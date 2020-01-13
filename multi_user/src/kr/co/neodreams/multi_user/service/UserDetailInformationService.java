package kr.co.neodreams.multi_user.service;

import java.util.List;

import kr.co.neodreams.multi_user.dto.Tbsvc_tdmsempDto;

public interface UserDetailInformationService {
	
	public List Udi_Select(Tbsvc_tdmsempDto tbsvc_tdmsempDto) throws Exception;

}
