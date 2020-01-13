package kr.co.neodreams.multi_user.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.DataMap;
import kr.co.neodreams.multi_user.common.HashidsGenerator;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.controller.KubeAdminController.KubeModelAndView;
import kr.co.neodreams.multi_user.dto.KubeDto;
import kr.co.neodreams.multi_user.dto.PromoteDto;
import kr.co.neodreams.multi_user.service.PromoteService;

@Controller
@RequestMapping("promote")
public class PromoteController extends BaseController{

    @Autowired
    PromoteService promoteService;

    /*이용안내*/
    @RequestMapping("promoteInfo.do")
    public ModelAndView DisplayBoardInfo(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/promote/promoteInfo");
        return mv;
    }

    /*행사신청*/
    @RequestMapping("promoteRequest.do")
    public ModelAndView promoteRequest(HttpServletRequest request, HttpServletResponse response){
        ModelAndView mv = new ModelAndView();

        try {
        	
        	mv.setViewName("/promote/promoteRequest");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            mv.setViewName("/error/error");
        }
        return mv;
    }

    @RequestMapping("insertUpdatePromote.do")
    @ResponseBody
	public void insertUpdatePromote(PromoteDto promoteDto, BindingResult result,HttpServletRequest request, HttpServletResponse response)throws Exception{
    	String retVal = "false"; 
        
		try{
			retVal = promoteService.insertUpdatePromote(promoteDto, request); 
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally{
			response.getWriter().write(retVal);
		}
    }

    /*진행상황*/
    @RequestMapping("promoteProgress.do")
    public ModelAndView promoteProgress(PromoteDto promoteDto, BindingResult result, HttpServletRequest request, HttpServletResponse response){
        ModelAndView mv = new ModelAndView();

        List<HashMap<String, String>> promoteList = null;
        int totalCnt = 0;

        try {
        	String start_date = promoteDto.getStart_date();
        	String end_date = promoteDto.getEnd_date();
        	
        	if(StringUtil.isNotEmpty(start_date)){
        		promoteDto.setStart_date(promoteDto.getStart_date().replace("-", ""));
        	}
        	
        	if(StringUtil.isNotEmpty(end_date)){
        		promoteDto.setEnd_date(promoteDto.getEnd_date().replace("-", ""));
        	}
			
        	String SESS_EMPNO = (String) request.getSession().getAttribute("SESS_EMPNO");
        	promoteDto.setReq_empno(SESS_EMPNO);
        	
        	promoteList		= promoteService.getPromoteList(promoteDto);
            totalCnt        = promoteService.getPromoteListCnt(promoteDto);

            promoteDto.setStart_date(start_date);
			promoteDto.setEnd_date(end_date);
			
            mv.addObject("promoteList", promoteList);
            //페이징처리
            mv.addObject("totalCnt", totalCnt);
            mv.addObject("paging", promoteDto);
            mv.addObject("left_depth_2", "3");
            mv.setViewName("/promote/promoteProgress");
        } catch (Exception e) {
            e.printStackTrace();
            mv.setViewName("/error/error");
        }

        return mv;
    }
    
    /*결재*/
    @RequestMapping("promoteMgmt.do")
    public ModelAndView promoteMgmt(PromoteDto promoteDto, BindingResult result, HttpServletRequest request, HttpServletResponse response){
    	ModelAndView mv = new ModelAndView();
    	
    	List<HashMap<String, String>> promoteList = null;
    	int totalCnt = 0;
    	
    	try {
    		String start_date = promoteDto.getStart_date();
    		String end_date = promoteDto.getEnd_date();
    		
    		if(StringUtil.isNotEmpty(start_date)){
    			promoteDto.setStart_date(promoteDto.getStart_date().replace("-", ""));
    		}
    		
    		if(StringUtil.isNotEmpty(end_date)){
    			promoteDto.setEnd_date(promoteDto.getEnd_date().replace("-", ""));
    		}
    		
    		promoteList		= promoteService.getPromoteList(promoteDto);
    		totalCnt        = promoteService.getPromoteListCnt(promoteDto);
    		
    		promoteDto.setStart_date(start_date);
    		promoteDto.setEnd_date(end_date);
    		
    		mv.addObject("promoteList", promoteList);
    		//페이징처리
    		mv.addObject("totalCnt", totalCnt);
    		mv.addObject("paging", promoteDto);
    		mv.addObject("left_depth_2", "4");
    		mv.setViewName("/promote/promoteProgress");
    	} catch (Exception e) {
    		e.printStackTrace();
    		mv.setViewName("/error/error");
    	}
    	
    	return mv;
    }

    /*view Detail*/
    @RequestMapping("promoteDetail.do")
    public ModelAndView promoteDetail(PromoteDto promoteDto, BindingResult result, HttpServletRequest request, HttpServletResponse response){
        ModelAndView mv = new ModelAndView();

        try {
            HashMap<String, String> promoteDetail	= promoteService.getPromoteDetail(promoteDto);
            
            mv.addObject("promoteDetail", promoteDetail);
            mv.addObject("left_depth_2", request.getParameter("left_depth_2"));
            mv.setViewName("/promote/promoteDetail");
            
            DataMap dataMap = new DataMap(request, "non_encoding");
    		mv.addObject("srhReq", dataMap.getParameterHiddenForm());
        } catch (Exception e) {
            // TODO: handle exception
        	e.printStackTrace();
        	mv.setViewName("/error/error");
        }
        return mv;
    }
    
    @RequestMapping("promoteAdmin.do")
    public ModelAndView promoteAdmin(PromoteDto promoteDto, BindingResult result, HttpServletRequest request){
    	ModelAndView mv = new ModelAndView();  
    	
    	try{
    		List<HashMap<String, String>> saList = promoteService.getSaList();
    		
    		mv.setViewName("/promote/promoteAdmin");
    		mv.addObject("paging", promoteDto);
    		mv.addObject("saList", saList);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
    @RequestMapping("promoteAdminRegPop.do")
    public ModelAndView promoteAdminRegPop(PromoteDto promoteDto, BindingResult result, HttpServletRequest request){
    	ModelAndView mv = new ModelAndView();  
    	
    	try{
    		
    		promoteDto.setPerPageCnt(15);

    		List<HashMap<String, String>> userList = promoteService.getUserList(promoteDto);
    		int totalCnt = promoteService.getUserListCnt(promoteDto);
    		
    		mv.setViewName("/promote/promoteAdminRegPop");
    		mv.addObject("paging", promoteDto);
    		mv.addObject("userList", userList);
        	mv.addObject("totalCnt", totalCnt);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
    @RequestMapping("insertDeletePromoteAdmin.do")
    @ResponseBody
	public void insertDeletePromoteAdmin(PromoteDto promoteDto , BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception{		
    	
		String retVal = "false"; 
		
		try{ 
			retVal = promoteService.insertDeleteSa(promoteDto, request); 
			
			retVal = "true";
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally{
			response.setHeader("Content-Type", "text/html; charset=utf-8");
			response.getWriter().write(retVal);
		}
	}
    
    /*mail Detail*/
    @RequestMapping("promoteMail.do")
    public ModelAndView promoteMail(PromoteDto promoteDto, BindingResult result, HttpServletRequest request, HttpServletResponse response){
    	ModelAndView mv = new ModelAndView();
    	
    	try {     
    		
    		String query = request.getParameter("q");
    		System.out.println(query);
    		if(StringUtil.isNotEmpty(query)){
    			String[] query_split = query.split("MULTI");
    			 System.out.println(query_split.length);
	    		HashidsGenerator hashids = new HashidsGenerator(Constants.KUBE_SEQ_SALT, 15);
	    		promoteDto.setP_seq(Integer.parseInt(String.valueOf(hashids.decrypt(query_split[0])[0])));
	    		
	    		HashMap<String, String> promoteDetail	= promoteService.getPromoteDetail(promoteDto);
	    		
	    		mv.addObject("promoteDetail", promoteDetail);
	    		mv.addObject("mail_p_seq", String.valueOf(hashids.decrypt(query_split[0].replace("\"", ""))[0]));
	    		mv.addObject("mail_p_status", String.valueOf(hashids.decrypt(query_split[1].replace("\"", ""))[0]));
	    		mv.addObject("link_gubun", String.valueOf(hashids.decrypt(query_split[2].replace("\"", ""))[0]));
	    		mv.setViewName("/promote/promoteMail");
	    		
	    		DataMap dataMap = new DataMap(request, "non_encoding");
	    		mv.addObject("srhReq", dataMap.getParameterHiddenForm());
    		}else{
    			mv.setViewName("/error/error");
    		}
    	} catch (Exception e) {
    		// TODO: handle exception
    		e.printStackTrace();
    		mv.setViewName("/error/error");
    	}
    	return mv;
    }
}
