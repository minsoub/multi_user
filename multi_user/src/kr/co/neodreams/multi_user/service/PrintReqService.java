package kr.co.neodreams.multi_user.service;

import java.util.List;

import kr.co.neodreams.multi_user.dto.PhotoReqDto;
import kr.co.neodreams.multi_user.dto.PrintReqDto;

/**
 * 폴로터 출력 요청, 사진 촬영 요청 Service Interface Class
 * 
 * @author hist
 *
 */
public interface PrintReqService {
	/**
	 * 플로터 출력 요청 리스트를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public List<PrintReqDto> getPrintList(PrintReqDto dto) throws Exception;
	/**
	 * 플로터 출력 요청 리스트 총 개수를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int getPrintListCnt(PrintReqDto dto) throws Exception;
	/**
	 * 플로터 출력 요청 등록한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int printInsert(PrintReqDto dto) throws Exception;
	/**
	 * 플로터 출력 요청을 수정한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int printUpdate(PrintReqDto dto) throws Exception;
	/**
	 * 플로터 출력 요청을 삭제한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int printDelete(PrintReqDto dto) throws Exception;
	/**
	 * 플로터 출력 요청 상세 정보를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public PrintReqDto getPrintReqDetail(PrintReqDto dto) throws Exception;
	/**
	 * 폴로터 출력 요청 상태 정보를 업데이트 한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int printUpdateSts(PrintReqDto dto) throws Exception;
	
	/**
	 * 사진촬영 요청 리스트를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public List<PhotoReqDto> getPhotoList(PhotoReqDto dto) throws Exception;
	/**
	 * 사진촬영 요청 리스트 총 개수를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int getPhotoListCnt(PhotoReqDto dto) throws Exception;
	/**
	 * 사진촬영 요청 등록한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int photoInsert(PhotoReqDto dto) throws Exception;
	/**
	 * 사진촬영 요청을 수정한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int photoUpdate(PhotoReqDto dto) throws Exception;
	/**
	 * 사진촬영 요청을 삭제한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int photoDelete(PhotoReqDto dto) throws Exception;
	/**
	 * 사진촬영 요청 상세 정보를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public PrintReqDto getPhotoReqDetail(PhotoReqDto dto) throws Exception;
	/**
	 * 사진촬영 요청 상태 정보를 업데이트 한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int photoUpdateSts(PhotoReqDto dto) throws Exception;
}
