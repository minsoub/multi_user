package kr.co.neodreams.multi_user.service;

import java.util.List;

import kr.co.neodreams.multi_user.dto.CommonDto;
import kr.co.neodreams.multi_user.dto.MemoDto;
import kr.co.neodreams.multi_user.dto.NoticeDto;

/**
 * 공지사항 관련 인터페이스 클래스 
 * 
 * @author minso
 *
 */
public interface MemoService {
	
	/**
	 * 공지사항 리스트 조회
	 * 
	 * @param commonDto
	 * @return
	 * @throws Exception
	 */
    public List<MemoDto> getNoticeList (MemoDto commonDto) throws Exception;

    /**
     * 공지사항 작성 글 총 개수 조회
     * @param commonDto
     * @return
     * @throws Exception
     */
    public int getNoticeListCnt (MemoDto commonDto) throws Exception;

    /**
     * 공지사항 세부 내용 보기
     * 
     * @param num
     * @return
     * @throws Exception
     */
    public MemoDto getNoticeDetail (String num) throws Exception;
    
    /**
     * 공지사항 게시글을 등록한다.
     * 
     * @param noticeDto
     * @return
     * @throws Exception
     */
    public int noticeInsert(MemoDto memoDto) throws Exception;
    
    /**
     * 공지사항을 업데이트 한다.
     * 
     * @param memoDto
     * @return
     * @throws Exception
     */
    public int noticeUpdate(MemoDto memoDto) throws Exception;
    
    /**
     * 공지사항 visited 업데이트 
     * 
     * @param memoDto
     * @return
     * @throws Exception
     */
    public int noticeHitUpdate(MemoDto memoDto) throws Exception;
    
    /**
     * 공지사항을 삭제한다.
     * 
     * @param memoDto
     * @return
     * @throws Exception
     */
    public int noticeDelete(MemoDto memoDto) throws Exception;
    
    /**
     * 공지사항 파일 업로드에서 가베지를 제거한다. 
     * 
     * @param memoDto
     * @return
     * @throws Exception
     */
    public List<MemoDto> garbageAttatch(MemoDto memoDto) throws Exception;
    
    /**
     * 공지사항 파일을 삭제한다.
     * 
     * @param memoDto
     * @return
     * @throws Exception
     */
    public int noticeFileDelete(MemoDto memoDto) throws Exception;
    
    /**
     * 파일정보를 리턴한다.
     * 
     * @param memoDto
     * @return
     * @throws Exception
     */
    public MemoDto getAttatch(MemoDto memoDto) throws Exception;
}
