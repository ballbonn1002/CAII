package com.cubesofttech.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.SupportDAO;
import com.cubesofttech.dao.SupportMenuDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.Support;
import com.cubesofttech.model.SupportMenu;
import com.cubesofttech.util.DateUtil;
import com.cubesofttech.util.FileUtil;
import com.opensymphony.xwork2.ActionSupport;

public class HelpSupportAction extends ActionSupport {

    private static final long serialVersionUID = 1L;
    private static final Logger log = Logger.getLogger(HelpSupportAction.class);

    HttpServletRequest request = ServletActionContext.getRequest();
    HttpServletResponse response = ServletActionContext.getResponse();

    @Autowired
    private SupportDAO supportDAO;

    @Autowired
    private SupportMenuDAO supportMenuDAO;

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private com.cubesofttech.dao.SupportDetailDAO supportDetailDAO;

    @Autowired
    private com.cubesofttech.dao.FileUploadDAO fileUploadDAO;

    private String categorized;
    private String supportMenuId;
    private String description;
    private String supportId;
    private java.io.File[] files;
    private String[] filesFileName;
    private String[] filesContentType;
    private String userId;
    private String newStatus;
    private String adminMessage;

    public String getCategorized() {
        return categorized;
    }

    public void setCategorized(String categorized) {
        this.categorized = categorized;
    }

    public String getSupportMenuId() {
        return supportMenuId;
    }

