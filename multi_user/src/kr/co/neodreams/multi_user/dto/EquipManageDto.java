package kr.co.neodreams.multi_user.dto;

import java.util.Map;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;
import kr.co.neodreams.multi_user.common.StringUtil;

public class EquipManageDto extends BasePagingDto{
    /*code1가져오기*/
    private String gbcd;
    private String gbnm;

    private String seqno;

    private String empno;
    private String name;
    private String deptName;
    private String posName;
    private String regSign;
    private String signDate;
    private String title;

    /*시퀀스*/
    private String mdseq;
    private String[] mdseqArr;
    private String[] assignedArr;
    private String mdno;
    private String mdtxt;
    private String mdnm;
    private String lchdt;
    private int betMonth;
    private String amount;
    private String orderBy;

    /*대여가능 장비대수*/
    private int rentEnableCnt;

    /*장비정보*/
    private String item;
    private String itemNm;

    /*이미지정보*/
    private String imageUrl;

    /*장비코드 DB검색용*/
    private String code;

    /*카운트*/
    private int itemCnt;

    /*사원넘버*/
    private String SM_MEMPNO;

    /*장비 상세 검색*/
    private String searchVal;

    private int best;
    private String lch;
    private String lchImg;
    private String checkbox;
    private int eqEnable;
    private int eqAll;
    private String eqSel;
    private String btnApp;
    private String btnBasket;

    private String fileNo;
    private String fileNm;
    private String pathNm;
    private String filetp;
    private String refno;

    /*장바구니 정보*/
    private String bskno;
    private String strdt;
    private String enddt;
    private String regeno;
    private String regenm;
    private String regdt;
    private Map<String, Object> modelByCodeList;

    private String appno;
    private String appnum;
    private String appeno;
    private String appenm;
    private String status;
    private String approval;
    private String appueno;
    private String apptel;
    private String apphp;
    private String appuenm;
    private String appss;
    private String appmail;
    private String useobj;
    private String appinsuno;
    private String appinsunm;
    private String insuno;
    private String insunm;
    private String insudt;
    private String ingaeno; 
    private String ingaenm;
    private String bigo;
    private String etc_comment;
    private String banpno;
    private String banpnm;
    private String banpdt;
    private String banpst;
    private String RENT_IN_SIGN_IMG;
    private String RENT_OUT_SIGN_IMG;
    
	private String eqnm;
    private String eqno;
    private String[] eqnoArr;
    private String eqrst;
    private String eqmst;
    private String eqlst;
    private String eqalias;
    private int assignedAmount;
    private String uhseq;
    private String mailapproval;
    private String deptno;
    private String DEPT1NM;
    
    private String euseq;

    private String banpflag;
    
    private String rent_NB_Gubun;
    
    /*대여등록시 첨부파일 추가*/
    private String RENT_SECURITY_fileName;
    private String RENT_SECURITY_orgFileName;
    private String RENT_SECURITY_ext;
    private String RENT_SECURITY_phycalPath;
    private String RENT_SECURITY_logicalPath;
    private String RENT_SECURITY_userPK;
    private String RENT_SECURITY_regDate;
    private int RENT_SECURITY_SEQ;
   
    private	String	insuDeptNo;			//인수자 부서코드
    private	String	insuDeptNm;			//인수자 부서명
    
    
    
