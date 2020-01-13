package kr.co.neodreams.multi_user.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.DataMap;
import kr.co.neodreams.multi_user.common.DateUtil;
import kr.co.neodreams.multi_user.common.DownloadView;
import kr.co.neodreams.multi_user.common.HashidsGenerator;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.controller.KubeAdminController.KubeModelAndView;
import kr.co.neodreams.multi_user.dto.ImgBoardDto;
import kr.co.neodreams.multi_user.dto.KubeDto;
import kr.co.neodreams.multi_user.service.KubeAdminService;
import kr.co.neodreams.multi_user.service.KubeUserService;
import net.arnx.jsonic.JSON;

@Controller
public class KubeUserController extends BaseController {
 
	@Autowired
	KubeUserService kubeService;
	
	@Autowired
	KubeAdminService kubeAdminService;
	
	@Autowired
	DownloadView downloadView; 
	
	private HashidsGenerator hashids = new HashidsGenerator(Constants.KUBE_SEQ_SALT, 15);
	
    /*kube home*/ 
    @SuppressWarnings("unchecked")
	@RequestMapping("/kube.do")
    public ModelAndView kubeHome(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response) {
    	try{
    		HttpSession session = request.getSession();

    		if(session != null){
    			session.setAttribute("SESS_KUBE_MENU", kubeService.getLeftMenu((String) request.getSession().getAttribute("SESS_EMPNO")));
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    		log.error( "failed!", e );
    	}
    	
    	ModelAndView mv = new KubeModelAndView(kubeService, request); 
    	
    	try{ 
    		List<HashMap<String, String>> mainInfos = kubeAdminService.getMainLayerInfo();
    		
    		kubeDto.setReg_date(DateUtil.beforeSpecDay(DateUtil.getCurrentDate(), 7) + "000000");
    		kubeDto.setDept_code(((HashMap<String, String>) request.getSession().getAttribute("SESS_USER_INFO")).get("deptno"));
			List<HashMap<String, String>> homeList = kubeService.getHomeList(kubeDto);
			 
    		mv.addObject("mainInfos", mainInfos);
    		mv.addObject("homeList", homeList);
    		mv.addObject("web_url", Constants.WEB_URL);
    		mv.addObject("storage_web_url", Constants.KUBE_UPLOAD_ASP_IP);
    		mv.setViewName("/kube/kubeHome");
    	}catch(Exception e){
    		e.printStackTrace();
    	}
        return mv;
    }
    
    @RequestMapping("/videoWrite.do")
    public ModelAndView videoWrite(HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		
    		String datetime = DateUtil.getCurrentDateTime();

        	String thumbPath = datetime.substring(0, 4) + "/" + datetime.substring(4, 8);
        	
    		mv.setViewName("/kube/videoWrite");
    		mv.addObject("codeList", this.getCodeList("1, 2, 11, 12"));
    		mv.addObject("thumbPath", thumbPath);
    		mv.addObject("SESS_EMPNO", SESS_EMPNO);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
    @RequestMapping("/videoMoidfy.do")
    public ModelAndView videoMoidfy(KubeDto kubeDto, BindingResult result, HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		
    		kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
			kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(kubeDto.getVi_seq_hash())[0])));

			HashMap<String, String> videoInfo = kubeService.getVideoDetailInfo(kubeDto);
			
			kubeDto.setReg_date(DateUtil.beforeSpecDay(DateUtil.getCurrentDate(), 7) + "000000");
			
			List<HashMap<String, String>> tagList = kubeService.getVideoTagList(kubeDto);
				              
			mv.setViewName("/kube/videoModify");
			mv.addObject("code_seq", kubeDto.getCode_seq());
			mv.addObject("p_code_seq", kubeDto.getP_code_seq());
			mv.addObject("vi_seq_hash", kubeDto.getVi_seq_hash());
			mv.addObject("videoInfo", videoInfo);
			mv.addObject("tagList", tagList);
    		mv.addObject("codeList", this.getCodeList("1, 2, 11, 12"));
    		mv.addObject("SESS_EMPNO", SESS_EMPNO);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
    /**
     * 미사용. 
     * ASP 업로드 커넥션.
     * 자바 메모리 문제와 파일 2번 저장되서 안씀. 
     * asp 직접 호출
     */
    @RequestMapping("/kube/uploadVideoFile.do")
    @ResponseBody
    public void uploadVideoFile(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest mRequest)throws Exception{
    	HashMap<String, String> retVal = null; 
    	
    	try{ 
    		retVal = kubeService.uploadVideoFile(kubeDto, request, mRequest); 
    		
    	} catch (Exception e) {
    		e.printStackTrace();
    		log.error( "failed!", e );
    	} finally{
   			response.getWriter().write(JSON.encode(retVal));
    	}
    }
    
