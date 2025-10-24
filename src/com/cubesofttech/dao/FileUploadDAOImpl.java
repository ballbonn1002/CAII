package com.cubesofttech.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/*import com.cubesofttech.model.ExpenseGroup;*/
import com.cubesofttech.model.FileUpload;

@Repository
public class FileUploadDAOImpl implements FileUploadDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(FileUpload FileUpload) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(FileUpload);
		session.flush();
		// session.close();
	}

//	@Override
//	public List<FileUpload> findAll() throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<FileUpload> fileList = null;
//		try {
//			fileList = session.createCriteria(FileUpload.class).list();
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			// session.close();
//		}
//		return fileList;
//	}
//
//	@Override
//	public List<FileUpload> findByuser(String user) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<FileUpload> holidayList = null;
//		try {
//
//			String sql = "SELECT  * FROM file where user_create='" + user + "'  ";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.addEntity(FileUpload.class);
//
//			holidayList = query.list();
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			// session.close();
//		}
//		return holidayList;
//	}

	@Override
	public Integer getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Integer maxId = 0;
		try {

			Criteria criteria = session.createCriteria(FileUpload.class).setProjection(Projections.max("fileId"));
			maxId = (Integer) criteria.uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
			maxId = new Integer(0);

		} finally {

		}
		if (maxId != null) {
			return maxId;
		} else {
			return new Integer(0);
		}
	}

//	@Override
//	public void deleteByPath(String path) throws Exception {
//
//		// Select id from path
//		FileUpload fileUpload = (FileUpload) sessionFactory.getCurrentSession()
//				.createQuery("from FileUpload where path = :path").setString("path", path).uniqueResult();
//
//		// System.out.println("DELETE [File] ID: " + fileUpload.getFileId());
//		delete(fileUpload);
//
//	}
//
//	@Override
//	public FileUpload findById(String id) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		FileUpload FileUpload = null;
//		try {
//			FileUpload = (FileUpload) session.get(FileUpload.class, id);
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			// session.close();
//		}
//		return FileUpload;
//	}

	@Override
	public FileUpload findById(int id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		FileUpload FileUpload = null;
		try {
			FileUpload = (FileUpload) session.get(FileUpload.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return FileUpload;
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
		} catch (Exception e){ 
			e.printStackTrace();
		} 
		return fileList;
	}

//	@Override
//	public void update(FileUpload FileUpload) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		session.clear();
//		session.update(FileUpload);
//		session.flush();
//		// session.close();
//	}

	@Override
	public void delete(FileUpload FileUpload) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(FileUpload);
		session.flush();
		// session.close();
	}

//	@Override
//	public List<FileUpload> findByTicketId(String ticket_id) throws Exception {
//	    Session session = this.sessionFactory.getCurrentSession();
//	    List<FileUpload> fileList = null;
//	    try {
//	        String sql = "SELECT * FROM file WHERE page_id = :ticket_id";
//	        SQLQuery query = session.createSQLQuery(sql);
//	        query.addEntity(FileUpload.class);
//	        query.setParameter("ticket_id", ticket_id);  
//	        fileList = query.list();
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	    }
//	    return fileList;
//	}
//	
//	public void delete(String fileId) throws Exception{
//		 Session session = this.sessionFactory.getCurrentSession();
//		    FileUpload fileUpload = (FileUpload) session.get(FileUpload.class, fileId);
//		    
//		    if (fileUpload != null) {
//		        session.delete(fileUpload);
//		    } else {
//		        throw new Exception("No file!");
//		    }
//	}
//
//
//	public List<FileUpload> findByPageAndPageId(String page, String pageId) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<FileUpload> fileList = null;
//		try {
//			String sql = "SELECT * FROM file WHERE page = :page AND page_id = :pageId";
//			SQLQuery query = session.createSQLQuery(sql);
//			query.addEntity(FileUpload.class);
//			query.setParameter("page", page);
//			query.setParameter("pageId", pageId);
//
//			fileList = query.list();
//		} catch (Exception e){ 
//			e.printStackTrace();
//		} 
//		return fileList;
//	}
//	
//	public void deletepageandpageid(String page, String PageId) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		/* List<FileUpload> fileList = null; */
//		try {
//			String sql = "DELETE FROM file WHERE page = :page AND page_id = :page_id";
//	        SQLQuery query = session.createSQLQuery(sql);
//	        query.setParameter("page", page);
//	        query.setParameter("page_id", PageId);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			/* fileList = query.list(); */
//			Log.debug(query);
//			Log.debug("ssss : ");
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//	
//	@Override
//	public List<FileUpload> findBypageandpageid(String page, String PageId) throws Exception {
//		Session session = this.sessionFactory.getCurrentSession();
//		List<FileUpload> fileList = null; 
//		try {
//			String sql = "SELECT * FROM file WHERE page = :page AND page_id = :page_id";
//	        SQLQuery query = session.createSQLQuery(sql);
//	        query.setParameter("page", page);
//	        query.setParameter("page_id", PageId);
//			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
//			fileList = query.list(); 
//			Log.debug(query);
//			Log.debug("ssss : ");
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return fileList;
//	}

}
