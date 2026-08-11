package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.GoodReceiptDetail;

@Repository
public class GoodReceiptDetailDAOImpl implements GoodReceiptDetailDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(GoodReceiptDetail goodReceiptDetail) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(goodReceiptDetail);
    }

    @Override
    public void update(GoodReceiptDetail goodReceiptDetail) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(goodReceiptDetail);
    }

    @Override
    public void delete(GoodReceiptDetail goodReceiptDetail) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(goodReceiptDetail);
    }

    @Override
    public GoodReceiptDetail findById(Integer goodReceiptDetailId) throws Exception {
        if (goodReceiptDetailId == null) {
            return null;
        }
        Session session = this.sessionFactory.getCurrentSession();
        return (GoodReceiptDetail) session.get(GoodReceiptDetail.class, goodReceiptDetailId);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<GoodReceiptDetail> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<GoodReceiptDetail> list = session.createQuery("from GoodReceiptDetail").list();
        return list != null ? list : new ArrayList<GoodReceiptDetail>();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<GoodReceiptDetail> findByGoodReceiptId(String goodReceiptId) throws Exception {
        if (goodReceiptId == null || goodReceiptId.trim().isEmpty()) {
            return new ArrayList<GoodReceiptDetail>();
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery(
                "from GoodReceiptDetail where goodReceiptId = :goodReceiptId order by goodReceiptDetailId asc");
        query.setParameter("goodReceiptId", goodReceiptId.trim());

        List<GoodReceiptDetail> list = query.list();
        return list != null ? list : new ArrayList<GoodReceiptDetail>();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<GoodReceiptDetail> findByProductId(String productId) throws Exception {
        if (productId == null || productId.trim().isEmpty()) {
            return new ArrayList<GoodReceiptDetail>();
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery(
                "from GoodReceiptDetail where productId = :productId order by timeCreate desc");
        query.setParameter("productId", productId.trim());

        List<GoodReceiptDetail> list = query.list();
        return list != null ? list : new ArrayList<GoodReceiptDetail>();
    }

    @Override
    public int deleteByGoodReceiptId(String goodReceiptId) throws Exception {
        if (goodReceiptId == null || goodReceiptId.trim().isEmpty()) {
            return 0;
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery(
                "delete from GoodReceiptDetail where goodReceiptId = :goodReceiptId");
        query.setParameter("goodReceiptId", goodReceiptId.trim());

        return query.executeUpdate();
    }

    @Override
    public Integer getMaxId() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        Integer maxId = 0;
        try {
            Criteria criteria = session.createCriteria(GoodReceiptDetail.class)
                    .setProjection(Projections.max("goodReceiptDetailId"));
            maxId = (Integer) criteria.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            maxId = 0;
        }
        return (maxId != null) ? maxId : Integer.valueOf(0);
    }
}
