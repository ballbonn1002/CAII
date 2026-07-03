package com.cubesofttech.service;

import java.math.BigInteger;

import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;
import java.sql.Timestamp;
import com.cubesofttech.dao.LeaveDAO;
import com.cubesofttech.dao.UserDAO;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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
import com.cubesofttech.model.User;
import com.cubesofttech.system.Constant;

@Service
public class WorkHoursService {
	@Autowired
	private WorkHoursDAO workHoursDAO;
	
	@Autowired
	private HolidayDAO holidayDAO;

	@Autowired
	private Constant constant;

	@Autowired
	private LeaveDAO leaveDAO;
	
	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private LeaveService leaveService;

	Logger log = Logger.getLogger(getClass());
	private static final Integer Interger = null;
	private static LocalTime CUT_IN_LATE = null;
	private static LocalTime CUT_OUT_NORMAL = null;

	public LocalDate calculateAllowedWorkDate(LocalDate today) {
		Objects.requireNonNull(today, "today must not be null");
		// 1) get all holidays, create Set<LocalDate> for fast check.
		Set<LocalDate> holidays = loadAllHolidayDates();
		LocalDate cursor;
		if (today.getDayOfWeek() == DayOfWeek.MONDAY) {
			cursor = today.minusDays(3); // Mon -> Last Fri
		} else {
			cursor = today.minusDays(1); // Else -> Yesterday
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
			LocalDate end = h.getEnd_date().toLocalDate();
			for (LocalDate cur = start; !cur.isAfter(end); cur = cur.plusDays(1)) {
				dates.add(cur);
			}
		}
		return dates;
	}

