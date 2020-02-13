package kr.co.neodreams.multi_user.controller;

import java.io.File;
import java.util.ArrayList;
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
import kr.co.neodreams.multi_user.dto.NoticeDto;
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
    
    protected String[] boardTitle = {
    	"공개소프트웨어",
    	"업무소프트웨어",
    	"드라이버",
    	"패치/업데이트",
    	"멀티미디어",
    	"윈도우10"
    };
    protected String[] menuDepth = {"1", "2", "3", "4", "5", "6"};
    
    
    protected Logger log = LoggerFactory.getLogger(this.getClass()); 
    
	/**
	 * S/W 라이센스 리스트
	 * @return
	 */
    @RequestMapping("/swlicense.do")
    public ModelAndView swlicense(BoardDto commonDto, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		try{
			
			List<BoardDto> noticeList = null;
			
			int totalCnt = 0;
			commonDto.setBbsid("10030");		// 라이센스등록

			noticeList = boardService.getSelectBoardList(commonDto);
			totalCnt = boardService.getSelectBoardListCnt(commonDto);

			mv.setViewName("/board/license");
			mv.addObject("noticeList", noticeList);	
			
			mv.addObject("bbsid", "10030");
			mv.addObject("menu_depth1", "13");
			mv.addObject("menu_depth2", "1");
			mv.addObject("title", "라이센스등록");
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
	 * S/W 라이센스 리스트
	 * @return
	 */
    @RequestMapping("/swmng.do")
    public ModelAndView swmng(BoardDto commonDto, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		try{
			
			List<BoardDto> noticeList = null;
			
			int totalCnt = 0;
			commonDto.setBbsid("10029");		// 소프트웨어관리

			noticeList = boardService.getSelectBoardList(commonDto);
			totalCnt = boardService.getSelectBoardListCnt(commonDto);

			mv.setViewName("/board/swlist");
			mv.addObject("noticeList", noticeList);	
			
			mv.addObject("bbsid", "10029");
			mv.addObject("menu_depth1", "13");
			mv.addObject("menu_depth2", "2");
			mv.addObject("title", "소프트웨어관리");
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
			
			//mv.setViewName("/board/publicswboard");
			mv.setViewName("/board/bbsList");
			mv.addObject("noticeList", noticeList);	
			
			mv.addObject("bbsid", "10022");
			mv.addObject("menu_depth1", "11");
			mv.addObject("menu_depth2", "1");
			mv.addObject("title", "공개소프트웨어");
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
			
			//mv.setViewName("/board/jobswboard");
			mv.setViewName("/board/bbsList");
			mv.addObject("noticeList", noticeList);
			
			mv.addObject("bbsid", "10023");
			mv.addObject("menu_depth1", "11");
			mv.addObject("menu_depth2", "2");
			mv.addObject("title", "업무소프트웨어");
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
			
			//mv.setViewName("/board/driverswboard");
			mv.setViewName("/board/bbsList");
			mv.addObject("noticeList", noticeList);
			
			mv.addObject("bbsid", "10024");
			mv.addObject("menu_depth1", "11");
			mv.addObject("menu_depth2", "3");
			mv.addObject("title", "드라이버");
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
			
			//mv.setViewName("/board/patchswboard");
			mv.setViewName("/board/bbsList");
			mv.addObject("noticeList", noticeList);
			
			mv.addObject("bbsid", "10025");
			mv.addObject("menu_depth1", "11");
			mv.addObject("menu_depth2", "4");
			mv.addObject("title", "패치/업데이트");
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
			
			//mv.setViewName("/board/multiswboard");
			mv.setViewName("/board/bbsList");
			mv.addObject("noticeList", noticeList);
			
			mv.addObject("bbsid", "10026");
			mv.addObject("menu_depth1", "11");
			mv.addObject("menu_depth2", "5");
			mv.addObject("title", "멀티미디어");
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
			
			//mv.setViewName("/board/winswboard");
			mv.setViewName("/board/bbsList");
			mv.addObject("noticeList", noticeList);
			
			mv.addObject("bbsid", "10027");
			mv.addObject("menu_depth1", "11");
			mv.addObject("menu_depth2", "6");
			mv.addObject("title", "윈도우 10");
			mv.addObject("categ", "1");  // SW자료=> 카테고리 1:SW자료, 2:드라이버공유, 3:교육자료
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
		ModelAndView mv = new ModelAndView();
		String bbsid = boardDto.getBbsid();
		String url = null;
		List<BoardDto> noticeList = null;
		int totalCnt = 0;
		
		System.out.println("bbsid : " + bbsid);
		System.out.println("searchString : " + boardDto.getSearchString());
		
		noticeList = boardService.getSelectBoardList(boardDto);
		totalCnt = boardService.getSelectBoardListCnt(boardDto);
		
		mv.addObject("noticeList", noticeList);
		mv.addObject("bbsid", bbsid);
		mv.addObject("menu_depth1", "11");
		
		if (bbsid.equals("10022"))		// 공개소프트웨어
		{
			mv.addObject("menu_depth2", menuDepth[0]);
			mv.addObject("title",       boardTitle[0]);
		}else if(bbsid.equals("10023"))	// 업무소프트웨어
		{
			mv.addObject("menu_depth2", menuDepth[1]);
			mv.addObject("title",       boardTitle[1]);
		}else if(bbsid.equals("10024"))	// 드라이버
		{
			mv.addObject("menu_depth2", menuDepth[2]);
			mv.addObject("title",       boardTitle[2]);
		}else if(bbsid.equals("10025"))	// 패치/업데이트
		{
			mv.addObject("menu_depth2", menuDepth[3]);
			mv.addObject("title",       boardTitle[3]);
		}else if(bbsid.equals("10026"))	// 멀티미디어
		{
			mv.addObject("menu_depth2", menuDepth[4]);
			mv.addObject("title",       boardTitle[4]);
		}else if(bbsid.equals("10027"))	// 윈도우 10
		{
			mv.addObject("menu_depth2", menuDepth[5]);
			mv.addObject("title",       boardTitle[5]);
			mv.addObject("categ", boardDto.getCateg());		// 카테고리 1:SW자료, 2:드라이버공유, 3:교육자료
		}
		
		//페이징처리
		mv.addObject("totalCnt", totalCnt);
		mv.addObject("paging", boardDto);
		
		mv.setViewName("/board/bbsList");
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
	public ModelAndView bbsWrite(@RequestParam String bbsid, @RequestParam String categ, HttpServletRequest request)
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
			mv.addObject("categ", categ);		// 카테고리 1:SW자료, 2:드라이버공유, 3:교육자료
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
			System.out.println("writer : " + boardDto.getWriter());
			System.out.println("notice : " + boardDto.getNotice());
			System.out.println("categ : " + boardDto.getCateg());
			//seq,     bbsid,     writer,    subject,     content, 
			//hit,     wtime,     ip,        userid,      notice
			
			// IP
			String ip = req.getRemoteAddr();
			boardDto.setIp(ip);   // IP 주소
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
	/**
	 * 게시글 수정 폼을 출력한다.
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/bbsUpdate.do")
	public ModelAndView noticeUpdate(HttpServletRequest req, HttpServletResponse res, BoardDto boardDto) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		String bbsid = boardDto.getBbsid();
		int pageNo = boardDto.getPageNo(); 
		
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
			mv.addObject("categ", boardDto.getCateg());
		}
		
		mv.setViewName("/board/bbsModify");
		BoardDto resultDetail = new BoardDto();
		resultDetail = boardService.getSelectBoardDetail(boardDto);
		resultDetail.setPageNo(pageNo);
		mv.addObject("resultDetail", resultDetail);
		mv.addObject("paging", boardDto);
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
	@RequestMapping("/bbsDetail.do")
	public ModelAndView bbsDetail(HttpServletRequest req, HttpServletResponse res, BoardDto boardDto) throws Exception{
		ModelAndView mv = new ModelAndView();
		String bbsid = boardDto.getBbsid();
		int pageNo = boardDto.getPageNo(); 
		
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
		dto.setPageNo(pageNo);
		mv.addObject("boardInfo", dto);
		mv.addObject("paging", dto);
		
		// 게시글 조회수증가 
		int result = boardService.boardHitUpdate(boardDto);
		
		mv.setViewName("/board/bbsView");
		
		return mv;
	}
	
	/**
	 * 게시글 수정하기 
	 * 
	 * @param req
	 * @param res
	 * @param noticeDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/bbsUpdate.do")
	public void bbsUpdate(HttpServletRequest req, HttpServletResponse res, BoardDto boardDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			retVal = Integer.toString(boardService.boardUpdate(boardDto));
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}
	
	/**
	 * 게시글 상세 보기에서 게시글을 삭제한다. 
	 * 파일이 있으면 파일을 삭제해야 한다.
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/deleteBoard.do")
	public void removeNotice(HttpServletRequest req, HttpServletResponse res, BoardDto boardDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			int fileChk = fileDelete(boardDto);
			
			if(fileChk > 0) {
				retVal = Integer.toString(boardService.boardFileDelete(boardDto));
				retVal = Integer.toString(boardService.boardDelete(boardDto));
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
	 * 첨부된 파일을 삭제한다.
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/deleteBoardAttatch.do")
	public void deleteBoardAttatch(HttpServletRequest req, HttpServletResponse res, BoardDto boardDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			int fileChk = fileDelete(boardDto);
			
			if(fileChk > 0) {
				retVal = Integer.toString(boardService.boardFileDelete(boardDto));
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
	 * @param boardDto
	 * @return
	 * @throws Exception
	 */
	public int fileDelete(BoardDto boardDto) throws Exception{
		int retVal = 0;
		
		try {
			List<BoardDto> boardList = new ArrayList<>();
			boardList = boardService.garbageAttatch(boardDto);
			
			for(int i=0; i < boardList.size(); i++) {
				BoardDto getFileDto = new BoardDto();
				
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
}
