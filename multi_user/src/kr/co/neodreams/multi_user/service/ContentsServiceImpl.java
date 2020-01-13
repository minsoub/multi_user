package kr.co.neodreams.multi_user.service;

import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import kr.co.neodreams.multi_user.base.service.BaseService;
import kr.co.neodreams.multi_user.common.CommonUtil;
import kr.co.neodreams.multi_user.dao.ContentsDao;
import kr.co.neodreams.multi_user.dto.ContentsDto;
import kr.co.neodreams.multi_user.dto.ImgBoardDto;
import kr.co.neodreams.multi_user.dto.Tbsetcd1Dto;
import kr.co.neodreams.multi_user.dto.Tbsetcd2Dto;
import kr.co.neodreams.multi_user.dto.Tbsvc_tdmsempDto;

@Service
public class ContentsServiceImpl extends BaseService implements ContentsService{
	
	@Autowired
	DataSourceTransactionManager dataSourceTransactionManager;
	
	@Autowired
	ContentsDao contentsDao;
	
	
	/**
	 * @Title : 서비스 신청 구분
	 * @descrption : 서비스 신청 구분
	 */
	public List<Tbsetcd2Dto> contents_categorey_Select(Tbsetcd2Dto tbsetcd2Dto) throws Exception {
		List<Tbsetcd2Dto> categorey = null;
		categorey = contentsDao.contents_categorey_Select(tbsetcd2Dto);
		return categorey;
	}
	public boolean contens_Insert(ContentsDto contentsDto, JSONObject jsonObject) throws Exception{
		
		CommonUtil commonUtil = new CommonUtil();
		Date from = new Date();
		SimpleDateFormat transFormat_no 	= new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat transFormat_date 	= new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat transFormat_date2 	= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		
		/*서비스 신청번호 생성*/
		String setSM_NO = "";
		List<ContentsDto> maxNumSelect = null;
		maxNumSelect = contentsDao.contents_Select(contentsDto);
		String max_num = maxNumSelect.get(0).getN_SM_NO();
		if (max_num == null) {
			setSM_NO = transFormat_no.format(from) + "1001";
		} else {
			int maxSumNum = Integer.parseInt(max_num) + 1;
			setSM_NO = transFormat_no.format(from) + String.valueOf(maxSumNum);
		}
				
		/*파일 등록*/	
		if(!jsonObject.isEmpty()){ 
			String jsondepth = jsonObject.get("isSuccess").toString();
			JSONObject jsondepth2 = null;
			JSONArray jsonArr = (JSONArray)jsonObject.get("datas");
			
			String savename = "";
			for(int i=0;i<jsonArr.size();i++){
				jsondepth2 = (JSONObject)jsonArr.get(i);
				savename = jsondepth2.get("saveFileName").toString();
				//System.out.println(i+"번째 : " + jsondepth2.get("originalFileName"));
				if(i == 0){
					contentsDto.setSCT_FNAME1(savename);
				}else if(i == 1){
					contentsDto.setSCT_FNAME2(savename);
				}else if(i == 2){
					contentsDto.setSCT_FNAME3(savename);
				}
			}
		}
		
		/*회사명 조회*/
		List<ContentsDto> codeValue = contentsDao.contents_tbSetcd1_Select(contentsDto);
		String code = codeValue.get(0).getCD1_NAME();	
		
		String SM_SVC1 		= "1003";		//서비스구분[콘텐츠제작요청/1003]
		// 관리항목
		String SM_LSTATE 	= "3093";		//사용자 서비스상태[신청||접수||정상완료||미처리종료||미승인종료||사용자취소]
		String SM_FSTATE 	= "";			//서비스 종료상태[납품완료||사용자취소]
		String SM_ISSIGN 	= "3112";		//승인상태[승인대기중||승인완료||반려]
		
		contentsDto.setSM_NO(setSM_NO);
		contentsDto.setSM_DATE(transFormat_date.format(from));
		contentsDto.setSM_SVC1(SM_SVC1);
		contentsDto.setSM_MCNAME(code);
		contentsDto.setSM_FDATE(transFormat_date.format(from));
		contentsDto.setSM_LSTATE(SM_LSTATE);
		contentsDto.setSM_FSTATE(SM_FSTATE);
		contentsDto.setSM_ISSIGN(SM_ISSIGN);
		contentsDto.setSM_IPADDR(commonUtil.getIPAddr());
		contentsDto.setSM_WDATE(transFormat_date2.format(from));
		contentsDao.contents_Insert(contentsDto);
		
		String SCT_RDATE = contentsDto.getSCT_RDATE();
		SCT_RDATE = transFormat_no.format(transFormat_date.parse(SCT_RDATE))+"00";
		contentsDto.setSCT_RDATE(SCT_RDATE);
		contentsDto.setSCT_ORIGTEXT("");
		contentsDao.contents_File_Insert(contentsDto);
		
		if((!"".equals(contentsDto.getFileSeq_1()) && contentsDto.getFileSeq_1() != null)
			||(!"".equals(contentsDto.getFileSeq_2()) && contentsDto.getFileSeq_2() != null)
			||(!"".equals(contentsDto.getFileSeq_3()) && contentsDto.getFileSeq_3() != null)) {
			contentsDao.Contents_fileUpdate(contentsDto);
		}
		
		return true;
	}
	
