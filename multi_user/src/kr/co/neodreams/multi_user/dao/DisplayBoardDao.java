package kr.co.neodreams.multi_user.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.DisplayBoardDto;
import kr.co.neodreams.multi_user.dto.Tbsetcd2Dto;

@Component
public class DisplayBoardDao extends BaseDao{
	
    @SuppressWarnings("unchecked")
    public List<DisplayBoardDto> getMypageDisplayBoardList(DisplayBoardDto displayBoardDto) throws Exception{
        return (List<DisplayBoardDto>) list("DisplayBoard#getMypageDisplayBoardList", displayBoardDto);
    }
    public int getMypageDisplayBoardListCount(DisplayBoardDto displayBoardDto) throws Exception{
        return getCount("DisplayBoard#getMypageDisplayBoardListCount", displayBoardDto);
    }
    public List<Tbsetcd2Dto>  display_categorey_Select(Tbsetcd2Dto tbsetcd2Dto){
		return (List<Tbsetcd2Dto>) list("DisplayBoard#select_categorey",tbsetcd2Dto);
	}
    public List<DisplayBoardDto>  display_Select(DisplayBoardDto displayBoardDto){
		return (List<DisplayBoardDto>) list("DisplayBoard#select_maxnum",displayBoardDto);
	}
    public List<DisplayBoardDto> display_tbSetcd1_Select(DisplayBoardDto displayBoardDto){
		return (List<DisplayBoardDto>) list("DisplayBoard#select_tbsetcd1",  displayBoardDto);
	}
    public Object display_Insert(DisplayBoardDto displayBoardDto) throws Exception{
		return insert("DisplayBoard#insert",displayBoardDto);
	}
    public Object display_File_Insert(DisplayBoardDto displayBoardDto) throws Exception{
		return insert("DisplayBoard#insert_file",displayBoardDto);
	}
    public List<DisplayBoardDto> getDisplayList (DisplayBoardDto displayBoardDto) throws Exception{
		return (List<DisplayBoardDto>) list("DisplayBoard#getContentsList", displayBoardDto);
	}
	public int getDisplayListCnt (DisplayBoardDto displayBoardDto) throws Exception{
		return getCount("DisplayBoard#getContentsListCnt", displayBoardDto);
	}
	public List<DisplayBoardDto> getDisplayDetail (DisplayBoardDto displayBoardDto) throws Exception{
		return (List<DisplayBoardDto>) list("DisplayBoard#getContentsDetail", displayBoardDto);
	}
	public Object display_Update(DisplayBoardDto displayBoardDto) throws Exception{
		return update("DisplayBoard#update", displayBoardDto);
	}
	public Object display_File_Update(DisplayBoardDto displayBoardDto) throws Exception{
		return update("DisplayBoard#update_file",displayBoardDto);
	}
	public Object display_Del(DisplayBoardDto displayBoardDto) throws Exception{
		return update("DisplayBoard#del",displayBoardDto);
	}
	public void display_Approve(DisplayBoardDto displayBoardDto) throws Exception{
		update("DisplayBoard#display_Approve",displayBoardDto);
	}
	public void Display_fileUpdate(DisplayBoardDto displayBoardDto) throws Exception{
		update("DisplayBoard#Display_fileUpdate", displayBoardDto);
		
	}
	@SuppressWarnings("unchecked")
	public List<DisplayBoardDto> contentFileList(DisplayBoardDto displayBoardDto) throws Exception{
		return (List<DisplayBoardDto>) list("DisplayBoard#contentFileList", displayBoardDto);
	}
	public DisplayBoardDto removeDisplayFile(int SDP_SEQ) throws Exception{
		return (DisplayBoardDto) select("DisplayBoard#removeDisplayFile", SDP_SEQ);
	}
	public int diplayFileAjax(int SDP_SEQ) throws Exception{
		return delete("DisplayBoard#diplayFileAjax", SDP_SEQ);
	}
	@SuppressWarnings("unchecked")
	public List<DisplayBoardDto> delfileChk() throws Exception{
		return (List<DisplayBoardDto>) list("DisplayBoard#delfileChk", "");
	}
	public DisplayBoardDto TotalList(DisplayBoardDto displayBoardDto) throws Exception{
		return (DisplayBoardDto) select("DisplayBoard#TotalList", "");
	}
}
