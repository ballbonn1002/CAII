package com.cubesofttech.util;

import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ResourceConfigManager {

    private final static Logger log = LoggerFactory.getLogger(ResourceConfigManager.class);
    private Properties prop = null;

    public ResourceConfigManager(){
        this.prop = new Properties();
        try {
          this.prop.load(super.getClass().getResourceAsStream("/database.properties"));
        } catch (Exception ex) {
          System.out.println(ex.getMessage());
          ex.printStackTrace();
        }
    }
    
    public Properties getProp() {
        return prop;
    }

    public void setProp(Properties prop) {
        this.prop = prop;
    }
   
}
