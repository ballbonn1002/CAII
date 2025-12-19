<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
	background-color: #009ef7 !important;
	border-color: #009ef7 !important;
	color: #fff !important;
}
</style>

</head>

<body class="app-default">
	<div class="app-main flex-column flex-row-fluid">
		<div class="d-flex flex-column flex-column-fluid">
			<div class="app-toolbar py-3 py-lg-6">
				<div class="app-container container-xxl" id="pageRoot">
					<div
						class="page-title d-flex flex-row align-items-center justify-content-between me-3 mb-6">

						<div class="d-flex flex-column flex-wrap gap-2 gap-lg-3">
							<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 my-0">
								My Profile</h1>

							<ul
								class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0">
								<li class="breadcrumb-item text-muted"><a
									href="${pageContext.request.contextPath}/demo_dashboard"
									class="text-muted text-hover-primary"> Home </a></li>
							</ul>
						</div>
						<input type="hidden" name="user.id" value="${selectUser.id}" />
					</div>


					<div class="card mb-10">
						<div class="card-body pt-6 pb-0">
							<div class="d-flex flex-column flex-md-row align-items-start">

								<div class="me-md-9 mb-md-0" style="width: 150px;">
									<div
										class="border border-2 border-default rounded-sm overflow-hidden mb-3"
										style="width: 130px; aspect-ratio: 1/1;">
										<c:choose>
											<c:when test="${not empty user.path}">
												<img id="avatarPreview" src="${user.path}"
													alt="${not empty user.nameEN ? user.nameEN : user.name}"
													class="w-100 h-100 rounded" style="object-fit: cover;">
											</c:when>
											<c:otherwise>
												<div id="avatarPreview"
													class="w-100 h-100 rounded d-flex align-items-center justify-content-center"
													style="background-color: #f3f6f9; font-size: 48px; color: #0d6efd;">
													<c:choose>
														<c:when
															test="${not empty user.nameEN and fn:length(user.nameEN) >= 1}">
                                                            ${fn:toUpperCase(fn:substring(user.nameEN, 0, 1))}
                                                        </c:when>
														<c:when
															test="${not empty user.name and fn:length(user.name) >= 1}">
                                                            ${fn:toUpperCase(fn:substring(user.name, 0, 1))}
                                                        </c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose>
												</div>
											</c:otherwise>
										</c:choose>
									</div>
								</div>

								<div class="flex-grow-1 ">
									<div
										class="d-flex justify-content-between aling-items-start flex-wrap mb-5">
										<div class="d-flex flex-column">
											<div class="d-flex align-items-center gap-4">
												<p class="fs-2 fw-bold text-gray-900  mb-0">${user.id}</p>

												<c:forEach var="jobSite" items="${jobSite}">
													<span
														class="badge bg-primary rounded-2 px-2 py-1 text-white fw-semibold">${jobSite.name_site}</span>
												</c:forEach>

												<!-- <span
												class="badge bg-primary rounded-2 px-2 py-1 text-white fw-semibold">AIS
												DBP</span> 
												<span
												class="badge bg-primary rounded-2 px-2 py-1 text-white fw-semibold">KTB</span> -->
											</div>
											<div class="d-flex flex-wrap">
												<span class="fs-4 fw-normal text-gray-900">${user.employeeId}
													${user.nameEN} - ${user.name}</span>
											</div>

										</div>
										<div class="d-flex ms-auto">
											<c:if test="${user.enable eq '1'}">
												<p>
													<span
														class="badge rounded-2 bg-light-success text-success px-2 py-1 fw-semibold">Active</span>
												</p>

											</c:if>
											<c:if test="${user.enable ne '1'}">
												<p>
													<span
														class="badge rounded-2 bg-light-danger text-danger px-2 py-1 fw-semibold">Inactive</span>
												</p>
											</c:if>
										</div>
									</div>
									<div class="d-flex flex-wrap gap-4">
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-4 fw-bold text-gray-900 mb-0">
													${workPeriod}</p>
												<p class="fs-6 fw-bold text-gray-600 mb-0">
													<c:choose>
														<c:when test="${empty user.startDate}">
														</c:when>
														<c:otherwise>
															<fmt:formatDate value="${user.startDate}"
																pattern="dd MMM yyyy" />
														</c:otherwise>
													</c:choose>

												</p>
											</div>
										</div>
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-4 fw-bold text-gray-900 mb-0">${user.positionId}</p>
												<p class="fs-6 fw-bold text-gray-600 mb-0">Position</p>
											</div>
										</div>
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-4 fw-bold text-gray-900 mb-0">${user.departmentId}</p>
												<p class="fs-6 fw-bold text-gray-600 mb-0">Department</p>
											</div>
										</div>
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-4 fw-bold text-gray-900 mb-0">${user.workType == 1 ? 'On-site' : 'WFH'}</p>
												<p class="fs-6 fw-bold text-gray-600 mb-0">
													${user.onsiteNum == 3 ? '4–5 Day' :
          							          user.onsiteNum == 2 ? '2–3 Day' :
          							          user.onsiteNum == 1 ? '0.5–1 Day' : 'N/A'}</p>
											</div>
										</div>
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-4 fw-bold text-gray-900 mb-0">${user.workDayStart == 1 ? 'Mon' :
 											user.workDayStart == 2 ? 'Tue' :
 											user.workDayStart == 3 ? 'Wed' :
 											user.workDayStart == 4 ? 'Thu' :
 											user.workDayStart == 5 ? 'Fri' :
 											user.workDayStart == 6 ? 'Sat' :
 											user.workDayStart == 7 ? 'Sun' : ''}
													${user.workDayEnd == 1 ? '- Mon' :
 											user.workDayEnd == 2 ? '- Tue' :
 											user.workDayEnd == 3 ? '- Wed' :
 											user.workDayEnd == 4 ? '- Thu' :
 											user.workDayEnd == 5 ? '- Fri' :
 											user.workDayEnd == 6 ? '- Sat' :
 											user.workDayEnd == 7 ? '- Sun' : ''}</p>
												<p class="fs-6 fw-bold text-gray-600 mb-0">${user.workTimeStart}
													- ${user.workTimeEnd}</p>
											</div>
										</div>
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-4 fw-bold text-gray-900 mb-0">${user.employeeTypeId == 1 ? 'พนักงานประจำ' 
											: user.employeeTypeId == 2 ? 'พนักงานอัตราจ้าง'
											: 'นักศึกษาฝึกงาน'}</p>
												<p class="fs-6 fw-bold text-gray-600 mb-0">Employee Type</p>
											</div>
										</div>
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-4 fw-bold text-gray-900 mb-0">${manager.managerNameEn}</p>
												<p class="fs-6 fw-bold text-gray-600 mb-0">Manager</p>
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
								href="#" data-target="#account-info"> Overview </a></li>

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
							<h3 class="card-title fw-bold m-0">Account Info</h3>

							<a class="btn btn-light py-4 px-6 align-self-center rounded-1"
								href="#" data-target="#edit_overview">Edit</a>
						</div>

						<div class="card-body px-9 pt-9">
							<div class="row">
								<div class="col-6 gap-2">
									<p class="fs-5 text-muted fw-medium mb-0">Nickname TH</p>
									<%-- <p class="fs-5 text-gray-800 fw-semibold">${user.titleNameTH}
									${user.name} - ${user.nickName}</p> --%>
									<p class="fs-5 text-gray-800 fw-semibold">${user.nickName}</p>
								</div>
								<div class="col-6">
									<p class="fs-5 text-muted fw-medium mb-0">Nickname EN</p>
									<%-- <p class="fs-5 text-gray-800 fw-semibold">${user.titleNameEN}
									${user.nameEN} - ${user.nickNameEN}</p> --%>
									<p class="fs-5 text-gray-800 fw-semibold">${user.nickNameEN}</p>
								</div>
							</div>
							<div class="row">
								<div class="col-6 gap-2">
									<p class="fs-5 text-muted fw-medium mb-0">Gender</p>
									<p class="fs-5 text-gray-800 fw-semibold">${empty user.gender ? '-' : (user.gender == 'M' ? 'Male' : 'Female')}</p>
								</div>
								<div class="col-6">
									<p class="fs-5 text-muted fw-medium mb-0">Birth Date</p>
									<p class="fs-5 text-gray-800 fw-semibold">
										<c:choose>
											<c:when test="${empty user.birthDate}">
											</c:when>
											<c:otherwise>
												<fmt:formatDate value="${user.birthDate}"
													pattern="dd MMM yyyy" />
											</c:otherwise>
										</c:choose>
									</p>
								</div>
							</div>
							<div class="row">
								<div class="col-6 gap-2">
									<p class="fs-5 text-muted fw-medium mb-0">Citizen ID</p>
									<p class="fs-5 text-gray-800 fw-semibold">${empty user.citizenId ? '-' : user.citizenId}</p>
								</div>
								<div class="col-6">
									<p class="fs-5 text-muted fw-medium mb-0">Passport ID</p>
									<p class="fs-5 text-gray-800 fw-semibold">${empty user.passportId ? '-' : user.passportId}</p>
								</div>
							</div>
							<div class="row">
								<div class="col-6 gap-2">
									<p class="fs-5 text-muted fw-medium mb-0">E-Mail</p>
									<p class="fs-5 text-gray-800 fw-semibold">${empty user.email ? '-' : user.email }</p>
								</div>
								<div class="col-6">
									<p class="fs-5 text-muted fw-medium mb-0">Phone Number</p>
									<p class="fs-5 text-gray-800 fw-semibold">${empty user.phonenum ? '-' : user.phonenum }</p>
								</div>
							</div>
							<div class="row">
								<div class="col-12 gap-2">
									<p class="fs-5 text-muted fw-medium mb-0">Address</p>
									<p class="fs-5 text-gray-800 fw-semibold">${empty user.address ? '-' : user.address}</p>
								</div>

							</div>
							<div class="row">
								<div class="col-6">
									<p class="fs-5 text-muted fw-medium mb-0">Emergency Contact</p>
									<p class="fs-5 text-gray-800 fw-semibold">${empty user.emergContact ? '-' : user.emergContact }</p>
								</div>
								<div class="col-6 gap-2">
									<p class="fs-5 text-muted fw-medium mb-0">Emergency Phone</p>
									<p class="fs-5 text-gray-800 fw-semibold">${empty user.emergPhone ? '-' : user.emergPhone }</p>
								</div>

							</div>


						</div>

					</div>


					<div class="card mb-10" id="edit_overview">

						<!--begin::Card header-->
						<div class="card-header">
							<!--begin::Card title-->
							<div class="card-title">
								<h3 class="fw-semibold text-gray-900">Account Info</h3>
							</div>



						</div>
						<!--end::Card header-->

						<form id="formUpdateOverview" action="update_my_profile"
							method="POST" class="form" autocomplete="off" enctype="multipart/form-data"
							onsubmit="return submitForm()">
							<div class="card-body px-9 pt-9">

								<div class="row mb-8">
									<div class="col-12 d-flex justify-content-center ">
										<div id="ktImageInput" class="image-input image-input-outline"
											data-kt-image-input="true"
											style="background-image: url('${pageContext.request.contextPath}/assets/media/svg/avatars/blank.svg');">

											<div id="imageInputWrapper"
												class="image-input-wrapper w-150px h-150px d-flex align-items-center justify-content-center"
												style="
								                <c:choose>
								                    <c:when test='${not empty user.path}'>
								                        background-image: url(${user.path});
								                        background-size: cover;
								                        background-position: center;
								                    </c:when>
								                    <c:otherwise>
								                        background-color: #f3f6f9; 
								                        background-image: none;
								                    </c:otherwise>
								                </c:choose>
								             ">

												<c:if test="${empty user.path}">
													<span class="initials-text"> <c:choose>
															<c:when
																test="${not empty user.nameEN and fn:length(user.nameEN) >= 1}">
								                            ${fn:toUpperCase(fn:substring(user.nameEN, 0, 1))}
								                        </c:when>
															<c:when
																test="${not empty user.name and fn:length(user.name) >= 1}">
								                            ${fn:toUpperCase(fn:substring(user.name, 0, 1))}
								                        </c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</span>
												</c:if>
											</div>

											<label id="changeBtn"
												class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow"
												data-kt-image-input-action="change" data-bs-toggle="tooltip"
												data-bs-dismiss="click" title="Change avatar"> <i
												class="ki-duotone ki-pencil fs-6"><span class="path1"></span><span
													class="path2"></span></i> <input id="imageInputFile"
												type="file" name="fileUpload" accept=".png, .jpg, .jpeg" />

												<input id="avatarRemoveHidden" type="hidden"
												name="avatar_remove" value="false" />
											</label> <span id="cancelBtn"
												class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow"
												data-kt-image-input-action="cancel" data-bs-toggle="tooltip"
												data-bs-dismiss="click" title="Cancel avatar"> <i
												class="ki-outline ki-cross fs-3"></i>
											</span> <span id="removeBtn"
												class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow"
												data-kt-image-input-action="remove" data-bs-toggle="tooltip"
												data-bs-dismiss="click" title="Remove avatar"> <i
												class="ki-outline ki-cross fs-3"></i>
											</span>
										</div>
									</div>
									<div
										class="form-text fs-7 text-muted fw-medium mt-6 mb-0  d-flex justify-content-center">Allowed
										file types: png, jpg, jpeg.</div>
								</div>


								<div class="row mb-8">
									<div class="col-2 gap-2">
										<label class="required fs-6 fw-medium text-gray-800 mb-2">คำนำหน้า</label>
										<select name="titleNameTH" data-control="select2"
											data-placeholder=""
											class="form-select py-2 px-4 border border-gray-300">
											<option value="นาย"
												${user.titleNameTH == 'นาย' ? 'selected' : ''}>นาย</option>
											<option value="นาง"
												${user.titleNameTH == 'นาง' ? 'selected' : ''}>นาง</option>
											<option value="นางสาว"
												${user.titleNameTH == 'นางสาว' ? 'selected' : ''}>นางสาว</option>
										</select>
									</div>
									<div class="col-5">
										<label class="required fs-6 fw-medium text-gray-800 mb-2">ชื่อ
											สกุล</label> <input type="text"
											class="form-control py-2 px-4 border border-gray-300"
											placeholder="" name="name" id="name" value="${user.name}" />
									</div>
									<div class="col-5">
										<label class="required fs-6 fw-medium text-gray-800 mb-2">Nickname
											TH</label> <input type="text"
											class="form-control py-2 px-4 border border-gray-300"
											placeholder="" name="nickName" id="nickName"
											value="${user.nickName}" />
									</div>
								</div>

								<div class="row mb-8">
									<div class="col-2 gap-2 ">
										<label class="required fs-6 fw-medium text-gray-800 mb-2">Title
											Name</label> <select name="titleNameEN" data-control="select2"
											data-placeholder=""
											class="form-select py-2 px-4 border border-gray-300">
											<option value="Mr."
												${user.titleNameEN == 'Mr.' ? 'selected' : ''}>Mr.</option>
											<option value="Mrs."
												${user.titleNameEN == 'Mrs.' ? 'selected' : ''}>Mrs.</option>
											<option value="Miss"
												${user.titleNameEN == 'Miss' ? 'selected' : ''}>Miss</option>
											<option value="Ms."
												${user.titleNameEN == 'Ms.' ? 'selected' : ''}>Ms.</option>
										</select>

									</div>
									<div class="col-5">
										<label class="required fs-6 fw-medium text-gray-800 mb-2">Full
											Name EN</label> <input type="text"
											class="form-control py-2 px-4 border border-gray-300"
											placeholder="" name="nameEN" id="nameEN"
											value="${user.nameEN}" pattern="[A-Za-z ]+"
											oninput="this.value = this.value.replace(/[^A-Za-z ]/g, '')" />
									</div>
									<div class="col-5">
										<label class="required fs-6 fw-medium text-gray-800 mb-2">Nickname
											EN</label> <input type="text"
											class="form-control py-2 px-4 border border-gray-300"
											placeholder="" name="nickNameEN" id="nickNameEN"
											value="${user.nickNameEN}" pattern="[A-Za-z ]+"
											oninput="this.value = this.value.replace(/[^A-Za-z ]/g, '')" />
									</div>
								</div>

								<div class="row mb-8">
									<div class="col-6 gap-2">
										<p class="required fs-6 fw-medium text-gray-800 mb-2">Gender</p>

										<div class="form-check form-check-inline mt-1">
											<!-- <input type="radio" id="genderMale" name="gender"
											class="form-check-input" value="M" /> -->
											<input type="radio" name="gender" class="form-check-input"
												value="M" ${user.gender == 'M' ? 'checked' : ''} required />
											<label class="form-check-label fs-6 text-gray-800 fw-normal"
												for="genderMale">Male</label>
										</div>

										<div class="form-check form-check-inline mt-1">
											<!-- <input type="radio" id="genderFemale" name="gender"
											class="form-check-input" value="F" />  -->
											<input type="radio" name="gender" class="form-check-input"
												value="F" ${user.gender == 'F' ? 'checked' : ''} /> <label
												class="form-check-label fs-6 text-gray-800 fw-normal"
												for="genderFemale">Female</label>
										</div>
									</div>
									<div class="col-6">
										<p class="required fs-6 fw-medium text-gray-800 mb-2">Birth
											Date</p>
										<div class="position-relative">
											<i
												class="ki-duotone ki-calendar-8 text-gray-500 position-absolute top-50 translate-middle-y ms-4">
												<span class="path1"></span><span class="path2"></span> <span
												class="path3"></span><span class="path4"></span> <span
												class="path5"></span><span class="path6"></span>
											</i> <input type="text" id="birthDate" name="birthDate"
												class="form-control ps-10 date-picker"
												placeholder="1 Jan 2025" autocomplete="off"
												value="<fmt:formatDate value='${user.birthDate}' pattern='dd MMM yyyy'/>"
												required />
										</div>


									</div>
								</div>
								<div class="row mb-8">
									<div class="col-6 gap-2">
										<p class="required fs-6 fw-medium text-gray-800 mb-2">Citizen
											ID</p>
										<input type="text"
											class="form-control py-2 px-4 border border-gray-300"
											placeholder="" name="citizenId" id="citizenId"
											value="${user.citizenId}" maxlength="13" inputmode="numeric"
											oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0,13)" />

									</div>
									<div class="col-6">
										<p class="fs-6 fw-medium text-gray-800 mb-2">Passport ID</p>
										<input type="text"
											class="form-control py-2 px-4 border border-gray-300"
											placeholder="" name="passportId" value="${user.passportId}" />

									</div>
								</div>
								<div class="row mb-8">
									<div class="col-6 gap-2">
										<p class="required fs-6 fw-medium text-gray-800 mb-2">E-Mail</p>
										<input type="email"
											class="form-control py-2 px-4 border border-gray-300"
											placeholder="" name="email" id="email" value="${user.email}" />

									</div>
									<div class="col-6">
										<p class="required fs-6 fw-medium text-gray-800 mb-2">Phone
											Number</p>
										<input type="text"
											class="form-control py-2 px-4 border border-gray-300"
											placeholder="" name="phonenum" id="phonenum"
											value="${user.phonenum}" maxlength="10" inputmode="numeric"
											oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0,10)" />

									</div>
								</div>
								<div class="row mb-8">
									<div class="col-12 gap-2">
										<p class="fs-6 fw-medium text-gray-800 mb-2">Address</p>

										<textarea rows="3" cols=""
											class="form-control py-2 px-4 border border-gray-300"
											placeholder="" name="address">${user.address}</textarea>
									</div>

								</div>
								<div class="row ">
									<div class="col-6">
										<p class="fs-6 fw-medium text-gray-800 mb-2">Emergency
											Contact</p>
										<input type="text"
											class="form-control py-2 px-4 border border-gray-300"
											placeholder="" name="emergContact"
											value="${user.emergContact}" />

									</div>
									<div class="col-6 gap-2">
										<p class="fs-6 fw-medium text-gray-800 mb-2">Emergency
											Phone</p>
										<input type="text"
											class="form-control py-2 px-4 border border-gray-300"
											placeholder="" name="emergPhone" value="${user.emergPhone}"
											maxlength="10" inputmode="numeric"
											oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0,10)" />

									</div>

								</div>
							</div>
							<div class="card-footer d-flex justify-content-end">
								<button type="button"
									onclick="window.location.href='my_profile'"
									class="btn btn-light text-light-inverse fw-medium rounded me-2 py-4">Cancel
								</button>
								<button type="submit"
									class="btn btn-success text-white fw-medium rounded py-4">Save</button>
							</div>
						</form>

					</div>

					<div class="card mb-10" id="security-info">
						<div class="card-header">
							<!--begin::Card title-->
							<div class="card-title">
								<h3 class="fw-semibold text-gray-900">Security</h3>
							</div>

						</div>
						<!--end::Card header-->
						<div class="card-body px-9 pt-9">
							<div
								class="col d-flex align-items-center justify-content-between">
								<div class="col">
									<p class="fs-6 text-gray-800 fw-bold mb-0">Password</p>
									<p class="fs-5 text-muted fw-medium">************</p>
								</div>

								<a
									class="btn btn-light py-4 px-6 rounded-1 text-light-inverse fw-medium fs-5"
									href="#" data-target="#reset_password">Reset Password</a>


							</div>
						</div>
					</div>

					<div class="card mb-10" id="reset_password">
						<!--begin::Card header-->
						<div class="card-header">
							<!--begin::Card title-->
							<div class="card-title">
								<h3 class="fw-semibold text-gray-900">Security</h3>
							</div>

						</div>
						<!--end::Card header-->
						<form action="update_password" method="POST"
							id="resetPasswordForm" autocomplete="off">
							<div class="card-body px-9 pt-9">
								<div class="row mb-8">
									<div class="col-4 gap-2">
										<label class="required fs-6 fw-medium text-gray-800 mb-2">Current
											Password</label> <input type="password"
											class="form-control py-2 px-4 border border-gray-300"
											placeholder="" name="currentPw" id="currentPw"
											oninput="validateCurrentPassword();" />

										<!-- error message -->
										<span id="currentPwError"
											class="text-danger fs-7 fw-medium d-none mt-2  mb-0">
											Incorrect password </span>
									</div>
									<div class="col-4">

										<label class="required fs-6 fw-medium text-gray-800 mb-2">New
											Password</label> <input type="password"
											class="form-control py-2 px-4 border border-gray-300"
											placeholder="" name="newPw" id="newPw"
											oninput="validateNewPassword();" minlength="6" disabled />
										<!-- error message -->
										<span id="newPwError"
											class="text-danger fs-8 fw-medium d-none mt-2  mb-0">
											New password must be different from Current Password </span>

									</div>
									<div class="col-4">
										<label class="required fs-6 fw-medium text-gray-800 mb-2">Confirm
											New Password</label> <input type="password"
											class="form-control py-2 px-4 border border-gray-300"
											placeholder="" name="confirmNewPw" id="confirmNewPw"
											oninput="validateConfirmPassword()" minlength="6" disabled />
										<!--  pattern="^(?=.*[A-Za-z])(?=.*[^A-Za-z0-9])[!-~]{6,}$" -->


										<!-- error message -->
										<span id="confirmNewPwError"
											class="text-danger fs-8 fw-medium d-none mt-2 mb-0">
											Please fill in New Password and Confirm New Password with the
											same value. </span>

									</div>

								</div>
								<p id="pwPattern" class="fs-6 fw-normal text-muted mb-0">Password
									must be at least 6 character and contain symbols</p>
							</div>
							<div class="card-footer d-flex justify-content-end">
								<button type="button"
									onclick="window.location.href='security_password'"
									class="btn btn-light text-light-inverse fw-medium rounded me-2 py-4">Cancel
								</button>
								<button type="button" onclick="validatePassword()"
									class="btn btn-success text-white fw-medium rounded py-4">Update
									Password</button>
							</div>
						</form>
					</div>


					<div class="card mb-10" id="borrow-info">
						<!--begin::Card header-->
						<div class="card-header">
							<!--begin::Card title-->
							<div class="card-title">
								<h3 class="fw-semibold text-gray-900">Borrow List</h3>
							</div>

						</div>
						<!--end::Card header-->
						<div class="card-body px-9 pt-9">
							<div class="table-responsive">
								<table
									class="table table-striped table-hover border-gray-300 table-row-bordered table-row-gray-200 ">
									<thead class="border-bottom-1">
										<tr class="fs-7 fw-bold text-gray-500">
											<th class="px-3 min-w-150px">Date Create</th>
											<th class="px-3 min-w-140px">Item No</th>
											<th class="px-3 min-w-150px">Equipment</th>
											<th class="px-3 min-w-130px">Location</th>
											<th class="px-3 min-w-130px">Status</th>
										</tr>
									</thead>

									<tbody>
										<c:forEach var="borrowList" items="${borrowList}">
											<tr>
												<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">
													${borrowList.formatted_date}
													<p class="text-gray-600 fs-6 fw-normal mb-0">${borrowList.formatted_time}</p>
												</td>
												<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">${borrowList.item_no}</td>
												<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">${borrowList.name}</td>
												<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">${borrowList.location}</td>
												<td class="px-3 py-4"><c:if
														test="${borrowList.status == 'R'}">
														<span
															class="badge bg-success rounded-2 px-2 py-1 text-white fw-semibold">Returned</span>
													</c:if> <c:if test="${borrowList.status == 'B'}">
														<span
															class="badge bg-warning rounded-2 px-2 py-1 text-white fw-semibold">Borrowing</span>
													</c:if></td>
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
	</div>

