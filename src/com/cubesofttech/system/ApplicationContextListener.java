/*
 * ApplicationContextListener.java
 *
 * Created on October 10, 2006, 11:24 AM
 */
package com.cubesofttech.system;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

//import com.cubesofttech.mail.Mail;


/**
 *
 * @author  weerawatp
 * @version
 *
 * Web application lifecycle listener.
 */
public class ApplicationContextListener implements ServletContextListener {

    private static Logger log = Logger.getLogger(ApplicationContextListener.class);

    public void contextInitialized(ServletContextEvent evt) {
        try {

//            Mail.initialize();

        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }

    /**
     * ### Method from ServletContextListener ###
     *
     * Called when a Web application is about to be shut down
     * (i.e. on Web server shutdown or when a context is removed or reloaded).
     * Request handling will be stopped before this method is called.
     *
     * For example, the database connections can be closed here.
     */
    public void contextDestroyed(ServletContextEvent evt) {
        try {
            //IDGenerator.finalizeMap();
//            Mail.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