    @RequestMapping("/kube/insertVideoUpload.do")
    @ResponseBody
	public void insertVideoUpload(MultipartHttpServletRequest request, HttpServletResponse response)throws Exception{
    	String retVal = "false"; 
		              
		try{
			retVal = kubeService.insertVideoUpload(request); 
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally{
			if(retVal.equals("false")){
				response.setHeader("Content-Type", "text/html; charset=utf-8");
				retVal = "<script>alert('서비스 장애가 발생했습니다. 관리자에게 문의 하시기 바랍니다.');</script>";
				response.getWriter().write(retVal);
			}else{
				response.setHeader("Content-Type", "text/html; charset=utf-8");
				retVal = "<script>alert('등록 되었습니다. 영상 컨버팅 완료 후 게시됩니다.');parent.location.replace('/kube/mypage/videoMgmtList.do');</script>";
				response.getWriter().write(retVal);
			}   
		}
	}
    
    @RequestMapping("/kube/updateVideoInfo.do")
    @ResponseBody
    public void updateVideoInfo(MultipartHttpServletRequest request, HttpServletResponse response)throws Exception{
    	String retVal = "false"; 
    	
    	try{
    		retVal = kubeService.updateVideoInfo(request); 
    	} catch (Exception e) {
    		e.printStackTrace();
    		log.error( "failed!", e );
    	} finally{
    		if(retVal.equals("false")){
    			response.setHeader("Content-Type", "text/html; charset=utf-8");
    			retVal = "<script>alert('서비스 장애가 발생했습니다. 관리자에게 문의 하시기 바랍니다.');</script>";
    			response.getWriter().write(retVal);
    		}else{
    			response.setHeader("Content-Type", "text/html; charset=utf-8");
    			retVal = "<script>alert('수정 되었습니다.');parent.goPageDetail();</script>";
    			response.getWriter().write(retVal);
    		}   
    	}
    }
    
    /**
     * (공통)영상 카테고리별 리스트
     */
	@SuppressWarnings("unchecked")
	@RequestMapping(value={"/kube/channel/{channel}/{p_code_seq_hash}/{code_seq_hash}"}) 
    public ModelAndView kubeChannelList(@PathVariable("channel") String channel
    		, @PathVariable("p_code_seq_hash") String p_code_seq_hash
    		, @PathVariable("code_seq_hash") String code_seq_hash
    		, KubeDto kubeDto
    		, BindingResult result
    		, HttpServletRequest request) throws Exception{
    	ModelAndView mv = new KubeModelAndView(kubeService, request); 
    	
    	try{
    		
    		kubeDto.setPerPageCnt(20);
    		kubeDto.setCode_seq(Integer.parseInt(String.valueOf(hashids.decrypt(code_seq_hash)[0])));
    		kubeDto.setP_code_seq(Integer.parseInt(String.valueOf(hashids.decrypt(p_code_seq_hash)[0])));
    		kubeDto.setSelOrder(StringUtil.isNull(kubeDto.getSelOrder(), "reg_date"));
    		
    		if(StringUtil.isNotEmpty(kubeDto.getSrh_keyword_top())){
				kubeDto.setSrh_keyword(kubeDto.getSrh_keyword_top());
			}
			
			if(StringUtil.isNotEmpty(kubeDto.getSrh_keyword())){
				kubeDto.setSrh_keyword_top(kubeDto.getSrh_keyword());
			}
			
    		//사업소는 해당 영상만 가져온다
    		if(kubeDto.getCode_seq() == 12){
    			kubeDto.setDept_code(((HashMap<String, String>) request.getSession().getAttribute("SESS_USER_INFO")).get("deptno"));
    		}
    		
    		HashMap<String, String> categoryInfo = kubeService.getCategoryInfo(kubeDto);
    		
    		List<HashMap<String, String>> videoList = kubeService.getCategoryVideoList(kubeDto);
    		int totalCnt = kubeService.getCategoryVideoListCnt(kubeDto);
    		
    		mv.setViewName("/kube/videoList");
    		mv.addObject("code_seq", kubeDto.getCode_seq());
    		mv.addObject("p_code_seq", kubeDto.getP_code_seq());
    		mv.addObject("categoryInfo", categoryInfo);
    		mv.addObject("web_url", Constants.KUBE_UPLOAD_ASP_IP);
    		mv.addObject("paging", kubeDto);
    		mv.addObject("channel", channel);
    		mv.addObject("videoList", videoList);
        	mv.addObject("totalCnt", totalCnt);
    	}catch(Exception e){
    		e.printStackTrace();
			mv.setViewName("/error/error");
    	}
    	return mv;
    }
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value={"/kube/channel/{channel}"}) 
	public ModelAndView kubeChannelList(@PathVariable("channel") String channel
			, KubeDto kubeDto
			, BindingResult result
			, HttpServletRequest request) throws Exception{
		ModelAndView mv = new KubeModelAndView(kubeService, request); 
		
		try{
			if("search".equals(channel)){
				
				if(StringUtil.isNotEmpty(kubeDto.getSrh_keyword_top())){
					kubeDto.setSrh_keyword(kubeDto.getSrh_keyword_top());
				}
				
				if(StringUtil.isNotEmpty(kubeDto.getSrh_keyword())){
					kubeDto.setSrh_keyword_top(kubeDto.getSrh_keyword());
				}
				
				kubeDto.setReg_date(DateUtil.beforeSpecDay(DateUtil.getCurrentDate(), 7) + "000000");
	    		kubeDto.setDept_code(((HashMap<String, String>) request.getSession().getAttribute("SESS_USER_INFO")).get("deptno"));
				kubeDto.setSelOrder(StringUtil.isNull(kubeDto.getSelOrder(), "reg_date"));
	    		
	    		List<HashMap<String, String>> videoList = kubeService.getTotalSrhList(kubeDto);
	    		HashMap<String, String> totalCnt = kubeService.getTotalSrhListCnt(kubeDto);
	    		List<HashMap<String, String>> categoryCnt = kubeService.getSrhCategoryCnt(kubeDto);
	    		
	    		mv.setViewName("/kube/videoSrhList");
	    		mv.addObject("web_url", Constants.KUBE_UPLOAD_ASP_IP);
	    		mv.addObject("paging", kubeDto);
	    		mv.addObject("videoList", videoList);
	        	mv.addObject("totalCnt", totalCnt);
	        	mv.addObject("categoryCnt", categoryCnt);
			}else{
				kubeDto.setPerPageCnt(20);
				kubeDto.setReg_date(DateUtil.beforeSpecDay(DateUtil.getCurrentDate(), 7) + "000000");
	    		
				if(StringUtil.isNotEmpty(kubeDto.getSrh_keyword_top())){
					kubeDto.setSrh_keyword(kubeDto.getSrh_keyword_top());
				}
				
				if(StringUtil.isNotEmpty(kubeDto.getSrh_keyword())){
					kubeDto.setSrh_keyword_top(kubeDto.getSrh_keyword());
				}
				
				List<HashMap<String, String>> videoList = null; 
				int totalCnt = 0;
				
				if("weekly".equals(channel)){
					kubeDto.setSelOrder(StringUtil.isNull(kubeDto.getSelOrder(), "popular_cnt"));
					videoList = kubeService.getWeeklyList(kubeDto);
					totalCnt = kubeService.getWeeklyListCnt(kubeDto);					
				}else if("hits".equals(channel)){
					kubeDto.setSelOrder(StringUtil.isNull(kubeDto.getSelOrder(), "visit_cnt"));
					videoList = kubeService.getWeeklyList(kubeDto);
					totalCnt = kubeService.getWeeklyListCnt(kubeDto);					
				}else if("like".equals(channel)){
					kubeDto.setSelOrder(StringUtil.isNull(kubeDto.getSelOrder(), "like_cnt"));
					videoList = kubeService.getWeeklyList(kubeDto);
					totalCnt = kubeService.getWeeklyListCnt(kubeDto);					
				}else if("recently".equals(channel)){
					kubeDto.setSelOrder("reg_date");
					videoList = kubeService.getRecentlyList(kubeDto);
					totalCnt = kubeService.getRecentlyListCnt(kubeDto);
				}else if("top".equals(channel)){
					kubeDto.setSelOrder("popular_cnt");
					videoList = kubeService.getTopList(kubeDto);
					totalCnt = kubeService.getTopListCnt(kubeDto);
				}else if("dept".equals(channel)){
					kubeDto.setSelOrder(StringUtil.isNull(kubeDto.getSelOrder(), "reg_date"));
					kubeDto.setCode_seq(999999);
					kubeDto.setP_code_seq(1);
					
					if(StringUtil.isEmpty(kubeDto.getSel_f_dept_code())){
	        			kubeDto.setSel_f_dept_code(((HashMap<String, String>) request.getSession().getAttribute("SESS_USER_INFO")).get("first_dept_code"));
	        		}
	        		
	        		if(StringUtil.isEmpty(kubeDto.getSel_s_dept_code())){
	        			kubeDto.setSel_s_dept_code(((HashMap<String, String>) request.getSession().getAttribute("SESS_USER_INFO")).get("second_dept_code"));
	        			kubeDto.setEtc_info("sub_use");
	        		}else{
	        			if("none".equals(kubeDto.getSel_s_dept_code())){
	        				kubeDto.setEtc_info("sub_none");
	        			}else{
	        				kubeDto.setEtc_info("sub_use");
	        			}
	        		}
	        		
					videoList = kubeService.getCategoryVideoList(kubeDto);
					totalCnt = kubeService.getCategoryVideoListCnt(kubeDto);
				}else if("recommend".equals(channel)){ 
					kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
					videoList = kubeService.getRecommendedList(kubeDto);
					totalCnt = kubeService.getRecommendedListCnt(kubeDto);
				}
						
	    		mv.setViewName("/kube/videoWRTList");
	    		mv.addObject("web_url", Constants.KUBE_UPLOAD_ASP_IP);
	    		mv.addObject("paging", kubeDto);
	    		mv.addObject("videoList", videoList);
	        	mv.addObject("totalCnt", totalCnt);
	        	mv.addObject("channel", channel);
	        	
	        	if("dept".equals(channel)){
	        		//1, 2depth 리스트 가져오기
	        		kubeDto.setEtc_info("");
	        		List<HashMap<String, String>> firstList = kubeService.getDeptInfo(kubeDto);
	        		mv.addObject("firstDept", firstList);
	        		
	        		for(int i = 0; i < firstList.size(); i++){
	        			if(kubeDto.getSel_f_dept_code().equals(firstList.get(i).get("dept_code"))){
	        				mv.addObject("firstDeptName", firstList.get(i).get("dept_name"));
	        			}
	        		}
	        		
	        		kubeDto.setEtc_info("Y");
	        		List<HashMap<String, String>> secondList = kubeService.getDeptInfo(kubeDto);
	        		mv.addObject("secondDept", secondList);
	        		
					if(StringUtil.isNotEmpty(kubeDto.getSel_s_dept_code())
							&& !"none".equals(kubeDto.getSel_s_dept_code())){
						for(int i = 0; i < secondList.size(); i++){
							if(kubeDto.getSel_s_dept_code().equals(secondList.get(i).get("dept_code"))){
								mv.addObject("secondDeptName", secondList.get(i).get("dept_name"));
							}
						}
					}
	        	}
			}
			
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}
		return mv;
	}
	
