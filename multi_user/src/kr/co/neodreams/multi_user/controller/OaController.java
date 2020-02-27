package kr.co.neodreams.multi_user.controller;

import java.io.File;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.Address;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.CommonUtil;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.DateUtil;
import kr.co.neodreams.multi_user.common.ExcelUtil;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.common.mail.MailUtil;
import kr.co.neodreams.multi_user.dto.BoardDto;
import kr.co.neodreams.multi_user.dto.OaDto;
import kr.co.neodreams.multi_user.dto.PhotoReqDto;
import kr.co.neodreams.multi_user.dto.PrintReqDto;
import kr.co.neodreams.multi_user.service.BoardService;
import kr.co.neodreams.multi_user.service.OaService;
import kr.co.neodreams.multi_user.service.PrintReqService;

/**
 * OA 교육장 Controller Class
 * 
 * @author hist
 *
 */
@Controller
public class OaController extends BaseController{
	@Autowired
	DataSourceTransactionManager dataSourceTransactionManager;
	
	@Autowired
	OaService oaService;
	
	@Autowired
	BoardService boardService;	
	
	@Autowired
	PrintReqService prtService;
	
    @Resource(name = "commonUtil")
    private CommonUtil commonUtil;
    
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    
    /**
     * OA 교육장 신청 목록
     * 
     * @return
     */
    @RequestMapping("/oalist.do")
    public ModelAndView oaList(OaDto oaDto,  HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        
        String date = oaDto.getDate();	// 검색일자
        if (date == null || "".equals(date))
        {
        	
        }
        else
        	if (date.length() == 10) date = date.substring(0, 8);
        
        List<String> dateList = new ArrayList<String>();	// 주간일자 출력 리스트
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        Calendar calendar = Calendar.getInstance();

        int year = 0, month = 0, day = 0;
        
        // 기본 날짜 설정
        if (date == null || "".equals(date))
        {
        	year = calendar.get(Calendar.YEAR);
        	month = calendar.get(Calendar.MONTH) + 1;
        	day = calendar.get(Calendar.DAY_OF_MONTH);
        	date = year + String.format("%02d", month) + String.format("%02d", day);
        } else {
        	year = Integer.parseInt(date.substring(0, 4));
        	month = Integer.parseInt(date.substring(4, 6));
        	day = Integer.parseInt(date.substring(6, 8));
        }
        

        calendar.set(year, month-1, day);

        int todayWeek = calendar.get(Calendar.DAY_OF_WEEK);
        int temp = 0;

        // 월요일 날짜 구하기
        if (todayWeek == Calendar.TUESDAY) temp -= 1;
        else if (todayWeek == Calendar.WEDNESDAY) temp -= 2;
        else if (todayWeek == Calendar.THURSDAY) temp -= 3;
        else if (todayWeek == Calendar.FRIDAY) temp -= 4;
        else if (todayWeek == Calendar.SATURDAY) temp -= 5;
        else if (todayWeek == Calendar.SUNDAY) temp -= 6;

        calendar.add(Calendar.DAY_OF_MONTH, temp);	// 시작월요일

        String monDate = calendar.get(Calendar.YEAR) + String.format("%02d", (calendar.get(Calendar.MONTH) + 1)) + String.format("%02d", calendar.get(Calendar.DAY_OF_MONTH));
                
        // 주말을 제외한 주간일자를 구한다.
        for (int i = 0; i < 7; i++) {
        	if (i != 0) calendar.add(Calendar.DAY_OF_MONTH, 1);
        	int w = calendar.get(Calendar.DAY_OF_WEEK);
        	if (w == Calendar.SUNDAY || w == Calendar.SATURDAY) continue;
        	dateList.add(dateFormat.format(calendar.getTime()));
        }

        // 지난주, 다음주 구하기
        calendar.set(year, month-1, day);
        calendar.add(Calendar.DAY_OF_MONTH, -7);
        String pDate = calendar.get(Calendar.YEAR) + String.format("%02d", (calendar.get(Calendar.MONTH) + 1)) + String.format("%02d", calendar.get(Calendar.DAY_OF_MONTH));
        calendar.add(Calendar.DAY_OF_MONTH, 14);
        String nDate = calendar.get(Calendar.YEAR) + String.format("%02d", calendar.get(Calendar.MONTH) + 1) + String.format("%02d", calendar.get(Calendar.DAY_OF_MONTH));

    	Date today = new Date();
    	
    	String reserveInterval = dateFormat.format(today); // 당일까지만 예약가능.
    	
    	Calendar cal = Calendar.getInstance();
    	cal.setTime(today);
    	cal.add(Calendar.DATE, 14);
    	
    	String nextInterval = dateFormat.format(new Date(cal.getTimeInMillis()));
    	
        // 이번 주 예약 추출
        Map<String, String> rsrvMap = new HashMap<String, String>();
        Map<String, String> idMap = new HashMap<String, String>();
        
        // 예약 추출을 yyyyMMddHH24 형식의 key로 저장하면 containKey로 찾을 수 있음.
        OaDto dto = new OaDto();
        dto.setDate(monDate);   // 시작월요일부터
        System.out.println("monDate : " + monDate);
        System.out.println("date : " + date);
        //dto.setDate(date);
        
        List<OaDto> lst = oaService.getSelectOAList(dto);
        System.out.println("lst size : " + lst.size());
        for (int i=0; i<lst.size(); i++)
        {
        	OaDto to = (OaDto) lst.get(i);
        	rsrvMap.put(to.getRsrv_dt(), to.getSabun());
        	
        	idMap.put(to.getRsrv_dt(), String.valueOf(to.getRsrv_id()));		// 예약번호 저장
        }
                
        // 화면에 필요한 변수 설정
        mv.addObject("year",  	 year);
        mv.addObject("month", 	 month);
        mv.addObject("pDate", 	 pDate);
        mv.addObject("nDate", 	 nDate);
        mv.addObject("dateList", dateList);
        mv.addObject("reserveInterval", reserveInterval);
        mv.addObject("nextInterval", nextInterval);
        mv.addObject("rsrvMap",  rsrvMap);		// 예약현황
        mv.addObject("idMap",    idMap);		// 예약번호
        
        OaDto d = new OaDto();
        mv.addObject("oaDto", d);
        
        mv.setViewName("/oa/oalist");               
        
        return mv;
    }
    /**
     * OA 교육장 신청 폼 출력
     * 
     * @param oaDto
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/oaWrite.do")
    public ModelAndView oaWrite(HttpServletRequest req, HttpServletResponse res, OaDto oaDto) throws Exception {
        ModelAndView mv = new ModelAndView();
        System.out.println("oaWrite.do called..");
        String date = oaDto.getDate();	// 검색일자
        System.out.println("oaWrite.do called.."+date);
        String year = date.substring(0, 4);
        String month = String.valueOf(Integer.parseInt(date.substring(4, 6)));
        String day = String.valueOf(Integer.parseInt(date.substring(6, 8)));
        String time = String.valueOf(Integer.parseInt(date.substring(8, 10)));
        
        mv.addObject("date", date);		// 신청일시
        mv.addObject("month", month);
        mv.addObject("day", day);
        mv.addObject("time", time);
        mv.addObject("year", year);
        
        mv.setViewName("/oa/oaform");	
        System.out.println("oaWrite.do called..2");
        return mv;
    }
    
	/**
	 * OA교육장 신청을 접수한다. 
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/registOA.do")
	public void registOA(HttpServletRequest req, HttpServletResponse res, OaDto oaDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			oaDto.setSabun(SESS_EMPNO);
			oaDto.setRsrv_dt(oaDto.getDate());    // 예약일시
			String useTime = oaDto.getDate();
			
			int year = Integer.parseInt(useTime.substring(0, 4));
			int month = Integer.parseInt(useTime.substring(4, 6));
			int day = Integer.parseInt(useTime.substring(6, 8));
			int time = Integer.parseInt(useTime.substring(8, 10));
			
			// 이미 예약이 된 일시인지 확인한다.
			if (oaDto.getHour() == null || "".equals(oaDto.getHour()))
				oaDto.setHour("1");   // default 1 hour
			int j = Integer.parseInt(oaDto.getHour());
			
			if (j <= 0)
			{
				retVal = "예약 시간이 올바르지 않습니다!!!";
			}else {
				
				String[] hours = new String[j];
				for (int i=0; i<j; i++)
				{
					int t = time + i;
					hours[i] = String.valueOf(year) + String.format("%02d", month) + String.format("%02d", day) + String.format("%02d", t);
				}
				StringBuilder sb = new StringBuilder();
				sb.append("'");
				for (String h: hours)
				{
					sb.append(h).append("', '");
				}
				sb.delete(sb.length()-2, sb.length());   // 마지막 , 제거
				
				// 이미 예약되어 있는지 확인한다.
				int rsvCnt = oaService.oaRsvCheckSelect(sb.toString());
				
				if (rsvCnt > 0)
				{
					retVal = "-2";
				}else {
					for (String h: hours) {
						oaDto.setRsrv_dt(h);
						System.out.println("subject : " + oaDto.getSubject());
						retVal = Integer.toString(oaService.oaInsert(oaDto));
						System.out.println("retVal : " + retVal);					
					}
					dataSourceTransactionManager.commit(status);
					retVal = "1";
					// 신청이 완료되면 메일을 보내야 한다.
					// itplazza@kepco.co.kr, "IT플라자"
					// title : OA교육장 이용신청
					// content : year + "년 " + month + "월 " + day + "일 " + time + "시 ~ "+(time + j)+"시<br><br>" + subject.replaceAll("\n", "<br>");
					Address[] toAddrs = new Address[1];
					InternetAddress address = new InternetAddress(Constants.ADMIN_EMAIL);		// 받는 사람 (관리자)
					toAddrs[0] = address;
					String mailSubject = "OA교육장 이용신청";
					String mailContent = year + "년 " + month + "월 " + day + "일 " + time + "시 ~ "+(time + j)+"시<br><br>" + oaDto.getSubject().replaceAll("\n", "<br>");
					
					String mailFrom = SESS_EMPNO + "@kepco.co.kr";		// 보내는 사람
					
					MailUtil.sendMail(toAddrs, mailFrom, mailSubject, mailContent);					
				}
			}
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	} 
	/**
	 * OA 신청내역 상세 보기
	 * 
	 * @param oaDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
    @RequestMapping("/oaView.do")
    public ModelAndView oaView(OaDto oaDto,  HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
  
        System.out.println("oaView called [rsrv_key] : " + oaDto.getRsrv_id());
        OaDto dto = oaService.getSelectOADetail(oaDto);

        String date = dto.getRsrv_dt();		// 예약일시
        System.out.println("oaView.do called.."+date);
        String year = date.substring(0, 4);
        String month = String.valueOf(Integer.parseInt(date.substring(4, 6)));
        String day = String.valueOf(Integer.parseInt(date.substring(6, 8)));
        String time = String.valueOf(Integer.parseInt(date.substring(8, 10)));
        
        dto.setSubject(dto.getSubject().replaceAll("\n", "<br/>"));
        
        mv.addObject("date", date);		// 신청일시
        mv.addObject("month", month);
        mv.addObject("day", day);
        mv.addObject("time", time);
        mv.addObject("year", year);
        
        mv.addObject("oaDto", dto);
        mv.addObject("paging", oaDto);
        
        mv.setViewName("/oa/oaview");               
        
        return mv;
    }	
    
	/**
	 * OA교육장 신청을 취소한다.
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/deleteOA.do")
	public void deleteOA(HttpServletRequest req, HttpServletResponse res, OaDto oaDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{

			retVal = Integer.toString(oaService.oaCancel(oaDto));
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}     
	
	/**
	 * OA교육장 신청을 승인처리한다
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/applyOA.do")
	public void applyOA(HttpServletRequest req, HttpServletResponse res, OaDto oaDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{

			oaDto.setAdmin_id(SESS_EMPNO);		// 승인자
			oaDto.setMemo("");
			retVal = Integer.toString(oaService.oaApply(oaDto));
			dataSourceTransactionManager.commit(status);
			
			// 세부정보 조회
	        OaDto dto = oaService.getSelectOADetail(oaDto);

	        String date = dto.getRsrv_dt();		// 예약일시
	        System.out.println("oaView.do called.."+date);
	        String year = date.substring(0, 4);
	        String month = String.valueOf(Integer.parseInt(date.substring(4, 6)));
	        String day = String.valueOf(Integer.parseInt(date.substring(6, 8)));
	        String time = String.valueOf(Integer.parseInt(date.substring(8, 10)));
	        int j = Integer.parseInt(oaDto.getHour());
	        
	        SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
	        Date dt = new Date();
	        String time1 = format1.format(dt);
			// 승인완료 메일을 보내야 한다.
			// 신청이 완료되면 메일을 보내야 한다.
			// itplazza@kepco.co.kr, "IT플라자"
			// title : OA교육장 이용신청
			// content : year + "년 " + month + "월 " + day + "일 " + time + "시 ~ "+(time + j)+"시<br><br>" + subject.replaceAll("\n", "<br>");
			Address[] toAddrs = new Address[1];
			InternetAddress address = new InternetAddress(SESS_EMPNO + "@kepco.co.kr");		// 받는 사람 (작성자) 
			toAddrs[0] = address;
			String mailSubject = "OA교육장 이용신청[승인완료]";
			String mailContent = year + "년 " + month + "월 " + day + "일 " + time + "시 ~ "+(time + j)+"시<br><br>" + oaDto.getSubject().replaceAll("\n", "<br>");
				   mailContent += "승인일자 : " + time1;
			
			String mailFrom = Constants.ADMIN_EMAIL; 		// 보내는 사람 ( 관리자)
			
			MailUtil.sendMail(toAddrs, mailFrom, mailSubject, mailContent);		
			
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}     	
	
	/**
	 * 출력 요청 리스트 조회
	 * 
	 * @param commonDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/printlist.do")
	public ModelAndView printlist(PrintReqDto commonDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			
			List<PrintReqDto> noticeList = null;
			
			int totalCnt = 0;
			commonDto.setBbsid("10028");		// 플로터출력
			commonDto.setReg_id("");            // mypage에서 활용함(검색조건으로)
			System.out.println("sts1 : " + commonDto.getSts1());
			System.out.println("sts2 : " + commonDto.getSts2());
			System.out.println("sts3 : " + commonDto.getSts3());
			System.out.println("sts4 : " + commonDto.getSts4());
			System.out.println("sts5 : " + commonDto.getSts5());
			
			// 검색 조건에서 출력 타입
			if (!CommonUtil.isNull(commonDto.getSts2()).equals("") || !CommonUtil.isNull(commonDto.getSts3()).equals("") || 
					!CommonUtil.isNull(commonDto.getSts4()).equals("") || !CommonUtil.isNull(commonDto.getSts5()).equals(""))
			{
				List<String> arrList = new ArrayList<String>();
				if (!CommonUtil.isNull(commonDto.getSts2()).equals(""))
					arrList.add("'"+commonDto.getSts2()+"'");
				if (!CommonUtil.isNull(commonDto.getSts3()).equals(""))
					arrList.add("'"+commonDto.getSts3()+"'");
				if (!CommonUtil.isNull(commonDto.getSts4()).equals(""))
					arrList.add("'"+commonDto.getSts4()+"'");
				if (!CommonUtil.isNull(commonDto.getSts5()).equals(""))
					arrList.add("'"+commonDto.getSts5()+"'");

				commonDto.setStsList(arrList);
			}else {
				commonDto.setSts1("ALL");   // default 검색 조건
				List<String> arrList = new ArrayList<String>();
				commonDto.setStsList(arrList);
			}

			noticeList = prtService.getPrintList(commonDto);
			totalCnt = prtService.getPrintListCnt(commonDto);
			
			mv.setViewName("/oa/printList");
			mv.addObject("noticeList", noticeList);
			
			mv.addObject("bbsid", "10028");
			mv.addObject("menu_depth1", "2");
			mv.addObject("menu_depth2", "4");
			mv.addObject("title", "플로터출력");
			//페이징처리
			mv.addObject("totalCnt", totalCnt);
			mv.addObject("paging", commonDto);
					
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}	
		return mv;
	} 
	
	/**
	 * 플로터 출력 처리내역을 엑셀로 다운로드 받는다.
	 * 
	 * @param commonDto
	 * @param result
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/printExcelDownload.do")
	public @ResponseBody byte[] printExcelDownload(PrintReqDto commonDto, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setHeader("Set-Cookie", "fileDownload=true); path=/");
		
		int totalCnt = 0;
		commonDto.setBbsid("10028");		// 플로터출력
		commonDto.setReg_id("");            // mypage에서 활용함(검색조건으로)
		System.out.println("sts1 : " + commonDto.getSts1());
		System.out.println("sts2 : " + commonDto.getSts2());
		System.out.println("sts3 : " + commonDto.getSts3());
		System.out.println("sts4 : " + commonDto.getSts4());
		System.out.println("sts5 : " + commonDto.getSts5());
		
		// 검색 조건에서 출력 타입
		if (!CommonUtil.isNull(commonDto.getSts2()).equals("") || !CommonUtil.isNull(commonDto.getSts3()).equals("") || 
				!CommonUtil.isNull(commonDto.getSts4()).equals("") || !CommonUtil.isNull(commonDto.getSts5()).equals(""))
		{
			List<String> arrList = new ArrayList<String>();
			if (!CommonUtil.isNull(commonDto.getSts2()).equals(""))
				arrList.add("'"+commonDto.getSts2()+"'");
			if (!CommonUtil.isNull(commonDto.getSts3()).equals(""))
				arrList.add("'"+commonDto.getSts3()+"'");
			if (!CommonUtil.isNull(commonDto.getSts4()).equals(""))
				arrList.add("'"+commonDto.getSts4()+"'");
			if (!CommonUtil.isNull(commonDto.getSts5()).equals(""))
				arrList.add("'"+commonDto.getSts5()+"'");

			commonDto.setStsList(arrList);
		}else {
			commonDto.setSts1("ALL");   // default 검색 조건
			List<String> arrList = new ArrayList<String>();
			commonDto.setStsList(arrList);
		}
		
		List<PrintReqDto> exList = prtService.getPrintList(commonDto);
		totalCnt = prtService.getPrintListCnt(commonDto);
		// Excel 세팅
		List<Object> header = new ArrayList<Object>();
		List<List<Object>> data = new ArrayList<List<Object>>();
		
		String[] keyVal = {"번호", "제목", "출력종류", "신청자", "요청일", "완료일", "상태"};
		String tmpDateTime = "";
		
		try {
			// Row 생성  Loop
			for (int i=0; i<keyVal.length; i++) header.add(keyVal[i]);
			
			for (int r=0; r<exList.size(); r++)
			{
				PrintReqDto map = exList.get(r);
				
				List<Object> obj = new ArrayList<Object>();
				// ${totalCnt - (paging.perPageCnt*(paging.pageNo-1)) - status.index }
				obj.add(String.valueOf( r+1 ) );  // 순번
				obj.add(map.getSubject());
				obj.add(map.getReq_type_nm());
				obj.add(map.getReg_nm());
				obj.add(map.getPrt_req_dt());
				obj.add(map.getAprv_dt() == null ? "" : map.getAprv_dt());
				obj.add(map.getAprv_status_nm());
				
				data.add(obj);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		ExcelUtil excel = new ExcelUtil(header ,data);
		excel.setSheetName("sheet1");
		excel.setWidth(6000);
		
		byte[] bytes = excel.makeExcel();
		
        String userAgent = request.getHeader("User-Agent");
        boolean br = userAgent.indexOf("Chrome") > -1;
        
        String fileName = "플로터출력처리내역_" + DateUtil.getCurrentDateTime();
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
	
	/**
	 * 플로터 출력 요청 폼 
	 * 
	 * @param commonDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/printWrite.do")
	public ModelAndView printWrite(PrintReqDto commonDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			int totalCnt = 0;
			commonDto.setBbsid("10028");		// 플로터출력

			mv.setViewName("/oa/printWrite");

			mv.addObject("bbsid", "10028");
			mv.addObject("menu_depth1", "2");
			mv.addObject("menu_depth2", "4");
			mv.addObject("title", "플로터출력");
			mv.addObject("paging", commonDto);
			
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}	
		return mv;
	} 
	
	/**
	 * 플로터 출력요청을 저장한다.
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/registPrint.do")
	public void registPrint(HttpServletRequest req, HttpServletResponse res, PrintReqDto dto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			// IP
			String ip = req.getRemoteAddr();
			dto.setReg_ip(ip);
			retVal = Integer.toString(prtService.printInsert(dto));
			System.out.println("retVal : " + retVal);
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}
	
	/**
	 * 플로터 출력요청 상세 보기
	 * 
	 * @param req
	 * @param res
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/printDetail.do")
	public ModelAndView printDetail(HttpServletRequest req, HttpServletResponse res, PrintReqDto dto) throws Exception{
		ModelAndView mv = new ModelAndView();
		String bbsid = dto.getBbsid();
		int pageNo = dto.getPageNo(); 
		
		mv.addObject("bbsid", bbsid);
		mv.addObject("menu_depth1", "2");
		mv.addObject("menu_depth2", "4");
		mv.addObject("title", "플로터출력");
		
		System.out.println("seq : " + dto.getSeq());

		PrintReqDto detailDto = prtService.getPrintReqDetail(dto);
		dto.setPageNo(pageNo);
		mv.addObject("boardInfo", detailDto);
		mv.addObject("paging", dto);
		System.out.println("pageNo : " + pageNo);
		mv.setViewName("/oa/printView");
		
		return mv;
	}
	
	/**
	 * 플로터 출력요청 수정 폼을 출력한다.
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/printUpdate.do")
	public ModelAndView printUpdate(HttpServletRequest req, HttpServletResponse res, PrintReqDto dto) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		String bbsid = dto.getBbsid();
		int pageNo = dto.getPageNo(); 
		
		mv.addObject("bbsid", bbsid);
		mv.addObject("menu_depth1", "2");
		mv.addObject("menu_depth2", "4");
		mv.addObject("title", "출력요청");

		mv.setViewName("/oa/printModify");
		PrintReqDto resultDetail = new PrintReqDto();
		resultDetail = prtService.getPrintReqDetail(dto);
		
		resultDetail.setPageNo(pageNo);
		mv.addObject("resultDetail", resultDetail);
		mv.addObject("paging", dto);
		return mv;
	}	
	
	/**
	 * 플로터 출력요청 수정하기 
	 * 
	 * @param req
	 * @param res
	 * @param noticeDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/printUpdateSave.do")
	public void printUpdateSave(HttpServletRequest req, HttpServletResponse res, PrintReqDto dto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{			
			retVal = Integer.toString(prtService.printUpdate(dto));
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}
	
	/**
	 * 관리자 상태값 수정하기 
	 * 
	 * @param req
	 * @param res
	 * @param noticeDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/printStsUpdate.do")
	public void printStsUpdate(HttpServletRequest req, HttpServletResponse res, PrintReqDto dto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			String ip = req.getRemoteAddr();
			dto.setAprv_ip(ip);
			dto.setAprv_id(SESS_EMPNO);
			retVal = Integer.toString(prtService.printUpdateSts(dto));
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			System.out.println(e.toString());
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}	
	
	/**
	 * 플로터 출력요청 상세 보기에서 게시글을 삭제한다. (신청취소상태로 전환)
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/deletePrint.do")
	public void deletePrint(HttpServletRequest req, HttpServletResponse res, PrintReqDto boardDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			int fileChk = fileDelete(boardDto);
			
			if(fileChk > 0) {
				//retVal = Integer.toString(prtService.printFileDelete(boardDto));
				retVal = Integer.toString(prtService.printDelete(boardDto));
			}else {
				throw new Exception("-1"); 
			}
			
			
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}	
	
	/**
	 * 물리적인 파일을 삭제한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int fileDelete(PrintReqDto dto) throws Exception{
		int retVal = 0;
		
		try {
			List<PrintReqDto> boardList = new ArrayList<>();
			boardList = prtService.garbageAttatch(dto);
			
			for(int i=0; i < boardList.size(); i++) {
				PrintReqDto getFileDto = new PrintReqDto();
				
				getFileDto = boardList.get(i);
				
				if(!"".equals(getFileDto.getPhy_path())){
					File file = new File(getFileDto.getPhy_path());
					if(file.exists()) {
						file.delete();
					}
				}
			}	
			retVal = 1;
		}catch(Exception e) {
			retVal = -1;
		}	
		return retVal;
	}	
	
	/**
	 * 사진촬영 리스트 조회
	 * 
	 * @param commonDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/photolist.do")
	public ModelAndView photolist(PhotoReqDto commonDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			
			List<PhotoReqDto> noticeList = null;
			
			int totalCnt = 0;
			commonDto.setBbsid("10029");		// 사진촬영

			// 검색 조건에서 출력 타입
			if (!CommonUtil.isNull(commonDto.getSts2()).equals("") || !CommonUtil.isNull(commonDto.getSts3()).equals("") || 
					!CommonUtil.isNull(commonDto.getSts4()).equals("") || !CommonUtil.isNull(commonDto.getSts5()).equals(""))
			{
				List<String> arrList = new ArrayList<String>();
				if (!CommonUtil.isNull(commonDto.getSts2()).equals(""))
					arrList.add("'"+commonDto.getSts2()+"'");
				if (!CommonUtil.isNull(commonDto.getSts3()).equals(""))
					arrList.add("'"+commonDto.getSts3()+"'");
				if (!CommonUtil.isNull(commonDto.getSts4()).equals(""))
					arrList.add("'"+commonDto.getSts4()+"'");
				if (!CommonUtil.isNull(commonDto.getSts5()).equals(""))
					arrList.add("'"+commonDto.getSts5()+"'");

				commonDto.setStsList(arrList);
			}else {
				commonDto.setSts1("ALL");   // default 검색 조건
				List<String> arrList = new ArrayList<String>();
				commonDto.setStsList(arrList);
			}
			
			noticeList = prtService.getPhotoList(commonDto);
			totalCnt = prtService.getPhotoListCnt(commonDto);
			
			mv.setViewName("/oa/photoList");
			mv.addObject("noticeList", noticeList);
			
			mv.addObject("bbsid", "10029");
			mv.addObject("menu_depth1", "2");
			mv.addObject("menu_depth2", "5");
			mv.addObject("title", "사진촬영");
			//페이징처리
			mv.addObject("totalCnt", totalCnt);
			mv.addObject("paging", commonDto);
			
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}	
		return mv;
	} 
	
	
	/**
	 * 사진촬영 출력 처리내역을 엑셀로 다운로드 받는다.
	 * 
	 * @param commonDto
	 * @param result
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/photoExcelDownload.do")
	public @ResponseBody byte[] photoExcelDownload(PhotoReqDto commonDto, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setHeader("Set-Cookie", "fileDownload=true); path=/");
		
		int totalCnt = 0;
		commonDto.setBbsid("10029");		// 사진촬영
		commonDto.setReg_id("");            // mypage에서 활용함(검색조건으로)
		System.out.println("sts1 : " + commonDto.getSts1());
		System.out.println("sts2 : " + commonDto.getSts2());
		System.out.println("sts3 : " + commonDto.getSts3());
		System.out.println("sts4 : " + commonDto.getSts4());
		System.out.println("sts5 : " + commonDto.getSts5());
		
		// 검색 조건에서 출력 타입
		if (!CommonUtil.isNull(commonDto.getSts2()).equals("") || !CommonUtil.isNull(commonDto.getSts3()).equals("") || 
				!CommonUtil.isNull(commonDto.getSts4()).equals("") || !CommonUtil.isNull(commonDto.getSts5()).equals(""))
		{
			List<String> arrList = new ArrayList<String>();
			if (!CommonUtil.isNull(commonDto.getSts2()).equals(""))
				arrList.add("'"+commonDto.getSts2()+"'");
			if (!CommonUtil.isNull(commonDto.getSts3()).equals(""))
				arrList.add("'"+commonDto.getSts3()+"'");
			if (!CommonUtil.isNull(commonDto.getSts4()).equals(""))
				arrList.add("'"+commonDto.getSts4()+"'");
			if (!CommonUtil.isNull(commonDto.getSts5()).equals(""))
				arrList.add("'"+commonDto.getSts5()+"'");

			commonDto.setStsList(arrList);
		}else {
			commonDto.setSts1("ALL");   // default 검색 조건
			List<String> arrList = new ArrayList<String>();
			commonDto.setStsList(arrList);
		}
		
		List<PhotoReqDto> exList = prtService.getPhotoList(commonDto);
		// Excel 세팅
		List<Object> header = new ArrayList<Object>();
		List<List<Object>> data = new ArrayList<List<Object>>();
		
		String[] keyVal = {"번호", "제목", "사진종류", "신청자", "요청일", "완료일", "상태"};
		String tmpDateTime = "";
		
		try {
			// Row 생성  Loop
			for (int i=0; i<keyVal.length; i++) header.add(keyVal[i]);
			
			for (int r=0; r<exList.size(); r++)
			{
				PhotoReqDto map = exList.get(r);
				
				List<Object> obj = new ArrayList<Object>();
				// ${totalCnt - (paging.perPageCnt*(paging.pageNo-1)) - status.index }
				obj.add(String.valueOf( r+1 ) );  // 순번
				obj.add(map.getSubject());
				obj.add(map.getReq_type_nm());
				obj.add(map.getReg_nm());
				obj.add(map.getPrt_req_dt());
				obj.add(map.getAprv_dt() == null ? "" : map.getAprv_dt());
				obj.add(map.getAprv_status_nm());
				
				data.add(obj);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		ExcelUtil excel = new ExcelUtil(header ,data);
		excel.setSheetName("sheet1");
		excel.setWidth(6000);
		
		byte[] bytes = excel.makeExcel();
		
        String userAgent = request.getHeader("User-Agent");
        boolean br = userAgent.indexOf("Chrome") > -1;
        
        String fileName = "사진촬영처리내역_" + DateUtil.getCurrentDateTime();
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
	/**
	 * 사진촬영 작성 폼을 보여준다. 
	 * 
	 * @param bbsid
	 * @param request
	 * @return
	 */
	@RequestMapping("/photoWrite.do")
	public ModelAndView photoWrite(PhotoReqDto commonDto, HttpServletRequest request)
	{
		ModelAndView mv = new ModelAndView();
		
		try{
			commonDto.setBbsid("10029");		// 사진촬영

			mv.setViewName("/oa/photoWrite");

			mv.addObject("bbsid", "10029");
			mv.addObject("menu_depth1", "2");
			mv.addObject("menu_depth2", "5");
			mv.addObject("title", "사진촬영");
			mv.addObject("paging", commonDto);
			
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}	
		return mv;
	}	
	
	
	/**
	 * 사진촬영 출력요청을 저장한다.
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/registPhoto.do")
	public void registPhoto(HttpServletRequest req, HttpServletResponse res, PhotoReqDto dto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			// IP
			String ip = req.getRemoteAddr();
			dto.setReg_ip(ip);
			retVal = Integer.toString(prtService.photoInsert(dto));
			System.out.println("retVal : " + retVal);
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}
		
	/**
	 * 촬영요청 상세 보기
	 * 
	 * @param req
	 * @param res
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/photoDetail.do")
	public ModelAndView photoDetail(HttpServletRequest req, HttpServletResponse res, PhotoReqDto dto) throws Exception{
		ModelAndView mv = new ModelAndView();
		String bbsid = dto.getBbsid();
		int pageNo = dto.getPageNo(); 
		
		mv.addObject("bbsid", bbsid);
		mv.addObject("menu_depth1", "2");
		mv.addObject("menu_depth2", "5");
		mv.addObject("title", "사진촬영");
		
		System.out.println("seq : " + dto.getSeq());

		PhotoReqDto detailDto = prtService.getPhotoReqDetail(dto);
		dto.setPageNo(pageNo);
		mv.addObject("boardInfo", detailDto);
		mv.addObject("paging", dto);
		System.out.println("pageNo : " + pageNo);
		mv.setViewName("/oa/photoView");
		
		return mv;
	}
	
	/**
	 * 촬영요청 수정 폼을 출력한다.
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/photoUpdate.do")
	public ModelAndView photoUpdate(HttpServletRequest req, HttpServletResponse res, PhotoReqDto dto) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		String bbsid = dto.getBbsid();
		int pageNo = dto.getPageNo(); 
		
		mv.addObject("bbsid", bbsid);
		mv.addObject("menu_depth1", "2");
		mv.addObject("menu_depth2", "5");
		mv.addObject("title", "사진촬영");

		mv.setViewName("/oa/photoModify");
		PhotoReqDto resultDetail = new PhotoReqDto();
		resultDetail = prtService.getPhotoReqDetail(dto);
		
		resultDetail.setPageNo(pageNo);
		mv.addObject("resultDetail", resultDetail);
		mv.addObject("paging", dto);
		return mv;
	}	
	
	/**
	 * 촬영요청 수정하기 
	 * 
	 * @param req
	 * @param res
	 * @param noticeDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/photoUpdateSave.do")
	public void photoUpdateSave(HttpServletRequest req, HttpServletResponse res, PhotoReqDto dto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{			
			retVal = Integer.toString(prtService.photoUpdate(dto));
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}
	
	/**
	 * 관리자 상태값 수정하기 
	 * 
	 * @param req
	 * @param res
	 * @param noticeDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/photoStsUpdate.do")
	public void photoStsUpdate(HttpServletRequest req, HttpServletResponse res, PhotoReqDto dto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			String ip = req.getRemoteAddr();
			dto.setAprv_ip(ip);
			dto.setAprv_id(SESS_EMPNO);
			retVal = Integer.toString(prtService.photoUpdateSts(dto));
			dataSourceTransactionManager.commit(status);
			
			System.out.println("result sts : " + retVal);
		}catch (Exception e) {
			System.out.println(e.toString());
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}	
	
	/**
	 * 촬영요청 상세 보기에서 게시글을 삭제한다. 
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/deletePhoto.do")
	public void deletePhoto(HttpServletRequest req, HttpServletResponse res, PhotoReqDto boardDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			retVal = Integer.toString(prtService.photoDelete(boardDto));
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}	
	
	/**
	 * 사용자 찾기 팝업
	 * 
	 * @param commonDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping("/commonUserSearch.do")
	public ModelAndView commonUserSearch(PrintReqDto commonDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			System.out.println("popup start...");			
			List<HashMap> userList = prtService.getUserSearch(commonDto);
			
			mv.setViewName("/oa/userSearch");
			mv.addObject("noticeList", userList);
			System.out.println("popup end...");
					
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}	
		return mv;
	} 
		
	
}
