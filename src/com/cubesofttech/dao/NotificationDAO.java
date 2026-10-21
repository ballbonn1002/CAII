package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Notification;

public interface NotificationDAO {

	public void save(Notification notification) throws Exception;

	public void update(Notification notification) throws Exception;

	public Notification findById(int id) throws Exception;

	public List<Map<String, Object>> findByUserId(String userId) throws Exception;

	public List<Map<String, Object>> findLatestByUserId(String userId, int maxResults) throws Exception;

	public void markAllRead(String userId, String actorId) throws Exception;

}
