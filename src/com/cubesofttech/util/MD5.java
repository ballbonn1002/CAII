package com.cubesofttech.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.log4j.Logger;


/**
 * MD5 utility used for generating the md5 text.
 */
public class MD5 {
    
	private static Logger log = Logger.getLogger(MD5.class);
	
    private MessageDigest md = null;
    static private MD5 md5 = null;
    private static final char[] hexChars ={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
    
    /**
     * Constructor is private so you must use the getInstance method
     */
    private MD5() throws NoSuchAlgorithmException {
        md = MessageDigest.getInstance("MD5");
    }
        
    /**
     * This returns the singleton instance of the MD5
     * @throws java.security.NoSuchAlgorithmException return if No MD5 algorithm
     * @return Instance of <CODE>MD5</CODE>
     */
    public static MD5 getInstance()throws NoSuchAlgorithmException {
        if (md5 == null) {
            md5 = new MD5();
        }
        return (md5);
    }
    
    /**
     * process the MD5 to the input data
     * @param dataToHash String to be hash
     * @return the HexString of the MD5 for dataToHash
     */
    public String hashData(byte[] dataToHash){
        return hexStringFromBytes((calculateHash(dataToHash)));
    }
    
    private byte[] calculateHash(byte[] dataToHash){
        md.update(dataToHash, 0, dataToHash.length);
        return (md.digest());
    }
    
    /**
     * Convert the MD5 byte string to MD5 HexString
     * @param b byte to be convert to HexString
     * @return HexString of the input ByteString
     */
    public String hexStringFromBytes(byte[] b){
        String hex = "";
        int msb;
        int lsb = 0;
        int i;
        // MSB maps to idx 0
        for (i = 0; i < b.length; i++){
            msb = ((int)b[i] & 0x000000FF) / 16;
            lsb = ((int)b[i] & 0x000000FF) % 16;
            hex = hex + hexChars[msb] + hexChars[lsb];
        }
        return(hex);
    }
    
    /**
     * Unit test for this Class
     * @param args runtime arguments
     */
    
    public static void main(String[] args) {
        try {
            MD5 md5 = MD5.getInstance();
            String s = "Bay%2005";
            String hash = md5.hashData(s.getBytes());
            log.debug("before hash string = " + s);
            log.debug("after hash string = " + hash);
            
            s = "XXX";
            String hash2 = md5.hashData(s.getBytes());
            log.debug("before hash string = " + s);
            log.debug("after hash string = " + hash2);
            
            s = "ABCDEFG";
            String hash3 = md5.hashData(s.getBytes());
            log.debug("before hash string = " + s);
            log.debug("after hash string = " + hash3);
            
            log.debug("h2 " + "" + "");
            
            String sx = (hash2.equals(hash3)) ? "equals" : "not equals";
            
        } catch (NoSuchAlgorithmException ex) {
            ex.printStackTrace();
        }
    }

}