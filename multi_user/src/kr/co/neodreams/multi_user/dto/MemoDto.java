package kr.co.neodreams.multi_user.dto;

import java.util.List;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

public class MemoDto extends BasePagingDto{

	private int    num;				// 게시글 번호
	private String subject;			// 제목
	private String writer;			// 작성자
	private String sosok;			// 소속
	private String pdsfile;			// 업로드파일명
	private String email;			// 메일주소
	private String passwd;			// 패스워드
	private String reg_date;		// 작성일자
	private String content;			// 내용
	private String visited; 		// 조회수
	private String html;			// HTML 여부 (1, 0)
	private String ref;				// 참조번호
	private String ref_step;		// 게시글 순서-스탭
	private String re_level;		// 게시글 레벨
	private String listnum;			// 리스트번호
	private String dirname;			// 디렉토리명
	private String host_ip;			// IP
	
	
	private String searchString;
	private String bbsid;
	
	// 파일
	private String freqs;				// 파일번호 리스트
	private String freq;				// 파일번호
	private String seq;					// 공지사항 글번호
	private String filename;			// 파일명
	private String maskname;			// 마스크명
	private String filesize;			// 파일사이즈
	private String phy_path;			// 물리적인 경로
	
	private List<MemoDto> attachList;

	
	
	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getSosok() {
		return sosok;
	}

	public void setSosok(String sosok) {
		this.sosok = sosok;
	}

	public String getPdsfile() {
		return pdsfile;
	}

	public void setPdsfile(String pdsfile) {
		this.pdsfile = pdsfile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getVisited() {
		return visited;
	}

	public void setVisited(String visited) {
		this.visited = visited;
	}

	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

	public String getRef() {
		return ref;
	}

	public void setRef(String ref) {
		this.ref = ref;
	}

	public String getRef_step() {
		return ref_step;
	}

	public void setRef_step(String ref_step) {
		this.ref_step = ref_step;
	}

	public String getRe_level() {
		return re_level;
	}

	public void setRe_level(String re_level) {
		this.re_level = re_level;
	}

	public String getListnum() {
		return listnum;
	}

	public void setListnum(String listnum) {
		this.listnum = listnum;
	}

	public String getDirname() {
		return dirname;
	}

	public void setDirname(String dirname) {
		this.dirname = dirname;
	}

	public String getHost_ip() {
		return host_ip;
	}

	public void setHost_ip(String host_ip) {
		this.host_ip = host_ip;
	}

	public String getSearchString() {
		return searchString;
	}

	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}

	public String getBbsid() {
		return bbsid;
	}

	public void setBbsid(String bbsid) {
		this.bbsid = bbsid;
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

	public List<MemoDto> getAttachList() {
		return attachList;
	}

	public void setAttachList(List<MemoDto> attachList) {
		this.attachList = attachList;
	}
	
	
	
}
