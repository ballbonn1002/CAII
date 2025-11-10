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
	private static String check_flag = "";
	private static String Global_flag = "";
	Logger log = Logger.getLogger(getClass());
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
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

//	@Autowired
//	public TimesheetDAO timesheetDAO;

//	@Autowired
//	public EmailService emailservice;

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

//	@Autowired
//	private AuthorizedObjectDAO authorizedObjectDAO;

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

//	public String list() {
//		try {
//			User ur = (User) request.getSession().getAttribute("onlineUser");
//			String userLogin = ur.getId();
//			HttpSession session = request.getSession();
//			String listbyuser = request.getParameter("Id");
//			if (userLogin != listbyuser) {
//				listbyuser = userLogin;
//			}
//			List<Map<String, Object>> userseq = userDAO.sequense();
//			request.setAttribute("userseq", userseq);
//			List<Map<String, Object>> leave = leaveDAO.listoneperson(listbyuser); // à¸£Â à¸¢à¸™à¹‚ï¿½à¸Œà¸£Â à¸¢à¸˜à¹‚ï¿½à¸‚à¸£à¸‚à¹‚â‚¬ï¿½à¸¢à¸Œà¸£Â à¸¢à¸™à¹‚ï¿½à¸Œà¸£Â à¸¢à¸˜à¸«ï¿½à¸£à¸�à¸¢à¸Ÿà¸¢à¸�à¸£Â à¸¢à¸™à¹�à¸Ÿà¸�à¸£Â à¸¢à¸˜à¸¥à¸˜à¸£Â à¸¢à¸˜à¹�à¸Ÿà¸�à¸£Â à¸¢à¸™à¹‚ï¿½à¸Œà¸£Â à¸¢à¸˜à¹‚ï¿½à¸‚à¸£à¸‚à¹‚â‚¬ï¿½à¸¢à¸Œà¸£Â à¸¢à¸™à¹‚ï¿½à¸Œà¸£Â à¸¢à¸˜à¸«ï¿½à¸£à¸�à¸¢à¸Ÿà¸¢à¸�à¸£Â à¸¢à¸™à¹‚ï¿½à¸Œà¸£Â à¸¢à¸˜à¸«ï¿½à¸£à¸‚à¹‚ï¿½à¸Œà¸«ï¿½à¸£Â à¸¢à¸™à¹‚ï¿½à¸Œà¸£Â à¸¢à¸˜à¹‚ï¿½à¸‚à¸£à¸‚à¹‚â‚¬ï¿½à¸¢à¸Œà¸£Â à¸¢à¸™à¹‚ï¿½à¸Œà¸£Â à¸¢à¸˜à¸«ï¿½à¸£à¸�à¸¢à¸Ÿà¸¢à¸�à¸£Â à¸¢à¸™à¹�à¸Ÿà¸�à¸£Â à¸¢à¸˜à¸¥à¸˜à¸£Â à¸¢à¸˜à¹�à¸Ÿà¸�
//			request.setAttribute("leave", leave);
//			Double ThisYear = leaveDAO.ThisYearQuota(userLogin);
//			request.setAttribute("ThisYear", ThisYear);
//			List<Map<String, Object>> leavenameList = leaveDAO.findLeave();
//			request.setAttribute("leavenameList", leavenameList);
//			// request.setAttribute("leaveList", leaveDAO.findAll());
//			Date day = new Date();
//			LocalDate localdate = day.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
//			Double LastYear = leaveDAO.LastYearQuota(userLogin, localdate.getYear());
//			request.setAttribute("LastYear", LastYear);
//			Timestamp start_date = DateUtil.dateToTimestamp("01-01-" + DateUtil.getYear(), "00:00");
//			Timestamp end_date = DateUtil.dateToTimestamp("31-12-" + DateUtil.getYear(), "00:00");
//
//			List<Map<String, Object>> userleave = leaveDAO.findUserLeave(userLogin, start_date, end_date);
//
//			request.setAttribute("userleave", userleave);
//			BigDecimal LeavenumT1 = new BigDecimal(0);
//			BigDecimal LeavenumT2 = new BigDecimal(0);
//			BigDecimal LeavenumT3 = new BigDecimal(0);
//			BigDecimal LeavenumT4 = new BigDecimal(0);
//			BigDecimal LeavenumT5 = new BigDecimal(0);
//			BigDecimal LeavenumT6 = new BigDecimal(0);
//			BigDecimal LeavenumT9 = new BigDecimal(0);
//
//			BigDecimal LeaveWAnumT1 = new BigDecimal(0);
//			BigDecimal LeaveWAnumT2 = new BigDecimal(0);
//			BigDecimal LeaveWAnumT3 = new BigDecimal(0);
//			BigDecimal LeaveWAnumT4 = new BigDecimal(0);
//			BigDecimal LeaveWAnumT5 = new BigDecimal(0);
//			BigDecimal LeaveWAnumT6 = new BigDecimal(0);
//			BigDecimal LeaveWAnumT9 = new BigDecimal(0);
//
//			for (int i = 0; i < userleave.size(); i++) {
//				Character type = (Character) userleave.get(i).get(TYPELEAVE);
//				BigDecimal num = (BigDecimal) userleave.get(i).get(NODAY);
//				Character status = (Character) userleave.get(i).get(STATUS);
//				log.debug(type + "  " + num);
//
//				switch (status) {
//				case '0':
//					switch (type) {
//					case '1':
//						LeaveWAnumT1 = num.add(LeaveWAnumT1);
//						break;
//					case '2':
//						LeaveWAnumT2 = num.add(LeaveWAnumT2);
//						break;
//					case '3':
//						LeaveWAnumT3 = num.add(LeaveWAnumT3);
//						break;
//					case '4':
//						LeaveWAnumT4 = num.add(LeaveWAnumT4);
//						break;
//					case '5':
//						LeaveWAnumT5 = num.add(LeaveWAnumT5);
//						break;
//					case '6':
//						LeaveWAnumT6 = num.add(LeaveWAnumT6);
//						break;
//					case '9':
//						LeaveWAnumT9 = num.add(LeaveWAnumT9);
//						break;
//					}
//					break;
//				case '1':
//					switch (type) {
//					case '1':
//						LeavenumT1 = num.add(LeavenumT1);
//						break;
//					case '2':
//						LeavenumT2 = num.add(LeavenumT2);
//						break;
//					case '3':
//						LeavenumT3 = num.add(LeavenumT3);
//						break;
//					case '4':
//						LeavenumT4 = num.add(LeavenumT4);
//						break;
//					case '5':
//						LeavenumT5 = num.add(LeavenumT5);
//						break;
//					case '6':
//						LeavenumT6 = num.add(LeavenumT6);
//						break;
//					case '9':
//						LeavenumT9 = num.add(LeavenumT9);
//						break;
//					}
//					break;
//				default:
//					break;
//				}
//			}
//
//			log.debug(start_date + " userleave " + end_date);
//			log.debug("*****************************");
//			log.debug(LeavenumT1);
//			log.debug(LeavenumT2);
//			log.debug(LeavenumT3);
//			log.debug(LeavenumT4);
//			log.debug(LeavenumT5);
//			log.debug(LeavenumT6);
//			log.debug(LeavenumT9);
//
//			request.setAttribute("LeavenumT1", LeavenumT1);
//			request.setAttribute("LeaveWAnumT1", LeaveWAnumT1);
//			request.setAttribute("LeavenumT2", LeavenumT2);
//			request.setAttribute("LeaveWAnumT2", LeaveWAnumT2);
//			request.setAttribute("LeavenumT3", LeavenumT3);
//			request.setAttribute("LeaveWAnumT3", LeaveWAnumT3);
//			request.setAttribute("LeavenumT4", LeavenumT4);
//			request.setAttribute("LeaveWAnumT4", LeaveWAnumT4);
//			request.setAttribute("LeavenumT5", LeavenumT5);
//			request.setAttribute("LeaveWAnumT5", LeaveWAnumT5);
//			request.setAttribute("LeavenumT6", LeavenumT6);
//			request.setAttribute("LeaveWAnumT6", LeaveWAnumT6);
//			request.setAttribute("LeavenumT9", LeavenumT9);
//			request.setAttribute("LeaveWAnumT9", LeaveWAnumT9);
//			request.setAttribute("leaveList", leaveDAO.searchtable2(start_date, end_date, userLogin));
//
//			request.setAttribute("leavetypeList", leavetypeDAO.findAll2());
//			request.setAttribute("leaveuserList", leaveuserDAO.findAll());
//			request.setAttribute("userList", userDAO.findAll());
//			request.setAttribute("userS", userLogin);
//
//			List<LeaveType> type_leave = leavetypeDAO.findAll();
//			request.setAttribute("leavetypelistChoice", type_leave);
//			request.setAttribute("type_1", type_leave.get(0).getLeaveTypeName());
//			request.setAttribute("type_2", type_leave.get(1).getLeaveTypeName());
//			request.setAttribute("type_3", type_leave.get(2).getLeaveTypeName());
//			request.setAttribute("type_4", type_leave.get(3).getLeaveTypeName());
//			request.setAttribute("type_5", type_leave.get(4).getLeaveTypeName());
//			request.setAttribute("type_6", type_leave.get(5).getLeaveTypeName());
//			myleave();
//			log.debug("leave for admin");
//			return SUCCESS;
//		} catch (Exception e) {
//
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

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
				log.debug("have role");
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
				log.debug(type + "  " + num);

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

			log.debug(start_date + " userleave " + end_date);
			log.debug("*****************************");
			log.debug(LeavenumT1);
			log.debug(LeavenumT2);
			log.debug(LeavenumT3);
			log.debug(LeavenumT4);
			log.debug(LeavenumT5);
			log.debug(LeavenumT6);
			log.debug(LeavenumT7);
			log.debug(LeavenumT9);

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
			request.setAttribute("userS", userLogin);
			request.setAttribute("flag_search", "0");

			List<LeaveType> type_leave = leavetypeDAO.findAll();
			log.debug(type_leave);
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

