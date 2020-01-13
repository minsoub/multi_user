package kr.co.neodreams.multi_user.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.common.DataMap;
import kr.co.neodreams.multi_user.common.onestop.OneStopLogVO;
import kr.co.neodreams.multi_user.dto.EquipManageDto;

@Component
public class EquipManageDao extends BaseDao {
    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getCodeList (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getCodeList", equipManageDto);
        return resultList;
    }

    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getAllCodeList (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getAllCodeList", equipManageDto);
        return resultList;
    }

    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getSubTree (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getSubTree", equipManageDto);
        return resultList;
    }

    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getEquipManageList (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getEquipManageList", equipManageDto);
        return resultList;
    }

    public int getEquipRentNum (EquipManageDto equipManageDto) throws Exception{
        int result = 0;
        result = getCount("EquipManage#getEquipRentNum", equipManageDto);
        return result;
    }

    public int getCurrAppCnt (EquipManageDto equipManageDto) throws Exception{
        int result = 0;
        result = getCount("EquipManage#getCurrAppCnt", equipManageDto);
        return result;
    }

    public int getBasketCnt (EquipManageDto equipManageDto) throws Exception{
        int result = 0;
        result = getCount("EquipManage#getBasketCnt", equipManageDto);
        return result;
    }

    public int getMyBasketCnt (EquipManageDto equipManageDto) throws Exception{
        int result = 0;
        result = getCount("EquipManage#getMyBasketCnt", equipManageDto);
        return result;
    }

    public int getNextAppno () throws Exception{
        int result = 0;
        result = getCount("EquipManage#getNextAppno", "");
        return result;
    }

    public int getNextSignSeq () throws Exception{
        int result = 0;
        result = getCount("EquipManage#getNextSignSeq", "");
        return result;
    }

    public int getNextBskno () throws Exception{
        int result = 0;
        result = getCount("EquipManage#getNextBskno", "");
        return result;
    }

    /*모델 상세정보*/
    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getModelSub (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getModelSub", equipManageDto);
        return resultList;
    }

    /** 확인증 출력 관련 APP테이블 정보 조회
     *  @param EquipManageDto > appno*/
    public EquipManageDto getAppTblinfo (EquipManageDto equipManageDto) throws Exception{
        EquipManageDto result = new EquipManageDto();
        result = (EquipManageDto) select("EquipManage#getAppTblinfo", equipManageDto);
        return result;
    }

    /*이미지파일 (한개만 출력)*/
    public EquipManageDto getImageUrl (EquipManageDto equipManageDto) throws Exception{
        EquipManageDto result = new EquipManageDto();
        result = (EquipManageDto) select("EquipManage#getImageUrl", equipManageDto);
        return result;
    }

    public EquipManageDto getCodeInfo (EquipManageDto equipManageDto) throws Exception{
        EquipManageDto result = new EquipManageDto ();
        result = (EquipManageDto) select("EquipManage#getCodeInfo", equipManageDto);
        return result;
    }

    public EquipManageDto getModelBasicInfo (EquipManageDto equipManageDto) throws Exception{
        EquipManageDto result = new EquipManageDto ();
        result = (EquipManageDto) select("EquipManage#getModelBasicInfo", equipManageDto);
        return result;
    }

    /*첨부파일*/
    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getModelInfo (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getModelInfo", equipManageDto);
        return resultList;
    }

    /*첨부파일*/
    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getAttachFileInfo (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getAttachFileInfo", equipManageDto);
        return resultList;
    }

    /*장바구니 정보*/
    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getBasketInfo (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getBasketInfo", equipManageDto);
        return resultList;
    }

    public void partBanp (DataMap dataMap) throws Exception{
        update ("EquipManage#partBanp", dataMap);
    }
    
    /*모델 코드 정보*/
    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getModelByCode (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getModelByCode", equipManageDto);
        return resultList;
    }

    public EquipManageDto getRecViewInfo (EquipManageDto equipManageDto) throws Exception{
        EquipManageDto result = new EquipManageDto ();
        result = (EquipManageDto) select("EquipManage#getRecViewInfo", equipManageDto);
        return result;
    }


    public EquipManageDto getEquipStatus (EquipManageDto equipManageDto) throws Exception{
        EquipManageDto result = new EquipManageDto ();
        result = (EquipManageDto) select("EquipManage#getEquipStatus", equipManageDto);
        return result;
    }

    public EquipManageDto getEquipAmount (EquipManageDto equipManageDto) throws Exception{
        EquipManageDto result = new EquipManageDto ();
        result = (EquipManageDto) select("EquipManage#getEquipAmount", equipManageDto);
        return result;
    }

    /*모델 코드 정보*/
    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getEquipModelInfo (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getEquipModelInfo", equipManageDto);
        return resultList;
    }

    /*모델 코드 정보*/
    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getEquipNo (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getEquipNo", equipManageDto);
        return resultList;
    }

