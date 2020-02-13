package kr.co.neodreams.multi_user.service;

import java.util.List;

import kr.co.neodreams.multi_user.dto.LicenseDto;
import kr.co.neodreams.multi_user.dto.SwmngDto;

public interface SwService {

	/**
	 * 소프트웨어 관리 리스트를 가져온다.
	 * 
	 * @param dto
	 * @return
	 */
	public List<SwmngDto> getSwList(SwmngDto dto) throws Exception;
	
	/**
	 * 소프트웨어 관리 리스트 총 개수를 가져온다.
	 * 
	 * @param dto
	 * @return
	 */
	public int getSwListCnt(SwmngDto dto) throws Exception;
	
	/**
	 * 소프트웨어 관리를 등록한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int swmngInsert(SwmngDto dto) throws Exception;
	
	/**
	 * 소프트웨어 관리 정보를 수정한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int swmngUpdate(SwmngDto dto) throws Exception;
	
	/**
	 * 소프트웨어 관리 정보를 삭제한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int swmngDelete(SwmngDto dto) throws Exception;
	
	/**
	 * 소프트웨어 관리 상세정보를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public SwmngDto getSwmngDetail(SwmngDto dto) throws Exception;
	
	
	/**
	 * 라이센스 관리 리스트를 가져온다.
	 * 
	 * @param dto
	 * @return
	 */
	public List<LicenseDto> getLicenseList(LicenseDto dto) throws Exception;
	
	/**
	 * 라이센스 관리 리스트 총 개수를 가져온다.
	 * 
	 * @param dto
	 * @return
	 */
	public int getLicenseListCnt(LicenseDto dto) throws Exception;
	
	/**
	 * 라이센스 관리를 등록한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int licenseInsert(LicenseDto dto) throws Exception;
	
	/**
	 * 라이센스 관리 정보를 수정한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int licenseUpdate(LicenseDto dto) throws Exception;
	
	/**
	 * 라이센스 관리 정보를 삭제한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int licenseDelete(LicenseDto dto) throws Exception;
	
	/**
	 * 라이센스 관리 상세정보를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public LicenseDto getlicenseDetail(LicenseDto dto) throws Exception;	
}