    public void setSupportMenuId(String supportMenuId) {
        this.supportMenuId = supportMenuId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSupportId() {
        return supportId;
    }

    public void setSupportId(String supportId) {
        this.supportId = supportId;
    }

    public java.io.File[] getFiles() {
        return files;
    }

    public void setFiles(java.io.File[] files) {
        this.files = files;
    }

    public String[] getFilesFileName() {
        return filesFileName;
    }

    public void setFilesFileName(String[] filesFileName) {
        this.filesFileName = filesFileName;
    }

    public String[] getFilesContentType() {
        return filesContentType;
    }

    public void setFilesContentType(String[] filesContentType) {
        this.filesContentType = filesContentType;
    }

    public String getNewStatus() {
        return newStatus;
    }

    public void setNewStatus(String newStatus) {
        this.newStatus = newStatus;
    }

    public String getAdminMessage() {
        return adminMessage;
    }

    public void setAdminMessage(String adminMessage) {
        this.adminMessage = adminMessage;
    }

    private String[] deleteFileIds;

    public String[] getDeleteFileIds() {
        return deleteFileIds;
    }

    public void setDeleteFileIds(String[] deleteFileIds) {
        this.deleteFileIds = deleteFileIds;
    }

    public String save() {
        try {
            com.cubesofttech.model.User onlineUser = (com.cubesofttech.model.User) request.getSession()
                    .getAttribute("onlineUser");
            String currentUserId = onlineUser.getId();

            // 1. Create Support Record
            java.sql.Timestamp now = DateUtil.getCurrentTime();
            Support support = new Support();
            support.setUserId(currentUserId);
            support.setIssueDate(new java.sql.Date(System.currentTimeMillis()));
            support.setCategorized(categorized);
            support.setSupportMenuId(supportMenuId);
            support.setStatus("New");
            support.setUserCreate(currentUserId);
            support.setUserUpdate(currentUserId);
            support.setTimeCreate(now);
            support.setTimeUpdate(now);
            supportDAO.save(support);

            Integer generatedSupportId = support.getSupportId();

            // 2. Create Support Detail Record
            com.cubesofttech.model.SupportDetail detail = new com.cubesofttech.model.SupportDetail();
            detail.setSupportId(generatedSupportId.toString());
            detail.setMessage(description); // Initial message same as support description
            detail.setStatus("New");
            detail.setUserCreate(currentUserId);
            detail.setUserUpdate(currentUserId);
            detail.setTimeCreate(now);
            detail.setTimeUpdate(now);
            supportDetailDAO.save(detail);

            Integer generatedDetailId = detail.getSupportDetailId();

            // 3. Handle File Uploads
            if (files != null && files.length > 0) {
                String uploadPath = request.getServletContext().getRealPath("/") + "upload/support/";
                for (int i = 0; i < files.length; i++) {
                    saveFileUpload(files[i], filesFileName[i], uploadPath, generatedDetailId.toString(), currentUserId,
                            now);
                }
            }

            return SUCCESS;
        } catch (Exception e) {
            log.error("Error saving support", e);
            e.printStackTrace();
            return ERROR;
        }
    }

    public String update() {
        try {
            com.cubesofttech.model.User onlineUser = (com.cubesofttech.model.User) request.getSession()
                    .getAttribute("onlineUser");
            String currentUserId = onlineUser.getId();

            if (supportId == null || supportId.isEmpty()) {
                supportId = request.getParameter("supportId");
            }

            if (supportId != null && !supportId.isEmpty()) {
                // Update Support Record
                java.sql.Timestamp now = DateUtil.getCurrentTime();
                Support support = supportDAO.findById(Integer.valueOf(supportId));
                if (support != null) {
                    if ("New".equals(support.getStatus())) {
                        support.setCategorized(categorized);
                        support.setSupportMenuId(supportMenuId);
                    }
                    support.setUserUpdate(currentUserId);
                    support.setTimeUpdate(now);
                    supportDAO.update(support);
                }

                // Update latest Support Detail
                List<com.cubesofttech.model.SupportDetail> details = supportDetailDAO.findBySupportId(supportId);
                if (details != null && !details.isEmpty()) {
                    // Latest detail is the last one (ordered by timeCreate ASC)
                    com.cubesofttech.model.SupportDetail latestDetail = details.get(details.size() - 1);
                    latestDetail.setMessage(description);
                    latestDetail.setUserUpdate(currentUserId);
                    latestDetail.setTimeUpdate(now);
                    supportDetailDAO.update(latestDetail);

                    Integer detailId = latestDetail.getSupportDetailId();

                    // Handle File Uploads (Append to the same detail)
                    if (files != null && files.length > 0) {
                        String uploadPath = request.getServletContext().getRealPath("/") + "upload/support/";
                        for (int i = 0; i < files.length; i++) {
                            saveFileUpload(files[i], filesFileName[i], uploadPath, detailId.toString(), currentUserId,
                                    now);
                        }
                    }

                    // Handle File Deletions
                    if (deleteFileIds != null && deleteFileIds.length > 0) {
                        String uploadPath = request.getServletContext().getRealPath("/") + "upload/support/";
                        for (String fileIdStr : deleteFileIds) {
                            try {
                                com.cubesofttech.model.FileUpload fu = fileUploadDAO
                                        .findById(Integer.valueOf(fileIdStr.trim()));
                                if (fu != null) {
                                    java.io.File physicalFile = new java.io.File(uploadPath, fu.getName());
                                    if (physicalFile.exists())
                                        physicalFile.delete();
                                    fileUploadDAO.delete(fu);
                                }
                            } catch (Exception ex) {
                                log.warn("Failed to delete fileId: " + fileIdStr, ex);
                            }
                        }
                    }
                }
            }
            return SUCCESS;
        } catch (Exception e) {
            log.error("Error updating support", e);
            e.printStackTrace();
            return ERROR;
        }
    }

    public String adminReply() {
        try {
            com.cubesofttech.model.User onlineUser = (com.cubesofttech.model.User) request.getSession()
                    .getAttribute("onlineUser");
            if (onlineUser == null) {
                return ERROR;
            }
            String currentUserId = onlineUser.getId();
            Set<String> userAuthority = (Set<String>) request.getSession().getAttribute("userAuthority");

            if (supportId == null || supportId.trim().isEmpty()) {
                return ERROR;
            }

            Support support = supportDAO.findById(Integer.valueOf(supportId.trim()));
            if (support == null) {
                return ERROR;
            }

            // Permission check: only those with helpsupport.manage can use adminReply
            // EXCEPT for when the owner re-opens or closes their own resolved ticket
            boolean isAdmin = userAuthority != null && userAuthority.contains("helpsupport.manage");
            boolean isOwner = support.getUserCreate() != null
                    && support.getUserCreate().trim().equalsIgnoreCase(currentUserId);

            // Allow if admin, OR if owner is changing a Resolved ticket to In
            // Progress/Closed
            boolean allowed = isAdmin || (isOwner && "Resolved".equals(support.getStatus())
                    && ("In Progress".equals(newStatus) || "Closed".equals(newStatus)));

            if (!allowed) {
                log.warn("Unauthorized status change attempt by user: " + currentUserId + " for supportId: "
                        + supportId);
                return SUCCESS;
            }

            if (newStatus != null && !newStatus.isEmpty()) {
                // 1. Create new SupportDetail with chosen status
                java.sql.Timestamp now = DateUtil.getCurrentTime();
                com.cubesofttech.model.SupportDetail newDetail = new com.cubesofttech.model.SupportDetail();
                newDetail.setSupportId(supportId);
                newDetail.setMessage(adminMessage != null ? adminMessage : "");
                newDetail.setStatus(newStatus);
                newDetail.setUserCreate(currentUserId);
                newDetail.setUserUpdate(currentUserId);
                newDetail.setTimeCreate(now);
                newDetail.setTimeUpdate(now);
                supportDetailDAO.save(newDetail);

                Integer newDetailId = newDetail.getSupportDetailId();

                // 2. Handle File Uploads
                if (files != null && files.length > 0) {
                    String uploadPath = request.getServletContext().getRealPath("/") + "upload/support/";
                    for (int i = 0; i < files.length; i++) {
                        saveFileUpload(files[i], filesFileName[i], uploadPath, newDetailId.toString(), currentUserId,
                                now);
                    }
                }

                // 3. Update Support.status to match the new detail's status
                support.setStatus(newStatus);
                support.setUserUpdate(currentUserId);
                support.setTimeUpdate(now);
                supportDAO.update(support);
            }
            return SUCCESS;
        } catch (Exception e) {
            log.error("Error in adminReply", e);
            e.printStackTrace();
            return ERROR;
        }
    }

    public String list() {
        try {
            // รับค่าเงื่อนไขจากหน้าจอ (ดึงเป็น Array เพื่อรองรับการเลือกหลายค่า)
            String searchText = request.getParameter("searchText");
            String[] status = request.getParameterValues("status");
            String[] categorized = request.getParameterValues("categorized");
            String[] supportMenuId = request.getParameterValues("supportMenuId");
            String year = request.getParameter("year");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");

            // ดึงข้อมูลรายการ Support โดยส่งเงื่อนไขไปที่ DAO
            List<Support> supportList = supportDAO.searchSupport(searchText, status, categorized, supportMenuId, year,
                    startDate, endDate);

            request.setAttribute("supportList", supportList);
            request.setAttribute("searchText", searchText);
            request.setAttribute("year", year);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);

            // ดึงข้อความแรกของแต่ละ Support มาแสดงในตาราง (เนื่องจากไม่ได้เก็บใน
            // support.description แล้ว)
            Map<Integer, String> messageMap = new HashMap<>();
            List<com.cubesofttech.model.SupportDetail> allDetails = supportDetailDAO.findAll();
            if (allDetails != null) {
                for (com.cubesofttech.model.SupportDetail d : allDetails) {
                    if (d.getSupportId() != null) {
                        try {
                            Integer sid = Integer.valueOf(d.getSupportId());
                            if (!messageMap.containsKey(sid)) {
                                messageMap.put(sid, d.getMessage());
                            }
                        } catch (NumberFormatException e) {
                            // Ignore if not a number
                        }
                    }
                }
            }
            request.setAttribute("messageMap", messageMap);

            // คำนวณสถิติและดึงข้อมูลเมนู
            populateCommonData();

            // ส่งค่าเงื่อนไขที่เลือกกลับไปที่หน้าจอ เพื่อให้แสดงผลค้างไว้เหมือนเดิม
            request.setAttribute("selectedStatus",
                    status != null ? java.util.Arrays.asList(status) : new java.util.ArrayList<>());
            request.setAttribute("selectedCategorized",
                    categorized != null ? java.util.Arrays.asList(categorized) : new java.util.ArrayList<>());
            request.setAttribute("selectedSupportMenuId",
                    supportMenuId != null ? java.util.Arrays.asList(supportMenuId) : new java.util.ArrayList<>());

            return SUCCESS;
        } catch (Exception e) {
            log.error(e);
            return ERROR;
        }
    }

