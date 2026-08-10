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

import com.cubesofttech.dao.GoodReceiptDAO;
import com.cubesofttech.dao.ProductDAO;
import com.cubesofttech.dao.StockDAO;
import com.cubesofttech.dao.UnitOfMeasureDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WarehouseDAO;
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
    
    /** product_type ของ consumables - อ้างอิงเดียวกับ findAllConsWithSubProducts() */
    private static final String PRODUCT_TYPE_CONSUMABLES = "2";

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private UnitOfMeasureDAO unitOfMeasureDAO;

    @Autowired
    private GoodReceiptDAO goodReceiptDAO;

    @Autowired
    private WarehouseDAO warehouseDAO;

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private StockDAO stockDAO;

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

    public String stockConsList() {
        try {
            List<Map<String, Object>> products = productDAO.findAllConsWithSubProducts();
            if (products == null) {
                products = new ArrayList<Map<String, Object>>();
            }

            fillMainUnits(products);

            //log.debug(products);
            request.setAttribute("products", products);

            return SUCCESS;
        } catch (Exception e) {
            log.error("stockConsList failed", e);
            return ERROR;
        }
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

    public String showStockAddPage() {
        try {
            if (getOnlineUser() == null) {
                log.warn("showStockAddPage: no online user in session");
                return ERROR;
            }

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
            if (!PRODUCT_TYPE_CONSUMABLES.equals(product.getProductType())) {
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

            return SUCCESS;
        } catch (Exception e) {
            log.error("showStockEditPage failed, productId=" + productId, e);
            return ERROR;
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
            if (!PRODUCT_TYPE_CONSUMABLES.equals(product.getProductType())) {
                log.warn("showStockBalancePage: not a consumable, productId=" + productId
                        + ", productType=" + product.getProductType());
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

            // (3) จำนวนคงเหลือต่อ sub product ดึงจาก stock.reconcile (แถวล่าสุด)
            Map<String, Double> reconcileBySub = buildReconcileBySubProduct(subProducts);

            // ประวัติรับเข้า (IN) จาก good_receipt (ใช้กับ History + รายการแยกคลัง)
            List<Map<String, Object>> inRows = goodReceiptDAO.findInHistoryByParentProductId(productIdStr);

            Map<String, String> subNameById = buildSubProductNameMap(subProducts);
            Map<String, String> whNameById = buildWarehouseNameMap(warehouses);
            Map<String, String> userNameById = buildUserDisplayMap(inRows);

            List<Map<String, Object>> historiesIn = buildHistoriesIn(inRows, subNameById, whNameById, userNameById);
            List<Map<String, Object>> balances = buildBalances(subProducts, warehouses, inRows, whNameById, reconcileBySub);
            List<Map<String, Object>> sizeSummaries = buildSizeSummaries(subProducts, reconcileBySub);

            request.setAttribute("product", product);
            request.setAttribute("subProducts", subProducts);
            request.setAttribute("warehouses", warehouses);
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

            java.sql.Timestamp now = DateUtil.getCurrentTime();
            Integer newProductId = productDAO.getMaxId() + 1;

            Product product = new Product();
            log.debug(newProductId);
            product.setProductId(newProductId);
            product.setProductNo(productNo.trim());
            product.setProductName(productName.trim());
            product.setProductType(productType.trim());
            product.setDescription(trimToNull(description));
            // product แม่ (top-level) ให้ parent_product_id = '0' สอดคล้องกับ findAllConsWithSubProducts()
            product.setParentProductId("0");
            product.setSequence("0");
            // สร้างใหม่ให้ active โดยปริยาย (หน้า add ยังไม่มี toggle)
            product.setActive("0".equals(active) ? "0" : "1");
            product.setSubProductActive("1");
            product.setUserCreate(onlineUser.getId());
            product.setTimeCreate(now);
            product.setUserUpdate(onlineUser.getId());
            product.setTimeUpdate(now);

            productDAO.save(product);

            // ตั้งค่าให้ result redirect ไป stock_cons_edit?productId=${productId} ได้
            this.productId = newProductId;

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

            Product product = productDAO.findById(productId);
            if (product == null) {
                log.warn("stockConsUpdate: product not found, productId=" + productId);
                return writeJson(false, "product not found");
            }
            // กันการยิง id ของ product ประเภทอื่น หรือ sub-product เข้ามาแก้ที่หน้านี้
            if (!PRODUCT_TYPE_CONSUMABLES.equals(product.getProductType())) {
                log.warn("stockConsUpdate: not a consumable, productId=" + productId
                        + ", productType=" + product.getProductType());
                return writeJson(false, "invalid product");
            }

            product.setProductNo(productNo.trim());
            product.setProductName(productName.trim());
            product.setProductType(productType.trim());
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
            if (parent == null || !PRODUCT_TYPE_CONSUMABLES.equals(parent.getProductType())) {
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
            if (parent == null || !PRODUCT_TYPE_CONSUMABLES.equals(parent.getProductType())) {
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
            if (parent == null || !PRODUCT_TYPE_CONSUMABLES.equals(parent.getProductType())) {
                log.warn("stockConsSubSave: parent not found/not consumable, parentId=" + parentId);
                return ERROR;
            }

            java.sql.Timestamp now = DateUtil.getCurrentTime();
            Integer newProductId = productDAO.getMaxId() + 1;

            // sequence ต่อท้ายของเดิม
            List<Product> siblings = productDAO.findByParentProductIds(
                    Collections.singletonList(String.valueOf(parentId)));
            int nextSeq = (siblings != null) ? siblings.size() : 0;

            Product sub = new Product();
            sub.setProductId(newProductId);
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