package kr.co.neodreams.multi_user.common.onestop;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class OneStopVO {
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
	
	public String getSigntype() {
		return signtype;
	}
	public void setSigntype(String signtype) {
		this.signtype = signtype;
	}
	public String getSignempid() {
		return signempid;
	}
	public void setSignempid(String signempid) {
		this.signempid = signempid;
	}
	public String getSystemid() {
		return systemid;
	}
	public void setSystemid(String systemid) {
		this.systemid = systemid;
	}
	public String getSystemkey() {
		return systemkey;
	}
	public void setSystemkey(String systemkey) {
		this.systemkey = systemkey;
	}
	public String getDoctype() {
		return doctype;
	}
	public void setDoctype(String doctype) {
		this.doctype = doctype;
	}
	public String getDocdate() {
		return docdate;
	}
	public void setDocdate(String docdate) {
		this.docdate = docdate;
	}
	public String getWritename() {
		return writename;
	}
	public void setWritename(String writename) {
		this.writename = writename;
	}
	public String getWriteempid() {
		return writeempid;
	}
	public void setWriteempid(String writeempid) {
		this.writeempid = writeempid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	

    public String toStringDefault() {
    	return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
	}     
}
