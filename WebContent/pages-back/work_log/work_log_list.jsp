<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>

<style>
  .xml-icon {
    display: inline-block;
    width: 24px;
    height: 24px;
    background-image: url('https://cdn-icons-png.flaticon.com/512/337/337959.png');
    background-size: cover;
    background-repeat: no-repeat;
  }
    .select2-results__group {
        font-size: 10px !important;
        color: #A1A5B7 !important;
        text-transform: uppercase !important;
        font-weight: 500 !important;
        padding-top: 10px !important;
        padding-bottom: 5px !important;
    }
    .badge-light-info {
    background-color: #E3D7FB !important;
    color: var(--bs-info) !important;
    }
    .badge-light-success {
    background-color: #D1F4DD !important;
    color: var(--bs-success) !important;
    }
    
    .form-check.form-check-info .form-check-input:checked {
    background-color: var(--bs-info);
    }
</style>

<perm:permission object="report.view">   
    <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
        <div class="d-flex flex-column flex-column-fluid">
         
            <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
                <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                    <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                        <h1 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center my-0">Work Log</h1>
                        <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                            <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
                            <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                            <li class="breadcrumb-item text-muted fw-medium fs-7">Admin Management</li>
                        </ul>
                    </div>
              
                    <div class="d-flex align-items-center gap-2 gap-lg-3">
                        <a href="javascript:;" id="exportExcelBtn" class="btn btn-secondary">
                            <i class="xml-icon me-2"></i> 
                            <span class="fw-medium fs-6 text-secondary-inverse">Download Excel</span>
                        </a>
                    </div>
                    
                </div>
            </div>
            
            <div id="kt_app_content_container" class="app-container container-fluid">
                
                <form action="work_log.action" method="post" id="filterForm">
                    <div class="card card-flush shadow-sm mb-5">
                        <div class="card-body py-5">
                            <div class="row g-5">
                            
                                <div class="col-md-9">
                                    <div class="input-group flex-nowrap">
                                        <span class="input-group-text bg-transparent border-end-0 h-45px">
                                            <i class="ki-duotone ki-magnifier fs-3"><span class="path1"></span><span class="path2"></span></i>
                                        </span>
                                        <div class="flex-grow-1">
                                            <select name="searchText" id="userSelect" class="form-select rounded-start-0 border-start-0 h-45px" data-control="select2">
                                                <option value="">All</option>
                                                <optgroup label="User Enable" class="text-muted fs-8 fw-bold text-uppercase">
                                                   <c:forEach var="u" items="${userList}">
                                                        <c:set var="label" value="" />
                                                        
                                                        <c:if test="${not empty u.employee_id}">
                                                            <c:set var="label" value="${u.employee_id}" />
                                                        </c:if>
                                                        <c:if test="${not empty u.name_en}">
                                                            <c:if test="${not empty label}"><c:set var="label" value="${label} - " /></c:if>
                                                            <c:set var="label" value="${label}${u.name_en}" />
                                                        </c:if>
                                                        <c:if test="${not empty u.name}">
                                                            <c:if test="${not empty label}"><c:set var="label" value="${label} - " /></c:if>
                                                            <c:set var="label" value="${label}${u.name}" />
                                                        </c:if>
                                                        <c:if test="${not empty u.role_id}">
                                                            <c:if test="${not empty label}"><c:set var="label" value="${label} - " /></c:if>
                                                            <c:set var="label" value="${label}${u.role_id}" />
                                                        </c:if>
                                                    
                                                        <option value="${u.id}" ${criteria.searchText eq u.id ? 'selected' : ''}>
                                                            ${label}
                                                        </option>
                                                        
                                                    </c:forEach>
                                                </optgroup>
                                            </select>
                                        </div>
                                    </div>
                               </div>
                               
                               <div class="col-md-3">
                                    <div class="input-group flex-nowrap">
                                        <span class="input-group-text">Sortting
                                        </span>
                                        <div class="overflow-hidden flex-grow-1">
                                            <select name="sortting" class="form-select rounded-start-0" data-control="select2" data-hide-search="true">
                                                <option value="1">ASC</option>
                                                <option value="2">DESC</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                               
                                <div class="col-md-3">
                                    <label class="form-label fs-7 fw-bold text-gray-700">Status:</label>
                                    <select name="status" class="form-select" data-control="select2" data-hide-search="true">
                                        <option value="">All Status</option>
                                            <optgroup label="Status Enable" class="text-muted fs-8 fw-bold text-uppercase">
                                            <option value="OnTime" <c:if test="${criteria.status eq 'OnTime'}">selected</c:if>>On Time</option>
                                            <option value="Late" <c:if test="${criteria.status eq 'Late'}">selected</c:if>>Late</option>
                                            <option value="Early Out" <c:if test="${criteria.status eq 'Early Out'}">selected</c:if>>Early Out</option>
                                            <option value="Finished Work" <c:if test="${criteria.status eq 'Finished Work'}">selected</c:if>>Finished Work</option>
                                            <option value="Unfinished Work" <c:if test="${criteria.status eq 'Unfinished Work'}">selected</c:if>>Unfinished Work</option>
                                        </optgroup>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label fs-7 fw-bold text-gray-700">Site:</label>
                                    <select name="siteId" class="form-select" data-control="select2" data-hide-search="true">
                                        <option value="">All Site</option>
                                        <optgroup label="Site Enable" class="text-muted fs-8 fw-bold text-uppercase">
                                            <c:forEach var="site" items="${siteList}">
                                                <option value="${site.id_sitejob}" <c:if test="${criteria.siteId eq site.id_sitejob}">selected</c:if>>${site.name_site}</option>
                                            </c:forEach>
                                        </optgroup>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label fs-7 fw-bold text-gray-700">Start Date:</label>
                                    <div class="position-relative d-flex align-items-center">
                                        <i class="ki-duotone ki-calendar-8 position-absolute ms-4 mb-1 text-gray-500 fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span></i>
                                        <input class="form-control form-control ps-12 datepicker" placeholder="Select date" name="startDate" value="${not empty criteria.startDate ? criteria.startDate : defaultStartDate}" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label fs-7 fw-bold text-gray-700">End Date:</label>
                                    <div class="position-relative d-flex align-items-center">
                                        <i class="ki-duotone ki-calendar-8 position-absolute ms-4 mb-1 text-gray-500 fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span></i>
                                        <input class="form-control form-control ps-12 datepicker" placeholder="Select date" name="endDate" value="${not empty criteria.endDate ? criteria.endDate : defaultEndDate}" />
                                    </div>
                                </div>    
                            </div>
                        </div>
                    </div>
                </form>
                
                <div id="content-update-area">
                    <div class="d-flex flex-wrap justify-content-between align-items-center my-10 gap-3">
                        <h3 class="page-heading text-gray-900 fw-bold mb-0">
                            <span id="itemsFoundCount">0</span> Items Found 
                            <span class="fs-6 fw-semibold text-gray-500">by Recent Updates ↓</span>
                        </h3>
                       
                        <div class="d-flex flex-wrap align-items-center gap-2">
                            <span class="badge badge-secondary fs-7 py-2"><i class="ki-duotone ki-map fs-2 me-1 text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i> On-Site</span>
                            <span class="badge badge-secondary fs-7 py-2"><i class="ki-duotone ki-home-2 fs-2 me-1 text-success"><span class="path1"></span><span class="path2"></span></i> WFH</span>
                            <span class="badge badge-secondary fs-7 py-2"><i class="ki-duotone ki-cube-2 fs-2 me-1 text-danger"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i> Head Office</span>
                            <span class="badge badge-success fw-bold fs-7 py-2">Ontime</span>
                            <span class="badge badge-primary fw-bold fs-7 py-2">Finished Work</span>
                            <span class="badge badge-warning fw-bold fs-7 py-2">Late</span>
                            <span class="badge badge-warning fw-bold fs-7 py-2">Early Out</span>
                            <span class="badge badge-danger fw-bold fs-7 py-2">Unfinished Work</span>
                        </div>
                    </div>
                
                    <div class="card card-flush shadow-sm">
                        <div class="card-body pt-0">
                            <div class="table-responsive" id="resultArea">
                                <div class="mt-10 mb-5">
                                    <h3 class="text-gray-900 fw-semibold">Work Log - Check In / Check Out</h3>
                                </div>
                                <table class="table align-middle table-row-dashed fs-6 gy-5">
                                    <thead>
                                        <tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0">
                                            <th style="width: 250px; max-width: 300px;">User</th>
                                            <th style="width: 150px; max-width: 150px;">Type</th>
                                            <th style="width: 300px; max-width: 300px;">Date - Time</th>
                                            <th class="min-w-100px">Time stamp / IP</th>
                                            <!-- <th class="text-center min-w-60px">GPS</th> -->
                                            <th class="min-w-100px">Status</th>
                                            <th class="text-end min-w-70px pe-4">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody class="fw-semibold text-gray-600" id="tableBody">
                                        <tr>
                                            <td colspan="6" class="text-center py-10 text-muted">
                                                <span class="spinner-border text-primary"></span><br>
                                                <span class="text-muted fs-6 fw-semibold mt-5">Loading...</span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
    
            </div>
        
        </div>
    </div>
    
    <div class="modal fade" id="editWorkLogModal" tabindex="-1" aria-hidden="true" data-bs-focus="false">
        <div class="modal-dialog modal-dialog-centered mw-650px">
            <div class="modal-content rounded">
                <div class="modal-header pb-0 border-1">
                    <h2 class="justify-content-start mb-4">Edit Work Log</h2>
                    <div class="btn btn-sm btn-icon btn-active-color-primary justify-content-end mb-4" data-bs-dismiss="modal">
                        <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                    </div>
                </div>
                
                <div class="modal-body scroll-y px-10 px-lg-15 pt-0 pb-15">
                    <form id="editWorkLogForm" class="form" action="#">
                        <input type="hidden" name="id" id="edit_id" />
    
                        <div class="d-flex align-items-center flex-wrap my-8">
                            <span class="fs-5 fw-semibold text-primary" id="edit_user_display"></span>
                        </div>
    
                        <div class="row mb-8">
                            <div class="col-md-6 fv-row">
                                <label class="required form-label fw-semibold mb-2">Date</label>
                                <div class="position-relative d-flex align-items-center">
                                    <i class="ki-duotone ki-calendar-8 fs-2 position-absolute mx-4" style="z-index: 10;"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span></i>
                                    <input class="form-control ps-12" placeholder="Select a date" name="date" id="edit_date" />
                                </div>
                            </div>
                            <div class="col-md-6 fv-row">
                                <label class="required form-label fw-semibold mb-2">Time</label>
                                <div class="position-relative d-flex align-items-center">
                                    <i class="ki-duotone ki-time fs-2 position-absolute mx-4" style="z-index: 10;"><span class="path1"></span><span class="path2"></span></i>
                                    <input type="text" class="form-control ps-12" placeholder="Select time" name="time" id="edit_time" />
                                </div>
                            </div>
                        </div>
    
                        <div class="d-flex flex-column mb-8 fv-row">
                            <div class="row g-9" data-kt-buttons="true" data-kt-buttons-target="[data-kt-button='true']">
                                <div class="col-6">
                                    <span class="form-check form-check-custom form-check-success form-check-solid form-check-md">
                                        <input class="form-check-input" type="radio" name="type" value="1" checked="checked" />
                                        <label class="form-check-label fs-6 fw-normal text-gray-800">Check In</label>
                                    </span>
                                </div>
                                <div class="col-6">
                                    <span class="form-check form-check-custom form-check-info form-check-solid form-check-md">
                                        <input class="form-check-input" type="radio" name="type" value="2" />
                                        <label class="form-check-label fs-6 fw-normal text-gray-800">Check Out</label>
                                    </span>
                                </div>
                            </div>
                        </div>
    
                        <div class="d-flex flex-column mb-8 fv-row">
                            <label class="d-flex align-items-center form-label fw-semibold mb-2 required">Location</label>
                            <div class="row g-9" data-kt-buttons="true" data-kt-buttons-target="[data-kt-button='true']">
                                <div class="col-4">
                                    <span class="form-check form-check-custom form-check-primary form-check-solid form-check-md">
                                        <input class="form-check-input" type="radio" name="location" value="1" />
                                        <i class="ki-duotone ki-map fs-1 ms-2 text-primary"> <span class="path1"></span> <span class="path2"></span> <span class="path3"></span></i>
                                        <label for="workType1" class="form-check-label fs-6 fw-normal text-gray-800">On-Site</label>
                                    </span>                                            
                                </div>
                                <div class="col-4">
                                    <span class="form-check form-check-custom form-check-primary form-check-solid form-check-md">
                                        <input class="form-check-input" type="radio" name="location" value="2" />
                                        <i class="ki-duotone ki-home-2 fs-1 ms-2 text-success"><span class="path1"></span> <span class="path2"></span></i>
                                        <label for="workType2" class="form-check-label fs-6 fw-normal text-gray-800">WFH</label>
                                    </span>
                                </div>
                                <div class="col-4">
                                    <span class="form-check form-check-custom form-check-primary form-check-solid form-check-md">
                                        <input class="form-check-input" type="radio" name="location" value="3" />
                                        <i class="ki-duotone ki-cube-2 fs-1 ms-2 text-danger"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
                                        <label for="workType2" class="form-check-label fs-6 fw-normal text-gray-800">Head Office</label>
                                    </span>
                                </div>
                            </div>
                        </div>
    
                        <div class="d-flex flex-column mb-8">
                            <label class="form-label fw-semibold mb-2">Reason</label>
                            <textarea class="form-control" rows="3" name="description" id="edit_description" placeholder="Please provide a reason."></textarea>
                        </div>
    
                        <div class="text-center">
                            <button type="reset" class="btn btn-light me-3" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" id="btn_submit_edit" class="btn btn-success" onclick="saveEditWorkLog()">
                                <span class="indicator-label">Submit</span>
                                <span class="indicator-progress">Please wait... <span class="spinner-border spinner-border-sm align-middle ms-2"></span></span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal bg-body fade" tabindex="-1" id="showMapModal">
    	<div class="modal-dialog modal-fullscreen">
	    	<div class="modal-content shadow-none">
	    		<div class="modal-header">
	    			<h5 class="modal-title">Work Location</h5>
	    			<!--begin::Close-->
	                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
	                    <i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span class="path2"></span></i>
	                </div>
	                <!--end::Close-->
	    		</div>
	    	</div>
    	</div>
    </div>
