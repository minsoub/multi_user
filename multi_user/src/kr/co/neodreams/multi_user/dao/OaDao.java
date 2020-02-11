package kr.co.neodreams.multi_user.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.OaDto;

/**
 * OA 예약장 신청 DAO Class
 * 
 * @author hist
 *
 */
@Component
public class OaDao extends BaseDao {
	/**
	 * OA 교육장 신청 현황을 가져온다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
    @SuppressWarnings("unchecked")
	public List<OaDto> getSelectOAList (OaDto dto)  throws Exception{
        return (List<OaDto>) list("OA#getSelectOAList", dto);
    }

}
