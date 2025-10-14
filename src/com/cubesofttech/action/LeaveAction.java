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
	private HolidayDAO holidayDAO;

	@Autowired
	private RoleAuthorizedObjectDAO roleAuthorizedObjectDAO;

	@Autowired
	private UserDAO userDAO;

	List<Leaves> modalLeaveList;
	private String roleId;

	private Leaves leave;

	private int leaveId;


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
}