</perm:permission>

<script>
    var allWorkLogsData = [];      
    var displayWorkLogs = [];      
    var currentIndex = 0;          
    var batchSize = 50;            
    var currentMonth = '';         
    var progressInterval;          
    var currentRequest = null; 

    $(document).ready(function() {
        try {
            var isInit = true;

            // Init Plugins
            $('#userSelect').select2({allowClear: false});
            $('.datepicker').flatpickr({ 
                dateFormat: "d-m-Y", 
                altInput: true,
                altFormat: "j M Y",
                onChange: function(selectedDates, dateStr, instance) {
                    loadData();
                } 
            });

            // Bind Events
            $('#userSelect').on('change', function() { 
                if (!isInit) loadData(); 
            });

            $('select[name="siteId"]').on('change', function () {
                loadData();
            });

            $('select[name="status"], select[name="sortting"]').on('change', function () {
                renderLocalData();
            });
            
            $('#exportExcelBtn').click(function(e) {
                e.preventDefault();

                var params = {
                    searchText: $('select[name="searchText"]').val() || '',
                    sortting:  $('select[name="sortting"]').val() || '',
                    status:    $('select[name="status"]').val() || '',
                    siteId:    $('select[name="siteId"]').val() || '',
                    startDate: $('input[name="startDate"]').val() || '',
                    endDate:   $('input[name="endDate"]').val() || ''
                };

                var url = "${pageContext.request.contextPath}/export_excel.action?" + $.param(params);
                window.open(url, '_blank');
            });

            loadData();
            setTimeout(function(){ isInit = false; }, 500);

        } catch (e) {
            console.error("Init Error:", e);
        }
    });

    // --- Helper Functions ---
    function formatDate(dateString) {
        if (!dateString) return '';
        var date = new Date(dateString); 
        return date.toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' });
    }

    function formatTime(dateString) {
        if (!dateString) return '';
        var date = new Date(dateString);
        return date.toLocaleTimeString('en-GB', { hour: '2-digit', minute: '2-digit' });
    }

    function getMonthName(dateString) {
        var date = new Date(dateString);
        return date.toLocaleDateString('en-US', { month: 'long', year: 'numeric' });
    }

    function getDayColorClass(dateString) {
        if (!dateString) return 'bg-light';
        var date = new Date(dateString);
        var day = date.getDay(); 
        var colors = ['bg-danger', 'bg-warning', 'bg-pink', 'bg-success', 'bg-orange', 'bg-cyan', 'bg-info'];
        return colors[day] || 'bg-light';
    }

    function getWorkTypeIcon(type) {
        type = String(type).trim();
        if (type === '1') return '<div class="d-inline-flex align-items-center badge badge-light-success fw-bold px-4 py-2 fs-7">IN</div>';
        else if (type === '2') return '<div class="d-inline-flex align-items-center badge badge-light-info fw-bold px-4 py-2 fs-7">OUT</div>';
        return '<span class="badge badge-light text-gray-600">' + type + '</span>';
    }

    function getStatusBadge(status, duration) {
        status = String(status || '').trim();
        var badge = '';
        if (status === 'OnTime') badge = '<span class="badge badge-success fw-bold fs-7 py-2">Ontime</span>';
        else if (status === 'Late') badge = '<span class="badge badge-warning fw-bold text-white fs-7 py-2">Late</span>';
        else if (status === 'Early Out') badge = '<span class="badge badge-warning fw-bold text-white mb-1 fs-7 py-2">Early Out</span>';
        else if (status === 'Finished Work') badge = '<span class="badge badge-primary fw-bold mb-1 fs-7 py-2">Finished Work</span>';
        else if (status === 'Unfinished Work') badge = '<span class="badge badge-danger fw-bold mb-1 fs-7 py-2">Unfinished Work</span>';
        else { if(status) badge = '<span class="badge badge-light fw-bold fs-7 py-2">' + status + '</span>'; }

        if (duration && (status === 'Early Out' || status === 'Finished Work' || status === 'Unfinished Work')) {
             badge += '<span class="badge badge-light-primary fw-bold mt-2 fs-7 py-2">' + duration + '</span>';
        }
        return badge;
    }

    // --- Progress Bar Functions ---
    function startProgressSimulation() {
        clearInterval(progressInterval);
        var percent = 0;
        var updateUI = function(p) {
        	// -- loadingPercent --
            // $('#loadingPercent').text(Math.floor(p) + '%');
            $('#loadingBar').css('width', p + '%');
        };
        updateUI(0);

        progressInterval = setInterval(function() {
            var step = 0;
            if (percent < 30) step = 5;
            else if (percent < 60) step = 2;
            else if (percent < 80) step = 1;
            else if (percent < 95) step = 0.2;
            
            if (percent < 95) {
                percent += step;
                updateUI(percent);
            }
        }, 200);
    }

    function finishProgressSimulation() {
        clearInterval(progressInterval);
        // -- loadingPercent --
        // $('#loadingPercent').text('100%');
        $('#loadingBar').css('transition', 'none'); 
        $('#loadingBar').css('width', '100%');
        $('#loadingBar').addClass('w-100'); 
    }

    // --- LOADING FUNCTION ---
    window.loadData = function() {
        
        // Have Request -> Abort
        if (currentRequest) {
            currentRequest.abort();
            currentRequest = null;
        }

        var formData = $('#filterForm').serialize();
        
        // UI Loading
        var loadingHtml = 
            '<tr><td colspan="9" class="text-center py-10">' + 
                '<div class="d-flex flex-column align-items-center justify-content-center">' +
                    '<div class="spinner-border text-primary w-40px h-40px mb-3" role="status"></div>' +
                    '<div class="fs-4 fw-bold text-gray-800 mb-2">Loading Data...</div>' +
                	 // -- loadingPercent --
                    // '<div class="fs-2 fw-bold text-primary mb-2"><span id="loadingPercent">0%</span></div>' +
                    '<div class="progress h-6px w-300px bg-light-primary rounded">' +
                        '<div id="loadingBar" class="progress-bar bg-primary rounded fs-5" role="progressbar" style="width: 0%"></div>' +
                    '</div>' +
                '</div>' +
            '</td></tr>';

        $('#tableBody').html(loadingHtml);
        $('#resultArea').css('opacity', '0.5');
        
        startProgressSimulation();

        // Request into currentRequest
        currentRequest = $.ajax({
            url: "${pageContext.request.contextPath}/work_log_json.action", 
            type: "POST",
            data: formData,
            dataType: "json",
            success: function(response) {
                currentRequest = null;
                
                finishProgressSimulation();

                setTimeout(function() {
                    allWorkLogsData = response.workLogList || [];
                    renderLocalData(); 
                }, 500); 
            },
            error: function(jqXHR, textStatus, errorThrown) {
                // If Error is Abort
                if (textStatus === 'abort') {
                    return; 
                }
                // If etc. Error
                clearInterval(progressInterval);
                currentRequest = null;
                $('#tableBody').html('<tr><td colspan="9" class="text-center text-danger py-10">Error loading data.</td></tr>');
            }
        });
    }

    // --- FILTER FUNCTION ---
    function renderLocalData() {
        var statusFilter = $('select[name="status"]').val().toLowerCase();
        var siteFilter = $('select[name="siteId"]').val();
        var sortFilter = $('select[name="sortting"]').val(); 

        displayWorkLogs = allWorkLogsData.filter(function(item) {
            var itemStatus = (item.status || '').toLowerCase();
            if (statusFilter && itemStatus !== statusFilter) return false;
            
            return true;
        });

        displayWorkLogs.sort(function(a, b) {
            var timeA = a.work_hours_time_work ? new Date(a.work_hours_time_work).getTime() : 0;
            var timeB = b.work_hours_time_work ? new Date(b.work_hours_time_work).getTime() : 0;
            
            if (sortFilter === '2') { 
                return timeB - timeA;
            } else { 
                return timeA - timeB;
            }
        });

        $('#itemsFoundCount').text(displayWorkLogs.length);

        // Set Tabel
        currentIndex = 0;
        currentMonth = '';
        $('#tableBody').empty();

        if (displayWorkLogs.length === 0) {
            $('#tableBody').html('<tr><td colspan="9" class="text-center py-10 text-muted">No records found.</td></tr>');
            $('#resultArea').css('opacity', '1');
        } else {
            processBatch();
        }
        $('#resultArea').css('opacity', '1');
    }

    // --- TABEL FUNCTION ---
    function processBatch() {
        if (currentIndex >= displayWorkLogs.length) return;

        var html = '';
        var end = Math.min(currentIndex + batchSize, displayWorkLogs.length);

        for (var i = currentIndex; i < end; i++) {
            var item = displayWorkLogs[i];
            
            var thisMonth = getMonthName(item.work_hours_time_work);
            if (currentMonth !== thisMonth) {
                html += '<tr class="bg-light-primary"><td colspan="9" class="ps-4 py-3 rounded">' +
                        '<h4 class="text-primary fw-bold mb-0">' + thisMonth + '</h4></td></tr>';
                currentMonth = thisMonth;
            }

            var dayColor = getDayColorClass(item.work_hours_time_work);
            var workTypeIcon = getWorkTypeIcon(item.work_hours_type);
            var statusBadge = getStatusBadge(item.status, item.work_duration);
            var dateStr = formatDate(item.work_hours_time_work);
            var timeStr = formatTime(item.work_hours_time_work);
            var dowStr = new Date(item.work_hours_time_work).toLocaleDateString('en-US', { weekday: 'short' });
            
            var locationIcon = '';
            var workType = String(item.work_type || '').trim();
            if (workType === '1') locationIcon = '<i class="ki-duotone ki-map fs-1 text-primary ms-5" title="On-Site"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>';
            else if (workType === '2') locationIcon = '<i class="ki-duotone ki-home-2 fs-1 text-success ms-5" title="WFH"><span class="path1"></span><span class="path2"></span></i>';
            else if (workType === '3') locationIcon = '<i class="ki-duotone ki-cube-2 fs-1 text-danger ms-5" title="Head Office"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>'
            var descriptionHtml = item.description ? 
                '<div class="d-flex align-items-center mt-1 ms-4"><i class="ki-solid ki-message-text-2 fs-4 text-gray-400 fw-normal me-2"></i><span class="fw-normal text-gray-700 fs-6">' + item.description + '</span></div>' : '';

            var createTimeStr = item.time_update ? formatDate(item.time_update) + ', ' + formatTime(item.time_update) : '';
            var ipAddress = item.ip_address || '';
            var latitude = item.latitude || '';
            var longitude = item.longitude || '';
            //console.log(latitude);
            //console.log(longitude);
            
            var gpsButtonHtml = '';
            if (latitude && longitude) {
                gpsButtonHtml = '<a href="javascript:void(0)" onclick="showGPS(\'' + latitude + '\', \'' + longitude + '\')">' +
                '<i class="ki-duotone ki-geolocation-home text-danger fs-1 mx-2" data-bs-toggle="modal">' +
                '<span class="path1"></span><span class="path2"></span></i></a>';
			}
            
            html += '<tr>' +
                    '<td class="ps-4"><div class="d-flex flex-column">' +
                        '<span class="text-gray-800 fw-normal mb-1 fs-6">' + (item.name_en || '') + '</span>' +
                        '<span class="text-gray-600 fw-normal fs-6">' + (item.name || '') + '</span>' +
                    '</div></td>' +
                    '<td>' + workTypeIcon + '</td>' +
                    '<td><div class="d-flex flex-column">' +
                        '<div class="d-flex align-items-center mb-1">' +
                            '<div class="bullet bullet-vertical me-2 h-20px w-3px ' + dayColor + '"></div>' +
                            '<span class="text-gray-600 fw-normal fs-7 me-3">' + dowStr + '</span>' +
                            '<span class="text-gray-900 fw-normal fs-6 me-3">' + dateStr + '</span>' +
                            '<span class="me-3">' + locationIcon + '</span>' +
                            '<span class="badge badge-light-primary fw-bold fs-6">' + timeStr + '</span>' +
                        '</div>' + descriptionHtml +
                    '</div></td>' +
                    '<td>' +
                        '<span class="text-gray-800 fw-normal fs-6 d-block">' + createTimeStr + '</span>' +
                        '<span class="fw-normal text-gray-600 fs-6">' + ipAddress + '</span>' +
                    '</td>' +
                    /* '<td class="text-center">'+
                    	gpsButtonHtml +
                    '</td>' + */
                    '<td><div class="d-flex flex-column align-items-start">' + statusBadge + '</div></td>' +
                    '<td class="text-end pe-4">' +
                        '<a href="javascript:void(0)" onclick="openEditModal(' + i + ')" class="btn btn-icon btn-light-primary btn-sm">' +
                        	'<i class="ki-duotone ki-pencil fs-2"><span class="path1"></span><span class="path2"></span></i>' +
                   		 '</a>' +
                    '</td>' +
                    '</tr>';
        }

        $('#tableBody').append(html);
        currentIndex = end;
        setTimeout(processBatch, 0);
    }
    
    // --- MODAL FUNCTION ---
    function openEditModal(index) {
        var item = displayWorkLogs[index];
        if (!item) return;
        
		var infoParts = [];
        
        // User Name
        if (item.employee_id) infoParts.push(item.employee_id);
        if (item.name_en)     infoParts.push(item.name_en);
        if (item.name)        infoParts.push(item.name);
        if (item.role_id)     infoParts.push(item.role_id);
        var fullDisplayText = infoParts.join("  -  ");
        $('#edit_user_display').text(fullDisplayText || 'Unknown User');
        $('#edit_id').val(item.work_hours_id);

        // Reset Styles 
        $('input[name="type"]').closest('label').removeClass('active');

        // Set ID
        $('#edit_id').val(item.work_hours_id); 
        
        // Set Date & Time
        if (document.querySelector('#edit_date')._flatpickr) {
            document.querySelector('#edit_date')._flatpickr.destroy();
        }
        if (document.querySelector('#edit_time')._flatpickr) {
            document.querySelector('#edit_time')._flatpickr.destroy();
        }
        if (item.work_hours_time_work) {
            var dateObj = new Date(item.work_hours_time_work);
            // Date Picker
            $('#edit_date').flatpickr({ 
                dateFormat: "d-m-Y", 
                defaultDate: dateObj,
                static: true
            });
            // Time Picker
            $('#edit_time').flatpickr({
                enableTime: true,
                noCalendar: true,
                dateFormat: "H:i",
                time_24hr: true,
                defaultDate: dateObj,
                static: true
            });
        }

        // Set Type
        var typeVal = String(item.work_hours_type || '1');
        $('input[name="type"][value="' + typeVal + '"]').prop('checked', true);
        $('input[name="type"][value="' + typeVal + '"]').closest('label').addClass('active');

     	// Set Location
        var locVal = String(item.work_type || '1');
        $('input[name="location"]').closest('label').removeClass('active');
        var locationRadio = $('input[name="location"][value="' + locVal + '"]');
        locationRadio.prop('checked', true);
        locationRadio.closest('label').addClass('active');

        // Set Description
        $('#edit_description').val('');
        
        $('#editWorkLogModal').modal('show');
    }
	
    // --- SHOW GPS ---
    function showGPS(la, lo) {
    	console.log(la);
    	console.log(lo);
    	$('#showMapModal').modal('show');
    }
    
 	// --- SAVE EDIT ---
    function saveEditWorkLog() {
        var reason = $('#edit_description').val().trim();

        // Show Loading State 
        var btn = document.getElementById('btn_submit_edit');
        btn.setAttribute('data-kt-indicator', 'on');
        btn.disabled = true;

        var formData = $('#editWorkLogForm').serialize();

        $.ajax({
            url: "${pageContext.request.contextPath}/save_work_log.action", 
            type: "POST",
            data: formData,
            dataType: "json",
            success: function(response) {
                // Remove Loading State
                btn.removeAttribute('data-kt-indicator');
                btn.disabled = false;

                if (response.status === "success") {
                	$('#editWorkLogModal').modal('hide');
                    loadData();
                } else {
                    Swal.fire({
                        text: "An error occurred. " + (response.message || "Unknown error"),
                        icon: "error",
                        buttonsStyling: false,
                        confirmButtonText: "OK",
                        customClass: { confirmButton: "btn btn-primary" }
                    });
                }
            },
            error: function() {
                btn.removeAttribute('data-kt-indicator');
                btn.disabled = false;
                Swal.fire({ text: "Unable to connect to Server", icon: "error" });
            }
        });
    }
</script>