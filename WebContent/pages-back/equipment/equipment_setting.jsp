<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- <style>
    .badge-cyan {
    color: var(--bs-cyan-inverse);
    background-color: var(--bs-cyan)
    }
    .badge-cyan.badge-outline {
        border: 1px solid var(--bs-cyan);
        background-color: transparent;
        color: var(--bs-cyan)
    }
</style> -->

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">

        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-xxl d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Equipment Status</h1>
                    <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                        <li class="breadcrumb-item text-muted">
                            <a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a>
                        </li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted">Borrow</li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted">
                             <a href="${pageContext.request.contextPath}/equipment_list" class="text-muted text-hover-primary">Equipment</a>
                        </li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted">Setting Equipment</li>
                    </ul>
                </div>
            </div>
        </div>
        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-xxl">
                
                <div class="card card-flush h-xl-100">
                    <div class="card-header py-7">
                        <div class="card-title pt-3 mb-0 gap-4 gap-lg-10 gap-xl-15 nav nav-tabs border-bottom-0" data-kt-table-widget-3="tabs_nav">
                            
                            <div class="fs-4 fw-bold text-primary pb-3 cursor-pointer border-bottom border-3 border-primary" 
                                 data-kt-table-widget-3="tab" 
                                 data-tab-target="#kt_tab_equipment_status">
                                Equipment Status
                            </div>
                            <div class="fs-4 fw-bold pb-3 cursor-pointer text-muted" 
                                 data-kt-table-widget-3="tab" 
                                 data-tab-target="#kt_tab_equipment_type">
                                Equipment Type
                            </div>
                            </div>
                        <div class="card-toolbar">
                            <a href="javascript:;" onclick="goToCreatePage()" class="btn btn-success d-inline-flex align-items-center px-6 py-3">
                                <i class="ki-duotone ki-plus fs-2 me-2">
                                    <span class="path1"></span><span class="path2"></span>
                                </i>
                                <span class="fw-bold">Create</span>
                            </a>
                        </div>
                        </div>
                    <div class="card-body pt-5">
                        <div class="tab-content">
                            
                            <div class="tab-pane fade show active" id="kt_tab_equipment_status">
                                <div class="table-responsive">
                                    <table class="table table-striped align-middle table-row-dashed fs-6 gy-5" id="table_status">
                                        <thead>
                                            <tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0">
                                                <th class="min-w-50px">Type</th>
                                                <th class="min-w-100px">Status</th>
                                                <th class="min-w-150px">Color</th>
                                                <th class="min-w-150px">Create</th>
                                                <th class="min-w-150px">Update</th>
                                                <th class="text-end min-w-100px">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody class="fw-semibold text-gray-600" id="tbody_status">
                                            </tbody>
                                    </table>
                                </div>
                            </div>
                            
                            <div class="tab-pane fade" id="kt_tab_equipment_type">
                                <div class="table-responsive">
                                    <table class="table table-striped align-middle table-row-dashed fs-6 gy-5" id="table_type">
                                        <thead>
                                            <tr class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0">
                                                <th class="min-w-70px">Type</th>
                                                <th class="min-w-80px">Icon</th>
                                                <th class="min-w-150px">Name</th>
                                                <th class="min-w-150px">Create</th>
                                                <th class="min-w-150px">Update</th>
                                                <th class="text-end min-w-100px">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody class="fw-semibold text-gray-900" id="tbody_type">
                                            </tbody>
                                    </table>
                                </div>
                            </div>

                        </div>
                    </div>
                    </div>
            </div>
        </div>
        
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Load Data
        var statusData = ${requestScope.list != null ? requestScope.list : '[]'};
        var typeData = ${requestScope.tlist != null ? requestScope.tlist : '[]'};
        
        renderStatusTable(statusData);
        renderTypeTable(typeData);

        // Custom Tab Logic
        var tabs = document.querySelectorAll('[data-kt-table-widget-3="tab"]');
        tabs.forEach(function(tab) {
            tab.addEventListener('click', function() {
                // Reset Visuals
                tabs.forEach(function(t) {
                    t.classList.remove('border-bottom', 'border-3', 'border-primary','text-primary');
                    t.classList.add('text-muted');
                });
                // Set Active Visuals
                this.classList.remove('text-muted');
                this.classList.add('border-bottom', 'border-3', 'border-primary','text-primary');
                // Switch Content
                var targetSelector = this.getAttribute('data-tab-target');
                document.querySelectorAll('.tab-pane').forEach(function(pane) {
                    pane.classList.remove('show', 'active');
                });
                var targetPane = document.querySelector(targetSelector);
                if(targetPane) {
                    targetPane.classList.add('show', 'active');
                }
            });
        });
    });

 // --- Render Functions ---
 // ====================== Status Table =================================
    function renderStatusTable(data) {
        var tbody = document.getElementById('tbody_status');
        var html = '';

        // Color List
        var COLOR_LIST = [
            { id: 'success',   name: 'Success' },
            { id: 'primary',   name: 'Primary' },
            { id: 'danger',    name: 'Danger' },
            { id: 'info',      name: 'Info' },
            { id: 'cyan',      name: 'Cyan' },
            { id: 'warning',   name: 'Warning' },
            { id: 'dark',      name: 'Dark' },
            { id: 'secondary', name: 'Secondary' }
        ];

        data.forEach(function(item) {
            var statusId = item.statusId || item.status; 
            
            // Badge Class From Color Field 
            var badgeClass = getBadgeClassFromDB(item.color2, statusId);
            var dbColorId = badgeClass.replace('badge-', ''); // remove 'badge-'
            
            // Map COLOR_LIST to Text
            var colorName = dbColorId; // Default show text
            COLOR_LIST.forEach(function(c) {
                if (c.id === dbColorId) {
                    colorName = c.name;
                }
            });

            // Format Date/Time
            var createDate = formatDateTime(item.timeCreate);
            var updateDate = formatDateTime(item.timeUpdate);

         	// Status Table Show Data
            html += '<tr>';
            html += '<td class="fw-bold text-gray-900 fs-7 ps-4 align-top">' + (statusId || '-') + '</td>';
            html += '<td class="align-top"><span class="badge ' + badgeClass + ' fs-7 px-4 py-2">' + (item.description) + '</span></td>';
            html += '<td class="text-gray-900 fw-normal fs-6 mb-1 align-top">' + colorName + '</td>';
            html += '<td class="align-top"><div class="d-flex flex-column"><span class="text-gray-900 fw-normal fs-6 mb-1">' + (item.userCreate || '-') + '</span><span class="text-gray-700 fw-normal fs-6">' + createDate + '</span></div></td>';
            html += '<td class="align-top"><div class="d-flex flex-column"><span class="text-gray-900 fw-normal fs-6 mb-1">' + (item.userUpdate || '-') + '</span><span class="text-gray-700 fw-normal fs-6">' + updateDate + '</span></div></td>';
         	// Actions
            html += '<td class="text-end"> <a href="equipment_status_edit?id=' + statusId + '" class="btn btn-icon btn-sm btn-light-primary mb-1 fs-3 me-3"><i class="ki-duotone ki-pencil fs-1"><span class="path1"></span><span class="path2"></span></i></a>' +
                    '<a href="javascript:;" onclick="confirmStatusDelete(\'' + statusId + '\')" class="btn btn-icon btn-sm btn-light-danger mb-1 fs-3 me-3"><i class="ki-duotone ki-trash fs-1"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i></a></td>';
            html += '</tr>';
        });
        
        if(data.length === 0) html = '<tr><td colspan="6" class="text-center text-muted py-5">No status data found</td></tr>';
        
        tbody.innerHTML = html;
    }

 	// Mapping Keyword to Class
    function getBadgeClassFromDB(dbColor, statusId) {
    	var color = (dbColor || '').toString().toLowerCase()
         
        if (color.includes('success')) return 'badge-success';
        if (color.includes('primary')) return 'badge-primary';
        if (color.includes('danger')) return 'badge-danger';
        if (color.includes('info')) return 'badge-info';
        if (color.includes('cyan')) return 'badge-cyan'; 
        if (color.includes('warning')) return 'badge-warning';
        if (color.includes('dark')) return 'badge-dark';
        if (color.includes('secondary')) return 'badge-secondary';
        if (color.startsWith('badge-')) return color; // Have prefix 'badge-' return color   

        // Non: return 'badge-secondary'
        return 'badge-secondary';
    }
 	
    function confirmStatusDelete(statusId) {
        Swal.fire({
            title: '<h1 class="fw-semibold text-gray-900 mt-10">Confirm Delete ?</h1>',
            html: `<span class="fw-medium text-gray-800 fs-5">Are you sure you want to delete it?</span> <br>
                   <span class="fw-medium text-gray-800 fs-5">Once the data is deleted, it cannot be recovered.</span>`,
            width: '500px',
            icon: undefined, 
            iconHtml: `
                <i class="ki-duotone ki-information text-danger" style="font-size: 10rem;">
                    <span class="path1"></span>
                    <span class="path2"></span>
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
                window.location.href = "equipment_status_delete?id=" + statusId;
            }
        })
    }

    // ====================== Type Table =================================
    function renderTypeTable(data) {
        var tbody = document.getElementById('tbody_type');
        var html = '';
        
        data.forEach(function(item) {
            // ดึงค่า typeText ถ้าไม่มีใช้ default
            var dbIcon = item.typeText; 
            var iconClass = (dbIcon && dbIcon.trim() !== '') ? dbIcon : 'ki-solid ki-dots-square'; 
            
            var typeId = (item.TypeID || '').toString();
            var createDate = formatDateTime(item.timeCreate);
            var updateDate = formatDateTime(item.timeUpdate);

            // Type Table Show Data
            html += '<tr>';
            html += '<td class="fw-normal text-gray-900 fs-6 ps-3 align-top">' + (typeId || '-') + '</td>';
            html += '<td class="align-top"><i class="' + iconClass + ' fs-2x text-gray-500"></i></td>';
            html += '<td class="text-gray-900 fw-normal fs-6 align-top">' + (item.description || '-') + '</td>';
            html += '<td class="align-top"><div class="d-flex flex-column"><span class="text-gray-900 fw-normal fs-6 mb-1">' + (item.userCreate || '-') + '</span><span class="text-gray-700 fw-normal fs-6">' + createDate + '</span></div></td>';
            html += '<td class="align-top"><div class="d-flex flex-column"><span class="text-gray-900 fw-normal fs-6 mb-1">' + (item.userUpdate || '-') + '</span><span class="text-gray-700 fw-normal fs-6">' + updateDate + '</span></div></td>';
         	// Actions
            html += '<td class="text-end"> <a href="equipment_type_edit?id=' + typeId + '" class="btn btn-icon btn-sm btn-light-primary mb-1 fs-3 me-3"><i class="ki-duotone ki-pencil fs-1"><span class="path1"></span><span class="path2"></span></i></a>' +
                    '<a href="javascript:;" onclick="confirmTypeDelete(\'' + typeId + '\')" class="btn btn-icon btn-sm btn-light-danger mb-1 fs-3 me-3"><i class="ki-duotone ki-trash fs-1"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i></a></td>';
            html += '</tr>';
        });
        
        if(data.length === 0) html = '<tr><td colspan="6" class="text-center text-muted py-5">No type data found</td></tr>';
        tbody.innerHTML = html;
    }
    
 // --- Format Date/Time ---
    function formatDateTime(dateStr) {
        if (!dateStr) return '-';
        
        // ลองแปลงเป็น Date Object
        var date = new Date(dateStr);
        
        // เช็คว่าแปลงสำเร็จไหม
        if (isNaN(date.getTime())) return dateStr;
        
        var day = String(date.getDate()).padStart(2, '0');
        var month = String(date.getMonth() + 1).padStart(2, '0');
        var year = date.getFullYear();
        var hours = String(date.getHours()).padStart(2, '0');
        var minutes = String(date.getMinutes()).padStart(2, '0');
        var seconds = String(date.getSeconds()).padStart(2, '0');
        
        // คืนค่ารูปแบบ "dd/MM/yyyy, HH:mm:ss"
        return day + '/' + month + '/' + year + ', ' + hours + ':' + minutes + ':' + seconds;
    }
 
    function confirmTypeDelete(typeId) {
        Swal.fire({
            title: '<h1 class="fw-semibold text-gray-900 mt-10">Confirm Delete ?</h1>',
            html: `<span class="fw-medium text-gray-800 fs-5">Are you sure you want to delete it?</span> <br>
                   <span class="fw-medium text-gray-800 fs-5">Once the data is deleted, it cannot be recovered.</span>`,
            width: '500px',
            icon: undefined, 
            iconHtml: `
                <i class="ki-duotone ki-information text-danger" style="font-size: 10rem;">
                    <span class="path1"></span>
                    <span class="path2"></span>
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
                window.location.href = "equipment_type_delete?id=" + typeId;
            }
        })
    }
 
    function goToCreatePage() {
        // เช็คว่า Tab Status มี class 'active' หรือไม่ 
        var statusTab = document.getElementById('kt_tab_equipment_status');
        
        if (statusTab.classList.contains('active')) {
            // ถ้าอยู่หน้า Status ให้ไปหน้า Add Status
            window.location.href = 'equipment_status_add'; 
        } else {
            // ถ้าไม่อย่างนั้น ให้ไปหน้า Add Type
            window.location.href = 'equipment_type_add';
        }
    }
    
    $(document).ready(function() {
        const urlParams = new URLSearchParams(window.location.search);
        const currentTab = urlParams.get('tab');  
        if (currentTab === 'type') {
        	$('[data-tab-target="#kt_tab_equipment_type"]').click();
        }
    });
</script>