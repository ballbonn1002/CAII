package com.cubesofttech.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;
import com.cubesofttech.model.Job;

public interface JobDAO {
   public List<Job> findAll() throws Exception;
   public List<Map<String, Object>> readcardjob(Integer id) throws Exception;
   public Job findById(Integer jobId) throws Exception;
   public Job findByPosition(String position) throws Exception;
   
   public void save(Job job) throws Exception;
   public void update(Job job) throws Exception;
   public void delete(Job job) throws Exception;
   
   public Integer getMaxId() throws Exception;
   public List<Job> search(String keyword, Date startDate, Date endDate) throws Exception;
}