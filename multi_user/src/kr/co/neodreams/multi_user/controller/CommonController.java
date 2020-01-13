package kr.co.neodreams.multi_user.controller;


import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.CommonUtil;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.DateUtil;
import kr.co.neodreams.multi_user.common.NeoUtil;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.common.TableDataInit;
import kr.co.neodreams.multi_user.common.sms.SendSMS;
import kr.co.neodreams.multi_user.dto.CommonDto;
import kr.co.neodreams.multi_user.dto.RentDto;
import kr.co.neodreams.multi_user.service.CommonService;
import kr.co.neodreams.multi_user.service.PowerstatusService;
import net.arnx.jsonic.JSON;

@Controller
public class CommonController extends BaseController{


    @Autowired
    CommonService commonService;

    @Autowired
    PowerstatusService powerstatusService;

    @RequestMapping("/media_02.do")
    public ModelAndView media_02(CommonDto commonDto, HttpServletRequest request) throws Exception{

        ModelAndView mv = new ModelAndView();

        try{

            List<CommonDto> static_idx_list = commonService.getStatic_idx();

            if(static_idx_list == null
                    || static_idx_list.size() == 0){
                commonService.insertNewStatic_idx();
            }else{
                commonService.updateStatic_count(static_idx_list.get(0).getStatic_idx());
            }

            String Rs_num = request.getParameter("num");
            String Rs_title = request.getParameter("Rs_title");
            String DirName = request.getParameter("DirName");

            if(CommonUtil.isNumber(Rs_num)){
                commonService.updateVisitedCount(Rs_num);

                mv.addObject("sess_id", SESS_EMPNO);
                mv.addObject("sess_name", SESS_USER_NAME);

                if("12815".equals(Rs_num.trim())){
                    commonService.insertSpecialCount(SESS_EMPNO);
                }

                if(StringUtil.isNotEmpty(DirName)){
                    //포인트 관련
                    if(StringUtil.isNotEmpty(SESS_EMPNO.trim())){

                        HashMap<Object, Object> proc_map = new HashMap<>();
                        proc_map.put("USER_ID", SESS_EMPNO.trim());
                        proc_map.put("NUMBER", Rs_num);
                        proc_map.put("M_Table", "vod_s1");
                        proc_map.put("Flag", "read");
                        proc_map.put("Point", Constants.getPoint(DirName.trim()));
                        proc_map.put("DirName", DirName);

                        commonService.Proc_mileage_insert(proc_map);
                    }
                    //포인트 종료
                }

                CommonDto vod_info = commonService.getVod_s1_info(Rs_num);

                String Re_content = vod_info.getContent();
                String Rs_dir01 = vod_info.getRe_Step();
                String pdsFile = vod_info.getPdsFile();

                if("17".equals(Rs_dir01)){
                    Rs_dir01 = "1";
                }

                if(StringUtil.isNotEmpty(Rs_title)
                        && Rs_title.length() > 25){
                    Rs_title = Rs_title.substring(0, 25) + "..";
                }

                HashMap<String, String> multiUrl = Constants.getMultiUrl(Rs_num, Rs_dir01);

                String view_File = multiUrl.get("mmsURL") + multiUrl.get("pdsFile");

                mv.addObject("Rs_num", Rs_num);
                mv.addObject("Rs_title", Rs_title);
                mv.addObject("contentID", Rs_num);
                mv.addObject("Re_content", Re_content);
                mv.addObject("Rs_dir01", Rs_dir01);
                mv.addObject("pdsFile", pdsFile);
                mv.addObject("view_File", view_File);

                //콘텐츠 중분류가 "KEPCN-NEW" 가 아닌 나머지 경우
                if(!"9".equals(Rs_dir01)){

                    List<CommonDto> commentList = commonService.getWin_list_sp(Rs_num);

                    mv.setViewName("/popup/media_02");
                    mv.addObject("commentList", commentList);

                }else{
                    //콘텐츠 중분류가 "KEPCN-NEW" 인 경우
                    String m_name = vod_info.getSubject();
                    String Re_step = Rs_dir01;
                    String Re_level = vod_info.getRe_level();

                    //☞ Re_level : 2008.07.25 5번 부터 추가됨.
                    //1 : KEPCN-NEWS
                    //2 : KEPCN 영어방송
                    //4 : 통일염원사업소릴레이
                    //5 : KEP-CN 포커스
                    //6 : KEP-CN이 간다
                    //7 : 이달의 전력사
                    //8 : KEP-CN 영상뉴스
                    //9 : 4시의 쉼터
                    //10 : 음악이 흐르는 퇴근 길
                    //11 : KEP-CN 특별 좌담회
                    //13 : 우리 사업소를 소개합니다

                    //중분류가 "KEPCN-NEW" 이며, 소분류가 "외국어 Reports" 가 아닌 나머지 경우만 "media_02_vod_01.jsp" 페이지로 이동
                    if("9".equals(Re_step) && ("1".equals(Re_level) || "4".equals(Re_level) || "5".equals(Re_level)
                            || "6".equals(Re_level) || "7".equals(Re_level) || "8".equals(Re_level)
                            || "9".equals(Re_level) || "10".equals(Re_level) || "11".equals(Re_level)
                            || "13".equals(Re_level) || "14".equals(Re_level) || "15".equals(Re_level)
                            || "16".equals(Re_level) || "17".equals(Re_level) || "18".equals(Re_level) || "19".equals(Re_level) || "20".equals(Re_level))){

                        if(StringUtil.isEmpty(m_name)){
                            m_name = "Kepn_News";
                        }

                            String URL = "";

                            if("1".equals(Re_step) || "17".equals(Re_step)){
                                URL = "/media/seminar.asp";
                            }else if("2".equals(Re_step)){
                                URL = "/media/language.asp";
                            }else if("3".equals(Re_step)
                                        || "4".equals(Re_step)
                                        || "5".equals(Re_step)
                                        || "6".equals(Re_step)
                                        || "7".equals(Re_step)
                                        || "8".equals(Re_step)){
                                URL = "/media/culture.asp";
                            }else if("13".equals(Re_step)){
                                URL = "/media/info.asp";
                            }else if("9".equals(Re_step)){
                                URL = "/live/kepcn.asp";
                            }

                            List<CommonDto> commentList = commonService.getKepcn_comment_sp(Rs_num);

                            mv.setViewName("/popup/media_02_vod_1");
                            mv.addObject("m_name", m_name);//jsp에서 사용 안함
                            mv.addObject("URL", URL);
                            mv.addObject("cat_name", vod_info.getName());
                            mv.addObject("dir01", Re_step);
                            mv.addObject("dir02", Re_level);
                            mv.addObject("commentList", commentList);
                            mv.addObject("vod_info", vod_info);

                    }else{
                        CommonDto kepcn_news_file = commonService.getKepcn_news_file(Rs_num);

                        String j_pdsFile = kepcn_news_file.getJ_pdsFile();
                        String j_mp3 = kepcn_news_file.getJ_mp3();

                        List<CommonDto> commentList = commonService.getKepcn_comment_sp(Rs_num);

                        mv.setViewName("/popup/media_02_vod");
                        mv.addObject("j_pdsFile", j_pdsFile);
                        mv.addObject("j_mp3", j_mp3);
                        mv.addObject("commentList", commentList);
                    }
                }

            }else{
                mv.setViewName("/error/error");
            }
        }catch(Exception e){
            e.printStackTrace();
            mv.setViewName("/error/error");
        }
        return mv;
    }
    
