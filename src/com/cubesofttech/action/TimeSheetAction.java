package com.cubesofttech.action;

import java.io.FileInputStream;
import java.sql.Timestamp;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
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
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
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

	public String timeSheetList() {
		try {

			User ur = (User) request.getSession().getAttribute("onlineUser");

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
			request.setAttribute("dateList", dateList);

			// Map date with time sheet
			Map<String, List<Map<String, Object>>> timeSheetMap = new HashMap<>();
			Set<String> otDateSet = new HashSet<>();
			Set<String> workDateSet = new HashSet<>();
			Set<String> lateDateSet = new HashSet<>();

			for (Map<String, Object> ts : timeSheetList) {

//				Total time check in / check out
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

//				Total time start OT / end OT
				Date startOT = (Date) ts.get("OT_time_start");
				Date endOT = (Date) ts.get("OT_time_end");

				if (startOT != null && endOT != null) {

					long diffMillis = endOT.getTime() - startOT.getTime();
					long diffMinutes = diffMillis / (1000 * 60);
					long hours = diffMinutes / 60;
					long minutes = diffMinutes % 60;
					String totalTimeOT = String.format("%02d:%02d", hours, minutes);
					ts.put("total_time_OT", totalTimeOT);

					LocalDate localDate = startOT.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

					String key = localDate.format(formatter);
					otDateSet.add(key);
				}

				if (checkIn != null && checkOut != null) {

					LocalDate localDate = checkIn.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

					LocalDateTime checkInTime = checkIn.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
					LocalDateTime checkOutTime = checkOut.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();

					LocalTime nineAM = LocalTime.of(9, 0);
					LocalTime sixPM = LocalTime.of(18, 0);

					String key = localDate.format(formatter);
					String keyLate = checkInTime.toLocalDate().format(formatter);
					boolean isLate = false;

					// ❌ มาสาย
					if (checkInTime.toLocalTime().isAfter(nineAM)) {
						isLate = true;
					}

					// ❌ กลับก่อน
					if (checkOutTime.toLocalTime().isBefore(sixPM)) {
						isLate = true;
					}

					if (isLate) {
						lateDateSet.add(keyLate);
					} else if (lateDateSet.contains(keyLate)) {
						lateDateSet.remove(keyLate);
					}
					;
					timeSheetMap.computeIfAbsent(key, k -> new ArrayList<>()).add(ts);
					workDateSet.add(key);
				}
			}

			total_OT = otDateSet.size();
			total_absent = total_work - workDateSet.size();
			total_work = total_work - total_absent;
			total_late = lateDateSet.size();

			request.setAttribute("total_absent", total_absent);
			request.setAttribute("total_OT", total_OT);
			request.setAttribute("total_work", total_work);
			request.setAttribute("total_leave", total_leave);
			request.setAttribute("total_late", total_late);

			request.setAttribute("timeSheetMap", timeSheetMap);

			return SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
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
			log.debug(searchDate);
			log.debug(idUserSelected);
			request.setAttribute("searchDate", searchDate);
			request.setAttribute("searchUserId", idUserSelected);
			List<User> userList = userDAO.findAll();

			List<User> userEnable = new ArrayList<User>();
			;
			List<User> userDisable = new ArrayList<User>();
			;

			userEnable = userList.stream().filter(user -> user.getEnable().equals("1")).collect(Collectors.toList());
			userDisable = userList.stream().filter(user -> user.getEnable().equals("0")).collect(Collectors.toList());

			request.setAttribute("userEnable", userEnable);
			request.setAttribute("userDisable", userDisable);
			;

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

			for (Map<String, Object> ts : timeSheetList) {

//				Total time check in / check out
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

//				Total time start OT / end OT
				Date startOT = (Date) ts.get("OT_time_start");
				Date endOT = (Date) ts.get("OT_time_end");

				if (startOT != null && endOT != null) {
					long diffMillis = endOT.getTime() - startOT.getTime();
					long diffMinutes = diffMillis / (1000 * 60);
					long hours = diffMinutes / 60;
					long minutes = diffMinutes % 60;
					String totalTimeOT = String.format("%02d:%02d", hours, minutes);
					ts.put("total_time_OT", totalTimeOT);

					LocalDate localDate = startOT.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

					String key = localDate.format(formatter);
					otDateSet.add(key);
				}

				if (checkIn != null) {
					LocalDate localDate = checkIn.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

					LocalDateTime checkInTime = checkIn.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
					LocalDateTime checkOutTime = checkOut.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();

					LocalTime nineAM = LocalTime.of(9, 0);
					LocalTime sixPM = LocalTime.of(18, 0);

					String key = localDate.format(formatter);
					String keyLate = checkInTime.toLocalDate().format(formatter);
					boolean isLate = false;

					// ❌ มาสาย
					if (checkInTime.toLocalTime().isAfter(nineAM)) {
						log.debug("late nineAM: " + checkInTime);
						isLate = true;
					}

					// ❌ กลับก่อน
					if (checkOutTime.toLocalTime().isBefore(sixPM)) {
						log.debug("late sixPM: " + checkOutTime);
						isLate = true;
					}

					if (isLate) {
						lateDateSet.add(keyLate);
					} else if (lateDateSet.contains(keyLate)) {
						lateDateSet.remove(keyLate);
					}

					timeSheetMap.computeIfAbsent(key, k -> new ArrayList<>()).add(ts);
					workDateSet.add(key);

				}
			}

			total_OT = otDateSet.size();
			total_absent = total_work - workDateSet.size();
			total_work = total_work - total_absent;
			total_late = lateDateSet.size();

			request.setAttribute("total_absent", total_absent);
			request.setAttribute("total_OT", total_OT);
			request.setAttribute("total_work", total_work);
			request.setAttribute("total_leave", total_leave);
			request.setAttribute("total_late", total_late);

			request.setAttribute("timeSheetMap", timeSheetMap);
			request.setAttribute("dateList", dateList);

			return SUCCESS;
		} catch (Exception e) {
			// TODO: handle exception
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

			log.debug("project ID: " + projectId);
			log.debug("function ID: " + functionId);
			log.debug("project name: " + projectName);
			log.debug("function name: " + functionName);

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
				newProject.setUser_update(null);
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
			newTimesheet.setFunction_id(functionId != null ? Integer.valueOf(functionId) : null);
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
		log.debug("project ID: " + projectId);
		try {
			if (!projectId.isEmpty() && !projectId.equals("newProject")) {
				projectFunctions = projectFunctionDAO.findAllByProjectId(Integer.valueOf(projectId));
			}
			log.debug("function list: " + projectFunctions);
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
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
//		sheet.getRow(4).getCell(2).setCellValue();
		sheet.getRow(3).getCell(16).setCellValue(date);

		// ===== ตัวอย่างข้อมูล timesheet =====
		int startRow = 7;

		for (int i = 0; i < 5; i++) {

			Row row = sheet.getRow(startRow + i);

			row.getCell(0).setCellValue("01/03/2026");
			row.getCell(2).setCellValue("09:00");
			row.getCell(4).setCellValue("18:00");
			row.getCell(6).setCellValue("");
			row.getCell(8).setCellValue("");
			row.getCell(10).setCellValue("8:00");
			row.getCell(14).setCellValue("Develop Feature");
		}

		// ===== download =====
		ServletActionContext.getResponse()
				.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

		ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename=report.xlsx");

		ServletOutputStream out = ServletActionContext.getResponse().getOutputStream();
		workbook.write(out);

		out.flush();
		out.close();
		workbook.close();

		return NONE;
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