	@RequestMapping(value={"/kube/elearn/{pds_saved_name}"}) 
	public ModelAndView kubeElearnVideoDetail(@PathVariable("pds_saved_name") String pds_saved_name
			, KubeDto kubeDto
			, BindingResult result
			, HttpServletRequest request) throws Exception{
		ModelAndView mv = new KubeModelAndView(kubeService, request); 
		
		try{
			
			String vi_seq = kubeService.getElearnVideoViSeq(pds_saved_name);
			
			if(StringUtil.isNotEmpty(vi_seq)){
				String vi_seq_hash = hashids.encrypt(Integer.parseInt(vi_seq));
				
				kubeDto.setVi_seq_hash(vi_seq_hash);
				kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
				kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(vi_seq_hash)[0])));
	
				HashMap<String, String> videoInfo = kubeService.getVideoDetailInfo(kubeDto);
				
				boolean visitUpdate = true;
				
				//20180126 이전까지는 모든 사용자가 1개 게시글에 조회수 1일 1회 증가 됨
				if(DateUtil.compareBetweenDates("20180126", DateUtil.getToday()) == -1){
					if(kubeDto.getEmpno().equals(videoInfo.get("reg_empno"))){
						
						HashMap<String, String> visitInfo = kubeService.getLastVisitDate(kubeDto);
						
						if(visitInfo != null){
							//로그인 사용자와 영상 업로더가 같은 경우, 조회 카운트는 24시간 초과시 1 증가. 조회수 조작 방지 및 사용자 유입 유도
							if(DateUtil.getBetweenDateTimes(DateUtil.getCurrentDateTime(), visitInfo.get("reg_date")) / (60*60*24) == 0){
								visitUpdate = false;
							}
						}
					}
				}else{
					HashMap<String, String> visitInfo = kubeService.getLastVisitDate(kubeDto);
					
					if(visitInfo != null){
						//로그인 사용자와 영상 업로더가 같은 경우, 조회 카운트는 24시간 초과시 1 증가. 조회수 조작 방지 및 사용자 유입 유도
						if(DateUtil.getBetweenDateTimes(DateUtil.getCurrentDateTime(), visitInfo.get("reg_date")) / (60*60*24) == 0){
							visitUpdate = false;
						}
					}
				}
				
				if(visitUpdate){
					//하단의 kubeService.userActCtrl 에서 증가 처리 됨. 
					//증가된 데이터를 가져오기 위해 kubeService.getVideoDetailInfo 를 반복 실행하지 않고 임시로 카운트 1 증가해서 화면에 뿌림
					videoInfo.put("visit_cnt", String.valueOf(Integer.parseInt(String.valueOf(videoInfo.get("visit_cnt"))) + 1));
					
					//조회 카운트 증가 및 히스토리 생성
					kubeDto.setVh_gubun("1");
					kubeDto.setVc_seq(0);
					kubeService.userActCtrl(kubeDto, request);
				}
				
				String right_gubun = StringUtil.isNull(request.getParameter("right_gubun"), "R");
				String autoplay = StringUtil.isNull(request.getParameter("autoplay"), "3");
				
				kubeDto.setReg_date(DateUtil.beforeSpecDay(DateUtil.getCurrentDate(), 7) + "000000");
				
				//다음 값으로 증가 시켜주는 역할
				int nextNum = Integer.parseInt(StringUtil.isNull(request.getParameter("nextNum"), "-1"));
				
				List<HashMap<String, String>> tagList = kubeService.getVideoTagList(kubeDto);
					
				HashMap<String, String> elearnUserMap; 
						
				if("elearn".equals(String.valueOf(videoInfo.get("channel")))){
					
					HashMap<String, String> videoUserInfo = new HashMap<String, String>();
					videoUserInfo.put("empno", kubeDto.getEmpno());
					videoUserInfo.put("vi_seq", String.valueOf(kubeDto.getVi_seq()));
					
					//상황별 공통 메소드로 사용하기 위해 맵으로 변경
					kubeService.insertUpdateElearnVideoUserMap(videoUserInfo);
					
					elearnUserMap = kubeService.getElearnVideoUserInfo(kubeDto);
					
					mv.addObject("elearnUserMap", elearnUserMap);
				}
				
				mv.setViewName("/kube/videoDetail");
				mv.addObject("code_seq", kubeDto.getCode_seq());
				mv.addObject("p_code_seq", kubeDto.getP_code_seq());
				mv.addObject("vi_seq_hash", vi_seq_hash);
				mv.addObject("videoInfo", videoInfo);
				mv.addObject("codeList", this.getCodeList("14"));
				mv.addObject("web_url", Constants.KUBE_UPLOAD_ASP_IP);
				mv.addObject("tagList", tagList);
				mv.addObject("right_gubun", right_gubun);
				
				if("M".equals(right_gubun)){
					String[] chkVideoSeq = request.getParameterValues("chkVideoSeqArr");
					ArrayList<String> chkVideoSeqArr = new ArrayList<String>();
					
					
					if(chkVideoSeq != null
							&& chkVideoSeq.length > 0){
						
						autoplay = "1";
						
						//즐겨찾기 영상에서 복수 건 체크하고 들어온 경우 이미 첫번째 영상 재생중. 다음 자동 재생에서는 2번째 영상으로 건너뛴다
						if(nextNum == -1){
							nextNum = nextNum + 1;
						}
						
						for(int i = 0; i < chkVideoSeq.length; i++){
							chkVideoSeqArr.add(chkVideoSeq[i]);
						}  
						
						mv.addObject("chkVideoSeqArr", chkVideoSeqArr);
						
					}
					
				}
				
