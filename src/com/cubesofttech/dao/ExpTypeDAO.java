package com.cubesofttech.dao;

import java.util.List;

import com.cubesofttech.model.ExpType;

public interface ExpTypeDAO {

    void save(ExpType expType) throws Exception;

    List<ExpType> findAll() throws Exception;

    ExpType findById(String expTypeId) throws Exception;

    void update(ExpType expType) throws Exception;

    void delete(ExpType expType) throws Exception;
}