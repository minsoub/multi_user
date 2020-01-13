package kr.co.neodreams.multi_user.dto;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

public class UserRentScreenDto extends BasePagingDto {
	private Integer APPNO;
    private String GBNM;
    private String GBUP;
    private String STRDT;
    private String ENDDT;
    private String STATUS;
    private String STATUSSTR;
	private String REGDT;
    private String APPNUM;
    private String APPROVAL;
    private String APPENM;
    private String APPUENM;
    
    
	public Integer getAPPNO() {
		return APPNO;
	}
	public void setAPPNO(Integer aPPNO) {
		APPNO = aPPNO;
	}
	public String getGBNM() {
		return GBNM;
	}
	public void setGBNM(String gBNM) {
		GBNM = gBNM;
	}
	public String getGBUP() {
		return GBUP;
	}
	public void setGBUP(String gBUP) {
		GBUP = gBUP;
	}
	public String getSTRDT() {
		return STRDT;
	}
	public void setSTRDT(String sTRDT) {
		STRDT = sTRDT;
	}
	public String getENDDT() {
		return ENDDT;
	}
	public void setENDDT(String eNDDT) {
		ENDDT = eNDDT;
	}
	public String getSTATUS() {
		return STATUS;
	}
	public void setSTATUS(String sTATUS) {
		STATUS = sTATUS;
	}
    public String getSTATUSSTR() {
		return STATUSSTR;
	}
	public void setSTATUSSTR(String sTATUSSTR) {
		STATUSSTR = sTATUSSTR;
	}
	public String getREGDT() {
		return REGDT;
	}
	public void setREGDT(String rEGDT) {
		REGDT = rEGDT;
	}
	public String getAPPNUM() {
		return APPNUM;
	}
	public void setAPPNUM(String aPPNUM) {
		APPNUM = aPPNUM;
	}
	public String getAPPROVAL() {
		return APPROVAL;
	}
	public void setAPPROVAL(String aPPROVAL) {
		APPROVAL = aPPROVAL;
	}
	public String getAPPENM() {
		return APPENM;
	}
	public void setAPPENM(String aPPENM) {
		APPENM = aPPENM;
	}
	public String getAPPUENM() {
		return APPUENM;
	}
	public void setAPPUENM(String aPPUENM) {
		APPUENM = aPPUENM;
	}
}
