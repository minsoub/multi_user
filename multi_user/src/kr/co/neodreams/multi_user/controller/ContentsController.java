package kr.co.neodreams.multi_user.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
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
import org.json.simple.parser.JSONParser;
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
import kr.co.neodreams.multi_user.common.CalcBizDate;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.DateUtil;
import kr.co.neodreams.multi_user.common.DownloadView;
import kr.co.neodreams.multi_user.common.HashidsGenerator;
import kr.co.neodreams.multi_user.common.MultiFileUploadJson;
import kr.co.neodreams.multi_user.common.mail.SendMail;
import kr.co.neodreams.multi_user.dto.ContentsDto;
import kr.co.neodreams.multi_user.dto.ImgBoardDto;
import kr.co.neodreams.multi_user.dto.Tbsetcd2Dto;
import kr.co.neodreams.multi_user.dto.Tbsvc_tdmsempDto;
import kr.co.neodreams.multi_user.service.ContentsService;
import kr.co.neodreams.multi_user.service.NoticeService;
import kr.co.neodreams.multi_user.service.UserDetailInformationService;

@Controller
public class ContentsController extends BaseController{

	public static String dir_path 	= Constants.dir_contents_path;

    @Autowired
    UserDetailInformationService userdiService;

    @Autowired
    ContentsService contentsService;
    
	@Autowired
	DataSourceTransactionManager dataSourceTransactionManager;
	
	@Autowired
	NoticeService noticeService;
	
	@Autowired
	DownloadView dowoloadView;


    /*이용안내*/
    @RequestMapping("/contentsInfo.do")
    public ModelAndView ContensInfo(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/contents/contentsInfo");
        return mv;
    }

