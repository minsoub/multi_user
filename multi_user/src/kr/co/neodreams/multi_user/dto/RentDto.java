package kr.co.neodreams.multi_user.dto;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;
import kr.co.neodreams.multi_user.common.StringUtil;

public class RentDto extends BasePagingDto{

    private Integer APPNO;
    private String GBCD;
    private String GBNM;
    private String GBUP;
    private String STRDT;
    private String ENDDT;
    private String STATUS;
    private String REGDT;
    private String APPNUM;
    private String APPROVAL;
    private String APPENM;
    private String APPUENM;
    private String REGENO;
    private Boolean IS_CANCEL;
    private String STATUSSTR;
    private Integer MDSEQ;
    private Integer AMOUNT;
    private String sch_strdt;
    private String sch_enddt;
    private String sch_status;
    private String sch_approval;
    private String sch_return;
    private String sch_code1;
    private String sch_text;
    private String sch_text2;
    private String todayRecCode;
    private String modal_appno;
    private Integer[] MDSEQ_ARR;
    private String NAME;
    private String REG_SIGN;
    private String MDNO;
    private String MDNM;
    private String MDTXT;
    private String MDBG;
    private String GBLEV;
    private String EQHNO;
    private Integer BSKNO;
    private Integer[] BSKNO_ARR;
    private Integer TOTALCNT;
    private String APPENO;
    private String USER_EMPNO;
    private String GBYN;
    private String PAGESET;
    private String ORDCOLUMN;
    private String ORDTYPE;
    private Integer STRIDX;
    private String UPCODE;
    private Integer GBCDLEN;
    private String GBBG;
    private String DELYN;
    private String EMP_ID;
    private String[] EMP_ID_ARR;
    private String EMP_NM;
    private String DEPT_NM;
    private String GET_MAIL;
    private String TELNO;
    private String KEYWORD;
    private String LCHDT;
    private String ITEM;
    private Integer NO;
    private String EQNO;
    private String EQNONULL;
    private String NULL;
    private String EQSN;
    private String EQNM;
    private String EQLST;
    private String EQMST;
    private String EQRST;
    private String EQDET;
    private String EQALIAS;
    private String EQRDT;
    private String EQCDT;
    private String EQPKG;
    private String EQBRK;
    private String EQBG;
    private String REGENM;
    private String DELDT;
    private String EQBRKDT;
    private String ETC1;
    private String ETC2;
    private String ETC3;
    private String ETC4;
    private String ETC5;
    private String ETC6;
    private Integer FILENO;
    private Integer REFNO;
    private String FILETP;
    private String FILENM;
    private String PATHNM;
    private String BANPDT;
    private String BANPDTCONV;
    private String MDSEQ_GRP;
    private String TYPE;
    private String SENDDT;
    private String SENDMS;
    private String ETC;
    private String EMPNO;
    private String DEPTNO;
    private String DEPTFULNM;
    private String STATMODE;
    private String SETDATE;
    private String APPSS;
    private String USEOBJ;
    private String IS_SIGN;
    private String SIGNMODE;
    private String[] ASSIGNEDEQNO_ARR;
    private String EXCEPT_SELF_APPNO;
    private String APPUENO;
    private String INSUNM;
    private String INSUDT;
    private String BANPNO;
    private String BANPNM;
    private String BANPST;
    private String RENT_OUT_MAIL_PATH;
    private String RENT_IN_MAIL_PATH;
    private String RENT_OUT_MAIL_SEND;
    private String RENT_IN_MAIL_SEND;
    private String CURR_MDSEQ;
    private String EUSEQ;
    private String UHSEQ;
    private String UHSEQNULL;
    private String MODE;
    private String INSUNO;
    private String APPINSUNO;
    private String APPINSUNM;
    private String INGAENO;
    private String INGAENM;
    private String MAILAPPROVAL;
    private String APPHP;
    private String INSUHP;
    private String REMAINDT;
    private String APPUEHP;
    private String TARGETMODE;

    private String RENT_IN_SIGN_IMG;
    private String RENT_OUT_SIGN_IMG;
    
