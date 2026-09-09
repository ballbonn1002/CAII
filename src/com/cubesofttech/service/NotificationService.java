package com.cubesofttech.service;

import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cubesofttech.dao.NotificationDAO;
import com.cubesofttech.model.Notification;
import com.cubesofttech.util.DateUtil;

@Service
public class NotificationService {

	@Autowired
	private NotificationDAO notificationDAO;

	public void create(String userId, String title, String message, String description, String actorId, String funcId) throws Exception {
		Notification notification = new Notification();
		notification.setUserId(userId);
		notification.setTitle(title);
		notification.setFunctionId(funcId);
		notification.setMessage(message);
		notification.setDescription(description);
		notification.setIsRead(false);
		notification.setUserCreate(actorId);
		notification.setUserUpdate(actorId);
		Timestamp now = DateUtil.getCurrentTime();
		notification.setTimeCreate(now);
		notification.setTimeUpdate(now);
		notificationDAO.save(notification);
	}

}
