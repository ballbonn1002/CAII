package com.cubesofttech.action;

import com.cubesofttech.dao.BorrowDAO;
import com.cubesofttech.dao.HolidayDAO;
import com.cubesofttech.dao.LeaveDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WorkLogDAO;
import com.cubesofttech.model.Borrow;
import com.cubesofttech.model.User;
import com.cubesofttech.util.ReportUtil;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;

import net.sf.jasperreports.engine.JasperCompileManager;

public class ReportAction extends ActionSupport {

    private static final long serialVersionUID = 1L;

    Logger log = Logger.getLogger(getClass());
    HttpServletRequest request = ServletActionContext.getRequest();
    HttpServletResponse response = ServletActionContext.getResponse();
    
    public static final String LOGOPATH = "logoPath";
	public static final String JASPERPATH = "/WEB-INF/classes/jasper";
	public static final String IMAGEPATH = "/images";


    private User onlineUser = (User) request.getSession().getAttribute("onlineUser");

    @Autowired
    private UserDAO userDAO;
    @Autowired
    private WorkLogDAO workLogDAO;
    @Autowired
    private LeaveDAO leaveDAO;
    @Autowired
    private HolidayDAO holidayDAO;
    @Autowired
	private BorrowDAO borrowDAO;

    // ====== CONFIG =======
    private static final Set<String> EFFECTIVE_LEAVE_STATUS_IDS =
            new HashSet<>(Arrays.asList("1"));

    private static boolean isSickLeaveTypeName(String leaveTypeName) {
        return leaveTypeName != null && leaveTypeName.trim().equals("ลาป่วย");
    }

    // OPEN PAGE
    public String open() {
        try {
            if (onlineUser == null) {
                return "login";
            }

            // name dropdown
            List<Map<String, Object>> userList = userDAO.Query_Userlist();
            request.setAttribute("userList", userList);

            // default values
            request.setAttribute("defaultUserId", onlineUser.getId());
            request.setAttribute("selectedYear", String.valueOf(Year.now().getValue()));

            return SUCCESS;
        } catch (Exception e) {
            log.error(e);
            return ERROR;
        }
    }

    // RENDER JSP PAGE
    public String listWorking() {
        try {
            if (onlineUser == null) {
                return "login";
            }

            List<Map<String, Object>> userList = userDAO.Query_Userlist();
            request.setAttribute("userList", userList);

            String userId = nvl(request.getParameter("userId"), onlineUser.getId());
            String yearStr = nvl(request.getParameter("year"), String.valueOf(Year.now().getValue()));

            request.setAttribute("defaultUserId", userId);
            request.setAttribute("selectedYear", yearStr);

            // initial values
            request.setAttribute("summaryWorkingDay", 0);
            request.setAttribute("summaryOnTime", 0);
            request.setAttribute("summaryLeave", 0);
            request.setAttribute("summarySickLeave", 0);
            request.setAttribute("summaryHoliday", 0);
            request.setAttribute("summaryLateEarly", 0);
            request.setAttribute("summaryIncomplete", 0);
            request.setAttribute("summaryNoRecord", 0);

            request.setAttribute("ontimePercentage", 0);
            request.setAttribute("leavePercentage", 0);
            request.setAttribute("sickLeavePercentage", 0);
            request.setAttribute("lateEarlyOutPercentage", 0);
            request.setAttribute("incompletePercentage", 0);
            request.setAttribute("noRecordPercentage", 0);

            request.setAttribute("attendanceMap", new HashMap<String, String>());

            return SUCCESS;
        } catch (Exception e) {
            log.error(e);
            return ERROR;
        }
    }

