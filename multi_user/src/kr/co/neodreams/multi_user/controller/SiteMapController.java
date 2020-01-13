package kr.co.neodreams.multi_user.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.dto.CommonDto;
import kr.co.neodreams.multi_user.service.CommonService;
import kr.co.neodreams.multi_user.service.KubeUserService;

@Controller
public class SiteMapController extends BaseController{
	
	@Autowired
	CommonService commonService;
	
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
