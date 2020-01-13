package kr.co.neodreams.multi_user.dto;


import java.util.List;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

public class ImgBoardDto extends BasePagingDto{

	private	int		img_Board_Seq;				//번호
	private	String	img_Board_Title;			//제목
	private	String	img_Board_Secret;			//공개구분
	private	String	img_Board_Content;			//내용
	private	String	write_User;				//작성자
	private	String	write_User_Name;		//작성자
	private	String	write_Date;				//작성일
	
	private	String	attatch_Seqs;
	
	private	List<ImgBoardDto> attatchList;
	
	private	String	attatch_Seq;			//첨부파일
	private	String	attatch_OrgName;		//파일이름
	private	String	attatch_PhyPath;		//실제경로
	private	String	attatch_LogPath;		//웹경로
	
	private	String	searchText;
	
	private String secretChk;

	
	
	public int getImg_Board_Seq() {
		return img_Board_Seq;
	}

	public void setImg_Board_Seq(int img_Board_Seq) {
		this.img_Board_Seq = img_Board_Seq;
	}

	public String getImg_Board_Title() {
		return img_Board_Title;
	}

	public void setImg_Board_Title(String img_Board_Title) {
		this.img_Board_Title = img_Board_Title;
	}

	public String getImg_Board_Secret() {
		return img_Board_Secret;
	}

	public void setImg_Board_Secret(String img_Board_Secret) {
		this.img_Board_Secret = img_Board_Secret;
	}

	public String getImg_Board_Content() {
		return img_Board_Content;
	}

	public void setImg_Board_Content(String img_Board_Content) {
		this.img_Board_Content = img_Board_Content;
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

	public List<ImgBoardDto> getAttatchList() {
		return attatchList;
	}

	public void setAttatchList(List<ImgBoardDto> attatchList) {
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

	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	public String getSecretChk() {
		return secretChk;
	}

	public void setSecretChk(String secretChk) {
		this.secretChk = secretChk;
	}
	
	
	
	

	
}
