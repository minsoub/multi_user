package kr.co.neodreams.multi_user.base.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class BaseController{

    protected Logger log = LoggerFactory.getLogger(this.getClass());    // Log

    public static String SESS_EMPNO = null;
    public static String SESS_USER_NAME = null;
    public static String SESS_USER_TELNO = null;
    public static String SESS_DEPT_NAME = null;

    //page_log 관리 대상 url
    public static HashMap<String, String> URL = new HashMap<String, String>();

    //대여, 게시 접근 사용자 empno 관리
    public static HashMap<String, String> MENU_EMPNO = new HashMap<String, String>();
    
    public BaseController(){
        URL.put("/kepcnNewsList.do","");
        URL.put("/promotionalVideoList.do","");
        URL.put("/kepcnPlanList.do","");
        URL.put("http://cello.hq:8888/EBBS/brd_list.php?menuid=A1542","");
        URL.put("/equipManual.do","");
        URL.put("/equipRentList.do","");
        URL.put("/appList.do","");
        URL.put("/basketList.do","");
        URL.put("/displayBoardInfo.do","");
        URL.put("/displayBoardRequest.do","");
        URL.put("/displayBoardProgress.do","");
        URL.put("/contentsInfo.do","");
        URL.put("/contentsRequest.do","");
        URL.put("/contentsProgress.do","");
        URL.put("/mypageContentsList.do","");
        URL.put("/mypageDisplayBoardList.do","");
        URL.put("/mypageStatistics.do","");
        URL.put("/powerStatus.do","");
        URL.put("/businessLocation.do","");
        URL.put("/dustLocation.do","");
        URL.put("/scheduling.do","");
        URL.put("/businessStatus.do","");
        URL.put("/kepcnRequest.do","");
        URL.put("/issueTalkList.do","");
        URL.put("/access.do","");
        URL.put("/longTermUser.do","");
        URL.put("/kube.do","");
        URL.put("/kepcnConferenceList.do","");
        
        //20171211 추가
        MENU_EMPNO.put("91113015", "");
        MENU_EMPNO.put("96108958", "");
        MENU_EMPNO.put("02101432", "");
        MENU_EMPNO.put("03101339", "");
        MENU_EMPNO.put("16991374", "");
        MENU_EMPNO.put("16991375", "");
        MENU_EMPNO.put("15100435", "");
        MENU_EMPNO.put("16991373", "");
        MENU_EMPNO.put("16991541", "");
        MENU_EMPNO.put("93200071", "");
        MENU_EMPNO.put("12103301", "");
        MENU_EMPNO.put("98106260", "");
        MENU_EMPNO.put("06101909", "");
        MENU_EMPNO.put("08100047", "");
        MENU_EMPNO.put("16202428", "");
        MENU_EMPNO.put("97112215", "");
        MENU_EMPNO.put("12103301", "");
        MENU_EMPNO.put("nojohq03", "");
    }

    public static void setSession(HttpServletRequest request, String empno, String user_name){

        HttpSession session = request.getSession();
        session.setAttribute("SESS_EMPNO", empno);
        session.setAttribute("SESS_USER_NAME", user_name);
        session.setMaxInactiveInterval(60 * 30); //30분간 유지

        SESS_EMPNO = (String) session.getAttribute("SESS_EMPNO");
        SESS_USER_NAME = (String) session.getAttribute("SESS_USER_NAME");
    }
    
    public static void setSession(HttpServletRequest request, String empno, HashMap<String, String> user_info, ArrayList<HashMap<String, String>> admInfo, int serviceAdmInfo){
    	
    	HttpSession session = request.getSession();
    	session.setAttribute("SESS_EMPNO", empno);
    	session.setAttribute("SESS_USER_NAME", user_info.get("name"));
    	session.setAttribute("SESS_USER_TELNO", user_info.get("telno"));
    	session.setAttribute("SESS_USER_INFO", user_info);
    	session.setAttribute("SESS_ADMIN_INFO", admInfo);
    	//ASP 에서 사용하는 사용자 정보, 컨텐츠 제작요청, 전광판 게시요청에서 사용
    	session.setAttribute("SESS_SERVICE_ADMIN_INFO", serviceAdmInfo);
    	session.setMaxInactiveInterval(60 * 30); //30분간 유지
    	
    	SESS_EMPNO = (String) session.getAttribute("SESS_EMPNO");
    	SESS_USER_NAME = (String) session.getAttribute("SESS_USER_NAME");
    	SESS_USER_TELNO = (String) session.getAttribute("SESS_USER_TELNO");
    }

    /**
    * 사용안하는 메소드. 맞춤형 디스플레이 메뉴 없어짐
    */
    public static void setSession(HttpServletRequest request, String empno, HashMap<String, String> user_info, boolean custom_display_auth){

        HttpSession session = request.getSession();
        session.setAttribute("SESS_EMPNO", empno);
        session.setAttribute("SESS_USER_NAME", user_info.get("name"));
        session.setAttribute("SESS_CUSTOM_DISPLAY_AUTH", String.valueOf(custom_display_auth));
        session.setMaxInactiveInterval(60 * 30); //30분간 유지

        SESS_EMPNO = (String) session.getAttribute("SESS_EMPNO");
        SESS_USER_NAME = (String) session.getAttribute("SESS_USER_NAME");
    }

    public static void setSession(HttpServletRequest request){
        HttpSession session = request.getSession();

        SESS_EMPNO = (String) session.getAttribute("SESS_EMPNO");
        SESS_USER_NAME = (String) session.getAttribute("SESS_USER_NAME");
        SESS_USER_TELNO = (String) session.getAttribute("SESS_USER_TELNO");
    }
}
