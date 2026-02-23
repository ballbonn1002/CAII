package com.cubesofttech.dao;

import java.util.List;
import com.cubesofttech.model.Overtime;
import java.util.Map;

public interface OvertimeDAO {
    
    public void save(Overtime overtime) throws Exception;
    
    public void update(Overtime overtime) throws Exception;

    public void delete(Overtime overtime) throws Exception;
    
    public Overtime findById(Integer id) throws Exception;
    
    public List<Map<String, Object>> findAll() throws Exception;
    
    public List<Map<String, Object>> findByCriteria(String userId, String status, String dateRange) throws Exception;
    
    public List<Map<String, Object>> findOvertimeStatusAll() throws Exception;

    public List<Map<String, Object>> getOvertimeByUserId(String userId) throws Exception;

    
}