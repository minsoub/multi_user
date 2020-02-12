package kr.co.neodreams.multi_user.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.dto.BoardDto;
import kr.co.neodreams.multi_user.dto.CommonDto;
import kr.co.neodreams.multi_user.service.BoardService;
import kr.co.neodreams.multi_user.service.CommonService;
import kr.co.neodreams.multi_user.service.KubeUserService;

@Controller
public class SiteMapController extends BaseController{
	
	@Autowired
	CommonService commonService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	KubeUserService kubeService;
	
	@RequestMapping("/notice.do")
	public ModelAndView notice(CommonDto commonDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			
			List<CommonDto> noticeList = null;
			
			int totalCnt = 0;

			noticeList = commonService.getNoticeList(commonDto);
			totalCnt = commonService.getNoticeListCnt(commonDto);
			
			mv.setViewName("/sitemap/notice");
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
	
	@RequestMapping("/notice_view.do")
	public ModelAndView notice_view(CommonDto commonDto, HttpServletRequest request) throws Exception{
		
		ModelAndView mv = new ModelAndView();
		
		try{
			
			CommonDto noticeDetail = null;
			
			noticeDetail = commonService.getNoticeDetail(commonDto.getNum());
			
			mv.setViewName("/sitemap/notice_view");
			mv.addObject("noticeDetail", noticeDetail);
			
			mv.addObject("paging", commonDto);
			
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}	
		return mv;
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
