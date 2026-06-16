package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.WorkHours;

public interface WorkLogDAO {
    
    public List<Map<String, Object>> search(Map<String, Object> params) throws Exception;
    
    public WorkHours findById(Integer id) throws Exception;
    public void update(WorkHours workHours) throws Exception;

	List<Map<String, Object>> searchWorkLocation(Map<String, Object> params) throws Exception;
}