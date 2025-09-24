package com.cubesofttech.action;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.HolidayDAO;
import com.cubesofttech.model.Holiday;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;
import com.opensymphony.xwork2.ActionSupport;

public class HolidayAction extends ActionSupport {

    private static final Logger log = Logger.getLogger(HolidayAction.class);
    private static final long serialVersionUID = 1L;

    private static String checkFlag = "";
    private static String Check_add = "";
    private static String dateTime = "";
    private static Calendar cal = Calendar.getInstance();

    @Autowired
    private HolidayDAO holidayDAO;

    HttpServletRequest request = ServletActionContext.getRequest();
    HttpServletResponse response = ServletActionContext.getResponse();

    public String List() {
        long t0 = System.currentTimeMillis();
        request.setAttribute("dbTried", true);
        try {
            checkFlag = "1";

            String yearParam = request.getParameter("year");

 
            List<Object> yearsRaw = holidayDAO.searchallyear();
            Integer fallback = Calendar.getInstance().get(Calendar.YEAR);
            Integer maxYear = null;
            if (yearsRaw != null && !yearsRaw.isEmpty()) {
                for (Object o : yearsRaw) {
                    if (o == null) continue;
                    try {
                        int y = Integer.parseInt(o.toString().trim());
                        if (maxYear == null || y > maxYear) maxYear = y;
                    } catch (NumberFormatException ignore) { 
      
                    }
                }
            }
            if (maxYear == null) maxYear = fallback; 


            boolean showAll = false;
            Integer yearToUse = null;
            if (yearParam == null || yearParam.trim().isEmpty()) {
  
                yearToUse = maxYear;
            } else if ("all".equalsIgnoreCase(yearParam.trim())) {
                showAll = true;
            } else {
                try {
                    yearToUse = Integer.parseInt(yearParam.trim());
                } catch (NumberFormatException nfe) {
                    log.warn("Invalid 'year' param: " + yearParam + " -> fallback to latest year");
                    yearToUse = maxYear;
                }
            }


            List<Holiday> holidayList;
            if (showAll) {
                holidayList = holidayDAO.findAll(); 
                request.setAttribute("selectedYear", "all");
                request.setAttribute("currentYear", null);
                request.setAttribute("isAll", true);
            } else {
                holidayList = holidayDAO.findByYear(yearToUse); 
                request.setAttribute("selectedYear", String.valueOf(yearToUse));
                request.setAttribute("currentYear", yearToUse);
                request.setAttribute("isAll", false);
            }

            // 5) ใส่ attribute ให้ JSP
            request.setAttribute("holidayList", holidayList);
            request.setAttribute("holidayList_year", yearsRaw);
            request.setAttribute("dbOk", true);
            request.setAttribute("rowCount", holidayList == null ? 0 : holidayList.size());

            return SUCCESS;
        } catch (Exception e) {
            log.error("Load Holiday List failed", e);
            request.setAttribute("dbOk", false);
            request.setAttribute("dbError", e.getMessage());
            return ERROR;
        } finally {
            request.setAttribute("elapsedMs", System.currentTimeMillis() - t0);
        }
    }

    public String List1() {
        long t0 = System.currentTimeMillis();
        request.setAttribute("dbTried", true);
        try {
            checkFlag = "0";
            String date = request.getParameter("date");
            String date1 = request.getParameter("date1");

            if (date != null) {
                java.util.Date utilDate = new SimpleDateFormat("dd-MM-yyyy").parse(date);
                java.sql.Date start_date = new java.sql.Date(utilDate.getTime());
                request.setAttribute("flag12", start_date);
            }
            if (date1 != null) {
                request.setAttribute("flag12", date1);
            }

            List<Holiday> holidayList = holidayDAO.findAll();
            request.setAttribute("holidayList", holidayList);

            String flag_cal = request.getParameter("flag");
            if (flag_cal != null) {
                cal = Calendar.getInstance();
            }

            int month = cal.get(Calendar.MONTH);
            int year = cal.get(Calendar.YEAR);
            request.setAttribute("num_month", month);
            request.setAttribute("num_year", year);
            request.setAttribute("dbOk", true);
            request.setAttribute("rowCount", holidayList == null ? 0 : holidayList.size());

            return SUCCESS;
        } catch (Exception e) {
            log.error("Load Holiday List1 failed", e);
            request.setAttribute("dbOk", false);
            request.setAttribute("dbError", e.getMessage());
            return ERROR;
        } finally {
            request.setAttribute("elapsedMs", System.currentTimeMillis() - t0);
        }
    }

