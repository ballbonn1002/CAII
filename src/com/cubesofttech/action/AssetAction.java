package com.cubesofttech.action;

import java.io.File;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.AssetDAO;
import com.cubesofttech.dao.AssetLogDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.ProductDAO;
import com.cubesofttech.dao.WarehouseDAO;
import com.cubesofttech.model.Asset;
import com.cubesofttech.model.AssetLog;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.Product;
import com.cubesofttech.model.User;
import com.cubesofttech.model.Warehouse;
import com.cubesofttech.service.FileAttachmentService;
import com.cubesofttech.util.QrLinkUtil;
import com.opensymphony.xwork2.ActionSupport;

/**
 * เมนู Assets (รอบ A1): หน้ารายการ + หน้าเพิ่ม/แก้ไข + ลบ
 *  - ทุก method เช็คสิทธิ์ assetlist.view ที่ฝั่ง server (ไม่ใช่แค่ซ่อนเมนู) ไม่มีสิทธิ์ -> result "forbidden"
 *  - Item No. สร้างอัตโนมัติตอนบันทึกครั้งแรก (AST0001, ...) แก้ไม่ได้
 *  - ที่อยู่ (warehouse) เลือกได้ตอนสร้าง หรือตอนแก้ไขถ้ายังไม่เคยระบุ หลังจากนั้นเปลี่ยนผ่าน "ย้ายที่" (assetMoveSave, รอบ A2)
 *  - ย้ายที่ได้หลายชิ้นพร้อมกัน เก็บประวัติลงตาราง asset_log / ชิ้นที่เคยย้ายแล้วลบไม่ได้ (เปลี่ยนสถานะแทน)
 *  - รุ่น = product type '4' (Assets ซึ่งจะเปลี่ยนชื่อเป็น Assets ในรอบ A5) ไม่บังคับ
 */
public class AssetAction extends ActionSupport {

    private static final long serialVersionUID = 1L;
    private static final Logger log = Logger.getLogger(AssetAction.class);

    /** สิทธิ์ของเมนู Assets (authorized_object) - ใช้ทั้งดู เพิ่ม แก้ไข ลบ และย้ายที่ */
    public static final String PERMISSION_VIEW = "assetlist.view";
    /** product_type ของรุ่นที่ผูกกับ Assets ได้ */
    public static final String ASSET_PRODUCT_TYPE = "4";
    private static final String FORBIDDEN = "forbidden";
    private static final String UPLOAD_PAGE = "asset";
    private static final Set<String> IMAGE_EXTENSIONS = new HashSet<String>(
            Arrays.asList("jpg", "jpeg", "png", "gif", "webp"));
    private static final int MAX_TREE_DEPTH = 50;

    private final HttpServletRequest request = ServletActionContext.getRequest();

    @Autowired
    private AssetDAO assetDAO;
    @Autowired
    private ProductDAO productDAO;
    @Autowired
    private WarehouseDAO warehouseDAO;
    @Autowired
    private FileAttachmentService fileAttachmentService;
    @Autowired
    private AssetLogDAO assetLogDAO;
    @Autowired
    private UserDAO userDAO;

    // ---- ค่าจากฟอร์ม (Struts bind ผ่าน setter) ----
    private String assetId;
    /** รหัส Asset หลายตัวคั่นด้วย comma (ใช้ตอนผูก/เอาออกจากรุ่น) */
    private String assetIds;
    private String name;
    private String productId;
    private String serialNo;
    private String warehouseId;
    private String status;
    private String purchaseDate;
    private String price;
    private String note;
    private File image;
    private String imageFileName;
    private String imageContentType;

    // =====================================================================
    // หน้ารายการ
    // =====================================================================

