package kr.co.neodreams.multi_user.controller;

import java.io.PrintWriter;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Address;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ibm.icu.util.Calendar;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.CommonUtil;
import kr.co.neodreams.multi_user.common.DataMap;
import kr.co.neodreams.multi_user.common.DateUtil;
import kr.co.neodreams.multi_user.common.ExcelUtil;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.common.mail.SendMail;
import kr.co.neodreams.multi_user.common.sms.SendSMS;
import kr.co.neodreams.multi_user.dto.LongTermUserDto;
import kr.co.neodreams.multi_user.dto.RentDto;
import kr.co.neodreams.multi_user.service.CommonService;
import kr.co.neodreams.multi_user.service.LongTermUserService;
import kr.co.neodreams.multi_user.service.RentService;

@Controller
public class LongTermUserController extends BaseController {
	
	@Autowired
	LongTermUserService longTermUserService;	
	
	@Autowired
    RentService rentService;
	

    @Autowired
    private CommonService commonService;
		
	/* 장비대여 > 관리메뉴 > 장기대여사용자관리  */    
    @RequestMapping("/admin/longTermUser.do")
    public ModelAndView longTermUserList(HttpServletRequest request, HttpServletResponse response) throws Exception {

    	ModelAndView mv = new ModelAndView();
    	
    	try{
	    	String schCode = request.getParameter("schCode");
	    	String schStatus = request.getParameter("schStatus");
	    	String schEQST = request.getParameter("schEQST");
	    	String schOrder = request.getParameter("schOrder");
	    	String schText = request.getParameter("schText");
	    	
	    	if (schStatus == null || schStatus.equalsIgnoreCase("") || schStatus == "") {
	        	schStatus = "";        	
	        }
	    	if (schEQST == null || schEQST.equalsIgnoreCase("") || schEQST == "") {
	    		schEQST = "useing";        	
	        }
	    	
	    	/* 장비 목록 */
	        List<LongTermUserDto> codeList = new ArrayList<LongTermUserDto>();
	        codeList = longTermUserService.equipCodeList();
	        mv.addObject("codeList", codeList);
	        
	        if (schCode == null || schCode.equalsIgnoreCase("") || schCode == "") {
	        	schCode = codeList.get(0).getGBCD();        	
	        }
	        mv.addObject("schCode", schCode);
	
	        LongTermUserDto ltud = new LongTermUserDto();
	        ltud.setGBCD(schCode);
	        
	    	switch(schStatus) {
	    	case "all":
	        	ltud.setSchStatus("");
	    		break;
	    	case "longNShort":
	    		ltud.setSchStatus("1");
	    		break;
	    	case "long":
	    		ltud.setSchStatus("5");
	    		break;
	    	case "short":
	    		ltud.setSchStatus("4");
	    		break;
	    	case "available":
	    		ltud.setSchStatus("0");
	        	break;
	    	case "expected":
	    		ltud.setSchStatus("3");
	        	break;
	    	case "unreturn":
	    		ltud.setSchStatus("2");
	    		break;
	    	}
	    	
	    	switch(schEQST) {
	    	case "useing":
	        	ltud.setSchEQST("1");
	    		break;
	    	case "trouble":
	    		ltud.setSchEQST("2");
	    		break;
	    	case "repair":
	        	ltud.setSchEQST("3");
	    		break;
	    	case "disuse":
	        	ltud.setSchEQST("4");
	    		break;
	    	case "Terminate":
	        	ltud.setSchEQST("5");
	    		break;
	    	case "Store":
	        	ltud.setSchEQST("6");
	    		break;
	    	}
	    	
	    	
	        mv.addObject("schStatus", schStatus);
	        mv.addObject("schEQST", schEQST);
	        
	        if(StringUtil.isEmpty(schOrder)){
	        	schOrder = "EQALIAS";
	        }
	        ltud.setSRH_ORDER(schOrder);
	        mv.addObject("schOrder", schOrder);
	        
	        ltud.setSCHTEXT(schText);
	        mv.addObject("schText", schText);
	        
	        List<LongTermUserDto> list = longTermUserService.longTermUserList(ltud);
	
	        mv.setViewName("rent/admin/longTermUser");       
	        mv.addObject("longTermUserList", list);
    	}catch(Exception e){
    		e.printStackTrace();
    		mv.setViewName("/error/error");
    	}
        
        return mv;
    }
    
    /* 장비대여 > 관리메뉴 > 장기대여사용자관리 > 엑셀저장  */
   /* @RequestMapping("/admin/excelDownload.do")
    public String excelDownload (@RequestParam HashMap<String, Object> paramMap, ModelMap model) throws Exception{
     
        model.addAttribute("excelResult",paramMap);

        return "rent/admin/longTermUserExcel";

    }*/
    
