<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<fmt:setLocale value="en_US" scope="page" />

<link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet"
	type="text/css" />
<script src="assets/plugins/global/plugins.bundle.js"></script>


<!--CKEditor-->
<script src="assets/plugins/custom/ckeditor/ckeditor-decoupled.bundle.js"></script>
<script src="assets/plugins/custom/ckeditor/ckeditor-document.bundle.js"></script>

<!-- <script src="assets/plugins/custom/ckeditor/ckeditor-classic.bundle.js"></script> -->

<!DOCTYPE html>
<!--begin::Image input placeholder-->
<style>
.image-input-placeholder {
	background-image: url('svg/avatars/blank.svg');
}

[data-bs-theme="dark"] .image-input-placeholder {
	background-image: url('svg/avatars/blank-dark.svg');
}
#kt_docs_ckeditor_document  {
	width: 100%;
	margin-left: auto;
	margin-right: auto;
}

#kt_docs_ckeditor_document  {
	border: 1px solid #d1d5db;
	border-radius: 6px;
	overflow: hidden;
	min-height: 500px;
	padding: 12px;
}
</style>
<!--end::Image input placeholder-->
<div class="app-main flex-column flex-row-fluid">
	<div class="d-flex flex-column flex-column-fluid">
		<div class="app-toolbar align-items-stretch py-5 py-lg-6">
			<div class="app-container container-fluid d-flex flex-stack">
				<div
					class="d-flex align-items-center justify-content-between flex-lg-grow-1">
					<div class="d-flex align-items-center">
						<div
							class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
							<h1
								class="page-heading d-flex text-gray-700 fw-semibold fs-3 flex-column justify-content-center my-0">
								<c:choose>
									<c:when test="${not empty announcement}">
            							Edit Announcement
        							</c:when>
									<c:otherwise>
            							Add Announcement
        							</c:otherwise>
								</c:choose>
							</h1>
							<ul
								class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
								<!--begin::Item-->
								<li class="breadcrumb-item text-muted"><a
									href="demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
								<!--end::Item-->
								<!--begin::Item-->
								<li class="breadcrumb-item"><span
									class="bullet bg-gray-500 w-5px h-2px"></span></li>
								<!--end::Item-->
								<!--begin::Item-->
								<li class="breadcrumb-item text-muted">Announcement</li>
								<!--end::Item-->
							</ul>
						</div>
					</div>
					<c:if test="${not empty announcement}">
					<a
						class="btn btn-danger btn-flex h-40px border-0 fw-bold px-4 px-lg-6"
						href="javascript:;"
						onclick="confirmDelete('${announcement.announcementId}')"> <i
						class="ki-duotone ki-trash fs-2 me-2"> <span class="path1"></span>
							<span class="path2"></span> <span class="path3"></span> <span
							class="path4"></span> <span class="path5"></span>
					</i> Delete
					</a>
					</c:if>
				</div>
			</div>
		</div>
		<div class="app-content flex-column-fluid">
			<div class="app-container container-fluid">
				<form autocomplete="off" action="announcementAdd" method="POST"
					id="formid" class="horizontal-form" enctype="multipart/form-data">
					<c:if test="${not empty announcement}">
					    <input type="hidden"
					           id="detailHidden"
					           value="<c:out value='${announcement.detail}' escapeXml='true'/>">
					</c:if>
					
					<input type="hidden" name="detail" id="detailInput">
					<div class="row g-5 gx-xl-10">
						<div
							class="col-md-12 col-lg-7 col-xl-7 col-xxl-8 mb-md-5 mb-xl-10">
							<div class="card card-flush py-3">
								<div class="card-header pt-5">
									<h3 class="card-title fw-semibold text-gray-900">Announcement</h3>
									<div class="card-toolbar">
										<div
											class="form-check form-switch form-check-custom form-check-primary form-check-solid me-7">
											<span class="fs-6 fw-medium text-gray-700">Highlight&nbsp;&nbsp;</span>
											<input class="form-check-input h-20px w-35px" type="checkbox"
												name="highlight" value="1" checked id="highlight" />
										</div>

										<div
											class="form-check form-switch form-check-custom form-check-success form-check-solid">
											<span class="fs-6 fw-medium text-gray-700">Active&nbsp;&nbsp;</span><input
												class="form-check-input  h-20px w-35px" type="checkbox"
												name="status" value="1" checked id="status" />
										</div>
									</div>
								</div>
								<!-- Hidden ID สำหรับ Edit -->
								<c:if test="${not empty announcement}">
									<input type="hidden" name="announcementId"
										value="${announcement.announcementId}" />
								</c:if>
								<div class="card-body pt-10">
									<div class="mb-5">
										<label class="form-label required form-label">Topic</label> <input
											type="text" class="form-control fw-medium text-gray-700"
											placeholder="Enter topic" name="topic" id="topic">
									</div>
									<div class="mb-10">
										<label class="form-label required form-label">Announcement
											Date</label>
										<div class="input-group" id="kt_td_picker_basic"
											data-td-target-input="nearest"
											data-td-target-toggle="nearest">
											<span class="input-group-text"
												data-td-target="#kt_td_picker_basic"
												data-td-toggle="datetimepicker"> <i
												class="ki-duotone ki-calendar-8 fs-2"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span> <span class="path4"></span> <span
													class="path5"></span> <span class="path6"></span>
											</i>
											</span> <input id="kt_td_picker_basic_input" type="text" placeholder="1 Jan 2026"
												name="anndate" class="form-control fw-medium text-gray-700"
												data-td-target="#kt_td_picker_basic" />
										</div>
									</div>
									<div class="mb-5 ckeditor-wrapper">
									<div id="editor">
										<div id="kt_docs_ckeditor_document_toolbar"></div>
										<div id="kt_docs_ckeditor_document"></div>
										<!-- <textarea id="kt_docs_ckeditor_classic" name="detail"></textarea> -->
									</div>
								</div>
							</div>
						</div>
							</div>
						<div
							class="col-md-12 col-lg-5 col-xl-5 col-xxl-4 mb-md-5 mb-xl-10">
							<div class="card card-flush py-3 mb-5 mb-xl-10">
								<div class="card-header pt-5 flex-column align-items-start">
									<h3 class="card-title fw-semibold text-gray-900 mb-1">Cover
										Photo</h3>
									<span class="fw-semibold fs-6 text-danger">Not shown in
										details</span>
								</div>
								<div id="errorMsg" class="text-center text-danger"></div>
								<div class="card-body pt-6 text-center">
									<!--begin::Image input-->
									<div class="image-input image-input-outline"
										data-kt-image-input="true"
										style="background-image: url(/assets/media/svg/avatars/blank.svg)">
										<!--begin::Image preview wrapper-->
										<c:if test="${not empty announcement}">
											<div class="image-input-wrapper w-250px h-250px"
												style="background-image: url('${pageContext.request.contextPath}${not empty announcement.fileUpload.path ? announcement.fileUpload.path : '/assets/media/svg/avatars/blank.svg'}'); 
            									background-size: cover; 
            									background-position: top;">
											</div>

										</c:if>
										<c:if test="${empty announcement}">
											<div class="image-input-wrapper w-250px h-250px"
												style="background-image: url(/assets/media/svg/avatars/blank.svg)">
											</div>
										</c:if>
										<!--end::Image preview wrapper-->

										<!--begin::Edit button-->
										<label
											class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow"
											data-kt-image-input-action="change" data-bs-toggle="tooltip"
											data-bs-dismiss="click" title="Change avatar"> <i
											class="ki-duotone ki-pencil fs-6"><span class="path1"></span><span
												class="path2"></span></i> <!--begin::Inputs--> <input id="imageInputFile"
											type="file" name="fileUpload" accept=".png, .jpg, .jpeg" />
											<input type="hidden" name="avatar_remove" /> <!--end::Inputs-->
										</label>
										<!--end::Edit button-->

										<!--begin::Cancel button-->
										<span
											class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow"
											data-kt-image-input-action="cancel" data-bs-toggle="tooltip"
											data-bs-dismiss="click" title="Cancel avatar"> <i
											class="ki-outline ki-cross fs-3"></i>
										</span>
										<!--end::Cancel button-->

										<!--begin::Remove button-->
										<c:if test="${not empty announcement}">
											<span
												class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow"
												data-kt-image-input-action="remove" data-bs-toggle="tooltip"
												data-bs-dismiss="click" title="Remove avatar"> <i
												class="ki-outline ki-cross fs-3"></i>
											</span>
										</c:if>
										<!--end::Remove button-->
									</div>
									<!--end::Image input-->
								</div>
								<div class="card-footer pt-0">
									<span class="d-block fw-medium text-muted text-center">Allowed
										file types: png, jpg, jpeg.</span>
								</div>
							</div>
							<div class="card card-flush py-3">
								<div class="card-header pt-5">
									<div
										class="border border-2 border-warning rounded border-active active w-100">
										<div class="py-5 d-flex flex-column align-items-center">
											<div
												class="fs-3 fw-bold text-warning d-flex justify-content-center align-items-center gap-2 mb-5">
												<i class="ki-duotone ki-information-2 fs-3x text-warning">
													<span class="path1"></span> <span class="path2"></span> <span
													class="path3"></span>
												</i> Attach files
											</div>
											<div
												class="d-flex justify-content-center align-items-center text-center fw-medium fs-7 mb-5 text-gray-800">Only
												English filenames are accepted.</div>
											<div
												class="d-flex justify-content-center align-items-center text-center fw-medium fs-7 text-muted">
												Files with Thai or special characters may<br> not open
												correctly after upload.
											</div>
										</div>
									</div>
								</div>
								<div class="card-body pt-6">
									<div class="py-5 d-flex flex-column">
										<label
											class="btn btn-primary btn-flex h-40px border-0 fw-medium w-100 d-flex justify-content-center align-items-center text-center mx-auto"
											id="lbFile" for="myFile" style="height: 44px;">
											Upload File <input type="file" id="myFile" name="files"
											multiple style="display: none;"
											accept=".pdf, .doc, .docx, .xlsx, .pptx, .csv, .png, .jpg, .jpeg, .gif, .webp, .mp4" />
											<input type="hidden" name="filesUploadFileName"
											id="filesUploadFileName" /> <input type="hidden"
											name="fileUploadId" id="fileUploadId" />
										</label>

										<div id="oldFileList" class="d-flex flex-column mt-3 gap-2"></div>

										<div id="newFileList" class="d-flex flex-column mt-3 gap-2"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
				<div class="text-end">
					<a href="announcementList" class="btn btn-light fw-medium"
						onclick="confirmClose()">Close</a> <a href="announcementList"
						class="btn btn-success fw-medium" onclick="confirmButton()">Save</a>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
    <!-- CKEditor -->
	var editorInstance;
	DecoupledEditor
	.create(document.querySelector('#kt_docs_ckeditor_document'), {
		 ckfinder: { uploadUrl: 'uploadImageFromCkeditor' },
	     mediaEmbed: { previewsInData: true }
	})
	.then(editor => {
	    editorInstance = editor;

	    const toolbarContainer = document.querySelector('#kt_docs_ckeditor_document_toolbar');
	    toolbarContainer.appendChild(editor.ui.view.toolbar.element);

	    var hidden = document.getElementById("detailHidden");
	    if (hidden && hidden.value) {
	        editor.setData(hidden.value);
	    }
	})
	.catch(error => {
	    console.error(error);
	});
    /* let editorInstance;
    ClassicEditor
    .create(document.querySelector('#kt_docs_ckeditor_classic'),{
        ckfinder: { uploadUrl: 'uploadImageFromCkeditor' },
        mediaEmbed: { previewsInData: true }
    })
    .then(editor => {
        editorInstance = editor;
        <c:if test="${not empty announcement}">
            editor.setData(`<c:out value='${announcement.detail}' escapeXml='false'/>`);
        </c:if>
    })
    .catch(error => { console.error(error); }); */


    <!-- File Upload -->
    var selectedFiles = []; 

    function getFileIconPath(fileName) {
        var ext = fileName.split('.').pop().toLowerCase();
        switch (ext) {
            case 'pdf': return 'assets/media/svg/files/pdf.svg';
            case 'doc': case 'docx': return 'assets/media/svg/files/doc.svg';
            default: return 'assets/media/svg/files/folder-document.svg';
        }
    }

    document.getElementById('myFile').addEventListener('change', function(event) {
        var fileListInput = event.target.files;
        for (let i = 0; i < fileListInput.length; i++) {
            const file = fileListInput[i];
            const existing = selectedFiles.find(f => f.name === file.name && f.size === file.size);
            if (!existing) {
                selectedFiles.push(file);
            }
        }
        
        renderNewFileList();
        updateInputFiles();
    });

    function renderNewFileList() {
    	var fileListDiv = document.getElementById('newFileList');
    	fileListDiv.innerHTML = "";
        fileListDiv.innerHTML = ""; 

        fileListDiv.style.display = "flex";
        fileListDiv.style.flexDirection = "column"; 

        if (selectedFiles.length > 0) {
            selectedFiles.forEach(file => {
                const fileName = file.name;
                const lastDotIndex = fileName.lastIndexOf('.');
                const nameOnly = fileName.substring(0, lastDotIndex);
                const fileExt = fileName.substring(lastDotIndex); // .pdf
                const iconPath = getFileIconPath(fileName);

                const outerDiv = document.createElement('div');
                outerDiv.className = 'd-flex align-items-center justify-content-center mb-2';

                outerDiv.innerHTML = `
                    <div class="d-flex align-items-center justify-content-between w-100 p-2 rounded">
                        <div class="d-flex align-items-center text-decoration-none text-gray-800" style="flex-grow: 1;">
                            <img src="` + iconPath + `" class="w-25px h-25px me-3" alt="icon" />
                            <span class="fs-6 fw-medium">
                                ` + nameOnly + `
                                <span class="text-gray-800 fw-medium ms-1">` + fileExt + `</span>
                            </span>
                        </div>
                        
                        <span class="badge badge-light-danger bg-hover cursor-pointer delete-btn ms-3">
                            <i class="ki-duotone ki-trash text-danger fs-2">
                                <span class="path1"></span><span class="path2"></span>
                                <span class="path3"></span><span class="path4"></span><span class="path5"></span>
                            </i>
                        </span>
                    </div>
                `;

                outerDiv.querySelector('.delete-btn').addEventListener('click', function() {
                    selectedFiles = selectedFiles.filter(f => f.name !== fileName);
                    renderNewFileList(); 
                    updateInputFiles(); 
                });

                fileListDiv.appendChild(outerDiv);
            });
        }
    }

    function updateInputFiles() {
        var inputFile = document.getElementById("myFile");
        var dataTransfer = new DataTransfer();
        selectedFiles.forEach(file => dataTransfer.items.add(file));
        inputFile.files = dataTransfer.files;
    }


    <!-- save and close -->
    function confirmButton() {
        event.preventDefault();

        var topic = document.querySelector("input[name='topic']").value.trim();
        var annDate = document.querySelector("input[name='anndate']").value.trim();
        /* var detail = editorInstance.getData().trim(); */
        const detail = editorInstance.getData();
	    document.getElementById("detailInput").value = detail;
	    const errorMsg = document.getElementById("errorMsg");
		  if (errorMsg && errorMsg.textContent.trim() !== "") {
			  window.scrollTo({
			        top: 0,
			        behavior: "smooth"
			    });
			  return false; 
		  }

        var errorFields = [];
        if (!topic) {
            errorFields.push("Topic");
            document.querySelector("input[name='topic']").classList.add("is-invalid");
        } else {
            document.querySelector("input[name='topic']").classList.remove("is-invalid");
        }

        if (!annDate) {
            errorFields.push("Announcement Date");
            document.querySelector("input[name='anndate']").classList.add("is-invalid");
        } else {
            document.querySelector("input[name='anndate']").classList.remove("is-invalid");
        }

        if (errorFields.length > 0) {
            Swal.fire({
                title: "Please complete the form!",
                html: "Please fill in the following fields:<br><strong>"
    	            + errorFields.join(", ") + "</strong>",
                icon: "error",
                confirmButtonColor: "#d33",
                confirmButtonText: "OK",
                buttonsStyling: false,
                customClass: { confirmButton: "btn btn-danger" }
            });
            return;
        }

        Swal.fire({
            title: "Are you sure?!",
            text: "Do you want to save the changes?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Save",
            customClass: { confirmButton: "btn btn-success", cancelButton: "btn btn-secondary" },
            buttonsStyling: false
        }).then((result) => {
            if (result.isConfirmed) {
                updateInputFiles();

                var fileNames = selectedFiles.map(file => file.name);
                document.getElementById("filesUploadFileName").value = JSON.stringify(fileNames);
                
                var fileUploadIdEl = document.getElementById("fileUploadId");
                if (!fileUploadIdEl.value || fileUploadIdEl.value.trim() === "") {
                    fileUploadIdEl.value = "[]";
                }

                var form = document.getElementById("formid");
                
                var idInput = document.querySelector("input[name='announcementId']");
                if (idInput && idInput.value.trim() !== "") {
                    form.action = "announcementUpdate";
                } else {
                    form.action = "announcementAdd";
                }
                form.submit();
            }
        });
    }

    function confirmClose() {
        event.preventDefault();

        var announcementId = "${announcement.announcementId}";

        Swal.fire({
            title: "Are you sure?",
            text: "Closing will discard any unsaved data.",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Yes, discard it",
            cancelButtonText: "Cancel",
            buttonsStyling: false,
            customClass: {
                confirmButton: "btn btn-danger",
                cancelButton: "btn btn-secondary"
            }
        }).then((result) => {
            if (result.isConfirmed) {
                if (announcementId && announcementId.trim() !== "") {
                    window.location.href = 'announcementRead?id=' + announcementId;
                } else {
                    window.location.href = 'announcementList';
                }
            }
        });
    }
    
   function confirmDelete(id) {
        event.preventDefault();

        Swal.fire({
            title: "Are you sure?",
            text: "You won't be able to revert this!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Yes, delete it!",
            cancelButtonText: "Cancel",
            buttonsStyling: false,
            customClass: {
                confirmButton: "btn btn-danger",
                cancelButton: "btn btn-secondary"
            }
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = 'announcementDelete?id=' + id;
            }
        });
    }
