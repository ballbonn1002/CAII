<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
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
            <div id="kt_app_content_container" class="app-container container-fluid">
                
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
                                <input type="text" class="form-control" name="Type" id="field_type_id" placeholder="Enter ID (e.g. NB, PC)" maxlength="3" required />
                                <div id="type_id_error" class="text-danger mt-2" style="display:none;">This Type ID already exists in the system. Please use a different name.</div>
                            </div>

                            <div class="mb-10">
                                <label class="form-label required fw-bold">Type Name</label>
                                <input type="text" class="form-control" name="description" id="field_description" placeholder="Enter type name" required />
                            </div>

                            <div class="mb-8">
                                <label class="form-label required fw-bold">Type Icon</label>
                                <div class="d-flex align-items-center">
                                    <div class="flex-grow-1 me-3">
                                        <select class="form-select" name="type_text" id="field_icon" data-control="select2" data-placeholder="Select an icon" required>
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
                            <button type="submit" id="submit_btn" class="btn btn-success px-8">Save</button>
                        </div>
                    
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/custom/icons/keenicons.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var select = $('#field_icon');
        var data = getIconsForSelect2()

        select.select2({
            data: data,
            placeholder: "Select or Search Icon...",
            allowClear: true,
            minimumInputLength: 0
        });

        // Preview
        select.on('select2:select', function (e) {
            var iconClass = e.params.data.id;
            updatePreview(iconClass);
        });

        select.on('select2:clear', function (e) {
             updatePreview('');
        });

        // Check Duplicate
        var typeIdInput = document.getElementById('field_type_id');
        var submitBtn = document.getElementById('submit_btn');
        var errorMsg = document.getElementById('type_id_error');

        typeIdInput.addEventListener('input', function() {
        	typeIdInput.classList.remove('is-invalid');
            typeIdInput.classList.remove('border-success');
            errorMsg.style.display = 'none';
            submitBtn.disabled = false;
        });

        typeIdInput.addEventListener('blur', function() {
            var id = this.value.trim();
            if(id === "") return;
            
            $.ajax({
                url: 'checkTypeDuplicate',
                type: 'POST',
                data: { typeId: id },
                success: function(response) {
                    if (response.status === 'duplicate') {
                        typeIdInput.classList.remove('border-success');
                        typeIdInput.classList.add('is-invalid');
                        errorMsg.style.display = 'block';
                        submitBtn.disabled = true;
                    } else {
                        typeIdInput.classList.remove('is-invalid');
                        typeIdInput.classList.add('border-success');
                        errorMsg.style.display = 'none';
                        submitBtn.disabled = false;
                    }
                },
                error: function(err) {
                    console.error("Error checking duplicate:", err);
                }
            });
        });
    });

    // Update Preview
    function updatePreview(iconClass) {
        if(!iconClass) iconClass = 'ki-solid ki-dots-square';
        $('#icon_preview').attr('class', 'fs-2x text-gray-500 ' + iconClass);
    }
</script>