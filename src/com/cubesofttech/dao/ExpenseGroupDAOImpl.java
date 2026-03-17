package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.ExpenseGroup;

@Repository
public class ExpenseGroupDAOImpl implements ExpenseGroupDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(ExpenseGroup expenseGroup) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(expenseGroup);
        session.flush();
    }

    @Override
    public List<ExpenseGroup> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        return session.createCriteria(ExpenseGroup.class).list();
    }

    @Override
    public ExpenseGroup findById(Long expenseGroupId) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        return (ExpenseGroup) session.get(ExpenseGroup.class, expenseGroupId);
    }

    @Override
    public void update(ExpenseGroup expenseGroup) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.clear();
        session.update(expenseGroup);
        session.flush();
    }

    @Override
    public void delete(ExpenseGroup expenseGroup) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(expenseGroup);
        session.flush();
    }

    @Override
    public Long getMaxId() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        Long maxId = 0L;
        try {
            Criteria criteria = session.createCriteria(ExpenseGroup.class)
                    .setProjection(Projections.max("expenseGroupId"));
            Object r = criteria.uniqueResult();
            if (r != null) maxId = (Long) r;
        } catch (Exception e) {
            e.printStackTrace();
            return 0L;
        }
        return maxId == null ? 0L : maxId;
    }

    @Override
    public int updateStatus(Long expenseGroupId, String fromStatus, String toStatus, String userUpdate)
            throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        try {
            String sql = ""
                + "UPDATE expense_group "
                + "SET status_id = :toStatus, user_update = :userUpdate, time_update = NOW() "
                + "WHERE expense_group_id = :gid AND status_id = :fromStatus";

            SQLQuery query = session.createSQLQuery(sql);
            query.setParameter("toStatus", toStatus);
            query.setParameter("userUpdate", userUpdate);
            query.setParameter("gid", expenseGroupId);
            query.setParameter("fromStatus", fromStatus);

            int affected = query.executeUpdate();
            session.flush();
            return affected;
        } catch (HibernateException e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public Map<String, Object> findGroupHeaderForModal(Long expenseGroupId) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        Map<String, Object> row = null;

        try {
            String sql = ""
                + "SELECT g.expense_group_id, g.status_id, g.total_amount, g.exp_type_id, "
                + "       g.user_id, u.employee_id, u.name, u.name_en, "
                + "       g.time_create AS request_date "
                + "FROM expense_group g "
                + "LEFT JOIN user u ON g.user_id = u.id "
                + "WHERE g.expense_group_id = :gid "
                + "LIMIT 1";

            SQLQuery query = session.createSQLQuery(sql);
            query.setParameter("gid", expenseGroupId);
            query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

            row = (Map<String, Object>) query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return row;
    }

    // ✅ เวอร์ชัน Hibernate เก่า: ใช้ org.hibernate.Query
    @Override
    public ExpenseGroup findByUserMonthYearAndStatus(
            String userId, String expTypeId, Short month, Integer year, String statusId) throws Exception {

        Session session = this.sessionFactory.getCurrentSession();
        ExpenseGroup group = null;

        try {
            String hql = "from ExpenseGroup g "
                       + "where g.userId = :uid "
                       + "and g.expTypeId = :tid "
                       + "and g.paidMonth = :m "
                       + "and g.paidYear = :y "
                       + "and g.statusId = :sid "
                       + "order by g.expenseGroupId desc";

            org.hibernate.Query q = session.createQuery(hql);
            q.setParameter("uid", userId);
            q.setParameter("tid", expTypeId);
            q.setParameter("m", month);   // ✅ Short ให้ตรง field
            q.setParameter("y", year);
            q.setParameter("sid", statusId);

            q.setMaxResults(1);
            group = (ExpenseGroup) q.uniqueResult();

        } catch (HibernateException e) {
            e.printStackTrace();
        }

        return group;
    }
    
    @Override
    public int countMyGroupsByStatus(
            String status, String userId,
            java.sql.Date dateFrom, java.sql.Date dateTo) throws Exception {

        Session session = this.sessionFactory.getCurrentSession();
        try {
            StringBuilder sql = new StringBuilder()
                .append("SELECT COUNT(*) ")
                .append("FROM expense_group g ")
                .append("WHERE g.status_id   = :status ")
                .append("  AND g.user_id     = :userId ");

            if (dateFrom != null) sql.append("  AND DATE(g.requested_at) >= :dateFrom ");
            if (dateTo   != null) sql.append("  AND DATE(g.requested_at) <= :dateTo ");

            SQLQuery query = session.createSQLQuery(sql.toString());
            query.setParameter("status", status);
            query.setParameter("userId", userId);
            if (dateFrom != null) query.setParameter("dateFrom", dateFrom);
            if (dateTo   != null) query.setParameter("dateTo",   dateTo);

            Object result = query.uniqueResult();
            return result != null ? ((Number) result).intValue() : 0;

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public List<Map<String, Object>> findMyGroupsByStatus(
            String status, String userId,
            java.sql.Date dateFrom, java.sql.Date dateTo,
            int offset, int pageSize) throws Exception {

        Session session = this.sessionFactory.getCurrentSession();
        try {
            StringBuilder sql = new StringBuilder()
                // ── ข้อมูล group header ──────────────────────────────────────────
                .append("SELECT ")
                .append("  g.expense_group_id, ")
                .append("  g.status_id, ")
                .append("  g.total_amount, ")
                .append("  g.requested_at, ")
                .append("  g.user_id, ")
                // ── นับจำนวน expense ใน group ────────────────────────────────────
                .append("  (SELECT COUNT(*) FROM expense e ")
                .append("   WHERE e.expense_group_id = g.expense_group_id) AS item_count, ")
                // ── ชื่อ user ─────────────────────────────────────────────────────
                .append("  u.name_en AS user_name ")
                .append("FROM expense_group g ")
                .append("LEFT JOIN user u ON u.id = g.user_id ")
                .append("WHERE g.status_id = :status ")
                .append("  AND g.user_id   = :userId ");

            if (dateFrom != null) sql.append("  AND DATE(g.requested_at) >= :dateFrom ");
            if (dateTo   != null) sql.append("  AND DATE(g.requested_at) <= :dateTo ");

            sql.append("ORDER BY g.expense_group_id DESC ")
               .append("LIMIT :limit OFFSET :offset");

            SQLQuery query = session.createSQLQuery(sql.toString());
            query.setParameter("status", status);
            query.setParameter("userId", userId);
            if (dateFrom != null) query.setParameter("dateFrom", dateFrom);
            if (dateTo   != null) query.setParameter("dateTo",   dateTo);
            query.setParameter("limit",  pageSize);
            query.setParameter("offset", offset);
            query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

            return query.list();

        } catch (Exception e) {
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }
}
