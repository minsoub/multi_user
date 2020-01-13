package kr.co.neodreams.multi_user.common.onestop;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketAddress;
import java.net.UnknownHostException;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.DateUtil;

public class OneStopSendThread extends Thread {
	/** LOGGER */
	private static final Logger log = LoggerFactory.getLogger(OneStopSendThread.class);

	private static final String ONESTOP_HOST = Constants.ONESTOP_HOST;
	private static final String ONESTOP_PORT = Constants.ONESTOP_PORT;
    private static final String ONESTOP_SYSTEMID = Constants.ONESTOP_SYSTEMID;
    private static final String ONESTOP_DOCTYPE = Constants.ONESTOP_DOCTYPE;
    
    private Socket socket; // 소켓
    OneStopVO osVO;
    private String onestopInfo;
    private InputStream recv;
    private BufferedOutputStream send;
    private String oneStopRetCode = "";
    
    OneStopSendThread(OneStopVO _osVO) {
    	this.osVO = _osVO;
    	this.onestopInfo =  onestopInfo();
    	System.out.println("Make OnestopInfo: [" + this.onestopInfo + "]");
    }
    
    @Override
    synchronized public void run() {
    	super.run();
    	try {
    		if(Constants.TEST_MODE){ 
    			setOneStopRetCode("0000");
    		}
    		
    		connect();
    		sendMessage(this.onestopInfo);
    		System.out.println("Message sent to the server : " + this.onestopInfo);
    		send.flush();
    		System.out.println("SEND FLUSH");
    		
    		String receiveMsg = receiveMessage();
    		
    		System.out.println("Message received from the server : " + receiveMsg);
    		
    		String retCode = receiveMsg;
    		
    		setOneStopRetCode(retCode);
    		
    		switch (retCode) {
    		case "0000" : System.out.println("ONESTOP 전송 성공");
    			break;
    		case "1001" : System.out.println("ONESTOP [" + retCode + " : 전송 데이터형식 오류]");
    			break;
    		case "1002" : System.out.println("ONESTOP [" + retCode + " : 서버간 전송시간 초과 오류]");
    			break;
    		case "1100" : System.out.println("ONESTOP [" + retCode + " : 데이터베이스 접속 오류]");
    			break;
    		case "1101" : System.out.println("ONESTOP [" + retCode + " : 데이터베이스 Query 오류]");
    			break;
    		case "1200" : System.out.println("ONESTOP [" + retCode + " : 시스템 서비스 오류]");
    			break;
    		}
    	} catch (IOException e) {
            // TODO ONESTOP
    		//retCode = e.printStackTrace();
    		StringWriter error = new StringWriter();
    		e.printStackTrace(new PrintWriter(error));
    		setOneStopRetCode(error.toString());
    		e.printStackTrace();
        } catch (Exception e) {
        	StringWriter error = new StringWriter();
    		e.printStackTrace(new PrintWriter(error));
    		setOneStopRetCode(error.toString());
        	e.printStackTrace();
        } finally {
            // Closing the socket
            try {
                disconnect();
            } catch (Exception e) {
            }
        }
    }
    
    public void connect() throws UnknownHostException, IOException {
    	InetAddress host = InetAddress.getByName(ONESTOP_HOST);
    	int port = Integer.parseInt(ONESTOP_PORT);
    	SocketAddress socketAddress = new InetSocketAddress(host, port);
    	socket = new Socket();
    	socket.setSoTimeout(4000);
    	socket.connect(socketAddress, 4000);
    	System.out.println(socket.getInetAddress() + "와 연결되었습니다.");
    	
    	recv = socket.getInputStream();
    	send = new BufferedOutputStream(socket.getOutputStream());
    }
    
    public void disconnect() throws IOException {
    	recv.close();
    	send.close();
    	socket.close();
    	System.out.println("SOCKET CLOSE");
    }
    
    public void sendMessage(String message) throws IOException {
    	send.write(message.getBytes("euc-kr"));
    	
    	System.out.println("==========sendMessage length========" + message.getBytes("euc-kr").length);
    }
    
