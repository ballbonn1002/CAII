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
	background-color: #009ef7 !important;
	border-color: #009ef7 !important;
	color: #fff !important;
}

.toggle-password.d-none {
  display: none !important;
}
</style>

</head>

<body class="app-default">
<div class="app-main flex-column flex-row-fluid">
	<div class="d-flex flex-column flex-column-fluid">
	<!-- Header -->
		<div class="app-toolbar py-3 py-lg-6">
			<div class="app-container container-fluid d-flex flex-stack">
				<div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1 class="page-heading d-flex text-gray-900 fw-semibold flex-column justify-content-center my-0">
						My Profile</h1>
					<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="demo_dashboard" class="text-muted text-hover-primary">Home</a>
						</li>
					</ul>
				</div>
			</div>
		</div>

					<div class="app-content flex-column-fluid">
			<div class="app-container container-fluid">
					<div class="card mb-10">
						<div class="card-body pt-6 pb-0">
							<div class="d-flex flex-column flex-md-row align-items-start">
								<div class="mb-4 mb-md-0 me-md-9 mb-md-0 w-150px h-150px mx-auto">
										<c:choose>
											<c:when test="${not empty userImgPath}">
												<img id="avatarPreview" src="${userImgPath}"
													alt="${not empty user.nameEN ? user.nameEN : user.name}"
													class="border border-2 border-white rounded-1 w-150px h-150px" style="object-fit: cover;"> 
											</c:when>
											<c:otherwise>
												<div id="avatarPreview"
													class="w-150px h-150px rounded-1 d-flex align-items-center justify-content-center"
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

								<div class="flex-grow-1 ">
								<div class="d-flex justify-content-between align-items-start mb-4">
                                            <div>
                                               <div class="d-flex flex-column">
											<div class="d-flex align-items-center gap-4 ">
												<p class="fs-2 fw-bold text-gray-900  mb-0">${user.id}</p>
												<c:forEach var="jobSite" items="${jobSite}">
													<span
														class="badge badge-lg bg-primary text-white fw-semibold fs-8">${jobSite.name_site}</span>
												</c:forEach>
											</div>
											<div class="d-flex flex-wrap">
												<span class="fs-4 fw-normal text-gray-900">${user.employeeId}
													${user.nameEN} - ${user.name}</span>
											</div>
										</div>
                                            </div>

                                            <c:if test="${user.enable eq '1'}">
												<p>
													<span
														class="badge badge-lg bg-light-success text-success fw-semibold fs-8">Active</span>
												</p>
											</c:if>
											<c:if test="${user.enable ne '1'}">
												<p>
													<span
														class="badge badge-lg bg-light-danger text-danger fw-semibold fs-8">Inactive</span>
												</p>
											</c:if>
                                        </div>
									<div class="d-flex flex-wrap gap-4">
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-5 fw-bold text-gray-800 mb-2">
													${empty workPeriod ? '-' :workPeriod}</p>
												<p class="fs-6 fw-bold text-gray-500 mb-0">
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
												<p class="fs-5 fw-bold text-gray-800 mb-2">${empty user.positionId ? 'NONE':user.positionId}</p>
												<p class="fs-6 fw-bold text-gray-500 mb-0">Position</p>
											</div>
										</div>
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-5 fw-bold text-gray-800 mb-2">${empty user.departmentId ? 'NONE':user.departmentId}</p>
												<p class="fs-6 fw-bold text-gray-500 mb-0">Department</p>
											</div>
										</div>
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-5 fw-bold text-gray-800 mb-2">${user.workType == 1 ? 'On-site' : 'WFH'}</p>
												<p class="fs-6 fw-bold text-gray-500 mb-0">
													${user.onsiteNum == 3 ? '4–5 Day' :
          							          user.onsiteNum == 2 ? '2–3 Day' :
          							          user.onsiteNum == 1 ? '0.5–1 Day' : '-'}</p>
											</div>
										</div>
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-5 fw-bold text-gray-800 mb-2">${user.workDayStart == 1 ? 'Mon' :
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
												<p class="fs-6 fw-bold text-gray-500 mb-0">${user.workTimeStart}
													- ${user.workTimeEnd}</p>
												</div>
											</div>
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-5 fw-bold text-gray-800 mb-2">${user.employeeTypeId == 1 ? 'พนักงานประจำ' 
											: user.employeeTypeId == 2 ? 'พนักงานอัตราจ้าง'
											: 'นักศึกษาฝึกงาน'}</p>
												<p class="fs-6 fw-bold text-gray-500 mb-0">Employee Type</p>
											</div>
										</div>
										<div
											class="border border-gray-300 rounded-1 px-4 py-3 border-dashed ">
											<div class="d-flex flex-column">
												<p class="fs-5 fw-bold text-gray-800 mb-2">${empty manager.managerNameEn ? 'NONE':manager.managerNameEn}</p>
												<p class="fs-6 fw-bold text-gray-500 mb-0">Manager</p>
											</div>
										</div>

									</div>
								</div>
							</div>
						</div>

						<div class="separator mt-3 mb-2 mx-9 "></div>
						<ul
							class="nav nav-stretch nav-line-tabs nav-line-tabs-2x border-0 fs-6 fw-semibold px-9  mb-1"
							id="profileNav">

							<li class="nav-item"><a
								class="nav-link text-active-primary active py-3 ms-0 fw-bold"
								 data-target="#account-info"> Overview </a></li>

							<li class="nav-item"><a
								class="nav-link text-active-primary py-3 fw-bold" 
								data-target="#security-info"> Security </a></li>
							<li class="nav-item"><a
								class="nav-link text-active-primary py-3 fw-bold" 
								data-target="#borrow-info"> Borrow </a></li>
						</ul>
						
					</div>


					<div class="card mb-10" id="account-info">
						<div
							class="card-header d-flex align-items-center justify-content-between">
							<div class="card-title">
								<h3 class="fw-semibold text-gray-900">Account Info</h3>
							</div>

							<a class="btn btn-lg btn-light fw-medium text-light-inverse"
								 data-target="#edit_overview">Edit</a>
						</div>

						<div class="card-body px-10 py-9">
							<div class="row">
								<div class="col-12 col-md-6 col-lg-6">
									<p class="fs-5 text-muted fw-medium mb-0">Name TH</p>
									<p class="fs-5 text-gray-800 fw-semibold">${empty user.titleNameTH ? '': user.titleNameTH} ${empty user.name ? '': user.name} ${not empty user.nickName ? '- ' : ''}${user.nickName}</p>
								</div>
								<div class="col-12 col-md-6 col-lg-6">
									<p class="fs-5 text-muted fw-medium mb-0">Name EN</p>
						
									<p class="fs-5 text-gray-800 fw-semibold">${empty user.titleNameEN ? '': user.titleNameEN} ${empty user.nameEN ? '': user.nameEN} ${not empty user.nickNameEN ? '- ' : ''}${user.nickNameEN}</p>
								</div>
							</div>
							<div class="row">
								<div class="col-12 col-md-6 col-lg-6">
									<p class="fs-5 text-muted fw-medium mb-0">Gender</p>
									<p class="fs-5 text-gray-800 fw-semibold">${empty user.gender ? '-' : (user.gender == 'M' ? 'Male' : 'Female')}</p>
								</div>
								<div class="col-12 col-md-6 col-lg-6">
									<p class="fs-5 text-muted fw-medium mb-0">Birth Date</p>
									<p class="fs-5 text-gray-800 fw-semibold">
										<c:choose>
											<c:when test="${empty user.birthDate}">
											-
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
								<div class="col-12 col-md-6 col-lg-6">
									<p class="fs-5 text-muted fw-medium mb-0">Citizen ID</p>
									<p class="fs-5 text-gray-800 fw-semibold">
									<%-- ${empty user.citizenId ? '-' : user.citizenId} --%>
									<c:choose>
										<c:when test="${empty user.citizenId}">
										-
										</c:when>
										<c:otherwise>
										<c:set var="cid" value="${fn:replace(user.citizenId, '-', '')}" />
										${fn:substring(cid, 0,1)}-${fn:substring(cid, 1,5)}-${fn:substring(cid, 5,10)}-${fn:substring(cid, 10,12)}-${fn:substring(cid, 12,13)}
										</c:otherwise>
										
									</c:choose>
									</p>
								</div>
								<div class="col-12 col-md-6 col-lg-6">
									<p class="fs-5 text-muted fw-medium mb-0">Passport ID</p>
									<p class="fs-5 text-gray-800 fw-semibold">${empty user.passportId ? '-' : user.passportId}</p>
								</div>
							</div>
							<div class="row">
								<div class="col-12 col-md-6 col-lg-6">
									<p class="fs-5 text-muted fw-medium mb-0">E-Mail</p>
									<p class="fs-5 text-gray-800 fw-semibold">${empty user.email ? '-' : user.email }</p>
								</div>
								<div class="col-12 col-md-6 col-lg-6">
									<p class="fs-5 text-muted fw-medium mb-0">Phone Number</p>
									<p class="fs-5 text-gray-800 fw-semibold">
									<%-- ${empty user.phonenum ? '-' : user.phonenum } --%>
									<c:choose>
										<c:when test="${empty user.phonenum}">
										-
										</c:when>
										
										<c:otherwise>
										<c:set var="phone" value="${fn:replace(fn:replace(user.phonenum, '-', ''), ' ', '')}" />
      										${fn:substring(phone, 0,3)}-${fn:substring(phone, 3,6)}-${fn:substring(phone, 6,10)}

											<c:if test="${fn:length(phone) > 10}">
												${fn:substring(phone, 10, fn:length(phone))}
											</c:if>
										</c:otherwise>
										
									</c:choose>
									</p>
								</div>
							</div>
							<div class="row">
								<div class="col-12 gap-2">
									<p class="fs-5 text-muted fw-medium mb-0">Address</p>
									<p class="fs-5 text-gray-800 fw-semibold">${empty user.address ? '-' : user.address}</p>
								</div>

							</div>
							<div class="row">
								<div class="col-12 col-md-6 col-lg-6">
									<p class="fs-5 text-muted fw-medium mb-0">Emergency Contact</p>
									<p class="fs-5 text-gray-800 fw-semibold">${empty user.emergContact ? '-' : user.emergContact }</p>
								</div>
								<div class="col-12 col-md-6 col-lg-6">
									<p class="fs-5 text-muted fw-medium mb-0">Emergency Phone</p>
									<p class="fs-5 text-gray-800 fw-semibold">
									<%-- ${empty user.emergPhone ? '-' : user.emergPhone } --%>
									<c:choose>
										<c:when test="${empty user.emergPhone}">
										-
										</c:when>
										
										<c:otherwise>
										 ${fn:substring(user.emergPhone, 0,3)}-${fn:substring(user.emergPhone, 3,6)}-${fn:substring(user.emergPhone, 6,10)}
										</c:otherwise>
										
									</c:choose>
									</p>
									
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
							method="POST" class="form" autocomplete="off" enctype="multipart/form-data">
							<div class="card-body px-10 py-9">

								<div class="row mb-8">
									<div class="col-12 d-flex justify-content-center ">
										<div id="ktImageInput" class="image-input image-input-outline"
											data-kt-image-input="true"
											style="background-image: url('${pageContext.request.contextPath}/assets/media/svg/avatars/blank.svg');">

											<div id="imageInputWrapper"
												class="border border-2 border-white rounded image-input-wrapper w-150px h-150px d-flex align-items-center justify-content-center"
												style="
								                <c:choose>
								                    <c:when test='${not empty userImgPath}'>
								                        background-image: url(${userImgPath});
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

												<%-- <c:if test="${empty userImgPath}">
												
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
												</c:if> --%>
											</div>

											<label id="changeBtn"
												class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow"
												data-kt-image-input-action="change" data-bs-toggle="tooltip"
												data-bs-dismiss="click" title="Change avatar"> 
												<i class="ki-duotone ki-pencil fs-6">
												<span class="path1"></span>
												<span class="path2"></span></i> 
												<input id="imageInputFile"
												type="file" name="fileUpload" accept=".png, .jpg, .jpeg" />

												<input id="avatarRemoveHidden" type="hidden"
												name="avatar_remove" value="false" />
											</label> <span id="cancelBtn"
												class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow"
												data-kt-image-input-action="cancel" data-bs-toggle="tooltip"
												data-bs-dismiss="click" title="Cancel avatar"> <i
												class="ki-outline ki-cross fs-3"></i>
											</span> 
											<c:if test="${not empty userImgPath}">
											    <span id="removeBtn"
											        class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow"
											        data-kt-image-input-action="remove"
											        data-bs-toggle="tooltip"
											        data-bs-dismiss="click"
											        title="Remove avatar">
											        <i class="ki-outline ki-cross fs-3"></i>
											    </span>
											</c:if>
											
										</div>
									</div>
									<div
										class="form-text fs-7 text-muted fw-medium mt-6 mb-0  d-flex justify-content-center">Allowed
										file types: png, jpg, jpeg.</div>
								</div>


								<div class="row mb-0 mb-lg-5">
									<div class="col-12 col-md-2 col-lg-2  mt-md-4">
										<label class="required fw-medium text-gray-800 mb-2">คำนำหน้า</label>
										<select name="user_titleNameTH" id="user_titleNameTH" 
											data-placeholder=""
											class="form-select text-gray-700">
											<option value="นาย"
												${user.titleNameTH == 'นาย' ? 'selected' : ''}>นาย</option>
											<option value="นาง"
												${user.titleNameTH == 'นาง' ? 'selected' : ''}>นาง</option>
											<option value="นางสาว"
												${user.titleNameTH == 'นางสาว' ? 'selected' : ''}>นางสาว</option>
										</select>
									</div>
									<div class="col-12 col-md-5 col-lg-5 mt-9 mt-md-4">
										<label class="required fw-medium text-gray-800 mb-2">ชื่อ
											สกุล</label> <input type="text"
											class="form-control text-gray-700" oninput="this.value = this.value.replace(/[^ก-๙\s]/g, '')"
											placeholder="" name="user_name" id="user_name" value="${user.name}" />
									</div>
									<div class="col-12 col-md-5 col-lg-5 mt-9 mt-md-4">
										<label class="fw-medium text-gray-800 mb-2">Nickname
											TH</label> <input type="text"
											class="form-control text-gray-700" oninput="this.value = this.value.replace(/[^ก-๙\s]/g, '')"
											placeholder="" name="user_nickName" id="user_nickName"
											value="${user.nickName}" />
									</div>
								</div>

								<div class="row mb-0 mb-lg-5">
									<div class="col-12 col-md-2 col-lg-2 mt-9 mt-md-4">
										<label class="required fw-medium text-gray-800 mb-2">Title
											Name</label> <select name="user_titleNameEN" id="user_titleNameEN" 
											data-placeholder=""
											class="form-select text-gray-700">
											<option value="Mr."
												${user.titleNameEN == 'Mr.' ? 'selected' : ''}>Mr.</option>
											<option value="Mrs."
												${user.titleNameEN == 'Mrs.' ? 'selected' : ''}>Mrs.</option>
											<option value="Ms."
												${user.titleNameEN == 'Ms.' ? 'selected' : ''}>Ms.</option>
										</select>

									</div>
									<div class="col-12 col-md-5 col-lg-5 mt-9 mt-md-4">
										<label class="required fw-medium text-gray-800 mb-2">Full
											Name EN</label> <input type="text"
											class="form-control text-gray-700"
											placeholder="" name="user_fullNameEN" id="user_fullNameEN"
											value="${user.nameEN}" pattern="[A-Za-z ]+"
											oninput="this.value = this.value.replace(/[^A-Za-z ]/g, '')" />
									</div>
									<div class="col-12 col-md-5 col-lg-5 mt-9 mt-md-4">
										<label class="fw-medium text-gray-800 mb-2">Nickname
											EN</label> <input type="text"
											class="form-control text-gray-700"
											placeholder="" name="user_nickNameEN" id="user_nickNameEN"
											value="${user.nickNameEN}" pattern="[A-Za-z ]+"
											oninput="this.value = this.value.replace(/[^A-Za-z ]/g, '')" />
									</div>
								</div>

								<div class="row mb-0 mb-lg-5">
									<div class="col-12 col-md-6 col-lg-6 mt-9 mt-md-4">
										<p class="required fw-medium text-gray-800 mb-2">Gender</p>

										<div class="form-check form-check-inline mt-1">
											<input type="radio" name="user_gender" id="user_genderM" class="form-check-input"
												value="M" ${user.gender == 'M' ? 'checked' : ''} required />
											<label class="form-check-label fs-6 text-gray-800 fw-normal"
												for="genderMale">Male</label>
										</div>

										<div class="form-check form-check-inline mt-1">
											<input type="radio" name="user_gender" id="user_genderF" class="form-check-input"
												value="F" ${user.gender == 'F' ? 'checked' : ''} /> <label
												class="form-check-label fs-6 text-gray-800 fw-normal"
												for="genderFemale">Female</label>
										</div>
									</div>
									<div class="col-12 col-md-6 col-lg-6 mt-9 mt-md-4">
										<p class="required fw-medium text-gray-800 mb-2">Birth
											Date</p>
										<div class="position-relative">
											<i
												class="ki-duotone ki-calendar-8 text-gray-500 position-absolute top-50 translate-middle-y ms-4">
												<span class="path1"></span><span class="path2"></span> <span
												class="path3"></span><span class="path4"></span> <span
												class="path5"></span><span class="path6"></span>
											</i> 
											<input type="text" id="user_birthDate" name="user_birthDate"
												class="form-control ps-10 text-gray-700"
												placeholder="1 Jan 2025" autocomplete="off"
												<%-- value="${user.birthDate}" --%>
												value="<fmt:formatDate value='${user.birthDate}' pattern='yyyy-MM-dd' />"
												required />
										</div>


									</div>
								</div>
								<div class="row mb-0 mb-lg-5">
									<div class="col-12 col-md-6 col-lg-6 mt-9 mt-md-4">
										<p class="required fw-medium text-gray-800 mb-2">Citizen
											ID</p>
										<input type="text"
											class="form-control text-gray-700"
											placeholder="" name="user_citizenId" id="user_citizenId"
											value="${user.citizenId}" maxlength="17" inputmode="numeric" required
											oninput="formatCitizenId(this)"
											/>
											<!-- oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0,13)" /> -->
											
											<!-- error message -->
										<span id="citizenIdError"
											class="text-danger fs-7 fw-medium d-none mt-2 mb-0">
											Please enter a valid 13-digit.</span>

									</div>
									<div class="col-12 col-md-6 col-lg-6 mt-9 mt-md-4">
										<p class="fs-6 fw-medium text-gray-800 mb-2">Passport ID</p>
										<input type="text"
											class="form-control text-gray-700"
											placeholder="" name="user_passportId" id="user_passportId" value="${user.passportId}" />

									</div>
								</div>
								<div class="row mb-0 mb-lg-5">
									<div class="col-12 col-md-6 col-lg-6 mt-9 mt-md-4">
										<p class="required fw-medium text-gray-800 mb-2">E-Mail</p>
										<input type="email"
											class="form-control text-gray-700"
											placeholder="" name="user_email" id="user_email" value="${user.email}" required/>

									</div>
									<div class="col-12 col-md-6 col-lg-6 mt-9 mt-md-4">
										<p class="required fw-medium text-gray-800 mb-2">Phone
											Number</p>
										<input type="text"
										    class="form-control text-gray-700" name="user_phonenum"   id="user_phonenum"
										    value="${user.phonenum}"  required oninput="formatPhone(this)" maxlength="20"/>
										   <!--  pattern="[0-9]{10}" maxlength="10"
										    inputmode="numeric" oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0,10)" /> -->
									</div>
								</div>
								<div class="row mb-0 mb-lg-5">
									<div class="col-12 mt-9 mt-md-4">
										<p class="fs-6 fw-medium text-gray-800 mb-2">Address</p>

										<textarea rows="3" cols=""
											class="form-control text-gray-700"
											placeholder="" name="user_address" id="user_address">${user.address}</textarea>
									</div>

								</div>
								<div class="row ">
									<div class="col-12 col-md-6 col-lg-6 mt-9 mt-md-4">
										<p class="fs-6 fw-medium text-gray-800 mb-2">Emergency
											Contact</p>
										<input type="text"
											class="form-control text-gray-700"
											placeholder="" name="user_emergContact" id="user_emergContact"
											value="${user.emergContact}" />

									</div>
									<div class="col-12 col-md-6 col-lg-6 mt-9 mt-md-4">
										<p class="fs-6 fw-medium text-gray-800 mb-2">Emergency
											Phone</p>
										<input type="text"
											class="form-control text-gray-700"
											placeholder="" name="user_emergPhone" id="user_emergPhone" value="${user.emergPhone}"
											pattern="^$|^[0-9]{10}$"
										    maxlength="10" inputmode="numeric"
										    oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0,10)" />

									</div>

								</div>
							</div>
							<div class="card-footer d-flex justify-content-end">
								<button type="button" id="cancelFormBtn"
									onclick="confirmLeaveForm('my_profile')"
									class="btn btn-lg btn-light fw-medium text-light-inverse me-2">Cancel
								</button>
								<button type="button" id="saveFormBtn" class="btn btn-lg btn-success text-white fw-medium"
								    onclick="submitForm()">Save</button>
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
						<div class="card-body px-10 py-9">
							<div
								class="col  d-flex align-items-center justify-content-between">
								<div class="col">
									<p class="fs-6 text-gray-800 fw-bold mb-0">Password</p>
									<p class="fs-5 text-muted fw-medium mb-0">************</p>
								</div>
								<a
									class="btn btn-lg btn-light fw-medium text-light-inverse"
									 data-target="#reset_password">Reset Password</a>


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
							<div class="card-body px-10 py-9">
								<div class="row mb-8">
									<div class="col-12 col-lg-4 mt-4 mb-0 mt-md-0 mt-lg-0">
										<label class="required fs-6 fw-medium text-gray-800 mb-2">Current
											Password</label>
										<div class="position-relative">
											 <input type="password"
											class="form-control text-gray-800"
											placeholder="" name="currentPw" id="currentPw"
											oninput="validateCurrentPassword();" />
											<span class="btn btn-sm btn-icon position-absolute top-50 end-0 translate-middle-y toggle-password "
										         data-eye-target="currentPw">
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
										<!-- error message -->
										<span id="currentPwError"
											class="text-danger fs-7 fw-medium d-none mt-2 mb-0">
											Incorrect password.</span>
									</div>
									<div class="col-12 col-lg-4 mt-9 mt-md-4 mt-lg-0">

										<label class="required fs-6 fw-medium text-gray-800  mb-2">New
											Password</label> 
											<div class="position-relative">
											<input type="password"
											class="form-control text-gray-800"
											placeholder="" name="newPw" id="newPw"
											oninput="validateNewPassword();" minlength="6" disabled />
											<span class="btn btn-sm btn-icon position-absolute top-50 end-0 translate-middle-y toggle-password d-none"
										         data-eye-target="newPw">
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
										
										<!-- error message -->
										<span id="newPwError"
											class="text-danger fs-7 fw-medium d-none mt-2  mb-0">
											New password must be different from Current Password.</span>

									</div>
									<div class="col-12 col-lg-4 mt-9 mt-md-4 mt-lg-0">
										<label class="required fs-6 fw-medium text-gray-800  mb-2">Confirm
											New Password</label> 
											<div class="position-relative">
											<input type="password"
											class="form-control text-gray-800"
											placeholder="" name="confirmNewPw" id="confirmNewPw"
											oninput="validateConfirmPassword()" minlength="6" disabled />
										<span class="btn btn-sm btn-icon position-absolute top-50 end-0 translate-middle-y toggle-password d-none"
										         data-eye-target="confirmNewPw">
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
							<div class="card-footer d-flex justify-content-end">
								<button type="button"
									onclick="confirmLeaveForm('my_profile')"
									class="btn btn-lg btn-light fw-medium text-light-inverse me-2">Cancel
								</button>
								<button type="button" onclick="validatePassword()"
									class="btn btn-lg btn-success text-white fw-medium">Update
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
										</tr>
									</thead>

									<tbody>
									<c:if test="${empty borrowList}">
										<tr>
											<td colspan="5" class="text-center text-muted py-4">
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
		 toggleEyeIcon();
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
      const buttonNavMap = {
    		"#edit_overview": "#account-info",
    		"#reset_password": "#security-info"
    	};
    	navTarget = trigger.classList.contains("nav-link")
    		? target
    		: buttonNavMap[target];
    }
   
    showSection(target);

    const el = document.querySelector(target);
    	el?.scrollIntoView({ behavior: "smooth", block: "start" });
  	});

	});
