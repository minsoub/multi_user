package kr.co.neodreams.multi_user.common.sms;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketAddress;
import java.net.UnknownHostException;
import java.util.List;

import javax.annotation.Resource;

import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.dto.RentDto;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.ibatis.sqlmap.client.SqlMapClient;

public class RentalSendThread extends Thread {

    @Autowired
    SqlMapClientTemplate sqlTemp;

    /** LOGGER */
    Logger log = Logger.getLogger(this.getClass());

    private Socket socket; // 소켓
    private String smsInfo; //
    private BigInteger key; // 고유키 (타 시스템에서 생성)
    private List<RentDto> cellNoList; // 수신자번호 리스트
    private int refCnt; // 수신자번호 카운트
    private InputStream recv;
    private BufferedOutputStream send;

    @Resource(name = "sqlMapClient")
    public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
        this.sqlTemp = sqlMapClientTemplate;
    }

    RentalSendThread(BigInteger _key, String msg, List<RentDto> _cellNoList) {

        cellNoList = _cellNoList;

        // DB에 shareNo contNo 등록 후 키 가져오기
         this.key = _key;

        // 보낼 번호 리스트 사이즈
        refCnt = cellNoList.size();
        if (refCnt > 0) {
            smsInfo = smsInfo(key, cellNoList.get(0).getHp(), msg, refCnt - 1);
            log.info("MAKE SMSINFO: " + smsInfo);
        }
    }

    @Override
    public void run() {
        // TODO SMS
        super.run();
        try {

            // Send the message to the server
            connect();
            sendMessage(smsInfo);
            log.info("Message sent to the server : " + smsInfo);

            if (refCnt > 1) {
                int cnt = 0;
                String cellNo = "";
                int cellNoListSize = cellNoList.size();

                for (int i = 0; i < cellNoListSize; i++) {

                    cellNo = cellNoList.get(i).getHp();

                    log.info("cellNo11" + cellNo);
                    if (cnt > 0) {
                        refMessage(refInfo(key, cellNo));
                        log.info("Ref Cell No: " + cellNo);
                    }
                    cnt = cnt + 1;
                }
            }
            send.flush();
            log.info("SEND FLUSH");


            String receiveMsg = receiveMessage();

            log.info("Message received from the server : " + receiveMsg);

            String retCode = receiveMsg;

            SqlMapClient sqlmap = SqlMapConfig.getSqlMapInstance();
            try {
                sqlmap.startTransaction();
                sqlmap.update("Common#updateRentalSendSMS", retCode);
                sqlmap.commitTransaction();
            } finally {
                sqlmap.endTransaction();
            }

            if("9999".equals(retCode)){
                System.out.println("send sms 9999 is success");
            }else{
                System.out.println("send sms " + retCode + " is fail");
            }

        } catch (Exception e) {
            // TODO SLEEP
            e.printStackTrace();
        } finally {
            // Closing the socket
            try {
                disconnect();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void connect() throws UnknownHostException, IOException {

        InetAddress host = InetAddress.getByName(Constants.SMS_HOST);
        int port = Constants.SMS_PORT;
        SocketAddress socketAddress = new InetSocketAddress(host, port);
        socket = new Socket();
        socket.setSoTimeout(4000); /* InputStream에서 데이터읽을때의 timeout */
        socket.connect(socketAddress, 4000);
        log.info(socket.getInetAddress() + "와 연결되었습니다.");

        // Get the return message from the server
        recv = socket.getInputStream();
        send = new BufferedOutputStream(socket.getOutputStream());
    }

    public void sendMessage(String message) throws IOException {
        send.write(message.getBytes("euc-kr"));

        log.info("==========sendMessage length========" + message.getBytes("euc-kr").length);
    }

    public void refMessage(String message) throws IOException {
        // Send the message to the server
        send.write(message.getBytes("euc-kr"));

        log.info("==========refMessage length========" + message.getBytes().length);
    }

    public String receiveMessage() throws IOException {
        // Get the return message from the server
        byte[] rcvmsg = new byte[155];

        int readCnt = 0;

        readCnt = recv.read(rcvmsg);
        log.info("---------------------------read-----------------------------" + readCnt);
        log.info("---------------------------buf-----------------------------" + rcvmsg);

        System.out.println(new String(rcvmsg).substring(0,4));
        return new String(rcvmsg).substring(0,4);
    }

    public void disconnect() throws IOException {
        recv.close();
        send.close();
        socket.close();
        log.info("SOCKET CLOSE");
    }

    /**
     * SMS 메세지를 작성
     *
     * <pre>
     * String classcode [5자리]  //연계코드 (운영부서에서 부여)
     * String password [4자리]   //비밀번호 (운영부서에서 부여)
     * String key [15자리]       //고유키 (타 시스템에서 생성)
     * String recvphone [15자리] //수신자 번호
     * String callback [15자리]  //회신 번호
     * String message [80자리]   //메시지
     * String empno [8자리]      //사번
     * String refcnt [5자리]     //참조자수
     * </pre>
     */
    private String smsInfo(BigInteger key_, String recvphone_, String message_, int refCount_) {

        String classcode; // 연계코드 (운영부서에서 부여)
        String password; // 비밀번호 (운영부서에서 부여)
        String strKey; // 고유키 (타 시스템에서 생성)
        String recvphone; // 수신자 번호
        String callback; // 회신 번호
        String message; // 메시지
        String empno; // 사번
        String refcnt; // 참조자수

        // heap = stack
        classcode = makeSendStr(Constants.SMS_CLASS_CODE); // 연계코드 (운영부서에서 부여)
        password = makeSendStr(Constants.SMS_PASSCODE); // 비밀번호 (운영부서에서 부여)
        strKey = String.format("%15s", String.valueOf(key_)).replace(" ", "0");
        strKey = makeSendStr(strKey); // 고유키 (타 시스템에서 생성)

        recvphone = makeSendStr(recvphone_.replace("-", ""), 16); // 수신자 번호
        callback = makeSendStr(Constants.SMS_CALLBACK, 16); // 회신 번호

        message = byteCheck(message_, 80);
        message = makeSendStr2(message, 81); // 메시지

        empno = makeSendStr(Constants.sms_senderEmpno, 9); // 사번

        String _refcnt = String.format("%5s", String.valueOf(refCount_)).replace(" ", "0");
        refcnt = makeSendStr(_refcnt); // 참조자수
        log.info(message);

        return classcode + password + strKey + recvphone + callback + message + empno + refcnt;
    }

    /**
     * SMS 참조자를 작성
     *
     * <pre>
     * String key [15자리]       //고유키 (타 시스템에서 생성)
     * String recvphone [15자리] //수신자 번호
     * </pre>
     */
    private String refInfo(BigInteger key_, String recvphone_) {
        String strKey; // 고유키 (타 시스템에서 생성)
        String recvphone; // 수신자 번호
        strKey = String.format("%15s", String.valueOf(key_)).replace(" ", "0");
        strKey = makeSendStr(String.valueOf(strKey)); // 고유키 (타 시스템에서 생성)
        recvphone = makeSendStr(recvphone_.replace("-", ""), 16); // 수신자 번호
        log.info(recvphone);
        return strKey + recvphone;
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
            // TODO: handle exception
            log.info("makeSendStr GETBYTES err.........." + e.toString());
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
            // TODO: handle exception
            log.info("makeSendStr GETBYTES err.........." + e.toString());
        }

        String retVal = null;

        try {
            retVal = new String(rArr, "euc-kr");
        } catch (UnsupportedEncodingException e) {
         // TODO: handle exception
            log.info("makeSendStr NEW STRING err.........." + e.toString());
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
}

