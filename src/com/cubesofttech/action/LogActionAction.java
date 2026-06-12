package com.cubesofttech.action;

import com.cubesofttech.dao.LogActionDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.User;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import com.google.gson.GsonBuilder;

public class LogActionAction extends ActionSupport {

    private static final long serialVersionUID = 1L;

    Logger log = Logger.getLogger(getClass());
    HttpServletRequest request = ServletActionContext.getRequest();

    private User onlineUser = (User) request.getSession().getAttribute("onlineUser");

    @Autowired
    private LogActionDAO logActionDAO;

    @Autowired
    private UserDAO userDAO;

    /**
     * เปิดหน้า Action Log (โหลด userList สำหรับ filter และข้อมูลของปีปัจจุบัน)
     */
    public String open() {
        try {
            if (onlineUser == null) {
                return "login";
            }
            
            java.util.Calendar cal = java.util.Calendar.getInstance();
            int year = cal.get(java.util.Calendar.YEAR);
            String startDate = year + "-01-01";
            String endDate   = year + "-12-31";

            List<Map<String, Object>> userList = userDAO.Query_Userlist();
            request.setAttribute("userList", userList);
            
            request.setAttribute("selectedUserId", "All");
            request.setAttribute("selectedStartDate", startDate);
            request.setAttribute("selectedEndDate", endDate);

            return SUCCESS;
        } catch (Exception e) {
            log.error(e);
            return ERROR;
        }
    }

    /**
     * ค้นหา / แสดงรายการ Action Log (รองรับ AJAX reload)
     */
    public String list() {
        try {
            if (onlineUser == null) {
                return "login";
            }

            // โหลด user list สำหรับ dropdown
            List<Map<String, Object>> userList = userDAO.Query_Userlist();
            request.setAttribute("userList", userList);

            // รับ parameter
            String userId    = request.getParameter("userId");
            String startDate = request.getParameter("startDate");
            String endDate   = request.getParameter("endDate");

            request.setAttribute("selectedUserId", userId != null ? userId : "All");
            request.setAttribute("selectedStartDate", startDate != null ? startDate : "");
            request.setAttribute("selectedEndDate",   endDate   != null ? endDate   : "");

            return SUCCESS;
        } catch (Exception e) {
            log.error(e);
            return ERROR;
        }
    }

    /**
     * ดึงข้อมูล Action Log เป็น JSON สำหรับ AJAX DataTable
     */
    public String listData() {
        try {
            User onlineUser = (User) request.getSession().getAttribute("onlineUser");
            if (onlineUser == null) {
                return "login";
            }

            String userId    = request.getParameter("userId");
            String startDate = request.getParameter("startDate");
            String endDate   = request.getParameter("endDate");

            List<Map<String, Object>> logList = logActionDAO.search(userId, startDate, endDate);

            request.setAttribute("json", new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create().toJson(logList));
            return "json";
        } catch (Exception e) {
            log.error(e);
            return ERROR;
        }
    }
}
