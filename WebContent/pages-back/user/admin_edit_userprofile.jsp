<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value="en_US" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />

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
.form-check-success .form-check-input {
	border-color: #50cd89 !important;
}

.form-check-primary .form-check-input {
	border-color: #009ef7 !important;
}

.form-check-danger .form-check-input {
	border-color: #f1416c !important;
}

.initials-text {
	font-size: 48px;
	color: #0d6efd;
}

.image-input.image-input-changed .initials-text {
	display: none !important;
}

#id_sitejob+.select2-container .select2-selection__choice {
	background-color: #4b92fa !important; 
    border-color: #0d6efd !important;
    color: #fff !important;
    font-size: 13px;
}


.toggle-password.d-none {
	display: none !important;
}

#password.is-invalid,
#confirm_password.is-invalid {
    background-image: none !important;
}


</style>

</head>

<body class="app-default">
	<div class="app-main flex-column flex-row-fluid">
		<div class="app-toolbar py-3 py-lg-6">
			<div class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex align-items-center justify-content-between w-100 me-3 mb-6">
					<div class="d-flex flex-column flex-wrap gap-2 gap-lg-3">
						<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 my-0">
							Edit User</h1>

						<ul
							class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0">
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/user-list"
								class="text-muted text-hover-primary">Admin Management </a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted">User Profile</li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted">Edit User <c:if
									test="${not empty selectUser.name}">
                                            – ${selectUser.name}
                                        </c:if>
							</li>
						</ul>
					</div>

					<div class="d-flex align-items-center">
						<button type="button"
							class="btn btn-danger btn-sm d-flex align-items-center gap-2"
							id="btnDelete" data-user-id="${selectUser.id}">

							<i class="ki-duotone ki-trash fs-4"> <span class="path1"></span>
								<span class="path2"></span> <span class="path3"></span> <span
								class="path4"></span> <span class="path5"></span>
							</i> Delete
						</button>

					</div>

				</div>
			</div>
		</div>

		<div class="app-content flex-column-fluid">
			<div class="app-container container-fluid">
				<form action="admin-perform-edit" method="post"
					enctype="multipart/form-data" autocomplete="off">
					<input type="hidden" name="user.id" value="${selectUser.id}" />

					<div class="card mb-10">
						<div class="card-body pt-6 pb-0">
							<div class="d-flex flex-column flex-md-row align-items-start">

								<div class="me-md-9 mb-md-0" style="width: 150px;">
									<div class="mb-4 mb-md-0 me-md-9 mb-md-0 w-150px h-150px mx-auto">
								
										<c:choose>
											<c:when test="${not empty editUserImgPath}">
												<img id="avatarPreview"
													src="${pageContext.request.contextPath}${editUserImgPath}"
													alt="${not empty selectUser.nameEN ? selectUser.nameEN : selectUser.name}"
													class="border border-2 border-white rounded-1 w-150px h-150px"
													style="object-fit: cover;">
											</c:when>
											<c:otherwise>
												<div id="avatarPreview"
													class="w-150px h-150px rounded-1 d-flex align-items-center justify-content-center"
													style="background-color: #f3f6f9; font-size: 48px; color: #0d6efd;">
													<c:choose>
														<c:when
															test="${not empty selectUser.nameEN and fn:length(selectUser.nameEN) >= 1}">
                                                            ${fn:toUpperCase(fn:substring(selectUser.nameEN, 0, 1))}
                                                        </c:when>
														<c:when
															test="${not empty selectUser.name and fn:length(selectUser.name) >= 1}">
                                                            ${fn:toUpperCase(fn:substring(selectUser.name, 0, 1))}
                                                        </c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose>
												</div>
											</c:otherwise>
										</c:choose>
									</div>
								</div>

								<div class="flex-grow-1 w-100">

									<div
										class="d-flex justify-content-between align-items-start mb-4">
										<div>
											<div class="d-flex flex-column">
												<div class="d-flex align-items-center gap-4 ">
													<p class="fs-2 fw-bold text-gray-900  mb-0">${selectUser.id}</p>
													<c:forEach var="jobSite" items="${jobSite}">
														<span
															class="badge badge-lg bg-primary text-white fw-semibold fs-8">${jobSite.name_site}</span>
													</c:forEach>
												</div>
												<div class="d-flex flex-wrap">
													<span class="fs-4 fw-normal text-gray-900">${selectUser.employeeId}
														${selectUser.nameEN} - ${selectUser.name}</span>
												</div>
											</div>
										</div>

										<span id="userActiveBadge"
											class="badge px-4 py-2
                                                  ${selectUser.enable eq '1'
                                                        ? 'badge-light-success'
                                                        : 'badge-light-danger'}">
											${selectUser.enable eq '1' ? 'Active' : 'Inactive'} </span>
									</div>

									<div class="d-flex flex-wrap gap-4">
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-5 fw-bold text-gray-800 mb-2">${empty workPeriod ? '-' :workPeriod}</p>
												<p class="fs-6 fw-bold text-gray-500 mb-0">
													<c:choose>
														<c:when test="${empty selectUser.startDate}">
														</c:when>
														<c:otherwise>
															<fmt:formatDate value="${selectUser.startDate}"
																pattern="dd MMM yyyy" />
														</c:otherwise>
													</c:choose>

												</p>
											</div>
										</div>
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-5 fw-bold text-gray-800 mb-2">${empty selectUser.positionId ? 'NONE':selectUser.positionId}</p>
												<p class="fs-6 fw-bold text-gray-500 mb-0">Position</p>
											</div>
										</div>
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-5 fw-bold text-gray-800 mb-2">${empty selectUser.departmentId ? 'NONE':selectUser.departmentId}</p>
												<p class="fs-6 fw-bold text-gray-500 mb-0">Department</p>
											</div>
										</div>
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-5 fw-bold text-gray-800 mb-2">${selectUser.workType == 1 ? 'On-site' : 'WFH'}</p>
												<p class="fs-6 fw-bold text-gray-500 mb-0">
													${selectUser.onsiteNum == 3 ? '4–5 Day' :
          							          selectUser.onsiteNum == 2 ? '2–3 Day' :
          							          selectUser.onsiteNum == 1 ? '0.5–1 Day' : '-'}</p>
											</div>
										</div>
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-5 fw-bold text-gray-800 mb-2">${selectUser.workDayStart == 1 ? 'Mon' :
 											selectUser.workDayStart == 2 ? 'Tue' :
 											selectUser.workDayStart == 3 ? 'Wed' :
 											selectUser.workDayStart == 4 ? 'Thu' :
 											selectUser.workDayStart == 5 ? 'Fri' :
 											selectUser.workDayStart == 6 ? 'Sat' :
 											selectUser.workDayStart == 7 ? 'Sun' : ''}
													${selectUser.workDayEnd == 1 ? '- Mon' :
 											selectUser.workDayEnd == 2 ? '- Tue' :
 											selectUser.workDayEnd == 3 ? '- Wed' :
 											selectUser.workDayEnd == 4 ? '- Thu' :
 											selectUser.workDayEnd == 5 ? '- Fri' :
 											selectUser.workDayEnd == 6 ? '- Sat' :
 											selectUser.workDayEnd == 7 ? '- Sun' : ''}</p>
												<p class="fs-6 fw-bold text-gray-500 mb-0">${selectUser.workTimeStart}
													- ${selectUser.workTimeEnd}</p>
											</div>
										</div>
									</div>

								</div>
							</div>
						</div>

						<div class="separator my-2 mx-9 "></div>
						<ul
							class="nav nav-stretch nav-line-tabs nav-line-tabs-2x border-0 fs-6 fw-semibold px-9 mt-1 mb-1"
							id="profileNav">

							<li class="nav-item"><a
								class="nav-link text-active-primary active py-3 ms-0 fw-bold"
								href="#" data-target="#account-info"> Account Info </a></li>

							<li class="nav-item"><a
								class="nav-link text-active-primary py-3 fw-bold" href="#"
								data-target="#employee-info"> Employee Info </a></li>
							<li class="nav-item"><a
								class="nav-link text-active-primary py-3 fw-bold" href="#"
								data-target="#education-info"> Education </a></li>
							<li class="nav-item"><a
								class="nav-link text-active-primary py-3 fw-bold" href="#"
								data-target="#payment-info"> Payment Info </a></li>
							<li class="nav-item"><a
								class="nav-link text-active-primary py-3 fw-bold" href="#"
								data-target="#security-info"> Security </a></li>
							<li class="nav-item"><a
								class="nav-link text-active-primary py-3 fw-bold" href="#"
								data-target="#borrow-info"> Borrow </a></li>
						</ul>
					</div>


					<div class="card mb-10" id="account-info">
						<div
							class="card-header d-flex align-items-center justify-content-between">
							<h3 class="card-title fw-bold m-0">Account Information</h3>

							<div class="d-flex align-items-center gap-3">
								<span id="userActiveText"
									class="fw-semibold fs-8
                                          ${selectUser.enable eq '1' ? 'text-success' : 'text-muted'}">
									${selectUser.enable eq '1' ? 'Active' : 'Inactive'} </span>

								<div id="userActiveWrapper"
									class="form-check form-switch form-check-custom form-check-solid
                                         ${selectUser.enable eq '1' ? 'form-check-success' : 'form-check-muted'}">
									<input class="form-check-input h-20px w-35px js-toggle-enable"
										type="checkbox" id="userActiveSwitch"
										<c:if test="${selectUser.enable eq '1'}">checked</c:if> />
								</div>
							</div>
						</div>

						<input type="hidden" name="user.enable" id="userEnableHidden"
							value="${selectUser.enable}" />

						<div class="card-body pt-6">
							
							<div class="row mb-8">
							<div id="errorMsgProfile" class="text-center text-danger mb-3"></div>
								<div class="col-12 d-flex justify-content-center ">
									<div id="ktImageInput" class="image-input image-input-outline"
										data-kt-image-input="true"
										style="background-image: url('${pageContext.request.contextPath}/assets/media/svg/avatars/blank.svg');">

											<div id="imageInputWrapper"
												class="border border-2 border-white rounded image-input-wrapper w-150px h-150px d-flex align-items-center justify-content-center"
												style="
								                <c:choose>
								                  <c:when test='${not empty editUserImgPath}'>
								                        background-image: url(${editUserImgPath});
								                        background-size: cover;
								                        background-position: center;
								                    </c:when>
								                   <c:otherwise>
											            background-image: url('${pageContext.request.contextPath}/assets/media/svg/avatars/blank.svg');
											            background-size: cover;
											            background-position: center;
											        </c:otherwise>
								                </c:choose>
								             ">

										</div>

										<label id="changeBtn"
											class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow"
											data-kt-image-input-action="change" data-bs-toggle="tooltip"
											data-bs-dismiss="click" title="Change avatar"> <i
											class="ki-duotone ki-pencil fs-6"> <span class="path1"></span>
												<span class="path2"></span></i> <input id="imageInputFile"
											type="file" name="fileUpload" accept=".png, .jpg, .jpeg" />

											<input id="avatarRemoveHidden" type="hidden"
											name="avatar_remove" value="false" />
										</label> <span id="cancelBtn"
											class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow"
											data-kt-image-input-action="cancel" data-bs-toggle="tooltip"
											data-bs-dismiss="click" title="Cancel avatar"> <i
											class="ki-outline ki-cross fs-3"></i>
										</span>
										<c:if test="${not empty editUserImgPath}">
											<span id="removeBtn"
												class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow"
												data-kt-image-input-action="remove" data-bs-toggle="tooltip"
												data-bs-dismiss="click" title="Remove avatar"> <i
												class="ki-outline ki-cross fs-3"></i>
											</span>
										</c:if>

									</div>
								</div>
								<div
									class="form-text fs-7 text-muted fw-medium mt-6 mb-0  d-flex justify-content-center">Allowed
									file types: png, jpg, jpeg.</div>
							</div>
							<div class="row g-9">

								<div class="col-md-6 fv-row">
									<label class="required form-label">Role</label> 
									<select
										class="form-select" name="user.roleId" data-control="select2"
										data-placeholder="Select role" data-tab="account" data-required="true" data-label="Role">
										<option></option>
										<c:forEach var="role" items="${roleList}">
											<option value="${role.id}"
												<c:if test="${selectUser.roleId eq role.id}">selected</c:if>>
												${role.id} - ${role.name}</option>
										</c:forEach>
									</select>
								</div>

								<div class="col-md-6 fv-row">
									<label class="required form-label">Gender</label>
									<div class="d-flex align-items-center mt-2 gap-8">
										<label class="form-check form-check-custom form-check-solid">
											<input class="form-check-input" type="radio" data-tab="account"  data-required="true" data-label="Gender"
											name="user.gender" value="M"
											${selectUser.gender eq 'M' ? 'checked':''}> <span
											class="form-check-label text-gray-800">Male</span>
										</label> <label class="form-check form-check-custom form-check-solid">
											<input class="form-check-input" type="radio" data-tab="account"  data-required="true" data-label="Gender"
											name="user.gender" value="F"
											${selectUser.gender eq 'F' ? 'checked':''}> <span
											class="form-check-label text-gray-800">Female</span>
										</label>
									</div>
								</div>

								<div class="col-12">
									<div class="d-flex flex-column flex-md-row gap-4">
										<div class="flex-shrink-0" style="width: 160px;">
											<label class="form-label fw-semibold text-gray-800 required">คำนำหน้า</label>
											<select class="form-select userinfo" name="user.titleNameTH" data-tab="account"  data-required="true" data-label="คำนำหน้า"
												>
												<option value="" disabled>Select</option>
												<option value="นาย"
													${selectUser.titleNameTH == 'นาย' ? 'selected' : ''}>นาย</option>
												<option value="นาง"
													${selectUser.titleNameTH == 'นาง' ? 'selected' : ''}>นาง</option>
												<option value="นางสาว"
													${selectUser.titleNameTH == 'นางสาว' ? 'selected' : ''}>นางสาว</option>
											</select>
											<div id="hintTitleTh" class="text-danger fs-8 mt-1 d-none">Please
												select a title</div>
										</div>

										<div class="flex-grow-1">
											<label class="form-label fw-semibold text-gray-800 required">ชื่อ
												- สกุล</label> <input type="text" class="form-control userinfo"
												name="user.name" maxlength="190" value="${selectUser.name}"
												placeholder="ชื่อ - สกุล" data-tab="account" data-required="true" data-label="ชื่อ-สกุล" />
											<div id="hintNameTh" class="text-danger fs-8 mt-1 d-none">Please
												enter full name</div>
										</div>
									</div>
								</div>

								<div class="col-12">
									<div class="d-flex flex-column flex-md-row gap-4">
										<div class="flex-shrink-0" style="width: 160px;">
											<label class="form-label fw-semibold text-gray-800 required">Title
												Name</label> <select class="form-select userinfo"
												name="user.titleNameEN" data-tab="account"  data-required="true" data-label="Title Name">
												<option value="" disabled>Select</option>
												<option value="Mr."
													${selectUser.titleNameEN == 'Mr.'  ? 'selected' : ''}>Mr.</option>
												<option value="Mrs."
													${selectUser.titleNameEN == 'Mrs.' ? 'selected' : ''}>Mrs.</option>
												<option value="Ms."
													${selectUser.titleNameEN == 'Ms.'  ? 'selected' : ''}>Ms.</option>
											</select>
											<div id="hintTitleEn" class="text-danger fs-8 mt-1 d-none">Please
												select a title</div>
										</div>

										<div class="flex-grow-1">
											<label class="form-label fw-semibold text-gray-800 required">Full
												Name</label> <input type="text" class="form-control userinfo"
												name="user.nameEN" maxlength="190" data-label="Full Name"
												value="${selectUser.nameEN}" placeholder="Name - Surname" data-tab="account" data-required="true"
												>
											<div id="hintNameEn" class="text-danger fs-8 mt-1 d-none">Please
												enter name</div>
										</div>
									</div>
								</div>

								<div class="col-md-6 fv-row">
									<label class="form-label">Nickname TH</label> <input
										type="text" class="form-control" name="user.nickName" data-tab="account" 
										value="${selectUser.nickName}" />
								</div>
								<div class="col-md-6 fv-row">
									<label class="form-label">Nickname EN</label> <input
										type="text" class="form-control" name="user.nickNameEN" data-tab="account" 
										value="${selectUser.nickNameEN}" />
								</div>

								<div class="col-md-6 fv-row">
									<label class="required form-label">Citizen ID</label> <input
										type="text" class="form-control" id="user_citizenId"
										name="user.citizenId" maxlength="17" inputmode="numeric" data-tab="account"  data-required="true"
										oninput="formatCitizenId(this)" data-label="Citizen ID"
										value="${selectUser.citizenId}" />

									<!-- error message -->
									<span id="citizenIdError"
										class="text-danger fs-7 fw-medium d-none mt-2 mb-0">
										Please enter a valid 13-digit.</span>
								</div>
								<div class="col-md-6 fv-row">
									<label class="form-label">Passport ID</label> <input
										type="text" class="form-control" name="user.passportId" data-tab="account"
										maxlength="10" value="${selectUser.passportId}" />
								</div>

								<div class="col-md-6 fv-row">
									<label class="required form-label">E-Mail</label> <input
										type="email" class="form-control" name="user_email" data-tab="account" data-required="true" data-label="E-Mail"
										maxlength="50" value="${selectUser.email}"/>
								</div>

								<div class="col-md-6 fv-row">
									<label class="form-label">Send Email</label>
									<div class="form-check form-check-custom form-check-solid mt-2">
										<input class="form-check-input" type="checkbox" data-tab="account" 
											id="emailEnableSwitch"
											${selectUser.emailEnable eq '1' ? 'checked':''} /> <label
											class="form-check-label" for="emailEnableSwitch"> Yes
										</label> <input type="hidden" name="user.emailEnable"
											id="emailEnableHidden" value="${selectUser.emailEnable}" />
									</div>
								</div>

								<div class="col-md-6 fv-row">
									<label class="required form-label">Phone Number</label> <input
										type="text" class="form-control" name="user.phonenum" data-tab="account"  data-required="true" data-label="Phone Number"
										oninput="formatPhone(this)" maxlength="20"
										value="${selectUser.phonenum}"  />
								</div>

								<div class="col-md-6 fv-row">
									<label class="form-label">Birth Date</label>
									<div class="position-relative">
										<i
											class="ki-duotone ki-calendar-8 fs-2 text-gray-500 position-absolute top-50 start-0 translate-middle-y ms-4">
											<span class="path1"></span><span class="path2"></span> <span
											class="path3"></span><span class="path4"></span> <span
											class="path5"></span><span class="path6"></span>
										</i> <input type="text" name="birthDate" id="birthDate"
											class="form-control ps-12" data-kt-date-picker="true"
											placeholder="1 Jan 1995" data-tab="account"  
											value="<fmt:formatDate value='${selectUser.birthDate}' pattern='yyyy-MM-dd'/>"
											autocomplete="off" />
									</div>
								</div>


								<div class="col-12 fv-row">
									<label class="form-label">Address</label>
									<textarea class="form-control" name="user.address" rows="4" data-tab="account" 
										placeholder="Please add your address">${selectUser.address}</textarea>
								</div>

								<div class="col-md-6 fv-row">
									<label class="form-label">Emergency Contact</label> <input
										type="text" class="form-control" name="user.emergContact" data-tab="account" 
										value="${selectUser.emergContact}" placeholder="Name" />
								</div>
								<div class="col-md-6 fv-row">
									<label class="form-label">Emergency Phone Number</label> <input
										type="text" class="form-control" name="user.emergPhone" data-tab="account" 
										maxlength="10" value="${selectUser.emergPhone}"
										placeholder="Phone number" />
								</div>
							</div>
						</div>
					</div>

					<div class="card mb-10" id="employee-info">
						<div class="card-header">
							<h3 class="card-title fw-bold m-0">Employee Information</h3>
						</div>

						<div class="card-body pt-6">
							<div class="row g-9">

								<div class="col-md-6 fv-row">
									<label class="required form-label">Employee Code</label> <input
										type="text" class="form-control" name="user.employeeId"
										value="${selectUser.employeeId}" data-tab="employee" data-required="true" data-label="Employee Code"/>
								</div>

								<div class="col-md-6 fv-row">
									<label class="required form-label">Employee Type</label> <select
										class="form-select" name="user.employeeTypeId"
										data-control="select2" data-placeholder="Employee type"
										data-hide-search="true" data-tab="employee" data-required="true" data-label="Employee Type">

										<option></option>

										<option value="1"
											<c:if test="${selectUser.employeeTypeId == '1'}">selected</c:if>>
											พนักงานประจำ</option>

										<option value="2"
											<c:if test="${selectUser.employeeTypeId == '2'}">selected</c:if>>
											พนักงานอัตราจ้าง</option>

										<option value="3"
											<c:if test="${selectUser.employeeTypeId == '3'}">selected</c:if>>
											นักศึกษาฝึกงาน</option>

									</select>
								</div>

								<div class="col-md-6 fv-row">
									<label class="required form-label">Department</label> <select
										class="form-select" name="department_id"
										data-control="select2" data-placeholder="Department"
										data-hide-search="true" data-tab="employee" data-required="true" data-label="Department">

										<option></option>

										<c:forEach var="department" items="${departmentList}">
											<option value="${department.id}"
												<c:if test="${selectUser.departmentId eq department.id}">selected</c:if>>
												${department.id} ${empty department.description ? '' : ' - '}${department.description}</option>
										</c:forEach>

									</select>
								</div>

								<div class="col-md-6 fv-row">
									<label class="required form-label">Position</label> <select
										class="form-select" name="position_id" data-control="select2"
										data-placeholder="Position" data-hide-search="true" data-tab="employee" data-required="true" data-label="Position">

										<option></option>

										<c:forEach var="position" items="${positionList}">
											<option value="${position.position_id}"
												<c:if test="${selectUser.positionId eq position.position_id}">selected</c:if>>
												${position.name}</option>
										</c:forEach>

									</select>
								</div>
								<div class="col-md-6 fv-row">
									<label class="required form-label">Start Working Date</label>
									<div class="position-relative">
										<i
											class="ki-duotone ki-calendar-8 fs-2 text-gray-500 position-absolute top-50 start-0 translate-middle-y ms-4">
											<span class="path1"></span><span class="path2"></span> <span
											class="path3"></span><span class="path4"></span> <span
											class="path5"></span><span class="path6"></span>
										</i> <input type="text" name="startDate" id="startDate"
											class="form-control ps-12" data-kt-date-picker="true"
											placeholder="1 Jan 2025" data-tab="employee" data-required="true" data-label="Start Working Date"
											value="<fmt:formatDate value='${selectUser.startDate}' pattern='yyyy-MM-dd'/>"
											autocomplete="off" />
									</div>
								</div>

								<div class="col-md-6 fv-row">
									<label class="form-label">Last Working Date</label>
									<div class="position-relative">
										<i
											class="ki-duotone ki-calendar-8 fs-2 text-gray-500 position-absolute top-50 start-0 translate-middle-y ms-4">
											<span class="path1"></span><span class="path2"></span> <span
											class="path3"></span><span class="path4"></span> <span
											class="path5"></span><span class="path6"></span>
										</i> <input type="text" name="endDate" id="endDate"
											class="form-control ps-12" data-kt-date-picker="true"
											placeholder="1 Jan 2025"  data-tab="employee" 
											value="<fmt:formatDate value='${selectUser.endDate}' pattern='yyyy-MM-dd'/>"
											autocomplete="off" />
									</div>
								</div>


								<div class="col-md-6 fv-row">
									<label class="required form-label">Manager</label> <select
										class="form-select" name="user.managerId" id="managerId"
										data-control="select2" data-placeholder="Manager" data-tab="employee" data-required="true" data-label="Manager">
										<option></option>
										<c:forEach var="manager" items="${userList}">
											<option value="${manager.id}"
												${selectUser.managerId eq manager.id ? 'selected':''}>
												${manager.department_id} - ${manager.id}</option>
										</c:forEach>
									</select>
								</div>

								<div class="col-md-6 fv-row">
									<label class="required form-label">Job Site</label> <select
										class="form-select" name="id_sitejob" id="id_sitejob" multiple
										data-control="select2" data-placeholder="Job site" data-tab="employee" data-required="true" data-label="Job Site">
										<c:forEach var="jobsite" items="${test}">
											<option  value="${jobsite.id_sitejob}"
												${jobsite.is_related == 1 ? 'selected':''}>
												${jobsite.name_site}</option>
										</c:forEach>
								
									</select> <input type="hidden" name="id_sitejob" id="id_sitejob_join" />
								</div>

								<div class="col-md-6 fv-row">
									<label class="required form-label">Working Day</label>
									<div class="d-flex align-items-stretch gap-3">
										<select class="form-select flex-fill" name="user.workDayStart"
											data-control="select2" data-placeholder="Select an option"
											data-hide-search="true" id="workDayStart" data-tab="employee" data-required="true" data-label="Working Day Start">
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
										</select> <span class="d-flex align-items-center">to</span> <select
											class="form-select flex-fill" name="user.workDayEnd"
											data-control="select2" data-placeholder="Select an option"
											data-hide-search="true" id="workDayEnd" data-tab="employee" data-required="true" data-label="Working Day End">
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

								<div class="col-md-6 fv-row">
									<label class="required form-label">Working Hour</label>
									<div class="d-flex align-items-stretch gap-3">
										<select class="form-select flex-fill" data-control="select2"
											data-placeholder="Select an option" data-hide-search="true"
											id="workTimeStart" name="user.workTimeStart" data-tab="employee" data-required="true" data-label="Working Hour Start">
											<option value="8:00"
												${selectUser.workTimeStart == '8:00' ? 'selected' : ''}>8:00</option>
											<option value="8:30"
												${selectUser.workTimeStart == '8:30' ? 'selected' : ''}>8:30</option>
											<option value="9:00"
												${selectUser.workTimeStart == '9:00' ? 'selected' : ''}>9:00</option>
										</select> <span class="d-flex align-items-center text-muted">to</span>
										<select class="form-select flex-fill" data-control="select2"
											data-placeholder="Select an option" data-hide-search="true"
											id="workTimeEnd" name="user.workTimeEnd" data-tab="employee" data-required="true" data-label="Working Hour End">
											<option value="17:00"
												${selectUser.workTimeEnd == '17:00' ? 'selected' : ''}>17:00</option>
											<option value="17:30"
												${selectUser.workTimeEnd == '17:30' ? 'selected' : ''}>17:30</option>
											<option value="18:00"
												${selectUser.workTimeEnd == '18:00' ? 'selected' : ''}>18:00</option>
										</select>
									</div>
								</div>

								<p class="mt-6 fw-bold text-primary fs-3">Setting For
									Working</p>

								<div class="col-md-6 fv-row">
									<label class="required form-label">Default Working</label>
									<div class="mt-2">
										<label class="form-check form-check-custom mb-6 mt-6">
											<input class="form-check-input" type="radio"
											name="user.workType" value="1" data-tab="employee" data-required="true" data-label="Default Working"
											<c:if test="${empty selectUser.workType or selectUser.workType == '1'}">checked</c:if>>
											<span class="form-check-label text-gray-800">On-Site</span>
										</label> <label class="form-check form-check-custom mb-6 mt-6">
											<input class="form-check-input" type="radio"
											name="user.workType" value="2" data-tab="employee" data-required="true" data-label="Default Working"
											<c:if test="${selectUser.workType == '2'}">checked</c:if>>
											<span class="form-check-label text-gray-800">WFH</span>
										</label>
									</div>
								</div>

								<div class="col-md-6 fv-row">
									<label class="required form-label">Number of On-Site
										Days</label>
									<div class="mt-2">
										<label class="form-check form-check-custom mb-6 mt-6">
											<input class="form-check-input" type="radio"
											name="user.onsiteNum" value="3" data-tab="employee" data-required="true" data-label="Number of On-Site Days"
											<c:if test="${empty selectUser.onsiteNum or selectUser.onsiteNum == '3'}">checked</c:if>>
											<span class="form-check-label text-gray-800 fw-500"> 4
												- 5 days (On-Site) </span>
										</label> <label class="form-check form-check-custom mb-6 mt-6">
											<input class="form-check-input" type="radio"
											name="user.onsiteNum" value="2" data-tab="employee" data-required="true" data-label="Number of On-Site Days"
											<c:if test="${selectUser.onsiteNum == '2'}">checked</c:if>>
											<span class="form-check-label text-gray-800 fw-500"> 2
												- 3 days (Hybrid) </span>
										</label> <label class="form-check form-check-custom mb-6 mt-6">
											<input class="form-check-input" type="radio"
											name="user.onsiteNum" value="1" data-tab="employee" data-required="true" data-label="Number of On-Site Days"
											<c:if test="${selectUser.onsiteNum == '1'}">checked</c:if>>
											<span class="form-check-label text-gray-800 fw-500">
												0.5 - 1 day (WFH) </span>
										</label>
									</div>
								</div>



								<p class="mt-6 fw-bold text-primary fs-3 ">Leave Quota</p>

								<div class="col-md-4 fv-row">
									<label class="form-label">ลาพักร้อน (วัน)</label> <input
										type="text" class="form-control" name="user.leaveQuota1"
										value="${selectUser.leaveQuota1}" maxlength="4" data-tab="employee"  
										onkeypress="return fun_AllowOnlyAmountAndDot(this.id);" />
								</div>

								<div class="col-md-4 fv-row">
									<label class="form-label">ลาพักร้อนที่เหลือจากปีที่แล้ว
										(วัน)</label> <input type="text" class="form-control"
										name="user.leaveQuota4" value="${selectUser.leaveQuota4}"
										maxlength="4" data-tab="employee" 
										onkeypress="return fun_AllowOnlyAmountAndDot(this.id);" />
								</div>

								<div class="col-md-4 fv-row">
									<label class="form-label">ลาป่วย (วัน)</label> <input
										type="text" class="form-control" name="user.leaveQuota3"
										value="${selectUser.leaveQuota3}" maxlength="4" data-tab="employee" 
										onkeypress="return fun_AllowOnlyAmountAndDot(this.id);" />
								</div>

							</div>
						</div>
					</div>

					<div class="card mb-10" id="education-info">
						<div class="card-header">
							<h3 class="card-title fw-bold m-0">Education</h3>
						</div>
						<div class="card-body pt-6">
							<div class="table-responsive">
								<table
									class="table align-middle table-row-dashed table-striped gy-4 gs-7">
									<thead>
										<tr
											class="text-muted fw-semibold border-bottom border-gray-200">
											<th style="width: 60px;">No</th>
											<th>Level of Education</th>
											<th style="min-width: 280px;">Name of Institute</th>
											<th style="min-width: 220px;">Duration (Year)</th>
											<th style="min-width: 260px;">Degree/Certificate</th>
										</tr>
									</thead>
									<tbody>
										<tr class="border-bottom border-gray-200">
											<td>1</td>
											<td>High School</td>
											<td><input class="form-control"
												name="user.eduInstitute1" data-tab="education"
												value="${selectUser.eduInstitute1}"></td>
											<td>
												<div class="d-flex align-items-center gap-3">
													<input class="form-control" type="number"
														name="user.eduDurStart1" data-tab="education"
														value="${selectUser.eduDurStart1}"> <span
														class="text-muted">~</span> <input class="form-control"
														type="number" name="user.eduDurEnd1"  data-tab="education"
														value="${selectUser.eduDurEnd1}">
												</div>
											</td>
											<td><input class="form-control" name="user.eduDegree1" data-tab="education"
												value="${selectUser.eduDegree1}"></td>
										</tr>
										<tr class="border-bottom border-gray-200">
											<td>2</td>
											<td>Technical/Commercial</td>
											<td><input class="form-control"
												name="user.eduInstitute2" data-tab="education"
												value="${selectUser.eduInstitute2}"></td>
											<td>
												<div class="d-flex align-items-center gap-3">
													<input class="form-control" type="number"
														name="user.eduDurStart2" data-tab="education"
														value="${selectUser.eduDurStart2}"> <span
														class="text-muted">~</span> <input class="form-control"
														type="number" name="user.eduDurEnd2" data-tab="education"
														value="${selectUser.eduDurEnd2}">
												</div>
											</td>
											<td><input class="form-control" name="user.eduDegree2" data-tab="education"
												value="${selectUser.eduDegree2}"></td>
										</tr>
										<tr class="border-bottom border-gray-200">
											<td>3</td>
											<td>University</td>
											<td><input class="form-control"
												name="user.eduInstitute3" data-tab="education"
												value="${selectUser.eduInstitute3}"></td>
											<td>
												<div class="d-flex align-items-center gap-3">
													<input class="form-control" type="number"
														name="user.eduDurStart3" data-tab="education"
														value="${selectUser.eduDurStart3}"> <span
														class="text-muted">~</span> <input class="form-control"
														type="number" name="user.eduDurEnd3" data-tab="education"
														value="${selectUser.eduDurEnd3}">
												</div>
											</td>
											<td><input class="form-control" name="user.eduDegree3" data-tab="education"
												value="${selectUser.eduDegree3}"></td>
										</tr>
										<tr class="border-bottom border-gray-200">
											<td>4</td>
											<td>Graduated School</td>
											<td><input class="form-control"
												name="user.eduInstitute4" data-tab="education"
												value="${selectUser.eduInstitute4}"></td>
											<td>
												<div class="d-flex align-items-center gap-3">
													<input class="form-control" type="number"
														name="user.eduDurStart4" data-tab="education"
														value="${selectUser.eduDurStart4}"> <span
														class="text-muted">~</span> <input class="form-control"
														type="number" name="user.eduDurEnd4" data-tab="education"
														value="${selectUser.eduDurEnd4}">
												</div>
											</td>
											<td><input class="form-control" name="user.eduDegree4" data-tab="education"
												value="${selectUser.eduDegree4}"></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>

					<div class="card mb-10" id="payment-info">
						<div class="card-header">
							<h3 class="card-title fw-bold m-0">Payment Information</h3>
						</div>
						<div class="card-body pt-6">
							<div class="row g-9">
								<div class="col-lg-6 fv-row">
									<label class="form-label d-block fw-bold">สิทธิ์เบี้ยขยัน</label>
									<div class="row g-4 mt-4">
										<div class="col-sm-6 mb-3 mt-3">
											<label
												class="form-check form-check-custom form-check-success ">
												<input class="form-check-input" type="radio" data-tab="payment" 
												name="user.incDa" value="1"
												${selectUser.incDa == '1' ? 'checked':''}> <span
												class="form-check-label text-gray-800

                                                    ">มีสิทธิ์ได้เบี้ยขยัน</span>
											</label>
										</div>
										<div class="col-sm-6 mb-3 mt-3">
											<label
												class="form-check form-check-custom form-check-success">
												<input class="form-check-input" type="radio" data-tab="payment" 
												name="user.incDa" value="2"
												${selectUser.incDa == '2' ? 'checked':''}> <span
												class="form-check-label text-gray-800">เงินเดือนรวมค่าเบี้ยขยันแล้ว</span>
											</label>
										</div>
										<div class="col-sm-6 mb-3 mt-3">
											<label
												class="form-check form-check-custom form-check-success">
												<input class="form-check-input" type="radio" data-tab="payment" 
												name="user.incDa" value="3"
												${selectUser.incDa == '3' ? 'checked':''}> <span
												class="form-check-label text-gray-800">เงินเดือนถึงเกณฑ์งดเบี้ยขยัน</span>
											</label>
										</div>
										<div class="col-sm-6 mb-3 mt-3">
											<label
												class="form-check form-check-custom form-check-primary">
												<input class="form-check-input" type="radio" data-tab="payment" 
												name="user.incDa" value="4"
												${selectUser.incDa == '4' ? 'checked':''}> <span
												class="form-check-label text-gray-800">ผ่านทดลองงานรับเบี้ยขยัน</span>
											</label>
										</div>
										<div class="col-sm-6 mb-3 mt-3">
											<label class="form-check form-check-custom form-check-danger">
												<input class="form-check-input" type="radio" data-tab="payment" 
												name="user.incDa" value="0"
												${selectUser.incDa == '0' ? 'checked':''}> <span
												class="form-check-label text-gray-800">งดเบี้ยขยัน</span>
											</label>
										</div>

									</div>
								</div>

								<div class="col-lg-6 fv-row">
									<label class="form-label d-block fw-bold">สิทธิ์ค่า
										notebook</label>
									<div class="row g-4 mt-4">
										<div class="col-sm-6 mb-3 mt-3">
											<label
												class="form-check form-check-custom form-check-success">
												<input class="form-check-input" type="radio"
												name="user.incNb" value="1" data-tab="payment" 
												${selectUser.incNb == '1' ? 'checked':''}> <span
												class="form-check-label text-gray-800">มีสิทธิ์ได้ค่า
													notebook</span>
											</label>
										</div>
										<div class="col-sm-6">
											<label
												class="form-check form-check-custom form-check-success">
												<input class="form-check-input" type="radio"
												name="user.incNb" value="2" data-tab="payment" 
												${selectUser.incNb == '2' ? 'checked':''}> <span
												class="form-check-label text-gray-800">เงินเดือนรวมค่า
													notebook แล้ว</span>
											</label>
										</div>
										<div class="col-sm-6">
											<label class="form-check form-check-custom form-check-danger">
												<input class="form-check-input" type="radio"
												name="user.incNb" value="0" data-tab="payment" 
												${selectUser.incNb == '0' ? 'checked':''}> <span
												class="form-check-label text-gray-800">งดค่า notebook</span>
											</label>
										</div>
									</div>
								</div>

								<div class="col-12 fv-row mb-4">
									<label class="form-label">Payment Remark</label>
									<textarea class="form-control" rows="3" data-tab="payment" 
										name="user.paymentRemark" placeholder="Payment remark">${selectUser.paymentRemark}</textarea>
								</div>

								<div class="separator my-5 separator-dashed"></div>

								<div class="col-md-6">
									<label class="form-check form-check-custom"> <input
										class="form-check-input" type="checkbox" id="withHoldAuto" data-tab="payment" 
										${selectUser.withHoldAuto == '1' ? 'checked':''}> <span
										class="form-check-label text-gray-800">คำนวนภาษีหัก ณ
											ที่จ่ายอัตโนมัติ</span>
									</label> <input type="hidden" name="user.withHoldAuto" 
										id="withHoldAutoHidden" value="${selectUser.withHoldAuto}" />
								</div>
								<div class="col-md-6">
									<label class="form-check form-check-custom"> <input
										class="form-check-input" type="checkbox" id="socialSecurity" data-tab="payment" 
										${selectUser.socialSecurity == 1 ? 'checked':''}> <span
										class="form-check-label text-gray-800">มีสิทธิ์ประกันสังคม</span>
									</label> <input type="hidden" name="user.socialSecurity" 
										id="socialSecurityHidden" value="${selectUser.socialSecurity}" />
								</div>

								<div class="col-md-6 fv-row">
									<label class="form-label">Tax Default</label> <input
										type="number" step="0.01" class="form-control" id="withHold" data-tab="payment" 
										name="user.withHold"
										value="${selectUser.withHold != null ? selectUser.withHold : '0.00'}"
										${selectUser.withHoldAuto == '1' ? 'disabled':''} />
								</div>
								<div class="col-md-6 fv-row">
									<label class="form-label">Tax Deduction</label> <select 
										class="form-select" name="user.taxDec" data-control="select2" data-tab="payment" >
										<option value="0" ${selectUser.taxDec == '0' ? 'selected':''}>หัก
											ณ ที่จ่าย</option>
										<option value="1" ${selectUser.taxDec == '1' ? 'selected':''}>ออกให้ตลอดไป</option>
									</select>
								</div>

								<div class="col-12 fv-row">
									<label class="form-label d-block">Transfer Type</label>
									<div class="d-flex align-items-center gap-10">
										<label class="form-check form-check-custom"> <input
											class="form-check-input" type="radio" data-tab="payment" 
											name="user.transferType" value="1"
											${selectUser.transferType != '0' ? 'checked':''}> <span
											class="form-check-label text-gray-800">โอน</span>
										</label> <label class="form-check form-check-custom"> <input
											class="form-check-input" type="radio" data-tab="payment" 
											name="user.transferType" value='0'
											${selectUser.transferType == '0' ? 'checked':''}> <span
											class="form-check-label text-gray-800">เงินสด</span>
										</label>
									</div>
								</div>

								<div class="col-md-6 fv-row">
									<label class="form-label">Bank Name</label> <input
										class="form-control" name="user.bank" data-tab="payment" 
										value="${selectUser.bank}" placeholder="Bank name">
								</div>
								<div class="col-md-6 fv-row">
									<label class="form-label">Bank Branch</label> <input
										class="form-control" name="user.bankBranch" data-tab="payment" 
										value="${selectUser.bankBranch}" placeholder="Bank branch">
								</div>

								<div class="col-md-6 fv-row">
									<label class="form-label d-block">Bank Type</label>
									<div class="d-flex align-items-center gap-10">
										<label class="form-check form-check-custom"> <input
											class="form-check-input" type="radio" name="user.bankType" data-tab="payment" 
											value="0" ${selectUser.bankType != '1' ? 'checked':''}>
											<span class="form-check-label text-gray-800">บัญชีออมทรัพย์</span>
										</label> <label class="form-check form-check-custom"> <input
											class="form-check-input" type="radio" name="user.bankType" data-tab="payment" 
											value="1" ${selectUser.bankType == '1' ? 'checked':''}>
											<span class="form-check-label text-gray-800">บัญชีกระแสรายวัน</span>
										</label>
									</div>
								</div>
								<div class="col-md-6 fv-row">
									<label class="required form-label">Bank Number</label> <input
										class="form-control" name="user.bankNum" data-tab="payment" data-required="true" data-label="Bank Number"
										value="${selectUser.bankNum}" placeholder="Bank number"
										>
								</div>
							</div>

							<input type="hidden" name="page" value="2" />

						</div>
					</div>

					<div class="text-end mt-10 d-flex justify-content-end gap-6">
						<button type="button" class="btn btn-light" id="btnCancel"
							onclick="confirmLeaveForm('user-list')">Cancel</button>
						<button type="button" class="btn btn-success" id="btnSubmit">Save</button>
					</div>
				</form>

				<form action="admin_update_password" method="post" id="resetPasswordForm" 
					 autocomplete="off">
					<input type="hidden" name="user_id" value="${selectUser.id}" />
					<div class="d-none" id="security-info">

						<div class="card mb-10">
							<div class="card-header">
								<h3 class="card-title fw-bold m-0">Security</h3>
							</div>
							<div class="card-body pt-6">
								<div class="row g-9">
									<div
										class="col d-flex align-items-center justify-content-between">
										<div class="col">
											<p class="fs-6 text-gray-800 fw-bold mb-0">Password</p>
											<p class="fs-5 text-muted fw-medium mb-0">************</p>
										</div>
										<a class="btn btn-lg btn-light fw-medium text-light-inverse"
											id="btnShowResetCard">Reset Password</a>
									</div>
								</div>
							</div>

						</div>

						<div class="card mb-10 d-none" id="resetPasswordCard">
							<div class="card-header">
								<h3 class="card-title fw-bold m-0">Security</h3>
							</div>
							<div class="card-body px-10 py-9">
								<div class="row mb-8">
									<div class="col-12 col-lg-6 mt-4 mb-0 mt-md-0 mt-lg-0">
										<label class="required fs-6 fw-medium text-gray-800  mb-2">New
											Password</label>
										<div class="position-relative">
											<input type="password" class="form-control" name="password"
												id="password" placeholder="New Password"
												autocomplete="new-password" oninput="validateNewPassword();"
												minlength="6" /> 
												<span class="btn btn-sm btn-icon position-absolute top-50 end-0 translate-middle-y toggle-password"
										         data-eye-target="password">
										   	 	<i class="ki-duotone ki-eye-slash fs-2">
												    <span class="path1"></span>
												    <span class="path2"></span>
												    <span class="path3"></span>
												    <span class="path4"></span>
												 </i>
												
												  <i class="ki-duotone ki-eye fs-2 d-none">
												    <span class="path1"></span>
												    <span class="path2"></span>
												    <span class="path3"></span>
												    <span class="path4"></span>
												  </i>
										  	</span>
										</div>

									</div>
									<div class="col-12 col-lg-6 mt-9 mt-md-4 mt-lg-0">
										<label class="required fs-6 fw-medium text-gray-800  mb-2">Confirm
											New Password</label>
										<div class="position-relative">
											<input type="password" class="form-control"
												name="confirmpassword" id="confirm_password"
												placeholder="Confirm Password"
												oninput="validateConfirmPassword()" minlength="6" /> 
												<span class="btn btn-sm btn-icon position-absolute top-50 end-0 translate-middle-y toggle-password"
										         data-eye-target="confirm_password">
										   	 	<i class="ki-duotone ki-eye-slash fs-2">
												    <span class="path1"></span>
												    <span class="path2"></span>
												    <span class="path3"></span>
												    <span class="path4"></span>
												 </i>
												
												  <i class="ki-duotone ki-eye fs-2 d-none">
												    <span class="path1"></span>
												    <span class="path2"></span>
												    <span class="path3"></span>
												    <span class="path4"></span>
												  </i>
										  	</span>
										</div>

										<span id="confirmNewPwError"
											class="text-danger fs-7 fw-medium d-none mt-2 mb-0">
											The password is incorrect. Please enter it again.</span>
									</div>

								</div>
								<p id="pwPattern" class="fs-6 fw-normal text-muted mb-0">Password
									must be at least 6 character.</p>
							</div>
							<div class="card-footer">
								<div class="text-end d-flex justify-content-end gap-6">
									<button type="button" class="btn btn-light"
										id="btnPasswordCancel">Cancel</button>
									<button type="button" class="btn btn-success" onclick="validatePassword()"
										id="btnPasswordUpdate">Update Password</button>
								</div>
							</div>
						</div>
					</div>
				</form>

				<div class="card mb-10" id="borrow-info">
					<%-- <div class="portlet light bordered" id="borrow-info">
						<div class="test">
							<jsp:include page="/pages-back/borrow/bTable.jsp" flush="true"></jsp:include>
						</div>
					</div> --%>
					
					
					
					<div class="card-header">
							<!--begin::Card title-->
							<div class="card-title">
								<h3 class="fw-semibold text-gray-900">Borrow List</h3>
							</div>
							<div class="card-toolbar">
				           		 <a href="/borrow_add" class="btn btn-primary btn-md fw-medium" target="_blank">
				                	<i class="ki-duotone ki-plus fs-4"> <span class="path1"></span> 
								</i>Add New
				            	</a>
        					</div>
						</div>
					<div class="card-body p-10 opacity-80">
							<div class="table-responsive ">
								<table
									class="table table-striped table-hover border-gray-300 table-row-bordered table-row-gray-200 ">
									<thead class="border-bottom-1">
										<tr class="fs-7 fw-bold text-gray-500">
											<th class="px-3 min-w-150px">Date Create</th>
											<th class="px-3 min-w-140px">Item No</th>
											<th class="px-3 min-w-150px">Equipment</th>
											<th class="px-3 min-w-130px">Location</th>
											<th class="px-3 min-w-130px">Status</th>
											<th class="px-3 min-w-130px">Action</th>
										</tr>
									</thead>

									<tbody>
									<c:if test="${empty borrowList}">
										<tr>
											<td colspan="6" class="text-center text-muted py-4">
												Not found borrow list.
											</td>
										</tr>
									</c:if>
										<c:forEach var="item" items="${borrowList}">
											<tr class="align-middle">
												<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">
													${item.formatted_date}
													<p class="text-gray-600 fs-6 fw-normal mb-0">${item.formatted_time}</p>
												</td>
												<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">${item.item_no}</td>
												<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">${item.name}</td>
												<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">${item.location}</td>
												<td class="px-3 py-4 ">
												<c:if test="${item.status == 'R'}">
													<span class="badge badge-lg bg-success text-white fw-semibold fs-8">Returned</span>
												</c:if> 
												<c:if test="${item.status == 'B'}">
													<span class="badge badge-lg bg-warning text-white fw-semibold fs-8">Borrowing</span>
												</c:if>
												 <c:if test="${item.status == 'W'}">
													<span class="badge badge-lg badge-secondary text-dark fw-semibold fs-8">Waiting</span>
												</c:if>
												<c:if test="${item.status == 'C'}">
													<span class="badge badge-lg bg-dark text-white fw-semibold fs-8">Cancel</span>
												</c:if> 
												<c:if test="${empty item.status || item.status == '-'}">
													<span class="badge badge-lg bg-light-secondary text-white fw-semibold fs-8">-</span>
												</c:if>
												</td>
												<td class="px-3 py-4">
												<c:if test="${item.status == 'R'}">
													<a href="/equipment_edit?id=${item.equipment_id}" target="_blank" class="btn btn-icon btn-sm btn-light-info" onclick="this.blur()">
									                	<i class="ki-duotone ki-document fs-2"> <span class="path1"></span> 
									                	<span class="path2"></span> <span class="path2"></span> 
														</i>
									            	</a>
												</c:if> 
												
												<c:if test="${item.status == 'B'}">
													<a href="/borrow_edit?id=${item.borrow_id}" target="_blank" class="btn btn-icon btn-sm btn-light-info" onclick="this.blur()">
									                	<i class="ki-duotone ki-document fs-2"> <span class="path1"></span> 
									                	<span class="path2"></span> <span class="path2"></span> 
														</i>
									            	</a>
												</c:if>
												 <c:if test="${item.status == 'W'}">
													<a href="/borrow_edit?id=${item.borrow_id}" target="_blank" class="btn btn-icon btn-sm btn-light-info" onclick="this.blur()">
									                	<i class="ki-duotone ki-document fs-2"> <span class="path1"></span> 
									                	<span class="path2"></span> <span class="path2"></span> 
														</i>
									            	</a>
									            	
												</c:if>
												<c:if test="${item.status == 'C'}">
													<a href="/equipment_edit?id=${item.equipment_id}" target="_blank" class="btn btn-icon btn-sm btn-light-info" onclick="this.blur()">
									                	<i class="ki-duotone ki-document fs-2"> <span class="path1"></span> 
									                	<span class="path2"></span> <span class="path2"></span> 
														</i>
									            	</a>
												</c:if> 
												<c:if test="${empty item.status || item.status == '-'}">
													-
												</c:if>
											<%-- <a href="/borrow_edit?id=${item.borrow_id}" class="btn btn-lg btn-light-primary">
									                	<i class="ki-duotone ki-pencil fs-4"> <span class="path1"></span> 
									                	<span class="path2"></span> <span class="path2"></span> 
														</i>
									            	</a> --%>
				            					</td>
											</tr>

										</c:forEach>
									</tbody>
								</table>
							</div>

						</div>
				</div>


			</div>
		</div>

	</div>

	<script>
	document.addEventListener("DOMContentLoaded", function() {
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
	    
	    flatpickr('[data-kt-date-picker="true"]', {
	        dateFormat: "Y-m-d",  
	        altInput: true,
	        altFormat: "d M Y",   
	        locale: "en",        
	        allowInput: false
	    });
	    
	    const citizenInput = document.getElementById("user_citizenId");
		if (citizenInput.value) {
	        formatCitizenId(citizenInput);
	    }
	});
