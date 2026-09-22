package com.cubesofttech.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.UnitOfMeasure;

@Repository
public class UnitOfMeasureDAOImpl implements UnitOfMeasureDAO {

    /** sequence ของ unit หลัก */
    private static final String MAIN_UNIT_SEQUENCE = "0";

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(UnitOfMeasure unitOfMeasure) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(unitOfMeasure);
        // OpenSessionInViewFilter ตั้ง flush mode = MANUAL ต้อง flush เองไม่งั้นไม่ลง DB
        session.flush();
    }

    @Override
    public void update(UnitOfMeasure unitOfMeasure) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(unitOfMeasure);
        session.flush();
    }

    @Override
    public void delete(UnitOfMeasure unitOfMeasure) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.delete(unitOfMeasure);
        session.flush();
    }

    @Override
    public UnitOfMeasure findById(Integer unitId) throws Exception {
        if (unitId == null) {
            return null;
        }
        Session session = this.sessionFactory.getCurrentSession();
        return (UnitOfMeasure) session.get(UnitOfMeasure.class, unitId);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<UnitOfMeasure> findByProductId(String productId) throws Exception {
        if (productId == null || productId.trim().isEmpty()) {
            return new ArrayList<UnitOfMeasure>();
        }
        Session session = this.sessionFactory.getCurrentSession();
        // sequence เป็น varchar ถ้า order ตรงๆ จะเรียงแบบ string ('10' มาก่อน '2') จึง cast เป็นตัวเลขก่อน
        Query query = session.createQuery(
                "from UnitOfMeasure where productId = :productId order by cast(sequence as integer) asc");
        query.setParameter("productId", productId.trim());

        List<UnitOfMeasure> units = query.list();
        return units != null ? units : new ArrayList<UnitOfMeasure>();
    }

    @Override
    public UnitOfMeasure findMainUnitByProductId(String productId) throws Exception {
        if (productId == null || productId.trim().isEmpty()) {
            return null;
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery(
                "from UnitOfMeasure where productId = :productId and sequence = :sequence order by unitId asc");
        query.setParameter("productId", productId.trim());
        query.setParameter("sequence", MAIN_UNIT_SEQUENCE);
        // กันกรณีข้อมูลซ้ำ (sequence = '0' มากกว่า 1 แถว) ไม่ให้ระเบิดเป็น NonUniqueResultException
        query.setMaxResults(1);

        return (UnitOfMeasure) query.uniqueResult();
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<UnitOfMeasure> findMainUnitsByProductIds(List<String> productIds) throws Exception {
        if (productIds == null || productIds.isEmpty()) {
            return new ArrayList<UnitOfMeasure>();
        }
        // กัน null/ค่าว่างใน list ที่จะทำให้ IN (...) พังหรือได้ผลลัพธ์เพี้ยน
        List<String> ids = new ArrayList<String>();
        for (String productId : productIds) {
            if (productId != null && !productId.trim().isEmpty()) {
                ids.add(productId.trim());
            }
        }
        if (ids.isEmpty()) {
            return new ArrayList<UnitOfMeasure>();
        }

        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery(
                "from UnitOfMeasure where productId in (:productIds) and sequence = :sequence order by unitId asc");
        query.setParameterList("productIds", ids);
        query.setParameter("sequence", MAIN_UNIT_SEQUENCE);

        List<UnitOfMeasure> units = query.list();
        return units != null ? units : new ArrayList<UnitOfMeasure>();
    }

    @Override
    public int deleteByProductId(String productId) throws Exception {
        if (productId == null || productId.trim().isEmpty()) {
            return 0;
        }
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("delete from UnitOfMeasure where productId = :productId");
        query.setParameter("productId", productId.trim());

        return query.executeUpdate();
    }
}