    // DATA
    public String workingDayData() {
        try {
            if (onlineUser == null) {
                return "login";
            }

            String userId = nvl(request.getParameter("userId"), onlineUser.getId());
            int year = Integer.parseInt(nvl(request.getParameter("year"), String.valueOf(Year.now().getValue())));

            String monthParam = nvl(request.getParameter("month"), "0");
            List<Integer> selectedMonths = new ArrayList<>();

            if ("0".equals(monthParam) || monthParam.isEmpty()) {
                for (int i = 1; i <= 12; i++) {
                    selectedMonths.add(i);
                }
            } else {
                String[] parts = monthParam.split(",");
                for (String p : parts) {
                    try {
                        selectedMonths.add(Integer.parseInt(p.trim()));
                    } catch (NumberFormatException e) {
                        log.warn("Invalid month format ignored: " + p);
                    }
                }
            }
            
            User user = userDAO.findById(userId);
            LocalDate empStartDate = null;
            LocalDate empEndDate = null;
            // fillter date working
            if (user != null) {
                if (user.getStartDate() != null) empStartDate = toLocalDate(user.getStartDate());
                if (user.getEndDate() != null) empEndDate = toLocalDate(user.getEndDate());
            }

            AttendanceResult attData = buildAttendanceData(userId, year, empStartDate, empEndDate );
            Summary summary = buildSummary(attData.statusMap, year, selectedMonths, empStartDate, empEndDate);

            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();
            
            out.print(toJson(attData.statusMap, attData.detailsMap, attData.workTypeMap, summary));
            out.flush();

            return NONE;
        } catch (Exception e) {
            log.error(e);
            response.setStatus(500);
            return NONE;
        }
    }

    // ====== Build Attendance Data ======
    private AttendanceResult buildAttendanceData(String userId, int year, LocalDate empStartDate, LocalDate empEndDate) throws Exception {
        AttendanceResult result = new AttendanceResult();

        // WorkLog (year)
        Map<String, Object> params = new HashMap<>();
        params.put("searchText", userId);
        params.put("siteId", "");
        params.put("status", "");
        params.put("sortting", "1");
        params.put("startDate", "01-01-" + year);
        params.put("endDate", "31-12-" + year);

        List<Map<String, Object>> rows = workLogDAO.search(params);

        Map<LocalDate, List<LocalDateTime>> perDay = new HashMap<>();
        Map<LocalDate, Map<String, Object>> anyRowPerDay = new HashMap<>();

        for (Map<String, Object> r : rows) {
            Object tsObj = r.get("work_hours_time_work");
            if (tsObj == null) continue;

            LocalDateTime dt = toLocalDateTime(tsObj);
            LocalDate d = dt.toLocalDate();

            perDay.computeIfAbsent(d, k -> new ArrayList<>()).add(dt);
            anyRowPerDay.putIfAbsent(d, r);
        }

        // Leave of year
        LeaveDays ld = loadLeaveDays(userId, year);
        Map<LocalDate, String> leaveDays = ld.leaveDays;
        Map<LocalDate, String> sickDays = ld.sickDays;

        // Holiday of year
        Set<LocalDate> holidayDays = loadHolidayDays(year);
        
        LocalDate today = LocalDate.now();

        // Build daily status
        for (int m = 1; m <= 12; m++) {
            int dim = YearMonth.of(year, m).lengthOfMonth();
            for (int day = 1; day <= dim; day++) {
                LocalDate date = LocalDate.of(year, m, day);
                String key = m + "_" + day;
                
                if (holidayDays.contains(date)) {
                    result.statusMap.put(key, "Holiday");
                    continue;
                }
                
                // fillter date working
                if (empStartDate != null && date.isBefore(empStartDate)) {
                    continue;
                }
                if (empEndDate != null && date.isAfter(empEndDate)) {
                    continue;
                }

                // data to statusMap and detailsMap 
                if (sickDays.containsKey(date)) {
                    result.statusMap.put(key, "Sick");
                    result.detailsMap.put(key, sickDays.get(date));
                    continue;
                }
                if (leaveDays.containsKey(date)) {
                    result.statusMap.put(key, "Leave");
                    result.detailsMap.put(key, leaveDays.get(date));
                    continue;
                }
                
                if (date.isAfter(today)) {
                    continue; 
                }

                // Data time working
                List<LocalDateTime> logs = perDay.getOrDefault(date, Collections.emptyList());
                if (logs.isEmpty()) {
                    boolean isWeekend = (date.getDayOfWeek() == DayOfWeek.SATURDAY || date.getDayOfWeek() == DayOfWeek.SUNDAY);
                    if (!isWeekend) {
                        result.statusMap.put(key, "NoRecord");
                    }
                    continue;
                }
                
                Map<String, Object> anyRow = anyRowPerDay.getOrDefault(date, Collections.emptyMap());
	             String workType = str(anyRow.get("work_type"));
	             result.workTypeMap.put(key, workType != null ? workType : "null");

                if (logs.size() == 1) {
                    result.statusMap.put(key, "Incomplete");
                    continue;
                }

                LocalTime start = parseUserTime(anyRow.get("work_time_start"));
                if(start!=null) start = start.withSecond(0).withNano(0);
                
                LocalTime end = parseUserTime(anyRow.get("work_time_end"));
                if(end!=null) end = end.withSecond(0).withNano(0);

                logs.sort(Comparator.naturalOrder());
                LocalTime inTime = logs.get(0).toLocalTime().withSecond(0).withNano(0);
                LocalTime outTime = logs.get(logs.size() - 1).toLocalTime().withSecond(0).withNano(0);

                if (start == null || end == null) {
                    result.statusMap.put(key, "Ontime");
                    continue;
                }

                boolean late = inTime.isAfter(start);
                boolean earlyOut = outTime.isBefore(end);

                if (!late && !earlyOut) result.statusMap.put(key, "Ontime");
                else if (late && !earlyOut) result.statusMap.put(key, "Late");
                else if (!late && earlyOut) result.statusMap.put(key, "EarlyOut");
                else result.statusMap.put(key, "Unfinished Work");
            }
        }

        return result;
    }

