package kr.co.neodreams.multi_user.common.mikep;

import java.io.*;
import java.net.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.concurrent.*;

import kr.co.neodreams.multi_user.common.Constants;

public class MikepSocketServer {
	private final static int PORT = 48888;
	private final static String driver = Constants.driver_socket;
    private final static String url = Constants.url_socket;
    private final static String user = Constants.user_socket;
    private final static String password = Constants.password_socket;
    private static Connection conn = null;
    
    public static void init() {
        try {
            Class.forName(driver);
            System.out.println(getTime() + " 데이터베이스 드라이버 로드 성공.");

            getConnection();

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    public static void getConnection(){

        try {
            conn = DriverManager.getConnection(url, user, password);
            System.out.println(getTime() + " 데이터베이스 접속 성공.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
	
	public static void main(String[] args) {
		
		init();
		
		ExecutorService pool = Executors.newFixedThreadPool(50);
		try{
			ServerSocket server = new ServerSocket(PORT);
			System.out.println(getTime() + " 연결요청을 기다리는 중입니다.");
			while(true){
				try{
					Socket connection = server.accept();
					Callable<Void> task = new DaytimeTask(connection);
					pool.submit(task);
				}catch(IOException e){}
			}
		}catch(IOException e){
			System.err.println(getTime() + " 이미 마이캡응답서버가 실행중이거나 해당포트가 사용중 입니다.");
		}
	}
	
	private static class DaytimeTask implements Callable<Void> {
		
		private Socket connection;
		private OutputStream sender;
		private InputStream receiver;
		private String rtnCode = "0000"; //클라이언트로 리턴값 보내기 - 정상 : 0000, 비정상 : 9999
		
		DaytimeTask(Socket connection) {
			this.connection= connection;
		}
	
		public Void call(){
			try{
				System.out.println(getTime() + " " + connection.getInetAddress() + " 로부터 연결요청이 들어왔습니다.");
				
				sender = connection.getOutputStream();
				receiver = connection.getInputStream();
				
				int[] aryPacket = {18, 2, 81, 31, 2, 14, 11, 101, 21, 31, 2, 15, 11, 101, 21, 31, 2, 15, 11, 101, 21, 31, 2, 15, 11, 101, 21, 31, 2, 15};
				ArrayList<String> aryReceivedData = new ArrayList<String>();
				
				for (int i = 0; i < aryPacket.length; i++) {
					aryReceivedData.add(getByteToString(receiver, 0, aryPacket[i]));		
				}
				System.out.println(aryReceivedData);
				
				// 문서정보
				String link_key = 		aryReceivedData.get(0);
				String sign_status = 	aryReceivedData.get(1);
				String title = 			aryReceivedData.get(2);
				String master_no = 		aryReceivedData.get(3);
				String batch_flag = 	aryReceivedData.get(4);
				String link = 			aryReceivedData.get(5);
				
				// 기안자
				String emp_id1 = 		aryReceivedData.get(6);
				String dept_name1 = 	aryReceivedData.get(7);
				String user_name1 = 	aryReceivedData.get(8);
				String pos_name1 = 		aryReceivedData.get(9);
				String method1 = 		aryReceivedData.get(10);
				String date1 = 			aryReceivedData.get(11);
				
				// 입안자
				String emp_id2 = 		aryReceivedData.get(12);
				String dept_name2 = 	aryReceivedData.get(13);
				String user_name2 = 	aryReceivedData.get(14);
				String pos_name2 = 		aryReceivedData.get(15);
				String method2 = 		aryReceivedData.get(16);
				String date2 = 			aryReceivedData.get(17);
				
				// 검토자
				String emp_id3 = 		aryReceivedData.get(18);
				String dept_name3 = 	aryReceivedData.get(19);
				String user_name3 = 	aryReceivedData.get(20);
				String pos_name3 = 		aryReceivedData.get(21);
				String method3 = 		aryReceivedData.get(22);
				String date3 = 			aryReceivedData.get(23);
				
				// 결재자
				String emp_id4 = 		aryReceivedData.get(24);
				String dept_name4 = 	aryReceivedData.get(25);
				String user_name4 = 	aryReceivedData.get(26);
				String pos_name4 = 		aryReceivedData.get(27);
				String method4 = 		aryReceivedData.get(28);
				String date4 = 			aryReceivedData.get(29);
				
				/*
				 *  LINKKEY생성규칙
				 *  1. FORMAT : LNKyyMMddXXXXXXXXX
				 *  2. (LNKyyMMdd)9자리 + (XXXXXXXXX)9자리 = 총 18자리
				 *  3. XX영역의 9자리는 APPNO를 채운 후 나머지 앞자리는 'N'으로 채운다.
				 *  4. 예) LNK170511NNNNN5480				 * 
				 */
				
				String appno = link_key.substring(9).replace("N", "");

				System.out.println(getTime() + " " + link_key + "의 데이터 전송이 완료 되었습니다.");
				
				PreparedStatement pstmt = null;
				ResultSet rs = null;
		        String sql = "INSERT INTO ONESTOP_RENT_MIKEP_SIGN(SEQNO, APPNO, LINKKEY, SIGN_STATUS, TITLE, MASTER_NO, BATCH_FLAG, LINK, EMPNO, SIGN_LEVEL, DEPT_NAME, NAME, POS_NAME, METHOD, SIGN_DATE, REGDT)"
		        		+ "VALUES ((SELECT ISNULL(MAX(seqno) + 1, 0) AS SEQNO FROM ONESTOP_RENT_MIKEP_SIGN), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CONVERT(varchar(10), getdate(), 112) + REPLACE(CONVERT(varchar(8), getdate(), 108), ':', ''))";
		        
		        try {
	            	pstmt = conn.prepareStatement(sql);
	                pstmt.setString(1, appno); //장비대여 접수현황 키
	                pstmt.setString(2, link_key); //KEY 코드
	                pstmt.setString(3, sign_status); //결재상태 : 1-기안 3-입안결재 4-검토결재 5-결정결재 7-완료 8-폐기
	                pstmt.setString(4, title); //문서제목
	                pstmt.setString(5, master_no); //마이캡 문서번호
	                pstmt.setString(6, batch_flag); //기안문서 안번호
	                pstmt.setString(7, link); //마이캡 문서 ID
	                pstmt.setString(8, emp_id1); // 기안자 사원번호
	                pstmt.setString(9, "1"); //결재등급 : 1-기안자 2-입안자 3- 검토자 4- 결재자
	                pstmt.setString(10, dept_name1); //기안자 부서명
	                pstmt.setString(11, user_name1); //기안자 이름
	                pstmt.setString(12, pos_name1); //기안자 직위
	                pstmt.setString(13, method1); //결재방법 : 1-일반결재 2-대결 3-후결 4-결재안함 5-결재패스
	                pstmt.setString(14, date1); //기안일자
	                
	                pstmt.execute();
	            } catch (SQLException e) {
					rtnCode =  "9999";	
					sendRtnCode(sender, rtnCode);
					
	                e.printStackTrace();

	                if(conn != null){
	                    try {
	                        conn.close();
	                    } catch (SQLException e1) {
	                        e1.printStackTrace();
	                    }
	                }
	            } finally {
	                try{
	                    if(rs != null){
	                        rs.close();
	                    }
	                    if(pstmt != null){
	                    	pstmt.close();
	                    }
	                } catch (SQLException e){
	                    e.printStackTrace();
	                }
	            }
				
				System.out.println(getTime() + " " + link_key + "의 데이터베이스 등록이 완료 되었습니다.");
				
				sendRtnCode(sender, rtnCode);
				
			}catch(Exception e){
				rtnCode =  "9999";	
				sendRtnCode(sender, rtnCode);

                e.printStackTrace();
			}finally{
				try{
					receiver.close();
					connection.close();
					System.out.println(getTime() + " " + connection.getInetAddress() + " 연결 종료.");
				}catch(IOException e){}
			}
			return null;
		}
	}
	
	private static void sendRtnCode(OutputStream sender, String rtnCode) {
		byte[] rtn_data = rtnCode.getBytes();
        try {
			sender.write(rtn_data, 0, rtn_data.length);
			sender.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}
	
	private static String getTime(){
		SimpleDateFormat f = new SimpleDateFormat("[yy-MM-dd hh:mm:ss]");
		return f.format(new Date());
	}
	
	private static String getByteToString(InputStream in, int off, int dataLength) throws Exception {
		byte[] byteData = new byte[dataLength];
		in.read(byteData, off, dataLength);
		return new String(byteData, "EUC-KR").trim();
	}
}
