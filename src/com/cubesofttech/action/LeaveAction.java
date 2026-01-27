package com.cubesofttech.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Year;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAccessor;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.HolidayDAO;
import com.cubesofttech.dao.LeaveDAO;
import com.cubesofttech.dao.RoleAuthorizedObjectDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.Holiday;
import com.cubesofttech.model.Leaves;
import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.dao.LeaveTypeDAO;
import com.cubesofttech.dao.LeaveUserDAO;
//import com.cubesofttech.dao.TimesheetDAO;
//import com.cubesofttech.mail.EmailService;
//import com.cubesofttech.model.Department;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.LeaveType;
//import com.cubesofttech.model.ProjectFunction;
import com.cubesofttech.model.Role;
import com.cubesofttech.model.RoleAuthorizedObject;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.cubesofttech.util.FileUtil;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ibm.icu.util.RangeValueIterator.Element;
import com.opensymphony.xwork2.ActionSupport;

public class LeaveAction extends ActionSupport {
	private static final Integer Interger = null;
	private static final long serialVersionUID = 2280661337420278284L;
	Logger log = Logger.getLogger(getClass());
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	
	private static String check_flag = "";
	private static String Global_flag = "";
	public static final String TYPELEAVE = "leave_type_id";
	public static final String NODAY = "no_day";
	public static final String STATUS = "leave_status_id";
	
	@Autowired
	private LeaveDAO leaveDAO;

	@Autowired
	private LeaveTypeDAO leavetypeDAO;

	@Autowired
	private LeaveUserDAO leaveuserDAO;

	@Autowired
	private HolidayDAO holidayDAO;

	@Autowired
	private RoleAuthorizedObjectDAO roleAuthorizedObjectDAO;

	@Autowired
	private UserDAO userDAO;

	@Autowired
	public FileUploadDAO fileuploadDAO;

	List<Leaves> modalLeaveList;
	private String roleId;

	private Leaves leave;

	private int leaveId;

	private String leaveTypeId;

	private Role role;

