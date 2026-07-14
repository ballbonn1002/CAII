<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
.company-logo .image-input-wrapper {
	background-image:
		url('${pageContext.request.contextPath}/assets/media/svg/files/blank-image.svg');
}

.contact-profile .image-input-wrapper {
	background-image:
		url('${pageContext.request.contextPath}/assets/media/svg/avatars/blank-old.svg');
}

.border {
	border-radius: 1px !important;
}

.btn-success {
	background-color: #17C653 !important;
}

.address-name-col {
	width: 100%;
}

/* .middle-section {
    padding-left: clamp(0px, 6vw, 120px);
} */
@media ( min-width : 768px) {
	/*  	.middle-section {
		padding-left: 50px;
	}  */
	.address-name-col {
		width: 150px;
		flex-shrink: 0;
	}
}

/* @media ( min-width : 992px) {
	.middle-section {
		padding-left: 30px;
	}
}

@media ( min-width : 1200px) {
	.middle-section {
		padding-left: 40px;
	}
}

@media ( min-width : 1400px) {
	.middle-section {
		padding-left: 120px;
	}
} */
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
						<li class="breadcrumb-item text-muted">Edit</li>
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
								</label> <input class="form-check-input" type="checkbox"
									id="company-active"
									<c:if test="${company.isActive eq '1'}">checked</c:if> />
							</div>
						</div>
					</div>

					<div class="card-body">
						<!-- Logo Upload -->
						<div class="row mb-10">
							<div class="col-12">

								<div
									class="d-flex justify-content-center align-items-center flex-column mb-5">

									<!--begin::Image input-->
									<div
										class="image-input image-input-empty image-input-placeholder company-logo mb-3"
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
									<input type="text" id="company-code" class="form-control pe-10"
										value="${company.companyCode}" required> <i
										id="company-code-valid-icon"
										class="ki-duotone ki-check-circle fs-1 text-success position-absolute top-50 end-0 translate-middle-y me-4">
										<span class="path1"></span> <span class="path2"></span>
									</i>
								</div>
							</div>

							<div class="col-md-6 company-tax-number-container">
								<label class="form-label"> Tax ID </label> <input type="text"
									class="form-control " value="${company.taxNumber }"
									id="company-tax-number">
							</div>

						</div>

						<!-- Row 2 -->
						<div class="row g-6 mb-6">

							<div class="col-md-6 company-name-en-container">
								<label class="form-label"> Company Name EN </label> <input
									type="text" class="form-control " id="company-name-en"
									value="${company.companyEn }">
							</div>

							<div class="col-md-6 company-name-th-container">
								<label class="form-label"> Company Name TH </label> <input type="text"
									class="form-control "
									value="${company.companyTh }" id="company-name-th">
							</div>

						</div>

						<!-- Row 3 -->
						<div class="row g-6">

							<div class="col-md-6 company-idustry-container">
								<label class="form-label"> Industry </label> <select
									class="form-select" data-control="select2"
									id="company-industry">
									<option value="1" ${company.industry eq '1' ? 'selected' : ''}>
										IT</option>
									<option value="2" ${company.industry eq '2' ? 'selected' : ''}>
										Finance</option>
									<option value="3" ${company.industry eq '3' ? 'selected' : ''}>
										Retail</option>
									<option value="4" ${company.industry eq '4' ? 'selected' : ''}>
										Manufacturing</option>
								</select>
							</div>

						</div>
					</div>
				</div>


				<!-- begin::company address -->
				<div class="card mt-10">
					<div class="card-header">
						<div class="card-title">
							<h3 class="fw-semibold m-0">Company Address</h3>
						</div>

						<div class="card-toolbar">
							<button type="button"
								class="btn btn-primary d-inline-flex align-items-center py-3 px-6 gap-2"
								id="createAddressBtn">
								<i class="ki-duotone ki-plus fs-5"> <span class="path1"></span>
									<span class="path2"></span>
								</i> <span class="fw-bold">Create</span>
							</button>
						</div>
					</div>

					<!-- begin::modal -->
					<div class="modal fade" tabindex="-1" id="createAddressModal">
						<div class="modal-dialog  modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header border-0">
									<h2 class="modal-title fw-semibold">Company Address</h2>

									<!--begin::Close-->
									<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
										data-bs-dismiss="modal" aria-label="Close">
										<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span
											class="path2"></span></i>
									</div>
									<!--end::Close-->
								</div>

								<div class="modal-body">
									<div class="row g-8 mb-8">
										<div class="col-md-12 create-address-container">
											<label for="Address name" class="form-label required">Address
												Name</label> <input type="text" class="form-control form-control-lg"
												placeholder="Address name" id="address-name-create" required />

										</div>
										<div class="col-md-12 create-addressVal-container">
											<label for="Address value" class="form-label required">
												Address </label>
											<textarea class="form-control" data-kt-autosize="true"
												id="address-value-create"></textarea>
										</div>
										<div class="col-md-12 create-ggMap-container">
											<label for="Google map URL" class="form-label required">
												Google Map URL </label> <input type="url"
												class="form-control form-control-lg"
												placeholder="https://maps.google.com/...." required
												id="ggMap-create" />

										</div>
									</div>
								</div>

								<div class="modal-footer border-0">
									<button type="button" class="btn btn-light"
										data-bs-dismiss="modal">Close</button>
									<button type="button" id="saveAddressBtn"
										class="btn btn-success">Save</button>
								</div>
							</div>
						</div>
					</div>
					<!-- end::modal -->

					<div class="card-body" id="addressCard">

						<c:choose>

							<c:when test="${empty addressList}">
								<div class="border rounded p-15 text-center"
									id="addressNotFound">
									<div class="text-gray-400 fw-semibold">Not Found</div>
								</div>
							</c:when>

							<c:otherwise>

								<c:forEach items="${addressList}" var="address">

									<div
										class="d-flex flex-column flex-md-row
						                       justify-content-between
						                       align-items-start align-items-md-center
						                       border py-6 py-md-15 px-6 gap-6"
										id="addressCard-${address.address_id}">

										<div class="address-name-col ps-md-3">
											<h2 id="name_${address.address_id}" class="text-break">${address.address_name}</h2>
										</div>

										<div
											class="d-flex flex-grow-1 flex-column mw-md-75 gap-3 gap-md-6 ms-xl-15 ">

											<div class="text-break lh-lg">
												<div
													class="fw-semibold mb-1 d-flex align-items-center gap-3">

													<i class="ki-duotone ki-map me-1 fs-1"> <span
														class="path1"></span> <span class="path2"></span> <span
														class="path3"></span>
													</i> <span class="text-gray-800"
														id="address_${address.address_id}">
														${address.address} </span>

												</div>
											</div>

											<div class="text-break lh-lg">
												<div
													class="fw-semibold mb-1 d-flex align-items-center gap-3">

													<i class="ki-duotone ki-geolocation me-1 fs-1"> <span
														class="path1"></span> <span class="path2"></span>
													</i> <span class="text-gray-800"
														id="googleMap_${address.address_id }">
														${address.google_map} </span>

												</div>
											</div>

										</div>

										<div
											class="d-flex align-items-center flex-shrink-0 justify-content-end gap-3 ms-md-auto w-100 w-md-auto mt-3 mt-md-0">

											<button type="button"
												class="btn btn-icon btn-sm btn-light-primary mb-1 fs-3 js-edit-address"
												data-address-id="${address.address_id}">

												<i class="ki-duotone ki-pencil fs-1"> <span
													class="path1"></span> <span class="path2"></span>
												</i>

											</button>

											<button
												class="btn btn-icon btn-sm btn-light-danger mb-1 fs-3 me-1 js-delete-address"
												data-address-id="${address.address_id}">
												<i class="ki-duotone ki-trash fs-1"> <span class="path1"></span>
													<span class="path2"></span> <span class="path3"></span> <span
													class="path4"></span> <span class="path5"></span>
												</i>

											</button>

										</div>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>

					<div class="modal fade" tabindex="-1" id="editAddressModal">

						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">

								<div class="modal-header border-0">
									<h2 class="modal-title fw-semibold">Company Address</h2>

									<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
										data-bs-dismiss="modal">

										<i class="ki-duotone ki-cross fs-1"> <span class="path1"></span>
											<span class="path2"></span>
										</i>

									</div>

								</div>

								<div class="modal-body">
									<input type="hidden" id="editingAddressId">
									<div class="row g-8 mb-8">
										<div class="col-md-12 address-name-update-container">
											<label class="form-label required"> Address Name </label> <input
												type="text" class="form-control form-control-lg"
												id="address-name-update" />
										</div>

										<div class="col-md-12 address-value-update-container">
											<label class="form-label required"> Address </label>
											<textarea class="form-control" data-kt-autosize="true"
												id="address-value-update"></textarea>
										</div>

										<div class="col-md-12 ggMap-update-container">
											<label class="form-label required"> Google Map URL </label> <input
												type="text" class="form-control form-control-lg"
												id="ggMap-update" />
										</div>
									</div>
								</div>

								<div class="modal-footer border-0">

									<button type="button" class="btn btn-light"
										data-bs-dismiss="modal">Close</button>

									<button type="button"
										class="btn btn-success js-save-address-modal"
										id="saveAddressModalBtn">Save</button>

								</div>

							</div>
						</div>
					</div>
				</div>

				<!-- begin::company contact -->
				<div class="card mt-10">
					<div class="card-header">
						<div class="card-title">
							<h3 class="fw-semibold m-0">Company Contact</h3>
						</div>

						<div class="card-toolbar">
							<div>
								<button type="button"
									class="btn btn-primary d-inline-flex align-items-center py-3 px-6 gap-2"
									id="createContactBtn">
									<i class="ki-duotone ki-plus fs-5"> <span class="path1"></span>
										<span class="path2"></span>
									</i> <span class="fw-bold">Create</span>
								</button>
							</div>
						</div>

						<!-- begin::create contact modal -->
						<div class="modal fade" tabindex="-1" id="createContactModal">
							<div class="modal-dialog modal-lg modal-dialog-centered">
								<div class="modal-content">
									<div class="modal-header border-0">
										<h2 class="modal-title fw-semibold">Company Contact</h2>

										<!--begin::Close-->
										<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
											data-bs-dismiss="modal" aria-label="Close">
											<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span
												class="path2"></span></i>
										</div>
										<!--end::Close-->
									</div>

									<div class="modal-body ms-2">
										<!-- Logo Upload -->
										<div class="row mb-10">
											<div class="col-12">
												<div
													class="d-flex justify-content-center align-items-center flex-column mb-5">

													<!--begin::Image input-->
													<div
														class="image-input image-input-empty image-input-placeholder contact-profile mb-3"
														data-kt-image-input="true">
														<!--begin::Image preview wrapper-->
														<div class="image-input-wrapper w-150px h-150px"></div>
														<!--end::Image preview wrapper-->

														<!--begin::Edit button-->
														<label
															class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow-sm"
															data-kt-image-input-action="change"
															data-bs-toggle="tooltip" data-bs-dismiss="click"
															title="Change company logo"> <i
															class="ki-duotone ki-pencil fs-6"><span class="path1"></span><span
																class="path2"></span></i> <!--begin::Inputs--> <input
															type="file" name="logo" accept=".png, .jpg, .jpeg" /> <input
															type="hidden" name="logo_remove" /> <!--end::Inputs-->
														</label>
														<!--end::Edit button-->

														<!--begin::Cancel button-->
														<span
															class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow-sm"
															data-kt-image-input-action="cancel"
															data-bs-toggle="tooltip" data-bs-dismiss="click"
															title="Cancel logo"> <i
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

													<div class="text-muted fs-6 mt-3">Allowed file types:
														png, jpg, jpeg</div>
												</div>
											</div>
										</div>
										<div class="row g-4 mb-8">
											<div class="col-md-3">
												<label for="Title name" class="form-label required">
													คํานําหน้า </label> <select class="form-select form-select-lg"
													data-control="select2" data-placeholder="Select an option"
													name="titleNameTH" id="titleNameTH-create">
													<option value=""></option>
													<option value="นาย">นาย</option>
													<option value="นาง">นาง</option>
													<option value="นางสาว">นางสาว</option>
												</select>

											</div>
											<div class="col-md-9 create-contact-nameTH-container">
												<label for="Full thai name" class="form-label required">
													ชื่อ สกุล </label> <input class="form-control form-control-lg"
													type="text" name="contactNameTH" id="contactNameTH-create">
											</div>
										</div>

										<div class="row g-4 mb-8">
											<div class="col-md-3">
												<label for="Address name" class="form-label required">
													Title Name </label> <select class="form-select form-select-lg"
													data-control="select2" data-placeholder="Select an option"
													name="titleNameEN" id="titleNameEN-create">
													<option value=""></option>
													<option value="Mr.">Mr.</option>
													<option value="Ms.">Ms.</option>
													<option value="Mrs.">Mrs.</option>
													<option value="Miss">Miss.</option>
												</select>

											</div>
											<div class="col-md-9 creat-contact-nameEN-container">
												<label for="Full english name" class="form-label required">
													Full Name EN</label> <input type="text"
													class="form-control form-control-lg" name="contactNameEN"
													id="contactNameEN-create">
											</div>
										</div>

										<div class="row g-8 mb-8">
											<div class="col-md-6">
												<label for="Address name" class="form-label required">
													Address Name </label> <select class="form-select form-select-lg"
													data-control="select2" data-placeholder="Select an option"
													name="addressId" id="contactAddressId-create">
													<option value=""></option>
													<c:forEach items="${addressList}" var="address">
														<option value="${address.address_id}">${address.address_name}</option>
													</c:forEach>
												</select>

											</div>
											<div class="col-md-6 create-position-container">
												<label for="Position" class="form-label required"> Position</label>
												<input type="text" class="form-control form-control-lg"
													name="position" id="contactPosition-create">
											</div>
										</div>

										<div class="row g-8 mb-8">
											<div class="col-md-6 create-contact-phone-container">
												<label for="Phone Number" class="form-label required">
													Phone Number</label> <input type="tel" name="phoneNumber"
													class="form-control form-control-lg"
													id="phoneNumber-create">
											</div>
											<div class="col-md-6 create-contact-email-container">
												<label for="Email" class="form-label required">
													Email</label> <input type="email" name="email"
													class="form-control form-control-lg"
													id="contactEmail-create">
											</div>
										</div>

									</div>

									<div class="modal-footer border-0">
										<button type="button" class="btn btn-light"
											data-bs-dismiss="modal">Close</button>
										<button type="button" id="saveContactBtn"
											class="btn btn-success">Save</button>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="card-body" id="contactCard">

						<c:choose>
							<c:when test="${empty contactList}">
								<div class="border rounded p-15 text-center"
									id="contactNotFound">
									<div class="text-gray-400 fw-semibold">Not Found</div>
								</div>
							</c:when>

							<c:otherwise>
								<c:forEach items="${contactList}" var="contact">
									<div
										class="d-flex flex-column flex-md-row
							           justify-content-between
							           align-items-start align-items-md-center
							           border py-6 py-md-15 px-6 gap-8 gap-md-3"
										id="contactCard-${contact.contact_id}">
										<div class="d-flex align-items-center gap-4 flex-shrink-0 "
											style="width: 250px">
											<div class="symbol symbol-50px symbol-circle">
												<c:choose>
													<c:when test="${not empty contact.file_path}">
														<div class="symbol-label"
															style="background-image:url('${pageContext.request.contextPath}${contact.file_path}')">
														</div>
													</c:when>

													<c:otherwise>
														<div class="symbol-label fs-5 fw-bold text-primary">
															<c:choose>
																<c:when test="${not empty contact.contact_name}">
																	${fn:toUpperCase(fn:substring(contact.contact_name,0,1))}
																</c:when>
																<c:otherwise>?</c:otherwise>
															</c:choose>
														</div>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="d-flex flex-column gap-2 fw-semibold"
												style="word-break: break-word">
												<span class="text-gray-900"
													id="contactName${contact.contact_id}">
													${contact.contact_name} </span> <span class="text-gray-600"
													id="contactPosition${contact.contact_id }">${contact.position}</span>
											</div>
										</div>

										<div
											class="row flex-grow-1 gap-2 gap-xl-0 middle-section justify-content-md-around ">
											<div class="col-xl-3 gap-2 d-flex align-items-center ">
												<i class="ki-duotone ki-map me-2 fs-1"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span>
												</i> <span class="text-gray-800 fs-6 text-break"
													id="contactAddressName${contact.contact_id}">${contact.address_name}</span>
											</div>
											<div class="col-xl-3 gap-2 d-flex align-items-center ">
												<i class="ki-duotone ki-map me-2 fs-1"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span>
												</i> <span class="text-gray-800 fs-6 text-break"
													id="contactPhoneNumber${contact.contact_id }">${contact.phone }</span>
											</div>
											<div class="col-xl-4 gap-2 d-flex align-items-center ">
												<i class="ki-duotone ki-map me-2 fs-1"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span>
												</i> <span class="text-gray-800 fs-6 text-break"
													id="contactEmail${contact.contact_id }">${contact.email }</span>
											</div>
										</div>

										<div
											class="d-flex align-items-center justify-content-end flex-shrink-0 gap-3 ms-md-auto  w-100 w-md-auto mt-3 mt-md-0">
											<button type="button"
												class="btn btn-icon btn-sm btn-light-primary mb-1 fs-3 js-edit-contact"
												data-contact-id="${contact.contact_id}">
												<i class="ki-duotone ki-pencil fs-1"><span class="path1"></span><span
													class="path2"></span></i>
											</button>
											<button
												class="btn btn-icon btn-sm btn-light-danger mb-1 fs-3 me-1 js-delete-contact"
												data-contact-id="${contact.contact_id}">
												<i class="ki-duotone ki-trash fs-1"> <span class="path1"></span>
													<span class="path2"></span> <span class="path3"></span> <span
													class="path4"></span> <span class="path5"></span>
												</i>

											</button>
										</div>
									</div>
								</c:forEach>
							</c:otherwise>


						</c:choose>
						<div class="modal fade" tabindex="-1" id="editContactModal">
							<div class="modal-dialog modal-lg modal-dialog-centered">
								<div class="modal-content">
									<div class="modal-header border-0">
										<h2 class="modal-title fw-semibold">Company Contact</h2>

										<!--begin::Close-->
										<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
											data-bs-dismiss="modal" aria-label="Close">
											<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span
												class="path2"></span></i>
										</div>
										<!--end::Close-->
									</div>

									<div class="modal-body ms-2">
										<input type="hidden" id="editingContactId">
										<!-- Logo Upload -->
										<div class="row mb-10">
											<div class="col-12">
												<div
													class="d-flex justify-content-center align-items-center flex-column mb-5">

													<!--begin::Image input-->
													<div
														class="image-input image-input-empty image-input-placeholder contact-profile mb-3"
														data-kt-image-input="true">
														<!--begin::Image preview wrapper-->
														<div class="image-input-wrapper w-150px h-150px"></div>
														<!--end::Image preview wrapper-->

														<!--begin::Edit button-->
														<label
															class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow-sm"
															data-kt-image-input-action="change"
															data-bs-toggle="tooltip" data-bs-dismiss="click"
															title="Change company logo"> <i
															class="ki-duotone ki-pencil fs-6"><span class="path1"></span><span
																class="path2"></span></i> <!--begin::Inputs--> <input
															type="file" name="logo" accept=".png, .jpg, .jpeg" /> <input
															type="hidden" name="logo_remove" /> <!--end::Inputs-->
														</label>
														<!--end::Edit button-->

														<!--begin::Cancel button-->
														<span
															class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-25px h-25px bg-body shadow-sm"
															data-kt-image-input-action="cancel"
															data-bs-toggle="tooltip" data-bs-dismiss="click"
															title="Cancel logo"> <i
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

													<div class="text-muted fs-6 mt-3">Allowed file types:
														png, jpg, jpeg</div>
												</div>
											</div>
										</div>
										<div class="row g-4 mb-8">
											<div class="col-md-3">
												<label for="Title name" class="form-label required">
													คํานําหน้า </label> <select class="form-select form-select-lg"
													data-control="select2" data-placeholder="Select an option"
													name="titleNameTH" id="titleNameTH">
													<option value=""></option>
													<option value="นาย">นาย</option>
													<option value="นาง">นาง</option>
													<option value="นางสาว">นางสาว</option>
												</select>

											</div>
											<div class="col-md-9">
												<label for="Full thai name" class="form-label required">
													ชื่อ สกุล </label> <input class="form-control form-control-lg"
													type="text" name="contactNameTH" id="contactNameTH">
											</div>
										</div>

										<div class="row g-4 mb-8">
											<div class="col-md-3">
												<label for="Address name" class="form-label required">
													Title Name </label> <select class="form-select form-select-lg"
													data-control="select2" data-placeholder="Select an option"
													name="titleNameEN" id="titleNameEN">
													<option value="Mr.">Mr.</option>
													<option value="Ms.">Ms.</option>
													<option value="Mrs.">Mrs.</option>
													<option value="Miss">Miss.</option>
												</select>

											</div>
											<div class="col-md-9">
												<label for="Full english name" class="form-label required">
													Full Name EN</label> <input type="text"
													class="form-control form-control-lg" name="contactNameEN"
													id="contactNameEN">
											</div>
										</div>

										<div class="row g-8 mb-8">
											<div class="col-md-6">
												<label for="Address name" class="form-label required">
													Address Name </label> <select class="form-select form-select-lg"
													data-control="select2" data-placeholder="Select an option"
													name="addressId" id="contactAddressId">

													<c:forEach items="${addressList}" var="address">
														<option value="${address.address_id}">${address.address_name}</option>
													</c:forEach>
												</select>

											</div>
											<div class="col-md-6">
												<label for="Position" class="form-label required"> Position</label>
												<input type="text" class="form-control form-control-lg"
													name="position" id="contactPosition">
											</div>
										</div>

										<div class="row g-8 mb-8">
											<div class="col-md-6">
												<label for="Phone Number" class="form-label required">
													Phone Number</label> <input type="tel" name="phoneNumber"
													class="form-control form-control-lg" id="phoneNumber">
											</div>
											<div class="col-md-6">
												<label for="Email" class="form-label required">
													Email</label> <input type="email" name="email"
													class="form-control form-control-lg" id="contactEmail">
											</div>
										</div>

									</div>

									<div class="modal-footer border-0">
										<button type="button" class="btn btn-light"
											data-bs-dismiss="modal">Close</button>
										<button type="button" id="saveContactModalBtn"
											class="btn btn-success">Save</button>
									</div>
								</div>
							</div>
						</div>

					</div>

				</div>

				<!-- Footer Button -->
				<div class="d-flex justify-content-end gap-3 mt-8">

					<button type="button" onclick="window.history.back();"
						class="btn btn-light">Close</button>

					<button type="button" class="btn btn-success js-submit-btn">
						Save</button>

				</div>

			</div>
			<!-- end::company contact -->


		</div>

	</div>


	<script
		src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>

	<!-- begin::Custom Script -->
	<script>
			const addressStore= {};
			<c:forEach items="${addressList}" var="address">

			addressStore['${address.address_id}'] = {
			    address_id: '${address.address_id}',
			    address_name: '${address.address_name}',
			    address: '${address.address}',
			    google_map: '${address.google_map}'
			};
			</c:forEach>
			
			const contactStore= {};
			<c:forEach items="${contactList}" var="contact">

			contactStore['${contact.contact_id}'] = {
			    contact_id: '${contact.contact_id}',
			    company_id: '${contact.company_id}',
			   	address_id: '${contact.address_id}',
			    title_name_th: '${contact.title_name_th}',
			    title_name_en: '${contact.title_name_en}',
			    name_en: '${contact.contact_name}',
			    name_th: '${contact.contact_name_th}',
			    position: '${contact.position}',
			    phone_number: '${contact.phone}',
			    email: '${contact.email}',
			    profile_path: '${contact.file_path}' || null
			};
			</c:forEach>
			
			function updateBtnState(selector, state) {
			    $(selector).prop(
			        "disabled",
			        state
			    );
			}
			
			const pendingChanges = {
				address : {
					updated : {},
					created : {},
					deleted : []
				},
				contact : {
					updated : {},
					created : {},
					deleted : []
				}
			};
	
			let tempIdCounter = 0;
			
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
			
			function hasValidationErrors(stateObj) {

			    return Object.values(stateObj)
			                 .some(valid => !valid);
			}
	
			$(document).ready(function(){

				const validationState = {
					    companyCode: true,
					    companyNameEn: true
					};

				let companyCodeExists = false;
				
			
				
				
				
				/* ----------------------- Create Address -----------------------------*/
				
				//Open create new address modal
				$(document).on('click', "#createAddressBtn", showCreateAddressModal);
				
				// Save new address & Generate a new address DOM
				$(document).on('click', "#saveAddressBtn", saveCreatedAddress);
				
 				/* ----------------------- Edit Address -----------------------------*/
 				
				// Open edit address modal
				$(document).on('click', ".js-edit-address", function() { showEditAddressModal($(this).data('address-id')) });
				
				// Save address changes & Edit address DOM
				$(document).on('click', "#saveAddressModalBtn", saveAddressChanges);
				
				
				/* ----------------------- Delete Address -----------------------------*/
				$(document).on('click', ".js-delete-address", function() { deleteAddress($(this).data('address-id')) });
				
				
				
				/* ----------------------- Create Contact -----------------------------*/
				
				//Open create new contact modal
				$(document).on('click', "#createContactBtn", showCreateContactModal);
				
				// Save new contact & Generate a new contact DOM
				$(document).on('click', "#saveContactBtn", saveCreatedContact);
				
				
				/* ----------------------- Edit Contact -----------------------------*/
				
				// Open edit contact modal
				$(document).on('click', ".js-edit-contact", function() { showEditContactModal($(this).data('contact-id')) });
				
				// Save contact changes & Edit contact DOM
				$(document).on('click', "#saveContactModalBtn", saveContactChanges);
				
				/* ----------------------- Delete Address -----------------------------*/
				$(document).on('click', ".js-delete-contact", function() { deleteContact($(this).data('contact-id')) });
				
				
				
				/* ----------------------- Submit -----------------------------*/
				$(document).on('click', ".js-submit-btn", submitChanges);
				
				/* ----------------------- Validating -----------------------------*/
				$("#company-code").on(
					    "input",
					    debounce(validateCompanyCode, 500)
				);
				
				$("#company-name-en").on(
					    "input",
					    debounce(validateCompanyEnName, 500)
				);
				
				$("#company-tax-number").on("input", function () {
				    this.value = this.value.replace(/\D/g, "");
				});
				
				
				
				/* ----------------------- Function Definitions -----------------------------*/
				
				
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
				        
				        
				        return;
				    }

				    $.ajax({
				        url: "check_company_code",
				        type: "GET",
				        data: {
				            companyCode: code,
				            companyId: ${company.companyId}
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
				        }
				    });
				}
				
				function validateCompanyEnName() {

				    const value = $(this).val().trim();
				    
				    if (value === "") {
						validationState.companyNameEn = true;
				        clearFieldError("#company-name-en");
				        return;
				    }

				    const regex = /^[A-Za-z0-9\s.,&()\/'@+_-]+$/;

				    if (!regex.test(value)) {
				    	validationState.companyNameEn = false;
				        setFieldInvalid(
				            "#company-name-en",
				            "Only English letters are allowed"
				        );
				        return;
				    }
				    validationState.companyNameEn = true;
				    clearFieldError("#company-name-en");
				    return;
				}
				
				
				function showEditAddressModal (addressId) {
					for (const key of Object.keys(addressValidationState)) {
						addressValidationState[key] = true;
					}
					
					updateBtnState("#saveAddressModalBtn", hasValidationErrors(addressValidationState));
					
				    const data =
				        pendingChanges.address.updated[addressId]
				        || addressStore[addressId] 
				    	|| pendingChanges.address.created[addressId];
				    
				    $("#editingAddressId").val(addressId);
				    $("#address-name-update").val(data.address_name);
				    $("#address-value-update").val(data.address);
				    $("#ggMap-update").val(data.google_map);
				
				    bootstrap.Modal
				        .getOrCreateInstance(
				            document.getElementById("editAddressModal")
				        )
				        .show();
				}
				
				function saveAddressChanges () {
					
					// Extract input value
				    const addressId =
				        $("#editingAddressId").val();
	
				    const data = {
	
				        address_id: addressId,
	
				        address_name:
				            $("#address-name-update").val(),
	
				        address:
				            $("#address-value-update").val(),
	
				        google_map:
				            $("#ggMap-update").val()
	
				    };
				    
				 	// Append changes
				    addressId.startsWith("temp_") ? pendingChanges.address.created[addressId] = data : pendingChanges.address.updated[addressId] = data;
	
				    
				    /* pendingChanges.address.updated[addressId] = data; */
	
					// Manipulate address DOM
				    $("#name_" + addressId).text(data.address_name);
				    $("#address_" + addressId).text(data.address);
				    $("#googleMap_" + addressId).text(data.google_map);
					
				    // Close modal
				    bootstrap.Modal.getOrCreateInstance(document.getElementById("editAddressModal")).hide();
				    console.log(pendingChanges)
				}
				
				function deleteAddress(addressId) {
					const addressIdStr = String(addressId)
					const isTemp = addressIdStr.startsWith("temp_")
					
					if (isTemp) {
						delete pendingChanges.address.created[addressIdStr]
					} 
					
					delete pendingChanges.address.updated[addressIdStr]
					$("#addressCard-" + addressIdStr).remove()

					if (!isTemp) pendingChanges.address.deleted.push(addressIdStr)
					console.log(pendingChanges)
				}
				
				function showEditContactModal(contactId) {
				    const data =
				        pendingChanges.contact.updated[contactId]
				        || contactStore[contactId]
				    	|| pendingChanges.contact.created[contactId];

				    $("#editingContactId").val(contactId);

				    $("#titleNameTH").val(data.title_name_th).trigger("change");
				    $("#titleNameEN").val(data.title_name_en).trigger("change");

				    $("#contactNameTH").val(data.name_th);
				    $("#contactNameEN").val(data.name_en);

				    $("#contactPosition").val(data.position);
				    $("#phoneNumber").val(data.phone_number);
				    $("#contactEmail").val(data.email);

				    $("#contactAddressId")
				        .val(data.address_id)
				        .trigger("change");

				    bootstrap.Modal
				        .getOrCreateInstance(
				            document.getElementById("editContactModal")
				        )
				        .show();
				}
				
				function saveContactChanges() {

				    const contactId = $("#editingContactId").val();

				    const data = {

				        contact_id: contactId,

				        title_name_th: $("#titleNameTH").val(),
				        title_name_en: $("#titleNameEN").val(),

				        name_th: $("#contactNameTH").val(),
				        name_en: $("#contactNameEN").val(),

				        position: $("#contactPosition").val(),

				        phone_number: $("#phoneNumber").val(),
				        email: $("#contactEmail").val(),

				        address_id: $("#contactAddressId").val() || null,

				        profile_path:
				            contactStore[contactId]?.profile_path || null
				    };
				    
				    console.log(data.address_id)

				 	// Append changes
				    contactId.startsWith("temp_") ? pendingChanges.contact.created[contactId] = data : pendingChanges.contact.updated[contactId] = data;

				    $("#contactName" + contactId)
				        .text(data.name_en);

				    $("#contactPosition" + contactId)
				        .text(data.position);
				    
				    $("#contactAddressName" + contactId).text(addressStore[data.address_id]?.address_name || "-")
				    $("#contactPhoneNumber" + contactId)
				        .text(data.phone_number || "-");

				    $("#contactEmail" + contactId)
				        .text(data.email || "-");

				    bootstrap.Modal
				        .getOrCreateInstance(
				            document.getElementById("editContactModal")
				        )
				        .hide();
				    
				    console.log(pendingChanges)
				}
				
				function deleteContact(contactId) {
					const contactIdStr = String(contactId)
					const isTemp = contactIdStr.startsWith("temp_")
					
					if (isTemp) {
						delete pendingChanges.contact.created[contactIdStr]
					} 
					
					delete pendingChanges.contact.updated[contactIdStr]
					$("#contactCard-" + contactIdStr).remove()

					if (!isTemp) pendingChanges.contact.deleted.push(contactIdStr)
					console.log(pendingChanges)
				}
				
				function showCreateAddressModal() {
					
					// Init validation state
					for (const key of Object.keys(addressValidationState)) {
						addressValidationState[key] = false;
					}
					
					updateBtnState("#saveAddressBtn", hasValidationErrors(addressValidationState));

					// Clear previous input
					$('#address-name-create').val("")
					$('#address-value-create').val("")
					$('#ggMap-create').val("")
					
					clearFieldError('#address-name-create')
					clearFieldError('#address-value-create')
					clearFieldError('#ggMap-create')
					
					// Open modal
					 bootstrap.Modal
				        .getOrCreateInstance(
				            document.getElementById("createAddressModal")
				        )
				        .show();
				}
				
				function saveCreatedAddress() {

					// Construct a new address
					const addressId = "temp_" + (++tempIdCounter) 
					const data = {
						address_id: addressId,
						address_name: $('#address-name-create').val(),
						address: $('#address-value-create').val(),
						google_map: $('#ggMap-create').val()
					}
					
					// Append changes
					pendingChanges.address.created[data.address_id] = data;
					
					// Close the modal
					bootstrap.Modal
				        .getOrCreateInstance(
				            document.getElementById("createAddressModal")
				        )
				        .hide();
					
					// Append new address
					const cardElm = $('#addressCard')
					cardElm.find('#addressNotFound').remove();
					const html = `
							<div
							class="d-flex flex-column flex-md-row
			                       justify-content-between
			                       align-items-start align-items-md-center
			                       border py-6 py-md-15 px-6 gap-6"
			                       id="addressCard-\${addressId}"
			                 >
	
							<div class="address-name-col ps-md-3" >
								<h2 id="name_\${addressId}" class="text-break">\${data.address_name}</h2>
							</div>
	
							<div
								class="d-flex flex-grow-1 flex-column mw-md-75 gap-3 gap-md-6 ms-xl-15 ">
	
								<div class="text-break lh-lg">
									<div
										class="fw-semibold mb-1 d-flex align-items-center gap-3">
	
										<i class="ki-duotone ki-map me-1 fs-1"> <span
											class="path1"></span> <span class="path2"></span> <span
											class="path3"></span>
										</i> <span class="text-gray-800"
											id="address_\${addressId}">
											\${data.address} </span>
	
									</div>
								</div>
	
								<div class="text-break lh-lg">
									<div
										class="fw-semibold mb-1 d-flex align-items-center gap-3">
	
										<i class="ki-duotone ki-geolocation me-1 fs-1"> <span
											class="path1"></span> <span class="path2"></span>
										</i> <span class="text-gray-800"
											id="googleMap_\${addressId}">
											\${data.google_map} </span>
	
									</div>
								</div>
	
							</div>
	
							<div
								class="d-flex align-items-center flex-shrink-0 justify-content-end gap-3 ms-md-auto w-100 w-md-auto mt-3 mt-md-0">
	
								<button type="button"
									class="btn btn-icon btn-sm btn-light-primary mb-1 fs-3 js-edit-address"
									data-address-id="\${addressId}"
									>
	
									<i class="ki-duotone ki-pencil fs-1"> <span
										class="path1"></span> <span class="path2"></span>
									</i>
	
								</button>
	
								<button
								class="btn btn-icon btn-sm btn-light-danger mb-1 fs-3 me-1 js-delete-address"
								data-address-id="\${addressId}"> <i
								class="ki-duotone ki-trash fs-1"> <span class="path1"></span>
									<span class="path2"></span> <span class="path3"></span> <span
									class="path4"></span> <span class="path5"></span>
								</i>
	
								</button>
	
							</div>
						</div> 
					`
					 console.log(pendingChanges)
					cardElm.append(html);
				}
				
				
				function showCreateContactModal() {
					// Clear input
				    $("#titleNameTH-create").val("").trigger("change")
				    $("#titleNameEN-create").val("").trigger("change")
				    $("#contactAddressId-create").val("").trigger("change")
				    
				    
				    $("#contactNameTH-create").val("")
				    $("#contactNameEN-create").val("")
				    $("#contactPosition-create").val("")
				    $("#phoneNumber-create").val("")
				    $("#contactEmail-create").val("")

					
					// Open modal
					 bootstrap.Modal
				        .getOrCreateInstance(
				            document.getElementById("createContactModal")
				        )
				        .show();
				}
				
				function saveCreatedContact() {
					// Construct a new address
					const contactId = "temp_" + (++tempIdCounter) 
					const data = {

				        contact_id: contactId,

				        title_name_th: $("#titleNameTH-create").val(),
				        title_name_en: $("#titleNameEN-create").val(),

				        name_th: $("#contactNameTH-create").val(),
				        name_en: $("#contactNameEN-create").val(),

				        position: $("#contactPosition-create").val(),

				        phone_number: $("#phoneNumber-create").val(),
				        email: $("#contactEmail-create").val(),

				        address_id: $("#contactAddressId-create").val(),

				        profile_path:
				            contactStore[contactId]?.profile_path || null
				    };
					
					// Append changes
					pendingChanges.contact.created[data.contact_id] = data;
					
					// Close the modal
					bootstrap.Modal
				        .getOrCreateInstance(
				            document.getElementById("createContactModal")
				        )
				        .hide();
					
					// Append new contact
					const cardElm = $('#contactCard')
					cardElm.find('#contactNotFound').remove();
					const html = `
						<div
						   class="d-flex flex-column flex-md-row
				           justify-content-between
				           align-items-start align-items-md-center
				           border py-6 py-md-15 px-6 gap-8 gap-md-3"
				           id="contactCard-\${contactId}" 
				          >
						<div class="d-flex align-items-center gap-4 flex-shrink-0 "
							style="width: 250px">
							<div class="symbol symbol-50px symbol-circle">
							 \${
					                data.profile_path
					                ? `
					                    <div class="symbol-label"
					                         style="background-image:url('${pageContext.request.contextPath}\${data.profile_path}')">
					                    </div>
					                  `
					                : `
					                    <div class="symbol-label fs-5 fw-bold text-primary">
					                        \${data.name_en?.charAt(0).toUpperCase() || "?"}
					                    </div>
					                  `
					            }
							</div>
							<div class="d-flex flex-column gap-2 fw-semibold"
								style="word-break: break-word">
								<span class="text-gray-900" id="contactName\${contactId}"> \${data.name_en}
								</span> <span class="text-gray-600" id="contactPosition\${contactId}">\${data.position}</span>
							</div>
						</div>

						<div
							class="row flex-grow-1 gap-2 gap-xl-0 middle-section justify-content-md-around ">
							<div class="col-xl-3 gap-2 d-flex align-items-center ">
								<i class="ki-duotone ki-map me-2 fs-1"> <span
									class="path1"></span> <span class="path2"></span> <span
									class="path3"></span>
								</i> <span class="text-gray-800 fs-6 text-break" id="contactAddressName\${contactId}">\${addressStore[data.address_id]?.address_name || "-"}</span>
							</div>
							<div class="col-xl-3 gap-2 d-flex align-items-center ">
								<i class="ki-duotone ki-map me-2 fs-1"> <span
									class="path1"></span> <span class="path2"></span> <span
									class="path3"></span>
								</i> <span class="text-gray-800 fs-6 text-break" id="contactPhoneNumber\${contactId}">\${data.phone_number || "-"}</span>
							</div>
							<div class="col-xl-4 gap-2 d-flex align-items-center "
								>
								<i class="ki-duotone ki-map me-2 fs-1"> <span
									class="path1"></span> <span class="path2"></span> <span
									class="path3"></span>
								</i> <span class="text-gray-800 fs-6 text-break" id="contactEmail\${contactId}">\${data.email || "-"}</span>
							</div>
						</div>

						<div
							class="d-flex align-items-center justify-content-end flex-shrink-0 gap-3 ms-md-auto  w-100 w-md-auto mt-3 mt-md-0">
							<button type="button"
								class="btn btn-icon btn-sm btn-light-primary mb-1 fs-3 js-edit-contact"
								data-contact-id="\${contactId}">
								<i class="ki-duotone ki-pencil fs-1"><span class="path1"></span><span
									class="path2"></span></i>
							</button>
							<button
							class="btn btn-icon btn-sm btn-light-danger mb-1 fs-3 me-1 js-delete-contact"
							data-contact-id="\${contactId}"> <i
							class="ki-duotone ki-trash fs-1"> <span class="path1"></span>
								<span class="path2"></span> <span class="path3"></span> <span
								class="path4"></span> <span class="path5"></span>
							</i>

							</button>
						</div>
					</div>
					`
					console.log(pendingChanges)
					cardElm.append(html);
				}
				
				function submitChanges() {

					if (hasValidationErrors(validationState)) {

				        Swal.fire({
				            icon: "warning",
				            title: "Invalid Data",
				            text: "Please fix validation errors before saving"
				        });

				        return;
				    }
					
					const company = {
						id: ${company.companyId},
						code: $("#company-code").val().trim(),
						taxId: $("#company-tax-number").val().trim(),
						nameEN: $("#company-name-en").val().trim(),
						nameTH: $("#company-name-th").val().trim(),
						industry: $("#company-industry").val(),
						isActive: $("#company-active").is(":checked") ? "1" : "0"
					};
					
				    const payload = {
				        company,
				        address: {
				            updated: Object.values(pendingChanges.address.updated),
				            created: Object.values(pendingChanges.address.created),
				            deleted: pendingChanges.address.deleted
				        },

				        contact: {
				            updated: Object.values(pendingChanges.contact.updated),
				            created: Object.values(pendingChanges.contact.created),
				            deleted: pendingChanges.contact.deleted
				        }
				    };

				    Swal.fire({
				        icon: 'warning',
				        title: 'Confirm Save',
				        text: 'Do you want to save these changes?',
				        showCancelButton: true,
				        confirmButtonText: 'Yes, Save',
				        cancelButtonText: 'Cancel',
				        reverseButtons: true
				    }).then((result) => {

				        if (!result.isConfirmed) {
				            return;
				        }

				        $.ajax({
				            url: 'update_company',
				            type: 'POST',
				            contentType: 'application/json; charset=UTF-8',
				            data: JSON.stringify(payload),
				            
				            beforeSend: function() {
				                Swal.fire({
				                    title: 'Saving...',
				                    text: 'Please wait',
				                    allowOutsideClick: false,
				                    allowEscapeKey: false,
				                    didOpen: () => {
				                        Swal.showLoading();
				                    }
				                });
				            },

				            success: function(res) {
								console.log(res);
				                Swal.fire({
				                    icon: 'success',
				                    title: 'Saved',
				                    text: 'Data saved successfully',
				                    confirmButtonText: 'OK',
				                    allowOutsideClick: false,
				                    allowEscapeKey: false
				                }).then(() => {
				                    location.reload();
				                });

				            },

				            error: function(xhr) {

				                Swal.fire({
				                    icon: 'error',
				                    title: 'Error',
				                    text: 'Cannot save data'
				                });

				            }
				        });

				    });
				}
				
			});
	</script>
	<!-- end::Custom Script -->
	
	<script>
	
		const addressValidationState = {
			    addressName: false,
			    addressVal: false,
			    ggMap: false
			};

		function bindAddressValidation(selector, errMsg, key) {
		    $(selector).on(
		        "input",
		        debounce(function () {
		            validateRequiredField($(this), errMsg, key);
		        }, 500)
		    );
		}

		function validateRequiredField(input, errMsg, key) {

		    const val = input.val().trim();
		    const mode = input.attr("id").includes("-update") ? "update" : "create"

		    if (!val) {

		        addressValidationState[key] = false;

		        setFieldInvalid(
		            "#" + input.attr("id"),
		            errMsg
		        );

		    } else {

		        addressValidationState[key] = true;

		        clearFieldError(
		            "#" + input.attr("id")
		        );
		    }

		    const btnSelector = mode === "update" ? "#saveAddressModalBtn" : "#saveAddressBtn"
		    
		    updateBtnState(
		    	btnSelector,
		        hasValidationErrors(addressValidationState)
		    );
		}
	
		$(document).ready(function() {
			bindAddressValidation(
				    "#address-name-create, #address-name-update",
				    "Address Name is required",
				    "addressName"
				);

			bindAddressValidation(
				    "#address-value-create, #address-value-update",
				    "Address is required",
				    "addressVal"
				);

			bindAddressValidation(
				    "#ggMap-create, #ggMap-update",
				    "Google Map URL is required",
				    "ggMap"
				);
			
		});
	</script>
		
	<script>
		const contactValidationState = {
			    titleNameTH: false,
			    contactNameTH: false,
			    titleNameEN: false,
			    contactNameEN: false,
			    addressId: false,
			    position: false,
			    phoneNumber: false,
			    email: false
			};
		
		function bindContactValidation(selector, errMsg, key) {
		    $(selector).on(
		        "input change",
		        debounce(function () {
		            validateContactRequired($(this), errMsg, key);
		        }, 300)
		    );
		}

		function validateContactRequired(input, errMsg, key) {

		    const val = input.val()?.trim();

		    if (!val) {

		        contactValidationState[key] = false;

		        setFieldInvalid(
		            "#" + input.attr("id"),
		            errMsg
		        );

		    } else {

		        contactValidationState[key] = true;

		        clearFieldError(
		            "#" + input.attr("id")
		        );
		    }

		    updateBtnState(
		        "#saveContactBtn",
		        hasValidationErrors(contactValidationState)
		    );
		}
		
		function validatePhoneNumber() {

		    const input = $(this);
		    const value = input.val().trim();

		    if (!value) {

		        contactValidationState.phoneNumber = false;

		        setFieldInvalid(
		            "#phoneNumber-create",
		            "Phone Number is required"
		        );

		        return updateBtnState(
		            "#saveContactBtn",
		            hasValidationErrors(contactValidationState)
		        );
		    }

		    if (!/^[0-9]+$/.test(value)) {

		        contactValidationState.phoneNumber = false;

		        setFieldInvalid(
		            "#phoneNumber-create",
		            "Phone Number must contain only numbers"
		        );

		    } else {

		        contactValidationState.phoneNumber = true;

		        clearFieldError("#phoneNumber-create");
		    }

		    updateBtnState(
		        "#saveContactBtn",
		        hasValidationErrors(contactValidationState)
		    );
		}
		
		function validateEmail() {

		    const input = $(this);
		    const value = input.val().trim();

		    if (!value) {

		        contactValidationState.email = false;

		        setFieldInvalid(
		            "#contactEmail-create",
		            "Email is required"
		        );

		        return updateBtnState(
		            "#saveContactBtn",
		            hasValidationErrors(contactValidationState)
		        );
		    }

		    const emailRegex =
		        /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

		    if (!emailRegex.test(value)) {

		        contactValidationState.email = false;

		        setFieldInvalid(
		            "#contactEmail-create",
		            "Invalid email format"
		        );

		    } else {

		        contactValidationState.email = true;

		        clearFieldError("#contactEmail-create");
		    }

		    updateBtnState(
		        "#saveContactBtn",
		        hasValidationErrors(contactValidationState)
		    );
		}
		
		function validateContactNameEN() {

		    const input = $(this);
		    const value = input.val().trim();

		    if (!value) {

		        contactValidationState.contactNameEN = false;

		        setFieldInvalid(
		            "#contactNameEN-create",
		            "Full Name EN is required"
		        );

		    } else if (
		        !/^[A-Za-z\s.'-]+$/.test(value)
		    ) {

		        contactValidationState.contactNameEN = false;

		        setFieldInvalid(
		            "#contactNameEN-create",
		            "Only English letters are allowed"
		        );

		    } else {

		        contactValidationState.contactNameEN = true;

		        clearFieldError("#contactNameEN-create");
		    }

		    updateBtnState(
		        "#saveContactBtn",
		        hasValidationErrors(contactValidationState)
		    );
		}
		
		function validateContactNameTH() {

		    const input = $(this);
		    const value = input.val().trim();

		    if (!value) {

		        contactValidationState.contactNameTH = false;

		        setFieldInvalid(
		            "#contactNameTH-create",
		            "Name TH is required"
		        );

		    } else if (
		        !/^[ก-๙\s]+$/.test(value)
		    ) {

		        contactValidationState.contactNameTH = false;

		        setFieldInvalid(
		            "#contactNameTH-create",
		            "Only Thai characters are allowed"
		        );

		    } else {

		        contactValidationState.contactNameTH = true;

		        clearFieldError("#contactNameTH-create");
		    }

		    updateBtnState(
		        "#saveContactBtn",
		        hasValidationErrors(contactValidationState)
		    );
		}
		
		$(document).ready(function () {

		    bindContactValidation(
		        "#titleNameTH-create",
		        "Title Name TH is required",
		        "titleNameTH"
		    );

		    bindContactValidation(
		        "#titleNameEN-create",
		        "Title Name EN is required",
		        "titleNameEN"
		    );

		    bindContactValidation(
		        "#contactAddressId-create",
		        "Address is required",
		        "addressId"
		    );

		    bindContactValidation(
		        "#contactPosition-create",
		        "Position is required",
		        "position"
		    );

		    $("#contactNameTH-create").on(
		        "input",
		        debounce(validateContactNameTH, 300)
		    );

		    $("#contactNameEN-create").on(
		        "input",
		        debounce(validateContactNameEN, 300)
		    );

		    $("#phoneNumber-create").on(
		        "input",
		        debounce(validatePhoneNumber, 300)
		    );

		    $("#contactEmail-create").on(
		        "input",
		        debounce(validateEmail, 300)
		    );
		});
	</script>
</body>
</html>