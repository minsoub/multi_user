package kr.co.neodreams.multi_user.service;

import java.util.List;

import kr.co.neodreams.multi_user.base.service.BaseService;
import kr.co.neodreams.multi_user.dao.BroadcastDao;
import kr.co.neodreams.multi_user.dto.BroadcastDto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BroadcastServiceImpl extends BaseService implements BroadcastService{

	@Autowired
	BroadcastDao broadcastDao;
	
	@Override
	public List<BroadcastDto> getNewsList(BroadcastDto broadcastDto) throws Exception {
		// TODO Auto-generated method stub
		return broadcastDao.getNewsList(broadcastDto);
	}
	
	@Override
	public int getNewsListCnt(BroadcastDto broadcastDto) throws Exception {
		// TODO Auto-generated method stub
		return broadcastDao.getNewsListCnt(broadcastDto);
	}
	
	@Override
	public List<BroadcastDto> getNewsList2(BroadcastDto broadcastDto) throws Exception {
		// TODO Auto-generated method stub
		return broadcastDao.getNewsList2(broadcastDto);
	}
	
	@Override
	public int getNewsListCnt2(BroadcastDto broadcastDto) throws Exception {
		// TODO Auto-generated method stub
		return broadcastDao.getNewsListCnt2(broadcastDto);
	}
}
