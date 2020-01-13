package kr.co.neodreams.multi_user.controller;


import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.CommonUtil;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.dto.BroadcastDto;
import kr.co.neodreams.multi_user.service.BroadcastService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BroadcastController extends BaseController{
	
	@Autowired
	BroadcastService broadcastService;
	
	
	@RequestMapping("/kepcnNewsList.do")
	public ModelAndView getKepcnNewsList(BroadcastDto broadcastDto) throws Exception{
		
		List<BroadcastDto> kepcnNewList = null;
		int totalCnt = 0;
		
		ModelAndView mv = new ModelAndView();
		try{
								
			if(StringUtil.isEmpty(broadcastDto.getDir01())){
				broadcastDto.setDir01("9");
				broadcastDto.setDir02("1");
			}
			
			kepcnNewList = broadcastService.getNewsList(broadcastDto);
			
			totalCnt = broadcastService.getNewsListCnt(broadcastDto);
			
			mv.setViewName("/broadcast/kepcnNewsList");
			mv.addObject("kepcnNewList", kepcnNewList);
			mv.addObject("DIR_URL", CommonUtil.getDir_urlFromIP());
			mv.addObject("sess_id", SESS_EMPNO);
			
			//페이징처리
			mv.addObject("totalCnt", totalCnt);
			mv.addObject("paging", broadcastDto);
			
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}
		return mv;
	}
	
	@RequestMapping("/issueTalkList.do")
	public ModelAndView issueTalkList(BroadcastDto broadcastDto) throws Exception{
		
		List<BroadcastDto> issueTalkList = null;
		int totalCnt = 0;
		
		ModelAndView mv = new ModelAndView();
		try{
								
			if(StringUtil.isEmpty(broadcastDto.getDir01())){
				broadcastDto.setDir01("9");
				broadcastDto.setDir02("15");
			}
			
			issueTalkList = broadcastService.getNewsList(broadcastDto);
			
			totalCnt = broadcastService.getNewsListCnt(broadcastDto);
			
			mv.setViewName("/broadcast/issueTalkList");
			mv.addObject("issueTalkList", issueTalkList);
			mv.addObject("DIR_URL", CommonUtil.getDir_urlFromIP());
			mv.addObject("sess_id", SESS_EMPNO);
			
			//페이징처리
			mv.addObject("totalCnt", totalCnt);
			mv.addObject("paging", broadcastDto);
			
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}
		return mv;
	}
	
	/*감성홍보영상*/
	@RequestMapping("/promotionalVideoList.do")
	public ModelAndView promotionalvideo(BroadcastDto broadcastDto){
		
		List<BroadcastDto> promotionalVideoList = null;
		int totalCnt = 0;
		
		ModelAndView mv = new ModelAndView();
		try{
			
			if(StringUtil.isEmpty(broadcastDto.getDir01())){
				broadcastDto.setDir01("9");
				broadcastDto.setDir02("13");
			}
			
			promotionalVideoList = broadcastService.getNewsList(broadcastDto);
			
			totalCnt = broadcastService.getNewsListCnt(broadcastDto);
			
			mv.setViewName("/broadcast/promotionalVideoList");
			mv.addObject("promotionalVideoList", promotionalVideoList);
			mv.addObject("DIR_URL", CommonUtil.getDir_urlFromIP());
			mv.addObject("sess_id", SESS_EMPNO);
			
			//페이징처리
			mv.addObject("totalCnt", totalCnt);
			mv.addObject("paging", broadcastDto);
			
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}
		
		return mv;
	}
	
	/*kepcn기획*/
	@RequestMapping("/kepcnPlanList.do")
	public ModelAndView kepcnplan(BroadcastDto broadcastDto){
		
		List<BroadcastDto> kepcnPlanList = null;
		int totalCnt = 0;
		
		ModelAndView mv = new ModelAndView();
		try{
			
			if(StringUtil.isEmpty(broadcastDto.getDir01())){
				broadcastDto.setDir01("9");
				broadcastDto.setDir02("20");
			
			}
			
			kepcnPlanList = broadcastService.getNewsList2(broadcastDto);
			
			totalCnt = broadcastService.getNewsListCnt2(broadcastDto);
			
			mv.setViewName("/broadcast/kepcnPlanList");
			mv.addObject("kepcnPlanList", kepcnPlanList);
			mv.addObject("DIR_URL", CommonUtil.getDir_urlFromIP());
			mv.addObject("sess_id", SESS_EMPNO);
			
			//페이징처리
			mv.addObject("totalCnt", totalCnt);
			mv.addObject("paging", broadcastDto);
			
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}
		
		return mv;
	}
	
	@RequestMapping("/kepcnRequest.do")
	public void kepcnplan(HttpServletResponse response){
		try {
			response.sendRedirect("http://cello.hq:8888/EBBS/brd_list.php?menuid=A1542");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/kepcnFocusList.do")
	public ModelAndView kepcnFocusList(BroadcastDto broadcastDto) throws Exception{
		
		List<BroadcastDto> kepcnFocusList = null;
		int totalCnt = 0;
		
		ModelAndView mv = new ModelAndView();
		try{
								
			if(StringUtil.isEmpty(broadcastDto.getDir01())){
				broadcastDto.setDir01("9");
				broadcastDto.setDir02("5");
			}
			
			kepcnFocusList = broadcastService.getNewsList(broadcastDto);
			
			totalCnt = broadcastService.getNewsListCnt(broadcastDto);
			
			mv.setViewName("/broadcast/kepcnFocusList");
			mv.addObject("kepcnFocusList", kepcnFocusList);
			mv.addObject("DIR_URL", CommonUtil.getDir_urlFromIP());
			mv.addObject("sess_id", SESS_EMPNO);
			
			//페이징처리
			mv.addObject("totalCnt", totalCnt);
			mv.addObject("paging", broadcastDto);
			
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}
		return mv;
	}

	@RequestMapping("/kepcnConferenceList.do")
	public ModelAndView kepcnConferenceList(BroadcastDto broadcastDto) throws Exception{
		
		List<BroadcastDto> kepcnFocusList = null;
		int totalCnt = 0;
		broadcastDto.setPerPageCnt(15);
		
		
		ModelAndView mv = new ModelAndView();
		try{
								
			if(StringUtil.isEmpty(broadcastDto.getDir01())){
				broadcastDto.setDir01("9");
				broadcastDto.setDir02("18");
			}
			
			kepcnFocusList = broadcastService.getNewsList(broadcastDto);
			
			totalCnt = broadcastService.getNewsListCnt(broadcastDto);
			
			mv.setViewName("/broadcast/kepcnConferenceList");
			mv.addObject("kepcnFocusList", kepcnFocusList);
			mv.addObject("DIR_URL", CommonUtil.getDir_urlFromIP());
			mv.addObject("sess_id", SESS_EMPNO);
			
			//페이징처리
			mv.addObject("totalCnt", totalCnt);
			mv.addObject("paging", broadcastDto);
			
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}
		return mv;
	}
	
}
