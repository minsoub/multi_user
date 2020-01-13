package kr.co.neodreams.multi_user.dao;

import java.util.HashMap;
import java.util.List;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.common.DataMap;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.dto.RentDto;

import org.springframework.stereotype.Component;

@Component
public class RentDao extends BaseDao{
	
	/*장비대여 > 마이페이지 > 대여리스트*/
	@SuppressWarnings("unchecked")
	public List<RentDto> appList(RentDto rentDto) throws Exception{
		return (List<RentDto>)list("Rent#appList", rentDto);
	}
	
	/*장비대여 > 마이페이지 > 대여리스트 총 자료수*/
	public int getAppListCnt(RentDto rentDto) throws Exception{
		return (int)select("Rent#getAppListCnt", rentDto);
	}
	
	/*장비대여 > 마이페이지 > 장비셀렉트*/
	@SuppressWarnings("unchecked")
	public List<RentDto> codeList(RentDto rentDto) throws Exception{
		return (List<RentDto>)list("Rent#codeList", rentDto);
	}

	/*장비 모델 정보*/
	@SuppressWarnings("unchecked")
	public List<RentDto> loadAppModel(RentDto rentDto) throws Exception{
		return (List<RentDto>)list("Rent#loadAppModel", rentDto);
	}
	
	/*대여 결제 정보*/
	@SuppressWarnings("unchecked")
	public List<RentDto> loadSign(RentDto rentDto) throws Exception{
		return (List<RentDto>)list("Rent#loadSign", rentDto);
	}

	/*모델 상세 정보*/
	@SuppressWarnings("unchecked")
	public RentDto getModelInfo(RentDto rentDto) throws Exception{
		return (RentDto)select("Rent#getModelInfo", rentDto);
	}
	
	/*모델 상세 정보(배열 처리)*/
	@SuppressWarnings("unchecked")
	public List<RentDto> getModelInfoArr(RentDto rentDto) throws Exception{
		return (List<RentDto>)list("Rent#getModelInfo", rentDto);
	}
	
	/*모델 상세 정보 (APPNO 이용)*/
	@SuppressWarnings("unchecked")
	public List<RentDto> getModelInfoByAppno(RentDto rentDto) throws Exception{
		return (List<RentDto>)list("Rent#getModelInfoByAppno", rentDto);
	}
	
	/*모델 상세 정보*/
	@SuppressWarnings("unchecked")
	public RentDto getCodeInfo(RentDto rentDto) throws Exception{
		return (RentDto)select("Rent#getCodeInfo", rentDto);
	}
	
	/*장비대여 > 장바구니 > 리스트*/
	@SuppressWarnings("unchecked")
	public List<RentDto> basketList(RentDto rentDto) throws Exception{
		return (List<RentDto>)list("Rent#basketList", rentDto);
	}
	
	/*장비대여 > 장바구니 > 선택삭제 또는 삭제*/
	public void deleteBasket(RentDto rentDto) throws Exception{
		delete("Rent#deleteBasket", rentDto);
	}
	
	/*대여상태 정보 가져오기*/
	@SuppressWarnings("unchecked")
	public RentDto getAppStatusInfo(RentDto rentDto) throws Exception{
		return (RentDto)select("Rent#getAppStatusInfo", rentDto);
	}
	
	/*대여상태  취소변경*/
	public void updAppCancel(RentDto rentDto) throws Exception{
		update("Rent#updAppCancel", rentDto);
	}
	
	/*대여 결제정보 확인*/
	@SuppressWarnings("unchecked")
	public List<RentDto> getSignInfo(RentDto rentDto) throws Exception{
		return (List<RentDto>)list("Rent#getSignInfo", rentDto);
	}
	
