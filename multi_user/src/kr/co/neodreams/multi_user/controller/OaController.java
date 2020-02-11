package kr.co.neodreams.multi_user.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.common.CommonUtil;
import kr.co.neodreams.multi_user.dto.OaDto;
import kr.co.neodreams.multi_user.service.OaService;

@Controller
public class OaController {
	@Autowired
	DataSourceTransactionManager dataSourceTransactionManager;
	
	@Autowired
	OaService oaService;
	
    @Resource(name = "commonUtil")
    private CommonUtil commonUtil;
    
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    
    /**
     * OA 교육장 신청 목록
     * 
     * @return
     */
    @RequestMapping("/oalist.do")
    public ModelAndView oaList(@RequestParam String date,  HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        
        //String date = oaDto.getNdate();		// 검색일자
        
        List<String> dateList = new ArrayList<String>();	// 주간일자 출력 리스트
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        Calendar calendar = Calendar.getInstance();

        int year = 0, month = 0, day = 0;
        
        // 기본 날짜 설정
        if (date == null || "".equals(date))
        {
        	year = calendar.get(Calendar.YEAR);
        	month = calendar.get(Calendar.MONTH) + 1;
        	day = calendar.get(Calendar.DAY_OF_MONTH);
        	date = year + String.format("%02d", month) + String.format("%02d", day);
        } else {
        	year = Integer.parseInt(date.substring(0, 4));
        	month = Integer.parseInt(date.substring(4, 6));
        	day = Integer.parseInt(date.substring(6, 8));
        }
        

        calendar.set(year, month-1, day);

        int todayWeek = calendar.get(Calendar.DAY_OF_WEEK);
        int temp = 0;

        // 월요일 날짜 구하기
        if (todayWeek == Calendar.TUESDAY) temp -= 1;
        else if (todayWeek == Calendar.WEDNESDAY) temp -= 2;
        else if (todayWeek == Calendar.THURSDAY) temp -= 3;
        else if (todayWeek == Calendar.FRIDAY) temp -= 4;
        else if (todayWeek == Calendar.SATURDAY) temp -= 5;
        else if (todayWeek == Calendar.SUNDAY) temp -= 6;

        calendar.add(Calendar.DAY_OF_MONTH, temp);

        String monDate = calendar.get(Calendar.YEAR) + String.format("%02d", (calendar.get(Calendar.MONTH) + 1)) + String.format("%02d", calendar.get(Calendar.DAY_OF_MONTH));

        // 주말을 제외한 주간일자를 구한다.
        for (int i = 0; i < 7; i++) {
        	if (i != 0) calendar.add(Calendar.DAY_OF_MONTH, 1);
        	int w = calendar.get(Calendar.DAY_OF_WEEK);
        	if (w == Calendar.SUNDAY || w == Calendar.SATURDAY) continue;
        	dateList.add(dateFormat.format(calendar.getTime()));
        }

        // 지난주, 다음주 구하기
        calendar.set(year, month-1, day);
        calendar.add(Calendar.DAY_OF_MONTH, -7);
        String pDate = calendar.get(Calendar.YEAR) + String.format("%02d", (calendar.get(Calendar.MONTH) + 1)) + String.format("%02d", calendar.get(Calendar.DAY_OF_MONTH));
        calendar.add(Calendar.DAY_OF_MONTH, 14);
        String nDate = calendar.get(Calendar.YEAR) + String.format("%02d", calendar.get(Calendar.MONTH) + 1) + String.format("%02d", calendar.get(Calendar.DAY_OF_MONTH));

    	Date today = new Date();
    	String reserveInterval = dateFormat.format(today); // 당일까지만 예약가능.
    	
        // 이번 주 예약 추출
        Map<String, String> rsrvMap = new HashMap<String, String>();
        Map<String, String> idMap = new HashMap<String, String>();
        
        // 예약 추출을 yyyyMMddHH24 형식의 key로 저장하면 containKey로 찾을 수 있음.
        OaDto dto = new OaDto();
        dto.setDate(date);
        List<OaDto> lst = oaService.getSelectOAList(dto);
        for (int i=0; i<lst.size(); i++)
        {
        	OaDto to = (OaDto) lst.get(i);
        	rsrvMap.put(to.getRsrv_dt(), to.getSabun());
        	
        	idMap.put(to.getRsrv_dt(), String.valueOf(to.getRsrv_id()));		// 예약번호 저장
        }
        
        
        // 화면에 필요한 변수 설정
        mv.addObject("year",  	 year);
        mv.addObject("month", 	 month);
        mv.addObject("pDate", 	 pDate);
        mv.addObject("nDate", 	 nDate);
        mv.addObject("dateList", dateList);
        mv.addObject("reserveInterval", reserveInterval);
        mv.addObject("rsrvMap",  rsrvMap);		// 예약현황
        mv.addObject("idMap",    idMap);		// 예약번호
        
        mv.setViewName("/oa/oalist");
        return mv;
    }
}
