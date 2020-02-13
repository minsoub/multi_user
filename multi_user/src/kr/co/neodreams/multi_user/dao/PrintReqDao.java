package kr.co.neodreams.multi_user.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.PhotoReqDto;
import kr.co.neodreams.multi_user.dto.PrintReqDto;


/**
 * 플로터 출력 요청, 사진촬영요청 처리 DAO Class
 * 
 * @author hist
 *
 */
@Component
public class PrintReqDao extends BaseDao {

	/**
	 * 플로터 출력 요청 리스트를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PrintReqDto> getPrintList(PrintReqDto dto) throws Exception
	{
		return (List<PrintReqDto>) list("PrintReq#getPrintList", dto);
	}
	/**
	 * 플로터 출력 요청 리스트 총 개수를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int getPrintListCnt(PrintReqDto dto) throws Exception
	{
		return getCount("PrintReq#getPrintListCnt", dto);
	}
	/**
	 * 플로터 출력 요청 등록한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public Object printInsert(PrintReqDto dto) throws Exception
	{
		return insert("PrintReq#printInsert", dto);
	}
	/**
	 * 플로터 출력 요청을 수정한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int printUpdate(PrintReqDto dto) throws Exception
	{
		return update("PrintReq#printUpdate", dto);
	}
	/**
	 * 플로터 출력 요청을 삭제한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int printDelete(PrintReqDto dto) throws Exception
	{
		return delete("PrintReq#printDelete", dto);
	}
	/**
	 * 플로터 출력 요청 상세 정보를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public PrintReqDto getPrintReqDetail(PrintReqDto dto) throws Exception
	{
		return (PrintReqDto) select("PrintReq#getPrintReqDetail", dto);
	}
	/**
	 * 폴로터 출력 요청 상태 정보를 업데이트 한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int printUpdateSts(PrintReqDto dto) throws Exception
	{
		return update("PrintReq#printUpdateSts", dto);
	}
	
	/**
	 * 파일정보를 업데이트 한다.
	 * 
	 * @param listBoardDto
	 * @return
	 */
	public Object boardAttatchInsert(List<PrintReqDto> dto) {
		return insert("PrintReq#printAttatchInsert", dto);
	}
		
	/**
	 * 첨부된 파일을 삭제한다.
	 * 
	 * @param boardDto
	 * @return
	 */
	public int attatchDelete(PrintReqDto dto) {
		return delete("PrintReq#attatchDelete", dto);
	}

	/**
	 * 게시글 삭제후 첨부 파일 삭제 리스트를 조회한다.
	 * 
	 * @param boardDto
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<PrintReqDto> garbageAttatch(PrintReqDto dto) {
		return (List<PrintReqDto>) list("PrintReq#garbageAttatch", dto);
	}

	/**
	 * 첨부 파일을 삭제한다.
	 * 
	 * @param boardDto
	 * @return
	 */
	public int boardFileDelete(PrintReqDto dto) {
		return delete("PrintReq#printFileDelete", dto);
	}

	/**
	 * 첨부 파일 리스트를 조회한다.
	 * 
	 * @param boardDto
	 * @return
	 */
	public PrintReqDto getAttatch(PrintReqDto dto) {
		return (PrintReqDto) select("PrintReq#getAttatchList", dto);
	}
		
	
	/**
	 * 사진촬영 요청 리스트를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PhotoReqDto> getPhotoList(PhotoReqDto dto) throws Exception
	{
		return (List<PhotoReqDto>) list("PrintReq#getPhotoList", dto);
	}
	/**
	 * 사진촬영 요청 리스트 총 개수를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int getPhotoListCnt(PhotoReqDto dto) throws Exception
	{
		return getCount("PrintReq#getPhotoListCnt", dto);
	}
	/**
	 * 사진촬영 요청 등록한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public Object photoInsert(PhotoReqDto dto) throws Exception
	{
		return insert("PrintReq#photoInsert", dto);
	}
	/**
	 * 사진촬영 요청을 수정한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int photoUpdate(PhotoReqDto dto) throws Exception
	{
		return update("PrintReq#photoUpdate", dto);
	}
	/**
	 * 사진촬영 요청을 삭제한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int photoDelete(PhotoReqDto dto) throws Exception
	{
		return delete("PrintReq#photoDelete", dto);
	}
	/**
	 * 사진촬영 요청 상세 정보를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public PrintReqDto getPhotoReqDetail(PhotoReqDto dto) throws Exception
	{
		return (PrintReqDto) select("PrintReq#getPhotoReqDetail", dto);
	}
	/**
	 * 사진촬영 요청 상태 정보를 업데이트 한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int photoUpdateSts(PhotoReqDto dto) throws Exception
	{
		return update("PrintReq#photoUpdateSts", dto);
	}	
}
