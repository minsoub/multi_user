package kr.co.neodreams.multi_user.common.onestop;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

public class OneStopLogVO extends BasePagingDto{
	/**
	 * ONESTOP 메시지
	 * <pre>
     * int ep_LogSeq []				//로그 시퀀스
     * String ep_SignType [1자리]		//결재구분
     * String ep_DocData [8자리]		//결재문서 번호(데이터 파라미터)
     * String ep_DocApprover [20자리]		//결재자 또는 기안자
     * String ep_SendData [MAX]		//EP 전송 데이터
     * String ep_ReciveData [MAX]	//EP 응답 코드 또는 Exception 내용
     * String ep_SendDate [datetime]//EP 전송 날짜
     * </pre>
	 */
	
	private	int		ep_LogSeq;
	private	String	ep_SignType;
	private	String	ep_DocData;
	private	String	ep_DocApprover;
	private	String	ep_SendData;
	private	String	ep_ReciveData;
	private	String	ep_SendDate;
	
	public int getEp_LogSeq() {
		return ep_LogSeq;
	}
	public void setEp_LogSeq(int ep_LogSeq) {
		this.ep_LogSeq = ep_LogSeq;
	}
	public String getEp_SignType() {
		return ep_SignType;
	}
	public void setEp_SignType(String ep_SignType) {
		this.ep_SignType = ep_SignType;
	}
	public String getEp_DocData() {
		return ep_DocData;
	}
	public void setEp_DocData(String ep_DocData) {
		this.ep_DocData = ep_DocData;
	}
	public String getEp_DocApprover() {
		return ep_DocApprover;
	}
	public void setEp_DocApprover(String ep_DocApprover) {
		this.ep_DocApprover = ep_DocApprover;
	}
	public String getEp_SendData() {
		return ep_SendData;
	}
	public void setEp_SendData(String ep_SendData) {
		this.ep_SendData = ep_SendData;
	}
	public String getEp_ReciveData() {
		return ep_ReciveData;
	}
	public void setEp_ReciveData(String ep_ReciveData) {
		this.ep_ReciveData = ep_ReciveData;
	}
	public String getEp_SendDate() {
		return ep_SendDate;
	}
	public void setEp_SendDate(String ep_SendDate) {
		this.ep_SendDate = ep_SendDate;
	}
	
	
}
