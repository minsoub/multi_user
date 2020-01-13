package kr.co.neodreams.multi_user.dto;

import kr.co.neodreams.multi_user.base.dto.BaseDto;

public class AccessDto extends BaseDto {
	private String ACCENO;
	private String ACCENM;
	private String ACCSS;
	private String ACCUSEOBJ;
	private Integer APPNO;
	private String REGDT;
	private String STDT;
	private String EDDT;

	public String getACCENO() {
		return ACCENO;
	}
	public void setACCENO(String aCCENO) {
		ACCENO = aCCENO;
	}
	public String getACCENM() {
		return ACCENM;
	}
	public void setACCENM(String aCCENM) {
		ACCENM = aCCENM;
	}
	public String getACCSS() {
		return ACCSS;
	}
	public void setACCSS(String aCCSS) {
		ACCSS = aCCSS;
	}
	public String getACCUSEOBJ() {
		return ACCUSEOBJ;
	}
	public void setACCUSEOBJ(String aCCUSEOBJ) {
		ACCUSEOBJ = aCCUSEOBJ;
	}
	public Integer getAPPNO() {
		return APPNO;
	}
	public void setAPPNO(Integer aPPNO) {
		APPNO = aPPNO;
	}
	public String getREGDT() {
		return REGDT;
	}
	public void setREGDT(String rEGDT) {
		REGDT = rEGDT;
	}
	public String getSTDT() {
		return STDT;
	}
	public void setSTDT(String sTDT) {
		STDT = sTDT;
	}
	public String getEDDT() {
		return EDDT;
	}
	public void setEDDT(String eDDT) {
		EDDT = eDDT;
	}
}
