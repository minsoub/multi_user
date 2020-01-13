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
import org.apache.poi.hssf.util.CellRangeAddress8Bit;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
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
import kr.co.neodreams.multi_user.common.TldUtil;
import kr.co.neodreams.multi_user.dao.DisplayBoardDao;
import kr.co.neodreams.multi_user.dto.ContentsDto;
import kr.co.neodreams.multi_user.dto.DisplayBoardDto;
import kr.co.neodreams.multi_user.dto.Tbsetcd2Dto;

@Service
public class DisplayBoardServiceImpl extends BaseService implements DisplayBoardService{
	
	@Autowired
	DisplayBoardDao displayBoardDao;

    @Autowired
	DataSourceTransactionManager dataSourceTransactionManager;	
    
	/** 컨텐츠 제작 신청내역 취득 */
	public Map<String, Object> getMypageDisplayBoardList(DisplayBoardDto displayBoardDto) throws Exception{
	    Map<String, Object> resultMap = new HashMap<String, Object>();
		List<DisplayBoardDto> resultList = (List<DisplayBoardDto>) displayBoardDao.getMypageDisplayBoardList(displayBoardDto);
		int totalCnt = displayBoardDao.getMypageDisplayBoardListCount(displayBoardDto);
		resultMap.put("resultList", resultList);
		resultMap.put("totalCnt", totalCnt);
		return resultMap;
	}
	
