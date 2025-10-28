package com.cubesofttech.action;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.dao.HolidayDAO;
import com.cubesofttech.dao.TimesheetDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.Holiday;
import com.cubesofttech.model.Timesheet;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;
import com.cubesofttech.util.FileUtil;
import com.ibm.icu.text.SimpleDateFormat;
import com.opensymphony.xwork2.ActionSupport;



public class FileUploadAction extends ActionSupport {

	private static final Logger log = Logger.getLogger(FileUploadAction.class);
    private static final long serialVersionUID = 1L;

	
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private FileUploadDAO fileuploadDAO;

	@Autowired
	private TimesheetDAO timesheetDAO;

	@Autowired
	private HolidayDAO holidayDAO;

	/* private TimeInReportAction timeinreportAction = new TimeInReportAction(); */

	private User user;

	private String userId;

	private File fileUpload;

	private String fileUploadFileName;

	private String userUploadId;

	private String userUploadCreate;

	private String fileUploadSize;

	private int fileId;

	public String getFileUploadSize() {
		return fileUploadSize;
	}

	public void setFileUploadSize(String fileUploadSize) {
		this.fileUploadSize = fileUploadSize;
	}

	public int getFileId() {
		return fileId;
	}

	public void setFileId(int fileId) {
		this.fileId = fileId;
	}

	public String getUserUploadCreate() {
		return userUploadCreate;
	}

	public void setUserUploadCreate(String userUploadCreate) {
		this.userUploadCreate = userUploadCreate;
	}

	public String getUserUploadId() {
		return userUploadId;
	}

	public void setUserUploadId(String userUploadId) {
		this.userUploadId = userUploadId;
	}

	public String getFileUploadFileName() {
		return fileUploadFileName;
	}

	public void setFileUploadFileName(String fileUploadFileName) {
		this.fileUploadFileName = fileUploadFileName;
	}

	public File getFileUpload() {
		return fileUpload;
	}

