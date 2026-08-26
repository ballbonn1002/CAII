package com.cubesofttech.action;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.EquipmentDAO;
import com.cubesofttech.dao.EquipmentTypeDAO;
import com.cubesofttech.dao.GoodReceiptDAO;
import com.cubesofttech.dao.GoodReceiptDetailDAO;
import com.cubesofttech.dao.ProductDAO;
import com.cubesofttech.dao.StockDAO;
import com.cubesofttech.dao.UnitOfMeasureDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WarehouseDAO;
import com.cubesofttech.model.Equipment;
import com.cubesofttech.model.GoodReceipt;
import com.cubesofttech.model.GoodReceiptDetail;
import com.cubesofttech.model.Product;
import com.cubesofttech.model.Stock;
import com.cubesofttech.model.UnitOfMeasure;
import com.cubesofttech.model.User;
import com.cubesofttech.model.Warehouse;
import com.cubesofttech.util.DateUtil;
import com.opensymphony.xwork2.ActionSupport;

public class ProductAction extends ActionSupport {
    private static final Logger log = Logger.getLogger(ProductAction.class);
    private static final long serialVersionUID = 1L;

    private final HttpServletRequest request = ServletActionContext.getRequest();
    private final HttpServletResponse response = ServletActionContext.getResponse();
    
    /** ประเภท item ที่บริหารในหน้า stock: 1=Equipment, 2=Consumable, 3=Accessories, 4=Office Supplies */
    private static final java.util.Set<String> STOCK_ITEM_TYPES =
            new java.util.HashSet<String>(java.util.Arrays.asList("1", "2", "3", "4"));

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private UnitOfMeasureDAO unitOfMeasureDAO;

    @Autowired
    private GoodReceiptDAO goodReceiptDAO;

    @Autowired
    private GoodReceiptDetailDAO goodReceiptDetailDAO;

    @Autowired
    private WarehouseDAO warehouseDAO;

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private StockDAO stockDAO;

    @Autowired
    private EquipmentDAO equipmentDAO;

    @Autowired
    private EquipmentTypeDAO equipmentTypeDAO;

    private Integer productId;
    private String productNo;
    private String productName;
    private String productType;
    private String description;
    private String active;

    // ---- fields สำหรับ Unit of Measure (UOM) ----
    private Integer unitId;
    private String unitName;
    private Integer conversionRate;
    private String sequence;

    // ---- fields สำหรับ Sub product ----
    private String parentProductId;
    private Integer subProductId;
    private String subProductActive;

    // ---- reorder (SortableJS ส่ง id คั่นด้วย comma) ----
    private String orderedIds;

    // ---- field รับค่าจาก dropdown Equipment Type ในหน้า add (เมื่อ productType = '1') ----
    private String equipmentType;

    // ---- popup เลือกเครื่องมาผูกกับ catalog Equipment - ส่ง equipment_id คั่นด้วย comma ----
    private String equipmentIds;

    // ---- fields สำหรับ Add Stock (บันทึกรับเข้า/Good Receipt) ในหน้า Stock Balance ----
    private String warehouseId;
    private String refNo;
    private String receiveDate;

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getActive() {
        return active;
    }

    public void setActive(String active) {
        this.active = active;
    }

    public Integer getUnitId() {
        return unitId;
    }

    public void setUnitId(Integer unitId) {
        this.unitId = unitId;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public Integer getConversionRate() {
        return conversionRate;
    }

    public void setConversionRate(Integer conversionRate) {
        this.conversionRate = conversionRate;
    }

    public String getSequence() {
        return sequence;
    }

    public void setSequence(String sequence) {
        this.sequence = sequence;
    }

    public String getParentProductId() {
        return parentProductId;
    }

    public void setParentProductId(String parentProductId) {
        this.parentProductId = parentProductId;
    }

    public Integer getSubProductId() {
        return subProductId;
    }

    public void setSubProductId(Integer subProductId) {
        this.subProductId = subProductId;
    }

    public String getSubProductActive() {
        return subProductActive;
    }

    public void setSubProductActive(String subProductActive) {
        this.subProductActive = subProductActive;
    }

    public String getOrderedIds() {
        return orderedIds;
    }

    public void setOrderedIds(String orderedIds) {
        this.orderedIds = orderedIds;
    }

    public String getEquipmentType() {
        return equipmentType;
    }

    public void setEquipmentType(String equipmentType) {
        this.equipmentType = equipmentType;
    }

    public String getEquipmentIds() {
        return equipmentIds;
    }

    public void setEquipmentIds(String equipmentIds) {
        this.equipmentIds = equipmentIds;
    }

    public String getProductNo() {
        return productNo;
    }

    public void setProductNo(String productNo) {
        this.productNo = productNo;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
    }

    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }

    public String getReceiveDate() {
        return receiveDate;
    }

    public void setReceiveDate(String receiveDate) {
        this.receiveDate = receiveDate;
    }

    public String stockConsList() {
        try {
            // null = เอาทุก type (1 Equipment / 2 Consumables / 3 Accessory) มาแสดงรวมในตารางเดียว
            List<Map<String, Object>> products = productDAO.findAllWithSubProducts(null);
            if (products == null) {
                products = new ArrayList<Map<String, Object>>();
            }

            fillMainUnits(products);

            //log.debug(products);
            request.setAttribute("products", products);
            request.setAttribute("typeCounts", countByType(products));

            return SUCCESS;
        } catch (Exception e) {
            log.error("stockConsList failed", e);
            return ERROR;
        }
    }

    /**
     * นับจำนวน product แยกตาม type ฝั่ง server สำหรับการ์ดสรุปด้านบนหน้า list
     * (เดิม JSP นับจาก DOM ซึ่งจะผิดทันทีที่เปลี่ยนไปทำ paging ฝั่ง server)
     * คืน map ที่มี key ครบทุก type เสมอ JSP จะได้ไม่ต้องเช็ค null
     */
    private Map<String, Integer> countByType(List<Map<String, Object>> products) {
        Map<String, Integer> counts = new HashMap<String, Integer>();
        for (String type : STOCK_ITEM_TYPES) {
            counts.put(type, Integer.valueOf(0));
        }
        if (products == null) {
            return counts;
        }

        for (Map<String, Object> product : products) {
            if (product == null) {
                continue;
            }
            Object rawType = product.get("product_type");
            if (rawType == null) {
                continue;
            }
            Integer current = counts.get(String.valueOf(rawType).trim());
            if (current != null) {
                // type ที่ไม่รู้จักปล่อยผ่าน - ยังโชว์ในตารางแต่ไม่นับเข้าการ์ดใบไหน
                counts.put(String.valueOf(rawType).trim(), Integer.valueOf(current.intValue() + 1));
            }
        }
        return counts;
    }

    /**
     * เติม unit_id / unit_name (unit หลัก sequence = '0') ให้กับ product แต่ละแถว
     * ดึงครั้งเดียวด้วย IN (...) เพื่อกัน N+1 query
     */
    private void fillMainUnits(List<Map<String, Object>> products) throws Exception {
        if (products == null || products.isEmpty()) {
            return;
        }

        // unit_of_measure.product_id เป็น varchar จึงเทียบกันด้วย String
        List<String> productIds = new ArrayList<String>();
        for (Map<String, Object> product : products) {
            Object rawProductId = (product != null) ? product.get("product_id") : null;
            if (rawProductId != null) {
                productIds.add(String.valueOf(rawProductId));
            }
        }

        Map<String, UnitOfMeasure> mainUnitByProductId = new HashMap<String, UnitOfMeasure>();
        List<UnitOfMeasure> mainUnits = unitOfMeasureDAO.findMainUnitsByProductIds(productIds);
        if (mainUnits != null) {
            for (UnitOfMeasure unit : mainUnits) {
                if (unit == null || unit.getProductId() == null) {
                    continue;
                }
                String key = unit.getProductId().trim();
                // ถ้าข้อมูลซ้ำ (sequence = '0' หลายแถว) ให้ยึดแถวแรกตาม unit_id
                if (!mainUnitByProductId.containsKey(key)) {
                    mainUnitByProductId.put(key, unit);
                }
            }
        }

        for (Map<String, Object> product : products) {
            if (product == null) {
                continue;
            }
            Object rawProductId = product.get("product_id");
            UnitOfMeasure unit = (rawProductId != null)
                    ? mainUnitByProductId.get(String.valueOf(rawProductId))
                    : null;

            product.put("unit_id", (unit != null) ? unit.getUnitId() : null);
            product.put("unit_name", (unit != null) ? unit.getUnitName() : null);
        }
    }

    /**
     * หน้า Stock By Product - ตอนนี้เป็น UI mockup อย่างเดียว (ข้อมูลในตาราง static demo)
     * TODO: ต่อ query สรุปยอดคงเหลือต่อสินค้าจริงเมื่อ requirement คอลัมน์/filter นิ่งแล้ว
     */
    public String showStockByProductPage() {
        try {
            if (getOnlineUser() == null) {
                log.warn("showStockByProductPage: no online user in session");
                return ERROR;
            }
            return SUCCESS;
        } catch (Exception e) {
            log.error("showStockByProductPage failed", e);
            return ERROR;
        }
    }

    /**
     * หน้า Stock By Location - ตอนนี้เป็น UI mockup อย่างเดียว (ข้อมูลในตาราง static demo)
     * TODO: ต่อ query สรุปยอดคงเหลือต่อคลัง (warehouse, รองรับ parent/child) เมื่อ requirement นิ่งแล้ว
     */
    public String showStockByLocationPage() {
        try {
            if (getOnlineUser() == null) {
                log.warn("showStockByLocationPage: no online user in session");
                return ERROR;
            }
            return SUCCESS;
        } catch (Exception e) {
            log.error("showStockByLocationPage failed", e);
            return ERROR;
        }
    }

