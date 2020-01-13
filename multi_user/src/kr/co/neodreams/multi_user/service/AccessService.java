package kr.co.neodreams.multi_user.service;

import java.util.List;

import kr.co.neodreams.multi_user.dto.AccessDto;
import kr.co.neodreams.multi_user.dto.EquipManageDto;

public interface AccessService {
	public List<AccessDto> accessList(AccessDto ad) throws Exception;
	public void insertAccessEnter(AccessDto ad) throws Exception;

}