    public String receiveMessage() throws IOException {
    	byte[] rcvmsg = new byte[5];
    	
    	int readCnt = 0;
    	
    	readCnt = recv.read(rcvmsg);
    	System.out.println("---------------------------read-----------------------------" + readCnt);
        System.out.println("---------------------------buf-----------------------------" + rcvmsg);
        
        return new String(rcvmsg).substring(0,4);
    }
    
    
    private String onestopInfo() {
    	/**
    	 * ONESTOP 메시지
    	 * <pre>
         * String signtype [1자리]		//결재구분(대기/결재)
         * String signempid [8자리]		//결재자 사번
         * String systemid [5자리]		//연계시스템 아이디 (운영부서에서 부여)
         * String systemkey [15자리]		//결재문서 고유키 (타시스템에서 생성)
         * String doctype [20자리]		//결재타입 (시스템이름)
         * String docdate [14자리]		//결재문서도착/결재 일시
         * String writename [20자리]		//문서 최초 작성자 이름
         * String writeempid [8자리]		//문서 최초 작성자 사번
         * String title [255자리]			//문서 제목
         * String url [255자리]			//결재시행(문서보기)할 URL
         * String status [1자리]			//결재진행상태 (진행, 완료, 회수/반송)
         * </pre>
    	 */
    	String signtype;
    	String signempid;
    	String systemid;
    	String systemkey;
    	String doctype;
    	String docdate;
    	String writename;
    	String writeempid;
    	String title;
    	String url;
    	String status;
    	
    	signtype = makeSendStr(this.osVO.getSigntype(), 2);
    	signempid = makeSendStr(this.osVO.getSignempid(), 9);
    	systemid = makeSendStr(ONESTOP_SYSTEMID);
    	systemkey = makeSendStr(this.osVO.getSystemkey(), 16);
    	doctype = makeSendStr2(ONESTOP_DOCTYPE, 21);
    	docdate = makeSendStr(DateUtil.getCurrentDateTime(), 15);
    	//docdate = makeSendStr(this.osVO.getDocdate(), 15);
    	writename = byteCheck(this.osVO.getWritename(), 20);
    	writename = makeSendStr2(writename, 21);
    	writeempid = makeSendStr(this.osVO.getWriteempid(), 9);
    	title = byteCheck(this.osVO.getTitle(), 255);
    	title = makeSendStr2(title, 256);
    	
    	url = makeSendStr(this.osVO.getUrl(), 256);
    	status = makeSendStr(this.osVO.getStatus(), 2);
    	
    	return signtype + signempid + systemid + systemkey + doctype + docdate + writename + writeempid + title + url + status;
    }
    
    private String makeSendStr(String str) {
        return this.makeSendStr(str, str.getBytes().length + 1);
    }

    private String makeSendStr(String str, int len) {
        byte[] rArr = new byte[len];

        try{
            byte[] strByte = str.getBytes();

            for (int i = 0; i < len; i++) {
                rArr[i] = (i < strByte.length) ? strByte[i] : (byte) 0;
            }
        }catch (Exception e) {
            
            System.out.println("makeSendStr GETBYTES err.........." + e.toString());
            e.printStackTrace();
        }

        String retVal = null;

        retVal = new String(rArr);

        return retVal;
    }

    private String makeSendStr2(String str, int len) {
        byte[] rArr = new byte[len];

        try{
            byte[] strByte = str.getBytes("euc-kr");

            for (int i = 0; i < len; i++) {
                rArr[i] = (i < strByte.length) ? strByte[i] : (byte) 0;
            }
        }catch (Exception e) {
            
            System.out.println("makeSendStr GETBYTES err.........." + e.toString());
            e.printStackTrace();
        }

        String retVal = null;

        try {
            retVal = new String(rArr, "euc-kr");
        } catch (UnsupportedEncodingException e) {
         
            System.out.println("makeSendStr NEW STRING err.........." + e.toString());
            e.printStackTrace();
        }

        return retVal;
    }


    public String byteCheck(String txt, int standardByte) {

        if (StringUtils.isEmpty(txt)) {
            return "";
        }

        int byteChk = 0;
        String retStr = "";

        char[] txtChar = txt.toCharArray();

        for (int j = 0; j < txtChar.length; j++) {

            if (txtChar[j] >= '\uAC00' && txtChar[j] <= '\uD7A3') {
                byteChk = byteChk + 2;

                if (byteChk < standardByte) {

                    retStr = retStr + String.valueOf(txtChar[j]);
                } else {
                    break;
                }
            } else {
                byteChk = byteChk + 1;

                if (byteChk < standardByte) {
                    retStr = retStr + String.valueOf(txtChar[j]);
                } else {
                    break;
                }
            }
        }

        return retStr;
    }

	public String getOneStopRetCode() {
		return oneStopRetCode;
	}

	public void setOneStopRetCode(String oneStopRetCode) {
		this.oneStopRetCode = oneStopRetCode;
	}
}
