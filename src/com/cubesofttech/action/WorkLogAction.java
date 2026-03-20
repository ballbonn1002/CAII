package com.cubesofttech.action;

import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WorkLogDAO;
import com.cubesofttech.model.User;
import com.cubesofttech.model.WorkHours;
import com.cubesofttech.service.WorkHoursService;

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
import java.net.URLEncoder;
import java.util.Collections;
import java.util.Comparator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;

import com.google.gson.Gson;
import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;
import com.opensymphony.xwork2.ActionSupport;

public class WorkLogAction extends ActionSupport {

    private static final long serialVersionUID = 1L;
    Logger log = Logger.getLogger(getClass());
    HttpServletRequest request = ServletActionContext.getRequest();
    HttpServletResponse response = ServletActionContext.getResponse();
    
    private User onlineUser = (User) request.getSession().getAttribute("onlineUser");
    
    private static final String SESSION_WORKLOG_LIST = "CACHED_WORKLOG_LIST";
    private static final String SESSION_WORKLOG_PARAMS = "CACHED_WORKLOG_PARAMS";

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
            // Dropdown 
            List<Map<String, Object>> userList = userDAO.Query_Userlist();
            List<Map<String, Object>> siteList = jobsiteDAO.findAll();
            
            request.setAttribute("userList", userList);
            request.setAttribute("siteList", siteList);
            
            // Default Date
            LocalDate today = LocalDate.now();
            DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("dd-MM-yyyy");
            request.setAttribute("defaultStartDate", today.format(dateFormat));
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
            String searchText = request.getParameter("searchText");
            String status = request.getParameter("status");
            String siteId = request.getParameter("siteId");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String sortting = request.getParameter("sortting");

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
            params.put("sortting", sortting);
            params.put("startDate", startDate);
            params.put("endDate", endDate);

            // Import Data
            List<Map<String, Object>> workLogList = workLogDAO.search(params);
            
            request.getSession().setAttribute(SESSION_WORKLOG_PARAMS, new HashMap<>(params));
            request.getSession().setAttribute(SESSION_WORKLOG_LIST, workLogList);
            
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
                            
                            LocalTime userStartTime = LocalTime.parse(userStartStr).withSecond(0).withNano(0);
                            LocalTime scanTime = new java.sql.Time(workTime.getTime()).toLocalTime().withSecond(0).withNano(0);

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

