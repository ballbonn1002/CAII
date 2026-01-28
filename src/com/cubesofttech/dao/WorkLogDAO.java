package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

public interface WorkLogDAO {
    
    public List<Map<String, Object>> search(Map<String, Object> params) throws Exception;
}