</script>

	<script>
	function formatCitizenId(input){
		var value = input.value.replace(/\D/g, '').slice(0, 13);
		if (!value) { 
	        input.value = "";
	        document.getElementById("citizenIdError").classList.add("d-none");
	        return;
	    }
		
		var formatted = value;
		if (value.length > 1)
			formatted = value.slice(0,1) + '-' + value.slice(1);
		if (value.length > 5)
			formatted = value.slice(0,1) + '-' + value.slice(1,5) + '-' + value.slice(5);
		if (value.length > 10)
			formatted = value.slice(0,1) + '-' + value.slice(1,5) + '-' + value.slice(5,10) + '-' + value.slice(10);
		if (value.length > 12)
			formatted = value.slice(0,1) + '-' + value.slice(1,5) + '-' + value.slice(5,10) + '-' + value.slice(10,12) + '-' + value.slice(12);

		input.value = formatted;

		const error = document.getElementById("citizenIdError");
		if (value.length === 13) {
			error.classList.add("d-none");
		} else {
			error.classList.remove("d-none");
		}
	}
	
	function formatPhone(input){
		input.value = input.value.replace(/[^0-9\-a-zA-Zก-๙\s]/g, '');
	}
	</script>


	<script>
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

    function textNodeTpl (data) {
      if (!data.id) return data.text;
      const $span = $('<span/>');
      $span.text(data.id);
      return $span;
    }

