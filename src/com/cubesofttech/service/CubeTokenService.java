package com.cubesofttech.service;

import java.io.File;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;

import com.cubesofttech.dao.ActionPointDAO;
import com.cubesofttech.dao.ActionTypeDAO;
import com.cubesofttech.dao.DocStatusDAO;
import com.cubesofttech.dao.HolidayDAO;
import com.cubesofttech.dao.ItemPrivilegeDAO;
import com.cubesofttech.dao.JobsiteDAO;
import com.cubesofttech.dao.LeaveDAO;
import com.cubesofttech.dao.LeaveTypeDAO;
import com.cubesofttech.dao.TokenMonthlyLogDAO;
import com.cubesofttech.dao.TokenMonthlyLogDetailDAO;
import com.cubesofttech.dao.TokenSettingDAO;
import com.cubesofttech.dao.TokenUsageDAO;
import com.cubesofttech.dao.TokenUsageSummaryDAO;
import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.dao.UserFavoriteDAO;
import com.cubesofttech.dao.UserRedeemDAO;
import com.cubesofttech.dao.WorkHoursDAO;
import com.cubesofttech.model.ActionPoint;
import com.cubesofttech.model.ActionType;
import com.cubesofttech.model.DocStatus;
import com.cubesofttech.model.FileUpload;
import com.cubesofttech.model.ItemPrivilege;
import com.cubesofttech.model.LeaveType;
import com.cubesofttech.model.Leaves;
import com.cubesofttech.model.TokenMonthlyLog;
import com.cubesofttech.model.TokenMonthlyLogDetail;
import com.cubesofttech.model.TokenSetting;
import com.cubesofttech.model.TokenUsage;
import com.cubesofttech.model.TokenUsageSummary;
import com.cubesofttech.model.User;
import com.cubesofttech.model.UserFavorite;
import com.cubesofttech.model.UserRedeem;
import com.cubesofttech.util.DateUtil;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

@Service
public class CubeTokenService {

	private static final Logger log = Logger.getLogger(CubeTokenService.class);

	@Autowired
	private ActionTypeDAO actionTypeDAO;

	@Autowired
	private ActionPointDAO actionPointDAO;

	@Autowired
	private TokenSettingDAO tokenSettingDAO;

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private TokenUsageDAO usageTokenDAO;

	@Autowired
	private TokenUsageSummaryDAO tokenUsageSummaryDAO;

	@Autowired
	private TokenMonthlyLogDAO tokenMonthlyLogDAO;

	@Autowired
	private TokenMonthlyLogDetailDAO tokenMonthlyLogDetailDAO;

	@Autowired
	private JobsiteDAO jobsiteDAO;

	@Autowired
	private WorkHoursDAO workHoursDAO;

	@Autowired
	private DocStatusDAO docStatusDAO;

	@Autowired
	private LeaveDAO leaveDAO;

	@Autowired
	private HolidayDAO holidayDAO;

	@Autowired
	private LeaveTypeDAO leaveTypeDAO;

	@Autowired
	private ItemPrivilegeDAO itemPrivilegeDAO;

	@Autowired
	private UserFavoriteDAO userFavoriteDAO;

	@Autowired
	private UserRedeemDAO userRedeemDAO;

	@Autowired
	private FileAttachmentService fileAttachmentService;

	@Autowired
	private PlatformTransactionManager transactionManager;

	private TransactionTemplate transactionTemplate;

	private static final Integer ACTION_TYPE_GIFT = 1;
	private static final Integer ACTION_TYPE_DUDUCT = 2;
	private static final Integer ACTION_TYPE_RETURN = 3;
	private static final Integer ACTION_TYPE_REWARD = 4;
	private static final Integer ACTION_TYPE_ADD_RECONCILE = 5;
	private static final Integer ACTION_TYPE_EXCHANGE = 6;
	private static final Integer ACTION_TYPE_REDEEM = 7;
	private static final Integer ACTION_TYPE_VOID = 8;
	private static final Integer ACTION_TYPE_CARRY_OVER = 9;
	private static final Integer ACTION_TYPE_SPEND_CARRYOVER = 10;
	private static final Integer ACTION_TYPE_SPEND_CURRENT_YEAR = 11;

	private static final Integer ACTION_POINT_LATE = 4;
	private static final Integer ACTION_POINT_EARLY_OUT = 5;
	private static final Integer ACTION_POINT_LEAVE = 6;
	private static final Integer ACTION_POINT_BACKDATE = 7;
	private static final Integer ACTION_POINT_NO_RECORD = 8;

	private static final String STATUS_REDEEM_PENDING = "1";
	private static final String STATUS_REDEEM_APPROVED = "2";
	private static final String STATUS_REDEEM_RECEIVED = "3";
	private static final String STATUS_REDEEM_COMPLETE = "4";
	private static final String STATUS_REDEEM_CANCEL = "5";

	private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("dd MMM, HH:mm", Locale.ENGLISH);
	private static final ObjectMapper MAPPER = new ObjectMapper();

	@PostConstruct
	public void init() {
		transactionTemplate = new TransactionTemplate(transactionManager);
		transactionTemplate.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
	}

//	@Scheduled(cron = "0 0 2 * * ?", zone = "Asia/Bangkok")
//	@Scheduled(fixedRate = 10000)
	public void distributeMonthlyToken() {

		log.info("Start distributeMonthlyToken");

		LocalDate today = LocalDate.now();
		int todayDay = today.getDayOfMonth();
		int lastDay = today.lengthOfMonth();

		try {

			DistributionData data = transactionTemplate.execute(status -> {

				try {

					List<TokenSetting> settings = tokenSettingDAO.findAll();

					if (settings == null || settings.isEmpty()) {
						return null;
					}

					// =================================================
					// Activate date
					// =================================================

					TokenSetting activateDateSetting = settings.stream()
							.filter(s -> "activate_date".equalsIgnoreCase(s.getType())
									&& "day".equalsIgnoreCase(s.getTypeName()))
							.findFirst().orElse(null);

					if (activateDateSetting == null || activateDateSetting.getStatus() == null) {

						log.warn("Activate date setting not found.");
						return null;
					}

					int activateDate;

					try {
						activateDate = Integer.parseInt(activateDateSetting.getStatus());
					} catch (NumberFormatException e) {

						log.error("Invalid activate date setting", e);
						return null;
					}

					int executeDay = Math.min(activateDate, lastDay);

					if (executeDay != todayDay) {

						log.info("Today is not token distribution day. Skipping.");

						return null;
					}

					// =================================================
					// Gift action type
					// =================================================

					ActionType giftType = actionTypeDAO.findById(1);

					if (giftType == null || !"Y".equalsIgnoreCase(giftType.getActiveStatus())) {

						log.info("Gift action type is not active. Skipping.");

						return null;
					}

					// =================================================
					// User settings
					// =================================================

					boolean allowActive = isSettingActive(settings, "user_status", "Active");

					boolean allowProbation = isSettingActive(settings, "user_status", "Probation");

					boolean allowExcluded = isSettingActive(settings, "user_status", "Excluded");

					boolean allowIntern = isSettingActive(settings, "user_status", "Intern");

					boolean allowEnable = isSettingActive(settings, "system_status", "Enable");

					boolean allowDisable = isSettingActive(settings, "system_status", "Disable");

					// =================================================
					// Gift points
					// =================================================

					List<ActionPoint> giftPoints = actionPointDAO.findByActionTypeIdAndActiveStatus(1, "Y");

					if (giftPoints == null || giftPoints.isEmpty()) {

						log.info("No active gift points found. Skipping.");

						return null;
					}

					/*
					 * ================================================= Create monthly log
					 * =================================================
					 */

					TokenMonthlyLog monthlyLog = new TokenMonthlyLog();

					monthlyLog.setFailCase(0);
					monthlyLog.setSuccessCase(0);

					monthlyLog.setDateTime(DateUtil.getCurrentTime());

					monthlyLog.setDescription(
							"Monthly token distribution for " + today.getMonth() + " " + today.getYear());

					monthlyLog.setUserCreate("system");
					monthlyLog.setTimeCreate(DateUtil.getCurrentTime());

					tokenMonthlyLogDAO.save(monthlyLog);

					return new DistributionData(settings, giftPoints, allowActive, allowProbation, allowExcluded,
							allowIntern, allowEnable, allowDisable, monthlyLog.getMonitorLogId());

				} catch (Exception e) {

					status.setRollbackOnly();

					log.error("Failed to prepare monthly token distribution", e);

					throw new RuntimeException(e);
				}
			});

			/*
			 * ========================================================= Nothing to process
			 * =========================================================
			 */

			if (data == null) {
				return;
			}

			int totalGiven = 0;
			int totalSkipped = 0;
			int totalFailed = 0;

			/*
			 * ========================================================= Distribute
			 * =========================================================
			 */

			for (ActionPoint point : data.getGiftPoints()) {

				String employeeTypeId = getEmployeeTypeId(point.getActionPointType());

				if (employeeTypeId == null) {

					log.warn("Unknown employee type: " + point.getActionPointType()

					);

					continue;
				}

				/*
				 * ----------------------------------------------------- Query users
				 * -----------------------------------------------------
				 */

				List<User> users = transactionTemplate.execute(status -> {
					try {
						return userDAO.findEligibleUsers(employeeTypeId, data.isAllowActive(), data.isAllowProbation(),
								data.isAllowExcluded(), data.isAllowIntern(), data.isAllowEnable(),
								data.isAllowDisable());
					} catch (Exception e) {

						log.error("Failed to query eligible users for employee type: " + point.getActionPointType(), e);
						return null;
					}
				});

				if (users == null || users.isEmpty()) {

					log.info("No eligible users found for employee type: " + point.getActionPointType());

					continue;
				}

				log.info("Distributing " + point.getPoint() + " tokens to " + users.size()
						+ " users for employee type: " + point.getActionPointType());

				/*
				 * ===================================================== Each user = separate
				 * transaction =====================================================
				 */

				for (User user : users) {

					try {

						Boolean result = transactionTemplate.execute(status -> {

							try {

								/*
								 * --------------------------------- Check duplicate
								 * ---------------------------------
								 */

								boolean alreadyGiven = usageTokenDAO.existsMonthlyGift(user.getId(), ACTION_TYPE_GIFT,
										today.getMonthValue(), today.getYear());

								if (alreadyGiven) {
									return false;
								}

								/*
								 * --------------------------------- Create TokenUsage
								 * ---------------------------------
								 * 
								 */

								TokenUsage usage = new TokenUsage();

								usage.setUserId(user.getId());

								usage.setActionTypeId(point.getActionTypeId());

								usage.setActionPointId(point.getActionPointId());

								usage.setValue(point.getPoint());

								usage.setReconcile(null);

								usage.setMonth(today.getMonthValue());

								usage.setYear(today.getYear());

								ObjectNode jsonData = MAPPER.createObjectNode();

								jsonData.put("type", "add");

								jsonData.put("reason", "รายเดือน");

								usage.setDescription(MAPPER.writeValueAsString(jsonData));

								usage.setReFlag("N");
								usage.setUserCreate("system");

								usage.setTimeCreate(DateUtil.getCurrentTime());

								/*
								 * --------------------------------- Save ---------------------------------
								 */

								usageTokenDAO.save(usage);

								TokenMonthlyLogDetail detail = new TokenMonthlyLogDetail();
								detail.setMonitorLogId(data.getMonitorLogId());
								detail.setUserId(user.getId());
								detail.setDateTime(DateUtil.getCurrentTime());
								detail.setValue(point.getPoint());
								detail.setStatus("success");
								detail.setDescription("Monthly token distribution successful");
								detail.setUserCreate("system");

								tokenMonthlyLogDetailDAO.save(detail);

								return true;

							} catch (Exception e) {

								status.setRollbackOnly();

								throw new RuntimeException(e);
							}
						});

						/*
						 * ================================================= Result
						 * =================================================
						 */

						if (Boolean.TRUE.equals(result)) {

							totalGiven++;

						} else {

							totalSkipped++;
						}

					} catch (Exception e) {

						/*
						 * ================================================= User transaction failed
						 * =================================================
						 */

						totalFailed++;

						log.error("Token distribution failed for user: " + user.getId(), e);

						/*
						 * ================================================= Save failed log
						 * =================================================
						 */

						try {

							saveFailedTokenLog(data.getMonitorLogId(), user, point.getPoint(), e);

						} catch (Exception logException) {

							log.error("Failed to save monthly token failed log for user: " + user.getId(),
									logException);
						}
					}
				}
			}

			/*
			 * ========================================================= Update monthly log
			 * =========================================================
			 */

			final int GIVEN = totalGiven;
			final int FAILED = totalFailed;

			transactionTemplate.execute(status -> {

				try {

					TokenMonthlyLog monthlyLog = tokenMonthlyLogDAO.findById(data.getMonitorLogId());

					if (monthlyLog != null) {

						monthlyLog.setSuccessCase(GIVEN);
						monthlyLog.setFailCase(FAILED);

						monthlyLog.setTimeUpdate(DateUtil.getCurrentTime());

						monthlyLog.setUserUpdate("system");

						tokenMonthlyLogDAO.update(monthlyLog);
					}

					return null;

				} catch (Exception e) {

					status.setRollbackOnly();

					throw new RuntimeException("Failed to update monthly log", e);
				}
			});

			/*
			 * ========================================================= Completed
			 * =========================================================
			 */

			log.info("Monthly Token Distribution Completed. Given: " + totalGiven + ", Skipped: " + totalSkipped
					+ ", Failed: " + totalFailed);

		} catch (Exception e) {

			log.error("Error during monthly token distribution", e);
		}
	}

