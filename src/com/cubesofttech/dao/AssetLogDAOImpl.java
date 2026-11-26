package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.AssetLog;

@Repository
public class AssetLogDAOImpl implements AssetLogDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(AssetLog move) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(move);
        session.flush();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<AssetLog> findByAssetId(Integer assetId) throws Exception {
        if (assetId == null) {
            return new ArrayList<AssetLog>();
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from AssetLog m where m.assetId = :assetId order by m.timeCreate desc, m.logId desc");
        query.setParameter("assetId", assetId);
        List<AssetLog> list = query.list();
        return list != null ? list : new ArrayList<AssetLog>();
    }

    @Override
    public boolean existsByAssetId(Integer assetId) throws Exception {
        if (assetId == null) {
            return false;
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("select count(m.logId) from AssetLog m where m.assetId = :assetId");
        query.setParameter("assetId", assetId);
        Object result = query.uniqueResult();
        return (result instanceof Number) && ((Number) result).longValue() > 0;
    }

    @Override
    @SuppressWarnings("unchecked")
    public Set<Integer> findMovedAssetIds() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("select distinct m.assetId from AssetLog m");
        List<Integer> list = query.list();
        return list != null ? new HashSet<Integer>(list) : new HashSet<Integer>();
    }
}
