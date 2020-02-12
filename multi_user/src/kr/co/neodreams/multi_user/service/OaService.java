package kr.co.neodreams.multi_user.service;

import java.util.List;

import kr.co.neodreams.multi_user.dto.OaDto;

/**
 * OA 교육장 인터페이스 클래스
 * 
 * @author hist
 *
 */
public interface OaService {

	/**
	 * OA 교육장 신청 현황을 가져온다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public List<OaDto> getSelectOAList (OaDto dto) throws Exception;
	
	/**
	 * OA 교육장 신청을 저장한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int oaInsert(OaDto dto) throws Exception;
	
	/**
	 * OA 교육장 신청내역을 취소한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int oaCancel(OaDto dto) throws Exception;
	
	/**
	 * OA 교육장 예약 여부 체크
	 * 
	 * @param rsrv_dt
	 * @return
	 * @throws Exception
	 */
	public int oaRsvCheckSelect(String rsrv_dt) throws Exception;
	
	/**
	 * OA 교육장 예약신청 상세내역 조회
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public OaDto getSelectOADetail(OaDto dto) throws Exception;
}
