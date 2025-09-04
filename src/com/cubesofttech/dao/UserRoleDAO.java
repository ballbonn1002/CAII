package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.UserRole;


public interface UserRoleDAO {
    
    public void save(UserRole userRole) throws Exception;
    
    public List<UserRole> findAll() throws Exception;
    
    public List<UserRole> findByRoleId(String roleId) throws Exception;
    
    public List<UserRole> findByUserId(String userId) throws Exception;
    
    public void update(UserRole userRole) throws Exception;
    
    public void delete(UserRole userRole) throws Exception;
    
    
}
