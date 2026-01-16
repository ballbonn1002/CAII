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
<script src="assets/plugins/custom/ckeditor/ckeditor-classic.bundle.js"></script>

<!DOCTYPE html>
<!--begin::Image input placeholder-->
<style>
.image-input-placeholder {
	background-image: url('svg/avatars/blank.svg');
}

[data-bs-theme="dark"] .image-input-placeholder {
	background-image: url('svg/avatars/blank-dark.svg');
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
					<div class="d-flex align-items-center">
						<a
							class="btn btn-danger btn-flex h-40px border-0 fw-bold px-4 px-lg-6"
							href="announcementDelete?id=${announcement.announcementId}">
							<i class="ki-duotone ki-trash fs-2"> <span class="path1"></span>
								<span class="path2"></span> <span class="path3"></span> <span
								class="path4"></span> <span class="path5"></span>
						</i>&nbsp; Delete
						</a>
					</div>
				</div>
			</div>
		</div>
		<div class="app-content flex-column-fluid">
			<div class="app-container container-fluid">
				<form autocomplete="off" action="announcementAdd" method="POST"
					id="formid" class="horizontal-form" enctype="multipart/form-data">
					<div class="row g-5 gx-xl-10">
						<div
							class="col-md-12 col-lg-7 col-xl-7 col-xxl-8 mb-md-5 mb-xl-10">
							<div class="card card-flush py-3">
								<div class="card-header pt-5">
									<h3 class="card-title fw-semibold">Announcement</h3>
									<div class="card-toolbar">
										<div
											class="form-check form-switch form-check-custom form-check-primary form-check-solid me-7">
											<span class="fs-6 fw-medium text-gray-700">Highlight&nbsp;&nbsp;</span>
											<input class="form-check-input h-20px w-33px" type="checkbox"
												name="highlight" value="1" checked id="highlight" />
										</div>

										<div
											class="form-check form-switch form-check-custom form-check-success form-check-solid">
											<span class="fs-6 fw-medium text-gray-700">Active&nbsp;&nbsp;</span><input
												class="form-check-input  h-20px w-33px" type="checkbox"
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
										<label class="form-label required form-labe">Topic</label> <input
											type="text" class="form-control" placeholder="Enter topic"
											name="topic" id="topic">
									</div>
									<div class="mb-10">
										<label class="form-label required form-labe">Announcement
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
											</span> <input id="kt_td_picker_basic_input" type="text"
												name="anndate" class="form-control"
												data-td-target="#kt_td_picker_basic" />
										</div>
									</div>
									<div class="mb-5">
										<textarea id="kt_docs_ckeditor_classic" name="detail"></textarea>
									</div>
								</div>
							</div>
						</div>
						<div
							class="col-md-12 col-lg-5 col-xl-5 col-xxl-4 mb-md-5 mb-xl-10">
							<div class="card card-flush py-3 mb-5 mb-xl-10">
								<div class="card-header pt-5 flex-column align-items-start">
									<h3 class="card-title fw-bold text-gray-900 mb-1">Cover
										Photo</h3>
									<span class="fw-semibold fs-6 text-danger">Not shown in
										details</span>
								</div>
								<div class="card-body pt-6 text-center">
									<!--begin::Image input-->
									<div class="image-input image-input-outline"
										data-kt-image-input="true"
										style="background-image: url(/assets/media/svg/avatars/blank.svg)">
										<!--begin::Image preview wrapper-->
										<c:if test="${not empty announcement}">
											<div class="image-input-wrapper w-250px h-250px"
												style="background-image: url(${empty announcement.fileUpload.path 
         											? '/assets/media/svg/avatars/blank.svg' 
         											: announcement.fileUpload.path})">
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
												class="path2"></span></i> <!--begin::Inputs--> <input
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
										class="border border-warning rounded border-active active w-100">
										<div class="py-5 d-flex flex-column align-items-center">
											<div
												class="fs-3 fw-bold text-warning d-flex justify-content-center align-items-center gap-2 mb-5">
												<i class="ki-duotone ki-information-2 fs-3x text-warning">
													<span class="path1"></span> <span class="path2"></span> <span
													class="path3"></span>
												</i> Attach files
											</div>
											<div
												class="d-flex justify-content-center align-items-center text-center fw-medium fs-7 mb-5">Only
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
											id="lbFile" for="myFile" style="height: 44px;">Upload
											File <input type="file" id="myFile" name="files" multiple
											style="display: none;"
											accept=".pdf, .doc, .docx, .xlsx, .pptx, .csv, .png, .jpg, .jpeg, .gif, .webp, .mp4" />
											<input type="hidden" name="filesUploadFileName"
											id="filesUploadFileName" /> <input type="hidden"
											name="fileUploadId" id="fileUploadId" />
										</label>
										<div id="filePreviewContainer" style="margin-top: 10px;"></div>
										<div id="fileList" style="margin-bottom: 10px;"></div>
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
document.addEventListener('DOMContentLoaded', function() {
    const pickerElement = document.getElementById("kt_td_picker_basic");
    const picker = new tempusDominus.TempusDominus(pickerElement, {
        display: {
            components: { clock: false }
        },
        localization: {
        	locale: 'en',
            format: "dd MMM yyyy"
        }
    });

    <c:if test="${not empty announcement}">
        const dateStr = "<fmt:formatDate value='${announcement.announcement_date}' pattern='yyyy-MM-dd'/>";
        const dateObj = new Date(dateStr);
        picker.dates.setValue(tempusDominus.DateTime.convert(dateObj));
    </c:if>
});
</script>

