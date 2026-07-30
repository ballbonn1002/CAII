package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.cubesofttech.model.Product;

@Repository
public class ProductDAOImpl implements ProductDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Product product) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(product);
    }

    @Override
    public void update(Product product) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(product);
    }

    @Override
    public void delete(Product product) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(product);
    }

    @Override
    public Product findById(Integer id) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        return (Product) session.get(Product.class, id);
    }

    @Override
    public List<Product> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        return session.createQuery("from Product").list();
    }

    @Override
    public List<Map<String, Object>> findAllConsWithSubProducts() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<Map<String, Object>> products = null;
        try {
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT main.product_id AS product_id, main.sequence AS sequence, ");
            sql.append("main.product_name AS product_name, main.product_type AS product_type, ");
            sql.append("GROUP_CONCAT(sub.product_name ORDER BY sub.sequence ASC SEPARATOR ',') AS sub_products, ");
            sql.append("u.unit_id AS unit_id, u.unit_name AS unit_name ");
            sql.append("FROM product main ");
            sql.append("LEFT JOIN product sub ON main.product_id = sub.parent_product_id ");
            sql.append("LEFT JOIN unit_of_measure u ON main.product_id = u.product_id AND u.sequence = 0 ");
            sql.append("WHERE main.product_type = 2 AND main.parent_product_id = 0 ");
            sql.append("GROUP BY main.product_id, main.sequence, main.product_name, main.product_type, u.unit_id, u.unit_name ");
            sql.append("ORDER BY main.product_id ASC");
            SQLQuery query = session.createSQLQuery(sql.toString());
            query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
            products = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return products;
    }
    
}
