<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Edit User (Metronic 8)</title>

<!-- Metronic 8 core assets -->
<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/style.bundle.css"
	rel="stylesheet" />

<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>

<style>
/* ปรับระยะการ์ดรวม */
.app-wrapper {
	padding-top: 1.5rem;
	padding-bottom: 2rem;
}

/* กล่องคำนำหน้าให้เป็น “การ์ดเล็ก” แยกจากช่องชื่อ */
.title-cell {
	min-width: 120px;
	max-width: 160px;
	width: 140px;
}

@media ( min-width : 992px) {
	.title-cell {
		width: 150px;
	}
}

/* การ์ด section */
.card.section {
	border-radius: .75rem;
}

.card.section .row-item {
	padding: 1.25rem 1.5rem;
	border-bottom: 1px solid var(--bs-border-color);
}

/* ปุ่มไอคอนจิ๋ว */
.btn-icon-plain {
	width: 36px;
	height: 36px;
	display: flex;
	align-items: center;
	justify-content: center;
}

/* กล่องค้นหา */
.input-search {
	width: 260px;
	padding-left: 2.5rem;
}

.input-search-icon {
	left: .85rem;
	top: 50%;
	transform: translateY(-50%);
}

/* ป้ายสถานะ */
.badge-pill {
	border-radius: 9999px;
	padding: .4rem .7rem;
	font-weight: 600;
}

.badge-wait {
	background: #eef2ff;
	color: #3f51b5;
}

.badge-borrowing {
	background: #fff4d6;
	color: #c48a00;
}

.badge-returned {
	background: #eaf7ef;
	color: #2f8f4e;
}

.badge-cancel {
	background: #fde8e8;
	color: #c62828;
}

/* ตาราง */
table thead th {
	color: var(--bs-gray-600)
}

/* dropdown Entries ให้เล็ก */
.w-75px {
	width: 75px !important;
}

/* Box รูป */
.avatar-box {
	width: 125px;
	height: 125px;
	border: 2px solid var(--bs-border-color);
	border-radius: 6.18px;
	overflow: hidden;
}

#avatarPreview {
	display: block;
	width: 100%;
	height: 100%;
	object-fit: cover;
}

/* ปุ่มอัปโหลด */
.btn-upload {
	width: 125px;
	height: 44px;
	border-radius: 12px;
	font-weight: 600;
	background: var(--bs-gray-100);
	border: 0;
	box-shadow: 0 2px 6px rgba(0, 0, 0, .06);
	color: var(--bs-gray-800);
}

.btn-upload:hover {
	background: var(--bs-gray-200);
}

/* ===== Global font sizing for this page ===== */
:root {
	--fs-input: 14.95px;
	--fs-label: 13.65px;
	--fs-h3: 17.55px;
}

/* Inputs / selects / select2 render */
.form-control, .form-select, .select2-container .select2-selection__rendered
	{
	font-size: var(--fs-input);
}

.form-control::placeholder {
	font-size: var(--fs-input);
	opacity: .65;
}

.form-label {
	font-size: var(--fs-label);
	font-weight: 500;
}

.form-check-label {
	font-size: var(--fs-label);
	font-weight: 500;
}

/* Select2 dropdown/selection */
.select2-container--default .select2-results__option {
	font-size: var(--fs-input);
}

.card-header .card-title, h3.card-title {
	font-size: var(--fs-h3);
	line-height: 1.25;
}

.select2-container * {
	font-family: var(--bs-body-font-family, system-ui, -apple-system,
		"Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans",
		"Liberation Sans", sans-serif) !important;
}

.select2-container--default .select2-results__option,
	.select2-container--default .select2-selection__rendered {
	font-variant-numeric: tabular-nums !important;
	font-feature-settings: "tnum" 1, "lnum" 1 !important;
	letter-spacing: 0 !important;
	color: var(--bs-body-color) !important;
	direction: ltr !important;
	line-height: 1.5 !important;
}

.select2-container--default .select2-results__option--selected {
	color: var(--bs-body-color) !important;
}

.select2-container--default .select2-results__option[aria-selected] {
	opacity: 1 !important;
}

/* ===== Fix: Select2 in Metronic (Light/Dark) ===== */

/* พื้นที่เลือก (selected box) */
.select2-container--default .select2-selection--single {
	background-color: var(--bs-body-bg) !important;
	border-color: var(--bs-border-color) !important;
	color: var(--bs-body-color) !important;
	height: auto;
	min-height: calc(1.5em + 1rem + 2px);
	display: flex;
	align-items: center;
}

/* ตัวหนังสือในกล่องเลือก + กันทับไอคอนขวา */
.select2-container--default .select2-selection--single .select2-selection__rendered
	{
	color: var(--bs-body-color) !important;
	line-height: 1.5;
	padding-left: .75rem;
	padding-right: 3rem; /* เว้นที่ให้ปุ่ม X + ลูกศร */
}

/* ปุ่มเคลียร์ (X) จัดตำแหน่งไม่ให้ชนลูกศร */
.select2-container--default .select2-selection--single .select2-selection__clear
	{
	position: absolute;
	right: 2.1rem; /* ← ขยับให้ไม่ชนลูกศร */
	top: 50%;
	transform: translateY(-50%);
	font-size: 1rem;
	opacity: .7;
}

/* ลูกศรลง */
.select2-container--default .select2-selection--single .select2-selection__arrow
	{
	position: absolute;
	right: .65rem; /* ← ระยะขวา */
	top: 50%;
	transform: translateY(-50%);
	height: auto;
	pointer-events: none; /* ไม่บังการคลิก */
}

/* ===== Dropdown & Search box (แก้พื้นหลังขาว) ===== */
.select2-container--default .select2-dropdown {
	background-color: var(--bs-body-bg) !important;
	border-color: var(--bs-border-color) !important;
	color: var(--bs-body-color) !important;
}

.select2-container--default .select2-search--dropdown .select2-search__field
	{
	background-color: var(--bs-body-bg) !important;
	color: var(--bs-body-color) !important;
	border-color: var(--bs-border-color) !important;
}

.select2-container--default .select2-results__option {
	color: var(--bs-body-color) !important;
}

/* โฟกัส / hover */
.select2-container--default .select2-results__option--highlighted[aria-selected]
	{
	background-color: var(--bs-primary) !important;
	color: var(--bs-primary-inverse) !important;
}

/* รายการที่ถูกเลือก */
.select2-container--default .select2-results__option[aria-selected=true]
	{
	background-color: var(--bs-light-dark, var(--bs-gray-200)) !important;
	color: var(--bs-body-color) !important;
}

