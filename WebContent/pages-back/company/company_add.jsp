<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
.image-input-placeholder {
	background-image:
		url('${pageContext.request.contextPath}/assets/media/svg/files/blank-image.svg');
}

/* Uncomment this to enable placeholder in dark mode */
/* [data-bs-theme="dark"] .image-input-placeholder {
	background-image:
		url('${pageContext.request.contextPath}/assets/media/svg/files/blank-image-dark.svg');
} */
.image-input-wrapper {
	/* Shadow */
	box-shadow: 0 4px 4px 0 rgba(0, 0, 0, 0.03);
}
</style>
</head>
<body>
	<!--begin::Main-->
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
						Company</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/check_in_out"
							class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/company_list"
							class="text-muted text-hover-primary">Company</a></li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Add</li>
					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container"
				class="app-container container-fluid">

				<div class="card ">
					<div class="card-header">
						<div class="card-title">
							<h3 class="fw-semibold m-0">Company Information</h3>
						</div>

						<div class="card-toolbar">
							<div
								class="form-check form-switch form-check-custom form-check-solid form-check-success">
								<label class="form-check-label me-3 fw-semibold"> Active
								</label> <input class="form-check-input h-20px w-30px" type="checkbox" checked
									form="companyForm" name="isActive" value="1" />
							</div>
						</div>
					</div>

					<div class="card-body">
						<form id="companyForm" action="create_company" method="POST"
							enctype="multipart/form-data">

							<!-- Logo Upload -->
							<div class="row mb-10">
								<div class="col-12">
									<div
										class="d-flex justify-content-center align-items-center flex-column mb-5">

										<!--begin::Image input-->
										<div
											class="image-input image-input-empty image-input-placeholder mb-3"
											data-kt-image-input="true">
											<!--begin::Image preview wrapper-->
											<div class="image-input-wrapper w-150px h-150px"></div>
											<!--end::Image preview wrapper-->

											<!--begin::Edit button-->
											<label
												class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow-sm"
												data-kt-image-input-action="change" data-bs-toggle="tooltip"
												data-bs-dismiss="click" title="Change company logo">
												<i class="ki-duotone ki-pencil fs-6"><span class="path1"></span><span
													class="path2"></span></i> <!--begin::Inputs--> <input
												type="file" name="logo" accept=".png, .jpg, .jpeg" /> <input
												type="hidden" name="logo_remove" /> <!--end::Inputs-->
											</label>
											<!--end::Edit button-->

											<!--begin::Cancel button-->
											<span
												class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow-sm"
												data-kt-image-input-action="cancel" data-bs-toggle="tooltip"
												data-bs-dismiss="click" title="Cancel logo"> <i
												class="ki-outline ki-cross fs-3"></i>
											</span>
											<!--end::Cancel button-->

											<!--begin::Remove button-->
											<span
												class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow-sm"
												data-kt-image-input-action="remove" data-bs-toggle="tooltip"
												data-bs-dismiss="click" title="Remove logo"> <i
												class="ki-outline ki-cross fs-3"></i>
											</span>
											<!--end::Remove button-->
										</div>
										<!--end::Image input-->

										<div class="text-muted fs-6 mt-3">Allowed file types:
											png, jpg, jpeg</div>
									</div>
								</div>
							</div>

							<!-- Row 1 -->
							<div class="row g-6 mb-6">

								<div class="col-md-6 company-code-container">
									<label class="required form-label"> Company Code </label>
									<div class="position-relative">
										<input type="text" id="company-code"
											class="form-control pe-10" value="${company.companyCode}"
											name="companyCode"> <i id="company-code-valid-icon"
											class="ki-duotone ki-check-circle fs-1 text-success position-absolute top-50 end-0 translate-middle-y me-4 d-none">
											<span class="path1"></span> <span class="path2"></span>
										</i>
									</div>
								</div>

								<div class="col-md-6 company-tax-number-container">
									<label class="form-label required"> Tax ID </label> <input type="text"
										class="form-control" name="taxNumber" id="company-tax-number">
								</div>

							</div>

							<!-- Row 2 -->
							<div class="row g-6 mb-6 ">

								<div class="col-md-6 company-name-en-container">
									<label class="form-label required"> Company Name EN </label> <input
										type="text" class="form-control" name="nameEN"
										id="company-name-en">
								</div>

								<div class="col-md-6 company-name-th-container">
									<label class="form-label required"> Company Name TH </label> <input
										type="text" class="form-control" name="nameTH"
										id="company-name-th">
								</div>

							</div>

							<!-- Row 3 -->
							<div class="row g-6">

								<div class="col-md-6 ">
									<label class="form-label required"> Industry </label> <select id="company-industry"
										class="form-select" data-control="select2" data-hide-search="true" data-placeholder="Select an option" name="industry">
										<option></option>
										<option value="IT">IT</option>
										<option value="Finance">Finance</option>
										<option value="Retail">Retail</option>
										<option value="Manufacturing">Manufacturing</option>

									</select>
								</div>

							</div>

						</form>

					</div>
				</div>

				<!-- Footer Button -->
				<div class="d-flex justify-content-end gap-3 mt-8">

					<button type="button" onclick="location.href='company_list'"
						class="btn btn-light">Close</button>

					<button type="submit" form="companyForm" class="btn btn-success"
						id="submit-btn">Save</button>

				</div>
			</div>

		</div>

	</div>

	<script
		src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>
	<script type="text/javascript">
	
		const validationState = {
			    companyCode: false,
			    companyNameEn: false,
			    companyNameTh: false,
			    taxNumber: false,
			    industry: false
		};
	
		let companyCodeExists = false;
	
		function setFieldInvalid(selector, message) {
	
		    const input = $(selector);
	
		    input.addClass("is-invalid");
	
		    const container = input.closest("[class*='container']");
	
		    let feedback = container.find(".invalid-feedback");
	
		    if (!feedback.length) {
		        feedback = $('<div class="invalid-feedback d-block"></div>');
		        container.append(feedback);
		    }
	
		    feedback.text(message);
		}
		
		function clearFieldError(selector) {
	
		    const input = $(selector);
	
		    input.removeClass("is-invalid");
	
		    input.closest("[class$='-container']")
		         .find(".invalid-feedback")
		         .remove();
		}
		
		/* debounce function */
		function debounce(fn, delay) {
		    let timer;
		
		    return function (...args) {
		
		        const context = this;
		
		        clearTimeout(timer);
		
		        timer = setTimeout(() => {
		            fn.apply(context, args);
		        }, delay);
		    };
		}
		
		function hasValidationErrors() {

		    return Object.values(validationState)
		                 .some(valid => !valid);
		}
		
	</script>
	<script type="text/javascript">
		let isSubmitting = false;
		
		$(document).ready(function(){
			$("#company-code").on(
				    "input",
				    debounce(validateCompanyCode, 500)
			);
			
 			$("#company-name-en").on(
				    "input",
				    debounce(validateCompanyEnName, 300)
			);
			
			$("#company-name-th").on(
				    "input",
				    debounce(validateCompanyThName, 300)
			);
			
			$("#company-industry").on(
				    "input",
				    debounce(validateIndustry, 300)
			);
			
			$("#submit-btn").on("click", function (e) {

			    e.preventDefault();

			    if (isSubmitting) {
			        return;
			    }

			    validateCompanyCode.call($("#company-code"));
			    validateCompanyEnName.call($("#company-name-en"));
			    validateCompanyThName.call($("#company-name-th"));
			    validateTaxNumber.call($("#company-tax-number"));
			    validateIndustry.call($("#company-industry"));

			    if (!hasValidationErrors()) {

			        isSubmitting = true;

			        $(this)
			            .prop("disabled", true)
			            .addClass("disabled");

			        $("#companyForm").submit();
			    }
			});
			
			
			$("#company-tax-number").on("input", function () {
			    this.value = this.value.replace(/\D/g, "");
			    validateTaxNumber.call(this);
			});
			
			
			
			function validateCompanyEnName() {

			    const value = $(this).val().trim();
			    
			    if (value === "" || value.length === 0) {
					validationState.companyNameEn = false;
					setFieldInvalid(
				            "#company-name-en",
				            "Company name EN is required"
				        );
				    updateBtnState();
			        return;
			    }

			    const regex = /^[A-Za-z0-9\s.,&()\/'@+_-]+$/;

			    if (!regex.test(value)) {
			    	validationState.companyNameEn = false;
			        setFieldInvalid(
			            "#company-name-en",
			            "Only English letters are allowed"
			        );
			        updateBtnState();
			        return;
			    }
			    validationState.companyNameEn = true;
			    clearFieldError("#company-name-en");
			    updateBtnState();
			    return;
			}
			
			
			function validateCompanyCode() {

			    const input = $(this);
			    const code = input.val().trim();
			    
			    if (!code) {
			        companyCodeExists = false;
			        $("#company-code-valid-icon").addClass("d-none");
			        
			        validationState.companyCode = false;
			        
			        setFieldInvalid(
		                    "#company-code",
		                    "Company code is required"
		                );
			        
			        updateBtnState()
			        return;
			    }

			    $.ajax({
			        url: "check_company_code",
			        type: "GET",
			        data: {
			            companyCode: code,
			            companyId: null
			        },
			        success: function(res) {

			            const result =
			                typeof res === "string"
			                    ? JSON.parse(res)
			                    : res;

			            companyCodeExists = result.exists;

			            if (result.exists) {
			            	validationState.companyCode = false;
			                setFieldInvalid(
			                    "#company-code",
			                    "This company code already exists"
			                );

			                $("#company-code-valid-icon")
			                    .addClass("d-none");

			            } else {
			            	validationState.companyCode = true;
			                clearFieldError("#company-code");

			                $("#company-code-valid-icon")
			                    .removeClass("d-none");
			            }
			            updateBtnState();
			        }
			    });
			    
			    
			}
			
			function validateCompanyThName() {

			    const value = $(this).val().trim();

			    if (value === "" || value.length === 0) {
			        validationState.companyNameTh = false;
			        setFieldInvalid(
				            "#company-name-th",
				            "Company name is required"
				     );
			        updateBtnState();
			        return
			    }

			    const regex = /^[ก-๙0-9\s().,&/-]+$/;

			    if (!regex.test(value)) {
			        validationState.companyNameTh = false;
			        setFieldInvalid(
			            "#company-name-th",
			            "Only Thai characters are allowed"
			        );
			    } else {
			        validationState.companyNameTh = true;
			        clearFieldError("#company-name-th");
			    }
			    updateBtnState();
			    return
			}
			
			function validateTaxNumber() {
				const value = $(this).val().trim();
				console.log(value)

			    if (value === "") {

			        validationState.taxNumber = false;
			        setFieldInvalid(
				            "#company-tax-number",
				            "Tax ID is required"
				     );
			        updateBtnState();
			        return
			    }

			    if (!/^\d{1,13}$/.test(value)) {

			        validationState.taxNumber = false;
			        
			        console.log(value)

			        setFieldInvalid(
			            "#company-tax-number",
			            "Tax ID must contain 1-13 digits"
			        );
			        
			    } else {
			        validationState.taxNumber = true;
			        clearFieldError("#company-tax-number");
			    }
			    updateBtnState();
				return
			}
			
			function validateIndustry() {

			    const value = $("#company-industry").val();
			    console.log(value)

			    if (!value) {
			        validationState.industry = false;
			        setFieldInvalid(
			            "#company-industry",
			            "Please select an industry"
			        );
			    } else {
			        validationState.industry = true;
			        clearFieldError("#company-industry");
			    }
			    updateBtnState();
			    return
			}
			
			function updateBtnState() {
			    $("#submit-btn").prop(
			        "disabled",
			        hasValidationErrors()
			    );
			}
			updateBtnState();
		});
	</script>
</body>
</html>