package kr.co.neodreams.multi_user.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.StatisticsDto;

@Component
public class StatisticsDao extends BaseDao{
	
    @SuppressWarnings("unchecked")
    public List<StatisticsDto> getMypageStatisticsList(StatisticsDto statisticsDto) throws Exception{
        return (List<StatisticsDto>) list("Statistics#getMypageStatisticsList", statisticsDto);
    }
    
    public int getMypageStatisticsListCount(StatisticsDto statisticsDto) throws Exception{
        return getCount("Statistics#getMypageStatisticsListCount", statisticsDto);
    }
}