	private String jojikdo;
    private String user_name;
    private String pos_name;
    private String sex;    
//    private String deptno; 대문자 변수가 이전부터 존재 하므로 삭제
//    private String empno; 대문자 변수가 이전부터 존재 하므로 삭제
    private String levelno;

    private String type;
    private String no_gubun;
    
    private String dept_name;
    private String dept_code;
    private String dept_nm_tree;
    
    private String dcode;
    private String code;
    private String dname;
    private String depth;
    private String[] space;
    private String totalDcode;
    private String htmlMode;
    
    private String dept1Name;
    private String dept2Name;
    private String dept3Name;
    private String dept4Name;
    private String dept5Name;
    private String dept6Name;

    private String dept1Code;
    private String dept2Code;
    private String dept3Code;
    private String dept4Code;
    private String dept5Code;
    private String dept6Code;
    
    //사용자 부서
    private String DEPT1NM;
    private String NUM;


    //문자 발송 관련
    private int sms_seq;
    private String pre_deptno;
    private String now_deptno;
    private String hp;
    private String regdate;
    private String senddate;
    private String send_status;

    private String levleno;
    
    
    private String SEQNO;
    private String LINKKEY;
    private String SIGN_STATUS;
    private String TITLE;
    private String MASTER_NO;
    private String BATCH_FLAG;
    private String LINK;
    private String SIGN_LEVEL;
    private String METHOD;
    private String SIGN_DATE;
    
    private String EQASSETSNO;
    

