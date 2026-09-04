package com.cubesofttech.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.util.DateUtil;
import com.cubesofttech.util.FileUtil;

/**
 * บริการแนบไฟล์แบบใช้ซ้ำได้ทุกโมดูล รองรับหลายไฟล์ต่อ 1 record
 *
 * <p>ใช้ตาราง {@code file} ที่มีอยู่เดิมเป็น attachment แบบ polymorphic ผ่านคู่คีย์
 * {@code page} (ชื่อโมดูล เช่น "good_receipt") + {@code page_id} (id ของ record นั้น)
 * ทำให้ 1 record ผูกไฟล์ได้ไม่จำกัดจำนวนโดยไม่ต้องมีคอลัมน์ file_id ในตารางเจ้าของ</p>
 */
@Service
public class FileAttachmentService {

    private static final Logger log = Logger.getLogger(FileAttachmentService.class);

    /** โฟลเดอร์จริงใต้ context root ที่เก็บไฟล์ (สอดคล้องกับของเดิมในระบบ) */
    private static final String UPLOAD_SUBDIR = "/upload/";
    /** path เชิง web ที่บันทึกลง DB */
    private static final String WEB_PATH_PREFIX = "/upload/";

    @Autowired
    private FileUploadDAO fileUploadDAO;

    /**
     * บันทึกไฟล์แนบหลายไฟล์ให้กับ record หนึ่ง (เขียนลงดิสก์ + insert แถวใน table file)
     *
     * @param files           ไฟล์ที่อัปโหลดเข้ามา (จาก Struts fileUpload interceptor)
     * @param fileNames        ชื่อไฟล์เดิมของแต่ละไฟล์ (index ตรงกับ files)
     * @param page            ชื่อโมดูล เช่น "good_receipt"
     * @param pageId          id ของ record เจ้าของไฟล์
     * @param userId          ผู้ทำรายการ (ใช้เป็น user_id / user_create)
     * @param serverRealPath  ค่า context.getRealPath("/") ส่งมาจาก action
     * @return รายการ FileUpload ที่บันทึกสำเร็จ (ว่างได้ถ้าไม่มีไฟล์)
     */
    public List<FileUpload> attach(List<File> files, List<String> fileNames,
            String page, String pageId, String userId, String serverRealPath) throws Exception {

        List<FileUpload> saved = new ArrayList<FileUpload>();

        if (files == null || files.isEmpty()) {
            return saved;
        }
        if (isBlank(page) || isBlank(pageId)) {
            throw new IllegalArgumentException("page และ pageId ต้องไม่ว่าง");
        }

        // ดึง max id ครั้งเดียวแล้ว running เอง กัน N+1 query
        int nextId = safeInt(fileUploadDAO.getMaxId());
        String uploadDir = ensureTrailingSlash(serverRealPath) + UPLOAD_SUBDIR;

        for (int i = 0; i < files.size(); i++) {
            File file = files.get(i);
            if (file == null) {
                continue;
            }
            // ป้องกัน path traversal: ตัดเหลือเฉพาะชื่อไฟล์ ไม่เอา path ที่ client ส่งมา
            String originalName = sanitizeFileName((fileNames != null && i < fileNames.size()) ? fileNames.get(i) : null);
            if (isBlank(originalName)) {
                originalName = "file";
            }

            nextId++;
            String storedName = page + "/" + nextId +extension(originalName); //แก้เป็น path/maxId+typeFileName
            FileUtil.upload(file, uploadDir, storedName);

            FileUpload fu = new FileUpload();
            fu.setFileId(nextId);
            fu.setPage(page);
            fu.setPageId(pageId);
            fu.setPath(WEB_PATH_PREFIX + storedName);
            fu.setName(baseName(originalName));
            fu.setType(extension(originalName));
            fu.setSize(FileUtil.getFileSize(file.length()));
            fu.setUserId(userId);
            fu.setUserCreate(userId);
            fu.setUserUpdate(userId);
            fu.setTimeCreate(DateUtil.getCurrentTime());
            fu.setTimeUpdate(DateUtil.getCurrentTime());
            fileUploadDAO.save(fu);

            saved.add(fu);
            log.debug("attached file id=" + nextId + " to " + page + "#" + pageId);
        }

        return saved;
    }

    /** ไฟล์แนบทั้งหมดของ record หนึ่ง */
    public List<FileUpload> listAttachments(String page, String pageId) throws Exception {
        if (isBlank(page) || isBlank(pageId)) {
            return new ArrayList<FileUpload>();
        }
        List<FileUpload> list = fileUploadDAO.findByPageAndPageId(page, pageId);
        return list != null ? list : new ArrayList<FileUpload>();
    }

