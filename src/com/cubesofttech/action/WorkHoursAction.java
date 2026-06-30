package com.cubesofttech.action;

import java.io.File;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.HolidayDAO;
import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.LeaveDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WorkHoursDAO;
import com.cubesofttech.model.Holiday;
import com.cubesofttech.dao.JobSiteTeamDAO;
import com.cubesofttech.model.Announcement;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.dao.AnnouncementDAO;
import com.cubesofttech.dao.BorrowDAO;
import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.model.User;
import com.cubesofttech.model.WorkHours;
import com.cubesofttech.service.LogService;
import com.cubesofttech.service.WorkHoursService;
import com.cubesofttech.util.DateUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.opensymphony.xwork2.ActionSupport;

public class WorkHoursAction extends ActionSupport {
	// com.sun.media.jfxmedia.logging.Logger log = Logger.getLogger(getClass());
	Logger log = Logger.getLogger(getClass());
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	private static final ZoneId ZONE = ZoneId.of("Asia/Bangkok");
	private static final DateTimeFormatter ISO = DateTimeFormatter.ISO_OFFSET_DATE_TIME;

	@Autowired
	private WorkHoursService workHoursService;
	@Autowired
	private WorkHoursDAO workHoursDAO;
	@Autowired
	private HolidayDAO holidayDAO;
	@Autowired
	private UserDAO userDAO;
	@Autowired
	private LeaveDAO leaveDAO;
	@Autowired
	private JobsiteDAO jobsiteDAO;
	@Autowired
	private JobSiteTeamDAO jobSiteTeamDAO;
	@Autowired
	private AnnouncementDAO announcementDAO;
	@Autowired
	private LogService logService;
	@Autowired
	private FileUploadDAO fileuploadDAO;
	@Autowired
	private BorrowDAO borrowDAO;

