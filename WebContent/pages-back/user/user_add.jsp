<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/style.bundle.css"
	rel="stylesheet" />

<style>
#password.is-invalid,
#confirm_password.is-invalid {
    background-image: none !important;
}
</style>

</head>

<body class="app-default">
	<div class="app-main flex-column flex-row-fluid">
		<div class="d-flex flex-column flex-column-fluid">
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container"
					class="app-container container-fluid d-flex flex-stack">
					<div
						class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<h1
							class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
							Add Employee Profile</h1>
						<ul
							class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/demo_dashboard"
								class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/user-list"
								class="text-muted text-hover-primary">Admin Management </a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted">Employee Profile</li>
						</ul>
					</div>
				</div>
			</div>

			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container"
					class="app-container container-fluid">

					<form action="user-perform-add" method="post" autocomplete="off"
						id="userAddForm" enctype="multipart/form-data" novalidate>
						<div class="card border-2">
							<div
								class="card-header d-flex align-items-center justify-content-between py-4">
								<h3 class="card-title fw-semibold text-gray-900 mb-0">Account
									Info</h3>
								<div
									class="d-flex align-items-center gap-2 fw-semibold text-gray-900">
									<span>Active</span> <label
										class="form-check form-switch form-check-success form-check-solid m-0">
										<input class="form-check-input h-20px w-35px" type="checkbox"
										name="user.enable" checked />
									</label>
								</div>
							</div>

							<div class="card-body py-10">
								<div class="row mb-16">
								<div id="errorMsgProfile" class="text-center text-danger mb-3"></div>
								<div class="d-flex flex-column align-items-center">
									<div class="image-input image-input-outline"
										data-kt-image-input="true"
										style="background-image: url(${pageContext.request.contextPath}/assets/media/svg/avatars/blank.svg)">

										<div class="image-input-wrapper w-150px h-150px"
											style="background-image: url(${pageContext.request.contextPath}/assets/media/svg/avatars/blank.svg)">
										</div>

										<label
											class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow"
											data-kt-image-input-action="change" data-bs-toggle="tooltip"
											title="Change avatar"> <i
											class="ki-duotone ki-pencil fs-6"><span class="path1"></span><span
												class="path2"></span></i> 
												<input type="file" name="fileUpload" id="imageInputFile"
											accept=".png, .jpg, .jpeg" /> <input type="hidden" id="avatarRemoveHidden"
											name="avatar_remove" />
										</label> <span
											class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow"
											data-kt-image-input-action="cancel" data-bs-toggle="tooltip"
											title="Cancel avatar"> <i
											class="ki-outline ki-cross fs-3"></i>
										</span> <span
										  class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow d-none"
										  data-kt-image-input-action="remove" title="Remove avatar" id="avatarRemoveBtn">
										  <i class="ki-outline ki-cross fs-3"></i>
										</span>

									</div>
									
								</div>
								<div
									class="form-text fs-7 text-muted fw-medium mt-6 mb-0  d-flex justify-content-center">Allowed
									file types: png, jpg, jpeg.</div>
							</div>

								<div class="row g-8">
									<div class="col-12 col-md-6">
										<label class="form-label fw-semibold text-gray-800 required">User
											ID</label>
										<div class="position-relative">
											<input id="userid" name="user.id" type="text"
												class="form-control userinfo pe-12" placeholder="User ID" required data-label="User ID" />

											<div
												class="position-absolute top-50 end-0 translate-middle-y me-3 d-none icon-wrapper"
												id="userIdLoading">
												<span class="spinner-border spinner-border-sm text-primary"
													role="status"></span>
											</div>

											<div
												class="position-absolute top-50 end-0 translate-middle-y me-3 d-none icon-wrapper"
												id="userIdCheck">
												<i class="ki-duotone ki-check-circle fs-1 text-success">
													<span class="path1"></span> <span class="path2"></span>
												</i>
											</div>
										</div>
										<div id="hintUserId" class="text-danger fs-8 mt-1 d-none">This
											ID is already taken</div>
									</div>

									<div class="col-12 col-md-6">
										<label for="date_s" class="form-label fw-semibold required">
											Start Working Date </label>
										<div class="position-relative">
											<i
												class="ki-duotone ki-calendar-8 fs-2 text-gray-500 position-absolute top-50 start-0 translate-middle-y ms-4">
												<span class="path1"></span><span class="path2"></span> <span
												class="path3"></span><span class="path4"></span> <span
												class="path5"></span><span class="path6"></span>
											</i> <input type="text" id="date_s" name="startDate"
												class="form-control ps-12 userinfo" placeholder="1 Jan 2025"
												autocomplete="off" required data-label="Start Working Date" />
										</div>
									</div>

									<div class="col-12 col-md-6">
										<label for="roleId" class="form-label fw-semibold required">Role</label>
										<select class="form-select userinfo" name="user.roleId"  required data-label="Role"
											data-control="select2" data-hide-search="true" id="roleId">
											<option value="">Select</option>
											<c:forEach var="role" items="${roleList}">
												<option value="${role.id}">${role.id} ${empty role.name ? '' : ' - '}${role.name}</option>
											</c:forEach>
										</select>
										<div id="hintRole" class="text-danger fs-8 mt-1 d-none">Please
											select a role</div>
									</div>

									<div class="col-12 col-md-6 d-flex align-items-center">
										<div class="w-100">
											<label
												class="form-label fw-semibold text-gray-800 me-3 mb-2 required">Gender</label>
											<div class="d-flex h-50 align-items-center gap-4">
												<label class="form-check form-check-custom"> <input
													class="form-check-input me-2 userinfo" type="radio" required data-label="Gender"
													name="user.gender" value="M" /> <span
													class="form-check-label text-gray-800">Male</span>
												</label> <label class="form-check form-check-custom m-0"> <input
													class="form-check-input me-2 userinfo" type="radio" required data-label="Gender"
													name="user.gender" value="F" /> <span
													class="form-check-label text-gray-800">Female</span>
												</label>
											</div>
											<div id="hintGender" class="text-danger fs-8 mt-1 d-none">Please
												select gender</div>
										</div>
									</div>

									<div class="col-12 d-flex gap-4">
										<div class="flex-shrink-0" style="width: 160px;">
											<label for="titleNameTH"
												class="form-label fw-semibold text-gray-800 required">คำนำหน้า</label>
											<select class="form-select userinfo" name="user.titleNameTH" 
												id="titleNameTH" data-control="select2" data-label="คำนำหน้า"
												data-hide-search="true" required>
												<option value="">Select</option>
												<option value="นาย">นาย</option>
												<option value="นาง">นาง</option>
												<option value="นางสาว">นางสาว</option>
											</select>
											<div id="hintTitleTh" class="text-danger fs-8 mt-1 d-none">Please
												select a title</div>
										</div>
										<div class="flex-grow-1">
											<label for="name"
												class="form-label fw-semibold text-gray-800 required">ชื่อ
												- สกุล</label> <input type="text" id="name" name="user.name"
												class="form-control userinfo" maxlength="190" data-label="ชื่อ - สกุล"
												placeholder="ชื่อ - สกุล" required />
											<div id="hintNameTh" class="text-danger fs-8 mt-1 d-none">Please
												enter full name</div>
										</div>
									</div>

									<div class="col-12">
										<div class="d-flex flex-column flex-md-row gap-4">
											<div class="flex-shrink-0" style="width: 160px;">
												<label for="titleNameEN"
													class="form-label fw-semibold text-gray-800 required">Title
													Name</label> <select class="form-select userinfo"
													name="user.titleNameEN" id="titleNameEN"  data-label="Title Name"
													data-control="select2" data-hide-search="true" required>
													<option value="">Select</option>
													<option value="Mr.">Mr.</option>
													<option value="Mrs.">Mrs.</option>
													<option value="Ms.">Ms.</option>
												</select>
												<div id="hintTitleEn" class="text-danger fs-8 mt-1 d-none">Please
													select a title</div>
											</div>
											<div class="flex-grow-1">
												<label for="nameEN"
													class="form-label fw-semibold text-gray-800 required">Full
													Name EN</label> <input type="text" id="nameEN" name="user.nameEN"
													class="form-control userinfo" maxlength="190" data-label="Full Name"
													placeholder="Name - Surname" required />
												<div id="hintNameEn" class="text-danger fs-8 mt-1 d-none">Please
													enter name</div>
											</div>
										</div>
									</div>

									<div class="col-12 col-md-6">
										<label for="nickName"
											class="form-label fw-semibold text-gray-800">Nickname
											TH</label> <input type="text" id="nickName" name="user.nickName"
											class="form-control" maxlength="32" 
											placeholder="ชื่อเล่น (ไทย)" />
									</div>
									<div class="col-12 col-md-6">
										<label for="nickNameEN"
											class="form-label fw-semibold text-gray-800">Nickname
											EN</label> <input type="text" id="nickNameEN" name="user.nickNameEN"
											class="form-control" maxlength="32" 
											placeholder="Nickname (EN)" />
									</div>

									<div class="col-12 col-md-6">
										<label class="form-label fw-semibold text-gray-800 required">Department</label>
										<select class="form-select userinfo" name="user.departmentId" data-label="Department"
											data-control="select2" data-hide-search="true" required>
											<option value="">Select</option>
											<c:forEach var="department" items="${departmentList}">
												<option value="${department.id}">${department.id} ${empty department.description ? '' : ' - '}${department.description}</option>
											</c:forEach>
										</select>
										<div id="hintDept" class="text-danger fs-8 mt-1 d-none">Please
											select a department</div>
									</div>

									<div class="col-12 col-md-6">
										<label class="form-label fw-semibold text-gray-800 required">Position</label>
										<select class="form-select userinfo" name="user.positionId" data-label="Position"
											data-control="select2" data-hide-search="true" required>
											<option value="">Select</option>
											<option value="none">None</option>
											<c:forEach var="position" items="${positionList}">
												<option value="${position.position_id}">${position.name}</option>
											</c:forEach>
										</select>
										<div id="hintPosition" class="text-danger fs-8 mt-1 d-none">Please
											select a position</div>
									</div>

									<div class="col-12 col-md-6">
										<label class="form-label fw-semibold text-gray-800 required">E-Mail</label>
										<input type="email" name="user.email"  data-label="E-Mail"
											class="form-control userinfo" maxlength="50"
											placeholder="name@example.com" required>
										<div id="hintEmail" class="text-danger fs-8 mt-1 d-none">Please
											enter a valid email</div>
									</div>

									<div class="col-12 col-md-6">
										<label class="form-label fw-semibold text-gray-800 required">Phone
											Number</label> <input type="text" name="user.phonenum" id="phone"
											class="form-control userinfo" maxlength="10"  data-label="Phone Number"
											pattern="[0-9]{10}" placeholder="0xxxxxxxxx" required>
										<div id="hintPhone" class="text-danger fs-8 mt-1 d-none">Please
											enter a phone number</div>
									</div>

									<div class="col-12 col-md-6 w-100">
										<label for="address"
											class="form-label fw-semibold text-gray-800">Address</label>
										<textarea id="address" name="user.address"
											class="form-control w-100" rows="3" maxlength="255"></textarea>
									</div>

								</div>
							</div>
						</div>

						<div class="card mb-10 mt-12 border-2">
							<div class="card-header">
								<h3 class="card-title fw-semibold text-gray-900 m-0">Setting For Working</h3>
							</div>
							<div class="card-body pt-6">
								<div class="row g-8">
									<div class="col-md-6 fv-row mb-6">
										<label class="required form-label">Working Day</label>
										<div class="d-flex align-items-stretch gap-3">
											<select class="form-select flex-fill userinfo" data-control="select2"
												data-hide-search="true" name="user.workDayStart" required data-label="Work Day Start"
												id="workDayStart">
												<option value="1" selected>Mon</option>
												<option value="2">Tue</option>
												<option value="3">Wed</option>
												<option value="4">Thu</option>
												<option value="5">Fri</option>
												<option value="6">Sat</option>
												<option value="7">Sun</option>
											</select> <span class="d-flex align-items-center">to</span> <select
												class="form-select flex-fill userinfo" data-control="select2" required data-label="Work Day End"
												data-hide-search="true" name="user.workDayEnd"
												id="workDayEnd">
												<option value="1">Mon</option>
												<option value="2">Tue</option>
												<option value="3">Wed</option>
												<option value="4">Thu</option>
												<option value="5" selected>Fri</option>
												<option value="6">Sat</option>
												<option value="7">Sun</option>
											</select>
										</div>
									</div>

									<div class="col-md-6 fv-row mb-6">
										<label class="required form-label">Working Hour</label>
										<div class="d-flex align-items-stretch gap-3">
											<select class="form-select flex-fill userinfo" data-control="select2"
												data-hide-search="true" id="workTimeStart" required data-label="Working Hour Start"
												name="user.workTimeStart">
												<option value="8:00">8:00</option>
												<option value="8:30">8:30</option>
												<option value="9:00" selected>9:00</option>
											</select> <span class="d-flex align-items-center text-muted">to</span>
											<select class="form-select flex-fill userinfo" data-control="select2"
												data-hide-search="true" id="workTimeEnd" required data-label="Working Hour End"
												name="user.workTimeEnd">
												<option value="17:00">17:00</option>
												<option value="17:30">17:30</option>
												<option value="18:00" selected>18:00</option>
											</select>
										</div>
									</div>

									<div class="col-md-6 fv-row">
										<label class="required form-label">Default Working</label>
										<div class="mt-2">
											<label class="form-check form-check-custom mb-6 mt-6">
												<input class="form-check-input userinfo" type="radio" required data-label="Default Working"
												name="user.workType" value="1" checked> <span
												class="form-check-label text-gray-800">On-Site</span>
											</label> <label class="form-check form-check-custom mb-6 mt-6">
												<input class="form-check-input userinfo" type="radio" required data-label="Default Working"
												name="user.workType" value="2"> <span
												class="form-check-label text-gray-800">WFH</span>
											</label>
											<label class="form-check form-check-custom mb-6 mt-6">
												<input class="form-check-input userinfo" type="radio" required data-label="Default Working"
												name="user.workType" value="3"> <span
												class="form-check-label text-gray-800">Head Office</span>
											</label>
											
										</div>
									</div>

									<div class="col-md-6 fv-row">
										<label class="required form-label">Number of On-Site
											Days</label>
										<div class="mt-2">
											<label class="form-check form-check-custom mb-6 mt-6">
												<input class="form-check-input userinfo" type="radio" required data-label="Number of On-Site Days"
												name="user.onsiteNum" value="3" checked> <span
												class="form-check-label text-gray-800 fw-500">4 - 5
													days (On-Site)</span>
											</label> <label class="form-check form-check-custom mb-6 mt-6">
												<input class="form-check-input userinfo" type="radio" required data-label="Number of On-Site Days"
												name="user.onsiteNum" value="2"> <span
												class="form-check-label text-gray-800 fw-500">2 - 3
													days (Hybrid)</span>
											</label> <label class="form-check form-check-custom mb-6 mt-6">
												<input class="form-check-input userinfo" type="radio" required data-label="Number of On-Site Days"
												name="user.onsiteNum" value="1"> <span
												class="form-check-label text-gray-800 fw-500">0.5 - 1
													day (WFH)</span>
											</label>
										</div>
									</div>
								</div>

							</div>
						</div>

						<div class="card mb-10 mt-12 border-2" id="securityInfoCard">
							<div class="card-header">
								<h3 class="card-title fw-semibold text-gray-900 m-0">Security</h3>
							</div>
							<div class="card-body pt-6">
								<div class="row g-9">
									<div class="col-md-6 fv-row">
										<label class="required form-label">New Password</label>
										<div class="position-relative">
											<input type="password" class="form-control userinfo" name="password"
												id="password" placeholder="New password" required data-label="New Password"
												autocomplete="new-password" oninput="validateNewPassword();"
												minlength="6" /> <span
												class="btn btn-sm btn-icon position-absolute top-50 end-0 translate-middle-y toggle-password"
												data-eye-target="password"> <i
												class="ki-duotone ki-eye-slash fs-2"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span> <span class="path4"></span>
											</i> <i class="ki-duotone ki-eye fs-2 d-none"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span> <span class="path4"></span>
											</i>
											</span>
										</div>
										<!-- <input
											type="password" class="form-control" name="password"
											id="newPassword" placeholder="Enter password"
											autocomplete="new-password" required /> -->
									</div>

									<div class="col-md-6 fv-row">
										<label class="required form-label">Confirm New
											Password</label>
										<div class="position-relative">
											<input type="password" class="form-control userinfo"
												name="confirm_password" id="confirm_password"
												placeholder="Confirm password" required data-label="Confirm New Password"
												oninput="validateConfirmPassword()" minlength="6" /> 
												<span
												class="btn btn-sm btn-icon position-absolute top-50 end-0 translate-middle-y toggle-password "
												data-eye-target="confirm_password"> <i
												class="ki-duotone ki-eye-slash fs-2"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span> <span class="path4"></span>
											</i> <i class="ki-duotone ki-eye fs-2 d-none"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span> <span class="path4"></span>
											</i>
											</span>
										</div>
										<!--  <input type="password" class="form-control"
											id="confirmPassword" placeholder="Confirm password" required /> -->
										<span id="confirmNewPwError"
											class="text-danger fs-7 fw-medium d-none mt-2 mb-0">
											The password is incorrect. Please enter it again.</span>
										<!-- <div id="passwordMatchMessage" class="mt-2 fw-semibold fs-7"></div> -->
									</div>
								</div>
								<p id="pwPattern" class="fs-6 fw-normal text-muted mt-4 mb-0">Password
									must be at least 6 character.</p>
							</div>
						</div>