	public List<Tbsetcd2Dto> display_categorey_Select(Tbsetcd2Dto tbsetcd2Dto) throws Exception {
		List<Tbsetcd2Dto> categorey = null;
		categorey = displayBoardDao.display_categorey_Select(tbsetcd2Dto);
		return categorey;
	}
	
	
public boolean display_Insert(DisplayBoardDto displayBoardDto, JSONObject jsonObject) throws Exception{
		
		CommonUtil commonUtil = new CommonUtil();
		Date from = new Date();
		SimpleDateFormat transFormat_no 	= new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat transFormat_date 	= new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat transFormat_date2 	= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
		
		/*서비스 신청번호 생성*/
		String setSM_NO = "";
		List<DisplayBoardDto> maxNumSelect = null;
		maxNumSelect = displayBoardDao.display_Select(displayBoardDto);
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
					displayBoardDto.setSDP_FNAME1(savename);
				}else if(i == 1){
					displayBoardDto.setSDP_FNAME2(savename);
				}else if(i == 2){
					displayBoardDto.setSDP_FNAME3(savename);
				}
			}
		}
		
		/*회사명 조회*/
		List<DisplayBoardDto> codeValue = displayBoardDao.display_tbSetcd1_Select(displayBoardDto);
		String code = codeValue.get(0).getCD1_NAME();	
		
		String SM_SVC1 		= "1002";		//서비스구분[전광판 게시신청/1002]
		// 관리항목
		String SM_LSTATE 	= "3093";		//사용자 서비스상태[신청||접수||정상완료||미처리종료||미승인종료||사용자취소]
		String SM_FSTATE 	= "3115";		//서비스 종료상태[진행중||게시종료||미승인종료||사용자취소]
		String SM_ISSIGN 	= "3112";		//승인상태[승인대기중||승인완료||반려]
		
		displayBoardDto.setSM_NO(setSM_NO);
		displayBoardDto.setSM_DATE(transFormat_date.format(from));
		displayBoardDto.setSM_SVC1(SM_SVC1);
		displayBoardDto.setSM_MCNAME(code);
		displayBoardDto.setSM_FDATE(transFormat_date.format(from));
		displayBoardDto.setSM_LSTATE(SM_LSTATE);
		displayBoardDto.setSM_FSTATE(SM_FSTATE);
		displayBoardDto.setSM_ISSIGN(SM_ISSIGN);
		displayBoardDto.setSM_IPADDR(commonUtil.getIPAddr());
		displayBoardDto.setSM_WDATE(transFormat_date2.format(from));
		displayBoardDao.display_Insert(displayBoardDto);
		
		String setSDP_FDATE = "";//= STIME1 & STIME2 & STIME3
		String STIME1 = displayBoardDto.getSTIME1();
		String STIME2 = displayBoardDto.getSTIME2();
		String STIME3 = displayBoardDto.getSTIME3();
		setSDP_FDATE = STIME1.replaceAll("-", "")+STIME2+STIME3;
		String setSDP_TDATE = "";//= STIME1 & STIME2 & STIME3
		String ETIME1 = displayBoardDto.getETIME1();
		String ETIME2 = displayBoardDto.getETIME2();
		String ETIME3 = displayBoardDto.getETIME3();
		setSDP_TDATE = ETIME1.replaceAll("-", "")+ETIME2+ETIME3;
		
		displayBoardDto.setSDP_SMDATE(transFormat_date.format(from));
		displayBoardDto.setSDP_FDATE(setSDP_FDATE);
		displayBoardDto.setSDP_TDATE(setSDP_TDATE);
		
		displayBoardDao.display_File_Insert(displayBoardDto);
		
		if((!"".equals(displayBoardDto.getFileSeq_1()) && displayBoardDto.getFileSeq_1() != null)
				||(!"".equals(displayBoardDto.getFileSeq_2()) && displayBoardDto.getFileSeq_2() != null)
				||(!"".equals(displayBoardDto.getFileSeq_3()) && displayBoardDto.getFileSeq_3() != null)) {
				displayBoardDao.Display_fileUpdate(displayBoardDto);
			}
		
		return true;
	}
	public List<DisplayBoardDto> getDisplayList (DisplayBoardDto displayBoardDto) throws Exception{
		try {
			if(!"".equals(displayBoardDto.getS3()) && null != displayBoardDto.getS3()) {
				StringTokenizer attatchSeqs = new StringTokenizer(displayBoardDto.getS3(),",");
				ArrayList<String> lists3 = new ArrayList<>();
				
				int totCnt = attatchSeqs.countTokens();
				for(int i=0; i < totCnt; i++) {
					lists3.add(attatchSeqs.nextToken());
				}
				displayBoardDto.setLists3(lists3);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return displayBoardDao.getDisplayList(displayBoardDto);
	}
	public int getDisplayListCnt (DisplayBoardDto displayBoardDto) throws Exception{
		return displayBoardDao.getDisplayListCnt(displayBoardDto);
	}
	public List<DisplayBoardDto> getDisplayDetail (DisplayBoardDto displayBoardDto) throws Exception{
		return displayBoardDao.getDisplayDetail(displayBoardDto);
	}
	public boolean display_Update(DisplayBoardDto displayBoardDto, JSONObject jsonObject) throws Exception{
		/*파일 등록*/	
		if(jsonObject != null && !jsonObject.isEmpty()){ 
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
					displayBoardDto.setSDP_FNAME1(savename);
				}else if(i == 1){
					displayBoardDto.setSDP_FNAME2(savename);
				}else if(i == 2){
					displayBoardDto.setSDP_FNAME3(savename);
				}
			}
		}
		displayBoardDao.display_Update(displayBoardDto);
		displayBoardDao.display_File_Update(displayBoardDto);
		if((!"".equals(displayBoardDto.getFileSeq_1()) && displayBoardDto.getFileSeq_1() != null)
				||(!"".equals(displayBoardDto.getFileSeq_2()) && displayBoardDto.getFileSeq_2() != null)
				||(!"".equals(displayBoardDto.getFileSeq_3()) && displayBoardDto.getFileSeq_3() != null)) {
				displayBoardDao.Display_fileUpdate(displayBoardDto);
		}
		return true; 
	}
	public boolean display_Del(DisplayBoardDto displayBoardDto) throws Exception{
		displayBoardDao.display_Del(displayBoardDto);
		return true;
	}

	@Override
	public boolean display_Approve(DisplayBoardDto displayBoardDto) throws Exception {
		
		boolean updateChk = false;
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		try {
			displayBoardDao.display_Approve(displayBoardDto);
			dataSourceTransactionManager.commit(status);
			updateChk = true;
		}catch (Exception e){
			dataSourceTransactionManager.rollback(status);
		}finally {
			return updateChk;
		}
	}

	@Override
	public List<DisplayBoardDto> contentFileList(DisplayBoardDto displayBoardDto) throws Exception {
		return displayBoardDao.contentFileList(displayBoardDto);
	}

	@Override
	public DisplayBoardDto removeDisplayFile(int SDP_SEQ) throws Exception {
		return displayBoardDao.removeDisplayFile(SDP_SEQ);
	}

	@Override
	public int diplayFileAjax(int SDP_SEQ) throws Exception {
		return displayBoardDao.diplayFileAjax(SDP_SEQ);
	}

	@Override
	public void completeFile(DisplayBoardDto displayBoardDto) throws Exception {
		displayBoardDao.Display_fileUpdate(displayBoardDto);		
	}

	@Override
	public void lstateUpdate(DisplayBoardDto displayBoardDto) throws Exception {
		displayBoardDao.display_Update(displayBoardDto);		
	}

	@Override
	public List<DisplayBoardDto> delfileChk() throws Exception {
		return displayBoardDao.delfileChk();
	}

	@SuppressWarnings({ "resource", "unchecked" })
	@Override
	public byte[] excelDown(Map<String, Object> commandMap, HttpServletRequest req, HttpServletResponse res) throws Exception {
		//엑셀 처리 시작
		HSSFWorkbook objWorkBook = new HSSFWorkbook();      				// 워크북 생성
		HSSFSheet objSheet 		 = objWorkBook.createSheet("Display");   	// 워크시트 생성
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
		
		HSSFCellStyle styleEnd_cell	 = objWorkBook.createCellStyle();
		styleEnd_cell.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		styleEnd_cell.setBottomBorderColor(HSSFColor.BLACK.index);
		styleEnd_cell.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		styleEnd_cell.setLeftBorderColor(HSSFColor.BLACK.index);
		styleEnd_cell.setBorderRight(HSSFCellStyle.BORDER_THIN);
		styleEnd_cell.setRightBorderColor(HSSFColor.BLACK.index);
		styleEnd_cell.setBorderTop(HSSFCellStyle.BORDER_THIN);
		styleEnd_cell.setTopBorderColor(HSSFColor.BLACK.index);
		styleEnd_cell.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);
		styleEnd_cell.setFillForegroundColor(HSSFColor.TEAL.index);
		styleEnd_cell.setAlignment (HSSFCellStyle.ALIGN_CENTER);
		
		for(int i=1; i <= title.length; i++){
			String headerTitle = title[i-1];
			objCell = objRow.createCell(i-1);
			objCell.setCellValue(new HSSFRichTextString(headerTitle));
			objCell.setCellStyle(styleTitle);
		}
		
		List<DisplayBoardDto> resultList = (List<DisplayBoardDto>) commandMap.get("resultList");
		DisplayBoardDto TotalList =  (DisplayBoardDto) commandMap.get("TotalList");
		
		int listsize = resultList.size();
		int endrowCnt = listsize + 2;
		
		if(resultList != null){
			for(int i=0; i < resultList.size(); i++){
				objRow = objSheet.createRow(objRow.getRowNum()+1);
				DisplayBoardDto getMap = new DisplayBoardDto();
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
				
				String SDP_PLANDATE = isNullChk(getMap.getSDP_PLANDATE());
				String SM_SVC2 = isNullChk(getMap.getSM_SVC2());
				String SM_LSTATE = isNullChk(getMap.getSM_LSTATE());
				String SDP_FDATE = isNullChk(TldUtil.changday2(getMap.getSDP_FDATE()));
				String SDP_TDATE = isNullChk(TldUtil.changday2(getMap.getSDP_TDATE()));
				String SM_LSTATE_NM = "";
				String TERM_DATE = SDP_FDATE + " ~ " + SDP_TDATE;
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
				cellData.add(SDP_PLANDATE);
				if(SM_SVC2.contains("3074")) {
					cellData.add("O");
				}else {
					cellData.add("");
				}
				if(SM_SVC2.contains("3075")) {
					cellData.add("O");
				}else {
					cellData.add("");
				}
				if(SM_SVC2.contains("3076")) {
					cellData.add("O");
				}else {
					cellData.add("");
				}
				if(SM_SVC2.contains("3272")) {
					cellData.add("O");
				}else {
					cellData.add("");
				}
				cellData.add(SM_LSTATE_NM);
				cellData.add(TERM_DATE);
				cellData.add("");
				
				for(int j=1; j <= cellData.size(); j++){
					objCell = objRow.createCell(j-1);
					objCell.setCellValue(new HSSFRichTextString(cellData.get(j-1)));
					objCell.setCellStyle(styleContents);
				}
			}
			for(int x=0; x<objRow.getPhysicalNumberOfCells(); x++) {
				if(x == 3) {
					objSheet.setColumnWidth(x, 13000);
				}else if(x == 14){
					objSheet.setColumnWidth(x, 13000);
				}else {
					objSheet.autoSizeColumn(x);
					objSheet.setColumnWidth(x, objSheet.getColumnWidth(x)+1000);
				}
			}
			objRow = objSheet.createRow(endrowCnt);
			int TotalSum = TotalList.getC1_TOT() + TotalList.getC2_TOT() + TotalList.getC3_TOT() + TotalList.getC4_TOT();
			for(int y=1; y <= 16; y++){
				objCell = objRow.createCell(y-1);
				if(y == 1) {
					objCell.setCellValue("합계 : " + TotalSum);	
				}else if( y == 10){
					objCell.setCellValue(TotalList.getC1_TOT());
				}else if( y == 11){
					objCell.setCellValue(TotalList.getC2_TOT());
				}else if( y == 12){
					objCell.setCellValue(TotalList.getC3_TOT());
				}else if( y == 13){
					objCell.setCellValue(TotalList.getC4_TOT());
				} 
				objCell.setCellStyle(styleContents);
				objCell.setCellStyle(styleEnd_cell);
			}
			objSheet.addMergedRegion(new CellRangeAddress(endrowCnt, endrowCnt, 0, 8));
			/*objCell.setCellValue("합계");
			objCell.setCellStyle(styleTitle);*/
			
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

	@Override
	public DisplayBoardDto TotalList(DisplayBoardDto displayBoardDto) throws Exception {
		return displayBoardDao.TotalList(displayBoardDto);
	}
	
}