    // ====== Build Summary ======
    private Summary buildSummary(Map<String, String> attendanceMap, int year, List<Integer> selectedMonths, LocalDate empStartDate, LocalDate empEndDate) {
        Summary s = new Summary();
        LocalDate today = LocalDate.now();

        for (int m : selectedMonths) {
            if (m < 1 || m > 12) continue;

            int dim = YearMonth.of(year, m).lengthOfMonth();
            for (int d = 1; d <= dim; d++) {
                
                LocalDate date = LocalDate.of(year, m, d);
                
                // fillter date working
                if (empStartDate != null && date.isBefore(empStartDate)) {
                    continue;
                }
                if (empEndDate != null && date.isAfter(empEndDate)) {
                    continue;
                }

                String key = m + "_" + d;
                String st = attendanceMap.get(key);
                
                boolean weekend = (date.getDayOfWeek() == DayOfWeek.SATURDAY || date.getDayOfWeek() == DayOfWeek.SUNDAY);

                if (!date.isAfter(today)) {
                    if (!weekend && !"Holiday".equals(st)) {
                        s.workingDay++;
                    }
                }
                
                if ("Ontime".equals(st)) s.ontime++;
                else if ("Leave".equals(st)) s.leave++;
                else if ("Sick".equals(st)) s.sickLeave++;
                else if ("Holiday".equals(st)) s.holiday++;
                else if ("Late".equals(st) || "EarlyOut".equals(st) || "Unfinished Work".equals(st)) s.lateEarlyOut++;
                else if ("Incomplete".equals(st)) s.incomplete++;
                else if ("NoRecord".equals(st)) s.noRecord++;
            }
        }

        s.percent = s.toPercent();
        return s;
    }

      
    // ====== DAO loaders ======
    private static class LeaveDays {
        Map<LocalDate, String> leaveDays = new HashMap<>();
        Map<LocalDate, String> sickDays = new HashMap<>();
    }

    private LeaveDays loadLeaveDays(String userId, int year) throws Exception {
        LeaveDays out = new LeaveDays();

        Timestamp startTs = Timestamp.valueOf(LocalDate.of(year, 1, 1).atStartOfDay());
        Timestamp endTs = Timestamp.valueOf(LocalDate.of(year, 12, 31).atTime(23, 59, 59));

        // form myLeavesList
        List<Map<String, Object>> leaves = leaveDAO.myLeavesList(userId, startTs, endTs);

        for (Map<String, Object> r : leaves) {
            String statusId = str(r.get("leave_status_id"));
            if (!EFFECTIVE_LEAVE_STATUS_IDS.contains(statusId)) continue;

            LocalDate start = toLocalDate(r.get("start_date"));
            LocalDate end = r.get("end_date") != null ? toLocalDate(r.get("end_date")) : start;

            String leaveTypeName = str(r.get("leave_type_name"));
            String startTime = str(r.get("start_time"));
            String endTime = str(r.get("end_time"));
            String halfDay = str(r.get("half_day"));
            
            boolean sick = isSickLeaveTypeName(leaveTypeName);

            // Leave Type
            String statusDetail = leaveTypeName; 
            
            if (halfDay != null && !halfDay.trim().isEmpty() && !"null".equals(halfDay) && !"0".equals(halfDay)) {
                if ("1".equals(halfDay)) {
                    statusDetail += " (เช้า)";
                } else if ("2".equals(halfDay)) {
                    statusDetail += " (บ่าย)";
                } else {
                    statusDetail += " (ครึ่งวัน)";
                }
            } else {
                statusDetail += "";
            }

            // PopOver format
            String timeDetail = "";
            if (startTime != null && !startTime.trim().isEmpty() && !"null".equals(startTime) &&
                endTime != null && !endTime.trim().isEmpty() && !"null".equals(endTime)) {
                
                if (startTime.length() >= 5) startTime = startTime.substring(0, 5);
                if (endTime.length() >= 5) endTime = endTime.substring(0, 5);
                
                timeDetail = "Time: " + startTime + " - " + endTime;
            }

            String detailText = statusDetail;
            if (!timeDetail.isEmpty()) {
                detailText += "<br>" + timeDetail;
            }

            for (LocalDate d = start; !d.isAfter(end); d = d.plusDays(1)) {
                if (sick) out.sickDays.put(d, detailText);
                else out.leaveDays.put(d, detailText);
            }
        }

        return out;
    }

