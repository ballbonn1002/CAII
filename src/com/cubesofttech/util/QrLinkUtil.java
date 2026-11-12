package com.cubesofttech.util;

import javax.servlet.http.HttpServletRequest;

import com.cubesofttech.system.Constant;

/**
 * สร้างลิงก์ที่เข้ารหัสใน QR เช่น https://<โดเมน>/qr?c=E12
 *
 * โดเมนอ่านจาก qr.base.url ใน application.properties (ต้องเป็นเว็บจริงที่พนักงานเปิดได้)
 * ถ้ายังไม่ตั้งค่า จะใช้โดเมนของหน้าที่เปิดอยู่แทน ซึ่งบนเครื่องทดสอบจะเป็น localhost
 * หน้าที่สร้าง QR จึงควรเตือนผู้ใช้เมื่อ isConfigured() เป็น false
 */
public final class QrLinkUtil {

	private QrLinkUtil() {
	}

	/** ตั้งค่า qr.base.url ไว้แล้วหรือยัง */
	public static boolean isConfigured() {
		String base = Constant.getQrBaseUrl();
		return base != null && !base.trim().isEmpty();
	}

	/** โดเมน + context path ไม่มี / ปิดท้าย */
	public static String baseUrl(HttpServletRequest request) {
		String base = Constant.getQrBaseUrl();
		if (base == null || base.trim().isEmpty()) {
			if (request == null) {
				return "";
			}
			StringBuilder sb = new StringBuilder();
			sb.append(request.getScheme()).append("://").append(request.getServerName());
			int port = request.getServerPort();
			boolean defaultPort = ("http".equals(request.getScheme()) && port == 80)
					|| ("https".equals(request.getScheme()) && port == 443);
			if (!defaultPort) {
				sb.append(':').append(port);
			}
			sb.append(request.getContextPath());
			base = sb.toString();
		}
		base = base.trim();
		while (base.endsWith("/")) {
			base = base.substring(0, base.length() - 1);
		}
		return base;
	}

	/** ลิงก์ QR ของ Equipment 1 เครื่อง (ใช้ equipment_id ที่ไม่เปลี่ยน ไม่ใช้ Item No. ที่แก้ไขได้) */
	public static String equipmentLink(HttpServletRequest request, Integer equipmentId) {
		if (equipmentId == null) {
			return "";
		}
		return baseUrl(request) + "/qr?c=E" + equipmentId;
	}
}
