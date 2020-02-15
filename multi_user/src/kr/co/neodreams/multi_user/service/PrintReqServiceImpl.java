package kr.co.neodreams.multi_user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.dao.PrintReqDao;
import kr.co.neodreams.multi_user.dto.BoardDto;
import kr.co.neodreams.multi_user.dto.PhotoReqDto;
import kr.co.neodreams.multi_user.dto.PrintReqDto;


/**
 * 폴로터 출력 요청, 사진 촬영 요청 Service 구현 Class
 * 
 * @author hist
 *
 */
@Service
public class PrintReqServiceImpl implements PrintReqService {
	
	@Autowired
	PrintReqDao printReqDao;
	
	/**
	 * 플로터 출력 요청 리스트를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public List<PrintReqDto> getPrintList(PrintReqDto dto) throws Exception
	{
		return printReqDao.getPrintList(dto);
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
		return printReqDao.getPrintListCnt(dto);
	}
	/**
	 * 플로터 출력 요청 등록한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int printInsert(PrintReqDto dto) throws Exception
	{
		int retVal = (int) printReqDao.printInsert(dto);
		
		if(retVal > 0) {
			dto.setSeq(retVal);
			int attatchFileChk = attatchInsert(dto);
			
			if(attatchFileChk < 0) {
				throw new Exception("-1"); 
			}
		}
		return retVal;
	}
    /**
     * 파일 정보를 업데이트 한다.
     * 
     * @param boardDto
     * @return
     */
	public int attatchInsert(PrintReqDto dto) {
		int retVal = 0;
		try {
			if(!"".equals(dto.getFreqs().trim())) {
				StringTokenizer attatchSeqs = new StringTokenizer(dto.getFreqs(),"|");
				List<PrintReqDto> listattatchDto = new ArrayList<>();
				
				int totCnt = attatchSeqs.countTokens();
				for(int i=0; i < totCnt; i++) {
					PrintReqDto attatchDto = new PrintReqDto();
					attatchDto.setSeq(dto.getSeq());			// 게시글 번호
					attatchDto.setFreq(attatchSeqs.nextToken());	// 파일번호
					attatchDto.setBbsid(dto.getBbsid());		// 게시판 아이디
					listattatchDto.add(attatchDto);
				}
				
				if(listattatchDto.size() > 0) {
					printReqDao.printAttatchInsert(listattatchDto);
				}
			}
		}catch (Exception e) {
			retVal = -1;
		}
		return retVal;
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
		int retVal =  printReqDao.printUpdate(dto);
		
		if(retVal > 0) {
			dto.setSeq(dto.getSeq());
			int attatchFileChk = attatchInsert(dto);
			
			if(attatchFileChk < 0) {
				throw new Exception("-1"); 
			}
		}
		return retVal;
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
		return printReqDao.printDelete(dto);
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
		return printReqDao.getPrintReqDetail(dto);
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
		return printReqDao.printUpdateSts(dto);
	}
	
	/**
	 * 삭제할 첨부 파일 리스트를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public List<PrintReqDto> garbageAttatch (PrintReqDto dto) throws Exception
	{
		return printReqDao.garbageAttatch(dto);
	}
	
	/**
	 * 폴로터 출력  첨부 파일을  삭제한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int printFileDelete(PrintReqDto dto) throws Exception	
	{
		return printReqDao.printFileDelete(dto);
	}
		
	
	/**
	 * 사진촬영 요청 리스트를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public List<PhotoReqDto> getPhotoList(PhotoReqDto dto) throws Exception
	{
		return printReqDao.getPhotoList(dto);
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
		return printReqDao.getPhotoListCnt(dto);
	}
	/**
	 * 사진촬영 요청 등록한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public int photoInsert(PhotoReqDto dto) throws Exception
	{
		return (int) printReqDao.photoInsert(dto);
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
		return printReqDao.photoUpdate(dto);
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
		return printReqDao.photoDelete(dto);
	}
	/**
	 * 사진촬영 요청 상세 정보를 조회한다.
	 * 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	public PhotoReqDto getPhotoReqDetail(PhotoReqDto dto) throws Exception
	{
		return printReqDao.getPhotoReqDetail(dto);
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
		return printReqDao.photoUpdateSts(dto);
	}
	
	/**
	 * 사용자 검색 
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public List<HashMap> getUserSearch(PrintReqDto dto) throws Exception
	{
		return printReqDao.getUserSearch(dto);
	}
}
