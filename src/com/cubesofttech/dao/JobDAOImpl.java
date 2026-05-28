package com.cubesofttech.dao;

import java.util.Date;
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

import com.cubesofttech.model.Job;
import com.cubesofttech.model.Equipment;
import com.cubesofttech.model.FileUpload;

@Repository
public class JobDAOImpl implements JobDAO {
   
   @Autowired
   private SessionFactory sessionFactory;
   
   @Override
   public List<Job> findAll() throws Exception {
       Session session = this.sessionFactory.getCurrentSession();
       List<Job> jobList = null;
       try {
           String hql = "FROM Job ORDER BY jobId DESC";
           jobList = session.createQuery(hql).list();
       } catch (Exception e) {
           e.printStackTrace();
       }
       return jobList;
   }

   @Override
   public List<Map<String, Object>> readcardjob(Integer id) throws Exception {
       Session session = this.sessionFactory.getCurrentSession();
       List<Map<String, Object>> jobDetail = null;
       try {
           String sql = "SELECT * FROM job WHERE job_id = :id";
           SQLQuery query = session.createSQLQuery(sql);
           query.setParameter("id", id);
           query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
           jobDetail = query.list();
       } catch (Exception e) {
           e.printStackTrace();
       }
       return jobDetail;
   }

   @Override
   public Job findById(Integer jobId) throws Exception {
       Session session = this.sessionFactory.getCurrentSession();
       Job job = null;
       try {
           job = (Job) session.get(Job.class, jobId);
       } catch (Exception e) {
           e.printStackTrace();
       }
       return job;
   }
   
   @Override
   public Job findByPosition(String position) throws Exception {
	   Session session = this.sessionFactory.getCurrentSession();
       Job job = null;
       try {
           job = (Job) session.get(Job.class, position);
       } catch (Exception e) {
           e.printStackTrace();
       }
       return job;
   }

   @Override
   public void save(Job job) throws Exception {
       Session session = this.sessionFactory.getCurrentSession();
       session.save(job);
       session.flush();
   }

   @Override
   public void update(Job job) throws Exception {
       Session session = this.sessionFactory.getCurrentSession();
       session.clear();
       session.update(job);
       session.flush();
   }

   @Override
   public void delete(Job job) throws Exception {
       Session session = this.sessionFactory.getCurrentSession();
       session.delete(job);
       session.flush();
   }

   @Override
   public Integer getMaxId() throws Exception {
       Session session = this.sessionFactory.getCurrentSession();
       Integer maxId = null;
       try {
           Criteria criteria = session.createCriteria(Job.class).setProjection(Projections.max("jobId"));
           maxId = (Integer) criteria.uniqueResult();
       } catch (Exception e) {
           e.printStackTrace();
       }
       return maxId == null ? 0 : maxId;
   }

   @Override
   public List<Job> search(String keyword, Date startDate, Date endDate) throws Exception {
       Session session = this.sessionFactory.getCurrentSession();
       List<Job> jobList = null;
       try {
           String hql = "FROM Job WHERE 1=1 ";
           if (keyword != null && !keyword.trim().isEmpty()) {
               hql += "AND (name LIKE :keyword OR position LIKE :keyword) ";
           }
           if (startDate != null && endDate != null) {
               hql += "AND startDate BETWEEN :startDate AND :endDate ";
           }
           hql += "ORDER BY jobId DESC";
           
           Query query = session.createQuery(hql);
           if (keyword != null && !keyword.trim().isEmpty()) {
               query.setParameter("keyword", "%" + keyword + "%");
           }
           if (startDate != null && endDate != null) {
               query.setParameter("startDate", startDate);
               query.setParameter("endDate", endDate);
           }
           jobList = query.list();
       } catch (Exception e) {
           e.printStackTrace();
       }
       return jobList;
   }
}