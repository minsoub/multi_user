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
}
