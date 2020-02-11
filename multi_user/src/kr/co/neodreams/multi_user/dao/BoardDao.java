package kr.co.neodreams.multi_user.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.BoardDto;
import kr.co.neodreams.multi_user.dto.NoticeDto;

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
     * 게시글 상세 정보를 리턴한다.
     * 
     * @param boardDto
     * @return
     * @throws Exception
     */
    public BoardDto getSelectBoardDetail (BoardDto boardDto) throws Exception {
    	return (BoardDto) select("Board#getSelectBoardDetail", boardDto);
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
	
	/**
	 * 게시글 조회수를 증가시킨다.
	 * 
	 * @param boardDto
	 * @return
	 */
	public Object boardHitUpdate(BoardDto boardDto) {
		return update("Board#boardHitUpdate", boardDto);
	}
	/**
	 * 게시글을 수정한다.
	 * 
	 * @param boardDto
	 * @return
	 */
	public int boardUpdate(BoardDto boardDto) {
		return update("Board#boardUpdate", boardDto);
	}
	
	/**
	 * 게시글을 삭제한다.
	 *  
	 * @param boardDto
	 * @return
	 */
	public int boardDelete(BoardDto boardDto) {
		return delete("Board#boardDelete", boardDto);
	}

	/**
	 * 첨부된 파일을 삭제한다.
	 * 
	 * @param boardDto
	 * @return
	 */
	public int attatchDelete(BoardDto boardDto) {
		return delete("Board#boardattatchDelete", boardDto);
	}

	/**
	 * 게시글 삭제후 첨부 파일 삭제 리스트를 조회한다.
	 * 
	 * @param boardDto
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BoardDto> garbageAttatch(BoardDto boardDto) {
		return (List<BoardDto>) list("Board#garbageAttatch", boardDto);
	}

	/**
	 * 첨부 파일을 삭제한다.
	 * 
	 * @param boardDto
	 * @return
	 */
	public int boardFileDelete(BoardDto boardDto) {
		return delete("Board#boardFileDelete", boardDto);
	}

	/**
	 * 첨부 파일 리스트를 조회한다.
	 * 
	 * @param boardDto
	 * @return
	 */
	public BoardDto getAttatch(BoardDto boardDto) {
		return (BoardDto) select("Board#getAttatchList", boardDto);
	}	
}
