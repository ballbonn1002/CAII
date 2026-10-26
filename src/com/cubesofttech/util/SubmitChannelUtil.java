package com.cubesofttech.util;

import javax.servlet.http.HttpServletRequest;

/**
 * ตัดสินว่า request ลงเวลา (check-in/out) ที่เข้ามานี้ "น่าจะ" มาจากช่องทางไหน
 * โดยอาศัยร่องรอยที่ browser/LINE ส่งมาให้เองตามธรรมชาติ (header/referer)
 * ไม่ใช่ค่าที่ frontend กำหนดเองแล้วส่งมาตรงๆ เพราะแบบนั้นปลอมได้ง่ายเกินไป
 *
 * หมายเหตุสำคัญ: นี่คือ "สัญญาณเตือน" ให้ HR สังเกตแล้วไปตรวจสอบเพิ่ม
 * ไม่ใช่ระบบป้องกันที่ปลอมไม่ได้ 100% คนที่เปิด DevTools แล้วตั้งใจ copy header
 * ให้ครบยังสามารถทำให้ผลลัพธ์ออกมาเป็น WEB_FORM ได้อยู่ดี
 * ถ้าต้องการป้องกันแบบปลอมไม่ได้จริง ต้องใช้ CSRF token ที่ผูกกับ session แทน
 */
public class SubmitChannelUtil {

	/** กดปุ่มจริงจากหน้าเว็บ HR (pages-back) */
	public static final String WEB_FORM = "WEB_FORM";
	/** กดปุ่มจริงจากหน้า LINE LIFF (pages-line) */
	public static final String LINE_LIFF = "LINE_LIFF";
	/** พิมพ์คำสั่งในแชท LINE bot (ผ่าน webhook) */
	public static final String LINE_WEBHOOK = "LINE_WEBHOOK";
	/** ไม่มี "ลายเซ็น" ของ AJAX call จากหน้าเว็บของเราเอง — น่าสงสัย ควรตรวจสอบเพิ่ม */
	public static final String WEB_UNVERIFIED = "WEB_UNVERIFIED";

	private SubmitChannelUtil() {
	}

	/**
	 * ใช้กับ request ที่เข้า WorkHoursAction.savecheck() ซึ่งรับได้ทั้งจากเว็บ HR ปกติ
	 * (pages-back) และ LINE LIFF (pages-line) ที่ยิงมาที่ action เดียวกัน
	 */
	public static String determineWebChannel(HttpServletRequest request) {
		String requestedWith = request.getHeader("X-Requested-With");
		String referer = request.getHeader("Referer");

		// jQuery $.ajax ใส่ header นี้ให้อัตโนมัติทุกครั้งที่ยิง AJAX แบบ same-origin
		// ส่วน Postman/curl หรือ fetch() ที่ยิงตรงจาก Console จะไม่มี header นี้
		// เว้นแต่คนยิงจะตั้งใจใส่มาเอง
		boolean hasAjaxSignature = "XMLHttpRequest".equalsIgnoreCase(requestedWith);

		// Referer ต้องชี้มาจาก host เดียวกับที่รับ request นี้ (กัน referer ปลอมข้าม domain)
		boolean refererSameHost = false;
		if (referer != null && !referer.trim().isEmpty()) {
			String host = request.getHeader("Host");
			if (host == null || host.trim().isEmpty()) {
				host = request.getServerName();
			}
			refererSameHost = host != null && referer.toLowerCase().contains(host.toLowerCase());
		}

		if (!hasAjaxSignature || !refererSameHost) {
			return WEB_UNVERIFIED;
		}

		// แยก LINE LIFF (pages-line) ออกจากเว็บ HR ปกติ (pages-back) จาก path ใน referer
		String refererLower = referer.toLowerCase();
		if (refererLower.contains("pages-line") || refererLower.contains("line_check_in_out")) {
			return LINE_LIFF;
		}

		return WEB_FORM;
	}
}
