package kr.co.neodreams.multi_user.dto;

public class Tbsetcd2Dto {
	private String CD2_CODE;
	private String CD2_NAME;
	private String CD2_CD1;
	private String CD2_STATE;
	private int CD2_SORT;
	private String LISTCNT;					//서비스 진행중인 건수
	private String LISTSUM;					//서비스 진행중이 매&시간
	
	public String getCD2_CODE() {
		return CD2_CODE;
	}
	public String getCD2_NAME() {
		return CD2_NAME;
	}
	public String getCD2_CD1() {
		return CD2_CD1;
	}
	public String getCD2_STATE() {
		return CD2_STATE;
	}
	public int getCD2_SORT() {
		return CD2_SORT;
	}
	public String getLISTCNT() {
		return LISTCNT;
	}
	public String getLISTSUM() {
		return LISTSUM;
	}
	public void setCD2_CODE(String cD2_CODE) {
		CD2_CODE = cD2_CODE;
	}
	public void setCD2_NAME(String cD2_NAME) {
		CD2_NAME = cD2_NAME;
	}
	public void setCD2_CD1(String cD2_CD1) {
		CD2_CD1 = cD2_CD1;
	}
	public void setCD2_STATE(String cD2_STATE) {
		CD2_STATE = cD2_STATE;
	}
	public void setCD2_SORT(int cD2_SORT) {
		CD2_SORT = cD2_SORT;
	}
	public void setLISTCNT(String lISTCNT) {
		LISTCNT = lISTCNT;
	}
	public void setLISTSUM(String lISTSUM) {
		LISTSUM = lISTSUM;
	}
	
}
