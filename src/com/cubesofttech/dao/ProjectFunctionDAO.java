package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.Project;
import com.cubesofttech.model.ProjectFunction;

public interface ProjectFunctionDAO {

	List<ProjectFunction> findAllByProjectId(Integer projectId) throws Exception;
	
	public void save(ProjectFunction project) throws Exception;
	
	public Integer getMaxId() throws Exception;
	
	
	public ProjectFunction findByName(String functionName) throws Exception;
	
    public ProjectFunction findById(Integer id) throws Exception;

}
