package kr.co.neodreams.multi_user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.base.service.BaseService;
import kr.co.neodreams.multi_user.dao.PowerstatusDao;
import kr.co.neodreams.multi_user.dto.PowerstatusDto;

@Service
public class PowerstatusServiceImpl extends BaseService implements PowerstatusService{

	@Autowired
	PowerstatusDao powerstatusDao;
	
	@Override
	public PowerstatusDto getDeptNameInfo (String empno) throws Exception {
		return powerstatusDao.getDeptNameInfo(empno);
	}
}
