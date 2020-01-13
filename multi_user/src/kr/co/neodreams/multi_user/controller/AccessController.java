package kr.co.neodreams.multi_user.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ibm.icu.util.Calendar;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.dto.AccessDto;
import kr.co.neodreams.multi_user.dto.EquipManageDto;
import kr.co.neodreams.multi_user.dto.RentDto;
import kr.co.neodreams.multi_user.service.AccessService;
import kr.co.neodreams.multi_user.service.EquipManageService;

@Controller
public class AccessController extends BaseController {
	
	@Autowired
	AccessService accessService;	
	
    @Autowired
    EquipManageService equipManageService;
	
	/* 장비대여 > 관리메뉴 > 출입대장관리  */    
    @RequestMapping("/admin/access.do")
    public ModelAndView accessList(HttpServletRequest request, HttpServletResponse response) throws Exception {

    	ModelAndView mv = new ModelAndView();
    	
    	/*매월 첫째날*/
    	Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        int year = cal.get(Calendar.YEAR);
        int month = (cal.get(Calendar.MONTH)+1);
        String startDate = year + "-" + (month < 10 ? "0" + month : month) + "-01";
        
        String strdt = request.getParameter("sch_strdt");
        if (StringUtil.isEmpty(strdt)){
            strdt = startDate;
        }
        mv.addObject("sch_strdt", strdt);

        String enddt = request.getParameter("sch_enddt");
        if (StringUtil.isEmpty(enddt)){
            enddt = sdf.format(cal.getTime());
        }
        mv.addObject("sch_enddt", enddt);
        
        String empno = request.getParameter("empno");
      
        AccessDto ad = new AccessDto();
        ad.setSTDT(strdt.replaceAll("-", ""));
        ad.setEDDT(enddt.replaceAll("-", ""));
        List<AccessDto> list = accessService.accessList(ad);

        mv.setViewName("rent/admin/access");      
        mv.addObject("accessList", list);
        
        return mv;
    }
    
    @RequestMapping("/admin/accessEnter.do")
    public void accessEnter(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String appno = request.getParameter("appno");
        System.out.println("appno : " + appno);
        try {
        	/*검색용*/
            EquipManageDto searchDto = new EquipManageDto();            
            searchDto.setAppno(appno);
        	/*결과 반환용*/
            EquipManageDto equipDto = new EquipManageDto();
            equipDto = equipManageService.getAppTblInfo(searchDto);

        	AccessDto ad = new AccessDto();
        	ad.setACCENO(equipDto.getAppeno());
        	ad.setACCENM(equipDto.getAppenm());
        	ad.setACCSS(equipDto.getAppss());
        	ad.setACCUSEOBJ(equipDto.getUseobj());
        	ad.setAPPNO(Integer.parseInt(equipDto.getAppno()));
            accessService.insertAccessEnter(ad);

        } catch (Exception e) {
            e.printStackTrace();
        } 

    }
}