	public void retryFailedTokenDistribution(Integer monitorLogId) throws Exception {

		if (monitorLogId == null || monitorLogId <= 0) {
			throw new IllegalArgumentException("Invalid logId");
		}

		log.info("Start retry monthly token. monitorLogId=" + monitorLogId);

		// =========================================================
		// 1. Query failed users
		// =========================================================

		List<TokenMonthlyLogDetail> failedDetails = transactionTemplate.execute(status -> {
			try {
				return tokenMonthlyLogDetailDAO.findFailedByMonitorLogId(monitorLogId);
			} catch (Exception e) {
				log.error("Failed to query failed token logs. monitorLogId=" + monitorLogId, e);

				status.setRollbackOnly();
				throw new RuntimeException(e);
			}
		});

		if (failedDetails == null || failedDetails.isEmpty()) {
			log.info("No failed token log details found. monitorLogId=" + monitorLogId);
			return;
		}

		// =========================================================
		// 2. Create new retry log
		// =========================================================

		Integer retryLogId = transactionTemplate.execute(status -> {

			try {

				TokenMonthlyLog monthlyLog = new TokenMonthlyLog();

				monthlyLog.setFailCase(0);
				monthlyLog.setSuccessCase(0);
				monthlyLog.setDateTime(DateUtil.getCurrentTime());
				monthlyLog.setDescription("Retry monthly token distribution");
				monthlyLog.setUserCreate("system");
				monthlyLog.setTimeCreate(DateUtil.getCurrentTime());

				tokenMonthlyLogDAO.save(monthlyLog);

				return monthlyLog.getMonitorLogId();

			} catch (Exception e) {

				status.setRollbackOnly();

				log.error("Failed to create retry monthly log", e);

				throw new RuntimeException(e);
			}
		});

		int successCount = 0;
		int failCount = 0;
		int totalSkipped = 0;

		// =========================================================
		// 3. Retry each user
		// =========================================================

		for (TokenMonthlyLogDetail failedDetail : failedDetails) {

			try {

				boolean success = retryTokenForUser(failedDetail, retryLogId);

				if (success) {
					successCount++;
				} else {
					totalSkipped++;
				}

			} catch (Exception e) {

				failCount++;

				try {
					saveFailedTokenLog(monitorLogId, userDAO.findById(failedDetail.getUserId()),
							failedDetail.getValue(), e);
				} catch (Exception logException) {
					log.error("Failed to save retry failed log for userId=" + failedDetail.getUserId(), logException);
				}

				log.error("Retry failed for userId=" + failedDetail.getUserId(), e);
			}
		}

		// =========================================================
		// 4. Update retry log
		// =========================================================

		final int finalSuccessCount = successCount;
		final int finalFailCount = failCount;

		transactionTemplate.execute(status -> {

			try {

				TokenMonthlyLog monthlyLog = tokenMonthlyLogDAO.findById(retryLogId);

				if (monthlyLog != null) {

					monthlyLog.setSuccessCase(finalSuccessCount);
					monthlyLog.setFailCase(finalFailCount);
					monthlyLog.setUserUpdate("system");
					monthlyLog.setTimeUpdate(DateUtil.getCurrentTime());

					tokenMonthlyLogDAO.update(monthlyLog);
				}

				return null;

			} catch (Exception e) {

				status.setRollbackOnly();

				throw new RuntimeException("Failed to update retry monthly log", e);
			}
		});

		log.info("Retry monthly token completed. " + "monitorLogId=" + monitorLogId + ", retryLogId=" + retryLogId
				+ ", success=" + successCount + ", failed=" + failCount + " skipped=" + totalSkipped);
	}

	private boolean retryTokenForUser(TokenMonthlyLogDetail failedDetail, Integer retryLogId) throws Exception {

		Boolean result = transactionTemplate.execute(status -> {

			try {

				String userId = failedDetail.getUserId();
				Double value = failedDetail.getValue();

				if (userId == null || userId.isEmpty()) {
					throw new IllegalArgumentException("Invalid userId");
				}

				if (value == null || value <= 0) {
					throw new IllegalArgumentException("Invalid token value");
				}

				LocalDate targetDate = failedDetail.getDateTime().toInstant().atZone(ZoneId.systemDefault())
						.toLocalDate();

				boolean alreadyGiven = usageTokenDAO.existsMonthlyGift(userId, ACTION_TYPE_GIFT,
						targetDate.getMonthValue(), targetDate.getYear());

				if (alreadyGiven) {
					return false;
				}

				// Create TokenUsage
				TokenUsage usage = new TokenUsage();

				usage.setUserId(userId);
				usage.setActionTypeId(ACTION_TYPE_GIFT);
				usage.setValue(value);
				usage.setReconcile(null);
				usage.setMonth(targetDate.getMonthValue());
				usage.setYear(targetDate.getYear());

				ObjectNode jsonData = MAPPER.createObjectNode();
				jsonData.put("type", "add");
				jsonData.put("reason", "รายเดือน");

				usage.setDescription(MAPPER.writeValueAsString(jsonData));

				usage.setReFlag("N");
				usage.setUserCreate("system");
				usage.setTimeCreate(DateUtil.getCurrentTime());

				usageTokenDAO.save(usage);

				// Success detail
				TokenMonthlyLogDetail detail = new TokenMonthlyLogDetail();

				detail.setMonitorLogId(retryLogId);
				detail.setUserId(userId);
				detail.setDateTime(DateUtil.getCurrentTime());
				detail.setValue(value);
				detail.setStatus("success");
				detail.setDescription("Monthly token distribution successful on retry");
				detail.setUserCreate("system");
				detail.setTimeCreate(DateUtil.getCurrentTime());

				tokenMonthlyLogDetailDAO.save(detail);

				return true;

			} catch (Exception e) {

				status.setRollbackOnly();

				throw new RuntimeException(e);
			}
		});

		return Boolean.TRUE.equals(result);
	}

	private void saveFailedTokenLog(Integer monitorLogId, User user, Double value, Exception exception) {

		if (user == null || user.getId() == null || user.getId().isEmpty()) {
			log.error("Cannot save failed token log: invalid user");
			return;
		}

		transactionTemplate.execute(status -> {

			try {

				TokenMonthlyLogDetail detail = new TokenMonthlyLogDetail();

				detail.setMonitorLogId(monitorLogId);

				detail.setUserId(user.getId());

				detail.setDateTime(DateUtil.getCurrentTime());

				detail.setValue(value);

				detail.setStatus("failed");

				String message = exception.getMessage();

				if (message == null || message.isEmpty()) {
					message = exception.getClass().getSimpleName();
				}

				detail.setDescription("Monthly token distribution failed: " + message);

				detail.setUserCreate("system");

				detail.setTimeCreate(DateUtil.getCurrentTime());

				tokenMonthlyLogDetailDAO.save(detail);

				return null;

			} catch (Exception e) {

				status.setRollbackOnly();

				throw new RuntimeException("Cannot save failed token log", e);
			}
		});
	}

	@Scheduled(cron = "0 0 0 5 * ?", zone = "Asia/Bangkok")
//	@Scheduled(fixedRate = 10000)
	@Transactional
	public void calculateAccumulatedToken() throws Exception { // คํานวณยอดสะสม Token ของพนักงานทุกคนในแต่ละเดือน

		try {

			LocalDate today = LocalDate.now();
			YearMonth previousMonth = YearMonth.from(today).minusMonths(1);

			log.info("Starting accumulated token calculation for " + previousMonth.toString());

			List<String> userIds = usageTokenDAO.findAllUserIds();

			int processedCount = 0;
			int skippedCount = 0;

			int year = previousMonth.getYear();
			int month = previousMonth.getMonthValue();

			for (String userId : userIds) {

				Double monthlyBalance = usageTokenDAO.findMonthlyBalance(userId, previousMonth);

				if (monthlyBalance == null) {
					monthlyBalance = 0D;
				}

				double value = monthlyBalance;

				/*
				 * ป้องกัน scheduler รันซ้ำ
				 */

				boolean exists = usageTokenDAO.existsAccumulatedToken(userId, previousMonth);

				if (exists) {

					skippedCount++;

					continue;

				}

				/*
				 * Insert Accumulated Token
				 */
				TokenUsage usage = new TokenUsage();

				ObjectNode description = MAPPER.createObjectNode();

				description.put("type", "accumulated");
				description.put("reason", "โทเคนสะสมจากเดือน " + previousMonth.toString());

				usage.setUserId(userId);
				usage.setActionTypeId(ACTION_TYPE_ADD_RECONCILE);
				usage.setValue(null);
				usage.setReconcile(value);
				usage.setDescription(MAPPER.writeValueAsString(description));
				usage.setYear(year);
				usage.setMonth(month);
				usage.setReFlag("N");
				usage.setUserCreate("system");
				usage.setTimeCreate(DateUtil.getCurrentTime());

				usageTokenDAO.save(usage);
				
				if (previousMonth.getMonthValue() == 12) {
				    int previousYear = previousMonth.getYear();
				    int newYear = previousYear + 1;

				    Double carryOverBalance = usageTokenDAO.findAccumulatedBalanceByYear(userId, previousYear);

				    boolean carryOverExists =
				            usageTokenDAO.existsCarryOver(userId, newYear);

				    if (!carryOverExists) {
				        TokenUsage carryOver = new TokenUsage();

				        ObjectNode carryOverDescription = MAPPER.createObjectNode();
				        carryOverDescription.put("type", "carry_over");
				        carryOverDescription.put("reason", "Carry over token from " + previousYear);

				        carryOver.setUserId(userId);
				        carryOver.setActionTypeId(ACTION_TYPE_CARRY_OVER);
				        carryOver.setValue(null);
				        carryOver.setReconcile(carryOverBalance);
				        carryOver.setDescription(MAPPER.writeValueAsString(carryOverDescription));
				        carryOver.setYear(LocalDate.now().getYear());
				        carryOver.setMonth(LocalDate.now().getMonthValue());
				        carryOver.setReFlag("N");
				        carryOver.setUserCreate("system");
				        carryOver.setTimeCreate(DateUtil.getCurrentTime());

				        usageTokenDAO.save(carryOver);
				    }
				}

				TokenUsageSummary summary = new TokenUsageSummary();
				Double userCurrentBalance = getUserCurrentAccumulatedBalance(userId);

				summary.setUserId(userId);
				summary.setActionTypeId(ACTION_TYPE_ADD_RECONCILE);
				summary.setYear(previousMonth.getYear());
				summary.setMonth(previousMonth.getMonthValue());
				summary.setMonthlyToken(Math.max(monthlyBalance, 0));
				summary.setTotalToken(Math.max(userCurrentBalance, 0));
				summary.setDescription("Accumulated token from " + previousMonth.toString());
				summary.setUserCreate("system");
				summary.setTimeCreate(DateUtil.getCurrentTime());

				tokenUsageSummaryDAO.save(summary);

				processedCount++;
			}

			log.info(String.format("Accumulated token calculation completed: month=%s, processed=%d, skipped=%d",
					previousMonth.toString(), processedCount, skippedCount));

		} catch (Exception e) {

			log.error("Error calculating Accumulated token: " + e.getMessage(), e);

		}
	}

	@Scheduled(cron = "0 0 1 * * *", zone = "Asia/Bangkok")
//	@Scheduled(fixedRate = 10000)
	@Transactional
	public void checkWorkHoursForToken() {

		try {

			log.info("Work hours check for token started.");

			LocalDate targetDate = LocalDate.now().minusDays(5);

			log.info(targetDate.getDayOfMonth());

			DayOfWeek dayOfWeek = targetDate.getDayOfWeek();

			// =========================
			// Weekend
			// =========================
			if (dayOfWeek == DayOfWeek.SATURDAY || dayOfWeek == DayOfWeek.SUNDAY) {

				log.info("Target date " + targetDate + " is a weekend. Skipping work hours check.");

				return;
			}

			// =========================
			// Holiday
			// =========================
			Date targetDateObj = Date.from(targetDate.atStartOfDay(ZoneId.systemDefault()).toInstant());

			if (holidayDAO.isHoliday(targetDateObj)) {

				log.info("Target date " + targetDate + " is holiday. Skip work hours check.");

				return;
			}

			checkApprovedLeavesForToken(targetDate);

			// =========================
			// Get work hours
			// =========================
			List<Object[]> workHoursList = workHoursDAO.findUserEnableWorkHoursByDate(targetDateObj);

			for (Object[] row : workHoursList) {

				String userId = (String) row[0];

				String workTimeStart = (String) row[1];

				String workTimeEnd = (String) row[2];

				Timestamp checkin = (Timestamp) row[3];

				Timestamp checkinTimeCreate = (Timestamp) row[4];

				String checkinDescription = (String) row[5];

				Timestamp checkout = (Timestamp) row[6];

				Timestamp checkoutTimeCreate = (Timestamp) row[7];

				String checkoutDescription = (String) row[8];

				// =====================================================
				// Approved Leave
				// =====================================================

				boolean skipMorning = false;
				boolean skipAfternoon = false;

				List<Object[]> leaveList = leaveDAO.findApprovedLeaveByUserAndDate(userId, targetDate);

				for (Object[] leave : leaveList) {

					String halfDay = leave[0] != null ? leave[0].toString() : null;

					String startTime = leave[1] != null ? leave[1].toString() : null;

					String endTime = leave[2] != null ? leave[2].toString() : null;

					// =========================
					// Full Day
					// =========================
					if ("0".equals(halfDay)) {
						skipMorning = true;
						skipAfternoon = true;
					}

					// =========================
					// Morning
					// =========================
					else if ("1".equals(halfDay)) {
						skipMorning = true;
					}

					// =========================
					// Afternoon
					// =========================
					else if ("2".equals(halfDay)) {
						skipAfternoon = true;
					}

					// =========================
					// Custom Time
					// =========================
					else if ("3".equals(halfDay) && startTime != null && endTime != null) {

						LocalTime leaveStart = parseTime(startTime);

						LocalTime leaveEnd = parseTime(endTime);

						LocalTime workStart = parseTime(workTimeStart);

						LocalTime workEnd = parseTime(workTimeEnd);

						LocalTime morningEnd = LocalTime.of(12, 0);

						LocalTime afternoonStart = LocalTime.of(13, 0);

						// =========================
						// Morning overlap
						// =========================
						if (leaveStart.isBefore(morningEnd) && leaveEnd.isAfter(workStart)) {
							skipMorning = true;
						}

						// =========================
						// Afternoon overlap
						// =========================
						if (leaveStart.isBefore(workEnd) && leaveEnd.isAfter(afternoonStart)) {
							skipAfternoon = true;
						}
					}
				}

				// =====================================================
				// No Record - Morning
				// =====================================================

				if (!skipMorning && checkin == null) {

					deductUserCubeTokenForNoRecordMorning(userId, targetDate, workTimeStart);
				}

				// =====================================================
				// No Record - Afternoon
				// =====================================================

				if (!skipAfternoon && checkout == null) {

					deductUserCubeTokenForNoRecordAfternoon(userId, targetDate, workTimeEnd);
				}

				// =====================================================
				// Late
				// =====================================================

				if (!skipMorning && checkin != null && isLate(checkin, workTimeStart)) {

					deductUserCubeTokenForLate(userId, checkin);
				}

				// =====================================================
				// Early Out
				// =====================================================

				if (!skipAfternoon && checkout != null && isEarlyOut(checkout, workTimeEnd)) {

					deductUserCubeTokenForEarlyOut(userId, checkout);
				}

				// =====================================================
				// Backdate - Checkin
				// =====================================================

				if (isBackdated(checkin, checkinTimeCreate, checkinDescription, targetDate)) {

					deductUserCubeTokenForBackDateCheckIn(userId, checkin, checkinTimeCreate);
				}

				// =====================================================
				// Backdate - Checkout
				// =====================================================

				if (isBackdated(checkout, checkoutTimeCreate, checkoutDescription, targetDate)) {

					deductUserCubeTokenForBackDateCheckOut(userId, checkout, checkoutTimeCreate);
				}
			}

			log.info("Work hours check completed for date: " + targetDate);

		} catch (Exception e) {

			log.error("Error checking work hours for token: " + e.getMessage(), e);
		}
	}

