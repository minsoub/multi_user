package kr.co.neodreams.multi_user.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.HomeDto;

@Component
public class HomeDao extends BaseDao {
	
	@SuppressWarnings("unchecked")
	public List<HomeDto> getTodayUpdate (String val) throws Exception{
		return (List<HomeDto>) list("Home#getTodayUpdate", val);
	}
	
	@SuppressWarnings("unchecked")
	public List<HomeDto> getTodayUpdateList (HomeDto homeDto)  throws Exception{
		return (List<HomeDto>) list("Home#getTodayUpdateList", homeDto);
	}
	
	public int getTodayUpdateListCnt(HomeDto homeDto) throws Exception{
		return getCount("Home#getTodayUpdateListCnt", homeDto);
	}
}
