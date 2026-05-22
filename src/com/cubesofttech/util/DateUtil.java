/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cubesofttech.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

public class DateUtil {

	private DateUtil() {
	}

	public static Timestamp getCurrentTime() {
		Date date = new Date();
		return new Timestamp(date.getTime());
	}

	public static java.sql.Date periodMinus(Date date, int day) {
		long oldDate = date.getTime();
		long newDate = oldDate - (day * 1000 * 60 * 60 * 24);
		return new java.sql.Date(newDate);
	}// หาวันในอดีต

	public static long periodDiff(Date date1, Date date2) {
		long diff = Math.abs(date1.getTime() - date2.getTime());
		return diff / (1000 * 60 * 60 * 24);
	}// เอาวันมาลบกัน

	public static int checkCurrentYear() throws ParseException {

		java.util.Date currentyear = new java.util.Date();
		Calendar c = new GregorianCalendar();
		c.setTime(currentyear);
		return c.get(Calendar.YEAR);
	}

	public static Timestamp dateToTimestamp2(String date, String time) throws ParseException {
		Timestamp ts;
		SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy HH:mm");
		ts = new Timestamp(sdf1.parse(date + " " + time).getTime());
		return ts;
	}

	public static String changePstocs(String date) {
		String ps = date.substring(6, 10);
		Integer psi = Integer.parseInt(ps);
		if (psi >= 2559) {
			psi = psi - 543;
		}
		String cs = Integer.toString(psi);
		String ddmm = date.substring(0, 6);
		return ddmm + cs;
	}

	public static String dateToFormat(String date) {
		if (date != "" && date != null) {
			String dd = date.substring(0, 2);
			String mm = date.substring(3, 5);
			String yy = date.substring(6, 10);
			String newDate = yy += "-";
			newDate += mm += "-";
			newDate += dd += " 23:59:59:0";
			return newDate;
		}
		String to = "9999-12-31 23:59:59";
		return to;
	}

	public static String dateFromFormat(String date) {
		if (date != "" && date != null) {
			String dd = date.substring(0, 2);
			String mm = date.substring(3, 5);
			String yy = date.substring(6, 10);
			String newDate = yy += "-";
			newDate += mm += "-";
			newDate += dd += " 00:00:00:0";
			return newDate;
		}
		String from = "0000-01-01 01:01:01";
		return from;
	}

	public static Timestamp myDateStart(String DateStart) throws ParseException {
		Timestamp ts;
		SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		ts = new Timestamp(sdf1.parse(DateStart.trim() + " 00:00:00").getTime());
		return ts;
	}

	public static Timestamp myDateEnd(String dateEnd) throws ParseException {
		Timestamp ts;
		SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		ts = new Timestamp(sdf1.parse(dateEnd.trim() + " 23:59:59").getTime());
		return ts;
	}

	public static Timestamp dateFormat(String date) {
		if (date != "") {
			String dd = date.substring(0, 2);
			String mm = date.substring(3, 5);
			String yy = date.substring(6, 10);
			String newDate = yy += "-";
			newDate += mm += "-";
			newDate += dd += " 00:00:00";
			Timestamp ts;
			ts = Timestamp.valueOf(newDate);
			return ts;
		}
		return null;
	}

	public static Timestamp dateFormatEdit(String date) {
		if (date != "") {
			String dd = date.substring(0, 2);
			String mm = date.substring(3, 5);
			String yyyy = date.substring(6, 10);
			String newDate = yyyy += "-";
			newDate += mm += "-";
			newDate += dd += " 00:00:00.0";
			Timestamp ts;
			ts = Timestamp.valueOf(newDate);
			return ts;
		}
		return null;
	}

	public static Timestamp dateFormatEditEnd(String date) {
		if (date != "") {
			String dd = date.substring(0, 2);
			String mm = date.substring(3, 5);
			String yyyy = date.substring(6, 10);
			String newDate = yyyy += "-";
			newDate += mm += "-";
			newDate += dd += " 23:59:59.0";
			Timestamp ts;
			ts = Timestamp.valueOf(newDate);
			return ts;
		}
		return null;
	}

