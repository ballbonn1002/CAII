<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<fmt:setLocale value="en_US" />

<link href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<script src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<style>
/* ===== Month Group Header ===== */
.month-group-row td {
    background: #eef6ff !important;
    color: #1b84ff !important;
    font-weight: 600;
    font-size: 0.85rem;
    letter-spacing: 0.04em;
    padding: 10px 16px;
    border: none !important;
}
.month-group-row:hover td {
    background: #eef6ff !important;
}

/* ===== Log modal text area ===== */
#logTextContent {
    font-family: 'Courier New', Courier, monospace;
    font-size: 0.85rem;
    line-height: 1.6;
    color: #000000;
    font-weight: 600;
    background: #f9fafb;
    border: 1px solid #e5e7eb;
    border-radius: 8px;
    padding: 14px 16px;
    white-space: pre-wrap;
    word-break: break-all;
    max-height: 420px;
    overflow-y: auto;
}

/* ===== User filter Select2 ===== */
.select2-selection__clear { display: none !important; }
#filterCard .select2-container--bootstrap-5 .select2-selection--single {
    height: 45px;
    display: flex;
    align-items: center;
}

/* ===== Log Button ===== */
.btn-view-log i {
    color: var(--bs-primary, #009ef7) !important;
    transition: color 0.2s ease;
}
.btn-view-log:hover i {
    color: #005b8f !important; /* Darker primary */
}

/* ===== DataTable Header Color Override ===== */
#actionLogTable thead th {
    color: #a1a5b7 !important;
}

/* ===== DataTable Length/Info Single Line ===== */
.dataTables_length label {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 0;
    white-space: nowrap;
}
.dataTables_length select {
    width: auto !important;
    display: inline-block !important;
}
.dataTables_info {
    white-space: nowrap;
}

