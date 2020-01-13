package kr.co.neodreams.multi_user.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.neodreams.multi_user.dto.BroadcastDto;
import kr.co.neodreams.multi_user.dto.RentDto;



public interface RentService {

	public List<RentDto> appList(RentDto rentDto) throws Exception;
	
	public int getAppListCnt(RentDto rentDto) throws Exception;
	
	public List<RentDto> codeList(RentDto rentDto) throws Exception;
	
	public List<RentDto>  loadAppModel(RentDto rentDto) throws Exception;
	
	public List<RentDto>  loadSign(RentDto rentDto) throws Exception;
	
	public RentDto getModelInfo(RentDto rentDto) throws Exception;
	
	public List<RentDto> getModelInfoArr(RentDto rentDto) throws Exception;
	
	public List<RentDto> getModelInfoByAppno(RentDto rentDto) throws Exception;
	
	public RentDto getCodeInfo(RentDto rentDto) throws Exception;
	
	public List<RentDto> basketList(RentDto rentDto) throws Exception;
	
	public void deleteBasket(RentDto rentDto) throws Exception;
	
	public RentDto getAppStatusInfo(RentDto rentDto) throws Exception;
	
	public void updAppCancel(RentDto rentDto) throws Exception;
	
	public List<RentDto> getSignInfo(RentDto rentDto) throws Exception;
	
	public void delAppEquip(RentDto rentDto) throws Exception;
	
	public List<RentDto> code(RentDto rentDto) throws Exception;
	
	public int getCodeCnt(RentDto rentDto) throws Exception;
	
	public String getMaxGbcd(RentDto rentDto) throws Exception;
	
	public void insCode(RentDto rentDto) throws Exception;
	
	public void updCode(RentDto rentDto) throws Exception;
	
	public List<RentDto> getSubCode(RentDto rentDto) throws Exception;
	
	public List<RentDto> adminList(RentDto rentDto) throws Exception;
	
	public void deleteAdmin(RentDto rentDto) throws Exception;
	
	public void updateAdmin(RentDto rentDto) throws Exception;
	
	public int empidChk(RentDto rentDto) throws Exception;
	
	public void insertAdmin(RentDto rentDto) throws Exception;
	
	public List<RentDto> searchAdmin(RentDto rentDto) throws Exception;
	
	public List<RentDto> stanModelList(RentDto rentDto) throws Exception;
	
	public int getStanModelCnt(RentDto rentDto) throws Exception;
	
	public List<RentDto> getModelSub(RentDto rentDto) throws Exception;
	
	public List<RentDto> equipList(RentDto rentDto) throws Exception;
	
	public int getEquipCnt(RentDto rentDto) throws Exception;
	
	public List<RentDto> discardList(RentDto rentDto) throws Exception;
	
	public int getDiscardCnt(RentDto rentDto) throws Exception;
	
	public List<RentDto> companyList(RentDto rentDto) throws Exception;
	
	public List<RentDto> getModelList(RentDto rentDto) throws Exception;
	
	public RentDto equipInfo(RentDto rentDto) throws Exception;
	
	public List<RentDto> getAdminChk(RentDto rentDto) throws Exception;
	
	public RentDto getEQLSTChk(RentDto rentDto) throws Exception;
	
	public void updEquip(RentDto rentDto) throws Exception;
	
	public String getNewEqnm(RentDto rentDto) throws Exception;
	
	public int getMaxEqno(RentDto rentDto) throws Exception;
	
	public void insEquip(RentDto rentDto) throws Exception;
	
	public int getMaxFileNo() throws Exception;
	
	public void insFile(RentDto rentDto) throws Exception;
	
	public List<RentDto> getFileList(RentDto rentDto) throws Exception;
	
	public void delFile(RentDto rentDto) throws Exception;
	
	public List<RentDto> recList(RentDto rentDto) throws Exception;
	
	public int getRecListCnt(RentDto rentDto) throws Exception;
	
	public void updModel(RentDto rentDto) throws Exception;
	
	public void updModelSub(RentDto rentDto) throws Exception;
	
	public List<RentDto> codeChkOfModelSub(RentDto rentDto) throws Exception;
	
	public List<RentDto> codeChkOfCode(RentDto rentDto) throws Exception;
	
	public void insModel(RentDto rentDto) throws Exception;
	
	public void insModelSub(RentDto rentDto) throws Exception;
	
	public void delModelSub(RentDto rentDto) throws Exception;
	
	public int maxMdseqModel() throws Exception;
	
	public int getUseEquipCnt(RentDto rentDto) throws Exception;
	
	public List<RentDto> msHistory(RentDto rentDto) throws Exception;
	
	public List<RentDto> searchMember(RentDto rentDto) throws Exception;
	
	public List<RentDto> equipRentPop(RentDto rentDto) throws Exception;
	
	public int getEquipRentPopCnt(RentDto rentDto) throws Exception;
	
	public List<RentDto> equipRentStatusNo1(RentDto rentDto) throws Exception;
	
	public List<RentDto> equipRentStatusNo2(RentDto rentDto) throws Exception;
	
	public List<RentDto> monthlyRentStatusElement(RentDto rentDto) throws Exception;
	
	public List<RentDto> monthlyRentStatusData(RentDto rentDto) throws Exception;
	
