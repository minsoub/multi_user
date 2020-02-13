package kr.co.neodreams.multi_user.dto;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

/**
 * 라이센스 관리 DTO Class
 * 
 * @author hist
 *
 */
public class LicenseDto extends BasePagingDto {
	private int		seq;			// 라이센스 key
	private int		sw_id;			// SW ID
	private String	ver_nm;			// 라이센스 버전명
	private int		qty;			// 수량
	private String	content;		// 내용
	private String	reg_id;				// 등록자 아이디
	private String	reg_nm;				// 등록자명
	private String	reg_ip;				// 등록 아이피
	private String	reg_dt;				// 등록일자
	private String	del_yn;				// 삭제여부
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getSw_id() {
		return sw_id;
	}
	public void setSw_id(int sw_id) {
		this.sw_id = sw_id;
	}
	public String getVer_nm() {
		return ver_nm;
	}
	public void setVer_nm(String ver_nm) {
		this.ver_nm = ver_nm;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	
	
}