	private Map<String, String> getHeadersInfo(HttpServletRequest request) {
		String ipAddress = request.getHeader("x-forwarded-for");
		if (ipAddress == null) {
			ipAddress = request.getHeader("X_FORWARDED_FOR");
			if (ipAddress == null) {
				ipAddress = request.getRemoteAddr();
			}
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("ipAddress", ipAddress);

		Enumeration<String> headerNames = request.getHeaderNames();
		while (headerNames.hasMoreElements()) {
			String key = (String) headerNames.nextElement();
			String value = request.getHeader(key);
			map.put(key, value);
		}
		return map;
	}

	public String init() {
		try {
			User ur = (User) request.getSession().getAttribute("onlineUser");
			String logonUser = ur.getId();
			request.setAttribute("logonUser", logonUser);
			log.info("logonUser : " + logonUser);
			LocalDate currentDate = LocalDate.now();
			request.setAttribute("currentDate", currentDate);

			List<Holiday> holidayList = null;
			holidayList = holidayDAO.findAllInMonth();
			request.setAttribute("holidayList", holidayList);
			
			LocalDate lastWorkDate = currentDate.minusDays(1);
			while (true) {
			    boolean isHoliday = false;
			    if (holidayList != null) {
			    	for (Object obj : holidayList) {
			    	    Map row = (Map) obj;
			    	    LocalDate start = ((java.sql.Date) row.get("start_date")).toLocalDate();
			    	    LocalDate end = ((java.sql.Date) row.get("end_date")).toLocalDate();

			            if ((lastWorkDate.isEqual(start) || lastWorkDate.isAfter(start)) &&
			                (lastWorkDate.isEqual(end) || lastWorkDate.isBefore(end)) ) 
			            {
			                isHoliday = true;
			                break;
			            }
			        }
			    }

			    if (lastWorkDate.getDayOfWeek() != DayOfWeek.SATURDAY 
			    	&& lastWorkDate.getDayOfWeek() != DayOfWeek.SUNDAY && !isHoliday) {
			        break;
			    }
			    lastWorkDate = lastWorkDate.minusDays(1);
			}

			String lastWorkDayName = lastWorkDate.getDayOfWeek().getDisplayName(java.time.format.TextStyle.SHORT, java.util.Locale.ENGLISH);
			request.setAttribute("lastWorkDayName", lastWorkDayName);
			
			List<Map<String, Object>> leaveToday = leaveDAO.findLeaveByUserAndDate(logonUser, currentDate.toString());
			request.setAttribute("leaveToday", leaveToday);
			List<Map<String, Object>> leaveLastday = leaveDAO.findLeaveByUserAndDate(logonUser, lastWorkDate.toString());
			request.setAttribute("leaveLastday", leaveLastday);
			
			List<Map<String, Object>> getTodayCheckIn = workHoursDAO.getTodayCheckIn(logonUser);
			List<Map<String, Object>> getTodayCheckOut = workHoursDAO.getTodayCheckOut(logonUser);
			List<Map<String, Object>> getLastdayCheckIn = workHoursDAO.getLastdayCheckIn(logonUser, lastWorkDate);
			List<Map<String, Object>> getLastdayCheckOut = workHoursDAO.getLastdayCheckOut(logonUser, lastWorkDate);

			request.setAttribute("todaycheckin", getTodayCheckIn);
			request.setAttribute("todaycheckout", getTodayCheckOut);
			request.setAttribute("lastcheckin", getLastdayCheckIn);
			request.setAttribute("lastcheckout", getLastdayCheckOut);
			
			try {
				List<Announcement> announcementList = announcementDAO.findAll();
				request.setAttribute("announcementList", announcementList);
				Integer maxId = announcementDAO.getMaxId();
				request.setAttribute("islastest", maxId);
				List<Map<String, Object>> userSites = jobSiteTeamDAO.findSiteByUserId(logonUser);

				if (userSites != null && !userSites.isEmpty()) {
					Map<String, Object> myJobsite = userSites.get(0);

					request.setAttribute("jobsite", myJobsite);
					request.setAttribute("jobsiteList", userSites);
					log.info("Found jobsite: " + myJobsite);
				} else {
					log.warn("User " + logonUser + " has no site in JobSiteTeam");
					request.setAttribute("jobsite", null);
					request.setAttribute("jobsiteList", null);
				}
			} catch (Exception e) {
				log.error("Error finding jobsite for user: " + logonUser, e);
				request.setAttribute("jobsite", null);
			}

			request.setAttribute("allowedDate", workHoursService.calculateAllowedWorkDateIso(currentDate));

			loadNotification(logonUser, ur);
			
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String savecheck() {
		User ur = (User) request.getSession().getAttribute("onlineUser");
		
		Map<String, Object> result = new HashMap<>();
		try {
			String userId = request.getParameter("userId");
			String checkDate = request.getParameter("date");
			String checkTime = request.getParameter("time");
			String checkType = request.getParameter("checkType");
			String workType = request.getParameter("workType");
			String checkMode = request.getParameter("mode");
			log.debug(checkType + "/" + workType+"/"+checkDate+ "/"+userId);

			if ("2".equals(checkType)) {
				LocalDate targetDate = LocalDate.now(ZoneId.of("Asia/Bangkok"));
				if ("retro".equals(checkMode) && checkDate != null && !checkDate.isEmpty()) {
					try {
						targetDate = LocalDate.parse(checkDate);
					} catch (Exception e) {
						try {
							String uriLog = request.getRequestURI();
				    		String methodLog = request.getMethod();
				    		String statusLog = "ERROR";
				    		String descLog = e.getClass().getName() + ": " + e.getMessage();
				    		String dateLog = LocalDateTime.now().toLocalDate().toString() + '%';
				    		
				    		logService.updateRequestLog(uriLog, methodLog, statusLog, descLog, dateLog, ur.getId());
						} catch (Exception logEx) {
							log.debug("Log can't write to DB: " + logEx.getMessage());
						}
						log.error("Invalid date format", e);
					}
				} else {	// normal
					checkDate = targetDate.toString();
				}
				List<Map<String, Object>> targetDateCheckIn = workHoursDAO.getCheckinByDate(userId, checkDate);
				boolean isCheckedIn = false;
				if (targetDateCheckIn != null && !targetDateCheckIn.isEmpty()) {
				    isCheckedIn = true;
				    log.debug("Found Check-in for date: " + targetDate);
				}

				if (!isCheckedIn) {
					result.put("status", "error");
					if ("retro".equals(checkMode)) {
						result.put("message", "ไม่สามารถ Check-out ย้อนหลังได้ เนื่องจากไม่พบเวลา Check-in ของวันที่ " + targetDate);
					} else {
						result.put("message", "ไม่สามารถ Check-out ได้ เนื่องจากคุณยังไม่ได้ Check-in วันนี้");
					}

					try {
						ObjectMapper mapper = new ObjectMapper();
						response.setContentType("application/json;charset=UTF-8");
						response.getWriter().write(mapper.writeValueAsString(result));
						response.getWriter().flush();
						response.getWriter().close();
					} catch (Exception e) {
						try {
							String uriLog = request.getRequestURI();
				    		String methodLog = request.getMethod();
				    		String statusLog = "ERROR";
				    		String descLog = e.getClass().getName() + ": " + e.getMessage();
				    		String dateLog = LocalDateTime.now().toLocalDate().toString() + '%';
				    		
				    		logService.updateRequestLog(uriLog, methodLog, statusLog, descLog, dateLog, ur.getId());
						} catch (Exception logEx) {
							log.debug("Log can't write to DB: " + logEx.getMessage());
						}
						e.printStackTrace();
					}
					return null;
				}
			}

			String desRaw = null;
			String des = null;
			desRaw = request.getParameter("reason");
			des = (desRaw != null || desRaw != "") ? desRaw.trim() : "";
			log.debug(desRaw);
			

			String lat = request.getParameter("latitude");
			String lng = request.getParameter("longitude");
			
			//set latitude/longitude ลง session
			HttpSession session = request.getSession();

			if (lat == null || "".equals(lat.trim())) {
			    lat = (String) session.getAttribute("latitude");
			} else {
			    session.setAttribute("latitude", lat);
			}

			if (lng == null || "".equals(lng.trim())) {
			    lng = (String) session.getAttribute("longitude");
			} else {
			    session.setAttribute("longitude", lng);
			}

			Map<String, String> headersInfo = getHeadersInfo(request);
			String userAgent = (String) headersInfo.get("user-agent");
			String ipAddress = (String) headersInfo.get("ipAddress");

			LocalDateTime now = LocalDateTime.now(ZoneId.of("Asia/Bangkok"));
			DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("HH:mm:ss");

			Timestamp ts = null;
			String timeString = null;
			int date;
			int month;
			int year;
			if ("retro".equals(checkMode) && checkDate != null && checkTime != null) {
				ts = Timestamp.valueOf(checkDate + " " + checkTime + ":00");
				LocalDateTime ldt = ts.toLocalDateTime();
				date = ldt.getDayOfMonth();
				month = ldt.getMonthValue();
				year = ldt.getYear();
				log.debug(ldt.getDayOfMonth() + "|" + ldt.getMonthValue() + "|" + ldt.getYear());
				log.debug(ts.getTime());
				timeString = ldt.format(timeFormat);
				if (ldt.isAfter(now)) {
					result.put("status", "error");
					result.put("message", "Can't check-in/out time in future. Please try again.");
				} else {
					result.put("status", "success");
					result.put("type", checkType);
					result.put("time", checkTime);
				}
			} else {

				LocalDateTime officialLdt = now;

				if ("2".equals(checkType)) {
					LocalDateTime cutOffTime = now.withHour(18).withMinute(30).withSecond(0).withNano(0);

					if (now.isAfter(cutOffTime)) {
						officialLdt = cutOffTime;
						log.info("Cut-off applied | User: " + userId + " | Real: " + now + " -> Official: "
								+ officialLdt);
					}
				}

				ts = Timestamp.valueOf(officialLdt);
				timeString = officialLdt.format(timeFormat);
				date = now.getDayOfMonth();
				month = now.getMonthValue();
				year = now.getYear();
			}
			
			if ("retro".equals(checkMode)) {
				des = desRaw != null ? desRaw.trim() : "";
	
				log.debug(des);
				des = des.replaceAll("[:;']", "")
				        .replaceAll("[\\n\\r\\t]", "")
				        .replaceAll("[<>\"&]", "")
				        .trim();
				des = des.replaceAll("[\\p{So}\\p{Cn}]", "");
				
				if (des.isEmpty()) {
				    result.put("status", "error");
				    result.put("message", "Please provide a reason.");
				    
				    ObjectMapper mapper = new ObjectMapper();
				    response.setContentType("application/json;charset=UTF-8");
				    response.getWriter().write(mapper.writeValueAsString(result));
				    response.getWriter().flush();
				    response.getWriter().close();
				    return null;
				}
	
				if (des.length() < 10) {
				    result.put("status", "error");
				    result.put("message", "Reason must be at least 10 characters long.");
	
				    ObjectMapper mapper = new ObjectMapper();
				    response.setContentType("application/json;charset=UTF-8");
				    response.getWriter().write(mapper.writeValueAsString(result));
				    response.getWriter().flush();
				    response.getWriter().close();
				    return null;
				}
			}
			log.debug(timeString);
			int workinghour = workHoursService.calculateWorkingHours(userId, checkType, date, month, year, timeString);

			WorkHours wh = new WorkHours();
			wh.setWorkHoursId(workHoursDAO.getMaxId() + 1);
			wh.setWorkHoursType(checkType);
			wh.setWorkHoursTimeWork(ts);
			wh.setWorkType(workType);
			wh.setLatitude(lat);
			wh.setLongitude(lng);
			wh.setDescription(des);
			wh.setUserAgent("CA-II | " + userAgent);
			wh.setIpAddress(ipAddress);
			
			if ("retro".equals(checkMode)) {
				wh.setTimeCreate(Timestamp.valueOf(now));
				wh.setTimeUpdate(Timestamp.valueOf(now));
			} else {
				wh.setTimeCreate(Timestamp.valueOf(now));
				wh.setTimeUpdate(Timestamp.valueOf(now));
			}
			
			wh.setUserCreate(userId);
			wh.setUserUpdate(userId);
			wh.setWorkinghours(workinghour);
			workHoursDAO.save(wh);

			DateTimeFormatter fmt = DateTimeFormatter.ofPattern("HH:mm");
			result.put("status", "success");
			result.put("type", checkType);
			if ("retro".equals(checkMode)) {
				result.put("time", checkTime);
			} else {
				result.put("time", timeString.substring(0, 5));
			}
		} catch (Exception e) {
			try {
				String uriLog = request.getRequestURI();
	    		String methodLog = request.getMethod();
	    		String statusLog = "ERROR";
	    		String descLog = e.getClass().getName() + ": " + e.getMessage();
	    		String dateLog = LocalDateTime.now().toLocalDate().toString() + '%';
	    		
	    		logService.updateRequestLog(uriLog, methodLog, statusLog, descLog, dateLog, ur.getId());
			} catch (Exception logEx) {
				log.debug("Log can't write to DB: " + logEx.getMessage());
			}
			e.printStackTrace();
			result.put("status", "error");
			result.put("message", "Failed to record your check-in/out time. Please try again.");
		}
		log.debug(result);
		try {
			ObjectMapper mapper = new ObjectMapper();
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(mapper.writeValueAsString(result));
			response.getWriter().flush();
			response.getWriter().close();
		} catch (Exception e) {
			try {
				String uriLog = request.getRequestURI();
	    		String methodLog = request.getMethod();
	    		String statusLog = "ERROR";
	    		String descLog = e.getClass().getName() + ": " + e.getMessage();
	    		String dateLog = LocalDateTime.now().toLocalDate().toString() + '%';
	    		
	    		logService.updateRequestLog(uriLog, methodLog, statusLog, descLog, dateLog, ur.getId());
			} catch (Exception logEx) {
				log.debug("Log can't write to DB: " + logEx.getMessage());
			}
			e.printStackTrace();
		}
		
		try {
			String uriLog = request.getRequestURI();
			String methodLog = request.getMethod();
			String statusLog = "SUCCESS";
			String descLog = null;
			String dateLog = LocalDateTime.now().toLocalDate().toString() + '%';
			
			logService.updateRequestLog(uriLog, methodLog, statusLog, descLog, dateLog, ur.getId());
		} catch (Exception logEx) {
			log.debug("Log can't write to DB: " + logEx.getMessage());
		}
		
		return null;
	}

	public String CheckAllCalendar() {

		String userCalendar = request.getParameter("usercalendar");
		if (userCalendar != null && !userCalendar.isEmpty()) {
			request.getSession().setAttribute("usercalendar", userCalendar);
		} else {
			userCalendar = (String) request.getSession().getAttribute("usercalendar");
		}

		User onlineUser = (User) request.getSession().getAttribute("onlineUser");
		String userId = (userCalendar != null && !userCalendar.isEmpty()) ? userCalendar : onlineUser.getId();

		request.setAttribute("logonUser", userId); // ส่งไป JSP

		try {
			// Get current user and date info
			LocalDate today = LocalDate.now();
			int currentYear = today.getYear();
			int currentMonth = today.getMonthValue();
			int last2year = currentYear - 1;

			// Holiday Calendar
			List<Holiday> allholiday = holidayDAO.findAllHoliday();
			request.setAttribute("allholiday", allholiday);

			// Leave Calendar
			LocalDate startOfYear = LocalDate.of(last2year, Month.JANUARY, 1);
			LocalDate endOfYear = LocalDate.of(currentYear, Month.DECEMBER, 31);

			DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
			Timestamp start_date_leave = DateUtil.dateToTimestamp(startOfYear.format(dateFormatter), "00:00:00.0");
			Timestamp end_date_leave = DateUtil.dateToTimestamp(endOfYear.format(dateFormatter), "23:59:59.0");

			List<Map<String, Object>> leavelist = leaveDAO.myLeavesList(userId, start_date_leave, end_date_leave);
			request.setAttribute("leave", leavelist);
			// log.debug("leave: " + leavelist);

			// Check in - Check out Calendar
			User userWorkTime = userDAO.findById(userId);
			String workStartTime = userWorkTime.getWorkTimeStart();
			String workEndTime = userWorkTime.getWorkTimeEnd();

			// Get check-in / check-out data
			Map<LocalDate, Map<String, Object>> checkinMap = workHoursDAO.getCheckinsForYear(userId, last2year,
					currentYear);
			// log.debug("checkinMap: " + checkinMap);
			Map<LocalDate, Map<String, Object>> checkoutMap = workHoursDAO.getCheckoutsForYear(userId, last2year,
					currentYear);
			// log.debug("checkoutMap: " + checkoutMap);

			List<Map<String, Object>> workData = new ArrayList<>();

			LocalDate startDate = LocalDate.of(last2year, 1, 1);
			LocalDate endDate = LocalDate.of(currentYear, 12, 31);

			for (LocalDate date = startDate; !date.isAfter(endDate); date = date.plusDays(1)) {
				Map<String, Object> dayData = new HashMap<>();
				dayData.put("DATE(work_hours_time_work)", date.toString());

				// Check-in
				Map<String, Object> checkinData = checkinMap.get(date);
				if (checkinData != null) {
					Timestamp checkinTs = (Timestamp) checkinData.get("checkinTs");
					Object descriptionIn = checkinData.get("descriptionIn");
					Object workTypeIn = checkinData.get("workTypeIn");

					if (checkinTs != null) {
						dayData.put("mycheckin", checkinTs.toLocalDateTime().toString());
						dayData.put("mycheckins", checkinTs);
					} else {
						dayData.put("mycheckin", null);
						dayData.put("mycheckins", null);
					}

					if (descriptionIn != null) {
						dayData.put("descriptionIn", descriptionIn.toString());
					} else {
						dayData.put("descriptionIn", "");
					}

					if (workTypeIn != null) {
						dayData.put("workTypeIn", workTypeIn.toString());
					} else {
						dayData.put("workTypeIn", "");
					}
				} else {
					dayData.put("mycheckin", null);
					dayData.put("mycheckins", null);
					dayData.put("descriptionIn", "");
					dayData.put("workTypeIn", null);
				}

				// Check-out
				Map<String, Object> checkoutData = checkoutMap.get(date);
				if (checkoutData != null) {
					Timestamp checkoutTs = (Timestamp) checkoutData.get("checkoutTs");
					Object workingHours = checkoutData.get("workinghours");
					Object descriptionOut = checkoutData.get("descriptionOut");
					Object workTypeOut = checkoutData.get("workTypeOut");

					if (checkoutTs != null) {
						String checkoutTimeStr = checkoutTs.toLocalDateTime().toLocalTime().toString().substring(0, 5);
						dayData.put("checkouttime", checkoutTimeStr);
					} else {
						dayData.put("checkouttime", "");
					}

					if (workingHours != null) {
						dayData.put("workinghours", workingHours.toString());
					} else {
						dayData.put("workinghours", "");
					}

					if (descriptionOut != null) {
						dayData.put("descriptionOut", descriptionOut.toString());
					} else {
						dayData.put("descriptionOut", "");
					}

					if (workTypeOut != null) {
						dayData.put("workTypeOut", workTypeOut.toString());
					} else {
						dayData.put("workTypeOut", "");
					}
				} else {
					dayData.put("checkouttime", "");
					dayData.put("workinghours", "");
					dayData.put("descriptionOut", "");
					dayData.put("workTypeOut", null);
				}

				// คำนวณ status
				String status = "Incomplete";
				if (dayData.get("mycheckin") != null && !dayData.get("checkouttime").equals("")) {
					try {
						LocalTime checkinTime = LocalTime.parse(dayData.get("mycheckin").toString().substring(11, 16));
						LocalTime checkoutTime = LocalTime.parse(dayData.get("checkouttime").toString());

						String[] startParts = workStartTime.split(":");
						LocalTime workStart = LocalTime.of(Integer.parseInt(startParts[0].trim()),
								Integer.parseInt(startParts[1].trim()));

						String[] endParts = workEndTime.split(":");
						LocalTime workEnd = LocalTime.of(Integer.parseInt(endParts[0].trim()),
								Integer.parseInt(endParts[1].trim()));

						boolean isLate = checkinTime.isAfter(workStart);
						boolean isEarlyOut = checkoutTime.isBefore(workEnd);

						if (isLate && isEarlyOut) {
							status = "Unfinished Work";
						} else if (isLate) {
							status = "Late";
						} else if (isEarlyOut) {
							status = "Early out";
						} else {
							status = "On Time";
						}

					} catch (Exception e) {
						log.debug("Error parsing time for date: " + date + " - " + e.getMessage());
						status = "Incomplete";
					}
				}

				dayData.put("status", status);
				workData.add(dayData);
			}

			// Set attributes for JSP
			ObjectMapper mapper = new ObjectMapper();
			request.setAttribute("workList", workData);
			request.setAttribute("stime", workStartTime);
			request.setAttribute("etime", workEndTime);
			request.setAttribute("user", userWorkTime);
			request.setAttribute("month", String.valueOf(currentMonth));
			request.setAttribute("year", String.valueOf(currentYear));

			List<Map<String, Object>> cubeUser = userDAO.sequense();
			request.setAttribute("cubeUser", cubeUser);

			String cubeUserJson = mapper.writeValueAsString(cubeUser);
			request.setAttribute("cubeUserJson", cubeUserJson);

			log.debug("workData size: " + workData.size());

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String CheckAllCalendar2() {

		String userCalendar = request.getParameter("usercalendar");
		if (userCalendar != null && !userCalendar.isEmpty()) {
			request.getSession().setAttribute("usercalendar", userCalendar);
		} else {
			userCalendar = (String) request.getSession().getAttribute("usercalendar");
		}

		User onlineUser = (User) request.getSession().getAttribute("onlineUser");
		if (onlineUser == null) {
			return LOGIN;
		}
		String userId = (userCalendar != null && !userCalendar.isEmpty()) ? userCalendar : onlineUser.getId();

		request.setAttribute("logonUser", userId);

		try {
			// Get current user and date info
			LocalDate today = LocalDate.now();
			int currentYear = today.getYear();
			int currentMonth = today.getMonthValue();
			int last2year = currentYear - 1;

			// Holiday Calendar
			List<Holiday> allholiday = holidayDAO.findAllHoliday();
			request.setAttribute("allholiday", allholiday);

			// Leave Calendar
			LocalDate startDate = LocalDate.of(currentYear, 1, 1);
			LocalDate endDate = LocalDate.of(currentYear, 12, 31);

			DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
			Timestamp start_date_leave = DateUtil.dateToTimestamp(startDate.format(dateFormatter), "00:00:00.0");
			Timestamp end_date_leave = DateUtil.dateToTimestamp(endDate.format(dateFormatter), "23:59:59.0");
			
			List<Map<String, Object>> leavelist = leaveDAO.myLeavesList(userId, start_date_leave, end_date_leave);
			request.setAttribute("leave", leavelist);
			
			Map<LocalDate, Map<String, Object>> leaveLookup = new HashMap<>();
			if (leavelist != null) {
	            for (Map<String, Object> l : leavelist) {
	                Object dateObj = l.get("start_date");
	                if (dateObj instanceof java.sql.Date) {
	                    leaveLookup.put(((java.sql.Date) dateObj).toLocalDate(), l);
	                } else if (dateObj instanceof Timestamp) {
	                    leaveLookup.put(((Timestamp) dateObj).toLocalDateTime().toLocalDate(), l);
	                }
	            }
	        }
			
			//---- Check in - Check out Calendar
			User userWorkTime = userDAO.findById(userId);
	        if (userWorkTime == null) return ERROR;
	        
			String workStartTime = userWorkTime.getWorkTimeStart();
			String workEndTime = userWorkTime.getWorkTimeEnd();
			if (workStartTime != null && workStartTime.indexOf(':') == 1) workStartTime = "0" + workStartTime;
	        if (workEndTime != null && workEndTime.indexOf(':') == 1) workEndTime = "0" + workEndTime;
			
	        LocalTime userStart = (workStartTime != null) ? LocalTime.parse(workStartTime.substring(0, 5)) : LocalTime.of(9, 0);
	        LocalTime userEnd = (workEndTime != null) ? LocalTime.parse(workEndTime.substring(0, 5)) : LocalTime.of(18, 0);
	        
	        // Get check-in / check-out data
			Map<LocalDate, List<Map<String, Object>>> checkinMap = workHoursDAO.getCheckinsForYear2(userId,last2year,currentYear);
			Map<LocalDate, List<Map<String, Object>>> checkoutMap = workHoursDAO.getCheckoutsForYear2(userId,last2year,currentYear);

			if (checkinMap == null) checkinMap = new HashMap<>();
	        if (checkoutMap == null) checkoutMap = new HashMap<>();

			List<Map<String, Object>> workData = new ArrayList<>();
			DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("HH:mm");
			
			for (LocalDate date = startDate; !date.isAfter(endDate); date = date.plusDays(1)) {
				List<Map<String, Object>> dailyIns = checkinMap.getOrDefault(date, new ArrayList<>());
				List<Map<String, Object>> dailyOuts = checkoutMap.getOrDefault(date, new ArrayList<>());
				Map<String, Object> dailyLeave = leaveLookup.get(date);
				
				String dailyStatus = "";
				String leaveDescription = "";
				String dailyTotalHours = "";
				try {
					Map<String, Object> statusResult = workHoursService.determineDailyStatus(date, dailyIns, dailyOuts, dailyLeave, userStart, userEnd);
					if (statusResult != null) {
						dailyStatus = (String) statusResult.get("status");
						if (statusResult.containsKey("leave_desc")) {
							leaveDescription = (String) statusResult.get("leave_desc");
						}
					}

				} catch (Exception e) {
					log.error("Error calculating status", e);
				}
				
				Timestamp minIn = null;
	            Timestamp maxOut = null;
	            				
				if (!dailyIns.isEmpty()) {
	                for (Map<String, Object> in : dailyIns) {
	                    Timestamp ts = (Timestamp) in.get("checkinTs");
	                    if (ts != null && (minIn == null || ts.before(minIn))) minIn = ts;
	                }
	            }
				
				if (!dailyOuts.isEmpty()) {
	                for (Map<String, Object> out : dailyOuts) {
	                    Timestamp ts = (Timestamp) out.get("checkoutTs");
	                    if (ts != null && (maxOut == null || ts.after(maxOut))) maxOut = ts;
	                }
	            }
				
				if (minIn != null && maxOut != null) {
	                long diffMinutes = java.time.Duration.between(minIn.toLocalDateTime(), maxOut.toLocalDateTime()).toMinutes();
	                
	                long hrs = diffMinutes / 60;
	                long mins = diffMinutes % 60;
	                
	                if (hrs >= 1) hrs = hrs - 1; 
	                
	                if (diffMinutes > 0) {
	                     dailyTotalHours = String.format("%02d:%02d", hrs, mins);
	                }
	            }

				int maxRows = Math.max(dailyIns.size(), dailyOuts.size());

				if (maxRows == 0) {
					Map<String, Object> dayData = new HashMap<>();
					dayData.put("DATE(work_hours_time_work)", date.toString());
					dayData.put("mycheckin", null);
					dayData.put("mycheckins", null);
					dayData.put("checkouttime", "");
					dayData.put("workinghours", "");
					dayData.put("descriptionOut", "");
					dayData.put("workTypeOut", "");
					dayData.put("descriptionIn", (leaveDescription != null) ? leaveDescription : "");
					dayData.put("status", dailyStatus);
					workData.add(dayData);
				} else {
					for (int i = 0; i < maxRows; i++) {
						Map<String, Object> dayData = new HashMap<>();
						dayData.put("DATE(work_hours_time_work)", date.toString());
						
						// Check-in Data
						if (i < dailyIns.size()) {
							Map<String, Object> inData = dailyIns.get(i);
							Timestamp inTs = (Timestamp) inData.get("checkinTs");
							dayData.put("mycheckin", inTs);
							dayData.put("mycheckins", (inTs != null) ? inTs.toLocalDateTime().toString() : null);
	                        dayData.put("descriptionIn", inData.getOrDefault("descriptionIn", "").toString());
	                        dayData.put("workTypeIn", inData.getOrDefault("workTypeIn", ""));
						} else {
							dayData.put("mycheckin", null);
							dayData.put("mycheckins", null);
							dayData.put("descriptionIn", "");
							dayData.put("workTypeIn", "");
						}
						
						// Check-out Data
						if (i < dailyOuts.size()) {
							Map<String, Object> outData = dailyOuts.get(i);
							Timestamp outTs = (Timestamp) outData.get("checkoutTs");
							String tStr = "";
							if (outTs != null) {
								tStr = outTs.toLocalDateTime().format(timeFmt);
							}
							dayData.put("checkouttime", tStr);
							dayData.put("descriptionOut", outData.getOrDefault("descriptionOut", "").toString());
							dayData.put("workTypeOut", outData.getOrDefault("workTypeOut", ""));
						} else {
							dayData.put("checkouttime", "");
							dayData.put("descriptionOut", "");
							dayData.put("workTypeOut", "");
						}
						dayData.put("status", dailyStatus);
						dayData.put("workinghours", dailyTotalHours);

						workData.add(dayData);
					}
				}
			}
			ObjectMapper mapper = new ObjectMapper();
			request.setAttribute("workList", workData);
			request.setAttribute("stime", workStartTime);
			request.setAttribute("etime", workEndTime);
			request.setAttribute("user", userWorkTime);

			request.setAttribute("month", String.valueOf(currentMonth));
			request.setAttribute("year", String.valueOf(currentYear));
			request.setAttribute("currentYear", today.getYear());
			request.setAttribute("lastYear", today.getYear() - 1);

			List<Map<String, Object>> cubeUser = userDAO.sequense2();
			request.setAttribute("cubeUser", cubeUser);
			request.setAttribute("cubeUserJson", mapper.writeValueAsString(cubeUser));

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	
	private void loadNotification(String logonUser, User ur) {
	    try {
			User u = userDAO.findById(logonUser);
			
			//หาลายเซ็น
	    	String imgPathSignature = null;
			String signatureFileName = null;
			if (u.getPathSignature() != null && u.getPathSignature().contains("_")) {
				try {
					String originalFileName = new File(u.getPathSignature()).getName();
					String fileIdStr = originalFileName.substring(0, originalFileName.indexOf("_"));
					String typeFile = originalFileName.substring(originalFileName.lastIndexOf("."));

					imgPathSignature = "/upload/user/user_signature_" + fileIdStr + typeFile;

					String server = request.getServletContext().getRealPath("/");
					File f = new File(server + imgPathSignature);
					if (!f.exists()) {
						imgPathSignature = null;
					}

					FileUpload file = fileuploadDAO.findById(Integer.parseInt(fileIdStr));
					if (file != null) {
			            signatureFileName = file.getName()+file.getType();  
			        }
					
				} catch (Exception e) {
					imgPathSignature = null;
				}
			}
			request.setAttribute("imgPathSignature", imgPathSignature);
			request.setAttribute("signatureFileName", signatureFileName);

			//หา borrow
			List<Map<String, Object>> borrow = borrowDAO.getBorrowListByUserId(logonUser);
			boolean hasNotification = false;

			if (borrow != null && !borrow.isEmpty()) {
	            // Check Notification
	            for (Map<String, Object> row : borrow) {

	                String status = row.get("status") != null ? row.get("status").toString() : "";
	                Object userDelivery = row.get("user_delivery");
	                Object userReceive = row.get("user_receive");
	                Object userReturn = row.get("user_return");
	                Object userReturnReceive = row.get("user_return_receive");

	                boolean isReceiveWaiting = "B".equals(status)
	                        && userDelivery != null && userReceive == null
	                        && userReturn == null && userReturnReceive == null;

	                boolean isReturnWaiting = "T".equals(status)
	                        && userDelivery != null && userReceive != null
	                        && userReturn == null && userReturnReceive == null;

	                if (isReceiveWaiting || isReturnWaiting) {

	                    hasNotification = true;
	                    break;
	                }
	            }
	            
	         // Format Date
				SimpleDateFormat inputDate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
				inputDate.setCalendar(new GregorianCalendar());

				SimpleDateFormat outputDate = new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH);
				outputDate.setCalendar(new GregorianCalendar());

				for (Map<String, Object> row : borrow) {
					Object dateStartObj = row.get("time_create");
					if (dateStartObj == null) {
						continue;
					}
					String dt = dateStartObj.toString();
					String[] parts = dt.split(" ");

					String datePart = parts[0];
					String timePart = parts[1].split("\\.")[0];

					java.util.Date date = inputDate.parse(datePart);

					row.put("formatted_date", outputDate.format(date));
					row.put("formatted_time", timePart);
				}

				request.setAttribute("borrowList", borrow);
				request.setAttribute("hasNotification",hasNotification);
			} else {
				request.setAttribute("borrowList", borrow);
			}

	    } catch (Exception e) {
	        log.error("loadNotification error", e);
	    }
	}
	
	public String saveLocationToSession() {
	    Map<String, Object> result = new HashMap<>();
	    try {
	        String lat = request.getParameter("latitude");
	        String lng = request.getParameter("longitude");

	        HttpSession session = request.getSession();

	        if (lat != null && !lat.trim().isEmpty()) {
	            session.setAttribute("latitude", lat);
	        }
	        if (lng != null && !lng.trim().isEmpty()) {
	            session.setAttribute("longitude", lng);
	        }

	        result.put("status", "success");
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("status", "error");
	        result.put("message", e.getMessage());
	    }

	    try {
	        ObjectMapper mapper = new ObjectMapper();
	        response.setContentType("application/json;charset=UTF-8");
	        response.getWriter().write(mapper.writeValueAsString(result));
	        response.getWriter().flush();
	        response.getWriter().close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}
}