    public int updateStatus (EquipManageDto equipManageDto) throws Exception {
        int result = 0;
        result = update("EquipManage#updateStatus", equipManageDto);
        return result;
    }

    public int updateEqlst (EquipManageDto equipManageDto) throws Exception {
        int result = 0;
        result = update("EquipManage#updateEqlst", equipManageDto);
        return result;
    }

    public int updateIsSign (EquipManageDto equipManageDto) throws Exception {
        int result = 0;
        result = update("EquipManage#updateIsSign", equipManageDto);
        return result;
    }

    public int updateAmount (EquipManageDto equipManageDto) throws Exception {
        int result = 0;
        result = update("EquipManage#updateAmount", equipManageDto);
        return result;
    }

    public int updateInsu (EquipManageDto equipManageDto) throws Exception {
        int result = 0;
        result = update("EquipManage#updateInsu", equipManageDto);
        return result;
    }

    public int updateInUse (EquipManageDto equipManageDto) throws Exception {
        int result = 0;
        result = update("EquipManage#updateInUse", equipManageDto);
        return result;
    }

    public int updateBanp (EquipManageDto equipManageDto) throws Exception {
        int result = 0;
        result = update("EquipManage#updateBanp", equipManageDto);
        return result;
    }

    public int updateAppData (EquipManageDto equipManageDto) throws Exception {
        int result = 0;
        result = update("EquipManage#updateAppData", equipManageDto);
        return result;
    }

    /* 장비 신청 모델,수량 정보  */
    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getAmountForModel (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getAmountForModel", equipManageDto);
        return resultList;
    }

    /* 장비 신청 모델 정보  */
    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getAssignedEquipInfo (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getAssignedEquipInfo", equipManageDto);
        return resultList;
    }

    /* 장비 신청 모델 정보  */
    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getEqnm (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getEqnm", equipManageDto);
        return resultList;
    }

    public EquipManageDto getAssignEquip1 (EquipManageDto equipManageDto) throws Exception{
        EquipManageDto result = new EquipManageDto ();
        result = (EquipManageDto) select("EquipManage#getAssignEquip1", equipManageDto);
        return result;
    }

    public int getAssignEquip2 (EquipManageDto equipManageDto) throws Exception{
        int result = 0;
        result = getCount("EquipManage#getAssignEquip2", equipManageDto);
        return result;
    }

    public EquipManageDto getStatusApproval (EquipManageDto equipManageDto) throws Exception{
        EquipManageDto result = new EquipManageDto ();
        result = (EquipManageDto) select("EquipManage#getStatusApproval", equipManageDto);
        return result;
    }

    public int delRecModel (EquipManageDto equipManageDto) throws Exception{
        int result = 0;
        result = delete("EquipManage#delRecModel", equipManageDto);
        return result;
    }

    public int delRecEquip (EquipManageDto equipManageDto) throws Exception{
        int result = 0;
        result = delete("EquipManage#delRecEquip", equipManageDto);
        return result;
    }

