package com.cubesofttech.action;

import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;
import com.opensymphony.xwork2.ActionSupport;
import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WorkLogDAO;
import com.cubesofttech.model.User;
import com.cubesofttech.service.WorkHoursService;

public class WorkLogAction extends ActionSupport {

    private static final long serialVersionUID = 1L;
    Logger log = Logger.getLogger(getClass());
    HttpServletRequest request = ServletActionContext.getRequest();
    HttpServletResponse response = ServletActionContext.getResponse();
    
    private User onlineUser = (User) request.getSession().getAttribute("onlineUser");

    @Autowired
    private WorkLogDAO workLogDAO;
    @Autowired
    private JobsiteDAO jobsiteDAO;
    @Autowired
    private UserDAO userDAO;
    @Autowired
    private WorkHoursService workHoursService;

    // OPEN PAGE 
    public String open() {
        try {
        	if (onlineUser == null) {
				return "login";
			}
            // โหลด Dropdown 
            List<Map<String, Object>> userList = userDAO.Query_Userlist();
            List<Map<String, Object>> siteList = jobsiteDAO.findAll();
            
            request.setAttribute("userList", userList);
            request.setAttribute("siteList", siteList);
            
            // กำหนดค่า Default วันที่
            LocalDate today = LocalDate.now();
            DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("dd-MM-yyyy");
            request.setAttribute("defaultStartDate", today.with(TemporalAdjusters.firstDayOfMonth()).format(dateFormat));
            request.setAttribute("defaultEndDate", today.format(dateFormat));

            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }

    // DATA
    public String search() {
        try {
        	if (onlineUser == null) {
				return "login";
			}
            // Parameter
            String searchText = request.getParameter("searchText");
            String status = request.getParameter("status");
            String siteId = request.getParameter("siteId");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");

            // Config Date Default 
            LocalDate today = LocalDate.now();
            DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("dd-MM-yyyy", Locale.ENGLISH);
            if (startDate == null || startDate.isEmpty()) {
                startDate = today.with(TemporalAdjusters.firstDayOfMonth()).format(dateFormat);
            }
            if (endDate == null || endDate.isEmpty()) {
                endDate = today.format(dateFormat);
            }

            Map<String, Object> params = new HashMap<>();
            params.put("searchText", searchText);
            params.put("status", status);
            params.put("siteId", siteId);
            params.put("startDate", startDate);
            params.put("endDate", endDate);

            // Import Data
            List<Map<String, Object>> workLogList = workLogDAO.search(params);
            
            if (workLogList != null) {
                SimpleDateFormat dateKeyFmt = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
                
                // Loop check Late in day
                Set<String> lateUserDateSet = new HashSet<>();
                
                for (Map<String, Object> row : workLogList) {
                    try {
                        Object typeObj = row.get("work_hours_type");
                        String type = (typeObj != null) ? typeObj.toString() : "";
                        
                        if ("1".equals(type)) { // User Check-in
                            Object timeObj = row.get("work_hours_time_work");
                            Date workTime = (Date) timeObj;
                            Object userIdObj = row.get("user_id");
                            String userId = (userIdObj != null) ? userIdObj.toString() : "";

                            // Work time User
                            String userStartStr = (row.get("work_time_start") != null) ? row.get("work_time_start").toString().trim() : "09:00:00";
                            if (userStartStr.indexOf(":") == 1) userStartStr = "0" + userStartStr;
                            
                            LocalTime userStartTime = LocalTime.parse(userStartStr);
                            LocalTime scanTime = new java.sql.Time(workTime.getTime()).toLocalTime();

                            // if Late set key (Format: USERID_DATE)
                            if (scanTime.isAfter(userStartTime)) {
                                String key = userId + "_" + dateKeyFmt.format(workTime);
                                lateUserDateSet.add(key);
                            }
                        }
                    } catch (Exception e) {}
                }

                // STATUS
                for (Map<String, Object> row : workLogList) {
                	try {
                        // Import Data
                        Object typeObj = row.get("work_hours_type");
                        String type = (typeObj != null) ? typeObj.toString() : "";
                        
                        Object userIdObj = row.get("user_id");
                        String userId = (userIdObj != null) ? userIdObj.toString() : "";
                        
                        Object timeObj = row.get("work_hours_time_work");
                        Date workTime = (Date) timeObj;
                        
                        String userStartStr = (row.get("work_time_start") != null) ? row.get("work_time_start").toString().trim() : "09:00:00";
                        String userEndStr = (row.get("work_time_end") != null) ? row.get("work_time_end").toString().trim() : "18:00:00";
                        
                        if (userStartStr.indexOf(":") == 1) userStartStr = "0" + userStartStr;
                        if (userEndStr.indexOf(":") == 1) userEndStr = "0" + userEndStr;

                        LocalTime userStartTime = LocalTime.parse(userStartStr);
                        LocalTime userEndTime = LocalTime.parse(userEndStr);
                        LocalTime scanTime = new java.sql.Time(workTime.getTime()).toLocalTime();

                        String rowStatus = ""; 
                        
                        // Check-in
                        if ("1".equals(type)) {
                            if (scanTime.isAfter(userStartTime)) {
                                rowStatus = "Late";
                            } else {
                                rowStatus = "OnTime";
                            }
                        
                        // Check-out
                        } else if ("2".equals(type)) {
                            
                            if (scanTime.isBefore(userEndTime)) {
                                // Check Late-Early Out
                                String key = userId + "_" + dateKeyFmt.format(workTime);
                                
                                if (lateUserDateSet.contains(key)) {
                                    rowStatus = "Unfinished Work";
                                } else {
                                    rowStatus = "Early Out";
                                }
                            } else {
                                rowStatus = "Finished Work";
                            }
                        }
                        row.put("status", rowStatus);
                        
                        // DURATION 
                        String durationStr = "";
                        if ("2".equals(type)) { 
                        	Calendar cal = Calendar.getInstance(Locale.US); 
                            cal.setTime(workTime);
                            
                            int date = cal.get(Calendar.DATE);
                            int month = cal.get(Calendar.MONTH) + 1;
                            int year = cal.get(Calendar.YEAR);

                            SimpleDateFormat timeFormatUS = new SimpleDateFormat("HH:mm", Locale.US);
                            String myTimeHHMM = timeFormatUS.format(workTime);

                            int totalMinutes = workHoursService.calculateWorkingHours(userId, type, date, month, year, myTimeHHMM);
                            
                            if (totalMinutes > 0) {
                                int hrs = totalMinutes / 60;
                                int mins = totalMinutes % 60;
                                durationStr = String.format("%d:%02d hrs.", hrs, mins);
                            }
                        }
                        row.put("work_duration", durationStr);

                    } catch (Exception ex) {
                        ex.printStackTrace(); 
                    }
                }
                
                if (workLogList != null && !workLogList.isEmpty()) {
                    
                    // 1. กรอง Status
                    if (status != null && !status.isEmpty()) {
                        final String statusFilter = status;
                        workLogList.removeIf(r -> {
                            String s = (String) r.get("status");
                            return !statusFilter.equalsIgnoreCase(s);
                        });
                    }

                    // 2. กรอง Site
                    if (siteId != null && !siteId.isEmpty()) {
                         final String siteFilter = siteId;
                         workLogList.removeIf(r -> {
                            Object siteObj = r.get("id_sitejob");
                            String s = (siteObj != null) ? siteObj.toString() : "";
                            return !siteFilter.equals(s);
                         });
                    }
                }
            }
            
            Map<String, Integer> summary = calculateSummary(workLogList);

            Map<String, Object> jsonResponse = new HashMap<>();
            jsonResponse.put("workLogList", workLogList);
            jsonResponse.put("summary", summary);

            // JSON to Response 
            Gson gson = new Gson();
            String json = gson.toJson(jsonResponse);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print(json);
            out.flush();
            out.close();

            return null; 

        } catch (Exception e) {
            log.error("Error in WorkLogAction.search()", e);
            e.printStackTrace();
            return null;
        }
    }

    private Map<String, Integer> calculateSummary(List<Map<String, Object>> list) {
        Map<String, Integer> stats = new HashMap<>();
        stats.put("total", 0);

        if (list != null && !list.isEmpty()) {
            stats.put("total", list.size());
        }
        return stats;
    }
}