    // Holiday
    private Set<LocalDate> loadHolidayDays(int year) throws Exception {
        Set<LocalDate> days = new HashSet<>();

        List<com.cubesofttech.model.Holiday> holidays = holidayDAO.findByYear(year);
        for (com.cubesofttech.model.Holiday h : holidays) {
        	LocalDate start = toLocalDate(h.getStart_date());
        	LocalDate end = h.getEnd_date() != null ? toLocalDate(h.getEnd_date()) : start;

            for (LocalDate d = start; !d.isAfter(end); d = d.plusDays(1)) {
                days.add(d);
            }
        }

        return days;
    }

    // ====== Helpers ======
    private static String nvl(String a, String b) {
        return (a == null || a.trim().isEmpty()) ? b : a.trim();
    }

    private static String str(Object o) {
        return o == null ? null : String.valueOf(o);
    }

    private static LocalDateTime toLocalDateTime(Object tsObj) {
        if (tsObj instanceof java.sql.Timestamp) {
            return ((java.sql.Timestamp) tsObj).toLocalDateTime();
        }
        if (tsObj instanceof java.util.Date) {
            return Instant.ofEpochMilli(((java.util.Date) tsObj).getTime())
                    .atZone(ZoneId.systemDefault())
                    .toLocalDateTime();
        }
        // fallback
        return LocalDateTime.parse(String.valueOf(tsObj));
    }

    private static LocalTime parseUserTime(Object o) {
        if (o == null) return null;

        String t = String.valueOf(o).trim();
        if (t.isEmpty()) return null;

        // support: 9:00, 09:00, 8:30, 08:30, 9:00:00, 09:00:00
        DateTimeFormatter[] fmts = new DateTimeFormatter[] {
            DateTimeFormatter.ofPattern("H:mm"),
            DateTimeFormatter.ofPattern("HH:mm"),
            DateTimeFormatter.ofPattern("H:mm:ss"),
            DateTimeFormatter.ofPattern("HH:mm:ss")
        };

        for (DateTimeFormatter f : fmts) {
            try {
                return LocalTime.parse(t, f).withSecond(0).withNano(0);
            } catch (Exception ignore) { }
        }

        // normalize time
        String[] parts = t.split(":");
        if (parts.length >= 2) {
            String hh = parts[0].length() == 1 ? "0" + parts[0] : parts[0];
            String mm = parts[1].length() == 1 ? "0" + parts[1] : parts[1];
            String ss = (parts.length >= 3)
                ? (parts[2].length() == 1 ? "0" + parts[2] : parts[2])
                : null;

            String norm = (ss == null) ? (hh + ":" + mm) : (hh + ":" + mm + ":" + ss);

            try { return LocalTime.parse(norm, DateTimeFormatter.ofPattern("HH:mm")).withSecond(0).withNano(0); } catch (Exception ignore) {}
            try { return LocalTime.parse(norm, DateTimeFormatter.ofPattern("HH:mm:ss")).withSecond(0).withNano(0); } catch (Exception ignore) {}
        }

        return null;
    }

    private static LocalDate toLocalDate(Object dateObj) {
        if (dateObj == null) return null;

        if (dateObj instanceof java.sql.Timestamp) {
            return ((java.sql.Timestamp) dateObj).toLocalDateTime().toLocalDate();
        }
        if (dateObj instanceof java.sql.Date) {
            return ((java.sql.Date) dateObj).toLocalDate();
        }
        if (dateObj instanceof java.util.Date) {
            return Instant.ofEpochMilli(((java.util.Date) dateObj).getTime())
                    .atZone(ZoneId.systemDefault())
                    .toLocalDate();
        }

        // fallback string: "2026-02-05 00:00:00.0" / "2026-02-05"
        String s = String.valueOf(dateObj);
        if (s.length() >= 10) s = s.substring(0, 10);
        return LocalDate.parse(s);
    }

