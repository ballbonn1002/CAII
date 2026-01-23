<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>

<style>
  .pdf-icon {
    display: inline-block;
    width: 24px;
    height: 24px;
    background-image: url('https://cdn-icons-png.flaticon.com/512/337/337946.png');
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
                        <a href="#" class="btn btn-secondary">
                            <i class="pdf-icon me-2"></i> 
                            <span class="fw-medium fs-6 f text-secondary-inverse">Print PDF</span>
                        </a>
                    </div>
                </div>
            </div>
            
            <div id="kt_app_content_container" class="app-container container-fluid">
                
                <form action="work_log.action" method="post" id="filterForm">
                    <div class="card card-flush shadow-sm mb-5">
                        <div class="card-body py-5">
                            <div class="row g-5">
                            
                                <div class="col-md-12">
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
</perm:permission>

<script>
    $(document).ready(function() {
        try {
            $('#userSelect').select2({allowClear: false});
            $('.datepicker').flatpickr({ 
                dateFormat: "d-m-Y", 
                altInput: true,
                altFormat: "j M Y",
                onChange: function(selectedDates, dateStr, instance) {
                    loadData(); 
                } 
            });

            // Bind Event Change
            $('#userSelect, select[name="status"], select[name="siteId"]').on('change', function() { 
                loadData(); 
            });
            
            loadData();

        } catch (e) {
            console.error("Init Error:", e);
        }
    });

    // Helper Functions
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
        return date.toLocaleDateString('en-US', { month: 'long' });
    }

    function getDayColorClass(dateString) {
        if (!dateString) return 'bg-light';
        var date = new Date(dateString);
        var day = date.getDay(); // 0=Sun, 1=Mon, ..., 6=Sat
        
        var colors = [
            'bg-danger',  // 0 Sun
            'bg-warning', // 1 Mon
            'bg-pink',    // 2 Tue
            'bg-success', // 3 Wed
            'bg-orange',  // 4 Thu
            'bg-cyan',    // 5 Fri
            'bg-info'     // 6 Sat
        ];
        return colors[day] || 'bg-light';
    }

    function getWorkTypeIcon(type) {
        type = String(type).trim();
        if (type === '1') {
            return '<div class="d-inline-flex align-items-center badge badge-light-success fw-bold px-4 py-2 fs-7">IN</div>';
        } else if (type === '2') {
            return '<div class="d-inline-flex align-items-center badge badge-light-info fw-bold px-4 py-2 fs-7">OUT</div>';
        }
        return '<span class="badge badge-light text-gray-600">' + type + '</span>';
    }

    function getStatusBadge(status, duration) {
        status = String(status || '').trim();
        var badge = '';
        
        if (status === 'OnTime') {
            badge = '<span class="badge badge-success fw-bold fs-7 py-2">Ontime</span>';
        } else if (status === 'Late') {
            badge = '<span class="badge badge-warning fw-bold text-white fs-7 py-2">Late</span>';
        } else if (status === 'Early Out') {
            badge = '<span class="badge badge-warning fw-bold text-white mb-1 fs-7 py-2">Early Out</span>';
        } else if (status === 'Finished Work') {
            badge = '<span class="badge badge-primary fw-bold mb-1 fs-7 py-2">Finished Work</span>';
        } else if (status === 'Unfinished Work') {
            badge = '<span class="badge badge-danger fw-bold mb-1 fs-7 py-2">Unfinished Work</span>';
        } else {
            if(status) badge = '<span class="badge badge-light fw-bold fs-7 py-2">' + status + '</span>';
        }

        if (duration && (status === 'Early Out' || status === 'Finished Work' || status === 'Unfinished Work')) {
             badge += '<span class="badge badge-light-primary fw-bold mt-2 fs-7 py-2">' + duration + '</span>';
        }
        return badge;
    }

    // Main Logic
    window.loadData = function() {
        var formData = $('#filterForm').serialize();
        
        $('#tableBody').html('<tr><td colspan="6" class="text-center py-10"><span class="spinner-border text-primary"></span></td></tr>');
        $('#resultArea').css('opacity', '0.5');

        $.ajax({
            url: "${pageContext.request.contextPath}/work_log_json.action", 
            type: "POST",
            data: formData,
            dataType: "json",
            success: function(response) {
                // Update Summary
                if (response.summary) {
                    // Items Found
                    $('#itemsFoundCount').text(response.summary.total || 0);
                }

                // Render Table
                var html = '';
                var currentMonth = '';
                var list = response.workLogList || [];

                if (list.length === 0) {
                    html = '<tr><td colspan="6" class="text-center py-10 text-muted">No records found.</td></tr>';
                } else {
                    $.each(list, function(index, item) {
                        
                        var thisMonth = getMonthName(item.work_hours_time_work);
                        if (currentMonth !== thisMonth) {
                            html += '<tr class="bg-light-primary"><td colspan="6" class="ps-4 py-3 rounded">' +
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

                        var descriptionHtml = item.description ? 
                            '<div class="d-flex align-items-center mt-1 ms-4"><i class="ki-solid ki-message-text-2 fs-4 text-gray-400 fw-normal me-2"></i><span class="fw-normal text-gray-700 fs-6">' + item.description + '</span></div>' : '';

                        // HTML Row 
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
                                    '<span class="text-gray-800 fw-normal fs-6 d-block">' + formatDate(item.time_create) + ', ' + formatTime(item.time_create) + '</span>' +
                                    '<span class="fw-normal text-gray-600 fs-6">' + (item.ip_address || '') + '</span>' +
                                '</td>' +
                                
                                '<td><div class="d-flex flex-column align-items-start">' + statusBadge + '</div></td>' +
                                
                                '<td class="text-end pe-4">' +
                                    '<a href="#" class="btn btn-icon btn-light-primary btn-sm">' +
                                        '<i class="ki-duotone ki-pencil fs-2"><span class="path1"></span><span class="path2"></span></i>' +
                                    '</a>' +
                                '</td>' +
                                '</tr>';
                    });
                }

                $('#tableBody').html(html);
                $('#resultArea').css('opacity', '1');
            }
        });
    }
</script>