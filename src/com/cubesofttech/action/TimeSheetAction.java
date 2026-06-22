package com.cubesofttech.action;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.temporal.ChronoField;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.HolidayDAO;
import com.cubesofttech.dao.LeaveDAO;
import com.cubesofttech.dao.ProjectDAO;
import com.cubesofttech.dao.ProjectFunctionDAO;
import com.cubesofttech.dao.TimesheetDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.Holiday;
import com.cubesofttech.model.Leaves;
import com.cubesofttech.model.Project;
import com.cubesofttech.model.ProjectFunction;
import com.cubesofttech.model.Timesheet;
import com.cubesofttech.model.User;
import com.opensymphony.xwork2.ActionSupport;

public class TimeSheetAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	HttpSession session = ServletActionContext.getRequest().getSession(false);
	Logger log = Logger.getLogger(getClass());

	@Autowired
	private TimesheetDAO timesheetDAO;

	@Autowired
	private HolidayDAO holidayDAO;

	@Autowired
	private ProjectDAO projectDAO;

	@Autowired
	private ProjectFunctionDAO projectFunctionDAO;

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private LeaveDAO leaveDAO;

	private List<ProjectFunction> projectFunctions;

	private Map<String, Object> newTimeSheetMap = new HashMap<>();

	private File fileUpload;

	public String timeSheetList() {
		try {

			User ur = (User) request.getSession().getAttribute("onlineUser");

			// User
			List<User> userList = userDAO.findAll();
			List<User> userEnable = new ArrayList<User>();
			List<User> userDisable = new ArrayList<User>();

			userEnable = userList.stream().filter(user -> user.getEnable().equals("1")).collect(Collectors.toList());
			userDisable = userList.stream().filter(user -> user.getEnable().equals("0")).collect(Collectors.toList());

			request.setAttribute("userEnable", userEnable);
			request.setAttribute("userDisable", userDisable);
			request.setAttribute("roleUser", ur.getRoleId());

			// Date
			YearMonth yearMonth = YearMonth.now();

			DateTimeFormatter formatYearMonth = DateTimeFormatter.ofPattern("MM-yyyy");

			request.setAttribute("searchDate", yearMonth.format(formatYearMonth));

			Date startOfMonth = Date.from(yearMonth.atDay(1).atStartOfDay(ZoneId.systemDefault()).toInstant());

			Date endOfMonth = Date
					.from(yearMonth.atEndOfMonth().atTime(23, 59, 59).atZone(ZoneId.systemDefault()).toInstant());

			List<Map<String, Object>> timeSheetList = timesheetDAO.searchTimesheetByUserCreateAndDate(ur.getId(),
					startOfMonth, endOfMonth);

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

			List<Map<String, Object>> dateList = new ArrayList<>();
			Map<String, Object> holidayMap = new HashMap<>();

			List<Holiday> holidays = holidayDAO.findAll();

			Map<String, Object> leaveMap = new HashMap<>();
			List<Leaves> leaveUsers = leaveDAO.findLeaveByUserId(ur.getId());

			Integer total_leave = 0;
			Integer total_absent = 0;
			Integer total_work = 0;
			Integer total_late = 0;
			Integer total_OT = 0;

			long total_ot_minutes = 0;

			// ประกาศตัวแปรเก็บสะสมชั่วโมง OT แยกตามประเภทเรท
			double sum_ot_x15 = 0.0;
			double sum_ot_x2 = 0.0;
			double sum_ot_x3 = 0.0;

			for (int day = 1; day <= yearMonth.lengthOfMonth(); day++) {

				LocalDate localDate = yearMonth.atDay(day);

				boolean isWeekend = false;
				boolean isHoliday = false;
				boolean isLeave = false;

				// เช็ค weekend
				DayOfWeek dayOfWeek = localDate.getDayOfWeek();
				if (dayOfWeek == DayOfWeek.SATURDAY || dayOfWeek == DayOfWeek.SUNDAY) {
					isWeekend = true;
				}

				Map<String, Object> dateData = new HashMap<>();
				String formattedDate = localDate.format(formatter);

				dateData.put("date", formattedDate);
				dateData.put("cssClass", "dot-" + localDate.getDayOfWeek().name().toLowerCase());
				dateList.add(dateData);

				for (Holiday holiday : holidays) {
					LocalDate startDate = holiday.getStart_date().toLocalDate();
					LocalDate endDate = holiday.getEnd_date().toLocalDate();

					if (!localDate.isBefore(startDate) && !localDate.isAfter(endDate)) {
						holidayMap.put(formattedDate, holiday);
						isHoliday = true;
					}
				}
				for (Leaves leaveUser : leaveUsers) {
					LocalDate startDate = leaveUser.getStartDate().toLocalDateTime().toLocalDate();
					LocalDate endDate = leaveUser.getEndDate().toLocalDateTime().toLocalDate();

					if (!localDate.isBefore(startDate) && !localDate.isAfter(endDate)) {
						leaveMap.put(formattedDate, leaveUser);
						isLeave = true;
						total_leave++;
					}
				}

				// นับเฉพาะวันที่เป็นวันทำงานจริง
				if (!isWeekend && !isHoliday && !isLeave) {
					total_work++;
				}
			}

			request.setAttribute("holidayMap", holidayMap);
			request.setAttribute("leaveMap", leaveMap);
			request.setAttribute("dateList", dateList);

			// Map date with time sheet
			Map<String, List<Map<String, Object>>> timeSheetMap = new HashMap<>();
			Set<String> otDateSet = new HashSet<>();
			Set<String> workDateSet = new HashSet<>();
			Set<String> lateDateSet = new HashSet<>();

			// ประกาศ Set เพื่อเก็บ "วันที่" สำหรับนับว่ามีกี่วันในแต่ละเรท OT
			Set<String> ot15DateSet = new HashSet<>();
			Set<String> ot2DateSet = new HashSet<>();
			Set<String> ot3DateSet = new HashSet<>();

			for (Map<String, Object> ts : timeSheetList) {

				// Total time check in / check out
				Date checkIn = (Date) ts.get("time_check_in");
				Date checkOut = (Date) ts.get("time_check_out");

				if (checkIn != null && checkOut != null) {
					long diffMillis = checkOut.getTime() - checkIn.getTime();
					long diffMinutes = diffMillis / (1000 * 60);
					long hours = diffMinutes / 60;
					long minutes = diffMinutes % 60;
					String totalTime = String.format("%02d:%02d", hours, minutes);
					ts.put("total_time", totalTime);
				}

				// Total time start OT / end OT
				Date startOT = (Date) ts.get("OT_time_start");
				Date endOT = (Date) ts.get("OT_time_end");
				String otDateKey = null;

				if (startOT != null && endOT != null) {
					long diffMillis = endOT.getTime() - startOT.getTime();
					long diffMinutes = diffMillis / (1000 * 60);

					total_ot_minutes += diffMinutes;

					long hours = diffMinutes / 60;
					long minutes = diffMinutes % 60;
					String totalTimeOT = String.format("%02d:%02d", hours, minutes);
					ts.put("total_time_OT", totalTimeOT);

					LocalDate localDate = startOT.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
					otDateKey = localDate.format(formatter);
					otDateSet.add(otDateKey);
				} else if (checkIn != null) {

					otDateKey = checkIn.toInstant().atZone(ZoneId.systemDefault()).toLocalDate().format(formatter);
				}

				Object ot15Obj = ts.get("OT_hour_x15");
				if (ot15Obj != null && !ot15Obj.toString().trim().isEmpty()) {
					double val = Double.parseDouble(ot15Obj.toString());
					if (val > 0) {
						sum_ot_x15 += val;
						if (otDateKey != null)
							ot15DateSet.add(otDateKey);
					}
				}

				Object ot2Obj = ts.get("OT_hour_x2");
				if (ot2Obj != null && !ot2Obj.toString().trim().isEmpty()) {
					double val = Double.parseDouble(ot2Obj.toString());
					if (val > 0) {
						sum_ot_x2 += val;
						if (otDateKey != null)
							ot2DateSet.add(otDateKey);
					}
				}

				Object ot3Obj = ts.get("OT_hour_x3");
				if (ot3Obj != null && !ot3Obj.toString().trim().isEmpty()) {
					double val = Double.parseDouble(ot3Obj.toString());
					if (val > 0) {
						sum_ot_x3 += val;
						if (otDateKey != null)
							ot3DateSet.add(otDateKey);
					}
				}

				Date referenceDate = null;

				if (checkIn != null) {
					referenceDate = checkIn;
				} else if (checkOut != null) {
					referenceDate = checkOut;
				} else if (startOT != null) {
					referenceDate = startOT;
				} else if (endOT != null) {
					referenceDate = endOT;
				} else {

					Object baseDateObj = ts.get("started_date");
					if (baseDateObj != null) {
						referenceDate = (Date) baseDateObj;
					}
				}

				if (referenceDate != null) {

					LocalDate localDate = java.time.Instant.ofEpochMilli(referenceDate.getTime())
							.atZone(ZoneId.systemDefault()).toLocalDate();
					String key = localDate.format(formatter);
					boolean isLate = false;

					LocalTime nineAM = LocalTime.of(9, 0);
					LocalTime sixPM = LocalTime.of(18, 0);

					// ❌ เช็คมาสาย (ตรวจสอบเฉพาะกรณีที่มีเวลา Check In)
					if (checkIn != null) {
						LocalDateTime checkInTime = java.time.Instant.ofEpochMilli(checkIn.getTime())
								.atZone(ZoneId.systemDefault()).toLocalDateTime();
						if (checkInTime.toLocalTime().isAfter(nineAM)) {
							isLate = true;
						}
					}

					// ❌ เช็คกลับก่อน (ตรวจสอบเฉพาะกรณีที่มีเวลา Check Out)
					if (checkOut != null) {
						LocalDateTime checkOutTime = java.time.Instant.ofEpochMilli(checkOut.getTime())
								.atZone(ZoneId.systemDefault()).toLocalDateTime();
						if (checkOutTime.toLocalTime().isBefore(sixPM)) {
							isLate = true;
						}
					}

					// จัดการข้อมูลลง Set และ Map เพื่อให้แสดงผลได้
					if (isLate) {
						lateDateSet.add(key);
					} else if (lateDateSet.contains(key)) {
						lateDateSet.remove(key);
					}

					timeSheetMap.computeIfAbsent(key, k -> new ArrayList<>()).add(ts);
					workDateSet.add(key);
				}
			}

			total_OT = otDateSet.size();
			total_absent = total_work - workDateSet.size();
			total_work = total_work - total_absent;
			total_late = lateDateSet.size();

			// สมมติฐาน: 1 วันทำงานปกติ = 8 ชั่วโมง
			double hours_total_work = total_work * 8.0;
			double hours_total_absent = total_absent * 8.0;
			double hours_total_leave = total_leave * 8.0;
			double hours_total_late = total_late * 1.0;
			double hours_total_ot = (double) total_ot_minutes / 60.0;

			// --- ส่งค่าแถว "วัน" (จำนวนวัน) ---
			request.setAttribute("total_absent", total_absent);
			request.setAttribute("total_OT", total_OT);
			request.setAttribute("total_work", total_work);
			request.setAttribute("total_leave", total_leave);
			request.setAttribute("total_late", total_late);

			// ส่งค่า "จำนวนวัน" ของ OT แต่ละเรทไปให้ JSP
			request.setAttribute("total_days_ot_x15", ot15DateSet.size());
			request.setAttribute("total_days_ot_x2", ot2DateSet.size());
			request.setAttribute("total_days_ot_x3", ot3DateSet.size());

			// --- ส่งค่าแถว "ชั่วโมง" (ผลรวมชั่วโมง) ---
			request.setAttribute("hours_total_work", String.format("%.2f", hours_total_work));
			request.setAttribute("hours_total_late", String.format("%.2f", hours_total_late));
			request.setAttribute("hours_total_absent", String.format("%.2f", hours_total_absent));
			request.setAttribute("hours_total_leave", String.format("%.2f", hours_total_leave));
			request.setAttribute("hours_total_ot", String.format("%.2f", hours_total_ot));

			request.setAttribute("sum_ot_x15", String.format("%.2f", sum_ot_x15));
			request.setAttribute("sum_ot_x2", String.format("%.2f", sum_ot_x2));
			request.setAttribute("sum_ot_x3", String.format("%.2f", sum_ot_x3));

			request.setAttribute("timeSheetMap", timeSheetMap);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String addTimeSheet() {
		try {

			User ur = (User) request.getSession().getAttribute("onlineUser");
			request.setAttribute("roleUser", ur.getRoleId());

			List<Project> projects = projectDAO.findAll();

			projects = projects.stream().filter(p -> p.getProject_name() != null && !p.getProject_name().isEmpty())
					.collect(Collectors.toList());
			request.setAttribute("projectList", projects);

			// User
			List<User> userList = userDAO.findAll();
			List<User> userEnable = new ArrayList<User>();
			;
			List<User> userDisable = new ArrayList<User>();
			;

			userEnable = userList.stream().filter(user -> user.getEnable().equals("1")).collect(Collectors.toList());
			userDisable = userList.stream().filter(user -> user.getEnable().equals("0")).collect(Collectors.toList());

			request.setAttribute("userEnable", userEnable);
			request.setAttribute("userDisable", userDisable);

			String dateStr = request.getParameter("date");
			request.setAttribute("date", dateStr);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;

		}
	}

	public String timeSheetSearch() {
		try {
			User ur = (User) request.getSession().getAttribute("onlineUser");
			String searchDate = request.getParameter("searchDate");
			String idUserSelected = request.getParameter("userSelect") == null
					|| request.getParameter("userSelect").isEmpty() ? ur.getId() : request.getParameter("userSelect");

			request.setAttribute("idUserSelected", idUserSelected);

			request.setAttribute("searchDate", searchDate);
			request.setAttribute("searchUserId", idUserSelected);
			List<User> userList = userDAO.findAll();

			List<User> userEnable = new ArrayList<User>();
			List<User> userDisable = new ArrayList<User>();

			userEnable = userList.stream().filter(user -> user.getEnable().equals("1")).collect(Collectors.toList());
			userDisable = userList.stream().filter(user -> user.getEnable().equals("0")).collect(Collectors.toList());

			request.setAttribute("userEnable", userEnable);
			request.setAttribute("userDisable", userDisable);

			request.setAttribute("userList", userList);
			request.setAttribute("roleUser", ur.getRoleId());

			DateTimeFormatter ymFormatter = DateTimeFormatter.ofPattern("MM-yyyy");

			YearMonth yearMonth = YearMonth.parse(searchDate, ymFormatter);

			Date startOfMonth = Date.from(yearMonth.atDay(1).atStartOfDay(ZoneId.systemDefault()).toInstant());

			Date endOfMonth = Date
					.from(yearMonth.atEndOfMonth().atTime(23, 59, 59).atZone(ZoneId.systemDefault()).toInstant());

			List<Map<String, Object>> timeSheetList = timesheetDAO.searchTimesheetByUserCreateAndDate(idUserSelected,
					startOfMonth, endOfMonth);

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
			List<Map<String, Object>> dateList = new ArrayList<>();
			Map<String, Object> holidayMap = new HashMap<>();
			Map<String, Object> leaveMap = new HashMap<>();

			List<Holiday> holidays = holidayDAO.findAll();
			List<Leaves> leaveUsers = leaveDAO.findLeaveByUserId(idUserSelected);

			Integer total_leave = 0;
			Integer total_absent = 0;
			Integer total_work = 0;
			Integer total_late = 0;
			Integer total_OT = 0;

			long total_ot_minutes = 0;

			// ประกาศตัวแปรเก็บสะสมชั่วโมง OT แยกตามประเภทเรท
			double sum_ot_x15 = 0.0;
			double sum_ot_x2 = 0.0;
			double sum_ot_x3 = 0.0;

			for (int day = 1; day <= yearMonth.lengthOfMonth(); day++) {

				LocalDate localDate = yearMonth.atDay(day);

				boolean isWeekend = false;
				boolean isHoliday = false;
				boolean isLeave = false;

				// เช็ค weekend
				DayOfWeek dayOfWeek = localDate.getDayOfWeek();
				if (dayOfWeek == DayOfWeek.SATURDAY || dayOfWeek == DayOfWeek.SUNDAY) {
					isWeekend = true;
				}

				Map<String, Object> dateData = new HashMap<>();

				String formattedDate = localDate.format(formatter);

				dateData.put("date", formattedDate);
				dateData.put("cssClass", "dot-" + localDate.getDayOfWeek().name().toLowerCase());
				dateList.add(dateData);

				for (Holiday holiday : holidays) {

					LocalDate startDate = holiday.getStart_date().toLocalDate();
					LocalDate endDate = holiday.getEnd_date().toLocalDate();

					// เทียบแบบ LocalDate
					if (!localDate.isBefore(startDate) && !localDate.isAfter(endDate)) {
						holidayMap.put(formattedDate, holiday);
						// เช็ควันหยุด
						isHoliday = true;
					}
				}

				for (Leaves leaveUser : leaveUsers) {
					LocalDate startDate = leaveUser.getStartDate().toLocalDateTime().toLocalDate();

					LocalDate endDate = leaveUser.getEndDate().toLocalDateTime().toLocalDate();
					// เทียบแบบ LocalDateTime
					if (!localDate.isBefore(startDate) && !localDate.isAfter(endDate)) {
						leaveMap.put(formattedDate, leaveUser);
						// เช็ควันลา
						isLeave = true;
						total_leave++;
					}
				}

				// นับเฉพาะวันที่เป็นวันทำงานจริง
				if (!isWeekend && !isHoliday && !isLeave) {
					total_work++;
				}
			}

			request.setAttribute("holidayMap", holidayMap);
			request.setAttribute("leaveMap", leaveMap);

			Map<String, List<Map<String, Object>>> timeSheetMap = new HashMap<>();
			Set<String> otDateSet = new HashSet<>();
			Set<String> workDateSet = new HashSet<>();
			Set<String> lateDateSet = new HashSet<>();

			// ประกาศ Set เพื่อเก็บ "วันที่" สำหรับนับว่ามีกี่วันในแต่ละเรท OT
			Set<String> ot15DateSet = new HashSet<>();
			Set<String> ot2DateSet = new HashSet<>();
			Set<String> ot3DateSet = new HashSet<>();

			for (Map<String, Object> ts : timeSheetList) {

				// Total time check in / check out
				Date checkIn = (Date) ts.get("time_check_in");
				Date checkOut = (Date) ts.get("time_check_out");

				if (checkIn != null && checkOut != null) {
					long diffMillis = checkOut.getTime() - checkIn.getTime();
					long diffMinutes = diffMillis / (1000 * 60);
					long hours = diffMinutes / 60;
					long minutes = diffMinutes % 60;
					String totalTime = String.format("%02d:%02d", hours, minutes);
					ts.put("total_time", totalTime);
				}

				// Total time start OT / end OT
				Date startOT = (Date) ts.get("OT_time_start");
				Date endOT = (Date) ts.get("OT_time_end");
				String otDateKey = null;

				if (startOT != null && endOT != null) {
					long diffMillis = endOT.getTime() - startOT.getTime();
					long diffMinutes = diffMillis / (1000 * 60);

					total_ot_minutes += diffMinutes;

					long hours = diffMinutes / 60;
					long minutes = diffMinutes % 60;
					String totalTimeOT = String.format("%02d:%02d", hours, minutes);
					ts.put("total_time_OT", totalTimeOT);

					LocalDate localDate = startOT.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

					otDateKey = localDate.format(formatter);
					otDateSet.add(otDateKey);
				} else if (checkIn != null) {
					// กรณีไม่ได้ลงเวลาเริ่ม OT ชัดเจน แต่มีเรท OT ในฐานข้อมูล ให้ดึงวันที่จากเวลา
					// Check In แทน
					otDateKey = checkIn.toInstant().atZone(ZoneId.systemDefault()).toLocalDate().format(formatter);
				}

				// ดึงค่า OT แต่ละเรท + บวกชั่วโมงสะสม + เพิ่มวันที่ลง Set (ถ้าชั่วโมง > 0)
				Object ot15Obj = ts.get("OT_hour_x15");
				if (ot15Obj != null && !ot15Obj.toString().trim().isEmpty()) {
					double val = Double.parseDouble(ot15Obj.toString());
					if (val > 0) {
						sum_ot_x15 += val;
						if (otDateKey != null)
							ot15DateSet.add(otDateKey);
					}
				}

				Object ot2Obj = ts.get("OT_hour_x2");
				if (ot2Obj != null && !ot2Obj.toString().trim().isEmpty()) {
					double val = Double.parseDouble(ot2Obj.toString());
					if (val > 0) {
						sum_ot_x2 += val;
						if (otDateKey != null)
							ot2DateSet.add(otDateKey);
					}
				}

				Object ot3Obj = ts.get("OT_hour_x3");
				if (ot3Obj != null && !ot3Obj.toString().trim().isEmpty()) {
					double val = Double.parseDouble(ot3Obj.toString());
					if (val > 0) {
						sum_ot_x3 += val;
						if (otDateKey != null)
							ot3DateSet.add(otDateKey);
					}
				}

				Date referenceDate = null;

				if (checkIn != null) {
					referenceDate = checkIn;
				} else if (checkOut != null) {
					referenceDate = checkOut;
				} else if (startOT != null) {
					referenceDate = startOT;
				} else if (endOT != null) {
					referenceDate = endOT;
				} else {

					Object baseDateObj = ts.get("started_date");
					if (baseDateObj != null) {
						referenceDate = (Date) baseDateObj;
					}
				}

				if (referenceDate != null) {

					LocalDate localDate = java.time.Instant.ofEpochMilli(referenceDate.getTime())
							.atZone(ZoneId.systemDefault()).toLocalDate();
					String key = localDate.format(formatter);
					boolean isLate = false;

					LocalTime nineAM = LocalTime.of(9, 0);
					LocalTime sixPM = LocalTime.of(18, 0);

					if (checkIn != null) {

						LocalDateTime checkInTime = java.time.Instant.ofEpochMilli(checkIn.getTime())
								.atZone(ZoneId.systemDefault()).toLocalDateTime();
						if (checkInTime.toLocalTime().isAfter(nineAM)) {
							isLate = true;
						}
					}

					if (checkOut != null) {

						LocalDateTime checkOutTime = java.time.Instant.ofEpochMilli(checkOut.getTime())
								.atZone(ZoneId.systemDefault()).toLocalDateTime();
						if (checkOutTime.toLocalTime().isBefore(sixPM)) {
							isLate = true;
						}
					}

					if (isLate) {
						lateDateSet.add(key);
					} else if (lateDateSet.contains(key)) {
						lateDateSet.remove(key);
					}

					timeSheetMap.computeIfAbsent(key, k -> new ArrayList<>()).add(ts);
					workDateSet.add(key);
				}
			}

			total_OT = otDateSet.size();
			total_absent = total_work - workDateSet.size();
			total_work = total_work - total_absent;
			total_late = lateDateSet.size();

			// สมมติฐาน: 1 วันทำงานปกติ = 8 ชั่วโมง
			double hours_total_work = total_work * 8.0;
			double hours_total_absent = total_absent * 8.0;
			double hours_total_leave = total_leave * 8.0;
			double hours_total_late = total_late * 1.0;
			double hours_total_ot = (double) total_ot_minutes / 60.0;

			request.setAttribute("total_absent", total_absent);
			request.setAttribute("total_OT", total_OT);
			request.setAttribute("total_work", total_work);
			request.setAttribute("total_leave", total_leave);
			request.setAttribute("total_late", total_late);

			request.setAttribute("total_days_ot_x15", ot15DateSet.size());
			request.setAttribute("total_days_ot_x2", ot2DateSet.size());
			request.setAttribute("total_days_ot_x3", ot3DateSet.size());

			// --- ส่งค่าแถว "ชั่วโมง" (ผลรวมชั่วโมงทศนิยม) ---
			request.setAttribute("hours_total_work", String.format("%.2f", hours_total_work));
			request.setAttribute("hours_total_late", String.format("%.2f", hours_total_late));
			request.setAttribute("hours_total_absent", String.format("%.2f", hours_total_absent));
			request.setAttribute("hours_total_leave", String.format("%.2f", hours_total_leave));
			request.setAttribute("hours_total_ot", String.format("%.2f", hours_total_ot));

			request.setAttribute("sum_ot_x15", String.format("%.2f", sum_ot_x15));
			request.setAttribute("sum_ot_x2", String.format("%.2f", sum_ot_x2));
			request.setAttribute("sum_ot_x3", String.format("%.2f", sum_ot_x3));

			request.setAttribute("timeSheetMap", timeSheetMap);
			request.setAttribute("dateList", dateList);

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String saveTimeSheet() {
		try {
			String idUserSelected = request.getParameter("userSelect");
			String searchDate = request.getParameter("searchDate");
			String startTime = request.getParameter("start-time");
			String endTime = request.getParameter("end-time");
			String team = request.getParameter("team").isEmpty() ? null : request.getParameter("team");
			String projectId = request.getParameter("projectSelect").isEmpty() ? null
					: request.getParameter("projectSelect");
			String projectName = request.getParameter("projectName").isEmpty() ? null
					: request.getParameter("projectName");
			String functionId = request.getParameter("function").isEmpty() ? null : request.getParameter("function");
			String functionName = request.getParameter("functionName").isEmpty() ? null
					: request.getParameter("functionName");
			String description = request.getParameter("task-description").isEmpty() ? null
					: request.getParameter("task-description");
			String timeSpent = request.getParameter("time-spent").isEmpty() ? null : request.getParameter("time-spent");
			String startOverTime = request.getParameter("start-overtime");
			String endOverTime = request.getParameter("end-overtime");
			String overtimeDescription = request.getParameter("overtime-description").isEmpty() ? null
					: request.getParameter("overtime-description");

			Timesheet newTimesheet = new Timesheet();

			Timestamp now = Timestamp.valueOf(LocalDateTime.now());

			Project project = null;
			if (projectId != null && !projectId.equals("newProject")) {
				project = projectDAO.findById(Integer.valueOf(projectId));

			} else if (projectId != null && projectId.equals("newProject")) {
				Project newProject = new Project();
				newProject.setProject_id(projectDAO.getMaxId() + 1);
				newProject.setProject_name(projectName);
				newProject.setDescription(null);
				newProject.setStatus_project("1");
				newProject.setUser_create(idUserSelected);
				newProject.setUser_update(idUserSelected);
				newProject.setTime_create(now);
				newProject.setTime_update(now);
				projectDAO.save(newProject);
				project = newProject;
			}

			if (functionId != null && functionId.equals("newFunction")) {
				ProjectFunction newFunction = new ProjectFunction();
				newFunction.setFunction_id(projectFunctionDAO.getMaxId() + 1);
				newFunction.setFunction_name(functionName);
				newFunction.setStatus("1");
				newFunction.setProject_id(project == null ? null : project.getProject_id());
				newFunction.setUser_create(idUserSelected);
				newFunction.setUser_update(idUserSelected);
				newFunction.setTime_create(now);
				newFunction.setTime_update(now);
				projectFunctionDAO.save(newFunction);
				functionId = newFunction.getFunction_id().toString();
			}

			DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
			DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

			LocalDate date = LocalDate.parse(searchDate, dateFormatter);
			Date startedDate = Date.from(date.atStartOfDay(ZoneId.systemDefault()).toInstant());

			// ===== เวลาเข้างาน =====
			Timestamp startTimestamp = null;
			Timestamp endTimestamp = null;
			Timestamp startOverTimestamp = null;
			Timestamp endOverTimestamp = null;

			if (startTime != null && !startTime.isEmpty()) {
				LocalTime time = LocalTime.parse(startTime, timeFormatter);
				startTimestamp = Timestamp.valueOf(LocalDateTime.of(date, time));
			}

			if (endTime != null && !endTime.isEmpty()) {
				LocalTime time = LocalTime.parse(endTime, timeFormatter);
				endTimestamp = Timestamp.valueOf(LocalDateTime.of(date, time));
			}

			// ===== OT =====
			if (startOverTime != null && !startOverTime.isEmpty()) {
				LocalTime time = LocalTime.parse(startOverTime, timeFormatter);
				startOverTimestamp = Timestamp.valueOf(LocalDateTime.of(date, time));
			}

			if (endOverTime != null && !endOverTime.isEmpty()) {
				LocalTime time = LocalTime.parse(endOverTime, timeFormatter);
				endOverTimestamp = Timestamp.valueOf(LocalDateTime.of(date, time));
			}

			if (endOverTimestamp != null && startOverTimestamp != null && endOverTimestamp.before(startOverTimestamp)) {
				LocalDateTime overEnd = endOverTimestamp.toLocalDateTime().plusDays(1);
				endOverTimestamp = Timestamp.valueOf(overEnd);
			}

			newTimesheet.setId(timesheetDAO.getMaxId() + 1);
			newTimesheet.setProject(project == null ? null : project.getProject_name());
			newTimesheet.setProject_id(project == null ? null : project.getProject_id());
			newTimesheet.setSummary(functionId == null ? null
					: projectFunctionDAO.findById(Integer.valueOf(functionId)).getFunction_name());
			newTimesheet.setFunction_id(functionId == null ? null : Integer.valueOf(functionId));
			newTimesheet.setOT_type(null);
			newTimesheet.setOT_time_start(startOverTimestamp);
			newTimesheet.setOT_time_end(endOverTimestamp);
			newTimesheet.setOT_description(overtimeDescription);
			newTimesheet.setDescription(description);
			newTimesheet.setStarted_date(startedDate);
			newTimesheet.setTimespent(timeSpent);
			newTimesheet.setTimeCheckIn(startTimestamp);
			newTimesheet.setTimeCheckOut(endTimestamp);
			newTimesheet.setStatus("W");
			newTimesheet.setReason(null);
			newTimesheet.setAppr_user_id(null);
			newTimesheet.setUserCreate(idUserSelected);
			newTimesheet.setUserUpdate(idUserSelected);
			newTimesheet.setTimeCreate(now);
			newTimesheet.setTimeUpdate(now);
			newTimesheet.setTimeAppr(null);
			newTimesheet.setTeam(team);
			timesheetDAO.save(newTimesheet);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;

		}
	}

	public String deleteTimeSheet() {
		try {

			String timeSheetId = request.getParameter("timeSheetId");
			Timesheet timesheet = timesheetDAO.findById(Integer.valueOf(timeSheetId));
			timesheetDAO.delete(timesheet);
			return SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return ERROR;
		}
	}

	public String updateTimeSheet() {
		try {
			String timeSheetId = request.getParameter("timeSheetId");
			String startTime = request.getParameter("startTime");
			String endTime = request.getParameter("endTime");
			String startOverTime = request.getParameter("startOvertime") == null
					|| request.getParameter("startOvertime").isEmpty() ? null : request.getParameter("startOvertime");
			String endOverTime = request.getParameter("endOvertime") == null
					|| request.getParameter("endOvertime").isEmpty() ? null : request.getParameter("endOvertime");
			String project = request.getParameter("project") == null || request.getParameter("project").isEmpty() ? null
					: request.getParameter("project");
			String description = request.getParameter("description") == null
					|| request.getParameter("description").isEmpty() ? null : request.getParameter("description");
			String summary = request.getParameter("summary") == null || request.getParameter("summary").isEmpty() ? null
					: request.getParameter("summary");
			String dateString = request.getParameter("date");

			User ur = (User) request.getSession().getAttribute("onlineUser");

			Timesheet newTimesheet = timesheetDAO.findById(Integer.valueOf(timeSheetId));

			Timestamp now = Timestamp.valueOf(LocalDateTime.now());

			DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
			LocalDate date = LocalDate.parse(dateString, dateFormatter);

			// ===== เวลาเข้างาน =====
			Timestamp startTimestamp = null;
			Timestamp endTimestamp = null;
			Timestamp startOverTimestamp = null;
			Timestamp endOverTimestamp = null;

			if (startTime != null && !startTime.isEmpty()) {
				LocalTime time = LocalTime.parse(startTime, timeFormatter);
				startTimestamp = Timestamp.valueOf(LocalDateTime.of(date, time));
				log.debug(startTimestamp);
			}

			if (endTime != null && !endTime.isEmpty()) {
				LocalTime time = LocalTime.parse(endTime, timeFormatter);
				endTimestamp = Timestamp.valueOf(LocalDateTime.of(date, time));
			}

			// ===== OT =====
			if (startOverTime != null && !startOverTime.isEmpty()) {
				LocalTime time = LocalTime.parse(startOverTime, timeFormatter);
				startOverTimestamp = Timestamp.valueOf(LocalDateTime.of(date, time));
			}

			if (endOverTime != null && !endOverTime.isEmpty()) {
				LocalTime time = LocalTime.parse(endOverTime, timeFormatter);
				endOverTimestamp = Timestamp.valueOf(LocalDateTime.of(date, time));
			}

			if (endOverTimestamp != null && startOverTimestamp != null && endOverTimestamp.before(startOverTimestamp)) {
				LocalDateTime overEnd = endOverTimestamp.toLocalDateTime().plusDays(1);
				endOverTimestamp = Timestamp.valueOf(overEnd);
			}

			newTimesheet.setTimeCheckIn(startTimestamp);
			newTimesheet.setTimeCheckOut(endTimestamp);
			newTimesheet.setOT_time_start(startOverTimestamp);
			newTimesheet.setOT_time_end(endOverTimestamp);
			newTimesheet.setProject(project);
			newTimesheet.setProject_id(null);
			newTimesheet.setDescription(description);
			newTimesheet.setSummary(summary);
			newTimesheet.setFunction_id(null);
			newTimesheet.setTimeUpdate(now);
			newTimesheet.setUserUpdate(ur.getId());
			timesheetDAO.update(newTimesheet);

//			Total time check in / check out
			Date checkIn = (Date) newTimesheet.getTimeCheckIn();
			Date checkOut = (Date) newTimesheet.getTimeCheckOut();

			if (checkIn != null && checkOut != null) {
				long diffMillis = checkOut.getTime() - checkIn.getTime();
				long diffMinutes = diffMillis / (1000 * 60);
				long hours = diffMinutes / 60;
				long minutes = diffMinutes % 60;
				String totalTime = String.format("%02d:%02d", hours, minutes);
				newTimeSheetMap.put("total_time", totalTime);

			}

//			Total time start OT / end OT
			Date startOT = (Date) newTimesheet.getOT_time_start();
			Date endOT = (Date) newTimesheet.getOT_time_end();

			if (startOT != null && endOT != null) {
				long diffMillis = endOT.getTime() - startOT.getTime();
				long diffMinutes = diffMillis / (1000 * 60);
				long hours = diffMinutes / 60;
				long minutes = diffMinutes % 60;
				String totalTimeOT = String.format("%02d:%02d", hours, minutes);
				newTimeSheetMap.put("total_time_OT", totalTimeOT);
			}
			newTimeSheetMap.put("newTimeSheet", newTimesheet);

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}

	public String getFunction() {
		String projectId = request.getParameter("projectId");
		try {
			if (!projectId.isEmpty() && !projectId.equals("newProject")) {
				projectFunctions = projectFunctionDAO.findAllByProjectId(Integer.valueOf(projectId));
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}

//	public String importTimeSheet() throws Exception {
//
//		try {
//			FileInputStream fis = new FileInputStream(fileUpload);
//			Workbook workbook = WorkbookFactory.create(fis);
//
//			Sheet sheet = workbook.getSheetAt(0);
//			DataFormatter dataFormatter = new DataFormatter();
//
//			// ดึงค่า User
//			Row userRow = sheet.getRow(1);
//			String userStr = "";
//			if (userRow != null) {
//				String colB = getCellValue(userRow.getCell(1), dataFormatter);
//				String colA = getCellValue(userRow.getCell(0), dataFormatter);
//
//				if (colB != null && !colB.trim().isEmpty()) {
//					userStr = colB.trim();
//				} else if (colA != null && colA.contains(":")) {
//					userStr = colA.substring(colA.indexOf(":") + 1).trim();
//				}
//			}
//
//			if (userStr == null || userStr.trim().isEmpty()) {
//				return ERROR;
//			}
//
//			Timestamp now = new Timestamp(System.currentTimeMillis());
//
//			// --- ตัวแปรความจำ (Memory) ---
//			LocalDate memDate = null;
//			Timestamp memCheckIn = null;
//			Timestamp memCheckOut = null;
//			Timestamp memOtStart = null;
//			Timestamp memOtEnd = null;
//			String memProject = null;
//			String memSummary = null;
//
//			log.debug("==================================================");
//			log.debug("🚀 เริ่มต้นกระบวนการ Import TimeSheet");
//			log.debug("==================================================");
//
//			// ข้อมูลเริ่มที่ Row 8 (Index 7)
//			for (int rowIndex = 7; rowIndex <= sheet.getLastRowNum(); rowIndex++) {
//				Row row = sheet.getRow(rowIndex);
//				if (row == null) {
//					continue;
//				}
//
//				// =======================================================
//				// 1. ดึงข้อมูลดิบจาก Excel (Raw Data)
//				// =======================================================
//				String rawDateStr = getCellValue(row.getCell(0), dataFormatter);
//
//				// ป้องกันแถวสรุปด้านล่างสุด
//				if (rawDateStr != null && (rawDateStr.contains("สรุปเวลา") || rawDateStr.contains("Total"))) {
//					log.debug("🛑 เจอคำว่า 'สรุปเวลา/Total' -> สั่งหยุดการทำงาน (Break) ที่บรรทัด " + rowIndex);
//					break;
//				}
//
//				String rawCheckIn = getCellValue(row.getCell(1), dataFormatter);
//				String rawCheckOut = getCellValue(row.getCell(2), dataFormatter);
//				String rawOtStart = getCellValue(row.getCell(3), dataFormatter);
//				String rawOtEnd = getCellValue(row.getCell(4), dataFormatter);
//				String timeSpentStr = getCellValue(row.getCell(5), dataFormatter);
//				String projectStr = getCellValue(row.getCell(7), dataFormatter);
//				String summaryStr = getCellValue(row.getCell(8), dataFormatter);
//				String descriptionStr = getCellValue(row.getCell(9), dataFormatter);
//
//				// --- ยามเฝ้าประตู: เช็คว่าบรรทัดนี้ "มีข้อมูลอะไรให้เซฟไหม" ---
//				boolean hasWork = (projectStr != null && !projectStr.trim().isEmpty())
//						|| (summaryStr != null && !summaryStr.trim().isEmpty())
//						|| (descriptionStr != null && !descriptionStr.trim().isEmpty())
//						|| (rawCheckIn != null && !rawCheckIn.trim().isEmpty());
//
//				if (!hasWork) {
//					continue; // วันหยุด หรือ แถวว่างเปล่า -> เตะทิ้ง ไม่เซฟ!
//				}
//
//				// =======================================================
//				// 🔴 พิมพ์ LOG ข้อมูลดิบก่อนแปลง (Raw Data)
//				// =======================================================
//				log.debug("\n📍 แถวที่ (Row Index) : " + rowIndex);
//				log.debug("🔍 [1. ข้อมูลดิบจาก Excel]");
//				log.debug("   - วันที่ดิบ   : [" + rawDateStr + "]");
//				log.debug("   - เวลาเข้าดิบ : [" + rawCheckIn + "]");
//				log.debug("   - เวลาออกดิบ  : [" + rawCheckOut + "]");
//				log.debug("   - Project   : [" + projectStr + "]");
//				log.debug("   - Summary   : [" + summaryStr + "]");
//
//				// =======================================================
//				// 2. แปลงค่า "วันที่" (Date Parsing)
//				// =======================================================
//				boolean isMainTask = (rawDateStr != null && !rawDateStr.trim().isEmpty());
//
//				if (isMainTask) {
//					LocalDate parsedDate = parseDateRobust(row.getCell(0), dataFormatter);
//					if (parsedDate != null) {
//						memDate = parsedDate;
//					}
//
//					// 🔥 หัวใจสำคัญ: เมื่อเริ่มวันใหม่ ล้างความจำเวลาของวันเก่าทิ้งให้เกลี้ยง 100%
//					memCheckIn = null;
//					memCheckOut = null;
//					memOtStart = null;
//					memOtEnd = null;
//					memProject = null;
//					memSummary = null;
//				}
//
//				// =======================================================
//				// 3. แปลงค่า "เวลา" (Time Parsing)
//				// =======================================================
//				Timestamp curIn = parseTimeRobust(row.getCell(1), memDate, dataFormatter);
//				if (curIn != null)
//					memCheckIn = curIn; // ถ้ามีค่าใหม่ ให้เอาทับค่าเดิม
//
//				Timestamp curOut = parseTimeRobust(row.getCell(2), memDate, dataFormatter);
//				if (curOut != null)
//					memCheckOut = curOut;
//
//				Timestamp curOtStart = parseTimeRobust(row.getCell(3), memDate, dataFormatter);
//				if (curOtStart != null)
//					memOtStart = curOtStart;
//
//				Timestamp curOtEnd = parseTimeRobust(row.getCell(4), memDate, dataFormatter);
//				if (curOtEnd != null)
//					memOtEnd = curOtEnd;
//
//				// อัปเดต Project/Summary ถ้ามีการพิมพ์มา (เพื่อใช้กับงานย่อย)
//				if (projectStr != null && !projectStr.trim().isEmpty())
//					memProject = projectStr.trim();
//				if (summaryStr != null && !summaryStr.trim().isEmpty())
//					memSummary = summaryStr.trim();
//
//				// =======================================================
//				// 🟢 พิมพ์ LOG หลังจากแปลงค่าเสร็จแล้ว (Parsed Data)
//				// =======================================================
//				log.debug("✅ [2. ผลลัพธ์หลังแปลงค่า (เตรียมลง DB)]");
//				log.debug("   - memDate (วันที่)     : " + memDate);
//				log.debug("   - memCheckIn (เวลาเข้า) : " + memCheckIn);
//				log.debug("   - memCheckOut (เวลาออก) : " + memCheckOut);
//				log.debug("   - memProject (โปรเจกต์) : " + memProject);
//				log.debug("--------------------------------------------------");
//
//				// =======================================================
//				// 4. บันทึกข้อมูลลง Database
//				// =======================================================
//				Timesheet timesheet = new Timesheet();
//				timesheet.setId(timesheetDAO.getMaxId() + 1);
//				timesheet.setUserCreate(userStr);
//				timesheet.setUserUpdate(userStr);
//				timesheet.setStatus("W");
//				timesheet.setTimeCreate(now);
//				timesheet.setTimeUpdate(now);
//
//				if (memDate != null) {
//					timesheet.setStarted_date(java.sql.Date.valueOf(memDate));
//				}
//
//				timesheet.setTimeCheckIn(memCheckIn);
//				timesheet.setTimeCheckOut(memCheckOut);
//				timesheet.setOT_time_start(memOtStart);
//				timesheet.setOT_time_end(memOtEnd);
//
//				timesheet.setProject(memProject);
//				if (memProject != null) {
//					Project project = projectDAO.findByName(memProject);
//					if (project == null) {
//						Project newProject = new Project();
//						newProject.setProject_id(projectDAO.getMaxId() + 1);
//						newProject.setProject_name(memProject);
//						newProject.setStatus_project("1");
//						newProject.setUser_create(userStr);
//						newProject.setUser_update(userStr);
//						newProject.setTime_create(now);
//						newProject.setTime_update(now);
//						projectDAO.save(newProject);
//						timesheet.setProject_id(newProject.getProject_id());
//					} else {
//						timesheet.setProject_id(project.getProject_id());
//					}
//				}
//
//				timesheet.setSummary(memSummary);
//				if (memSummary != null) {
//					ProjectFunction function = projectFunctionDAO.findByName(memSummary);
//					if (function == null) {
//						ProjectFunction newFunction = new ProjectFunction();
//						newFunction.setFunction_id(projectFunctionDAO.getMaxId() + 1);
//						newFunction.setFunction_name(memSummary);
//						newFunction.setStatus("1");
//						newFunction.setProject_id(timesheet.getProject_id());
//						newFunction.setUser_create(userStr);
//						newFunction.setUser_update(userStr);
//						newFunction.setTime_create(now);
//						newFunction.setTime_update(now);
//						projectFunctionDAO.save(newFunction);
//						timesheet.setFunction_id(newFunction.getFunction_id());
//					} else {
//						timesheet.setFunction_id(function.getFunction_id());
//					}
//				}
//
//				timesheet.setDescription(
//						descriptionStr != null && !descriptionStr.trim().isEmpty() ? descriptionStr.trim() : null);
//				timesheet.setTimespent(
//						timeSpentStr != null && !timeSpentStr.trim().isEmpty() ? timeSpentStr.trim() : null);
//
//				timesheetDAO.save(timesheet);
//			}
//
//			log.debug("🎉 นำเข้าข้อมูลสำเร็จ!");
//			return SUCCESS;
//
//		} catch (Exception e) {
//			log.error("❌ เกิดข้อผิดพลาดระหว่างนำเข้า: ", e);
//			e.printStackTrace();
//			return ERROR;
//		}
//	}
//
//	// ==============================================================================
//	// Method 1: ตัวช่วยหั่นวันที่ขั้นเทพ (รองรับภาษาไทย อังกฤษ และทุก Format)
//	// ==============================================================================
//	private LocalDate parseDateRobust(Cell cell, DataFormatter formatter) {
//		if (cell == null)
//			return null;
//
//		// ท่าที่ 1: อ่านข้อความตรงๆ ก่อนเพื่อหลีกเลี่ยงวันที่เพี้ยน
//		String dStr = formatter.formatCellValue(cell);
//		if (dStr != null && !dStr.trim().isEmpty()) {
//			dStr = dStr.trim().toUpperCase();
//
//			// ดักจับเดือนภาษาไทยและอังกฤษ
//			String[] months = { "มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน", "กรกฎาคม", "สิงหาคม",
//					"กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม", "ม.ค.", "ก.พ.", "มี.ค.", "เม.ย.", "พ.ค.", "มิ.ย.",
//					"ก.ค.", "ส.ค.", "ก.ย.", "ต.ค.", "พ.ย.", "ธ.ค.", "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL",
//					"AUG", "SEP", "OCT", "NOV", "DEC" };
//
//			for (int i = 0; i < months.length; i++) {
//				if (dStr.contains(months[i])) {
//					String nums = dStr.replaceAll("[^0-9]", " ").trim();
//					String[] parts = nums.split("\\s+");
//					if (parts.length >= 2) {
//						int day = Integer.parseInt(parts[0]);
//						int year = Integer.parseInt(parts[parts.length - 1]);
//						if (year < 100)
//							year += 2000;
//						if (year > 2500)
//							year -= 543;
//						return LocalDate.of(year, (i % 12) + 1, day);
//					}
//				}
//			}
//
//			// ดักจับรูปแบบตัวเลข (เช่น 30/03/2026 หรือ 2026-03-30)
//			String cleanStr = dStr.replaceAll("[^0-9]", " ").trim();
//			String[] parts = cleanStr.split("\\s+");
//			if (parts.length >= 3) {
//				int p0 = Integer.parseInt(parts[0]);
//				int p1 = Integer.parseInt(parts[1]);
//				int p2 = Integer.parseInt(parts[2]);
//
//				int year, month, day;
//				if (p0 > 1000) {
//					year = p0;
//					month = p1;
//					day = p2;
//				} else if (p2 > 1000) {
//					year = p2;
//					month = p1;
//					day = p0;
//				} else {
//					year = p2 + 2000;
//					month = p1;
//					day = p0;
//				}
//
//				// 🔥 ป้องกัน Excel สลับเดือนกับวันมาให้ (เช่น เดือน 30 วันที่ 3)
//				if (month > 12 && day <= 12) {
//					int temp = month;
//					month = day;
//					day = temp;
//				}
//
//				if (year > 2500)
//					year -= 543;
//				return LocalDate.of(year, month, day);
//			}
//		}
//
//		// ท่าที่ 2: ถ้าเป็นตัวเลขวันที่ใน Excel จริงๆ (ไม่ได้จัดรูปแบบเป็น Text)
//		try {
//			java.util.Date javaDate = cell.getDateCellValue();
//			if (javaDate != null) {
//				java.util.Calendar cal = java.util.Calendar.getInstance();
//				cal.setTime(javaDate);
//				int year = cal.get(java.util.Calendar.YEAR);
//				if (year > 1900) {
//					if (year > 2500)
//						year -= 543;
//					return LocalDate.of(year, cal.get(java.util.Calendar.MONTH) + 1,
//							cal.get(java.util.Calendar.DAY_OF_MONTH));
//				}
//			}
//		} catch (Exception e) {
//		}
//
//		return null;
//	}
//
//	// ==============================================================================
//	// Method 2: ตัวดึงเวลา (ดูดล้างทุกอักขระขยะ ไม่พึ่ง CellType)
//	// ==============================================================================
//	private Timestamp parseTimeRobust(Cell cell, LocalDate date, DataFormatter formatter) {
//		if (cell == null || date == null)
//			return null;
//
//		// 1. อ่าน Text ตรงๆ
//		String tStr = formatter.formatCellValue(cell);
//		if (tStr != null && !tStr.trim().isEmpty()) {
//			tStr = tStr.trim().toUpperCase();
//
//			// ดักจับทศนิยมในคราบ String (เช่น 0.3388)
//			String decStr = tStr.replace(",", ".").replaceAll("[^0-9\\.]", "");
//			if (decStr.startsWith("0.") && decStr.length() > 2) {
//				try {
//					double val = Double.parseDouble(decStr);
//					if (val > 0 && val < 1.0) {
//						int totalSeconds = (int) Math.round(val * 24 * 60 * 60);
//						int h = totalSeconds / 3600;
//						int m = (totalSeconds % 3600) / 60;
//						int s = totalSeconds % 60;
//						return Timestamp.valueOf(String.format("%s %02d:%02d:%02d", date.toString(), h, m, s));
//					}
//				} catch (Exception e) {
//				}
//			}
//
//			// ดึงแบบปกติ (ตัดตัวอักษรทิ้ง เปลี่ยนจุดเป็นโคลอน)
//			String cleanTime = tStr.replace(".", ":").replaceAll("[^0-9:]", "");
//			String[] parts = cleanTime.split(":");
//			if (parts.length >= 2) {
//				try {
//					int h = Integer.parseInt(parts[0]);
//					int m = Integer.parseInt(parts[1]);
//					int s = (parts.length > 2 && !parts[2].isEmpty()) ? Integer.parseInt(parts[2]) : 0;
//
//					if (tStr.contains("PM") && h < 12)
//						h += 12;
//					if (tStr.contains("AM") && h == 12)
//						h = 0;
//
//					return Timestamp.valueOf(String.format("%s %02d:%02d:%02d", date.toString(), h, m, s));
//				} catch (Exception e) {
//				}
//			}
//		}
//
//		// 2. ถ้าเป็นเลขเศษส่วนวันใน Excel โดยตรง
//		try {
//			double val = cell.getNumericCellValue();
//			double fraction = val - Math.floor(val);
//			if (fraction > 0) {
//				int totalSeconds = (int) Math.round(fraction * 24 * 60 * 60);
//				int h = totalSeconds / 3600;
//				int m = (totalSeconds % 3600) / 60;
//				int s = totalSeconds % 60;
//				return Timestamp.valueOf(String.format("%s %02d:%02d:%02d", date.toString(), h, m, s));
//			}
//		} catch (Exception e) {
//		}
//
//		return null;
//	}
//
//	// ==============================================================================
//	// Method 3: ตัวดึงข้อความทั่วไป
//	// ==============================================================================
//	private String getCellValue(Cell cell, DataFormatter formatter) {
//		if (cell == null) {
//			return "";
//		}
//		return formatter.formatCellValue(cell).trim();
//	}

	public String importTimeSheet() throws Exception {

		try {
			FileInputStream fis = new FileInputStream(fileUpload);
			Workbook workbook = WorkbookFactory.create(fis);

			Sheet sheet = workbook.getSheetAt(0);
			DataFormatter dataFormatter = new DataFormatter();

			// 🔥 เพิ่มอาวุธใหม่: ตัวคำนวณสูตร Excel (Formula Evaluator)
			FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator();

			// ดึงค่า User
			Row userRow = sheet.getRow(1);
			String userStr = "";
			if (userRow != null) {
				String colB = getCellValue(userRow.getCell(1), dataFormatter, evaluator);
				String colA = getCellValue(userRow.getCell(0), dataFormatter, evaluator);

				if (colB != null && !colB.trim().isEmpty()) {
					userStr = colB.trim();
				} else if (colA != null && colA.contains(":")) {
					userStr = colA.substring(colA.indexOf(":") + 1).trim();
				}
			}

			if (userStr == null || userStr.trim().isEmpty()) {
				return ERROR;
			}

			Timestamp now = new Timestamp(System.currentTimeMillis());

			// --- ตัวแปรความจำ (Memory) ---
			LocalDate memDate = null;
			Timestamp memCheckIn = null;
			Timestamp memCheckOut = null;
			Timestamp memOtStart = null;
			Timestamp memOtEnd = null;
			String memProject = null;
			String memSummary = null;

			// ข้อมูลเริ่มที่ Row 8 (Index 7)
			for (int rowIndex = 7; rowIndex <= sheet.getLastRowNum(); rowIndex++) {
				Row row = sheet.getRow(rowIndex);
				if (row == null) {
					continue;
				}

				String rawDateStr = getCellValue(row.getCell(0), dataFormatter, evaluator);

				// ป้องกันแถวสรุปด้านล่าง
				if (rawDateStr != null && (rawDateStr.contains("สรุปเวลา") || rawDateStr.contains("Total"))) {
					break;
				}

				String checkInStr = getCellValue(row.getCell(1), dataFormatter, evaluator);
				String checkOutStr = getCellValue(row.getCell(2), dataFormatter, evaluator);
				String otStartStr = getCellValue(row.getCell(3), dataFormatter, evaluator);
				String otEndStr = getCellValue(row.getCell(4), dataFormatter, evaluator);
				String timeSpentStr = getCellValue(row.getCell(5), dataFormatter, evaluator);
				String projectStr = getCellValue(row.getCell(7), dataFormatter, evaluator);
				String summaryStr = getCellValue(row.getCell(8), dataFormatter, evaluator);
				String descriptionStr = getCellValue(row.getCell(9), dataFormatter, evaluator);

				// --- 1. ยามเฝ้าประตู ---
				boolean hasWork = (projectStr != null && !projectStr.trim().isEmpty())
						|| (summaryStr != null && !summaryStr.trim().isEmpty())
						|| (descriptionStr != null && !descriptionStr.trim().isEmpty())
						|| (checkInStr != null && !checkInStr.trim().isEmpty());

				if (!hasWork) {
					continue;
				}

				// --- 2. จัดการ "วันที่" ---
				LocalDate parsedDate = parseDateRobust(row.getCell(0), dataFormatter, evaluator);

				if (parsedDate != null) {
					memDate = parsedDate;

					// 🔥 ล้างความจำเก่าทิ้งทั้งหมด
					memCheckIn = null;
					memCheckOut = null;
					memOtStart = null;
					memOtEnd = null;
					memProject = null;
					memSummary = null;
				}

				// --- 3. ดึง "เวลา" (ส่ง Evaluator เข้าไปประมวลผลสูตร RAND() ด้วย) ---
				Timestamp curIn = parseTimeRobust(row.getCell(1), memDate, dataFormatter, evaluator);
				if (curIn != null)
					memCheckIn = curIn;

				Timestamp curOut = parseTimeRobust(row.getCell(2), memDate, dataFormatter, evaluator);
				if (curOut != null)
					memCheckOut = curOut;

				Timestamp curOtStart = parseTimeRobust(row.getCell(3), memDate, dataFormatter, evaluator);
				if (curOtStart != null)
					memOtStart = curOtStart;

				Timestamp curOtEnd = parseTimeRobust(row.getCell(4), memDate, dataFormatter, evaluator);
				if (curOtEnd != null)
					memOtEnd = curOtEnd;

				// อัปเดต Project/Summary
				if (projectStr != null && !projectStr.trim().isEmpty())
					memProject = projectStr.trim();
				if (summaryStr != null && !summaryStr.trim().isEmpty())
					memSummary = summaryStr.trim();

				// --- 4. บันทึกข้อมูลลง Database ---
				Timesheet timesheet = new Timesheet();
				timesheet.setId(timesheetDAO.getMaxId() + 1);
				timesheet.setUserCreate(userStr);
				timesheet.setUserUpdate(userStr);
				timesheet.setStatus("W");
				timesheet.setTimeCreate(now);
				timesheet.setTimeUpdate(now);

				if (memDate != null) {
					timesheet.setStarted_date(java.sql.Date.valueOf(memDate));
				}

				timesheet.setTimeCheckIn(memCheckIn);
				timesheet.setTimeCheckOut(memCheckOut);
				timesheet.setOT_time_start(memOtStart);
				timesheet.setOT_time_end(memOtEnd);

				timesheet.setProject(memProject);
				if (memProject != null) {
					Project project = projectDAO.findByName(memProject);
					if (project == null) {
						Project newProject = new Project();
						newProject.setProject_id(projectDAO.getMaxId() + 1);
						newProject.setProject_name(memProject);
						newProject.setStatus_project("1");
						newProject.setUser_create(userStr);
						newProject.setUser_update(userStr);
						newProject.setTime_create(now);
						newProject.setTime_update(now);
						projectDAO.save(newProject);
						timesheet.setProject_id(newProject.getProject_id());
					} else {
						timesheet.setProject_id(project.getProject_id());
					}
				}

				timesheet.setSummary(memSummary);
				if (memSummary != null) {
					ProjectFunction function = projectFunctionDAO.findByName(memSummary);
					if (function == null) {
						ProjectFunction newFunction = new ProjectFunction();
						newFunction.setFunction_id(projectFunctionDAO.getMaxId() + 1);
						newFunction.setFunction_name(memSummary);
						newFunction.setStatus("1");
						newFunction.setProject_id(timesheet.getProject_id());
						newFunction.setUser_create(userStr);
						newFunction.setUser_update(userStr);
						newFunction.setTime_create(now);
						newFunction.setTime_update(now);
						projectFunctionDAO.save(newFunction);
						timesheet.setFunction_id(newFunction.getFunction_id());
					} else {
						timesheet.setFunction_id(function.getFunction_id());
					}
				}

				timesheet.setDescription(
						descriptionStr != null && !descriptionStr.trim().isEmpty() ? descriptionStr.trim() : null);
//				timesheet.setTimespent(
//						timeSpentStr != null && !timeSpentStr.trim().isEmpty() ? timeSpentStr.trim() : null);

				timesheetDAO.save(timesheet);
			}

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	// ==============================================================================
	// Method 1: ตัวหั่นวันที่ (รองรับ Evaluator)
	// ==============================================================================
	private LocalDate parseDateRobust(Cell cell, DataFormatter formatter, FormulaEvaluator evaluator) {
		if (cell == null)
			return null;

		try {
			// ประมวลผลสูตรก่อนอ่าน
			String dStr = formatter.formatCellValue(cell, evaluator);
			if (dStr != null && !dStr.trim().isEmpty()) {
				dStr = dStr.trim().toUpperCase();

				String[] months = { "มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน", "กรกฎาคม",
						"สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม", "ม.ค.", "ก.พ.", "มี.ค.", "เม.ย.",
						"พ.ค.", "มิ.ย.", "ก.ค.", "ส.ค.", "ก.ย.", "ต.ค.", "พ.ย.", "ธ.ค.", "JAN", "FEB", "MAR", "APR",
						"MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };

				for (int i = 0; i < months.length; i++) {
					if (dStr.contains(months[i])) {
						String nums = dStr.replaceAll("[^0-9]", " ").trim();
						String[] parts = nums.split("\\s+");
						if (parts.length >= 2) {
							int day = Integer.parseInt(parts[0]);
							int year = Integer.parseInt(parts[parts.length - 1]);
							if (year < 100)
								year += 2000;
							if (year > 2500)
								year -= 543;
							return LocalDate.of(year, (i % 12) + 1, day);
						}
					}
				}

				String cleanStr = dStr.replaceAll("[^0-9]", " ").trim();
				String[] parts = cleanStr.split("\\s+");
				if (parts.length >= 3) {
					int p0 = Integer.parseInt(parts[0]);
					int p1 = Integer.parseInt(parts[1]);
					int p2 = Integer.parseInt(parts[2]);

					int year, month, day;
					if (p0 > 1000) {
						year = p0;
						month = p1;
						day = p2;
					} else if (p2 > 1000) {
						year = p2;
						month = p1;
						day = p0;
					} else {
						year = p2 + 2000;
						month = p1;
						day = p0;
					}

					if (month > 12 && day <= 12) {
						int temp = month;
						month = day;
						day = temp;
					}

					if (year > 2500)
						year -= 543;
					return LocalDate.of(year, month, day);
				}
			}
		} catch (Exception e) {
		}

		try {
			java.util.Date javaDate = cell.getDateCellValue();
			if (javaDate != null) {
				java.util.Calendar cal = java.util.Calendar.getInstance();
				cal.setTime(javaDate);
				int year = cal.get(java.util.Calendar.YEAR);
				if (year > 1900) {
					if (year > 2500)
						year -= 543;
					return LocalDate.of(year, cal.get(java.util.Calendar.MONTH) + 1,
							cal.get(java.util.Calendar.DAY_OF_MONTH));
				}
			}
		} catch (Exception e) {
		}

		return null;
	}

	// ==============================================================================
	// Method 2: ตัวดึงเวลา (รองรับ Evaluator ประมวลผลสูตร RAND)
	// ==============================================================================
	private Timestamp parseTimeRobust(Cell cell, LocalDate date, DataFormatter formatter, FormulaEvaluator evaluator) {
		if (cell == null || date == null)
			return null;

		try {
			// 🔥 ใช้ evaluator บังคับให้ Excel รันสูตรให้ออกมาเป็นเวลาจริงๆ ก่อน
			String tStr = formatter.formatCellValue(cell, evaluator);
			if (tStr != null && !tStr.trim().isEmpty()) {
				tStr = tStr.trim().toUpperCase();

				String decStr = tStr.replace(",", ".").replaceAll("[^0-9\\.]", "");
				if (decStr.startsWith("0.") && decStr.length() > 2) {
					double val = Double.parseDouble(decStr);
					if (val > 0 && val < 1.0) {
						int totalSeconds = (int) Math.round(val * 24 * 60 * 60);
						int h = totalSeconds / 3600;
						int m = (totalSeconds % 3600) / 60;
						int s = totalSeconds % 60;
						return Timestamp.valueOf(String.format("%s %02d:%02d:%02d", date.toString(), h, m, s));
					}
				}

				String cleanTime = tStr.replace(".", ":").replaceAll("[^0-9:]", "");
				String[] parts = cleanTime.split(":");
				if (parts.length >= 2) {
					int h = Integer.parseInt(parts[0]);
					int m = Integer.parseInt(parts[1]);
					int s = (parts.length > 2 && !parts[2].isEmpty()) ? Integer.parseInt(parts[2]) : 0;

					if (tStr.contains("PM") && h < 12)
						h += 12;
					if (tStr.contains("AM") && h == 12)
						h = 0;

					return Timestamp.valueOf(String.format("%s %02d:%02d:%02d", date.toString(), h, m, s));
				}
			}
		} catch (Exception e) {
		}

		try {
			double val = cell.getNumericCellValue();
			double fraction = val - Math.floor(val);
			if (fraction > 0) {
				int totalSeconds = (int) Math.round(fraction * 24 * 60 * 60);
				int h = totalSeconds / 3600;
				int m = (totalSeconds % 3600) / 60;
				int s = totalSeconds % 60;
				return Timestamp.valueOf(String.format("%s %02d:%02d:%02d", date.toString(), h, m, s));
			}
		} catch (Exception e) {
		}

		return null;
	}

	// ==============================================================================
	// Method 3: ดึงข้อความทั่วไป (รองรับ Evaluator)
	// ==============================================================================
	private String getCellValue(Cell cell, DataFormatter formatter, FormulaEvaluator evaluator) {
		if (cell == null) {
			return "";
		}
		try {
			// ประมวลผลสูตรทุกอย่างให้เป็นข้อความ
			return formatter.formatCellValue(cell, evaluator).trim();
		} catch (Exception e) {
			return formatter.formatCellValue(cell).trim();
		}
	}

	public File getFileUpload() {
		return fileUpload;
	}

	public void setFileUpload(File fileUpload) {
		this.fileUpload = fileUpload;
	}

	public String exportTimeSheet() throws Exception {

		String date = request.getParameter("date");
		String userId = request.getParameter("userId");

		User user = userDAO.findById(userId);

		FileInputStream file = new FileInputStream(
				ServletActionContext.getServletContext().getRealPath("/upload/template/timesheet.xlsx"));

		Workbook workbook = new XSSFWorkbook(file);
		Sheet sheet = workbook.getSheetAt(0);

		// ===== ใส่ข้อมูล user =====
		sheet.getRow(2).getCell(2).setCellValue(user.getId());
		sheet.getRow(2).getCell(16).setCellValue(user.getTitleNameTH());

		sheet.getRow(3).getCell(2).setCellValue("Cube SoftTech");
//		sheet.getRow(4).getCell(2).setCellValue("Monkey");
		sheet.getRow(3).getCell(16).setCellValue(date);

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-yyyy");

		YearMonth yearMonth = YearMonth.parse(date, formatter);

		LocalDate startLocalDate = yearMonth.atDay(1);
		LocalDate endLocalDate = yearMonth.atEndOfMonth();

		Date startOfMonth = java.sql.Date.valueOf(startLocalDate);
		Date endOfMonth = java.sql.Date.valueOf(endLocalDate);

		Integer total_leave = 0;
		Integer total_absent = 0;
		Integer total_work = 0;
		Integer total_late = 0;
		Integer total_OT = 0;

		long total_ot_minutes = 0;

		// ประกาศตัวแปรเก็บสะสมชั่วโมง OT แยกตามประเภทเรท
		double sum_ot_x15 = 0.0;
		double sum_ot_x2 = 0.0;
		double sum_ot_x3 = 0.0;

		// Map date with time sheet
		Set<String> otDateSet = new HashSet<>();
		Set<String> workDateSet = new HashSet<>();
		Set<String> lateDateSet = new HashSet<>();

		// ประกาศ Set เพื่อเก็บ "วันที่" สำหรับนับว่ามีกี่วันในแต่ละเรท OT
		Set<String> ot15DateSet = new HashSet<>();
		Set<String> ot2DateSet = new HashSet<>();
		Set<String> ot3DateSet = new HashSet<>();

		for (int day = 1; day <= yearMonth.lengthOfMonth(); day++) {

			LocalDate localDate = yearMonth.atDay(day);

			boolean isWeekend = false;
			boolean isHoliday = false;
			boolean isLeave = false;

			// เช็ค weekend
			DayOfWeek dayOfWeek = localDate.getDayOfWeek();
			if (dayOfWeek == DayOfWeek.SATURDAY || dayOfWeek == DayOfWeek.SUNDAY) {
				isWeekend = true;
			}

			List<Holiday> holidays = holidayDAO.findAll();

			for (Holiday holiday : holidays) {
				LocalDate startDate = holiday.getStart_date().toLocalDate();
				LocalDate endDate = holiday.getEnd_date().toLocalDate();

				// เทียบแบบ LocalDate
				if (!localDate.isBefore(startDate) && !localDate.isAfter(endDate)) {
					isHoliday = true;
				}
			}

			List<Leaves> leaveUsers = leaveDAO.findLeaveByUserId(userId);

			for (Leaves leaveUser : leaveUsers) {
				LocalDate startDate = leaveUser.getStartDate().toLocalDateTime().toLocalDate();
				LocalDate endDate = leaveUser.getEndDate().toLocalDateTime().toLocalDate();

				// เทียบแบบ LocalDateTime
				if (!localDate.isBefore(startDate) && !localDate.isAfter(endDate)) {
					isLeave = true;
					total_leave++;
				}
			}
			// นับเฉพาะวันที่เป็นวันทำงานจริง
			if (!isWeekend && !isHoliday && !isLeave) {
				total_work++;
			}
		}

		List<Map<String, Object>> timeSheetList = timesheetDAO.searchTimesheetByUserCreateAndDate(userId, startOfMonth,
				endOfMonth);

		int startRow = 7;
		int index = 0;

		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

		for (Map<String, Object> ts : timeSheetList) {

			Date checkIn = (Date) ts.get("time_check_in");
			Date checkOut = (Date) ts.get("time_check_out");
			Date startOT = (Date) ts.get("OT_time_start");
			Date endOT = (Date) ts.get("OT_time_end");
			Date startedDate = (Date) ts.get("started_date");

			// format วันที่
			String startedDateStr = "";
			if (startedDate != null) {
				startedDateStr = toLocalDate(startedDate).format(dateFormatter);
			}

			// format เวลา
			String checkInStr = checkIn != null ? toLocalTime(checkIn).format(timeFormatter) : "";
			String checkOutStr = checkOut != null ? toLocalTime(checkOut).format(timeFormatter) : "";
			String startOTStr = startOT != null ? toLocalTime(startOT).format(timeFormatter) : "";
			String endOTStr = endOT != null ? toLocalTime(endOT).format(timeFormatter) : "";

			String otDateKey = null;
			if (startOT != null) {
				otDateKey = toLocalDate(startOT).format(dateFormatter);
			} else if (checkIn != null) {
				otDateKey = toLocalDate(checkIn).format(dateFormatter);
			} else if (startedDate != null) {
				otDateKey = toLocalDate(startedDate).format(dateFormatter);
			}

			// Total time check in / check out
			if (checkIn != null && checkOut != null) {
				long diffMillis = checkOut.getTime() - checkIn.getTime();
				long diffMinutes = diffMillis / (1000 * 60);
				String totalTime = String.format("%02d:%02d", diffMinutes / 60, diffMinutes % 60);
				ts.put("total_time", totalTime);
			}

			// Total time start OT / end OT
			if (startOT != null && endOT != null) {
				long diffMillis = endOT.getTime() - startOT.getTime();
				long diffMinutes = diffMillis / (1000 * 60);

				total_ot_minutes += diffMinutes;

				String totalTimeOT = String.format("%02d:%02d", diffMinutes / 60, diffMinutes % 60);
				ts.put("total_time_OT", totalTimeOT);

				String key = toLocalDate(startOT).format(formatter);
				otDateSet.add(key);
			}

			// ดึงค่า OT แต่ละเรท + บวกชั่วโมงสะสม + เก็บวันที่ลง Set
			Object ot15Obj = ts.get("OT_hour_x15");
			if (ot15Obj != null && !ot15Obj.toString().trim().isEmpty()) {
				double val = Double.parseDouble(ot15Obj.toString());
				if (val > 0) {
					sum_ot_x15 += val;
					if (otDateKey != null) {
						ot15DateSet.add(otDateKey);
					}
				}
			}

			Object ot2Obj = ts.get("OT_hour_x2");
			if (ot2Obj != null && !ot2Obj.toString().trim().isEmpty()) {
				double val = Double.parseDouble(ot2Obj.toString());
				if (val > 0) {
					sum_ot_x2 += val;
					if (otDateKey != null) {
						ot2DateSet.add(otDateKey);
					}
				}
			}

			Object ot3Obj = ts.get("OT_hour_x3");
			if (ot3Obj != null && !ot3Obj.toString().trim().isEmpty()) {
				double val = Double.parseDouble(ot3Obj.toString());
				if (val > 0) {
					sum_ot_x3 += val;
					if (otDateKey != null) {
						ot3DateSet.add(otDateKey);
					}
				}
			}

			// เช็คมาสาย / กลับก่อน
			if (checkIn != null && checkOut != null) {
				LocalDate localDate = toLocalDate(checkIn);
				LocalDateTime checkInTime = toLocalDateTime(checkIn);
				LocalDateTime checkOutTime = toLocalDateTime(checkOut);

				LocalTime nineAM = LocalTime.of(9, 0);
				LocalTime sixPM = LocalTime.of(18, 0);

				String key = localDate.format(formatter);
				String keyLate = checkInTime.toLocalDate().format(formatter);
				boolean isLate = false;

				// ❌ มาสาย หรือ กลับก่อน
				if (checkInTime.toLocalTime().isAfter(nineAM) || checkOutTime.toLocalTime().isBefore(sixPM)) {
					isLate = true;
				}

				if (isLate) {
					lateDateSet.add(keyLate);
				} else if (lateDateSet.contains(keyLate)) {
					lateDateSet.remove(keyLate);
				}

				workDateSet.add(key);
			}

			Row row = sheet.getRow(startRow + index);

			String project = ts.get("project") != null ? ts.get("project").toString() : "";
			String summary = ts.get("summary") != null ? ts.get("summary").toString() : "";

			String detailString = "";

			if (project.trim().isEmpty() && !summary.trim().isEmpty()) {
				detailString = summary;
			} else if (!project.trim().isEmpty() && summary.trim().isEmpty()) {
				detailString = project;
			} else if (!project.trim().isEmpty() && !summary.trim().isEmpty()) {
				detailString = project + " / " + summary;
			} else {
				detailString = "-";
			}

			row.getCell(0).setCellValue(startedDateStr);
			row.getCell(2).setCellValue(checkInStr);
			row.getCell(4).setCellValue(checkOutStr);
			row.getCell(6).setCellValue(startOTStr);
			row.getCell(8).setCellValue(endOTStr);
			row.getCell(10).setCellValue(ts.get("total_time") != null ? ts.get("total_time").toString() : "");
			row.getCell(12).setCellValue(ts.get("total_time_OT") != null ? ts.get("total_time_OT").toString() : "");
			row.getCell(14).setCellValue(detailString);

			index++;
		}

		total_OT = otDateSet.size();
		total_absent = total_work - workDateSet.size();
		total_work = total_work - total_absent;
		total_late = lateDateSet.size();

		double hours_total_work = total_work * 8.0;
		double hours_total_late = total_late * 1.0;
		double hours_total_leave = total_leave * 8.0;
		double hours_total_ot = (double) total_ot_minutes / 60.0;

		int[] dayCols = { 6, 7 };

		int[] hourCols = { 8, 9, 10, 11 };

		// 1. บรรทัด Total Mandays (Index 40)
		Row rowMandays = sheet.getRow(40);
		if (rowMandays != null) {
			for (int c : dayCols) {
				if (rowMandays.getCell(c) == null)
					rowMandays.createCell(c);
				rowMandays.getCell(c).setCellValue(total_work);
			}
			for (int c : hourCols) {
				if (rowMandays.getCell(c) == null)
					rowMandays.createCell(c);
				rowMandays.getCell(c).setCellValue(Double.parseDouble(String.format("%.2f", hours_total_work)));
			}
		}

		// 2. บรรทัด สาย + ออกก่อน (Index 41)
		Row rowLate = sheet.getRow(41);
		if (rowLate != null) {
			for (int c : dayCols) {
				if (rowLate.getCell(c) == null)
					rowLate.createCell(c);
				rowLate.getCell(c).setCellValue(total_late);
			}
			for (int c : hourCols) {
				if (rowLate.getCell(c) == null)
					rowLate.createCell(c);
				rowLate.getCell(c).setCellValue(Double.parseDouble(String.format("%.2f", hours_total_late)));
			}
		}

		// 3. บรรทัด ลางาน (Index 42)
		Row rowLeave = sheet.getRow(42);
		if (rowLeave != null) {
			for (int c : dayCols) {
				if (rowLeave.getCell(c) == null)
					rowLeave.createCell(c);
				rowLeave.getCell(c).setCellValue(total_leave);
			}
			for (int c : hourCols) {
				if (rowLeave.getCell(c) == null)
					rowLeave.createCell(c);
				rowLeave.getCell(c).setCellValue(Double.parseDouble(String.format("%.2f", hours_total_leave)));
			}
		}

		// 4. บรรทัด ล่วงเวลาทั้งหมด (Index 43)
		Row rowOT = sheet.getRow(43);
		if (rowOT != null) {
			for (int c : dayCols) {
				if (rowOT.getCell(c) == null)
					rowOT.createCell(c);
				rowOT.getCell(c).setCellValue(total_OT);
			}
			for (int c : hourCols) {
				if (rowOT.getCell(c) == null)
					rowOT.createCell(c);
				rowOT.getCell(c).setCellValue(Double.parseDouble(String.format("%.2f", hours_total_ot)));
			}
		}

		// 5. บรรทัด จำนวนชม.OT * 1 เท่า (Index 44)
		Row rowOT1 = sheet.getRow(44);
		if (rowOT1 != null) {
			for (int c : dayCols) {
				if (rowOT1.getCell(c) == null)
					rowOT1.createCell(c);
				rowOT1.getCell(c).setCellValue(0);
			}
			for (int c : hourCols) {
				if (rowOT1.getCell(c) == null)
					rowOT1.createCell(c);
				rowOT1.getCell(c).setCellValue(0.00);
			}
		}

		// 6. บรรทัด จำนวนชม.OT * 1.5 เท่า (Index 45)
		Row rowOT15 = sheet.getRow(45);
		if (rowOT15 != null) {
			for (int c : dayCols) {
				if (rowOT15.getCell(c) == null)
					rowOT15.createCell(c);
				rowOT15.getCell(c).setCellValue(ot15DateSet.size());
			}
			for (int c : hourCols) {
				if (rowOT15.getCell(c) == null)
					rowOT15.createCell(c);
				rowOT15.getCell(c).setCellValue(Double.parseDouble(String.format("%.2f", sum_ot_x15)));
			}
		}

		// 7. บรรทัด จำนวนชม.OT * 3 เท่า (Index 46)
		Row rowOT3 = sheet.getRow(46);
		if (rowOT3 != null) {
			for (int c : dayCols) {
				if (rowOT3.getCell(c) == null)
					rowOT3.createCell(c);
				rowOT3.getCell(c).setCellValue(ot3DateSet.size());
			}
			for (int c : hourCols) {
				if (rowOT3.getCell(c) == null)
					rowOT3.createCell(c);
				rowOT3.getCell(c).setCellValue(Double.parseDouble(String.format("%.2f", sum_ot_x3)));
			}
		}

		// ===== download =====
		ServletActionContext.getResponse()
				.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

		ServletActionContext.getResponse().setHeader("Content-Disposition",
				"attachment; filename=report_timesheet.xlsx");

		ServletOutputStream out = ServletActionContext.getResponse().getOutputStream();
		workbook.write(out);

		out.flush();
		out.close();
		workbook.close();

		return NONE;
	}

	private LocalDate toLocalDate(Date date) {
		if (date == null)
			return null;
		return Instant.ofEpochMilli(date.getTime()).atZone(ZoneId.systemDefault()).toLocalDate();
	}

	private LocalTime toLocalTime(Date date) {
		if (date == null)
			return null;
		return Instant.ofEpochMilli(date.getTime()).atZone(ZoneId.systemDefault()).toLocalTime();
	}

	private LocalDateTime toLocalDateTime(Date date) {
		if (date == null)
			return null;
		return Instant.ofEpochMilli(date.getTime()).atZone(ZoneId.systemDefault()).toLocalDateTime();
	}

	public List<ProjectFunction> getProjectFunctions() {
		return projectFunctions;
	}

	public void setProjectFunctions(List<ProjectFunction> projectFunctions) {
		this.projectFunctions = projectFunctions;
	}

	public Map<String, Object> getNewTimeSheetMap() {
		return newTimeSheetMap;
	}

	public void setNewTimeSheetMap(Map<String, Object> newTimeSheetMap) {
		this.newTimeSheetMap = newTimeSheetMap;
	}

}
