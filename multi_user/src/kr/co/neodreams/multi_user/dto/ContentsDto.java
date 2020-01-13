package kr.co.neodreams.multi_user.dto;

import java.util.ArrayList;

public class ContentsDto extends ContentsFileDto{
    
	private int SM_SEQ;
	private String SM_DATE; 
	private String SM_SVC1; 
	private String SM_SVC2; 
	private String SM_MEMPNO; 
	private String SM_MCCD; 
	private String SM_MCNAME; 
	private String SM_MC1CD; 
	private String SM_MC1NAME; 
	private String SM_MC2CD; 
	private String SM_MC2NAME; 
	private String SM_MDCD; 
	private String SM_MDNAME; 
	private String SM_MTCD; 
	private String SM_MTNAME; 
	private String SM_MNAME; 
	private String SM_MTEL; 
	private String SM_MCEL; 
	private String SM_MEMAIL; 
	private String SM_TITLE; 
	private String SM_TEXT; 
	private String SM_FDATE; 
	private String SM_LSTATE; 
	private String SM_FSTATE;
	private String SM_ISSIGN;
	private String SM_SIGNNO;
	private String SM_NOTE;
	private String SM_IPADDR;
	private String SM_WDATE;
	/* 신청일 조회시 ~부터 */
	private String SM_WDATE_FROM;
	/* 신청일 조회시  ~까지 */
	private String SM_WDATE_TO;
	private String SM_UDATE;
	private String SM_CDATE;
	private String SM_SDFDATE;
	private String CD2_NAME;
	/*max count*/
	private String N_SM_NO;
	/*신규 추가 컬럼*/
	private String SSTART;
	private String MULTIPAGE;
	private String MULTITIME;
	private String MULTITIMEOUT;
	/*검색용*/
	private String S1;
	private String S2;
	private String S3;
	private String S4;
	/*디테일용*/
	private String SHSEQNUM;
	/*카테고리별 카운트용 */
	private String CON1_ING;
	private String CON2_ING;
	private String CON3_ING;
	private String CON4_ING;
	private String CON5_ING;
	private String CON6_ING;
	private String CON7_ING;
	private String CON1_WAIT;
	private String CON2_WAIT;
	private String CON3_WAIT;
	private String CON4_WAIT;
	private String CON5_WAIT;
	private String CON6_WAIT;
	private String CON7_WAIT;
	
	/*20190531 강정우 추가*/
	private String svc2Cnt;			//매체별 건수
	private String SM_AMOUNT;		//작업요청 수량
	private String SM_ALARM;		//약관
	/*약관동의*/
	private int AC_SEQ; 			//약관 seq
	private String AC_DEPT;			//등록자 부서코드
	private String AC_REG_USER;		//등록자 사번
	private String AC_REG_NAME; 	//등록자 이름
	private String AC_REG_DATE;		//등록일
	private String AC_TITLE;		//제목
	private String AC_CONTENTS;		//약관 내용
	private String AC_STATUS;		//약관 선택여부
	private String AC_MOD_DATE;		//수정일
	private String AC_MOD_USER;		//수정자 사번
	private String AC_DEL_DATE;		//삭제일
	private String AC_DEL_USER;		//삭제자 사번
	private String AC_DELYN;		//삭제여부
	
	/*dext파일등록 재정의*/
	private String fileSeq_1;		//첨부파일 1
	private String fileSeq_2;		//첨부파일 2
	private String fileSeq_3;		//첨부파일 3
	private String fileSeq_4;		//완료파일
	private String SCF_SEQ;					//첨부파일 seq
	private String SCF_orgFileName;			//첨부파일 이름
	private String SCF_phycalPath;			//첨부파일 경로
	private String SCF_status;				//완료파일 여부
	
	/*사용자 조회*/
	private String SCT_allow1EMP;			//승인자1 사번
	private String SCT_allow1NM;			//승인자1 이름
	private String SCT_allow1DEPT;			//승인자1 부서코드
	private String SCT_allow1DEPTNM;		//승인자1 부서명
	private String SCT_allow2EMP;			//팀장 사번
	private String SCT_allow2NM;			//팀장 이름
	private String SCT_allow2DEPT;			//팀장 부서코드
	private String SCT_allow2DEPTNM;		//팀장 부서명
	private String SCT_allow1REGDATE;		//승인자1 승인시간
	private String SCT_allow2REGDATE;		//팀장 승인시간
	
