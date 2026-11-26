package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Asset;

@Repository
public class AssetDAOImpl implements AssetDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Asset asset) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(asset);
        session.flush();
    }

    @Override
    public void update(Asset asset) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(asset);
        session.flush();
    }

    @Override
    public void delete(Asset asset) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(asset);
        session.flush();
    }

    @Override
    public Asset findById(Integer assetId) throws Exception {
        if (assetId == null) {
            return null;
        }
        Session session = this.sessionFactory.getCurrentSession();
        return (Asset) session.get(Asset.class, assetId);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Asset> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery(
                "from Asset order by coalesce(timeUpdate, timeCreate) desc, assetId desc");
        List<Asset> list = query.list();
        return list != null ? list : new ArrayList<Asset>();
    }

    @Override
    public int findMaxItemNoSequence(String prefix) throws Exception {
        if (prefix == null || prefix.isEmpty()) {
            return 0;
        }
        Session session = this.sessionFactory.getCurrentSession();
        // ส่วนท้ายต้องเป็นตัวเลขล้วนเท่านั้น (REGEXP) กัน Item No. แปลกๆ ทำให้ CAST ได้ค่าเพี้ยน
        SQLQuery query = session.createSQLQuery(
                "SELECT COALESCE(MAX(CAST(SUBSTRING(item_no, :start) AS UNSIGNED)), 0) "
                + "FROM asset WHERE item_no LIKE :prefixLike AND SUBSTRING(item_no, :start) REGEXP '^[0-9]+$'");
        query.setParameter("start", Integer.valueOf(prefix.length() + 1));
        query.setParameter("prefixLike", prefix + "%");
        Object result = query.uniqueResult();
        return (result instanceof Number) ? ((Number) result).intValue() : 0;
    }

    @Override
    public boolean existsByItemNo(String itemNo) throws Exception {
        if (itemNo == null || itemNo.trim().isEmpty()) {
            return false;
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery(
                "select count(a.assetId) from Asset a where lower(trim(a.itemNo)) = :itemNo");
        query.setParameter("itemNo", itemNo.trim().toLowerCase());
        Object result = query.uniqueResult();
        return (result instanceof Number) && ((Number) result).longValue() > 0;
    }

    @Override
    public Asset findByItemNo(String itemNo) throws Exception {
        if (itemNo == null || itemNo.trim().isEmpty()) {
            return null;
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Asset a where lower(trim(a.itemNo)) = :itemNo");
        query.setParameter("itemNo", itemNo.trim().toLowerCase());
        query.setMaxResults(1);
        return (Asset) query.uniqueResult();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Asset> findByWarehouseIds(List<Long> warehouseIds) throws Exception {
        if (warehouseIds == null || warehouseIds.isEmpty()) {
            return new ArrayList<Asset>();
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Asset a where a.warehouseId in (:ids) order by a.itemNo");
        query.setParameterList("ids", warehouseIds);
        List<Asset> list = query.list();
        return list != null ? list : new ArrayList<Asset>();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Asset> findByProductIds(List<Integer> productIds) throws Exception {
        if (productIds == null || productIds.isEmpty()) {
            return new ArrayList<Asset>();
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Asset a where a.productId in (:ids) order by a.itemNo");
        query.setParameterList("ids", productIds);
        List<Asset> list = query.list();
        return list != null ? list : new ArrayList<Asset>();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Asset> findUnlinked() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Asset a where a.productId is null order by a.itemNo");
        List<Asset> list = query.list();
        return list != null ? list : new ArrayList<Asset>();
    }
}
