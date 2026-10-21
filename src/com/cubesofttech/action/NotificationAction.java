package com.cubesofttech.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.apache.struts2.ServletActionContext;

import com.cubesofttech.dao.NotificationDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.Notification;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.opensymphony.xwork2.ActionSupport;

public class NotificationAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(NotificationAction.class);

	@Autowired
	private NotificationDAO notificationDAO;

	@Autowired
	private UserDAO userDAO;

	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();

	private Integer id;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String listJson() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			List<Map<String, Object>> list = notificationDAO.findLatestByUserId(onlineUser.getId(), 10);

			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss").create();
			String json = gson.toJson(list);

			response.setContentType("application/json;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();
			out.close();

			return null;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String list() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			List<Map<String, Object>> list = notificationDAO.findByUserId(onlineUser.getId());

			// Resolve "employee_id - name" for each notification's user_id (used in the Message column)
			Map<String, String> actorMap = new HashMap<String, String>();
			for (Map<String, Object> n : list) {
				String uid = (String) n.get("userId");
				if (uid == null || actorMap.containsKey(uid)) {
					continue;
				}
				try {
					User u = userDAO.findById(uid);
					if (u != null) {
						String empId = u.getEmployeeId() == null ? "" : u.getEmployeeId().trim();
						String name = u.getNameEN() == null ? "" : u.getNameEN().trim();
						String label;
						if (!empId.isEmpty() && !name.isEmpty()) {
							label = empId + " - " + name;
						} else {
							label = empId + name;
						}
						actorMap.put(uid, label);
					}
				} catch (Exception ex) {
					log.error("Unable to resolve notification actor for user_id " + uid, ex);
				}
			}

			request.setAttribute("notificationList", list);
			request.setAttribute("actorMap", actorMap);
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String read() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			Notification notification = notificationDAO.findById(id);
			if (notification != null && notification.getSendTo().equals(onlineUser.getId()) && notification.getIsRead() == false) {
				notification.setIsRead(true);
				notification.setTimeUpdate(DateUtil.getCurrentTime());
				notificationDAO.update(notification);
			}
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String readAll() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			notificationDAO.markAllRead(onlineUser.getId(), onlineUser.getId());
			return null;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String detail() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			Notification notification = notificationDAO.findById(id);
			if (notification == null || !notification.getUserId().equals(onlineUser.getId())) {
				return ERROR;
			}
			request.setAttribute("notification", notification);
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

}
