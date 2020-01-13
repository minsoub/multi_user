package kr.co.neodreams.multi_user.common;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import kr.co.neodreams.multi_user.common.mikep.ServletMikepThread;

public class ServletMikepListener implements ServletContextListener {
	
	/*마이캡 연동을 위한 리스너*/

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		
		// 마이캡 연동 서버 스레드 시작
		ServletMikepThread smt = new ServletMikepThread();
		smt.start();
		
	}
}
