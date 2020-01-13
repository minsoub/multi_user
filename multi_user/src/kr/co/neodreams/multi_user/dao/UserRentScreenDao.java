package kr.co.neodreams.multi_user.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.UserRentScreenDto;;

@Component
public class UserRentScreenDao extends BaseDao {
	
	/* 장비대여 > 관리메뉴 > 접수현황 > 사용자 대여 물품 리스트 */
	@SuppressWarnings("unchecked")
	public List<UserRentScreenDto> userRentList(String regeno) throws Exception{
		return (List<UserRentScreenDto>)list("UserRentScreen#userRentList", regeno);
	}

}
