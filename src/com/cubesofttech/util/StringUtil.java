/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cubesofttech.util;

import java.util.Iterator;
import java.util.List;

/**
 *
 * @author Administrator
 */
public class StringUtil {

	public static String generateIdNumeric(List idList) {

		StringBuffer sf = new StringBuffer();
		Iterator it = idList.iterator();
		while (it.hasNext()) {
			sf.append("," + it.next());
		}
		if (sf.length() > 0) {
			sf.deleteCharAt(0);
		}
		return sf.toString();
	}

	public static String generateIdString(List idList) {

		StringBuffer sf = new StringBuffer();
		Iterator it = idList.iterator();
		while (it.hasNext()) {
			sf.append(",'" + it.next() + "' ");
		}
		if (sf.length() > 0) {
			sf.deleteCharAt(0);
		}
		return sf.toString();
	}

	public static String replaceAllBRwithReturn(String text) {
		return text.replaceAll("(<br>|<br/>)", "\n");
	}

	public static String replaceAllReturnWithBR(String text) {
		return text.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
	}

	public static String[] trimAll(String kwSkill) {
		String[] skills = null;
		if (kwSkill != null && !kwSkill.equals("")) {
			skills = kwSkill.split(",");
			for (int i = 0, size = skills.length; i < size; i++) {
				skills[i] = skills[i].trim();
			}
		}
		return skills;
	}

	public static String removeSpaceLeftRight(String before_str, String remove_str) {
		String after_str = before_str.trim();
		return after_str;
	}

	public static String removeSpaceLeftRight2(String before_str, String remove_str) {
		String tempstr1 = "";

		int left_index = 0;
		int right_index = 0;

		// scan left
		boolean op = true;
		int i = -1;
		while (i < before_str.length() && op == true) {
			i++;
			String tmp1 = before_str.substring(i, i + 1);

			if (tmp1.equalsIgnoreCase(remove_str)) {

			} else {
				left_index = i;
				op = false;
			}
		}

		// scan right
		boolean op2 = true;
		int j = before_str.length();
		while (j >= 0 && op2 == true) {
			j--;
			String tmp1 = before_str.substring(j, j + 1);

			if (tmp1.equalsIgnoreCase(remove_str)) {

			} else {
				right_index = j;
				op2 = false;
			}
		}

		String final_str = before_str.substring(left_index, right_index + 1);
        /*        
        log.debug("left index = "+left_index);
        log.debug("right index = "+right_index);
        log.debug("before = "+before_str);
        log.debug("after = "+final_str);
        */
		return final_str;
	}

	public static String paddingLeft(int count, char c, String stringJdescId) {

		String sf = stringJdescId;
		while (sf.length() < count) {
			sf = c + sf;
		}
		return sf;
	}

	public static boolean isEmpty(String str) {
		if (null == str) {
			return true;
		} else if (str.isEmpty()) {
			return true;
		} else if (str.trim().isEmpty()) {
			return true;
		}else {
			return false;
		}
	}

}