    public String getDEPT1NM() {
		return DEPT1NM;
	}
	public void setDEPT1NM(String dEPT1NM) {
		DEPT1NM = dEPT1NM;
	}
	public String getLevleno() {
        return levleno;
    }
    public void setLevleno(String levleno) {
        this.levleno = levleno;
    }
    public String getCURR_MDSEQ() {
        return CURR_MDSEQ;
    }
    public void setCURR_MDSEQ(String cURR_MDSEQ) {
        CURR_MDSEQ = cURR_MDSEQ;
    }
    public Integer getAPPNO() {
        return APPNO;
    }
    public void setAPPNO(Integer aPPNO) {
        APPNO = aPPNO;
    }
    public String getGBCD() {
        return GBCD;
    }
    public void setGBCD(String gBCD) {
        GBCD = gBCD;
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
    public String getREGENO() {
        return REGENO;
    }
    public void setREGENO(String rEGENO) {
        REGENO = rEGENO;
    }
    public Boolean getIS_CANCEL() {
        return IS_CANCEL;
    }
    public void setIS_CANCEL(Boolean iS_CANCEL) {
        IS_CANCEL = iS_CANCEL;
    }
    public String getSTATUSSTR() {
        return STATUSSTR;
    }
    public void setSTATUSSTR(String sTATUSSTR) {
        STATUSSTR = sTATUSSTR;
    }
    public Integer getMDSEQ() {
        return MDSEQ;
    }
    public void setMDSEQ(Integer mDSEQ) {
        MDSEQ = mDSEQ;
    }
    public Integer getAMOUNT() {
        return Integer.parseInt(StringUtil.isNull(String.valueOf(AMOUNT), "0"));
    }
    public void setAMOUNT(Integer aMOUNT) {
        AMOUNT = aMOUNT;
    }
    public String getSch_strdt() {
        return sch_strdt;
    }
    public void setSch_strdt(String sch_strdt) {
        this.sch_strdt = sch_strdt;
    }
    public String getSch_enddt() {
        return sch_enddt;
    }
    public void setSch_enddt(String sch_enddt) {
        this.sch_enddt = sch_enddt;
    }
    public String getSch_code1() {
        return sch_code1;
    }
    public void setSch_code1(String sch_code1) {
        this.sch_code1 = sch_code1;
    }
    public Integer[] getMDSEQ_ARR() {
        return MDSEQ_ARR;
    }
    public void setMDSEQ_ARR(Integer[] mDSEQ_ARR) {
        MDSEQ_ARR = mDSEQ_ARR;
    }
    public String getNAME() {
        return NAME;
    }
    public void setNAME(String nAME) {
        NAME = nAME;
    }
    public String getREG_SIGN() {
        return REG_SIGN;
    }
    public void setREG_SIGN(String rEG_SIGN) {
        REG_SIGN = rEG_SIGN;
    }
    public String getMDNO() {
        return MDNO;
    }
    public void setMDNO(String mDNO) {
        MDNO = mDNO;
    }
    public String getMDNM() {
        return MDNM;
    }
    public void setMDNM(String mDNM) {
        MDNM = mDNM;
    }
    public String getMDTXT() {
        return MDTXT;
    }
    public void setMDTXT(String mDTXT) {
        MDTXT = mDTXT;
    }
    public String getMDBG() {
        return MDBG;
    }
    public void setMDBG(String mDBG) {
        MDBG = mDBG;
    }
    public String getGBLEV() {
        return GBLEV;
    }
    public void setGBLEV(String gBLEV) {
        GBLEV = gBLEV;
    }
    public String getEQHNO() {
        return EQHNO;
    }
    public void setEQHNO(String eQHNO) {
        EQHNO = eQHNO;
    }
    public Integer getBSKNO() {
        return BSKNO;
    }
    public void setBSKNO(Integer bSKNO) {
        BSKNO = bSKNO;
    }
    public Integer[] getBSKNO_ARR() {
        return BSKNO_ARR;
    }
    public void setBSKNO_ARR(Integer[] bSKNO_ARR) {
        BSKNO_ARR = bSKNO_ARR;
    }
    public Integer getTOTALCNT() {
        return TOTALCNT;
    }
    public void setTOTALCNT(Integer tOTALCNT) {
        TOTALCNT = tOTALCNT;
    }
    public String getAPPENO() {
        return APPENO;
    }
    public void setAPPENO(String aPPENO) {
        APPENO = aPPENO;
    }
    public String getUSER_EMPNO() {
        return USER_EMPNO;
    }
    public void setUSER_EMPNO(String uSER_EMPNO) {
        USER_EMPNO = uSER_EMPNO;
    }
    public String getGBYN() {
        return GBYN;
    }
    public void setGBYN(String gBYN) {
        GBYN = gBYN;
    }
    public String getPAGESET() {
        return PAGESET;
    }
    public void setPAGESET(String pAGESET) {
        PAGESET = pAGESET;
    }
    public String getORDCOLUMN() {
        return ORDCOLUMN;
    }
    public void setORDCOLUMN(String oRDCOLUMN) {
        ORDCOLUMN = oRDCOLUMN;
    }
    public String getORDTYPE() {
        return ORDTYPE;
    }
    public void setORDTYPE(String oRDTYPE) {
        ORDTYPE = oRDTYPE;
    }
    public Integer getSTRIDX() {
        return STRIDX;
    }
    public void setSTRIDX(Integer sTRIDX) {
        STRIDX = sTRIDX;
    }
    public String getUPCODE() {
        return UPCODE;
    }
    public void setUPCODE(String uPCODE) {
        UPCODE = uPCODE;
    }
    public Integer getGBCDLEN() {
        return GBCDLEN;
    }
    public void setGBCDLEN(Integer gBCDLEN) {
        GBCDLEN = gBCDLEN;
    }
    public String getGBBG() {
        return GBBG;
    }
    public void setGBBG(String gBBG) {
        GBBG = gBBG;
    }
    public String getDELYN() {
        return DELYN;
    }
    public void setDELYN(String dELYN) {
        DELYN = dELYN;
    }
    public String getEMP_ID() {
        return EMP_ID;
    }
    public void setEMP_ID(String eMP_ID) {
        EMP_ID = eMP_ID;
    }
    public String getEMP_NM() {
        return EMP_NM;
    }
    public void setEMP_NM(String eMP_NM) {
        EMP_NM = eMP_NM;
    }
    public String getDEPT_NM() {
        return DEPT_NM;
    }
    public void setDEPT_NM(String dEPT_NM) {
        DEPT_NM = dEPT_NM;
    }
    public String getGET_MAIL() {
        return GET_MAIL;
    }
    public void setGET_MAIL(String gET_MAIL) {
        GET_MAIL = gET_MAIL;
    }
    public String[] getEMP_ID_ARR() {
        return EMP_ID_ARR;
    }
    public void setEMP_ID_ARR(String[] eMP_ID_ARR) {
        EMP_ID_ARR = eMP_ID_ARR;
    }
    public String getTELNO() {
        return TELNO;
    }
    public void setTELNO(String tELNO) {
        TELNO = tELNO;
    }
    public String getKEYWORD() {
        return KEYWORD;
    }
    public void setKEYWORD(String kEYWORD) {
        KEYWORD = kEYWORD;
    }
    public String getLCHDT() {
        return LCHDT;
    }
    public void setLCHDT(String lCHDT) {
        LCHDT = lCHDT;
    }
    public String getITEM() {
        return ITEM;
    }
    public void setITEM(String iTEM) {
        ITEM = iTEM;
    }
    public Integer getNO() {
        return NO;
    }
    public void setNO(Integer nO) {
        NO = nO;
    }
    public String getEQNO() {
        return EQNO;
    }
    public void setEQNO(String eQNO) {
        EQNO = eQNO;
    }
    public String getEQSN() {
        return EQSN;
    }
    public void setEQSN(String eQSN) {
        EQSN = eQSN;
    }
    public String getEQNM() {
        return EQNM;
    }
    public void setEQNM(String eQNM) {
        EQNM = eQNM;
    }
    public String getEQLST() {
        return EQLST;
    }
    public void setEQLST(String eQLST) {
        EQLST = eQLST;
    }
    public String getEQMST() {
        return EQMST;
    }
    public void setEQMST(String eQMST) {
        EQMST = eQMST;
    }
    public String getEQDET() {
        return EQDET;
    }
    public void setEQDET(String eQDET) {
        EQDET = eQDET;
    }
    public String getEQALIAS() {
        return EQALIAS;
    }
    public void setEQALIAS(String eQALIAS) {
        EQALIAS = eQALIAS;
    }
    public String getEQRST() {
        return EQRST;
    }
    public void setEQRST(String eQRST) {
        EQRST = eQRST;
    }
    public String getEQRDT() {
        return EQRDT;
    }
    public void setEQRDT(String eQRDT) {
        EQRDT = eQRDT;
    }
    public String getEQCDT() {
        return EQCDT;
    }
    public void setEQCDT(String eQCDT) {
        EQCDT = eQCDT;
    }
    public String getEQPKG() {
        return EQPKG;
    }
    public void setEQPKG(String eQPKG) {
        EQPKG = eQPKG;
    }
    public String getEQBRK() {
        return EQBRK;
    }
    public void setEQBRK(String eQBRK) {
        EQBRK = eQBRK;
    }
    public String getEQBG() {
        return EQBG;
    }
    public void setEQBG(String eQBG) {
        EQBG = eQBG;
    }
    public String getREGENM() {
        return REGENM;
    }
    public void setREGENM(String rEGENM) {
        REGENM = rEGENM;
    }
    public String getDELDT() {
        return DELDT;
    }
    public void setDELDT(String dELDT) {
        DELDT = dELDT;
    }
    public String getEQBRKDT() {
        return EQBRKDT;
    }
    public void setEQBRKDT(String eQBRKDT) {
        EQBRKDT = eQBRKDT;
    }
    public String getETC1() {
        return ETC1;
    }
    public void setETC1(String eTC1) {
        ETC1 = eTC1;
    }
    public String getETC2() {
        return ETC2;
    }
    public void setETC2(String eTC2) {
        ETC2 = eTC2;
    }
    public String getETC3() {
        return ETC3;
    }
    public void setETC3(String eTC3) {
        ETC3 = eTC3;
    }
    public String getETC4() {
        return ETC4;
    }
    public void setETC4(String eTC4) {
        ETC4 = eTC4;
    }
    public String getETC5() {
        return ETC5;
    }
    public void setETC5(String eTC5) {
        ETC5 = eTC5;
    }
    public String getETC6() {
        return ETC6;
    }
    public void setETC6(String eTC6) {
        ETC6 = eTC6;
    }
    public Integer getFILENO() {
        return FILENO;
    }
    public void setFILENO(Integer fILENO) {
        FILENO = fILENO;
    }
    public Integer getREFNO() {
        return REFNO;
    }
    public void setREFNO(Integer rEFNO) {
        REFNO = rEFNO;
    }
    public String getFILETP() {
        return FILETP;
    }
    public void setFILETP(String fILETP) {
        FILETP = fILETP;
    }
    public String getFILENM() {
        return FILENM;
    }
    public void setFILENM(String fILENM) {
        FILENM = fILENM;
    }
    public String getPATHNM() {
        return PATHNM;
    }
    public void setPATHNM(String pATHNM) {
        PATHNM = pATHNM;
    }
    public String getBANPDT() {
        return BANPDT;
    }
    public void setBANPDT(String bANPDT) {
        BANPDT = bANPDT;
    }
    public String getBANPDTCONV() {
		return BANPDTCONV;
	}
	public void setBANPDTCONV(String bANPDTCONV) {
		BANPDTCONV = bANPDTCONV;
	}
	public String getMDSEQ_GRP() {
        return MDSEQ_GRP;
    }
    public void setMDSEQ_GRP(String mDSEQ_GRP) {
        MDSEQ_GRP = mDSEQ_GRP;
    }
    public String getSch_status() {
        return sch_status;
    }
    public void setSch_status(String sch_status) {
        this.sch_status = sch_status;
    }
    public String getSch_approval() {
        return sch_approval;
    }
    public void setSch_approval(String sch_approval) {
        this.sch_approval = sch_approval;
    }
    public String getSch_return() {
        return sch_return;
    }
    public void setSch_return(String sch_return) {
        this.sch_return = sch_return;
    }
    public String getSch_text() {
        return sch_text;
    }
    public void setSch_text(String sch_text) {
        this.sch_text = sch_text;
    }
    public String getSch_text2() {
		return sch_text2;
	}
	public void setSch_text2(String sch_text2) {
		this.sch_text2 = sch_text2;
	}
	public String getTodayRecCode() {
        return todayRecCode;
    }
    public void setTodayRecCode(String todayRecCode) {
        this.todayRecCode = todayRecCode;
    }
    public String getTYPE() {
        return TYPE;
    }
    public void setTYPE(String tYPE) {
        TYPE = tYPE;
    }
    public String getSENDDT() {
        return SENDDT;
    }
    public void setSENDDT(String sENDDT) {
        SENDDT = sENDDT;
    }
    public String getSENDMS() {
        return SENDMS;
    }
    public void setSENDMS(String sENDMS) {
        SENDMS = sENDMS;
    }
    public String getETC() {
        return ETC;
    }
    public void setETC(String eTC) {
        ETC = eTC;
    }
    public String getEMPNO() {
        return EMPNO;
    }
    public void setEMPNO(String eMPNO) {
        EMPNO = eMPNO;
    }
    public String getDEPTNO() {
        return DEPTNO;
    }
    public void setDEPTNO(String dEPTNO) {
        DEPTNO = dEPTNO;
    }
    public String getDEPTFULNM() {
        return DEPTFULNM;
    }
    public void setDEPTFULNM(String dEPTFULNM) {
        DEPTFULNM = dEPTFULNM;
    }
    public String getSTATMODE() {
        return STATMODE;
    }
    public void setSTATMODE(String sTATMODE) {
        STATMODE = sTATMODE;
    }
    public String getSETDATE() {
        return SETDATE;
    }
    public void setSETDATE(String sETDATE) {
        SETDATE = sETDATE;
    }
    public String getAPPSS() {
        return APPSS;
    }
    public void setAPPSS(String aPPSS) {
        APPSS = aPPSS;
    }
    public String getUSEOBJ() {
        return USEOBJ;
    }
    public void setUSEOBJ(String uSEOBJ) {
        USEOBJ = uSEOBJ;
    }
    public String getIS_SIGN() {
        return IS_SIGN;
    }
    public void setIS_SIGN(String iS_SIGN) {
        IS_SIGN = iS_SIGN;
    }
    public String getSIGNMODE() {
        return SIGNMODE;
    }
    public void setSIGNMODE(String sIGNMODE) {
        SIGNMODE = sIGNMODE;
    }
    public String[] getASSIGNEDEQNO_ARR() {
        return ASSIGNEDEQNO_ARR;
    }
    public void setASSIGNEDEQNO_ARR(String[] aSSIGNEDEQNO_ARR) {
        ASSIGNEDEQNO_ARR = aSSIGNEDEQNO_ARR;
    }
    public String getEXCEPT_SELF_APPNO() {
        return EXCEPT_SELF_APPNO;
    }
    public void setEXCEPT_SELF_APPNO(String eXCEPT_SELF_APPNO) {
        EXCEPT_SELF_APPNO = eXCEPT_SELF_APPNO;
    }
    public String getAPPUENO() {
        return APPUENO;
    }
    public void setAPPUENO(String aPPUENO) {
        APPUENO = aPPUENO;
    }
    public String getINSUNM() {
        return INSUNM;
    }
    public void setINSUNM(String iNSUNM) {
        INSUNM = iNSUNM;
    }
    public String getINSUDT() {
        return INSUDT;
    }
    public void setINSUDT(String iNSUDT) {
        INSUDT = iNSUDT;
    }
    public String getBANPNM() {
        return BANPNM;
    }
    public void setBANPNM(String bANPNM) {
        BANPNM = bANPNM;
    }
    public String getBANPST() {
        return BANPST;
    }
    public void setBANPST(String bANPST) {
        BANPST = bANPST;
    }
	public int getSms_seq() {
		return sms_seq;
	}
	public void setSms_seq(int sms_seq) {
		this.sms_seq = sms_seq;
	}
	public String getPre_deptno() {
		return pre_deptno;
	}
	public void setPre_deptno(String pre_deptno) {
		this.pre_deptno = pre_deptno;
	}
	public String getNow_deptno() {
		return now_deptno;
	}
	public void setNow_deptno(String now_deptno) {
		this.now_deptno = now_deptno;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getSenddate() {
		return senddate;
	}
	public void setSenddate(String senddate) {
		this.senddate = senddate;
	}
	public String getSend_status() {
		return send_status;
	}
	public void setSend_status(String send_status) {
		this.send_status = send_status;
	}
	public String getRENT_OUT_MAIL_PATH() {
		return RENT_OUT_MAIL_PATH;
	}
	public void setRENT_OUT_MAIL_PATH(String rENT_OUT_MAIL_PATH) {
		RENT_OUT_MAIL_PATH = rENT_OUT_MAIL_PATH;
	}
	public String getRENT_IN_MAIL_PATH() {
		return RENT_IN_MAIL_PATH;
	}
	public void setRENT_IN_MAIL_PATH(String rENT_IN_MAIL_PATH) {
		RENT_IN_MAIL_PATH = rENT_IN_MAIL_PATH;
	}
	public String getRENT_OUT_MAIL_SEND() {
		return RENT_OUT_MAIL_SEND;
	}
	public void setRENT_OUT_MAIL_SEND(String rENT_OUT_MAIL_SEND) {
		RENT_OUT_MAIL_SEND = rENT_OUT_MAIL_SEND;
	}
	public String getRENT_IN_MAIL_SEND() {
		return RENT_IN_MAIL_SEND;
	}
	public void setRENT_IN_MAIL_SEND(String rENT_IN_MAIL_SEND) {
		RENT_IN_MAIL_SEND = rENT_IN_MAIL_SEND;
	}
	public String getEUSEQ() {
		return EUSEQ;
	}
	public void setEUSEQ(String eUSEQ) {
		EUSEQ = eUSEQ;
	}
	public String getEQNONULL() {
		return EQNONULL;
	}
	public void setEQNONULL(String eQNONULL) {
		EQNONULL = eQNONULL;
	}
	public String getUHSEQ() {
		return UHSEQ;
	}
	public void setUHSEQ(String uHSEQ) {
		UHSEQ = uHSEQ;
	}
	public String getMODE() {
		return MODE;
	}
	public void setMODE(String mODE) {
		MODE = mODE;
	}
	public String getINSUNO() {
		return INSUNO;
	}
	public void setINSUNO(String iNSUNO) {
		INSUNO = iNSUNO;
	}
	public String getINGAENO() {
		return INGAENO;
	}
	public void setINGAENO(String iNGAENO) {
		INGAENO = iNGAENO;
	}
	public String getINGAENM() {
		return INGAENM;
	}
	public void setINGAENM(String iNGAENM) {
		INGAENM = iNGAENM;
	}
	public String getMAILAPPROVAL() {
		return MAILAPPROVAL;
	}
	public void setMAILAPPROVAL(String mAILAPPROVAL) {
		MAILAPPROVAL = mAILAPPROVAL;
	}
	public String getNULL() {
		return NULL;
	}
	public void setNULL(String nULL) {
		NULL = nULL;
	}
	public String getUHSEQNULL() {
		return UHSEQNULL;
	}
	public void setUHSEQNULL(String uHSEQNULL) {
		UHSEQNULL = uHSEQNULL;
	}
	public String getBANPNO() {
		return BANPNO;
	}
	public void setBANPNO(String bANPNO) {
		BANPNO = bANPNO;
	}
	public String getAPPINSUNO() {
		return APPINSUNO;
	}
	public void setAPPINSUNO(String aPPINSUNO) {
		APPINSUNO = aPPINSUNO;
	}
	public String getAPPINSUNM() {
		return APPINSUNM;
	}
	public void setAPPINSUNM(String aPPINSUNM) {
		APPINSUNM = aPPINSUNM;
	}
	public String getModal_appno() {
		return modal_appno;
	}
	public void setModal_appno(String modal_appno) {
		this.modal_appno = modal_appno;
	}
	public String getAPPHP() {
		return APPHP;
	}
	public void setAPPHP(String aPPHP) {
		APPHP = aPPHP;
	}
	public String getINSUHP() {
		return INSUHP;
	}
	public void setINSUHP(String iNSUHP) {
		INSUHP = iNSUHP;
	}
	public String getREMAINDT() {
		return REMAINDT;
	}
	public void setREMAINDT(String rEMAINDT) {
		REMAINDT = rEMAINDT;
	}
	public String getAPPUEHP() {
		return APPUEHP;
	}
	public void setAPPUEHP(String aPPUEHP) {
		APPUEHP = aPPUEHP;
	}
	public String getJojikdo() {
		return jojikdo;
	}
	public void setJojikdo(String jojikdo) {
		this.jojikdo = jojikdo;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getPos_name() {
		return pos_name;
	}
	public void setPos_name(String pos_name) {
		this.pos_name = pos_name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getNo_gubun() {
		return no_gubun;
	}
	public void setNo_gubun(String no_gubun) {
		this.no_gubun = no_gubun;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getDept_code() {
		return dept_code;
	}
	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}
	public String getDept_nm_tree() {
		return dept_nm_tree;
	}
	public void setDept_nm_tree(String dept_nm_tree) {
		this.dept_nm_tree = dept_nm_tree;
	}
	public String getDcode() {
		return dcode;
	}
	public void setDcode(String dcode) {
		this.dcode = dcode;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getDepth() {
		return depth;
	}
	public void setDepth(String depth) {
		this.depth = depth;
	}
	public String[] getSpace() {
		return space;
	}
	public void setSpace(String[] space) {
		this.space = space;
	}
	public String getTotalDcode() {
		return totalDcode;
	}
	public void setTotalDcode(String totalDcode) {
		this.totalDcode = totalDcode;
	}
	public String getHtmlMode() {
		return htmlMode;
	}
	public void setHtmlMode(String htmlMode) {
		this.htmlMode = htmlMode;
	}
	public String getDept1Name() {
		return dept1Name;
	}
	public void setDept1Name(String dept1Name) {
		this.dept1Name = dept1Name;
	}
	public String getDept2Name() {
		return dept2Name;
	}
	public void setDept2Name(String dept2Name) {
		this.dept2Name = dept2Name;
	}
	public String getDept3Name() {
		return dept3Name;
	}
	public void setDept3Name(String dept3Name) {
		this.dept3Name = dept3Name;
	}
	public String getDept4Name() {
		return dept4Name;
	}
	public void setDept4Name(String dept4Name) {
		this.dept4Name = dept4Name;
	}
	public String getDept5Name() {
		return dept5Name;
	}
	public void setDept5Name(String dept5Name) {
		this.dept5Name = dept5Name;
	}
	public String getDept6Name() {
		return dept6Name;
	}
	public void setDept6Name(String dept6Name) {
		this.dept6Name = dept6Name;
	}
	public String getDept1Code() {
		return dept1Code;
	}
	public void setDept1Code(String dept1Code) {
		this.dept1Code = dept1Code;
	}
	public String getDept2Code() {
		return dept2Code;
	}
	public void setDept2Code(String dept2Code) {
		this.dept2Code = dept2Code;
	}
	public String getDept3Code() {
		return dept3Code;
	}
	public void setDept3Code(String dept3Code) {
		this.dept3Code = dept3Code;
	}
	public String getDept4Code() {
		return dept4Code;
	}
	public void setDept4Code(String dept4Code) {
		this.dept4Code = dept4Code;
	}
	public String getDept5Code() {
		return dept5Code;
	}
	public void setDept5Code(String dept5Code) {
		this.dept5Code = dept5Code;
	}
	public String getDept6Code() {
		return dept6Code;
	}
	public void setDept6Code(String dept6Code) {
		this.dept6Code = dept6Code;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
    public String getTARGETMODE() {
        return TARGETMODE;
    }
    public String getRENT_IN_SIGN_IMG() {
		return RENT_IN_SIGN_IMG;
	}
	public void setRENT_IN_SIGN_IMG(String rENT_IN_SIGN_IMG) {
		RENT_IN_SIGN_IMG = rENT_IN_SIGN_IMG;
	}
	public String getRENT_OUT_SIGN_IMG() {
		return RENT_OUT_SIGN_IMG;
	}
	public void setRENT_OUT_SIGN_IMG(String rENT_OUT_SIGN_IMG) {
		RENT_OUT_SIGN_IMG = rENT_OUT_SIGN_IMG;
	}
    public void setTARGETMODE(String tARGETMODE) {
        TARGETMODE = tARGETMODE;
    }
    public String getLevelno() {
        return levelno;
    }
    public void setLevelno(String levelno) {
        this.levelno = levelno;
    }
	public String getSEQNO() {
		return SEQNO;
	}
	public void setSEQNO(String sEQNO) {
		SEQNO = sEQNO;
	}
	public String getLINKKEY() {
		return LINKKEY;
	}
	public void setLINKKEY(String lINKKEY) {
		LINKKEY = lINKKEY;
	}
	public String getSIGN_STATUS() {
		return SIGN_STATUS;
	}
	public void setSIGN_STATUS(String sIGN_STATUS) {
		SIGN_STATUS = sIGN_STATUS;
	}
	public String getTITLE() {
		return TITLE;
	}
	public void setTITLE(String tITLE) {
		TITLE = tITLE;
	}
	public String getMASTER_NO() {
		return MASTER_NO;
	}
	public void setMASTER_NO(String mASTER_NO) {
		MASTER_NO = mASTER_NO;
	}
	public String getBATCH_FLAG() {
		return BATCH_FLAG;
	}
	public void setBATCH_FLAG(String bATCH_FLAG) {
		BATCH_FLAG = bATCH_FLAG;
	}
	public String getLINK() {
		return LINK;
	}
	public void setLINK(String lINK) {
		LINK = lINK;
	}
	public String getSIGN_LEVEL() {
		return SIGN_LEVEL;
	}
	public void setSIGN_LEVEL(String sIGN_LEVEL) {
		SIGN_LEVEL = sIGN_LEVEL;
	}
	public String getMETHOD() {
		return METHOD;
	}
	public void setMETHOD(String mETHOD) {
		METHOD = mETHOD;
	}
	public String getSIGN_DATE() {
		return SIGN_DATE;
	}
	public void setSIGN_DATE(String sIGN_DATE) {
		SIGN_DATE = sIGN_DATE;
	}
	public String getEQASSETSNO() {
		return EQASSETSNO;
	}
	public void setEQASSETSNO(String eQASSETSNO) {
		EQASSETSNO = eQASSETSNO;
	}
	public String getNUM() {
		return NUM;
	}
	public void setNUM(String nUM) {
		NUM = nUM;
	}

}