	private void checkApprovedLeavesForToken(LocalDate targetDate) throws Exception {

		List<Leaves> approvedLeaves = leaveDAO.findApprovedLeavesByStartDate(targetDate);

		if (approvedLeaves == null || approvedLeaves.isEmpty()) {
			log.info("No approved leaves found for date: " + targetDate);
			return;
		}

		for (Leaves leave : approvedLeaves) {
			try {
				if (leave == null) {
					continue;
				}

				String userId = leave.getUserId();

				log.info("Processing approved leave. Leave ID: " + leave.getLeaveId() + ", User ID: " + userId
						+ ", Start date: " + leave.getStartDate() + ", End date: " + leave.getEndDate());

				// ตรวจสอบว่าหัก Token ของคำขอนี้ไปแล้วหรือยัง
				if (usageTokenDAO.existsLeaveDeduction(leave.getLeaveId())) {
					log.info("Token already deducted for leave ID: " + leave.getLeaveId());
					continue;
				}

				// ใช้ logic การหัก Token เดิม
				deductUserCubeTokenForLeave(userId, leave);

			} catch (Exception e) {
				// ถ้าคำขอใดผิดพลาด ให้ประมวลผลคำขอถัดไปต่อ
				log.error("Failed to deduct token for leave ID: " + leave.getLeaveId(), e);
			}
		}

		log.info("Approved leave token check completed for date: " + targetDate);
	}

	@Transactional(readOnly = true)
	public Double getUserYearlyTokenBalance(String userId, Integer year) throws Exception {

		if (year > LocalDate.now().getYear()) {
			throw new IllegalArgumentException("Year cannot be in the future.");
		}

		if (year == null || year <= 0) {
			year = LocalDate.now().getYear();
		}

		Double yearlyBalance = usageTokenDAO.findYearlyBalance(userId, year);

		return yearlyBalance != null ? yearlyBalance : 0D;
	}

	@Transactional(readOnly = true)
	public List<Map<String, Object>> getUserTokenTransactionByYear(String userId, Integer year) throws Exception {

		if (year == null || year <= 0) {
			year = LocalDate.now().getYear();
		}

		if (year > LocalDate.now().getYear()) {
			throw new IllegalArgumentException("Year cannot be in the future.");
		}

		List<Map<String, Object>> ledger = usageTokenDAO.findTokenLedgerByUserId(userId, year);

		Map<String, Map<String, Object>> monthMap = new LinkedHashMap<>();

		// =====================================================
		// Group by month
		// =====================================================

		/*
		 * for (Map<String, Object> row : ledger) {
		 * 
		 * Timestamp ts = (Timestamp) row.get("time_create"); LocalDateTime dateTime =
		 * ts.toLocalDateTime();
		 * 
		 * String monthKey = dateTime.getMonth().getDisplayName(TextStyle.FULL,
		 * java.util.Locale.ENGLISH);
		 * 
		 * Map<String, Object> month = monthMap.computeIfAbsent(monthKey, k -> {
		 * 
		 * Map<String, Object> m = new LinkedHashMap<>();
		 * 
		 * m.put("month", monthKey); m.put("transactions", new ArrayList<Map<String,
		 * Object>>());
		 * 
		 * return m; });
		 * 
		 * @SuppressWarnings("unchecked") List<Map<String, Object>> transactions =
		 * (List<Map<String, Object>>) month.get("transactions");
		 * 
		 * Map<String, Object> tx = new LinkedHashMap<>();
		 * 
		 * tx.put("id", row.get("token_usage_id"));
		 * 
		 * DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("d MMM, HH:mm",
		 * java.util.Locale.ENGLISH);
		 * 
		 * tx.put("date", dateTime.format(dateFormatter));
		 * 
		 * tx.put("actionName", row.get("action_name"));
		 * 
		 * if ("1".equals(row.get("action_type_id").toString())) { tx.put("actionName",
		 * row.get("action_type_name")); } else { tx.put("actionName",
		 * row.get("action_name")); }
		 * 
		 * tx.put("userId", userId); tx.put("transactionType",
		 * row.get("transaction_type")); tx.put("value", ((Number)
		 * row.get("value")).doubleValue()); tx.put("reconcile", row.get("reconcile") !=
		 * null ? ((Number) row.get("reconcile")).doubleValue() : 0D);
		 * tx.put("returned", "N".equals(String.valueOf(row.get("returned"))));
		 * tx.put("description", row.get("description"));
		 * 
		 * transactions.add(tx); }
		 */

		for (Map<String, Object> row : ledger) {

			int transactionYear = ((Number) row.get("year")).intValue();
			int transactionMonth = ((Number) row.get("month")).intValue();

			Month monthEnum = Month.of(transactionMonth);

			String monthKey = monthEnum.getDisplayName(TextStyle.FULL, Locale.ENGLISH);

			Map<String, Object> month = monthMap.computeIfAbsent(transactionYear + "-" + transactionMonth, k -> {

				Map<String, Object> m = new LinkedHashMap<>();

				m.put("year", transactionYear);
				m.put("month", monthKey);
				m.put("monthNumber", transactionMonth);

				m.put("transactions", new ArrayList<Map<String, Object>>());

				return m;
			});

			@SuppressWarnings("unchecked")
			List<Map<String, Object>> transactions = (List<Map<String, Object>>) month.get("transactions");

			Map<String, Object> tx = new LinkedHashMap<>();

			tx.put("id", row.get("token_usage_id"));

			Timestamp ts = (Timestamp) row.get("time_create");

			if (ts != null) {
				LocalDateTime dateTime = ts.toLocalDateTime();

				DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("d MMM, HH:mm", Locale.ENGLISH);

				tx.put("date", dateTime.format(dateFormatter));
			} else {
				tx.put("date", "-");
			}

			tx.put("actionName", row.get("action_name"));

			if ("1".equals(String.valueOf(row.get("action_type_id")))) {
				tx.put("actionName", row.get("action_type_name"));
			} else {
				tx.put("actionName", row.get("action_name"));
			}

			tx.put("userId", userId);
			tx.put("transactionType", row.get("transaction_type"));

			tx.put("value", ((Number) row.get("value")).doubleValue());

			tx.put("reconcile", row.get("reconcile") != null ? ((Number) row.get("reconcile")).doubleValue() : 0D);

			tx.put("returned", "N".equals(String.valueOf(row.get("returned"))));

			tx.put("description", row.get("description"));

			transactions.add(tx);
		}

		// =====================================================
		// Calculate summary
		// =====================================================

		for (Map<String, Object> month : monthMap.values()) {

			@SuppressWarnings("unchecked")
			List<Map<String, Object>> transactions = (List<Map<String, Object>>) month.get("transactions");

			Map<String, Object> summary = new LinkedHashMap<>();

			summary.put("gift", 0D);
			summary.put("late", 0D);
			summary.put("earlyout", 0D);
			summary.put("leave", 0D);
			summary.put("norecord", 0D);
			summary.put("backdate", 0D);
			summary.put("reward", 0D);
			summary.put("return", 0D);
			summary.put("exchange", 0D);

			double runningBalance = 0D;

			for (Map<String, Object> tx : transactions) {

				String transactionType = (String) tx.get("transactionType");

				String actionType = ((String) tx.get("actionName")).toLowerCase().replace(" ", "");

				double value = ((Number) tx.get("value")).doubleValue();

				if ("ADD".equals(transactionType)) {

					runningBalance += value;
					summary.put(actionType, ((Number) summary.get(actionType)).doubleValue() + value);

				} else {

					runningBalance -= value;

					if ("void".equals(actionType)) {
						summary.put("reward", ((Number) summary.get("reward")).doubleValue() - value);
					} else {
						summary.put(actionType, ((Number) summary.get(actionType)).doubleValue() - value);
					}

				}

				tx.put("balance", runningBalance);
			}

			for (String key : summary.keySet()) {
				summary.put(key, Math.abs(((Number) summary.get(key)).doubleValue()));
			}

			summary.put("balance", runningBalance);

			month.put("summary", summary);
		}

		return new ArrayList<>(monthMap.values());
	}

	@Transactional(readOnly = true)
	public Map<String, Object> getTokenSettingPageData() throws Exception {

		Map<String, Object> result = new LinkedHashMap<>();

		/*
		 * ========================= Activate Date =========================
		 */
		TokenSetting activateDateSetting = tokenSettingDAO.findByType("activate_date");

		Integer activateDate = null;

		if (activateDateSetting != null) {
			activateDate = Integer.valueOf(activateDateSetting.getStatus());
		}

		result.put("activate_date", activateDate);

		/*
		 * ========================= Filter =========================
		 */
		Map<String, Object> filter = new LinkedHashMap<>();

		Map<String, Object> employeeStatus = new LinkedHashMap<>();

		employeeStatus.put("active",
				buildFilterSetting(tokenSettingDAO.findByTypeAndTypeName("user_status", "Active")));

		employeeStatus.put("probation",
				buildFilterSetting(tokenSettingDAO.findByTypeAndTypeName("user_status", "Probation")));

		employeeStatus.put("excluded",
				buildFilterSetting(tokenSettingDAO.findByTypeAndTypeName("user_status", "Excluded")));

		employeeStatus.put("intern",
				buildFilterSetting(tokenSettingDAO.findByTypeAndTypeName("user_status", "Intern")));

		filter.put("employee_status", employeeStatus);

		Map<String, Object> systemStatus = new LinkedHashMap<>();

		systemStatus.put("enable",
				buildFilterSetting(tokenSettingDAO.findByTypeAndTypeName("system_status", "Enable")));

		systemStatus.put("disable",
				buildFilterSetting(tokenSettingDAO.findByTypeAndTypeName("system_status", "Disable")));

		filter.put("system_status", systemStatus);

		result.put("filter", filter);

		/*
		 * ========================= Gift Setting =========================
		 */
		ActionType giftType = actionTypeDAO.findById(ACTION_TYPE_GIFT);

		Map<String, Object> giftSetting = new LinkedHashMap<>();

		boolean giftActive = giftType != null && "Y".equals(giftType.getActiveStatus());

		giftSetting.put("active", giftActive);

		List<ActionPoint> giftPoints = actionPointDAO.findByActionTypeId(ACTION_TYPE_GIFT);

		List<Map<String, Object>> giftData = new ArrayList<>();

		for (ActionPoint point : giftPoints) {

			Map<String, Object> row = new LinkedHashMap<>();

			row.put("id", point.getActionPointId());
			row.put("name_en", point.getActionPointType());
			row.put("name_th", point.getActionPointName());
			row.put("point", point.getPoint());
			row.put("active", "Y".equals(point.getActiveStatus()));

			getStyle(row);

			giftData.add(row);
		}

		giftSetting.put("data", giftData);

		result.put("giftSetting", giftSetting);

		/*
		 * ========================= Deduct Setting =========================
		 */
		ActionType deductType = actionTypeDAO.findById(ACTION_TYPE_DUDUCT);

		Map<String, Object> deductSetting = new LinkedHashMap<>();

		boolean deductActive = deductType != null && "Y".equals(deductType.getActiveStatus());

		deductSetting.put("active", deductActive);

		List<ActionPoint> deductPoints = actionPointDAO.findByActionTypeId(ACTION_TYPE_DUDUCT);

		List<Map<String, Object>> deductData = new ArrayList<>();

		for (ActionPoint point : deductPoints) {

			Map<String, Object> row = new LinkedHashMap<>();

			row.put("id", point.getActionPointId());
			row.put("name_en",
					"Late".equals(point.getActionPointType()) ? "Check-In Late" : point.getActionPointType());
			row.put("name_th", point.getActionPointName());
			row.put("point", point.getPoint().intValue());
			row.put("active", "Y".equals(point.getActiveStatus()));
			getStyle(row);

			deductData.add(row);
		}

		deductSetting.put("data", deductData);

		result.put("deductSetting", deductSetting);

		return result;
	}

	@Transactional(readOnly = true)
	public Map<String, Object> getUserTokenSummary(String userId, Integer year) throws Exception {

		if (year > LocalDate.now().getYear()) {
			throw new IllegalArgumentException("Year cannot be in the future.");
		}

		if (year == null || year <= 0) {
			year = LocalDate.now().getYear();
		}

		Map<String, Object> row = usageTokenDAO.findTokenSummaryByUserId(userId, year);

		Map<String, Object> result = new LinkedHashMap<>();

		result.put("accumulatedToken", getDouble(row, "token"));

		result.put("yearlyToken", getUserYearlyTokenBalance(userId, year));

		result.put("gift", getDouble(row, "gift"));

		result.put("reward", getDouble(row, "reward"));

		result.put("return", getDouble(row, "return_token"));

		result.put("exchange", getDouble(row, "exchange"));

		result.put("late", getDouble(row, "late"));

		result.put("earlyOut", getDouble(row, "early_out"));

		result.put("leave", getDouble(row, "leave_token"));

		result.put("backDate", getDouble(row, "back_date"));

		result.put("noRecord", getDouble(row, "no_record"));

		return result;
	}

	@Transactional(readOnly = true)
	public List<Map<String, Object>> getTokenSummaryForAllUsers(Integer year) throws Exception {

		if (year > LocalDate.now().getYear()) {
			throw new IllegalArgumentException("Year cannot be in the future.");
		}

		if (year == null || year <= 0) {
			year = LocalDate.now().getYear();
		}

		List<Map<String, Object>> summaryList = usageTokenDAO.findTokenSummaryForAllUsers(year);

		for (Map<String, Object> row : summaryList) {

			if (row.get("file_path") != null) {
				String filePath = fileAttachmentService.getFileUrl(row.get("file_path").toString());
				row.put("file_path", filePath);
			}

		}

		return summaryList;
	}

	public List<Integer> getTokenAvailableYears(String userId) throws Exception {

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		Integer year = LocalDate.now().getYear();

		Integer startYear = Integer.valueOf(userDAO.findStartYear(userId));
		List<Integer> availableYears = new ArrayList<>();

		while (startYear <= year) {
			availableYears.add(0, startYear);
			startYear++;
		}

		return availableYears;
	}

