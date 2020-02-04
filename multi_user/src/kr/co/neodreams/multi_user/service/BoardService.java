package kr.co.neodreams.multi_user.service;

import java.util.List;

import kr.co.neodreams.multi_user.dto.BoardDto;

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
}
