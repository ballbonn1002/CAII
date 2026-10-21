package com.cubesofttech.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cubesofttech.dao.AnnouncementDAO;
import com.cubesofttech.dao.BorrowDAO;
import com.cubesofttech.dao.NotificationDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.Announcement;
import com.cubesofttech.model.Notification;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;

@Service
public class NotificationService {

	private static final Logger log = Logger.getLogger(NotificationService.class);

	private static final String TITLE_LEAVE = "My Leave";
	private static final String TITLE_LEAVE_APPROVE = "Leave Approve";
	private static final String TITLE_TRAVEL = "My Travel";
	private static final String TITLE_TRAVEL_APPROVE = "Travel Approve";
	private static final String TITLE_ANNOUNCEMENT = "Announcement";
	private static final String TITLE_BORROW = "My Borrow";
	private static final String TITLE_BORROW_APPROVE = "Borrow Approve";
	private static final String AUTHORIZED_OBJECT_LEAVE_APPROVE = "leave.approve";
	private static final String AUTHORIZED_OBJECT_TRAVEL_APPROVE = "expense.approve";
	private static final String AUTHORIZED_OBJECT_BORROW_APPROVE = "borrow.approved";

	@Autowired
	private NotificationDAO notificationDAO;

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private AnnouncementDAO announcementDAO;

	@Autowired
	private BorrowDAO borrowDAO;

	@Autowired
	private FileAttachmentService fileAttachmentService;

	@Transactional
    @Scheduled(cron = "0 0 9 * * ?")
    public void checkNotiAnnouncement() {
        try {
        	log.info("Initialized checkNotiAnnouncement...");
        	SimpleDateFormat sdfNoti = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
        	String todayStr = sdfNoti.format(new Date());

        	List<Announcement> announcementList = announcementDAO.findByAnnouncementDateAndStatus(todayStr, "1");
        	if (announcementList == null || announcementList.isEmpty()) {
        		return;
        	}

        	for (Announcement announcement : announcementList) {
        		String startDateNoti = announcement.getannouncement_date() != null ? sdfNoti.format(announcement.getannouncement_date()) : "";

        		JSONObject messageJson = new JSONObject();
        		messageJson.put("announcementId", announcement.getAnnouncementId());
        		messageJson.put("typeName", "Announcement");
        		messageJson.put("status", "");
        		messageJson.put("startDate", startDateNoti);
        		messageJson.put("endDate", "");

        		create(null, TITLE_ANNOUNCEMENT, messageJson.toString(), null, announcement.getUserCreate(), announcement.getAnnouncementId().toString());
        	}
		} catch (Exception e) {
			log.error("Unable to check and notify announcements", e);
		}
    }

	public void create(String userId, String title, String message, String description, String actorId, String funcId) throws Exception {
		switch (title == null ? "" : title) {
			case TITLE_LEAVE_APPROVE:
				List<User> approvers = userDAO.findEnabledUsersByAuthorizedObjectId(AUTHORIZED_OBJECT_LEAVE_APPROVE);
				if (approvers == null || approvers.isEmpty()) {
					log.debug("No enabled user found with authorized_object_id = " + AUTHORIZED_OBJECT_LEAVE_APPROVE);
					break;
				}
				for (User approver : approvers) {
					saveNotification(userId, approver.getId(), title, message, description, actorId, funcId, "A");
				}
				//request from user
				saveNotification(userId, userId, TITLE_LEAVE, message, description, actorId, funcId, "U");
				break;
	
			case TITLE_LEAVE:
				User user = userDAO.findById(userId);
				if (user == null || !"1".equals(user.getEnable())) {
					log.debug("Skip notification, user is null or disabled. userId = " + userId);
					break;
				}
				saveNotification(userId, userId, title, message, description, actorId, funcId, "U");
				break;

			case TITLE_TRAVEL_APPROVE:
				List<User> travelApprovers = userDAO.findEnabledUsersByAuthorizedObjectId(AUTHORIZED_OBJECT_TRAVEL_APPROVE);
				if (travelApprovers == null || travelApprovers.isEmpty()) {
					log.debug("No enabled user found with authorized_object_id = " + AUTHORIZED_OBJECT_TRAVEL_APPROVE);
					break;
				}
				for (User approver : travelApprovers) {
					saveNotification(userId, approver.getId(), title, message, description, actorId, funcId, "A");
				}
				//request from user
				saveNotification(userId, userId, TITLE_TRAVEL, message, description, actorId, funcId, "U");
				break;

			case TITLE_TRAVEL:
				User travelUser = userDAO.findById(userId);
				if (travelUser == null || !"1".equals(travelUser.getEnable())) {
					log.debug("Skip notification, user is null or disabled. userId = " + userId);
					break;
				}
				saveNotification(userId, userId, title, message, description, actorId, funcId, "U");
				break;

			case TITLE_ANNOUNCEMENT:
				List<User> announceUsers = userDAO.findEnabledUsers();
				if (announceUsers == null || announceUsers.isEmpty()) {
					log.debug("No enabled user found for announcement");
					break;
				}
				for (User announceUser : announceUsers) {
					saveNotification(userId, announceUser.getId(), title, message, description, actorId, funcId, "U");
				}
				break;

			case TITLE_BORROW_APPROVE:
				List<User> borrowApprovers = userDAO.findEnabledUsersByAuthorizedObjectId(AUTHORIZED_OBJECT_BORROW_APPROVE);
				if (borrowApprovers == null || borrowApprovers.isEmpty()) {
					log.debug("No enabled user found with authorized_object_id = " + AUTHORIZED_OBJECT_BORROW_APPROVE);
					break;
				}
				for (User approver : borrowApprovers) {
					saveNotification(userId, approver.getId(), "Borrow", message, description, actorId, funcId, "A");
				}
				//request from user
				saveNotification(userId, userId, TITLE_BORROW, message, description, actorId, funcId, "U");
				break;

			case TITLE_BORROW:
				User borrowUser = userDAO.findById(userId);
				if (borrowUser == null || !"1".equals(borrowUser.getEnable())) {
					log.debug("Skip notification, user is null or disabled. userId = " + userId);
					break;
				}
				saveNotification(userId, userId, TITLE_BORROW, message, description, actorId, funcId, "U");
				break;

			default:
				//saveNotification(userId, title, message, description, actorId, funcId);
				break;
		}
	}

