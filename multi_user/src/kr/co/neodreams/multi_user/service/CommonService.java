package kr.co.neodreams.multi_user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import kr.co.neodreams.multi_user.dto.CommonDto;
import kr.co.neodreams.multi_user.dto.RentDto;

public interface CommonService {

    public List<CommonDto> getStatic_idx () throws Exception;

    public void insertNewStatic_idx() throws Exception;

    public void updateStatic_count(String static_idx) throws Exception;

    public void updateVisitedCount(String Rs_num) throws Exception;

    public void insertSpecialCount(String empno) throws Exception;

    public void Proc_mileage_insert(HashMap<Object, Object> proc_map) throws Exception;

    public CommonDto getVod_s1_info (String Rs_num) throws Exception;

    public List<CommonDto> getWin_list_sp (String Rs_num) throws Exception;

    public List<CommonDto> getKepcn_comment_sp (String Rs_num) throws Exception;

    public CommonDto getKepcn_news_file (String Rs_num) throws Exception;

    public String insertMedia_02_ok(CommonDto commonDto) throws Exception;

    public void deleteKepcn_comment(String k_num) throws Exception;

    public void deleteMileage(CommonDto commonDto) throws Exception;

    public void insertMedia_02_write_ok(CommonDto commonDto) throws Exception;

    public List<CommonDto> getNoticeList (CommonDto commonDto) throws Exception;

    public int getNoticeListCnt (CommonDto commonDto) throws Exception;

    public CommonDto getNoticeDetail (String num) throws Exception;

    public void insertPageLog(HashMap<String, String> page_log) throws Exception;

    public void deleteDeptTMP() throws Exception;

    public void insertDeptTMP(String query) throws Exception;

    public void deleteUserTMP() throws Exception;

    public void insertUserTMP(String query) throws Exception;
    
    public void deleteUserNomuTMP() throws Exception;
    
    public void insertUserNomuTMP(String query) throws Exception;

    public void deleteDetailTMP() throws Exception;

    public void insertDetailTMP(String query) throws Exception;

    public void insertDataSetResult(HashMap<String, String> result) throws Exception;

    public String getDataSetLastLog() throws Exception;
    
    public void insertDataSetResultNomu(HashMap<String, String> result) throws Exception;
    
    public String getDataSetLastLogNomu() throws Exception;

    public void insertAllDept_User_Data() throws Exception;
    
    public void insertUser_NomuData() throws Exception;

    public void updateDataSetLastLog() throws Exception;
    
    public void updateDataSetLastLogNomu() throws Exception;

    public HashMap<String, String> getBasicUserInfo(String empno) throws Exception;
    
    public ArrayList<HashMap<String, String>> getAdmInfo(String empno) throws Exception;
    
    public int getServiceAdmInfo(String empno) throws Exception;
    
    public ArrayList<RentDto> getRentalSendSMSTargetList() throws Exception;
    
    public void updateRentalSendSMS(String retCode) throws Exception;
    
    public List<RentDto> getMailApprovalTargetList() throws Exception;
    
    public List<RentDto> getMailRemainDateTargetList(String targetMode) throws Exception;
    
    public void insertMsHistory(RentDto rentDto) throws Exception;
}
