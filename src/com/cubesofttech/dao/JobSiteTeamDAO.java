package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.JobSiteTeam;

public interface JobSiteTeamDAO {
	public JobSiteTeam findById(Integer id) throws Exception;
	
	public JobSiteTeam findByIdSiteJobAndUserId(String idSiteJob, String userId) throws Exception;

	public List<JobSiteTeam> findAllByUserId(String userId) throws Exception;

	public void save(JobSiteTeam jobsite) throws Exception;

	public void delete(JobSiteTeam jobsite) throws Exception;
	
	public void deleteByIdSiteJob(String idSiteJob) throws Exception;
	
	public List<JobSiteTeam> findAllJobsiteByJobsiteId(String jobsiteId) throws Exception;
	
	
}
