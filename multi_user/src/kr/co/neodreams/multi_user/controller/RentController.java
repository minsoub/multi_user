package kr.co.neodreams.multi_user.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.mail.Address;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.converters.IntegerArrayConverter;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.Base64ImageUtil;
import kr.co.neodreams.multi_user.common.CommonUtil;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.DateUtil;
import kr.co.neodreams.multi_user.common.NeoUtil;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.common.mail.SendMail;
import kr.co.neodreams.multi_user.common.sms.SendSMS;
import kr.co.neodreams.multi_user.dto.RentDto;
import kr.co.neodreams.multi_user.service.EquipManageService;
import kr.co.neodreams.multi_user.service.RentService;
import net.sf.json.JSONObject;

/**
 * 장비대여 Controller
 * @author minso
 *
 */
@Controller
public class RentController extends BaseController {

    @Autowired
    RentService rentService;

    @Autowired
    EquipManageService equipManageService;

    @Autowired
    DataSourceTransactionManager dataSourceTransactionManager;

    @Resource(name = "commonUtil")
    private CommonUtil commonUtil;

    /* 이용안내 */
    @RequestMapping("/equipManual.do")
    public ModelAndView equipManual() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/rent/equipManual");
        return mv;
    }

    /* 마이페이지 */
    @RequestMapping("/appList.do")
    public ModelAndView appList(RentDto rentDto) throws Exception {
        ModelAndView mv = new ModelAndView();

        List<RentDto> appList = null;
        List<RentDto> codeList = null;
        int totalCnt = 0;

        try {

            /* 사용자 세션 정보 입력 */
            rentDto.setREGENO(SESS_EMPNO);
            appList = rentService.appList(rentDto);
            codeList = rentService.codeList(rentDto);
            totalCnt = rentService.getAppListCnt(rentDto);

            for (int i = 0; i < appList.size(); i++) {
                rentDto.setIS_CANCEL(false);
                String status = appList.get(i).getSTATUS();
                String approval = appList.get(i).getAPPROVAL();

                /* 접수 취소 여부 */
                appList.get(i).setIS_CANCEL(isCancel(status, approval));
                /* 접수 상태 문자 변환 */
                appList.get(i).setSTATUSSTR(statusStr(status, approval));
            }

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        mv.addObject("appList", appList);
        mv.addObject("codeList", codeList);
        mv.addObject("rentDto", rentDto);
        mv.addObject("totalCnt", totalCnt);
        mv.addObject("paging", rentDto);
        mv.setViewName("/rent/appList");
        return mv;
    }

    /* 접수 취소 여부 로직 */
    public static boolean isCancel(String status, String approval)
            throws Exception {
        if (!status.equals("") || !approval.equals("")) {
            if ((status.equals("1") || status.equals("3"))
                    && !approval.equals("3")) {
                return true;
            }
        }
        return false;
    }

    /* 상태 여부 문자 변환 로직 */
    public static String statusStr(String status, String approval)
            throws Exception {
        String statusStr = "";
        if ((approval.equals("2") || approval.equals("3"))
                && status.equals("3")) {
            statusStr = Constants.approvalToStr(approval);
        } else {
            statusStr = Constants.appstToStr(status);
        }
        return statusStr;
    }

    /* 마이페이지 상세정보 가져오기 */
    @ResponseBody
    @RequestMapping("/loadAppModel.do")
    public void loadAppModel(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        String appno = request.getParameter("appno");
        ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
        HashMap<String, Object> map = null;
        HashMap<String, Object> appMap = null;
        boolean retVal = false;
        RentDto appInfo = null;

        try {

            RentDto rentDto = new RentDto();
            rentDto.setAPPNO(Integer.parseInt(appno));
            appInfo = rentService.getAppInfo(rentDto);

            appMap = new HashMap<String, Object>();

            appMap.put("status", appInfo.getSTATUS());
            appMap.put("appinsuno", appInfo.getAPPINSUNO());
            appMap.put("appinsunm", appInfo.getAPPINSUNM());
            appMap.put("mailapproval", appInfo.getMAILAPPROVAL());
            appMap.put("ingaeno", appInfo.getINGAENO());
            appMap.put("ingaenm", appInfo.getINGAENM());
            appMap.put("insuno", appInfo.getINSUNO());
            appMap.put("insunm", appInfo.getINSUNM());
            appMap.put("uhseq", appInfo.getUHSEQ());


            List<RentDto> resultModelList = rentService.getAppListView(rentDto);

            for (int i = 0; i < resultModelList.size(); i++) {

                map = new HashMap<String, Object>();
                if (!resultModelList.get(i).getGBCD().isEmpty()) {

                    rentDto.setGBCD(resultModelList.get(i).getGBCD());
                    RentDto codeInfo = rentService.getCodeInfo(rentDto);

                    if (!codeInfo.getGBNM().isEmpty()) {
                        map.put("gbnm", codeInfo.getGBNM());
                    }
                    map.put("mdnm", resultModelList.get(i).getMDNM());
                    map.put("mdseq", resultModelList.get(i).getMDSEQ());
                    map.put("eqno", resultModelList.get(i).getEQNO());
                    map.put("amount", resultModelList.get(i).getAMOUNT());
                    map.put("euseq", resultModelList.get(i).getEUSEQ());
                    map.put("appueno", resultModelList.get(i).getAPPUENO());
                    map.put("appuenm", resultModelList.get(i).getAPPUENM());
                    map.put("eqnm", resultModelList.get(i).getEQNM());
                    map.put("eqalias", resultModelList.get(i).getEQALIAS());
                    map.put("uhseq", resultModelList.get(i).getUHSEQ());
                    map.put("ingaeno", resultModelList.get(i).getINGAENO());
                    map.put("ingaenm", resultModelList.get(i).getINGAENM());
                    map.put("insuno", resultModelList.get(i).getINSUNO());
                    map.put("insunm", resultModelList.get(i).getINSUNM());
                    map.put("mailapproval", resultModelList.get(i).getMAILAPPROVAL());

                    list.add(map);
                }

            }

            retVal = true;

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            retVal = false;
        } finally {

            if (retVal != false) {

                JSONObject json = new JSONObject();
                json.put("model_list", list);
                json.put("appInfo", appMap);

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print(json.toString());

            } else {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print("false");

            }
        }

    }

    /* 장기대여 결재 취소시 장비대여 취소 프로세스 */
    @RequestMapping("/rentSignCancel.do")
    public String rentSignCancel(HttpServletRequest request) throws Exception {

        String appno = request.getParameter("appno");
        boolean retVal = false;

        try {

            RentDto rentDto = new RentDto();
            rentDto.setUSER_EMPNO(SESS_EMPNO);

            if (!StringUtils.isEmpty(appno)) {

                rentDto.setAPPNO(Integer.parseInt(appno));
                RentDto appStatusInfo = rentService.getAppStatusInfo(rentDto);

                if (isCancel(appStatusInfo.getSTATUS(), appStatusInfo.getAPPROVAL())) {

                    /* 사용자취소로 변경 (취소코드가 사용자취소밖에 없음) */
                    rentService.updAppCancel(rentDto);

                    /* 이전에는 결제완료후 최종승인이면 이력을 남기기위해 상태값 변경처리로직을 구현했으나 지금은 모두 삭제처리 */
                    /*
                    * List<RentDto> signInfo =
                    * rentService.getSignInfo(rentDto); if(signInfo.size() >
                    * 0){
                    *
                    * for ( int i = 0 ; i < signInfo.size() ; i++ ){ if (
                    * signInfo.get(i).getSTATUS().equals("3") &&
                    * signInfo.get(i).getREG_SIGN().equals("Y") ) {
                    *
                    * 배정된 설비 삭제 rentService.delAppEquip(rentDto);
                    * System.out.println("배정된 설비 삭제");
                    *
                    * sending mail.. } }
                    *
                    * }
                    */

                    /* 배정된 설비 삭제 */
                    rentService.delAppEquip(rentDto);
                    WebUtils.setSessionAttribute(request, "resultMessage",
                            "취소 되었습니다.");
                    retVal = true;

                } else {
                    WebUtils.setSessionAttribute(request, "resultMessage",
                            "취소가능 상태가 아닙니다.");
                }

            } else {
                WebUtils.setSessionAttribute(request, "resultMessage",
                        "취소에 실패하였습니다.");
            }

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        return "redirect:/equipRentList.do";

    }

    /* 마이페이지 장비대여 취소 */
    @RequestMapping("/appCancel.do")
    public String appCancel(HttpServletRequest request) throws Exception {

        String appno = request.getParameter("appno");
        boolean retVal = false;

        try {

            RentDto rentDto = new RentDto();
            rentDto.setUSER_EMPNO(SESS_EMPNO);

            if (!StringUtils.isEmpty(appno)) {

                rentDto.setAPPNO(Integer.parseInt(appno));
                RentDto appStatusInfo = rentService.getAppStatusInfo(rentDto);

                if (isCancel(appStatusInfo.getSTATUS(), appStatusInfo.getAPPROVAL())) {

                    /* 사용자취소로 변경 (취소코드가 사용자취소밖에 없음) */
                    rentService.updAppCancel(rentDto);

                    /* 이전에는 결제완료후 최종승인이면 이력을 남기기위해 상태값 변경처리로직을 구현했으나 지금은 모두 삭제처리 */
                    /*
                    * List<RentDto> signInfo =
                    * rentService.getSignInfo(rentDto); if(signInfo.size() >
                    * 0){
                    *
                    * for ( int i = 0 ; i < signInfo.size() ; i++ ){ if (
                    * signInfo.get(i).getSTATUS().equals("3") &&
                    * signInfo.get(i).getREG_SIGN().equals("Y") ) {
                    *
                    * 배정된 설비 삭제 rentService.delAppEquip(rentDto);
                    * System.out.println("배정된 설비 삭제");
                    *
                    * sending mail.. } }
                    *
                    * }
                    */

                    /* 배정된 설비 삭제 */
                    rentService.delAppEquip(rentDto);
                    WebUtils.setSessionAttribute(request, "resultMessage",
                            "취소 되었습니다.");
                    retVal = true;

                } else {
                    WebUtils.setSessionAttribute(request, "resultMessage",
                            "취소가능 상태가 아닙니다.");
                }

            } else {
                WebUtils.setSessionAttribute(request, "resultMessage",
                        "취소에 실패하였습니다.");
            }

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        return "redirect:/appList.do";

    }

    /* 장비대여 > 장바구니 > 리스트 */
    @RequestMapping("/basketList.do")
    public ModelAndView basketList(RentDto rentDto) throws Exception {
        ModelAndView mv = new ModelAndView();
        rentDto.setREGENO(SESS_EMPNO);
        List<RentDto> basketList = rentService.basketList(rentDto);
        ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

        for (int i = 0; i < basketList.size(); i++) {
            HashMap<String, Object> map = new HashMap<String, Object>();

            rentDto.setMDSEQ(basketList.get(i).getMDSEQ());
            RentDto model = rentService.getModelInfo(rentDto);
            rentDto.setGBCD(model.getGBCD());
            RentDto code = rentService.getCodeInfo(rentDto);

            map.put("gbnm", code.getGBNM());
            map.put("mdseq", model.getMDSEQ());
            map.put("mdnm", model.getMDNM());
            map.put("bskno", basketList.get(i).getBSKNO());
            map.put("strdt", basketList.get(i).getSTRDT());
            map.put("enddt", basketList.get(i).getENDDT());
            map.put("amount", basketList.get(i).getAMOUNT());
            list.add(map);
        }

        mv.addObject("list", list);
        mv.setViewName("/rent/basketList");

        return mv;
    }

    /* 장비대여 > 장바구니 > 리스트 > 데이터삭제 */
    @ResponseBody
    @RequestMapping("/deleteBasket.do")
    public void deleteBasket(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        Boolean retVal = false;

        try {

            Integer[] bskno_arr = ArrayUtils.toObject((int[]) new IntegerArrayConverter().convert(null,request.getParameterValues("bskno[]")));

            RentDto rentDto = new RentDto();
            rentDto.setREGENO(SESS_EMPNO);

            if (bskno_arr.length > 1) {
                rentDto.setBSKNO_ARR(bskno_arr);
            } else {
                rentDto.setBSKNO(bskno_arr[0]);
            }

            List<RentDto> basketList = rentService.basketList(rentDto);

            if (basketList.size() == bskno_arr.length) {
                rentService.deleteBasket(rentDto);
                retVal = true;
            }

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            retVal = false;
        } finally {

            if (retVal != false) {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print("true");

            } else {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print("false");

            }

        }

    }

    /* 장비대여 > 관리메뉴 > 설정관리 > 코드관리 */
    @RequestMapping("/admin/code.do")
    public ModelAndView code(RentDto rentDto, HttpServletRequest request)
            throws Exception {

        String gbcd = request.getParameter("gbcd");
        String codeLevel = request.getParameter("codeLevel") == null ? "1"
                : request.getParameter("codeLevel");
        String upcode = request.getParameter("upcode");
        String perPage = request.getParameter("perPage") == null ? "1"
                : request.getParameter("perPage");
        rentDto.setPerPageCnt(15);

        ModelAndView mv = new ModelAndView();
        List<RentDto> codeSelectLv1 = null;
        List<RentDto> codeSelectLv2 = null;

        try {

            /* gbcd 데이터 체크 */
            if (gbcd != null) {
                rentDto.setGBCD(gbcd);
                rentDto.setGBLEV(codeLevel);
                List<RentDto> codeGbcd = rentService.code(rentDto);

                if (codeGbcd.size() == 1) {
                    mv.addObject("gbnm", codeGbcd.get(0).getGBNM());
                    mv.addObject("gbyn", codeGbcd.get(0).getGBYN());
                    mv.addObject("eqhno", codeGbcd.get(0).getEQHNO());
                }
                rentDto.setGBCD(null);
            }

            if (Integer.parseInt(codeLevel) > 1) {
                switch (Integer.parseInt(codeLevel)) {
                /* 코드레벨 소 구분관리 화면 로딩시 */
                case 3:
                    rentDto.setGBLEV("1");
                    codeSelectLv1 = rentService.code(rentDto);
                    if (upcode != null && !upcode.equals("")) {
                        rentDto.setGBLEV("2");
                        rentDto.setGBUP(upcode.substring(0, 3));
                        codeSelectLv2 = rentService.code(rentDto);
                        rentDto.setGBUP(null);
                    }
                    break;
                /* 코드레벨 중 구분관리 화면 로딩시 */
                case 2:
                    rentDto.setGBLEV("1");
                    codeSelectLv1 = rentService.code(rentDto);
                    break;
                }

            }

            /* 코드별 분류영역 조정 */
            if (upcode != null) {
                switch (upcode.length()) {
                case 3:
                    rentDto.setSTRIDX(4);
                    rentDto.setUPCODE(upcode);
                    break;
                case 6:
                    rentDto.setSTRIDX(7);
                    rentDto.setUPCODE(upcode);
                    break;
                }
            }

            rentDto.setGBLEV(codeLevel);
            rentDto.setPAGESET("ON");
            rentDto.setORDCOLUMN("GBCD");
            rentDto.setORDTYPE("ASC");
            List<RentDto> codeList = rentService.code(rentDto);
            int totalCnt = rentService.getCodeCnt(rentDto);
            ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

            for (int i = 0; i < codeList.size(); i++) {
                HashMap<String, Object> map = new HashMap<String, Object>();

                map.put("gbcd", codeList.get(i).getGBCD());
                map.put("gbnm", codeList.get(i).getGBNM());
                map.put("gbyn", codeList.get(i).getGBYN());
                map.put("eqhno", codeList.get(i).getEQHNO());

                switch (codeList.get(i).getGBCD().length()) {
                case 6:
                    map.put("linkUpcode", "&upcode="
                            + codeList.get(i).getGBCD().substring(0, 3));
                    break;
                case 9:
                    map.put("linkUpcode", "&upcode="
                            + codeList.get(i).getGBCD().substring(0, 6));
                    break;
                default:
                    map.put("linkUpcode", "");
                    break;
                }

                list.add(map);
            }

            mv.addObject("gbcd", gbcd);
            mv.addObject("codeLevel", codeLevel);
            mv.addObject("upcode", upcode);
            mv.addObject("list", list);
            mv.addObject("totalCnt", totalCnt);
            mv.addObject("paging", rentDto);
            mv.addObject("codeSelectLv1", codeSelectLv1);
            mv.addObject("codeSelectLv2", codeSelectLv2);
            mv.setViewName("/rent/admin/code");

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        return mv;
    }

    /* 장비대여 > 관리메뉴 > 설정관리 > 코드관리 - 데이터 저장 */
    @RequestMapping("/admin/saveCode.do")
    public String saveCode(RentDto rentDto, HttpServletRequest request)
            throws Exception {

        String gbcd = request.getParameter("gbcd");
        String codeLevel = request.getParameter("codeLevel") == null ? "1"
                : request.getParameter("codeLevel");
        String upcode = request.getParameter("upcode");
        String gbnm = request.getParameter("gbnm");
        String gbyn = request.getParameter("gbyn");
        String eqhno = request.getParameter("eqhno");

        if (getAdminChk(SESS_EMPNO)) {

            if (!gbcd.isEmpty() && gbcd != null) {

                DefaultTransactionDefinition def = new DefaultTransactionDefinition();
                def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
                TransactionStatus status = dataSourceTransactionManager
                        .getTransaction(def);

                try {

                    /* gbcd값이 있을시 데이터 수정 */
                    rentDto.setGBCD(gbcd);
                    rentDto.setGBNM(gbnm);
                    rentDto.setGBYN(gbyn);

                    if (codeLevel.equals("1")) {
                        rentDto.setEQHNO(eqhno);
                    } else {
                        rentDto.setEQHNO(null);
                    }

                    rentService.updCode(rentDto);

                    /* 해당 gbcd코드 하위코드 사용여부처리 */
                    List<RentDto> subCodeList = rentService.getSubCode(rentDto);
                    for (int i = 0; i < subCodeList.size(); i++) {
                        rentDto.setGBCD(subCodeList.get(i).getGBCD());
                        rentDto.setGBNM(null);
                        rentDto.setEQHNO(null);
                        rentDto.setGBYN(gbyn);
                        rentService.updCode(rentDto);
                    }

                    dataSourceTransactionManager.commit(status);

                } catch (Exception e) {
                    // TODO: handle exception
                    e.printStackTrace();
                    dataSourceTransactionManager.rollback(status);
                }

            } else {

                try {

                    /* gbcd값이 없을시 데이터 등록 */
                    rentDto.setGBCDLEN(Integer.parseInt(codeLevel) * 3);

                    if (upcode != null) {
                        rentDto.setUPCODE(upcode);
                        rentDto.setSTRIDX(upcode.length());
                    }

                    String gbcdMax = rentService.getMaxGbcd(rentDto);

                    String inGbcd = "";

                    if (StringUtils.isEmpty(gbcdMax)) {
                        inGbcd = upcode + "001";
                    } else {
                        inGbcd = NeoUtil.appendLeft(
                                String.valueOf(Integer.parseInt(gbcdMax) + 1),
                                "0", (Integer.parseInt(codeLevel) * 3));
                    }

                    rentDto.setGBCD(inGbcd);
                    rentDto.setGBUP(upcode);
                    rentDto.setGBNM(gbnm);
                    rentDto.setGBYN(gbyn);
                    rentDto.setGBLEV(codeLevel);

                    if (codeLevel.equals("1")) {
                        rentDto.setEQHNO(eqhno);
                    }

                    rentService.insCode(rentDto);

                } catch (Exception e) {
                    // TODO: handle exception
                    e.printStackTrace();
                }

            }

        } else {
            WebUtils.setSessionAttribute(request, "resultMessage",
                    "관리자만 접근 가능합니다.");
        }

        return "redirect:/admin/code.do?gbcd=" + gbcd + "&codeLevel="
                + codeLevel + "&upcode=" + upcode;
    }

    /* 장비대여 > 관리메뉴 > 설정관리 > 코드관리 - 데이터 삭제 */
    @RequestMapping("/admin/deleteCode.do")
    public String deleteCode(RentDto rentDto, HttpServletRequest request)
            throws Exception {

        String gbcd = request.getParameter("gbcd");
        String codeLevel = request.getParameter("codeLevel") == null ? "1"
                : request.getParameter("codeLevel");
        String upcode = request.getParameter("upcode");

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = dataSourceTransactionManager
                .getTransaction(def);

        try {

            /* 해당 gbcd코드 삭제처리 */
            rentDto.setGBCD(gbcd);
            rentDto.setDELYN("Y");
            rentDto.setGBYN("N");
            rentService.updCode(rentDto);

            /* 해당 gbcd코드 하위코드 삭제처리 */
            List<RentDto> subCodeList = rentService.getSubCode(rentDto);
            for (int i = 0; i < subCodeList.size(); i++) {
                rentDto.setGBCD(subCodeList.get(i).getGBCD());
                rentDto.setDELYN("Y");
                rentDto.setGBYN("N");
                rentService.updCode(rentDto);
            }

            dataSourceTransactionManager.commit(status);

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            dataSourceTransactionManager.rollback(status);
        }

        return "redirect:/admin/code.do?" + "&codeLevel=" + codeLevel
                + "&upcode=" + upcode;
    }

    /* 장비대여 > 관리메뉴 > 설정관리 > 관리자관리 */
    @RequestMapping("/admin/adminList.do")
    public ModelAndView adminList(RentDto rentDto, HttpServletRequest request)
            throws Exception {
        ModelAndView mv = new ModelAndView();

        List<RentDto> adminList = rentService.adminList(rentDto);
        mv.addObject("adminList", adminList);
        mv.setViewName("/rent/admin/adminList");
        return mv;
    }

    /* 장비대여 > 관리메뉴 > 설정관리 > 관리자관리 > 관리자삭제 */
    @ResponseBody
    @RequestMapping("/admin/deleteAdmin.do")
    public void deleteAdmin(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        String[] empno_arr = request.getParameterValues("empno_arr[]");
        boolean retVal = false;

        try {

            RentDto rentDto = new RentDto();
            rentDto.setEMP_ID_ARR(empno_arr);
            rentService.deleteAdmin(rentDto);
            retVal = true;

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            retVal = false;
        } finally {

            if (retVal != false) {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print("true");

            } else {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print("false");

            }
        }

    }

    /* 장비대여 > 관리메뉴 > 설정관리 > 관리자관리 > 메일전송여부 */
    @ResponseBody
    @RequestMapping("/admin/isReceipt.do")
    public void isReceipt(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        String empno = request.getParameter("empno");
        String get_mail = request.getParameter("get_mail");
        boolean retVal = false;

        try {

            RentDto rentDto = new RentDto();
            rentDto.setEMP_ID(empno);
            rentDto.setGET_MAIL(get_mail);
            rentService.updateAdmin(rentDto);
            retVal = true;

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            retVal = false;
        } finally {

            if (retVal != false) {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print("true");

            } else {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print("false");

            }
        }

    }

    /* 장비대여 > 관리메뉴 > 설정관리 > 관리자관리 > 관리자등록페이지 */
    @RequestMapping("/admin/adminRegist.do")
    public ModelAndView adminRegist() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/rent/admin/adminRegist");
        return mv;
    }

    /* 장비대여 > 관리메뉴 > 설정관리 > 관리자관리 > 관리자등록 */
    @RequestMapping("/admin/insertAdmin.do")
    public String insertAdmin(RentDto rentDto, HttpServletRequest request) throws Exception {

        String empno = request.getParameter("empno");
        String empnm = request.getParameter("empnm");
        String deptnm = request.getParameter("deptnm");
        String getmail = request.getParameter("get_mail");

        try {


            rentDto.setEMP_ID(empno);
            int empidChk = rentService.empidChk(rentDto);

            if (empidChk > 0) {
                WebUtils.setSessionAttribute(request, "resultMessage", "이미 등록된 관리자 입니다.");
            } else {

                rentDto.setEMP_ID(empno);
                rentDto.setEMP_NM(empnm);
                rentDto.setDEPT_NM(deptnm);
                rentDto.setGET_MAIL(getmail);

                rentService.insertAdmin(rentDto);
                WebUtils.setSessionAttribute(request, "resultMessage", "저장 되었습니다.");
            }

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }



        return "redirect:/admin/adminList.do";
    }

    /* 장비대여 > 관리메뉴 > 설정관리 > 관리자관리 > 직원검색 */
    @ResponseBody
    @RequestMapping("/admin/searchAdmin.do")
    public void searchAdmin(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        String empno = request.getParameter("empno");
        String name = request.getParameter("name");
        List<RentDto> searchMember = null;
        boolean retVal = false;

        try {

            RentDto rentDto = new RentDto();
            rentDto.setEMP_ID(empno);
            rentDto.setNAME(name);
            searchMember = rentService.searchAdmin(rentDto);
            retVal = true;

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            retVal = false;
        } finally {

            if (retVal != false) {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print("true");

            } else {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print("false");

            }
        }

    }

    /* 장비대여 > 관리메뉴 > 설정관리 > 모델관리 */
    @RequestMapping("/admin/stanModelList.do")
    public ModelAndView stanModelList(RentDto rentDto,
            HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();
        int totalCnt = 0;
        List<RentDto> stanModelList = null;
        List<RentDto> codeList = null;
        String gbcd = "";
        String mdseq = request.getParameter("mdseq");

        try {

            /* 대분류 코드리스트 가져오기 (셀렉트박스) */
            rentDto.setGBLEV("1");
            rentDto.setPAGESET("OFF");
            codeList = rentService.code(rentDto);

            gbcd = request.getParameter("gbcd") == null ? codeList.get(0)
                    .getGBCD() : request.getParameter("gbcd");

            /* 모델정보 가져오기 */
            if (!StringUtils.isEmpty(mdseq)) {
                rentDto.setMDSEQ(Integer.parseInt(mdseq));
            }
            rentDto.setGBCD(gbcd);
            rentDto.setPerPageCnt(15);
            rentDto.setPAGESET("ON");
            stanModelList = rentService.stanModelList(rentDto);
            totalCnt = rentService.getStanModelCnt(rentDto);

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        mv.addObject("gbcd", gbcd);
        mv.addObject("codeList", codeList);
        mv.addObject("stanModelList", stanModelList);
        mv.addObject("totalCnt", totalCnt);
        mv.addObject("paging", rentDto);

        mv.setViewName("/rent/admin/stanModelList");
        return mv;
    }

    /* 장비대여 > 관리메뉴 > 설정관리 > 모델관리 > 모델등록페이지 */
    @RequestMapping("/admin/stanModelRegist.do")
    public ModelAndView stanModelRegist(RentDto rentDto,
            HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {

            HashMap<String, String> view = new HashMap<String, String>();
            HashMap<String, String> data = new HashMap<String, String>();
            List<RentDto> modelInfo = null;
            List<RentDto> imgFileList = null;
            List<RentDto> fileList = null;

            String gbcd = request.getParameter("gbcd");
            String mdseq = request.getParameter("mdseq");

            /* GBCD기준 하위분류 중분류코드 가져오기 */
            rentDto.setGBCD(gbcd);
            rentDto.setGBLEV("2");
            List<RentDto> subCodeLv2 = rentService.getSubCode(rentDto);

            /* GBCD기준 하위분류 소분류코드 가져오기 */
            rentDto.setGBLEV("3");
            List<RentDto> subCodeLv3 = rentService.getSubCode(rentDto);

            if (!StringUtils.isEmpty(mdseq) && mdseq != null) {

                rentDto.setMDSEQ(Integer.parseInt(mdseq));
                modelInfo = rentService.stanModelList(rentDto);

                data.put("mdno", modelInfo.get(0).getMDNO());
                data.put("mdnm", modelInfo.get(0).getMDNM());
                data.put("mdtxt", modelInfo.get(0).getMDTXT());
                data.put("mdbg", modelInfo.get(0).getMDBG());
                data.put("lchdt", modelInfo.get(0).getLCHDT());

                List<RentDto> modelSub = rentService.getModelSub(rentDto);

                for (int k = 0; k < modelSub.size(); k++) {
                    view.put(modelSub.get(k).getGBCD(), modelSub.get(k)
                            .getITEM());
                }

                rentDto.setREFNO(Integer.parseInt(mdseq));

                /* 이미지 첨부파일 정보 가져오기 */
                rentDto.setFILETP("I");
                imgFileList = rentService.getFileList(rentDto);

                /* 이미지 첨부파일 정보 가져오기 */
                rentDto.setFILETP("F");
                fileList = rentService.getFileList(rentDto);

            }

            mv.addObject("gbcd", gbcd);
            mv.addObject("mdseq", mdseq);
            mv.addObject("view", view);
            mv.addObject("data", data);
            mv.addObject("fileList", fileList);
            mv.addObject("imgFileList", imgFileList);
            mv.addObject("modelInfo", modelInfo);
            mv.addObject("subCodeLv2", subCodeLv2);
            mv.addObject("subCodeLv3", subCodeLv3);

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        mv.setViewName("/rent/admin/stanModelRegist");
        return mv;
    }

    /* 장비대여 > 관리메뉴 > 설정관리 > 모델관리 > 모델삭제 */
    @RequestMapping("/admin/deleteModel.do")
    public String deleteModel(RentDto rentDto, HttpServletRequest request)
            throws Exception {

        String mdseq = request.getParameter("mdseq");
        String gbcd = request.getParameter("gbcd");

        if (!StringUtil.isEmpty(mdseq)) {

            rentDto.setDELYN("N");
            rentDto.setEQLST("1");
            rentDto.setMDSEQ(Integer.parseInt(mdseq));

            int useEquipCnt = rentService.getUseEquipCnt(rentDto);

            if (useEquipCnt > 0) {
                /* 사용중인 설비 존재시 */
                WebUtils.setSessionAttribute(request, "resultMessage",
                        "해당모델로 등록된 사용중인 설비가 존재합니다.");
                return "/admin/stanModelRegist.do?gbcd=" + gbcd + "&mdseq="
                        + mdseq;

            } else {
                /* 사용중인 설비가 없을시 삭제 처리 */

                System.out.println("삭제처리 진행");

                rentDto.setDELYN("Y");
                rentDto.setEQLST(null);
                rentDto.setMDSEQ(Integer.parseInt(mdseq));
                rentService.updModel(rentDto);
                rentService.delModelSub(rentDto);
                rentDto.setREFNO(Integer.parseInt(mdseq));
                rentService.delFile(rentDto);

            }

            WebUtils.setSessionAttribute(request, "resultMessage", "삭제되었습니다.");
        }

        return "redirect:/admin/stanModelList.do?gbcd=" + gbcd;
    }

    /* 장비대여 > 관리메뉴 > 설정관리 > 모델관리 > 모델저장 */
    @RequestMapping("/admin/saveModel.do")
    public String saveModel(RentDto rentDto, HttpServletRequest request)
            throws Exception {

        MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest) request;

        String mdseq = request.getParameter("mdseq");
        String gbcd = request.getParameter("gbcd");
        String mdno = request.getParameter("mdno");
        String mdnm = request.getParameter("mdnm");
        String lch_year = request.getParameter("lch_year");
        String lch_month = request.getParameter("lch_month");
        String mdtxt = request.getParameter("mdtxt");
        String mdbg = request.getParameter("mdbg");

        try {

            /* 관리자 체크 */
            if (getAdminChk(SESS_EMPNO)) {

                rentDto.setGBCD(gbcd);
                rentDto.setMDNO(mdno);
                rentDto.setMDNM(mdnm);
                rentDto.setLCHDT(lch_year + lch_month);
                rentDto.setMDBG(mdbg);
                rentDto.setMDTXT(mdtxt);

                if (!StringUtil.isEmpty(mdseq) && mdseq != null) {
                    /* 데이터 수정시 */

                    rentDto.setMDSEQ(Integer.parseInt(mdseq));
                    rentService.updModel(rentDto);

                    /* 모델서브정보 수정 */
                    List<RentDto> subCodeList = rentService.getSubCode(rentDto);
                    for (int i = 0; i < subCodeList.size(); i++) {
                        rentDto.setITEM(request.getParameter(subCodeList.get(i)
                                .getGBCD()));
                        rentDto.setGBCD(subCodeList.get(i).getGBCD());
                        rentService.updModelSub(rentDto);
                    }

                    /*
                    * 코드가 변경되거나 삭제되어 기존 저장된 코드데이터와 다른 경우, MODEL_SUB와 CODE 테이블을
                    * 비교하여 데이터를 맞춰준다
                    */
                    rentDto.setGBCD(gbcd);
                    List<RentDto> codeChkOfModelSub = rentService
                            .codeChkOfModelSub(rentDto);
                    List<RentDto> codeChkOfCode = rentService
                            .codeChkOfCode(rentDto);

                    /* 코드 변경요소 확인 */
                    List<RentDto> resCCodeChk = codeChkList(codeChkOfCode,
                            codeChkOfModelSub);
                    List<RentDto> resMSCodeChk = codeChkList(codeChkOfModelSub,
                            codeChkOfCode);

                    if (resCCodeChk.size() > 0) {
                        /* 코드테이블 기준, 모델서브 테이블에 없는 추가된 코드 감지 > 추가작업 */
                        for (int i = 0; i < resCCodeChk.size(); i++) {
                            String tmpGbcd = resCCodeChk.get(i).getGBCD();
                            rentDto.setGBCD(tmpGbcd);
                            rentDto.setITEM(request.getParameter(tmpGbcd));
                            rentService.insModelSub(rentDto);
                        }
                    } else if (resMSCodeChk.size() > 0) {
                        /* 코드테이블 기준, 모델서브 테이블 속에서 사용하지 않는 코드 감지 > 삭제작업 */
                        for (int i = 0; i < resMSCodeChk.size(); i++) {
                            String tmpGbcd = resMSCodeChk.get(i).getGBCD();
                            rentDto.setGBCD(tmpGbcd);
                            rentService.delModelSub(rentDto);
                        }

                    }

                    WebUtils.setSessionAttribute(request, "resultMessage",
                            "저장되었습니다.");

                } else {
                    /* 데이터 등록시 */

                    int maxMdseq = rentService.maxMdseqModel();

                    rentDto.setMDSEQ((maxMdseq + 1));
                    rentDto.setREGENO(SESS_EMPNO);
                    rentDto.setREGENM(SESS_USER_NAME);

                    rentService.insModel(rentDto);

                    /* 모델서브정보 등록 */
                    List<RentDto> subCodeList = rentService.getSubCode(rentDto);
                    for (int i = 0; i < subCodeList.size(); i++) {
                        rentDto.setITEM(request.getParameter(subCodeList.get(i)
                                .getGBCD()));
                        rentDto.setGBCD(subCodeList.get(i).getGBCD());
                        rentService.insModelSub(rentDto);
                    }

                }

                int maxFileNo = rentService.getMaxFileNo();
                List<HashMap<String, Object>> fileInfoList = commonUtil.sendToServer(mRequest, maxFileNo);

                for (int i = 0; i < fileInfoList.size(); i++) {
                    HashMap<String, Object> fileInfoMap = fileInfoList.get(i);
                    if (fileInfoMap != null) {
                        /* 첨부파일 */

                        rentDto.setREFNO(rentDto.getMDSEQ());
                        rentDto.setFILETP((String) fileInfoMap.get("fileType"));
                        rentDto.setFILENO((int) fileInfoMap.get("fileNo"));
                        rentDto.setFILENM((String) fileInfoMap
                                .get("userFileName"));
                        rentDto.setPATHNM("/OCFSFILES/data01/www/DATA/APPS/apply/rent/" + CommonUtil.getToday().subSequence(0, 4) + "/" + fileInfoMap.get("saveFileName") + "." + fileInfoMap.get("fileExt"));
                        rentService.insFile(rentDto);

                        WebUtils.setSessionAttribute(request, "resultMessage","저장 되었습니다.");

                    } else {
                        WebUtils.setSessionAttribute(request, "resultMessage","저장 실패 : " + rentDto.getFILENM());
                    }
                }

            } else {
                WebUtils.setSessionAttribute(request, "resultMessage",
                        "관리자만 접근 가능합니다.");
                return "redirect:/admin/stanModelRegist.do";
            }

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        return "redirect:/admin/stanModelList.do?gbcd=" + gbcd;
    }

    /* 장비대여 > 관리메뉴 > 설정관리 > 장비현황 > 리스트 */
    @RequestMapping("/admin/equipList.do")
    public ModelAndView equipList(RentDto rentDto, HttpServletRequest request)
            throws Exception {
        ModelAndView mv = new ModelAndView();

        String gbcd = request.getParameter("gbcd") == null ? "all" : request.getParameter("gbcd");
        String schCompany = request.getParameter("schCompany");
        String schModel = request.getParameter("schModel");
        String schEqlst = request.getParameter("schEqlst");
        String schEqrst = request.getParameter("schEqrst");
        String schEqmst = request.getParameter("schEqmst");
        String schEqsn = request.getParameter("schEqsn");
        List<RentDto> companyList = null;
        List<RentDto> modelList = null;
        List<RentDto> equipList = null;
        List<RentDto> codeList = null;
        HashMap<String, String> eqlstMap = null;
        HashMap<String, String> eqrstMap = null;
        HashMap<String, String> eqmstMap = null;
        ArrayList<HashMap<String, Object>> list = null;

        int totalCnt = 0;
        int totalSumCnt = 0;

        try {

            /* 검색 옵션 */
            if (!StringUtils.isEmpty(schEqlst) && schEqlst != null) {
                rentDto.setEQLST(schEqlst);
            }
            if (!StringUtils.isEmpty(schEqrst) && schEqrst != null) {
                rentDto.setEQRST(schEqrst);
            }
            if (!StringUtils.isEmpty(schEqmst) && schEqmst != null) {
                rentDto.setEQMST(schEqmst);
            }
            if (!StringUtils.isEmpty(schEqsn) && schEqsn != null) {
                rentDto.setEQSN(schEqsn);
            }
            if (!StringUtils.isEmpty(schCompany) && schCompany != null) {
                rentDto.setITEM(schCompany);
            }
            if (!StringUtils.isEmpty(schModel) && schModel != null) {
                rentDto.setMDSEQ(Integer.parseInt(schModel));
            }

            /* 대분류 코드 가져오기 */
            codeList = rentService.codeList(rentDto);
            for (int j = 0; j < codeList.size(); j++) {
                rentDto.setGBCD(codeList.get(j).getGBCD());
                int resultCnt = rentService.getEquipCnt(rentDto);
                codeList.get(j).setTotalCnt(resultCnt);
                totalSumCnt = totalSumCnt + resultCnt;
            }

            rentDto.setGBCD(gbcd);
            rentDto.setPerPageCnt(15);

            companyList = rentService.companyList(rentDto);

            /* 모델 데이터 가져오기 */
            if (!gbcd.equals("all")) {
                modelList = rentService.getModelList(rentDto);
            }

            /* 장비 데이터 가져오기 */
            equipList = rentService.equipList(rentDto);
            totalCnt = rentService.getEquipCnt(rentDto);

            list = new ArrayList<HashMap<String, Object>>();

            for (int i = 0; i < equipList.size(); i++) {
                HashMap<String, Object> map = new HashMap<String, Object>();

                int no = totalCnt - (rentDto.getPageStartNo() + i) /* + 1 */;
                map.put("no", no);
                map.put("gbcd", equipList.get(i).getGBCD());
                map.put("eqno", equipList.get(i).getEQNO());
                map.put("eqnm", equipList.get(i).getEQNM());
                map.put("eqsn", equipList.get(i).getEQSN());

                map.put("eqalias", equipList.get(i).getEQALIAS());

                rentDto.setMDSEQ(equipList.get(i).getMDSEQ());
                RentDto modelInfo = rentService.getModelInfo(rentDto);

                if (modelInfo != null) {
                    map.put("mdnm", modelInfo.getMDNM());
                }

                /* 승인요청이 대기중인 상태에서 모델이 삭제되면 null값이 반환될 수 있다. */
                map.put("eqlst", equipList.get(i).getEQLST());
                map.put("eqmst", equipList.get(i).getEQMST());
                map.put("eqdet", equipList.get(i).getEQDET());

                list.add(map);
            }

            eqlstMap = Constants.getEqlstMap();
            eqrstMap = Constants.getEqrstMap();
            eqmstMap = Constants.getEqmstMap();

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        mv.addObject("gbcd", gbcd);
        mv.addObject("paging", rentDto);
        mv.addObject("totalCnt", totalCnt);
        mv.addObject("totalSumCnt", totalSumCnt);
        mv.addObject("companyList", companyList);
        mv.addObject("modelList", modelList);
        mv.addObject("codeList", codeList);
        mv.addObject("eqlstMap", eqlstMap);
        mv.addObject("eqrstMap", eqrstMap);
        mv.addObject("eqmstMap", eqmstMap);
        mv.addObject("schEqlst", schEqlst);
        mv.addObject("schEqrst", schEqrst);
        mv.addObject("schEqmst", schEqmst);
        mv.addObject("schCompany", schCompany);
        mv.addObject("schModel", schModel);
        mv.addObject("list", list);

        mv.setViewName("/rent/admin/equipList");
        return mv;
    }

    /* 장비대여 > 관리메뉴 > 장비현황 > 폐기처분 > 리스트 */
    @RequestMapping("/admin/discardList.do")
    public ModelAndView discardList(RentDto rentDto, HttpServletRequest request)
            throws Exception {
        ModelAndView mv = new ModelAndView();

        String gbcd = request.getParameter("gbcd") == null ? "all" : request
                .getParameter("gbcd");
        int totalCnt = 0;

        List<RentDto> codeList = rentService.codeList(rentDto);

        rentDto.setGBCD(gbcd);
        rentDto.setPerPageCnt(15);
        List<RentDto> discardList = rentService.discardList(rentDto);
        totalCnt = rentService.getDiscardCnt(rentDto);

        ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

        for (int i = 0; i < discardList.size(); i++) {
            HashMap<String, Object> map = new HashMap<String, Object>();

            int no = totalCnt - (rentDto.getPageStartNo() + i) /* + 1 */;
            map.put("no", no);
            map.put("gbcd", gbcd);
            map.put("eqno", discardList.get(i).getEQNO());
            map.put("eqnm", discardList.get(i).getEQNM());
            map.put("eqsn", discardList.get(i).getEQSN());

            /* map.put("eqalias", discardList.get(i).getEQALIAS()); */

            rentDto.setMDSEQ(discardList.get(i).getMDSEQ());
            RentDto modelInfo = rentService.getModelInfo(rentDto);

            map.put("mdnm", modelInfo.getMDNM());
            map.put("eqlst", discardList.get(i).getEQLST());
            /* map.put("eqmst", discardList.get(i).getEQMST()); */
            map.put("eqdet", discardList.get(i).getEQDET());

            list.add(map);
        }

        mv.addObject("gbcd", gbcd);
        mv.addObject("paging", rentDto);
        mv.addObject("totalCnt", totalCnt);
        mv.addObject("codeList", codeList);
        mv.addObject("list", list);

        mv.setViewName("/rent/admin/discardList");
        return mv;
    }

    /* 장비대여 > 관리메뉴 > 장비현황 > 장비등록페이지 */
    @RequestMapping("/admin/equipRegist.do")
    public ModelAndView equipRegist(RentDto rentDto, HttpServletRequest request)
            throws Exception {
        ModelAndView mv = new ModelAndView();

        String gbcd = request.getParameter("gbcd") == null ? "all" : request.getParameter("gbcd");
        String eqno = request.getParameter("eqno");
        String pageNo = request.getParameter("pageNo") == null ? "1" : request.getParameter("pageNo");

        List<RentDto> fileList = null;
        RentDto equipInfo = null;
        
        List<RentDto> rentUserList = null;
        int rentUserListCnt = 0;

        /*장비현황 - 장비가 배정되있을경우 등록상태, 관리상태 변경 불가*/
        List<RentDto> rentCheck = null;
        try {
        	rentCheck = rentService.rentCheck(eqno);
		} catch (Exception e) {
			e.printStackTrace();
		}
        
        /* 대분류 코드리스트 가져오기 (셀렉트박스) */
        rentDto.setGBLEV("1");
        rentDto.setPAGESET("OFF");
        List<RentDto> codeList = rentService.code(rentDto);

        /* 모델리스트 가져오기 (셀렉트박스) */
        rentDto.setGBCD(gbcd);
        List<RentDto> modelList = rentService.getModelList(rentDto);

        if (!StringUtils.isEmpty(eqno)) {

            /* 장비정보 가져오기 */
            rentDto.setEQNO(eqno);
            equipInfo = rentService.equipInfo(rentDto);

            /* 첨부파일 정보 가져오기 */
            rentDto.setREFNO(Integer.parseInt(eqno));
            rentDto.setFILETP("E");
            fileList = rentService.getFileList(rentDto);

            /* 대여현황 사용자 정보 */
            rentUserList = rentService.rentUserList(rentDto);
            rentUserListCnt = rentService.rentUserListCnt(rentDto);
            
        }

        HashMap<String, String> eqlstMap = Constants.getEqlstMap();
        HashMap<String, String> eqrstMap = Constants.getEqrstMap();
        HashMap<String, String> eqmstMap = Constants.getEqmstMap();

        mv.addObject("rentCheck", rentCheck);
        mv.addObject("gbcd", gbcd);
        mv.addObject("eqno", eqno);
        mv.addObject("pageNo", pageNo);
        mv.addObject("equipInfo", equipInfo);
        mv.addObject("codeList", codeList);
        mv.addObject("modelList", modelList);
        mv.addObject("fileList", fileList);
        mv.addObject("eqlstMap", eqlstMap);
        mv.addObject("eqrstMap", eqrstMap);
        mv.addObject("eqmstMap", eqmstMap);
        mv.addObject("rentUserList", rentUserList);
        mv.addObject("paging", rentDto);
        mv.addObject("totalCnt", rentUserListCnt);

        //설비대여현황에서 팝업 상세보기와 같이 사용하기 위해 추가. 20180516.
        String pageGubun = request.getParameter("pageGubun");
     
        if(StringUtil.isNotEmpty(pageGubun)){
        	mv.setViewName("/rent/admin/equipInfoPop");
        }else{
        	mv.setViewName("/rent/admin/equipRegist");
        }
        return mv;
    }
    
    /* 대여현황 사용자 정보 */
    @RequestMapping("/admin/rentUserListAjax.do")
    public ModelAndView rentUserListAjax(HttpServletRequest req, HttpServletResponse res, RentDto rentDto)throws Exception {
    	res.setContentType("application/json;charset=UTF-8");
    	ModelAndView mv = new ModelAndView();
    	
    	try {
    		String pageNo = req.getParameter("pageNo") == null ? "1" : req.getParameter("pageNo");
    		List<RentDto> rentUserList = null;
    		int rentUserListCnt = 0;
    		
    		rentUserList = rentService.rentUserList(rentDto);
    		rentUserListCnt = rentService.rentUserListCnt(rentDto);
    		
    		mv.setViewName("/rent/admin/equipInfoPopRent");
    		mv.addObject("paging", rentDto);
    		mv.addObject("rentUserList", rentUserList);
    		mv.addObject("totalCnt", rentUserListCnt);

		} catch (Exception e) {
			e.printStackTrace();
		}
    	return mv;
    }

    /* 장비대여 > 관리메뉴 > 장비현황 > 장비등록 */
    @RequestMapping("/admin/saveEquip.do")
    public String saveEquip(RentDto rentDto, HttpServletRequest request)
            throws Exception {

        MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest) request;

        String gbcd = mRequest.getParameter("gbcd");
        String eqno = mRequest.getParameter("eqno");
        String eqsn = mRequest.getParameter("eqsn"); // 설비고유번호
        String mdseq = mRequest.getParameter("mdseq"); // 모델고유번호
        String eqcdt = mRequest.getParameter("eqcdt");
        String eqrdt = mRequest.getParameter("eqrdt");
        String eqrst = mRequest.getParameter("eqrst"); // 설비등록상태
        String eqmst = mRequest.getParameter("eqmst"); // 설비관리상태
        String eqpkg = mRequest.getParameter("eqpkg");
        String eqdet = mRequest.getParameter("eqdet");
        String eqbrk = mRequest.getParameter("eqbrk");
        String eqbrkdt = mRequest.getParameter("eqbrkdt");
        String eqalias = mRequest.getParameter("eqalias"); // 설비별칭
        String eqbg = mRequest.getParameter("eqbg"); // 설비별칭
        String etc1 = mRequest.getParameter("etc1");
        String etc2 = mRequest.getParameter("etc2");
        String etc3 = mRequest.getParameter("etc3");
        String etc4 = mRequest.getParameter("etc4");
        String etc5 = mRequest.getParameter("etc5");
        String etc6 = mRequest.getParameter("etc6");
        String pageNo = mRequest.getParameter("pageNo");
        String eqassetsno = mRequest.getParameter("eqassetsno");

        try {

            /* 관리자 체크 */
            if (getAdminChk(SESS_EMPNO)) {

                rentDto.setEQSN(eqsn);
                rentDto.setEQCDT(eqcdt.replace("-", ""));
                rentDto.setEQRDT(eqrdt.replace("-", ""));
                rentDto.setEQPKG(eqpkg);
                rentDto.setEQDET(eqdet);
                rentDto.setEQBRK(eqbrk);
                rentDto.setEQBG(eqbg);
                rentDto.setEQASSETSNO(eqassetsno);
                
                if (!StringUtil.isEmpty(eqbrkdt)) {
                    rentDto.setEQBRKDT(eqbrkdt.replaceAll("[^0-9]", "") + "00");
                }
                rentDto.setEQALIAS(eqalias);

                if (!StringUtils.isEmpty(eqno) && eqno != null) {
                    /* 데이터 수정시 */

                    rentDto.setEQNO(eqno);
                    RentDto eqnoInfo = rentService.getEQLSTChk(rentDto);

                    /* 대여상태가 사용중이 아닐경우에만 모델, 설비등록 , 관리상태 변경가능 */
                    if (!eqnoInfo.getEQLST().equals("1")
                            && eqnoInfo.getEQLST() != null) {
                        rentDto.setMDSEQ(Integer.parseInt(mdseq));
                        rentDto.setEQRST(eqrst);
                        rentDto.setEQMST(eqmst);
                    }

                    /* 태블릿이나 에그 일 시 */
                    if (eqnoInfo.getGBCD().equals("010")
                            || eqnoInfo.getGBCD().equals("011")) {
                        rentDto.setETC1(etc1);
                        rentDto.setETC2(etc2);
                        rentDto.setETC3(etc3);
                        rentDto.setETC4(etc4);
                        rentDto.setETC5(etc5);
                        rentDto.setETC6(etc6);
                    }
                    
                    if (eqnoInfo.getGBCD().equals("021")){
                    	rentDto.setETC2(etc2);
                    }

                    rentService.updEquip(rentDto);
                    gbcd = eqnoInfo.getGBCD();

                } else {
                    /* 데이터 등록시 */

                    /* 태블릿이나 에그 일 시 */
                    if (gbcd.equals("010") || gbcd.equals("011")) {
                        rentDto.setETC1(etc1);
                        rentDto.setETC2(etc2);
                        rentDto.setETC3(etc3);
                        rentDto.setETC4(etc4);
                        rentDto.setETC5(etc5);
                        rentDto.setETC6(etc6);
                    }

                    /* 설비관리번호 생성 */
                    rentDto.setGBCD(gbcd);
                    RentDto codeInfo = rentService.getCodeInfo(rentDto);

                    if (StringUtils.isEmpty(codeInfo.getEQHNO())) {
                        WebUtils.setSessionAttribute(request, "resultMessage",
                                "코드의 설비관리번호가 없습니다.");
                        return "redirect:/admin/equipRegist.do";
                    } else {

                        String newEqnm = codeInfo.getEQHNO()
                                + CommonUtil.getToday().substring(2, 4);
                        rentDto.setEQNM(newEqnm);
                        String newEqnmSuffix = rentService.getNewEqnm(rentDto);

                        /* 코드의 설비관리번호 생성 */
                        if (StringUtils.isEmpty(newEqnmSuffix)) {
                            WebUtils.setSessionAttribute(request,
                                    "resultMessage", "코드의 설비관리번호 생성에 실패 했습니다.");
                            return "redirect:/admin/equipRegist.do";
                        } else {
                            newEqnm = newEqnm + newEqnmSuffix;

                            rentDto.setEQNM(newEqnm);
                            rentDto.setMDSEQ(Integer.parseInt(mdseq));
                            rentDto.setEQRST(eqrst);
                            rentDto.setEQMST(eqmst);

                            int maxEqno = rentService.getMaxEqno(rentDto);
                            int newEqno = (maxEqno + 1);

                            rentDto.setEQNO(String.valueOf(newEqno));
                            rentDto.setEQLST("0");
                            rentDto.setREGENO(SESS_EMPNO);
                            rentDto.setREGENM(SESS_USER_NAME);

                            rentService.insEquip(rentDto);
                        }

                    }

                }

                int maxFileNo = rentService.getMaxFileNo();
                List<HashMap<String, Object>> fileInfoList = commonUtil.sendToServer(mRequest, maxFileNo);

                for (int i = 0; i < fileInfoList.size(); i++) {
                    HashMap<String, Object> fileInfoMap = fileInfoList.get(i);
                    if (fileInfoMap != null) {
                        /* 첨부파일 */
                        rentDto.setREFNO(Integer.parseInt(rentDto.getEQNO()));
                        rentDto.setFILETP((String) fileInfoMap.get("fileType"));
                        rentDto.setFILENO((int) fileInfoMap.get("fileNo"));
                        rentDto.setFILENM((String) fileInfoMap
                                .get("userFileName"));
                        rentDto.setPATHNM("/OCFSFILES/data01/www/DATA/APPS/apply/rent/" + CommonUtil.getToday().subSequence(0, 4) + "/" + fileInfoMap.get("saveFileName") + "." + fileInfoMap.get("fileExt"));
                        rentService.insFile(rentDto);

                        WebUtils.setSessionAttribute(request, "resultMessage",
                                "저장 되었습니다.");
                    } else {
                        WebUtils.setSessionAttribute(request, "resultMessage",
                                "저장 실패\n관리자에게 문의하여 주세요.");
                    }
                }

            } else {
                WebUtils.setSessionAttribute(request, "resultMessage",
                        "관리자만 접근 가능합니다.");
                return "redirect:/admin/equipRegist.do";
            }

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        return "redirect:/admin/equipList.do?pageNo=" + pageNo + "&gbcd=" + gbcd;
    }

    /* 장비대여 > 관리메뉴 > 장비현황 > 장비삭제 */
    @RequestMapping("/admin/deleteEquip.do")
    public String deleteEquip(RentDto rentDto, HttpServletRequest request)
            throws Exception {

        String eqno = request.getParameter("eqno");
        String gbcd = request.getParameter("gbcd");
        String pageNo = request.getParameter("pageNo") == null ? "1" : request.getParameter("pageNo");

        if (!StringUtil.isEmpty(eqno)) {

            rentDto.setEQNO(eqno);
            rentDto.setDELYN("Y");
            rentService.updEquip(rentDto);
            rentDto.setREFNO(Integer.parseInt(eqno));
            rentService.delFile(rentDto);

            WebUtils.setSessionAttribute(request, "resultMessage", "삭제되었습니다.");
        }

        return "redirect:/admin/equipList.do?gbcd=" + gbcd + "&pageNo=" + pageNo;
    }

    /* 장비대여 > 관리메뉴 > 장비현황 > 장비등록 */
    @ResponseBody
    @RequestMapping("/admin/delFile.do")
    public void delFile(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Boolean retVal = false;
        String fileNo = request.getParameter("fileNo");
        String type = request.getParameter("type");
        RentDto rentDto = new RentDto();

        /* 관리자 체크 */
        if (getAdminChk(SESS_EMPNO)) {

            try {

                if (!StringUtils.isEmpty(fileNo)) {
                    rentDto.setFILETP(type);
                    rentDto.setFILENO(Integer.parseInt(fileNo));
                    rentService.delFile(rentDto);
                    retVal = true;
                }

            } catch (Exception e) {
                // TODO: handle exception
                e.printStackTrace();
                retVal = false;
            } finally {

                if (retVal != false) {

                    response.setContentType("text/html;charset=utf-8");
                    PrintWriter out = response.getWriter();
                    out.print("success");

                } else {

                    response.setContentType("text/html;charset=utf-8");
                    PrintWriter out = response.getWriter();
                    out.print("error");

                }

            }

        } else {
            WebUtils.setSessionAttribute(request, "resultMessage",
                    "관리자만 접근 가능합니다.");
        }

    }

    /* 관리자 여부 체크 */
    public boolean getAdminChk(String adminEmpId) throws Exception {

        boolean rt = false;
        RentDto rentDto = new RentDto();
        rentDto.setEMP_ID(adminEmpId);
        List<RentDto> adminList = rentService.getAdminChk(rentDto);

        if (adminList.size() > 0) {
            rt = true;
        }

        return rt;
    }

    /* 장비대여 > 관리메뉴 > 설정관리 > 관리자관리 > 관리자삭제 */
    @ResponseBody
    @RequestMapping("/admin/getModelList.do")
    public void getModelList(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        String gbcd = request.getParameter("gbcd") == null ? "all" : request
                .getParameter("gbcd");
        ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
        RentDto rentDto = new RentDto();
        boolean retVal = false;

        try {

            /* 모델리스트 가져오기 (셀렉트박스) */
            rentDto.setGBCD(gbcd);
            List<RentDto> modelList = rentService.getModelList(rentDto);

            for (int i = 0; i < modelList.size(); i++) {
                HashMap<String, Object> map = new HashMap<String, Object>();

                map.put("gbcd", modelList.get(i).getGBCD());
                map.put("mdno", modelList.get(i).getMDNO());
                map.put("mdseq", modelList.get(i).getMDSEQ());
                map.put("mdnm", modelList.get(i).getMDNM());
                map.put("mdtxt", modelList.get(i).getMDTXT());
                map.put("mdbg", modelList.get(i).getMDBG());

                list.add(map);
            }

            retVal = true;

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            retVal = false;
        } finally {

            if (retVal != false) {

                JSONObject json = new JSONObject();
                json.put("model_list", list);

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print(json.toString());

            } else {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print("error");

            }
        }

    }

    /* 장비대여 > 관리메뉴 > 접수현황 > 리스트 > sms/mail내역 */
    @ResponseBody
    @RequestMapping("/admin/msHistory.do")
    public void msHistory(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        String refno = request.getParameter("appno");

        ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
        RentDto rentDto = new RentDto();
        boolean retVal = false;
        List<RentDto> msHistoryList = null;

        try {

            if (!StringUtil.isEmpty(refno)) {

                rentDto.setREFNO(Integer.parseInt(refno));
                msHistoryList = rentService.msHistory(rentDto);

                for (int i = 0; i < msHistoryList.size(); i++) {
                    HashMap<String, Object> map = new HashMap<String, Object>();

                    map.put("type", msHistoryList.get(i).getType().equals("1") ? "MAIL" : "SMS");
                    map.put("senddt", msHistoryList.get(i).getSENDDT().substring(0, 4) + "." + msHistoryList.get(i).getSENDDT().substring(4, 6) + "." + msHistoryList.get(i).getSENDDT().substring(6, 8)
                    		+ " " + msHistoryList.get(i).getSENDDT().substring(8, 10) + ":" + msHistoryList.get(i).getSENDDT().substring(10, 12) + ":" + msHistoryList.get(i).getSENDDT().substring(12, 14));
                    map.put("sendms", msHistoryList.get(i).getSENDMS());

                    String typeVal = msHistoryList.get(i).getType();
                    String etcVal = msHistoryList.get(i).getETC();
                    String etc = "";

                    if ((typeVal.equals("1") && etcVal.equals("1")) || (typeVal.equals("2") && etcVal.equals("9999"))) {
                        etc = "성공";
                    } else {
                        etc = "실패";
                    }
                    map.put("etc", etc);
                    list.add(map);
                }

            }

            retVal = true;

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            retVal = false;
        } finally {

            if (retVal != false) {

                JSONObject json = new JSONObject();
                json.put("msList", list);

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print(json.toString());

            } else {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print("error");

            }
        }

    }

    /* 장비대여 > 관리메뉴 > 접수현황 > 리스트 > sms/mail내역 */
    @ResponseBody
    @RequestMapping("/admin/searchMember.do")
    public void searchMember(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        String keyword = request.getParameter("keyword");

        ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
        RentDto rentDto = new RentDto();
        boolean retVal = false;
        List<RentDto> searchMemberList = null;

        try {

            if (!StringUtil.isEmpty(keyword)) {

                rentDto.setKEYWORD(keyword);
                searchMemberList = rentService.searchMember(rentDto);

                for (int i = 0; i < searchMemberList.size(); i++) {
                    HashMap<String, Object> map = new HashMap<String, Object>();

                    map.put("empno", searchMemberList.get(i).getEMPNO());
                    map.put("name", searchMemberList.get(i).getNAME());
                    map.put("dept_nm", searchMemberList.get(i).getDEPT_NM());
                    map.put("dept_nm_depth1", searchMemberList.get(i).getDept1Name());
                    map.put("deptno", searchMemberList.get(i).getDEPTNO());
                    map.put("telno", searchMemberList.get(i).getTELNO());

                    list.add(map);
                }

            }

            retVal = true;

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            retVal = false;
        } finally {

            if (retVal != false) {

                JSONObject json = new JSONObject();
                json.put("memberList", list);

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print(json.toString());

            } else {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print("error");

            }
        }

    }

    /* 변경된 코드 값 비교 */
    public List<RentDto> codeChkList(List<RentDto> mainList,
            List<RentDto> compareWith) throws Exception {
        List<RentDto> codeChkResult = new ArrayList<RentDto>();
        boolean exist = false;

        /* 메인 리스트를 기준으로 for문 시작 */
        for (int i = 0; i < mainList.size(); i++) {
            /* 값 존재여부 설정 */
            exist = false;

            /* 비교 리스트의 GBCD값이 돌아가며 값 확인비교, 존재시 break */
            for (int j = 0; j < compareWith.size(); j++) {
                if (mainList.get(i).getGBCD()
                        .equals(compareWith.get(j).getGBCD())) {
                    exist = true;
                    break;
                }
            }
            /* 값 존재여부가 없을시 리스트에 등록 */
            if (exist == false) {
                RentDto rentDto = new RentDto();
                rentDto.setGBCD(mainList.get(i).getGBCD());
                codeChkResult.add(rentDto);
            }
        }

        return codeChkResult;
    }

    /* 마이페이지 */
    @RequestMapping("/equipRentPop.do")
    public ModelAndView equipRentPop(RentDto rentDto) throws Exception {
        ModelAndView mv = new ModelAndView();

        List<RentDto> equipRentPopList = null;
        int totalCnt = 0;

        try {

            /* 사용자 세션 정보 입력 */
            rentDto.setREGENO(SESS_EMPNO);
            equipRentPopList = rentService.equipRentPop(rentDto);
            totalCnt = rentService.getEquipRentPopCnt(rentDto);

            for (int i = 0; i < equipRentPopList.size(); i++) {
                rentDto.setIS_CANCEL(false);
                String status = equipRentPopList.get(i).getSTATUS();
                String approval = equipRentPopList.get(i).getAPPROVAL();

                /* 접수 취소 여부 */
                equipRentPopList.get(i)
                        .setIS_CANCEL(isCancel(status, approval));
                /* 접수 상태 문자 변환 */
                equipRentPopList.get(i).setSTATUSSTR(
                        statusStr(status, approval));
            }

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        mv.addObject("equipRentPopList", equipRentPopList);
        mv.addObject("rentDto", rentDto);
        mv.addObject("totalCnt", totalCnt);
        mv.addObject("paging", rentDto);
        mv.setViewName("/rent/equipRentPop");
        return mv;
    }

    /* 공통 메일로직 */
    @RequestMapping("/mail/mailView.do")
    public ModelAndView mailView(RentDto rentDto, HttpServletRequest request)
            throws Exception {
        ModelAndView mv = new ModelAndView();

        String appno = request.getParameter("appno");
        String mode = request.getParameter("mode");
        String status = request.getParameter("status");
        String uhseq = request.getParameter("uhseq");
        HashMap<String, Object> map = null;

        String btnLink = "";
        map = new HashMap<String, Object>();

        if (!StringUtils.isEmpty(appno) && !StringUtils.isEmpty(mode)) {

            if (mode.equals("sign")) {
                // 결제
                mv.setViewName("/rent/mail/mailViewSign");
            } else if (mode.equals("toadmin")) {
                // 관리자
                mv.setViewName("/rent/mail/mailView");
                btnLink = "/admin/recView.do?appno=" + appno;
                map.put("btnLink", btnLink);
            } else if (mode.equals("touser")) {
                // 사용자
                mv.setViewName("/rent/mail/mailView");
                btnLink = "/appList.do";
                map.put("btnLink", btnLink);
            } else if (mode.equals("chgEu") || mode.equals("chgEu_adm")){
                mv.setViewName("/rent/mail/mailViewChgEu");
                btnLink = "/admin/recView.do?appno=" + appno;
                map.put("btnLink", btnLink);
            } else if (mode.equals("chgEm") || mode.equals("chgEm_adm")){
                mv.setViewName("/rent/mail/mailViewChgEm");
                btnLink = "/admin/recView.do?appno=" + appno;
                map.put("btnLink", btnLink);
            } else if (mode.equals("info")){
            	mv.setViewName("/rent/mail/mailViewInfo");
            }

            rentDto.setAPPNO(Integer.parseInt(appno));

            if(mode.equals("chgEu") || mode.equals("chgEu_adm")){
            	
            	/*사용자 인수인계 메일*/

                rentDto.setUHSEQ(uhseq);
                RentDto mailContext = rentService.getMailViewChgEu(rentDto);

                map.put("appno", appno);
                map.put("mode", mode);
                map.put("status", status);

                map.put("euseq", mailContext.getEUSEQ());
                map.put("mdseq", mailContext.getMDSEQ());
                map.put("eqno", mailContext.getEQNO());
                map.put("uhseq", mailContext.getUHSEQ());
                map.put("mailmode", mailContext.getMODE());
                map.put("insuno", mailContext.getINSUNO());
                map.put("insunm", mailContext.getINSUNM());
                map.put("ingaeno", mailContext.getINGAENO());
                map.put("ingaenm", mailContext.getINGAENM());
                map.put("regeno", mailContext.getREGENO());
                map.put("regenm", mailContext.getREGENM());
                map.put("regdt", mailContext.getREGDT().substring(0, 4) + "."
                        + mailContext.getREGDT().substring(4, 6) + "."
                        + mailContext.getREGDT().substring(6, 8));
                map.put("mailapproval", mailContext.getMAILAPPROVAL());
                map.put("mdnm", mailContext.getMDNM());
                map.put("eqnm", mailContext.getEQNM());
                map.put("eqalias", mailContext.getEQALIAS());
                map.put("gbcd", mailContext.getGBCD());
                map.put("gbnm", mailContext.getGBNM());
                map.put("appnum", mailContext.getAPPNUM());
                map.put("strdt", mailContext.getSTRDT().substring(0, 4) + "."
                        + mailContext.getSTRDT().substring(4, 6) + "."
                        + mailContext.getSTRDT().substring(6, 8));
                map.put("enddt", mailContext.getENDDT().substring(0, 4) + "."
                        + mailContext.getENDDT().substring(4, 6) + "."
                        + mailContext.getENDDT().substring(6, 8));
                map.put("deptno", mailContext.getDEPTNO());
                map.put("dept1Nm", mailContext.getDEPT1NM());

            }else if(mode.equals("chgEm") || mode.equals("chgEm_adm")){
            	
            	/*인수자(담당자) 인수인계 메일*/

                rentDto.setUHSEQ(uhseq);
                RentDto mailContext = rentService.getMailViewChgEm(rentDto);

                map.put("appno", appno);
                map.put("mode", mode);

                map.put("amount", mailContext.getAMOUNT());
                map.put("gbnm", removeDuplicateStringToken(mailContext.getGBNM(), ","));
                map.put("strdt", mailContext.getSTRDT().substring(0, 4) + "."
                        + mailContext.getSTRDT().substring(4, 6) + "."
                        + mailContext.getSTRDT().substring(6, 8));
                map.put("enddt", mailContext.getENDDT().substring(0, 4) + "."
                        + mailContext.getENDDT().substring(4, 6) + "."
                        + mailContext.getENDDT().substring(6, 8));
                map.put("appnum", mailContext.getAPPNUM());
                map.put("appeno", mailContext.getAPPENO());
                map.put("appenm", mailContext.getAPPENM());
                map.put("insudt", mailContext.getINSUDT());
                map.put("uhseq", mailContext.getUHSEQ());
                map.put("ingaenm", mailContext.getINGAENM());
                map.put("ingaeno", mailContext.getINGAENO());
                map.put("insunm", mailContext.getINSUNM());
                map.put("insuno", mailContext.getINSUNO());
                map.put("mailapproval", mailContext.getMAILAPPROVAL());
                map.put("mailmode", mailContext.getMODE());
                map.put("regdt", mailContext.getREGDT().substring(0, 4) + "."
                        + mailContext.getREGDT().substring(4, 6) + "."
                        + mailContext.getREGDT().substring(6, 8));

            } else if (mode.equals("info")) {
            	
            	/*인수자 사용자 정보 확인용 메일*/
            	
            	RentDto mailContext = rentService.getMailViewInfo(rentDto);
            	
				map.put("appno", appno);
				map.put("mode", mode);
				map.put("status", status);
				
				 if (mailContext != null) {
					 
					 	map.put("amount", mailContext.getAMOUNT());
	                    map.put("gbnm", removeDuplicateStringToken(mailContext.getGBNM(), ","));
	                    map.put("mdnm", removeDuplicateStringToken(mailContext.getMDNM(), ","));
	                    map.put("strdt", mailContext.getSTRDT().substring(0, 4) + "."
	                            + mailContext.getSTRDT().substring(4, 6) + "."
	                            + mailContext.getSTRDT().substring(6, 8));
	                    map.put("enddt", mailContext.getENDDT().substring(0, 4) + "."
	                            + mailContext.getENDDT().substring(4, 6) + "."
	                            + mailContext.getENDDT().substring(6, 8));
	                    map.put("regdt", mailContext.getREGDT().substring(0, 4) + "."
	                            + mailContext.getREGDT().substring(4, 6) + "."
	                            + mailContext.getREGDT().substring(6, 8));
	                    map.put("appnum", mailContext.getAPPNUM());
	                    map.put("appeno", mailContext.getAPPENO());
	                    map.put("appenm", mailContext.getAPPENM());
	                    map.put("insuno", mailContext.getINSUNO());
	                    map.put("insunm", mailContext.getINSUNM());
	                    map.put("appueno", mailContext.getAPPUENO());
	                    map.put("appuenm", mailContext.getAPPUENM());
	                    map.put("useobj", mailContext.getUSEOBJ());

	                }
            	
            } else {

                RentDto mailContext = rentService.mailView(rentDto);

                map.put("appno", appno);
                map.put("mode", mode);
                map.put("status", status);

                if (mailContext != null) {

                    map.put("gbnm", removeDuplicateStringToken(mailContext.getGBNM(), ","));
                    map.put("mdnm", removeDuplicateStringToken(mailContext.getMDNM(), ","));
                    map.put("appnum", mailContext.getAPPNUM());
                    map.put("appenm", mailContext.getAPPENM());
                    map.put("strdt", mailContext.getSTRDT().substring(0, 4) + "."
                            + mailContext.getSTRDT().substring(4, 6) + "."
                            + mailContext.getSTRDT().substring(6, 8));
                    map.put("enddt", mailContext.getENDDT().substring(0, 4) + "."
                            + mailContext.getENDDT().substring(4, 6) + "."
                            + mailContext.getENDDT().substring(6, 8));
                    map.put("amount", mailContext.getAMOUNT());
                    map.put("useobj", mailContext.getUSEOBJ());

                }
            }



        } else {
            WebUtils.setSessionAttribute(request, "resultMessage", "잘못된 접근입니다.");
        }

        mv.addObject("mailContext", map);

        return mv;

    }

    /* 데이터 중복제거 */
    public String removeDuplicateStringToken(String str, String token) {
        String removeDubString = "";
        String[] array = StringUtils.split(str, token.trim());
        TreeSet ts = new TreeSet();
        for (int i = 0; i < array.length; i++) {
            ts.add(array[i]);
        }
        Iterator it = ts.iterator();
        while (it.hasNext()) {
            removeDubString += (String) it.next() + token.trim();
        }
        removeDubString = removeDubString.substring(0,
                removeDubString.lastIndexOf(token.trim()));

        return removeDubString;
    }

    /* 결재승인 */
    @ResponseBody
    @RequestMapping("/signUp.do")
    public void signUp(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String appno = request.getParameter("appno");
        String mode = request.getParameter("mode");
        String status = request.getParameter("status");
        String euseq = request.getParameter("euseq");
        String uhseq = request.getParameter("uhseq");
        String appueno = request.getParameter("appueno");
        String appuenm = request.getParameter("appuenm");
        String insuno = request.getParameter("insuno");
        String insunm = request.getParameter("insunm");
        String deptno = request.getParameter("deptno");
        String DEPT1NM = request.getParameter("DEPT1NM");
        String isResult = "";

        RentDto rentDto = new RentDto();

        ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
        HashMap<String, Object> map = null;
        boolean retVal = false;

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus statusTr = dataSourceTransactionManager.getTransaction(def);

        try {

            if (mode.equals("sign") || mode.equals("return")){

                if (!StringUtil.isEmpty(appno) && !StringUtil.isEmpty(mode)
                        && !StringUtil.isEmpty(status)) {

                    rentDto.setAPPNO(Integer.parseInt(appno));
                    RentDto signInfo = rentService.signInfo(rentDto);

                    if (signInfo.getAPPNO() == null) {
                        isResult = "error";
                    } else if (signInfo.getSTATUS() != null
                            && signInfo.getSTATUS().equals("2")) {
                        // 취소된 건인지 확인
                        isResult = "cancel";
                    } else if (signInfo.getIS_SIGN() != null
                            && signInfo.getIS_SIGN().equals("Y")) {
                        // 최종 승인건인지 확인
                        isResult = "final";
                    } else if (signInfo.getIS_SIGN() != null
                            && signInfo.getIS_SIGN().equals("R")) {
                        // 이미 반송된 건인지 확인
                        isResult = "return";
                    }

                    if (!isResult.equals("error") && !isResult.equals("cancel")
                            && !isResult.equals("final")
                            && !isResult.equals("return")) {

                        rentDto.setSTATUS(status);
                        rentDto.setSIGNMODE("REG_SIGN");
                        RentDto signStatusInfo = rentService.getSignStatusInfo(rentDto);

                        if (signStatusInfo != null
                                && signStatusInfo.getREG_SIGN().equals("Y")) {
                            /* 이미 승인된 건인지 확인 */
                            isResult = "dup";
                        } else {

                            if (mode.equals("sign")) {
                                isResult = signReg(appno, status, mode);
                            } else if (mode.equals("return")) {
                                signReturn(appno, status, mode);
                            }

                        }

                    }

                    retVal = true;
                    dataSourceTransactionManager.commit(statusTr);

                } else {
                    WebUtils.setSessionAttribute(request, "resultMessage", "잘못된 접근입니다.");
                    retVal = false;
                }

            } else if (mode.equals("chgEuSign") || mode.equals("chgEuReturn")) {

                rentDto.setUHSEQ(uhseq);
                rentDto.setAPPNO(Integer.parseInt(appno));
                RentDto equipUserHistory = rentService.getEquipUserHistory(rentDto);

                if(!equipUserHistory.getMAILAPPROVAL().equals("0")){
                    WebUtils.setSessionAttribute(request, "resultMessage", "인수인계 상태가 아닙니다.");
                    retVal = false;
                } else {
                    if (mode.equals("chgEuSign")) {

                        if(!StringUtil.isEmpty(euseq) && !StringUtil.isEmpty(appno) && !StringUtil.isEmpty(appueno)
                        && !StringUtil.isEmpty(appuenm) && !StringUtil.isEmpty(uhseq)){

                            /*장비사용자 변경*/
                            rentDto.setEUSEQ(euseq);
                            rentDto.setAPPNO(Integer.parseInt(appno));
                            rentDto.setAPPUENO(appueno);
                            rentDto.setAPPUENM(appuenm);
                            rentDto.setDEPTNO(deptno);
                            rentDto.setDEPT1NM(DEPT1NM);
                            rentService.updAppEquipUser(rentDto);

                            /*인수인계 내역 완료처리*/
                            rentDto.setUHSEQ(uhseq);
                            rentDto.setMAILAPPROVAL("6");
                            rentService.updEquipUserHistory(rentDto);
                            isResult = "success";

                            retVal = true;
                            dataSourceTransactionManager.commit(statusTr);

                        } else {
                            WebUtils.setSessionAttribute(request, "resultMessage", "잘못된 접근입니다.");
                            retVal = false;
                        }

                    } else if (mode.equals("chgEuReturn")) {


                        if(!StringUtil.isEmpty(euseq) && !StringUtil.isEmpty(appno)
                        && !StringUtil.isEmpty(uhseq)){

                            /*인수인계 내역 완료처리*/
                            rentDto.setEUSEQ(euseq);
                            rentDto.setAPPNO(Integer.parseInt(appno));
                            rentDto.setUHSEQ(uhseq);
                            rentDto.setMAILAPPROVAL("7");
                            rentService.updEquipUserHistory(rentDto);
                            isResult = "success";

                            retVal = true;
                            dataSourceTransactionManager.commit(statusTr);

                        } else {
                            WebUtils.setSessionAttribute(request, "resultMessage", "잘못된 접근입니다.");
                            retVal = false;
                        }


                    } else {
                        WebUtils.setSessionAttribute(request, "resultMessage", "잘못된 접근입니다.");
                        retVal = false;
                    }
                }


            } else if (mode.equals("chgEmSign") || mode.equals("chgEmReturn")) {

                rentDto.setUHSEQ(uhseq);
                rentDto.setAPPNO(Integer.parseInt(appno));
                RentDto equipUserHistory = rentService.getEquipUserHistory(rentDto);

                if(!equipUserHistory.getMAILAPPROVAL().equals("0")){
                    WebUtils.setSessionAttribute(request, "resultMessage", "인수인계 상태가 아닙니다.");
                    retVal = false;
                } else {
                    if (mode.equals("chgEmSign")) {

                        if(!StringUtil.isEmpty(appno) && !StringUtil.isEmpty(insuno)
                        && !StringUtil.isEmpty(insunm) && !StringUtil.isEmpty(uhseq)){

                            /*장비담당자 변경*/
                            rentDto.setAPPNO(Integer.parseInt(appno));
                            rentDto.setINSUNO(insuno);
                            rentDto.setINSUNM(insunm);
                            rentService.updAppInfo(rentDto);

                            /*인수인계 내역 완료처리*/
                            rentDto.setUHSEQ(uhseq);
                            rentDto.setMAILAPPROVAL("6");
                            rentService.updEquipUserHistory(rentDto);
                            isResult = "success";

                            retVal = true;
                            dataSourceTransactionManager.commit(statusTr);

                        } else {
                            WebUtils.setSessionAttribute(request, "resultMessage", "잘못된 접근입니다.");
                            retVal = false;
                        }

                    } else if (mode.equals("chgEmReturn")) {


                        if(!StringUtil.isEmpty(appno) && !StringUtil.isEmpty(uhseq)){

                            /*인수인계 내역 완료처리*/
                            rentDto.setEUSEQ(euseq);
                            rentDto.setAPPNO(Integer.parseInt(appno));
                            rentDto.setUHSEQ(uhseq);
                            rentDto.setMAILAPPROVAL("7");
                            rentService.updEquipUserHistory(rentDto);
                            isResult = "success";

                            retVal = true;
                            dataSourceTransactionManager.commit(statusTr);

                        } else {
                            WebUtils.setSessionAttribute(request, "resultMessage", "잘못된 접근입니다.");
                            retVal = false;
                        }


                    } else {
                        WebUtils.setSessionAttribute(request, "resultMessage", "잘못된 접근입니다.");
                        retVal = false;
                    }
                }

            }

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            retVal = false;
            dataSourceTransactionManager.rollback(statusTr);
        } finally {

            if (retVal != false) {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print(isResult);

            } else {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print("false");

            }
        }

    }

    /* 결재승인 */
    public String signReg(String appno, String status, String mode)
            throws Exception {

        RentDto rentDto = new RentDto();
        String isResult = "";

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus statusTr = dataSourceTransactionManager
                .getTransaction(def);

        try {

            if (status.equals("2")) {

                // 검토 > 결정

                // 입안
                rentDto.setSIGNMODE("EMPNO");
                rentDto.setAPPNO(Integer.parseInt(appno));
                rentDto.setSTATUS("1");
                RentDto draftInfo = rentService.getSignStatusInfo(rentDto);

                // 결정
                rentDto.setSTATUS("3");
                RentDto toFinalInfo = rentService.getSignStatusInfo(rentDto);

                if ((draftInfo == null && draftInfo.getEMPNO() == null)
                        || (toFinalInfo == null && toFinalInfo.getEMPNO() == null)) {
                    isResult = "error";
                } else {

                    // 결제테이블 상태 업데이트
                    rentDto.setSTATUS("2");
                    rentDto.setREG_SIGN("Y");
                    rentService.updStatus(rentDto);

                    // 최종결정자에게 메일발송
                    status = "3";
                    SendMail sm = SendMail.getInstance();
                    Address[] toAddrs = new Address[1];
                    toAddrs[0] = new InternetAddress(toFinalInfo.getEMPNO() + "@kepco.co.kr");
                    sm.sign_sendMail(toAddrs, toFinalInfo.getEMPNO(), appno, mode, status);

                }

            } else if (status.equals("3")) {

                // 최종결정

                // 결제테이블 상태 업데이트
                rentDto.setSTATUS("3");
                rentDto.setREG_SIGN("Y");
                rentDto.setAPPNO(Integer.parseInt(appno));
                rentService.updStatus(rentDto);

                // 신상정보 결제필드 업데이트
                rentService.updSign(rentDto);
                RentDto appStatusInfo = rentService.getAppStatusInfo(rentDto);
                
                // 접수된 신청내역 결정처리
                RentDto updAppSign = new RentDto();
                updAppSign.setAPPNO(Integer.parseInt(appno));
                updAppSign.setIS_SIGN("Y");
                rentService.updAppInfo(updAppSign);

                // 자동배정
                /*List<RentDto> appModelList = rentService.loadAppModel(rentDto);

                for (int i = 0; i < appModelList.size(); i++) {

                    rentDto.setMDSEQ(appModelList.get(i).getMDSEQ());
                    rentDto.setSTRDT(appStatusInfo.getSTRDT());
                    rentDto.setENDDT(appStatusInfo.getENDDT());

                    // 배정된 장비목록
                    List<RentDto> assignedList = rentService
                            .assignedApp(rentDto);

                    // 제외대상
                    String[] assignedEqno_arr = new String[assignedList.size()];

                    for (int j = 0; j < assignedList.size(); j++) {
                        assignedEqno_arr[j] = assignedList.get(j).getEQNO();
                    }

                    // 배정가능 장비목록
                    if (assignedEqno_arr.length > 0) {
                        rentDto.setASSIGNEDEQNO_ARR(assignedEqno_arr);
                    }

                    rentDto.setAMOUNT(appModelList.get(i).getAMOUNT());
                    List<RentDto> allocList = rentService.allocList(rentDto);

                    // 배정
                    for (int k = 0; k < allocList.size(); k++) {

                        rentDto.setAPPNO(Integer.parseInt(appno));
                        rentDto.setMDSEQ(appModelList.get(i).getMDSEQ());
                        rentDto.setEQNO(allocList.get(k).getEQNO());

                        rentService.insAppEquip(rentDto);
                    }

                }*/

                // 관리자 메일보내기
                Address[] toAddrs = null;
                List<Map<String, String>> result = equipManageService.getAdminUserMail();
                if (result != null)
                    toAddrs = new Address[result.size()];

                int cnt = 0;
                for (Map<String, String> adminInfo : result) {
                    String empno = adminInfo.get("empno");
                    InternetAddress address = new InternetAddress(empno+ "@kepco.co.kr");
                    toAddrs[cnt] = address;
                    cnt++;
                }
                SendMail mail = SendMail.getInstance();
                String mailSubject = "[멀티미디어 설비대여 취소 알림]" + appStatusInfo.getAPPENM() + "님께서 신청하신 내역이 취소되었습니다.";
                mail.sendMail(toAddrs, appno, "toadmin", "", mailSubject);

                isResult = "success";

            } else {
                isResult = "error";
            }

            dataSourceTransactionManager.commit(statusTr);

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            dataSourceTransactionManager.rollback(statusTr);
        }

        return isResult;

    }

    /* 결재반려 */
    public String signReturn(String appno, String status, String mode)
            throws Exception {

        RentDto rentDto = new RentDto();

        // 결제 테이블 상세 업데이트
        rentDto.setAPPNO(Integer.parseInt(appno));
        rentDto.setSTATUS(status);
        rentDto.setREG_SIGN("R");
        rentService.updStatus(rentDto);

        // 신청정보 결제필드 업데이트
        rentDto.setAPPNO(Integer.parseInt(appno));
        rentDto.setIS_SIGN("R");
        rentService.updSign(rentDto);

        return "success";

    }

    /* 공통 > 배정된 장비를 변경 */
    @ResponseBody
    @RequestMapping("/admin/changeAssignedEquip.do")
    public void changeAssignedEquip(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        RentDto rentDto = new RentDto();
        String isResult = null;
        TransactionStatus status = null;

        String appno = request.getParameter("appno");
        String mdseq = request.getParameter("mdseq");
        String currMdseq = request.getParameter("currMdseq");
        String amount = request.getParameter("amount");
        String currAmount = request.getParameter("currAmount");
        String euseq = request.getParameter("euseq");
        String strdt = request.getParameter("strdt");
        String enddt = request.getParameter("enddt");

        try {

            if (!StringUtils.isEmpty(appno) && !StringUtils.isEmpty(mdseq)
                    && !StringUtils.isEmpty(currMdseq)
                    && !StringUtils.isEmpty(amount)
                    && !StringUtils.isEmpty(currAmount)
                    && !StringUtils.isEmpty(strdt)
                    && !StringUtils.isEmpty(enddt)) {

                // 남은수량 체크
                HashMap<String, Object> map = new HashMap<String, Object>();

                map.put("mdseq", mdseq);
                map.put("strdt", strdt);
                map.put("enddt", enddt);

                HashMap<String, Object> amountInfo = getEquipAmountInfo(map);

                int rentEnableCnt = (int) amountInfo.get("rentEnableCnt");

                if (mdseq.equals(currMdseq) && amountInfo != null) {
                    rentEnableCnt += Integer.parseInt(currAmount);
                }

                if (amountInfo == null || Integer.parseInt(amount) > rentEnableCnt) {
                    isResult = "amount error";
                } else {

                    // 반출전인지 체크
                    rentDto.setAPPNO(Integer.parseInt(appno));
                    RentDto signInfo = rentService.signInfo(rentDto);

                    if (Integer.parseInt(signInfo.getSTATUS()) > 3) {
                        isResult = "status error";
                    } else {

                        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
                        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
                        status = dataSourceTransactionManager.getTransaction(def);

                        rentDto.setMDSEQ(Integer.parseInt(currMdseq));
                        List<RentDto> loadCurrAppModel = rentService.loadAppModel(rentDto);
                        rentDto.setMDSEQ(Integer.parseInt(mdseq));
                        List<RentDto> loadAppModel = rentService.loadAppModel(rentDto);

                        rentDto.setEUSEQ(euseq);
                        //변경전 변경후 모델이 다를 경우
                        if(!mdseq.equals(currMdseq)) {
	                        //모델 변경시 기존모델 변화 
	                        if(loadCurrAppModel.size() > 0) {
	                        	rentDto.setMDSEQ(Integer.parseInt(currMdseq));
	                        	rentDto.setCURR_MDSEQ(currMdseq);
	                        	if(loadCurrAppModel.get(0).getAMOUNT() > 1) {
	                        		rentDto.setAMOUNT(loadCurrAppModel.get(0).getAMOUNT() -1);
	                        		rentService.updAppModel(rentDto);
	                        	}else {
	                        		rentService.delAppModel(rentDto);
	                        	}
	                        }
	                        
	                        //모델 변경시 신규모델 변화
	                        if(loadAppModel.size() > 0) {
	                        	if(loadAppModel.get(0).getAMOUNT() > 1) {
	                        		rentDto.setCURR_MDSEQ(mdseq);
	                        		rentDto.setAMOUNT(loadAppModel.get(0).getAMOUNT() +1);
	                                rentService.updAppModel(rentDto);
	                        	}
	                        }else {
	                        	rentDto.setAMOUNT(1);
	                        	rentDto.setMDSEQ(Integer.parseInt(mdseq));
	                        	rentService.insAppModel(rentDto);
	                        }
                        }

                        rentDto.setEQNO(null);
                        rentDto.setNULL(null);
                        rentDto.setEQNONULL("null");
                        rentService.updAppEquipUser(rentDto);


                        // 기본 모델로 배정되어 있는 장비를 삭제
                        rentDto.setMDSEQ(Integer.parseInt(currMdseq));
                        rentService.delAppEquip(rentDto);
                        
                        // 기본 모델로 배정되어 있는 사용자를 삭제
                        /*rentDto.setEUSEQ(euseq);
                        rentService.delAppEquipUser(rentDto);*/

                        isResult = "success";

                        dataSourceTransactionManager.commit(status);

                    }

                }

            } else {

                /*
                * WebUtils.setSessionAttribute(request, "resultMessage",
                * "input error");
                */
                isResult = "input error";
                dataSourceTransactionManager.rollback(status);

            }

        } catch (Exception e) {

            // TODO: handle exception
            e.printStackTrace();
            isResult = "exception error";

        } finally {

            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.print(isResult);

        }

    }

    public HashMap<String, Object> getEquipAmountInfo(
            HashMap<String, Object> map) throws Exception {

        String mdseq = (String) map.get("mdseq");
        String strdt = (String) map.get("strdt");
        String enddt = (String) map.get("enddt");
        String exceptSelfAppno = (String) map.get("exceptSelfAppno");
        HashMap<String, Object> rt = new HashMap<String, Object>();

        if (!StringUtil.isEmpty(mdseq) && !StringUtil.isEmpty(strdt)
                && !StringUtil.isEmpty(enddt)) {

            int equipCnt = 0;
            int currAppCnt = 0;
            int basketCnt = 0;
            int myBasketCnt = 0;

            RentDto rentDto = new RentDto();
            rentDto.setMDSEQ(Integer.parseInt(mdseq));

            // 등록된장비 총개수
            equipCnt = rentService.getEquipRentNum(rentDto);

            rentDto.setMDSEQ(Integer.parseInt(mdseq));
            rentDto.setSTRDT(strdt);
            rentDto.setENDDT(enddt);

            if (!StringUtil.isEmpty(exceptSelfAppno)) {
                rentDto.setEXCEPT_SELF_APPNO(exceptSelfAppno);
            }
            // 신청접수 개수
            currAppCnt = rentService.getCurrentAppSumAmount(rentDto);

            // 장바구니 개수
            basketCnt += rentService.getBasketSumAmount(rentDto);

            // 내 장바구니 개수
            rentDto.setREGENO(SESS_EMPNO);
            myBasketCnt += rentService.getBasketSumAmount(rentDto);

            rt.put("equipCnt", equipCnt);
            rt.put("currAppCnt", currAppCnt);
            rt.put("basketCnt", basketCnt);

            int rentEnableCnt = equipCnt - currAppCnt - basketCnt;

            if (rentEnableCnt < 0) {
                rentEnableCnt = 0;
            }

            rt.put("rentEnableCnt", rentEnableCnt);

        }

        return rt;

    }

    /*공통 > 대여기간변경*/
    @ResponseBody
    @RequestMapping({ "/admin/extendPeriodUpdate.do", "/admin/extendPeriodMsg.do" })
    public void extend_period(HttpServletRequest request,
            HttpServletResponse response) throws Exception {


        String appno = request.getParameter("appno");
        String extendEnddt = request.getParameter("extendEnddt");
        LinkedHashMap<String, Object> map = null;
        List<LinkedHashMap<String, Object>> list = new ArrayList<LinkedHashMap<String,Object>>();
        RentDto rentDto = null;
        String isResult = null;

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus statusTr = dataSourceTransactionManager.getTransaction(def);

        try {


            if (!StringUtil.isEmpty(appno) && !StringUtil.isEmpty(extendEnddt)) {


                    rentDto = new RentDto();


                    rentDto.setAPPNO(Integer.parseInt(appno));
                    RentDto EqnoAppEquipInfo = rentService.getEqnoAppEquipInfo(rentDto);

                    String strdt = EqnoAppEquipInfo.getSTRDT();
                    String enddt = EqnoAppEquipInfo.getENDDT();
                    String status = EqnoAppEquipInfo.getSTATUS();
                    String approval = EqnoAppEquipInfo.getAPPROVAL();
                    String[] appEquip = EqnoAppEquipInfo.getEQNO().split(",");


                    if(DateUtil.compareBetweenDates(extendEnddt, strdt) == 0 || DateUtil.compareBetweenDates(extendEnddt, strdt) == -1){
                        isResult = "error";
                    }else if(!status.equals("4")){
                        isResult = "error";
                    }else{

//                      연장 시작날짜
                        String extendStrdt = DateUtil.afterSpecDay(enddt, 1);

                        rentDto.setENDDT(extendStrdt);
                        rentDto.setSTRDT(extendEnddt);
                        rentDto.setAPPNO(Integer.parseInt(appno));
                        List<RentDto> reservedEqInfo = rentService.getReservedEquipInfo(rentDto);
                        for( int i = 0 ; i < reservedEqInfo.size() ; i++ ){

//                          연장기간중에 대여기간이 포함되어 있으면 리턴

                            /*if( ( DateUtil.compareBetweenDates(reservedEqInfo.get(i).getENDDT(), strdt) == 0
                            || DateUtil.compareBetweenDates(reservedEqInfo.get(i).getENDDT(), strdt) == 1 )
                            &&  ( DateUtil.compareBetweenDates(reservedEqInfo.get(i).getSTRDT(), enddt) == 0
                            || DateUtil.compareBetweenDates(reservedEqInfo.get(i).getSTRDT(), enddt) == -1 ) ){*/
                        	if( ( DateUtil.compareBetweenDates(reservedEqInfo.get(i).getENDDT(), extendStrdt) == 0
                                    || DateUtil.compareBetweenDates(reservedEqInfo.get(i).getENDDT(), extendStrdt) == 1 )
                                    &&  ( DateUtil.compareBetweenDates(reservedEqInfo.get(i).getSTRDT(), extendEnddt) == 0
                                    || DateUtil.compareBetweenDates(reservedEqInfo.get(i).getSTRDT(), extendEnddt) == -1 ) ){
                        		
                                map = new LinkedHashMap<String, Object>();
                                rentDto.setAPPNO(reservedEqInfo.get(i).getAPPNO());
                                List<RentDto> equipInfoForExt = rentService.getEquipInfoForExt(rentDto);

                                for( int j = 0 ; j < equipInfoForExt.size() ; j++ ){
                                    for ( int k = 0 ; k < appEquip.length ; k++ ) {

                                        if(equipInfoForExt.get(j).getEQNO().equals(appEquip[k])){

                                            if (request.getRequestURI().substring(19).equals("Update.do")) {

                                            // 배정된 설비가 연장된 접수 설비와 겹치면 삭제
                                            rentDto.setAPPNO(reservedEqInfo.get(i).getAPPNO());
                                            rentDto.setEQNO(equipInfoForExt.get(j).getEQNO());
                                            rentService.delAppEquip(rentDto);

                                            }

                                            map.put("appnum", reservedEqInfo.get(i).getAPPNUM());
                                            map.put("eqnm", equipInfoForExt.get(j).getEQNM() + " " + equipInfoForExt.get(j).getEQALIAS());

                                            list.add(map);
                                            break;
                                        }


                                    }
                                }

                            }
                        }


                        if (request.getRequestURI().substring(19).equals("Update.do")) {
//                          update일때

                            rentDto.setAPPNO(Integer.parseInt(appno));
                            rentDto.setSTRDT(null);
                            rentDto.setENDDT(extendEnddt);
                            rentService.updAppDate(rentDto);

                            isResult = "success";

                        } else {
//                          msg일때
                             isResult = "msg";

                        }


                    }


                dataSourceTransactionManager.commit(statusTr);
            }


        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            dataSourceTransactionManager.rollback(statusTr);
        } finally {


            if(isResult.equals("msg")){

                JSONObject json = new JSONObject();
                json.put("appnum", list);

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print(json.toString());

            }else{

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print(isResult);

            }


        }

    }


    /*대여기간 수정*/
    @ResponseBody
    @RequestMapping("/admin/modifyPeriodUpdate.do")
    public void modifyPeriodUpdate(HttpServletRequest request,
            HttpServletResponse response) throws Exception {

        String appno = request.getParameter("appno");
        String modifyStrdt = request.getParameter("modifyStrdt");
        String modifyEnddt = request.getParameter("modifyEnddt");
        String isResult = null;

        ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
        HashMap<String, Object> map = null;
        boolean retVal = false;

        try {


            if(StringUtil.isEmpty(appno) || StringUtil.isEmpty(modifyStrdt) || StringUtil.isEmpty(modifyEnddt)){
                isResult = "error";
            }else if( DateUtil.compareBetweenDates(modifyEnddt, modifyStrdt) == -1 ){
                isResult = "date_error";
            }else{
                RentDto rentDto = new RentDto();
                rentDto.setAPPNO(Integer.parseInt(appno));
                RentDto appStatusInfo = rentService.getAppStatusInfo(rentDto);


                if(appStatusInfo != null){

                    if( !appStatusInfo.getAPPROVAL().equals("2") || (!appStatusInfo.getSTATUS().equals("1") && !appStatusInfo.getSTATUS().equals("3")) ){
                        isResult = "status error";
                    }else {

                        if( (DateUtil.compareBetweenDates(modifyEnddt, appStatusInfo.getENDDT()) == 0) || (DateUtil.compareBetweenDates(modifyEnddt, appStatusInfo.getENDDT()) == -1)
                            && (DateUtil.compareBetweenDates(modifyStrdt, appStatusInfo.getSTRDT()) == 0) || (DateUtil.compareBetweenDates(modifyStrdt, appStatusInfo.getSTRDT()) == 1)){
//                          날짜가 같거나 줄어든 경우
                        }else{

                            List<RentDto> appModelInfo = rentService.loadAppModel(rentDto);
                            map = new HashMap<String, Object>();
                            for ( int i = 0 ; i < appModelInfo.size() ; i++ ){

                                if( (DateUtil.compareBetweenDates(appStatusInfo.getENDDT(), modifyStrdt) == 0) || (DateUtil.compareBetweenDates(appStatusInfo.getENDDT(), modifyStrdt)  == 1)
                                    && (DateUtil.compareBetweenDates(appStatusInfo.getSTRDT(), modifyEnddt) == 0) || (DateUtil.compareBetweenDates(appStatusInfo.getSTRDT(), modifyEnddt)  == -1) ){
//                                  날짜가 겹치는 경우
                                    map.put("mdseq", String.valueOf(appModelInfo.get(i).getMDSEQ()));
                                    map.put("strdt", modifyStrdt);
                                    map.put("enddt", modifyEnddt);
                                    map.put("exceptSelfAppno", appno);

                                }else{
                                    map.put("mdseq", String.valueOf(appModelInfo.get(i).getMDSEQ()));
                                    map.put("strdt", modifyStrdt);
                                    map.put("enddt", modifyEnddt);
                                }

                                HashMap<String, Object> amountInfo = getEquipAmountInfo(map);

                                if(appModelInfo.get(i).getAMOUNT() > (int) amountInfo.get("rentEnableCnt")){
                                    isResult = "amount error";
                                }

                            }

//                          배정된 설비 모두삭제
                            rentDto.setAPPNO(Integer.parseInt(appno));
                            rentService.delAppEquip(rentDto);
                        }

                        rentDto.setAPPNO(Integer.parseInt(appno));
                        rentDto.setSTRDT(modifyStrdt);
                        rentDto.setENDDT(modifyEnddt);
                        rentService.updAppDate(rentDto);

                        isResult = "success";
                    }


                }else{
                    isResult = "list error";
                }

            }

            retVal = true;

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            retVal = false;
        } finally {

            if (retVal != false) {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print(isResult);

            } else {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print("false");

            }
        }

    }

    /* 공통 > 승인처리 */
    @ResponseBody
    @RequestMapping({"/admin/appStatusChangeStatus.do", "/admin/appStatusChangeApproval.do"})
    public void appStatusChange(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String appno = request.getParameter("appno");
        String aval = request.getParameter("aval");
        String type = request.getRequestURI().substring(22).replace(".do", "").toLowerCase();

        String now = DateUtil.getCurrentDateTime();
        String today = DateUtil.getToday();
        String file_path = today + "/" + appno + "_" + now;
        
        File dir = new File(Constants.mailHtmlPath + today);

        if(!dir.exists()){
            dir.mkdirs();
        }

        RentDto rentDto = new RentDto();
        String isResult = null;
        boolean retVal = false;

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus statusTr = dataSourceTransactionManager.getTransaction(def);

        try {


                if(StringUtil.isEmpty(type) || StringUtil.isEmpty(appno) || StringUtil.isEmpty(aval)){
                    isResult = "error";
                }else{

                    rentDto.setAPPNO(Integer.parseInt(appno));
                    RentDto appInfo =  rentService.getAppInfo(rentDto);

                    String status = appInfo.getSTATUS();
                    String approval = appInfo.getAPPROVAL();
                    String appnum = appInfo.getAPPNUM();
                    int amount = appInfo.getAMOUNT();
                    String gbnm = appInfo.getGBNM();
                    String mdnm = appInfo.getMDNM();
                    String strdt = appInfo.getSTRDT();
                    String enddt = appInfo.getENDDT();
                    String appeno = appInfo.getAPPENO();
                    String appenm = appInfo.getAPPENM();
                    String appueno = appInfo.getAPPUENO();
                    String appuenm = appInfo.getAPPUENM();
                    
                    
                    SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
                    SimpleDateFormat sdfm = new SimpleDateFormat("yyyy-MM-dd");
                    String strDate = sdfm.format(df.parse(strdt));
                    String endDate = sdfm.format(df.parse(enddt));

                    if( status.equals("2") || approval.equals("3") ){

                        isResult = "error";

                    }else{

                        if(type.equals("status")){


                            if( aval.equals("4") && ( !status.equals("3") || !approval.equals("2") ) ){
    //                          반출시 상태값이 접수완료와 승인완료인지 체크
                                isResult = "error";
                            }else if( aval.equals("6") && ( !status.equals("4") || !approval.equals("2") )){
    //                          반납시 상태값이 사용중, 승인완료인지 체크
                                isResult = "error";
                            }else{


                                if(aval.equals("4")){
        //                          반출시 인수자와 인수일을 받는다

        //                          모두 배정이 되었는지 재확인
                                    boolean isAssignEquip =  isAssignEquip(appno);
                                    if(!isAssignEquip){
                                        isResult = "error";
                                    }else{

                                        try {
                                        	
                                            String insunm = request.getParameter("insunm");
                                            String insudt = request.getParameter("insudt");
                                            String insuno = request.getParameter("insuno");
                                            
                                            String insusignbase64 = request.getParameter("insusigndata");
                                            String insuSignImage = "";
                                            
                                            if (!StringUtil.isEmpty(insusignbase64)) {
                                            	String imageString = Base64ImageUtil.removeBase64Header(insusignbase64);
                                    			String imageType = Base64ImageUtil.getImageType(insusignbase64);
                                    			BufferedImage image = Base64ImageUtil.decodeToImage(imageString);
                                    			File imageFile = new File(Constants.mailHtmlPath + file_path + "_in" + "." + imageType);
                                    			insuSignImage = file_path + "_in" + "." + imageType;
                                    			ImageIO.write(image, imageType, imageFile);                                            	
                                            }
                                            
                                            if (!StringUtil.isEmpty(insudt)) {
                                            	insudt = insudt.replaceAll("[^0-9]", "");
                                            }

                                            if(StringUtil.isEmpty(insunm) || StringUtil.isEmpty(insudt) ){
                                                isResult = "error";
                                            }

                                            rentDto.setINSUNO(insuno);
                                            rentDto.setINSUNM(insunm);
                                            rentDto.setINSUDT(insudt);
                                            rentDto.setRENT_IN_SIGN_IMG(insuSignImage);

                                            rentDto.setAPPNO(Integer.parseInt(appno));
                                            List<RentDto> appEquip = rentService.getAppEquip(rentDto);

//                                          반출시 설비 상태를 사용중으로 업데이트
                                            for ( int i = 0 ; i < appEquip.size() ; i++ ){

                                                rentDto.setEQLST("1");
                                                rentDto.setEQNO(appEquip.get(i).getEQNO());
                                                rentDto.setMDSEQ(appEquip.get(i).getMDSEQ());
                                                rentService.updEquip(rentDto);

                                            }

                                            isResult = "success";

                                            //행사용 노트북은 반출시 메일 발송하지 않는다
                                            if(StringUtil.isEmpty(request.getParameter("en_chk"))){
	//                                          신청자 사용자에게 메일발송
	                                            SendMail sd = SendMail.getInstance();
	                                            HashMap<String, String> addrs = new HashMap<String, String>();
	                                            addrs.put("email", appeno + "@kepco.co.kr");
	                                            Address[] toAddrs = CommonUtil.mapToAddresses(addrs);
	                                            sd.htmlSendMail(toAddrs, appno, appInfo.getRENT_OUT_MAIL_PATH(), "[멀티미디어 설비대여 내역 알림] "+ gbnm + " " + mdnm +" (" + strDate + " ~ " + endDate + ")");
	                                            rentDto.setRENT_OUT_MAIL_SEND("6");
                                            }
                                            


                                        } catch (Exception e) {
                                            // TODO: handle exception
                                            e.printStackTrace();
                                            rentDto.setRENT_OUT_MAIL_SEND("9");
                                        } finally {
                                        	
//                                          상태값 적용
                                            rentDto.setSTATUS(aval);
                                            rentDto.setAPPROVAL(null);
                                            rentService.updAppInfo(rentDto);

                                        }

                                    }


                                }else if(aval.equals("6")){

                                    String banpnm = request.getParameter("banpnm");
                                    String banpdt = request.getParameter("banpdt");
                                    String banpno = request.getParameter("banpno");
                                    
                                    String banpsignbase64 = request.getParameter("banpsigndata");
                                    String banpSignImage = "";
                                    
                                    if (!StringUtil.isEmpty(banpsignbase64)) {
                                    	String imageString = Base64ImageUtil.removeBase64Header(banpsignbase64);
                            			String imageType = Base64ImageUtil.getImageType(banpsignbase64);
                            			BufferedImage image = Base64ImageUtil.decodeToImage(imageString);
                            			File imageFile = new File(Constants.mailHtmlPath + file_path+ "_out" + "." + imageType);
                            			banpSignImage = file_path+ "_out" + "." + imageType;
                            			ImageIO.write(image, imageType, imageFile);                                            	
                                    }

                                    if (!StringUtil.isEmpty(banpdt)) {
                                        banpdt = banpdt.replaceAll("[^0-9]", "") + "00";
                                    }

                                    String banpst = request.getParameter("banpst");

                                    if(StringUtil.isEmpty(banpnm) || StringUtil.isEmpty(banpdt) || StringUtil.isEmpty(banpst) ){
                                        isResult = "error";
                                    }else{

                                        rentDto.setBANPNM(banpnm);
                                        rentDto.setBANPDT(banpdt);
                                        rentDto.setBANPST(banpst);
                                        rentDto.setBANPNO(banpno);
                                        rentDto.setRENT_OUT_SIGN_IMG(banpSignImage);
                                        rentDto.setBANPDTCONV(NeoUtil.getDateTmFormat(banpdt, "-", "1"));
                                        
                                        try {

                                            rentDto.setAPPNO(Integer.parseInt(appno));
                                            List<RentDto> appEquip = rentService.getAppEquip(rentDto);

//                                          최종 반납시 장비상태를 되돌린다.
                                            for ( int i = 0 ; i < appEquip.size() ; i++ ){

                                                rentDto.setEQLST("0");
                                                rentDto.setEQNO(appEquip.get(i).getEQNO());
                                                rentDto.setMDSEQ(appEquip.get(i).getMDSEQ());
                                                rentService.updEquip(rentDto);
                                                
                                                rentDto.setEUSEQ(appEquip.get(i).getEUSEQ());
                                                RentDto equipUser = rentService.getEquipUser(rentDto);

                                                /*인수인계가 진행중일시 자동종료*/
                                                if(equipUser != null 
                                                		&& !StringUtil.isEmpty(equipUser.getUHSEQ())){
                                                	
                                                	rentDto.setMAILAPPROVAL("8");
                                                	rentDto.setUHSEQ(equipUser.getUHSEQ());
                                                    rentService.updEquipUserHistory(rentDto);
                                                    
                                                    rentDto.setNULL(null);
                                                    rentDto.setUHSEQ(null);
                                                    rentDto.setUHSEQNULL("null");
                                                    rentService.updAppEquipUser(rentDto);
                                                    rentService.updAppInfo(rentDto);
                                                	
                                                }
                                                
                                                //장비 부분 반납 정보 업데이트와 노트북인 경우 노트북 점검대장에 데이터 유무 체크하고 인서트
                                                rentService.partBanp(rentDto);
                                            }

                                            isResult = "success";

                                            /*신청자 사용자에게 메일발송*/
                                            SendMail sd = SendMail.getInstance();
                                            HashMap<String, String> addrs = new HashMap<String, String>();
                                            addrs.put("email", appeno + "@kepco.co.kr");
                                            Address[] toAddrs = CommonUtil.mapToAddresses(addrs);
                                            sd.htmlSendMail(toAddrs, appno, appInfo.getRENT_IN_MAIL_PATH(), "[멀티미디어 설비대여 반납 알림] "+ gbnm + " " + mdnm +" (" + strDate + " ~ " + endDate + ")");
                                            rentDto.setRENT_IN_MAIL_SEND("6");
                                            
                                        } catch (Exception e) {
                                            // TODO: handle exception
                                            e.printStackTrace();
                                            rentDto.setRENT_IN_MAIL_SEND("9");
                                        } finally {

//                                          상태값 적용
                                            rentDto.setSTATUS(aval);
                                            rentDto.setAPPROVAL(null);
                                            rentDto.setUHSEQ(null);
                                            rentService.updAppInfo(rentDto);

                                        }

                                    }

                                }
                            }


                        }else if(type.equals("approval")){
//                          승인여부 변경

                            if( aval.equals("2") && ( !status.equals("3") && !approval.equals("1"))){
    //                          승인시 상태값이 접수완료와 승인대기중인지 체크
                                isResult = "error";
                            }else{

                                if(aval.equals("2")){

    //                              승인

    //                              신청자 사용자에게 메일발송
                                    SendMail sd = SendMail.getInstance();
                                    HashMap<String, String> addrs = new HashMap<String, String>();
                                    addrs.put("email", appeno + "@kepco.co.kr");
                                    Address[] toAddrs = CommonUtil.mapToAddresses(addrs);
                                                                        
                                    String mailTitle = "[멀티미디어 설비대여 승인 알림] "+ gbnm + " " + mdnm +" (" + strDate + " ~ " + endDate + ")";
                                    sd.sendMail(toAddrs, appno, "touser", status, mailTitle);

    //                              신청자 사용자에게 SMS발송
                                    SendSMS ss =  SendSMS.getInstance();

                                    String msg = "[설비대여 승인 알림]"+appenm+" 님께서 신청하신 내역을 승인하였음을 알려드립니다.";
//                                            msg += "* 신청번호 : " + appnum;
//                                            msg += "* 신청자 : " + appenm;
//                                            msg += "* 대여설비 : " + gbnm;
//                                            msg += "* 수량 : " + amount;
//                                            msg += "* 대여기간 : " + strdt + "~" + enddt;
//                                            msg += "* 대여장소 : 멀티미디어 센터";

                                    rentDto.setAPPENO(appeno);
                                    rentDto.setAPPUENO(appueno);
                                    List<RentDto> cellNoList = rentService.smsToUser(rentDto);
                                    if(cellNoList.size() > 0){
                                        ss.rentalSendSMS(new BigInteger(DateUtil.getCurrentDateTime()), msg, cellNoList);
                                    }
                                }else if(aval.equals("3")){
    //                              반려
    //                              배정된 설비 삭제
                                    rentDto.setAPPNO(Integer.parseInt(appno));
                                    rentService.delAppEquip(rentDto);
                                }


                                rentDto.setSTATUS(null);
                                rentDto.setAPPROVAL(aval);
                                rentService.updAppInfo(rentDto);

                                isResult = "success";
                            }
                        }

                    }


            }

            retVal = true;
            dataSourceTransactionManager.commit(statusTr);

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            dataSourceTransactionManager.rollback(statusTr);
            retVal = false;
        } finally {

            if (retVal != false) {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print(isResult);

            } else {

                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.print("false");

            }
        }

    }

    /*배정장비여부*/
    public boolean isAssignEquip(String appno) throws Exception{

        RentDto rentDto = new RentDto();
        boolean rt = false;

        if(StringUtil.isEmpty(appno)){
            return false;

        }else{

            int appAmount = 0;
            int assignAmount = 0;

            rentDto.setAPPNO(Integer.parseInt(appno));
            RentDto appModelInfo = rentService.getAppModelInfo(rentDto);

            if(appModelInfo.getAMOUNT() > 0){
                appAmount = appModelInfo.getAMOUNT();
            }

            if(!StringUtil.isEmpty(appModelInfo.getMDSEQ_GRP())){
                String[] str = appModelInfo.getMDSEQ_GRP().split(",");
                Integer[] mdseq_arr = ArrayUtils.toObject((int[]) new IntegerArrayConverter().convert(null, str));
                rentDto.setMDSEQ_ARR(mdseq_arr);
                assignAmount = rentService.getAppAmount(rentDto);
            }

            if((appAmount > 0 && assignAmount > 0) && (appAmount == assignAmount)){
                rt = true;
            }
            return rt;
        }
    }


    @ResponseBody
    @RequestMapping({"/admin/changeEquipUser.do"})
    public void changeEquipUser(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String euseq = request.getParameter("euseq");
        String appno = request.getParameter("appno");
        String mdseq = request.getParameter("mdseq");
        String eqno = request.getParameter("eqno");
        String eu_mode = request.getParameter("eu_mode");
        String mode = request.getParameter("mode");
        String insuno = request.getParameter("insuno") == "" ? null : request.getParameter("insuno");
        String insunm = request.getParameter("insunm") == "" ? null : request.getParameter("insunm");
        String ingaeno = request.getParameter("ingaeno") == "" ? null : request.getParameter("ingaeno");
        String ingaenm = request.getParameter("ingaenm") == "" ? null : request.getParameter("ingaenm");
        String regeno = request.getParameter("regeno") == "" ? null : request.getParameter("regeno");
        String regenm = request.getParameter("regenm") == "" ? null : request.getParameter("regenm");
        String uhseq = request.getParameter("uhseq") == "" ? null : request.getParameter("uhseq");
        String deptno = request.getParameter("deptno") == "" ? null : request.getParameter("deptno");
        String DEPT1NM = request.getParameter("DEPT1NM") == "" ? null : request.getParameter("DEPT1NM");


        boolean retVal = false;

        RentDto rentDto = new RentDto();

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = dataSourceTransactionManager.getTransaction(def);

        if(eu_mode.equals("change_equipuser")){

            /*장비사용자 인수인계*/

            try {

                rentDto.setAPPNO(Integer.parseInt(appno));
                rentDto.setMDSEQ(Integer.parseInt(mdseq));
                rentDto.setEUSEQ(euseq);
                rentDto.setEQNO(eqno);
                rentDto.setMODE(mode);
                rentDto.setINSUNO(insuno);
                rentDto.setINSUNM(insunm);
                rentDto.setINGAENO(ingaeno);
                rentDto.setINGAENM(ingaenm);
                rentDto.setREGENO(regeno);
                rentDto.setREGENM(regenm);
                rentDto.setUHSEQ(uhseq);

                RentDto beforeTaskEuHistory = rentService.getEquipUserHistory(rentDto);

                if (beforeTaskEuHistory != null){
                    /*이미 인수인계가 진행중일시 자동종료처리*/
                    if(beforeTaskEuHistory.getMAILAPPROVAL() == "0"){
                        rentDto.setMAILAPPROVAL("8");
                        rentService.updEquipUserHistory(rentDto);
                    }
                }

                rentService.insEquipUserHistory(rentDto);
                rentDto.setMDSEQ(null);
                rentDto.setCURR_MDSEQ(mdseq);
                String maxUhseq = rentService.getMaxUhseq(rentDto);
                rentDto.setUHSEQ(maxUhseq);
               /* rentDto.setDEPTNO(deptno);
                rentDto.setDEPT1NM(DEPT1NM);*/
                rentService.updAppEquipUser(rentDto);
                rentDto.setCURR_MDSEQ(null);

                RentDto equipUserHistory = rentService.getEquipUserHistory(rentDto);

                /*인수자에게 인수요청*/
                SendMail sd = SendMail.getInstance();
                HashMap<String, String> addrs = new HashMap<String, String>();
                addrs.put("email", equipUserHistory.getINSUNO() + "@kepco.co.kr");
                Address[] toAddrs = CommonUtil.mapToAddresses(addrs);
                sd.sendMail(toAddrs, appno, "chgEu", maxUhseq, "[멀티미디어센터]" + equipUserHistory.getINGAENM() + "님께서 " + equipUserHistory.getINSUNM() + " 님께 대여설비를 인계요청 하였습니다.");

                /*관리자에게 인수정보 메일 보내기*/
                List<Map<String, String>> result = equipManageService.getAdminUserMail();
                if (result != null)
                    toAddrs = new Address[result.size()];

                int cnt = 0;
                for (Map<String, String> adminInfo : result) {
                    String empno = adminInfo.get("empno");
                    InternetAddress address = new InternetAddress(empno+ "@kepco.co.kr");
                    toAddrs[cnt] = address;
                    cnt++;
                }
                String mailSubject = "[멀티미디어센터]" + equipUserHistory.getINGAENM() + "님께서 " + equipUserHistory.getINSUNM() + " 님께 대여설비를 인계요청 하였습니다.";
                sd.sendMail(toAddrs, appno, "chgEu_adm", maxUhseq, mailSubject);


                retVal = true;
                dataSourceTransactionManager.commit(status);

            } catch (Exception e) {
                e.printStackTrace();
                retVal = false;
                dataSourceTransactionManager.rollback(status);
            } finally {

                if(retVal != false){
                    response.setContentType("text/html;charset=utf-8");
                    PrintWriter out = response.getWriter();
                    out.print("true");
                }else{
                    response.setContentType("text/html;charset=utf-8");
                    PrintWriter out = response.getWriter();
                    out.print("false");
                }

            }


        } else if (eu_mode.equals("edit_equipuser")){

            /*장비사용자 수정처리*/

            try {

                rentDto.setAPPNO(Integer.parseInt(appno));
                rentDto.setCURR_MDSEQ(mdseq);
                rentDto.setEUSEQ(euseq);
                rentDto.setAPPUENO(insuno);
                rentDto.setAPPUENM(insunm);
                rentDto.setDEPTNO(deptno);
                rentDto.setDEPT1NM(DEPT1NM);

                rentService.updAppEquipUser(rentDto);
                retVal = true;
                dataSourceTransactionManager.commit(status);

            } catch (Exception e) {
                e.printStackTrace();
                retVal = false;
                dataSourceTransactionManager.rollback(status);
            } finally {

                if(retVal != false){
                    response.setContentType("text/html;charset=utf-8");
                    PrintWriter out = response.getWriter();
                    out.print("true");
                }else{
                    response.setContentType("text/html;charset=utf-8");
                    PrintWriter out = response.getWriter();
                    out.print("false");
                }

            }

        } else if (eu_mode.equals("cancel_equipuser")){

            /*장비사용자 인수인계 취소처리*/

            try {

                rentDto.setAPPNO(Integer.parseInt(appno));
                rentDto.setEUSEQ(euseq);
                rentDto.setUHSEQ(uhseq);
                rentDto.setMAILAPPROVAL("9");

                rentService.updEquipUserHistory(rentDto);

                rentDto.setNULL(null);
                rentDto.setUHSEQ(null);
                rentDto.setUHSEQNULL("null");
                rentService.updAppEquipUser(rentDto);

                rentDto.setUHSEQ(uhseq);
                RentDto equipUserHistory = rentService.getEquipUserHistory(rentDto);

                /*인수자에게 인수요청*/
                SendMail sd = SendMail.getInstance();
                HashMap<String, String> addrs = new HashMap<String, String>();
                addrs.put("email", equipUserHistory.getINSUNO() + "@kepco.co.kr");
                Address[] toAddrs = CommonUtil.mapToAddresses(addrs);
                sd.sendMail(toAddrs, appno, "chgEu", uhseq, "[멀티미디어센터]" + equipUserHistory.getINSUNM() + "님이 " + equipUserHistory.getINGAENM() + " 님의 대여설비 인계 요청을 취소하였습니다.");

                /*관리자에게 인수정보 메일 보내기*/
                List<Map<String, String>> result = equipManageService.getAdminUserMail();
                if (result != null)
                    toAddrs = new Address[result.size()];

                int cnt = 0;
                for (Map<String, String> adminInfo : result) {
                    String empno = adminInfo.get("empno");
                    InternetAddress address = new InternetAddress(empno+ "@kepco.co.kr");
                    toAddrs[cnt] = address;
                    cnt++;
                }
                String mailSubject = "[멀티미디어센터]" + equipUserHistory.getINSUNM() + "님이 " + equipUserHistory.getINGAENM() + " 님의 대여설비 인계 요청을 취소하였습니다.";
                sd.sendMail(toAddrs, appno, "chgEu_adm", uhseq, mailSubject);

                retVal = true;
                dataSourceTransactionManager.commit(status);

            } catch (Exception e) {
                e.printStackTrace();
                retVal = false;
                dataSourceTransactionManager.rollback(status);
            } finally {

                if(retVal != false){
                    response.setContentType("text/html;charset=utf-8");
                    PrintWriter out = response.getWriter();
                    out.print("cancel_true");
                }else{
                    response.setContentType("text/html;charset=utf-8");
                    PrintWriter out = response.getWriter();
                    out.print("cancel_false");
                }

            }

        } else if (eu_mode.equals("change_equipmanager")) {

            /*장비담당자 인수인계*/

            try {

                rentDto.setAPPNO(Integer.parseInt(appno));
                rentDto.setEUSEQ(euseq);
                rentDto.setUHSEQ(uhseq);
                rentDto.setMODE(mode);
                rentDto.setINSUNO(insuno);
                rentDto.setINSUNM(insunm);
                rentDto.setINGAENO(ingaeno);
                rentDto.setINGAENM(ingaenm);
                rentDto.setREGENO(regeno);
                rentDto.setREGENM(regenm);

                RentDto beforeTaskEuHistory = rentService.getEquipUserHistory(rentDto);

                if (beforeTaskEuHistory != null){
                    /*이미 인수인계가 진행중일시 자동종료처리*/
                    if(beforeTaskEuHistory.getMAILAPPROVAL() == "0"){
                        rentDto.setMAILAPPROVAL("8");
                        rentService.updEquipUserHistory(rentDto);
                    }
                }

                rentService.insEquipUserHistory(rentDto);

                String maxUhseq = rentService.getMaxUhseq(rentDto);
                rentDto.setUHSEQ(maxUhseq);

                rentDto.setINSUNO(null);
                rentDto.setINSUNM(null);
                rentDto.setINGAENO(null);
                rentDto.setINGAENM(null);
                rentDto.setREGENO(null);
                rentDto.setREGENM(null);
                rentService.updAppInfo(rentDto);

                RentDto equipUserHistory = rentService.getEquipUserHistory(rentDto);

                SendMail sd = SendMail.getInstance();
                HashMap<String, String> addrs = new HashMap<String, String>();
                Address[] toAddrs = null;


                /*인수자에게 인수요청*/
                addrs.put("email", equipUserHistory.getINSUNO() + "@kepco.co.kr");
                toAddrs = CommonUtil.mapToAddresses(addrs);
                sd.sendMail(toAddrs, appno, "chgEm", maxUhseq, "[멀티미디어센터] "+equipUserHistory.getINGAENM()+" 님께서 대여한 멀티미디어 설비를 인계하였음을 알려드립니다.");


                /*관리자에게 인수정보 메일 보내기*/
                List<Map<String, String>> result = equipManageService.getAdminUserMail();
                if (result != null)
                    toAddrs = new Address[result.size()];

                int cnt = 0;
                for (Map<String, String> adminInfo : result) {
                    String empno = adminInfo.get("empno");
                    InternetAddress address = new InternetAddress(empno+ "@kepco.co.kr");
                    toAddrs[cnt] = address;
                    cnt++;
                }
                String mailSubject = "[멀티미디어센터]" + equipUserHistory.getINGAENM() + "님께서 대여한 멀티미디어 설비를 " + equipUserHistory.getINSUNM() + " 님께 인계하였음을 알려드립니다.";
                sd.sendMail(toAddrs, appno, "chgEm_adm", maxUhseq, mailSubject);

                retVal = true;
                dataSourceTransactionManager.commit(status);

            } catch (Exception e) {
                e.printStackTrace();
                retVal = false;
                dataSourceTransactionManager.rollback(status);
            } finally {

                if(retVal != false){
                    response.setContentType("text/html;charset=utf-8");
                    PrintWriter out = response.getWriter();
                    out.print("true");
                }else{
                    response.setContentType("text/html;charset=utf-8");
                    PrintWriter out = response.getWriter();
                    out.print("false");
                }

            }


        } else if (eu_mode.equals("cancel_equipmanager")) {

            /*장비담당자 인수인계 취소처리*/

            try {

                rentDto.setAPPNO(Integer.parseInt(appno));
                rentDto.setUHSEQ(uhseq);
                rentDto.setMAILAPPROVAL("9");

                rentService.updEquipUserHistory(rentDto);

                rentDto.setNULL(null);
                rentDto.setUHSEQ(null);
                rentDto.setUHSEQNULL("null");
                rentService.updAppInfo(rentDto);

                rentDto.setUHSEQ(uhseq);
                RentDto equipUserHistory = rentService.getEquipUserHistory(rentDto);

                /*인수자에게 인수요청*/
                SendMail sd = SendMail.getInstance();
                HashMap<String, String> addrs = new HashMap<String, String>();
                addrs.put("email", equipUserHistory.getINSUNO() + "@kepco.co.kr");
                Address[] toAddrs = CommonUtil.mapToAddresses(addrs);
                sd.sendMail(toAddrs, appno, "chgEm", uhseq, "[멀티미디어센터] "+equipUserHistory.getINGAENM()+" 님께서 대여한 멀티미디어 설비를 인수 취소하였음을 알려드립니다.");

                /*관리자에게 인수정보 메일 보내기*/
                List<Map<String, String>> result = equipManageService.getAdminUserMail();
                if (result != null)
                    toAddrs = new Address[result.size()];

                int cnt = 0;
                for (Map<String, String> adminInfo : result) {
                    String empno = adminInfo.get("empno");
                    InternetAddress address = new InternetAddress(empno+ "@kepco.co.kr");
                    toAddrs[cnt] = address;
                    cnt++;
                }
                String mailSubject = "[멀티미디어센터]" + equipUserHistory.getINGAENM() + "님께서 대여한 멀티미디어 설비를 " + equipUserHistory.getINSUNM() + " 님께 인계 취소하였음을 알려드립니다.";
                sd.sendMail(toAddrs, appno, "chgEm_adm", uhseq, mailSubject);

                retVal = true;
                dataSourceTransactionManager.commit(status);

            } catch (Exception e) {
                e.printStackTrace();
                retVal = false;
                dataSourceTransactionManager.rollback(status);
            } finally {

                if(retVal != false){
                    response.setContentType("text/html;charset=utf-8");
                    PrintWriter out = response.getWriter();
                    out.print("cancel_true");
                }else{
                    response.setContentType("text/html;charset=utf-8");
                    PrintWriter out = response.getWriter();
                    out.print("cancel_false");
                }

            }

        }


    }
    
    /*결재창 */
    @RequestMapping("/iniJojikdo.do")
    public ModelAndView iniJojikdo(HttpServletRequest request) throws Exception {
    	
    	String jojikdo = request.getParameter("jojikdo") == null ? "0" : request.getParameter("jojikdo");
    	String user_name = request.getParameter("userName") == null ? "" : request.getParameter("userName");
    	String pos_name = request.getParameter("posName") == null ? "" : request.getParameter("posName");
    	String type = request.getParameter("type") == null ? "" : request.getParameter("type");
    	String no_gubun = request.getParameter("no_gubun") == null ? "" : request.getParameter("no_gubun");
    	String sign_degree = "";
    	
    	if(jojikdo.equals("")){
    		jojikdo = "0";
    	}
    	
    	if(no_gubun.equals("N")){
    		sign_degree = "3";
    	}else{
    		sign_degree = "4";
    	}
    	
    	ModelAndView mv = new ModelAndView();
    	
    	mv.addObject("jojikdo", jojikdo);
    	mv.addObject("user_name", user_name);
    	mv.addObject("pos_name", pos_name);
    	mv.addObject("type", type);
    	mv.addObject("no_gubun", no_gubun);
    	mv.addObject("sign_degree", sign_degree);
    	
    	mv.setViewName("/rent/iniJojikdo");
    	
    	return mv;
    }
    
    /*결재창(내부) - 조직도 */
    @RequestMapping("/jojikdo.do")
    public ModelAndView jojikdo(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("UTF-8");
    	
    	String mode = request.getParameter("mode") == null ? "" : request.getParameter("mode");
    	String jojikdo = request.getParameter("jojikdo") == null ? "0" : request.getParameter("jojikdo");
    	String key = request.getParameter("key") == null ? "" : request.getParameter("key");
    	String decode = request.getParameter("decode") == null ? "" : request.getParameter("decode");
    	String user_name = request.getParameter("user_name") == null ? "" : request.getParameter("user_name");
    	String pos_name = request.getParameter("pos_name") == null ? "" : request.getParameter("pos_name");
    	String type = request.getParameter("type") == null ? "" : request.getParameter("type");
    	String no_gubun = request.getParameter("no_gubun") == null ? "" : request.getParameter("no_gubun");
    	String sign_degree = "";
    	List<RentDto> searchUserList = null;
    	ModelAndView mv = new ModelAndView();
    	
    	if(jojikdo.equals("")){
    		jojikdo = "0";
    	}
    	
    	if(no_gubun.equals("N")){
    		sign_degree = "3";
    	}else{
    		sign_degree = "4";
    	}
    	
    	
    	mv.addObject("jojikdo", jojikdo);
    	mv.addObject("user_name", user_name);
    	mv.addObject("pos_name", pos_name);
    	mv.addObject("type", type);
    	mv.addObject("no_gubun", no_gubun);
    	mv.addObject("sign_degree", sign_degree);
    	mv.addObject("mode", mode);
    	mv.addObject("searchUserList", searchUserList);
    	
    	
    	mv.setViewName("/rent/jojikdo");
    	
    	return mv;
    }
    
    @RequestMapping(value = "/getSearchUserList.do")
    public ModelAndView getSearchUserList(HttpServletRequest request) throws Exception {
    	
    	String mode = request.getParameter("mode") == null ? "" : request.getParameter("mode");
    	String key = request.getParameter("key") == null ? "" : request.getParameter("key");
    	List<RentDto> searchUserList = null;
    	
    	System.out.println("mode : " + mode);
    	System.out.println("key : " + key);
    	
        ModelAndView mv = new ModelAndView();

    	if(mode.equals("search")){
    	    
    	    RentDto searchDto = new RentDto();
    	    
    	    if( Pattern.matches("[가-힣]", key.substring(0, 1)) ){
    	        searchDto.setUser_name(key);
    	    } else {
    	        searchDto.setEMPNO(key);  
    	    }
    	    
    	    try {
    	    	 searchUserList = rentService.getSearchUser(searchDto);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
    	    
    	   
    	    
    	    mv.addObject("searchUserList", searchUserList);
    	    mv.setViewName("jsonView");

            return mv;
    	    
    	}

        mv.setViewName("jsonView");

        return mv;
    }
    
    @RequestMapping(value = "/getDeptAllList.do")
    public ModelAndView getDeptAllList() throws Exception {
        ModelAndView mv = new ModelAndView();

        List<RentDto> dept1List = rentService.getDept1List();
    	List<RentDto> dept2List = rentService.getDept2List();
//    	List<RentDto> dept3List = rentService.getDept3List();
//    	List<RentDto> dept4List = rentService.getDept4List();
//    	List<RentDto> dept5List = rentService.getDept5List();
//    	List<RentDto> dept6List = rentService.getDept6List();

    	List<RentDto> dept1UserList = rentService.getDept1UserListByCode();
    	List<RentDto> dept2UserList = rentService.getDept2UserListByCode();

        mv
        .addObject("deptList01", dept1List)
        .addObject("deptList02", dept2List)
        .addObject("deptUserList01", dept1UserList)
        .addObject("deptUserList02", dept2UserList);
//        .addObject("deptList03", dept3List);
//        .addObject("deptList04", dept4List)
//        .addObject("deptList05", dept5List)
//        .addObject("deptList06", dept6List);

        mv.setViewName("jsonView");

        return mv;
    }

    @RequestMapping(value = "/getDept3ListByCode.do")
    public ModelAndView getDept3ListByCode(HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        RentDto rentDto = new RentDto();
        rentDto.setDept_code(request.getParameter("deptCode"));

        List<RentDto> deptList = rentService.getDept3ListByCode(rentDto);
        List<RentDto> deptUserList = rentService.getDept3UserListByCode(rentDto);

        mv.addObject("deptList03", deptList);
        mv.addObject("deptUserList03", deptUserList);

        mv.setViewName("jsonView");

        return mv;
    }

    @RequestMapping(value = "/getDept4ListByCode.do")
    public ModelAndView getDept4ListByCode(HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        RentDto rentDto = new RentDto();
        rentDto.setDept_code(request.getParameter("deptCode"));

        List<RentDto> deptList = rentService.getDept4ListByCode(rentDto);
        List<RentDto> deptUserList = rentService.getDept4UserListByCode(rentDto);

        mv.addObject("deptList04", deptList);
        mv.addObject("deptUserList04", deptUserList);

        mv.setViewName("jsonView");

        return mv;
    }


    @RequestMapping(value = "/getDept5ListByCode.do")
    public ModelAndView getDept5ListByCode(HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        RentDto rentDto = new RentDto();
        rentDto.setDept_code(request.getParameter("deptCode"));

        List<RentDto> deptList = rentService.getDept5ListByCode(rentDto);
        List<RentDto> deptUserList = rentService.getDept5UserListByCode(rentDto);

        mv.addObject("deptList05", deptList);
        mv.addObject("deptUserList05", deptUserList);

        mv.setViewName("jsonView");

        return mv;
    }


    @RequestMapping(value = "/getDept6ListByCode.do")
    public ModelAndView getDept6ListByCode(HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        RentDto rentDto = new RentDto();
        rentDto.setDept_code(request.getParameter("deptCode"));

        List<RentDto> deptList = rentService.getDept6ListByCode(rentDto);
        List<RentDto> deptUserList = rentService.getDept6UserListByCode(rentDto);

        mv.addObject("deptList06", deptList);
        mv.addObject("deptUserList06", deptUserList);

        mv.setViewName("jsonView");

        return mv;
    }

    @RequestMapping(value = "/getDeptUserlist.do")
    public ModelAndView getsDeptUserTbl(HttpServletRequest request) throws Exception {
    	
        ModelAndView mv = new ModelAndView();

        RentDto rentDto = new RentDto();
        rentDto.setDEPTNO(request.getParameter("deptCode"));
        
        List<RentDto> resultList = rentService.getDeptEmpList(rentDto);
        mv.addObject("deptUserList", resultList);

        mv.setViewName("jsonView");
        return mv;
    }
    

}
