package com.cubesofttech.action;

import java.io.File;
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

import com.cubesofttech.model.ItemPrivilege;
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

	private String target;
	private Integer id;
	private String field;
	private String value;
	private String userId;
	private String reason;
	private String transactionId;

	private Map<String, Object> result;
	private Map<String, Object> userInfo;

	private Integer itemId;
	private String itemName;
	private Double itemToken;
	private Double itemAddedMoney;
	private Integer itemQuantity;
	private String itemDescription;

	private String effectiveDate;

	private String activeFlag;

	private File cover;
	private String coverContentType;
	private String coverFileName;

	private File[] additionalImages;
	private String[] additionalImagesContentType;
	private String[] additionalImagesFileName;

	private String removedAdditionalImages;

	private List<ItemPrivilege> itemPrivileges;
	private ItemPrivilege item;

	private int year;

	@Autowired
	private CubeTokenService cubeTokenService;

	public String cubetokenManagementPage() {

		try {
			User user = (User) session.getAttribute("user");

			if (user == null) {
				log.error("User not logged in");
				return LOGIN;
			}

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

	public String privilegeMangementPage() {

		try {

			itemPrivileges = cubeTokenService.getAllRewardItems();
			
			return SUCCESS;

		} catch (Exception e) {

			log.error("Error in privilegeMangementPage: " + e.getMessage(), e);

			return ERROR;

		}
	}

	public String privilegePage() {

		return SUCCESS;

	}

	public String getRewardItemList() {

		try {

			User user = (User) session.getAttribute("user");
			
			List<Map<String, Object>> items = cubeTokenService.getAllRewardItemsWithFavoriteStatus(user.getId());

			writeSuccessResponse(items, HttpServletResponse.SC_OK, "Reward item list retrieved successfully");

		} catch (Exception e) {

			log.error("Error in getRewardItemList: " + e.getMessage(), e);
			writeErrorResponse(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal server error");

		}

		return NONE;
	}

	public String createRewardItem() {
		return SUCCESS;
	}

	public String editRewardItem() {

		try {

			Integer itemId = Integer.valueOf(request.getParameter("itemId"));

			item = cubeTokenService.getRewardItemById(itemId);

			return SUCCESS;

		} catch (NumberFormatException e) {

			log.error("Invalid itemId parameter: " + request.getParameter("itemId"), e);

			return ERROR;
		}

		catch (Exception e) {

			log.error("Error in editRewardItem: " + e.getMessage(), e);

			return ERROR;

		}

	}
	
	public String redeemRewardItem() {
		
		try {
			
			User user = (User) session.getAttribute("user");
			
			cubeTokenService.redeemRewardItem(user.getId(), itemId);
			
			writeSuccessResponse(null, HttpServletResponse.SC_CREATED, "Reward item redeemed successfully");
			
		} catch (IllegalArgumentException e) {

			log.error("Invalid input: " + e.getMessage(), e);
			writeErrorResponse(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
			
		} 
		
		catch (Exception e) {

			log.error("Error in redeemRewardItem: " + e.getMessage(), e);
			writeErrorResponse(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal server error");
		}
		
		return NONE;
	}
	
	public String toggleFavorite() {

	    try {
	    	
	        User user  = (User) session.getAttribute("user");
	        String userId = user.getId();

	        boolean favorite = cubeTokenService.toggleFavorite(userId, itemId);

	        writeSuccessResponse(favorite, HttpServletResponse.SC_OK, "Favorite status toggled successfully");

	    } catch (IllegalArgumentException e) {
	        log.error("Invalid input: " + e.getMessage(), e);
	        writeErrorResponse(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
	    } 
	    
	    catch (Exception e) {
	        log.error(e.getMessage(), e);
	        writeErrorResponse(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal server error");
	    }

	    return NONE;
	    
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

	public String cubeTokenRankingPage() {

		try {

			User user = (User) session.getAttribute("user");

			userInfo = cubeTokenService.getUserInfo(user.getId());
			userInfo.put("currentBalance",
					cubeTokenService.getUserAccumulatedBalanceByYear(user.getId(), LocalDate.now().getYear()));

			return SUCCESS;

		} catch (Exception e) {

			log.error("Error in cubeTokenRankingPage: " + e.getMessage(), e);
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

	public String getUserAccumelatedToken() {

		try {

			User user = (User) session.getAttribute("user");

			if (year <= 0) {
				year = LocalDate.now().getYear();
			}

			Double data = cubeTokenService.getUserAccumulatedBalanceByYear(user.getId(), year);

			writeSuccessResponse(data, HttpServletResponse.SC_OK, "User accumulated token retrieved successfully");

		} catch (Exception e) {

			log.error("Error in getUserAccumelatedToken: ", e);
			writeErrorResponse(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal server error");

		}

		return NONE;
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

		boolean canViewAll = userAuthority != null && userAuthority.contains("cubetoken.history.viewall");

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
			Double accumulatedBalance = cubeTokenService.getUserCurrentAccumulatedBalance(targetUserId);

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

	public String getTokenRanking() {

		try {

			if (year <= 0) {
				year = LocalDate.now().getYear();
			}

			System.out.println(year);

			List<Map<String, Object>> data = cubeTokenService.getTop10AccumulatedTokenBalance(year);
			writeSuccessResponse(data, HttpServletResponse.SC_OK,
					"Top 10 accumulated token balance retrieved successfully");

		} catch (Exception e) {

			writeErrorResponse(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal server error");

		}

		return NONE;
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

	public String getUserCurrentRank() {

		try {

			User user = (User) session.getAttribute("user");
			String data = cubeTokenService.getUserCurrentRankByYear(user.getId(), year);

			writeSuccessResponse(data, HttpServletResponse.SC_OK, "User current rank retrieved successfully");

		} catch (Exception e) {

			log.error("Error in getUserCurrentRank: ", e);
			writeErrorResponse(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal server error");

		}

		return NONE;
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

	public String reloadRewardItemTable() {
		try {

			itemPrivileges = cubeTokenService.getAllRewardItems();

			return SUCCESS;

		} catch (Exception e) {

			log.error("Error loading reward item table", e);

			return ERROR;
		}
	}

	public String saveRewardItem() {

		try {
			response.setContentType("application/json;charset=UTF-8");

			User user = (User) session.getAttribute("user");

			cubeTokenService.createRewardItem(itemName, itemToken, itemAddedMoney, itemQuantity, itemDescription,
					effectiveDate, cover, activeFlag, coverFileName, additionalImages, additionalImagesFileName,
					user.getId(), request.getServletContext().getRealPath("/"));

			response.setStatus(HttpServletResponse.SC_CREATED);

			Map<String, Object> result = new LinkedHashMap<>();
			result.put("success", true);
			result.put("message", "Reward item created successfully");

			new ObjectMapper().writeValue(response.getWriter(), result);

		} catch (IllegalArgumentException e) {

			log.error("Invalid input: " + e.getMessage(), e);

			writeErrorResponse(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());

		} catch (Exception e) {

			log.error("Error creating reward item", e);

			writeErrorResponse(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to create reward item");
		}

		return NONE;
	}

	public String updateRewardItem() {
		try {
			response.setContentType("application/json;charset=UTF-8");

			User user = (User) session.getAttribute("user");

			cubeTokenService.updateRewardItem(itemId, itemName, itemToken, itemAddedMoney, itemQuantity,
					itemDescription, effectiveDate, activeFlag, cover, coverFileName, additionalImages,
					additionalImagesFileName, removedAdditionalImages, user.getId(),
					request.getServletContext().getRealPath("/"));

			response.setStatus(HttpServletResponse.SC_OK);

			Map<String, Object> result = new LinkedHashMap<>();
			result.put("success", true);
			result.put("message", "Reward item updated successfully");

			new ObjectMapper().writeValue(response.getWriter(), result);

		} catch (IllegalArgumentException e) {

			log.error("Invalid input: " + e.getMessage(), e);

			writeErrorResponse(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());

		} catch (Exception e) {

			log.error("Error updating reward item", e);

			writeErrorResponse(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to update reward item");
		}

		return NONE;
	}

	public String updateRewardItemActiveFlag() {

		try {

			response.setContentType("application/json;charset=UTF-8");
			User user = (User) session.getAttribute("user");

			ItemPrivilege itemPrivilege = cubeTokenService.updateRewardItemActiveFlag(itemId, activeFlag, user.getId());

			Map<String, Object> data = new LinkedHashMap<>();

			data.put("itemId", itemPrivilege.getItemId());
			data.put("activeFlag", "Y".equalsIgnoreCase(itemPrivilege.getActiveFlag()));

			writeSuccessResponse(data, HttpServletResponse.SC_OK, "Reward item active flag updated successfully");

		} catch (IllegalArgumentException e) {

			log.error("Invalid input: " + e.getMessage(), e);

			writeErrorResponse(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());

		} catch (Exception e) {

			log.error("Error updating reward item", e);

			writeErrorResponse(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to update reward item");
		}

		return NONE;

	}

	public String deleteRewardItem() {
		try {
			response.setContentType("application/json;charset=UTF-8");

			User user = (User) session.getAttribute("user");

			cubeTokenService.deleteRewardItem(itemId, user.getId(), request.getServletContext().getRealPath("/"));

			response.setStatus(HttpServletResponse.SC_OK);

			Map<String, Object> result = new LinkedHashMap<>();
			result.put("success", true);
			result.put("message", "Reward item deleted successfully");

			new ObjectMapper().writeValue(response.getWriter(), result);

		} catch (IllegalArgumentException e) {

			log.error("Invalid input: " + e.getMessage(), e);

			writeErrorResponse(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());

		} catch (Exception e) {

			log.error("Error deleting reward item", e);

			writeErrorResponse(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to delete reward item");
		}

		return NONE;
	}

	private void writeSuccessResponse(Object data, int status, String message) {

		try {
			response.setContentType("application/json;charset=UTF-8");
			response.setStatus(status);

			Map<String, Object> result = new LinkedHashMap<>();
			result.put("success", true);
			result.put("data", data);
			result.put("message", message);

			new ObjectMapper().writeValue(response.getWriter(), result);

		} catch (Exception e) {
			log.error("Error writing JSON response", e);
		}
	}

	private void writeErrorResponse(int status, String message) {

		try {
			response.setContentType("application/json;charset=UTF-8");
			response.setStatus(status);

			Map<String, Object> result = new LinkedHashMap<>();
			result.put("success", false);
			result.put("message", message);

			new ObjectMapper().writeValue(response.getWriter(), result);

		} catch (Exception e) {
			log.error("Error writing JSON response", e);
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

	public File getCover() {
		return cover;
	}

	public void setCover(File cover) {
		this.cover = cover;
	}

	public String getCoverContentType() {
		return coverContentType;
	}

	public void setCoverContentType(String coverContentType) {
		this.coverContentType = coverContentType;
	}

	public String getCoverFileName() {
		return coverFileName;
	}

	public void setCoverFileName(String coverFileName) {
		this.coverFileName = coverFileName;
	}

	public File[] getAdditionalImages() {
		return additionalImages;
	}

	public void setAdditionalImages(File[] additionalImages) {
		this.additionalImages = additionalImages;
	}

	public String[] getAdditionalImagesContentType() {
		return additionalImagesContentType;
	}

	public void setAdditionalImagesContentType(String[] additionalImagesContentType) {
		this.additionalImagesContentType = additionalImagesContentType;
	}

	public String[] getAdditionalImagesFileName() {
		return additionalImagesFileName;
	}

	public void setAdditionalImagesFileName(String[] additionalImagesFileName) {
		this.additionalImagesFileName = additionalImagesFileName;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public Double getItemToken() {
		return itemToken;
	}

	public void setItemToken(Double itemToken) {
		this.itemToken = itemToken;
	}

	public Integer getItemQuantity() {
		return itemQuantity;
	}

	public void setItemQuantity(Integer itemQuantity) {
		this.itemQuantity = itemQuantity;
	}

	public String getItemDescription() {
		return itemDescription;
	}

	public void setItemDescription(String itemDescription) {
		this.itemDescription = itemDescription;
	}

	public String getEffectiveDate() {
		return effectiveDate;
	}

	public void setEffectiveDate(String effectiveDate) {
		this.effectiveDate = effectiveDate;
	}

	public String getActiveFlag() {
		return activeFlag;
	}

	public void setActiveFlag(String activeFlag) {
		this.activeFlag = activeFlag;
	}

	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}

	public List<ItemPrivilege> getItemPrivileges() {
		return itemPrivileges;
	}

	public ItemPrivilege getItem() {
		return item;
	}

	public String getRemovedAdditionalImages() {
		return removedAdditionalImages;
	}

	public void setRemovedAdditionalImages(String removedAdditionalImages) {
		this.removedAdditionalImages = removedAdditionalImages;
	}

	public Double getItemAddedMoney() {
		return itemAddedMoney;
	}

	public void setItemAddedMoney(Double itemAddedMoney) {
		this.itemAddedMoney = itemAddedMoney;
	}

	public void setYear(int year) {
		this.year = year;
	}

}
