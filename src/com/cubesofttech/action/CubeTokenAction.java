package com.cubesofttech.action;

import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.model.User;
import com.cubesofttech.service.CubeTokenService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.opensymphony.xwork2.ActionSupport;

public class CubeTokenAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(CubeTokenAction.class);
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	HttpSession session = request.getSession();

	@Autowired
	private CubeTokenService cubeTokenService;

	private String target;
	private Integer id;
	private String field;
	private String value;
	private String userId;
	private String reason;
	private String transactionId;

	private Map<String, Object> result;
	private Map<String, Object> userInfo;

	public String cubetokenManagementPage() {

		try {
			User user = (User) session.getAttribute("user");

			if (user == null) {
				log.error("User not logged in");
				return LOGIN;
			}

			Integer currentYear = LocalDate.now().getYear();

			request.setAttribute("tokenSummary", cubeTokenService.getTokenSummaryForAllUsers(currentYear));

			return SUCCESS;

		} catch (Exception e) {

			log.error("Error in cubetokenManagementPage: " + e.getMessage(), e);
			return ERROR;

		}
	}

	public String returnCubeTokenPage() {

		try {

			User user = (User) session.getAttribute("user");

			if (user == null) {
				log.error("User not logged in");
				return LOGIN;
			}

			String targetUserId = getTargetUserId(request, user);

			userInfo = cubeTokenService.getUserInfo(targetUserId);

			return SUCCESS;

		} catch (Exception e) {

			log.error("Error in listTokenHistoryPage: " + e.getMessage(), e);
			return ERROR;
		}
	}

	public String cubeTokenSettingPage() {

		try {

			if (session.getAttribute("user") == null) {
				log.error("User not logged in");
				return LOGIN;
			}

			request.setAttribute("tokenSettingPageData", cubeTokenService.getTokenSettingPageData());
			return SUCCESS;

		} catch (Exception e) {

			log.error("Error in listTokenSetting: " + e.getMessage(), e);

			return ERROR;
		}
	}

	public String myCubeTokenPage() {

		try {

			User user = (User) session.getAttribute("user");

			if (user == null) {
				log.error("User not logged in");
				return LOGIN;
			}

			String targetUserId = getTargetUserId(request, user);

			userInfo = cubeTokenService.getUserInfo(targetUserId);

			return SUCCESS;

		} catch (Exception e) {

			log.error("Error in listTokenHistoryPage: " + e.getMessage(), e);
			return ERROR;
		}
	}

	public String exchangeMonthlyToken() {

		try {

			response.setContentType("application/json;charset=UTF-8");
			User user = (User) session.getAttribute("user");

			if (user == null) {

				log.error("User not logged in");
				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
				Map<String, Object> errorResult = new LinkedHashMap<>();

				errorResult.put("success", false);
				errorResult.put("message", "User not logged in");

				new ObjectMapper().writeValue(response.getWriter(), errorResult);

				return NONE;
			}

			String targetUserId = user.getId();

			Double tokenValue = Double.parseDouble(value);

			cubeTokenService.exchangeMonthlyToken(targetUserId, tokenValue);

			response.setStatus(HttpServletResponse.SC_CREATED);
			result = new LinkedHashMap<>();
			result.put("success", true);
			result.put("message", "Monthly token exchanged successfully");

			new ObjectMapper().writeValue(response.getWriter(), result);

			return NONE;

		} catch (IllegalArgumentException e) {

			log.error("Invalid token value: " + e.getMessage(), e);

			try {
				response.setContentType("application/json;charset=UTF-8");
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				Map<String, Object> errorResult = new LinkedHashMap<>();

				errorResult.put("success", false);
				errorResult.put("message", e.getMessage());

				new ObjectMapper().writeValue(response.getWriter(), errorResult);

			} catch (Exception ex) {

				log.error("Error writing response in exchangeMonthlyToken: ", ex);

			}

			return NONE;

		}

		catch (Exception e) {

			log.error("Error in exchangeMonthlyToken: " + e.getMessage(), e);

			try {
				response.setContentType("application/json;charset=UTF-8");
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				Map<String, Object> errorResult = new LinkedHashMap<>();

				errorResult.put("success", false);
				errorResult.put("message", e.getMessage());

				new ObjectMapper().writeValue(response.getWriter(), errorResult);

			} catch (Exception ex) {

				log.error("Error writing response in exchangeMonthlyToken: ", ex);

			}

			return NONE;
		}
	}

	public String getTokenSummaryForAllUsers() throws Exception {

		try {
			response.setContentType("application/json;charset=UTF-8");

			if (session.getAttribute("user") == null) {

				Map<String, Object> errorResult = new LinkedHashMap<>();

				result.put("success", false);
				result.put("message", "User not logged in");

				new ObjectMapper().writeValue(response.getWriter(), errorResult);

				return NONE;
			}

			String yearParam = request.getParameter("year");

			if (yearParam == null || yearParam.isEmpty()) {
				yearParam = String.valueOf(LocalDate.now().getYear());
			}

			int year = Integer.parseInt(yearParam);

			List<Map<String, Object>> data = cubeTokenService.getTokenSummaryForAllUsers(year);

			Map<String, Object> result = new LinkedHashMap<>();

			result.put("success", true);
			result.put("data", data);

			new ObjectMapper().writeValue(response.getWriter(), result);

			return NONE;

		} catch (Exception e) {

			log.error("Error in someMethod: ", e);

			Map<String, Object> errorResult = new LinkedHashMap<>();

			result.put("success", false);
			result.put("message", "User not logged in");

			new ObjectMapper().writeValue(response.getWriter(), errorResult);

			return NONE;
		}

	}

	public String updateTokenSetting() {

		try {

			cubeTokenService.updateTokenSetting(target, id, field, value);

			result = new LinkedHashMap<>();
			result.put("success", true);

			return SUCCESS;

		} catch (Exception e) {

			log.error("Update token setting failed", e);

			result = new LinkedHashMap<>();
			result.put("success", false);
			result.put("message", e.getMessage());

			return SUCCESS;
		}
	}

	public String rewardCubeToken() {

		response.setContentType("application/json;charset=UTF-8");
		Map<String, Object> result = new LinkedHashMap<>();

		try {

			User user = (User) session.getAttribute("user");

			if (user == null) {

				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

				result.put("success", false);
				result.put("message", "User not logged in");

				new ObjectMapper().writeValue(response.getWriter(), result);

				return NONE;
			}

			String givenBy = user.getId();

			String targetUserId = userId;

			if (targetUserId == null || targetUserId.trim().isEmpty()) {
				targetUserId = user.getId();
			}

			// Validate value
			if (value == null || value.trim().isEmpty()) {

				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

				result.put("success", false);
				result.put("message", "Token value is required");

				new ObjectMapper().writeValue(response.getWriter(), result);

				return NONE;
			}

			Double tokenValue = Double.parseDouble(value);

			if (tokenValue <= 0) {

				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

				result.put("success", false);
				result.put("message", "Token value must be greater than 0");

				new ObjectMapper().writeValue(response.getWriter(), result);

				return NONE;
			}

			// Validate reason
			if (reason == null || reason.trim().isEmpty()) {

				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

				result.put("success", false);
				result.put("message", "Reason is required");

				new ObjectMapper().writeValue(response.getWriter(), result);

				return NONE;
			}

			log.info("Reward token: targetUserId=" + targetUserId + ", value=" + tokenValue + ", reason=" + reason);

			// เรียก service
			cubeTokenService.rewardCubeToken(targetUserId, givenBy, tokenValue, reason);

			result.put("success", true);
			result.put("message", "Cube Token rewarded successfully");

			new ObjectMapper().writeValue(response.getWriter(), result);

			return NONE;

		} catch (NumberFormatException e) {

			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

			result.put("success", false);
			result.put("message", "Invalid token value");

			try {
				new ObjectMapper().writeValue(response.getWriter(), result);
			} catch (Exception ex) {
				log.error("Error writing response", ex);
			}

			return NONE;

		} catch (Exception e) {

			log.error("Error in rewardCubeToken: ", e);

			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

			result.put("success", false);
			result.put("message", "Internal server error");

			try {
				new ObjectMapper().writeValue(response.getWriter(), result);
			} catch (Exception ex) {
				log.error("Error writing response", ex);
			}

			return NONE;
		}
	}

	public String returnCubeToken() {

		response.setContentType("application/json;charset=UTF-8");

		Map<String, Object> result = new LinkedHashMap<>();

		try {

			User user = (User) session.getAttribute("user");

			if (user == null) {

				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

				result.put("success", false);
				result.put("message", "User not logged in");

				new ObjectMapper().writeValue(response.getWriter(), result);

				return NONE;
			}

			String givenBy = user.getId();

			String targetUserId = userId;

			if (targetUserId == null || targetUserId.trim().isEmpty()) {

				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

				result.put("success", false);
				result.put("message", "User ID is required");

				new ObjectMapper().writeValue(response.getWriter(), result);

				return NONE;
			}

			// Validate transaction ID
			if (transactionId == null) {

				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

				result.put("success", false);
				result.put("message", "Transaction ID is required");

				new ObjectMapper().writeValue(response.getWriter(), result);

				return NONE;
			}

			// Validate reason
			if (reason == null || reason.trim().isEmpty()) {

				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

				result.put("success", false);
				result.put("message", "Reason is required");

				new ObjectMapper().writeValue(response.getWriter(), result);

				return NONE;
			}

			log.info("Return token: targetUserId=" + targetUserId + ", transactionId=" + transactionId + ", reason="
					+ reason);
			
			Integer transactionIdInt = Integer.parseInt(transactionId);

			cubeTokenService.returnCubeToken(targetUserId, givenBy, transactionIdInt, reason);

			result.put("success", true);
			result.put("message", "Cube Token returned successfully");

			new ObjectMapper().writeValue(response.getWriter(), result);

			return NONE;

		} catch (IllegalArgumentException e) {

			log.error("Error in returnCubeToken: ", e);

			response.setStatus(HttpServletResponse.SC_NOT_FOUND);

			result.put("success", false);
			result.put("message", e.getMessage());

			try {

				new ObjectMapper().writeValue(response.getWriter(), result);

			} catch (Exception ex) {

				log.error("Error writing response", ex);
			}

			return NONE;
			
		}
		
		catch (Exception e) {

			log.error("Error in returnCubeToken: ", e);

			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

			result.put("success", false);
			result.put("message", "Internal server error");

			try {

				new ObjectMapper().writeValue(response.getWriter(), result);

			} catch (Exception ex) {

				log.error("Error writing response", ex);
			}

			return NONE;
		}
	}

	private String getTargetUserId(HttpServletRequest request, User user) {

		Set<String> userAuthority = (Set<String>) session.getAttribute("userAuthority");

		boolean canViewAll = userAuthority != null && userAuthority.contains("cubetoken.viewall");

		String userIdParam = request.getParameter("userId");

		if (canViewAll && userIdParam != null && !userIdParam.trim().isEmpty()) {

			return userIdParam.trim();
		}

		return user.getId();
	}

	public String listTokenHistory() throws Exception {

		try {

			response.setContentType("application/json;charset=UTF-8");
			User user = (User) session.getAttribute("user");

			if (user == null) {

				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

				Map<String, Object> errorResult = new LinkedHashMap<>();
				errorResult.put("success", false);
				errorResult.put("message", "User not logged in");

				new ObjectMapper().writeValue(response.getWriter(), errorResult);

				return NONE;
			}

			String yearParam = request.getParameter("year");

			if (yearParam == null || yearParam.isEmpty()) {

				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

				Map<String, Object> errorResult = new LinkedHashMap<>();
				errorResult.put("success", false);
				errorResult.put("message", "Year parameter is required");

				new ObjectMapper().writeValue(response.getWriter(), errorResult);

				return NONE;
			}

			int year = Integer.parseInt(yearParam);

			String targetUserId = getTargetUserId(request, user);

			List<Map<String, Object>> transactions = cubeTokenService.getUserTokenTransactionByYear(targetUserId, year);
			Double currentBalance = cubeTokenService.getUserCurrentMonthlyBalance(targetUserId);
			Double accumulatedBalance = cubeTokenService.getUserAccumulatedBalance(targetUserId);

			Map<String, Object> result = new LinkedHashMap<>();

			result.put("success", true);
			result.put("data", transactions);
			result.put("currentBalance", currentBalance);
			result.put("accumulatedBalance", accumulatedBalance);

			new ObjectMapper().writeValue(response.getWriter(), result);

			return NONE;

		} catch (NumberFormatException e) {

			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

			Map<String, Object> errorResult = new LinkedHashMap<>();

			errorResult.put("success", false);
			errorResult.put("message", "Invalid year parameter");

			try {

				response.setContentType("application/json;charset=UTF-8");
				new ObjectMapper().writeValue(response.getWriter(), errorResult);

			} catch (Exception ex) {

				log.error("Error writing response", ex);

			}

			return NONE;
		}

		catch (IllegalArgumentException e) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);

			Map<String, Object> errorResult = new LinkedHashMap<>();
			errorResult.put("success", false);
			errorResult.put("message", e.getMessage());

			try {
				response.setContentType("application/json;charset=UTF-8");
				new ObjectMapper().writeValue(response.getWriter(), errorResult);
			} catch (Exception ex) {
				log.error("Error writing response", ex);
			}

			return NONE;
		}

		catch (Exception e) {

			log.error("Error in listTokenHistory: ", e);

			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

			Map<String, Object> errorResult = new LinkedHashMap<>();
			errorResult.put("success", false);
			errorResult.put("message", "Internal server error");

			try {
				response.setContentType("application/json;charset=UTF-8");
				new ObjectMapper().writeValue(response.getWriter(), errorResult);
			} catch (Exception ex) {
				log.error("Error writing response", ex);
			}

			return NONE;
		}
	}

	public String getTokenAvailableYears() throws Exception {

		try {

			response.setContentType("application/json;charset=UTF-8");

			User user = (User) session.getAttribute("user");
			Map<String, Object> result = new LinkedHashMap<>();

			if (user == null) {

				result.put("success", false);
				result.put("message", "User not logged in");

				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

				return NONE;
			}

			String targetUserId = getTargetUserId(request, user);

			List<Integer> availableYears = cubeTokenService.getTokenAvailableYears(targetUserId);

			result.put("success", true);
			result.put("data", availableYears);

			new ObjectMapper().writeValue(response.getWriter(), result);

			return NONE;

		} catch (Exception e) {

			log.error("Error in getTokenAvailableYears: ", e);

			Map<String, Object> result = new LinkedHashMap<>();

			result.put("success", false);
			result.put("message", "Internal server error");

			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

			new ObjectMapper().writeValue(response.getWriter(), result);

			return NONE;
		}
	}

	public String getTokenSummary() {

		try {

			response.setContentType("application/json;charset=UTF-8");
			User user = (User) session.getAttribute("user");

			if (user == null) {
				response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
				return NONE;
			}

			String yearParam = request.getParameter("year");

			if (yearParam == null || yearParam.isEmpty()) {
				yearParam = String.valueOf(LocalDate.now().getYear());
			}

			String targetUserId = getTargetUserId(request, user);

			int year = Integer.parseInt(yearParam);

			Map<String, Object> summary = cubeTokenService.getUserTokenSummary(targetUserId, year);

			Map<String, Object> result = new LinkedHashMap<>();

			result.put("success", true);
			result.put("data", summary);

			new ObjectMapper().writeValue(response.getWriter(), result);

			return NONE;

		} catch (Exception e) {

			log.error("Error in getTokenSummary: ", e);
			response.setContentType("application/json;charset=UTF-8");
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

			try {

				new ObjectMapper().writeValue(response.getWriter(), result);

			} catch (Exception e1) {

				log.error("Error writing response in getTokenSummary: ", e1);

			}

			return NONE;

		}
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public Map<String, Object> getResult() {
		return result;
	}

	public Map<String, Object> getUserInfo() {
		return userInfo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

}
