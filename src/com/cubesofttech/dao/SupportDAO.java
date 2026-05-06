package com.cubesofttech.dao;

import java.util.List;
import com.cubesofttech.model.Support;

public interface SupportDAO {
    public void save(Support support) throws Exception;
    public void update(Support support) throws Exception;
    public void delete(Support support) throws Exception;
    public Support findById(Integer supportId) throws Exception;
    public List<Support> findAll() throws Exception;

    // Method ที่เพิ่มใหม่สำหรับใช้ Filter
    public List<Support> searchSupport(String searchText, String[] status, String[] categorized, String[] supportMenuId, String year, String startDate, String endDate) throws Exception;
    public void autoCloseResolved() throws Exception;
}