    private static String toJson(Map<String, String> attendanceMap, Map<String, String> detailsMap, Map<String, String> workTypeMap, Summary summary) {
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("\"summary\":").append(summary.toJson()).append(",");
        
        // convert  attendanceMap
        sb.append("\"attendanceMap\":{");
        boolean first = true;
        for (Map.Entry<String, String> e : attendanceMap.entrySet()) {
            if (!first) sb.append(",");
            first = false;
            sb.append("\"").append(e.getKey()).append("\":\"").append(e.getValue()).append("\"");
        }
        sb.append("},");

        // convert detailsMap for Popover
        sb.append("\"detailsMap\":{");
        first = true;
        for (Map.Entry<String, String> e : detailsMap.entrySet()) {
            if (!first) sb.append(",");
            first = false;
            // prevent quotation marks from breaking in JSON
            String safeDetail = e.getValue() != null ? e.getValue().replace("\"", "\\\"") : "";
            sb.append("\"").append(e.getKey()).append("\":\"").append(safeDetail).append("\"");
        }
        sb.append("},");
        
        sb.append("\"workTypeMap\":{");
        boolean firstType = true;
        for (Map.Entry<String, String> e : workTypeMap.entrySet()) {
            if (!firstType) sb.append(",");
            firstType = false;
            sb.append("\"").append(e.getKey()).append("\":\"").append(e.getValue()).append("\"");
        }
        sb.append("}");

        sb.append("}");
        return sb.toString();
    }
    
    static class AttendanceResult {
        public Map<String, String> statusMap = new HashMap<>();
        public Map<String, String> detailsMap = new HashMap<>();
        public Map<String, String> workTypeMap = new HashMap<>();
    }

    // ====== DTOs ======
    static class Summary {
        public int workingDay;
        public int ontime;
        public int leave;
        public int sickLeave;
        public int holiday;
        public int lateEarlyOut;
        public int incomplete;
        public int noRecord;
        public Percent percent;

        public Percent toPercent() {
            int base = ontime + leave + sickLeave + lateEarlyOut + incomplete + noRecord;
            if (base <= 0) {
                return new Percent(); 
            }

            Percent p = new Percent();
            
            p.ontime = roundPct(ontime, base);
            p.leave = roundPct(leave, base);
            p.sickLeave = roundPct(sickLeave, base);
            p.lateEarlyOut = roundPct(lateEarlyOut, base);
            p.incomplete = roundPct(incomplete, base);
            p.noRecord = roundPct(noRecord, base);

            int total = p.ontime + p.leave + p.sickLeave + p.lateEarlyOut + p.incomplete + p.noRecord;
            if (total != 100) {
                int diff = 100 - total;
                int maxVal = p.ontime;
                
                String maxKey = "ontime";
                if (p.leave > maxVal) { maxVal = p.leave; maxKey = "leave"; }
                if (p.sickLeave > maxVal) { maxVal = p.sickLeave; maxKey = "sickLeave"; }
                if (p.lateEarlyOut > maxVal) { maxVal = p.lateEarlyOut; maxKey = "lateEarlyOut"; }
                if (p.incomplete > maxVal) { maxVal = p.incomplete; maxKey = "incomplete"; }
                if (p.noRecord > maxVal) { maxVal = p.noRecord; maxKey = "noRecord"; }

                switch (maxKey) {
                    case "ontime": p.ontime += diff; break;
                    case "leave": p.leave += diff; break;
                    case "sickLeave": p.sickLeave += diff; break;
                    case "lateEarlyOut": p.lateEarlyOut += diff; break;
                    case "incomplete": p.incomplete += diff; break;
                    case "noRecord": p.noRecord += diff; break;
                }
            }
            
            return p;
        }

        private int roundPct(int a, int base) {
            return (int) Math.round((a * 100.0) / base);
        }

