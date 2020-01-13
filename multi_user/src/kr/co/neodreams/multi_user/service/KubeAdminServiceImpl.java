package kr.co.neodreams.multi_user.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.neodreams.multi_user.base.service.BaseService;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.DataMap;
import kr.co.neodreams.multi_user.common.DateUtil;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.dao.KubeDao;
import kr.co.neodreams.multi_user.dto.KubeDto;

@Service
public class KubeAdminServiceImpl extends BaseService implements KubeAdminService{

	@Autowired
	KubeDao kubeDao;
	
	@Autowired
	DataSourceTransactionManager dataSourceTransactionManager;
	
	@Override
    public List<HashMap<String, String>> getLeftMenu(String empno) throws Exception {
    	return kubeDao.getLeftMenu(empno);
    }

	@Override
	public List<HashMap<String, String>> getMainLayerInfo() throws Exception {
		return kubeDao.getMainLayerInfo();
	}
	
	@Override
    public String insertUpdateMainMgmt(KubeDto kubeDto, HttpServletRequest request, MultipartHttpServletRequest mRequest) throws Exception {
    	
    	String retVal = "false"; 
    	
    	String datetime = DateUtil.getCurrentDateTime();

		String file_path = Constants.KUBE_UPLOAD_IMG_PHY_PATH + File.separator + datetime.substring(0, 4) + File.separator + datetime.substring(4, 8) + File.separator;

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);

		try{
			String SESS_EMPNO = (String) request.getSession().getAttribute("SESS_EMPNO");
			
			File dir = new File(file_path);
			
			if(!dir.exists()){
				dir.mkdirs();
			}
			
			DataMap dataMap = new DataMap(request,"non_encoding");
			
			//이미지 업로드 파일
			List<MultipartFile> mFiles = mRequest.getFiles("files");
			String[] mainSeq = dataMap.getParameterValues("mainSeq");
			String tmpSeq = "";	
			if(mainSeq != null
					&& mainSeq.length > 0){
				tmpSeq = Arrays.toString(mainSeq);
			}
			
			ArrayList<KubeDto> insertMainLayerDtos = new ArrayList<KubeDto>();
			ArrayList<KubeDto> updateMainLayerDtos = new ArrayList<KubeDto>();
			String fileName = "";
			
			for(int i = 0; i < 3; i++){
				KubeDto dto = new KubeDto();
				dto.setSeq(i + 1);
				dto.setUrl_info(dataMap.getParameterValues("url_info")[i]);
				dto.setCap_title(dataMap.getParameterValues("cap_title")[i]);
				if(i == 0){
					dto.setMin_title(dataMap.getNVLString("min_title"));
				}else{
					dto.setMin_title(null);
				}
				fileName = mFiles.get(i).getOriginalFilename();
				
				//파일 업로드가 있는 경우. 업데이트는 파일 재업로드를 하지 않기 때문에 빈 값이 올 수 있다
				if(StringUtil.isNotEmpty(fileName)){
					dto.setThumb_file_name(fileName);
					fileName = DateUtil.getCurrentDateTimeMilli() + "_" + (i + 1) + "." + fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
					dto.setThumb_log_path(file_path.replace(Constants.FILE_ROOT_PATH, "").replace(File.separator, "/") + fileName);
					dto.setThumb_phy_path(file_path + fileName);
				}else{
					dto.setThumb_file_name(null);
				}
				
				dto.setReg_date(datetime);
				dto.setReg_empno(SESS_EMPNO);
				dto.setThumbFiles(mFiles.get(i));
				
				//기존 인서트 건이 있는 경우
				if(tmpSeq.indexOf(String.valueOf(i + 1)) != -1){
					updateMainLayerDtos.add(dto);
				}else{
					insertMainLayerDtos.add(dto);
				}
				
			}
			if(updateMainLayerDtos != null
					&& updateMainLayerDtos.size() > 0){
				//mainSeq가 없는 건은 삭제해주고 아래에서 인서트 해준다
				kubeDao.deleteMainMgmt(updateMainLayerDtos);
				
				HashMap<String, ArrayList<KubeDto>> map = new HashMap<String, ArrayList<KubeDto>>();
				map.put("List", updateMainLayerDtos);
				kubeDao.updateMainMgmt(map);
			}else{
				//seq가 없는 경우, 무조건 1,2,3 삭제
				ArrayList<KubeDto> forceUpdateMainLayerDtos = new ArrayList<KubeDto>();
				
				KubeDto forceDto = new KubeDto();
				forceDto.setSeq(4);
				forceUpdateMainLayerDtos.add(forceDto);
				
				kubeDao.deleteMainMgmt(forceUpdateMainLayerDtos);
			}
			
			if(insertMainLayerDtos != null
					&& insertMainLayerDtos.size() > 0){
				kubeDao.insertMainMgmt(insertMainLayerDtos);
			}
			
			dataSourceTransactionManager.commit(status);
				
			//DB 인서트 후 파일 전송 처리
			//insert용
			for(int i = 0; i < insertMainLayerDtos.size(); i++){
				
				MultipartFile mFile = insertMainLayerDtos.get(i).getThumbFiles();
				
				try {
					mFile.transferTo(new File(insertMainLayerDtos.get(i).getThumb_phy_path()));
				} catch (IllegalStateException e) {
					e.printStackTrace();
					log.error( "failed!", e );
				} catch (IOException e) {
					e.printStackTrace();
					log.error( "failed!", e );
				} catch (Exception e) {
					e.printStackTrace();
					log.error( "failed!", e );
				}
			}
			
			//update용
			for(int i = 0; i < updateMainLayerDtos.size(); i++){
				
				MultipartFile mFile = updateMainLayerDtos.get(i).getThumbFiles();
				
				try {
					if(StringUtil.isNotEmpty(mFile.getOriginalFilename())){
						mFile.transferTo(new File(updateMainLayerDtos.get(i).getThumb_phy_path()));
					}
				} catch (IllegalStateException e) {
					e.printStackTrace();
					log.error( "failed!", e );
				} catch (IOException e) {
					e.printStackTrace();
					log.error( "failed!", e );
				} catch (Exception e) {
					e.printStackTrace();
					log.error( "failed!", e );
				}
			}
			
			retVal = "true";
			
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
    		
    		dataSourceTransactionManager.rollback(status);
		}
		
