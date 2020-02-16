package kr.co.neodreams.multi_user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.dao.OaDao;
import kr.co.neodreams.multi_user.dto.OaDto;

/**
 * OA 교육장 인터페이스 구현 클래스
 * 
 * @author hist
 *
 */
@Service
public class OaServiceImpl implements OaService {

	@Autowired
	OaDao oaDao;
	
	/**
	 * OA 교육장 신청 현황을 조회한다 - Mypage
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public List<OaDto> getSelectOAMyList(OaDto dto) throws Exception
	{
		return oaDao.getSelectOAMyList(dto);
	}

	/**
	 * OA 교육장 신청 현황(총개수)을 조회한다 - Mypage
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int getSelectOAMyListCnt(OaDto dto) throws Exception
	{
		return oaDao.getSelectOAMyListCnt(dto);
	}
	
	/**
	 * OA 교육장 신청 현황을 가져온다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public List<OaDto> getSelectOAList (OaDto dto) throws Exception
	{
		return oaDao.getSelectOAList(dto);
	}
	
	/**
	 * OA 교육장 신청을 저장한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int oaInsert(OaDto dto) throws Exception
	{
		return (int) oaDao.oaInsert(dto);
	}
	
	/**
	 * OA 교육장 신청내역을 취소한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int oaCancel(OaDto dto) throws Exception
	{
		return (int) oaDao.oaCancel(dto);
	}
	
	/**
	 * OA 교육장 신청내역을 승인완료 시킨다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int oaApply(OaDto dto) throws Exception
	{
		return (int) oaDao.oaApply(dto);
	}	
	/**
	 * OA 교육장 예약 여부 체크
	 * 
	 * @param rsrv_dt
	 * @return
	 * @throws Exception
	 */
	public int oaRsvCheckSelect(String rsrv_dt) throws Exception
	{
		return oaDao.getRsvCheckSelect(rsrv_dt);
	}
	
	/**
	 * OA 교육장 예약신청 상세내역 조회
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public OaDto getSelectOADetail(OaDto dto) throws Exception
	{
		return oaDao.getSelectOADetail(dto);
	}
}
