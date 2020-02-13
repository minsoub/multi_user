package kr.co.neodreams.multi_user.dto;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

/**
 * 소프트웨어 관리 Dto Class
 * 
 * @author hist
 *
 */
public class SwmngDto extends BasePagingDto {
	private int	sw_id;					// SW ID
	private String	sw_name;			// SW Name
	private String	level1;				// 본부 그룹
	private String	level2;				// 사업소 1 그룹
	private String	level3;				// 사업소 2 그룹
	private String	content;			// SW 설명
	private String	reg_id;				// 등록자 아이디
	private String	reg_nm;				// 등록자명
	private String	reg_ip;				// 등록 아이피
	private String	reg_dt;				// 등록일자
	private String	del_yn;				// 삭제여부
	
	
	public int getSw_id() {
		return sw_id;
	}
	public void setSw_id(int sw_id) {
		this.sw_id = sw_id;
	}
	public String getSw_name() {
		return sw_name;
	}
	public void setSw_name(String sw_name) {
		this.sw_name = sw_name;
	}
	public String getLevel1() {
		return level1;
	}
	public void setLevel1(String level1) {
		this.level1 = level1;
	}
	public String getLevel2() {
		return level2;
	}
	public void setLevel2(String level2) {
		this.level2 = level2;
	}
	public String getLevel3() {
		return level3;
	}
	public void setLevel3(String level3) {
		this.level3 = level3;
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
