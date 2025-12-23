package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.AuthorizedObject;
import com.cubesofttech.model.AuthorizedObjectGroup;


public interface AuthorizedObjectGroupDAO {
    
    public List<AuthorizedObjectGroup> findAll() throws Exception;
    
    public List<AuthorizedObjectGroup> getAuthorizedHierarchy() throws Exception;
    
}