    public String edit() {
        try {
            if (supportId == null || supportId.isEmpty()) {
                supportId = request.getParameter("supportId");
            }
            if (supportId != null && !supportId.isEmpty()) {
                Support support = supportDAO.findById(Integer.valueOf(supportId));
                request.setAttribute("support", support);

                // Load details
                List<com.cubesofttech.model.SupportDetail> details = supportDetailDAO.findBySupportId(supportId);
                request.setAttribute("supportDetails", details);

                // Load files for each detail
                Map<Integer, List<com.cubesofttech.model.FileUpload>> detailFilesMap = new HashMap<>();
                if (details != null) {
                    for (com.cubesofttech.model.SupportDetail detail : details) {
                        List<com.cubesofttech.model.FileUpload> files = fileUploadDAO
                                .findByPageAndPageId("support_detail", detail.getSupportDetailId().toString());
                        detailFilesMap.put(detail.getSupportDetailId(), files);
                    }
                }
                request.setAttribute("detailFilesMap", detailFilesMap);
            }
            // Populate necessary data for the page (stats, menus, etc.)
            populateCommonData();
            return SUCCESS;
        } catch (Exception e) {
            log.error(e);
            return ERROR;
        }
    }

    public String delete() {
        try {
            String supportId = request.getParameter("supportId");
            if (supportId != null) {
                Support support = supportDAO.findById(Integer.valueOf(supportId));
                if (support != null) {
                    supportDAO.delete(support);
                }
            }
            return SUCCESS;
        } catch (Exception e) {
            log.error(e);
            return ERROR;
        }
    }

