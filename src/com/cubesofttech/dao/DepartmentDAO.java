package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Department;


public interface DepartmentDAO {
    
    public void save(Department department) throws Exception;
    
    public List<Map<String, Object>> sequense() throws Exception;
    
    public List<Department> findAll() throws Exception;
    public List<Map<String, Object>> findAllList() throws Exception;
    
    public List<Department> findByDepartmentId(String departmentId) throws Exception;
    
    public Department findById(String id) throws Exception;
    
    public void update(Department department) throws Exception;
    
    public void delete(Department department) throws Exception;

	public List<Department> search(String departmentId) throws Exception;
}
