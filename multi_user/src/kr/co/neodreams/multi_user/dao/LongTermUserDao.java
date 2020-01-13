package kr.co.neodreams.multi_user.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.common.DataMap;
import kr.co.neodreams.multi_user.dto.LongTermUserDto;

@Component
public class LongTermUserDao extends BaseDao {
	
	/* 장비대여 > 관리메뉴 > 장기대여사용자관리 > 장비리스트 */ 
	@SuppressWarnings("unchecked")
	public List<LongTermUserDto> equipCodeList() throws Exception{
		return (List<LongTermUserDto>) list("LongTermUser#codeList", null);
	}

	/* 장비대여 > 관리메뉴 > 장기대여사용자관리 > 리스트 */ 
	@SuppressWarnings("unchecked")
	public List<LongTermUserDto> longTermUserList(LongTermUserDto ltud) {
		return (List<LongTermUserDto>) list("LongTermUser#equipRentListNew", ltud);
	}

	/* 장비대여 > 관리메뉴 > 장기대여사용자관리 > 대여알림 */ 
	@SuppressWarnings("unchecked")
	public List<LongTermUserDto> longTermUserNotifyUserInfo(LongTermUserDto ltud) {
		return (List<LongTermUserDto>) list("LongTermUser#NofityUserInfo", ltud);
	}

	/* 장비대여 > 관리메뉴 > 노트북 점검대장 > 리스트 */ 
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> notebookCheckList(LongTermUserDto ltud) {
		return (List<HashMap<String, String>>) list("LongTermUser#notebookCheckList", ltud);
	}
	
	public int notebookCheckListCnt(LongTermUserDto ltud) {
		return getCount("LongTermUser#notebookCheckListCnt", ltud);
	}

	/* 장비대여 > 관리메뉴 > 노트북 점검대장 > 상세보기 */ 
	@SuppressWarnings("unchecked")
	public HashMap<String, String> notebookCheckView(LongTermUserDto ltud) {
		return (HashMap<String, String>) select("LongTermUser#notebookCheckView", ltud);
	}
	
	/* 장비대여 > 관리메뉴 > 노트북 점검대장 > 상세보기 수정 */ 
	public void notebookCheckUpdate (DataMap dataMap) throws Exception {
        update("LongTermUser#notebookCheckUpdate", dataMap);
    }

	/* 장비대여 > 관리메뉴 > 노트북 점검대장 > 엑셀 리스트 */ 
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> notebookCheckListXls(LongTermUserDto ltud) {
		return (List<HashMap<String, String>>) list("LongTermUser#notebookCheckListXls", ltud);
	}

	public void notebookPartsUpdate(LongTermUserDto longTermUserDto) {
		update("LongTermUser#notebookPartsUpdate", longTermUserDto);
	}
}
