package kr.co.neodreams.multi_user.service;

import java.io.File;
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

import com.ibm.icu.impl.Trie.DataManipulate;
import com.j256.simplemagic.ContentInfo;
import com.j256.simplemagic.ContentInfoUtil;

import kr.co.neodreams.multi_user.base.service.BaseService;
import kr.co.neodreams.multi_user.common.AspConnectionUploader;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.DataMap;
import kr.co.neodreams.multi_user.common.DateUtil;
import kr.co.neodreams.multi_user.common.HashidsGenerator;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.common.ZipCompress;
import kr.co.neodreams.multi_user.dao.KubeDao;
import kr.co.neodreams.multi_user.dto.KubeDto;

@Service
public class KubeUserServiceImpl extends BaseService implements KubeUserService{

	@Autowired
	KubeDao kubeDao;
	
	@Autowired
	DataSourceTransactionManager dataSourceTransactionManager;
	
	private HashidsGenerator hashids = new HashidsGenerator(Constants.KUBE_SEQ_SALT, 15);
	
	@Override
    public List<HashMap<String, String>> getLeftMenu(String empno) throws Exception {
    	return kubeDao.getLeftMenu(empno);
    }
	
	@Override
    public List<HashMap<String, String>> getCodeList(String inQuery) throws Exception {
    	return kubeDao.getCodeList(inQuery);
    }
	
	@Override
	synchronized public HashMap<String, String> uploadVideoFile(KubeDto kubeDto, HttpServletRequest request, MultipartHttpServletRequest mRequest) throws Exception {

		String SESS_EMPNO = ""; 
		HashMap<String, String> retMap = new HashMap<>();
		String tmpFileSavePath = "";
		String response = "";
		
		try{
			//영상 업로드 파일
			MultipartFile mFile = mRequest.getFile("uploadFile");
			
			if(mFile != null
					&& StringUtil.isNotEmpty(mFile.getName())){
				
				SESS_EMPNO = (String) request.getSession().getAttribute("SESS_EMPNO");
				
				String originalFileName = mFile.getOriginalFilename();
				String fileExtension    = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
				String tmpFileName = DateUtil.getCurrentDateTimeMilli() + "_" + SESS_EMPNO;
				
				String url = Constants.KUBE_UPLOAD_ASP_CALL;
				String video_duration = StringUtil.isNull(request.getParameter("video_duration"), "0");
				
                AspConnectionUploader uploader = new AspConnectionUploader();
                
                File dir = new File(Constants.KUBE_UPLOAD_VIDEO_TMP_PATH);
    			
    			if(!dir.exists()){
    				dir.mkdirs();
    			}
    			
                tmpFileSavePath = Constants.KUBE_UPLOAD_VIDEO_TMP_PATH + File.separator + mFile.getOriginalFilename();
                
                File convFile = null;
                //System.out.println(DateUtil.getCurrentDateTime());
                try{
            		convFile = new File(tmpFileSavePath );
            		
            		if(!convFile.exists() ){
            			mFile.transferTo(convFile);
            		}
            		//System.out.println(DateUtil.getCurrentDateTime());
            	}catch(Exception e){
            		e.printStackTrace();
            	}
                
                response = uploader.uploadVideo(url, convFile, tmpFileName, fileExtension, video_duration);

                if(response.indexOf("FAIL") < 0){
                	retMap.put("cid", response);
                	retMap.put("tmpFileName", tmpFileName);
                	retMap.put("result", "SUCCESS");
                }else{
                	retMap.put("result", "FAIL");
                }
			}
        }catch(Exception e){
        	e.printStackTrace();
        }
		
        return retMap;
	}
	
	@SuppressWarnings("unchecked")
	@Override
    public String insertVideoUpload(MultipartHttpServletRequest request) throws Exception {
		//파일 업로드는 첨부시 20번 서버에 video_tmp 폴더에 asp로 업로드
		//지미디어 영상 컨버팅 솔루션으로 일정 시간 지나면 video 폴더로 컨버팅 및 저장 됨
		//DB에는 video 폴더로 저장. 컨버팅 상태값으로 완료 된 영상만 상세 화면에서 재생 로직 태움
		KubeDto kubeDto = new KubeDto();
    	String retVal = "false"; 
    	
    	String datetime = DateUtil.getCurrentDateTime();

    	String video_file_path = Constants.KUBE_UPLOAD_VIDEO_PHY_PATH + File.separator + datetime.substring(0, 4) + File.separator + datetime.substring(4, 8) + File.separator;
    	
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);