    /*제작요청*/
    @RequestMapping("/contentsRequest.do")
    public ModelAndView ContensRequest(Tbsvc_tdmsempDto tbsvc_tdmsempDto ,Tbsetcd2Dto tbsetcd2Dto, ContentsDto contentsDto){
        ModelAndView mv = new ModelAndView();

        String strEmpNo = SESS_EMPNO;
        tbsvc_tdmsempDto.setEMPNO(strEmpNo);

        try {
            List userStatus = userdiService.Udi_Select(tbsvc_tdmsempDto );
            List<Tbsetcd2Dto> categoreyList = contentsService.contents_categorey_Select(tbsetcd2Dto);
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
            
            int nowTime = Integer.parseInt(DateUtil.getCurrentDateTime().substring(8, 10));
            
            //18시 이후 건은 업무일 4일 뒤 완료 가능
            if(nowTime >= 18){
            	mv.addObject("biz_date_over_3", df.format(CalcBizDate.getLastNWeekdays(5, Integer.parseInt(DateUtil.getMonth(today)) - 1, Integer.parseInt(today.substring(6, 8)))));
            }else{
            	mv.addObject("biz_date_over_3", df.format(CalcBizDate.getLastNWeekdays(4, Integer.parseInt(DateUtil.getMonth(today)) - 1, Integer.parseInt(today.substring(6, 8)))));
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        mv.addObject("MEMPNO",strEmpNo);
        mv.setViewName("/contents/contentsRequest");
        return mv;
    }

    @RequestMapping("/contents/Insert.do")
    public ModelAndView insert(HttpServletRequest req,HttpServletResponse res,ContentsDto contentsDto)throws Exception{
        ModelAndView mv = new ModelAndView();
        boolean result         = false;                                 //저장 성공 여부
        
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
                result = contentsService.contens_Insert(contentsDto, jsonObject);
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
        mv.setViewName("/contents/save");
        return mv;
    }

    /*진행사항*/
    @RequestMapping("/contentsProgress.do")
    public ModelAndView ContensProgress(ContentsDto contentsDto,Tbsetcd2Dto tbsetcd2Dto){
        ModelAndView mv = new ModelAndView();

        List<ContentsDto> contentsList = null;
        List<ContentsDto> contentsCount= null;
        int totalCnt = 0;

        try {
        	/*20190529 매체 건수*/
        	List<Tbsetcd2Dto> svc2Cnt = contentsService.svc2Cnt();
        	/*garbageFileChk*/
        	List<ContentsDto> delfileChk = contentsService.delfileChk();
        	
        	if(delfileChk.size() > 0) {
        		for(int i = 0; i < delfileChk.size(); ++i) {
        			File file = new File(delfileChk.get(i).getSCF_phycalPath());
        			if(file.exists()) {
						file.delete();
					}
        			int SCF_SEQ =  Integer.parseInt(delfileChk.get(i).getSCF_SEQ());
        			contentsService.ContentsFileAjax(SCF_SEQ);
        		}
        	}
        	
            //List<Tbsetcd2Dto> categoreyList = contentsService.contents_categorey_Select(tbsetcd2Dto);
            contentsList     = contentsService.getContentsList(contentsDto);
            totalCnt          = contentsService.getContentsListCnt(contentsDto);
            contentsCount    = contentsService.getContentsCount(contentsDto);

            mv.addObject("svc2Code", svc2Cnt);
            
            //mv.addObject("categoreyList", categoreyList);
            mv.addObject("contentsList", contentsList);
            mv.addObject("contentsCount", contentsCount);
            //페이징처리
            mv.addObject("totalCnt", totalCnt);
            mv.addObject("paging", contentsDto);

            mv.setViewName("/contents/contentsProgress");
        } catch (Exception e) {
            e.printStackTrace();
            mv.setViewName("/error/error");
        }

        return mv;
    }

    /*view Detail*/
    @RequestMapping("/contentsDetail.do")
    public ModelAndView ContentsDetail(HttpServletRequest req, ContentsDto contentsDto,Tbsetcd2Dto tbsetcd2Dto){
        ModelAndView mv = new ModelAndView();
        List<ContentsDto> contentsDetail = null;
        
        try {
        	HashidsGenerator hashids = new HashidsGenerator(Constants.KUBE_SEQ_SALT, 15);
        	String sm_Seq = String.valueOf(hashids.decrypt(contentsDto.getSHSEQNUM())[0]);
        	contentsDto.setSHSEQNUM(sm_Seq);
        	
            List<Tbsetcd2Dto> categoreyList = contentsService.contents_categorey_Select(tbsetcd2Dto);
            contentsDetail     = contentsService.getContentsDetail(contentsDto);
            /*20190618추가 강정우*/
            String str = null;
            if(contentsDetail.get(0).getAC_CONTENTS() != null) {
            	str = contentsDetail.get(0).getAC_CONTENTS().trim();
            	str = str.replaceAll("(\\r\\n|\\n)", "<br/>");
                str = str.replaceAll(" ", "&nbsp;");
            }
            
            contentsDto.setSearchStatus("U");
            List<ContentsDto> contentFileList = contentsService.contentFileList(contentsDto);
            contentsDto.setSearchStatus("M");
            List<ContentsDto> completeFileList = contentsService.contentFileList(contentsDto);
            
            mv.addObject("AC_CONTENTS1", str);
            mv.addObject("mode", contentsDto.getMode());
            mv.addObject("mode2", contentsDto.getMode2());
            mv.addObject("categoreyList", categoreyList);
            mv.addObject("contentsDetail", contentsDetail);
            mv.addObject("contentFileList", contentFileList);
            mv.addObject("completeFileList", completeFileList);
            //페이징처리
            mv.addObject("paging", contentsDto);
            //다운로드 권한처리를 위한 사번 취득
            mv.addObject("sessEmpno", SESS_EMPNO);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        mv.setViewName("/contents/contentsDetail");
        return mv;
    }

    /*신청자 부분 수정*/
    @RequestMapping("/contents/Modify.do")
    public ModelAndView ContentsModify(HttpServletRequest req, ContentsDto contentsDto) throws Exception{
        ModelAndView mv = new ModelAndView();
        
        try {
        	HashidsGenerator hashids = new HashidsGenerator(Constants.KUBE_SEQ_SALT, 15);
        	String sm_Seq = String.valueOf(hashids.decrypt(contentsDto.getSHSEQNUM())[0]);
        	contentsDto.setSHSEQNUM(sm_Seq);
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
        			result = contentsService.contents_Update(contentsDto ,jsonObject);
        		} catch (Exception e) {
        			e.printStackTrace();
        		}
        	}
        	result =(result == true)?true:false;
        	mv.addObject("Complete", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
        mv.addObject("mode", "1");
        mv.addObject("SM_SEQ",contentsDto.getSM_SEQ());
        mv.setViewName("/contents/save");
        return mv;
    }

    /*삭제*/
    @RequestMapping("/contentsDel.do")
    public ModelAndView ContentsDel(HttpServletRequest req, ContentsDto contentsDto) throws Exception{
    	ModelAndView mv = new ModelAndView();
    	try { 
	    		HashidsGenerator hashids = new HashidsGenerator(Constants.KUBE_SEQ_SALT, 15);
	        	String sm_Seq = String.valueOf(hashids.decrypt(contentsDto.getSHSEQNUM())[0]);
	    		contentsDto.setSHSEQNUM(sm_Seq);
    	        contentsService.contents_Del(contentsDto);
    	       
		} catch (Exception e) {
			e.printStackTrace();
		}
    	mv.addObject("Complete", true);
        mv.addObject("mode", "2");
        mv.addObject("SM_SEQ",contentsDto.getSM_SEQ());
        mv.setViewName("/contents/save");
        return mv;
    }
    
    /* 이미지 자료실 */
    @RequestMapping("/contentsImgBrdList.do")
    public ModelAndView contentsImgBrdList(HttpServletRequest req, HttpServletResponse res, ImgBoardDto imgBoardDto) throws Exception{
		ModelAndView mv = new ModelAndView();
        mv.setViewName("/contents/contentsImgBrdList");

        String secretChk = "C";
        try {

            BufferedReader fileReader = new BufferedReader(new InputStreamReader(new FileInputStream(Constants.IMGBRD_OPEN_USER_JSON_FILE),"UTF-8"));

            JSONParser p = new JSONParser();

            JSONObject jsonObj   = (JSONObject)p.parse(fileReader);

            JSONArray cdGroup = (JSONArray) jsonObj.get("ImgBrdOpenList");

            if(cdGroup != null
                    && cdGroup.size() > 0){

                int cdGroupSize = cdGroup.size();

                for(int i = 0; i < cdGroupSize; i++){

                    JSONObject cdinfo = (JSONObject) cdGroup.get(i);

                    if(cdinfo.get("user_id").equals(SESS_EMPNO)){
                    	secretChk = "O";
                    }
                }
            }else{
                System.out.println("custom_display_auth err........" + SESS_EMPNO);
            }
		} catch (Exception e) {
			// TODO: handle exception
		}
        
        imgBoardDto.setSecretChk(secretChk);
        imgBoardDto.setWrite_User(SESS_EMPNO);
        
		List<ImgBoardDto> resultList = contentsService.getImgBrdList(imgBoardDto);
		int listCnt = contentsService.getImgBrdListCnt(imgBoardDto);
		
		mv.addObject("resultList", resultList);
		mv.addObject("totalCnt", listCnt);
		mv.addObject("paging", imgBoardDto);
		return mv;
	}

	@RequestMapping("/contentsImgBrdWrite.do")
	public ModelAndView contentsImgBrdWrite(HttpServletRequest req, HttpServletResponse res, ImgBoardDto imgBoardDto) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		List<ImgBoardDto> imgBrdList = new ArrayList<>();
		imgBoardDto.setAttatch_Seq("0");
		
		imgBrdList = contentsService.garbageAttatch(imgBoardDto);
		
		if(imgBrdList.size() > 0) {
			for(int i=0; i < imgBrdList.size(); i++) {
				ImgBoardDto imgBrdFileDto = new ImgBoardDto();
				
				imgBrdFileDto = imgBrdList.get(i);
				fileDelete(imgBrdFileDto);
				contentsService.imgBrdFileDelete(imgBrdFileDto);
			}
		}
		
		mv.addObject("paging", imgBoardDto);
		mv.setViewName("/contents/contentsImgBrdWrite");
		return mv;
	}

	@RequestMapping("/contentsImgBrdDetail.do")
	public ModelAndView contentsImgBrdDetail(HttpServletRequest req, HttpServletResponse res, ImgBoardDto imgBoardDto) throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/contents/contentsImgBrdDetail");
		ImgBoardDto resultDetail = new ImgBoardDto();
		resultDetail = contentsService.getImgBrd(imgBoardDto);
		mv.addObject("paging", imgBoardDto);
		mv.addObject("resultDetail", resultDetail);
		return mv;
	}

	@RequestMapping("/contentsImgBrdUpdate.do")
	public ModelAndView contentsImgBrdUpdate(HttpServletRequest req, HttpServletResponse res, ImgBoardDto imgBoardDto) throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/contents/contentsImgBrdUpdate");
		ImgBoardDto resultDetail = new ImgBoardDto();
		resultDetail = contentsService.getImgBrd(imgBoardDto);
		mv.addObject("resultDetail", resultDetail);
		mv.addObject("paging", imgBoardDto);
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("/registContentsImgBrd.do")
	public void registContentsImgBrd(HttpServletRequest req, HttpServletResponse res, ImgBoardDto imgBoardDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			imgBoardDto.setWrite_User(SESS_EMPNO);
			imgBoardDto.setWrite_User_Name(SESS_USER_NAME);
			retVal = Integer .toString(contentsService.imgBrdInsert(imgBoardDto));
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}

	@ResponseBody
	@RequestMapping("/modifyContentsImgBrd.do")
	public void modifyContentsImgBrd(HttpServletRequest req, HttpServletResponse res, ImgBoardDto imgBoardDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			retVal = Integer.toString(contentsService.imgBrdUpdate(imgBoardDto));
			dataSourceTransactionManager.commit(status);
		}catch (Exception e) {
			retVal = "-1";
			dataSourceTransactionManager.rollback(status);
		}finally {
			res.getWriter().write(retVal);
		}
	}

