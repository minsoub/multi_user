package kr.co.neodreams.multi_user.base.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.controller.CommonController;
import kr.co.neodreams.multi_user.service.CommonService;

public class ServiceInitInterceptor extends HandlerInterceptorAdapter {

	CommonController commonController = new CommonController();

	@Autowired
	CommonService commonService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		try{
			if(!Constants.TEST_MODE){
				if (checkSession(request)) {
					//세션이 있는 경우
					System.out.println("session ok");
					
                    
                    //전광판 게시, 컨텐츠 제작, 장비대여 메뉴 접근 컨트롤
                    String uriChkVal = "true";
                    
                    uriChkVal = uriChk(request);
                    
                    if("true".equals(uriChkVal)){
                        try{
                            commonController.insertPageLog(request, commonService);
                        }catch(Exception e){
                            e.printStackTrace();
                        }
                    }else if("saupso".equals(uriChkVal)){
                        
                        response.setHeader("Content-Type", "text/html; charset=utf-8");
                        response.getWriter().write("<script>alert('콘텐츠 제작(게시요청/장비대여)은 본사만 지원이 가능합니다.');history.back(-1);</script>");
                        
                        return false;
					}
					
					return true;
				} else {
					//세션이 없는 경우
					
					//테스트용. 임의의 사번으로 로그인하기 위해 처리. ?empno=임의사번
					//empno = "ex190126";
					//empno = "04102746";
					//empno = "02100371";
					//empno = "94108551";
					String empno = request.getParameter("empno");
					
					if(StringUtil.isEmpty(empno)){
						//일반적인 페이지 접근. 일반 사용자가 url만 치고 들어온 경우
						empno = getAccessEmpno(request);
						
						// 쿠키에서 사번 가져오는 로직 추가..가져오면 setSession(HttpServletRequest request,
						// String empno, String user_name) 호출
						if (StringUtil.isNotEmpty(empno)) {
							
							HashMap<String, String> user_info = commonController.getBasicUserInfo(empno,commonService);
							ArrayList<HashMap<String, String>> admInfo = commonController.getAdmInfo(empno,commonService);
							int serviceAdmInfo = commonController.getServiceAdmInfo(empno,commonService);
							
							if(user_info != null){
								
								//맞춤형 디스플레이 메뉴 없어짐
								//boolean custom_display_auth = commonController.custom_display_auth(user_info);
								//BaseController.setSession(request, empno, user_info, custom_display_auth);
								
								BaseController.setSession(request, empno, user_info, admInfo, serviceAdmInfo);
								
								System.out.println("session make ok");
								
                                
                                //전광판 게시, 컨텐츠 제작, 장비대여 메뉴 접근 컨트롤
                                String uriChkVal = "true";
                                
                                uriChkVal = uriChk(request);
                                
                                if("true".equals(uriChkVal)){
                                    try{
                                        commonController.insertPageLog(request, commonService);
                                    }catch(Exception e){
                                        e.printStackTrace();
                                    }
                                }else if("saupso".equals(uriChkVal)){
                                    
                                    response.setHeader("Content-Type", "text/html; charset=utf-8");
                                    response.getWriter().write("<script>alert('콘텐츠 제작(게시요청/장비대여)은 본사만 지원이 가능합니다.');history.back(-1);</script>");
                                    
                                    return false;
								}
								
								/*관리자 세션 체크*/
								
								
								
								return true;
							}else{
								response.sendRedirect("/jsp/error/error.jsp");
								return false;
							}
						} else {
							response.sendRedirect("/jsp/error/error.jsp");
							return false;
						}
					}else{
						//테스트용. 임의의 사번으로 로그인하기 위해 처리. ?empno=임의사번
						HashMap<String, String> user_info = commonController.getBasicUserInfo(empno,commonService);
						ArrayList<HashMap<String, String>> admInfo = commonController.getAdmInfo(empno,commonService);
						int serviceAdmInfo = commonController.getServiceAdmInfo(empno,commonService);
						
						if(user_info != null){
							
							//맞춤형 디스플레이 메뉴 없어짐
							//boolean custom_display_auth = commonController.custom_display_auth(user_info);
							//BaseController.setSession(request, empno, user_info, custom_display_auth);
							
							BaseController.setSession(request, empno, user_info, admInfo, serviceAdmInfo);
							
							System.out.println("session make ok");
							
                            
                            //전광판 게시, 컨텐츠 제작, 장비대여 메뉴 접근 컨트롤
                            String uriChkVal = "true";
                            
                            uriChkVal = uriChk(request);
                            
                            if("true".equals(uriChkVal)){
                                try{
                                    commonController.insertPageLog(request, commonService);
                                }catch(Exception e){
                                    e.printStackTrace();
                                }
                            }else if("saupso".equals(uriChkVal)){
                                
                                response.setHeader("Content-Type", "text/html; charset=utf-8");
                                response.getWriter().write("<script>alert('콘텐츠 제작(게시요청/장비대여)은 본사만 지원이 가능합니다.');history.back(-1);</script>");
                                
                                return false;
							}
							
							return true;
						}else{
							response.sendRedirect("/jsp/error/error.jsp");
							return false;
						}
					}
				}
			}else{
				
				String empno = request.getParameter("empno");
				
				if (StringUtil.isEmpty(empno) 
						&& checkSession(request)) {
					//세션이 있는 경우
					System.out.println("session ok");
					
					return true;
				}else{
					
					if(StringUtil.isEmpty(empno)){
						//테스트 서버에서 사용하는 로그인 로직
						empno = "ex190126";
					}
					
					//테스트용. 임의의 사번으로 로그인하기 위해 처리. ?empno=임의사번
					//empno = "ex190126";
					//empno = "04102746";
					//empno = "02100371";
					//empno = "94108551";
					HashMap<String, String> user_info = commonController.getBasicUserInfo(empno,commonService);
					ArrayList<HashMap<String, String>> admInfo = commonController.getAdmInfo(empno,commonService);
					int serviceAdmInfo = commonController.getServiceAdmInfo(empno,commonService);
					
					//System.out.println(user_info);
					if(user_info != null){
						
	                    BaseController.setSession(request, empno, user_info, admInfo, serviceAdmInfo);
	                    
	                    System.out.println("session make ok");
	                    
	                    
	                    //전광판 게시, 컨텐츠 제작, 장비대여 메뉴 접근 컨트롤
	                    String uriChkVal = "true";
	                    
	                    uriChkVal = uriChk(request);
	                    
	                    if("true".equals(uriChkVal)){
	                        try{
	                            commonController.insertPageLog(request, commonService);
	                        }catch(Exception e){
	                            e.printStackTrace();
	                        }
	                    }else if("saupso".equals(uriChkVal)){
	                        
	                        response.setHeader("Content-Type", "text/html; charset=utf-8");
	                        response.getWriter().write("<script>alert('콘텐츠 제작(게시요청/장비대여)은 본사만 지원이 가능합니다.');history.back(-1);</script>");
	                        
	                        return false;
						}
						
						return true;
					}else{
						response.sendRedirect("/jsp/error/error.jsp");
						return false;
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			
			response.sendRedirect("/jsp/error/error.jsp");
			return false;
		}
	}

	private void setSession(HttpServletRequest request) {
		BaseController.setSession(request);
	}

	private boolean checkSession(HttpServletRequest request) {

		boolean chkSession = false;

		String url = request.getRequestURI();
		
		if(url.indexOf("dataSet.do") < 0
			&& url.indexOf("dataGet.do") < 0){
			HttpSession session = request.getSession();
	
			if (StringUtil.isNotEmpty((String) session.getAttribute("SESS_EMPNO")) 
                    && StringUtil.isNotEmpty((String) session.getAttribute("SESS_USER_NAME"))
                    && StringUtil.isNotEmpty((String) session.getAttribute("SESS_USER_TELNO"))) {
                
				chkSession = true;
	
				this.setSession(request);
			}
		}else{
			chkSession = true;
		}

		return chkSession;
	}

	private String getAccessEmpno(HttpServletRequest request) throws Exception {
		/* 리턴할 복화화 유저ID */
		String decodedUserID = null;

		try {
			Process p = null;
			BufferedReader resultEmpNo = null;

			String encodedEmpNo = null;

			Cookie cookie[] = request.getCookies();

			if (cookie != null) {
				for (int i = 0; i < cookie.length; i++) {
					if ("pgsecuid2".equals(cookie[i].getName())) {
						encodedEmpNo = cookie[i].getValue();
					}
				}
			}
//			System.out.println("encodedEmpNo==========" + encodedEmpNo);

			/*
			 * 한전용 암호화 ID를 복호화 하여 유저ID 가져오기
			 *
			 * C:/engine/seed_decode_java/SDDecode.exe : Decode 실행파일 경로
			 */
			if (encodedEmpNo != null) {
				encodedEmpNo = encodedEmpNo.replace(" ", "+");
				try {
					p = Runtime.getRuntime().exec("C:/engine/seed_decode_java/SDDecode.exe " + encodedEmpNo);
					p.waitFor();
					if (p.exitValue() != 0) {
						decodedUserID = null;
					} else {
						resultEmpNo = new BufferedReader(new InputStreamReader(p.getInputStream()));
						while (resultEmpNo.ready()) {
							decodedUserID = resultEmpNo.readLine();
						}
						resultEmpNo.close();
						resultEmpNo = null;
					}
					p.destroy();
				} catch (IOException e) {
					decodedUserID = null;
					// e.printStackTrace();
				} catch (InterruptedException e) {
					decodedUserID = null;
					// e.printStackTrace();
				}
			}else {
				if(request.getParameter("paramempno") != null) {
					decodedUserID = request.getParameter("paramempno");
				}
			}

			//System.out.println("decodedUserID==========" + decodedUserID);
			
			if (decodedUserID != null && decodedUserID.length() > 8) {
				decodedUserID = decodedUserID.substring(0, 8);
			}
		} catch (Exception ex) {
			throw new Exception(ex);
		}
		return decodedUserID;
	}
	
	private String uriChk(HttpServletRequest request){
        String url = request.getRequestURI();
        
        String retVal = "false";
        
        if(url.indexOf("contentsInfo.do") != -1
            || url.indexOf("contentsRequest.do") != -1
            || url.indexOf("contentsProgress.do") != -1
            || url.indexOf("displayBoardInfo.do") != -1
            || url.indexOf("displayBoardRequest.do") != -1
            || url.indexOf("displayBoardProgress.do") != -1
            || url.indexOf("equipManual.do") != -1
            || url.indexOf("equipRentList.do") != -1
            || url.indexOf("appList.do") != -1
            || url.indexOf("basketList.do") != -1
            || url.indexOf("access.do") != -1
            || url.indexOf("longTermUser.do") != -1){

            //지역사업소 사원은 해당 메뉴 접근 불가
            //"061-"은 본사 직원 내선 번호. 그 외 번호는 지역 사업소 직원으로 해당 메뉴 접근 불가
            if((StringUtil.isNotEmpty(BaseController.SESS_USER_TELNO)
                    && BaseController.SESS_USER_TELNO.indexOf("061-") != -1)
                    	|| (StringUtil.isNotEmpty(BaseController.SESS_EMPNO)
                    			&& BaseController.MENU_EMPNO.containsKey(BaseController.SESS_EMPNO))){
                
                retVal = "true";
            }else{
                retVal = "saupso";
            }
            
            //예외 처리 - 노조 직원 접근 허용
            if (StringUtil.isNotEmpty(BaseController.SESS_EMPNO)) {
            	HashMap<String,String> nojo = Constants.getNojohqMap();
            	Iterator<String> keys = nojo.keySet().iterator();
            	
                while(keys.hasNext()) {
                    String key = keys.next();
                    if (BaseController.SESS_EMPNO.equalsIgnoreCase(nojo.get(key))) {
                    	retVal = "true";                    	
                    }
                }
            }
        }else{
            retVal = "true";
        }
        
        return retVal;
    }
    
}

