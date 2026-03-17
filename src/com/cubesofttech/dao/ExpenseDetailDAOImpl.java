package com.cubesofttech.dao;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.ExpenseDetail;

@Repository
public class ExpenseDetailDAOImpl implements ExpenseDetailDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(ExpenseDetail detail) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(detail);
        session.flush();
    }

    @Override
    public void update(ExpenseDetail detail) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.clear();
        session.update(detail);
        session.flush();
    }

    @Override
    public void delete(ExpenseDetail detail) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(detail);
        session.flush();
    }

    @Override
    public ExpenseDetail findById(Long expenseDetailId) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        ExpenseDetail obj = null;
        try {
            obj = (ExpenseDetail) session.get(ExpenseDetail.class, expenseDetailId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return obj;
    }

    @Override
    public List<ExpenseDetail> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<ExpenseDetail> list = null;
        try {
            list = session.createCriteria(ExpenseDetail.class).list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<ExpenseDetail> findByExpenseId(Long expenseId) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<ExpenseDetail> list = null;
        try {
            Criteria criteria = session.createCriteria(ExpenseDetail.class);
            criteria.add(Restrictions.eq("expenseId", expenseId));
            criteria.addOrder(org.hibernate.criterion.Order.asc("expenseDetailId"));
            list = criteria.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void deleteByExpenseId(Long expenseId) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        try {
            Query q = session.createQuery("delete from ExpenseDetail d where d.expenseId = :expenseId");
            q.setParameter("expenseId", expenseId);
            q.executeUpdate();
            session.flush();
        } catch (HibernateException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Long getMaxId() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        Long maxId = 0L;
        try {
            Criteria criteria = session.createCriteria(ExpenseDetail.class)
                    .setProjection(Projections.max("expenseDetailId"));
            Object r = criteria.uniqueResult();
            if (r != null) maxId = (Long) r;
        } catch (Exception e) {
            e.printStackTrace();
            return 0L;
        }
        return maxId == null ? 0L : maxId;
    }
    
    @Override
    public List<Map<String, Object>> findDetailsByExpenseIds(List<Long> expenseIds) throws Exception {
        if (expenseIds == null || expenseIds.isEmpty()) return new ArrayList<>();

        Session session = this.sessionFactory.getCurrentSession();
        List<Map<String, Object>> list = null;
        try {
            String sql =
                " SELECT " +
                "   ed.expense_detail_id AS expense_detail_id, " +
                "   ed.expense_id        AS expense_id, " +
                "   ed.go_by             AS go_by, " +
                "   ed.total             AS total, " +
                "   ed.kilometers        AS kilometers, " +
                "   ed.description       AS description, " +
                "   tt.name              AS travel_type_name " +
                " FROM expense_detail ed " +
                " LEFT JOIN exp_travel_type tt ON tt.exp_travel_type_id = ed.go_by " +
                " WHERE ed.expense_id IN (:ids) " +
                " ORDER BY ed.expense_id ASC, ed.expense_detail_id ASC ";

            SQLQuery q = session.createSQLQuery(sql);
            q.setParameterList("ids", expenseIds);
            q.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
            list = q.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}