		try{
			String SESS_EMPNO = (String) request.getSession().getAttribute("SESS_EMPNO");
			String SESS_USER_NAME = (String) request.getSession().getAttribute("SESS_USER_NAME");
			
			String SESS_DEPT_CODE = ((HashMap<String, String>) request.getSession().getAttribute("SESS_USER_INFO")).get("deptno");
			
			File dir = new File(video_file_path);
			
			if(!dir.exists()){
				dir.mkdirs();
			}
		
			String oriFileName = request.getParameter("oriFileName");
			
			if(StringUtil.isNotEmpty(oriFileName)){
				
				String fileName = oriFileName;  
				 
				ArrayList<KubeDto> thumbDtos = new ArrayList<KubeDto>();
				
				DataMap dataMap = new DataMap(request, "non_encoding");
				
				//실제 저장되는(컨버팅 완료) 파일 정보로 입력
				kubeDto.setTitle(dataMap.getNVLString("title"));
				kubeDto.setContents_desc(dataMap.getNVLString("contents_desc"));
				kubeDto.setOpen_flag(dataMap.getNVLInteger("open_flag"));
				kubeDto.setDownload_flag(dataMap.getNVLInteger("download_flag"));
				kubeDto.setCode_seq1(dataMap.getNVLInteger("code_seq1"));
				kubeDto.setCode_seq2(dataMap.getNVLInteger("code_seq2"));
				kubeDto.setWriter(SESS_USER_NAME);
				kubeDto.setDept_code(SESS_DEPT_CODE);
				kubeDto.setPds_ori_name(fileName.substring(0, fileName.lastIndexOf(".")));
				kubeDto.setPds_saved_name(dataMap.getNVLString("tmpFileName2"));
				//kubeDto.setPds_ext(fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length()));
				kubeDto.setPds_ext("mp4");
				kubeDto.setPds_size(Long.parseLong(StringUtil.isNull(request.getParameter("tmpFileSize"), "0")));
				kubeDto.setPds_phy_path(video_file_path + kubeDto.getPds_saved_name() + ".mp4");
				kubeDto.setPds_log_path(video_file_path.replace(Constants.STORAGE_SERVER_FILE_ROOT_PATH, "").replace(File.separator, "/") + kubeDto.getPds_saved_name() + ".mp4");
				kubeDto.setReg_date(datetime);
				kubeDto.setReg_empno(SESS_EMPNO);
				
				kubeDto.setSel_f_dept_code(((HashMap<String, String>) request.getSession().getAttribute("SESS_USER_INFO")).get("first_dept_code"));
				kubeDto.setSel_s_dept_code(((HashMap<String, String>) request.getSession().getAttribute("SESS_USER_INFO")).get("second_dept_code"));
				
				int vi_seq = kubeDao.insertVideoUpload(kubeDto);
				String selThumbImgIdx = request.getParameter("selThumbImgIdx");
				
				String[] thumb_url = dataMap.getParameterValues("thumb_url");
				
				if(thumb_url != null
						&& thumb_url.length > 0){
					
					int forCnt = thumb_url.length;
					for(int i = 0; i < forCnt; i++){
						KubeDto dto = new KubeDto();
						
						dto.setVi_seq(vi_seq);
						dto.setVit_seq(i + 1);
						if(selThumbImgIdx.equals(i + "")){
							dto.setMain_flag(1);
						}else{
							dto.setMain_flag(0);
						}
						dto.setThumb_phy_path(Constants.FILE_ROOT_PATH +  thumb_url[i]);
						dto.setThumb_log_path(thumb_url[i]);   
						
						thumbDtos.add(dto);
					}
				}
				 
				if(thumbDtos != null
						&& thumbDtos.size() > 0){
					kubeDao.insertVideoThumb(thumbDtos);
				}
				
				HashMap<String, String> tvmInfo = new HashMap<>();
				tvmInfo.put("vi_seq", String.valueOf(vi_seq));
				tvmInfo.put("cid", request.getParameter("cid"));
				kubeDao.updateKubeTVMContents(tvmInfo);
				
				//태그 정보 입력
				ArrayList<HashMap<String, String>> tagsDtos = new ArrayList<HashMap<String, String>>();
				
				String[] tagsInfo = dataMap.getParameterValues("tagsInfo");
				
				if(tagsInfo != null
						&& tagsInfo.length > 0){
					
					int forCnt = tagsInfo.length;
					for(int i = 0; i < forCnt; i++){
						HashMap<String, String> tagMap = new HashMap<>();
						
						tagMap.put("vi_seq", String.valueOf(vi_seq));
						tagMap.put("kvt_seq", String.valueOf(i + 1));
						tagMap.put("tag_desc", tagsInfo[i]);
						
						tagsDtos.add(tagMap);
					}
				}
				
				if(tagsDtos != null
						&& tagsDtos.size() > 0){
					kubeDao.insertTagInfo(tagsDtos);
				}
				
				String video_subtitle_path = Constants.FILE_ROOT_PATH + File.separator+ "kubeFnc" + File.separator + dataMap.getNVLString("tmpFileName2");
				dir = new File(video_subtitle_path);
				
				if(!dir.exists()){
					dir.mkdirs();
				}
				
				MultipartFile mf = request.getFile("vtt_File");
				
				if(!mf.isEmpty()) {
					File setFile = new File(video_subtitle_path + File.separator + dataMap.getNVLString("tmpFileName2") + ".zip");
					
					ContentInfoUtil fileUtil = new ContentInfoUtil();
					ContentInfo info = fileUtil.findMatch(mf.getBytes());
					
					String contentType = info.getMimeType();
					if("application/zip".equals(contentType) && "zip".contentEquals(info.getName())) {
						mf.transferTo(setFile);
					}
					
					try {
						if(setFile.exists())
							ZipCompress.decompress(setFile.toString(), video_subtitle_path);
					} catch (Throwable e) {
						e.printStackTrace();
					}
				}
				
				
				dataSourceTransactionManager.commit(status);
					
				retVal = "true";
			}
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
    		
    		dataSourceTransactionManager.rollback(status);
		}
		
