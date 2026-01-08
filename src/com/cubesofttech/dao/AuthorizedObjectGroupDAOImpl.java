package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.AuthorizedObject;
import com.cubesofttech.model.AuthorizedObjectGroup;
import com.cubesofttech.model.Role;

@Repository
public class AuthorizedObjectGroupDAOImpl implements AuthorizedObjectGroupDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
    @Override
    public void save(AuthorizedObjectGroup authorizedObjectGroup) throws Exception{
        Session session = this.sessionFactory.getCurrentSession();
        session.save(authorizedObjectGroup);
        session.flush();
        //session.close();
    }
    
    @Override
    public AuthorizedObjectGroup findById(String id) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        AuthorizedObjectGroup authorizedObjectGroup = null;
        try {
            authorizedObjectGroup = (AuthorizedObjectGroup) session.get(AuthorizedObjectGroup.class, id);
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            //session.close();
        }        
        return authorizedObjectGroup;
    }
    
    @Override
    public void delete(AuthorizedObjectGroup authorizedObjectGroup) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(authorizedObjectGroup);
        session.flush();
        //session.close();
    }

	@Override
	public List<AuthorizedObjectGroup> findAll() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<AuthorizedObjectGroup> groupList = null;
		try {
			Criteria criteria = session.createCriteria(AuthorizedObjectGroup.class);
			criteria.addOrder(Order.asc("authorizedObjectGroupId"));
			groupList = criteria.list();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return groupList;
	}

	@Override
	public List<AuthorizedObjectGroup> getAuthorizedHierarchy() throws Exception {
		Session session = this.sessionFactory.getCurrentSession();
		List<AuthorizedObjectGroup> finalResult = new ArrayList<>();

		try {
			String sql = "(SELECT g.authorized_object_group_id, g.description AS group_description, "
					+ " o.authorized_object_id, o.name AS object_name, o.description AS object_description "
					+ " FROM authorized_object_group g "
					+ " LEFT JOIN authorized_object o ON g.authorized_object_group_id = o.authorized_object_group_id) "
					+ " UNION ALL "
					+ " (SELECT NULL AS authorized_object_group_id, 'รายการที่ไม่ได้จัดกลุ่ม' AS group_description, "
					+ " o.authorized_object_id, o.name AS object_name, o.description AS object_description "
					+ " FROM authorized_object o "
					+ " WHERE o.authorized_object_group_id NOT IN (SELECT authorized_object_group_id FROM authorized_object_group) "
					+ " OR o.authorized_object_group_id IS NULL) "
					+ " ORDER BY CASE WHEN authorized_object_group_id IS NULL THEN 1 ELSE 0 END, "
					+ " authorized_object_group_id, object_description ";

			SQLQuery query = session.createSQLQuery(sql);

			query.setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE);
			List<Map<String, Object>> rows = query.list();

			Map<Integer, AuthorizedObjectGroup> groupMap = new LinkedHashMap<>();

			for (Map<String, Object> row : rows) {
				Object gIdRaw = row.get("authorized_object_group_id");
				Integer gId = null;

				if (gIdRaw != null) {
					gId = ((Number) gIdRaw).intValue();
				}

				String gDesc = (String) row.get("group_description");

				Integer mapKey = (gId == null) ? -999 : gId;

				AuthorizedObjectGroup group = groupMap.get(mapKey);
				if (group == null) {
					group = new AuthorizedObjectGroup();
					group.setAuthorizedObjectGroupId(gId);
					group.setDescription(gDesc);
					groupMap.put(mapKey, group);
				}

				String objId = (String) row.get("authorized_object_id");
				if (objId != null) {
					AuthorizedObject obj = new AuthorizedObject();
					obj.setAuthorizedObjectId(objId);
					obj.setName((String) row.get("object_name"));
					obj.setDescription((String) row.get("object_description"));

					group.addObject(obj);
				}
			}

			finalResult = new ArrayList<>(groupMap.values());

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return finalResult;
	}

}
