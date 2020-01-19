package kr.co.neodreams.multi_user.controller;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.CommonUtil;

@Controller
public class BoardController extends BaseController{
	@Autowired
	DataSourceTransactionManager dataSourceTransactionManager;
	
    @Resource(name = "commonUtil")
    private CommonUtil commonUtil;
	/**
	 * S/W 라이센스 리스트
	 * @return
	 */
    @RequestMapping("/swlicense.do")
    public ModelAndView equipManual() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/board/license");
        return mv;
    }
    
    /**
     * OA 교육장
     * @return
     */
    @RequestMapping("/oalist.do")
    public ModelAndView oaList() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/board/oalist");
        return mv;
    }
}
