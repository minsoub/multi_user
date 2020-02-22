package kr.co.neodreams.multi_user.dto;


import java.util.List;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

public class CommonDto extends BasePagingDto{
	
	private String static_idx;
	private String Re_Step;
	
	private String caption_desc;
	private String Re_level;
	
	private String num;				// 게시글 번호
	private String subject;			// 제목
	private String Writer;			// 작성자

	private String pdsFile;			// 업로드파일명

	private String Reg_Date;		// 작성일자
	private String content;			// 내용
	private String Visited; 		// 조회수
	
	private String j_pdsFile;
	private String j_mp3;
	private String name;
	private String k_id;
	private String k_title;
	private String k_num;
	private String icon;
	private String k_date;
	private String Rs_num;
	private String f_mode;
	private String f_url;
	private String DirName;
	private String co_id;
	private String co_icon;
	private String co_content;

	
	private String searchString;
	
	
	private String empno;
	private String mailno;
	private String dept_name;
	private String deptno;
	private String telno;
	private String dept_name_1depth;
	private String dept_name_2depth;
	

	
	public String getStatic_idx() {
		return static_idx;
	}

	public void setStatic_idx(String static_idx) {
		this.static_idx = static_idx;
	}

	public String getPdsFile() {
		return pdsFile;
	}

	public void setPdsFile(String pdsFile) {
		this.pdsFile = pdsFile;
	}

	public String getRe_Step() {
		return Re_Step;
	}

	public void setRe_Step(String re_Step) {
		Re_Step = re_Step;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCaption_desc() {
		return caption_desc;
	}

	public void setCaption_desc(String caption_desc) {
		this.caption_desc = caption_desc;
	}

	public String getRe_level() {
		return Re_level;
	}

	public void setRe_level(String re_level) {
		Re_level = re_level;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getJ_pdsFile() {
		return j_pdsFile;
	}

	public void setJ_pdsFile(String j_pdsFile) {
		this.j_pdsFile = j_pdsFile;
	}

	public String getJ_mp3() {
		return j_mp3;
	}

	public void setJ_mp3(String j_mp3) {
		this.j_mp3 = j_mp3;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getK_id() {
		return k_id;
	}

	public void setK_id(String k_id) {
		this.k_id = k_id;
	}

	public String getK_title() {
		return k_title;
	}

	public void setK_title(String k_title) {
		this.k_title = k_title;
	}

	public String getK_num() {
		return k_num;
	}

	public void setK_num(String k_num) {
		this.k_num = k_num;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getK_date() {
		return k_date;
	}

	public void setK_date(String k_date) {
		this.k_date = k_date;
	}

	public String getRs_num() {
		return Rs_num;
	}

	public void setRs_num(String rs_num) {
		Rs_num = rs_num;
	}

	public String getF_mode() {
		return f_mode;
	}

	public void setF_mode(String f_mode) {
		this.f_mode = f_mode;
	}

	public String getF_url() {
		return f_url;
	}

	public void setF_url(String f_url) {
		this.f_url = f_url;
	}

	public String getDirName() {
		return DirName;
	}

	public void setDirName(String dirName) {
		DirName = dirName;
	}

	public String getCo_id() {
		return co_id;
	}

	public void setCo_id(String co_id) {
		this.co_id = co_id;
	}

	public String getCo_icon() {
		return co_icon;
	}

	public void setCo_icon(String co_icon) {
		this.co_icon = co_icon;
	}

	public String getCo_content() {
		return co_content;
	}

	public void setCo_content(String co_content) {
		this.co_content = co_content;
	}

	public String getReg_Date() {
		return Reg_Date;
	}

	public void setReg_Date(String reg_Date) {
		Reg_Date = reg_Date;
	}

	public String getVisited() {
		return Visited;
	}

	public void setVisited(String visited) {
		Visited = visited;
	}

	public String getSearchString() {
		return searchString;
	}

	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}

	public String getWriter() {
		return Writer;
	}

	public void setWriter(String writer) {
		Writer = writer;
	}

	public String getEmpno() {
		return empno;
	}

	public void setEmpno(String empno) {
		this.empno = empno;
	}

	public String getMailno() {
		return mailno;
	}

	public void setMailno(String mailno) {
		this.mailno = mailno;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getDeptno() {
		return deptno;
	}

	public void setDeptno(String deptno) {
		this.deptno = deptno;
	}

	public String getTelno() {
		return telno;
	}

	public void setTelno(String telno) {
		this.telno = telno;
	}

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
