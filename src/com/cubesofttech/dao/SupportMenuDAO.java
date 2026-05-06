package com.cubesofttech.dao;

import java.util.List;
import com.cubesofttech.model.SupportMenu;

public interface SupportMenuDAO {
    public void save(SupportMenu supportMenu) throws Exception;
    public void update(SupportMenu supportMenu) throws Exception;
    public void delete(SupportMenu supportMenu) throws Exception;
    public SupportMenu findById(Integer supportMenuId) throws Exception;
    public List<SupportMenu> findAll() throws Exception;
}
