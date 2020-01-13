package kr.co.neodreams.multi_user.common;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;

import javax.mail.Address;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component("commonUtil")
public class CommonUtil {

    private static DecimalFormat df = null;

        /* addZero : 인덱스의 길이만큼 Zero(0)을 붙인다.
        */
        public static String addZero(String src, int index) {
            int len = src.length();
            if(len == index) {
            } else if(len < index){
                while(len != index) {
                    src = "0" + src;
                    len = src.length();
                }
            } else {
                System.out.println("[ImUtil]String의 길이가 인덱스의 길이보다 크다.");
            }
            return src;
        }

        /* addComma : 숫자에 콤마를 붙인다
        */
        public static String addComma(String sNumber) {
            if(sNumber == null) return "0";
            else if(sNumber.equals("")) return "0";
            long lNumber=0;
            try {
                lNumber  = Long.parseLong(sNumber);
            }catch(NumberFormatException e){
                return "0";
            }
            NumberFormat nf = NumberFormat.getInstance();
            return nf.format(lNumber);
        }

        /* isNull : Null -> "" 변경
        */
        public static String isNull(String Str) {
            if(Str == null) Str = "";
            else if(Str.equals("null")) Str = "";
            //else Str = Str.trim();
            return Str;
        }

        /* getToday : 오늘날짜.
        */
        public static String getToday() {
            java.util.Date dToday = new java.util.Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
            String today = dateFormat.format(dToday) ;
            return today;
        }

        public static String getWeek(String sYYYYMMDD) {
            String Weeks[] = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" };

            int iYYYY = Integer.parseInt(sYYYYMMDD.substring(0,4));
            int iMM = Integer.parseInt(sYYYYMMDD.substring(4,6));
            int iDD = Integer.parseInt(sYYYYMMDD.substring(6,8));

            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.YEAR, iYYYY);
            calendar.set(Calendar.MONTH, (iMM-1)); // Calendar의 월은 0~11까지 있음.
            calendar.set(Calendar.DAY_OF_MONTH, iDD);

