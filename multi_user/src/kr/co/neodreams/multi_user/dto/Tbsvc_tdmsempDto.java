package kr.co.neodreams.multi_user.dto;

public class Tbsvc_tdmsempDto extends Tbsvc_tdmsdeptDto{
	private String EMPNO;
	private String NAME;
	private String MAILNO;
	private String DEPT_NAME;
	private String DEPTNO;
	private String TELNO;
	
	public String getEMPNO() {
		return EMPNO;
	}
	public void setEMPNO(String eMPNO) {
		EMPNO = eMPNO;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String nAME) {
		NAME = nAME;
	}
	public String getMAILNO() {
		return MAILNO;
	}
	public void setMAILNO(String mAILNO) {
		MAILNO = mAILNO;
	}
	public String getDEPT_NAME() {
		return DEPT_NAME;
	}
	public void setDEPT_NAME(String dEPT_NAME) {
		DEPT_NAME = dEPT_NAME;
	}
	public String getDEPTNO() {
		return DEPTNO;
	}
	public void setDEPTNO(String dEPTNO) {
		DEPTNO = dEPTNO;
	}
	public String getTELNO() {
		return TELNO;
	}
	public void setTELNO(String tELNO) {
		TELNO = tELNO;
	}
}
