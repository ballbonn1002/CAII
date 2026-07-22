package com.cubesofttech.dao;

import java.util.List;
import com.cubesofttech.model.Product;

public interface ProductDAO {
    public void save(Product product) throws Exception;
    public void update(Product product) throws Exception;
    public void delete(Product product) throws Exception;
    public Product findById(Integer id) throws Exception;
    public List<Product> findAll() throws Exception;
    public List<Product> findAllConsWithSubProducts() throws Exception;
}
