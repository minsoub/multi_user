package kr.co.neodreams.multi_user.service;

import java.util.List;

import kr.co.neodreams.multi_user.dto.UserRentScreenDto;

public interface UserRentScreenService {
	public List<UserRentScreenDto> userRentList(String regeno) throws Exception;

}
