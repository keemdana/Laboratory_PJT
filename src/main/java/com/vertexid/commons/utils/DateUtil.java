package com.vertexid.commons.utils;

import java.text.ParseException;
import java.util.Calendar;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public final class DateUtil{
	/**
     * logger
     */
    protected static Logger logger = LoggerFactory.getLogger(StringUtil.class);
	/**
	 * the instance
	 */
	private static DateUtil instance;

	private static final String defaultDateFormat = "yyyy-MM-dd";
	private static final String defaultTimeFormat = "HH:mm:ss";

	public static final int SUNDAY 		= Calendar.SUNDAY;
	public static final int MONDAY 		= Calendar.MONDAY;
	public static final int TUESDAY 		= Calendar.TUESDAY;
	public static final int WEDNESDAY 	= Calendar.WEDNESDAY;
	public static final int THURSDAY 		= Calendar.THURSDAY;
	public static final int FRIDAY 		= Calendar.FRIDAY;
	public static final int SATURDAY 		= Calendar.SATURDAY;
	public static final String[] WEEKDAYKOR = {"일","월","화","수","목","금","토"};


	/**
     * <p>{@code DateUtil} instances should NOT be constructed in
     * standard programming. Instead, the class should be used as
     * {@code DateUtil.get(" foo ");}.</p>
     *
     * <p>This constructor is public to permit tools that require a JavaBean
     * instance to operate.</p>
     */
	private DateUtil() {
		super();
		logger.debug("==========>>>>>>>>>> DateUtil constructed!");
	}

	/**
     * @return the instance
     */
    public static DateUtil getInstance() {
    	if (instance == null) {
    		instance = new DateUtil();
    	}

    	return instance;
    }


//    /*
//     * Demonstraton and self test of class
//     */
//    public static void main(String args[])
//    throws Exception {
//    	String current_date 	= DateUtil.getCurrentDate();
//    	String current_year 	= DateUtil.getCurrentYear();
//    	String current_month	= DateUtil.getCurrentMonth();
//    	String current_day		= DateUtil.getCurrentDay();
//
//    	logger.debug("DateUtil.getCurrentDate() => "+ DateUtil.getCurrentDate());
//    	logger.debug("DateUtil.whichDay() => "+ DateUtil.whichDay(current_date));
//    	logger.debug("DateUtil.lastDay() => "+ DateUtil.lastDay(Integer.parseInt(current_month), Integer.parseInt(current_month)));
//    	logger.debug("DateUtil.lastDayOfMonth() => "+ DateUtil.lastDayOfMonth(current_date));
//    }


    /**
     * getCurrentDate
     * @return
     */
    public static String getCurrentDate(String formatPattern) {
	    java.text.SimpleDateFormat dateFormat  = new java.text.SimpleDateFormat(formatPattern, java.util.Locale.KOREA);

	    return dateFormat.format(new java.util.Date());
    }

    /**
     * getCurrentDate
     * @return
     */
    public static String getCurrentDate(){
	    return getCurrentDate(defaultDateFormat);
    }


    /**
     * getCurrentYear(YYYY)
     * @return
     */
	public static String getCurrentYear() {
        java.text.SimpleDateFormat dateFormat  = new java.text.SimpleDateFormat("yyyy", java.util.Locale.KOREA);

        return dateFormat.format(new java.util.Date());
    }
	/**
	 * getCurrentYear(YY)
	 * @return
	 */
	public static String getCurrentTwoYear() {
		java.text.SimpleDateFormat dateFormat  = new java.text.SimpleDateFormat("yy", java.util.Locale.KOREA);

		return dateFormat.format(new java.util.Date());
	}


	/**
	 * getCurrentMonth
	 * @return
	 */
    public static String getCurrentMonth() {
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("MM", java.util.Locale.KOREA);

		return dateFormat.format(new java.util.Date());
	}


    /**
     * getCurrentDay
     * @return
     */
	public static String getCurrentDay() {
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd", java.util.Locale.KOREA);

		return dateFormat.format(new java.util.Date());
	}


	/**
	 * getCurrentTime
	 * @param formatPattern
	 * @return
	 */
	public static String getCurrentTime(String formatPattern){
		java.text.SimpleDateFormat timeFormat  = new java.text.SimpleDateFormat(formatPattern, java.util.Locale.KOREA);

        return timeFormat.format(new java.util.Date());
	}

	/**
	 * getCurrentTime
	 * @return
	 */
	public static String getCurrentTime(){
        return getCurrentTime(defaultTimeFormat);
    }


	/**
	 * getDirInfo
	 * @return
	 */
	public static String getDirInfo(){
		return new java.text.SimpleDateFormat("/yyyy/MMdd/",java.util.Locale.KOREA).format(new java.util.Date());
	}

	/**
	 * check date string validation with the default format "yyyyMMdd".
	 * @param s date string you want to check with default format "yyyyMMdd".
     * @return date java.util.Date
	 */
	public static java.util.Date check(String s) throws ParseException {
		return check(s, defaultDateFormat);
	}

	/**
	 * check date string validation with an user defined format.
	 * @param s date string you want to check.
	 * @param format string representation of the date format. For example, "yyyy-MM-dd".
     * @return date java.util.Date
	 */
	public static java.util.Date check(String s, String format) throws ParseException {
		if ( s == null )
			throw new ParseException("date string to check is null", 0);
		if ( format == null )
			throw new ParseException("format string to check date is null", 0);

		java.text.SimpleDateFormat formatter =
            new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
		java.util.Date date = null;
		try {
			date = formatter.parse(s);
		}
		catch(ParseException e) {
            /*
			throw new ParseException(
				e.getMessage() + " with format \"" + format + "\"",
				e.getErrorOffset()
			);
            */
            throw new ParseException(" wrong date:\"" + s +
            "\" with format \"" + format + "\"", 0);
		}

		if ( ! formatter.format(date).equals(s) )
			throw new ParseException(
				"Out of bound date:\"" + s + "\" with format \"" + format + "\"",
				0
			);
        return date;
	}

	/**
	 * check date string validation with the default format "yyyyMMdd".
	 * @param s date string you want to check with default format "yyyyMMdd"
	 * @return boolean true 날짜 형식이 맞고, 존재하는 날짜일 때
	 *                 false 날짜 형식이 맞지 않거나, 존재하지 않는 날짜일 때
	 */
	public static boolean isValid(String s) throws Exception {
		return isValid(s, defaultDateFormat);
	}

	/**
	 * check date string validation with an user defined format.
	 * @param s date string you want to check.
	 * @param format string representation of the date format. For example, "yyyy-MM-dd".
	 * @return boolean true 날짜 형식이 맞고, 존재하는 날짜일 때
	 *                 false 날짜 형식이 맞지 않거나, 존재하지 않는 날짜일 때
	 */
	public static boolean isValid(String s, String format) {
/*
		if ( s == null )
			throw new NullPointerException("date string to check is null");
		if ( format == null )
			throw new NullPointerException("format string to check date is null");
*/
		java.text.SimpleDateFormat formatter =
		    new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
		java.util.Date date = null;
		try {
			date = formatter.parse(s);
		}
		catch(ParseException e) {
            return false;
		}

		if ( ! formatter.format(date).equals(s) )
            return false;

        return true;
	}

	/**
	 *
	 * For example, String time = DateTime.getFormatString("yyyy-MM-dd HH:mm:ss");
	 *
	 * @param java.lang.String pattern  "yyyy, MM, dd, HH, mm, ss and more"
	 * @return formatted string representation of current day and time with  your pattern.
	 */
	public static int getNumberByPattern(String pattern) {
		java.text.SimpleDateFormat formatter =
           new java.text.SimpleDateFormat (pattern, java.util.Locale.KOREA);
		String dateString = formatter.format(new java.util.Date());
		return Integer.parseInt(dateString);
	}

	/**
	 *
	 * For example, String time = DateTime.getFormatString("yyyy-MM-dd HH:mm:ss");
	 *
	 * @param java.lang.String pattern  "yyyy, MM, dd, HH, mm, ss and more"
	 * @return formatted string representation of current day and time with  your pattern.
	 */
	public static String getFormatString(String pattern) {
		java.text.SimpleDateFormat formatter =
           new java.text.SimpleDateFormat (pattern, java.util.Locale.KOREA);
		String dateString = formatter.format(new java.util.Date());
		return dateString;
	}

	/**
	 * return days between two date strings with default defined format.(yyyyMMdd)
	 * @param s date string you want to check.
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 요일을 리턴
	 *           형식이 잘못 되었거나 존재하지 않는 날짜: ParseException 발생
	 *          0: 일요일 (java.util.Calendar.SUNDAY 와 비교)
	 *          1: 월요일 (java.util.Calendar.MONDAY 와 비교)
	 *          2: 화요일 (java.util.Calendar.TUESDAY 와 비교)
	 *          3: 수요일 (java.util.Calendar.WENDESDAY 와 비교)
	 *          4: 목요일 (java.util.Calendar.THURSDAY 와 비교)
	 *          5: 금요일 (java.util.Calendar.FRIDAY 와 비교)
	 *          6: 토요일 (java.util.Calendar.SATURDAY 와 비교)
	 * 예) String s = "20000529";
	 *  int dayOfWeek = whichDay(s, format);
	 *  if (dayOfWeek == java.util.Calendar.MONDAY)
	 *      logger.debug(" 월요일: " + dayOfWeek);
	 *  if (dayOfWeek == java.util.Calendar.TUESDAY)
	 *      logger.debug(" 화요일: " + dayOfWeek);
	 */
    public static int whichDay(String s) throws ParseException {
        return whichDay(s, defaultDateFormat);
    }

	/**
	 * return days between two date strings with user defined format.
	 * @param s date string you want to check.
	 * @param format string representation of the date format. For example, "yyyy-MM-dd".
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 요일을 리턴
	 *           형식이 잘못 되었거나 존재하지 않는 날짜: ParseException 발생
	 *          0: 일요일 (java.util.Calendar.SUNDAY 와 비교)
	 *          1: 월요일 (java.util.Calendar.MONDAY 와 비교)
	 *          2: 화요일 (java.util.Calendar.TUESDAY 와 비교)
	 *          3: 수요일 (java.util.Calendar.WENDESDAY 와 비교)
	 *          4: 목요일 (java.util.Calendar.THURSDAY 와 비교)
	 *          5: 금요일 (java.util.Calendar.FRIDAY 와 비교)
	 *          6: 토요일 (java.util.Calendar.SATURDAY 와 비교)
	 * 예) String s = "2000-05-29";
	 *  int dayOfWeek = whichDay(s, "yyyy-MM-dd");
	 *  if (dayOfWeek == java.util.Calendar.MONDAY)
	 *      logger.debug(" 월요일: " + dayOfWeek);
	 *  if (dayOfWeek == java.util.Calendar.TUESDAY)
	 *      logger.debug(" 화요일: " + dayOfWeek);
	 */

    public static int whichDay(String s, String format) throws ParseException {
 		java.text.SimpleDateFormat formatter =
		    new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
		java.util.Date date = check(s, format);

        java.util.Calendar calendar = formatter.getCalendar();
		calendar.setTime(date);
        return calendar.get(java.util.Calendar.DAY_OF_WEEK);
    }

	/**
	 * return days between two date strings with default defined format.("yyyyMMdd")
	 * @param String from date string
	 * @param String to date string
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 나이 리턴
	 *           형식이 잘못 되었거나 존재하지 않는 날짜: ParseException 발생
	 */
    public static int daysBetween(String from, String to) throws ParseException {
        return daysBetween(from, to, defaultDateFormat);
    }

	/**
	 * return days between two date strings with user defined format.
	 * @param String from date string
	 * @param String to date string
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 일자 리턴
	 *           형식이 잘못 되었거나 존재하지 않는 날짜: ParseException 발생
	 */
    public static int daysBetween(String from, String to, String format) throws ParseException {
//        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
        java.util.Date d1 = check(from, format);
        java.util.Date d2 = check(to, format);

        long duration = d2.getTime() - d1.getTime();

        return (int)( duration/(1000 * 60 * 60 * 24) );
        // seconds in 1 day
    }

	/**
	 * return age between two date strings with default defined format.("yyyyMMdd")
	 * @param String from date string
	 * @param String to date string
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 나이 리턴
	 *           형식이 잘못 되었거나 존재하지 않는 날짜: ParseException 발생
	 */
    public static int ageBetween(String from, String to) throws ParseException {
        return ageBetween(from, to, defaultDateFormat);
    }

	/**
	 * return age between two date strings with user defined format.
	 * @param String from date string
	 * @param String to date string
	 * @param format string representation of the date format. For example, "yyyy-MM-dd".
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 나이 리턴
	 *           형식이 잘못 되었거나 존재하지 않는 날짜: ParseException 발생
	 */
    public static int ageBetween(String from, String to, String format) throws ParseException {
        return (int)(daysBetween(from, to, format) / 365 );
    }

	/**
	 * return add day to date strings
	 * @param String date string
	 * @param int 더할 일수
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 일수 더하기
	 *           형식이 잘못 되었거나 존재하지 않는 날짜: ParseException 발생
	 */
    public static String addDays(String s, int day) throws ParseException {
        return addDays(s, day, defaultDateFormat);
    }

	/**
	 * return add day to date strings with user defined format.
	 * @param String date string
	 * @param int 더할 일수
	 * @param format string representation of the date format. For example, "yyyy-MM-dd".
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 일수 더하기
	 *           형식이 잘못 되었거나 존재하지 않는 날짜: ParseException 발생
	 */
    public static String addDays(String s, int day, String format) throws ParseException{
 		java.text.SimpleDateFormat formatter =
		    new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
		java.util.Date date = check(s, format);

        date.setTime(date.getTime() + ((long)day * 1000 * 60 * 60 * 24));
        return formatter.format(date);
    }

	/**
	 * return add month to date strings
	 * @param String date string
	 * @param int 더할 월수
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 월수 더하기
	 *           형식이 잘못 되었거나 존재하지 않는 날짜: ParseException 발생
	 */
    public static String addMonths(String s, int month) throws ParseException {
        return addMonths(s, month, defaultDateFormat);
    }

	/**
	 * return add month to date strings with user defined format.
	 * @param String date string
	 * @param int 더할 월수
	 * @param format string representation of the date format. For example, "yyyy-MM-dd".
	 * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 월수 더하기
	 *           형식이 잘못 되었거나 존재하지 않는 날짜: ParseException 발생
	 */
    public static String addMonths(String s, int addMonth, String format) throws ParseException {
 		java.text.SimpleDateFormat formatter =
		    new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
		java.util.Date date = check(s, format);

 		java.text.SimpleDateFormat yearFormat =
		    new java.text.SimpleDateFormat("yyyy", java.util.Locale.KOREA);
 		java.text.SimpleDateFormat monthFormat =
		    new java.text.SimpleDateFormat("MM", java.util.Locale.KOREA);
 		java.text.SimpleDateFormat dayFormat =
		    new java.text.SimpleDateFormat("dd", java.util.Locale.KOREA);
        int year = Integer.parseInt(yearFormat.format(date));
        int month = Integer.parseInt(monthFormat.format(date));
        int day = Integer.parseInt(dayFormat.format(date));

        month += addMonth;
        if (addMonth > 0) {
            while (month > 12) {
                month -= 12;
                year += 1;
            }
        } else {
            while (month <= 0) {
                month += 12;
                year -= 1;
            }
        }
 		java.text.DecimalFormat fourDf = new java.text.DecimalFormat("0000");
 		java.text.DecimalFormat twoDf = new java.text.DecimalFormat("00");
        String tempDate = String.valueOf(fourDf.format(year))
                         + String.valueOf(twoDf.format(month))
                         + String.valueOf(twoDf.format(day));
        java.util.Date targetDate = null;

        try {
            targetDate = check(tempDate, defaultDateFormat);
        } catch(ParseException pe) {
            day = lastDay(year, month);
            tempDate = String.valueOf(fourDf.format(year))
                         + String.valueOf(twoDf.format(month))
                         + String.valueOf(twoDf.format(day));
            targetDate = check(tempDate, defaultDateFormat);
        }

        return formatter.format(targetDate);
    }

    public static String addYears(String s, int year) throws ParseException {
        return addYears(s, year, defaultDateFormat);
    }

    public static String addYears(String s, int year, String format) throws ParseException {
 		java.text.SimpleDateFormat formatter =
		    new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
		java.util.Date date = check(s, format);
        date.setTime(date.getTime() + ((long)year * 1000 * 60 * 60 * 24 * (365 + 1)));
        return formatter.format(date);
    }

    public static int monthsBetween(String from, String to) throws ParseException {
        return monthsBetween(from, to, defaultDateFormat);
    }

    public static int monthsBetween(String from, String to, String format) throws ParseException {
    	return monthsBetween(from, to, format, true);
    }

    public static int monthsBetween(String from, String to, String format, boolean isCeilFloorEffect) throws ParseException {
// 		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
 	        java.util.Date fromDate = check(from, format);
 	        java.util.Date toDate = check(to, format);

 	        // if two date are same, return 0.
 	        if (fromDate.compareTo(toDate) == 0) return 0;

 	 		java.text.SimpleDateFormat yearFormat =
 			    new java.text.SimpleDateFormat("yyyy", java.util.Locale.KOREA);
 	 		java.text.SimpleDateFormat monthFormat =
 			    new java.text.SimpleDateFormat("MM", java.util.Locale.KOREA);
 	 		java.text.SimpleDateFormat dayFormat =
 			    new java.text.SimpleDateFormat("dd", java.util.Locale.KOREA);

 	        int fromYear = Integer.parseInt(yearFormat.format(fromDate));
 	        int toYear = Integer.parseInt(yearFormat.format(toDate));
 	        int fromMonth = Integer.parseInt(monthFormat.format(fromDate));
 	        int toMonth = Integer.parseInt(monthFormat.format(toDate));
 	        int fromDay = Integer.parseInt(dayFormat.format(fromDate));
 	        int toDay = Integer.parseInt(dayFormat.format(toDate));

 	        int result = 0;
 	        result += ((toYear - fromYear) * 12);
 	        result += (toMonth - fromMonth);

// 	        if (((toDay - fromDay) < 0) ) result += fromDate.compareTo(toDate);
 	        // ceil과 floor의 효과
 	        if( isCeilFloorEffect ){
 	        	if (((toDay - fromDay) > 0) ) result += toDate.compareTo(fromDate);
 	        }

 	        return result;
    }

    public static String lastDayOfMonth(String src) throws ParseException {
        return lastDayOfMonth(src, defaultDateFormat);
    }

    public static String lastDayOfMonth(String src, String format) throws ParseException {
 		java.text.SimpleDateFormat formatter =
		    new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
		java.util.Date date = check(src, format);

 		java.text.SimpleDateFormat yearFormat =
		    new java.text.SimpleDateFormat("yyyy", java.util.Locale.KOREA);
 		java.text.SimpleDateFormat monthFormat =
		    new java.text.SimpleDateFormat("MM", java.util.Locale.KOREA);

        int year = Integer.parseInt(yearFormat.format(date));
        int month = Integer.parseInt(monthFormat.format(date));
        int day = lastDay(year, month);

        java.text.DecimalFormat fourDf = new java.text.DecimalFormat("0000");
 		java.text.DecimalFormat twoDf = new java.text.DecimalFormat("00");
        String tempDate = String.valueOf(fourDf.format(year))
                         + String.valueOf(twoDf.format(month))
                         + String.valueOf(twoDf.format(day));

        date = check(tempDate, "yyyyMMdd");

        return formatter.format(date);
    }

    /**
     * 주어진 년/월의 총 일수 반환
     * @param year
     * @param month
     * @return
     * @throws ParseException
     */
    public static int lastDay(int year, int month)
    throws ParseException {
        int day = 0;
        switch(month)
        {
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12: day = 31;
                     break;
            case 2: if ((year % 4) == 0) {
                        if ((year % 100) == 0 && (year % 400) != 0) { day = 28; }
                        else { day = 29; }
                    } else { day = 28; }
                    break;
            default: day = 30;
        }

        return day;
    }

    /**
     * 주어진 Calendar 객체의 요일(KOR)을 return
     * @param c
     * @return
     */
    public static String weekDayKor(Calendar c){
//    	String rtn = "";
    	return WEEKDAYKOR[c.get(Calendar.DAY_OF_WEEK) - 1];
    }

    /**
     * getDayDiff
     * @param fromDate
     * @param toDate
     * @return
     */
    public static int getDayDiff(String fromDate, String toDate) {
		if(fromDate.length() < 8) return -1;
		if(toDate.length() < 8) return -1;

		int year1  = Integer.parseInt(fromDate.substring(0,4));
		int month1 = Integer.parseInt(fromDate.substring(4,6)) - 1;
		int day1   = Integer.parseInt(fromDate.substring(6,8));

		int year2  = Integer.parseInt(toDate.substring(0,4));
		int month2 = Integer.parseInt(toDate.substring(4,6)) - 1;
		int day2   = Integer.parseInt(toDate.substring(6,8));

		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();

		c1.set(year1, month1, day1);
		c2.set(year2, month2, day2);

		long d1 = c1.getTime().getTime();
		long d2 = c2.getTime().getTime();
		int days =(int)((d2-d1)/(1000*60*60*24));

		return days;
    }

    public static String getQuerterDate(String type){
    	String sCurrentYear  = getCurrentYear();
    	String sCurrentMonth = getCurrentMonth();
    	String rtnDate = "";
    	int nCurrentMonth = Integer.parseInt(sCurrentMonth);

    	if("S".equals(type)){
    		if(nCurrentMonth == 1 || nCurrentMonth == 2 || nCurrentMonth == 3){
    			rtnDate = sCurrentYear + "-01-01";
    		}else if(nCurrentMonth == 4 || nCurrentMonth == 5 || nCurrentMonth == 6){
    			rtnDate = sCurrentYear + "-04-01";
    		}else if(nCurrentMonth == 7 || nCurrentMonth == 8 || nCurrentMonth == 9){
    			rtnDate = sCurrentYear + "-07-01";
    		}else if(nCurrentMonth == 10 || nCurrentMonth == 11 || nCurrentMonth == 12){
    			rtnDate = sCurrentYear + "-10-01";
    		}
    	}else if("E".equals(type)){
    		if(nCurrentMonth == 1 || nCurrentMonth == 2 || nCurrentMonth == 3){
    			rtnDate = sCurrentYear + "-03-31";
    		}else if(nCurrentMonth == 4 || nCurrentMonth == 5 || nCurrentMonth == 6){
    			rtnDate = sCurrentYear + "-06-30";
    		}else if(nCurrentMonth == 7 || nCurrentMonth == 8 || nCurrentMonth == 9){
    			rtnDate = sCurrentYear + "-09-30";
    		}else if(nCurrentMonth == 10 || nCurrentMonth == 11 || nCurrentMonth == 12){
    			rtnDate = sCurrentYear + "-12-31";
    		}
    	}

    	return rtnDate;
    }


}
