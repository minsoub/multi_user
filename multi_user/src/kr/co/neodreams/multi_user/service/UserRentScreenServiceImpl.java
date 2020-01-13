package kr.co.neodreams.multi_user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.base.service.BaseService;
import kr.co.neodreams.multi_user.dao.UserRentScreenDao;
import kr.co.neodreams.multi_user.dto.UserRentScreenDto;

@Service
public class UserRentScreenServiceImpl extends BaseService implements UserRentScreenService {
	
	@Autowired
	UserRentScreenDao userRentScreenDao;

	@Override
	public List<UserRentScreenDto> userRentList(String regeno) throws Exception {
		// TODO Auto-generated method stub
		return userRentScreenDao.userRentList(regeno);
	}

}
