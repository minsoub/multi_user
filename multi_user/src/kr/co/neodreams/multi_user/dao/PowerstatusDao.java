package kr.co.neodreams.multi_user.dao;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.PowerstatusDto;

@Component
public class PowerstatusDao extends BaseDao {
	
	public PowerstatusDto getDeptNameInfo (String empno) throws Exception{
		return (PowerstatusDto) select("Powerstatus#getDeptNameInfo", empno);
	}
}
