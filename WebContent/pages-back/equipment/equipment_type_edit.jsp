<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
    <div class="d-flex flex-column flex-column-fluid">
        
        <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
            <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
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
            <div id="kt_app_content_container" class="app-container container-fluid">
                
                <form action="/equipment_type_update.action" method="post" id="kt_equipment_type_edit_form">
                    <div class="card shadow-sm">
                        <div class="card-header border-0 pt-7">
                            <div class="card-title">
                                <h2 class="mb-0">Equipment Type</h2>
                            </div>
                        </div>

                        <div class="card-body py-10">
                            
                            <div class="mb-10">
                                <label class="form-label required fw-bold">Type ID</label>
                                <input type="text" class="form-control" name="Type" id="field_type_id" readonly />
                            </div>

                            <div class="mb-10">
                                <label class="form-label required fw-bold">Type Name</label>
                                <input type="text" class="form-control" name="description" id="field_description" placeholder="Enter type name" required />
                            </div>

                            <div class="mb-8">
                                <label class="form-label required fw-bold">Type Icon</label>
                                <select class="form-select" name="type_text" id="field_icon" data-control="select2" data-placeholder="Select an Icon">
                                    <option></option>
                                </select>
                                <div class="fw-semibold mt-1 text-gray-500">Browse available icons at  <a href="https://preview.keenthemes.com/html/metronic/docs/?page=icons/keenicons#listing" target="_blank" rel="noopener noreferrer" class="fw-semibold">KeenIcons.</a></div>
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

<script src="${pageContext.request.contextPath}/assets/js/custom/icons/keenicons.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var typeData = ${requestScope.info != null ? requestScope.info : 'null'};
        var select = $('#field_icon');
        var data = getIconsForSelect2()
        
        select.select2({
            data: data,
            placeholder: "Select or Search Icon...",
            allowClear: true,
            minimumInputLength: 0,
            escapeMarkup: function(markup) { return markup; }, 
            templateResult: formatIcon,
            templateSelection: formatIcon
        });

        function formatIcon(icon) {
            if (!icon.id) return icon.text;
            return '<span class="d-flex align-items-center">' + 
                   '<i class="' + icon.id + ' fs-2 me-2"></i>' + 
                   '<span>' + icon.text + '</span>' + 
                   '</span>';
        }

        if (typeData) {
            $('#field_type_id').val(typeData.TypeID || '');
            $('#field_description').val(typeData.description || '');
            
            var currentIcon = typeData.typeText || '';
            if(currentIcon) {
                select.val(currentIcon).trigger('change');
                updatePreview(currentIcon);
            }
        }
    });
</script>