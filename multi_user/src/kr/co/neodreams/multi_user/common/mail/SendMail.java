package kr.co.neodreams.multi_user.common.mail;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.HashMap;

import javax.mail.Address;

import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.HashidsGenerator;

public class SendMail {

    private static String mailFrom = "ex190121@kepco.co.kr"; 

    private String mailLink = "";

    public static SendMail getInstance()
    {
        return new SendMail();
    }

//  메일전송 로직
    public boolean sendMail (Address[] toAddrs, String appno, String mode, String status, String mailSubject) {
    	
    	String sendEmpNo = "";
    	
    	if(toAddrs.length > 0) {
    		sendEmpNo = toAddrs[0].toString().split("@")[0];
    	}
    	
        if (mode.equals("sign")) {
            mailLink = "&status=" + status + "&paramempno="+ sendEmpNo.trim();
        } else if (mode.equals("chgEu") || mode.equals("chgEu_adm") || mode.equals("chgEm") || mode.equals("chgEm_adm")){
        	mailLink = "mailView.do?appno=" + appno + "&mode=" + mode + "&uhseq=" + status + "&paramempno="+ sendEmpNo.trim();
        } else {
            mailLink = "mailView.do?appno=" + appno + "&mode=" + mode + "&paramempno="+ sendEmpNo.trim();
        }
        return sendMail (toAddrs, appno, mode, mailSubject);
    }
    
    private boolean sendMail (Address[] toAddrs, String appno, String mode, String mailSubject) {
        boolean success = false;

        try {
            String mailContent = "";

            mailContent += "<!DOCTYPE>";
            mailContent += "<html>";
            mailContent += "<head>";
            mailContent += "<meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\">";
            mailContent += "<title></title>";
            mailContent += "</head>";
            mailContent += "<body>";
            mailContent += "    <iframe src=\"http://media.hq/mail/" + mailLink + "\" width=\"100%\" height=\"500\" frameborder=\"0\" scrolling=\"yes\"></iframe>";
            mailContent += "</body>";
            mailContent += "</html>";
            

            // send Mail
            MailUtil.sendMail(toAddrs, mailFrom, mailSubject, mailContent);

            success = true;
        } catch (Exception ex) {
            ex.printStackTrace();
            success = false;
        }

        return success;
    }

//  결재메일
    public boolean sign_sendMail (Address[] toAddrs, String mailFrom, String appno, String mode, String status) {
        if (mode.equals("sign")) {
            mailLink = "&status=" + status;
        } else {
            mailLink = "mailView.do?appno=" + appno + "&mode=" + mode;
        }
        return sign_sendMail (toAddrs, mailFrom, appno);
    }

