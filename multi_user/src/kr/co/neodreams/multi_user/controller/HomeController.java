package kr.co.neodreams.multi_user.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.dto.CommonDto;
import kr.co.neodreams.multi_user.dto.HomeDto;
import kr.co.neodreams.multi_user.service.CommonService;
import kr.co.neodreams.multi_user.service.HomeService;
import kr.co.neodreams.multi_user.service.RentalSendSMS;

@Controller
public class HomeController extends BaseController{

	@Autowired HomeService homeService;
	
	@Autowired CommonService commonService;
	
	@Autowired RentalSendSMS sms;

	
	@RequestMapping("rentalTest.do")
	public void rentalTest() throws Exception{
		sms.sendSMS();
	}
	
	@RequestMapping({"/main.do","/"})
	public ModelAndView home(CommonDto commonDto) {
		
		List<HomeDto> today_updateList = null;
		List<CommonDto> noticeList = null;
		
		ModelAndView mv = new ModelAndView();
		try{
			
			today_updateList = homeService.getTodayUpdate("Today_update_main");
			
			commonDto.setPerPageCnt(5);
			noticeList = commonService.getNoticeList(commonDto);
			
			mv.setViewName("/main");
			mv.addObject("today_updateList", today_updateList);
			mv.addObject("noticeList", noticeList);
			
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}
		
		return mv;
	}
	
	@RequestMapping("/updata.do")
	public ModelAndView updata(HomeDto homeDto, HttpServletRequest request) throws Exception{
	
		ModelAndView mv = new ModelAndView();
		
		try{
			

			List<HomeDto> today_updateList = null;
			int totalCnt = 0;
			
			today_updateList = homeService.getTodayUpdateList(homeDto);
			
			totalCnt = homeService.getTodayUpdateListCnt(homeDto);
			
			mv.setViewName("/updata");
			mv.addObject("today_updateList", today_updateList);
			
			//페이징처리
			mv.addObject("totalCnt", totalCnt);
			mv.addObject("paging", homeDto);

		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}	
		return mv;
	}
	
}
