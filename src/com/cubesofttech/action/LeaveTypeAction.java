package com.cubesofttech.action;

import java.sql.Timestamp;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.LeaveTypeDAOImpl;
import com.cubesofttech.model.LeaveType;
import com.cubesofttech.model.User;
import com.opensymphony.xwork2.ActionSupport;

public class LeaveTypeAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	HttpSession session = ServletActionContext.getRequest().getSession(false);
	Logger log = Logger.getLogger(getClass());

	private List<LeaveType> leaveTypeList;
	private LeaveType leaveType;

	@Autowired
	private LeaveTypeDAOImpl leaveTypeDAO;

	public String getAllLeaveType() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				return ERROR;
			}
			leaveTypeList = leaveTypeDAO.findAll();
			leaveTypeList.sort(Comparator.comparingInt(o -> {
				String id = o.getLeaveTypeId();

				if (id == null || id.isEmpty()) {
					return Integer.MAX_VALUE;
				}

				char c = id.charAt(0);

				// ถ้าเป็นตัวเลข 0-9 → ให้เรียงก่อน
				if (Character.isDigit(c)) {
					return c; 
				}

				// ถ้าเป็นตัวอักษร → ต่อหลังเลข
				return 100 + Character.toUpperCase(c);
			}));
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	public String addLeaveType() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				return ERROR;
			}
			leaveType = new LeaveType();
			leaveTypeList = leaveTypeDAO.findAll();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	public String editLeaveType() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				return ERROR;
			}
			String id = request.getParameter("leaveTypeId");
			leaveType = leaveTypeDAO.findById(id);
			if (leaveType == null) {
				addActionError("Leave type" + id + "not found");
				return ERROR;
			}
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Error occur!");
			return ERROR;
		}

	}

	public String saveLeaveType() {
		try {

			User user = (User) session.getAttribute("user");
			Timestamp now = new Timestamp(System.currentTimeMillis());
			leaveType.setUserCreate(user.getName());
			leaveType.setUserUpdate(user.getName());
			leaveType.setTimeCreate(now);
			leaveType.setTimeUpdate(now);
			leaveTypeDAO.save(leaveType);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Save failed!");
			return ERROR;
		}

	}

	public String updateLeaveType() {
		try {
			User user = (User) session.getAttribute("user");
			Timestamp now = new Timestamp(System.currentTimeMillis());
			leaveType.setUserUpdate(user.getName());
			leaveType.setTimeUpdate(now);
			leaveTypeDAO.update(leaveType);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Updatefailed!");
			return ERROR;
		}
	}

	public String deleteLeaveType() {
		try {
			String id = request.getParameter("leaveTypeId");
			LeaveType delLeaveType = leaveTypeDAO.findById(id);

			if (delLeaveType == null) {
				addActionError("Leave type" + id + "not found");
				return ERROR;
			}

			leaveTypeDAO.delete(delLeaveType);
			return SUCCESS;

		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Delete failed");
			return ERROR;
		}
	}

	public LeaveType getLeaveType() {
		return leaveType;
	}

	public void setLeaveType(LeaveType leaveType) {
		this.leaveType = leaveType;
	}

	public List<LeaveType> getLeaveTypeList() {
		return leaveTypeList;
	}

	public void setLeaveTypeList(List<LeaveType> leaveTypeList) {
		this.leaveTypeList = leaveTypeList;
	}

}
