package kr.co.neodreams.multi_user.service;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.dao.BoardDao;
import kr.co.neodreams.multi_user.dto.BoardDto;
import kr.co.neodreams.multi_user.dto.NoticeDto;

/**
 * IT 플라자 게시판 관련 서비스 구현 클래스
 * @author minso
 *
 */
@Service
public class BoardServiceImpl implements BoardService {

	 @Autowired 
	 BoardDao boardDao;
	/**
	 * 게시판 리스트 데이터를 조회한다.
	 * 게시판 아이디를 통해서 게시판을 구분한다.
	 * 
	 * @param commonDto
	 * @return
	 * @throws Exception
	 */
    public List<BoardDto> getSelectBoardList (BoardDto boardDto) throws Exception
    {
    	return boardDao.getSelectBoardList(boardDto);
    }

    /**
     * 게시판 페이징을 위한 리스트 개수를 구한다.
     * 
     * @param commonDto
     * @return
     * @throws Exception
     */
    public int getSelectBoardListCnt (BoardDto boardDto) throws Exception
    {
    	return boardDao.getSelectBoardListCnt(boardDto);
    }
    
    /**
     * 게시글 상세정보를 리턴한다.
     * 
     */
    @Override
    public BoardDto getSelectBoardDetail(BoardDto boardDto) throws Exception
    {
    	return boardDao.getSelectBoardDetail(boardDto);
    }

    /**
     * 게시글을 등록한다.
     */
	@Override
	public int boardInsert(BoardDto boardDto) throws Exception {
		// TODO Auto-generated method stub
		int retVal = (int) boardDao.boardInsert(boardDto);
		if(retVal > 0) {
			boardDto.setSeq(retVal);
			int attatchFileChk = boardAttatchInsert(boardDto);
			
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
	public int boardAttatchInsert(BoardDto boardDto) {
		int retVal = 0;
		try {
			if(!"".equals(boardDto.getFreqs().trim())) {
				StringTokenizer attatchSeqs = new StringTokenizer(boardDto.getFreqs(),"|");
				List<BoardDto> listattatchDto = new ArrayList<>();
				
				int totCnt = attatchSeqs.countTokens();
				for(int i=0; i < totCnt; i++) {
					BoardDto attatchDto = new BoardDto();
					attatchDto.setSeq(boardDto.getSeq());			// 게시글 번호
					attatchDto.setFreq(attatchSeqs.nextToken());	// 파일번호
					attatchDto.setBbsid(boardDto.getBbsid());		// 게시판 아이디
					listattatchDto.add(attatchDto);
				}
				
				if(listattatchDto.size() > 0) {
					boardDao.boardAttatchInsert(listattatchDto);
				}
			}
		}catch (Exception e) {
			retVal = -1;
		}
		return retVal;
	}
	/**
	 * 게시글 조회수를 증가시킨다.
	 * 
	 */
	public int boardHitUpdate(BoardDto boardDto) throws Exception {
		int retVal = (int) boardDao.boardHitUpdate(boardDto);
		
		return retVal;
	}
	
    /**
     * 게시글을 삭제한다.
     * 
     * @param noticeDto
     * @return
     * @throws Exception
     */
	public int boardDelete(BoardDto boardDto) throws Exception
	{
		return boardDao.boardDelete(boardDto);
	}
	
	/**
	 * 삭제할 첨부 파일 리스트를 조회한다.
	 * 
	 * @param noticeDto
	 * @return
	 * @throws Exception
	 */
	public List<BoardDto> garbageAttatch (BoardDto boardDto) throws Exception
	{
		return boardDao.garbageAttatch(boardDto);
	}
	
	/**
	 * 게시판 첨부 파일을  삭제한다.
	 * 
	 * @param noticeDto
	 * @return
	 * @throws Exception
	 */
	public int boardFileDelete(BoardDto boardDto) throws Exception	
	{
		return boardDao.boardFileDelete(boardDto);
	}
}
