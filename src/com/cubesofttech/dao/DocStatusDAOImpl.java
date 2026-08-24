package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.SQLQuery;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.DocStatus;
@Repository
public class DocStatusDAOImpl implements DocStatusDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public List<DocStatus> findAll() throws Exception {
        Session session = sessionFactory.getCurrentSession();
        List<DocStatus> list = null;
        try {
            list = session.createCriteria(DocStatus.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    @Override
    public List<DocStatus> findByStatusGroup(String statusGroup) throws Exception {
        Session session = sessionFactory.getCurrentSession();
        List<DocStatus> list = null;
        try {
            list = session.createCriteria(DocStatus.class)
                    .add(Restrictions.eq("statusGroup", statusGroup))
                    .addOrder(Order.asc("docStatusId"))
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    @Override
    public void save(DocStatus docStatus) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(docStatus);
        session.flush();
    }

    @Override
    public DocStatus findById(String docStatusId) throws Exception {
        Session session = sessionFactory.getCurrentSession();
        DocStatus docStatus = null;
        try {
            docStatus = (DocStatus) session.get(DocStatus.class, docStatusId);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return docStatus;
    }

    @Override
    public Long getMaxId() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        Long maxId = 0L;
        try {
            String sql = "SELECT MAX(CAST(doc_status_id AS UNSIGNED)) FROM doc_status";
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

    @Override
    public void delete(DocStatus docStatus) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(docStatus);
        session.flush();
    }

    @Override
    public void update(DocStatus docStatus) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.clear();
        session.update(docStatus);
        session.flush();
    }

}