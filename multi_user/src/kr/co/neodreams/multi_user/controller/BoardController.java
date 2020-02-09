package kr.co.neodreams.multi_user.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.CommonUtil;
import kr.co.neodreams.multi_user.common.DownloadView;
import kr.co.neodreams.multi_user.dto.BoardDto;
import kr.co.neodreams.multi_user.service.BoardService;

/**
 * S/W 라이센스, 다운로드 게시판 처리 Controller
 * @author minso
 *
 */
@Controller
public class BoardController extends BaseController{
	@Autowired
	DataSourceTransactionManager dataSourceTransactionManager;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	DownloadView dowoloadView;
	
    @Resource(name = "commonUtil")
    private CommonUtil commonUtil;
    
    protected Logger log = LoggerFactory.getLogger(this.getClass()); 
    
	/**
	 * S/W 라이센스 리스트
	 * @return
	 */
    @RequestMapping("/swlicense.do")
    public ModelAndView equipManual() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/board/license");
        return mv;
    }
    
    /**
     * OA 교육장
     * @return
     */
    @RequestMapping("/oalist.do")
    public ModelAndView oaList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/board/oalist");
        return mv;
    }
    
	/**
	 * 다운로드 > 공개소프트웨어 리스트 조회 
	 * 
	 * @param commonDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/publicsw.do")
	public ModelAndView publicswBoard(BoardDto commonDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			
			List<BoardDto> noticeList = null;
			
			int totalCnt = 0;
			commonDto.setBbsid("10022");		// 공개소프트웨어

			noticeList = boardService.getSelectBoardList(commonDto);
			totalCnt = boardService.getSelectBoardListCnt(commonDto);
			
			mv.setViewName("/board/publicswboard");
			
			mv.addObject("noticeList", noticeList);			
			//페이징처리
			mv.addObject("totalCnt", totalCnt);
			mv.addObject("paging",   commonDto);
			
			System.out.println("paging : " + commonDto.getPageNo());
			
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}	
		return mv;
	}    
    
	/**
	 * 다운로드 > 업무소프트웨어 리스트 조회 
	 * 
	 * @param commonDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/jobsw.do")
	public ModelAndView jobswBoard(BoardDto commonDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			
			List<BoardDto> noticeList = null;
			
			int totalCnt = 0;
			commonDto.setBbsid("10023");		// 업무소프트웨어

			noticeList = boardService.getSelectBoardList(commonDto);
			totalCnt = boardService.getSelectBoardListCnt(commonDto);
			
			mv.setViewName("/board/jobswboard");
			mv.addObject("noticeList", noticeList);
			
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
	 * 다운로드 > 드라이버 리스트 조회 
	 * 
	 * @param commonDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/driversw.do")
	public ModelAndView driverswBoard(BoardDto commonDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			
			List<BoardDto> noticeList = null;
			
			int totalCnt = 0;
			commonDto.setBbsid("10024");		// 드라이버

			noticeList = boardService.getSelectBoardList(commonDto);
			totalCnt = boardService.getSelectBoardListCnt(commonDto);
			
			mv.setViewName("/board/driverswboard");
			mv.addObject("noticeList", noticeList);
			
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
	 * 다운로드 > 패치/업데이트  리스트 조회 
	 * 
	 * @param commonDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/patchsw.do")
	public ModelAndView patchswBoard(BoardDto commonDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			
			List<BoardDto> noticeList = null;
			
			int totalCnt = 0;
			commonDto.setBbsid("10025");		// 패치/업데이트 

			noticeList = boardService.getSelectBoardList(commonDto);
			totalCnt = boardService.getSelectBoardListCnt(commonDto);
			
			mv.setViewName("/board/patchswboard");
			mv.addObject("noticeList", noticeList);
			
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
	 * 다운로드 > 멀티미디어  리스트 조회 
	 * 
	 * @param commonDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/multisw.do")
	public ModelAndView multiswBoard(BoardDto commonDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			
			List<BoardDto> noticeList = null;
			
			int totalCnt = 0;
			commonDto.setBbsid("10026");		// 멀티미디어 

			noticeList = boardService.getSelectBoardList(commonDto);
			totalCnt = boardService.getSelectBoardListCnt(commonDto);
			
			mv.setViewName("/board/multiswboard");
			mv.addObject("noticeList", noticeList);
			
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
	 * 다운로드 > 윈도우 10  리스트 조회 
	 * 
	 * @param commonDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/winsw.do")
	public ModelAndView winswBoard(BoardDto commonDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			
			List<BoardDto> noticeList = null;
			
			int totalCnt = 0;
			commonDto.setBbsid("10027");		// 윈도우 10 

			noticeList = boardService.getSelectBoardList(commonDto);
			totalCnt = boardService.getSelectBoardListCnt(commonDto);
			
			mv.setViewName("/board/winswboard");
			mv.addObject("noticeList", noticeList);
			
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
	 * 공통 통로를 통해서 게시판 리스트를 분할한다.
	 * 
	 * @param commonDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/bbsList.do")
	public ModelAndView bbsList(HttpServletRequest req, HttpServletResponse res, BoardDto boardDto) throws Exception{
	//public ModelAndView bbsList(@ModelAttribute BoardDto boardDto, ModelMap model) throws Exception{
		ModelAndView mv = new ModelAndView();
		String bbsid = boardDto.getBbsid();
		String url = null;
		
		System.out.println("bbsid : " + bbsid);
		
		if (bbsid.equals("10022"))		// 공개소프트웨어
		{
			url = "redirect:/publicsw.do";
		}else if(bbsid.equals("10023"))	// 업무소프트웨어
		{
			url = "redirect:/jobsw.do";
		}else if(bbsid.equals("10024"))	// 드라이버
		{
			url = "redirect:/driversw.do";
		}else if(bbsid.equals("10025"))	// 패치/업데이트
		{
			url = "redirect:/patchsw.do";
		}else if(bbsid.equals("10026"))	// 멀티미디어
		{
			url = "redirect:/multisw.do";
		}else if(bbsid.equals("10027"))	// 윈도우 10
		{
			url = "redirect:/winsw.do";
		}
		mv.setViewName(url);
		return mv;
	}
	
	/**
	 * 게시글 작성 폼을 보여준다. 
	 * 
	 * @param bbsid
	 * @param request
	 * @return
	 */
	@RequestMapping("/bbsWrite.do")
	public ModelAndView bbsWrite(@RequestParam String bbsid, HttpServletRequest request)
	{
		ModelAndView mv = new ModelAndView();
		BoardDto commonDto = new BoardDto();
		
		mv.addObject("bbsid", bbsid);
		mv.addObject("menu_depth1", "11");
		if (bbsid.equals("10022"))		// 공개소프트웨어
		{
			mv.addObject("menu_depth2", "1");
			mv.addObject("title", "공개소프트웨어");
		}else if(bbsid.equals("10023"))	// 업무소프트웨어
		{
			mv.addObject("menu_depth2", "2");
			mv.addObject("title", "업무소프트웨어");
		}else if(bbsid.equals("10024"))	// 드라이버
		{
			mv.addObject("menu_depth2", "3");
			mv.addObject("title", "드라이버");
		}else if(bbsid.equals("10025"))	// 패치/업데이트
		{
			mv.addObject("menu_depth2", "4");
			mv.addObject("title", "패치/업데이트");
		}else if(bbsid.equals("10026"))	// 멀티미디어
		{
			mv.addObject("menu_depth2", "5");
			mv.addObject("title", "멀티미디어");
		}else if(bbsid.equals("10027"))	// 윈도우 10
		{
			mv.addObject("menu_depth2", "6");
			mv.addObject("title", "윈도우 10");
		}
		
		
		mv.addObject("commonDto", commonDto);
		mv.addObject("paging", commonDto);
		mv.setViewName("/board/bbsWrite");
		
		return mv;
	}
	/**
	 * 게시글 작성을 저장한다.
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/registBoard.do")
	public void registBoard(HttpServletRequest req, HttpServletResponse res, BoardDto boardDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			boardDto.setWriter(SESS_USER_NAME);
			boardDto.setUserid(SESS_EMPNO);

			System.out.println(boardDto.toString());
			System.out.println("bbsid : " + boardDto.getBbsid());
			System.out.println("subject : " + boardDto.getSubject());
			System.out.println("content : " + boardDto.getContent());
			System.out.println("hit : " + boardDto.getHit());
			System.out.println("ip : " + boardDto.getIp());
			System.out.println("userid : " + boardDto.getUserid());
			System.out.println("notice : " + boardDto.getNotice());
			//seq,     bbsid,     writer,    subject,     content, 
			//hit,     wtime,     ip,        userid,      notice
			retVal = Integer.toString(boardService.boardInsert(boardDto));
			System.out.println("retVal : " + retVal);
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}
	
	@ResponseBody
	@RequestMapping("/boardDetail.do")
	public void boardDetail(HttpServletRequest req, HttpServletResponse res, BoardDto boardDto) throws Exception{
		ModelAndView mv = new ModelAndView();
		String bbsid = boardDto.getBbsid();
		
		mv.addObject("bbsid", bbsid);
		mv.addObject("menu_depth1", "11");
		if (bbsid.equals("10022"))		// 공개소프트웨어
		{
			mv.addObject("menu_depth2", "1");
			mv.addObject("title", "공개소프트웨어");
		}else if(bbsid.equals("10023"))	// 업무소프트웨어
		{
			mv.addObject("menu_depth2", "2");
			mv.addObject("title", "업무소프트웨어");
		}else if(bbsid.equals("10024"))	// 드라이버
		{
			mv.addObject("menu_depth2", "3");
			mv.addObject("title", "드라이버");
		}else if(bbsid.equals("10025"))	// 패치/업데이트
		{
			mv.addObject("menu_depth2", "4");
			mv.addObject("title", "패치/업데이트");
		}else if(bbsid.equals("10026"))	// 멀티미디어
		{
			mv.addObject("menu_depth2", "5");
			mv.addObject("title", "멀티미디어");
		}else if(bbsid.equals("10027"))	// 윈도우 10
		{
			mv.addObject("menu_depth2", "6");
			mv.addObject("title", "윈도우 10");
		}
		
		BoardDto dto = boardService.getSelectBoardDetail(boardDto);
		mv.addObject("boardInfo", dto);
		
		mv.setViewName("/board/bbsView");
	}
}
