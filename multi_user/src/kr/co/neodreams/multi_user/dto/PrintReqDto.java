package kr.co.neodreams.multi_user.dto;

import java.util.List;

import kr.co.neodreams.multi_user.base.dto.ItBaseDto;

/**
 * 플로터 출력 요청 DTO Class
 * 
 * @author hist
 *
 */
public class PrintReqDto extends ItBaseDto {
	private int			seq;			// 순번
	private String		subject;		// 제목
	private String		prt_req_dt;		// 출력 요청일
	private String		want_req_dt;	// 희망 요청 완료일
	private String		req_type;		// 출력 종류
	private String		prt_cnt;		// 출력 부수
	private String		prt_size;		// 규격
	private String		prt_size1;		// 가로 규격
	private String		prt_size2;		// 세로 규격
	private String		content;		// 기타 사항
	private String		req_type_nm;	// 출력 종류명
	private String		aprv_status_nm;	// 승인상태명
		
	// 파일
	private String freqs;				// 파일번호 리스트
	private String freq;				// 파일번호
	private String filename;			// 파일명
	private String maskname;			// 마스크명
	private String filesize;			// 파일사이즈
	private String phy_path;			// 물리적인 경로
	
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
	
	private List<PrintReqDto> attachList;

	

	public List<String> getStsList() {
		return stsList;
	}

	public void setStsList(List<String> stsList) {
		this.stsList = stsList;
	}

	public String getAprv_status_nm() {
		return aprv_status_nm;
	}

	public void setAprv_status_nm(String aprv_status_nm) {
		this.aprv_status_nm = aprv_status_nm;
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

	public String getReq_type_nm() {
		return req_type_nm;
	}

	public void setReq_type_nm(String req_type_nm) {
		this.req_type_nm = req_type_nm;
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

	public String getPrt_cnt() {
		return prt_cnt;
	}

	public void setPrt_cnt(String prt_cnt) {
		this.prt_cnt = prt_cnt;
	}

	public String getPrt_size() {
		return prt_size;
	}

	public void setPrt_size(String prt_size) {
		this.prt_size = prt_size;
	}

	public String getPrt_size1() {
		return prt_size1;
	}

	public void setPrt_size1(String prt_size1) {
		this.prt_size1 = prt_size1;
	}

	public String getPrt_size2() {
		return prt_size2;
	}

	public void setPrt_size2(String prt_size2) {
		this.prt_size2 = prt_size2;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFreqs() {
		return freqs;
	}

	public void setFreqs(String freqs) {
		this.freqs = freqs;
	}

	public String getFreq() {
		return freq;
	}

	public void setFreq(String freq) {
		this.freq = freq;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getMaskname() {
		return maskname;
	}

	public void setMaskname(String maskname) {
		this.maskname = maskname;
	}

	public String getFilesize() {
		return filesize;
	}

	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}

	public String getPhy_path() {
		return phy_path;
	}

	public void setPhy_path(String phy_path) {
		this.phy_path = phy_path;
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

	public List<PrintReqDto> getAttachList() {
		return attachList;
	}

	public void setAttachList(List<PrintReqDto> attachList) {
		this.attachList = attachList;
	}		

	
	
}
