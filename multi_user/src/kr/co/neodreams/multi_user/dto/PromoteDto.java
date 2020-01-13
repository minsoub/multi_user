package kr.co.neodreams.multi_user.dto;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

public class PromoteDto extends BasePagingDto{
    
	private int p_seq;
	private String req_dept_code;
	private String req_empno;
	private String p_title;
	private String p_date;
	private String start_time;
	private String end_time;
	private int p_target_code;
	private String p_target_desc;
	private String energy_flag;
	private int p_status;
	private String cancel_desc;
	private String reject_desc;
	private String start_date;
	private String end_date;
	private String srh_sel_status;
	private String srh_gubun;
	private String srh_keyword;
	private String empno;
	private String reg_empno;
	
	public int getP_seq() {
		return p_seq;
	}
	public void setP_seq(int p_seq) {
		this.p_seq = p_seq;
	}
	public String getReq_dept_code() {
		return req_dept_code;
	}
	public void setReq_dept_code(String req_dept_code) {
		this.req_dept_code = req_dept_code;
	}
	public String getReq_empno() {
		return req_empno;
	}
	public void setReq_empno(String req_empno) {
		this.req_empno = req_empno;
	}
	public String getP_title() {
		return p_title;
	}
	public void setP_title(String p_title) {
		this.p_title = p_title;
	}
	public String getP_date() {
		return p_date;
	}
	public void setP_date(String p_date) {
		this.p_date = p_date;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public int getP_target_code() {
		return p_target_code;
	}
	public void setP_target_code(int p_target_code) {
		this.p_target_code = p_target_code;
	}
	public String getP_target_desc() {
		return p_target_desc;
	}
	public void setP_target_desc(String p_target_desc) {
		this.p_target_desc = p_target_desc;
	}
	public String getEnergy_flag() {
		return energy_flag;
	}
	public void setEnergy_flag(String energy_flag) {
		this.energy_flag = energy_flag;
	}
	public int getP_status() {
		return p_status;
	}
	public void setP_status(int p_status) {
		this.p_status = p_status;
	}
	public String getCancel_desc() {
		return cancel_desc;
	}
	public void setCancel_desc(String cancel_desc) {
		this.cancel_desc = cancel_desc;
	}
	public String getReject_desc() {
		return reject_desc;
	}
	public void setReject_desc(String reject_desc) {
		this.reject_desc = reject_desc;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getSrh_sel_status() {
		return srh_sel_status;
	}
	public void setSrh_sel_status(String srh_sel_status) {
		this.srh_sel_status = srh_sel_status;
	}
	public String getSrh_gubun() {
		return srh_gubun;
	}
	public void setSrh_gubun(String srh_gubun) {
		this.srh_gubun = srh_gubun;
	}
	public String getSrh_keyword() {
		return srh_keyword;
	}
	public void setSrh_keyword(String srh_keyword) {
		this.srh_keyword = srh_keyword;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getReg_empno() {
		return reg_empno;
	}
	public void setReg_empno(String reg_empno) {
		this.reg_empno = reg_empno;
	}
}
