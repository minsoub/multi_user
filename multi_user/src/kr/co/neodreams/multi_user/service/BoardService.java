package kr.co.neodreams.multi_user.service;

import java.util.List;

import kr.co.neodreams.multi_user.dto.BoardDto;
import kr.co.neodreams.multi_user.dto.NoticeDto;

/**
 * IT 플라자 게시판 관련 서비스
 * 
 * @author minso
 *
 */
public interface BoardService {

	/**
	 * 게시판 리스트 데이터를 조회한다.
	 * 게시판 아이디를 통해서 게시판을 구분한다.
	 * 
	 * @param boardDto
	 * @return
	 * @throws Exception
	 */
    public List<BoardDto> getSelectBoardList (BoardDto boardDto) throws Exception;

    /**
     * 게시판 페이징을 위한 리스트 개수를 구한다.
     * 
     * @param boardDto
     * @return
     * @throws Exception
     */
    public int getSelectBoardListCnt (BoardDto boardDto) throws Exception;
    
    /**
     * 게시글을 등록한다.
     * 
     * @param boardDto
     * @return
     * @throws Exception
     */
    public int boardInsert(BoardDto boardDto) throws Exception;
    
    /**
     * 게시글 상세정보를 리턴한다. 
     * 
     * @param boardDto
     * @return
     * @throws Exception
     */
    public BoardDto getSelectBoardDetail(BoardDto boardDto) throws Exception;
    
    /**
     * 게시글 조회 수를 증가시킨다.
     * 
     * @param boardDto
     * @return
     * @throws Exception
     */
    public int boardHitUpdate(BoardDto boardDto) throws Exception;
    
    /**
     * 게시글을 삭제한다.
     * 
     * @param boardDto
     * @return
     * @throws Exception
     */
	public int boardDelete(BoardDto boardDto) throws Exception;
	
	/**
	 * 삭제할 첨부 파일 리스트를 조회한다.
	 * 
	 * @param boardDto
	 * @return
	 * @throws Exception
	 */
	public List<BoardDto> garbageAttatch (BoardDto boardDto) throws Exception;
	
	/**
	 * 게시판 첨부 파일을  삭제한다.
	 * 
	 * @param boardDto
	 * @return
	 * @throws Exception
	 */
	public int boardFileDelete(BoardDto boardDto) throws Exception;
}
