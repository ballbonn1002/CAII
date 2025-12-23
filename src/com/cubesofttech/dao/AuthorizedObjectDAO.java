package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.AuthorizedObject;


public interface AuthorizedObjectDAO {
    
//    public void save(AuthorizedObject authorizaedObject) throws Exception;
    
    public List<AuthorizedObject> findAll() throws Exception;
    
//    public AuthorizedObject findById(String id) throws Exception;
//    
//    public void update(AuthorizedObject authorizaedObject) throws Exception;
//    
//    public void delete(AuthorizedObject authorizaedObject) throws Exception;
}
