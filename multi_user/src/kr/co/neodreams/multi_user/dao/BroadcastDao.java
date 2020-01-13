package kr.co.neodreams.multi_user.dao;

import java.util.List;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.BroadcastDto;

import org.springframework.stereotype.Component;

@Component
public class BroadcastDao extends BaseDao {
	
	
	/*kepcnNews 리스트*/
	@SuppressWarnings("unchecked")
	public List<BroadcastDto> getNewsList (BroadcastDto broadcastDto) throws Exception{
		return (List<BroadcastDto>) list("Broadcast#getNewsList", broadcastDto);
	}
	
	public int getNewsListCnt (BroadcastDto broadcastDto) throws Exception{
		return getCount("Broadcast#getNewsListCnt", broadcastDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<BroadcastDto> getNewsList2 (BroadcastDto broadcastDto) throws Exception{
		return (List<BroadcastDto>) list("Broadcast#getNewsList2", broadcastDto);
	}
	
	public int getNewsListCnt2 (BroadcastDto broadcastDto) throws Exception{
		return getCount("Broadcast#getNewsListCnt2", broadcastDto);
	}
}