    // ------------------- Add -------------------
    public String Add() {
        try {
            int flag = 1;

            User user = (request.getSession(false) != null)
                    ? (User) request.getSession(false).getAttribute("onlineUser")
                    : null;
            String logonUser = (user != null && user.getId() != null) ? user.getId() : "";
//            User user = (User) request.getSession().getAttribute("onlineUser");
//            String logonUser = user.getId();  


            String Date_Start = request.getParameter("Date-Start");
            String Date_End   = request.getParameter("Date-End");
            String name_form  = request.getParameter("name");
            String description_form = request.getParameter("description");

            if (Date_Start != null && Date_Start.trim().equals("--")) Date_Start = "";
            if (Date_End   != null && Date_End.trim().equals("--"))   Date_End   = "";

            if (Date_Start == null || Date_Start.trim().isEmpty() ||
                name_form == null  || name_form.trim().isEmpty()) {
                request.setAttribute("flag", flag);
                request.setAttribute("date", Date_Start);
                request.setAttribute("flag_form", checkFlag);
                return INPUT;
            }
            if (Date_End == null || Date_End.trim().isEmpty()) {
                Date_End = Date_Start; 
            }

            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            sdf.setLenient(false);
            java.sql.Date start_date = new java.sql.Date(sdf.parse(Date_Start).getTime());
            java.sql.Date end_date   = new java.sql.Date(sdf.parse(Date_End).getTime());

            if (start_date.after(end_date)) {
                request.setAttribute("flag", flag);
                request.setAttribute("date", Date_Start);
                request.setAttribute("flag_form", checkFlag);
                return INPUT;
            }


            if (start_date.equals(end_date)) {
                // วันเดียว
                List<Map<String, Object>> dup = holidayDAO.findByDate(start_date);
                if (dup != null && !dup.isEmpty()) {
                    request.setAttribute("flag", flag);
                    request.setAttribute("date", Date_Start);
                    request.setAttribute("flag_form", checkFlag);
                    return INPUT;
                }
            } else {
                // ช่วงวัน
                Holiday probe = new Holiday();
                probe.setStart_date(start_date);
                probe.setEnd_date(end_date);
                List<Holiday> overlap = holidayDAO.protect(probe);
                if (overlap != null && !overlap.isEmpty()) {
                    request.setAttribute("flag", flag);
                    return INPUT;
                }
            }

            Long Id = holidayDAO.getMaxId() + 1;
            Holiday h = new Holiday();
            h.setId_date(Id);
            h.setStart_date(start_date);
            h.setEnd_date(end_date);
            h.setHead(name_form);
            h.setDescription(description_form);
            h.setUser_create(logonUser);
            h.setUser_update(logonUser);
            h.setTime_create(DateUtil.getCurrentTime());
            h.setTime_update(DateUtil.getCurrentTime());

            holidayDAO.save(h);
            return SUCCESS;

        } catch (java.text.ParseException pe) {
            request.setAttribute("flag", 1);
            request.setAttribute("date", request.getParameter("Date-Start"));
            request.setAttribute("flag_form", checkFlag);
            return INPUT;
        } catch (Exception e) {
            Logger.getLogger(HolidayAction.class).error("AddHoliday failed", e);
            return ERROR;
        }
    }


