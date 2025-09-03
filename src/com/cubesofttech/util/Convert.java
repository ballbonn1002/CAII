/*
 * Convert.java //Generate from the WEBDAO project
 *
 * Created on November 12, 2006, 9:30 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.cubesofttech.util;

import java.sql.Array;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;

/**
 *
 * @author user
 */
public class Convert {
    
    /** Creates a new instance of Convert */
    public Convert() {
    }
    
    public static Array parseArray( String s) {
        return null;
    }
    public static boolean parseBoolean( String s) {
        return Boolean.getBoolean(s);
    }
    public static byte parseByte( String s) {
        return Byte.parseByte(s);
    }
    public static byte[] parseBytes( String s) {
        return s.getBytes();
    }
    public static double parseDouble( String s) {
        return Double.parseDouble(s);
    }
    public static float parseFloat( String s) {
        return Float.parseFloat(s);
    }
    public static int parseInt( String s) {
        return Integer.parseInt(s);
    }
    public static java.lang.Object parseObject( String s) {
        return s;
    }
    public static java.math.BigDecimal parseBigDecimal( String s) {
    	
		try {	
	        DecimalFormat format = new DecimalFormat("#,###.##");
	        ParsePosition parsePosition = new ParsePosition(0);
	        Object object = format.parse(s, parsePosition);
	        return new java.math.BigDecimal(object.toString());
		} catch (Exception e){
			throw new NumberFormatException();
		}
    }
    public static java.sql.Blob parseBlob( String s) {
        
        return null;
    }
    public static java.sql.Clob parseClob( String s) {
        return null;
    }
    public static java.sql.Date parseDate_( String s) throws ParseException{
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        try {
            String year = s.substring(0, 4);
            if (Convert.parseInt(year) > 2400) {
                int yearInt = Convert.parseInt(year) - 543;
                s = yearInt + s.substring(4, s.length());
            }
        } catch (Exception e) {}
        return new Date(formatter.parse(s).getTime());
    }
    public static java.sql.Date parseDate( String s) throws ParseException {
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        return new Date(formatter.parse(s).getTime());
    }
    public static java.sql.Time parseTime( String s) throws ParseException {
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
        return new Time(formatter.parse(s).getTime());
    }
    public static java.sql.Timestamp parseTimestamp( String s) throws ParseException {
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
        return new Timestamp(formatter.parse(s).getTime());
    }
    public static long parseLong( String s) {
        return Long.parseLong(s);
    }
    public static java.sql.Ref parseRef( String s) {
        return null;
    }
    public static short parseShort( String s) {
        return Short.parseShort(s);
    }
    public static String parseString(String s) {
    	if(s == null){
    		s = "";
    	}
        return s;
    }
    
}
