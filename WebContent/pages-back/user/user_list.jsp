<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value="en_US" />
<%
    String yearParam = request.getParameter("year");
%>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/assets/css/style.bundle.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>

<link href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<style type="text/css">
.select2-selection__clear { display: none !important; }
.form-check-input:checked { background-color: var(--bs-success) !important; border-color: var(--bs-success) !important; }

#filterFields .select2-container--bootstrap-5 .select2-selection--single {
  height: 45px; display: flex; align-items: center; background-color: #fff; border-color: var(--bs-gray-300);
}
#filterFields .select2-container--bootstrap-5 .select2-selection--single .select2-selection__rendered {
  padding-left: 0.75rem; line-height: 1.2;
}
#gridViewContainer .card { min-height: 380px; }
</style>
</head>

<body class="app-default">
    <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
        <div class="d-flex flex-column flex-column-fluid">
            <div id="kt_app_toolbar" class="app-toolbar py-2 py-lg-3">
                <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack align-items-center justify-content-between">
                    <div class="page-title d-flex flex-column justify-content-center">
                        <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Employee Profile</h1>
                        <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                            <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
                            <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
                            <li class="breadcrumb-item text-muted">Admin Management</li>
                        </ul>
                    </div>
                    <div class="d-flex align-items-center gap-2 ms-auto">
                    <!-- 
                        <a href="userAllReport" class="btn btn-light-primary btn-sm px-3 py-2">
						    <i class="ki-duotone ki-printer fs-3 me-1">
						        <span class="path1"></span>
						        <span class="path2"></span>
						        <span class="path3"></span>
						        <span class="path4"></span>
						        <span class="path5"></span>
						    </i>
						    Print
						</a>
					-->
                        <button type="button" class="btn btn-success btn-sm px-3 py-2" onclick="addUser()">
                            <i class="ki-outline ki-plus fs-3 me-1"></i>Create
                        </button>
                    </div>
                </div>
            </div>

            <div id="kt_app_content" class="app-content flex-column-fluid">
                <div id="kt_app_content_container" class="app-container container-fluid">

                    <div class="card mb-5">
                        <div class="card-body p-4">
                            <div class="filter-card p-4 mb-4 rounded-3">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="user-search-wrap flex-grow-1">
                                        <div class="input-group flex-nowrap">
                                            <span class="input-group-text bg-transparent border-end-0 h-45px">
                                                <i class="ki-outline ki-magnifier fs-3"></i>
                                            </span>
                                            <div class="flex-grow-1">
                                                <select id="name2" class="form-select rounded-start-0 border-start-0 h-45px" data-control="select2" data-placeholder="All" data-allow-clear="true">
                                                    <option></option>
                                                   <option value="All">All</option> 
                                                    <optgroup label="Enable">
                                                        <c:forEach var="user" items="${cubesoftUser}">
                                                            <c:if test="${user.enable == 1 && user.flag_search == '1'}">
                                                                <c:set var="displayText" value="${not empty user.employee_id ? user.employee_id : ''}" />
                                                                <c:if test="${not empty user.name_en}"><c:set var="displayText" value="${displayText}${not empty displayText ? ' - ' : ''}${user.name_en}" /></c:if>
                                                                <c:if test="${not empty user.name}"><c:set var="displayText" value="${displayText}${not empty displayText ? ' - ' : ''}${user.name}" /></c:if>                                                      
                                                                <option value="<c:out value='${user.id != null ? fn:trim(user.id) : ""}'/>">${displayText}</option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </optgroup>
                                                    <optgroup label="Disable">
                                                        <c:forEach var="user" items="${cubesoftUser}">
                                                            <c:if test="${user.enable == 0 && user.flag_search == '1'}">
                                                                <c:set var="displayText" value="${not empty user.employee_id ? user.employee_id : ''}" />
                                                                <c:if test="${not empty user.name_en}"><c:set var="displayText" value="${displayText}${not empty displayText ? ' - ' : ''}${user.name_en}" /></c:if>
                                                                <c:if test="${not empty user.name}"><c:set var="displayText" value="${displayText}${not empty displayText ? ' - ' : ''}${user.name}" /></c:if>
                                                                <option value="<c:out value='${user.id != null ? fn:trim(user.id) : ""}'/>">${displayText}</option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </optgroup>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="button" id="btnToggleFilters" class="btn btn-icon btn-light-primary text-gray-600 border-0 rounded-3 h-45px px-4 d-flex align-items-center justify-content-center" aria-expanded="false">
                                        <i class="ki-duotone ki-filter fs-2"><span class="path1"></span><span class="path2"></span></i>
                                    </button>
                                </div>

                                <div class="filter-divider border-bottom my-3 mt-6 d-none"></div>

                                <div id="filterFields" class="filter-fields d-none">
                                    <div class="row g-3">
                                        <div class="col-12 col-md-4">
                                            <label for="statusSelect" class="form-label mb-1">Status:</label>
                                            <select id="statusSelect" class="form-select" data-control="select2" data-hide-search="true" data-placeholder="All Status">
                                                <option value="">All Status</option>
                                                <option value="1">Active</option>
                                                <option value="2">Non active</option>
                                                <option value="3">All Users</option>
                                            </select>
                                        </div>
                                        <div class="col-12 col-md-4">
                                            <label for="birthdaysSelect" class="form-label mb-1">Birthdays:</label>
                                            <select id="birthdaysSelect" class="form-select" data-allow-clear="true" data-control="select2" data-hide-search="true" data-placeholder="Select">
                                                <option value="">Select</option>
                                                <option value="1">This Month</option>
                                                <option value="2">This Week</option>
                                                <option value="3">All Users</option>
                                            </select>
                                        </div>
                                        <div class="col-12 col-md-4">
                                            <label for="anniversariesSelect" class="form-label mb-1">Anniversaries:</label>
                                            <select id="anniversariesSelect" class="form-select" data-allow-clear="true" data-control="select2" data-hide-search="true" data-placeholder="Select">
                                                <option value="">Select</option>
                                                <option value="1">This Month</option>
                                                <option value="2">This Week</option>
                                                <option value="3">All Users</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-4 pt-5 mb-5 fs-7">
                        <div id="dt_showing" class="text-dark fs-7 mb-2 mb-md-0"></div>
                        <div class="d-flex align-items-center gap-3">
                            <div class="d-flex align-items-center gap-2 me-1">
                                <button id="btnGridView" class="btn btn-icon btn-active-primary btn-light-primary" title="Grid View">
                                    <i class="ki-outline ki-element-plus fs-2"></i>
                                </button>
                                <button id="btnTableView" class="btn btn-icon btn-active-primary btn-color-primary active" title="Table View">
                                    <i class="ki-outline ki-row-horizontal fs-2"></i>
                                </button>
                            </div>
                            <div class="w-225px w-md-250px">
                                <select id="sortSelect" class="form-select form-select-solid" data-control="select2" data-hide-search="true" data-placeholder="Sort by: Employee ID">
                                    <option value="Alluser">All User</option>
                                    <option value="empid-asc">Employee ID: Lowest</option>
                                    <option value="empid-desc">Employee ID: Highest</option>
                                    <option value="name-asc">Name: A–Z</option>
                                    <option value="name-desc">Name: Z–A</option>
                                    <option value="site-asc">Job Site: A–Z</option>
                                    <option value="site-desc">Job Site: Z–A</option>
                                    <option value="period-asc">Period: Shortest</option>
                                    <option value="period-desc">Period: Longest</option>
                                    <option value="startdate-desc">Start Date: Newest</option>
                                    <option value="startdate-asc">Start Date: Oldest</option>
                                    <option value="birth-young">Birth Date: Youngest</option>
                                    <option value="birth-old">Birth Date: Oldest</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div id="tableViewContainer" class="card">
                        <div class="card-body pt-6 mb-6 align-items-start">
                            <div class="table-responsive">
                                <table id="myTable" class="table table-striped table-row-dashed align-middle table-hover fs-6 gy-5 gx-5 gs-5 mb-0 border-bottom-0">
                                    <thead>
                                            <tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0">
                                                <th class="text-start min-w-120px">#</th>
                                                <th class="min-w-90px">Employee ID</th>
                                                <th class="min-w-220px">Name</th>
                                                
                                                <th class="w-50px text-center p-0"></th> 
                                                
                                                <th class="min-w-160px">Job Site</th>
                                                <th class="min-w-120px">Position</th>
                                                <th class="min-w-120px">Period</th>
                                                <th class="text-end min-w-90px">Active</th>
                                                <th class="text-end min-w-120px">Actions</th>
                                            </tr>
                                    </thead>
                                    <tbody>
                                            <c:forEach var="user" items="${cubesoftUser}" varStatus="st">
                                                <c:set var="uid" value="${user.id != null ? fn:trim(user.id) : ''}" />
                                                <tr data-user-id="${uid}" data-birth="<fmt:formatDate value='${user.birth_date}' pattern='yyyy-MM-dd'/>">
                                                    
                                                    <td class="fw-bold text-gray-800 text-start row-number "></td>
                                                    
                                                    <td class="fw-bold text-gray-800" data-order="${user.employee_id}">
                                                        ${not empty user.employee_id ? user.employee_id : '-'}
                                                    </td>
                                                    
                                                    <td>
                                                        <div class="fw-semibold text-gray-900">
                                                            <c:choose>
                                                                <c:when test="${not empty user.name_en}">
                                                                    <a href="user-edit?userId=${user.id}" class="text-gray-900 text-hover-primary">${user.name_en}</a>
                                                                </c:when>
                                                                <c:otherwise>-</c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div class="text-gray-700 fs-6">${not empty user.name ? user.name : ''}</div>
                                                    </td>

                                                    <td class="text-center bday-cell"></td>

                                                    <td>
                                                        <div class="d-flex flex-wrap align-items-start gap-2">
                                                            <c:choose>
                                                                <c:when test="${not empty user.job_site_all}">
                                                                    <c:forEach var="site" items="${user.job_site_all}">
                                                                        <span class="badge badge-primary fw-semibold me-2 d-inline-flex">${site.name_site}</span>
                                                                    </c:forEach>
                                                                </c:when>
                                                                <c:otherwise><span class="">-</span></c:otherwise>
                                                            </c:choose>
                                                            <c:if test="${not empty user.inhouse && user.inhouse}">
                                                                <span class="badge badge-light-info fw-semibold d-inline-flex">In-house</span>
                                                            </c:if>
                                                        </div>
                                                    </td>

                                                    <td class="text-gray-800">${not empty user.position_id ? user.position_id : '-'}</td>
                                                    
                                                    <td class="text-gray-800">
                                                        <span class="period-text" data-start="<fmt:formatDate value='${user.start_date}' pattern='yyyy-MM-dd'/>" data-end="<fmt:formatDate value='${user.end_date}' pattern='yyyy-MM-dd'/>">-</span>
                                                    </td>
                                                    
                                                    <td class="text-end" data-order="${user.enable}">
                                                        <div class="form-check form-switch form-check-custom form-check-solid d-inline-flex justify-content-end">
                                                            <input class="form-check-input h-20px w-35px js-toggle-enable" type="checkbox" id="active_${uid}" data-userid="${uid}" data-enable="${user.enable}" <c:if test="${user.enable == 1}">checked</c:if> />
                                                        </div>
                                                    </td>
                                                    
                                                    <td class="text-end">
                                                        <a href="user-edit?userId=${user.id}" class="btn btn-icon btn-light-primary btn-sm me-2" title="Edit">
                                                            <i class="ki-duotone ki-pencil fs-5"><span class="path1"></span><span class="path2"></span></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div id="gridViewContainer" class="row g-8 d-none">
					    <c:forEach var="user" items="${cubesoftUser}">
					        <div class="col-12 col-md-6 col-xl-4 grid-card">
					            <div class="card" data-user-id="${user.id}">
					                <div class="card-header d-flex justify-content-between align-items-center">
					                    <div class="d-flex align-items-center">
					                        <span class="employee-id fw-bold">${not empty user.employee_id ? user.employee_id : 'NONE'}</span>
					                    </div>
					                    <div class="action-icons">
					                        <a href="user-edit?userId=${user.id}" class="btn btn-icon btn-light-primary btn-sm me-2" title="Edit">
					                            <i class="ki-duotone ki-pencil fs-5"><span class="path1"></span><span class="path2"></span></i>
					                        </a>
					                    </div>
					                </div>
					                <div class="card-body d-flex flex-column">
					                    <div style="flex-grow: 1;">
					                        <div class="d-flex align-items-center mb-3">
					                            <div class="symbol symbol-40px symbol-circle me-8">
					                                <c:choose>
					                                    <c:when test="${not empty user.ListUserImgPath}">
					                                        <div class="symbol-label"><img src="${user.ListUserImgPath}" class="w-100 h-100 rounded-circle" style="object-fit: cover;" /></div>
					                                    </c:when>
					                                    <c:otherwise>
					                                        <span class="symbol-label bg-light-primary text-primary fw-bold d-flex align-items-center justify-content-center">
					                                            ${fn:toUpperCase(fn:substring(not empty user.name_en ? user.name_en : user.name, 0, 1))}
					                                        </span>
					                                    </c:otherwise>
					                                </c:choose>
					                                <%-- <c:choose>
													    <c:when test="${not empty user.userImgPath}">
													    <div class="symbol-label">
													        <img src="${pageContext.request.contextPath}${user.userImgPath}"
													             class="w-100 h-100 rounded-circle" style="object-fit: cover;">
													             </div>
													    </c:when>
													    <c:otherwise>
													        <span class="symbol-label bg-light-primary text-primary fw-bold d-flex align-items-center justify-content-center">
													            ${fn:toUpperCase(fn:substring(user.nameEN,0,1))}
													        </div>
													    </c:otherwise>
													</c:choose> --%>
																		                                
					                            </div>
					                            <div class="employee-info mb-4">
					                                <span style="font-weight: 500;">${not empty user.name_en ? user.name_en : '-'}</span><br/>
					                                <span style="font-weight: 300; margin-left: 6px;">${not empty user.name ? user.name : '-'}</span>
					                            </div>
					                        </div>
					                        
					                        <div class="info-row d-flex justify-content-between mb-4">
					                            <div class="info-left d-flex align-items-center">
					                                <i class="ki-duotone ki-map me-1 fs-1"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
					                                <span class="info-text">${not empty user.work_type ? user.work_type : 'None'}</span>
					                            </div>
					                            <span class="info-right">${not empty user.onsite_num ? user.onsite_num : 'None'}</span>
					                        </div>
					
					                        <div class="info-row d-flex justify-content-between mb-4">
					                            <div class="info-left d-flex align-items-center">
					                                <i class="ki-duotone ki-office-bag me-1 fs-1"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>
					                                <span class="info-text">${not empty user.department_id ? user.department_id : 'None'}</span>
					                            </div>
					                            <span class="info-right">${not empty user.position_id ? user.position_id : '-'}</span>
					                        </div>
					
					                        <div class="info-row d-flex justify-content-between mb-4">
					                            <div class="info-left d-flex align-items-center">
					                                <i class="ki-duotone ki-time me-1 fs-1"><span class="path1"></span><span class="path2"></span></i>
					                                <span class="info-text"><c:choose><c:when test="${not empty user.start_date}"><fmt:formatDate value="${user.start_date}" pattern="dd MMM yyyy" /></c:when><c:otherwise>None</c:otherwise></c:choose></span>
					                            </div>
					                            <span class="info-right period-display" 
					                                  data-start="<fmt:formatDate value='${user.start_date}' pattern='yyyy-MM-dd'/>" 
					                                  data-end="<fmt:formatDate value='${user.end_date}' pattern='yyyy-MM-dd'/>">
					                                None
					                            </span>
					                        </div>
					
					                        <div class="info-row d-flex justify-content-between">
					                            <div class="info-left d-flex align-items-center">
					                                <i class="ki-duotone ki-gift me-1 fs-1"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>
					                                <span class="info-text">
					                                    <c:choose>
					                                        <c:when test="${not empty user.birth_date}"><fmt:formatDate value="${user.birth_date}" pattern="dd MMM yyyy" /></c:when>
					                                        <c:when test="${not empty user.birth_day}">${user.birth_day}</c:when>
					                                        <c:otherwise>None</c:otherwise>
					                                    </c:choose>
					                                </span>
					                            </div>
					                            <span class="info-right birth-age" data-birth-date="<fmt:formatDate value='${user.birth_date}' pattern='yyyy-MM-dd'/>">-</span>
					                        </div>                                          
					                    </div>
					                </div>
					                <div class="card-footer d-flex flex-column">
					                    <div class="info-row d-flex justify-content-between mt-2">
					                        <div class="text-start">
					                            <c:choose>
					                                <c:when test="${not empty user.job_site_all}">
					                                    <c:forEach var="site" items="${user.job_site_all}">
					                                        <span class="badge badge-primary fw-semibold me-2 d-inline-flex">${site.name_site}</span>
					                                    </c:forEach>
					                                </c:when>
					                                <c:otherwise><span class="badge badge-light d-inline-flex">None</span></c:otherwise>
					                            </c:choose>
					                        </div>
					                        <div class="d-flex align-items-center gap-2">
					                            <span class="status-text fw-semibold fs-8 <c:if test='${user.enable == 1}'>text-success</c:if> <c:if test='${user.enable != 1}'>text-muted</c:if>">
					                                <c:choose><c:when test="${user.enable == 1}">Active</c:when><c:otherwise>Inactive</c:otherwise></c:choose>
					                            </span>
					                            <div class="form-check form-switch form-check-custom form-check-solid <c:if test='${user.enable == 1}'>form-check-success</c:if> <c:if test='${user.enable != 1}'>form-check-muted</c:if>">
					                                <c:set var="uid" value="${user.id != null ? fn:trim(user.id) : ''}" />
					                                <input class="form-check-input h-20px w-35px js-toggle-enable" type="checkbox" id="active_grid_${uid}" data-userid="${uid}" data-enable="${user.enable}" <c:if test="${user.enable == 1}">checked</c:if> />
					                            </div>
					                        </div>
					                    </div>
					                </div>
					            </div>
					        </div>
					    </c:forEach>
					</div>

                    <div class="card-footer d-flex align-items-center gap-3 px-5 py-3 border-0 bg-transparent pt-0 mt-4">
                        <select id="rowsPerPage" class="form-select form-select-sm w-75px">
                            <option value="10" selected>10</option>
                            <option value="20">20</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                        </select>
                        <div id="tablePagination" class="ms-auto"></div>
                    </div>

                </div>
            </div>
        </div>
    </div>

