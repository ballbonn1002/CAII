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

public class FileUploadAction extends ActionSupport {
    private static final Logger log = Logger.getLogger(FileUploadAction.class);
    private static final long serialVersionUID = 1L;

    @Autowired
    private HolidayDAO holidayDAO;

    private File fileUpload;
    private String fileUploadFileName;
    private String fileUploadContentType;

    public void setFileUpload(File fileUpload) { this.fileUpload = fileUpload; }
    public void setFileUploadFileName(String fileUploadFileName) { this.fileUploadFileName = fileUploadFileName; }
    public void setFileUploadContentType(String fileUploadContentType) { this.fileUploadContentType = fileUploadContentType; }

    private HttpServletRequest req() { return ServletActionContext.getRequest(); }

    private static final DataFormatter DF = new DataFormatter();
    private static final String[] DATE_PATTERNS = { "d/M/yy", "d/M/yyyy", "dd-MM-yyyy" };

    @Override
    public String execute() {
        return upload_holiday();
    }

    public String uploadholiday() {
        return upload_holiday();
    }

    public String upload_holiday() {
        long t0 = System.currentTimeMillis();
        try {
            if (fileUpload == null || !fileUpload.exists() || fileUpload.length() == 0) {
                addActionError("No file uploaded.");
                return ERROR;
            }
            if (fileUploadContentType == null ||
               !(fileUploadContentType.contains("excel") || fileUploadContentType.contains("spreadsheet"))) {
                addActionError("Invalid file type. Please upload an Excel file (.xlsx/.xls).");
                return ERROR;
            }


            try (FileInputStream fis = new FileInputStream(fileUpload);
                 Workbook wb = WorkbookFactory.create(fis)) {

                Sheet sheet = wb.getNumberOfSheets() > 0 ? wb.getSheetAt(0) : null;
                if (sheet == null) {
                    addActionError("Excel has no sheet.");
                    return ERROR;
                }

                Map<String, Integer> col = detectColumns(sheet);
                if (!col.containsKey("start") || !col.containsKey("name")) {
                    addActionError("Template missing required columns: Start Date and Name.");
                    return ERROR;
                }

                User u = (User) Optional.ofNullable(req().getSession(false))
                        .map(s -> s.getAttribute("onlineUser")).orElse(null);
                String logonUser = (u != null && u.getId() != null) ? u.getId() : "";

                Set<String> seenInBatch = new HashSet<>();
                java.text.SimpleDateFormat iso = new java.text.SimpleDateFormat("yyyy-MM-dd");
                java.util.function.Function<Object[], String> makeKey = arr -> {
                    Date s = (Date) arr[0];
                    Date e = (Date) arr[1];
                    String h = (String) arr[2];
                    String ss = (s == null) ? "" : iso.format(s);
                    String ee = (e == null) ? "" : iso.format(e);
                    String hh = (h == null) ? "" : h.trim().replaceAll("\\s+", " ").toLowerCase();
                    return ss + "|" + ee + "|" + hh;
                };

                for (int r = sheet.getFirstRowNum() + 1; r <= sheet.getLastRowNum(); r++) {
                    Row row = sheet.getRow(r);
                    if (row == null) continue;

                    Cell cStart = getCell(row, col.get("start"));
                    Cell cEnd   = col.containsKey("end")  ? getCell(row, col.get("end"))  : null;
                    Cell cName  = getCell(row, col.get("name"));
                    Cell cDesc  = col.containsKey("desc") ? getCell(row, col.get("desc")) : null;

                    String name = trimToNull(getString(cName));
                    if (name == null) continue;

                    Date start = parseCellAsSqlDate(cStart);
                    Date end   = parseCellAsSqlDate(cEnd);
                    if (start == null) continue;
                    if (end == null) end = start;

                    if (start.after(end)) {
                        Date tmp = start; start = end; end = tmp;
                    }

                    String desc = Optional.ofNullable(getString(cDesc)).orElse("");

                    String batchKey = makeKey.apply(new Object[]{start, end, name});
                    if (seenInBatch.contains(batchKey)) continue;
                    seenInBatch.add(batchKey);

                    Holiday probe = new Holiday();
                    probe.setStart_date(start);
                    probe.setEnd_date(end);
                    List<Holiday> overlap = holidayDAO.protect(probe);
                    if (overlap != null && !overlap.isEmpty()) continue;

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
                }

                return SUCCESS;
            }
        } catch (Exception e) {
            log.error("upload_holiday failed", e);
            addActionError("Import failed: " + e.getMessage());
            return ERROR;
        } finally {
            req().setAttribute("elapsedMs", System.currentTimeMillis() - t0);
        }
    }


    // ---------------- helpers ----------------
    private Map<String, Integer> detectColumns(Sheet sheet) {
        String[][] aliases = new String[][] {
                {"start","start date","begin","date start","วันที่เริ่ม","startdate"},
                {"end","end date","finish","date end","วันที่สิ้นสุด","enddate"},
                {"name","head","holiday","ชื่อ","หัวข้อ","name/หัวข้อ"},
                {"desc","description","รายละเอียด","notes","remark"}
        };
        Map<String, Integer> map = new HashMap<>();
        Row header = sheet.getRow(sheet.getFirstRowNum());
        if (header != null) {
            int first = Math.max(0, header.getFirstCellNum());
            int last  = header.getLastCellNum();
            for (int i = first; i < last; i++) {
                String head = trimToNull(DF.formatCellValue(header.getCell(i)));
                if (head == null) continue;
                String h = head.toLowerCase(Locale.ROOT);
                for (String[] grp : aliases) {
                    for (String a : grp) {
                        if (h.equals(a)) { map.put(grp[0], i); break; }
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

    private Cell getCell(Row row, Integer idx) {
        return (row == null || idx == null) ? null : row.getCell(idx);
    }

    private String getString(Cell c) {
        return (c == null) ? null : DF.formatCellValue(c);
    }

    private String trimToNull(String s) {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }


    private Date parseCellAsSqlDate(Cell cell) {
        if (cell == null) return null;
        try {
            int t = cell.getCellType(); // POI เก่า: คืนค่า int
            if (t == Cell.CELL_TYPE_FORMULA) {
                t = cell.getCachedFormulaResultType();
            }

            if (t == Cell.CELL_TYPE_NUMERIC) {
                if (org.apache.poi.ss.usermodel.DateUtil.isCellDateFormatted(cell)) {
                    java.util.Date d = cell.getDateCellValue();
                    return new Date(d.getTime());
                } else {
                    java.util.Date d = org.apache.poi.ss.usermodel.DateUtil.getJavaDate(cell.getNumericCellValue());
                    return new Date(d.getTime());
                }
            } else {
                String s = trimToNull(DF.formatCellValue(cell));
                return parseStringDate(s);
            }
        } catch (Exception e) {
            return null;
        }
    }

    private Date parseStringDate(String s) {
        if (s == null) return null;
        Calendar base = Calendar.getInstance();
        base.set(2000, Calendar.JANUARY, 1); 
        for (String p : DATE_PATTERNS) {
            try {
                SimpleDateFormat f = new SimpleDateFormat(p);
                f.setLenient(false);
                if ("d/M/yy".equals(p)) f.set2DigitYearStart(base.getTime());
                java.util.Date d = f.parse(s);
                return new Date(d.getTime());
            } catch (Exception ignore) {}
        }
        return null;
    }
}