    @RequestMapping("/scenario.do")
    public ModelAndView scenario(CommonDto commonDto, HttpServletRequest request) throws Exception{
    	
    	ModelAndView mv = new ModelAndView();
    	
    	try{
    		
    		String Rs_num = request.getParameter("num");
    		
    		if(CommonUtil.isNumber(Rs_num)){
    			mv.addObject("sess_id", SESS_EMPNO);
    			mv.addObject("sess_name", SESS_USER_NAME);

    			CommonDto vod_info = commonService.getVod_s1_info(Rs_num);
    			
    			mv.addObject("vod_info", vod_info);
				mv.setViewName("/scenario");
    		}else{
    			mv.setViewName("/error/error");
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    		mv.setViewName("/error/error");
    	}
    	return mv;
    }


    @RequestMapping("media_02_ok.do")
    @ResponseBody
    public void media_02_ok(CommonDto commonDto, BindingResult result, HttpServletResponse response)throws Exception{

        boolean success = false;

        String f_mode = commonDto.getF_mode();

        try{

            commonDto.setK_date(NeoUtil.getDateTmFormat(DateUtil.getCurrentDate(), "-", "3"));

            if("insert".equals(f_mode)){
                if(CommonUtil.isNumber(commonDto.getRs_num())){

                    String k_num = commonService.insertMedia_02_ok(commonDto);

                    if(StringUtil.isNotEmpty(SESS_EMPNO)){

                        HashMap<Object, Object> proc_map = new HashMap<>();
                        proc_map.put("USER_ID", SESS_EMPNO.trim());
                        proc_map.put("NUMBER", commonDto.getRs_num());
                        proc_map.put("M_Table", "Kepcn_comment");
                        proc_map.put("Flag", "Writer");
                        proc_map.put("Point", Constants.getPoint(commonDto.getDirName().trim()));
                        proc_map.put("DirName", commonDto.getDirName());

                        commonService.Proc_mileage_insert(proc_map);
                    }

                    commonDto.setK_num(k_num);

                    success = true;
                }else{
                    //no action
                }
            }else if("del".equals(f_mode)){
                if(CommonUtil.isNumber(commonDto.getK_num())){

                    commonService.deleteKepcn_comment(commonDto.getK_num());

                    if(StringUtil.isNotEmpty(SESS_EMPNO)){
                        commonDto.setK_id(commonDto.getK_id().trim());
                        commonService.deleteMileage(commonDto);
                    }

                    success = true;
                }else{
                    //no action
                }
            }else{
                success = false;
            }
        } catch(Exception e){
            e.printStackTrace();

            success = false;
        } finally{

            if(!success){
                response.getWriter().write("false");
            }else{
                if("insert".equals(f_mode)){
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write(JSON.encode(commonDto));
                }else if("del".equals(f_mode)){
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write("true");
                }
            }
        }
    }

    @RequestMapping("media_02_write_ok.do")
    @ResponseBody
    public void media_02_write_ok(CommonDto commonDto, BindingResult result, HttpServletResponse response)throws Exception{

        boolean success = false;

        String f_mode = commonDto.getF_mode();

        try{

            commonDto.setK_date(NeoUtil.getDateTmFormat(DateUtil.getCurrentDate(), "-", "3"));

            if("insert".equals(f_mode)){
                if(CommonUtil.isNumber(commonDto.getRs_num())){

                    commonService.insertMedia_02_write_ok(commonDto);

                    if(StringUtil.isNotEmpty(SESS_EMPNO)){

                        HashMap<Object, Object> proc_map = new HashMap<>();
                        proc_map.put("USER_ID", SESS_EMPNO.trim());
                        proc_map.put("NUMBER", commonDto.getRs_num());
                        proc_map.put("M_Table", "vod_s1_comment");
                        proc_map.put("Flag", "Writer");
                        proc_map.put("Point", Constants.getPoint(commonDto.getDirName().trim()));
                        proc_map.put("DirName", commonDto.getDirName());

                        commonService.Proc_mileage_insert(proc_map);
                    }

                    success = true;
                }else{
                    //no action
                }

                /*
            }else if("del".equals(f_mode)){
                if(CommonUtil.isNumber(commonDto.getK_num())){

                commonService.deleteKepcn_comment(commonDto.getK_num());

                    if(StringUtil.isNotEmpty(SESS_EMPNO)){
                        commonDto.setK_id(commonDto.getK_id().trim());
                        commonService.deleteMileage(commonDto);
                    }

                        success = true;
                    }else{
                        //no action
                    }
            */

            }else{
                success = false;
            }
        } catch(Exception e){
            e.printStackTrace();

            success = false;
        } finally{

            if(!success){
                response.getWriter().write("false");
            }else{
                if("insert".equals(f_mode)){
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write(JSON.encode(commonDto));
                }
                /*
                else if("del".equals(f_mode)){
                    response.setCharacterEncoding("utf-8");
                    response.getWriter().write("true");
                }
                */
            }
        }
    }

    public void insertPageLog(HttpServletRequest request, CommonService commonService){

        String uri = request.getRequestURI();

        if(URL.containsKey(uri)){

            try {
                HashMap<String, String> page_log = new HashMap<String, String>();

                page_log.put("logical_url", uri);
                page_log.put("empno", SESS_EMPNO);
                page_log.put("ip_addr", CommonUtil.getIPAddr());

                commonService.insertPageLog(page_log);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

    public HashMap<String, String> getBasicUserInfo(String empno, CommonService commonService){

        HashMap<String, String> user_info = null;

        try {
            user_info = commonService.getBasicUserInfo(empno);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return user_info;
    }
    
    public ArrayList<HashMap<String, String>> getAdmInfo(String empno, CommonService commonService){
    	
    	ArrayList<HashMap<String, String>> admInfo = null;
    	
    	try {
    		admInfo = commonService.getAdmInfo(empno);
    	} catch (Exception e) {
    		// TODO Auto-generated catch block
    		e.printStackTrace();
    	}
    	
    	return admInfo;
    }

    public int getServiceAdmInfo(String empno, CommonService commonService){
    	
    	int admInfo = 0;
    	
    	try {
    		admInfo = commonService.getServiceAdmInfo(empno);
    	} catch (Exception e) {
    		// TODO Auto-generated catch block
    		e.printStackTrace();
    	}
    	
    	return admInfo;
    }

    @RequestMapping("/insertRentalPageLog.do")
    public void insertRentalPageLog(HttpServletRequest request){

        String url = request.getParameter("url");

        if(URL.containsKey(url)){

            try {
                HashMap<String, String> page_log = new HashMap<String, String>();

                page_log.put("logical_url", url);
                page_log.put("empno", SESS_EMPNO);
                page_log.put("ip_addr", CommonUtil.getIPAddr());

                commonService.insertPageLog(page_log);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

    @RequestMapping("/dataGet.do")
    public synchronized void dataGet(HttpServletResponse response) throws Exception{

        System.out.println("#######################dataGet() start#######################");
        System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
        System.out.println("#######################dataGet() start#######################");

        HashMap<String, String> hashMap = new HashMap<String, String>();
        String outString = "";
        String result = "N";

        hashMap.put("schedule_date", DateUtil.getCurrentDateTime());

        PrintWriter out = response.getWriter();

        try{
            out.println("dataGet.do start::::::::::::::");

        }catch(Exception e){
            e.printStackTrace();
        }

        try{
            TableDataInit init = new TableDataInit();

            ArrayList<String> values = init.getDept_Data("dept_select");

            if(values != null){

                commonService.deleteDeptTMP();

                for(int i = 0; i < values.size(); i++){
                    commonService.insertDeptTMP(values.get(i));
                }

                outString = "dept_tmp success!!! 33% process";

                System.out.println(outString);

                values = init.getUser_Data("user_select");

                if(values != null){

                    commonService.deleteUserTMP();

                    for(int i = 0; i < values.size(); i++){
                        commonService.insertUserTMP(values.get(i));
                    }

                    outString = "user_tmp success!!! 66% process";

                    System.out.println(outString);

                    values = init.getDetail_Data("detail_select");

                    if(values != null){

                        commonService.deleteDetailTMP();

                        for(int i = 0; i < values.size(); i++){
                            commonService.insertDetailTMP(values.get(i));
                        }

                        outString = "detail_tmp success!!! 100% process";

                        System.out.println(outString);

                        result = "Y";
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            outString = e.toString();
            result = "N";
        }finally{

            try{
                System.out.println("#######################dataGet() end#######################");
                System.out.println(DateUtil.getCurrentDateTime() + "::::" + outString);
                System.out.println("#######################dataGet() end#######################");

                hashMap.put("log_desc", outString);
                hashMap.put("result_value", result);

                commonService.insertDataSetResult(hashMap);

            }catch(Exception e){
                e.printStackTrace();

            }finally{
                hashMap.clear();

                out = response.getWriter();

                try{
                    out.println(outString);

                }catch(Exception e){
                    e.printStackTrace();

                }finally{
                    out.flush();
                    out.close();
                }
            }
        }
    }

    @RequestMapping("/dataSet.do")
    public synchronized void dataSet(HttpServletResponse response) throws Exception{

        System.out.println("#######################dataSet() start#######################");
        System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
        System.out.println("#######################dataSet() start#######################");

        String outString = "false";

        PrintWriter out = response.getWriter();

        try{
            out.println("dataSet.do start::::::::::::::");

        }catch(Exception e){
            e.printStackTrace();
        }

        try{
            String result = commonService.getDataSetLastLog();

            if(StringUtil.isEmpty(result)
                    || "Y".equals(result)){
                commonService.insertAllDept_User_Data();

                outString = "success";

                try{
                    commonService.updateDataSetLastLog();
                }catch(Exception e){
                    e.printStackTrace();
                }
            }else{
                if("S".equals(result)){
                    outString = "last data set is Success";
                }else{
                    outString = "last data set is error";
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            outString = "dataSet() process error";
        }finally{

            out = response.getWriter();

            try{
                out.println(outString);

            }catch(Exception e){
                e.printStackTrace();

            }finally{
                out.flush();
                out.close();
            }

            System.out.println("#######################dataSet() end#######################");
            System.out.println(DateUtil.getCurrentDateTime() + "::::" + outString);
            System.out.println("#######################dataSet() end#######################");
        }
    }

    @RequestMapping("/dataGet_nomu.do")
    public synchronized void dataGetNomu(HttpServletResponse response) throws Exception{

        System.out.println("#######################dataGetNomu() start#######################");
        System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
        System.out.println("#######################dataGetNomu() start#######################");

        HashMap<String, String> hashMap = new HashMap<String, String>();
        String outString = "";
        String result = "N";

        hashMap.put("schedule_date", DateUtil.getCurrentDateTime());

        PrintWriter out = response.getWriter();

        try{
            out.println("dataGet_nomu.do start::::::::::::::");

        }catch(Exception e){
            e.printStackTrace();
        }

        try{
            TableDataInit init = new TableDataInit("nomu");

            ArrayList<String> values = init.getUser_Data_nomu("user_select_nomu");

            if(values != null){

                commonService.deleteUserNomuTMP();

                for(int i = 0; i < values.size(); i++){
                    commonService.insertUserNomuTMP(values.get(i));
                }

                outString = "user_nomu_tmp success!!! 100% process";

                System.out.println(outString);

                result = "Y";
            }
        }catch (Exception e){
            e.printStackTrace();
            outString = e.toString();
            result = "N";
        }finally{

            try{
                System.out.println("#######################dataGetNomu() end#######################");
                System.out.println(DateUtil.getCurrentDateTime() + "::::" + outString);
                System.out.println("#######################dataGetNomu() end#######################");

                hashMap.put("log_desc", outString);
                hashMap.put("result_value", result);

                commonService.insertDataSetResultNomu(hashMap);

            }catch(Exception e){
                e.printStackTrace();

            }finally{
                hashMap.clear();

                out = response.getWriter();

                try{
                    out.println(outString);

                }catch(Exception e){
                    e.printStackTrace();

                }finally{
                    out.flush();
                    out.close();
                }
            }
        }
    }

    @RequestMapping("/dataSet_nomu.do")
    public synchronized void dataSetNomu(HttpServletResponse response) throws Exception{

        System.out.println("#######################dataSetNomu() start#######################");
        System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
        System.out.println("#######################dataSetNomu() start#######################");

        String outString = "false";

        PrintWriter out = response.getWriter();

        try{
            out.println("dataSet_nomu.do start::::::::::::::");

        }catch(Exception e){
            e.printStackTrace();
        }

        try{
            String result = commonService.getDataSetLastLogNomu();

            if(StringUtil.isEmpty(result)
                    || "Y".equals(result)){
                commonService.insertUser_NomuData();

                outString = "success";

                try{
                    commonService.updateDataSetLastLogNomu();
                }catch(Exception e){
                    e.printStackTrace();
                }
            }else{
                if("S".equals(result)){
                    outString = "last data set is Success";
                }else{
                    outString = "last data set is error";
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            outString = "dataSetNomu() process error";
        }finally{

            out = response.getWriter();

            try{
                out.println(outString);

            }catch(Exception e){
                e.printStackTrace();

            }finally{
                out.flush();
                out.close();
            }

            System.out.println("#######################dataSetNomu() end#######################");
            System.out.println(DateUtil.getCurrentDateTime() + "::::" + outString);
            System.out.println("#######################dataSetNomu() end#######################");
        }
    }
    
    @RequestMapping("/rentalSendSMS.do")
    public synchronized void rentalSendSMS(HttpServletRequest request, HttpServletResponse response) throws Exception{

        System.out.println("#######################sendSMS() start#######################");
        System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
        System.out.println("#######################sendSMS() start#######################");

        String outString = "";

        PrintWriter out = response.getWriter();

        try{
            out.println("rentalSendSMS.do start::::::::::::::");

        }catch(Exception e){
            e.printStackTrace();
        }

        try{
            //문자 나가는지 테스트 하려면 받는 사람의 hp를 아래 파라메터에 담아 날려준다. test_sms_hp=01090718563
            String test_sms_hp = request.getParameter("test_sms_hp");

            if(StringUtil.isEmpty(test_sms_hp)){
                //real sms_send
                List<RentDto> targetList = commonService.getRentalSendSMSTargetList();

                if(targetList != null
                        && targetList.size() > 0){
                    SendSMS sms = SendSMS.getInstance();
                    sms.rentalSendSMS(new BigInteger(DateUtil.getCurrentDateTime()), "장비 반납 하세요", targetList);
                }else{
                    outString = "dept move data is null. this is ok";
                }
            }else{
                //test sms_send
                RentDto testDto = new RentDto();
                testDto.setHp(test_sms_hp);

                List<RentDto> targetList = new ArrayList<RentDto>();
                targetList.add(testDto);

                SendSMS sms = SendSMS.getInstance();
                sms.rentalSendSMS(new BigInteger(DateUtil.getCurrentDateTime()), "장비 반납 하세요", targetList);
            }
        }catch (Exception e){
            e.printStackTrace();
            outString = e.toString();
        }finally{

            System.out.println("#######################sendSMS() end#######################");
            System.out.println(DateUtil.getCurrentDateTime() + "::::" + outString);
            System.out.println("#######################sendSMS() end#######################");

            out = response.getWriter();

            try{
                out.println(outString);

            }catch(Exception e){
                e.printStackTrace();

            }finally{
                out.flush();
                out.close();
            }
        }
    }

    public boolean custom_display_auth(HashMap<String, String> user_info){

        boolean auth_tf = false;

        try{
            String dept_name_1depth = (String) user_info.get("dept_name_1depth");

            BufferedReader fileReader = new BufferedReader(new InputStreamReader(new FileInputStream(Constants.CUSTOM_DISPLAY_JSON_FILE),"UTF-8"));

            JSONParser p = new JSONParser();

            JSONObject jsonObj   = (JSONObject)p.parse(fileReader);

            JSONArray cdGroup = (JSONArray) jsonObj.get("place_dept");

            if(cdGroup != null
                    && cdGroup.size() > 0){

                int cdGroupSize = cdGroup.size();

                for(int i = 0; i < cdGroupSize; i++){

                    JSONObject cdinfo = (JSONObject) cdGroup.get(i);

                    if(cdinfo.get("name").equals(dept_name_1depth)){
                        auth_tf = true;
                    }
                }
            }else{
                System.out.println("custom_display_auth err........" + SESS_EMPNO);
            }
        }catch(Exception e){
            e.printStackTrace();
        }

        return auth_tf;
    }
}