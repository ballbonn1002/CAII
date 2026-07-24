package com.cubesofttech.action;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.apache.struts2.ServletActionContext;

import com.cubesofttech.dao.NotificationDAO;
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
			List<Notification> list = notificationDAO.findByUserId(onlineUser.getId());

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
			List<Notification> list = notificationDAO.findByUserId(onlineUser.getId());
			request.setAttribute("notificationList", list);
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
			if (notification != null && notification.getUserId().equals(onlineUser.getId())) {
				notification.setIsRead(true);
				notification.setUserUpdate(onlineUser.getId());
				notification.setTimeUpdate(DateUtil.getCurrentTime());
				notificationDAO.update(notification);
			}
			return SUCCESS;
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