<script>
	document.addEventListener("DOMContentLoaded", function () {

  const sections = [
    "#account-info",
    "#security-info",
    "#borrow-info",
    "#edit_overview",
    "#reset_password"
  ];

  const navLinks = document.querySelectorAll("#profileNav .nav-link[data-target]");

  function toggleFormButtons(targetId) {
    const hideOn = ["#security-info", "#borrow-info"];
    ["btnCancel", "btnSubmit"].forEach(id => {
      const btn = document.getElementById(id);
      if (!btn) return;
      btn.classList.toggle("d-none", hideOn.includes(targetId));
    });
  }

  function showSection(targetId) {
    sections.forEach(id => {
      const el = document.querySelector(id);
      if (el) el.classList.toggle("d-none", id !== targetId);
    });

    toggleFormButtons(targetId);
  }

  //default
  showSection("#account-info");

  document.body.addEventListener("click", function (e) {
    const trigger = e.target.closest('[data-target]');
    if (!trigger) return;

    const target = trigger.getAttribute("data-target");
    if (!target) return;

    e.preventDefault();

 	//active nav เฉพาะตอนคลิก nav
    if (trigger.classList.contains("nav-link")) {

      navLinks.forEach(l => l.classList.remove("active"));
      trigger.classList.add("active");

    } else {
      navLinks.forEach(l => l.classList.remove("active"));
      const overviewNav = document.querySelector(
        '#profileNav .nav-link[data-target="#account-info"]'
      );
      overviewNav?.classList.add("active");
    }


    showSection(target);

    const el = document.querySelector(target);
    	el?.scrollIntoView({ behavior: "smooth", block: "start" });
  	});

	});