/*     (function () {
      if (typeof flatpickr !== 'function') {
        console.warn('flatpickr not found');
        return;
      }

      $('[data-kt-date-picker="true"]').each(function () {
        flatpickr(this, {
          dateFormat: 'd-m-Y',
          altInput: true,
          altFormat: 'j M Y',
          allowInput: true
        });
      });
    })(); */


    (function(){
      const sw = document.getElementById('emailEnableSwitch');
      const hidden = document.getElementById('emailEnableHidden');
      if (sw && hidden) sw.addEventListener('change', ()=> hidden.value = sw.checked ? '1' : '0');
    })();

    // Active switch sync
    document.addEventListener('DOMContentLoaded', function () {
      const sw      = document.getElementById('userActiveSwitch');
      const hidden  = document.getElementById('userEnableHidden');
      const label   = document.getElementById('userActiveText');
      const wrapper = document.getElementById('userActiveWrapper');
      const badge   = document.getElementById('userActiveBadge');

      if (!sw) return;

      function syncActiveUI() {
        const isOn = sw.checked;

        if (hidden) hidden.value = isOn ? '1' : '0';

        if (label) {
          label.textContent = isOn ? 'Active' : 'Inactive';
          label.classList.remove('text-success', 'text-muted');
          label.classList.add(isOn ? 'text-success' : 'text-muted');
        }

        if (wrapper) {
          wrapper.classList.remove('form-check-success', 'form-check-muted');
          wrapper.classList.add(isOn ? 'form-check-success' : 'form-check-muted');
        }

        if (badge) {
          badge.textContent = isOn ? 'Active' : 'Inactive';
          badge.classList.remove('badge-light-success', 'badge-light-danger');
          badge.classList.add(isOn ? 'badge-light-success' : 'badge-light-danger');
        }
      }

      syncActiveUI();

      sw.addEventListener('change', syncActiveUI);
    });


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


    (function(){
      const $form = $('form[action="admin-perform-edit"]');
      const $sel  = $('#id_sitejob');
      const $hid  = $('#id_sitejob_join');

      $form.on('submit', function(){
        const vals = $sel.val() || [];
        $hid.val(vals.join(','));
        /* $sel.attr('name', 'id_sitejob_client_only'); */
      });
    })();

    // Borrow table filter/search
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

    function deleteBorrow(btn){
      const id = btn.getAttribute('data-id');
      if (!confirm('Delete this record?')) return;
      alert('Deleted (mock): ' + id);
    }

    $('[data-control="select2"]').each(function(){
      const $el = $(this);
      if ($el.hasClass('select2-hidden-accessible')) $el.select2('destroy');

      const $parent =
        $el.closest('.modal.show').find('.modal-content').first().length
          ? $el.closest('.modal.show').find('.modal-content').first()
          : $(document.body);

      $el.select2({
        width: '100%',
        minimumResultsForSearch: 5,
        dropdownParent: $parent,
        allowClear: $el.is('[data-allow-clear], [data-allow_clear]') || $el.data('allowClear') === true
      });
    });
    </script>

	<!-- <script>
    document.addEventListener("DOMContentLoaded", function () {
          const navLinks = document.querySelectorAll("#profileNav .nav-link[data-target]");

          if (!navLinks.length) {
            return;
          }

          const targets = Array.from(navLinks).map(link => link.getAttribute("data-target"));

          function showSection(targetId) {
            targets.forEach(sel => {
              const card = document.querySelector(sel);
              if (!card) return;

              if (sel === targetId) {
                card.classList.remove("d-none");
                card.style.display = "";
              } else {
                card.classList.add("d-none");
              }
            });
            toggleFormButtons(targetId);
          }

          showSection("#account-info");
          
          navLinks.forEach(link => link.classList.remove("active"));
          const defaultLink = document.querySelector('#profileNav .nav-link[data-target="#account-info"]');
          if (defaultLink) defaultLink.classList.add("active");

          navLinks.forEach(link => {
            link.addEventListener("click", function (e) {
              e.preventDefault();

              navLinks.forEach(l => l.classList.remove("active"));
              this.classList.add("active");

              const target = this.getAttribute("data-target");
              if (target) {
                showSection(target);

                const card = document.querySelector(target);
                if (card) {
                  card.scrollIntoView({ behavior: "smooth", block: "start" });
                }
              }
            });
          });
        });

    </script> -->

	<script>

    function calculateWorkDuration() {
        var container = document.getElementById('workDurationBlock');
        var label = document.getElementById('durationLabel');
        
        if (!container || !label) return;

        var startStr = container.getAttribute('data-start-date');
        if (!startStr) { label.textContent = "-"; return; }

        var startDate = new Date(startStr);
        var now = new Date();

        if (isNaN(startDate.getTime())) { label.textContent = "-"; return; }

        var years = now.getFullYear() - startDate.getFullYear();
        var months = now.getMonth() - startDate.getMonth();
        var days = now.getDate() - startDate.getDate();

        if (days < 0) {
            months--;
            var lastMonth = new Date(now.getFullYear(), now.getMonth(), 0);
            days += lastMonth.getDate(); 
        }
        if (months < 0) {
            years--;
            months += 12;
        }

        var result = [];
        if (years > 0) result.push(years + "y");
        if (months > 0) result.push(months + "m");
        if (years === 0 && months === 0) result.push(days + "d");

        label.textContent = result.join(" ");
    }

    function forceOpenTab(targetId) {
        var allCards = ['#account-info', '#employee-info', '#education-info', '#payment-info', '#security-info', '#borrow-info'];
        allCards.forEach(function(id) { $(id).addClass('d-none'); });

        $(targetId).removeClass('d-none').show();

        $('#profileNav .nav-link').removeClass('active');
        $('#profileNav .nav-link[data-target="' + targetId + '"]').addClass('active');

        if (targetId === '#security-info' || targetId === '#borrow-info') {
            $('#btnCancel, #btnSubmit').addClass('d-none');
        } else {
            $('#btnCancel, #btnSubmit').removeClass('d-none');
        }
    }


    $(document).ready(function() {
        
       /*  if (typeof flatpickr === 'function') {
            $('[data-kt-date-picker="true"]').each(function() {
                flatpickr(this, { dateFormat: 'd-m-Y', altInput: true, altFormat: 'j M Y', allowInput: true });
            });
        } */
        $('[data-control="select2"]').each(function() {
            if ($(this).hasClass('select2-hidden-accessible')) return;
            $(this).select2({ width: '100%', minimumResultsForSearch: 5 });
        });

        $('[data-kt-image-input-action="remove"]').click(function() {
            $('#avatarRemoveHidden').val('true');
        });

        $('#imageInputFile').change(function() {
            $('#avatarRemoveHidden').val('false');
        });
        $('[data-kt-image-input-action="cancel"]').click(function() {
            $('#avatarRemoveHidden').val('false');
        });

        $('#emailEnableSwitch').change(function() { $('#emailEnableHidden').val(this.checked ? '1' : '0'); });
        $('#socialSecurity').change(function() { $('#socialSecurityHidden').val(this.checked ? '1' : '0'); });
        $('#withHoldAuto').change(function() {
            var on = this.checked;
            $('#withHoldAutoHidden').val(on ? '1' : '0');
            $('#withHold').prop('disabled', on).val(on ? '0.00' : '');
        });
        $('form[action="admin-perform-edit"]').on('submit', function() {
            var vals = $('#id_sitejob').val() || [];
            $('#id_sitejob_join').val(vals.join(','));
            $('#id_sitejob').attr('name', 'id_sitejob_client_only');
        });

        forceOpenTab('#account-info');
        calculateWorkDuration();       

        $('#profileNav .nav-link').on('click', function(e) {
            e.preventDefault();
            var target = $(this).attr('data-target');
            forceOpenTab(target);
            $('html, body').animate({ scrollTop: $(target).offset().top - 120 }, 300);
        });

        $('#btnSubmit').on('click', function (e) {
        	  e.preventDefault();

        	  const activeSection = getActiveTabElement();
        	  const errorFields = validateActiveTab(activeSection);

        	  const errorMsgProfile = document.getElementById("errorMsgProfile");
    		  if (errorMsgProfile && errorMsgProfile.textContent.trim() !== "") {
    			  window.scrollTo({
    			        top: 0,
    			        behavior: "smooth"
    			    });
    			  return false; 
    		  }
    		  
        	  if (errorFields.length > 0) {
        	    Swal.fire({
        	      title: "Please complete the form!",
        	      html: "Please fill in the following fields:<br><strong>"
        	            + errorFields.join(", ") + "</strong>",
        	      icon: "error",
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
        	    cancelButtonText: "Close",
        	    buttonsStyling: false,
        	    customClass: {
        	      confirmButton: "btn btn-success",
        	      cancelButton: "btn btn-secondary"
        	    }
        	  }).then((result) => {
        	    if (result.isConfirmed) {
        	    	const citizenIdInput = document.getElementById("user_citizenId");
		            if (citizenIdInput) {
		                citizenIdInput.value = citizenIdInput.value.replace(/\D/g, '');
		            }
		            
        	      document.querySelector('form[action="admin-perform-edit"]').submit();
        	    }
        	  });
        	});


       /*  $('#btnCancel').click(function() { window.location.href = 'user-list'; }); */

        $('#btnDelete').click(function() {
            var userId = $(this).data('user-id');
            if (!userId) return;
            Swal.fire({
                title: 'Are you sure?!', text: "This data will be permanently deleted.", icon: 'warning',
                showCancelButton: true, confirmButtonText: 'Confirm'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.post('${pageContext.request.contextPath}/user-delete.action', { id: userId })
                     .done(function() { Swal.fire('Deleted!', '', 'success').then(() => window.location.href = 'user-list'); })
                     .fail(function() { Swal.fire('Error', 'ไม่สามารถลบได้ เนื่องจากมีการลง Check-In หรือ Check-Out ในระบบแล้ว', 'error'); });
                }
            });
        });

        $('#btnShowResetCard').click(function() {
            $('#resetPasswordCard').removeClass('d-none');
            $('html, body').animate({ scrollTop: $("#resetPasswordCard").offset().top - 100 }, 500);
        });
       /*  $('#btnPasswordCancel').click(function() {
            $('#resetPasswordCard').addClass('d-none');
            $('#password, #confirm_password').val('');
            $('#passwordMessage').html('');
        }); */
        $('#btnPasswordCancel').click(function () {
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
                    $('#resetPasswordCard').addClass('d-none');
                    $('#password, #confirm_password').val('');
                    $('#passwordMessage').html(''); 
                    
                    $('#password').removeClass('is-invalid');
                    $('#confirm_password').removeClass('is-invalid');
                    $('#confirmNewPwError').addClass('d-none');
                    $('#pwPattern')
                        .removeClass('text-danger')
                        .addClass('text-muted');
                }
            });
        });

        /* $('#password, #confirm_password').keyup(function() {
            var p = $('#password').val(), c = $('#confirm_password').val();
            if(p == "" && c == "") { $('#passwordMessage').html(''); return; }
            $('#passwordMessage').html(p == c ? '<span class="text-success">ตรงกัน</span>' : '<span class="text-danger">ไม่ตรงกัน</span>');
        });
        $('#btnPasswordUpdate').click(function() {
           var p = $('#password').val(), c = $('#confirm_password').val();
            if(p === "" || c === "") { alert('กรุณากรอกรหัสผ่าน'); return; }
            if(p !== c) { alert('รหัสผ่านไม่ตรงกัน'); return; }
            $('form[action="admin-perform-edit"]').submit(); 
        }); */

        var getUrlParameter = function getUrlParameter(sParam) {
            var sPageURL = window.location.search.substring(1),
                sURLVariables = sPageURL.split('&'), sParameterName, i;
            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('=');
                if (sParameterName[0] === sParam) return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
            }
            return false;
        };
        var msg = getUrlParameter('massage');
        if (msg === '11') {
            $('#resetPasswordCard').removeClass('d-none');
            if(typeof swal !== 'undefined') swal({ title: "Error", text: "Something went wrong", type: "error", confirmButtonText: "OK" });
        } else if (msg === 'success') {
            if(typeof swal !== 'undefined') swal({ title: "Success", text: "Update Success", type: "success", confirmButtonText: "OK" });
        }
    });
