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

	/**
	 * ดึงความสัมพันธ์ user กับ job_site ของ "ทุกคน" ด้วย query เดียว (ใช้แทนการเรียกทีละ user ในลูป)
	 * คอลัมน์ที่ได้: user_id, id_sitejob, name_site, is_active_flag (1 = active, 0 = ไม่ active)
	 */
	public List<Map<String, Object>> findAllJobsiteTeamMembers() throws Exception;
	
	public List<Map<String, Object>> findAll() throws Exception;
	
	public List<Map<String, Object>> findAll2() throws Exception;

	List<Map<String, Object>> getJobSiteByUserId(String userId) throws Exception;
	
	public List<Map<String, Object>> findAllWithTeamAmount() throws Exception;
}