        public String toJson() {
            if (percent == null) percent = toPercent();
            return "{"
                    + "\"workingDay\":" + workingDay + ","
                    + "\"ontime\":" + ontime + ","
                    + "\"leave\":" + leave + ","
                    + "\"sickLeave\":" + sickLeave + ","
                    + "\"holiday\":" + holiday + ","
                    + "\"lateEarlyOut\":" + lateEarlyOut + ","
                    + "\"incomplete\":" + incomplete + ","
                    + "\"noRecord\":" + noRecord + ","
                    + "\"percent\":" + percent.toJson()
                    + "}";
        }
    }

    static class Percent {
        public int ontime;
        public int leave;
        public int sickLeave;
        public int lateEarlyOut;
        public int incomplete;
        public int noRecord;

        public String toJson() {
            return "{"
                    + "\"ontime\":" + ontime + ","
                    + "\"leave\":" + leave + ","
                    + "\"sickLeave\":" + sickLeave + ","
                    + "\"lateEarlyOut\":" + lateEarlyOut + ","
                    + "\"incomplete\":" + incomplete + ","
                    + "\"noRecord\":" + noRecord
                    + "}";
        }
    }
    
    public String borrowReport() throws IOException {
    	User onlineUser = (User) request.getSession().getAttribute("onlineUser");
		if (onlineUser == null) {
			return ERROR;
		}
		
        ServletContext context = request.getServletContext();
        String borrowId = request.getParameter("borrowId");
        String jasperPath = context.getRealPath(JASPERPATH);
        String imagePath = context.getRealPath(IMAGEPATH);
        String serverPath = context.getRealPath("/");
        
        Map<String, Object> reportParameter = new HashMap<>();
        
        File logo = new File(imagePath + "/logo_cubesofttech.png");
        BufferedImage logoimage = ImageIO.read(logo);
        reportParameter.put(LOGOPATH, logoimage);
        reportParameter.put("borrowId", borrowId);
        
        try {
            Borrow borrow = borrowDAO.findById(Integer.parseInt(borrowId));
            
            if (borrow != null) {
                User deliveryUser = borrow.getUser_delivery() != null ? userDAO.findById(borrow.getUser_delivery()) : null;
                User receiveUser = borrow.getUser_receive() != null ? userDAO.findById(borrow.getUser_receive()) : null;
                User returnUser = borrow.getUser_return() != null ? userDAO.findById(borrow.getUser_return()) : null;
                User returnRecUser = borrow.getUser_return_receive() != null ? userDAO.findById(borrow.getUser_return_receive()) : null;
                
                // โหลดลายเซ็นแต่ละคน
                reportParameter.put("deliverySignature",       loadSignatureImage(serverPath, deliveryUser));
                reportParameter.put("receiveSignature",        loadSignatureImage(serverPath, receiveUser));
                reportParameter.put("returnSignature",         loadSignatureImage(serverPath, returnUser));
                reportParameter.put("returnReceiveSignature",  loadSignatureImage(serverPath, returnRecUser));
            }

        } catch (Exception e) {
            log.debug("Error loading signatures: " + e.getMessage());
        }

        try {
//        	compile PDF
//        	log.debug("JRXML PATH = " + jasperPath + "/borrowReport.jrxml");
//        	System.out.println("JASPER PATH = " + jasperPath + "/borrowReport.jasper");
//        	
//            JasperCompileManager.compileReportToFile(
//                jasperPath + "/borrowReport.jrxml",
//                jasperPath + "/borrowReport.jasper"
//            );
//            
//            File jasperFile = new File(jasperPath + "/borrowReport.jasper");
//
//            System.out.println("Jasper exists = " + jasperFile.exists());
//            log.debug("Jasper absolute path = " + jasperFile.getAbsolutePath());

            ReportUtil.printReportToBrowsePdf(
                jasperPath + "/",
                "borrowReport",
                "borrowReport.pdf",
                reportParameter,
                request,
                response
            );
        } catch (Exception e) {
            log.debug(e);
        }

        return null;
    }

    // Helper method โหลดรูปลายเซ็นจาก User
    private BufferedImage loadSignatureImage(String serverPath, User user) {
        if (user == null || user.getPathSignature() == null) {
            return null;
        }

        String pathSignature = user.getPathSignature().trim();
        if (pathSignature.isEmpty()) {
            return null;
        }

        try {
            File f = new File(serverPath + pathSignature);

            if (f.exists()) {
                return ImageIO.read(f);
            } else {
                log.debug("Signature file not found: " + f.getAbsolutePath());
                return null;
            }

        } catch (Exception e) {
            log.debug("Error loading signature: " + e.getMessage());
            return null;
        }
    }
}