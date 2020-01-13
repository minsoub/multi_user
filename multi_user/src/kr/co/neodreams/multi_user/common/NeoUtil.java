package  kr.co.neodreams.multi_user.common;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Iterator;

public class NeoUtil {
	
	private static DecimalFormat df = null;
	
	public NeoUtil() {
			
	} 
	
	/**
	 * java.lang.String.trim()이 문자열이 <code>null</code>인 경우
	 * <code>NullPointException</code> 던지지만 이 메소드는
	 * <codE>null</code>를 리턴한다
	 *
	 * @see #clean(String str)
	 */
	public static String trim(String str)
	{
		return trim(str, null);
	}

    /**
     * java.lang.String.trim()과 같이 공백을 제거해주고 문자열이 null인
     * 경우는 빈 문자열을 리턴한다.
     */
    public static String clean(String str)
    {
        return trim(str, "");
    }
    
    /**
     * java.lang.String.trim()과 같이 공백을 제거해주고 문자열이 null인
     * 경우는 빈 문자열을 리턴한다.
     */
    public static String cleanNum(String str)
    {
        return trim(str, "0");
    }

    /**
	 * 문자열의 공백을 제거한다. 문자열이 null이라면 default value를
	 * 리턴한다.
	 *
	 * @param str	trim하고자 하는 string을 나타낸다
	 * @param def	default value를 나타낸다
	 */
	public static String trim(String str, String def)
	{
		return (null == str ? def : str.trim());
	}
	
	
	/* 일련번호등의  앞에 원하는 문자를 .. */
	public static String appendLeft(String src, String apchar, int len)
	{
		int count = len - src.trim().length();
		for(int i=0;i<count;i++)
		    src = apchar.trim() + src.trim();

	    return src;
	}
	
	/**
	 * DISH PK 생성
	 * DISH13093000001
	 */
	public String getMaxCode(String get_code){
		
		String str_MaxCode = "";
			
		if("0".equals(get_code)){
		
			str_MaxCode = "DISH" + CommonUtil.getToday().substring(2,8) + "00001";
		
		}else{
		
			if(!StringUtil.isEmpty(get_code)){
				
				int iCode = Integer.valueOf(get_code.substring(10,get_code.length())) + 1;

				str_MaxCode = get_code.substring(0,10) + this.appendLeft(String.valueOf(iCode), "0", 5);
				
			}else{
				str_MaxCode = "";
			}
		}
		
		return str_MaxCode;
	}
	
	/**
	 * PUB PK 생성
	 * PUB13093000000000000000001
	 */
	public String getMaxPubCode(String get_code){
		
		String str_MaxCode = "";
			
		if("0".equals(get_code)){
		
			str_MaxCode = "PUB" + CommonUtil.getToday().substring(2,8) + "00000000000000001";
		
		}else{
		
			if(!StringUtil.isEmpty(get_code)){
				
				int iCode = Integer.valueOf(get_code.substring(9,get_code.length())) + 1;

				str_MaxCode = get_code.substring(0,9) + this.appendLeft(String.valueOf(iCode), "0", 17);
				
			}else{
				str_MaxCode = "";
			}
		}
		
		return str_MaxCode;
	}
	
	/**
	 * IMG PK 생성
	 * IMG13093000000000000000001
	 */
	public String getMaxImgCode(String get_code){
		
		String str_MaxCode = "";
			
		if("0".equals(get_code)){
		
			str_MaxCode = "IMG" + CommonUtil.getToday().substring(2,8) + "00000000000000001";
		
		}else{
		
			if(!StringUtil.isEmpty(get_code)){
				
				int iCode = Integer.valueOf(get_code.substring(9,get_code.length())) + 1;

				str_MaxCode = get_code.substring(0,9) + this.appendLeft(String.valueOf(iCode), "0", 17);
				
			}else{
				str_MaxCode = "";
			}
		}
		
		return str_MaxCode;
	}
	
	/**
	 * request.getParameter 시 한글깨짐 방지
	 */
	public static String toKorean(String str){
		
		String retVal = "";
		
		try {
			if(!StringUtil.isEmpty(str))
				retVal = new String(str.getBytes("8859_1"), "KSC5601");
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return retVal;
	}
	
	public static String getStrDateTime(String datetime) {

		StringBuilder sb = new StringBuilder();
		
		if(!StringUtil.isEmpty(datetime)){
	  		
	  		sb.append(datetime.substring(0,4));
	  		sb.append("년 ");
	  		sb.append(datetime.substring(4,6));
	  		sb.append("월 ");
	  		sb.append(datetime.substring(6,8));
	  		sb.append("일 ");
	  		sb.append(datetime.substring(8,10));
	  		sb.append(":");
	  		sb.append(datetime.substring(10,12));
	  		sb.append(":");
	  		sb.append(datetime.substring(12,14));
		}
		
		return sb.toString();
  	}
	
	/* getDateTmFormat: 날짜 Display(YYYY-MM-DD HH:MM:SS)
	 */
	public static String getDateTmFormat(String dttm) {	
		
		String newFormat = "";
		
		try
		{
			if (!StringUtil.isEmpty(dttm))
			{
				String sYear = dttm.substring(0,4);
		    	String sMonth = dttm.substring(4,6);
		    	String sDay = dttm.substring(6,8);
		    	String sHr = dttm.substring(8,10);
		    	String sMin= dttm.substring(10,12);
		    	String sSec = dttm.substring(12,14);
		    	      	
		    	newFormat = sYear +"-"+ sMonth +"-"+ sDay+ " " + sHr + ":" + sMin + ":" + sSec;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return newFormat;
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
				}
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return newFormat;
	}

	/**
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		
		NeoUtil neoUtil = new NeoUtil();
		/*
		System.out.println(StringCrypto.encrypt(EnumData.HP_WHAT, "01090718564"));
		System.out.println(StringCrypto.decrypt(EnumData.HP_WHAT, "62001E4185C6CFF7FB1A8562B96E1A06"));
		*/
		HashMap<String, String> userMap = new HashMap<String, String>(); 
		String a = "user_a";
		String b = "user_b";
		String c = "user_c";
		String d = "user_d";
		
		for(int i = 0; i < 20; i++){
			
			if(i < 5){
				userMap.put(String.valueOf(i), a + "#" + (i + 5));
			}else if(i >= 5 && i < 10){
				userMap.put(String.valueOf(i), b + "#" + (i + 5));
			}else if(i >= 10 && i < 15){
				userMap.put(String.valueOf(i), c + "#" + (i + 5));
			}else if(i >= 15 &&i < 20){
				userMap.put(String.valueOf(i), d + "#" + (i + 5));
			}
		}
		
		Iterator<String> iterator = userMap.keySet().iterator();
		while(iterator.hasNext()) {
			
		   //Stirng 객체 하나를 가져온다.
			
		    System.out.println(userMap.get(iterator.next()));
		}
		
		System.out.println("1#asdf".split("#")[1]);
		
		
		
		String phone = "15885588";
		System.out.println(phone.substring(0,4) + "-" + phone.substring(4,8));
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}
