<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/style.bundle.css"
	rel="stylesheet" />
<style>
/* Header */
#itemTable thead th {
	font-weight: 600 !important;
	text-transform: uppercase;
	white-space: nowrap;
	vertical-align: middle;
}

#itemTable thead th .dt-column-header {
	display: inline-flex !important;
	flex-direction: row !important;
	align-items: center !important;
}

#itemTable thead th .dt-column-order {
	margin: 0 !important;
}

.image-input-wrapper {
	/* Shadow */
	box-shadow: 0 4px 4px 0 rgba(0, 0, 0, 0.03);
}

.image-input-placeholder {
	background-image:
		url('${pageContext.request.contextPath}/assets/media/svg/files/blank-image.svg');
}

/* =========================================
   Additional Images
   ========================================= */
.additional-image-wrapper {
	position: relative;
}

.additional-image-card {
	position: relative;
	width: 100%;
	aspect-ratio: 1/1;
	border: 1px solid #e1e3ea;
	border-radius: 8px;
	overflow: visible;
	background-color: #fff;
}

.additional-image-card img {
	width: 100%;
	height: 100%;
	object-fit: contain;
	border-radius: 8px;
}

/* Remove button */
.additional-image-remove {
	position: absolute;
	top: -10px;
	right: -10px;
	width: 28px;
	height: 28px;
	border: 0;
	border-radius: 50%;
	background-color: #fff;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	z-index: 2;
	color: #b5b5c3;
}

.additional-image-remove:hover {
	color: #f1416c;
	background-color: #fff;
}

