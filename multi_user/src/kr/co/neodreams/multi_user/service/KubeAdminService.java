package kr.co.neodreams.multi_user.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.neodreams.multi_user.dto.KubeDto;



public interface KubeAdminService {
	
	public List<HashMap<String, String>> getLeftMenu(String empno) throws Exception;
	
	public List<HashMap<String, String>> getMainLayerInfo() throws Exception;
	
	public String insertUpdateMainMgmt(KubeDto kubeDto, HttpServletRequest request, MultipartHttpServletRequest mRequest) throws Exception;
	
	public void insertCode(KubeDto kubeDto) throws Exception;
	
	public void updateCode(KubeDto kubeDto) throws Exception;
	
	public void deleteCode(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getCodeList(String inQuery) throws Exception;
	
	public List<HashMap<String, String>> getCategoryCode(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getReportList(KubeDto kubeDto) throws Exception;
	
	public int getReportListCnt(KubeDto kubeDto) throws Exception;
	
	public String updateReport(KubeDto kubeDto, HttpServletRequest request) throws Exception;
	
	public List<HashMap<String, String>> getVideoList(KubeDto kubeDto) throws Exception;
	
	public int getVideoListCnt(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getVideoListXls(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getUserStatisticsList(KubeDto kubeDto) throws Exception;
	
	public int getUserStatisticsListCnt(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getSaList(KubeDto kubeDto) throws Exception;
	
	public String insertDeleteKubeSa(KubeDto kubeDto, HttpServletRequest request) throws Exception;
	
	public List<HashMap<String, String>> getUserList(KubeDto kubeDto) throws Exception;
	
	public int getUserListCnt(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getElearnStatList(KubeDto kubeDto) throws Exception;
	
	public int getElearnStatListCnt(KubeDto kubeDto) throws Exception;
	
	public List<HashMap<String, String>> getElearnStatListXls(KubeDto kubeDto) throws Exception;
	
}
