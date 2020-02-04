package kr.co.neodreams.multi_user.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.BoardDto;

/**
 * 게시판 데이터베이스 처리 클래스
 * 
 * @author minso
 *
 */
@Component
public class BoardDao  extends BaseDao {

	/**
	 * 게시판 리스트 데이터를 조회한다.
	 * 게시판 아이디를 통해서 게시판을 구분한다.
	 * 
	 * @param commonDto
	 * @return
	 * @throws Exception
	 */
    @SuppressWarnings("unchecked")
	public List<BoardDto> getSelectBoardList (BoardDto boardDto)  throws Exception{
        return (List<BoardDto>) list("Board#getSelectBoardList", boardDto);
    }

    /**
     * 게시판 페이징을 위한 리스트 개수를 구한다.
     * 
     * @param commonDto
     * @return
     * @throws Exception
     */
    public int getSelectBoardListCnt (BoardDto boardDto) throws Exception{
        return getCount("Board#getSelectBoardListCnt", boardDto);
    }
    
    /**
     * 게시글 등록한다.
     * 
     * @param boardDto
     * @return
     */
	public Object boardInsert(BoardDto boardDto) {
		return insert("Board#boardInsert", boardDto);
	}
	/**
	 * 파일정보를 업데이트 한다.
	 * 
	 * @param listBoardDto
	 * @return
	 */
	public Object boardAttatchInsert(List<BoardDto> listBoardDto) {
		return insert("Board#boardAttatchInsert", listBoardDto);
	}
}