	private void saveNotification(String userId, String sendId, String title, String message, String description, String actorId, String funcId, String type) throws Exception {
		Notification notification = new Notification();
		notification.setUserId(userId);
		notification.setSendTo(sendId);
		notification.setTitle(title);
		notification.setFunctionId(funcId);
		notification.setMessage(message);
		notification.setDescription(description);
		notification.setIsRead(false);
		notification.setTypeSending(type);
		notification.setUserCreate(actorId);
		notification.setUserUpdate(actorId);
		Timestamp now = DateUtil.getCurrentTime();
		notification.setTimeCreate(now);
		notification.setTimeUpdate(now);
		notificationDAO.save(notification);
	}

	/**
	 * โหลดข้อมูลลายเซ็น + รายการยืม-คืน (borrow) และสถานะแจ้งเตือน แล้ว set ลง request
	 * ใช้ร่วมกันระหว่าง WorkHoursAction.init() และ UserAction.my_profile()
	 *
	 * request ต้องส่งเข้ามาจาก Action เท่านั้น (Service เป็น singleton ห้ามเก็บ request เป็น field)
	 */
	public void loadNotification(HttpServletRequest request, String logonUser, User ur) {
		try {
			User u = userDAO.findById(logonUser);
			if (u == null) {
				log.warn("loadNotification: user not found. logonUser = " + logonUser);
				return;
			}

			//หาลายเซ็น
			if (u.getPathSignature() != null) {
				String imgPathSignature = fileAttachmentService.getFileUrl(u.getPathSignature());
				String signatureFileName = fileAttachmentService.getFileDisplayName(u.getPathSignature());

				request.setAttribute("imgPathSignature", imgPathSignature);
				request.setAttribute("signatureFileName", signatureFileName);
			}


			//หา borrow
			List<Map<String, Object>> borrow = borrowDAO.getBorrowListByUserId(logonUser);
			boolean hasNotification = false;

			if (borrow != null && !borrow.isEmpty()) {
				// Check Notification
				for (Map<String, Object> row : borrow) {

					String status = row.get("status") != null ? row.get("status").toString() : "";
					Object userDelivery = row.get("user_delivery");
					Object userReceive = row.get("user_receive");
					Object userReturn = row.get("user_return");
					Object userReturnReceive = row.get("user_return_receive");

					boolean isReceiveWaiting = "B".equals(status)
							&& userDelivery != null && userReceive == null
							&& userReturn == null && userReturnReceive == null;

					boolean isReturnWaiting = "T".equals(status)
							&& userDelivery != null && userReceive != null
							&& userReturn == null && userReturnReceive == null;

					if (isReceiveWaiting || isReturnWaiting) {

						hasNotification = true;
						break;
					}
				}

				// Format Date
				SimpleDateFormat inputDate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
				inputDate.setCalendar(new GregorianCalendar());

				SimpleDateFormat outputDate = new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH);
				outputDate.setCalendar(new GregorianCalendar());

				for (Map<String, Object> row : borrow) {
					Object dateStartObj = row.get("time_create");
					if (dateStartObj == null) {
						continue;
					}
					String dt = dateStartObj.toString();
					String[] parts = dt.split(" ");
					if (parts.length < 2) {
						continue;
					}

					String datePart = parts[0];
					String timePart = parts[1].split("\\.")[0];

					Date date = inputDate.parse(datePart);

					row.put("formatted_date", outputDate.format(date));
					row.put("formatted_time", timePart);
				}

				request.setAttribute("borrowList", borrow);
				request.setAttribute("hasNotification", hasNotification);
			} else {
				request.setAttribute("borrowList", borrow);
			}

		} catch (Exception e) {
			log.error("loadNotification error", e);
		}
	}

}
