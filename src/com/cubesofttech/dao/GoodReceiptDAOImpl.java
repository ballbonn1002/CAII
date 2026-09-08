package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.GoodReceipt;

@Repository
public class GoodReceiptDAOImpl implements GoodReceiptDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(GoodReceipt goodReceipt) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(goodReceipt);
        session.flush();
    }

    @Override
    public void update(GoodReceipt goodReceipt) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(goodReceipt);
        session.flush();
    }

    @Override
    public void delete(GoodReceipt goodReceipt) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(goodReceipt);
        session.flush();
    }

    @Override
    public GoodReceipt findById(Integer goodReceiptId) throws Exception {
        if (goodReceiptId == null) {
            return null;
        }
        Session session = this.sessionFactory.getCurrentSession();
        return (GoodReceipt) session.get(GoodReceipt.class, goodReceiptId);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<GoodReceipt> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<GoodReceipt> list = session.createQuery("from GoodReceipt order by receiveDate desc").list();
        return list != null ? list : new ArrayList<GoodReceipt>();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<GoodReceipt> findByWarehouseId(String warehouseId) throws Exception {
        if (warehouseId == null || warehouseId.trim().isEmpty()) {
            return new ArrayList<GoodReceipt>();
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery(
                "from GoodReceipt where warehouseId = :warehouseId order by receiveDate desc");
        query.setParameter("warehouseId", warehouseId.trim());

        List<GoodReceipt> list = query.list();
        return list != null ? list : new ArrayList<GoodReceipt>();
    }

    @Override
    public Integer getMaxId() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        Integer maxId = 0;
        try {
            Criteria criteria = session.createCriteria(GoodReceipt.class)
                    .setProjection(Projections.max("goodReceiptId"));
            maxId = (Integer) criteria.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            maxId = 0;
        }
        return (maxId != null) ? maxId : Integer.valueOf(0);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> findInHistoryByParentProductId(String parentProductId) throws Exception {
        if (parentProductId == null || parentProductId.trim().isEmpty()) {
            return new ArrayList<Map<String, Object>>();
        }
        Session session = this.sessionFactory.getCurrentSession();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT g.good_receipt_id AS good_receipt_id, g.gr_ref AS gr_ref, ");
        sql.append("g.receive_date AS receive_date, g.recipient_user AS recipient_user, ");
        sql.append("g.warehouse_id AS warehouse_id, ");
        sql.append("d.good_receipt_detail_id AS good_receipt_detail_id, ");
        sql.append("d.product_id AS sub_product_id, d.parent AS parent_product_id, ");
        sql.append("d.amount AS amount, d.unit AS unit ");
        sql.append("FROM good_receipt g ");
        // good_receipt.good_receipt_id เป็น int แต่ good_receipt_detail.good_receipt_id เป็น varchar
        // จึง cast ให้เทียบกันได้
        sql.append("JOIN good_receipt_detail d ON CAST(g.good_receipt_id AS CHAR) = d.good_receipt_id ");
        // parent = สินค้าหลัก (main product) ที่ sub product สังกัด
        sql.append("WHERE d.parent = :parentProductId ");
        sql.append("ORDER BY g.receive_date DESC, g.good_receipt_id DESC, d.good_receipt_detail_id ASC");

        SQLQuery query = session.createSQLQuery(sql.toString());
        query.setParameter("parentProductId", parentProductId.trim());
        query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

        List<Map<String, Object>> rows = query.list();
        return rows != null ? rows : new ArrayList<Map<String, Object>>();
    }
}
