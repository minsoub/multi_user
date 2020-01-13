package kr.co.neodreams.multi_user.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.NoticeDto;

@Component
public class NoticeDao extends BaseDao {
	

	@SuppressWarnings("unchecked")
	public List<NoticeDto> getNoticeList(NoticeDto noticeDto) {
		return (List<NoticeDto>) list("Notice#getNoticeList", noticeDto);
	}

	public int getNoticeListCnt(NoticeDto noticeDto) {
		return getCount("Notice#getNoticeListCnt", noticeDto);
	}

	public NoticeDto getNotice(NoticeDto noticeDto) {
		return (NoticeDto) select("Notice#getNotice", noticeDto);
	}

	public Object noticeInsert(NoticeDto noticeDto) {
		return insert("Notice#noticeInsert", noticeDto);
	}

	public Object noticeAttatchInsert(List<NoticeDto> listNoticeDto) {
		return insert("Notice#noticeAttatchInsert", listNoticeDto);
	}
	
	public int noticeUpdate(NoticeDto noticeDto) {
		return update("Notice#noticeUpdate", noticeDto);
	}

	public int noticeDelete(NoticeDto noticeDto) {
		return delete("Notice#noticeDelete", noticeDto);
	}

	public int attatchDelete(NoticeDto noticeDto) {
		return delete("Notice#attatchDelete", noticeDto);
	}

	@SuppressWarnings("unchecked")
	public List<NoticeDto> garbageAttatch(NoticeDto noticeDto) {
		return (List<NoticeDto>) list("Notice#garbageAttatch", noticeDto);
	}

	public int noticeFileDelete(NoticeDto noticeDto) {
		return delete("Notice#noticeFileDelete", noticeDto);
	}

	public NoticeDto getAttatch(NoticeDto noticeDto) {
		return (NoticeDto) select("Notice#getAttatchList", noticeDto);
	}
}
