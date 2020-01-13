package kr.co.neodreams.multi_user.common;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang.time.DateUtils;
import com.ibm.icu.util.ChineseCalendar;

public class CalcBizDate {

	private static transient Map<Integer, List<Date>> computedDates = new HashMap<Integer, List<Date>>();

	/*
	 * This method will calculate the next business day after the one input.
	 * This means that if the next day falls on a weekend or one of the
	 * following holidays then it will try the next day.
	 * 
	 * Holidays Accounted For: New Year's Day Martin Luther King Jr. Day
	 * President's Day Memorial Day Independence Day Labor Day Columbus Day
	 * Veterans Day Thanksgiving Day Christmas Day
	 */
	public static boolean isBusinessDay(Date dateToCheck) {
		// Setup the calendar to have the start date truncated
		Calendar baseCal = Calendar.getInstance();

		baseCal.setTime(DateUtils.truncate(dateToCheck, Calendar.DATE));

		List<Date> offlimitDates;

		// Grab the list of dates for the year. These SHOULD NOT be modified.
		synchronized (computedDates) {
			int year = baseCal.get(Calendar.YEAR);

			// If the map doesn't already have the dates computed, create them.
			if (!computedDates.containsKey(year))
				computedDates.put(year, getOfflimitDates(year));
			offlimitDates = computedDates.get(year);
			//System.out.println(computedDates.get(String.valueOf(year)));
		}
		
		SimpleDateFormat df= new SimpleDateFormat("yyyy-MM-dd");
		
		boolean onHoliday = false;
		
		for(int i = 0; i < offlimitDates.size(); i++){
			if(df.format(baseCal.getTime()).equals(df.format(offlimitDates.get(i)).toString())){
				onHoliday = true;
			}
		}
		
		// Determine if the date is on a weekend.
		int dayOfWeek = baseCal.get(Calendar.DAY_OF_WEEK);
		boolean onWeekend = dayOfWeek == Calendar.SATURDAY || dayOfWeek == Calendar.SUNDAY;
		// If it's on a holiday, increment and test again
		// If it's on a weekend, increment necessary amount and test again
		if (onHoliday || onWeekend){
			return false;
		}else{
			return true;
		}
	}

	/**
	 * 
	 * This method will calculate the next business day after the one input.
	 * This leverages the isBusinessDay heavily, so look at that documentation
	 * for further information.
	 * 
	 * @param startDate
	 *            the Date of which you need the next business day.
	 * @return The next business day. I.E. it doesn't fall on a weekend, a
	 *         holiday or the official observance of that holiday if it fell on
	 *         a weekend.
	 * 
	 */
	public static Date getNextBusinessDay(Date startDate) {
		// Increment the Date object by a Day and clear out hour/min/sec
		// information
		Date nextDay = DateUtils.truncate(addDays(startDate, 1), Calendar.DATE);
		// If tomorrow is a valid business day, return it
		if (isBusinessDay(nextDay))
			return nextDay;
		// Else we recursively call our function until we find one.
		else
			return getNextBusinessDay(nextDay);
	}

	// 말일기준 영업일 계산
	public static Date getLastNWeekdays(int dayCount) {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		Date startDate = cal.getTime();
		Date beforeDay = null;
		int i = 0;
		int counter = 0;
		while (counter != dayCount) {
			beforeDay = DateUtils.truncate(addDays(startDate, i), Calendar.DATE);
			if (isBusinessDay(beforeDay)) {
				counter++;
			}
			i--;
		}
		return beforeDay;
	}