    public int delBskno (EquipManageDto equipManageDto) throws Exception{
        int result = 0;
        result = delete("EquipManage#delBskno", equipManageDto);
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, String>> getAdminUserMail() throws Exception {
        return (List<Map<String, String>>) list("EquipManage#getAdminUserMail", "");
    }

    public EquipManageDto getAmount (EquipManageDto equipManageDto) throws Exception{
        EquipManageDto result = new EquipManageDto ();
        result = (EquipManageDto) select("EquipManage#getAmount", equipManageDto);
        return result;
    }

    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getEquipInfo (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getEquipInfo", equipManageDto);
        return resultList;
    }

    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getNotInEquipNo (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getNotInEquipNo", equipManageDto);
        return resultList;
    }

    public void insertAppData (EquipManageDto equipManageDto) throws Exception{
        insert("EquipManage#insertAppData", equipManageDto);
    }

    public void insertAppModel (EquipManageDto equipManageDto) throws Exception{
        insert("EquipManage#insertAppModel", equipManageDto);
    }

    public void insertAppEquip (EquipManageDto equipManageDto) throws Exception{
        insert("EquipManage#insertAppEquip", equipManageDto);
    }

    public void insertSignInfo (EquipManageDto equipManageDto) throws Exception{
        insert("EquipManage#insertSignInfo", equipManageDto);
    }

    public void insertBasketInfo (EquipManageDto equipManageDto) throws Exception{
        insert("EquipManage#insertBasketInfo", equipManageDto);
    }

    public void updateMailPath (HashMap<String, String> mailInfo) throws Exception{
        insert("EquipManage#updateMailPath", mailInfo);
    }
    
    public void insertEquipUser (EquipManageDto equipManageDto) throws Exception{
        insert("EquipManage#insertEquipUser", equipManageDto);
    }
    
    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getEquipUserList (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getEquipUserList", equipManageDto);
        return resultList;
    }
    
    public int updateAppEquipUser (EquipManageDto equipManageDto) throws Exception {
        int result = 0;
        result = update("EquipManage#updateAppEquipUser", equipManageDto);
        return result;
    }
    
    @SuppressWarnings("unchecked")
    public List<EquipManageDto> getRecInfo (EquipManageDto equipManageDto) throws Exception{
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = (List<EquipManageDto>) list("EquipManage#getRecInfo", equipManageDto);
        return resultList;
    }
    
    public void insertEQtoEU () throws Exception{
        insert("EquipManage#insertEQtoEU", "");
    }
    
    @SuppressWarnings("unchecked")
    public List<EquipManageDto> selectAMexpEQ () throws Exception{
    	return (List<EquipManageDto>) list("EquipManage#selectAMexpEQ", "");
    }
    
    public String getMaxEuseq(EquipManageDto equipManageDto) throws Exception{
    	return (String) select("EquipManage#getMaxEuseq", equipManageDto);
    }
    
    public int deleteEquipUser(EquipManageDto equipManageDto) throws Exception {
    	return delete("EquipManage#deleteEquipUser", equipManageDto);
    }
    
    public void insertMonthAppData (HashMap<String, String> dataMap) throws Exception{
    	insert("EquipManage#insertMonthAppData", dataMap);
    }
    
    @SuppressWarnings("unchecked")
    public HashMap<String, String> getCheckAppList () throws Exception{
    	return (HashMap<String, String>) select("EquipManage#getCheckAppList", "");
    }
    
    @SuppressWarnings("unchecked")
    public List<HashMap<String, String>> getCheckAppMonthList (EquipManageDto equipManageDto) throws Exception{
        return (List<HashMap<String, String>>) list("EquipManage#getCheckAppMonthList", equipManageDto);
    }
    
    @SuppressWarnings("unchecked")
    public HashMap<String, String> getCheckAppMonthInfo (String app_month) throws Exception{
    	return (HashMap<String, String>) select("EquipManage#getCheckAppMonthInfo", app_month);
    }
    
    @SuppressWarnings("unchecked")
    public List<HashMap<String, String>> getCheckAppMonthListXls (EquipManageDto equipManageDto) throws Exception{
    	return (List<HashMap<String, String>>) list("EquipManage#getCheckAppMonthListXls", equipManageDto);
    }
    
    @SuppressWarnings("unchecked")
    public List<HashMap<String, String>> getCheckAppMonthDeviceList (HashMap<String, String> dataMap) throws Exception{
    	return (List<HashMap<String, String>>) list("EquipManage#getCheckAppMonthDeviceList", dataMap);
    }
    
    public int getCheckAppMonthListCnt (EquipManageDto equipManageDto) throws Exception {
        return getCount("EquipManage#getCheckAppMonthListCnt", equipManageDto);
    }
    
    public void insertCheckAppManage (HashMap<String, String> dataMap) throws Exception{
    	insert("EquipManage#insertCheckAppManage", dataMap);
    }
    
    @SuppressWarnings("unchecked")
    public HashMap<String, String> getMonthApproval_Info (String app_month)  throws Exception{
    	return (HashMap<String, String>) select("EquipManage#getMonthApproval_Info", app_month);
    }
    
    public void updateMonthApproval_Info (String app_month, String level) throws Exception{
    	HashMap<String, String> dataMap = new HashMap<>();
    	dataMap.put("app_month", app_month);
    	dataMap.put("level", level);
    	dataMap.put("check_result", "이상없음");
    	insert("EquipManage#updateMonthApproval_Info", dataMap);
    }

	public void insertOneStopLog(List<OneStopLogVO> oneStopLogList) {
		insert("EquipManage#insertOneStopLog", oneStopLogList);
	}

	public int getOneStopLogCnt() {
		return getCount("EquipManage#getOneStopLogCnt", null);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> oneStopLogList (OneStopLogVO oneStopLog) throws Exception{
		return (List<HashMap<String, String>>) list("EquipManage#oneStopLogList", oneStopLog);
	}

	public int oneStopLogListCnt(OneStopLogVO oneStopLog) {
		return getCount("EquipManage#oneStopLogListCnt", oneStopLog);
	}

	@SuppressWarnings("unchecked")
	public HashMap<String, String> oneStopLogDetail(OneStopLogVO oneStopLog) {
		return (HashMap<String, String>) select("EquipManage#oneStopLogDetail", oneStopLog);
	}

	public void insertFile(EquipManageDto equipFileDto) {
		insert("EquipManage#insertFile", equipFileDto);
	}

	public EquipManageDto selectRentFile(String appno) throws Exception{
		return (EquipManageDto) select("EquipManage#selectRentFile", appno);
	}

	public int AjaxRentFileremove(int rENT_SECURITY_SEQ) throws Exception{
		return delete("EquipManage#AjaxRentFileremove", rENT_SECURITY_SEQ);
	}
}