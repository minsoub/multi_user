package kr.co.neodreams.multi_user.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.ContentsDto;
import kr.co.neodreams.multi_user.dto.ContentsFileDto;
import kr.co.neodreams.multi_user.dto.ImgBoardDto;
import kr.co.neodreams.multi_user.dto.Tbsetcd1Dto;
import kr.co.neodreams.multi_user.dto.Tbsetcd2Dto;
import kr.co.neodreams.multi_user.dto.Tbsvc_tdmsempDto;

@Component
public class ContentsDao extends BaseDao{
	
	/*등록화면*/
	public List<Tbsetcd2Dto>  contents_categorey_Select(Tbsetcd2Dto tbsetcd2Dto){
		return (List<Tbsetcd2Dto>) list("Contents#select_categorey",tbsetcd2Dto);
	}
	
	/*저장*/
	public List<ContentsDto>  contents_Select(ContentsDto contentsDto){
		return (List<ContentsDto>) list("Contents#select_maxnum",contentsDto);
	}
	
	public List<ContentsDto> contents_tbSetcd1_Select(ContentsDto contentsDto){
		return (List<ContentsDto>) list("Contents#select_tbsetcd1",  contentsDto);
	}
	
	public Object contents_Insert(ContentsDto contensDto) throws Exception{
		return insert("Contents#insert",contensDto);
	}
	
	public Object contents_File_Insert(ContentsFileDto contentsFileDto) throws Exception{
		return insert("Contents#insert_file",contentsFileDto);
	}
	
    @SuppressWarnings("unchecked")
    public List<ContentsDto> getMypageContentsList(ContentsDto contensDto) throws Exception{
        return (List<ContentsDto>) list("Contents#getMypageContentsList", contensDto);
    }
    
    public int getMypageContentsListCount(ContentsDto contensDto) throws Exception{
        return getCount("Contents#getMypageContentsListCount", contensDto);
    }
    
    public List<ContentsDto> getContentsList (ContentsDto contentsDto) throws Exception{
		return (List<ContentsDto>) list("Contents#getContentsList", contentsDto);
	}
	public int getContentsListCnt (ContentsDto contentsDto) throws Exception{
		return getCount("Contents#getContentsListCnt", contentsDto);
	}
	
	public List<ContentsDto> getContentsDetail (ContentsDto contentsDto) throws Exception{
		return (List<ContentsDto>) list("Contents#getContentsDetail", contentsDto);
	}
	
	public List<ContentsDto> getContentsCount (ContentsDto contentsDto) throws Exception{
		return (List<ContentsDto>) list("Contents#getContentsCount", contentsDto);
	}
	
	public Object contents_Update(ContentsDto contentsDto) throws Exception{
		return update("Contents#update", contentsDto);
	}
	
	public Object contents_File_Update(ContentsDto contentsDto) throws Exception{
		return update("Contents#update_file",contentsDto);
	}
	
	public Object contents_Del(ContentsDto contentsDto) throws Exception{
		return update("Contents#del",contentsDto);
	}

	@SuppressWarnings("unchecked")
	public List<ImgBoardDto> getImgBrdList(ImgBoardDto imgBoardDto) {
		return (List<ImgBoardDto>) list("Contents#getImgBrdList", imgBoardDto);
	}

	public int getImgBrdListCnt(ImgBoardDto imgBoardDto) {
		return getCount("Contents#getImgBrdListCnt", imgBoardDto);
	}

	@SuppressWarnings("unchecked")
	public List<ImgBoardDto> garbageAttatch(ImgBoardDto imgBoardDto) {
		return (List<ImgBoardDto>) list("Contents#garbageAttatch", imgBoardDto);
	}

	public Object imgBrdInsert(ImgBoardDto imgBoardDto) {
		return insert("Contents#imgBrdInsert", imgBoardDto);
	}

	public ImgBoardDto getImgBrd(ImgBoardDto imgBoardDto) {
		return (ImgBoardDto) select("Contents#getImgBrd", imgBoardDto);
	}

	public int imgBrdDelete(ImgBoardDto imgBoardDto) {
		return delete("Contents#imgBrdDelete", imgBoardDto);
	}

	public int imgBrdFileDelete(ImgBoardDto imgBoardDto) {
		return delete("Contents#imgBrdFileDelete", imgBoardDto);
	}

