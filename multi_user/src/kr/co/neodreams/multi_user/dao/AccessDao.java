package kr.co.neodreams.multi_user.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.AccessDto;
import kr.co.neodreams.multi_user.dto.EquipManageDto;

@Component
public class AccessDao extends BaseDao {
	
	/* 장비대여 > 관리메뉴 > 출입대장관리  */    
	@SuppressWarnings("unchecked")
	public List<AccessDto> accessList(AccessDto ad) throws Exception{
		return (List<AccessDto>)list("Access#accessList", ad);
	}
	
	public void insertAccessEnter(AccessDto ad) throws Exception{
        insert("Access#accessEnter", ad);
    }

}