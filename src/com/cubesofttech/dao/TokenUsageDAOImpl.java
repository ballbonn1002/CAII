package com.cubesofttech.dao;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.From;

import org.hibernate.SQLQuery;
import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cubesofttech.model.TokenUsage;

@Repository
public class TokenUsageDAOImpl implements TokenUsageDAO {

	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void save(TokenUsage usageToken) throws Exception {
		sessionFactory.getCurrentSession().save(usageToken);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void update(TokenUsage usageToken) throws Exception {
		sessionFactory.getCurrentSession().update(usageToken);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public void delete(TokenUsage usageToken) throws Exception {
		sessionFactory.getCurrentSession().delete(usageToken);
		sessionFactory.getCurrentSession().flush();
	}

	@Override
	public TokenUsage findById(Integer usageTokenId) throws Exception {
		return sessionFactory.getCurrentSession().get(TokenUsage.class, usageTokenId);
	}
	
	@Override
	public List<String> findAllUserIds() throws Exception {
	    return sessionFactory.getCurrentSession()
	            .createQuery("SELECT DISTINCT userId FROM TokenUsage WHERE userId IS NOT NULL")
	            .list();
	}


	@Override
	public boolean existsMonthlyGift(String userId,
	                                 Integer actionTypeId,
	                                 int month,
	                                 int year) throws Exception {

	    LocalDate start = LocalDate.of(year, month, 1);
	    LocalDate end = start.plusMonths(1);

	    String hql =
	        "SELECT COUNT(*) " +
	        "FROM TokenUsage " +
	        "WHERE userId = :userId " +
	        "AND actionTypeId = :actionTypeId " +
	        "AND timeCreate >= :startDate " +
	        "AND timeCreate < :endDate";

	    Long count = (Long) sessionFactory
	            .getCurrentSession()
	            .createQuery(hql)
	            .setParameter("userId", userId)
	            .setParameter("actionTypeId", actionTypeId)
	            .setParameter("startDate", java.sql.Timestamp.valueOf(start.atStartOfDay()))
	            .setParameter("endDate", java.sql.Timestamp.valueOf(end.atStartOfDay()))
	            .uniqueResult();

	    return count != null && count > 0;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> findTokenLedgerByUserId(String userId, int year) throws Exception {

	    String sql =
	            "SELECT " +
	            "    tu.token_usage_id, " +
	            "    tu.user_id, " +
	            "    tu.value, " +
	            "    tu.reconcile, " +
	            "    tu.re_flag AS returned, " +
	            "    tu.time_create, " +
	            "    tu.action_type_id, " +
	            "    tat.action_type_name, " +
	            "    CASE " +
	            "        WHEN tap.action_point_id IS NOT NULL THEN tap.action_point_type " +
	            "        ELSE tat.action_type_name " +
	            "    END AS action_name, " +
	            
	            "    CASE " +
	            "        WHEN tat.action_type_id = 2 OR tat.action_type_id = 8" +
	            "        THEN 'DEDUCT' " +
	            "        ELSE 'ADD' " +
	            "    END AS transaction_type, " +
	            
	            " 	 tu.description " +

	            "FROM token_usage tu " +

	            "LEFT JOIN token_action_type tat " +
	            "    ON tu.action_type_id = tat.action_type_id " +
	            
				"LEFT JOIN token_action_point tap " +
				"    ON tu.action_point_id = tap.action_point_id " +

	            "WHERE tu.user_id = :userId " +
	            "AND (tu.action_type_id IN (1, 2, 3, 4, 7, 8) OR (tu.action_type_id = 6 AND tu.value IS NOT NULL)) " +
	            "AND YEAR(tu.time_create) = :year " +

	            "ORDER BY tu.time_create ASC";

	    return sessionFactory
	            .getCurrentSession()
	            .createSQLQuery(sql)
	            .setParameter("userId", userId)
	            .setParameter("year", year)
	            .setResultTransformer(
	                    AliasToEntityMapResultTransformer.INSTANCE)
	            .list();
	}
	


	@Override
	@SuppressWarnings("unchecked")
	public Map<String, Object> findTokenSummaryByUserId(
	        String userId,
	        int year) throws Exception {

	    String sql =
	            "SELECT " +
	    
	            // Accumulated token balance
				"COALESCE(SUM(" +
				"    CASE " +
				"        WHEN tu.action_type_id = 5 " +
				"            THEN GREATEST(COALESCE(tu.reconcile, 0), 0) " +
				"        WHEN tu.action_type_id = 6 AND tu.reconcile IS NOT NULL " +
				"            THEN -COALESCE(tu.reconcile, 0) " +
				"        ELSE 0 " +
				"    END" +
				"), 0) AS token, "+	

	            // Gift
	            "    COALESCE(SUM( " +
	            "        CASE WHEN tu.action_type_id = 1 " +
	            "        THEN tu.value ELSE 0 END " +
	            "    ), 0) AS gift, " +

	            // Reward
	            "    COALESCE(SUM( " +
	            "        CASE WHEN tu.action_type_id = 4 THEN tu.value " +
	            "   		  WHEN tu.action_type_id = 8 THEN -tu.value " +
	            "        ELSE 0 END " +
	            "    ), 0) AS reward, " +

	            // Return
	            "    COALESCE(SUM( " +
	            "        CASE WHEN tu.action_type_id = 3 THEN tu.value " +
	            "		 ELSE 0 END" +	
	            "    ), 0) AS return_token, " +

	            // Exchange
	            "    COALESCE(SUM( " +
	            "        CASE WHEN tu.action_type_id = 6 AND tu.value IS NOT NULL " +
	            "        THEN tu.value ELSE 0 END " +
	            "    ), 0) AS exchange, " +

	            // Late
	            "    COALESCE(SUM( " +
	            "        CASE WHEN tu.action_point_id = 4 " +
	            "        THEN tu.value ELSE 0 END " +
	            "    ), 0) AS late, " +

	            // Early Out
	            "    COALESCE(SUM( " +
	            "        CASE WHEN tu.action_point_id = 5 " +
	            "        THEN tu.value ELSE 0 END " +
	            "    ), 0) AS early_out, " +

	            // Leave
	            "    COALESCE(SUM( " +
	            "        CASE WHEN tu.action_point_id = 6 " +
	            "        THEN tu.value ELSE 0 END " +
	            "    ), 0) AS leave_token, " +

	            // Backdate
	            "    COALESCE(SUM( " +
	            "        CASE WHEN tu.action_point_id = 7 " +
	            "        THEN tu.value ELSE 0 END " +
	            "    ), 0) AS back_date, " +
	            
				// No Record
				"    COALESCE(SUM( " +
				"        CASE WHEN tu.action_point_id = 8 " +
				"        THEN tu.value ELSE 0 END " +
				"    ), 0) AS no_record " +

	            "FROM token_usage tu " +

	            "WHERE tu.user_id = :userId " +
	            "AND YEAR(tu.time_create) = :year";

	    return (Map<String, Object>) sessionFactory
	            .getCurrentSession()
	            .createSQLQuery(sql)
	            .setParameter("userId", userId)
	            .setParameter("year", year)
	            .setResultTransformer(
	                    AliasToEntityMapResultTransformer.INSTANCE)
	            .uniqueResult();
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> findTokenSummaryForAllUsers(int year) throws Exception {

	    String sql =
	            "SELECT " +
	            "    u.id AS user_id, " +
	            "    u.name AS name_th, " +
	            "    u.name_en, " +
	            "    u.employee_id, " +
	            "	 u.employee_type_id,  " +
	            "	 u.employee_status,  " +
	            "	 u.enable, " + 
	            "	 u.path AS file_path, " +

				// Accumulated token balance
				"COALESCE(SUM(" +
				"    CASE " +
				"        WHEN tu.action_type_id = 5 " + // Add in reconcile
				"            THEN GREATEST(COALESCE(tu.reconcile, 0), 0) " + // Exclude negative reconcile values
				"        WHEN tu.action_type_id = 6 AND tu.reconcile IS NOT NULL" + // Exchange
				"            THEN -COALESCE(tu.reconcile, 0) " +
				"        ELSE 0 " +
				"    END" +
				"), 0) AS reconcile, "+	

	            // Get Token = Gift + Return + Reward + Exchange
	            "    COALESCE(SUM( " +
	            "        CASE " +
	            "            WHEN tu.action_type_id IN (1, 3, 4) " + // Gift, Return, Reward
	            "            THEN tu.value " +
	            " 			 WHEN tu.action_type_id = 6 AND tu.value IS NOT NULL " + // Exchange
	            "            THEN tu.value " +
	            "            WHEN tu.action_type_id = 8 " + // Void
	            "            THEN -tu.value " +
	            "            ELSE 0 " +
	            "        END " +
	            "    ), 0) AS get_token, " +

	            // Deduct Token
	            "    COALESCE(SUM( " +
	            "        CASE " +
	            "            WHEN tu.action_type_id = 2 " +
	            "            THEN tu.value " +
	            "            ELSE 0 " +
	            "        END " +
	            "    ), 0) AS deduct_token " +

	            "FROM user u " +

	            "LEFT JOIN token_usage tu " +
	            "    ON u.id = tu.user_id " +
	            "    AND YEAR(tu.time_create) = :year " +
	            
				"GROUP BY " +
				"    u.id, " +
				"    u.name, " +
				"    u.name_en, " +
				"    u.employee_id, " +
				"    u.employee_type_id, " +
				"    u.employee_status, " +
				"    u.enable, " +
				"    u.path " +
				
				"ORDER BY " +
				"    u.employee_id ASC, " +
				"    u.name_en ASC, " +
				"    u.name ASC, " +
				"	 u.enable DESC "
				;

	    return sessionFactory
	            .getCurrentSession()
	            .createSQLQuery(sql)
	            .setParameter("year", year)
	            .setResultTransformer(
	                AliasToEntityMapResultTransformer.INSTANCE
	            )
	            .list();
	}
	
	public Double findMonthlyBalance(String userId, YearMonth previousMonth) throws Exception {

	    LocalDateTime startDate = previousMonth
	            .atDay(1)
	            .atStartOfDay();

	    LocalDateTime endDate = previousMonth
	            .plusMonths(1)
	            .atDay(1)
	            .atStartOfDay();

	    String sql =
	            "SELECT COALESCE(SUM( " +
	            "    CASE " +
	            "        WHEN tu.action_type_id IN (1, 3, 4) THEN tu.value " + // Gift, Return, Reward
	            "        WHEN tu.action_type_id = 6 AND tu.value IS NOT NULL THEN tu.value " + // Exchange
	            "        WHEN tu.action_type_id = 2 OR tu.action_type_id = 8 THEN -tu.value " + // Deduct, Void
	            "        ELSE 0 " +
	            "    END " +
	            "), 0) AS balance " +
	            "FROM token_usage tu " +
	            "WHERE tu.user_id = :userId " +
	            "AND tu.time_create >= :startDate " +
	            "AND tu.time_create < :endDate";

	    Object result = sessionFactory
	            .getCurrentSession()
	            .createSQLQuery(sql)
	            .setParameter("userId", userId)
	            .setParameter("startDate", Timestamp.valueOf(startDate))
	            .setParameter("endDate", Timestamp.valueOf(endDate))
	            .uniqueResult();

	    return result != null
	            ? ((Number) result).doubleValue()
	            : 0D;
	}

	@Override
	public Double getAccumulatedTokenBalance(String userId) throws Exception {

	    String sql =
	            "SELECT " +
	            "    COALESCE(SUM( " +
	            "        CASE " +
	            "            WHEN tu.action_type_id = 5 " + // Add in reconcile
	            "                THEN GREATEST(COALESCE(tu.reconcile, 0), 0) " + // Exclude negative reconcile values
	            "            WHEN tu.action_type_id = 6 AND tu.reconcile IS NOT NULL " +
	            "                THEN -COALESCE(tu.reconcile, 0) " + // Exchange 
	            "            ELSE 0 " +
	            "        END " +
	            "    ), 0) AS token " +
	            "FROM token_usage tu " +
	            "WHERE tu.user_id = :userId " +
	            "AND YEAR(tu.time_create) = :year";

	    SQLQuery query = sessionFactory
	            .getCurrentSession()
	            .createSQLQuery(sql);

	    query.setParameter("userId", userId);
	    query.setParameter("year", LocalDate.now().getYear());

	    Object result = query.uniqueResult();

	    if (result == null) {
	        return 0D;
	    }

	    return ((Number) result).doubleValue();
	}

	@Override
	public Double findYearlyBalance(String userId, Integer year) throws Exception {

	    String sql =
	            "SELECT " +
	            "    COALESCE(SUM( " +
	            "        CASE " +
	            "            WHEN tu.action_type_id = 5 " +
	            "                THEN GREATEST(COALESCE(tu.reconcile, 0), 0) " +
	            "            WHEN tu.action_type_id = 6 AND tu.reconcile IS NOT NULL " +
	            "                THEN -COALESCE(tu.reconcile, 0) " +
	            "            ELSE 0 " +
	            "        END " +
	            "    ), 0) AS yearly_token " +
	            "FROM token_usage tu " +
	            "WHERE tu.user_id = :userId " +
	            "AND YEAR(tu.time_create) = :year";

	    SQLQuery query = sessionFactory
	            .getCurrentSession()
	            .createSQLQuery(sql);

	    query.setParameter("userId", userId);
	    query.setParameter("year", year);

	    Object result = query.uniqueResult();

	    if (result == null) {
	        return 0D;
	    }

	    return ((Number) result).doubleValue();
	}

	@Override
	public boolean existsAccumulatedToken(String userId, YearMonth yearMonth) throws Exception {

	    if (userId == null || userId.trim().isEmpty()) {
	        throw new IllegalArgumentException("User ID is required.");
	    }

	    if (yearMonth == null) {
	        throw new IllegalArgumentException("Year month is required.");
	    }

	    String sql =
	            "SELECT EXISTS ( " +
	            "    SELECT 1 " +
	            "    FROM token_usage tu " +
	            "    WHERE tu.user_id = :userId " +
	            "      AND tu.action_type_id = 5 " +
	            "      AND YEAR(tu.time_create) = :year " +
	            "      AND MONTH(tu.time_create) = :month " +
	            ")";
	    
	    SQLQuery query = sessionFactory
	            .getCurrentSession()
	            .createSQLQuery(sql);
	    
	    query.setParameter("userId", userId);
	    query.setParameter("year", yearMonth.getYear());
	    query.setParameter("month", yearMonth.getMonthValue());

	    Number result = (Number) query.uniqueResult();
	    
	    return result != null && result.intValue() == 1;
	}
}
