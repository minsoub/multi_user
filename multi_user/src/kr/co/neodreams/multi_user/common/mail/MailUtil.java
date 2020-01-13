package kr.co.neodreams.multi_user.common.mail;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import kr.co.neodreams.multi_user.common.DateUtil;

import org.apache.log4j.Logger;

public class MailUtil {
//    private static String mailServerName = Constant.MAIL_SERVER_NAME;
//    private static String mailServerPort = Constant.MAIL_SERVER_PORT;
//    private static String mailSenderName = Constant.MAIL_SENDER_NAME;
//    private static String mailUserId = Constant.MAIL_USERID;C
//    private static String mailFrom = Constant.MAIL_FROM;
//    private static String mailPassword = Constant.MAIL_PASSWORDC;

//    private static String mailServerName = "localhost"; //추후 localhost
//    private static String mailServerPort = "40025";
	
    private static String mailServerName = "mail.neodreams.co.kr"; /*추후 localhost*/
    private static String mailServerPort = "25";
    private static String mailSenderName = "MULTIMEDIA";

    public static void sendMail(Address[] toAddrs, String mailFrom, String subject, String messageText)
        throws AddressException, MessagingException, UnsupportedEncodingException
    {
        sendMail(toAddrs, subject, messageText, mailFrom, mailSenderName);
    }

    public static void sendMail(Address[] toAddrs, String subject, String messageText, String from, String senderName)
        throws AddressException, MessagingException, UnsupportedEncodingException
    {
        /** LOGGER */
        Logger log = Logger.getLogger("MAIL");

        // Create session
        Properties mailProps = new Properties();
        mailProps.put("mail.smtp.host", mailServerName);
        mailProps.put("mail.smtp.port", mailServerPort);
        

        Session mailSession = Session.getInstance(mailProps);
        InternetAddress fromAddr = new InternetAddress(from, senderName);
        
        // Create and initialize message
        MimeMessage message = new MimeMessage(mailSession);
        message.setFrom(fromAddr);

        message.setRecipients(Message.RecipientType.TO, toAddrs);
        message.setSubject(subject, "EUC-KR");
        message.setContent(messageText.toString(), "text/html; charset=euc-kr");
        try
        {
            Transport trans = mailSession.getTransport("smtp");
            trans.connect();
            trans.sendMessage(message, message.getAllRecipients());
            System.out.println(" MailsendOK:::::::::::::::::" + DateUtil.getCurrentDateTime());
        } catch (Exception ex)
        {
            ex.printStackTrace();
            throw new MessagingException(ex.getMessage());
        }
    }
    
    public static void sendToMail(Address[] toAddrs, String mailFrom, String subject, String messageText)
            throws AddressException, MessagingException, UnsupportedEncodingException
        {
    		sendToMail(toAddrs, subject, messageText, mailFrom, mailSenderName);
        }

    public static void sendToMail(Address[] toAddrs, String subject, String messageText, String from, String senderName)
        throws AddressException, MessagingException, UnsupportedEncodingException
    {
        /** LOGGER */
        Logger log = Logger.getLogger("MAIL");

        // Create session
        Properties mailProps = new Properties();
        mailProps.put("mail.smtp.host", mailServerName);
        mailProps.put("mail.smtp.port", mailServerPort);

        Session mailSession = Session.getInstance(mailProps);
        InternetAddress fromAddr = new InternetAddress(from, senderName);

        // Create and initialize message
        MimeMessage message = new MimeMessage(mailSession);
        message.setFrom(fromAddr);

        message.setRecipients(Message.RecipientType.TO, toAddrs);
        message.setSubject(subject, "EUC-KR");
        message.setText(messageText, "EUC-KR");
        message.setHeader("content-Type", "text/html");
        
        try
        {
            Transport trans = mailSession.getTransport("smtp");
            trans.connect();
            trans.send(message);
            System.out.println(" sendToMailOK:::::::::::::::::" + DateUtil.getCurrentDateTime());
        } catch (Exception ex)
        {
            ex.printStackTrace();
            throw new MessagingException(ex.getMessage());
        }
    }

//    static class PopupAuthenticator extends Authenticator
//    {
//        public PasswordAuthentication getPasswordAuthentication()
//        {
//            return new PasswordAuthentication(mailUserId, mailPassword);
//        }
//    }

//  /**
//  * @param args
//  */
// public static void main(String[] args)
// {
//   try {
//     MailUtil.sendMail("wlghksdl@naver.com", "테스트 ", "TEST MAIL SUCCESS!!", "ex190126@kepco.co.kr", "devUSer");
//   } catch (Exception e) {
//     e.printStackTrace();
// }
// }
}
