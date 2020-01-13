package kr.co.neodreams.multi_user.service;

import java.util.List;

import kr.co.neodreams.multi_user.dto.NoticeDto;



public interface NoticeService {

	public List<NoticeDto> getNoticeList (NoticeDto noticeDto) throws Exception;
	
	public int getNoticeListCnt (NoticeDto noticeDto) throws Exception;
	
	public NoticeDto getAttatch(NoticeDto noticeDto) throws Exception;
	
	public NoticeDto getNotice (NoticeDto noticeDto) throws Exception;
	
	public int noticeInsert(NoticeDto noticeDto) throws Exception;
	
	public int noticeUpdate(NoticeDto noticeDto) throws Exception;
	
	public int noticeDelete(NoticeDto noticeDto) throws Exception;
	
	public List<NoticeDto> garbageAttatch (NoticeDto noticeDto) throws Exception;
	
	public int noticeFileDelete(NoticeDto noticeDto) throws Exception;
	
}
