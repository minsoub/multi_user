package kr.co.neodreams.multi_user.service;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.dao.MemoDao;
import kr.co.neodreams.multi_user.dto.MemoDto;
import kr.co.neodreams.multi_user.dto.NoticeDto;

@Service
public class MemoServiceImpl implements MemoService {
	@Autowired
	MemoDao memoDao;
	
	/**
	 * 공지사항 리스트 조회
	 * 
	 */
    @Override
    public List<MemoDto> getNoticeList (MemoDto memoDto) throws Exception {
        // TODO Auto-generated method stub
        return memoDao.getNoticeList(memoDto);
    }

    /**
     * 공지사항 게시글 총 개수 조회
     * 
     */
    @Override
    public int getNoticeListCnt(MemoDto memoDto) throws Exception {
        // TODO Auto-generated method stub
        return memoDao.getNoticeListCnt(memoDto);
    }

    /**
     * 공지사항 상세 내용 보기
     * 
     */
    @Override
    public MemoDto getNoticeDetail (String num) throws Exception {
        return memoDao.getNoticeDetail(num);
    }
    
    /**
     * 공지사항 게시글을 등록한다.
     * 
     * @param noticeDto
     * @return
     * @throws Exception
     */
	@Override
	public int noticeInsert(MemoDto memoDto) throws Exception {
				
		int retVal = (int) memoDao.noticeInsert(memoDto);
		// 첨부파일이 있으면 첨부파일도 등록한다. 
		if(retVal > 0) {
			memoDto.setNum(retVal);					// 공지사항 글번호
			int attatchFileChk = noticeAttatchInsert(memoDto);		// 파일 등록
			
			if(attatchFileChk < 0) {
				throw new Exception("-1"); 
			}
		}
		return retVal;
	}
    /**
     * 공지사항을 업데이트 한다.
     * 
     * @param memoDto
     * @return
     * @throws Exception
     */
	@Override
	public int noticeUpdate(MemoDto memoDto) throws Exception {
		int retVal = memoDao.noticeUpdate(memoDto);
		if(retVal > 0) {
			int attatchFileChk = noticeAttatchInsert(memoDto);
			
			if(attatchFileChk < 0) {
				throw new Exception("-1"); 
			}
		}
		return retVal;
	}
	
    /**
     * 공지사항 visited 업데이트 
     * 
     * @param memoDto
     * @return
     * @throws Exception
     */
    public int noticeHitUpdate(MemoDto memoDto) throws Exception
    {
    	return (int) memoDao.noticeHitUpdate(memoDto);    			
    }
    /**
     * 공지사항을 삭제한다.
     * 
     * @param memoDto
     * @return
     * @throws Exception
     */
	@Override
	public int noticeDelete(MemoDto memoDto) throws Exception {
		return memoDao.noticeDelete(memoDto);
	}
    /**
     * 공지사항 파일 업로드에서 가베지를 제거한다. 
     * 
     * @param memoDto
     * @return
     * @throws Exception
     */
	@Override
	public List<MemoDto> garbageAttatch(MemoDto memoDto) throws Exception {
		return memoDao.garbageAttatch(memoDto);
	}
    /**
     * 공지사항 파일을 삭제한다.
     * 
     * @param memoDto
     * @return
     * @throws Exception
     */
	@Override
	public int noticeFileDelete(MemoDto memoDto) throws Exception {
		return memoDao.noticeFileDelete(memoDto);
	}
	
	/**
	 * 공지사항 파일 등록
	 * @param memoDto
	 * @return
	 */
	public int noticeAttatchInsert(MemoDto memoDto) {
		int retVal = 0;
		try {
			if(!"".equals(memoDto.getFreqs().trim())) {	// 등록된 파일 리스트 ('|'으로 연결됨
				StringTokenizer attatchSeqs = new StringTokenizer(memoDto.getFreqs(),"|");
				List<MemoDto> listattatchDto = new ArrayList<>();
				
				int totCnt = attatchSeqs.countTokens();
				for(int i=0; i < totCnt; i++) {
					MemoDto attatchDto = new MemoDto();
					attatchDto.setNum(memoDto.getNum());			// 공지사항 글번호
					attatchDto.setFreq(attatchSeqs.nextToken());	// 파일번호
					attatchDto.setBbsid(memoDto.getBbsid());        // 게시판 구분용도(10030)
					listattatchDto.add(attatchDto);
				}
				
				if(listattatchDto.size() > 0) {
					memoDao.noticeAttatchInsert(listattatchDto);
				}
			}
		}catch (Exception e) {
			retVal = -1;
		}
		return retVal;
	}
    
    /**
     * 파일정보를 리턴한다.
     * 
     * @param memoDto
     * @return
     * @throws Exception
     */
	@Override
	public MemoDto getAttatch(MemoDto memoDto) throws Exception {
		return memoDao.getAttatch(memoDto);
	}    
}
