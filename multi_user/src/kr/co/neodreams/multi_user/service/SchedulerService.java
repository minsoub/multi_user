
package kr.co.neodreams.multi_user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.mail.Address;
import javax.mail.internet.InternetAddress;

import org.springframework.beans.factory.annotation.Autowired;

import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.DateUtil;
import kr.co.neodreams.multi_user.common.NeoUtil;
import kr.co.neodreams.multi_user.common.mail.SendMail;
import kr.co.neodreams.multi_user.common.onestop.OneStopLogVO;
import kr.co.neodreams.multi_user.common.onestop.OneStopVO;
import kr.co.neodreams.multi_user.common.onestop.SendONESTOP;

public class SchedulerService {
	
	@Autowired
    private EquipManageService equipManageService;
	
	/**
     * 점검대장 월별 반출,반납 합계 로그 데이터 생성
     * 기본 룰은 매월 1일 00시 10분에 스케줄 돌면서(dispacher-servlet) "전월" 데이터 합계 생성
     * 결재자가 변경된 경우, 점검자(기안자)가 결재 진행을 하지 않은 건에 대해 url 콜로 재생성 가능. param=reqDate(201806)
     * force_reset : 점검자가 결재 진행 또는 최종 결재가 완료된 건을 강제적으로 삭제 인서트 처리 하기 위한 파라메터. force_reset=neodreams1324
     */
	public void insertMonthAppData() throws Exception {
    	try{
    		
    		//scheduler 가 매월 1일 00시 10분에 호출되나, java에서 한번 더 필터 처리
    		//오늘 날짜가 이 달의 1일인지 필터. 조건이 맞으면 이전 달 데이터 취합
    		if(DateUtil.getCurrentDate().equals(DateUtil.getFirstDayBeforeMonth(DateUtil.getCurrentDate(), 0))){
	    		
	    		/*
	    		RESET             Y or N
	    		#app_month#       20180601
	    		'$strdt$%'        201806
	    		#start_banpdt#    2018-06-01
	    		#end_banpdt#      2018-07-01
	    		*/
	    		HashMap<String, String> dataMap = new HashMap<>();
	    		
	   			String reqDate = DateUtil.getFirstDayBeforeMonth(DateUtil.getCurrentDate(), 1);
	   			dataMap.put("RESET", "N");
	    		dataMap.put("app_month", reqDate);
	    		dataMap.put("strdt", reqDate.substring(0, 6));
	    		dataMap.put("start_banpdt", NeoUtil.getDateTmFormat(reqDate, "-", "3"));
	    		dataMap.put("end_banpdt", NeoUtil.getDateTmFormat(DateUtil.getFirstDayAfterMonth(reqDate, 1), "-", "3"));
	    		
	    		equipManageService.insertMonthAppData(dataMap);
	    		
	    		HashMap<String, String> appList = equipManageService.getCheckAppList();
	    		HashMap<String, String> monthApproval_Info = equipManageService.getMonthApproval_Info(String.valueOf(dataMap.get("app_month")));
	    		
	    		SendMail sendMail = SendMail.getInstance();
	            Address[] toAddrs = new Address[1];
	            toAddrs[0] = new InternetAddress(appList.get("app_empno1") + "@kepco.co.kr");
	            sendMail.equip_month_app_sendMail(toAddrs, monthApproval_Info);
	    		
	            equipManageService.updateMonthApproval_Info(reqDate, "mail");
	            
	    		System.out.println("insertMonthAppData success" + DateUtil.getCurrentDateTime());
	    		SendONESTOP onestop = SendONESTOP.getInstance();
	    		//기안자
	    		String empNo = Constants.ONESTOP_WRITER;
	    		String empName = Constants.ONESTOP_WRITER_NAME;
	    		String retCode = "";
	    		List<OneStopLogVO> oneStopLogList = new ArrayList<>();
	    		OneStopLogVO osl = new OneStopLogVO();
	    		int logCnt = equipManageService.getOneStopLogCnt();
	    		
	    		OneStopVO osVO = new OneStopVO();
	    		String url = Constants.ASP_DOMAIN + "admin/checkAppMonthApproval.do?target_date="+dataMap.get("app_month");
	    		String systemKey = dataMap.get("app_month").substring(0, 6) + (String.valueOf(monthApproval_Info.get("reg_datetime")).replace("-", "").replace(":", "").replace(" ", "").substring(6, 14));
				String title = "[멀티미디어 장비대여 " + dataMap.get("app_month").substring(0, 4) + "년 " + dataMap.get("app_month").substring(4, 6) + "월 반입/반출 결재 건]";
	    		
				//최초 기안자(김종찬으로 임시 등록)
				osVO = setVoInfo("E", empName, systemKey, empName, empNo, title, url, "0");
	    		retCode = onestop.sendOneStop(osVO);
	    		
	    		osl.setEp_SignType("E");
				logCnt = logCnt+1;
				osl.setEp_LogSeq(logCnt);
				osl.setEp_DocData(dataMap.get("app_month"));
				osl.setEp_DocApprover(empNo);
				osl.setEp_SendData(osVO.toStringDefault());
				osl.setEp_ReciveData(retCode);
				oneStopLogList.add(osl);
				
	    		osVO = setVoInfo("S", monthApproval_Info.get("app_empno1"), systemKey, empName, empNo, title, url, "0");
	    		retCode = onestop.sendOneStop(osVO);
	    		
	    		osl = new OneStopLogVO();
	    		osl.setEp_SignType("E");
				logCnt = logCnt+1;
				osl.setEp_LogSeq(logCnt);
				osl.setEp_DocData(dataMap.get("app_month"));
				osl.setEp_DocApprover(monthApproval_Info.get("app_empno1"));
				osl.setEp_SendData(osVO.toStringDefault());
				osl.setEp_ReciveData(retCode);
				oneStopLogList.add(osl);
				
				equipManageService.insertOneStopLog(oneStopLogList);
    		}
    		
    	}catch(Exception e){
    		e.printStackTrace();
    		System.out.println("insertMonthAppData fail" + DateUtil.getCurrentDateTime());
    	}
    }

	/**
	 * socket 발송용 setVO
	 */
    private OneStopVO setVoInfo(String signType, String signEmpId, String systemKey, String writeEmpName, String writeEmpId, String title, String url, String status){
    	
    	OneStopVO osVO = new OneStopVO();
    	
    	osVO.setSigntype(signType);
		osVO.setSignempid(signEmpId);
		osVO.setSystemkey(systemKey);
		osVO.setWritename(writeEmpName);
		osVO.setWriteempid(writeEmpId);
		osVO.setTitle(title);
		osVO.setUrl(url);
		osVO.setStatus(status);
		
		return osVO;
    }
}

