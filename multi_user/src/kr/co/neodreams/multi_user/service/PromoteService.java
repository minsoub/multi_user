package kr.co.neodreams.multi_user.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.neodreams.multi_user.dto.PromoteDto;

public interface PromoteService {

	public List<HashMap<String, String>> getPromoteList(PromoteDto promoteDto) throws Exception;
	
	public int getPromoteListCnt(PromoteDto promoteDto) throws Exception;
	
	public HashMap<String, String> getPromoteDetail(PromoteDto promoteDto) throws Exception;
	
	public String insertUpdatePromote(PromoteDto promoteDto, HttpServletRequest request) throws Exception;
	
	public List<HashMap<String, String>> getSaList() throws Exception;
	
	public String insertDeleteSa(PromoteDto promoteDto, HttpServletRequest request) throws Exception;
	
	public List<HashMap<String, String>> getUserList(PromoteDto promoteDto) throws Exception;
	
	public int getUserListCnt(PromoteDto promoteDto) throws Exception;
}
