package kr.co.neodreams.multi_user.dto;

/**
 * OA 교육장 DTO Class
 * 
 * @author hist
 *
 */
public class OaDto {
	private int		rsrv_id;				// 예약번호(순차번호)
	private String	sabun;					// 사번(사용자아이디)
	private String	place_id;				// 교육장아이디
	private String	rsrv_dt;				// 예약일자(yyyyMMddHH24)
	private String	subject;				// 신청 제목
	private String  people_cnt;				// 예약인원수
	private String	reg_dttm;				// 예약일자(datetime)
	private String	admin_id;				// 승인자 아이디
	private String	aprv_ip;				// 승인자 아이피 주소
	private String	aprv_status;			// 승인상태 (N:신청, Y:승인, C:취소)
	private String	aprv_dttm;				// 승인일자(datetime)
	private String	del_flag;				// 삭제여부(Y:삭제, N)
	private String	memo;					// 취소 처리 메모
	private String  date;					// 검색일자
	private String  hour;					// 예약시간+
	
	private String  user_name;
	private String  user_tel;

	
	
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_tel() {
		return user_tel;
	}
	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}
	public String getPeople_cnt() {
		return people_cnt;
	}
	public void setPeople_cnt(String people_cnt) {
		this.people_cnt = people_cnt;
	}
	public String getHour() {
		return hour;
	}
	public void setHour(String hour) {
		this.hour = hour;
	}
	public int getRsrv_id() {
		return rsrv_id;
	}
	public void setRsrv_id(int rsrv_id) {
		this.rsrv_id = rsrv_id;
	}
	public String getSabun() {
		return sabun;
	}
	public void setSabun(String sabun) {
		this.sabun = sabun;
	}
	public String getPlace_id() {
		return place_id;
	}
	public void setPlace_id(String place_id) {
		this.place_id = place_id;
	}
	public String getRsrv_dt() {
		return rsrv_dt;
	}
	public void setRsrv_dt(String rsrv_dt) {
		this.rsrv_dt = rsrv_dt;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getReg_dttm() {
		return reg_dttm;
	}
	public void setReg_dttm(String reg_dttm) {
		this.reg_dttm = reg_dttm;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
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
	public String getAprv_dttm() {
		return aprv_dttm;
	}
	public void setAprv_dttm(String aprv_dttm) {
		this.aprv_dttm = aprv_dttm;
	}
	public String getDel_flag() {
		return del_flag;
	}
	public void setDel_flag(String del_flag) {
		this.del_flag = del_flag;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	
	
}
