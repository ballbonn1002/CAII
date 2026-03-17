package com.cubesofttech.action;

import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.JobSiteTeamDAO;
import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.LeaveDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WorkHoursDAO;
import com.cubesofttech.model.User;
import com.cubesofttech.service.WorkHoursService;
import com.opensymphony.xwork2.ActionSupport;

public class DailyMonitorAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	HttpSession session = ServletActionContext.getRequest().getSession(false);
	Logger log = Logger.getLogger(getClass());

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private JobsiteDAO jobsiteDAO;

	@Autowired
	private WorkHoursDAO workHoursDAO;

	@Autowired
	private WorkHoursService workHoursService;

	@Autowired
	private JobSiteTeamDAO jobSiteTeamDAO;

	@Autowired
	private LeaveDAO leaveDAO;

	public String dailyMonitorList() {

		try {

			// ===== User =====
			List<User> userList = userDAO.findAll();

			List<User> userEnable = userList.stream().filter(user -> "1".equals(user.getEnable()))
					.sorted(Comparator.comparing(User::getEmployeeId)).collect(Collectors.toList());

			request.setAttribute("userEnable", userEnable);
			request.setAttribute("userList", userEnable);

			// ===== Jobsite =====
			List<Map<String, Object>> jobsites = jobsiteDAO.findAll();
			Map<String, Object> jobSiteMap = new HashMap<>();

			request.setAttribute("jobSiteList", jobsites);

			for (User user : userEnable) {

				List<Map<String, Object>> jobSiteList = jobSiteTeamDAO.findSiteByUserId(user.getId());

				if (!jobSiteList.isEmpty()) {
					jobSiteMap.put(user.getId(), jobSiteList.get(0));
				}

			}

			// ===== Date =====
			LocalDate localDate = LocalDate.now();
			Date today = java.sql.Date.valueOf(localDate);
			Timestamp startDate = Timestamp.valueOf(localDate.atStartOfDay());
			Timestamp endDate = Timestamp.valueOf(localDate.atTime(23, 59, 59));

			request.setAttribute("searchDate", today);

			// ===== WorkHours =====
			List<Map<String, Object>> workHours = workHoursDAO.getWorkHourDaily("all", today);
			Map<String, Map<String, Map<String, Object>>> workHoursMap = new HashMap<>();
			Map<String, Map<String, Object>> statusCache = new HashMap<>();
			Map<String, Map<String, Object>> dailyStatusMap = new HashMap<>();

			for (Map<String, Object> work : workHours) {

				String userId = work.get("user_create").toString();
				String type = work.get("work_hours_type").toString();

				workHoursMap.computeIfAbsent(userId, k -> new HashMap<>()).put(type, work);
			}

			int totalOntime = 0;
			int totalLate = 0;
			int totalEarlyOut = 0;
			int totalUnfinishedWork = 0;
			int totalLeave = 0;
			int totalSickLeave = 0;
			int totalIncomplete = 0;
			int totalNoRecord = 0;

			Map<String, Integer> leaveMap = new HashMap<>();

			for (User user : userEnable) {

				String userId = user.getId();

				Map<String, Object> status = statusCache.computeIfAbsent(userId, id -> {
					try {
						return workHoursService.calculateDailyStatus(id, localDate);
					} catch (Exception e) {
						e.printStackTrace();
						return new HashMap<>();
					}
				});

				log.debug(status);

				String statusType = (String) status.get("status");
				String leaveStatusType = (String) status.get("leave_status");

				if ("ONTIME".equals(statusType)) {
					totalOntime++;
				} else if ("LATE".equals(statusType)) {
					totalLate++;
				} else if ("EARLY_OUT".equals(statusType)) {
					totalEarlyOut++;
				} else if ("UNFINISHED_WORK".equals(statusType)) {
					totalUnfinishedWork++;
				} else if ("INCOMPLETE".equals(statusType)) {
					totalIncomplete++;
				} else if ("NO_RECORD".equals(statusType)) {
					totalNoRecord++;
				}

				if ("SICK_LEAVE".equals(leaveStatusType)) {
					totalSickLeave++;
					List<Map<String, Object>> leaveList = leaveDAO.myLeavesList(userId, startDate, endDate);
					if (!leaveList.isEmpty()) {
						Integer leaveId = Integer.parseInt(leaveList.get(0).get("leave_id").toString());
						leaveMap.put(userId, leaveId);
					}
				} else if ("BUSINESS_LEAVE".equals(leaveStatusType)) {
					totalLeave++;
					List<Map<String, Object>> leaveList = leaveDAO.myLeavesList(userId, startDate, endDate);
					if (!leaveList.isEmpty()) {
						Integer leaveId = Integer.parseInt(leaveList.get(0).get("leave_id").toString());
						leaveMap.put(userId, leaveId);
					}
				}

				dailyStatusMap.put(userId, status);
			}
			request.setAttribute("leaveMap", leaveMap);

			request.setAttribute("total_ontime", totalOntime);
			request.setAttribute("total_late", totalLate);
			request.setAttribute("total_early_out", totalEarlyOut);
			request.setAttribute("total_unfinished_work", totalUnfinishedWork);
			request.setAttribute("total_incomplete", totalIncomplete);
			request.setAttribute("total_leave", totalLeave);
			request.setAttribute("total_sick_leave", totalSickLeave);
			request.setAttribute("total_no_record", totalNoRecord);

			// ===== Calculate working hour =====
			for (Map.Entry<String, Map<String, Object>> entry : dailyStatusMap.entrySet()) {

				Map<String, Object> status = entry.getValue();

				String checkInStr = (String) status.get("check_in");
				String checkOutStr = (String) status.get("check_out");

				if (checkInStr != null && checkOutStr != null) {

					LocalTime checkIn = LocalTime.parse(checkInStr);
					LocalTime checkOut = LocalTime.parse(checkOutStr);

					long minutes = Duration.between(checkIn, checkOut).toMinutes();

					long h = minutes / 60;
					long m = minutes % 60;

					status.put("workinghours_format", String.format("%02d:%02d", h, m));
				}
			}

			request.setAttribute("jobSiteMap", jobSiteMap);
			request.setAttribute("dailyStatusMap", dailyStatusMap);
			request.setAttribute("workHoursMap", workHoursMap);

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

		return SUCCESS;
	}

	public String dailyMonitorSearch() {
		try {

			String searchDate = request.getParameter("searchDate");
			String jobSiteId = request.getParameter("jobSiteSelect");
			String statusSelect = request.getParameter("statusSelect");
			String userIdSelect = request.getParameter("userSelect");

			request.setAttribute("idJobSiteSelected", jobSiteId);
			request.setAttribute("statusSelected", statusSelect);

			// ===== User =====
			List<User> userList = userDAO.findAll();

			List<User> userEnable = userList.stream().filter(user -> "1".equals(user.getEnable()))
					.sorted(Comparator.comparing(User::getEmployeeId)).collect(Collectors.toList());

			request.setAttribute("userEnable", userEnable);

			request.setAttribute("idUserSelected", userIdSelect);

			// ===== Jobsite =====
			List<Map<String, Object>> jobsites = jobsiteDAO.findAll();
			request.setAttribute("jobSiteList", jobsites);

			Map<String, Object> jobSiteMap = new HashMap<>();
			List<User> filteredUsers = new ArrayList<>();

			request.setAttribute("jobSiteList", jobsites);

			if ("all".equals(jobSiteId)) {
				filteredUsers = userEnable;
			} else {

				for (User user : userEnable) {

					List<Map<String, Object>> jobSiteList = jobSiteTeamDAO.findSiteByUserId(user.getId());

					if (!jobSiteList.isEmpty()) {

						Map<String, Object> site = jobSiteList.get(0);

						if (site.get("id_sitejob").toString().equals(jobSiteId)) {
							filteredUsers.add(user);
						}

						jobSiteMap.put(user.getId(), site);
					}
				}
			}

			List<User> finalUsers;

			if ("all".equals(userIdSelect)) {
				finalUsers = filteredUsers;
			} else {
				finalUsers = filteredUsers.stream().filter(u -> u.getId().equals(userIdSelect))
						.collect(Collectors.toList());
			}

			// ===== Date =====
			LocalDate localDate = LocalDate.parse(searchDate); // yyyy-MM-dd
			Date date = java.sql.Date.valueOf(localDate);
			Timestamp startDate = Timestamp.valueOf(localDate.atStartOfDay());
			Timestamp endDate = Timestamp.valueOf(localDate.atTime(23, 59, 59));

			request.setAttribute("searchDate", date);

			// ===== WorkHours =====
			List<Map<String, Object>> workHours = workHoursDAO.getWorkHourDaily(userIdSelect, date);
			Map<String, Map<String, Map<String, Object>>> workHoursMap = new HashMap<>();
			Map<String, Map<String, Object>> statusCache = new HashMap<>();
			Map<String, Map<String, Object>> dailyStatusMap = new HashMap<>();

			for (Map<String, Object> work : workHours) {

				String userId = work.get("user_create").toString();
				String type = work.get("work_hours_type").toString();

				workHoursMap.computeIfAbsent(userId, k -> new HashMap<>()).put(type, work);
			}

			int totalOntime = 0;
			int totalLate = 0;
			int totalEarlyOut = 0;
			int totalUnfinishedWork = 0;
			int totalLeave = 0;
			int totalSickLeave = 0;
			int totalIncomplete = 0;
			int totalNoRecord = 0;

			// ===== loop user =====
			List<User> resultUsers = new ArrayList<>();
			Map<String, Integer> leaveMap = new HashMap<>();

			for (User user : finalUsers) {

				String userId = user.getId();

				Map<String, Object> status = statusCache.computeIfAbsent(userId, id -> {
					try {
						return workHoursService.calculateDailyStatus(id, localDate);
					} catch (Exception e) {
						e.printStackTrace();
						return new HashMap<>();
					}
				});

				String statusType = (String) status.get("status");
				String leaveStatusType = (String) status.get("leave_status");


				// ===== filter status =====
				if (!"all".equals(statusSelect)) {
					if ("LEAVE".equals(statusSelect)) {

						// กรองเฉพาะคนที่เป็น leave ทุกประเภท
						if (!"BUSINESS_LEAVE".equals(leaveStatusType) && !"ANNUAL_LEAVE".equals(leaveStatusType)
								&& !"ANNUAL_LEAVE_REMAINING".equals(leaveStatusType)) {
							continue;
						}

					} else if (!statusSelect.equals(statusType) && !statusSelect.equals(leaveStatusType)) {
						continue;
					}
				}

				if ("ONTIME".equals(statusType)) {
					totalOntime++;
				} else if ("LATE".equals(statusType)) {
					totalLate++;
				} else if ("EARLY_OUT".equals(statusType)) {
					totalEarlyOut++;
				} else if ("UNFINISHED_WORK".equals(statusType)) {
					totalUnfinishedWork++;
				} else if ("INCOMPLETE".equals(statusType)) {
					totalIncomplete++;
				} else if ("NO_RECORD".equals(statusType)) {
					totalNoRecord++;
				}

				if ("SICK_LEAVE".equals(leaveStatusType)) {
					totalSickLeave++;
					List<Map<String, Object>> leaveList = leaveDAO.myLeavesList(userId, startDate, endDate);
					if (!leaveList.isEmpty()) {
						Integer leaveId = Integer.parseInt(leaveList.get(0).get("leave_id").toString());
						leaveMap.put(userId, leaveId);
					}

				} else if ("BUSINESS_LEAVE".equals(leaveStatusType) || "ANNUAL_LEAVE".equals(leaveStatusType)
						|| "ANNUAL_LEAVE_REMAINING".equals(leaveStatusType)) {
					totalLeave++;
					List<Map<String, Object>> leaveList = leaveDAO.myLeavesList(userId, startDate, endDate);
					if (!leaveList.isEmpty()) {
						Integer leaveId = Integer.parseInt(leaveList.get(0).get("leave_id").toString());
						leaveMap.put(userId, leaveId);
					}
				}

				dailyStatusMap.put(userId, status);
				resultUsers.add(user);
			}

			request.setAttribute("leaveMap", leaveMap);

			request.setAttribute("total_ontime", totalOntime);
			request.setAttribute("total_late", totalLate);
			request.setAttribute("total_early_out", totalEarlyOut);
			request.setAttribute("total_unfinished_work", totalUnfinishedWork);
			request.setAttribute("total_incomplete", totalIncomplete);
			request.setAttribute("total_leave", totalLeave);
			request.setAttribute("total_sick_leave", totalSickLeave);
			request.setAttribute("total_no_record", totalNoRecord);

			// ===== Calculate working hour =====
			for (Map.Entry<String, Map<String, Object>> entry : dailyStatusMap.entrySet()) {

				Map<String, Object> status = entry.getValue();

				String checkInStr = (String) status.get("check_in");
				String checkOutStr = (String) status.get("check_out");

				if (checkInStr != null && checkOutStr != null) {

					LocalTime checkIn = LocalTime.parse(checkInStr);
					LocalTime checkOut = LocalTime.parse(checkOutStr);

					long minutes = Duration.between(checkIn, checkOut).toMinutes();

					long h = minutes / 60;
					long m = minutes % 60;

					status.put("workinghours_format", String.format("%02d:%02d", h, m));
				}
			}

			request.setAttribute("userList", resultUsers);

			request.setAttribute("jobSiteMap", jobSiteMap);
			request.setAttribute("dailyStatusMap", dailyStatusMap);
			request.setAttribute("workHoursMap", workHoursMap);

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

		return SUCCESS;
	}

}
