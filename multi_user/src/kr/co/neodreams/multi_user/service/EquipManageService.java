
package kr.co.neodreams.multi_user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.co.neodreams.multi_user.common.onestop.OneStopLogVO;
import kr.co.neodreams.multi_user.dto.EquipManageDto;

public interface EquipManageService {
    /** 코드취득 */
    public List<EquipManageDto> getCodeList(EquipManageDto equipManageDto) throws Exception;

    /** 모든 코드 취득*/
    public List<EquipManageDto> getAllCodeList(EquipManageDto equipManageDto) throws Exception;

    /** 표준모델 등록 하위코드 가져오기 */
    public Map<String, Object> getSubTreeList(EquipManageDto equipManageDto) throws Exception;

    /** 대여 가능 장비 리스트 취득 */
    public List<EquipManageDto> getEquipManageList(EquipManageDto equipManageDto) throws Exception;

    /** 설비갯수 */
    public Map<String, Object> getEquipAmountInfo(EquipManageDto equipManageDto, String SESS_EMPNO) throws Exception;

    /** 확인증 출력 관련 APP테이블 정보 조회 */
    public EquipManageDto getAppTblInfo(EquipManageDto equipManageDto) throws Exception;

    /** 베스트순 */
    public int getRentNumByModel(EquipManageDto equipManageDto) throws Exception;

    /** 모델상세정보 취득 */
    public String getModelSub(EquipManageDto equipManageDto) throws Exception;

    /** 이미지정보 */
    public String getImageUrl(EquipManageDto equipManageDto) throws Exception;

    /** 장비정보 */
    public EquipManageDto getCodeInfo(EquipManageDto equipManageDto) throws Exception;

    /** 모델기본정보 */
    public EquipManageDto getModelBasicInfo (EquipManageDto equipManageDto) throws Exception;

    /** 모델정보 */
    public List<EquipManageDto> getModelInfo(EquipManageDto equipManageDto) throws Exception;

    /** 대여 가능 장비 리스트 취득 */
    public List<EquipManageDto> getAttachFileInfo(EquipManageDto equipManageDto) throws Exception;

    /** 대여 가능 장비 리스트 취득 */
    public List<EquipManageDto> getBasketInfo(EquipManageDto equipManageDto) throws Exception;

    /** 부분 반납 처리 */
    public String partBanp(HttpServletRequest request) throws Exception;
    
    /** 모델 코드 정보 */
    public Map<String, Object> getModelByCode (EquipManageDto equipManageDto) throws Exception;

    public List<EquipManageDto> getEquipInfo (EquipManageDto equipManageDto) throws Exception;

    /** 장비 신청 죄회 정보*/
    public EquipManageDto getRecViewInfo (EquipManageDto equipManageDto) throws Exception;

    public EquipManageDto getEquipStatus (EquipManageDto equipManageDto) throws Exception;

    public EquipManageDto getEquipAmount (EquipManageDto equipManageDto) throws Exception;

    public Map<String, Object> getEquipModelInfo (EquipManageDto equipManageDto) throws Exception;

    public List<EquipManageDto> getEquipNo (EquipManageDto equipManageDto) throws Exception;

    public List<EquipManageDto> getNotInEquipNo (EquipManageDto equipManageDto) throws Exception;

    /** 상태값 갱신*/
    public void updateStatus (EquipManageDto equipManageDto) throws Exception;

    /** 배정상태 갱신*/
    public void updateEqlst (EquipManageDto equipManageDto) throws Exception;

    /** 신청정보 결재 필드 갱신*/
    public void updateIsSign (EquipManageDto equipManageDto) throws Exception;

    /** 신청수량 갱신*/
    public void updateAmount (EquipManageDto equipManageDto) throws Exception;

    public void updateInsu (EquipManageDto equipManageDto) throws Exception;

    public void updateInUse (EquipManageDto equipManageDto) throws Exception;

    public void updateBanp (EquipManageDto equipManageDto) throws Exception;

    /** 장비대여 신청 갱신*/
    public void updateAppData (EquipManageDto equipManageDto) throws Exception;

    /* 장비 신청 모델 정보  */
    public List<EquipManageDto> getAmountForModel (EquipManageDto equipManageDto) throws Exception;

    /* 배정 정보  */
    public List<EquipManageDto> getAssignedEquipInfo (EquipManageDto equipManageDto) throws Exception;

    /* 배정 정보  */
    public List<EquipManageDto> getEqnm (EquipManageDto equipManageDto) throws Exception;

