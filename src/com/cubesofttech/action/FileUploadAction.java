package com.cubesofttech.action;

import com.cubesofttech.dao.HolidayDAO;
import com.cubesofttech.model.Holiday;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;
import com.opensymphony.xwork2.ActionSupport;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.*;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class FileUploadAction extends ActionSupport {
    private static final Logger log = Logger.getLogger(FileUploadAction.class);
    private static final long serialVersionUID = 1L;

    private static final String RES_TO_LIST = "toList";
    private static final String MSG_NO_FILE = "No file uploaded.";
    private static final String MSG_BAD_TYPE = "Invalid file type. Please upload an Excel file (.xlsx/.xls).";
    private static final String MSG_NO_SHEET = "Excel has no sheet.";
    private static final String MSG_MISSING_COLS = "Template missing required columns: Start Date and Name.";
    private static final String FLASH_STATUS = "flashImportStatus";
    private static final String FLASH_INSERTED = "flashImportInserted";
    private static final String FLASH_SKIPPED = "flashImportSkipped";
    private static final String FLASH_ELAPSED = "flashImportElapsed";

    private static final DataFormatter DF = new DataFormatter(Locale.UK);


    private static final String[] DATE_PATTERNS = {
        "d/M/yy", "d/M/yyyy", "dd-MM-yyyy",
        "d MMM yyyy", "d MMMM yyyy",
        "dd MMM yyyy", "dd MMMM yyyy"
    };
    private static final Locale[] DATE_LOCALES = { new Locale("th", "TH"), Locale.UK };
    private static final Pattern NUMERIC_DATE = Pattern.compile("^(\\d{1,2})[\\./\\-](\\d{1,2})[\\./\\-](\\d{2,4})$");
    private static final SimpleDateFormat ISO_DATE = new SimpleDateFormat("yyyy-MM-dd");

    // ====== DI / Fields ============================================================
    @Autowired
    private HolidayDAO holidayDAO;

    private File fileUpload;
    private String fileUploadFileName;
    private String fileUploadContentType;

    public void setFileUpload(File fileUpload) { this.fileUpload = fileUpload; }
    public void setFileUploadFileName(String fileUploadFileName) { this.fileUploadFileName = fileUploadFileName; }
    public void setFileUploadContentType(String fileUploadContentType) { this.fileUploadContentType = fileUploadContentType; }

    // ====== Actions ================================================================
    @Override
    public String execute() { return upload_holiday(); }
    public String uploadholiday() { return upload_holiday(); }

    public String upload_holiday() {
        final long t0 = System.currentTimeMillis();
        int inserted = 0;
        int skipped = 0;

        try {
            if (!hasValidUpload()) {
                addActionError(MSG_NO_FILE);
                setFlash("error", inserted, skipped, t0);
                return RES_TO_LIST;
            }
            if (!isExcelFile(fileUploadFileName, fileUploadContentType)) {
                addActionError(MSG_BAD_TYPE);
                setFlash("error", inserted, skipped, t0);
                return RES_TO_LIST;
            }

            try (FileInputStream fis = new FileInputStream(fileUpload);
                 Workbook wb = WorkbookFactory.create(fis)) {

                Sheet sheet = (wb.getNumberOfSheets() > 0) ? wb.getSheetAt(0) : null;
                if (sheet == null) {
                    addActionError(MSG_NO_SHEET);
                    setFlash("error", inserted, skipped, t0);
                    return RES_TO_LIST;
                }

                Map<String, Integer> col = detectColumns(sheet);
                if (!col.containsKey("start") || !col.containsKey("name")) {
                    addActionError(MSG_MISSING_COLS);
                    setFlash("error", inserted, skipped, t0);
                    return RES_TO_LIST;
                }

                String logonUser = getLogonUserId();

                Set<String> seenInBatch = new HashSet<>();

                for (int r = sheet.getFirstRowNum() + 1; r <= sheet.getLastRowNum(); r++) {
                    Row row = sheet.getRow(r);
                    if (row == null) continue;

                    Cell cStart = getCell(row, col.get("start"));
                    Cell cEnd   = col.containsKey("end")  ? getCell(row, col.get("end"))  : null;
                    Cell cName  = getCell(row, col.get("name"));
                    Cell cDesc  = col.containsKey("desc") ? getCell(row, col.get("desc")) : null;

                    String name = trimToNull(getShown(cName));
                    if (name == null) { skipped++; continue; }

                    // Dates: parse as D/M/Y from shown text first, fallback to serial
                    Date start = parseCellAsSqlDate(cStart);
                    Date end   = parseCellAsSqlDate(cEnd);

                    if (start == null) { skipped++; continue; }
                    if (end == null) end = start;
                    if (start.after(end)) { Date tmp = start; start = end; end = tmp; }

                    String desc = Optional.ofNullable(getShown(cDesc)).orElse("");

                    String batchKey = makeBatchKey(start, end, name);
                    if (!seenInBatch.add(batchKey)) { skipped++; continue; }

                    Holiday probe = new Holiday();
                    probe.setStart_date(start);
                    probe.setEnd_date(end);
                    List<Holiday> overlap = holidayDAO.protect(probe);
                    if (overlap != null && !overlap.isEmpty()) { skipped++; continue; }

                    // Persist
                    Long newId = holidayDAO.getMaxId() + 1;
                    Holiday h = new Holiday();
                    h.setId_date(newId);
                    h.setStart_date(start);
                    h.setEnd_date(end);
                    h.setHead(name.trim());
                    h.setDescription(desc.trim());
                    h.setUser_create(logonUser);
                    h.setUser_update(logonUser);
                    h.setTime_create(DateUtil.getCurrentTime());
                    h.setTime_update(DateUtil.getCurrentTime());

                    holidayDAO.save(h);
                    inserted++;
                }

                setFlash("success", inserted, skipped, t0);
                return RES_TO_LIST;
            }

        } catch (Exception e) {
            log.error("upload_holiday failed", e);
            addActionError("Import failed: " + e.getMessage());
            setFlash("error", inserted, skipped, t0);
            return RES_TO_LIST;

        } finally {
            req().setAttribute("elapsedMs", System.currentTimeMillis() - t0);
        }
    }

    // ====== Column Detection =======================================================

    private Map<String, Integer> detectColumns(Sheet sheet) {
        String[][] aliases = new String[][] {
            {"start","start date","begin","date start","วันที่เริ่ม","startdate","start_date","begin date"},
            {"end","end date","finish","date end","วันที่สิ้นสุด","enddate","end_date"},
            {"name","head","holiday","ชื่อ","หัวข้อ","name/หัวข้อ","title"},
            {"desc","description","รายละเอียด","notes","remark","note"}
        };
        Map<String, Integer> map = new HashMap<>();
        Row header = sheet.getRow(sheet.getFirstRowNum());
        if (header != null) {
            int first = Math.max(0, header.getFirstCellNum());
            int last  = header.getLastCellNum();
            for (int i = first; i < last; i++) {
                String head = trimToNull(getShown(header.getCell(i)));
                if (head == null) continue;
                String h = head.toLowerCase(Locale.ROOT);
                for (String[] grp : aliases) {
                    for (String a : grp) {
                        if (h.equals(a)) { map.putIfAbsent(grp[0], i); break; }
                    }
                }
            }
        }
        map.putIfAbsent("start", 0);
        map.putIfAbsent("end",   1);
        map.putIfAbsent("name",  2);
        map.putIfAbsent("desc",  3);
        return map;
    }

	// ====== Date Parsing ===========================================================
    private Date parseCellAsSqlDate(Cell cell) {
        if (cell == null) return null;

        try {
            String shown = trimToNull(getShown(cell));
            if (shown != null) {
                Date d = parseStringDate(shown);
                if (d != null) return d;
            }

            // 2) fallback: serial
            int t = cell.getCellType();
            if (t == Cell.CELL_TYPE_FORMULA) t = cell.getCachedFormulaResultType();
            if (t == Cell.CELL_TYPE_NUMERIC) {
                java.util.Date d = org.apache.poi.ss.usermodel.DateUtil.getJavaDate(cell.getNumericCellValue());
                return new Date(d.getTime());
            }
        } catch (Exception ignore) {}

        return null;
    }

    private Date parseStringDate(String s) {
        if (s == null) return null;
        String in = s.trim();

        Matcher m = NUMERIC_DATE.matcher(in);
        if (m.matches()) {
            int d = safeInt(m.group(1));
            int M = safeInt(m.group(2));
            int y = safeInt(m.group(3));
            if (y < 100) y += 2000; // pivot year
            if (!validDMY(d, M, y)) return null;
            Calendar cal = Calendar.getInstance();
            cal.clear();
            cal.set(y, M - 1, d, 0, 0, 0);
            return new Date(cal.getTimeInMillis());
        }

        for (Locale loc : DATE_LOCALES) {
            for (String p : DATE_PATTERNS) {
                try {
                    SimpleDateFormat f = new SimpleDateFormat(p, loc);
                    f.setLenient(false);
                    if ("d/M/yy".equals(p)) {
                        Calendar base = Calendar.getInstance();
                        base.set(2000, Calendar.JANUARY, 1);
                        f.set2DigitYearStart(base.getTime());
                    }
                    java.util.Date d = f.parse(in);
                    return new Date(d.getTime());
                } catch (Exception ignore) {}
            }
        }
        return null;
    }

    // ====== Helpers ==========================================================
    private HttpServletRequest req() { return ServletActionContext.getRequest(); }

    private boolean hasValidUpload() {
        return fileUpload != null && fileUpload.exists() && fileUpload.length() > 0;
    }

    private boolean isExcelFile(String filename, String contentType) {
        String nameLower = (filename == null) ? "" : filename.toLowerCase(Locale.ROOT);
        boolean extOk = nameLower.endsWith(".xlsx") || nameLower.endsWith(".xls");
        boolean ctOk  = (contentType != null) && (contentType.contains("excel") || contentType.contains("spreadsheet"));
        return extOk || ctOk; // ยอมอย่างใดอย่างหนึ่ง เพราะ browser บางตัวส่ง octet-stream
    }

    private String getLogonUserId() {
        Object uObj = Optional.ofNullable(req().getSession(false))
            .map(s -> s.getAttribute("onlineUser")).orElse(null);
        if (uObj instanceof User) {
            User u = (User) uObj;
            if (u.getId() != null) return u.getId();
        }
        return "";
    }

    private void setFlash(String status, int inserted, int skipped, long t0) {
        req().getSession(true).setAttribute(FLASH_STATUS, status);
        req().getSession(true).setAttribute(FLASH_INSERTED, inserted);
        req().getSession(true).setAttribute(FLASH_SKIPPED, skipped);
        req().getSession(true).setAttribute(FLASH_ELAPSED, System.currentTimeMillis() - t0);
    }

    private Cell getCell(Row row, Integer idx) {
        return (row == null || idx == null) ? null : row.getCell(idx);
    }

    private String getShown(Cell c) {
        return (c == null) ? null : DF.formatCellValue(c);
    }

    private String trimToNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }

    private int safeInt(String s) {
        try { return Integer.parseInt(s); } catch (Exception e) { return -1; }
    }

    private boolean validDMY(int d, int m, int y) {
        if (y < 1900 || y > 3000) return false;
        if (m < 1 || m > 12) return false;
        if (d < 1 || d > 31) return false;
        return true;
    }

    private String makeBatchKey(Date start, Date end, String name) {
        String ss = (start == null) ? "" : ISO_DATE.format(start);
        String ee = (end == null)   ? "" : ISO_DATE.format(end);
        String hh = (name == null)  ? "" : name.trim().replaceAll("\\s+", " ").toLowerCase();
        return ss + "|" + ee + "|" + hh;
    }
}
