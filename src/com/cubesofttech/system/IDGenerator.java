/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cubesofttech.system;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

/**
 *
 * @author Administrator
 */
public class IDGenerator {

    private static Logger log = Logger.getLogger(IDGenerator.class);
    public static final String PM = "pm";
    public static final String JOB = "job";
    public static final int UPDATE = 1;
    public static Map IDMap = new HashMap();
/*
    public static long getRunningID(String tableName) throws SQLException, ClassNotFoundException, NamingException {
        IdRunning idRunning = (IdRunning) IDMap.get(tableName);
        long running = 1;
        if (idRunning == null) {
            idRunning = new IdRunning();
            idRunning.setId(tableName);
            idRunning.setName(tableName);
            idRunning.setPkId(tableName + "_id");
            idRunning.setRunningNo(running);
            idRunning.setTimeCreate(DateUtil.getCurrentTime());
            idRunning.setTimeUpdate(DateUtil.getCurrentTime());
            IDMap.put(idRunning.getId(), idRunning);
            insertRunningTable(idRunning);
        } else {
            running = idRunning.getRunningNo() + 1;
            idRunning.setRunningNo(running);
            if (running % UPDATE == 0) {
                updateRunningTable(idRunning);
            }
        }
        return running;
    }

    public static void initMap() throws SQLException, ClassNotFoundException, NamingException {
        Connection conn = DB.getConnection();
        try {
            IdRunningDAO idRunningDAO = new IdRunningDAO();
            List idRunningList = idRunningDAO.findAll(conn);
            Iterator it = idRunningList.iterator();
            while (it.hasNext()) {
                IdRunning idRunning = (IdRunning) it.next();
                updateRunningNumber(idRunning);
            }
            idRunningList = idRunningDAO.findAll(conn);
            it = idRunningList.iterator();
            while (it.hasNext()) {
                IdRunning idRunning = (IdRunning) it.next();
                IDMap.put(idRunning.getId(), idRunning);
            }
            
        } catch (SQLException e) {
            log.error(e.getMessage());
        } finally {
            DB.closeConnection(conn);
        }
        log.info("Initialize Running Number MAP is success; size = " + IDMap.size());
        log.info(IDMap);
    }

    private static void updateRunningNumber(IdRunning idRunning) throws ClassNotFoundException, NamingException, SQLException {
        Connection conn = null;
        try {
        	conn = DB.getConnection();
            IdRunningDAO idRunningDAO = new IdRunningDAO();
            idRunningDAO.updateRunningNo(idRunning, conn);

        } catch (SQLException e) {
            log.error(e.getMessage());
        } finally {
            DB.closeConnection(conn);
        }
	}

	public static void finalizeMap() throws SQLException, ClassNotFoundException, NamingException {
        Connection conn = DB.getConnection();
        try {
            IdRunningDAO idRunningDAO = new IdRunningDAO();
            List idRunningList = idRunningDAO.findAll(conn);
            Iterator it = idRunningList.iterator();
            while (it.hasNext()) {
                IdRunning idRunning = (IdRunning) it.next();
                IdRunning mapRunning = (IdRunning) IDMap.remove(idRunning.getId());
                mapRunning.setTimeUpdate(DateUtil.getCurrentTime());
                idRunningDAO.update(mapRunning, conn);
            }
        } catch (SQLException e) {
            log.error(e.getMessage());
        } finally {
            DB.closeConnection(conn);
        }
        log.info("Finalize Running Number MAP is success; size = " + IDMap.size());
        log.info(IDMap);
    }

    private static void updateRunningTable(IdRunning idRunning) throws SQLException, ClassNotFoundException, NamingException {
        Connection conn = DB.getConnection();
        try {
            IdRunningDAO idRunningDAO = new IdRunningDAO();
            idRunningDAO.update(idRunning, conn);
        } catch (SQLException ex) {
            log.error(ex.getMessage());
        } catch (Exception ex) {
            log.error(ex.getMessage());
        } finally {
            DB.closeConnection(conn);
        }
    }

    private static void insertRunningTable(IdRunning idRunning) throws SQLException, ClassNotFoundException, NamingException {
        Connection conn = DB.getConnection();
        try {
            IdRunningDAO idRunningDAO = new IdRunningDAO();
            idRunningDAO.insert(idRunning, conn);
        } catch (SQLException ex) {
            log.error(ex.getMessage());
        } catch (Exception ex) {
            log.error(ex.getMessage());
        } finally {
            DB.closeConnection(conn);
        }
    }
*/

}
