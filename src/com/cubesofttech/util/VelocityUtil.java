package com.cubesofttech.util;


import java.io.StringWriter;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;


public class VelocityUtil {

	private static Logger log = Logger.getLogger(VelocityUtil.class);
	
	public static String getTextFromFile(String userid, String roleid, String message, String templatefilename) throws Exception{
		
		  /*  first, get and initialize an engine  */
        VelocityEngine ve = new VelocityEngine();
        ve.init();
        /*  next, get the Template  */
        Template t = ve.getTemplate(templatefilename);
        
        /*  create a context and add data */
        VelocityContext context = new VelocityContext();
        context.put("userid", userid);
        context.put("roleid", roleid);
        context.put("map", message);
        
        /* now render the template into a StringWriter */
        StringWriter writer = new StringWriter();
        t.merge( context, writer );
        /* show the World */
        log.debug( writer.toString() );
		return writer.toString(); 
		
	}
	
	
	public static String getTextFromStr(String userid, String roleid, Map message, String templateStr) throws Exception{
		
		  VelocityEngine ve = new VelocityEngine();
          ve.init();
        
		  VelocityContext context = new VelocityContext();
		    
		    context.put("userid", userid);
	        context.put("roleid", roleid);
	        context.put("map", message);

	        StringWriter swOut = new StringWriter();
	        /**
	         * Merge data and template
	         */
	        ve.evaluate( context, swOut, "log tag name", templateStr);
	        log.debug(swOut);
	        
			return swOut.toString();
		
	}
	
}
