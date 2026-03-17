package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Project;
import com.cubesofttech.model.Timesheet;

@Repository
public class ProjectDAOImpl implements ProjectDAO {
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<Project> findAll() throws Exception {

		Session session = this.sessionFactory.getCurrentSession();
		List<Project> projectList = null;
		try {
			projectList = session.createCriteria(Project.class).list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return projectList;
	}

	@Override
	public Project findById(Integer projectId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Project project = null;
		try {
			project = session.get(Project.class, projectId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return project;
	}

	@Override
	public void save(Project project) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(project);
		session.flush();

	}

	@Override
	public Integer getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Integer maxId = 0;
		try {

			Criteria criteria = session.createCriteria(Project.class).setProjection(Projections.max("project_id"));
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
