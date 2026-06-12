package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.Project;

public interface ProjectDAO {

	public List<Project> findAll() throws Exception;

	public Project findById(Integer projectId) throws Exception;
	
	public Project findByName(String projectName) throws Exception;
	
	public void save(Project project) throws Exception;
	
	public Integer getMaxId() throws Exception;
}
