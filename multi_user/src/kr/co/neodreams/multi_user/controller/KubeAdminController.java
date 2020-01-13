package kr.co.neodreams.multi_user.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.DateUtil;
import kr.co.neodreams.multi_user.common.ExcelUtil;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.common.TldUtil;
import kr.co.neodreams.multi_user.dto.KubeDto;
import kr.co.neodreams.multi_user.service.KubeAdminService;
import net.arnx.jsonic.JSON;

@Controller
public class KubeAdminController extends BaseController {
 
	@Autowired
	KubeAdminService kubeService;
	
    @RequestMapping("/kubeMainMgmt.do")
    public ModelAndView kubeMainMgmt(HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		List<HashMap<String, String>> mainInfos = kubeService.getMainLayerInfo();
    		
    		mv.setViewName("/kube/admin/kubeMainMgmt");
    		mv.addObject("mainInfos", mainInfos);
    		mv.addObject("web_url", Constants.WEB_URL);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
    @RequestMapping("/kube/insertUpdateMainMgmt.do")
    @ResponseBody
	public void insertUpdateMainMgmt(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest mRequest)throws Exception{		
    	          
		String retVal = "false"; 
		
		try{ 
			
			retVal = kubeService.insertUpdateMainMgmt(kubeDto, request, mRequest); 
			
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally{
			
			if(retVal.equals("false")){
				response.setHeader("Content-Type", "text/html; charset=utf-8");
				retVal = "<script>alert('서비스 장애가 발생했습니다. 관리자에게 문의 하시기 바랍니다.');</script>";
				response.getWriter().write(retVal);
			}else{
				response.setHeader("Content-Type", "text/html; charset=utf-8");
				retVal = "<script>alert('등록 되었습니다.');parent.location.replace('/kubeMainMgmt.do');</script>";
				response.getWriter().write(retVal);
			}   
		}
	}
    
    @RequestMapping("/kubeCategoryMgmt.do")
    public ModelAndView kubeCategoryMgmt(HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		mv.setViewName("/kube/admin/kubeCategoryMgmt");
    		mv.addObject("codeList", this.getCodeList("14"));
    		mv.addObject("kubeLeftMenuList", kubeService.getLeftMenu(""));
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
    @RequestMapping("/kubeCategoryPop.do")
    public ModelAndView kubeCategoryPop(HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		mv.setViewName("/kube/admin/kubeCategoryPop");
    		mv.addObject("ct", request.getParameter("ct"));
    		mv.addObject("p", request.getParameter("p"));
    		mv.addObject("s", request.getParameter("s"));
    		mv.addObject("codeList", this.getCodeList("14"));
    		mv.addObject("kubeLeftMenuList", kubeService.getLeftMenu(""));
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
    @RequestMapping("/kubeCategoryInsertUpdate.do")
    @ResponseBody
    public void kubeCategoryInsertUpdate(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception{		
		
		String retVal = "false";
		
		try{
			String SESS_EMPNO = (String) request.getSession().getAttribute("SESS_EMPNO");
			String act_gubun = request.getParameter("act_gubun");
			String code_seq = request.getParameter("s");
			String category = request.getParameter("ct");
			String ori_p_code_seq = request.getParameter("p");
			
			kubeDto.setMod_date(DateUtil.getCurrentDateTime());
			kubeDto.setMod_empno(SESS_EMPNO);
			kubeDto.setCategory(category);
			
			if(StringUtil.isNotEmpty(ori_p_code_seq)){
				kubeDto.setOri_p_code_seq(Integer.parseInt(ori_p_code_seq));
			}
			
			if("c".equals(act_gubun)){
				kubeService.insertCode(kubeDto);
			}else if("u".equals(act_gubun)){
				kubeDto.setCode_seq(Integer.parseInt(code_seq));
				kubeService.updateCode(kubeDto);
			}else if("d".equals(act_gubun)){
				kubeDto.setCode_seq(Integer.parseInt(code_seq));
				kubeService.deleteCode(kubeDto);
			}
			
			HttpSession session = request.getSession();
    		
    		if(session != null){
    			session.setAttribute("SESS_KUBE_MENU", kubeService.getLeftMenu(SESS_EMPNO));
    		}
    		
			retVal = "true";
		} catch(Exception e){
			e.printStackTrace();
    		log.error( "failed!", e );
			
			retVal = "false";
			
		} finally{
			response.getWriter().write(retVal);
		} 
	}
    
    @RequestMapping("/kubeReportMgmt.do")
    public ModelAndView kubeReportMgmt(KubeDto kubeDto, BindingResult result, HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		
    		List<HashMap<String, String>> reportList = kubeService.getReportList(kubeDto);
    		int totalCnt = kubeService.getReportListCnt(kubeDto);
    		
    		mv.setViewName("/kube/admin/kubeReportMgmt");
    		mv.addObject("paging", kubeDto);
    		mv.addObject("reportList", reportList);
        	mv.addObject("totalCnt", totalCnt);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
	@RequestMapping("/kube/updateReport.do")
    @ResponseBody
	public void updateReport(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception{		
    	
		String retVal = "false"; 
		
		try{ 
			retVal = kubeService.updateReport(kubeDto, request); 
			
			retVal = "true";
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally{
			response.setHeader("Content-Type", "text/html; charset=utf-8");
			response.getWriter().write(retVal);
		}
	}
	
	@RequestMapping("/kubeVideoMgmt.do")
    public ModelAndView kubeVideoMgmt(KubeDto kubeDto, BindingResult result, HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		kubeDto.setPerPageCnt(20);
    		kubeDto.setSelOrder(StringUtil.isNull(kubeDto.getSelOrder(), "reg_date"));
    		kubeDto.setStart_date(StringUtil.isNull(kubeDto.getStart_date(),DateUtil.getToday()).replace("-", ""));
    		kubeDto.setEnd_date(StringUtil.isNull(kubeDto.getEnd_date(),DateUtil.getToday()).replace("-", ""));
    		
    		List<HashMap<String, String>> videoList = kubeService.getVideoList(kubeDto);
    		int totalCnt = kubeService.getVideoListCnt(kubeDto);
    		
    		mv.setViewName("/kube/admin/kubeVideoMgmt");
    		mv.addObject("paging", kubeDto);
    		mv.addObject("videoList", videoList);
        	mv.addObject("totalCnt", totalCnt);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
	
	/**
	 * exportXls :  영상관리 엑셀다운로드 
	 * @param kubeDto
	 */
	@RequestMapping("kubeVideoExportXls.do")
	public @ResponseBody byte[] kubeVideoExportXls (KubeDto kubeDto, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {

		response.setHeader("Set-Cookie", "fileDownload=true; path=/");

		kubeDto.setSelOrder(StringUtil.isNull(kubeDto.getSelOrder(), "reg_date"));
		kubeDto.setStart_date(StringUtil.isNull(kubeDto.getStart_date(),DateUtil.getToday()).replace("-", ""));
		kubeDto.setEnd_date(StringUtil.isNull(kubeDto.getEnd_date(),DateUtil.getToday()).replace("-", ""));
		
		List<HashMap<String, String>> exList = kubeService.getVideoListXls(kubeDto);
		
		// Excel 셋팅
		List<Object> header = new ArrayList<Object>();
		List<List<Object>> data = new ArrayList<List<Object>>();
		
		String[] keyVal = {"제목","카테고리","게시자","조회","댓글","다운로드","좋아요","게시일시"};
		
	    //ROW 생성 LOOP  
	    for(int r=0; r < exList.size();r++){
	    	HashMap<String, String> map = exList.get(r);
	    	
    		List<Object> obj = new ArrayList<Object>();	
	    	//header setting 
	    	if(r==0){
	    		for(int k = 0; k < keyVal.length; k++){
	    			header.add(keyVal[k]);
	    			obj.add(String.valueOf(map.get(keyVal[k])));			    		
	    		}
	    	}else{
		    	//data setting 
	    		for(int k = 0; k < keyVal.length; k++){
	    			obj.add(String.valueOf(map.get(keyVal[k])));			    		
	    		}
	    	}
	    	
    		data.add(obj);
	    }

		ExcelUtil excel = new ExcelUtil(header ,data);
		excel.setSheetName("sheet1");
		excel.setWidth(6000);
		
		byte[] bytes = excel.makeExcel();
		
        String userAgent = request.getHeader("User-Agent");
        boolean br = userAgent.indexOf("Chrome") > -1;
        
        String fileName = "영상 리스트_" + kubeDto.getStart_date() + "~" + kubeDto.getEnd_date();
        String docName ="";        	   
        
        if(br){
        	docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
        } else {
        	docName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
        }
		
		response.setHeader("Content-Disposition", "attachment; filename="+docName+".xlsx");
		response.setContentLength(bytes.length);
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Pragma", "no-cache");		
		response.setHeader("Cache-Control", "private");
		response.setHeader("Expires", "0");
		return bytes;
	}
	
    @RequestMapping("/kubeUserMgmt.do")
    public ModelAndView kubeUserMgmt(KubeDto kubeDto, BindingResult result, HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		kubeDto.setPerPageCnt(20);
    		kubeDto.setSelOrder(StringUtil.isNull(kubeDto.getSelOrder(), "name asc"));

    		List<HashMap<String, String>> userList = kubeService.getUserStatisticsList(kubeDto);
    		int totalCnt = kubeService.getUserStatisticsListCnt(kubeDto);
    		
    		mv.setViewName("/kube/admin/kubeUserMgmt");
    		mv.addObject("paging", kubeDto);
    		mv.addObject("userList", userList);
        	mv.addObject("totalCnt", totalCnt);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
    @RequestMapping("/kubeSaMgmt.do")
    public ModelAndView kubeSaMgmt(KubeDto kubeDto, BindingResult result, HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		List<HashMap<String, String>> saList = kubeService.getSaList(kubeDto);
    		
    		mv.setViewName("/kube/admin/kubeSaMgmt");
    		mv.addObject("paging", kubeDto);
    		mv.addObject("saList", saList);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
    @RequestMapping("/kubeSaRegPop.do")
    public ModelAndView kubeSaRegPop(KubeDto kubeDto, BindingResult result, HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		
    		kubeDto.setPerPageCnt(15);

    		List<HashMap<String, String>> userList = kubeService.getUserList(kubeDto);
    		int totalCnt = kubeService.getUserListCnt(kubeDto);
    		
    		mv.setViewName("/kube/admin/kubeSaRegPop");
    		mv.addObject("paging", kubeDto);
    		mv.addObject("userList", userList);
        	mv.addObject("totalCnt", totalCnt);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
    @RequestMapping("/kube/insertDeleteKubeSa.do")
    @ResponseBody
	public void insertDeleteKubeSa(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception{		
    	
		String retVal = "false"; 
		
		try{ 
			retVal = kubeService.insertDeleteKubeSa(kubeDto, request); 
			
			retVal = "true";
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally{
			response.setHeader("Content-Type", "text/html; charset=utf-8");
			response.getWriter().write(retVal);
		}
	}
    
    /**
     * 코드 가져옴. 
     * where code_gubun in (inQuery)
     */
    protected List<HashMap<String, String>> getCodeList(String inQuery){
        
        List<HashMap<String, String>> codeList = null;
        
        try {
        	codeList = kubeService.getCodeList(inQuery);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        
        return codeList;
    }
    
	/*동적 셀렉트 박스 코드 컨트롤*/
    @RequestMapping("/kube/getCategoryCode.do")
    @ResponseBody
    public void getCategoryCode(KubeDto kubeDto, BindingResult result, HttpServletResponse response) throws Exception{
    	
    	List<HashMap<String, String>> codeList = null;
    	
    	try{
    		codeList = kubeService.getCategoryCode(kubeDto);
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		log.error( "failed!", e );
    	}finally {
    		if(codeList != null){
    			response.setHeader("Content-Type", "text/html; charset=utf-8");
    			response.getWriter().write(JSON.encode(codeList));
    		}
    	}
    }
    
    @RequestMapping("getMenuList.do")
    @ResponseBody
    public void getMenuList(KubeDto kubeDto, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception{
    	
    	List<HashMap<String, String>> codeList = null;
    	
    	try{
    		codeList = kubeService.getLeftMenu((String) request.getSession().getAttribute("SESS_EMPNO"));
    		
    		if(codeList != null){
	    		int forCnt = codeList.size();
	    		
	    		for(int i = 0; i < forCnt; i++){
	    			codeList.get(i).put("p_code_seq", TldUtil.seqEncode(String.valueOf(codeList.get(i).get("p_code_seq")))); 
	    			codeList.get(i).put("code_seq", TldUtil.seqEncode(String.valueOf(codeList.get(i).get("code_seq"))));
	    		}
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    		log.error( "failed!", e );
    	}finally {
    		if(codeList != null){
    			response.setHeader("Content-Type", "text/html; charset=utf-8");
    			response.getWriter().write(JSON.encode(codeList));
    		}
    	}
    }

    @RequestMapping("/kubeElearnStat.do")
    public ModelAndView kubeElearnStat(KubeDto kubeDto, BindingResult result, HttpServletRequest request, HttpServletResponse response){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		
    		kubeDto.setPerPageCnt(15);

    		String start_date = kubeDto.getStart_date();
    		String end_date = kubeDto.getEnd_date();
    		
    		kubeDto.setStart_date(start_date + " 00:00:00");
    		kubeDto.setEnd_date(end_date + " 23:59:59");
    		
    		List<HashMap<String, String>> statList = kubeService.getElearnStatList(kubeDto);
    		int totalCnt = kubeService.getElearnStatListCnt(kubeDto);
    		
    		kubeDto.setStart_date(start_date);
    		kubeDto.setEnd_date(end_date);
    		
    		mv.setViewName("/kube/admin/kubeElearnStat");
    		mv.addObject("paging", kubeDto);
    		mv.addObject("statList", statList);
        	mv.addObject("totalCnt", totalCnt);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	
    	return mv;
    }
    
    /**
	 * exportXls :  e-러닝관리 엑셀다운로드 
	 * @param kubeDto
	 */
	@RequestMapping("/kubeElearnStatXls.do")
	public @ResponseBody byte[] kubeElearnStatXls (KubeDto kubeDto, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {

		response.setHeader("Set-Cookie", "fileDownload=true; path=/");

		String start_date = kubeDto.getStart_date();
		String end_date = kubeDto.getEnd_date();
		
		kubeDto.setStart_date(start_date + " 00:00:00");
		kubeDto.setEnd_date(end_date + " 23:59:59");
		
		List<HashMap<String, String>> exList = kubeService.getElearnStatListXls(kubeDto);
		
		// Excel 셋팅
		List<Object> header = new ArrayList<Object>();
		List<List<Object>> data = new ArrayList<List<Object>>();
		
		String[] keyVal = {"사번","이름","소속","과정명","시작일시","수료일시","수료여부","과정시간","진행률"};
		
	    //ROW 생성 LOOP  
	    for(int r=0; r < exList.size();r++){
	    	HashMap<String, String> map = exList.get(r);
	    	
    		List<Object> obj = new ArrayList<Object>();	
	    	//header setting 
	    	if(r==0){
	    		for(int k = 0; k < keyVal.length; k++){
	    			header.add(keyVal[k]);
	    			if("과정시간".equals(keyVal[k])){
	    				obj.add(String.valueOf(TldUtil.secToHour(String.valueOf(map.get("play_duration_sec"))) + " / " + TldUtil.secToHour(String.valueOf(map.get("totDuration")))));
	    			}else if("진행률".equals(keyVal[k])){ 
	    				obj.add(String.valueOf(Integer.parseInt(String.valueOf(map.get("play_duration_sec"))) * 100 / Integer.parseInt(String.valueOf(map.get("totDuration")))) + "%"); 
	    			}else{
	    				obj.add(String.valueOf(map.get(keyVal[k])));
	    			}    		
	    		}
	    	}else{
		    	//data setting 
	    		for(int k = 0; k < keyVal.length; k++){
	    			if("과정시간".equals(keyVal[k])){
	    				obj.add(String.valueOf(TldUtil.secToHour(String.valueOf(map.get("play_duration_sec"))) + " / " + TldUtil.secToHour(String.valueOf(map.get("totDuration")))));
	    			}else if("진행률".equals(keyVal[k])){ 
	    				obj.add(String.valueOf(Integer.parseInt(String.valueOf(map.get("play_duration_sec"))) * 100 / Integer.parseInt(String.valueOf(map.get("totDuration")))) + "%"); 
	    			}else{
	    				obj.add(String.valueOf(map.get(keyVal[k])));
	    			}
	    		}
	    	}
	    	
    		data.add(obj);
	    }

		ExcelUtil excel = new ExcelUtil(header ,data);
		excel.setSheetName("sheet1");
		excel.setWidth(6000);
		
		byte[] bytes = excel.makeExcel();
		
        String userAgent = request.getHeader("User-Agent");
        boolean br = userAgent.indexOf("Chrome") > -1;
        
        String fileName = "e-러닝 리스트_" + DateUtil.getCurrentDateTime();
        String docName ="";        	   
        
        if(br){
        	docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
        } else {
        	docName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
        }
		
		response.setHeader("Content-Disposition", "attachment; filename="+docName+".xlsx");
		response.setContentLength(bytes.length);
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Pragma", "no-cache");		
		response.setHeader("Cache-Control", "private");
		response.setHeader("Expires", "0");
		return bytes;
	}
    
    class KubeModelAndView extends ModelAndView {

    	/**
    	 * ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	 * kube메뉴는 레프트 메뉴 항상 가져와서 처리해야 함
    	 */
    	public KubeModelAndView(KubeAdminService kubeService, HttpServletRequest request) {
    		try{
    			
    			HttpSession session = request.getSession();
    			@SuppressWarnings("unchecked")
				List<HashMap<String, String>> kube_menu = (List<HashMap<String, String>>) session.getAttribute("SESS_KUBE_MENU");
				//System.out.println(kube_menu);
				
				//큐브 레프트 메뉴 가져오기
				if(kube_menu != null
						&& kube_menu.size() > 0){
					this.addObject("kubeLeftMenu", session.getAttribute("SESS_KUBE_MENU"));
				}else{
					session.setAttribute("SESS_KUBE_MENU", kubeService.getLeftMenu((String) request.getSession().getAttribute("SESS_EMPNO")));
					
					this.addObject("kubeLeftMenu", session.getAttribute("SESS_KUBE_MENU"));
				}
    		}catch(Exception e){
    			e.printStackTrace();
    		}
    	}
    }
}