<script>
	// Note Editor
	let editorInstance;
	ClassicEditor
    .create(document.querySelector('#kt_docs_ckeditor_classic'),{
    	ckfinder:
    	{
    		uploadUrl: 'uploadImageFromCkeditor'
    	},
    	mediaEmbed: {
            previewsInData: true
        }
    })
    .then(editor => {
        editorInstance = editor;
        // ถ้าเป็น Edit กำหนดค่า
        <c:if test="${not empty announcement}">
            editor.setData(`<c:out value='${announcement.detail}' escapeXml='false'/>`);
        </c:if>
    })
    .catch(error => { console.error(error); });
	
	var selectedFiles = [];

	document.getElementById('myFile').addEventListener('change', function(event) {
	    var fileList = event.target.files;
	    var fileListDiv = document.getElementById('fileList');
	    
	    for (let i = 0; i < fileList.length; i++) {
	        const file = fileList[i];
	        const existing = selectedFiles.find(f => f.name === file.name && f.size === file.size);
	        if (!existing) {
	            selectedFiles.push(file);
	        } else {
	        	continue;
	        }
	    }
	    
	    fileListDiv.style.display = "flex";
	    fileListDiv.style.flexWrap = "wrap";
	    fileListDiv.style.gap = "10px";

	    if (fileList.length > 0) {
	        for (let i = 0; i < fileList.length; i++) {
	            const file = fileList[i];
	            //selectedFiles.push(file);

	            const fileURL = URL.createObjectURL(file);
	            const fileName = file.name;
	            const fileExtension = fileName.split('.').pop().toLowerCase();

	            let iconClass = "fa-file";
	            if (fileExtension === "pdf") iconClass = "ki-duotone ki-file-pdf";
	            else if (fileExtension === "doc" || fileExtension === "docx") iconClass = "fa-file-word-o";
	            else if (fileExtension === "xlsx" || fileExtension === "xls") iconClass = "fa-file-excel-o";
	            else if (fileExtension === "ppt" || fileExtension === "pptx") iconClass = "fa-file-powerpoint-o";
	            else if (fileExtension === "csv") iconClass = "fa-file-csv-o";
	            else if (["png", "jpg", "jpeg", "gif", "bmp", "webp"].includes(fileExtension)) iconClass = "fa-file-image-o";
	            else if (fileExtension === "mp4") iconClass = "fa-file-video-o";

	            const fileWrapper = document.createElement('div');
	            fileWrapper.style.display = "flex";
	            fileWrapper.style.justifyContent = "space-between";
	            fileWrapper.style.marginBottom = "5px";
	            fileWrapper.setAttribute("data-filename", fileName);

	            const leftGroup = document.createElement('div');
	            leftGroup.style.display = "flex";
	            leftGroup.style.alignItems = "center";

	            const icon = document.createElement('i');
	            icon.className = iconClass; // Metronic / FA icon
	            icon.style.marginRight = "5px";

	            // file name
	            const aTag = document.createElement('a');
	            aTag.href = fileURL;
	            aTag.textContent = fileName;
	            aTag.target = "_blank";
	            aTag.className = "fs-6 text-gray-800 fw-medium me-5";

	            // icon + aTag in leftGroup
	            leftGroup.appendChild(icon);
	            leftGroup.appendChild(aTag);

	            // trash buttun in rightGroup
	            const removeBtn = document.createElement("span");
	            removeBtn.classList.add("badge", "badge-light-danger", "cursor-pointer");
	            removeBtn.type = "button";
	            removeBtn.onclick = function () {
	                selectedFiles = selectedFiles.filter(f => f.name !== fileName);
	                fileWrapper.remove();
	                updateInputFiles();
	            };

	            // trash icon
	            const trashIcon = document.createElement("i");
	            trashIcon.className = "ki-duotone ki-trash text-danger fs-2";
	            trashIcon.innerHTML = `
	                <span class="path1"></span>	
	                <span class="path2"></span>
	                <span class="path3"></span>
	                <span class="path4"></span>
	                <span class="path5"></span>
	            `;
	            removeBtn.appendChild(trashIcon);
				// set layout left & right
	            fileWrapper.appendChild(leftGroup);
	            fileWrapper.appendChild(removeBtn);

	            fileListDiv.appendChild(fileWrapper);
	        }
	    } else {
	        fileListDiv.textContent = "No file selected.";
	    }

	    updateInputFiles();
	});

	// อัปเดตค่า input.files ให้เป็นค่าที่เลือกล่าสุด
	function updateInputFiles() {
	    var inputFile = document.getElementById("myFile");
	    var dataTransfer = new DataTransfer();

	    selectedFiles.forEach(file => dataTransfer.items.add(file));

	    inputFile.files = dataTransfer.files;
	    console.log("Updated input.files:", inputFile.files);
	}
	
	// ฟังก์ชันแสดง Alert และส่งฟอร์ม
	function confirmButton() {
		event.preventDefault();

	    // ดึงค่าจากฟอร์ม
	    var topic = document.querySelector("input[name='topic']").value.trim();
	    var annDate = document.querySelector("input[name='anndate']").value.trim();
	    var status = document.querySelector("input[name='status']").value.trim();
	 	// ดึงค่าจาก CKEditor
	    var detail = editorInstance.getData().trim();

	    // ตรวจสอบว่ามีช่องไหนว่างหรือไม่
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

	    // ถ้ามีช่องว่าง แสดงข้อความแจ้งเตือน และหยุดทำงาน
	    if (errorFields.length > 0) {
	        Swal.fire({
	            title: "โปรดกรอกข้อมูลให้ครบถ้วน",
	            html: "Please fill in the following fields:<br><strong>" + errorFields.join(", ") + "</strong>",
	            icon: "error",
	            confirmButtonColor: "#d33",
	            confirmButtonText: "OK",
	            buttonsStyling: false,
	            customClass: {
	                confirmButton: "btn btn-danger"
	            }
	        });
	        return;
	    }

	    // ถ้าข้อมูลครบ ให้ถามยืนยันการบันทึก
	    Swal.fire({
	        title: "Are you sure?!",
	        text: "Do you want to save the changes?",
	        icon: "warning",
	        showCancelButton: true,
	        confirmButtonText: "Save",
	        cancelButtonText: "Close",
	        buttonsStyling: false,
	        customClass: {
	            confirmButton: "btn btn-success",
	            cancelButton: "btn btn-secondary"
	        }
	    }).then((result) => {
	        if (result.isConfirmed) {
	            // อัปเดต input.files ก่อนส่ง
	            updateInputFiles();

	            // ดึงชื่อไฟล์ทั้งหมด
	            var fileNames = selectedFiles.map(file => file.name);

	            // เซ็ตค่า input hidden ให้เป็น JSON ของชื่อไฟล์
	            document.getElementById("filesUploadFileName").value = JSON.stringify(fileNames);

	            // ส่งฟอร์ม
	            var form = document.getElementById("formid");
	            form.action = "announcementAdd";
	            form.submit();
	        }
	    });
	}

	// close button
	function confirmClose() {
		event.preventDefault();
		
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
	            window.location.href = 'announcementList';
	        }
	    });
	}