	@ResponseBody
	@RequestMapping("/removeContentsImgBrd.do")
	public void removeContentsImgBrd(HttpServletRequest req, HttpServletResponse res, ImgBoardDto imgBoardDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			int fileChk = fileDelete(imgBoardDto);
			
			if(fileChk > 0) {
				retVal = Integer.toString(contentsService.imgBrdFileDelete(imgBoardDto));
				retVal = Integer.toString(contentsService.imgBrdDelete(imgBoardDto));
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
	public void removeAttatch(HttpServletRequest req, HttpServletResponse res, ImgBoardDto imgBoardDto) throws Exception{
		String retVal = "0";
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = dataSourceTransactionManager.getTransaction(def);
		
		try{
			int fileChk = fileDelete(imgBoardDto);
			
			if(fileChk > 0) {
				retVal = Integer.toString(contentsService.imgBrdFileDelete(imgBoardDto));
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
	
	
	public int fileDelete(ImgBoardDto imgBoardDto) throws Exception{
		int retVal = 0;
		
		try {
			List<ImgBoardDto> imgBrdList = new ArrayList<>();
			imgBrdList = contentsService.garbageAttatch(imgBoardDto);
			
			for(int i=0; i < imgBrdList.size(); i++) {
				ImgBoardDto getFileDto = new ImgBoardDto();
				
				getFileDto = imgBrdList.get(i);
				
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
	public ModelAndView taskAttFileDown(HttpServletRequest req, ImgBoardDto imgBoardDto) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		try{
			
			String file_Name = "";
			String file_Path = "";
			
			ImgBoardDto getFileDto = new ImgBoardDto();
			getFileDto = contentsService.getAttatch(imgBoardDto);
			
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
    
	
	/*20190610 목록 페이지*/
	@RequestMapping("/acceptList.do")
	public ModelAndView acceptList (HttpServletRequest req, HttpServletResponse res, ContentsDto contentsDto) throws Exception{
		int totalCnt = 0;
		
		ModelAndView mv = new ModelAndView();
		
		List<ContentsDto> acceptList = contentsService.acceptList(contentsDto);
		totalCnt = contentsService.acceptListCnt(contentsDto);
		
		mv.setViewName("/contents/acceptList");
		mv.addObject("acceptList", acceptList);
		mv.addObject("paging", contentsDto);
		mv.addObject("totalCnt", totalCnt);
		return mv;
	}
	
	
	//등록페이지
	@RequestMapping("/acceptWrite.do")
	public ModelAndView accptWrite(HttpServletRequest req, HttpServletResponse res, Tbsvc_tdmsempDto tbsvc_tdmsempDto)throws Exception {
		ModelAndView mv = new ModelAndView();
		try {
			String strEmpNo = SESS_EMPNO;
			Tbsvc_tdmsempDto userImp = contentsService.userImp(strEmpNo);
			
			mv.setViewName("/contents/acceptWrite");
			mv.addObject("userImp", userImp);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	//등록
	@RequestMapping("/registAcceptAjax.do")
	public void registAcceptAjax(HttpServletRequest req, HttpServletResponse res, ContentsDto contentsDto) throws Exception {
		int result = 0;
		String AC_STATUS = contentsDto.getAC_STATUS();
		try {
			result = contentsService.registAcceptAjax(contentsDto);
			if("S".equals(AC_STATUS) ) {
				contentsDto.setAC_SEQ(result);
				contentsService.statusUpdate(contentsDto.getAC_SEQ());
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = -1;
		}
		PrintWriter printWriter = res.getWriter();
		printWriter.print(result);
	}
	
	//수정페이지
	@RequestMapping("/acceptUpdate.do")
	public ModelAndView acceptUpdate(HttpServletRequest req, HttpServletResponse res, ContentsDto contentsDto)throws Exception {
		ModelAndView mv = new ModelAndView();
		try {
			ContentsDto acceptDetail = contentsService.acceptUpdate(contentsDto);
			
			mv.setViewName("/contents/acceptUpdate");
			mv.addObject("acceptList", acceptDetail);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	//수정
	@RequestMapping("/updateAcceptAjax.do")
	public void updateAcceptAjax(HttpServletRequest req, HttpServletResponse res, ContentsDto contentsDto) throws Exception {
		int result = 0;
		int AC_SEQ = contentsDto.getAC_SEQ();
		String AC_STATUS = contentsDto.getAC_STATUS();
		try {
			result = contentsService.updateAcceptAjax(contentsDto);
			if("S".equals(AC_STATUS)) {
				contentsService.statusUpdate(AC_SEQ);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = -1;
		}
		PrintWriter printWriter = res.getWriter();
		printWriter.print(result);
	}
	
	/*파일 제거*/
	@RequestMapping("/removeContentsFile.do")
	public void removeContentsFile(HttpServletRequest req, HttpServletResponse res, ContentsDto contentsDto) throws Exception{
		String retVal = "false";
		
		try {
			int SCF_SEQ = Integer.parseInt(req.getParameter("SCF_SEQ"));
			
			ContentsDto selectFile = contentsService.removeContentsFile(SCF_SEQ);
			
			if(selectFile != null) {
				File file = new File(selectFile.getSCF_phycalPath()); 
				if(file.exists()) {
					file.delete();
				}
				contentsService.ContentsFileAjax(SCF_SEQ);
			}
			
			retVal = "true";
		} catch (Exception e) {
			e.printStackTrace();			
		}finally {
			res.getWriter().write(retVal);
		}
	}
	
	/*접수자 추가정보 등록*/
	@RequestMapping("/modifyConfirmAjax.do")
	public void modifyConfirmAjax(HttpServletRequest req, HttpServletResponse res, ContentsDto contentsDto) throws Exception {
		
		boolean result = false;
		List<ContentsDto> contentsDetail = null;
		try {
			contentsDto.setSM_LSTATE("3094");
			result = contentsService.modifyConfirmAjax(contentsDto);
			if(result) {
    			/* 메일발송 파트 */
				contentsDetail     = contentsService.getContentsDetail(contentsDto);
    			SendMail mail = SendMail.getInstance();
    			if(contentsDetail.size() != 0) {
    				Address[] toAddrs = new Address[contentsDetail.size()];
    				HashMap<String, String> map = new HashMap<>();
    				map.put("mail_Type", "C");
    				map.put("SM_SEQ", Integer.toString(contentsDto.getSM_SEQ()));
    				if(!"".equals(contentsDetail.get(0).getSCT_allow1EMP()) && contentsDetail.get(0).getSCT_allow1EMP() != null ) {
    					InternetAddress address = new InternetAddress(contentsDetail.get(0).getSCT_allow1EMP() + "@kepco.co.kr");
    					toAddrs[0] = address;
        				map.put("status", contentsDto.getSM_LSTATE());
        				map.put("paramEmpno", contentsDetail.get(0).getSCT_allow1EMP());
        				mail.contents_sendMail(toAddrs, map);
    				}
    			}
    			/* 메일발송 파트 END */
    		}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		PrintWriter printWriter = res.getWriter();
		printWriter.print(result);
	}
	
	/*결재자 승인*/
	@ResponseBody
    @RequestMapping("/contentsApprove.do")
    public void contentsApprove(HttpServletRequest req,HttpServletResponse res, ContentsDto contentsDto ) throws Exception{
    	String retVal = "false";
    	List<ContentsDto> contentsDetail = null;
    	try {
    		//승인대기(3094) -- 접수완료, 승인요청
    		
    		/* 본인인증 체크 */
    		contentsDetail     = contentsService.getContentsDetail(contentsDto);
    		/* 본인인증 체크 END */
    		if("allow2EMP".equals(contentsDto.getAllow())) {
    			contentsDto.setSM_LSTATE("3099");
    		}
    		boolean updateChk = contentsService.contentsApprove(contentsDto);
    		if(updateChk) {
	    		if(!"allow2EMP".equals(contentsDto.getAllow())) {
	    			/* 메일발송 파트 */
	    			SendMail mail = SendMail.getInstance();
	    			if(contentsDetail.size() != 0) {
	    				Address[] toAddrs = new Address[contentsDetail.size()];
	    				HashMap<String, String> map = new HashMap<>();
	    				map.put("mail_Type", "C");
	    				map.put("SM_SEQ", contentsDto.getSHSEQNUM());
	    				if(contentsDetail.get(0).getSCT_allow2EMP() != null 
	    						&& !"".equals(contentsDetail.get(0).getSCT_allow2EMP())) {
	    					InternetAddress address = new InternetAddress(contentsDetail.get(0).getSCT_allow2EMP() + "@kepco.co.kr");
	        				toAddrs[0] = address;
	        				map.put("status", contentsDetail.get(0).getSM_LSTATE());
	        				map.put("paramEmpno", contentsDetail.get(0).getSCT_allow2EMP());
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
	
	/*작업완료*/
	@ResponseBody
    @RequestMapping("/completeFile.do")
    public void completeFile(HttpServletRequest req,HttpServletResponse res, ContentsDto contentsDto) throws Exception{
		String retVal = "true";
		List<ContentsDto> contentsDetail = null;
		try {
			if(!"".equals(contentsDto.getFileSeq_4()) && contentsDto.getFileSeq_4() != null ) {
				contentsService.completeFile(contentsDto);
			}
			if((!"".equals(Integer.toString(contentsDto.getSCT_ORIGQTY())) && Integer.toString(contentsDto.getSCT_ORIGQTY()) != null) 
					|| (!"".equals(contentsDto.getSCT_ORIGTEXT()) && contentsDto.getSCT_ORIGTEXT() != null)
					|| (!"".equals(contentsDto.getSCT_TDATE()) && contentsDto.getSCT_TDATE() != null)) {
				SimpleDateFormat transFormat_no 	= new SimpleDateFormat("yyyyMMdd");
				SimpleDateFormat transFormat_date 	= new SimpleDateFormat("yyyy-MM-dd");
				String SCT_TDATE = contentsDto.getSCT_TDATE();
				SCT_TDATE = transFormat_no.format(transFormat_date.parse(SCT_TDATE))+"00";
				contentsDto.setSCT_TDATE(SCT_TDATE);
				contentsService.origqtyUpdate(contentsDto);
			}
			
			contentsDto.setSM_LSTATE("3095");
			contentsService.lstateUpdate(contentsDto);
			
			/* 메일발송 파트 */
			SendMail mail = SendMail.getInstance();
			contentsDetail     = contentsService.getContentsDetail(contentsDto);
			if(contentsDetail.size() != 0) {
				Address[] toAddrs = new Address[contentsDetail.size()];
				HashMap<String, String> map = new HashMap<>();
				map.put("mail_Type", "C");
				map.put("SM_SEQ", contentsDto.getSHSEQNUM());
			
				InternetAddress address = new InternetAddress(contentsDetail.get(0).getSM_MEMPNO() + "@kepco.co.kr");
				toAddrs[0] = address;
				map.put("status", contentsDto.getSM_LSTATE());
				map.put("paramEmpno", contentsDetail.get(0).getSM_MEMPNO());
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
	@RequestMapping("/contentsExcelDown.do")
	public @ResponseBody byte[] contentsExcelDown (HttpServletResponse res, HttpServletRequest req,  ContentsDto contentsDto) throws Exception{
		
		contentsDto.setXmlGubun("excelDown");
		
		String[] prefix = null;
		List<ContentsDto> contentsList = null;
		String fileGubun = null;
			
		contentsList = contentsService.getContentsList(contentsDto);;
		prefix = new String[]{"번호", "신청번호", "등록일", "제목", "부서1", "부서2", "부서3", "신청자", "완료일", "요청일", "요청구분", "요청수량", "완료수량", "상태", "내용", "작업자"};
		fileGubun = "콘텐츠제작 신청처리현황_";
		
		ArrayList headerList = new ArrayList<>();
		Map<String, Object> commandMap = new HashMap();
		
		headerList.add(0, prefix);
		commandMap.put("excelName", "EquipmentRentalStatus");
		commandMap.put("sheetName", "");
		commandMap.put("colName", headerList);
		commandMap.put("resultList" , contentsList);
		
		byte[] bytes = contentsService.excelDown(commandMap, req, res);
		
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
	
	@RequestMapping("/contextPrint.do")
	public ModelAndView  contextPrint(HttpServletRequest req, ContentsDto contentsDto) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/contents/approvePrintPage");
		try {
			contentsDto.setSHSEQNUM(req.getParameter("strID"));
			List<ContentsDto> contentsDetail = contentsService.getContentsDetail(contentsDto);
			contentsDto.setSearchStatus("U");
			List<ContentsDto> contentFileList = contentsService.contentFileList(contentsDto);
			contentsDto.setSearchStatus("M");
            List<ContentsDto> completeFileList = contentsService.contentFileList(contentsDto);
			mv.addObject("contentsDetail", contentsDetail);
			mv.addObject("contentFileList", contentFileList);
			mv.addObject("completeFileList", completeFileList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
}
