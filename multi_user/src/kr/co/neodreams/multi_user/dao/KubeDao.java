package kr.co.neodreams.multi_user.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import kr.co.neodreams.multi_user.dto.KubeDto;

@Component
public class KubeDao extends BaseDao {

	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getLeftMenu(String empno) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getLeftMenu", empno);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getMainLayerInfo() throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getMainLayerInfo", "");
	}
	
	public void insertMainMgmt(ArrayList<KubeDto> kubeDtos) throws Exception {
		insert ("Kube#insertMainMgmt", kubeDtos);
	}
	
	public void deleteMainMgmt(ArrayList<KubeDto> kubeDtos) throws Exception {
		update ("Kube#deleteMainMgmt", kubeDtos);
	}
	
	public void updateMainMgmt(HashMap<String, ArrayList<KubeDto>> map) throws Exception {
		update ("Kube#updateMainMgmt", map);
	}
	
	public void insertCode(KubeDto kubeDto) throws Exception {
		insert ("Kube#insertCode", kubeDto);
	}
	
	public void updateCode(KubeDto kubeDto) throws Exception {
		update ("Kube#updateCode", kubeDto);
	}
	
	public void deleteCode(KubeDto kubeDto) throws Exception {
		update ("Kube#deleteCode", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getCodeList(String inQuery) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getCodeList", inQuery);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getCategoryCode(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getCategoryCode", kubeDto);
	}
	
	public int insertVideoUpload(KubeDto kubeDto) throws Exception {
		return (int) insert ("Kube#insertVideoUpload", kubeDto);
	}
	
	public void updateVideoInfo(KubeDto kubeDto) throws Exception {
		update ("Kube#updateVideoInfo", kubeDto);
	}
	
	public void insertVideoThumb(ArrayList<KubeDto> kubeDtos) throws Exception {
		insert ("Kube#insertVideoThumb", kubeDtos);
	}
	
	public void updateKubeTVMContents(HashMap<String, String> dataMap) throws Exception {
		update ("Kube#updateKubeTVMContents", dataMap);
	}
	
	public void insertTagInfo(ArrayList<HashMap<String, String>> dataMap) throws Exception {
		insert ("Kube#insertTagInfo", dataMap);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, String> getCategoryInfo(KubeDto kubeDto) throws Exception {
		return (HashMap<String, String>) select ("Kube#getCategoryInfo", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getDeptInfo(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getDeptInfo", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getCategoryVideoList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getCategoryVideoList", kubeDto);
	}
	
	public int getCategoryVideoListCnt(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getCategoryVideoListCnt", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, String> getVideoDetailInfo(KubeDto kubeDto) throws Exception {
		return (HashMap<String, String>) select ("Kube#getVideoDetailInfo", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, String> getLastVisitDate(KubeDto kubeDto) throws Exception {
		return (HashMap<String, String>) select ("Kube#getLastVisitDate", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getVideoTagList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getVideoTagList", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getVideoRecommendList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getVideoRecommendList", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getMyBookMarkChkList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getMyBookMarkChkList", kubeDto);
	}
	
	public void insertApproveReqVideo(KubeDto kubeDto) throws Exception {
		insert ("Kube#insertApproveReqVideo", kubeDto);
	}
	
	public void insertVideoHistory(KubeDto kubeDto) throws Exception {
		insert ("Kube#insertVideoHistory", kubeDto);
	}
	
	public void updateVideoSubInfo(KubeDto kubeDto) throws Exception {
		update ("Kube#updateVideoSubInfo", kubeDto);
	}
	
	public void insertMyActMgmt(KubeDto kubeDto) throws Exception {
		insert ("Kube#insertMyActMgmt", kubeDto);
	}
	
	public void deleteMyActMgmt(KubeDto kubeDto) throws Exception {
		delete ("Kube#deleteMyActMgmt", kubeDto);
	}
	
	public int insertUserComment(KubeDto kubeDto) throws Exception {
		return (int) insert ("Kube#insertUserComment", kubeDto);
	}
	
	public void deleteUserComment(KubeDto kubeDto) throws Exception {
		update ("Kube#deleteUserComment", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getCommentList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getCommentList", kubeDto);
	}
	
	public void updateKube_video_commentCnt(KubeDto kubeDto) throws Exception {
		update ("Kube#updateKube_video_commentCnt", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getNewComment(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getNewComment", kubeDto);
	}
	
	public void insertReportReqV_C(KubeDto kubeDto) throws Exception {
		insert ("Kube#insertReportReqV_C", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getHomeList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getHomeList", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getTotalSrhList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getTotalSrhList", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, String> getTotalSrhListCnt(KubeDto kubeDto) throws Exception {
		return (HashMap<String, String>) select ("Kube#getTotalSrhListCnt", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getSrhCategoryCnt(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getSrhCategoryCnt", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getWeeklyList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getWeeklyList", kubeDto);
	}
	
	public int getWeeklyListCnt(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getWeeklyListCnt", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getRecommendedList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getRecommendedList", kubeDto);
	}
	
	public int getRecommendedListCnt(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getRecommendedListCnt", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getRecentlyList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getRecentlyList", kubeDto);
	}
	
	public int getRecentlyListCnt(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getRecentlyListCnt", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getTopList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getTopList", kubeDto);
	}
	
	public int getTopListCnt(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getTopListCnt", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getMyBookMarkList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getMyBookMarkList", kubeDto);
	}
	
	public int getMyBookMarkListCnt(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getMyBookMarkListCnt", kubeDto);
	}
	 
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getMyDownLoadReqList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getMyDownLoadReqList", kubeDto);
	}
	
	public int getMyDownLoadReqListCnt(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getMyDownLoadReqListCnt", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getMyVideoMgmtList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getMyVideoMgmtList", kubeDto);
	}
	
	public int getMyVideoMgmtListCnt(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getMyVideoMgmtListCnt", kubeDto);
	}
	
	public void updateVideoStatus(KubeDto kubeDto) throws Exception {
		update ("Kube#updateVideoStatus", kubeDto);
	}
	
	public void updateApproveStatus(KubeDto kubeDto) throws Exception {
		update ("Kube#updateApproveStatus", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getMyApproveMgmtList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getMyApproveMgmtList", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getMyVideoApproveSubList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getMyVideoApproveSubList", kubeDto);
	}
	
	public int getMyApproveMgmtListCnt(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getMyApproveMgmtListCnt", kubeDto);
	}
	
	public int getTargetPageNum(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getTargetPageNum", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getMyCommentMgmtList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getMyCommentMgmtList", kubeDto);
	}
	
	public int getMyCommentMgmtListCnt(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getMyCommentMgmtListCnt", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getReportList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getReportList", kubeDto);
	}
	
	public int getReportListCnt(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getReportListCnt", kubeDto);
	}
	
	public void updateReport(KubeDto kubeDto) throws Exception {
		update ("Kube#updateReport", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getVideoList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getVideoList", kubeDto);
	}
	
	public int getVideoListCnt(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getVideoListCnt", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getVideoListXls(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getVideoListXls", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getUserStatisticsList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getUserStatisticsList", kubeDto);
	}
	
	public int getUserStatisticsListCnt(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getUserStatisticsListCnt", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getSaList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getSaList", kubeDto);
	}
	
	public void deleteKubeSa(KubeDto kubeDto) throws Exception {
		update ("Kube#deleteKubeSa", kubeDto);
	}
	
	public void insertKubeSa(KubeDto kubeDto) throws Exception {
		update ("Kube#insertKubeSa", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getUserList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getUserList", kubeDto);
	}
	
	public int getUserListCnt(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getUserListCnt", kubeDto);
	}

	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getCustomtMenu(String empno) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getCustomtMenu", empno);
	}
	
	public void deleteUserMenuInfo(String empno) throws Exception {
		delete ("Kube#deleteUserMenuInfo", empno);
	}
	
	public void insertUserMenuInfo(String empno) throws Exception {
		insert ("Kube#insertUserMenuInfo", empno);
	}
	
	public void updateUserMenuInfo(HashMap<String, String> userMenuMap) throws Exception {
		update ("Kube#updateUserMenuInfo", userMenuMap);
	}
	
	public void insertUpdateElearnVideoUserMap(HashMap<String, String> videoUserInfo) throws Exception {
		update ("Kube#insertUpdateElearnVideoUserMap", videoUserInfo);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, String> getElearnVideoUserInfo(KubeDto kubeDto) throws Exception {
		return (HashMap<String, String>) select ("Kube#getElearnVideoUserInfo", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getElearnStatList(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getElearnStatList", kubeDto);
	}
	
	public int getElearnStatListCnt(KubeDto kubeDto) throws Exception {
		return getCount("Kube#getElearnStatListCnt", kubeDto);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> getElearnStatListXls(KubeDto kubeDto) throws Exception {
		return (List<HashMap<String, String>>) list("Kube#getElearnStatListXls", kubeDto);
	}
	
	public String getElearnVideoViSeq(String pds_saved_name) throws Exception {
		return (String) select ("Kube#getElearnVideoViSeq", pds_saved_name);
	}
}