                        LocalTime userStartTime = LocalTime.parse(userStartStr).withSecond(0).withNano(0);
                        LocalTime userEndTime = LocalTime.parse(userEndStr).withSecond(0).withNano(0);
                        LocalTime scanTime = new java.sql.Time(workTime.getTime()).toLocalTime().withSecond(0).withNano(0);

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
                                durationStr = String.format("%d:%02d", hrs, mins);
                            }
                        }
                        row.put("work_duration", durationStr);

                    } catch (Exception ex) {
                        ex.printStackTrace(); 
                    }
                }
                
                if (workLogList != null && !workLogList.isEmpty()) {
                    
                    // Filter Status
                   // if (status != null && !status.isEmpty()) {
                   //     final String statusFilter = status;
                   //     workLogList.removeIf(r -> {
                   //         String s = (String) r.get("status");
                    //        return !statusFilter.equalsIgnoreCase(s);
                   //     });
                   // }

                    // Filter Site
                   // if (siteId != null && !siteId.isEmpty()) {
                   //      final String siteFilter = siteId;
                   //      workLogList.removeIf(r -> {
                   //         Object siteObj = r.get("id_sitejob");
                   //         String s = (siteObj != null) ? siteObj.toString() : "";
                   //         return !siteFilter.equals(s);
                   //      });
                  //  }
                }
            }
            
            request.getSession().setAttribute(SESSION_WORKLOG_LIST, workLogList);

            
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
    
    @SuppressWarnings("unchecked")
    public String exportExcel() {
        try {
            if (onlineUser == null) return "login";

            String searchText = request.getParameter("searchText");
            String status     = request.getParameter("status");
            String siteId     = request.getParameter("siteId");
            String startDate  = request.getParameter("startDate");
            String endDate    = request.getParameter("endDate");
            String sortting   = request.getParameter("sortting");

            // fallback session
            Map<String, Object> cachedParams =
                    (Map<String, Object>) request.getSession().getAttribute(SESSION_WORKLOG_PARAMS);

            if (cachedParams != null) {
                if (isEmpty(siteId))    siteId    = toStr(cachedParams.get("siteId"));
                if (isEmpty(status))    status    = toStr(cachedParams.get("status"));
                if (isEmpty(startDate)) startDate = toStr(cachedParams.get("startDate"));
                if (isEmpty(endDate))   endDate   = toStr(cachedParams.get("endDate"));
                if (isEmpty(sortting))  sortting  = toStr(cachedParams.get("sortting"));
                if (isEmpty(searchText))searchText= toStr(cachedParams.get("searchText"));
            }

            List<Map<String, Object>> list =
                    (List<Map<String, Object>>) request.getSession().getAttribute(SESSION_WORKLOG_LIST);

            boolean isCached = (list != null);

            if (!isCached) {
                Map<String, Object> params = new HashMap<>();
                params.put("searchText", searchText);
                params.put("status", status);
                params.put("siteId", siteId);
                params.put("startDate", startDate);
                params.put("endDate", endDate);
                params.put("sortting", sortting);

                list = workLogDAO.search(params);

                request.getSession().setAttribute(SESSION_WORKLOG_PARAMS, new HashMap<>(params));
                request.getSession().setAttribute(SESSION_WORKLOG_LIST, list);
            }
            
            final String sorttingFinal = sortting;
            if (list != null) {
                Collections.sort(list, new Comparator<Map<String, Object>>() {
                    @Override
                    public int compare(Map<String, Object> o1, Map<String, Object> o2) {
                        try {
                            Date d1 = (Date) o1.get("work_hours_time_work");
                            Date d2 = (Date) o2.get("work_hours_time_work");
                            if (d1 == null && d2 == null) return 0;
                            if (d1 == null) return 1;
                            if (d2 == null) return -1;

                            if ("2".equals(sorttingFinal)) return d2.compareTo(d1); // DESC
                            return d1.compareTo(d2); // ASC
                        } catch (Exception e) {
                            return 0;
                        }
                    }
                });
            }
            
            // Format
            Map<String, List<Map<String, Object>>> dataByMonth = new java.util.LinkedHashMap<>();
            SimpleDateFormat tabNameFmt = new SimpleDateFormat("MMM yyyy", Locale.US); 
            SimpleDateFormat dateKeyFmt = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
            Set<String> lateUserDateSet = new HashSet<>();

            // If none Cached -> Loop check Late user 
            if (!isCached && list != null) {
                for (Map<String, Object> row : list) {
                    try {
                        Object typeObj = row.get("work_hours_type");
                        String type = (typeObj != null) ? typeObj.toString() : "";
                        
                        if ("1".equals(type)) { 
                            Object timeObj = row.get("work_hours_time_work");
                            Date workTime = (Date) timeObj;
                            Object userIdObj = row.get("user_id");
                            String userId = (userIdObj != null) ? userIdObj.toString() : "";
    
                            String userStartStr = (row.get("work_time_start") != null) ? row.get("work_time_start").toString().trim() : "09:00:00";
                            if (userStartStr.indexOf(":") == 1) userStartStr = "0" + userStartStr;
                            
                            LocalTime userStartTime = LocalTime.parse(userStartStr).withSecond(0).withNano(0);
                            LocalTime scanTime = new java.sql.Time(workTime.getTime()).toLocalTime().withSecond(0).withNano(0);
    
                            if (scanTime.isAfter(userStartTime)) {
                                String key = userId + "_" + dateKeyFmt.format(workTime);
                                lateUserDateSet.add(key);
                            }
                        }
                    } catch (Exception e) {}
                }
            }

            //  Loop Filter and Grouping 
            if (list != null) {
                for (Map<String, Object> row : list) {
                    try {
                        String rowStatus = "";
                        String durationStr = "";

                        // -- Check Status --
                        if (isCached && row.containsKey("status") && row.get("status") != null) {
                            // Have Cache 
                            rowStatus = (String) row.get("status");
                            durationStr = (String) row.get("work_duration"); 
                        } else {
                            // None Cache 
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

                            LocalTime userStartTime = LocalTime.parse(userStartStr).withSecond(0).withNano(0);
                            LocalTime userEndTime = LocalTime.parse(userEndStr).withSecond(0).withNano(0);
                            LocalTime scanTime = new java.sql.Time(workTime.getTime()).toLocalTime().withSecond(0).withNano(0);

                            if ("1".equals(type)) { 
                                rowStatus = (scanTime.isAfter(userStartTime)) ? "Late" : "Ontime";
                            } else if ("2".equals(type)) { 
                                if (scanTime.isBefore(userEndTime)) {
                                    String key = userId + "_" + dateKeyFmt.format(workTime);
                                    rowStatus = (lateUserDateSet.contains(key)) ? "Unfinished Work" : "Early Out";
                                } else {
                                    rowStatus = "Finished Work";
                                }
                            }
                            
                            if ("2".equals(type) && ("Early Out".equals(rowStatus) || "Finished Work".equals(rowStatus) || "Unfinished Work".equals(rowStatus))) {
                                 try {
                                     Calendar cal = Calendar.getInstance(Locale.US);
                                     cal.setTime(workTime);
                                     int date = cal.get(Calendar.DATE);
                                     int month = cal.get(Calendar.MONTH) + 1;
                                     int year = cal.get(Calendar.YEAR);
                                     SimpleDateFormat timeFormatUS = new SimpleDateFormat("HH:mm", Locale.US);
                                     int totalMinutes = workHoursService.calculateWorkingHours(userId, type, date, month, year, timeFormatUS.format(workTime));
                                     
                                     if (totalMinutes > 0) {
                                         int hrs = totalMinutes / 60;
                                         int mins = totalMinutes % 60;
                                         durationStr = String.format("%02d:%02d:00", hrs, mins);
                                     }
                                 } catch (Exception ex) { ex.printStackTrace(); }
                            }
                        }

                        // -- Filter --
                        // Status
                        if (status != null && !status.isEmpty()) {
                            if (!status.equalsIgnoreCase(rowStatus)) continue; 
                        }

                        // -- Update data --
                        row.put("calculated_status", rowStatus);
                        row.put("calculated_duration", (durationStr != null) ? durationStr : "");

                        // -- Grouping month --
                        Object timeObj = row.get("work_hours_time_work");
                        if (timeObj != null) {
                            String monthKey = tabNameFmt.format((Date) timeObj); 
                            if (!dataByMonth.containsKey(monthKey)) {
                                dataByMonth.put(monthKey, new java.util.ArrayList<Map<String, Object>>());
                            }
                            dataByMonth.get(monthKey).add(row);
                        }

                    } catch (Exception e) { e.printStackTrace(); }
                }
            }

            // -- Excel --
            Workbook workbook = new XSSFWorkbook();
            
            
            // Style Header and Title
            CellStyle titleStyle = workbook.createCellStyle();
            titleStyle.setAlignment(HorizontalAlignment.CENTER);
            titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            Font titleFont = workbook.createFont();
            titleFont.setBold(true);
            titleFont.setFontHeightInPoints((short) 14);
            titleStyle.setFont(titleFont);

            // Style Header
            XSSFCellStyle headerStyle = (XSSFCellStyle) workbook.createCellStyle();
            headerStyle.setAlignment(HorizontalAlignment.CENTER);
            headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            
            // bg Color
            XSSFColor customColor = new XSSFColor(new java.awt.Color(255, 217, 102));
            headerStyle.setFillForegroundColor(customColor);
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            
            headerStyle.setBorderTop(BorderStyle.THIN);
            headerStyle.setBorderBottom(BorderStyle.THIN);
            headerStyle.setBorderLeft(BorderStyle.THIN);
            headerStyle.setBorderRight(BorderStyle.THIN);

            // Font 
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerStyle.setFont(headerFont);
            
            String[] columns = {"#", "ชื่อพนักงาน EN", "ชื่อพนักงาน TH", "type", "Location", "Date", "TIME", "Status", "Work Hours (hrs.)", "Retroactively", "TIME STEMP", "IP Address"};

            for (Map.Entry<String, List<Map<String, Object>>> entry : dataByMonth.entrySet()) {
                String sheetName = entry.getKey(); 
                List<Map<String, Object>> sheetRows = entry.getValue(); 
                Sheet sheet = workbook.createSheet(sheetName);

                // Title Row
                Row titleRow = sheet.createRow(0);
                Cell titleCell = titleRow.createCell(0);
                titleCell.setCellValue("รายงานการลงเวลา Check - in / Check - out ของพนักงาน");
                titleCell.setCellStyle(titleStyle);
                sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, columns.length - 1));

                // Header Row
                Row headerRow = sheet.createRow(1);
                for (int i = 0; i < columns.length; i++) {
                    Cell cell = headerRow.createCell(i);
                    cell.setCellValue(columns[i]);
                    cell.setCellStyle(headerStyle);
                }

                // Data
                int rowNum = 2;
                int seq = 1; 
                
                for (Map<String, Object> row : sheetRows) {
                    Row dataRow = sheet.createRow(rowNum++);
                    
                    dataRow.createCell(0).setCellValue(seq++);
                    
                    String nameEn = (String) row.get("name_en");
                    dataRow.createCell(1).setCellValue(nameEn != null ? nameEn : "");
                    String nameTh = (String) row.get("name");
                    dataRow.createCell(2).setCellValue(nameTh != null ? nameTh : "");
                    
                    String typeCode = (row.get("work_hours_type") != null) ? row.get("work_hours_type").toString() : "";
                    String typeText = typeCode.equals("1") ? "check - in" : "check - out";
                    dataRow.createCell(3).setCellValue(typeText);
                    
                    // Location Logic
                    String workType = (row.get("work_type") != null) ? row.get("work_type").toString() : "";
                    String locationText = "";
                    if ("1".equals(workType)) locationText = "On-Site";
                    else if ("2".equals(workType)) locationText = "WFH";
                    
                    dataRow.createCell(4).setCellValue(locationText);
                    
                    Object timeObj = row.get("work_hours_time_work");
                    if (timeObj != null) {
                         Date workTime = (Date) timeObj;
                         dataRow.createCell(5).setCellValue(new SimpleDateFormat("dd/MM/yyyy", Locale.US).format(workTime));
                         dataRow.createCell(6).setCellValue(new SimpleDateFormat("HH:mm", Locale.US).format(workTime));
                    }
                    
                    dataRow.createCell(7).setCellValue((String) row.get("calculated_status"));
                    dataRow.createCell(8).setCellValue((String) row.get("calculated_duration"));
                    
                    String description = (row.get("description") != null) ? row.get("description").toString() : "";
                    dataRow.createCell(9).setCellValue(description);
                    
                    Object createTimeObj = row.get("time_update");
                    if (createTimeObj != null) {
                        dataRow.createCell(10).setCellValue(new SimpleDateFormat("dd/MM/yyyy, HH:mm", Locale.US).format((Date) createTimeObj));
                    }
                    
                    String ipAddress = (row.get("ip_address") != null) ? row.get("ip_address").toString() : "";
                    dataRow.createCell(11).setCellValue(ipAddress);
                }

                for (int i = 0; i < columns.length; i++) {
                    sheet.autoSizeColumn(i);
                }
            }
            
            if (workbook.getNumberOfSheets() == 0) workbook.createSheet("No Data");

            SimpleDateFormat fileDateFmt = new SimpleDateFormat("dd-MM-yyyy", Locale.US);
            String currentDate = fileDateFmt.format(new Date());
            String fileName = "รายงานการลงเวลา Check-in_Check-out ของพนักงาน " + currentDate + ".xlsx";
            String encodedFileName = URLEncoder.encode(fileName, "UTF-8");
            
            encodedFileName = encodedFileName.replaceAll("\\+", "%20");

            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=" + encodedFileName);

            workbook.write(response.getOutputStream());
            workbook.close();

            return null;

        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }
    
    private boolean isEmpty(String s) { return s == null || s.trim().isEmpty(); }
    private String toStr(Object v) { return v == null ? "" : String.valueOf(v); }
    
    public String saveWorkLog() {
        try {
        	if (onlineUser == null) {
				return "login";
			}
            String idStr = request.getParameter("id");
            String dateStr = request.getParameter("date");
            String timeStr = request.getParameter("time");
            String type = request.getParameter("type"); 
            String location = request.getParameter("location");
            String description = request.getParameter("description");

            Map<String, String> result = new HashMap<>();
            Gson gson = new Gson();

            // Check ID
            if (idStr == null || idStr.isEmpty()) {
                writeResponse(gson.toJson(Collections.singletonMap("status", "error")));
                return null;
            }

            // Get Data
            Integer id = Integer.parseInt(idStr);
            WorkHours workHours = workLogDAO.findById(id); 

            if (workHours != null) {
                // Date Time 
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm", Locale.US);
                Date newDateTime = sdf.parse(dateStr + " " + timeStr);
                
                // Update
                workHours.setWorkHoursTimeWork(new java.sql.Timestamp(newDateTime.getTime()));
                workHours.setWorkHoursType(type);
                workHours.setWorkType(location); 
                workHours.setDescription(description);
                workHours.setTimeUpdate(new java.sql.Timestamp(System.currentTimeMillis()));
                if (onlineUser != null) {
                    workHours.setUserUpdate(onlineUser.getId());
                }

                // Save
                workLogDAO.update(workHours);
                request.getSession().removeAttribute("CACHED_WORKLOG_LIST");

                result.put("status", "success");
            } else {
                result.put("status", "error");
                result.put("message", "Record not found");
            }

            writeResponse(gson.toJson(result));
            return null;

        } catch (Exception e) {
            e.printStackTrace();
            // If Error 
            try {
                Map<String, String> err = new HashMap<>();
                err.put("status", "error");
                err.put("message", e.toString());
                writeResponse(new Gson().toJson(err));
            } catch (Exception ex) {}
            return null;
        }
    }

    // Helper Method: JSON Response
    private void writeResponse(String json) throws Exception {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
        out.close();
    }
}