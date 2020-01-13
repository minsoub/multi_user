package kr.co.neodreams.multi_user.dto;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

public class Tbsetcd1Dto extends BasePagingDto{
	private String CD1_CODE;
	private String CD1_NAME;
	private String CD1_MDIV;
	private String CD1_STATE;
	private int CD1_SORT;
	
	/*마이페이지 일반페이지 구분*/
	private String mode; //모든사용자 ,my페이지 구분
	private String mode2; //수정, 삭제 구분
	
	
	public String getMode2() {
		return mode2;
	}
	public void setMode2(String mode2) {
		this.mode2 = mode2;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getCD1_CODE() {
		return CD1_CODE;
	}
	public void setCD1_CODE(String cD1_CODE) {
		CD1_CODE = cD1_CODE;
	}
	public String getCD1_NAME() {
		return CD1_NAME;
	}
	public void setCD1_NAME(String cD1_NAME) {
		CD1_NAME = cD1_NAME;
	}
	public String getCD1_MDIV() {
		return CD1_MDIV;
	}
	public void setCD1_MDIV(String cD1_MDIV) {
		CD1_MDIV = cD1_MDIV;
	}
	public String getCD1_STATE() {
		return CD1_STATE;
	}
	public void setCD1_STATE(String cD1_STATE) {
		CD1_STATE = cD1_STATE;
	}
	public int getCD1_SORT() {
		return CD1_SORT;
	}
	public void setCD1_SORT(int cD1_SORT) {
		CD1_SORT = cD1_SORT;
	}
}