</script>

<script>
	document.addEventListener("DOMContentLoaded", function() {
		flatpickr(".date-picker", {
			dateFormat : "d M Y",
			allowInput : true
		});
	});
	
	function submitForm(){
		  var errorFields = [];
		  
		  const name = document.getElementById("name").value.trim();
		  const nickName = document.getElementById("nickName").value.trim();
		  const nameEN = document.getElementById("nameEN").value.trim();
		  const nickNameEN = document.getElementById("nickNameEN").value.trim();
		  const birthDate = document.getElementById("birthDate").value.trim();
		  const citizenId = document.getElementById("citizenId").value.trim();
		  const email = document.getElementById("email").value.trim();
		  const phonenum = document.getElementById("phonenum").value.trim();
		  
		  if(!name) errorFields.push("ชื่อ สกุล")
		  if(!nickName) errorFields.push("Nickname TH")
		  if(!nameEN) errorFields.push("Full Name EN")
		  if(!nickNameEN) errorFields.push("Nickname EN")
		  if(!birthDate) errorFields.push("Birth Date")
		  if(!citizenId) errorFields.push("Citizen ID")
		  if(!email) errorFields.push("E-Mail")
		  if(!phonenum) errorFields.push("Phone Number")
		  
		  
		  if (errorFields.length > 0) {
			  Swal.fire({
		    		title: "Please complete the form!",
		    		html: "Please fill in the following fields:<br><strong>" + errorFields.join(", ") + "</strong>",
			 	    icon: "error",
			 	    confirmButtonText: "OK",
			 	    buttonsStyling: false,
			 	    customClass: {
			 	       confirmButton: "btn btn-danger",
			 	   }
			    })
				return false;
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
		        	 document.getElementById("formUpdateOverview").submit();
		        }
		    });
		  return false;

	}
