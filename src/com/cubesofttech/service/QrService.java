package com.cubesofttech.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cubesofttech.dao.BorrowDAO;
import com.cubesofttech.dao.EquipmentDAO;
import com.cubesofttech.dao.EquipmentStatusDAO;
import com.cubesofttech.dao.ProductDAO;
import com.cubesofttech.dao.WarehouseDAO;
import com.cubesofttech.model.Equipment;
import com.cubesofttech.model.EquipmentStatus;
import com.cubesofttech.model.Product;
import com.cubesofttech.model.Warehouse;

/**
 * ตรรกะของ QR: แยกรหัสใน QR (E12, P5, W3, A7) และรวมข้อมูลที่แสดงหลังสแกน
 * ใช้ร่วมกันได้หลายหน้า (หน้าผลสแกน, ไอคอนสแกนบนแถบบน, ปุ่มสแกนในแต่ละฟอร์ม)
 *
 * ใช้ได้ 2 ทาง
 *   1) เป็น action ของ /qr โดยตรง (qrView) : Struts สร้างสำเนาใหม่ต่อ request และ autowire DAO ให้ จึงอ่าน request/session ได้ปลอดภัย
 *   2) action ของเมนูอื่นเรียก scan(รหัส, สิทธิ์ของผู้ใช้) เอง โดยส่งสิทธิ์จาก session ของตัวเองเข้ามา (ตัวที่ Spring inject ไม่ยุ่งกับ request)
 *
 * ห้ามเก็บค่าของ request ไว้ใน field ของ class นี้ เพราะตัวที่ Spring inject ให้ action อื่นเป็นตัวเดียวทั้งระบบ
 * (loadBasic = ข้อมูลที่ทุกคนที่ login เห็น, loadFull = ข้อมูลเต็มเฉพาะผู้มีสิทธิ์)
 */
@Service
public class QrService {

	private static final Logger log = Logger.getLogger(QrService.class);

	/** รูปแบบรหัสใน QR: ตัวอักษรนำหน้า 1 ตัว ตามด้วยตัวเลข (กันค่าแปลกปลอมก่อนเข้า DAO) */
	private static final Pattern CODE_PATTERN = Pattern.compile("^([A-Z])(\\d{1,10})$");
	/** ชื่อสีป้ายที่ยอมรับ (กันค่าแปลกใน equipment_status.color_2 หลุดไปเป็น class) */
	private static final Pattern STATUS_COLOR_PATTERN = Pattern.compile("^[a-z0-9-]{1,30}$");

	public static final char TYPE_EQUIPMENT = 'E';

	/** สิทธิ์ดูข้อมูลเต็มจากการสแกน QR */
	public static final String PERMISSION_QR_VIEW = "stock.qr.view";

	@Autowired
	private EquipmentDAO equipmentDAO;

	@Autowired
	private EquipmentStatusDAO equipmentStatusDAO;

	@Autowired
	private WarehouseDAO warehouseDAO;

	@Autowired
	private ProductDAO productDAO;

	@Autowired
	private BorrowDAO borrowDAO;

	/** รหัสที่แยกแล้ว เช่น E303 = type E, id 303 */
	public static class QrCode {
		private final char type;
		private final int id;

		QrCode(char type, int id) {
			this.type = type;
			this.id = id;
		}

		public char getType() {
			return type;
		}

		public int getId() {
			return id;
		}
	}

	/** ข้อมูลที่ทุกคนที่ login เห็น */
	public static class QrBasic {
		public String name;
		public String itemNo;
		public String typeLabel;
		/** เก็บไว้ให้ loadFull ใช้ต่อ ไม่ต้องค้นซ้ำ */
		Equipment equipment;
	}