<div class="text-end mt-10 d-flex justify-content-end gap-6">
						<button type="button" class="btn btn-light" id="btnCancel">Cancel</button>
						<button type="submit" class="btn btn-success" id="btnSubmit">Save</button>
					</div>
					</form>

					

				</div>
			</div>
		</div>
	</div>

	<script
		src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>

	<script>
	document.addEventListener('DOMContentLoaded', function () {
		toggleEyeIcon();
		const fileInput = document.getElementById("imageInputFile");  
		const errorMsgProfile = document.getElementById("errorMsgProfile");
		const removeBtn = document.querySelector('[data-kt-image-input-action="remove"]');
	    const removeHidden = document.getElementById('avatarRemoveHidden');
	    const clearError = () => {
	        if (errorMsgProfile) errorMsgProfile.textContent = "";
	    };
	    
	    fileInput.addEventListener("change", function () { 	
	        const file = this.files[0];
	        const maxSize = 2 * 1024 * 1024;
	        
	        if (!file) return;

	        if (file.size > maxSize) {
	        	errorMsgProfile.textContent = "Image must be smaller than 2MB.";
	            this.value = "";
	            return;
	        } 
	        
	        if (removeHidden) removeHidden.value = "false";
	        clearError();
	       
	    });
	    
	    if (removeBtn) {
	        removeBtn.addEventListener("click", function() {
	            removeHidden.value = "true";
	            fileInput.value = "";
	        	clearError();
	        });
	    }
	    const cancelBtn = document.querySelector('[data-kt-image-input-action="cancel"]');
	    if (cancelBtn) {
	        cancelBtn.addEventListener("click", clearError);
	    }
	});
	
