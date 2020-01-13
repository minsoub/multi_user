package kr.co.neodreams.multi_user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.base.service.BaseService;
import kr.co.neodreams.multi_user.dao.CommonDao;
import kr.co.neodreams.multi_user.dto.CommonDto;
import kr.co.neodreams.multi_user.dto.RentDto;

@Service
public class CommonServiceImpl extends BaseService implements CommonService{

    @Autowired
    CommonDao commonDao;

    @Override
    public List<CommonDto> getStatic_idx() throws Exception {
        return commonDao.getStatic_idx();
    }

    @Override
    public void insertNewStatic_idx() throws Exception {
        commonDao.insertNewStatic_idx();
    }

    @Override
    public void updateStatic_count(String static_idx) throws Exception {
        commonDao.updateStatic_count(static_idx);
    }

    @Override
    public void updateVisitedCount(String Rs_num) throws Exception {
        commonDao.updateVisitedCount(Rs_num);
    }

    @Override
    public void insertSpecialCount(String empno) throws Exception {
        commonDao.insertSpecialCount(empno);
    }

    @Override
    public void Proc_mileage_insert(HashMap<Object, Object> proc_map) throws Exception {
        commonDao.Proc_mileage_insert(proc_map);
    }

    @Override
    public CommonDto getVod_s1_info (String Rs_num) throws Exception {
        return commonDao.getVod_s1_info(Rs_num);
    }

    @Override
    public List<CommonDto> getWin_list_sp (String Rs_num)  throws Exception {
        return commonDao.getWin_list_sp(Rs_num);
    }

    @Override
    public List<CommonDto> getKepcn_comment_sp (String Rs_num)  throws Exception {
        return commonDao.getKepcn_comment_sp(Rs_num);
    }

    @Override
    public CommonDto getKepcn_news_file (String Rs_num) throws Exception {
        return commonDao.getKepcn_news_file(Rs_num);
    }

    @Override
    public String insertMedia_02_ok(CommonDto commonDto) throws Exception {
        return commonDao.insertMedia_02_ok(commonDto);
    }

    @Override
    public void deleteKepcn_comment(String k_num) throws Exception {
        commonDao.deleteKepcn_comment(k_num);
    }

    @Override
    public void deleteMileage(CommonDto commonDto) throws Exception {
        commonDao.deleteMileage(commonDto);
    }

    @Override
    public void insertMedia_02_write_ok(CommonDto commonDto) throws Exception {
        commonDao.insertMedia_02_write_ok(commonDto);
    }

    @Override
    public List<CommonDto> getNoticeList (CommonDto commonDto) throws Exception {
        // TODO Auto-generated method stub
        return commonDao.getNoticeList(commonDto);
    }

    @Override
    public int getNoticeListCnt(CommonDto commonDto) throws Exception {
        // TODO Auto-generated method stub
        return commonDao.getNoticeListCnt(commonDto);
    }

    @Override
    public CommonDto getNoticeDetail (String num) throws Exception {
        return commonDao.getNoticeDetail(num);
    }

    @Override
    public void insertPageLog(HashMap<String, String> page_log) throws Exception {
        commonDao.insertPageLog(page_log);
    }

    @Override
    public void deleteDeptTMP() throws Exception {
        commonDao.deleteDeptTMP();
    }

    @Override
    public void insertDeptTMP(String query) throws Exception {
        commonDao.insertDeptTMP(query);
    }

    @Override
    public void deleteUserTMP() throws Exception {
        commonDao.deleteUserTMP();
    }

    @Override
    public void insertUserTMP(String query) throws Exception {
        commonDao.insertUserTMP(query);
    }
    
    @Override
    public void deleteUserNomuTMP() throws Exception {
    	commonDao.deleteUserNomuTMP();
    }
    
    @Override
    public void insertUserNomuTMP(String query) throws Exception {
    	commonDao.insertUserNomuTMP(query);
    }

    @Override
    public void deleteDetailTMP() throws Exception {
        commonDao.deleteDetailTMP();
    }

    @Override
    public void insertDetailTMP(String query) throws Exception {
        commonDao.insertDetailTMP(query);
    }

    @Override
    public void insertDataSetResult(HashMap<String, String> result) throws Exception {
        commonDao.insertDataSetResult(result);
    }

    @Override
    public String getDataSetLastLog() throws Exception {
        return (String) commonDao.getDataSetLastLog();
    }
    
    @Override
    public void insertDataSetResultNomu(HashMap<String, String> result) throws Exception {
    	commonDao.insertDataSetResultNomu(result);
    }
    
    @Override
    public String getDataSetLastLogNomu() throws Exception {
    	return (String) commonDao.getDataSetLastLogNomu();
    }

    @Override
    public void insertAllDept_User_Data() throws Exception {
        commonDao.insertAllDept_User_Data();
    }
    
    @Override
    public void insertUser_NomuData() throws Exception {
    	commonDao.insertUser_NomuData();
    }

    @Override
    public void updateDataSetLastLog() throws Exception {
        commonDao.updateDataSetLastLog();
    }
    
    @Override
    public void updateDataSetLastLogNomu() throws Exception {
    	commonDao.updateDataSetLastLogNomu();
    }

    @Override
    public HashMap<String, String> getBasicUserInfo(String empno) throws Exception {
        return (HashMap<String, String>) commonDao.getBasicUserInfo(empno);
    }
    
    @Override
    public ArrayList<HashMap<String, String>> getAdmInfo(String empno) throws Exception {
    	return (ArrayList<HashMap<String, String>>) commonDao.getAdmInfo(empno);
    }
    
    @Override
    public int getServiceAdmInfo(String empno) throws Exception {
    	return (int) commonDao.getServiceAdmInfo(empno);
    }

    @Override
    public ArrayList<RentDto> getRentalSendSMSTargetList() throws Exception {
        return (ArrayList<RentDto>) commonDao.getRentalSendSMSTargetList();
    }

    @Override
    public void updateRentalSendSMS(String retCode) throws Exception {
        commonDao.updateRentalSendSMS(retCode);
    }

	@Override
	public List<RentDto> getMailApprovalTargetList() throws Exception {
		return commonDao.getMailApprovalTargetList();
	}

	@Override
	public List<RentDto> getMailRemainDateTargetList(String targetMode) throws Exception {
		return commonDao.getMailRemainDateTargetList(targetMode);
	}

    @Override
    public void insertMsHistory(RentDto rentDto) throws Exception {
        commonDao.insertMsHistory(rentDto);
    }
    
}

