package com.cubesofttech.action;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
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
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WorkHoursDAO;
import com.cubesofttech.model.User;
import com.cubesofttech.model.WorkHours;
import com.cubesofttech.service.LineMessagingService;
import com.cubesofttech.service.WorkHoursService;
import com.cubesofttech.util.DateUtil;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.opensymphony.xwork2.ActionSupport;

public class WebhookAction extends ActionSupport implements ServletRequestAware, ServletResponseAware {

	private static final Logger log = Logger.getLogger(WebhookAction.class);
	private static final long serialVersionUID = 1L;
	
	private HttpServletRequest request;
    private HttpServletResponse response;
    
    @Autowired
	private WorkHoursService workHoursService;
    
    @Autowired
	private LineMessagingService lineMessagingService;
    
    @Autowired
	private UserDAO userDAO;
    
    @Autowired
	private WorkHoursDAO workHoursDAO;
    
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
    
    @Override
    public String execute() {
    	try {
    		String payload;
            try (InputStream in = request.getInputStream()) {
            	payload = readBody(in, request.getCharacterEncoding());
            }
        	ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(payload);
            ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
			String json = ow.writeValueAsString(root);
			log.debug(json);
			JsonNode eventsNode = root.path("events").get(0);
			
			if(!(eventsNode == null || eventsNode.isMissingNode() || eventsNode.isNull())) {
				String text = eventsNode.path("message").path("text").asText();
				String uid = eventsNode.path("source").path("userId").asText();
				String replyToken = eventsNode.path("replyToken").asText();
	            String code = text.substring(0, 4);
	            User userExist = userDAO.findByUid(uid);
	            log.debug(userExist == null);
	            String echoMessage;
	            
	            if(userExist == null) {
	            	// Account Binding | case: No account bound
	            	if(code.equals("#uid")) {
		            	String line = text.substring(4).trim();
		            	log.debug(line);
		            	User userBinding = userDAO.findByLine(line);
		            	log.debug(userBinding);
		            	userBinding.setUid_line_oa(uid);
		            	userDAO.update(userBinding);
		            	echoMessage = "Binding successfully!";
		            	lineMessagingService.replyTextMessage(replyToken, echoMessage);
		            }else if(code.equals("#a00")) {
		            	//ask for how to binding : do not anything
		            }else if(!(text.equals("benefit") || text.equals("Holiday"))) {
		            	echoMessage = "Account not bound, Please bind account.";
		            	lineMessagingService.replyTextMessage(replyToken, echoMessage);
		            }
	            } else if(userExist != null) {
	            	if(userExist.getEnable().equals("1") & (userExist.getEndDate() == null || userExist.getEndDate().compareTo(DateUtil.getCurrentTime()) >= 0)) {
		            	// Account Binding | case: Account bound
		            	if(code.equals("#uid")) {
			            	String line = text.substring(4).trim();
			            	log.debug(line);
			            	User userBinding = userDAO.findByLine(line);
			            	log.debug(userBinding);
			            	
			            	if(userExist.getLine_id().equals(line)) {
			            		//update uid on old account
			            		userBinding.setUid_line_oa(uid);
				            	userDAO.update(userBinding);
				            	echoMessage = "Update binding successfully!";
				            	lineMessagingService.replyTextMessage(replyToken, echoMessage);
			            	}else {
			            		//update uid on new account
			            		echoMessage = "Please unbound old account before binding new account.";
				            	lineMessagingService.replyTextMessage(replyToken, echoMessage);
			            	}
			            	
			            }
			            
		            	// Check-In/Check-Out
			            if(text.equals("Check-In/WFH") || text.equals("Check-In/On-Site") || text.equals("Check-Out/WFH") || text.equals("Check-Out/On-Site")) {
			            	String checkType = null;
			            	String workType = null;
			            	switch (text) {
			            		case "Check-In/On-Site":
			            			checkType = "1";
			            			workType = "1";
			            			break;
			            		case "Check-In/WFH":
			            			checkType = "1";
			            			workType = "2";
			            			break;
			            		case "Check-In/Head-Office":
			            			checkType = "1";
			            			workType = "3";
			            			break;
			            		case "Check-Out/On-Site":
			            			checkType = "2";
			            			workType = "1";
			            			break;
			            		case "Check-Out/WFH":
			            			checkType = "2";
			            			workType = "2";
			            			break;
			            		case "Check-Out/Head-Office":
			            			checkType = "2";
			            			workType = "3";
			            			break;
			            	}
			            	log.debug(checkType);
			            	
			            	User user = userDAO.findByUid(uid);
				            LocalDateTime now = LocalDateTime.now(ZoneId.of("Asia/Bangkok"));
				            DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("HH:mm:ss");
				            Timestamp ts = null;
				            String timeString = null;
							int date;
							int month;
							int year;
							LocalDateTime officialLdt = now;
							if ("2".equals(checkType)) {
								LocalDateTime cutOffTime = now.withHour(18).withMinute(30).withSecond(0).withNano(0);
	
								if (now.isAfter(cutOffTime)) {
									officialLdt = cutOffTime;
									log.info("Cut-off applied | User: " + user.getId() + " | Real: " + now + " -> Official: "
											+ officialLdt);
								}
							}
							ts = Timestamp.valueOf(officialLdt);
				            timeString = officialLdt.format(timeFormat);
							date = now.getDayOfMonth();
							month = now.getMonthValue();
							year = now.getYear();
							int workinghour = workHoursService.calculateWorkingHours(user.getId(), checkType, date, month, year, timeString);
							
							Map<String, String> headersInfo = getHeadersInfo(request);
			    			String userAgent = (String) headersInfo.get("user-agent");
			    			String ipAddress = (String) headersInfo.get("ipAddress");
			    			
			    			WorkHours wh = new WorkHours();
			    			wh.setWorkHoursId(workHoursDAO.getMaxId() + 1);
			    			wh.setWorkHoursType(checkType);
			    			wh.setWorkHoursTimeWork(ts);
			    			wh.setWorkType(workType);
			    			wh.setLatitude("");
			    			wh.setLongitude("");
			    			wh.setDescription("");
			    			wh.setUserAgent("CA-II | " + userAgent);
			    			wh.setIpAddress(ipAddress);
			    			wh.setTimeCreate(DateUtil.getCurrentTime());
							wh.setTimeUpdate(DateUtil.getCurrentTime());
			    			wh.setUserCreate(user.getId());
			    			wh.setUserUpdate(user.getId());
			    			wh.setWorkinghours(workinghour);
			    			workHoursDAO.save(wh);
			    			echoMessage = "Saved successfully!";
			    			lineMessagingService.replyTextMessage(replyToken, echoMessage);
			            }
			            
			            // My Profile
		            	if(text.equals("My Profile")) {
		            		echoMessage = userExist.getId() + "\n" + userExist.getEmployeeId() + " " + userExist.getNameEN() + " - " + userExist.getName() 
		            						+ "\nPosition : " + ((userExist.getPositionId() == null || userExist.getPositionId().isEmpty()) ? "NONE" : userExist.getPositionId()) 
		            						+ "\nDepartment : " + ((userExist.getDepartmentId() == null || userExist.getDepartmentId().isEmpty()) ? "NONE" : userExist.getDepartmentId());
			    			lineMessagingService.replyTextMessage(replyToken, echoMessage);
			            }
	            	}
	            }
	            
			}
            
    		response.setStatus(200);
            response.getWriter().write("ok");
            return NONE;
    	} catch (Exception e) {
        	e.printStackTrace();
            try {
                response.setStatus(500);
                response.getWriter().write("error");
            } catch (Exception ignore) {}
            return NONE;
        }
    }
    
    private String readBody(InputStream in, String charset) throws IOException {
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        byte[] data = new byte[1024];
        int nRead;
        while ((nRead = in.read(data, 0, data.length)) != -1) {
            buffer.write(data, 0, nRead);
        }
        buffer.flush();
        return new String(buffer.toByteArray(), charset != null ? charset : "UTF-8");
    }
    
    @Override public void setServletRequest(HttpServletRequest httpServletRequest) { this.request = httpServletRequest; }
    @Override public void setServletResponse(HttpServletResponse httpServletResponse) { this.response = httpServletResponse; }
}