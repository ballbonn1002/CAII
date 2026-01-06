package com.cubesofttech.action;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.HolidayDAO;
import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.LeaveDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WorkHoursDAO;
import com.cubesofttech.model.Holiday;
import com.cubesofttech.model.Jobsite;
import com.cubesofttech.model.User;
import com.cubesofttech.model.WorkHours;
import com.cubesofttech.service.WorkHoursService;
import com.cubesofttech.util.DateUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.opensymphony.xwork2.ActionSupport;

public class WorkHoursAction extends ActionSupport {
	//com.sun.media.jfxmedia.logging.Logger log = Logger.getLogger(getClass());
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
	        LocalDate currentDate = LocalDate.now();
	        request.setAttribute("currentDate", currentDate);
	        
			List<Map<String, Object>> lastcheckin = workHoursDAO.lastcheckin(logonUser);
			List<Map<String, Object>> lastcheckout = workHoursDAO.lastcheckout(logonUser);
			request.setAttribute("lastcheckin", lastcheckin);
			log.debug(lastcheckin);
			log.debug(lastcheckout);
			request.setAttribute("lastcheckout", lastcheckout);
			
			List<Holiday> holidayList = null;
			holidayList = holidayDAO.findAllInMonth();
			log.debug(holidayList);
			request.setAttribute("holidayList", holidayList);
			User user =  userDAO.findById(logonUser);
			if (user == null) {
				log.warn("User not found: " + logonUser);
			    request.setAttribute("jobsite", null);
			} else {
				Integer idSitejob = user.getId_sitejob();
				if(idSitejob == null || idSitejob.toString().trim().isEmpty()) {
					log.warn("User " + logonUser + " has no sitejob id");
			        request.setAttribute("jobsite", null);
				} else {
					Jobsite jobsite = jobsiteDAO.findById(idSitejob);
					if (jobsite == null) {
						log.warn("Jobsite not found by id: " + idSitejob);
					} else {
						log.debug("jobsite name = " + jobsite.getName_site());
					}
					request.setAttribute("jobsite", jobsite);
				}
			}
			