/* รองรับโหมดมืดของ Metronic โดยตรง (ถ้าธีมเปลี่ยนด้วย data-bs-theme) */
html[data-bs-theme="dark"] .select2-container--default .select2-results__option[aria-selected=true]
	{
	background-color: var(--bs-gray-700) !important;
}

.select2-container--default .select2-selection--single {
	position: relative;
}
/* ดันเลเยอร์ของ select2 ให้ชนะ toolbar/backdrop ทั้งหมด */
.select2-container--open,
.select2-container,
.select2-dropdown {
  z-index: 2055 !important;   /* 2055 > modal backdrop/metronic headers */
}

</style>
</head>

<body class="app-default">
	<div class="app-main flex-column flex-row-fluid">
		<div class="d-flex flex-column flex-column-fluid">
			<div class="app-toolbar py-3 py-lg-6">
				<div class="app-container container-xxl d-flex flex-stack"
					id="pageRoot">
					<form action="admin-perform-edit" method="post"
						enctype="multipart/form-data" autocomplete="off">
						<!-- PAGE TITLE -->
						<div
							class="page-title d-flex flex-column flex-wrap me-3 gap-2 gap-lg-3 mb-6">
							<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 my-0">Edit
								User</h1>
							<ul
								class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0">
								<li class="breadcrumb-item text-muted"><a
									href="${pageContext.request.contextPath}/demo_dashboard"
									class="text-muted text-hover-primary"> Admin Management </a></li>
								<li class="breadcrumb-item"><span
									class="bullet bg-gray-500 w-5px h-2px"></span></li>
								<li class="breadcrumb-item text-muted">User Profile</li>
								<li class="breadcrumb-item"><span
									class="bullet bg-gray-500 w-5px h-2px"></span></li>
								<li class="breadcrumb-item text-muted">Edit User <c:if
										test="${not empty selectUser.name}"> – ${selectUser.name}</c:if>
								</li>
							</ul>
						</div>

						<!-- ========================= CARD 0: Account Information ========================= -->
						<div class="card mb-10">
							<div
								class="card-header d-flex align-items-center justify-content-between">
								<h3 class="card-title fw-bold m-0">Account Information</h3>
								<!-- Active switch + hidden สำหรับ submit -->
								<div
									class="form-check form-switch form-check-custom form-check-solid">
									<input class="form-check-input" type="checkbox"
										id="userActiveSwitch"
										${selectUser.enable eq '1' ? 'checked' : ''} /> <label
										class="form-check-label fw-semibold" for="userActiveSwitch">Active</label>
								</div>
							</div>
							<input type="hidden" name="user.enable" id="userEnableHidden"
								value="${selectUser.enable}" />

							<div class="card-body pt-6">
								<!-- Profile picture -->
								<div class="mb-10">
									<label
										class="form-label d-block mb-3 fw-medium fs-7 form-label">Profile
										Picture</label>
									<div class="d-flex flex-column align-items-start"
										style="width: 180px">
										<div
											class="avatar-box border border-2 border-default rounded-sm overflow-hidden">
											<img id="avatarPreview" src="pages-back/img/image.jpg"
												alt="avatar" class="w-100 h-100" style="object-fit: cover;">
										</div>
										<label for="avatarFile"
											class="btn btn-light-primary w-100 d-inline-flex align-items-center justify-content-center gap-2 py-2 rounded-sm">
											<i class="ki-duotone ki-picture fs-6"><span class="path1"></span><span
												class="path2"></span></i> <span>Select Image</span>
										</label>
									</div>
									<input id="avatarFile" name="fileUpload" type="file"
										accept=".png,.jpg,.jpeg" class="d-none">
								</div>

								<div class="row g-9">
									<!-- Username -->
									<div class="col-md-6 fv-row">
										<label class="required form-label">Username</label> <input
											type="text" class="form-control" name="user.id" id="userid"
											value="${selectUser.id}" readonly />
									</div>

									<!-- Role -->
									<div class="col-md-6 fv-row">
										<label class="required form-label">Role</label> <select
											class="form-select" name="user.roleId" data-control="select2"
											data-placeholder="Select role" required>
											<option></option>
											<c:forEach var="role" items="${roleList}">
												<option value="${role.id}"
													<c:if test="${selectUser.roleId eq role.id}"> selected </c:if>>${role.id}
													- ${role.name}</option>
											</c:forEach>
										</select>
									</div>

									<!-- Gender -->
									<div class="col-md-6 fv-row">
										<label class="required form-label">Gender</label>
										<div class="d-flex align-items-center mt-2 gap-8">
											<label class="form-check form-check-custom form-check-solid">
												<input class="form-check-input" type="radio"
												name="user.gender" value="M"
												${selectUser.gender eq 'M' ? 'checked':''}> <span
												class="form-check-label">Male</span>
											</label> <label class="form-check form-check-custom form-check-solid">
												<input class="form-check-input" type="radio"
												name="user.gender" value="F"
												${selectUser.gender eq 'F' ? 'checked':''}> <span
												class="form-check-label">Female</span>
											</label>
										</div>
									</div>

									<!-- Send Email -->
									<div class="col-md-6 fv-row">
										<label class="form-label">Send Email</label>
										<div
											class="form-check form-switch form-check-custom form-check-solid mt-2">
											<input class="form-check-input" type="checkbox"
												id="emailEnableSwitch"
												${selectUser.emailEnable eq '1' ? 'checked':''} /> <label
												class="form-check-label" for="emailEnableSwitch">Enabled</label>
											<input type="hidden" name="user.emailEnable"
												id="emailEnableHidden" value="${selectUser.emailEnable}" />
										</div>
									</div>

									<!-- Full Name TH -->
									<div class="col-md-6 fv-row">
										<label class="required form-label">Full Name TH</label>
										<div class="d-flex align-items-stretch gap-3">
											<div class="title-cell">
												<select class="form-select" name="user.titleNameTH" required>
													<option value="นาย"
														${selectUser.titleNameTH == 'นาย' ? 'selected' : ''}>นาย</option>
													<option value="นาง"
														${selectUser.titleNameTH == 'นาง' ? 'selected' : ''}>นาง</option>
													<option value="นางสาว"
														${selectUser.titleNameTH == 'นางสาว' ? 'selected' : ''}>นางสาว</option>
												</select>
											</div>
											<input type="text" class="form-control flex-grow-1"
												name="user.name" value="${selectUser.name}"
												placeholder="Full Name TH" required />
										</div>
									</div>

									<!-- Full Name EN -->
									<div class="col-md-6 fv-row">
										<label class="required form-label">Full Name EN</label>
										<div class="d-flex align-items-stretch gap-3">
											<div class="title-cell">
												<select class="form-select" name="user.titleNameEN" required>
													<option value="Mr."
														${selectUser.titleNameEN == 'Mr.'  ? 'selected' : ''}>Mr.</option>
													<option value="Mrs."
														${selectUser.titleNameEN == 'Mrs.' ? 'selected' : ''}>Mrs.</option>
													<option value="Ms."
														${selectUser.titleNameEN == 'Ms.'  ? 'selected' : ''}>Ms.</option>
												</select>
											</div>
											<input type="text" class="form-control flex-grow-1"
												name="user.nameEN" value="${selectUser.nameEN}"
												placeholder="Full Name EN" required />
										</div>
									</div>

									<!-- Nicknames -->
									<div class="col-md-6 fv-row">
										<label class="form-label">Nickname TH</label> <input
											type="text" class="form-control" name="user.nickName"
											value="${selectUser.nickName}" />
									</div>
									<div class="col-md-6 fv-row">
										<label class="form-label">Nickname EN</label> <input
											type="text" class="form-control" name="user.nickNameEN"
											value="${selectUser.nickNameEN}" />
									</div>

									<!-- Citizen / Passport -->
									<div class="col-md-6 fv-row">
										<label class="required form-label">Citizen ID</label> <input
											type="text" class="form-control" name="user.citizenId"
											maxlength="32" value="${selectUser.citizenId}" required />
									</div>
									<div class="col-md-6 fv-row">
										<label class="form-label">Passport ID</label> <input
											type="text" class="form-control" name="user.passportId"
											maxlength="10" value="${selectUser.passportId}" />
									</div>

									<!-- Email / Phone -->
									<div class="col-md-6 fv-row">
										<label class="required form-label">E-Mail</label> <input
											type="email" class="form-control" name="user_email"
											maxlength="50" value="${selectUser.email}" required />
									</div>
									<div class="col-md-6 fv-row">
										<label class="required form-label">Phone Number</label> <input
											type="text" class="form-control" name="user.phonenum"
											maxlength="10" value="${selectUser.phonenum}" required />
									</div>

									<!-- Birth date / Address -->
									<div class="col-md-6 fv-row">
										<label class="form-label">Birth Date</label>
										<div class="position-relative">
											<i
												class="ki-duotone ki-calendar fs-3 position-absolute top-50 translate-middle-y ms-4"></i>
											<input name="birthDate" class="form-control ps-10"
												data-kt-date-picker="true" placeholder="dd-mm-yyyy"
												value="<fmt:formatDate value='${selectUser.birthDate}' pattern='dd-MM-yyyy'/>"
												autocomplete="off" />
										</div>
									</div>
									<div class="col-md-6 fv-row">
										<label class="form-label">Address</label>
										<textarea class="form-control" rows="2" name="user.address"
											placeholder="Please add your address">${selectUser.address}</textarea>
									</div>

									<!-- Password (เก็บคอมเมนต์ของต้นฉบับไว้) -->
									<%-- 
									<div class="col-md-6 fv-row">
										<label class="form-label">Password</label>
										<input type="password" class="form-control" name="password" value="${selectUser.password}" maxlength="32" />
									</div>
									<div class="col-md-6 fv-row">
										<label class="form-label">Confirm Password</label>
										<input type="password" class="form-control" name="confirmpassword" value="${selectUser.password}" maxlength="32" />
										<span id="message" class="mt-1 d-block"></span>
									</div>
									--%>
								</div>
							</div>
						</div>

						<!-- ========================= CARD 1: Employee Information ========================= -->
						<div class="card mb-10">
							<div class="card-header">
								<h3 class="card-title fw-bold m-0">Employee Information</h3>
							</div>
							<div class="card-body pt-6">
								<div class="row g-9">
									<div class="col-md-6 fv-row">
										<label class="required form-label">Employee Code</label> <input
											type="text" class="form-control" name="user.employeeId"
											value="${selectUser.employeeId}" required />
									</div>
									<div class="col-md-6 fv-row">
										<label class="required form-label">Employee Type</label> <select
											class="form-select" name="user.employeeTypeId"
											data-control="select2" data-placeholder="Employee type"
											required>
											<option></option>
											<option value="1"
												${selectUser.employeeTypeId == '1' ? 'selected':''}>พนักงานประจำ</option>
											<option value="2"
												${selectUser.employeeTypeId == '2' ? 'selected':''}>พนักงานอัตราจ้าง</option>
											<option value="3"
												${selectUser.employeeTypeId == '3' ? 'selected':''}>นักศึกษาฝึกงาน</option>
										</select>
									</div>

									<div class="col-md-6 fv-row">
										<label class="required form-label">Department</label> <select
											class="form-select" name="department_id"
											data-control="select2" data-placeholder="Department" required>
											<option></option>
											<c:forEach var="department" items="${departmentList}">
												<option value="${department.id}"
													${selectUser.departmentId eq department.id ? 'selected':''}>${department.id}</option>
											</c:forEach>
										</select>
									</div>
									<div class="col-md-6 fv-row">
										<label class="required form-label">Position</label> <select
											class="form-select" name="position_id" data-control="select2"
											data-placeholder="Position" required>
											<option></option>
											<c:forEach var="position" items="${positionList}">
												<option value="${position.position_id}"
													<c:if test="${selectUser.positionId eq position.position_id }"> selected </c:if>>${position.name}</option>
											</c:forEach>
										</select>
									</div>

									<div class="col-md-6 fv-row">
										<label class="required form-label">Start Working Date</label>
										<div class="position-relative">
											<i
												class="ki-duotone ki-calendar fs-3 position-absolute top-50 translate-middle-y ms-4"></i>
											<input name="startDate" class="form-control ps-10"
												data-kt-date-picker="true" placeholder="dd-mm-yyyy" required
												value="<fmt:formatDate value='${selectUser.startDate}' pattern='dd-MM-yyyy'/>"
												autocomplete="off" />
										</div>
									</div>
									<div class="col-md-6 fv-row">
										<label class="form-label">Last Working Date</label>
										<div class="position-relative">
											<i
												class="ki-duotone ki-calendar fs-3 position-absolute top-50 translate-middle-y ms-4"></i>
											<input name="endDate" class="form-control ps-10"
												data-kt-date-picker="true" placeholder="dd-mm-yyyy"
												value="<fmt:formatDate value='${selectUser.endDate}' pattern='dd-MM-yyyy'/>"
												autocomplete="off" />
										</div>
									</div>

									<div class="col-md-6 fv-row">
										<label class="required form-label">Manager</label> <select
											class="form-select" name="user.managerId" id="managerId"
											data-control="select2" data-placeholder="Manager" required>
											<option></option>
											<c:forEach var="manager" items="${userList}">
												<option value="${manager.id}"
													${selectUser.managerId eq manager.id ? 'selected':''}>
													${manager.department_id} - ${manager.id}</option>
											</c:forEach>
										</select>
									</div>

									<!-- Job Site (multiple) -->
									<div class="col-md-6 fv-row">
										<label class="required form-label">Job Site</label> <select
											class="form-select" name="id_sitejob" id="id_sitejob"
											multiple data-control="select2" data-placeholder="Job site"
											required>
											<c:forEach var="jobsite" items="${test}">
												<option value="${jobsite.id_sitejob}"
													${jobsite.is_related == 1 ? 'selected':''}>${jobsite.name_site}</option>
											</c:forEach>
										</select>
										<!-- ✅ hidden เพื่อส่งค่าแบบคอมมาสตริงไป backend ตัวเดิม -->
										<input type="hidden" name="id_sitejob" id="id_sitejob_join" />
									</div>

									<!-- Working Day -->
									<div class="col-md-6 fv-row">
										<label class="required form-label">Working Day</label>
										<div class="d-flex align-items-stretch gap-3">
											<select class="form-select flex-fill"
												name="user.workDayStart" id="workDayStart">
												<option value="1"
													${selectUser.workDayStart == 1 ? 'selected' : ''}>Mon</option>
												<option value="2"
													${selectUser.workDayStart == 2 ? 'selected' : ''}>Tue</option>
												<option value="3"
													${selectUser.workDayStart == 3 ? 'selected' : ''}>Wed</option>
												<option value="4"
													${selectUser.workDayStart == 4 ? 'selected' : ''}>Thu</option>
												<option value="5"
													${selectUser.workDayStart == 5 ? 'selected' : ''}>Fri</option>
												<option value="6"
													${selectUser.workDayStart == 6 ? 'selected' : ''}>Sat</option>
												<option value="7"
													${selectUser.workDayStart == 7 ? 'selected' : ''}>Sun</option>
											</select> <span class="d-flex align-items-center text-muted">to</span>
											<select class="form-select flex-fill" name="user.workDayEnd"
												id="workDayEnd">
												<option value="1"
													${selectUser.workDayEnd == 1 ? 'selected' : ''}>Mon</option>
												<option value="2"
													${selectUser.workDayEnd == 2 ? 'selected' : ''}>Tue</option>
												<option value="3"
													${selectUser.workDayEnd == 3 ? 'selected' : ''}>Wed</option>
												<option value="4"
													${selectUser.workDayEnd == 4 ? 'selected' : ''}>Thu</option>
												<option value="5"
													${selectUser.workDayEnd == 5 ? 'selected' : ''}>Fri</option>
												<option value="6"
													${selectUser.workDayEnd == 6 ? 'selected' : ''}>Sat</option>
												<option value="7"
													${selectUser.workDayEnd == 7 ? 'selected' : ''}>Sun</option>
											</select>
										</div>
									</div>

									<!-- Working Hour -->
									<div class="col-md-6 fv-row">
										<label class="required form-label">Working Hour</label>
										<div class="d-flex align-items-stretch gap-3">
											<select class="form-select flex-fill" id="workTimeStart"
												name="user.workTimeStart"></select> <span
												class="d-flex align-items-center text-muted">to</span> <select
												class="form-select flex-fill" id="workTimeEnd"
												name="user.workTimeEnd"></select>
										</div>
									</div>

									<!-- Default working -->
									<div class="col-md-6 fv-row">
										<label class="form-label">Default Working</label>
										<div class="d-flex align-items-center gap-10 mt-2">
											<label class="form-check form-check-custom form-check-solid">
												<input class="form-check-input" type="radio"
												name="user.work_type" value="1"
												${selectUser.work_type eq '1' or empty selectUser.work_type ? 'checked':''}>
												<span class="form-check-label">On-Site</span>
											</label> <label class="form-check form-check-custom form-check-solid">
												<input class="form-check-input" type="radio"
												name="user.work_type" value="2"
												${selectUser.work_type eq '2' ? 'checked':''}> <span
												class="form-check-label">WFH</span>
											</label>
										</div>
									</div>

									<!-- On-site days -->
									<div class="col-md-6 fv-row">
										<label class="form-label">Number of On-Site Days</label>
										<div class="d-flex align-items-center flex-wrap gap-7 mt-2">
											<label class="form-check form-check-custom form-check-solid">
												<input class="form-check-input" type="radio"
												name="user.onsite_num" value="1"
												${selectUser.onsite_num eq '1' ? 'checked':''}> <span
												class="form-check-label">0.5 – 1 day (WFH)</span>
											</label> <label class="form-check form-check-custom form-check-solid">
												<input class="form-check-input" type="radio"
												name="user.onsite_num" value="2"
												${selectUser.onsite_num eq '2' ? 'checked':''}> <span
												class="form-check-label">2 – 3 days (Hybrid)</span>
											</label> <label class="form-check form-check-custom form-check-solid">
												<input class="form-check-input" type="radio"
												name="user.onsite_num" value="3"
												${selectUser.onsite_num eq '3' or empty selectUser.onsite_num ? 'checked':''}>
												<span class="form-check-label">4 – 5 days (On-Site)</span>
											</label>
										</div>
									</div>

									<!-- Emergency -->
									<div class="col-md-6 fv-row">
										<label class="form-label">Emergency Contact</label> <input
											type="text" class="form-control" name="user.emergContact"
											value="${selectUser.emergContact}" placeholder="Name" />
									</div>
									<div class="col-md-6 fv-row">
										<label class="form-label">Emergency Phone Number</label> <input
											type="text" class="form-control" name="user.emergPhone"
											maxlength="10" value="${selectUser.emergPhone}"
											placeholder="Phone number" />
									</div>

									<!-- Leave quota -->
									<div class="col-12">
										<label class="form-label">Leave quota: <span
											class="fw-semibold text-muted">10 days left</span></label>
									</div>
									<div class="col-md-4 fv-row">
										<label class="form-label">ลาพักร้อน (วัน)</label> <input
											type="text" class="form-control" name="user.leaveQuota1"
											placeholder="จำนวนวัน" value="${selectUser.leaveQuota1}" />
									</div>
									<div class="col-md-4 fv-row">
										<label class="form-label">ลาป่วย (วัน)</label> <input
											type="text" class="form-control" name="user.leaveQuota3"
											placeholder="จำนวนวัน" value="${selectUser.leaveQuota3}" />
									</div>
									<div class="col-md-4 fv-row">
										<label class="form-label">ลาพักร้อนที่เหลือจากปีที่แล้ว
											(วัน)</label> <input type="text" class="form-control"
											name="user.leaveQuota4" placeholder="จำนวนวัน"
											value="${selectUser.leaveQuota4}" />
									</div>
								</div>
							</div>
						</div>

						<!-- ========================= CARD 2: Education ========================= -->
						<div class="card mb-10">
							<div class="card-header">
								<h3 class="card-title fw-bold m-0">Education</h3>
							</div>
							<div class="card-body pt-6">
								<div class="table-responsive">
									<table class="table align-middle table-row-dashed gy-4">
										<thead>
											<tr class="text-muted fw-semibold">
												<th style="width: 60px;">No</th>
												<th>Level of Education</th>
												<th style="min-width: 280px;">Name of Institute</th>
												<th style="min-width: 220px;">Duration (Year)</th>
												<th style="min-width: 260px;">Degree/Certificate</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>1</td>
												<td>High School</td>
												<td><input class="form-control"
													name="user.eduInstitute1"
													value="${selectUser.eduInstitute1}"></td>
												<td>
													<div class="d-flex align-items-center gap-3">
														<input class="form-control" type="number"
															name="user.eduDurStart1"
															value="${selectUser.eduDurStart1}"> <span
															class="text-muted">~</span> <input class="form-control"
															type="number" name="user.eduDurEnd1"
															value="${selectUser.eduDurEnd1}">
													</div>
												</td>
												<td><input class="form-control" name="user.eduDegree1"
													value="${selectUser.eduDegree1}"></td>
											</tr>
											<tr>
												<td>2</td>
												<td>Technical/Commercial</td>
												<td><input class="form-control"
													name="user.eduInstitute2"
													value="${selectUser.eduInstitute2}"></td>
												<td>
													<div class="d-flex align-items-center gap-3">
														<input class="form-control" type="number"
															name="user.eduDurStart2"
															value="${selectUser.eduDurStart2}"> <span
															class="text-muted">~</span> <input class="form-control"
															type="number" name="user.eduDurEnd2"
															value="${selectUser.eduDurEnd2}">
													</div>
												</td>
												<td><input class="form-control" name="user.eduDegree2"
													value="${selectUser.eduDegree2}"></td>
											</tr>
											<tr>
												<td>3</td>
												<td>University</td>
												<td><input class="form-control"
													name="user.eduInstitute3"
													value="${selectUser.eduInstitute3}"></td>
												<td>
													<div class="d-flex align-items-center gap-3">
														<input class="form-control" type="number"
															name="user.eduDurStart3"
															value="${selectUser.eduDurStart3}"> <span
															class="text-muted">~</span> <input class="form-control"
															type="number" name="user.eduDurEnd3"
															value="${selectUser.eduDurEnd3}">
													</div>
												</td>
												<td><input class="form-control" name="user.eduDegree3"
													value="${selectUser.eduDegree3}"></td>
											</tr>
											<tr>
												<td>4</td>
												<td>Graduated School</td>
												<td><input class="form-control"
													name="user.eduInstitute4"
													value="${selectUser.eduInstitute4}"></td>
												<td>
													<div class="d-flex align-items-center gap-3">
														<input class="form-control" type="number"
															name="user.eduDurStart4"
															value="${selectUser.eduDurStart4}"> <span
															class="text-muted">~</span> <input class="form-control"
															type="number" name="user.eduDurEnd4"
															value="${selectUser.eduDurEnd4}">
													</div>
												</td>
												<td><input class="form-control" name="user.eduDegree4"
													value="${selectUser.eduDegree4}"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>

						<!-- ========================= CARD 3: Payment Information ========================= -->
						<div class="card mb-10">
							<div class="card-header">
								<h3 class="card-title fw-bold m-0">Payment Information</h3>
							</div>
							<div class="card-body pt-6">
								<div class="row g-9">
									<!-- เบี้ยขยัน -->
									<div class="col-lg-6 fv-row">
										<label class="form-label d-block">สิทธิ์เบี้ยขยัน</label>
										<div class="row g-4">
											<div class="col-sm-6">
												<label
													class="form-check form-check-custom form-check-success">
													<input class="form-check-input" type="radio"
													name="user.incDa" value="1"
													${selectUser.incDa == '1' ? 'checked':''}> <span
													class="form-check-label">มีสิทธิ์ได้เบี้ยขยัน</span>
												</label>
											</div>
											<div class="col-sm-6">
												<label
													class="form-check form-check-custom form-check-light-success">
													<input class="form-check-input" type="radio"
													name="user.incDa" value="2"
													${selectUser.incDa == '2' ? 'checked':''}> <span
													class="form-check-label">เงินเดือนรวมค่าเบี้ยขยันแล้ว</span>
												</label>
											</div>
											<div class="col-sm-6">
												<label class="form-check form-check-custom form-check-info">
													<input class="form-check-input" type="radio"
													name="user.incDa" value="4"
													${selectUser.incDa == '4' ? 'checked':''}> <span
													class="form-check-label">ผ่านทดลองงานรับเบี้ยขยัน</span>
												</label>
											</div>
											<div class="col-sm-6">
												<label
													class="form-check form-check-custom form-check-danger">
													<input class="form-check-input" type="radio"
													name="user.incDa" value="0"
													${selectUser.incDa == '0' ? 'checked':''}> <span
													class="form-check-label">งดเบี้ยขยัน</span>
												</label>
											</div>
											<div class="col-sm-6">
												<label
													class="form-check form-check-custom form-check-warning">
													<input class="form-check-input" type="radio"
													name="user.incDa" value="3"
													${selectUser.incDa == '3' ? 'checked':''}> <span
													class="form-check-label">เงินเดือนถึงเกณฑ์งดเบี้ยขยัน</span>
												</label>
											</div>
										</div>
									</div>

									<!-- notebook -->
									<div class="col-lg-6 fv-row">
										<label class="form-label d-block">สิทธิ์ค่า notebook</label>
										<div class="row g-4">
											<div class="col-sm-6">
												<label
													class="form-check form-check-custom form-check-success">
													<input class="form-check-input" type="radio"
													name="user.incNb" value="1"
													${selectUser.incNb == '1' ? 'checked':''}> <span
													class="form-check-label">มีสิทธิ์ได้ค่า notebook</span>
												</label>
											</div>
											<div class="col-sm-6">
												<label
													class="form-check form-check-custom form-check-light-success">
													<input class="form-check-input" type="radio"
													name="user.incNb" value="2"
													${selectUser.incNb == '2' ? 'checked':''}> <span
													class="form-check-label">เงินเดือนรวมค่า notebook
														แล้ว</span>
												</label>
											</div>
											<div class="col-sm-6">
												<label
													class="form-check form-check-custom form-check-danger">
													<input class="form-check-input" type="radio"
													name="user.incNb" value="0"
													${selectUser.incNb == '0' ? 'checked':''}> <span
													class="form-check-label">งดค่า notebook</span>
												</label>
											</div>
										</div>
									</div>

									<!-- remark -->
									<div class="col-12 fv-row">
										<label class="form-label">Payment Remark</label>
										<textarea class="form-control" rows="3"
											name="user.paymentRemark" placeholder="Payment remark">${selectUser.paymentRemark}</textarea>
									</div>

									<!-- switches -->
									<div class="col-md-6">
										<label
											class="form-check form-switch form-check-custom form-check-solid">
											<input class="form-check-input" type="checkbox"
											id="withHoldAuto"
											${selectUser.withHoldAuto == '1' ? 'checked':''}> <span
											class="form-check-label">คำนวนภาษีหัก ณ
												ที่จ่ายอัตโนมัติ</span>
										</label> <input type="hidden" name="user.withHoldAuto"
											id="withHoldAutoHidden" value="${selectUser.withHoldAuto}" />
									</div>
									<div class="col-md-6">
										<label
											class="form-check form-switch form-check-custom form-check-solid">
											<input class="form-check-input" type="checkbox"
											id="socialSecurity"
											${selectUser.socialSecurity == 1 ? 'checked':''}> <span
											class="form-check-label">มีสิทธิ์ประกันสังคม</span>
										</label> <input type="hidden" name="user.socialSecurity"
											id="socialSecurityHidden"
											value="${selectUser.socialSecurity}" />
									</div>

									<!-- tax -->
									<div class="col-md-6 fv-row">
										<label class="form-label">Tax Default</label> <input
											type="number" step="0.01" class="form-control" id="withHold"
											name="user.withHold"
											value="${selectUser.withHold != null ? selectUser.withHold : '0.00'}"
											${selectUser.withHoldAuto == '1' ? 'disabled':''} />
									</div>
									<div class="col-md-6 fv-row">
										<label class="form-label">Tax Deduction</label> <select
											class="form-select" name="user.taxDec" data-control="select2">
											<option value="0" ${selectUser.taxDec == '0' ? 'selected':''}>หัก
												ณ ที่จ่าย</option>
											<option value="1" ${selectUser.taxDec == '1' ? 'selected':''}>ออกให้ตลอดไป</option>
										</select>
									</div>

									<!-- transfer -->
									<div class="col-12 fv-row">
										<label class="form-label d-block">Transfer Type</label>
										<div class="d-flex align-items-center gap-10">
											<label class="form-check form-check-custom form-check-solid">
												<input class="form-check-input" type="radio"
												name="user.transferType" value="1"
												${selectUser.transferType != '0' ? 'checked':''}> <span
												class="form-check-label">โอน</span>
											</label> <label class="form-check form-check-custom form-check-solid">
												<input class="form-check-input" type="radio"
												name="user.transferType" value='0'
												${selectUser.transferType == '0' ? 'checked':''}> <span
												class="form-check-label">เงินสด</span>
											</label>
										</div>
									</div>

									<!-- bank -->
									<div class="col-md-6 fv-row">
										<label class="form-label">Bank Name</label> <input
											class="form-control" name="user.bank"
											value="${selectUser.bank}" placeholder="Bank name">
									</div>
									<div class="col-md-6 fv-row">
										<label class="form-label">Bank Branch</label> <input
											class="form-control" name="user.bankBranch"
											value="${selectUser.bankBranch}" placeholder="Bank branch">
									</div>

									<div class="col-md-6 fv-row">
										<label class="form-label d-block">Bank Type</label>
										<div class="d-flex align-items-center gap-10">
											<label class="form-check form-check-custom form-check-solid">
												<input class="form-check-input" type="radio"
												name="user.bankType" value="0"
												${selectUser.bankType != '1' ? 'checked':''}> <span
												class="form-check-label">บัญชีออมทรัพย์</span>
											</label> <label class="form-check form-check-custom form-check-solid">
												<input class="form-check-input" type="radio"
												name="user.bankType" value="1"
												${selectUser.bankType == '1' ? 'checked':''}> <span
												class="form-check-label">บัญชีกระแสรายวัน</span>
											</label>
										</div>
									</div>
									<div class="col-md-6 fv-row">
										<label class="required form-label">Bank Number</label> <input
											class="form-control" name="user.bankNum"
											value="${selectUser.bankNum}" placeholder="Bank number"
											required>
									</div>
								</div>

								<input type="hidden" name="page" value="2" />
								<div class="d-flex justify-content-end mt-10">
									<button type="reset" class="btn btn-light me-3">
										<i class="fa fa-close"></i>Cancel
									</button>
									<button type="submit" class="btn btn-success">
										<i class="ki-duotone ki-save-2 fs-2 me-2"></i>Save
									</button>
								</div>
							</div>
						</div>

						<!-- ========================= CARD: More Information ========================= -->
						<div class="card section mb-10">
							<div class="card-header">
								<h3 class="card-title fw-bold m-0">More Information</h3>
							</div>
							<div class="card-body p-0">
								<div
									class="row-item d-flex align-items-center justify-content-between">
									<div class="fw-semibold">Change Password</div>
									<button type="button"
										class="btn btn-light btn-icon btn-icon-plain"
										data-bs-toggle="modal" data-bs-target="#modalChangePassword">
										<i class="ki-duotone ki-pencil fs-3 text-primary"><span
											class="path1"></span><span class="path2"></span></i>
									</button>
								</div>
							</div>
						</div>

						<!-- ========================= CARD: Borrow List ========================= -->
						<div class="card section">
							<div class="card-header align-items-center">
								<h3 class="card-title fw-bold m-0">Borrow List</h3>
								<div class="card-toolbar">
									<a href="borrow-new" class="btn btn-primary"> <i
										class="ki-duotone ki-plus fs-2 me-2"></i> Add New
									</a>
								</div>
							</div>

							<div class="card-body">
								<!-- Controls -->
								<div
									class="d-flex flex-wrap align-items-center justify-content-between gap-6 mb-4">
									<!-- search -->
									<div class="position-relative">
										<i
											class="ki-duotone ki-magnifier fs-2 position-absolute input-search-icon"></i>
										<input id="borrowSearch" type="text"
											class="form-control input-search" placeholder="Search">
									</div>
									<!-- entries -->
									<div class="d-flex align-items-center gap-3">
										<select id="borrowEntries" class="form-select w-75px">
											<option>10</option>
											<option>25</option>
											<option>50</option>
										</select> <span class="text-muted">Entries</span>
									</div>
								</div>

								<!-- Filters -->
								<div class="d-flex flex-wrap align-items-center gap-6 mb-2">
									<label class="form-check form-check-custom form-check-solid">
										<input class="form-check-input borrow-filter" type="checkbox"
										value="WAIT" checked> <span class="form-check-label">Wait
											for approve</span>
									</label> <label class="form-check form-check-custom form-check-solid">
										<input class="form-check-input borrow-filter" type="checkbox"
										value="BORROWING"> <span class="form-check-label">Borrowing</span>
									</label> <label class="form-check form-check-custom form-check-solid">
										<input class="form-check-input borrow-filter" type="checkbox"
										value="RETURNED"> <span class="form-check-label">Returned</span>
									</label> <label class="form-check form-check-custom form-check-solid">
										<input class="form-check-input borrow-filter" type="checkbox"
										value="CANCEL"> <span class="form-check-label">Cancel</span>
									</label>
								</div>

								<div class="text-muted fs-7 mb-4" id="borrowCount">Showing
									0 items</div>

								<!-- Table -->
								<div class="table-responsive">
									<table id="borrowTable"
										class="table align-middle table-row-dashed">
										<thead>
											<tr class="fw-semibold">
												<th style="min-width: 140px;">Date Create</th>
												<th>Item No</th>
												<th>Equipment</th>
												<th>Borrower</th>
												<th>Location</th>
												<th>Status</th>
												<th class="text-end">Action</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="row" items="${borrowList}">
												<tr data-status="${row.status}">
													<td>
														<div class="fw-semibold">
															<fmt:formatDate value="${row.createdAt}"
																pattern="d MMM yyyy" />
														</div>
														<div class="text-muted fs-7">
															<fmt:formatDate value="${row.createdAt}"
																pattern="HH:mm:ss" />
														</div>
													</td>
													<td>${row.itemNo}</td>
													<td>${row.equipment}</td>
													<td>${row.borrower}</td>
													<td>${row.location}</td>
													<td><c:choose>
															<c:when test="${row.status=='WAIT'}">
																<span class="badge badge-pill badge-wait">Wait
																	for approve</span>
															</c:when>
															<c:when test="${row.status=='BORROWING'}">
																<span class="badge badge-pill badge-borrowing">Borrowing</span>
															</c:when>
															<c:when test="${row.status=='RETURNED'}">
																<span class="badge badge-pill badge-returned">Returned</span>
															</c:when>
															<c:otherwise>
																<span class="badge badge-pill badge-cancel">Cancel</span>
															</c:otherwise>
														</c:choose></td>
													<td class="text-end"><a
														href="borrow-edit?id=${row.id}"
														class="btn btn-light btn-icon btn-icon-plain me-2"
														aria-label="Edit"> <i
															class="ki-duotone ki-pencil fs-3"></i>
													</a>
														<button type="button"
															class="btn btn-light-danger btn-icon btn-icon-plain"
															data-id="${row.id}" onclick="deleteBorrow(this)"
															aria-label="Delete">
															<i class="ki-duotone ki-trash fs-3"></i>
														</button></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>

								<!-- Pagination (static) -->
								<div class="d-flex justify-content-end mt-6">
									<ul class="pagination">
										<li class="page-item previous disabled"><a
											class="page-link"><i class="previous"></i></a></li>
										<li class="page-item active"><a class="page-link">1</a></li>
										<li class="page-item"><a class="page-link">2</a></li>
										<li class="page-item"><a class="page-link">3</a></li>
										<li class="page-item"><a class="page-link">…</a></li>
										<li class="page-item"><a class="page-link">5</a></li>
										<li class="page-item"><a class="page-link">6</a></li>
										<li class="page-item next"><a class="page-link"><i
												class="next"></i></a></li>
									</ul>
								</div>
							</div>
						</div>

					</form>

					<!-- Modal: Change Password -->
					<div class="modal fade" id="modalChangePassword" tabindex="-1"
						aria-hidden="true">
						<div class="modal-dialog modal-md modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">Change Password</h5>
									<button type="button" class="btn btn-icon btn-sm"
										data-bs-dismiss="modal">
										<i class="ki-duotone ki-cross fs-2"></i>
									</button>
								</div>
								<form action="admin-perform-change-password" method="post"
									autocomplete="off">
									<div class="modal-body py-6">
										<div class="mb-5">
											<label class="form-label">Current Password</label> <input
												type="password" class="form-control" name="currentPassword">
										</div>
										<div class="mb-5">
											<label class="form-label">New Password</label> <input
												type="password" class="form-control" name="newPassword">
										</div>
										<div>
											<label class="form-label">Confirm New Password</label> <input
												type="password" class="form-control" name="confirmPassword">
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-light"
											data-bs-dismiss="modal">Cancel</button>
										<button type="submit" class="btn btn-primary">Update
											Password</button>
									</div>
								</form>
							</div>
						</div>
					</div>

				</div>
				<!-- /.app-container -->
			</div>
			<!-- /.toolbar -->
		</div>
		<!-- /.flex -->
	</div>
	<!-- /.app-main -->

	<!-- ============== Page Scripts ============== -->
	<script>
	// ====== เวลาทุก 30 นาที ======
	const STEP_MIN = 30;
	function buildTimes(step) {
	  const out = [];
	  for (let h = 0; h < 24; h++) {
	    for (let m = 0; m < 60; m += step) {
	      const hh = String(h).padStart(2, '0');
	      const mm = String(m).padStart(2, '0');
	      out.push(`${hh}:${mm}`);
	    }
	  }
	  return out;
	}

	// template text-node ล้วน (กันไอคอนฟอนต์แทรก)
	function textNodeTpl (data) {
	  if (!data.id) return data.text;
	  const $span = $('<span/>');
	  $span.text(data.id);
	  return $span;
	}

	function initTimeSelect($el, value) {
		  const times = buildTimes(STEP_MIN);
		  const data  = [{ id: '', text: 'Select time' }, ...times.map(t => ({ id:t, text:t }))];

		  if ($el.hasClass('select2-hidden-accessible')) $el.select2('destroy');
		  $el.empty();

		  $el.select2({
		    data,
		    width: '100%',
		    minimumResultsForSearch: Infinity,
		    dropdownAutoWidth: true,
		    dropdownParent: $(document.body),   // ✅ กัน overflow คลิป
		    templateResult:   textNodeTpl,
		    templateSelection:textNodeTpl,
		    escapeMarkup: m => m
		  });

		  if (value && times.includes(value)) $el.val(value).trigger('change');
		}



	const defaultStart = '${selectUser.workTimeStart != null ? selectUser.workTimeStart : ""}';
	const defaultEnd   = '${selectUser.workTimeEnd   != null ? selectUser.workTimeEnd   : ""}';

	initTimeSelect($('#workTimeStart'), defaultStart || '08:30');
	initTimeSelect($('#workTimeEnd'),   defaultEnd   || '17:30');

	// สำหรับ workDay และ time select ที่เรียกต่างหาก ให้ส่ง dropdownParent ด้วย
	$('#workDayStart, #workDayEnd').select2({
  width: '100%',
  minimumResultsForSearch: Infinity,
  dropdownParent: $(document.body)   // ✅ เปลี่ยนเป็น body
});


	

	// Flatpickr Datepicker
	$('[data-kt-date-picker="true"]').flatpickr({ dateFormat: 'd-m-Y', allowInput: true });

	// Email enable switch <-> hidden
	(function(){
	  const sw = document.getElementById('emailEnableSwitch');
	  const hidden = document.getElementById('emailEnableHidden');
	  if (sw && hidden) sw.addEventListener('change', ()=> hidden.value = sw.checked ? '1' : '0');
	})();

	// Active switch <-> user.enable (hidden)
	(function(){
	  const sw = document.getElementById('userActiveSwitch');
	  const hidden = document.getElementById('userEnableHidden');
	  if (sw && hidden) sw.addEventListener('change', ()=> hidden.value = sw.checked ? '1' : '0');
	})();

	// Withhold auto switch
	(function(){
	  const sw = document.getElementById('withHoldAuto');
	  const hidden = document.getElementById('withHoldAutoHidden');
	  const input = document.getElementById('withHold');
	  if (sw && hidden && input) {
	    sw.addEventListener('change', ()=>{
	      const on = sw.checked;
	      hidden.value = on ? '1' : '0';
	      input.disabled = on;
	      if (on) input.value = '0.00';
	    });
	  }
	})();

	// Social security switch
	(function(){
	  const sw = document.getElementById('socialSecurity');
	  const hidden = document.getElementById('socialSecurityHidden');
	  if (sw && hidden) sw.addEventListener('change', ()=> hidden.value = sw.checked ? '1' : '0');
	})();

	// Password match (ถ้าเปิดคอมเมนต์ส่วนรหัสผ่าน)
	(function(){
	  const pwd = document.querySelector('input[name="password"]');
	  const cpw = document.querySelector('input[name="confirmpassword"]');
	  const msg = document.getElementById('message');
	  function check(){
	    if(!pwd || !cpw || !msg) return;
	    if(pwd.value === cpw.value){ msg.textContent='รหัสผ่านตรงกัน'; msg.style.color='green'; }
	    else { msg.textContent='รหัสผ่านไม่ตรงกัน โปรดกรอกใหม่'; msg.style.color='red'; }
	  }
	  if (pwd && cpw) { pwd.addEventListener('keyup', check); cpw.addEventListener('keyup', check); }
	})();

	// ===== Hook form submit: แพ็ก Job Site (multiple) เป็น comma string ให้ backend เดิม =====
	(function(){
	  const $form = $('form[action="admin-perform-edit"]');
	  const $sel  = $('#id_sitejob');          // select multiple
	  const $hid  = $('#id_sitejob_join');     // hidden ที่ส่งคอมมาสตริง

	  $form.on('submit', function(){
	    const vals = $sel.val() || [];            // ["S001","S002",...]
	    $hid.val(vals.join(','));                 // "S001,S002"
	    $sel.attr('name', 'id_sitejob_client_only'); // กันส่งซ้ำกับ hidden
	  });
	})();

	// ===== Borrow table filter/search =====
	(function() {
	  const $rows    = $('#borrowTable tbody tr');
	  const $search  = $('#borrowSearch');
	  const $filters = $('.borrow-filter');
	  const $count   = $('#borrowCount');

	  function apply() {
	    const q = ($search.val() || '').toLowerCase();
	    const allowed = new Set($filters.filter(':checked').map((_, el) => el.value).get());
	    let shown = 0;

	    $rows.each(function () {
	      const t = $(this).text().toLowerCase();
	      const okText   = !q || t.includes(q);
	      const okStatus = allowed.has($(this).data('status'));
	      const show = okText && okStatus;
	      $(this).toggle(show);
	      if (show) shown++;
	    });

	    $count.text('Showing ' + shown + ' item' + (shown !== 1 ? 's' : ''));
	  }

	  $search.on('input', apply);
	  $filters.on('change', apply);
	  apply();
	})();

	// ลบรายการ (ตัวอย่าง)
	function deleteBorrow(btn){
	  const id = btn.getAttribute('data-id');
	  if (!confirm('Delete this record?')) return;
	  alert('Deleted (mock): ' + id);
	}
	
	// ใช้กับทุก select2 ของหน้า ที่ตั้ง data-control="select2"
	$('[data-control="select2"]').each(function(){
  const $el = $(this);
  if ($el.hasClass('select2-hidden-accessible')) $el.select2('destroy');

  const $parent =
    $el.closest('.modal.show').find('.modal-content').first().length
      ? $el.closest('.modal.show').find('.modal-content').first()
      : $(document.body);   // ✅ โมดัลใช้ .modal-content, นอกนั้นใช้ body

  $el.select2({
    width: '100%',
    minimumResultsForSearch: 5,
    dropdownParent: $parent,
    allowClear: $el.is('[data-allow-clear], [data-allow_clear]') || $el.data('allowClear') === true
  });
});


	

	</script>

</body>
</html>
