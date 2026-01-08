package com.cubesofttech.service;

import java.math.BigInteger;

import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;
import java.sql.Timestamp;
import com.cubesofttech.dao.LeaveDAO;
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

	@Autowired
	private LeaveDAO leaveDAO;

	Logger log = Logger.getLogger(getClass());
	private static final Integer Interger = null;

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

	private static final LocalTime CUT_IN_LATE = LocalTime.of(9, 1);
	private static final LocalTime CUT_OUT_NORMAL = LocalTime.of(18, 0);

	public Map<String, Object> calculateDailyStatus(String userId, LocalDate workDate) throws Exception {

		Map<String, Object> result = new HashMap<>();

		// ================== Priority 1 : Leave ==================
		Timestamp start = Timestamp.valueOf(workDate.minusDays(60).atStartOfDay());
		Timestamp end = Timestamp.valueOf(workDate.atTime(23, 59, 59));

		List<Map<String, Object>> leaves = leaveDAO.findUserLeaveByTypeAndStatus(start, end, userId, null, null);

		if (leaves != null && !leaves.isEmpty()) {
			for (Map<String, Object> leave : leaves) {

				Timestamp leaveStart = (leave.get("start_date") != null) ? (Timestamp) leave.get("start_date") : null;
				Timestamp leaveEnd = (leave.get("end_date") != null) ? (Timestamp) leave.get("end_date") : null;

				if (leaveStart != null && leaveEnd != null) {
					LocalDate leaveStartDate = leaveStart.toLocalDateTime().toLocalDate();
					LocalDate leaveEndDate = leaveEnd.toLocalDateTime().toLocalDate();

					if (!workDate.isBefore(leaveStartDate) && !workDate.isAfter(leaveEndDate)) {


						Object statusObj = leave.get("leave_status_id");
						String leaveStatusId = (statusObj != null) ? String.valueOf(statusObj).trim() : "";

						Object typeObj = leave.get("leave_type_id");
						String leaveTypeId = (typeObj != null) ? String.valueOf(typeObj).trim() : "";

						String realStatus = "UNKNOWN";
						String leaveNameTH = "ไม่ระบุ"; 

						switch (leaveTypeId) {
						case "1":
							realStatus = "ANNUAL_LEAVE";
							leaveNameTH = "ลาพักร้อน";
							break;
						case "2":
							realStatus = "BUSINESS_LEAVE";
							leaveNameTH = "ลากิจ";
							break;
						case "3":
							realStatus = "SICK_LEAVE";
							leaveNameTH = "ลาป่วย";
							break;
						case "4":
							realStatus = "ABSENT";
							leaveNameTH = "ขาดงาน";
							break;
						case "5":
							realStatus = "WITHOUT_PAY";
							leaveNameTH = "ลาโดยไม่รับค่าจ้าง";
							break;
						case "6":
							realStatus = "ANNUAL_LEAVE_REMAINING";
							leaveNameTH = "ลาพักร้อนที่เหลือจากปีก่อน";
							break;
						case "7":
							realStatus = "OTHER_LEAVE";
							leaveNameTH = "ลาอื่นๆ";
							break;
						case "9":
							realStatus = "OTHERS";
							leaveNameTH = "อื่นๆ";
							break;
						default:
							realStatus = "UNKNOWN";
							leaveNameTH = "ไม่ระบุ";
							break;
						}

						if ("0".equals(leaveStatusId)) {
							result.put("status", "WAITING");
							result.put("leave_desc", leaveNameTH);
							result.put("check_in", null);
							result.put("check_out", null);
							return result;

						} else if ("1".equals(leaveStatusId)) {
							result.put("status", realStatus);
							result.put("leave_desc", leaveNameTH);
							result.put("check_in", null);
							result.put("check_out", null);
							return result;
						}
					}
				}
			}
		}

		Timestamp tsIn = workHoursDAO.findMinTimeByType(userId, workDate, "1");
		Timestamp tsOut = workHoursDAO.findMaxTimeByType(userId, workDate, "2");
		
		String checkInType = workHoursDAO.findWorkTypeByDaily(userId, workDate, "1", "ASC");
        String checkOutType = workHoursDAO.findWorkTypeByDaily(userId, workDate, "2", "DESC");
        
        result.put("check_in_type", checkInType);
        result.put("check_out_type", checkOutType);

		// ================== Priority 2 : Incomplete ==================
		if (tsIn == null || tsOut == null) {
			result.put("status", "INCOMPLETE");
			result.put("check_in", toHHmm(tsIn));
			result.put("check_out", toHHmm(tsOut));
			return result;
		}

		LocalTime inTime = truncate(tsIn);
		LocalTime outTime = truncate(tsOut);

		// ================== Priority 3 : Time Logic ==================
		boolean late = !inTime.isBefore(CUT_IN_LATE);
		boolean earlyOut = outTime.isBefore(CUT_OUT_NORMAL);

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

		result.put("status", status);
		result.put("check_in", inTime.toString());
		result.put("check_out", outTime.toString());

		return result;
	}

	private LocalTime truncate(Timestamp ts) {
		return ts.toLocalDateTime().toLocalTime().truncatedTo(ChronoUnit.MINUTES);
	}

	private String toHHmm(Timestamp ts) {
		return ts == null ? null : truncate(ts).toString();
	}
}