			request.setAttribute("allowedDate", workHoursService.calculateAllowedWorkDateIso(currentDate));			
			
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String savecheck() {
	    Map<String, Object> result = new HashMap<>();
		try {
			String userId = request.getParameter("userId");
			String checkDate = request.getParameter("date");
			String checkTime = request.getParameter("time");
			String checkType = request.getParameter("checkType");
			String workType = request.getParameter("workType");
			String checkMode = request.getParameter("mode");
			log.debug(userId+"/"+checkType+"/"+workType);
			
			String desRaw = null;	String des = null;
			desRaw = request.getParameter("reason");
			des = (desRaw != null || desRaw != "") ? desRaw.trim() : "";
			log.debug(desRaw);

			String lat = request.getParameter("latitude");
			String lng = request.getParameter("longitude");
			
			Map<String, String> headersInfo = getHeadersInfo(request);
			String userAgent = (String) headersInfo.get("user-agent");
			String ipAddress = (String) headersInfo.get("ipAddress");
			
			LocalDateTime  now = LocalDateTime .now(ZoneId.of("Asia/Bangkok")); 
			DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("HH:mm:ss");

			Timestamp ts = null;	
			String timeString = null;
			int date;	int month;	int year;
			if("retro".equals(checkMode) && checkDate != null && checkTime != null){
				ts = Timestamp.valueOf(checkDate + " " + checkTime + ":00");
				LocalDateTime ldt = ts.toLocalDateTime();
				date = ldt.getDayOfMonth();
				month = ldt.getMonthValue();
				year = ldt.getYear();
				log.debug(ldt.getDayOfMonth()+"|"+ldt.getMonthValue()+"|"+ldt.getYear());
				log.debug(ts.getTime());
				timeString = ldt.format(timeFormat);
				if(ldt.isAfter(now)) {
					result.put("status", "error");
					result.put("message", "Can't check-in/out time in future. Please try again.");
				} else {
					result.put("status", "success");
			        result.put("type", checkType);
			        result.put("time", checkTime);
				}
			} else {
				ts = Timestamp.valueOf(now);
				date = now.getDayOfMonth();
				month = now.getMonthValue();
				year = now.getYear();
				timeString = now.format(timeFormat);
			}

			log.debug(timeString);
			int workinghour = workHoursService.calculateWorkingHours(userId, checkType, date, month, year, timeString);
						
			WorkHours wh = new WorkHours();
			wh.setWorkHoursId(workHoursDAO.getMaxId()+1);
			wh.setWorkHoursType(checkType);
			wh.setWorkHoursTimeWork(ts);
			wh.setWorkType(workType);
			wh.setLatitude(lat);
			wh.setLongitude(lng);
			wh.setDescription(des);
			wh.setUserAgent("CA-II | "+userAgent);
			wh.setIpAddress(ipAddress);
			if("retro".equals(checkMode)) {
				wh.setTimeCreate(Timestamp.valueOf(now));
				wh.setTimeUpdate(Timestamp.valueOf(now));
			} else {
				wh.setTimeCreate(ts);
				wh.setTimeUpdate(ts);
			}
			wh.setUserCreate(userId);
			wh.setUserUpdate(userId);
			wh.setWorkinghours(workinghour);
			workHoursDAO.save(wh);
			
	        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("HH:mm");
		    result.put("status", "success");
		    result.put("type", checkType);
		    if("retro".equals(checkMode)) {
		    	result.put("time", checkTime);
		    } else {
		    	result.put("time", now.format(fmt));
		    }
		} catch (Exception e) {
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
	        e.printStackTrace();
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
		String userId = (userCalendar != null && !userCalendar.isEmpty()) 
		                 ? userCalendar 
		                 : onlineUser.getId();

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
			LocalDate endOfYear   = LocalDate.of(currentYear, Month.DECEMBER, 31);

			DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
			Timestamp start_date_leave = DateUtil.dateToTimestamp(startOfYear.format(dateFormatter), "00:00:00.0");
			Timestamp end_date_leave = DateUtil.dateToTimestamp(endOfYear.format(dateFormatter), "23:59:59.0");

			List<Map<String, Object>> leavelist = leaveDAO.myLeavesList(userId, start_date_leave, end_date_leave);
			request.setAttribute("leave", leavelist);
			//log.debug("leave: " + leavelist);
			
			// Check in - Check out Calendar
			User userWorkTime = userDAO.findById(userId);
			String workStartTime = userWorkTime.getWorkTimeStart();
			String workEndTime = userWorkTime.getWorkTimeEnd();
			log.debug("WorkStartTime from DB: " + workStartTime);
			log.debug("WorkEndTime from DB: " + workEndTime);
			// Get check-in / check-out data
			List<Map<String, Object>> rawCheckList = workHoursDAO.getCheckListFromLastAndCurrentYear(userId, last2year, currentYear);
			List<Map<String, Object>> workData = new ArrayList<>();
			Map<String, Object> currentPair = null;

			log.debug(userId+"/"+last2year+"/"+currentYear);
			log.debug(rawCheckList);
			
			for (Map<String, Object> row : rawCheckList) {
				try {
					String workType = row.get("work_hours_type").toString();
					Timestamp time = (Timestamp) row.get("work_hours_time_work");
					if (workType == null || time == null) continue;
					if ("1".equals(workType)) {
						currentPair = new HashMap<>();
                        currentPair.put("DATE(work_hours_time_work)", time.toLocalDateTime().toLocalDate().toString());
                        currentPair.put("mycheckins", time);
                        currentPair.put("mycheckin", time.toLocalDateTime().toString());
                        currentPair.put("descriptionIn", row.get("description") != null ? row.get("description").toString() : "");
                        currentPair.put("workTypeIn", row.get("work_type") != null ? row.get("work_type").toString() : "");
                        
                        // Default values
                        currentPair.put("checkouttime", "");
                        currentPair.put("workinghours", ""); 
                        currentPair.put("descriptionOut", "");
                        currentPair.put("workTypeOut", "");
                        currentPair.put("status", "Incomplete");
                        workData.add(currentPair);
					} else if ("2".equals(workType) && currentPair != null) {
						Timestamp checkinTime = (Timestamp) currentPair.get("mycheckins");
                        
                        boolean isSameDay = checkinTime.toLocalDateTime().toLocalDate().isEqual(time.toLocalDateTime().toLocalDate());
                        
                        long diff = time.getTime() - checkinTime.getTime();
                        boolean isWithin24Hours = diff < (24 * 60 * 60 * 1000);

						if (isSameDay || isWithin24Hours) {
                            String checkoutTimeStr = time.toLocalDateTime().toLocalTime().toString().substring(0, 5);
                            currentPair.put("checkouttime", checkoutTimeStr);
                            currentPair.put("descriptionOut", row.get("description") != null ? row.get("description").toString() : "");
                            currentPair.put("workTypeOut", row.get("work_type") != null ? row.get("work_type").toString() : "");
                            
                            long minutes = diff / (60 * 1000);
                            currentPair.put("workinghours", String.valueOf(minutes)); 

                            // คำนวณ Status (On Time / Late)
                            // ... (ใส่ Logic คำนวณ Status ตามโค้ดเดิมของคุณตรงนี้) ...
                             boolean hasWorkConfig = (workStartTime != null && !workStartTime.isEmpty() && workEndTime != null && !workEndTime.isEmpty());
                             if (hasWorkConfig) {
                                 // ... logic คำนวณ Late/Early ...
                             } else {
                                 currentPair.put("status", "On Time");
                             }
                            currentPair = null;
                        } else {
                            currentPair = null; 
                        }
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
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
	
}