    	return retVal;
    }
	
	@Override
	public String updateVideoInfo(MultipartHttpServletRequest request) throws Exception {
		KubeDto kubeDto = new KubeDto();
		String retVal = "false"; 
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			DataMap dataMap = new DataMap(request, "non_encoding");
			
			kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(dataMap.getNVLString("vi_seq_hash"))[0])));
			kubeDto.setTitle(dataMap.getNVLString("title"));
			kubeDto.setContents_desc(dataMap.getNVLString("contents_desc"));
			kubeDto.setOpen_flag(dataMap.getNVLInteger("open_flag"));
			kubeDto.setDownload_flag(dataMap.getNVLInteger("download_flag"));
			kubeDto.setCode_seq1(dataMap.getNVLInteger("code_seq1"));
			kubeDto.setCode_seq2(dataMap.getNVLInteger("code_seq2"));
			kubeDto.setMod_date(DateUtil.getCurrentDateTime());
			
			kubeDao.updateVideoInfo(kubeDto);
				
			//태그 정보 입력
			ArrayList<HashMap<String, String>> tagsDtos = new ArrayList<HashMap<String, String>>();
			
			String[] tagsInfo = dataMap.getParameterValues("tagsInfo");
			
			if(tagsInfo != null
					&& tagsInfo.length > 0){
				
				int forCnt = tagsInfo.length;
				for(int i = 0; i < forCnt; i++){
					HashMap<String, String> tagMap = new HashMap<>();
					
					tagMap.put("vi_seq", String.valueOf(kubeDto.getVi_seq()));
					tagMap.put("kvt_seq", String.valueOf(i + 1));
					tagMap.put("tag_desc", tagsInfo[i]);
					
					tagsDtos.add(tagMap);
				}
			}
			
			if(tagsDtos != null
					&& tagsDtos.size() > 0){
				kubeDao.insertTagInfo(tagsDtos);
			}
			
			String video_subtitle_path = Constants.FILE_ROOT_PATH + File.separator+ "kubeFnc" + File.separator + dataMap.getNVLString("tmpFileName2");
			File dir = new File(video_subtitle_path);
			
			if(!dir.exists()){
				dir.mkdirs();
			}
			
			MultipartFile mf = request.getFile("vtt_File");
			
			if(!mf.isEmpty()) {
				File setFile = new File(video_subtitle_path + File.separator + dataMap.getNVLString("tmpFileName2") + ".zip");

				ContentInfoUtil fileUtil = new ContentInfoUtil();
				ContentInfo info = fileUtil.findMatch(mf.getBytes());
				
				String contentType = info.getMimeType();
				
				if("application/zip".equals(contentType) && "zip".contentEquals(info.getName())) {
					mf.transferTo(setFile);
				}
				
				try {
					if(setFile.exists())
						ZipCompress.decompress(setFile.toString(), video_subtitle_path);
				} catch (Throwable e) {
					e.printStackTrace();
				}
			}
			
			dataSourceTransactionManager.commit(status);
				
			retVal = "true";
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error( "failed!", e );
			
			dataSourceTransactionManager.rollback(status);
		}
		
		return retVal;
	}
	
	@Override
    public HashMap<String, String> getCategoryInfo(KubeDto kubeDto) throws Exception {
    	return kubeDao.getCategoryInfo(kubeDto);
    }
	
	@Override
	public List<HashMap<String, String>> getDeptInfo(KubeDto kubeDto) throws Exception {
		return kubeDao.getDeptInfo(kubeDto);
	}
	
	@Override
    public List<HashMap<String, String>> getCategoryVideoList(KubeDto kubeDto) throws Exception {
    	return kubeDao.getCategoryVideoList(kubeDto);
    }
	
	@Override
	public int getCategoryVideoListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getCategoryVideoListCnt(kubeDto);
	}
	
	@Override
	public HashMap<String, String> getVideoDetailInfo(KubeDto kubeDto) throws Exception {
		return kubeDao.getVideoDetailInfo(kubeDto);
	}
	
	@Override
	public HashMap<String, String> getLastVisitDate(KubeDto kubeDto) throws Exception {
		return kubeDao.getLastVisitDate(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getVideoTagList(KubeDto kubeDto) throws Exception {
		return kubeDao.getVideoTagList(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getVideoRecommendList(KubeDto kubeDto) throws Exception {
		return kubeDao.getVideoRecommendList(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getMyBookMarkChkList(KubeDto kubeDto) throws Exception {
		return kubeDao.getMyBookMarkChkList(kubeDto);
	}
	
	@Override
    public String insertApproveReqVideo(KubeDto kubeDto, HttpServletRequest request) throws Exception {
    	
    	String retVal = "false"; 
    	
		try{
			kubeDto.setApp_empno((String) request.getSession().getAttribute("SESS_EMPNO"));
			kubeDto.setReg_date(DateUtil.getCurrentDateTime());
			
			kubeDao.insertApproveReqVideo(kubeDto);
			
			retVal = "true";
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		}
		
    	return retVal;
    }
	
	@Override
	public String userActCtrl(KubeDto kubeDto, HttpServletRequest request) throws Exception {
		
		String retVal = "false"; 
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			if(StringUtil.isNotEmpty(kubeDto.getVh_gubun())){
				int vh_gubun = Integer.parseInt(kubeDto.getVh_gubun());
				
				kubeDto.setReg_date(DateUtil.getCurrentDateTime());
				kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
				
				if(vh_gubun < 10){
					kubeDao.insertVideoHistory(kubeDto);
					kubeDao.updateVideoSubInfo(kubeDto);
					if(vh_gubun == 2 || vh_gubun == 4 || vh_gubun == 6){
						kubeDao.insertMyActMgmt(kubeDto);
					}else if(vh_gubun == 3 || vh_gubun == 5 || vh_gubun == 7){
						kubeDao.deleteMyActMgmt(kubeDto);
					}
				}else if(vh_gubun > 10){
					kubeDao.insertVideoHistory(kubeDto);
					kubeDao.updateKube_video_commentCnt(kubeDto);
					
					if(vh_gubun == 11 || vh_gubun == 13){
						kubeDao.insertMyActMgmt(kubeDto);
					}else if(vh_gubun == 12 || vh_gubun == 14){
						kubeDao.deleteMyActMgmt(kubeDto);
					}
				}
			
				dataSourceTransactionManager.commit(status);
				
				retVal = "true";
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error( "failed!", e );
			
			dataSourceTransactionManager.rollback(status);
		}
		
		return retVal;
	}
	
	@Override
	public String deleteMyBookMarkVideo(KubeDto kubeDto, HttpServletRequest request) throws Exception {
		
		String retVal = "false"; 
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			String[] videoChk = request.getParameterValues("videoChk");
			
			if(videoChk != null
					&& videoChk.length > 0){
				
				int forCnt = videoChk.length;
				String datetime = DateUtil.getCurrentDateTime();
				
				kubeDto.setVh_gubun("7");
				kubeDto.setVc_seq(0);
				kubeDto.setReg_date(datetime);
				kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
				
				for(int i = 0; i < forCnt; i++){
					if(!"all".equals(videoChk[i])){
						kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(videoChk[i])[0])));
						
						kubeDao.insertVideoHistory(kubeDto);
						kubeDao.updateVideoSubInfo(kubeDto);
						kubeDao.deleteMyActMgmt(kubeDto);
					}
				}
				
				retVal = "true";
				
				dataSourceTransactionManager.commit(status);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error( "failed!", e );
			
			dataSourceTransactionManager.rollback(status);
		}
		
		return retVal;
	}
	
	
	@Override
	public int insertUserComment(KubeDto kubeDto) throws Exception {
		
		int retVal = 99999999; 
		
		try{
			retVal = kubeDao.insertUserComment(kubeDto);
		} catch (Exception e) {
			e.printStackTrace();
			log.error( "failed!", e );
		}
		
		return retVal;
	}
	
	@Override
	public void deleteUserComment(KubeDto kubeDto) throws Exception {
		kubeDao.deleteUserComment(kubeDto);
	}
	
	@Override
    public List<HashMap<String, String>> getCommentList(KubeDto kubeDto) throws Exception {
    	return kubeDao.getCommentList(kubeDto);
    }
	
	@Override
	public List<HashMap<String, String>> getNewComment(KubeDto kubeDto) throws Exception {
		return kubeDao.getNewComment(kubeDto);
	}
	
	@Override
	public void insertReportReqV_C(KubeDto kubeDto) throws Exception {
		kubeDao.insertReportReqV_C(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getHomeList(KubeDto kubeDto) throws Exception {
		return kubeDao.getHomeList(kubeDto);
	}
	
	@Override
    public List<HashMap<String, String>> getTotalSrhList(KubeDto kubeDto) throws Exception {
    	return kubeDao.getTotalSrhList(kubeDto);
    }
	
	@Override
	public HashMap<String, String> getTotalSrhListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getTotalSrhListCnt(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getSrhCategoryCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getSrhCategoryCnt(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getWeeklyList(KubeDto kubeDto) throws Exception {
		return kubeDao.getWeeklyList(kubeDto);
	}
	
	@Override
	public int getWeeklyListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getWeeklyListCnt(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getRecommendedList(KubeDto kubeDto) throws Exception {
		return kubeDao.getRecommendedList(kubeDto);
	}
	
	@Override
	public int getRecommendedListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getRecommendedListCnt(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getRecentlyList(KubeDto kubeDto) throws Exception {
		return kubeDao.getRecentlyList(kubeDto);
	}
	
	@Override
	public int getRecentlyListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getRecentlyListCnt(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getTopList(KubeDto kubeDto) throws Exception {
		return kubeDao.getTopList(kubeDto);
	}
	
	@Override
	public int getTopListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getTopListCnt(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getMyBookMarkList(KubeDto kubeDto) throws Exception {
		return kubeDao.getMyBookMarkList(kubeDto);
	}
	
	@Override
	public int getMyBookMarkListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getMyBookMarkListCnt(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getMyDownLoadReqList(KubeDto kubeDto) throws Exception {
		return kubeDao.getMyDownLoadReqList(kubeDto);
	}
	
	@Override
	public int getMyDownLoadReqListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getMyDownLoadReqListCnt(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getMyVideoMgmtList(KubeDto kubeDto) throws Exception {
		return kubeDao.getMyVideoMgmtList(kubeDto);
	}
	
	@Override
	public int getMyVideoMgmtListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getMyVideoMgmtListCnt(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getMyApproveMgmtList(KubeDto kubeDto) throws Exception {
		return kubeDao.getMyApproveMgmtList(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getMyVideoApproveSubList(KubeDto kubeDto) throws Exception {
		return kubeDao.getMyVideoApproveSubList(kubeDto);
	}
	
	@Override
	public int getMyApproveMgmtListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getMyApproveMgmtListCnt(kubeDto);
	}
	
	@Override
	public String updateMyVideoFlag(KubeDto kubeDto, HttpServletRequest request) throws Exception {
		
		String retVal = "false"; 
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			String[] videoChk = request.getParameterValues("videoChk");
			String taskVal = request.getParameter("taskVal");
			
			if(videoChk != null
					&& videoChk.length > 0
					&& StringUtil.isNotEmpty(taskVal)){
				
				int forCnt = videoChk.length;
				String datetime = DateUtil.getCurrentDateTime();
				
				kubeDto.setMod_date(datetime);
				
				for(int i = 0; i < forCnt; i++){
					if(!"all".equals(videoChk[i])){
						
						kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(videoChk[i])[0])));
						
						if("39".equals(taskVal)
								|| "40".equals(taskVal)){
							kubeDto.setOpen_flag(Integer.parseInt(taskVal));
							
						}else if("41".equals(taskVal)
								|| "42".equals(taskVal)
								|| "43".equals(taskVal)){
							kubeDto.setDownload_flag(Integer.parseInt(taskVal));
							kubeDto.setVa_status(46);
							kubeDao.updateApproveStatus(kubeDto);
						}else if("9".equals(taskVal)){
							kubeDto.setVi_status(9);
						}
						
						kubeDao.updateVideoStatus(kubeDto);
					}
				}
				
				retVal = "true";
				
				dataSourceTransactionManager.commit(status);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error( "failed!", e );
			
			dataSourceTransactionManager.rollback(status);
		}
		
		return retVal;
	}
	
	@Override
	public int getTargetPageNum(KubeDto kubeDto) throws Exception {
		return kubeDao.getTargetPageNum(kubeDto);
	}
	
	@Override
	public String updateMyVideoApproveFlag(KubeDto kubeDto, HttpServletRequest request) throws Exception {
		
		String retVal = "false"; 
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			String[] videoChk = request.getParameterValues("videoChk");
			String taskVal = request.getParameter("taskVal");
			
			if(videoChk != null
					&& videoChk.length > 0
					&& StringUtil.isNotEmpty(taskVal)){
				
				int forCnt = videoChk.length;
				String datetime = DateUtil.getCurrentDateTime();
				
				kubeDto.setMod_date(datetime);
				kubeDto.setVa_status(Integer.parseInt(taskVal));
				
				for(int i = 0; i < forCnt; i++){
					if(!"all".equals(videoChk[i])){
						kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(videoChk[i])[0])));
						kubeDao.updateApproveStatus(kubeDto);
					}
				}
				
				retVal = "true";
				
				dataSourceTransactionManager.commit(status);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error( "failed!", e );
			
			dataSourceTransactionManager.rollback(status);
		}
		
		return retVal;
	}
	
	@Override
	public List<HashMap<String, String>> getMyCommentMgmtList(KubeDto kubeDto) throws Exception {
		return kubeDao.getMyCommentMgmtList(kubeDto);
	}
	
	@Override
	public int getMyCommentMgmtListCnt(KubeDto kubeDto) throws Exception {
		return kubeDao.getMyCommentMgmtListCnt(kubeDto);
	}
	
	@Override
	public List<HashMap<String, String>> getCustomtMenu(String empno) throws Exception {
		return kubeDao.getCustomtMenu(empno);
	}
	
	@Override
    public String insertMyCustomMenu(HttpServletRequest request) throws Exception {
		//kube_user_menu 테이블의 현재 세션 아이디 정보 삭제
		//kube_mgmt_code 의 메뉴 정보를 셀렉트 인서트
		//checkbox 데이터를 제외한 나머지는 use_flag = 0 update
    	String retVal = "false"; 
    	
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);

		try{
			String SESS_EMPNO = (String) request.getSession().getAttribute("SESS_EMPNO");

			kubeDao.deleteUserMenuInfo(SESS_EMPNO);
			
			kubeDao.insertUserMenuInfo(SESS_EMPNO);
			
			HashMap<String, String> userMenuMap = new HashMap<>();
			userMenuMap.put("empno", SESS_EMPNO);
			userMenuMap.put("code_seq", Arrays.toString(request.getParameterValues("chkMenu")).replace("[", "").replace("]", ""));
			
			kubeDao.updateUserMenuInfo(userMenuMap);
				
			dataSourceTransactionManager.commit(status);
					
			retVal = "true";
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
    		
    		dataSourceTransactionManager.rollback(status);
		}
		
    	return retVal;
    }
	
	@Override
	public String insertUpdateElearnVideoUserMap(HashMap<String, String> videoUserInfo) throws Exception {
		String retVal = "false";
		
		try{
			kubeDao.insertUpdateElearnVideoUserMap(videoUserInfo);
			retVal = "true";
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return retVal;
	}

	@Override
	public HashMap<String, String> getElearnVideoUserInfo(KubeDto kubeDto) throws Exception {
		return kubeDao.getElearnVideoUserInfo(kubeDto);
	}
	
	@Override
	public String getElearnVideoViSeq(String pds_saved_name) throws Exception {
		return kubeDao.getElearnVideoViSeq(pds_saved_name);
	}
	
}