</script>

<c:if test="${not empty announcement}">
	<script>
document.addEventListener('DOMContentLoaded', function() {
    // เซ็ตค่า input ต่างๆ
    document.getElementById("topic").value = "${announcement.topic}";
    document.getElementById("kt_td_picker_basic_input").value = "<fmt:formatDate value='${announcement.announcement_date}' pattern='dd MMM yyyy'/>";
    document.getElementById("status").checked = ${announcement.status == '1' ? 'true' : 'false'};
    document.getElementById("highlight").checked = ${announcement.highlight == '1' ? 'true' : 'false'};

    // วนไฟล์เก่ามา preview
    const fileListDiv = document.getElementById("fileList");
    fileListDiv.style.display = "flex";
    fileListDiv.style.flexDirection = "column";
    fileListDiv.style.gap = "10px";

    var deletedFileIds = []; // เก็บ id ไฟล์ที่ลบ

    <c:forEach var="file" items="${announcementFiles}">
        <c:if test="${file.pageId == announcement.announcementId}">
            (function(){
                const fileId = "${file.fileId}";
                const fileName = "${file.name}${file.type}";
                const filePath = "${file.path}";
                const fileExtension = "${file.type}".replace('.', '').toLowerCase();

                const fileWrapper = document.createElement('div');
                fileWrapper.style.display = "flex";
                fileWrapper.style.justifyContent = "space-between";
                fileWrapper.style.marginBottom = "5px";
                fileWrapper.style.width = "100%";

                const leftGroup = document.createElement('div');
                leftGroup.style.display = "flex";
                leftGroup.style.alignItems = "center";

                const icon = document.createElement('i');
                icon.className = "fa-file"; // ปรับตาม type
                icon.style.marginRight = "5px";

                const aTag = document.createElement('a');
                aTag.href = filePath;
                aTag.textContent = fileName;
                aTag.target = "_blank";
                aTag.className = "fs-6 text-gray-800 fw-medium me-5";

                leftGroup.appendChild(icon);
                leftGroup.appendChild(aTag);

                const removeBtn = document.createElement("span");
                removeBtn.classList.add("badge", "badge-light-danger", "cursor-pointer");
                removeBtn.onclick = function () {
                    fileWrapper.remove();
                    deletedFileIds.push(fileId);
                    document.getElementById("fileUploadId").value = JSON.stringify(deletedFileIds);
                };

                const trashIcon = document.createElement("i");
                trashIcon.className = "ki-duotone ki-trash text-danger fs-2";
                trashIcon.innerHTML = `
                    <span class="path1"></span>	
                    <span class="path2"></span>
                    <span class="path3"></span>
                    <span class="path4"></span>
                    <span class="path5"></span>
                `;
                removeBtn.appendChild(trashIcon);

                fileWrapper.appendChild(leftGroup);
                fileWrapper.appendChild(removeBtn);
                fileListDiv.appendChild(fileWrapper);
            })();
        </c:if>
    </c:forEach>
});
</script>
</c:if>