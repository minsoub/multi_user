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
		�׽�Ʈ Decode [��� : test0007] : �׽�Ʈ ����
		�Ǽ��� �϶��� �Ʒ��� ������ ������ �ּ���.	
	*/
	if(encodedEmpNo == null){
		encodedEmpNo = "GE8jGlhr/ftMYdRYtyzsXw";
	}

	/*
	C:/engine/seed_decode_java/SDDecode.exe : Decode �������� ���
	*/

	if( encodedEmpNo != null ){
		encodedEmpNo = encodedEmpNo.replace(" ", "+");
		try {
			out.println("as123d");       
			out.println(encodedEmpNo.length());
			
			//������ �׽�Ʈ
			p = Runtime.getRuntime().exec("C:/engine/seed_decode_java/SDDecode.exe " + encodedEmpNo);
			
			//������ �׽�Ʈ
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