	private String allow; 					//승인자 구분
	
	private String SDP_FDATE;				//전광판 게시일 시작
	private String SDP_TDATE;				//전광판 게시일 끝
	private String SCT_RDATE;				//요청날짜
	private String SCT_TDATE;				//예정날짜
	private String SDP_PLANDATE;			
	private String SCT_worker;				//작업자
	private String xmlGubun;				//엑셀다운로드 구분
	private String regDate;				//엑셀다운로드 구분
	
	private ArrayList<String> lists3;		//체크박스 검색
	
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getXmlGubun() {
		return xmlGubun;
	}
	public void setXmlGubun(String xmlGubun) {
		this.xmlGubun = xmlGubun;
	}
	public ArrayList<String> getLists3() {
		return lists3;
	}
	public void setLists3(ArrayList<String> lists3) {
		this.lists3 = lists3;
	}
	public String getSCT_worker() {
		return SCT_worker;
	}
	public void setSCT_worker(String sCT_worker) {
		SCT_worker = sCT_worker;
	}
	public String getSDP_PLANDATE() {
		return SDP_PLANDATE;
	}
	public void setSDP_PLANDATE(String sDP_PLANDATE) {
		SDP_PLANDATE = sDP_PLANDATE;
	}
	public String getSCT_RDATE() {
		return SCT_RDATE;
	}
	public String getSCT_TDATE() {
		return SCT_TDATE;
	}
	public void setSCT_RDATE(String sCT_RDATE) {
		SCT_RDATE = sCT_RDATE;
	}
	public void setSCT_TDATE(String sCT_TDATE) {
		SCT_TDATE = sCT_TDATE;
	}
	public String getSDP_FDATE() {
		return SDP_FDATE;
	}
	public String getSDP_TDATE() {
		return SDP_TDATE;
	}
	public void setSDP_FDATE(String sDP_FDATE) {
		SDP_FDATE = sDP_FDATE;
	}
	public void setSDP_TDATE(String sDP_TDATE) {
		SDP_TDATE = sDP_TDATE;
	}
	public String getSCF_status() {
		return SCF_status;
	}
	public void setSCF_status(String sCF_status) {
		SCF_status = sCF_status;
	}
	public String getFileSeq_4() {
		return fileSeq_4;
	}
	public void setFileSeq_4(String fileSeq_4) {
		this.fileSeq_4 = fileSeq_4;
	}
	public String getSCT_allow1REGDATE() {
		return SCT_allow1REGDATE;
	}
	public void setSCT_allow1REGDATE(String sCT_allow1REGDATE) {
		SCT_allow1REGDATE = sCT_allow1REGDATE;
	}
	public String getSCT_allow2REGDATE() {
		return SCT_allow2REGDATE;
	}
	public void setSCT_allow2REGDATE(String sCT_allow2REGDATE) {
		SCT_allow2REGDATE = sCT_allow2REGDATE;
	}
	public String getAllow() {
		return allow;
	}
	public void setAllow(String allow) {
		this.allow = allow;
	}
	public String getSCT_allow1EMP() {
		return SCT_allow1EMP;
	}
	public void setSCT_allow1EMP(String sCT_allow1EMP) {
		SCT_allow1EMP = sCT_allow1EMP;
	}
	public String getSCT_allow1NM() {
		return SCT_allow1NM;
	}
	public void setSCT_allow1NM(String sCT_allow1NM) {
		SCT_allow1NM = sCT_allow1NM;
	}
	public String getSCT_allow1DEPT() {
		return SCT_allow1DEPT;
	}
	public void setSCT_allow1DEPT(String sCT_allow1DEPT) {
		SCT_allow1DEPT = sCT_allow1DEPT;
	}
	public String getSCT_allow1DEPTNM() {
		return SCT_allow1DEPTNM;
	}
	public void setSCT_allow1DEPTNM(String sCT_allow1DEPTNM) {
		SCT_allow1DEPTNM = sCT_allow1DEPTNM;
	}
	public String getSCT_allow2EMP() {
		return SCT_allow2EMP;
	}
	public void setSCT_allow2EMP(String sCT_allow2EMP) {
		SCT_allow2EMP = sCT_allow2EMP;
	}
	public String getSCT_allow2NM() {
		return SCT_allow2NM;
	}
	public void setSCT_allow2NM(String sCT_allow2NM) {
		SCT_allow2NM = sCT_allow2NM;
	}
	public String getSCT_allow2DEPT() {
		return SCT_allow2DEPT;
	}
	public void setSCT_allow2DEPT(String sCT_allow2DEPT) {
		SCT_allow2DEPT = sCT_allow2DEPT;
	}
	public String getSCT_allow2DEPTNM() {
		return SCT_allow2DEPTNM;
	}
	public void setSCT_allow2DEPTNM(String sCT_allow2DEPTNM) {
		SCT_allow2DEPTNM = sCT_allow2DEPTNM;
	}
	public String getSCF_phycalPath() {
		return SCF_phycalPath;
	}
	public void setSCF_phycalPath(String sCF_phycalPath) {
		SCF_phycalPath = sCF_phycalPath;
	}
	public String getSCF_orgFileName() {
		return SCF_orgFileName;
	}
	public void setSCF_orgFileName(String sCF_orgFileName) {
		SCF_orgFileName = sCF_orgFileName;
	}
	public String getSCF_SEQ() {
		return SCF_SEQ;
	}
	public void setSCF_SEQ(String sCF_SEQ) {
		SCF_SEQ = sCF_SEQ;
	}
	public String getFileSeq_1() {
		return fileSeq_1;
	}
	public void setFileSeq_1(String fileSeq_1) {
		this.fileSeq_1 = fileSeq_1;
	}
	public String getFileSeq_2() {
		return fileSeq_2;
	}
	public void setFileSeq_2(String fileSeq_2) {
		this.fileSeq_2 = fileSeq_2;
	}
	public String getFileSeq_3() {
		return fileSeq_3;
	}
	public void setFileSeq_3(String fileSeq_3) {
		this.fileSeq_3 = fileSeq_3;
	}
	public String getAC_REG_USER() {
		return AC_REG_USER;
	}
	public void setAC_REG_USER(String aC_REG_USER) {
		AC_REG_USER = aC_REG_USER;
	}
	public String getAC_MOD_USER() {
		return AC_MOD_USER;
	}
	public void setAC_MOD_USER(String aC_MOD_USER) {
		AC_MOD_USER = aC_MOD_USER;
	}
	public String getAC_DEL_USER() {
		return AC_DEL_USER;
	}
	public void setAC_DEL_USER(String aC_DEL_USER) {
		AC_DEL_USER = aC_DEL_USER;
	}
	public int getAC_SEQ() {
		return AC_SEQ;
	}
	public void setAC_SEQ(int aC_SEQ) {
		AC_SEQ = aC_SEQ;
	}
	public String getAC_DEPT() {
		return AC_DEPT;
	}
	public void setAC_DEPT(String aC_DEPT) {
		AC_DEPT = aC_DEPT;
	}
	public String getAC_REG_NAME() {
		return AC_REG_NAME;
	}
	public void setAC_REG_NAME(String aC_REG_NAME) {
		AC_REG_NAME = aC_REG_NAME;
	}
	public String getAC_REG_DATE() {
		return AC_REG_DATE;
	}
	public void setAC_REG_DATE(String aC_REG_DATE) {
		AC_REG_DATE = aC_REG_DATE;
	}
	public String getAC_TITLE() {
		return AC_TITLE;
	}
	public void setAC_TITLE(String aC_TITLE) {
		AC_TITLE = aC_TITLE;
	}
	public String getAC_CONTENTS() {
		return AC_CONTENTS;
	}
	public void setAC_CONTENTS(String aC_CONTENTS) {
		AC_CONTENTS = aC_CONTENTS;
	}
	public String getAC_STATUS() {
		return AC_STATUS;
	}
	public void setAC_STATUS(String aC_STATUS) {
		AC_STATUS = aC_STATUS;
	}
	public String getAC_MOD_DATE() {
		return AC_MOD_DATE;
	}
	public void setAC_MOD_DATE(String aC_MOD_DATE) {
		AC_MOD_DATE = aC_MOD_DATE;
	}
	public String getAC_DEL_DATE() {
		return AC_DEL_DATE;
	}
	public void setAC_DEL_DATE(String aC_DEL_DATE) {
		AC_DEL_DATE = aC_DEL_DATE;
	}
	public String getAC_DELYN() {
		return AC_DELYN;
	}
	public void setAC_DELYN(String aC_DELYN) {
		AC_DELYN = aC_DELYN;
	}
	public String getSM_ALARM() {
		return SM_ALARM;
	}
	public void setSM_ALARM(String sM_ALARM) {
		SM_ALARM = sM_ALARM;
	}
	public String getSM_AMOUNT() {
		return SM_AMOUNT;
	}
	public void setSM_AMOUNT(String sM_AMOUNT) {
		SM_AMOUNT = sM_AMOUNT;
	}
	public String getSvc2Cnt() {
		return svc2Cnt;
	}
	public void setSvc2Cnt(String svc2Cnt) {
		this.svc2Cnt = svc2Cnt;
	}
	public String getCON1_ING() {
		return CON1_ING;
	}
	public void setCON1_ING(String cON1_ING) {
		CON1_ING = cON1_ING;
	}
	public String getCON2_ING() {
		return CON2_ING;
	}
	public void setCON2_ING(String cON2_ING) {
		CON2_ING = cON2_ING;
	}
	public String getCON3_ING() {
		return CON3_ING;
	}
	public void setCON3_ING(String cON3_ING) {
		CON3_ING = cON3_ING;
	}
	public String getCON4_ING() {
		return CON4_ING;
	}
	public void setCON4_ING(String cON4_ING) {
		CON4_ING = cON4_ING;
	}
	public String getCON5_ING() {
		return CON5_ING;
	}
	public void setCON5_ING(String cON5_ING) {
		CON5_ING = cON5_ING;
	}
	public String getCON6_ING() {
		return CON6_ING;
	}
	public void setCON6_ING(String cON6_ING) {
		CON6_ING = cON6_ING;
	}
	public String getCON7_ING() {
		return CON7_ING;
	}
	public void setCON7_ING(String cON7_ING) {
		CON7_ING = cON7_ING;
	}
	public String getCON1_WAIT() {
		return CON1_WAIT;
	}
	public void setCON1_WAIT(String cON1_WAIT) {
		CON1_WAIT = cON1_WAIT;
	}
	public String getCON2_WAIT() {
		return CON2_WAIT;
	}
	public void setCON2_WAIT(String cON2_WAIT) {
		CON2_WAIT = cON2_WAIT;
	}
	public String getCON3_WAIT() {
		return CON3_WAIT;
	}
	public void setCON3_WAIT(String cON3_WAIT) {
		CON3_WAIT = cON3_WAIT;
	}
	public String getCON4_WAIT() {
		return CON4_WAIT;
	}
	public void setCON4_WAIT(String cON4_WAIT) {
		CON4_WAIT = cON4_WAIT;
	}
	public String getCON5_WAIT() {
		return CON5_WAIT;
	}
	public void setCON5_WAIT(String cON5_WAIT) {
		CON5_WAIT = cON5_WAIT;
	}
	public String getCON6_WAIT() {
		return CON6_WAIT;
	}
	public void setCON6_WAIT(String cON6_WAIT) {
		CON6_WAIT = cON6_WAIT;
	}
	public String getCON7_WAIT() {
		return CON7_WAIT;
	}
	public void setCON7_WAIT(String cON7_WAIT) {
		CON7_WAIT = cON7_WAIT;
	}
	public String getSHSEQNUM() {
		return SHSEQNUM;
	}
	public void setSHSEQNUM(String sHSEQNUM) {
		SHSEQNUM = sHSEQNUM;
	}
	public String getS1() {
		return S1;
	}
	public void setS1(String s1) {
		S1 = s1;
	}
	public String getS2() {
		return S2;
	}
	public void setS2(String s2) {
		S2 = s2;
	}
	public String getS3() {
		return S3;
	}
	public void setS3(String s3) {
		S3 = s3;
	}
	public String getS4() {
		return S4;
	}
	public void setS4(String s4) {
		S4 = s4;
	}
	public String getSSTART() {
		return SSTART;
	}
	public void setSSTART(String sSTART) {
		SSTART = sSTART;
	}
	public String getMULTIPAGE() {
		return MULTIPAGE;
	}
	public void setMULTIPAGE(String mULTIPAGE) {
		MULTIPAGE = mULTIPAGE;
	}
	public String getMULTITIME() {
		return MULTITIME;
	}
	public void setMULTITIME(String mULTITIME) {
		MULTITIME = mULTITIME;
	}
	public String getMULTITIMEOUT() {
		return MULTITIMEOUT;
	}
	public void setMULTITIMEOUT(String mULTITIMEOUT) {
		MULTITIMEOUT = mULTITIMEOUT;
	}
	public String getN_SM_NO() {
		return N_SM_NO;
	}
	public void setN_SM_NO(String n_SM_NO) {
		N_SM_NO = n_SM_NO;
	}
	public int getSM_SEQ() {
		return SM_SEQ;
	}
	public void setSM_SEQ(int sM_SEQ) {
		SM_SEQ = sM_SEQ;
	}
	public String getSM_DATE() {
		return SM_DATE;
	}
	public void setSM_DATE(String sM_DATE) {
		SM_DATE = sM_DATE;
	}
	public String getSM_SVC1() {
		return SM_SVC1;
	}
	public void setSM_SVC1(String sM_SVC1) {
		SM_SVC1 = sM_SVC1;
	}
	public String getSM_SVC2() {
		return SM_SVC2;
	}
	public void setSM_SVC2(String sM_SVC2) {
		SM_SVC2 = sM_SVC2;
	}
	public String getSM_MEMPNO() {
		return SM_MEMPNO;
	}
	public void setSM_MEMPNO(String sM_MEMPNO) {
		SM_MEMPNO = sM_MEMPNO;
	}
	public String getSM_MCCD() {
		return SM_MCCD;
	}
	public void setSM_MCCD(String sM_MCCD) {
		SM_MCCD = sM_MCCD;
	}
	public String getSM_MCNAME() {
		return SM_MCNAME;
	}
	public void setSM_MCNAME(String sM_MCNAME) {
		SM_MCNAME = sM_MCNAME;
	}
	public String getSM_MC1CD() {
		return SM_MC1CD;
	}
	public void setSM_MC1CD(String sM_MC1CD) {
		SM_MC1CD = sM_MC1CD;
	}
	public String getSM_MC1NAME() {
		return SM_MC1NAME;
	}
	public void setSM_MC1NAME(String sM_MC1NAME) {
		SM_MC1NAME = sM_MC1NAME;
	}
	public String getSM_MC2CD() {
		return SM_MC2CD;
	}
	public void setSM_MC2CD(String sM_MC2CD) {
		SM_MC2CD = sM_MC2CD;
	}
	public String getSM_MC2NAME() {
		return SM_MC2NAME;
	}
	public void setSM_MC2NAME(String sM_MC2NAME) {
		SM_MC2NAME = sM_MC2NAME;
	}
	public String getSM_MDCD() {
		return SM_MDCD;
	}
	public void setSM_MDCD(String sM_MDCD) {
		SM_MDCD = sM_MDCD;
	}
	public String getSM_MDNAME() {
		return SM_MDNAME;
	}
	public void setSM_MDNAME(String sM_MDNAME) {
		SM_MDNAME = sM_MDNAME;
	}
	public String getSM_MTCD() {
		return SM_MTCD;
	}
	public void setSM_MTCD(String sM_MTCD) {
		SM_MTCD = sM_MTCD;
	}
	public String getSM_MTNAME() {
		return SM_MTNAME;
	}
	public void setSM_MTNAME(String sM_MTNAME) {
		SM_MTNAME = sM_MTNAME;
	}
	public String getSM_MNAME() {
		return SM_MNAME;
	}
	public void setSM_MNAME(String sM_MNAME) {
		SM_MNAME = sM_MNAME;
	}
	public String getSM_MTEL() {
		return SM_MTEL;
	}
	public void setSM_MTEL(String sM_MTEL) {
		SM_MTEL = sM_MTEL;
	}
	public String getSM_MCEL() {
		return SM_MCEL;
	}
	public void setSM_MCEL(String sM_MCEL) {
		SM_MCEL = sM_MCEL;
	}
	public String getSM_MEMAIL() {
		return SM_MEMAIL;
	}
	public void setSM_MEMAIL(String sM_MEMAIL) {
		SM_MEMAIL = sM_MEMAIL;
	}
	public String getSM_TITLE() {
		return SM_TITLE;
	}
	public void setSM_TITLE(String sM_TITLE) {
		SM_TITLE = sM_TITLE;
	}
	public String getSM_TEXT() {
		return SM_TEXT;
	}
	public void setSM_TEXT(String sM_TEXT) {
		SM_TEXT = sM_TEXT;
	}
	public String getSM_FDATE() {
		return SM_FDATE;
	}
	public void setSM_FDATE(String sM_FDATE) {
		SM_FDATE = sM_FDATE;
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
	public String getSM_NOTE() {
		return SM_NOTE;
	}
	public void setSM_NOTE(String sM_NOTE) {
		SM_NOTE = sM_NOTE;
	}
	public String getSM_IPADDR() {
		return SM_IPADDR;
	}
	public void setSM_IPADDR(String sM_IPADDR) {
		SM_IPADDR = sM_IPADDR;
	}
	public String getSM_WDATE() {
		return SM_WDATE;
	}
	public void setSM_WDATE(String sM_WDATE) {
		SM_WDATE = sM_WDATE;
	}
	public String getSM_UDATE() {
		return SM_UDATE;
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
	public void setSM_UDATE(String sM_UDATE) {
		SM_UDATE = sM_UDATE;
	}
	public String getSM_CDATE() {
		return SM_CDATE;
	}
	public void setSM_CDATE(String sM_CDATE) {
		SM_CDATE = sM_CDATE;
	}
	public String getSM_SDFDATE() {
		return SM_SDFDATE;
	}
	public void setSM_SDFDATE(String sM_SDFDATE) {
		SM_SDFDATE = sM_SDFDATE;
	}
	public String getCD2_NAME() {
        return CD2_NAME;
    }
    public void setCD2_NAME(String cD2_NAME) {
        CD2_NAME = cD2_NAME;
    }
    public String getSM_SDTDATE() {
		return SM_SDTDATE;
	}
	public void setSM_SDTDATE(String sM_SDTDATE) {
		SM_SDTDATE = sM_SDTDATE;
	}
	public String getSM_SDRDATE() {
		return SM_SDRDATE;
	}
	public void setSM_SDRDATE(String sM_SDRDATE) {
		SM_SDRDATE = sM_SDRDATE;
	}
	public String getSM_SDUSEPLACE1() {
		return SM_SDUSEPLACE1;
	}
	public void setSM_SDUSEPLACE1(String sM_SDUSEPLACE1) {
		SM_SDUSEPLACE1 = sM_SDUSEPLACE1;
	}
	public String getSM_SDUSEPLACE2() {
		return SM_SDUSEPLACE2;
	}
	public void setSM_SDUSEPLACE2(String sM_SDUSEPLACE2) {
		SM_SDUSEPLACE2 = sM_SDUSEPLACE2;
	}
	public String getSM_SDRCMAN() {
		return SM_SDRCMAN;
	}
	public void setSM_SDRCMAN(String sM_SDRCMAN) {
		SM_SDRCMAN = sM_SDRCMAN;
	}
	public String getSM_SDRTMAN() {
		return SM_SDRTMAN;
	}
	public void setSM_SDRTMAN(String sM_SDRTMAN) {
		SM_SDRTMAN = sM_SDRTMAN;
	}
	public int getSM_CSPOINT() {
		return SM_CSPOINT;
	}
	public void setSM_CSPOINT(int sM_CSPOINT) {
		SM_CSPOINT = sM_CSPOINT;
	}
	public String getSM_CSMEMO() {
		return SM_CSMEMO;
	}
	public void setSM_CSMEMO(String sM_CSMEMO) {
		SM_CSMEMO = sM_CSMEMO;
	}
	public String getSM_CSSEND() {
		return SM_CSSEND;
	}
	public void setSM_CSSEND(String sM_CSSEND) {
		SM_CSSEND = sM_CSSEND;
	}
	private String SM_SDTDATE;
	private String SM_SDRDATE;
	private String SM_SDUSEPLACE1;
	private String SM_SDUSEPLACE2;
	private String SM_SDRCMAN;
	private String SM_SDRTMAN;
	private int SM_CSPOINT;
	private String SM_CSMEMO;
	private String SM_CSSEND;
}
