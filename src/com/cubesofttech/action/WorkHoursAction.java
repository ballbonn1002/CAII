package com.cubesofttech.action;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
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
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WorkHoursDAO;
import com.cubesofttech.model.Holiday;
import com.cubesofttech.model.User;
import com.cubesofttech.model.WorkHours;
import com.cubesofttech.service.WorkHoursService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.opensymphony.xwork2.ActionSupport;

public class WorkHoursAction extends ActionSupport {
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
			
			List<Map<String, Object>> lastcheckin = workHoursDAO.lastcheckin(logonUser);
			List<Map<String, Object>> lastcheckout = workHoursDAO.lastcheckout(logonUser);
			request.setAttribute("lastcheckin", lastcheckin);
			request.setAttribute("lastcheckout", lastcheckout);
			log.debug(lastcheckin);
			log.debug(lastcheckout);
			List<Holiday> holidayList = holidayDAO.findAllInMonth();
			request.setAttribute("holidayList", holidayList);
			log.debug(holidayList);
			User user =  userDAO.findById(logonUser);
			log.debug(user);
			
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
			String checkType = request.getParameter("checkType");
			String workType = request.getParameter("workType");
			log.debug(userId+"/"+checkType+"/"+workType);
			String desRaw = request.getParameter("description");
			String des = (desRaw != null) ? desRaw.trim() : "";
			String lat = request.getParameter("latitude");
			String lng = request.getParameter("longitude");

			LocalDateTime  now = LocalDateTime .now(ZoneId.of("Asia/Bangkok")); // ให้ชัดเจนเรื่องโซนเวลา
			Timestamp ts = Timestamp.valueOf(now);
			
			Map<String, String> headersInfo = getHeadersInfo(request);
			String userAgent = (String) headersInfo.get("user-agent");
			String ipAddress = (String) headersInfo.get("ipAddress");
			String mytime = ts.getHours() + ":" + ts.getMinutes();
			log.debug(mytime);
			int date = now.getDayOfMonth();
			int month = now.getMonthValue();
			int year = now.getYear();
			int workinghour = workHoursService.calculateWorkingHours(userId, checkType, date, month, year, mytime);
			
			WorkHours wh = new WorkHours();
			wh.setWorkHoursId(workHoursDAO.getMaxId()+1);
			wh.setWorkHoursType(checkType);
			wh.setWorkHoursTimeWork(ts);
			wh.setWorkType(workType);
			wh.setLatitude(lat);
			wh.setLongitude(lng);
			wh.setDescription(des);
			wh.setUserAgent(userAgent);
			wh.setIpAddress(ipAddress);
			wh.setTimeCreate(ts);
			wh.setTimeUpdate(ts);
			wh.setUserCreate(userId);
			wh.setUserUpdate(userId);
			wh.setWorkinghours(workinghour);
			
			workHoursDAO.save(wh);
			
	        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("HH:mm");
		    result.put("status", "success");
		    result.put("type", checkType);
		    result.put("time", now.format(fmt));

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
}