<script>
(function () {
  var tableSelector = '#myTable';
  var paginationSelector = '#tablePagination';
  var rowsPerPageSelector = '#rowsPerPage';
  var gridItemsPerPage = 12;   
  var tableItemsPerPage = 10;
  var currentPage = 1;
  var isGridView = false;
  var activeFilters  = { status: '1', anniversaries: '', birthdays: '' };
  var sortedCardCache = null;



  function $rowsAll(){ return $(tableSelector + ' tbody tr'); }
  function $gridCardsAll() { return $('#gridViewContainer .grid-card'); }

  function toDateYmd(iso) {
    if (!iso) return null;
    var m = String(iso).trim().match(/^(\d{4})-(\d{2})-(\d{2})/);
    if (!m) return null;
    return new Date(+m[1], +m[2]-1, +m[3]);
  }
  function asUTCDate(d){ return new Date(Date.UTC(d.getFullYear(), d.getMonth(), d.getDate())); }
  function daysBetween(a,b){ return Math.round((asUTCDate(b) - asUTCDate(a)) / 86400000); }
  function startOfWeekMonday(d){
    var t = new Date(d.getFullYear(), d.getMonth(), d.getDate());
    var dow = (t.getDay() + 6) % 7; 
    t.setDate(t.getDate() - dow);
    return t;
  }
  function clampFeb29(year, month, day){
    if (month === 1 && day === 29) {
      var dd = new Date(year, 1, 29);
      if (dd.getMonth() !== 1) return new Date(year, 1, 28);
    }
    return new Date(year, month, day);
  }
  function computeNextOccurrence(baseDate, today) {
    today = today || new Date();
    var thisYear = today.getFullYear();
    var next = clampFeb29(thisYear, baseDate.getMonth(), baseDate.getDate());
    if (daysBetween(today, next) < 0) next = clampFeb29(thisYear + 1, baseDate.getMonth(), baseDate.getDate());
    var ws = startOfWeekMonday(today);
    var we = new Date(ws.getFullYear(), ws.getMonth(), ws.getDate() + 6);
    return {
      nextDate: next,
      daysLeft: Math.max(0, daysBetween(today, next)),
      inThisMonth: next.getMonth() === today.getMonth(),
      inThisWeek:  (asUTCDate(next) >= asUTCDate(ws)) && (asUTCDate(next) <= asUTCDate(we))
    };
  }
  
  // 1. Anniversary Logic
  function applyAnnivData($el, startISO, today, isGrid) {
      const start = toDateYmd(startISO);
      if (!start || start > today){
        $el.attr({'data-anniv-years':'','data-anniv-days':'','data-anniv-thismonth':'0','data-anniv-thisweek':'0'});
        if(isGrid) $el.attr('data-anniv-text', '');
        return;
      }
      const info = computeNextOccurrence(start, today);
      const years = info.nextDate.getFullYear() - start.getFullYear();
      if (years <= 0) {
    	  $el.attr({
    	    'data-anniv-years':'0',
    	    'data-anniv-days':'',
    	    'data-anniv-thismonth':'0',
    	    'data-anniv-thisweek':'0'
    	  });
    	  if (isGrid) $el.attr('data-anniv-text', '');
    	  return;
    	}
      
      $el.attr({
        'data-anniv-years': years,
        'data-anniv-days' : info.daysLeft,
        'data-anniv-thismonth': info.inThisMonth ? '1' : '0',
        'data-anniv-thisweek' : info.inThisWeek  ? '1' : '0'
      });


      if (isGrid) {
          var yearLabel = (years === 1 ? '1 Year Anniversary' : (years + ' Year Anniversary'));
          var dayStr = (info.daysLeft === 0) ? 'today' : (info.daysLeft === 1 ? 'in 1 day' : ('in ' + info.daysLeft + ' days'));
          $el.attr('data-anniv-text', yearLabel + ' ' + dayStr);
      }
  }

  function annotateAnniversaries(){
    const today = new Date();

    $rowsAll().each(function(){
      const $tr = $(this);
      const startISO = ($tr.find('.period-text').attr('data-start') || '').trim();
      applyAnnivData($tr, startISO, today, false); 
    });

    $gridCardsAll().each(function(){
       const $card = $(this);
       const startISO = ($card.find('.period-display').attr('data-start') || '').trim();
       applyAnnivData($card, startISO, today, true);
    });
  }

  // 2. Birthday Logic
  function getBirthFromRow($tr){
    var iso = ($tr.attr('data-birth') || $tr.attr('data-dob') || $tr.attr('data-birthday') || '').trim();
    return toDateYmd(iso);
  }

  function applyBirthData($el, dob, today, isGrid){
      if (!dob){
        $el.attr({'data-bday-days':'','data-bday-thismonth':'0','data-bday-thisweek':'0'});
        if(isGrid) $el.attr('data-bday-text', '');
        return;
      }
      const info = computeNextOccurrence(dob, today);
      

      $el.attr({
        'data-bday-days'     : info.daysLeft,
        'data-bday-thismonth': info.inThisMonth ? '1' : '0',
        'data-bday-thisweek' : info.inThisWeek  ? '1' : '0'
      });


      if (isGrid) {
          var msg = (info.daysLeft===0) ? 'Birthday today'
                  : (info.daysLeft===1) ? 'Birthday in 1 day'
                  : 'Birthday in ' + info.daysLeft + ' days';
          $el.attr('data-bday-text', msg);
      }
  }

  function annotateBirthdays(){
    const today = new Date();

    $rowsAll().each(function(){
       const $tr = $(this);
       const dob = getBirthFromRow($tr); 
       applyBirthData($tr, dob, today, false);
    });

    $gridCardsAll().each(function(){
       const $card = $(this);
       let iso = ($card.find('.birth-age').attr('data-birth-date') || '').trim();
       const dob = toDateYmd(iso);
       applyBirthData($card, dob, today, true);
    });
  }

  function renderTableBirthdayIcons() {
      $rowsAll().each(function() {
          var $tr = $(this);
          var $cell = $tr.find('.bday-cell');

          var isMonth = $tr.attr('data-bday-thismonth') === '1';
          var isWeek = $tr.attr('data-bday-thisweek') === '1';
          

          if (isMonth || isWeek) {
              $cell.html('<i class="ki-duotone ki-gift fs-1 text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>');
          } else {
              $cell.empty();
          }
      });
  }

 // format period display
  function toISODateOnly(s) {
      if (!s) return null;
      var trimmed = String(s).trim().substring(0, 10);
      var m = trimmed.match(/^(\d{4})-(\d{2})-(\d{2})$/);
      if (!m) return null;
      var date = new Date(parseInt(m[1], 10), parseInt(m[2], 10) - 1, parseInt(m[3], 10));
      return isNaN(date.getTime()) ? null : date;
  }
  function fmtDateDMY(iso){
      const d = toISODateOnly(iso);
      if(!d) return null;
      return d.toLocaleDateString('en-GB', { day:'2-digit', month:'short', year:'numeric' }).replace(/ /g,' ');
  }
  function periodLengthLabel(sISO, eISO){
      const s = toISODateOnly(sISO);
      if(!s) return '-';
      const e = eISO ? toISODateOnly(eISO) : new Date();
      if(!e) return '-';
      if (s > e) return 'Waiting to start.';
      
      let y = e.getFullYear() - s.getFullYear();
      let m = e.getMonth() - s.getMonth();
      let d = e.getDate() - s.getDate();
      if (d < 0){ m--; d += new Date(e.getFullYear(), e.getMonth(), 0).getDate(); }
      if (m < 0){ y--; m += 12; }
      const parts = [];
      if (y > 0) parts.push(y + 'y');
      if (m > 0) parts.push(m + 'm');
      if (!parts.length && d >= 0) parts.push(d + 'd');
      return parts.join(' ');
  }
  
  function birthdayAgeLabel(bISO){
	  const b = toISODateOnly(bISO);
	  if(!b) return '-';

	  const today = new Date();
	  let y = today.getFullYear() - b.getFullYear();
	  let m = today.getMonth() - b.getMonth();
	  let d = today.getDate() - b.getDate();

	  if (d < 0) {
	    m--;
	    d += new Date(today.getFullYear(), today.getMonth(), 0).getDate();
	  }
	  if (m < 0) {
	    y--;
	    m += 12;
	  }

	  const parts = [];
	  if (y > 0) parts.push(y + 'y');
	  if (m > 0) parts.push(m + 'm');
	  if (!parts.length) parts.push('0y');

	  return parts.join(' ');
	}

  
  function renderPeriods() {
      // Table View Period rendering
      document.querySelectorAll('.period-text').forEach(function (el) {
        const sISO = el.getAttribute('data-start');
        const eISO = el.getAttribute('data-end');
        const sTxt = fmtDateDMY(sISO);
        const eTxt = fmtDateDMY(eISO);
        const len  = periodLengthLabel(sISO, eISO);
        

        const $tr = $(el).closest('tr');
        const isAnniv = ($tr.attr('data-anniv-thismonth') === '1' || $tr.attr('data-anniv-thisweek') === '1');
        

        const colorClass = isAnniv ? 'text-primary fw-bold' : 'text-muted'; 

        if (!sTxt) { el.textContent = '-'; return; }
        
        let html = '<div class="">' + (eTxt ? (sTxt + ' to<br>' + eTxt) : sTxt) + '</div>';
        
        html += '<div class="' + colorClass + ' fs-7 mt-1">' + (len || '-') + '</div>';
        
        el.innerHTML = html;
      });
  }
  function renderGridDurations() {
      // 1. Anniversary
      document.querySelectorAll('#gridViewContainer .period-display').forEach(function (el) {
        const sISO = el.getAttribute('data-start');
        const eISO = el.getAttribute('data-end');
        const label = periodLengthLabel(sISO, eISO);
        el.textContent = label || '-';

        const $gridCard = $(el).closest('.grid-card');
        const isAnniv = ($gridCard.attr('data-anniv-thismonth') === '1' || $gridCard.attr('data-anniv-thisweek') === '1');
        
        const $infoRow = $(el).closest('.info-row');
        const $icon = $infoRow.find('i.ki-time');
        const $text = $infoRow.find('.info-text');

        if(isAnniv) {
            $icon.removeClass('text-gray-400').addClass('text-primary');
            $text.addClass('text-primary fw-bold');
            $(el).addClass('text-primary fw-bold');
        } else {
            $icon.removeClass('text-primary').addClass('text-gray-400');
            $text.removeClass('text-primary fw-bold');
            $(el).removeClass('text-primary fw-bold');
        }
      });
	
      // 2. Birthday
      document.querySelectorAll('#gridViewContainer .birth-age').forEach(function (el) {
        const bISO = el.getAttribute('data-birth-date') || el.getAttribute('data-birth');
       /* 
        const label = periodLengthLabel(bISO, null); */
        el.textContent = birthdayAgeLabel(bISO);

        const $gridCard = $(el).closest('.grid-card');
        const isBday = ($gridCard.attr('data-bday-thismonth') === '1' || $gridCard.attr('data-bday-thisweek') === '1');

        const $infoRow = $(el).closest('.info-row');
        const $icon = $infoRow.find('i.ki-gift');
        const $text = $infoRow.find('.info-text');
        
        if(isBday) {
             $icon.removeClass('text-gray-400').addClass('text-primary');
             $text.addClass('text-primary fw-bold');
             $(el).addClass('text-primary fw-bold');
        } else {
             $icon.removeClass('text-primary').addClass('text-gray-400');
             $text.removeClass('text-primary fw-bold');
             $(el).removeClass('text-primary fw-bold');
        }
      });
  }

  //filter view
  function rowPassesFilters($tr){
    if ($tr.attr('data-filtered') === '0') return false;
    // Status Filter
    var st = (activeFilters.status || '');
    if (st === '3') st = '';
    if (st !== '') {
      var $cb = $tr.find('.form-check-input[type="checkbox"]').first();
      var enabled = $cb.length ? $cb.prop('checked') : null;
      if (enabled !== null) {
        if (st === '1' && !enabled) return false;
        if (st === '2' &&  enabled) return false;
      }
    }
    // Anniversaries Filter
    var an = String(activeFilters.anniversaries || '');
    if (an === '1' && $tr.attr('data-anniv-thismonth') !== '1') return false;
    if (an === '2' && $tr.attr('data-anniv-thisweek')  !== '1') return false;
    
    // Birthdays Filter
    var bd = String(activeFilters.birthdays || '');
    if (bd === '1' && $tr.attr('data-bday-thismonth') !== '1') return false;
    if (bd === '2' && $tr.attr('data-bday-thisweek')  !== '1') return false;
    return true;
  }
   
  function cardPassesFilters($card){
    if ($card.attr('data-filtered') === '0') return false;
    var st = (activeFilters.status || '');
    if (st === '3') st = '';
    if (st !== '') {
      var $cb = $card.find('.js-toggle-enable');
      var enabled = null;
      if ($cb.length) enabled = (String($cb.attr('data-enable')) === '1');
      if (enabled !== null) {
        if (st === '1' && !enabled) return false;
        if (st === '2' &&  enabled) return false;
      }
    }
    var an = String(activeFilters.anniversaries || '');
    if (an === '1' && $card.attr('data-anniv-thismonth') !== '1') return false;
    if (an === '2' && $card.attr('data-anniv-thisweek')  !== '1') return false;
    var bd = String(activeFilters.birthdays || '');
    if (bd === '1' && $card.attr('data-bday-thismonth') !== '1') return false;
    if (bd === '2' && $card.attr('data-bday-thisweek')  !== '1') return false;
    return true;
  }

  function $rowsEligible(){ return $rowsAll().filter(function(){ return rowPassesFilters($(this)); }); }
  function $cardsEligible(){ return $gridCardsAll().filter(function(){ return cardPassesFilters($(this)); }); }

  function updateShowingText(total, totalAll){
    var badges = [];
    if (activeFilters.status === '1') badges.push('Status: Active');
    if (activeFilters.status === '2') badges.push('Status: Non active');
    if (String(activeFilters.anniversaries) === '1') badges.push('Anniversary month');
    if (String(activeFilters.anniversaries) === '2') badges.push('Anniversary week');
    if (String(activeFilters.birthdays) === '1') badges.push('Birthday month');
    if (String(activeFilters.birthdays) === '2') badges.push('Birthday week');

 	var count = badges.length ? total : totalAll;
    
    var base = 'Employee (' + count + ')';
    /* var base = 'Employee (' + totalAll + ')'; */
    var desc = badges.length ? '<span class="fs-6 text-muted fw-normal ms-2"> • Filtered by: ' + badges.join(', ') + '</span>' : '';
    $('#dt_showing').html('<h3 class="fw-bold text-gray-900 m-0 d-flex align-items-center">' + base + desc + '</h3>');
    $('#dt_showing').removeClass('fs-7 text-dark'); 
  }

  function renderTablePagination(totalPages){
    var $nav = $(paginationSelector);
    if (!totalPages || totalPages < 1){ $nav.html(''); return; }
    var html = '<ul class="pagination pagination-sm align-items-center gap-1 mb-0">';
    html += '<li class="page-item ' + (currentPage===1?'disabled':'') + '"><a href="#" class="page-link" data-page="'+(currentPage-1)+'"><i class="ki-outline ki-left"></i></a></li>';
    var windowSize = 5;
    var startPage = Math.max(1, currentPage - 2);
    var endPage   = Math.min(totalPages, startPage + windowSize - 1);
    startPage = Math.max(1, Math.min(startPage, totalPages - windowSize + 1));
    if (startPage > 1){
      html += '<li class="page-item"><a class="page-link" data-page="1" href="#">1</a></li>';
      if (startPage > 2) html += '<li class="page-item ellipsis"><span class="page-link">...</span></li>';
    }
    for (var i=startPage;i<=endPage;i++){
      html += '<li class="page-item '+(i===currentPage?'active':'')+'"><a href="#" class="page-link" data-page="'+i+'">'+i+'</a></li>';
    }
    if (endPage < totalPages){
      if (endPage < totalPages - 1) html += '<li class="page-item ellipsis"><span class="page-link">...</span></li>';
      html += '<li class="page-item"><a class="page-link" data-page="'+totalPages+'" href="#">'+totalPages+'</a></li>';
    }
    html += '<li class="page-item ' + (currentPage===totalPages?'disabled':'') + '"><a href="#" class="page-link" data-page="'+(currentPage+1)+'"><i class="ki-outline ki-right"></i></a></li>';
    html += '</ul>';
    $nav.html(html);
  }
  
  function renumberTableRows(startIndex){
		 startIndex = startIndex || 0;
		 let count = startIndex + 1;

		  $('#myTable tbody tr:visible').each(function () {
		    $(this).find('.row-number').text(count++);
		  });
	}

  function showTablePage(page) {
    annotateAnniversaries();
    annotateBirthdays();

    const $all = $rowsAll();
    const $eligible = $rowsEligible();
    const totalEligible = $eligible.length;
    const totalPages = Math.max(1, Math.ceil(totalEligible / tableItemsPerPage));
    currentPage = Math.min(Math.max(page, 1), totalPages);
    const start = (currentPage - 1) * tableItemsPerPage;
    const end   = start + tableItemsPerPage;
    $all.hide();
    $eligible.slice(start, end).show();
    renderTablePagination(totalPages);
    renderPeriods();
    renderTableBirthdayIcons(); 
    
    renumberTableRows(start);
    
    updateShowingText(totalEligible, $all.length);
  }

  function showGridPage(page) {
	    annotateAnniversaries();
	    annotateBirthdays();

	    var $all = $gridCardsAll();
	    var source = sortedCardCache ? sortedCardCache : $all.get();

	    var eligible = $(source).filter(function() {
	        return cardPassesFilters($(this));
	    }).get();

	    var totalEligible = eligible.length;
	    var totalPages = Math.max(1, Math.ceil(totalEligible / gridItemsPerPage));
	    currentPage = Math.min(Math.max(page, 1), totalPages);

	    var start = (currentPage - 1) * gridItemsPerPage;
	    var end = start + gridItemsPerPage;

	    $all.addClass('d-none');
	    $(eligible.slice(start, end)).removeClass('d-none');

	    renderTablePagination(totalPages);
	    renderGridDurations();
	    updateShowingText(totalEligible, $all.length);
	}


  function refreshCurrentView() {
      if (isGridView) showGridPage(1);
      else showTablePage(1);
  }

  //Search & Reset Logic
  function showOnlyUserWithReset(id) {
    id = (id || '').trim();
    const $rows = $rowsAll();
    const $cards = $gridCardsAll();
    if (!id || id.toLowerCase() === 'all'){
      $rows.attr('data-filtered','1');
      $cards.attr('data-filtered','1');
    } else {
      $rows.each(function () {
        const match = String($(this).attr('data-user-id') || '').trim() === id;
        $(this).attr('data-filtered', match ? '1' : '0');
      });
      $cards.each(function () {
        const $innerCard = $(this).find('.card');
        const cardUserId = String($innerCard.attr('data-user-id') || '').trim();
        const match = (cardUserId === id);
        $(this).attr('data-filtered', match ? '1' : '0');
      });
    }
    sortedCardCache = null;
    refreshCurrentView();
  }

  function showAllUsers(){
    $rowsAll().attr('data-filtered','1');
    $gridCardsAll().attr('data-filtered','1'); 
    activeFilters = { status: '1', birthdays: '3', anniversaries: '3' };
    sortedCardCache = null
    sortedCache = null
    currentPage = 1;
    $('#statusSelect').val('1').trigger('change.select2');
    $('#birthdaysSelect').val('3').trigger('change.select2');
    $('#anniversariesSelect').val('3').trigger('change.select2');
    
    $('#name2').val('All').trigger('change.select2');
    
    var currentSortMode = $('#sortSelect').val() || 'empid-asc';
    if (isGridView) {
        sortCards(currentSortMode);
        showGridPage(1); 
    } else {
        sortRows(currentSortMode); 
    }
    /* refreshCurrentView();  */
  }

  function searchBySelectValue(user_id) {
	  user_id = (user_id || '').trim();
   /*  if (!user_id || user_id === 'All') { showAllUsers(); return; } */
    if (!user_id) { showAllUsers(); return; }
    $.ajax({
      url: "search-User",
      type: "POST",
      dataType: "json",
      data: { "user_id": user_id },
      success: function (data) {
        const selectedId = String((data && (data.id || data.user_id)) || user_id).trim();
        showOnlyUserWithReset(selectedId);
      },
      error: function () {
        showOnlyUserWithReset(user_id);
      }
    });
  }

  //sorting
  (function(){
    var currentSort = 'empid-asc';
    var sortedCache = null;
    function textOf($tr, idx){ return ($tr.children().eq(idx).text() || '').replace(/\u00A0/g,' ').trim(); }
    function empIdKey($tr){
      var raw = textOf($tr,0);
      var num = parseInt((raw.match(/\d+/)||[''])[0],10);
      return {raw: raw.toLowerCase(), num: isNaN(num)?-1:num};
    }
    function nameKey($tr){
      var primary = $tr.find('td:nth-child(3) .fw-semibold').text().trim(); 
      var fallback = $tr.find('td:nth-child(3) .text-muted').text().trim();
      return (primary || fallback || '').toLowerCase();
    }
    function siteKey($tr){ return ($tr.find('td:nth-child(5) .badge').first().text().trim() || '').toLowerCase(); }
    function toMsStart($tr){ var el = $tr.find('.period-text')[0]; if(!el) return 0; var d = toISODateOnly(el.getAttribute('data-start')||''); return d?d.getTime():0; }
    function periodDays($tr){
      var el = $tr.find('.period-text')[0]; if(!el) return 0;
      var s = toISODateOnly(el.getAttribute('data-start')||'');
      var e = el.getAttribute('data-end') ? toISODateOnly(el.getAttribute('data-end')) : new Date();
      return (s && e) ? Math.round((e-s)/86400000) : 0;
    }
    function birthMs($tr){ 
        var iso = ($tr.attr('data-birth') || '').trim();
        var d = toDateYmd(iso);
        return d?d.getTime():0; 
    }
    function cmp(a,b){ return a<b?-1:(a>b?1:0); }

    function sortRows(mode){
      currentSort = mode || currentSort;
      var rows = $rowsAll().get();
      rows.sort(function(ra, rb){
        var $a=$(ra), $b=$(rb);
        switch(currentSort){
          case 'empid-asc':  { var ka=empIdKey($a), kb=empIdKey($b); return ka.num!==kb.num ? ka.num-kb.num : cmp(ka.raw,kb.raw); }
          case 'empid-desc': { var ka=empIdKey($a), kb=empIdKey($b); return ka.num!==kb.num ? kb.num-ka.num : cmp(kb.raw,ka.raw); }
          case 'name-asc':   return cmp(nameKey($a), nameKey($b));
          case 'name-desc':  return cmp(nameKey($b), nameKey($a));
          case 'site-asc':   return cmp(siteKey($a), siteKey($b));
          case 'site-desc':  return cmp(siteKey($b), siteKey($a));
          case 'period-asc': return periodDays($a) - periodDays($b);
          case 'period-desc':return periodDays($b) - periodDays($a);
          case 'startdate-asc':  return toMsStart($a) - toMsStart($b);
          case 'startdate-desc': return toMsStart($b) - toMsStart($a);
          case 'birth-young':    return birthMs($b) - birthMs($a);
          case 'birth-old':      return birthMs($a) - birthMs($b);
          default: return 0;
        }
      });
      sortedCache = rows;
      showTablePage = function(page){
        var $all = $($rowsAll());
        $all.hide();
        var eligible = [];
        $(sortedCache).each(function(){
          if (rowPassesFilters($(this))) eligible.push(this);
        });
        var totalEligible = eligible.length;
        var totalPages = Math.max(1, Math.ceil(totalEligible / tableItemsPerPage));
        currentPage = Math.min(Math.max(page, 1), totalPages);
        var start = (currentPage - 1) * tableItemsPerPage;
        var end   = start + tableItemsPerPage;
        $(eligible.slice(start,end)).show();
        renderTablePagination(totalPages);
        renderPeriods();
        renderTableBirthdayIcons(); 
        
        renumberTableRows(start);
        
        updateShowingText(totalEligible, $all.length);
      };
      refreshCurrentView();
    }
    $(function(){
     /*  $('#sortSelect').on('change', function(){ sortRows(this.value); });
      sortRows($('#sortSelect').val() || 'empid-asc'); */
    	$('#sortSelect').on('change', function () {
    		  var mode = this.value;
    		  currentPage = 1;
    		  
    		  if (isGridView) {
    		    sortCards(mode);   
    		    showGridPage(1);   
    		  } else {
    		    sortRows(mode); 
    		  }
    		});

    });
    
    function sortCards(mode) {
        var $container = $('#gridViewContainer');
        var cards = $gridCardsAll().get();

        function cmp(a, b) { return a < b ? -1 : (a > b ? 1 : 0); }

        //แยกตัวเลขออกจาก string
        function empIdKeyCard($c) {
            var raw = ($c.find('.employee-id').text() || '').trim();
            var numMatch = raw.match(/\d+/);
            var num = numMatch ? parseInt(numMatch[0], 10) : -1;
            return { raw: raw.toLowerCase(), num: num };
        }

        function nameKeyCard($c) {
            var name = $c.find('.employee-info span:first').text().trim() || 
                       $c.find('.fw-bold').first().text().trim();
            return name.toLowerCase();
        }

        function siteKeyCard($c) {
            return ($c.find('.badge').first().text().trim() || '').toLowerCase();
        }

        cards.sort(function(a, b) {
            var $a = $(a), $b = $(b);
            switch (mode) {
                case 'empid-asc': {
                    var ka = empIdKeyCard($a), kb = empIdKeyCard($b);
                    return ka.num !== kb.num ? ka.num - kb.num : cmp(ka.raw, kb.raw);
                }
                case 'empid-desc': {
                    var ka = empIdKeyCard($a), kb = empIdKeyCard($b);
                    return ka.num !== kb.num ? kb.num - ka.num : cmp(kb.raw, ka.raw);
                }
                case 'name-asc':   return cmp(nameKeyCard($a), nameKeyCard($b));
                case 'name-desc':  return cmp(nameKeyCard($b), nameKeyCard($a));
                case 'site-asc':   return cmp(siteKeyCard($a), siteKeyCard($b));
                case 'site-desc':  return cmp(siteKeyCard($b), siteKeyCard($a));
                case 'period-asc': return periodDaysCard($a) - periodDaysCard($b);
                case 'period-desc':return periodDaysCard($b) - periodDaysCard($a);
                case 'startdate-asc':  return startMsCard($a) - startMsCard($b);
                case 'startdate-desc': return startMsCard($b) - startMsCard($a);
                case 'birth-young':    return birthMsCard($b) - birthMsCard($a);
                case 'birth-old':      return birthMsCard($a) - birthMsCard($b);
                default: return 0;
            }
        });

        $.each(cards, function(i, card) { $container.append(card); });
        sortedCardCache = cards;
    }
  })();


  $(document).on('click', paginationSelector + ' .page-link', function(e){
    e.preventDefault();
    var page = parseInt($(this).data('page'), 10);
    if (isNaN(page)) return;
    isGridView ? showGridPage(page) : showTablePage(page);
  });

  $(rowsPerPageSelector).on('change', function(){
    var v = parseInt($(this).val(), 10);
    if (isNaN(v) || v <= 0) return;
    if (isGridView) { gridItemsPerPage = v; showGridPage(1); }
    else { tableItemsPerPage = v; showTablePage(1); }
  });

  $(document).on('change', '.js-toggle-enable', function () {
    const $cb  = $(this);
    const id   = $cb.data('userid');
    const next = $cb.prop('checked') ? 1 : 0;
    const prev = String($cb.data('enable')) === '1' ? 1 : 0;
    $cb.prop('disabled', true);

    $.ajax({
      type: 'POST',
      url: '${pageContext.request.contextPath}/update-user-status',
      dataType: 'json',
      data: { enable: next, userid: id },
      success: function (res) {
        const enabled = String(res.enable) === '1';
        $cb.prop('checked', enabled).attr('data-enable', enabled ? 1 : 0);
        // Sync Table
        const $td = $cb.closest('td[data-order]');
        if ($td.length) $td.attr('data-order', enabled ? 1 : 0);
        // Sync Grid
        const $card        = $cb.closest('.card');
        const $statusText = $card.find('.status-text');
        const $switchWrap = $cb.closest('.form-check');
        if ($statusText.length) {
          $statusText.text(enabled ? 'Active' : 'Inactive').toggleClass('text-success', enabled).toggleClass('text-muted', !enabled);
        }
        if ($switchWrap.length) {
          $switchWrap.toggleClass('form-check-success', enabled).toggleClass('form-check-muted', !enabled);
        }
        if (window.toastr) (enabled ? toastr.success : toastr.warning)((res.id || id) + (enabled ? ' enable success' : ' disable success'));
      },
      error: function () {
        $cb.prop('checked', prev === 1);
        if (window.toastr) toastr.error('Status update failed');
      },
      complete: function () { $cb.prop('disabled', false); }
    });
  });

  $('#btnGridView').on('click', function (e) {
    e.preventDefault();
    if (!isGridView) {
      isGridView = true;
      $('#tableViewContainer').addClass('d-none'); 
      $('#gridViewContainer').removeClass('d-none');
      showGridPage(1);
      $('#btnGridView').removeClass('btn-light-primary').addClass('btn-active-primary btn-color-primary active');
      $('#btnTableView').removeClass('btn-active-primary btn-color-primary active').addClass('btn-light-primary');
    }
  });

  $('#btnTableView').on('click', function (e) {
    e.preventDefault();
    if (isGridView) {
      isGridView = false;
      $('#gridViewContainer').addClass('d-none');
      $('#tableViewContainer').removeClass('d-none');
      showTablePage(1);
      $('#btnTableView').removeClass('d-none').addClass('btn-active-primary btn-color-primary active');
      $('#btnGridView').removeClass('btn-active-primary btn-color-primary active').addClass('btn-light-primary');
    }
  });

  $(function () {
    function initSel($el, noSearch){
      if(!$el.length) return;
      if ($el.data('select2') || $el.hasClass('select2-hidden-accessible')) return;
      $el.select2({
        theme: 'bootstrap-5',
        width: '100%',
        placeholder: $el.data('placeholder') || 'Select',
        allowClear: true,
        dropdownParent: $(document.body),
        minimumResultsForSearch: noSearch ? Infinity : 0
      });
    }

    initSel($('#name2')); 
    initSel($('#statusSelect'), true);
    initSel($('#birthdaysSelect'), true);
    initSel($('#anniversariesSelect'), true);
    $('#statusSelect').val('1').trigger('change.select2'); 
    $('#birthdaysSelect').val('3').trigger('change.select2'); 
    $('#anniversariesSelect').val('3').trigger('change.select2'); 
    activeFilters.status = '1';

    const $btn = $('#btnToggleFilters');
    const $fields = $('#filterFields');
    const $divider = $('.filter-divider');
    function setFiltersOpen(open){
      $btn.toggleClass('active', open).attr('aria-expanded', open);
      if(open){
        $btn.removeClass('btn-light-primary text-gray-600').addClass('btn-primary text-white');
        $divider.removeClass('d-none');
        $fields.stop(true,true).slideDown(150, function(){ $(this).removeClass('d-none'); });
      }else{
        $btn.removeClass('btn-primary text-white').addClass('btn-light-primary text-gray-600');
        $fields.stop(true,true).slideUp(150, function(){ $(this).addClass('d-none'); });
        $divider.addClass('d-none');
      }
    }
    setFiltersOpen(false);
    $btn.on('click', function(e){ e.preventDefault(); setFiltersOpen(!$btn.hasClass('active')); });

    $('#statusSelect').on('change', function(){
      var v = ($(this).val() || '');
      activeFilters.status = (v === '3') ? '' : v;
      refreshCurrentView();
    });
    $('#birthdaysSelect').on('change', function(){
      activeFilters.birthdays = ($(this).val() || '');
      refreshCurrentView();
    });
    $('#anniversariesSelect').on('change', function(){
      activeFilters.anniversaries = ($(this).val() || '');
      refreshCurrentView();
    });

    $("#name2").on("change select2:select", function () {
      const user_id = ($(this).val() || '').toString().trim();
      searchBySelectValue(user_id);
    });
    /* $("#name2").on("select2:clear", function(){ showAllUsers(); }); */
    $("#name2").on("select2:select change", function (e) {
	    const val = ($(this).val() || '').toString().trim();
	
	    if (val === '' || val === 'All') {
	    	setTimeout(function () {
	            showAllUsers();
	            $el.select2('close'); 
	          }, 0);

	          return;
	        }
	
	    searchBySelectValue(val);
	  })
	  .on("select2:clear", function () {
	    showAllUsers();      
  });

    
    window.addUser = function () { window.location.href = 'user-add'; };
  });

  isGridView = false;
  $('#tableViewContainer .card-body').removeClass('d-none');
  $('#gridViewContainer').addClass('d-none');
  
  setTimeout(function(){ 
      annotateAnniversaries(); 
      annotateBirthdays();     
      showTablePage(1); 
  }, 100);

})();
</script>

</body>
</html>