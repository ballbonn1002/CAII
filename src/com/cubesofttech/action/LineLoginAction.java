package com.cubesofttech.action;

import okhttp3.*;

import com.cubesofttech.dao.UserDAO;
import com.cubesofttech.model.User;
import com.cubesofttech.system.Constant;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.opensymphony.xwork2.ActionSupport;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

public class LineLoginAction extends ActionSupport {

	private static final Logger log = Logger.getLogger(LineLoginAction.class);
	HttpServletRequest request = ServletActionContext.getRequest();
	
    // data from LINE Developer Console
    private static final String CHANNEL_ID = Constant.getLineChannel_id();;
    private static final String CHANNEL_SECRET = Constant.getLineChannel_secret();
    private static final String CALLBACK_URL = Constant.getLineCallback_url();
    
    @Autowired
	private Constant constant;
    
    @Autowired
	private UserDAO userDAO;
    
    private String authUrl;
    
    public String getAuthUrl() {
		return authUrl;
	}

	public void setAuthUrl(String authUrl) {
		this.authUrl = authUrl;
	}

    /**
     * 1. Method create URL and link to LINE Login page
     */
    public String login() {
        // create State for protect CSRF
        String state = UUID.randomUUID().toString();
        ServletActionContext.getRequest().getSession().setAttribute("line_state", state);

        authUrl = "https://access.line.me/oauth2/v2.1/authorize"
                + "?response_type=code"
                + "&client_id=" + CHANNEL_ID
                + "&redirect_uri=" + CALLBACK_URL
                + "&state=" + state
                + "&scope=profile%20openid"; // get user profile
                
        return "redirect";
    }

	/**
     * 2. Method for get Callback from LINE
     */
    public String callback() {
    	log.debug("Line Login success!!");
        String code = request.getParameter("code");
        String state = request.getParameter("state");
        String sessionState = (String) request.getSession().getAttribute("line_state");
        User onlineUser = (User) request.getSession().getAttribute("onlineUser");

        // Check status State (protect CSRF)
        if (state == null || !state.equals(sessionState)) {
            addActionError("Invalid State.");
            return ERROR;
        }

        //TODO:
        if (code != null) {
            try {
                String accessToken = getAccessToken(code);

                String lineId = getUserProfile(accessToken);
                
                log.debug(lineId);

                // check binding LINE User ID
                List<Map<String, Object>> userList = userDAO.findByLineId(lineId);
                
                // - if not: save and bind account
                if(userList == null || userList.isEmpty()) {
                	User user = userDAO.findById(onlineUser.getId());
                	user.setLine_id(lineId);
                	userDAO.update(user);
                } else {
                	String userId = userList.get(0).get("id").toString();
                	if(userId.equals(onlineUser.getId())) {
                		//update binding check match user
                		User user = userDAO.findById(userId);
                    	user.setLine_id(lineId);
                    	userDAO.update(user);
                	} else {
                		String webLinelogin = constant.getWebLinelogin();
            			request.setAttribute("webLinelogin", webLinelogin);
                		addActionError("This account is bound, Please unbound account or use another account.");
                        return "error_callback";
                	}
                }

                return SUCCESS;
            } catch (Exception e) {
                addActionError("Failed to authenticate with LINE.");
                e.printStackTrace();
                return ERROR;
            }
        }
        
        return ERROR;
    }

    private String getAccessToken(String code) throws Exception {
    	OkHttpClient client = new OkHttpClient();

        RequestBody formBody = new FormBody.Builder()
                .add("grant_type", "authorization_code")
                .add("code", code)
                .add("redirect_uri", CALLBACK_URL)
                .add("client_id", CHANNEL_ID)
                .add("client_secret", CHANNEL_SECRET)
                .build();

        Request request = new Request.Builder()
                .url("https://api.line.me/oauth2/v2.1/token")
                .post(formBody)
                .build();

        try {
            Response response = client.newCall(request).execute();
            
            try (ResponseBody responseBody = response.body()) {
                String jsonResponse = responseBody.string();
                
                if (!response.isSuccessful()) {
                    throw new Exception("LINE API Error: " + jsonResponse);
                }

                JsonObject jsonObject = new JsonParser().parse(jsonResponse).getAsJsonObject();
                return jsonObject.get("access_token").getAsString();
            } // responseBody auto close protect Memory Leak
            
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    private String getUserProfile(String accessToken) throws Exception {
    	String profileUrl = "https://api.line.me/v2/profile";
        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
                .url(profileUrl)
                .header("Authorization", "Bearer " + accessToken)
                .get()
                .build();

        try {
            Response response = client.newCall(request).execute();
            
            try (ResponseBody responseBody = response.body()) {
                String jsonResponse = responseBody.string();
                
                if (!response.isSuccessful()) {
                    throw new Exception("LINE Profile API Error: " + jsonResponse);
                }

                JsonObject jsonObject = new JsonParser().parse(jsonResponse).getAsJsonObject();
                
                String userId = jsonObject.get("userId").getAsString();
                String displayName = jsonObject.get("displayName").getAsString();
                
                //String pictureUrl = jsonObject.has("pictureUrl") ? jsonObject.get("pictureUrl").getAsString() : "";

                log.debug("LINE User ID: " + userId);
                log.debug("LINE Name: " + displayName);
                
                return userId; 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public String unbound() {
    	try {
            String id = request.getParameter("id");
            log.debug(id);
            
            User user = userDAO.findById(id);
            
            if(user.getLine_id() != null) {
            	user.setLine_id(null);
                user.setUid_line_oa(null);
                userDAO.update(user);
            } else {
            	String webLinelogin = constant.getWebLinelogin();
    			request.setAttribute("webLinelogin", webLinelogin);
            	addActionError("No account binding, Please bind account.");
                return "error_unbound";
            }
            

            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }
}