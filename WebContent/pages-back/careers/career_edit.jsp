<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>

<fmt:setLocale value="en_US" />

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Career</title>

        <link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
        <script src="assets/plugins/global/plugins.bundle.js"></script>

        <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>

        <style>
            #summernote { width: 100%; margin-left: auto; margin-right: auto; }
            .ckeditor-wrapper { height: auto !important; min-height: 200px; border: 1px solid #d1d5db; border-radius: 6px; padding: 12px; }
            .note-editor.note-frame { margin-bottom: 0 !important; border: none !important; }
            .note-editor:focus-within { border-color: #3b82f6 !important; box-shadow: 0 0 0 3px rgba(59,130,246,.15); }
            .note-toolbar { background: #f9fafb !important; border-bottom: 1px solid #e5e7eb !important; padding: 8px; }
            .note-btn { border-radius: 6px !important; margin-right: 8px; }
            .note-editable { min-height: 300px; padding: 20px; font-size: 14px; line-height: 1.7; color: #111827; }
            
            .form-control[readonly] {
                color: #212529 !important;
                -webkit-text-fill-color: #212529 !important;
                background-color: #f5f8fa;
                opacity: 1 !important;
            }
            
            .form-control.ps-12[readonly] {
                background-color: #ffffff !important;
            }

            /* พอเป็น Dark Mode ให้กลับไปมืดกลมกลืนตามเดิม */
            [data-bs-theme="dark"] .form-control.ps-12[readonly] {
                background-color: #1B1C22 !important;
            }
            

            /* ==========================================
               Dark Mode Styles
               ========================================== */
            
            /* Inputs & Readonly Inputs */
            [data-bs-theme="dark"] .form-control {
                background-color: #1B1C22 !important;
                border-color: #323248 !important;
                color: #92929F !important;
            }
            [data-bs-theme="dark"] .form-control:focus {
                border-color: #474761 !important;
                color: #FFFFFF !important;
            }
            [data-bs-theme="dark"] .form-control[readonly] {
                background-color: #15171C !important;
                color: #565674 !important;
                -webkit-text-fill-color: #565674 !important;
                border-color: #323248 !important;
            }

            /* Summernote Editor Dark Mode */
            [data-bs-theme="dark"] .ckeditor-wrapper {
                border-color: #323248 !important;
            }
            [data-bs-theme="dark"] .note-toolbar {
                background: #15171C !important;
                border-bottom: 1px solid #323248 !important;
            }
            [data-bs-theme="dark"] .note-btn {
                background-color: #1B1C22 !important;
                color: #A1A5B7 !important;
                border-color: #323248 !important;
            }
            [data-bs-theme="dark"] .note-btn:hover {
                background-color: #323248 !important;
                color: #FFFFFF !important;
            }
            
            [data-bs-theme="dark"] .note-editable,
            [data-bs-theme="dark"] .note-editable p,
            [data-bs-theme="dark"] .note-editable span,
            [data-bs-theme="dark"] .note-editable div,
            [data-bs-theme="dark"] .note-editable ul,
            [data-bs-theme="dark"] .note-editable ol,
            [data-bs-theme="dark"] .note-editable li,
            [data-bs-theme="dark"] .note-editable h1,
            [data-bs-theme="dark"] .note-editable h2,
            [data-bs-theme="dark"] .note-editable h3 {
                color: #E4E6EF !important;
                background-color: transparent !important;
            }
            [data-bs-theme="dark"] .note-editable {
                background-color: #1B1C22 !important; 
            }
            [data-bs-theme="dark"] .note-editor:focus-within {
                border-color: #474761 !important;
                box-shadow: 0 0 0 3px rgba(255,255,255,.05);
            }
            [data-bs-theme="dark"] .note-modal-content {
                background-color: #1E1E2D !important;
                color: #A1A5B7 !important;
                border: 1px solid #323248 !important;
            }
            [data-bs-theme="dark"] .note-modal-header {
                border-bottom: 1px solid #323248 !important;
            }
            [data-bs-theme="dark"] .note-dropdown-menu {
                background-color: #1E1E2D !important;
                border-color: #323248 !important;
            }
            [data-bs-theme="dark"] .note-dropdown-item {
                color: #A1A5B7 !important;
            }
            [data-bs-theme="dark"] .note-dropdown-item:hover {
                background-color: #323248 !important;
            }

            /* SweetAlert2 Dark Mode */
            [data-bs-theme="dark"] .swal2-popup {
                background-color: #1E1E2D !important;
                color: #FFFFFF !important;
                border: 1px solid #323248;
            }
            [data-bs-theme="dark"] .swal2-title {
                color: #FFFFFF !important;
            }
            [data-bs-theme="dark"] .swal2-html-container {
                color: #A1A5B7 !important;
            }
        </style>
    </head>
    <body class="app-default">
        <perm:permission object="careers.view">
            <div class="app-main flex-column flex-row-fluid">
                <div class="d-flex flex-column flex-column-fluid">
                    
                    <div class="app-toolbar py-3 py-lg-6">
                        <div class="app-container container-fluid d-flex flex-stack">
                            <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                                <h1 class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">Career Edit</h1>
                                <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                                    <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
                                    <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
                                    <li class="breadcrumb-item text-muted">CMS</li>
                                    <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
                                    <li class="breadcrumb-item text-muted"><a class="text-muted text-hover-primary">Careers</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="app-content flex-column-fluid">
                        <div class="app-container container-fluid">
                            <form id="formEditCareer" action="${pageContext.request.contextPath}/career_saveedit.action" method="POST" class="form" autocomplete="off">
                                
                                <input type="hidden" name="jobId" id="jobId" value="${jobInfo.jobId}">
                                <input type="hidden" name="contentDetail" id="contentDetailInput">
                                <input type="hidden" name="oldPageUriId" id="oldPageUriId" value="${pageUri.pageUriId}" />

                                <div class="card mb-10">
                                    <div class="card-header d-flex align-items-center justify-content-between">
                                        <h3 class="fw-semibold text-gray-900 mb-0">Career Detail</h3>
                                    </div>
                                    <div class="card-body">
                                        <div class="row mb-5">
                                            <div class="col-md-12">
                                                <label class="fw-medium text-gray-800 mb-2">Position Name</label>
                                                <input type="text" class="form-control text-gray-700" placeholder="e.g. Programmer" name="positionName" id="positionName" value="${jobInfo.position}" />
                                                <div class="invalid-feedback fw-bold mt-2">
                                                    This Position Name is already taken.
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row mb-5">
                                            <div class="col-md-6">
                                                <label class="fw-medium text-gray-800 mb-2">Job Ref</label>
                                                <input type="text" class="form-control text-gray-700" placeholder="e.g. 1" name="jobRef" id="jobRef" value="${jobInfo.name}" />
                                            </div>
                                            <div class="col-md-6 mt-5 mt-md-0">
                                                <label class="fw-medium text-gray-800 mb-2">Salary</label>
                                                <input type="text" class="form-control text-gray-700" placeholder="e.g. 15,000 - 30,000 THB" name="salary" id="salary" value="${jobInfo.salaryMin} - ${jobInfo.salaryMax}" />
                                            </div>
                                        </div>
                                        <div class="row mb-5">
                                            <div class="col-12 col-md-6">
                                                <label class="fw-medium text-gray-800 mb-2">Start Date</label>
                                                <div class="position-relative">
                                                    <i class="ki-duotone ki-calendar-8 text-gray-500 position-absolute top-50 translate-middle-y ms-4 fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span></i>
                                                    <input type="text" class="form-control ps-12 text-gray-700" placeholder="Select Start Date" name="startDate" id="startDate" value="${jobInfo.startDate}" />
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="fw-medium text-gray-800 mb-2">End Date</label>
                                                <div class="position-relative">
                                                    <i class="ki-duotone ki-calendar-8 text-gray-500 position-absolute top-50 translate-middle-y ms-4 fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span></i>
                                                    <input type="text" class="form-control ps-12 text-gray-700" placeholder="Select End Date" name="endDate" id="endDate" value="${jobInfo.endDate}" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="card mb-10">
                                    <div class="card-header d-flex align-items-center justify-content-between">
                                        <h3 class="fw-semibold text-gray-900 mb-0">Content Detail</h3>
                                    </div>
                                    <div class="card-body">
                                        <div id="editorError" class="text-danger mb-2 text-center"></div>
                                        <div class="ckeditor-wrapper">
                                            <div id="summernote"></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="card mb-10">
                                    <div class="card-header border-bottom d-flex align-items-center pt-6 pb-6">
                                        <div class="card-title">
                                            <h3 class="fw-semibold text-gray-900 mb-0">Page URL Detail</h3>
                                        </div>
                                    </div>
                                    <div class="card-body p-10">
                                        <div class="row mb-7">
                                            <div class="col-lg-4">
                                                <label class="form-label fw-semibold">Forward to</label>
                                                <input type="text" readonly
														class="form-control text-gray-700"
														placeholder="Forward to" name="forward_to"
														id="forward_to" value="${pageUri.forwardTo}" />
                                                <div class="invalid-feedback d-none" id="forwardToFeedback">This Forward to is already in use.</div>
                                            </div>
                                            <div class="col-lg-4">
                                                <label class="form-label fw-semibold">Model</label>
                                                <input type="text" readonly
														class="form-control text-gray-700"
														placeholder="Model" name="model"
														id="model" value="${pageUri.model}" />
                                            </div>
                                            <div class="col-lg-4">
                                                <label class="form-label fw-semibold">Model ID</label>
                                                <input type="text" readonly
														class="form-control text-gray-700"
														placeholder="Model ID" name="model_id"
														id="model_id" value="${pageUri.modelId}" />
                                            </div>
                                        </div>
                                        <div class="row mb-7">
                                            <div class="col-lg-12">
                                                <label class="required form-label fw-semibold">Page URL</label>
                                                <input type="text" name="pageUriId" id="pageUriId" class="form-control form-control-lg" value="${pageUri.pageUriId}"/>
                                                <div class="invalid-feedback d-none" id="pageUriIdFeedback">This Page URL is already in use.</div>
                                            </div>
                                        </div>
                                        <div class="row mb-7">
                                            <div class="col-lg-12">
                                                <label class="required form-label fw-semibold">Title</label>
                                                <input type="text" name="pageUriTitle" class="form-control form-control-lg" value="${pageUri.pageUriTitle}" />
                                            </div>
                                        </div>
                                        <div class="row mb-7">
                                            <div class="col-lg-12">
                                                <label class="required form-label fw-semibold">Meta</label>
                                                <textarea name="meta" rows="3" class="form-control form-control-lg h-fit-content">${pageUri.meta}</textarea>
                                            </div>
                                        </div>
                                        <div class="row mb-7">
                                            <div class="col-lg-12">
                                                <label class="required form-label fw-semibold">Description</label>
                                                <textarea name="pageUriDescription" rows="5" class="form-control form-control-lg">${pageUri.pageUriDescription}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>    
                                
                                <div class="d-flex justify-content-end border-0 pb-10">
                                    <button type="button" onclick="confirmLeaveForm('careersList')" class="btn btn-lg btn-light fw-medium text-light-inverse px-3 py-4 me-4">Close</button>
                                    <button type="button" class="btn btn-success text-white fw-medium px-3 py-4" onclick="submitForm()">Save Changes</button>
                                </div>
                                
                            </form>
                        </div>
                    </div>

                </div>
            </div>

            <script>
                var existingContent = `${jobInfo.description}`;
            </script>

            <script>
            	    console.log("Data = ${pageUri}");
            	    console.log("Model = ${pageUri.model}");
            	    console.log("ModelId = ${pageUri.modelId}");
            	    console.log("PageUriId = ${pageUri.pageUriId}");
            	    console.log("ForwardTo = ${pageUri.forwardTo}");
	            console.log("Title = ${pageUri.pageUriTitle}");
	            console.log("Meta = ${pageUri.meta}");
	            console.log("Description = ${pageUri.pageUriDescription}");
            
                function initSummernote(content="") {
                    $('#summernote').summernote({
                        placeholder: 'Type here...',
                        minHeight: 250,
                        tabsize: 2,
                        toolbar: [
                        ['style', ['style']],
                        ['font', ['bold', 'italic', 'underline', 'clear']],
                        ['fontname', ['fontname']],
                        ['color', ['color']],
                        ['para', ['ul', 'ol', 'paragraph']],
                        ['insert', ['link', 'picture', 'table']],
                        ['view', ['undo', 'redo', 'fullscreen', 'codeview']]
                        ]
                    });
                    $('#summernote').summernote('code', content);
                }
                
                document.addEventListener("DOMContentLoaded", function () {
                    flatpickr("#startDate", { dateFormat: "Y-m-d", altInput: true, altFormat: "d M Y", locale: "en", allowInput: false });
                    flatpickr("#endDate", { dateFormat: "Y-m-d", altInput: true, altFormat: "d M Y", locale: "en", allowInput: false }); 
                    if (!$('#summernote').next('.note-editor').length) {
                        initSummernote(existingContent);
                    }
                });
                
                function submitForm(){
                    const content = $('#summernote').summernote('code');
                    
                    document.getElementById("contentDetailInput").value = content;
                    var errorFields = [];
                    const form = document.getElementById("formEditCareer");
                    
                    ["positionName", "jobRef", "startDate", "endDate"].forEach(id => {
                        const element = document.getElementById(id);
                        if (element && element.value) { element.value = element.value.trim(); }
                    });
                    
                    if ($('#positionName').hasClass('is-invalid')) {
                        window.scrollTo({ top: 0, behavior: "smooth" });
                        Swal.fire({
                            title: "Duplicate Position!",
                            text: "This Position Name is already taken. Please change it before saving.",
                            icon: "error",
                            confirmButtonText: "OK",
                            customClass: { confirmButton: "btn btn-danger" }
                        });
                        return false;
                    }
                    
                    if(!document.getElementById("positionName").value) errorFields.push("Position Name");
                    if(!document.getElementById("jobRef").value) errorFields.push("Job Ref");
                    if(!document.getElementById("startDate").value) errorFields.push("Start Date");
                    if(!document.getElementById("endDate").value) errorFields.push("End Date");
                    if(!content.replace(/<[^>]*>/g, "").trim()) errorFields.push("Content Detail");
                    
                    if (errorFields.length > 0) {
                        Swal.fire({
                            title: "Incomplete Form",
                            html: "Please fill in: <strong>" + errorFields.join(", ") + "</strong>",
                            icon: "error",
                            confirmButtonText: "OK",
                            customClass: { confirmButton: "btn btn-danger" }
                        });
                        return false;
                    }
                    
                    Swal.fire({
                        title: "Confirm Update",
                        text: "Are you sure you want to save these changes?",
                        icon: "warning",
                        showCancelButton: true,
                        confirmButtonText: "Yes, Update",
                        cancelButtonText: "Cancel",
                        reverseButtons: true,
                        customClass: { confirmButton: "btn btn-success", cancelButton: "btn btn-secondary" }
                    }).then((result) => {
                        if (result.isConfirmed) {
                            form.submit();
                        }
                    });
                }
                
                $(document).ready(function() {
                    let typingTimer;  
                    let doneTypingInterval = 500; 
                    
                    const originalPositionName = "${jobInfo.position}".trim().toLowerCase();

                    $('#positionName').on('input', function () {
                        clearTimeout(typingTimer);
                        let positionName = $(this).val().trim();
                        let inputElement = $(this);

                        if (positionName === '') {
                            inputElement.removeClass('is-invalid is-valid');
                            return;
                        }
                        
                        if (positionName.toLowerCase() === originalPositionName) {
                            inputElement.removeClass('is-invalid').addClass('is-valid');
                            return;
                        }

                        typingTimer = setTimeout(function () {
                            $.ajax({
                                url: 'checkPositionDuplicate',
                                type: 'GET',
                                data: { positionName: positionName },
                                dataType: 'json',
                                success: function (data) {
                                    if (data.isDuplicate) {
                                        inputElement.removeClass('is-valid').addClass('is-invalid');
                                    } else {
                                        inputElement.removeClass('is-invalid').addClass('is-valid');
                                    }
                                },
                                error: function (xhr, status, error) {
                                    console.error("AJAX Error:", error);
                                }
                            });
                        }, doneTypingInterval);
                    });
                });
            
                function confirmLeaveForm(redirectUrl){
                    Swal.fire({
                        title: "Discard Changes?",
                        text: "Closing will discard any unsaved edits.",
                        icon: "warning",
                        showCancelButton: true,
                        confirmButtonText: "Yes, discard",
                        cancelButtonText: "Cancel",
                        reverseButtons: true,
                        customClass: { confirmButton: "btn btn-danger", cancelButton: "btn btn-secondary" }
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = "careers_list";
                        }
                    });
                }
            </script>
        </perm:permission>
    </body>
</html>