<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
   
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                    <h1 class="page-heading d-flex text-gray-700 fw-semibold my-0">Create Equipment Status</h1>
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
                
                <form action="/equipment_status_save.action" method="post" id="kt_equipment_status_add_form">
            
                    <div class="card shadow-sm">
                        <div class="card-header border-0 pt-7">
                            <div class="card-title">
                                <h2 class="mb-0">Equipment Status</h2>
                            </div>
                        </div>

                        <div class="card-body py-10">
                          
                            <div class="mb-10">
                                <label class="form-label required fw-bold">Type (ID)</label>
                                <input type="text" class="form-control" name="status" id="field_status" placeholder="e.g. A, B, C" maxlength="3" required />
                                <div id="status_id_error" class="text-danger mt-2" style="display:none;">This Type (ID) already exists in the system. Please use a different name.</div>
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
                                <span id="badge_preview" class="badge badge-secondary fs-7 px-4 py-2">Preview</span>
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

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // รายการสี
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
        colorSelect.innerHTML = '';
        
        // เพิ่ม option ว่างสำหรับ placeholder
        colorSelect.add(new Option('', ''));

        COLOR_LIST.forEach(function(color) {
            var option = new Option(color.name, color.id);
            colorSelect.add(option);
        });

        $('#field_color').select2({
            minimumResultsForSearch: Infinity
        });

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
            
            // จัดการ prefix badge-
            if(color && !color.startsWith('badge-')) {
                color = 'badge-' + color;
            } else if (!color) {
                color = 'badge-secondary';
            }
            badge.classList.add(color);
        }
    
     	// Check Duplicate
        $(document).ready(function() {
            var statusInput = document.getElementById('field_status');
            var submitBtn = document.getElementById('submit_btn');
            var errorMsg = document.getElementById('status_id_error');

            if(statusInput) {
                statusInput.addEventListener('input', function() {
                    this.classList.remove('is-invalid');
                    this.classList.remove('border-success');
                    errorMsg.style.display = 'none';
                    submitBtn.disabled = false;
                });

                statusInput.addEventListener('blur', function() {
                    var id = this.value.trim();
                    
                    if(id === "") return; 

                    $.ajax({
                        url: 'checkStatusDuplicate',
                        type: 'POST',
                        data: { statusId: id },
                        success: function(response) {
                            if (response.status === 'duplicate') {
                                // กรณีซ้ำ
                                statusInput.classList.remove('border-success');
                                statusInput.classList.add('is-invalid');
                                errorMsg.style.display = 'block';
                                submitBtn.disabled = true;
                                
                            } else {
                                // กรณีใช้ได้
                                statusInput.classList.remove('is-invalid');
                                statusInput.classList.add('border-success');
                                errorMsg.style.display = 'none';
                                submitBtn.disabled = false;
                            }
                        },
                        error: function(err) {
                            console.error("Error checking status duplicate:", err);
                        }
                    });
                });
            }
        });
    
    });
</script>