/* ===== DataTable Alternating Row Colors ===== */
#actionLogTable tbody tr.odd-row td {
    background-color: #f8f9fa !important;
}
#actionLogTable tbody tr.even-row td {
    background-color: #ffffff !important;
}
#actionLogTable tbody tr.odd-row:hover td,
#actionLogTable tbody tr.even-row:hover td {
    background-color: #f1f5f9 !important;
}
</style>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">

        <%-- Toolbar / Breadcrumb --%>
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold fs-3 flex-column justify-content-center my-0">
                        Action Log
                    </h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted">
                            <a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a>
                        </li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted">
                            <a href="${pageContext.request.contextPath}/report" class="text-muted text-hover-primary">Report</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <%-- End Toolbar --%>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-fluid">

                <%-- ===== Filter Card ===== --%>
                <div class="card mb-6" id="filterCard">
                    <div class="card-body py-5">
                        <div class="row g-4 align-items-center">

                            <%-- User Filter --%>
                            <div class="col-12 col-md">
                                <div class="input-group flex-nowrap">
                                    <span class="input-group-text bg-transparent border-end-0 h-45px ps-4">
                                        <i class="ki-outline ki-magnifier fs-3 text-gray-500"></i>
                                    </span>
                                    <div class="flex-grow-1">
                                        <select id="userSelect" class="form-select rounded-start-0 border-start-0 h-45px ps-0"
                                                data-control="select2"
                                                data-placeholder="All Employee"
                                                data-allow-clear="false">
                                            <option value="All" <c:if test="${empty selectedUserId or selectedUserId == 'All'}">selected</c:if>>All Employee</option>
                                            <c:if test="${not empty userList}">
                                                <optgroup label="Enable">
                                                    <c:forEach var="u" items="${userList}">
                                                        <c:if test="${u.enable == 1 and u.flag_search == '1'}">
                                                            <c:set var="dText" value="" />
                                                            <c:if test="${not empty u.employee_id}"><c:set var="dText" value="${u.employee_id}" /></c:if>
                                                            <c:if test="${not empty u.name_en}"><c:set var="dText" value="${dText}${not empty dText ? ' - ' : ''}${u.name_en}" /></c:if>
                                                            <c:if test="${not empty u.name}"><c:set var="dText" value="${dText}${not empty dText ? ' - ' : ''}${u.name}" /></c:if>
                                                            <option value="${fn:trim(u.id)}" <c:if test="${selectedUserId == fn:trim(u.id)}">selected</c:if>>${dText}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </optgroup>
                                                <optgroup label="Disable">
                                                    <c:forEach var="u" items="${userList}">
                                                        <c:if test="${u.enable == 0 and u.flag_search == '1'}">
                                                            <c:set var="dText2" value="" />
                                                            <c:if test="${not empty u.employee_id}"><c:set var="dText2" value="${u.employee_id}" /></c:if>
                                                            <c:if test="${not empty u.name_en}"><c:set var="dText2" value="${dText2}${not empty dText2 ? ' - ' : ''}${u.name_en}" /></c:if>
                                                            <c:if test="${not empty u.name}"><c:set var="dText2" value="${dText2}${not empty dText2 ? ' - ' : ''}${u.name}" /></c:if>
                                                            <option value="${fn:trim(u.id)}" <c:if test="${selectedUserId == fn:trim(u.id)}">selected</c:if>>${dText2}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </optgroup>
                                            </c:if>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <%-- Date Range Filter --%>
                            <div class="col-12 col-md-4 col-xl-3">
                                <div class="position-relative">
                                    <i class="ki-duotone ki-calendar-8 fs-2 text-gray-500 position-absolute top-50 translate-middle-y ms-4" style="pointer-events:none; z-index:5;">
                                        <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                                        <span class="path4"></span><span class="path5"></span><span class="path6"></span>
                                    </i>
                                    <input type="text" id="actionLogDatePicker"
                                           class="form-control ps-14 h-45px"
                                           placeholder="Pick date range"
                                           readonly />
                                </div>
                            </div>

                            <%-- Search Button --%>
                            <div class="col-12 col-md-auto">
                                <button type="button" id="btnSearch" class="btn btn-sm btn-primary px-5 h-35px">
                                    Search
                                </button>
                            </div>

                        </div>
                    </div>
                </div>
                <%-- End Filter Card --%>

                <%-- ===== Table Card ===== --%>
                <div class="card">
                    <div class="card-header border-0 pt-6 pb-3 d-flex align-items-center justify-content-between">
                        <h3 class="card-title fw-bold text-gray-900 fs-5 mb-0">Action Log</h3>
                    </div>

                    <div class="card-body pt-0">
                        <div class="table-responsive">
                            <table class="table table-hover table-row-dashed align-middle fs-6 gy-4 gs-4" id="actionLogTable">
                                <thead>
                                    <tr class="text-start text-gray-400 fw-bold fs-7 text-uppercase gs-0">
                                        <th class="w-40px text-center">#</th>
                                        <th class="w-100px text-center">Action ID</th>
                                        <th style="min-width:200px;">Employee</th>
                                        <th style="min-width:160px;">Date</th>
                                        <th class="text-center w-70px">Log</th>
                                    </tr>
                                </thead>
                                <tbody id="logTableBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <%-- End Table Card --%>

            </div>
        </div>
    </div>
</div>

<%-- ===== Modal: View Log ===== --%>
<div class="modal fade" id="modalViewLog" tabindex="-1" aria-labelledby="modalViewLogLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header border-0 pb-2">
                <h5 class="modal-title fw-bold text-gray-800" id="modalViewLogLabel">Action Log</h5>
                <div class="btn btn-icon btn-sm btn-active-light-danger text-muted text-hover-danger" data-bs-dismiss="modal">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>
            <div class="modal-body pt-2">
                <%-- User + ID + Date Header --%>
                <div class="d-flex align-items-center justify-content-between mb-5 pb-4 border-bottom">
                    <div class="d-flex align-items-center gap-3">
                        <div class="symbol symbol-45px symbol-circle">
                            <img id="modalUserImg" src="" class="rounded-circle" style="object-fit:cover; display:none;" />
                            <span id="modalUserInitial" class="symbol-label bg-light-primary text-primary fw-bold fs-4 d-flex align-items-center justify-content-center"></span>
                        </div>
                        <span id="modalUserName" class="fw-semibold text-gray-800 fs-5"></span>
                    </div>
                    <div class="d-flex align-items-center gap-3 text-end">
                        <span id="modalLogId" class="fw-bold text-primary fs-5"></span>
                        <span class="text-gray-400">|</span>
                        <div id="modalLogDateContainer" class="d-flex align-items-center gap-2"></div>
                    </div>
                </div>

                <%-- Log Data (raw text) --%>
                <div id="logTextContent"></div>
            </div>
            <div class="modal-footer border-0 pt-2">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
