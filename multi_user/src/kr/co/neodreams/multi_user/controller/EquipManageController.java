package kr.co.neodreams.multi_user.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.Address;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.converters.IntegerArrayConverter;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.CommonUtil;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.DataMap;
import kr.co.neodreams.multi_user.common.DateUtil;
import kr.co.neodreams.multi_user.common.DownloadView;
import kr.co.neodreams.multi_user.common.ExcelUtil;
import kr.co.neodreams.multi_user.common.NeoUtil;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.common.mail.SendMail;
import kr.co.neodreams.multi_user.common.onestop.OneStopLogVO;
import kr.co.neodreams.multi_user.common.onestop.OneStopVO;
import kr.co.neodreams.multi_user.common.onestop.SendONESTOP;
import kr.co.neodreams.multi_user.dto.ContentsDto;
import kr.co.neodreams.multi_user.dto.EquipManageDto;
import kr.co.neodreams.multi_user.dto.PowerstatusDto;
import kr.co.neodreams.multi_user.dto.RentDto;
import kr.co.neodreams.multi_user.service.EquipManageService;
import kr.co.neodreams.multi_user.service.PowerstatusService;
import kr.co.neodreams.multi_user.service.RentService;
import net.arnx.jsonic.JSON;

/**
 * @author user
 *
 */
@Controller
public class EquipManageController extends BaseController{

	public static String dir_path 	= Constants.rent_security_path;
	@Autowired
	DownloadView dowoloadView;
	
    @Autowired
    EquipManageService equipManageService;

    @Autowired
    PowerstatusService powerstatusService;

    @Autowired
    RentService rentService;
    
    @Autowired
    DataSourceTransactionManager dataSourceTransactionManager;
    
    @Resource(name = "commonUtil")
    private CommonUtil commonUtil;

    /**
     * @param EquipManageDto
     * @param HttpServletRequest
     * @return view(equipRentList)
     * 장비대여 설비 현황
     */
    @RequestMapping("/equipRentList.do")
    public ModelAndView equipRentList(EquipManageDto equipManageDto, HttpServletRequest request){

        ModelAndView mv = new ModelAndView();
        mv.setViewName("rent/equipRentList");

        /*세션에서 사번취득 후 삽입*/
        String sM_MEMPNO = SESS_EMPNO;
        equipManageDto.setSM_MEMPNO(sM_MEMPNO);

        /*오늘날짜 취득*/
        Date today = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String todayStr = sdf.format(today);

        /*대여일 ~부터*/
        String strdt = equipManageDto.getStrdt();
        if (StringUtil.isEmpty(strdt)){
            strdt = todayStr;
            equipManageDto.setStrdt(strdt);
        }
        mv.addObject("strdt", strdt);

        /*반납일 ~까지*/
        String enddt = equipManageDto.getEnddt();
        if (StringUtil.isEmpty(enddt)){
            enddt = todayStr;
            equipManageDto.setEnddt(enddt);
        }
        mv.addObject("enddt", enddt);
        /*대여가능 수량 ( amount )*/
        String amount = equipManageDto.getAmount();
        mv.addObject("amount", amount);

        /*리스트정렬 구분자*/
        String orderBy = equipManageDto.getOrderBy();
        mv.addObject("orderBy", orderBy);

        /*베스트순*/
        String bestTxt = request.getParameter("bestTxt");
        if(StringUtils.isNotEmpty(bestTxt)) {
            mv.addObject("bestTxt", bestTxt);
        } else {
            mv.addObject("bestTxt", "베스트순▼");
        }

        /*출시년월순*/
        String lchTxt = request.getParameter("lchTxt");
        if(StringUtils.isNotEmpty(lchTxt)) {
            mv.addObject("lchTxt", lchTxt);
        } else {
            mv.addObject("lchTxt", "출시년월순▼");
        }

        int totalCnt = 0;
        try {
            /*코드(대) 데이터를가져온다.*/
            List<EquipManageDto> codeList = new ArrayList<EquipManageDto> ();
            codeList = equipManageService.getCodeList(equipManageDto);
            EquipManageDto firstCode = new EquipManageDto();
            firstCode.setGbcd("-1");
            firstCode.setGbnm("선택");
            codeList.add(0, firstCode);
            
            mv.addObject("codeList", codeList);

            String code = request.getParameter("selectCode");
            if (StringUtils.isEmpty(code)) {
                code = codeList.get(0).getGbcd();
                if (StringUtils.isEmpty(code)) {
                    mv.setViewName("/error/error");
                    return mv;
                }
            }
            mv.addObject("selectCode", code);
            equipManageDto.setCode(code);

            /*표준모델 등록 하위코드 가져오기*/
            Map<String, Object> subTreeMap = new LinkedHashMap<String, Object> ();
            subTreeMap = equipManageService.getSubTreeList(equipManageDto);
            mv.addObject("subTreeMap", subTreeMap);

            /*장비 검색시의 조건 정리*/
            String searchValParam = request.getParameter("searchVal");
            if(StringUtils.isNotEmpty(searchValParam)){
                String searchVal = "";
                String[] searchValArr = searchValParam.split(",");
                if (code.equals(searchValArr[0].substring(0, 3))) {
                    for (int i=0; i < searchValArr.length; i++) {
                        if (searchValArr[i].length() == 6) {
                            searchVal += "MS.GBCD = " + "'" + searchValArr[i] + "'";
                        } else if (searchValArr[i].length() == 9){
                            searchVal += "MS.ITEM = " + "'" + searchValArr[i] + "'";
                        }
                        if (i < searchValArr.length - 1) {
                            if (searchValArr[i].length() > 0) {
                                searchVal += " OR ";
                            }
                        }
                    }
                    equipManageDto.setSearchVal(searchVal);
                    equipManageDto.setItemCnt(searchValArr.length);
                    mv.addObject("searchVal", searchValParam);
                } else {
                    equipManageDto.setSearchVal(searchVal);
                    equipManageDto.setItemCnt(0);
                    mv.addObject("searchVal", "");
                }

            }

            /*대여가능 장비 리스트 취득*/
            List<EquipManageDto> equipManageList = new ArrayList<EquipManageDto> ();
            List<EquipManageDto> remakeList = new ArrayList<EquipManageDto> ();
            equipManageList = equipManageService.getEquipManageList(equipManageDto);
            
            /*문자를 데이터형으로 변경*/
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");

            String strDt = strdt.replace("-","").replace("/","").trim().substring(0, 8);
            String endDt = enddt.replace("-","").replace("/","").trim().substring(0, 8);
            
            for(EquipManageDto dto : equipManageList)
            {

                dto.setStrdt(strDt);
                dto.setEnddt(endDt);

                /*대여 가능 설비 정보*/
                Map<String, Object> amountInfo = equipManageService.getEquipAmountInfo(dto, SESS_EMPNO);
                int rentEnableCnt = (int) amountInfo.get("rentEnableCnt");
                int equipCnt = (int) amountInfo.get("equipCnt");

                /*대여 가능 설비 대수 체크*/
                if(rentEnableCnt < 1)
                {
                    /*대여 가능 설비 없을 시 객체 리메이크리스트에 집어넣지 않음*/
                    continue;
                }
                dto.setRentEnableCnt(rentEnableCnt);

                /*orderBy의 값이 있을경우 정렬기준 값 취득*/
                if(StringUtils.isNotEmpty(orderBy)) {
                    int rentnum = equipManageService.getRentNumByModel(dto);
                    dto.setBest(rentnum);
                    dto.setLch(dto.getLchdt());
                }

                /*12달이내의 모델은 new(이미지)를 붙인다.*/
                if (Math.abs(Math.floor(dto.getBetMonth())) <= 12) {
                    dto.setLchImg("<img src='../images/icon_new.png' alt='' />");
                }

                /*모델상세정보 취득*/
                dto.setItem(equipManageService.getModelSub(dto));

                /*모델 이미지 취득*/
                dto.setImageUrl(equipManageService.getImageUrl(dto));

                if(rentEnableCnt > 0) {
                    dto.setCheckbox("true");
                    dto.setEqEnable(rentEnableCnt);
                    dto.setEqAll(equipCnt);
                }

                remakeList.add(dto);
            }

            /*화면으로 넘기기전 정렬조건 맞춰 리스트 정렬*/
            if(StringUtils.isNotEmpty(orderBy)) {

                if (orderBy.contains("bestAsc")) {/*베스트 오름차순*/
                    Collections.sort(remakeList, new ComparatorBestAsc());
                } else if (orderBy.contains("bestDesc")) {/*베스트순 내림차순*/
                    Collections.sort(remakeList, new ComparatorBestDesc());
                } else if (orderBy.contains("lchAsc")) {/*출시년월순 오름차순*/
                    Collections.sort(remakeList, new ComparatorLchAsc());
                } else if (orderBy.contains("lchDesc")) {/*출시년월순 내림차순*/
                    Collections.sort(remakeList, new ComparatorLchDesc());
                }
            }

            /*조회 결과에서 리스트 카운트*/
            totalCnt = remakeList.size();

            /*화면에 가져갈 리스트 담기*/
            mv.addObject("equipManageList", remakeList);

            /*화면에 가져갈 리스트 카운트 담기*/
            mv.addObject("totalCnt", totalCnt);

        } catch (Exception e) {
          // TODO TRY/CATCH
          e.printStackTrace();
          /*에러 화면 이동*/
          mv.setViewName("/error/error");
        }

        /*페이징 처리를 위한 값 담기*/
        mv.addObject("paging", equipManageDto);

        mv.addObject("config", Constants.getConfigOption());

        return mv;
    }

    /**
     * 베스트 내림차순 정렬
     */
    private final class ComparatorBestDesc implements Comparator<EquipManageDto> {
        @Override
        public int compare(EquipManageDto o1, EquipManageDto o2) {
            int firstValue = Integer.valueOf(o1.getBest());
            int secondValue = Integer.valueOf(o2.getBest());

            if (firstValue > secondValue) {
                return -1;
            } else if (firstValue < secondValue) {
                return 1;
            } else /* if (firstValue == secondValue) */ {
                return 0;
            }
        }
    }

    /**
     * 베스트 오른차순 정렬
     */
    private final class ComparatorBestAsc implements Comparator<EquipManageDto> {
        @Override
        public int compare(EquipManageDto o1, EquipManageDto o2) {
            int firstValue = Integer.valueOf(o1.getBest());
            int secondValue = Integer.valueOf(o2.getBest());

            if (firstValue < secondValue) {
                return -1;
            } else if (firstValue > secondValue) {
                return 1;
            } else /* if (firstValue == secondValue) */ {
                return 0;
            }
        }
    }

    /**
     * 출시년월 내림차순 정렬
     */
    private final class ComparatorLchDesc implements Comparator<EquipManageDto> {
        @Override
        public int compare(EquipManageDto o1, EquipManageDto o2) {
            int firstValue = Integer.valueOf(o1.getLch());
            int secondValue = Integer.valueOf(o2.getLch());

            if (firstValue > secondValue) {
                return -1;
            } else if (firstValue < secondValue) {
                return 1;
            } else /* if (firstValue == secondValue) */ {
                return 0;
            }
        }
    }

    /**
     * 출시년월 오름차순 정렬
     */
    private final class ComparatorLchAsc implements Comparator<EquipManageDto> {
        @Override
        public int compare(EquipManageDto o1, EquipManageDto o2) {
            int firstValue = Integer.valueOf(o1.getLch());
            int secondValue = Integer.valueOf(o2.getLch());

            if (firstValue < secondValue) {
                return -1;
            } else if (firstValue > secondValue) {
                return 1;
            } else /* if (firstValue == secondValue) */ {
                return 0;
            }
        }
    }

