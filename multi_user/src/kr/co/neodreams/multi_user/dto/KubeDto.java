package kr.co.neodreams.multi_user.dto;


import org.springframework.web.multipart.MultipartFile;

import kr.co.neodreams.multi_user.base.dto.BasePagingDto;

public class KubeDto extends BasePagingDto{
	
	private String empno;
	
	private String adm_gubun;
	
	private int seq;
	private String url_info;
	private String min_title;
	private String cap_title;
	private String thumb_file_name;
	private String thumb_phy_path;
	private String thumb_log_path;
	private String reg_date;
	private String reg_empno;
	private MultipartFile thumbFiles;
	
	private int p_code_seq;
	private int ori_p_code_seq;
	private int code_seq;
	private String code_desc;
	private int code_gubun;
	private String category;
	private String mod_date;
	private String mod_empno;
	private String etc_info;
	
	private int open_flag;
	private int download_flag;
	private int code_seq1;
	private int code_seq2;
	private String title;
	private String contents_desc;
	private String[] thumb_url;
	private String writer;
	private String dept_code;
	private String pds_ori_name;
	private String pds_saved_name;
	private String pds_ext;
	private long pds_size;
	private String pds_phy_path;
	private String pds_log_path;
	private int vi_seq;
	private String vi_seq_hash;
	private String vi_seq_hash_r;
	private int vc_seq;
	private String vc_seq_hash;
	private String vc_seq_hash_r;
	private int vit_seq;
	private int main_flag;
	private String selOrder;
	private String srh_keyword;
	private String srh_keyword_top;
	
	private String app_empno;
	
	private String vh_gubun;
	private int vh_seq;
	private String target_vc_seq;
	private int p_vc_seq;
	private String comment_desc;
	private int vi_status;
	private int vc_status;
	private int va_status;
	private String va_status_hash;
	
	private int report_gubun;
	private int selReport;
	private String re_desc;
	private int re_seq;
	private int taskVal;
	private int re_gubun;
	private int re_status;
	private String act_gubun;
	
	private String duration;
	private String conv_flag;
	
	private String rm_gubun;
	private String autoplayA;
	private String autoplayO;
	private String[] myChkList;
	private String inQuery;
	private String orderVal;
	
	private String start_date;
	private String end_date;
	
	private String sel_f_dept_code;
	private String sel_s_dept_code;
	
