package com.cubesofttech.dao;

import java.util.List;
import com.cubesofttech.model.SupportDetail;

public interface SupportDetailDAO {
    public void save(SupportDetail supportDetail) throws Exception;
    public void update(SupportDetail supportDetail) throws Exception;
    public void delete(SupportDetail supportDetail) throws Exception;
    public SupportDetail findById(Integer supportDetailId) throws Exception;
    public List<SupportDetail> findAll() throws Exception;
    public List<SupportDetail> findBySupportId(String supportId) throws Exception;
}