</script>


	<script>
	function confirmLeaveForm(redirectUrl){
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
	            window.location.href = redirectUrl;
	        }
	    });
	}
</script>

<script>
	function getActiveTabElement() {
		  const target = $('#profileNav .nav-link.active').data('target');
		  return target ? document.querySelector(target) : null;
		}

	function validateActiveTab(activeSection) {
	    const errorFields = [];
	    const checkedGroup = new Set();

	    if (!activeSection) return errorFields;

	    activeSection.querySelectorAll('[data-required="true"]').forEach(el => {

	        if (el.type === 'radio' || el.type === 'checkbox') {
	            if (checkedGroup.has(el.name)) return;
	            checkedGroup.add(el.name);

	            const checked = activeSection.querySelector("input[name='" + el.name + "']:checked");

	            if (!checked) {
	                errorFields.push(el.dataset.label || el.name);
	                el.closest('.fv-row')?.classList.add('is-invalid');
	            } else {
	                el.closest('.fv-row')?.classList.remove('is-invalid');
	            }
	        } else {
	            if (!el.value || el.value.trim() === "" || el.value === "null") {
	                errorFields.push(el.dataset.label || el.name);
	                el.classList.add('is-invalid');
	            } else {
	                el.classList.remove('is-invalid');
	            }
	        }
	    });

	    return errorFields;
	}
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

	var isNewPwValid = false;
		
	function validateNewPassword() {
	    const password = document.getElementById("password").value.trim();
	    const pattern = /^\S{6,}$/;

	    if (password === "") {
	        setPwPattern("normal");
	        isNewPwValid = false;
	        return false;
	    }

	    if (!pattern.test(password)) {
	        setPwPattern("error");  
	        isNewPwValid = false;
	        return false;
	    }

	    setPwPattern("normal");
	    isNewPwValid = true;
	    return true;
	}
	

	
	function validateConfirmPassword() {
	    const password = document.getElementById("password");
	    const confirmPassword = document.getElementById("confirm_password");
	    const errorEl = document.getElementById("confirmNewPwError");

	    if (confirmPassword.value.trim() === "") {
	        confirmPassword.classList.remove("is-invalid");
	        errorEl.classList.add("d-none");
	        return true;
	    }

	    if (password.value !== confirmPassword.value) {
	    	confirmPassword.classList.add("is-invalid");
	    	errorEl.classList.remove("d-none"); 
	        return false;
	    }

	    confirmPassword.classList.remove("is-invalid");
	    errorEl.classList.add("d-none");
	    return true;
	}

	function validatePassword() {
	    var errorFields = [];
	    var isValid = true;

	    const newPwInput = document.getElementById("password");
	    const newPwValue = newPwInput.value.trim();
	    const confirmNewPw = document.getElementById("confirm_password").value.trim();

	  
	        if (!newPwValue){
	        	errorFields.push("New Password");
	        }
	        if (!confirmNewPw) {
		        errorFields.push("Confirm New Password");
		    }

	    if (errorFields.length > 0) {
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

	    if (!newPwInput.disabled) {
	        //เรียกfunc ให้update สถานะล่าสุด
	        const isPwPatternOk = validateNewPassword(); 
	        const isConfirmOk = validateConfirmPassword();

	        if (!isPwPatternOk || !isConfirmOk) {
	            isValid = false;
	        }
	    }

	    if (!isValid) return false;

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
	            document.getElementById("resetPasswordForm").submit();
	        }
	    });
	}
	
	function setPwPattern(state){
		 const pwPattern = document.getElementById("pwPattern");
		 const passwordInput = document.getElementById("password");
		  if (!pwPattern || !passwordInput) return;

		  pwPattern.classList.remove("text-muted", "text-danger");
		   passwordInput.classList.remove("is-invalid");
		 
		 if(state === "error"){
			 pwPattern.classList.add("text-danger");
			 passwordInput.classList.add("is-invalid");
		 }else{
			 pwPattern.classList.add("text-muted");
		 }
	 }
	 
</script>


</body>
</html>