	/*배정된 장비 삭제*/
	public void delAppEquip(RentDto rentDto) throws Exception{
		delete("Rent#delAppEquip", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 코드관리 > 리스트*/
	@SuppressWarnings("unchecked")
	public List<RentDto> code(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#code", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 코드관리 > 코드구분 총 자료수*/
	public int getCodeCnt(RentDto rentDto) throws Exception{
		return (int)select("Rent#getCodeCnt", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 코드관리 > 분류코드 최대값 구하기*/
	public String getMaxGbcd(RentDto rentDto) throws Exception{
		return (String)select("Rent#getMaxGbcd", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 코드관리 > 코드등록*/
	public void insCode(RentDto rentDto) throws Exception{
		insert("Rent#insCode", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 코드관리 > 코드수정*/
	public void updCode(RentDto rentDto) throws Exception{
		update("Rent#updCode", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 코드관리 > 하위코드 가져오기*/
	@SuppressWarnings("unchecked")
	public List<RentDto> getSubCode(RentDto rentDto) throws Exception{
		return (List<RentDto>)list("Rent#getSubCode", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 관리자관리 > 리스트*/
	@SuppressWarnings("unchecked")
	public List<RentDto> adminList(RentDto rentDto) throws Exception{
		return (List<RentDto>)list("Rent#adminList", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 관리자관리 > 관리자삭제*/
	public void deleteAdmin(RentDto rentDto) throws Exception{
		delete("Rent#deleteAdmin", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 관리자관리 > 관리자변경*/
	public void updateAdmin(RentDto rentDto) throws Exception{
		update("Rent#updateAdmin", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 관리자관리 > 관리자등록여부 확인*/
	public int empidChk(RentDto rentDto) throws Exception{
		return (int)select("Rent#empidChk", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 관리자관리 > 관리자등록*/
	public void insertAdmin(RentDto rentDto) throws Exception{
		insert("Rent#insertAdmin", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 관리자관리 > 직원검색*/
	@SuppressWarnings("unchecked")
	public List<RentDto> searchAdmin(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#searchAdmin", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 모델관리 > 리스트*/
	@SuppressWarnings("unchecked")
	public List<RentDto> stanModelList(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#stanModelList", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 모델관리 > 리스트 총자료수*/
	public int getStanModelCnt(RentDto rentDto) throws Exception{
		return (int) select("Rent#getStanModelCnt", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 모델관리 > 모델서브정보*/
	@SuppressWarnings("unchecked")
	public List<RentDto> getModelSub(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#getModelSub", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 장비현황 > 리스트*/ 
	@SuppressWarnings("unchecked")
	public List<RentDto> equipList(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#equipList", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 장비현황 > 리스트 총자료수*/
	public int getEquipCnt(RentDto rentDto) throws Exception{
		return (int) select("Rent#getEquipCnt", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 장비현황 > 폐기처분*/ 
	@SuppressWarnings("unchecked")
	public List<RentDto> discardList(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#discardList", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 장비현황 > 폐기처분 > 리스트 총자료수*/
	public int getDiscardCnt(RentDto rentDto) throws Exception{
		return (int) select("Rent#getDiscardCnt", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 장비현황 > 제조사정보*/ 
	@SuppressWarnings("unchecked")
	public List<RentDto> companyList(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#companyList", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 장비현황 > 모델정보*/
	@SuppressWarnings("unchecked")
	public List<RentDto> getModelList(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#getModelList", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 장비현황 > 장비현황상세*/
	public RentDto equipInfo(RentDto rentDto) throws Exception{
		return (RentDto) select("Rent#equipInfo", rentDto);
	}
	
	/*공통 > 관리자 체크*/
	@SuppressWarnings("unchecked")
	public List<RentDto> getAdminChk(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#getAdminChk", rentDto);
	}
	
	/*대여상태 체크*/
	public RentDto getEQLSTChk(RentDto rentDto) throws Exception{
		return (RentDto) select("Rent#getEQLSTChk", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 장비현황 > 장비수정로직*/
	public void updEquip(RentDto rentDto) throws Exception{
		update("Rent#updEquip", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 장비현황 > 장비등록 > 장비의 설비관리번호 생성*/
	public String getNewEqnm(RentDto rentDto) throws Exception{
		return (String) select("Rent#getNewEqnm", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 장비현황 > 장비등록 > 장비번호 최대값*/
	public int getMaxEqno(RentDto rentDto) throws Exception{
		return (int) select("Rent#getMaxEqno", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 장비현황 > 장비등록 > 데이터 등록*/
	public void insEquip(RentDto rentDto) throws Exception{
		insert("Rent#insEquip", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 장비현황 > 장비등록 > 파일번호 최대값*/
	public int getMaxFileNo() throws Exception{
		return (int) select("Rent#getMaxFileNo", "");
	}
	
	/*장비대여 > 관리메뉴 > 장비현황 > 장비등록 > 파일정보등록*/
	public void insFile(RentDto rentDto) throws Exception{
		insert("Rent#insFile", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 장비현황 > 장비등록 > 파일정보 불러오기*/
	@SuppressWarnings("unchecked")
	public List<RentDto> getFileList(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#getFileList", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 장비현황 > 장비등록 > 파일정보삭제*/
	public void delFile(RentDto rentDto) throws Exception{
		insert("Rent#delFile", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 접수현황 > 리스트*/
	@SuppressWarnings("unchecked")
	public List<RentDto> recList(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#recList", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 접수현황 > 리스트 총자료수*/
	public int getRecListCnt(RentDto rentDto) throws Exception{
		return (int) select("Rent#getRecListCnt", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 모델관리 > 모델정보수정*/
	public void updModel(RentDto rentDto) throws Exception{
		update("Rent#updModel", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 모델관리 > 모델서브정보수정*/
	public void updModelSub(RentDto rentDto) throws Exception{
		update("Rent#updModelSub", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 모델관리 > 모델서브코드(코드 확인용)*/
	@SuppressWarnings("unchecked")
	public List<RentDto> codeChkOfModelSub(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#codeChkOfModelSub", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 모델관리 > 코드테이블 코드(코드 확인용)*/
	@SuppressWarnings("unchecked")
	public List<RentDto> codeChkOfCode(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#codeChkOfCode", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 모델관리 > 모델등록*/
	public void insModel(RentDto rentDto) throws Exception{
		insert("Rent#insModel", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 모델관리 > 모델서브등록*/
	public void insModelSub(RentDto rentDto) throws Exception{
		insert("Rent#insModelSub", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 모델관리 > 모델서브삭제*/
	public void delModelSub(RentDto rentDto) throws Exception{
		delete("Rent#delModelSub", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 모델관리 > 모델  max mdseq*/
	public int maxMdseqModel() throws Exception{
		return (int) select("Rent#maxMdseqModel", "");
	}
	
	/*장비대여 > 관리메뉴 > 설정관리 > 모델관리 > 사용중인 장비 확인*/
	public int getUseEquipCnt(RentDto rentDto) throws Exception{
		return (int) select("Rent#getUseEquipCnt", rentDto);
	}
	
	/*장비대여 > 관리메뉴 > 접수현황 > 리스트 > sms/mail 내역*/
	@SuppressWarnings("unchecked")
	public List<RentDto> msHistory(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#msHistory", rentDto);
	}
	
	/*장비대여 > 공통 > 직원검색*/
	@SuppressWarnings("unchecked")
	public List<RentDto> searchMember(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#searchMember", rentDto);
	}
	
	/*장비대여 > 설비현황 > 대여신청 > 현재 대여 리스트 알림팝업*/
	@SuppressWarnings("unchecked")
	public List<RentDto> equipRentPop(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#equipRentPop", rentDto);
	}
	
	/*장비대여 > 설비현황 > 대여신청 > 현재 대여 리스트 알림팝업 > 리스트 총자료수*/
	public int getEquipRentPopCnt(RentDto rentDto) throws Exception{
		return (int) select("Rent#getEquipRentPopCnt", rentDto);
	}
	
	/*장비대여 > 대여현황 > 도표1 > 장비수량 체크*/
	@SuppressWarnings("unchecked")
	public List<RentDto> equipRentStatusNo1(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#equipRentStatusNo1", rentDto);
	}
	
	/*장비대여 > 대여현황 > 도표2 > 장비수량 체크*/
	@SuppressWarnings("unchecked")
	public List<RentDto> equipRentStatusNo2(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#equipRentStatusNo2", rentDto);
	}
	
	/*장비대여 > 대여현황 > 월간대여현황 > 테이블 항목 가져오기*/
	@SuppressWarnings("unchecked")
	public List<RentDto> monthlyRentStatusElement(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#monthlyRentStatusElement", rentDto);
	}
	
	/*장비대여 > 대여현황 > 월간대여현황 > 데이터 가져오기*/
	@SuppressWarnings("unchecked")
	public List<RentDto> monthlyRentStatusData(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#monthlyRentStatusData", rentDto);
	}
	
	/*공통 메일에 보여질 정보 가져오기*/
	public RentDto mailView(RentDto rentDto) throws Exception{
		return (RentDto) select("Rent#mailView", rentDto);
	}
	
	/*승인처리전 승인기본정보 가져오기*/
	public RentDto signInfo(RentDto rentDto) throws Exception{
		return (RentDto) select("Rent#signInfo", rentDto);
	}
	
	/*승인기본정보에 다른 현 승인상태 가져오기*/
	public RentDto getSignStatusInfo(RentDto rentDto) throws Exception{
		return (RentDto) select("Rent#getSignStatusInfo", rentDto);
	}
		
	/*결재상태 변경 업데이트 REG_SIGN = Y*/
	public void updStatus(RentDto rentDto) throws Exception{
		update("Rent#updStatus", rentDto);
	}
	
	/*결재상태 변경 업데이트 REG_SIGN = Y*/
	public void updSign(RentDto rentDto) throws Exception{
		update("Rent#updSign", rentDto);
	}
	
	/*승인후 자동배정이전 제외시킬 배정된 리스트*/
	@SuppressWarnings("unchecked")
	public List<RentDto> assignedApp(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#assignedApp", rentDto);
	}
	
	/*승인후 자동배정이전 배정가능 리스트*/
	@SuppressWarnings("unchecked")
	public List<RentDto> allocList(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#allocList", rentDto);
	}

	/*장비승인처리*/
	public void insAppEquip(RentDto rentDto) throws Exception{
		insert("Rent#insAppEquip", rentDto);
	}
	
	/*총장비갯수*/
	public int getEquipRentNum(RentDto rentDto) throws Exception{
		return (int) select("Rent#getEquipRentNum", rentDto);
	}
	
	/*신청정보개수*/
	public int getCurrentAppSumAmount(RentDto rentDto) throws Exception{
		return Integer.parseInt(StringUtil.isNull((String) select("Rent#getCurrentAppSumAmount", rentDto),"0"));
	}
	
	/*장바구니개수*/
	public int getBasketSumAmount(RentDto rentDto) throws Exception{
		return Integer.parseInt(StringUtil.isNull((String) select("Rent#getBasketSumAmount", rentDto),"0"));
	}
	
	/*모델 수량 업데이트*/
	public void updAppModel(RentDto rentDto) throws Exception{
		update("Rent#updAppModel", rentDto);
	}
	
	/*기간산정 장비정보 가져오기*/
	public RentDto getEqnoAppEquipInfo(RentDto rentDto) throws Exception{
		return (RentDto) select("Rent#getEqnoAppEquipInfo", rentDto);
	}
	
	/*접수중인 장비정보 가져오기*/
	@SuppressWarnings("unchecked")
	public List<RentDto> getReservedEquipInfo(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#getReservedEquipInfo", rentDto);
	}
	
	/*연장예약가능 장비정보 가져오기*/
	@SuppressWarnings("unchecked")
	public List<RentDto> getEquipInfoForExt(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#getEquipInfoForExt", rentDto);
	}
	
	/*대여기간 업데이트*/
	public void updAppDate(RentDto rentDto) throws Exception{
		update("Rent#updAppDate", rentDto);
	}
	
	/*승인전 데이터 불러오기*/
	public RentDto getAppInfo(RentDto rentDto) throws Exception{
		return (RentDto) select("Rent#getAppInfo", rentDto);
	}
	
	/*수량체크 전 수량 데이터 불러오기*/
	public RentDto getAppModelInfo(RentDto rentDto) throws Exception{
		return (RentDto) select("Rent#getAppModelInfo", rentDto);
	}
	
	/*배정완료확인 총 자료수*/
	public int getAppAmount(RentDto rentDto) throws Exception{
		return (int)select("Rent#getAppAmount", rentDto);
	}
	
	/*결재상태 변경*/
	public void updAppInfo(RentDto rentDto) throws Exception{
		update("Rent#updAppInfo", rentDto);
	}
	
	/*신청자 사용자 SMS 발송*/
	@SuppressWarnings("unchecked")
	public List<RentDto> smsToUser(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#smsToUser", rentDto);
	}
	
	/*설비정보 가져오기*/
	@SuppressWarnings("unchecked")
	public List<RentDto> getAppEquip(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#getAppEquip", rentDto);
	}
	
	/*장비상태 변경*/
	public void updAppEquip(RentDto rentDto) throws Exception{
		update("Rent#updAppEquip", rentDto);
	}
	
	/*접수정보 미리보기*/
	@SuppressWarnings("unchecked")
	public List<RentDto> recListPreview(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#recListPreview", rentDto);
	}
	
	/*장비삭제시 사용자정보 삭제*/
	public void delAppEquipUser(RentDto rentDto) throws Exception{
		delete("Rent#delAppEquipUser", rentDto);
	}
	
	/*장비변경시 사용자정보의 장비수정*/
	public void updAppEquipUser(RentDto rentDto) throws Exception{
		update("Rent#updAppEquipUser", rentDto);
	}
	
	/*장비변경시 배정모델등록*/
	public void insAppModel(RentDto rentDto) throws Exception{
		insert("Rent#insAppModel", rentDto);
	}
	
	/*장비변경시 배정모델삭제*/
	public void delAppModel(RentDto rentDto) throws Exception{
		delete("Rent#delAppModel", rentDto);
	}
	
	/*인수인계시 히스토리 내역정보 가져오기*/
	public RentDto getEquipUserHistory(RentDto rentDto) throws Exception{
		return (RentDto) select("Rent#getEquipUserHistory", rentDto);
	}
	
	/*인수인계시 장비사용자 내역 등록*/
	public void insEquipUserHistory(RentDto rentDto) throws Exception{
		insert("Rent#insEquipUserHistory", rentDto);
	}
	
	/*장비사용자 내역 수정*/
	public void updEquipUserHistory(RentDto rentDto) throws Exception{
		update("Rent#updEquipUserHistory", rentDto);
	}
	
	public void partBanp (RentDto rentDto) throws Exception{
        update ("Rent#partBanp", rentDto);
    }
	
	/*uhseq 최대값 가져오기*/
	public String getMaxUhseq(RentDto rentDto) throws Exception{
		return (String)select("Rent#getMaxUhseq", rentDto);
	}
	
	/*사용자 변경메일 정보 가져오기*/
	@SuppressWarnings("unchecked")
	public RentDto getMailViewChgEu(RentDto rentDto) throws Exception{
		return (RentDto) select("Rent#getMailViewChgEu", rentDto);
	}
	
	/*담당자 변경메일 정보 가져오기*/
	@SuppressWarnings("unchecked")
	public RentDto getMailViewChgEm(RentDto rentDto) throws Exception{
		return (RentDto) select("Rent#getMailViewChgEm", rentDto);
	}

	/*마이페이지 > 리스트  > 상세정보 가져오기 */
	@SuppressWarnings("unchecked")
	public List<RentDto> getAppListView(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#getAppListView", rentDto);
	}
	
	/*알림메일 전송정보 가져오기 */
	public RentDto getMailViewInfo(RentDto rentDto) throws Exception{
		return (RentDto) select("Rent#getMailViewInfo", rentDto);
	}
	
	/*사용자 정보 가져오기*/
	public RentDto getEquipUser(RentDto rentDto) throws Exception{
		return (RentDto) select("Rent#getEquipUser", rentDto);
	}
	
	/*설비현황 > 등록  > 조직도 */
	@SuppressWarnings("unchecked")
	public List<RentDto> putJojikDep0List() throws Exception{
		return (List<RentDto>) list("Rent#putJojikDep0List", "");
	}
	
	@SuppressWarnings("unchecked")
	public List<RentDto> getDept1List() throws Exception{
		return (List<RentDto>) list("Rent#getDept1List", "");
	}
	
	@SuppressWarnings("unchecked")
	public List<RentDto> getDept2List() throws Exception{
		return (List<RentDto>) list("Rent#getDept2List", "");
	}
	
	@SuppressWarnings("unchecked")
	public List<RentDto> getDept1UserListByCode() throws Exception{
	    return (List<RentDto>) list("Rent#getDept1UserListByCode", "");
	}
	
	@SuppressWarnings("unchecked")
	public List<RentDto> getDept2UserListByCode() throws Exception{
	    return (List<RentDto>) list("Rent#getDept2UserListByCode", "");
	}
	
	@SuppressWarnings("unchecked")
	public List<RentDto> getDept3List() throws Exception{
		return (List<RentDto>) list("Rent#getDept3List", "");
	}
	
	@SuppressWarnings("unchecked")
	public List<RentDto> getDept4List() throws Exception{
		return (List<RentDto>) list("Rent#getDept4List", "");
	}
	
	@SuppressWarnings("unchecked")
	public List<RentDto> getDept5List() throws Exception{
		return (List<RentDto>) list("Rent#getDept5List", "");
	}
	
	@SuppressWarnings("unchecked")
	public List<RentDto> getDept6List() throws Exception{
		return (List<RentDto>) list("Rent#getDept6List", "");
	}
	
    @SuppressWarnings("unchecked")
    public List<RentDto> getDept3ListByCode(RentDto rentDto) throws Exception{
        return (List<RentDto>) list("Rent#getDept3ListByCode", rentDto);
    }

    @SuppressWarnings("unchecked")
    public List<RentDto> getDept4ListByCode(RentDto rentDto) throws Exception{
        return (List<RentDto>) list("Rent#getDept4ListByCode", rentDto);
    }

    @SuppressWarnings("unchecked")
    public List<RentDto> getDept5ListByCode(RentDto rentDto) throws Exception{
        return (List<RentDto>) list("Rent#getDept5ListByCode", rentDto);
    }

    @SuppressWarnings("unchecked")
    public List<RentDto> getDept6ListByCode(RentDto rentDto) throws Exception{
        return (List<RentDto>) list("Rent#getDept6ListByCode", rentDto);
    }

    @SuppressWarnings("unchecked")
    public List<RentDto> getDept3UserListByCode(RentDto rentDto) throws Exception{
        return (List<RentDto>) list("Rent#getDept3UserListByCode", rentDto);
    }

    @SuppressWarnings("unchecked")
    public List<RentDto> getDept4UserListByCode(RentDto rentDto) throws Exception{
        return (List<RentDto>) list("Rent#getDept4UserListByCode", rentDto);
    }

    @SuppressWarnings("unchecked")
    public List<RentDto> getDept5UserListByCode(RentDto rentDto) throws Exception{
        return (List<RentDto>) list("Rent#getDept5UserListByCode", rentDto);
    }

    @SuppressWarnings("unchecked")
    public List<RentDto> getDept6UserListByCode(RentDto rentDto) throws Exception{
        return (List<RentDto>) list("Rent#getDept6UserListByCode", rentDto);
    }

	@SuppressWarnings("unchecked")
	public List<RentDto> getDeptEmpList(RentDto rentDto) throws Exception{
		return (List<RentDto>) list("Rent#getDeptEmpList", rentDto);
	}
	
	@SuppressWarnings("unchecked")
    public List<RentDto> getSearchUser(RentDto rentDto) throws Exception{
        return (List<RentDto>) list("Rent#getSearchUser", rentDto);
    }
	
	/*마이캡 결재정보*/
	public void insertMikepSign(RentDto rentDto) throws Exception{
		insert("Rent#insertMikepSign", rentDto);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, String> getMInsuBanpStat(HashMap<String, String> mInsuBanpStatParamMap) throws Exception{
		return (HashMap<String, String>) select("Rent#getMInsuBanpStat", mInsuBanpStatParamMap);
	}

	/*장비대여 > 관리메뉴 > 접수현황 > 리스트 총자료수*/
	@SuppressWarnings("unchecked")
	public List<HashMap<String, Object>> getRentListCnt(RentDto rentDto) throws Exception{
		return (List<HashMap<String, Object>>) list("Rent#getRentListCnt", rentDto);
	}
	
	/*대여현황 사용자 정보*/
	@SuppressWarnings("unchecked")
	public List<RentDto> rentUserList(RentDto rentDto) {
		return (List<RentDto>) list("Rent#rentUserList", rentDto);
	}

	public int rentUserListCnt(RentDto rentDto) {
		return getCount("Rent#rentUserListCnt", rentDto);
	}

	@SuppressWarnings("unchecked")
	public List<RentDto> rentCheck(String eqno) {
		return (List<RentDto>) list("Rent#rentCheck", eqno);
	}
}