	public String getInsuDeptNo() {
		return insuDeptNo;
	}
	public void setInsuDeptNo(String insuDeptNo) {
		this.insuDeptNo = insuDeptNo;
	}
	public String getInsuDeptNm() {
		return insuDeptNm;
	}
	public void setInsuDeptNm(String insuDeptNm) {
		this.insuDeptNm = insuDeptNm;
	}
	public String getRENT_SECURITY_fileName() {
		return RENT_SECURITY_fileName;
	}
	public String getRENT_SECURITY_orgFileName() {
		return RENT_SECURITY_orgFileName;
	}
	public String getRENT_SECURITY_ext() {
		return RENT_SECURITY_ext;
	}
	public String getRENT_SECURITY_phycalPath() {
		return RENT_SECURITY_phycalPath;
	}
	public String getRENT_SECURITY_logicalPath() {
		return RENT_SECURITY_logicalPath;
	}
	public String getRENT_SECURITY_userPK() {
		return RENT_SECURITY_userPK;
	}
	public String getRENT_SECURITY_regDate() {
		return RENT_SECURITY_regDate;
	}
	public int getRENT_SECURITY_SEQ() {
		return RENT_SECURITY_SEQ;
	}
	public void setRENT_SECURITY_fileName(String rENT_SECURITY_fileName) {
		RENT_SECURITY_fileName = rENT_SECURITY_fileName;
	}
	public void setRENT_SECURITY_orgFileName(String rENT_SECURITY_orgFileName) {
		RENT_SECURITY_orgFileName = rENT_SECURITY_orgFileName;
	}
	public void setRENT_SECURITY_ext(String rENT_SECURITY_ext) {
		RENT_SECURITY_ext = rENT_SECURITY_ext;
	}
	public void setRENT_SECURITY_phycalPath(String rENT_SECURITY_phycalPath) {
		RENT_SECURITY_phycalPath = rENT_SECURITY_phycalPath;
	}
	public void setRENT_SECURITY_logicalPath(String rENT_SECURITY_logicalPath) {
		RENT_SECURITY_logicalPath = rENT_SECURITY_logicalPath;
	}
	public void setRENT_SECURITY_userPK(String rENT_SECURITY_userPK) {
		RENT_SECURITY_userPK = rENT_SECURITY_userPK;
	}
	public void setRENT_SECURITY_regDate(String rENT_SECURITY_regDate) {
		RENT_SECURITY_regDate = rENT_SECURITY_regDate;
	}
	public void setRENT_SECURITY_SEQ(int rENT_SECURITY_SEQ) {
		RENT_SECURITY_SEQ = rENT_SECURITY_SEQ;
	}
	public String getRent_NB_Gubun() {
		return rent_NB_Gubun;
	}
	public void setRent_NB_Gubun(String rent_NB_Gubun) {
		this.rent_NB_Gubun = rent_NB_Gubun;
	}
	public String getDEPT1NM() {
		return DEPT1NM;
	}
	public void setDEPT1NM(String dEPT1NM) {
		DEPT1NM = dEPT1NM;
	}
	public String getTitle() {
        return title;
    }
    public String[] getEqnoArr() {
        return eqnoArr;
    }
    public void setEqnoArr(String[] eqnoArr) {
        this.eqnoArr = eqnoArr;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getRegSign() {
        return regSign;
    }
    public void setRegSign(String regSign) {
        this.regSign = regSign;
    }
    public String getSignDate() {
        return signDate;
    }
    public void setSignDate(String signDate) {
        this.signDate = signDate;
    }
    public String getSeqno() {
        return seqno;
    }
    public void setSeqno(String seqno) {
        this.seqno = seqno;
    }
    public String getEmpno() {
        return empno;
    }
    public void setEmpno(String empno) {
        this.empno = empno;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getDeptName() {
        return deptName;
    }
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
    public String getPosName() {
        return posName;
    }
    public void setPosName(String posName) {
        this.posName = posName;
    }
    public String getMdno() {
        return mdno;
    }
    public void setMdno(String mdno) {
        this.mdno = mdno;
    }
    public String getMdtxt() {
        return mdtxt;
    }
    public void setMdtxt(String mdtxt) {
        this.mdtxt = mdtxt;
    }
    public String getMdnm() {
        return mdnm;
    }
    public void setMdnm(String mdnm) {
        this.mdnm = mdnm;
    }
    public String getLchdt() {
        return lchdt;
    }
    public void setLchdt(String lchdt) {
        this.lchdt = lchdt;
    }
    public int getBetMonth() {
        return betMonth;
    }
    public void setBetMonth(int betMonth) {
        this.betMonth = betMonth;
    }
    public String getGbcd() {
        return gbcd;
    }
    public void setGbcd(String gbcd) {
        this.gbcd = gbcd;
    }
    public String getGbnm() {
        return gbnm;
    }
    public void setGbnm(String gbnm) {
        this.gbnm = gbnm;
    }
    public String getAmount() {
        return amount;
    }
    public void setAmount(String amount) {
        this.amount = amount;
    }
    public String getOrderBy() {
        return orderBy;
    }
    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }
    public String getItem() {
        return item;
    }
    public void setItem(String item) {
        this.item = item;
    }
    public String getItemNm() {
        return itemNm;
    }
    public void setItemNm(String itemNm) {
        this.itemNm = itemNm;
    }
    public int getRentEnableCnt() {
        return rentEnableCnt;
    }
    public void setRentEnableCnt(int rentEnableCnt) {
        this.rentEnableCnt = rentEnableCnt;
    }
    public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    public String getCode() {
        return code;
    }
    public void setCode(String code) {
        this.code = code;
    }
    public int getItemCnt() {
        return itemCnt;
    }
    public void setItemCnt(int itemCnt) {
        this.itemCnt = itemCnt;
    }
    public String getSM_MEMPNO() {
        return SM_MEMPNO;
    }
    public void setSM_MEMPNO(String sM_MEMPNO) {
        SM_MEMPNO = sM_MEMPNO;
    }
    public String getSearchVal() {
        return searchVal;
    }
    public void setSearchVal(String searchVal) {
        this.searchVal = searchVal;
    }
    public int getBest() {
        return best;
    }
    public void setBest(int best) {
        this.best = best;
    }
    public String getLch() {
        return lch;
    }
    public void setLch(String lch) {
        this.lch = lch;
    }
    public String getLchImg() {
        return lchImg;
    }
    public void setLchImg(String lchImg) {
        this.lchImg = lchImg;
    }
    public String getCheckbox() {
        return checkbox;
    }
    public void setCheckbox(String checkbox) {
        this.checkbox = checkbox;
    }
    public int getEqEnable() {
        return eqEnable;
    }
    public void setEqEnable(int eqEnable) {
        this.eqEnable = eqEnable;
    }
    public int getEqAll() {
        return eqAll;
    }
    public void setEqAll(int eqAll) {
        this.eqAll = eqAll;
    }
    public String getEqSel() {
        return eqSel;
    }
    public void setEqSel(String eqSel) {
        this.eqSel = eqSel;
    }
    public String getBtnApp() {
        return btnApp;
    }
    public void setBtnApp(String btnApp) {
        this.btnApp = btnApp;
    }
    public String getBtnBasket() {
        return btnBasket;
    }
    public void setBtnBasket(String btnBasket) {
        this.btnBasket = btnBasket;
    }
    public String getFileNo() {
        return fileNo;
    }
    public void setFileNo(String fileNo) {
        this.fileNo = fileNo;
    }
    public String getFileNm() {
        return fileNm;
    }
    public void setFileNm(String fileNm) {
        this.fileNm = fileNm;
    }
    public String getPathNm() {
        return pathNm;
    }
    public void setPathNm(String pathNm) {
        this.pathNm = pathNm;
    }
    public String getFiletp() {
        return filetp;
    }
    public void setFiletp(String filetp) {
        this.filetp = filetp;
    }
    public String getRefno() {
        return refno;
    }
    public void setRefno(String refno) {
        this.refno = refno;
    }
    public String getBskno() {
        return bskno;
    }
    public void setBskno(String bskno) {
        this.bskno = bskno;
    }
    public String getStrdt() {
        return strdt;
    }
    public void setStrdt(String strdt) {
        this.strdt = strdt;
    }
    public String getEnddt() {
        return enddt;
    }
    public void setEnddt(String enddt) {
        this.enddt = enddt;
    }
    public String getMdseq() {
        return mdseq;
    }
    public void setMdseq(String mdseq) {
        this.mdseq = mdseq;
    }
    public String[] getMdseqArr() {
        return mdseqArr;
    }
    public void setMdseqArr(String[] mdseqArr) {
        this.mdseqArr = mdseqArr;
    }
    public String[] getAssignedArr() {
        return assignedArr;
    }
    public void setAssignedArr(String[] assignedArr) {
        this.assignedArr = assignedArr;
    }
    public String getRegeno() {
        return regeno;
    }
    public void setRegeno(String regeno) {
        this.regeno = regeno;
    }
    public String getRegenm() {
        return regenm;
    }
    public void setRegenm(String regenm) {
        this.regenm = regenm;
    }
    public String getRegdt() {
        return regdt;
    }
    public void setRegdt(String regdt) {
    	if(StringUtil.isEmpty(regdt)){
    		this.regdt = regdt;
    	}else{
    		this.regdt = regdt.trim();
    	}
    }
    public Map<String, Object> getModelByCodeList() {
        return modelByCodeList;
    }
    public void setModelByCodeList(Map<String, Object> modelByCodeList) {
        this.modelByCodeList = modelByCodeList;
    }
    public String getAppnum() {
        return appnum;
    }
    public void setAppnum(String appnum) {
        this.appnum = appnum;
    }
    public String getAppeno() {
        return appeno;
    }
    public void setAppeno(String appeno) {
        this.appeno = appeno;
    }
    public String getAppenm() {
        return appenm;
    }
    public void setAppenm(String appenm) {
        this.appenm = appenm;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public String getApproval() {
        return approval;
    }
    public void setApproval(String approval) {
        this.approval = approval;
    }
    public String getAppueno() {
        return appueno;
    }
    public void setAppueno(String appueno) {
        this.appueno = appueno;
    }
    public String getApptel() {
        return apptel;
    }
    public void setApptel(String apptel) {
        this.apptel = apptel;
    }
    public String getApphp() {
        return apphp;
    }
    public void setApphp(String apphp) {
        this.apphp = apphp;
    }
    public String getAppuenm() {
        return appuenm;
    }
    public void setAppuenm(String appuenm) {
        this.appuenm = appuenm;
    }
    public String getAppss() {
        return appss;
    }
    public void setAppss(String appss) {
        this.appss = appss;
    }
    public String getAppmail() {
        return appmail;
    }
    public void setAppmail(String appmail) {
        this.appmail = appmail;
    }
    public String getUseobj() {
        return useobj;
    }
    public void setUseobj(String useobj) {
        this.useobj = useobj;
    }
    public String getInsunm() {
        return insunm;
    }
    public void setInsunm(String insunm) {
        this.insunm = insunm;
    }
    public String getInsudt() {
        return insudt;
    }
    public void setInsudt(String insudt) {
    	if(StringUtil.isEmpty(insudt)){
    		this.insudt = insudt;
    	}else{
    		this.insudt = insudt.trim();
    	}
    }
    public String getBigo() {
        return bigo;
    }
    public void setBigo(String bigo) {
        this.bigo = bigo;
    }
    public String getEtc_comment() {
        return etc_comment;
    }
    public void setEtc_comment(String etc_comment) {
        this.etc_comment = etc_comment;
    }
    public String getBanpnm() {
        return banpnm;
    }
    public void setBanpnm(String banpnm) {
        this.banpnm = banpnm;
    }
    public String getBanpdt() {
        return banpdt;
    }
    public void setBanpdt(String banpdt) {
    	if(StringUtil.isEmpty(banpdt)){
    		this.banpdt = banpdt;
    	}else{
    		this.banpdt = banpdt.trim();
    	}
    }
    public String getBanpst() {
        return banpst;
    }
    public void setBanpst(String banpst) {
        this.banpst = banpst;
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
    public String getAppno() {
        return appno;
    }
    public void setAppno(String appno) {
        this.appno = appno;
    }
    public String getEqnm() {
        return eqnm;
    }
    public void setEqnm(String eqnm) {
        this.eqnm = eqnm;
    }
    public String getEqno() {
        return eqno;
    }
    public void setEqno(String eqno) {
        this.eqno = eqno;
    }
    public String getEqrst() {
        return eqrst;
    }
    public void setEqrst(String eqrst) {
        this.eqrst = eqrst;
    }
    public String getEqmst() {
        return eqmst;
    }
    public void setEqmst(String eqmst) {
        this.eqmst = eqmst;
    }
    public String getEqlst() {
        return eqlst;
    }
    public void setEqlst(String eqlst) {
        this.eqlst = eqlst;
    }
    public String getEqalias() {
        return eqalias;
    }
    public void setEqalias(String eqalias) {
        this.eqalias = eqalias;
    }
    public int getAssignedAmount() {
        return assignedAmount;
    }
    public void setAssignedAmount(int assignedAmount) {
        this.assignedAmount = assignedAmount;
    }
	public String getEuseq() {
		return euseq;
	}
	public void setEuseq(String euseq) {
		this.euseq = euseq;
	}
	public String getMailapproval() {
		return mailapproval;
	}
	public void setMailapproval(String mailapproval) {
		this.mailapproval = mailapproval;
	}
	public String getInsuno() {
		return insuno;
	}
	public void setInsuno(String insuno) {
		this.insuno = insuno;
	}
	public String getIngaeno() {
		return ingaeno;
	}
	public void setIngaeno(String ingaeno) {
		this.ingaeno = ingaeno;
	}
	public String getIngaenm() {
		return ingaenm;
	}
	public void setIngaenm(String ingaenm) {
		this.ingaenm = ingaenm;
	}
	public String getUhseq() {
		return uhseq;
	}
	public void setUhseq(String uhseq) {
		this.uhseq = uhseq;
	}
	public String getBanpno() {
		return banpno;
	}
	public void setBanpno(String banpno) {
		this.banpno = banpno;
	}
	public String getAppinsuno() {
		return appinsuno;
	}
	public void setAppinsuno(String appinsuno) {
		this.appinsuno = appinsuno;
	}
	public String getAppinsunm() {
		return appinsunm;
	}
	public void setAppinsunm(String appinsunm) {
		this.appinsunm = appinsunm;
	}
	public String getBanpflag() {
		return banpflag;
	}
	public void setBanpflag(String banpflag) {
		this.banpflag = banpflag;
	}
	public String getDeptno() {
		return deptno;
	}
	public void setDeptno(String deptno) {
		this.deptno = deptno;
	}
}
