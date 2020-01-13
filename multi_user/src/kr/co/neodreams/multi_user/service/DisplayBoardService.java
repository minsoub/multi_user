package kr.co.neodreams.multi_user.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import kr.co.neodreams.multi_user.dto.DisplayBoardDto;
import kr.co.neodreams.multi_user.dto.Tbsetcd2Dto;

public interface DisplayBoardService {
	/** 전광판 제작 신청내역 취득 */
	public Map<String, Object> getMypageDisplayBoardList(DisplayBoardDto displayBoardDto) throws Exception;
	public List<Tbsetcd2Dto> display_categorey_Select(Tbsetcd2Dto tbsetcd2Dto) throws Exception;
	public boolean display_Insert(DisplayBoardDto displayBoardDto ,JSONObject jsonObject) throws Exception;
	public List<DisplayBoardDto> getDisplayList(DisplayBoardDto displayBoardDto) throws Exception;
	public int getDisplayListCnt (DisplayBoardDto displayBoardDto) throws Exception;
	public List<DisplayBoardDto> getDisplayDetail (DisplayBoardDto displayBoardDto) throws Exception;
	public boolean display_Update(DisplayBoardDto displayBoardDto, JSONObject jsonObject) throws Exception;
	public boolean display_Del(DisplayBoardDto displayBoardDto) throws Exception;
	public boolean display_Approve(DisplayBoardDto displayBoardDto) throws Exception;
	public List<DisplayBoardDto> contentFileList(DisplayBoardDto displayBoardDto) throws Exception;
	public DisplayBoardDto removeDisplayFile(int sDP_SEQ) throws Exception;
	public int diplayFileAjax(int SDP_SEQ) throws Exception;
	public void completeFile(DisplayBoardDto displayBoardDto) throws Exception;
	public void lstateUpdate(DisplayBoardDto displayBoardDto) throws Exception;
	public List<DisplayBoardDto> delfileChk() throws Exception;
	public byte[] excelDown(Map<String, Object> commandMap, HttpServletRequest req, HttpServletResponse res) throws Exception;
	public DisplayBoardDto TotalList(DisplayBoardDto displayBoardDto) throws Exception;
}