	/** ข้อมูลเต็ม (เรียกเฉพาะผู้มีสิทธิ์) */
	public static class QrFull {
		public Integer equipmentId;
		public String serialNo;
		public String statusCode;
		public String statusText;
		/** สีป้ายจาก equipment_status.color_2 (ชื่อสี Bootstrap เช่น success, warning) ใช้เป็น badge-xxx */
		public String statusColor;
		public boolean retired;
		public String catalog;
		public String location;
		public String borrower;
		public String borrowId;
		public String borrowDate;
	}

	/** action ของ /qr (actionback.xml): อ่าน c กับสิทธิ์จาก request/session แล้วส่งผลให้ JSP ผ่าน request attribute */
	@SuppressWarnings("unchecked")
	public String qrView() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession(false);
		Set<String> userAuthority = (session == null) ? null : (Set<String>) session.getAttribute("userAuthority");

		String rawCode = request.getParameter("c");
		if (rawCode == null || rawCode.trim().isEmpty()) {
			// ไม่มี c: ลองค้นจาก Item No. (ปุ่มสแกนบนแถบบนที่พิมพ์ Item No. แทนการสแกน)
			rawCode = codeFromItemNo(request.getParameter("item"));
		}

		Map<String, Object> attrs = scan(rawCode, userAuthority);
		for (Map.Entry<String, Object> entry : attrs.entrySet()) {
			request.setAttribute(entry.getKey(), entry.getValue());
		}
		return "success";
	}

	/** แปลง Item No. เป็นรหัส QR (E<equipment_id>) คืน null ถ้าไม่พบ (รอบนี้ค้นเฉพาะ Equipment) */
	public String codeFromItemNo(String itemNo) {
		if (itemNo == null || itemNo.trim().isEmpty()) {
			return null;
		}
		try {
			Equipment equipment = equipmentDAO.findByItemNo(itemNo.trim());
			if (equipment != null && equipment.getEquipmentId() != null) {
				return TYPE_EQUIPMENT + String.valueOf(equipment.getEquipmentId());
			}
		} catch (Exception e) {
			log.warn("codeFromItemNo failed, itemNo=" + itemNo, e);
		}
		return null;
	}

	/**
	 * จุดเข้าเดียวของหน้าผลสแกน: รับรหัสจาก QR + สิทธิ์ของผู้ใช้ แล้วคืนค่าที่ JSP ใช้ (key = ชื่อ attribute)
	 *   qrState = notfound | limited | full
	 *   limited : qrName, qrItemNo, qrTypeLabel เท่านั้น
	 *   full    : เพิ่ม qrEquipmentId, qrSerialNo, qrStatusCode, qrStatusText, qrRetired, qrCatalog,
	 *             qrLocation และถ้าถูกยืมอยู่ qrBorrower, qrBorrowId, qrBorrowDate
	 * ข้อมูลที่ผู้ใช้ไม่มีสิทธิ์เห็นจะไม่ถูกดึงและไม่อยู่ใน Map เลย
	 *
	 * @param userAuthority สิทธิ์ของผู้ใช้ที่ login (session attribute userAuthority) null = ไม่มีสิทธิ์
	 */
	public Map<String, Object> scan(String rawCode, Set<String> userAuthority) {
		Map<String, Object> attrs = new HashMap<String, Object>();
		try {
			QrBasic basic = loadBasic(parseCode(rawCode));
			if (basic == null) {
				attrs.put("qrState", "notfound");
				return attrs;
			}

			// ข้อมูลที่ทุกคนที่ login เห็น
			attrs.put("qrName", basic.name);
			attrs.put("qrItemNo", basic.itemNo);
			attrs.put("qrTypeLabel", basic.typeLabel);

			if (userAuthority == null || !userAuthority.contains(PERMISSION_QR_VIEW)) {
				attrs.put("qrState", "limited");
				return attrs;
			}

			// ข้อมูลเต็ม (เฉพาะคนที่มีสิทธิ์)
			QrFull full = loadFull(basic);
			attrs.put("qrState", "full");
			attrs.put("qrEquipmentId", full.equipmentId);
			attrs.put("qrSerialNo", full.serialNo);
			attrs.put("qrStatusCode", full.statusCode);
			attrs.put("qrStatusText", full.statusText);
			attrs.put("qrStatusColor", full.statusColor);
			attrs.put("qrRetired", full.retired);
			attrs.put("qrCatalog", full.catalog);
			attrs.put("qrLocation", full.location);
			if (full.borrower != null) {
				attrs.put("qrBorrower", full.borrower);
			}
			if (full.borrowId != null) {
				attrs.put("qrBorrowId", full.borrowId);
			}
			if (full.borrowDate != null) {
				attrs.put("qrBorrowDate", full.borrowDate);
			}
			return attrs;
		} catch (Exception e) {
			log.error("scan failed, c=" + rawCode, e);
			attrs.clear();
			attrs.put("qrState", "notfound");
			return attrs;
		}
	}

	/** แยกรหัส คืน null ถ้ารูปแบบไม่ถูกต้อง */
	public QrCode parseCode(String code) {
		if (code == null) {
			return null;
		}
		Matcher m = CODE_PATTERN.matcher(code.trim());
		if (!m.matches()) {
			return null;
		}
		try {
			return new QrCode(m.group(1).charAt(0), Integer.parseInt(m.group(2)));
		} catch (NumberFormatException e) {
			return null;
		}
	}

	/** ข้อมูลพื้นฐานของรหัสนี้ คืน null ถ้าไม่พบ หรือยังไม่รองรับประเภทนั้น (รอบแรกรองรับเฉพาะ E) */
	public QrBasic loadBasic(QrCode code) throws Exception {
		if (code == null || code.getType() != TYPE_EQUIPMENT) {
			return null;
		}
		Equipment equipment = equipmentDAO.findByEquipmentId(code.getId());
		if (equipment == null) {
			return null;
		}
		QrBasic basic = new QrBasic();
		basic.equipment = equipment;
		basic.name = nvl(equipment.getName());
		basic.itemNo = nvl(equipment.getItemNo());
		basic.typeLabel = "Equipment";
		return basic;
	}

	/** ข้อมูลเต็ม ผู้เรียกต้องตรวจสิทธิ์ก่อนเรียก */
	public QrFull loadFull(QrBasic basic) {
		Equipment equipment = basic.equipment;
		QrFull full = new QrFull();
		full.equipmentId = equipment.getEquipmentId();
		full.serialNo = nvl(equipment.getSerialNo());

		String statusCode = nvl(equipment.getStatus());
		full.statusCode = statusCode;
		fillStatus(full, statusCode);
		// สถานะปลดระวาง (S, Z, L) แสดงเป็นป้ายเตือน ไม่ใช่ "ไม่พบ"
		full.retired = EquipmentDAO.RETIRED_STATUSES.contains(statusCode);
		full.catalog = catalogName(equipment.getProductId());

		if ("B".equals(statusCode)) {
			// ถูกยืมอยู่ ไม่อยู่ในที่เก็บ (warehouse_id = 0) แสดงผู้ยืมแทน
			full.location = "ถูกยืมออกไป";
			fillBorrower(full, equipment.getEquipmentId());
		} else {
			full.location = locationPath(equipment.getWarehouseId());
		}
		return full;
	}

	/** ชื่อสถานะ + สีป้าย ตามที่ตั้งไว้ในตาราง equipment_status (สีเดียวกับหน้า Equipment List) */
	private void fillStatus(QrFull full, String statusCode) {
		full.statusText = statusCode.isEmpty() ? "-" : statusCode;
		full.statusColor = "secondary";
		if (statusCode.isEmpty()) {
			return;
		}
		try {
			EquipmentStatus status = equipmentStatusDAO.findByStatus(statusCode);
			if (status == null) {
				return;
			}
			if (status.getDescription() != null && !status.getDescription().trim().isEmpty()) {
				full.statusText = status.getDescription();
			}
			// รับเฉพาะชื่อสีที่เป็นตัวอักษร/ตัวเลข/ขีด เพราะค่านี้ถูกต่อเป็นชื่อ class ใน JSP
			String color = status.getColor2() == null ? "" : status.getColor2().trim().toLowerCase();
			if (STATUS_COLOR_PATTERN.matcher(color).matches()) {
				full.statusColor = color;
			}
		} catch (Exception e) {
			log.warn("fillStatus failed, status=" + statusCode, e);
		}
	}

	/** ชื่อรุ่นใน catalog (equipment.product_id เป็น varchar ต้องแปลงเป็นตัวเลขก่อน) */
	private String catalogName(String productId) {
		if (productId == null || productId.trim().isEmpty()) {
			return "-";
		}
		try {
			Product product = productDAO.findById(Integer.valueOf(productId.trim()));
			if (product != null && product.getProductName() != null) {
				return product.getProductName();
			}
		} catch (Exception e) {
			log.warn("catalogName failed, productId=" + productId, e);
		}
		return "-";
	}

	/** เส้นทางเต็มของที่เก็บ เช่น Cube ITF › ห้องเก็บของ › ตู้ 1 (null และ 0 ถือว่ายังไม่ระบุที่เก็บ) */
	public String locationPath(Long warehouseId) {
		if (warehouseId == null || warehouseId.longValue() <= 0L) {
			return "ยังไม่ระบุที่เก็บ";
		}
		List<String> names = new ArrayList<String>();
		Long current = warehouseId;
		// จำกัดความลึกกันข้อมูลวนลูป
		for (int depth = 0; depth < 12 && current != null && current.longValue() > 0L; depth++) {
			try {
				Warehouse wh = warehouseDAO.findById(current);
				if (wh == null) {
					break;
				}
				names.add(0, nvl(wh.getWarehouseName()));
				current = wh.getParent();
			} catch (Exception e) {
				log.warn("locationPath failed, warehouseId=" + current, e);
				break;
			}
		}
		if (names.isEmpty()) {
			return "ไม่พบที่เก็บในระบบ";
		}
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < names.size(); i++) {
			if (i > 0) {
				sb.append(" › ");
			}
			sb.append(names.get(i));
		}
		return sb.toString();
	}

	/** ผู้ยืมล่าสุดที่ยังไม่คืน (borrow.status = B) */
	private void fillBorrower(QrFull full, Integer equipmentId) {
		if (equipmentId == null) {
			return;
		}
		try {
			List<Map<String, Object>> rows = borrowDAO.findBorrowWithUserByEquipmentId2(String.valueOf(equipmentId));
			if (rows == null) {
				return;
			}
			for (Map<String, Object> row : rows) {
				if ("B".equals(String.valueOf(row.get("status")))) {
					// แสดงชื่อภาษาอังกฤษ (user.name_en) ถ้าว่างค่อยใช้ชื่อไทย
					full.borrower = firstNonBlank(row.get("name_en"), row.get("name"));
					Object borrowId = row.get("borrow_id");
					if (borrowId != null) {
						full.borrowId = String.valueOf(borrowId);
					}
					Object start = row.get("date_start");
					if (start instanceof java.util.Date) {
						full.borrowDate = new SimpleDateFormat("dd/MM/yyyy HH:mm").format((java.util.Date) start);
					}
					return;
				}
			}
		} catch (Exception e) {
			log.warn("fillBorrower failed, equipmentId=" + equipmentId, e);
		}
	}

	private static String firstNonBlank(Object first, Object second) {
		if (first != null && !String.valueOf(first).trim().isEmpty()) {
			return String.valueOf(first).trim();
		}
		if (second != null && !String.valueOf(second).trim().isEmpty()) {
			return String.valueOf(second).trim();
		}
		return "-";
	}

	private static String nvl(String s) {
		return s == null ? "" : s;
	}
}
