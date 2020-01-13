package kr.co.neodreams.multi_user.service;

import java.util.List;

import kr.co.neodreams.multi_user.dto.HomeDto;

public interface HomeService {
	
	public List<HomeDto> getTodayUpdate (String val) throws Exception;
	
	public List<HomeDto> getTodayUpdateList (HomeDto homeDto) throws Exception;
	
	public int getTodayUpdateListCnt (HomeDto homeDto) throws Exception;
}
