package kr.co.neodreams.multi_user.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.BoardDto;
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
    
    /**
     * OA 교육장 신청을 접수한다.
     * 
     * @param dto
     * @return
     */
	public Object oaInsert(OaDto dto) {
		return insert("OA#oaInsert", dto);
	}
	
	/**
	 * OA 교육장 신청내역을 취소한다.
	 * 
	 * @param dto
	 * @return
	 */
	public Object oaCancel(OaDto dto) {
		return update("OA#oaCancel", dto);
	}
	
	/**
	 * OA 교육장 신청내역을 승인완료시킨다.
	 * 
	 * @param dto
	 * @return
	 */
	public Object oaApply(OaDto dto) {
		return update("OA#oaApply", dto);
	}	
	
	/**
	 * OA 교육장 신청 예약 여부를 체크한다.
	 * 
	 * @param rsrv_dt
	 * @return
	 */
	public int getRsvCheckSelect(String rsrv_dt) {
		return (int) select("OA#getRsvCheckSelect", rsrv_dt);
	}
	
	/**
	 * OA 교육장 신청 상세 내역을 조회한다.
	 * 
	 * @param dto
	 * @return
	 */
	public OaDto getSelectOADetail(OaDto dto) {
		return (OaDto) select("OA#getSelectOADetail", dto);
	}
	/**
	 * OA 교육장 신청 데이터를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
    @SuppressWarnings("unchecked")
	public List<OaDto> getSelectOAMyList (OaDto dto)  throws Exception{
        return (List<OaDto>) list("OA#getSelectOAMyList", dto);
    }

    /**
     * OA 교육장 신청 페이징을 위한 리스트 개수를 구한다.
     * 
     * @param dto
     * @return
     * @throws Exception
     */
    public int getSelectOAMyListCnt (OaDto dto) throws Exception{
        return getCount("OA#getSelectOAMyListCnt", dto);
    }
}
