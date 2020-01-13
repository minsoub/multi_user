package kr.co.neodreams.multi_user.service;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.mail.Address;

import kr.co.neodreams.multi_user.common.CommonUtil;
import kr.co.neodreams.multi_user.common.DateUtil;
import kr.co.neodreams.multi_user.common.mail.SendMail;
import kr.co.neodreams.multi_user.common.sms.SendSMS;
import kr.co.neodreams.multi_user.dto.RentDto;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 1. 스케줄을 통해 sendSMS 실행.
 * 2. rentalSendSMS 테이블에 send_status != 9999 건만 전송 대상
 * 3. 최종 일자가 성공인 경우, 임시 테이블 데이터를 실제 테이블에 insert 한다
 */
public class RentalSendSMS {

    @Autowired
    private CommonService commonService;

    public synchronized void sendSMS() throws Exception{

        System.out.println("#######################sendSMS() start#######################");
        System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
        System.out.println("#######################sendSMS() start#######################");

        String outString = "";
        String outMailAppString = "";
        String outMailRemainString = "";

        try{
            List<RentDto> targetList = commonService.getRentalSendSMSTargetList();

            if(targetList != null
                    && targetList.size() > 0){
                
                //String msg = "[장비반납요청] 부서 이동 전 장비 반납을 요청 드립니다..";
            	String msg = "[반납요청] 부서 이동 전 설비 반납 요청.";
                msg += " * 장소 : 3층 멀티미디어센터(6383)";
                //msg += "오늘도 즐거운 하루 되시기 바랍니다!";
                //msg += "감사합니다";
                //msg += "[ICT인프라처 ICT서비스부(6266)]";

                SendSMS sms = SendSMS.getInstance();
                sms.rentalSendSMS(new BigInteger(DateUtil.getCurrentDateTime()), msg, targetList);

                
                
                List<RentDto> adminList = new ArrayList<RentDto>(); 
                
                RentDto dto = new RentDto();
                dto.setHp("010-8490-7704");
                
                adminList.add(0, dto);
                
                msg = "[반납요청] 부서 이동 전 설비 반납 요청 " + targetList.size() + "건 발송 안내 문자입니다.";
                SendSMS sms2 = SendSMS.getInstance();
                sms2.rentalSendSMS(new BigInteger(DateUtil.getCurrentDateTime()), msg, adminList);
                		
            }else{
                outString = "dept move data is null. this is ok";
            }
        }catch (Exception e){
            e.printStackTrace();
            outString = e.toString();
        }finally{

            System.out.println("#######################sendSMS() end#######################");
            System.out.println(DateUtil.getCurrentDateTime() + "::::" + outString);
            System.out.println("#######################sendSMS() end#######################");
        }


        try {

            /*인수인계 승인메일 발송*/

            System.out.println("#######################sendMailApproval() start#######################");
            System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
            System.out.println("#######################sendMailApproval() start#######################");


            List<RentDto> mailApprovalTargetList = commonService.getMailApprovalTargetList();

            for ( int i = 0 ; i < mailApprovalTargetList.size() ; i++ ){

                String appno = String.valueOf(mailApprovalTargetList.get(i).getAPPNO());
                String uhseq = mailApprovalTargetList.get(i).getUHSEQ();

                /*인수자에게 인수요청*/
                SendMail sd = SendMail.getInstance();
                HashMap<String, String> addrs = new HashMap<String, String>();
                addrs.put("email", mailApprovalTargetList.get(i).getINSUNO() + "@kepco.co.kr");
                Address[] toAddrs = CommonUtil.mapToAddresses(addrs);

                try {
                    sd.sendMail(toAddrs, appno, "chgEu", uhseq, "[멀티미디어 설비사용자 인수인계] "+mailApprovalTargetList.get(i).getINGAENM()+" 님께서 설비사용 인수요청을 하셨음을 알려드립니다.");
                    outMailAppString = "As the data, uhseq is " + uhseq + " and appno is " + appno + ", The approval mail of handing over is sent successfully.";
                } catch (Exception e) {
                    e.printStackTrace();
                    outMailAppString = "As the data, uhseq is " + uhseq + " and appno is " + appno + ", The approval mail of handing over is failed and happended the problem";
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            System.out.println("#######################sendMailApproval() end#######################");
            System.out.println(DateUtil.getCurrentDateTime() + "::::" + outMailAppString);
            System.out.println("#######################sendMailApproval() end#######################");

        }


        try {

            /*대여기간 만료전 메일 및 SMS 발송*/

            System.out.println("#######################sendRemainDateMail() start#######################");
            System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
            System.out.println("#######################sendRemainDateMail() start#######################");

            List<RentDto> mailRemainDateTargetList = commonService.getMailRemainDateTargetList("remain");

            for( int i = 0 ; i < mailRemainDateTargetList.size() ; i++ ){

                String appno = String.valueOf(mailRemainDateTargetList.get(i).getAPPNO());
                String appnum = mailRemainDateTargetList.get(i).getAPPNUM();
                String remaindt = mailRemainDateTargetList.get(i).getREMAINDT();
                SendMail sd = SendMail.getInstance();
                SendSMS ss =  SendSMS.getInstance();
                HashMap<String, String> addrs = null;
                Address[] toAddrs = null;

                /*신청자 대여기간 만료전 알림 메일 및 SMS 발송*/

                String appeno = mailRemainDateTargetList.get(i).getAPPENO();
                String appenm = mailRemainDateTargetList.get(i).getAPPENM();
                String enddt = mailRemainDateTargetList.get(i).getENDDT().substring(0, 4) + "." + mailRemainDateTargetList.get(i).getENDDT().substring(4, 6) + "." + mailRemainDateTargetList.get(i).getENDDT().substring(6, 8);
                String[] eqaliasArr = mailRemainDateTargetList.get(i).getEQALIAS().split(",");

                if(!StringUtils.isEmpty(appeno)){

                    addrs = new HashMap<String, String>();
                    addrs.put("email", appeno + "@kepco.co.kr");
                    toAddrs = CommonUtil.mapToAddresses(addrs);

                    try {
                    	/*신청자 알림메일 발송*/
                        sd.sendMail(toAddrs, appno, "info", "", "[신청자  멀티미디어 대여 반납일 알림] "+appenm+"님께서 대여하신 설비의 대여기간이 "+remaindt+"일 남았습니다.");
                        outMailRemainString = "As the data, appno is " + appno + ", [APPENO] The alarm mail of remaining date is sent successfully.";
                    } catch (Exception e) {
                        e.printStackTrace();
                        outMailRemainString = "As the data, appno is " + appno + ", [APPENO] The alarm mail of remaining date is failed and happended the problem";
                    }

                    String msg = "[설비대여반납일알림] "+appenm+"님께서 대여하신 설비의 대여기간이 "+remaindt+"일 남았습니다.";
                    /*String msg = "[신청자 멀티미디어 대여 반납일 알림] "+appenm+"님께서 대여하신 장비의 대여기간이 "+remaindt+"일 남았습니다.";
                    msg += "* 신청번호 : " + appnum;
                    if(eqaliasArr.length > 1){
                    	msg += "* 대여장비 : " + eqaliasArr[0] + " 외 " + (eqaliasArr.length -1) + "건";
                    }else{
                    	msg += "* 대여장비 : " + eqaliasArr[0];
                    }                    
                    msg += "* 반납일 : " +enddt;
                    msg += "* 반납장소 : 본관 3층 멀티미디어센터(6383)";
                    msg += "오늘도 즐거운 하루 되시기 바랍니다!";
                    msg += "감사합니다";
                    msg += "[ICT인프라처 ICT서비스부(6266)]";*/
                    
                    
                    List<RentDto> cellNoList = new ArrayList<RentDto>();
                    RentDto tmpDto = new RentDto();
                    tmpDto.setHp(mailRemainDateTargetList.get(i).getAPPHP());
                    //cellNoList.get(i).setHp(mailRemainDateTargetList.get(i).getAPPHP());
                    cellNoList.add(tmpDto);
                    try {
                        if(cellNoList.size() > 0){
                            ss.rentalRequireSMS(new BigInteger(DateUtil.getCurrentDateTime()), Integer.parseInt(appno), msg, cellNoList);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            System.out.println("#######################sendRemainDateMail() end#######################");
            System.out.println(DateUtil.getCurrentDateTime() + "::::" + outMailRemainString);
            System.out.println("#######################sendRemainDateMail() end#######################");
        }
        
        
        try {
            /*장비 미반납 알림 메일 및 SMS 발송*/

            System.out.println("#######################sendNoReturnMail() start#######################");
            System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
            System.out.println("#######################sendNoReturnMail() start#######################");

            List<RentDto> mailNoReturnTargetList = commonService.getMailRemainDateTargetList("noReturn");
            
            for( int i = 0 ; i < mailNoReturnTargetList.size() ; i++ ){

                String appno = String.valueOf(mailNoReturnTargetList.get(i).getAPPNO());
                String appnum = mailNoReturnTargetList.get(i).getAPPNUM();
                String remaindt = mailNoReturnTargetList.get(i).getREMAINDT();
                SendMail sd = SendMail.getInstance();
                SendSMS ss =  SendSMS.getInstance();
                HashMap<String, String> addrs = null;
                Address[] toAddrs = null;

                /*신청자 장비 미반납 알림 메일 및 SMS 발송*/

                String appeno = mailNoReturnTargetList.get(i).getAPPENO();
                String appenm = mailNoReturnTargetList.get(i).getAPPENM();
                String enddt = mailNoReturnTargetList.get(i).getENDDT().substring(0, 4) + "." + mailNoReturnTargetList.get(i).getENDDT().substring(4, 6) + "." + mailNoReturnTargetList.get(i).getENDDT().substring(6, 8);
                String[] eqaliasArr = mailNoReturnTargetList.get(i).getEQALIAS().split(",");

                if(!StringUtils.isEmpty(appeno)){

                    addrs = new HashMap<String, String>();
                    addrs.put("email", appeno + "@kepco.co.kr");
                    toAddrs = CommonUtil.mapToAddresses(addrs);

                    try {
                        /*신청자 알림메일 발송*/
                        sd.sendMail(toAddrs, appno, "info", "", "[신청자  멀티미디어 대여 미반납 알림] "+appenm+"님께서 대여하신 설비가 반납되지 않았음을 알려드립니다.");
                        outMailRemainString = "As the data, appno is " + appno + ", [APPENO] The alarm mail of no returned equips is sent successfully.";
                    } catch (Exception e) {
                        e.printStackTrace();
                        outMailRemainString = "As the data, appno is " + appno + ", [APPENO] The alarm mail of no returned equips is failed and happended the problem";
                    }

                    //String msg = "[설비대여미반납알림] "+appenm+"님께서 대여하신 설비가 반납되지 않았음을 알려드립니다";
                    String msg = "[설비대여미반납알림] "+appenm+"님께서 대여하신 설비를 반납해주시기 바랍니다.";
                    /*String msg = "[신청자 멀티미디어 대여 미반납 알림] "+appenm+"님께서 대여하신 장비가 반납되지 않았음을 알려드립니다.";
                    msg += "* 신청번호 : " + appnum;
                    if(eqaliasArr.length > 1){
                        msg += "* 대여장비 : " + eqaliasArr[0] + " 외 " + (eqaliasArr.length -1) + "건";
                    }else{
                        msg += "* 대여장비 : " + eqaliasArr[0];
                    }                    
                    msg += "* 반납일 : " +enddt;
                    msg += "* 반납장소 : 본관 3층 멀티미디어센터(6383)";
                    msg += "오늘도 즐거운 하루 되시기 바랍니다!";
                    msg += "감사합니다";
                    msg += "[ICT인프라처 ICT서비스부(6266)]";*/
                    
                    List<RentDto> cellNoList = new ArrayList<RentDto>();
                    RentDto tmpDto = new RentDto();
                    tmpDto.setHp(mailNoReturnTargetList.get(i).getAPPHP());
                    //cellNoList.get(i).setHp(mailNoReturnTargetList.get(i).getAPPHP());
                    cellNoList.add(tmpDto);
                    try {
                        if(cellNoList.size() > 0){
                            ss.rentalRequireSMS(new BigInteger(DateUtil.getCurrentDateTime()), Integer.parseInt(appno), msg, cellNoList);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (Exception e) {
                e.printStackTrace();
        } finally {
            
            System.out.println("#######################sendNoReturnMail() end#######################");
            System.out.println(DateUtil.getCurrentDateTime() + "::::" + outMailRemainString);
            System.out.println("#######################sendNoReturnMail() end#######################");
        }
    }
}