    	return retVal;
    }
	
	@Override
    public void insertCode(KubeDto kubeDto) throws Exception {
    	kubeDao.insertCode(kubeDto);
    }
	
	@Override
    public void updateCode(KubeDto kubeDto) throws Exception {
		kubeDao.updateCode(kubeDto);
    }
	
	@Override
    public void deleteCode(KubeDto kubeDto) throws Exception {
		kubeDao.deleteCode(kubeDto);
    }
	
	@Override
    public List<HashMap<String, String>> getCodeList(String inQuery) throws Exception {
    	return kubeDao.getCodeList(inQuery);
    }
	
	@Override
	public List<HashMap<String, String>> getCategoryCode(KubeDto kubeDto) throws Exception {
		return kubeDao.getCategoryCode(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getReportList(KubeDto kubeDto) throws Exception {
		return kubeDao.getReportList(kubeDto);
	}
	
	@Override
	public int getReportListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getReportListCnt(kubeDto);
	}
	
	@Override
	public String updateReport(KubeDto kubeDto, HttpServletRequest request) throws Exception {
		
		String retVal = "false"; 
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			kubeDto.setMod_date(DateUtil.getCurrentDateTime());

			kubeDao.updateReport(kubeDto);
			
			retVal = "true";
			
			dataSourceTransactionManager.commit(status);
		} catch (Exception e) {
			e.printStackTrace();
			log.error( "failed!", e );
			
			dataSourceTransactionManager.rollback(status);
		}
		
		return retVal;
	}
	
	@Override
	public List<HashMap<String, String>> getVideoList(KubeDto kubeDto) throws Exception {
		return kubeDao.getVideoList(kubeDto);
	}
	
	@Override
	public int getVideoListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getVideoListCnt(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getVideoListXls(KubeDto kubeDto) throws Exception {
		return kubeDao.getVideoListXls(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getUserStatisticsList(KubeDto kubeDto) throws Exception {
		return kubeDao.getUserStatisticsList(kubeDto);
	}
	
	@Override
	public int getUserStatisticsListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getUserStatisticsListCnt(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getSaList(KubeDto kubeDto) throws Exception {
		return kubeDao.getSaList(kubeDto);
	}
	
	@Override
	public String insertDeleteKubeSa(KubeDto kubeDto, HttpServletRequest request) throws Exception {
		
		String retVal = "false"; 
		
		try{
			
			if("D".equals(kubeDto.getAct_gubun())){
				kubeDao.deleteKubeSa(kubeDto);
			}else if("C".equals(kubeDto.getAct_gubun())){
				
				kubeDto.setReg_empno((String) request.getSession().getAttribute("SESS_EMPNO"));
				kubeDto.setReg_date(DateUtil.getCurrentDateTime());
				
				kubeDao.insertKubeSa(kubeDto);	
			}

			retVal = "true";
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error( "failed!", e );
		}
		
		return retVal;
	}
	
	@Override
	public List<HashMap<String, String>> getUserList(KubeDto kubeDto) throws Exception {
		return kubeDao.getUserList(kubeDto);
	}
	
	@Override
	public int getUserListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getUserListCnt(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getElearnStatList(KubeDto kubeDto) throws Exception {
		return kubeDao.getElearnStatList(kubeDto);
	}
	
	@Override
	public int getElearnStatListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getElearnStatListCnt(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getElearnStatListXls(KubeDto kubeDto) throws Exception {
		return kubeDao.getElearnStatListXls(kubeDto);
	}
}
