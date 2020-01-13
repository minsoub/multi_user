package kr.co.neodreams.multi_user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.base.service.BaseService;
import kr.co.neodreams.multi_user.dao.AccessDao;
import kr.co.neodreams.multi_user.dto.AccessDto;
import kr.co.neodreams.multi_user.dto.EquipManageDto;

@Service
public class AccessServiceImpl extends BaseService implements AccessService {
	
	@Autowired
	AccessDao accessDao;

	@Override
	public List<AccessDto> accessList(AccessDto ad) throws Exception {
		return accessDao.accessList(ad);
	}
	
	@Override
    public void insertAccessEnter (AccessDto ad) throws Exception {
		accessDao.insertAccessEnter(ad);
    }

}
