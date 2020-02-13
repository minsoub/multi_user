package kr.co.neodreams.multi_user.controller;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.CommonUtil;

/**
 * 소프트웨어관리, 라이센스관리 Controller Class
 * @author hist
 *
 */
public class SwController extends BaseController{
	@Autowired
	DataSourceTransactionManager dataSourceTransactionManager;
	
    @Resource(name = "commonUtil")
    private CommonUtil commonUtil;
    
    
}
