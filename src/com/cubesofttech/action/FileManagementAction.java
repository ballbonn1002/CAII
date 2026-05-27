package com.cubesofttech.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import java.util.Map;
import java.util.HashMap;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;
import com.cubesofttech.util.FileUtil;
import com.opensymphony.xwork2.ActionSupport;

public class FileManagementAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    private static final Logger log = Logger.getLogger(FileManagementAction.class);

    HttpServletRequest request = ServletActionContext.getRequest();
    HttpServletResponse response = ServletActionContext.getResponse();

    @Autowired
    public FileUploadDAO fileuploadDAO;

    @Autowired
    public UserDAO userDAO;

    // Upload file fields (Struts2 file upload naming convention)
    private File fileUpload;
    private String fileUploadFileName;
    private String fileUploadContentType;
    private String compressFile;

    // File delete field
    private String fileId;

    // PAGE_SIZE
    private static final int PAGE_SIZE = 100;

    public File getFileUpload() { return fileUpload; }
    public void setFileUpload(File fileUpload) { this.fileUpload = fileUpload; }
    public String getFileUploadFileName() { return fileUploadFileName; }
    public void setFileUploadFileName(String fileUploadFileName) { this.fileUploadFileName = fileUploadFileName; }
    public String getFileUploadContentType() { return fileUploadContentType; }
    public void setFileUploadContentType(String fileUploadContentType) { this.fileUploadContentType = fileUploadContentType; }
    public String getCompressFile() { return compressFile; }
    public void setCompressFile(String compressFile) { this.compressFile = compressFile; }
    public String getFileId() { return fileId; }
    public void setFileId(String fileId) { this.fileId = fileId; }

    /**
     * List files with date range filter and mode (all/my).
     * Search keyword and pagination are handled by DataTable (client-side).
     */
    public String list() {
        try {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");

            User onlineUser = (User) request.getSession().getAttribute("onlineUser");
            if (onlineUser == null) return LOGIN;

            String startDateStr = request.getParameter("startDate");
            String endDateStr   = request.getParameter("endDate");
            String mode         = request.getParameter("mode");
            String searchUser   = request.getParameter("searchUser");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
            Date startDate, endDate;

            if (startDateStr != null && !startDateStr.isEmpty()
                    && endDateStr != null && !endDateStr.isEmpty()) {
                startDate = sdf.parse(startDateStr);
                Date rawEnd = sdf.parse(endDateStr);
                Calendar cal = Calendar.getInstance();
                cal.setTime(rawEnd);
                cal.set(Calendar.HOUR_OF_DAY, 23);
                cal.set(Calendar.MINUTE, 59);
                cal.set(Calendar.SECOND, 59);
                endDate = cal.getTime();
            } else {
                Calendar cal = Calendar.getInstance();
                // สิ้นสุดของปีนี้ (เพื่อครอบคลุม "This Year")
                cal.set(Calendar.MONTH, Calendar.DECEMBER);
                cal.set(Calendar.DAY_OF_MONTH, 31);
                cal.set(Calendar.HOUR_OF_DAY, 23);
                cal.set(Calendar.MINUTE, 59);
                cal.set(Calendar.SECOND, 59);
                endDate = cal.getTime();
                
                // เริ่มต้นของปีนี้ (1 มกราคม ของปีปัจจุบัน)
                cal.set(Calendar.MONTH, Calendar.JANUARY);
                cal.set(Calendar.DAY_OF_MONTH, 1);
                cal.set(Calendar.HOUR_OF_DAY, 0);
                cal.set(Calendar.MINUTE, 0);
                cal.set(Calendar.SECOND, 0);
                startDate = cal.getTime();
                
                startDateStr = sdf.format(startDate);
                endDateStr = sdf.format(endDate);
            }

            Set<String> userAuthority = (Set<String>) request.getSession().getAttribute("userAuthority");
            if (userAuthority == null || (!userAuthority.contains("file.view") && !userAuthority.contains("file.viewall"))) {
                return ERROR;
            }

            if ("all".equals(mode) && !userAuthority.contains("file.viewall")) {
                mode = "my";
            }

            if (mode == null || mode.isEmpty()) {
                mode = "my";
            }
            
            String filterUserId = null;
            if ("my".equals(mode)) {
                filterUserId = onlineUser.getId();
            } else if (searchUser != null && !searchUser.isEmpty() && !"all_users".equals(searchUser)) {
                filterUserId = searchUser;
            }

            // keyword = null → DataTable handles search client-side
            List<FileUpload> fileList = fileuploadDAO.searchFiles(null, startDate, endDate, filterUserId);
            if (fileList == null) fileList = new ArrayList<>();

            request.setAttribute("fileList",     fileList);
            request.setAttribute("totalCount",   fileList.size());
            request.setAttribute("mode",         mode);
            request.setAttribute("startDateStr", startDateStr != null ? startDateStr : "");
            request.setAttribute("endDateStr",   endDateStr   != null ? endDateStr   : "");
            request.setAttribute("onlineUser",   onlineUser);
            request.setAttribute("searchUser",   searchUser != null ? searchUser : "all_users");
            List<User> userList = userDAO.findAll();
            Map<String, User> userMap = new HashMap<>();
            for (User u : userList) {
                userMap.put(u.getId(), u);
            }
            request.setAttribute("userList",     userList);
            request.setAttribute("userMap",      userMap);

            return SUCCESS;
        } catch (Exception e) {
            log.error("FileManagementAction.list error", e);
            return ERROR;
        }
    }

    /**
     * Upload a single file and redirect back to the list.
     */
    public String upload() {
        try {
            User onlineUser = (User) request.getSession().getAttribute("onlineUser");
            if (onlineUser == null) return LOGIN;

            Set<String> userAuthority = (Set<String>) request.getSession().getAttribute("userAuthority");
            if (userAuthority == null || (!userAuthority.contains("file.view") && !userAuthority.contains("file.viewall"))) {
                return ERROR;
            }

            if (fileUpload == null || fileUploadFileName == null || fileUploadFileName.isEmpty()) {
                addActionError("No file selected.");
                return ERROR;
            }

            boolean isCompress = "1".equals(compressFile);

            int maxId = fileuploadDAO.getMaxId() + 1;

            String fileName = fileUploadFileName;
            int dotIdx = fileName.lastIndexOf('.');
            String name = (dotIdx > 0) ? fileName.substring(0, dotIdx) : fileName;
            String type = (dotIdx > 0) ? fileName.substring(dotIdx)    : "";

            ServletContext context = request.getServletContext();
            String realPath   = context.getRealPath("/");
            String uploadDir  = "upload/file_management/";
            
            // Ensure directory exists
            File uploadDirFile = new File(realPath + uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }

            String storedName;
            String ext = type.toLowerCase();
            boolean isImage = ext.equals(".jpg") || ext.equals(".jpeg") || ext.equals(".png") || ext.equals(".gif");

            if (isCompress && isImage) {
                // Image resizing & compression (80% quality)
                storedName = maxId + "_" + fileName;
                String format = ext.substring(1); // e.g. "jpg", "png"
                if ("jpeg".equals(format)) {
                    format = "jpg";
                }
                try (FileInputStream fis = new FileInputStream(fileUpload);
                     FileOutputStream fos = new FileOutputStream(new File(realPath + uploadDir, storedName))) {
                    byte[] resizedBytes = FileUtil.resizeImage(fis, 800, 800, format);
                    fos.write(resizedBytes);
                }
            } else {
                storedName = maxId + "_" + fileName;
                FileUtil.upload(fileUpload, realPath + uploadDir, storedName);
            }

            FileUpload fileRecord = new FileUpload();
            fileRecord.setFileId(maxId);
            fileRecord.setPage("file_management");
            fileRecord.setPageId(String.valueOf(maxId));
            fileRecord.setUserId(onlineUser.getId());
            fileRecord.setName(name);
            fileRecord.setType(type);
            
            // Get actual file size (compressed or original) and format it using FileUtil.getFileSize()
            File savedFile = new File(realPath + uploadDir, storedName);
            fileRecord.setSize(FileUtil.getFileSize(savedFile.length()));
            
            fileRecord.setPath("/" + uploadDir + storedName);
            fileRecord.setAltName(fileName);
            fileRecord.setUserCreate(onlineUser.getId());
            fileRecord.setUserUpdate(onlineUser.getId());
            fileRecord.setTimeCreate(DateUtil.getCurrentTime());
            fileRecord.setTimeUpdate(DateUtil.getCurrentTime());

            fileuploadDAO.save(fileRecord);

            return SUCCESS;
        } catch (Exception e) {
            log.error("FileManagementAction.upload error", e);
            return ERROR;
        }
    }

    /**
     * Delete a file record (by fileId parameter).
     */
    public String delete() {
        try {
            User onlineUser = (User) request.getSession().getAttribute("onlineUser");
            if (onlineUser == null) return LOGIN;

            Set<String> userAuthority = (Set<String>) request.getSession().getAttribute("userAuthority");
            if (userAuthority == null || (!userAuthority.contains("file.view") && !userAuthority.contains("file.viewall"))) {
                return ERROR;
            }

            if (fileId != null && !fileId.isEmpty()) {
                int id = Integer.parseInt(fileId);
                FileUpload target = fileuploadDAO.findById(id);
                if (target != null) {
                    // Check if the user is the owner or an Admin (Role 1)
                    if (onlineUser.getId().equals(target.getUserId()) || "1".equals(onlineUser.getRoleId())) {
                        
                        // Physical file deletion
                        String realPath = request.getServletContext().getRealPath("");
                        String filePath = target.getPath();
                        if (filePath != null && filePath.startsWith("/")) {
                            filePath = filePath.substring(1);
                        }
                        File physicalFile = new File(realPath, filePath);
                        if (physicalFile.exists()) {
                            physicalFile.delete();
                        }
                        
                        fileuploadDAO.delete(target);
                    }
                }
            }
            return SUCCESS;
        } catch (Exception e) {
            log.error("FileManagementAction.delete error", e);
            return ERROR;
        }
    }
}
