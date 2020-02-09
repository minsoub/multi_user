package kr.co.neodreams.multi_user.dto;

import java.util.List;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

/**
 * IT 플라자 게시판 항목 정의 클랙스 
 * @author minso
 *
 */
public class BoardDto  extends BasePagingDto{

	private int seq;					// 순번
	private String bbsid;				// 게시판 아이디
	private String categ;				// 카테고리
	private String ref;					// 글번호2
	private String step;				// 글번호3
	private String lev;					// 글번호4
	private String writer;				// 작성자
	private String subject;				// 제목
	private String content;				// 내용
	private String password;			// 비밀번호
	private String email;				// 메일주소
	private String hit;					// 조회수
	private String sts;					// 상태
	private String wtime;				// 작성일
	private String ip;					// IP 주소
	private String html;				// HTML 사용여부
	private String yndisplay;			// 게시여부
	private String contact;				// 연락처
	private String etc1;				// 기타정보 1
	private String etc2;				// 기타정보 2
	private String userid;				// 작성자 아이디
	private String notice;				// 공지여부 (Y = 공지)
	private String exist;				// 삭제여부 (Y : 삭제안됨, N : 삭제됨)
	private String comment_cnt;			// 댓글 개수
	
	private String searchString;
	
	// 파일
	private String freqs;				// 파일번호 리스트
	private String freq;				// 파일번호
	private String filename;			// 파일명
	private String maskname;			// 마스크명
	private String filesize;			// 파일사이즈
	
	private List<BoardDto> attachList;
	
	
	
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
	public List<BoardDto> getAttachList() {
		return attachList;
	}
	public void setAttachList(List<BoardDto> attachList) {
		this.attachList = attachList;
	}
	public String getSearchString() {
		return searchString;
	}
	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getBbsid() {
		return bbsid;
	}
	public void setBbsid(String bbsid) {
		this.bbsid = bbsid;
	}
	public String getCateg() {
		return categ;
	}
	public void setCateg(String categ) {
		this.categ = categ;
	}
	public String getRef() {
		return ref;
	}
	public void setRef(String ref) {
		this.ref = ref;
	}
	public String getStep() {
		return step;
	}
	public void setStep(String step) {
		this.step = step;
	}
	public String getLev() {
		return lev;
	}
	public void setLev(String lev) {
		this.lev = lev;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHit() {
		return hit;
	}
	public void setHit(String hit) {
		this.hit = hit;
	}
	public String getSts() {
		return sts;
	}
	public void setSts(String sts) {
		this.sts = sts;
	}
	public String getWtime() {
		return wtime;
	}
	public void setWtime(String wtime) {
		this.wtime = wtime;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getHtml() {
		return html;
	}
	public void setHtml(String html) {
		this.html = html;
	}
	public String getYndisplay() {
		return yndisplay;
	}
	public void setYndisplay(String yndisplay) {
		this.yndisplay = yndisplay;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getEtc1() {
		return etc1;
	}
	public void setEtc1(String etc1) {
		this.etc1 = etc1;
	}
	public String getEtc2() {
		return etc2;
	}
	public void setEtc2(String etc2) {
		this.etc2 = etc2;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	public String getExist() {
		return exist;
	}
	public void setExist(String exist) {
		this.exist = exist;
	}
	public String getComment_cnt() {
		return comment_cnt;
	}
	public void setComment_cnt(String comment_cnt) {
		this.comment_cnt = comment_cnt;
	}			
}
