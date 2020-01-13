package kr.co.neodreams.multi_user.controller;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Address;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.CalcBizDate;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.DateUtil;
import kr.co.neodreams.multi_user.common.HashidsGenerator;
import kr.co.neodreams.multi_user.common.MultiFileUploadJson;
import kr.co.neodreams.multi_user.common.mail.SendMail;
import kr.co.neodreams.multi_user.dto.ContentsDto;
import kr.co.neodreams.multi_user.dto.DisplayBoardDto;
import kr.co.neodreams.multi_user.dto.DisplayFileDto;
import kr.co.neodreams.multi_user.dto.Tbsetcd2Dto;
import kr.co.neodreams.multi_user.dto.Tbsvc_tdmsempDto;
import kr.co.neodreams.multi_user.service.ContentsService;
import kr.co.neodreams.multi_user.service.DisplayBoardService;
import kr.co.neodreams.multi_user.service.UserDetailInformationService;

@Controller
public class DisplayboardController extends BaseController{

	public static String dir_path 	= Constants.dir_display_path;

    @Autowired
    UserDetailInformationService userdiService;

    @Autowired
    DisplayBoardService displayBoardService;

    @Autowired
    ContentsService contentsService;
    
    /*이용안내*/
    @RequestMapping("/displayBoardInfo.do")
    public ModelAndView DisplayBoardInfo(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/displayboard/displayBoardInfo");
        return mv;
    }

