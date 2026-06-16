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

public class WorkLocationAction extends ActionSupport {

	private static final long serialVersionUID = 2280661337420278284L;
	private static final Integer Interger = null;
	Logger log = Logger.getLogger(getClass());
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	public static final String User = "userList";
	public static final String ONLINEUSER = "onlineUser";

	private User onlineUser = (User) request.getSession().getAttribute("onlineUser");
	
	@Autowired
    private WorkLogDAO workLogDAO;
    @Autowired
    private JobsiteDAO jobsiteDAO;
    @Autowired
    private UserDAO userDAO;
    
    // OPEN PAGE 
    public String open() {
        try {
//        	log.debug("Hello WorkLocationAction");
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
    
}