	public Map<String, Object> getUserInfo(String userId) throws Exception {

		Map<String, Object> result = new LinkedHashMap<>();
		User user = userDAO.findById(userId);

		result.put("id", user.getId());
		result.put("name_en", user.getNameEN());
		result.put("name_th", user.getName());
		result.put("employee_id", user.getEmployeeId());
		result.put("employee_type", user.getEmployeeTypeId());
		result.put("employee_status", user.getEmployeeStatus());
		result.put("position", user.getPositionId());
		result.put("department", user.getDepartmentId());

		List<Map<String, Object>> userJobsiteList = jobsiteDAO.getNameSiteListByUserId(userId);

		if (userJobsiteList == null || userJobsiteList.isEmpty()) {
			log.warn("No jobsite found for user: " + userId);
			userJobsiteList = new ArrayList<Map<String, Object>>(); // Return an empty list instead of null
		}

		result.put("jobsiteList", userJobsiteList);

		return result;
	}

	public void deductUserCubeTokenForLeave(String userId, Leaves leave) throws Exception {

		if (leave == null) {
			throw new IllegalArgumentException("Leave object is null.");
		}

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		if (!"1".equals(leave.getLeaveStatusId())) {
			log.info("Leave status is not approved. No token deduction will be made for leave ID: "
					+ leave.getLeaveId());
			return;
		}

		// ========================================
		// ลาพักร้อน
		// ========================================
		if ("1".equals(leave.getLeaveTypeId())) {

			if (leave.getTimeCreate() == null || leave.getStartDate() == null) {

				log.warn("Cannot calculate advance leave days because " + "timeCreate or startDate is null. Leave ID: "
						+ leave.getLeaveId());

			} else {

				LocalDate requestDate = leave.getTimeCreate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

				LocalDate leaveStartDate = leave.getStartDate().toInstant().atZone(ZoneId.systemDefault())
						.toLocalDate();

				int businessDays = countBusinessDays(requestDate, leaveStartDate);

				log.info("Annual leave ID: " + leave.getLeaveId() + ", requestDate: " + requestDate
						+ ", leaveStartDate: " + leaveStartDate + ", advance business days: " + businessDays);

				// ลาล่วงหน้าอย่างน้อย 5 วันทำการ
				if (businessDays >= 5) {

					log.info("Annual leave was requested at least 5 business days "
							+ "in advance. No token deduction will be made. " + "Leave ID: " + leave.getLeaveId());

					return;
				}
			}
		}

		// ========================================
		// Check deduct action
		// ========================================
		ActionType deductType = actionTypeDAO.findById(ACTION_TYPE_DUDUCT);

		if (deductType == null || !"Y".equals(deductType.getActiveStatus())) {

			log.info("Deduct action type is not active. " + "No token deduction will be made for leave ID: "
					+ leave.getLeaveId());

			return;
		}

		// ========================================
		// Deduct token
		// ========================================
		ActionPoint leaveActionPoint = actionPointDAO.findById(ACTION_POINT_LEAVE);

		if (leaveActionPoint == null) {
			throw new IllegalStateException("Leave action point not found.");
		}

		if ("N".equals(leaveActionPoint.getActiveStatus()) || leaveActionPoint.getPoint() == 0D) {

			log.info("Leave action is inactive or has zero points. " + "No deduction will be made.");

			return;
		}

		LeaveType leaveType = leaveTypeDAO.findById(leave.getLeaveTypeId());

		TokenUsage tokenUsage = new TokenUsage();

		tokenUsage.setUserId(userId);
		tokenUsage.setActionTypeId(ACTION_TYPE_DUDUCT);
		tokenUsage.setActionPointId(ACTION_POINT_LEAVE);
		tokenUsage.setValue(leaveActionPoint.getPoint());
		tokenUsage.setReconcile(null);
		tokenUsage.setYear(leave.getStartDate().toInstant().atZone(ZoneId.systemDefault()).getYear());
		tokenUsage.setMonth(leave.getStartDate().toInstant().atZone(ZoneId.systemDefault()).getMonthValue());
		tokenUsage.setReFlag("Y");

		ObjectNode jsonNode = MAPPER.createObjectNode();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

		jsonNode.put("type", "deduct");
		jsonNode.put("action", "leave");
		jsonNode.put("reason", leaveType.getLeaveTypeName());
		jsonNode.put("referenceId", leave.getLeaveId());
		jsonNode.put("startDate", dateFormat.format(leave.getStartDate()));
		jsonNode.put("endDate", dateFormat.format(leave.getEndDate()));
		jsonNode.put("startTime", leave.getStartTime());
		jsonNode.put("endTime", leave.getEndTime());
		jsonNode.put("halfDay", leave.getHalfDay());

		tokenUsage.setDescription(MAPPER.writeValueAsString(jsonNode));

		tokenUsage.setUserCreate("system");
		tokenUsage.setTimeCreate(DateUtil.getCurrentTime());

		usageTokenDAO.save(tokenUsage);

		log.info("Deducted " + leaveActionPoint.getPoint() + " tokens for leave ID: " + leave.getLeaveId()
				+ " for user: " + userId);
	}

	private void deductUserCubeTokenForNoRecordMorning(String userId, LocalDate targetDate, String workTimeStart)
			throws Exception {

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		if (targetDate == null) {
			throw new IllegalArgumentException("Target date is required.");
		}

		if (workTimeStart == null || workTimeStart.trim().isEmpty()) {
			throw new IllegalArgumentException("Work time start is required.");
		}

		ActionType deductType = actionTypeDAO.findById(ACTION_TYPE_DUDUCT);

		if (deductType == null || !"Y".equals(deductType.getActiveStatus())) {
			log.info("Deduct action type is not active. No token deduction will be made for no record.");

			return;
		}

		ActionPoint noRecordActionPoint = actionPointDAO.findById(ACTION_POINT_NO_RECORD);

		if (noRecordActionPoint == null) {
			throw new IllegalStateException("No Record action point not found.");
		}

		if ("N".equals(noRecordActionPoint.getActiveStatus()) || noRecordActionPoint.getPoint() == 0D) {

			log.info("No Record action is inactive or has zero points. No deduction will be made.");

			return;
		}

		/*
		 * Description Example: targetDate = 2026-08-05 workTimeStart = 9:00
		 *
		 * Result: 5 Aug, 9:00
		 */
		String eventDate = targetDate.format(DateTimeFormatter.ofPattern("d MMM", Locale.ENGLISH)) + ", "
				+ workTimeStart;

		TokenUsage tokenUsage = new TokenUsage();

		ObjectNode jsonNode = MAPPER.createObjectNode();

		jsonNode.put("type", "deduct");
		jsonNode.put("reason", "ไม่พบประวัติ Check-In");
		jsonNode.put("date", eventDate);

		tokenUsage.setUserId(userId);
		tokenUsage.setActionTypeId(ACTION_TYPE_DUDUCT);
		tokenUsage.setActionPointId(ACTION_POINT_NO_RECORD);
		tokenUsage.setValue(noRecordActionPoint.getPoint());
		tokenUsage.setReconcile(null);
		tokenUsage.setYear(targetDate.getYear());
		tokenUsage.setMonth(targetDate.getMonthValue());
		tokenUsage.setReFlag("Y");
		tokenUsage.setDescription(MAPPER.writeValueAsString(jsonNode));
		tokenUsage.setUserCreate("system");
		tokenUsage.setTimeCreate(DateUtil.getCurrentTime());

		usageTokenDAO.save(tokenUsage);

		log.info("Deducted " + noRecordActionPoint.getPoint() + " tokens for no record - morning" + " for user: "
				+ userId + ", date: " + targetDate + ", work time start: " + workTimeStart);

	}

	private void deductUserCubeTokenForNoRecordAfternoon(String userId, LocalDate targetDate, String workTimeEnd)
			throws Exception {

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		if (targetDate == null) {
			throw new IllegalArgumentException("Target date is required.");
		}

		if (workTimeEnd == null || workTimeEnd.trim().isEmpty()) {
			throw new IllegalArgumentException("Work time end is required.");
		}

		ActionType deductType = actionTypeDAO.findById(ACTION_TYPE_DUDUCT);

		if (deductType == null || !"Y".equals(deductType.getActiveStatus())) {
			log.info("Deduct action type is not active. No token deduction will be made for no record.");

			return;
		}

		ActionPoint noRecordActionPoint = actionPointDAO.findById(ACTION_POINT_NO_RECORD);

		if (noRecordActionPoint == null) {
			throw new IllegalStateException("No Record action point not found.");
		}

		if ("N".equals(noRecordActionPoint.getActiveStatus()) || noRecordActionPoint.getPoint() == 0D) {

			log.info("No Record action is inactive or has zero points. No deduction will be made.");

			return;
		}

		/*
		 * Description Example: targetDate = 2026-08-05 workTimeEnd = 18:00
		 *
		 * Result: 5 Aug, 18:00
		 */
		String eventDate = targetDate.format(DateTimeFormatter.ofPattern("d MMM", Locale.ENGLISH)) + ", " + workTimeEnd;

		TokenUsage tokenUsage = new TokenUsage();

		ObjectNode jsonNode = MAPPER.createObjectNode();

		jsonNode.put("type", "deduct");
		jsonNode.put("reason", "ไม่พบประวัติ Check-Out");
		jsonNode.put("date", eventDate);

		tokenUsage.setUserId(userId);
		tokenUsage.setActionTypeId(ACTION_TYPE_DUDUCT);
		tokenUsage.setActionPointId(ACTION_POINT_NO_RECORD);
		tokenUsage.setValue(noRecordActionPoint.getPoint());
		tokenUsage.setReconcile(null);
		tokenUsage.setYear(targetDate.getYear());
		tokenUsage.setMonth(targetDate.getMonthValue());
		tokenUsage.setReFlag("Y");
		tokenUsage.setDescription(MAPPER.writeValueAsString(jsonNode));
		tokenUsage.setUserCreate("system");
		tokenUsage.setTimeCreate(DateUtil.getCurrentTime());

		usageTokenDAO.save(tokenUsage);

		log.info("Deducted " + noRecordActionPoint.getPoint() + " tokens for no record - afternoon" + " for user: "
				+ userId + ", date: " + targetDate + ", work time end: " + workTimeEnd);
	}

	private void deductUserCubeTokenForLate(String userId, Timestamp checkIn) throws Exception {

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		ActionType deductType = actionTypeDAO.findById(ACTION_TYPE_DUDUCT);

		if (deductType == null || !"Y".equals(deductType.getActiveStatus())) {
			log.info("Deduct action type is not active. No token deduction will be made for late check-in.");
			return;
		}

		ActionPoint lateActionPoint = actionPointDAO.findById(ACTION_POINT_LATE);

		if (lateActionPoint == null) {
			throw new IllegalStateException("Leave action point not found.");
		}

		if (lateActionPoint.getActiveStatus().equals("N") || lateActionPoint.getPoint() == 0D) {
			log.info("Leave action is inactive or has zero points. No deduction will be made.");
			return;
		}

		TokenUsage tokenUsage = new TokenUsage();

		ObjectNode jsonNode = MAPPER.createObjectNode();

		jsonNode.put("type", "deduct");
		jsonNode.put("reason", "เข้างานสาย");
		jsonNode.put("date", checkIn.toLocalDateTime().format(FORMATTER));

		tokenUsage.setUserId(userId);
		tokenUsage.setActionTypeId(ACTION_TYPE_DUDUCT);
		tokenUsage.setActionPointId(ACTION_POINT_LATE);
		tokenUsage.setValue(lateActionPoint.getPoint());
		tokenUsage.setReconcile(null);
		tokenUsage.setYear(checkIn.toLocalDateTime().getYear());
		tokenUsage.setReFlag("Y");
		tokenUsage.setDescription(MAPPER.writeValueAsString(jsonNode));
		tokenUsage.setUserCreate("system");
		tokenUsage.setTimeCreate(DateUtil.getCurrentTime());

		usageTokenDAO.save(tokenUsage);

		log.info("Deducted " + lateActionPoint.getPoint() + " tokens for late check-in" + " for user: " + userId);

	}

	private void deductUserCubeTokenForEarlyOut(String userId, Timestamp checkOut) throws Exception {

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		ActionType deductType = actionTypeDAO.findById(ACTION_POINT_EARLY_OUT);

		if (deductType == null || !"Y".equals(deductType.getActiveStatus())) {
			log.info("Deduct action type is not active. No token deduction will be made for late early out.");
			return;
		}

		ActionPoint earlyOutActionPoint = actionPointDAO.findById(ACTION_POINT_EARLY_OUT);

		if (earlyOutActionPoint == null) {
			throw new IllegalStateException("Early out action point not found.");
		}

		if (earlyOutActionPoint.getActiveStatus().equals("N") || earlyOutActionPoint.getPoint() == 0D) {
			log.info("Early out action is inactive or has zero points. No deduction will be made.");
			return;
		}

		TokenUsage tokenUsage = new TokenUsage();

		ObjectNode jsonNode = MAPPER.createObjectNode();

		jsonNode.put("type", "deduct");
		jsonNode.put("reason", "ออกก่อนเวลา");
		jsonNode.put("date", checkOut.toLocalDateTime().format(FORMATTER));

		tokenUsage.setUserId(userId);
		tokenUsage.setActionTypeId(ACTION_TYPE_DUDUCT);
		tokenUsage.setActionPointId(ACTION_POINT_EARLY_OUT);
		tokenUsage.setValue(earlyOutActionPoint.getPoint());
		tokenUsage.setReconcile(null);
		tokenUsage.setReFlag("Y");
		tokenUsage.setDescription(MAPPER.writeValueAsString(jsonNode));
		tokenUsage.setUserCreate("system");
		tokenUsage.setTimeCreate(DateUtil.getCurrentTime());

		usageTokenDAO.save(tokenUsage);

		log.info("Deducted " + earlyOutActionPoint.getPoint() + " tokens for early out" + " for user: " + userId + ".");

	}

