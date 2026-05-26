package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.ExpTravelType;

public interface ExpTravelTypeDAO {

    void save(ExpTravelType travelType) throws Exception;

    List<ExpTravelType> findAll() throws Exception;
    
    Map<Long, Integer> getCountUseType() throws Exception;

    ExpTravelType findById(Long expTravelTypeId) throws Exception;

    void update(ExpTravelType travelType) throws Exception;

    void delete(ExpTravelType travelType) throws Exception;

    Long getMaxId() throws Exception;
}