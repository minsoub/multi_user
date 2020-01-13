package kr.co.neodreams.multi_user.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.Tbsvc_tdmsempDto;

@Component
public class UserDetailInformationDao extends BaseDao{
	public List<Tbsvc_tdmsempDto>  Udi_Select(Tbsvc_tdmsempDto tbsvc_tdmsempDto){
		return (List<Tbsvc_tdmsempDto>) list("Udi#select_tdmsemp",tbsvc_tdmsempDto);
	}
	
	
	public List<Tbsvc_tdmsempDto> Uid_depth_Select(Tbsvc_tdmsempDto tbsvc_tdmsempDto){
		return (List<Tbsvc_tdmsempDto>) list("Udi#select_tbmsdept",tbsvc_tdmsempDto);
	}
}