	public Leaves getLeaves() {
		return leave;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public void setLeave(Leaves leave) {
		this.leave = leave;
	}

	public int getLeaveId() {
		return leaveId;
	}

	public void setLeaveId(int leaveId) {
		this.leaveId = leaveId;
	}

	private String user;

	private String userId;

	private String userList;

	public String getUserList() {
		return userList;
	}

	public void setUserList(String userList) {
		this.userList = userList;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public List<User> leader;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public List<User> getLeader() {
		return leader;
	}

	public void setLeader(List<User> leader) {
		this.leader = leader;
	}

	public List<Map<String, Object>> approve;

	private String id;

	public List<Map<String, Object>> getApprove() {
		return approve;
	}

	public void setApprove(List<Map<String, Object>> approve) {
		this.approve = approve;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	private InputStream excelStream; // variable output stream

	private String excelFileName; // download file name

	private String leaveType;

	private String from;

	private String to;

	private String time_from;

	private String time_to;

	private String amount;

	private String amount_sub;

	private String halfDay;

	private String description;

	private String approver;

	private String status;

	private String reason;

	private String user_hidden;

	private String leaveId_hidden;

	private String approver_hidden;

	private String status_hidden;

	private String to_hidden;

	private String amount_hidden;

	private String amount_sub_hidden;

	private File fileUpload;

	private String fileUploadSize;

	private String fileUploadFileName;

	private String fileUploadId;

	private List<Object[]> summaryData;
	
	private String deleteFileId;
	
	public String getDeleteFileId() {
		return deleteFileId;
	}

	public void setDeleteFileId(String deleteFileId) {
		this.deleteFileId = deleteFileId;
	}

	public InputStream getExcelStream() {
		return excelStream;
	}

	public void setExcelStream(InputStream excelStream) {
		this.excelStream = excelStream;
	}

	public String getExcelFileName() {
		return excelFileName;
	}

	public void setExcelFileName(String excelFileName) {
		this.excelFileName = excelFileName;
	}

	public File getFileUpload() {
		return fileUpload;
	}

	public void setFileUpload(File fileUpload) {
		this.fileUpload = fileUpload;
	}

	public String getFileUploadSize() {
		return fileUploadSize;
	}

	public void setFileUploadSize(String fileUploadSize) {
		this.fileUploadSize = fileUploadSize;
	}

	public String getFileUploadFileName() {
		return fileUploadFileName;
	}

	public void setFileUploadFileName(String fileUploadFileName) {
		this.fileUploadFileName = fileUploadFileName;
	}

	public String getFileUploadId() {
		return fileUploadId;
	}

	public void setFileUploadId(String fileUploadId) {
		this.fileUploadId = fileUploadId;
	}

	public String getLeaveType() {
		return leaveType;
	}

	public void setLeaveType(String leaveType) {
		this.leaveType = leaveType;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public String getTime_from() {
		return time_from;
	}

	public void setTime_from(String time_from) {
		this.time_from = time_from;
	}

	public String getTime_to() {
		return time_to;
	}

	public void setTime_to(String time_to) {
		this.time_to = time_to;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getAmount_sub() {
		return amount_sub;
	}

	public void setAmount_sub(String amount_sub) {
		this.amount_sub = amount_sub;
	}

	public String getHalfDay() {
		return halfDay;
	}

	public void setHalfDay(String halfDay) {
		this.halfDay = halfDay;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getApprover() {
		return approver;
	}

	public void setApprover(String approver) {
		this.approver = approver;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getUser_hidden() {
		return user_hidden;
	}

	public void setUser_hidden(String user_hidden) {
		this.user_hidden = user_hidden;
	}

	public String getLeaveId_hidden() {
		return leaveId_hidden;
	}

	public void setLeaveId_hidden(String leaveId_hidden) {
		this.leaveId_hidden = leaveId_hidden;
	}

	public String getApprover_hidden() {
		return approver_hidden;
	}

	public void setApprover_hidden(String approver_hidden) {
		this.approver_hidden = approver_hidden;
	}

	public String getStatus_hidden() {
		return status_hidden;
	}

	public void setStatus_hidden(String status_hidden) {
		this.status_hidden = status_hidden;
	}

	public String getTo_hidden() {
		return to_hidden;
	}

	public void setTo_hidden(String to_hidden) {
		this.to_hidden = to_hidden;
	}

	public String getAmount_hidden() {
		return amount_hidden;
	}

	public void setAmount_hidden(String amount_hidden) {
		this.amount_hidden = amount_hidden;
	}

	public String getAmount_sub_hidden() {
		return amount_sub_hidden;
	}

	public void setAmount_sub_hidden(String amount_sub_hidden) {
		this.amount_sub_hidden = amount_sub_hidden;
	}

	public String New_list() {
		try {
			User ur = (User) request.getSession().getAttribute("onlineUser");
			String userLogin = ur.getId();
			HttpSession session = request.getSession();
			String listbyuser = request.getParameter("Id");
			log.debug(listbyuser);
			if (userLogin != listbyuser) {
				listbyuser = userLogin;
			}
			String user_role = ur.getRoleId();
			log.debug(user_role);
			request.setAttribute("user_role", user_role);
			List<RoleAuthorizedObject> role_authorized = roleAuthorizedObjectDAO.findLeaveViewAllByRoleId(user_role);

			// User list in dropdown
			List<Map<String, Object>> userseq = userDAO.sequense();
			request.setAttribute("userseq", userseq);
			List<Map<String, Object>> userseqTeam = userDAO.sequense_userinteam(userLogin);
			request.setAttribute("userseqTeam", userseqTeam);

			List<Map<String, Object>> leave = leaveDAO.listoneperson(listbyuser);
			request.setAttribute("leave", leave);
			Double ThisYear = leaveDAO.ThisYearQuota(userLogin);
			request.setAttribute("ThisYear", ThisYear);
			List<Map<String, Object>> leavenameList = leaveDAO.findLeave();
			request.setAttribute("leavenameList", leavenameList);
			Date day = new Date();
			LocalDate localdate = day.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			Double LastYear = leaveDAO.LastYearQuota(userLogin, localdate.getYear());
			request.setAttribute("LastYear", LastYear);
			Timestamp start_date = DateUtil.dateToTimestamp("01-01-" + DateUtil.getYear(), "00:00");
			Timestamp end_date = DateUtil.dateToTimestamp("31-12-" + DateUtil.getYear(), "00:00");

			List<Map<String, Object>> userleave = null;
			if (role_authorized != null) {
				userleave = leaveDAO.findUserAllLeave(start_date, end_date);
				//log.debug("have role");
				request.setAttribute("role_authorized", "1");
				request.setAttribute("leaveList", leaveDAO.searchtableAll(start_date, end_date));

			} else {
				userleave = leaveDAO.findLeaveInTeamByManager(start_date, end_date, userLogin);
				log.debug("doesn't have role");
				request.setAttribute("role_authorized", "0");
				request.setAttribute("leaveList", leaveDAO.findLeaveInTeamByManager(start_date, end_date, userLogin));

			}
			//log.debug(request.getAttribute("leaveList"));
			request.setAttribute("userleave", userleave);
			BigDecimal LeavenumT1 = new BigDecimal(0);
			BigDecimal LeavenumT2 = new BigDecimal(0);
			BigDecimal LeavenumT3 = new BigDecimal(0);
			BigDecimal LeavenumT4 = new BigDecimal(0);
			BigDecimal LeavenumT5 = new BigDecimal(0);
			BigDecimal LeavenumT6 = new BigDecimal(0);
			BigDecimal LeavenumT7 = new BigDecimal(0);
			BigDecimal LeavenumT9 = new BigDecimal(0);

			BigDecimal LeaveWAnumT1 = new BigDecimal(0);
			BigDecimal LeaveWAnumT2 = new BigDecimal(0);
			BigDecimal LeaveWAnumT3 = new BigDecimal(0);
			BigDecimal LeaveWAnumT4 = new BigDecimal(0);
			BigDecimal LeaveWAnumT5 = new BigDecimal(0);
			BigDecimal LeaveWAnumT6 = new BigDecimal(0);
			BigDecimal LeaveWAnumT7 = new BigDecimal(0);
			BigDecimal LeaveWAnumT9 = new BigDecimal(0);

			for (int i = 0; i < userleave.size(); i++) {
				Character type = (Character) userleave.get(i).get(TYPELEAVE);
				BigDecimal num = (BigDecimal) userleave.get(i).get(NODAY);
				Character status = (Character) userleave.get(i).get(STATUS);
				//log.debug(type + "  " + num);

				switch (status) {
				case '0':
					switch (type) {
					case '1':
						LeaveWAnumT1 = num.add(LeaveWAnumT1);
						break;
					case '2':
						LeaveWAnumT2 = num.add(LeaveWAnumT2);
						break;
					case '3':
						LeaveWAnumT3 = num.add(LeaveWAnumT3);
						break;
					case '4':
						LeaveWAnumT4 = num.add(LeaveWAnumT4);
						break;
					case '5':
						LeaveWAnumT5 = num.add(LeaveWAnumT5);
						break;
					case '6':
						LeaveWAnumT6 = num.add(LeaveWAnumT6);
						break;
					case '7':
						LeaveWAnumT7 = num.add(LeaveWAnumT7);
						break;
					case '9':
						LeaveWAnumT9 = num.add(LeaveWAnumT9);
						break;
					}
					break;
				case '1':
					switch (type) {
					case '1':
						LeavenumT1 = num.add(LeavenumT1);
						break;
					case '2':
						LeavenumT2 = num.add(LeavenumT2);
						break;
					case '3':
						LeavenumT3 = num.add(LeavenumT3);
						break;
					case '4':
						LeavenumT4 = num.add(LeavenumT4);
						break;
					case '5':
						LeavenumT5 = num.add(LeavenumT5);
						break;
					case '6':
						LeavenumT6 = num.add(LeavenumT6);
						break;
					case '7':
						LeavenumT7 = num.add(LeavenumT7);
						break;
					case '9':
						LeavenumT9 = num.add(LeavenumT9);
						break;
					}
					break;
				default:
					break;
				}
			}

			request.setAttribute("start_date", start_date);

			//log.debug(start_date + " userleave " + end_date);
			//log.debug("*****************************");

			request.setAttribute("LeavenumT1", LeavenumT1);
			request.setAttribute("LeaveWAnumT1", LeaveWAnumT1);
			request.setAttribute("LeavenumT2", LeavenumT2);
			request.setAttribute("LeaveWAnumT2", LeaveWAnumT2);
			request.setAttribute("LeavenumT3", LeavenumT3);
			request.setAttribute("LeaveWAnumT3", LeaveWAnumT3);
			request.setAttribute("LeavenumT4", LeavenumT4);
			request.setAttribute("LeaveWAnumT4", LeaveWAnumT4);
			request.setAttribute("LeavenumT5", LeavenumT5);
			request.setAttribute("LeaveWAnumT5", LeaveWAnumT5);
			request.setAttribute("LeavenumT6", LeavenumT6);
			request.setAttribute("LeaveWAnumT6", LeaveWAnumT6);
			request.setAttribute("LeavenumT7", LeavenumT7);
			request.setAttribute("LeaveWAnumT7", LeaveWAnumT7);
			request.setAttribute("LeavenumT9", LeavenumT9);
			request.setAttribute("LeaveWAnumT9", LeaveWAnumT9);

			request.setAttribute("leavetypeList", leavetypeDAO.findAll2());
			request.setAttribute("leaveuserList", leaveuserDAO.findAll());
			request.setAttribute("userList", userDAO.findAll());
			request.setAttribute("logonUser", userLogin);
			request.setAttribute("userS", userLogin);
			request.setAttribute("flag_search", "0");

			List<LeaveType> type_leave = leavetypeDAO.findAll();
			request.setAttribute("leavetypelistChoice", type_leave);
			request.setAttribute("type_1", type_leave.get(0).getLeaveTypeName());
			request.setAttribute("type_2", type_leave.get(1).getLeaveTypeName());
			request.setAttribute("type_3", type_leave.get(2).getLeaveTypeName());
			request.setAttribute("type_4", type_leave.get(3).getLeaveTypeName());
			request.setAttribute("type_5", type_leave.get(4).getLeaveTypeName());
			request.setAttribute("type_6", type_leave.get(5).getLeaveTypeName());
			request.setAttribute("type_7", type_leave.get(6).getLeaveTypeName());
			request.setAttribute("type_9", type_leave.get(7).getLeaveTypeName());
			New_myleave();

			//Summary Leave - For Add Leave Page
			request.getSession().setAttribute("type_1", type_leave.get(0).getLeaveTypeName());
			request.getSession().setAttribute("type_2", type_leave.get(1).getLeaveTypeName());
			request.getSession().setAttribute("type_3", type_leave.get(2).getLeaveTypeName());
			request.getSession().setAttribute("type_4", type_leave.get(3).getLeaveTypeName());
			request.getSession().setAttribute("type_5", type_leave.get(4).getLeaveTypeName());
			request.getSession().setAttribute("type_6", type_leave.get(5).getLeaveTypeName());
			request.getSession().setAttribute("type_7", type_leave.get(6).getLeaveTypeName());
			
			log.debug("leave for admin");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String New_searchleaveapproved() {
		try {
			String userSelect = request.getParameter("name1");
			String userSelect2 = request.getParameter("name2");
			String leaveStatus = request.getParameter("appr");
			String startdate = request.getParameter("startdate");
			String enddate = request.getParameter("enddate");
			String leaveType = request.getParameter("type");
			log.debug(userSelect+"/"+userSelect2);
			log.debug(leaveStatus);
			log.debug(leaveType);

			User ur = (User) request.getSession().getAttribute("onlineUser");
			String userLogin = ur.getId();
			request.setAttribute("logonUser", userLogin);
			
			log.debug(userLogin);

			String user_role = ur.getRoleId();
			log.debug("user_role: " + user_role);
			request.setAttribute("user_role", user_role);

			DateTimeFormatter date1 = DateTimeFormatter.ofPattern("01-01-yyyy");
			LocalDate localDate = LocalDate.now();
			String s = "00:00:00.0";

			String start = request.getParameter("startdate");
			String end = request.getParameter("enddate");
			Timestamp start_date;
			Timestamp end_date;

			if (start == null && end == null) {
				start_date = DateUtil.dateToTimestamp(date1.format(localDate), s);
				end_date = DateUtil.changetoEndYear(date1.format(localDate));
			} else {
				start_date = DateUtil.dateFormatEdit(start);
				end_date = DateUtil.dateFormatEdit(end);
			}
			
			List<Map<String, Object>> leaveList = null;
			if((!userSelect.isEmpty() || userSelect != null) && (userSelect2.isEmpty() || userSelect2 == null)) {
				log.debug("all");		
				if (userSelect.equalsIgnoreCase("All")) { //if choose "All Employee"
					request.setAttribute("role_authorized", "1");
					userLogin = null;
					log.debug(start_date+"/"+end_date+"/"+userLogin+"/"+leaveStatus+"/"+leaveType);
					leaveList = leaveDAO.findLeaveInTeamByManagerAndType(start_date, end_date, userLogin, leaveStatus, leaveType);

				} else {	//if choose "All Manage"
					request.setAttribute("role_authorized", "0");
					log.debug(start_date+"/"+end_date+"/"+userLogin+"/"+leaveStatus+"/"+leaveType);
					leaveList = leaveDAO.findLeaveInTeamByManagerAndType(start_date, end_date, userLogin, leaveStatus, leaveType);
				}

			} else if((!userSelect.isEmpty() || userSelect != null) && (!userSelect2.isEmpty() || userSelect2 != null)) {
				log.debug("1 user");
				if (userSelect.equalsIgnoreCase("All")) {	//if choose "All Employee"
					request.setAttribute("role_authorized", "1");
					log.debug(start_date+"/"+end_date+"/"+userSelect2+"/"+leaveStatus+"/"+leaveType);
					leaveList = leaveDAO.findUserLeaveByTypeAndStatus(start_date, end_date, userSelect2, leaveStatus, leaveType);
				} else {	//if choose "All Manage"
					request.setAttribute("role_authorized", "0");
					log.debug(start_date+"/"+end_date+"/"+userSelect2+"/"+leaveStatus+"/"+leaveType);
					leaveList = leaveDAO.findUserLeaveByTypeAndStatus(start_date, end_date, userSelect2, leaveStatus, leaveType);
				}

			}
			request.setAttribute("leaveList", leaveList);
			
			log.debug(request.getAttribute("leaveList"));
			log.debug(leaveStatus);
			log.debug(startdate + "/" + enddate);
			log.debug(userSelect + "/" + userSelect2);
			Date day = new Date();
			LocalDate localdate = day.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			List<Map<String, Object>> userleave = null;
			BigDecimal quota_1 = null;
			BigDecimal quota_2 = null;
			BigDecimal quota_3 = null;
			BigDecimal quota_4 = null;
			if ("All".equals(userSelect) && userSelect2.equals("")) {
				userleave = leaveDAO.findUserAllLeave(start_date, end_date);
			} else if ("All".equals(userSelect) && !userSelect2.equals("")) {
				userleave = leaveDAO.findUserLeave(userSelect2, start_date, end_date);
				Double LastYear = leaveDAO.LastYearQuota(userSelect2, localdate.getYear());
				request.setAttribute("LastYear", LastYear);
				// Double ThisYear = leaveDAO.ThisYearQuota(userSelect2);
				// request.setAttribute("ThisYear", ThisYear);
				log.debug("lastyear: " + LastYear);
				// log.debug("thisyear: "+ThisYear);
				quota_1 = userDAO.findById(userSelect2).getLeaveQuota1();
				quota_2 = userDAO.findById(userSelect2).getLeaveQuota2();
				quota_3 = userDAO.findById(userSelect2).getLeaveQuota3();
				quota_4 = userDAO.findById(userSelect2).getLeaveQuota4();
			} else if ("All2".equals(userSelect) && userSelect2.equals("")) {
				userleave = leaveDAO.findUserAllLeaveInTeam(start_date, end_date, userLogin);
			} else {
				userleave = leaveDAO.findUserLeave(userSelect2, start_date, end_date);
				Double LastYear = leaveDAO.LastYearQuota(userSelect2, localdate.getYear());
				request.setAttribute("LastYear", LastYear);
				// Double ThisYear = leaveDAO.ThisYearQuota(userSelect2);
				// request.setAttribute("ThisYear", ThisYear);
				log.debug("lastyear: " + LastYear);
				// log.debug("thisyear: "+ThisYear);
				quota_1 = userDAO.findById(userSelect2).getLeaveQuota1();
				quota_2 = userDAO.findById(userSelect2).getLeaveQuota2();
				quota_3 = userDAO.findById(userSelect2).getLeaveQuota3();
				quota_4 = userDAO.findById(userSelect2).getLeaveQuota4();
			}
			request.setAttribute("userleave", userleave);
			request.setAttribute("quota_1", quota_1);
			request.setAttribute("quota_2", quota_2);
			request.setAttribute("quota_3", quota_3);
			request.setAttribute("quota_4", quota_4);
			log.debug(userSelect2 + " quota: " + quota_1);
			BigDecimal LeavenumT1 = new BigDecimal(0);
			BigDecimal LeavenumT2 = new BigDecimal(0);
			BigDecimal LeavenumT3 = new BigDecimal(0);
			BigDecimal LeavenumT4 = new BigDecimal(0);
			BigDecimal LeavenumT5 = new BigDecimal(0);
			BigDecimal LeavenumT6 = new BigDecimal(0);
			BigDecimal LeavenumT7 = new BigDecimal(0);
			BigDecimal LeavenumT9 = new BigDecimal(0);

			BigDecimal LeaveWAnumT1 = new BigDecimal(0);
			BigDecimal LeaveWAnumT2 = new BigDecimal(0);
			BigDecimal LeaveWAnumT3 = new BigDecimal(0);
			BigDecimal LeaveWAnumT4 = new BigDecimal(0);
			BigDecimal LeaveWAnumT5 = new BigDecimal(0);
			BigDecimal LeaveWAnumT6 = new BigDecimal(0);
			BigDecimal LeaveWAnumT7 = new BigDecimal(0);
			BigDecimal LeaveWAnumT9 = new BigDecimal(0);

			for (int i = 0; i < userleave.size(); i++) {
				Character type = (Character) userleave.get(i).get(TYPELEAVE);
				BigDecimal num = (BigDecimal) userleave.get(i).get(NODAY);
				Character status = (Character) userleave.get(i).get(STATUS);
				// log.debug(type + " " + num);

				try {
					switch (status) {
					case '0':
						switch (type) {
						case '1':
							LeaveWAnumT1 = num.add(LeaveWAnumT1);
							break;
						case '2':
							LeaveWAnumT2 = num.add(LeaveWAnumT2);
							break;
						case '3':
							LeaveWAnumT3 = num.add(LeaveWAnumT3);
							break;
						case '4':
							LeaveWAnumT4 = num.add(LeaveWAnumT4);
							break;
						case '5':
							LeaveWAnumT5 = num.add(LeaveWAnumT5);
							break;
						case '6':
							LeaveWAnumT6 = num.add(LeaveWAnumT6);
							break;
						case '7':
							LeaveWAnumT7 = num.add(LeaveWAnumT7);
							break;
						case '9':
							LeaveWAnumT9 = num.add(LeaveWAnumT9);
							break;
						}
						break;
					case '1':
						switch (type) {
						case '1':
							LeavenumT1 = num.add(LeavenumT1);
							break;
						case '2':
							LeavenumT2 = num.add(LeavenumT2);
							break;
						case '3':
							LeavenumT3 = num.add(LeavenumT3);
							break;
						case '4':
							LeavenumT4 = num.add(LeavenumT4);
							break;
						case '5':
							LeavenumT5 = num.add(LeavenumT5);
							break;
						case '6':
							LeavenumT6 = num.add(LeavenumT6);
							break;
						case '7':
							LeavenumT7 = num.add(LeavenumT7);
							break;
						case '9':
							LeavenumT9 = num.add(LeavenumT9);
							break;
						}
						break;
					default:
						break;
					}
				} catch (Exception e) {

				}
			}

			request.setAttribute("LeavenumT1", LeavenumT1);
			request.setAttribute("LeaveWAnumT1", LeaveWAnumT1);
			request.setAttribute("LeavenumT2", LeavenumT2);
			request.setAttribute("LeaveWAnumT2", LeaveWAnumT2);
			request.setAttribute("LeavenumT3", LeavenumT3);
			request.setAttribute("LeaveWAnumT3", LeaveWAnumT3);
			request.setAttribute("LeavenumT4", LeavenumT4);
			request.setAttribute("LeaveWAnumT4", LeaveWAnumT4);
			request.setAttribute("LeavenumT5", LeavenumT5);
			request.setAttribute("LeaveWAnumT5", LeaveWAnumT5);
			request.setAttribute("LeavenumT6", LeavenumT6);
			request.setAttribute("LeaveWAnumT6", LeaveWAnumT6);
			request.setAttribute("LeavenumT7", LeavenumT7);
			request.setAttribute("LeaveWAnumT7", LeaveWAnumT7);
			request.setAttribute("LeavenumT9", LeavenumT9);
			request.setAttribute("LeaveWAnumT9", LeaveWAnumT9);

			request.setAttribute("flag_search", "1");
			request.setAttribute("appr", leaveStatus);
			request.setAttribute("userId", userSelect);
			request.setAttribute("userS", userSelect);
			// request.setAttribute("logonUser", userSelect);
			request.setAttribute("userSelect", userSelect);
			request.setAttribute("userSelect2", userSelect2);
			request.setAttribute("leaveType", leaveType);

			List<Map<String, Object>> cubeUser = userDAO.allName();
			request.setAttribute("cubeUser", cubeUser);

			List<Map<String, Object>> userseq = userDAO.sequense();
			request.setAttribute("userseq", userseq);
			List<Map<String, Object>> userseqTeam = userDAO.sequense_userinteam(userLogin);
			request.setAttribute("userseqTeam", userseqTeam);

			request.setAttribute("startdate", start_date);
			request.setAttribute("enddate", end_date);

			List<Map<String, Object>> leavenameList = leaveDAO.findLeave();
			request.setAttribute("leavenameList", leavenameList);
			List<LeaveType> type_leave = leavetypeDAO.findAll();

			request.setAttribute("type_1", type_leave.get(0).getLeaveTypeName());
			request.setAttribute("type_2", type_leave.get(1).getLeaveTypeName());
			request.setAttribute("type_3", type_leave.get(2).getLeaveTypeName());
			request.setAttribute("type_4", type_leave.get(3).getLeaveTypeName());
			request.setAttribute("type_5", type_leave.get(4).getLeaveTypeName());
			request.setAttribute("type_6", type_leave.get(5).getLeaveTypeName());
			request.setAttribute("type_7", type_leave.get(6).getLeaveTypeName());
			request.setAttribute("type_9", type_leave.get(7).getLeaveTypeName());
			request.setAttribute("leavetypelistChoice", type_leave);
			// New_myleave();
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String New_myleave() {
		try {
			User ur = new User();
			String userLogin = null;
			String type = request.getParameter("appr");
			String leaveType = request.getParameter("type");
			log.debug(type);
			ur = (User) request.getSession().getAttribute("onlineUser");
			userLogin = ur.getId();

			String listbyuser = request.getParameter("Id");
			DateTimeFormatter date1 = DateTimeFormatter.ofPattern("01-01-yyyy");
			LocalDate localDate = LocalDate.now();
			String s = "00:00:00.0";

			String start = request.getParameter("startdate");
			String end = request.getParameter("enddate");

			Timestamp start_date;
			Timestamp end_date;
			if (start == null && end == null) {
				start_date = DateUtil.dateToTimestamp(date1.format(localDate), s);
				end_date = DateUtil.changetoEndYear(date1.format(localDate));
			} else {
				start_date = DateUtil.dateFormatEdit(start);
				end_date = DateUtil.dateFormatEdit(end);
			}

			Date startdate = new Date(start_date.getTime());
			Date enddate = new Date(end_date.getTime());
			request.setAttribute("startdate", startdate);
			request.setAttribute("enddate", enddate);
			log.debug(enddate);
			log.debug(end_date);
			if (userLogin != listbyuser) {
				listbyuser = userLogin;
			}

			List<LeaveType> type_leave = leavetypeDAO.findAll_calendar();
			for (int i = 0; i < type_leave.size(); i++) {
				LeaveType leave = type_leave.get(i);
				request.setAttribute("type_" + leave.getLeaveTypeId(), leave.getLeaveTypeName());
			}
			log.debug(userLogin);
			List<Map<String, Object>> leavelist = null;

			log.debug(type+"/"+leaveType);
			leavelist = leaveDAO.findUserLeaveByTypeAndStatus(start_date, end_date, userLogin, type, leaveType);

			String status = "1";
			List LeaveID = leaveDAO.findLeaveId(userLogin, start_date, end_date, status);

			request.setAttribute("leavelist", leavelist);
			Double leave_1 = 0.000, leave_2 = 0.000, leave_3 = 0.000, leave_4 = 0.000, leave_5 = 0.000, leave_6 = 0.000,
					leave_7 = 0.000, leave_9 = 0.000;
//
//			for (Iterator iterator = leavelist.iterator(); iterator.hasNext();) {
//				Leaves leave = (Leaves) iterator.next();
//			}
			int x = 0;

			while (x <= LeaveID.size() - 1) {
				log.debug("inLoopWhile");
				String a[] = LeaveID.get(x).toString().split("[={}]");
				log.debug("Split Success");
				for (int b = 0; b <= a.length - 1; b++) {
					log.debug("a[" + b + "]= " + a[b]);
				}
				int id = 0;
				for (int b = 0; b <= a.length - 1; b++) {
					log.debug("inLoopFor");
					if (tryParseInt(a[b])) {
						log.debug("inIf");
						id = Integer.parseInt(a[b]);
						log.debug("This is Array No: " + b + " =" + a[b]);
						Leaves leaveDashboard = leaveDAO.findByLeaveId(id);
						log.debug("Ref Success");
						Double noday = leaveDashboard.getNoDay().doubleValue();
						log.debug("This NoDay : " + noday);
						if (leaveDashboard.getLeaveTypeId().contains("1")) {
							leave_1 = leave_1 + noday;
						}
						if (leaveDashboard.getLeaveTypeId().contains("2")) {
							leave_2 = leave_2 + noday;
						}
						if (leaveDashboard.getLeaveTypeId().contains("3")) {
							leave_3 = leave_3 + noday;
						}
						if (leaveDashboard.getLeaveTypeId().contains("4")) {
							leave_4 = leave_4 + noday;
						}
						if (leaveDashboard.getLeaveTypeId().contains("5")) {
							leave_5 = leave_5 + noday;
						}
						if (leaveDashboard.getLeaveTypeId().contains("6")) {
							leave_6 = leave_6 + noday;
						}
						if (leaveDashboard.getLeaveTypeId().contains("7")) {
							leave_7 = leave_7 + noday;
						}
						if (leaveDashboard.getLeaveTypeId().contains("9")) {
							leave_9 = leave_9 + noday;
						}
					}

				}
				x++;
			}
			request.setAttribute("leave_1", leave_1);
			request.setAttribute("leave_2", leave_2);
			request.setAttribute("leave_3", leave_3);
			request.setAttribute("leave_4", leave_4);
			request.setAttribute("leave_5", leave_5);
			request.setAttribute("leave_6", leave_6);
			request.setAttribute("leave_7", leave_7);
			request.setAttribute("leave_9", leave_9);
			request.setAttribute("usertest", userLogin);
			request.setAttribute("userS", userLogin);
			request.setAttribute("appr", type);

			Date day = new Date();
			log.debug(userLogin);

			LocalDate localdate = day.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			Double quotaLastYear = null;
			Double quotaThisYear = null;
			if (!"All".equals(userLogin) || !"All2".equals(userLogin)) {
				quotaLastYear = leaveDAO.LastYearQuota(userLogin, localdate.getYear());
				// List<Map<String, Object>> quotaLastYear = leaveDAO.LastYearQuota2(userLogin,
				// localdate.getYear());
				quotaThisYear = leaveDAO.ThisYearQuota(userLogin);
				request.setAttribute("quotaLastYear", quotaLastYear);
				request.setAttribute("quotaThisYear", quotaThisYear);
				request.setAttribute("leave_6l", quotaLastYear - leave_6);
				log.debug("quotaLastYear: " + quotaLastYear);
				BigDecimal quota_1 = ur.getLeaveQuota1(); // holiday leave quota
				BigDecimal quota_2 = ur.getLeaveQuota2(); // business leave quota
				BigDecimal quota_3 = ur.getLeaveQuota3(); // sick leave quota
				BigDecimal quota_4 = ur.getLeaveQuota4(); // leave quota from last year
				request.setAttribute("quota_1", quota_1);
				request.setAttribute("quota_2", quota_2);
				request.setAttribute("quota_3", quota_3);
				request.setAttribute("quota_4", quota_4);
				
				//Summary Leave - For Add Leave Page
				request.getSession().setAttribute("quota_1", quota_1);
				request.getSession().setAttribute("quota_3", quota_3);
				request.getSession().setAttribute("quota_4", quota_4);
				
			} else {

			}

			String year = localdate.toString().substring(0, 4);
			Timestamp tend = Timestamp.valueOf(year + "-04-01 00:00:00"); // time end is april month
			Timestamp tnow = new Timestamp(day.getTime());
			request.setAttribute("tnow", tnow);
			request.setAttribute("tend", tend);
			log.debug(type_leave);
			request.setAttribute("leavetypelistChoice", type_leave);
			request.setAttribute("leaveType", leaveType);
			
			//Summary Leave - For Add Leave Page
			request.getSession().setAttribute("leave_1", leave_1);
			request.getSession().setAttribute("leave_2", leave_2);
			request.getSession().setAttribute("leave_3", leave_3);
			request.getSession().setAttribute("leave_4", leave_4);
			request.getSession().setAttribute("leave_5", leave_5);
			request.getSession().setAttribute("leave_6", leave_6);
			request.getSession().setAttribute("leave_7", leave_7);
			
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public boolean tryParseInt(String value) {
		try {
			int x = Integer.parseInt(value);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

	public String NewLeaveAdd() {
		String date = request.getParameter("date");
		String time = request.getParameter("time");
		try {
			User ur = new User();
			String userLogin = null;
			ur = (User) request.getSession().getAttribute("onlineUser");
			userLogin = ur.getId();
			log.debug(userLogin);

			DateTimeFormatter date1 = DateTimeFormatter.ofPattern("01-01-yyyy");
			LocalDate localDate = LocalDate.now();
			String s = "00:00:00.0";

			String start = request.getParameter("startdate");
			String end = request.getParameter("enddate");
			Timestamp start_date;
			Timestamp end_date;
			if (start == null && end == null) {
				start_date = DateUtil.dateToTimestamp(date1.format(localDate), s);
				end_date = DateUtil.changetoEndYear(date1.format(localDate));
			} else {
				start_date = DateUtil.dateFormatEdit(start);
				end_date = DateUtil.dateFormatEdit(end);
			}
			log.debug(start_date);
			log.debug(end_date);

			String status = "1";
			// List<Map<String, Object>> leaveListDashboard =
			// leaveDAO.myLeavesList(userLogin, start_date, end_date, status);
			List LeaveID = leaveDAO.findLeaveId(userLogin, start_date, end_date, status);

			Double leave_1 = 0.000, leave_2 = 0.000, leave_3 = 0.000, leave_5 = 0.000, leave_6 = 0.000;
//
//			for (Iterator iterator = leavelist.iterator(); iterator.hasNext();) {
//				Leaves leave = (Leaves) iterator.next();
//			}
			int x = 0;

			while (x <= LeaveID.size() - 1) {
				log.debug("inLoopWhile");
				String a[] = LeaveID.get(x).toString().split("[={}]");
				log.debug("Split Success");
				for (int b = 0; b <= a.length - 1; b++) {
					log.debug("a[" + b + "]= " + a[b]);
				}
				int id = 0;
				for (int b = 0; b <= a.length - 1; b++) {
					log.debug("inLoopFor");
					if (tryParseInt(a[b])) {
						log.debug("inIf");
						id = Integer.parseInt(a[b]);
						log.debug("This is Array No: " + b + " =" + a[b]);
						Leaves leaveDashboard = leaveDAO.findByLeaveId(id);
						log.debug("Ref Success");
						Double noday = leaveDashboard.getNoDay().doubleValue();
						log.debug("This NoDay : " + noday);
						if (leaveDashboard.getLeaveTypeId().contains("1")) {
							leave_1 = leave_1 + noday;
						}
						if (leaveDashboard.getLeaveTypeId().contains("2")) {
							leave_2 = leave_2 + noday;
						}
						if (leaveDashboard.getLeaveTypeId().contains("3")) {
							leave_3 = leave_3 + noday;
						}
						if (leaveDashboard.getLeaveTypeId().contains("5")) {
							leave_5 = leave_5 + noday;
						}
						if (leaveDashboard.getLeaveTypeId().contains("6")) {
							leave_6 = leave_6 + noday;
						}
					}

				}
				x++;
			}
			if (ur.getLeaveQuota1() != null) {
				if (ur.getLeaveQuota1().doubleValue() - leave_2 <= leave_1) {
					String leave1Check = "1";
					request.setAttribute("leave1Check", leave1Check);
				} else {
					String leave1Check = "0";
					request.setAttribute("leave1Check", leave1Check);
				}
			}
			/*
			 * if(ur.getLeaveQuota2() != null) { if(ur.getLeaveQuota2().doubleValue() <=
			 * leave_2) { String leave2Check = "1"; request.setAttribute("leave2Check",
			 * leave2Check); } else { String leave2Check = "0";
			 * request.setAttribute("leave2Check", leave2Check); } }
			 */
			if (3 <= leave_2) {
				String leave2Check = "1";
				request.setAttribute("leave2Check", leave2Check);
			} else {
				String leave2Check = "0";
				request.setAttribute("leave2Check", leave2Check);
			}
			if (ur.getLeaveQuota3() != null) {
				if (ur.getLeaveQuota3().doubleValue() <= leave_3) {
					String leave3Check = "1";
					request.setAttribute("leave3Check", leave3Check);
				} else {
					String leave3Check = "0";
					request.setAttribute("leave3Check", leave3Check);
				}
			} else {
				if (30 <= leave_3) {
					String leave3Check = "1";
					request.setAttribute("leave3Check", leave3Check);
				} else {
					String leave3Check = "0";
					request.setAttribute("leave3Check", leave3Check);
				}
			}
			if (ur.getLeaveQuota4() != null) {
				if (ur.getLeaveQuota4().doubleValue() <= leave_6) {
					String leave6Check = "1";
					request.setAttribute("leave6Check", leave6Check);
				} else {
					String leave6Check = "0";
					request.setAttribute("leave6Check", leave6Check);
				}
			}

			log.debug("Set Check Quota Success!!");
			/**/
			String leaveTypeJSON = leavetypeDAO.getForDisplayJSON();
			String holidayJSON = holidayDAO.getallOnlyDateJSON();
			String userListJSON = userDAO.userListJSON();
			Double quotaThisYear = leaveDAO.ThisYearQuota(userLogin);
			log.debug("quota of this year : " + quotaThisYear);
			Double qThisYear = quotaThisYear - (leave_1 + leave_2);
			request.setAttribute("quotaThisYear", qThisYear.intValue());

			request.setAttribute("date", date);
			request.setAttribute("time", time);
			request.setAttribute("userList", userListJSON);
			request.setAttribute("leaveType", leaveTypeJSON);
			request.setAttribute("holiday", holidayJSON);
			request.setAttribute("action", "Add");
			
			log.debug("Set request Success!!");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String NewLeaveEdit() {
		try {
			String id = request.getParameter("id");
			Leaves  leave = leaveDAO.findByLeaveId(Integer.parseInt(id));
			User user = new User();
			String userLogin = null;
			user = (User) request.getSession().getAttribute("onlineUser");
			userLogin = user.getId();
			log.debug(userLogin);
			String userId = leave.getUserId();	
			log.debug(userId);
			
			DateTimeFormatter dateTimeFormat = DateTimeFormatter.ofPattern("01-01-yyyy");
			LocalDate localDate = LocalDate.now();
			String time = "00:00:00.0";
			
			String start = request.getParameter("startdate");
			String end = request.getParameter("enddate");
			Timestamp start_date;
			Timestamp end_date;
			if(start == null && end == null) {
				start_date = DateUtil.dateToTimestamp(dateTimeFormat.format(localDate), time);
				end_date = DateUtil.changetoEndYear(dateTimeFormat.format(localDate));
			} else {
				start_date = DateUtil.dateFormatEdit(start);
				end_date = DateUtil.dateFormatEdit(end);
			}
			String status = "1";
			List LeaveID = leaveDAO.findLeaveId(userId, start_date, end_date, status);

			Double leave_1 = 0.000, leave_2 = 0.000, leave_3 = 0.000, leave_4 = 0.000, leave_5 = 0.000, leave_6 = 0.000, leave_7 = 0.000, leave_9 = 0.000;
			int x = 0;
			
			while (x <= LeaveID.size() - 1 ) {
				String a[] = LeaveID.get(x).toString().split("[={}]");
				for (int b = 0; b <= a.length - 1; b++) {
					log.debug("a[" + b + "]= " + a[b]);
				}
				int leave_id = 0;
				for (int b = 0; b <= a.length - 1; b++) {
					if(tryParseInt(a[b])) {
						leave_id = Integer.parseInt(a[b]);
						Leaves leaveDashboard = leaveDAO.findByLeaveId(leave_id);
						Double noday = leaveDashboard.getNoDay().doubleValue();
						if (leaveDashboard.getLeaveTypeId().contains("1")) {
							leave_1 = leave_1 + noday;
						}
						if (leaveDashboard.getLeaveTypeId().contains("2")) {
							leave_2 = leave_2 + noday;
						}
						if (leaveDashboard.getLeaveTypeId().contains("3")) {
							leave_3 = leave_3 + noday;
						}
						if (leaveDashboard.getLeaveTypeId().contains("5")) {
							leave_5 = leave_5 + noday;
						}
						if (leaveDashboard.getLeaveTypeId().contains("6")) {
							leave_6 = leave_6 + noday;
						}
					} 
				}
				x++;
			}
			if (user.getLeaveQuota1() != null) {
				if (user.getLeaveQuota1().doubleValue() - leave_2 <= leave_1) {
					String leave1Check = "1";
					request.setAttribute("leave1Check", leave1Check);
				} else {
					String leave1Check = "0";
					request.setAttribute("leave1Check", leave1Check);
				}
			}
			if (3 <= leave_2) {
				String leave2Check = "1";
				request.setAttribute("leave2Check", leave2Check);
			} else {
				String leave2Check = "0";
				request.setAttribute("leave2Check", leave2Check);
			}
			if (user.getLeaveQuota3() != null) {
				if (user.getLeaveQuota3().doubleValue() <= leave_3) {
					String leave3Check = "1";
					request.setAttribute("leave3Check", leave3Check);
				} else {
					String leave3Check = "0";
					request.setAttribute("leave3Check", leave3Check);
				}
			} else {
				if (30 <= leave_3) {
					String leave3Check = "1";
					request.setAttribute("leave3Check", leave3Check);
				} else {
					String leave3Check = "0";
					request.setAttribute("leave3Check", leave3Check);
				}
			}
			if (user.getLeaveQuota4() != null) {						
				log.debug(user.getLeaveQuota4());
				if (user.getLeaveQuota4().doubleValue() < leave_6) {	
					String leave6Check = "1";							
					request.setAttribute("leave6Check", leave6Check);
				} else {
					String leave6Check = "0";
					request.setAttribute("leave6Check", leave6Check);
				}
			}
			if(leave.getLeaveFile() != null) {
				FileUpload fileLeave = fileuploadDAO.findById(Integer.parseInt(leave.getLeaveFile()));
				request.setAttribute("fileLeave", new Gson().toJson(fileLeave));
			}
			
			String leaveTypeJSON = leavetypeDAO.getForDisplayJSON();
			String holidayJSON = holidayDAO.getallOnlyDateJSON();
			String userListJSON = userDAO.userListJSON();
			Double quotaThisYear = leaveDAO.ThisYearQuota(userId);
			Double qThisYear = quotaThisYear - (leave_1 + leave_2);
			
			request.setAttribute("quotaThisYear", qThisYear.intValue());
			request.setAttribute("userList", userListJSON);
			request.setAttribute("leaveType", leaveTypeJSON);
			request.setAttribute("holiday", holidayJSON);
			log.debug(new Gson().toJson(leave));
			request.setAttribute("leave", new Gson().toJson(leave));
			request.setAttribute("action", "Edit");
			
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		
	}

	public String new_LeaveAdd_Do() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");

			if (user == null) {
				user = user_hidden;
			}
			if (approver == null) {
				approver = approver_hidden;
			}
			if (status == null) {
				status = status_hidden;
			}
			if (to == null) {
				to = to_hidden;
			}

			if (halfDay != null) {
				if (halfDay.equals("0")) {
					time_from = "9:00";
					time_to = "18:00";
				} else if (halfDay.equals("1")) {
					time_from = "8:00";
					time_to = "12:00";
				} else if (halfDay.equals("2")) {
					time_from = "13:00";
					time_to = "17:00";
				}
			}

			if (amount == null) {
				amount = amount_hidden;
			}
			if (amount_sub == null) {
				amount_sub = amount_sub_hidden;
			}

			log.debug(user);
			log.debug(status);

			float amount_n = Float.parseFloat(amount);
			float amount_sub_n = Float.parseFloat(amount_sub);
			log.debug(amount_n);
			log.debug(amount_sub_n);
			BigDecimal noDay = BigDecimal.valueOf(amount_n + (amount_sub_n / 8));
			log.debug("no day" + noDay);

			final String OLD_FORMAT = "dd MMM yyyy";
			final String NEW_FORMAT = "dd-MM-yyyy";
			String newDateFrom;
			String newDateTo;

			SimpleDateFormat sdf = new SimpleDateFormat(OLD_FORMAT);
			Date date_from = sdf.parse(from);
			Date date_to = sdf.parse(to);
			sdf.applyPattern(NEW_FORMAT);
			newDateFrom = sdf.format(date_from);
			newDateTo = sdf.format(date_to);
			Timestamp startDate = DateUtil.dateFormatEdit(newDateFrom);
			Timestamp endDate = DateUtil.dateFormatEdit(newDateTo);
			Integer id = leaveDAO.getMaxId() + 1;

			int maxId = fileuploadDAO.getMaxId() + 1;
			FileUpload fileupload = new FileUpload();
			log.debug(fileUpload);
			if (fileUpload != null) {
				ServletContext context = request.getServletContext();
				String fileServerPath = context.getRealPath("/");
				String fileName = fileUploadFileName;
				log.debug("fileName = " + fileName);
				fileupload.setSize(fileUploadSize);
				log.debug("fileUploadSize = " + fileUploadSize);

				int l = fileUploadFileName.length();
				int split = fileUploadFileName.lastIndexOf('.');
				String name = fileUploadFileName.substring(0, split);
				String type = (String) fileUploadFileName.subSequence(split, l);

				String serverFileName = maxId + type; // 101.jpg

//				fileupload.setPath("/upload/user/" + maxId + "_" + fileName);
//				FileUtil.upload(fileUpload, fileServerPath + "upload/user/", maxId + "_" + fileName);
				fileupload.setPath("/upload/user/" + serverFileName);
				FileUtil.upload(fileUpload, fileServerPath + "upload/user/", serverFileName);

				log.debug("File Upload Path = " + fileServerPath + "upload/user/" + serverFileName);

//				int l = fileUploadFileName.length();
//				int split = fileUploadFileName.lastIndexOf('.');
//				String name = fileUploadFileName.substring(0, split);
//				String type = (String) fileUploadFileName.subSequence(split, l);

				fileupload.setFileId(maxId);
				fileupload.setUserId(user);
				fileupload.setUserCreate(onlineUser.getId());
				fileupload.setName(name);
				fileupload.setType(type);
				fileupload.setUserUpdate(onlineUser.getId());
				fileupload.setTimeCreate(DateUtil.getCurrentTime());
				fileupload.setTimeUpdate(DateUtil.getCurrentTime());
				fileuploadDAO.save(fileupload);
			}

			// Data send mail
			// List<Map<String, Object>> leaveType_mail =
			// leavetypeDAO.findByLeaveTypeId(leaveType);

			// emailservice.sendMail(user,leaveType,description,halfDay,from,to,noDay);
			log.debug(leaveType);
			Leaves leave = new Leaves();
			leave.setLeaveId(id);
			leave.setLeaveTypeId(leaveType);
			leave.setLeaveStatusId(status);
			leave.setHalfDay(halfDay);
			leave.setUserId(user);
			leave.setApprUserId(approver);
			leave.setDescription(description);
			leave.setReason(reason);
			leave.setStartDate(startDate);
			leave.setEndDate(endDate);
			leave.setStartTime(time_from);
			leave.setEndTime(time_to);
			leave.setNoDay(noDay);
			if (fileUpload != null) {
				leave.setLeaveFile(Integer.toString(maxId));
			} else {
				leave.setLeaveFile(null);
			}
			leave.setUserCreate(onlineUser.getId());
			leave.setUserUpdate(onlineUser.getId());
			leave.setTimeCreate(DateUtil.getCurrentTime());
			leave.setTimeUpdate(DateUtil.getCurrentTime());
			if (!noDay.equals(BigDecimal.ZERO)) {
				leaveDAO.save(leave);
			}
			log.debug("new_leaveAdd_Do Success!!");

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String new_LeaveEdit_Do() {
	    try {
	        log.info("new_LeaveEdit_Do");
	        User onlineUser = (User) request.getSession().getAttribute("onlineUser");
	        
	        log.debug(leaveId_hidden);
	        int id = Integer.parseInt(leaveId_hidden);
	        Leaves leave = leaveDAO.findByLeaveId(id);

	        if (user == null) {
	            user = leave.getUserId();
	        }
	        if (approver == null) {
	            approver = approver_hidden;
	        }
	        if (status == null) {
	            status = status_hidden;
	        }
	        if (to == null) {
	            to = to_hidden;
	        }
	        log.debug(user);
	        log.debug(approver);
	        
	        if (halfDay.equals("0")) {
	            time_from = "9:00";
	            time_to = "18:00";
	        } else if (halfDay.equals("1")) {
	            time_from = "8:00";
	            time_to = "12:00";
	        } else if (halfDay.equals("2")) {
	            time_from = "13:00";
	            time_to = "17:00";
	        }

	        if (amount == null) {
	            amount = amount_hidden;
	        }
	        if (amount_sub == null) {
	            amount_sub = amount_sub_hidden;
	        }
	        float amount_n = Float.parseFloat(amount);
	        float amount_sub_n = Float.parseFloat(amount_sub);
	        log.debug(amount_n);
	        log.debug(amount_sub_n);
	        BigDecimal noDay = BigDecimal.valueOf(amount_n + (amount_sub_n / 8));
	        log.debug("no day" + noDay);

	        final String OLD_FORMAT = "dd MMM yyyy";
	        final String NEW_FORMAT = "dd-MM-yyyy";
	        String newDateFrom;
	        String newDateTo;

	        SimpleDateFormat sdf = new SimpleDateFormat(OLD_FORMAT);
	        Date date_from = sdf.parse(from);
	        Date date_to = sdf.parse(to);
	        sdf.applyPattern(NEW_FORMAT);
	        newDateFrom = sdf.format(date_from);
	        newDateTo = sdf.format(date_to);
	        Timestamp startDate = DateUtil.dateFormatEdit(newDateFrom);
	        Timestamp endDate = DateUtil.dateFormatEdit(newDateTo);

	        // Logic Manage File Attach
	        String oldFileIdStr = leave.getLeaveFile();
	        
	        // logic delete file from bin icon
	        if (deleteFileId != null && !deleteFileId.isEmpty()) {
	            try {
	                int delFileId = Integer.parseInt(deleteFileId);
	                FileUpload fileuploadDel = fileuploadDAO.findById(delFileId);

	                if (fileuploadDel != null) {
	                    ServletContext context = request.getServletContext();
	                    String fileServerPath = context.getRealPath("/");
	                    File file = new File(fileServerPath + fileuploadDel.getPath());
	                    
	                    if (file.delete()) {
	                        log.info("Successfully deleted file on server (Trash Icon): " + delFileId);
	                    } else {
	                        log.info("Cannot delete file on server (Trash Icon): " + delFileId);
	                    }
	                    
	                    fileuploadDAO.delete(fileuploadDel);
	                    log.info("Successfully deleted file record from DB (Trash Icon): " + delFileId);
	                    
	                    // Clear the file link on the server object
	                    oldFileIdStr = null; 
	                }
	                
	                // update leave file to null
	                leave.setLeaveFile(null); 
	                
	            } catch (NumberFormatException e) {
	                log.error("Invalid deleteFileId format: " + deleteFileId, e);
	            }
	        }

	        // logic manage file on update file attach
	        if (fileUpload != null) {
	            log.info("New file uploaded. Processing replacement/upload.");
	            
	            // delete old file
	            if (oldFileIdStr != null && !oldFileIdStr.isEmpty()) {
	                try {
	                    int oldFileId = Integer.parseInt(oldFileIdStr);
	                    FileUpload fileuploadDel = fileuploadDAO.findById(oldFileId);
	                    
	                    if (fileuploadDel != null) {
	                        ServletContext context = request.getServletContext();
	                        String fileServerPath = context.getRealPath("/");
	                        File file = new File(fileServerPath + fileuploadDel.getPath());
	                        
	                        if (file.delete()) {
	                            log.info("Successfully deleted OLD file during replacement: " + oldFileId);
	                        } else {
	                            log.info("Cannot delete OLD file during replacement: " + oldFileId);
	                        }
	                        fileuploadDAO.delete(fileuploadDel);
	                        log.info("Successfully deleted OLD file record from DB: " + oldFileId);
	                    }
	                } catch (NumberFormatException e) {
	                    log.error("Invalid oldFileId format in Leaves object during replacement: " + oldFileIdStr, e);
	                }
	            }
	            // upload new file
	            int maxId = fileuploadDAO.getMaxId() + 1;
	            FileUpload fileupload = new FileUpload();
	            
	            ServletContext context = request.getServletContext();
	            String fileServerPath = context.getRealPath("/");
	            String fileName = fileUploadFileName;
	            
	            int l = fileUploadFileName.length();
	            int split = fileUploadFileName.lastIndexOf('.');
	            String name = fileUploadFileName.substring(0, split);
	            String type = (String) fileUploadFileName.subSequence(split, l); //.jpg

	            String serverFileName = maxId + type; //101.jpg
	            
	            fileupload.setPath("/upload/user/" + serverFileName);
	            FileUtil.upload(fileUpload, fileServerPath + "upload/user/", serverFileName);
	            log.info("File Upload Path = " + fileServerPath + "upload/user/" + serverFileName);

	            // save on db
	            fileupload.setFileId(maxId);
	            fileupload.setUserId(user); 
	            fileupload.setUserCreate(onlineUser.getId());
	            fileupload.setName(name);
	            fileupload.setType(type);
	            fileupload.setSize(fileUploadSize);
	            fileupload.setUserUpdate(onlineUser.getId());
	            fileupload.setTimeCreate(DateUtil.getCurrentTime());
	            fileupload.setTimeUpdate(DateUtil.getCurrentTime());
	            fileuploadDAO.save(fileupload);

	            leave.setLeaveFile(Integer.toString(maxId));
	        }
	        
	        // Logic Manage File Attach
	        
	        // Update Leave
	        log.info(leaveType);
	        leave.setLeaveTypeId(leaveType);
	        leave.setLeaveStatusId(status);
	        leave.setHalfDay(halfDay);
	        leave.setUserId(user);
	        leave.setApprUserId(approver);
	        leave.setDescription(description);
	        leave.setReason(reason);
	        leave.setStartDate(startDate);
	        leave.setEndDate(endDate);
	        leave.setStartTime(time_from);
	        leave.setEndTime(time_to);
	        leave.setNoDay(noDay);
	        leave.setUserUpdate(onlineUser.getId());
	        leave.setTimeUpdate(DateUtil.getCurrentTime());
	        leaveDAO.update(leave);
	        
	        return SUCCESS;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ERROR;
	    }
	}


	public String preview_File() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			String id = request.getParameter("id");
			log.debug(id);
			FileUpload fileUpload = fileuploadDAO.findById(Integer.parseInt(id));
			request.setAttribute("pathImage", fileUpload.getPath());
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String New_modalLeaveStatus() {
		try {
			log.debug("leave id " + leaveId);

			Gson gson = new GsonBuilder().setDateFormat("dd MMM yyyy, HH:mm").create();
			String responseJSON = gson.toJson(leaveDAO.findLeaveById2(leaveId));
			request.setAttribute("json", responseJSON);
			log.debug(responseJSON);

			JSONArray jsonarray = new JSONArray(responseJSON);
			JSONObject jsonobj = jsonarray.getJSONObject(0);

			int leaveId = jsonobj.getInt("leave_id");
			String leaveTypeId = jsonobj.getString("leave_type_id");
			String leaveStatusId = jsonobj.getString("leave_status_id");
			String userId = jsonobj.getString("user_id");
			String startDate = jsonobj.getString("start_date");
			String endDate = jsonobj.getString("end_date");
			String apprUserId = jsonobj.getString("appr_user_id");
			BigDecimal noDay = jsonobj.getBigDecimal("no_day");
			String description = jsonobj.getString("description");
			String name = jsonobj.getString("name");

			String reason = "";
			try {
				reason = jsonobj.getString("reason");
			} catch (Exception e) {
			}
			String timeCreate = jsonobj.getString("time_create");

			// -------- time --------
			String startTime = "";
			try {
				startTime = jsonobj.getString("start_time");
			} catch (Exception e) {
			}
			String endTime = "";
			try {
				endTime = jsonobj.getString("end_time");
			} catch (Exception e) {
			}

			// -------- time update --------
			String timeUpdate = "";
			try {
				timeUpdate = jsonobj.getString("time_update");
			} catch (Exception e) {
			}

			String userCreate = "";
			try {
				userCreate = jsonobj.getString("user_create");
			} catch (Exception e) {
			}

			String userUpdate = "";
			try {
				userUpdate = jsonobj.getString("user_update");
			} catch (Exception e) {
			}

			// -------- leave file --------
			String leaveFileId = "";
			try {
				leaveFileId = jsonobj.getString("leave_file");
			} catch (Exception e) {
			}

			String leaveFileName = "";
			try {
				leaveFileName = jsonobj.getString("file_name");
			} catch (Exception e) {
			}

			String leaveFileType = "";
			try {
				leaveFileType = jsonobj.getString("type");
			} catch (Exception e) {
			}

			PrintWriter out = response.getWriter();
			JSONObject json = new JSONObject();

			json.put("leave_id", leaveId);
			json.put("leave_type_id", leaveTypeId);
			json.put("leave_status_id", leaveStatusId);
			json.put("user_id", userId);
			json.put("start_date", startDate);
			json.put("end_date", endDate);
			json.put("start_time", startTime);
			json.put("end_time", endTime);
			json.put("appr_user_id", apprUserId);
			json.put("no_day", noDay);
			json.put("description", description);
			json.put("name", name);
			json.put("reason", reason);
			json.put("time_create", timeCreate);
			json.put("time_update", timeUpdate);
			json.put("user_create", userCreate);
			json.put("user_update", userUpdate);
			json.put("leave_file_id", leaveFileId);
			json.put("leave_file_name", leaveFileName);
			json.put("leave_file_type", leaveFileType);

			out.print(json);
			out.flush();
			out.close();

			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String Leave_inListStatusToCancel() {
		try {
			String leave_id = request.getParameter("leave_id");
			log.debug(leave_id);
			String reason = request.getParameter("reason");
			log.debug(reason);
			Leaves leave = leaveDAO.findByLeaveId(Integer.parseInt(leave_id));
			leave.setLeaveStatusId("3");
			leave.setReason(reason);
			leave.setTimeUpdate(DateUtil.getCurrentTime());
			leaveDAO.update(leave);

			return SUCCESS;
		} catch (Exception e) {
			return ERROR;
		}

	}

	public String Leave_inListUpdateStatus() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			log.debug(onlineUser);
			String leave_id = request.getParameter("leave_id");
			String reason = request.getParameter("reason");
			String status = request.getParameter("status");
			log.debug(status);
			log.debug(reason);
			
		    if(reason == null || reason.trim().isEmpty()){
		        reason = null;
		    }
		    
			Leaves leave = leaveDAO.findByLeaveId(Integer.parseInt(leave_id));
			leave.setLeaveStatusId(status);
			leave.setReason(reason);
			leave.setTimeUpdate(DateUtil.getCurrentTime());
			leave.setUserUpdate(onlineUser.getId());
			leaveDAO.save(leave);
			log.debug(leave);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String CreateListUsers() {
		try {
			String value = request.getParameter("select_list");
			log.debug(value);
			String userLogin = request.getParameter("user_login");
			log.debug(userLogin);
			Gson gson = new GsonBuilder().setPrettyPrinting().create();
			String responseJSON = "";
			List<Map<String, Object>> list = null;
			if (value.equals("All")) {
				list = userDAO.sequense();
				responseJSON = gson.toJson(list);
			} else {
				list = userDAO.sequense_userinteam(userLogin);
				responseJSON = gson.toJson(list);
			}
			request.setAttribute("json", responseJSON);
			PrintWriter out = response.getWriter();
			out.print(responseJSON);
			out.flush();
			out.close();

			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String getManagerIdAndManagerName() {
		log.info("getManagerIdAndManagerName");

		try {

			String reqUserId = request.getParameter("userId");
			log.info("userId = " + reqUserId);

			String option = "";
			String managerId = "";
			String employeeId = "";

			List<Map<String, Object>> mapList = userDAO.getManagerIdAndManagerNameByUserId(reqUserId);
			if (!mapList.isEmpty()) {
				Map<String, Object> map = mapList.get(0);
				
				String resUserId = ( map.get("userId") != null ) ? map.get("userId").toString() : "";
				managerId = ( map.get("managerId") != null ) ? map.get("managerId").toString() : "";
				employeeId = ( map.get("employeeId") != null ) ? map.get("employeeId").toString() : "";
				String managerNameTh = ( map.get("managerNameTh") != null ) ? map.get("managerNameTh").toString() : "";
				String managerNameEn = ( map.get("managerNameEn") != null ) ? map.get("managerNameEn").toString() : "";
				log.info("managerId = " + managerId);
				log.info("employeeId = " + employeeId);
				log.info("managerNameTh = " + managerNameTh);
				log.info("managerNameEn = " + managerNameEn);
				
				String result = "";
				
				if (employeeId != null && !employeeId.isEmpty() && managerNameTh != null && !managerNameTh.isEmpty() && managerNameEn != null && !managerNameEn.isEmpty()) {
					result = employeeId + " - " + managerNameTh + " - " + managerNameEn;
				} else if (employeeId != null && !employeeId.isEmpty() && (managerNameTh == null || managerNameTh.isEmpty()) && (managerNameEn == null || managerNameEn.isEmpty())) {
					result = employeeId;
				} else if (employeeId != null && !employeeId.isEmpty() && managerNameTh != null && !managerNameTh.isEmpty() && (managerNameEn == null || managerNameEn.isEmpty())) {
					result = employeeId + " - " + managerNameTh;
				} else if (employeeId != null && !employeeId.isEmpty() && (managerNameTh == null || managerNameTh.isEmpty()) && managerNameEn != null && !managerNameEn.isEmpty()) {
					result = employeeId + " - " + managerNameEn;
				} else if ((employeeId == null || employeeId.isEmpty()) && managerNameTh != null && !managerNameTh.isEmpty() && (managerNameEn == null || managerNameEn.isEmpty())) {
					result = managerNameTh;
				} else if ((employeeId == null || employeeId.isEmpty()) && managerNameTh != null && !managerNameTh.isEmpty() && managerNameEn != null && !managerNameEn.isEmpty()) {
					result = managerNameTh + " - " + managerNameEn;
				} else if ((employeeId == null || employeeId.isEmpty()) && (managerNameTh == null || managerNameTh.isEmpty()) && managerNameEn != null && !managerNameEn.isEmpty()) {
					result = managerNameEn;
				} else {
					result = resUserId;
				}
				
				option = "<option value='" + managerId + "'>" + result + "</option>";
			}

			Map<String, String> obj = new HashMap<>();
			obj.put("approverId", managerId);
			obj.put("option", option);
			Gson gson = new GsonBuilder().setPrettyPrinting().create();
			String json = gson.toJson(obj);
			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();
			out.close();

			log.info("[getManagerIdAndManagerName] SUCCESS");
			return SUCCESS;
		} catch (Exception e) {
			log.info("[getManagerIdAndManagerName] ERROR");
			log.error(e);
			return ERROR;
		}

	}
	
	public String getLeaveCheckStatusJson() {
	    log.info("getLeaveCheckStatusJson");
	    
	    try {
	        String reqUserId = request.getParameter("userId");
	        log.info("Checking quota for userId = " + reqUserId);

	        if (reqUserId == null || reqUserId.isEmpty()) {
	            log.error("Required parameter 'userId' is missing.");
	            return ERROR;
	        }

	        User ur = userDAO.findById(reqUserId);
	        
	        if (ur == null) {
	            log.error("Target User object not found in database for ID: " + reqUserId);
	            return ERROR;
	        }
	        
	        DateTimeFormatter date1 = DateTimeFormatter.ofPattern("01-01-yyyy");
	        LocalDate localDate = LocalDate.now();
	        String s = "00:00:00.0";

	        Timestamp start_date = DateUtil.dateToTimestamp(date1.format(localDate), s);
	        Timestamp end_date = DateUtil.changetoEndYear(date1.format(localDate));
	        
	        log.debug("Start Date: " + start_date);
	        log.debug("End Date: " + end_date);

	        String status = "1";
	        
	        List LeaveID = leaveDAO.findLeaveId(reqUserId, start_date, end_date, status);

	        Double leave_1 = 0.000, leave_2 = 0.000, leave_3 = 0.000, leave_5 = 0.000, leave_6 = 0.000;
	        int x = 0;

	        while (x <= LeaveID.size() - 1) {
	            String a[] = LeaveID.get(x).toString().split("[={}]");
	            int id = 0;
	            for (int b = 0; b <= a.length - 1; b++) {
	                if (tryParseInt(a[b])) {
	                    id = Integer.parseInt(a[b]);
	                    Leaves leaveDashboard = leaveDAO.findByLeaveId(id);
	                    
	                    if (leaveDashboard != null && leaveDashboard.getNoDay() != null) {
	                        Double noday = leaveDashboard.getNoDay().doubleValue();
	                        
	                        if (leaveDashboard.getLeaveTypeId().contains("1")) {
	                            leave_1 = leave_1 + noday;
	                        }
	                        if (leaveDashboard.getLeaveTypeId().contains("2")) {
	                            leave_2 = leave_2 + noday;
	                        }
	                        if (leaveDashboard.getLeaveTypeId().contains("3")) {
	                            leave_3 = leave_3 + noday;
	                        }
	                        if (leaveDashboard.getLeaveTypeId().contains("5")) {
	                            leave_5 = leave_5 + noday;
	                        }
	                        if (leaveDashboard.getLeaveTypeId().contains("6")) {
	                            leave_6 = leave_6 + noday;
	                        }
	                    }
	                }
	            }
	            x++;
	        }
	        log.debug("Days Used: L1=" + leave_1 + ", L2=" + leave_2 + ", L3=" + leave_3 + ", L6=" + leave_6);

	        Map<String, Boolean> leaveCheckMap = new HashMap<>(); 

	        // leave1Check: (Quota1 - leave_2) <= leave_1
	        if (ur.getLeaveQuota1() != null) {
	            boolean isFull = ur.getLeaveQuota1().doubleValue() - leave_2 <= leave_1;
	            leaveCheckMap.put("1", isFull);
	        } else {
	            leaveCheckMap.put("1", false); 
	        }

	        // leave2Check: 3 <= leave_2
	        leaveCheckMap.put("2", (3 <= leave_2));

	        // leave3Check: (Quota3 หรือ 30) <= leave_3
	        if (ur.getLeaveQuota3() != null) {
	            boolean isFull = ur.getLeaveQuota3().doubleValue() <= leave_3;
	            leaveCheckMap.put("3", isFull);
	        } else {
	            boolean isFull = 30 <= leave_3; // Use 30 as Default
	            leaveCheckMap.put("3", isFull);
	        }

	        // leave6Check: Quota4 <= leave_6
	        if (ur.getLeaveQuota4() != null) {
	            boolean isFull = ur.getLeaveQuota4().doubleValue() <= leave_6;
	            leaveCheckMap.put("6", isFull);
	        } else {
	            leaveCheckMap.put("6", false);
	        }
	        
	        Map<String, Object> finalResponse = new HashMap<>();
	        finalResponse.put("leaveCheckStatus", leaveCheckMap);
	        
	        Gson gson = new GsonBuilder().setPrettyPrinting().create();
	        String json = gson.toJson(finalResponse);
	        
	        PrintWriter out = response.getWriter();
	        out.print(json);
	        out.flush();
	        out.close();

	        log.info("[getLeaveCheckStatusJson] SUCCESS");
	        return SUCCESS;
	    } catch (Exception e) {
	        log.error("[getLeaveCheckStatusJson] ERROR", e);
	        return ERROR;
	    }
	}
	
}