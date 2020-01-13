package kr.co.neodreams.multi_user.dto;

import java.util.ArrayList;

public class DisplayBoardDto extends DisplayFileDto{
    
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
	/*게시일시용*/
	private String STIME1;
	private String STIME2;
	private String STIME3;
	private String ETIME1;
	private String ETIME2;
	private String ETIME3;
	
	private	String	approveState;
	
	/*20190704 강정우 dext파일등록 재정의*/
	private String fileSeq_1;		//첨부파일 1
	private String fileSeq_2;		//첨부파일 2
	private String fileSeq_3;		//첨부파일 3
	private String fileSeq_4;		//완료파일
	private String SDP_SEQ;					//첨부파일 seq
	private String SDP_orgFileName;			//첨부파일 이름
	private String SDP_phycalPath;			//첨부파일 경로
	private String SDP_status;				//완료파일 여부
	private String searchStatus;			//사용자파일,완료파일 구분
	private String SM_REGDATE;				//
	private String AC_SEQ;					//약관동의 SEQ
	private String AC_STATUS;				//약관동의 선택여부
	private String AC_CONTENTS;				//약관동의 내용
	private String SDP_worker;				//작업자
	private String xmlGubun;				//엑셀다운로드 구분

	private int C1_TOT;				//셀 합계
	private int C2_TOT;				//셀 합계
	private int C3_TOT;				//셀 합계
	private int C4_TOT;				//셀 합계
	private ArrayList<String> lists3;		//체크박스 검색

	private String regDate;			//처리완료 날짜
	
	
	public String getSDP_worker() {
		return SDP_worker;
	}
	public void setSDP_worker(String sDP_worker) {
		SDP_worker = sDP_worker;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getC1_TOT() {
		return C1_TOT;
	}
	public int getC2_TOT() {
		return C2_TOT;
	}
	public int getC3_TOT() {
		return C3_TOT;
	}
	public int getC4_TOT() {
		return C4_TOT;
	}
	public void setC1_TOT(int c1_TOT) {
		C1_TOT = c1_TOT;
	}
	public void setC2_TOT(int c2_TOT) {
		C2_TOT = c2_TOT;
	}
	public void setC3_TOT(int c3_TOT) {
		C3_TOT = c3_TOT;
	}
	public void setC4_TOT(int c4_TOT) {
		C4_TOT = c4_TOT;
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
	public String getAC_CONTENTS() {
		return AC_CONTENTS;
	}
	public void setAC_CONTENTS(String aC_CONTENTS) {
		AC_CONTENTS = aC_CONTENTS;
	}
	public String getSM_REGDATE() {
		return SM_REGDATE;
	}
	public String getAC_SEQ() {
		return AC_SEQ;
	}
	public String getAC_STATUS() {
		return AC_STATUS;
	}
	public void setSM_REGDATE(String sM_REGDATE) {
		SM_REGDATE = sM_REGDATE;
	}
	public void setAC_SEQ(String aC_SEQ) {
		AC_SEQ = aC_SEQ;
	}
	public void setAC_STATUS(String aC_STATUS) {
		AC_STATUS = aC_STATUS;
	}
	public String getSearchStatus() {
		return searchStatus;
	}
	public void setSearchStatus(String searchStatus) {
		this.searchStatus = searchStatus;
	}
	public String getApproveState() {
		return approveState;
	}
	public String getFileSeq_1() {
		return fileSeq_1;
	}
	public String getFileSeq_2() {
		return fileSeq_2;
	}
	public String getFileSeq_3() {
		return fileSeq_3;
	}
	public String getFileSeq_4() {
		return fileSeq_4;
	}
	public String getSDP_SEQ() {
		return SDP_SEQ;
	}
	public String getSDP_orgFileName() {
		return SDP_orgFileName;
	}
	public String getSDP_phycalPath() {
		return SDP_phycalPath;
	}
	public String getSDP_status() {
		return SDP_status;
	}
	public void setFileSeq_1(String fileSeq_1) {
		this.fileSeq_1 = fileSeq_1;
	}
	public void setFileSeq_2(String fileSeq_2) {
		this.fileSeq_2 = fileSeq_2;
	}
	public void setFileSeq_3(String fileSeq_3) {
		this.fileSeq_3 = fileSeq_3;
	}
	public void setFileSeq_4(String fileSeq_4) {
		this.fileSeq_4 = fileSeq_4;
	}
	public void setSDP_SEQ(String sDP_SEQ) {
		SDP_SEQ = sDP_SEQ;
	}
	public void setSDP_orgFileName(String sDP_orgFileName) {
		SDP_orgFileName = sDP_orgFileName;
	}
	public void setSDP_phycalPath(String sDP_phycalPath) {
		SDP_phycalPath = sDP_phycalPath;
	}
	public void setSDP_status(String sDP_status) {
		SDP_status = sDP_status;
	}
	public void setApproveState(String approveState) {
		this.approveState = approveState;
	}
	public String getSTIME1() {
		return STIME1;
	}
	public void setSTIME1(String sTIME1) {
		STIME1 = sTIME1;
	}
	public String getSTIME2() {
		return STIME2;
	}
	public void setSTIME2(String sTIME2) {
		STIME2 = sTIME2;
	}
	public String getSTIME3() {
		return STIME3;
	}
	public void setSTIME3(String sTIME3) {
		STIME3 = sTIME3;
	}
	public String getETIME1() {
		return ETIME1;
	}
	public void setETIME1(String eTIME1) {
		ETIME1 = eTIME1;
	}
	public String getETIME2() {
		return ETIME2;
	}
	public void setETIME2(String eTIME2) {
		ETIME2 = eTIME2;
	}
	public String getETIME3() {
		return ETIME3;
	}
	public void setETIME3(String eTIME3) {
		ETIME3 = eTIME3;
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
	public String getSM_UDATE() {
		return SM_UDATE;
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
	public String getN_SM_NO() {
		return N_SM_NO;
	}
	public void setN_SM_NO(String n_SM_NO) {
		N_SM_NO = n_SM_NO;
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
	public String getSHSEQNUM() {
		return SHSEQNUM;
	}
	public void setSHSEQNUM(String sHSEQNUM) {
		SHSEQNUM = sHSEQNUM;
	}
    
    
}
