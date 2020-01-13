package kr.co.neodreams.multi_user.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.CommonUtil;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.dto.EquipManageDto;
import kr.co.neodreams.multi_user.dto.UserRentScreenDto;
import kr.co.neodreams.multi_user.service.EquipManageService;
import kr.co.neodreams.multi_user.service.UserRentScreenService;

@Controller
public class UserRentalScreenController extends BaseController {
	
	@Autowired
	UserRentScreenService userRentScreenService;
	
	@Autowired
    EquipManageService equipManageService;
	
	
	/* 장비대여 > 관리메뉴 > 접수현황 > 사용자 대여 물품 팝업 */    
    @RequestMapping("/admin/userRentList.do")
    public ModelAndView userRentList(HttpServletRequest request, HttpServletResponse response) throws Exception {

    	ModelAndView mv = new ModelAndView();
    	
        String empno = request.getParameter("empno");
      
        List<UserRentScreenDto> list = userRentScreenService.userRentList(empno);

        mv.setViewName("rent/admin/sign/userRentalScreen");      
        mv.addObject("userRentList", list);
        
        return mv;
    }
    
    /**
     * @param HttpServletRequest
     * @return view(/rent/admin/sign/userRentalScreen)
     * 장비대여 > 관리메뉴 > 접수현황 > 서명 확인 팝업
     */
    @RequestMapping("/admin/signConfirm.do")
    public ModelAndView signConfirm(HttpServletRequest request, Model model){
        ModelAndView mv = new ModelAndView();

        /*검색용*/
        EquipManageDto searchDto = new EquipManageDto();
        /*세션에서 사번취득 후 삽입*/
        String sM_MEMPNO = SESS_EMPNO;
        searchDto.setSM_MEMPNO(sM_MEMPNO);


        String appno = request.getParameter("appno");


        try {
            /*결과 반환용*/
            EquipManageDto recViewInfo = new EquipManageDto();

            /*장비정보취득*/
            searchDto.setAppno(appno);
            recViewInfo = equipManageService.getRecViewInfo(searchDto);

            String status = recViewInfo.getStatus();
            String approval = recViewInfo.getApproval();
            if(recViewInfo.equals(null)) {
                model.addAttribute("msg", "잘못된 접근입니다.");
                mv.setViewName("/error/errorAlert");
                return mv;
            }

            List<EquipManageDto> modelList = new ArrayList<EquipManageDto> ();
            modelList = equipManageService.getAmountForModel(searchDto);

            Map<String, Object> assignedMap = new LinkedHashMap<String, Object> ();
            for(int i = 0; i < modelList.size(); i++) {
                EquipManageDto modelDto = new EquipManageDto ();

                modelDto = modelList.get(i);
                /*모델정보취득*/
                EquipManageDto modelInfo = equipManageService.getModelInfo(modelDto).get(0);

                if(modelDto.equals(null)) {
                    model.addAttribute("msg", "모델 정보가 존재하지 않습니다.");
                    mv.setViewName("error/errorAlert");
                    return mv;
                }

                modelDto.setGbcd(modelInfo.getGbcd());
                modelDto.setMdnm(modelInfo.getMdnm());

                /*장비정보취득*/
                EquipManageDto codeInfo = equipManageService.getCodeInfo(modelDto);
                modelDto.setGbnm(codeInfo.getGbnm());

                List<EquipManageDto> assignedEquipList = new ArrayList<EquipManageDto> ();
                assignedEquipList = equipManageService.getAssignedEquipInfo(modelDto);
                assignedMap.put(String.valueOf(i), assignedEquipList);
                modelDto.setAssignedAmount(assignedEquipList.size());
                modelList.set(i, modelDto);
            }

            mv.addObject("appno", appno);
            mv.addObject("modelList", modelList);
            mv.addObject("assignedMap", assignedMap);
            mv.addObject("view", recViewInfo);

            Map<String, Object> configMap = Constants.getConfigOption();
            mv.addObject("appstArr", configMap.get("appstArr"));
            mv.addObject("approvalArr", configMap.get("approvalArr"));
            mv.addObject("banpArr", configMap.get("banpArr"));

            String[] cancelView = {status, approval};
            mv.addObject("cancelView", cancelView);

            mv.setViewName("rent/admin/sign/userRentalScreen");
        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        return mv;
    }
}
