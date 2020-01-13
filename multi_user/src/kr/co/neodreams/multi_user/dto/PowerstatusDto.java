package kr.co.neodreams.multi_user.dto;


import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

public class PowerstatusDto extends BasePagingDto{
	
	private String dept_name_1depth;
	private String dept_name_2depth;
	
	public String getDept_name_1depth() {
		return dept_name_1depth;
	}
	public void setDept_name_1depth(String dept_name_1depth) {
		this.dept_name_1depth = dept_name_1depth;
	}
	public String getDept_name_2depth() {
		return dept_name_2depth;
	}
	public void setDept_name_2depth(String dept_name_2depth) {
		this.dept_name_2depth = dept_name_2depth;
	}

}
