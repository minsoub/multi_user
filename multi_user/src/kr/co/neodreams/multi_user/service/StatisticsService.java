package kr.co.neodreams.multi_user.service;

import java.util.Map;

import kr.co.neodreams.multi_user.dto.StatisticsDto;

public interface StatisticsService {
	/** 전광판 제작 신청내역 취득 */
	public Map<String, Object> getMypageStatisticsList(StatisticsDto statisticsDto) throws Exception;
}
