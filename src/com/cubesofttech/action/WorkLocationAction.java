package com.cubesofttech.action;

import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WorkLogDAO;
import com.cubesofttech.model.User;

import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class WorkLocationAction extends ActionSupport {

    private static final long serialVersionUID = 2280661337420278284L;

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

    public String open() {
        try {
            if (onlineUser == null) {
                return "login";
            }

            List<Map<String, Object>> userList = userDAO.Query_Userlist();
            List<Map<String, Object>> siteList = jobsiteDAO.findAll();

            request.setAttribute("userList", userList);
            request.setAttribute("siteList", siteList);

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

    public String search() {
        try {
            if (onlineUser == null) {
                return "login";
            }

            String searchText = request.getParameter("searchText");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String sortting = request.getParameter("sortting");

            String[] siteIds = request.getParameterValues("siteIds");
            String[] actions = request.getParameterValues("actions");

            LocalDate today = LocalDate.now();
            DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("dd-MM-yyyy", Locale.ENGLISH);

            if (startDate == null || startDate.isEmpty()) {
                startDate = today.format(dateFormat);
            }

            if (endDate == null || endDate.isEmpty()) {
                endDate = today.format(dateFormat);
            }

            Map<String, Object> params = new HashMap<>();
            params.put("searchText", searchText);
            params.put("sortting", sortting);
            params.put("startDate", startDate);
            params.put("endDate", endDate);
            params.put("siteIds", siteIds);
            params.put("actions", actions);

            List<Map<String, Object>> workLogList = workLogDAO.searchWorkLocation(params);

            Map<String, Integer> summary = calculateSummary(workLogList);

            Map<String, Object> jsonResponse = new HashMap<>();
            jsonResponse.put("workLogList", workLogList);
            jsonResponse.put("summary", summary);

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
            log.error("Error in WorkLocationAction.search()", e);
            e.printStackTrace();
            return null;
        }
    }

    private Map<String, Integer> calculateSummary(List<Map<String, Object>> list) {
        Map<String, Integer> stats = new HashMap<>();
        stats.put("total", list != null ? list.size() : 0);
        return stats;
    }
}