    private boolean sign_sendMail (Address[] toAddrs, String mailFrom, String appno) {
        boolean success = false;

        try {
            String mailSubject = "[멀티미디어 설비대여 결재승인 요청]";
            String mailContent = "";

            mailContent += "<!DOCTYPE>";
            mailContent += "<html>";
            mailContent += "<head>";
            mailContent += "<meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\">";
            mailContent += "<title></title>";
            mailContent += "</head>";
            mailContent += "<body>";
            mailContent += "    <iframe src=\"http://media.hq/mail/" + mailLink + "\" width=\"100%\" height=\"500\" frameborder=\"0\" scrolling=\"yes\"></iframe>";
            mailContent += "</body>";
            mailContent += "</html>";

            // send Mail
            MailUtil.sendMail(toAddrs, mailFrom, mailSubject, mailContent);

            success = true;
        } catch (Exception ex) {
            ex.printStackTrace();
            success = false;
        }

        return success;
    }

    
    //장비대여 월합 통계 메일 발송
    public boolean equip_month_app_sendMail (Address[] toAddrs, HashMap<String, String> dataMap) {
        boolean success = false;

        try {
            String mailSubject = "[멀티미디어 장비대여 " + String.valueOf(dataMap.get("app_month")).substring(0, 4) + "년 " + String.valueOf(dataMap.get("app_month")).substring(4, 6) + "월 결재 진행 요청]";
            StringBuffer mailContent = new StringBuffer();

            mailContent.append("<!DOCTYPE>");
            mailContent.append("<html>");
            mailContent.append("<head>");
            mailContent.append("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\">");
            mailContent.append("<title></title>");
            mailContent.append("</head>");
            mailContent.append("<body>");
            mailContent.append("<iframe src=\"" + Constants.ASP_DOMAIN + "rent/mail/mailViewMonthCheck.do?apm=" + String.valueOf(dataMap.get("app_month")) + "\" width=\"100%\" height=\"500\" frameborder=\"0\" scrolling=\"yes\"></iframe>");
            mailContent.append("</body>");
            mailContent.append("</html>");

            // send Mail
            MailUtil.sendMail(toAddrs, mailFrom, mailSubject, mailContent.toString());

            success = true;
        } catch (Exception ex) {
            ex.printStackTrace();
            success = false;
        }

        return success;
    }
    
    
    public boolean htmlSendMail (Address[] toAddrs, String appno, String fileName, String mailSubject) {
        boolean success = false;

        try {
            String mailContent = this.fileToString(Constants.mailHtmlPath + fileName);

            // send Mail
            MailUtil.sendMail(toAddrs, mailFrom, mailSubject, mailContent);

            success = true;
        } catch (Exception ex) {
            ex.printStackTrace();
            success = false;
        }

        return success;
    }

    
    public boolean customSendMail(Address[] toAddrs, String mailSubject, String mailContent) {
        boolean success = false;

        try {

            // send Mail
            //MailUtil.sendMail(toAddrs, mailFrom, mailSubject, mailContent);
        	MailUtil.sendToMail(toAddrs, mailFrom, mailSubject, mailContent);

            success = true;
        } catch (Exception ex) {
            ex.printStackTrace();
            success = false;
        }

        return success;
    }

    
    public boolean test(Address[] toAddrs, String mailSubject, String mailContent) {
        boolean success = false;

        try {

            // send Mail
            MailUtil.sendMail(toAddrs, mailFrom, mailSubject, mailContent);

            success = true;
        } catch (Exception ex) {
            ex.printStackTrace();
            success = false;
        }

        return success;
    }
    


/*
    public boolean sendTagAlertMail(Address[] toAddrs, String shareNo, String contNo, String shareName)
    {
        boolean success = false;

        String mailSubject = "[POWER BAND] 태그글 알림 메일입니다.";
        String mailContent = "";

        try
        {
            //리얼
            mailContent = SendMail.fileToString("/usr/local/server/tomcat/webapps/share/resources/html/new_mail_info.html");

            //테스트 local
            mailContent = mailContent.replaceAll(":WEB_HOST:", "http://localhost:8080/");
            mailContent = mailContent.replaceAll(":SHARE_NAME:", shareName);
            mailContent = mailContent.replaceAll(":ACCESS_APP_CODE:", "http://localhost:8080/" + "/getMainShareData.do?shareNo=" + shareNo + "&contNo=" + contNo);

            // send Mail
            MailUtil.sendMail(toAddrs, mailSubject, mailContent);

            success = true;
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
            success = false;
        }

        return success;
    }

*/
    
    public static String fileToString(String p_file)
    {
        String allString = "";

        try
        {
            BufferedReader bufferReader = new BufferedReader(new InputStreamReader(new FileInputStream(File.separator + p_file), "euc-kr"));

            String bufferString = "";
            while((bufferString = bufferReader.readLine()) != null)
            allString += bufferString + "\n";
            bufferReader.close();

        } catch (Exception e)
        {
            e.printStackTrace();
        }

        return allString;
    }
    
