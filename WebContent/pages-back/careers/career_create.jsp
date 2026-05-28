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
    <title>New Career</title>

    <link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
    <script src="assets/plugins/global/plugins.bundle.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>

    <style>
            #summernote { width: 100%; margin-left: auto; margin-right: auto; }
            .ckeditor-wrapper { border: 1px solid #d1d5db; border-radius: 6px; overflow: hidden; min-height: auto; padding: 14px; }
            
            .note-editor { border: 1px solid #d1d5db !important; border-radius: 10px !important; overflow: hidden; transition: all 0.2s ease; background: #fff; }
            .note-editor:focus-within { border-color: #3b82f6 !important; box-shadow: 0 0 0 3px rgba(59,130,246,.15); }
            .note-toolbar { background: #f9fafb !important; border-bottom: 1px solid #e5e7eb !important; padding: 8px; }
            .note-btn { border-radius: 6px !important; transition: all .15s ease; margin-right: 8px; } 
            .note-btn:hover { background: #e5e7eb !important; } 
            .note-editable blockquote { border-left: 5px solid #f1416c !important; padding: 15px 20px !important; margin: 20px 0 !important; color: #3f4254 !important; }
            .note-editable pre { background-color: #f1f1f2 !important; border: 1px solid #e1e3ea !important; border-radius: 8px !important; padding: 15px !important; margin: 20px 0 !important; font-size: 13px !important; color: #181c32 !important; line-height: 1.5 !important; overflow-x: auto !important; }
            .note-editing-area { background: #ffffff; }
            .note-editable { min-height: 300px; padding: 20px; font-size: 14px; line-height: 1.7; color: #111827; font-family: system-ui, sans-serif; }
            .note-placeholder { color: #9ca3af !important; }
            .note-editable::-webkit-scrollbar { width: 8px; }
            .note-editable::-webkit-scrollbar-thumb { background: #cbd5f5; border-radius: 6px; }
            .note-editor.note-frame.fullscreen { background: white; padding: 15px; }
            .note-editable h1 { font-size: 30px; margin: 16px 0; }
            .note-editable h2 { font-size: 24px; margin: 14px 0; }
            .note-editable h3 { font-size: 20px; margin: 12px 0; }
            .note-btn.dropdown-toggle::after { display: none !important; } 
            .note-toolbar .note-btn { margin-right: 0 !important; }
            .note-toolbar .note-btn-group { margin-right: 10px !important; }
            .note-toolbar .note-btn-group .note-btn { border-radius: 6px !important; }
            .note-modal .note-modal-footer { display: flex !important; align-items: center !important; justify-content: flex-end !important; padding: 1rem !important; height: auto !important; min-height: 60px !important; }
            .note-modal .note-modal-footer .note-btn { float: none !important; margin: 0 10px !important; position: static !important; }
            .note-modal-content { border: none !important; border-radius: 12px !important; box-shadow: 0 15px 50px rgba(0,0,0,0.2) !important; overflow: hidden !important; }
            .note-modal-header { border-bottom: 1px solid #eee !important; padding: 15px 20px !important; }
            .note-modal-title { font-size: 1.2rem !important; font-weight: 600 !important; color: #111827 !important; }
            .note-dropdown-menu { width: 350px !important; }
            .note-palette { margin: 2px 0; }
            
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
               Dark Mode
               ========================================== */
           
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

            /* Summernote Wrappers & Editor */
            [data-bs-theme="dark"] .ckeditor-wrapper {
                border-color: #323248 !important;
            }
            [data-bs-theme="dark"] .note-editor {
                border-color: #323248 !important;
                background: #1B1C22 !important;
            }
            [data-bs-theme="dark"] .note-editor:focus-within {
                border-color: #474761 !important;
                box-shadow: 0 0 0 3px rgba(255,255,255,.05) !important;
            }
            [data-bs-theme="dark"] .note-editor.note-frame.fullscreen {
                background: #15171C !important;
            }

            /* Summernote Toolbar & Buttons */
            [data-bs-theme="dark"] .note-toolbar {
                background: #15171C !important;
                border-bottom: 1px solid #323248 !important;
            }
            [data-bs-theme="dark"] .note-btn {
                background-color: transparent !important;
                color: #A1A5B7 !important;
            }
            [data-bs-theme="dark"] .note-btn:hover {
                background-color: #323248 !important;
                color: #FFFFFF !important;
            }

            /* Summernote Editable Area & Typography */
            [data-bs-theme="dark"] .note-editing-area {
                background: #1B1C22 !important;
            }
            [data-bs-theme="dark"] .note-editable {
                background-color: #1B1C22 !important;
            }
            [data-bs-theme="dark"] .note-placeholder {
                color: #565674 !important;
            }
            [data-bs-theme="dark"] .note-editable::-webkit-scrollbar-thumb {
                background: #323248 !important;
            }
            
            /* Overriding Hardcoded Colors inside Editor */
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

            /* Custom Typography (Blockquote & Pre) */
            [data-bs-theme="dark"] .note-editable blockquote {
                color: #A1A5B7 !important;
            }
            [data-bs-theme="dark"] .note-editable pre {
                background-color: #15171C !important;
                border-color: #323248 !important;
                color: #A1A5B7 !important;
            }

            /* Summernote Modals & Dropdowns */
            [data-bs-theme="dark"] .note-modal-content {
                background-color: #1E1E2D !important;
                color: #A1A5B7 !important;
                border: 1px solid #323248 !important;
                box-shadow: 0 15px 50px rgba(0,0,0,0.5) !important;
            }
            [data-bs-theme="dark"] .note-modal-header {
                border-bottom: 1px solid #323248 !important;
            }
            [data-bs-theme="dark"] .note-modal-title {
                color: #FFFFFF !important;
            }
            [data-bs-theme="dark"] .note-dropdown-menu {
                background-color: #1E1E2D !important;
                border: 1px solid #323248 !important;
            }
            [data-bs-theme="dark"] .note-dropdown-item {
                color: #A1A5B7 !important;
            }
            [data-bs-theme="dark"] .note-dropdown-item:hover {
                background-color: #323248 !important;
                color: #FFFFFF !important;
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
                        <h1 class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">New Career</h1>
                        <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                            <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
                            <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
                            <li class="breadcrumb-item text-muted"><a class="text-muted text-hover-primary">CMS</a></li>
                            <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
                            <li class="breadcrumb-item text-muted"><a class="text-muted text-hover-primary">Careers</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="app-content flex-column-fluid">
                <div class="app-container container-fluid">
                    <form id="formAddCareer" action="career_savecreate" method="POST" class="form" autocomplete="off">
                        
                        <div class="card mb-10">
                            <div class="card-header d-flex align-items-center justify-content-between">
                                <h3 class="fw-semibold text-gray-900 mb-0">Career Detail</h3>
                            </div>

                            <div class="card-body">
                                <div class="row mb-5">
                                    <div class="col-md-12">
                                        <label class="required fw-medium text-gray-800 mb-2">Position Name</label>
                                        <input type="text" class="form-control text-gray-700" placeholder="e.g. Programmer" name="positionName" id="positionName" value="" />
                                        <div class="invalid-feedback fw-bold mt-2">
                                            This Position Name is already taken.
                                        </div>
                                    </div>
                                    
                                </div>

                                <div class="row mb-5">
                                    <div class="col-md-6">
                                        <label class="required fw-medium text-gray-800 mb-2">Job Ref</label>
                                        <input type="text" class="form-control text-gray-700" placeholder="e.g. 1" name="jobRef" id="jobRef" value="" />
                                    </div>
                                    <div class="col-md-6 mt-5 mt-md-0">
                                        <label class="fw-medium text-gray-800 mb-2">Salary</label>
                                        <input type="text" class="form-control text-gray-700" placeholder="e.g. 15,000 - 30,000 THB" name="salary" id="salary" value="" />
                                    </div>
                                </div>

                                <div class="row mb-5">
                                    <div class="col-12 col-md-6">
                                        <label class="required fw-medium text-gray-800 mb-2">Start Date</label>
                                        <div class="position-relative bg-white">
                                            <i class="ki-duotone ki-calendar-8 text-gray-500 position-absolute top-50 translate-middle-y ms-4 fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span></i> 
                                            <input type="text" class="form-control ps-12 text-gray-700" placeholder="Select Start Date" name="startDate" id="startDate" value="" />
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <label class="required fw-medium text-gray-800 mb-2">End Date</label>
                                        <div class="position-relative">
                                            <i class="ki-duotone ki-calendar-8 text-gray-500 position-absolute top-50 translate-middle-y ms-4 fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span></i> 
                                            <input type="text" class="form-control ps-12 text-gray-700" placeholder="Select End Date" name="endDate" id="endDate" value="" />
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
                            <input type="hidden" name="contentDetail" id="contentDetailInput">
                        </div>

                        <div class="d-flex justify-content-end border-0 pb-10">
                            <button type="button" onclick="confirmLeaveForm('careersList')" class="btn btn-md btn-light fw-medium text-light-inverse px-3 py-4 me-3">Cancel</button>
                            <button type="button" class="btn btn-md btn-success text-white fw-medium px-3 py-4" onclick="submitForm()">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function initSummernote(content="") {
            $('#summernote').summernote({
                placeholder: 'Type here...',
                tabsize: 2,
                codeviewFilter: false,
                codeviewIframeFilter: false,
                toolbar: [
                    ['style', ['style']],
                    ['font', ['bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript', 'clear']],
                    ['fontname', ['fontname']],
                    ['fontsize', ['fontsize']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph', 'height']],
                    ['insert', ['link', 'picture', 'video', 'table', 'hr']],
                    ['view', ['undo', 'redo', 'fullscreen', 'codeview', 'help']]
                ],
                callbacks : {
                    onImageUpload : function(files) {
                        for (var i = files.length - 1; i >= 0; i--) {
                            sendFile(files[i], this);
                        }
                    },
                    onMediaDelete : function(target) {
                        deleteFile(target[0].src);
                    }
                }
            });
            $('#summernote').summernote('code', content);
        }
    
        function sendFile(file, el) {
            const errorBox = document.getElementById("editorError");

            if(file.size > 2 * 1024 * 1024){
                errorBox.textContent = "Image must be smaller than 2MB. Please select a new image.";
                return false;
            }

            errorBox.textContent = "";
            var form_data = new FormData();
            form_data.append('careerImageFile', file);
            
            $.ajax({
                data : form_data,
                type : "POST",
                url : 'addImgFormEditor',
                cache : false,
                contentType : false,
                processData : false,
                success : function(url) {
                    $('#summernote').summernote('editor.insertImage', url);
                },
                error : function(data) {
                    console.log("Error upload image inside editor");
                }
            });
        }

        function deleteFile(src) {
            $.ajax({
                data : "srcDelete=" + src,
                type : "POST",
                url : "DeleteImgFormEditor",
                cache : false
            });
        }
    </script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            flatpickr("#startDate", {
                dateFormat: "Y-m-d",  
                altInput: true,
                altFormat: "d M Y",   
                locale: "en",        
                allowInput: false,
                defaultDate: new Date()
            });
            
            flatpickr("#endDate", {
                dateFormat: "Y-m-d",  
                altInput: true,
                altFormat: "d M Y",   
                locale: "en",        
                allowInput: false,
                defaultDate: new Date(new Date().getTime() + 30*24*60*60*1000)
            });
                    
            if (!$('#summernote').next('.note-editor').length) {
                initSummernote();
            }
        });
    </script>

    <script>
        function submitForm(){
            const content = $('#summernote').summernote('code');
            const errorBox = document.getElementById("editorError");
            const editorError = errorBox.textContent.trim();
            
            document.getElementById("contentDetailInput").value = content;
            var errorFields = [];
            const form = document.getElementById("formAddCareer");
            
            ["positionName", "jobRef", "startDate", "endDate"].forEach(id => {
                const element = document.getElementById(id);
                if (element && element.value) {
                    element.value = element.value.trim();
                }
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
              
            const positionName = document.getElementById("positionName").value;
            const jobRef = document.getElementById("jobRef").value;
            const startDate = document.getElementById("startDate").value;
            const endDate = document.getElementById("endDate").value;
            const salary = document.getElementById("salary").value;
            const contentText = content.replace(/<[^>]*>/g, "").trim();
              
            if(!positionName) errorFields.push("Position Name");
            if(!jobRef) {
                errorFields.push("Job Ref");
            } else if (isNaN(jobRef)) {
                Swal.fire({
                    title: "Invalid Input!",
                    text: "Job Ref must be a numeric value only (e.g. 1, 2, 10)",
                    icon: "error",
                    confirmButtonText: "OK"
                });
                return false;
            }
            if(!startDate) errorFields.push("Start Date");
            if(!endDate) errorFields.push("End Date");
            if(!contentText) errorFields.push("Job Description (Content Detail)");
              
            if (errorFields.length > 0) {
                window.scrollTo({ top: 0, behavior: "smooth" });
                document.activeElement.blur();
                
                Swal.fire({
                    title: "Please complete the form!",
                    html: "Please fill in the following fields:<br><strong>" + errorFields.join(", ") + "</strong>",
                    icon: "error",
                    confirmButtonText: "OK",
                    buttonsStyling: false,
                    customClass: { confirmButton: "btn btn-danger" }
                });
                return false;
            } 
              
            if(editorError){
                errorBox.scrollIntoView({ behavior: "smooth", block: "center" });
                return false; 
            }
              
            Swal.fire({
                title: "Are you sure?!",
                text: "Do you want to save this job position?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Save",
                cancelButtonText: "Close",
                reverseButtons: true,
                buttonsStyling: false,
                customClass: { confirmButton: "btn btn-success", cancelButton: "btn btn-secondary" }
            }).then((result) => {
                if (result.isConfirmed) {                   
	               form.submit();
                }
            });
          return false;
        }
        
        $(document).ready(function() {
            let typingTimer;              
            let doneTypingInterval = 500;  

            $('#positionName').on('input', function () {
                clearTimeout(typingTimer);
                let positionName = $(this).val().trim();
                let inputElement = $(this);

                if (positionName === '') {
                    inputElement.removeClass('is-invalid is-valid');
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
                title: "Are you sure?!",
                text: "Closing will discard any unsaved data.",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Yes, discard it",
                cancelButtonText: "Cancel",
                reverseButtons: true,
                buttonsStyling: false,
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