</script>

<script>
	var isCurrentPwValid = false;
	var isNewPwValid = false;
	
	function showError(inputId, errorId) {
	    const input = document.getElementById(inputId);
	    const error = document.getElementById(errorId);

	    input.classList.add("input-error");
	    error.classList.remove("d-none");
	}

	function clearError(inputId, errorId) {
	    const input = document.getElementById(inputId);
	    const error = document.getElementById(errorId);

	    input.classList.remove("input-error");
	    error.classList.add("d-none");
	}

	function validateCurrentPassword() {
	    const password = document.getElementById("currentPw").value.trim();

	    if (password === "") {
	    	 isCurrentPwValid = false;
	        showError("currentPw", "currentPwError");
	        
	        resetNewPasswordState();
	        return;
	    }

	    fetch("validate_current_password", {
	        method: "POST",
	        headers: { "Content-Type": "application/x-www-form-urlencoded" },
	        body: "currentPw=" + encodeURIComponent(password)
	    })
	    .then(res => res.json())
	    .then(data => {
	        if (data.valid) {
	        	isCurrentPwValid = true;
	            clearError("currentPw", "currentPwError");
	            enableNewPwInput(true);
	            
	        } else {
	            showError("currentPw", "currentPwError");
	            isCurrentPwValid = false;
	            enableNewPwInput(false);
	         
	        }
	    })
	    .catch(err => {
	        console.error(err); 
	        isCurrentPwValid = false;
	        showError("currentPw", "currentPwError");
	      
	    });
	}

	function validateNewPassword() {
	    const currentPw = document.getElementById("currentPw").value.trim();
	    const newPw = document.getElementById("newPw").value.trim();
	    
	    //มีสัญลักษณ์ และ ยาว 6 ตัวขึ้นไป
	    const pattern = /^(?=.*[^A-Za-z0-9]).{6,}$/; 
	    
	    //clearError ก่อนเริ่มตรวจ
	    clearError("newPw", "newPwError");
	    setPwPattern("normal");
	    
	    if (newPw === "") {
	        isNewPwValid = false;
	        return false;
	    }

	    if (newPw === currentPw) {	    	
	        isNewPwValid = false;
	        showError("newPw", "newPwError");
	        return false;
	    }
	    
	    if (!pattern.test(newPw)) {
	        isNewPwValid = false;
	        setPwPattern("error"); 
	        return false;
	    }

	    isNewPwValid = true;
	    clearError("newPw", "newPwError");
	    setPwPattern("normal");
	    return true;
	}

	
	function validateConfirmPassword() {
	    const newPw = document.getElementById("newPw").value.trim();
	    const confirmPw = document.getElementById("confirmNewPw").value.trim();

	    if (confirmPw === "") {
	        clearError("confirmNewPw", "confirmNewPwError");
	        return  true;
	    }

	    if (newPw !== confirmPw) {
	        showError("confirmNewPw", "confirmNewPwError");
	        return false;
	    }

	    clearError("confirmNewPw", "confirmNewPwError");
	    return true;
	}
	
	function validatePassword() {
	    var errorFields = [];
	    var isValid = true;

	    const currentPw = document.getElementById("currentPw").value.trim();
	    const newPwInput = document.getElementById("newPw");
	    const newPwValue = newPwInput.value.trim();
	    const confirmNewPw = document.getElementById("confirmNewPw").value.trim();

	    //เช็คยังไม่กรอก
	    if (!currentPw) errorFields.push("Current Password");
	    
	    if (!newPwInput.disabled) {
	        if (!newPwValue){
	        	errorFields.push("New Password");
	        }
	        if (isNewPwValid && !confirmNewPw) {
		        errorFields.push("Confirm New Password");
		    }else if (!newPwValue && !confirmNewPw){
		    	errorFields.push("Confirm New Password");
		    }
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

	    //เช็คความถูกรหัสเดิมว่ายัง error มั้ย
	    if (!isCurrentPwValid) {
	        showError("currentPw", "currentPwError");
	        isValid = false;
	    }

	    if (!newPwInput.disabled) {
	        //เรียกfunc เพื่อ update สถานะล่าสุด
	        const isPwPatternOk = validateNewPassword(); 
	        const isConfirmOk = validateConfirmPassword();

	        if (!isPwPatternOk || !isConfirmOk) {
	            isValid = false;
	        }
	    }

	    if (!isValid) return false;

	    //ผ่านหมด
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
	
	 function enableNewPwInput(enable) {
		    document.getElementById("newPw").disabled = !enable;
		    document.getElementById("confirmNewPw").disabled = !enable;

		    if (!enable) {
		        document.getElementById("newPw").value = "";
		        document.getElementById("confirmNewPw").value = "";
		    }
	}
	 
	 function setPwPattern(state){
		 const pwPattern = document.getElementById("pwPattern");
		 
		 pwPattern.classList.remove("text-muted", "text-danger");
		 
		 if(state === "error"){
			 pwPattern.classList.add("text-danger");
		 }else{
			 pwPattern.classList.add("text-muted");
		 }
	 }

	
</script>



</body>
</html>