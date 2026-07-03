package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.Footer;

@Repository
public class FooterDAOImpl implements FooterDAO {
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(Footer footer) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(footer);
		session.flush();

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> findAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> footerList = null;
		try {
			String sql = "SELECT * FROM footer";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			footerList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return footerList;
	}

	@Override
	public void update(Footer footer) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.clear();
		session.update(footer);
		session.flush();
		// session.close();
	}

	@Override
	public void delete(Footer footer) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		session.delete(footer);
		session.flush();
		// session.close();

	}

	@Override
	public Footer findById(long footer_id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		Footer footer = null;
		try {
			footer = (Footer) session.get(Footer.class, footer_id);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return footer;
	}

	@Override
	public List<Footer> findByParentId(Long parent_footer_id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Footer> footers = new ArrayList<>();

		try {

			String sql = "SELECT * FROM footer WHERE parent_footer_id = :parentId ORDER BY sequence ASC";

			SQLQuery query = session.createSQLQuery(sql);

			query.setParameter("parentId", parent_footer_id);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			footers = query.list();

		} catch (Exception e) {
			e.printStackTrace();
			throw e; 
		}

		return footers;
	}

	@Override
	public List<Map<String, Object>> findParentIdByFooterId(long footer_id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> parentFooter = null;
		try {
			String sql = "SELECT footer_id as repeat_footer_id ,footer_name, footer_url, footer_name_th ,status ,sequence "
					+ "FROM footer WHERE parent_footer_id = " + footer_id + " ORDER BY sequence ASC ";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			parentFooter = query.list();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return parentFooter;
	}

	@Override
	public boolean checkExistByName(String footer_name) {
		try {
			String sanitizedFooterName = footer_name.replace("'", "''");
			String hql = "FROM Footer WHERE footer_name = '" + sanitizedFooterName + "'";

			Footer footer = (Footer) sessionFactory.getCurrentSession().createQuery(hql).setMaxResults(1)
					.uniqueResult();

			return footer != null;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public Long getMaxId() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Footer> list = null;
		Long maxId;

		try {

			Criteria criteria = session.createCriteria(Footer.class).setProjection(Projections.max("footer_id"));
			maxId = (Long) criteria.uniqueResult();

			if (maxId == null) {
				maxId = 0L;
			} else {
				return maxId;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return new Long(0);

		} finally {

		}
		return maxId;
	}

	@Override
	public boolean hasChildFooters(String footerId) {
		String hql = "SELECT COUNT(f) FROM Footer f WHERE f.parent_footer_id = :footer_id";
		Long count = (Long) sessionFactory.getCurrentSession().createQuery(hql).setParameter("footer_id", footerId)
				.uniqueResult();

		return count != null && count > 0;
	}

	@Override
	public boolean deleteById(String footerId) {
		String hql = "DELETE FROM Footer f WHERE f.footer_id = :footer_id";
		int result = sessionFactory.getCurrentSession().createQuery(hql).setParameter("footer_id", footerId)
				.executeUpdate();

		return result > 0; // Return true if any rows were deleted
	}

	@Override
	public List<Map<String, Object>> countChildFooter() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> footerList = null;
		try {
			String sql = "SELECT ft.footer_id, ft.parent_footer_id, "
					+ "(SELECT COUNT(footer_id) FROM footer f WHERE f.parent_footer_id = ft.footer_id) AS countf FROM footer ft "
					+ "WHERE parent_footer_id = 0 AND status = 1;";
			SQLQuery query = session.createSQLQuery(sql);
			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			footerList = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return footerList;
	}

	@Override
	public Integer findSequenceUnderParent(String id) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Footer> list = null;
		Integer maxSequence;
		try {
			Criteria cr = session.createCriteria(Footer.class);
			cr.add(Restrictions.eq("parent_footer_id", id));
			cr.setProjection(Projections.max("sequence"));

			maxSequence = (Integer) cr.uniqueResult();
			if (maxSequence == null) {
				maxSequence = 0;
			} else {
				return maxSequence;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new Integer(0);
		} finally {

		}
		return maxSequence;

	}

	@Override
	public void updateSequence(List<Integer> sortedIDs) throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		try {
			String sql = "UPDATE `footer` SET sequence = :sequence WHERE footer_id = :footer_id";
			Query query = session.createSQLQuery(sql);
			for (int i = 0; i < sortedIDs.size(); i++) {
				query.setParameter("sequence", i + 1);
				query.setParameter("footer_id", sortedIDs.get(i));
				query.executeUpdate();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public List<Map<String, Object>> findAllParentFooter() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<Map<String, Object>> footers = new ArrayList<>();

		try {
			// ใช้คำสั่ง SQL ตามโครงสร้าง Table และ Column ในฐานข้อมูลจริงๆ
			String sql = "SELECT * FROM footer WHERE parent_footer_id = 0";

			// ใช้ createNativeQuery แทน createQuery และแนบ Footer.class ไปด้วยเพื่อให้
			// Hibernate Map ข้อมูลกลับมาเป็น Object ให้
			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);

			footers = query.list();

		} catch (Exception e) {
			// ในระบบจริง แนะนำให้ใช้ Logger แทน e.printStackTrace()
			e.printStackTrace();
			throw e; // ควรโยน Exception ออกไปให้ Controller หรือ Service จัดการต่อ
		}

		return footers;
	}
}
