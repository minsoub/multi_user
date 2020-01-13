package kr.co.neodreams.multi_user.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dao.UserDetailInformationDao;
import kr.co.neodreams.multi_user.dto.Tbsvc_tdmsempDto;

@Service
public class UserDetailInformationServiceImpl extends BaseDao implements UserDetailInformationService {
	
	@Autowired
	UserDetailInformationDao dao;
	
	public List Udi_Select(Tbsvc_tdmsempDto tbsvc_tdmsempDto) throws Exception{
		
		List<Tbsvc_tdmsempDto> userinfo = null;
		userinfo = dao.Udi_Select(tbsvc_tdmsempDto);
		
		tbsvc_tdmsempDto.setDEPTNO(userinfo.get(0).getDEPTNO().toString());
		List<Tbsvc_tdmsempDto> userdepth = null;
		userdepth = dao.Uid_depth_Select(tbsvc_tdmsempDto);
		
		List user = new ArrayList();
		
		user.add(userinfo);
		user.add(userdepth);
		
		return user;
	};
}
