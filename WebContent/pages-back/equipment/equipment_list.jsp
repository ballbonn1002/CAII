<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-xxl d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Equipment List</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary fw-medium fs-7">Home</a></li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted fw-medium fs-7">Borrow</li>
                    </ul>
                </div>
                <div class="d-flex align-items-center gap-2 gap-lg-3">
                    <a href="equipment_setting" class="btn bg-primary-subtle border border-primary-subtle d-inline-flex align-items-center gap-2 px-4 py-2 text-primary">
                        <i class="ki-duotone ki-setting-2 fs-2 text-primary"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fw-medium">Settings</span>
                    </a>
                </div>
            </div>
        </div>
        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-xxl">

                <div class="card">
                    <div class="card-border-radius">
                        <div class="card-body">
                            <div class="row g-5 align-items-end">
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center position-relative">
                                        <i class="ki-duotone ki-magnifier fs-3 position-absolute ms-5"><span class="path1"></span><span class="path2"></span></i>
                                        <input type="text" id="searchInput" class="form-control form-solid ps-14 text-gray-700" name="q" placeholder="Search" value="${fn:escapeXml(param.q)}" />
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <label class="select-default">Status:</label>
                                    <div class="dropdown w-100">
                                        <button class="btn btn-white border border-gray-300 rounded-3 d-flex justify-content-between align-items-center w-100 px-4 py-3" type="button" data-bs-toggle="dropdown">
                                            <span>All Status</span>
                                            <i class="ki-duotone ki-down fs-4"><span class="path1"></span><span class="path2"></span></i>
                                        </button>
                                        <div class="dropdown-menu dropdown-menu-end p-4 shadow rounded-4" style="min-width: 254px;">
                                            <div class="mb-4" id="statusFilterContainer">
                                                </div>
                                            <div class="d-flex justify-content-between pt-3 border-top">
                                                <button type="button" class="btn btn-light">Deselect All</button>
                                                <button type="button" class="btn btn-primary">Select All</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <label for="type" class="select-default">Type:</label>
                                    <div class="dropdown w-100">
                                        <button class="btn btn-white border border-gray-300 rounded-3 d-flex justify-content-between align-items-center w-100 px-4 py-3" type="button" data-bs-toggle="dropdown">
                                            <span>Select</span>
                                            <i class="ki-duotone ki-down fs-4"><span class="path1"></span><span class="path2"></span></i>
                                        </button>
                                        <div class="dropdown-menu dropdown-menu-end p-4 shadow rounded-4" style="min-width: 254px;">
                                            <div class="mb-4" id="typeFilterContainer">
                                                </div>
                                            <div class="d-flex justify-content-between pt-3 border-top">
                                                <button type="button" class="btn btn-light">Deselect All</button>
                                                <button type="button" class="btn btn-primary">Select All</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="d-flex align-items-center justify-content-between mt-8 mb-6">
                    <div class="d-flex align-items-baseline gap-1">
                        <h3 class="page-heading text-gray-900 fw-bold mb-0">
                            <span id="currentTotalRows">
                                <c:set var="totalRows" value="${fn:length(equipmentall)}" />
                                ${totalRows}
                            </span> 
                            Items Found
                        </h3>
                        <span class="fs-6 fw-semibold text-gray-500 d-flex align-items-center">by Recent Updates <span class="ms-1">↓</span></span>
                    </div>
                    <a href="equipment_add" class="btn btn-success d-inline-flex align-items-center px-6 py-3">
                        <i class="ki-duotone ki-plus fs-3 me-2"><span class="path1"></span><span class="path2"></span></i>
                        <span class="fw-bold">Create</span>
                    </a>
                </div>

                <div class="card">
                    <div class="card-border-radius">
                        <div class="card-body">
                            <div class="border border-dashed border-gray-400 rounded-3 px-7 py-6 mb-8 bg-transparent">
                                <div class="d-flex flex-column">
                                    <span class="fs-4 text-gray-800 fw-bold mb-4">Type</span>
                                    <div class="d-flex flex-wrap gap-3">
                                        <div class="d-inline-flex align-items-center me-10"><i class="ki-solid ki-laptop fs-1 text-gray-500 me-3"></i>
                                            <span class="fs-6 fw-normal text-gray-900">Computer</span></div>
                                        <div class="d-inline-flex align-items-center me-10"><i class="ki-solid ki-keyboard fs-1 text-gray-500 me-3"></i>
                                            <span class="fs-6 fw-normal text-gray-900">Instrument</span></div>
                                        <div class="d-inline-flex align-items-center me-10"><i class="ki-solid ki-verify fs-1 text-gray-500 me-3"></i>
                                            <span class="fs-6 fw-normal text-gray-900">Software License</span></div>
                                        <div class="d-inline-flex align-items-center me-10"><i class="ki-solid ki-phone fs-1 text-gray-500 me-3"></i>
                                            <span class="fs-6 fw-normal text-gray-900">Mobile</span></div>
                                        <div class="d-inline-flex align-items-center me-10"><i class="ki-solid ki-dots-square fs-1 text-gray-500 me-3"></i>
                                            <span class="fs-6 fw-normal text-gray-900">Other</span></div>
                                        <div class="d-inline-flex align-items-center me-10"><i class="ki-solid ki-wifi-square fs-1 text-gray-500 me-3"></i>
                                            <span class="fs-6 fw-normal text-gray-900">Pocket WIFI</span></div>
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table id="eqTable" class="table table-striped align-middle fs-6 mb-0 ca-eq-table">
                                    <thead class="fs-7 text-gray-500 text-uppercase">
                                        <tr class="fw-semibold">
                                            <th class="min-w-60px">ID</th>
                                            <th class="min-w-120px">Item No</th>
                                            <th class="min-w-90px text-center">Type</th>
                                            <th class="min-w-350px">Equipment / Detail</th>
                                            <th class="min-w-250px">Status</th>
                                            <th class="min-w-200px text-end">Actions</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="kt_modal_view_equipment" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered mw-700px">
        <div class="modal-content">
            <div class="modal-header pb-0 border-0 justify-content-between">
                <h2 class="fw-bold m-0 text-gray-800 ps-4 pt-4">Equipment Detail</h2>
                <div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>
            
            <div class="modal-body scroll-y px-10 px-lg-8 pt-5 pb-15">
                
                <div class="rounded p-6">
                    
                    <div class="row g-5 mb-6">
                        <div class="col-md-6 d-flex align-items-center gap-3">
                            <span class="fs-5 fw-bold text-primary" id="view_item_no">ID: ITEMxxxx</span>
                            <span class="badge" id="view_status_badge">Status</span>
                        </div>
                
                        <div class="col-md-6 d-flex align-items-center gap-2">
                            <span id="view_type_icon"></span>
                            <span class="fs-5 fw-bold text-gray-800" id="view_name">Equipment Name</span>
                        </div>
                    </div>

                    <div class="row g-5 mb-5">
                        <div class="col-md-6">
                            <div class="col-md-0 d-flex align-items-start gap-2">
                                <span class="text-gray-700 fw-normal fs-5">Serial No:</span>
                                <span class="text-gray-800 fw-normal fs-5" id="view_serial">-</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <span class="text-gray-700 fw-normal fs-5 me-2">Amount:</span>
                            <span class="text-gray-800 fw-normal fs-5" id="view_amount">-</span>
                        </div>
                        <div class="col-md-6">
                            <div class="col-md-0 d-flex align-items-start gap-2">
                                <span class="text-gray-700 fw-normal fs-5">Detail:</span>
                                <span class="text-gray-800 fw-normal fs-5" id="view_detail">-</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="col-md-0 d-flex align-items-start gap-2">
                                <span class="text-gray-700 fw-normal fs-5">Date of Purchase:</span>
                                <span class="text-gray-800 fw-normal fs-5" id="view_purchase_date">-</span>
                            </div>
                        </div>
                    </div>

                    <div class="mb-0">
                        <a href="#" class="text-primary text-hover-primary fw-normal fs-5 mb-3 rotate collapsible collapsed" data-bs-toggle="collapse" data-bs-target="#kt_view_equipment_more_details">
                            More Detail 
                            <span class="d-flex flex-center rotate-n180 ms-2">
                                <i class="ki-duotone ki-down fs-5"><span class="path1"></span><span class="path2"></span></i>
                            </span>
                        </a>
                        
                        <div id="kt_view_equipment_more_details" class="collapse">
                            <div class="row g-5 pt-2">
                                <div class="col-md-6">
                                    <div class="col-md-0 d-flex align-items-start gap-2">
                                        <span class="text-gray-700 fw-normal fs-5">Windows</span>
                                        <span class="text-gray-800 fw-normal fs-5" id="view_os">-</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="col-md-0 d-flex align-items-start gap-2">
                                        <span class="text-gray-700 fw-normal fs-5">CPU</span>
                                        <span class="text-gray-800 fw-normal fs-5" id="view_cpu">-</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="col-md-0 d-flex align-items-start gap-2">
                                        <span class="text-gray-700 fw-normal fs-5">Ram</span>
                                        <span class="text-gray-800 fw-normal fs-5" id="view_ram">-</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="col-md-0 d-flex align-items-start gap-2">
                                        <span class="text-gray-700 fw-normal fs-5">Storage</span>
                                        <span class="text-gray-800 fw-normal fs-5" id="view_storage">-</span>
                                    </div>    
                                </div>
                                <div class="col-md-6">
                                    <div class="col-md-0 d-flex align-items-start gap-2">
                                        <span class="text-gray-700 fw-normal fs-5">Battery</span>
                                        <span class="text-gray-800 fw-normal fs-5" id="view_battery">-</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="col-md-0 d-flex align-items-start gap-2">
                                        <span class="text-gray-700 fw-normal fs-5">Display</span>
                                        <span class="text-gray-800 fw-normal fs-5" id="view_display">-</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="col-md-0 d-flex align-items-start gap-2">
                                        <span class="text-gray-700 fw-normal fs-5">WIFI Address</span>
                                        <span class="text-gray-800 fw-normal fs-5" id="view_wifi">-</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="col-md-0 d-flex align-items-start gap-2">
                                        <span class="text-gray-700 fw-normal fs-5">LAN Address</span>
                                        <span class="text-gray-800 fw-normal fs-5" id="view_lan">-</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                        <div id="view_borrow_section" class="d-none">
                        <div class="separator separator-dashed border-gray-300 my-10"></div>
                        <div class="d-flex align-items-center mb-5">
                             <span class="fs-5 fw-bold text-gray-800 me-3">Borrow ID:</span>
                             <span class="fs-5 fw-bold text-primary" id="view_borrow_id_display">xxxx</span>
                        </div>
                        
                        <div class="row g-5 mb-5" id="view_borrow_detailed_info">
                            <div class="col-12">
                                <div class="d-flex flex-wrap align-items-center">
                                    <span class="text-gray-700 fw-normal fs-5 me-2">Borrow by:</span>
                                    <span class="fs-5 text-gray-800 fw-medium" id="view_borrower_full">-</span>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="d-flex align-items-center">
                                    <span class="text-gray-700 fw-normal fs-5 me-2">Location:</span>
                                    <span class="text-gray-800 fw-normal fs-5" id="view_location">-</span>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="d-flex align-items-center">
                                    <span class="text-gray-700 fw-normal fs-5 me-2">Borrow Date:</span>
                                    <span class="text-gray-800 fw-normal fs-5" id="view_borrow_date">-</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div id="view_return_section" class="d-none mt-5">
                        <div class="separator separator-dashed border-gray-300 my-10"></div>
                        <div class="mb-3">
                             <label class="fw-bold mb-2 text-primary fs-5">Approver</label>
                             <div class="form-label fw-medium text-gray-800 mb-2">Specify a note when changing status (optional)</div>
                             <textarea id="return_note" class="form-control" rows="3" placeholder="Enter maintenance or repair notes..."></textarea>
                        </div>
                    </div>
                    <div class="d-flex justify-content-end align-items-center gap-3 mt-10"></div>
                
                </div> 
                
                <div class="d-flex justify-content-end align-items-center gap-3">
                    <button type="button" class="btn btn-light fw-bold" data-bs-dismiss="modal">Cancel</button>
                    <a href="#" id="view_btn_edit" class="btn btn-primary fw-bold">Edit</a>
                    
                    <button type="button" id="view_btn_return" class="btn btn-warning fw-bold d-none">
                        Request for Return
                    </button>
                    
                    <button type="button" id="view_btn_borrow" class="btn btn-warning fw-bold d-none">
                        Borrow
                    </button>
                </div>
                
            </div>
        </div>
    </div>
