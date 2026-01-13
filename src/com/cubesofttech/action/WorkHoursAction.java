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

			List leavelist = leaveDAO.myLeavesList(userId, start_date_leave, end_date_leave);
			request.setAttribute("leave", leavelist);
			//log.debug("leave: " + leavelist);
			
			// Check in - Check out Calendar
			User userWorkTime = userDAO.findById(userId);
			String workStartTime = userWorkTime.getWorkTimeStart();
			String workEndTime = userWorkTime.getWorkTimeEnd();

			// Get check-in / check-out data
			Map<LocalDate, Map<String,Object>> checkinMap = workHoursDAO.getCheckinsForYear(userId, last2year, currentYear);
			//log.debug("checkinMap: " + checkinMap);
			Map<LocalDate, Map<String,Object>> checkoutMap = workHoursDAO.getCheckoutsForYear(userId, last2year, currentYear);
			//log.debug("checkoutMap: " + checkoutMap);

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
			            LocalTime checkinTime = LocalTime.parse(dayData.get("mycheckin").toString().substring(11,16));
			            LocalTime checkoutTime = LocalTime.parse(dayData.get("checkouttime").toString());

			            String[] startParts = workStartTime.split(":");
			            LocalTime workStart = LocalTime.of(
			                Integer.parseInt(startParts[0].trim()),
			                Integer.parseInt(startParts[1].trim())
			            );

			            String[] endParts = workEndTime.split(":");
			            LocalTime workEnd = LocalTime.of(
			                Integer.parseInt(endParts[0].trim()),
			                Integer.parseInt(endParts[1].trim())
			            );

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
		log.debug("CheckAllCalendar2");
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

		request.setAttribute("logonUser", userId);
		try {
			ObjectMapper mapper = new ObjectMapper();
			
			List<Map<String, Object>> cubeUser = userDAO.sequense();
			request.setAttribute("cubeUser", cubeUser);
			
			String cubeUserJson = mapper.writeValueAsString(cubeUser);
			request.setAttribute("cubeUserJson", cubeUserJson);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
	    }
	}
}