	public int calculateWorkingHours(String userId, String type, int date, int month, int year, String mytime) {
		String d = Integer.toString(date);
		String m = Integer.toString(month);
		String y = Integer.toString(year);
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
				if (constant.getWebEnv().equalsIgnoreCase("dev")) {
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
				if (constant.getWebEnv().equalsIgnoreCase("dev")) {
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
	
	public Map<String, Object> calculateDailyStatus(String userId, LocalDate workDate) throws Exception {
		User user = userDAO.findById(userId);
	    if (user == null) {
	        return new HashMap<>();
	    }
	    String userWorkTimeStart = user.getWorkTimeStart();
	    String userWorkTimeEnd = user.getWorkTimeEnd();
	    if (userWorkTimeStart == null) userWorkTimeStart = "09:00";
	    if (userWorkTimeEnd == null) userWorkTimeEnd = "18:00";
	    
	    if (userWorkTimeStart.indexOf(':') == 1) { userWorkTimeStart = "0" + userWorkTimeStart; } // เปลี่ยน 9:00 -> 09:00
	    if (userWorkTimeStart.length() > 5) { userWorkTimeStart = userWorkTimeStart.substring(0, 5); }
	    
	    if (userWorkTimeEnd.indexOf(':') == 1) { userWorkTimeEnd = "0" + userWorkTimeEnd; }
	    if (userWorkTimeEnd.length() > 5) { userWorkTimeEnd = userWorkTimeEnd.substring(0, 5); }
	    
	    LocalTime workStartTime = LocalTime.parse(userWorkTimeStart);
	    LocalTime workEndTime = LocalTime.parse(userWorkTimeEnd);
		
	    Object[] inData = workHoursDAO.findMinTimeByType(userId, workDate, "1");
	    Object[] outData = workHoursDAO.findMaxTimeByType(userId, workDate, "2");
	    
	    List<Map<String, Object>> dailyIns = new ArrayList<>();
	    if (inData != null && inData.length > 0 && inData[0] != null) {
	        Map<String, Object> map = new HashMap<>();
	        map.put("checkinTs", inData[0]);
	        map.put("workTypeIn", inData[1]);
	        dailyIns.add(map);
	    }
	    
	    List<Map<String, Object>> dailyOuts = new ArrayList<>();
	    if (outData != null && outData.length > 0 && outData[0] != null) {
	        Map<String, Object> map = new HashMap<>();
	        map.put("checkoutTs", outData[0]);
	        map.put("workTypeOut", outData[1]);
	        dailyOuts.add(map);
	    }
	    
	    Timestamp start = Timestamp.valueOf(workDate.atStartOfDay());
	    Timestamp end = Timestamp.valueOf(workDate.atTime(23, 59, 59));
	    List<Map<String, Object>> leaves = leaveDAO.findUserLeaveByTypeAndStatus(start, end, userId, null, null);
	    
	    Map<String, Object> leaveData = null;
	    if (leaves != null && !leaves.isEmpty()) {
	        leaveData = leaves.get(0);
	    }
	    
	    return determineDailyStatus(
	            workDate, dailyIns, dailyOuts, 
	            leaveData,  workStartTime, workEndTime
	    );
	    
	}
	
	public Map<String, Object> determineDailyStatus(
		LocalDate workDate, 
		List<Map<String, Object>> dailyIns, 
		List<Map<String, Object>> dailyOuts, 
		Map<String, Object> leaveData, 
		LocalTime workStartTime, LocalTime workEndTime) {
		
		Map<String, Object> result = new HashMap<>();
		LocalTime cutInLate = workStartTime.plusMinutes(1); 
        LocalTime cutOutNormal = workEndTime;
        
        Timestamp tsIn = null;
        String checkInType = "";
        if (dailyIns != null && !dailyIns.isEmpty()) {
        	for (Map<String, Object> row : dailyIns) {
                Timestamp ts = (Timestamp) row.get("checkinTs");
                if (ts != null) {
                    if (tsIn == null || ts.before(tsIn)) {
                        tsIn = ts;
                        checkInType = String.valueOf(row.getOrDefault("workTypeIn", ""));
                    }
                }
            }
        }
        
        Timestamp tsOut = null;
        String checkOutType = "";
        if (dailyOuts != null && !dailyOuts.isEmpty()) {
            for (Map<String, Object> row : dailyOuts) {
                Timestamp ts = (Timestamp) row.get("checkoutTs");
                if (ts != null) {
                    if (tsOut == null || ts.after(tsOut)) {
                        tsOut = ts;
                        checkOutType = String.valueOf(row.getOrDefault("workTypeOut", ""));
                    }
                }
            }
        }
        
        result.put("check_in_type", checkInType);
        result.put("check_out_type", checkOutType);
        result.put("check_in", toHHmm(tsIn));
        result.put("check_out", toHHmm(tsOut));
        
        String status = "NO_RECORD"; 
        boolean late = false;
        boolean earlyOut = false;
        LocalTime inTime = (tsIn != null) ? tsIn.toLocalDateTime().toLocalTime() : null;
        LocalTime outTime = (tsOut != null) ? tsOut.toLocalDateTime().toLocalTime() : null;
        
        if (tsIn == null && tsOut == null) {
            status = "NO_RECORD";
        } else if (tsIn == null || tsOut == null) {
            status = "INCOMPLETE";
        } else {
            late = !inTime.isBefore(cutInLate);
            earlyOut = outTime.isBefore(cutOutNormal);
            status = checkLateOrEarlyOut(late, earlyOut);
        }
        
        if (leaveData != null && !leaveData.isEmpty()) {
            String leaveStatusId = String.valueOf(leaveData.getOrDefault("leave_status_id", ""));
            String leaveTypeId = String.valueOf(leaveData.getOrDefault("leave_type_id", ""));
            String leaveTypeName = String.valueOf(leaveData.getOrDefault("leave_type_name", "ไม่ระบุ"));
            String halfDay = String.valueOf(leaveData.getOrDefault("half_day", ""));

            if ("1".equals(halfDay)) { 
                if (inTime != null) late = !inTime.isBefore(LocalTime.parse("13:00"));
                if (outTime != null) earlyOut = outTime.isBefore(cutOutNormal);
                
                if (!"INCOMPLETE".equals(status) && !"NO_RECORD".equals(status)) {
                    status = checkLateOrEarlyOut(late, earlyOut);
                }
            } else if ("2".equals(halfDay)) { 
                if (inTime != null) late = !inTime.isBefore(cutInLate);
                if (outTime != null) earlyOut = outTime.isBefore(LocalTime.parse("12:00"));
                
                if (!"INCOMPLETE".equals(status) && !"NO_RECORD".equals(status)) {
                    status = checkLateOrEarlyOut(late, earlyOut);
                }
            }
            result.put("status", status);
            result.put("halfDay", halfDay);
            
            if ("0".equals(leaveStatusId)) {
                result.put("leave_status", "WAITING");
                result.put("leave_desc", leaveTypeName);
            } else if ("1".equals(leaveStatusId)) {
                result.put("leave_status", leaveService.mapLeaveTypeToStatus(leaveTypeId));
                result.put("leave_desc", leaveTypeName);
            } else {
                result.put("leave_status", null);
                result.put("leave_desc", null);
            }
            
        } else {
            result.put("status", status);
            result.put("leave_status", null);
            result.put("leave_desc", null);
        }
        
		return result;
	}
	
	private LocalTime truncate(Timestamp ts) {
		if (ts == null) {
	        return null;
	    }
		return ts.toLocalDateTime().toLocalTime().truncatedTo(ChronoUnit.MINUTES);
	}

	private String toHHmm(Timestamp ts) {
		return ts == null ? null : truncate(ts).toString();
	}
	
	private String checkLateOrEarlyOut (boolean late, boolean earlyOut) {
		String status;
		if (late && earlyOut) {
			status = "UNFINISHED_WORK";
		} else if (late) {
			status = "LATE";
		} else if (earlyOut) {
			status = "EARLY_OUT";
		} else {
			status = "ONTIME";
		}
		return status;
		
	}
}