(function () {
    var contextPath = "${pageContext.request.contextPath}";

    /* ========================
       Date Range Picker (เหมือน announcement_list)
    ======================== */
    var start = moment().startOf('year');
    var end   = moment().endOf('year');

    function cb(s, e) {
        $("#actionLogDatePicker").val(s.format("DD MMM YYYY") + " - " + e.format("DD MMM YYYY"));
    }

    $("#actionLogDatePicker").daterangepicker({
        startDate : start,
        endDate   : end,
        locale    : { format: "DD MMM YYYY" },
        ranges    : {
            "Today"      : [moment(), moment()],
            "Yesterday"  : [moment().subtract(1,"days"), moment().subtract(1,"days")],
            "Last 7 Days": [moment().subtract(6,"days"), moment()],
            "Last 30 Days": [moment().subtract(29,"days"), moment()],
            "This Month" : [moment().startOf("month"), moment().endOf("month")],
            "Last Month" : [moment().subtract(1,"month").startOf("month"), moment().subtract(1,"month").endOf("month")],
            "This Year"  : [moment().startOf("year"), moment().endOf("year")],
            "Last Year"  : [moment().subtract(1,"year").startOf("year"), moment().subtract(1,"year").endOf("year")]
        }
    }, cb);
    cb(start, end);

    /* ========================
       Search (reload page พร้อม params)
    ======================== */
    function escapeHtml(str) {
        if (!str) return "";
        return str.replace(/&/g, "&amp;")
                  .replace(/</g, "&lt;")
                  .replace(/>/g, "&gt;")
                  .replace(/"/g, "&quot;")
                  .replace(/'/g, "&#039;");
    }

    /* ========================
       Restore filter ถ้ามีค่าจาก server
    ======================== */
    var selUserId    = "${selectedUserId}";
    var selStartDate = "${selectedStartDate}";
    var selEndDate   = "${selectedEndDate}";

    if (selStartDate && selEndDate) {
        var s2 = moment(selStartDate, "YYYY-MM-DD");
        var e2 = moment(selEndDate,   "YYYY-MM-DD");
        if (s2.isValid() && e2.isValid()) {
            $("#actionLogDatePicker").data("daterangepicker").setStartDate(s2);
            $("#actionLogDatePicker").data("daterangepicker").setEndDate(e2);
            cb(s2, e2);
        }
    }

    if (selUserId && selUserId !== "All" && selUserId !== "") {
        $("#userSelect").val(selUserId).trigger("change");
    }

    /* ========================
       Initialize DataTable via AJAX
    ======================== */
    var table = $('#actionLogTable').DataTable({
        processing: true,
        serverSide: false,
        ajax: {
            url: contextPath + "/action_log_list_data",
            type: "POST",
            data: function (d) {
                var picker = $("#actionLogDatePicker").data("daterangepicker");
                d.userId = $("#userSelect").val() || "All";
                d.startDate = picker.startDate.format("YYYY-MM-DD");
                d.endDate = picker.endDate.format("YYYY-MM-DD");
            },
            dataSrc: ""
        },
        columns: [
            { 
                data: null, 
                className: "text-center text-gray-600 fw-semibold",
                orderable: false,
                render: function (data, type, row, meta) {
                    return meta.row + 1;
                }
            },
            { 
                data: "log_action_id", 
                className: "text-center fw-bold text-gray-700" 
            },
            {
                data: null,
                orderable: false,
                render: function (data, type, row) {
                    var path = row.path || "";
                    var nameEn = row.name_en || "";
                    var nameTh = row.name || "";
                    var userCreate = row.user_create || "";
                    
                    var displayName = nameEn ? nameEn : (nameTh ? nameTh : userCreate);
                    var initialLetter = displayName ? displayName.charAt(0).toUpperCase() : "?";
                    
                    var avatarHtml = "";
                    if (path) {
                        var imgSrc = contextPath + path;
                        avatarHtml = 
                            '<div class="symbol-label">' +
                            '    <img src="' + imgSrc + '" class="w-100 h-100 rounded-circle" style="object-fit:cover;" ' +
                            '         onerror="this.classList.add(\'d-none\'); this.nextElementSibling.classList.remove(\'d-none\'); this.nextElementSibling.classList.add(\'d-flex\');" />' +
                            '    <span class="symbol-label bg-light-primary text-primary fw-bold d-none align-items-center justify-content-center">' +
                                     initialLetter +
                            '    </span>' +
                            '</div>';
                    } else {
                        avatarHtml = 
                            '<span class="symbol-label bg-light-primary text-primary fw-bold d-flex align-items-center justify-content-center">' +
                                 initialLetter +
                            '</span>';
                    }
                    
                    var subNameHtml = "";
                    if (nameTh && nameEn) {
                        subNameHtml = '<div class="text-gray-500 fs-7">' + nameTh + '</div>';
                    }
                    
                    return '<div class="d-flex align-items-center gap-3">' +
                           '    <div class="symbol symbol-40px symbol-circle">' +
                                    avatarHtml +
                           '    </div>' +
                           '    <div>' +
                           '        <div class="fw-semibold text-gray-900">' + displayName + '</div>' +
                                    subNameHtml +
                           '    </div>' +
                           '</div>';
                }
            },
            {
                data: "time_create",
                render: function (data, type, row) {
                    if (!data) return "";
                    var m = moment(data, "YYYY-MM-DD HH:mm:ss");
                    if (!m.isValid()) return data;
                    
                    var dayOfWeek = m.format("ddd");
                    var formattedDate = m.format("D MMM YYYY");
                    
                    var barColor = "#3b82f6";
                    var dayLower = dayOfWeek.toLowerCase();
                    if (dayLower.indexOf("mon") >= 0) barColor = "#ffc700";
                    else if (dayLower.indexOf("tue") >= 0) barColor = "#D63384";
                    else if (dayLower.indexOf("wed") >= 0) barColor = "#50cd89";
                    else if (dayLower.indexOf("thu") >= 0) barColor = "#FD7E14";
                    else if (dayLower.indexOf("fri") >= 0) barColor = "#0DCAF0";
                    else if (dayLower.indexOf("sat") >= 0) barColor = "#7239ea";
                    else if (dayLower.indexOf("sun") >= 0) barColor = "#dc3545";
                    
                    return '<div class="d-flex align-items-center gap-2">' +
                           '    <span class="w-3px h-15px rounded-1 d-inline-block" style="background:' + barColor + ';"></span>' +
                           '    <span class="text-gray-500 fw-semibold fs-7 me-1">' + dayOfWeek + '</span>' +
                           '    <span class="text-gray-900">' + formattedDate + '</span>' +
                           '</div>';
                }
            },
            {
                data: null,
                className: "text-center",
                orderable: false,
                render: function (data, type, row) {
                    var logActionId = row.log_action_id || "";
                    var nameEn = row.name_en || "";
                    var nameTh = row.name || "";
                    var userCreate = row.user_create || "";
                    var displayName = nameEn ? nameEn : (nameTh ? nameTh : userCreate);
                    var path = row.path || "";
                    
                    var timeCreate = row.time_create || "";
                    var m = moment(timeCreate, "YYYY-MM-DD HH:mm:ss");
                    var fmtLogDate = m.isValid() ? m.format("D MMM YYYY") : "";
                    var dayOfWeek = m.isValid() ? m.format("ddd") : "";
                    
                    var barColor = "#3b82f6";
                    var dayLower = dayOfWeek.toLowerCase();
                    if (dayLower.indexOf("mon") >= 0) barColor = "#ffc700";
                    else if (dayLower.indexOf("tue") >= 0) barColor = "#D63384";
                    else if (dayLower.indexOf("wed") >= 0) barColor = "#50cd89";
                    else if (dayLower.indexOf("thu") >= 0) barColor = "#FD7E14";
                    else if (dayLower.indexOf("fri") >= 0) barColor = "#0DCAF0";
                    else if (dayLower.indexOf("sat") >= 0) barColor = "#7239ea";
                    else if (dayLower.indexOf("sun") >= 0) barColor = "#dc3545";
                    
                    var escapedLogData = escapeHtml(row.log_data);

                    return '<button type="button" class="btn-view-log border-0 bg-transparent p-0" ' +
                           '        data-log-id="' + logActionId + '" ' +
                           '        data-log-user="' + escapeHtml(displayName) + '" ' +
                           '        data-log-path="' + path + '" ' +
                           '        data-log-date="' + fmtLogDate + '" ' +
                           '        data-log-day="' + dayOfWeek + '" ' +
                           '        data-log-color="' + barColor + '" ' +
                           '        data-log-data="' + escapedLogData + '" ' +
                           '        title="View Log">' +
                           '    <i class="ki-duotone ki-notepad fs-2x">' +
                           '        <span class="path1"></span><span class="path2"></span>' +
                           '        <span class="path3"></span><span class="path4"></span>' +
                           '        <span class="path5"></span>' +
                           '    </i>' +
                           '</button>';
                }
            }
        ],
        order: [],
        pageLength: 10,
        lengthMenu: [10, 25, 50, 100],
        dom: "<'row'<'col-sm-12'tr>>" +
             "<'row mt-3'<'col-sm-5 d-flex align-items-center justify-content-center justify-content-sm-start'l><'col-sm-7 d-flex align-items-center justify-content-center justify-content-sm-end'p>>",
        language: {
            lengthMenu: "_MENU_",
            zeroRecords: "No records found",
            info: "Showing _START_ to _END_ of _TOTAL_ entries",
            infoEmpty: "Showing 0 to 0 of 0 entries",
            infoFiltered: "(filtered from _MAX_ total entries)",
            paginate: {
                first: "First",
                last: "Last",
                next: "Next",
                previous: "Previous"
            }
        },
        drawCallback: function (settings) {
            var api = this.api();
            var rows = api.rows({ page: 'current' }).nodes();
            var last = null;

            api.rows({ page: 'current' }).nodes().to$().prev('.month-group-row').remove();

            api.column(3, { page: 'current' }).data().each(function (dateVal, i) {
                var rowData = api.row(rows[i]).data();
                if (!rowData || !rowData.time_create) return;
                
                var m = moment(rowData.time_create, "YYYY-MM-DD HH:mm:ss");
                if (!m.isValid()) return;
                
                var monthLabel = m.format("MMMM YYYY");
                if (last !== monthLabel) {
                    var groupRow = $(
                        '<tr class="month-group-row" style="pointer-events: none;">' +
                        '    <td colspan="5" style="background:#eef6ff !important; color:#1b84ff; font-weight:600; border: none !important; padding-top:10px; padding-bottom:10px;">' +
                                 monthLabel +
                        '    </td>' +
                        '</tr>'
                    );
                    $(rows[i]).before(groupRow);
                    last = monthLabel;
                }
            });

            // Apply alternate row colors
            api.rows({ page: 'current' }).nodes().to$().removeClass('odd-row even-row').each(function (idx) {
                if (idx % 2 === 0) {
                    $(this).addClass('even-row');
                } else {
                    $(this).addClass('odd-row');
                }
            });
        }
    });

    /* ========================
       Search (ajax reload)
    ======================== */
    $("#btnSearch").on("click", function () {
        table.ajax.reload();
    });

    /* ========================
       Modal View Log
    ======================== */
    $(document).on("click", ".btn-view-log", function () {
        var $btn   = $(this);
        var logId  = $btn.data("log-id");
        var user   = $btn.data("log-user")  || "";
        var path   = $btn.data("log-path")  || "";
        var date   = $btn.data("log-date")  || "";
        var day    = $btn.attr("data-log-day") || "";
        var color  = $btn.attr("data-log-color") || "";
        var logRaw = $btn.attr("data-log-data") || "";

        // Header
        $("#modalLogId").text("#" + logId);
        
        var dateHtml = '<span class="w-3px h-15px rounded-1 d-inline-block" style="background:' + color + ';"></span>' +
                       '<span class="text-gray-500 fw-semibold fs-7 me-1">' + day + '</span>' +
                       '<span class="text-gray-800 fs-6">' + date + '</span>';
        $("#modalLogDateContainer").html(dateHtml);
        
        $("#modalUserName").text(user);

        // Avatar
        var initial = user ? user.charAt(0).toUpperCase() : "?";
        $("#modalUserInitial").text(initial);

        if (path) {
            var imgSrc = contextPath + path;
            var $img   = $("#modalUserImg");
            $img.attr("src", imgSrc).show();
            $("#modalUserInitial").addClass("d-none").hide();	
            $img.on("error", function () {
                $(this).hide();
                $("#modalUserInitial").removeClass("d-none").show();
            });
        } else {
            $("#modalUserImg").hide();
            $("#modalUserInitial").removeClass("d-none").show();
        }

        // Log data (แสดงตรงๆ สีดำ ตัดบรรทัดทุกลูกน้ำ)
        var formattedLog = logRaw.replace(/,/g, ",\n");
        $("#logTextContent").text(formattedLog);

        var modal = new bootstrap.Modal(document.getElementById("modalViewLog"));
        modal.show();
    });

})();
</script>