    /* 장비대여 > 관리메뉴 > 장기대여사용자관리 > 엑셀저장  */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/admin/longTermExcelDownload.do")
    public @ResponseBody byte[] longTermExcelDownload (HttpServletResponse res, HttpServletRequest req, LongTermUserDto termUserDto, BindingResult bindingResult) throws Exception{
     
    	String schCode = req.getParameter("schCode");
    	String schStatus = req.getParameter("schStatus");
    	String schEQST = req.getParameter("schEQST");
    	String schOrder = req.getParameter("schOrder");
    	String schText = req.getParameter("schText");
    	
    	if (schStatus == null || schStatus.equalsIgnoreCase("") || schStatus == "") {
        	schStatus = "";        	
        }
    	if (schEQST == null || schEQST.equalsIgnoreCase("") || schEQST == "") {
    		schEQST = "useing";        	
        }
    	if(StringUtil.isEmpty(schOrder)){
        	schOrder = "MDNM";
        }
    	termUserDto.setSRH_ORDER(schOrder);
        termUserDto.setSCHTEXT(schText);
        termUserDto.setGBCD(schCode);
        
    	switch(schStatus) {
    	case "all":
    		termUserDto.setSchStatus("");
    		break;
    	case "longNShort":
    		termUserDto.setSchStatus("1");
    		break;
    	case "long":
    		termUserDto.setSchStatus("5");
    		break;
    	case "short":
    		termUserDto.setSchStatus("4");
    		break;
    	case "available":
    		termUserDto.setSchStatus("0");
        	break;
    	case "expected":
    		termUserDto.setSchStatus("3");
        	break;
    	case "unreturn":
    		termUserDto.setSchStatus("2");
    		break;
    	}
    	
    	switch(schEQST) {
    	case "useing":
    		termUserDto.setSchEQST("1");
    		break;
    	case "trouble":
    		termUserDto.setSchEQST("2");
    		break;
    	case "repair":
    		termUserDto.setSchEQST("3");
    		break;
    	case "disuse":
    		termUserDto.setSchEQST("4");
    		break;
    	case "Terminate":
    		termUserDto.setSchEQST("5");
    		break;
    	}
    	List<LongTermUserDto> listMap = longTermUserService.longTermUserList(termUserDto);
    	String[] prefix = null;
    	if(("001").equals(schCode) || ("018").equals(schCode)) {
    		if(!("available").equals(schStatus)) {
    			prefix = new String[]{"순번", "구분", "제조일", "등록일", "제조사", "모델명", "관리번호", "자산번호", "설비고유번호", "신청자 부서", "사번", "신청자 이름", "사용자 부서", "사번", "사용자 이름", "대여일자", "반납일자"};
    		}else {
    			prefix = new String[]{"순번", "구분", "제조일", "등록일", "제조사", "모델명", "관리번호", "자산번호", "설비고유번호", "신청자 부서", "사번", "신청자 이름", "사용자 부서", "사번", "사용자 이름", "대여예정일자", "반납예정일자"};
    		}
    	}else if(("010").equals(schCode)){
    		if(!("available").equals(schStatus)) {
    			prefix = new String[]{"순번", "구분", "제조일", "등록일", "제조사", "통신사", "모델명", "관리번호", "설비고유번호", "신청자 부서", "사번", "신청자 이름", "사용자 부서", "사번", "사용자 이름", "대여일자", "반납일자"};
    		}else {
    			prefix = new String[]{"순번", "구분", "제조일", "등록일", "제조사", "통신사", "모델명", "관리번호", "설비고유번호", "신청자 부서", "사번", "신청자 이름", "사용자 부서", "사번", "사용자 이름", "대여예정일자", "반납예정일자"};
    		}
    	}else if(("021").equals(schCode)){
    		if(!("available").equals(schStatus)) {
    			prefix = new String[]{"순번", "구분", "제조일", "등록일", "제조사", "통신사", "모델명", "관리번호", "유심번호", "설비고유번호", "신청자 부서", "사번", "신청자 이름", "사용자 부서", "사번", "사용자 이름", "대여일자", "반납일자"};
    		}else {
    			prefix = new String[]{"순번", "구분", "제조일", "등록일", "제조사", "통신사", "모델명", "관리번호", "유심번호", "설비고유번호", "신청자 부서", "사번", "신청자 이름", "사용자 부서", "사번", "사용자 이름", "대여예정일자", "반납예정일자"};
    		}
    	}else {
    		if(!("available").equals(schStatus)) {
    			prefix = new String[]{"순번", "구분", "제조사", "모델명", "관리번호", "설비고유번호", "신청자 부서명", "사번", "신청자 이름", "사용자 부서명", "사번", "사용자 이름", "대여일자", "반납일자"};
    		}else {
    			prefix = new String[]{"순번", "구분", "제조사", "모델명", "관리번호", "설비고유번호", "신청자 부서명", "사번", "신청자 이름", "사용자 부서명", "사번", "사용자 이름", "대여예정일자", "반납예정일자"};
    		}
    	}
    	ArrayList headerList = new ArrayList<>();
    	
    	headerList.add(0, prefix);
    	
    	Map<String, Object> commandMap = new HashMap();
    	commandMap.put("excelName", "EquipmentRentalStatus");
		commandMap.put("sheetName", "");
		commandMap.put("colName", headerList);
		commandMap.put("resultList" , listMap );
		
		byte[] bytes = longTermUserService.excelDown(commandMap, req, res);
		
		
		String fileName = null;
        Calendar calendar = Calendar.getInstance();
        java.util.Date date = calendar.getTime();
        String today = (new SimpleDateFormat("yyyyMMdd").format(date));
        
        fileName = "설비대여현황_"+today;
        String docName ="";
        
        String userAgent = req.getHeader("User-Agent");
        boolean br = userAgent.indexOf("Chrome") > -1;

        if(br){
        	docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
        } else {
        	docName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
        }
		
		res.setHeader("Content-Disposition", "attachment; filename="+docName+".xls");
		res.setContentLength(bytes.length);
		res.setContentType("application/vnd.ms-excel");
		res.setHeader("Pragma", "no-cache");		
		res.setHeader("Cache-Control", "private");
		res.setHeader("Expires", "0");
		
		return bytes;

    }
    
    
    /* 장비대여 > 관리메뉴 > 장기대여사용자관리 > SMS 보내기  */    
    @ResponseBody
    @RequestMapping("/admin/longTermUserSms.do")
    public void longTermUserSms(HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String inputsms = request.getParameter("inputsms");
    	String userdata_sms = request.getParameter("userdata_sms");
    	
    	String[] aryUserData = userdata_sms.split("\\,");

		SendSMS sendSms =  SendSMS.getInstance();
    	for (int i = 0; i < aryUserData.length; i++) {
    		String appeno = aryUserData[i];
        	
    		RentDto rentDto = new RentDto();
    		rentDto.setAPPENO(appeno);
            rentDto.setAPPUENO(appeno);
            
            List<RentDto> cellNoList = rentService.smsToUser(rentDto);
            if(cellNoList.size() > 0){
            	System.out.println("cellNoList : " + cellNoList.get(0).getHp());
            	sendSms.rentalSendSMS(new BigInteger(DateUtil.getCurrentDateTime()), inputsms, cellNoList);
            }
    	}

    	System.out.println("length : " + aryUserData.length);
    	response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print("OK");
    }
    