	public void setFileUpload(File fileUpload) {
		this.fileUpload = fileUpload;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public static final String USERSEQ = "userseq";
	public static final String USERLIST = "userList";
	public static final String FILEUPLOADLIST = "fileuploadList";
	
	

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
    
    private HttpServletRequest req() { return ServletActionContext.getRequest(); }


    private static final String[] DATE_PATTERNS = {
        "d/M/yy", "d/M/yyyy", "dd-MM-yyyy",
        "d MMM yyyy", "d MMMM yyyy",
        "dd MMM yyyy", "dd MMMM yyyy"
    };
    private static final Locale[] DATE_LOCALES = { new Locale("th", "TH"), Locale.UK };
    private static final Pattern NUMERIC_DATE = Pattern.compile("^(\\d{1,2})[\\./\\-](\\d{1,2})[\\./\\-](\\d{2,4})$");
    private static final SimpleDateFormat ISO_DATE = new SimpleDateFormat("yyyy-MM-dd");

    // ====== DI / Fields ============================================================
    

    
    private String fileUploadContentType;

    
    public void setFileUploadContentType(String fileUploadContentType) { this.fileUploadContentType = fileUploadContentType; }

    // ====== Actions ================================================================
    

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
                    java.sql.Date start = (java.sql.Date) parseCellAsSqlDate(cStart);
                    java.sql.Date end   = (java.sql.Date) parseCellAsSqlDate(cEnd);

                    if (start == null) { skipped++; continue; }
                    if (end == null) end = start;
                    if (start.after(end)) { java.sql.Date tmp = start; start = end; end = tmp; }

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

	public String list() {
		try {
			request.setAttribute(USERSEQ, userDAO.sequense());
			request.setAttribute(USERLIST, userDAO.findAll());
			request.setAttribute(FILEUPLOADLIST, fileuploadDAO.findAll());
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String upload() {
		try {
			int maxId = fileuploadDAO.getMaxId() + 1;
			FileUpload fileupload = new FileUpload();

			if (fileUpload != null) {
				ServletContext context = request.getServletContext();
				String fileServerPath = context.getRealPath("/");
				fileupload.setSize(fileUploadSize);
				String fileName = fileUploadFileName;
				fileupload.setPath("/upload/user/" + maxId + "_" + fileName);
				FileUtil.upload(fileUpload, fileServerPath + "upload/user/", maxId + "_" + fileName);
				// log.debug(fileServerPath + "upload/user/" + maxId + "_" + fileName);
			} else {
				return ERROR;
			}
			int l = fileUploadFileName.length();
			int split = fileUploadFileName.lastIndexOf('.');
			String name = fileUploadFileName.substring(0, split);
			String type = (String) fileUploadFileName.subSequence(split, l);

			fileupload.setFileId(maxId);
			fileupload.setUserId(userUploadId);
			fileupload.setUserCreate(userUploadCreate);
			fileupload.setName(name);
			fileupload.setType(type);
			fileupload.setUserUpdate(userUploadCreate);
			fileupload.setTimeCreate(DateUtil.getCurrentTime());
			fileupload.setTimeUpdate(DateUtil.getCurrentTime());
			fileuploadDAO.save(fileupload);

			request.setAttribute(USERSEQ, userDAO.sequense());
			request.setAttribute(USERLIST, userDAO.findAll());
			request.setAttribute(FILEUPLOADLIST, fileuploadDAO.findAll());
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String uploadholiday() {

		try {
			log.debug("Test");
			User onlineuser = (User) request.getSession().getAttribute("onlineUser");
			String logonUser = onlineuser.getId();

			List<Map<String, Object>> cubeUser;
			cubeUser = userDAO.sequense();

			int maxId = fileuploadDAO.getMaxId() + 1;
			Long newId = holidayDAO.getMaxId() ;//holiday
			FileUpload fileupload = new FileUpload();
			SimpleDateFormat sdf2Digit = new SimpleDateFormat("d/M/yy");
			SimpleDateFormat sdf4Digit = new SimpleDateFormat("d/M/yyyy");
			Calendar cal = Calendar.getInstance();
			cal.set(2000, Calendar.JANUARY, 1);
			sdf2Digit.set2DigitYearStart(cal.getTime());

			int l = fileUploadFileName.length();
			int split = fileUploadFileName.lastIndexOf('.');
			String name = fileUploadFileName.substring(0, split);
			String type = (String) fileUploadFileName.subSequence(split, l);

			if (type.equals(".xlsx") || type.equals(".xls")) {
				ServletContext context = request.getServletContext();
				String fileServerPath = context.getRealPath("/");
				fileupload.setSize(fileUploadSize);
				String fileName = fileUploadFileName;

				fileupload.setPath("/upload/user/" + maxId + "_" + fileName);
				FileUtil.upload(fileUpload, fileServerPath + "upload/user/", maxId + "_" + fileName);// upload to server
				//log.debug(fileServerPath + "upload/user/" + maxId + "_" + fileName);

				fileupload.setFileId(maxId);
				fileupload.setUserId(logonUser);
				fileupload.setUserCreate(logonUser);
				fileupload.setName(name);
				fileupload.setType(type);
				fileupload.setUserUpdate(logonUser);
				fileupload.setTimeCreate(DateUtil.getCurrentTime());
				fileupload.setTimeUpdate(DateUtil.getCurrentTime());
				fileuploadDAO.save(fileupload);// upload to database

				String setFileName = maxId + "_" + fileName;
				Workbook workbook = WorkbookFactory.create(new File(fileServerPath + "upload/user/" + setFileName));
				Iterator<Sheet> sheetIterator = workbook.sheetIterator();
				while (sheetIterator.hasNext()) {
					Sheet sheet = sheetIterator.next();
				}
				for (Sheet sheet : workbook) {
				}
				workbook.forEach(sheet -> {
				});

				Sheet sheet = workbook.getSheetAt(0);

				DataFormatter dataFormatter = new DataFormatter();

				Iterator<Row> rowIterator = sheet.rowIterator();
				while (rowIterator.hasNext()) {
					Row row = rowIterator.next();

					Iterator<Cell> cellIterator = row.cellIterator();
					while (cellIterator.hasNext()) {
						Cell cell = cellIterator.next();
						String cellValue = dataFormatter.formatCellValue(cell);
					}
				}

				
				
				int i = 0;
				String a = null;
				String b = null;
				String c = null;
				String d = null;
				for (Row row : sheet) {
					for (Cell cell : row) {
						String cellValue = dataFormatter.formatCellValue(cell);
						// System.out.print(cellValue + "\t");
						if (i == 0) {
							a = a + "!" + cellValue;
						} else if (i == 1) {
							b = b + "!" + cellValue;
						} else if (i == 2) {
							c = c + "!" + cellValue;
						} else if (i == 3) {
							d = d + "!" + cellValue;
						}
						i++;
					}
					// log.debug();
					i = 0;
				}
				
				/*
				 * log.debug(a); log.debug(b); log.debug(c); log.debug(d);
				 */
				
				String[] start = a.split("!");
				String[] end = b.split("!");
				String[] head = c.split("!");
				String[] desc = d.split("!");

				
				for (int x = 2; x < start.length; x++) { // เริ่มที่ 2 เพื่อข้าม null และ header
				    if (start[x] == null || start[x].isEmpty()) {
				        continue; // ข้ามถ้าไม่มีวันเริ่มต้น
				    }
				    Holiday holiday = new Holiday();

				    // แปลงวันเป็น java.sql.Date รองรับทั้ง 2 และ 4 หลัก
				    java.sql.Date startDate = null, endDate = null;
				    try {
				        Date startDateUtil, endDateUtil;
				        if (start[x].matches("\\d{1,2}/\\d{1,2}/\\d{2}$")) {
				            startDateUtil = sdf2Digit.parse(start[x]);
				        } else {
				            startDateUtil = sdf4Digit.parse(start[x]);
				        }
				        if (end[x].matches("\\d{1,2}/\\d{1,2}/\\d{2}$")) {
				            endDateUtil = sdf2Digit.parse(end[x]);
				        } else {
				            endDateUtil = sdf4Digit.parse(end[x]);
				        }
				        startDate = new java.sql.Date(startDateUtil.getTime());
				        endDate = new java.sql.Date(endDateUtil.getTime());
				    } catch (ParseException e) {
				        log.error("Parse date error: " + start[x] + ", " + end[x], e);
				        continue;
				    }
				    newId++;
				    holiday.setId_date(newId); // ถ้าต้องการกำหนด id เอง
				    holiday.setStart_date(startDate);
				    holiday.setEnd_date(endDate);
				    holiday.setHead(head[x]);
				    holiday.setDescription(desc[x]);
				    holiday.setUser_create(logonUser);
				    holiday.setUser_update(logonUser);
				    holiday.setTime_create(DateUtil.getCurrentTime());
				    holiday.setTime_update(DateUtil.getCurrentTime());

				    holidayDAO.save(holiday); // บันทึกลงฐานข้อมูล
					/*
					 * log.debug("Saved holiday: " + holiday.getId_date());
					 * log.debug("Saved holiday: " + holiday.getStart_date());
					 * log.debug("Saved holiday: " + holiday.getEnd_date());
					 * log.debug("Saved holiday: " + holiday.getHead()); log.debug("Saved holiday: "
					 * + holiday.getDescription());
					 */
				    
				}
				

			}return SUCCESS;

		}catch(

	Exception e)
	{
		log.error(e);
		e.printStackTrace();
		return ERROR;

	}

	}

	public String uploadexcel() {
		try {
			User onlineuser = (User) request.getSession().getAttribute("onlineUser");
			String logonUser = onlineuser.getId();

			List<Map<String, Object>> cubeUser;
			cubeUser = userDAO.sequense();

			int maxId = fileuploadDAO.getMaxId() + 1;
			FileUpload fileupload = new FileUpload();

			int l = fileUploadFileName.length();
			int split = fileUploadFileName.lastIndexOf('.');
			String name = fileUploadFileName.substring(0, split);
			String type = (String) fileUploadFileName.subSequence(split, l);

			if (type.equals(".xlsx") || type.equals(".xls")) {
				ServletContext context = request.getServletContext();
				String fileServerPath = context.getRealPath("/");
				fileupload.setSize(fileUploadSize);
				String fileName = fileUploadFileName;

				fileupload.setPath("/upload/user/" + maxId + "_" + fileName);
				FileUtil.upload(fileUpload, fileServerPath + "upload/user/", maxId + "_" + fileName);
				// log.debug(fileServerPath + "upload/user/" + maxId + "_" + fileName);

				fileupload.setFileId(maxId);
				fileupload.setUserId(userUploadId);
				fileupload.setUserCreate(userUploadCreate);
				fileupload.setName(name);
				fileupload.setType(type);
				fileupload.setUserUpdate(userUploadCreate);
				fileupload.setTimeCreate(DateUtil.getCurrentTime());
				fileupload.setTimeUpdate(DateUtil.getCurrentTime());
				fileuploadDAO.save(fileupload);
				String setFileName = maxId + "_" + fileName;
				Workbook workbook = WorkbookFactory.create(new File(fileServerPath + "upload/user/" + setFileName));
				// Retrieving the number of sheets in the Workbook
				/*
				 * ============================================================= Iterating over
				 * all the sheets in the workbook (Multiple ways)
				 * =============================================================
				 */

				// 1. You can obtain a sheetIterator and iterate over it
				Iterator<Sheet> sheetIterator = workbook.sheetIterator();
				while (sheetIterator.hasNext()) {
					Sheet sheet = sheetIterator.next();
				}
				// 2. Or you can use a for-each loop
				for (Sheet sheet : workbook) {
				}
				// 3. Or you can use a Java 8 forEach with lambda
				workbook.forEach(sheet -> {
				});
				/*
				 * ================================================================== Iterating
				 * over all the rows and columns in a Sheet (Multiple ways)
				 * ==================================================================
				 */

				// Getting the Sheet at index zero
				Sheet sheet = workbook.getSheetAt(0);
				// Create a DataFormatter to format and get each cell's value as String
				DataFormatter dataFormatter = new DataFormatter();
				// 1. You can obtain a rowIterator and columnIterator and iterate over them
				Iterator<Row> rowIterator = sheet.rowIterator();
				while (rowIterator.hasNext()) {
					Row row = rowIterator.next();
					// Now let's iterate over the columns of the current row
					Iterator<Cell> cellIterator = row.cellIterator();
					while (cellIterator.hasNext()) {
						Cell cell = cellIterator.next();
						String cellValue = dataFormatter.formatCellValue(cell);
					}
				}

				int i = 0;
				String a = null;
				String b = null;
				String c = null;
				String d = null;
				String e = null;
				String f = null;
				String g = null;
				for (Row row : sheet) {
					for (Cell cell : row) {
						String cellValue = dataFormatter.formatCellValue(cell);
						// System.out.print(cellValue + "\t");
						if (i == 0) {
							a = a + "!" + cellValue;
						} else if (i == 1) {
							b = b + "!" + cellValue;
						} else if (i == 2) {
							c = c + "!" + cellValue;
						} else if (i == 3) {
							d = d + "!" + cellValue;
						} else if (i == 4) {
							e = e + "!" + cellValue;
						} else if (i == 5) {
							f = f + "!" + cellValue;
						} else if (i == 6) {
							g = g + "!" + cellValue;
						}
						i++;
					}
					// log.debug();
					i = 0;
				}
				log.debug(a);
				log.debug(b);
				log.debug(c);
				log.debug(d);
				log.debug(e);
				// log.debug(f);
				log.debug(g);
				log.debug("---------------------------------------------------------------------");
				String[] user = a.split("!");
				String[] date = b.split("!");
				String[] project = c.split("!");
				String[] summary = d.split("!");
				String[] desc = e.split("!");
				// String[] timesec = f.split("!");
				String[] timespent = g.split("!");
				for (i = 0; i < date.length - 1; i++) {
					if (i > 2) {

						if (user[i] != null) {
							List<Map<String, Object>> chkId = timesheetDAO.wherename(user[i]);
							// log.debug(chkId);
							String uploadId = null;
							String searchyear, searchmonth, searchday;

							for (int z = 0; z < chkId.size(); z++) {
								uploadId = ((String) chkId.get(z).get("id"));
								// log.debug(uploadId);
							}

							if (userUploadId.equalsIgnoreCase(uploadId) && uploadId != null) {
								searchyear = date[i].substring(6, 10);
								searchmonth = date[i].substring(3, 5);
								searchday = date[i].substring(0, 2);

								Timesheet timesheet = new Timesheet();
								int tsmaxid = timesheetDAO.getMaxId() + 1;
								timesheet.setId(tsmaxid);
								timesheet.setProject(project[i]);
								timesheet.setSummary(summary[i]);
								timesheet.setDescription(desc[i]);

								Date startdate = new SimpleDateFormat("dd/MM/yyyy").parse(date[i]);
								timesheet.setStarted_date(startdate);

								timesheet.setTimespent(timespent[i]);

								List<Map<String, Object>> whereworkhour = timesheetDAO.whereworkhour(searchyear,
										searchmonth, searchday, uploadId);
								if (!whereworkhour.isEmpty()) {
									for (int wwh = 0; wwh < whereworkhour.size(); wwh++) {
										char work_hours_type = ((char) whereworkhour.get(wwh).get("work_hours_type"));
										if (work_hours_type == '1') {
											Timestamp startDate = ((Timestamp) whereworkhour.get(wwh)
													.get("work_hours_time_work"));
											timesheet.setTimeCheckIn(startDate);
											// log.debug(startDate);
										} else if (work_hours_type == '2') {
											Timestamp endDate = ((Timestamp) whereworkhour.get(wwh)
													.get("work_hours_time_work"));
											timesheet.setTimeCheckOut(endDate);
											// log.debug(endDate);
										}
									}
								} else {
									/*
									 * String sdate = searchyear + "-" + searchmonth + "-" + searchday +
									 * " 00:00:00"; String edate = searchyear + "-" + searchmonth + "-" + searchday
									 * + " 00:00:00";
									 */
									Timestamp startDate = null;
									Timestamp endDate = null;
									timesheet.setTimeCheckIn(startDate);
									timesheet.setTimeCheckOut(endDate);
								}

								timesheet.setStatus("W");
								timesheet.setUserCreate(uploadId);
								timesheet.setUserUpdate(userUploadCreate);
								timesheet.setTimeCreate(DateUtil.getCurrentTime());
								timesheetDAO.save(timesheet);

							} else {
								return ERROR;
							}

						}
					}
				}
				request.setAttribute("cubeUser", cubeUser);
				request.setAttribute("logonUser", logonUser);
				// timeinreportAction.listTimeInReport();
				/*
				 * request.setAttribute(USERSEQ, userDAO.sequense());
				 * request.setAttribute(USERLIST, userDAO.findAll());
				 * request.setAttribute(FILEUPLOADLIST, fileuploadDAO.findAll());
				 */
				return SUCCESS;
			} else {
				return ERROR;
			}

		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			return ERROR;
		}
	}

	public String delete() {
		try {
			FileUpload file = new FileUpload();
			file.setFileId(Integer.valueOf(request.getParameter("fileId")));
			fileuploadDAO.delete(file);
			request.setAttribute(USERSEQ, userDAO.sequense());
			request.setAttribute(USERLIST, userDAO.findAll());
			request.setAttribute(FILEUPLOADLIST, fileuploadDAO.findAll());
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String list2() {
		try {
			request.setAttribute(USERSEQ, userDAO.sequense());
			request.setAttribute(USERLIST, userDAO.findAll());
			request.setAttribute(FILEUPLOADLIST, fileuploadDAO.findByuser(request.getParameter("userId")));
			return SUCCESS;
		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}
}
