package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.Notification;

public interface NotificationDAO {

	public void save(Notification notification) throws Exception;

	public void update(Notification notification) throws Exception;

	public Notification findById(int id) throws Exception;

	public List<Notification> findByUserId(String userId) throws Exception;

}
