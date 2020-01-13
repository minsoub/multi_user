package kr.co.neodreams.multi_user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.dto.ContentsDto;
import kr.co.neodreams.multi_user.dto.DisplayBoardDto;
import kr.co.neodreams.multi_user.dto.StatisticsDto;
import kr.co.neodreams.multi_user.service.ContentsService;
import kr.co.neodreams.multi_user.service.DisplayBoardService;
import kr.co.neodreams.multi_user.service.StatisticsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MypageController extends BaseController{

    @Autowired
    ContentsService contentsService;

    @Autowired
    DisplayBoardService displayBoardService;

    @Autowired
    StatisticsService statisticsService;

    /* 컨텐츠 제작 신청 내역 */
    @RequestMapping("/mypageContentsList.do")
    public ModelAndView mypageContentsList(ContentsDto contentsDto){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("mypage/mypageContentsList");

        /*-------------------------조회조건 추가 START*/
        /*사번97101841*/
        //String sM_MEMPNO = "97200572";/*세션에서 사번취득 후 삽입*/
        String sM_MEMPNO = SESS_EMPNO;
        contentsDto.setSM_MEMPNO(sM_MEMPNO);

        List<ContentsDto> resultList = null;
        int totalCnt = 0;
        try {
            Map<String, Object> resultMap = new HashMap<String, Object>();
            /*DB조회 결과 취득*/
            resultMap = contentsService.getMypageContentsList(contentsDto);
            /*조회 결과에서 리스트 취득*/
            resultList = extractedContentsDto(resultMap);
            /*조회 결과에서 리스트 카운트*/
            totalCnt = (int) resultMap.get("totalCnt");

            /*화면에 가져갈 리스트 담기*/
            mv.addObject("applicationList", resultList);
            /*화면에 가져갈 리스트 카운트 담기*/
            mv.addObject("totalCnt", totalCnt);

        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        /*페이징 처리를 위한 값 담기*/
        mv.addObject("paging", contentsDto);
        return mv;
    }

    @SuppressWarnings("unchecked")
    private List<ContentsDto> extractedContentsDto(Map<String, Object> resultMap) {
        return ((List<ContentsDto>) resultMap.get("resultList"));
    }

    /* 전광판 제작 신청 내역 */
    @RequestMapping("/mypageDisplayBoardList.do")
    public ModelAndView mypageDisplayBoardList(DisplayBoardDto displayBoardDto){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("mypage/mypageDisplayBoardList");

        /*-------------------------조회조건 추가 START*/
        /*사번97200572*/
        //String sM_MEMPNO = "07200579";/*세션에서 사번취득 후 삽입*/
        String sM_MEMPNO = SESS_EMPNO;
        displayBoardDto.setSM_MEMPNO(sM_MEMPNO);

        List<DisplayBoardDto> resultList = null;
        int totalCnt = 0;
        try {
            Map<String, Object> resultMap = new HashMap<String, Object>();
            /*DB조회 결과 취득*/
            resultMap = displayBoardService.getMypageDisplayBoardList(displayBoardDto);
            /*조회 결과에서 리스트 취득*/
            resultList = extractedDisplayBoardDto(resultMap);
            /*조회 결과에서 리스트 카운트*/
            totalCnt = (int) resultMap.get("totalCnt");

            /*화면에 가져갈 리스트 담기*/
            mv.addObject("applicationList", resultList);
            /*화면에 가져갈 리스트 카운트 담기*/
            mv.addObject("totalCnt", totalCnt);

        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        /*페이징 처리를 위한 값 담기*/
        mv.addObject("paging", displayBoardDto);
        return mv;
    }

    @SuppressWarnings("unchecked")
    private List<DisplayBoardDto> extractedDisplayBoardDto(Map<String, Object> resultMap) {
        return ((List<DisplayBoardDto>) resultMap.get("resultList"));
    }

    /* 이용현황 통계 내역 */
    @RequestMapping("/mypageStatistics.do")
    public ModelAndView mypageStatisticsList(StatisticsDto statisticsDto){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("mypage/mypageStatistics");

        /*-------------------------조회조건 추가 START*/

        /*test사번97101841*/
        statisticsDto.setSM_MEMPNO(SESS_EMPNO);

        List<StatisticsDto> resultList = null;
        //int totalCnt = 0;
        try {
            Map<String, Object> resultMap = new HashMap<String, Object>();
            /*DB조회 결과 취득*/
            resultMap = statisticsService.getMypageStatisticsList(statisticsDto);
            /*조회 결과에서 리스트 취득*/
            resultList = extractedStatisticsDto(resultMap);
            /*조회 결과에서 리스트 카운트*/
            //totalCnt = (int) resultMap.get("totalCnt");

            /*화면에 가져갈 리스트 담기*/
            mv.addObject("applicationList", resultList);
            /*화면에 가져갈 리스트 카운트 담기*/
            //mv.addObject("totalCnt", totalCnt);

        } catch (Exception e) {
            // TODO TRY/CATCH
            e.printStackTrace();
            /*에러 화면 이동*/
            mv.setViewName("/error/error");
        }

        /*페이징 처리를 위한 값 담기*/
        mv.addObject("paging", statisticsDto);
        return mv;
    }

    @SuppressWarnings("unchecked")
    private List<StatisticsDto> extractedStatisticsDto(Map<String, Object> resultMap) {
        return ((List<StatisticsDto>) resultMap.get("resultList"));
    }

    /*장비신청내역*/
    @RequestMapping("/mypageRentalList.do")
    public ModelAndView mypageRentalList(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("mypage/mypageRentalList");
        return mv;
    }
}
