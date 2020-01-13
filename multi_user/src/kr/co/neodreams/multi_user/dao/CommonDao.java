package kr.co.neodreams.multi_user.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.CommonDto;
import kr.co.neodreams.multi_user.dto.RentDto;

@Component
public class CommonDao extends BaseDao {

    @SuppressWarnings("unchecked")
    public List<CommonDto> getStatic_idx () throws Exception{
        return (List<CommonDto>) list("Common#getStatic_idx", "");
    }

    public void insertNewStatic_idx() throws Exception{
        insert("Common#insertNewStatic_idx", "");
    }

    public void updateStatic_count(String static_idx) throws Exception{
        update("Common#updateStatic_count", static_idx);
    }

    public void updateVisitedCount(String Rs_num) throws Exception{
        update("Common#updateVisitedCount", Rs_num);
    }

    public void insertSpecialCount(String empno) throws Exception{
        insert("Common#insertSpecialCount", empno);
    }

    public void Proc_mileage_insert(HashMap<Object, Object> proc_map) throws Exception{
        insert("Common#Proc_mileage_insert", proc_map);
    }

    public CommonDto getVod_s1_info (String Rs_num) throws Exception{
        return (CommonDto) select("Common#getVod_s1_info", Rs_num);
    }

    public CommonDto getKepcn_news_file (String Rs_num) throws Exception{
        return (CommonDto) select("Common#getKepcn_news_file", Rs_num);
    }

    @SuppressWarnings("unchecked")
    public List<CommonDto> getWin_list_sp (String Rs_num) throws Exception{
        return (List<CommonDto>) list("Common#getWin_list_sp", Rs_num);
    }

    @SuppressWarnings("unchecked")
    public List<CommonDto> getKepcn_comment_sp (String Rs_num) throws Exception{
        return (List<CommonDto>) list("Common#getKepcn_comment_sp", Rs_num);
    }

    public String insertMedia_02_ok(CommonDto commonDto) throws Exception{
        return (String)insert("Common#insertMedia_02_ok", commonDto);
    }

    public void deleteKepcn_comment(String k_num)  throws Exception{
        delete("Common#deleteKepcn_comment", k_num);
    }

    public void deleteMileage(CommonDto commonDto)  throws Exception{
        delete("Common#deleteMileage", commonDto);
    }

    public void insertMedia_02_write_ok(CommonDto commonDto) throws Exception{
        insert("Common#insertMedia_02_write_ok", commonDto);
    }

    @SuppressWarnings("unchecked")
    public List<CommonDto> getNoticeList (CommonDto commonDto)  throws Exception{
        return (List<CommonDto>) list("Common#getNoticeList", commonDto);
    }

    public int getNoticeListCnt (CommonDto commonDto) throws Exception{
        return getCount("Common#getNoticeListCnt", commonDto);
    }

    public CommonDto getNoticeDetail (String num) throws Exception{
        return (CommonDto) select("Common#getNoticeDetail", num);
    }

    public void insertPageLog(HashMap<String, String> page_log) throws Exception{
        insert("Common#insertPageLog", page_log);
    }

    public void deleteDeptTMP() throws Exception {
        delete("Common#deleteDeptTMP", "");
    }

    public void insertDeptTMP(String query) throws Exception {
        insert("Common#insertDeptTMP", query);
    }

    public void deleteUserTMP() throws Exception {
        delete("Common#deleteUserTMP", "");
    }

    public void insertUserTMP(String query) throws Exception {
        insert("Common#insertUserTMP", query);
    }
    
    public void deleteUserNomuTMP() throws Exception {
    	delete("Common#deleteUserNomuTMP", "");
    }
    
    public void insertUserNomuTMP(String query) throws Exception {
    	insert("Common#insertUserNomuTMP", query);
    }
    
    public void deleteDetailTMP() throws Exception {
        delete("Common#deleteDetailTMP", "");
    }

    public void insertDetailTMP(String query) throws Exception {
        insert("Common#insertDetailTMP", query);
    }
    
    public void insertDataSetResult(HashMap<String, String> result) throws Exception {
        insert("Common#insertDataSetResult", result);
    }

    public String getDataSetLastLog() throws Exception {
        return (String)select("Common#getDataSetLastLog", "");
    }
    
    public void insertDataSetResultNomu(HashMap<String, String> result) throws Exception {
    	insert("Common#insertDataSetResultNomu", result);
    }
    
    public String getDataSetLastLogNomu() throws Exception {
    	return (String)select("Common#getDataSetLastLogNomu", "");
    }

    public void insertAllDept_User_Data() throws Exception {
        insert("Common#insertAllDept_User_Data", "");
    }
    
    public void insertUser_NomuData() throws Exception {
    	insert("Common#insertUser_NomuData", "");
    }

    public void updateDataSetLastLog() throws Exception {
        update("Common#updateDataSetLastLog", "");
    }
    
    public void updateDataSetLastLogNomu() throws Exception {
    	update("Common#updateDataSetLastLogNomu", "");
    }

    @SuppressWarnings("unchecked")
    public HashMap<String, String> getBasicUserInfo(String empno) throws Exception {
        return (HashMap<String, String>) select("Common#getBasicUserInfo", empno);
    }
    
    @SuppressWarnings("unchecked")
    public ArrayList<HashMap<String, String>> getAdmInfo(String empno) throws Exception {
    	return (ArrayList<HashMap<String, String>>) list ("Common#getAdmInfo", empno);
    }

	public int getServiceAdmInfo(String empno) {
		return getCount("Common#getServiceAdmInfo", empno);
	}
    
    @SuppressWarnings("unchecked")
    public ArrayList<RentDto> getRentalSendSMSTargetList() throws Exception {
    	return (ArrayList<RentDto>) list("Common#getRentalSendSMSTargetList", "");
    } 
    
    public void updateRentalSendSMS(String retCode) throws Exception {
    	update("Common#updateRentalSendSMS", retCode);
    }
    
    @SuppressWarnings("unchecked")
    public List<RentDto> getMailApprovalTargetList() throws Exception {
    	return (ArrayList<RentDto>) list("Common#getMailApprovalTargetList", "");
    }
    
    @SuppressWarnings("unchecked")
    public List<RentDto> getMailRemainDateTargetList(String targetMode) throws Exception {
        return (List<RentDto>) list("Common#getMailRemainDateTargetList", targetMode);
    }
    
    public void insertMsHistory(RentDto rentDto) throws Exception {
        insert("Common#insertMsHistory", rentDto);
    }
}

