package kr.co.neodreams.multi_user.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.CommonUtil;
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
	
    @Resource(name = "commonUtil")
    private CommonUtil commonUtil;
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
			mv.addObject("paging", commonDto);
			
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
			commonDto.setBbsid("10023");		// 드라이버

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
			commonDto.setBbsid("10024");		// 패치/업데이트 

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
			commonDto.setBbsid("10025");		// 멀티미디어 

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
			commonDto.setBbsid("10026");		// 윈도우 10 

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
}
