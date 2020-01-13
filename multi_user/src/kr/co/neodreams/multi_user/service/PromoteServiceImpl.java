package kr.co.neodreams.multi_user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Address;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.base.service.BaseService;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.HashidsGenerator;
import kr.co.neodreams.multi_user.common.NeoUtil;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.common.mail.SendMail;
import kr.co.neodreams.multi_user.dao.PromoteDao;
import kr.co.neodreams.multi_user.dto.PromoteDto;

@Service
public class PromoteServiceImpl extends BaseService implements PromoteService{
	
	@Autowired
	PromoteDao promoteDao;
	
	private HashidsGenerator hashids = new HashidsGenerator(Constants.KUBE_SEQ_SALT, 15);
	
	@Override
    public List<HashMap<String, String>> getPromoteList(PromoteDto promoteDto) throws Exception {
    	return promoteDao.getPromoteList(promoteDto);
    }

	@Override
	public int getPromoteListCnt(PromoteDto promoteDto) throws Exception {
		return promoteDao.getPromoteListCnt(promoteDto);
	}
	
	@SuppressWarnings("unchecked")
	@Override
    public String insertUpdatePromote(PromoteDto promoteDto, HttpServletRequest request) throws Exception {
    	String retVal = "false"; 
    	String act_gubun = request.getParameter("act_gubun");
		int newP_seq = 0;
		
    	try{
			String SESS_EMPNO = (String) request.getSession().getAttribute("SESS_EMPNO");
			String SESS_DEPT_CODE = ((HashMap<String, String>) request.getSession().getAttribute("SESS_USER_INFO")).get("deptno");
			
			
			if(StringUtil.isNotEmpty(act_gubun)){
				
				//insert 신청, 2-승인, 3-반려, 4-취소, 6-완료
				if("insert".equals(act_gubun)){
					promoteDto.setP_date(promoteDto.getP_date().replace("-", ""));
					promoteDto.setStart_time(request.getParameter("start_time1") + request.getParameter("start_time2"));
					promoteDto.setEnd_time(request.getParameter("end_time1") + request.getParameter("end_time2"));
					promoteDto.setReq_dept_code(SESS_DEPT_CODE);
					promoteDto.setReq_empno(SESS_EMPNO);
					promoteDto.setP_status(1);
					
					newP_seq = promoteDao.insertPromote(promoteDto);
				}else{
					promoteDto.setP_status(Integer.parseInt(act_gubun));
					
					promoteDao.updatePromote(promoteDto);
				}
				
				retVal = "true";
			}
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally {
			if("true".equals(retVal)){
				
				String url = "http://media.hq";
				
				
				if("insert".equals(act_gubun)){
					//사용자가 신청->관리자들에게 메일 발송
					
					//a 시퀀스, b 상태값, c 사용자 관리자 링크 페이지 구분(3, 4)
					//mail html치환 문제로 delimiter(MULTI) 사용 
					//q=aMULTIbMULTIc
					url = url + "/promote/promoteMail.do?q=" + hashids.encrypt(newP_seq) + "MULTI" + hashids.encrypt(1) + "MULTI" + hashids.encrypt(4);
					
					log.debug("=================================SENDMAIL START==============================");
	                Address[] toAddrs = null;
	                List<HashMap<String, String>> result = promoteDao.getSaList();
	                if (result != null)
	                    toAddrs = new Address[result.size()];

	                int cnt = 0;
	                for (Map<String, String> adminInfo : result) {
	                    String mailno = adminInfo.get("mailno");
	                    
	                    InternetAddress address = new InternetAddress(mailno + "@kepco.co.kr");
	                    toAddrs[cnt] = address;
	                    
	                    cnt++; 
	                }
	                
	                SendMail mail = SendMail.getInstance();
	                
	                String mailSubject = "[멀티미디어 행사신청 알림] " 
	                			+ ((HashMap<String, String>) request.getSession().getAttribute("SESS_USER_INFO")).get("user_dept_name") 
	                			+ " " +  (String) request.getSession().getAttribute("SESS_USER_NAME") 
	                			+ " " + NeoUtil.getDateTmFormat(promoteDto.getP_date(), "-", "3") 
	                			+ " " + request.getParameter("start_time1") + ":" + request.getParameter("start_time2") + " ~ " 
	                			+ request.getParameter("end_time1") + ":" + request.getParameter("end_time2");
	                
	                mail.promote_sendMail(toAddrs, ((HashMap<String, String>) request.getSession().getAttribute("SESS_USER_INFO")).get("mailno") + "@kepco.co.kr", mailSubject, url);
	                log.debug("=================================SENDMAIL FINISH==============================");
	                
					
				}else if("2".equals(act_gubun)
						|| "3".equals(act_gubun)){
					//관리자가 승인, 반려->사용자에게 메일 발송
					//a 시퀀스, b 상태값, c 사용자 관리자 링크 페이지 구분(3, 4)
					//q=aMULTIbMULTIc
					url = url + "/promote/promoteMail.do?q=" + hashids.encrypt(promoteDto.getP_seq()) + "MULTI" + hashids.encrypt(Integer.parseInt(act_gubun)) + "MULTI" + hashids.encrypt(3);
					
					log.debug("=================================SENDMAIL START==============================");
	                Address[] toAddrs = null;
	                List<HashMap<String, String>> result = promoteDao.getSaList();
	                if (result != null)
	                    toAddrs = new Address[result.size()];

	                int cnt = 0;
	                for (Map<String, String> adminInfo : result) {
	                    String mailno = adminInfo.get("mailno");
	                    
	                    InternetAddress address = new InternetAddress(mailno + "@kepco.co.kr");
	                    toAddrs[cnt] = address;
	                    
	                    cnt++;
	                }
	                
	                HashMap<String, String> detail = promoteDao.getPromoteDetail(promoteDto);
	                
	                SendMail mail = SendMail.getInstance();
	                
	                String mailSubject = "[멀티미디어 행사신청 " + ("2".equals(act_gubun) ? "승인" : "반려") + "]"
	                			+ detail.get("dept_name")
	                			+ " " +  detail.get("name") 
	                			+ " " + NeoUtil.getDateTmFormat(detail.get("p_date"), "-", "3") 
	                			+ " " + NeoUtil.getDateTmFormat(detail.get("start_time"), "", "5") + " ~ " 
	                			+ NeoUtil.getDateTmFormat(detail.get("end_time"), "", "5");
	                System.out.println(mailSubject);
	                mail.promote_sendMail(toAddrs, detail.get("mailno") + "@kepco.co.kr", mailSubject, url);
	                log.debug("=================================SENDMAIL FINISH==============================");
				}
			}
		}
		
    	return retVal;
    }
	
	@Override
    public HashMap<String, String> getPromoteDetail(PromoteDto promoteDto) throws Exception {
    	return promoteDao.getPromoteDetail(promoteDto);
    }
	
	@Override
    public List<HashMap<String, String>> getSaList() throws Exception {
    	return promoteDao.getSaList();
    }
	
	@Override
	public String insertDeleteSa(PromoteDto promoteDto, HttpServletRequest request) throws Exception {
		
		String retVal = "false"; 
		
		try{
			
			String act_gubun = request.getParameter("act_gubun");
			
			if("D".equals(act_gubun)){
				promoteDao.deleteSa(promoteDto);
			}else if("C".equals(act_gubun)){
				
				promoteDto.setReg_empno((String) request.getSession().getAttribute("SESS_EMPNO"));
				
				promoteDao.insertSa(promoteDto);	
			}

			retVal = "true";
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error( "failed!", e );
		}
		
		return retVal;
	}
	
	@Override
	public List<HashMap<String, String>> getUserList(PromoteDto promoteDto) throws Exception {
		return promoteDao.getUserList(promoteDto);
	}
	
	@Override
	public int getUserListCnt(PromoteDto promoteDto) throws Exception {
		return promoteDao.getUserListCnt(promoteDto);
	}
}
