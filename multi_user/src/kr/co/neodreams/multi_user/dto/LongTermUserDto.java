package kr.co.neodreams.multi_user.dto;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

public class LongTermUserDto extends BasePagingDto {
	
	private int NUM;
	private String GBCD;
	private String GBNM;
	private String GBYN;
	private String EQHNO;	
	private String MDSEQ;
	private String MDNM;
	private String EQNO;
	private String EQSN;
	private String EQCDT;
	private String EQRDT;
	private String EQNM;
	private String EQLST;
	private String EQMST;
	private String EQDET;
	private String EQALIAS;
	private String APPSS;
	private String APPENM;
	private String REGENM;
	private String APPENO;
	private String STATUS;
	private String STATUSNM;
	private String STRDT;
	private String ENDDT;
	private String APPNO;
	
	private String APPUENO;
	private String APPUENM;
	private String EQMSTNM;
	
	// ��Ʈ�� ���˴���
	private String DELYN;
	private String INSUNM;
	private String CMOSPWYN;
	private String LOGONPWYN;
	private String SHAREFOLDERDELYN;
	private String DOCUMENTDELYN;
	private String OSUPDATEYN;
	private String V3UPDATEYN;
	private String MANAGERNM;
	private String MANAGERNO;
	private String UPMANAGERNM;
	private String UPMANAGERNO;
	private String PARTMANAGERNM;
	private String PARTMANAGERNO;
	private String BIGO;
	private String SCHTEXT;
	private String schEQST;
	private String schStatus;
	
	private String SRH_ORDER;
	private String schCode;
	
	private String APPE_DEPTNM;
	private String DEPT1NM;
	private String EQASSETSNO;
	private	String ETC2;
	
	public String getMANAGERNO() {
		return MANAGERNO;
	}
	public String getUPMANAGERNO() {
		return UPMANAGERNO;
	}
	public String getPARTMANAGERNM() {
		return PARTMANAGERNM;
	}
	public String getPARTMANAGERNO() {
		return PARTMANAGERNO;
	}
	public void setMANAGERNO(String mANAGERNO) {
		MANAGERNO = mANAGERNO;
	}
	public void setUPMANAGERNO(String uPMANAGERNO) {
		UPMANAGERNO = uPMANAGERNO;
	}
	public void setPARTMANAGERNM(String pARTMANAGERNM) {
		PARTMANAGERNM = pARTMANAGERNM;
	}
	public void setPARTMANAGERNO(String pARTMANAGERNO) {
		PARTMANAGERNO = pARTMANAGERNO;
	}
	public String getETC2() {
		return ETC2;
	}
	public void setETC2(String eTC2) {
		ETC2 = eTC2;
	}
	public String getSchCode() {
		return schCode;
	}
	public void setSchCode(String schCode) {
		this.schCode = schCode;
	}
	
