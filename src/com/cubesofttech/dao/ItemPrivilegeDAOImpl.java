package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.ItemPrivilege;

@Repository
public class ItemPrivilegeDAOImpl implements ItemPrivilegeDAO {
	

	@Autowired
	SessionFactory sessionFactory;
	
	@Override
	public void save(ItemPrivilege itemPrivilege) throws Exception {
		sessionFactory.getCurrentSession().save(itemPrivilege);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void update(ItemPrivilege itemPrivilege) throws Exception {
		sessionFactory.getCurrentSession().update(itemPrivilege);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void delete(ItemPrivilege itemPrivilege) throws Exception {
		sessionFactory.getCurrentSession().delete(itemPrivilege);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public ItemPrivilege findById(Integer itemId) throws Exception {
		return sessionFactory.getCurrentSession().get(ItemPrivilege.class, itemId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ItemPrivilege> findAll() throws Exception {
		return sessionFactory.getCurrentSession().createQuery("from ItemPrivilege").list();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> findAllWithUserFavorite(String userId) throws Exception {

		String sql =
		        "SELECT " +
		        "    ip.item_id AS itemId, " +
		        "    ip.item_name AS itemName, " +
		        "    ip.details AS details, " +
		        "    ip.token AS token, " +
		        "    ip.added_money AS addedMoney, " +
		        "    ip.quantity AS quantity, " +
		        "    ip.cover_path AS coverPath, " +
		        "    ip.img_path AS imgPath, " +
		        "    CASE " +
		        "        WHEN uf.user_favorite_id IS NOT NULL THEN true " +
		        "        ELSE false " +
		        "    END AS isFavorite " +
		        "FROM item_privilege ip " +
		        "LEFT JOIN user_favorite uf " +
		        "    ON ip.item_id = uf.item_id " +
		        "    AND uf.user_id = :userId " +
		        "WHERE ip.active_flag = 'Y' " +
		        "ORDER BY " +
		        "    CASE WHEN uf.user_favorite_id IS NOT NULL THEN 0 ELSE 1 END, " +
		        "    ip.item_id ASC";

	    return sessionFactory.getCurrentSession()
	            .createSQLQuery(sql)
	            .setParameter("userId", userId)
	            .setResultTransformer(AliasToEntityMapResultTransformer.INSTANCE)
	            .list();
	}

}
