/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cubesofttech.util;

import org.apache.log4j.Logger;




/**
 *
 * @author Administrator
 */
public class UUID {
	
	private static Logger log = Logger.getLogger(UUID.class);
	
    public static String getUUID() {
       java.util.UUID uuid = java.util.UUID.randomUUID();
       String uuidString = uuid.toString().replaceAll("-", "");
       return uuidString.toUpperCase();
    }

    public static void main(String args []){
        for (int i = 0; i<100; i++) {
            log.debug("UUID = " + getUUID());
        }
    }
}
