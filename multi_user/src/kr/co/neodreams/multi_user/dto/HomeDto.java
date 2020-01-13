package kr.co.neodreams.multi_user.dto;


import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

public class HomeDto extends BasePagingDto{
	
	private String num;
	private String re_form;
	private String subject;
	private String R_date;
	private String Re_Step;
	private String visited;
	private String re_comment;
	
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getRe_form() {
		return re_form;
	}
	public void setRe_form(String re_form) {
		this.re_form = re_form;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getR_date() {
		return R_date;
	}
	public void setR_date(String r_date) {
		R_date = r_date;
	}
	public String getRe_Step() {
		return Re_Step;
	}
	public void setRe_Step(String re_Step) {
		Re_Step = re_Step;
	}
	public String getVisited() {
		return visited;
	}
	public void setVisited(String visited) {
		this.visited = visited;
	}
	public String getRe_comment() {
		return re_comment;
	}
	public void setRe_comment(String re_comment) {
		this.re_comment = re_comment;
	}
	
}