    /* 장비대여 > 관리메뉴 > 장기대여사용자관리 > Email  */    
    @ResponseBody
    @RequestMapping("/admin/longTermUserEmail.do")
    public void longTermUserEmail(HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String title_email = request.getParameter("title_email");
    	String input_email = request.getParameter("input_email");
    	String userdata_email = request.getParameter("userdata_email");
    	
    	String[] aryUserData = userdata_email.split("\\,");

    	SendMail sd = SendMail.getInstance();
    	for (int i = 0; i < aryUserData.length; i++) {
    		String appeno = aryUserData[i];
        	
            HashMap<String, String> addrs = new HashMap<String, String>();
            addrs.put("email", appeno + "@kepco.co.kr");
            Address[] toAddrs = CommonUtil.mapToAddresses(addrs);
            sd.customSendMail(toAddrs, title_email, input_email);
    	}

    	System.out.println("length : " + aryUserData.length);
    	response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print("OK");
    }
    
    /* 장비대여 > 관리메뉴 > 장기대여사용자관리 > 장비대여알림  */    
    @ResponseBody
    @RequestMapping("/admin/longTermUserNotify.do")
    public void longTermUserNotify(HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String userdata = request.getParameter("userdata");
    	String sendsms = request.getParameter("sendsms");
    	
    	String[] aryUserData = userdata.split("\\,");

    	for (int i = 0; i < aryUserData.length; i++) {
    		String appno = aryUserData[i];
    		if (!appno.equalsIgnoreCase("")) {
    			LongTermUserDto ltud = new LongTermUserDto();
        		ltud.setAPPNO(appno);
        		List<LongTermUserDto> list = longTermUserService.longTermUserNotifyUserInfo(ltud);
        		if(list.size() > 0){
        			System.out.println("Appeno : " + list.get(0).getAPPENO());
        			System.out.println("Appnm : " + list.get(0).getAPPENM());
        			System.out.println("strdt : " + list.get(0).getSTRDT());
        			System.out.println("enddt : " + list.get(0).getENDDT());
        			
        			String eno = list.get(0).getAPPENO();
        			String name = list.get(0).getAPPENM();
        			String strdt = list.get(0).getSTRDT();
        			String enddt = list.get(0).getENDDT();
        			String today = CommonUtil.getToday();
        			long betWeenTime = (CommonUtil.strToDate(today).getTime() - CommonUtil.strToDate(enddt).getTime());
                    int remain = (int) (betWeenTime / (1000*60*60*24));

                    if (sendsms.equals("true")) {
                    	System.out.println("=======================");
	                    //SMS발송
	                    SendSMS ss =  SendSMS.getInstance();
	
	                    String msg = "[설비대여 알림]" + name + " 님 대여 남은기간은 "+ remain +"일 입니다.";
	                           
	                   RentDto rentDto = new RentDto();
	                   rentDto.setAPPENO(eno);
	                   rentDto.setAPPUENO(eno);
	                   List<RentDto> cellNoList = rentService.smsToUser(rentDto);
	                   if(cellNoList.size() > 0){
	                       ss.rentalSendSMS(new BigInteger(DateUtil.getCurrentDateTime()), msg, cellNoList);
	                   }
                   }
                           
                   //EMAIL발송
                   String mail_title = "[멀티미디어 대여설비 반납일 알림] 노트북 1 대( " + remain +" 일 남음)";
                   
                   /*String mail_msg = name + " 님께서 대여해가신 노트북 반납일을 아래와 같이 알려드리오니<br />";
                          mail_msg += "참고 하시어 반납일을 준수해주시기 바랍니다.<br />";
                          mail_msg += "	□ 대여기간 : '"+ strdt.substring(2, 4) +"년 "+ strdt.substring(4, 6) +"월 "+ strdt.substring(6, 8) +"일 ~ '"+ enddt.substring(2, 4) +"년 "+ enddt.substring(4, 6) +"월 "+ enddt.substring(6, 8) +"일<br />";
                          mail_msg += "	□ 남은기간 : "+ remain +"일<br />";
                          mail_msg += "	□ 문의 : 멀티미디어센터 ☎061-6383, ☎061-6265";*/
                          
                   String mail_msg = "<html><head>";
                		mail_msg += "<meta http-equiv='X-UA-Compatible' content='IE=edge, chrome=1'>";
                		mail_msg += "<link rel='stylesheet' type='text/css' href='http://media.hq/resource/common/css/basic.css' />";
                		mail_msg += "<link rel='stylesheet' type='text/css' href='http://media.hq/resource/common/css/main.css' />";
                		mail_msg += "<link rel='stylesheet' type='text/css' href='http://media.hq/resource/common/css/jquery-1.12.1-ui.css' />";
                		mail_msg += "<title>멀티미디어센터</title>";
                		mail_msg += "</head>";
                		mail_msg += "<body>";
                		mail_msg += "<table width='700' border='0' cellspacing='0' cellpadding='0'>";
                		mail_msg += "<tr>";
                		mail_msg += "<td height='140' background='http://media.hq/resource/images/mail/top_return.jpg'>&nbsp;</td>";
                		mail_msg += "</tr>";
                		mail_msg += "<tr>";
                		mail_msg += "<td align='center' background='http://media.hq/resource/images/mail/middle.jpg'>";
                		mail_msg += "<table align='center'>";
                		mail_msg += "<tr>";
                		mail_msg += "<td style='font-size:16px'>";
                		mail_msg += name + " 님께서 대여해가신 노트북 반납일을 아래와 같이 알려드리오니<br />";
                		mail_msg += "참고 하시어 반납일을 준수해주시기 바랍니다.<br /><br />";
                		mail_msg += "□ 대여기간 : '"+ strdt.substring(2, 4) +"년 "+ strdt.substring(4, 6) +"월 "+ strdt.substring(6, 8) +"일 ~ '"+ enddt.substring(2, 4) +"년 "+ enddt.substring(4, 6) +"월 "+ enddt.substring(6, 8) +"일<br />";
                		mail_msg += "□ 남은기간 : "+ remain +"일<br />";
                		mail_msg += "□ 문의 : 멀티미디어센터 ☎061-6383, ☎061-6265";
                		mail_msg += "</td>";
                		mail_msg += "</tr>";
                		mail_msg += "</table>";
                		mail_msg += "</td>";
                		mail_msg += "</tr>";
                		mail_msg += "<tr>";
                		mail_msg += "<td height='105' align='center' valign='top' background='http://media.hq/resource/images/mail/bottom.jpg'></td>";
                		mail_msg += "</tr>";
                		mail_msg += "</table>";
                		mail_msg += "</html>";
        			
        			//메일발송
                    SendMail sd = SendMail.getInstance();
                    HashMap<String, String> addrs = new HashMap<String, String>();
                    addrs.put("email", eno + "@kepco.co.kr");
                    Address[] toAddrs = CommonUtil.mapToAddresses(addrs);
                    sd.customSendMail(toAddrs, mail_title, mail_msg);
        		}
    		}
    	}

    	response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print("OK");
    }
    
