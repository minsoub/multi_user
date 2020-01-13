package kr.co.neodreams.multi_user.service;

import java.util.List;

import kr.co.neodreams.multi_user.dto.BroadcastDto;



public interface BroadcastService {

	public List<BroadcastDto> getNewsList (BroadcastDto broadcastDto) throws Exception;
	
	public int getNewsListCnt (BroadcastDto broadcastDto) throws Exception;
	
	public List<BroadcastDto> getNewsList2 (BroadcastDto broadcastDto) throws Exception;
	
	public int getNewsListCnt2 (BroadcastDto broadcastDto) throws Exception;
	
}
