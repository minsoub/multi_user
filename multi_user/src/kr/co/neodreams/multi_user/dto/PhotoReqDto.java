package kr.co.neodreams.multi_user.dto;

import java.util.List;

import kr.co.neodreams.multi_user.base.dto.ItBaseDto;

/**
 * 사진촬영요청 DTO Class
 * 
 * @author hist
 *
 */
public class PhotoReqDto extends ItBaseDto {
	private int			seq;			// 순번
	private String		subject;		// 제목
	private String		prt_req_dt;		// 출력 요청일
	private String		want_req_dt;	// 희망 요청 완료일
	private String		req_type;		// 사진 종류
	private String		prt_cnt;		// 출력 개수
	private String		add_type;		// 추가 사항
	private String		content;		// 기타 사항
	private String		req_type_nm;	// 출력 종류명
	private String		aprv_status_nm;	// 승인상태명

	
	// 검색 조건
	private String searchFromDt;
	private String searchToDt;
	private String searchString;		// 제목 또는 신청자명
	private String sts1;			// 전체
	private String sts2;			// 신청
	private String sts3;			// 진행중
	private String sts4;			// 완료
	private String sts5;			// 사용자취소
	
	private List<String> stsList;

	
	
	public String getPrt_cnt() {
		return prt_cnt;
	}

	public void setPrt_cnt(String prt_cnt) {
		this.prt_cnt = prt_cnt;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getPrt_req_dt() {
		return prt_req_dt;
	}

	public void setPrt_req_dt(String prt_req_dt) {
		this.prt_req_dt = prt_req_dt;
	}

	public String getWant_req_dt() {
		return want_req_dt;
	}

	public void setWant_req_dt(String want_req_dt) {
		this.want_req_dt = want_req_dt;
	}

	public String getReq_type() {
		return req_type;
	}

	public void setReq_type(String req_type) {
		this.req_type = req_type;
	}

	public String getAdd_type() {
		return add_type;
	}

	public void setAdd_type(String add_type) {
		this.add_type = add_type;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReq_type_nm() {
		return req_type_nm;
	}

	public void setReq_type_nm(String req_type_nm) {
		this.req_type_nm = req_type_nm;
	}

	public String getAprv_status_nm() {
		return aprv_status_nm;
	}

	public void setAprv_status_nm(String aprv_status_nm) {
		this.aprv_status_nm = aprv_status_nm;
	}

	public String getSearchFromDt() {
		return searchFromDt;
	}

	public void setSearchFromDt(String searchFromDt) {
		this.searchFromDt = searchFromDt;
	}

	public String getSearchToDt() {
		return searchToDt;
	}

	public void setSearchToDt(String searchToDt) {
		this.searchToDt = searchToDt;
	}

	public String getSearchString() {
		return searchString;
	}

	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}

	public String getSts1() {
		return sts1;
	}

	public void setSts1(String sts1) {
		this.sts1 = sts1;
	}

	public String getSts2() {
		return sts2;
	}

	public void setSts2(String sts2) {
		this.sts2 = sts2;
	}

	public String getSts3() {
		return sts3;
	}

	public void setSts3(String sts3) {
		this.sts3 = sts3;
	}

	public String getSts4() {
		return sts4;
	}

	public void setSts4(String sts4) {
		this.sts4 = sts4;
	}

	public String getSts5() {
		return sts5;
	}

	public void setSts5(String sts5) {
		this.sts5 = sts5;
	}

	public List<String> getStsList() {
		return stsList;
	}

	public void setStsList(List<String> stsList) {
		this.stsList = stsList;
	}
	
	
}