    /* 장비대여 > 관리메뉴 > 노트북 점검대장 */    
    @RequestMapping("/admin/notebookCheckList.do")
    public ModelAndView notebookCheckList(LongTermUserDto ltud, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	ModelAndView mv = new ModelAndView();
    	
    	try{
	    	/*매월 첫째날*/
	    	Calendar cal = Calendar.getInstance();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        int year = cal.get(Calendar.YEAR);
	        int month = (cal.get(Calendar.MONTH)+1);
	        String startDate = year + "-" + (month < 10 ? "0" + month : month) + "-01";
	        
	        String strdt = request.getParameter("sch_strdt");
	        if (StringUtil.isEmpty(strdt)){
	            strdt = startDate;
	        }
	        mv.addObject("sch_strdt", strdt);
	
	        String enddt = request.getParameter("sch_enddt");
	        if (StringUtil.isEmpty(enddt)){
	            enddt = sdf.format(cal.getTime());
	        }
	        mv.addObject("sch_enddt", enddt);
	        
	        String sch_text = request.getParameter("sch_text");
	        if (!StringUtil.isEmpty(sch_text)) {
	            sch_text = sch_text.replaceAll("& #40;", "(");
	            sch_text = sch_text.replaceAll("& #41;", ")");
	            mv.addObject("sch_text", sch_text);        	
	        }
	    	
	        ltud.setSTRDT(strdt.replace("-", ""));
	        ltud.setENDDT(enddt.replace("-", ""));
	        ltud.setSCHTEXT(sch_text);
	        ltud.setPerPageCnt(100);	//100개 출력. 20180516.
	        
	        List<HashMap<String, String>> list = longTermUserService.notebookCheckList(ltud);
	        
	        int totalCnt = longTermUserService.notebookCheckListCnt(ltud);
	
	        mv.setViewName("rent/admin/notebookCheckList");      
	        mv.addObject("notebookCheckList", list);
	        mv.addObject("totalCnt", totalCnt);
	        mv.addObject("paging", ltud);
    	}catch(Exception e){
    		e.printStackTrace();
    		mv.setViewName("/error/error");
    	}
        
        return mv;
    }
    
