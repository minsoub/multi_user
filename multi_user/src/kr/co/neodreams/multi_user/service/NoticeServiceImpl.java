package kr.co.neodreams.multi_user.service;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.base.service.BaseService;
import kr.co.neodreams.multi_user.dao.NoticeDao;
import kr.co.neodreams.multi_user.dto.NoticeDto;

@Service
public class NoticeServiceImpl extends BaseService implements NoticeService{

	@Autowired
	NoticeDao noticeDao;

	@Override
	public List<NoticeDto> getNoticeList(NoticeDto noticeDto) throws Exception {
		return noticeDao.getNoticeList(noticeDto);
	}

	@Override
	public int getNoticeListCnt(NoticeDto noticeDto) throws Exception {
		return noticeDao.getNoticeListCnt(noticeDto);
	}

	@Override
	public NoticeDto getNotice(NoticeDto noticeDto) throws Exception {
		return noticeDao.getNotice(noticeDto);
	}

	@Override
	public int noticeInsert(NoticeDto noticeDto) throws Exception {
		int retVal = (int) noticeDao.noticeInsert(noticeDto);
		if(retVal > 0) {
			noticeDto.setNotice_Seq(retVal);
			int attatchFileChk = noticeAttatchInsert(noticeDto);
			
			if(attatchFileChk < 0) {
				throw new Exception("-1"); 
			}
		}
		return retVal;
	}

	@Override
	public int noticeUpdate(NoticeDto noticeDto) throws Exception {
		int retVal = noticeDao.noticeUpdate(noticeDto);
		if(retVal > 0) {
			int attatchFileChk = noticeAttatchInsert(noticeDto);
			
			if(attatchFileChk < 0) {
				throw new Exception("-1"); 
			}
		}
		return retVal;
	}

	@Override
	public int noticeDelete(NoticeDto noticeDto) throws Exception {
		return noticeDao.noticeDelete(noticeDto);
	}

	@Override
	public List<NoticeDto> garbageAttatch(NoticeDto noticeDto) throws Exception {
		return noticeDao.garbageAttatch(noticeDto);
	}

	@Override
	public int noticeFileDelete(NoticeDto noticeDto) throws Exception {
		return noticeDao.noticeFileDelete(noticeDto);
	}
	
	public int noticeAttatchInsert(NoticeDto noticeDto) {
		int retVal = 0;
		try {
			if(!"".equals(noticeDto.getAttatch_Seqs().trim())) {
				StringTokenizer attatchSeqs = new StringTokenizer(noticeDto.getAttatch_Seqs(),"|");
				List<NoticeDto> listattatchDto = new ArrayList<>();
				
				int totCnt = attatchSeqs.countTokens();
				for(int i=0; i < totCnt; i++) {
					NoticeDto attatchDto = new NoticeDto();
					attatchDto.setNotice_Seq(noticeDto.getNotice_Seq());
					attatchDto.setAttatch_Seq(attatchSeqs.nextToken());
					listattatchDto.add(attatchDto);
				}
				
				if(listattatchDto.size() > 0) {
					noticeDao.noticeAttatchInsert(listattatchDto);
				}
			}
		}catch (Exception e) {
			retVal = -1;
		}
		return retVal;
	}

	@Override
	public NoticeDto getAttatch(NoticeDto noticeDto) throws Exception {
		return noticeDao.getAttatch(noticeDto);
	}
}
