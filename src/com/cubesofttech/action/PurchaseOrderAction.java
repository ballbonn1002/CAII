package com.cubesofttech.action;

import com.cubesofttech.dao.CompanyAddressDAO;
import com.cubesofttech.dao.CompanyContactDAO;
import com.cubesofttech.dao.CompanyDAO;
import com.cubesofttech.dao.DocStatusDAO;
import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.PoDAO;
import com.cubesofttech.dao.PoDetailDAO;
import com.cubesofttech.dao.PoParentDAO;
import com.cubesofttech.dao.PrDetailDAO;
import com.cubesofttech.dao.ProductDAO;
import com.cubesofttech.dao.UnitOfMeasureDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WorkLogDAO;
import com.cubesofttech.model.Company;
import com.cubesofttech.model.CompanyAddress;
import com.cubesofttech.model.CompanyContact;
import com.cubesofttech.model.DocStatus;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.Po;
import com.cubesofttech.model.PoDetail;
import com.cubesofttech.model.PoParent;
import com.cubesofttech.model.Product;
import com.cubesofttech.model.UnitOfMeasure;
import com.cubesofttech.model.User;
import com.cubesofttech.service.FileAttachmentService;
import com.cubesofttech.util.DateUtil;

import java.io.File;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.hibernate.SQLQuery;
import org.hibernate.transform.AliasToEntityMapResultTransformer;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class PurchaseOrderAction extends ActionSupport {

    private static final long serialVersionUID = 2280661337420278284L;

    Logger log = Logger.getLogger(getClass());
    HttpServletRequest request = ServletActionContext.getRequest();
    HttpServletResponse response = ServletActionContext.getResponse();

    private User onlineUser = (User) request.getSession().getAttribute("onlineUser");

    @Autowired
    private PoDAO poDAO;

    @Autowired
    private UserDAO userDAO;
    
    @Autowired
    private FileUploadDAO fileuploadDAO;
   
    @Autowired
    private PoDetailDAO poDetailDAO;
    
    @Autowired
    private PoParentDAO poParentDAO;
    
    @Autowired
    private CompanyDAO companyDAO;
    
    @Autowired
    private CompanyAddressDAO companyAddressDAO;
    
    @Autowired
    private CompanyContactDAO companyContactDAO;
    
    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private FileAttachmentService fileAttachmentService;

    @Autowired
    private UnitOfMeasureDAO unitOfMeasureDAO;

    @Autowired
    private DocStatusDAO docStatusDAO;

    @Autowired
    private PrDetailDAO prDetailDAO;
    
    private String poId;
    private String itemsType;
    private String includeSubProducts;

    public String getPoId() {
        return poId;
    }

    public void setPoId(String poId) {
        this.poId = poId;
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

    private String companyId;
    private String companyLocation;
    private String contactId;
    private String description;
    private String descriptionVendor;
    private String referenceNo;
    private String referenceDate;
    private String poDetailCartJson;
    private String status;
    private String reason;
    private String fileId;

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    public String getContactId() {
        return contactId;
    }

    public void setContactId(String contactId) {
        this.contactId = contactId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescriptionVendor() {
        return descriptionVendor;
    }

    public void setDescriptionVendor(String descriptionVendor) {
        this.descriptionVendor = descriptionVendor;
    }

    public String getReferenceNo() {
        return referenceNo;
    }

    public void setReferenceNo(String referenceNo) {
        this.referenceNo = referenceNo;
    }

    public String getReferenceDate() {
        return referenceDate;
    }

    public void setReferenceDate(String referenceDate) {
        this.referenceDate = referenceDate;
    }

    public String getPoDetailCartJson() {
        return poDetailCartJson;
    }

    public void setPoDetailCartJson(String poDetailCartJson) {
        this.poDetailCartJson = poDetailCartJson;
    }

    public void setCompanyLocation(String companyLocation) {
        this.companyLocation = companyLocation;
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

    private String poDetailId;
    private String productId;
    private String qty;
    private String unit;
    private String price;
    private String signUser;
    private String signDate;
    private String poParentId;
    private String keepDetail;
    
    public String getPoDetailId() {
        return poDetailId;
    }

    public void setPoDetailId(String poDetailId) {
        this.poDetailId = poDetailId;
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

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
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

    public String getPoParentId() {
        return poParentId;
    }

    public void setPoParentId(String poParentId) {
        this.poParentId = poParentId;
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

    public String purchaseOrderList() {
        try {
            if (onlineUser == null) {
                return ERROR;
            }

            List<Map<String, Object>> poList = poDAO.findAllPoWithUser();
            request.setAttribute("poList", poList);

            // --- Summary (อิง doc_status, group=po) ---
            List<DocStatus> statuses = docStatusDAO.findByPage("po");

            // นับจำนวนตาม status_code
            Map<String, Integer> summary = new HashMap<>();
            for (DocStatus ds : statuses) {
                summary.put(ds.getStatusCode(), 0);
            }
            for (Map<String, Object> po : poList) {
                String code = String.valueOf(po.get("status"));
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

            request.setAttribute("poSummary", summary);       // key = status_code -> count
            request.setAttribute("poStatusNames", statusNames); // key = status_code -> status_name
            request.setAttribute("poStatusColors", statusColors);
            request.setAttribute("poSummaryTotal", poList.size());

            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }

    public String purchaseOrderAdd() {
        try {
            if (onlineUser == null) {
                return ERROR;
            }
            
            String loginUser = onlineUser.getId();
            List<Map<String, Object>> companyList = companyDAO.findAll();
            // log.debug("--- companyList ----- "+ companyList);
            request.setAttribute("companyList", companyList);
            
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
    
    public String purchaseOrderEdit() {
        try {
            if (onlineUser == null) {
                return ERROR;
            }
            String logonUser = onlineUser.getId();
            Po poList = poDAO.findById(poId);
            // log.debug("--- poList ----- "+ poList);
            request.setAttribute("poList", poList);
            
            if(poList.getUserCreate() != null) {
                User userCreate = userDAO.findById(poList.getUserCreate());
                // log.debug("--- userCreate ----- "+ userCreate);
                request.setAttribute("userCreate", userCreate);
            }
            
            if (Arrays.asList("4", "5", "6", "7").contains(poList.getStatus())) {
                String userUpdateId = poList.getUserUpdate();

                if (userUpdateId != null && !userUpdateId.trim().isEmpty()) {
                    User userUpdate = userDAO.findById(userUpdateId);
                    request.setAttribute("userUpdate", userUpdate);
                }
            }
            
            //--- Get SignUser ---
            User userSignUser = null;
            if (poList.getSignUser() != null) {
                userSignUser = userDAO.findById(poList.getSignUser());
            } else {
                userSignUser = userDAO.findById(logonUser);
            }
            request.setAttribute("userSignUser", userSignUser);
            String signaturePath = fileAttachmentService.getFileUrl(userSignUser != null ? userSignUser.getPathSignature() : null);
            request.setAttribute("imgPathSignature", signaturePath);

            //--- Get ApproveUser signature ---
            if (poList.getApproveUser() != null && !poList.getApproveUser().trim().isEmpty()) {
                User userApproveUser = userDAO.findById(poList.getApproveUser());
                request.setAttribute("userApproveUser", userApproveUser);

                String imgPathApproveSignature = fileAttachmentService.getFileUrl(userApproveUser != null ? userApproveUser.getPathSignature() : null);
                request.setAttribute("imgPathApproveSignature", imgPathApproveSignature);
            }

            List<Map<String, Object>> companyList = companyDAO.findAll();
            request.setAttribute("companyList", companyList);
            
            List<Map<String, Object>> poDetailList = poDetailDAO.findPoDetailByPoId(String.valueOf(poList.getPoId()));
            // log.debug("--- poDetailList ----- "+ poDetailList);
            request.setAttribute("poDetailList", poDetailList);
            
            List<Map<String, Object>> poParentList = new java.util.ArrayList<>();
            if (poDetailList != null) {
                for (Map<String, Object> detail : poDetailList) {
                    Object poDetailIdObj = detail.get("po_detail_id");
                    if (poDetailIdObj != null) {
                        List<Map<String, Object>> parents = poParentDAO.findPoParentByPoDetailId(String.valueOf(poDetailIdObj));
                        if (parents != null) {
                            for (Map<String, Object> p : parents) {
                                Object prIdObj = p.get("pr_id");
                                Object parentProductIdObj = p.get("product_id");
                                if (prIdObj != null && parentProductIdObj != null) {
                                    p.put("mrList", prDetailDAO.findMrByPrIdAndProductId(String.valueOf(prIdObj), parentProductIdObj));
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
                            poParentList.addAll(parents);
                            detail.put("poParentList", parents);
                        }
                    }

                    Object productIdObj = detail.get("product_id");
                    if (productIdObj != null) {
                        Product product = productDAO.findById(Integer.valueOf(String.valueOf(productIdObj)));
                        if (product != null) {
                            detail.put("product_name", product.getProductName());
                            detail.put("product_type", product.getProductType());

                            String pp = product.getParentProductId() == null ? "" : product.getParentProductId().trim();
                            if (!pp.isEmpty() && !"0".equals(pp)) {
                                Product parentProduct = productDAO.findById(Integer.valueOf(pp));
                                if (parentProduct != null) {
                                    detail.put("parent_product_name", parentProduct.getProductName());
                                }
                            }
                        }
                    }

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
            // log.debug("--- poParentList ----- " + poParentList);
            request.setAttribute("poParentList", poParentList);

            Map<String, String> statusNames = new HashMap<>();
            Map<String, String> statusColors = new HashMap<>();

            for (DocStatus ds : docStatusDAO.findByPage("po")) {
                statusNames.put(ds.getStatusCode(), ds.getStatusName());
                statusColors.put(ds.getStatusCode(), ds.getColor());
            }
            request.setAttribute("poStatusNames", statusNames);
            request.setAttribute("poStatusColors", statusColors);
            
            List<FileUpload> attachmentList = fileAttachmentService.listAttachments("po", String.valueOf(poList.getPoId()));
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

    // --- generate poId ---
    private String generateNewPoId() throws Exception {
        String year = String.valueOf(java.time.Year.now().getValue());
        String prefix = "PO" + year;
        String maxPoId = poDAO.findMaxPoIdByYear(prefix + "%");

        long nextSeq = 1L;
        if (maxPoId != null && maxPoId.length() >= prefix.length() + 8) {
            String seqPart = maxPoId.substring(prefix.length());
            try {
                nextSeq = Long.parseLong(seqPart) + 1;
            } catch (NumberFormatException nfe) {
                nextSeq = 1L;
            }
        }
        return prefix + String.format("%08d", nextSeq);
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

    public String savePo() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
            String loginUserId = onlineUser.getId();

            String newPoId = generateNewPoId();
            debugLog.add("newPoId = " + newPoId);

            List<Map<String, Object>> cartItems = new ArrayList<>();
            if (poDetailCartJson != null && !poDetailCartJson.trim().isEmpty()) {
                JSONArray jsonArray = new JSONArray(poDetailCartJson);
                for (int i = 0; i < jsonArray.length(); i++) {
                    JSONObject obj = jsonArray.getJSONObject(i);
                    cartItems.add(jsonObjectToMap(obj));
                }
            }
            debugLog.add("cartItems size = " + cartItems.size());

            double grandTotal = 0d;
            for (Map<String, Object> item : cartItems) {
                grandTotal += toDouble(item.get("qty")) * toDouble(item.get("price"));
            }

            // --- Header ---
            Po po = new Po();
            po.setPoId(newPoId);
            po.setRefNo(referenceNo);

            if (referenceDate != null && !referenceDate.trim().isEmpty()) {
                    java.time.LocalDate ld = java.time.LocalDate.parse(referenceDate);
                    po.setRefDate(java.sql.Timestamp.valueOf(ld.atStartOfDay()));
                
            }
            
            if(signDate != null && !signDate.trim().isEmpty()) {
                po.setSignDate(java.sql.Timestamp.valueOf(signDate));
                po.setSignUser(loginUserId);
            }
            
            if (companyId != null && !companyId.trim().isEmpty()) po.setCompanyId(Long.parseLong(companyId));
            if (companyLocation != null && !companyLocation.trim().isEmpty()) po.setCompanyLocation(Long.parseLong(companyLocation));
            if (contactId != null && !contactId.trim().isEmpty()) po.setContactId(Long.parseLong(contactId));

            po.setDescription(description);
            po.setDescriptionVendor(descriptionVendor);
            po.setUserCreate(loginUserId);
            po.setTimeCreate(DateUtil.getCurrentTime());
            po.setUserUpdate(loginUserId);
            po.setTimeUpdate(DateUtil.getCurrentTime());
            po.setPoTotal(grandTotal);
            String poStatus = (status != null && !status.trim().isEmpty()) ? status : "1";
            po.setStatus(poStatus); // 1 = Draft

            poDAO.save(po);

         // --- Detail ---
            Long lastDetailId = poDetailDAO.getMaxId();
            Long lastParentId = poParentDAO.getMaxId();

            long nextDetailSeq = lastDetailId + 1;
            long nextParentSeq = lastParentId + 1;

            int seq = 0;
            long parentSeq = 0;
            List<String> pulledPrDetailIds = new ArrayList<>();
            for (Map<String, Object> item : cartItems) {
                double qty = toDouble(item.get("qty"));
                double price = toDouble(item.get("price"));

                String poDetailId = String.valueOf(nextDetailSeq + seq);

                String productId = item.get("productId") != null ? String.valueOf(item.get("productId")) : null;
                String unitVal = item.get("unit") != null ? String.valueOf(item.get("unit")) : null;
                String descVal = item.get("description") != null ? String.valueOf(item.get("description")) : null;

                String dbProductId = productId;
                String dbParentId = null;
                String dbItemsType = null;
                String itemsTypeVal = String.valueOf(item.get("itemsType"));

                if (itemsTypeVal != null) {
                    if ("equipment".equals(itemsTypeVal)) {
                        dbItemsType = "1";
                    } else if ("consumables".equals(itemsTypeVal)) {
                        dbItemsType = "2";
                    } else if ("accessory".equals(itemsTypeVal)) {
                        dbItemsType = "3";
                    } else if ("office".equals(itemsTypeVal)) {
                        dbItemsType = "4";
                    }

                    Product p = productDAO.findById(Integer.valueOf(productId));
                    dbProductId = p.getProductId().toString();
                    dbParentId = String.valueOf(p.getParentProductId());
                }

                // --- PoDetail ---
                PoDetail detail = new PoDetail();
                detail.setPoDetailId(poDetailId);
                detail.setPoId(newPoId);
                detail.setProductId(dbProductId);
                detail.setParentId(dbParentId);
                detail.setUnit(unitVal);
                detail.setAmountTotal(qty);
                detail.setUnitPrice(String.valueOf(price));
                detail.setPriceTotal(qty * price);
                detail.setDescription(descVal);
                detail.setUserCreate(loginUserId);
                detail.setTimeCreate(DateUtil.getCurrentTime());
                detail.setUserUpdate(loginUserId);
                detail.setTimeUpdate(DateUtil.getCurrentTime());

                poDetailDAO.save(detail);

                // --- PoParent อ่านจาก item.sources (ถ้ามี) ---
                List<Map<String, Object>> sources = new ArrayList<>();
                Object sourcesObj = item.get("sources");
                if (sourcesObj instanceof JSONArray) {
                    JSONArray arr = (JSONArray) sourcesObj;
                    for (int i = 0; i < arr.length(); i++) {
                        sources.add(jsonObjectToMap(arr.getJSONObject(i)));
                    }
                }

                if (sources.isEmpty()) {
                    String poParentIdVal = String.valueOf(nextParentSeq + parentSeq++);
                    PoParent parent = new PoParent();
                    parent.setPoParentId(poParentIdVal);
                    parent.setPoDetailId(poDetailId);
                    parent.setPrId(null);
                    parent.setProductId(dbProductId);
                    parent.setParentId(dbParentId);
                    parent.setAmount(qty);
                    parent.setUnit(unitVal);
                    parent.setDescription(descVal);
                    parent.setUserCreate(loginUserId);
                    parent.setTimeCreate(DateUtil.getCurrentTime());
                    parent.setUserUpdate(loginUserId);
                    parent.setTimeUpdate(DateUtil.getCurrentTime());
                    poParentDAO.save(parent);
                } else {
                    for (Map<String, Object> src : sources) {
                        String prIdVal = src.get("prId") != null ? String.valueOf(src.get("prId")) : null;
                        String prDetailIdVal = src.get("prDetailId") != null ? String.valueOf(src.get("prDetailId")) : null;
                        double srcQty = toDouble(src.get("qty"));
                        String srcUnitVal = src.get("unit") != null ? String.valueOf(src.get("unit")) : unitVal;

                        if (prDetailIdVal != null && !prDetailIdVal.trim().isEmpty()) {
                            pulledPrDetailIds.add(prDetailIdVal);
                        }

                        String poParentIdVal = String.valueOf(nextParentSeq + parentSeq++);
                        PoParent parent = new PoParent();
                        parent.setPoParentId(poParentIdVal);
                        parent.setPoDetailId(poDetailId);
                        parent.setPrId(prIdVal);
                        parent.setProductId(dbProductId);
                        parent.setParentId(dbParentId);
                        parent.setAmount(srcQty);
                        parent.setUnit(srcUnitVal);
                        parent.setDescription(descVal);
                        parent.setUserCreate(loginUserId);
                        parent.setTimeCreate(DateUtil.getCurrentTime());
                        parent.setUserUpdate(loginUserId);
                        parent.setTimeUpdate(DateUtil.getCurrentTime());
                        poParentDAO.save(parent);
                    }
                }

                seq++;
            }
            if (!pulledPrDetailIds.isEmpty()) {
                prDetailDAO.markPulled(pulledPrDetailIds);
            }

            // --- Attach files (page='po', pageId=newPoId) ---
            log.debug("files = " + (files == null ? "null" : files.size()) 
                + ", filesFileName = " + (filesFileName == null ? "null" : filesFileName));

            fileAttachmentService.attach(files, filesFileName, "po", newPoId, loginUserId,
                request.getServletContext().getRealPath("/"));

            Map<String, Object> result = new HashMap<>();
            result.put("poId", newPoId);
            writeJson(result, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }
    
    
    public String updatePo() {
        List<String> debugLog = new ArrayList<>();

        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }

            if (poId == null || poId.trim().isEmpty()) {
                debugLog.add("poId missing");
                writeJson(null, debugLog);
                return NONE;
            }

            String loginUserId = onlineUser.getId();

            // --- Header ---
            Po po = poDAO.findById(poId);
            if (po == null) {
                debugLog.add("PO not found : " + poId);
                writeJson(null, debugLog);
                return NONE;
            }

            po.setRefNo(referenceNo);
            
            if (referenceDate != null && !referenceDate.trim().isEmpty()) {
                LocalDate ld = LocalDate.parse(referenceDate);
                po.setRefDate(java.sql.Timestamp.valueOf(ld.atStartOfDay()));
            }

            if (companyId != null && !companyId.trim().isEmpty()) po.setCompanyId(Long.parseLong(companyId));
            if (companyLocation != null && !companyLocation.trim().isEmpty()) po.setCompanyLocation(Long.parseLong(companyLocation));
            if (contactId != null && !contactId.trim().isEmpty()) po.setContactId(Long.parseLong(contactId));

            po.setDescription(description);
            if (descriptionVendor != null) po.setDescriptionVendor(descriptionVendor);
            po.setUserUpdate(loginUserId);
            po.setTimeUpdate(DateUtil.getCurrentTime());

            if (status != null && !status.trim().isEmpty()) {
                po.setStatus(status);
            }

            // --- Detail ---
            List<Map<String, Object>> cartItems = new ArrayList<>();
            if (poDetailCartJson != null && !poDetailCartJson.trim().isEmpty()) {
                JSONArray jsonArray = new JSONArray(poDetailCartJson);
                for (int i = 0; i < jsonArray.length(); i++) {
                    JSONObject obj = jsonArray.getJSONObject(i);
                    cartItems.add(jsonObjectToMap(obj));
                }
            }
            debugLog.add("new cartItems size = " + cartItems.size());

            Long lastDetailId = poDetailDAO.getMaxId();
            Long lastParentId = poParentDAO.getMaxId();
            long nextDetailSeq = lastDetailId + 1;
            long nextParentSeq = lastParentId + 1;

            int seq = 0;
            long parentSeq = 0;
            List<String> pulledPrDetailIds = new ArrayList<>();
            for (Map<String, Object> item : cartItems) {
                // --- ต่อเข้า po_detail เดิม ใส่ poDetailId มาให้) ---
                String existingDetailId = item.get("poDetailId") != null
                        ? String.valueOf(item.get("poDetailId")).trim() : "";
                if (!existingDetailId.isEmpty()) {
                    PoDetail existing = poDetailDAO.findById(existingDetailId);
                    if (existing == null || !poId.equals(String.valueOf(existing.getPoId()))) {
                        throw new IllegalStateException("po_detail not found / not in this PO: " + existingDetailId);
                    }

                    List<Map<String, Object>> exSources = new ArrayList<>();
                    Object exSourcesObj = item.get("sources");
                    if (exSourcesObj instanceof JSONArray) {
                        JSONArray arr = (JSONArray) exSourcesObj;
                        for (int i = 0; i < arr.length(); i++) {
                            exSources.add(jsonObjectToMap(arr.getJSONObject(i)));
                        }
                    }

                    double addBaseQty = 0d, addTotal = 0d;
                    for (Map<String, Object> src : exSources) {
                        String prIdVal = src.get("prId") != null ? String.valueOf(src.get("prId")) : null;
                        String prDetailIdVal = src.get("prDetailId") != null ? String.valueOf(src.get("prDetailId")) : null;
                        double srcQty = toDouble(src.get("qty"));
                        String srcUnitVal = src.get("unit") != null ? String.valueOf(src.get("unit")) : existing.getUnit();

                        if (prDetailIdVal != null && !prDetailIdVal.trim().isEmpty()) {
                            pulledPrDetailIds.add(prDetailIdVal);
                        }

                        PoParent parent = new PoParent();
                        parent.setPoParentId(String.valueOf(nextParentSeq + parentSeq++));
                        parent.setPoDetailId(existingDetailId);
                        parent.setPrId(prIdVal);
                        parent.setProductId(existing.getProductId());
                        parent.setParentId(existing.getParentId());
                        parent.setAmount(srcQty);
                        parent.setUnit(srcUnitVal);
                        parent.setDescription(existing.getDescription());
                        parent.setUserCreate(loginUserId);
                        parent.setTimeCreate(DateUtil.getCurrentTime());
                        parent.setUserUpdate(loginUserId);
                        parent.setTimeUpdate(DateUtil.getCurrentTime());
                        poParentDAO.save(parent);

                        addBaseQty += src.get("baseQty") != null ? toDouble(src.get("baseQty")) : srcQty;
                        addTotal   += toDouble(src.get("total"));
                    }

                    // แก้ qty/unit ของ po_parent เดิม 
                    double editBaseQtyDelta = 0d;
                    List<Map<String, Object>> srcEdits = new ArrayList<>();
                    Object srcEditsObj = item.get("sourceEdits");
                    if (srcEditsObj instanceof JSONArray) {
                        JSONArray arr = (JSONArray) srcEditsObj;
                        for (int i = 0; i < arr.length(); i++) {
                            srcEdits.add(jsonObjectToMap(arr.getJSONObject(i)));
                        }
                    }
                    for (Map<String, Object> se : srcEdits) {
                        String ppId = se.get("poParentId") != null ? String.valueOf(se.get("poParentId")).trim() : "";
                        if (ppId.isEmpty()) continue;

                        PoParent p = poParentDAO.findById(ppId);
                        if (p == null || !existingDetailId.equals(String.valueOf(p.getPoDetailId()))) {
                            // กัน poParentId ผิด/เป็นของการ์ดอื่นหลุดเข้ามาแก้
                            continue;
                        }

                        double oldBase = toDouble(p.getAmount()) * conversionRateOf(p.getUnit());
                        double newQtyVal = toDouble(se.get("qty"));
                        String newUnitVal = se.get("unit") != null ? String.valueOf(se.get("unit")) : p.getUnit();
                        double newBase = newQtyVal * conversionRateOf(newUnitVal);

                        p.setAmount(newQtyVal);
                        p.setUnit(newUnitVal);
                        p.setUserUpdate(loginUserId);
                        p.setTimeUpdate(DateUtil.getCurrentTime());
                        poParentDAO.update(p);

                        editBaseQtyDelta += (newBase - oldBase);
                    }

                    double newQty = toDouble(existing.getAmountTotal()) + addBaseQty + editBaseQtyDelta;

                    // ถ้าผู้ใช้แก้ราคารวมของการ์ดเดิม (editTotal) ให้ใช้แทนยอดเดิมใน db แล้วค่อยบวกยอด pending
                    boolean hasEditTotal = item.get("editTotal") != null;
                    double baseTotal = hasEditTotal ? toDouble(item.get("editTotal")) : toDouble(existing.getPriceTotal());
                    double newTot = baseTotal + addTotal;

                    if (item.get("editDescription") != null) {
                        String newDesc = String.valueOf(item.get("editDescription"));
                        existing.setDescription(newDesc);

                        // sync ไปแถว po_parent เดิมของการ์ดนี้
                        List<Map<String, Object>> parentRows = poParentDAO.findPoParentByPoDetailId(existingDetailId);
                        if (parentRows != null) {
                            for (Map<String, Object> p : parentRows) {
                                Object ppId = p.get("po_parent_id");
                                if (ppId == null) continue;
                                PoParent pp = poParentDAO.findById(String.valueOf(ppId));
                                if (pp == null) continue;
                                pp.setDescription(newDesc);
                                pp.setUserUpdate(loginUserId);
                                pp.setTimeUpdate(DateUtil.getCurrentTime());
                                poParentDAO.update(pp);
                            }
                        }
                    }

                    existing.setAmountTotal(newQty);
                    existing.setPriceTotal(newTot);
                    existing.setUnitPrice(String.valueOf(newQty > 0 ? newTot / newQty : 0d)); // unitPrice เป็น String
                    existing.setUserUpdate(loginUserId);
                    existing.setTimeUpdate(DateUtil.getCurrentTime());
                    poDetailDAO.update(existing);

                    continue;
                }

                double qty = toDouble(item.get("qty"));
                double price = toDouble(item.get("price"));

                String poDetailId = String.valueOf(nextDetailSeq + seq);

                String productId = item.get("productId") != null ? String.valueOf(item.get("productId")) : null;
                String unitVal = item.get("unit") != null ? String.valueOf(item.get("unit")) : null;
                String descVal = item.get("description") != null ? String.valueOf(item.get("description")) : null;

                String dbProductId = productId;
                String dbParentId = null;
                String dbItemsType = null;
                String itemsTypeVal = String.valueOf(item.get("itemsType"));

                if (itemsTypeVal != null) {
                    if ("equipment".equals(itemsTypeVal)) {
                        dbItemsType = "1";
                    } else if ("consumables".equals(itemsTypeVal)) {
                        dbItemsType = "2";
                    } else if ("accessory".equals(itemsTypeVal)) {
                        dbItemsType = "3";
                    } else if ("office".equals(itemsTypeVal)) {
                        dbItemsType = "4";
                    }

                    Product p = productDAO.findById(Integer.valueOf(productId));
                    dbProductId = p.getProductId().toString();
                    dbParentId = String.valueOf(p.getParentProductId());
                }

                // --- PoDetail ---
                PoDetail detail = new PoDetail();
                detail.setPoDetailId(poDetailId);
                detail.setPoId(poId);
                detail.setProductId(dbProductId);
                detail.setParentId(dbParentId);
                detail.setUnit(unitVal);
                detail.setAmountTotal(qty);
                detail.setUnitPrice(String.valueOf(price));
                detail.setPriceTotal(qty * price);
                detail.setDescription(descVal);
                detail.setUserCreate(loginUserId);
                detail.setTimeCreate(DateUtil.getCurrentTime());
                detail.setUserUpdate(loginUserId);
                detail.setTimeUpdate(DateUtil.getCurrentTime());

                poDetailDAO.save(detail);

                // --- PoParent อ่านจาก item.sources (ถ้ามี) ---
                List<Map<String, Object>> sources = new ArrayList<>();
                Object sourcesObj = item.get("sources");
                if (sourcesObj instanceof JSONArray) {
                    JSONArray arr = (JSONArray) sourcesObj;
                    for (int i = 0; i < arr.length(); i++) {
                        sources.add(jsonObjectToMap(arr.getJSONObject(i)));
                    }
                }

                if (sources.isEmpty()) {
                    String poParentIdVal = String.valueOf(nextParentSeq + parentSeq++);
                    PoParent parent = new PoParent();
                    parent.setPoParentId(poParentIdVal);
                    parent.setPoDetailId(poDetailId);
                    parent.setPrId(null);
                    parent.setProductId(dbProductId);
                    parent.setParentId(dbParentId);
                    parent.setAmount(qty);
                    parent.setUnit(unitVal);
                    parent.setDescription(descVal);
                    parent.setUserCreate(loginUserId);
                    parent.setTimeCreate(DateUtil.getCurrentTime());
                    parent.setUserUpdate(loginUserId);
                    parent.setTimeUpdate(DateUtil.getCurrentTime());
                    poParentDAO.save(parent);
                } else {
                    for (Map<String, Object> src : sources) {
                        String prIdVal = src.get("prId") != null ? String.valueOf(src.get("prId")) : null;
                        String prDetailIdVal = src.get("prDetailId") != null ? String.valueOf(src.get("prDetailId")) : null;
                        double srcQty = toDouble(src.get("qty"));
                        String srcUnitVal = src.get("unit") != null ? String.valueOf(src.get("unit")) : unitVal;

                        if (prDetailIdVal != null && !prDetailIdVal.trim().isEmpty()) {
                            pulledPrDetailIds.add(prDetailIdVal);
                        }

                        String poParentIdVal = String.valueOf(nextParentSeq + parentSeq++);
                        PoParent parent = new PoParent();
                        parent.setPoParentId(poParentIdVal);
                        parent.setPoDetailId(poDetailId);
                        parent.setPrId(prIdVal);
                        parent.setProductId(dbProductId);
                        parent.setParentId(dbParentId);
                        parent.setAmount(srcQty);
                        parent.setUnit(srcUnitVal);
                        parent.setDescription(descVal);
                        parent.setUserCreate(loginUserId);
                        parent.setTimeCreate(DateUtil.getCurrentTime());
                        parent.setUserUpdate(loginUserId);
                        parent.setTimeUpdate(DateUtil.getCurrentTime());
                        poParentDAO.save(parent);
                    }
                }

                seq++;
            }
            if (!pulledPrDetailIds.isEmpty()) {
                prDetailDAO.markPulled(pulledPrDetailIds);
            }

            // --- Attach files (page='po', pageId=poId) ---
            String serverRealPath = ServletActionContext.getServletContext().getRealPath("/");
            fileAttachmentService.attach(files, filesFileName, "po", poId, loginUserId, serverRealPath);

            // รวมยอดจาก po_detail จริงใน DB (รายการเดิม + รายการใหม่ที่เพิ่งเพิ่ม) แทนการคำนวณจาก cart
            double total = poDetailDAO.getTotalByPoId(poId);
            po.setPoTotal(total);

            poDAO.update(po);

            Map<String, Object> result = new HashMap<>();
            result.put("poId", poId);
            writeJson(result, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    public String updatePoDetail() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
            if (poDetailId == null || poDetailId.trim().isEmpty()) {
                writeJson(null, debugLog);
                return NONE;
            }

            PoDetail detail = poDetailDAO.findById(poDetailId);
            if (detail == null) {
                debugLog.add("poDetail not found: " + poDetailId);
                writeJson(null, debugLog);
                return NONE;
            }

            double itemQty = qty != null ? toDouble(qty) : 0d;
            double itemPrice = price != null ? toDouble(price) : 0d;

            detail.setProductId(productId);
            detail.setUnit(unit);
            detail.setAmountTotal(itemQty);
            detail.setUnitPrice(String.valueOf(itemPrice));
            detail.setPriceTotal(itemQty * itemPrice);
            detail.setDescription(description);
            detail.setUserUpdate(onlineUser.getId());
            detail.setTimeUpdate(DateUtil.getCurrentTime());

            poDetailDAO.update(detail);

            // po_parent เป็น row ย่อยของ po_detail เดียวกัน
            // ต้อง sync productId/unit/description ให้ตรงกับ po_detail ที่เพิ่งแก้ ไม่งั้นข้อมูลจะค้างค่าตอนสร้างครั้งแรก
            List<Map<String, Object>> parents = poParentDAO.findPoParentByPoDetailId(poDetailId);
            if (parents != null) {
                for (Map<String, Object> p : parents) {
                    Object poParentIdObj = p.get("po_parent_id");
                    if (poParentIdObj == null) continue;
                    PoParent parent = poParentDAO.findById(String.valueOf(poParentIdObj));
                    if (parent == null) continue;
                    parent.setProductId(productId);
                    parent.setUnit(unit);
                    parent.setDescription(description);
                    parent.setUserUpdate(onlineUser.getId());
                    parent.setTimeUpdate(DateUtil.getCurrentTime());
                    poParentDAO.update(parent);
                }
            }

            Po po = poDAO.findById(detail.getPoId());
            if (po != null) {
                double total = poDetailDAO.getTotalByPoId(detail.getPoId());
                po.setPoTotal(total);
                poDAO.update(po);
            }

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

    public String deletePoDetail() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
            if (poDetailId == null || poDetailId.trim().isEmpty()) {
                writeJson(null, debugLog);
                return NONE;
            }

            List<Map<String, Object>> parents = poParentDAO.findPoParentByPoDetailId(poDetailId);
            debugLog.add("parents found = " + (parents != null ? parents.size() : 0));
            if (parents != null) {
                for (Map<String, Object> p : parents) {
                    Object prIdObj = p.get("pr_id");
                    Object productIdObj = p.get("product_id");
                    debugLog.add("parent row: pr_id=" + prIdObj + ", product_id=" + productIdObj);
                    if (prIdObj != null && productIdObj != null) {
                        prDetailDAO.revertPulledStatusByPrProduct(String.valueOf(prIdObj), String.valueOf(productIdObj));
                        debugLog.add("revert called for pr_id=" + prIdObj + ", product_id=" + productIdObj);
                    } else {
                        debugLog.add("SKIPPED revert - prId or productId is null");
                    }
                }
            }


            poParentDAO.deleteByPoDetailId(poDetailId);
            poDetailDAO.deleteByPoIdAndPoDetailId(poDetailId, poId);

            if (poId != null && !poId.trim().isEmpty()) {
                Po po = poDAO.findById(poId);
                if (po != null) {
                    double total = poDetailDAO.getTotalByPoId(poId);
                    po.setPoTotal(total);
                    poDAO.update(po);
                }
            }

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

    public String updatePoSource() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }

            double newQty = toDouble(qty);
            Po po = poDAO.findById(poId);
            if (po == null || !"1".equals(po.getStatus())) {// Draft เท่านั้น
                debugLog.add("PO not found or not draft");
                writeJson(null, debugLog);
                return NONE;
            }

            PoDetail detail = poDetailDAO.findById(poDetailId);
            if (detail == null || !poId.equals(String.valueOf(detail.getPoId()))) {
                debugLog.add("po_detail not in this PO");
                writeJson(null, debugLog);
                return NONE;
            }

            PoParent parent = poParentDAO.findById(poParentId);
            double oldBase = toDouble(parent.getAmount()) * conversionRateOf(parent.getUnit());
            double newBase = newQty * conversionRateOf(unit);

            // แก้เฉพาะ amount/unit
            parent.setAmount(newQty);
            parent.setUnit(unit.trim());
            parent.setUserUpdate(onlineUser.getId());
            parent.setTimeUpdate(DateUtil.getCurrentTime());
            poParentDAO.update(parent);

            applyDetailQty(detail, toDouble(detail.getAmountTotal()) + newBase - oldBase, onlineUser.getId());

            po.setPoTotal(poDetailDAO.getTotalByPoId(poId));
            poDAO.update(po);

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

    public String deletePoSource() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }

            Po po = poDAO.findById(poId);
            if (po == null || !"1".equals(po.getStatus())) {
                debugLog.add("PO not found or not draft");
                writeJson(null, debugLog);
                return NONE;
            }

            PoDetail detail = poDetailDAO.findById(poDetailId);
            if (detail == null || !poId.equals(String.valueOf(detail.getPoId()))) {
                debugLog.add("po_detail not in this PO");
                writeJson(null, debugLog);
                return NONE;
            }

            PoParent parent = poParentDAO.findById(poParentId);
            if (parent == null || !poDetailId.equals(String.valueOf(parent.getPoDetailId()))) {
                debugLog.add("po_parent not in this po_detail");
                writeJson(null, debugLog);
                return NONE;
            }

            List<Map<String, Object>> parentsBefore = poParentDAO.findPoParentByPoDetailId(poDetailId);
            boolean keep = "true".equals(keepDetail);   // frontend แจ้งว่ายังมี source ใหม่ค้างรอ save
            if (!keep && (parentsBefore == null || parentsBefore.size() <= 1)) {
                debugLog.add("last source - use delete_po_detail");
                writeJson(null, debugLog);
                return NONE;
            }

            double oldBase = toDouble(parent.getAmount()) * conversionRateOf(parent.getUnit());

            // ให้ PR detail กลับมาเลือกใน Search PR ได้อีก
            if (!blank(parent.getPrId()) && !blank(parent.getProductId())) {
                prDetailDAO.revertPulledStatusByPrProduct(parent.getPrId(), parent.getProductId());
            }

            poParentDAO.delete(parent);

            applyDetailQty(detail, toDouble(detail.getAmountTotal()) - oldBase, onlineUser.getId());

            po.setPoTotal(poDetailDAO.getTotalByPoId(poId));
            poDAO.update(po);

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

    public String updateStatusPo() {
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

            Po po = poDAO.findById(poId);

            String oldStatus = po.getStatus();
            boolean toRejectOrCancel = "5".equals(status) || "6".equals(status);
            boolean wasRejectOrCancel = "5".equals(oldStatus) || "6".equals(oldStatus);
            if (toRejectOrCancel && !wasRejectOrCancel) {
                revertPrPulledByPo(poId); // คืน PR เป็น pulled=0
            }

            po.setStatus(status);
            if (reason != null && !reason.trim().isEmpty()) {
                po.setReason(reason.trim());
            }

            if ("1".equals(status)) {
                po.setReason(null);
            } 

            if ("3".equals(status)) {
                po.setApproveUser(loginUserId);
                po.setApproveDate(DateUtil.getCurrentTime());
            }
            po.setUserUpdate(loginUserId);
            po.setTimeUpdate(DateUtil.getCurrentTime());

            poDAO.update(po);

            Map<String, Object> result = new HashMap<>();
            result.put("poId", poId);
            writeJson(result, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }
    
    public String getCompanyProfile() {
        List<String> debugLog = new java.util.ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
            String companyIdStr = request.getParameter("companyId");
            debugLog.add("companyIdStr = " + companyIdStr);

            Long companyId = Long.parseLong(companyIdStr);

            Map<String, Object> profile = companyDAO.findCompanyProfileById(companyId);
            debugLog.add("profile = " + profile);

            if (profile == null) {
                writeJson(null, debugLog);
                return NONE;
            }

            Map<String, Object> result = new HashMap<>();
            result.put("taxId", profile.get("tax_number"));
            result.put("locationList", profile.get("addressList"));

            writeJson(result, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }
    
    public String getItemsCatalog() {
        List<String> debugLog = new ArrayList<>();

        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }

            if (itemsType != null) {
                List<Map<String, Object>> productList = new ArrayList<>();
                String dbItemsType = null;
                if ("equipment".equals(itemsType)) {
                    dbItemsType = "1";
                } else if ("consumables".equals(itemsType)) {
                    dbItemsType = "2";
                } else if ("accessory".equals(itemsType)) {
                    dbItemsType = "3";
                } else if ("office".equals(itemsType)) {
                    dbItemsType = "4";
                }

                if (dbItemsType != null) {
                    List<Map<String, Object>> itemCatalog = productDAO.findByItemsTypeIncludingSubProducts(dbItemsType);

                    for (Map<String, Object> p : itemCatalog) {
                        Map<String, Object> item = new HashMap<>();
                        item.put("id", p.get("product_id"));
                        item.put("name", p.get("product_name"));
                        productList.add(item);
                        
                    }
                }

                Map<String, Object> data = new HashMap<>();
                data.put("productList", productList);

                writeJson(data, debugLog);
            }

            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    public String getCompanyLocation() {
        List<String> debugLog = new java.util.ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }

            String addressIdStr = request.getParameter("addressId");
            debugLog.add("addressIdStr = " + addressIdStr);

            Long addressId = Long.parseLong(addressIdStr);

            CompanyAddress address = companyAddressDAO.findById(addressId);
            debugLog.add("address = " + address);

            List<Map<String, Object>> contactList = companyContactDAO.findByAddressId(addressId);
            debugLog.add("contactList size = " + (contactList != null ? contactList.size() : 0));

            Map<String, Object> result = new HashMap<>();
            result.put("address", address);
            result.put("contactList", contactList);

            writeJson(result, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    public String getCompanyContact() {
        List<String> debugLog = new java.util.ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }

            String contactIdStr = request.getParameter("contactId");
            debugLog.add("contactIdStr = " + contactIdStr);

            Long contactId = Long.parseLong(contactIdStr);

            CompanyContact contact = companyContactDAO.findById(contactId);
            debugLog.add("contact = " + contact);
//            log.debug("getCompanyContact result: " + contact);

            writeJson(contact, debugLog);
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
    
    public String poPerformDelete() {
        try {
            if (onlineUser == null || poId == null || poId.trim().isEmpty()) {
                return ERROR;
            }
            String loginUserId = onlineUser.getId();
            Po po = poDAO.findById(poId);
            if (po != null) {
                if (!"6".equals(po.getStatus()) && !"5".equals(po.getStatus())) {
                    revertPrPulledByPo(poId);
                }
                po.setStatus("6");
                po.setUserUpdate(loginUserId);
                po.setTimeUpdate(DateUtil.getCurrentTime());
                poDAO.update(po);
            }
            return SUCCESS;

        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }

    public String confirmPoSign() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
            if (poId == null || poId.trim().isEmpty()) {
                debugLog.add("poId missing");
                writeJson(null, debugLog);
                return NONE;
            }

            Po po = poDAO.findById(poId);
            if (po == null) {
                debugLog.add("PO not found: " + poId);
                writeJson(null, debugLog);
                return NONE;
            }

            // กันกดซ้ำ / กันแก้ทับของเดิม
            if (po.getSignDate() != null) {
                Map<String, Object> result = new HashMap<>();
                result.put("success", false);
                result.put("message", "PO นี้มีการลงชื่อผู้ขอเบิกแล้ว");
                writeJson(result, debugLog);
                return NONE;
            }

            String loginUserId = onlineUser.getId();
            java.sql.Timestamp now = DateUtil.getCurrentTime();

            po.setSignUser(loginUserId);
            po.setSignDate(now);
            poDAO.update(po);

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

    public String getUnitOfMeasure() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }

            List<Map<String, Object>> unitList = new ArrayList<>();

            if (productId != null && !productId.trim().isEmpty()) {
                String lookupProductId = productId;

                // ถ้าเป็น sub product ให้ใช้ product id ของตัวแม่แทน
                Product product = productDAO.findById(Integer.valueOf(productId.trim()));
                if (product != null && product.getParentProductId() != null
                        && !"0".equals(String.valueOf(product.getParentProductId()).trim())) {
                    lookupProductId = String.valueOf(product.getParentProductId()).trim();
                }
                debugLog.add("productId = " + productId + ", lookupProductId(for unit) = " + lookupProductId);
                
                List<UnitOfMeasure> units = unitOfMeasureDAO.findByProductId(lookupProductId);
                for (UnitOfMeasure u : units) {
                    Map<String, Object> item = new HashMap<>();
                    item.put("id", u.getUnitId());
                    item.put("name", u.getUnitName());
                    item.put("conversionRate", u.getConversionRate());
                    item.put("sequence", u.getSequence());
                    unitList.add(item);
                }
            }
            debugLog.add("unitList size = " + unitList.size());

            Map<String, Object> data = new HashMap<>();
            data.put("unitList", unitList);

            writeJson(data, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }
    
    public String deletePoAttachment() {
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

    public String searchInprogressPr() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
            List<Map<String, Object>> prDetailList = prDetailDAO.findInprogressPrDetailForPrSearch();

            Map<String, String> parentNameCache = new HashMap<>();
            for (Map<String, Object> row : prDetailList) {
                row.put("parent_product_name", findParentProductName(row.get("product_id"), parentNameCache));
            }

            Map<String, Object> data = new HashMap<>();
            data.put("prDetailList", prDetailList);
            // log.debug("searchApprovedPr result: " + data);
            writeJson(data, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    private String findParentProductName(Object productIdObj, Map<String, String> cache) {
        if (productIdObj == null) return "";
        String key = String.valueOf(productIdObj).trim();
        if (key.isEmpty()) return "";
        if (cache.containsKey(key)) return cache.get(key);

        String name = "";
        try {
            Product product = productDAO.findById(Integer.valueOf(key));
            if (product != null && product.getParentProductId() != null) {
                String pp = String.valueOf(product.getParentProductId()).trim();
                if (!pp.isEmpty() && !"0".equals(pp)) {
                    Product parent = productDAO.findById(Integer.valueOf(pp));
                    if (parent != null) name = parent.getProductName();
                }
            }
        } catch (Exception e) {
            log.error("findParentProductName failed for " + key, e);
        }
        cache.put(key, name);
        return name;
    }

    private boolean blank(String s) {
        return s == null || s.trim().isEmpty();
    }

    // คืน status=0 ของ PR detail ทุกตัวที่ PO นี้ดึงไป (ตอน Reject / Cancel / Delete)
    private void revertPrPulledByPo(String poIdVal) throws Exception {
        List<Map<String, Object>> poDetailList = poDetailDAO.findPoDetailByPoId(poIdVal);
        if (poDetailList == null) return;
        for (Map<String, Object> d : poDetailList) {
            Object poDetailIdObj = d.get("po_detail_id");
            if (poDetailIdObj == null) continue;
            List<Map<String, Object>> parents = poParentDAO.findPoParentByPoDetailId(String.valueOf(poDetailIdObj));
            if (parents == null) continue;
            for (Map<String, Object> p : parents) {
                Object prIdObj = p.get("pr_id");
                Object productIdObj = p.get("product_id");
                if (prIdObj != null && productIdObj != null) {
                    prDetailDAO.revertPulledStatusByPrProduct(String.valueOf(prIdObj), String.valueOf(productIdObj));
                }
            }
        }
    }

    private double conversionRateOf(String unitId) {
        try {
            if (blank(unitId)) return 1d;
            UnitOfMeasure u = unitOfMeasureDAO.findById(Integer.valueOf(unitId.trim()));
            if (u != null && u.getConversionRate() != null) return u.getConversionRate().doubleValue();
        } catch (Exception e) {
            log.error("conversionRateOf failed for " + unitId, e);
        }
        return 1d;
    }

    private void applyDetailQty(PoDetail detail, double newQty, String userId) throws Exception {
        double tot = toDouble(detail.getPriceTotal());
        double q = Math.max(0d, newQty);

        detail.setAmountTotal(q);
        detail.setUnitPrice(String.valueOf(q > 0 ? tot / q : 0d));
        detail.setUserUpdate(userId);
        detail.setTimeUpdate(DateUtil.getCurrentTime());

        poDetailDAO.update(detail);
    }
}