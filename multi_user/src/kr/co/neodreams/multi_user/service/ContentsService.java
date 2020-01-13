package kr.co.neodreams.multi_user.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import kr.co.neodreams.multi_user.dto.ContentsDto;
import kr.co.neodreams.multi_user.dto.ImgBoardDto;
import kr.co.neodreams.multi_user.dto.Tbsetcd1Dto;
import kr.co.neodreams.multi_user.dto.Tbsetcd2Dto;
import kr.co.neodreams.multi_user.dto.Tbsvc_tdmsempDto;

public interface ContentsService {
	public List<Tbsetcd2Dto> contents_categorey_Select(Tbsetcd2Dto tbsetcd2Dto) throws Exception;
	public boolean contens_Select(ContentsDto contentsDto) throws Exception;
	public boolean contens_Insert(ContentsDto contentsDto ,JSONObject jsonObject) throws Exception;
	/** 컨텐츠 제작 신청내역 취득 */
	public Map<String, Object> getMypageContentsList(ContentsDto contentsDto) throws Exception;
	public List<ContentsDto> getContentsList (ContentsDto contentsDto) throws Exception;
	public int getContentsListCnt (ContentsDto contentsDto) throws Exception;
	public List<ContentsDto> getContentsDetail (ContentsDto contentsDto) throws Exception;
	public List<ContentsDto> getContentsCount (ContentsDto contentsDto) throws Exception;
	public boolean contents_Update(ContentsDto contentsDto, JSONObject jsonObject) throws Exception;
	public boolean contents_Del(ContentsDto contentsDto) throws Exception;
	
	/* 이미지 자료실 */
	public List<ImgBoardDto> getImgBrdList (ImgBoardDto imgBoardDto) throws Exception;
	public int getImgBrdListCnt (ImgBoardDto imgBoardDto) throws Exception;
	public ImgBoardDto getAttatch(ImgBoardDto imgBoardDto) throws Exception;
	public ImgBoardDto getImgBrd (ImgBoardDto imgBoardDto) throws Exception;
	public int imgBrdInsert(ImgBoardDto imgBoardDto) throws Exception;
	public int imgBrdUpdate(ImgBoardDto imgBoardDto) throws Exception;
	public int imgBrdDelete(ImgBoardDto imgBoardDto) throws Exception;
	public List<ImgBoardDto> garbageAttatch (ImgBoardDto imgBoardDto) throws Exception;
	public int imgBrdFileDelete(ImgBoardDto imgBoardDto) throws Exception;
	public List<Tbsetcd2Dto> svc2Cnt() throws Exception;
	
	/*컨텐츠제작*/
	public List<ContentsDto> acceptList(ContentsDto contentsDto) throws Exception;
	public int acceptListCnt(ContentsDto contentsDto) throws Exception;
	public Tbsvc_tdmsempDto userImp(String strEmpNo) throws Exception;
	public int registAcceptAjax(ContentsDto contentsDto) throws Exception;
	public ContentsDto acceptUpdate(ContentsDto contentsDto) throws Exception;
	public void statusUpdate(int AC_SEQ) throws Exception;
	public int updateAcceptAjax(ContentsDto contentsDto) throws Exception;
	public ContentsDto accptContents() throws Exception;
	public List<Tbsetcd1Dto> companyList() throws Exception;
	public List<Tbsetcd2Dto> serviceList() throws Exception;
	public List<Tbsetcd2Dto> confrimList() throws Exception;
	public List<Tbsetcd2Dto> serviceEndList() throws Exception;
	public List<Tbsetcd1Dto> dataList() throws Exception;
	public List<ContentsDto> contentFileList(ContentsDto contentsDto) throws Exception;
	public ContentsDto removeContentsFile(int SCF_SEQ) throws Exception;
	public int ContentsFileAjax (int SCF_SEQ) throws Exception;
	public boolean modifyConfirmAjax(ContentsDto contentsDto) throws Exception;
	public boolean contentsApprove(ContentsDto contentsDto) throws Exception;
	public void completeFile(ContentsDto contentsDto) throws Exception;
	public void origqtyUpdate(ContentsDto contentsDto) throws Exception;
	public void lstateUpdate(ContentsDto contentsDto) throws Exception;
	public List<ContentsDto> delfileChk() throws Exception;
	public byte[] excelDown(Map<String, Object> commandMap, HttpServletRequest req, HttpServletResponse res)throws Exception;

	
}