    /**
     * ลบไฟล์แนบตาม id ที่เลือก (ใช้ตอน user กดลบบางไฟล์บนหน้า edit)
     * ลบทั้งแถวใน DB และไฟล์จริงบนดิสก์
     */
    public void deleteByIds(List<String> fileIds, String serverRealPath) throws Exception {
        if (fileIds == null || fileIds.isEmpty()) {
            return;
        }
        for (String rawId : fileIds) {
            if (isBlank(rawId)) {
                continue;
            }
            Integer id;
            try {
                id = Integer.valueOf(rawId.trim());
            } catch (NumberFormatException e) {
                log.warn("deleteByIds: bad file id=" + rawId);
                continue;
            }
            FileUpload fu = fileUploadDAO.findById(id);
            if (fu == null) {
                continue;
            }
            deletePhysicalFile(fu, serverRealPath);
            fileUploadDAO.delete(fu);
            log.debug("deleted attachment id=" + id);
        }
    }

    /**
     * ลบไฟล์แนบเดี่ยวตาม id (ใช้ตอนแทนที่รูปปก/cover — ลบตัวเก่าก่อน attach ตัวใหม่)
     * ลบทั้งแถวใน DB และไฟล์จริงบนดิสก์
     */
    public void deleteById(String fileId, String serverRealPath) throws Exception {
        if (isBlank(fileId)) {
            return;
        }
        Integer id;
        try {
            id = Integer.valueOf(fileId.trim());
        } catch (NumberFormatException e) {
            log.warn("deleteById: bad file id=" + fileId);
            return;
        }
        FileUpload fu = fileUploadDAO.findById(id);
        if (fu == null) {
            return;
        }
        deletePhysicalFile(fu, serverRealPath);
        fileUploadDAO.delete(fu);
        log.debug("deleted attachment id=" + id);
    }

    /** ลบไฟล์แนบทั้งหมดของ record (ใช้ตอนลบหัว record) */
    public void deleteAll(String page, String pageId, String serverRealPath) throws Exception {
        List<FileUpload> list = listAttachments(page, pageId);
        for (FileUpload fu : list) {
            deletePhysicalFile(fu, serverRealPath);
        }
        // ลบแถวใน DB ทีเดียวด้วย query ที่มีอยู่แล้ว
        fileUploadDAO.deletepageandpageid(page, pageId);
    }

    // ---------- helpers ----------

    private void deletePhysicalFile(FileUpload fu, String serverRealPath) {
        try {
            if (fu.getPath() == null || isBlank(serverRealPath)) {
                return;
            }
            // path ใน DB เป็น web path (เริ่ม /) แปลงกลับเป็น path จริงบนดิสก์
            String relative = fu.getPath().startsWith("/") ? fu.getPath().substring(1) : fu.getPath();
            File physical = new File(ensureTrailingSlash(serverRealPath) + relative);
            if (physical.exists() && !physical.delete()) {
                log.warn("cannot delete physical file: " + physical.getAbsolutePath());
            }
        } catch (Exception e) {
            // ลบไฟล์จริงพลาดไม่ควรทำให้ทั้ง transaction ล้ม แค่ log ไว้
            log.warn("deletePhysicalFile failed for fileId=" + fu.getFileId(), e);
        }
    }

    /** ตัดเหลือเฉพาะชื่อไฟล์ กัน path traversal (../ หรือ C:\...) */
    private String sanitizeFileName(String name) {
        if (name == null) {
            return null;
        }
        String cleaned = name.trim().replace('\\', '/');
        int slash = cleaned.lastIndexOf('/');
        if (slash >= 0) {
            cleaned = cleaned.substring(slash + 1);
        }
        return cleaned;
    }

    private String baseName(String fileName) {
        int dot = fileName.lastIndexOf('.');
        return (dot > 0) ? fileName.substring(0, dot) : fileName;
    }

    private String extension(String fileName) {
        int dot = fileName.lastIndexOf('.');
        return (dot >= 0) ? fileName.substring(dot).toLowerCase() : "";
    }

    private String ensureTrailingSlash(String path) {
        if (path == null || path.isEmpty()) {
            return "";
        }
        return (path.endsWith("/") || path.endsWith("\\")) ? path : path + "/";
    }

    private int safeInt(Integer value) {
        return (value != null) ? value.intValue() : 0;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    public String getFileUrl(String path) throws Exception {
        if (isBlank(path)) {
            return null;
        }

        return path;
    }

    /** ดึงชื่อไฟล์ต้นฉบับ (name + type) จาก path ที่เก็บไว้ */
    public String getFileDisplayName(String path) {
        if (isBlank(path)) {
            return null;
        }
        try {
            String fileName = new File(path).getName();
            int dot = fileName.lastIndexOf('.');
            String idStr = (dot > 0) ? fileName.substring(0, dot) : fileName;
            FileUpload file = fileUploadDAO.findById(Integer.parseInt(idStr));
            return (file != null) ? file.getName() + file.getType() : null;
        } catch (Exception e) {
            log.debug("getFileDisplayName failed for path=" + path, e);
            return null;
        }
    }


}