</script>

<script>
	document.addEventListener("DOMContentLoaded", function() {
	    const removeBtn = document.querySelector('[data-kt-image-input-action="remove"]');
	    const removeHidden = document.getElementById('avatarRemoveHidden');
	    
	    if (removeBtn) {
	        removeBtn.addEventListener("click", function() {
	            removeHidden.value = "true";
	        });
	    }
	});
</script>

<script>
	document.addEventListener("DOMContentLoaded", function() {
		/* $("#user_birthDate").flatpickr(); */
		flatpickr("#user_birthDate", {
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
	function submitForm(){
		  var errorFields = [];
		  
		  [ "user_titleNameTH", "user_name",  "user_nickName", "user_titleNameEN","user_fullNameEN", "user_nickNameEN", "user_gender","user_birthDate",
			  "user_citizenId", "user_passportId",  "user_email", "user_phonenum", "user_address", "user_emergContact", "user_emergPhone"
			].forEach(id => {
			    const element = document.getElementById(id);
			    if (element && element.value) {
			    	element.value = element.value.trim();
			    }
			});
		  
		  const titleNameTH  = document.getElementById("user_titleNameTH").value
		  const name = document.getElementById("user_name").value
		  const nickName = document.getElementById("user_nickName").value
		  const titleNameEN  = document.getElementById("user_titleNameEN").value
		  const nameEN = document.getElementById("user_fullNameEN").value
		  const nickNameEN = document.getElementById("user_nickNameEN").value
		  const birthDate = document.getElementById("user_birthDate").value
		  /* const citizenId = document.getElementById("user_citizenId").value */
		  const passportId = document.getElementById("user_passportId").value
		  const email = document.getElementById("user_email").value
		  /* const phonenumRaw = document.getElementById("user_phonenum").value
		  const phonenum = phonenumRaw.replace(/\D/g, ''); */
		  const address = document.getElementById("user_address").value
		  const emergContact = document.getElementById("user_emergContact").value
		  const emergPhone = document.getElementById("user_emergPhone").value
		  var gender = "";
		  const genderValue = document.getElementsByName("user_gender");
		  for (const g of genderValue) {
		      if (g.checked) {
		          gender = g.value;
		          break;
		      }
		  }
		  const citizenIdInput = document.getElementById("user_citizenId");
		  const citizenIdFormatted = citizenIdInput.value.trim();
		  const citizenId = citizenIdFormatted.replace(/\D/g, '');
		  
		  const phoneInput = document.getElementById("user_phonenum");
		  const phoneRaw = phoneInput.value.trim();
		  const digits = phoneRaw.replace(/\D/g, '');
		  const mainPhone = digits.slice(0, 10);
		  var extra = "";
		  if (digits.length > 10) {
			  var digitCount = 0;
			  var cutIndex = phoneRaw.length;

			  for (var i = 0; i < phoneRaw.length; i++) {
			    if (/\d/.test(phoneRaw[i])) {
			      digitCount++;
			      if (digitCount === 10) {
			        cutIndex = i + 1;
			        break;
			      }
			    }
			  }

			  extra = phoneRaw.slice(cutIndex);
			}
		  const phonenum = mainPhone + extra;
		  phoneInput.value = phonenum;

		  if(!titleNameTH) errorFields.push("คำนำหน้า")
		  if(!name) errorFields.push("ชื่อ สกุล")
		  /* if(!nickName) errorFields.push("Nickname TH") */
		  if(!titleNameEN) errorFields.push("Title Name")
		  if(!nameEN) errorFields.push("Full Name EN")
		  /* if(!nickNameEN) errorFields.push("Nickname EN") */
		  if(!gender) errorFields.push("Gender")
		  if(!birthDate) errorFields.push("Birth Date")
		  if (!citizenId) {
		    errorFields.push("Citizen ID");
		    document.getElementById("citizenIdError").classList.remove("d-none");
		  }else if (citizenId.length !== 13) {
				document.getElementById("citizenIdError").classList.remove("d-none");
				return false
		  } else {
			    document.getElementById("citizenIdError").classList.add("d-none");
		  }
		  if(!email) errorFields.push("E-Mail")
		  if(!phonenum){
			  errorFields.push("Phone Number")
		  }
		  /* else if(phonenum.length !== 10){
			  errorFields.push("Phone Number (must be 10 digits)");
		  } */
		  /* if(emergPhone && emergPhone.length !== 10) {
			    errorFields.push("Emergency Phone (must be 10 digits)");
			} */
		  //console.log({titleNameTH, name, nickName, titleNameEN, nameEN, nickNameEN, gender, birthDate, citizenId, email, phonenum});
				  
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
		        	const citizenIdInput = document.getElementById("user_citizenId");
		        	citizenIdInput.value = citizenIdInput.value.replace(/\D/g, '');
		        	const form = document.getElementById("formUpdateOverview");
		        	form.submit();
		        }
		    });
		  return false;
	}
</script>
	
<script>
	function toggleEyeIcon(){
		document.querySelectorAll(".toggle-password").forEach(btn =>{
			
			if (btn.dataset.bound === "true") return;
		    btn.dataset.bound = "true";
		    
			btn.addEventListener("click", function(){
				const input =document.getElementById(this.dataset.eyeTarget);
				if (input.disabled) return;

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
	    
	    const pattern = /^\S{6,}$/;
	    
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
	
	 function enableNewPwInput(enable) {
		 const newPw = document.getElementById("newPw");
		 const confirmNewPw = document.getElementById("confirmNewPw");
		 
		 const newPwEye = document.querySelector('[data-eye-target="newPw"]');
		 const confirmNewPwEye = document.querySelector('[data-eye-target="confirmNewPw"]');
		 
		 newPw.disabled = !enable;
		 confirmNewPw.disabled = !enable;

		  if (enable) {
			  newPwEye.classList.remove("d-none");
			  confirmNewPwEye.classList.remove("d-none");
		  }else{
			  newPw.value = "";
			  confirmNewPw.value = "";
			  
			  newPw.type = "password";
			  confirmPw.type = "password";

			  newPwEye.classList.add("d-none");
			  confirmNewPwEye.classList.add("d-none");
			  
			  newPwEye.querySelector(".ki-eye").classList.add("d-none");
			  newPwEye.querySelector(".ki-eye-slash").classList.remove("d-none");

			  confirmNewPwEye.querySelector(".ki-eye").classList.add("d-none");
			  confirmNewPwEye.querySelector(".ki-eye-slash").classList.remove("d-none");
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


</body>
</html>