<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-xxl d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Create Equipment Type</h1>
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
                
                <form action="/equipment_type_save.action" method="post" id="kt_equipment_type_add_form">
                     
                    <div class="card shadow-sm">
                        <div class="card-header border-0 pt-7">
                            <div class="card-title">
                                <h2 class="mb-0">New Type Details</h2>
                            </div>
                        </div>

                        <div class="card-body py-10">
                            
                            <div class="mb-10">
                                <label class="form-label required fw-bold">Type ID</label>
                                <input type="text" class="form-control" name="Type" id="field_type_id" placeholder="Enter ID (e.g. NB, PC)" required />
                            </div>

                            <div class="mb-10">
                                 <label class="form-label required fw-bold">Type Name</label>
                                <input type="text" class="form-control" name="description" id="field_description" placeholder="Enter type name" required />
                            </div>

                            <div class="mb-8">
                                <label class="form-label required fw-bold">Type Icon</label>
                                <div class="d-flex align-items-center">
                                    <div class="flex-grow-1 me-3">
                                        <select class="form-select" name="type_text" id="field_icon" data-control="select2" data-placeholder="Select an icon">
                                            <option></option>
                                        </select>
                                     </div>
                                    
                                    <div class="d-flex justify-content-center align-items-center px-6">
                                         <i id="icon_preview" class="fs-2x text-gray-600 ki-solid ki-dots-square"></i>
                                    </div>
                                </div>
                             </div>
                        </div>

                        <div class="card-footer d-flex justify-content-end gap-3 p-8">
                             <a href="equipment_setting" class="btn btn-light px-8">Cancel</a> 
                            <button type="submit" class="btn btn-success px-8">Save</button>
                        </div>
                    
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // รายการไอคอน
    const AVAILABLE_ICONS = [
        "ki-solid ki-laptop",
        "ki-solid ki-keyboard",
        "ki-solid ki-verify",
        "ki-solid ki-phone",
        "ki-solid ki-wifi-square",
        "ki-solid ki-dots-square"
    ];

    document.addEventListener("DOMContentLoaded", function() {
        var select = $('#field_icon');

        // สร้างตัวเลือกใน Dropdown
        AVAILABLE_ICONS.forEach(function(iconClass) {
            select.append(new Option(iconClass, iconClass, false, false));
        });
        
        $('#field_icon').select2({
            minimumResultsForSearch: Infinity
        });

        // อัปเดต Preview เมื่อเลือกเปลี่ยน
        select.on('select2:select', function (e) {
            var data = e.params.data;
            updatePreview(data.id);
        });
    });

    function updatePreview(iconClass) {
        if(!iconClass) iconClass = 'ki-solid ki-dots-square';
        $('#icon_preview').attr('class', 'fs-2x text-gray-600 ' + iconClass);
    }
</script>