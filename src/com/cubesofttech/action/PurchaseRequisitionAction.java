package com.cubesofttech.action;

import com.cubesofttech.dao.DocStatusDAO;
import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.PrDAO;
import com.cubesofttech.dao.PrDetailDAO;
import com.cubesofttech.dao.PrParentDAO;
import com.cubesofttech.dao.ProductDAO;
import com.cubesofttech.dao.UnitOfMeasureDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.WorkLogDAO;
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

import java.io.File;
import java.io.PrintWriter;
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
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

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
    private String productId;
    private String qty;
    private String unit;
    private String refLink;
    private String signUser;
    private String signDate;

    public String getPrDetailId() {
        return prDetailId;
    }

    public void setPrDetailId(String prDetailId) {
        this.prDetailId = prDetailId;
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
                    Object prDetailIdObj = detail.get("pr_detail_id");
                    if (prDetailIdObj != null) {
                        List<Map<String, Object>> parents = prParentDAO.findPrParentByPrDetailId(String.valueOf(prDetailIdObj));
                        if (parents != null) {
                            prParentList.addAll(parents);
                        }
                    }

                    Object productIdObj = detail.get("product_id");
                    if (productIdObj != null) {
                        Product product = productDAO.findById(Integer.valueOf(String.valueOf(productIdObj)));
                        if (product != null) {
                            detail.put("product_name", product.getProductName());
                            detail.put("product_type", product.getProductType());
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
            map.put(key, obj.get(key));
        }
        return map;
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

            List<Map<String, Object>> cartItems = new ArrayList<>();
            if (prDetailCartJson != null && !prDetailCartJson.trim().isEmpty()) {
                JSONArray jsonArray = new JSONArray(prDetailCartJson);
                for (int i = 0; i < jsonArray.length(); i++) {
                    JSONObject obj = jsonArray.getJSONObject(i);
                    cartItems.add(jsonObjectToMap(obj));
                }
            }
            debugLog.add("cartItems size = " + cartItems.size());

            // --- Header ---
            Pr pr = new Pr();
            pr.setPrId(newPrId);

            if(signDate != null && !signDate.trim().isEmpty()) {
                pr.setSignDate(java.sql.Timestamp.valueOf(signDate));
                pr.setSignUser(loginUserId);
            }

            pr.setDescription(description);
            pr.setUserCreate(loginUserId);
            pr.setTimeCreate(DateUtil.getCurrentTime());
            String prStatus = (status != null && !status.trim().isEmpty()) ? status : "1";
            pr.setStatus(prStatus); // 1 = Draft

            prDAO.save(pr);

         // --- Detail ---
            Long lastDetailId = prDetailDAO.getMaxId();
            Long lastParentId = prParentDAO.getMaxId();

            long nextDetailSeq = lastDetailId + 1;
            long nextParentSeq = lastParentId + 1;

            int seq = 0;
            for (Map<String, Object> item : cartItems) {
                double qty = toDouble(item.get("qty"));

                String prDetailId = String.valueOf(nextDetailSeq + seq);
                String prParentIdVal = String.valueOf(nextParentSeq + seq);

                String productId = item.get("productId") != null ? String.valueOf(item.get("productId")) : null;
                String parentIdVal = item.get("parentId") != null ? String.valueOf(item.get("parentId")) : "0";
                String unitVal = item.get("unit") != null ? String.valueOf(item.get("unit")) : null;
                String descVal = item.get("description") != null ? String.valueOf(item.get("description")) : null;
                String refLinkVal = item.get("refLink") != null ? String.valueOf(item.get("refLink")) : null;
                String mrIdVal = item.get("mrId") != null ? String.valueOf(item.get("mrId")) : null;
                String dbProductId = productId;
                String dbParentId = null;
                String dbItemsType = null;
                String itemsTypeVal = String.valueOf(item.get("itemsType"));

                if(itemsTypeVal != null){
                    if ("equipment".equals(itemsTypeVal)) {
                        dbItemsType = "1";
                    } else if ("consumables".equals(itemsTypeVal)) {
                        dbItemsType = "2";

                    } else if ("accessory".equals(itemsTypeVal)) {
                        dbItemsType = "3";
                    }else if ("office".equals(itemsTypeVal)) {
                        dbItemsType = "4";
                    }

                    Product p = productDAO.findById(Integer.valueOf(productId));
                    dbProductId = p.getProductId().toString();
                    dbParentId = String.valueOf(p.getParentProductId());
                }

//                String itemsTypeVal = item.get("items_type") != null ? String.valueOf(item.get("items_type")) : null;

                // --- PrDetail ---
                PrDetail detail = new PrDetail();
                detail.setPrDetailId(prDetailId);
                detail.setPrId(newPrId);
                detail.setProductId(productId);
                detail.setProductId(dbProductId);
                detail.setParentId(dbParentId);

                detail.setUnit(unitVal);
                detail.setAmountTotal(qty);
                detail.setDescription(descVal);
                detail.setRefLink(refLinkVal);
                detail.setUserCreate(loginUserId);
                detail.setTimeCreate(DateUtil.getCurrentTime());
                detail.setUserUpdate(loginUserId);
                detail.setTimeUpdate(DateUtil.getCurrentTime());

                prDetailDAO.save(detail);

                // --- PrParent ---
                PrParent parent = new PrParent();
                parent.setPrParentId(prParentIdVal);
                parent.setPrDetailId(prDetailId);
                parent.setMrId(mrIdVal);

                parent.setProductId(dbProductId);
                parent.setParentId(dbParentId);

                parent.setAmount(qty);
                parent.setUnit(unitVal);
                parent.setDescription(descVal);
                parent.setUserCreate(loginUserId);
                parent.setTimeCreate(DateUtil.getCurrentTime());
                parent.setUserUpdate(loginUserId);
                parent.setTimeUpdate(DateUtil.getCurrentTime());

                prParentDAO.save(parent);

                seq++;
            }

            // --- Attach files (page='pr', pageId= newPrId) ---
            log.debug("files = " + (files == null ? "null" : files.size())
                + ", filesFileName = " + (filesFileName == null ? "null" : filesFileName));

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

            pr.setDescription(description);
            pr.setUserUpdate(loginUserId);
            pr.setTimeUpdate(DateUtil.getCurrentTime());

            if (status != null && !status.trim().isEmpty()) {
                pr.setStatus(status);
            }

            // --- Detail ---
            List<Map<String, Object>> cartItems = new ArrayList<>();
            if (prDetailCartJson != null && !prDetailCartJson.trim().isEmpty()) {
                JSONArray jsonArray = new JSONArray(prDetailCartJson);
                for (int i = 0; i < jsonArray.length(); i++) {
                    JSONObject obj = jsonArray.getJSONObject(i);
                    cartItems.add(jsonObjectToMap(obj));
                }
            }
            debugLog.add("new cartItems size = " + cartItems.size());

            Long lastDetailId = prDetailDAO.getMaxId();
            Long lastParentId = prParentDAO.getMaxId();
            long nextDetailSeq = lastDetailId + 1;
            long nextParentSeq = lastParentId + 1;

            int seq = 0;
            for (Map<String, Object> item : cartItems) {
                double qty = toDouble(item.get("qty"));

                String prDetailId = String.valueOf(nextDetailSeq + seq);
                String prParentIdVal = String.valueOf(nextParentSeq + seq);

                String productId = item.get("productId") != null ? String.valueOf(item.get("productId")) : null;
                String unitVal = item.get("unit") != null ? String.valueOf(item.get("unit")) : null;
                String descVal = item.get("description") != null ? String.valueOf(item.get("description")) : null;
                String refLinkVal = item.get("refLink") != null ? String.valueOf(item.get("refLink")) : null;
                String mrIdVal = item.get("mrId") != null ? String.valueOf(item.get("mrId")) : null;
                String dbProductId = productId;
                String dbParentId = null;
                String dbItemsType = null;
                String itemsTypeVal = String.valueOf(item.get("itemsType"));

                if(itemsTypeVal != null){
                    if ("equipment".equals(itemsTypeVal)) {
                        dbItemsType = "1";
                    } else if ("consumables".equals(itemsTypeVal)) {
                        dbItemsType = "2";
                    } else if ("accessory".equals(itemsTypeVal)) {
                        dbItemsType = "3";
                    }else if ("office".equals(itemsTypeVal)) {
                        dbItemsType = "4";
                    }

                    Product p = productDAO.findById(Integer.valueOf(productId));
                    dbProductId = p.getProductId().toString();
                    dbParentId = String.valueOf(p.getParentProductId());
                }
                // if ("equipment".equals(itemsTypeVal)) {
                //     dbItemsType = "1";
                //     Product p = productDAO.findById(Integer.valueOf(productId));
                //     dbProductId = p.getProductId().toString();
                //     dbParentId = null;
                // } else if ("consumables".equals(itemsTypeVal)) {
                //     dbItemsType = "2";
                //     Product p = productDAO.findById(Integer.valueOf(productId));
                //     dbProductId = p.getProductId().toString();
                //     dbParentId = String.valueOf(p.getParentProductId());
                // } else if ("office".equals(itemsTypeVal)) {
                //     dbItemsType = "3";
                //     Product p = productDAO.findById(Integer.valueOf(productId));
                //     dbProductId = p.getProductId().toString();
                //     dbParentId = String.valueOf(p.getParentProductId());
                // }

                // --- PrDetail ---
                PrDetail detail = new PrDetail();
                detail.setPrDetailId(prDetailId);
                detail.setPrId(prId);
                detail.setProductId(dbProductId);
                detail.setParentId(dbParentId);
                detail.setUnit(unitVal);
                detail.setAmountTotal(qty);
                detail.setDescription(descVal);
                detail.setRefLink(refLinkVal);
                detail.setUserCreate(loginUserId);
                detail.setTimeCreate(DateUtil.getCurrentTime());
                detail.setUserUpdate(loginUserId);
                detail.setTimeUpdate(DateUtil.getCurrentTime());

                prDetailDAO.save(detail);

                // --- PrParent ---
                PrParent parent = new PrParent();
                parent.setPrParentId(prParentIdVal);
                parent.setPrDetailId(prDetailId);
                parent.setMrId(mrIdVal);
                parent.setProductId(dbProductId);
                parent.setParentId(dbParentId);
                parent.setAmount(qty);
                parent.setUnit(unitVal);
                parent.setDescription(descVal);
                parent.setUserCreate(loginUserId);
                parent.setTimeCreate(DateUtil.getCurrentTime());
                parent.setUserUpdate(loginUserId);
                parent.setTimeUpdate(DateUtil.getCurrentTime());


                prParentDAO.save(parent);
                seq++;
            }

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

            double itemQty = qty != null ? toDouble(qty) : 0d;

            detail.setProductId(productId);
            detail.setUnit(unit);
            detail.setAmountTotal(itemQty);
            detail.setDescription(description);
            detail.setRefLink(refLink);
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
            if ("1".equals(status)) {
                pr.setReason(null);
            } else if (reason != null) {
                pr.setReason(reason.trim());
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

}
