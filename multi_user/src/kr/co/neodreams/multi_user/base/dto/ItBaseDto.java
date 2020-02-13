package kr.co.neodreams.multi_user.base.dto;

public class ItBaseDto {
	private int pageNo;			// 페이지
	private int perPageCnt;		// 1페이지당 노출 갯수
	private int pageRange;			// 노출 페이징수
	private int totalCnt;			// 게시물 총 갯수
	
	private int pageStartNo;		// 페이징시 시작 
	private int pageEndNo;			// 페이징시 종료
	
	private String sort;			// 정렬조건
	private int menuID;
	private String bbsid;			// 게시판구분 : 10028 플로터요청  10029  사진촬영
	
	private String reg_id;			// 등록자 ID
	private String reg_nm;			// 등록자명
	private String reg_dept_nm;		// 등록자부서명 
	private String reg_tel;			// 등록자 전화번호
	private String reg_email;		// 등록자 메일주소
	private String reg_ip;			// 등록자 IP
	private String reg_dt;			// 등록일자
	private String del_yn;			// 삭제여부
	private String aprv_id;			// 승인자 아이디
	private String aprv_ip;			// 승인자 IP
	private String aprv_status;		// 처리 상태
	private String aprv_dt;			// 승인일자
	private String memo;			// 승인 메모
	
	public ItBaseDto()
	{
		this.pageNo = 1;
		this.perPageCnt = 10;
		this.pageRange = 10;
		this.sort = "";
	}
	public String getBbsid() {
		return bbsid;
	}
	public void setBbsid(String bbsid) {
		this.bbsid = bbsid;
	}
	public String getReg_dept_nm() {
		return reg_dept_nm;
	}
	public void setReg_dept_nm(String reg_dept_nm) {
		this.reg_dept_nm = reg_dept_nm;
	}
	public String getReg_tel() {
		return reg_tel;
	}
	public void setReg_tel(String reg_tel) {
		this.reg_tel = reg_tel;
	}
	public String getReg_email() {
		return reg_email;
	}
	public void setReg_email(String reg_email) {
		this.reg_email = reg_email;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getPerPageCnt() {
		return perPageCnt;
	}
	public void setPerPageCnt(int perPageCnt) {
		this.perPageCnt = perPageCnt;
	}
	public int getPageRange() {
		return pageRange;
	}
	public void setPageRange(int pageRange) {
		this.pageRange = pageRange;
	}
	public int getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
	public int getPageStartNo() {
		return pageStartNo;
	}
	public void setPageStartNo(int pageStartNo) {
		this.pageStartNo = pageStartNo;
	}
	public int getPageEndNo() {
		return pageEndNo;
	}
	public void setPageEndNo(int pageEndNo) {
		this.pageEndNo = pageEndNo;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public int getMenuID() {
		return menuID;
	}
	public void setMenuID(int menuID) {
		this.menuID = menuID;
	}
	public String getReg_id() {
		return reg_id;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	public String getReg_nm() {
		return reg_nm;
	}
	public void setReg_nm(String reg_nm) {
		this.reg_nm = reg_nm;
	}
	public String getReg_ip() {
		return reg_ip;
	}
	public void setReg_ip(String reg_ip) {
		this.reg_ip = reg_ip;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getAprv_id() {
		return aprv_id;
	}
	public void setAprv_id(String aprv_id) {
		this.aprv_id = aprv_id;
	}
	public String getAprv_ip() {
		return aprv_ip;
	}
	public void setAprv_ip(String aprv_ip) {
		this.aprv_ip = aprv_ip;
	}
	public String getAprv_status() {
		return aprv_status;
	}
	public void setAprv_status(String aprv_status) {
		this.aprv_status = aprv_status;
	}
	public String getAprv_dt() {
		return aprv_dt;
	}
	public void setAprv_dt(String aprv_dt) {
		this.aprv_dt = aprv_dt;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	
	
}
