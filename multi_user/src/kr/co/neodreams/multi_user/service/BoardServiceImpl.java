package kr.co.neodreams.multi_user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.dao.BoardDao;
import kr.co.neodreams.multi_user.dto.BoardDto;

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
}