    /* 장비대여 > 관리메뉴 > 노트북 점검대장 상세보기 */    
    @RequestMapping("/admin/notebookCheckView.do")
    public ModelAndView notebookCheckView(LongTermUserDto ltud, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	ModelAndView mv = new ModelAndView();
    	        
    	try{
    		HashMap<String, String> view = longTermUserService.notebookCheckView(ltud);
	
    		DataMap dataMap = new DataMap(request, "non_encoding");
    		
	        mv.setViewName("rent/admin/notebookCheckView");      
	        mv.addObject("view", view);
	        mv.addObject("srhFrm", dataMap.getParameterHiddenForm());
    	}catch(Exception e){
    		e.printStackTrace();
    		mv.setViewName("/error/error");
    	} 
        
        return mv;
    }
    
    /* 장비대여 > 관리메뉴 > 노트북 점검대장 상세보기 수정 */    
    @RequestMapping("/admin/notebookCheckUpdate.do")
    public void notebookCheckUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String retVal = "false"; 
		
		try{ 
			retVal = longTermUserService.notebookCheckUpdate(request); 
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally{
			response.setHeader("Content-Type", "text/html; charset=utf-8");
			response.getWriter().write(retVal);
		}
    }
    
    /* 장비대여 > 관리메뉴 > 노트북 점검대장 담당자 수정 */    
    @RequestMapping("/admin/notebookPartsUpdate.do")
    public void notebookPartsUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String retVal = "false";
    	String []checkVal_arry = request.getParameterValues("checkVal_arry");
    	String upmanagernm = request.getParameter("upmanagernm");
    	String upmanagerno = request.getParameter("upmanagerno");
    	String partmanagernm = request.getParameter("partmanagernm");
    	String partmanagerno = request.getParameter("partmanagerno");
    	LongTermUserDto longTermUserDto = new LongTermUserDto();
		try{ 
			for(int i=0; checkVal_arry.length > i; ++i) {
	    		String[] searChk = checkVal_arry[i].split(",");
	    		longTermUserDto.setAPPNO(searChk[0].trim());
	    		longTermUserDto.setEQNO(searChk[1].trim());
	    		longTermUserDto.setMANAGERNM(request.getParameter("managernm"));
	    		longTermUserDto.setMANAGERNO(request.getParameter("managerno"));
	    		if((!upmanagernm.equals("") && upmanagernm != null) && (!upmanagerno.equals("") && upmanagerno != null)) {
	    			longTermUserDto.setUPMANAGERNM(upmanagernm);
	    			longTermUserDto.setUPMANAGERNO(upmanagerno);
	    			
	    		}
	    		if((!partmanagernm.equals("") && partmanagernm != null ) && (!partmanagerno.equals("") && partmanagerno != null)) {
	    			longTermUserDto.setPARTMANAGERNM(partmanagernm);
	    			longTermUserDto.setPARTMANAGERNO(partmanagerno);
	    		}
	    		retVal = longTermUserService.notebookPartsUpdate(longTermUserDto);
	    	}
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally{
			response.setHeader("Content-Type", "text/html; charset=utf-8");
			response.getWriter().write(retVal);
		}
    }
    
    
    /* 장비대여 > 관리메뉴 > 노트북 점검대장 > 엑셀저장  */
    @RequestMapping("/admin/checkExcelDownload.do")
	public @ResponseBody byte[] exportXls (LongTermUserDto ltud, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {

		response.setHeader("Set-Cookie", "fileDownload=true; path=/");

		/*매월 첫째날*/
    	Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        int year = cal.get(Calendar.YEAR);
        int month = (cal.get(Calendar.MONTH)+1);
        String startDate = year + "-" + (month < 10 ? "0" + month : month) + "-01";
        
		String strdt = request.getParameter("sch_strdt");
        if (StringUtil.isEmpty(strdt)){
            strdt = startDate;
        }

        String enddt = request.getParameter("sch_enddt");
        if (StringUtil.isEmpty(enddt)){
            enddt = sdf.format(cal.getTime());
        }
        
        String sch_text = request.getParameter("sch_text");
        if (!StringUtil.isEmpty(sch_text)) {
            sch_text = sch_text.replaceAll("& #40;", "(");
            sch_text = sch_text.replaceAll("& #41;", ")");
        }
    	
        ltud.setSTRDT(strdt.replace("-", ""));
        ltud.setENDDT(enddt.replace("-", ""));
        ltud.setSCHTEXT(sch_text);
       
        List<HashMap<String, String>> exList = longTermUserService.notebookCheckListXls(ltud);
		
		// Excel 셋팅
		List<Object> header = new ArrayList<Object>();
		List<List<Object>> data = new ArrayList<List<Object>>();
		
		String[] keyVal = {"NO","구분","대여일","대여자","반납일","반납자","제조사/모델명","관리번호"
							,"CMOS PW 설정여부","로그온 PW 설정여부","공유폴더 삭제여부","주요문서 삭제여부","운영체제 업데이트 여부","V3백신 업데이트 여부","대여관리자","한전담당자","한전파트장","비고","수정일시"};
		
	    //ROW 생성 LOOP  
	    for(int r=0; r < exList.size();r++){
	    	HashMap<String, String> map = exList.get(r);
	    	
    		List<Object> obj = new ArrayList<Object>();	
	    	//header setting 
	    	if(r==0){
	    		for(int k = 0; k < keyVal.length; k++){
	    			header.add(keyVal[k]);
	    			obj.add(String.valueOf(map.get(keyVal[k])));			    		
	    		}
	    	}else{
		    	//data setting 
	    		for(int k = 0; k < keyVal.length; k++){
	    			obj.add(String.valueOf(map.get(keyVal[k])));			    		
	    		}
	    	}
	    	
    		data.add(obj);
	    }

		ExcelUtil excel = new ExcelUtil(header ,data);
		excel.setSheetName("sheet1");
		excel.setWidth(6000);
		
		byte[] bytes = excel.makeExcel();
		
        String userAgent = request.getHeader("User-Agent");
        boolean br = userAgent.indexOf("Chrome") > -1;
        
        String fileName = "보안조치현황_" + DateUtil.getCurrentDateTime();
        String docName ="";        	   
        
        if(br){
        	docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
        } else {
        	docName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
        }
		
		response.setHeader("Content-Disposition", "attachment; filename="+docName+".xlsx");
		response.setContentLength(bytes.length);
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Pragma", "no-cache");		
		response.setHeader("Cache-Control", "private");
		response.setHeader("Expires", "0");
		return bytes;
	}
    
    
    
    @RequestMapping("/admin/sendSMS.do")
    public synchronized void sendSMS() throws Exception{

        System.out.println("#######################sendSMS() start#######################");
        System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
        System.out.println("#######################sendSMS() start#######################");

        String outString = "";
        String outMailAppString = "";
        String outMailRemainString = "";

        try{
            List<RentDto> targetList = commonService.getRentalSendSMSTargetList();

            if(targetList != null
                    && targetList.size() > 0){
                
                //String msg = "[장비반납요청] 부서 이동 전 장비 반납을 요청 드립니다..";
            	String msg = "[반납요청] 부서 이동 전 설비 반납 요청.";
                msg += " * 장소 : 3층 멀티미디어센터(6383)";
                //msg += "오늘도 즐거운 하루 되시기 바랍니다!";
                //msg += "감사합니다";
                //msg += "[ICT인프라처 ICT서비스부(6266)]";

                SendSMS sms = SendSMS.getInstance();
                sms.rentalSendSMS(new BigInteger(DateUtil.getCurrentDateTime()), msg, targetList);

                
                
                List<RentDto> adminList = new ArrayList<RentDto>(); 
                
                RentDto dto = new RentDto();
                dto.setHp("010-8490-7704");
                
                adminList.add(0, dto);
                
                msg = "[반납요청] 부서 이동 전 설비 반납 요청 " + targetList.size() + "건 발송 안내 문자입니다.";
                SendSMS sms2 = SendSMS.getInstance();
                sms2.rentalSendSMS(new BigInteger(DateUtil.getCurrentDateTime()), msg, adminList);
                		
            }else{
                outString = "dept move data is null. this is ok";
            }
        }catch (Exception e){
            e.printStackTrace();
            outString = e.toString();
        }finally{

            System.out.println("#######################sendSMS() end#######################");
            System.out.println(DateUtil.getCurrentDateTime() + "::::" + outString);
            System.out.println("#######################sendSMS() end#######################");
        }


        try {

            /*인수인계 승인메일 발송*/

            System.out.println("#######################sendMailApproval() start#######################");
            System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
            System.out.println("#######################sendMailApproval() start#######################");


            List<RentDto> mailApprovalTargetList = commonService.getMailApprovalTargetList();

            for ( int i = 0 ; i < mailApprovalTargetList.size() ; i++ ){

                String appno = String.valueOf(mailApprovalTargetList.get(i).getAPPNO());
                String uhseq = mailApprovalTargetList.get(i).getUHSEQ();

                /*인수자에게 인수요청*/
                SendMail sd = SendMail.getInstance();
                HashMap<String, String> addrs = new HashMap<String, String>();
                addrs.put("email", mailApprovalTargetList.get(i).getINSUNO() + "@kepco.co.kr");
                Address[] toAddrs = CommonUtil.mapToAddresses(addrs);

                try {
                    sd.sendMail(toAddrs, appno, "chgEu", uhseq, "[멀티미디어 설비사용자 인수인계] "+mailApprovalTargetList.get(i).getINGAENM()+" 님께서 설비사용 인수요청을 하셨음을 알려드립니다.");
                    outMailAppString = "As the data, uhseq is " + uhseq + " and appno is " + appno + ", The approval mail of handing over is sent successfully.";
                } catch (Exception e) {
                    e.printStackTrace();
                    outMailAppString = "As the data, uhseq is " + uhseq + " and appno is " + appno + ", The approval mail of handing over is failed and happended the problem";
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            System.out.println("#######################sendMailApproval() end#######################");
            System.out.println(DateUtil.getCurrentDateTime() + "::::" + outMailAppString);
            System.out.println("#######################sendMailApproval() end#######################");

        }


        try {

            /*대여기간 만료전 메일 및 SMS 발송*/

            System.out.println("#######################sendRemainDateMail() start#######################");
            System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
            System.out.println("#######################sendRemainDateMail() start#######################");

            List<RentDto> mailRemainDateTargetList = commonService.getMailRemainDateTargetList("remain");

            for( int i = 0 ; i < mailRemainDateTargetList.size() ; i++ ){

                String appno = String.valueOf(mailRemainDateTargetList.get(i).getAPPNO());
                String appnum = mailRemainDateTargetList.get(i).getAPPNUM();
                String remaindt = mailRemainDateTargetList.get(i).getREMAINDT();
                SendMail sd = SendMail.getInstance();
                SendSMS ss =  SendSMS.getInstance();
                HashMap<String, String> addrs = null;
                Address[] toAddrs = null;

                /*신청자 대여기간 만료전 알림 메일 및 SMS 발송*/

                String appeno = mailRemainDateTargetList.get(i).getAPPENO();
                String appenm = mailRemainDateTargetList.get(i).getAPPENM();
                String enddt = mailRemainDateTargetList.get(i).getENDDT().substring(0, 4) + "." + mailRemainDateTargetList.get(i).getENDDT().substring(4, 6) + "." + mailRemainDateTargetList.get(i).getENDDT().substring(6, 8);
                String[] eqaliasArr = mailRemainDateTargetList.get(i).getEQALIAS().split(",");

                if(!StringUtils.isEmpty(appeno)){

                    addrs = new HashMap<String, String>();
                    addrs.put("email", appeno + "@kepco.co.kr");
                    toAddrs = CommonUtil.mapToAddresses(addrs);

                    try {
                    	/*신청자 알림메일 발송*/
                        sd.sendMail(toAddrs, appno, "info", "", "[신청자  멀티미디어 대여 반납일 알림] "+appenm+"님께서 대여하신 설비의 대여기간이 "+remaindt+"일 남았습니다.");
                        outMailRemainString = "As the data, appno is " + appno + ", [APPENO] The alarm mail of remaining date is sent successfully.";
                    } catch (Exception e) {
                        e.printStackTrace();
                        outMailRemainString = "As the data, appno is " + appno + ", [APPENO] The alarm mail of remaining date is failed and happended the problem";
                    }

                    String msg = "[설비대여반납일알림] "+appenm+"님께서 대여하신 설비의 대여기간이 "+remaindt+"일 남았습니다.";
                    /*String msg = "[신청자 멀티미디어 대여 반납일 알림] "+appenm+"님께서 대여하신 장비의 대여기간이 "+remaindt+"일 남았습니다.";
                    msg += "* 신청번호 : " + appnum;
                    if(eqaliasArr.length > 1){
                    	msg += "* 대여장비 : " + eqaliasArr[0] + " 외 " + (eqaliasArr.length -1) + "건";
                    }else{
                    	msg += "* 대여장비 : " + eqaliasArr[0];
                    }                    
                    msg += "* 반납일 : " +enddt;
                    msg += "* 반납장소 : 본관 3층 멀티미디어센터(6383)";
                    msg += "오늘도 즐거운 하루 되시기 바랍니다!";
                    msg += "감사합니다";
                    msg += "[ICT인프라처 ICT서비스부(6266)]";*/
                    
                    
                    List<RentDto> cellNoList = new ArrayList<RentDto>();
                    RentDto tmpDto = new RentDto();
                    tmpDto.setHp(mailRemainDateTargetList.get(i).getAPPHP());
                    //cellNoList.get(i).setHp(mailRemainDateTargetList.get(i).getAPPHP());
                    cellNoList.add(tmpDto);
                    try {
                        if(cellNoList.size() > 0){
                            ss.rentalRequireSMS(new BigInteger(DateUtil.getCurrentDateTime()), Integer.parseInt(appno), msg, cellNoList);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            System.out.println("#######################sendRemainDateMail() end#######################");
            System.out.println(DateUtil.getCurrentDateTime() + "::::" + outMailRemainString);
            System.out.println("#######################sendRemainDateMail() end#######################");
        }
        
        
        try {
            /*장비 미반납 알림 메일 및 SMS 발송*/

            System.out.println("#######################sendNoReturnMail() start#######################");
            System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
            System.out.println("#######################sendNoReturnMail() start#######################");

            List<RentDto> mailNoReturnTargetList = commonService.getMailRemainDateTargetList("noReturn");
            
            for( int i = 0 ; i < mailNoReturnTargetList.size() ; i++ ){

                String appno = String.valueOf(mailNoReturnTargetList.get(i).getAPPNO());
                String appnum = mailNoReturnTargetList.get(i).getAPPNUM();
                String remaindt = mailNoReturnTargetList.get(i).getREMAINDT();
                SendMail sd = SendMail.getInstance();
                SendSMS ss =  SendSMS.getInstance();
                HashMap<String, String> addrs = null;
                Address[] toAddrs = null;

                /*신청자 장비 미반납 알림 메일 및 SMS 발송*/

                String appeno = mailNoReturnTargetList.get(i).getAPPENO();
                String appenm = mailNoReturnTargetList.get(i).getAPPENM();
                String enddt = mailNoReturnTargetList.get(i).getENDDT().substring(0, 4) + "." + mailNoReturnTargetList.get(i).getENDDT().substring(4, 6) + "." + mailNoReturnTargetList.get(i).getENDDT().substring(6, 8);
                String[] eqaliasArr = mailNoReturnTargetList.get(i).getEQALIAS().split(",");

                if(!StringUtils.isEmpty(appeno)){

                    addrs = new HashMap<String, String>();
                    addrs.put("email", appeno + "@kepco.co.kr");
                    toAddrs = CommonUtil.mapToAddresses(addrs);

                    try {
                        /*신청자 알림메일 발송*/
                        sd.sendMail(toAddrs, appno, "info", "", "[신청자  멀티미디어 대여 미반납 알림] "+appenm+"님께서 대여하신 설비가 반납되지 않았음을 알려드립니다.");
                        outMailRemainString = "As the data, appno is " + appno + ", [APPENO] The alarm mail of no returned equips is sent successfully.";
                    } catch (Exception e) {
                        e.printStackTrace();
                        outMailRemainString = "As the data, appno is " + appno + ", [APPENO] The alarm mail of no returned equips is failed and happended the problem";
                    }

                    String msg = "[설비대여미반납알림] "+appenm+"님께서 대여하신 설비를 반납해주시기 바랍니다.";
                    
                    List<RentDto> cellNoList = new ArrayList<RentDto>();
                    RentDto tmpDto = new RentDto();
                    tmpDto.setHp(mailNoReturnTargetList.get(i).getAPPHP());
                    cellNoList.get(i).setHp(mailNoReturnTargetList.get(i).getAPPHP());
                    cellNoList.add(tmpDto);
                    try {
                        if(cellNoList.size() > 0){
                            ss.rentalRequireSMS(new BigInteger(DateUtil.getCurrentDateTime()), Integer.parseInt(appno), msg, cellNoList);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (Exception e) {
                e.printStackTrace();
        } finally {
            
            System.out.println("#######################sendNoReturnMail() end#######################");
            System.out.println(DateUtil.getCurrentDateTime() + "::::" + outMailRemainString);
            System.out.println("#######################sendNoReturnMail() end#######################");
        }
    }
    
    
    
    
}
