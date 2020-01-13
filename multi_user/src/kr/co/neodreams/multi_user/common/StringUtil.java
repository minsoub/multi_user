package  kr.co.neodreams.multi_user.common;

import java.io.UnsupportedEncodingException;

import org.jdom.Document;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;

public class StringUtil {
	private StringUtil() {
	}
	
	/**tri
	 * 문자열이 빈 문자열이면 해당 값을 리턴한다.
	 *
	 * <blockquote><pre>
	 * boolean b = StringUtil.isEmpty("  "); // true
	 * String str = null;
	 * beolean b1 = StringUtil.isEmpty(str); // true
	 * </pre></blockquote>
	 *
	 * @param str 체크하고자 하는 문자열을 나타낸다
	 * @return 문자열이 비어있으면 <code>true</code>를 리턴하고 비어있지 않다면
	 *			<code>false</code>를 리턴한다. 문자열이 <code>null</code>이거나
	 * 			trim시에 길이가 <code>0</code>이라면 빈 문자열로 간주한다.
	 */
	public static String isNull(String str, String returnStr)
	{
		if((str == null || str.trim().length() == 0 || "null".equals(str))){
			return returnStr;
		} else {
			return str;
		}
	}

	/**tri
	 * 문자열이 빈 문자열인지를 체크한다.
	 *
	 * <blockquote><pre>
	 * boolean b = StringUtil.isEmpty("  "); // true
	 * String str = null;
	 * beolean b1 = StringUtil.isEmpty(str); // true
	 * </pre></blockquote>
	 *
	 * @param str 체크하고자 하는 문자열을 나타낸다
	 * @return 문자열이 비어있으면 <code>true</code>를 리턴하고 비어있지 않다면
	 *			<code>false</code>를 리턴한다. 문자열이 <code>null</code>이거나
	 * 			trim시에 길이가 <code>0</code>이라면 빈 문자열로 간주한다.
	 */
	public static boolean isEmpty(String str)
	{
		return (str == null || str.trim().length() == 0 || "null".equals(str));
	}

	public static boolean isNotEmpty(String str)
	{
		boolean chk = false;
		
		if(StringUtil.isEmpty(str)){
			chk = false;
		}else{
			chk = true;
		}
		
		return chk;
	}
	
	
    public static String replaceAll(String text, String oldChar, String newChar) {
        String newText = text;
        if (text != null) {
            StringBuffer sb = new StringBuffer((int)(text.length() * 1.5));
            int index = 0;
            while ( (index = text.indexOf(oldChar)) > -1) {
                sb.append(text.substring(0, index));
                sb.append(newChar);
                if (index + oldChar.length() < text.length()) {
                    text = text.substring(index + oldChar.length());    
                } else {
                    text = "";
                    break;
                }
            }
            sb.append(text);
            newText = sb.toString();
            
        }
        return newText;
    }

	/**
	 * 길이를 초과하는 문자열을 길이만큼 자른후 꼬리문자열을 붙인다.
	 * 
	 * @param source 원본 문자열
	 * @param length 최대 길이
	 * @param tail 꼬리문자열
	 * @param charset 문자셋
	 * @return 길이만큼 잘라진 문자열
	 */
	public static String crop(String source, int length, String tail, String charset) throws UnsupportedEncodingException {
		if (source == null) return null;
		String result = source;
		int sLength = 0;
		int bLength = 0;
		char c;
		
		if ( result.getBytes(charset).length > length) {
		    length = length - tail.length();
			while ( (bLength + 1) <= length) {
				c = result.charAt(sLength);
				bLength++;
				sLength++;
				if (c > 127) bLength++;
			}
			result = result.substring(0, sLength) + tail;
		}
		return result;
	}
	
	/**
	 * 길이를 초과하는 문자열을 길이만큼 자른후 꼬리문자열을 붙인다.
	 * 
	 * @param source 원본 문자열
	 * @param length 최대 길이
	 * @param tail 꼬리문자열
	 * @return 길이만큼 잘라진 문자열
	 */
	public static String crop(String source, int length, String tail) {
		if (source == null) return null;
		
		if (tail == null) tail = "";
		
		String result = source;
		int sLength = 0;
		int bLength = 0;
		char c;
		
		if ( result.getBytes().length > length) {
		    length = length - tail.length();
			while ( (bLength + 1)  <= length) {
				c = result.charAt(sLength);
				bLength++;
				sLength++;
				if (c > 127) bLength++;
			}
			result = result.substring(0, sLength) + tail;
		}
		return result;
		
	}
	
	public static int ONE_BYTE_MIN = 0x0000;
	public static int ONE_BYTE_MAX = 0x007F;
	public static int TWO_BYTE_MIN = 0x0080;
	public static int TWO_BYTE_MAX = 0x07FF;
	public static int THREE_BYTE_MIN = 0x0800;
	public static int THREE_BYTE_MAX = 0xFFFF;
	public static int SURROGATE_MIN = 0x10000;
	public static int SURROGATE_MAX = 0x10FFFF;



