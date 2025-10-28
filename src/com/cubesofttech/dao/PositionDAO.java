package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Position;

public interface PositionDAO {
    
    public void save(Position position) throws Exception;
    
    public List<Map<String, Object>> sequense() throws Exception;
    
    public List<Position> findAll() throws Exception;
    
    public void update(Position position) throws Exception;
    
    public void delete(Position position) throws Exception;

	public List<Position> search(String position_id) throws Exception;
	
	public Position findById(String position_id) throws Exception;

	public List<Map<String, Object>> positionuser(String logonUser) throws Exception;
    
}