</div>

<script>
    // =============== Data Table From Backend ==============
    var equipments = ${equipments != null ? equipments : '[]'};
    var borrows = ${borrows != null ? borrows : '[]'};
    var users = ${userList != null ? userList : '[]'};
    var dbStatusList = ${status != null ? status : '[]'};
    var dbTypeList = ${type != null ? type : '[]'};

    // ============== CONFIGURATION & PREPARATION ================
    var STATUS_CONFIG = {};          // Class badge
    var DYNAMIC_ICON_MAPPING = {};   // Class Icon
    var DEFAULT_ICON = '<i class="ki-solid ki-dots-square fs-1 ms-6 text-gray-500"></i>';
    
    // Filter (Checkbox)
    var statusFilterHtml = '';
    var typeFilterHtml = '';

    // ============= Config Stetus and Filter Status =========================
    if(dbStatusList && dbStatusList.length > 0) {
        dbStatusList.forEach(function(st) {
            var badgeClass = st.color2 ? ('badge-' + st.color2) : 'badge-secondary'; // Default 
            
            // Map Config Stetus for Table
            STATUS_CONFIG[st.statusId] = {
                class: badgeClass,
                label: st.description || st.statusId
            };

            // Checkbox Dropdown Filter
            statusFilterHtml += 
                '<label class="form-check form-check-custom form-check-solid mb-3">' +
                '<input class="form-check-input filter-status" type="checkbox" value="' + st.statusId + '">' +
                '<span class="form-check-label text-gray-600 fw-normal menu-heading">' + 
                (st.description || st.statusId) + 
                '</span></label>';
        });
    }

    // ============= Config icon and Filter Type ====================
    if(dbTypeList && dbTypeList.length > 0) {
        dbTypeList.forEach(function(t) {
            // เช็คว่ามี Class ไอคอนส่งมาไหม
            var iconClass = t.typeText;
            if (iconClass && iconClass.trim() !== '') {
                DYNAMIC_ICON_MAPPING[t.TypeID] = '<i class="' + iconClass + ' fs-1 ms-6 text-gray-500"></i>';
            } else {
                DYNAMIC_ICON_MAPPING[t.TypeID] = DEFAULT_ICON;
            }

            // สร้าง HTML Checkbox
            typeFilterHtml += 
                '<label class="form-check form-check-custom form-check-solid mb-3">' +
                '<input class="form-check-input filter-type" type="checkbox" value="' + t.TypeID + '">' +
                '<span class="form-check-label text-gray-600 fw-normal menu-heading">' + 
                (t.description || t.TypeID) + 
                '</span></label>';
        });
    }

    // ================ DATA MAPPING =========================
    // ดึง HTML Icon ตาม Type ID
    function getIconHtml(TypeId) {                             
        var tid = (TypeId) ? TypeId.toString().trim() : '';
        return DYNAMIC_ICON_MAPPING[tid] || DEFAULT_ICON;
    }

    // ============= Badge Status ===========================
    function getStatusBadgeHtml(statusId, rowData) {
    	var config = STATUS_CONFIG[statusId];
        var cssClass = config ? config.class : 'badge-primary'; // ใช้ค่าจาก config ถ้าไม่มีใช้ badge-primary เป็น default
        var labelText = config ? config.label : 'Borrowed';
        // กรณีถ้าสถานะเป็น 'B' (Borrowed) ให้โชว์ชื่อคนยืม
        if (statusId === 'B') {
             var eqIdStr = String(rowData.equipmentId);
             // ดึงข้อมูลการยืมล่าสุดของเครื่องนี้
             var borrow = lastBorrowByEqId[eqIdStr];
             // แปลง UserID เป็นชื่อคน
             var borrowerName = (borrow && borrow.userBorrowid) ? (userById[(borrow.userBorrowid || '').toLowerCase()] || borrow.userBorrowid) : '-';
             
             return '<div class="d-flex flex-column align-items-start">' +
                    '<span class="badge ' + cssClass + ' fs-7 py-2 mb-2">' + labelText + '</span>' +
                    '<span class="fw-normal fs-6 text-gray-900">' + borrowerName + '</span>' +
                    '</div>';
        }

        // กรณีทั่วไป ดึงสีและป้ายชื่อจาก Config
        var config = STATUS_CONFIG[statusId];
        var cssClass = config ? config.class : 'badge-light'; 
        var label    = config ? config.label : (statusId || '-');

        return '<span class="badge ' + cssClass + ' fs-7 py-2">' + label + '</span>';
    }

    // ==== Map User ID -> Name
    var userById = {};
    users.forEach(function(u) {
        var key = (u.id || '').toLowerCase();
        userById[key] = (u.name_en && u.name_en.trim() !== '') ? u.name_en : (u.name || u.id);
    });

    // ==== Map Equipment ID -> Last Borrow Record
    var lastBorrowByEqId = {};
    borrows.forEach(function(b) {
        var eqId = String(b.equipmentId);
        // ถ้ายังไม่มี หรือ ถ้าเจอ ID การยืมที่ใหม่และมากกว่าให้แทนที่
        if (!lastBorrowByEqId[eqId] || b.borrowId > lastBorrowByEqId[eqId].borrowId) {
            lastBorrowByEqId[eqId] = b;
        }
    });

    //  =============== MAIN SHOW DATA LOGIC =======================
    $(document).ready(function() {
        // Set Filter
        $('#statusFilterContainer').html(statusFilterHtml);
        $('#typeFilterContainer').html(typeFilterHtml);

        // Set Data Table
        var table = $('#eqTable').DataTable({
            data: equipments,
            pageLength: 20,
            lengthMenu: [20, 50, 100],
            info: false,        
            ordering: true,
            autoWidth: false,
            columns: [
                // Col 1: ID
                {   
                    data: 'equipmentId', 
                    className: 'text-center',
                    render: function(data) {
                        return '<span class="text-gray-900 fw-bold fs-6">' + (data || '') + '</span>';
                    }
                },
                // Col 2: Item No
                {
                    data: 'itemNo',  
                    defaultContent: "",
                    render: function(data) {
                        return '<span class="text-gray-900 fw-normal fs-5">' + (data || '') + '</span>';
                    }
                },
                // Col 3: Type 
                {
                    data: 'type',
                    className: 'text-center',
                    render: function(data, type) {
                        var val = (data) ? data.toString().trim() : '';
                        if (type === 'filter' || type === 'sort') return val; // ถ้า Sort ให้ใช้ค่า Text
                        return getIconHtml(val); // ถ้า Show ให้ใช้ค่า Icon
                    }
                },
                // Col 4: Detail 
                {
                    data: null,
                    render: function(data, type, row) {
                    	if (type === 'filter') {
                            var searchStr = (row.name || '') + ' ' + (row.detail || ''); 
                            if (row.status === 'B') {
                                var eqIdStr = String(row.equipmentId);
                                var borrow = lastBorrowByEqId[eqIdStr];
                                var borrowerName = (borrow && borrow.userBorrowid) ?
                                    (userById[(borrow.userBorrowid || '').toLowerCase()] || borrow.userBorrowid) : '';
                                
                                searchStr += ' ' + borrowerName;
                            }
                            return searchStr;
                        }
                    	
                        var nameHtml = '<div class="fw-normal fs-5 text-gray-900">' + (row.name || '') + '</div>';
                        var detailHtml = row.detail ? 
                            '<div class="d-flex align-items-center mt-1 fw-semibold fs-5 text-gray-900">' +
                                '<i class="ki-duotone ki-message-text fs-4 me-3 text-gray-500"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>' +
                                row.detail +
                            '</div>' : '';

                        return nameHtml + detailHtml;
                    }
                },
                // Col 5: Status
                {
                    data: 'status',
                    render: function(status, type, row) {
                        var val = (status) ? status.toString().trim() : '';
                        if (type === 'filter' || type === 'sort') return val;
                        return getStatusBadgeHtml(val, row);
                    }
                },
                // Col 6: Actions
                {
                    data: null,
                    orderable: false,
                    className: 'text-end align-top',
                    render: function(data, type, row) {
                    	var id = row.equipmentId;
                        return '<div class="eq-actions">' +
                               '<a href="javascript:;" onclick="openViewModal(\'' + id + '\')" class="btn btn-icon btn-sm btn-light-info mb-1 fs-3"><i class="ki-duotone ki-document fs-1"><span class="path1"></span><span class="path2"></span></i></a> ' +
                               '<a href="equipment_edit?id=' + id + '" class="btn btn-icon btn-sm btn-light-primary mb-1 fs-3"><i class="ki-duotone ki-pencil fs-1"><span class="path1"></span><span class="path2"></span></i></a> ' +
                               '<a href="javascript:;" onclick="confirmDelete(\'' + id + '\')" class="btn btn-icon btn-sm btn-light-danger mb-1 fs-3 me-3"><i class="ki-duotone ki-trash fs-1"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i></a>' +
                               '</div>';
                    }
                }
            ]
        });

        // Update Items Found
        table.on('draw', function () {
            var info = table.page.info();
            $('#currentTotalRows').text(info.recordsDisplay);
        });

        // Search Box to Data Table
        $('#searchInput').on('keyup', function() { table.search(this.value).draw(); });

        // ========= FILTER LOGIC (Checkbox Multi-select) ==================
        function updateFilter(containerId, columnIndex) {
            var selected = [];
            var labels = [];
            var container = $(containerId);
            var allCheckboxes = container.find('input[type="checkbox"]');
            var checkedCheckboxes = container.find('input[type="checkbox"]:checked');

            // เก็บค่า Value ของตัวที่ติ๊กถูก
            checkedCheckboxes.each(function() {
                var val = $.fn.dataTable.util.escapeRegex($(this).val().trim());
                selected.push(val);
                labels.push($(this).parent().find('span').text().trim());
            });

            // สร้าง Regex สำหรับค้นหาหลายค่าด้วย OR 
            var regex = selected.length ? '^(' + selected.join('|') + ')$' : '';
            
            // สั่ง DataTable ให้ค้นหาเฉพาะคอลัมน์นั้น
            table.column(columnIndex).search(regex, true, false).draw();

            // อัปเดตข้อความบนปุ่ม Dropdown
            var btnSpan = container.closest('.dropdown').find('button span').first();
            var defaultText = (containerId === '#statusFilterContainer') ? 'All Status' : 'Select';
            
            if (checkedCheckboxes.length === 0) {
                 btnSpan.text(defaultText);
            } else if (checkedCheckboxes.length === allCheckboxes.length && containerId === '#statusFilterContainer') {
                 btnSpan.text('All Status');
            } else {
                 btnSpan.text(labels.length <= 2 ? labels.join(', ') : labels.length + ' Selected');
            }
        }

        // เชื่อม Event Checkbox เปลี่ยนค่า -> เรียก updateFilter
        $('#statusFilterContainer').on('change', '.filter-status', function() {
            updateFilter('#statusFilterContainer', 4); // Column Status
        });
        $('#typeFilterContainer').on('change', '.filter-type', function() {
             updateFilter('#typeFilterContainer', 2); // Column Type
        });

        // Select All / Deselect All ใน Dropdown
        $('.dropdown-menu .btn-primary').on('click', function(e) {
            e.stopPropagation();
            var menu = $(this).closest('.dropdown-menu');
            menu.find('input[type="checkbox"]').prop('checked', true); // ติ๊กทุกอัน
            if (menu.find('#statusFilterContainer').length) updateFilter('#statusFilterContainer', 4);
            if (menu.find('#typeFilterContainer').length) updateFilter('#typeFilterContainer', 2);
        });
        
        $('.dropdown-menu .btn-light').on('click', function(e) {
            e.stopPropagation();
            var menu = $(this).closest('.dropdown-menu');
            menu.find('input[type="checkbox"]').prop('checked', false); // เอาติ๊กออกหมด
            if (menu.find('#statusFilterContainer').length) updateFilter('#statusFilterContainer', 4);
            if (menu.find('#typeFilterContainer').length) updateFilter('#typeFilterContainer', 2);
        });

        // ป้องกัน Dropdown ปิดเมื่อคลิกพื้นที่ว่างในเมนู
        $('.dropdown-menu').on('click', function(e) { e.stopPropagation(); });
        
        // ============= UI Logic การเปิด/ปิด More Details ใน Modal ============================
        var moreDetailCollapse = document.getElementById('kt_view_equipment_more_details');
        if (moreDetailCollapse) {
            // กด More Detail ซ่อนส่วน Borrow
            moreDetailCollapse.addEventListener('show.bs.collapse', function () {
                $('#view_borrow_detailed_info').slideUp();
            });
            // ปิด More Detail แสดงส่วน Borrow กลับมา
            moreDetailCollapse.addEventListener('hide.bs.collapse', function () {
                $('#view_borrow_detailed_info').slideDown();
            });
        }
    });
    
    // ======= Functions แปลงวันที่ ============
    function formatDateTime(dateStr) {
        if (!dateStr) return '-';
        var d = new Date(dateStr);
        if (isNaN(d.getTime())) return dateStr;
        var day = d.getDate();
        var month = d.toLocaleString('en-GB', { month: 'short' });
        var year = d.getFullYear();
        var hours = d.getHours().toString().padStart(2, '0');
        var minutes = d.getMinutes().toString().padStart(2, '0');
        return day + ' ' + month + ' ' + year + ', ' + hours + ':' + minutes;
    }

    function formatDateOnly(dateStr) {
        if (!dateStr) return '-';
        var d = new Date(dateStr);
        if (isNaN(d.getTime())) return dateStr;
        return d.getDate() + ' ' + d.toLocaleString('en-GB', { month: 'short' }) + ' ' + d.getFullYear();
    }

    // =============== MODAL & ACTIONS ==============================
    // View Modal
    function openViewModal(id) {
        // หาข้อมูลอุปกรณ์ชิ้นนั้นจาก Array
        var item = equipments.find(x => x.equipmentId == id);
        if (!item) return;

        // Data in modal
        $('#kt_modal_view_equipment .modal-header h2').text('Equipment Detail');
        $('#view_item_no').text('ID: ' + (item.itemNo || '-'));
        $('#view_name').text(item.name || '-');
        $('#view_serial').text(item.serialNo || '-');
        $('#view_amount').text(item.amount || '0');
        $('#view_detail').text(item.detail || '-');
        $('#view_purchase_date').text(formatDateOnly(item.timeCreate));
        
        $('#view_os').text(item.windows || '-');
        $('#view_cpu').text(item.process || '-');
        $('#view_ram').text(item.ram || '-');
        $('#view_storage').text(item.hdd || '-');
        $('#view_battery').text(item.battery || '-');
        $('#view_display').text(item.display || '-');
        $('#view_wifi').text(item.wifiaddress || '-');
        $('#view_lan').text(item.lanaddress || '-');

        var iconHtml = getIconHtml(item.type);
        iconHtml = iconHtml.replace('ms-6', 'me-3'); 
        $('#view_type_icon').html(iconHtml);

        // Borrow Return btn
        var badge = $('#view_status_badge');
        var btnEdit = $('#view_btn_edit');
        var btnReturn = $('#view_btn_return');
        var btnBorrow = $('#view_btn_borrow');
        var borrowSection = $('#view_borrow_section');
        var returnSection = $('#view_return_section');

        // Reset UI Elements
        badge.removeClass().addClass('badge badge-lg fw-semibold py-2');
        btnReturn.addClass('d-none');
        btnBorrow.addClass('d-none');
        borrowSection.addClass('d-none');
        returnSection.addClass('d-none');
        $('#return_note').val('');
        btnEdit.attr('href', 'equipment_edit?id=' + id);

        // ตั้งสี Badge ตาม Config
        var stConfig = STATUS_CONFIG[item.status];
        if (stConfig) {
            badge.addClass(stConfig.class).text(stConfig.label);
        } else {
            badge.addClass('badge-light').text(item.status || '-');
        }

        // =========== LOGIC ปุ่ม Borrow and Return ===============
        // กรณี A: Available โชว์ปุ่ม Borrow
        if (item.status === 'A') {
            btnBorrow.removeClass('d-none');
            btnBorrow.off('click').on('click', function() {
                 window.location.href = 'borrow_add?equipmentId=' + id;
            });
        
        // กรณี B: Borrowed โชว์ปุ่ม Return และรายละเอียดคนยืม
        } else if (item.status === 'B') {
            btnReturn.removeClass('d-none');
            var eqIdStr = String(item.equipmentId);
            var borrow = lastBorrowByEqId[eqIdStr]; // หาข้อมูลการยืมล่าสุด
            
            if (borrow) {
                borrowSection.removeClass('d-none');
                $('#view_borrow_id_display').text(borrow.borrowId || '-');
                
                // หาชื่อคนยืมจาก User List
                var borrowerID = (borrow.userBorrowid || '').toLowerCase();
                var borrower = users.find(u => (u.id || '').toLowerCase() === borrowerID);
                var borrowerStr = '-';
                if (borrower) {
                    var infoParts = [];
                    var empId = borrower.employee_id || borrower.employeeId;
                    var thName = borrower.name;
                    var enName = borrower.name_en || borrower.nameEn || borrower.nick_name;
                    // Format: รหัส - ชื่อไทย - ชื่ออังกฤษ
                    if (empId) infoParts.push(empId);
                    if (thName) infoParts.push(thName);
                    if (enName) infoParts.push(enName);
                    borrowerStr = infoParts.join('   -   ');
                } else {
                    borrowerStr = (borrow.userBorrowid || '-') + ' (Unknown User)';
                }
                
                $('#view_borrower_full').text(borrowerStr);
                $('#view_location').text(borrow.location || item.location || '-');
                var dStart = formatDateTime(borrow.dateStart);
                var dEnd = borrow.dateEnd ? formatDateTime(borrow.dateEnd) : 'None';
                $('#view_borrow_date').text(dStart + ' - ' + dEnd);

             	// =========== Logic Request for Return ==================
                btnReturn.off('click').on('click', function() {
                    
                    //  ถ้า Approver ยังไม่เปิด ให้เปิดก่อน
                    if (returnSection.hasClass('d-none')) {
                        returnSection.hide().removeClass('d-none').slideDown(500);
                        $('#return_note').focus();
                        $('#kt_modal_view_equipment .modal-header h2').text('Request for Return Equipment');
                        
                    //  ถ้า Approver เปิด AJAX บันทึกคืนของ
                    } else {
                        var note = $('#return_note').val();
                        var originalText = btnReturn.text();
                        btnReturn.prop('disabled', true).text('Processing...');

                        $.post('equipment_return', { 
                            equipmentId: id, 
                            borrowId: borrow.borrowId,
                            note: note
                        }, function(res) {
                            res = res.trim();
                            if(res === 'success') {
                                location.reload();
                            } 
                            else if (res === 'login') {
                                window.location.href = 'index.jsp'; 
                            } 
                            else {
                                alert('Error returning item.');
                                btnReturn.prop('disabled', false).text(originalText);
                            }
                        });
                    }
                });
            }
        }
        // เปิด Modal
        $('#kt_modal_view_equipment').modal('show');
    }
    
    // ฟังก์ชันยืนยันการลบ
    function confirmDelete(id) {
        Swal.fire({
            title: '<h1 class="fw-semibold text-gray-900 mt-10">Confirm Delete ?</h1>',
            html: `<span class="fw-medium text-gray-800 fs-5">Are you sure you want to delete it?</span> <br>
                   <span class="fw-medium text-gray-800 fs-5">Once the data is deleted, it cannot be recovered.</span>`,
            width: '500px',
            icon: undefined, 
            iconHtml: `
                <i class="ki-duotone ki-information text-danger" style="font-size: 10rem;">
                    <span class="path1"></span><span class="path2"></span>
                    <span class="path3"></span>
                </i>
            `,
            showCancelButton: true,
            cancelButtonText: 'Cancel',
            confirmButtonText: 'Delete',
            customClass: {
                icon: 'border-0',
                cancelButton: 'btn btn-light',
                confirmButton: "btn btn-danger"
            },
            focusConfirm: false,
            focusCancel: true
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "equipment_delete?id=" + id;
            }
        })
    }
</script>