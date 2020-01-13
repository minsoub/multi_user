package kr.co.neodreams.multi_user.controller;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.dto.PowerstatusDto;
import kr.co.neodreams.multi_user.service.PowerstatusService;

@Controller
public class ManagementController extends BaseController {

	@Autowired
	PowerstatusService powerstatusService;
	
	@RequestMapping("/scheduling.do")
	public ModelAndView Scheduling(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		
		//시연용 가라 empno 사용하기 위한 파라메터
		String empno = request.getParameter("empno");
		String region = "newmedia_schedule";
		
		try{
			if(StringUtil.isEmpty(empno)){
				empno = SESS_EMPNO;
			}
			
			PowerstatusDto dept_nameDto = powerstatusService.getDeptNameInfo(empno);
			
			if(dept_nameDto != null){
				String dept_name_1depth = dept_nameDto.getDept_name_1depth();
				
				BufferedReader fileReader = new BufferedReader(new InputStreamReader(new FileInputStream(Constants.CUSTOM_DISPLAY_JSON_FILE),"UTF-8"));
				
				JSONParser p = new JSONParser();
				
				JSONObject jsonObj   = (JSONObject)p.parse(fileReader);
	
				JSONArray cdGroup = (JSONArray) jsonObj.get("place_dept");
				
				if(cdGroup != null
						&& cdGroup.size() > 0){
	
					int cdGroupSize = cdGroup.size();
					
					for(int i = 0; i < cdGroupSize; i++){
						
						JSONObject cdinfo = (JSONObject) cdGroup.get(i);
					
						if(cdinfo.get("name").equals(dept_name_1depth)
								&& StringUtil.isNotEmpty(String.valueOf(cdinfo.get("location_code")))){
							region = region + "_" + cdinfo.get("location_code");
						}
					}
					mv.setViewName("/management/scheduling");
					mv.addObject("empno", empno);
					mv.addObject("region", region);
					mv.addObject("success", "Y");
					
				}else{
					System.out.println("scheduling err........" + SESS_EMPNO);
				}
			}else{
				System.out.println("scheduling err........" + SESS_EMPNO);
			}
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}
		
		return mv;
	}
	
	@RequestMapping("/businessStatus.do")
	public ModelAndView businessStatus(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/management/businessStatus");
		return mv;
	}
}
