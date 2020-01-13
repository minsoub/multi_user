package kr.co.neodreams.multi_user.service;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.base.service.BaseService;
import kr.co.neodreams.multi_user.common.DataMap;
import kr.co.neodreams.multi_user.dao.LongTermUserDao;
import kr.co.neodreams.multi_user.dto.LongTermUserDto;

@Service
public class LongTermUserServiceImpl extends BaseService implements LongTermUserService {
	@Autowired
	LongTermUserDao longTermUserDao;
	
	@Override
	public List<LongTermUserDto> equipCodeList() throws Exception {
		return longTermUserDao.equipCodeList();
	}

	@Override
	public List<LongTermUserDto> longTermUserList(LongTermUserDto ltud) throws Exception {
		return longTermUserDao.longTermUserList(ltud);
	}

	@Override
	public List<LongTermUserDto> longTermUserNotifyUserInfo(LongTermUserDto ltud) throws Exception {
		return longTermUserDao.longTermUserNotifyUserInfo(ltud);
	}

	@Override
	public List<HashMap<String, String>> notebookCheckList(LongTermUserDto ltud) throws Exception {
		return longTermUserDao.notebookCheckList(ltud);
	}
	
	@Override
	public int notebookCheckListCnt(LongTermUserDto ltud) throws Exception {
		return longTermUserDao.notebookCheckListCnt(ltud);
	}

	@Override
	public HashMap<String, String> notebookCheckView(LongTermUserDto ltud) throws Exception {
		return longTermUserDao.notebookCheckView(ltud);
	}
	
	@Override
	public String notebookCheckUpdate(HttpServletRequest request) throws Exception {
		
		String retVal = "false";
		
		try{
			DataMap dataMap = new DataMap(request, "non_encoding");
			
			longTermUserDao.notebookCheckUpdate(dataMap);
			
			retVal = "true";
		}catch(Exception e){
			e.printStackTrace();
			retVal = "false";
		}
		
		return retVal;
	}
	
	@Override
	public String notebookPartsUpdate(LongTermUserDto longTermUserDto) throws Exception {
		String retVal = "false";
		
		try{
			longTermUserDao.notebookPartsUpdate(longTermUserDto);
			retVal = "true";
		}catch(Exception e){
			e.printStackTrace();
			retVal = "false";
		}
		return retVal;
	}

	@Override
	public List<HashMap<String, String>> notebookCheckListXls(LongTermUserDto ltud) throws Exception {
		return longTermUserDao.notebookCheckListXls(ltud);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public byte[] excelDown(Map<String, Object> commandMap, HttpServletRequest req, HttpServletResponse res) throws Exception {
		//엑셀 처리 시작
				HSSFWorkbook objWorkBook = new HSSFWorkbook();      		// 워크북 생성
				HSSFSheet objSheet 		 = objWorkBook.createSheet("EquipmentRentalStatus");   	// 워크시트 생성
				HSSFRow objRow 			 = null;        					// 로우 생성
				HSSFCell objCell 		 = null;       						// 셀 생성
				
				objRow = objSheet.createRow((short)1);
				objRow.setHeight ((short) 0x250);
				
				ArrayList headerList = new ArrayList<>();
				ArrayList nextHeaderList = new ArrayList<>();
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
				styleTitle.setFillForegroundColor(HSSFColor.TEAL.index);
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
				styleContents.setAlignment (HSSFCellStyle.ALIGN_CENTER);
				
				for(int i=1; i <= title.length; i++){
					String headerTitle = title[i-1];
					
					objCell = objRow.createCell(i);
					objCell.setCellValue(new HSSFRichTextString(headerTitle));
					objCell.setCellStyle(styleTitle);
				}
				
				List<LongTermUserDto> resultList = (List<LongTermUserDto>) commandMap.get("resultList");
				
				if(resultList != null){
					for(int i=0; i < resultList.size(); i++){
						objRow = objSheet.createRow(objRow.getRowNum()+1);
					//	objRow.setHeight ((short) 0x250);
						
						LongTermUserDto getMap = new LongTermUserDto();
						getMap = resultList.get(i);
						ArrayList<String> cellData = new ArrayList<>();
						String NUM = Integer.toString(i + 1);
						String EQMSTNM = isNullChk(getMap.getEQMSTNM());
						String EQMST = isNullChk(getMap.getEQMST());
						String STATUSNM = isNullChk(getMap.getSTATUSNM());
						String EQCDT = isNullChk(getMap.getEQCDT());
						String EQRDT = isNullChk(getMap.getEQRDT());
						String GBNM = isNullChk(getMap.getGBNM());
						String MDNM = isNullChk(getMap.getMDNM());
						String EQALIAS = isNullChk(getMap.getEQALIAS());
						String EQASSETSNO = isNullChk(getMap.getEQASSETSNO());
						String EQSN = isNullChk(getMap.getEQSN());
						String APPE_DEPTNM = isNullChk(getMap.getAPPSS());
						String APPENO = isNullChk(getMap.getAPPENO());
						String APPENM = isNullChk(getMap.getAPPENM());
						String DEPT1NM = isNullChk(getMap.getAPPE_DEPTNM());
						String APPUENO = isNullChk(getMap.getAPPUENO()); 
						String APPUENM = isNullChk(getMap.getAPPUENM());
						String STRDT = isNullChk(getMap.getSTRDT());
						String ENDDT = isNullChk(getMap.getENDDT());
						String etc2 = isNullChk(getMap.getETC2());
						
						String schCode = req.getParameter("schCode");
						String schStatus = isNullChk(getMap.getSchStatus());
						
						switch (EQMST) {
						case "1":
							switch (STATUSNM) {
							case "0":
								STATUSNM = "대여가능";
								break;
							case "2":
								STATUSNM = "미반납";
								break;
							case "3":
								STATUSNM = "대여예정";
								break;
							case "4":
								STATUSNM = "단기대여";
								break;
							default:
								STATUSNM = "장기대여";
								break;
							}
							break;
						case "2":
							STATUSNM = "고장";
							break;
						case "3":
							STATUSNM = "수리중";
							break;
						case "4":
							STATUSNM = "폐기";
							break;
						default:
							STATUSNM = "해지";
							break;
						}
						
						
							cellData.add(NUM);
							cellData.add(STATUSNM);
						if(("001").equals(schCode) || ("018").equals(schCode) || ("010").equals(schCode) || ("021").equals(schCode)) {
							cellData.add(EQCDT);
							cellData.add(EQRDT);
						}
							cellData.add(GBNM);
							
						if(("010").equals(schCode) || ("021").equals(schCode)){
							cellData.add(etc2);
						}
							cellData.add(MDNM);
							cellData.add(EQALIAS);
						if(("001").equals(schCode) || ("018").equals(schCode) || ("021").equals(schCode)) {
							cellData.add(EQASSETSNO);
						}
							cellData.add(EQSN);
							cellData.add(APPE_DEPTNM);
							cellData.add(APPENO);
							cellData.add(APPENM);
							cellData.add(DEPT1NM);
							cellData.add(APPUENO);
							cellData.add(APPUENM);
							cellData.add(STRDT);
							cellData.add(ENDDT);

						for(int j=1; j <= cellData.size(); j++){
							objCell = objRow.createCell(j);
							objCell.setCellValue(new HSSFRichTextString(cellData.get(j-1)));
							objCell.setCellStyle(styleContents);
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
