package kr.co.neodreams.multi_user.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import kr.co.neodreams.multi_user.dto.BoardDto;
import kr.co.neodreams.multi_user.dto.CommonDto;
import kr.co.neodreams.multi_user.dto.MemoDto;
import kr.co.neodreams.multi_user.service.BoardService;
import kr.co.neodreams.multi_user.service.CommonService;
import kr.co.neodreams.multi_user.service.KubeUserService;
import kr.co.neodreams.multi_user.service.MemoService;

@Controller
public class SiteMapController extends BaseController{
	
	@Autowired
	DataSourceTransactionManager dataSourceTransactionManager;
	
	@Autowired
	CommonService commonService;
	
	@Autowired
	MemoService memoService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	KubeUserService kubeService;
	
	/**
	 * 공지사항 리스트 조회
	 * 
	 * @param memoDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/notice.do")
	public ModelAndView notice( MemoDto memoDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			
			List<MemoDto> noticeList = null;
			
			int totalCnt = 0;

			noticeList = memoService.getNoticeList(memoDto);
			totalCnt = memoService.getNoticeListCnt(memoDto);
			
			mv.setViewName("/sitemap/notice");
			mv.addObject("noticeList", noticeList);
			
			//페이징처리
			mv.addObject("totalCnt", totalCnt);
			mv.addObject("paging", memoDto);
			
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}	
		return mv;
	}
	
	/**
	 * 공지사항 상세 보기
	 * 
	 * @param memoDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/notice_view.do")
	public ModelAndView notice_view(MemoDto memoDto, HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		
		try{
			
			MemoDto noticeDetail = null;
			
			noticeDetail = memoService.getNoticeDetail(String.valueOf(memoDto.getNum()));
			
			// 게시글 HIT 업데이트 한다.
			memoService.noticeHitUpdate(memoDto);
			
			mv.setViewName("/sitemap/notice_view");
			mv.addObject("noticeDetail", noticeDetail);
			memoDto.setBbsid("10030");
			mv.addObject("paging", memoDto);
			
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}	
		return mv;
	}
	
	/***
	 * 공지사항 쓰기 폼 호출
	 * 
	 * @param commonDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/notice_write.do")
	public ModelAndView notice_write(MemoDto commonDto, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		commonDto.setBbsid("10030");
		
		mv.addObject("paging", commonDto);
		
		mv.setViewName("/sitemap/notice_write");
		
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
	@RequestMapping("/registMemo.do")
	public void notice_write(HttpServletRequest req, HttpServletResponse res, MemoDto memoDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			memoDto.setWriter(SESS_USER_NAME);			
			// IP
			String ip = req.getRemoteAddr();   // IP 주소
			memoDto.setHost_ip(ip);  
			memoDto.setPasswd(SESS_EMPNO);	
			
			//#num#,	 #subject#,   #writer#,   #sosok#,  #pdsfile#,   #filesize#, #email#,   #passwd#,   getDate(), 
			//#content#, 0,         #html#,     #num#,    0,           0,          #num#,     #dirname#,  #host_ip#
			System.out.println(memoDto.getSubject());
			System.out.println(memoDto.getWriter());
			System.out.println(memoDto.getSosok());
			System.out.println(memoDto.getPdsfile());
			System.out.println(memoDto.getFilesize());
			System.out.println(memoDto.getEmail());
			System.out.println(memoDto.getPasswd());
			System.out.println(memoDto.getContent());
			System.out.println(memoDto.getHtml());
			System.out.println(memoDto.getDirname());
			System.out.println(memoDto.getHost_ip());
			
			retVal = Integer.toString(memoService.noticeInsert(memoDto));
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
	 * @param memoDto
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/memoModify.do")
	public ModelAndView memoModifyForm(HttpServletRequest req, HttpServletResponse res, MemoDto memoDto) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		String bbsid = memoDto.getBbsid();
		int pageNo = memoDto.getPageNo(); 
		
		mv.addObject("bbsid", bbsid);		
		mv.setViewName("/sitemap/notice_modify");
		MemoDto resultDetail = new MemoDto();
		resultDetail = memoService.getNoticeDetail(String.valueOf(memoDto.getNum()));
		resultDetail.setPageNo(pageNo);
		resultDetail.setBbsid("10030");
		mv.addObject("resultDetail", resultDetail);
		mv.addObject("paging", resultDetail);
		return mv;
	}
	
	/**
	 * 게시글 수정하기 
	 * 
	 * @param req
	 * @param res
	 * @param memoDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/memoUpdate.do")
	public void memoUpdate(HttpServletRequest req, HttpServletResponse res, MemoDto memoDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			retVal = Integer.toString(memoService.noticeUpdate(memoDto));
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
	 * @param memoDto
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/deleteMemo.do")
	public void deleteMemo(HttpServletRequest req, HttpServletResponse res, MemoDto memoDto) throws Exception{
		System.out.println("deleteMemo called..");
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			memoDto.setBbsid("10030");
			int fileChk = fileDelete(memoDto);
			
			if(fileChk > 0) {
				retVal = Integer.toString(memoService.noticeFileDelete(memoDto));
				System.out.println(retVal);
				retVal = Integer.toString(memoService.noticeDelete(memoDto));
				System.out.println(retVal);
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
	 * @param memoDto
	 * @return
	 * @throws Exception
	 */
	public int fileDelete(MemoDto memoDto) throws Exception{
		int retVal = 0;
		
		try {
			List<MemoDto> boardList = new ArrayList<>();
			boardList = memoService.garbageAttatch(memoDto);
			
			for(int i=0; i < boardList.size(); i++) {
				MemoDto getFileDto = new MemoDto();
				
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
	 * 게시판 > 자유게시판 리스트 조회 
	 * 
	 * @param commonDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/freeboard.do")
	public ModelAndView freeboard(BoardDto commonDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			
			List<BoardDto> noticeList = null;
			
			int totalCnt = 0;
			commonDto.setBbsid("10020");

			noticeList = boardService.getSelectBoardList(commonDto);
			totalCnt = boardService.getSelectBoardListCnt(commonDto);
			
			mv.setViewName("/sitemap/freeboard");
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
	 * 게시글 작성 폼을 보여준다. 
	 * 자유게시판, Q&A
	 * @param bbsid
	 * @param request
	 * @return
	 */
	@RequestMapping("/boardWrite.do")
	public ModelAndView boardWrite(@RequestParam String bbsid, HttpServletRequest request)
	{
		ModelAndView mv = new ModelAndView();
		BoardDto commonDto = new BoardDto();
		
		mv.addObject("bbsid", bbsid);
		mv.addObject("menu_depth1", "12");
		if (bbsid.equals("10020"))		// 자유게시판
		{
			mv.addObject("menu_depth2", "2");
			mv.addObject("title", "자유게시판");
		}else if(bbsid.equals("10021"))	// Q&A
		{
			mv.addObject("menu_depth2", "3");
			mv.addObject("title", "Q&A");
		}		
		
		mv.addObject("commonDto", commonDto);
		mv.addObject("paging", commonDto);
		mv.setViewName("/sitemap/boardWrite");
		
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
	@RequestMapping("/boardModify.do")
	public ModelAndView boardModifyForm(HttpServletRequest req, HttpServletResponse res, BoardDto boardDto) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		String bbsid = boardDto.getBbsid();
		int pageNo = boardDto.getPageNo(); 
		
		mv.addObject("bbsid", bbsid);
		mv.addObject("menu_depth1", "12");
		if (bbsid.equals("10020"))		// 자유게시판
		{
			mv.addObject("menu_depth2", "2");
			mv.addObject("title", "자유게시판");
		}else if(bbsid.equals("10021"))	// Q&A
		{
			mv.addObject("menu_depth2", "3");
			mv.addObject("title", "Q&A");
		}	
		
		mv.setViewName("/sitemap/boardModify");
		BoardDto resultDetail = new BoardDto();
		resultDetail = boardService.getSelectBoardDetail(boardDto);
		resultDetail.setPageNo(pageNo);
		mv.addObject("resultDetail", resultDetail);
		mv.addObject("paging", boardDto);
		return mv;
	}
	
	/**
	 * 게시판 > Q&A 리스트 조회 
	 * 
	 * @param commonDto
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/qnaboard.do")
	public ModelAndView qnaboard(BoardDto commonDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			
			List<BoardDto> noticeList = null;
			
			int totalCnt = 0;
			commonDto.setBbsid("10021");
			noticeList = boardService.getSelectBoardList(commonDto);
			totalCnt = boardService.getSelectBoardListCnt(commonDto);
			
			mv.setViewName("/sitemap/qnaboard");
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
	 * 게시판 상세 보기
	 * 
	 * @param req
	 * @param res
	 * @param boardDto
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/boardDetail.do")
	public ModelAndView boardDetail(HttpServletRequest req, HttpServletResponse res, BoardDto boardDto) throws Exception{
		ModelAndView mv = new ModelAndView();
		String bbsid = boardDto.getBbsid();
		int pageNo = boardDto.getPageNo(); 
		
		mv.addObject("bbsid", bbsid);
		mv.addObject("menu_depth1", "12");
		if (bbsid.equals("10020"))		 
		{
			mv.addObject("menu_depth2", "2");
			mv.addObject("title", "자유게시판");
		}else if(bbsid.equals("10021"))	 
		{
			mv.addObject("menu_depth2", "3");
			mv.addObject("title", "Q&A");
		}
		
		BoardDto dto = boardService.getSelectBoardDetail(boardDto);
		dto.setPageNo(pageNo);
		mv.addObject("boardInfo", dto);
		mv.addObject("paging", dto);
		
		// 게시글 조회수증가 
		int result = boardService.boardHitUpdate(boardDto);
		
		mv.setViewName("/sitemap/boardView");
		
		return mv;
	}	
	
	
	@RequestMapping("/siteMap.do")
	public ModelAndView SiteMap(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/sitemap/siteMap");
		try {
			mv.addObject("kubeMenu", kubeService.getLeftMenu(""));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}
}
