package kr.co.neodreams.multi_user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.dao.SwDao;
import kr.co.neodreams.multi_user.dto.LicenseDto;
import kr.co.neodreams.multi_user.dto.SwmngDto;

@Service
public class SwServiceImpl implements SwService {
	
	@Autowired 
	SwDao swDao;
	
	/**
	 * 소프트웨어 관리 리스트를 가져온다.
	 * 
	 * @param dto
	 * @return
	 */
	public List<SwmngDto> getSwList(SwmngDto dto) throws Exception
	{
		return swDao.getSwList(dto);
	}
	
	/**
	 * 소프트웨어 관리 리스트 총 개수를 가져온다.
	 * 
	 * @param dto
	 * @return
	 */
	public int getSwListCnt(SwmngDto dto) throws Exception
	{
		return swDao.getSwListCnt(dto);
	}
	
	/**
	 * 소프트웨어 관리를 등록한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int swmngInsert(SwmngDto dto) throws Exception
	{
		return (int) swDao.swmngInsert(dto);
	}
	
	/**
	 * 소프트웨어 관리 정보를 수정한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int swmngUpdate(SwmngDto dto) throws Exception
	{
		return swDao.swmngUpdate(dto);
	}
	
	/**
	 * 소프트웨어 관리 정보를 삭제한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int swmngDelete(SwmngDto dto) throws Exception
	{
		return swDao.swmngDelete(dto);
	}
	
	/**
	 * 소프트웨어 관리 상세정보를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public SwmngDto getSwmngDetail(SwmngDto dto) throws Exception
	{
		return swDao.getSwmngDetail(dto);
	}
	
	
	/**
	 * 라이센스 관리 리스트를 가져온다.
	 * 
	 * @param dto
	 * @return
	 */
	public List<LicenseDto> getLicenseList(LicenseDto dto) throws Exception
	{
		return swDao.getLicenseList(dto);
	}
	
	/**
	 * 라이센스 관리 리스트 총 개수를 가져온다.
	 * 
	 * @param dto
	 * @return
	 */
	public int getLicenseListCnt(LicenseDto dto) throws Exception
	{
		return swDao.getLicenseListCnt(dto);
	}
	
	/**
	 * 라이센스 관리를 등록한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int licenseInsert(LicenseDto dto) throws Exception
	{
		return (int)swDao.licenseInsert(dto);
	}
	
	/**
	 * 라이센스 관리 정보를 수정한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int licenseUpdate(LicenseDto dto) throws Exception
	{
		return swDao.licenseUpdate(dto);
	}
	
	/**
	 * 라이센스 관리 정보를 삭제한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int licenseDelete(LicenseDto dto) throws Exception
	{
		return swDao.licenseDelete(dto);
	}
	
	/**
	 * 라이센스 관리 상세정보를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public LicenseDto getlicenseDetail(LicenseDto dto) throws Exception
	{
		return swDao.getlicenseDetail(dto);
	}
}