	public static String cropUTF8(String str, int maxByteSize, String trail) throws UnsupportedEncodingException {
		if (str == null) {
			return null;
		}

		byte strByte[] = str.getBytes("UTF-8");

		if (strByte.length <= maxByteSize) {
			return str;
		}

		int trailByteSize = 0;

		if (trail != null) {
			trailByteSize = trail.getBytes("UTF-8").length;
		}

		maxByteSize = maxByteSize - trailByteSize;

		int endPos = 0;
		int currByte = 0;

		for (int i = 0; i < str.length(); i++) {
			char ch = str.charAt(i);
			currByte = currByte  + availableByteNum(ch);
			
			if(currByte > maxByteSize) {
				endPos = currByte - availableByteNum(ch);
				break;
			}
		}

		byte newStrByte[] = new byte[endPos];
		System.arraycopy(strByte, 0, newStrByte, 0, endPos);

		String newStr = new String(newStrByte, "UTF-8");
		newStr += trail;

		return newStr;

	}

	public static int availableByteNum(char c) {
		int digit = (int)c;
		
		if (ONE_BYTE_MIN <= digit && digit <= ONE_BYTE_MAX) {
			return 1;
		} else if (TWO_BYTE_MIN <= digit && digit <= TWO_BYTE_MAX) {
			return 2;
		} else if (THREE_BYTE_MIN <= digit && digit <= THREE_BYTE_MAX) {
			return 3;
		} else if (SURROGATE_MIN <= digit && digit <= SURROGATE_MAX) {
			return 4;
		}
		
		return -1;
	}
	
	public static String htmlCrop(String str, int length, String tail) {
		StringBuffer result = new StringBuffer();

		int remain = length;
		int position = 0;
		int bIndex = -1;
		int eIndex = -1;
		String temp = str;
		
		while (position < temp.length()) {
			bIndex = temp.indexOf("<");
			eIndex = temp.indexOf(">", bIndex);
			
			if (bIndex > -1) {
				if (remain > 0) {
					result.append(crop(temp.substring(0, bIndex), remain, tail));
				}
				if (bIndex < eIndex) {
					position = eIndex + 1;
					result.append(temp.substring(bIndex, position));
					temp = temp.substring(position);
				} else {
					if (remain > 0) {
						result.append(crop(temp, remain, tail));
						temp = "";
					}
				}	
			} else {
				if (remain > 0) {
					result.append(crop(temp, remain, tail));
						temp = "";
				}
				position = temp.length();
			}
		}

		if (remain > 0) {
			result.append(crop(temp, remain, tail));
		}
		
		return result.toString();
	}
	
	
	/**
	 * 문자숫자 랜덤값 ( ex: Xy3 )
	 * @param iCipher 자릿수
	 * @return
	 */
	public static String getRandomStringCharNum(int iCipher) {
		StringBuffer	sbRandom	= new StringBuffer();
		
		if ( iCipher > 0 ) {
			for( int i = 0; i < iCipher; i++ ) {
				if ( i % 3 == 0 ) {
					sbRandom.append( getUpperCaseCharacter() );
				}
				else if ( i % 3 == 1 ) {
					sbRandom.append( getLowerCaseCharacter() );
				}
				else if ( i % 3 == 2 ) {
					sbRandom.append( String.valueOf( getNumber() ) );
				}
			}
		}
		
		return sbRandom.toString();
	}
	
	
	/**
	 * 문자 랜덤값 ( ex: Ab )
	 * @param iCipher 자릿수
	 * @return
	 */
	public static String getRandomStringChar(int iCipher) {
		StringBuffer	sbRandom	= new StringBuffer();
		
		if ( iCipher > 0 ) {
			for( int i = 0; i < iCipher; i++ ) {
				if ( i % 2 == 0 ) {
					sbRandom.append( getUpperCaseCharacter() );
				}
				else if ( i % 2 == 1 ) {
					sbRandom.append( getLowerCaseCharacter() );
				}
			}
		}
		
		return sbRandom.toString();
	}
	
	/**
	 * 숫자 랜덤값 ( ex: 9563 )
	 * @param iCipher 자릿수
	 * @return
	 */
	public static String getRandomStringNum(int iCipher) {
		StringBuffer	sbRandom	= new StringBuffer();
		
		if ( iCipher > 0 ) {
			for( int i = 0; i < iCipher; i++ ) {
				sbRandom.append( getNumber() );
			}
		}
		
		return sbRandom.toString();
	}
	
	public static char getUpperCaseCharacter() {
		return (char)Math.floor( Math.random() * ( 90 - 65 + 1 ) + 65 );
	}
	public static char getLowerCaseCharacter() {
		return (char)Math.floor( Math.random() * ( 122 - 97 + 1 ) + 97 );
	}
	public static int getNumber() {
		return (int)( Math.floor( Math.random() * 10 ) );
	}

	public static String format9line(String appno) {
		final int nineLine = 9;
		
		StringBuilder sb = new StringBuilder();
		
		int strLength = appno.length();
		
		if (strLength <= 9) {
			int marginLength = nineLine - strLength;
			
			for (int i = 0; i < marginLength; i++) {
				sb.append("0");								
			}
			
			sb.append(appno);			
		} else {
			sb.append("000000000");
		}

		return sb.toString();
	}
}