	public int noticeUpdate(ImgBoardDto imgBoardDto) {
		return update("Contents#imgBrdUpdate", imgBoardDto);
	}

	public ImgBoardDto getAttatch(ImgBoardDto imgBoardDto) {
		return (ImgBoardDto) select("Contents#getAttatchList", imgBoardDto);
	}

	public Object imgBrdAttatchInsert(List<ImgBoardDto> listattatchDto) {
		return insert("Contents#imgBrdAttatchInsert", listattatchDto);
	}

	@SuppressWarnings("unchecked")
	public List<Tbsetcd2Dto> svc2Cnt() throws Exception {
		return (List<Tbsetcd2Dto>) list("Contents#svc2Cnt", "");
	}

	@SuppressWarnings("unchecked")
	public List<ContentsDto> acceptList(ContentsDto contentsDto) throws Exception {
		return  (List<ContentsDto>) list("Contents#acceptList", contentsDto);
	}

	public int acceptListCnt(ContentsDto contentsDto) throws Exception {
		return getCount("Contents#acceptListCnt", contentsDto);
	}

	@SuppressWarnings("unchecked")
	public List<Tbsvc_tdmsempDto> userImp(Tbsvc_tdmsempDto tbsvc_tdmsempDto) throws Exception{
		return (List<Tbsvc_tdmsempDto>) select("Contents#User_imp", tbsvc_tdmsempDto);
	}

	public Tbsvc_tdmsempDto userImp(String strEmpNo) throws Exception{
		return (Tbsvc_tdmsempDto) select("Contents#userImp", strEmpNo);
	}

	public int registAcceptAjax(ContentsDto contentsDto) throws Exception{
		return (int) insert("Contents#registAcceptAjax",contentsDto);
	}

	public ContentsDto acceptUpdate(ContentsDto contentsDto) throws Exception{
		return (ContentsDto) select("Contents#acceptUpdate", contentsDto);
	}

	public void statusUpdate(int AC_SEQ) throws Exception {
		update("Contents#statusUpdate", AC_SEQ);
	}

	public int updateAcceptAjax(ContentsDto contentsDto) throws Exception {
		return update("Contents#updateAcceptAjax", contentsDto);
	}

	public ContentsDto accptContents() throws Exception {
		return (ContentsDto) select("Contents#accptContents", "");
	}

	@SuppressWarnings("unchecked")
	public List<Tbsetcd1Dto> companyList() throws Exception {
		return (List<Tbsetcd1Dto>) list("Contents#companyList", "");
	}

	@SuppressWarnings("unchecked")
	public List<Tbsetcd2Dto> serviceList() throws Exception {
		return (List<Tbsetcd2Dto>) list("Contents#serviceList", "");
	}

	@SuppressWarnings("unchecked")
	public List<Tbsetcd2Dto> confrimList() throws Exception {
		return (List<Tbsetcd2Dto>) list("Contents#confrimList", "");
	}

	@SuppressWarnings("unchecked")
	public List<Tbsetcd2Dto> serviceEndList() throws Exception {
		return (List<Tbsetcd2Dto>) list("Contents#serviceEndList", "");
	}

	@SuppressWarnings("unchecked")
	public List<Tbsetcd1Dto> dataList() throws Exception {
		return (List<Tbsetcd1Dto>) list("Contents#dataList", "");
	}

	public void Contents_fileUpdate(ContentsDto contentsDto) throws Exception {
		update("Contents#Contents_fileUpdate", contentsDto);
	}

	@SuppressWarnings("unchecked")
	public List<ContentsDto> contentFileList(ContentsDto contentsDto) throws Exception {
		return (List<ContentsDto>) list("Contents#contentFileList", contentsDto);
	}

	public ContentsDto removeContentsFile(int SCF_SEQ) throws Exception {
		return (ContentsDto) select("Contents#removeContentsFile", SCF_SEQ);
	}

	public int ContentsFileAjax(int SCF_SEQ) throws Exception {
		return delete("Contents#ContentsFileAjax", SCF_SEQ);
	}

	public void contentsApprove(ContentsDto contentsDto) throws Exception{
		update("Contents#contentsApprove",contentsDto);
	}

	@SuppressWarnings("unchecked")
	public List<ContentsDto> delfileChk() throws Exception{
		return (List<ContentsDto>) list("Contents#delfileChk", "");
	}
	
}
