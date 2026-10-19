package com.cubesofttech.action;

import java.io.File;
import java.io.PrintWriter;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.DocStatusDAO;
import com.cubesofttech.dao.EquipmentRequestMrNewDAO;
import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.dao.PrDAO;
import com.cubesofttech.dao.PrDetailDAO;
import com.cubesofttech.dao.PrParentDAO;
import com.cubesofttech.dao.ProductDAO;
import com.cubesofttech.dao.UnitOfMeasureDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.DocStatus;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.Pr;
import com.cubesofttech.model.PrDetail;
import com.cubesofttech.model.PrParent;
import com.cubesofttech.model.Product;
import com.cubesofttech.model.UnitOfMeasure;
import com.cubesofttech.model.User;
import com.cubesofttech.service.FileAttachmentService;
import com.cubesofttech.util.DateUtil;
import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class PurchaseRequisitionAction extends ActionSupport {

    private static final long serialVersionUID = 2280661337420278284L;

    Logger log = Logger.getLogger(getClass());
    HttpServletRequest request = ServletActionContext.getRequest();
    HttpServletResponse response = ServletActionContext.getResponse();

    private User onlineUser = (User) request.getSession().getAttribute("onlineUser");

    @Autowired
    private PrDAO prDAO;

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private FileUploadDAO fileuploadDAO;

    @Autowired
    private PrDetailDAO prDetailDAO;

    @Autowired
    private PrParentDAO prParentDAO;

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private FileAttachmentService fileAttachmentService;

    @Autowired
    private UnitOfMeasureDAO unitOfMeasureDAO;

    @Autowired
    private DocStatusDAO docStatusDAO;

    @Autowired
    private EquipmentRequestMrNewDAO equipmentRequestMrDAO;

    private String prId;
    private String itemsType;
   
    private String includeSubProducts;

    public String getPrId() {
        return prId;
    }

    public void setPrId(String prId) {
        this.prId = prId;
    }

    public String getItemsType() {
        return itemsType;
    }

    public void setItemsType(String itemsType) {
        this.itemsType = itemsType;
    }

    public String getIncludeSubProducts() {
        return includeSubProducts;
    }

    public void setIncludeSubProducts(String includeSubProducts) {
        this.includeSubProducts = includeSubProducts;
    }

    private String description;
    private String prDetailCartJson;
    private String status;
    private String reason;
    private String fileId;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPrDetailCartJson() {
        return prDetailCartJson;
    }

    public void setPrDetailCartJson(String prDetailCartJson) {
        this.prDetailCartJson = prDetailCartJson;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    private String prDetailId;
    private String prParentId;
    private String productId;
    private String qty;
    private String unit;
    private String refLink;
    private String signUser;
    private String signDate;
    private String keepDetail;

    public String getPrDetailId() {
        return prDetailId;
    }

    public void setPrDetailId(String prDetailId) {
        this.prDetailId = prDetailId;
    }

    public String getPrParentId() {
        return prParentId;
    }

    public void setPrParentId(String prParentId) {
        this.prParentId = prParentId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getQty() {
        return qty;
    }

    public void setQty(String qty) {
        this.qty = qty;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getRefLink() {
        return refLink;
    }

    public void setRefLink(String refLink) {
        this.refLink = refLink;
    }

    public String getSignUser() {
        return signUser;
    }

    public void setSignUser(String signUser) {
        this.signUser = signUser;
    }

    public String getSignDate() {
        return signDate;
    }

    public void setSignDate(String signDate) {
        this.signDate = signDate;
    }

    public String getKeepDetail() { 
        return keepDetail; 
    }

    public void setKeepDetail(String keepDetail) { 
        this.keepDetail = keepDetail; 
    }

    // --- Multi-file attach ---
    private List<File> files;
    private List<String> filesFileName;

    public List<File> getFiles() {
        return files;
    }

    public void setFiles(List<File> files) {
        this.files = files;
    }

    public List<String> getFilesFileName() {
        return filesFileName;
    }

    public void setFilesFileName(List<String> filesFileName) {
        this.filesFileName = filesFileName;
    }

    public String purchaseRequisitionList() {
        try {
            if (onlineUser == null) {
                return ERROR;
            }

            List<Map<String, Object>> prList = prDAO.findAllPrWithUser();
            request.setAttribute("prList", prList);

            // --- Summary (อิง doc_status, page=pr) ---
            List<DocStatus> statuses = docStatusDAO.findByPage("pr");

            // นับจำนวนตาม status_code
            Map<String, Integer> summary = new HashMap<>();
            for (DocStatus ds : statuses) {
                summary.put(ds.getStatusCode(), 0);
            }
            for (Map<String, Object> pr : prList) {
                String code = String.valueOf(pr.get("status"));
                if (summary.containsKey(code)) {
                    summary.put(code, summary.get(code) + 1);
                }
            }

            // ชื่อสถานะและสีตาม code
            Map<String, String> statusNames = new HashMap<>();
            Map<String, String> statusColors = new HashMap<>();

            for (DocStatus ds : statuses) {
                statusNames.put(ds.getStatusCode(), ds.getStatusName());
                statusColors.put(ds.getStatusCode(), ds.getColor());
            }

            request.setAttribute("prSummary", summary);
            request.setAttribute("prStatusNames", statusNames);
            request.setAttribute("prStatusColors", statusColors);
            request.setAttribute("prSummaryTotal", prList.size());

            //นับ progress ของ pr_detail ---
            Map<String, Integer[]> prDetailProgress = prDetailDAO.countPrDetailProgressGroupByPr();
            request.setAttribute("prDetailProgress", prDetailProgress);

            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }

    public String purchaseRequisitionAdd() {
        try {
            if (onlineUser == null) {
                return ERROR;
            }

            String loginUser = onlineUser.getId();

            User u = userDAO.findById(loginUser);

            String signaturePath = fileAttachmentService.getFileUrl(u.getPathSignature());
            request.setAttribute("imgPathSignature", signaturePath);

            request.setAttribute("loginUser", u);

            Date requestDate = new Date();
            request.setAttribute("requestDateTime", requestDate);

            return SUCCESS;

        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }

    public String purchaseRequisitionEdit() {
        try {
            if (onlineUser == null) {
                return ERROR;
            }
            String logonUser = onlineUser.getId();
            Pr prList = prDAO.findById(prId);
            // log.debug("--- prList ----- "+ prList);
            request.setAttribute("prList", prList);

            if(prList.getUserCreate() != null) {
                User userCreate = userDAO.findById(prList.getUserCreate());
                // log.debug("--- userCreate ----- "+ userCreate);
                request.setAttribute("userCreate", userCreate);
            }

            if (Arrays.asList("4", "5", "6", "7").contains(prList.getStatus())) {
                String userUpdateId = prList.getUserUpdate();

                if (userUpdateId != null && !userUpdateId.trim().isEmpty()) {
                    User userUpdate = userDAO.findById(userUpdateId);
                    request.setAttribute("userUpdate", userUpdate);
                }
            }

            //--- Get SignUser ---
            User userSignUser = null;
            if (prList.getSignUser() != null) {
                userSignUser = userDAO.findById(prList.getSignUser());
            } else {
                userSignUser = userDAO.findById(logonUser);
            }
            request.setAttribute("userSignUser", userSignUser);
            String signaturePath = fileAttachmentService.getFileUrl(userSignUser != null ? userSignUser.getPathSignature() : null);
            request.setAttribute("imgPathSignature", signaturePath);

            //--- Get ApproveUser signature ---
            if (prList.getApproveUser() != null && !prList.getApproveUser().trim().isEmpty()) {
                User userApproveUser = userDAO.findById(prList.getApproveUser());
                request.setAttribute("userApproveUser", userApproveUser);

                String imgPathApproveSignature = fileAttachmentService.getFileUrl(userApproveUser != null ? userApproveUser.getPathSignature() : null);
                request.setAttribute("imgPathApproveSignature", imgPathApproveSignature);
            }

            List<Map<String, Object>> prDetailList = prDetailDAO.findPrDetailByPrId(String.valueOf(prList.getPrId()));
            // log.debug("--- prDetailList ----- "+ prDetailList);
            request.setAttribute("prDetailList", prDetailList);

            List<Map<String, Object>> prParentList = new java.util.ArrayList<>();
            if (prDetailList != null) {
                for (Map<String, Object> detail : prDetailList) {

                    // --- sources (pr_parent) ---
                    Object prDetailIdObj = detail.get("pr_detail_id");
                    if (prDetailIdObj != null) {
                        List<Map<String, Object>> parents = prParentDAO.findPrParentByPrDetailId(String.valueOf(prDetailIdObj));
                        if (parents != null) {
                            Object detailRefObj = detail.get("ref_link");
                            String detailRef = detailRefObj == null ? "" : String.valueOf(detailRefObj).trim();
                            boolean detailRefUsed = false;

                            for (Map<String, Object> p : parents) {
                                Object pMrIdObj = p.get("mr_id");
                                String pMrId = pMrIdObj == null ? "" : String.valueOf(pMrIdObj).trim();
                                if (pMrId.isEmpty()) {
                                    p.put("ref_link", detailRefUsed ? "" : detailRef);
                                    detailRefUsed = true;
                                } else {
                                    Object mrRefObj = p.get("mr_ref_link");
                                    p.put("ref_link", mrRefObj == null ? "" : String.valueOf(mrRefObj));
                                }

                                Object parentUnitIdObj = p.get("unit");
                                if (parentUnitIdObj != null && !String.valueOf(parentUnitIdObj).trim().isEmpty()) {
                                    Integer parentUnitId = Integer.valueOf(String.valueOf(parentUnitIdObj).trim());
                                    UnitOfMeasure parentUom = unitOfMeasureDAO.findById(parentUnitId);
                                    if (parentUom != null) {
                                        p.put("unit_name", parentUom.getUnitName());

                                        Object amountObj = p.get("amount");
                                        double srcAmount = amountObj != null ? Double.parseDouble(String.valueOf(amountObj)) : 0d;
                                        Integer conversionRate = parentUom.getConversionRate();
                                        double rate = (conversionRate != null) ? conversionRate : 1d;
                                        p.put("base_qty", srcAmount * rate);
                                    }
                                }
                            }
                            prParentList.addAll(parents);
                            detail.put("prParentList", parents);
                        }
                    }

                    // --- product + parent name ---
                    Object productIdObj = detail.get("product_id");
                    if (productIdObj != null) {
                        Product product = productDAO.findById(Integer.valueOf(String.valueOf(productIdObj)));
                        if (product != null) {
                            detail.put("product_name", product.getProductName());
                            detail.put("product_type", product.getProductType());

                            // ตัวแม่ parent_product_id = "0" → ไม่ใส่ parent_product_name
                            String pp = product.getParentProductId() == null ? "" : product.getParentProductId().trim();
                            if (!pp.isEmpty() && !"0".equals(pp)) {
                                Product parentProduct = productDAO.findById(Integer.valueOf(pp));
                                if (parentProduct != null) {
                                    detail.put("parent_product_name", parentProduct.getProductName());
                                }
                            }
                        }
                    }

                    // --- unit name ---
                    Object unitIdObj = detail.get("unit");
                    if (unitIdObj != null && !String.valueOf(unitIdObj).trim().isEmpty()) {
                        Integer unitId = Integer.valueOf(String.valueOf(unitIdObj).trim());
                        UnitOfMeasure uom = unitOfMeasureDAO.findById(unitId);
                        if (uom != null) {
                            detail.put("unit_name", uom.getUnitName());
                        }
                    }
                }
            }
            // log.debug("--- prParentList ----- " + prParentList);
            request.setAttribute("prParentList", prParentList);

            Map<String, String> statusNames = new HashMap<>();
            Map<String, String> statusColors = new HashMap<>();

            for (DocStatus ds : docStatusDAO.findByPage("pr")) {
                statusNames.put(ds.getStatusCode(), ds.getStatusName());
                statusColors.put(ds.getStatusCode(), ds.getColor());
            }
            request.setAttribute("prStatusNames", statusNames);
            request.setAttribute("prStatusColors", statusColors);

            List<FileUpload> attachmentList = fileAttachmentService.listAttachments("pr", String.valueOf(prList.getPrId()));
            request.setAttribute("attachmentList", attachmentList);


            User u = userDAO.findById(logonUser);
            request.setAttribute("loginUser", u);

            Date requestDate = new Date();
            request.setAttribute("requestDateTime", requestDate);

            return SUCCESS;

        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }

    // --- generate prId ---
    private String generateNewPrId() throws Exception {
        String year = String.valueOf(java.time.Year.now().getValue());
        String prefix = "PR" + year;
        String maxPrId = prDAO.findMaxPrIdByYear(prefix + "%");

        long nextSeq = 1L;
        if (maxPrId != null && maxPrId.length() >= prefix.length() + 8) {
            String seqPart = maxPrId.substring(prefix.length());
            try {
                nextSeq = Long.parseLong(seqPart) + 1;
            } catch (NumberFormatException nfe) {
                nextSeq = 1L;
            }
        }
        return prefix + String.format("%08d", nextSeq);
    }

    private String cleanText(String s) {
        if (s == null) return null;
        String t = s.replace("\r\n", "\n").trim();
        return t.isEmpty() ? null : t;
    }

    private double toDouble(Object val) {
        if (val == null) return 0d;
        try {
            return Double.parseDouble(String.valueOf(val));
        } catch (Exception e) {
            return 0d;
        }
    }

    private Map<String, Object> jsonObjectToMap(JSONObject obj) {
        Map<String, Object> map = new HashMap<>();
        java.util.Iterator<String> keys = obj.keys();
        while (keys.hasNext()) {
            String key = keys.next();
            Object val = obj.get(key);
            map.put(key, (val == JSONObject.NULL) ? null : val);
        }
        return map;
    }

    // บันทึก pr_detail (1 แถวต่อ item) + pr_parent (1 แถวต่อ source) คืนค่า mrId ที่ถูกดึงมา 
    private List<String> saveCartItems(String targetPrId, String cartJson, String loginUserId,
                                    List<String> debugLog) throws Exception {
        List<String> pulledMrIds = new ArrayList<>();
        if (cartJson == null || cartJson.trim().isEmpty()) return pulledMrIds;

        List<Map<String, Object>> cartItems = new ArrayList<>();
        JSONArray jsonArray = new JSONArray(cartJson);
        for (int i = 0; i < jsonArray.length(); i++) {
            cartItems.add(jsonObjectToMap(jsonArray.getJSONObject(i)));
        }
        debugLog.add("cartItems size = " + cartItems.size());

        long nextDetailSeq = prDetailDAO.getMaxId() + 1;
        long nextParentSeq = prParentDAO.getMaxId() + 1;
        long detailSeq = 0;
        long parentSeq = 0;

        for (Map<String, Object> item : cartItems) {
            double qty = toDouble(item.get("qty"));  // รวมเป็นหน่วยเล็กสุด
            String productId = item.get("productId") != null ? String.valueOf(item.get("productId")) : null;
            String unitVal = item.get("unit") != null ? String.valueOf(item.get("unit")) : null; // หน่วยเล็กสุด
            String descVal = item.get("description") != null ? String.valueOf(item.get("description")) : null;

            Product p = productDAO.findById(Integer.valueOf(productId));
            String dbProductId = p.getProductId().toString();
            String dbParentId = String.valueOf(p.getParentProductId());

            // --- sources ---
            List<Map<String, Object>> sources = new ArrayList<>();
            Object sourcesObj = item.get("sources");
            if (sourcesObj instanceof JSONArray) {
                JSONArray arr = (JSONArray) sourcesObj;
                for (int i = 0; i < arr.length(); i++) {
                    sources.add(jsonObjectToMap(arr.getJSONObject(i)));
                }
            }

            // ref link
            String manualRefLink = null;
            for (Map<String, Object> src : sources) {
                String mr = src.get("mrId") != null ? String.valueOf(src.get("mrId")).trim() : "";
                String r = src.get("refLink") != null ? String.valueOf(src.get("refLink")).trim() : "";
                if (mr.isEmpty() && !r.isEmpty()) { manualRefLink = r; break; }
            }

            // --- item ที่ต่อเข้ากับ pr_detail เดิมใน DB: เพิ่มเฉพาะ pr_parent แล้วบวก amount_total ---
            String existingDetailId = item.get("prDetailId") != null ? String.valueOf(item.get("prDetailId")).trim() : "";
            if (!existingDetailId.isEmpty()) {
                PrDetail existing = prDetailDAO.findById(existingDetailId);
                if (existing != null && targetPrId.equals(existing.getPrId())) {

                    applyExistingDetailEdits(existing, existingDetailId, item, loginUserId);

                    // แก้ qty/unit ของ pr_parent เดิมที่มี sourceEdits
                    double editDeltaBase = 0d;
                    Object editsObj = item.get("sourceEdits");
                    if (editsObj instanceof JSONArray) {
                        JSONArray editArr = (JSONArray) editsObj;
                        for (int i = 0; i < editArr.length(); i++) {
                            Map<String, Object> ed = jsonObjectToMap(editArr.getJSONObject(i));
                            String editParentId = ed.get("prParentId") != null ? String.valueOf(ed.get("prParentId")).trim() : "";
                            double newQty = toDouble(ed.get("qty"));
                            String newUnit = ed.get("unit") != null ? String.valueOf(ed.get("unit")).trim() : "";
                            if (editParentId.isEmpty() || newQty <= 0 || newUnit.isEmpty()) continue;

                            PrParent parent = prParentDAO.findById(editParentId);
                            if (parent == null || !existingDetailId.equals(parent.getPrDetailId())) continue;

                            double oldBase = toDouble(parent.getAmount()) * unitRate(parent.getUnit());
                            double newBase = newQty * unitRate(newUnit);
                            editDeltaBase += (newBase - oldBase);

                            parent.setAmount(newQty);
                            parent.setUnit(newUnit);
                            parent.setUserUpdate(loginUserId);
                            parent.setTimeUpdate(DateUtil.getCurrentTime());
                            prParentDAO.update(parent);
                        }
                    }

                    double addBaseQty = 0d;
                    for (Map<String, Object> src : sources) {
                        String mrIdVal = src.get("mrId") != null ? String.valueOf(src.get("mrId")).trim() : null;
                        if (mrIdVal != null && mrIdVal.isEmpty()) mrIdVal = null;

                        double srcQty = toDouble(src.get("qty"));
                        double srcBase = src.get("baseQty") != null ? toDouble(src.get("baseQty")) : srcQty;
                        String srcUnitVal = src.get("unit") != null ? String.valueOf(src.get("unit")) : unitVal;
                        String srcDesc = src.get("description") != null ? String.valueOf(src.get("description")) : null;

                        if (mrIdVal != null) pulledMrIds.add(mrIdVal);
                        addBaseQty += srcBase;

                        savePrParent(String.valueOf(nextParentSeq + parentSeq++), existingDetailId, mrIdVal,
                                dbProductId, dbParentId, srcQty, srcUnitVal, srcDesc, loginUserId);
                    }
                    double current = existing.getAmountTotal() == null ? 0d : existing.getAmountTotal();
                    existing.setAmountTotal(current + addBaseQty + editDeltaBase);
                    if (manualRefLink != null && (existing.getRefLink() == null || existing.getRefLink().trim().isEmpty())) {
                        existing.setRefLink(manualRefLink);
                    }
                    existing.setUserUpdate(loginUserId);
                    existing.setTimeUpdate(DateUtil.getCurrentTime());
                    prDetailDAO.update(existing);
                    continue; // ไม่สร้าง PrDetail ใหม่
                }
            }

            // --- PrDetail ---
            String prDetailId = String.valueOf(nextDetailSeq + detailSeq++);
            PrDetail detail = new PrDetail();
            detail.setPrDetailId(prDetailId);
            detail.setPrId(targetPrId);
            detail.setProductId(dbProductId);
            detail.setParentId(dbParentId);
            detail.setStatus("0");
            detail.setUnit(unitVal);
            detail.setAmountTotal(qty);
            detail.setDescription(cleanText(descVal));
            detail.setUserCreate(loginUserId);
            detail.setRefLink(manualRefLink);
            detail.setTimeCreate(DateUtil.getCurrentTime());
            detail.setUserUpdate(loginUserId);
            detail.setTimeUpdate(DateUtil.getCurrentTime());
            prDetailDAO.save(detail);

            // --- PrParent ---
            if (sources.isEmpty()) {
                String mrIdVal = item.get("mrId") != null ? String.valueOf(item.get("mrId")) : null;
                        savePrParent(String.valueOf(nextParentSeq + parentSeq++), prDetailId, mrIdVal,dbProductId,
                        dbParentId, qty, unitVal, descVal, loginUserId);
                if (mrIdVal != null && !mrIdVal.trim().isEmpty()) pulledMrIds.add(mrIdVal);
            } else {
                for (Map<String, Object> src : sources) {
                    String mrIdVal = src.get("mrId") != null ? String.valueOf(src.get("mrId")).trim() : null;
                    if (mrIdVal != null && mrIdVal.isEmpty()) mrIdVal = null;

                    double srcQty = toDouble(src.get("qty"));
                    // แต่ละ source เก็บหน่วยดิบที่เลือกไว้ตอนนั้น ไม่ใช่หน่วยเล็กสุดของ pr_detail
                    String srcUnitVal = src.get("unit") != null ? String.valueOf(src.get("unit")) : unitVal;
                    String srcDesc = src.get("description") != null ? String.valueOf(src.get("description")) : descVal;

                    if (mrIdVal != null) pulledMrIds.add(mrIdVal);

                    savePrParent(String.valueOf(nextParentSeq + parentSeq++), prDetailId, mrIdVal,
                            dbProductId, dbParentId, srcQty, srcUnitVal, srcDesc, loginUserId);
                }
            }
        }
        return pulledMrIds;
    }

    private void applyExistingDetailEdits(PrDetail detail, String detailId, Map<String, Object> item, String loginUserId) throws Exception {
        String editProductId = item.get("editProductId") != null ? String.valueOf(item.get("editProductId")).trim() : "";
        if (!editProductId.isEmpty() && !editProductId.equals(detail.getProductId())) {
            changeDetailProduct(detail, detailId, editProductId, loginUserId);
        }
        if (item.get("editDescription") != null) {
            detail.setDescription(cleanText(String.valueOf(item.get("editDescription"))));
        }
        if (item.get("editRefLink") != null) {
            detail.setRefLink(String.valueOf(item.get("editRefLink")).trim());
        }
    }

    private void changeDetailProduct(PrDetail detail, String detailId, String newProductId, String loginUserId) throws Exception {
        Product np = productDAO.findById(Integer.valueOf(newProductId));
        if (np == null) throw new IllegalStateException("ไม่พบสินค้าที่เลือก: " + newProductId);
        String newParentId = String.valueOf(np.getParentProductId());

        String eff = (newParentId != null && !newParentId.trim().isEmpty() && !"0".equals(newParentId.trim()))
                ? newParentId.trim() : newProductId;
        List<UnitOfMeasure> mains = unitOfMeasureDAO.findMainUnitsByProductIds(
                java.util.Collections.singletonList(eff));
        if (mains == null || mains.isEmpty()) throw new IllegalStateException("สินค้าที่เลือกยังไม่มีหน่วยนับ: " + eff);
        String newBaseUnit = String.valueOf(mains.get(0).getUnitId());

        List<Map<String, Object>> rows = prParentDAO.findPrParentByPrDetailId(detailId);
        if (rows != null) {
            for (Map<String, Object> row : rows) {
                PrParent pp = prParentDAO.findById(String.valueOf(row.get("pr_parent_id")));
                if (pp == null) continue;
                double baseQty = toDouble(pp.getAmount()) * unitRate(pp.getUnit());
                pp.setProductId(newProductId);
                pp.setParentId(newParentId);
                pp.setUnit(newBaseUnit);
                pp.setAmount(baseQty);
                pp.setUserUpdate(loginUserId);
                pp.setTimeUpdate(DateUtil.getCurrentTime());
                prParentDAO.update(pp);
            }
        }
        detail.setProductId(newProductId);
        detail.setParentId(newParentId);
        detail.setUnit(newBaseUnit);
    }

    private void savePrParent(String prParentId, String prDetailId, String mrId, String productId,
                            String parentId, double amount, String unit, String desc,String loginUserId) throws Exception {
        PrParent parent = new PrParent();
        parent.setPrParentId(prParentId);
        parent.setPrDetailId(prDetailId);
        parent.setMrId(mrId);
        parent.setProductId(productId);
        parent.setParentId(parentId);
        parent.setAmount(amount);
        parent.setUnit(cleanText(unit));
        parent.setDescription(cleanText(desc));
        parent.setUserCreate(loginUserId);
        parent.setTimeCreate(DateUtil.getCurrentTime());
        parent.setUserUpdate(loginUserId);
        parent.setTimeUpdate(DateUtil.getCurrentTime());
        prParentDAO.save(parent);
    }

    public String savePr() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
            String loginUserId = onlineUser.getId();

            String newPrId = generateNewPrId();
            debugLog.add("newPrId = " + newPrId);

            // --- Header ---
            Pr pr = new Pr();
            pr.setPrId(newPrId);

            if (signDate != null && !signDate.trim().isEmpty()) {
                pr.setSignDate(java.sql.Timestamp.valueOf(signDate));
                pr.setSignUser(loginUserId);
            }

            pr.setDescription(cleanText(description));
            pr.setUserCreate(loginUserId);
            pr.setTimeCreate(DateUtil.getCurrentTime());
            String prStatus = (status != null && !status.trim().isEmpty()) ? status : "1";
            pr.setStatus(prStatus); // 1 = Draft

            prDAO.save(pr);

            // --- Detail + Parent  ---
            List<String> pulledMrIds = saveCartItems(newPrId, prDetailCartJson, loginUserId, debugLog);
            debugLog.add("pulledMrIds = " + pulledMrIds);

            // --- Attach files (page='pr', pageId= newPrId) ---
            fileAttachmentService.attach(files, filesFileName, "pr", newPrId, loginUserId,
                request.getServletContext().getRealPath("/"));

            Map<String, Object> result = new HashMap<>();
            result.put("prId", newPrId);
            writeJson(result, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }


    public String updatePr() {
        List<String> debugLog = new ArrayList<>();

        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }

            if (prId == null || prId.trim().isEmpty()) {
                debugLog.add("prId missing");
                writeJson(null, debugLog);
                return NONE;
            }

            String loginUserId = onlineUser.getId();

            // --- Header ---
            Pr pr = prDAO.findById(prId);

            if (pr == null) {
                debugLog.add("PR not found : " + prId);
                writeJson(null, debugLog);
                return NONE;
            }

            pr.setDescription(cleanText(description));
            pr.setUserUpdate(loginUserId);
            pr.setTimeUpdate(DateUtil.getCurrentTime());

            if (status != null && !status.trim().isEmpty()) {
                pr.setStatus(status);
            }

            // --- Detail + Parent ---
            // prDetailCartJson เฉพาะรายการใหม่ที่เพิ่มระหว่างแก้ไข (ยังไม่ save ลง DB) เท่านั้น
            List<String> pulledMrIds = saveCartItems(prId, prDetailCartJson, loginUserId, debugLog);
            debugLog.add("pulledMrIds = " + pulledMrIds);

            // --- Attach files (page='pr', pageId=prId) ---
            String serverRealPath = ServletActionContext.getServletContext().getRealPath("/");
            fileAttachmentService.attach(files, filesFileName, "pr", prId, loginUserId, serverRealPath);

            prDAO.update(pr);

            Map<String, Object> result = new HashMap<>();
            result.put("prId", prId);
            writeJson(result, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    public String updatePrDetail() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
            if (prDetailId == null || prDetailId.trim().isEmpty()) {
                writeJson(null, debugLog);
                return NONE;
            }

            PrDetail detail = prDetailDAO.findById(prDetailId);
            if (detail == null) {
                debugLog.add("prDetail not found: " + prDetailId);
                writeJson(null, debugLog);
                return NONE;
            }

            if (prId == null || prId.trim().isEmpty() || !prId.equals(detail.getPrId())) {
                debugLog.add("prDetailId " + prDetailId + " does not belong to prId " + prId);
                writeJson(null, debugLog);
                return NONE;
            }

            Pr prForUpdateDetail = prDAO.findById(prId);
            if (prForUpdateDetail == null || !"1".equals(prForUpdateDetail.getStatus())) {
                debugLog.add("PR not found or not Draft: " + prId);
                writeJson(null, debugLog);
                return NONE;
            }

            // ถ้าเปลี่ยนสินค้า ต้องอัปเดต pr_parent + หน่วยให้ตามไปด้วย
            String newProductId = productId == null ? "" : productId.trim();
            if (newProductId.isEmpty()) {
                debugLog.add("productId missing");
                Map<String, Object> result = new HashMap<>();
                result.put("success", false);
                result.put("message", "กรุณาเลือกสินค้า");
                writeJson(result, debugLog);
                return NONE;
            }

            if (!newProductId.equals(detail.getProductId())) {
                Product np = productDAO.findById(Integer.valueOf(newProductId));
                if (np == null) {
                    debugLog.add("product not found: " + newProductId);
                    Map<String, Object> result = new HashMap<>();
                    result.put("success", false);
                    result.put("message", "ไม่พบสินค้าที่เลือก");
                    writeJson(result, debugLog);
                    return NONE;
                }
                String newParentId = String.valueOf(np.getParentProductId());

                // หน่วยเล็กสุดของสินค้าใหม่ (ถ้าเป็นสินค้าลูกให้ใช้ของตัวแม่)
                String eff = (newParentId != null && !newParentId.trim().isEmpty() && !"0".equals(newParentId.trim()))
                        ? newParentId.trim() : newProductId;
                List<UnitOfMeasure> mains = unitOfMeasureDAO.findMainUnitsByProductIds(
                        java.util.Collections.singletonList(eff));
                if (mains == null || mains.isEmpty()) {
                    debugLog.add("no main unit for product " + eff);
                    Map<String, Object> result = new HashMap<>();
                    result.put("success", false);
                    result.put("message", "สินค้าที่เลือกยังไม่มีหน่วยนับ");
                    writeJson(result, debugLog);
                    return NONE;
                }
                String newBaseUnit = String.valueOf(mains.get(0).getUnitId());

                // อัปเดต pr_parent ทุกแถวของการ์ดนี้ (mr_id ไม่แตะ)
                List<Map<String, Object>> rows = prParentDAO.findPrParentByPrDetailId(prDetailId);
                for (Map<String, Object> row : rows) {
                    PrParent pp = prParentDAO.findById(String.valueOf(row.get("pr_parent_id")));
                    if (pp == null) continue;

                    // แปลงจำนวนเดิมเป็นหน่วยเล็กสุดก่อน ยอดรวมจะได้ไม่เพี้ยน
                    double rate = 1d;
                    if (pp.getUnit() != null && !pp.getUnit().trim().isEmpty()) {
                        UnitOfMeasure old = unitOfMeasureDAO.findById(Integer.valueOf(pp.getUnit().trim()));
                        if (old != null && old.getConversionRate() != null) rate = old.getConversionRate();
                    }
                    double baseQty = pp.getAmount() * rate;

                    pp.setProductId(newProductId);
                    pp.setParentId(newParentId);
                    pp.setUnit(newBaseUnit);
                    pp.setAmount(baseQty);
                    pp.setUserUpdate(onlineUser.getId());
                    pp.setTimeUpdate(DateUtil.getCurrentTime());
                    prParentDAO.update(pp);
                }

                detail.setProductId(newProductId);
                detail.setParentId(newParentId);
                detail.setUnit(newBaseUnit);
            }

            detail.setDescription(cleanText(description));
            if (refLink != null) {
                detail.setRefLink(refLink.trim());
            }
            detail.setUserUpdate(onlineUser.getId());
            detail.setTimeUpdate(DateUtil.getCurrentTime());

            prDetailDAO.update(detail);

            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            writeJson(result, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    public String deletePrDetail() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
            if (prDetailId == null || prDetailId.trim().isEmpty()) {
                writeJson(null, debugLog);
                return NONE;
            }

            PrDetail detailToDelete = prDetailDAO.findById(prDetailId);
            if (detailToDelete == null || prId == null || prId.trim().isEmpty()
                    || !prId.equals(detailToDelete.getPrId())) {
                debugLog.add("prDetailId " + prDetailId + " does not belong to prId " + prId);
                writeJson(null, debugLog);
                return NONE;
            }

            Pr prForDeleteDetail = prDAO.findById(prId);
            if (prForDeleteDetail == null || !"1".equals(prForDeleteDetail.getStatus())) {
                debugLog.add("PR not found or not Draft: " + prId);
                writeJson(null, debugLog);
                return NONE;
            }

            prParentDAO.deleteByPrDetailId(prDetailId);
            prDetailDAO.deleteByPrIdAndPrDetailId(prDetailId, prId);

            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            writeJson(result, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    public String updatePrSource() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
            if (prParentId == null || prParentId.trim().isEmpty()
                    || prDetailId == null || prDetailId.trim().isEmpty()
                    || prId == null || prId.trim().isEmpty()) {
                debugLog.add("prParentId/prDetailId/prId missing");
                Map<String, Object> result = new HashMap<>();
                result.put("success", null);
                writeJson(result, debugLog);
                return NONE;
            }

            double qtyVal = toDouble(qty);
            if (qtyVal <= 0 || unit == null || unit.trim().isEmpty()) {
                debugLog.add("invalid qty/unit");
                Map<String, Object> result = new HashMap<>();
                result.put("success", null);
                writeJson(result, debugLog);
                return NONE;
            }

            Pr pr = prDAO.findById(prId);
            if (pr == null || !"1".equals(pr.getStatus())) {
                debugLog.add("PR not found or not Draft: " + prId);
                Map<String, Object> result = new HashMap<>();
                result.put("success", null);
                writeJson(result, debugLog);
                return NONE;
            }

            PrDetail detail = prDetailDAO.findById(prDetailId);
            if (detail == null || !prId.equals(detail.getPrId())) {
                debugLog.add("prDetailId " + prDetailId + " does not belong to prId " + prId);
                Map<String, Object> result = new HashMap<>();
                result.put("success", null);
                writeJson(result, debugLog);
                return NONE;
            }

            PrParent parent = prParentDAO.findById(prParentId);
            if (parent == null || !prDetailId.equals(parent.getPrDetailId())) {
                debugLog.add("prParentId " + prParentId + " does not belong to prDetailId " + prDetailId);
                Map<String, Object> result = new HashMap<>();
                result.put("success", null);
                writeJson(result, debugLog);
                return NONE;
            }

            // mr_id ของแถวนี้ (ถ้ามี) ไม่ถูกแก้
            parent.setAmount(qtyVal);
            parent.setUnit(unit);
            parent.setUserUpdate(onlineUser.getId());
            parent.setTimeUpdate(DateUtil.getCurrentTime());
            prParentDAO.update(parent);

            // คำนวณ pr_detail.amount_total ใหม่ = ผลรวม base_qty (amount x conversionRate) ของ pr_parent ทุกแถวของ detail นี้
            double newAmountTotal = 0d;
            List<Map<String, Object>> parents = prParentDAO.findPrParentByPrDetailId(prDetailId);
            if (parents != null) {
                for (Map<String, Object> p : parents) {
                    Object amountObj = p.get("amount");
                    double srcAmount = amountObj != null ? Double.parseDouble(String.valueOf(amountObj)) : 0d;
                    Object unitIdObj = p.get("unit");
                    double rate = 1d;
                    if (unitIdObj != null && !String.valueOf(unitIdObj).trim().isEmpty()) {
                        UnitOfMeasure uom = unitOfMeasureDAO.findById(Integer.valueOf(String.valueOf(unitIdObj).trim()));
                        if (uom != null && uom.getConversionRate() != null) {
                            rate = uom.getConversionRate();
                        }
                    }
                    newAmountTotal += srcAmount * rate;
                }
            }

            detail.setAmountTotal(newAmountTotal);
            detail.setUserUpdate(onlineUser.getId());
            detail.setTimeUpdate(DateUtil.getCurrentTime());
            prDetailDAO.update(detail);

            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            writeJson(result, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            Map<String, Object> result = new HashMap<>();
            result.put("success", null);
            writeJson(result, debugLog);
            return NONE;
        }
    }

    public String deletePrSource() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
            if (prParentId == null || prParentId.trim().isEmpty()
                    || prDetailId == null || prDetailId.trim().isEmpty()
                    || prId == null || prId.trim().isEmpty()) {
                debugLog.add("prParentId/prDetailId/prId missing");
                Map<String, Object> result = new HashMap<>();
                result.put("success", null);
                writeJson(result, debugLog);
                return NONE;
            }

            Pr pr = prDAO.findById(prId);
            if (pr == null || !"1".equals(pr.getStatus())) {
                debugLog.add("PR not found or not Draft: " + prId);
                Map<String, Object> result = new HashMap<>();
                result.put("success", null);
                writeJson(result, debugLog);
                return NONE;
            }

            PrDetail detail = prDetailDAO.findById(prDetailId);
            if (detail == null || !prId.equals(detail.getPrId())) {
                debugLog.add("prDetailId " + prDetailId + " does not belong to prId " + prId);
                Map<String, Object> result = new HashMap<>();
                result.put("success", null);
                writeJson(result, debugLog);
                return NONE;
            }

            PrParent parent = prParentDAO.findById(prParentId);
            if (parent == null || !prDetailId.equals(parent.getPrDetailId())) {
                debugLog.add("prParentId " + prParentId + " does not belong to prDetailId " + prDetailId);
                Map<String, Object> result = new HashMap<>();
                result.put("success", null);
                writeJson(result, debugLog);
                return NONE;
            }

            List<Map<String, Object>> parentsBefore = prParentDAO.findPrParentByPrDetailId(prDetailId);
            boolean keep = "true".equals(keepDetail); //มี source ใหม่ค้างรอ save
            if (!keep && (parentsBefore == null || parentsBefore.size() <= 1)) {
                debugLog.add("only one pr_parent row left, use delete_pr_detail instead");
                Map<String, Object> result = new HashMap<>();
                result.put("success", null);
                writeJson(result, debugLog);
                return NONE;
            }


            prParentDAO.delete(parent);

            // คำนวณ pr_detail.amount_total ใหม่จากแถวที่เหลือ
            double newAmountTotal = 0d;
            List<Map<String, Object>> parentsAfter = prParentDAO.findPrParentByPrDetailId(prDetailId);
            if (parentsAfter != null) {
                for (Map<String, Object> p : parentsAfter) {
                    Object amountObj = p.get("amount");
                    double srcAmount = amountObj != null ? Double.parseDouble(String.valueOf(amountObj)) : 0d;
                    Object unitIdObj = p.get("unit");
                    double rate = 1d;
                    if (unitIdObj != null && !String.valueOf(unitIdObj).trim().isEmpty()) {
                        UnitOfMeasure uom = unitOfMeasureDAO.findById(Integer.valueOf(String.valueOf(unitIdObj).trim()));
                        if (uom != null && uom.getConversionRate() != null) {
                            rate = uom.getConversionRate();
                        }
                    }
                    newAmountTotal += srcAmount * rate;
                }
            }

            detail.setAmountTotal(newAmountTotal);
            detail.setUserUpdate(onlineUser.getId());
            detail.setTimeUpdate(DateUtil.getCurrentTime());
            prDetailDAO.update(detail);

            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            writeJson(result, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            Map<String, Object> result = new HashMap<>();
            result.put("success", null);
            writeJson(result, debugLog);
            return NONE;
        }
    }

    public String updateStatusPr() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }

            if ("4".equals(status)) { // Return
                if (reason == null || reason.trim().length() < 10) {
                    debugLog.add("reason invalid for return");
                    writeJson(null, debugLog);
                    return NONE;
                }
            }else if ("5".equals(status)) { // Rejected
                if (reason == null || reason.trim().length() < 10) {
                    debugLog.add("reason invalid for reject");
                    writeJson(null, debugLog);
                    return NONE;
                }
            }

            String loginUserId = onlineUser.getId();

            Pr pr = prDAO.findById(prId);
            pr.setStatus(status);
            if (reason != null && !reason.trim().isEmpty()) {
                pr.setReason(reason.trim());
            }

            if ("1".equals(status)) {
                pr.setReason(null);
            } 
            
            if ("3".equals(status)) {
                pr.setApproveUser(loginUserId);
                pr.setApproveDate(DateUtil.getCurrentTime());
            }
            pr.setUserUpdate(loginUserId);
            pr.setTimeUpdate(DateUtil.getCurrentTime());

            prDAO.update(pr);

            Map<String, Object> result = new HashMap<>();
            result.put("prId", prId);
            writeJson(result, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    // --- helper เขียน JSON ---
    private void writeJson(Object data) {
        writeJson(data, null);
    }

    private void writeJson(Object data, List<String> debugMessages) {
        try {
            Map<String, Object> envelope = new HashMap<>();
            envelope.put("data", data);
            if (debugMessages != null) {
                envelope.put("debug", debugMessages);
            }
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print(new Gson().toJson(envelope));
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void writeJsonError() {
        try {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.print("{\"error\":true}");
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String prPerformDelete() {
        try {
            if (onlineUser == null || prId == null || prId.trim().isEmpty()) {
                return ERROR;
            }
            String loginUserId = onlineUser.getId();
            Pr pr = prDAO.findById(prId);
            if (pr != null) {
                pr.setStatus("6");
                pr.setUserUpdate(loginUserId);
                pr.setTimeUpdate(DateUtil.getCurrentTime());

                prDAO.update(pr);
            }

            return SUCCESS;

        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }

    public String confirmPrSign() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
            if (prId == null || prId.trim().isEmpty()) {
                debugLog.add("prId missing");
                writeJson(null, debugLog);
                return NONE;
            }

            Pr pr = prDAO.findById(prId);
            if (pr == null) {
                debugLog.add("PR not found: " + prId);
                writeJson(null, debugLog);
                return NONE;
            }

            // กันกดซ้ำ / กันแก้ทับของเดิม
            if (pr.getSignDate() != null) {
                Map<String, Object> result = new HashMap<>();
                result.put("success", false);
                result.put("message", "PR นี้มีการลงชื่อผู้ขอเบิกแล้ว");
                writeJson(result, debugLog);
                return NONE;
            }

            String loginUserId = onlineUser.getId();
            java.sql.Timestamp now = DateUtil.getCurrentTime();

            pr.setSignUser(loginUserId);
            pr.setSignDate(now);
            prDAO.update(pr);

            String displayName = (onlineUser.getNameEN() != null && !onlineUser.getNameEN().trim().isEmpty())
                    ? onlineUser.getNameEN() : onlineUser.getName();

            DateTimeFormatter displayFmt = DateTimeFormatter.ofPattern("d MMM yyyy, H:mm", Locale.ENGLISH);
            String signDateDisplay = now.toLocalDateTime().format(displayFmt);

            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("signUserName", displayName);
            result.put("signDateDisplay", signDateDisplay);
            writeJson(result, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    public String deletePrAttachment() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
            if (fileId == null || fileId.trim().isEmpty()) {
                debugLog.add("fileId missing");
                writeJson(null, debugLog);
                return NONE;
            }

            String serverRealPath = ServletActionContext.getServletContext().getRealPath("/");
            fileAttachmentService.deleteByIds(java.util.Collections.singletonList(fileId), serverRealPath);

            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            writeJson(result, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    public String searchApprovedMr() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
            // MR ที่ pr_parent และ PR status ไม่ใช่ 5,6 จะถูกตัดออก
            List<Map<String, Object>> mrDetailList = equipmentRequestMrDAO.findApprovedMrForMrSearch();

            //รวม product_id ที่ต้องใช้หา unit
            Set<String> productIds = new LinkedHashSet<>();
            for (Map<String, Object> row : mrDetailList) {
                String pid = effectiveProductId(row);
                if (pid != null) {
                    productIds.add(pid);
                }
            }

            //ดึงหน่วยหลัก Map ตาม product_id
            Map<String, UnitOfMeasure> unitMap = new HashMap<>();
            if (!productIds.isEmpty()) {
                List<UnitOfMeasure> units = unitOfMeasureDAO.findMainUnitsByProductIds(new ArrayList<>(productIds));
                if (units != null) {
                    for (UnitOfMeasure u : units) {
                        if (u.getProductId() != null) {
                            unitMap.put(String.valueOf(u.getProductId()).trim(), u);
                        }
                    }
                }
            }

            for (Map<String, Object> row : mrDetailList) {
                UnitOfMeasure u = unitMap.get(effectiveProductId(row));
                row.put("unit", u != null ? u.getUnitId() : null);
                row.put("unit_name", u != null ? u.getUnitName() : null);
                // log.debug("MR row keys/values: " + row);
            }

            Map<String, Object> data = new HashMap<>();
            data.put("mrDetailList", mrDetailList);
            writeJson(data, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    private double unitRate(String unitId) {
        try {
            if (unitId == null || unitId.trim().isEmpty()) return 1d;
            UnitOfMeasure u = unitOfMeasureDAO.findById(Integer.valueOf(unitId.trim()));
            if (u != null && u.getConversionRate() != null) return u.getConversionRate();
        } catch (Exception e) { }
        return 1d;
    }

    private String effectiveProductId(Map<String, Object> row) {
        Object parent = row.get("parent_id");
        Object product = row.get("product_id");
        String p = parent == null ? null : String.valueOf(parent).trim();
        if (p != null && !p.isEmpty() && !"0".equals(p)) {
            return p;
        }
        return product == null ? null : String.valueOf(product).trim();
    }

}
