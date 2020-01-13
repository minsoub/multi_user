package kr.co.neodreams.multi_user.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.Address;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.CommonUtil;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.DateUtil;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.common.mail.SendMail;
import kr.co.neodreams.multi_user.dto.EquipManageDto;
import kr.co.neodreams.multi_user.dto.PowerstatusDto;
import kr.co.neodreams.multi_user.dto.RentDto;
import kr.co.neodreams.multi_user.service.EquipManageService;
import kr.co.neodreams.multi_user.service.PowerstatusService;
import kr.co.neodreams.multi_user.service.RentService;
import net.arnx.jsonic.JSON;
import net.sf.json.JSONObject;

import org.apache.commons.beanutils.converters.IntegerArrayConverter;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author user
 *
 */
@Controller
public class InterLockingWithMKController extends BaseController{

    /**
     * @param HttpServletRequest
     * @return view(popup/appPopView)
     * 장비대여 설비 현황 > 장비 상세보기 팝업화면
     */
    @RequestMapping("/iLWithMk.do")
    public ModelAndView appPopView(HttpServletRequest request){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("rent/iLWithMk");

        /*검색용*/
        EquipManageDto searchDto = new EquipManageDto ();
        /*세션에서 사번취득 후 삽입*/
        String sM_MEMPNO = SESS_EMPNO;
        searchDto.setSM_MEMPNO(sM_MEMPNO);

        String userName = request.getParameter("userName");
        if (StringUtils.isEmpty(userName)) {
            mv.setViewName("/error/error");
            return mv;
        }

        String posName = request.getParameter("posName");
        if (StringUtils.isEmpty(posName)) {
            mv.setViewName("/error/error");
            return mv;
        }

        /*결과 반환용*/
        EquipManageDto equipDto = new EquipManageDto ();
        try {
            mv.addObject("flag", "Y");
            mv.addObject("date", DateUtil.getCurrentDate());
            mv.addObject("userName", userName);
            mv.addObject("posName", posName);
        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        return mv;
    }

}
