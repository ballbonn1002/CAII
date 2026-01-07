<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
                        <li class="breadcrumb-item text-muted">Equipment</li>
                        <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
                        <li class="breadcrumb-item text-muted">Setting Equipment</li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="kt_app_content" class="app-content flex-column-fluid">
            <div id="kt_app_content_container" class="app-container container-xxl">
                
                <form action="/equipment_status_update.action" method="post" id="kt_equipment_status_edit_form">
                    
                    <div class="card shadow-sm">
                        <div class="card-header border-0 pt-7">
                            <div class="card-title">
                                <h2 class="mb-0">Equipment Status</h2>
                            </div>
                        </div>

                        <div class="card-body py-10">
                            
                            <div class="mb-10">
                                <label class="form-label required fw-bold">Type</label>
                                <input type="text" class="form-control" name="status" id="field_status" readonly />
                            </div>

                            <div class="mb-10">
                                <label class="form-label required fw-bold">Status Name</label>
                                <input type="text" class="form-control" name="description" id="field_description" placeholder="e.g. Available, Borrowed" required />
                            </div>

                            <div class="mb-8">
                                <label class="form-label required fw-bold">Color</label>
                                <select class="form-select" name="color2" id="field_color" data-control="select2" data-placeholder="Select a color" required></select>
                            </div>

                            <div class="mb-0">
                                <span id="badge_preview" class="badge badge-success fs-7 px-4 py-2"></span>
                            </div>

                        </div>

                        <div class="card-footer d-flex justify-content-end gap-3 p-8">
                            <a href="equipment_setting" class="btn btn-light px-8">Cancel</a> <button type="submit" class="btn btn-success px-8">Save</button>
                        </div>
                    
                    </div>
                </form>
                </div>
        </div>

    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var COLOR_LIST = [
            { id: 'success',   name: 'Green-Success' },
            { id: 'primary',   name: 'Blue-Primary' },
            { id: 'danger',    name: 'Red-Danger' },
            { id: 'info',      name: 'Purple-Info' },
            { id: 'cyan',      name: 'Cyan-Cyan' },
            { id: 'warning',   name: 'Yellow-Warning' },
            { id: 'dark',      name: 'Dark-Dark' },
            { id: 'secondary', name: 'Gray-Secondary' }
        ];

        // สร้าง Option ลงใน Dropdown
        var colorSelect = document.getElementById('field_color');
        // ล้างค่าเก่า
        colorSelect.innerHTML = ''; 
        
        COLOR_LIST.forEach(function(color) {
            // สร้าง <option value="success">Green - Success</option>
            // ใช้ value เป็น id
            var option = new Option(color.name, color.id);
            colorSelect.add(option);
        });
        
        $('#field_color').select2({
            minimumResultsForSearch: Infinity
        });

        // รับข้อมูลจาก Server
        var info = ${info != null ? info : '{}'};
        console.log("Status Data:", info);

        // นำข้อมูลมาใส่ใน Input Fields
        if(info.statusId || info.status) {
            document.getElementById('field_status').value = info.statusId || info.status;
            document.getElementById('field_description').value = info.description || '';
            
            // จัดการเรื่องสีที่มาจาก DB
            var dbColor = info.color2 ? info.color2.toLowerCase() : 'secondary';
            // ตัดคำว่า badge- ออก
            dbColor = dbColor.replace('badge-', '');
            
            // เลือกค่าใน Dropdown
            $('#field_color').val(dbColor).trigger('change');
            
            // Update Preview
            updateBadgePreview(info.description, dbColor);
        }
        // Event Listeners
        $('#field_color').on('change', function() {
            var selectedColor = $(this).val();
            var text = $('#field_description').val() || 'Preview';
            updateBadgePreview(text, selectedColor);
        });

        $('#field_description').on('input', function() {
            var text = $(this).val() || 'Preview';
            var selectedColor = $('#field_color').val();
            updateBadgePreview(text, selectedColor);
        });

        function updateBadgePreview(text, color) {
            var badge = document.getElementById('badge_preview');
            badge.innerText = text;
            
            badge.className = 'badge fs-7 px-4 py-2';
            // เวลาแสดงผลต้องมี badge- นำหน้า
            if(color && !color.startsWith('badge-')) {
                color = 'badge-' + color;
            }
            badge.classList.add(color);
        }
    });
</script>