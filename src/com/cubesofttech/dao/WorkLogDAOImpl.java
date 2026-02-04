package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.WorkHours;

@Repository
public class WorkLogDAOImpl implements WorkLogDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public List<Map<String, Object>> search(Map<String, Object> params) throws Exception {
        try {
            String searchText = (String) params.get("searchText"); 
            String siteId = (String) params.get("siteId");
            String startDate = (String) params.get("startDate");
            String endDate = (String) params.get("endDate");
            String status = (String) params.get("status");

            StringBuilder sql = new StringBuilder();

            // filter status
            sql.append(" SELECT * FROM ( ");
            sql.append("   SELECT ");
            sql.append("     wh.work_hours_id, wh.work_hours_type, wh.work_hours_time_work, wh.time_create, ");
            sql.append("     wh.time_update, wh.work_type, wh.description, wh.ip_address, ");
            sql.append("     u.id as user_id, u.name, u.name_en, u.position_id, u.employee_id, u.role_id, ");
            sql.append("     j.id_sitejob, j.name_site, ");

            // STATUS 
            sql.append("     u.work_time_start, u.work_time_end ");
  
            // WORK DURATION
            sql.append("   FROM work_hours wh ");
            sql.append("   LEFT JOIN user u ON wh.user_create = u.id ");
            sql.append("   LEFT JOIN job_site j ON j.id_sitejob = u.id_sitejob ");
            sql.append("   WHERE 1=1 ");

            if (startDate != null && endDate != null && !startDate.isEmpty() && !endDate.isEmpty()) {
                sql.append("     AND DATE(wh.work_hours_time_work) ");
                sql.append("         BETWEEN STR_TO_DATE(:startDate, '%d-%m-%Y') AND STR_TO_DATE(:endDate, '%d-%m-%Y') ");
            }

            if (siteId != null && !siteId.isEmpty()) {
                // Filter site 
                sql.append("     AND EXISTS ( ");
                sql.append("         SELECT 1 ");
                sql.append("         FROM job_site_team jst ");
                sql.append("         WHERE jst.user_id = wh.user_create ");
                sql.append("           AND jst.id_sitejob = :siteId ");
                sql.append("     ) ");
            }

            if (searchText != null && !searchText.isEmpty()) {
                // dropdown > user id 
                sql.append("     AND u.id = :userId ");
            }

            sql.append(" ) t WHERE 1=1 ");

            String sortting = (String) params.get("sortting");
            if ("1".equals(sortting)) {
                sql.append(" ORDER BY t.work_hours_time_work ASC "); 
                
            } else {
                sql.append(" ORDER BY t.work_hours_time_work DESC "); 
            }

            SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql.toString());
            query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

            // bind parameters
            if (startDate != null && endDate != null && !startDate.isEmpty() && !endDate.isEmpty()) {
                query.setParameter("startDate", startDate);
                query.setParameter("endDate", endDate);
            }
            if (siteId != null && !siteId.isEmpty()) {
                query.setParameter("siteId", siteId);
            }
            if (searchText != null && !searchText.isEmpty()) {
                query.setParameter("userId", searchText);
            }
           
            return query.list();

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    @Override
    public WorkHours findById(Integer id) throws Exception {
        return (WorkHours) sessionFactory.getCurrentSession().get(WorkHours.class, id);
    }

    @Override
    public void update(WorkHours workHours) throws Exception {
        sessionFactory.getCurrentSession().update(workHours);
        sessionFactory.getCurrentSession().flush();
    }
}