	private void deductUserCubeTokenForBackDateCheckIn(String userId, Timestamp checkIn, Timestamp checkInTimeCreate)
			throws Exception {

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		if (checkIn == null) {
			throw new IllegalArgumentException("Check-in timestamp is required.");
		}

		if (checkInTimeCreate == null) {
			throw new IllegalArgumentException("Check-in time create timestamp is required.");
		}

		ActionType deductType = actionTypeDAO.findById(ACTION_TYPE_DUDUCT);

		if (deductType == null || !"Y".equals(deductType.getActiveStatus())) {
			log.info("Deduct action type is not active. No token deduction will be made for backdate check-in.");
			return;
		}

		ActionPoint backDateActionPoint = actionPointDAO.findById(ACTION_POINT_BACKDATE);

		if (backDateActionPoint == null) {
			throw new IllegalStateException("Backdate action point not found.");
		}

		if (backDateActionPoint.getActiveStatus().equals("N") || backDateActionPoint.getPoint() == 0D) {
			log.info("Backdate action is inactive or has zero points. No deduction will be made.");
			return;
		}

		TokenUsage tokenUsage = new TokenUsage();

		ObjectNode jsonNode = MAPPER.createObjectNode();

		jsonNode.put("type", "deduct");
		jsonNode.put("reason", "ลงเวลาย้อนหลัง");
		jsonNode.put("date", checkIn.toLocalDateTime().format(FORMATTER));

		tokenUsage.setUserId(userId);
		tokenUsage.setActionTypeId(ACTION_TYPE_DUDUCT);
		tokenUsage.setActionPointId(ACTION_POINT_BACKDATE);
		tokenUsage.setValue(backDateActionPoint.getPoint());
		tokenUsage.setReconcile(null);
		tokenUsage.setYear(checkInTimeCreate.toLocalDateTime().getYear());
		tokenUsage.setMonth(checkInTimeCreate.toLocalDateTime().getMonthValue());
		tokenUsage.setReFlag("Y");
		tokenUsage.setDescription(MAPPER.writeValueAsString(jsonNode));
		tokenUsage.setUserCreate("system");
		tokenUsage.setTimeCreate(DateUtil.getCurrentTime());

		usageTokenDAO.save(tokenUsage);

		log.info("Deducted " + backDateActionPoint.getPoint() + " tokens for backdate check-in" + " for user: "
				+ userId);

	}

	private void deductUserCubeTokenForBackDateCheckOut(String userId, Timestamp checkOut, Timestamp checkOutTimeCreate)
			throws Exception {

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		if (checkOut == null) {
			throw new IllegalArgumentException("Check-out timestamp is required.");
		}

		if (checkOutTimeCreate == null) {
			throw new IllegalArgumentException("Check-out time create timestamp is required.");
		}

		ActionType deductType = actionTypeDAO.findById(ACTION_TYPE_DUDUCT);

		if (deductType == null || !"Y".equals(deductType.getActiveStatus())) {
			log.info("Deduct action type is not active. No token deduction will be made for backdate check-out.");
			return;
		}

		ActionPoint backDateActionPoint = actionPointDAO.findById(ACTION_POINT_BACKDATE);

		if (backDateActionPoint == null) {
			throw new IllegalStateException("Backdate action point not found.");
		}

		if (backDateActionPoint.getActiveStatus().equals("N") || backDateActionPoint.getPoint() == 0D) {
			log.info("Backdate action is inactive or has zero points. No deduction will be made.");
			return;
		}

		TokenUsage tokenUsage = new TokenUsage();

		ObjectNode jsonNode = MAPPER.createObjectNode();

		jsonNode.put("type", "deduct");
		jsonNode.put("reason", "ลงเวลาย้อนหลัง");
		jsonNode.put("date", checkOut.toLocalDateTime().format(FORMATTER));

		tokenUsage.setUserId(userId);
		tokenUsage.setActionTypeId(ACTION_TYPE_DUDUCT);
		tokenUsage.setActionPointId(ACTION_POINT_BACKDATE);
		tokenUsage.setValue(backDateActionPoint.getPoint());
		tokenUsage.setReconcile(null);
		tokenUsage.setYear(checkOutTimeCreate.toLocalDateTime().getYear());
		tokenUsage.setMonth(checkOutTimeCreate.toLocalDateTime().getMonthValue());
		tokenUsage.setReFlag("Y");
		tokenUsage.setDescription(MAPPER.writeValueAsString(jsonNode));
		tokenUsage.setUserCreate("system");
		tokenUsage.setTimeCreate(DateUtil.getCurrentTime());

		usageTokenDAO.save(tokenUsage);

		log.info("Deducted " + backDateActionPoint.getPoint() + " tokens for backdate check-out" + " for user: "
				+ userId);

	}

	@Transactional(readOnly = true)
	public String getUserCurrentRankByYear(String userId, int year) throws Exception {

		int currentMonth = LocalDate.now().getMonthValue();

		if (currentMonth == 1) {
			return "--"; // Return "--" if it's January
		}

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		if (year <= 0) {
			throw new IllegalArgumentException("Year must be a positive integer.");
		}

		if (year > LocalDate.now().getYear()) {
			throw new IllegalArgumentException("Year cannot be in the future.");
		}

		List<Map<String, Object>> users = usageTokenDAO.findAccumulatedTokenBalanceForAllUser(year);

		int ranking = 0;
		double previousToken = Double.NaN;

		for (int i = 0; i < users.size(); i++) {

			Map<String, Object> user = users.get(i);

			double token = ((Number) user.get("token")).doubleValue();

			if (Double.compare(token, previousToken) != 0) {
				ranking = i + 1;
				previousToken = token;
			}

			boolean tied = false;

			if (i > 0) {
				double prevToken = ((Number) users.get(i - 1).get("token")).doubleValue();
				tied = Double.compare(token, prevToken) == 0;
			}

			if (i + 1 < users.size()) {
				double nextToken = ((Number) users.get(i + 1).get("token")).doubleValue();
				tied = tied || Double.compare(token, nextToken) == 0;
			}

			String currentUserId = (String) user.get("userId");
			if (userId.equals(currentUserId)) {
				return tied ? "#T" + ranking : "#" + String.valueOf(ranking);
			}

		}

		return "--"; // User not found in the ranking
	}

	@Transactional(readOnly = true)
	public List<Map<String, Object>> getTop10AccumulatedTokenBalance(int year) throws Exception {

		int currentMonth = LocalDate.now().getMonthValue();

		if (currentMonth == 1) {
			return new ArrayList<>(); // Return an empty list if it's January
		}

		List<Map<String, Object>> users = usageTokenDAO.findAccumulatedTokenBalanceForAllUser(year);

		List<Map<String, Object>> result = new ArrayList<>();

		int ranking = 1;
		double previousToken = Double.NaN;

		for (int i = 0; i < users.size(); i++) {

			Map<String, Object> user = users.get(i);

			double token = ((Number) user.get("token")).doubleValue();

			// ==========================================
			// Calculate ranking
			// ==========================================
			if (i > 0 && Double.compare(token, previousToken) != 0) {
				ranking = i + 1;
			}

			previousToken = token;

			// ==========================================
			// Stop after rank 10
			// ==========================================
			if (ranking > 10) {
				break;
			}

			// ==========================================
			// Check tie
			// ==========================================
			boolean tied = false;

			if (i > 0) {

				double prevToken = ((Number) users.get(i - 1).get("token")).doubleValue();

				tied = Double.compare(token, prevToken) == 0;
			}

			if (i + 1 < users.size()) {

				double nextToken = ((Number) users.get(i + 1).get("token")).doubleValue();

				tied = tied || Double.compare(token, nextToken) == 0;
			}

			Map<String, Object> row = new LinkedHashMap<>();

			String userId = (String) user.get("userId");

			row.put("userId", user.get("userId"));
			row.put("employeeId", user.get("employeeId"));
			row.put("nameTh", user.get("nameTh"));
			row.put("nameEn", user.get("nameEn"));
			row.put("token", token);

			row.put("rankDisplay", tied ? "T" + ranking : String.valueOf(ranking));

			row.put("rank", ranking);

			row.put("filePath", user.get("filePath"));

			List<Map<String, Object>> userJobsiteList = jobsiteDAO.getNameSiteListByUserId(userId);

			if (userJobsiteList == null || userJobsiteList.isEmpty()) {
				userJobsiteList = new ArrayList<>();
			}

			row.put("jobsiteList", userJobsiteList);

			result.add(row);
		}

		return result;
	}

	@Transactional(readOnly = true)
	public Double getUserCurrentMonthlyBalance(String userId) throws Exception {

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		LocalDate today = LocalDate.now();
		YearMonth currentMonth = YearMonth.from(today);

		Double monthlyBalance = usageTokenDAO.findMonthlyBalance(userId, currentMonth);

		return monthlyBalance != null ? monthlyBalance : 0D;
	}

	@Transactional(readOnly = true)
	public Double getUserCurrentAccumulatedBalance(String userId) throws Exception {

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		Double accumulatedBalance = usageTokenDAO.findAccumulatedTokenBalance(userId);

		return accumulatedBalance != null ? accumulatedBalance : 0D;
	}

	@Transactional(readOnly = true)
	public Double getUserAccumulatedBalanceByYear(String userId, int year) throws Exception {

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		if (year <= 0) {
			throw new IllegalArgumentException("Year must be a positive integer.");
		}

		if (year > LocalDate.now().getYear()) {
			throw new IllegalArgumentException("Year cannot be in the future.");
		}

		Double accumulatedBalance = usageTokenDAO.findAccumulatedBalanceByYear(userId, year);

		return accumulatedBalance != null ? accumulatedBalance : 0D;
	}
	

	@Transactional(readOnly = true)
	public List<Map<String, Object>> getAllUsersCurrentAccumulatedBalance() throws Exception {

		int currentYear = LocalDate.now().getYear();

		return usageTokenDAO.findAccumulatedTokenBalanceForAllUser(currentYear);
	}

	@Transactional
	public void updateTokenSetting(String target, Integer id, String field, String value) throws Exception {

		if (target == null || value == null) {
			throw new IllegalArgumentException("Invalid update request.");
		}

		switch (target) {

		/*
		 * ========================= Activate Date =========================
		 */
		case "activate_date":
			updateActivateDate(value);
			break;

		/*
		 * ========================= Global Action ========================= id = 1 ->
		 * Get Token id = 2 -> Deduct
		 */
		case "action":
			updateAction(id, field, value);
			break;

		/*
		 * ========================= Employee / System Filter =========================
		 * 
		 */
		case "filter":
			updateFilter(id, field, value);
			break;

		/*
		 * ========================= Gift / Deduct Point =========================
		 */
		case "gift":
		case "deduct":
			updateActionPoint(id, field, value);
			break;

		default:
			throw new IllegalArgumentException("Unknown target: " + target);
		}
	}

	@Transactional(readOnly = true)
	public List<TokenMonthlyLog> getAllTokenMonthlyLogsByYear(int year) throws Exception {
		return tokenMonthlyLogDAO.findByYear(year);
	}

	@Transactional(readOnly = true)
	public List<Map<String, Object>> getTokenMonthlyLogDetailsByLogId(Integer logId) throws Exception {

		if (logId == null || logId <= 0) {
			throw new IllegalArgumentException("Invalid log ID.");
		}

		List<Map<String, Object>> details = tokenMonthlyLogDetailDAO.findByMonitorLogId(logId);

		for (Map<String, Object> detail : details) {

			String userId = (String) detail.get("userId");
			List<Map<String, Object>> userJobsiteList = jobsiteDAO.getNameSiteListByUserId(userId);

			if (userJobsiteList == null || userJobsiteList.isEmpty()) {
				userJobsiteList = new ArrayList<>();
			}

			detail.put("jobsiteList", MAPPER.writeValueAsString(userJobsiteList));
		}

		return details;
	}

	@Transactional
	public void rewardCubeToken(String targetUserId, String givenBy, Double value, String reason) throws Exception {

		TokenUsage usage = new TokenUsage();
		usage.setUserId(targetUserId);
		usage.setActionTypeId(ACTION_TYPE_REWARD); // Reward
		usage.setValue(value);
		usage.setReconcile(null);
		usage.setDescription(null);
		usage.setYear(LocalDate.now().getYear());
		usage.setMonth(LocalDate.now().getMonthValue());
		usage.setReFlag("Y");
		usage.setUserCreate(givenBy);
		usage.setTimeCreate(DateUtil.getCurrentTime());

		usageTokenDAO.save(usage);

		ObjectNode jsonNode = MAPPER.createObjectNode();

		jsonNode.put("type", "add");
		jsonNode.put("reason", "การแจกแต้ม " + reason);
		jsonNode.put("referenceId", usage.getTokenUsageId());

		usage.setDescription(MAPPER.writeValueAsString(jsonNode));

		usageTokenDAO.update(usage);
	}

	@Transactional
	public void returnCubeToken(String userId, String givenBy, Integer transactionId, String reason) throws Exception {

		TokenUsage originalTransaction = usageTokenDAO.findById(transactionId);

		if (originalTransaction == null) {
			throw new IllegalArgumentException(String.format("Transaction with an ID:%d not found.", transactionId));
		}

		if (!"Y".equals(originalTransaction.getReFlag())) {
			throw new IllegalArgumentException("This transaction has already been returned or voided.");
		}

		// check if the original transaction is in the previous month or not

		YearMonth currentMonth = YearMonth.now(ZoneId.of("Asia/Bangkok"));

		YearMonth transactionMonth = YearMonth.of(originalTransaction.getYear(), originalTransaction.getMonth());

		if (transactionMonth.isBefore(currentMonth.minusMonths(1))) {
			throw new IllegalArgumentException("Cannot return transactions older than the previous month.");
		}

		Double returnValue = originalTransaction.getValue();

		TokenUsage usage = new TokenUsage();
		Integer targetActionTypeId = originalTransaction.getActionTypeId() == ACTION_TYPE_REWARD ? ACTION_TYPE_VOID
				: ACTION_TYPE_RETURN;

		ObjectNode jsonNode = MAPPER.createObjectNode();
		ObjectNode descriptionNode = (ObjectNode) MAPPER.readTree(originalTransaction.getDescription());

		if (descriptionNode.has("referenceId")) {
			Integer referenceId = descriptionNode.get("referenceId").asInt();
			jsonNode.put("referenceId", referenceId);
		}

		if (descriptionNode.has("date")) {
			String evetnDate = descriptionNode.get("date").asText();
			jsonNode.put("date", evetnDate);
		}

		usage.setUserId(userId);
		usage.setActionTypeId(targetActionTypeId); // Return or Void
		usage.setValue(returnValue);
		usage.setReconcile(null);
		usage.setYear(transactionMonth.getYear());
		usage.setMonth(transactionMonth.getMonthValue());
		usage.setReFlag("N");

		jsonNode.put("type", targetActionTypeId == ACTION_TYPE_VOID ? "void" : "add");
		jsonNode.put("action", targetActionTypeId == ACTION_TYPE_VOID ? "cancel" : "return");
		jsonNode.put("reason", targetActionTypeId == ACTION_TYPE_VOID ? reason : "ยกเลิก " + reason);

		usage.setDescription(MAPPER.writeValueAsString(jsonNode));
		usage.setUserCreate(givenBy);
		usage.setTimeCreate(DateUtil.getCurrentTime());

		usageTokenDAO.save(usage);

		originalTransaction.setReFlag("N");
		usageTokenDAO.update(originalTransaction);

		String targetUserId = originalTransaction.getUserId();
		recalculateAccumulatedTokenBalance(targetUserId, userId, transactionMonth);

	}