            int iWeek = calendar.get(Calendar.DAY_OF_WEEK)-1; // Sunday가 1부터 정의되어있음.
            String sWeek = Weeks[iWeek];
            return sWeek;
        }

        public static String getWeekKor(String sWeek) {
            String sWeekKor;
            if(sWeek.equals("Sun"))
                sWeekKor = "일요일";
            else if(sWeek.equals("Mon"))
                sWeekKor = "월요일";
            else if(sWeek.equals("Tue"))
                sWeekKor = "화요일";
            else if(sWeek.equals("Wed"))
                sWeekKor = "수요일";
            else if(sWeek.equals("Thu"))
                sWeekKor = "목요일";
            else if(sWeek.equals("Fri"))
                sWeekKor = "금요일";
            else
                sWeekKor = "토요일";
            return sWeekKor;
        }

        public static String getAddDate(String sYYYYMMDD, int addDay) {
            int iYYYY = Integer.parseInt(sYYYYMMDD.substring(0,4));
            int iMM = Integer.parseInt(sYYYYMMDD.substring(4,6));
            int iDD = Integer.parseInt(sYYYYMMDD.substring(6,8));

            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.YEAR, iYYYY);
            calendar.set(Calendar.MONTH, (iMM-1)); // Calendar의 월은 0~11까지 있음.
            calendar.set(Calendar.DAY_OF_MONTH, iDD);

            calendar.add(Calendar.DATE, addDay);

            iYYYY = calendar.get(Calendar.YEAR);
            iMM = calendar.get(Calendar.MONTH)+1;
            iDD = calendar.get(Calendar.DAY_OF_MONTH);

            String sYear = Integer.toString(iYYYY);
            String sMonth = CommonUtil.addZero(Integer.toString(iMM),2);
            String sDay = CommonUtil.addZero(Integer.toString(iDD),2);
            return sYear + sMonth + sDay;
        }


        /* getSysDtTm : 현재시간날짜(20030201123030)
        */
        public static String getSysDtTm() {
            java.util.Date dToday = new java.util.Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
            String today = dateFormat.format(dToday) ;
            return today;
        }



        /* getDayFormat : 날짜 Display(YYYY-MM-DD)
        */
        public static String getDayFormat(String sYYYYMMDD) {
            String sYear = sYYYYMMDD.substring(0,4);
            String sMonth = sYYYYMMDD.substring(4,6);
            String sDay = sYYYYMMDD.substring(6,8);
            String sDayFormat = sYear +"-"+ sMonth +"-"+ sDay;
            return sDayFormat;
        }

        /* changeDateFormat : Change the date format into the given option
        */
        public static String changeDateFormat(String sYYYYMMDD, String del) {
                String sYear = sYYYYMMDD.substring(0,4);
                String sMonth = sYYYYMMDD.substring(4,6);
                String sDay = sYYYYMMDD.substring(6,8);
                String sDayFormat = sYear + del + sMonth + del + sDay;
                return sDayFormat;
        }

        /* getDateTmFormat: 날짜 Display(YYYY-MM-DD HH:MM:SS)
        */
        public static String getDateTmFormat(String dttm) {
            String sYear = dttm.substring(0,4);
            String sMonth = dttm.substring(4,6);
            String sDay = dttm.substring(6,8);
            String sHr = dttm.substring(8,10);
            String sMin= dttm.substring(10,12);
            String sSec = dttm.substring(12,14);

            String newFormat = sYear +"-"+ sMonth +"-"+ sDay+ " " + sHr + ":" + sMin + ":" + sSec;
            return newFormat;
        }

        /* getDateTmFormat: 날짜 Display(YYYY-MM-DD HH:MM)
        */
        public static String getDateTmFormatMM(String dttm) {
            String sYear = dttm.substring(0,4);
            String sMonth = dttm.substring(4,6);
            String sDay = dttm.substring(6,8);
            String sHr = dttm.substring(8,10);
            String sMin= dttm.substring(10,12);

            String newFormat = sYear +"-"+ sMonth +"-"+ sDay+ " " + sHr + ":" + sMin;
            return newFormat;
        }

        /* 주어진 날짜(yyyyMMdd)에 gap 만큼의 개월을  빼거나 더더한 Date를 String으로 return
        */
        public static String addMonth(String date, int gap){
            Date orgDt = CommonUtil.strToDate(date);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(orgDt);
            calendar.add(Calendar.MONTH, gap);
            Date newDt = calendar.getTime();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
                return dateFormat.format(newDt) ;
        }

        /* 주어진 날짜(yyyyMMddHHmmss)에 gap 만큼의 초를  빼거나 더더한 Date를 String으로 return
        */
        public static String addSecond(String date, int gap){
            Date orgDt = CommonUtil.strToDateSecond(date);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(orgDt);
            calendar.add(Calendar.SECOND, gap);
            Date newDt = calendar.getTime();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
                return dateFormat.format(newDt) ;
        }

        /* String 형식의 날짜(yyyyMMddHHmmss)를 Date class로 변환
        */
        public static java.util.Date strToDateSecond(String dt){

            java.util.Date rtnDate = new java.util.Date();

            SimpleDateFormat dtFm = new SimpleDateFormat("yyyyMMddHHmmss");
            try{
                rtnDate = dtFm.parse(dt);

            }catch(java.text.ParseException pe){
                System.out.println("Error on changing into date :" + pe.getMessage());
            }

            return rtnDate;
        }

        /* String 형식의 날짜(YYYYMMDD)를 Date class로 변환
        */
        public static java.util.Date strToDate(String dt){
            java.util.Date rtnDate = new java.util.Date();

            SimpleDateFormat dtFm = new SimpleDateFormat("yyyyMMdd");
            try{
                rtnDate = dtFm.parse(dt);

            }catch(java.text.ParseException pe){
                System.out.println("Error on changing into date :" + pe.getMessage());
            }

            return rtnDate;
        }

        /* sql Date class를 mm/dd hh:mm 형식의 String으로 변경 */
        public static String to38Format(java.sql.Date dt,java.sql.Time time){
            String newFormat="";
            Calendar cal = Calendar.getInstance();
            Calendar calTime = Calendar.getInstance();
            cal.setTime(dt);
            calTime.setTime(time);
            String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
            String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
            String hour = String.valueOf(calTime.get(Calendar.HOUR_OF_DAY));
            String min = String.valueOf(calTime.get(Calendar.MINUTE));
            newFormat= CommonUtil.addZero(month,2) + "/" + CommonUtil.addZero(day, 2) + " " + CommonUtil.addZero(hour,2) + ":" + CommonUtil.addZero(min,2);
            return newFormat;
        }

        public static String addBrTag(String org){
            String newString="";
            StringTokenizer tk = new StringTokenizer(org, "\n");
            while (tk.hasMoreTokens()){
                String token=tk.nextToken();
                newString=newString + token + "<BR>";
            }
            return newString;
        }


        public static String removeEnter(String org){
            String newString="";
            int b,
            count=0;
            char[] ch=new char[1];
            int i=0;
            try{
                while (i<(org.length()-1)) {
                    char tmpChar = org.charAt(i);
                    b = (int)tmpChar;
                    if((b!=10)&(b!=13)){
                        ch[0]=(char)b;
                        String tmpStr = new String(ch);
                        //Log.write(tmpStr+":");
                        newString = newString + tmpStr;
                    }
                    i++;
                }
            }catch(Exception e){
                //Log.write("ImUtil.java:" + e.getMessage());
                System.out.println("ImUtil.java:"  + e.getMessage());
            }
            return newString;
        }


        /* java.util.Date -> java.sql.Date로 변경
        */
        public static java.sql.Date utilDateToSQLDate(java.util.Date utilDt){

            java.sql.Date sqlDt = null;
            SimpleDateFormat afterFm = new SimpleDateFormat("yyyy-MM-dd");
            sqlDt = java.sql.Date.valueOf(afterFm.format(utilDt));
            return sqlDt;
        }

        /* getCurrencyFormat : Currency Format으로 변환
        *  ex) 4500000 -> 4,500,000
        */
        public static String getCurrencyFormat(String s){

            if(s == null || s.length() == 0)
                return "";
            StringBuffer stringbuffer = new StringBuffer();
            int i = s.length() % 3;
            if(i == 0)
                i = 3;
            stringbuffer.append(s.substring(0, i));
            for(int j = i; j < s.length(); j += 3)
                stringbuffer.append("," + s.substring(j, j + 3));

            return stringbuffer.toString();
        }

        public static String replace(String orgData, String oldData, String newData){
            StringBuffer org = new StringBuffer(orgData);
            String orgStr = org.toString();
            int startPos = orgStr.indexOf(oldData);
            int endPos = startPos + oldData.length();
            org = org.replace(startPos, endPos, newData);
            return org.toString();
        }

        // Minus 기호를 삭제한 문자를 return한다.
        public static String removeMinus(String sSrc) {
            String sReSrc = "";
            if(sSrc == null) return sReSrc;
            int index = 0;
            sSrc = sSrc.trim();
            int len = sSrc.length();
            while(index < len) {
                String sToken = sSrc.substring(index, index+1);
                if(!sToken.equals("-")) {
                    sReSrc = sReSrc + sToken;
                }
                index = index + 1;
            }
            return sReSrc;
        }

        //날짜 혹은 시간 포멧대로 데이터를 반환한다. 06.02.17 by Dew
        public static String easyDateFormat(String format) {
            /*
            * System.out.println(easyDateFormat("yyyyMMddHHmmss"));
                System.out.println(easyDateFormat("yyMMddHHmmssS"));
                System.out.println(easyDateFormat("H"));
                System.out.println(easyDateFormat("yyyyMMdd"));
                System.out.println(easyDateFormat("H:mm:ss"));
            */
            Date today = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat(format);
            String dateValue = formatter.format(today);
            return dateValue;
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
            if(StringUtil.isEmpty(phone)) return rePhone;

            phone = phone.replaceAll("-","");

            if(11 == phone.trim().length()){
                rePhone = phone.substring(0,3) + "-" + phone.substring(3,7) + "-" + phone.substring(7,11);
            } else if(10 == phone.trim().length()) {
                rePhone = phone.substring(0,3) + "-" + phone.substring(3,6) + "-" + phone.substring(6,10);
            } else if(9 == phone.trim().length()) {
                rePhone = phone.substring(0,2) + "-" + phone.substring(2,5) + "-" + phone.substring(5,9);
            } else if(8 == phone.trim().length()) {
                rePhone = phone.substring(0,4) + "-" + phone.substring(4,8);
            } else {
                rePhone = "xxx";
            }
            return rePhone;
        }

        /**
        * 지정된 두 일자간의 차일수
        * @param fromDate  첫 번째 날자
        * @param toDate    두 번째 날자
        * @return 두일자의 차일수를 반환
        * @throws ParseException
        */
        public static int getBetweenDates(String fromDate, String toDate)
        {// 지정된 두 일자간의 차일수
        long betWeenTime = Math.abs(strToDate(fromDate).getTime() - strToDate(toDate).getTime());
        return (int) (betWeenTime / (1000*60*60*24));
        }


        /**
        * 지정된 두 시간간의 차이 시간(초)
        * @param fromDate(yyyyMMddHHmmss)  첫 번째 날자시간
        * @param toDate(yyyyMMddHHmmss)    두 번째 날자시간
        * @return 두시간의 차일시간을 반환
        * @throws ParseException
        */
        public static int getBetweenDateTimes(String fromDate, String toDate)
        {// 지정된 두 시간간의 차이 시간(초)
            long betWeenTime = Math.abs(strToDateSecond(fromDate).getTime() - strToDateSecond(toDate).getTime());
            return (int) (betWeenTime / (1000));
        }

        /**
        * 세자리 단위로 콤마(,)를 표시한다.
        * 금액표시 (###,##0.##)
        * @param won double
        * @return java.lang.String
        */
        public static String getCurrency(double won)
        {
            return getCurrency(won, Locale.KOREA);
        }

        /**
        * 세자리 단위로 콤마(,)를 표시한다.
        * @param won double
        * @param loc java.util.Locale
        * @return java.lang.String
        */
        public static String getCurrency(double won, Locale loc)
        {
            getDecimalFormat(loc);
            return df.format(won);
        }

        private static void getDecimalFormat(Locale loc)
        {
            if (df == null)
            {
                df = new DecimalFormat("###,##0.##", new DecimalFormatSymbols(loc));
            }
        }

        public static boolean isNumber(String str) {

            boolean retVal = false;

            if(str==null || str.equals("")){
                return retVal;
            }

            /*
            for(int i=0; i<str.length(); i++) {
                char ch = str.charAt(i);

                if(ch<'0' || ch>'9') {
                    return false;
                }
            }*/

            try{
                Double.parseDouble(str);
                retVal = true;
            }catch(Exception e){
                System.out.println("this is not number");
            }

            return retVal;
        }

        public static String getStrDateTime(String datetime) {

            StringBuilder sb = new StringBuilder();

            sb.append(datetime.substring(0,4));
            sb.append(".");
            sb.append(datetime.substring(4,6));
            sb.append(".");
            sb.append(datetime.substring(6,8));
            sb.append(" ");
            sb.append(datetime.substring(8,10));
            sb.append(":");
            sb.append(datetime.substring(10,12));
            sb.append(":");
            sb.append(datetime.substring(12,14));

            return sb.toString();
        }

        public static String getIPAddr(){
            HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
            String ip = request.getHeader("X-FORWARDED-FOR");

            if (ip == null){
                ip = request.getRemoteAddr();
            }

            return ip;
        }

        public static String getDir_urlFromIP(){

            String ip = CommonUtil.getIPAddr();
            String DIR_URL = "";

            if("168".equals(ip.substring(0, 3))){
                DIR_URL = "168.78.201.142"; //멀티미디어센터 옛날 "100.1.53.15"
            }else if("100".equals(ip.substring(0, 3))){
                DIR_URL = "100.1.48.20"; //멀티미디어센터 옛날 "100.1.53.15"
            }else{
                DIR_URL = "203.248.44.142";
            }

            return DIR_URL;
        }

        /**
        * 파일이름에서 확장자를 얻어오는 메서드
        */
        public static String getExt(String str){
            if(str == null)
                return "";

            StringTokenizer stn = new StringTokenizer(str, ".");
            String file_exe="";
            while(stn.hasMoreTokens()){
                file_exe = stn.nextToken();
            }
            return file_exe;
        }

        /**
        * 파일이름 을 얻어오는 메서드
        */

        public static String getName(String str)
        {
            if(str == null)
                return "";
            StringBuffer file_name = new StringBuffer();
            String[] tempStr = str.split("\\.");
            if(tempStr != null && tempStr.length > 0){
                for(int i=0; i<tempStr.length-1; i++){
                    file_name.append(tempStr[i]);
                }
            }
            return file_name.toString();
        }

        public static void main(String[] arg){
            System.out.println(getCurrency(-1111111111));

        }

        /*접수 취소 여부 로직*/
        public static boolean isCancel(String status, String approval) throws Exception{

            Boolean result = false;

            if(StringUtils.isEmpty(status) || StringUtils.isEmpty(approval)){
                return false;
            }

            if( (status.equals("1") || status.equals("3")) && !approval.equals("3") ){
                result = true;
            }

            return result;
        }

        public static int getEndDayOfMonth(int year, int month) throws Exception {

            Calendar calendar = Calendar.getInstance();

            /*int year = 2009;
            int month = 7-1;*/
            calendar.set(year, month, 1);

            int DayOfMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

            return DayOfMonth;

        }

        public static Address[] mapToAddresses(Map<String, String> addrs) throws AddressException{

            Address[] toAddrs = new Address[addrs.size()];

            int cnt = 0;
            for (String key : addrs.keySet()){
                addrs.get(key);
                toAddrs[cnt] = new InternetAddress((String) addrs.get(key));
                cnt++;
            }
            return toAddrs;
        }

        /* 장비대여 관리자 여부 확인
        */
        public static Boolean isGetAdmin(HttpServletRequest request) {
            Map<String, String> sessionMap = new HashMap<String, String> ();
            HttpSession session = request.getSession();
            sessionMap = (Map<String, String>) session.getAttribute("SESS_USER_INFO");

            if(sessionMap.get("rentAdmin") == null) {
                return false;
            }

            return true;
        }

        /* 파일 업로드 */
        public List<HashMap<String, Object>> sendToServer(
                MultipartHttpServletRequest mRequest, int maxFileNo) {
            String file_path = Constants.rent_dir_path + CommonUtil.getToday().subSequence(0, 4) + "/";
    		String security_path = Constants.rent_security_path + "/"+ CommonUtil.getToday().subSequence(0, 4) + "/";
            List<HashMap<String, Object>> fileInfoList = new ArrayList<HashMap<String, Object>>();
            HashMap<String, Object> fileInfoMap = null;

            try {

                File dir = new File(file_path);

                if (!dir.exists()) {
                    dir.mkdirs();
                }

                Iterator<String> formFiles = mRequest.getFileNames();

                MultipartFile tmp_file = null;
                String tmp_name = "";
                String tmp_next = "";
                String tmp_file_type = "";
                String tmp_file_name = "";
                String tmp_file_ext = "";

                int no = 1;
                while (formFiles.hasNext()) {
                    tmp_next = formFiles.next();
                    tmp_file = mRequest.getFile(tmp_next);

                    if (!tmp_next.isEmpty()) {
                        tmp_file_type = tmp_next.split("_")[0];
                    }

                    if (!tmp_file.isEmpty()) {
                        fileInfoMap = new HashMap<String, Object>();
                        int newFileNo = maxFileNo + no;
                        tmp_name = tmp_file.getOriginalFilename();
                        tmp_file_ext = CommonUtil.getExt(tmp_name);
                        tmp_file_name = tmp_file_type + newFileNo + "_" + DateUtil.getCurrentDateTime();
                        if("file_attach".equals(tmp_next)) {
                        	tmp_file.transferTo(new File(security_path + tmp_file_name + "." + tmp_file_ext));
                        }else {
                        	tmp_file.transferTo(new File(file_path + tmp_file_name + "." + tmp_file_ext));
                        	
                        }
                        no++;

                        fileInfoMap.put("fileNo", newFileNo);
                        fileInfoMap.put("userFileName", tmp_name);
                        fileInfoMap.put("saveFileName", tmp_file_name);
                        fileInfoMap.put("fileType", tmp_file_type);
                        fileInfoMap.put("fileExt", tmp_file_ext);
                        fileInfoMap.put("inputNm", tmp_next);

                        fileInfoList.add(fileInfoMap);
                    }

                }

            } catch (IllegalStateException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }

            return fileInfoList;
        }

}
