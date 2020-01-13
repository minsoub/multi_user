<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="java.io.*" %>
<%
	String decodedUserID = null;
	Process p = null;
	BufferedReader resultEmpNo = null;


	String encodedEmpNo = null;
	String userID = null;
	Cookie cookie[] = request.getCookies();

	if( cookie != null ){
		for(int i=0; i<cookie.length; i++) {
			if( "pgsecuid2".equals(cookie[i].getName()) ){
				encodedEmpNo = cookie[i].getValue();
			}
		}
	}

	/*
		테스트 Decode [결과 : test0007] : 테스트 전용
		실서비스 일때는 아래의 문장을 제거해 주세요.	
	*/
	if(encodedEmpNo == null){
		encodedEmpNo = "GE8jGlhr/ftMYdRYtyzsXw";
	}

	/*
	C:/engine/seed_decode_java/SDDecode.exe : Decode 실행파일 경로
	*/

	if( encodedEmpNo != null ){
		encodedEmpNo = encodedEmpNo.replace(" ", "+");
		try {
			out.println("as123d");       
			out.println(encodedEmpNo.length());
			
			//윈도우 테스트
			p = Runtime.getRuntime().exec("C:/engine/seed_decode_java/SDDecode.exe " + encodedEmpNo);
			
			//리눅이 테스트
			//p = Runtime.getRuntime().exec("/home/webadm/mtest/BIN/seed_decode -d " + encodedEmpNo);
			
			p.waitFor ();
				if (p.exitValue () != 0) {
					decodedUserID = null;
				} else { 
					resultEmpNo = new BufferedReader (new InputStreamReader (p.getInputStream()));
					while (resultEmpNo.ready()){
						decodedUserID = resultEmpNo.readLine();
					}
					resultEmpNo.close();
					resultEmpNo = null;
			}
			p.destroy ();
		} catch (IOException e) {
			decodedUserID = null;
			//e.printStackTrace();
		} catch (InterruptedException e) {
			decodedUserID = null;
			//e.printStackTrace();
		}
	}

	if( decodedUserID != null && decodedUserID.length() > 8 ){
		decodedUserID = decodedUserID.substring(0, 8);
	}

	out.println("empno : " + decodedUserID);
%>