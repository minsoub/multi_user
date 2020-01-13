package kr.co.neodreams.multi_user.common;

import java.text.DecimalFormat;

public class TldUtil {
	
	private static DecimalFormat df = null;
	
	public TldUtil() {
		
	} 
		
	/* getDateTmFormat: 날짜 Display(YYYY-MM-DD HH:MM:SS)
	*/
	public static String getDateTmFormat(String dttm, String type, String format) {	
		
		String newFormat = "";

		try
		{
			if (!StringUtil.isEmpty(dttm))
			{
				String sYear 	= "";
		    	String sMonth 	= "";
		    	String sDay 	= "";
		    	String sHr 		= "";
		    	String sMin		= "";
		    	String sSec 	= "";

				if(dttm.length() == 14){
					sYear = dttm.substring(0,4);
			    	sMonth = dttm.substring(4,6);
			    	sDay = dttm.substring(6,8);
			    	sHr = dttm.substring(8,10);
			    	sMin= dttm.substring(10,12);
			    	sSec = dttm.substring(12,14);
				}else if(dttm.length() == 12){
					sYear = dttm.substring(0,4);
			    	sMonth = dttm.substring(4,6);
			    	sDay = dttm.substring(6,8);
			    	sHr = dttm.substring(8,10);
			    	sMin= dttm.substring(10,12);
				}else if(dttm.length() == 8){
					sYear = dttm.substring(0,4);
			    	sMonth = dttm.substring(4,6);
			    	sDay = dttm.substring(6,8);
				}else if(dttm.length() == 4){
					sHr = dttm.substring(0,2);
			    	sMin= dttm.substring(2,4);
				}
		    	
				if("1".equals(format)){	//년월일시분초
			    	newFormat = sYear + type + sMonth + type + sDay+ " " + sHr + ":" + sMin + ":" + sSec;
				}else if("2".equals(format)){	//년월일시분
			    	newFormat = sYear + type + sMonth + type + sDay+ " " + sHr + ":" + sMin;
				}else if("3".equals(format)){	//년월일
					newFormat = sYear + type + sMonth + type + sDay;
				}else if("4".equals(format)){	//시분초
					newFormat = sHr + ":" + sMin + ":" + sSec;
				}else if("5".equals(format)){	//시분
					newFormat = sHr + ":" + sMin;
				}else if("6".equals(format)){	//시분
					newFormat = sYear + type + sMonth;
				}
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return newFormat;
	}
	
  	//사업자번호  / 법인번호(주민번호) - 입력
  	//111-22-33333 / 123659-4569874
  	public static String bizFormat(String bizno){
  		String reBizno = "";
  		if(bizno == null) return reBizno;
  		if(10 == bizno.trim().length()){
			reBizno = bizno.substring(0,3) + "-" + bizno.substring(3,5) + "-" + bizno.substring(5,10); 
  		} else if(13 == bizno.trim().length()) {
  			reBizno = bizno.substring(0,6) + "-" + bizno.substring(6,13);
  		} else {
  			reBizno = "xxx";
  		}
			return reBizno;
  	}
	  	
  	/**
  	 * 핸드폰 번호 자르는 메소드
  	 */
  	public static String hpFormat(String phone){
  		String rePhone = "";
  		if(phone == null) return rePhone;
  		if(11 == phone.trim().length()){
  			rePhone = phone.substring(0,3) + "-" + phone.substring(3,7) + "-" + phone.substring(7,11);
  		} else if(10 == phone.trim().length()) {
  			rePhone = phone.substring(0,3) + "-" + phone.substring(3,6) + "-" + phone.substring(6,10);
  		} else if(9 == phone.trim().length()) {
  			rePhone = phone.substring(0,2) + "-" + phone.substring(2,5) + "-" + phone.substring(5,9);
  		} else {
  			rePhone = "xxx";
  		}
  		return rePhone;
  	}
  	
  	
  	/*한전에서 사용한 커스텀 날짜 변환*/
  	public static String changday(String date){
  		String sYear 	="";
  		String sMonth 	="";
  		String sDay 	="";
  		String sumday   ="";
  		
  		sYear 	= date.substring(0,4);
    	sMonth 	= date.substring(4,6);
    	sDay 	= date.substring(6,8);
    	
    	sumday 	= sYear+"-"+sMonth+"-"+sDay;
    	return sumday;
  	}
  	
  	/*한전에서 사용한 커스텀 날짜 변환2*/
  	public static String changday2(String date){
  		String sYear 	="";
  		String sMonth 	="";
  		String sDay 	="";
  		String sumday   ="";
  		String hh		="";
  		String mm		="";
  		sYear 	= date.substring(0,4);
    	sMonth 	= date.substring(4,6);
    	sDay 	= date.substring(6,8);
    	hh		= date.substring(8,10);
    	mm		= date.substring(10,12);
    	
    	sumday 	= sYear+"-"+sMonth+"-"+sDay+" "+hh+":"+mm;
    	return sumday;
  	}
  	/*컨텐츠제작 카테고리 이름 추출*/
  	public static String svc2Name(String code){
  		String newcode = code.trim();
  		String thisName = "";
  		if(newcode.equals("3079")){
  			thisName = "매체 변환";
  		}else if(newcode.equals("3080")){
  			thisName = "영상편집";
  		}else if(newcode.equals("3081")){
  			thisName = "파워포인트";
  		}else if(newcode.equals("3082")){
  			thisName = "이미지 제작";
  		}else if(newcode.equals("3083")){
  			thisName = "세미나 교육자료 제작";
  		}else if(newcode.equals("3092")){
  			thisName = "기타";
  		}
  		return thisName;
  	}
  	
  	public static String codeStatus(String code){
  		/*
  		3093 = 신청
  		3094 = 접수/제작중   => 진행중 => 승인대기
  		3095 = 정상완료 => 완료
  		3096 = 미처리종료  => 완료
  		3097 = 사용자취소  => 유지
  		3098 = 미승인종료  => 완료
  		3275 = 검수중
  		3099 = 진행중
  		3100 = 반려
  		*/
  		String newcode = code.trim();
  		String thisName = "";
  		if(newcode.equals("3093")){
  		  	thisName = "<p class='con-font-0'>신청</p>";
  		}else if(newcode.equals("3094")){
  		  	thisName = "<p class='con-font-5'>승인대기</p>";
  		}else if(newcode.equals("3095") || newcode.equals("3098")){
  		  	thisName = "<p class='con-font-2'>완료</p>";
  		}else if(newcode.equals("3097")){
  		  	thisName = "<p class='con-font-3'>사용자취소</p>";
  		}else if(newcode.equals("3099")){
  		  	thisName = "<p class='con-font-1'>진행중</p>";
  		}else if(newcode.equals("3275")){
  		  	thisName = "<p class='con-font-2'>검수중</p>";
  		}else if(newcode.equals("3096")){
            thisName = "<p class='con-font-2'>완료</p>";
        }
  		return thisName;
  	}
  	
  	/*디스플레이 카테고리 이름 추출*/
  	public static String svc2NameDisplay(String code){
  		String newcode = code.trim();
  		String thisName = "";
  		if(newcode.equals("3074")){
  			thisName = "[한전본관] 북측 LED";
  		}else if(newcode.equals("3075")){
  			thisName = "[한전본관] 남측 LED";
  		}else if(newcode.equals("3076")){
  			thisName = "[한전본관] 엘리베이터 로비";
  		}else if(newcode.equals("3272")){
  			thisName = "[E/V]내부";
  		}else if(newcode.equals("3274")){
  			thisName = "[E/V]경영진";
  		}else if(newcode.equals("3277")){
  			thisName = "[남측]키오스크";
  		}else if(newcode.equals("3278")){
  			thisName = "[한전본관]31층";
  		}
  		return thisName;
  	}
  	
  	/*kube 특정 seq 암호화*/
  	public static String seqEncode(String seq){
  		String encSeq = "";
  		try{
  			HashidsGenerator hashids = new HashidsGenerator(Constants.KUBE_SEQ_SALT, 15);
  			encSeq = hashids.encrypt(Integer.parseInt(seq));
  		}catch(Exception e){
  			e.printStackTrace();
  		}
  		
  		return encSeq;
  	}
  	
  	/*kube 초를 시간으로 변환*/
  	public static String secToHour(String sec){
  		String retHour = "0";
  		try{
  			int time = Integer.parseInt(StringUtil.isNull(sec, "0"));
  			
			retHour = NeoUtil.appendLeft(String.valueOf((time / 3600)), "0", 2) 
					+ ":" 
					+ NeoUtil.appendLeft(String.valueOf((time % 3600 / 60)), "0", 2)
					+ ":" 
					+ NeoUtil.appendLeft(String.valueOf((time % 3600 % 60)), "0", 2);
  		}catch(Exception e){
  			e.printStackTrace();
  		}
  		
  		return retHour;
  	}
  	
  	/*문자열 자르기*/
  	public static String splitStr(String str, String len){
  		String retStr = "";
  		
  		try{
  			retStr = StringUtil.crop(str, Integer.parseInt(len), "...");
  		}catch(Exception e){
  			e.printStackTrace();
  		}
  		
  		return retStr;
  	}
  	
  	/*행사 신청 상태*/
  	public static String retPStatus(String p_status){
  		String retVal = "";
  		
  		if("1".equals(p_status)){
  			retVal = "신청";
  		}else if("2".equals(p_status)){
  			retVal = "승인";
  		}else if("3".equals(p_status)){
  			retVal = "반려";
  		}else if("4".equals(p_status)){
  			retVal = "취소";
  		}else if("6".equals(p_status)){
  			retVal = "완료";
  		}
  		
  		return retVal;
  	}
  	
  	/*행사 주체*/
  	public static String retPTarget(String p_target_code, String p_target_desc){
  		String retVal = "";
  		
  		if("1".equals(p_target_code)){
  			retVal = "CEO";
  		}else if("2".equals(p_target_code)){
  			retVal = "본부장";
  		}else if("3".equals(p_target_code)){
  			retVal = p_target_desc;
  		}
  		
  		return retVal;
  	}
  	
  	/*해당 월의 말일*/
  	public static String monthLastDate(String date) throws Exception{
  		return DateUtil.getLastDayAfterMonth(date, 0);
  	}
}
