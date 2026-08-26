package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Stock;

@Repository
public class StockDAOImpl implements StockDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Stock stock) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(stock);
    }

    @Override
    public void update(Stock stock) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(stock);
    }

    @Override
    public void delete(Stock stock) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(stock);
    }

    @Override
    public Stock findById(String stockId) throws Exception {
        if (stockId == null || stockId.trim().isEmpty()) {
            return null;
        }
        Session session = this.sessionFactory.getCurrentSession();
        return (Stock) session.get(Stock.class, stockId.trim());
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Stock> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<Stock> stocks = session.createQuery("from Stock order by timeCreate desc").list();
        return stocks != null ? stocks : new ArrayList<Stock>();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Stock> findByProductId(String productId) throws Exception {
        if (productId == null || productId.trim().isEmpty()) {
            return new ArrayList<Stock>();
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery(
                "from Stock where productId = :productId order by timeCreate desc");
        query.setParameter("productId", productId.trim());

        List<Stock> stocks = query.list();
        return stocks != null ? stocks : new ArrayList<Stock>();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Stock> findByActionRef(String actionRef) throws Exception {
        if (actionRef == null || actionRef.trim().isEmpty()) {
            return new ArrayList<Stock>();
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery(
                "from Stock where actionRef = :actionRef order by timeCreate desc");
        query.setParameter("actionRef", actionRef.trim());

        List<Stock> stocks = query.list();
        return stocks != null ? stocks : new ArrayList<Stock>();
    }

    @Override
    public Stock findLatestByProductId(String productId) throws Exception {
        if (productId == null || productId.trim().isEmpty()) {
            return null;
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery(
                "from Stock where productId = :productId order by timeCreate desc, stockId desc");
        query.setParameter("productId", productId.trim());
        // เอาแถวล่าสุดแถวเดียว กัน NonUniqueResultException
        query.setMaxResults(1);

        return (Stock) query.uniqueResult();
    }

    @Override
    public Double sumConvertByProductId(String productId) throws Exception {
        if (productId == null || productId.trim().isEmpty()) {
            return Double.valueOf(0d);
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery(
                "select coalesce(sum(amountConvert), 0) from Stock where productId = :productId");
        query.setParameter("productId", productId.trim());

        Object result = query.uniqueResult();
        // coalesce กัน null ระดับ SQL แล้ว แต่ยัง null-check ฝั่ง Java กัน NPE ตอน unbox
        return (result != null) ? ((Number) result).doubleValue() : 0d;
    }

    @Override
    public Long getMaxId() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        Long maxId = 0L;
        try {
            String sql = "SELECT MAX(CAST(stock_id AS UNSIGNED)) FROM stock";
            SQLQuery query = session.createSQLQuery(sql);
            Object result = query.uniqueResult();
            if (result != null) {
                maxId = ((Number) result).longValue();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return maxId;
    }
}
