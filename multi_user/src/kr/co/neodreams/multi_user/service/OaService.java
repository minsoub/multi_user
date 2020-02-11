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
}
