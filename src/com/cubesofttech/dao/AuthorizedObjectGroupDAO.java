package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.AuthorizedObjectGroup;


public interface AuthorizedObjectGroupDAO {
    
	void save(AuthorizedObjectGroup authorizedObjectGroup) throws Exception;
	
    public AuthorizedObjectGroup findById(Integer authorizedObjectGroupId) throws Exception;
    
    public List<AuthorizedObjectGroup> findByName(String name) throws Exception;
    
    public void update(AuthorizedObjectGroup authorizedObjectGroup) throws Exception;
    
    public void delete(AuthorizedObjectGroup authorizedObjectGroup) throws Exception;

	public List<AuthorizedObjectGroup> findAll() throws Exception;
    
    public List<AuthorizedObjectGroup> getAuthorizedHierarchy() throws Exception;

}