    // ------------------- Edit -------------------
    public String Edit() {
        try {
            String dateid = request.getParameter("id");
            request.setCharacterEncoding("UTF-8");
            request.setAttribute("flag_form", checkFlag);
            int x = Integer.parseInt(dateid);
            Holiday holidayrecord = holidayDAO.findById(x);
            request.setAttribute("holidayrecord", holidayrecord);
            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }

    // ------------------- Update -------------------
    public String Update() {
        try {
            int flag = 1;

            User user = (request.getSession(false) != null)
                    ? (User) request.getSession(false).getAttribute("onlineUser")
                    : null;
            String logonUser = (user != null && user.getId() != null) ? user.getId() : "";

            String idParam       = request.getParameter("id_date");
            String head          = request.getParameter("name");
            String description   = request.getParameter("description");
            String Date_Start    = request.getParameter("Date-Start");
            String Date_End      = request.getParameter("Date-End");

            if (Date_Start != null && Date_Start.trim().equals("--")) Date_Start = "";
            if (Date_End   != null && Date_End.trim().equals("--"))   Date_End   = "";

            if (idParam == null || idParam.trim().isEmpty()) {
                log.warn("Update: missing id_date");
                return ERROR;
            }
            int id = Integer.parseInt(idParam.trim());

            if (Date_Start == null || Date_Start.trim().isEmpty() ||
                head == null || head.trim().isEmpty()) {
                request.setAttribute("flag", flag);
                request.setAttribute("date", Date_Start);
                request.setAttribute("holidayrecord", holidayDAO.findById(id));
                request.setAttribute("flag_form", checkFlag);
                return INPUT;
            }
            if (Date_End == null || Date_End.trim().isEmpty()) {
                Date_End = Date_Start; 
            }

            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            sdf.setLenient(false);
            java.sql.Date start_date = new java.sql.Date(sdf.parse(Date_Start).getTime());
            java.sql.Date end_date   = new java.sql.Date(sdf.parse(Date_End).getTime());

            if (start_date.after(end_date)) {
                request.setAttribute("flag", flag);
                request.setAttribute("date", Date_Start);
                request.setAttribute("holidayrecord", holidayDAO.findById(id));
                request.setAttribute("flag_form", checkFlag);
                return INPUT;
            }

            Holiday holiday = holidayDAO.findById(id);
            if (holiday == null) {
                log.warn("Update: holiday not found id=" + id);
                return ERROR;
            }

            if (start_date.equals(end_date)) {
                List<Map<String, Object>> dup = holidayDAO.findByDate(start_date);
                boolean conflict = false;
                if (dup != null) {
                    for (Map<String, Object> row : dup) {
                        Object idObj = row.get("id_date"); 
                        if (idObj != null && !String.valueOf(id).equals(String.valueOf(idObj))) {
                            conflict = true;
                            break;
                        }
                    }
                }
                if (conflict) {
                    request.setAttribute("flag", flag);
                    request.setAttribute("holidayrecord", holiday);
                    request.setAttribute("flag_form", checkFlag);
                    return INPUT;
                }
            } else {

                Holiday probe = new Holiday();
                probe.setId_date((long) id); 
                probe.setStart_date(start_date);
                probe.setEnd_date(end_date);


                List<Holiday> overlap = holidayDAO.protect_edit(probe);
                if (overlap != null && !overlap.isEmpty()) {
                    request.setAttribute("flag", flag);
                    request.setAttribute("holidayrecord", holiday);
                    request.setAttribute("flag_form", checkFlag);
                    return INPUT;
                }
            }

            holiday.setStart_date(start_date);
            holiday.setEnd_date(end_date);
            holiday.setHead(head);
            holiday.setDescription(description);
            holiday.setUser_update(logonUser);
            holiday.setTime_update(DateUtil.getCurrentTime());

            holidayDAO.update(holiday);

            if ("1".equals(checkFlag)) {
                return SUCCESS;
            } else {
                Calendar cal1 = Calendar.getInstance();
                cal1.setTime(start_date);
                cal = cal1;
                request.setAttribute("flag12", start_date);
                return LOGIN;
            }
        } catch (Exception e) {
            Logger.getLogger(HolidayAction.class).error("UpdateHoliday failed", e);
            return ERROR;
        }
    }

    // ------------------- Delete -------------------
    public String Delete() {
        try {
            String dateid = request.getParameter("id");
            int x = Integer.parseInt(dateid);
            Holiday holiday_delete = holidayDAO.findById(x);
            holidayDAO.delete(holiday_delete);
            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }

    // ------------------- Search -------------------
    public String searchtable() {
        long t0 = System.currentTimeMillis();
        request.setAttribute("dbTried", true);
        try {
            String date_1 = request.getParameter("myselect");
            List<Holiday> holidayList = holidayDAO.searchtable(date_1);
            request.setAttribute("holidayList", holidayList);

            List<Object> holidayList_year = holidayDAO.searchallyear();
            request.setAttribute("holidayList_year", holidayList_year);
            request.setAttribute("myselect", date_1);
            request.setAttribute("dbOk", true);
            request.setAttribute("rowCount", holidayList == null ? 0 : holidayList.size());

            return SUCCESS;
        } catch (Exception e) {
            log.error("Search Holiday table failed", e);
            request.setAttribute("dbOk", false);
            request.setAttribute("dbError", e.getMessage());
            return ERROR;
        } finally {
            request.setAttribute("elapsedMs", System.currentTimeMillis() - t0);
        }
    }

    public String formadd() {
        String flag = request.getParameter("flag");
        String date = request.getParameter("date_cal");

        if (flag.equals("0")) {
            Check_add = "1";
            dateTime = date;
        } else {
            Check_add = "0";
        }

        request.setAttribute("date", date);
        request.setAttribute("flag_form", checkFlag);
        return SUCCESS;
    }

    // ------------------- Find Next Year -------------------
    public void findnext_year() {
        try {
            String next = request.getParameter("year_next");
            List<Holiday> holidayList = holidayDAO.findnext_Year(next);

            JSONArray arrayObj1 = new JSONArray();
            JSONArray arrayObj2 = new JSONArray();
            JSONArray arrayObj3 = new JSONArray();
            JSONArray arrayObj4 = new JSONArray();
            JSONArray arrayObj5 = new JSONArray();

            for (int i = 0; i < holidayList.size(); i++) {
                arrayObj1.put(holidayList.get(i).getId_date());
                arrayObj2.put(holidayList.get(i).head);
                arrayObj3.put(holidayList.get(i).description);
                arrayObj4.put(holidayList.get(i).getStart_date().toString());
                arrayObj5.put(holidayList.get(i).getEnd_date().toString());
            }

            PrintWriter out = response.getWriter();
            JSONObject json = new JSONObject();
            json.put("id", arrayObj1);
            json.put("title", arrayObj2);
            json.put("des", arrayObj3);
            json.put("start", arrayObj4);
            json.put("end", arrayObj5);

            out.print(json);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
