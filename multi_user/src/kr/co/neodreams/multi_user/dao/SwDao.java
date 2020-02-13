package kr.co.neodreams.multi_user.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.LicenseDto;
import kr.co.neodreams.multi_user.dto.SwmngDto;


/**
 * 소프트웨어 관리, 라이센스 관리 DAO Class
 * 
 * @author hist
 *
 */
@Component
public class SwDao  extends BaseDao {
	/**
	 * 소프트웨어 관리 리스트를 가져온다.
	 * 
	 * @param dto
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SwmngDto> getSwList(SwmngDto dto) throws Exception
	{
		return (List<SwmngDto>) list("License#getSwList", dto);
	}
	
	/**
	 * 소프트웨어 관리 리스트 총 개수를 가져온다.
	 * 
	 * @param dto
	 * @return
	 */
	public int getSwListCnt(SwmngDto dto) throws Exception
	{
		return getCount("License#getSwListCnt", dto);
	}
	
	/**
	 * 소프트웨어 관리를 등록한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public Object swmngInsert(SwmngDto dto) throws Exception
	{
		return insert("License#swmngInsert", dto);
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
		return update("License#swmngUpdate", dto);
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
		return delete("License#swmngDelete", dto);
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
		return (SwmngDto) select("License#getSwmngDetail", dto);
	}
	
	
	/**
	 * 라이센스 관리 리스트를 가져온다.
	 * 
	 * @param dto
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<LicenseDto> getLicenseList(LicenseDto dto) throws Exception
	{
		return (List<LicenseDto>) list("License#getLicenseList", dto);
	}
	
	/**
	 * 라이센스 관리 리스트 총 개수를 가져온다.
	 * 
	 * @param dto
	 * @return
	 */
	public int getLicenseListCnt(LicenseDto dto) throws Exception
	{
		return getCount("License#getLicenseListCnt", dto);
	}
	
	/**
	 * 라이센스 관리를 등록한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public Object licenseInsert(LicenseDto dto) throws Exception
	{
		return insert("License#licenseInsert", dto);
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
		return update("License#licenseUpdate", dto);
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
		return delete("License#licenseDelete", dto);
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
		return (LicenseDto) select("License#getlicenseDetail", dto);
	}
}
