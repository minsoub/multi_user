package kr.co.neodreams.multi_user.common.mikep;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.Date;

import kr.co.neodreams.multi_user.dto.RentDto;
import kr.co.neodreams.multi_user.service.RentService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class ServletMikepThread extends Thread{
	
	ServerSocket serverSocket = null;
	
	@Autowired
	RentService rentService;
	
	@Autowired
    DataSourceTransactionManager dataSourceTransactionManager;
	
	public void run(){
		
		String retCode = "9999";
		Socket socket = null;
		TransactionStatus statusTr = null;
		Boolean TestMode = false;
		
		try {
			// 서버소켓생성 - 46060번 포트 바인딩
			serverSocket = new ServerSocket(46060);
			System.out.println(getTime() + " 서버가 준비되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		} // try - catch
		
		while(true){
			
			try {
				
				System.out.println(getTime() + " 연결요청을 기다리는 중입니다.");
				// 서버소켓은 클라이언트의 연결요청이 올 때까지 실행을 멈추고 계속 기다린다.
				// 클라이언트의 연결요청이 오면 클라이언트 소켓과 통신할 새로운 소켓을 생성한다.
				socket = serverSocket.accept();
				System.out.println(getTime() + socket.getInetAddress() + " 로부터 연결요청이 들어왔습니다.");
				
				// 소켓의 입력스트림을 얻는다.
				InputStream in = socket.getInputStream();	
				ServletMikepThread smt = new ServletMikepThread();
				System.out.println(getTime() + " 데이터 전송을 시작합니다");
				
				if(TestMode){
					
					// 테스트 모드
					String resultStr = smt.getByteToString(in, 0, 872);
					System.out.println("resultStr : " + resultStr);
					
				} else {
					
					// 바이트 데이터 수신
					
					// 문서정보
					String link_key = 		smt.getByteToString(in, 0, 18);
					String sign_status = 	smt.getByteToString(in, 1, 2);
					String title = 			smt.getByteToString(in, 2, 81);
					String master_no = 		smt.getByteToString(in, 3, 31);
					String batch_flag = 	smt.getByteToString(in, 4, 2);
					String link = 			smt.getByteToString(in, 5, 14);
					
					// 기안자
					String emp_id1 = 		smt.getByteToString(in, 6, 11);
					String dept_name1 = 	smt.getByteToString(in, 7, 101);
					String user_name1 = 	smt.getByteToString(in, 8, 21);
					String pos_name1 = 		smt.getByteToString(in, 9, 31);
					String method1 = 		smt.getByteToString(in, 10, 2);
					String date1 = 			smt.getByteToString(in, 11, 15);
					
					// 입안자
					String emp_id2 = 		smt.getByteToString(in, 12, 11);
					String dept_name2 = 	smt.getByteToString(in, 13, 101);
					String user_name2 = 	smt.getByteToString(in, 14, 21);
					String pos_name2 = 		smt.getByteToString(in, 15, 31);
					String method2 = 		smt.getByteToString(in, 16, 2);
					String date2 = 			smt.getByteToString(in, 17, 15);
					
					// 검토자
					String emp_id3 = 		smt.getByteToString(in, 18, 11);
					String dept_name3 = 	smt.getByteToString(in, 19, 101);
					String user_name3 = 	smt.getByteToString(in, 20, 21);
					String pos_name3 = 		smt.getByteToString(in, 21, 31);
					String method3 = 		smt.getByteToString(in, 22, 2);
					String date3 = 			smt.getByteToString(in, 23, 15);
					
					// 결재자
					String emp_id4 = 		smt.getByteToString(in, 24, 11);
					String dept_name4 = 	smt.getByteToString(in, 25, 101);
					String user_name4 = 	smt.getByteToString(in, 26, 21);
					String pos_name4 = 		smt.getByteToString(in, 27, 31);
					String method4 = 		smt.getByteToString(in, 28, 2);
					String date4 = 			smt.getByteToString(in, 29, 15);
					String appno = link_key.substring(10).replace("0", "");

					System.out.println(getTime() + " " + link_key + "의 데이터 전송이 완료되었습니다");
					
					// 입력스트림을 닫는다.
					in.close();
					
					DefaultTransactionDefinition def = new DefaultTransactionDefinition();
			        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
			        statusTr = dataSourceTransactionManager.getTransaction(def);
					
					RentDto rentDto = new RentDto();
					
					rentDto.setAPPNO(Integer.parseInt(appno));
					rentDto.setLINKKEY(link_key);
					rentDto.setSIGN_STATUS(sign_status);
					rentDto.setTITLE(title);
					rentDto.setMASTER_NO(master_no);
					rentDto.setBATCH_FLAG(batch_flag);
					rentDto.setLINK(link);
					
					// 기안자 등록
					rentDto.setEMPNO(emp_id1);
					rentDto.setDept_name(dept_name1);
					rentDto.setNAME(user_name1);
					rentDto.setPos_name(pos_name1);
					rentDto.setMETHOD(method1);
					rentDto.setSIGN_DATE(date1);
					
					rentService.insertMikepSign(rentDto);
					
					// 입안자 등록
					rentDto.setEMPNO(emp_id2);
					rentDto.setDept_name(dept_name2);
					rentDto.setNAME(user_name2);
					rentDto.setPos_name(pos_name2);
					rentDto.setMETHOD(method2);
					rentDto.setSIGN_DATE(date2);
					
					rentService.insertMikepSign(rentDto);
					
					// 검토자 등록
					rentDto.setEMPNO(emp_id3);
					rentDto.setDept_name(dept_name3);
					rentDto.setNAME(user_name3);
					rentDto.setPos_name(pos_name3);
					rentDto.setMETHOD(method3);
					rentDto.setSIGN_DATE(date3);
					
					rentService.insertMikepSign(rentDto);
					
					// 결재자 등록
					rentDto.setEMPNO(emp_id4);
					rentDto.setDept_name(dept_name4);
					rentDto.setNAME(user_name4);
					rentDto.setPos_name(pos_name4);
					rentDto.setMETHOD(method4);
					rentDto.setSIGN_DATE(date4);
					
					rentService.insertMikepSign(rentDto);
					
					
					// Mikep 결재완료시 AppDB 결재내역 변경 
					if(sign_status.equals("8")){
						RentDto appDto = new RentDto();
						appDto.setAPPNO(Integer.parseInt(appno));
						appDto.setLINKKEY(link_key);
						rentService.updAppInfo(appDto);
						System.out.println(getTime() + " " + link_key + " Mikep결재가 완료되어 AppDB의 결재내역을 변경하였습니다.");
					}
					
					System.out.println(getTime() + " " + link_key + "의 DB 등록이 완료되었습니다");
					dataSourceTransactionManager.commit(statusTr);
					
				}
				
				retCode = "0000";
				
				
			} catch (IOException ioe) {
				ioe.printStackTrace();
				dataSourceTransactionManager.rollback(statusTr);
				retCode = "9999";
			} catch (Exception e){
				e.printStackTrace();
				dataSourceTransactionManager.rollback(statusTr);
				retCode = "9999";
			} finally {
				
				try {
					
					OutputStream out =  socket.getOutputStream();
					out.write(retCode.getBytes());
					System.out.println(getTime() + " 최종 결과 상태값이 Mikep으로 전송 되었습니다.");
					
					out.close();
					
				} catch (IOException e) {
					e.printStackTrace();
				}
				
			} // try - catch - finally
			
		}
		
	}
	
	static String getTime(){
		SimpleDateFormat f = new SimpleDateFormat("[hh:mm:ss]");
		return f.format(new Date());
	}
	
	private String getByteToString(InputStream in, int off, int dataLength) throws Exception {
		byte[] byteData = new byte[dataLength];
		in.read(byteData, off, dataLength);
		return new String(byteData, off, dataLength);
	}
	
}
