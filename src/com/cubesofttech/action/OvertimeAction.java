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
	private List<User> userList;
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

	public String overtimeApprove() {
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			String userId = request.getParameter("userId");
			String dateRange = request.getParameter("dateRange");

			userList = userDAO.findAll();
			overtimeList = overtimeDAO.findByCriteria(userId, null, dateRange);

			return SUCCESS;
		} catch (Exception e) {
			log.error("Error in OvertimeAction.overtimeApprove()", e); 
			return ERROR;
		}
	}

	public String update_approve() {
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			Integer otId = Integer.parseInt(request.getParameter("ot_id"));

			Overtime ot = overtimeDAO.findById(otId);

			if (ot != null) {
				User user = (User) request.getSession().getAttribute("onlineUser");
				Timestamp now = new Timestamp(System.currentTimeMillis());

				ot.setStatus(request.getParameter("status"));
				ot.setAppr_hours(new BigDecimal(request.getParameter("appr_hours")));

				String typeOfOt = request.getParameter("type_of_ot");
				if (typeOfOt != null && !typeOfOt.isEmpty()) {
					ot.setType_of_ot(new BigDecimal(typeOfOt));
				}

				String descAppr = request.getParameter("description_appr");
				if (descAppr != null) {
					ot.setDescription_appr(descAppr.trim());
				}

				ot.setAppr_user_id(user.getId());
				ot.setApproved_at(now);

				ot.setUser_update(user.getId());
				ot.setTime_update(now);

				overtimeDAO.update(ot);
			}

			return SUCCESS;
		} catch (Exception e) {
			log.error("Error in update_approve: " + e.getMessage());
			return ERROR;
		}
	}

	public String overtimeApproveForm() {
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			String otId = request.getParameter("ot_id");

			if (otId != null && !otId.isEmpty()) {
				overtime = overtimeDAO.findById(Integer.parseInt(otId));

				if (overtime != null && overtime.getUser_create() != null) {
					User reqUser = userDAO.findById(overtime.getUser_create());

					if (reqUser != null) {
						String displayName = "";
						if (reqUser.getEmployeeId() != null && !reqUser.getEmployeeId().isEmpty()) {
							displayName += reqUser.getEmployeeId();
						}
						if (reqUser.getNameEN() != null && !reqUser.getNameEN().isEmpty()) {
							if (!displayName.isEmpty())
								displayName += " - ";
							displayName += reqUser.getNameEN();
						}
						if (reqUser.getName() != null && !reqUser.getName().isEmpty()) {
							if (!displayName.isEmpty())
								displayName += " - ";
							displayName += reqUser.getName();
						}
						if (reqUser.getRoleId() != null && !reqUser.getRoleId().isEmpty()) {
							if (!displayName.isEmpty())
								displayName += " - ";
							displayName += reqUser.getRoleId();
						}
						request.setAttribute("displayName", displayName);
					}

					List<Map<String, Object>> statusList = overtimeDAO.findOvertimeStatusAll(); 
																			
					for (Map<String, Object> s : statusList) {
						if (s.get("status").equals(overtime.getStatus())) {
							request.setAttribute("status_name", (String) s.get("description"));
							request.setAttribute("status_color", (String) s.get("color"));
							break;
						}
					}
				}
			}

			return SUCCESS;
		} catch (Exception e) {
			log.error("Error in OvertimeAction.overtimeApproveForm()", e);
			return ERROR;
		}
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

	public List<User> getUserList() {
		return userList;
	}

	public void setUserList(List<User> userList) {
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