    private void populateCommonData() throws Exception {
        // ดึงสถิติ
        List<Support> allSupportList = supportDAO.findAll();
        int countPending = 0, countInProgress = 0, countResolved = 0, countClosed = 0;
        if (allSupportList != null) {
            for (Support s : allSupportList) {
                if ("Pending".equals(s.getStatus()) || "New".equals(s.getStatus()))
                    countPending++;
                else if ("In Progress".equals(s.getStatus()))
                    countInProgress++;
                else if ("Resolved".equals(s.getStatus()))
                    countResolved++;
                else if ("Closed".equals(s.getStatus()))
                    countClosed++;
            }
        }
        request.setAttribute("countPending", countPending);
        request.setAttribute("countInProgress", countInProgress);
        request.setAttribute("countResolved", countResolved);
        request.setAttribute("countClosed", countClosed);

        // ดึงข้อมูล Menu
        List<SupportMenu> menuList = supportMenuDAO.findAll();
        request.setAttribute("menuList", menuList);
        Map<String, String> menuMap = new HashMap<>();
        if (menuList != null) {
            for (SupportMenu menu : menuList) {
                menuMap.put(menu.getSupportMenuId().toString(), menu.getMenuName());
            }
        }
        request.setAttribute("menuMap", menuMap);

        Map<String, String> categoryMap = new HashMap<>();
        categoryMap.put("1", "Technical Issue");
        categoryMap.put("2", "Inquiry / Question");
        categoryMap.put("3", "Feature Request");
        request.setAttribute("categoryMap", categoryMap);

        // ดึงข้อมูล User จาก Query_Userlist (จะได้ Map<String, Object> ที่มี key ตรงกับ
        // DB)
        List<Map<String, Object>> userList = userDAO.Query_Userlist();
        request.setAttribute("userList", userList);

        Map<String, String> userMap = new HashMap<>();
        if (userList != null) {
            for (Map<String, Object> u : userList) {
                String id = (String) u.get("id");
                String empId = (String) u.get("employee_id");
                String nameEn = (String) u.get("name_en");
                String nameTh = (String) u.get("name");
                String depId = (String) u.get("department_id");

                StringBuilder label = new StringBuilder();
                if (empId != null && !empId.isEmpty()) {
                    label.append(empId).append(" ");
                }

                if (nameEn != null && !nameEn.isEmpty()) {
                    label.append(nameEn);
                } else if (nameTh != null && !nameTh.isEmpty()) {
                    label.append(nameTh);
                }

                if (depId != null && !depId.isEmpty()) {
                    label.append(" - ").append(depId);
                }

                if (id != null) {
                    userMap.put(id.trim(), label.toString().trim());
                }
            }
        }
        request.setAttribute("userMap", userMap);
    }

