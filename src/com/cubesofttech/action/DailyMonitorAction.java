package com.cubesofttech.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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

import com.cubesofttech.dao.JobSiteTeamDAO;
import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WorkHoursDAO;
import com.cubesofttech.model.User;
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
	private JobSiteTeamDAO jobSiteTeamDAO;

	@Autowired
	private WorkHoursDAO workHoursDAO;

	private InputStream inputStream;

	public InputStream getInputStream() {
		return inputStream;
	}

	public String dailyMonitorList() {

		try {
			User ur = (User) request.getSession().getAttribute("onlineUser");

			request.setAttribute("idUserSelected", "all");
			request.setAttribute("idJobSiteSelected", "all");
			request.setAttribute("statusSelected", "all");

			List<Map<String, Object>> userEnable = userDAO.findUserActive();

			request.setAttribute("userEnable", userEnable);

			List<Map<String, Object>> jobsites = jobsiteDAO.findAll();
			request.setAttribute("jobSiteList", jobsites);

			// ===== Date =====
			LocalDate localDate = LocalDate.now();

			Date today = java.sql.Date.valueOf(localDate);

			String selectDate = localDate.toString();

			request.setAttribute("searchDate", today);

			List<Map<String, Object>> dailyReportList = workHoursDAO.findForDailyReport("all", "all", selectDate);

			int totalOntime = 0;
			int totalLate = 0;
			int totalEarlyOut = 0;
			int totalUnfinishedWork = 0;
			int totalLeave = 0;
			int totalSickLeave = 0;
			int totalIncomplete = 0;
			int totalNoRecord = 0;

			Map<String, List<Map<String, Object>>> jobSiteMap = new HashMap<>();

			for (Map<String, Object> daily : dailyReportList) {

				String userId = (String) daily.get("userId");
				String status = (String) daily.get("status");
				String leaveType = (String) daily.get("leaveType");

				List<Map<String, Object>> jobSite = jobSiteTeamDAO.findSiteByUserId(userId);

				jobSiteMap.put(userId, jobSite);

				if ("OnTime".equals(status)) {
					totalOntime++;
				} else if ("Late".equals(status)) {
					totalLate++;
				} else if ("Early Out".equals(status)) {
					totalEarlyOut++;
				} else if ("Unfinished Work".equals(status)) {
					totalUnfinishedWork++;
				} else if ("Incomplete".equals(status)) {
					totalIncomplete++;
				} else if ("Absent/Error".equals(status)) {
					totalNoRecord++;
				}

				if ("ลาป่วย".equals(leaveType)) {
					totalSickLeave++;
					if ("Absent/Error".equals(status)) {
						totalNoRecord--;
					}

				} else if ("ลากิจ".equals(leaveType) || "ลาพักร้อน".equals(leaveType)
						|| "ลาพักร้อนที่เหลือจากปีก่อน".equals(leaveType)) {
					totalLeave++;

					if ("Absent/Error".equals(status)) {
						totalNoRecord--;
					}
				}

			}

			request.setAttribute("jobSiteMap", jobSiteMap);

			request.setAttribute("dailyWorkUser", dailyReportList);

			request.setAttribute("total_ontime", totalOntime);
			request.setAttribute("total_late", totalLate);
			request.setAttribute("total_early_out", totalEarlyOut);
			request.setAttribute("total_unfinished_work", totalUnfinishedWork);
			request.setAttribute("total_incomplete", totalIncomplete);
			request.setAttribute("total_leave", totalLeave);
			request.setAttribute("total_sick_leave", totalSickLeave);
			request.setAttribute("total_no_record", totalNoRecord);

			// ===== WorkHours =====
			List<Map<String, Object>> workHours = workHoursDAO.getWorkHourDailyUserActive("all", "all", today);
			Map<String, Map<String, List<Map<String, Object>>>> workHoursMap = new HashMap<>();

			for (Map<String, Object> work : workHours) {

				String userId = work.get("user_create").toString().toLowerCase().trim();
				String type = work.get("work_hours_type").toString();

				workHoursMap.computeIfAbsent(userId, k -> new HashMap<>()).computeIfAbsent(type, k -> new ArrayList<>())
						.add(work);

			}

			request.setAttribute("workHoursMap", workHoursMap);

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

		return SUCCESS;
	}

	public String dailyMonitorSearch() {
		try {
			User ur = (User) request.getSession().getAttribute("onlineUser");

			String searchDate = request.getParameter("searchDate");
			String jobSiteId = request.getParameter("jobSiteSelect");
			String statusSelect = request.getParameter("statusSelect");
			String userIdSelect = request.getParameter("userSelect");

			request.setAttribute("idJobSiteSelected", jobSiteId);
			request.setAttribute("statusSelected", statusSelect);

			// ===== User =====
			List<Map<String, Object>> userEnable = userDAO.findUserActive();

			request.setAttribute("userEnable", userEnable);

			request.setAttribute("idUserSelected", userIdSelect);

			// ===== Jobsite =====
			List<Map<String, Object>> jobsites = jobsiteDAO.findAll();
			request.setAttribute("jobSiteList", jobsites);

			// ===== Date =====
			LocalDate localDate = LocalDate.parse(searchDate); // yyyy-MM-dd
			Date date = java.sql.Date.valueOf(localDate);
			String selectDate = localDate.toString();

			request.setAttribute("searchDate", date);

			List<Map<String, Object>> dailyReportList = workHoursDAO.findForDailyReport(userIdSelect, jobSiteId,
					selectDate);

			if (!"all".equals(statusSelect)) {
				if ("Leave".equals(statusSelect)) {

					dailyReportList = dailyReportList.stream()
							.filter(d -> "ลากิจ".equals(d.get("leaveType")) || "ลาพักร้อน".equals(d.get("leaveType"))
									|| "ลาพักร้อนที่เหลือจากปีก่อน".equals(d.get("leaveType")))
							.collect(Collectors.toList());

				} else if ("ลาป่วย".equals(statusSelect)) {
					dailyReportList = dailyReportList.stream().filter(d -> statusSelect.equals(d.get("leaveType")))
							.collect(Collectors.toList());
				} else if ("Absent/Error".equals(statusSelect)) {
					dailyReportList = dailyReportList.stream()
							.filter(d -> statusSelect.equals(d.get("status")) && d.get("leaveType") == null)
							.collect(Collectors.toList());
				} else {
					dailyReportList = dailyReportList.stream().filter(d -> statusSelect.equals(d.get("status")))
							.collect(Collectors.toList());
				}
			}

			int totalOntime = 0;
			int totalLate = 0;
			int totalEarlyOut = 0;
			int totalUnfinishedWork = 0;
			int totalLeave = 0;
			int totalSickLeave = 0;
			int totalIncomplete = 0;
			int totalNoRecord = 0;

			Map<String, List<Map<String, Object>>> jobSiteMap = new HashMap<>();

			for (Map<String, Object> daily : dailyReportList) {

				String userId = (String) daily.get("userId");
				String status = (String) daily.get("status");
				String leaveType = (String) daily.get("leaveType");

				List<Map<String, Object>> jobSite = jobSiteTeamDAO.findSiteByUserId(userId);

				jobSiteMap.put(userId, jobSite);

				if ("OnTime".equals(status)) {
					totalOntime++;
				} else if ("Late".equals(status)) {
					totalLate++;
				} else if ("Early Out".equals(status)) {
					totalEarlyOut++;
				} else if ("Unfinished Work".equals(status)) {
					totalUnfinishedWork++;
				} else if ("Incomplete".equals(status)) {
					totalIncomplete++;
				} else if ("Absent/Error".equals(status)) {
					totalNoRecord++;
				}

				if ("ลาป่วย".equals(leaveType)) {
					totalSickLeave++;
					if ("Absent/Error".equals(status)) {
						totalNoRecord--;
					}

				} else if ("ลากิจ".equals(leaveType) || "ลาพักร้อน".equals(leaveType)
						|| "ลาพักร้อนที่เหลือจากปีก่อน".equals(leaveType)) {
					totalLeave++;

					if ("Absent/Error".equals(status)) {
						totalNoRecord--;
					}
				}

			}
			request.setAttribute("jobSiteMap", jobSiteMap);
			request.setAttribute("dailyWorkUser", dailyReportList);

			// ===== WorkHours =====
			List<Map<String, Object>> workHours = workHoursDAO.getWorkHourDailyUserActive(userIdSelect, jobSiteId,
					date);
			Map<String, Map<String, List<Map<String, Object>>>> workHoursMap = new HashMap<>();

			for (Map<String, Object> work : workHours) {

				String userId = work.get("user_create").toString().toLowerCase().trim();
				String type = work.get("work_hours_type").toString();

				workHoursMap.computeIfAbsent(userId, k -> new HashMap<>()).computeIfAbsent(type, k -> new ArrayList<>())
						.add(work);
			}

			request.setAttribute("total_ontime", totalOntime);
			request.setAttribute("total_late", totalLate);
			request.setAttribute("total_early_out", totalEarlyOut);
			request.setAttribute("total_unfinished_work", totalUnfinishedWork);
			request.setAttribute("total_incomplete", totalIncomplete);
			request.setAttribute("total_leave", totalLeave);
			request.setAttribute("total_sick_leave", totalSickLeave);
			request.setAttribute("total_no_record", totalNoRecord);

			request.setAttribute("workHoursMap", workHoursMap);

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}

		return SUCCESS;
	}

	public String exportExcelDailyMonitor() {
		try {

			String searchDate = request.getParameter("searchDate");
			String jobSiteId = request.getParameter("jobSiteSelect");
			String statusSelect = request.getParameter("statusSelect");
			String userIdSelect = request.getParameter("userSelect");

			LocalDate localDate = LocalDate.parse(searchDate);
			String selectDate = localDate.toString();

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
			String formattedDate = localDate.format(formatter);

			List<Map<String, Object>> dailyReportList = workHoursDAO.findForDailyReport(userIdSelect, jobSiteId,
					selectDate);

			if (!"all".equals(statusSelect)) {
				if ("Leave".equals(statusSelect)) {
					dailyReportList = dailyReportList.stream()
							.filter(d -> "ลากิจ".equals(d.get("leaveType")) || "ลาพักร้อน".equals(d.get("leaveType"))
									|| "ลาพักร้อนที่เหลือจากปีก่อน".equals(d.get("leaveType")))
							.collect(Collectors.toList());

				} else if ("ลาป่วย".equals(statusSelect)) {
					dailyReportList = dailyReportList.stream().filter(d -> statusSelect.equals(d.get("leaveType")))
							.collect(Collectors.toList());
				} else if ("Absent/Error".equals(statusSelect)) {
					dailyReportList = dailyReportList.stream()
							.filter(d -> statusSelect.equals(d.get("status")) && d.get("leaveType") == null)
							.collect(Collectors.toList());
				} else {
					dailyReportList = dailyReportList.stream().filter(d -> statusSelect.equals(d.get("status")))
							.collect(Collectors.toList());
				}
			}

			Workbook workbook = new XSSFWorkbook();
			Sheet sheet = workbook.createSheet("Daily Report");

			String[] headers = { "Date", "EmpID", "Name TH", "Name EN", "Job Site", "Position", "Start Time",
					"End Time", "Check In", "Check Out", "Working (HRS)", "Status" };

			Row headerRow = sheet.createRow(0);
			for (int i = 0; i < headers.length; i++) {
				headerRow.createCell(i).setCellValue(headers[i]);
			}

			int rowNum = 1;
			for (Map<String, Object> daily : dailyReportList) {
				Row row = sheet.createRow(rowNum++);

				String status = daily.get("leaveType") != null ? daily.get("leaveType").toString()
						: (daily.get("status") != null ? daily.get("status").toString() : "-");

				String halfDay = daily.get("halfDay") != null ? daily.get("halfDay").toString() : "";

				if ("ลาป่วย".equals(status)) {
					if ("1".equals(halfDay)) {
						status = "ลาป่วยครึ่งวันเช้า";
					} else if ("2".equals(halfDay)) {
						status = "ลาป่วยครึ่งวันบ่าย";
					}

				} else if ("ลากิจ".equals(status)) {
					if ("1".equals(halfDay)) {
						status = "ลากิจครึ่งวันเช้า";
					} else if ("2".equals(halfDay)) {
						status = "ลากิจครึ่งวันบ่าย";
					}
				}
				row.createCell(0).setCellValue(formattedDate);
				row.createCell(1).setCellValue(daily.get("empId") == null ? "-" : daily.get("empId").toString());
				row.createCell(2).setCellValue(daily.get("name") == null ? "-" : daily.get("name").toString());
				row.createCell(3).setCellValue(daily.get("nameEn") == null ? "-" : daily.get("nameEn").toString());
				row.createCell(4).setCellValue(daily.get("site") == null ? "-" : daily.get("site").toString());
				row.createCell(5).setCellValue(daily.get("position") == null ? "-" : daily.get("position").toString());
				row.createCell(6)
						.setCellValue(daily.get("startTime") == null ? "-" : daily.get("startTime").toString());
				row.createCell(7).setCellValue(daily.get("endTime") == null ? "-" : daily.get("endTime").toString());
				row.createCell(8).setCellValue(daily.get("timeIn") == null ? "-" : daily.get("timeIn").toString());
				row.createCell(9).setCellValue(daily.get("timeOut") == null ? "-" : daily.get("timeOut").toString());
				row.createCell(10)
						.setCellValue(daily.get("workingHours") == null ? "-" : daily.get("workingHours").toString());
				row.createCell(11).setCellValue(status);
			}

			for (int i = 0; i < headers.length; i++) {
				sheet.autoSizeColumn(i);
			}

			// ===== convert to InputStream =====
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			workbook.write(out);
			workbook.close();

			inputStream = new ByteArrayInputStream(out.toByteArray());

			return SUCCESS;

		} catch (

		Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return ERROR;
		}
	}

}