	private void recalculateAccumulatedTokenBalance(String targetUserId, String performBy, YearMonth yearMonth)
			throws Exception {

		Double newReconcileValue = usageTokenDAO.findMonthlyBalance(targetUserId, yearMonth);
		TokenUsage existsAccumulatedToken = usageTokenDAO.findExistsAccumulatedToken(targetUserId, yearMonth);

		if (existsAccumulatedToken != null) {
			existsAccumulatedToken.setReconcile(newReconcileValue);
			existsAccumulatedToken.setTimeUpdate(DateUtil.getCurrentTime());
			existsAccumulatedToken.setUserUpdate(performBy);
			usageTokenDAO.update(existsAccumulatedToken);

		}

		TokenUsageSummary existingSummary = tokenUsageSummaryDAO.findByUserIdAndYearMonth(targetUserId, yearMonth);

		if (existingSummary != null) {
			existingSummary.setMonthlyToken(Math.max(usageTokenDAO.findMonthlyBalance(targetUserId, yearMonth), 0));
			existingSummary.setTotalToken(Math.max(usageTokenDAO.findAccumulatedTokenBalance(targetUserId), 0));
			existingSummary.setTimeUpdate(DateUtil.getCurrentTime());
			existingSummary.setUserUpdate(performBy);
			tokenUsageSummaryDAO.update(existingSummary);
		}
	}

	@Transactional
	public void exchangeMonthlyToken(String userId, Double value) throws Exception {

	    if (userId == null || userId.trim().isEmpty()) {
	        throw new IllegalArgumentException("User ID is required.");
	    }

	    if (value == null || !Double.isFinite(value) || value <= 0) {
	        throw new IllegalArgumentException("Exchange value must be greater than zero.");
	    }

	    LocalDate currentDate = LocalDate.now(ZoneId.of("Asia/Bangkok"));
	    int currentYear = currentDate.getYear();
	    int currentMonth = currentDate.getMonthValue();

	    // 1. ตรวจสอบยอด Carry Over คงเหลือ
	    Double carryOverBalance =
	            usageTokenDAO.findCarryOverBalance(userId, currentYear);

	    if (carryOverBalance == null) {
	        carryOverBalance = 0D;
	    }

	    // 2. ตรวจสอบยอดสะสมของปีปัจจุบัน
	    Double currentYearBalance =
	            usageTokenDAO.findYearlyBalance(userId, currentYear);

	    if (currentYearBalance == null) {
	        currentYearBalance = 0D;
	    }

	    // ป้องกันยอดติดลบจากข้อมูลเดิม
	    carryOverBalance = Math.max(carryOverBalance, 0D);
	    currentYearBalance = Math.max(currentYearBalance, 0D);

	    // 3. ตรวจสอบยอดรวมที่สามารถใช้แลกได้
	    double totalBalance = carryOverBalance + currentYearBalance;

	    if (totalBalance < value) {
	        throw new IllegalArgumentException(
	                "Insufficient token balance for exchange."
	        );
	    }

	    // 4. หัก Carry Over ก่อน
	    double deductCarryOver = Math.min(carryOverBalance, value);

	    // 5. ส่วนที่เหลือจึงหักจากแต้มของปีปัจจุบัน
	    double deductCurrentYear = value - deductCarryOver;

	    // 6. บันทึก Exchange เพียง 1 record
	    ObjectNode description = MAPPER.createObjectNode();
	    description.put("type", "exchange");
	    description.put("reason", "เบิกแต้มบุญ");
	    description.put("carryOverDeduct", deductCarryOver);
	    description.put("currentYearDeduct", deductCurrentYear);

	    TokenUsage exchangeUsage = new TokenUsage();
	    exchangeUsage.setUserId(userId);
	    exchangeUsage.setActionTypeId(ACTION_TYPE_EXCHANGE);
	    exchangeUsage.setValue(value);
	    exchangeUsage.setReconcile(null);
	    exchangeUsage.setDescription(MAPPER.writeValueAsString(description));
	    exchangeUsage.setYear(currentYear);
	    exchangeUsage.setMonth(currentMonth);
	    exchangeUsage.setReFlag("N");
	    exchangeUsage.setUserCreate(userId);
	    exchangeUsage.setTimeCreate(DateUtil.getCurrentTime());

	    usageTokenDAO.save(exchangeUsage);

	    // 7. บันทึกรายการหักจาก Carry Over
	    if (deductCarryOver > 0) {
	        TokenUsage carryOverDeduct = new TokenUsage();
	        carryOverDeduct.setUserId(userId);
	        carryOverDeduct.setActionTypeId(ACTION_TYPE_SPEND_CARRYOVER);
	        carryOverDeduct.setValue(null);
	        carryOverDeduct.setReconcile(deductCarryOver);
	        carryOverDeduct.setDescription(
	                "Carry Over deduction from Exchange"
	        );
	        carryOverDeduct.setYear(currentYear);
	        carryOverDeduct.setMonth(currentMonth);
	        carryOverDeduct.setReFlag("N");
	        carryOverDeduct.setUserCreate(userId);
	        carryOverDeduct.setTimeCreate(DateUtil.getCurrentTime());

	        usageTokenDAO.save(carryOverDeduct);
	    }

	    // 8. บันทึกรายการหักจากแต้มปีปัจจุบัน
	    if (deductCurrentYear > 0) {
	        TokenUsage currentYearDeduct = new TokenUsage();
	        currentYearDeduct.setUserId(userId);
	        currentYearDeduct.setActionTypeId(ACTION_TYPE_SPEND_CURRENT_YEAR);
	        currentYearDeduct.setValue(null);
	        currentYearDeduct.setReconcile(deductCurrentYear);
	        currentYearDeduct.setDescription(
	                "Current Year deduction from Exchange"
	        );
	        currentYearDeduct.setYear(currentYear);
	        currentYearDeduct.setMonth(currentMonth);
	        currentYearDeduct.setReFlag("N");
	        currentYearDeduct.setUserCreate(userId);
	        currentYearDeduct.setTimeCreate(DateUtil.getCurrentTime());

	        usageTokenDAO.save(currentYearDeduct);
	    }
	}

	@Transactional
	public void createRewardItem(String itemName, Double itemToken, Double itemAddedMoney, Integer itemQuantity,
			String itemDescription, String effectiveDate, File cover, String activeFlag, String coverFileName,
			File[] additionalImages, String[] additionalImagesFileName, String userId, String realPath,
			Integer productId) throws Exception {

		// =========================
		// Validation
		// =========================

		if (itemName == null || itemName.trim().isEmpty()) {
			throw new IllegalArgumentException("Item name is required.");
		}

		if (itemToken == null || itemToken <= 0) {
			throw new IllegalArgumentException("Item token value must be greater than zero.");
		}

		if (itemAddedMoney == null || itemAddedMoney < 0) {
			throw new IllegalArgumentException("Item added money must be zero or greater.");
		}

		if (itemQuantity == null || itemQuantity < 0) {
			throw new IllegalArgumentException("Item quantity must be positive.");
		}

		if (itemDescription == null || itemDescription.trim().isEmpty()) {
			throw new IllegalArgumentException("Item description is required.");
		}

		if (effectiveDate == null || effectiveDate.trim().isEmpty()) {
			throw new IllegalArgumentException("Effective date is required.");
		}

		if (cover == null || !cover.exists()) {
			throw new IllegalArgumentException("Cover image file is required.");
		}

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		if (!"Y".equals(activeFlag) && !"N".equals(activeFlag)) {
			throw new IllegalArgumentException("Active flag must be either 'Y' or 'N'.");
		}

		// =========================
		// Parse effective date
		// =========================

		String[] dates = effectiveDate.split("\\s+-\\s+");

		if (dates.length != 2) {
			throw new IllegalArgumentException("Invalid effective date format.");
		}

		Date startDate;
		Date endDate;

		try {

			SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH);
			sdf.setLenient(false);

			startDate = sdf.parse(dates[0].trim());
			endDate = sdf.parse(dates[1].trim());

		} catch (ParseException e) {
			throw new IllegalArgumentException("Invalid effective date format.");
		}

		if (startDate.after(endDate)) {
			throw new IllegalArgumentException("Start date must not be after end date.");
		}

		// =========================
		// Create ItemPrivilege
		// =========================

		ItemPrivilege item = new ItemPrivilege();

		item.setProductId(productId);
		item.setItemName(itemName.trim());
		item.setToken(itemToken);
		item.setAddedMoney(itemAddedMoney);
		item.setQuantity(itemQuantity);
		item.setDetails(itemDescription.trim());

		item.setStartDate(startDate);
		item.setEndDate(endDate);

		item.setActiveFlag(activeFlag);

		item.setUserCreate(userId);

		item.setTimeCreate(DateUtil.getCurrentTime());

		// =========================
		// Save first
		// Get item_id
		// =========================

		itemPrivilegeDAO.save(item);

		Integer itemId = item.getItemId();

		// =========================
		// Upload cover
		// =========================

		List<File> coverFiles = new ArrayList<File>();
		coverFiles.add(cover);

		List<String> coverFileNames = new ArrayList<String>();
		coverFileNames.add(coverFileName);

		List<FileUpload> coverSaved = fileAttachmentService.attach(coverFiles, coverFileNames, "privilegeManagement",
				String.valueOf(itemId), userId, realPath);

		if (coverSaved.isEmpty()) {
			throw new IllegalStateException("Unable to upload cover image.");
		}

		item.setCoverPath(coverSaved.get(0).getPath());

		// =========================
		// Upload additional images
		// =========================

		ArrayNode images = MAPPER.createArrayNode();

		if (additionalImages != null && additionalImages.length > 0) {

			List<File> additionalFiles = Arrays.asList(additionalImages);

			List<String> additionalFileNames = additionalImagesFileName != null
					? Arrays.asList(additionalImagesFileName)
					: new ArrayList<String>();

			List<FileUpload> additionalSaved = fileAttachmentService.attach(additionalFiles, additionalFileNames,
					"privilegeManagement", String.valueOf(itemId), userId, realPath);

			for (FileUpload fileUpload : additionalSaved) {
				images.add(fileUpload.getPath());
			}
		}

		// =========================
		// Save image paths
		// =========================

		item.setImgPath(images.toString());

		item.setTimeUpdate(DateUtil.getCurrentTime());