</script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const pickerElement = document.getElementById("kt_td_picker_basic");
    const picker = new tempusDominus.TempusDominus(pickerElement, {
        display: { components: { clock: false } },
        localization: { locale: 'en', format: "dd MMM yyyy" }
    });

    <c:if test="${not empty announcement}">
        const dateStr = "<fmt:formatDate value='${announcement.announcement_date}' pattern='yyyy-MM-dd'/>";
        const dateObj = new Date(dateStr);
        picker.dates.setValue(tempusDominus.DateTime.convert(dateObj));
    </c:if>
    
    
    const imageInput = document.getElementById("imageInputFile");
	
    imageInput.addEventListener("change", function () {

        const file = this.files[0];
        const maxSize = 2 * 1024 * 1024;
        const errorMsg = document.getElementById("errorMsg");

        if (!file) return;

        if (file.size > maxSize) {

            errorMsg.textContent = "Image must be smaller than 2MB.";
            this.value = "";
        } else {
            errorMsg.textContent = "";
        }

    });
});
</script>

<c:if test="${not empty announcement}">
	<script>
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById("topic").value = "${announcement.topic}";
    document.getElementById("kt_td_picker_basic_input").value = "<fmt:formatDate value='${announcement.announcement_date}' pattern='dd MMM yyyy'/>";
    document.getElementById("status").checked = ${announcement.status == '1' ? 'true' : 'false'};
    document.getElementById("highlight").checked = ${announcement.highlight == '1' ? 'true' : 'false'};

    const oldFileListDiv = document.getElementById("oldFileList");
    
    if(oldFileListDiv) {
        oldFileListDiv.style.display = "flex";
        oldFileListDiv.style.flexDirection = "column";
    }

    var deletedFileIds = [];

    function getFileIconPathLocal(fileName) {
        var ext = fileName.split('.').pop().toLowerCase();
        switch (ext) {
            case 'pdf': return 'assets/media/svg/files/pdf.svg';
            case 'doc': case 'docx': return 'assets/media/svg/files/doc.svg';
            default: return 'assets/media/svg/files/folder-document.svg';
        }
    }

    <c:forEach var="file" items="${announcementFiles}">
        <c:if test="${file.pageId == announcement.announcementId}">
            (function(){
                const fileId = "${file.fileId}";
                const fileName = "${file.name}";
                const fileType = "${file.type}";
                const fullFileName = fileName + fileType;
                const filePath = "${file.path}";
                
                const iconPath = getFileIconPathLocal(fullFileName);

                const outerDiv = document.createElement('div');
                outerDiv.className = 'd-flex align-items-center justify-content-center mb-2';

                outerDiv.innerHTML = `
                    <div class="d-flex align-items-center justify-content-between w-100 p-2 rounded bg-hover-light">
                        <a href="` + filePath + `" target="_blank" class="d-flex align-items-center text-decoration-none text-gray-800" style="flex-grow: 1;">
                            <img src="` + iconPath + `" class="w-25px h-25px me-3" alt="icon" />
                            <span class="fs-6 fw-medium text-gray-800">
                                ` + fileName + `
                                <span class="ms-1">` + fileType + `</span>
                            </span>
                        </a>

                        <span class="badge badge-light-danger cursor-pointer delete-old-file ms-3">
                            <i class="ki-duotone ki-trash text-danger fs-2">
                                <span class="path1"></span><span class="path2"></span>
                                <span class="path3"></span><span class="path4"></span><span class="path5"></span>
                            </i>
                        </span>
                    </div>
                `;

                outerDiv.querySelector('.delete-old-file').onclick = function() {
                    outerDiv.remove();
                    deletedFileIds.push(fileId);
                    document.getElementById("fileUploadId").value = JSON.stringify(deletedFileIds);
                };

                if (oldFileListDiv) {
                    oldFileListDiv.appendChild(outerDiv);
                }
            })();
        </c:if>
    </c:forEach>
});
</script>
</c:if>