/* Upload button */
#uploadAdditionalImagesBtn {
	max-width: 350px;
}
</style>
</head>
<body>
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
						Edit Item</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/check_in_out"
							class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a href="#"
							class="text-muted text-hover-primary">Cube Token Privilege</a></li>

						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/privilegeMangementPage"
							class="text-muted text-hover-primary">Privilege Management</a></li>

						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/editRewardItem?itemId=${item.itemId}"
							class="text-muted text-hover-primary">Edit Item</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid ">
			<div id="kt_app_content_container"
				class="app-container container-fluid">

				<div class="row g-7">
					<div class="col-12 col-xl-8">
						<div class="card">
							<!--begin::Card Header-->
							<div class="card-header">

								<!--begin::Card title-->
								<div class="card-title">
									<h3 class="fw-semibold text-gray-900">Add Item</h3>
								</div>
								<!--end::Card title-->

								<!--begin::Card toolbar-->
								<div class="card-toolbar">
									<div class="d-flex align-items-center gap-3">

										<span class="text-gray-700 fs-6 fw-medium"> Active </span>

										<div
											class="form-check form-check-success form-switch form-check-custom form-check-solid">
											<input class="form-check-input w-30px h-20px" type="checkbox"
												value="1" id="itemActive"
												${item.activeFlag == 'Y' ? 'checked' : ''} />
										</div>

									</div>
								</div>
								<!--end::Card toolbar-->

							</div>
							<!--end::Card Header-->


							<div class="card-body">

								<div class="row g-5 mb-6">
									<!-- ITEM NAME -->
									<div class="col-md-6 itemName-container">
										<label for="itemName"
											class="form-label fw-mudium text-gray-800 required">
											Item Name</label> <input type="text" value="${item.itemName}"
											class="form-control form-control-lg" id="itemName"
											name="itemName" placeholder="Enter item name" />
									</div>

									<!-- QUANTITY -->
									<div class="col-md-6 itemQuantity-container">

										<label for="itemQuantity"
											class="form-label fw-medium text-gray-800 required">
											Quantity </label> <input type="number" value="${item.quantity}"
											class="form-control form-control-lg" id="itemQuantity"
											name="itemQuantity" min="0" placeholder="0" />

									</div>
								</div>



								<!-- TOKEN / ADDITIONAL CASH -->
								<div class="row g-5 mb-6">

									<!-- TOKEN -->
									<div class="col-12 col-md-6 itemToken-container">

										<label for="itemToken"
											class="form-label fw-medium text-gray-800 required">


											Token </label> <input type="number" value="${item.token.intValue()}"
											class="form-control form-control-lg" id="itemToken"
											name="itemToken" min="0" placeholder="0" />

									</div>

									<!-- EXTRA CASH -->
									<div class="col-12 col-md-6 extraCash-container">

										<label for="extraCash"
											class="form-label fw-medium text-gray-800 required">
											Additional Cash (THB) </label> <input type="number"
											value="${item.addedMoney.intValue()}"
											class="form-control form-control-lg" id="itemAddedMoney"
											name="addedMoney" min="0" placeholder="0" />

									</div>


								</div>


								<!-- DESCRIPTION -->
								<div class="mb-6 itemDescription-container">

									<label for="itemDescription"
										class="form-label fw-medium text-gray-800">
										Description </label>

									<textarea class="form-control form-control"
										id="itemDescription" name="itemDescription" rows="3"
										placeholder="Enter description">${item.details}</textarea>

								</div>


								<!-- EFFECTIVE DATE -->
								<div>

									<label for="effectiveDate"
										class="form-label fw-medium text-gray-800 required">
										Effective Date </label>

									<div class="mb-0 ">
										<fmt:formatDate value="${item.startDate}" pattern="yyyy-MM-dd"
											var="startDate" />
										<fmt:formatDate value="${item.endDate}" pattern="yyyy-MM-dd"
											var="endDate" />

										<div class="position-relative">

											<input class="form-control form-control-lg ps-15"
												placeholder="Select date range" placeholder="Pick date rage"
												id="kt_daterangepicker_1" name="effectiveDate" /> 
												<i
												class="ki-duotone ki-calendar-8 fs-1 position-absolute ms-3 top-50 translate-middle-y">
												<span class="path1"></span> <span class="path2"></span> <span
												class="path3"></span> <span class="path4"></span> <span
												class="path5"></span> <span class="path6"></span>
											</i>
										</div>

										<div class="effectiveDate-container"></div>
									</div>




								</div>
							</div>
						</div>
					</div>
					<div class="col-12 col-xl-4">
						<div class="row g-4">
							<div class="col-12 col-md-6 col-xl-12">
								<div class="card">
									<!--begin::Card Header-->
									<div class="card-header">
										<!--begin::Card title-->
										<div class="card-title">
											<h3 class="fw-semibold text-gray-900">Cover Image</h3>
											<label class="required form-label ms-1 pt-1"></label>
										</div>
										<!--end::Card title-->
									</div>
									<!--end::Card Header-->


									<div class="card-body">

										<div class="d-flex flex-column align-items-center">
											<!--begin::Image input-->
											<div class="image-input image-input-placeholder mb-3"
												id="coverImageInput" data-kt-image-input="true">
												<!--begin::Image preview wrapper-->
												<div class="image-input-wrapper w-150px h-150px"
													style="background-image: url('${pageContext.request.contextPath}${item.coverPath}');"></div>
												<!--end::Image preview wrapper-->

												<!--begin::Edit button-->
												<label
													class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow-sm"
													data-kt-image-input-action="change"
													data-bs-toggle="tooltip" data-bs-dismiss="click"
													title="Change cover image"> <i
													class="ki-duotone ki-pencil fs-6"><span class="path1"></span><span
														class="path2"></span></i> <!--begin::Inputs--> <input
													type="file" name="cover" id="coverImage"
													accept=".png, .jpg, .jpeg" /> <input type="hidden"
													name="cover_remove" /> <!--end::Inputs-->
												</label>
												<!--end::Edit button-->

												<!--begin::Cancel button-->
												<span
													class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow-sm"
													data-kt-image-input-action="cancel"
													data-bs-toggle="tooltip" data-bs-dismiss="click"
													title="Cancel cover"> <i
													class="ki-outline ki-cross fs-3"></i>
												</span>
												<!--end::Cancel button-->

												<!--begin::Remove button-->
												<span
													class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow-sm"
													data-kt-image-input-action="remove"
													data-bs-toggle="tooltip" data-bs-dismiss="click"
													title="Remove logo"> <i
													class="ki-outline ki-cross fs-3"></i>
												</span>
												<!--end::Remove button-->
											</div>
											<!--end::Image input-->

											<div
												class="cover-container d-flex flex-column align-items-center justify-content-center">
												<span class="fw-medium text-muted fs-7">Allowed file
													types: png, jpg, jpeg.</span>
											</div>
										</div>

									</div>
								</div>
							</div>
							<div class="col-12 col-md-6 col-xl-12">
								<div class="card h-100">
									<!--begin::Card Header-->
									<div class="card-header">

										<!--begin::Card title-->
										<div class="card-title">
											<h3 class="fw-semibold text-gray-900">Additional Images</h3>
										</div>
										<!--end::Card title-->
									</div>
									<!--end::Card Header-->


									<div class="card-body">
										<div
											class="d-flex flex-column justify-content-between align-items-center h-100">
											<!-- Preview Container -->
											<div id="additionalImagesPreview" class="row g-4 mb-6">
											</div>

											<!-- Empty State -->
											<div id="additionalImagesEmpty"
												class="d-flex flex-column align-items-center justify-content-center pb-10">

												<img
													src="${pageContext.request.contextPath}/assets/media/svg/files/blank-image.svg"
													alt="" style="width: 80px; height: 80px" class="rounded" />

											</div>



											<!-- Upload Button -->
											<div class="text-center w-100">
												<div id="errorMessage" class="text-danger fs-7 fw-medium"></div>
												<button type="button" id="uploadAdditionalImagesBtn"
													class="btn btn-primary w-100">Upload Images</button>

												<input type="file" id="additionalImagesInput"
													accept=".png,.jpg,.jpeg" multiple hidden>

											</div>
										</div>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div
					class="d-flex align-items-center justify-content-end gap-3 mt-10">
					<button type="button" class="btn btn-light"
						onClick="window.location.href = 'privilegeMangementPage'">Cancel</button>
					<button type="button" class="btn btn-success" id="saveBtn">Save</button>
				</div>




			</div>
		</div>
	</div>
	<script
		src="${pageContext.request.contextPath}/assets/js/custom/utilities/attachFile/attcahfile.js"></script>
	<script>

    // ==========================================
    // Existing / New Images
    // ==========================================

    let existingAdditionalImages = [];
    let additionalImageFiles = [];
    let removedAdditionalImages = [];

    let coverChanged = false;

    const validationState = {
        itemName: false,
        itemToken: false,
        itemQuantity: false,
        effectiveDate: false,
        itemAddedMoney: false,
        cover: true
    };


    // ==========================================
    // Additional Images Elements
    // ==========================================

    const additionalImagesInput =
        document.getElementById("additionalImagesInput");

    const uploadAdditionalImagesBtn =
        document.getElementById("uploadAdditionalImagesBtn");

    const additionalImagesPreview =
        document.getElementById("additionalImagesPreview");

    const additionalImagesEmpty =
        document.getElementById("additionalImagesEmpty");

    const errorMessage =
        document.getElementById("errorMessage");


    // ==========================================
    // Load Existing Additional Images
    // ==========================================

    try {

        const imgPath = '${item.imgPath}';

        if (imgPath && imgPath.trim() !== "") {
            existingAdditionalImages = JSON.parse(imgPath);
        }

    } catch (e) {

        console.error(
            "Unable to parse existing additional images:",
            e
        );

        existingAdditionalImages = [];

    }


    // ==========================================
    // Open file picker
    // ==========================================

    uploadAdditionalImagesBtn.addEventListener("click", function () {

        additionalImagesInput.click();

    });


    // ==========================================
    // Select new files
    // ==========================================

    additionalImagesInput.addEventListener("change", function (event) {

        const files = Array.from(event.target.files);

        errorMessage.textContent = "";

        files.forEach(function (file) {

            // Validate file type
            const allowedTypes = [
                "image/png",
                "image/jpeg",
                "image/jpg"
            ];

            if (!allowedTypes.includes(file.type)) {
                errorMessage.textContent =
                    file.name + " is not a valid image.";
                return;
            }


            // Validate file size
            const maxSize = 10 * 1024 * 1024;

            if (file.size > maxSize) {

                errorMessage.textContent =
                    file.name + " is larger than 10 MB.";

                return;
            }


            // Maximum 10 images
            const totalImages =
                existingAdditionalImages.length
                + additionalImageFiles.length;

            if (totalImages >= 10) {

                errorMessage.textContent =
                    "You can upload up to 10 images.";

                return;
            }


            // Prevent duplicate new file
            const duplicate =
                additionalImageFiles.some(function (existingFile) {

                    return (
                        existingFile.name === file.name &&
                        existingFile.size === file.size &&
                        existingFile.lastModified === file.lastModified
                    );

                });

            if (duplicate) {
                return;
            }


            additionalImageFiles.push(file);

        });


        renderAdditionalImages();

        // Reset input
        additionalImagesInput.value = "";

    });


    // ==========================================
    // Render Existing + New Images
    // ==========================================

    function renderAdditionalImages() {

        additionalImagesPreview.innerHTML = "";

        const totalImages =
            existingAdditionalImages.length
            + additionalImageFiles.length;


        // Empty state
        if (totalImages === 0) {

            additionalImagesEmpty.classList.remove("d-none");

            return;

        }

        additionalImagesEmpty.classList.add("d-none");


        // ==========================================
        // Existing Images
        // ==========================================

        existingAdditionalImages.forEach(function (imagePath, index) {

            const col = document.createElement("div");
            col.className = "col-6";


            const wrapper = document.createElement("div");
            wrapper.className = "additional-image-wrapper";


            const card = document.createElement("div");
            card.className = "additional-image-card";


            const img = document.createElement("img");

            img.alt = "Additional image";

            img.src =
                "${pageContext.request.contextPath}" + imagePath;


            // ==========================================
            // Remove button
            // ==========================================

            const removeBtn =
                document.createElement("button");

            removeBtn.type = "button";

            removeBtn.className =
                "additional-image-remove";


            removeBtn.innerHTML = `
                <i class="ki-outline ki-cross fs-5"></i>
            `;


            removeBtn.addEventListener("click", function () {

                removeExistingAdditionalImage(index);

            });


            card.appendChild(img);

            wrapper.appendChild(card);

            wrapper.appendChild(removeBtn);

            col.appendChild(wrapper);

            additionalImagesPreview.appendChild(col);

        });


        // ==========================================
        // New Images
        // ==========================================

        additionalImageFiles.forEach(function (file, index) {

            const col = document.createElement("div");
            col.className = "col-6";


            const wrapper = document.createElement("div");
            wrapper.className = "additional-image-wrapper";


            const card = document.createElement("div");
            card.className = "additional-image-card";


            const img = document.createElement("img");

            img.alt = file.name;


            const objectUrl =
                URL.createObjectURL(file);

            img.src = objectUrl;


            img.onload = function () {

                URL.revokeObjectURL(objectUrl);

            };


            // ==========================================
            // Remove button
            // ==========================================

            const removeBtn =
                document.createElement("button");

            removeBtn.type = "button";

            removeBtn.className =
                "additional-image-remove";


            removeBtn.innerHTML = `
                <i class="ki-outline ki-cross fs-5"></i>
            `;


            removeBtn.addEventListener("click", function () {

                removeAdditionalImage(index);

            });


            card.appendChild(img);

            wrapper.appendChild(card);

            wrapper.appendChild(removeBtn);

            col.appendChild(wrapper);

            additionalImagesPreview.appendChild(col);

        });

    }


    // ==========================================
    // Remove Existing Image
    // ==========================================

    function removeExistingAdditionalImage(index) {

        const imagePath =
            existingAdditionalImages[index];


        removedAdditionalImages.push(imagePath);

        existingAdditionalImages.splice(index, 1);

        renderAdditionalImages();

    }


    // ==========================================
    // Remove New Image
    // ==========================================

    function removeAdditionalImage(index) {

        additionalImageFiles.splice(index, 1);

        renderAdditionalImages();

    }


    // ==========================================
    // Validation
    // ==========================================

    function setFieldInvalid(selector, message) {
	
	    const input = $(selector);
	
	    input.addClass("is-invalid");
	
	    let container = input.closest("[class$='-container']");
	
	    if (selector === "#coverImage") {
	        container = $(".cover-container");
	    }
	
	    if (selector === "#kt_daterangepicker_1") {
	        container = $(".effectiveDate-container");
	    }
	
	    let feedback = container.find(".invalid-feedback");
	
	    if (!feedback.length) {
	        feedback = \$(`
	            <div class="invalid-feedback d-block \${
	                selector === "#coverImage" ? "text-center" : ""
	            }"></div>
	        `);
	
	        container.append(feedback);
	    }
	
	    feedback.text(message);
	}


    function clearFieldError(selector) {

        const input = $(selector);

        input.removeClass("is-invalid");

        let container =
            input.closest("[class$='-container']");

        if (selector === "#coverImage") {
            container = $(".cover-container");
        }
        
        if (selector === "#kt_daterangepicker_1") container = $(".effectiveDate-container");

        container.find(".invalid-feedback").remove();

    }


    function updateBtnState() {

        const saveBtn = $("#saveBtn");

        const isValid =
            Object.values(validationState)
                .every(value => value === true);

        saveBtn.prop("disabled", !isValid);

    }


    // ==========================================
    // Item Name
    // ==========================================

    function validateItemName() {

        const value = $(this).val().trim();

        if (value.length === 0) {

            validationState.itemName = false;

            setFieldInvalid(
                "#itemName",
                "Item name is required."
            );

            updateBtnState();

            return;

        }


        validationState.itemName = true;

        clearFieldError("#itemName");

        updateBtnState();

    }


    // ==========================================
    // Quantity
    // ==========================================

    function validateItemQuantity() {

        const value = $(this).val().trim();

        if (value === "") {

            validationState.itemQuantity = false;

            setFieldInvalid(
                "#itemQuantity",
                "Item quantity is required."
            );

            updateBtnState();

            return;

        }


        if (Number(value) < 0) {

            validationState.itemQuantity = false;

            setFieldInvalid(
                "#itemQuantity",
                "Item quantity must be positive."
            );

            updateBtnState();

            return;

        }


        validationState.itemQuantity = true;

        clearFieldError("#itemQuantity");

        updateBtnState();

    }


    // ==========================================
    // Token
    // ==========================================

    function validateItemToken() {

        const value = $(this).val().trim();

        if (value === "") {

            validationState.itemToken = false;

            setFieldInvalid(
                "#itemToken",
                "Item token is required."
            );

            updateBtnState();

            return;

        }


        if (Number(value) <= 0) {

            validationState.itemToken = false;

            setFieldInvalid(
                "#itemToken",
                "Item token value must be greater than zero."
            );

            updateBtnState();

            return;

        }


        validationState.itemToken = true;

        clearFieldError("#itemToken");

        updateBtnState();

    }
    
    function validateItemAddedMoney() {

        const value = $(this).val().trim();

        if (value === "") {

        	validationState.itemAddedMoney = false;
            setFieldInvalid(
                "#itemAddedMoney",
                "Additional cash is required."
            );
            
            updateBtnState();
            return

        } else if (Number(value) < 0) {

        	validationState.itemAddedMoney = false;
            setFieldInvalid(
                "#itemAddedMoney",
                "Additional cash must not be negative."
            );
            
            updateBtnState();
            return

        } else {

        	validationState.itemAddedMoney = true;
            clearFieldError("#itemAddedMoney");

        }
        
        updateBtnState();

    }


    // ==========================================
    // Effective Date
    // ==========================================

    function validateEffectiveDate() {

        const input =
            $("#kt_daterangepicker_1");

        const value =
            input.val().trim();


        if (value === "") {

            validationState.effectiveDate = false;

            setFieldInvalid(
                "#kt_daterangepicker_1",
                "Effective date is required."
            );

            updateBtnState();

            return;

        }


        const pattern =
            /^\d{2} [A-Za-z]{3} \d{4} - \d{2} [A-Za-z]{3} \d{4}$/;


        if (!pattern.test(value)) {

            validationState.effectiveDate = false;

/*             setFieldInvalid(
                "#kt_daterangepicker_1",
                "Invalid effective date format."
            ); */

            updateBtnState();

            return;

        }


        const parts =
            value.split(" - ");


        if (parts.length !== 2) {

            validationState.effectiveDate = false;

            setFieldInvalid(
                "#kt_daterangepicker_1",
                "Invalid effective date."
            );

            updateBtnState();

            return;

        }


        const startDate =
            parseDate(parts[0]);

        const endDate =
            parseDate(parts[1]);


        if (!startDate || !endDate) {

            validationState.effectiveDate = false;

            setFieldInvalid(
                "#kt_daterangepicker_1",
                "Invalid effective date."
            );

            updateBtnState();

            return;

        }


        if (startDate > endDate) {

            validationState.effectiveDate = false;

            setFieldInvalid(
                "#kt_daterangepicker_1",
                "Start date must not be after end date."
            );

            updateBtnState();

            return;

        }


        validationState.effectiveDate = true;

        clearFieldError(
            "#kt_daterangepicker_1"
        );

        updateBtnState();

    }
    
	  //Image compression logic
		async function compressImage(file, maxWidth = 1280, maxHeight = 1280, quality = 0.8) {
			if (!file.type.match(/image\/(jpeg|jpg|png)/)) {
				return file;
			}
	
			return new Promise((resolve, reject) => {
				const reader = new FileReader();
				reader.readAsDataURL(file);
				reader.onload = event => {
					const img = new Image();
					img.src = event.target.result;
					img.onload = () => {
						let width = img.width;
						let height = img.height;
	
						if (width > maxWidth || height > maxHeight) {
							const ratio = Math.min(maxWidth / width, maxHeight / height);
							width = width * ratio;
							height = height * ratio;
						}
	
						const canvas = document.createElement('canvas');
						canvas.width = width;
						canvas.height = height;
						const ctx = canvas.getContext('2d');
						ctx.drawImage(img, 0, 0, width, height);
	
						canvas.toBlob((blob) => {
							if (blob) {
								const newFileName = file.name.replace(/\.[^/.]+$/, ".jpg");
								const newFile = new File([blob], newFileName, {
									type: 'image/jpeg',
									lastModified: Date.now()
								});
								resolve(newFile);
							} else {
								resolve(file);
							}
						}, 'image/jpeg', quality);
					};
					img.onerror = error => reject(error);
				};
				reader.onerror = error => reject(error);
			});
		}


    // ==========================================
    // Cover Validation - UPDATE
    // ==========================================

    function validateCover() {

        const input =
            document.querySelector("#coverImage");

        const file =
            input.files[0];


        // ==========================================
        // Existing cover is valid if unchanged
        // ==========================================

        if (!coverChanged) {

            validationState.cover = true;

            clearFieldError("#coverImage");

            updateBtnState();

            return;

        }


        // ==========================================
        // Cover has been changed
        // ==========================================

        if (!file) {

            validationState.cover = false;

            setFieldInvalid(
                "#coverImage",
                "Cover image is required."
            );

            updateBtnState();

            return;

        }


        const allowedTypes = [
            "image/png",
            "image/jpeg",
            "image/jpg"
        ];


        if (!allowedTypes.includes(file.type)) {

            validationState.cover = false;

            setFieldInvalid(
                "#coverImage",
                "Only PNG and JPG images are allowed."
            );

            updateBtnState();

            return;

        }


        const maxSize = 10 * 1024 * 1024;


        if (file.size > maxSize) {

            validationState.cover = false;

            setFieldInvalid(
                "#coverImage",
                "Cover image must not exceed 10 MB."
            );

            updateBtnState();

            return;

        }


        validationState.cover = true;

        clearFieldError("#coverImage");

        updateBtnState();

    }


    // ==========================================
    // Submit
    // ==========================================

    async function submit() {

        $("#saveBtn").prop("disabled", true);


        Swal.fire({

            title: "Confirm Update",

            text:
                "Are you sure you want to update this reward item?",

            icon: "question",

            showCancelButton: true,

            confirmButtonText: "Yes, Update",

            cancelButtonText: "Cancel",

            buttonsStyling: false,

            customClass: {

                confirmButton: "btn btn btn-success px-3",

                cancelButton: "btn btn-light"

            },
	        focusConfirm: false,
	        focusCancel: false,
	        reverseButtons: true

        }).then(async function (result) {

            if (!result.isConfirmed) {

                updateBtnState();

                return;

            }


            // ==========================================
            // FormData
            // ==========================================

            const formData = new FormData();


            // Item ID
            formData.append(
                "itemId",
                "${item.itemId}"
            );


            formData.append(
                "itemName",
                $("#itemName").val().trim()
            );

            formData.append(
                "itemToken",
                $("#itemToken").val().trim()
            );
            
            formData.append("itemAddedMoney", $("#itemAddedMoney").val().trim());

            formData.append(
                "itemQuantity",
                $("#itemQuantity").val().trim()
            );

            formData.append(
                "itemDescription",
                $("#itemDescription").val().trim()
            );

            formData.append(
                "effectiveDate",
                $("#kt_daterangepicker_1").val().trim()
            );

            formData.append(
                "activeFlag",
                $("#itemActive").is(":checked")
                    ? "Y"
                    : "N"
            );


            // ==========================================
            // Cover
            // ==========================================

            const coverInput =
                document.querySelector("#coverImage");


            if (coverChanged &&
                coverInput.files.length > 0) {

            	const originalFile = coverInput.files[0];
            	try {

            		const compressedCover = await compressImage(
            			originalFile,
            			1280,
            			1280,
            			0.8
            		);
            		
            		formData.append("cover", compressedCover);
                    formData.append("coverFileName", compressedCover.name);
            	
            	} catch (error) {
            		console.error("Image compression error:", error);
            		
            		Swal.fire({
            			title: "Error!",
            			text: "Unable to compress cover image.",
            			icon: "error",
            			confirmButtonText: "OK",
            			buttonsStyling: false,
            			customClass: {
            				confirmButton: "btn btn-primary"
            			}
            		});
            		
            		updateBtnState();
            		return;
            	}
            	 
            	
	            /* try {
	                const processedFile = await processAndRemoveWhiteBg(originalFile);

	                formData.append("cover", processedFile);
	                formData.append("coverFileName", processedFile.name);

	            } catch (error) {
	                console.error("Image processing error:", error);

	                Swal.fire({
	                    title: "Error!",
	                    text: "Unable to process cover image.",
	                    icon: "error",
	                    confirmButtonText: "OK",
	                    buttonsStyling: false,
	                    customClass: {
	                        confirmButton: "btn btn-primary"
	                    }
	                });

	                updateBtnState();
	                return;
	            }
 					*/
            }


            // ==========================================
            // New Additional Images
            // ==========================================
            	
            	for (const file of additionalImageFiles) {
				    try {
				        const compressedFile = await compressImage(
				            file,
				            1280,
				            1280,
				            0.8
				        );
				
				        formData.append("additionalImages", compressedFile);
				        formData.append("additionalImagesFileName", compressedFile.name);
				
				    } catch (error) {
				        console.error("Image compression error:", error);
				
				        Swal.fire({
				            title: "Error!",
				            text: "Unable to compress additional image: " + file.name,
				            icon: "error",
				            confirmButtonText: "OK",
				            buttonsStyling: false,
				            customClass: {
				                confirmButton: "btn btn-primary"
				            }
				        });
				
				        updateBtnState();
				        return;
				    }
				}

            /* additionalImageFiles.forEach(function (file) {

                formData.append(
                    "additionalImages",
                    file
                );

                formData.append(
                    "additionalImagesFileName",
                    file.name
                );

            }); */


            // ==========================================
            // Removed Existing Images
            // ==========================================
            	
            formData.append(
                "removedAdditionalImages",
                JSON.stringify(
                    removedAdditionalImages
                )
            );


            // ==========================================
            // Loading
            // ==========================================

            Swal.fire({

                title: "Updating...",

                text:
                    "Please wait while the reward item is being updated.",

                allowOutsideClick: false,

                allowEscapeKey: false,

                didOpen: function () {

                    Swal.showLoading();

                }

            });


            // ==========================================
            // AJAX
            // ==========================================

            $.ajax({

                url: "updateRewardItem",

                type: "POST",

                data: formData,

                processData: false,

                contentType: false,

                success: function (response) {

                    if (response.success) {

                        Swal.fire({

                            title: "Success!",

                            text:
                                response.message ||
                                "Reward item updated successfully.",

                            icon: "success",

                            confirmButtonText: "OK",

                            buttonsStyling: false,

                            customClass: {

                                confirmButton:
                                    "btn btn-success"

                            }

                        }).then(function () {

                            window.location.href =
                                "privilegeMangementPage";

                        });

                    } else {

                        Swal.fire({

                            title: "Unable to Update",

                            text:
                                response.message ||
                                "Unable to update reward item.",

                            icon: "error",

                            confirmButtonText: "OK",

                            buttonsStyling: false,

                            customClass: {

                                confirmButton:
                                    "btn btn-light"

                            }

                        });

                        updateBtnState();

                    }

                },

                error: function (xhr) {

                    console.error(xhr);


                    let message =
                        "Unable to update reward item.";


                    if (
                        xhr.responseJSON &&
                        xhr.responseJSON.message
                    ) {

                        message =
                            xhr.responseJSON.message;

                    }


                    Swal.fire({

                        title: "Error!",

                        text: message,

                        icon: "error",

                        confirmButtonText: "OK",

                        buttonsStyling: false,

                        customClass: {

                            confirmButton:
                                "btn btn-primary"

                        }

                    });


                    updateBtnState();

                }

            });

        });

    }


    // ==========================================
    // Parse Date
    // ==========================================

    function parseDate(value) {

        const parts =
            value.split(" ");


        if (parts.length !== 3) {
            return null;
        }


        const day =
            Number(parts[0]);

        const monthText =
            parts[1];

        const year =
            Number(parts[2]);


        const months = {

            Jan: 0,
            Feb: 1,
            Mar: 2,
            Apr: 3,
            May: 4,
            Jun: 5,
            Jul: 6,
            Aug: 7,
            Sep: 8,
            Oct: 9,
            Nov: 10,
            Dec: 11

        };


        if (
            !months.hasOwnProperty(monthText) ||
            !Number.isInteger(day) ||
            !Number.isInteger(year)
        ) {

            return null;

        }


        const date =
            new Date(
                year,
                months[monthText],
                day
            );


        if (
            date.getFullYear() !== year ||
            date.getMonth() !== months[monthText] ||
            date.getDate() !== day
        ) {

            return null;

        }


        return date;

    }


    // ==========================================
    // Document Ready
    // ==========================================

    $(document).ready(function () {


        // ==========================================
        // Flatpickr
        // ==========================================

/*         $("#kt_daterangepicker_1").flatpickr({

            mode: "range",

            dateFormat: "d M Y",

            locale: {

                rangeSeparator: " - "

            }

        });
         */
         
         $("#kt_daterangepicker_1").flatpickr({
        	    mode: "range",
        	    dateFormat: "d M Y",

        	    defaultDate: [
        	        new Date("${startDate}T00:00:00"),
        	        new Date("${endDate}T00:00:00")
        	    ],

        	    locale: {
        	        rangeSeparator: " - "
        	    }
        	});


        // ==========================================
        // Cover Image
        // ==========================================

        const imageInputElement =
            document.querySelector("#coverImageInput");


        const imageInput =
            KTImageInput.getInstance(
                imageInputElement
            );


        imageInput.on(
            "kt.imageinput.change",
            function () {

                coverChanged = true;

                validateCover();

            }
        );


        imageInput.on(
            "kt.imageinput.remove",
            
            function () {

                coverChanged = true;

                validateCover();

            }
        );


        imageInput.on(
            "kt.imageinput.cancel",
            function () {

                coverChanged = false;

                validateCover();

            }
        );


        // ==========================================
        // Input Validation
        // ==========================================

        $("#itemName")
            .on("input", validateItemName);


        $("#itemQuantity")
            .on("input", validateItemQuantity);
        
        $("#itemAddedMoney")
            .on("input", validateItemAddedMoney);


        $("#itemToken")
            .on("input", validateItemToken);


        $("#kt_daterangepicker_1")
            .on("change", validateEffectiveDate);


        // ==========================================
        // Render Existing Images
        // ==========================================

        renderAdditionalImages();


        // ==========================================
        // Initial Validation
        // ==========================================

        validateItemName.call(
            $("#itemName")
        );
        
        validateItemAddedMoney.call(
                $("#itemAddedMoney")
            );

        validateItemQuantity.call(
            $("#itemQuantity")
        );

        validateItemToken.call(
            $("#itemToken")
        );

        validateEffectiveDate.call(
            $("#kt_daterangepicker_1")
        );


        // Cover already exists on Update
        validationState.cover = true;


        updateBtnState();


        // ==========================================
        // Save button
        // ==========================================

        $("#saveBtn").click(function () {

            validateItemName.call(
                $("#itemName")
            );

            validateItemQuantity.call(
                $("#itemQuantity")
            );

            validateItemToken.call(
                $("#itemToken")
            );
            
            validateItemAddedMoney.call(
                    $("#itemAddedMoney")
                );

            validateEffectiveDate.call(
                $("#kt_daterangepicker_1")
            );

            validateCover.call(
                $("#coverImage")
            );


            if (
                Object.values(validationState)
                    .every(value => value === true)
            ) {

                submit();

            }

        });

    });

</script>
</body>
</html>