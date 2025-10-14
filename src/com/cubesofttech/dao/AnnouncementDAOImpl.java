package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Announcement;
import com.cubesofttech.model.FileUpload;

@Repository
public class AnnouncementDAOImpl implements AnnouncementDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<Announcement> findAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Announcement> announcementList = null;
	    try {
	        String hql = "SELECT a FROM Announcement a LEFT JOIN FETCH a.fileUpload";
	        announcementList = session.createQuery(hql).list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return announcementList;
	}
	
	@Override
	public List<FileUpload> findByPageAndPageId(String page, String pageId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<FileUpload> fileList = null;
		try {
			String sql = "SELECT * FROM file WHERE page = :page AND page_id = :pageId";
			SQLQuery query = session.createSQLQuery(sql);
			query.addEntity(FileUpload.class);
			query.setParameter("page", page);
			query.setParameter("pageId", pageId);

			fileList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileList;
	}
	
	@Override
	public List<Map<String, Object>> readcardannounce(Integer id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> announcementList = new ArrayList<>();
		try {
			String sql = "SELECT an.*, file.path AS path FROM announcement an LEFT JOIN file ON file.file_id =an.file_id WHERE an.announcement_id = "
					+ id;
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			announcementList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return announcementList;
	}

	@Override
	public void save(Announcement announcement) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(announcement);
		session.flush();
	}

	@Override
	public void update(Announcement announcement) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(announcement);
		session.flush();
	}

	@Override
	public void delete(Announcement announcement) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.delete(announcement);
		session.flush();
	}
	
	@Override
	public Announcement findById(Integer announcementId) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Announcement announcementList = null;
		try {
			announcementList = (Announcement) session.get(Announcement.class, announcementId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return announcementList;
	}
}
