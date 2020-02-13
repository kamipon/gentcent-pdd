package com.keji09.erp.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

public class DateUtil {
    private static final int FIRST_DAY = Calendar.MONDAY;
    public final static SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy-MM-dd");
    public final static SimpleDateFormat SDF_DATETIME = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    
    public static void main(String[] args) throws ParseException {
        Date date = new Date();
        System.out.println(date);
//        String dateStr = SDF_DATE.format(date);
//        System.out.println(SDF_DATE.parse(dateStr));
        
        
        Date temp = getMOnday(SDF_DATE.parse("2016-01-04"));
        
        System.out.println(temp == date);
        
       /* List<String> list = getWeekdays(SDF_DATE.parse("2015-08-06"));
        System.out.println(list);
        System.out.println(getMonday(SDF_DATE.parse("2015-08-20")));
        System.out.println(getSunday(SDF_DATE.parse("2015-08-20")));
        
        System.out.println(DateUtil.getFirstDayOfWeek(new Date()));
        System.out.println(DateUtil.getLastDayOfWeek(new Date()));
        
        System.out.println(DutyDateUtil.getAfterWeekByDay(SDF_DATE.parse("2015-08-27")));
        System.out.println(DutyDateUtil.getBeforeWeekByDay(SDF_DATE.parse("2015-08-12")));*/
    }

    private static void setToFirstDay(Calendar calendar) {
        while (calendar.get(Calendar.DAY_OF_WEEK) != FIRST_DAY) {
            calendar.add(Calendar.DATE, -1);
        }
    }
    
    public static String formatDateTime (Date date) {
    	return SDF_DATETIME.format(date);
    }
    
    public static String formatDate (Date date) {
    	return SDF_DATE.format(date);
    }
    
    public static Date parseDateTime(String date){
    	Date d = null;
    	try {
			d = SDF_DATETIME.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return d;
    }
    
    public static Date parseDate(String date){
    	Date d = null;
    	try {
			d = SDF_DATE.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return d;
    }

    /**
     * 从周一开始7天
     */
    public static List<String> getWeekdays(Date date) {
        List<String> list = new ArrayList<String>();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        
        setToFirstDay(calendar);
        
        for (int i = 0; i < 7; i++) {
            list.add(SDF_DATE.format(calendar.getTime()));
            calendar.add(Calendar.DATE, 1);
        }
        return list;
    }
    
    /**
     * 从周一开始7天
     */
    public static List<String> getWeekdaysAndColor(Date date) {
        List<String> list = new ArrayList<String>();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        
        setToFirstDay(calendar);
        
        for (int i = 0; i < 7; i++) {
        	if(i == 6 || i == 5)
                list.add("<font class='weekColor'>" + SDF_DATE.format(calendar.getTime()) + "</font>");
        	else
        		list.add(SDF_DATE.format(calendar.getTime()));
            calendar.add(Calendar.DATE, 1);
        }
        return list;
    }
    public static String getMonday(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        setToFirstDay(calendar);
        return SDF_DATE.format(calendar.getTime());
    }
    
    public static String getSunday(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        setToFirstDay(calendar);
        calendar.add(Calendar.DATE, 6);
        return SDF_DATE.format(calendar.getTime());
    }
    
    /**
     * 当前日期  + 7
     * @param date
     * @return
     */
    public static Date getAfterWeekByDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, 7);
        return calendar.getTime();
    }
    
    /**
     * 当前日期  - 7
     * @param date
     * @return
     */
    public static Date getBeforeWeekByDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, -7);
        return calendar.getTime();
    }

    /**
	 * 获取星期一
	 * 
	 * @param date 传入的日期
	 * @return
	 */
	public static Date getMOnday(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		// 判断要计算的日期是否是周日，如果是则减一天计算周六的，否则会出问题，计算到下一周去了
		int dayWeek = cal.get(Calendar.DAY_OF_WEEK);// 获得当前日期是一个星期的第几天
		if (1 == dayWeek) {
			cal.add(Calendar.DAY_OF_MONTH, -1);
		}
		cal.setFirstDayOfWeek(Calendar.MONDAY);// 设置一个星期的第一天，按中国的习惯一个星期的第一天是星期一
		int day = cal.get(Calendar.DAY_OF_WEEK);// 获得当前日期是一个星期的第几天
		cal.add(Calendar.DATE, cal.getFirstDayOfWeek() - day);// 根据日历的规则，给当前日期减去星期几与一个星期第一天的差值
		return cal.getTime();
	}

	/**
	 * 判断传入的日期的周数是否大于当前日期的周数
	 * @param dutyDate 传入的日期
	 * @return
	 */
	public static boolean isBeforeThisWeek(Date dutyDate){ 
		return getMOnday(new Date()).getTime() < getMOnday(dutyDate).getTime();
	}
	
	public static boolean equals(Date d1,Date d2,SimpleDateFormat sdf) {
	    String a = sdf.format(d1);
	    String b = sdf.format(d2);
	    if(a != null && b != null) {
	        return a.equals(b);
	    }
	    return false;
	}

	public static String ignoreFrmat(String source,SimpleDateFormat sdf) {
	    List<String> list = Arrays.asList("yyyy-M-d","yyyy-MM-dd","yyyy-M","yyyy-MM","yyyy/M/d","yyyy/MM/dd","yyyy/M","yyyy/MM");
	    String result = "";
	    for(int i = 0;i<list.size();i++) {
	        try {
                Date d = new SimpleDateFormat(list.get(i)).parse(source);
                result = sdf.format(d);
                return result;
            } catch (Exception e) {
                
            }
	    }
	    try {
            Date d = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy",Locale.US).parse(source);
            result = sdf.format(d);
        } catch (Exception e) {
        }
	    return result;
	}
	
	public static Date ignoreFrmat_Date(String source,SimpleDateFormat sdf) {
	    String result = ignoreFrmat(source,sdf);
	    Date d = null;
        try {
            d = sdf.parse(result);
        } catch (ParseException e) {
            e.printStackTrace();
        }
	    return d;
	}
	
	/**
	 * 两个时间相差天数
	 * date1  开始时间
	 * date2  结束时间
	 * 
	 * */
	public static int getMonthSpace(String staticTime, String endTime) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		long startT=sdf.parse(staticTime).getTime(); //定义开始时间
		long endT=sdf.parse(endTime).getTime();  //定义结束时间
		long overDay=(endT-startT) /(1000 * 60 * 60 * 24);
		int day = Integer.parseInt(String.valueOf(overDay));
		return day;
	}
	
	/**
	 * 获取年份
	 * */
	private static int getYear(String date1) throws ParseException { 
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	    Calendar cal = Calendar.getInstance(); 
	    Date dt = null; 
	    try { 
	      dt = sdf.parse(date1); 
	      cal.setTime(dt); 
	    } catch (ParseException e) { 
	      // TODO Auto-generated catch block 
	      e.printStackTrace(); 
	    } 
	    int year = cal.get(Calendar.YEAR); 
	    int month = cal.get(Calendar.MONTH) + 1; 
	    int day = cal.get(Calendar.DAY_OF_MONTH); 
	    int hour = cal.get(Calendar.HOUR_OF_DAY); 
	    int minute = cal.get(Calendar.MINUTE); 
	    int second = cal.get(Calendar.SECOND); 
	    return year;
	  } 
	
}	
