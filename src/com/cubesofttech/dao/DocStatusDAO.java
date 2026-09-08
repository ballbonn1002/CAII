package com.cubesofttech.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import com.cubesofttech.model.DocStatus;

public interface DocStatusDAO {

	List<DocStatus> findAll() throws Exception;

	List<DocStatus> findByPage(String page) throws Exception;
	
	void save(DocStatus DocStatus) throws Exception;
	
	DocStatus findById(String DocStatusId) throws Exception;

	Long getMaxId() throws Exception;

	void delete(DocStatus DocStatus) throws Exception;

	void update(DocStatus DocStatus) throws Exception;

}