    public String assetList() {
        try {
            if (getOnlineUser() == null) {
                return LOGIN;
            }
            if (!hasPermission()) {
                return FORBIDDEN;
            }

            List<Asset> assets = assetDAO.findAll();
            Map<Long, Warehouse> warehouseById = loadWarehouses();
            Map<Integer, String> productNames = loadProductNames();
            // ชิ้นที่เคยย้ายที่แล้ว = ลบไม่ได้ (ปุ่มลบในรายการถูกปิด)
            Set<Integer> movedIds = assetLogDAO.findMovedAssetIds();

            List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
            Set<String> locationOptions = new TreeSet<String>();
            Set<String> modelOptions = new TreeSet<String>();
            SimpleDateFormat dateFmt = new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH);

            for (Asset a : assets) {
                if (a == null) {
                    continue;
                }
                String location = locationText(a.getWarehouseId(), warehouseById);
                String model = modelText(a.getProductId(), productNames);

                Map<String, Object> row = new HashMap<String, Object>();
                row.put("assetId", a.getAssetId());
                row.put("itemNo", nvl(a.getItemNo()));
                row.put("name", nvl(a.getName()));
                row.put("serialNo", nvl(a.getSerialNo()));
                row.put("model", model);
                row.put("location", location);
                row.put("moved", Boolean.valueOf(movedIds.contains(a.getAssetId())));
                row.put("statusCode", nvl(a.getStatus()));
                row.put("statusLabel", a.getStatusLabel());
                row.put("statusColor", a.getStatusColor());
                row.put("image", nvl(a.getImage()));
                Timestamp updated = (a.getTimeUpdate() != null) ? a.getTimeUpdate() : a.getTimeCreate();
                row.put("updated", (updated != null) ? dateFmt.format(updated) : "-");
                // ไว้เรียงในตาราง (DataTables data-order)
                row.put("updatedSort", (updated != null) ? Long.valueOf(updated.getTime()) : Long.valueOf(0L));
                rows.add(row);

                locationOptions.add(location);
                if (!"-".equals(model)) {
                    modelOptions.add(model);
                }
            }

            // ยอดสรุปตามสถานะ คำนวณฝั่ง server (DataTables เหลือแถวแค่หน้าปัจจุบัน)
            Map<String, Integer> statusCounts = new LinkedHashMap<String, Integer>();
            for (String code : Asset.STATUS_LABELS.keySet()) {
                statusCounts.put(code, Integer.valueOf(0));
            }
            for (Asset a : assets) {
                if (a != null && a.getStatus() != null && statusCounts.containsKey(a.getStatus())) {
                    statusCounts.put(a.getStatus(), Integer.valueOf(statusCounts.get(a.getStatus()).intValue() + 1));
                }
            }

            request.setAttribute("assetRows", rows);
            request.setAttribute("assetTotal", Integer.valueOf(rows.size()));
            request.setAttribute("statusCounts", statusCounts);
            request.setAttribute("statusLabels", Asset.STATUS_LABELS);
            request.setAttribute("statusColors", Asset.STATUS_COLORS);
            request.setAttribute("warehouseOptions", buildWarehouseOptions(warehouseById));
            request.setAttribute("locationOptions", new ArrayList<String>(locationOptions));
            request.setAttribute("modelOptions", new ArrayList<String>(modelOptions));
            request.setAttribute("flash", popFlash());
            return SUCCESS;
        } catch (Exception e) {
            log.error("assetList failed", e);
            return ERROR;
        }
    }

    // =====================================================================
    // หน้าเพิ่ม / แก้ไข
    // =====================================================================

    public String assetAdd() {
        try {
            if (getOnlineUser() == null) {
                return LOGIN;
            }
            if (!hasPermission()) {
                return FORBIDDEN;
            }
            Asset asset = new Asset();
            asset.setStatus(Asset.STATUS_IN_USE);
            putFormAttributes(asset, true);
            return SUCCESS;
        } catch (Exception e) {
            log.error("assetAdd failed", e);
            return ERROR;
        }
    }

    public String assetEdit() {
        try {
            if (getOnlineUser() == null) {
                return LOGIN;
            }
            if (!hasPermission()) {
                return FORBIDDEN;
            }
            Asset asset = assetDAO.findById(parseIntOrNull(request.getParameter("id")));
            if (asset == null) {
                setFlash("danger", "ไม่พบ Asset ที่ต้องการแก้ไข");
                return "list";
            }
            putFormAttributes(asset, false);
            return SUCCESS;
        } catch (Exception e) {
            log.error("assetEdit failed", e);
            return ERROR;
        }
    }

    /** บันทึก: ไม่มี assetId = สร้างใหม่ / มี = แก้ไข (POST เท่านั้น) */
    public String assetSave() {
        try {
            User user = getOnlineUser();
            if (user == null) {
                return LOGIN;
            }
            if (!hasPermission()) {
                return FORBIDDEN;
            }
            if (!"POST".equalsIgnoreCase(request.getMethod())) {
                return "list";
            }

            boolean isNew = isBlank(assetId);
            Asset asset;
            if (isNew) {
                asset = new Asset();
            } else {
                asset = assetDAO.findById(parseIntOrNull(assetId));
                if (asset == null) {
                    setFlash("danger", "ไม่พบ Asset ที่ต้องการแก้ไข");
                    return "list";
                }
            }

            // ---- ตรวจค่าจากฟอร์ม (ผิดข้อแรกที่เจอ แสดงฟอร์มเดิมพร้อมค่าที่กรอกไว้) ----
            String error = null;
            String nameVal = trimToNull(name);
            Integer productIdVal = null;
            Long warehouseIdVal = null;
            java.sql.Date purchaseDateVal = null;
            BigDecimal priceVal = null;

            if (nameVal == null) {
                error = "กรุณากรอกชื่อ";
            } else if (nameVal.length() > 255) {
                error = "ชื่อยาวเกิน 255 ตัวอักษร";
            }
            if (error == null && !isBlank(productId)) {
                productIdVal = parseIntOrNull(productId);
                Product product = (productIdVal != null) ? productDAO.findById(productIdVal) : null;
                if (product == null || !ASSET_PRODUCT_TYPE.equals(nvl(product.getProductType()).trim())) {
                    error = "รุ่นที่เลือกไม่ถูกต้อง";
                }
            }
            if (error == null && !Asset.STATUS_LABELS.containsKey(nvl(status))) {
                error = "กรุณาเลือกสถานะ";
            }
            // ที่อยู่: เลือกได้ตอนสร้าง หรือชิ้นที่ยังไม่เคยระบุที่อยู่ (นอกนั้นต้องใช้ "ย้ายที่")
            boolean canSetLocation = isNew || asset.getWarehouseId() == null;
            if (error == null && canSetLocation && !isBlank(warehouseId)) {
                warehouseIdVal = parseLongOrNull(warehouseId);
                if (warehouseIdVal == null || warehouseDAO.findById(warehouseIdVal) == null) {
                    error = "ที่อยู่ที่เลือกไม่ถูกต้อง";
                }
            }
            if (error == null && !isBlank(purchaseDate)) {
                String text = purchaseDate.trim();
                if (!text.matches("\\d{4}-\\d{2}-\\d{2}")) {
                    error = "รูปแบบวันที่ซื้อไม่ถูกต้อง";
                } else {
                    try {
                        purchaseDateVal = java.sql.Date.valueOf(text);
                    } catch (IllegalArgumentException ex) {
                        error = "รูปแบบวันที่ซื้อไม่ถูกต้อง";
                    }
                }
            }
            if (error == null && !isBlank(price)) {
                try {
                    priceVal = new BigDecimal(price.trim().replace(",", ""));
                    if (priceVal.signum() < 0 || priceVal.precision() - priceVal.scale() > 10) {
                        error = "ราคาไม่ถูกต้อง";
                    }
                    priceVal = priceVal.setScale(2, java.math.RoundingMode.HALF_UP);
                } catch (NumberFormatException ex) {
                    error = "ราคาไม่ถูกต้อง";
                }
            }
            if (error == null && image != null) {
                String ext = extensionOf(imageFileName);
                boolean imageType = imageContentType == null || imageContentType.toLowerCase(Locale.ENGLISH).startsWith("image/");
                if (!IMAGE_EXTENSIONS.contains(ext) || !imageType) {
                    error = "รูปต้องเป็นไฟล์ jpg, png, gif หรือ webp";
                }
            }
            String serialVal = trimToNull(serialNo);
            String noteVal = trimToNull(note);
            if (error == null && serialVal != null && serialVal.length() > 100) {
                error = "Serial ยาวเกิน 100 ตัวอักษร";
            }
            if (error == null && noteVal != null && noteVal.length() > 1000) {
                error = "หมายเหตุยาวเกิน 1000 ตัวอักษร";
            }

            if (error != null) {
                // คืนค่าที่กรอกไว้ให้ฟอร์ม (ไม่บันทึกลง DB)
                Asset draft = new Asset();
                draft.setAssetId(asset.getAssetId());
                draft.setItemNo(asset.getItemNo());
                draft.setImage(asset.getImage());
                draft.setName(name);
                draft.setProductId(parseIntOrNull(productId));
                draft.setSerialNo(serialNo);
                draft.setWarehouseId(canSetLocation ? parseLongOrNull(warehouseId) : asset.getWarehouseId());
                draft.setStatus(status);
                draft.setNote(note);
                putFormAttributes(draft, isNew);
                request.setAttribute("formError", error);
                request.setAttribute("formPurchaseDate", nvl(purchaseDate));
                request.setAttribute("formPrice", nvl(price));
                // ไม่ใช้ INPUT เพราะ Struts คืน "input" เองตอนอัปโหลดไฟล์ไม่ผ่าน (เช่น ไฟล์ใหญ่เกิน)
                // โดยไม่ผ่าน method นี้ ซึ่งหน้าฟอร์มจะไม่มีข้อมูลตัวเลือก - "input" จึง redirect ไปหน้ารายการแทน
                return "invalid";
            }

            Timestamp now = new Timestamp(System.currentTimeMillis());
            asset.setName(nameVal);
            asset.setProductId(productIdVal);
            asset.setSerialNo(serialVal);
            if (canSetLocation) {
                asset.setWarehouseId(warehouseIdVal);
            }
            asset.setStatus(status);
            asset.setPurchaseDate(purchaseDateVal);
            asset.setPrice(priceVal);
            asset.setNote(noteVal);
            asset.setUserUpdate(user.getId());
            asset.setTimeUpdate(now);

            if (isNew) {
                asset.setItemNo(nextItemNo());
                asset.setUserCreate(user.getId());
                asset.setTimeCreate(now);
                assetDAO.save(asset); // ได้ asset_id จาก AUTO_INCREMENT ก่อน แล้วค่อยแนบรูปด้วย id นี้
            }

            if (image != null) {
                List<FileUpload> saved = fileAttachmentService.attach(
                        Arrays.asList(image), Arrays.asList(imageFileName), UPLOAD_PAGE,
                        String.valueOf(asset.getAssetId()), user.getId(),
                        request.getServletContext().getRealPath("/"));
                if (saved != null && !saved.isEmpty() && saved.get(0) != null) {
                    asset.setImage(saved.get(0).getPath());
                }
            }
            assetDAO.update(asset);

            setFlash("success", (isNew ? "เพิ่ม " : "บันทึก ") + asset.getItemNo() + " เรียบร้อย");
            return SUCCESS;
        } catch (Exception e) {
            log.error("assetSave failed, assetId=" + assetId, e);
            return ERROR;
        }
    }

    /** ลบ (POST เท่านั้น) - ลบได้เฉพาะชิ้นที่ยังไม่เคยย้ายที่ ชิ้นที่มีประวัติการย้ายให้เปลี่ยนสถานะแทน */
    public String assetDelete() {
        try {
            if (getOnlineUser() == null) {
                return LOGIN;
            }
            if (!hasPermission()) {
                return FORBIDDEN;
            }
            if (!"POST".equalsIgnoreCase(request.getMethod())) {
                return SUCCESS;
            }
            Asset asset = assetDAO.findById(parseIntOrNull(assetId));
            if (asset == null) {
                setFlash("danger", "ไม่พบ Asset ที่ต้องการลบ");
                return SUCCESS;
            }
            if (assetLogDAO.existsByAssetId(asset.getAssetId())) {
                setFlash("danger", "ลบ " + asset.getItemNo() + " ไม่ได้ เพราะเคยย้ายที่แล้ว (เก็บประวัติไว้) ให้เปลี่ยนสถานะแทน เช่น ชำรุด");
                return SUCCESS;
            }
            String itemNo = asset.getItemNo();
            assetDAO.delete(asset);
            setFlash("success", "ลบ " + itemNo + " เรียบร้อย");
            return SUCCESS;
        } catch (Exception e) {
            log.error("assetDelete failed, assetId=" + assetId, e);
            return ERROR;
        }
    }

    /**
     * ผูก Asset ที่ยังไม่มีรุ่น เข้ากับรุ่น (Product ตัวแม่หรือ sub product ประเภท Assets) ที่กำลังดูอยู่
     * เรียกจากหน้าแก้ไข Product (AJAX POST, ตอบ JSON) รับ productId + assetIds (คั่นด้วย comma)
     * ผูกได้เฉพาะชิ้นที่ยัง "ว่าง" (product_id เป็น NULL) กันแย่งชิ้นที่ผูกกับรุ่นอื่นอยู่แล้ว
     */
    public String assetLinkSave() {
        try {
            User user = getOnlineUser();
            if (user == null) {
                return writeJson(false, "กรุณาเข้าสู่ระบบใหม่");
            }
            if (!hasPermission()) {
                return writeJson(false, "ไม่มีสิทธิ์จัดการ Assets");
            }
            if (!"POST".equalsIgnoreCase(request.getMethod())) {
                return writeJson(false, "รูปแบบการเรียกไม่ถูกต้อง");
            }
            Integer targetId = parseIntOrNull(productId);
            Product target = (targetId != null) ? productDAO.findById(targetId) : null;
            if (target == null || !ASSET_PRODUCT_TYPE.equals(nvl(target.getProductType()).trim())) {
                return writeJson(false, "ไม่พบรุ่นที่จะผูก");
            }
            List<Integer> ids = parseIds(assetIds);
            if (ids.isEmpty()) {
                return writeJson(false, "กรุณาเลือกอย่างน้อย 1 รายการ");
            }
            Timestamp now = new Timestamp(System.currentTimeMillis());
            int linked = 0;
            for (Integer id : ids) {
                Asset asset = assetDAO.findById(id);
                // ข้ามชิ้นที่ไม่พบ หรือถูกผูกกับรุ่นอื่นไปแล้วระหว่างที่หน้าต่างเปิดค้างอยู่
                if (asset == null || asset.getProductId() != null) {
                    continue;
                }
                asset.setProductId(targetId);
                asset.setUserUpdate(user.getId());
                asset.setTimeUpdate(now);
                assetDAO.update(asset);
                linked++;
            }
            if (linked == 0) {
                return writeJson(false, "รายการที่เลือกถูกผูกกับรุ่นอื่นไปแล้ว กรุณาเลือกใหม่");
            }
            return writeJson(true, "ผูก Asset สำเร็จ " + linked + " รายการ");
        } catch (Exception e) {
            log.error("assetLinkSave failed, productId=" + productId, e);
            return writeJson(false, "เกิดข้อผิดพลาด ไม่สามารถบันทึกได้");
        }
    }

    /**
     * เอา Asset ออกจากรุ่น (เคลียร์ asset.product_id) ตัว Asset ไม่ถูกลบ แค่กลับไปเป็นชิ้นที่ยังไม่มีรุ่น
     * รับ productId (รุ่นที่ผูกอยู่) + assetIds (คั่นด้วย comma) เอาออกเฉพาะชิ้นที่ผูกกับรุ่นนี้จริง
     */
    public String assetUnlinkSave() {
        try {
            User user = getOnlineUser();
            if (user == null) {
                return writeJson(false, "กรุณาเข้าสู่ระบบใหม่");
            }
            if (!hasPermission()) {
                return writeJson(false, "ไม่มีสิทธิ์จัดการ Assets");
            }
            if (!"POST".equalsIgnoreCase(request.getMethod())) {
                return writeJson(false, "รูปแบบการเรียกไม่ถูกต้อง");
            }
            Integer targetId = parseIntOrNull(productId);
            if (targetId == null) {
                return writeJson(false, "ไม่พบรุ่น");
            }
            List<Integer> ids = parseIds(assetIds);
            if (ids.isEmpty()) {
                return writeJson(false, "กรุณาเลือกอย่างน้อย 1 รายการ");
            }
            Timestamp now = new Timestamp(System.currentTimeMillis());
            int unlinked = 0;
            for (Integer id : ids) {
                Asset asset = assetDAO.findById(id);
                if (asset == null || !targetId.equals(asset.getProductId())) {
                    continue;
                }
                asset.setProductId(null);
                asset.setUserUpdate(user.getId());
                asset.setTimeUpdate(now);
                assetDAO.update(asset);
                unlinked++;
            }
            if (unlinked == 0) {
                return writeJson(false, "ไม่พบ Asset ที่จะเอาออก");
            }
            return writeJson(true, "เอา Asset ออกแล้ว " + unlinked + " รายการ");
        } catch (Exception e) {
            log.error("assetUnlinkSave failed, productId=" + productId, e);
            return writeJson(false, "เกิดข้อผิดพลาด ไม่สามารถบันทึกได้");
        }
    }

    /**
     * ย้ายที่ Asset หลายชิ้นพร้อมกัน (AJAX POST, ตอบ JSON) รับ assetIds (คั่นด้วย comma) + warehouseId (ที่ใหม่) + note (ไม่บังคับ)
     * ชิ้นที่อยู่ที่ใหม่อยู่แล้วจะถูกข้าม (ไม่เก็บประวัติซ้ำ) / ชิ้นที่ยังไม่เคยระบุที่อยู่ก็ย้ายได้ (ที่เดิม = ว่าง)
     * ทุกชิ้นที่ย้ายจริงจะมี 1 แถวใน asset_log
     */
    public String assetMoveSave() {
        try {
            User user = getOnlineUser();
            if (user == null) {
                return writeJson(false, "กรุณาเข้าสู่ระบบใหม่");
            }
            if (!hasPermission()) {
                return writeJson(false, "ไม่มีสิทธิ์จัดการ Assets");
            }
            if (!"POST".equalsIgnoreCase(request.getMethod())) {
                return writeJson(false, "รูปแบบการเรียกไม่ถูกต้อง");
            }
            Long toId = parseLongOrNull(warehouseId);
            if (toId == null || toId.longValue() == 0L || warehouseDAO.findById(toId) == null) {
                return writeJson(false, "กรุณาเลือกที่อยู่ใหม่");
            }
            List<Integer> ids = parseIds(assetIds);
            if (ids.isEmpty()) {
                return writeJson(false, "กรุณาเลือกอย่างน้อย 1 รายการ");
            }
            String noteVal = trimToNull(note);
            if (noteVal != null && noteVal.length() > 500) {
                return writeJson(false, "หมายเหตุยาวเกิน 500 ตัวอักษร");
            }
            Timestamp now = new Timestamp(System.currentTimeMillis());
            int moved = 0;
            int sameSpot = 0;
            for (Integer id : ids) {
                Asset asset = assetDAO.findById(id);
                if (asset == null) {
                    continue;
                }
                if (toId.equals(asset.getWarehouseId())) {
                    sameSpot++;
                    continue;
                }
                AssetLog logRow = new AssetLog();
                logRow.setAssetId(asset.getAssetId());
                // 0 / NULL = ยังไม่เคยระบุที่อยู่ เก็บเป็น NULL
                Long fromId = asset.getWarehouseId();
                logRow.setFromWarehouseId((fromId == null || fromId.longValue() == 0L) ? null : fromId);
                logRow.setToWarehouseId(toId);
                logRow.setDescription(noteVal);
                logRow.setUserCreate(user.getId());
                logRow.setTimeCreate(now);
                logRow.setUserUpdate(user.getId());
                logRow.setTimeUpdate(now);
                assetLogDAO.save(logRow);

                asset.setWarehouseId(toId);
                asset.setUserUpdate(user.getId());
                asset.setTimeUpdate(now);
                assetDAO.update(asset);
                moved++;
            }
            if (moved == 0) {
                return writeJson(false, sameSpot > 0 ? "รายการที่เลือกอยู่ที่นี่อยู่แล้ว" : "ไม่พบ Asset ที่จะย้าย");
            }
            String msg = "ย้ายที่สำเร็จ " + moved + " รายการ";
            if (sameSpot > 0) {
                msg += " (ข้าม " + sameSpot + " รายการที่อยู่ที่นี่อยู่แล้ว)";
            }
            return writeJson(true, msg);
        } catch (Exception e) {
            log.error("assetMoveSave failed, assetIds=" + assetIds, e);
            return writeJson(false, "เกิดข้อผิดพลาด ไม่สามารถย้ายที่ได้");
        }
    }

    // =====================================================================
    // helper
    // =====================================================================

    /** ตัวเลือกที่อยู่ (id + เส้นทางเต็ม) เรียงตามเส้นทาง ใช้ทั้งฟอร์มและหน้าต่างย้ายที่ */
    private List<Map<String, Object>> buildWarehouseOptions(Map<Long, Warehouse> warehouseById) {
        List<Map<String, Object>> warehouseOptions = new ArrayList<Map<String, Object>>();
        for (Warehouse w : warehouseById.values()) {
            Map<String, Object> opt = new HashMap<String, Object>();
            opt.put("id", w.getWarehouseId());
            opt.put("path", pathOf(w.getWarehouseId(), warehouseById));
            warehouseOptions.add(opt);
        }
        Collections.sort(warehouseOptions, new Comparator<Map<String, Object>>() {
            public int compare(Map<String, Object> x, Map<String, Object> y) {
                return String.valueOf(x.get("path")).compareTo(String.valueOf(y.get("path")));
            }
        });
        return warehouseOptions;
    }

    /** ประวัติการย้ายของชิ้นนี้ เรียงล่าสุดก่อน (ชื่อผู้ย้ายหาไม่เจอก็ใช้รหัสผู้ใช้แทน) */
    private List<Map<String, Object>> buildMoveHistory(Integer assetIdVal, Map<Long, Warehouse> warehouseById) throws Exception {
        List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
        SimpleDateFormat fmt = new SimpleDateFormat("dd MMM yyyy HH:mm", Locale.ENGLISH);
        Map<String, String> userNames = new HashMap<String, String>();
        for (AssetLog m : assetLogDAO.findByAssetId(assetIdVal)) {
            if (m == null) {
                continue;
            }
            String by = nvl(m.getUserCreate());
            if (!by.isEmpty() && !userNames.containsKey(by)) {
                String display = by;
                try {
                    User u = userDAO.findById(by);
                    if (u != null && !isBlank(u.getName())) {
                        display = u.getName().trim();
                    }
                } catch (Exception ex) {
                    log.warn("buildMoveHistory: user lookup failed, id=" + by, ex);
                }
                userNames.put(by, display);
            }
            Map<String, Object> row = new HashMap<String, Object>();
            row.put("movedAt", m.getTimeCreate() != null ? fmt.format(m.getTimeCreate()) : "-");
            row.put("from", locationText(m.getFromWarehouseId(), warehouseById));
            row.put("to", locationText(m.getToWarehouseId(), warehouseById));
            row.put("by", by.isEmpty() ? "-" : userNames.get(by));
            row.put("note", nvl(m.getDescription()));
            rows.add(row);
        }
        return rows;
    }

    /** แยก id หลายค่าคั่นด้วย comma เอาเฉพาะตัวเลขล้วน ตัดซ้ำ จำกัดจำนวนกันส่งมามากผิดปกติ */
    private static List<Integer> parseIds(String text) {
        List<Integer> ids = new ArrayList<Integer>();
        if (text == null || text.trim().isEmpty()) {
            return ids;
        }
        for (String part : text.split(",")) {
            Integer id = parseIntOrNull(part.trim());
            if (id != null && !ids.contains(id) && ids.size() < 500) {
                ids.add(id);
            }
        }
        return ids;
    }

    /** ตอบ JSON {success, message} แล้วคืน NONE (ข้อความถูก escape กัน JSON พัง) */
    private String writeJson(boolean success, String message) {
        try {
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setContentType("application/json;charset=UTF-8");
            String safe = (message == null) ? "" : message.replace("\\", "\\\\").replace("\"", "\\\"");
            response.getWriter().write("{\"success\":" + success + ",\"message\":\"" + safe + "\"}");
            response.getWriter().flush();
        } catch (Exception e) {
            log.error("writeJson failed", e);
        }
        return NONE;
    }

    /** ตัวเลือกในฟอร์ม + ค่าของชิ้นนี้ */
    private void putFormAttributes(Asset asset, boolean isNew) throws Exception {
        Map<Long, Warehouse> warehouseById = loadWarehouses();

        List<Map<String, Object>> warehouseOptions = buildWarehouseOptions(warehouseById);

        List<Map<String, Object>> productOptions = new ArrayList<Map<String, Object>>();
        for (Map.Entry<Integer, String> e : loadProductNames().entrySet()) {
            Map<String, Object> opt = new HashMap<String, Object>();
            opt.put("id", e.getKey());
            opt.put("name", e.getValue());
            productOptions.add(opt);
        }

        boolean canSetLocation = isNew || asset.getWarehouseId() == null;
        request.setAttribute("asset", asset);
        request.setAttribute("isNew", Boolean.valueOf(isNew));
        request.setAttribute("nextItemNo", isNew ? nextItemNo() : null);
        request.setAttribute("canSetLocation", Boolean.valueOf(canSetLocation));
        request.setAttribute("currentLocation", locationText(asset.getWarehouseId(), warehouseById));
        request.setAttribute("warehouseOptions", warehouseOptions);
        request.setAttribute("productOptions", productOptions);
        request.setAttribute("statusLabels", Asset.STATUS_LABELS);
        request.setAttribute("formPurchaseDate", asset.getPurchaseDate() != null ? asset.getPurchaseDate().toString() : "");
        request.setAttribute("formPrice", asset.getPrice() != null ? asset.getPrice().toPlainString() : "");
        // ประวัติการย้ายที่ (เฉพาะชิ้นที่บันทึกแล้ว) + ธงกันลบ: เคยย้ายแล้วลบไม่ได้
        List<Map<String, Object>> moveHistory = new ArrayList<Map<String, Object>>();
        if (!isNew && asset.getAssetId() != null) {
            moveHistory = buildMoveHistory(asset.getAssetId(), warehouseById);
        }
        request.setAttribute("moveHistory", moveHistory);
        request.setAttribute("hasMoves", Boolean.valueOf(!moveHistory.isEmpty()));
        // ปุ่ม Generate QR (เฉพาะชิ้นที่บันทึกแล้ว) ลิงก์ใช้ asset_id ที่ไม่เปลี่ยน
        if (!isNew && asset.getAssetId() != null) {
            request.setAttribute("qrLink", QrLinkUtil.assetLink(request, asset.getAssetId()));
            request.setAttribute("qrLinkConfigured", Boolean.valueOf(QrLinkUtil.isConfigured()));
        }
    }

    /** Item No. ตัวถัดไป เช่น AST0001 (เกิน 9999 ก็ยาวขึ้นเอง) - ข้ามเลขที่มีอยู่แล้วกันชน */
    private String nextItemNo() throws Exception {
        int seq = assetDAO.findMaxItemNoSequence(Asset.ITEM_NO_PREFIX);
        String candidate;
        int guard = 0;
        do {
            seq++;
            candidate = Asset.ITEM_NO_PREFIX + String.format("%04d", Integer.valueOf(seq));
        } while (assetDAO.existsByItemNo(candidate) && ++guard < 100);
        return candidate;
    }

    /** product type '4' ทั้งตัวแม่และ sub (ชื่อ sub = "ตัวแม่ > sub") เรียงตาม DAO */
    private Map<Integer, String> loadProductNames() throws Exception {
        Map<Integer, String> names = new LinkedHashMap<Integer, String>();
        List<Map<String, Object>> rows = productDAO.findByItemsTypeIncludingSubProducts(ASSET_PRODUCT_TYPE);
        if (rows != null) {
            for (Map<String, Object> row : rows) {
                Object id = (row != null) ? row.get("product_id") : null;
                if (id instanceof Number) {
                    names.put(Integer.valueOf(((Number) id).intValue()), nvl(row.get("product_name")).trim());
                }
            }
        }
        return names;
    }

    private Map<Long, Warehouse> loadWarehouses() throws Exception {
        Map<Long, Warehouse> map = new LinkedHashMap<Long, Warehouse>();
        List<Warehouse> list = warehouseDAO.findAll();
        if (list != null) {
            for (Warehouse w : list) {
                if (w != null && w.getWarehouseId() != null) {
                    map.put(w.getWarehouseId(), w);
                }
            }
        }
        return map;
    }

    private String modelText(Integer productIdVal, Map<Integer, String> productNames) {
        if (productIdVal == null) {
            return "-";
        }
        String n = productNames.get(productIdVal);
        return (n != null && !n.isEmpty()) ? n : ("สินค้า #" + productIdVal);
    }

    private String locationText(Long warehouseIdVal, Map<Long, Warehouse> warehouseById) {
        if (warehouseIdVal == null || warehouseIdVal.longValue() == 0L) {
            return "ไม่ระบุที่อยู่";
        }
        return pathOf(warehouseIdVal, warehouseById);
    }

    /** เส้นทางเต็ม เช่น "Cube ITF › ห้องประชุม" (กันวนซ้ำด้วย MAX_TREE_DEPTH) */
    private static String pathOf(Long id, Map<Long, Warehouse> warehouseById) {
        Warehouse w = warehouseById.get(id);
        if (w == null) {
            return "ที่เก็บ #" + id + " (ไม่พบในระบบ)";
        }
        List<String> names = new ArrayList<String>();
        Set<Long> seen = new HashSet<Long>();
        while (w != null && seen.add(w.getWarehouseId()) && names.size() < MAX_TREE_DEPTH) {
            names.add(0, nvl(w.getWarehouseName()).trim());
            Long parent = w.getParent();
            w = (parent == null || parent.longValue() == 0L) ? null : warehouseById.get(parent);
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

    @SuppressWarnings("unchecked")
    private boolean hasPermission() {
        HttpSession session = request.getSession(false);
        Set<String> userAuthority = (session == null) ? null : (Set<String>) session.getAttribute("userAuthority");
        return userAuthority != null && userAuthority.contains(PERMISSION_VIEW);
    }

    private User getOnlineUser() {
        if (request == null || request.getSession(false) == null) {
            return null;
        }
        return (User) request.getSession(false).getAttribute("onlineUser");
    }

    /** ข้อความแจ้งผลหลัง redirect (แสดงครั้งเดียวในหน้ารายการ) */
    private void setFlash(String type, String message) {
        Map<String, String> flash = new HashMap<String, String>();
        flash.put("type", type);
        flash.put("message", message);
        request.getSession().setAttribute("assetFlash", flash);
    }

    private Object popFlash() {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        Object flash = session.getAttribute("assetFlash");
        session.removeAttribute("assetFlash");
        return flash;
    }

    private static String extensionOf(String fileName) {
        if (fileName == null) {
            return "";
        }
        int dot = fileName.lastIndexOf('.');
        return (dot < 0) ? "" : fileName.substring(dot + 1).trim().toLowerCase(Locale.ENGLISH);
    }

    private static Integer parseIntOrNull(String text) {
        if (text == null || !text.trim().matches("\\d{1,9}")) {
            return null;
        }
        return Integer.valueOf(text.trim());
    }

    private static Long parseLongOrNull(String text) {
        if (text == null || !text.trim().matches("\\d{1,18}")) {
            return null;
        }
        return Long.valueOf(text.trim());
    }

    private static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    private static String trimToNull(String s) {
        return isBlank(s) ? null : s.trim();
    }

    private static String nvl(Object o) {
        return (o == null) ? "" : String.valueOf(o);
    }

    // ---- setter สำหรับ Struts ----
    public void setAssetIds(String assetIds) {
        this.assetIds = assetIds;
    }

    public void setAssetId(String assetId) {
        this.assetId = assetId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public void setSerialNo(String serialNo) {
        this.serialNo = serialNo;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setPurchaseDate(String purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public void setImage(File image) {
        this.image = image;
    }

    public void setImageFileName(String imageFileName) {
        this.imageFileName = imageFileName;
    }

    public void setImageContentType(String imageContentType) {
        this.imageContentType = imageContentType;
    }
}
