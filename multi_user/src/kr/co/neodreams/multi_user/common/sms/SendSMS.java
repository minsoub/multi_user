package kr.co.neodreams.multi_user.common.sms;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

import kr.co.neodreams.multi_user.dto.RentDto;

import org.apache.log4j.Logger;

public class SendSMS{

    public static SendSMS getInstance()
    {
        return new SendSMS();
    }
    Logger log = Logger.getLogger(this.getClass());
    public static void main(String[] args)
    {
        try {
            List<RentDto> _cellNoList = new ArrayList<RentDto>();
            RentDto dto = new RentDto();
            dto.setHp("010-4661-5480");
            _cellNoList.add(dto);
            RentalSendThread send_thread = new RentalSendThread(new BigInteger("1"), "ex190126", _cellNoList);

            send_thread.start();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendAlertSMS(int key, String userId, String shareName, List<String> cellNoList)
    {
        try
        {
            SendThread send_thread = new SendThread(key, userId, cellNoList);
            send_thread.start();
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
            log.error("sendTagAlertSMS ERROR" + ex.getMessage());
        }
    }

    public void rentalSendSMS(BigInteger key, String msg, List<RentDto> cellNoList)
    {
        try
        {
            RentalSendThread send_thread = new RentalSendThread(key, msg, cellNoList);
            send_thread.start();
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
    
    public void rentalRequireSMS(BigInteger key, Integer appno, String msg, List<RentDto> cellNoList)
    {
        try
        {
            RentalRequireThread send_thread = new RentalRequireThread(key, appno, msg, cellNoList);
            send_thread.start();
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
    
}
