package kr.co.neodreams.multi_user.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.CommonUtil;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.dto.BoardDto;
import kr.co.neodreams.multi_user.dto.OaDto;
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

        calendar.add(Calendar.DAY_OF_MONTH, temp);

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
    	
        // 이번 주 예약 추출
        Map<String, String> rsrvMap = new HashMap<String, String>();
        Map<String, String> idMap = new HashMap<String, String>();
        
        // 예약 추출을 yyyyMMddHH24 형식의 key로 저장하면 containKey로 찾을 수 있음.
        OaDto dto = new OaDto();
        dto.setDate(date);
        
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
			
			// 검색 조건에서 출력 타입
			if (commonDto.getSts2() != null || commonDto.getSts3() != null || commonDto.getSts4() != null || commonDto.getSts5() != null)
			{
				List<String> arrList = new ArrayList<String>();
				if (commonDto.getSts2() != null)
					arrList.add("'"+commonDto.getSts2()+"'");
				if (commonDto.getSts3() != null)
					arrList.add("'"+commonDto.getSts3()+"'");
				if (commonDto.getSts4() != null)
					arrList.add("'"+commonDto.getSts4()+"'");
				if (commonDto.getSts5() != null)
					arrList.add("'"+commonDto.getSts5()+"'");

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
	 * 사진촬영 리스트 조회
	 * 
	 * @param commonDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/photolist.do")
	public ModelAndView photolist(BoardDto commonDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			
			List<BoardDto> noticeList = null;
			
			int totalCnt = 0;
			commonDto.setBbsid("10029");		// 사진촬영

			noticeList = boardService.getSelectBoardList(commonDto);
			totalCnt = boardService.getSelectBoardListCnt(commonDto);
			
			mv.setViewName("/oa/reqList");
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
	 * 게시글 작성 폼을 보여준다. 
	 * 
	 * @param bbsid
	 * @param request
	 * @return
	 */
	@RequestMapping("/reqWrite.do")
	public ModelAndView reqWrite(@RequestParam String bbsid, @RequestParam String categ, HttpServletRequest request)
	{
		ModelAndView mv = new ModelAndView();
		BoardDto commonDto = new BoardDto();
		
		mv.addObject("bbsid", bbsid);
		mv.addObject("menu_depth1", "2");
		if (bbsid.equals("10028"))		// 출력요청
		{
			mv.addObject("menu_depth2", "4");
			mv.addObject("title", "출력요청");
		}else if(bbsid.equals("10029"))	// 사진촬영
		{
			mv.addObject("menu_depth2", "5");
			mv.addObject("title", "사진촬영");
		}
				
		mv.addObject("commonDto", commonDto);
		mv.addObject("paging", commonDto);
		mv.setViewName("/oa/reqWrite");
		
		return mv;
	}	
	
	/**
	 * 게시판 상세 보기
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/reqsDetail.do")
	public ModelAndView reqsDetail(HttpServletRequest req, HttpServletResponse res, BoardDto boardDto) throws Exception{
		ModelAndView mv = new ModelAndView();
		String bbsid = boardDto.getBbsid();
		int pageNo = boardDto.getPageNo(); 
		
		mv.addObject("bbsid", bbsid);
		mv.addObject("menu_depth1", "2");
		if (bbsid.equals("10028"))		// 출력요청
		{
			mv.addObject("menu_depth2", "4");
			mv.addObject("title", "출력요청");
		}else if(bbsid.equals("10029"))	// 사진촬영
		{
			mv.addObject("menu_depth2", "5");
			mv.addObject("title", "사진촬영");
		}
		
		BoardDto dto = boardService.getSelectBoardDetail(boardDto);
		dto.setPageNo(pageNo);
		mv.addObject("boardInfo", dto);
		mv.addObject("paging", dto);
		
		// 게시글 조회수증가 
		int result = boardService.boardHitUpdate(boardDto);
		
		mv.setViewName("/oa/reqView");
		
		return mv;
	}	
	
	/**
	 * 게시글 수정 폼을 출력한다.
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/reqUpdate.do")
	public ModelAndView reqUpdate(HttpServletRequest req, HttpServletResponse res, BoardDto boardDto) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		String bbsid = boardDto.getBbsid();
		int pageNo = boardDto.getPageNo(); 
		
		mv.addObject("bbsid", bbsid);
		mv.addObject("menu_depth1", "2");
		if (bbsid.equals("10028"))		// 출력요청
		{
			mv.addObject("menu_depth2", "4");
			mv.addObject("title", "출력요청");
		}else if(bbsid.equals("10029"))	// 사진촬영
		{
			mv.addObject("menu_depth2", "5");
			mv.addObject("title", "사진촬영");
		}
		
		mv.setViewName("/oa/reqModify");
		BoardDto resultDetail = new BoardDto();
		resultDetail = boardService.getSelectBoardDetail(boardDto);
		resultDetail.setPageNo(pageNo);
		mv.addObject("resultDetail", resultDetail);
		mv.addObject("paging", boardDto);
		return mv;
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
	@RequestMapping("/reqStsUpdate.do")
	public void bbsUpdate(HttpServletRequest req, HttpServletResponse res, BoardDto boardDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			retVal = Integer.toString(boardService.boardStsUpdate(boardDto));
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}	
}
