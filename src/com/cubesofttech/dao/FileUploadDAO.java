package com.cubesofttech.dao;

import java.util.Date;
import java.util.List;

import com.cubesofttech.model.FileUpload;


public interface FileUploadDAO {

    public void save(FileUpload fileupload) throws Exception;

    public List<FileUpload> findAll() throws Exception;

    public FileUpload findById(String id) throws Exception;

    public FileUpload findById(int id) throws Exception;

    public void update(FileUpload fileupload) throws Exception;

    public void delete(FileUpload fileupload) throws Exception;

    Integer getMaxId() throws Exception;

	List<FileUpload> findByuser(String user) throws Exception;

	public void deleteByPath(String path) throws Exception;

	public List<FileUpload> findByTicketId(String ticket_id) throws Exception;

//	public void delete(String fileId) throws Exception;

	public List<FileUpload> findByPageAndPageId(String page, String pageId) throws Exception;

	public void deletepageandpageid(String page, String PageId) throws Exception;

	public List<FileUpload> findBypageandpageid(String page, String PageId) throws Exception;

	void deleteByPathAtc(String path);

	List<FileUpload> searchFiles(String keyword, Date startDate, Date endDate, String userId) throws Exception;

	void updateTempArticleImageToArticle(String tempKey, String articleId);


}