    public String showStockAddPage() {
        try {
            if (getOnlineUser() == null) {
                log.warn("showStockAddPage: no online user in session");
                return ERROR;
            }

            // ใช้เติม dropdown Equipment Type ที่โผล่เมื่อเลือก Item Type = Equipment (type '1')
            request.setAttribute("equipmentTypes", equipmentTypeDAO.getall());

            return SUCCESS;
        } catch (Exception e) {
            log.error("showStockAddPage failed", e);
            return ERROR;
        }
    }

    public String showStockEditPage() {
        try {
            if (getOnlineUser() == null) {
                log.warn("showStockEditPage: no online user in session");
                return ERROR;
            }
            if (productId == null) {
                log.warn("showStockEditPage: productId is required");
                return ERROR;
            }

            Product product = productDAO.findById(productId);
            if (product == null) {
                log.warn("showStockEditPage: product not found, productId=" + productId);
                return ERROR;
            }
            // กันการยิง id ของ product ประเภทอื่น หรือ sub-product เข้ามาที่หน้านี้
            if (!isEditableStockItem(product)) {
                log.warn("showStockEditPage: not a consumable, productId=" + productId
                        + ", productType=" + product.getProductType());
                return ERROR;
            }

            // unit_of_measure.product_id เป็น varchar จึงส่งเป็น String
            List<UnitOfMeasure> units = unitOfMeasureDAO.findByProductId(String.valueOf(productId));
            // parent_product_id เป็น varchar จึงส่งเป็น String
            List<Product> subProducts = productDAO.findByParentProductIds(
                    Collections.singletonList(String.valueOf(productId)));
            // findByParentProductIds ไม่ได้ order มา - เรียงตาม sequence (varchar) แบบตัวเลขที่ฝั่ง app
            sortBySequence(subProducts);

            request.setAttribute("product", product);
            request.setAttribute("units", units);
            request.setAttribute("subProducts", subProducts);
            // ใช้เติม dropdown Equipment Type - โผล่เฉพาะตอน Item Type = Equipment (type '1')
            request.setAttribute("equipmentTypes", equipmentTypeDAO.getall());

            // Equipment เท่านั้นที่ต้องมีตัวเลือกผูกเครื่องจริง - รองรับทั้งมี sub product (ผูกแยกตามรุ่น)
            // และไม่มี sub product เลย (ผูกตรงกับตัวแม่ได้เหมือนเดิม) แสดงรวมในการ์ด "Sub product"
            // เดียวกัน (badge จำนวนเครื่อง + expand ดู serial/status ต่อแถว)
            if (isEquipmentProduct(product)) {
                // จำนวนเครื่องต่อแถว (ตัวแม่ + sub product ทุกตัว) - นับด้วย SQL subquery ฝั่ง server
                Map<Integer, Integer> equipmentCounts = productDAO.countEquipmentByParentAndSubProducts(productId);
                request.setAttribute("equipmentCounts", equipmentCounts);

                int totalEquipmentCount = 0;
                for (Integer count : equipmentCounts.values()) {
                    totalEquipmentCount += (count != null) ? count.intValue() : 0;
                }
                request.setAttribute("totalEquipmentCount", Integer.valueOf(totalEquipmentCount));
                // ดึงแยกไว้ตัวเดียวกันความยุ่งยากของ EL เวลาต้อง fallback ค่า null เป็น 0 ซ้ำๆ ใน JSP
                Integer parentCount = equipmentCounts.get(productId);
                request.setAttribute("parentEquipmentCount", parentCount != null ? parentCount : Integer.valueOf(0));

                // ข้อมูลรายเครื่อง (serial/status) ต่อแถว ใช้ตอน expand ดูรายละเอียด - reuse ตัวเดียวกับ
                // หน้า Stock Balance (buildEquipmentGroupsForCatalog) แค่แปลงเป็น map key productId ให้ lookup ง่าย
                Map<Integer, Map<String, Object>> equipmentDetailByProductId =
                        new LinkedHashMap<Integer, Map<String, Object>>();
                for (Map<String, Object> group : buildEquipmentGroupsForCatalog(product, subProducts)) {
                    Integer key = Integer.valueOf((String) group.get("productId"));
                    equipmentDetailByProductId.put(key, group);
                }
                request.setAttribute("equipmentDetailByProductId", equipmentDetailByProductId);

                // เครื่องที่ยังไม่ผูกกับ catalog ไหนเลย - ใช้เป็นตัวเลือกใน popup
                request.setAttribute("unlinkedEquipment", equipmentDAO.findUnlinked());
            }

            return SUCCESS;
        } catch (Exception e) {
            log.error("showStockEditPage failed, productId=" + productId, e);
            return ERROR;
        }
    }