//	public String openEdit() {
//		try {
//
//			List<Map<String, Object>> userseq = userDAO.sequense();
//			request.setAttribute("userseq", userseq);
//
//			User ur = (User) request.getSession().getAttribute("onlineUser"); // wishida
//			String userLogin = ur.getId();
//
//			String userId = request.getParameter("userId"); // applicant = null
//			if (userId == null || userId == userLogin) { // null not in loop
//				userId = userLogin;
//			}
//			if (userId == null && userId == userLogin) {
//				List<User> leader = userDAO.findBySelect(userId);
//				request.setAttribute("leader", leader);
//				request.setAttribute("userId", userId);
//			}
//			List<User> leader = userDAO.findBySelect(userId);
//			request.setAttribute("leader", leader);
//			request.setAttribute("userId", userId);
//			List<Map<String, Object>> leaveList = leaveDAO.findLeave();
//			request.setAttribute("leaveList", leaveList);
//			request.setAttribute("leavetypeList", leavetypeDAO.findAll_calendar());
//			request.setAttribute("leaveuserList", leaveuserDAO.findAll());
//			request.setAttribute("userList", userDAO.findAll());
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String select() {
//		try {
//			User ur = (User) request.getSession().getAttribute("onlineUser"); //
//			String userLogin = ur.getId();
//
//			String userId = request.getParameter("userId"); // applicant
//			request.setAttribute("userList", userDAO.findAll());
//			if (userId == null || userId == userLogin) { // null not in loop
//				userId = userLogin;
//			}
//			if (userId == null && userId == userLogin) {
//				List<User> leader = userDAO.findBySelect(userId);
//				request.setAttribute("leader", leader);
//				request.setAttribute("userId", userId);
//			}
//			leader = userDAO.findBySelect(userId);
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return ERROR;
//	}

//	public String add() {
//
//		try {
//			User ur = (User) request.getSession().getAttribute("onlineUser");
//			String userLogin = ur.getId();// online user
//			String userId = request.getParameter("name");
//
//			String leaveStatusId = request.getParameter("leaveStatusId");
//			String apprUserId = request.getParameter("apprUserId");
//			String description = request.getParameter("description");
//			String halfDay = request.getParameter("halfDay"); // null set 0
//			String reason = request.getParameter("reason");
//
//			String from = request.getParameter("from");
//			String to = request.getParameter("to");
//
//			String time_from = request.getParameter("time_from");
//			String time_to = request.getParameter("time_to");
//			log.debug("time from " + time_from);
//			log.debug("time to " + time_to);
//
//			Timestamp start_date = DateUtil.dateFormatEdit(from);// changeformat
//			Timestamp end_date = DateUtil.dateFormatEdit(to);// changeformat
//			String noDay = request.getParameter("noDay");
//			BigDecimal no_day = new BigDecimal(noDay);
//
//			Integer l = leaveDAO.getMaxId() + 1;
//			Leaves le = new Leaves();
//			le.setLeaveId(l);
//			String TypeId = request.getParameter("leaveTypeId");
//			if (!TypeId.equals("1") && !TypeId.equals("2") && !TypeId.equals("3") && !TypeId.equals("4")
//					&& !TypeId.equals("5") && !TypeId.equals("6")) {
//				le.setLeaveTypeId("9");
//			} else {
//				le.setLeaveTypeId(TypeId);
//			}
//
//			le.setLeaveStatusId(leaveStatusId);
//			le.setHalfDay(halfDay);
//			String hd = request.getParameter("halfDay");
//			if (hd == null) {
//				le.setHalfDay("0");
//			}
//			le.setUserId(userId);
//			le.setApprUserId(apprUserId);
//			le.setStartDate(start_date);
//			le.setEndDate(end_date);
//			le.setDescription(description);
//			le.setReason(reason);
//			le.setNoDay(no_day);
//			le.setUserCreate(userLogin);
//			le.setUserUpdate(userLogin);
//			le.setTimeCreate(DateUtil.getCurrentTime());
//			le.setTimeUpdate(DateUtil.getCurrentTime());
//
//			List<Map<String, Object>> leavenameList = leaveDAO.findLeave();
//			request.setAttribute("leavenameList", leavenameList);
//			request.setAttribute("leavenameList", leaveDAO.findAll());
//			request.setAttribute("leavetypeList", leavetypeDAO.findAll_calendar());
//			request.setAttribute("leaveuserList", leaveuserDAO.findAll());
//			request.setAttribute("test", "test");
//			request.setAttribute("id", userId);
//
//			leaveDAO.save(le);
//			return SUCCESS;
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String changesleader() {
//		try {
//			User ur = (User) request.getSession().getAttribute("onlineUser"); // wishida
//			String userLogin = ur.getId();
//
//			String userId = request.getParameter("userId"); // applicant = null
//			if (userId == null || userId == userLogin) {
//				userId = userLogin;
//			}
//
//			String apprUserId = request.getParameter("apprUserId"); // apirat.c
//			request.setAttribute("userList", userDAO.findAll());
//
//			if (apprUserId != null) {
//				List<Map<String, Object>> approve = userDAO.findByApprove(apprUserId); // null
//				request.setAttribute("approve", approve);
//				request.setAttribute("apprUserId", apprUserId);
//			}
//			approve = userDAO.findByApprove(apprUserId);
//			request.setAttribute("userId", userId);
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return ERROR;
//	}

//	public String performEdit() { // leave form with edit and approve
//		try {
//			List<Map<String, Object>> userseq = userDAO.sequense();
//			request.setAttribute("userseq", userseq);
//			String user_name = request.getParameter("user_id");
//			request.setAttribute("user_name", user_name);
//			request.setAttribute("flag_search", "1");
//			User ur = (User) request.getSession().getAttribute("onlineUser");
//			HttpSession session = request.getSession();
//			String vv = "leave.approve";
//			String x = ur.getRoleId();
//			int flag = 0;
//			if (x != null) {
//				Set<String> userAuthority = new HashSet<>();
//				List<RoleAuthorizedObject> roleAuthorizedObjectList = roleAuthorizedObjectDAO.findByRoleId(x);
//				if (roleAuthorizedObjectList != null) {
//					Iterator<RoleAuthorizedObject> it = roleAuthorizedObjectList.iterator();
//					while (it.hasNext()) {
//						RoleAuthorizedObject rao = it.next();
//						userAuthority.add(rao.getAuthorizedObjectId());
//						for (Object test : userAuthority) {
//							if (test.toString().indexOf(vv) != -1) {
//								flag = 1;
//
//							}
//						}
//					}
//				}
//				session.setAttribute("userAuthority", userAuthority);
//			}
//			request.setAttribute("flag", flag);
//			String id = request.getParameter("Id");
//			request.setAttribute("userList", userDAO.findAll());
//
//			if (id != null) {
//				List<Map<String, Object>> approve = leaveDAO.approverform(id);
//				request.setAttribute("approve", approve);
//				request.setAttribute("id", id);
//			}
//
//			List<Map<String, Object>> leavenameList = leaveDAO.findLeave();
//			request.setAttribute("leavenameList", leavenameList);
//			request.setAttribute("leaveList", leaveDAO.findAll());
//			request.setAttribute("leavetypeList", leavetypeDAO.findAll_calendar());
//
//			request.setAttribute("leaveuserList", leaveuserDAO.findAll());
//			request.setAttribute("userList", userDAO.findAll());
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return ERROR;
//	}

//	public String selectapprove() {
//		try {
//			String userId = request.getParameter("userId"); // applicant
//			request.setAttribute("userList", userDAO.findAll());
//			if (userId != null) {
//				List<User> leader = userDAO.findBySelect(userId);
//				request.setAttribute("leader", leader);
//				request.setAttribute("userId", userId);
//			}
//			leader = userDAO.findBySelect(userId);
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return ERROR;
//	}

//	public String approve() { // leave edit
//		try {
//			List<Map<String, Object>> userseq = userDAO.sequense();
//			request.setAttribute("userseq", userseq);
//
//			User ur = (User) request.getSession().getAttribute("onlineUser");
//			String userLogin = ur.getId();
//
//			String leaveid = request.getParameter("leaveId");
//			int leave_Id = Integer.valueOf(leaveid);
//
//			String userId = request.getParameter("name");
//			String leaveStatusId = request.getParameter("leaveStatusId");
//			String apprUserId = request.getParameter("apprUserId"); // have a
//																	// data
//			String description = request.getParameter("description");
//			String TypeId = request.getParameter("leaveTypeId");
//			String reason = request.getParameter("reason");// "" free
//
//			String noDay = request.getParameter("noDay");
//			BigDecimal no_day = new BigDecimal(noDay);
//
//			Leaves le = leaveDAO.findByLeaveId(leaveId);
//
//			le.setLeaveId(leave_Id);
//			if (!TypeId.equals("1") && !TypeId.equals("2") && !TypeId.equals("3") && !TypeId.equals("4")
//					&& !TypeId.equals("5") && !TypeId.equals("6")) {
//				le.setLeaveTypeId("9");
//			} else {
//				le.setLeaveTypeId(TypeId);
//			}
//			le.setLeaveStatusId(leaveStatusId);
//			le.setDescription(description);
//			le.setReason(reason);
//			le.setNoDay(no_day); // error
//			le.setUserUpdate(userLogin);
//			le.setUserId(userId); // get applicant
//			le.setApprUserId(apprUserId);
//			le.setTimeUpdate(DateUtil.getCurrentTime());
//
//			String halfDay = request.getParameter("halfDay");
//			if (halfDay == null) {
//				le.setHalfDay("0");
//			} else if (halfDay != "") {
//				le.setHalfDay(halfDay);
//			}
//
//			String startDate = request.getParameter("startDate");
//			if (startDate != "") {
//				Timestamp start_date = DateUtil.dateFormatEdit(startDate);
//				le.setStartDate(start_date);
//			}
//			String endDate = request.getParameter("endDate");
//			if (endDate != "") {
//				Timestamp end_date = DateUtil.dateFormatEdit(endDate);
//				le.setEndDate(end_date);
//			}
//
//			List<Leaves> leavenameList = leaveDAO.findAll();
//			request.setAttribute("leavenameList", leavenameList);
//			request.setAttribute("leavenameList", leaveDAO.findAll());
//			request.setAttribute("leavetypeList", leavetypeDAO.findAll());
//			request.setAttribute("leaveuserList", leaveuserDAO.findAll());
//
//			leaveDAO.update(le);
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String changesapprove() {
//		try {
//			String apprUserId = request.getParameter("apprUserId");
//			request.setAttribute("userList", userDAO.findAll());
//
//			if (apprUserId != null) {
//				List<Map<String, Object>> approve = leaveDAO.approverform(apprUserId);
//				request.setAttribute("approve", approve);
//				request.setAttribute("apprUserId", apprUserId);
//			}
//			approve = leaveDAO.approverform(apprUserId);
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return ERROR;
//	}

//	public String leave_wlist() { // link from user page
//		try {
//			String listbyuser = request.getParameter("Id");
//
//			List<Map<String, Object>> oneperson = leaveDAO.listwaitperson(listbyuser);
//			request.setAttribute("oneperson", oneperson);
//
//			request.setAttribute("userList", userDAO.findAll());
//
//			request.setAttribute("leaveoneuser", listbyuser);
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String searchleave() {
//		try {
//			String userSelect = request.getParameter("name1");
//			String typeLeaves = request.getParameter("type");
//			String startdate = request.getParameter("startdate");
//			String enddate = request.getParameter("enddate");
//
//			log.debug(userSelect);
//			log.debug(typeLeaves);
//			log.debug(startdate);
//			log.debug(enddate);
//
//			DateTimeFormatter date1 = DateTimeFormatter.ofPattern("01-01-yyyy");
//			LocalDate localDate = LocalDate.now();
//			String s = "00:00:00.0";
//
//			String start = request.getParameter("startdate");
//			String end = request.getParameter("enddate");
//			Timestamp start_date;
//			Timestamp end_date;
//			if (start == null && end == null) {
//				start_date = DateUtil.dateToTimestamp(date1.format(localDate), s);
//				end_date = DateUtil.changetoEndYear(date1.format(localDate));
//			} else {
//				start_date = DateUtil.dateFormatEdit(start);
//				end_date = DateUtil.dateFormatEdit(end);
//			}
//
//			if (!"All".equals(userSelect)) {
//				if (typeLeaves.equals("All")) {
//					log.debug("search");
//					request.setAttribute("leaveList", leaveDAO.searchapproved(start_date, end_date, userSelect));
//				} else {
//					request.setAttribute("leaveList",
//							leaveDAO.searchtable3(start_date, end_date, userSelect, typeLeaves)); // search
//																									// by
//																									// type
//				}
//			} else {
//				if (typeLeaves.equals("All")) {
//					request.setAttribute("leaveList", leaveDAO.searchapprovedall(start_date, end_date, userSelect));
//				} else {
//					request.setAttribute("leaveList",
//							leaveDAO.searchtable4(start_date, end_date, userSelect, typeLeaves));
//				}
//			}
//			request.setAttribute("flag_search", "1");
//			request.setAttribute("type", typeLeaves);
//			request.setAttribute("userId", userSelect);
//			request.setAttribute("userSelect", userSelect);
//
//			List<Map<String, Object>> cubeUser = userDAO.allName();
//			request.setAttribute("cubeUser", cubeUser);
//
//			List<Map<String, Object>> userseq = userDAO.sequense();
//			request.setAttribute("userseq", userseq);
//
//			Timestamp startDate = DateUtil.changeYearStart(startdate);
//			request.setAttribute("startdate", startDate);
//
//			Timestamp endDate = DateUtil.changeYearEnd(enddate);
//			request.setAttribute("enddate", endDate);
//
//			List<Map<String, Object>> leavenameList = leaveDAO.findLeave();
//			request.setAttribute("leavenameList", leavenameList);
//			List<LeaveType> type_leave = leavetypeDAO.findAll();
//
//			request.setAttribute("type_1", type_leave.get(0).getLeaveTypeName());
//			request.setAttribute("type_2", type_leave.get(1).getLeaveTypeName());
//			request.setAttribute("type_3", type_leave.get(2).getLeaveTypeName());
//			request.setAttribute("type_4", type_leave.get(3).getLeaveTypeName());
//			request.setAttribute("type_5", type_leave.get(4).getLeaveTypeName());
//			request.setAttribute("type_6", type_leave.get(5).getLeaveTypeName());
//			request.setAttribute("type_7", type_leave.get(6).getLeaveTypeName());
//			request.setAttribute("type_9", type_leave.get(7).getLeaveTypeName());
//			request.setAttribute("leavetypelistChoice", type_leave);
//			myleave();
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

	public static final String TYPELEAVE = "leave_type_id";
	public static final String NODAY = "no_day";
	public static final String STATUS = "leave_status_id";

//	public String searchleaveapproved() {
//		try {
//			String userSelect = request.getParameter("name1");
//			String leaveStatus = request.getParameter("appr");
//			String startdate = request.getParameter("startdate");
//			String enddate = request.getParameter("enddate");
//			log.debug(leaveStatus);
//			log.debug(startdate);
//			log.debug(enddate);
//			log.debug(userSelect);
//
//			DateTimeFormatter date1 = DateTimeFormatter.ofPattern("01-01-yyyy");
//			LocalDate localDate = LocalDate.now();
//			String s = "00:00:00.0";
//
//			String start = request.getParameter("startdate");
//			String end = request.getParameter("enddate");
//			Timestamp start_date;
//			Timestamp end_date;
//			Timestamp start_date1 = DateUtil.dateToTimestamp(startdate, "00:00");
//			Timestamp end_date1 = DateUtil.dateToTimestamp(enddate, "00:00");
//			if (start == null && end == null) {
//				start_date = DateUtil.dateToTimestamp(date1.format(localDate), s);
//				end_date = DateUtil.changetoEndYear(date1.format(localDate));
//			} else {
//				start_date = DateUtil.dateFormatEdit(start);
//				end_date = DateUtil.dateFormatEdit(end);
//			}
//			if (!"All".equals(userSelect)) {
//				if (leaveStatus.equals("3")) {
//					request.setAttribute("leaveList", leaveDAO.searchtable2(start_date, end_date, userSelect));
//				} else {
//					request.setAttribute("leaveList",
//							leaveDAO.searchtable2(start_date, end_date, userSelect, leaveStatus)); // search
//																									// by
//																									// type
//				}
//			} else {
//				if (leaveStatus.equals("3")) {
//					log.debug("'select all'");
//					List<Map<String, Object>> leaveList = leaveDAO.searchtableAll(start_date, end_date);
//					/*
//					 * List<Map<String, Object>> leaveList = leaveDAO.searchtable(start_date,
//					 * end_date, userSelect);
//					 */
//					request.setAttribute("leaveList", leaveList);
//				} else {
//					request.setAttribute("leaveList",
//							leaveDAO.searchtable(start_date, end_date, userSelect, leaveStatus));
//				}
//			}
//
//			Date day = new Date();
//			LocalDate localdate = day.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
//			List<Map<String, Object>> userleave = null;
//			if (!"All".equals(userSelect)) {
//				Double LastYear = leaveDAO.LastYearQuota(userSelect, localdate.getYear());
//				request.setAttribute("LastYear", LastYear);
//				Double ThisYear = leaveDAO.ThisYearQuota(userSelect);
//				request.setAttribute("ThisYear", ThisYear);
//				log.debug("lastyear: " + LastYear);
//				log.debug("thisyear: " + ThisYear);
//
//				userleave = leaveDAO.findUserLeave(userSelect, start_date1, end_date1);
//			} else {
//				userleave = leaveDAO.findUserAllLeave(start_date1, end_date1);
//			}
//			request.setAttribute("userleave", userleave);
//			BigDecimal LeavenumT1 = new BigDecimal(0);
//			BigDecimal LeavenumT2 = new BigDecimal(0);
//			BigDecimal LeavenumT3 = new BigDecimal(0);
//			BigDecimal LeavenumT4 = new BigDecimal(0);
//			BigDecimal LeavenumT5 = new BigDecimal(0);
//			BigDecimal LeavenumT6 = new BigDecimal(0);
//			BigDecimal LeavenumT7 = new BigDecimal(0);
//			BigDecimal LeavenumT9 = new BigDecimal(0);
//
//			BigDecimal LeaveWAnumT1 = new BigDecimal(0);
//			BigDecimal LeaveWAnumT2 = new BigDecimal(0);
//			BigDecimal LeaveWAnumT3 = new BigDecimal(0);
//			BigDecimal LeaveWAnumT4 = new BigDecimal(0);
//			BigDecimal LeaveWAnumT5 = new BigDecimal(0);
//			BigDecimal LeaveWAnumT6 = new BigDecimal(0);
//			BigDecimal LeaveWAnumT7 = new BigDecimal(0);
//			BigDecimal LeaveWAnumT9 = new BigDecimal(0);
//
//			for (int i = 0; i < userleave.size(); i++) {
//				Character type = (Character) userleave.get(i).get(TYPELEAVE);
//				BigDecimal num = (BigDecimal) userleave.get(i).get(NODAY);
//				Character status = (Character) userleave.get(i).get(STATUS);
//				log.debug(type + "  " + num);
//
//				try {
//					switch (status) {
//					case '0':
//						switch (type) {
//						case '1':
//							LeaveWAnumT1 = num.add(LeaveWAnumT1);
//							break;
//						case '2':
//							LeaveWAnumT2 = num.add(LeaveWAnumT2);
//							break;
//						case '3':
//							LeaveWAnumT3 = num.add(LeaveWAnumT3);
//							break;
//						case '4':
//							LeaveWAnumT4 = num.add(LeaveWAnumT4);
//							break;
//						case '5':
//							LeaveWAnumT5 = num.add(LeaveWAnumT5);
//							break;
//						case '6':
//							LeaveWAnumT6 = num.add(LeaveWAnumT6);
//							break;
//						case '7':
//							LeaveWAnumT7 = num.add(LeaveWAnumT7);
//							break;
//						case '9':
//							LeaveWAnumT9 = num.add(LeaveWAnumT9);
//							break;
//						}
//						break;
//					case '1':
//						switch (type) {
//						case '1':
//							LeavenumT1 = num.add(LeavenumT1);
//							break;
//						case '2':
//							LeavenumT2 = num.add(LeavenumT2);
//							break;
//						case '3':
//							LeavenumT3 = num.add(LeavenumT3);
//							break;
//						case '4':
//							LeavenumT4 = num.add(LeavenumT4);
//							break;
//						case '5':
//							LeavenumT5 = num.add(LeavenumT5);
//							break;
//						case '6':
//							LeavenumT6 = num.add(LeavenumT6);
//							break;
//						case '7':
//							LeavenumT7 = num.add(LeavenumT7);
//							break;
//						case '9':
//							LeavenumT9 = num.add(LeavenumT9);
//							break;
//						}
//						break;
//					default:
//						break;
//					}
//				} catch (Exception e) {
//
//				}
//			}
//
//			request.setAttribute("LeavenumT1", LeavenumT1);
//			request.setAttribute("LeaveWAnumT1", LeaveWAnumT1);
//			request.setAttribute("LeavenumT2", LeavenumT2);
//			request.setAttribute("LeaveWAnumT2", LeaveWAnumT2);
//			request.setAttribute("LeavenumT3", LeavenumT3);
//			request.setAttribute("LeaveWAnumT3", LeaveWAnumT3);
//			request.setAttribute("LeavenumT4", LeavenumT4);
//			request.setAttribute("LeaveWAnumT4", LeaveWAnumT4);
//			request.setAttribute("LeavenumT5", LeavenumT5);
//			request.setAttribute("LeaveWAnumT5", LeaveWAnumT5);
//			request.setAttribute("LeavenumT6", LeavenumT6);
//			request.setAttribute("LeaveWAnumT6", LeaveWAnumT6);
//			request.setAttribute("LeavenumT7", LeavenumT7);
//			request.setAttribute("LeaveWAnumT7", LeaveWAnumT7);
//			request.setAttribute("LeavenumT9", LeavenumT9);
//			request.setAttribute("LeaveWAnumT9", LeaveWAnumT9);
//
//			request.setAttribute("flag_search", "1");
//			request.setAttribute("appr", leaveStatus);
//			request.setAttribute("userId", userSelect);
//			request.setAttribute("userSelect", userSelect);
//			request.setAttribute("userS", userSelect);
//			request.setAttribute("logonUser", userSelect);
//			List<Map<String, Object>> cubeUser = userDAO.allName();
//			request.setAttribute("cubeUser", cubeUser);
//
//			List<Map<String, Object>> userseq = userDAO.sequense();
//			request.setAttribute("userseq", userseq);
//
//			Timestamp startDate = DateUtil.changeYearStart(startdate);
//			request.setAttribute("startdate", startDate);
//
//			Timestamp endDate = DateUtil.changeYearEnd(enddate);
//			request.setAttribute("enddate", endDate);
//
//			List<Map<String, Object>> leavenameList = leaveDAO.findLeave();
//			request.setAttribute("leavenameList", leavenameList);
//			List<LeaveType> type_leave = leavetypeDAO.findAll();
//
//			request.setAttribute("type_1", type_leave.get(0).getLeaveTypeName());
//			request.setAttribute("type_2", type_leave.get(1).getLeaveTypeName());
//			request.setAttribute("type_3", type_leave.get(2).getLeaveTypeName());
//			request.setAttribute("type_4", type_leave.get(3).getLeaveTypeName());
//			request.setAttribute("type_5", type_leave.get(4).getLeaveTypeName());
//			request.setAttribute("type_6", type_leave.get(5).getLeaveTypeName());
//			request.setAttribute("type_7", type_leave.get(6).getLeaveTypeName());
//			request.setAttribute("type_9", type_leave.get(7).getLeaveTypeName());
//			request.setAttribute("leavetypelistChoice", type_leave);
//			myleave();
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String LeaveApproveExcelExport() {
//		try {
//			String userSelect = request.getParameter("name1");
//			String userSelect2 = request.getParameter("name2");
//			String leaveStatus = request.getParameter("appr");
//			String startdate = request.getParameter("startdate");
//			String enddate = request.getParameter("enddate");
//			String leaveType = request.getParameter("leaveType");
//			log.debug(leaveType);
//
//			User ur = (User) request.getSession().getAttribute("onlineUser");
//			String userLogin = ur.getId();
//			log.debug(userLogin);
//
//			String user_role = ur.getRoleId();
//			log.debug("user_role: " + user_role);
//			request.setAttribute("user_role", user_role);
//
//			DateTimeFormatter date1 = DateTimeFormatter.ofPattern("01-01-yyyy");
//			LocalDate localDate = LocalDate.now();
//			String s = "00:00:00.0";
//
//			String start = request.getParameter("startdate");
//			String end = request.getParameter("enddate");
//			Timestamp start_date;
//			Timestamp end_date;
//			List<Map<String, Object>> leaveList = null;
//
//			if (start == null && end == null) {
//				start_date = DateUtil.dateToTimestamp(date1.format(localDate), s);
//				end_date = DateUtil.changetoEndYear(date1.format(localDate));
//			} else {
//				start_date = DateUtil.dateFormatEdit(start);
//				end_date = DateUtil.dateFormatEdit(end);
//			}
//			
//			if((!userSelect.isEmpty() || userSelect != null) && (userSelect2.isEmpty() || userSelect2 == null)) {
//				if (userSelect.equalsIgnoreCase("All")) { //if choose "All Employee"
//					request.setAttribute("role_authorized", "1");
//					userLogin = null;
//					leaveList = leaveDAO.findLeaveInTeamByManagerAndType(start_date, end_date, userLogin, leaveStatus, leaveType);
//
//				} else {	//if choose "All Manage"
//					request.setAttribute("role_authorized", "0");
//					leaveList = leaveDAO.findLeaveInTeamByManagerAndType(start_date, end_date, userLogin, leaveStatus, leaveType);
//				}
//
//			} else if((!userSelect.isEmpty() || userSelect != null) && (!userSelect2.isEmpty() || userSelect2 != null)) {
//				log.debug("1 user");
//				if (userSelect.equalsIgnoreCase("All")) {	//if choose "All Employee"
//					request.setAttribute("role_authorized", "1");
//					leaveList = leaveDAO.findUserLeaveByTypeAndStatus(start_date, end_date, userSelect2, leaveStatus, leaveType);
//				} else {	//if choose "All Manage"
//					request.setAttribute("role_authorized", "0");
//					leaveList = leaveDAO.findUserLeaveByTypeAndStatus(start_date, end_date, userSelect2, leaveStatus, leaveType);
//				}
//			}
//			request.setAttribute("leaveList", leaveList);
//
//			log.debug(leaveList);
//			log.debug(leaveStatus);
//			log.debug(startdate + "/" + enddate);
//			log.debug(userSelect + "/" + userSelect2);
//			// Date now
//			localDate = LocalDate.now();
//			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMMM yyyy");
//			String formattedDateTime = localDate.format(formatter);
//
//			// First
//			ServletContext context = request.getServletContext();
//			String fileServerPath = context.getRealPath("/");
//			File myFile = new File(fileServerPath + "upload/template/report_leaveapprove.xlsx");
//			FileInputStream file = new FileInputStream(myFile);
//
//			// Second
//			XSSFWorkbook wb = new XSSFWorkbook(file);
//			XSSFSheet sheet = wb.getSheetAt(0);
//			XSSFRow row = sheet.getRow(6);
//			XSSFFont font = wb.createFont();
//			font.setFontHeightInPoints((short) 12);
//			font.setFontName("TH Sarabun PSK");
//			font.setBold(false);
//			font.setItalic(false);
//			XSSFCellStyle styleEven = wb.createCellStyle();
//			styleEven.setAlignment(HorizontalAlignment.CENTER);
//			styleEven.setFont(font);
//			styleEven.setBorderBottom(BorderStyle.THIN);
//			styleEven.setBorderLeft(BorderStyle.THIN);
//			styleEven.setBorderTop(BorderStyle.THIN);
//			styleEven.setBorderRight(BorderStyle.THIN);
//			styleEven.setFillForegroundColor(new XSSFColor(new java.awt.Color(242, 242, 242)));
//			styleEven.setFillPattern(FillPatternType.SOLID_FOREGROUND);
//
//			XSSFCellStyle styleOdd = wb.createCellStyle();
//			styleOdd.setAlignment(HorizontalAlignment.CENTER);
//			styleOdd.setFont(font);
//			styleOdd.setBorderBottom(BorderStyle.THIN);
//			styleOdd.setBorderLeft(BorderStyle.THIN);
//			styleOdd.setBorderTop(BorderStyle.THIN);
//			styleOdd.setBorderRight(BorderStyle.THIN);
//			
//			XSSFCellStyle styleLeftEven = wb.createCellStyle();
//			styleLeftEven.setAlignment(HorizontalAlignment.LEFT);
//			styleLeftEven.setFont(font);
//			styleLeftEven.setBorderBottom(BorderStyle.THIN);
//			styleLeftEven.setBorderLeft(BorderStyle.THIN);
//			styleLeftEven.setBorderTop(BorderStyle.THIN);
//			styleLeftEven.setBorderRight(BorderStyle.THIN);
//			styleLeftEven.setFillForegroundColor(new XSSFColor(new java.awt.Color(242, 242, 242)));
//			styleLeftEven.setFillPattern(FillPatternType.SOLID_FOREGROUND);
//			
//			XSSFCellStyle styleLeftOdd = wb.createCellStyle();
//			styleLeftEven.setAlignment(HorizontalAlignment.LEFT);
//			styleLeftOdd.setFont(font);
//			styleLeftOdd.setBorderBottom(BorderStyle.THIN);
//			styleLeftOdd.setBorderLeft(BorderStyle.THIN);
//			styleLeftOdd.setBorderTop(BorderStyle.THIN);
//			styleLeftOdd.setBorderRight(BorderStyle.THIN);
//			int rowIndex = 5;
//
//			XSSFCellStyle casual = wb.createCellStyle();
//			casual.setFont(font);
//
//			// Date Section
//			SimpleDateFormat inputFormat = new SimpleDateFormat("dd-MM-yyyy");
//			SimpleDateFormat outputFormat = new SimpleDateFormat("dd MMMM yyyy", Locale.ENGLISH);
//			Date date = inputFormat.parse(start);
//			String formatSDate = outputFormat.format(date);
//			date = inputFormat.parse(end);
//			String formatEDate = outputFormat.format(date);
//			String formatDatePick = formatSDate + " - " + formatEDate;
//
//			row = sheet.getRow(2);
//			XSSFCell cell = row.createCell(1);
//			cell.setCellValue(formatDatePick);
//			cell.setCellStyle(casual);
//			cell = row.createCell(4);
//			cell.setCellValue(formattedDateTime);
//			cell.setCellStyle(casual);
//			
//			
//			String name,leave_type_name,sd,ed,start_time,end_time,no_day,leave_status_id;
//			DecimalFormat decimalFormat = new DecimalFormat("0.0");
//			inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
//			outputFormat = new SimpleDateFormat("dd-MM-yyyy");
//			// Data Section
//			for (Map<String, Object> data : leaveList) {
//				//set no
//				int no = rowIndex - 4;
//				//set name
//				name = data.get("name") == null ? null : data.get("name").toString();
//				//set leave_type
//				leave_type_name = data.get("leave_type_name") == null ? null : data.get("leave_type_name").toString();
//				//set startdate , enddate
//				sd = data.get("start_date") == null ? null : data.get("start_date").toString();
//				date = inputFormat.parse(sd);
//				formatSDate = outputFormat.format(date);
//				ed = data.get("end_date") == null ? null : data.get("end_date").toString();
//				date = inputFormat.parse(ed);
//				formatEDate = outputFormat.format(date);
//				//set time
//				start_time = data.get("start_time") == null ? null : data.get("start_time").toString();
//				end_time = data.get("end_time") == null ? null : data.get("end_time").toString();
//				//set no_day
//				no_day = decimalFormat.format(data.get("no_day") == null ? 0 : Double.parseDouble(data.get("no_day").toString()));
//				//set status
//				leave_status_id = data.get("leave_status_id") == null ? null : data.get("leave_status_id").toString();
//				if( leave_status_id.equals("0") ) { leave_status_id = "Wait for approve"; }
//				else if( leave_status_id.equals("1") ) { leave_status_id = "Approved"; }
//				else if( leave_status_id.equals("2") ) { leave_status_id = "Reject"; }
//				else { leave_status_id = "Cancel"; }
//				//set cell value
//				if (rowIndex % 2 == 0) {
//					row = sheet.createRow(rowIndex);
//					
//					cell = row.createCell(0);
//					cell.setCellValue(no);
//					cell.setCellStyle(styleEven);
//					
//					cell = row.createCell(1);
//					cell.setCellValue(name);
//					cell.setCellStyle(styleLeftEven);
//					
//					cell = row.createCell(2);
//					cell.setCellValue(leave_type_name);
//					cell.setCellStyle(styleEven);
//					
//					cell = row.createCell(3);
//					cell.setCellValue(formatSDate);
//					cell.setCellStyle(styleEven);
//	
//					cell = row.createCell(4);
//					cell.setCellValue(formatEDate);
//					cell.setCellStyle(styleEven);
//					
//					cell = row.createCell(5);
//					cell.setCellValue(start_time + "-" + end_time);
//					cell.setCellStyle(styleEven);
//					
//					cell = row.createCell(6);
//					cell.setCellValue(no_day);
//					cell.setCellStyle(styleEven);
//					
//					cell = row.createCell(7);
//					cell.setCellValue(leave_status_id);
//					cell.setCellStyle(styleLeftOdd);
//				} else {
//					row = sheet.createRow(rowIndex);
//
//					cell = row.createCell(0);
//					cell.setCellValue(no);
//					cell.setCellStyle(styleOdd);
//					
//					cell = row.createCell(1);
//					cell.setCellValue(name);
//					cell.setCellStyle(styleLeftOdd);
//					
//					cell = row.createCell(2);
//					cell.setCellValue(leave_type_name);
//					cell.setCellStyle(styleOdd);
//					
//					cell = row.createCell(3);
//					cell.setCellValue(formatSDate);
//					cell.setCellStyle(styleOdd);
//					
//					cell = row.createCell(4);
//					cell.setCellValue(formatEDate);
//					cell.setCellStyle(styleOdd);
//					
//					cell = row.createCell(5);
//					cell.setCellValue(start_time + "-" + end_time);
//					cell.setCellStyle(styleOdd);
//					
//					cell = row.createCell(6);
//					cell.setCellValue(no_day);
//					cell.setCellStyle(styleOdd);
//					
//					cell = row.createCell(7);
//					cell.setCellValue(leave_status_id);
//					cell.setCellStyle(styleLeftOdd);
//				}
//				rowIndex++;
//			}
//
//			// third step, save the file to a stream
//			ByteArrayOutputStream os = new ByteArrayOutputStream();
//			wb.write(os);
//			byte[] fileContent = os.toByteArray();
//			ByteArrayInputStream is = new ByteArrayInputStream(fileContent);
//
//			excelStream = is; // file stream
//			excelFileName = "report_leave.xlsx"; // set the download file name
//			return SUCCESS;
//		} catch (
//
//		Exception e) {
//			log.error(e);
//			return ERROR;
//		}
//	}

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

//	public String searchmyleave() {
//		try {
//			User ur = (User) request.getSession().getAttribute("onlineUser");
//			String userLogin = ur.getId();
//
//			String startdate = request.getParameter("startdate");
//			String enddate = request.getParameter("enddate");
//			String s = "00:00:00.0";
//
//			Timestamp start_date = DateUtil.dateToTimestamp(startdate, s);
//			Timestamp end_date = DateUtil.changeYearEnd(enddate);
//
//			List<Map<String, Object>> leave = leaveDAO.searchtable2(start_date, end_date, userLogin);
//
//			request.setAttribute("leave", leave);
//
//			request.setAttribute("userList", userDAO.findAll());
//			request.setAttribute("leavetypeList", leavetypeDAO.findAll_calendar());
//
//			Timestamp startDate = DateUtil.changeYearStart(startdate);
//			request.setAttribute("startdate", startDate);
//			Timestamp endDate = DateUtil.changeYearEnd(enddate);
//			request.setAttribute("enddate", endDate);
//
//			request.setAttribute("userLogin", userLogin);
//			BigDecimal x1 = new BigDecimal(0);
//			BigDecimal x2 = new BigDecimal(0);
//			BigDecimal x3 = new BigDecimal(0);
//			BigDecimal x4;
//
//			List<Map<String, Object>> wanla1 = leaveDAO.findPatiwanla(userLogin, 1, startDate, endDate);
//			List<Map<String, Object>> wanla2 = leaveDAO.findPatiwanla(userLogin, 2, startDate, endDate);
//			List<Map<String, Object>> wanla3 = leaveDAO.findPatiwanla(userLogin, 3, startDate, endDate);
//			int n1 = wanla1.size();
//			int n2 = wanla2.size();
//			int n3 = wanla3.size();
//			for (int i = 0; i < n1; i++) {
//				BigDecimal a = (BigDecimal) wanla1.get(i).get("no_day");
//
//				BigDecimal b = a;
//
//				x1 = b.add(x1);
//
//				request.setAttribute("x1", x1);
//
//			}
//
//			for (int i = 0; i < n2; i++) {
//				BigDecimal a = (BigDecimal) wanla2.get(i).get("no_day");
//
//				BigDecimal b = a;
//
//				x2 = b.add(x2);
//
//				request.setAttribute("x2", x2);
//
//			}
//
//			for (int i = 0; i < n3; i++) {
//				BigDecimal a = (BigDecimal) wanla3.get(i).get("no_day");
//
//				BigDecimal b = a;
//
//				x3 = b.add(x3);
//
//				request.setAttribute("x3", x3);
//
//			}
//			x4 = x1.add(x2).add(x3);
//			request.setAttribute("x4", x4);
//
//			List<LeaveType> type_leave = leavetypeDAO.findAll_calendar();
//			request.setAttribute("type_1", type_leave.get(0).getLeaveTypeName());
//			request.setAttribute("type_2", type_leave.get(1).getLeaveTypeName());
//			request.setAttribute("type_3", type_leave.get(2).getLeaveTypeName());
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String listmy() {
//		try {
//			String check_flag1 = request.getParameter("flag");
//			String useradd = request.getParameter("useradd");
//
//			if (check_flag1 != null) {
//				check_flag = check_flag1;
//
//				request.setAttribute("flag_1", check_flag1);
//				String date = request.getParameter("date");
//				request.setAttribute("date_calendar", date);
//			}
//			List<Map<String, Object>> userseq = userDAO.sequense();
//			request.setAttribute("userseq", userseq);
//			request.setAttribute("useradd", useradd);
//			HttpSession session = request.getSession();
//			User ur = (User) request.getSession().getAttribute("onlineUser"); // wishida
//			String userLogin = ur.getId();
//			String date = request.getParameter("date");
//			request.setAttribute("date", date); // Set Date from Click Calendar
//			String vv = "leave.approve";
//			String x = ur.getRoleId();
//			int flag = 0;
//			if (x != null) {
//				Set<String> userAuthority = new HashSet<>();
//				List<RoleAuthorizedObject> roleAuthorizedObjectList = roleAuthorizedObjectDAO.findByRoleId(x);
//				if (roleAuthorizedObjectList != null) {
//					Iterator<RoleAuthorizedObject> it = roleAuthorizedObjectList.iterator();
//					while (it.hasNext()) {
//						RoleAuthorizedObject rao = it.next();
//						userAuthority.add(rao.getAuthorizedObjectId());
//						for (Object test : userAuthority) {
//							if (test.toString().indexOf(vv) != -1) {
//								flag = 1;
//							}
//						}
//					}
//				}
//				session.setAttribute("userAuthority", userAuthority);
//			}
//			request.setAttribute("flag", flag);
//			String userId = request.getParameter("userId"); // applicant = null
//			if (userId == null || userId == userLogin) { // null not in loop
//				userId = userLogin;
//			}
//			if (userId == null && userId == userLogin) {
//				List<User> leader = userDAO.findBySelect(userId);
//				request.setAttribute("leader", leader);
//				request.setAttribute("userId", userId);
//			}
//			List<User> leader = userDAO.findBySelect(userId);
//			request.setAttribute("leader", leader);
//			request.setAttribute("userId", userId);
//			System.out.println("this one");
//			List<Map<String, Object>> leaveList = leaveDAO.findLeave();
//			request.setAttribute("leaveList", leaveList);
//
//			List<LeaveType> leavetypeList = leavetypeDAO.findAll_calendar();
//			request.setAttribute("leavetypeList", leavetypeList);
//
//			request.setAttribute("leaveuserList", leaveuserDAO.findAll());
//			request.setAttribute("userList", userDAO.findAll());
//			List<Map<String, Object>> holidayList = leaveDAO.findHoliday();
//			request.setAttribute("holidayList", holidayList);
//			List<Map<String, Object>> setHoli = timesheetDAO.findHoliday2();
//			request.setAttribute("setHoli", setHoli);
//			List<Map<String, Object>> cutholiday = leaveDAO.findHoliday3();
//			request.setAttribute("cutholiday", cutholiday);
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String changesmyleader() {
//		try {
//			User ur = (User) request.getSession().getAttribute("onlineUser"); // wishida
//			String userLogin = ur.getId();
//
//			String userId = request.getParameter("userId"); // applicant = null
//			if (userId == null || userId == userLogin) {
//				userId = userLogin;
//			}
//
//			String apprUserId = request.getParameter("apprUserId"); // apirat.c
//			request.setAttribute("userList", userDAO.findAll());
//
//			if (apprUserId != null) {
//				List<Map<String, Object>> approve = userDAO.findByApprove(apprUserId); // null
//				request.setAttribute("approve", approve);
//				request.setAttribute("apprUserId", apprUserId);
//			}
//			approve = userDAO.findByApprove(apprUserId);
//			request.setAttribute("userId", userId);
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return ERROR;
//	}

//	public String selectmyleader() {
//		try {
//			String userId = request.getParameter("userId"); // applicant
//			request.setAttribute("userList", userDAO.findAll());
//			if (userId != null) {
//				List<User> leader = userDAO.findBySelect(userId);
//				request.setAttribute("leader", leader);
//				request.setAttribute("userId", userId);
//			}
//			leader = userDAO.findBySelect(userId);
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String addmy() {
//		try {
//			User ur = (User) request.getSession().getAttribute("onlineUser");
//			String userLogin = ur.getId();// online user
//			// getParameter
//			String userId = request.getParameter("name");
//			String leaveStatusId = request.getParameter("leaveStatusId");
//			String apprUserId = request.getParameter("apprUserId"); // Approvers
//			String description = request.getParameter("description");
//			String halfDay = request.getParameter("halfDay");// null set 0
//			String reason = request.getParameter("reason");
//			String time_hours = request.getParameter("comboA");
//			String from = request.getParameter("from");
//			String to = request.getParameter("to");
//
//			java.util.Date utilDate = new SimpleDateFormat("dd-MM-yyyy").parse(from);
//			java.sql.Date start_date1 = new java.sql.Date(utilDate.getTime());
//
//			Timestamp start_date = DateUtil.dateFormatEdit(from);// changeformat
//			Timestamp end_date = DateUtil.dateFormatEdit(to);// changeformat
//			String noDay = request.getParameter("noDay");
//			BigDecimal no_day = new BigDecimal(noDay);
//			BigDecimal time_comboA = new BigDecimal(time_hours);
//			BigDecimal result = no_day.add(time_comboA);
//			Integer l = leaveDAO.getMaxId() + 1;
//			Leaves le = new Leaves();
//			le.setLeaveId(l);
//			String TypeId = request.getParameter("leaveTypeId");
//			log.debug(TypeId);
//			if (!TypeId.equals("1") && !TypeId.equals("2") && !TypeId.equals("3") && !TypeId.equals("4")
//					&& !TypeId.equals("5") && !TypeId.equals("6")) {
//				le.setLeaveTypeId("9");
//			} else {
//				le.setLeaveTypeId(TypeId);
//			}
//			if (leaveStatusId == null) {
//				le.setLeaveStatusId("0");
//			} else {
//				le.setLeaveStatusId(leaveStatusId);
//			}
//
//			le.setHalfDay(halfDay);
//
//			String hd = request.getParameter("halfDay");
//			if (hd == null) {
//				le.setHalfDay("0");
//			}
//			le.setUserId(userId);
//			le.setApprUserId(apprUserId);
//			le.setStartDate(start_date);
//			le.setEndDate(end_date);
//			le.setDescription(description);
//			le.setReason(reason);
//			le.setNoDay(result);
//			le.setUserCreate(userLogin);
//			le.setUserUpdate(userLogin);
//			le.setTimeCreate(DateUtil.getCurrentTime());
//			le.setTimeUpdate(DateUtil.getCurrentTime());
//
//			List<Map<String, Object>> leavenameList = leaveDAO.findLeave();
//
//			request.setAttribute("leavenameList", leavenameList);
//			request.setAttribute("leavenameList", leaveDAO.findAll());
//			request.setAttribute("leavetypeList", leavetypeDAO.findAll());
//			request.setAttribute("leaveuserList", leaveuserDAO.findAll());
//
//			leaveDAO.save(le);
//			request.setAttribute("flag", check_flag);
//			String status = "";
//			Map<String, String> obj = new HashMap<>();
//
//			if (check_flag.equals("1")) {
//				check_flag = "";
//				return SUCCESS;
//			}
//
//			request.setAttribute("flag12", start_date1);
//			return INPUT;
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String listone() {
//		try {
//			List<Map<String, Object>> userseq = userDAO.sequense();
//			request.setAttribute("userseq", userseq);
//			check_flag = "1";
//			User ur = (User) request.getSession().getAttribute("onlineUser");
//			String userLogin = ur.getId();
//			HttpSession session = request.getSession();
//			String listbyuser = request.getParameter("Id");
//
//			DateTimeFormatter date1 = DateTimeFormatter.ofPattern("01-01-yyyy");
//			DateTimeFormatter dateNow = DateTimeFormatter.ofPattern("dd-MM-yyyy");
//			LocalDate localDate = LocalDate.now();
//			String s = "00:00:00.0";
//
//			Timestamp start_date = DateUtil.dateToTimestamp(date1.format(localDate), s);
//			Timestamp end_date = DateUtil.changeYearEnd(dateNow.format(localDate));
//
//			if (userLogin != listbyuser) {
//				listbyuser = userLogin;
//			}
//			List<Map<String, Object>> oneperson = leaveDAO.searchtable2(start_date, end_date, userLogin);
//			request.setAttribute("oneperson", oneperson);
//			BigDecimal x1 = new BigDecimal(0);
//			BigDecimal x2 = new BigDecimal(0);
//			BigDecimal x3 = new BigDecimal(0);
//			BigDecimal x4 = new BigDecimal(0);
//			List<Map<String, Object>> wanla1 = leaveDAO.findPatiwanla(userLogin, 1, start_date, end_date);
//			List<Map<String, Object>> wanla2 = leaveDAO.findPatiwanla(userLogin, 2, start_date, end_date);
//			List<Map<String, Object>> wanla3 = leaveDAO.findPatiwanla(userLogin, 3, start_date, end_date);
//			List<Map<String, Object>> wanla4 = leaveDAO.findPatiwanla(userLogin, 5, start_date, end_date);
//			int n1 = wanla1.size();
//			int n2 = wanla2.size();
//			int n3 = wanla3.size();
//			int n4 = wanla4.size();
//			for (int i = 0; i < n1; i++) {
//				BigDecimal a = (BigDecimal) wanla1.get(i).get("no_day");
//
//				BigDecimal b = a;
//
//				x1 = b.add(x1);
//
//				request.setAttribute("y1", x1);
//
//			}
//
//			for (int i = 0; i < n2; i++) {
//				BigDecimal a = (BigDecimal) wanla2.get(i).get("no_day");
//
//				BigDecimal b = a;
//
//				x2 = b.add(x2);
//
//				request.setAttribute("y2", x2);
//
//			}
//
//			for (int i = 0; i < n3; i++) {
//				BigDecimal a = (BigDecimal) wanla3.get(i).get("no_day");
//
//				BigDecimal b = a;
//
//				x3 = b.add(x3);
//
//				request.setAttribute("y3", x3);
//
//			}
//			for (int i = 0; i < n3; i++) {
//				BigDecimal a = (BigDecimal) wanla3.get(i).get("no_day");
//
//				BigDecimal b = a;
//
//				x3 = b.add(x3);
//
//				request.setAttribute("y3", x3);
//
//			}
//			for (int i = 0; i < n4; i++) {
//				BigDecimal a = (BigDecimal) wanla4.get(i).get("no_day");
//
//				BigDecimal b = a;
//
//				x4 = b.add(x4);
//
//				request.setAttribute("y4", x4);
//
//			}
//			// x4 = x1.add(x2).add(x3);
//			request.setAttribute("userList", userDAO.findAll());
//
//			request.setAttribute("listbyuser", listbyuser);
//			// request.setAttribute("x4", x4);
//			request.setAttribute("leavetypeList", leavetypeDAO.findAll());
//			request.setAttribute("leaveuserList", leaveuserDAO.findAll());
//			request.setAttribute("userList", userDAO.findAll());
//			String vv = "leave.approve";
//			String x = ur.getRoleId();
//			int flag = 0;
//			if (x != null) {
//				Set<String> userAuthority = new HashSet<>();
//				List<RoleAuthorizedObject> roleAuthorizedObjectList = roleAuthorizedObjectDAO.findByRoleId(x);
//				if (roleAuthorizedObjectList != null) {
//					Iterator<RoleAuthorizedObject> it = roleAuthorizedObjectList.iterator();
//					while (it.hasNext()) {
//						RoleAuthorizedObject rao = it.next();
//						userAuthority.add(rao.getAuthorizedObjectId());
//						for (Object test : userAuthority) {
//							if (test.toString().indexOf(vv) != -1) {
//								flag = 1;
//
//							}
//						}
//					}
//
//				}
//				session.setAttribute("userAuthority", userAuthority);
//			}
//			request.setAttribute("flag", flag);
//			request.setAttribute("aoList", authorizedObjectDAO.findAll());
//			request.setAttribute("raoList", roleAuthorizedObjectDAO.findByRoleId(roleId));
//
//			List<LeaveType> type_leave = leavetypeDAO.findAll_calendar();
//			request.setAttribute("type_1", type_leave.get(0).getLeaveTypeName());
//			request.setAttribute("type_2", type_leave.get(1).getLeaveTypeName());
//			request.setAttribute("type_3", type_leave.get(2).getLeaveTypeName());
//			request.setAttribute("type_4", type_leave.get(3).getLeaveTypeName());
//			request.setAttribute("type_5", type_leave.get(4).getLeaveTypeName());
//			request.setAttribute("type_6", type_leave.get(5).getLeaveTypeName());
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String myEdit() {
//		try {
//
//			String flag_checkform = request.getParameter("flag");
//
//			if (flag_checkform != null) {
//				Global_flag = flag_checkform;
//				String user = request.getParameter("thisuser");
//				request.setAttribute("userId", user);
//				request.setAttribute("flag_search", flag_checkform);
//
//			}
//
//			User ur = (User) request.getSession().getAttribute("onlineUser");
//			HttpSession session = request.getSession();
//			int flag = 0;
//			List<Map<String, Object>> userseq = userDAO.sequense();
//			request.setAttribute("userseq", userseq);
//			String vv = "leave.approve";
//			String id = request.getParameter("Id");
//			String x = ur.getRoleId();
//
//			if (id != null) {
//				List<Map<String, Object>> approve = leaveDAO.approverform(id);
//				request.setAttribute("approve", approve);
//				request.setAttribute("id", id);
//			}
//
//			if (x != null) {
//				Set<String> userAuthority = new HashSet<>();
//				List<RoleAuthorizedObject> roleAuthorizedObjectList = roleAuthorizedObjectDAO.findByRoleId(x);
//				if (roleAuthorizedObjectList != null) {
//					Iterator<RoleAuthorizedObject> it = roleAuthorizedObjectList.iterator();
//					while (it.hasNext()) {
//						RoleAuthorizedObject rao = it.next();
//						userAuthority.add(rao.getAuthorizedObjectId());
//						for (Object test : userAuthority) {
//							if (test.toString().indexOf(vv) != -1) {
//								flag = 1;
//							}
//						}
//					}
//				}
//				session.setAttribute("userAuthority", userAuthority);
//			}
//			request.setAttribute("flag", flag);
//			List<Leaves> leaveList = leaveDAO.findAll();
//			request.setAttribute("leaveList", leaveList);
//			request.setAttribute("leavetypeList", leavetypeDAO.findAll_calendar());
//			request.setAttribute("leaveuserList", leaveuserDAO.findAll());
//			request.setAttribute("userList", userDAO.findAll());
//			List<Map<String, Object>> holidayList = leaveDAO.findHoliday();
//			request.setAttribute("holidayList", holidayList);
//			List<Map<String, Object>> setHoli = timesheetDAO.findHoliday2();
//			request.setAttribute("setHoli", setHoli);
//			List<Map<String, Object>> cutholiday = leaveDAO.findHoliday3();
//			request.setAttribute("cutholiday", cutholiday);
//			String date_now = request.getParameter("date");
//			if (date_now != null) {
//				request.setAttribute("date", date_now);
//			}
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String changesmyapprove() {
//		try {
//			String apprUserId = request.getParameter("apprUserId"); // apirat.c
//			request.setAttribute("userList", userDAO.findAll());
//
//			if (apprUserId != null) {
//				List<Map<String, Object>> approve = userDAO.findByApprove(apprUserId); // null
//				request.setAttribute("approve", approve);
//				request.setAttribute("apprUserId", apprUserId);
//			}
//			approve = userDAO.findByApprove(apprUserId);
//			request.setAttribute("userId", userId);
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return ERROR;
//	}

//	public String selectmyapprove() {
//		try {
//
//			String userId = request.getParameter("userId"); // applicant
//			request.setAttribute("userList", userDAO.findAll());
//
//			if (userId != null) {
//				List<Map<String, Object>> approve = userDAO.findByApprove(userId);
//				request.setAttribute("approve", approve);
//				request.setAttribute("userId", userId);
//			}
//			approve = userDAO.findByApprove(userId);
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return ERROR;
//	}

//	public String myLeaveUpdate() {
//
//		try {
//			List<Map<String, Object>> userseq = userDAO.sequense();
//			request.setAttribute("userseq", userseq);
//
//			User ur = (User) request.getSession().getAttribute("onlineUser");
//			String userLogin = ur.getId();// online user
//
//			// getParameter
//
//			String userId = request.getParameter("name");
//			String leaveid = request.getParameter("leaveId");
//			int leaveId = Integer.valueOf(leaveid);
//
//			String leaveStatusId = request.getParameter("leaveStatusId");
//
//			String apprUserId = request.getParameter("apprUserId");
//			String description = request.getParameter("description");
//			String halfDay = request.getParameter("halfDay"); // null set 0
//			String reason = request.getParameter("reason");
//			String time_hours = request.getParameter("comboA");
//			String from = request.getParameter("startDate");
//			String to = request.getParameter("endDate");
//
//			Timestamp start_date = DateUtil.dateFormat(from);// changeformat
//			Timestamp end_date = DateUtil.dateFormatEdit(to);// changeformat
//			String noDay = request.getParameter("noDay");
//			BigDecimal no_day = new BigDecimal(noDay);
//			BigDecimal time_comboA = new BigDecimal(time_hours);
//			BigDecimal result = no_day.add(time_comboA);
//
//			Leaves le = leaveDAO.findByLeaveId(leaveId);
//			if (leaveStatusId != null) {
//				le.setLeaveStatusId(leaveStatusId);
//			}
//			le.setLeaveId(leaveId);
//			String TypeId = request.getParameter("leaveTypeId");
//			if (!TypeId.equals("1") && !TypeId.equals("2") && !TypeId.equals("3") && !TypeId.equals("4")
//					&& !TypeId.equals("5") && !TypeId.equals("6")) {
//				le.setLeaveTypeId("9");
//			} else {
//				le.setLeaveTypeId(TypeId);
//			}
//
//			le.setHalfDay(halfDay);
//			String hd = request.getParameter("halfDay");
//			if (hd == null) {
//				le.setHalfDay("0");
//			}
//
//			le.setUserId(userLogin);
//			le.setApprUserId(apprUserId);
//			le.setStartDate(start_date);
//			le.setEndDate(end_date);
//			le.setDescription(description);
//			le.setReason(reason);
//
//			le.setNoDay(result);
//			le.setUserCreate(userLogin);
//			le.setUserUpdate(userLogin);
//			le.setTimeCreate(DateUtil.getCurrentTime());
//			le.setTimeUpdate(DateUtil.getCurrentTime());
//
//			List<Map<String, Object>> leaveList = leaveDAO.findLeave();
//			request.setAttribute("leaveList", leaveList);
//			request.setAttribute("leavetypeList", leavetypeDAO.findAll_calendar());
//			request.setAttribute("leaveuserList", leaveuserDAO.findAll());
//			request.setAttribute("userList", userDAO.findAll());
//
//			leaveDAO.update(le);
//			if (Global_flag.equals("2")) {
//				Global_flag = "";
//				return SUCCESS;
//			} else {
//
//				Global_flag = "";
//				return INPUT;
//			}
//		} catch (
//
//		Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String list_Updatena() {
//		try {
//			String leaveid = request.getParameter("leave_id");
//			int x = Integer.parseInt(leaveid);
//			Leaves l = leaveDAO.findByLeaveId(x);
//			l.setLeaveStatusId("1");
//			leaveDAO.update(l);
//			List<Map<String, Object>> leaveList = leaveDAO.findLeave();
//			request.setAttribute("leaveList", leaveList);
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String leave_approve() {
//		try {
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//
//	}

//	public String deleteleave() {
//		try {
//			String s = request.getParameter("leave_id");
//			int leaves = Integer.parseInt(s);
//			Leaves leaveid = leaveDAO.findByLeaveId(leaves);
//			String user = leaveid.getUserId();
//			String a1 = leaveid.getStartDate().toString();
//			leaveDAO.delete(leaveid);
//			String userSelect = "All";
//			Date date = new Date();
//			Timestamp tstamp = new Timestamp(date.getTime());
//			String tstm2 = tstamp.toString();
//			String tstm4 = tstm2.substring(0, 4);
//			String tstm5 = tstm2.substring(5, 7);
//			String tstm6 = tstm2.substring(8, 10);
//			String datee = tstm6 + "-" + tstm5 + "-" + tstm4;
//			String tim2 = "23:59:59";
//			String tim3 = "00:00:00";
//			Timestamp dateen = DateUtil.dateToTimestamp2(datee, tim2);
//			Date date1 = tstamp;
//			DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
//			String datenow = dateFormat.format(date1);
//			String year = datenow.substring(6, 10);
//			String newyear = "01-01" + "-" + year;
//			Timestamp startda = DateUtil.dateToTimestamp(newyear, tim3);
//			List<Map<String, Object>> userseq = userDAO.sequense();
//			request.setAttribute("userseq", userseq);
//			request.setAttribute("userId", user);
//			List<Map<String, Object>> leave = leaveDAO.searchtable(startda, dateen, userSelect);
//			request.setAttribute("leave", leave);
//			request.setAttribute("flag12", a1.substring(0, 10));
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String myleave() {
//		try {
//			User ur = new User();
//			String userLogin = null;
//			String type = request.getParameter("type");
//			if (type == null) {
//				ur = (User) request.getSession().getAttribute("onlineUser");
//				userLogin = ur.getId();
//			} else {
//				userLogin = request.getParameter("name1");
//			}
//
//			String listbyuser = request.getParameter("Id");
//
//			DateTimeFormatter date1 = DateTimeFormatter.ofPattern("01-01-yyyy");
//			LocalDate localDate = LocalDate.now();
//			String s = "00:00:00.0";
//
//			String start = request.getParameter("startdate");
//			String end = request.getParameter("enddate");
//			Timestamp start_date;
//			Timestamp end_date;
//			if (start == null && end == null) {
//				start_date = DateUtil.dateToTimestamp(date1.format(localDate), s);
//				end_date = DateUtil.changetoEndYear(date1.format(localDate));
//			} else {
//				start_date = DateUtil.dateFormatEdit(start);
//				end_date = DateUtil.dateFormatEdit(end);
//			}
//
//			Date enddate = new Date(end_date.getTime());
//			request.setAttribute("enddate", enddate);
//			if (userLogin != listbyuser) {
//				listbyuser = userLogin;
//			}
//
//			List<LeaveType> type_leave = leavetypeDAO.findAll_calendar();
//			for (int i = 0; i < type_leave.size(); i++) {
//				LeaveType leave = type_leave.get(i);
//				request.setAttribute("type_" + leave.getLeaveTypeId(), leave.getLeaveTypeName());
//			}
//			List<Map<String, Object>> leavelist = leaveDAO.myLeavesList(userLogin, start_date, end_date);
//
//			String status = "1";
//			// List<Map<String, Object>> leaveListDashboard =
//			// leaveDAO.myLeavesList(userLogin, start_date, end_date, status);
//			List LeaveID = leaveDAO.findLeaveId(userLogin, start_date, end_date, status);
//
//			request.setAttribute("leavelist", leavelist);
//
//			Double leave_1 = 0.000, leave_2 = 0.000, leave_3 = 0.000, leave_5 = 0.000, leave_6 = 0.000;
////
////			for (Iterator iterator = leavelist.iterator(); iterator.hasNext();) {
////				Leaves leave = (Leaves) iterator.next();
////			}
//			int x = 0;
//
//			while (x <= LeaveID.size() - 1) {
//				log.debug("inLoopWhile");
//				String a[] = LeaveID.get(x).toString().split("[={}]");
//				log.debug("Split Success");
//				for (int b = 0; b <= a.length - 1; b++) {
//					log.debug("a[" + b + "]= " + a[b]);
//				}
//				int id = 0;
//				for (int b = 0; b <= a.length - 1; b++) {
//					log.debug("inLoopFor");
//					if (tryParseInt(a[b])) {
//						log.debug("inIf");
//						id = Integer.parseInt(a[b]);
//						log.debug("This is Array No: " + b + " =" + a[b]);
//						Leaves leaveDashboard = leaveDAO.findByLeaveId(id);
//						log.debug("Ref Success");
//						Double noday = leaveDashboard.getNoDay().doubleValue();
//						log.debug("This NoDay : " + noday);
//						if (leaveDashboard.getLeaveTypeId().contains("1")) {
//							leave_1 = leave_1 + noday;
//						}
//						if (leaveDashboard.getLeaveTypeId().contains("2")) {
//							leave_2 = leave_2 + noday;
//						}
//						if (leaveDashboard.getLeaveTypeId().contains("3")) {
//							leave_3 = leave_3 + noday;
//						}
//						if (leaveDashboard.getLeaveTypeId().contains("5")) {
//							leave_5 = leave_5 + noday;
//						}
//						if (leaveDashboard.getLeaveTypeId().contains("6")) {
//							leave_6 = leave_6 + noday;
//						}
//					}
//
//				}
//				x++;
//			}
//			request.setAttribute("leave_1", leave_1);
//			request.setAttribute("leave_2", leave_2);
//			request.setAttribute("leave_3", leave_3);
//			request.setAttribute("leave_5", leave_5);
//			request.setAttribute("leave_6", leave_6);
//			request.setAttribute("usertest", userLogin);
//			Date day = new Date();
//			LocalDate localdate = day.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
//			Double quotaLastYear = leaveDAO.LastYearQuota(userLogin, localdate.getYear());
//			Double quotaThisYear = leaveDAO.ThisYearQuota(userLogin);
//			request.setAttribute("quotaThisYear", quotaThisYear);
//
//			request.setAttribute("quotaLastYear", quotaLastYear);
//			request.setAttribute("leave_6l", quotaLastYear - leave_6);
//
//			String year = localdate.toString().substring(0, 4);
//			Timestamp tend = Timestamp.valueOf(year + "-04-01 00:00:00"); // time end is april month
//			Timestamp tnow = new Timestamp(day.getTime());
//
//			request.setAttribute("tnow", tnow);
//			request.setAttribute("tend", tend);
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

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

//	public String LeaveAdd() {
//		String date = request.getParameter("date");
//		String time = request.getParameter("time");
//		try {
//			User ur = new User();
//			String userLogin = null;
//			String type = request.getParameter("type");
//			if (type == null) {
//				ur = (User) request.getSession().getAttribute("onlineUser");
//				userLogin = ur.getId();
//			} else {
//				userLogin = request.getParameter("name1");
//			}
//
//			String listbyuser = request.getParameter("Id");
//
//			DateTimeFormatter date1 = DateTimeFormatter.ofPattern("01-01-yyyy");
//			LocalDate localDate = LocalDate.now();
//			String s = "00:00:00.0";
//
//			String start = request.getParameter("startdate");
//			String end = request.getParameter("enddate");
//			Timestamp start_date;
//			Timestamp end_date;
//			if (start == null && end == null) {
//				start_date = DateUtil.dateToTimestamp(date1.format(localDate), s);
//				end_date = DateUtil.changetoEndYear(date1.format(localDate));
//			} else {
//				start_date = DateUtil.dateFormatEdit(start);
//				end_date = DateUtil.dateFormatEdit(end);
//			}
//
//			Date enddate = new Date(end_date.getTime());
//			request.setAttribute("enddate", enddate);
//			log.debug(enddate);
//			log.debug(end_date);
//			if (userLogin != listbyuser) {
//				listbyuser = userLogin;
//			}
//
//			List<LeaveType> type_leave = leavetypeDAO.findAll_calendar();
//			for (int i = 0; i < type_leave.size(); i++) {
//				LeaveType leave = type_leave.get(i);
//				request.setAttribute("type_" + leave.getLeaveTypeId(), leave.getLeaveTypeName());
//			}
//			List<Map<String, Object>> leavelist = leaveDAO.myLeavesList(userLogin, start_date, end_date);
//
//			String status = "1";
//			// List<Map<String, Object>> leaveListDashboard =
//			// leaveDAO.myLeavesList(userLogin, start_date, end_date, status);
//			List LeaveID = leaveDAO.findLeaveId(userLogin, start_date, end_date, status);
//
//			request.setAttribute("leavelist", leavelist);
//
//			Double leave_1 = 0.000, leave_2 = 0.000, leave_3 = 0.000, leave_5 = 0.000, leave_6 = 0.000;
////
////			for (Iterator iterator = leavelist.iterator(); iterator.hasNext();) {
////				Leaves leave = (Leaves) iterator.next();
////			}
//			int x = 0;
//
//			while (x <= LeaveID.size() - 1) {
//				log.debug("inLoopWhile");
//				String a[] = LeaveID.get(x).toString().split("[={}]");
//				log.debug("Split Success");
//				for (int b = 0; b <= a.length - 1; b++) {
//					log.debug("a[" + b + "]= " + a[b]);
//				}
//				int id = 0;
//				for (int b = 0; b <= a.length - 1; b++) {
//					log.debug("inLoopFor");
//					if (tryParseInt(a[b])) {
//						log.debug("inIf");
//						id = Integer.parseInt(a[b]);
//						log.debug("This is Array No: " + b + " =" + a[b]);
//						Leaves leaveDashboard = leaveDAO.findByLeaveId(id);
//						log.debug("Ref Success");
//						Double noday = leaveDashboard.getNoDay().doubleValue();
//						log.debug("This NoDay : " + noday);
//						if (leaveDashboard.getLeaveTypeId().contains("1")) {
//							leave_1 = leave_1 + noday;
//						}
//						if (leaveDashboard.getLeaveTypeId().contains("2")) {
//							leave_2 = leave_2 + noday;
//						}
//						if (leaveDashboard.getLeaveTypeId().contains("3")) {
//							leave_3 = leave_3 + noday;
//						}
//						if (leaveDashboard.getLeaveTypeId().contains("5")) {
//							leave_5 = leave_5 + noday;
//						}
//						if (leaveDashboard.getLeaveTypeId().contains("6")) {
//							leave_6 = leave_6 + noday;
//						}
//					}
//
//				}
//				x++;
//			}
//
//			request.setAttribute("leave_1", leave_1);
//			request.setAttribute("leave_2", leave_2);
//			request.setAttribute("leave_3", leave_3);
//			request.setAttribute("leave_5", leave_5);
//			request.setAttribute("leave_6", leave_6);
//			request.setAttribute("usertest", userLogin);
//			Date day = new Date();
//			LocalDate localdate = day.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
//			Double quotaLastYear = leaveDAO.LastYearQuota(userLogin, localdate.getYear());
//			Double quotaThisYear = leaveDAO.ThisYearQuota(userLogin);
//			request.setAttribute("quotaThisYear", quotaThisYear);
//
//			request.setAttribute("quotaLastYear", quotaLastYear);
//			request.setAttribute("leave_6l", quotaLastYear - leave_6);
//
//			String year = localdate.toString().substring(0, 4);
//			Timestamp tend = Timestamp.valueOf(year + "-04-01 00:00:00"); // time end is april month
//			Timestamp tnow = new Timestamp(day.getTime());
//
//			request.setAttribute("tnow", tnow);
//			request.setAttribute("tend", tend);
//			/**/
//			String leaveTypeJSON = leavetypeDAO.getForDisplayJSON();
//			String holidayJSON = holidayDAO.getallOnlyDateJSON();
//			String userListJSON = userDAO.userListJSON();
//
//			User user = userDAO.findById(userLogin);
//			String starttime = user.getWorkTimeStart();
//			String stime = starttime.replace(':', '.');
//			request.setAttribute("stime", stime);
//
//			String endtime = user.getWorkTimeEnd();
//			String etime = endtime.replace(':', '.');
//			request.setAttribute("etime", etime);
//
//			request.setAttribute("date", date);
//			request.setAttribute("time", time);
//			request.setAttribute("userList", userListJSON);
//			request.setAttribute("leaveType", leaveTypeJSON);
//			request.setAttribute("holiday", holidayJSON);
//			request.setAttribute("action", "Add");
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

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
			
//			request.setAttribute("leave", "");
//			request.setAttribute("fileLeave", "");
			
			log.debug("Set request Success!!");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

//	public String LeaveEdit() {
//		try {
//			String id = request.getParameter("id");
//			Leaves leave = leaveDAO.findByLeaveId(Integer.parseInt(id));
//
//			User ur = new User();
//			String userLogin = null;
//			ur = (User) request.getSession().getAttribute("onlineUser");
//			userLogin = ur.getId();
//			log.debug(userLogin);
//
//			DateTimeFormatter date1 = DateTimeFormatter.ofPattern("01-01-yyyy");
//			LocalDate localDate = LocalDate.now();
//			String s = "00:00:00.0";
//
//			String start = request.getParameter("startdate");
//			String end = request.getParameter("enddate");
//			Timestamp start_date;
//			Timestamp end_date;
//			if (start == null && end == null) {
//				start_date = DateUtil.dateToTimestamp(date1.format(localDate), s);
//				end_date = DateUtil.changetoEndYear(date1.format(localDate));
//			} else {
//				start_date = DateUtil.dateFormatEdit(start);
//				end_date = DateUtil.dateFormatEdit(end);
//			}
//			log.debug(start_date);
//			log.debug(end_date);
//
//			String status = "1";
//			// List<Map<String, Object>> leaveListDashboard =
//			// leaveDAO.myLeavesList(userLogin, start_date, end_date, status);
//			List LeaveID = leaveDAO.findLeaveId(userLogin, start_date, end_date, status);
//
//			Double leave_1 = 0.000, leave_2 = 0.000, leave_3 = 0.000, leave_5 = 0.000, leave_6 = 0.000;
//			int x = 0;
//
//			while (x <= LeaveID.size() - 1) {
//				log.debug("inLoopWhile");
//				String a[] = LeaveID.get(x).toString().split("[={}]");
//				log.debug("Split Success");
//				for (int b = 0; b <= a.length - 1; b++) {
//					log.debug("a[" + b + "]= " + a[b]);
//				}
//				int leave_id = 0;
//				for (int b = 0; b <= a.length - 1; b++) {
//					log.debug("inLoopFor");
//					if (tryParseInt(a[b])) {
//						log.debug("inIf");
//						leave_id = Integer.parseInt(a[b]);
//						log.debug("This is Array No: " + b + " =" + a[b]);
//						Leaves leaveDashboard = leaveDAO.findByLeaveId(leave_id);
//						log.debug("Ref Success");
//						Double noday = leaveDashboard.getNoDay().doubleValue();
//						log.debug("This NoDay : " + noday);
//						if (leaveDashboard.getLeaveTypeId().contains("1")) {
//							leave_1 = leave_1 + noday;
//						}
//						if (leaveDashboard.getLeaveTypeId().contains("2")) {
//							leave_2 = leave_2 + noday;
//						}
//						if (leaveDashboard.getLeaveTypeId().contains("3")) {
//							leave_3 = leave_3 + noday;
//						}
//						if (leaveDashboard.getLeaveTypeId().contains("5")) {
//							leave_5 = leave_5 + noday;
//						}
//						if (leaveDashboard.getLeaveTypeId().contains("6")) {
//							leave_6 = leave_6 + noday;
//						}
//					}
//
//				}
//				x++;
//			}
//			if (ur.getLeaveQuota1() != null) {
//				if (ur.getLeaveQuota1().doubleValue() - leave_2 <= leave_1) {
//					String leave1Check = "1";
//					request.setAttribute("leave1Check", leave1Check);
//				} else {
//					String leave1Check = "0";
//					request.setAttribute("leave1Check", leave1Check);
//				}
//			}
//			/*
//			 * if(ur.getLeaveQuota2() != null) { if(ur.getLeaveQuota2().doubleValue() <=
//			 * leave_2) { String leave2Check = "1"; request.setAttribute("leave2Check",
//			 * leave2Check); } else { String leave2Check = "0";
//			 * request.setAttribute("leave2Check", leave2Check); } }
//			 */
//			if (3 <= leave_2) {
//				String leave2Check = "1";
//				request.setAttribute("leave2Check", leave2Check);
//			} else {
//				String leave2Check = "0";
//				request.setAttribute("leave2Check", leave2Check);
//			}
//			if (ur.getLeaveQuota3() != null) {
//				if (ur.getLeaveQuota3().doubleValue() <= leave_3) {
//					String leave3Check = "1";
//					request.setAttribute("leave3Check", leave3Check);
//				} else {
//					String leave3Check = "0";
//					request.setAttribute("leave3Check", leave3Check);
//				}
//			} else {
//				if (30 <= leave_3) {
//					String leave3Check = "1";
//					request.setAttribute("leave3Check", leave3Check);
//				} else {
//					String leave3Check = "0";
//					request.setAttribute("leave3Check", leave3Check);
//				}
//			}
//			if (ur.getLeaveQuota4() != null) {
//				if (ur.getLeaveQuota4().doubleValue() <= leave_6) {
//					String leave6Check = "1";
//					request.setAttribute("leave6Check", leave6Check);
//				} else {
//					String leave6Check = "0";
//					request.setAttribute("leave6Check", leave6Check);
//				}
//			}
//
//			if (leave.getLeaveFile() != null) {
//				FileUpload fileLeave = fileuploadDAO.findById(Integer.parseInt(leave.getLeaveFile()));
//				log.debug(fileLeave);
//				request.setAttribute("fileLeave", new Gson().toJson(fileLeave));
//			}
//			String leaveTypeJSON = leavetypeDAO.getForDisplayJSON();
//			String holidayJSON = holidayDAO.getallOnlyDateJSON();
//			String userListJSON = userDAO.userListJSON();
//			Double quotaThisYear = leaveDAO.ThisYearQuota(userLogin);
//			log.debug("quota of this year : " + quotaThisYear);
//			Double qThisYear = quotaThisYear - (leave_1 + leave_2);
//			request.setAttribute("quotaThisYear", qThisYear.intValue());
//
//			request.setAttribute("userList", userListJSON);
//			request.setAttribute("leaveType", leaveTypeJSON);
//			request.setAttribute("holiday", holidayJSON);
//			request.setAttribute("leave", new Gson().toJson(leave));
//			request.setAttribute("action", "Edit");
//			// request.getSession().setAttribute("leaveId", id);
//			log.debug(leave);
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}
	
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

//	public String LeaveAdd_Do() {
//		try {
//			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
//			String user = request.getParameter("user");
//			String leaveType = request.getParameter("leaveType");
//			String from = request.getParameter("from");
//			String to = request.getParameter("to");
//
//			String time_from = "";
//			String[] fromSplit;
//			String tf_hour;
//			String tf_min;
//			String startTime = null;
//			try {
//				time_from = request.getParameter("time_from");
//				if (time_from == "") {
//					User userlist = userDAO.findById(user);
//					time_from = userlist.getWorkTimeStart();
//				}
//				fromSplit = time_from.split(":");
//				tf_hour = fromSplit[0];
//				tf_min = fromSplit[1];
//
//				if (tf_hour.length() == 1) {
//					startTime = "0" + tf_hour + ":" + tf_min;
//				} else {
//					startTime = time_from;
//				}
//			} catch (Exception e) {
//			}
//
//			String time_to = "";
//			String[] toSplit;
//			String tt_hour;
//			String tt_min;
//			String endTime = null;
//			try {
//				time_to = request.getParameter("time_to");
//				if (time_to == "") {
//					User userlist = userDAO.findById(user);
//					time_to = userlist.getWorkTimeEnd();
//				}
//				toSplit = time_to.split(":");
//				tt_hour = toSplit[0];
//				tt_min = toSplit[1];
//
//				if (tt_hour.length() == 1) {
//					endTime = "0" + tt_hour + ":" + tt_min;
//				} else {
//					endTime = time_to;
//				}
//			} catch (Exception e) {
//			}
//
//			String amount = request.getParameter("amount");
//			String amount_sub = request.getParameter("amount_sub");
//			String halfDay = request.getParameter("halfDay");
//			String description = request.getParameter("description");
//			String approver = request.getParameter("approver");
//			String status = request.getParameter("status");
//			String reason = request.getParameter("reason");
//			if (user == null) {
//				user = request.getParameter("user_hidden");
//			}
//			if (approver == null) {
//				approver = request.getParameter("approver_hidden");
//			}
//			if (status == null) {
//				status = request.getParameter("status_hidden");
//			}
//			log.debug(halfDay);
//			if (halfDay == null || halfDay.equals("0")) {
//				startTime = "9:00";
//				endTime = "18:00";
//			} else if (halfDay.equals("1")) {
//				startTime = "8:00";
//				endTime = "12:00";
//			} else if (halfDay.equals("2")) {
//				startTime = "13:00";
//				endTime = "17:00";
//			}
//			log.debug("timefrom " + startTime);
//			log.debug("timeto " + endTime);
//			float amount_n = Float.parseFloat(amount);
//			float amount_sub_n = Float.parseFloat(amount_sub);
//			log.debug(amount_n);
//			log.debug(amount_sub_n);
//			BigDecimal noDay = BigDecimal.valueOf(amount_n + (amount_sub_n / 8));
//			log.debug("no day" + noDay);
//			Timestamp startDate = DateUtil.dateFormatEdit(from);
//			Timestamp endDate = DateUtil.dateFormatEdit(to);
//			Integer id = leaveDAO.getMaxId() + 1;
//
//			// Data send mail
//			// List<Map<String, Object>> leaveType_mail =
//			// leavetypeDAO.findByLeaveTypeId(leaveType);
//
//			// emailservice.sendMail(user,leaveType,description,halfDay,from,to,noDay);
//
//			Leaves leave = new Leaves();
//			leave.setLeaveId(id);
//			leave.setLeaveTypeId(leaveType);
//			leave.setLeaveStatusId(status);
//			leave.setHalfDay(halfDay);
//			leave.setUserId(user);
//			leave.setApprUserId(approver);
//			leave.setDescription(description);
//			leave.setReason(reason);
//			leave.setStartDate(startDate);
//			leave.setEndDate(endDate);
//			leave.setStartTime(startTime);
//			leave.setEndTime(endTime);
//			leave.setNoDay(noDay);
//			leave.setUserCreate(onlineUser.getId());
//			leave.setUserUpdate(onlineUser.getId());
//			leave.setTimeCreate(DateUtil.getCurrentTime());
//			leaveDAO.save(leave);
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String LeaveEdit_Do() {
//		try {
//			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
//			String id_s = (String) request.getSession().getAttribute("leaveId");
//			int id = Integer.parseInt(id_s);
//			String user = request.getParameter("user");
//			String leaveType = request.getParameter("leaveType");
//			String from = request.getParameter("from");
//			String to = request.getParameter("to");
//			String time_from = request.getParameter("time_from");
//
//			String[] split = time_from.split(":");
//			String tf_hour = split[0];
//			String tf_min = split[1];
//			String startTime;
//
//			if (tf_hour.length() == 1) {
//				startTime = "0" + tf_hour + ":" + tf_min;
//
//			} else {
//				startTime = time_from;
//			}
//			String endTime = request.getParameter("time_to");
//			String amount = request.getParameter("amount");
//			String amount_sub = request.getParameter("amount_sub");
//			String halfDay = request.getParameter("halfDay");
//			String description = request.getParameter("description");
//			String approver = request.getParameter("approver");
//			String status = request.getParameter("status");
//			String reason = request.getParameter("reason");
//			if (user == null) {
//				user = request.getParameter("user_hidden");
//			}
//			if (approver == null) {
//				approver = request.getParameter("approver_hidden");
//			}
//			if (status == null) {
//				status = request.getParameter("status_hidden");
//			}
//
//			float amount_n = Float.parseFloat(amount);
//			float amount_sub_n = Float.parseFloat(amount_sub);
//			BigDecimal noDay = BigDecimal.valueOf(amount_n + amount_sub_n / 8);
//			Timestamp startDate = DateUtil.dateFormatEdit(from);
//			Timestamp endDate = DateUtil.dateFormatEdit(to);
//
//			Leaves leave = leaveDAO.findByLeaveId(id);
//			leave.setLeaveTypeId(leaveType);
//			leave.setLeaveStatusId(status);
//			leave.setHalfDay(halfDay);
//			leave.setUserId(user);
//			leave.setApprUserId(approver);
//			leave.setDescription(description);
//			leave.setReason(reason);
//			leave.setStartDate(startDate);
//			leave.setEndDate(endDate);
//			leave.setStartTime(startTime);
//			leave.setEndTime(endTime);
//			leave.setNoDay(noDay);
//			leave.setUserUpdate(onlineUser.getId());
//			leave.setTimeUpdate(DateUtil.getCurrentTime());
//			leaveDAO.save(leave);
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

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
			log.debug("new_LeaveEdit_Do");
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			// String id_s = (String) request.getSession().getAttribute("leaveId");
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

			int maxId = fileuploadDAO.getMaxId() + 1;
			FileUpload fileupload = new FileUpload();

			if (fileUpload != null) {
				if (!fileUploadId.isEmpty()) {
					FileUpload fileuploadDel = fileuploadDAO.findById(Integer.parseInt(fileUploadId));
					ServletContext context = request.getServletContext();
					String fileServerPath = context.getRealPath("/");
					log.debug(fileServerPath + fileuploadDel.getPath());
					File file = new File(fileServerPath + fileuploadDel.getPath());
					boolean fileDelete = file.delete();
					if (fileDelete) {
						log.debug("successfully deleted");
					} else {
						log.debug("cant delete a file");
					}
					log.debug(fileuploadDel);
					fileuploadDAO.delete(fileuploadDel);

					maxId = Integer.parseInt(fileUploadId);
				}

				log.debug(maxId);
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

				fileupload.setFileId(maxId);
				fileupload.setUserId(user);
				fileupload.setUserCreate(onlineUser.getId());
				fileupload.setName(name);
				fileupload.setType(type);
				fileupload.setUserUpdate(onlineUser.getId());
				fileupload.setTimeCreate(DateUtil.getCurrentTime());
				fileupload.setTimeUpdate(DateUtil.getCurrentTime());
				fileuploadDAO.save(fileupload);

				leave.setLeaveFile(Integer.toString(maxId));
			}
			log.debug(leaveType);
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
			if (!noDay.equals(BigDecimal.ZERO)) {
				leaveDAO.update(leave);
			}

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

//	public String Leave_inList() {
//		try {
//			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
//			String id_s = request.getParameter("leave_id");
//			int id = Integer.parseInt(id_s);
//			String user = request.getParameter("user");
//			String status = ("1");
//			String reason = request.getParameter("reason");
//			Leaves leave = leaveDAO.findByLeaveId(id);
//			leave.setLeaveStatusId(status);
//			leave.setReason(reason);
//			leave.setTimeUpdate(DateUtil.getCurrentTime());
//			leaveDAO.save(leave);
//			log.debug(leave);
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}
	// this is Anan method

//	public String Leave_inListLeaveStatusToWaiting() {
//		try {
//			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
//			String id_s = request.getParameter("leave_id");
//			int id = Integer.parseInt(id_s);
//
//			String user = request.getParameter("user");
//			String status = ("0");
//
//			Leaves leave = leaveDAO.findByLeaveId(id);
//			leave.setLeaveStatusId(status);
//			leaveDAO.save(leave);
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}
	// this is Nawapat.s's method

//	public String Leave_inListLeaveStatusToReject() {
//		try {
//			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
//			String id_s = request.getParameter("leave_id");
//			String reason = request.getParameter("reason");
//			int id = Integer.parseInt(id_s);
//
//			String user = request.getParameter("user");
//			String status = ("2");
//
//			Leaves leave = leaveDAO.findByLeaveId(id);
//			leave.setLeaveStatusId(status);
//			leave.setReason(reason);
//			leave.setTimeUpdate(DateUtil.getCurrentTime());
//			leaveDAO.save(leave);
//			log.debug(leave);
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String checkNull(String name, String n) {
//		try {
//			if (name == null) {
//				name = n;
//			} else {
//				name = name + " , " + n;
//			}
//			return name;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

	// Leave Summary
//	public String ytdLeaveSummary() {
//		try {
//			java.util.Date date = new java.util.Date();
//			LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
//			int yearnow = localDate.getYear();
//			int year = yearnow;
//			int month = localDate.getMonthValue();
//			int day = localDate.getDayOfMonth();
//
//			request.setAttribute("type", "1");
//			request.setAttribute("daynow", day);
//			request.setAttribute("monthnow", month);
//			request.setAttribute("yearnow", yearnow);
//			request.setAttribute("year", year);
//			List<Map<String, Object>> leaves = leaveDAO.test_LeavesSummary(year, 1);
//			request.setAttribute("leaves", leaves);
//
//			List<Map<String, Object>> holidayList = holidayDAO.test_holiday(year);
//			request.setAttribute("holidayList", holidayList);
//
//			int[][] s;
//			s = new int[12][31];
//			String[][] name;
//			name = new String[12][31];
//			for (int i = 0; i < leaves.size(); i++) {
//				int monthNumber = (Integer) leaves.get(i).get("Month");
//				int dayNumber = (Integer) leaves.get(i).get("Day");
//				BigDecimal noDay = (BigDecimal) leaves.get(i).get("no_day");
//				BigDecimal A = new BigDecimal(1.00);
//				String n = (String) leaves.get(i).get("user_id");
//				s[monthNumber - 1][dayNumber - 1]++;
//				name[monthNumber - 1][dayNumber - 1] = checkNull(name[monthNumber - 1][dayNumber - 1], n);
//				if (noDay.compareTo(A) > 0) {
//					double d = 0;
//					d = Math.ceil(noDay.doubleValue());
//					for (int j = 1; j < d; j++) {
//						if (year % 400 == 0 || year % 4 == 0 && year % 100 != 0) {// find leap year
//							if (monthNumber == 2) {
//								if (dayNumber - 1 + j >= 29) {
//									s[monthNumber][j - 1]++;
//									name[monthNumber][j - 1] = checkNull(name[monthNumber][j - 1], n);
//								} else {
//									s[monthNumber - 1][dayNumber - 1 + j]++;
//									name[monthNumber - 1][dayNumber - 1 + j] = checkNull(
//											name[monthNumber - 1][dayNumber - 1 + j], n);
//								}
//							} else if (monthNumber == 4 || monthNumber == 6 || monthNumber == 9 || monthNumber == 11) {
//								if (dayNumber - 1 + j >= 30) {
//									s[monthNumber][j - 1]++;
//									name[monthNumber][j - 1] = checkNull(name[monthNumber][j - 1], n);
//								} else {
//									s[monthNumber - 1][dayNumber - 1 + j]++;
//									name[monthNumber - 1][dayNumber - 1 + j] = checkNull(
//											name[monthNumber - 1][dayNumber - 1 + j], n);
//								}
//							} else {
//								if (dayNumber - 1 + j >= 31) {
//									s[monthNumber][j - 1]++;
//									name[monthNumber][j - 1] = checkNull(name[monthNumber][j - 1], n);
//								} else {
//									s[monthNumber - 1][dayNumber - 1 + j]++;
//									name[monthNumber - 1][dayNumber - 1 + j] = checkNull(
//											name[monthNumber - 1][dayNumber - 1 + j], n);
//								}
//							}
//						} else {
//							if (monthNumber == 2) {
//								if (dayNumber - 1 + j >= 28) {
//									s[monthNumber][j - 1]++;
//									name[monthNumber][j - 1] = checkNull(name[monthNumber][j - 1], n);
//								} else {
//									s[monthNumber - 1][dayNumber - 1 + j]++;
//									name[monthNumber - 1][dayNumber - 1 + j] = checkNull(
//											name[monthNumber - 1][dayNumber - 1 + j], n);
//								}
//							} else if (monthNumber == 4 || monthNumber == 6 || monthNumber == 9 || monthNumber == 11) {
//								if (dayNumber - 1 + j >= 30) {
//									s[monthNumber][j - 1]++;
//									name[monthNumber][j - 1] = checkNull(name[monthNumber][j - 1], n);
//								} else {
//									s[monthNumber - 1][dayNumber - 1 + j]++;
//									name[monthNumber - 1][dayNumber - 1 + j] = checkNull(
//											name[monthNumber - 1][dayNumber - 1 + j], n);
//								}
//							} else {
//								if (dayNumber - 1 + j >= 31) {
//									s[monthNumber][j - 1]++;
//									name[monthNumber][j - 1] = checkNull(name[monthNumber][j - 1], n);
//								} else {
//									s[monthNumber - 1][dayNumber - 1 + j]++;
//									name[monthNumber - 1][dayNumber - 1 + j] = checkNull(
//											name[monthNumber - 1][dayNumber - 1 + j], n);
//								}
//							}
//						}
//					}
//				}
//			}
//
//			List<Integer> list = new ArrayList<>();
//			List<String> nameList = new ArrayList<>();
//			for (int i = 1; i <= 12; i++) {
//				for (int j = 1; j <= 31; j++) {
//					list.add(s[i - 1][j - 1]);
//					nameList.add(name[i - 1][j - 1]);
//				}
//			}
//			request.setAttribute("alldata", list);
//			request.setAttribute("allname", nameList);
//
//			findWeekendsList(year);
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//
//	}

	// search leave
//	public String searchLeaveSummary() {
//		try {
//			List<Map<String, Object>> leaves = null;
//			String searchyaer = request.getParameter("year");
//			int year = Integer.parseInt(searchyaer);
//			request.setAttribute("year", year);
//
//			java.util.Date date = new java.util.Date();
//			LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
//			int yearnow = localDate.getYear();
//			request.setAttribute("yearnow", yearnow);
//
//			String type1 = request.getParameter("type");
//			int type = Integer.parseInt(type1);
//			request.setAttribute("type", type1);
//			if (type == 0) {
//				leaves = leaveDAO.test_LeavesSummary(year, type);
//			}
//			if (type == 1) {
//				leaves = leaveDAO.test_LeavesSummary(year, type);
//			}
//
//			List<Map<String, Object>> holidayList = holidayDAO.test_holiday(year);
//			request.setAttribute("holidayList", holidayList);
//
//			weekendList = new ArrayList();
//			weekendList2 = new ArrayList();
//
//			Calendar calendar = null;
//			calendar = Calendar.getInstance();
//			calendar.set(Calendar.YEAR, year);
//			calendar.set(Calendar.MONTH, 0);
//			calendar.set(Calendar.DATE, 1);
//			// The while loop ensures that you are only checking dates in the current year
//			while (calendar.get(Calendar.YEAR) == year) {
//				// The switch checks the day of the week for Saturdays and Sundays
//				switch (calendar.get(Calendar.DAY_OF_WEEK)) {
//				case Calendar.SATURDAY:
//				case Calendar.SUNDAY:
//					weekendList.add(calendar.get(Calendar.DATE));
//					weekendList2.add(calendar.get(Calendar.MONTH));
//
//					break;
//				}
//				// Increment the day of the year for the next iteration of the while loop
//				calendar.add(Calendar.DAY_OF_YEAR, 1);
//			}
//			request.setAttribute("weekEndDay", weekendList);
//			request.setAttribute("weekEndMonth", weekendList2);
//
//			request.setAttribute("leaves", leaves);
//			int[][] s;
//			s = new int[12][31];
//			String[][] name;
//			name = new String[12][31];
//			for (int i = 0; i < leaves.size(); i++) {
//				int monthNumber = (Integer) leaves.get(i).get("Month");
//				int dayNumber = (Integer) leaves.get(i).get("Day");
//				BigDecimal noDay = (BigDecimal) leaves.get(i).get("no_day");
//				BigDecimal A = new BigDecimal(1.00);
//				String n = (String) leaves.get(i).get("user_id");
//				s[monthNumber - 1][dayNumber - 1]++;
//				name[monthNumber - 1][dayNumber - 1] = checkNull(name[monthNumber - 1][dayNumber - 1], n);
//				if (noDay.compareTo(A) > 0) {
//					double d = 0;
//					d = Math.ceil(noDay.doubleValue());
//					for (int j = 1; j < d; j++) {
//						if (year % 400 == 0 || year % 4 == 0 && year % 100 != 0) {// find leap year
//							if (monthNumber == 2) {
//								if (dayNumber - 1 + j >= 29) {
//									s[monthNumber][j - 1]++;
//									name[monthNumber][j - 1] = checkNull(name[monthNumber][j - 1], n);
//								} else {
//									s[monthNumber - 1][dayNumber - 1 + j]++;
//									name[monthNumber - 1][dayNumber - 1 + j] = checkNull(
//											name[monthNumber - 1][dayNumber - 1 + j], n);
//								}
//							} else if (monthNumber == 4 || monthNumber == 6 || monthNumber == 9 || monthNumber == 11) {
//								if (dayNumber - 1 + j >= 30) {
//									s[monthNumber][j - 1]++;
//									name[monthNumber][j - 1] = checkNull(name[monthNumber][j - 1], n);
//								} else {
//									s[monthNumber - 1][dayNumber - 1 + j]++;
//									name[monthNumber - 1][dayNumber - 1 + j] = checkNull(
//											name[monthNumber - 1][dayNumber - 1 + j], n);
//								}
//							} else {
//								if (dayNumber - 1 + j >= 31) {
//									s[monthNumber][j - 1]++;
//									name[monthNumber][j - 1] = checkNull(name[monthNumber][j - 1], n);
//								} else {
//									s[monthNumber - 1][dayNumber - 1 + j]++;
//									name[monthNumber - 1][dayNumber - 1 + j] = checkNull(
//											name[monthNumber - 1][dayNumber - 1 + j], n);
//								}
//							}
//						} else {
//							if (monthNumber == 2) {
//								if (dayNumber - 1 + j >= 28) {
//									s[monthNumber][j - 1]++;
//									name[monthNumber][j - 1] = checkNull(name[monthNumber][j - 1], n);
//								} else {
//									s[monthNumber - 1][dayNumber - 1 + j]++;
//									name[monthNumber - 1][dayNumber - 1 + j] = checkNull(
//											name[monthNumber - 1][dayNumber - 1 + j], n);
//								}
//							} else if (monthNumber == 4 || monthNumber == 6 || monthNumber == 9 || monthNumber == 11) {
//								if (dayNumber - 1 + j >= 30) {
//									s[monthNumber][j - 1]++;
//									name[monthNumber][j - 1] = checkNull(name[monthNumber][j - 1], n);
//								} else {
//									s[monthNumber - 1][dayNumber - 1 + j]++;
//									name[monthNumber - 1][dayNumber - 1 + j] = checkNull(
//											name[monthNumber - 1][dayNumber - 1 + j], n);
//								}
//							} else {
//								if (dayNumber - 1 + j >= 31) {
//									s[monthNumber][j - 1]++;
//									name[monthNumber][j - 1] = checkNull(name[monthNumber][j - 1], n);
//								} else {
//									s[monthNumber - 1][dayNumber - 1 + j]++;
//									name[monthNumber - 1][dayNumber - 1 + j] = checkNull(
//											name[monthNumber - 1][dayNumber - 1 + j], n);
//								}
//							}
//						}
//					}
//				}
//			}
//
//			List<Integer> list = new ArrayList<>();
//			List<String> nameList = new ArrayList<>();
//			for (int i = 1; i <= 12; i++) {
//				for (int j = 1; j <= 31; j++) {
//					list.add(s[i - 1][j - 1]);
//					nameList.add(name[i - 1][j - 1]);
//				}
//			}
//			request.setAttribute("alldata", list);
//			request.setAttribute("allname", nameList);
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

	// find SATURDAY and SUNDAY
	private ArrayList weekendList = null;
	private ArrayList weekendList2 = null;
	private JSONArray jsonArray;

//	public void findWeekendsList(int year) {
//		weekendList = new ArrayList();
//		weekendList2 = new ArrayList();
//
//		Calendar calendar = null;
//		calendar = Calendar.getInstance();
//		calendar.set(Calendar.YEAR, year);
//		calendar.set(Calendar.MONTH, 0);
//		calendar.set(Calendar.DATE, 1);
//		// The while loop ensures that you are only checking dates in the current year
//		while (calendar.get(Calendar.YEAR) == year) {
//			// The switch checks the day of the week for Saturdays and Sundays
//			switch (calendar.get(Calendar.DAY_OF_WEEK)) {
//			case Calendar.SATURDAY:
//			case Calendar.SUNDAY:
//				weekendList.add(calendar.get(Calendar.DATE));
//				weekendList2.add(calendar.get(Calendar.MONTH));
//
//				break;
//			}
//			// Increment the day of the year for the next iteration of the while loop
//			calendar.add(Calendar.DAY_OF_YEAR, 1);
//		}
//		request.setAttribute("weekEndDay", weekendList);
//		request.setAttribute("weekEndMonth", weekendList2);
//
//	}

//	public String LeaveSelectMonth() {
//		try {
//
//			java.util.Date date = new java.util.Date();
//			LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
//			int yearnow = localDate.getYear();
//			int year = yearnow;
//			int month = localDate.getMonthValue();
//			log.info(month);
//
//			List<Map<String, Object>> leave = leaveDAO.leaveselectM(year);
//			request.setAttribute("leave", leave);
//			log.info(leave);
//
//			request.setAttribute("year", year);
//			request.setAttribute("type", month);
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String searchLeaveSelectMonth() {
//		try {
//			String searchyaer = request.getParameter("year");
//			int year = Interger.parseInt(searchyaer);
//			request.setAttribute("year", year);
//
//			List<Map<String, Object>> leave = leaveDAO.leaveselectM(year);
//			request.setAttribute("leave", leave);
//			log.info(leave);
//
//			String type1 = request.getParameter("type");
//			int type = Interger.parseInt(type1);
//			request.setAttribute("type", type1);
//
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String searchList_edit() {
//		try {
//			String jsonId = request.getParameter("nameSelect");
//			String jsonStatus = request.getParameter("appr");
//			String jsonType = request.getParameter("type");
//			String jsonStartDate = request.getParameter("startdate");
//			String jsonEndDate = request.getParameter("enddate");
//
//			String listbyuser = request.getParameter("Id");
//			if (jsonId != listbyuser) {
//				listbyuser = jsonId;
//			}
//			Timestamp start_date = DateUtil.dateToTimestamp(jsonStartDate, "00:00");
//			Timestamp end_date = DateUtil.dateToTimestamp(jsonEndDate, "00:00");
//			Gson gson = new GsonBuilder().create();
//			String responseJSON = gson
//					.toJson(leaveDAO.searchApproved(start_date, end_date, jsonId, jsonStatus, jsonType));
//			request.setAttribute("json", responseJSON);
//			return "json";
//		} catch (Exception e) {
//
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String searchShowDashboard() {
//		try {
//			Date newDate = new Date();
//			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
//			String date = dateFormat.format(newDate);
//			String jsonId = request.getParameter("nameSelect");
//
//			String listbyuser = request.getParameter("Id");
//			if (jsonId != listbyuser) {
//				listbyuser = jsonId;
//			}
//			Gson gson = new GsonBuilder().create();
//			String responseJSON = gson.toJson(leaveDAO.searchDashboard(jsonId, date));
//			request.setAttribute("json", responseJSON);
//			return "json";
//		} catch (Exception e) {
//
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String searchShowDashboardQuota() {
//		try {
//			log.debug("searchShowDashboardQuota");
//			Date newDate = new Date();
//			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
//			String date = dateFormat.format(newDate);
//			String jsonId = request.getParameter("nameSelect");
//			log.debug("UserId: " + jsonId);
//			log.debug("date: " + date);
//
//			String listbyuser = request.getParameter("Id");
//			if (jsonId != listbyuser) {
//				listbyuser = jsonId;
//			}
//			Gson gson = new GsonBuilder().create();
//			String responseJSON = gson.toJson(leaveDAO.searchDashboardQuota(jsonId, date));
//			request.setAttribute("json", responseJSON);
//			log.debug(responseJSON);
//			return "json";
//		} catch (Exception e) {
//
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String leaveUpdateStatus() {
//		try {
//			log.debug("leave update status");
//			log.debug("leaveUpdateStatus");
//			String user = request.getParameter("user");
//			String leaveId = request.getParameter("leaveId");
//			log.debug("user: " + user);
//			log.debug("leaveId: " + leaveId);
//			Gson gson = new GsonBuilder().create();
//			String responseJSON = gson.toJson(leaveDAO.leaveUpdateStatus(user, leaveId));
//			request.setAttribute("json", responseJSON);
//			log.debug(responseJSON);
//			return "json";
//		} catch (Exception e) {
//
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

//	public String modalLeaveStatus() {
//		try {
//			log.debug("leave id " + leaveId);
//
//			Gson gson = new GsonBuilder().setDateFormat("dd MMM yyyy, HH:mm").create();
//			String responseJSON = gson.toJson(leaveDAO.findLeaveById(leaveId));
//			request.setAttribute("json", responseJSON);
//			log.debug(responseJSON);
//
//			JSONArray jsonarray = new JSONArray(responseJSON);
//			JSONObject jsonobj = jsonarray.getJSONObject(0);
//
//			int leaveId = jsonobj.getInt("leave_id");
//			String leaveTypeId = jsonobj.getString("leave_type_id");
//			String leaveStatusId = jsonobj.getString("leave_status_id");
//			String userId = jsonobj.getString("user_id");
//			String startDate = jsonobj.getString("start_date");
//			String endDate = jsonobj.getString("end_date");
//			String apprUserId = jsonobj.getString("appr_user_id");
//			BigDecimal noDay = jsonobj.getBigDecimal("no_day");
//			String description = jsonobj.getString("description");
//
//			String reason = "";
//			try {
//				reason = jsonobj.getString("reason");
//			} catch (Exception e) {
//			}
//			String timeCreate = jsonobj.getString("time_create");
//
//			// -------- time --------
//			String startTime = "";
//			try {
//				startTime = jsonobj.getString("start_time");
//			} catch (Exception e) {
//			}
//			String endTime = "";
//			try {
//				endTime = jsonobj.getString("end_time");
//			} catch (Exception e) {
//			}
//
//			// -------- time update --------
//			String timeUpdate = "";
//			try {
//				timeUpdate = jsonobj.getString("time_update");
//			} catch (Exception e) {
//			}
//
//			// -------- leave file --------
//			String leaveFile = "";
//			try {
//				leaveFile = jsonobj.getString("leave_file");
//			} catch (Exception e) {
//			}
//
//			PrintWriter out = response.getWriter();
//			JSONObject json = new JSONObject();
//
//			json.put("leave_id", leaveId);
//			json.put("leave_type_id", leaveTypeId);
//			json.put("leave_status_id", leaveStatusId);
//			json.put("user_id", userId);
//			json.put("start_date", startDate);
//			json.put("end_date", endDate);
//			json.put("start_time", startTime);
//			json.put("end_time", endTime);
//			json.put("appr_user_id", apprUserId);
//			json.put("no_day", noDay);
//			json.put("description", description);
//			json.put("reason", reason);
//			json.put("time_create", timeCreate);
//			json.put("time_update", timeUpdate);
//			json.put("leave_file", leaveFile);
//
//			out.print(json);
//			out.flush();
//			out.close();
//
//			return SUCCESS;
//
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

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

//	public void findValidTime() {
//		try {
//			String id = request.getParameter("user");
//			log.debug(id);
//
//			Gson gson = new GsonBuilder().create();
//			String responseJSON = gson.toJson(userDAO.findById2(id));
//			request.setAttribute("json", responseJSON);
//			log.debug(responseJSON);
//
//			JSONArray jsonarray = new JSONArray(responseJSON);
//			JSONObject jsonobj = jsonarray.getJSONObject(0);
//
//			String starttime = jsonobj.getString("work_time_start");
//			String endtime = jsonobj.getString("work_time_end");
//			log.debug(starttime + "-" + endtime);
//
//			PrintWriter out = response.getWriter();
//			JSONObject json = new JSONObject();
//
//			json.put("stime", starttime);
//			json.put("etime", endtime);
//
//			out.print(json);
//			out.flush();
//			out.close();
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}

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

//	public String Leave_inListUpdateStatus() {
//		try {
//			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
//			log.debug(onlineUser);
//			String leave_id = request.getParameter("leave_id");
//			String reason = request.getParameter("reason");
//			String status = request.getParameter("status");
//			log.debug(status);
//			log.debug(reason);
//			
//		    if(reason == null || reason.trim().isEmpty()){
//		        reason = null;
//		    }
//		    
//			Leaves leave = leaveDAO.findByLeaveId(Integer.parseInt(leave_id));
//			leave.setLeaveStatusId(status);
//			leave.setReason(reason);
//			leave.setTimeUpdate(DateUtil.getCurrentTime());
//			leave.setUserUpdate(onlineUser.getId());
//			leaveDAO.save(leave);
//			log.debug(leave);
//			return SUCCESS;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return ERROR;
//		}
//	}

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
	
}