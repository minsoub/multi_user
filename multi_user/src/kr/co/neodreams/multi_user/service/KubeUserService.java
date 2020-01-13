package kr.co.neodreams.multi_user.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.neodreams.multi_user.dto.KubeDto;



public interface KubeUserService {
	
	public List<HashMap<String, String>> getLeftMenu(String empno) throws Exception;
	
	public List<HashMap<String, String>> getCodeList(String inQuery) throws Exception;
	
	public HashMap<String, String> uploadVideoFile(KubeDto kubeDto, HttpServletRequest request, MultipartHttpServletRequest mRequest) throws Exception;
	
	public String insertVideoUpload(MultipartHttpServletRequest request) throws Exception;
	
	public String updateVideoInfo(MultipartHttpServletRequest request) throws Exception;
	
	public HashMap<String, String> getCategoryInfo(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getDeptInfo(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getCategoryVideoList(KubeDto kubeDto) throws Exception;
	
	public int getCategoryVideoListCnt(KubeDto kubeDto) throws Exception;
	
	public HashMap<String, String> getVideoDetailInfo(KubeDto kubeDto) throws Exception;
	
	public HashMap<String, String> getLastVisitDate(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getVideoTagList(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getVideoRecommendList(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getMyBookMarkChkList(KubeDto kubeDto) throws Exception;
	
	public String insertApproveReqVideo(KubeDto kubeDto, HttpServletRequest request) throws Exception;
	
	public String userActCtrl(KubeDto kubeDto, HttpServletRequest request) throws Exception;
	
	public int insertUserComment(KubeDto kubeDto) throws Exception;
	
	public void deleteUserComment(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getCommentList(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getNewComment(KubeDto kubeDto) throws Exception;
	
	public void insertReportReqV_C(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getHomeList(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getTotalSrhList(KubeDto kubeDto) throws Exception;
	
	public HashMap<String, String> getTotalSrhListCnt(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getSrhCategoryCnt(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getWeeklyList(KubeDto kubeDto) throws Exception;
	
	public int getWeeklyListCnt(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getRecommendedList(KubeDto kubeDto) throws Exception;
	
	public int getRecommendedListCnt(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getRecentlyList(KubeDto kubeDto) throws Exception;
	
	public int getRecentlyListCnt(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getTopList(KubeDto kubeDto) throws Exception;
	
	public int getTopListCnt(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getMyBookMarkList(KubeDto kubeDto) throws Exception;
	
	public int getMyBookMarkListCnt(KubeDto kubeDto) throws Exception;
	
	public String deleteMyBookMarkVideo(KubeDto kubeDto, HttpServletRequest request) throws Exception;
	
	public List<HashMap<String, String>> getMyDownLoadReqList(KubeDto kubeDto) throws Exception;
	
	public int getMyDownLoadReqListCnt(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getMyVideoMgmtList(KubeDto kubeDto) throws Exception;
	
	public int getMyVideoMgmtListCnt(KubeDto kubeDto) throws Exception;

	public String updateMyVideoFlag(KubeDto kubeDto, HttpServletRequest request) throws Exception;
	
	public List<HashMap<String, String>> getMyApproveMgmtList(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getMyVideoApproveSubList(KubeDto kubeDto) throws Exception;
	
	public int getMyApproveMgmtListCnt(KubeDto kubeDto) throws Exception;
	
	public int getTargetPageNum(KubeDto kubeDto) throws Exception;
	
	public String updateMyVideoApproveFlag(KubeDto kubeDto, HttpServletRequest request) throws Exception;
	
	public List<HashMap<String, String>> getMyCommentMgmtList(KubeDto kubeDto) throws Exception;
	
	public int getMyCommentMgmtListCnt(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getCustomtMenu(String empno) throws Exception;
	
	public String insertMyCustomMenu(HttpServletRequest request) throws Exception;
	
	public String insertUpdateElearnVideoUserMap(HashMap<String, String> videoUserInfo) throws Exception;
	
	public HashMap<String, String> getElearnVideoUserInfo(KubeDto kubeDto) throws Exception;
	
	public String getElearnVideoViSeq(String pds_saved_name) throws Exception;
}