    /**
     * ผูกเครื่องจริง (equipment) ที่เลือกจาก popup เข้ากับ catalog Equipment ที่กำลังแก้ไขอยู่
     * ตั้งค่า equipment.product_id ให้แต่ละเครื่องที่เลือก แล้วตอบ JSON ให้ฝั่ง UI โชว์ SweetAlert
     *
     * ลิงก์ได้เฉพาะเครื่องที่ยัง "ว่าง" (product_id ยังไม่มีค่า) เท่านั้น กันไม่ให้แย่งเครื่อง
     * ที่ผูกกับ catalog อื่นอยู่แล้วไปโดยไม่ตั้งใจ (เช่น เปิด popup ค้างไว้หลายแท็บ)
     */
    public String stockEquLinkSave() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                log.warn("stockEquLinkSave: no online user in session");
                return writeJson(false, "unauthorized");
            }
            if (productId == null) {
                log.warn("stockEquLinkSave: productId is required");
                return writeJson(false, "productId required");
            }
            // ผูกได้ทั้งตัวแม่หรือ sub product ของ Equipment (เครื่องผูกกับ sub product เป็นหลักตั้งแต่ 25/08/2026)
            Product product = productDAO.findById(productId);
            if (product == null || !isEquipmentProduct(product)) {
                log.warn("stockEquLinkSave: invalid equipment catalog, productId=" + productId);
                return writeJson(false, "ไม่พบข้อมูล catalog");
            }

            List<Integer> ids = parseIds(equipmentIds);
            if (ids.isEmpty()) {
                return writeJson(false, "กรุณาเลือกอย่างน้อย 1 รายการ");
            }

            String productIdText = String.valueOf(productId);
            java.sql.Timestamp now = DateUtil.getCurrentTime();
            int linked = 0;
            for (Integer equipmentId : ids) {
                Equipment equipment = equipmentDAO.getById(equipmentId.intValue());
                // ข้ามเครื่องที่ไม่พบ หรือถูกผูกกับ catalog อื่นไปแล้วระหว่างที่ popup เปิดค้างอยู่
                if (equipment == null || !isBlank(equipment.getProductId())) {
                    continue;
                }
                equipment.setProductId(productIdText);
                equipment.setUserUpdate(onlineUser.getId());
                equipment.setTimeUpdate(now);
                equipmentDAO.update(equipment);
                linked++;
            }

            if (linked == 0) {
                log.warn("stockEquLinkSave: nothing linked (already taken?), productId=" + productId
                        + ", requestedIds=" + equipmentIds);
                return writeJson(false, "รายการที่เลือกถูกผูกกับ catalog อื่นไปแล้ว กรุณาเลือกใหม่");
            }

            return writeJson(true, "เพิ่มเครื่องสำเร็จ " + linked + " รายการ");
        } catch (Exception e) {
            log.error("stockEquLinkSave failed, productId=" + productId, e);
            return writeJson(false, "เกิดข้อผิดพลาด ไม่สามารถบันทึกได้");
        }
    }

    /**
     * ยกเลิกการผูกเครื่อง (equipment) ออกจาก catalog - เคลียร์ equipment.product_id
     * เครื่องไม่ได้ถูกลบ แค่เอาออกจาก catalog นี้ จะกลับไปเป็นเครื่องที่ยังไม่ผูก
     * รองรับ equipmentIds หลายค่าคั่นด้วย comma (reuse field เดียวกับ stockEquLinkSave)
     */
    public String stockEquUnlinkSave() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                log.warn("stockEquUnlinkSave: no online user in session");
                return writeJson(false, "unauthorized");
            }
            if (productId == null) {
                log.warn("stockEquUnlinkSave: productId is required");
                return writeJson(false, "productId required");
            }
            // เอาออกได้ทั้งจากตัวแม่หรือ sub product ของ Equipment (เหมือน stockEquLinkSave)
            Product product = productDAO.findById(productId);
            if (product == null || !isEquipmentProduct(product)) {
                log.warn("stockEquUnlinkSave: invalid equipment catalog, productId=" + productId);
                return writeJson(false, "ไม่พบข้อมูล catalog");
            }

            List<Integer> ids = parseIds(equipmentIds);
            if (ids.isEmpty()) {
                return writeJson(false, "กรุณาเลือกอย่างน้อย 1 รายการ");
            }

            String productIdText = String.valueOf(productId);
            java.sql.Timestamp now = DateUtil.getCurrentTime();
            int unlinked = 0;
            for (Integer equipmentId : ids) {
                Equipment equipment = equipmentDAO.getById(equipmentId.intValue());
                if (equipment == null || !productIdText.equals(equipment.getProductId())) {
                    continue;
                }
                equipment.setProductId(null);
                equipment.setUserUpdate(onlineUser.getId());
                equipment.setTimeUpdate(now);
                equipmentDAO.update(equipment);
                unlinked++;
            }

            if (unlinked == 0) {
                log.warn("stockEquUnlinkSave: nothing unlinked, productId=" + productId
                        + ", requestedIds=" + equipmentIds);
                return writeJson(false, "ไม่พบเครื่องที่จะเอาออก");
            }

            return writeJson(true, "เอาเครื่องออกแล้ว " + unlinked + " รายการ");
        } catch (Exception e) {
            log.error("stockEquUnlinkSave failed, productId=" + productId, e);
            return writeJson(false, "เกิดข้อผิดพลาด ไม่สามารถบันทึกได้");
        }
    }

    /**
     * เช็ค Item ID (product_no) ซ้ำ ใช้ตอนกรอกฟอร์มในหน้า add/edit (AJAX)
     * ตอน edit ต้องส่ง productId ของตัวเองมาด้วย กันเช็คซ้ำกับตัวมันเอง
     * success = true หมายถึง "ไม่ซ้ำ ใช้ได้" / false หมายถึง "ซ้ำ" หรือเกิด error
     */
    public String stockCheckProductNoDuplicate() {
        try {
            if (isBlank(productNo)) {
                return writeJson(false, "กรุณากรอก Item ID");
            }
            boolean duplicate = productDAO.existsByProductNo(productNo, productId);
            if (duplicate) {
                return writeJson(false, "Item ID นี้มีอยู่แล้วในระบบ กรุณาใช้ชื่ออื่น");
            }
            return writeJson(true, null);
        } catch (Exception e) {
            log.error("stockCheckProductNoDuplicate failed, productNo=" + productNo, e);
            return writeJson(false, "เกิดข้อผิดพลาด ไม่สามารถตรวจสอบได้");
        }
    }

    /**
     * หน้า Stock Balance ของ consumable หนึ่งตัว
     *  - historiesIn : ประวัติรับเข้า (IN) จากตาราง good_receipt (+ good_receipt_detail)
     *  - subProducts : รายการ sub product จากตาราง product
     *  - warehouses  : คลังจากตาราง warehouse
     *  - balances / sizeSummaries : ยอดรับเข้าสรุปตาม sub product x warehouse (คำนวณจาก IN)
     */
    public String showStockBalancePage() {
        try {
            if (getOnlineUser() == null) {
                log.warn("showStockBalancePage: no online user in session");
                return ERROR;
            }
            if (productId == null) {
                log.warn("showStockBalancePage: productId is required");
                return ERROR;
            }

            Product product = productDAO.findById(productId);
            if (product == null) {
                log.warn("showStockBalancePage: product not found, productId=" + productId);
                return ERROR;
            }
            if (!isEditableStockItem(product)) {
                log.warn("showStockBalancePage: not a consumable, productId=" + productId
                        + ", productType=" + product.getProductType());
                return ERROR;
            }
            // Equipment ยอดคงเหลือคิดจากเครื่องจริง ไม่ใช่จากตาราง stock - ต้องไป stock_equ_balance
            // ถ้าปล่อยผ่าน หน้านี้จะโชว์ยอด 0 ทั้งที่มีเครื่องอยู่ ซึ่งทำให้เข้าใจผิด
            if ("1".equals(product.getProductType().trim())) {
                log.warn("showStockBalancePage: equipment must use stock_equ_balance, productId=" + productId);
                return ERROR;
            }

            String productIdStr = String.valueOf(productId);

            // (2) sub product จากตาราง product / (3) warehouse จากตาราง warehouse
            List<Product> subProducts = productDAO.findByParentProductIds(
                    Collections.singletonList(productIdStr));
            List<Warehouse> warehouses = warehouseDAO.findAll();
            if (subProducts == null) {
                subProducts = new ArrayList<Product>();
            }
            if (warehouses == null) {
                warehouses = new ArrayList<Warehouse>();
            }
            // (1)(2) เรียง sub product ตาม sequence ให้ทั้งปุ่มกรองไซซ์และตารางยอดคงเหลือเรียงตรงกัน
            sortSubProductsBySequence(subProducts);

            // หน่วยนับ (unit) ของ product นี้ เรียงตาม sequence (ตัวแรก = unit หลัก) ใช้กับ dropdown ใน modal Add Stock
            List<UnitOfMeasure> units = unitOfMeasureDAO.findByProductId(productIdStr);
            if (units == null) {
                units = new ArrayList<UnitOfMeasure>();
            }

            // ไม่มี sub product จริง -> ใช้ตัวแม่เองเป็นกลุ่มเดียวแทน กันยอด/ประวัติรับเข้าหายไปจากหน้านี้
            // (สอดคล้องกับ stockConsStockAdd ที่ fallback ไปผูกกับตัวแม่โดยตรงเมื่อไม่มี sub product)
            List<Product> balanceGroups = subProducts.isEmpty() ? Collections.singletonList(product) : subProducts;

            // (3) จำนวนคงเหลือต่อ sub product ดึงจาก stock.reconcile (แถวล่าสุด)
            Map<String, Double> reconcileBySub = buildReconcileBySubProduct(balanceGroups);

            // ประวัติรับเข้า (IN) จาก good_receipt (ใช้กับ History + รายการแยกคลัง)
            List<Map<String, Object>> inRows = goodReceiptDAO.findInHistoryByParentProductId(productIdStr);

            Map<String, String> subNameById = buildSubProductNameMap(balanceGroups);
            Map<String, String> whNameById = buildWarehouseNameMap(warehouses);
            Map<String, String> userNameById = buildUserDisplayMap(inRows);

            List<Map<String, Object>> historiesIn = buildHistoriesIn(inRows, subNameById, whNameById, userNameById);
            List<Map<String, Object>> balances = buildBalances(balanceGroups, warehouses, inRows, whNameById, reconcileBySub);
            List<Map<String, Object>> sizeSummaries = buildSizeSummaries(balanceGroups, reconcileBySub);

            request.setAttribute("product", product);
            request.setAttribute("subProducts", subProducts);
            request.setAttribute("warehouses", warehouses);
            request.setAttribute("units", units);
            request.setAttribute("historiesIn", historiesIn);
            // ยังไม่มีแหล่งข้อมูลฝั่งเบิกออก (OUT) - ส่ง list ว่างไปก่อน
            request.setAttribute("historiesOut", new ArrayList<Map<String, Object>>());
            request.setAttribute("balances", balances);
            request.setAttribute("sizeSummaries", sizeSummaries);

            return SUCCESS;
        } catch (Exception e) {
            log.error("showStockBalancePage failed, productId=" + productId, e);
            return ERROR;
        }
    }

    /**
     * บันทึกรับเข้าสต็อก (ปุ่ม Add Stock ในหน้า Stock Balance ของ consumable/accessory/office supply)
     * สร้างเอกสาร good_receipt (หัวใบ) + good_receipt_detail (1 แถวต่อ sub product ที่กรอกจำนวน)
     * แล้วค่อยลงบัญชีใน stock (action_type = gr_issue) ตามเอกสารนั้น
     * - ห้าม UPDATE ตาราง stock ตรงๆ นอกเอกสาร (ดู skill product-module) ทุกความเคลื่อนไหวต้องมาจากการ insert นี้เท่านั้น
     * - รองรับทั้งกรณีมี sub product (amount_&lt;subProductId&gt; ต่อแถว) และไม่มี sub product
     *   (amount_&lt;productId&gt; ของตัวแม่เอง - ดู fallback ในหน้า stock_cons_balance.jsp และ showStockBalancePage)
     */
    public String stockConsStockAdd() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                log.warn("stockConsStockAdd: no online user in session");
                return ERROR;
            }
            if (productId == null || isBlank(warehouseId) || unitId == null) {
                log.warn("stockConsStockAdd: productId/warehouseId/unitId is required");
                return ERROR;
            }

            Product product = productDAO.findById(productId);
            if (product == null || !isEditableStockItem(product) || isEquipmentProduct(product)) {
                log.warn("stockConsStockAdd: product not found or not a consumable/accessory/office item, productId="
                        + productId);
                return ERROR;
            }

            // unit ต้องเป็นของ product นี้จริง กัน unitId ปลอมจาก client + เอา conversionRate มาคำนวณ amount_convert
            List<UnitOfMeasure> units = unitOfMeasureDAO.findByProductId(String.valueOf(productId));
            UnitOfMeasure selectedUnit = null;
            if (units != null) {
                for (UnitOfMeasure u : units) {
                    if (u != null && unitId.equals(u.getUnitId())) {
                        selectedUnit = u;
                        break;
                    }
                }
            }
            if (selectedUnit == null) {
                log.warn("stockConsStockAdd: unitId does not belong to product, productId=" + productId
                        + ", unitId=" + unitId);
                return ERROR;
            }
            int conversionRateVal = (selectedUnit.getConversionRate() != null)
                    ? selectedUnit.getConversionRate().intValue() : 1;

            String productIdStr = String.valueOf(productId);
            List<Product> subProducts = productDAO.findByParentProductIds(Collections.singletonList(productIdStr));
            if (subProducts == null) {
                subProducts = new ArrayList<Product>();
            }

            // target product id -> จำนวนที่กรอก (เฉพาะแถวที่กรอกมากกว่า 0)
            // มี sub product = แยกจำนวนต่อ sub / ไม่มี sub = ใช้ตัวแม่เป็นบรรทัดเดียว (amount_<parentProductId>)
            LinkedHashMap<String, Double> amountByTargetId = new LinkedHashMap<String, Double>();
            if (!subProducts.isEmpty()) {
                for (Product sub : subProducts) {
                    if (sub == null || sub.getProductId() == null) {
                        continue;
                    }
                    String key = String.valueOf(sub.getProductId());
                    double amount = toDouble(request.getParameter("amount_" + key));
                    if (amount > 0) {
                        amountByTargetId.put(key, Double.valueOf(amount));
                    }
                }
            } else {
                double amount = toDouble(request.getParameter("amount_" + productIdStr));
                if (amount > 0) {
                    amountByTargetId.put(productIdStr, Double.valueOf(amount));
                }
            }

            if (amountByTargetId.isEmpty()) {
                log.warn("stockConsStockAdd: no positive amount entered, productId=" + productId);
                return ERROR;
            }

            java.sql.Timestamp now = DateUtil.getCurrentTime();
            java.sql.Timestamp receiveTs = now;
            if (!isBlank(receiveDate)) {
                Date parsed = DateUtil.stringToDate(receiveDate.trim(), "yyyy-MM-dd", Locale.ENGLISH);
                if (parsed != null) {
                    receiveTs = new java.sql.Timestamp(parsed.getTime());
                }
            }

            // ---- (1) หัวใบ good_receipt ----
            Integer newGrId = Integer.valueOf(goodReceiptDAO.getMaxId().intValue() + 1);
            GoodReceipt gr = new GoodReceipt();
            gr.setGoodReceiptId(newGrId);
            gr.setGrRef(trimToNull(refNo));
            gr.setReceiveDate(receiveTs);
            gr.setRecipientUser(onlineUser.getId());
            gr.setWarehouseId(warehouseId.trim());
            gr.setUserCreate(onlineUser.getId());
            gr.setTimeCreate(now);
            gr.setUserUpdate(onlineUser.getId());
            gr.setTimeUpdate(now);
            goodReceiptDAO.save(gr);

            // ---- (2) รายการ good_receipt_detail + (3) ลงบัญชี stock ต่อบรรทัด ----
            long nextDetailId = goodReceiptDetailDAO.getMaxId().longValue() + 1;
            long nextStockId = stockDAO.getMaxId().longValue() + 1;

            for (Map.Entry<String, Double> entry : amountByTargetId.entrySet()) {
                String targetProductId = entry.getKey();
                double amount = entry.getValue().doubleValue();
                double amountConvert = amount * conversionRateVal;

                GoodReceiptDetail detail = new GoodReceiptDetail();
                detail.setGoodReceiptDetailId(Integer.valueOf((int) nextDetailId));
                detail.setGoodReceiptId(String.valueOf(newGrId));
                detail.setProductId(targetProductId);
                detail.setParent(productIdStr);
                detail.setAmount(Double.valueOf(amount));
                detail.setUnit(String.valueOf(unitId));
                detail.setWarehouseId(warehouseId.trim());
                detail.setUserCreate(onlineUser.getId());
                detail.setTimeCreate(now);
                detail.setUserUpdate(onlineUser.getId());
                detail.setTimeUpdate(now);
                goodReceiptDetailDAO.save(detail);
                nextDetailId++;

                // reconcile = ผลรวมกระทบยอดล่าสุดของ product นั้น + จำนวนที่รับเข้ารอบนี้ (คิดเป็น unit หลัก)
                Stock latest = stockDAO.findLatestByProductId(targetProductId);
                double previousReconcile = (latest != null && latest.getReconcile() != null)
                        ? latest.getReconcile().doubleValue() : 0d;

                Stock stock = new Stock();
                stock.setStockId(String.valueOf(nextStockId));
                stock.setProductId(targetProductId);
                stock.setActionType("gr_issue");
                stock.setActionRef(String.valueOf(newGrId));
                stock.setUnit(String.valueOf(unitId));
                stock.setAmountUnit(Double.valueOf(amount));
                stock.setAmountConvert(Double.valueOf(amountConvert));
                stock.setReconcile(Double.valueOf(previousReconcile + amountConvert));
                stock.setWarehouseId(warehouseId.trim());
                stock.setUserCreate(onlineUser.getId());
                stock.setTimeCreate(now);
                stock.setUserUpdate(onlineUser.getId());
                stock.setTimeUpdate(now);
                stockDAO.save(stock);
                nextStockId++;
            }

            return SUCCESS;
        } catch (Exception e) {
            log.error("stockConsStockAdd failed, productId=" + productId, e);
            return ERROR;
        }
    }

    /**
     * หน้า Stock Balance ฝั่ง Equipment
     *
     * ไม่ใช้ showStockBalancePage() ร่วมกัน เพราะยอดคงเหลือของ equipment คือ
     * "จำนวนเครื่องจริง" ที่ผูก product_id ไว้ ไม่ได้มาจากตาราง stock / good_receipt
     * เหมือน consumable
     *
     * Equipment ไม่ใช้ sub product แล้ว (19/08/2026) - เครื่องทุกตัวของ catalog นี้
     * จึงถูกจัดเป็นกลุ่มเดียวเสมอ ใช้ product.getProductName() เป็น label
     *
     *  - product        : catalog item ที่กำลังดู
     *  - groups         : List&lt;Map&gt; {label, productId, total, retired, rows:List&lt;Equipment&gt;} - มีสมาชิกเดียวเสมอ
     *  - totalOnHand    : จำนวนเครื่องที่ยังนับเป็นของคงเหลือ
     *  - totalRetired   : จำนวนเครื่องที่ปลดระวาง/บริจาคไปแล้ว (ผูกไว้แต่ไม่นับยอด)
     */
    public String showEquipmentBalancePage() {
        try {
            if (getOnlineUser() == null) {
                log.warn("showEquipmentBalancePage: no online user in session");
                return ERROR;
            }
            if (productId == null) {
                log.warn("showEquipmentBalancePage: productId is required");
                return ERROR;
            }

            Product product = productDAO.findById(productId);
            if (product == null) {
                log.warn("showEquipmentBalancePage: product not found, productId=" + productId);
                return ERROR;
            }
            // หน้านี้รับเฉพาะ catalog ฝั่ง Equipment (type '1') - type อื่นให้ไป stock_cons_balance
            if (!isEditableStockItem(product) || !isEquipmentProduct(product)) {
                log.warn("showEquipmentBalancePage: not an equipment catalog, productId=" + productId
                        + ", productType=" + product.getProductType());
                return ERROR;
            }

            // เครื่องจริงผูกกับ sub product เป็นหลัก (25/08/2026) แต่ยังรองรับกรณีไม่มี sub product เลยด้วย
            // ดู buildEquipmentGroupsForCatalog() - ใช้ตัวเดียวกับหน้า Settings
            List<Product> subProducts = productDAO.findByParentProductIds(
                    Collections.singletonList(String.valueOf(productId)));
            sortBySequence(subProducts);

            List<Map<String, Object>> groups = buildEquipmentGroupsForCatalog(product, subProducts);

            int totalOnHand = 0;
            int totalRetired = 0;
            for (Map<String, Object> group : groups) {
                totalOnHand += ((Integer) group.get("total")).intValue();
                totalRetired += ((Integer) group.get("retired")).intValue();
            }

            // นับแยก Available / Borrowed สำหรับแถบสรุป All/Available/Borrowed ด้านบนตาราง
            // (ดู EquipmentDAO status code: A=Available, B=Borrowed) - นับจากทุกกลุ่มรวมกัน
            int totalAvailable = 0;
            int totalBorrowed = 0;
            for (Map<String, Object> group : groups) {
                @SuppressWarnings("unchecked")
                List<Map<String, Object>> rows = (List<Map<String, Object>>) group.get("rows");
                if (rows == null) {
                    continue;
                }
                for (Map<String, Object> row : rows) {
                    Object status = row.get("status");
                    if ("A".equals(status)) {
                        totalAvailable++;
                    } else if ("B".equals(status)) {
                        totalBorrowed++;
                    }
                }
            }

            request.setAttribute("product", product);
            request.setAttribute("groups", groups);
            request.setAttribute("totalOnHand", Integer.valueOf(totalOnHand));
            request.setAttribute("totalAvailable", Integer.valueOf(totalAvailable));
            request.setAttribute("totalBorrowed", Integer.valueOf(totalBorrowed));
            request.setAttribute("totalRetired", Integer.valueOf(totalRetired));

            return SUCCESS;
        } catch (Exception e) {
            log.error("showEquipmentBalancePage failed, productId=" + productId, e);
            return ERROR;
        }
    }

    /** จัดกลุ่มเครื่องตาม product_id ที่ผูกไว้ (เครื่องที่ product_id ว่างถูกข้าม) */
    private Map<String, List<Equipment>> groupEquipmentByProductId(List<Equipment> equipments) {
        Map<String, List<Equipment>> byCatalogId = new HashMap<String, List<Equipment>>();
        if (equipments == null) {
            return byCatalogId;
        }
        for (Equipment equipment : equipments) {
            if (equipment == null || isBlank(equipment.getProductId())) {
                continue;
            }
            String key = equipment.getProductId().trim();
            List<Equipment> rows = byCatalogId.get(key);
            if (rows == null) {
                rows = new ArrayList<Equipment>();
                byCatalogId.put(key, rows);
            }
            rows.add(equipment);
        }
        return byCatalogId;
    }

    /**
     * สร้าง 1 กลุ่มของหน้า balance พร้อมนับยอด
     * total = เครื่องที่ยังนับเป็นของคงเหลือ, retired = ปลดระวาง/บริจาค (ยังโชว์ในตารางแต่ไม่นับ)
     *
     * แต่ละแถวแปลงเป็น map พร้อม flag retired มาจากที่นี่เลย เพื่อไม่ให้ JSP
     * ต้องไป hardcode รหัส status ซ้ำกับ EquipmentDAO.RETIRED_STATUSES
     */
    private Map<String, Object> buildEquipmentGroup(String label, String catalogId, List<Equipment> equipments) {
        int onHand = 0;
        int retired = 0;
        List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();

        if (equipments != null) {
            for (Equipment equipment : equipments) {
                if (equipment == null) {
                    continue;
                }
                boolean isRetired = isRetiredEquipment(equipment);
                if (isRetired) {
                    retired++;
                } else {
                    onHand++;
                }

                Map<String, Object> row = new LinkedHashMap<String, Object>();
                row.put("equipmentId", equipment.getEquipmentId());
                row.put("itemNo", equipment.getItemNo());
                row.put("name", equipment.getName());
                row.put("serialNo", equipment.getSerialNo());
                row.put("status", equipment.getStatus());
                row.put("location", equipment.getLocation());
                row.put("retired", Boolean.valueOf(isRetired));
                rows.add(row);
            }
        }

        Map<String, Object> group = new LinkedHashMap<String, Object>();
        group.put("label", label);
        group.put("productId", catalogId);
        group.put("total", Integer.valueOf(onHand));
        group.put("retired", Integer.valueOf(retired));
        group.put("rows", rows);
        return group;
    }

    /**
     * สร้างรายการกลุ่มเครื่องจริงของ catalog Equipment หนึ่งตัว - ใช้ร่วมกันทั้งหน้า Settings
     * (การ์ด "Equipment by Sub Product") และหน้า Stock Balance รองรับทั้ง 2 กรณี:
     *  - มี sub product: 1 กลุ่มต่อ 1 sub product
     *  - ไม่มี sub product เลย: 1 กลุ่มของตัวแม่เอง (ผูกเครื่องตรงกับตัวแม่ได้เหมือนเดิม)
     * เผื่อกรณีมี sub product แล้วแต่ตัวแม่ยังมีเครื่องผูกตรงค้างจากข้อมูลเก่า ก็ยังโชว์กลุ่มของตัวแม่เพิ่มด้วย
     */
    private List<Map<String, Object>> buildEquipmentGroupsForCatalog(Product product, List<Product> subProducts) throws Exception {
        List<Map<String, Object>> groups = new ArrayList<Map<String, Object>>();
        if (subProducts == null) {
            subProducts = new ArrayList<Product>();
        }

        List<String> allTargetIds = new ArrayList<String>();
        allTargetIds.add(String.valueOf(product.getProductId()));
        for (Product sub : subProducts) {
            allTargetIds.add(String.valueOf(sub.getProductId()));
        }
        Map<String, List<Equipment>> byCatalogId = groupEquipmentByProductId(equipmentDAO.findByProductIds(allTargetIds));

        List<Equipment> parentDirect = byCatalogId.get(String.valueOf(product.getProductId()));
        // โชว์กลุ่มของตัวแม่เฉพาะตอนมีเครื่องผูกตรงแบบเก่า หรือยังไม่มี sub product เลย
        if ((parentDirect != null && !parentDirect.isEmpty()) || subProducts.isEmpty()) {
            groups.add(buildEquipmentGroup(product.getProductName(), String.valueOf(product.getProductId()), parentDirect));
        }
        for (Product sub : subProducts) {
            String key = String.valueOf(sub.getProductId());
            groups.add(buildEquipmentGroup(sub.getProductName(), key, byCatalogId.get(key)));
        }
        return groups;
    }

    /** เครื่องที่ปลดระวาง/บริจาคไปแล้ว - ยังผูก product_id ไว้ แต่ไม่นับเป็นของคงเหลือ */
    private boolean isRetiredEquipment(Equipment equipment) {
        return equipment != null
                && equipment.getStatus() != null
                && EquipmentDAO.RETIRED_STATUSES.contains(equipment.getStatus().trim());
    }

    /** map: sub product id (String) -> ชื่อ sub product (ใช้เป็น label ของไซซ์) */
    private Map<String, String> buildSubProductNameMap(List<Product> subProducts) {
        Map<String, String> map = new HashMap<String, String>();
        if (subProducts == null) {
            return map;
        }
        for (Product sub : subProducts) {
            if (sub == null || sub.getProductId() == null) {
                continue;
            }
            String label = (sub.getProductName() != null && !sub.getProductName().trim().isEmpty())
                    ? sub.getProductName()
                    : sub.getProductNo();
            map.put(String.valueOf(sub.getProductId()), label);
        }
        return map;
    }

    /**
     * map: recipient_user id -> "id - ชื่อ" สำหรับแสดงในประวัติ
     * ดึงเฉพาะ id ที่ไม่ซ้ำจาก inRows (findById รายตัว) เพื่อจำกัดจำนวน query
     */
    private Map<String, String> buildUserDisplayMap(List<Map<String, Object>> inRows) throws Exception {
        Map<String, String> map = new HashMap<String, String>();
        if (inRows == null) {
            return map;
        }
        for (Map<String, Object> row : inRows) {
            if (row == null) {
                continue;
            }
            String userId = str(row.get("recipient_user"));
            if (isBlank(userId) || map.containsKey(userId)) {
                continue;
            }
            User user = userDAO.findById(userId);
            String name = (user != null) ? firstNonBlank(user.getName(), user.getNameEN()) : null;
            // แสดงเป็น "id - ชื่อ" ถ้าหาชื่อไม่เจอ ใช้ id เดี่ยว
            map.put(userId, isBlank(name) ? userId : (userId + " - " + name));
        }
        return map;
    }

    /** map: warehouse id (String) -> ชื่อคลัง */
    private Map<String, String> buildWarehouseNameMap(List<Warehouse> warehouses) {
        Map<String, String> map = new HashMap<String, String>();
        if (warehouses == null) {
            return map;
        }
        for (Warehouse wh : warehouses) {
            if (wh == null || wh.getWarehouseId() == null) {
                continue;
            }
            map.put(String.valueOf(wh.getWarehouseId()), wh.getWarehouseName());
        }
        return map;
    }

    /** group แถว detail ตาม good_receipt_id เป็น 1 การ์ดต่อ 1 ใบรับ */
    private List<Map<String, Object>> buildHistoriesIn(List<Map<String, Object>> inRows,
            Map<String, String> subNameById, Map<String, String> whNameById,
            Map<String, String> userNameById) {

        // LinkedHashMap รักษาลำดับใบล่าสุดก่อน (rows เรียงมาจาก SQL แล้ว)
        Map<String, Map<String, Object>> byReceipt = new LinkedHashMap<String, Map<String, Object>>();
        if (inRows == null) {
            return new ArrayList<Map<String, Object>>();
        }

        for (Map<String, Object> row : inRows) {
            if (row == null) {
                continue;
            }
            String receiptKey = str(row.get("good_receipt_id"));
            Map<String, Object> entry = byReceipt.get(receiptKey);
            if (entry == null) {
                entry = new HashMap<String, Object>();
                entry.put("doc_no", str(row.get("gr_ref")));
                entry.put("date", formatDateTime(row.get("receive_date")));
                String userId = str(row.get("recipient_user"));
                entry.put("user", resolveName(userNameById, userId));
                String whKey = str(row.get("warehouse_id"));
                entry.put("warehouse", resolveName(whNameById, whKey));
                entry.put("unit", str(row.get("unit")));
                entry.put("details", new ArrayList<Map<String, Object>>());
                entry.put("_total", Double.valueOf(0d));
                byReceipt.put(receiptKey, entry);
            }

            double amt = toDouble(row.get("amount"));
            entry.put("_total", Double.valueOf(toDouble(entry.get("_total")) + amt));
            if (isBlank(str(entry.get("unit"))) && !isBlank(str(row.get("unit")))) {
                entry.put("unit", str(row.get("unit")));
            }

            String subKey = str(row.get("sub_product_id"));
            Map<String, Object> detail = new HashMap<String, Object>();
            detail.put("size", resolveName(subNameById, subKey));
            detail.put("amount", formatQty(amt));
            ((List<Map<String, Object>>) entry.get("details")).add(detail);
        }

        // แปลงยอดรวมเป็น string สวยๆ แล้วลบ field ชั่วคราวออก
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> entry : byReceipt.values()) {
            entry.put("amount", formatQty(toDouble(entry.get("_total"))));
            entry.remove("_total");
            result.add(entry);
        }
        return result;
    }

    /**
     * ยอดคงเหลือเป็นกลุ่มตาม sub product (ไซซ์) เรียงตาม sequence
     *  - total : ยอดคงเหลือจริง ดึงจาก stock.reconcile (แถวล่าสุด)
     *  - rows  : รายการแยกคลังจากประวัติรับเข้า (good_receipt) - warehouse จาก WarehouseDAO เหมือนเดิม
     * โครงสร้าง: [{ key, label, total, rows:[{warehouse, amount}] }]
     */
    private List<Map<String, Object>> buildBalances(List<Product> subProducts, List<Warehouse> warehouses,
            List<Map<String, Object>> inRows, Map<String, String> whNameById, Map<String, Double> reconcileBySub) {

        // subKey -> (whKey -> ยอดรับเข้ารวม) สำหรับรายการแยกคลัง
        Map<String, Map<String, Double>> bySubWh = new HashMap<String, Map<String, Double>>();
        if (inRows != null) {
            for (Map<String, Object> row : inRows) {
                if (row == null) {
                    continue;
                }
                String subKey = str(row.get("sub_product_id"));
                String whKey = str(row.get("warehouse_id"));
                double amt = toDouble(row.get("amount"));

                Map<String, Double> whMap = bySubWh.get(subKey);
                if (whMap == null) {
                    whMap = new LinkedHashMap<String, Double>();
                    bySubWh.put(subKey, whMap);
                }
                Double prev = whMap.get(whKey);
                whMap.put(whKey, Double.valueOf((prev != null ? prev.doubleValue() : 0d) + amt));
            }
        }

        List<Map<String, Object>> balances = new ArrayList<Map<String, Object>>();
        for (Product sub : subProducts) {
            if (sub == null || sub.getProductId() == null) {
                continue;
            }
            String key = String.valueOf(sub.getProductId());
            String label = resolveName(buildSubProductNameMap(Collections.singletonList(sub)), key);
            Map<String, Double> whMap = bySubWh.get(key);

            // ยอดรวมของไซซ์ = ยอดคงเหลือจาก stock.reconcile (ไม่ใช่ผลรวมของรายการแยกคลัง)
            double total = (reconcileBySub != null && reconcileBySub.get(key) != null)
                    ? reconcileBySub.get(key).doubleValue() : 0d;

            List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
            if (whMap != null) {
                // เรียงตามลำดับคลังใน warehouses เพื่อผลลัพธ์คงที่
                for (Warehouse wh : warehouses) {
                    if (wh == null || wh.getWarehouseId() == null) {
                        continue;
                    }
                    String whKey = String.valueOf(wh.getWarehouseId());
                    Double val = whMap.get(whKey);
                    if (val != null && val.doubleValue() != 0d) {
                        rows.add(balanceRow(wh.getWarehouseName(), val.doubleValue()));
                    }
                }
                // คลังที่มีใน IN แต่ไม่มีในตาราง warehouse (กันข้อมูลตกหล่น)
                for (Map.Entry<String, Double> e : whMap.entrySet()) {
                    if (!containsWarehouse(warehouses, e.getKey()) && e.getValue() != null
                            && e.getValue().doubleValue() != 0d) {
                        rows.add(balanceRow(resolveName(whNameById, e.getKey()), e.getValue().doubleValue()));
                    }
                }
            }

            Map<String, Object> group = new HashMap<String, Object>();
            group.put("key", key);
            group.put("label", label);
            group.put("total", formatQty(total));
            group.put("rows", rows);
            balances.add(group);
        }
        return balances;
    }

    /**
     * ปุ่มกรอง + ยอดรวมต่อไซซ์ ({key,label,amount}) เรียงตาม sequence โดยมี ALL นำหน้า
     * จำนวนต่อไซซ์ดึงจาก stock.reconcile, ALL = ผลรวมของทุกไซซ์
     */
    private List<Map<String, Object>> buildSizeSummaries(List<Product> subProducts,
            Map<String, Double> reconcileBySub) {

        List<Map<String, Object>> summaries = new ArrayList<Map<String, Object>>();

        double grandTotal = 0d;
        List<Map<String, Object>> items = new ArrayList<Map<String, Object>>();
        for (Product sub : subProducts) {
            if (sub == null || sub.getProductId() == null) {
                continue;
            }
            String key = String.valueOf(sub.getProductId());
            String label = resolveName(buildSubProductNameMap(Collections.singletonList(sub)), key);
            double amount = (reconcileBySub != null && reconcileBySub.get(key) != null)
                    ? reconcileBySub.get(key).doubleValue() : 0d;
            grandTotal += amount;

            Map<String, Object> item = new HashMap<String, Object>();
            item.put("key", key);
            item.put("label", label);
            item.put("amount", formatQty(amount));
            items.add(item);
        }

        Map<String, Object> all = new HashMap<String, Object>();
        all.put("key", "ALL");
        all.put("label", "All");
        all.put("amount", formatQty(grandTotal));
        summaries.add(all);
        summaries.addAll(items);
        return summaries;
    }

    /** เรียง sub product ตาม sequence (varchar) แบบตัวเลข น้อย -> มาก, ค่าว่าง/ไม่ใช่ตัวเลขไปท้าย */
    private void sortSubProductsBySequence(List<Product> subProducts) {
        if (subProducts == null || subProducts.size() < 2) {
            return;
        }
        Collections.sort(subProducts, new Comparator<Product>() {
            @Override
            public int compare(Product a, Product b) {
                return Double.compare(sequenceValue(a), sequenceValue(b));
            }
        });
    }

    private double sequenceValue(Product product) {
        if (product == null || product.getSequence() == null) {
            return Double.MAX_VALUE;
        }
        try {
            return Double.parseDouble(product.getSequence().trim());
        } catch (NumberFormatException e) {
            return Double.MAX_VALUE;
        }
    }

    /**
     * map: sub product id -> ยอดคงเหลือจาก stock.reconcile (แถวล่าสุดตาม time_create)
     * ถ้าไม่มีความเคลื่อนไหวใน stock ให้เป็น 0
     */
    private Map<String, Double> buildReconcileBySubProduct(List<Product> subProducts) throws Exception {
        Map<String, Double> map = new HashMap<String, Double>();
        if (subProducts == null) {
            return map;
        }
        for (Product sub : subProducts) {
            if (sub == null || sub.getProductId() == null) {
                continue;
            }
            String key = String.valueOf(sub.getProductId());
            if (map.containsKey(key)) {
                continue;
            }
            Stock latest = stockDAO.findLatestByProductId(key);
            double reconcile = (latest != null && latest.getReconcile() != null)
                    ? latest.getReconcile().doubleValue() : 0d;
            map.put(key, Double.valueOf(reconcile));
        }
        return map;
    }

    private Map<String, Object> balanceRow(String warehouse, double amount) {
        Map<String, Object> row = new HashMap<String, Object>();
        row.put("warehouse", warehouse);
        row.put("amount", formatQty(amount));
        return row;
    }

    private boolean containsWarehouse(List<Warehouse> warehouses, String whKey) {
        if (warehouses == null || whKey == null) {
            return false;
        }
        for (Warehouse wh : warehouses) {
            if (wh != null && wh.getWarehouseId() != null
                    && whKey.equals(String.valueOf(wh.getWarehouseId()))) {
                return true;
            }
        }
        return false;
    }

    // ---------- utility ----------

    private String resolveName(Map<String, String> nameById, String key) {
        if (key == null) {
            return "";
        }
        String name = nameById.get(key);
        return (name != null && !name.trim().isEmpty()) ? name : key;
    }

    private String str(Object value) {
        return (value != null) ? String.valueOf(value) : "";
    }

    private String firstNonBlank(String a, String b) {
        if (!isBlank(a)) {
            return a;
        }
        return isBlank(b) ? null : b;
    }

    private double toDouble(Object value) {
        if (value instanceof Number) {
            return ((Number) value).doubleValue();
        }
        if (value != null) {
            try {
                return Double.parseDouble(String.valueOf(value).trim());
            } catch (NumberFormatException ignore) {
                return 0d;
            }
        }
        return 0d;
    }

    /** แสดงจำนวนแบบไม่มี .0 เกินจำเป็น และมี thousand separator */
    private String formatQty(double value) {
        return new DecimalFormat("#,##0.##").format(value);
    }

    private String formatDateTime(Object value) {
        if (value instanceof Date) {
            return new SimpleDateFormat("d MMM yyyy, HH:mm", Locale.ENGLISH).format((Date) value);
        }
        return str(value);
    }

    /**
     * บันทึก consumable ใหม่จากหน้า stock_cons_add
     * หลังบันทึกจะ redirect ไปหน้า edit ของ product ที่เพิ่งสร้าง เพื่อให้ผู้ใช้ตั้งค่า UOM / sub-product ต่อได้
     */
    public String stockConsSave() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                log.warn("stockConsSave: no online user in session");
                return ERROR;
            }
            // server-side validation กัน request ที่ bypass required ฝั่ง client
            if (isBlank(productNo) || isBlank(productName) || isBlank(productType)) {
                log.warn("stockConsSave: missing required fields");
                return ERROR;
            }
            // Item Type = Equipment ('1') บังคับเลือก Equipment Type ต่อ (เหมือน required ฝั่ง client)
            boolean isEquipmentType = "1".equals(productType.trim());
            if (isEquipmentType && isBlank(equipmentType)) {
                log.warn("stockConsSave: equipmentType is required when productType=1");
                return ERROR;
            }

            java.sql.Timestamp now = DateUtil.getCurrentTime();

            Product product = new Product();
            // ไม่ต้องตั้ง productId เอง - product_id เป็น AUTO_INCREMENT แล้ว (10/08/2026)
            // Hibernate จะได้ค่าที่ DB ออกให้กลับมาทันทีหลัง save() (GenerationType.IDENTITY)
            product.setProductNo(productNo.trim());
            product.setProductName(productName.trim());
            product.setProductType(productType.trim());
            // ค่า default ของ equipment type - มีความหมายเฉพาะตอน productType = '1' เท่านั้น
            product.setEquipmentType(isEquipmentType ? equipmentType.trim() : null);
            product.setDescription(trimToNull(description));
            // product แม่ (top-level) ให้ parent_product_id = '0' สอดคล้องกับ findAllConsWithSubProducts()
            product.setParentProductId("0");
            product.setSequence("0");
            // สร้างใหม่ให้ active โดยปริยาย (หน้า add ยังไม่มี toggle)
            product.setActive("0".equals(active) ? "0" : "1");
            // เปิด sub product ไว้ให้เลยทุก type (Equipment กลับมาใช้ sub product อีกครั้ง 25/08/2026
            // เพื่อผูกเครื่องจริงแยกตามรุ่น/sub product แทนที่จะผูกกับตัวแม่ตรงๆ)
            product.setSubProductActive("1");
            product.setUserCreate(onlineUser.getId());
            product.setTimeCreate(now);
            product.setUserUpdate(onlineUser.getId());
            product.setTimeUpdate(now);

            productDAO.save(product);

            // ตั้งค่าให้ result redirect ไป stock_cons_edit?productId=${productId} ได้
            // (product.getProductId() มีค่าแล้วหลัง save เพราะใช้ IDENTITY generator)
            this.productId = product.getProductId();

            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            log.error("stockConsSave failed", e);
            return ERROR;
        }
    }

    /**
     * แก้ไข product detail ของ consumable จากหน้า stock_cons_edit
     * ตอบกลับเป็น JSON (ฟอร์ม submit แบบ AJAX) เพื่อโชว์ SweetAlert โดยไม่ reload หน้า
     */
    public String stockConsUpdate() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                log.warn("stockConsUpdate: no online user in session");
                return writeJson(false, "unauthorized");
            }
            if (productId == null) {
                log.warn("stockConsUpdate: productId is required");
                return writeJson(false, "productId required");
            }
            if (isBlank(productNo) || isBlank(productName) || isBlank(productType)) {
                log.warn("stockConsUpdate: missing required fields, productId=" + productId);
                return writeJson(false, "missing required fields");
            }
            // Item Type = Equipment ('1') บังคับเลือก Equipment Type ต่อ (เหมือน stockConsSave)
            boolean isEquipmentType = "1".equals(productType.trim());
            if (isEquipmentType && isBlank(equipmentType)) {
                log.warn("stockConsUpdate: equipmentType is required when productType=1, productId=" + productId);
                return writeJson(false, "กรุณาเลือก Equipment Type");
            }

            Product product = productDAO.findById(productId);
            if (product == null) {
                log.warn("stockConsUpdate: product not found, productId=" + productId);
                return writeJson(false, "product not found");
            }
            // กันการยิง id ของ product ประเภทอื่น หรือ sub-product เข้ามาแก้ที่หน้านี้
            if (!isEditableStockItem(product)) {
                log.warn("stockConsUpdate: not a consumable, productId=" + productId
                        + ", productType=" + product.getProductType());
                return writeJson(false, "invalid product");
            }

            product.setProductNo(productNo.trim());
            product.setProductName(productName.trim());
            product.setProductType(productType.trim());
            // ค่ามีความหมายเฉพาะตอน productType = '1' เท่านั้น (เหมือน stockConsSave)
            product.setEquipmentType(isEquipmentType ? equipmentType.trim() : null);
            product.setDescription(trimToNull(description));
            // active มาจาก hidden ในฟอร์ม (toggle) - ส่งมาเสมอเป็น '1'/'0'
            if (active != null) {
                product.setActive("1".equals(active) ? "1" : "0");
            }
            product.setUserUpdate(onlineUser.getId());
            product.setTimeUpdate(DateUtil.getCurrentTime());

            productDAO.update(product);

            return writeJson(true, null);
        } catch (Exception e) {
            log.error("stockConsUpdate failed, productId=" + productId, e);
            return writeJson(false, "error");
        }
    }

    /**
     * ลบ product ตัวแม่พร้อม sub product / UOM ของมัน (ยิงจากปุ่มถังขยะในหน้า stock_cons_list)
     * ใช้ได้ทั้ง Consumables / Accessory / Equipment เพราะเช็คแค่ product_type อยู่ใน STOCK_ITEM_TYPES
     *
     * ก่อนลบต้องเช็คว่ามีใครอ้างถึงอยู่ไหม (กันข้อมูลกำพร้า) - ถ้ามีให้ตอบ JSON แจ้งแหล่งที่อ้างถึง
     * แหล่งที่เช็ค: mr (Material Request), stock (ประวัติเบิก-รับ), good_receipt_detail (ใบรับของ),
     * equipment (เครื่องจริงที่ผูก product_id ไว้ - เฉพาะฝั่ง Equipment)
     * ตอบกลับเป็น JSON เพื่อโชว์ SweetAlert โดยไม่ redirect หนีออกจากหน้า list
     */
    public String stockConsDelete() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                log.warn("stockConsDelete: no online user in session");
                return writeJson(false, "unauthorized");
            }
            if (productId == null) {
                log.warn("stockConsDelete: productId is required");
                return writeJson(false, "productId required");
            }

            Product product = productDAO.findById(productId);
            if (product == null) {
                log.warn("stockConsDelete: product not found, productId=" + productId);
                return writeJson(false, "ไม่พบข้อมูลที่ต้องการลบ");
            }
            // กันการยิง id ของ sub-product หรือ product ประเภทอื่นเข้ามาลบผ่านปุ่มนี้
            if (!isEditableStockItem(product)) {
                log.warn("stockConsDelete: not deletable from this page, productId=" + productId
                        + ", productType=" + product.getProductType());
                return writeJson(false, "ไม่สามารถลบรายการนี้ได้");
            }

            List<Product> subProducts = productDAO.findByParentProductIds(
                    Collections.singletonList(String.valueOf(productId)));
            List<Integer> allIds = new ArrayList<Integer>();
            allIds.add(productId);
            if (subProducts != null) {
                for (Product sub : subProducts) {
                    if (sub != null && sub.getProductId() != null) {
                        allIds.add(sub.getProductId());
                    }
                }
            }

            Map<String, Long> refs = productDAO.countReferences(allIds);
            if (!refs.isEmpty()) {
                StringBuilder message = new StringBuilder("ไม่สามารถลบได้ เนื่องจากมีการเรียกใช้งานอยู่ที่: ");
                boolean first = true;
                for (Map.Entry<String, Long> entry : refs.entrySet()) {
                    if (!first) {
                        message.append(", ");
                    }
                    message.append(entry.getKey()).append(" (").append(entry.getValue()).append(")");
                    first = false;
                }
                log.warn("stockConsDelete: blocked by references, productId=" + productId
                        + ", refs=" + refs);
                return writeJson(false, message.toString());
            }

            productDAO.deleteWithChildren(productId);

            return writeJson(true, "ลบข้อมูลสำเร็จ");
        } catch (Exception e) {
            log.error("stockConsDelete failed, productId=" + productId, e);
            return writeJson(false, "เกิดข้อผิดพลาด ไม่สามารถลบข้อมูลได้");
        }
    }

    // ==================== Sub product active toggle (AJAX) ====================

    /**
     * เปิด/ปิด sub_product_active ของ product แม่ (ยิงจาก toggle ในหน้า edit)
     * ตอบกลับเป็น JSON ไม่ redirect เพื่อไม่ให้หน้ารีเฟรช
     */
    public String subProductActiveUpdate() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                return writeJson(false, "unauthorized");
            }
            if (productId == null) {
                return writeJson(false, "productId required");
            }
            Product parent = productDAO.findById(productId);
            if (parent == null || !isEditableStockItem(parent)) {
                return writeJson(false, "product not found");
            }

            parent.setSubProductActive("1".equals(subProductActive) ? "1" : "0");
            parent.setUserUpdate(onlineUser.getId());
            parent.setTimeUpdate(DateUtil.getCurrentTime());
            productDAO.update(parent);

            return writeJson(true, null);
        } catch (Exception e) {
            log.error("subProductActiveUpdate failed, productId=" + productId, e);
            return writeJson(false, "error");
        }
    }

    /**
     * เปิด/ปิด active ของ product (Catalog MR ในหน้า list) - ยิงแบบ AJAX ตอบ JSON
     */
    public String productActiveUpdate() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                return writeJson(false, "unauthorized");
            }
            if (productId == null) {
                return writeJson(false, "productId required");
            }
            Product product = productDAO.findById(productId);
            if (product == null || !isEditableStockItem(product)) {
                return writeJson(false, "product not found");
            }

            product.setActive("1".equals(active) ? "1" : "0");
            product.setUserUpdate(onlineUser.getId());
            product.setTimeUpdate(DateUtil.getCurrentTime());
            productDAO.update(product);

            return writeJson(true, null);
        } catch (Exception e) {
            log.error("productActiveUpdate failed, productId=" + productId, e);
            return writeJson(false, "error");
        }
    }

    // ==================== Unit of Measure (UOM) ====================

    /** เพิ่ม unit ใหม่ให้ product (ยิงจาก modal Create UOM) */
    public String stockConsUomSave() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                log.warn("stockConsUomSave: no online user in session");
                return ERROR;
            }
            if (productId == null || isBlank(unitName) || isBlank(sequence)) {
                log.warn("stockConsUomSave: missing required fields, productId=" + productId);
                return ERROR;
            }
            Product parent = productDAO.findById(productId);
            if (parent == null || !isEditableStockItem(parent)) {
                log.warn("stockConsUomSave: parent not found/not consumable, productId=" + productId);
                return ERROR;
            }

            java.sql.Timestamp now = DateUtil.getCurrentTime();
            UnitOfMeasure unit = new UnitOfMeasure();
            // unit_of_measure.product_id เป็น varchar
            unit.setProductId(String.valueOf(productId));
            unit.setSequence(sequence.trim());
            unit.setUnitName(unitName.trim());
            unit.setConversionRate(conversionRate != null ? conversionRate : Integer.valueOf(1));
            unit.setDescription(trimToNull(description));
            unit.setUserCreate(onlineUser.getId());
            unit.setTimeCreate(now);
            unit.setUserUpdate(onlineUser.getId());
            unit.setTimeUpdate(now);

            unitOfMeasureDAO.save(unit);

            return SUCCESS;
        } catch (Exception e) {
            log.error("stockConsUomSave failed, productId=" + productId, e);
            return ERROR;
        }
    }

    /** แก้ไข unit (ยิงจาก modal Edit UOM) */
    public String stockConsUomUpdate() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                log.warn("stockConsUomUpdate: no online user in session");
                return ERROR;
            }
            if (productId == null || unitId == null || isBlank(unitName) || isBlank(sequence)) {
                log.warn("stockConsUomUpdate: missing required fields, unitId=" + unitId);
                return ERROR;
            }
            UnitOfMeasure unit = unitOfMeasureDAO.findById(unitId);
            if (unit == null) {
                log.warn("stockConsUomUpdate: unit not found, unitId=" + unitId);
                return ERROR;
            }
            // ownership: unit ต้องอยู่ใต้ product นี้ กัน id ข้ามสินค้า
            if (!String.valueOf(productId).equals(unit.getProductId())) {
                log.warn("stockConsUomUpdate: unit not under product, unitId=" + unitId + ", productId=" + productId);
                return ERROR;
            }

            unit.setSequence(sequence.trim());
            unit.setUnitName(unitName.trim());
            unit.setConversionRate(conversionRate != null ? conversionRate : unit.getConversionRate());
            unit.setDescription(trimToNull(description));
            unit.setUserUpdate(onlineUser.getId());
            unit.setTimeUpdate(DateUtil.getCurrentTime());

            unitOfMeasureDAO.update(unit);

            return SUCCESS;
        } catch (Exception e) {
            log.error("stockConsUomUpdate failed, unitId=" + unitId, e);
            return ERROR;
        }
    }

    /** ลบ unit */
    public String stockConsUomDelete() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                log.warn("stockConsUomDelete: no online user in session");
                return ERROR;
            }
            if (productId == null || unitId == null) {
                log.warn("stockConsUomDelete: productId/unitId required");
                return ERROR;
            }
            UnitOfMeasure unit = unitOfMeasureDAO.findById(unitId);
            if (unit == null) {
                log.warn("stockConsUomDelete: unit not found, unitId=" + unitId);
                return ERROR;
            }
            if (!String.valueOf(productId).equals(unit.getProductId())) {
                log.warn("stockConsUomDelete: unit not under product, unitId=" + unitId + ", productId=" + productId);
                return ERROR;
            }

            unitOfMeasureDAO.delete(unit);

            return SUCCESS;
        } catch (Exception e) {
            log.error("stockConsUomDelete failed, unitId=" + unitId, e);
            return ERROR;
        }
    }

    /** จัดลำดับ unit ใหม่ตามที่ลากใน SortableJS (AJAX) - sequence รันใหม่ 0..n */
    public String stockConsUomReorder() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                return writeJson(false, "unauthorized");
            }
            if (productId == null) {
                return writeJson(false, "productId required");
            }

            java.sql.Timestamp now = DateUtil.getCurrentTime();
            int seq = 0;
            for (Integer uid : parseIds(orderedIds)) {
                UnitOfMeasure unit = unitOfMeasureDAO.findById(uid);
                // ข้ามตัวที่ไม่พบ หรือไม่ได้อยู่ใต้ product นี้ (กัน id แปลกปลอม)
                if (unit == null || !String.valueOf(productId).equals(unit.getProductId())) {
                    continue;
                }
                unit.setSequence(String.valueOf(seq));
                unit.setUserUpdate(onlineUser.getId());
                unit.setTimeUpdate(now);
                unitOfMeasureDAO.update(unit);
                seq++;
            }

            return writeJson(true, null);
        } catch (Exception e) {
            log.error("stockConsUomReorder failed, productId=" + productId, e);
            return writeJson(false, "error");
        }
    }

    // ==================== Sub product ====================

    /** เพิ่ม sub product ใหม่ (ยิงจาก modal Create Sub product) */
    public String stockConsSubSave() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                log.warn("stockConsSubSave: no online user in session");
                return ERROR;
            }
            Integer parentId = toInteger(parentProductId);
            if (parentId == null || isBlank(productNo) || isBlank(productName)) {
                log.warn("stockConsSubSave: missing required fields, parentProductId=" + parentProductId);
                return ERROR;
            }
            Product parent = productDAO.findById(parentId);
            if (parent == null || !isEditableStockItem(parent)) {
                log.warn("stockConsSubSave: parent not found/not consumable, parentId=" + parentId);
                return ERROR;
            }
            java.sql.Timestamp now = DateUtil.getCurrentTime();

            // sequence ต่อท้ายของเดิม
            List<Product> siblings = productDAO.findByParentProductIds(
                    Collections.singletonList(String.valueOf(parentId)));
            int nextSeq = (siblings != null) ? siblings.size() : 0;

            Product sub = new Product();
            // ไม่ต้องตั้ง productId เอง - product_id เป็น AUTO_INCREMENT แล้ว (10/08/2026)
            sub.setProductNo(productNo.trim());
            sub.setProductName(productName.trim());
            // sub product ยึด product_type เดียวกับตัวแม่
            sub.setProductType(parent.getProductType());
            sub.setParentProductId(String.valueOf(parentId));
            sub.setSequence(String.valueOf(nextSeq));
            sub.setDescription(trimToNull(description));
            sub.setActive("1");
            sub.setUserCreate(onlineUser.getId());
            sub.setTimeCreate(now);
            sub.setUserUpdate(onlineUser.getId());
            sub.setTimeUpdate(now);

            productDAO.save(sub);

            return SUCCESS;
        } catch (Exception e) {
            log.error("stockConsSubSave failed, parentProductId=" + parentProductId, e);
            return ERROR;
        }
    }

    /** แก้ไข sub product (ยิงจาก modal Edit Sub product) */
    public String stockConsSubUpdate() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                log.warn("stockConsSubUpdate: no online user in session");
                return ERROR;
            }
            if (subProductId == null || isBlank(parentProductId) || isBlank(productNo) || isBlank(productName)) {
                log.warn("stockConsSubUpdate: missing required fields, subProductId=" + subProductId);
                return ERROR;
            }
            Product sub = productDAO.findById(subProductId);
            if (sub == null) {
                log.warn("stockConsSubUpdate: sub not found, subProductId=" + subProductId);
                return ERROR;
            }
            // ownership: ต้องเป็นลูกของ parent ที่ส่งมา
            if (!parentProductId.trim().equals(sub.getParentProductId())) {
                log.warn("stockConsSubUpdate: sub not under parent, subProductId=" + subProductId
                        + ", parentProductId=" + parentProductId);
                return ERROR;
            }

            sub.setProductNo(productNo.trim());
            sub.setProductName(productName.trim());
            sub.setDescription(trimToNull(description));
            sub.setUserUpdate(onlineUser.getId());
            sub.setTimeUpdate(DateUtil.getCurrentTime());

            productDAO.update(sub);

            return SUCCESS;
        } catch (Exception e) {
            log.error("stockConsSubUpdate failed, subProductId=" + subProductId, e);
            return ERROR;
        }
    }

    /** ลบ sub product */
    public String stockConsSubDelete() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                log.warn("stockConsSubDelete: no online user in session");
                return ERROR;
            }
            if (subProductId == null || isBlank(parentProductId)) {
                log.warn("stockConsSubDelete: subProductId/parentProductId required");
                return ERROR;
            }
            Product sub = productDAO.findById(subProductId);
            if (sub == null) {
                log.warn("stockConsSubDelete: sub not found, subProductId=" + subProductId);
                return ERROR;
            }
            if (!parentProductId.trim().equals(sub.getParentProductId())) {
                log.warn("stockConsSubDelete: sub not under parent, subProductId=" + subProductId);
                return ERROR;
            }

            productDAO.delete(sub);

            return SUCCESS;
        } catch (Exception e) {
            log.error("stockConsSubDelete failed, subProductId=" + subProductId, e);
            return ERROR;
        }
    }

    /** จัดลำดับ sub product ใหม่ตามที่ลากใน SortableJS (AJAX) - sequence รันใหม่ 0..n */
    public String stockConsSubReorder() {
        try {
            User onlineUser = getOnlineUser();
            if (onlineUser == null) {
                return writeJson(false, "unauthorized");
            }
            if (isBlank(parentProductId)) {
                return writeJson(false, "parentProductId required");
            }

            String parentKey = parentProductId.trim();
            java.sql.Timestamp now = DateUtil.getCurrentTime();
            int seq = 0;
            for (Integer sid : parseIds(orderedIds)) {
                Product sub = productDAO.findById(sid);
                // ข้ามตัวที่ไม่พบ หรือไม่ได้เป็นลูกของ parent นี้
                if (sub == null || !parentKey.equals(sub.getParentProductId())) {
                    continue;
                }
                sub.setSequence(String.valueOf(seq));
                sub.setUserUpdate(onlineUser.getId());
                sub.setTimeUpdate(now);
                productDAO.update(sub);
                seq++;
            }

            return writeJson(true, null);
        } catch (Exception e) {
            log.error("stockConsSubReorder failed, parentProductId=" + parentProductId, e);
            return writeJson(false, "error");
        }
    }

    // ---------- helpers (CRUD/reorder) ----------

    /** แปลง csv ("3,1,2") เป็น List<Integer> โดยข้ามค่าที่ไม่ใช่ตัวเลข */
    private List<Integer> parseIds(String csv) {
        List<Integer> ids = new ArrayList<Integer>();
        if (csv == null) {
            return ids;
        }
        for (String part : csv.split(",")) {
            Integer id = toInteger(part);
            if (id != null) {
                ids.add(id);
            }
        }
        return ids;
    }

    private Integer toInteger(String value) {
        if (value == null) {
            return null;
        }
        try {
            return Integer.valueOf(value.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

    /** เขียน JSON ตอบกลับ AJAX แล้วคืน NONE (ไม่ render result) */
    private String writeJson(boolean success, String message) {
        try {
            response.setContentType("application/json;charset=UTF-8");
            StringBuilder sb = new StringBuilder();
            sb.append("{\"success\":").append(success);
            if (message != null) {
                sb.append(",\"message\":\"").append(message.replace("\\", "\\\\").replace("\"", "\\\"")).append("\"");
            }
            sb.append("}");
            response.getWriter().write(sb.toString());
            response.getWriter().flush();
        } catch (Exception e) {
            log.error("writeJson failed", e);
        }
        return NONE;
    }

    /** เรียง product ตาม sequence แบบตัวเลข (sequence เป็น varchar - ค่าที่ไม่ใช่ตัวเลขถูกดันไปท้าย) */
    private void sortBySequence(List<Product> list) {
        if (list == null || list.size() < 2) {
            return;
        }
        Collections.sort(list, new java.util.Comparator<Product>() {
            @Override
            public int compare(Product a, Product b) {
                return Integer.compare(seqValue(a), seqValue(b));
            }
        });
    }

    private int seqValue(Product p) {
        if (p == null || p.getSequence() == null) {
            return Integer.MAX_VALUE;
        }
        try {
            return Integer.parseInt(p.getSequence().trim());
        } catch (NumberFormatException e) {
            return Integer.MAX_VALUE;
        }
    }

    /**
     * true เมื่อ product เป็น item ระดับบนสุด (parent_product_id = '0' ไม่ใช่ sub-product)
     * และ product_type อยู่ในกลุ่มที่จัดการในหน้า stock (1/2/3)
     * ใช้กันการยิง id ของ sub-product หรือ product ประเภทอื่นเข้ามาที่หน้า edit/balance
     */
    private boolean isEditableStockItem(Product p) {
        return p != null
                && p.getProductType() != null
                && STOCK_ITEM_TYPES.contains(p.getProductType().trim())
                && "0".equals(p.getParentProductId());
    }

    /**
     * true เมื่อ product เป็น Equipment (product_type = '1')
     * ใช้เช็คก่อนโชว์/บันทึกส่วนที่เฉพาะ Equipment เท่านั้น เช่นผูกเครื่องจริง (equipment table)
     * เข้ากับ sub product - Equipment มี sub product ได้เหมือน type อื่น (กลับมาใช้อีกครั้ง 25/08/2026)
     */
    private boolean isEquipmentProduct(Product p) {
        return p != null
                && p.getProductType() != null
                && "1".equals(p.getProductType().trim());
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    /** คืน null ถ้าค่าว่าง เพื่อไม่ให้เก็บ empty string ลง DB (ฟิลด์ที่ไม่บังคับ) */
    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private User getOnlineUser() {
        // getSession(false) กัน NPE และกันการสร้าง session ใหม่โดยไม่ตั้งใจ
        if (request == null || request.getSession(false) == null) {
            return null;
        }
        return (User) request.getSession(false).getAttribute("onlineUser");
    }
}