	public RentDto mailView(RentDto rentDto) throws Exception;
	
	public RentDto signInfo(RentDto rentDto) throws Exception;
	
	public RentDto getSignStatusInfo(RentDto rentDto) throws Exception;
	
	public void updSign(RentDto rentDto) throws Exception;
	
	public void updStatus(RentDto rentDto) throws Exception;
	
	public List<RentDto> assignedApp(RentDto rentDto) throws Exception;
	
	public List<RentDto> allocList(RentDto rentDto) throws Exception;
	
	public void insAppEquip(RentDto rentDto) throws Exception;
	
	public int getEquipRentNum(RentDto rentDto) throws Exception;
	
	public int getCurrentAppSumAmount(RentDto rentDto) throws Exception;
	
	public int getBasketSumAmount(RentDto rentDto) throws Exception;
	
	public void updAppModel(RentDto rentDto) throws Exception;
	
	public RentDto getEqnoAppEquipInfo(RentDto rentDto) throws Exception;
	
	public List<RentDto> getReservedEquipInfo(RentDto rentDto) throws Exception;
	
	public List<RentDto> getEquipInfoForExt(RentDto rentDto) throws Exception;
	
	public void updAppDate (RentDto rentDto) throws Exception;
	
	public RentDto getAppInfo(RentDto rentDto) throws Exception;
	
	public RentDto getAppModelInfo(RentDto rentDto) throws Exception;
	
	public int getAppAmount(RentDto rentDto) throws Exception;
	
	public void updAppInfo(RentDto rentDto) throws Exception;
	
	public List<RentDto> smsToUser(RentDto rentDto) throws Exception;
	
	public List<RentDto> getAppEquip(RentDto rentDto) throws Exception;
	
	public void updAppEquip(RentDto rentDto) throws Exception;
	
	public boolean isAssignEquip(String appno) throws Exception;
	
	public List<RentDto> recListPreview(RentDto rentDto) throws Exception;
	
	public void delAppEquipUser(RentDto rentDto) throws Exception;
	
	public void updAppEquipUser(RentDto rentDto) throws Exception;
	
	public void insAppModel(RentDto rentDto) throws Exception;
	
	public void delAppModel(RentDto rentDto) throws Exception;
	
	public RentDto getEquipUserHistory(RentDto rentDto) throws Exception;
	
	public void insEquipUserHistory(RentDto rentDto) throws Exception;
	
	public void updEquipUserHistory(RentDto rentDto) throws Exception;
	
	/** 부분 반납 처리 */
    public void partBanp(RentDto rentDto) throws Exception;
    
	public String getMaxUhseq(RentDto rentDto) throws Exception;
	
	public RentDto getMailViewChgEu(RentDto rentDto) throws Exception;
	
	public RentDto getMailViewChgEm(RentDto rentDto) throws Exception;
	
	public List<RentDto> getAppListView(RentDto rentDto) throws Exception;
	
	public RentDto getMailViewInfo(RentDto rentDto) throws Exception;
	
	public RentDto getEquipUser(RentDto rentDto) throws Exception;
	
	public List<RentDto> putJojikDep0List() throws Exception;
	
	public List<RentDto> getDept1List() throws Exception;
	
	public List<RentDto> getDept2List() throws Exception;
	
	public List<RentDto> getDept1UserListByCode() throws Exception;
	
	public List<RentDto> getDept2UserListByCode() throws Exception;
	
	public List<RentDto> getDept3List() throws Exception;
	
	public List<RentDto> getDept4List() throws Exception;
	
	public List<RentDto> getDept5List() throws Exception;
	
	public List<RentDto> getDept6List() throws Exception;

    public List<RentDto> getDept3ListByCode(RentDto rentDto) throws Exception;

    public List<RentDto> getDept4ListByCode(RentDto rentDto) throws Exception;

    public List<RentDto> getDept5ListByCode(RentDto rentDto) throws Exception;

    public List<RentDto> getDept6ListByCode(RentDto rentDto) throws Exception;

    public List<RentDto> getDept3UserListByCode(RentDto rentDto) throws Exception;

    public List<RentDto> getDept4UserListByCode(RentDto rentDto) throws Exception;

    public List<RentDto> getDept5UserListByCode(RentDto rentDto) throws Exception;

    public List<RentDto> getDept6UserListByCode(RentDto rentDto) throws Exception;

	public List<RentDto> getDeptEmpList(RentDto rentDto) throws Exception;
	
	public List<RentDto> getSearchUser(RentDto rentDto) throws Exception;
	
	public void insertMikepSign(RentDto rentDto) throws Exception;
	
	public HashMap<String, String> getMInsuBanpStat(HashMap<String, String> mInsuBanpStatParamMap) throws Exception;
	
	public List<HashMap<String, Object>> getRentListCnt(RentDto rentDto) throws Exception;

	/*대여현황 사용자 정보*/
	public List<RentDto> rentUserList(RentDto rentDto) throws Exception;

	public int rentUserListCnt(RentDto rentDto) throws Exception;

	/*장비가 배정되있을경우 등록상태, 관리상태 변경 불가*/
	public List<RentDto> rentCheck(String eqno) throws Exception;
	
}
