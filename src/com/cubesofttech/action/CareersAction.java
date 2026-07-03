package com.cubesofttech.action;

import java.io.ByteArrayInputStream;

import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.cubesofttech.dao.JobDAO;
import com.cubesofttech.model.Job;
import com.cubesofttech.model.User;
import com.cubesofttech.util.DateUtil;
import com.cubesofttech.model.PageUri;
import com.cubesofttech.dao.PageUriDAO;

import com.opensymphony.xwork2.ActionSupport;

public class CareersAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(CareersAction.class);
	
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	HttpSession session = request.getSession();

	@Autowired
	public JobDAO jobDAO;
	
	@Autowired
	public PageUriDAO pageUriDAO;
	
	private String oldPageUriId;
	private String pageUriId;
	private String forwardTo;
	private String model;
	private String modelId;
	private String pageUriTitle;
	private String meta;
	private String pageUriDescription;

	public String getOldPageUriId() {
		return oldPageUriId;
	}

	public void setOldPageUriId(String oldPageUriId) {
		this.oldPageUriId = oldPageUriId;
	}

	public String getPageUriId() {
		return pageUriId;
	}

	public void setPageUriId(String pageUriId) {
		this.pageUriId = pageUriId;
	}

	public String getForwardTo() {
		return forwardTo;
	}

	public void setForwardTo(String forwardTo) {
		this.forwardTo = forwardTo;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getModelId() {
		return modelId;
	}

	public void setModelId(String modelId) {
		this.modelId = modelId;
	}

	public String getPageUriTitle() {
		return pageUriTitle;
	}

	public void setPageUriTitle(String pageUriTitle) {
		this.pageUriTitle = pageUriTitle;
	}

	public String getMeta() {
		return meta;
	}

	public void setMeta(String meta) {
		this.meta = meta;
	}

	public String getPageUriDescription() {
		return pageUriDescription;
	}

	public void setPageUriDescription(String pageUriDescription) {
		this.pageUriDescription = pageUriDescription;
	}

	private String sortOrder;
	public String getSortOrder() { return sortOrder; }
	public void setSortOrder(String sortOrder) { this.sortOrder = sortOrder; }
	
	private Integer id;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

	public String careersList() {
		try {
			User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				return ERROR;
			}
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			
			List<Job> jobList = jobDAO.findAll(); 

			if (jobList == null) {
				jobList = new ArrayList<>();
			}

			Comparator<Job> sorter = Comparator.comparing(job -> {
			    String nameVal = job.getName();
			    
			    if (nameVal == null || nameVal.trim().isEmpty()) {
			        return Integer.MAX_VALUE; 
			    }
			    
			    try {
			        return Integer.parseInt(nameVal.trim());
			    } catch (NumberFormatException e) {
			        return Integer.MAX_VALUE; 
			    }
			}, Comparator.naturalOrder());

			sorter = sorter.thenComparing(Job::getJobId, Comparator.nullsLast(Comparator.naturalOrder()));

			if ("asc".equalsIgnoreCase(sortOrder)) {
			    jobList.sort(sorter.reversed());
			} else {
			    jobList.sort(sorter);
			}

			request.setAttribute("jobList", jobList);

            int islastest = 0;
            if (!jobList.isEmpty()) {
                islastest = jobList.stream()
                                   .mapToInt(Job::getJobId)
                                   .max()
                                   .orElse(0);
            }
            request.setAttribute("islastest", islastest);

            return SUCCESS;

		} catch (Exception e) {
			log.error("Error fetching job list using findAll()", e);
			return ERROR;
		}
	}

	public String deleteCareer() {
		try {
			String id = request.getParameter("id");
			
			if (id != null && !id.trim().isEmpty()) {
			    Job j = jobDAO.findById(Integer.parseInt(id));
			    if (j != null) jobDAO.delete(j);
			}
			
			String pageUriId = request.getParameter("id"); 

			PageUri uri = pageUriDAO.findByModelId(pageUriId);
	            
	            if (uri != null) {
	                if ("job".equalsIgnoreCase(uri.getModel())) {
	                    pageUriDAO.delete(uri);
	                }
	            }
			
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String createCareer() {
		User onlineUser = (User) request.getSession().getAttribute("onlineUser");
		if (onlineUser == null) {
			return ERROR;
		}
		
		return SUCCESS;
	}
	
	public String saveCareer() {
	    try {
	        String positionName = request.getParameter("positionName");
	        String jobRef = request.getParameter("jobRef");      
	        String startDateStr = request.getParameter("startDate"); 
	        String endDateStr = request.getParameter("endDate");  
	        String salary = request.getParameter("salary");  
	        String contentDetail = request.getParameter("contentDetail");

	        Job job = new Job();

	        Integer maxJobId = jobDAO.getMaxId();
	        if (maxJobId == null) {
	            maxJobId = 0;
	        }
	        job.setJobId(maxJobId + 1);

	        job.setPosition(positionName);
	        job.setName(jobRef);
	        job.setDescription(contentDetail);

	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        if (startDateStr != null && !startDateStr.isEmpty()) {
	            job.setStartDate(sdf.parse(startDateStr));
	        }
	        if (endDateStr != null && !endDateStr.isEmpty()) {
	            job.setEndDate(sdf.parse(endDateStr));
	        }

	        Integer minSalary = 0;
	        Integer maxSalary = 0;

	        if (salary != null && !salary.isEmpty()) {
	            if (salary.contains("-")) {
	                String[] salaryParts = salary.split("-");
	                if (salaryParts.length >= 2) {
	                    String minStr = salaryParts[0].replaceAll("[^0-9]", "");
	                    String maxStr = salaryParts[1].replaceAll("[^0-9]", "");
	                    
	                    if (!minStr.isEmpty()) {
	                        minSalary = Integer.parseInt(minStr);
	                    }
	                    if (!maxStr.isEmpty()) {
	                        maxSalary = Integer.parseInt(maxStr);
	                    }
	                }
	            } else {
	                String singleSalaryStr = salary.replaceAll("[^0-9]", "");
	                if (!singleSalaryStr.isEmpty()) {
	                    minSalary = Integer.parseInt(singleSalaryStr);
	                    maxSalary = minSalary; 
	                }
	            }
	        } else {
	        		minSalary = null;
                maxSalary = null; 
	        }

	        job.setSalaryMin(minSalary);
	        job.setSalaryMax(maxSalary);

	        String currentUsername = "system"; 
	        if (session.getAttribute("username") != null) {
	            currentUsername = (String) session.getAttribute("username");
	        } else if (session.getAttribute("user") != null) {
	            User loginUser = (User) session.getAttribute("user");
	            currentUsername = loginUser.getId(); 
	        }
			
			if ("cft.admin".equals(currentUsername)) {
	            currentUsername = "admin";
	        }
			
	        job.setUserCreate(currentUsername); 
	        job.setTimeCreate(new Timestamp(System.currentTimeMillis()));
	        job.setUserUpdate(currentUsername);
	        job.setTimeUpdate(new Timestamp(System.currentTimeMillis()));

	        jobDAO.save(job); 
	        
	        this.id = job.getJobId();

	        return SUCCESS;
	    } catch (Exception e) {
	        log.error("[saveCareer] error", e);
	        e.printStackTrace();
	        return ERROR;
	    }
	}
	
	public String editCareer() {
	    try {
	    	User onlineUser = (User) request.getSession().getAttribute("onlineUser");
			if (onlineUser == null) {
				return ERROR;
			}
			
	        String id = request.getParameter("id"); 
	        
	        if (id != null && !id.isEmpty()) {
	            Integer jobId = Integer.parseInt(id);
	            
	            Job jobData = jobDAO.findById(jobId); 
	            request.setAttribute("jobInfo", jobData); 
	            
	            List<PageUri> uriList = pageUriDAO.findByModelAndModelId("job", id);
	            PageUri uri = null;
	            if (uriList != null && !uriList.isEmpty()) {
	                uri = uriList.get(0); 
	            }
	            System.out.println("Data = " + uri);	            
	            
	            if (uri != null) {
	            		log.debug("Found");
	            		request.setAttribute("pageUri", uri);
	            		
	            		System.out.println("Data = " + uri);
	            		System.out.println("Model = " + uri.getModel());
	            		System.out.println("ModelId = " + uri.getModelId());
	            		System.out.println("PageUriId = " + uri.getPageUriId());
	            		System.out.println("ForwardTo = " + uri.getForwardTo());
	            		System.out.println("Title = " + uri.getPageUriTitle());
	            		System.out.println("Meta = " + uri.getMeta());
	            		System.out.println("Description = " + uri.getPageUriDescription());
	            } else {
	            		log.debug("Not Found");
	                PageUri newUri = new PageUri();
	                String position = (jobData != null && jobData.getPosition() != null) ? jobData.getPosition().trim() : "";
	                String formattedPosition = position.trim()
                            .replaceAll("[\\s\\u00a0]+", "-")
                            .replaceAll("-+", "-")
                            .replaceAll("^-|-$", "")
                            .toLowerCase();
	            
	                String forward = "/jobDetail.action?id=" + id;
	                String pageUriId = "/careers/" + formattedPosition;
	                
	                newUri.setPageUriId(pageUriId);
	                newUri.setForwardTo(forward);
	                newUri.setModel("job");
	                newUri.setModelId(id);
	                
	                request.setAttribute("pageUri", newUri);
	            }
	        }

	        return SUCCESS;
	    } catch (Exception e) {
	        log.error("[editCareer] error", e);
	        e.printStackTrace();
	        return ERROR;
	    }
	}
	
	public String saveEditCareer() {
	    HttpServletRequest request = ServletActionContext.getRequest();
	    try {
	        String jobIdStr = request.getParameter("jobId");
	        String pageUriId = request.getParameter("pageUriId");
	        String oldPageUriId = request.getParameter("oldPageUriId");

	        String currentUsername = "system";
	        if (request.getSession().getAttribute("onlineUser") != null) {
	            User onlineUser = (User) request.getSession().getAttribute("onlineUser");
	            currentUsername = onlineUser.getId();
	        } else if (request.getSession().getAttribute("username") != null) {
	            currentUsername = (String) request.getSession().getAttribute("username");
	        }
	        if ("cft.admin".equals(currentUsername)) currentUsername = "admin";

	        boolean isUriChanged = (oldPageUriId != null && !oldPageUriId.isEmpty() 
	                             && pageUriId != null && !pageUriId.isEmpty() 
	                             && !oldPageUriId.equals(pageUriId));
	        
	        if (isUriChanged) {
	            PageUri existingUri = pageUriDAO.findById(pageUriId);
	            if (existingUri != null) {
	                request.setAttribute("errorMsg", "Page URL (ID) already exists!");
	                return ERROR;
	            }
	        }

	        if (jobIdStr != null && !jobIdStr.isEmpty()) {
	            Integer jobId = Integer.parseInt(jobIdStr.trim());
	            Job job = jobDAO.findById(jobId);

	            if (job != null) {
	                job.setPosition(request.getParameter("positionName"));
	                job.setName(request.getParameter("jobRef"));
	                job.setDescription(request.getParameter("contentDetail"));

	                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	                String startDate = request.getParameter("startDate");
	                String endDate = request.getParameter("endDate");
	                if (startDate != null && !startDate.trim().isEmpty()) job.setStartDate(sdf.parse(startDate));
	                if (endDate != null && !endDate.trim().isEmpty()) job.setEndDate(sdf.parse(endDate));

	                String salary = request.getParameter("salary");
	                if (salary != null && !salary.trim().isEmpty()) {
	                    if (salary.contains("-")) {
	                        String[] salaryParts = salary.split("-");
	                        if (salaryParts.length >= 2) {
	                            String minStr = salaryParts[0].replaceAll("[^0-9]", "");
	                            String maxStr = salaryParts[1].replaceAll("[^0-9]", "");
	                            job.setSalaryMin(!minStr.isEmpty() ? Integer.parseInt(minStr) : null);
	                            job.setSalaryMax(!maxStr.isEmpty() ? Integer.parseInt(maxStr) : null);
	                        }
	                    } else {
	                        String singleSalaryStr = salary.replaceAll("[^0-9]", "");
	                        if (!singleSalaryStr.isEmpty()) {
	                            job.setSalaryMin(Integer.parseInt(singleSalaryStr));
	                            job.setSalaryMax(Integer.parseInt(singleSalaryStr)); 
	                        }
	                    }
	                } else {
	                    job.setSalaryMin(null);
	                    job.setSalaryMax(null);
	                }

	                job.setUserUpdate(currentUsername);
	                job.setTimeUpdate(new Timestamp(System.currentTimeMillis()));
	                
	                jobDAO.update(job);
	                this.id = job.getJobId();
	            }
	        }

	        if (pageUriId != null && !pageUriId.trim().isEmpty()) {
	            
	            if (isUriChanged) {
	                pageUriDAO.changePageUriId(oldPageUriId, pageUriId);
	            }

	            PageUri uri = pageUriDAO.findById(pageUriId);
	            boolean isNewUri = false;

	            if (uri == null) {
	                uri = new PageUri();
	                uri.setPageUriId(pageUriId);
	                uri.setUserCreate(currentUsername);
	                uri.setTimeCreate(DateUtil.getCurrentTime());
	                isNewUri = true;
	            }

	            uri.setForwardTo(request.getParameter("forward_to"));
	            uri.setModel(request.getParameter("model"));
	            uri.setModelId(request.getParameter("model_id"));
	            uri.setPageUriTitle(request.getParameter("pageUriTitle"));
	            uri.setMeta(request.getParameter("meta"));
	            uri.setPageUriDescription(request.getParameter("pageUriDescription"));
	            
	            uri.setUserUpdate(currentUsername);
	            uri.setTimeUpdate(DateUtil.getCurrentTime());

	            if (isNewUri) {
	                pageUriDAO.save(uri);
	            } else {
	                pageUriDAO.update(uri);
	            }
	        }

	        return SUCCESS;

	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("errorMsg", "System Error: " + e.getMessage());
	        return ERROR;
	    }
	}
	
	public String checkPositionDuplicate() {
	    try {
	        HttpServletRequest request = ServletActionContext.getRequest();
	        HttpServletResponse response = ServletActionContext.getResponse();
	        response.setContentType("application/json;charset=UTF-8");
	        
	        String positionName = request.getParameter("positionName");
	        boolean isDuplicate = false;
	        
	        if (positionName != null && !positionName.trim().isEmpty()) {
	            String target = positionName.trim().toLowerCase(); 
	            
	            List<Job> allJobs = jobDAO.findAll(); 
	            
	            if (allJobs != null) {
	                for (Job job : allJobs) {
	                    if (job.getPosition() != null) {
	                        String currentPos = job.getPosition().trim().toLowerCase();
	                        if (currentPos.equals(target)) {
	                            isDuplicate = true;
	                            break;
	                        }
	                    }
	                }
	            }
	        }
	        
	        response.getWriter().write("{\"isDuplicate\": " + isDuplicate + "}");
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return NONE;
	}
	
}