				mv.addObject("nextNum", nextNum);
				mv.addObject("autoplay", autoplay);
			}else{
				mv.setViewName("/error/error");
			}
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}
		return mv;
	}
	
	@RequestMapping(value={"/kube/watch/{vi_seq_hash}"}) 
	public ModelAndView kubeVideoDetail(@PathVariable("vi_seq_hash") String vi_seq_hash
			, KubeDto kubeDto
			, BindingResult result
			, HttpServletRequest request) throws Exception{
		ModelAndView mv = new KubeModelAndView(kubeService, request); 
		
		try{
			kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
			kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(vi_seq_hash)[0])));

			if(kubeDto.getP_code_seq() == 0
					|| kubeDto.getCode_seq() == 0){
				HashMap<String, String> videoInfo = kubeService.getVideoDetailInfo(kubeDto);
				kubeDto.setP_code_seq(Integer.parseInt(String.valueOf(videoInfo.get("mod_code_seq1"))));
				kubeDto.setCode_seq(Integer.parseInt(String.valueOf(videoInfo.get("mod_code_seq2"))));
			}
			
			HashMap<String, String> videoInfo = kubeService.getVideoDetailInfo(kubeDto);
			
			boolean visitUpdate = true;
			
			//20180126 이전까지는 모든 사용자가 1개 게시글에 조회수 1일 1회 증가 됨
			if(DateUtil.compareBetweenDates("20180126", DateUtil.getToday()) == -1){
				if(kubeDto.getEmpno().equals(videoInfo.get("reg_empno"))){
					
					HashMap<String, String> visitInfo = kubeService.getLastVisitDate(kubeDto);
					
					if(visitInfo != null){
						//로그인 사용자와 영상 업로더가 같은 경우, 조회 카운트는 24시간 초과시 1 증가. 조회수 조작 방지 및 사용자 유입 유도
						if(DateUtil.getBetweenDateTimes(DateUtil.getCurrentDateTime(), visitInfo.get("reg_date")) / (60*60*24) == 0){
							visitUpdate = false;
						}
					}
				}
			}else{
				HashMap<String, String> visitInfo = kubeService.getLastVisitDate(kubeDto);
				
				if(visitInfo != null){
					//로그인 사용자와 영상 업로더가 같은 경우, 조회 카운트는 24시간 초과시 1 증가. 조회수 조작 방지 및 사용자 유입 유도
					if(DateUtil.getBetweenDateTimes(DateUtil.getCurrentDateTime(), visitInfo.get("reg_date")) / (60*60*24) == 0){
						visitUpdate = false;
					}
				}
			}
			
			if(visitUpdate){
				//하단의 kubeService.userActCtrl 에서 증가 처리 됨. 
				//증가된 데이터를 가져오기 위해 kubeService.getVideoDetailInfo 를 반복 실행하지 않고 임시로 카운트 1 증가해서 화면에 뿌림
				videoInfo.put("visit_cnt", String.valueOf(Integer.parseInt(String.valueOf(videoInfo.get("visit_cnt"))) + 1));
				
				//조회 카운트 증가 및 히스토리 생성
				kubeDto.setVh_gubun("1");
				kubeDto.setVc_seq(0);
				kubeService.userActCtrl(kubeDto, request);
			}
			
			String right_gubun = StringUtil.isNull(request.getParameter("right_gubun"), "R");
			String autoplay = StringUtil.isNull(request.getParameter("autoplay"), "3");
			
			kubeDto.setReg_date(DateUtil.beforeSpecDay(DateUtil.getCurrentDate(), 7) + "000000");
			
			//다음 값으로 증가 시켜주는 역할
			int nextNum = Integer.parseInt(StringUtil.isNull(request.getParameter("nextNum"), "-1"));
			
			List<HashMap<String, String>> tagList = kubeService.getVideoTagList(kubeDto);
				
			HashMap<String, String> elearnUserMap; 
					
			if("elearn".equals(String.valueOf(videoInfo.get("channel")))){
				
				HashMap<String, String> videoUserInfo = new HashMap<String, String>();
				videoUserInfo.put("empno", kubeDto.getEmpno());
				videoUserInfo.put("vi_seq", String.valueOf(kubeDto.getVi_seq()));
				
				//상황별 공통 메소드로 사용하기 위해 맵으로 변경
				kubeService.insertUpdateElearnVideoUserMap(videoUserInfo);
				
				elearnUserMap = kubeService.getElearnVideoUserInfo(kubeDto);
				
				mv.addObject("elearnUserMap", elearnUserMap);
			}
			
			mv.setViewName("/kube/videoDetail");
			mv.addObject("code_seq", kubeDto.getCode_seq());
			mv.addObject("p_code_seq", kubeDto.getP_code_seq());
			mv.addObject("vi_seq_hash", vi_seq_hash);
			mv.addObject("videoInfo", videoInfo);
			mv.addObject("codeList", this.getCodeList("14"));
			mv.addObject("web_url", Constants.KUBE_UPLOAD_ASP_IP);
			mv.addObject("tagList", tagList);
			mv.addObject("right_gubun", right_gubun);
			
			if("M".equals(right_gubun)){
				String[] chkVideoSeq = request.getParameterValues("chkVideoSeqArr");
				ArrayList<String> chkVideoSeqArr = new ArrayList<String>();
				
				
				if(chkVideoSeq != null
						&& chkVideoSeq.length > 0){
					
					autoplay = "1";
					
					//즐겨찾기 영상에서 복수 건 체크하고 들어온 경우 이미 첫번째 영상 재생중. 다음 자동 재생에서는 2번째 영상으로 건너뛴다
					if(nextNum == -1){
						nextNum = nextNum + 1;
					}
					
					for(int i = 0; i < chkVideoSeq.length; i++){
						chkVideoSeqArr.add(chkVideoSeq[i]);
					}  
					
					mv.addObject("chkVideoSeqArr", chkVideoSeqArr);
					
				}
				
			}
			
			mv.addObject("nextNum", nextNum);
			mv.addObject("autoplay", autoplay);
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}
		return mv;
	}
	
	/**
	 * player 구분용. 조군제 과장 버전
	 */
	@RequestMapping(value={"/kube/video/videoDetail2.do"}) 
	public ModelAndView kubeVideoDetail2(KubeDto kubeDto
			, BindingResult result
			, HttpServletRequest request) throws Exception{
		ModelAndView mv = new KubeModelAndView(kubeService, request); 
		
		try{
			
			String vi_seq_hash = kubeDto.getVi_seq_hash();
			
			kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
			kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(vi_seq_hash)[0])));
			
			HashMap<String, String> videoInfo = kubeService.getVideoDetailInfo(kubeDto);
			
			boolean visitUpdate = true;
			
			//20180126 이전까지는 모든 사용자가 1개 게시글에 조회수 1일 1회 증가 됨
			if(DateUtil.compareBetweenDates("20180126", DateUtil.getToday()) == -1){
				if(kubeDto.getEmpno().equals(videoInfo.get("reg_empno"))){
					
					HashMap<String, String> visitInfo = kubeService.getLastVisitDate(kubeDto);
					
					if(visitInfo != null){
						//로그인 사용자와 영상 업로더가 같은 경우, 조회 카운트는 24시간 초과시 1 증가. 조회수 조작 방지 및 사용자 유입 유도
						if(DateUtil.getBetweenDateTimes(DateUtil.getCurrentDateTime(), visitInfo.get("reg_date")) / (60*60*24) == 0){
							visitUpdate = false;
						}
					}
				}
			}else{
				HashMap<String, String> visitInfo = kubeService.getLastVisitDate(kubeDto);
				
				if(visitInfo != null){
					//로그인 사용자와 영상 업로더가 같은 경우, 조회 카운트는 24시간 초과시 1 증가. 조회수 조작 방지 및 사용자 유입 유도
					if(DateUtil.getBetweenDateTimes(DateUtil.getCurrentDateTime(), visitInfo.get("reg_date")) / (60*60*24) == 0){
						visitUpdate = false;
					}
				}
			}
			
			if(visitUpdate){
				//하단의 kubeService.userActCtrl 에서 증가 처리 됨. 
				//증가된 데이터를 가져오기 위해 kubeService.getVideoDetailInfo 를 반복 실행하지 않고 임시로 카운트 1 증가해서 화면에 뿌림
				videoInfo.put("visit_cnt", String.valueOf(Integer.parseInt(String.valueOf(videoInfo.get("visit_cnt"))) + 1));
				
				//조회 카운트 증가 및 히스토리 생성
				kubeDto.setVh_gubun("1");
				kubeDto.setVc_seq(0);
				kubeService.userActCtrl(kubeDto, request);
			}
			
			String right_gubun = StringUtil.isNull(request.getParameter("right_gubun"), "R");
			String autoplay = StringUtil.isNull(request.getParameter("autoplay"), "3");
			
			kubeDto.setReg_date(DateUtil.beforeSpecDay(DateUtil.getCurrentDate(), 7) + "000000");
			
			//다음 값으로 증가 시켜주는 역할
			int nextNum = Integer.parseInt(StringUtil.isNull(request.getParameter("nextNum"), "-1"));
			
			List<HashMap<String, String>> tagList = kubeService.getVideoTagList(kubeDto);
			
			HashMap<String, String> elearnUserMap; 
			
			if("elearn".equals(String.valueOf(videoInfo.get("channel")))){
				
				HashMap<String, String> videoUserInfo = new HashMap<String, String>();
				videoUserInfo.put("empno", kubeDto.getEmpno());
				videoUserInfo.put("vi_seq", String.valueOf(kubeDto.getVi_seq()));
				
				//상황별 공통 메소드로 사용하기 위해 맵으로 변경
				kubeService.insertUpdateElearnVideoUserMap(videoUserInfo);
				
				elearnUserMap = kubeService.getElearnVideoUserInfo(kubeDto);
				
				mv.addObject("elearnUserMap", elearnUserMap);
			}
			
			mv.setViewName("/kube/videoDetailTest");
			mv.addObject("code_seq", kubeDto.getCode_seq());
			mv.addObject("p_code_seq", kubeDto.getP_code_seq());
			mv.addObject("vi_seq_hash", vi_seq_hash);
			mv.addObject("videoInfo", videoInfo);
			mv.addObject("codeList", this.getCodeList("14"));
			mv.addObject("web_url", Constants.KUBE_UPLOAD_ASP_IP);
			mv.addObject("tagList", tagList);
			mv.addObject("right_gubun", right_gubun);
			
			if("M".equals(right_gubun)){
				String[] chkVideoSeq = request.getParameterValues("chkVideoSeqArr");
				ArrayList<String> chkVideoSeqArr = new ArrayList<String>();
				
				
				if(chkVideoSeq != null
						&& chkVideoSeq.length > 0){
					
					autoplay = "1";
					
					//즐겨찾기 영상에서 복수 건 체크하고 들어온 경우 이미 첫번째 영상 재생중. 다음 자동 재생에서는 2번째 영상으로 건너뛴다
					if(nextNum == -1){
						nextNum = nextNum + 1;
					}
					
					for(int i = 0; i < chkVideoSeq.length; i++){
						chkVideoSeqArr.add(chkVideoSeq[i]);
					}  
					
					mv.addObject("chkVideoSeqArr", chkVideoSeqArr);
					
				}
				
			}
			
			mv.addObject("nextNum", nextNum);
			mv.addObject("autoplay", autoplay);
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}
		return mv;
	}
    
	/**
	 * player 구분용. 전대철 대리 원본 버전
	 */
	@RequestMapping(value={"/kube/video/videoDetail3.do"}) 
	public ModelAndView kubeVideoDetail3(KubeDto kubeDto
			, BindingResult result
			, HttpServletRequest request) throws Exception{
		ModelAndView mv = new KubeModelAndView(kubeService, request); 
		
		try{
			
			String vi_seq_hash = kubeDto.getVi_seq_hash();
			
			kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
			kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(vi_seq_hash)[0])));
			
			HashMap<String, String> videoInfo = kubeService.getVideoDetailInfo(kubeDto);
			
			boolean visitUpdate = true;
			
			//20180126 이전까지는 모든 사용자가 1개 게시글에 조회수 1일 1회 증가 됨
			if(DateUtil.compareBetweenDates("20180126", DateUtil.getToday()) == -1){
				if(kubeDto.getEmpno().equals(videoInfo.get("reg_empno"))){
					
					HashMap<String, String> visitInfo = kubeService.getLastVisitDate(kubeDto);
					
					if(visitInfo != null){
						//로그인 사용자와 영상 업로더가 같은 경우, 조회 카운트는 24시간 초과시 1 증가. 조회수 조작 방지 및 사용자 유입 유도
						if(DateUtil.getBetweenDateTimes(DateUtil.getCurrentDateTime(), visitInfo.get("reg_date")) / (60*60*24) == 0){
							visitUpdate = false;
						}
					}
				}
			}else{
				HashMap<String, String> visitInfo = kubeService.getLastVisitDate(kubeDto);
				
				if(visitInfo != null){
					//로그인 사용자와 영상 업로더가 같은 경우, 조회 카운트는 24시간 초과시 1 증가. 조회수 조작 방지 및 사용자 유입 유도
					if(DateUtil.getBetweenDateTimes(DateUtil.getCurrentDateTime(), visitInfo.get("reg_date")) / (60*60*24) == 0){
						visitUpdate = false;
					}
				}
			}
			
			if(visitUpdate){
				//하단의 kubeService.userActCtrl 에서 증가 처리 됨. 
				//증가된 데이터를 가져오기 위해 kubeService.getVideoDetailInfo 를 반복 실행하지 않고 임시로 카운트 1 증가해서 화면에 뿌림
				videoInfo.put("visit_cnt", String.valueOf(Integer.parseInt(String.valueOf(videoInfo.get("visit_cnt"))) + 1));
				
				//조회 카운트 증가 및 히스토리 생성
				kubeDto.setVh_gubun("1");
				kubeDto.setVc_seq(0);
				kubeService.userActCtrl(kubeDto, request);
			}
			
			String right_gubun = StringUtil.isNull(request.getParameter("right_gubun"), "R");
			String autoplay = StringUtil.isNull(request.getParameter("autoplay"), "3");
			
			kubeDto.setReg_date(DateUtil.beforeSpecDay(DateUtil.getCurrentDate(), 7) + "000000");
			
			//다음 값으로 증가 시켜주는 역할
			int nextNum = Integer.parseInt(StringUtil.isNull(request.getParameter("nextNum"), "-1"));
			
			List<HashMap<String, String>> tagList = kubeService.getVideoTagList(kubeDto);
			
			HashMap<String, String> elearnUserMap; 
			
			if("elearn".equals(String.valueOf(videoInfo.get("channel")))){
				
				HashMap<String, String> videoUserInfo = new HashMap<String, String>();
				videoUserInfo.put("empno", kubeDto.getEmpno());
				videoUserInfo.put("vi_seq", String.valueOf(kubeDto.getVi_seq()));
				
				//상황별 공통 메소드로 사용하기 위해 맵으로 변경
				kubeService.insertUpdateElearnVideoUserMap(videoUserInfo);
				
				elearnUserMap = kubeService.getElearnVideoUserInfo(kubeDto);
				
				mv.addObject("elearnUserMap", elearnUserMap);
			}
			
			mv.setViewName("/kube/videoDetailTest2");
			mv.addObject("code_seq", kubeDto.getCode_seq());
			mv.addObject("p_code_seq", kubeDto.getP_code_seq());
			mv.addObject("vi_seq_hash", vi_seq_hash);
			mv.addObject("videoInfo", videoInfo);
			mv.addObject("codeList", this.getCodeList("14"));
			mv.addObject("web_url", Constants.KUBE_UPLOAD_ASP_IP);
			mv.addObject("tagList", tagList);
			mv.addObject("right_gubun", right_gubun);
			
			if("M".equals(right_gubun)){
				String[] chkVideoSeq = request.getParameterValues("chkVideoSeqArr");
				ArrayList<String> chkVideoSeqArr = new ArrayList<String>();
				
				
				if(chkVideoSeq != null
						&& chkVideoSeq.length > 0){
					
					autoplay = "1";
					
					//즐겨찾기 영상에서 복수 건 체크하고 들어온 경우 이미 첫번째 영상 재생중. 다음 자동 재생에서는 2번째 영상으로 건너뛴다
					if(nextNum == -1){
						nextNum = nextNum + 1;
					}
					
					for(int i = 0; i < chkVideoSeq.length; i++){
						chkVideoSeqArr.add(chkVideoSeq[i]);
					}  
					
					mv.addObject("chkVideoSeqArr", chkVideoSeqArr);
					
				}
				
			}
			
			mv.addObject("nextNum", nextNum);
			mv.addObject("autoplay", autoplay);
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}
		return mv;
	}
	
	@RequestMapping("/kube/getRightVideoList.do") 
	public ModelAndView getRightVideoList(KubeDto kubeDto, BindingResult result, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView(); 
		
		try{
			kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
			kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(kubeDto.getVi_seq_hash())[0])));

			List<HashMap<String, String>> rightList = null;
			
			String right_gubun = StringUtil.isNull(request.getParameter("right_gubun"), "R");
			String nextVi_seq = "";
			int nextNum = Integer.parseInt(StringUtil.isNull(request.getParameter("nextNum"), "-1")) + 1;
			  
			if(right_gubun.equals("R")){
				kubeDto.setPageNo(1);
				rightList = kubeService.getRecommendedList(kubeDto);
				
				if(rightList != null 
						&& rightList.size() > 0){
					int forCnt = rightList.size();
					
					HashidsGenerator hashids = new HashidsGenerator(Constants.KUBE_SEQ_SALT, 15);

					for(int i = 0; i < forCnt; i++){
						if(nextNum == i){
							nextVi_seq = hashids.encrypt(Integer.parseInt(String.valueOf(rightList.get(i).get("vi_seq"))));
						}else{
							if(nextNum == forCnt - 1){
								nextVi_seq = "";
							}
						}
					}
				}
			}else if(right_gubun.equals("M")){          
				String chkVideoSeq = request.getParameter("chkVideoSeqArr");
				
				if(StringUtil.isNotEmpty(chkVideoSeq)){
					chkVideoSeq = chkVideoSeq.replace("[", "").replace("]", "");
					String[] chkVideoSeqArr = chkVideoSeq.split(",");
					String inQuery = "";
					String orderVal = " case kmam.vi_seq "; 
						
					int forCnt = chkVideoSeqArr.length;
					
					for(int i = 0; i < forCnt; i++){
						inQuery = inQuery + ", " + String.valueOf(hashids.decrypt(chkVideoSeqArr[i].trim())[0]); 
						orderVal = orderVal + " when " + String.valueOf(hashids.decrypt(chkVideoSeqArr[i].trim())[0]) + " then " + (i + 1);
						
						if(nextNum == i){
							nextVi_seq = chkVideoSeqArr[i].trim();
						}else{
							if(nextNum == forCnt - 1){
								nextVi_seq = "";
							}
						}
					}
					orderVal = orderVal + " end";
					
					kubeDto.setInQuery(inQuery.substring(1, inQuery.length()));
					kubeDto.setOrderVal(orderVal);
					
					rightList = kubeService.getMyBookMarkChkList(kubeDto);
				}
			}
			
			mv.setViewName("/kube/rightVideoList");
			mv.addObject("rightList", rightList);
			mv.addObject("web_url", Constants.KUBE_UPLOAD_ASP_IP);
			mv.addObject("nextVi_seq_hash", nextVi_seq); 
			mv.addObject("nextNumChk", nextNum);
		}catch(Exception e){
			e.printStackTrace();
			mv.setViewName("/error/error");
		}
		return mv;
	}
	
	/* 상세페이지 기능 액션 시작 */
	@RequestMapping("/kube/approveReqVideo.do")
    @ResponseBody
	public void insertApproveReqVideo(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception{		
    	
		String retVal = "false"; 
		
		try{ 
			kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(kubeDto.getVi_seq_hash())[0])));
			kubeDto.setVa_status(44);
			
			retVal = kubeService.insertApproveReqVideo(kubeDto, request); 
			
			retVal = "true";
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally{
			response.setHeader("Content-Type", "text/html; charset=utf-8");
			response.getWriter().write(retVal);
		}
	}
	
	@RequestMapping("/kube/kubeVideoFileDown.do")
	public void prdFileDown(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {
 		System.out.println(result.getErrorCount());
    	for(ObjectError errors : result.getAllErrors()){
    		System.out.println(errors.getCode());
    		System.out.println(result.getFieldError().getField());
    	}
    	
    	String retVal = "false"; 
    	
    	try {
	 		//파일 상세
    		kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
    		kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(kubeDto.getVi_seq_hash())[0])));
    		
    		//영상 다운로드 카운트 증가
			kubeDto.setVh_gubun("8");
			kubeDto.setVc_seq(0);
			kubeService.userActCtrl(kubeDto, request);
			
			retVal = "true";
 		}catch(Exception e){
 			e.printStackTrace();
    		log.error( "failed!", e );
 		} finally{
			response.setHeader("Content-Type", "text/html; charset=utf-8");
			response.getWriter().write(retVal);
		}
 	}
	
	@RequestMapping("/kube/userActCtrl.do")
	@ResponseBody
	public void userActCtrl(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception{		
		
		String retVal = "false"; 
		
		try{ 
			kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(kubeDto.getVi_seq_hash())[0])));
			kubeDto.setVh_gubun(request.getParameter("ma"));
			kubeDto.setVc_seq(Integer.parseInt(String.valueOf(hashids.decrypt(request.getParameter("target_vc_seq"))[0])));
			
			retVal = kubeService.userActCtrl(kubeDto, request); 
			
			retVal = "true";
		} catch (Exception e) {
			e.printStackTrace();
			log.error( "failed!", e );
		} finally{
			response.setHeader("Content-Type", "text/html; charset=utf-8");
			response.getWriter().write(retVal);
		}
	}
	
	@RequestMapping("/kube/insertUserComment.do")
	@ResponseBody
	public void insertUserComment(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception{		
		
		String retVal = "99999999"; 
		
		try{ 
			kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(kubeDto.getVi_seq_hash())[0])));
			kubeDto.setP_vc_seq(Integer.parseInt(String.valueOf(hashids.decrypt(request.getParameter("target_vc_seq"))[0])));
			kubeDto.setComment_desc(request.getParameterValues("comment_desc")[Integer.parseInt(request.getParameter("target_vc_seq_idx"))]);
			kubeDto.setReg_date(DateUtil.getCurrentDateTime());
			kubeDto.setReg_empno((String) request.getSession().getAttribute("SESS_EMPNO"));
			
			retVal = String.valueOf(kubeService.insertUserComment(kubeDto)); 
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error( "failed!", e );
		} finally{
			response.setHeader("Content-Type", "text/html; charset=utf-8");
			response.getWriter().write(retVal);
		}    
	}
	
	@RequestMapping("/kube/deleteUserComment.do")
	@ResponseBody
	public void deleteUserComment(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception{		
		
		String retVal = "false"; 
		
		try{ 
			kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(kubeDto.getVi_seq_hash())[0])));
			kubeDto.setVc_seq(Integer.parseInt(String.valueOf(hashids.decrypt(kubeDto.getVc_seq_hash())[0])));
			kubeDto.setVc_status(9);
			kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
			
			kubeService.deleteUserComment(kubeDto); 
			
			retVal = "true"; 
		} catch (Exception e) {
			e.printStackTrace();
			log.error( "failed!", e );
		} finally{
			response.setHeader("Content-Type", "text/html; charset=utf-8");
			response.getWriter().write(retVal);
		}    
	}
	
	
	@RequestMapping("/kube/getCommentList.do")
    public ModelAndView getCommentList(KubeDto kubeDto, HttpServletRequest request, HttpServletResponse response){
    	ModelAndView mv = new ModelAndView();
    	
    	try {
    		String gubun = request.getParameter("gubun");
    		
    		if("all".equals(gubun)){
	    		kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
	    		kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(kubeDto.getVi_seq_hash())[0])));
	    		kubeDto.setSelOrder(request.getParameter("o"));
	    		
	    		List<HashMap<String, String>> commentList = kubeService.getCommentList(kubeDto);
	    		
				mv.setViewName("/kube/commentForm");
				mv.addObject("commentList", commentList);
    		}else if("one".equals(gubun)){
    			//대댓글 신규 등록 후 1건 가져옴
	    		kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(kubeDto.getVi_seq_hash())[0])));
	    		
	    		List<HashMap<String, String>> commentList = kubeService.getNewComment(kubeDto);
	    		
				mv.setViewName("/kube/commentDummy");
				mv.addObject("commentList", commentList);
				mv.addObject("pCnt", request.getParameter("pCnt"));
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    		log.error( "failed!", e );
    	}  
    	
    	return mv;
    }
	
	@RequestMapping("/kube/reportReqV_C.do")
    @ResponseBody
	public void reportReqV_C(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception{		
    	
		String retVal = "false"; 
		
		try{ 
    		kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(kubeDto.getVi_seq_hash_r())[0])));
    		if(kubeDto.getReport_gubun() == 2){
    			kubeDto.setVc_seq(Integer.parseInt(String.valueOf(hashids.decrypt(kubeDto.getVc_seq_hash_r())[0])));
    		}
    		kubeDto.setReg_date(DateUtil.getCurrentDateTime());
			kubeDto.setReg_empno((String) request.getSession().getAttribute("SESS_EMPNO"));
			
			kubeService.insertReportReqV_C(kubeDto); 
			
			retVal = "true";
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally{
			response.setHeader("Content-Type", "text/html; charset=utf-8");
			response.getWriter().write(retVal);
		}
	}
	/* 상세페이지 기능 액션 끝 */
	
	/* 마이페이지 시작*/
    @RequestMapping("/kube/mypage/bookmarkList.do")
    public ModelAndView favorList(KubeDto kubeDto, BindingResult result, HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		kubeDto.setPerPageCnt(20);
    		kubeDto.setSelOrder(StringUtil.isNull(kubeDto.getSelOrder(), "reg_date"));
    		kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
    		
    		List<HashMap<String, String>> videoList = kubeService.getMyBookMarkList(kubeDto);
    		
    		int totalCnt = kubeService.getMyBookMarkListCnt(kubeDto);
    		
    		mv.setViewName("/kube/mypage/videoBookmarkList");
    		mv.addObject("web_url", Constants.KUBE_UPLOAD_ASP_IP);
    		mv.addObject("paging", kubeDto);
    		mv.addObject("videoList", videoList);
        	mv.addObject("totalCnt", totalCnt);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
    @RequestMapping("/kube/mypage/deleteMyBookMarkVideo.do")
    @ResponseBody
	public void deleteMyBookMarkVideo(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception{		
    	
		String retVal = "false"; 
		
		try{ 
			
			retVal = kubeService.deleteMyBookMarkVideo(kubeDto, request);
			
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally{
			response.setHeader("Content-Type", "text/html; charset=utf-8");
			response.getWriter().write(retVal);
		}
	}
    
    @RequestMapping("/kube/mypage/downloadReqList.do")
    public ModelAndView downloadReqList(KubeDto kubeDto, BindingResult result, HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		kubeDto.setSelOrder(StringUtil.isNull(kubeDto.getSelOrder(), "0"));
    		kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
    		     
    		List<HashMap<String, String>> videoList = kubeService.getMyDownLoadReqList(kubeDto);
    		
    		int totalCnt = kubeService.getMyDownLoadReqListCnt(kubeDto);
    		
    		mv.setViewName("/kube/mypage/downloadReqList");
    		mv.addObject("web_url", Constants.KUBE_UPLOAD_ASP_IP);
    		mv.addObject("paging", kubeDto);
    		mv.addObject("videoList", videoList);
        	mv.addObject("totalCnt", totalCnt);
        	mv.addObject("codeList", this.getCodeList("13"));
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
    @RequestMapping("/kube/updateApproveVideo.do")
    @ResponseBody
	public void updateApproveVideo(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception{		
    	
		String retVal = "false"; 
		
		try{ 
			kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(kubeDto.getVi_seq_hash())[0])));
			kubeDto.setVa_status(Integer.parseInt(String.valueOf(hashids.decrypt(kubeDto.getVa_status_hash())[0])));
			
			retVal = kubeService.insertApproveReqVideo(kubeDto, request); 
			
			retVal = "true";
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally{
			response.setHeader("Content-Type", "text/html; charset=utf-8");
			response.getWriter().write(retVal);
		}
	}
    
    @RequestMapping("/kube/mypage/videoMgmtList.do")
    public ModelAndView videoMgmtList(KubeDto kubeDto, BindingResult result, HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		kubeDto.setPerPageCnt(20);
    		kubeDto.setSelOrder(StringUtil.isNull(kubeDto.getSelOrder(), "reg_date"));
    		kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
    		
    		List<HashMap<String, String>> videoList = kubeService.getMyVideoMgmtList(kubeDto);
    		
    		int totalCnt = kubeService.getMyVideoMgmtListCnt(kubeDto);
    		
    		mv.setViewName("/kube/mypage/videoMgmtList");
    		mv.addObject("web_url", Constants.KUBE_UPLOAD_ASP_IP);
    		mv.addObject("paging", kubeDto);
    		mv.addObject("videoList", videoList);
        	mv.addObject("totalCnt", totalCnt);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
    @RequestMapping("/kube/mypage/updateMyVideoFlag.do")
    @ResponseBody
	public void updateMyVideoFlag(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception{		
    	
		String retVal = "false"; 
		
		try{ 
			retVal = kubeService.updateMyVideoFlag(kubeDto, request); 
			
			retVal = "true";
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally{
			response.setHeader("Content-Type", "text/html; charset=utf-8");
			response.getWriter().write(retVal);
		}
	}
    
    @RequestMapping("/kube/mypage/approveReqList.do")
    public ModelAndView approveReqList(KubeDto kubeDto, BindingResult result, HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		kubeDto.setPerPageCnt(20);
    		 
    		
    		kubeDto.setSelOrder(StringUtil.isNull(kubeDto.getSelOrder(), "approve_date"));
    		kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
    		
    		//동영상 관리에서 다운로드 요청 건수를 클릭하고 넘어온 경우 해당 페이지로 이동시켜준다.
    		if(StringUtil.isNotEmpty(kubeDto.getVi_seq_hash())){
    			kubeDto.setVi_seq(Integer.parseInt(String.valueOf(hashids.decrypt(kubeDto.getVi_seq_hash())[0])));
    			kubeDto.setPageNo(kubeService.getTargetPageNum(kubeDto));
    		}
    		
    		List<HashMap<String, String>> videoList = kubeService.getMyApproveMgmtList(kubeDto);
    		
    		int totalCnt = kubeService.getMyApproveMgmtListCnt(kubeDto);
    		
    		List<HashMap<String, String>> approveList = kubeService.getMyVideoApproveSubList(kubeDto);
    		
    		mv.setViewName("/kube/mypage/approveReqList");
    		mv.addObject("web_url", Constants.KUBE_UPLOAD_ASP_IP);
    		mv.addObject("paging", kubeDto);
    		mv.addObject("videoList", videoList);
    		mv.addObject("approveList", approveList);
        	mv.addObject("totalCnt", totalCnt);
        	mv.addObject("targetVi_seq", kubeDto.getVi_seq_hash());
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
    @RequestMapping("/kube/mypage/updateMyVideoApproveFlag.do")
    @ResponseBody
	public void updateMyVideoApproveFlag(KubeDto kubeDto , BindingResult result, HttpServletRequest request, HttpServletResponse response)throws Exception{		
    	
		String retVal = "false"; 
		
		try{ 
			retVal = kubeService.updateMyVideoApproveFlag(kubeDto, request); 
			
			retVal = "true";
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally{
			response.setHeader("Content-Type", "text/html; charset=utf-8");
			response.getWriter().write(retVal);
		}
	}
    
    @RequestMapping("/kube/mypage/videoCommentList.do")
    public ModelAndView videoCommentList(KubeDto kubeDto, BindingResult result, HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		kubeDto.setSelOrder(StringUtil.isNull(kubeDto.getSelOrder(), "comment_date"));
    		kubeDto.setEmpno((String) request.getSession().getAttribute("SESS_EMPNO"));
    		
    		List<HashMap<String, String>> videoList = kubeService.getMyCommentMgmtList(kubeDto);
    		
    		int totalCnt = kubeService.getMyCommentMgmtListCnt(kubeDto);
    		
    		mv.setViewName("/kube/mypage/videoCommentList");
    		mv.addObject("web_url", Constants.KUBE_UPLOAD_ASP_IP);
    		mv.addObject("paging", kubeDto);
    		mv.addObject("videoList", videoList);
        	mv.addObject("totalCnt", totalCnt);
        	mv.addObject("codeList", this.getCodeList("14"));
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
	
    @RequestMapping("/kube/mypage/customizeMenu.do")
    public ModelAndView kubeCategoryMgmt(HttpServletRequest request){
    	ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	
    	try{
    		mv.setViewName("/kube/mypage/customLeftMenu");
    		mv.addObject("kubeLeftMenuList", kubeService.getCustomtMenu((String) request.getSession().getAttribute("SESS_EMPNO")));
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return mv;
    }
    
    @RequestMapping("/kube/mypage/insertMyCustomMenu.do")
    @ResponseBody
	public void insertMyCustomMenu(HttpServletRequest request, HttpServletResponse response)throws Exception{
    	String retVal = "false"; 
		              
		try{
			retVal = kubeService.insertMyCustomMenu(request); 
		} catch (Exception e) {
			e.printStackTrace();
    		log.error( "failed!", e );
		} finally{
			if(retVal.equals("true")){
				HttpSession session = request.getSession();
	    		
	    		if(session != null){
	    			session.setAttribute("SESS_KUBE_MENU", kubeService.getLeftMenu((String) request.getSession().getAttribute("SESS_EMPNO")));
	    		}
			}
			
			response.getWriter().write(retVal);
		}
	}
    
    @SuppressWarnings("unchecked")
	@RequestMapping("/kube/updateElearnVideoUserMap.do")
    @ResponseBody
    public void updateElearnVideoUserMap(HttpServletRequest request, HttpServletResponse response)throws Exception{
    	String retVal = "false"; 
    	
    	try{
    		DataMap dataMap = new DataMap(request, "non_encoding");
    		dataMap.put("empno", String.valueOf(request.getSession().getAttribute("SESS_EMPNO")));
    		dataMap.put("vi_seq", Integer.parseInt(String.valueOf(hashids.decrypt(dataMap.getNVLString("vi_seq_hash"))[0])));

    		retVal = kubeService.insertUpdateElearnVideoUserMap(dataMap);
    	} catch (Exception e) {
    		e.printStackTrace();
    		log.error( "failed!", e );
    	} finally{
    		if(retVal.equals("true")){
    			HttpSession session = request.getSession();
    			
    			if(session != null){
    				session.setAttribute("SESS_KUBE_MENU", kubeService.getLeftMenu((String) request.getSession().getAttribute("SESS_EMPNO")));
    			}
    		}
    		
    		response.getWriter().write(retVal);
    	}
    }
    
    /* 마이페이지 끝*/
    
    /**
     * 코드 가져옴. 
     * where code_gubun in (inQuery)
     */
    protected List<HashMap<String, String>> getCodeList(String inQuery){
        
        List<HashMap<String, String>> codeList = null;
        
        try {
        	codeList = kubeService.getCodeList(inQuery);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        
        return codeList;
    }
    
    @RequestMapping("/kube/downloadKubeManual.do")
	public ModelAndView taskAttFileDown(HttpServletRequest req, ImgBoardDto imgBoardDto) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		try{
			File downloadFile = new File("C:\\2009media\\resource\\KUBE_MANUAL.pdf");
			
			mv.setView(downloadView);
			mv.addObject("downloadFile", downloadFile);
			mv.addObject("fileName", "KUBE_MANUAL.pdf");
			
		}catch (Exception e) {
		}finally {}
		
		return mv;
	}
    
    @RequestMapping("/kube/kubeContentsFrame.do")
    public ModelAndView kubeContentsFrame(HttpServletRequest req, ImgBoardDto imgBoardDto) throws Exception {
    	
    	ModelAndView mv = new ModelAndView();
    	
    	DataMap map = new DataMap(req);
    	
    	mv.addObject("result", map);
    	mv.setViewName("/kube/kubeContentsFrame");
    	return mv;
    }
    
    
    class KubeModelAndView extends ModelAndView {

    	/**
    	 * ModelAndView mv = new KubeModelAndView(kubeService, request);  
    	 * kube메뉴는 레프트 메뉴 항상 가져와서 처리해야 함
    	 */
    	public KubeModelAndView(KubeUserService kubeService, HttpServletRequest request) {
    		try{
    			
    			HttpSession session = request.getSession();
    			@SuppressWarnings("unchecked")
				List<HashMap<String, String>> kube_menu = (List<HashMap<String, String>>) session.getAttribute("SESS_KUBE_MENU");
				
				//큐브 레프트 메뉴 가져오기
				if(kube_menu != null
						&& kube_menu.size() > 0){
					this.addObject("kubeLeftMenu", session.getAttribute("SESS_KUBE_MENU"));
				}else{
					session.setAttribute("SESS_KUBE_MENU", kubeService.getLeftMenu((String) request.getSession().getAttribute("SESS_EMPNO")));
					
					this.addObject("kubeLeftMenu", session.getAttribute("SESS_KUBE_MENU"));
				}
    		}catch(Exception e){
    			e.printStackTrace();
    		}
    	}
    }
}
