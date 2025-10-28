package com.cubesofttech.action;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.multipart.MultiPartRequestWrapper;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.AnnouncementDAO;
import com.cubesofttech.dao.FileUploadDAO;
import com.cubesofttech.model.Announcement;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;
import com.cubesofttech.util.FileUtil;
import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;

public class AnnouncementAction extends ActionSupport {
	private static final long serialVersionUID = 1L;

	private static final Logger log = Logger.getLogger(AnnouncementAction.class);
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	String dateFromRequest = request.getParameter("announcement_date");

	HttpSession session = request.getSession();

	@Autowired
	public AnnouncementDAO announcementDAO;

	@Autowired
	public FileUploadDAO fileuploadDAO;

	private String topic;
	private String anndate;
	private String status;
	private String detail;
	private String announcementId;

	private String file_id;
	private File[] files;
	private String filesUploadFileName;
	private String fileUploadId;
	private List<FileUpload> fileUploadlist;

	private File fileUpload;
	private String fileUploadFileName;
	private String fileUploadSize;
	private FileUpload file;
	private FileUpload filenoteimg;

	public String getAnnouncementId() {
		return announcementId;
	}

	public void setAnnouncementId(String announcementId) {
		this.announcementId = announcementId;
	}

	public String getTopic() {
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public String getAnndate() {
		return anndate;
	}

	public void setAnndate(String anndate) {
		this.anndate = anndate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getFile_id() {
		return file_id;
	}

	public void setFile_id(String file_id) {
		this.file_id = file_id;
	}

	public File[] getFiles() {
		return files;
	}

	public void setFiles(File[] files) {
		this.files = files;
	}

	public String getFilesUploadFileName() {
		return filesUploadFileName;
	}

	public void setFilesUploadFileName(String filesUploadFileName) {
		this.filesUploadFileName = filesUploadFileName;
	}

	public String getFileUploadId() {
		return fileUploadId;
	}

	public void setFileUploadId(String fileUploadId) {
		this.fileUploadId = fileUploadId;
	}

	public List<FileUpload> getFileUploadlist() {
		return fileUploadlist;
	}

	public void setFileUploadlist(List<FileUpload> fileUploadlist) {
		this.fileUploadlist = fileUploadlist;
	}

	public File getFileUpload() {
		return fileUpload;
	}

	public void setFileUpload(File fileUpload) {
		this.fileUpload = fileUpload;
	}

	public String getFileUploadFileName() {
		return fileUploadFileName;
	}

	public void setFileUploadFileName(String fileUploadFileName) {
		this.fileUploadFileName = fileUploadFileName;
	}

	public String getFileUploadSize() {
		return fileUploadSize;
	}

	public void setFileUploadSize(String fileUploadSize) {
		this.fileUploadSize = fileUploadSize;
	}

	public FileUpload getFile() {
		return file;
	}

	public void setFile(FileUpload file) {
		this.file = file;
	}

	public FileUpload getFilenoteimg() {
		return filenoteimg;
	}

	public void setFilenoteimg(FileUpload filenoteimg) {
		this.filenoteimg = filenoteimg;
	}

	public String AnnouncementList() {
		try {
			List<Announcement> announcementList = announcementDAO.findAll();
			request.setAttribute("announcementList", announcementList);
			int islastest = announcementDAO.getMaxId();
			// request.setAttribute("announcementList", new
			// Gson().toJson(announcementList));
			request.setAttribute("islastest", islastest);
			return SUCCESS;
		} catch (Exception e) {
			log.error("Error fetching announcement list", e);
			e.printStackTrace();
			return ERROR;
		}
	}

	public String readcardannounce() {
		try {
			String id = request.getParameter("id");
			Integer announceId = Integer.parseInt(id);
			Announcement announce = announcementDAO.findById(announceId);
			if (announce != null) {
				Integer currentCount = announce.getReadcount() != null ? announce.getReadcount() : 0;
				announce.setReadcount(currentCount + 1);
				announcementDAO.update(announce);
			}
			List<Map<String, Object>> announcement = announcementDAO.readcardannounce(Integer.parseInt(id));
			request.setAttribute("announcement", announcement);

			fileUploadlist = announcementDAO.findByPageAndPageId("announcementFiles", String.valueOf(id));
			request.setAttribute("announcementFiles", fileUploadlist);

			return SUCCESS;
		} catch (Exception e) {
			log.error("Error fetching announcement Page Read", e);
			return ERROR;
		}
	}

	public String save() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (status == null || status.isEmpty()) {
				status = "0";
			}

			DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("dd MMM yyyy", Locale.ENGLISH);
			LocalDate localDate = LocalDate.parse(anndate, inputFormatter);
			Date date = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());

			Announcement announcement;
			boolean isEdit = announcementId != null && !announcementId.isEmpty();

			// Check Add or Edit
			if (isEdit) {
				announcement = announcementDAO.findById(Integer.parseInt(announcementId));
				announcement.setUserUpdate(onlineUser.getId());
				announcement.setTimeUpdate(DateUtil.getCurrentTime());
			} else {
				announcement = new Announcement();
				announcement.setAnnouncementId(announcementDAO.getMaxId() + 1);
				announcement.setUserCreate(onlineUser.getId());
				announcement.setTimeCreate(DateUtil.getCurrentTime());
			}

			announcement.setTopic(topic);
			announcement.setDetail(detail);
			announcement.setStatus(status);
			announcement.setannouncement_date(date);

			// Then save or update
			if (isEdit) {
				announcementDAO.update(announcement);
			} else {
				announcementDAO.save(announcement);
			}

			String announcementIdStr = String.valueOf(announcement.getAnnouncementId());

			// Cover Photo Upload
			if (fileUpload != null) {
				// If edit delete old file
				if (isEdit && announcement.getFile_id() != null) {
					FileUpload oldFile = fileuploadDAO.findById(Integer.parseInt(announcement.getFile_id()));
					if (oldFile != null)
						fileuploadDAO.delete(oldFile);
				}

				int maxId = fileuploadDAO.getMaxId() + 1;
				ServletContext context = request.getServletContext();
				String fileServerPath = context.getRealPath("/");
				String fileName = fileUploadFileName;
				FileUtil.upload(fileUpload, fileServerPath + "upload/user/", maxId + "_" + fileName);

				int split = fileName.lastIndexOf('.');
				String name = fileName.substring(0, split);
				String type = fileName.substring(split).toLowerCase();

				FileUpload fileupload = new FileUpload();
				fileupload.setFileId(maxId);
				fileupload.setPath("/upload/user/" + maxId + "_" + fileName);
				fileupload.setSize(fileUploadSize);
				fileupload.setName(name);
				fileupload.setType(type);
				fileupload.setUserId(onlineUser.getId());
				fileupload.setUserCreate(onlineUser.getId());
				fileupload.setPageId(announcementIdStr);
				fileupload.setPage("announcement");
				fileupload.setTimeCreate(DateUtil.getCurrentTime());
				fileuploadDAO.save(fileupload);

				announcement.setFile_id(String.valueOf(fileupload.getFileId()));
				announcementDAO.update(announcement);

			} else if (!isEdit) {
				int maxId = fileuploadDAO.getMaxId() + 1;
				FileUpload fileupload = new FileUpload();
				fileupload.setFileId(maxId);
				fileupload.setPath("/assets/media/svg/avatars/blank.svg");
				fileupload.setName("default_image");
				fileupload.setType("png");
				fileupload.setUserId(onlineUser.getId());
				fileupload.setUserCreate(onlineUser.getId());
				fileupload.setPageId(announcementIdStr);
				fileupload.setPage("announcement");
				fileupload.setTimeCreate(DateUtil.getCurrentTime());
				fileuploadDAO.save(fileupload);

				announcement.setFile_id(String.valueOf(fileupload.getFileId()));
				announcementDAO.update(announcement);
			}

			// ✅ Multiple Attachments (add/update)
			String[] fileIdss = new Gson().fromJson(fileUploadId, String[].class);
			log.debug("files to delete: " + Arrays.toString(fileIdss));

			if (fileIdss != null && fileIdss.length > 0) {
				for (String fileId : fileIdss) {
					FileUpload file = fileuploadDAO.findById(Integer.parseInt(fileId));
					if (file != null) {
						fileuploadDAO.delete(file);
						log.debug("✅ Deleted file ID: " + fileId);
					}
				}
			} else {
				log.debug("No file to delete");
			}

			if (files != null && files.length > 0 && filesUploadFileName != null && !filesUploadFileName.isEmpty()) {
				String[] fileNames = new Gson().fromJson(filesUploadFileName, String[].class);
				for (int i = 0; i < files.length; i++) {
					if (i >= fileNames.length) {
						log.warn("Mismatch between uploaded files and filenames. Skipping index: " + i);
						continue;
					}

					int maxId1 = fileuploadDAO.getMaxId() + 1;
					String fileName1 = fileNames[i];
					ServletContext context1 = request.getServletContext();
					String fileServerPath1 = context1.getRealPath("/");
					long fileSize = files[i].length();

					FileUpload fileupload1 = new FileUpload();
					fileupload1.setSize(formatFileSize(fileSize));
					fileupload1.setPath("/upload/user/" + maxId1 + "_" + fileName1);
					FileUtil.upload(files[i], fileServerPath1 + "upload/user/", maxId1 + "_" + fileName1);

					int split1 = fileName1.lastIndexOf('.');
					String name1 = fileName1.substring(0, split1);
					String type1 = fileName1.substring(split1);

					fileupload1.setName(name1);
					fileupload1.setType(type1);
					fileupload1.setFileId(maxId1);
					fileupload1.setUserId(onlineUser.getId());
					fileupload1.setUserCreate(onlineUser.getId());
					fileupload1.setPage("announcementFiles");
					fileupload1.setPageId(announcementIdStr);
					fileupload1.setUserUpdate(onlineUser.getId());
					fileupload1.setTimeCreate(DateUtil.getCurrentTime());
					fileuploadDAO.save(fileupload1);

					log.debug("✅ Added file ID: " + fileupload1.getFileId());
				}
			} else {
				log.debug("No new file to upload");
			}

			return SUCCESS;

		} catch (Exception e) {
			log.error("Error saving announcement", e);
			e.printStackTrace();
			return ERROR;
		}
	}

	private String formatFileSize(long size) {
		String[] units = { "Bytes", "KB", "MB", "GB", "TB" };
		int unitIndex = 0;
		double formattedSize = size;

		while (formattedSize > 900 && unitIndex < units.length - 1) {
			formattedSize /= 1024;
			unitIndex++;
		}

		return String.format("%.2f %s", formattedSize, units[unitIndex]);
	}

	public String edit() {
		try {
			String id = request.getParameter("id");
			Announcement announcement = announcementDAO.findById(Integer.parseInt(id));
			Integer file_id = Integer.parseInt(announcement.getFile_id());
			FileUpload fileimg = fileuploadDAO.findById(file_id);
			log.debug(fileimg);

			log.debug("Success" + announcement);
			log.debug("Success Json" + new Gson().toJson(announcement));

			fileUploadlist = announcementDAO.findByPageAndPageId("announcementFiles", String.valueOf(id));
			log.debug("file : " + fileUploadlist);
			request.setAttribute("announcementfile", new Gson().toJson(fileUploadlist));
			request.setAttribute("announcementFiles", fileUploadlist);

			request.setAttribute("announcement", announcement);
			request.setAttribute("fileimg", fileimg);
			return SUCCESS;

		} catch (Exception e) {
			log.error(e);
			return ERROR;
		}
	}

	public String delete() {
		try {
			String announcement = request.getParameter("id");
			int announcementId = Integer.parseInt(announcement);
			Announcement announcementdl = announcementDAO.findById(announcementId);
			fileUploadlist = fileuploadDAO.findByPageAndPageId("announcement", announcement);
			log.debug(fileUploadlist);
			List<FileUpload> fileUploadlist1 = fileuploadDAO.findByPageAndPageId("announcementFiles", announcement);

			if (fileUploadlist != null) {
				for (int i = 0; i < fileUploadlist.size(); i++) {
					fileuploadDAO.delete(fileUploadlist.get(i));
					log.debug(fileUploadlist.get(i));
					log.debug("delete fileupload success");
				}
			}
			if (fileUploadlist1 != null) {
				for (int i = 0; i < fileUploadlist1.size(); i++) {
					fileuploadDAO.delete(fileUploadlist1.get(i));
					log.debug(fileUploadlist1.get(i));
					log.debug("delete fileupload success");
				}
			}

			announcementDAO.delete(announcementdl);

			return SUCCESS;
		} catch (Exception e) {
			log.error("Error deleting announcement", e);
			return ERROR;
		}
	}

	public String uploadImageFromCkeditor() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("application/json;charset=UTF-8");

		try {
			MultiPartRequestWrapper multiWrapper = (MultiPartRequestWrapper) request;
			File[] files = multiWrapper.getFiles("upload");
			String[] fileNames = multiWrapper.getFileNames("upload");

			if (files != null && files.length > 0) {
				File file = files[0];
				String fileName = fileNames[0];

				String uploadPath = ServletActionContext.getServletContext().getRealPath("/upload/user/");
				File dir = new File(uploadPath);
				if (!dir.exists())
					dir.mkdirs();

				String newFileName = System.currentTimeMillis() + "_" + fileName;
				File destFile = new File(dir, newFileName);
				FileUtils.copyFile(file, destFile);

				String fileUrl = request.getContextPath() + "/upload/user/" + newFileName;

				response.setContentType("application/json;charset=UTF-8");
				response.getWriter().write("{\"uploaded\": true, \"url\": \"" + fileUrl + "\"}");
				return null;
			} else {
				response.getWriter().write("{\"error\":\"No file uploaded\"}");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			try {
				response.getWriter().write("{\"error\":\"Upload failed\"}");
			} catch (IOException ignored) {
			}
			return null;
		}
	}
}
