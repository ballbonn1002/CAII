package com.cubesofttech.dao;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Support;

@Repository
public class SupportDAOImpl implements SupportDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Support support) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(support);
        session.flush();
    }

    @Override
    public void update(Support support) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.clear();
        session.update(support);
        session.flush();
    }

    @Override
    public void delete(Support support) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.clear();
        session.delete(support);
        session.flush();
    }

    @Override
    public Support findById(Integer supportId) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        Support support = null;
        try {
            support = (Support) session.get(Support.class, supportId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return support;
    }

    @Override
    public List<Support> findAll() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<Support> supportList = null;
        try {
            String hql = "SELECT s FROM Support s ORDER BY s.timeCreate DESC";
            supportList = session.createQuery(hql).list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return supportList;
    }

    @Override
    public List<Support> searchSupport(String searchText, String[] status, String[] categorized, String[] supportMenuId,
            String year, String startDate, String endDate) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        List<Support> supportList = null;
        try {
            StringBuilder hql = new StringBuilder("SELECT s FROM Support s WHERE 1=1 ");

            if (searchText != null && !searchText.trim().isEmpty()) {
                hql.append(" AND s.userCreate LIKE :searchText ");
            }
            if (status != null && status.length > 0) {
                hql.append(" AND s.status IN (:status) ");
            }
            if (categorized != null && categorized.length > 0) {
                hql.append(" AND s.categorized IN (:categorized) ");
            }
            if (supportMenuId != null && supportMenuId.length > 0) {
                hql.append(" AND s.supportMenuId IN (:supportMenuId) ");
            }
            if (year != null && !year.trim().isEmpty() && !"All".equals(year)) {
                hql.append(" AND YEAR(s.timeCreate) = :year ");
            }

            // เพิ่ม Date Range Filter
            if (startDate != null && !startDate.trim().isEmpty() && endDate != null && !endDate.trim().isEmpty()) {
                hql.append(" AND s.timeCreate >= STR_TO_DATE(:startDate, '%d-%m-%Y %H:%i:%s') ");
                hql.append(" AND s.timeCreate <= STR_TO_DATE(:endDate, '%d-%m-%Y %H:%i:%s') ");
            }

            hql.append(" ORDER BY s.timeCreate DESC");

            Query query = session.createQuery(hql.toString());

            if (searchText != null && !searchText.trim().isEmpty()) {
                query.setParameter("searchText", "%" + searchText.trim() + "%");
            }
            if (status != null && status.length > 0) {
                query.setParameterList("status", status);
            }
            if (categorized != null && categorized.length > 0) {
                query.setParameterList("categorized", categorized);
            }
            if (supportMenuId != null && supportMenuId.length > 0) {
                query.setParameterList("supportMenuId", supportMenuId);
            }
            if (year != null && !year.trim().isEmpty() && !"All".equals(year)) {
                query.setParameter("year", Integer.valueOf(year));
            }

            if (startDate != null && !startDate.trim().isEmpty() && endDate != null && !endDate.trim().isEmpty()) {
                query.setParameter("startDate", startDate.trim() + " 00:00:00");
                query.setParameter("endDate", endDate.trim() + " 23:59:59");
            }

            supportList = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return supportList;
    }

    @Override
    public void autoCloseResolved() throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        String sql = "UPDATE support SET status = 'Closed' " +
                "WHERE status = 'Resolved' " +
                "AND DATEDIFF(NOW(), time_update) >= 5";
        session.createSQLQuery(sql).executeUpdate();
    }
}
