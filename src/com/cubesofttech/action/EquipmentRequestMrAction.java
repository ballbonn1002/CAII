package com.cubesofttech.action;

import com.cubesofttech.dao.DocStatusDAO;
import com.cubesofttech.dao.EquipmentRequestMrNewDAO;
import com.cubesofttech.dao.ProductDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.DocStatus;
import com.cubesofttech.model.EquipmentRequestMr;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.Po;
import com.cubesofttech.model.Product;
import com.cubesofttech.model.User;
import com.cubesofttech.service.FileAttachmentService;
import com.cubesofttech.util.DateUtil;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class EquipmentRequestMrAction extends ActionSupport {

    private static final long serialVersionUID = 1L;

    Logger log = Logger.getLogger(getClass());
    HttpServletRequest request = ServletActionContext.getRequest();
    HttpServletResponse response = ServletActionContext.getResponse();

    private User onlineUser = (User) request.getSession().getAttribute("onlineUser");

    @Autowired
    private EquipmentRequestMrNewDAO equipmentRequestMrNewDAO;

    @Autowired
    private DocStatusDAO docStatusDAO;

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private FileAttachmentService fileAttachmentService;

    @Autowired
    private ProductDAO productDAO;

    private String mrId;
    private String fileId;

    public String getMrId() {
        return mrId;
    }

    public void setMrId(String mrId) {
        this.mrId = mrId;
    }

    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    private String productId;
    private String subProductId;
    private String amount;
    private String description;
    private String urlRef;
    private String status;
    private String signDate;
    private List<File> files;
    private List<String> filesFileName;
    private String reason;

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getSubProductId() {
        return subProductId;
    }

    public void setSubProductId(String subProductId) {
        this.subProductId = subProductId;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUrlRef() {
        return urlRef;
    }

    public void setUrlRef(String urlRef) {
        this.urlRef = urlRef;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSignDate() {
        return signDate;
    }

    public void setSignDate(String signDate) {
        this.signDate = signDate;
    }

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

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String equipmentRequestMrList() {
        try {
            if (onlineUser == null) {
                return LOGIN;
            }

            List<Map<String, Object>> mrList = equipmentRequestMrNewDAO.findMyMrList(onlineUser.getId());
            if (mrList == null) {
                mrList = new ArrayList<>();
            }
            request.setAttribute("mrList", mrList);

            // --- Summary ---
            List<DocStatus> statuses = docStatusDAO.findByPage("mr");
            statuses.sort(Comparator.comparingInt(ds -> ds.getStatusCode() != null && ds.getStatusCode().matches("\\d+")
                    ? Integer.parseInt(ds.getStatusCode()) : Integer.MAX_VALUE));

            // นับจำนวนตาม status_code
            Map<String, Integer> summary = new HashMap<>();
            Map<String, String> statusNames = new HashMap<>();
            Map<String, String> statusColors = new HashMap<>();
            for (DocStatus ds : statuses) {
                summary.put(ds.getStatusCode(), 0);
                statusNames.put(ds.getStatusCode(), ds.getStatusName());
                statusColors.put(ds.getStatusCode(), ds.getColor());
            }
            for (Map<String, Object> mr : mrList) {
                String code = String.valueOf(mr.get("status_code"));
                if (summary.containsKey(code)) {
                    summary.put(code, summary.get(code) + 1);
                }
            }

            request.setAttribute("mrStatuses", statuses);
            request.setAttribute("mrSummary", summary);
            request.setAttribute("mrStatusNames", statusNames);
            request.setAttribute("mrStatusColors", statusColors);
            request.setAttribute("mrSummaryTotal", mrList.size());

            return SUCCESS;
        } catch (Exception e) {
            log.error(e);
            e.printStackTrace();
            return ERROR;
        }
    }

    public String equipmentRequestMrAdd() {
        try {
            if (onlineUser == null) {
                return LOGIN;
            }

            User u = userDAO.findById(onlineUser.getId());
            request.setAttribute("loginUser", u);

            String signaturePath = fileAttachmentService.getFileUrl(u.getPathSignature());
            request.setAttribute("imgPathSignature", signaturePath);

            List<Map<String, Object>> mainItems = equipmentRequestMrNewDAO.findMainItems();
            request.setAttribute("mainItemList", mainItems != null ? mainItems : new ArrayList<Map<String, Object>>());

            DocStatus draft = findMrStatusByCode("1");
            request.setAttribute("draftStatus", draft);

            request.setAttribute("requestDateTime", new Date());

            return SUCCESS;
        } catch (Exception e) {
            log.error(e);
            e.printStackTrace();
            return ERROR;
        }
    }

    //sub item ของ Item ที่เลือก (param productId = product_id ของ Item)
    public String getMrSubItem() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }

            List<Map<String, Object>> subItemList = new ArrayList<>();
            if (productId != null && !productId.trim().isEmpty()) {
                List<Map<String, Object>> rows = equipmentRequestMrNewDAO.findSubItems(productId.trim());
                if (rows != null) {
                    for (Map<String, Object> p : rows) {
                        Map<String, Object> item = new HashMap<>();
                        item.put("id", p.get("product_id"));
                        item.put("name", p.get("product_name"));
                        subItemList.add(item);
                    }
                }
            }
            debugLog.add("subItemList size = " + subItemList.size());

            Map<String, Object> data = new HashMap<>();
            data.put("subItemList", subItemList);
            writeJson(data, debugLog);
            return NONE;
        } catch (Exception e) {
            log.error(e);
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    // หน่วยเล็กสุดของ Item ตัวแม่
    public String getMrUnit() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }

            String lookupProductId = (productId != null && !productId.trim().isEmpty()) ? productId.trim() : null;
            String unitName = null;
            if (lookupProductId != null) {
                unitName = equipmentRequestMrNewDAO.findSmallestUnitName(lookupProductId);
            }
            debugLog.add("lookupProductId = " + lookupProductId + ", unitName = " + unitName);

            Map<String, Object> data = new HashMap<>();
            data.put("unitName", unitName);
            writeJson(data, debugLog);
            return NONE;
        } catch (Exception e) {
            log.error(e);
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    public String saveMr() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
            String loginUserId = onlineUser.getId();

            if (productId == null || productId.trim().isEmpty()) {
                debugLog.add("productId missing");
                writeJson(null, debugLog);
                return NONE;
            }

            String statusCode = "2".equals(status) ? "2" : "1";
            DocStatus ds = findMrStatusByCode(statusCode);
            if (ds == null) {
                debugLog.add("doc_status page=mr code=" + statusCode + " not found");
                writeJson(null, debugLog);
                return NONE;
            }

            String newMrId = generateNewMrId();
            debugLog.add("newMrId = " + newMrId);

            boolean hasSub = subProductId != null && !subProductId.trim().isEmpty();
            String dbProductId = hasSub ? subProductId.trim() : productId.trim();
            String dbParentId = hasSub ? productId.trim() : "0";

            java.sql.Timestamp now = DateUtil.getCurrentTime();

            EquipmentRequestMr mr = new EquipmentRequestMr();
            mr.setMrId(newMrId);
            mr.setProducId(dbProductId);
            mr.setParentId(dbParentId);
            mr.setAmount(parseDouble(amount));
            mr.setStatusId(ds.getStatusCode());
            mr.setDescription(description);
            mr.setUrlRef(urlRef);
            if (signDate != null && !signDate.trim().isEmpty()) {
                mr.setRequestUser(loginUserId);
                mr.setRequestDate(java.sql.Timestamp.valueOf(signDate.trim()));
            }
            mr.setUserCreate(loginUserId);
            mr.setTimeCreate(now);
            mr.setUserUpdate(loginUserId);
            mr.setTimeUpdate(now);

            equipmentRequestMrNewDAO.save(mr);

            fileAttachmentService.attach(files, filesFileName, "mr", newMrId, loginUserId,
                    request.getServletContext().getRealPath("/"));

            Map<String, Object> result = new HashMap<>();
            result.put("mrId", newMrId);
            writeJson(result, debugLog);
            return NONE;
        } catch (Exception e) {
            log.error(e);
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    public String equipmentRequestMrEdit() {
        try {
            if (onlineUser == null) {
                return LOGIN;
            }
            
            EquipmentRequestMr mr = loadMr();
            if (mr == null) {
                return LOGIN; 
            }
            User u = userDAO.findById(onlineUser.getId());
            request.setAttribute("loginUser", u);
            request.setAttribute("imgPathSignature", fileAttachmentService.getFileUrl(u.getPathSignature()));
            
            if (Arrays.asList("3", "4", "5", "6").contains(mr.getStatusId())) {
                String userUpdateId = mr.getUserUpdate();

                if (userUpdateId != null && !userUpdateId.trim().isEmpty()) {
                    User userUpdate = userDAO.findById(userUpdateId);
                    request.setAttribute("userUpdate", userUpdate);
                }
            }

            List<Map<String, Object>> mainItems = equipmentRequestMrNewDAO.findMainItems();
            request.setAttribute("mainItemList", mainItems != null ? mainItems : new ArrayList<Map<String, Object>>());

            // mr.status_id เก็บ status_code
            DocStatus mrStatus = null;
            for (DocStatus ds : docStatusDAO.findByPage("mr")) {
                if (ds.getStatusCode() != null && ds.getStatusCode().equals(mr.getStatusId())) {
                    mrStatus = ds;
                    break;
                }
            }
            request.setAttribute("mrStatus", mrStatus);
            String[] itemAndSub = resolveItemAndSub(mr);
            request.setAttribute("selectedItemId", itemAndSub[0]);
            request.setAttribute("selectedSubItemId", itemAndSub[1]);

            request.setAttribute("mr", mr);
            // log.debug("----mr------: " + mr);

            String itemName = "";
            String subItemName = "";
            String itemType = "";
            String parentIdForUnit = "";
            try {
                String parentIdStr = mr.getParentId() != null ? mr.getParentId().trim() : "";
                String prodIdStr = mr.getProducId() != null ? mr.getProducId().trim() : "";

                // ตัวแม่ (parentId)
                if (!parentIdStr.isEmpty() && !"0".equals(parentIdStr)) {
                    Product parent = productDAO.findById(Integer.valueOf(parentIdStr));
                    if (parent != null) {
                        itemName = parent.getProductName();
                        itemType = String.valueOf(parent.getProductType());
                        parentIdForUnit = parentIdStr;
                    }
                }
                // product_id ของ MR (ลูก หรือ ตัวแม่เอง)
                if (!prodIdStr.isEmpty()) {
                    Product self = productDAO.findById(Integer.valueOf(prodIdStr));
                    if (self != null) {
                        if (self.getParentProductId() == null || "0".equals(self.getParentProductId())) {
                            // ชี้ตัวแม่เอง ไม่มี sub
                            itemName = self.getProductName();
                            itemType = String.valueOf(self.getProductType());
                            parentIdForUnit = prodIdStr;
                        } else {
                            subItemName = self.getProductName();
                        }
                    }
                }
            } catch (NumberFormatException e) {
                log.error(e);
            }
            request.setAttribute("mrItemName", itemName);
            request.setAttribute("mrSubItemName", subItemName);
            request.setAttribute("mrItemType", itemType);

            //--- Get Request User ---
            if (mr.getRequestUser() != null && !mr.getRequestUser().trim().isEmpty()) {
                User userRequest = userDAO.findById(mr.getRequestUser());
                request.setAttribute("userRequest", userRequest);
                request.setAttribute("requestDate", mr.getRequestDate());
            }

            //--- Get Approve User ---
            if (mr.getApproveUser() != null && !mr.getApproveUser().trim().isEmpty()) {
                User userApprove = userDAO.findById(mr.getApproveUser());
                request.setAttribute("userApprove", userApprove);
                request.setAttribute("approveDate", mr.getApproveDate());
            }

            //--- Get Receive User ---
            if (mr.getReceiveUser() != null && !mr.getReceiveUser().trim().isEmpty()) {
                User userReceive = userDAO.findById(mr.getReceiveUser());
                request.setAttribute("userReceive", userReceive);
                request.setAttribute("receiveDate", mr.getReceiveDate());
            }

            String unitName = parentIdForUnit.isEmpty() ? null
                    : equipmentRequestMrNewDAO.findSmallestUnitName(parentIdForUnit);
            request.setAttribute("mrUnitName", unitName != null ? unitName : "-");

            List<FileUpload> attachmentList = fileAttachmentService.listAttachments("mr", mr.getMrId());
            request.setAttribute("attachmentList", attachmentList);

            return SUCCESS;
        } catch (Exception e) {
            log.error(e);
            e.printStackTrace();
            return ERROR;
        }
    }

    public String equipmentRequestMrListAdmin() {
        try {
            if (onlineUser == null) {
                return LOGIN;
            }

            List<Map<String, Object>> mrList = equipmentRequestMrNewDAO.findAllMrList();
            if (mrList == null) {
                mrList = new ArrayList<>();
            }
            List<Map<String, Object>> filteredList = new ArrayList<>();
            for (Map<String, Object> mr : mrList) {
                String code = String.valueOf(mr.get("status_code"));
                if (!code.equals("1") && !code.equals("6")) {
                    //--- Get Request User ---
                    Object reqUser = mr.get("user_create");
                    if (reqUser != null && !reqUser.toString().trim().isEmpty()) {
                        User u = userDAO.findById(reqUser.toString());
                        String displayName = reqUser.toString();
                        if (u != null) {
                            if (u.getNameEN() != null && !u.getNameEN().trim().isEmpty()) {
                                displayName = u.getNameEN();
                            } else if (u.getName() != null && !u.getName().trim().isEmpty()) {
                                displayName = u.getName();
                            }
                            mr.put("requestUserPath", u.getPath());
                        }
                        mr.put("requestUserName", displayName);
                    }
                    filteredList.add(mr);
                }
            }
            mrList = filteredList;
            request.setAttribute("mrList", mrList);
            // log.debug("------mrList admin ----- " + mrList);

            // --- Summary ---
            List<DocStatus> statuses = docStatusDAO.findByPage("mr");
            List<DocStatus> filteredStatuses = new ArrayList<>();
            for (DocStatus ds : statuses) {
                String code = ds.getStatusCode();
                if (!"1".equals(code) && !"6".equals(code)) {
                    filteredStatuses.add(ds);
                }
            }
            statuses = filteredStatuses;
            statuses.sort(Comparator.comparingInt(ds -> ds.getStatusCode() != null && ds.getStatusCode().matches("\\d+")
                    ? Integer.parseInt(ds.getStatusCode()) : Integer.MAX_VALUE));

            Map<String, Integer> summary = new HashMap<>();
            Map<String, String> statusNames = new HashMap<>();
            Map<String, String> statusColors = new HashMap<>();
            for (DocStatus ds : statuses) {
                summary.put(ds.getStatusCode(), 0);
                statusNames.put(ds.getStatusCode(), ds.getStatusName());
                statusColors.put(ds.getStatusCode(), ds.getColor());
            }
            for (Map<String, Object> mr : mrList) {
                String code = String.valueOf(mr.get("status_code"));
                if (summary.containsKey(code)) {
                    summary.put(code, summary.get(code) + 1);
                }
            }

            request.setAttribute("mrStatuses", statuses);
            request.setAttribute("mrSummary", summary);
            request.setAttribute("mrStatusNames", statusNames);
            request.setAttribute("mrStatusColors", statusColors);
            request.setAttribute("mrSummaryTotal", mrList.size());

            return SUCCESS;
        } catch (Exception e) {
            log.error(e);
            e.printStackTrace();
            return ERROR;
        }
    }

    public String equipmentRequestMrApprove() {
        try {
            if (onlineUser == null) {
                return LOGIN;
            }

            EquipmentRequestMr mr = (mrId == null || mrId.trim().isEmpty()) ? null
                : equipmentRequestMrNewDAO.findMrById(mrId.trim());
            if (mr == null) {
                return LOGIN;
            }

            User u = userDAO.findById(onlineUser.getId());
            request.setAttribute("loginUser", u);
            request.setAttribute("imgPathSignature", fileAttachmentService.getFileUrl(u.getPathSignature()));
            
            if (Arrays.asList("3", "4", "5", "6").contains(mr.getStatusId())) {
                String userUpdateId = mr.getUserUpdate();

                if (userUpdateId != null && !userUpdateId.trim().isEmpty()) {
                    User userUpdate = userDAO.findById(userUpdateId);
                    request.setAttribute("userUpdate", userUpdate);
                }
            }
            
            List<Map<String, Object>> mainItems = equipmentRequestMrNewDAO.findMainItems();
            request.setAttribute("mainItemList", mainItems != null ? mainItems : new ArrayList<Map<String, Object>>());

            DocStatus mrStatus = null;
            for (DocStatus ds : docStatusDAO.findByPage("mr")) {
                if (ds.getStatusCode() != null && ds.getStatusCode().equals(mr.getStatusId())) {
                    mrStatus = ds;
                    break;
                }
            }
            request.setAttribute("mrStatus", mrStatus);
            String[] itemAndSub = resolveItemAndSub(mr);
            request.setAttribute("selectedItemId", itemAndSub[0]);
            request.setAttribute("selectedSubItemId", itemAndSub[1]);

            request.setAttribute("mr", mr);

            String itemName = "";
            String subItemName = "";
            String itemType = "";
            String parentIdForUnit = "";
            try {
                String parentIdStr = mr.getParentId() != null ? mr.getParentId().trim() : "";
                String prodIdStr = mr.getProducId() != null ? mr.getProducId().trim() : "";

                // ตัวแม่ (parentId)
                if (!parentIdStr.isEmpty() && !"0".equals(parentIdStr)) {
                    Product parent = productDAO.findById(Integer.valueOf(parentIdStr));
                    if (parent != null) {
                        itemName = parent.getProductName();
                        itemType = String.valueOf(parent.getProductType());
                        parentIdForUnit = parentIdStr;
                    }
                }
                // product_id ของ MR (ลูก หรือ ตัวแม่เอง)
                if (!prodIdStr.isEmpty()) {
                    Product self = productDAO.findById(Integer.valueOf(prodIdStr));
                    if (self != null) {
                        if (self.getParentProductId() == null || "0".equals(self.getParentProductId())) {
                            // ชี้ตัวแม่เอง ไม่มี sub
                            itemName = self.getProductName();
                            itemType = String.valueOf(self.getProductType());
                            parentIdForUnit = prodIdStr;
                        } else {
                            subItemName = self.getProductName();
                        }
                    }
                }
            } catch (NumberFormatException e) {
                log.error(e);
            }
            request.setAttribute("mrItemName", itemName);
            request.setAttribute("mrSubItemName", subItemName);
            request.setAttribute("mrItemType", itemType);

            // log.debug("mrItemName=" + itemName + ", mrSubItemName=" + subItemName + ", mrItemType=" + itemType);

            //--- Get Request User ---
            if (mr.getRequestUser() != null && !mr.getRequestUser().trim().isEmpty()) {
                User userRequest = userDAO.findById(mr.getRequestUser());
                request.setAttribute("userRequest", userRequest);
                request.setAttribute("requestDate", mr.getRequestDate());
            }

            //--- Get Approve User ---
            if (mr.getApproveUser() != null && !mr.getApproveUser().trim().isEmpty()) {
                User userApprove = userDAO.findById(mr.getApproveUser());
                request.setAttribute("userApprove", userApprove);
                request.setAttribute("approveDate", mr.getApproveDate());
            }

            //--- Get Receive User ---
            if (mr.getReceiveUser() != null && !mr.getReceiveUser().trim().isEmpty()) {
                User userReceive = userDAO.findById(mr.getReceiveUser());
                request.setAttribute("userReceive", userReceive);
                request.setAttribute("receiveDate", mr.getReceiveDate());
            }

            String unitName = parentIdForUnit.isEmpty() ? null
                    : equipmentRequestMrNewDAO.findSmallestUnitName(parentIdForUnit);
            request.setAttribute("mrUnitName", unitName != null ? unitName : "-");

            List<FileUpload> attachmentList = fileAttachmentService.listAttachments("mr", mr.getMrId());
            request.setAttribute("attachmentList", attachmentList);

            return SUCCESS;
        } catch (Exception e) {
            log.error(e);
            e.printStackTrace();
            return ERROR;
        }
    }

    public String updateMr() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }
         
            EquipmentRequestMr mr = loadMr();
            if (mr == null) {
                return LOGIN; 
            }

            String loginUserId = onlineUser.getId();

            if (productId == null || productId.trim().isEmpty()) {
                debugLog.add("productId missing");
                writeJson(null, debugLog);
                return NONE;
            }

            String statusCode = "2".equals(status) ? "2" : "1";
            DocStatus ds = findMrStatusByCode(statusCode);
            if (ds == null) {
                debugLog.add("doc_status page=mr code=" + statusCode + " not found");
                writeJson(null, debugLog);
                return NONE;
            }

            // product_id = ตัวที่เลือกจริงล่างสุด, parent_id = ตัวแม่
            boolean hasSub = subProductId != null && !subProductId.trim().isEmpty();
            mr.setProducId(hasSub ? subProductId.trim() : productId.trim());
            mr.setParentId(hasSub ? productId.trim() : "0");
            mr.setAmount(parseDouble(amount));
            mr.setStatusId(ds.getStatusCode());// mr.status_id เก็บ status_code
            mr.setDescription(description);
            mr.setUrlRef(urlRef);

            // ลงชื่อผู้ขอเบิกแล้วจะไม่เขียนทับ — set เฉพาะกรณียังไม่เคยลงชื่อ
            if (mr.getRequestDate() == null && signDate != null && !signDate.trim().isEmpty()) {
                mr.setRequestUser(loginUserId);
                mr.setRequestDate(java.sql.Timestamp.valueOf(signDate.trim()));
            }

            mr.setUserUpdate(loginUserId);
            mr.setTimeUpdate(DateUtil.getCurrentTime());

            equipmentRequestMrNewDAO.update(mr);

            fileAttachmentService.attach(files, filesFileName, "mr", mr.getMrId(), loginUserId,
                    request.getServletContext().getRealPath("/"));

            Map<String, Object> result = new HashMap<>();
            result.put("mrId", mr.getMrId());
            writeJson(result, debugLog);
            return NONE;
        } catch (Exception e) {
            log.error(e);
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    //ลบไฟล์แนบเดิมของ MR
    public String deleteMrAttachment() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }

            EquipmentRequestMr mr = loadMr();
            if (mr == null) {
                return LOGIN; 
            }

            boolean belongsToMr = false;
            for (FileUpload fu : fileAttachmentService.listAttachments("mr", mr.getMrId())) {
                if (fu.getFileId() != null && fileId.trim().equals(String.valueOf(fu.getFileId()))) {
                    belongsToMr = true;
                    break;
                }
            }
            if (!belongsToMr) {
                debugLog.add("fileId " + fileId + " not attached to " + mr.getMrId());
                writeJson(null, debugLog);
                return NONE;
            }

            fileAttachmentService.deleteByIds(java.util.Collections.singletonList(fileId.trim()),
                    ServletActionContext.getServletContext().getRealPath("/"));

            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            writeJson(result, debugLog);
            return NONE;
        } catch (Exception e) {
            log.error(e);
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    //soft delete MR (status → Cancel) — ลบได้เฉพาะ MR ของตัวเองที่ยังเป็น Draft
    public String deleteMr() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }

            EquipmentRequestMr mr = loadMr();
            if (mr == null) {
                return LOGIN; 
            }

            DocStatus cancel = findMrStatusByCode("6");
            if (cancel == null) {
                debugLog.add("doc_status page=mr code=6 not found");
                writeJson(null, debugLog);
                return NONE;
            }

            int rows = equipmentRequestMrNewDAO.deleteById(mr.getMrId(), cancel.getStatusCode(), onlineUser.getId());
            debugLog.add("updated rows = " + rows);

            Map<String, Object> result = new HashMap<>();
            result.put("success", rows > 0);
            writeJson(result, debugLog);
            return NONE;
        } catch (Exception e) {
            log.error(e);
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }

    // หา Item (ตัวแม่) / Sub item จาก product_id
    private String[] resolveItemAndSub(EquipmentRequestMr mr) {
        String pid = mr.getProducId() != null ? mr.getProducId().trim() : null;
        if (pid == null || pid.isEmpty()) {
            return new String[] { null, null };
        }
        try {
            Product p = productDAO.findById(Integer.valueOf(pid));
            String parent = p != null && p.getParentProductId() != null ? p.getParentProductId().trim() : "0";
            if (!parent.isEmpty() && !"0".equals(parent)) {
                return new String[] { parent, pid };// product_id เป็นตัวลูก
            }

            String oldSub = mr.getParentId() != null ? mr.getParentId().trim() : "";
            if (!oldSub.isEmpty() && !"0".equals(oldSub)) {
                Product s = productDAO.findById(Integer.valueOf(oldSub));
                if (s != null && s.getParentProductId() != null && pid.equals(s.getParentProductId().trim())) {
                    return new String[] { pid, oldSub };
                }
            }
        } catch (Exception e) {
            log.warn("resolveItemAndSub failed for mr " + mr.getMrId() + ": " + e);
        }
        return new String[] { pid, null };
    }

    // --- generate mrId: MR + yyyy + running 8 หลัก  ---
    private String generateNewMrId() throws Exception {
        String year = String.valueOf(java.time.Year.now().getValue());
        String prefix = "MR" + year;
        String maxMrId = equipmentRequestMrNewDAO.findMaxMrIdByPrefix(prefix + "%");

        long nextSeq = 1L;
        if (maxMrId != null && maxMrId.length() >= prefix.length() + 8) {
            String seqPart = maxMrId.substring(prefix.length());
            try {
                nextSeq = Long.parseLong(seqPart) + 1;
            } catch (NumberFormatException nfe) {
                nextSeq = 1L;
            }
        }
        return prefix + String.format("%08d", nextSeq);
    }

    private EquipmentRequestMr loadMr() throws Exception {
        if (mrId == null || mrId.trim().isEmpty()) {
            return null;
        }
        return equipmentRequestMrNewDAO.findMrById(mrId.trim());
    }

    private DocStatus findMrStatusByCode(String statusCode) throws Exception {
        List<DocStatus> statuses = docStatusDAO.findByPage("mr");
        if (statuses != null) {
            for (DocStatus ds : statuses) {
                if (statusCode.equals(ds.getStatusCode())) {
                    return ds;
                }
            }
        }
        return null;
    }

    public String updateStatusMr() {
        List<String> debugLog = new ArrayList<>();
        try {
            if (onlineUser == null) {
                writeJsonError();
                return NONE;
            }

            if ("5".equals(status)) { // Rejected
                if (reason == null || reason.trim().length() < 10) {
                    debugLog.add("reason invalid for reject");
                    writeJson(null, debugLog);
                    return NONE;
                }
            }

            EquipmentRequestMr mr = equipmentRequestMrNewDAO.findMrById(mrId);
            mr.setStatusId(status);
            if (reason != null && !reason.trim().isEmpty()) {
                mr.setReason(reason.trim());
            }
            
            if ("3".equals(status)) {
                mr.setApproveUser(onlineUser.getId());
                mr.setApproveDate(DateUtil.getCurrentTime());
            }
            mr.setUserUpdate(onlineUser.getId());
            mr.setTimeUpdate(DateUtil.getCurrentTime());

            equipmentRequestMrNewDAO.update(mr);

            Map<String, Object> result = new HashMap<>();
            result.put("mrId", mrId);
            writeJson(result, debugLog);
            return NONE;

        } catch (Exception e) {
            e.printStackTrace();
            debugLog.add("EXCEPTION: " + e.toString());
            writeJson(null, debugLog);
            return NONE;
        }
    }
    

    private Double parseDouble(String val) {
        if (val == null || val.trim().isEmpty()) return null;
        try {
            return Double.parseDouble(val.trim());
        } catch (Exception e) {
            return null;
        }
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

}