	public static Timestamp changeYearStart(String year) {
		String date = year.substring(6, 10);
		Integer dateyear = Integer.parseInt(date);
		if (dateyear >= 2500) {
			dateyear = dateyear - 543;
		}
		String cs = Integer.toString(dateyear);
		String dd = year.substring(0, 2);
		String mm = year.substring(3, 5);
		String newYear = cs += "-";
		newYear += mm += "-";
		newYear += dd += " 01:01:01";
		Timestamp datetime;
		datetime = Timestamp.valueOf(newYear);// 2017-01-17 00:00:00
		return datetime;
	}

	public static Timestamp changeYearEnd(String year) {
		String date = year.substring(6, 10);
		Integer dateyear = Integer.parseInt(date);
		if (dateyear >= 2500) {
			dateyear = dateyear - 543;
		}
		String cs = Integer.toString(dateyear);
		String dd = year.substring(0, 2);
		String mm = year.substring(3, 5);
		String newYear = cs += "-";
		newYear += mm += "-";
		newYear += dd += " 23:59:59";
		Timestamp datetime;
		datetime = Timestamp.valueOf(newYear);// 2017-01-17 00:00:00
		return datetime;
	}

	public static Short getMonth() {
		Date month = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("MM");
		return Short.parseShort(dateFormat.format(month));
	}

	public static int getYear() {
		Date year = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
		return Integer.parseInt(dateFormat.format(year));
	}

	public static Timestamp dateToTimestamp(String date, String time) throws ParseException {
		Timestamp ts;
		SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy HH:mm");
		ts = new Timestamp(sdf1.parse(date + " " + time).getTime());
		return ts;
	}

	public static Timestamp yearToTimestamp(String date, String time) throws ParseException {
		Timestamp ts;
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		ts = new Timestamp(sdf1.parse(date + " " + time).getTime());
		return ts;
	}

	public static String getTimeNow() {

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		return sdf.format(cal.getTime());
	}

	public static Timestamp changetoEndYear(String year) {
		String date = year.substring(6, 10);
		Integer dateyear = Integer.parseInt(date);
		if (dateyear >= 2500) {
			dateyear = dateyear - 543;
		}
		String cs = Integer.toString(dateyear);
		String dd = "31";
		String mm = "12";
		String newYear = cs += "-";
		newYear += mm += "-";
		newYear += dd += " 23:59:59";
		Timestamp datetime;
		datetime = Timestamp.valueOf(newYear);// 2017-01-17 00:00:00
		return datetime;
	}

	public static String convertDateFormat(String dateStr,String srcFormat,String destFormat,Locale srcLocale,Locale destLocale){
		String result = "";
		if (null != dateStr && !"".equals(dateStr)) {
			try {
				result = dateToString(stringToDate(dateStr, srcFormat, srcLocale), destFormat, destLocale);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return result;
	}

	public static String dateToString(Date date, String dateFormat, Locale locale) {
		String result = "";
		SimpleDateFormat format = new SimpleDateFormat(dateFormat, locale);
		try {
			result = format.format(date);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return result;
	}

	public static Date stringToDate(String dateStr, String dateFormat, Locale locale) {
		Date result = null;
		SimpleDateFormat format = new SimpleDateFormat(dateFormat, locale);
		format.setLenient(false);
		try {
			result = format.parse(dateStr);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return result;
	}
	
	public static Timestamp parseBorrowDate(String dateStr) {
	    if (dateStr == null || dateStr.trim().isEmpty()) {
	        return null;
	    }

	    try {
	        SimpleDateFormat sdf =
	            new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.ENGLISH);

	        sdf.setCalendar(new GregorianCalendar());

	        Date parsedDate = sdf.parse(dateStr.trim());

	        return new Timestamp(parsedDate.getTime());

	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}


}
