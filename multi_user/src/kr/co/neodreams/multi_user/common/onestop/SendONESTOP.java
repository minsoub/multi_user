package kr.co.neodreams.multi_user.common.onestop;

import org.apache.log4j.Logger;

public class SendONESTOP {

	Logger log = Logger.getLogger(this.getClass());
	
	private static SendONESTOP instance = null;
	
	public static SendONESTOP getInstance() {
		if(instance == null){
			instance = new SendONESTOP();
		}		
		return instance;
	}
	
	synchronized public String sendOneStop(OneStopVO osVO) throws Exception {
		
		String retCode = "";
		
		try {
			OneStopSendThread send_thread = new OneStopSendThread(osVO);
			send_thread.start();
			
			send_thread.join();
			
			retCode = send_thread.getOneStopRetCode();
		} catch (Exception ex) {
			System.out.println("sendOneStop ERROR" + ex.getMessage());
		}
		
		return retCode;
	}
}
