/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cubesofttech.system;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Weerawat Poompattanapong
 */

public class Constant {
    public static List<String> onlineUserList = new ArrayList<>();
    private String test;
    private String googleApiKey;
    private String webPath;
    private static String webContext;
    private static String webContext2;
    private String imgContext;
    private String webEnv;

	public String getGoogleApiKey() {
		return googleApiKey;
	}

	public void setGoogleApiKey(String googleApiKey) {
		this.googleApiKey = googleApiKey;
	}

	public String getTest() {
		return test;
	}

	public void setTest(String test) {
		this.test = test;
	}

	public String getWebPath() {
		return webPath;
	}

	public void setWebPath(String webPath) {
		this.webPath = webPath;
	}

	public static String getWebContext() {
		return webContext;
	}

	public void setWebContext(String webContext) {
		Constant.webContext = webContext;
	}
	
	public static String getWebContext2() {
		return webContext2;
	}

	public static void setWebContext2(String webContext2) {
		Constant.webContext2 = webContext2;
	}

	public String getImgContext() {
		return imgContext;
	}

	public void setImgContext(String imgContext) {
		this.imgContext = imgContext;
	}

	public String getWebEnv() {
		return webEnv;
	}

	public void setWebEnv(String webEnv) {
		this.webEnv = webEnv;
	}

}
