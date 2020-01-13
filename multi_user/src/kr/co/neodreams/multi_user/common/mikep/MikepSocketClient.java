package kr.co.neodreams.multi_user.common.mikep;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;


public class MikepSocketClient {
    public static void main(String[] args) {        
        Socket                soc;     // 서버에 연결할 소켓
        BufferedReader        br;      // 서버가 보낸 메세지를 읽을 리더
        PrintWriter            pw;      // 서버로 메세지를 보낼 라이터
        Scanner                scan;   // 사용자가 입력한 데이터를 읽을 스캐너
        
        try{
            
            soc = new Socket("localhost",48888);
            //soc = new Socket("100.1.48.50",48888);
            System.out.println(getTime() + "Accept to Server Success!!");
            
            OutputStream sender = soc.getOutputStream();
			InputStream receiver = soc.getInputStream();
			
            //서버로 데이터 보내기
            //872byte
            //String send_message = "media170510000123401테스트문서테스트문서테스트문서테스트문서테스트문서테스트문서테스트문서테스트문서112345678901234567890123456789010212345678901234ex09911800011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111222222222222222222222333333333333333333333333333333301543215432154321ex09911800011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111222222222222222222222333333333333333333333333333333301543215432154321ex09911800011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111222222222222222222222333333333333333333333333333333301543215432154321ex09911800011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111222222222222222222222333333333333333333333333333333301543215432154321";
            //String send_message = "media170418000208 7 업무용 노트북 장기대여4                                                          아인(IC)-101                   1 9900000622791  5102632   ICT인프라처 ICT서비스부 OA설비/전자응용설비/멀티미디어                                               김진구               팀원                           4 20170510162138 15102632   ICT인프라처 ICT서비스부 OA설비/전자응용설비/멀티미디어                                               김진구               팀원                           2 20170510162138                                                                                                                                                                                      87103587   ICT인프라처 ICT서비스부                                                                              최갑천               부장                           B                ";
			//byte[] send_data = send_message.getBytes();    
			
			FileInputStream fis = new FileInputStream("D:\\mikepdata.dat");
			byte[] send_data = new byte[fis.available()];
			while (fis.read(send_data) != -1) {
				
			}
			fis.close();
            System.out.println("msg length : " + send_data.length);
            sender.write(send_data, 0, send_data.length);
            sender.flush();
            soc.shutdownOutput();
            
            //서버로부터 데이터 받기
            //11byte
            byte[] data = new byte[4];
            receiver.read(data,0,4);
             
            //수신메시지 출력
            String message = new String(data);
            String out = String.format("receive - %s", message);
            System.out.println(out);
            
            soc.close();
            
        }catch(IOException e){
            e.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();            
        }
 
    }
    
    private static String getTime(){
        SimpleDateFormat f = new SimpleDateFormat("[hh:mm:ss]");
        return f.format(new Date());
    }

}
