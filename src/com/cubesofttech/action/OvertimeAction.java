package com.cubesofttech.action;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.OvertimeDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.User;
import com.cubesofttech.model.Overtime;
import com.opensymphony.xwork2.ActionSupport;
import javax.servlet.http.HttpSession;

public class OvertimeAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private static Logger log = Logger.getLogger(OvertimeAction.class);

	@Autowired
	private OvertimeDAO overtimeDAO;

	@Autowired
	private UserDAO userDAO;

	private List<Map<String, Object>> overtimeList;
	private List<Map<String, Object>> userList;
	private Overtime overtime;
	private String statusId;

	// ------------------------ LIST ------------------------
	public String list() {
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			HttpSession session = request.getSession();

			String status = request.getParameter("status");
			String dateRange = request.getParameter("dateRange");

			User onlineUser = (User) session.getAttribute("onlineUser");
			String userId = onlineUser != null ? onlineUser.getId() : null;

			overtimeList = overtimeDAO.findByCriteria(userId, status, dateRange);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	// ------------------------ ADD ------------------------
	public String add() {
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			String loginUser = (String) request.getSession().getAttribute("user_id");

			overtime = new Overtime();
			overtime.setUser_id(loginUser);

			return SUCCESS;
		} catch (Exception e) {
			log.error("Error in OvertimeAction.add()", e);
			overtime = new Overtime();
			return ERROR;
		}
	}

	// ------------------------ SAVE ------------------------
	public String save() {
		try {
			HttpServletRequest request = ServletActionContext.getRequest();

			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			String loginUser = "";
			if (onlineUser != null) {
				loginUser = onlineUser.getId();
			} else {
				return LOGIN;
			}

			String otId = request.getParameter("ot_id");
			String otDateStr = request.getParameter("ot_date");

			String startTime = request.getParameter("start_time");
			String endTime = request.getParameter("end_time");
			String reqHours = request.getParameter("req_hours");
			String description = request.getParameter("description");

			SimpleDateFormat sdfDate = new SimpleDateFormat("dd/MM/yyyy", java.util.Locale.US);
			SimpleDateFormat sdfDatetime = new SimpleDateFormat("yyyy-MM-dd HH:mm", java.util.Locale.US);
			Timestamp now = new Timestamp(System.currentTimeMillis());

			Timestamp startTimestamp = null;
			Timestamp endTimestamp = null;

			if (startTime != null && !startTime.isEmpty() && endTime != null && !endTime.isEmpty()) {

				java.util.Date parsedStart = sdfDatetime.parse(startTime);
				startTimestamp = new Timestamp(parsedStart.getTime());

				java.util.Date parsedEnd = sdfDatetime.parse(endTime);
				endTimestamp = new Timestamp(parsedEnd.getTime());

			}

			if (otId == null || otId.isEmpty()) {
				// CREATE
				overtime = new Overtime();
				if (otDateStr != null && !otDateStr.isEmpty()) {
					overtime.setOt_date(sdfDate.parse(otDateStr));
				}
				overtime.setStart_time(startTimestamp);
				overtime.setEnd_time(endTimestamp);

				if (reqHours != null && !reqHours.isEmpty()) {
					BigDecimal hours = new BigDecimal(reqHours);
					overtime.setReq_hours(hours);
					overtime.setAppr_hours(hours);
				}

				overtime.setDescription(description);
				overtime.setStatus("W");
				overtime.setUser_id(loginUser);
				overtime.setUser_create(loginUser);
				overtime.setTime_create(now);

				overtimeDAO.save(overtime);
			} else {
				// UPDATE
				overtime = overtimeDAO.findById(Integer.parseInt(otId));
				if (overtime != null) {
					if (otDateStr != null && !otDateStr.isEmpty()) {
						overtime.setOt_date(sdfDate.parse(otDateStr));
					}
					overtime.setStart_time(startTimestamp);
					overtime.setEnd_time(endTimestamp);

					if (reqHours != null && !reqHours.isEmpty()) {
						BigDecimal hours = new BigDecimal(reqHours);
						overtime.setReq_hours(hours);
						overtime.setAppr_hours(hours);
					}

					overtime.setDescription(description);
					overtime.setUser_update(loginUser);
					overtime.setTime_update(now);

					overtimeDAO.update(overtime);
				}
			}
			return SUCCESS;
		} catch (Exception e) {
			log.error("Error in OvertimeAction.save()", e);
			return ERROR;
		}
	}

	// ------------------------ DELETE ------------------------
	public String delete() {
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			String idStr = request.getParameter("id");

			if (idStr != null && !idStr.isEmpty()) {
				Integer id = Integer.parseInt(idStr);
				Overtime overtime = overtimeDAO.findById(id);

				if (overtime != null) {
					overtimeDAO.delete(overtime);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	// ------------------------ EDIT ------------------------
	public String edit() {
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			String idStr = request.getParameter("id");

			if (idStr != null && !idStr.isEmpty()) {
				Integer id = Integer.parseInt(idStr);

				overtime = overtimeDAO.findById(id);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}

	// --- Getters and Setters ---

	public OvertimeDAO getOvertimeDAO() {
		return overtimeDAO;
	}

	public void setOvertimeDAO(OvertimeDAO overtimeDAO) {
		this.overtimeDAO = overtimeDAO;
	}

	public UserDAO getUserDAO() {
		return userDAO;
	}

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	public List<Map<String, Object>> getOvertimeList() {
		return overtimeList;
	}

	public void setOvertimeList(List<Map<String, Object>> overtimeList) {
		this.overtimeList = overtimeList;
	}

	public List<Map<String, Object>> getUserList() {
		return userList;
	}

	public void setUserList(List<Map<String, Object>> userList) {
		this.userList = userList;
	}

	public Overtime getOvertime() {
		return overtime;
	}

	public void setOvertime(Overtime overtime) {
		this.overtime = overtime;
	}

	public String getStatusId() {
		return statusId;
	}

	public void setStatusId(String statusId) {
		this.statusId = statusId;
	}
}