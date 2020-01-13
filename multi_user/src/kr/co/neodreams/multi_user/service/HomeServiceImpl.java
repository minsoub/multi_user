package kr.co.neodreams.multi_user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.base.service.BaseService;
import kr.co.neodreams.multi_user.dao.HomeDao;
import kr.co.neodreams.multi_user.dto.HomeDto;

@Service
public class HomeServiceImpl extends BaseService implements HomeService{

	@Autowired
	HomeDao homeDao;
	
	@Override
	public List<HomeDto> getTodayUpdate (String val) throws Exception {
		// TODO Auto-generated method stub
		return homeDao.getTodayUpdate(val);
	}
	
	@Override
	public List<HomeDto> getTodayUpdateList (HomeDto homeDto) throws Exception {
		// TODO Auto-generated method stub
		return homeDao.getTodayUpdateList(homeDto);
	}
	
	@Override
	public int getTodayUpdateListCnt(HomeDto homeDto) throws Exception {
		// TODO Auto-generated method stub
		return homeDao.getTodayUpdateListCnt(homeDto);
	}
}