		itemPrivilegeDAO.update(item);
	}

	@Transactional
	public void updateRewardItem(Integer itemId, String itemName, Double itemToken, Double itemAddedMoney,
			Integer itemQuantity, String itemDescription, String effectiveDate, String activeFlag, File cover,
			String coverFileName, File[] additionalImages, String[] additionalImagesFileName,
			String removedAdditionalImages, String userId, String realPath, Integer producId) throws Exception {

		// =========================
		// Validation
		// =========================

		if (itemId == null) {
			throw new IllegalArgumentException("Item ID is required.");
		}

		if (itemName == null || itemName.trim().isEmpty()) {
			throw new IllegalArgumentException("Item name is required.");
		}

		if (itemToken == null || itemToken <= 0) {
			throw new IllegalArgumentException("Item token value must be greater than zero.");
		}

		if (itemAddedMoney == null || itemAddedMoney < 0) {
			throw new IllegalArgumentException("Item added money must be zero or greater.");
		}

		if (itemQuantity == null || itemQuantity < 0) {
			throw new IllegalArgumentException("Item quantity must be popsitive.");
		}

		if (itemDescription == null || itemDescription.trim().isEmpty()) {
			throw new IllegalArgumentException("Item description is required.");
		}

		if (effectiveDate == null || effectiveDate.trim().isEmpty()) {
			throw new IllegalArgumentException("Effective date is required.");
		}

		if (!"Y".equals(activeFlag) && !"N".equals(activeFlag)) {
			throw new IllegalArgumentException("Active flag must be either 'Y' or 'N'.");
		}

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		// =========================
		// Get existing item
		// =========================

		ItemPrivilege item = itemPrivilegeDAO.findById(itemId);

		if (item == null) {
			throw new IllegalArgumentException("Reward item not found.");
		}

		// =========================
		// Parse effective date
		// =========================

		String[] dates = effectiveDate.split("\\s+-\\s+");

		if (dates.length != 2) {
			throw new IllegalArgumentException("Invalid effective date format.");
		}

		Date startDate;
		Date endDate;

		try {

			SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy", Locale.ENGLISH);

			sdf.setLenient(false);

			startDate = sdf.parse(dates[0].trim());
			endDate = sdf.parse(dates[1].trim());

		} catch (ParseException e) {

			throw new IllegalArgumentException("Invalid effective date format.");
		}

		if (startDate.after(endDate)) {
			throw new IllegalArgumentException("Start date must not be after end date.");
		}

		// =========================
		// Update basic information
		// =========================

		item.setItemName(itemName.trim());
		item.setProductId(producId);
		item.setToken(itemToken);
		item.setAddedMoney(itemAddedMoney);
		item.setQuantity(itemQuantity);
		item.setDetails(itemDescription.trim());
		item.setStartDate(startDate);
		item.setEndDate(endDate);
		item.setActiveFlag(activeFlag);
		item.setUserUpdate(userId);
		item.setTimeUpdate(DateUtil.getCurrentTime());

		// =========================
		// Update Cover Image
		// =========================

		if (cover != null && cover.exists()) {

			List<File> coverFiles = new ArrayList<>();
			coverFiles.add(cover);

			List<String> coverFileNames = new ArrayList<>();
			coverFileNames.add(coverFileName);

			List<FileUpload> coverSaved = fileAttachmentService.attach(coverFiles, coverFileNames,
					"privilegeManagement", String.valueOf(itemId), userId, realPath);

			if (coverSaved.isEmpty()) {
				throw new IllegalStateException("Unable to upload cover image.");
			}

//	        String oldCoverPath = item.getCoverPath();

			item.setCoverPath(coverSaved.get(0).getPath());

			// ถ้ามีระบบลบไฟล์เก่า ค่อยจัดการตรงนี้
			// deleteFile(oldCoverPath, realPath);
		}

		// =========================
		// Existing Additional Images
		// =========================

		List<String> existingImages = new ArrayList<>();

		String imgPath = item.getImgPath();

		if (imgPath != null && !imgPath.trim().isEmpty()) {

			try {

				JsonNode node = MAPPER.readTree(imgPath);

				if (node.isArray()) {

					for (JsonNode image : node) {

						if (image.isTextual()) {
							existingImages.add(image.asText());
						}
					}
				}

			} catch (Exception e) {

				log.error("Invalid imgPath JSON for itemId=" + itemId, e);

				throw new IllegalStateException("Invalid additional image data.");
			}
		}

		// =========================
		// Remove Additional Images
		// =========================

		if (removedAdditionalImages != null && !removedAdditionalImages.trim().isEmpty()) {

			try {

				JsonNode removedNode = MAPPER.readTree(removedAdditionalImages);

				if (removedNode.isArray()) {

					for (JsonNode removed : removedNode) {

						if (!removed.isTextual()) {
							continue;
						}

						String removedPath = removed.asText();

						existingImages.remove(removedPath);

						// ถ้ามีระบบลบไฟล์จริง
						// deleteFile(removedPath, realPath);
					}
				}

			} catch (Exception e) {

				log.error("Invalid removedAdditionalImages for itemId=" + itemId, e);

				throw new IllegalArgumentException("Invalid removed additional image data.");
			}
		}

		// =========================
		// Upload New Additional Images
		// =========================

		if (additionalImages != null && additionalImages.length > 0) {

			List<File> additionalFiles = Arrays.asList(additionalImages);

			List<String> additionalFileNames = additionalImagesFileName != null
					? Arrays.asList(additionalImagesFileName)
					: new ArrayList<String>();

			List<FileUpload> additionalSaved = fileAttachmentService.attach(additionalFiles, additionalFileNames,
					"privilegeManagement", String.valueOf(itemId), userId, realPath);

			for (FileUpload fileUpload : additionalSaved) {

				existingImages.add(fileUpload.getPath());
			}
		}

		// =========================
		// Save Additional Images
		// =========================

		ArrayNode images = MAPPER.createObjectNode().arrayNode();

		for (String path : existingImages) {
			images.add(path);
		}

		item.setImgPath(images.toString());

		// =========================
		// Save
		// =========================

		itemPrivilegeDAO.update(item);
	}

	@Transactional
	public void deleteRewardItem(Integer itemId, String userId, String realPath) throws Exception {

		if (itemId == null || itemId <= 0) {
			throw new IllegalArgumentException("Invalid itemId.");
		}

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		ItemPrivilege item = itemPrivilegeDAO.findById(itemId);

		if (item == null) {
			throw new IllegalArgumentException("Item not found.");
		}

		itemPrivilegeDAO.delete(item);
	}

	@Transactional(readOnly = true)
	public List<ItemPrivilege> getAllRewardItems() throws Exception {

		return itemPrivilegeDAO.findAll();
	}

	public List<Map<String, Object>> getAllRewardItemsWithFavoriteStatus(String userId) throws Exception {

		return itemPrivilegeDAO.findAllWithUserFavorite(userId);
	}

	@Transactional(readOnly = true)
	public List<Map<String, Object>> getUserRedeemHistory(String userId) throws Exception {

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		return userRedeemDAO.findByUserId(userId);
	}

	@Transactional(readOnly = true)
	public List<Map<String, Object>> getAllUserRedeemHistory() throws Exception {

		return userRedeemDAO.findAll();
	}

	@Transactional(readOnly = true)
	public Map<String, Object> getUserRedeemById(Integer redeemId) throws Exception {

		if (redeemId == null || redeemId <= 0) {
			throw new IllegalArgumentException("Invalid redeem ID.");
		}

		Map<String, Object> redeem = userRedeemDAO.findWithReceiveSignatureById(redeemId);

		if (redeem == null) {
			throw new IllegalArgumentException("Redeem record with ID " + redeemId + " not found.");
		}

		List<Map<String, String>> statusLogList = MAPPER.readValue(redeem.get("statusLog").toString(),
				new TypeReference<List<Map<String, String>>>() {
				});

		for (Map<String, String> statusLog : statusLogList) {

			String userId = statusLog.get("userUpdate");

			if (userId != null) {

				User user = userDAO.findById(userId);

				if (user != null) {
					String disaplayName = (user.getNameEN() != null && !user.getNameEN().isEmpty()) ? user.getNameEN()
							: user.getName();
					statusLog.put("displayName", user.getEmployeeId() + " - " + disaplayName);
				} else {
					statusLog.put("displayName", userId);
				}
			}
		}

		redeem.put("statusLog", MAPPER.writeValueAsString(statusLogList));
		return redeem;
	}

	@Transactional
	public void updateRedeemStatus(Integer redeemId, String statusCode, String reason, File signature, String userId,
			String realPath) throws Exception {

		if (redeemId == null || redeemId <= 0) {
			throw new IllegalArgumentException("Invalid redeemId");
		}

		if (statusCode == null || statusCode.isEmpty()) {
			throw new IllegalArgumentException("Invalid status");
		}

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		List<DocStatus> statusList = docStatusDAO.findByPage("cube token");

		UserRedeem redeem = userRedeemDAO.findById(redeemId);

		boolean validStatus = statusList.stream().anyMatch(status -> statusCode.equals(status.getStatusCode()));

		if (!validStatus) {
			throw new IllegalArgumentException("Invalid status code: " + statusCode);
		}

		if (redeem == null) {
			throw new IllegalArgumentException("Redeem record not found for redeemId: " + redeemId);
		}

		String currentStatus = redeem.getRedeemStatus();

		if (!isValidTransition(currentStatus, statusCode)) {
			throw new IllegalArgumentException("Invalid status transition: " + currentStatus + " -> " + statusCode);
		}

		if (STATUS_REDEEM_COMPLETE.equals(statusCode)) {

			if (!redeem.getUserId().equals(userId)) {
				throw new IllegalArgumentException("Only the user who initiated the redeem can complete it.");
			}

			if (signature != null && signature.exists()) {
				List<File> signatureFiles = new ArrayList<>();
				signatureFiles.add(signature);

				List<String> signatureFileNames = new ArrayList<>();
				signatureFileNames.add("signature.png");

				List<FileUpload> signatureSaved = fileAttachmentService.attach(signatureFiles, signatureFileNames,
						"privilegeManagement", String.valueOf(redeemId), userId, realPath);

				if (signatureSaved.isEmpty()) {
					throw new IllegalStateException("Unable to upload signature.");
				}

				FileUpload signatureFile = signatureSaved.get(0);

				User user = userDAO.findById(userId);
				user.setPathSignature(signatureFile.getPath());
				user.setTimeUpdate(DateUtil.getCurrentTime());
				userDAO.update(user);

				redeem.setUserReceive(userId);

			}

			else {

				User user = userDAO.findById(redeem.getUserId());
				String signaturePath = user != null ? user.getPathSignature() : null;

				if (signaturePath == null || signaturePath.trim().isEmpty()) {
					throw new IllegalArgumentException("Signature is required for completing the redeem process.");
				}

				redeem.setUserReceive(userId);

			}

		}

		redeem.setRedeemStatus(statusCode);

		redeem.setUserUpdate(userId);
		redeem.setTimeUpdate(DateUtil.getCurrentTime());

		ArrayNode statusArray;

		if (redeem.getStatusLog() != null && !redeem.getStatusLog().trim().isEmpty()) {

			statusArray = (ArrayNode) MAPPER.readTree(redeem.getStatusLog());

		} else {

			statusArray = MAPPER.createArrayNode();
		}

		ObjectNode statusJson = MAPPER.createObjectNode();

		switch (statusCode) {

		case STATUS_REDEEM_APPROVED:
			redeem.setUserApprove(userId);
			redeem.setTimeApprove(DateUtil.getCurrentTime());
			break;

		case STATUS_REDEEM_RECEIVED:
			redeem.setUserDeliver(userId);
			redeem.setTimeDeliver(DateUtil.getCurrentTime());
			break;

		case STATUS_REDEEM_COMPLETE:
			redeem.setTimeReceive(DateUtil.getCurrentTime());
			break;

		default:
			break;

		}

		statusJson.put("status", statusCode);
		statusJson.put("timeUpdate", DateUtil.getCurrentTime().toString());
		statusJson.put("userUpdate", userId);

		if (reason != null && !reason.isEmpty()) {
			redeem.setDescription(reason);
			statusJson.put("reason", reason);
		}

		statusArray.add(statusJson);

		redeem.setStatusLog(MAPPER.writeValueAsString(statusArray));

		userRedeemDAO.update(redeem);
	}

	private boolean isValidTransition(String currentStatus, String nextStatus) {

		if (currentStatus == null || nextStatus == null) {
			return false;
		}

		// 1 -> 2
		if (STATUS_REDEEM_PENDING.equals(currentStatus) && STATUS_REDEEM_APPROVED.equals(nextStatus)) {
			return true;
		}

		// 2 -> 3
		if (STATUS_REDEEM_APPROVED.equals(currentStatus) && STATUS_REDEEM_RECEIVED.equals(nextStatus)) {
			return true;
		}

		// 3 -> 4
		if (STATUS_REDEEM_RECEIVED.equals(currentStatus) && STATUS_REDEEM_COMPLETE.equals(nextStatus)) {
			return true;
		}

		// 1 -> 5 (Cancel)
		if (STATUS_REDEEM_PENDING.equals(currentStatus) && STATUS_REDEEM_CANCEL.equals(nextStatus)) {
			return true;
		}

		// 2 -> 5 (Cancel)
		if (STATUS_REDEEM_APPROVED.equals(currentStatus) && STATUS_REDEEM_CANCEL.equals(nextStatus)) {
			return true;
		}

		return false;
	}

	@Transactional(readOnly = true)
	public ItemPrivilege getRewardItemById(Integer id) throws Exception {

		if (id == null || id <= 0) {
			throw new IllegalArgumentException("Invalid item ID.");
		}

		ItemPrivilege item = itemPrivilegeDAO.findById(id);

		if (item == null) {
			throw new IllegalArgumentException("Item with ID " + id + " not found.");
		}

		return item;
	}

	@Transactional(readOnly = true)
	public List<Map<String, Object>> getRedeemHistoryByItemId(Integer itemId) throws Exception {

		if (itemId == null || itemId <= 0) {
			throw new IllegalArgumentException("Invalid item ID.");
		}

		return userRedeemDAO.findByItemId(itemId);
	}

	@Transactional
	public void redeemRewardItem(User user, Integer itemId) throws Exception {

	    if (user == null) {
	        throw new IllegalArgumentException("User is required.");
	    }

	    if (itemId == null || itemId <= 0) {
	        throw new IllegalArgumentException("Invalid item ID.");
	    }

	    ItemPrivilege item = itemPrivilegeDAO.findById(itemId);

	    if (item == null) {
	        throw new IllegalArgumentException("Item not found.");
	    }

	    if (item.getQuantity() <= 0) {
	        throw new IllegalArgumentException("Item is out of stock.");
	    }

	    if (item.getActiveFlag() == null || !"Y".equals(item.getActiveFlag())) {
	        throw new IllegalArgumentException("Item is not active.");
	    }

	    String userId = user.getId();

	    LocalDate today = LocalDate.now(ZoneId.of("Asia/Bangkok"));

	    LocalDate startDate = item.getStartDate().toInstant()
	            .atZone(ZoneId.of("Asia/Bangkok"))
	            .toLocalDate();

	    LocalDate endDate = item.getEndDate().toInstant()
	            .atZone(ZoneId.of("Asia/Bangkok"))
	            .toLocalDate();

	    if (today.isBefore(startDate) || today.isAfter(endDate)) {
	        throw new IllegalArgumentException(
	                "Item is not available for redemption today."
	        );
	    }

	    int currentYear = today.getYear();
	    int currentMonth = today.getMonthValue();

	    double rewardCost = item.getToken().doubleValue();

	    // 1. ตรวจสอบยอด Carry Over
	    Double carryOverBalance =
	            usageTokenDAO.findCarryOverBalance(userId, currentYear);

	    if (carryOverBalance == null) {
	        carryOverBalance = 0D;
	    }

	    // 2. ตรวจสอบยอดสะสมของปีปัจจุบัน
	    Double currentYearBalance =
	            usageTokenDAO.findYearlyBalance(userId, currentYear);

	    if (currentYearBalance == null) {
	        currentYearBalance = 0D;
	    }

	    carryOverBalance = Math.max(carryOverBalance, 0D);
	    currentYearBalance = Math.max(currentYearBalance, 0D);

	    // 3. ตรวจสอบยอดรวม
	    if (carryOverBalance + currentYearBalance < rewardCost) {
	        throw new IllegalArgumentException(
	                "Insufficient token balance."
	        );
	    }

	    // 4. หัก Carry Over ก่อน
	    double deductCarryOver = Math.min(carryOverBalance, rewardCost);

	    // 5. หักส่วนที่เหลือจากยอดปีปัจจุบัน
	    double deductCurrentYear = rewardCost - deductCarryOver;

	    // 6. ลดจำนวนสินค้าคงเหลือ
	    item.setQuantity(item.getQuantity() - 1);
	    item.setUserUpdate(userId);
	    item.setTimeUpdate(DateUtil.getCurrentTime());

	    itemPrivilegeDAO.update(item);

	    // 7. บันทึก REDEEM เพียง 1 record
	    ObjectNode jsonNode = MAPPER.createObjectNode();

	    jsonNode.put("type", "redeem");
	    jsonNode.put("reason", "Redeem reward item: " + item.getItemName());
	    jsonNode.put("itemId", itemId);
	    jsonNode.put("carryOverDeduct", deductCarryOver);
	    jsonNode.put("currentYearDeduct", deductCurrentYear);

	    TokenUsage usage = new TokenUsage();

	    usage.setUserId(userId);
	    usage.setActionTypeId(ACTION_TYPE_REDEEM);
	    usage.setValue(rewardCost);
	    usage.setReconcile(null);
	    usage.setYear(currentYear);
	    usage.setMonth(currentMonth);
	    usage.setReFlag("N");
	    usage.setDescription(MAPPER.writeValueAsString(jsonNode));
	    usage.setUserCreate(userId);
	    usage.setTimeCreate(DateUtil.getCurrentTime());

	    usageTokenDAO.save(usage);

	    // 8. บันทึกการหัก Carry Over
	    if (deductCarryOver > 0) {
	        TokenUsage carryOverDeduct = new TokenUsage();

	        carryOverDeduct.setUserId(userId);
	        carryOverDeduct.setActionTypeId(ACTION_TYPE_SPEND_CARRYOVER);
	        carryOverDeduct.setValue(null);
	        carryOverDeduct.setReconcile(deductCarryOver);
	        carryOverDeduct.setDescription(
	                "Carry Over deduction from Redeem item: " + item.getItemName()
	        );
	        carryOverDeduct.setYear(currentYear);
	        carryOverDeduct.setMonth(currentMonth);
	        carryOverDeduct.setReFlag("N");
	        carryOverDeduct.setUserCreate(userId);
	        carryOverDeduct.setTimeCreate(DateUtil.getCurrentTime());

	        usageTokenDAO.save(carryOverDeduct);
	    }

	    // 9. บันทึกการหัก Token ของปีปัจจุบัน
	    if (deductCurrentYear > 0) {
	        TokenUsage currentYearDeduct = new TokenUsage();

	        currentYearDeduct.setUserId(userId);
	        currentYearDeduct.setActionTypeId(ACTION_TYPE_SPEND_CURRENT_YEAR);
	        currentYearDeduct.setValue(null);
	        currentYearDeduct.setReconcile(deductCurrentYear);
	        currentYearDeduct.setDescription(
	                "Current Year deduction from Redeem item: " + item.getItemName()
	        );
	        currentYearDeduct.setYear(currentYear);
	        currentYearDeduct.setMonth(currentMonth);
	        currentYearDeduct.setReFlag("N");
	        currentYearDeduct.setUserCreate(userId);
	        currentYearDeduct.setTimeCreate(DateUtil.getCurrentTime());

	        usageTokenDAO.save(currentYearDeduct);
	    }

	    // 10. บันทึกประวัติการแลกของรางวัล
	    UserRedeem redeem = new UserRedeem();

	    redeem.setUserId(userId);
	    redeem.setItemId(item.getItemId());
	    redeem.setCash(item.getAddedMoney());
	    redeem.setToken(item.getToken());
	    redeem.setRedeemStatus(STATUS_REDEEM_PENDING);

	    ObjectNode statusJson = MAPPER.createObjectNode()
	            .put("status", STATUS_REDEEM_PENDING)
	            .put("timeUpdate", DateUtil.getCurrentTime().toString())
	            .put("userUpdate", userId);

	    ArrayNode statusArray = MAPPER.createArrayNode().add(statusJson);

	    redeem.setStatusLog(MAPPER.writeValueAsString(statusArray));
	    redeem.setUserCreate(userId);
	    redeem.setTimeCreate(DateUtil.getCurrentTime());

	    userRedeemDAO.save(redeem);

	    log.info(
	            "User " + userId + " redeemed reward item " + item.getItemName()
	            + " costing " + rewardCost + " tokens. Carry Over deducted: "
	            + deductCarryOver + ", Current Year deducted: " + deductCurrentYear
	    );
	}

	@Transactional
	public ItemPrivilege updateRewardItemActiveFlag(Integer itemId, String activeFlag, String userId) throws Exception {

		if (!"Y".equals(activeFlag) && !"N".equals(activeFlag)) {
			throw new IllegalArgumentException("Active flag must be either 'Y' or 'N'.");
		}

		if (itemId == null || itemId <= 0) {
			throw new IllegalArgumentException("Invalid item ID.");
		}

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		ItemPrivilege item = itemPrivilegeDAO.findById(itemId);

		if (item == null) {
			throw new IllegalArgumentException("Item with ID " + itemId + " not found.");
		}

		item.setActiveFlag(activeFlag);
		item.setUserUpdate(userId);
		item.setTimeUpdate(DateUtil.getCurrentTime());

		itemPrivilegeDAO.update(item);

		return item;

	}

	@Transactional
	public boolean toggleFavorite(String userId, Integer itemId) throws Exception {

		if (userId == null || userId.trim().isEmpty()) {
			throw new IllegalArgumentException("User ID is required.");
		}

		if (itemId == null || itemId <= 0) {
			throw new IllegalArgumentException("Invalid item ID.");
		}

		UserFavorite favorite = userFavoriteDAO.findByUserIdAndItemId(userId, itemId);

		if (favorite != null) {
			// มีอยู่แล้ว → ยกเลิก Favorite
			userFavoriteDAO.delete(favorite);
			return false;
		}

		// ยังไม่มี → เพิ่ม Favorite
		UserFavorite newFavorite = new UserFavorite();

		newFavorite.setUserId(userId);
		newFavorite.setItemId(itemId);
		newFavorite.setUserCreate(userId);
		newFavorite.setUserUpdate(userId);
		newFavorite.setTimeCreate(DateUtil.getCurrentTime());
		newFavorite.setTimeUpdate(DateUtil.getCurrentTime());

		userFavoriteDAO.save(newFavorite);

		return true;
	}

	private boolean isSettingActive(TokenSetting setting) {
		return setting != null && "active".equalsIgnoreCase(setting.getStatus());
	}

	private Map<String, Object> buildFilterSetting(TokenSetting setting) {

		Map<String, Object> result = new LinkedHashMap<>();

		if (setting == null) {
			result.put("id", null);
			result.put("active", false);
			return result;
		}

		result.put("id", setting.getSettingId());
		result.put("active", isSettingActive(setting));

		return result;
	}

	private void getStyle(Map<String, Object> row) {
		String name = (String) row.get("name_en");

		switch (name) {
		case "Permanent Employee":
			row.put("style", "primary");
			row.put("icon", "ki-profile-user");
			break;

		case "Contract Employee":
			row.put("style", "success");
			row.put("icon", "ki-profile-circle");
			break;

		case "Intern":
			row.put("style", "info");
			row.put("icon", "ki-teacher");
			break;

		case "Check-In Late":
			row.put("style", "warning");
			row.put("icon", "ki-time");
			break;

		case "Early Out":
			row.put("style", "success");
			row.put("icon", "ki-brifecase-timer");
			break;

		case "Leave":
			row.put("style", "info");
			row.put("icon", "ki-calendar-8");
			break;

		case "Backdate":
			row.put("style", "primary");
			row.put("icon", "ki-calendar-edit");
			break;

		case "No Record":
			row.put("style", "danger");
			row.put("icon", "ki-calendar-remove");
			break;

		case "GPS Check-In/Out":
			row.put("style", "warning");
			row.put("icon", "ki-map");
			break;

		default:
			break;
		}
	}

	private void updateActivateDate(String value) throws Exception {

		int day;

		try {

			day = Integer.parseInt(value);

		} catch (NumberFormatException e) {
			throw new IllegalArgumentException("Activate date must be a number.");
		}

		if (day < 1 || day > 31) {
			throw new IllegalArgumentException("Activate date must be between 1 and 31.");
		}

		TokenSetting setting = tokenSettingDAO.findByTypeAndTypeName("activate_date", "Day");

		if (setting == null) {
			throw new IllegalArgumentException("Activate date setting not found.");
		}

		setting.setStatus(String.valueOf(day));

		setting.setUserUpdate("cft.admin");
		setting.setTimeUpdate(DateUtil.getCurrentTime());

		tokenSettingDAO.save(setting);
	}

	private void updateAction(Integer id, String field, String value) throws Exception {

		if (id == null) {
			throw new IllegalArgumentException("Action type ID is required.");
		}

		if (!"active".equals(field)) {
			throw new IllegalArgumentException("Invalid action field.");
		}

		if (id != 1 && id != 2) {
			throw new IllegalArgumentException("Invalid action type.");
		}

		if (!"Y".equals(value) && !"N".equals(value)) {
			throw new IllegalArgumentException("Active value must be Y or N.");
		}

		ActionType actionType = actionTypeDAO.findById(id);

		if (actionType == null) {
			throw new IllegalArgumentException("Action type not found.");
		}

		actionType.setActiveStatus(value);
		actionType.setUserUpdate("cft.admin");
		actionType.setTimeUpdate(DateUtil.getCurrentTime());

		actionTypeDAO.save(actionType);
	}

	private void updateFilter(Integer id, String field, String value) throws Exception {

		if (id == null) {
			throw new IllegalArgumentException("Filter ID is required.");
		}

		if (!"active".equals(field)) {
			throw new IllegalArgumentException("Invalid filter field.");
		}

		if (!"Active".equals(value) && !"Disable".equals(value)) {
			throw new IllegalArgumentException("Filter value must be \"Active\" or \"Disable\".");
		}

		TokenSetting setting = tokenSettingDAO.findById(id);

		if (setting == null) {
			throw new IllegalArgumentException("Filter setting not found.");
		}

		setting.setStatus(value);

		setting.setUserUpdate("cft.admin");
		setting.setTimeUpdate(DateUtil.getCurrentTime());

		tokenSettingDAO.save(setting);
	}

	private void updateActionPoint(Integer id, String field, String value) throws Exception {

		if (id == null) {
			throw new IllegalArgumentException("Action point ID is required.");
		}

		ActionPoint actionPoint = actionPointDAO.findById(id);

		if (actionPoint == null) {
			throw new IllegalArgumentException("Action point not found.");
		}

		switch (field) {

		case "point":

			double point;

			try {
				point = Double.parseDouble(value);
			} catch (NumberFormatException e) {
				throw new IllegalArgumentException("Point must be a number.");
			}

			if (point < 0) {
				throw new IllegalArgumentException("Point cannot be negative.");
			}

			actionPoint.setPoint(point);

			break;

		case "active":

			if (!"Y".equals(value) && !"N".equals(value)) {
				throw new IllegalArgumentException("Active value must be Y or N.");
			}

			actionPoint.setActiveStatus(value);

			break;

		default:

			throw new IllegalArgumentException("Invalid action point field.");
		}

		actionPoint.setUserUpdate("cft.admin");
		actionPoint.setTimeUpdate(DateUtil.getCurrentTime());

		actionPointDAO.save(actionPoint);
	}

	private String getEmployeeTypeId(String typeName) throws Exception {

		if (typeName == null || typeName.trim().isEmpty()) {
			return null;
		}

		switch (typeName.toLowerCase()) {

		case "permanent employee":
			return "1";

		case "contract employee":
			return "2";

		case "intern":
			return "3";

		default:
			return null;
		}
	}

	private boolean isSettingActive(List<TokenSetting> settings, String type, String typeName) {

		return settings.stream().filter(s -> type.equalsIgnoreCase(s.getType()))
				.filter(s -> typeName.equalsIgnoreCase(s.getTypeName()))
				.anyMatch(s -> "Active".equalsIgnoreCase(s.getStatus()));
	}

	private double getDouble(Map<String, Object> row, String key) {

		Object value = row.get(key);

		if (value == null) {
			return 0D;
		}

		return ((Number) value).doubleValue();
	}

	private boolean isLate(Timestamp checkin, String workTimeStart) {

		if (checkin == null || workTimeStart == null) {
			return false;
		}

		LocalTime actualCheckIn = checkin.toLocalDateTime().toLocalTime();

		LocalTime workStart = parseTime(workTimeStart);

		return workStart != null && actualCheckIn.isAfter(workStart);
	}

	private boolean isEarlyOut(Timestamp checkout, String workTimeEnd) {

		if (checkout == null || workTimeEnd == null) {
			return false;
		}

		LocalTime actualCheckOut = checkout.toLocalDateTime().toLocalTime();

		LocalTime workEnd = parseTime(workTimeEnd);

		return workEnd != null && actualCheckOut.isBefore(workEnd);
	}

	private boolean isBackdated(Timestamp workTime, Timestamp timeCreate, String description, LocalDate targetDate)
			throws Exception {

		// ไม่มี record
		if (workTime == null) {
			return false;
		}

		// ไม่มี create time
		if (timeCreate == null) {
			return false;
		}

		// ต้องมี description
		if (description == null || description.trim().isEmpty()) {

			return false;
		}

		// เวลา work กับเวลาที่สร้างต้องไม่ตรงกัน
		if (workTime.equals(timeCreate)) {
			return false;
		}

		LocalDate createDate = timeCreate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

		/*
		 * จำนวนวันทำการที่ผ่านไประหว่าง targetDate -> createDate
		 */
		int businessDays = countBusinessDays(targetDate, createDate);

		/*
		 * ลงย้อนหลัง 0 หรือ 1 วันทำการ ไม่ถือเป็น Backdate ที่ต้องหัก Token
		 */
		if (businessDays <= 1) {

			return false;
		}

		return true;
	}

	private int countBusinessDays(LocalDate from, LocalDate to) throws Exception {

		if (!from.isBefore(to)) {
			return 0;
		}

		int count = 0;

		LocalDate current = from.plusDays(1);

		while (!current.isAfter(to)) {

			DayOfWeek dayOfWeek = current.getDayOfWeek();

			// ข้าม Saturday / Sunday
			if (dayOfWeek != DayOfWeek.SATURDAY && dayOfWeek != DayOfWeek.SUNDAY) {

				Date currentDate = Date.from(current.atStartOfDay(ZoneId.systemDefault()).toInstant());

				// ข้าม Holiday
				if (!holidayDAO.isHoliday(currentDate)) {
					count++;
				}
			}

			current = current.plusDays(1);
		}

		return count;
	}

	private LocalTime parseTime(String time) {

		if (time == null || time.trim().isEmpty()) {
			return null;
		}

		String[] parts = time.trim().split(":");

		int hour = Integer.parseInt(parts[0]);
		int minute = Integer.parseInt(parts[1]);

		return LocalTime.of(hour, minute);
	}

	private static class DistributionData {

		private final List<TokenSetting> settings;
		private final List<ActionPoint> giftPoints;

		private final boolean allowActive;
		private final boolean allowProbation;
		private final boolean allowExcluded;
		private final boolean allowIntern;
		private final boolean allowEnable;
		private final boolean allowDisable;

		private final Integer monitorLogId;

		public DistributionData(List<TokenSetting> settings, List<ActionPoint> giftPoints, boolean allowActive,
				boolean allowProbation, boolean allowExcluded, boolean allowIntern, boolean allowEnable,
				boolean allowDisable, Integer monitorLogId) {

			this.settings = settings;
			this.giftPoints = giftPoints;

			this.allowActive = allowActive;
			this.allowProbation = allowProbation;
			this.allowExcluded = allowExcluded;
			this.allowIntern = allowIntern;
			this.allowEnable = allowEnable;
			this.allowDisable = allowDisable;

			this.monitorLogId = monitorLogId;
		}

		public List<TokenSetting> getSettings() {
			return settings;
		}

		public List<ActionPoint> getGiftPoints() {
			return giftPoints;
		}

		public boolean isAllowActive() {
			return allowActive;
		}

		public boolean isAllowProbation() {
			return allowProbation;
		}

		public boolean isAllowExcluded() {
			return allowExcluded;
		}

		public boolean isAllowIntern() {
			return allowIntern;
		}

		public boolean isAllowEnable() {
			return allowEnable;
		}

		public boolean isAllowDisable() {
			return allowDisable;
		}

		public Integer getMonitorLogId() {
			return monitorLogId;
		}
	}

}