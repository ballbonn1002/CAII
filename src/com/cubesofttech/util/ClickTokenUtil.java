package com.cubesofttech.util;

import java.io.Serializable;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Iterator;
import java.util.LinkedHashSet;

import javax.servlet.http.HttpSession;

/**
 * token ยืนยันว่าการลงเวลาเกิดจาก "การกดปุ่มจริง" บนหน้าเว็บ
 *
 * flow:
 * 1. เปิดหน้าลงเวลา (WorkHoursAction.init) -> issue() สร้าง token ใหม่เก็บใน session แล้วส่งให้หน้าเว็บ
 * 2. หน้าเว็บเก็บ token ไว้ในตัวแปรภายใน (closure) และแนบไปกับ header X-Click-Token
 *    เฉพาะตอนที่ผู้ใช้กดปุ่มจริง (event.isTrusted) เท่านั้น
 * 3. savecheck -> verifyAndConsume() เทียบกับ session แล้วคืนป้ายผลตรวจ
 *    token ใช้ได้ครั้งเดียว ใช้แล้วย้ายไปกองที่ใช้แล้ว ยิงซ้ำจะได้ TOKEN_REUSED
 *
 * หมายเหตุ: ใช้ "ติดป้าย" ให้ HR ตรวจ ไม่ได้ใช้ปฏิเสธการลงเวลา
 * และไม่ใช่หลักฐาน 100% — คนที่ตั้งใจแกะโค้ดหน้าเว็บ (เช่น ตั้ง breakpoint) ยังดึง token ไปใช้ได้
 */
public class ClickTokenUtil {

	public static final String HEADER = "X-Click-Token";

	public static final String TOKEN_OK = "TOKEN_OK";           // กดปุ่มจริง token ถูกต้อง
	public static final String TOKEN_MISSING = "TOKEN_MISSING"; // ไม่มี token (script สั่งคลิก / ยิง API ตรง)
	public static final String TOKEN_INVALID = "TOKEN_INVALID"; // มี token แต่ไม่ใช่ที่ระบบออกให้
	public static final String TOKEN_REUSED = "TOKEN_REUSED";   // token เคยถูกใช้ไปแล้ว (ก็อป request ไปยิงซ้ำ)

	private static final String SESSION_KEY = "clickTokenStore";
	private static final SecureRandom RANDOM = new SecureRandom();

	private ClickTokenUtil() {}

	/** สร้าง token ใหม่ผูกกับ session (เรียกทุกครั้งที่เปิดหน้าลงเวลา) */
	public static String issue(HttpSession session) {
		if (session == null) return null;
		byte[] bytes = new byte[32];
		RANDOM.nextBytes(bytes);
		StringBuilder sb = new StringBuilder(64);
		for (byte b : bytes) {
			sb.append(String.format("%02x", b));
		}
		String token = sb.toString();
		getStore(session).add(token);
		return token;
	}

	/** ตรวจ token ที่ได้จากหน้าเว็บ แล้วตัดทิ้งให้ใช้ซ้ำไม่ได้ คืนค่าเป็นป้าย TOKEN_* */
	public static String verifyAndConsume(HttpSession session, String token) {
		if (token == null || token.trim().isEmpty()) return TOKEN_MISSING;
		if (session == null) return TOKEN_INVALID;
		return getStore(session).consume(token.trim());
	}

	private static Store getStore(HttpSession session) {
		synchronized (session) {
			Store store = (Store) session.getAttribute(SESSION_KEY);
			if (store == null) {
				store = new Store();
				session.setAttribute(SESSION_KEY, store);
			}
			return store;
		}
	}

	/**
	 * เก็บ token ที่ยังใช้ได้ (หลายตัว เผื่อเปิดหลายแท็บ) กับ token ที่ใช้ไปแล้ว
	 * จำกัดจำนวนไว้ไม่ให้ session โตเรื่อยๆ
	 */
	private static class Store implements Serializable {
		private static final long serialVersionUID = 1L;
		private static final int MAX_ACTIVE = 10;
		private static final int MAX_USED = 30;

		private final LinkedHashSet<String> active = new LinkedHashSet<>();
		private final LinkedHashSet<String> used = new LinkedHashSet<>();

		synchronized void add(String token) {
			active.add(token);
			trim(active, MAX_ACTIVE);
		}

		synchronized String consume(String token) {
			String match = find(active, token);
			if (match != null) {
				active.remove(match);
				used.add(match);
				trim(used, MAX_USED);
				return TOKEN_OK;
			}
			if (find(used, token) != null) return TOKEN_REUSED;
			return TOKEN_INVALID;
		}

		// เทียบแบบใช้เวลาคงที่ (กันการเดา token จากเวลาตอบกลับ)
		private static String find(LinkedHashSet<String> set, String token) {
			byte[] input = token.getBytes(StandardCharsets.UTF_8);
			String found = null;
			for (String t : set) {
				if (MessageDigest.isEqual(t.getBytes(StandardCharsets.UTF_8), input)) found = t;
			}
			return found;
		}

		// ตัดตัวที่เก่าที่สุดทิ้งเมื่อเกินจำนวน
		private static void trim(LinkedHashSet<String> set, int max) {
			Iterator<String> it = set.iterator();
			while (set.size() > max && it.hasNext()) {
				it.next();
				it.remove();
			}
		}
	}
}