(function () {
    const $doc = $(document);


    function debounce(fn, delay) {
        let t = null;
        return function (...args) {
            clearTimeout(t);
            t = setTimeout(() => fn.apply(this, args), delay);
        };
    }

    function markInvalid($el, hintSelector, isInvalid) {
        $el.toggleClass('is-invalid', !!isInvalid);

        if (hintSelector) {
            $(hintSelector).toggleClass('d-none', !isInvalid);
        }

        if ($el.hasClass('select2-hidden-accessible')) {
            const $selection = $el
                .next('.select2-container')
                .find('.select2-selection');

            $selection.toggleClass('border-danger', !!isInvalid);
        }
    }

    function updateTitles(gender) {
        const $th = $('#titleNameTH');
        const $en = $('#titleNameEN');

        $th.find('option').prop('disabled', false);
        $en.find('option').prop('disabled', false);

        if (gender === 'M') {
            $th.find('[value="นาง"], [value="นางสาว"]').prop('disabled', true);
            $en.find('[value="Mrs."], [value="Ms."]').prop('disabled', true);
        } else if (gender === 'F') {
            $th.find('[value="นาย"]').prop('disabled', true);
            $en.find('[value="Mr."]').prop('disabled', true);
        }

        $th.trigger('change.select2');
        $en.trigger('change.select2');
    }

    function updateGender(title) {
        let gender = '';
        if (['นาย', 'Mr.'].includes(title)) gender = 'M';
        if (['นาง', 'นางสาว', 'Mrs.', 'Ms.'].includes(title)) gender = 'F';

        if (gender) {
            $(`input[name="user.gender"][value="${gender}"]`).prop('checked', true);
            updateTitles(gender);
        }
    }

    $('input[name="user.gender"]').on('change', function () {
        updateTitles(this.value);
    });

    $('#titleNameTH, #titleNameEN').on('change', function () {
        if ($(this).val()) updateGender($(this).val());
    });

    if (typeof flatpickr === 'function') {
        flatpickr('#date_s', {
        	 dateFormat: "Y-m-d",  
             altInput: true,
             altFormat: "d M Y",   
             locale: "en",        
             allowInput: false
        });
    }

    /* =========================
       Input Filters
    ========================== */
    $('#name, #nickName').on('keypress', e =>
        /^[\u0E00-\u0E7F\s]$/.test(e.key) || e.preventDefault()
    );

    $('#nameEN, #nickNameEN').on('keypress', e =>
        /^[a-zA-Z\s]$/.test(e.key) || e.preventDefault()
    );

    $('#userid').on('keypress', e =>
        /^[A-Za-z.]$/.test(e.key) || e.preventDefault()
    );
    $('#userid').on('input', function () {
        let val = this.value.trim();

        if (val && !/^[A-Za-z]/.test(val)) {
            val = val.replace(/^[^A-Za-z]+/, '');
        }

        val = val.replace(/[^A-Za-z.]/g, '');

        this.value = val;
    });


    $('#phone').on('keypress', e =>
        /^[0-9]$/.test(e.key) || e.preventDefault()
    );

    const checkUserId = debounce(function () {
        const $user = $('#userid');
        const user = $user.val().trim();
        const $loading = $('#userIdLoading');
        const $check = $('#userIdCheck');
        const $hint = $('#hintUserId');

        $check.addClass('d-none');
        $hint.addClass('d-none');

        if (!user) return;

        $loading.removeClass('d-none');

        $.ajax({
            url: 'user_noti',
            method: 'POST',
            data: { 'user.id': user },
            success(data) {
                $loading.addClass('d-none');

                if (String(data).includes('1')) {
                    markInvalid($user, null, true);
                    $hint.removeClass('d-none');
                } else {
                    markInvalid($user, null, false);
                    $check.removeClass('d-none');
                }
            },
            error() {
                $loading.addClass('d-none');
                Swal.fire('Error', 'Cannot check username', 'error');
            }
        });
    }, 500);

    $('#userid').on('blur', checkUserId);
    $('#userid').on('input', () => $('#userIdCheck').addClass('d-none'));


    $('.userinfo').on('input change blur select2:select select2:clear', function () {
        const val = $(this).val();
        const empty = !val;
        markInvalid($(this), null, empty);
    });

    

    $('#userAddForm').on('submit', function (e) {
        e.preventDefault();

        let ok = true;
        let errorFields = [];
        
        const errorMsgProfile = document.getElementById("errorMsgProfile");
		  if (errorMsgProfile && errorMsgProfile.textContent.trim() !== "") {
			  window.scrollTo({
			        top: 0,
			        behavior: "smooth"
			    });
			  return false; 
		  }

        $('.userinfo:input[required]:not(.flatpickr-input)').each(function () {
            const $el = $(this);

            const label =
                $el.data('label') ||
                $('label[for="' + $el.attr('id') + '"]').text().trim() ||
                $el.closest('.col-12, .col-md-6, .fv-row')
                   .find('label.form-label:first')
                   .text().trim() ||
                'Unknown field';

            const val = $el.val();
            const empty = $el.is('select')
                ? !val
                : !String(val || '').trim();

            markInvalid($el, null, empty);

            if (empty) {
                ok = false;
                errorFields.push(label);
            }
        });


        const genderOk = $('input[name="user.gender"]:checked').length > 0;
        $('#hintGender').toggleClass('d-none', genderOk);
        if (!genderOk) {
            ok = false;
            errorFields.push('Gender');
        }

        const $email = $('input[name="user.email"]');
        if ($email.val() && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test($email.val())) {
            markInvalid($email, '#hintEmail', true);
            ok = false;
            errorFields.push('Valid Email');
        }

        const $phone = $('#phone');
        if ($phone.val() && !/^\d{10}$/.test($phone.val())) {
            markInvalid($phone, '#hintPhone', true);
            ok = false;
            errorFields.push('Phone Number');
        }

        const pwOk = validateNewPassword();
        const cfOk = validateConfirmPassword();
        if (!pwOk || !cfOk) {
            ok = false;
         
        }

        if (!ok) {
            Swal.fire({
            	title: "Please complete the form!",
	            html: "Please fill in the following fields:<br><strong>" + errorFields.join(", ") + "</strong>",
	            icon: "error",
	            confirmButtonText: "OK",
                buttonsStyling: false,
                customClass: { confirmButton: "btn btn-danger" }
            });

            const $first = $('.is-invalid, .border-danger').first();
            if ($first.length) {
                $('html, body').animate({
                    scrollTop: $first.offset().top - 100
                }, 500);
            }
            return;
        }

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
                this.submit();
            }
        });
    });

    /* $('#btnCancel').on('click', () => location.href = 'user-list'); */
    $('#btnCancel').on('click', function () {
    Swal.fire({
        title: "Are you sure?!",
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
            location.href = 'user-list';
        }
    });
});

    /* $('#btnSubmit').on('click', () => $('#userAddForm').submit()); */

})();
</script>

	<script>
	function toggleEyeIcon(){
		document.querySelectorAll(".toggle-password").forEach(btn =>{
			
			if (btn.dataset.bound === "true") return;
		    btn.dataset.bound = "true";
		    
			btn.addEventListener("click", function(){
				const input =document.getElementById(this.dataset.eyeTarget);
				

			      const eyeSlash = this.querySelector(".ki-eye-slash");
			      const eye = this.querySelector(".ki-eye");

			      if (input.type === "password") {
			        input.type = "text";
			        eyeSlash.classList.add("d-none");
			        eye.classList.remove("d-none");
			        this.classList.add("active-eye");
			      } else {
			        input.type = "password";
			        eye.classList.add("d-none");
			        eyeSlash.classList.remove("d-none");
			        this.classList.remove("active-eye");
			      }  
			})
			
		})
	}
	
	
	function validateNewPassword() {
		const pwEl = document.getElementById("password");
	    const password = document.getElementById("password").value.trim();
	    const pattern = /^\S{6,}$/;
	    
	    if (password === "") {
	    	pwEl.classList.add("is-invalid");
	    	setPwPattern("error");
	        return false;
	    }

	    if (!pattern.test(password)) {
	    	pwEl.classList.add("is-invalid");
	        setPwPattern("error");  
	        return false;
	    }

	    pwEl.classList.remove("is-invalid");
	    setPwPattern("normal");
	    return true;
	}
	
	function validateConfirmPassword() {
	    const password = document.getElementById("password").value.trim();
	    const confirmPassword = document.getElementById("confirm_password");
	    const errorEl = document.getElementById("confirmNewPwError");

	    if (confirmPassword.value.trim() === "") {
	    	confirmPassword.classList.add("is-invalid");
	        errorEl.classList.add("d-none");
	        return true;
	    }

	    if (password !== confirmPassword.value.trim()) {
	    	confirmPassword.classList.add("is-invalid");
	    	errorEl.classList.remove("d-none"); 
	        return false;
	    }

	    confirmPassword.classList.remove("is-invalid");
	    errorEl.classList.add("d-none");
	    return true;
	}
	
	function setPwPattern(state) {
	    const pw = document.getElementById("password");
	    const patternText = document.getElementById("pwPattern");

	    if (state === "error") {
	        pw.classList.add("is-invalid");
	        patternText.classList.remove("text-muted");
	        patternText.classList.add("text-danger");
	    } else {
	        pw.classList.remove("is-invalid");
	        patternText.classList.remove("text-danger");
	        patternText.classList.add("text-muted");
	    }
	}


</script>
</body>
</html>