    /**
     * บันทึกไฟล์อัปโหลด 1 ไฟล์ลงดิสก์และฐานข้อมูล
     * - รูปภาพ (jpg/jpeg/png/gif): ย่อขนาดสูงสุด 1280x1280 px ด้วย quality 80%
     * - ไฟล์อื่น (pdf ฯลฯ): copy ตรงโดยไม่บีบอัด
     */
    private void saveFileUpload(java.io.File file, String originalName,
            String uploadPath, String detailId,
            String userId, java.sql.Timestamp now) throws Exception {

        java.io.File uploadDir = new java.io.File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String extension = "";
        int dotIndex = originalName.lastIndexOf(".");
        if (dotIndex >= 0) {
            extension = originalName.substring(dotIndex).toLowerCase();
        }
        String newFileName = "SD" + detailId + "_" + System.currentTimeMillis() + "_"
                + (int) (Math.random() * 9000 + 1000) + extension;
        java.io.File destFile = new java.io.File(uploadPath, newFileName);

        boolean isImage = extension.equals(".jpg") || extension.equals(".jpeg")
                || extension.equals(".png") || extension.equals(".gif");

        long savedSize;
        if (isImage) {
            log.info("[Support Upload] Resizing image: " + originalName + " (" + file.length() + " bytes)");
            try (java.io.FileInputStream fis = new java.io.FileInputStream(file);
                    java.io.FileOutputStream fos = new java.io.FileOutputStream(destFile)) {
                byte[] resizedBytes = FileUtil.resizeImage(fis, 1280, 1280);
                fos.write(resizedBytes);
                savedSize = resizedBytes.length;
                log.info("[Support Upload] Resized size: " + savedSize + " bytes");
            }
        } else {
            FileUtil.upload(file, uploadPath, newFileName);
            savedSize = destFile.length();
            log.info("[Support Upload] Copied file: " + originalName + " (" + savedSize + " bytes)");
        }

        com.cubesofttech.model.FileUpload fileUpload = new com.cubesofttech.model.FileUpload();
        Integer nextFileId = fileUploadDAO.getMaxId() + 1;
        fileUpload.setFileId(nextFileId);
        fileUpload.setName(newFileName);
        fileUpload.setPath("/upload/support/" + newFileName);
        fileUpload.setType(extension.replace(".", ""));
        fileUpload.setPage("support_detail");
        fileUpload.setPageId(detailId);
        fileUpload.setUserId(userId);
        fileUpload.setUserCreate(userId);
        fileUpload.setTimeCreate(now);
        fileUploadDAO.save(fileUpload);
    }
}
