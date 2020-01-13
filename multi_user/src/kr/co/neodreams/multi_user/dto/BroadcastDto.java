package kr.co.neodreams.multi_user.dto;


import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

public class BroadcastDto extends BasePagingDto{

	//vod_s1
	private int Num;
	private String Subject;
	private String Writer;
	private String sosok;
	private String pdsFile;
	private int FileSize;
	private String Email;
	private String Passwd;
	private String Reg_Date;
	private String Content;
	private int Visited;
	private int Html;
	private int Ref;
	private int Re_Step;
	private int Re_level;
	private int ListNum;
	private String DirName;
	private String host_ip;
	private String R_date;
	private String re_form;
	private int re_count;
	private int re_comment;
	private String pdsimg;
	private int VOD_Type;
	private String Downcheck;
	private int vod_duration;
	private String FNAME3;
	
	private String searchString;
	
	private String dir01;
	private String dir02;
	private String dir02_1;
	private String dir02_2;
	private String dir02_3;
	
	private	String	searchStDate;
	private	String	searchEdDate;
	
	//TVM_CONTENTS
	private String duration;
	private String durationTime;
	
	private String thumb_log_path;
	
	public String getDurationTime() {
		return durationTime;
	}
	public void setDurationTime(String durationTime) {
		this.durationTime = durationTime;
	}
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	public String getSearchStDate() {
		return searchStDate;
	}
	public void setSearchStDate(String searchStDate) {
		this.searchStDate = searchStDate;
	}
	public String getSearchEdDate() {
		return searchEdDate;
	}
	public void setSearchEdDate(String searchEdDate) {
		this.searchEdDate = searchEdDate;
	}
	public int getNum() {
		return Num;
	}
	public void setNum(int num) {
		Num = num;
	}
	public String getSubject() {
		return Subject;
	}
	public void setSubject(String subject) {
		Subject = subject;
	}
	public String getWriter() {
		return Writer;
	}
	public void setWriter(String writer) {
		Writer = writer;
	}
	public String getSosok() {
		return sosok;
	}
	public void setSosok(String sosok) {
		this.sosok = sosok;
	}
	public String getPdsFile() {
		return pdsFile;
	}
	public void setPdsFile(String pdsFile) {
		this.pdsFile = pdsFile;
	}
	public int getFileSize() {
		return FileSize;
	}
	public void setFileSize(int fileSize) {
		FileSize = fileSize;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getPasswd() {
		return Passwd;
	}
	public void setPasswd(String passwd) {
		Passwd = passwd;
	}
	public String getReg_Date() {
		return Reg_Date;
	}
	public void setReg_Date(String reg_Date) {
		Reg_Date = reg_Date;
	}
	public String getContent() {
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}
	public int getVisited() {
		return Visited;
	}
	public void setVisited(int visited) {
		Visited = visited;
	}
	public int getHtml() {
		return Html;
	}
	public void setHtml(int html) {
		Html = html;
	}
	public int getRef() {
		return Ref;
	}
	public void setRef(int ref) {
		Ref = ref;
	}
	public int getRe_Step() {
		return Re_Step;
	}
	public void setRe_Step(int re_Step) {
		Re_Step = re_Step;
	}
	public int getRe_level() {
		return Re_level;
	}
	public void setRe_level(int re_level) {
		Re_level = re_level;
	}
	public int getListNum() {
		return ListNum;
	}
	public void setListNum(int listNum) {
		ListNum = listNum;
	}
	public String getDirName() {
		return DirName;
	}
	public void setDirName(String dirName) {
		DirName = dirName;
	}
	public String getHost_ip() {
		return host_ip;
	}
	public void setHost_ip(String host_ip) {
		this.host_ip = host_ip;
	}
	public String getR_date() {
		return R_date;
	}
	public void setR_date(String r_date) {
		R_date = r_date;
	}
	public String getRe_form() {
		return re_form;
	}
	public void setRe_form(String re_form) {
		this.re_form = re_form;
	}
	public int getRe_count() {
		return re_count;
	}
	public void setRe_count(int re_count) {
		this.re_count = re_count;
	}
	public int getRe_comment() {
		return re_comment;
	}
	public void setRe_comment(int re_comment) {
		this.re_comment = re_comment;
	}
	public String getPdsimg() {
		return pdsimg;
	}
	public void setPdsimg(String pdsimg) {
		this.pdsimg = pdsimg;
	}
	public int getVOD_Type() {
		return VOD_Type;
	}
	public void setVOD_Type(int vOD_Type) {
		VOD_Type = vOD_Type;
	}
	public String getDowncheck() {
		return Downcheck;
	}
	public void setDowncheck(String downcheck) {
		Downcheck = downcheck;
	}
	public int getVod_duration() {
		return vod_duration;
	}
	public void setVod_duration(int vod_duration) {
		this.vod_duration = vod_duration;
	}
	public String getFNAME3() {
		return FNAME3;
	}
	public void setFNAME3(String fNAME3) {
		FNAME3 = fNAME3;
	}
	public String getSearchString() {
		return searchString;
	}
	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}
	public String getDir01() {
		return dir01;
	}
	public void setDir01(String dir01) {
		this.dir01 = dir01;
	}
	public String getDir02() {
		return dir02;
	}
	public void setDir02(String dir02) {
		this.dir02 = dir02;
	}
	public String getDir02_1() {
		return dir02_1;
	}
	public void setDir02_1(String dir02_1) {
		this.dir02_1 = dir02_1;
	}
	public String getDir02_2() {
		return dir02_2;
	}
	public void setDir02_2(String dir02_2) {
		this.dir02_2 = dir02_2;
	}
	public String getDir02_3() {
		return dir02_3;
	}
	public void setDir02_3(String dir02_3) {
		this.dir02_3 = dir02_3;
	}
	public String getThumb_log_path() {
		return thumb_log_path;
	}
	public void setThumb_log_path(String thumb_log_path) {
		this.thumb_log_path = thumb_log_path;
	}
}
