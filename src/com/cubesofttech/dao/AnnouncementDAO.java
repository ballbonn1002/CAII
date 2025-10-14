package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Announcement;
import com.cubesofttech.model.FileUpload;

public interface AnnouncementDAO {
	
	public List<Announcement> findAll() throws Exception;
	public List<FileUpload> findByPageAndPageId(String page, String pageId) throws Exception;
	public List<Map<String, Object>> readcardannounce(Integer id) throws Exception;
	public Announcement findById(Integer announcementId) throws Exception;
	
	public void save(Announcement announcement) throws Exception;
	public void update(Announcement announcement) throws Exception;
	public void delete(Announcement announcement) throws Exception;
}
