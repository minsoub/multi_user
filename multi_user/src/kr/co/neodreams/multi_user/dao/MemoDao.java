package kr.co.neodreams.multi_user.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.BoardDto;
import kr.co.neodreams.multi_user.dto.MemoDto;
import kr.co.neodreams.multi_user.dto.NoticeDto;

/**
 * 공지사항 데이터베이스 처리 클래스
 * 
 * @author minso
 *
 */
@Component
public class MemoDao extends BaseDao {

	/**
	 * 공지사항 리스트 조회
	 * 
	 * @param commonDto
	 * @return
	 * @throws Exception
	 */
    @SuppressWarnings("unchecked")
    public List<MemoDto> getNoticeList (MemoDto commonDto)  throws Exception{
        return (List<MemoDto>) list("Memo#getNoticeList", commonDto);
    }

    /**
     * 공지사항 총 개수 조회
     * 
     * @param commonDto
     * @return
     * @throws Exception
     */
    public int getNoticeListCnt (MemoDto commonDto) throws Exception{
        return getCount("Memo#getNoticeListCnt", commonDto);
    }

    /**
     * 공지사항 상세 내용 보기
     * 
     * @param num
     * @return
     * @throws Exception
     */
    public MemoDto getNoticeDetail (String num) throws Exception{
        return (MemoDto) select("Memo#getNoticeDetail", num);
    }

    /**
     * 공지사항 게시글을 등록한다.
     * 
     * @param memoDto
     * @return
     */
	public Object noticeInsert(MemoDto memoDto) {
		return insert("Memo#noticeInsert", memoDto);
	}
	
	/**
	 * 공지사항 첨부파일을 등록한다.
	 * 
	 * @param listMemoDto
	 * @return
	 */
	public Object noticeAttatchInsert(List<MemoDto> listMemoDto) {
		return insert("Memo#noticeAttatchInsert", listMemoDto);
	}
	
	/**
	 * 게시글을 수정한다.
	 * 
	 * @param memoDto
	 * @return
	 */
	public int noticeUpdate(MemoDto memoDto) {
		return update("Memo#noticeUpdate", memoDto);
	}
	
	/**
	 * 게시글을 삭제한다.
	 *  
	 * @param memoDto
	 * @return
	 */
	public int noticeDelete(MemoDto memoDto) {
		return delete("Memo#noticeDelete", memoDto);
	}
	/**
	 * 게시글 조회수를 증가시킨다.
	 * 
	 * @param memoDto
	 * @return
	 */
	public Object noticeHitUpdate(MemoDto memoDto) {
		return update("Memo#noticeHitUpdate", memoDto);
	}
	/**
	 * 첨부된 파일을 삭제한다.
	 * 
	 * @param memoDto
	 * @return
	 */
	public int attatchDelete(MemoDto memoDto) {
		return delete("Memo#noticeattatchDelete", memoDto);
	}

	/**
	 * 게시글 삭제후 첨부 파일 삭제 리스트를 조회한다.
	 * 
	 * @param memoDto
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<MemoDto> garbageAttatch(MemoDto memoDto) {
		return (List<MemoDto>) list("Memo#garbageAttatch", memoDto);
	}

	/**
	 * 첨부 파일을 삭제한다.
	 * 
	 * @param memoDto
	 * @return
	 */
	public int noticeFileDelete(MemoDto memoDto) {
		return delete("Memo#noticeFileDelete", memoDto);
	}
	
	/**
	 * 첨부 파일 리스트를 조회한다.
	 * 
	 * @param memoDto
	 * @return
	 */
	public MemoDto getAttatch(MemoDto memoDto) {
		return (MemoDto) select("Memo#getAttatchList", memoDto);
	}
	
	/**
	 * 관리자 상태 값 업데이트 
	 * 
	 * @param memoDto
	 * @return
	 */
	public int MemoStsUpdate(MemoDto memoDto) {
		return update("Memo#boardStsUpdate", memoDto);
	}	
}
