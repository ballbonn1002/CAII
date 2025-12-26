package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Jobsite;

public interface JobsiteDAO {
	
	public void save(Jobsite jobsite) throws Exception;
	
	public void update(Jobsite jobsite) throws Exception;

	public void delete(Jobsite jobsite) throws Exception;
	
	void deleteTeamByJobsite(String idSitejob) throws Exception;
	
	public Jobsite findById(Integer id) throws Exception;
	
	public List<Map<String, Object>> getNameSiteListByUserId(String userId) throws Exception;
	
	public List<Map<String, Object>> findJobsiteUser(String userId) throws Exception;
	
	public List<Map<String, Object>> findAll() throws Exception;
	
	public List<Map<String, Object>> findAll2() throws Exception;

	List<Map<String, Object>> getJobSiteByUserId(String userId) throws Exception;
	
	public List<Map<String, Object>> findAllWithTeamAmount() throws Exception;
}