    public boolean promote_sendMail (Address[] toAddrs, String mailFrom, String mailSubject, String url) {
        boolean success = false;

        try {
            String mailContent = "";
            mailContent += "<!DOCTYPE>";
            mailContent += "<html>";
            mailContent += "<head>";
            mailContent += "<meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\">";
            mailContent += "<title></title>";
            mailContent += "</head>";
            mailContent += "<body>";
            mailContent += "    <iframe src=" + url + "\" width=\"100%\" height=\"800\" frameborder=\"0\" scrolling=\"yes\"></iframe>";
            mailContent += "</body>";
            mailContent += "</html>";

            // send Mail
            MailUtil.sendMail(toAddrs, mailFrom, mailSubject, mailContent);

            success = true;
        } catch (Exception ex) {
            ex.printStackTrace();
            success = false;
        }
        return success;
    }
    
    public boolean contents_sendMail (Address[] toAddrs, HashMap<String, String> dataMap) {
        boolean success = false;

        try {
            String mailContent = "";
            String mailType = dataMap.get("mail_Type");
            String status = dataMap.get("status");
            
            String title = "";
            String statusText = "";
            
            if("C".equals(mailType)) {
            	title = "컨텐츠 제작";
            }else if("D".equals(mailType)) {
            	title = "전광판 게시";
            }
            
            if("3903".equals(status.toString())) {
            	statusText = "신청";
            }else if("3094".equals(status)) {
            	statusText = "승인요청";
            }else if("3099".equals(status)) {
            	statusText = "진행중";
            }else if("3095".equals(status)) {
            	statusText = "작업완료";
            }else if("3100".equals(status)) {
            	statusText = "반려";
            }
            
            String sm_Seq = dataMap.get("SM_SEQ");
            
            HashidsGenerator hashids = new HashidsGenerator(Constants.KUBE_SEQ_SALT, 15);
            sm_Seq = hashids.encrypt(Integer.parseInt(sm_Seq));
            
            String mailSubject = "["+title+ " " + statusText +" 안내 메일입니다.]";
            mailContent += "<!DOCTYPE>";
            mailContent += "<html>";
            mailContent += "<head>";
            mailContent += "<meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\">";
            mailContent += "<title></title>";
            mailContent += "</head>";
            mailContent += "<body>";
            mailContent += "<iframe src=\"" + Constants.ASP_DOMAIN + "/multi/mailContents.do?sm_seq=" + sm_Seq + "&contentType="+mailType+"&paramempno="+ dataMap.get("paramEmpno") +"\" width=\"100%\" height=\"500\" frameborder=\"0\" scrolling=\"yes\"></iframe>";
            /*mailContent += "<iframe src=\"http://localhost:8080/multi/mailContents.do?sm_seq=" + sm_Seq + "&contentType="+mailType+"\" width=\"100%\" height=\"500\" frameborder=\"0\" scrolling=\"yes\"></iframe>";*/
            mailContent += "</body>";
            mailContent += "</html>";
            
            // send Mail
            MailUtil.sendMail(toAddrs, mailFrom, mailSubject, mailContent);

            success = true;
        } catch (Exception ex) {
            ex.printStackTrace();
            success = false;
        }
        return success;
    }
    
    public static void main(String[] args)
    {

        try
        {
        	HashidsGenerator hashids = new HashidsGenerator(Constants.KUBE_SEQ_SALT, 15);
        	System.out.println(hashids.encrypt(Integer.parseInt("29232")));
        	
           /* Address[] toAddrs = new Address[1];
            InternetAddress address = new InternetAddress("fakessoo@neodreams.co.kr");
            InternetAddress address = new InternetAddress("ex190126@kepco.co.kr");
            toAddrs[0] = address;
            SendMail mail = SendMail.getInstance();
            //mail.sendMail(toAddrs, "2363", "", "touser");
            mail.sendMail(toAddrs, "2363", "touser", "멀티미디어 장비 테스트 입니다.");*/

        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
