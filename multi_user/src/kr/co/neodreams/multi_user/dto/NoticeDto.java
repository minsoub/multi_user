package kr.co.neodreams.multi_user.dto;


import java.util.List;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

public class NoticeDto extends BasePagingDto{

	private	int		notice_Seq;				//번호
	private	String	notice_Title;			//제목
	private	String	notice_Gbn;				//업무구분
	private	String	notice_Content;			//내용
	private	String	write_User;				//작성자
	private	String	write_User_Name;		//작성자
	private	String	write_Date;				//작성일
	
	private	String	attatch_Seqs;
	
	private	List<NoticeDto> attatchList;
	
	private	String	attatch_Seq;			//첨부파일
	private	String	attatch_OrgName;		//파일이름
	private	String	attatch_PhyPath;		//실제경로
	private	String	attatch_LogPath;		//웹경로
	
	private	String	searchText;
	private	String	schNoticeGbn;
	
	
	public String getSearchText() {
		return searchText;
	}
	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}
	public String getSchNoticeGbn() {
		return schNoticeGbn;
	}
	public void setSchNoticeGbn(String schNoticeGbn) {
		this.schNoticeGbn = schNoticeGbn;
	}
	public int getNotice_Seq() {
		return notice_Seq;
	}
	public void setNotice_Seq(int notice_Seq) {
		this.notice_Seq = notice_Seq;
	}
	public String getNotice_Title() {
		return notice_Title;
	}
	public void setNotice_Title(String notice_Title) {
		this.notice_Title = notice_Title;
	}
	public String getNotice_Gbn() {
		return notice_Gbn;
	}
	public void setNotice_Gbn(String notice_Gbn) {
		this.notice_Gbn = notice_Gbn;
	}
	public String getNotice_Content() {
		return notice_Content;
	}
	public void setNotice_Content(String notice_Content) {
		this.notice_Content = notice_Content;
	}
	public String getWrite_User() {
		return write_User;
	}
	public void setWrite_User(String write_User) {
		this.write_User = write_User;
	}
	public String getWrite_User_Name() {
		return write_User_Name;
	}
	public void setWrite_User_Name(String write_User_Name) {
		this.write_User_Name = write_User_Name;
	}
	public String getWrite_Date() {
		return write_Date;
	}
	public void setWrite_Date(String write_Date) {
		this.write_Date = write_Date;
	}
	public String getAttatch_Seqs() {
		return attatch_Seqs;
	}
	public void setAttatch_Seqs(String attatch_Seqs) {
		this.attatch_Seqs = attatch_Seqs;
	}
	public List<NoticeDto> getAttatchList() {
		return attatchList;
	}
	public void setAttatchList(List<NoticeDto> attatchList) {
		this.attatchList = attatchList;
	}
	public String getAttatch_Seq() {
		return attatch_Seq;
	}
	public void setAttatch_Seq(String attatch_Seq) {
		this.attatch_Seq = attatch_Seq;
	}
	public String getAttatch_OrgName() {
		return attatch_OrgName;
	}
	public void setAttatch_OrgName(String attatch_OrgName) {
		this.attatch_OrgName = attatch_OrgName;
	}
	public String getAttatch_PhyPath() {
		return attatch_PhyPath;
	}
	public void setAttatch_PhyPath(String attatch_PhyPath) {
		this.attatch_PhyPath = attatch_PhyPath;
	}
	public String getAttatch_LogPath() {
		return attatch_LogPath;
	}
	public void setAttatch_LogPath(String attatch_LogPath) {
		this.attatch_LogPath = attatch_LogPath;
	}
	
	
	
	
	
	

	
}
