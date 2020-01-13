package kr.co.neodreams.multi_user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.neodreams.multi_user.dto.LongTermUserDto;

public interface LongTermUserService {
	
	public List<LongTermUserDto> equipCodeList() throws Exception;

	public List<LongTermUserDto> longTermUserList(LongTermUserDto ltud) throws Exception;
	public List<LongTermUserDto> longTermUserNotifyUserInfo(LongTermUserDto ltud) throws Exception;
	public List<HashMap<String, String>> notebookCheckList(LongTermUserDto ltud) throws Exception;
	public int notebookCheckListCnt(LongTermUserDto ltud) throws Exception;
	public HashMap<String, String> notebookCheckView(LongTermUserDto ltud) throws Exception;
	public String notebookCheckUpdate(HttpServletRequest request) throws Exception;
	public List<HashMap<String, String>> notebookCheckListXls(LongTermUserDto ltud) throws Exception;

	public byte[] excelDown(Map<String, Object> commandMap, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public String notebookPartsUpdate(LongTermUserDto longTermUserDto) throws Exception;
}