    /* 배정완료확인 */
    public boolean isAssignEquip (EquipManageDto equipManageDto) throws Exception;

    public boolean signUp(EquipManageDto equipManageDto) throws Exception;

    /*장비 대여 상태 조회*/
    public EquipManageDto getStatusApproval (EquipManageDto equipManageDto) throws Exception;

    /** 신청수량 취득*/
    public EquipManageDto getAmount (EquipManageDto equipManageDto) throws Exception;

    /*배정된설비삭제*/
    public int delRecModel (EquipManageDto equipManageDto) throws Exception;

    /*배정된설비삭제*/
    public int delRecEquip (EquipManageDto equipManageDto) throws Exception;

    /*장바구니삭제*/
    public int delBskno (EquipManageDto equispManageDto) throws Exception;

    /*사용자취소 - admin true(접수현황에서 취소), false(사용자취소)*/
    public Boolean appCancel (String appno, Boolean admin, String sessionEmpno, String sendInfoChk) throws Exception;

    public List<Map<String, String>> getAdminUserMail() throws Exception;

    public int getNextAppno () throws Exception;

    public int getNextSignSeq () throws Exception;

    public int getNextBskno () throws Exception;

    /*대여등록*/
    public void insertAppData (EquipManageDto equipManageDto) throws Exception;

    /*대여등록*/
    public void insertAppModel (EquipManageDto equipManageDto) throws Exception;

    /*대여등록*/
    public void insertAppEquip (EquipManageDto equipManageDto) throws Exception;

    public void insertSignInfo (EquipManageDto equipManageDto) throws Exception;

    public void insertBasketInfo (EquipManageDto equipManageDto) throws Exception;

    /*발송 메일 html 저장*/
    public void updateMailPath (HashMap<String, String> mailInfo) throws Exception;
    
    /*사용자 배정*/
    public void insertEquipUser (EquipManageDto equipManageDto) throws Exception;
    
    public List<EquipManageDto> getEquipUserList (EquipManageDto equipManageDto) throws Exception;
    
    public int updateAppEquipUser (EquipManageDto equipManageDto) throws Exception;
    
    public List<EquipManageDto> getRecInfo (EquipManageDto equipManageDto) throws Exception;
    
    /*장비 배정시 생성된 데이터를 유저내역에 추가*/
    public void insertEQtoEU () throws Exception;
    
    /*모델만 배정되고 장비가 배정되지 않은 접수의 리스트 가져오기*/
    public List<EquipManageDto> selectAMexpEQ () throws Exception;
    
    /*euseq의 최대값 가져오기*/
    public String getMaxEuseq(EquipManageDto equipManageDto) throws Exception;

    /*equipUser 삭제*/
    public int deleteEquipUser(EquipManageDto equipManageDto) throws Exception;

    public void insertMonthAppData (HashMap<String, String> dataMap) throws Exception;
    
    public HashMap<String, String> getCheckAppList () throws Exception;
    
    public List<HashMap<String, String>> getCheckAppMonthList (EquipManageDto equipManageDto) throws Exception;
    
    public HashMap<String, String> getCheckAppMonthInfo (String app_month) throws Exception;
    
    public List<HashMap<String, String>> getCheckAppMonthListXls (EquipManageDto equipManageDto) throws Exception;
    
    public List<HashMap<String, String>> getCheckAppMonthDeviceList (HashMap<String, String> dataMap) throws Exception;
    
    public int getCheckAppMonthListCnt (EquipManageDto equipManageDto) throws Exception;
    
    public void insertCheckAppManage (HashMap<String, String> dataMap) throws Exception;
    
    public HashMap<String, String> getMonthApproval_Info (String app_month) throws Exception;
    
    public void updateMonthApproval_Info (String app_month, String level) throws Exception;
    
    public void insertOneStopLog (List<OneStopLogVO> oneStopLogList) throws Exception;
    
    public int getOneStopLogCnt() throws Exception;
    
    public List<HashMap<String, String>> oneStopLogList (OneStopLogVO oneStopLog) throws Exception;
    
    public int oneStopLogListCnt(OneStopLogVO oneStopLog) throws Exception;
    
    public HashMap<String, String> oneStopLogDetail (OneStopLogVO oneStopLog) throws Exception;

	public void insertFile(EquipManageDto equipFileDto) throws Exception;

	public EquipManageDto selectRentFile(String appno) throws Exception;

	public int AjaxRentFileremove(int rENT_SECURITY_SEQ) throws Exception;
}