    /*제작요청*/
    @RequestMapping("/displayBoardRequest.do")
    public ModelAndView DisplayBoardRequest(Tbsvc_tdmsempDto tbsvc_tdmsempDto ,Tbsetcd2Dto tbsetcd2Dto){
        ModelAndView mv = new ModelAndView();

        String strEmpNo = SESS_EMPNO;
        tbsvc_tdmsempDto.setEMPNO(strEmpNo);

        try {
            List userStatus = userdiService.Udi_Select(tbsvc_tdmsempDto );
            List<Tbsetcd2Dto> categoreyList = displayBoardService.display_categorey_Select(tbsetcd2Dto);
            ContentsDto accptContents = contentsService.accptContents();
            
            String str = null;
            if(accptContents.getAC_CONTENTS() != null) {
            	str = accptContents.getAC_CONTENTS().trim();
            	str = str.replaceAll("(\\r\\n|\\n)", "<br/>");
                str = str.replaceAll(" ", "&nbsp;");
                accptContents.setAC_CONTENTS(str);
            }

            String today = DateUtil.getToday();
            SimpleDateFormat df= new SimpleDateFormat("yyyy-MM-dd");
            
            mv.addObject("categoreyList", categoreyList);
            mv.addObject("userStatus", userStatus);
            mv.addObject("accptContents", accptContents);
            
            mv.addObject("biz_date_over_3", df.format(CalcBizDate.getLastNWeekdays(4, Integer.parseInt(DateUtil.getMonth(today)) - 1, Integer.parseInt(today.substring(6, 8)))));
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        mv.addObject("MEMPNO",strEmpNo);
        mv.setViewName("/displayboard/displayBoardRequest");
        return mv;
    }
    
    @ResponseBody
    @RequestMapping("/applicantRequest.do")
    public void applicantRequest(HttpServletResponse res, String empNo){
    	try {
    		res.setContentType("text/html;charset=UTF-8");
        	Tbsvc_tdmsempDto tbsvc_tdmsempDto = new Tbsvc_tdmsempDto();
        	tbsvc_tdmsempDto.setEMPNO(empNo);
        	List list = userdiService.Udi_Select(tbsvc_tdmsempDto);
        	net.sf.json.JSONArray jsonArray = net.sf.json.JSONArray.fromObject(list);
        	PrintWriter writer = res.getWriter();
    		writer.print(jsonArray);
    	}catch (Exception e) {
    		e.printStackTrace();
			// TODO: handle exception
		}
    }

    @RequestMapping("/displayBoard/Insert.do")
    public ModelAndView insert(HttpServletRequest req,HttpServletResponse res,DisplayBoardDto displayBoardDto,
            DisplayFileDto displayFileDto )throws Exception{
        ModelAndView mv = new ModelAndView();
        boolean result     = false;                                 //저장 성공 여부

        File targetDir = new File(dir_path);
        if(!targetDir.exists()) {
            targetDir.mkdirs();
        }

        MultiFileUploadJson multiFileUploadJson = new MultiFileUploadJson();
        MultiFileUploadJson jsondel = new MultiFileUploadJson();
        JSONObject jsonObject = multiFileUploadJson.MultiFileUploadJson(req, dir_path);
        String jsondepth = "true";  //파일 업로드 성공여부 체크  (기본값 true)
        if(!jsonObject.isEmpty()){
            jsondepth = jsonObject.get("isSuccess").toString();
            JSONObject jsondepth2 = null;
            /*System.out.println("성공여부:"+jsondepth);*/
            JSONArray jsonArr = (JSONArray)jsonObject.get("datas");
            for(int i=0;i<jsonArr.size();i++){
                jsondepth2 = (JSONObject)jsonArr.get(i);
            }
            /*파일 엄로드 실폐시 일괄 삭제*/
            if("false".equals(jsondepth)){
                jsondel.MultiFileDelJson(jsonObject, dir_path);
            }
        }

        if("true".equals(jsondepth)){
            try {
                result = displayBoardService.display_Insert(displayBoardDto, jsonObject);
            } catch (Exception e) {
                /*트렌젝션 에러시 파일  일괄 삭제*/
                if(!jsonObject.isEmpty()){
                    jsondel.MultiFileDelJson(jsonObject, dir_path);
                }
                e.printStackTrace();
            }
        }

        result =(result == true)?true:false;
        mv.addObject("Complete", result);
        mv.setViewName("/displayboard/save");
        return mv;
    }
    
    @ResponseBody
    @RequestMapping("/displayBoard/displayAccept.do")
    public void displayAccept(HttpServletRequest req,HttpServletResponse res, DisplayBoardDto displayBoardDto )throws Exception{
    	String retVal = "false";
    	try {
    		//승인대기(3094) -- 접수완료, 승인요청
    		displayBoardDto.setSM_LSTATE("3094");
    		boolean updateChk = displayBoardService.display_Update(displayBoardDto, null);
    		if(updateChk) {
    			retVal = "success";
    			/* 메일발송 파트 */
    			SendMail mail = SendMail.getInstance();
    			Address[] toAddrs = null;
    			List<DisplayBoardDto> displayDetail = null; 
    			displayDetail     = displayBoardService.getDisplayDetail(displayBoardDto);
    			if(displayDetail.size() != 0) {
    				toAddrs = new Address[displayDetail.size()];
    				HashMap<String, String> map = new HashMap<>();
    				map.put("mail_Type", "D");
    				map.put("SM_SEQ", displayBoardDto.getSHSEQNUM());
    				if(displayDetail.get(0).getSDP_APPROVER_FST_EMPNO() != null 
    						&& !"".equals(displayDetail.get(0).getSDP_APPROVER_FST_EMPNO())) {
    					InternetAddress address = new InternetAddress(displayDetail.get(0).getSDP_APPROVER_FST_EMPNO() + "@kepco.co.kr");
        				toAddrs[0] = address;
        				map.put("status", displayBoardDto.getSM_LSTATE());
        				map.put("paramEmpno", displayDetail.get(0).getSDP_APPROVER_FST_EMPNO());
        				mail.contents_sendMail(toAddrs, map);
    				}
    			}
    			
    			/* 메일발송 파트 END */
    		}
     	}catch (Exception e) {
    		e.printStackTrace();
		}finally {
			res.getWriter().write(retVal);
		}
    }
    
    @ResponseBody
    @RequestMapping("/displayBoard/displayApprove.do")
    public void displayApprove(HttpServletRequest req,HttpServletResponse res, DisplayBoardDto displayBoardDto )throws Exception{
    	String retVal = "false";
    	try {
    		//승인대기(3094) -- 접수완료, 승인요청
    		
    		/* 본인인증 체크 */
			List<DisplayBoardDto> displayDetail = null; 
			displayDetail     = displayBoardService.getDisplayDetail(displayBoardDto);
    		/* 본인인증 체크 END */

			if("SND".equals(displayBoardDto.getApproveState())) {
				displayBoardDto.setSM_LSTATE("3099");
    		}
    		boolean updateChk = displayBoardService.display_Approve(displayBoardDto);
    		if(updateChk) {
	    		if(!"SND".equals(displayBoardDto.getApproveState())) {
	    			/* 메일발송 파트 */
	    			SendMail mail = SendMail.getInstance();
	    			Address[] toAddrs = null;
	    			if(displayDetail.size() != 0) {
	    				toAddrs = new Address[displayDetail.size()];
	    				HashMap<String, String> map = new HashMap<>();
	    				map.put("mail_Type", "D");
	    				map.put("SM_SEQ", displayBoardDto.getSHSEQNUM());
	    				if(displayDetail.get(0).getSDP_APPROVER_SND_EMPNO() != null 
	    						&& !"".equals(displayDetail.get(0).getSDP_APPROVER_SND_EMPNO())) {
	    					InternetAddress address = new InternetAddress(displayDetail.get(0).getSDP_APPROVER_SND_EMPNO() + "@kepco.co.kr");
	        				toAddrs[0] = address;
	        				map.put("status", displayDetail.get(0).getSM_LSTATE());
	        				map.put("paramEmpno", displayDetail.get(0).getSDP_APPROVER_SND_EMPNO());
	        				mail.contents_sendMail(toAddrs, map);
	    				}
	    			}
	    		}
    			retVal = "success";
    		}
    	}catch (Exception e) {
    		e.printStackTrace();
		}finally {
			res.getWriter().write(retVal);
		}
    }
    
    
    /*진행사항*/
    @RequestMapping("/displayBoardProgress.do")
    public ModelAndView DisplayBoardProgress(DisplayBoardDto displayBoardDto,Tbsetcd2Dto tbsetcd2Dto){
        ModelAndView mv = new ModelAndView();

        List<DisplayBoardDto> contentsList = null;
        int totalCnt = 0;

        try {
            List<Tbsetcd2Dto> categoreyList = displayBoardService.display_categorey_Select(tbsetcd2Dto);
            contentsList     = displayBoardService.getDisplayList(displayBoardDto);
            totalCnt          = displayBoardService.getDisplayListCnt(displayBoardDto);
            
            /*garbageFileChk*/
        	List<DisplayBoardDto> delfileChk = displayBoardService.delfileChk();
        	
        	if(delfileChk.size() > 0) {
        		for(int i = 0; i < delfileChk.size(); ++i) {
        			File file = new File(delfileChk.get(i).getSDP_phycalPath());
        			if(file.exists()) {
						file.delete();
					}
        			int SDP_SEQ =  Integer.parseInt(delfileChk.get(i).getSDP_SEQ());
        			displayBoardService.diplayFileAjax(SDP_SEQ);
        		}
        	}

            mv.addObject("categoreyList", categoreyList);
            mv.addObject("contentsList", contentsList);
            //페이징처리
            mv.addObject("totalCnt", totalCnt);
            mv.addObject("paging", displayBoardDto);


            mv.setViewName("/displayboard/displayBoardProgress");
        } catch (Exception e) {
            e.printStackTrace();
            mv.setViewName("/error/error");
        }

        return mv;
    }

    /*view Detail*/
    @RequestMapping("/displayDetail.do")
    public ModelAndView DisplayDetail(HttpServletRequest req, DisplayBoardDto displayBoardDto, Tbsetcd2Dto tbsetcd2Dto){
        ModelAndView mv = new ModelAndView();
        List<DisplayBoardDto> displayDetail = null;
        try {
        	List<Tbsetcd2Dto> categoreyList = displayBoardService.display_categorey_Select(tbsetcd2Dto);
        	HashidsGenerator hashids = new HashidsGenerator(Constants.KUBE_SEQ_SALT, 15);
        	String sm_Seq = String.valueOf(hashids.decrypt(displayBoardDto.getSHSEQNUM())[0]);
        	displayBoardDto.setSHSEQNUM(sm_Seq);
            displayDetail     = displayBoardService.getDisplayDetail(displayBoardDto);
            /*강정우 추가*/
            displayBoardDto.setSearchStatus("U");
            List<DisplayBoardDto> contentFileList = displayBoardService.contentFileList(displayBoardDto);
            displayBoardDto.setSearchStatus("M");
            List<DisplayBoardDto> completeFileList = displayBoardService.contentFileList(displayBoardDto);
            String str = null;
            
            if(displayDetail.get(0).getAC_CONTENTS() != null) {
            	str = displayDetail.get(0).getAC_CONTENTS().trim();
            	str = str.replaceAll("(\\r\\n|\\n)", "<br/>");
                str = str.replaceAll(" ", "&nbsp;");
            }
            mv.addObject("AC_CONTENTS1", str);
            /*END*/
            mv.addObject("mode", displayBoardDto.getMode());
            mv.addObject("mode2", displayBoardDto.getMode2());
            mv.addObject("categoreyList", categoreyList);
            mv.addObject("displayDetail", displayDetail);
            mv.addObject("contentFileList", contentFileList);
            mv.addObject("completeFileList", completeFileList);
            //페이징처리
            mv.addObject("paging", displayBoardDto);
            //다운로드 권한처리를 위한 사번 취득
            mv.addObject("sessEmpno", SESS_EMPNO);
        } catch (Exception e) {
            // TODO: handle exception
        }
        mv.setViewName("/displayboard/displayDetail");
        return mv;
    }
    
    @RequestMapping("/multi/mailContents.do")
    public ModelAndView mailContents(HttpServletRequest req, HttpServletResponse res,  @RequestParam HashMap<String, Object> map) throws Exception {
    	ModelAndView mv = new ModelAndView();
    	
    	HashidsGenerator hashids = new HashidsGenerator(Constants.KUBE_SEQ_SALT, 15);
    	String sm_Seq = String.valueOf(hashids.decrypt((String) map.get("sm_seq"))[0]);
    	String contentType = (String) map.get("contentType");
    	List<?> detailContents = null;
    	Tbsetcd2Dto tbsetcd2Dto = new Tbsetcd2Dto();
    	List<Tbsetcd2Dto> tbSetList = new ArrayList<>();

    	if("C".equals(contentType)) {
    		//컨텐츠 제작
    		ContentsDto contentsDto = new ContentsDto();
    		tbSetList = contentsService.contents_categorey_Select(tbsetcd2Dto);
    		contentsDto.setSHSEQNUM(sm_Seq);
    		detailContents     = contentsService.getContentsDetail(contentsDto);
    		
    	}else if("D".equals(contentType)) {
    		//전광판 게시
    		DisplayBoardDto displayBoardDto = new DisplayBoardDto();
    		tbSetList = displayBoardService.display_categorey_Select(tbsetcd2Dto);
    		displayBoardDto.setSHSEQNUM(sm_Seq);
    		detailContents = displayBoardService.getDisplayDetail(displayBoardDto);
    	}
    	mv.addObject("mail_Type", contentType);
    	mv.addObject("shseqnum", map.get("sm_seq"));
    	mv.addObject("categoreyList", tbSetList);
    	mv.addObject("resultView", detailContents);
    	mv.setViewName("/displayboard/mailContents");
    	return mv;
    }
    
    

    /*수정*/
    @RequestMapping("/displayBoard/Modify.do")
    public ModelAndView ContentsModify(HttpServletRequest req, DisplayBoardDto displayBoardDto) throws Exception{
        ModelAndView mv = new ModelAndView();
        HashidsGenerator hashids = new HashidsGenerator(Constants.KUBE_SEQ_SALT, 15);
        String sm_Seq;
        try {
        	sm_Seq = String.valueOf(hashids.decrypt(displayBoardDto.getSHSEQNUM())[0]);
        	displayBoardDto.setSHSEQNUM(sm_Seq);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
        
    	//String sm_Seq = String.valueOf(hashids.decrypt(displayBoardDto.getSHSEQNUM())[0]);
        boolean result     = false;                                 //저장 성공 여부

        String[] fileOgName = req.getParameterValues("fileOgName");    //오리지널 이름체크

        MultiFileUploadJson multiFileUploadJson = new MultiFileUploadJson();
        JSONObject jsonObject = multiFileUploadJson.MultiFileUploadJson(req, dir_path);
        String jsondepth = "true";  //파일 업로드 성공여부 체크  (기본값 true)
        if(!jsonObject.isEmpty()){
            jsondepth = jsonObject.get("isSuccess").toString();
            JSONObject jsondepth2 = null;
            JSONArray jsonArr = (JSONArray)jsonObject.get("datas");
            String savename = null;
            for(int i=0;i<jsonArr.size();i++){
                jsondepth2 = (JSONObject)jsonArr.get(i);
                savename = jsondepth2.get("saveFileName").toString();
                if(!savename.isEmpty()){
                String delPath =  dir_path + fileOgName[i];
                File f = new File(delPath);
                f.delete();
                }
            }
        }

        if("true".equals(jsondepth)){
            try {
                result = displayBoardService.display_Update(displayBoardDto ,jsonObject);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        result =(result == true)?true:false;
        mv.addObject("Complete", result);
        mv.addObject("mode", "1");
        mv.addObject("SM_SEQ",displayBoardDto.getSM_SEQ());
        mv.setViewName("/displayboard/save");
        return mv;
    }

    /*삭제*/
    @RequestMapping("/displayDel.do")
    public ModelAndView ContentsDel(HttpServletRequest req, DisplayBoardDto displayBoardDto) throws Exception{
    	ModelAndView mv = new ModelAndView();
        try {
        	HashidsGenerator hashids = new HashidsGenerator(Constants.KUBE_SEQ_SALT, 15);
        	String sm_Seq = String.valueOf(hashids.decrypt(displayBoardDto.getSHSEQNUM())[0]);
        	displayBoardDto.setSHSEQNUM(sm_Seq);
    		displayBoardService.display_Del(displayBoardDto);
		} catch (Exception e) {
			// TODO: handle exception
		}
    	
        mv.addObject("Complete", true);
        mv.addObject("mode", "2");
        mv.addObject("SM_SEQ",displayBoardDto.getSM_SEQ());
        mv.setViewName("/displayboard/save");
        return mv;
    }
    
    
    /*파일 제거 20190704 강정우 추가*/
	@RequestMapping("/removeDisplayFile.do")
	public void removeDisplayFile(HttpServletRequest req, HttpServletResponse res, DisplayBoardDto displayBoardDto) throws Exception{
		String retVal = "false";
		
		try {
			int SDP_SEQ = Integer.parseInt(req.getParameter("SDP_SEQ"));
			
			DisplayBoardDto selectFile = displayBoardService.removeDisplayFile(SDP_SEQ);
			
			if(selectFile != null) {
				File file = new File(selectFile.getSDP_phycalPath()); 
				if(file.exists()) {
					file.delete();
				}
				displayBoardService.diplayFileAjax(SDP_SEQ);
			}
			retVal = "true";
		} catch (Exception e) {
			e.printStackTrace();			
		}finally {
			res.getWriter().write(retVal);
		}
	}
	
	/*작업 완료*/
	@ResponseBody
    @RequestMapping("/displayCompleteFile.do")
    public void displayCompleteFile(HttpServletRequest req,HttpServletResponse res, DisplayBoardDto displayBoardDto) throws Exception{
		String retVal = "true";
		
		try {
			if(!"".equals(displayBoardDto.getFileSeq_4()) && displayBoardDto.getFileSeq_4() != null ) {
				displayBoardService.completeFile(displayBoardDto);
			}
			if(!"".equals(displayBoardDto.getSDP_PLANDATE()) && displayBoardDto.getSDP_PLANDATE() != null ) {
				boolean updateChk = displayBoardService.display_Update(displayBoardDto, null);
			}

			displayBoardDto.setSM_LSTATE("3095");
			displayBoardService.lstateUpdate(displayBoardDto);
			/* 메일발송 파트 */
			SendMail mail = SendMail.getInstance();
			Address[] toAddrs = null;
			List<DisplayBoardDto> displayDetail = null; 
			displayDetail     = displayBoardService.getDisplayDetail(displayBoardDto);
			if(displayDetail.size() != 0) {
				toAddrs = new Address[displayDetail.size()];
				HashMap<String, String> map = new HashMap<>();
				
				map.put("mail_Type", "D");
				map.put("SM_SEQ", displayBoardDto.getSHSEQNUM());
				
				InternetAddress address = new InternetAddress(displayDetail.get(0).getSM_MEMPNO() + "@kepco.co.kr");
				toAddrs[0] = address;
				map.put("status", displayBoardDto.getSM_LSTATE());
				map.put("paramEmpno", displayDetail.get(0).getSM_MEMPNO());
				mail.contents_sendMail(toAddrs, map);
			}
			
			/* 메일발송 파트 END */
		} catch (Exception e) {
			e.printStackTrace();
			retVal = "false";
		}finally {
			res.getWriter().write(retVal);
		}
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/displayExcelDown.do")
	public @ResponseBody byte[] contentsExcelDown (HttpServletResponse res, HttpServletRequest req, DisplayBoardDto displayBoardDto) throws Exception{
		
		displayBoardDto.setXmlGubun("excelDown");
		
		List<DisplayBoardDto> displayList = null;
        int totalCnt = 0;
		String[] prefix = null;
		String fileGubun = null;
		DisplayBoardDto TotalList = displayBoardService.TotalList(displayBoardDto);
		displayList     = displayBoardService.getDisplayList(displayBoardDto);
		prefix = new String[]{"번호", "신청번호", "신청일자", "제목", "부서1", "부서2", "부서3", "신청자", "완료예정일", "북측", "남측", "[EV]로비", "[E/V]내부", "상태", "게시일시", "비고"};
		fileGubun = "전광판 신청처리현황_";
		
		ArrayList headerList = new ArrayList<>();
		Map<String, Object> commandMap = new HashMap();
		
		headerList.add(0, prefix);
		commandMap.put("excelName", "Display");
		commandMap.put("sheetName", "");
		commandMap.put("colName", headerList);
		commandMap.put("resultList" , displayList);
		commandMap.put("TotalList" , TotalList);
		
		byte[] bytes = displayBoardService.excelDown(commandMap, req, res);
		
		Calendar calendar = Calendar.getInstance();
		Date date = calendar.getTime();
		String today = (new SimpleDateFormat("yyyyMMdd").format(date));
		String fileName = null;
		
		fileName = fileGubun+today;
		String docName ="";
		
		String userAgent = req.getHeader("User-Agent");
		boolean br = userAgent.indexOf("Chrome") > -1;
		
		if(br){
			docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
		} else {
			docName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
		}
		
		res.setHeader("Content-Disposition", "attachment; filename="+docName+".xls");
		res.setContentLength(bytes.length);
		res.setContentType("application/vnd.ms-excel");
		res.setHeader("Pragma", "no-cache");		
		res.setHeader("Cache-Control", "private");
		res.setHeader("Expires", "0");
			
		return bytes;
		}
	
	@RequestMapping("/displayPrint.do")
	public ModelAndView  displayPrint(HttpServletRequest req, DisplayBoardDto displayBoardDto) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/displayboard/approvePrintDoc");
		try {
        	displayBoardDto.setSHSEQNUM(req.getParameter("strID"));
			List<DisplayBoardDto> displayDetail = null; 
			displayDetail     = displayBoardService.getDisplayDetail(displayBoardDto);
			displayBoardDto.setSearchStatus("U");
            List<DisplayBoardDto> contentFileList = displayBoardService.contentFileList(displayBoardDto);
            displayBoardDto.setSearchStatus("M");
            List<DisplayBoardDto> completeFileList = displayBoardService.contentFileList(displayBoardDto);
			mv.addObject("displayDetail", displayDetail);
			mv.addObject("displayFileList", contentFileList);
			mv.addObject("completeFileList", completeFileList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
}
