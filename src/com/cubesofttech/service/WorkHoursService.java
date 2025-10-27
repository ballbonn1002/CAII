package com.cubesofttech.service;

import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cubesofttech.dao.HolidayDAO;
import com.cubesofttech.dao.WorkHoursDAO;
import com.cubesofttech.model.Holiday;
import com.cubesofttech.system.Constant;

@Service
public class WorkHoursService {
	@Autowired
	private WorkHoursDAO workHoursDAO;
	@Autowired
	private HolidayDAO holidayDAO;
	
	@Autowired
	private Constant constant;
	
	Logger log = Logger.getLogger(getClass());
	private static final Integer Interger = null;

	public LocalDate calculateAllowedWorkDate(LocalDate today) {
        Objects.requireNonNull(today, "today must not be null");
        //1) get all holidays, create Set<LocalDate> for fast check.
        Set<LocalDate> holidays = loadAllHolidayDates();
        LocalDate cursor;
        if (today.getDayOfWeek() == DayOfWeek.MONDAY) {
            cursor = today.minusDays(3);	//Mon -> Last Fri
        } else {
            cursor = today.minusDays(1);	//Else -> Yesterday
        }

        if (holidays.contains(today.minusDays(1))) {
            cursor = today.minusDays(1);
        }
        while (isWeekend(cursor) || holidays.contains(cursor)) {
            cursor = cursor.minusDays(1);
        }

        return cursor;
    }
	
	public String calculateAllowedWorkDateIso(LocalDate today) {
		 return calculateAllowedWorkDate(today).toString(); // e.g. "2025-08-13"
	 }
	 
	private boolean isWeekend(LocalDate d) {
		 DayOfWeek w = d.getDayOfWeek();
		 return (w == DayOfWeek.SATURDAY || w == DayOfWeek.SUNDAY);
	 }
	 
	private Set<LocalDate> loadAllHolidayDates() {
		 List<Holiday> list = null;
		 try {
			 list = holidayDAO.findAll();
		 } catch (Exception e) {
			e.printStackTrace();
		 }   
		 
		 Set<LocalDate> dates = new HashSet<>();
	     for (Holiday h : list) {
	    	 LocalDate start = h.getStart_date().toLocalDate();
	    	 LocalDate end   = h.getEnd_date().toLocalDate();
	    	 for (LocalDate cur = start; !cur.isAfter(end); cur = cur.plusDays(1)) {
	    		 dates.add(cur);
	    	 }
	     }
	     return dates;
	}

	public int calculateWorkingHours(String userId, String type, int date, int month, int year, String mytime) {
		String d = Integer.toString(date);	String m = Integer.toString(month);		String y = Integer.toString(year);	
		List<Map<String, Object>> checktimehours = null;
		List<Map<String, Object>> checktimemin = null;
		try {
			checktimehours = workHoursDAO.checktimehours(userId, d, m, y);
			checktimemin = workHoursDAO.checktimemin(userId, d, m, y);
		} catch (Exception e) {
			e.printStackTrace();
		}

		int types = Integer.valueOf(type);
		int inhour = 0, fullhour = 0, fullmin = 0, inmin = 0, fulltime = 0, outhours = 0, outmins = 0;
		String timeouthour = null, timeoutmin = null;
		String timeouthours = mytime.substring(1, 2);
		if (timeouthours.equals(":")) {
			timeouthour = mytime.substring(0, 1);
			timeoutmin = mytime.substring(2, 4);
		} else {
			timeouthour = mytime.substring(0, 2);
			timeoutmin = mytime.substring(3, 5);
		}
		outhours = Integer.valueOf(timeouthour);
		outmins = Integer.valueOf(timeoutmin);

		for (Map<String, Object> map : checktimehours) {
			for (Map.Entry<String, Object> entry : map.entrySet()) {
				Integer x;
				if(constant.getWebEnv().equalsIgnoreCase("dev")) {
				/* --------- Use in local --------- */
					x = (Integer) entry.getValue(); 
				} else {
					/* --------- Use in production --------- */
					x = ((BigInteger) entry.getValue()).intValue(); 
				}
				inhour = x.intValue();
			}
		}

		for (Map<String, Object> maps : checktimemin) {
			for (Map.Entry<String, Object> entry : maps.entrySet()) {
				Integer a;
				if(constant.getWebEnv().equalsIgnoreCase("dev")) {
					/* --------- Use in local --------- */
					a = (Integer) entry.getValue();  
				} else {
					/* --------- Use in production --------- */
					a = ((BigInteger) entry.getValue()).intValue(); 
				}
				
				inmin = a.intValue();
				fullmin = (outmins - inmin);
			}
		}
		if (checktimehours.size() == 0) {
			String time = null;
			List<Map<String, Object>> usertype1 = null;
			try {
				usertype1 = workHoursDAO.usertype1(userId);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			for (Map<String, Object> maps : usertype1) {
				for (Map.Entry<String, Object> entry : maps.entrySet()) {
					Date date1 = new Date();
					date1 = (Date) entry.getValue();
					DateFormat dateFormat = new SimpleDateFormat("HH:mm");
					time = dateFormat.format(date1);
					inhour = Interger.valueOf(time.substring(0, 2));
					inmin = Interger.valueOf(time.substring(3, 5));
					fullmin = (outmins - inmin);
				}
			}
		}

		if (types == 2) {

			if (outhours < inhour) {
				fullhour = ((24 - inhour) + outhours) * 60;
				fullmin = (outmins - inmin);
				fulltime = fullhour + fullmin;

			} else if (outhours == inhour && inmin > outmins) {
				fullhour = ((24 - inhour) + outhours) * 60;
				fullmin = (outmins - inmin);
				fulltime = fullhour + fullmin;
			} else {
				fullhour = (outhours - inhour) * 60;
				fullmin = (outmins - inmin);
				fulltime = fullhour + fullmin;
			}

		} else if (types == 1) {
			fulltime = 0;
		}
		return fulltime;
	}
}
