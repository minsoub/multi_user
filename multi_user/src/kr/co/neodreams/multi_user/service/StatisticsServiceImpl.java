package kr.co.neodreams.multi_user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.base.service.BaseService;
import kr.co.neodreams.multi_user.dao.StatisticsDao;
import kr.co.neodreams.multi_user.dto.StatisticsDto;

@Service
public class StatisticsServiceImpl extends BaseService implements StatisticsService{
	
	@Autowired
	StatisticsDao statisticsDao;
	
	/** 컨텐츠 제작 신청내역 취득 */
	public Map<String, Object> getMypageStatisticsList(StatisticsDto statisticsDto) throws Exception{
	    Map<String, Object> resultMap = new HashMap<String, Object>();
		List<StatisticsDto> resultList = (List<StatisticsDto>) statisticsDao.getMypageStatisticsList(statisticsDto);
		
		//int totalCnt = statisticsDao.getMypageStatisticsListCount(statisticsDto);
		resultMap.put("resultList", resultList);
		//resultMap.put("totalCnt", totalCnt);
		
		return resultMap;
	}
}
