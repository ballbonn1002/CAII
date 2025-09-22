package com.cubesofttech.dao;

import com.cubesofttech.model.SsoToken;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SsoTokenDAOImpl implements SsoTokenDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(SsoToken ssoToken) {
        Session session = sessionFactory.getCurrentSession();
        session.save(ssoToken);
        session.flush();
    }
    
    @Override
    public SsoToken findByTokenId(String tokenId) {
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = session.createCriteria(SsoToken.class);
        criteria.add(Restrictions.eq("tokenId", tokenId));
        return (SsoToken) criteria.uniqueResult();
    }

    @Override
    public void update(SsoToken ssoToken) {
        Session session = sessionFactory.getCurrentSession();
        session.update(ssoToken);
        session.flush();
    }

    @Override
    public void delete(String tokenId) {
        Session session = sessionFactory.getCurrentSession();
        SsoToken token = findByTokenId(tokenId);
        if (token != null) {
            session.delete(token);
            session.flush();
        }
    }

    @Override
    public List<SsoToken> findAll() {
        Session session = sessionFactory.getCurrentSession();
        return session.createCriteria(SsoToken.class).list();
    }
}