	// 입력일 기준 영업일 계산
	public static Date getLastNWeekdays(int dayCount, int month, int day) {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.MONTH, month);
		cal.set(Calendar.DAY_OF_MONTH, day);
		Date startDate = cal.getTime();
		Date beforeDay = null;
		int i = 0;
		int counter = 0;
		while (counter != dayCount) {
			beforeDay = DateUtils.truncate(addDays(startDate, i), Calendar.DATE);
			if (isBusinessDay(beforeDay)) {
				counter++;
			}
			i++;
		}
		return beforeDay;
	}
	
	public static Date getLastNWeekdays(int dayCount, Calendar cal, int day) {
		Date startDate = cal.getTime();
		Date beforeDay = null;
		int i = 0;
		int counter = 0;
		while (counter != dayCount) {
			beforeDay = DateUtils.truncate(addDays(startDate, i), Calendar.DATE);
			if (isBusinessDay(beforeDay)) {
				counter++;
			}
			i++;
		}
		return beforeDay;
	}

	public static String getLastNWeekdaysStr(int dayCount) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return sdf.format(getLastNWeekdays(dayCount));
	}

	public static String getLastNWeekdaysStr(int dayCount, int month, int day) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return sdf.format(getLastNWeekdays(dayCount, month, day));
	}

	public static String getNextBusinessDayStr(Date startDate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return sdf.format(getNextBusinessDay(startDate));
	}

	/*
	 * Based on a year, this will compute the actual dates of
	 * 
	 * 국경일 및 휴일 리스트
	 * 
	 * 임시, 대체 공휴일은 매년 수동 갱신. krh. 2017.12.11
	 */
	public static List<Date> getOfflimitDates(int year) {
		List<Date> offlimitDates = new ArrayList<Date>();
		ChineseCalendar chineseCal = new ChineseCalendar();
		
		Calendar baseCalendar = GregorianCalendar.getInstance();
		baseCalendar.clear();
		// Add in the static dates for the year.
		// 신정
		baseCalendar.set(year, Calendar.JANUARY, 1);
		offlimitDates.add(baseCalendar.getTime());
		
		// 설날
		chineseCal.set(ChineseCalendar.EXTENDED_YEAR, year + 2637);
		chineseCal.set(ChineseCalendar.MONTH, Calendar.JANUARY);
		chineseCal.set(ChineseCalendar.DAY_OF_MONTH, 1);
		baseCalendar.setTimeInMillis(chineseCal.getTimeInMillis());

		offlimitDates.add(addDays(baseCalendar.getTime(), -1));
		offlimitDates.add(baseCalendar.getTime());
		offlimitDates.add(addDays(baseCalendar.getTime(), 1));
		
		// 3.1절
		baseCalendar.set(year, Calendar.MARCH, 1);
		offlimitDates.add(baseCalendar.getTime());

		// 어린이날
		baseCalendar.set(year, Calendar.MAY, 5);
		offlimitDates.add(baseCalendar.getTime());

		// 석가탄신일
		chineseCal.set(ChineseCalendar.EXTENDED_YEAR, year + 2637);
		chineseCal.set(ChineseCalendar.MONTH, Calendar.APRIL);
		chineseCal.set(ChineseCalendar.DAY_OF_MONTH, 8);
		baseCalendar.setTimeInMillis(chineseCal.getTimeInMillis());

		offlimitDates.add(baseCalendar.getTime());
		
		// 현충일
		baseCalendar.set(year, Calendar.JUNE, 6);
		offlimitDates.add(baseCalendar.getTime());

		// 광복절
		baseCalendar.set(year, Calendar.AUGUST, 15);
		offlimitDates.add(baseCalendar.getTime());
		
		// 추석
		chineseCal.set(ChineseCalendar.EXTENDED_YEAR, year + 2637);
		chineseCal.set(ChineseCalendar.MONTH, Calendar.AUGUST);
		chineseCal.set(ChineseCalendar.DAY_OF_MONTH, 15);
		baseCalendar.setTimeInMillis(chineseCal.getTimeInMillis());

		offlimitDates.add(addDays(baseCalendar.getTime(), -1));
		offlimitDates.add(baseCalendar.getTime());
		offlimitDates.add(addDays(baseCalendar.getTime(), 1));
		
		// 개천절
		baseCalendar.set(year, Calendar.OCTOBER, 3);
		offlimitDates.add(baseCalendar.getTime());
		
		// 한글날
		baseCalendar.set(year, Calendar.OCTOBER, 9);
		offlimitDates.add(baseCalendar.getTime());
		
		// Christmas
		baseCalendar.set(year, Calendar.DECEMBER, 25);
		offlimitDates.add(baseCalendar.getTime());

		
		
		// 임시, 대체 공휴일 관리. 매년 이 부분 수정
		// 어린이날 20190506
		baseCalendar.set(year, Calendar.MAY, 6);
		offlimitDates.add(baseCalendar.getTime());
		
		// Columbus Day
		// offlimitDates.add(calculateFloatingHoliday(2, Calendar.MONDAY, year,
		// Calendar.OCTOBER));
		// Thanksgiving Day and Thanksgiving Friday
		// Date thanksgiving = calculateFloatingHoliday(4, Calendar.THURSDAY,
		// year, Calendar.NOVEMBER);
		// offlimitDates.add(thanksgiving);
		// offlimitDates.add(addDays(thanksgiving, 1));
		
		return offlimitDates;
	}

	/**
	 * This method will take in the various parameters and return a Date objet
	 * that represents that value.
	 * 
	 * Ex. To get Martin Luther Kings BDay, which is the 3rd Monday of January,
	 * the method call woudl be:
	 * 
	 * calculateFloatingHoliday(3, Calendar.MONDAY, year, Calendar.JANUARY);
	 * 
	 * Reference material can be found at:
	 * http://michaelthompson.org/technikos/holidays.php#MemorialDay
	 * 
	 * @param nth
	 *            0 for Last, 1 for 1st, 2 for 2nd, etc.
	 * @param dayOfWeek
	 *            Use Calendar.MODAY, Calendar.TUESDAY, etc.
	 * @param year
	 * @param month
	 *            Use Calendar.JANUARY, etc.
	 * @return
	 */
	private static Date calculateFloatingHoliday(int nth, int dayOfWeek, int year, int month) {
		Calendar baseCal = Calendar.getInstance();
		baseCal.clear();
		// Determine what the very earliest day this could occur.
		// If the value was 0 for the nth parameter, incriment to the following
		// month so that it can be subtracted alter.
		baseCal.set(year, month + ((nth <= 0) ? 1 : 0), 1);
		Date baseDate = baseCal.getTime();
		// Figure out which day of the week that this "earliest" could occur on
		// and then determine what the offset is for our day that we actually
		// need.
		int baseDayOfWeek = baseCal.get(Calendar.DAY_OF_WEEK);
		int fwd = dayOfWeek - baseDayOfWeek;
		// Based on the offset and the nth parameter, we are able to determine
		// the offset of days and then
		// adjust our base date.
		return addDays(baseDate, (fwd + (nth - (fwd >= 0 ? 1 : 0)) * 7));
	}

	/*
	 * If the given date falls on a weekend, the method will adjust to the
	 * closest weekday. I.E. If the date is on a Saturday, then the Friday will
	 * be returned, if it's a Sunday, then Monday is returned.
	 */
	private static Date offsetForWeekend(Calendar baseCal) {
		Date returnDate = baseCal.getTime();
		if (baseCal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
			// if (log.isDebugEnabled())
			// log.debug("Offsetting the Saturday by -1: " + returnDate);
			return addDays(returnDate, -1);
		} else if (baseCal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
			// if (log.isDebugEnabled())
			// log.debug("Offsetting the Sunday by +1: " + returnDate);
			return addDays(returnDate, 1);
		} else
			return returnDate;
	}

	/**
	 * Private method simply adds
	 * 
	 * @param dateToAdd
	 * @param numberOfDay
	 * @return
	 */
	private static Date addDays(Date dateToAdd, int numberOfDay) {
		if (dateToAdd == null)
			throw new IllegalArgumentException("Date can't be null!");
		Calendar tempCal = Calendar.getInstance();
		tempCal.setTime(dateToAdd);
		tempCal.add(Calendar.DATE, numberOfDay);
		return tempCal.getTime();
	}
	
	public static void main (String[] args){
		
		Calendar baseCal = Calendar.getInstance();
		int year = baseCal.get(Calendar.YEAR);
			
		List<Date> dList = CalcBizDate.getOfflimitDates(year);
		
		for(Date day : dList){
			System.out.println(day);
		}
		
	}
}