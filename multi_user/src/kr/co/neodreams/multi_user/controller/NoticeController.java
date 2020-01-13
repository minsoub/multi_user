package kr.co.neodreams.multi_user.controller;


import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.DownloadView;
import kr.co.neodreams.multi_user.dto.NoticeDto;
import kr.co.neodreams.multi_user.service.NoticeService;

@RequestMapping("/admin")
@Controller
public class NoticeController extends BaseController{
	
	@Autowired
	DataSourceTransactionManager dataSourceTransactionManager;
	
	@Autowired
	NoticeService noticeService;
	
	@Autowired
	DownloadView dowoloadView;

	@RequestMapping("/noticeList.do")
	public ModelAndView noticeList(HttpServletRequest req, HttpServletResponse res, NoticeDto noticeDto) throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/rent/admin/noticeList");
		
		List<NoticeDto> resultList = noticeService.getNoticeList(noticeDto);
		int listCnt = noticeService.getNoticeListCnt(noticeDto);
		
		mv.addObject("resultList", resultList);
		mv.addObject("totalCnt", listCnt);
		mv.addObject("paging", noticeDto);
		return mv;
	}
	@RequestMapping("/noticeWrite.do")
	public ModelAndView noticeWrite(HttpServletRequest req, HttpServletResponse res, NoticeDto noticeDto) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		List<NoticeDto> noticeList = new ArrayList<>();
		noticeDto.setAttatch_Seq("0");
		noticeList = noticeService.garbageAttatch(noticeDto);
		
		if(noticeList.size() > 0) {
			for(int i=0; i < noticeList.size(); i++) {
				NoticeDto noticeFileDto = new NoticeDto();
				
				noticeFileDto = noticeList.get(i);
				fileDelete(noticeFileDto);
				noticeService.noticeFileDelete(noticeFileDto);
			}
		}
		
		mv.addObject("paging", noticeDto);
		mv.setViewName("/rent/admin/noticeWrite");
		return mv;
	}

	@RequestMapping("/noticeDetail.do")
	public ModelAndView noticeDetail(HttpServletRequest req, HttpServletResponse res, NoticeDto noticeDto) throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/rent/admin/noticeDetail");
		NoticeDto resultDetail = new NoticeDto();
		resultDetail = noticeService.getNotice(noticeDto);
		mv.addObject("paging", noticeDto);
		mv.addObject("resultDetail", resultDetail);
		return mv;
	}

	@RequestMapping("/noticeUpdate.do")
	public ModelAndView noticeUpdate(HttpServletRequest req, HttpServletResponse res, NoticeDto noticeDto) throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/rent/admin/noticeUpdate");
		NoticeDto resultDetail = new NoticeDto();
		resultDetail = noticeService.getNotice(noticeDto);
		mv.addObject("resultDetail", resultDetail);
		mv.addObject("paging", noticeDto);
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("/registNotice.do")
	public void registNotice(HttpServletRequest req, HttpServletResponse res, NoticeDto noticeDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			noticeDto.setWrite_User(SESS_EMPNO);
			noticeDto.setWrite_User_Name(SESS_USER_NAME);
			retVal = Integer .toString(noticeService.noticeInsert(noticeDto));
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}

	@ResponseBody
	@RequestMapping("/modifyNotice.do")
	public void modifyNotice(HttpServletRequest req, HttpServletResponse res, NoticeDto noticeDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			retVal = Integer.toString(noticeService.noticeUpdate(noticeDto));
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}

	@ResponseBody
	@RequestMapping("/removeNotice.do")
	public void removeNotice(HttpServletRequest req, HttpServletResponse res, NoticeDto noticeDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			int fileChk = fileDelete(noticeDto);
			
			if(fileChk > 0) {
				retVal = Integer.toString(noticeService.noticeFileDelete(noticeDto));
				retVal = Integer.toString(noticeService.noticeDelete(noticeDto));
			}else {
				throw new Exception("-1"); 
			}
			
			
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}
	
	@ResponseBody
	@RequestMapping("/removeAttatch.do")
	public void removeAttatch(HttpServletRequest req, HttpServletResponse res, NoticeDto noticeDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			int fileChk = fileDelete(noticeDto);
			
			if(fileChk > 0) {
				retVal = Integer.toString(noticeService.noticeFileDelete(noticeDto));
			}else {
				throw new Exception("-1"); 
			}
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}
	
	
	public int fileDelete(NoticeDto noticeDto) throws Exception{
		int retVal = 0;
		
		try {
			List<NoticeDto> noticeList = new ArrayList<>();
			noticeList = noticeService.garbageAttatch(noticeDto);
			
			for(int i=0; i < noticeList.size(); i++) {
				NoticeDto getFileDto = new NoticeDto();
				
				getFileDto = noticeList.get(i);
				
				if(!"".equals(getFileDto.getAttatch_PhyPath())){
					File file = new File(getFileDto.getAttatch_PhyPath());
					if(file.exists()) {
						file.delete();
					}
				}
			}	
			retVal = 1;
		}catch(Exception e) {
			retVal = -1;
		}	
		return retVal;
	}
	

	@RequestMapping("/noticeFileDown")
	public ModelAndView taskAttFileDown(HttpServletRequest req, NoticeDto noticeDto) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		try{
			
			String file_Name = "";
			String file_Path = "";
			
			NoticeDto getFileDto = new NoticeDto();
			getFileDto = noticeService.getAttatch(noticeDto);
			
			if(!"".equals(getFileDto.getAttatch_OrgName())) {
				file_Name = getFileDto.getAttatch_OrgName();
				file_Path = getFileDto.getAttatch_PhyPath();
			}
			File downloadFile = new File(file_Path);
			mv.setView(dowoloadView);
			mv.addObject("downloadFile", downloadFile);
			mv.addObject("fileName", file_Name);
			
		}catch (Exception e) {
		}finally {}
		
		return mv;
	}
}
