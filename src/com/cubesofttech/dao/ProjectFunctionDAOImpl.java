package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.ProjectFunction;

@Repository
public class ProjectFunctionDAOImpl implements ProjectFunctionDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<ProjectFunction> findAllByProjectId(Integer projectId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<ProjectFunction> projectFunc = null;
		try {
			String sql = "SELECT * FROM project_function WHERE project_id = :projectId";
			SQLQuery query = session.createSQLQuery(sql);
			query.addEntity(ProjectFunction.class);
			query.setParameter("projectId", projectId);
			projectFunc = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return projectFunc;
	}

	@Override
	public ProjectFunction findById(Integer functionId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		ProjectFunction function = null;
		try {
			function = session.get(ProjectFunction.class, functionId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return function;
	}

	@Override
	public void save(ProjectFunction function) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(function);
		session.flush();

	}

	@Override
	public Integer getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Integer maxId = 0;
		try {

			Criteria criteria = session.createCriteria(ProjectFunction.class)
					.setProjection(Projections.max("function_id"));
			maxId = (Integer) criteria.uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
			return new Integer(0);

		}
		if (maxId != null) {
			return maxId;
		} else {
			return new Integer(0);
		}
	}

}
