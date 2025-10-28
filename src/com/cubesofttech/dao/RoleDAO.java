package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Role;


public interface RoleDAO {
    
	public List<Map<String, Object>> sequense() throws Exception;
	
    public void save(Role role) throws Exception;
    
    public List<Role> findAll() throws Exception;
    
    public List<Role> findByRoleId(String roleId) throws Exception;
    
    public Role findById(String id) throws Exception;
    
    public void update(Role role) throws Exception;
    
    public void delete(Role role) throws Exception;

	List<Map<String, Object>> sequense2() throws Exception;
    
}
