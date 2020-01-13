package kr.co.neodreams.multi_user.dto;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

public class StatisticsDto extends BasePagingDto{
    
    private String YR;
    private String MTH;
    private String CNT1;
    private String CNT2;
    private String CNT3;
    private String CNT4;
    private String CNT5;
    private String CNT6;
    
    private String SM_MEMPNO;
    private String SM_SEQ;
    private String SM_NO;
    private String SM_DATE;
    private String SM_SVC2;
    private String SM_MDNAME;
    private String SM_TITLE;
    private String CD2_NAME;
    private String SM_LSTATE;
    private String SM_FSTATE;
    private String SM_ISSIGN;
    private String SM_SIGNNO;
    private String SM_WDATE;

	/* 신청일 조회시 ~부터 */
	private String SM_WDATE_FROM;
	/* 신청일 조회시  ~까지 */
	private String SM_WDATE_TO;
	
    public String getYR() {
        return YR;
    }
    public void setYR(String yR) {
        YR = yR;
    }
    public String getMTH() {
        return MTH;
    }
    public void setMTH(String mTH) {
        MTH = mTH;
    }
    public String getCNT1() {
        return CNT1;
    }
    public void setCNT1(String cNT1) {
        CNT1 = cNT1;
    }
    public String getCNT2() {
        return CNT2;
    }
    public void setCNT2(String cNT2) {
        CNT2 = cNT2;
    }
    public String getCNT3() {
        return CNT3;
    }
    public void setCNT3(String cNT3) {
        CNT3 = cNT3;
    }
    public String getCNT4() {
        return CNT4;
    }
    public void setCNT4(String cNT4) {
        CNT4 = cNT4;
    }
    public String getCNT5() {
        return CNT5;
    }
    public void setCNT5(String cNT5) {
        CNT5 = cNT5;
    }
    public String getCNT6() {
        return CNT6;
    }
    public void setCNT6(String cNT6) {
        CNT6 = cNT6;
    }
    public String getSM_MEMPNO() {
        return SM_MEMPNO;
    }
    public void setSM_MEMPNO(String sM_MEMPNO) {
        SM_MEMPNO = sM_MEMPNO;
    }
    public String getSM_SEQ() {
        return SM_SEQ;
    }
    public void setSM_SEQ(String sM_SEQ) {
        SM_SEQ = sM_SEQ;
    }
    public String getSM_NO() {
        return SM_NO;
    }
    public void setSM_NO(String sM_NO) {
        SM_NO = sM_NO;
    }
    public String getSM_DATE() {
        return SM_DATE;
    }
    public void setSM_DATE(String sM_DATE) {
        SM_DATE = sM_DATE;
    }
    public String getSM_SVC2() {
        return SM_SVC2;
    }
    public void setSM_SVC2(String sM_SVC2) {
        SM_SVC2 = sM_SVC2;
    }
    public String getSM_MDNAME() {
        return SM_MDNAME;
    }
    public void setSM_MDNAME(String sM_MDNAME) {
        SM_MDNAME = sM_MDNAME;
    }
    public String getSM_TITLE() {
        return SM_TITLE;
    }
    public void setSM_TITLE(String sM_TITLE) {
        SM_TITLE = sM_TITLE;
    }
    public String getCD2_NAME() {
        return CD2_NAME;
    }
    public void setCD2_NAME(String cD2_NAME) {
        CD2_NAME = cD2_NAME;
    }
    public String getSM_LSTATE() {
        return SM_LSTATE;
    }
    public void setSM_LSTATE(String sM_LSTATE) {
        SM_LSTATE = sM_LSTATE;
    }
    public String getSM_FSTATE() {
        return SM_FSTATE;
    }
    public void setSM_FSTATE(String sM_FSTATE) {
        SM_FSTATE = sM_FSTATE;
    }
    public String getSM_ISSIGN() {
        return SM_ISSIGN;
    }
    public void setSM_ISSIGN(String sM_ISSIGN) {
        SM_ISSIGN = sM_ISSIGN;
    }
    public String getSM_SIGNNO() {
        return SM_SIGNNO;
    }
    public void setSM_SIGNNO(String sM_SIGNNO) {
        SM_SIGNNO = sM_SIGNNO;
    }
    public String getSM_WDATE() {
        return SM_WDATE;
    }
    public void setSM_WDATE(String sM_WDATE) {
        SM_WDATE = sM_WDATE;
    }
    public String getSM_WDATE_FROM() {
        return SM_WDATE_FROM;
    }
    public void setSM_WDATE_FROM(String sM_WDATE_FROM) {
        SM_WDATE_FROM = sM_WDATE_FROM;
    }
    public String getSM_WDATE_TO() {
        return SM_WDATE_TO;
    }
    public void setSM_WDATE_TO(String sM_WDATE_TO) {
        SM_WDATE_TO = sM_WDATE_TO;
    }
}