	public String getSchStatus() {
		return schStatus;
	}
	public void setSchStatus(String schStatus) {
		this.schStatus = schStatus;
	}
	public String getEQMSTNM() {
		return EQMSTNM;
	}
	public void setEQMSTNM(String eQMSTNM) {
		EQMSTNM = eQMSTNM;
	}
	public int getNUM() {
		return NUM;
	}
	public void setNUM(int nUM) {
		NUM = nUM;
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
	public String getGBYN() {
		return GBYN;
	}
	public void setGBYN(String gBYN) {
		GBYN = gBYN;
	}
	public String getEQHNO() {
		return EQHNO;
	}
	public void setEQHNO(String eQHNO) {
		EQHNO = eQHNO;
	}
	public String getMDSEQ() {
		return MDSEQ;
	}
	public void setMDSEQ(String mDSEQ) {
		MDSEQ = mDSEQ;
	}

	public String getMDNM() {
		return MDNM;
	}
	public void setMDNM(String mDNM) {
		MDNM = mDNM;
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
	public String getEQCDT() {
		return EQCDT;
	}
	public void setEQCDT(String eQCDT) {
		EQCDT = eQCDT;
	}
	public String getEQRDT() {
		return EQRDT;
	}
	public void setEQRDT(String eQRDT) {
		EQRDT = eQRDT;
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
	public String getAPPSS() {
		return APPSS;
	}
	public void setAPPSS(String aPPSS) {
		APPSS = aPPSS;
	}
	public String getAPPENM() {
		return APPENM;
	}
	public void setAPPENM(String aPPENM) {
		APPENM = aPPENM;
	}
	public String getREGENM() {
		return REGENM;
	}
	public void setREGENM(String rEGENM) {
		REGENM = rEGENM;
	}
	public String getAPPENO() {
		return APPENO;
	}
	public void setAPPENO(String aPPENO) {
		APPENO = aPPENO;
	}
	public String getSTATUS() {
		return STATUS;
	}
	public void setSTATUS(String sTATUS) {
		STATUS = sTATUS;
	}
	public String getSTATUSNM() {
		return STATUSNM;
	}
	public void setSTATUSNM(String sTATUSNM) {
		STATUSNM = sTATUSNM;
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
	public String getAPPNO() {
		return APPNO;
	}
	public void setAPPNO(String aPPNO) {
		APPNO = aPPNO;
	}
	public String getDELYN() {
		return DELYN;
	}
	public void setDELYN(String dELYN) {
		DELYN = dELYN;
	}
	public String getINSUNM() {
		return INSUNM;
	}
	public void setINSUNM(String iNSUNM) {
		INSUNM = iNSUNM;
	}
	public String getCMOSPWYN() {
		return CMOSPWYN;
	}
	public void setCMOSPWYN(String cMOSPWYN) {
		CMOSPWYN = cMOSPWYN;
	}
	public String getLOGONPWYN() {
		return LOGONPWYN;
	}
	public void setLOGONPWYN(String lOGONPWYN) {
		LOGONPWYN = lOGONPWYN;
	}
	public String getSHAREFOLDERDELYN() {
		return SHAREFOLDERDELYN;
	}
	public void setSHAREFOLDERDELYN(String sHAREFOLDERDELYN) {
		SHAREFOLDERDELYN = sHAREFOLDERDELYN;
	}
	public String getDOCUMENTDELYN() {
		return DOCUMENTDELYN;
	}
	public void setDOCUMENTDELYN(String dOCUMENTDELYN) {
		DOCUMENTDELYN = dOCUMENTDELYN;
	}
	public String getOSUPDATEYN() {
		return OSUPDATEYN;
	}
	public void setOSUPDATEYN(String oSUPDATEYN) {
		OSUPDATEYN = oSUPDATEYN;
	}
	public String getV3UPDATEYN() {
		return V3UPDATEYN;
	}
	public void setV3UPDATEYN(String v3updateyn) {
		V3UPDATEYN = v3updateyn;
	}
	public String getMANAGERNM() {
		return MANAGERNM;
	}
	public void setMANAGERNM(String mANAGERNM) {
		MANAGERNM = mANAGERNM;
	}
	public String getUPMANAGERNM() {
		return UPMANAGERNM;
	}
	public void setUPMANAGERNM(String uPMANAGERNM) {
		UPMANAGERNM = uPMANAGERNM;
	}
	public String getBIGO() {
		return BIGO;
	}
	public void setBIGO(String bIGO) {
		BIGO = bIGO;
	}
	public String getSCHTEXT() {
		return SCHTEXT;
	}
	public void setSCHTEXT(String sCHTEXT) {
		SCHTEXT = sCHTEXT;
	}
	
	public String getAPPUENO() {
		return APPUENO;
	}
	public void setAPPUENO(String aPPUENO) {
		APPUENO = aPPUENO;
	}
	public String getAPPUENM() {
		return APPUENM;
	}
	public void setAPPUENM(String aPPUENM) {
		APPUENM = aPPUENM;
	}
	public String getSRH_ORDER() {
		return SRH_ORDER;
	}
	public void setSRH_ORDER(String sRH_ORDER) {
		SRH_ORDER = sRH_ORDER;
	}
	public String getAPPE_DEPTNM() {
		return APPE_DEPTNM;
	}
	public void setAPPE_DEPTNM(String aPPE_DEPTNM) {
		APPE_DEPTNM = aPPE_DEPTNM;
	}
	public String getDEPT1NM() {
		return DEPT1NM;
	}
	public void setDEPT1NM(String dEPT1NM) {
		DEPT1NM = dEPT1NM;
	}
	public String getEQASSETSNO() {
		return EQASSETSNO;
	}
	public void setEQASSETSNO(String eQASSETSNO) {
		EQASSETSNO = eQASSETSNO;
	}
	public String getSchEQST() {
		return schEQST;
	}
	public void setSchEQST(String schEQST) {
		this.schEQST = schEQST;
	}
	
}