    /**
     * @param HttpServletRequest
     * @return view(popup/appPopView)
     * 장비대여 설비 현황 > 장비 상세보기 팝업화면
     */
    @RequestMapping("/appPopView.do")
    public ModelAndView appPopView(HttpServletRequest request){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("popup/appPopView");

        /*검색용*/
        EquipManageDto searchDto = new EquipManageDto ();
        /*세션에서 사번취득 후 삽입*/
        String sM_MEMPNO = SESS_EMPNO;
        searchDto.setSM_MEMPNO(sM_MEMPNO);

        String gbcd = request.getParameter("gbcd");
        if (StringUtils.isEmpty(gbcd)) {
            mv.setViewName("/error/error");
            return mv;
        }
        searchDto.setGbcd(gbcd);

        String mdseq = request.getParameter("mdseq");
        if (StringUtils.isEmpty(mdseq)) {
            mv.setViewName("/error/error");
            return mv;
        }
        searchDto.setMdseq(mdseq);

        /*결과 반환용*/
        EquipManageDto equipDto = new EquipManageDto ();
        try {
            EquipManageDto result = new EquipManageDto ();

            /*장비정보취득*/
            searchDto.setGbcd(gbcd);
            equipDto.setGbcd(gbcd);
            result = equipManageService.getCodeInfo(searchDto);
            equipDto.setGbnm(result.getGbnm());

            /*모델기본정보취득*/
            result = equipManageService.getModelBasicInfo(searchDto);
            equipDto.setMdno(result.getMdno());
            equipDto.setMdnm(result.getMdnm());
            equipDto.setMdtxt(result.getMdtxt());
            equipDto.setLchdt(result.getLchdt());

            /*모델상세정보 취득*/
            equipDto.setItem(equipManageService.getModelSub(searchDto));

            /*모델 이미지 취득*/
            equipDto.setImageUrl(equipManageService.getImageUrl(searchDto));

            /*첨부파일 취득*/
            List<EquipManageDto> fileList = new ArrayList<EquipManageDto> ();
            /*첨부파일 검색시*/
            searchDto.setRefno(mdseq);
            searchDto.setFiletp("F");
            fileList = equipManageService.getAttachFileInfo(searchDto);

            mv.addObject("fileList", fileList);

            /*표준모델 등록 하위코드 가져오기*/
            searchDto.setCode(gbcd);
            Map<String, Object> subTreeMap = new LinkedHashMap<String, Object> ();
            subTreeMap = equipManageService.getSubTreeList(searchDto);
            mv.addObject("subTreeMap", subTreeMap);

            mv.addObject("equipDto", equipDto);
        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        return mv;
    }

    /**
     * @param HttpServletRequest
     * @return view(popup/appPopView)
     * 장비대여 설비 현황 > 장비 상세보기 팝업화면
     */
    @RequestMapping("/admin/confirmDoc.do")
    public ModelAndView confirmDoc(HttpServletRequest request, Model model){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("popup/confirmDoc");
        
        /*검색용*/
        EquipManageDto searchDto = new EquipManageDto ();

        try {

            String appno = request.getParameter("appno");
            if (StringUtils.isEmpty(appno)) {
                model.addAttribute("msg", "잘못된 접근입니다.");
                model.addAttribute("url", "close");
                mv.setViewName("error/errorAlert");
                return mv;
            }
            searchDto.setAppno(appno);

            /*결과 반환용*/
            EquipManageDto equipDto = new EquipManageDto ();
            equipDto = equipManageService.getAppTblInfo(searchDto);

            if(Integer.valueOf(equipDto.getStatus()) < 3 || !equipDto.getApproval().equals("2")) {
                model.addAttribute("msg", "승인후 접근가능합니다.");
                model.addAttribute("url", "close");
                mv.setViewName("error/errorAlert");
                return mv;
            }
            List<EquipManageDto> modelList = new ArrayList<EquipManageDto> ();
            modelList = equipManageService.getAmountForModel(searchDto);

            int totAmount = 0;
            for (EquipManageDto dto1 : modelList) {
                EquipManageDto modelInfo = equipManageService.getModelInfo(dto1).get(0);

                if (StringUtils.isNotEmpty(modelInfo.getGbcd())) {
                    EquipManageDto result = new EquipManageDto ();

                    /*장비정보취득*/
                    result = equipManageService.getCodeInfo(modelInfo);
                    if (StringUtils.isNotEmpty(result.getGbnm())) {
                        dto1.setGbnm(result.getGbnm());
                    }
                    dto1.setGbcd(modelInfo.getGbcd());
                    dto1.setMdnm(modelInfo.getMdnm());
                }

                searchDto.setMdseq(dto1.getMdseq());
                List<EquipManageDto> eqnmList = new ArrayList<EquipManageDto> ();
                eqnmList = equipManageService.getEqnm(searchDto);

                String[] elist = new String[eqnmList.size()];

                for (int i = 0; i < eqnmList.size(); i++) {
                    EquipManageDto dto2 = eqnmList.get(i);
                    elist[i] = dto2.getEqnm() + "(" + dto2.getEqalias() + ")";
                }

                String eqnm = "";
                eqnm = StringUtils.join(elist, ", ");
                dto1.setEqnm(eqnm);

                totAmount += Integer.valueOf(dto1.getAmount());
            }

            mv.addObject("appAmount", String.valueOf(modelList.size()) + " 종 " + String.valueOf(totAmount));

            Map<String, Object> configMap = Constants.getConfigOption();
            mv.addObject("appstArr", configMap.get("appstArr"));
            mv.addObject("approvalArr", configMap.get("approvalArr"));
            mv.addObject("banpArr", configMap.get("banpArr"));

            mv.addObject("appno", appno);
            mv.addObject("modelList", modelList);
            mv.addObject("view", equipDto);

        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        return mv;
    }

    /**
     * @param HttpServletRequest
     * @param Model
     * @return view(rent/equipRentRegist)
     * 장비대여 설비 현황 > 장비 상세보기 팝업화면
     */
    @RequestMapping("/equipRentRegist.do")
    public ModelAndView equipRentRegist(HttpServletRequest request, Model model){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("rent/equipRentRegist");

        /*검색용*/
        EquipManageDto searchDto = new EquipManageDto ();
        /*세션에서 사번취득 후 삽입*/
        String sM_MEMPNO = SESS_EMPNO;
        searchDto.setSM_MEMPNO(sM_MEMPNO);

        try {
            PowerstatusDto powerstatusDto = new PowerstatusDto ();
            powerstatusDto = powerstatusService.getDeptNameInfo(SESS_EMPNO);
            String deptName = powerstatusDto.getDept_name_1depth();
            //deptName += " " + powerstatusDto.getDept_name_2depth();
            mv.addObject("deptName", deptName);

            /*코드(대) 데이터를가져온다.*/
            List<EquipManageDto> codeList = new ArrayList<EquipManageDto> ();
            codeList = equipManageService.getCodeList(searchDto);
            mv.addObject("codeList", codeList);

            /*장바구니*/
            // TODO 수정必要
            String bskno = request.getParameter("bskno");//a,b,c,.... 이런형태로

            //일반신청
            String mdseq = request.getParameter("mdseq");
            String strdt = request.getParameter("strdt");
            mv.addObject("strdt", strdt);
            String enddt = request.getParameter("enddt");
            mv.addObject("enddt", enddt);
            String amount = request.getParameter("amount");

            /*1개월이상 1년미만 결재*/
            boolean isLine = false;
            boolean noLine = false;
            boolean isOverYear = false;
            boolean isTablet = false;

            Map<String, Object> listMap = new LinkedHashMap<String, Object> ();
            String listMapkey = "";
            String listMapkeyLast = "";
            List<EquipManageDto> listMapVal = new ArrayList<EquipManageDto> ();
            List<EquipManageDto> basketInfoList = new ArrayList<EquipManageDto> ();

            if( StringUtils.isNotEmpty(bskno) ) {
                String[] bsknoArr = null;
                bsknoArr = bskno.split(",");
                String bskNum = "";
                for (int i = 0; i < bsknoArr.length; i++) {
                    bskNum += "'" + bsknoArr[i] + "'";
                    if(i < bsknoArr.length-1) {
                        bskNum += ", ";
                    }
                }
                searchDto.setBskno(bskNum);
                mv.addObject("bsknoArr", bskno);

                /*대여가능 장비 리스트 취득*/
                basketInfoList = equipManageService.getBasketInfo(searchDto);

                if(basketInfoList.size() == 0) {
                    /*대여가능 장비 리스트 없음*/
                    model.addAttribute("msg", "잘못된 접근입니다.");
                    mv.setViewName("error/errorAlert");
                    return mv;
                }

                for(EquipManageDto basketInfo : basketInfoList) {
                    /*문자를 데이터형으로 변경*/
                    SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
                    String strDt = basketInfo.getStrdt().replace("-","").replace("/","").trim().substring(0, 8);
                    String endDt = basketInfo.getEnddt().replace("-","").replace("/","").trim().substring(0, 8);

                    Date strDate = df.parse(strDt);
                    Date endDate = df.parse(endDt);

                    if(strDate.compareTo(endDate) > 0) {
                        model.addAttribute("msg", "대여반납일이 올바르지 않습니다.");
                        mv.setViewName("error/errorAlert");
                        return mv;
                    } else if(basketInfo.getRegeno() != sM_MEMPNO) {
                        //TODO 테스트후 삭제
//                        model.addAttribute("msg", "잘못된 접근입니다.");
//                        mv.setViewName("error/errorAlert");
//                        return mv;
                    }

                    /*대여 가능 설비 정보*/
                    Map<String, Object> amountInfo = equipManageService.getEquipAmountInfo(basketInfo, SESS_EMPNO);
                    int myBasketCnt = (int) amountInfo.get("myBasketCnt");
                    int rentEnableCnt = (int) amountInfo.get("rentEnableCnt");
                    basketInfo.setRentEnableCnt(rentEnableCnt);

                    if(myBasketCnt > 0)                    {
                        rentEnableCnt += myBasketCnt;
                    }

                    if(rentEnableCnt == 0 || Integer.valueOf(basketInfo.getAmount()) >  rentEnableCnt) {
                        model.addAttribute("msg", "대여가능한 설비가 부족하거나 없습니다.");
                        mv.setViewName("error/errorAlert");
                        return mv;
                    }

                    int daysNum = DateUtil.getBetweenDates(strDt, endDt);
                    if(daysNum > 365)
                    {
                        isOverYear = true;
                    }
                    else if(daysNum >= 30 && daysNum <= 365)
                    {
                        isLine = true;
                    }
                    else
                    {
                        noLine = true;
                    }

                    EquipManageDto result = new EquipManageDto();
                    /*모델기본정보취득*/
                    result = equipManageService.getModelInfo(basketInfo).get(0);

                    if(result.equals(null)) {
                        model.addAttribute("msg", "모델 정보가 존재하지 않습니다.");
                        mv.setViewName("error/errorAlert");
                        return mv;
                    }
                    basketInfo.setMdno(result.getMdno());
                    basketInfo.setMdnm(result.getMdnm());
                    basketInfo.setMdtxt(result.getMdtxt());
                    basketInfo.setLchdt(result.getLchdt());

                    /*장비정보취득*/
                    basketInfo.setGbcd(result.getGbcd());
                    result = equipManageService.getCodeInfo(basketInfo);
                    basketInfo.setGbnm(result.getGbnm());
                    
                    /*타블렛 유무확인*/
                    if(result.getGbcd().equals("010")){
                        isTablet = true;
                    }

                    Map<String, Object> resultMap = new HashMap<String, Object> ();
                    resultMap = equipManageService.getModelByCode(basketInfo);
                    basketInfo.setModelByCodeList((Map<String, Object>) resultMap.get("modelByCodeMap"));

                    listMapkey = strDt.substring(0, 4) + "년 " + strDt.substring(4, 6) + "월 " + strDt.substring(6, 8) + "일 " + "~" + endDt.substring(0, 4) + "년 " + endDt.substring(4, 6) + "월 " + endDt.substring(6, 8) + "일";
                    if (listMapkeyLast.equals(listMapkey)) {
                        listMapVal.add(basketInfo);
                        listMapkeyLast = listMapkey;
                    } else {
                        listMapVal = new ArrayList<EquipManageDto> ();
                        listMapVal.add(basketInfo);
                        listMapkeyLast = listMapkey;
                    }
                    listMap.put(listMapkey, listMapVal);
                }

            } else if (StringUtils.isNotEmpty(mdseq)
                    && StringUtils.isNotEmpty(strdt)
                    && StringUtils.isNotEmpty(enddt)
                    && StringUtils.isNotEmpty(amount)) {

                /*문자를 데이터형으로 변경*/
                SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");

                String strDt = strdt.replace("-","").replace("/","").trim().substring(0, 8);
                String endDt = enddt.replace("-","").replace("/","").trim().substring(0, 8);
                Date strDate = df.parse(strDt);
                Date endDate = df.parse(endDt);

                /*모델 넘버*/
                String[] mdseqArr = mdseq.split(",");
                mv.addObject("mdseqArr", mdseqArr);

                /*모델 수량*/
                String[] amountArr = amount.split(",");
                mv.addObject("amountArr", amountArr);

                if (mdseqArr.length != amountArr.length) {
                    model.addAttribute("msg", "대여가능한 설비가 부족하거나 없습니다.");
                    mv.setViewName("error/errorAlert");
                    return mv;
                }

                for (int i = 0 ; i < mdseqArr.length; i++) {

                    EquipManageDto basketInfo = new EquipManageDto();

                    searchDto.setMdseq(mdseqArr[i]);
                    searchDto.setStrdt(strdt);
                    searchDto.setEnddt(enddt);
                    basketInfo.setMdseq(mdseqArr[i]);

                    Map<String, Object> amountInfo = equipManageService.getEquipAmountInfo(searchDto, SESS_EMPNO);
                    int rentEnableCnt = (int) amountInfo.get("rentEnableCnt");
                    basketInfo.setRentEnableCnt(rentEnableCnt);

                    if(rentEnableCnt == 0 || Integer.valueOf(amountArr[i]) >  rentEnableCnt) {
                        model.addAttribute("msg", "대여가능한 설비가 부족하거나 없습니다.");
                        mv.setViewName("error/errorAlert");
                        return mv;
                    }

                    EquipManageDto result = new EquipManageDto();
                    /*모델기본정보취득*/
                    result = equipManageService.getModelInfo(searchDto).get(0);
                    if(result.equals(null)) {
                        model.addAttribute("msg", "모델 정보가 존재하지 않습니다.");
                        mv.setViewName("error/errorAlert");
                        return mv;
                    }

                    basketInfo.setMdno(result.getMdno());
                    basketInfo.setMdnm(result.getMdnm());
                    basketInfo.setMdtxt(result.getMdtxt());
                    basketInfo.setLchdt(result.getLchdt());

                    /*장비정보취득*/
                    basketInfo.setGbcd(result.getGbcd());
                    result = equipManageService.getCodeInfo(basketInfo);
                    basketInfo.setGbnm(result.getGbnm());
                    basketInfo.setAmount(amountArr[i]);
                    
                    /*타블렛 유무확인*/
                    if(result.getGbcd().equals("010")){
                        isTablet = true;
                    }

                    Map<String, Object> resultMap = new HashMap<String, Object> ();
                    resultMap = equipManageService.getModelByCode(basketInfo);
                    basketInfo.setModelByCodeList((Map<String, Object>) resultMap.get("modelByCodeMap"));

                    /*대여 가능 설비 정보*/
                    basketInfo.setStrdt(strdt);
                    basketInfo.setEnddt(enddt);

                    int daysNum = DateUtil.getBetweenDates(strDt, endDt);
                    if(daysNum > 365)
                    {
                        isOverYear = true;
                    }
                    else if(daysNum >= 30 && daysNum <= 365)
                    {
                        isLine = true;
                    }
                    else
                    {
                        noLine = true;
                    }

                    /*basketInfoList.add(basketInfo);*/

                    listMapkey = strDt.substring(0, 4) + "년 " + strDt.substring(4, 6) + "월 " + strDt.substring(6, 8) + "일 " + "~" + endDt.substring(0, 4) + "년 " + endDt.substring(4, 6) + "월 " + endDt.substring(6, 8) + "일";
                    if (listMapkeyLast.equals(listMapkey)) {
                        listMapVal.add(basketInfo);
                        listMapkeyLast = listMapkey;
                    } else {
                        listMapVal = new ArrayList<EquipManageDto> ();
                        listMapVal.add(basketInfo);
                        listMapkeyLast = listMapkey;
                    }
                    listMap.put(listMapkey, listMapVal);
                }
            } else {
                model.addAttribute("msg", "잘못된 접근입니다.");
                mv.setViewName("error/errorAlert");
                return mv;
            }
            /*mv.addObject("basketInfoList", basketInfoList);*/
            mv.addObject("listMap", listMap);
            mv.addObject("isLine", isLine); 
            mv.addObject("isTablet", isTablet);

            if(isOverYear) {
                model.addAttribute("msg", "1년이상은 대여불가능 합니다.");
                mv.setViewName("error/errorAlert");
                return mv;
            } else if(isLine && noLine) {
                model.addAttribute("msg", "대여기간이 1개월이상 인경우 별도로 신청하셔야 합니다.");
                mv.setViewName("error/errorAlert");
                return mv;
            }

        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        return mv;
    }

    /**
     * @param HttpServletRequest
     * @param Model
     * @return error
     *
     */
    @RequestMapping("/admin/equipAllocation.do")
    public ModelAndView equipAllocation(HttpServletRequest request, Model model){
        ModelAndView mv = new ModelAndView();

        try {
            String appno = request.getParameter("appno");
            String mdseq = request.getParameter("mdseq");
            String euseq = request.getParameter("euseq");
            String amount = request.getParameter("amount");


            if(StringUtils.isEmpty(appno) || StringUtils.isEmpty(mdseq) || StringUtils.isEmpty(euseq))
            {
                model.addAttribute("msg", "잘못된 접근입니다.");
                model.addAttribute("url", "close");
                mv.setViewName("error/errorAlert");
                return mv;
            }

            EquipManageDto searchDto = new EquipManageDto ();
            EquipManageDto resultDto = new EquipManageDto ();
            List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();

            searchDto.setAppno(appno);
            resultDto = equipManageService.getEquipStatus(searchDto);

            if (!resultDto.getStatus().equals("4") && !resultDto.getStatus().equals("3") || !resultDto.getApproval().equals("2")){
                model.addAttribute("msg", "배정할수 없습니다.");
                model.addAttribute("url", "close");
                mv.setViewName("error/errorAlert");
                return mv;
            }
            searchDto.setStrdt(resultDto.getStrdt());
            searchDto.setEnddt(resultDto.getEnddt());

            searchDto.setMdseq(mdseq);
            resultDto = equipManageService.getEquipAmount(searchDto);
            
            String eqAmount = resultDto.getAmount();
            if (StringUtils.isEmpty(eqAmount) || Integer.valueOf(eqAmount) < 1 ){
                model.addAttribute("msg", "최소 신청수량이 한개 이상이어야 합니다.");
                model.addAttribute("url", "close");
                mv.setViewName("error/errorAlert");
                return mv;
            }
            
            Map<String, Object> listMap = new LinkedHashMap<String, Object> ();
            listMap = equipManageService.getEquipModelInfo(searchDto);

            resultList = equipManageService.getEquipInfo(searchDto);
            List<String> eqnoList = new ArrayList<String> ();
            List<String> chkedEqList = new ArrayList<String>();
            HashMap<String, Object> usrMap = new HashMap<String, Object>();
            
            for (EquipManageDto result : resultList) {
                eqnoList.add(result.getEqno());
                usrMap.put(result.getEqno(), result.getEuseq());
                if(euseq.equals(result.getEuseq())){
                	chkedEqList.add(result.getEqno());
                }
                if(mdseq.equals(result.getMdseq())){
                	if(euseq.equals(result.getEuseq()) && Integer.parseInt(eqAmount) > 1){
                		eqAmount = String.valueOf(Integer.parseInt(eqAmount) - 1);	
                	}
                }
            }

            mv.addObject("elist", eqnoList);
            mv.addObject("status", resultDto.getStatus());
            mv.addObject("appno", appno);
            mv.addObject("mdseq", mdseq);
            mv.addObject("euseq", euseq);
            mv.addObject("usrMap", usrMap);
            mv.addObject("eqAmount", eqAmount);
            mv.addObject("amount", amount);
            mv.addObject("list", listMap);

        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        mv.setViewName("/popup/equipAllocation");

        return mv;
    }


    /**
     * @param HttpServletRequest
     * @param Model
     * @return error
     *
     */
    @RequestMapping("/admin/equipAllocationTemp.do")
    public ModelAndView equipAllocationTemp(HttpServletRequest request, Model model){
        ModelAndView mv = new ModelAndView();

        try {
            String mdseq = request.getParameter("mdseq");
            String amount = request.getParameter("amount");
            String strdt = request.getParameter("strdt");
            String enddt = request.getParameter("enddt");
            String allocEquip = request.getParameter("allocEquip");
            String disableEq = request.getParameter("disableEq");
            String idx = request.getParameter("idx");


            if(StringUtils.isEmpty(mdseq) || StringUtils.isEmpty(amount)|| StringUtils.isEmpty(strdt) || StringUtils.isEmpty(enddt))
            {
                model.addAttribute("msg", "잘못된 접근입니다.");
                model.addAttribute("url", "close");
                mv.setViewName("error/errorAlert");
                return mv;
            }

            EquipManageDto searchDto = new EquipManageDto ();
            List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();

            searchDto.setStrdt(strdt.replace("-", ""));
            searchDto.setEnddt(enddt.replace("-", ""));
            searchDto.setMdseq(mdseq);
            Map<String, Object> listMap = new LinkedHashMap<String, Object> ();
            listMap = equipManageService.getEquipModelInfo(searchDto);
            
            resultList = equipManageService.getEquipInfo(searchDto);
            List<String> eqnoList = new ArrayList<String> ();
            
            for (EquipManageDto result : resultList) {
                eqnoList.add(result.getEqno());
            }
            
            String[] disableEqSplit = disableEq.split(",");
            ArrayList<String> disableEqArr = new ArrayList<String>(Arrays.asList(disableEqSplit));

            mv.addObject("mdseq", mdseq);
            mv.addObject("amount", amount);
            mv.addObject("list", listMap);
            mv.addObject("openerIdx", idx);
            mv.addObject("allocEquip", allocEquip);
            mv.addObject("disableEqArr", disableEqArr);
            mv.addObject("elist", eqnoList);

        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        mv.setViewName("/popup/equipAllocationTemp");

        return mv;
    }

    /**
     * @param HttpServletRequest
     * @param Model
     * @return error
     *
     */
    @RequestMapping("/admin/equipAllocationUpdate.do")
    public ModelAndView equipAllocationUpdate(HttpServletRequest request, Model model){
        ModelAndView mv = new ModelAndView();

        try {
            String appno = request.getParameter("appno");
            String mdseq = request.getParameter("mdseq");
            String euseq = request.getParameter("euseq");
            String amount = request.getParameter("amount");
            String[] eqno = request.getParameterValues("eqno[]");

            if(CommonUtil.isGetAdmin(request)){
                /* 테스트시에는 제외
                model.addAttribute("msg", 관리자만 접근가능 합니다.");
                model.addAttribute("url", "close");
                mv.setViewName("/error/errorAlert");
                return mv;*/
            }

            if(StringUtils.isEmpty(appno) || StringUtils.isEmpty(mdseq) || StringUtils.isEmpty(amount) || StringUtils.isEmpty(euseq))
            {
                model.addAttribute("msg", "잘못된 접근입니다.");
                model.addAttribute("url", "close");
                mv.setViewName("error/errorAlert");
                return mv;
            } else if(eqno.equals(null) || eqno.length == 0) {
                model.addAttribute("msg", "최소 한개이상 선택하셔야 합니다.");
                model.addAttribute("url", "close");
                mv.setViewName("error/errorAlert");
                return mv;
            } else if(eqno.length > Integer.valueOf(amount)) {
                model.addAttribute("msg", "배정 수량이 초과되었습니다.");
                model.addAttribute("url", "close");
                mv.setViewName("error/errorAlert");
                return mv;
            }

            EquipManageDto searchDto = new EquipManageDto ();
            EquipManageDto resultDto = new EquipManageDto ();
            List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();

            searchDto.setAppno(appno);
            resultDto = equipManageService.getEquipStatus(searchDto);

            searchDto.setStrdt(resultDto.getStrdt());
            searchDto.setEnddt(resultDto.getEnddt());
            searchDto.setMdseq(mdseq);
            searchDto.setEuseq(euseq);
            resultList = equipManageService.getEquipNo(searchDto);
            List<String> eqnoList = new ArrayList<String> (Arrays.asList(eqno));
            for (EquipManageDto result : resultList) {
                if (eqnoList.contains(result.getEqno())) {
                    model.addAttribute("msg", "이미 배정되어있는 설비가 존재합니다.");
                    model.addAttribute("url", "close");
                    mv.setViewName("error/errorAlert");
                    return mv;
                }
            }

            /*반출후 배정된설비를 수정할경우 설비대여상태를 변경해준다.*/

            if (resultDto.getStatus().equals("4")){

                resultDto = equipManageService.getAmount(searchDto);
                int amt = Integer.valueOf(resultDto.getAmount());
                if (amt != eqno.length) {
                    model.addAttribute("msg", "신청수량과 일치하지 않습니다.");
                    model.addAttribute("url", "close");
                    mv.setViewName("error/errorAlert");
                    return mv;
                }

                resultList = equipManageService.getEquipInfo(searchDto);
                List<String> existEqno = new ArrayList<String> ();
                List<String> existEqno2 = new ArrayList<String> ();
                for (EquipManageDto result : resultList) {
                    existEqno.add(result.getEqno());
                    existEqno2.add(result.getEqno());
                }

                List<String> eqnoList2 = new ArrayList<String> (Arrays.asList(eqno));

                existEqno.removeAll(eqnoList2);
                eqnoList.removeAll(existEqno2);

                String[] cancelArr = existEqno.toArray(new String[existEqno.size()]);
                String[] addArr = eqnoList.toArray(new String[eqnoList.size()]);

                EquipManageDto updateDto = new EquipManageDto ();

                updateDto.setEqlst("0");
                updateDto.setEqnoArr(cancelArr);
                equipManageService.updateEqlst(updateDto);

                updateDto.setEqlst("0");
                updateDto.setEqnoArr(addArr);
                equipManageService.updateEqlst(updateDto);

            }

            equipManageService.delRecEquip(searchDto);

            for (int i = 0; i < eqno.length; i++) {
                EquipManageDto insertDto = new EquipManageDto ();

                insertDto.setAppno(appno);
                insertDto.setMdseq(mdseq);
                insertDto.setEqno(eqno[i]);
                insertDto.setEuseq(euseq);
                equipManageService.insertAppEquip(insertDto);
                equipManageService.updateAppEquipUser(insertDto);
                
            }
        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
            return mv;
        }

        model.addAttribute("msg", "저장 되었습니다.");
        model.addAttribute("url", "opener");
        mv.setViewName("error/errorAlert");
        return mv;
    }

    /**
     * @param HttpServletRequest
     * @return ajax응답 json
     * 장비대여 설비 현황 > 장비신청
     */
    @RequestMapping("/equipRentUpdate.do")
    public ModelAndView equipRentUpdate(HttpServletRequest request, Model model){
        ModelAndView mv = new ModelAndView();
        HttpSession session = request.getSession();

        /*검색용*/
        EquipManageDto searchDto = new EquipManageDto ();
        /*세션에서 사번취득 후 삽입*/
        String sM_MEMPNO = SESS_EMPNO;
        searchDto.setSM_MEMPNO(sM_MEMPNO);

        try {

            String bskno = request.getParameter("bsknoArr");
            String appeno = request.getParameter("appeno");
            String appenm = request.getParameter("appenm");
            String gbnm = request.getParameter("gbnm");
            String mdnm = request.getParameter("mdnm");
            mdnm = mdnm.replaceAll("& #40;", "(");
            mdnm = mdnm.replaceAll("& #41;", ")");

            String[] appueno = request.getParameterValues("appueno");
            String[] appuenm = request.getParameterValues("appuenm");
            String[] deptno_arr = request.getParameterValues("deptno_arr");
            String[] dept_Nm1dept_arr = request.getParameterValues("dept_Nm1dept_arr");
            
            
            String appss = request.getParameter("appss");
            String apptel = request.getParameter("apptel");
            String appmail = request.getParameter("appmail");
            String useobj = request.getParameter("useobj");
            String rent_NB_Gubun = request.getParameter("rent_NB_Gubun");

            String[] strdt = request.getParameterValues("strdt[]");
            String[] enddt = request.getParameterValues("enddt[]");
            String[] mdseq = request.getParameterValues("mdseq[]");
            String[] amount = request.getParameterValues("amount[]");

            String[] mdseqClone = mdseq.clone();
            mdseqClone = new HashSet<String>(Arrays.asList(mdseqClone)).toArray(new String[0]);
            String[] amountClone = amount.clone();
            amountClone = new String[mdseqClone.length];

            for (int i = 0;  i < mdseqClone.length; i++) {
                int containCount = 0;
                for (int j = 0;  j < mdseq.length; j++) {
                    if (mdseq[j].equals(mdseqClone[i])) {
                        containCount++;
                    }
                }
                amountClone[i] = String.valueOf(containCount);
            }

            for  (int i = 0 ; i < strdt.length; i++) {
                strdt[i] = strdt[i].replaceAll("-", "").replaceAll("/", "");
                enddt[i] = enddt[i].replaceAll("-", "").replaceAll("/", "");
            }

            //결재
//            String sign1Empno = request.getParameter("sign1Empno");
//            String sign1Sosok = request.getParameter("sign1Sosok");
//            String sign1UserName = request.getParameter("sign1UserName");
//            String sign1PosName = request.getParameter("sign1PosName");
//
//            String sign2Empno = request.getParameter("sign2Empno");
//            String sign2Sosok = request.getParameter("sign2Sosok");
//            String sign2UserName = request.getParameter("sign2UserName");
//            String sign2PosName = request.getParameter("sign2PosName");

            if(strdt == null || enddt == null || mdseq == null || amount == null)
            {
                model.addAttribute("msg", "최소 한개이상 신청하셔야 합니다.");
                mv.setViewName("error/errorAlert");
                return mv;
            }

            Date today = new Date();
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            String ymd = df.format(today);
            Date todayYmd = sdf.parse(ymd);

            int appnoInt = equipManageService.getNextAppno();
            String appno = String.valueOf(appnoInt);

            /*이번해 취득*/
            SimpleDateFormat yyyy = new SimpleDateFormat("yyyy");
            String yearStr = yyyy.format(today);
            SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
            String regdt = yyyyMMddHHmmss.format(today);
            NumberFormat formatter = new DecimalFormat("00000000");
            String appnum = String.valueOf(yearStr + formatter.format(appnoInt));

            String insertKey = "";
            /*대여가능 체크*/
            for(int i = 0; i < mdseqClone.length; i ++)
            {
                Map<String, Object> map = new HashMap<String, Object> ();

                if( StringUtils.isEmpty(strdt[i]) || StringUtils.isEmpty(enddt[i]) || StringUtils.isEmpty(amountClone[i]) )
                {
                    model.addAttribute("msg", "항목을 빠짐없이 입력하세요.");
                    mv.setViewName("error/errorAlert");
                    return mv;
                }
                else if( todayYmd.compareTo(df.parse(enddt[i])) > 0 || df.parse(strdt[i]).compareTo(df.parse(enddt[i])) > 0 )
                {
                    model.addAttribute("msg", "대여기간이 올바르지 않습니다.");
                    mv.setViewName("error/errorAlert");
                    return mv;
                }

                //신청가능한 모델 체크
                searchDto.setMdseq(mdseqClone[i]);
                List<EquipManageDto> modelInfoList = new ArrayList<EquipManageDto>();
                modelInfoList = equipManageService.getModelInfo(searchDto);
                EquipManageDto modelInfo = new EquipManageDto ();
                modelInfo = modelInfoList.get(0);

                if(StringUtils.isEmpty(modelInfo.getMdseq()))
                {
                    model.addAttribute("msg", "신청할수 없는 모델입니다.");
                    mv.setViewName("error/errorAlert");
                    return mv;
                }

                searchDto.setStrdt(strdt[i]);
                searchDto.setEnddt(enddt[i]);

                Map<String, Object> amountInfo = new HashMap<String, Object> ();
                amountInfo = equipManageService.getEquipAmountInfo(searchDto, SESS_EMPNO);
                int myBasketCnt = (int) amountInfo.get("myBasketCnt");
                int rentEnableCnt = (int) amountInfo.get("rentEnableCnt");
                if(myBasketCnt > 0)
                {
                    rentEnableCnt += myBasketCnt;
                }
                if( rentEnableCnt == 0 || Integer.valueOf(amountClone[i]) > rentEnableCnt )
                {
                    model.addAttribute("msg", "대여가능한 설비가 부족하거나 없습니다.");
                    mv.setViewName("error/errorAlert");
                    return mv;
                }
            }

            for(int i = 0; i < mdseq.length; i ++) {
                String mkey = strdt[i] + enddt[i];

                if(!mkey.equals(insertKey)) {

                    insertKey = mkey;

                    EquipManageDto insertDto = new EquipManageDto ();

                    insertDto.setAppno(appno);
                    insertDto.setAppnum(appnum);
                    insertDto.setAppeno(appeno);
                    insertDto.setAppenm(appenm);
                    insertDto.setAppueno("");
                    insertDto.setAppuenm("");
                    insertDto.setAppss(appss);
                    insertDto.setApptel(apptel);
                    insertDto.setAppmail(appmail);
                    insertDto.setUseobj(useobj);
                    insertDto.setStrdt(strdt[i]);
                    insertDto.setEnddt(enddt[i]);
                    insertDto.setStatus("1");
                    insertDto.setApproval("1");
                    insertDto.setRegeno(SESS_EMPNO);
                    insertDto.setRegenm(SESS_USER_NAME);
                    insertDto.setRegdt(regdt);
                    insertDto.setRent_NB_Gubun(rent_NB_Gubun);

                    equipManageService.insertAppData(insertDto);
                }
                
                EquipManageDto insertMdDto = new EquipManageDto ();
                insertMdDto.setAppno(appno);
                insertMdDto.setMdseq(mdseq[i]);
                insertMdDto.setAmount(amount[i]);

                EquipManageDto appModelChk = equipManageService.getEquipAmount(insertMdDto);

                /*모델 배정*/
                if(appModelChk != null){
                    insertMdDto.setAmount(String.valueOf(Integer.parseInt(appModelChk.getAmount()) + 1));
                    equipManageService.updateAmount(insertMdDto);
                }else{
                    equipManageService.insertAppModel(insertMdDto);
                }

                /*신청한 각모델마다 신청수량만큼 설비 자동배정    20160414*/
//                if(StringUtils.isEmpty(sign2Empno)) {
                    List<EquipManageDto> resultDto = new ArrayList<EquipManageDto> ();
                    searchDto.setAppno(appno);
                    searchDto.setMdseq(mdseq[i]);
                    searchDto.setStrdt(strdt[i]);
                    searchDto.setEnddt(strdt[i]);
                    resultDto = equipManageService.getEquipNo(searchDto);

                    String[] assignedArr = new String[resultDto.size()];

                    for (int j = 0; j < resultDto.size(); j++) {
                        EquipManageDto dto = resultDto.get(j);
                        assignedArr[j] = dto.getEqno();
                    }

                    searchDto.setAssignedArr(assignedArr);
                    int amoutInt = Integer.valueOf(amount[i]);
                    String amt = String.valueOf(amoutInt + 1);
                    searchDto.setAmount(amt);

                    /*장비 배정*/
                    /*List<EquipManageDto> allocResult = new ArrayList<EquipManageDto> ();
                    allocResult = equipManageService.getNotInEquipNo(searchDto);

                    for (EquipManageDto dto : allocResult) {
                        insertMdDto.setEqno(dto.getEqno());
                        equipManageService.insertAppEquip(insertMdDto);
                    }*/
 
                    /*사용자 배정*/
                    if (appueno[i] != null) {
                        if(!appueno[i].isEmpty() && !appuenm[i].isEmpty()){
                            insertMdDto.setAppueno(appueno[i]);
                            insertMdDto.setAppuenm(appuenm[i]);
                            insertMdDto.setDeptno(deptno_arr[i]);
                            insertMdDto.setDEPT1NM(dept_Nm1dept_arr[i]);
                            equipManageService.insertEquipUser(insertMdDto);
                        }
                    }
//                }
            }
            
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;

        	int maxFileNo = rentService.getMaxFileNo();
            List<HashMap<String, Object>> fileInfoList = commonUtil.sendToServer(multipartRequest, maxFileNo);
            EquipManageDto equipFileDto = new EquipManageDto();
            for (int z = 0; z < fileInfoList.size(); z++) {
                HashMap<String, Object> fileInfoMap = fileInfoList.get(z);
                if (fileInfoMap != null) {
                	if("file_attach".equals(fileInfoMap.get("inputNm"))) {
                		String security_path = dir_path + "/"+ CommonUtil.getToday().subSequence(0, 4) + "/";
                		File dir1 = new File(security_path);

                        if (!dir1.exists()) {
                        	dir1.mkdirs();
                        }
                		equipFileDto.setRENT_SECURITY_orgFileName((String) fileInfoMap.get("userFileName"));
                        equipFileDto.setRENT_SECURITY_fileName((String) fileInfoMap.get("saveFileName"));
                        equipFileDto.setRENT_SECURITY_ext((String) fileInfoMap.get("fileExt"));
                        equipFileDto.setRENT_SECURITY_phycalPath(security_path + "/" + (String) fileInfoMap.get("saveFileName") + "." + fileInfoMap.get("fileExt"));
                        equipFileDto.setRENT_SECURITY_logicalPath("/rent/security/" + CommonUtil.getToday().subSequence(0, 4) + "/" + fileInfoMap.get("saveFileName") + "." + fileInfoMap.get("fileExt"));
                        equipFileDto.setAppno(appno);
                        equipFileDto.setRENT_SECURITY_userPK((String) request.getSession().getAttribute("SESS_EMPNO"));
                        equipManageService.insertFile(equipFileDto);
                	}
                }
            }

            /*장바구니 삭제*/
            if(bskno != null && StringUtils.isNotEmpty(bskno))
            {
            	String[] bsknoArr = null;
                bsknoArr = bskno.split(",");

                EquipManageDto delDto = new EquipManageDto ();
                
                for (int i = 0; i < bsknoArr.length; i++) {
                	if (StringUtils.isNotEmpty(bsknoArr[i])) {
                        delDto.setBskno(bsknoArr[i]);
                        equipManageService.delBskno(delDto);
                    }
                }
            }

            /*대여기간이 1개월이상 1년미만일 경우 결재선*/
            int daysNum = DateUtil.getBetweenDates(strdt[0], enddt[0]);
            if(daysNum >= 30 && daysNum <= 365) {

                Map<String,String> sessMap = (Map<String,String>) session.getAttribute("SESS_USER_INFO");
                //TODO 인사조직 테이블 변환에 맞춰 컬럼명 변경
                String deptName = sessMap.get("dept_name");
                String title = sessMap.get("title");

                EquipManageDto signData = new EquipManageDto ();
                signData.setAppno(appno);
                signData.setAppnum(appnum);
                signData.setStatus("1");
                signData.setEmpno(SESS_EMPNO);
                signData.setName(SESS_USER_NAME);
                signData.setDeptName(deptName);
                signData.setPosName(title);

                EquipManageDto mailData = new EquipManageDto ();
                mailData.setAppno(appno);

                equipManageService.signUp(signData);
                
                //model.addAttribute("msg", "대여기간이 1개월 이상일 경우 결재상신 후 승인 되어야 신청접수가 완료됩니다.");
                
                /*
                 *  LINKKEY생성규칙
                 *  1. FORMAT : LNKyyMMddXXXXXXXXX
                 *  2. (LNKyyMMdd)9자리 + (XXXXXXXXX)9자리 = 총 18자리
                 *  3. XX영역의 9자리는 APPNO를 채운 후 나머지 앞자리는 'N'으로 채운다.
                 *  4. 예) LNK170511NNNNN5480				 * 
                 */
                SimpleDateFormat yyMMdd = new SimpleDateFormat("yyMMdd");
                String linkkeyDate = yyMMdd.format(today);                
                String linkkey = "LNK" + linkkeyDate.toString() + StringUtil.format9line(appno);                
                String mikepUser = appss + " " + appenm;
                String mikepAmount = amount.length + " 대";
                String mikepPeriod = strdt[0].substring(0, 4) + "년 " + strdt[0].substring(4, 6) + "월 " + strdt[0].substring(6, 8) + "일 " + " ~ " + enddt[0].substring(0, 4) + "년 " + enddt[0].substring(4, 6) + "월 " + enddt[0].substring(6, 8) + "일";
                String mikepTitle = "업무용 장비 장기대여 신청";
                
                mv.addObject("mikep_title", mikepTitle);
                mv.addObject("mikep_purpose", useobj);
                mv.addObject("mikep_period", mikepPeriod);
                mv.addObject("mikep_amount", mikepAmount);
                mv.addObject("mikep_user", mikepUser);
                mv.addObject("mikep_linkkey", linkkey);
                mv.addObject("mikep_empno", appeno);
                mv.addObject("mikep_appno", appno);
                mv.setViewName("/rent/processMikep");
                return mv;
            }
            else
            {
                log.debug("=================================SENDMAIL AMDIN START==============================");
                Address[] toAddrs = null;
                List<Map<String, String>> result = equipManageService.getAdminUserMail();
                if (result != null)
                    toAddrs = new Address[result.size()];

                int cnt = 0;
                for (Map<String, String> adminInfo : result) {
                    String empno = adminInfo.get("empno");
                    InternetAddress address = new InternetAddress(empno + "@kepco.co.kr");
                    toAddrs[cnt] = address;
                    cnt++;
                }
                SendMail mail = SendMail.getInstance();
                
                SimpleDateFormat sdfm = new SimpleDateFormat("yyyy-MM-dd");
                String strDate = sdfm.format(df.parse(searchDto.getStrdt()));
                String endDate = sdfm.format(df.parse(searchDto.getEnddt()));
                
                String mailSubject = "[멀티미디어 설비대여 신청 알림] " + gbnm + " " + mdnm +" (" + strDate + " ~ " + endDate + ")";
                // sendMail (Address[] toAddrs, String appno, String mode, String status, String mailSubject)
                mail.sendMail(toAddrs, appno, "toadmin", "" , mailSubject);
                log.debug("=================================SENDMAIL ADMIN FINISH==============================");

                model.addAttribute("msg", "신청완료 되었습니다.");
                model.addAttribute("url", "/equipRentList.do");
                mv.setViewName("error/errorAlert");
                return mv;
            }

        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        return mv;
    }

    /**
     * @param HttpServletRequest
     * @return ajax응답 json
     * 장비대여 설비 현황 > 장바구니 담기
     */
    @RequestMapping("/basketUpdate.do")
    @ResponseBody
    public void basketUpdate(HttpServletRequest request, HttpServletResponse response) throws Exception{

        try{
            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();

            String mode = request.getParameter("mode");

            if(StringUtil.isEmpty(mode))
            {
                out.print("error");
            }


            String mdseq = request.getParameter("mdseq");
            String strdt = request.getParameter("strdt");
            String enddt = request.getParameter("enddt");
            String amount = request.getParameter("amount");

            if(StringUtils.isEmpty(mdseq) || StringUtils.isEmpty(strdt) || StringUtils.isEmpty(enddt) || StringUtils.isEmpty(amount) )
            {
                out.print("error1");
            }

            String[] expMdseq = mdseq.split(",");
            String[] expAmount = amount.split(",");
            if( expMdseq.length != expAmount.length )
            {
                out.print("error2");
            }

            for (int i = 0; i < expMdseq.length; i++) {
                EquipManageDto searchDto = new EquipManageDto();
                searchDto.setMdseq(expMdseq[i]);
                searchDto.setStrdt(strdt);
                searchDto.setEnddt(enddt);
                /*대여 가능 설비 정보*/
                Map<String, Object> amountInfo = equipManageService.getEquipAmountInfo(searchDto, SESS_EMPNO);

                int rentEnableCnt = (int)amountInfo.get("rentEnableCnt");
                if (Integer.valueOf(expAmount[i]) > rentEnableCnt) {
                    out.print("error3");
                }

                int bskno = equipManageService.getNextBskno();

                EquipManageDto insertDto = new EquipManageDto();
                insertDto.setBskno(String.valueOf(bskno));
                insertDto.setMdseq(expMdseq[i]);
                insertDto.setAmount(expAmount[i]);
                insertDto.setStrdt(strdt.replace("-", ""));
                insertDto.setEnddt(enddt.replace("-", ""));
                insertDto.setRegeno(SESS_EMPNO);
                Date today = new Date();
                SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
                String regdt = yyyyMMddHHmmss.format(today);
                insertDto.setRegdt(regdt);
                equipManageService.insertBasketInfo(insertDto);
            }

            out.print("success");

        } catch (Exception e){
            e.printStackTrace();
        }
    }

    /**
     * @param HttpServletRequest
     * @return view(rent/admin/equipRentStatus)
     * 장비대여 관리메뉴 > 대여현황
     */
    @RequestMapping("/admin/equipRentStatus.do")
    public ModelAndView equipRentStatus(HttpServletRequest request) throws Exception{
        ModelAndView mv = new ModelAndView();
        List<RentDto> codeList = null;
        List<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
        String setDate = request.getParameter("setDate") == null ? CommonUtil.getToday() : request.getParameter("setDate").replace("-", "").trim().substring(0, 8);
        int totalCnt = 0;
        int totalSumCnt = 0;

        /*설비수량*/
        int equipAllTot = 0; //총보유량 합
        int equipRentTot = 0; //대여수 합
        int equipEnableTot = 0; //대여가능수 합

        HashMap<String, Object> rentAllMap = null;
        HashMap<String, Object> rentMap = null;
        HashMap<String, Object> enableMap = null;

        HashMap<String, Object> usingEqMap = null;  //대여중
        HashMap<String, Object> planOutMap = null;  //반출(예정)
        HashMap<String, Object> returnMap = null;  //반납(예정)
        HashMap<String, Object> missingMap = null;  //미반납
        HashMap<String, String> mInsuBanpStatMap = null; //월간 반출, 반납 각각 합계

        try {

            RentDto rentDto = new RentDto();

            /*대분류 코드 가져오기*/
            codeList = rentService.codeList(rentDto);
            for ( int j = 0 ; j < codeList.size() ; j++ ){
                rentDto.setGBCD(codeList.get(j).getGBCD());
                int resultCnt = rentService.getEquipCnt(rentDto);
                codeList.get(j).setTotalCnt(resultCnt);
                totalSumCnt = totalSumCnt + resultCnt;
            }

            /*도표1 시작*/
            /*장비 총 보유량 리스트*/
            rentDto.setSTATMODE(null);
            List<RentDto> equipAllTotList = rentService.equipRentStatusNo1(rentDto);
            rentAllMap = new HashMap<String, Object>();
            for ( int i = 0 ; i < equipAllTotList.size() ; i++ ) {
                int amount = equipAllTotList.get(i).getAMOUNT() > 0 ? equipAllTotList.get(i).getAMOUNT() : 0;
                rentAllMap.put(equipAllTotList.get(i).getGBCD(), amount);
                equipAllTot += amount;
            }

            /*장비 대여중인 수량 리스트*/
            rentDto.setSTATMODE("rent");
            List<RentDto> equipRentTotList = rentService.equipRentStatusNo1(rentDto);
            rentMap = new HashMap<String, Object>();
            for ( int i = 0 ; i < equipRentTotList.size() ; i++ ) {
                int amount = equipRentTotList.get(i).getAMOUNT() > 0 ? equipRentTotList.get(i).getAMOUNT() : 0;
                rentMap.put(equipRentTotList.get(i).getGBCD(), amount);
                equipRentTot += amount;
            }

            /*장비 대여가능수량 리스트*/
            rentDto.setSTATMODE("enable");
            List<RentDto> equipEnableTotList = rentService.equipRentStatusNo1(rentDto);
            enableMap = new HashMap<String, Object>();
            for ( int i = 0 ; i < equipEnableTotList.size() ; i++ ) {
                int amount = equipEnableTotList.get(i).getAMOUNT() > 0 ? equipEnableTotList.get(i).getAMOUNT() : 0;
                enableMap.put(equipEnableTotList.get(i).getGBCD(), amount);
                equipEnableTot += amount;
            }
            /*도표1 끝*/

            /*도표2 시작*/
            /*사용(대여중)*/
            rentDto.setSTATMODE("usingEq");
            rentDto.setSETDATE(setDate);
            List<RentDto> usingEqList = rentService.equipRentStatusNo2(rentDto);
            usingEqMap = new HashMap<String, Object>();
            for ( int i = 0 ; i < usingEqList.size() ; i++ ) {
                int amount = usingEqList.get(i).getAMOUNT() > 0 ? usingEqList.get(i).getAMOUNT() : 0;
                usingEqMap.put(usingEqList.get(i).getGBCD(), amount);
            }

            /*반출(예정)*/
            rentDto.setSTATMODE("planOut");
            rentDto.setSETDATE(setDate);
            List<RentDto> planOutList = rentService.equipRentStatusNo2(rentDto);
            planOutMap = new HashMap<String, Object>();
            for ( int i = 0 ; i < planOutList.size() ; i++ ) {
                int amount = planOutList.get(i).getAMOUNT() > 0 ? planOutList.get(i).getAMOUNT() : 0;
                planOutMap.put(planOutList.get(i).getGBCD(), amount);
            }

            /*반납(예정)*/
            rentDto.setSTATMODE("return");
            rentDto.setSETDATE(setDate);
            List<RentDto> returnList = rentService.equipRentStatusNo2(rentDto);
            returnMap = new HashMap<String, Object>();
            for ( int i = 0 ; i < returnList.size() ; i++ ) {
                int amount = returnList.get(i).getAMOUNT() > 0 ? returnList.get(i).getAMOUNT() : 0;
                returnMap.put(returnList.get(i).getGBCD(), amount);
            }

            /*미반납*/
            rentDto.setSTATMODE("missing");
            rentDto.setSETDATE(setDate);
            List<RentDto> missingList = rentService.equipRentStatusNo2(rentDto);
            missingMap = new HashMap<String, Object>();
            for ( int i = 0 ; i < missingList.size() ; i++ ) {
                int amount = missingList.get(i).getAMOUNT() > 0 ? missingList.get(i).getAMOUNT() : 0;
                missingMap.put(missingList.get(i).getGBCD(), amount);
            }


            /*도표2 끝*/


            /*월간 반납 반출 총 합계*/
			 HashMap<String, String> mInsuBanpStatParamMap = new HashMap<String, String>();
			 
			 mInsuBanpStatParamMap.put("insu_date", rentDto.getSETDATE().substring(0, 6));
			 mInsuBanpStatParamMap.put("banp_date", rentDto.getSETDATE().substring(0, 4) + "-" + rentDto.getSETDATE().substring(4, 6));

			 mInsuBanpStatMap = rentService.getMInsuBanpStat(mInsuBanpStatParamMap);
        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }


        mv.addObject("rentAllMap", rentAllMap);
        mv.addObject("rentMap", rentMap);
        mv.addObject("enableMap", enableMap);

        mv.addObject("usingEqMap", usingEqMap);
        mv.addObject("planOutMap", planOutMap);
        mv.addObject("returnMap", returnMap);
        mv.addObject("missingMap", missingMap);
        mv.addObject("mInsuBanpStatMap", mInsuBanpStatMap);

        mv.addObject("equipAllTot", equipAllTot);
        mv.addObject("equipRentTot", equipRentTot);
        mv.addObject("equipEnableTot", equipEnableTot);

        mv.addObject("codeList", codeList);
        mv.addObject("setDate", setDate.substring(0, 4)+"-"+setDate.substring(4, 6)+"-"+setDate.substring(6, 8));
        mv.setViewName("rent/admin/equipRentStatus");
        return mv;
    }

    /**
     * @param HttpServletRequest
     * @return view(rent/admin/monthlyRentStatus)
     * 장비대여 관리메뉴 > 대여현황   > 월간장비대여현황
     */
    @RequestMapping("/admin/monthlyRentStatus.do")
    public ModelAndView monthlyRentStatus(HttpServletRequest request) throws Exception{
        ModelAndView mv = new ModelAndView();
        List<RentDto> codeList = null;
        List<RentDto> modelList = null;
        List<RentDto> elementList = null;
        List<RentDto> dataList = null;
        /*List<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();*/
        List<String> list = new ArrayList<String>();
        String gbcd = request.getParameter("gbcd") == null ? "001" : request.getParameter("gbcd");
        String mdseq = request.getParameter("mdseq");
        String today = DateUtil.getToday();
        String year = request.getParameter("sch_year") == null ? today.substring(0, 4) : request.getParameter("sch_year");
        String month = request.getParameter("sch_month") == null ? today.substring(4, 6) : request.getParameter("sch_month");
        int totalCnt = 0;

        

        try {

            RentDto rentDto = new RentDto();

            /*대분류 코드 가져오기*/
            codeList = rentService.codeList(rentDto);

            /*모델리스트 가져오기 (셀렉트박스)*/
            rentDto.setGBCD(gbcd);
            modelList = rentService.getModelList(rentDto);



            /*장비명*/
            if(!StringUtils.isEmpty(mdseq)){
                rentDto.setMDSEQ(Integer.parseInt(mdseq));
            }
            elementList = rentService.monthlyRentStatusElement(rentDto);

            /*for( int i = 0 ; i < elementList.size() ; i++ ){

                HashMap<String, Object> map = new HashMap<String, Object>();

                map.put("eqno", elementList.get(i).getEQNO());
                map.put("eqnm", elementList.get(i).getEQNM());
                map.put("eqmst", elementList.get(i).getEQMST());

            }*/


        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        mv.addObject("sch_year", year);
        mv.addObject("sch_month", month);
        mv.addObject("gbcd", gbcd);
        mv.addObject("codeList", codeList);
        mv.addObject("modelList", modelList);
        mv.addObject("elementList", elementList);
        mv.setViewName("rent/admin/monthlyRentStatus");
        return mv;
    }


    /*장비대여 > 관리메뉴 > 장비현황 > 장비등록*/
    @ResponseBody
    @RequestMapping("/admin/getStatDataInfo.do")
    public void getStatDataInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{

        Boolean retVal = false;
        List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

        String gbcd = request.getParameter("gbcd") == null ? "001" : request.getParameter("gbcd");
        String mdseq = request.getParameter("mdseq");
        String year = request.getParameter("sch_year");
        String month = request.getParameter("sch_month");
        List<HashMap<String, Object>> eleList = new ArrayList<HashMap<String, Object>>();
        RentDto rentDto = new RentDto();
        List<RentDto> elementList = null;
        List<RentDto> dataList = null;
        List dayData = null;
        List value = null;
        HashMap<String, Object> data = null;


            try {

                rentDto.setGBCD(gbcd);
                /*장비명*/
                if(!StringUtils.isEmpty(mdseq) && !mdseq.equals("9999")){
                    rentDto.setMDSEQ(Integer.parseInt(mdseq));
                }
                elementList = rentService.monthlyRentStatusElement(rentDto);

                for( int i = 0 ; i < elementList.size() ; i++ ){

                    HashMap<String, Object> map = new HashMap<String, Object>();

                    map.put("eqno", elementList.get(i).getEQNO());
                    map.put("eqnm", elementList.get(i).getEQNM());
                    map.put("eqmst", elementList.get(i).getEQMST());

                    eleList.add(map);

                }


                rentDto.setSETDATE(year + month);
                dataList = rentService.monthlyRentStatusData(rentDto);

                data = new HashMap<String, Object>();

                for ( int j = 0 ; j < dataList.size(); j++ ){

                    SimpleDateFormat format = new SimpleDateFormat("yyyyMM");

                    Date day = format.parse((String) dataList.get(j).getENDDT().subSequence(0, 6));
                    Date day2 = format.parse(year+month);
                    int compare = day.compareTo(day2);

                    // 장비가 실제 사용중일시 직원정보를 표시항
                    if(compare == 1 || compare == 0){

                        String member = "<div style='cursor:pointer;' onclick='window.open(\"/admin/recView.do?appno="+dataList.get(j).getAPPNO()+"\", \"_blank\")'>"+
                                        "<p style='color:blue'>" + dataList.get(j).getAPPENM()+"</p>"
                                        + "<p>"+"["+dataList.get(j).getAPPSS()+"]"+"</p>"
                                        + "<p style='color:#ff6666'>" + dataList.get(j).getSTRDT().substring(0, 4) + "." + dataList.get(j).getSTRDT().substring(4, 6) + "." + dataList.get(j).getSTRDT().substring(6, 8)
                                        + " ~ " + dataList.get(j).getENDDT().substring(0, 4) + "." + dataList.get(j).getENDDT().substring(4, 6) + "." + dataList.get(j).getENDDT().substring(6, 8) + "</p></div>" ;

                        data.put(dataList.get(j).getEQNO(), member);
                    }

                }


                String endDay = DateUtil.getLastDayAfterMonth(year + month + "01", 0).substring(6, 8);

                dayData = new ArrayList();
                /*한달을 돌면서 데이터를 체크*/
                for ( int j = 1 ; j <= Integer.parseInt(endDay) ; j++ ){

                    value = new ArrayList();
                    // 리스트를 돌면서 EQNO 데이터의 유무에 다라 구분
                    for ( int i = 0 ; i < elementList.size() ; i++ ){

                        String setEqno = elementList.get(i).getEQNO();
                        String getData = (String) data.get(setEqno);
                        
                        if(!StringUtil.isEmpty(getData)){
                            value.add(getData);

                        }else{
                            value.add("");
                        }

                    }

                    dayData.add(value);
                }

                retVal = true;


            } catch (Exception e) {
                // TODO: handle exception
                e.printStackTrace();
                retVal = false;
            } finally {

                if(retVal != false){

                    JSONObject json = new JSONObject();
                    json.put("eleList", eleList);
                    json.put("dayData", dayData);

                    response.setContentType("text/html;charset=utf-8");
                    PrintWriter out = response.getWriter();
                    out.print(json.toString());

                }else{

                    response.setContentType("text/html;charset=utf-8");
                    PrintWriter out = response.getWriter();
                    out.print("error");

                }

            }

    }



    /**
     * @param HttpServletRequest
     * @return view(rent/admin/recList)
     * 장비대여 관리메뉴 > 접수현황
     */
    @RequestMapping("/admin/recList.do")
    public ModelAndView recList(RentDto rentDto, HttpServletRequest request) throws Exception{
        ModelAndView mv = new ModelAndView();
        String gbcd = request.getParameter("gbcd") == null ? "all" : request.getParameter("gbcd");
        String sch_strdt = request.getParameter("sch_strdt");
        String sch_enddt = request.getParameter("sch_enddt");
        String sch_status = request.getParameter("sch_status");
        String sch_approval = request.getParameter("sch_approval");
        String sch_return = request.getParameter("sch_return");
        String sch_text = request.getParameter("sch_text");
        String sch_text2 = request.getParameter("sch_text2");
        String rfid_empno = request.getParameter("rfid_empno");


        ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
        /*List<RentDto> codeList = null;*/
        List<HashMap<String, Object>> codeList = new ArrayList<>();
        List<RentDto> recList = null;
        int totalCnt = 0;
        int totalSumCnt = 0;

        try {

            /*검색용*/
            EquipManageDto searchDto = new EquipManageDto ();
            /*세션에서 사번취득 후 삽입*/
            String sM_MEMPNO = SESS_EMPNO;
            searchDto.setSM_MEMPNO(sM_MEMPNO);

            rentDto.setSch_strdt(null);
            rentDto.setSch_enddt(null);
            rentDto.setSch_status(null);
            rentDto.setSch_approval(null);
            rentDto.setSch_return(null);
            rentDto.setSch_text(null);


            if(!StringUtils.isEmpty(sch_strdt) && sch_strdt != null){
                rentDto.setSch_strdt(sch_strdt);
            }
            if(!StringUtils.isEmpty(sch_enddt) && sch_enddt != null){
                rentDto.setSch_enddt(sch_enddt);
            }
            if(!StringUtils.isEmpty(sch_status) && sch_status != null){
                rentDto.setSch_status(sch_status);
            }
            if(!StringUtils.isEmpty(sch_approval) && sch_approval != null){
                rentDto.setSch_approval(sch_approval);
            }
            if(!StringUtils.isEmpty(sch_return) && sch_return != null){
                rentDto.setSch_return(sch_return);
            }
            if(!StringUtils.isEmpty(sch_text) && sch_text != null){
                rentDto.setSch_text(sch_text);
            }
            if(!StringUtils.isEmpty(sch_text2) && sch_text2 != null){
            	rentDto.setSch_text2(sch_text2);
            }

            /*대분류 코드 가져오기*/
            /*codeList = rentService.codeList(rentDto);
            for ( int j = 0 ; j < codeList.size() ; j++ ){
                rentDto.setGBCD(codeList.get(j).getGBCD());
                int resultCnt = rentService.getRecListCnt(rentDto);
                codeList.get(j).setTotalCnt(resultCnt);
                totalSumCnt = totalSumCnt + resultCnt;
            }*/
            codeList = rentService.getRentListCnt(rentDto);

            rentDto.setGBCD(gbcd);
            rentDto.setPerPageCnt(15);

            recList = rentService.recList(rentDto);
            totalCnt = rentService.getRecListCnt(rentDto);

            for ( int i = 0 ; i < recList.size() ; i++ ){

                HashMap<String, Object> map = new HashMap<String, Object>();

                map.put("gbnm", recList.get(i).getGBNM());
                map.put("amount", recList.get(i).getAMOUNT());
                map.put("appno", recList.get(i).getAPPNO());
                map.put("appnum", recList.get(i).getAPPNUM());


                String enddt = recList.get(i).getENDDT();
                String strdt = recList.get(i).getSTRDT();
                String today = CommonUtil.getToday();
                String banpdt = recList.get(i).getBANPDT();


                long betWeenTime = (CommonUtil.strToDate(today).getTime() - CommonUtil.strToDate(enddt).getTime());
                int remain = (int) (betWeenTime / (1000*60*60*24));

                String status = recList.get(i).getSTATUS();
                String approval = recList.get(i).getAPPROVAL();
                String tomorrow = CommonUtil.getAddDate(today, 1);

                if( status.equals("4") && CommonUtil.strToDate(enddt).getTime() < CommonUtil.strToDate(today).getTime() ){
                    /*미반납*/
                    map.put("rec_class", "bg_02");
                }else if( (status.equals("3") && approval.equals("1"))
                        || (status.equals("3") && approval.equals("2") && strdt.equals(today))
                        || (status.equals("4"))
                        || (status.equals("4") && remain > -3) || (status.equals("6") && !StringUtils.isEmpty(banpdt)) ){
                    /*승인전, 대여예정, 사용중, 반납예정(3일), 반납건*/
                    map.put("rec_class", "bg_01");
                }else if( (status.equals("3") && approval.equals("2") && tomorrow.equals(strdt)) ){
                    /*익일대여예정*/
                    map.put("rec_class", "bg_03");
                }

                if(remain >= 0){
                    map.put("remain", "");
                }else{
                    map.put("remain", Math.abs(remain));
                }

                map.put("status", status);
                map.put("statusStr", RentController.statusStr(status, approval));
                map.put("approval", approval);
                map.put("appenm", recList.get(i).getAPPENM());
                map.put("appuenm", recList.get(i).getAPPUENM());
                map.put("strdt", strdt);
                map.put("enddt", enddt);
                map.put("regdt", recList.get(i).getREGDT());
                map.put("banpdt", banpdt);
                
                // 미리보기
                String phtml = "";
                
                phtml += "<div class='basic-list2' style='margin-top:5px; width:500px;'>";
                phtml += "<table style='width: 500px;'>";
                phtml += "<thead>";
                phtml += "<tr>";
                phtml += "<th style='padding: 3px; 0'>구분</th>";
                phtml += "<th style='padding: 3px; 0'>모델명</th>";
                phtml += "<th style='padding: 3px; 0'>배정(별칭)</th>";
                phtml += "</tr>";
                phtml += "</thead>";
                phtml += "<tbody>";
                
                
                
                String[] gbnm_arr = recList.get(i).getGBNM().split(",");
                String[] mdnm_arr = recList.get(i).getMDNM().split(",");
                Integer[] mdseq_arr = ArrayUtils.toObject((int[])new IntegerArrayConverter().convert(null, recList.get(i).getMDSEQ_GRP().split(","))); 
                rentDto.setAPPNO(recList.get(i).getAPPNO());
                rentDto.setEQNO(recList.get(i).getEQNO());
                System.out.println("11111111111111111111111111111111111111111111 eqno : " + recList.get(i).getEQNO());
                rentDto.setMDSEQ_ARR(mdseq_arr);
                
                for( int k = 0; k < mdseq_arr.length ; k++ ){
                	
                	String eList = "";
                	
                    List<RentDto> recListPreview = rentService.recListPreview(rentDto);
                    for( int j = 0 ; j < recListPreview.size() ; j++ ){
                    	if(mdseq_arr[k].equals(recListPreview.get(j).getMDSEQ())){
                    		
                        	eList += recListPreview.get(j).getEQNM(); 
                        	
                        	if(recListPreview.get(j).getEQALIAS() != null){
                        		eList += "(" +recListPreview.get(j).getEQALIAS()+ ")";
                        	}
                        	
                        	if(j != recListPreview.size()){
                        		eList += "<br>";
                        	}
                    		
                    	}
                    }
                    
                    phtml += "<tr>";
                    phtml += "<td style='padding: 0 0'>"+gbnm_arr[k]+"</td>";
                    phtml += "<td style='padding: 0 0'>"+mdnm_arr[k]+"</td>";
                    phtml += "<td style='padding: 0 0'>"+eList+"</td>";
                    phtml += "</tr>";
                	
                }
                
                phtml += "</tbody>";
                phtml += "</table>";
                phtml += "</div>";
                
                System.out.println("phtml: " + phtml);
                
                map.put("preview", phtml);
                list.add(map);
            }


        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }


        try {
            mv.setViewName("rent/admin/recList");
        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        mv.addObject("gbcd", gbcd);
        mv.addObject("codeList", codeList);
        mv.addObject("recList", list);
        mv.addObject("paging", rentDto);
        mv.addObject("totalCnt", totalCnt);
        mv.addObject("totalSumCnt", totalSumCnt);
        mv.addObject("config", Constants.getConfigOption());
        mv.addObject("sch_strdt", sch_strdt);
        mv.addObject("sch_enddt", sch_enddt);
        mv.addObject("sch_status", sch_status);
        mv.addObject("sch_approval", sch_approval);
        mv.addObject("sch_text", sch_text);
        mv.addObject("sch_text2", sch_text2);
        mv.addObject("sch_return", sch_return);
        mv.addObject("rfid_empno", rfid_empno);



        return mv;
    }


    /**
     * @param HttpServletRequest
     * @return view(rent/admin/todayRecList)
     * 장비대여 관리메뉴 > 금일접수현황
     */
    @RequestMapping("/admin/todayRecList.do")
    public ModelAndView todayRecList(RentDto rentDto, HttpServletRequest request) throws Exception{
        ModelAndView mv = new ModelAndView();
        String gbcd = request.getParameter("gbcd") == null ? "all" : request.getParameter("gbcd");
        String sch_status = request.getParameter("sch_status");
        String sch_approval = request.getParameter("sch_approval");
        String sch_return = request.getParameter("sch_return");
        String sch_text = request.getParameter("sch_text");


        ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
        List<RentDto> codeList = null;
        List<RentDto> todayRecList = null;
        int totalCnt = 0;
        int totalSumCnt = 0;

        try {

            /*검색용*/
            EquipManageDto searchDto = new EquipManageDto ();
            /*세션에서 사번취득 후 삽입*/
            String sM_MEMPNO = SESS_EMPNO;
            searchDto.setSM_MEMPNO(sM_MEMPNO);

            /*결과 반환용*/
            EquipManageDto equipDto = new EquipManageDto ();

            rentDto.setSch_status(null);
            rentDto.setSch_approval(null);
            rentDto.setSch_return(null);
            rentDto.setSch_text(null);

            if(!StringUtils.isEmpty(sch_status) && sch_status != null){
                rentDto.setSch_status(sch_status);
            }
            if(!StringUtils.isEmpty(sch_approval) && sch_approval != null){
                rentDto.setSch_approval(sch_approval);
            }
            if(!StringUtils.isEmpty(sch_return) && sch_return != null){
                rentDto.setSch_return(sch_return);
            }
            if(!StringUtils.isEmpty(sch_text) && sch_text != null){
                rentDto.setSch_text(sch_text);
            }

            rentDto.setTodayRecCode("on");

            /*대분류 코드 가져오기*/
            codeList = rentService.codeList(rentDto);
            for ( int j = 0 ; j < codeList.size() ; j++ ){
                rentDto.setGBCD(codeList.get(j).getGBCD());
                int resultCnt = rentService.getRecListCnt(rentDto);
                codeList.get(j).setTotalCnt(resultCnt);
                totalSumCnt = totalSumCnt + resultCnt;
            }

            rentDto.setGBCD(gbcd);
            rentDto.setPerPageCnt(15);

            todayRecList = rentService.recList(rentDto);
            totalCnt = rentService.getRecListCnt(rentDto);

            for ( int i = 0 ; i < todayRecList.size() ; i++ ){

                HashMap<String, Object> map = new HashMap<String, Object>();

                map.put("gbnm", todayRecList.get(i).getGBNM());
                map.put("amount", todayRecList.get(i).getAMOUNT());
                map.put("appno", todayRecList.get(i).getAPPNO());
                map.put("appnum", todayRecList.get(i).getAPPNUM());


                String enddt = todayRecList.get(i).getENDDT();
                String strdt = todayRecList.get(i).getSTRDT();
                String today = CommonUtil.getToday();
                String banpdt = todayRecList.get(i).getBANPDT();


                long betWeenTime = (CommonUtil.strToDate(today).getTime() - CommonUtil.strToDate(enddt).getTime());
                int remain = (int) (betWeenTime / (1000*60*60*24));

                String status = todayRecList.get(i).getSTATUS();
                String approval = todayRecList.get(i).getAPPROVAL();
                String tomorrow = CommonUtil.getAddDate(today, 1);

                if( status.equals("4") && CommonUtil.strToDate(enddt).getTime() < CommonUtil.strToDate(today).getTime() ){
                    /*미반납*/
                    map.put("rec_class", "bg_02");
                }else if( (status.equals("3") && approval.equals("1"))
                        || (status.equals("3") && approval.equals("2") && strdt.equals(today))
                        || (status.equals("4"))
                        || (status.equals("4") && remain > -3) || (status.equals("6") && !StringUtils.isEmpty(banpdt)) ){
                    /*승인전, 대여예정, 사용중, 반납예정(3일), 반납건*/
                    map.put("rec_class", "bg_01");
                }else if( (status.equals("3") && approval.equals("2") && tomorrow.equals(strdt)) ){
                    /*익일대여예정*/
                    map.put("rec_class", "bg_03");
                }
                
                if(remain >= 0){
                    map.put("remain", "");
                }else{
                    map.put("remain", Math.abs(remain));
                }

                map.put("status", status);
                map.put("statusStr", RentController.statusStr(status, approval));
                map.put("approval", approval);
                map.put("appenm", todayRecList.get(i).getAPPENM());
                map.put("appuenm", todayRecList.get(i).getAPPUENM());
                map.put("strdt", strdt);
                map.put("enddt", enddt);
                map.put("regdt", todayRecList.get(i).getREGDT());
                map.put("banpdt", banpdt);
                
             // 미리보기
                String phtml = "";
                
                phtml += "<div class='basic-list2' style='margin-top:5px; width:500px;'>";
                phtml += "<table style='width: 500px;'>";
                phtml += "<thead>";
                phtml += "<tr>";
                phtml += "<th style='padding: 3px; 0'>구분</th>";
                phtml += "<th style='padding: 3px; 0'>모델명</th>";
                phtml += "<th style='padding: 3px; 0'>배정(별칭)</th>";
                phtml += "</tr>";
                phtml += "</thead>";
                phtml += "<tbody>";
                
                
                
                String[] gbnm_arr = todayRecList.get(i).getGBNM().split(",");
                String[] mdnm_arr = todayRecList.get(i).getMDNM().split(",");
                Integer[] mdseq_arr = ArrayUtils.toObject((int[])new IntegerArrayConverter().convert(null, todayRecList.get(i).getMDSEQ_GRP().split(","))); 
                rentDto.setAPPNO(todayRecList.get(i).getAPPNO());
                rentDto.setMDSEQ_ARR(mdseq_arr);
                
                
                for( int k = 0; k < mdseq_arr.length ; k++ ){
                	
                    String eList = "";
                    List<RentDto> recListPreview = rentService.recListPreview(rentDto);
                    for( int j = 0 ; j < recListPreview.size() ; j++ ){
                        
                    	eList = recListPreview.get(j).getEQNM();
                    	
                    	if(recListPreview.get(j).getEQALIAS() == null){
                    		eList += "(별칭없음)";
                    	}else{
                    		eList += "(" +recListPreview.get(j).getEQALIAS()+ ")";
                    	}
                    	
                    	if(j != recListPreview.size()){
                    		eList += "<br>";
                    	}
                    	
                    }
                    
                    phtml += "<tr>";
                    phtml += "<td style='padding: 0 0'>"+gbnm_arr[k]+"</td>";
                    phtml += "<td style='padding: 0 0'>"+mdnm_arr[k]+"</td>";
                    phtml += "<td style='padding: 0 0'>"+eList+"</td>";
                    phtml += "</tr>";
                	
                }
                
                phtml += "</tbody>";
                phtml += "</table>";
                phtml += "</div>";
                
                map.put("preview", phtml);
                list.add(map);
            }

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }


        try {
            mv.setViewName("rent/admin/todayRecList");
        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        mv.addObject("gbcd", gbcd);
        mv.addObject("codeList", codeList);
        mv.addObject("todayRecList", list);
        mv.addObject("paging", rentDto);
        mv.addObject("totalCnt", totalCnt);
        mv.addObject("totalSumCnt", totalSumCnt);
        mv.addObject("config", Constants.getConfigOption());
        mv.addObject("sch_status", sch_status);
        mv.addObject("sch_approval", sch_approval);
        mv.addObject("sch_text", sch_text);

        return mv;
    }

    /**
     * @param HttpServletRequest
     * @return view(rent/admin/recView)
     * 장비대여 관리메뉴 > 장비신청 조회
     */
    @RequestMapping("/admin/recView.do")
    public ModelAndView recView(HttpServletRequest request, Model model) {
        ModelAndView mv = new ModelAndView();

        /*검색용*/
        EquipManageDto searchDto = new EquipManageDto ();
        /*세션에서 사번취득 후 삽입*/
        String sM_MEMPNO = SESS_EMPNO;
        searchDto.setSM_MEMPNO(sM_MEMPNO);


        String appno = request.getParameter("appno");
        String rfid_empno = StringUtil.isNull(request.getParameter("rfid_empno"),"");

        //param
        String schCode1 = request.getParameter("schCode1");
        String schAppenm = request.getParameter("schAppenm");
        String schApproval = request.getParameter("schApproval");
        String schStatus = request.getParameter("schStatus");
        String schStrdt = request.getParameter("schStrdt");
        String schEnddt = request.getParameter("schEnddt");
        String schName1 = request.getParameter("schName1");
        String schName2 = request.getParameter("schName2");

        try {

            PowerstatusDto powerstatusDto = new PowerstatusDto ();
            powerstatusDto = powerstatusService.getDeptNameInfo(SESS_EMPNO);
            String deptName = powerstatusDto.getDept_name_1depth();
            //deptName += " " + powerstatusDto.getDept_name_2depth();
            mv.addObject("deptName", deptName);

            if(StringUtils.isEmpty(appno)) {
                model.addAttribute("msg", "잘못된 접근입니다.");
                mv.setViewName("/error/errorAlert");
                return mv;
            }

            String param = "";
            if(!StringUtils.isEmpty(schCode1))
            {
                param += "&sch_code1="+schCode1;
            }
            if(!StringUtils.isEmpty(schAppenm))
            {
                param += "&sch_appenm="+schAppenm;
            }
            if(!StringUtils.isEmpty(schApproval))
            {
                param += "&sch_approval="+schApproval;
            }
            if(!StringUtils.isEmpty(schStatus))
            {
                param += "&sch_status="+schStatus;
            }
            if(!StringUtils.isEmpty(schStrdt))
            {
                param += "&sch_strdt="+schStrdt;
            }
            if(!StringUtils.isEmpty(schEnddt))
            {
                param += "&sch_enddt="+schEnddt;
            }
            if(!StringUtils.isEmpty(schName1))
            {
                param += "&sch_name1="+schName1;
            }
            if(!StringUtils.isEmpty(schName2))
            {
                param += "&sch_name2="+schName2;
            }

            if(CommonUtil.isGetAdmin(request)){
            /* 테스트시에는 제외
                model.addAttribute("msg", "잘못된 접근입니다.");
                mv.setViewName("/error/errorAlert");
                return mv;*/
            }

            /*결과 반환용*/
            EquipManageDto recViewInfo = new EquipManageDto ();

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

            //접수완료
            if(status.equals("1") && approval.equals("1")) {
                searchDto.setStatus("3");
                equipManageService.updateStatus(searchDto);
                recViewInfo.setStatus("3");
                status = "3";
            }

            List<EquipManageDto> modelList = new ArrayList<EquipManageDto> ();
            modelList = equipManageService.getRecInfo(searchDto);

            Map<String, Object> assignedMap = new LinkedHashMap<String, Object> ();
            for(int i = 0; i < modelList.size(); i++) {
                EquipManageDto modelDto = new EquipManageDto ();

                modelDto = modelList.get(i);
                /*모델정보취득*/
//                EquipManageDto modelInfo = equipManageService.getModelInfo(modelDto).get(0);
                //20180615 수정  
                List<EquipManageDto> equipMgt = equipManageService.getModelInfo(modelDto);
                EquipManageDto modelInfo = new EquipManageDto();
                
                if(equipMgt != null && equipMgt.size() != 0){
                	modelInfo = equipMgt.get(0);
                	modelDto.setGbcd(modelInfo.getGbcd());
                    modelDto.setMdnm(modelInfo.getMdnm());
                }
                

                if(modelDto.equals(null)) {
                    model.addAttribute("msg", "모델 정보가 존재하지 않습니다.");
                    mv.setViewName("error/errorAlert");
                    return mv;
                }

                
                modelDto.setEqno(modelList.get(i).getEqno());

                /*장비정보취득*/
                EquipManageDto codeInfo = equipManageService.getCodeInfo(modelDto);
                modelDto.setGbnm(codeInfo.getGbnm());

                List<EquipManageDto> assignedEquipList = new ArrayList<EquipManageDto> ();
                assignedEquipList = equipManageService.getAssignedEquipInfo(modelDto);
                assignedMap.put(String.valueOf(i), assignedEquipList);
                modelDto.setAssignedAmount(assignedEquipList.size());
                modelList.set(i, modelDto);
                
            }
            
            /*확인증 첨부*/
            List<EquipManageDto> fileList = new ArrayList<EquipManageDto> ();
            /*첨부파일 검색시*/
            searchDto.setRefno(appno);
            searchDto.setFiletp("C");
            fileList = equipManageService.getAttachFileInfo(searchDto);

            /*보안서약서*/
            EquipManageDto rentSecurityFile = equipManageService.selectRentFile(appno);
            
            
            /*접수상태변경*/
            String btnStatus = "";
            if(!status.equals("2")) {/*취소*/
                if(approval.equals("1")) {/*미승인*/
                    btnStatus = "2";
                } else if(approval.equals("2") && status.equals("3")) {/*승인*/
                    /*boolean isAssignEquip = equipManageService.isAssignEquip(searchDto);*/
                    boolean isAssignEquip = rentService.isAssignEquip(appno);
                    if(isAssignEquip) {/*모두배정완료*/
                        btnStatus = "4";
                    } else {
                        btnStatus = "N";
                    }
                }
                else if(status.equals("4")) //사용중
                {
                    btnStatus = "6";
                }
            }

            mv.addObject("param", param);
            mv.addObject("btnStatus", btnStatus);

            mv.addObject("appno", appno);
            mv.addObject("modelList", modelList);
            mv.addObject("assignedMap", assignedMap);
            mv.addObject("view", recViewInfo);

            Map<String, Object> configMap = Constants.getConfigOption();
            mv.addObject("appstArr", configMap.get("appstArr"));
            mv.addObject("approvalArr", configMap.get("approvalArr"));
            mv.addObject("banpArr", configMap.get("banpArr"));

            Boolean cancelView = CommonUtil.isCancel(status, approval);
            mv.addObject("cancelView", cancelView);

            mv.addObject("rentSecurityFile", rentSecurityFile);
            mv.addObject("fileList", fileList);
            mv.addObject("rfid_empno", rfid_empno);

            mv.setViewName("rent/admin/recView");
        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        return mv;
    }

    /**
     * 부분 반납 처리
     */
    @RequestMapping("/admin/partBanp.do")
    @ResponseBody
    public void partBanp(HttpServletRequest request, HttpServletResponse response) throws Exception{

    	String retVal = "false";
    	
        try{
        	retVal = equipManageService.partBanp(request);
        }catch(Exception e){
        	e.printStackTrace();
    		log.error( "failed!", e );
        }finally {
			response.getWriter().write(retVal);
		}
    }
    

    /**
     * @param HttpServletRequest, HttpServletResponse
     * @return ajax 응답 json
     * 장비대여 접수관련 신청정보 변경시 유동 셀렉트 박스
     */
    @RequestMapping("/rentLoad.do")
    @ResponseBody
    public void rentLoad(HttpServletRequest request, HttpServletResponse response) throws Exception{

        try{
            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();

            String mode = request.getParameter("mode");

            if(StringUtil.isEmpty(mode))
            {
                out.print("error");
            }

            switch (mode) {

                case "load_model" :

                    String gbcd = request.getParameter("gbcd");
                    if(StringUtils.isEmpty(gbcd))
                    {
                        out.print("error");
                    } else {
                        EquipManageDto searchDto = new EquipManageDto();
                        searchDto.setGbcd(gbcd);
                        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
                        Map<String, Object> resultMap = new HashMap<String, Object> ();
                        resultMap = equipManageService.getModelByCode(searchDto);
                        resultList = (List<EquipManageDto>) resultMap.get("resultList");

                        List<Map<String, String>> list = new ArrayList<Map<String, String>> ();
                        for (EquipManageDto result : resultList) {
                            Map<String, String> modelByCodeMap = new HashMap<String, String> ();
                            modelByCodeMap.put("mdseq", result.getMdseq());
                            modelByCodeMap.put("mdnm", result.getMdnm());
                            list.add(modelByCodeMap);
                        }

                        out.print(JSON.encode(list));
                    }

                    break;

                case "load_amount":

                    String mdseq = request.getParameter("mdseq");
                    String strdt = request.getParameter("strdt");
                    String enddt = request.getParameter("enddt");

                    if(StringUtils.isEmpty(mdseq) || StringUtils.isEmpty(strdt) || StringUtils.isEmpty(enddt))
                    {
                        out.print("error");
                    } else {
                        EquipManageDto searchDto = new EquipManageDto();
                        searchDto.setMdseq(mdseq);
                        searchDto.setStrdt(strdt);
                        searchDto.setEnddt(enddt);
                        /*대여 가능 설비 정보*/
                        Map<String, Object> amountInfo = equipManageService.getEquipAmountInfo(searchDto, SESS_EMPNO);

                        int rentEnableCnt = (int)amountInfo.get("rentEnableCnt");

                        out.print(JSON.encode(rentEnableCnt));
                    }

                    break;
            }

        }catch(Exception e){
            e.printStackTrace();
        }
    }

    /**
     * @param HttpServletRequest
     * @return view(rent/admin/recRegist)
     * 장비대여 관리메뉴 > 장비대여 신청
     */
    @RequestMapping("/admin/recRegist.do")
    public ModelAndView recRegist(HttpServletRequest request){
        ModelAndView mv = new ModelAndView();

        /*검색용*/
        EquipManageDto searchDto = new EquipManageDto ();
        /*세션에서 사번취득 후 삽입*/
        String sM_MEMPNO = SESS_EMPNO;
        searchDto.setSM_MEMPNO(sM_MEMPNO);

        try {
            PowerstatusDto powerstatusDto = new PowerstatusDto ();
            powerstatusDto = powerstatusService.getDeptNameInfo(SESS_EMPNO);
            String deptName = powerstatusDto.getDept_name_1depth();
            //deptName += " " + powerstatusDto.getDept_name_2depth();
            mv.addObject("deptName", deptName);

            String mdseq = request.getParameter("mdseq");
            mv.addObject("mdseq", mdseq);
            String strdt = request.getParameter("strdt");
            mv.addObject("strdt", strdt);
            String enddt = request.getParameter("enddt");
            mv.addObject("enddt", enddt);
            String amount = request.getParameter("amount");
            mv.addObject("amount", amount);

            /*코드(대) 데이터를가져온다.*/
            List<EquipManageDto> codeList = new ArrayList<EquipManageDto> ();
            codeList = equipManageService.getAllCodeList(searchDto);
            mv.addObject("codeList", codeList);

            Date today = new Date();
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
            String ymd = df.format(today);
            mv.addObject("ymd", ymd);

            mv.setViewName("rent/admin/recRegist");
        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        return mv;
    }

    /**
     * @param HttpServletRequest
     * @return view(/rent/admin/sign/signRentalDetail)
     * 장비대여 관리메뉴 > rfid 태그
     */
    @RequestMapping("/admin/signRentalDetail.do")
    public ModelAndView signRentalDetail(HttpServletRequest request, Model model){
        ModelAndView mv = new ModelAndView();

        /*검색용*/
        EquipManageDto searchDto = new EquipManageDto ();
        /*세션에서 사번취득 후 삽입*/
        String sM_MEMPNO = SESS_EMPNO;
        searchDto.setSM_MEMPNO(sM_MEMPNO);


        String appno = request.getParameter("appno");

        //param
        String schCode1 = request.getParameter("schCode1");
        String schAppenm = request.getParameter("schAppenm");
        String schApproval = request.getParameter("schApproval");
        String schStatus = request.getParameter("schStatus");
        String schStrdt = request.getParameter("schStrdt");
        String schEnddt = request.getParameter("schEnddt");
        String schName1 = request.getParameter("schName1");
        String schName2 = request.getParameter("schName2");

        try {
            if(StringUtils.isEmpty(appno)) {
                model.addAttribute("msg", "잘못된 접근입니다.");
                mv.setViewName("/error/errorAlert");
                return mv;
            }

            String param = "";
            if(!StringUtils.isEmpty(schCode1))
            {
                param += "&sch_code1="+schCode1;
            }
            if(!StringUtils.isEmpty(schAppenm))
            {
                param += "&sch_appenm="+schAppenm;
            }
            if(!StringUtils.isEmpty(schApproval))
            {
                param += "&sch_approval="+schApproval;
            }
            if(!StringUtils.isEmpty(schStatus))
            {
                param += "&sch_status="+schStatus;
            }
            if(!StringUtils.isEmpty(schStrdt))
            {
                param += "&sch_strdt="+schStrdt;
            }
            if(!StringUtils.isEmpty(schEnddt))
            {
                param += "&sch_enddt="+schEnddt;
            }
            if(!StringUtils.isEmpty(schName1))
            {
                param += "&sch_name1="+schName1;
            }
            if(!StringUtils.isEmpty(schName2))
            {
                param += "&sch_name2="+schName2;
            }

            if(CommonUtil.isGetAdmin(request)){
            /* 테스트시에는 제외
                model.addAttribute("msg", "잘못된 접근입니다.");
                mv.setViewName("/error/errorAlert");
                return mv;*/
            }

            /*결과 반환용*/
            EquipManageDto recViewInfo = new EquipManageDto ();

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
                
                //20180615 수정  
                List<EquipManageDto> equipMng = equipManageService.getModelInfo(modelDto);
                EquipManageDto modelInfo = new EquipManageDto();
                
                if(equipMng != null && equipMng.size() != 0){
                	modelInfo = equipMng.get(0);
                	modelDto.setGbcd(modelInfo.getGbcd());
                    modelDto.setMdnm(modelInfo.getMdnm());
                }
                
//                EquipManageDto modelInfo = equipManageService.getModelInfo(modelDto).get(0);

                if(modelDto.equals(null)) {
                    model.addAttribute("msg", "모델 정보가 존재하지 않습니다.");
                    mv.setViewName("error/errorAlert");
                    return mv;
                }

                

                /*장비정보취득*/
                EquipManageDto codeInfo = equipManageService.getCodeInfo(modelDto);
                modelDto.setGbnm(codeInfo.getGbnm());

                List<EquipManageDto> assignedEquipList = new ArrayList<EquipManageDto> ();
                assignedEquipList = equipManageService.getAssignedEquipInfo(modelDto);
                assignedMap.put(String.valueOf(i), assignedEquipList);
                modelDto.setAssignedAmount(assignedEquipList.size());
                modelList.set(i, modelDto);
            }

            mv.addObject("param", param);

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

            String popup_gubun = request.getParameter("popup_gubun");

            if("user".equals(popup_gubun)){
                mv.setViewName("rent/admin/sign/signRentalDetail_user");
            }else if("admin".equals(popup_gubun)){
                mv.setViewName("rent/admin/sign/signRentalDetail_admin");
            }
        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        return mv;
    }

    /**
     * @param HttpServletRequest
     * @return
     * 장비대여 관리메뉴 > rfid 태그
     */
    @RequestMapping("/admin/saveImgSendMail.do")
    @ResponseBody
    public void saveImgSendMail(HttpServletRequest request, HttpServletResponse response) throws Exception{

        String retVal = "false";

        try{

            String mail_form = request.getParameter("mail_form");
            String appno = request.getParameter("appno");
            String now = DateUtil.getCurrentDateTime();
            String today = DateUtil.getToday();
            String file_path = today + "/" + appno + "_" + now;
            String status = request.getParameter("status");

            File dir = new File(Constants.mailHtmlPath + today);

            if(!dir.exists()){
                dir.mkdirs();
            }

            StringBuffer sb = new StringBuffer(mail_form);

            FileOutputStream fos = null;
            OutputStreamWriter osw = null;

            try {
                fos = new FileOutputStream(Constants.mailHtmlPath + file_path +".html");

                osw = new OutputStreamWriter(fos);

                BufferedWriter bw = new BufferedWriter(osw);

                bw.write(sb.toString());
                bw.flush();

                HashMap<String, String> mailInfo = new HashMap<String, String>();

                mailInfo.put("appno", appno);
                mailInfo.put("status", status);
                mailInfo.put("mail_path", file_path + ".html");

                equipManageService.updateMailPath(mailInfo);

            } catch (Exception e) {
                e.printStackTrace();
            } finally{
                if(fos != null){
                    fos.flush();
                }

                if(osw != null){
                    osw.flush();
                }
            }

            //사인 이미지 처리 불가로 이미지 떨구지 않는다
            //HtmlToImg.create("http://" + Constants.localIP + "/" + file_path + ".html", 1200, 1000, Constants.mailHtmlPath + file_path +".png");
            //HtmlToImg.create("http://192.168.0.18/" + file_path + ".html", 1200, 1000, Constants.mailHtmlPath + file_path +".png");
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            response.setCharacterEncoding("utf-8");

            response.getWriter().write(JSON.encode(retVal));
        }
    }


    /**
     * @param HttpServletRequest
     * @return view(rent/admin/recUpdate)
     * 장비대여 관리메뉴 > 장비대여 신청
     */
    @RequestMapping("/admin/recUpdate.do")
    public ModelAndView recUpdate(HttpServletRequest request, Model model){
        ModelAndView mv = new ModelAndView();
        
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
    	def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
    	TransactionStatus statusTr = dataSourceTransactionManager.getTransaction(def);

        /*검색용*/
        EquipManageDto searchDto = new EquipManageDto ();
        if(CommonUtil.isGetAdmin(request)){
        /* 테스트시에는 제외
            model.addAttribute("msg", "잘못된 접근입니다.");
            mv.setViewName("/error/errorAlert");
            return mv;*/
        }

        EquipManageDto equipDto = new EquipManageDto ();
        try {
            String mode = request.getParameter("mode");
            String appno = request.getParameter("appno");
            String sendInfoChk = request.getParameter("sendInfoChk");

            if(StringUtils.isEmpty(mode)) {
                /*에러 화면 이동*/
            	dataSourceTransactionManager.rollback(statusTr);
                mv.setViewName("/error/error");
                return mv;
            }


            /*모델취소*/
            if(mode.equals("modelCancel")) {
                searchDto.setAppno(appno);
                equipDto = equipManageService.getStatusApproval(searchDto);

                String status = equipDto.getStatus();
                String approval = equipDto.getApproval();

                if(!status.equals("3") || !approval.equals("2")) {
                    /*에러 화면 이동*/
                	dataSourceTransactionManager.rollback(statusTr);
                    mv.setViewName("/error/error");
                    return mv;
                }

                String mdseq = request.getParameter("mdseq");
                String euseq = request.getParameter("euseq");

                if(StringUtils.isEmpty(appno) || StringUtils.isEmpty(mdseq) || StringUtils.isEmpty(euseq)) {
                    /*에러 화면 이동*/
                	dataSourceTransactionManager.rollback(statusTr);
                    mv.setViewName("/error/error");
                    return mv;
                }

                searchDto.setMdseq(mdseq);
                searchDto.setEuseq(euseq);
                
                EquipManageDto currAmountDto = equipManageService.getAmount(searchDto);
                String currResultAmount = currAmountDto.getAmount();
                
                if(Integer.parseInt(currResultAmount) > 1){
                	String modAmount = String.valueOf(Integer.parseInt(currResultAmount) -1);
                	searchDto.setAmount(modAmount);
                	equipManageService.updateAmount(searchDto);
                } else if ( Integer.parseInt(currResultAmount) <= 1 ) {
                	equipManageService.delRecModel(searchDto);
                }
                
                equipManageService.deleteEquipUser(searchDto);
                equipManageService.delRecEquip(searchDto);

                model.addAttribute("msg", "삭제되었습니다.");
                model.addAttribute("url", "/admin/recView.do?appno=" + appno);
                dataSourceTransactionManager.commit(statusTr);
                mv.setViewName("/error/errorAlert");
                return mv;
                
            } else if(mode.equals("appCancel")) {/*접수취소*/
                if(StringUtils.isEmpty(appno))
                {
                    /*에러 화면 이동*/
                	dataSourceTransactionManager.rollback(statusTr);
                    mv.setViewName("/error/error");
                    return mv;
                }

                Boolean appCancel = false;
                appCancel = equipManageService.appCancel(appno, true, SESS_EMPNO, sendInfoChk);
                if(appCancel) {
                    model.addAttribute("msg", "취소되었습니다.");
                    model.addAttribute("url", "/admin/recView.do?appno=" + appno);
                    dataSourceTransactionManager.commit(statusTr);
                    mv.setViewName("/error/errorAlert");
                } else {
                    model.addAttribute("msg", "취소에 실패하였습니다.");
                    model.addAttribute("url", "/admin/recView.do?appno=" + appno);
                    dataSourceTransactionManager.rollback(statusTr);
                    mv.setViewName("/error/errorAlert");
                }
            } else if(mode.equals("amountChange")) {
                String mdseq = request.getParameter("mdseq");
                String amount = request.getParameter("amount");

                searchDto.setAppno(appno);
                equipDto = equipManageService.getStatusApproval(searchDto);

                String status = equipDto.getStatus();
                String approval = equipDto.getApproval();

                if(StringUtils.isEmpty(appno) || StringUtils.isEmpty(mdseq)
                                            || StringUtils.isEmpty(amount)) {
                    model.addAttribute("msg", "변경에 실패하였습니다.");
                    model.addAttribute("url", "/admin/recView.do?appno=" + appno);
                    dataSourceTransactionManager.rollback(statusTr);
                    mv.setViewName("/error/errorAlert");
                }

                /*변경전 상태체크*/
                /*접수완료, 승인완료가 아니면..*/
                if(!status.equals("3") || !approval.equals("2")) {
                    model.addAttribute("msg", "변경에 실패하였습니다.");
                    model.addAttribute("url", "/admin/recView.do?appno=" + appno);
                    dataSourceTransactionManager.rollback(statusTr);
                    mv.setViewName("/error/errorAlert");
                }

                searchDto.setMdseq(mdseq);
                EquipManageDto amountDto = new EquipManageDto ();
                amountDto = equipManageService.getAmount(searchDto);

                /*신청수량이 추가될경우 남은수량 체크*/
                if (amountDto != null ){
                    String rstAmount = amountDto.getAmount();
                    if (Integer.valueOf(amount) > Integer.valueOf(rstAmount)) {
                        searchDto.setStrdt(equipDto.getStrdt());
                        searchDto.setEnddt(equipDto.getEnddt());
                        /*대여 가능 설비 정보*/
                        Map<String, Object> amountInfo = equipManageService.getEquipAmountInfo(searchDto, SESS_EMPNO);

                        int rentEnableCnt = (int)amountInfo.get("rentEnableCnt");
                        if ((Integer.valueOf(amount)-Integer.valueOf(rstAmount)) > rentEnableCnt) {
                            model.addAttribute("msg", "대여가능한 설비가 부족하거나 없습니다.");
                            dataSourceTransactionManager.rollback(statusTr);
                            mv.setViewName("/error/errorAlert");
                        }
                    } else if (Integer.valueOf(amount) < Integer.valueOf(rstAmount)) {
                        equipManageService.delRecEquip(searchDto);
                    }
                }

                /*업데이트*/
                searchDto.setAmount(amount);
                equipManageService.updateAmount(searchDto);
                dataSourceTransactionManager.commit(statusTr);
                
            } else if (mode.equals("recInsert")) {
            	
            	String deptno = request.getParameter("deptno");
                String appeno = request.getParameter("appeno");
                String appenm = request.getParameter("appenm");
                String appss = request.getParameter("appss");
                String apptel = request.getParameter("apptel");
                String apphp = request.getParameter("apphp");
                String appmail = request.getParameter("appmail");

                String appueno = request.getParameter("appueno");
                String appuenm = request.getParameter("appuenm");
                
                String[] appueno_arr = request.getParameterValues("appueno_arr");
                String[] appuenm_arr = request.getParameterValues("appuenm_arr");
                String[] deptno_arr = request.getParameterValues("deptno_arr");
                String[] dept_Nm1dept_arr = request.getParameterValues("dept_Nm1dept_arr");

                String useobj = request.getParameter("useobj");
                String insuno = request.getParameter("insuno");
                String insunm = request.getParameter("insunm");
                String insudt = request.getParameter("insudt");
                String banpno = request.getParameter("banpno");
                String banpnm = request.getParameter("banpnm");
                String banpdt = request.getParameter("banpdt");
                
                String rent_NB_Gubun = request.getParameter("rent_NB_Gubun");
                
                if (!StringUtil.isEmpty(insudt)) {
                	insudt = insudt.replaceAll("[^0-9]", "");
                }
                
                if (!StringUtil.isEmpty(banpdt)) {
                	banpdt = banpdt.replaceAll("[^0-9]", "") + "00";
                }
                
                String banpst = request.getParameter("banpst");
                String bigo = request.getParameter("bigo");

                String strdt = request.getParameter("strdt");
                String enddt = request.getParameter("enddt");
                
                if (!StringUtil.isEmpty(strdt)) {
                	strdt = strdt.replaceAll("[^0-9]", "");
                }
                
                if (!StringUtil.isEmpty(enddt)) {
                	enddt = enddt.replaceAll("[^0-9]", "");
                }

                String[] mdseq = request.getParameterValues("mdseq[]"); //array

                String[] amount = request.getParameterValues("amount[]"); //array

                String[] allocEquip = request.getParameterValues("allocEquip[]"); //array
                String euseq = null;


                if (mdseq == null || mdseq.length == 0 ||
                    amount == null || amount.length == 0 ) {
                    model.addAttribute("msg", "최소 한개이상 신청하셔야 합니다.");
                    dataSourceTransactionManager.rollback(statusTr);
                    mv.setViewName("/error/errorAlert");
                }

                /*대여일 ~부터*/
                if (StringUtil.isNotEmpty(strdt) && StringUtil.isNotEmpty(enddt)){
                    /*문자를 데이터형으로 변경*/
                    SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
                    Date strDate = df.parse(strdt);
                    Date endDate = df.parse(enddt);

                    if(strDate.compareTo(endDate) > 0) {
                        model.addAttribute("msg", "대여기간이 올바르지 않습니다.");
                        dataSourceTransactionManager.rollback(statusTr);
                        mv.setViewName("error/errorAlert");
                        return mv;
                    }
                }

                for (int i = 0; i < mdseq.length; i++) {
                    searchDto.setMdseq(mdseq[i]);
                    /*신청가능한 모델 체크*/
                    EquipManageDto modelInfo = equipManageService.getModelInfo(searchDto).get(0);

                    if(StringUtils.isEmpty(modelInfo.getMdseq())) {
                        model.addAttribute("msg", "신청할수 없는 모델입니다.");
                        dataSourceTransactionManager.rollback(statusTr);
                        mv.setViewName("/error/errorAlert");
                    }

                    searchDto.setStrdt(strdt);
                    searchDto.setEnddt(enddt);
                    /*대여가능 체크*/
                    Map<String, Object> amountInfo = equipManageService.getEquipAmountInfo(searchDto, SESS_EMPNO);

                    int rentEnableCnt = (int)amountInfo.get("rentEnableCnt");
                    if (Integer.valueOf(amount[i]) > rentEnableCnt) {
                        model.addAttribute("msg", "대여가능한 설비가 부족하거나 없습니다. \n 수량및 대여기간을 확인하세요.");
                        dataSourceTransactionManager.rollback(statusTr);
                        mv.setViewName("/error/errorAlert");
                    }
                }

                int appnoInt = equipManageService.getNextAppno();
                
                /*이번해 취득*/
                Date today = new Date();
                SimpleDateFormat yyyy = new SimpleDateFormat("yyyy");
                String yearStr = yyyy.format(today);
                SimpleDateFormat yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
                String regdt = yyyyMMddHHmmss.format(today);
                NumberFormat formatter = new DecimalFormat("00000000");
                String appnum = String.valueOf(yearStr + formatter.format(appnoInt));

                EquipManageDto insertDto = new EquipManageDto ();

                insertDto.setAppno(String.valueOf(appnoInt));
                insertDto.setAppnum(appnum);
                insertDto.setAppeno(appeno);
                insertDto.setAppenm(appenm);
                insertDto.setAppuenm(appuenm);
                insertDto.setAppss(appss);
                insertDto.setApptel(apptel);
                insertDto.setAppmail(appmail);
                insertDto.setApphp(apphp);                
                insertDto.setBigo(bigo);
                insertDto.setUseobj(useobj);
                insertDto.setStrdt(strdt);
                insertDto.setEnddt(enddt);
                insertDto.setStatus("3");
                insertDto.setApproval("2");
                insertDto.setRegeno(SESS_EMPNO);
                insertDto.setRegenm(SESS_USER_NAME);
                insertDto.setRegdt(regdt);
                insertDto.setRent_NB_Gubun(rent_NB_Gubun);
                
                equipManageService.insertAppData(insertDto);
               
                MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;

            	int maxFileNo = rentService.getMaxFileNo();
                List<HashMap<String, Object>> fileInfoList = commonUtil.sendToServer(multipartRequest, maxFileNo);
                EquipManageDto equipFileDto = new EquipManageDto();
                for (int i = 0; i < fileInfoList.size(); i++) {
                    HashMap<String, Object> fileInfoMap = fileInfoList.get(i);
                    if (fileInfoMap != null) {
                    	if("file_attach".equals(fileInfoMap.get("inputNm"))) {
                    		String security_path = dir_path + "/"+ CommonUtil.getToday().subSequence(0, 4) + "/";
                    		File dir1 = new File(security_path);

                            if (!dir1.exists()) {
                            	dir1.mkdirs();
                            }
                    		equipFileDto.setRENT_SECURITY_orgFileName((String) fileInfoMap.get("userFileName"));
                            equipFileDto.setRENT_SECURITY_fileName((String) fileInfoMap.get("saveFileName"));
                            equipFileDto.setRENT_SECURITY_ext((String) fileInfoMap.get("fileExt"));
                            equipFileDto.setRENT_SECURITY_phycalPath(security_path + "/" + (String) fileInfoMap.get("saveFileName") + "." + fileInfoMap.get("fileExt"));
                            equipFileDto.setRENT_SECURITY_logicalPath("/rent/security/" + CommonUtil.getToday().subSequence(0, 4) + "/" + fileInfoMap.get("saveFileName") + "." + fileInfoMap.get("fileExt"));
                            equipFileDto.setAppno(String.valueOf(appnoInt));
                            equipFileDto.setRENT_SECURITY_userPK((String) request.getSession().getAttribute("SESS_EMPNO"));
                            equipManageService.insertFile(equipFileDto);
                    	}
                    }
                }

                for (int i = 0; i < mdseq.length; i++) {

                    EquipManageDto insertMdDto = new EquipManageDto ();
                    insertMdDto.setAppno(String.valueOf(appnoInt));
                    insertMdDto.setMdseq(mdseq[i]);
                    insertMdDto.setAmount(amount[i]);                    
                    
                    EquipManageDto appModelChk = equipManageService.getEquipAmount(insertMdDto);
                    
                    /*모델 배정*/
                    if(appModelChk != null){
                    	insertMdDto.setAmount(String.valueOf(Integer.parseInt(appModelChk.getAmount()) + 1));
                    	equipManageService.updateAmount(insertMdDto);
                    }else{
                    	equipManageService.insertAppModel(insertMdDto);
                    }
                    
                    /*사용자 배정*/
                    if (appueno_arr[i] != null){
                    	if(!appueno_arr[i].isEmpty() && !appuenm_arr[i].isEmpty()){
                    		insertMdDto.setAppueno(appueno_arr[i]);
                    		insertMdDto.setAppuenm(appuenm_arr[i]);
                    		insertMdDto.setDeptno(deptno_arr[i]);
                    		insertMdDto.setDEPT1NM(dept_Nm1dept_arr[i]);
                    		equipManageService.insertEquipUser(insertMdDto);
                    		euseq = equipManageService.getMaxEuseq(insertMdDto);
                    	}
                    }
                    
                    /*장비 배정*/
                    if (allocEquip[i] != null) {
                        if (!allocEquip[i].isEmpty() && !euseq.isEmpty()) {
                            insertMdDto.setEqno(allocEquip[i]);
                            insertMdDto.setEuseq(euseq);
                            equipManageService.insertAppEquip(insertMdDto);
                            equipManageService.updateAppEquipUser(insertMdDto);
                        }
                    }
                    
                }

                searchDto.setAppno(String.valueOf(appnoInt));

                List<EquipManageDto> equipInfo = equipManageService.getEquipInfo(searchDto);

                /*장비 배정*/
                /*boolean isAssignEquip = equipManageService.isAssignEquip(searchDto);*/
                boolean isAssignEquip = rentService.isAssignEquip(String.valueOf(appnoInt));
                
                EquipManageDto updateDto = new EquipManageDto ();
                if (isAssignEquip && StringUtil.isNotEmpty(insunm.trim()) && StringUtil.isNotEmpty(insuno.trim()) && StringUtils.isNotEmpty(insudt)) {
                    updateDto.setAppno(String.valueOf(appnoInt));
                    updateDto.setInsuno(insuno);
                    updateDto.setInsunm(insunm);
                    updateDto.setInsudt(insudt);
                    equipManageService.updateInsu(updateDto);

                    for (EquipManageDto dto : equipInfo) {
                    	dto.setEqlst("1");
                        equipManageService.updateInUse(dto);
                    }
                } else if (isAssignEquip
                				&& StringUtil.isNotEmpty(insuno.trim())
                				&& StringUtil.isNotEmpty(insunm.trim())
                                && StringUtils.isNotEmpty(insudt)
                                && StringUtil.isNotEmpty(banpno.trim())
                                && StringUtil.isNotEmpty(banpnm.trim())
                                && StringUtils.isNotEmpty(banpdt)) {
                    updateDto.setAppno(String.valueOf(appnoInt));
                    updateDto.setBanpno(banpno);
                    updateDto.setBanpnm(banpnm);
                    updateDto.setBanpdt(banpdt);                    
                    equipManageService.updateBanp(updateDto);
                    
                    for (EquipManageDto dto : equipInfo) {
                    	dto.setEqlst("0");
                        equipManageService.updateInUse(dto);
                    }
                }

                model.addAttribute("msg", "등록되었습니다.");
                model.addAttribute("url", "/admin/recList.do");
                dataSourceTransactionManager.commit(statusTr);
                mv.setViewName("error/errorAlert");
                return mv;
                               
            } else if(mode.equals("recUpdate")) {

                if(StringUtil.isEmpty(appno))
                {
                    model.addAttribute("msg", "잘못된 접근입니다.");
                    dataSourceTransactionManager.rollback(statusTr);
                    mv.setViewName("error/errorAlert");
                    return mv;
                }
                String appeno = request.getParameter("appeno");
                String appenm = request.getParameter("appenm");
                String appss = request.getParameter("appss");
                String apptel = request.getParameter("apptel");
                String apphp = request.getParameter("apphp");
                String appmail = request.getParameter("appmail");

                String appueno = request.getParameter("appueno");
                String appuenm = request.getParameter("appuenm");

                String useobj = request.getParameter("useobj");
                String insuno = request.getParameter("insuno");
                String insunm = request.getParameter("insunm");
                String insudt = request.getParameter("insudt");
                String banpno = request.getParameter("banpno");
                String banpnm = request.getParameter("banpnm");
                String banpdt = request.getParameter("banpdt");
                
                String rent_NB_Gubun = request.getParameter("rent_NB_Gubun");
                
                if (!StringUtil.isEmpty(insudt)) {
                	insudt = insudt.replaceAll("[^0-9]", "");
                }
                
                if (!StringUtil.isEmpty(banpdt)) {
                	banpdt = banpdt.replaceAll("[^0-9]", "") + "00";
                }
                String banpst = request.getParameter("banpst");
                String bigo = request.getParameter("bigo");

                EquipManageDto updateDto = new EquipManageDto ();
                updateDto.setAppno(appno);

                updateDto.setAppeno(appeno);
                updateDto.setAppenm(appenm);
                updateDto.setAppss(appss);
                updateDto.setApptel(apptel);
                updateDto.setApphp(apphp);
                updateDto.setAppmail(appmail);
                updateDto.setAppueno(appueno);
                updateDto.setAppuenm(appuenm);
                updateDto.setUseobj(useobj);
                updateDto.setInsuno(insuno);
                updateDto.setInsunm(insunm);
                updateDto.setInsudt(insudt);
                updateDto.setBanpno(banpno);
                updateDto.setBanpnm(banpnm);
                updateDto.setBanpdt(banpdt);
                updateDto.setBanpst(banpst);
                updateDto.setBigo(bigo);
                updateDto.setRent_NB_Gubun(rent_NB_Gubun);

                equipManageService.updateAppData(updateDto);

                //확인증 첨부
                MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;

                	int maxFileNo = rentService.getMaxFileNo();
                    List<HashMap<String, Object>> fileInfoList = commonUtil.sendToServer(multipartRequest, maxFileNo);
                    

                    RentDto rentDto = new RentDto ();
                    for (int i = 0; i < fileInfoList.size(); i++) {
                        HashMap<String, Object> fileInfoMap = fileInfoList.get(i);
                        if (fileInfoMap != null) {
                        	if("C_attFile".equals(fileInfoMap.get("inputNm"))) {
                            /* 첨부파일 */
	                            rentDto.setREFNO(Integer.valueOf(appno));
	                            rentDto.setFILETP((String) fileInfoMap.get("fileType"));
	                            rentDto.setFILENO((int) fileInfoMap.get("fileNo"));
	                            rentDto.setFILENM((String) fileInfoMap.get("userFileName"));
	                            rentDto.setPATHNM("/rent/" + CommonUtil.getToday().subSequence(0, 4) + "/" + fileInfoMap.get("saveFileName") + "." + fileInfoMap.get("fileExt"));
	                            rentService.insFile(rentDto);
                        	}else {
                        		String security_path = dir_path + "/"+ CommonUtil.getToday().subSequence(0, 4) + "/";
                        		File dir1 = new File(security_path);

                                if (!dir1.exists()) {
                                	dir1.mkdirs();
                                }
                        		EquipManageDto equipFileDto = new EquipManageDto();
                        		equipFileDto.setRENT_SECURITY_orgFileName((String) fileInfoMap.get("userFileName"));
                                equipFileDto.setRENT_SECURITY_fileName((String) fileInfoMap.get("saveFileName"));
                                equipFileDto.setRENT_SECURITY_ext((String) fileInfoMap.get("fileExt"));
                                equipFileDto.setRENT_SECURITY_phycalPath(security_path + "/" + (String) fileInfoMap.get("saveFileName") + "." + fileInfoMap.get("fileExt"));
                                equipFileDto.setRENT_SECURITY_logicalPath("/rent/security/" + CommonUtil.getToday().subSequence(0, 4) + "/" + fileInfoMap.get("saveFileName") + "." + fileInfoMap.get("fileExt"));
                                equipFileDto.setAppno(String.valueOf(appno));
                                equipFileDto.setRENT_SECURITY_userPK((String) request.getSession().getAttribute("SESS_EMPNO"));
                                equipManageService.insertFile(equipFileDto);
                        	}
                        } else {
                            model.addAttribute("msg", "수정 실패 : " + rentDto.getFILENM());
                            dataSourceTransactionManager.rollback(statusTr);
                            mv.setViewName("error/errorAlert");
                            return mv;
                        }
                    }

                model.addAttribute("msg", "수정되었습니다.");
                model.addAttribute("url", "/admin/recView.do?appno=" + appno);
                dataSourceTransactionManager.commit(statusTr);
                mv.setViewName("error/errorAlert");
                return mv;
            }
        } catch (Exception e) {
            // TODO TRY/CATCH
        	dataSourceTransactionManager.rollback(statusTr);
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        return mv;
    }
    
    @RequestMapping("/admin/createDataInEU.do")
    public void createDataInEU() throws Exception {
    	
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
        
        try {
			
        	/*배정된 데이터를 사용해 EU데이터 내역을 생성*/
        	equipManageService.insertEQtoEU();
        	System.out.println("배정된 데이터를 사용해 EU데이터 내역을 생성");
        	
        	/*장비배정이 되지않은 접수모델 정보를 가져온다*/
        	List<EquipManageDto> modelListExpEQ = equipManageService.selectAMexpEQ();
        	System.out.println("장비배정이 되지않은 접수모델 정보를 파싱");
        	
        	EquipManageDto modelToEqDto = new EquipManageDto();
        	for ( int i = 0 ; i < modelListExpEQ.size() ; i++ ){
        		
        		modelToEqDto.setAppno(modelListExpEQ.get(i).getAppno());
        		modelToEqDto.setMdseq(modelListExpEQ.get(i).getMdseq());
        		modelToEqDto.setEqno(null);
        		modelToEqDto.setAppueno(modelListExpEQ.get(i).getAppueno());
        		modelToEqDto.setAppuenm(modelListExpEQ.get(i).getAppuenm());
        		
        		for ( int j = 0 ; j < Integer.parseInt(modelListExpEQ.get(i).getAmount()) ; j++ ){
        			equipManageService.insertEquipUser(modelToEqDto);
        		}
        	}
        	System.out.println("AMOUNT수에 따라 EquipUser 데이터 생성 완료");
        	
        	dataSourceTransactionManager.commit(status);
        	
		} catch (Exception e) {
			e.printStackTrace();
			dataSourceTransactionManager.rollback(status);
		}
    	
    
    	
    }
    
    /**
     * 점검대장 월별 반출,반납 합계 로그 데이터 생성
     * 기본 룰은 매월 1일 00시 10분에 스케줄 돌면서(dispacher-servlet) "전월" 데이터 합계 생성
     * 결재자가 변경된 경우, 점검자(기안자)가 결재 진행을 하지 않은 건에 대해 url 콜로 재생성 가능. param=reqDate(201806)
     * force_reset : 점검자가 결재 진행 또는 최종 결재가 완료된 건을 강제적으로 삭제 인서트 처리 하기 위한 파라메터. force_reset=neodreams1324
     */
    @RequestMapping("/admin/insertMonthAppData.do")
    public void insertMonthAppData(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result = "fail";
        
    	try{ 
    		//점검자가 아직 결재 미진행 건에 대해 삭제 인서트 할 년월 데이터. 201807
    		String reqDate = request.getParameter("reqDate");
    		String force_reset = request.getParameter("force_reset");
    		
    		/*
    		RESET             Y or N
    		#app_month#       20180601
    		'$strdt$%'        201806
    		#start_banpdt#    2018-06-01
    		#end_banpdt#      2018-07-01
    		*/
    		HashMap<String, String> dataMap = new HashMap<>();
    		
    		if(StringUtil.isEmpty(reqDate)){
    			reqDate = DateUtil.getFirstDayBeforeMonth(DateUtil.getCurrentDate(), 1);
    			dataMap.put("RESET", "N");
    		}else{
    			reqDate = reqDate + "01";
    			dataMap.put("RESET", "Y");
    		}
    		
    		if(StringUtil.isNotEmpty(force_reset)
    				&& "neodreams1324".equals(force_reset)){
    			dataMap.remove("RESET");
    			dataMap.put("force_reset","force_reset");
    		}

    		dataMap.put("app_month", reqDate);
    		dataMap.put("strdt", reqDate.substring(0, 6));
    		dataMap.put("start_banpdt", NeoUtil.getDateTmFormat(reqDate, "-", "3"));
    		dataMap.put("end_banpdt", NeoUtil.getDateTmFormat(DateUtil.getFirstDayAfterMonth(reqDate, 1), "-", "3"));
    		
    		equipManageService.insertMonthAppData(dataMap);
    		
    		HashMap<String, String> appList = equipManageService.getCheckAppList();
    		HashMap<String, String> monthApproval_Info = equipManageService.getMonthApproval_Info(String.valueOf(dataMap.get("app_month")));
    		
    		SendMail sendMail = SendMail.getInstance();
            Address[] toAddrs = new Address[1];
            
            if(!Constants.TEST_MODE){
            	toAddrs[0] = new InternetAddress(appList.get("app_empno1") + "@kepco.co.kr");
            }else{
            	toAddrs[0] = new InternetAddress("rhfogud@neodreams.co.kr");
            }
            sendMail.equip_month_app_sendMail(toAddrs, monthApproval_Info);
    		
            equipManageService.updateMonthApproval_Info(reqDate, "mail");
            
            System.out.println("insertMonthAppData success" + DateUtil.getCurrentDateTime());
    		SendONESTOP onestop = SendONESTOP.getInstance();
    		//기안자
    		String empNo = Constants.ONESTOP_WRITER;
    		String empName = Constants.ONESTOP_WRITER_NAME;
    		String retCode = "";
    		List<OneStopLogVO> oneStopLogList = new ArrayList<>();
    		OneStopLogVO osl = new OneStopLogVO();
    		int logCnt = equipManageService.getOneStopLogCnt();
    		
    		OneStopVO osVO = new OneStopVO();
    		String url = Constants.ASP_DOMAIN + "admin/checkAppMonthApproval.do?target_date="+dataMap.get("app_month");
    		String systemKey = dataMap.get("app_month").substring(0, 6) + (String.valueOf(monthApproval_Info.get("reg_datetime")).replace("-", "").replace(":", "").replace(" ", "").substring(6, 14));
			String title = "[멀티미디어 장비대여 " + dataMap.get("app_month").substring(0, 4) + "년 " + dataMap.get("app_month").substring(4, 6) + "월 반입/반출 결재 건]";
    		
			//최초 기안자(김종찬으로 임시 등록)
			osVO = setVoInfo("E", empNo, systemKey, empName, empNo, title, url, "0");
    		retCode = onestop.sendOneStop(osVO);
    		
    		osl.setEp_SignType("E");
			logCnt = logCnt+1;
			osl.setEp_LogSeq(logCnt);
			osl.setEp_DocData(dataMap.get("app_month"));
			osl.setEp_DocApprover(empNo);
			osl.setEp_SendData(osVO.toStringDefault());
			osl.setEp_ReciveData(retCode);
			oneStopLogList.add(osl);
			
    		osVO = setVoInfo("S", monthApproval_Info.get("app_empno1"), systemKey, empName, empNo, title, url, "0");
    		retCode = onestop.sendOneStop(osVO);
    		
    		osl = new OneStopLogVO();
    		osl.setEp_SignType("E");
			logCnt = logCnt+1;
			osl.setEp_LogSeq(logCnt);
			osl.setEp_DocData(dataMap.get("app_month"));
			osl.setEp_DocApprover(monthApproval_Info.get("app_empno1"));
			osl.setEp_SendData(osVO.toStringDefault());
			osl.setEp_ReciveData(retCode);
			oneStopLogList.add(osl);
			
			equipManageService.insertOneStopLog(oneStopLogList);
            
    		result = "success";
    		
    	}catch(Exception e){
    		e.printStackTrace();
    	}finally {
    		response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.print(result);
		}
    }
    
    /**
     * 점검 결재선 지정
     */
    @RequestMapping("/admin/checkAppManage.do")
    public ModelAndView checkAppManage() throws Exception {
    	ModelAndView mv = new ModelAndView(); 
    	
    	try{ 
    		HashMap<String, String> appList = equipManageService.getCheckAppList();
    		
    		mv.setViewName("/rent/admin/checkAppManagePop");
    		mv.addObject("appList", appList);
    	}catch(Exception e){
    		e.printStackTrace();
    		mv.setViewName("/error/error");
    	}
    	return mv;
    }
    
    /**
     * 점검대장 리스트
     */
    @RequestMapping("/admin/checkAppMonthList.do")
    public ModelAndView checkAppMonthList(EquipManageDto equipManageDto, BindingResult result, HttpServletRequest request) throws Exception {
    	ModelAndView mv = new ModelAndView(); 
    	
    	try{ 
    		List<HashMap<String, String>> monthList = equipManageService.getCheckAppMonthList(equipManageDto);
    		int totalCnt = equipManageService.getCheckAppMonthListCnt(equipManageDto);
    		
    		mv.setViewName("/rent/admin/checkAppMonthList");
    		mv.addObject("paging", equipManageDto);
    		mv.addObject("monthList", monthList);
        	mv.addObject("totalCnt", totalCnt);
        	mv.addObject("SESS_EMPNO", (String) request.getSession().getAttribute("SESS_EMPNO"));
    	}catch(Exception e){
    		e.printStackTrace();
			mv.setViewName("/error/error");
    	}
        return mv;
    }
    
    /**
     * 점검대장 상세
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("/admin/checkAppMonthDetail.do")
    public ModelAndView checkAppMonthDetail(EquipManageDto equipManageDto, BindingResult result, HttpServletRequest request) throws Exception {
    	ModelAndView mv = new ModelAndView(); 
    	
    	try{
    		/*
    		String target_date = request.getParameter("target_date");
    		String gubun = request.getParameter("gubun");	//total, long, short
    		String insban = request.getParameter("insban");	//ins, ban
    		*/
    		
    		DataMap dataMap = new DataMap(request, "non_encoding");
    		
    		String target_date = dataMap.getNVLString("target_date");
    		
    		if(StringUtil.isNotEmpty(target_date)){
    			//전체 검색인 경우 map에서 제거 처리로 전체 조회 한다
    			if("total".equals(dataMap.getNVLString("gubun"))){
    				dataMap.remove("gubun");
    			}
    			
	    		dataMap.put("strdt", target_date.substring(0,6));
	    		dataMap.put("start_banpdt", NeoUtil.getDateTmFormat(target_date, "-", "3"));
	    		dataMap.put("end_banpdt", NeoUtil.getDateTmFormat(DateUtil.getFirstDayAfterMonth(target_date, 1), "-", "3"));
	    		
	    		List<HashMap<String, String>> monthList = equipManageService.getCheckAppMonthDeviceList(dataMap);
	    		
	    		mv.setViewName("/rent/admin/checkAppMonthDetail");
	    		mv.addObject("srhReq", dataMap.getParameterHiddenForm());
	    		mv.addObject("monthList", monthList);
	    		mv.addObject("dataMap", dataMap);
    		}else{
    			mv.setViewName("/error/error");
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    		mv.setViewName("/error/error");
    	}
    	return mv;
    }

    /**
     * 점검대장 결제
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("/admin/checkAppMonthApproval.do")
    public ModelAndView checkAppMonthApproval(EquipManageDto equipManageDto, BindingResult result, HttpServletRequest request) throws Exception {
    	ModelAndView mv = new ModelAndView(); 
    	
    	try{
    		/*
    		String target_date = request.getParameter("target_date");
    		String gubun = request.getParameter("gubun");	//total, long, short
    		String insban = request.getParameter("insban");	//ins, ban
    		*/
    		
    		DataMap dataMap = new DataMap(request, "non_encoding");
    		
    		String target_date = dataMap.getNVLString("target_date");
    		
    		if(StringUtil.isNotEmpty(target_date)){
    			//전체 검색인 경우 map에서 제거 처리로 전체 조회 한다
    			HashMap<String, String> monthApproval_Info = equipManageService.getCheckAppMonthInfo(target_date);
	    		
	    		mv.setViewName("/rent/admin/checkAppMonthApproval");
	    		/*mv.addObject("srhReq", dataMap.getParameterHiddenForm());*/
	    		mv.addObject("resultView", monthApproval_Info);
	    		mv.addObject("dataMap", dataMap);
    		}else{
    			mv.setViewName("/error/error");
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    		mv.setViewName("/error/error");
    	}
    	return mv;
    }
    
    @SuppressWarnings("unchecked")
	@RequestMapping("/admin/insertCheckAppManage.do")
    public void insertCheckAppManage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String result = "false";
        
    	try{
    		DataMap dataMap = new DataMap(request, "non_encoding");
    		dataMap.put("reg_empno", (String) request.getSession().getAttribute("SESS_EMPNO"));
    		equipManageService.insertCheckAppManage(dataMap);
    		
    		result = "success";
    		
    	}catch(Exception e){
    		e.printStackTrace();
    	}finally {
    		response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.print(result);
		}
    }
    
	@RequestMapping("/admin/oneStopCheckAppMonth.do")
	public void oneStopCheckAppMonth(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
		String result = "fail";
		List<OneStopLogVO> oneStopLogList = new ArrayList<>();
		OneStopLogVO osl = new OneStopLogVO();
		int logCnt = equipManageService.getOneStopLogCnt();
		HashMap<String, String> monthApproval_Info = new HashMap<>();
		String app_month = request.getParameter("app_month");
		String level = request.getParameter("level");
		OneStopVO osVO = new OneStopVO();
		
		try {
			String retCode = "";
			
			monthApproval_Info = equipManageService.getMonthApproval_Info(app_month);
			
			SendONESTOP onestop = SendONESTOP.getInstance();
			
			String systemKey = app_month.substring(0, 6) + (String.valueOf(monthApproval_Info.get("reg_datetime")).replace("-", "").replace(":", "").replace(" ", "").substring(6, 14));
			String title = "[멀티미디어 장비대여 " + app_month.substring(0, 4) + "년 " + app_month.substring(4, 6) + "월 반입/반출 결재 건]";
			String url = Constants.ASP_DOMAIN + "admin/checkAppMonthApproval.do?target_date="+ app_month;
			
			if("1".equals(level) || "2".equals(level)){
				//level 1 - 기안자표시, level 2 - 결재시행
				osVO = setVoInfo("E", monthApproval_Info.get("app_empno" + level), systemKey, Constants.ONESTOP_WRITER_NAME, Constants.ONESTOP_WRITER, title, url, "0");
				System.out.println(osVO.toStringDefault());
				retCode = onestop.sendOneStop(osVO);
				
				osl.setEp_SignType("E");
				logCnt = logCnt+1;
				osl.setEp_LogSeq(logCnt);
				osl.setEp_DocData(app_month.substring(0, 6));
				osl.setEp_DocApprover(monthApproval_Info.get("app_empno" + level));
				osl.setEp_SendData(osVO.toStringDefault());
				osl.setEp_ReciveData(retCode);
				oneStopLogList.add(osl);
				
				if("0000".equals(retCode)){
					
					retCode = "";
					
					//결재올리기
					osVO = setVoInfo("S", monthApproval_Info.get("app_empno" + (Integer.parseInt(level) + 1)), systemKey, Constants.ONESTOP_WRITER_NAME, Constants.ONESTOP_WRITER, title, url, "0");
					retCode = onestop.sendOneStop(osVO);
					
					osl = new OneStopLogVO();
					osl.setEp_SignType("S");
					logCnt = logCnt+1;
					osl.setEp_LogSeq(logCnt);
					osl.setEp_DocData(app_month.substring(0, 6));
					osl.setEp_DocApprover(monthApproval_Info.get("app_empno" + (Integer.parseInt(level) + 1)));
					osl.setEp_SendData(osVO.toStringDefault());
					osl.setEp_ReciveData(retCode);
					oneStopLogList.add(osl);
					
					if("0000".equals(retCode)){
						equipManageService.updateMonthApproval_Info(app_month, level);
						
						result = "success";
					}
				}
			}else if("3".equals(level)){
				//결재시행
				osVO = setVoInfo("E", monthApproval_Info.get("app_empno3"), systemKey, Constants.ONESTOP_WRITER_NAME, Constants.ONESTOP_WRITER, title, url, "1");
				retCode = onestop.sendOneStop(osVO);

				osl = new OneStopLogVO();
				osl.setEp_SignType("E");
				logCnt = logCnt+1;
				osl.setEp_LogSeq(logCnt);
				osl.setEp_DocData(app_month.substring(0, 6));
				osl.setEp_DocApprover(monthApproval_Info.get("app_empno3"));
				osl.setEp_SendData(osVO.toStringDefault());
				osl.setEp_ReciveData(retCode);
				oneStopLogList.add(osl);
				
				if("0000".equals(retCode)){
					equipManageService.updateMonthApproval_Info(app_month, level);
					result = "success";
				}
			}
			
			
			
		} catch (Exception e) {
			System.out.println("sendOneStop ERROR" + e.getMessage());
		} finally {
			response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            equipManageService.insertOneStopLog(oneStopLogList);
            out.print(result);
		}
	}
    
	/**
	 * socket 발송용 setVO
	 */
    private OneStopVO setVoInfo(String signType, String signEmpId, String systemKey, String writeEmpName, String writeEmpId, String title, String url, String status){
    	
    	OneStopVO osVO = new OneStopVO();
    	
    	osVO.setSigntype(signType);
		osVO.setSignempid(signEmpId);
		osVO.setSystemkey(systemKey);
		osVO.setWritename(writeEmpName);
		osVO.setWriteempid(writeEmpId);
		osVO.setTitle(title);
		osVO.setUrl(url);
		osVO.setStatus(status);
		
		return osVO;
    }
    
	/**
	 * 점검자 메일 내용 표출용
	 */
	@RequestMapping("/rent/mail/mailViewMonthCheck.do")
    public ModelAndView mailViewMonthCheck(HttpServletRequest request) throws Exception {
    	ModelAndView mv = new ModelAndView(); 
    	
    	try{ 
    		HashMap<String, String> monthApproval_Info = equipManageService.getMonthApproval_Info(String.valueOf(request.getParameter("apm")));
    		
    		mv.setViewName("/rent/mail/mailViewMonthCheck");
    		mv.addObject("monthApproval_Info", monthApproval_Info);
    	}catch(Exception e){
    		e.printStackTrace();
    		mv.setViewName("/error/error");
    	}
    	return mv;
    }
    
    /**
	 * exportXls :  영상관리 엑셀다운로드 
	 * @param kubeDto
	 */
	@RequestMapping("/admin/checkMonthExcelDownload.do")
	public @ResponseBody byte[] checkMonthExcelDownload (EquipManageDto equipManageDto, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {

		response.setHeader("Set-Cookie", "fileDownload=true; path=/");

   		List<HashMap<String, String>> exList = equipManageService.getCheckAppMonthListXls(equipManageDto);
		
		// Excel 셋팅
		List<Object> header = new ArrayList<Object>();
		List<List<Object>> data = new ArrayList<List<Object>>();
		
		String[] keyVal = {"날짜","총 반출(노트북/태블릿)","총 반납(노트북/태블릿)","장기 반출(노트북/태블릿)","장기 반납(노트북/태블릿)","단기 반출(노트북/태블릿)","단기 반납(노트북/태블릿)","점검결과","점검자","파트장","부서장"};
		String tmpDateTime = "";
		
		try{
		    //ROW 생성 LOOP  
		    for(int r=0; r < exList.size();r++){
		    	HashMap<String, String> map = exList.get(r);
		    	
	    		List<Object> obj = new ArrayList<Object>();	
		    	//header setting 
		    	if(r==0){
		    		for(int k = 0; k < keyVal.length; k++){
		    			if(keyVal[k].indexOf("app_datetime") == -1){
			    			header.add(keyVal[k]);
			    			
			    			tmpDateTime = "";
			    			
			    			if(keyVal[k].equals("날짜")){
			    				obj.add(NeoUtil.getDateTmFormat(String.valueOf(map.get(keyVal[k])), "-", "3") + " ~ " + NeoUtil.getDateTmFormat(DateUtil.getLastDayAfterMonth(String.valueOf(map.get(keyVal[k])), 0), "-", "3"));
			    			}else if(keyVal[k].equals("점검자")){
			    				if(StringUtil.isNotEmpty(String.valueOf(map.get("app_datetime1")))){
			    					tmpDateTime = " (" + String.valueOf(map.get("app_datetime1")).substring(0,10) + ")";
			    				}
			    				
			    				obj.add(String.valueOf(map.get(keyVal[k])) + tmpDateTime);
			    			}else if(keyVal[k].equals("파트장")){
			    				if(StringUtil.isNotEmpty(String.valueOf(map.get("app_datetime2")))){
			    					tmpDateTime = " (" + String.valueOf(map.get("app_datetime2")).substring(0,10) + ")";
			    				}
			    				
			    				obj.add(String.valueOf(map.get(keyVal[k])) + tmpDateTime);
			    			}else if(keyVal[k].equals("부서장")){
			    				if(StringUtil.isNotEmpty(String.valueOf(map.get("app_datetime3")))){
			    					tmpDateTime = " (" + String.valueOf(map.get("app_datetime3")).substring(0,10) + ")";
			    				}
			    				
			    				obj.add(String.valueOf(map.get(keyVal[k])) + tmpDateTime);
				    		}else{
			    				obj.add(String.valueOf(map.get(keyVal[k])));
				    		}			    		
		    			}
		    		}
		    	}else{
			    	//data setting 
		    		for(int k = 0; k < keyVal.length; k++){
		    			
		    			tmpDateTime = "";
		    			
		    			if(keyVal[k].equals("날짜")){
		    				obj.add(NeoUtil.getDateTmFormat(String.valueOf(map.get(keyVal[k])), "-", "3") + " ~ " + NeoUtil.getDateTmFormat(DateUtil.getLastDayAfterMonth(String.valueOf(map.get(keyVal[k])), 0), "-", "3"));
		    			}else if(keyVal[k].equals("점검자")){
		    				if(StringUtil.isNotEmpty(String.valueOf(map.get("app_datetime1")))){
		    					tmpDateTime = " (" + String.valueOf(map.get("app_datetime1")) + ")";
		    				}
		    				
		    				obj.add(String.valueOf(map.get(keyVal[k])) + tmpDateTime);
		    			}else if(keyVal[k].equals("파트장")){
		    				if(StringUtil.isNotEmpty(String.valueOf(map.get("app_datetime2")))){
		    					tmpDateTime = " (" + String.valueOf(map.get("app_datetime2")) + ")";
		    				}
		    				
		    				obj.add(String.valueOf(map.get(keyVal[k])) + tmpDateTime);
		    			}else if(keyVal[k].equals("부서장")){
		    				if(StringUtil.isNotEmpty(String.valueOf(map.get("app_datetime3")))){
		    					tmpDateTime = " (" + String.valueOf(map.get("app_datetime3")) + ")";
		    				}
		    				
		    				obj.add(String.valueOf(map.get(keyVal[k])) + tmpDateTime);
			    		}else{
		    				obj.add(String.valueOf(map.get(keyVal[k])));
			    		}
		    		}
		    	}
		    	
	    		data.add(obj);
		    }
		}catch(Exception e){
			e.printStackTrace();
		}
	
		ExcelUtil excel = new ExcelUtil(header ,data);
		excel.setSheetName("sheet1");
		excel.setWidth(6000);
		
		byte[] bytes = excel.makeExcel();
		
        String userAgent = request.getHeader("User-Agent");
        boolean br = userAgent.indexOf("Chrome") > -1;
        
        String fileName = "점검대장_" + DateUtil.getCurrentDateTime();
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
	
	@RequestMapping("/admin/epLogList.do")
	public ModelAndView epLogList(HttpServletRequest req, HttpServletResponse res, OneStopLogVO oneStopVo) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		List<HashMap<String, String>> list = equipManageService.oneStopLogList(oneStopVo);
		int listCnt = equipManageService.oneStopLogListCnt(oneStopVo);
		
		mv.setViewName("/rent/admin/oneStopList");
		mv.addObject("resultSet", list);
		mv.addObject("totalCnt", listCnt);
		mv.addObject("paging", oneStopVo);
		return mv;
	}

	@RequestMapping("/admin/epLogDetail.do")
	public ModelAndView epLogDetailt(HttpServletRequest req, HttpServletResponse res, OneStopLogVO oneStopVo) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		HashMap<String, String> view = equipManageService.oneStopLogDetail(oneStopVo);
		
		mv.setViewName("/rent/admin/oneStopDetail");
		mv.addObject("resultSet", view);
		mv.addObject("paging", oneStopVo);
		return mv;
	}
	
	/*파일 제거*/
	@RequestMapping("/removeRentFile.do")
	public void AjaxRentFileremove(HttpServletRequest req, HttpServletResponse res, EquipManageDto equipManageDto) throws Exception{
		String retVal = "false";
		
		try {
			int RENT_SECURITY_SEQ = Integer.parseInt(req.getParameter("RENT_SECURITY_SEQ"));
			String appno = req.getParameter("appno");
			
			EquipManageDto selectFile = equipManageService.selectRentFile(appno);
			
			if(selectFile != null) {
				File file = new File(selectFile.getRENT_SECURITY_phycalPath()); 
				if(file.exists()) {
					file.delete();
				}
				equipManageService.AjaxRentFileremove(RENT_SECURITY_SEQ);
			}
			retVal = "true";
		} catch (Exception e) {
			e.printStackTrace();			
		}finally {
			res.getWriter().write(retVal);
		}
	}
	/*보안서약서 파일 다운로드*/
	@RequestMapping("/contentsSecurityDown.do")
	public ModelAndView contentsSecurityDown(HttpServletRequest req, ContentsDto contentsDto) throws Exception {
		ModelAndView mv = new ModelAndView();
		String full_Path = "D:/security/security.hwp";
		try{
			File downloadFile = new File(full_Path);
			
			mv.setView(dowoloadView);
			mv.addObject("downloadFile", downloadFile);
			mv.addObject("fileName", "security.hwp");
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {}
		
		return mv;
	}
	
}
