package kr.co.neodreams.multi_user.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.PromoteDto;

@Component
public class PromoteDao extends BaseDao{
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getPromoteList(PromoteDto promoteDto) throws Exception {
		return (List<HashMap<String, String>>) list("Promote#getPromoteList", promoteDto);
	}
	
	public int getPromoteListCnt(PromoteDto promoteDto) throws Exception {
		return getCount("Promote#getPromoteListCnt", promoteDto);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, String> getPromoteDetail(PromoteDto promoteDto) throws Exception {
		return (HashMap<String, String>) select("Promote#getPromoteDetail", promoteDto);
	}
	
	public int insertPromote(PromoteDto promoteDto) throws Exception {
		return (int) insert ("Promote#insertPromote", promoteDto);
	}
	
	public void updatePromote(PromoteDto promoteDto) throws Exception {
		update ("Promote#updatePromote", promoteDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getSaList() throws Exception {
		return (List<HashMap<String, String>>) list("Promote#getSaList", "");
	}
	
	public void deleteSa(PromoteDto promoteDto) throws Exception {
		update ("Promote#deleteSa", promoteDto);
	}
	
	public void insertSa(PromoteDto promoteDto) throws Exception {
		update ("Promote#insertSa", promoteDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getUserList(PromoteDto promoteDto) throws Exception {
		return (List<HashMap<String, String>>) list("Promote#getUserList", promoteDto);
	}
	
	public int getUserListCnt(PromoteDto promoteDto) throws Exception {
		return getCount("Promote#getUserListCnt", promoteDto);
	}
}