	public Object contens_(ContentsDto contentsDto) throws Exception{
		contentsDto.setSM_SVC1("123");
		Date from = new Date();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		String to = transFormat.format(from);
		contentsDto.setSM_WDATE(to);
		return contentsDao.contents_Insert(contentsDto);
	}
	
	/** 컨텐츠 제작 신청내역 취득 */
	public Map<String, Object> getMypageContentsList(ContentsDto contentsDto) throws Exception{
	    Map<String, Object> resultMap = new HashMap<String, Object>();
		List<ContentsDto> resultList = (List<ContentsDto>) contentsDao.getMypageContentsList(contentsDto);
		int totalCnt = contentsDao.getMypageContentsListCount(contentsDto);
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		return resultMap;
	}

	@Override
	public boolean contens_Select(ContentsDto contentsDto) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}
	public List<ContentsDto> getContentsList (ContentsDto contentsDto) throws Exception{
		try {
			if(!"".equals(contentsDto.getS3()) && null != contentsDto.getS3()) {
				StringTokenizer attatchSeqs = new StringTokenizer(contentsDto.getS3(),",");
				ArrayList<String> lists3 = new ArrayList<>();
				
				int totCnt = attatchSeqs.countTokens();
				for(int i=0; i < totCnt; i++) {
					lists3.add(attatchSeqs.nextToken());
				}
				contentsDto.setLists3(lists3);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return contentsDao.getContentsList(contentsDto);
	}
	public int getContentsListCnt (ContentsDto contentsDto) throws Exception{
		return contentsDao.getContentsListCnt(contentsDto);
	}
	public List<ContentsDto> getContentsDetail (ContentsDto contentsDto) throws Exception{
		return contentsDao.getContentsDetail(contentsDto);
	}
	public List<ContentsDto> getContentsCount (ContentsDto contentsDto) throws Exception{
		return contentsDao.getContentsCount(contentsDto);
	}
	public boolean contents_Update(ContentsDto contentsDto, JSONObject jsonObject) throws Exception{
		SimpleDateFormat transFormat_no 	= new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat transFormat_date 	= new SimpleDateFormat("yyyy-MM-dd");
		/*파일 등록*/
		if(!jsonObject.isEmpty()){ 
			String jsondepth = jsonObject.get("isSuccess").toString();
			JSONObject jsondepth2 = null;
			JSONArray jsonArr = (JSONArray)jsonObject.get("datas");
			
			String savename = "";
			for(int i=0;i<jsonArr.size();i++){
				jsondepth2 = (JSONObject)jsonArr.get(i);
				savename = jsondepth2.get("saveFileName").toString();
				if(savename == "")savename=null;
				//System.out.println(i+"번째 : " + jsondepth2.get("originalFileName"));
				if(i == 0){
					contentsDto.setSCT_FNAME1(savename);
				}else if(i == 1){
					contentsDto.setSCT_FNAME2(savename);
				}else if(i == 2){
					contentsDto.setSCT_FNAME3(savename);
				}
			}
		}
		contentsDao.contents_Update(contentsDto);
		String SCT_RDATE = contentsDto.getSCT_RDATE();
		String SCT_TDATE = contentsDto.getSCT_TDATE();
		
		SCT_RDATE = transFormat_no.format(transFormat_date.parse(SCT_RDATE))+"00";
		if("".equals(SCT_TDATE) || SCT_TDATE != null) {
			SCT_TDATE = transFormat_no.format(transFormat_date.parse(SCT_TDATE))+"00";
		}
		contentsDto.setSCT_RDATE(SCT_RDATE);
		contentsDto.setSCT_TDATE(SCT_TDATE);
		contentsDao.contents_File_Update(contentsDto);
		
		contentsDto.setSCT_ORIGTEXT("");
		if((!"".equals(contentsDto.getFileSeq_1()) && contentsDto.getFileSeq_1() != null)
				||(!"".equals(contentsDto.getFileSeq_2()) && contentsDto.getFileSeq_2() != null)
				||(!"".equals(contentsDto.getFileSeq_3()) && contentsDto.getFileSeq_3() != null)) {
				contentsDao.Contents_fileUpdate(contentsDto);
		}
		return true; 
	}
	public boolean contents_Del(ContentsDto contentsDto) throws Exception{
		contentsDao.contents_Del(contentsDto);
		return true;
	}
	
	/* 이미지 자료실 */
	@Override
	public List<ImgBoardDto> getImgBrdList(ImgBoardDto imgBoardDto) throws Exception {
		return contentsDao.getImgBrdList(imgBoardDto);
	}
	
	@Override
	public int getImgBrdListCnt(ImgBoardDto imgBoardDto) throws Exception {
		return contentsDao.getImgBrdListCnt(imgBoardDto);
	}
	
	@Override
	public ImgBoardDto getImgBrd(ImgBoardDto imgBoardDto) throws Exception {
		return contentsDao.getImgBrd(imgBoardDto);
	}
	
	@Override
	public int imgBrdInsert(ImgBoardDto imgBoardDto) throws Exception {
		int retVal = (int) contentsDao.imgBrdInsert(imgBoardDto);
		if(retVal > 0) {
			imgBoardDto.setImg_Board_Seq(retVal);
			int attatchFileChk = imgBrdAttatchInsert(imgBoardDto);
			
			if(attatchFileChk < 0) {
				throw new Exception("-1"); 
			}
		}
		return retVal;
	}
	
	@Override
	public int imgBrdUpdate(ImgBoardDto imgBoardDto) throws Exception {
		int retVal = contentsDao.noticeUpdate(imgBoardDto);
		if(retVal > 0) {
			int attatchFileChk = imgBrdAttatchInsert(imgBoardDto);
			
			if(attatchFileChk < 0) {
				throw new Exception("-1"); 
			}
		}
		return retVal;
	}
	
	@Override
	public int imgBrdDelete(ImgBoardDto imgBoardDto) throws Exception {
		return contentsDao.imgBrdDelete(imgBoardDto);
	}
	
	@Override
	public List<ImgBoardDto> garbageAttatch(ImgBoardDto imgBoardDto) throws Exception {
		return contentsDao.garbageAttatch(imgBoardDto);
	}
	
	@Override
	public int imgBrdFileDelete(ImgBoardDto imgBoardDto) throws Exception {
		return contentsDao.imgBrdFileDelete(imgBoardDto);
	}
	
	public int imgBrdAttatchInsert(ImgBoardDto imgBoardDto) {
		int retVal = 0;
		try {
			if(!"".equals(imgBoardDto.getAttatch_Seqs().trim())) {
				StringTokenizer attatchSeqs = new StringTokenizer(imgBoardDto.getAttatch_Seqs(),"|");
				List<ImgBoardDto> listattatchDto = new ArrayList<>();
				
				int totCnt = attatchSeqs.countTokens();
				for(int i=0; i < totCnt; i++) {
					ImgBoardDto attatchDto = new ImgBoardDto();
					attatchDto.setImg_Board_Seq(imgBoardDto.getImg_Board_Seq());
					attatchDto.setAttatch_Seq(attatchSeqs.nextToken());
					listattatchDto.add(attatchDto);
				}
				
				if(listattatchDto.size() > 0) {
					contentsDao.imgBrdAttatchInsert(listattatchDto);
				}
			}
		}catch (Exception e) {
			retVal = -1;
		}
		return retVal;
	}
	
	@Override
	public ImgBoardDto getAttatch(ImgBoardDto imgBoardDto) throws Exception {
		return contentsDao.getAttatch(imgBoardDto);
	}
	@Override
	public List<Tbsetcd2Dto> svc2Cnt() throws Exception {
		return contentsDao.svc2Cnt();
	}
	
	@Override
	public List<ContentsDto> acceptList(ContentsDto contentsDto) throws Exception {
		return contentsDao.acceptList(contentsDto);
	}
	@Override
	public int acceptListCnt(ContentsDto contentsDto) throws Exception {
		return contentsDao.acceptListCnt(contentsDto);
	}
	@Override
	public Tbsvc_tdmsempDto userImp(String strEmpNo) throws Exception {
		return contentsDao.userImp(strEmpNo);
	}
	
	public int registAcceptAjax(ContentsDto contentsDto) throws Exception{
		return contentsDao.registAcceptAjax(contentsDto);
	}
	@Override
	public ContentsDto acceptUpdate(ContentsDto contentsDto) throws Exception {
		return contentsDao.acceptUpdate(contentsDto);
	}
	@Override
	public void statusUpdate(int AC_SEQ) throws Exception {
		contentsDao.statusUpdate(AC_SEQ);
	}
	@Override
	public int updateAcceptAjax(ContentsDto contentsDto) throws Exception {
		return contentsDao.updateAcceptAjax(contentsDto);
	}
	@Override
	public ContentsDto accptContents() throws Exception{
		return contentsDao.accptContents();
	}
	@Override
	public List<Tbsetcd1Dto> companyList() throws Exception {
		return contentsDao.companyList();
	}
	@Override
	public List<Tbsetcd2Dto> serviceList() throws Exception {
		return contentsDao.serviceList();
	}
	@Override
	public List<Tbsetcd2Dto> confrimList() throws Exception {
		return contentsDao.confrimList();
	}
	@Override
	public List<Tbsetcd2Dto> serviceEndList() throws Exception {
		return contentsDao.serviceEndList();
	}
	@Override
	public List<Tbsetcd1Dto> dataList() throws Exception {
		return contentsDao.dataList();
	}
	@Override
	public List<ContentsDto> contentFileList(ContentsDto contentsDto) throws Exception {
		return contentsDao.contentFileList(contentsDto);
	}
	@Override
	public ContentsDto removeContentsFile(int SCF_SEQ) throws Exception {
		return contentsDao.removeContentsFile(SCF_SEQ);
	}
	@Override
	public int ContentsFileAjax(int SCF_SEQ) throws Exception {
		return contentsDao.ContentsFileAjax(SCF_SEQ);
	}
	@Override
	public boolean modifyConfirmAjax(ContentsDto contentsDto) throws Exception {
		SimpleDateFormat transFormat_no 	= new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat transFormat_date 	= new SimpleDateFormat("yyyy-MM-dd");
		
		boolean retVal = true;
		try {
			if(!"".equals(contentsDto.getSM_LSTATE()) || contentsDto.getSM_LSTATE() != null) {
				contentsDao.contents_Update(contentsDto);
			}
			String SCT_TDATE = contentsDto.getSCT_TDATE();
			SCT_TDATE = transFormat_no.format(transFormat_date.parse(SCT_TDATE))+"00";
			contentsDto.setSCT_TDATE(SCT_TDATE);
			contentsDto.setSCT_CHANGETYPE2("");
			contentsDao.contents_File_Update(contentsDto);
			
		} catch (Exception e) {
			e.printStackTrace();
			retVal = false;
		}
		return retVal;
	}
	@Override
	public boolean contentsApprove(ContentsDto contentsDto) throws Exception {
		
		boolean updateChk = false;
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		try {
			contentsDao.contentsApprove(contentsDto);
			dataSourceTransactionManager.commit(status);
			updateChk = true;
		}catch (Exception e){
			dataSourceTransactionManager.rollback(status);
		}finally {
			return updateChk;
		}
	}
	
	@Override
	public void completeFile(ContentsDto contentsDto) throws Exception {
		contentsDao.Contents_fileUpdate(contentsDto);
	}
	@Override
	public void origqtyUpdate(ContentsDto contentsDto) throws Exception {
		contentsDao.contents_File_Update(contentsDto);
	}
	@Override
	public void lstateUpdate(ContentsDto contentsDto) throws Exception {
		contentsDao.contents_Update(contentsDto);
	}
	@Override
	public List<ContentsDto> delfileChk() throws Exception {
		return contentsDao.delfileChk();
	}
	
	@SuppressWarnings({ "resource", "unchecked" })
	@Override
	public byte[] excelDown(Map<String, Object> commandMap, HttpServletRequest req, HttpServletResponse res) throws Exception {
		//엑셀 처리 시작
		HSSFWorkbook objWorkBook = new HSSFWorkbook();      				// 워크북 생성
		HSSFSheet objSheet 		 = objWorkBook.createSheet("Contents");   	// 워크시트 생성
		HSSFRow objRow 			 = null;        							// 로우 생성
		HSSFCell objCell 		 = null;       								// 셀 생성
		
		objRow = objSheet.createRow((short)1);
		objRow.setHeight ((short) 0x250);
		
		ArrayList headerList = new ArrayList<>();
		headerList = (ArrayList) commandMap.get("colName");
		
		String[] title = (String[]) headerList.get(0);

		HSSFCellStyle styleTitle	 = objWorkBook.createCellStyle();
		styleTitle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		styleTitle.setBottomBorderColor(HSSFColor.BLACK.index);
		styleTitle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		styleTitle.setLeftBorderColor(HSSFColor.BLACK.index);
		styleTitle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		styleTitle.setRightBorderColor(HSSFColor.BLACK.index);
		styleTitle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		styleTitle.setTopBorderColor(HSSFColor.BLACK.index);
		styleTitle.setAlignment (HSSFCellStyle.ALIGN_CENTER);
		styleTitle.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);
		styleTitle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		styleTitle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		
		HSSFCellStyle styleContents	 = objWorkBook.createCellStyle();
		styleContents.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		styleContents.setBottomBorderColor(HSSFColor.BLACK.index);
		styleContents.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		styleContents.setLeftBorderColor(HSSFColor.BLACK.index);
		styleContents.setBorderRight(HSSFCellStyle.BORDER_THIN);
		styleContents.setRightBorderColor(HSSFColor.BLACK.index);
		styleContents.setBorderTop(HSSFCellStyle.BORDER_THIN);
		styleContents.setTopBorderColor(HSSFColor.BLACK.index);
		styleContents.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);
		styleContents.setFillForegroundColor(HSSFColor.TEAL.index);
		styleContents.setWrapText(true);
		//styleContents.setAlignment (HSSFCellStyle.ALIGN_CENTER);
		
		for(int i=1; i <= title.length; i++){
			String headerTitle = title[i-1];
			objCell = objRow.createCell(i);
			objCell.setCellValue(new HSSFRichTextString(headerTitle));
			objCell.setCellStyle(styleTitle);
		}
		
		List<ContentsDto> resultList = (List<ContentsDto>) commandMap.get("resultList");
		
		if(resultList != null){
			for(int i=0; i < resultList.size(); i++){
				StringTokenizer attatchSeqs = new StringTokenizer(resultList.get(i).getSM_SVC2(),",");
				String SM_SVC2_NM = "";
				List<String> lists3 = new ArrayList<>();
				while (attatchSeqs.hasMoreTokens()){
					String now_token = attatchSeqs.nextToken();
					if("3079".equals(now_token.trim())) {
						SM_SVC2_NM = "매체변환";
					}else if("3080".equals(now_token.trim())) {
						SM_SVC2_NM = "영상편집";
					}else if("3081".equals(now_token.trim())) {
						SM_SVC2_NM = "파워포인트";
					}else if("3082".equals(now_token.trim())) {
						SM_SVC2_NM = "이미지";
					}else if("3092".equals(now_token.trim())) {
						SM_SVC2_NM = "기타";
					}else {
						SM_SVC2_NM = "";
					}
					lists3.add(SM_SVC2_NM);
	            }
					
				objRow = objSheet.createRow(objRow.getRowNum()+1);
				ContentsDto getMap = new ContentsDto();
				getMap = resultList.get(i);
				ArrayList<String> cellData = new ArrayList<>();
				
				String NUM = Integer.toString(i + 1);
				String SM_NO = isNullChk(getMap.getSM_NO());
				String SM_DATE = isNullChk(getMap.getSM_DATE());
				String SM_TITLE = isNullChk(getMap.getSM_TITLE());
				
				String SM_MC1NAME = isNullChk(getMap.getSM_MC1NAME());
				String SM_MC2NAME = isNullChk(getMap.getSM_MC2NAME());
				String SM_MDNAME = isNullChk(getMap.getSM_MDNAME());
				String SM_MNAME = isNullChk(getMap.getSM_MNAME());
				
				String SCT_TDATE = isNullChk(getMap.getSCT_TDATE());
				String SCT_RDATE = isNullChk(getMap.getSCT_RDATE());
				String SM_SVC2 = isNullChk(lists3.toString().replace("[", "").replace("]", ""));
				String SM_AMOUNT = isNullChk(getMap.getSM_AMOUNT());
				
				String SCT_ORIGQTY = isNullChk(getMap.getSCT_ORIGQTY());
				String SM_LSTATE = isNullChk(getMap.getSM_LSTATE());
				String SM_TEXT = isNullChk(getMap.getSM_TEXT());
				String SCT_worker = isNullChk(getMap.getSCT_worker());
				String SM_LSTATE_NM = "";
				
				switch(SM_LSTATE) {
				case "3093": 
					SM_LSTATE_NM = "신청";
					break;
				case "3094": 
					SM_LSTATE_NM = "승인대기";
					break;
				case "3099": 
					SM_LSTATE_NM = "진행중";
					break;
				case "3095": 
					SM_LSTATE_NM = "완료";
					break;
				case "3097": 
					SM_LSTATE_NM = "사용자취소";
					break;
				}
				
				cellData.add(NUM);
				cellData.add(SM_NO);
				cellData.add(SM_DATE);
				cellData.add(SM_TITLE);
				
				cellData.add(SM_MC1NAME);
				cellData.add(SM_MC2NAME);
				cellData.add(SM_MDNAME);
				cellData.add(SM_MNAME);
				
				cellData.add(SCT_TDATE);
				cellData.add(SCT_RDATE);
				cellData.add(SM_SVC2);
				cellData.add(SM_AMOUNT);
				
				cellData.add(SCT_ORIGQTY);
				cellData.add(SM_LSTATE_NM);
				cellData.add(SM_TEXT);
				cellData.add(SCT_worker);
				
				for(int j=1; j <= cellData.size(); j++){
					objCell = objRow.createCell(j);
					objCell.setCellValue(new HSSFRichTextString(cellData.get(j-1)));
					objCell.setCellStyle(styleContents);
				}
			}
			for(int x=0; x<objRow.getPhysicalNumberOfCells(); x++) {
				if(x == 4) {
					objSheet.setColumnWidth(x, 13000);
				}else if(x == 11){
					objSheet.setColumnWidth(x, 8000);
				}else if(x == 15){
					objSheet.setColumnWidth(x, 20000);
				}else {
					objSheet.autoSizeColumn(x);
					objSheet.setColumnWidth(x, objSheet.getColumnWidth(x)+512);
				}
			}
		}
		
		byte[] bytes = new byte[0];
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		try {
			objWorkBook.write(out);
			bytes = out.toByteArray();
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
		return bytes;
	}
	
	static String isNullChk(Object obj){
		String parseData = "";
		if(obj != null){
			parseData = obj.toString();
		}
		return parseData;
	}
}