	private String complete_flag;
	private String srh_date;
	
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getAdm_gubun() {
		return adm_gubun;
	}
	public void setAdm_gubun(String adm_gubun) {
		this.adm_gubun = adm_gubun;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getUrl_info() {
		return url_info;
	}
	public void setUrl_info(String url_info) {
		this.url_info = url_info;
	}
	public String getMin_title() {
		return min_title;
	}
	public void setMin_title(String min_title) {
		this.min_title = min_title;
	}
	public String getCap_title() {
		return cap_title;
	}
	public void setCap_title(String cap_title) {
		this.cap_title = cap_title;
	}
	public String getThumb_file_name() {
		return thumb_file_name;
	}
	public void setThumb_file_name(String thumb_file_name) {
		this.thumb_file_name = thumb_file_name;
	}
	public String getThumb_phy_path() {
		return thumb_phy_path;
	}
	public void setThumb_phy_path(String thumb_phy_path) {
		this.thumb_phy_path = thumb_phy_path;
	}
	public String getThumb_log_path() {
		return thumb_log_path;
	}
	public void setThumb_log_path(String thumb_log_path) {
		this.thumb_log_path = thumb_log_path;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getReg_empno() {
		return reg_empno;
	}
	public void setReg_empno(String reg_empno) {
		this.reg_empno = reg_empno;
	}
	public MultipartFile getThumbFiles() {
		return thumbFiles;
	}
	public void setThumbFiles(MultipartFile thumbFiles) {
		this.thumbFiles = thumbFiles;
	}
	public int getP_code_seq() {
		return p_code_seq;
	}
	public void setP_code_seq(int p_code_seq) {
		this.p_code_seq = p_code_seq;
	}
	public int getOri_p_code_seq() {
		return ori_p_code_seq;
	}
	public void setOri_p_code_seq(int ori_p_code_seq) {
		this.ori_p_code_seq = ori_p_code_seq;
	}
	public int getCode_seq() {
		return code_seq;
	}
	public void setCode_seq(int code_seq) {
		this.code_seq = code_seq;
	}
	public String getCode_desc() {
		return code_desc;
	}
	public void setCode_desc(String code_desc) {
		this.code_desc = code_desc;
	}
	public int getCode_gubun() {
		return code_gubun;
	}
	public void setCode_gubun(int code_gubun) {
		this.code_gubun = code_gubun;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getMod_date() {
		return mod_date;
	}
	public void setMod_date(String mod_date) {
		this.mod_date = mod_date;
	}
	public String getMod_empno() {
		return mod_empno;
	}
	public void setMod_empno(String mod_empno) {
		this.mod_empno = mod_empno;
	}
	public String getEtc_info() {
		return etc_info;
	}
	public void setEtc_info(String etc_info) {
		this.etc_info = etc_info;
	}
	public int getOpen_flag() {
		return open_flag;
	}
	public void setOpen_flag(int open_flag) {
		this.open_flag = open_flag;
	}
	public int getDownload_flag() {
		return download_flag;
	}
	public void setDownload_flag(int download_flag) {
		this.download_flag = download_flag;
	}
	public int getCode_seq1() {
		return code_seq1;
	}
	public void setCode_seq1(int code_seq1) {
		this.code_seq1 = code_seq1;
	}
	public int getCode_seq2() {
		return code_seq2;
	}
	public void setCode_seq2(int code_seq2) {
		this.code_seq2 = code_seq2;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents_desc() {
		return contents_desc;
	}
	public void setContents_desc(String contents_desc) {
		this.contents_desc = contents_desc;
	}
	public String[] getThumb_url() {
		return thumb_url;
	}
	public void setThumb_url(String[] thumb_url) {
		this.thumb_url = thumb_url;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getDept_code() {
		return dept_code;
	}
	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}
	public String getPds_ori_name() {
		return pds_ori_name;
	}
	public void setPds_ori_name(String pds_ori_name) {
		this.pds_ori_name = pds_ori_name;
	}
	public String getPds_saved_name() {
		return pds_saved_name;
	}
	public void setPds_saved_name(String pds_saved_name) {
		this.pds_saved_name = pds_saved_name;
	}
	public String getPds_ext() {
		return pds_ext;
	}
	public void setPds_ext(String pds_ext) {
		this.pds_ext = pds_ext;
	}
	public long getPds_size() {
		return pds_size;
	}
	public void setPds_size(long pds_size) {
		this.pds_size = pds_size;
	}
	public String getPds_phy_path() {
		return pds_phy_path;
	}
	public void setPds_phy_path(String pds_phy_path) {
		this.pds_phy_path = pds_phy_path;
	}
	public String getPds_log_path() {
		return pds_log_path;
	}
	public void setPds_log_path(String pds_log_path) {
		this.pds_log_path = pds_log_path;
	}
	public int getVi_seq() {
		return vi_seq;
	}
	public void setVi_seq(int vi_seq) {
		this.vi_seq = vi_seq;
	}
	public String getVi_seq_hash() {
		return vi_seq_hash;
	}
	public void setVi_seq_hash(String vi_seq_hash) {
		this.vi_seq_hash = vi_seq_hash;
	}
	public int getVc_seq() {
		return vc_seq;
	}
	public void setVc_seq(int vc_seq) {
		this.vc_seq = vc_seq;
	}
	public String getVc_seq_hash() {
		return vc_seq_hash;
	}
	public void setVc_seq_hash(String vc_seq_hash) {
		this.vc_seq_hash = vc_seq_hash;
	}
	public int getVit_seq() {
		return vit_seq;
	}
	public void setVit_seq(int vit_seq) {
		this.vit_seq = vit_seq;
	}
	public int getMain_flag() {
		return main_flag;
	}
	public void setMain_flag(int main_flag) {
		this.main_flag = main_flag;
	}
	public String getSelOrder() {
		return selOrder;
	}
	public void setSelOrder(String selOrder) {
		this.selOrder = selOrder;
	}
	public String getSrh_keyword() {
		return srh_keyword;
	}
	public void setSrh_keyword(String srh_keyword) {
		this.srh_keyword = srh_keyword;
	}
	public String getSrh_keyword_top() {
		return srh_keyword_top;
	}
	public void setSrh_keyword_top(String srh_keyword_top) {
		this.srh_keyword_top = srh_keyword_top;
	}
	public String getApp_empno() {
		return app_empno;
	}
	public void setApp_empno(String app_empno) {
		this.app_empno = app_empno;
	}
	public String getVh_gubun() {
		return vh_gubun;
	}
	public void setVh_gubun(String vh_gubun) {
		this.vh_gubun = vh_gubun;
	}
	public int getVh_seq() {
		return vh_seq;
	}
	public void setVh_seq(int vh_seq) {
		this.vh_seq = vh_seq;
	}
	public String getTarget_vc_seq() {
		return target_vc_seq;
	}
	public void setTarget_vc_seq(String target_vc_seq) {
		this.target_vc_seq = target_vc_seq;
	}
	public int getP_vc_seq() {
		return p_vc_seq;
	}
	public void setP_vc_seq(int p_vc_seq) {
		this.p_vc_seq = p_vc_seq;
	}
	public String getComment_desc() {
		return comment_desc;
	}
	public void setComment_desc(String comment_desc) {
		this.comment_desc = comment_desc;
	}
	public int getVc_status() {
		return vc_status;
	}
	public void setVc_status(int vc_status) {
		this.vc_status = vc_status;
	}
	public String getVi_seq_hash_r() {
		return vi_seq_hash_r;
	}
	public void setVi_seq_hash_r(String vi_seq_hash_r) {
		this.vi_seq_hash_r = vi_seq_hash_r;
	}
	public String getVc_seq_hash_r() {
		return vc_seq_hash_r;
	}
	public void setVc_seq_hash_r(String vc_seq_hash_r) {
		this.vc_seq_hash_r = vc_seq_hash_r;
	}
	public int getReport_gubun() {
		return report_gubun;
	}
	public void setReport_gubun(int report_gubun) {
		this.report_gubun = report_gubun;
	}
	public int getSelReport() {
		return selReport;
	}
	public void setSelReport(int selReport) {
		this.selReport = selReport;
	}
	public String getRe_desc() {
		return re_desc;
	}
	public void setRe_desc(String re_desc) {
		this.re_desc = re_desc;
	}
	public int getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}
	public int getVa_status() {
		return va_status;
	}
	public void setVa_status(int va_status) {
		this.va_status = va_status;
	}
	public String getVa_status_hash() {
		return va_status_hash;
	}
	public void setVa_status_hash(String va_status_hash) {
		this.va_status_hash = va_status_hash;
	}
	public int getTaskVal() {
		return taskVal;
	}
	public void setTaskVal(int taskVal) {
		this.taskVal = taskVal;
	}
	public int getVi_status() {
		return vi_status;
	}
	public void setVi_status(int vi_status) {
		this.vi_status = vi_status;
	}
	public int getRe_gubun() {
		return re_gubun;
	}
	public void setRe_gubun(int re_gubun) {
		this.re_gubun = re_gubun;
	}
	public int getRe_status() {
		return re_status;
	}
	public void setRe_status(int re_status) {
		this.re_status = re_status;
	}
	public String getAct_gubun() {
		return act_gubun;
	}
	public void setAct_gubun(String act_gubun) {
		this.act_gubun = act_gubun;
	}
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	public String getConv_flag() {
		return conv_flag;
	}
	public void setConv_flag(String conv_flag) {
		this.conv_flag = conv_flag;
	}
	public String getOrderVal() {
		return orderVal;
	}
	public void setOrderVal(String orderVal) {
		this.orderVal = orderVal;
	}
	public String getRm_gubun() {
		return rm_gubun;
	}
	public void setRm_gubun(String rm_gubun) {
		this.rm_gubun = rm_gubun;
	}
	public String getAutoplayA() {
		return autoplayA;
	}
	public void setAutoplayA(String autoplayA) {
		this.autoplayA = autoplayA;
	}
	public String getAutoplayO() {
		return autoplayO;
	}
	public void setAutoplayO(String autoplayO) {
		this.autoplayO = autoplayO;
	}
	public String getInQuery() {
		return inQuery;
	}
	public void setInQuery(String inQuery) {
		this.inQuery = inQuery;
	}
	public String[] getMyChkList() {
		return myChkList;
	}
	public void setMyChkList(String[] myChkList) {
		this.myChkList = myChkList;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getSel_f_dept_code() {
		return sel_f_dept_code;
	}
	public void setSel_f_dept_code(String sel_f_dept_code) {
		this.sel_f_dept_code = sel_f_dept_code;
	}
	public String getSel_s_dept_code() {
		return sel_s_dept_code;
	}
	public void setSel_s_dept_code(String sel_s_dept_code) {
		this.sel_s_dept_code = sel_s_dept_code;
	}
	public String getComplete_flag() {
		return complete_flag;
	}
	public void setComplete_flag(String complete_flag) {
		this.complete_flag = complete_flag;
	}
	public String getSrh_date() {
		return srh_date;
	}
	public void setSrh_date(String srh_date) {
		this.srh_date = srh_date;
	}
}
