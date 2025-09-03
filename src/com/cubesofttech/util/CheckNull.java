package com.cubesofttech.util;

import org.apache.log4j.Logger;

public class CheckNull {
	private static final CheckNull INSTANCE = new CheckNull();
	private static final Logger log = Logger.getLogger(CheckNull.class);
 
	public CheckNull() {
		super();
	}

	public String chkNullString(String str) {
		String strTemp = "";
		try {
			if (str != null) {
				strTemp = str.trim();
			}
		} catch (Throwable e) {
			log.error(e);
		}

		return strTemp;
	}

	public double chkNullStringToDouble(String str) {
		String strTemp = "";
		String rep = "0.00";
		try {
			if (str != null) {
				strTemp = this.chkBlankString(str.trim(), rep);
			} else {
				strTemp = rep;
			}
		} catch (Throwable e) {
			log.error(e);
		}

		return Double.parseDouble(strTemp);
	}

	public float chkNullStringToFloat(String str) {
		String strTemp = "";
		String rep = "0.00";
		try {
			if (str != null) {
				strTemp = this.chkBlankString(str.trim(), rep);
			} else {
				strTemp = rep;
			}
		} catch (Throwable e) {
			log.error(e);
		}

		return Float.parseFloat(strTemp);
	}

	public String chkNullString(String str, String rep) {
		String strTemp = "";
		try {
			if (str != null) {
				strTemp = this.chkBlankString(str.trim(), rep);
			} else {
				strTemp = rep;
			}
		} catch (Throwable e) {
			log.error(e);
		}

		return strTemp;
	}

	private String chkBlankString(String strnull, String rep) {
		String strbnk = "";
		try {
			if (strnull.length() > 0) {
				strbnk = strnull;
			} else {
				strbnk = rep;
			}
		} catch (Throwable e) {
			log.error(e);
		}
		return strbnk;
	}

	public String chkNullString(Double d, String s) {
		if (d == null) {
			return s;
		} else {
			return d.toString();
		}
	}
}
