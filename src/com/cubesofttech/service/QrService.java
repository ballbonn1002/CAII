package com.cubesofttech.service;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
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

import com.cubesofttech.dao.AssetDAO;
import com.cubesofttech.dao.BorrowDAO;
import com.cubesofttech.dao.EquipmentDAO;
import com.cubesofttech.dao.EquipmentStatusDAO;
import com.cubesofttech.dao.ProductDAO;
import com.cubesofttech.dao.StockDAO;
import com.cubesofttech.dao.UnitOfMeasureDAO;
import com.cubesofttech.dao.WarehouseDAO;
import com.cubesofttech.model.Asset;
import com.cubesofttech.model.Equipment;
import com.cubesofttech.model.EquipmentStatus;
import com.cubesofttech.model.Product;
import com.cubesofttech.model.Stock;
import com.cubesofttech.model.UnitOfMeasure;
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
	/** สินค้า Consumables / Accessories (รหัส P<product_id>) */
	public static final char TYPE_PRODUCT = 'P';
	/** ที่เก็บ / warehouse (รหัส W<warehouse_id>) */
	public static final char TYPE_WAREHOUSE = 'W';
	/** Asset 1 ชิ้น (รหัส A<asset_id>) */
	public static final char TYPE_ASSET = 'A';
	/** สิทธิ์เมนู Assets ใช้ตัดสินว่าจะโชว์ปุ่มไปหน้าแก้ไข Asset หรือไม่ */
	private static final String PERMISSION_ASSET = "assetlist.view";

	private static final String PRODUCT_TYPE_CONSUMABLES = "2";
	private static final String PRODUCT_TYPE_ACCESSORIES = "3";
	/** key แทน "ไม่ระบุที่เก็บ" ของแถว stock ที่ warehouse_id ว่างหรือเป็น 0 */
	private static final String NO_LOCATION_KEY = "0";
	/** จำนวนที่เก็บย่อยสูงสุดที่หน้าผลสแกนของที่เก็บจะรวมให้ (กันข้อมูลผิดปกติ) */
	private static final int MAX_TREE_NODES = 500;

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

	@Autowired
	private StockDAO stockDAO;

	@Autowired
	private UnitOfMeasureDAO unitOfMeasureDAO;

	@Autowired
	private AssetDAO assetDAO;

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
		/** ชนิดของรหัส: E, P, W หรือ A */
		public char kind;
		/** ป้ายของช่อง itemNo ในหน้าแบบจำกัด (Equipment = Item No., สินค้า = Item ID, ที่เก็บ = ที่เก็บ) */
		public String itemNoLabel;
		/** เก็บไว้ให้ส่วนข้อมูลเต็มใช้ต่อ ไม่ต้องค้นซ้ำ */
		Equipment equipment;
		Product product;
		Warehouse warehouse;
		Asset asset;
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

	/**
	 * แปลงข้อความที่ผู้ใช้พิมพ์ (ช่องพิมพ์ในหน้าต่างสแกนบนแถบบน) เป็นรหัส QR คืน null ถ้าไม่พบ
	 * ค้นตามลำดับ (ซ้ำกันให้ตัวก่อนชนะ):
	 *   1) Item No. ของ Equipment          -> E<equipment_id>
	 *   2) Item ID (product_no) ของสินค้า  -> P<product_id> (สินค้า type ที่หน้าสแกนไม่รองรับจะขึ้น "ไม่พบรายการ" เอง)
	 *   3) รหัสบนป้าย เช่น P12, W5, E303  -> ใช้ตามนั้น (ไม่สนตัวพิมพ์เล็ก/ใหญ่)
	 */
	public String codeFromItemNo(String itemNo) {
		if (itemNo == null || itemNo.trim().isEmpty()) {
			return null;
		}
		String text = itemNo.trim();
		try {
			Equipment equipment = equipmentDAO.findByItemNo(text);
			if (equipment != null && equipment.getEquipmentId() != null) {
				return TYPE_EQUIPMENT + String.valueOf(equipment.getEquipmentId());
			}
		} catch (Exception e) {
			log.warn("codeFromItemNo: equipment lookup failed, itemNo=" + itemNo, e);
		}
		try {
			Product product = productDAO.findByProductNo(text);
			if (product != null && product.getProductId() != null) {
				return TYPE_PRODUCT + String.valueOf(product.getProductId());
			}
		} catch (Exception e) {
			log.warn("codeFromItemNo: product lookup failed, itemNo=" + itemNo, e);
		}
		try {
			Asset asset = assetDAO.findByItemNo(text);
			if (asset != null && asset.getAssetId() != null) {
				return TYPE_ASSET + String.valueOf(asset.getAssetId());
			}
		} catch (Exception e) {
			log.warn("codeFromItemNo: asset lookup failed, itemNo=" + itemNo, e);
		}
		String upper = text.toUpperCase(Locale.ENGLISH);
		if (CODE_PATTERN.matcher(upper).matches()) {
			return upper;
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
			attrs.put("qrKind", String.valueOf(basic.kind));
			attrs.put("qrItemNoLabel", basic.itemNoLabel);

			if (userAuthority == null || !userAuthority.contains(PERMISSION_QR_VIEW)) {
				attrs.put("qrState", "limited");
				return attrs;
			}

			// สินค้า (P) และที่เก็บ (W): ข้อมูลเต็มประกอบแยกจาก Equipment
			if (basic.kind == TYPE_PRODUCT) {
				attrs.put("qrState", "full");
				putProductFull(attrs, basic.product);
				return attrs;
			}
			if (basic.kind == TYPE_WAREHOUSE) {
				attrs.put("qrState", "full");
				putWarehouseFull(attrs, basic.warehouse);
				return attrs;
			}
			if (basic.kind == TYPE_ASSET) {
				attrs.put("qrState", "full");
				putAssetFull(attrs, basic.asset, userAuthority);
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

	/** ข้อมูลพื้นฐานของรหัสนี้ คืน null ถ้าไม่พบ หรือยังไม่รองรับประเภทนั้น (รองรับ E, P ของ type 2/3, W, A) */
	public QrBasic loadBasic(QrCode code) throws Exception {
		if (code == null) {
			return null;
		}
		if (code.getType() == TYPE_PRODUCT) {
			return loadProductBasic(code.getId());
		}
		if (code.getType() == TYPE_WAREHOUSE) {
			return loadWarehouseBasic(code.getId());
		}
		if (code.getType() == TYPE_ASSET) {
			return loadAssetBasic(code.getId());
		}
		if (code.getType() != TYPE_EQUIPMENT) {
			return null;
		}
		Equipment equipment = equipmentDAO.findByEquipmentId(code.getId());
		if (equipment == null) {
			return null;
		}
		QrBasic basic = new QrBasic();
		basic.kind = TYPE_EQUIPMENT;
		basic.itemNoLabel = "Item No.";
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
		String[] status = lookupStatus(statusCode, new HashMap<String, String[]>());
		full.statusText = status[0];
		full.statusColor = status[1];
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

	// =====================================================================
	// รหัส P (สินค้า Consumables / Accessories)
	// =====================================================================

	private QrBasic loadProductBasic(int productId) throws Exception {
		Product product = productDAO.findById(Integer.valueOf(productId));
		if (product == null) {
			return null;
		}
		Map<Integer, Product> cache = new HashMap<Integer, Product>();
		cache.put(product.getProductId(), product);
		String type = effectiveProductType(product, cache);
		// รอบนี้รองรับ type 2 (Consumables) กับ 3 (Accessories) เท่านั้น
		// type 1 Equipment ใช้ QR รายเครื่อง (รหัส E) ส่วน type 4 รอเมนู Assets
		String typeLabel;
		if (PRODUCT_TYPE_CONSUMABLES.equals(type)) {
			typeLabel = "Consumables";
		} else if (PRODUCT_TYPE_ACCESSORIES.equals(type)) {
			typeLabel = "Accessories";
		} else {
			return null;
		}
		QrBasic basic = new QrBasic();
		basic.kind = TYPE_PRODUCT;
		basic.product = product;
		basic.name = productDisplayName(product, cache);
		basic.itemNo = nvl(product.getProductNo());
		basic.itemNoLabel = "Item ID";
		basic.typeLabel = typeLabel;
		return basic;
	}

	/** product_type ของ product (sub product ที่ไม่ได้ตั้งไว้เองใช้ของตัวแม่) */
	private String effectiveProductType(Product product, Map<Integer, Product> cache) {
		String type = nvl(product.getProductType()).trim();
		if (type.isEmpty() && isSubProduct(product)) {
			Product parent = findProductQuietly(product.getParentProductId(), cache);
			if (parent != null) {
				type = nvl(parent.getProductType()).trim();
			}
		}
		return type;
	}

	private static boolean isSubProduct(Product product) {
		String parent = nvl(product.getParentProductId()).trim();
		return !parent.isEmpty() && !"0".equals(parent);
	}

	private Product findProductQuietly(String idText, Map<Integer, Product> cache) {
		try {
			Integer id = Integer.valueOf(nvl(idText).trim());
			if (cache.containsKey(id)) {
				return cache.get(id);
			}
			Product p = productDAO.findById(id);
			cache.put(id, p);
			return p;
		} catch (Exception e) {
			log.warn("findProductQuietly failed, id=" + idText, e);
			return null;
		}
	}

	/** ชื่อสินค้าที่แสดง: sub product แสดงเป็น "ตัวแม่ (sub)" */
	private String productDisplayName(Product product, Map<Integer, Product> cache) {
		String name = nvl(product.getProductName());
		if (isSubProduct(product)) {
			Product parent = findProductQuietly(product.getParentProductId(), cache);
			if (parent != null && !nvl(parent.getProductName()).trim().isEmpty()) {
				return parent.getProductName().trim() + " (" + name + ")";
			}
		}
		return name;
	}

	/**
	 * ข้อมูลเต็มของสินค้า: ยอดรวมทุกที่เก็บ + ยอดแยกตามที่เก็บ (เส้นทางเต็ม)
	 * ตัวแม่ที่มี sub product รวมยอดของ sub product ทุกตัวด้วย (แสดงแยกบรรทัดต่อ sub)
	 * ยอดนับจาก stock.amount_convert (หน่วยหลัก) เพราะ stock เก็บเป็นรายการเคลื่อนไหว ผลรวม = ยอดคงเหลือ
	 */
	private void putProductFull(Map<String, Object> attrs, Product product) throws Exception {
		Map<Integer, Product> productCache = new HashMap<Integer, Product>();
		productCache.put(product.getProductId(), product);

		List<Product> family = new ArrayList<Product>();
		family.add(product);
		if (!isSubProduct(product)) {
			List<Product> subs = productDAO.findByParentProductIds(
					Collections.singletonList(String.valueOf(product.getProductId())));
			if (subs != null) {
				List<Product> sortedSubs = new ArrayList<Product>();
				for (Product sub : subs) {
					if (sub != null && sub.getProductId() != null && !sub.getProductId().equals(product.getProductId())) {
						sortedSubs.add(sub);
						productCache.put(sub.getProductId(), sub);
					}
				}
				Collections.sort(sortedSubs, new Comparator<Product>() {
					public int compare(Product a, Product b) {
						int c = compareSequence(a.getSequence(), b.getSequence());
						return c != 0 ? c : nvl(a.getProductName()).compareTo(nvl(b.getProductName()));
					}
				});
				family.addAll(sortedSubs);
			}
		}

		List<String> productIds = new ArrayList<String>();
		for (Product p : family) {
			productIds.add(String.valueOf(p.getProductId()));
		}

		// productId -> (warehouseKey -> ยอดสุทธิหน่วยหลัก)
		Map<String, Map<String, Double>> netByProduct = new HashMap<String, Map<String, Double>>();
		List<Stock> rows = stockDAO.findByProductIds(productIds);
		if (rows != null) {
			for (Stock row : rows) {
				if (row == null || row.getProductId() == null) {
					continue;
				}
				String pid = row.getProductId().trim();
				String whKey = warehouseKey(row.getWarehouseId());
				Map<String, Double> byWh = netByProduct.get(pid);
				if (byWh == null) {
					byWh = new HashMap<String, Double>();
					netByProduct.put(pid, byWh);
				}
				Double prev = byWh.get(whKey);
				byWh.put(whKey, Double.valueOf((prev != null ? prev.doubleValue() : 0d) + stockAmount(row)));
			}
		}

		Map<Long, Warehouse> warehouseById = warehouseMap(warehouseDAO.findAll());
		Map<String, List<UnitOfMeasure>> unitCache = new HashMap<String, List<UnitOfMeasure>>();

		List<Map<String, Object>> totals = new ArrayList<Map<String, Object>>();
		// path -> บรรทัดสินค้าที่ที่เก็บนั้น (TreeMap เรียงตามชื่อเส้นทาง)
		Map<String, List<Map<String, Object>>> linesByPath = new java.util.TreeMap<String, List<Map<String, Object>>>();
		for (Product p : family) {
			String pid = String.valueOf(p.getProductId());
			Map<String, Double> byWh = netByProduct.get(pid);
			if (byWh == null) {
				continue;
			}
			List<UnitOfMeasure> units = unitsOf(p, pid, unitCache);
			String name = productDisplayName(p, productCache);
			double total = 0d;
			for (Map.Entry<String, Double> e : byWh.entrySet()) {
				double net = e.getValue().doubleValue();
				if (isZero(net)) {
					continue;
				}
				total += net;
				String path = NO_LOCATION_KEY.equals(e.getKey()) ? "ไม่ระบุที่เก็บ"
						: pathOf(parseLongOrNull(e.getKey()), warehouseById);
				List<Map<String, Object>> lines = linesByPath.get(path);
				if (lines == null) {
					lines = new ArrayList<Map<String, Object>>();
					linesByPath.put(path, lines);
				}
				lines.add(line(name, formatAmount(net, units)));
			}
			if (!isZero(total)) {
				totals.add(line(name, formatAmount(total, units)));
			}
		}

		List<Map<String, Object>> byLocation = new ArrayList<Map<String, Object>>();
		for (Map.Entry<String, List<Map<String, Object>>> e : linesByPath.entrySet()) {
			Map<String, Object> section = new HashMap<String, Object>();
			section.put("path", e.getKey());
			section.put("lines", e.getValue());
			byLocation.add(section);
		}

		// ปุ่ม "ดูรายละเอียด" ต้องพาไปหน้าของตัวแม่เสมอ (หน้า stock_balance / product_edit รับ id ของตัวแม่)
		String pageId = isSubProduct(product) ? nvl(product.getParentProductId()).trim()
				: String.valueOf(product.getProductId());
		attrs.put("qrProductPageId", pageId);
		attrs.put("qrMultiProduct", Boolean.valueOf(family.size() > 1));
		attrs.put("qrTotals", totals);
		// ตัวแม่ที่มี sub: ยอดรวมทุก sub (เหมือนปุ่ม All ในหน้า Stock Balance) ใช้หน่วยของตัวที่สแกน
		// (sub ไม่มีหน่วยของตัวเอง จึงใช้หน่วยของตัวแม่ - ดู unitsOf(Product, ...))
		if (family.size() > 1 && !totals.isEmpty()) {
			double grandTotal = 0d;
			for (Map<String, Double> byWh : netByProduct.values()) {
				for (Double v : byWh.values()) {
					grandTotal += v.doubleValue();
				}
			}
			attrs.put("qrGrandTotal", formatAmount(grandTotal,
					unitsOf(product, String.valueOf(product.getProductId()), unitCache)));
		}
		attrs.put("qrByLocation", byLocation);
	}

	// =====================================================================
	// รหัส W (ที่เก็บ / warehouse)
	// =====================================================================

	private QrBasic loadAssetBasic(int assetId) throws Exception {
		Asset asset = assetDAO.findById(Integer.valueOf(assetId));
		if (asset == null) {
			return null;
		}
		QrBasic basic = new QrBasic();
		basic.kind = TYPE_ASSET;
		basic.itemNoLabel = "Item No.";
		basic.asset = asset;
		basic.name = nvl(asset.getName());
		basic.itemNo = nvl(asset.getItemNo());
		basic.typeLabel = "Assets";
		return basic;
	}

	/** ข้อมูลเต็มของ Asset 1 ชิ้น (เรียกเฉพาะผู้มีสิทธิ์ stock.qr.view) */
	private void putAssetFull(Map<String, Object> attrs, Asset asset, Set<String> userAuthority) {
		attrs.put("qrAssetId", asset.getAssetId());
		attrs.put("qrSerialNo", nvl(asset.getSerialNo()));
		attrs.put("qrStatusCode", nvl(asset.getStatus()));
		attrs.put("qrStatusText", asset.getStatusLabel());
		// ใน JSP ต่อเป็น badge-${qrStatusColor} เหมือน Equipment จึงใส่ light- ให้ตรงกับป้ายหน้ารายการ Assets
		attrs.put("qrStatusColor", "light-" + asset.getStatusColor());
		attrs.put("qrLocation", locationPath(asset.getWarehouseId()));
		String model = "ไม่ระบุรุ่น";
		if (asset.getProductId() != null) {
			Map<Integer, Product> cache = new HashMap<Integer, Product>();
			Product product = findProductQuietly(String.valueOf(asset.getProductId()), cache);
			model = (product != null) ? productDisplayName(product, cache) : ("สินค้า #" + asset.getProductId());
		}
		attrs.put("qrCatalog", model);
		if (asset.getPurchaseDate() != null) {
			attrs.put("qrPurchaseDate", new SimpleDateFormat("d MMM yyyy", new Locale("th", "TH")).format(asset.getPurchaseDate()));
		}
		if (!nvl(asset.getNote()).trim().isEmpty()) {
			attrs.put("qrNote", asset.getNote().trim());
		}
		attrs.put("qrCanEditAsset", Boolean.valueOf(userAuthority != null && userAuthority.contains(PERMISSION_ASSET)));
	}

	private QrBasic loadWarehouseBasic(int warehouseId) throws Exception {
		Warehouse warehouse = warehouseDAO.findById(Long.valueOf(warehouseId));
		if (warehouse == null) {
			return null;
		}
		QrBasic basic = new QrBasic();
		basic.kind = TYPE_WAREHOUSE;
		basic.warehouse = warehouse;
		basic.name = nvl(warehouse.getWarehouseName());
		// ผู้ไม่มีสิทธิ์เห็นแค่ชื่อกับเส้นทางของที่เก็บ
		basic.itemNo = locationPath(warehouse.getWarehouseId());
		basic.itemNoLabel = "ที่เก็บ";
		basic.typeLabel = "Warehouse";
		return basic;
	}

	/**
	 * ข้อมูลเต็มของที่เก็บ: ของในที่เก็บนี้ + ที่เก็บย่อยทุกชั้น จัดกลุ่มตามที่เก็บย่อย
	 *  - Consumables/Accessories : ยอดสุทธิจาก stock (หน่วยหลัก + หน่วยใหญ่)
	 *  - Equipment : นับเป็นจำนวนเครื่องต่อรุ่น กดดูรายเครื่องได้ (Item No., Serial, สถานะ)
	 *    ไม่นับเครื่องที่ปลดระวาง (S, Z, L) และเครื่องที่ถูกยืมอยู่ (B) เหมือนหน้า Stock By Location
	 *  - Assets : นับเป็นชิ้นต่อรุ่น กดดูรายชิ้นได้ (Item No., Serial, สถานะ) นับทุกสถานะ
	 */
	private void putWarehouseFull(Map<String, Object> attrs, Warehouse root) throws Exception {
		Map<Long, Warehouse> warehouseById = warehouseMap(warehouseDAO.findAll());
		Map<Long, List<Warehouse>> childrenByParent = new HashMap<Long, List<Warehouse>>();
		for (Warehouse wh : warehouseById.values()) {
			Long parent = wh.getParent();
			if (parent == null || parent.longValue() <= 0L) {
				continue;
			}
			List<Warehouse> children = childrenByParent.get(parent);
			if (children == null) {
				children = new ArrayList<Warehouse>();
				childrenByParent.put(parent, children);
			}
			children.add(wh);
		}

		// ไล่หาที่เก็บย่อยทุกชั้น (กัน loop ด้วย visited และจำกัดจำนวนกันข้อมูลผิดปกติ)
		List<Long> subtree = new ArrayList<Long>();
		Set<Long> visited = new HashSet<Long>();
		java.util.LinkedList<Long> queue = new java.util.LinkedList<Long>();
		queue.add(root.getWarehouseId());
		visited.add(root.getWarehouseId());
		boolean truncated = false;
		while (!queue.isEmpty()) {
			Long current = queue.removeFirst();
			if (subtree.size() >= MAX_TREE_NODES) {
				truncated = true;
				break;
			}
			subtree.add(current);
			List<Warehouse> children = childrenByParent.get(current);
			if (children == null) {
				continue;
			}
			for (Warehouse child : children) {
				if (child.getWarehouseId() != null && visited.add(child.getWarehouseId())) {
					queue.add(child.getWarehouseId());
				}
			}
		}

		List<String> warehouseKeys = new ArrayList<String>();
		for (Long id : subtree) {
			warehouseKeys.add(String.valueOf(id));
		}

		// warehouseId -> (productId -> ยอดสุทธิหน่วยหลัก)
		Map<Long, Map<String, Double>> stockByWarehouse = new HashMap<Long, Map<String, Double>>();
		List<Stock> stockRows = stockDAO.findByWarehouseIds(warehouseKeys);
		if (stockRows != null) {
			for (Stock row : stockRows) {
				if (row == null || row.getProductId() == null || row.getProductId().trim().isEmpty()) {
					continue;
				}
				Long whId = parseLongOrNull(row.getWarehouseId());
				if (whId == null) {
					continue;
				}
				Map<String, Double> byProduct = stockByWarehouse.get(whId);
				if (byProduct == null) {
					byProduct = new HashMap<String, Double>();
					stockByWarehouse.put(whId, byProduct);
				}
				String pid = row.getProductId().trim();
				Double prev = byProduct.get(pid);
				byProduct.put(pid, Double.valueOf((prev != null ? prev.doubleValue() : 0d) + stockAmount(row)));
			}
		}

		// warehouseId -> (productId หรือ "" ถ้ายังไม่ผูกสินค้า -> เครื่องในรุ่นนั้น)
		Map<Long, Map<String, List<Equipment>>> equipmentByWarehouse = new HashMap<Long, Map<String, List<Equipment>>>();
		List<Equipment> equipmentRows = equipmentDAO.findByWarehouseIds(subtree);
		if (equipmentRows != null) {
			for (Equipment eq : equipmentRows) {
				if (eq == null || eq.getWarehouseId() == null || eq.getWarehouseId().longValue() <= 0L) {
					continue;
				}
				String status = nvl(eq.getStatus()).trim();
				if (EquipmentDAO.RETIRED_STATUSES.contains(status) || "B".equals(status)) {
					continue;
				}
				Map<String, List<Equipment>> byModel = equipmentByWarehouse.get(eq.getWarehouseId());
				if (byModel == null) {
					byModel = new HashMap<String, List<Equipment>>();
					equipmentByWarehouse.put(eq.getWarehouseId(), byModel);
				}
				String modelKey = nvl(eq.getProductId()).trim();
				List<Equipment> units = byModel.get(modelKey);
				if (units == null) {
					units = new ArrayList<Equipment>();
					byModel.put(modelKey, units);
				}
				units.add(eq);
			}
		}

		// warehouseId -> (productId หรือ "" ถ้ายังไม่ผูกรุ่น -> Asset ในรุ่นนั้น) นับทุกสถานะ แต่ละชิ้นโชว์ป้ายสถานะของตัวเอง
		Map<Long, Map<String, List<Asset>>> assetsByWarehouse = new HashMap<Long, Map<String, List<Asset>>>();
		List<Asset> assetRows = assetDAO.findByWarehouseIds(subtree);
		if (assetRows != null) {
			for (Asset a : assetRows) {
				if (a == null || a.getWarehouseId() == null) {
					continue;
				}
				Map<String, List<Asset>> byModel = assetsByWarehouse.get(a.getWarehouseId());
				if (byModel == null) {
					byModel = new HashMap<String, List<Asset>>();
					assetsByWarehouse.put(a.getWarehouseId(), byModel);
				}
				String modelKey = (a.getProductId() == null) ? "" : String.valueOf(a.getProductId());
				List<Asset> pieces = byModel.get(modelKey);
				if (pieces == null) {
					pieces = new ArrayList<Asset>();
					byModel.put(modelKey, pieces);
				}
				pieces.add(a);
			}
		}

		Map<Integer, Product> productCache = new HashMap<Integer, Product>();
		Map<String, List<UnitOfMeasure>> unitCache = new HashMap<String, List<UnitOfMeasure>>();
		Map<String, String[]> statusCache = new HashMap<String, String[]>();

		List<Map<String, Object>> sections = new ArrayList<Map<String, Object>>();
		int itemCount = 0;
		for (Long whId : subtree) {
			List<Map<String, Object>> items = new ArrayList<Map<String, Object>>();

			Map<String, Double> byProduct = stockByWarehouse.get(whId);
			if (byProduct != null) {
				for (Map.Entry<String, Double> e : byProduct.entrySet()) {
					double net = e.getValue().doubleValue();
					if (isZero(net)) {
						continue;
					}
					Product p = findProductQuietly(e.getKey(), productCache);
					String name = (p != null) ? productDisplayName(p, productCache) : ("สินค้า #" + e.getKey());
					Map<String, Object> item = line(name, formatAmount(net, unitsOf(p, e.getKey(), unitCache)));
					items.add(item);
				}
			}

			Map<String, List<Equipment>> byModel = equipmentByWarehouse.get(whId);
			if (byModel != null) {
				for (Map.Entry<String, List<Equipment>> e : byModel.entrySet()) {
					String modelKey = e.getKey();
					String name = "ไม่ระบุสินค้า";
					if (!modelKey.isEmpty()) {
						Product p = findProductQuietly(modelKey, productCache);
						name = (p != null) ? productDisplayName(p, productCache) : ("สินค้า #" + modelKey);
					}
					List<Map<String, Object>> unitRows = new ArrayList<Map<String, Object>>();
					for (Equipment eq : e.getValue()) {
						String[] st = lookupStatus(nvl(eq.getStatus()).trim(), statusCache);
						Map<String, Object> unit = new HashMap<String, Object>();
						unit.put("itemNo", nvl(eq.getItemNo()));
						unit.put("serial", nvl(eq.getSerialNo()));
						unit.put("statusText", st[0]);
						unit.put("statusColor", st[1]);
						unitRows.add(unit);
					}
					Map<String, Object> item = line(name, e.getValue().size() + " เครื่อง");
					item.put("units", unitRows);
					items.add(item);
				}
			}

			Map<String, List<Asset>> assetModels = assetsByWarehouse.get(whId);
			if (assetModels != null) {
				for (Map.Entry<String, List<Asset>> e : assetModels.entrySet()) {
					String modelKey = e.getKey();
					String name = "ไม่ระบุรุ่น";
					if (!modelKey.isEmpty()) {
						Product p = findProductQuietly(modelKey, productCache);
						name = (p != null) ? productDisplayName(p, productCache) : ("สินค้า #" + modelKey);
					}
					List<Map<String, Object>> unitRows = new ArrayList<Map<String, Object>>();
					for (Asset a : e.getValue()) {
						Map<String, Object> unit = new HashMap<String, Object>();
						unit.put("itemNo", nvl(a.getItemNo()));
						unit.put("serial", nvl(a.getSerialNo()));
						unit.put("statusText", a.getStatusLabel());
						unit.put("statusColor", "light-" + a.getStatusColor());
						unitRows.add(unit);
					}
					Map<String, Object> item = line(name, e.getValue().size() + " ชิ้น");
					item.put("units", unitRows);
					items.add(item);
				}
			}

			if (items.isEmpty()) {
				continue;
			}
			Collections.sort(items, new Comparator<Map<String, Object>>() {
				public int compare(Map<String, Object> a, Map<String, Object> b) {
					return String.valueOf(a.get("name")).compareTo(String.valueOf(b.get("name")));
				}
			});
			itemCount += items.size();

			boolean isRoot = whId.equals(root.getWarehouseId());
			Map<String, Object> section = new HashMap<String, Object>();
			section.put("isRoot", Boolean.valueOf(isRoot));
			section.put("label", isRoot ? "" : relativePath(whId, root.getWarehouseId(), warehouseById));
			section.put("items", items);
			sections.add(section);
		}
		// ที่เก็บนี้เองขึ้นก่อน ตามด้วยที่เก็บย่อยเรียงตามชื่อ
		Collections.sort(sections, new Comparator<Map<String, Object>>() {
			public int compare(Map<String, Object> a, Map<String, Object> b) {
				boolean ra = Boolean.TRUE.equals(a.get("isRoot"));
				boolean rb = Boolean.TRUE.equals(b.get("isRoot"));
				if (ra != rb) {
					return ra ? -1 : 1;
				}
				return String.valueOf(a.get("label")).compareTo(String.valueOf(b.get("label")));
			}
		});

		attrs.put("qrWarehouseId", root.getWarehouseId());
		attrs.put("qrWarehousePath", pathOf(root.getWarehouseId(), warehouseById));
		attrs.put("qrSections", sections);
		attrs.put("qrItemCount", Integer.valueOf(itemCount));
		attrs.put("qrNodeCount", Integer.valueOf(subtree.size()));
		attrs.put("qrTruncated", Boolean.valueOf(truncated));
	}

	// =====================================================================
	// ตัวช่วยร่วมของ P / W
	// =====================================================================

	private static Map<String, Object> line(String name, String text) {
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("name", name);
		m.put("text", text);
		return m;
	}

	private static Map<Long, Warehouse> warehouseMap(List<Warehouse> warehouses) {
		Map<Long, Warehouse> map = new HashMap<Long, Warehouse>();
		if (warehouses != null) {
			for (Warehouse wh : warehouses) {
				if (wh != null && wh.getWarehouseId() != null) {
					map.put(wh.getWarehouseId(), wh);
				}
			}
		}
		return map;
	}

	/** stock.warehouse_id เป็น varchar: ว่าง/ไม่ใช่ตัวเลข/0 ถือว่า "ไม่ระบุที่เก็บ" */
	private static String warehouseKey(String warehouseId) {
		Long id = parseLongOrNull(warehouseId);
		return (id == null || id.longValue() <= 0L) ? NO_LOCATION_KEY : String.valueOf(id);
	}

	private static Long parseLongOrNull(String text) {
		if (text == null) {
			return null;
		}
		try {
			return Long.valueOf(text.trim());
		} catch (NumberFormatException e) {
			return null;
		}
	}

	/** จำนวนของแถว stock เป็นหน่วยหลัก (amount_convert) ถ้าไม่มีใช้ amount_unit */
	private static double stockAmount(Stock row) {
		if (row.getAmountConvert() != null) {
			return row.getAmountConvert().doubleValue();
		}
		return row.getAmountUnit() != null ? row.getAmountUnit().doubleValue() : 0d;
	}

	private static boolean isZero(double value) {
		return Math.abs(value) < 0.000001d;
	}

	/** เส้นทางเต็มจากข้อมูลที่โหลดไว้แล้ว (ไม่ยิง DB ซ้ำต่อชั้น) */
	private static String pathOf(Long warehouseId, Map<Long, Warehouse> warehouseById) {
		List<String> names = new ArrayList<String>();
		Set<Long> seen = new HashSet<Long>();
		Long current = warehouseId;
		while (current != null && current.longValue() > 0L && names.size() < 12 && seen.add(current)) {
			Warehouse wh = warehouseById.get(current);
			if (wh == null) {
				break;
			}
			names.add(0, nvl(wh.getWarehouseName()));
			current = wh.getParent();
		}
		if (names.isEmpty()) {
			return warehouseId == null ? "ไม่ระบุที่เก็บ" : ("ไม่พบที่เก็บในระบบ (#" + warehouseId + ")");
		}
		return joinNames(names);
	}

	/** เส้นทางของที่เก็บย่อยนับจากที่เก็บที่สแกน (ไม่รวมตัวที่สแกนเอง) เช่น ตู้ 1 › ชั้น 2 */
	private static String relativePath(Long warehouseId, Long rootId, Map<Long, Warehouse> warehouseById) {
		List<String> names = new ArrayList<String>();
		Set<Long> seen = new HashSet<Long>();
		Long current = warehouseId;
		while (current != null && current.longValue() > 0L && !current.equals(rootId) && names.size() < 12 && seen.add(current)) {
			Warehouse wh = warehouseById.get(current);
			if (wh == null) {
				break;
			}
			names.add(0, nvl(wh.getWarehouseName()));
			current = wh.getParent();
		}
		return joinNames(names);
	}

	private static String joinNames(List<String> names) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < names.size(); i++) {
			if (i > 0) {
				sb.append(" › ");
			}
			sb.append(names.get(i));
		}
		return sb.toString();
	}

	/** เรียง sequence (varchar) เป็นตัวเลข ค่าที่ไม่ใช่ตัวเลขไปท้าย */
	private static int compareSequence(String a, String b) {
		Long na = parseLongOrNull(a);
		Long nb = parseLongOrNull(b);
		if (na == null && nb == null) {
			return 0;
		}
		if (na == null) {
			return 1;
		}
		if (nb == null) {
			return -1;
		}
		return na.compareTo(nb);
	}

	/**
	 * หน่วยนับของสินค้า - หน่วยนับผูกไว้ที่ตัวแม่ (ตอนรับเข้า ProductAction.stockAdd เลือกหน่วยจากตัวแม่
	 * แล้วลงแถว stock เป็นของ sub) จึงต้องใช้หน่วยของตัวแม่เมื่อ sub ไม่มีหน่วยของตัวเอง
	 * ไม่งั้นยอดของ sub จะไม่มีชื่อหน่วยและไม่แตกเป็นหน่วยใหญ่
	 */
	private List<UnitOfMeasure> unitsOf(Product product, String fallbackId, Map<String, List<UnitOfMeasure>> cache) {
		if (product == null || product.getProductId() == null) {
			return unitsOf(fallbackId, cache);
		}
		List<UnitOfMeasure> own = unitsOf(String.valueOf(product.getProductId()), cache);
		if (own.isEmpty() && isSubProduct(product)) {
			return unitsOf(nvl(product.getParentProductId()).trim(), cache);
		}
		return own;
	}

	private List<UnitOfMeasure> unitsOf(String productId, Map<String, List<UnitOfMeasure>> cache) {
		List<UnitOfMeasure> units = cache.get(productId);
		if (units == null) {
			units = new ArrayList<UnitOfMeasure>();
			try {
				List<UnitOfMeasure> found = unitOfMeasureDAO.findByProductId(productId);
				if (found != null) {
					units.addAll(found);
				}
			} catch (Exception e) {
				log.warn("unitsOf failed, productId=" + productId, e);
			}
			cache.put(productId, units);
		}
		return units;
	}

	/**
	 * จำนวนเป็นหน่วยหลัก + แตกเป็นหน่วยใหญ่ เช่น 30 ด้าม (2 กล่อง 6 ด้าม)
	 * หน่วยหลัก = sequence 0 (conversion_rate ของหน่วยอื่น = มีกี่หน่วยหลักในหน่วยนั้น)
	 * แตกหน่วยใหญ่เฉพาะจำนวนเต็มที่เป็นบวก
	 */
	private static String formatAmount(double total, List<UnitOfMeasure> units) {
		UnitOfMeasure main = null;
		for (UnitOfMeasure u : units) {
			if ("0".equals(nvl(u.getSequence()).trim())) {
				main = u;
				break;
			}
		}
		if (main == null && !units.isEmpty()) {
			main = units.get(0);
		}
		String mainName = (main != null) ? nvl(main.getUnitName()).trim() : "";

		StringBuilder sb = new StringBuilder(formatNumber(total));
		if (!mainName.isEmpty()) {
			sb.append(' ').append(mainName);
		}

		if (total > 0d && Math.abs(total - Math.rint(total)) < 0.000001d) {
			List<UnitOfMeasure> larger = new ArrayList<UnitOfMeasure>();
			for (UnitOfMeasure u : units) {
				if (u != main && u.getConversionRate() != null && u.getConversionRate().intValue() > 1) {
					larger.add(u);
				}
			}
			Collections.sort(larger, new Comparator<UnitOfMeasure>() {
				public int compare(UnitOfMeasure a, UnitOfMeasure b) {
					return b.getConversionRate().compareTo(a.getConversionRate());
				}
			});
			long remain = Math.round(total);
			List<String> parts = new ArrayList<String>();
			for (UnitOfMeasure u : larger) {
				long rate = u.getConversionRate().longValue();
				long count = remain / rate;
				if (count > 0) {
					parts.add(count + " " + nvl(u.getUnitName()).trim());
					remain -= count * rate;
				}
			}
			if (!parts.isEmpty()) {
				if (remain > 0) {
					parts.add(remain + (mainName.isEmpty() ? "" : " " + mainName));
				}
				sb.append(" (").append(joinWithSpace(parts)).append(')');
			}
		}
		return sb.toString();
	}

	private static String joinWithSpace(List<String> parts) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < parts.size(); i++) {
			if (i > 0) {
				sb.append(' ');
			}
			sb.append(parts.get(i));
		}
		return sb.toString();
	}

	private static String formatNumber(double value) {
		return new DecimalFormat("#,##0.##", DecimalFormatSymbols.getInstance(Locale.ENGLISH)).format(value);
	}

	/** ชื่อสถานะ + สีป้าย (index 0 = ข้อความ, 1 = ชื่อสี Bootstrap) ตามตาราง equipment_status */
	private String[] lookupStatus(String statusCode, Map<String, String[]> cache) {
		String[] cached = cache.get(statusCode);
		if (cached != null) {
			return cached;
		}
		String text = statusCode.isEmpty() ? "-" : statusCode;
		String color = "secondary";
		if (!statusCode.isEmpty()) {
			try {
				EquipmentStatus status = equipmentStatusDAO.findByStatus(statusCode);
				if (status != null) {
					if (status.getDescription() != null && !status.getDescription().trim().isEmpty()) {
						text = status.getDescription();
					}
					// รับเฉพาะชื่อสีที่เป็นตัวอักษร/ตัวเลข/ขีด เพราะค่านี้ถูกต่อเป็นชื่อ class ใน JSP
					String c = status.getColor2() == null ? "" : status.getColor2().trim().toLowerCase();
					if (STATUS_COLOR_PATTERN.matcher(c).matches()) {
						color = c;
					}
				}
			} catch (Exception e) {
				log.warn("lookupStatus failed, status=" + statusCode, e);
			}
		}
		String[] result = new String[] { text, color };
		cache.put(statusCode, result);
		return result;
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
