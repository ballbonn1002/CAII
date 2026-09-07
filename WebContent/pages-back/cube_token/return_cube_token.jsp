<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
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
.border.border-gray-300 {
	border-color: var(--bs-gray-300) !important;
}

.token-summary-item {
	min-width: 50px;
	white-space: nowrap;
}

/* Put separator at the center of Bootstrap gutter */
.token-summary-add .row>.col:not(:first-child), .token-summary-deduct .row>.col:not(:first-child)
	{
	position: relative;
}

.token-summary-add .row>.col:not(:first-child)::before,
	.token-summary-deduct .row>.col:not(:first-child)::before {
	content: "";
	position: absolute;
	left: -2px;
	top: 50%;
	transform: translateY(-50%);
	width: 2px;
	height: 28px;
	border-radius: 2px;
	z-index: 1;
}

/* Green */
.token-summary-add .row>.col:not(:first-child)::before {
	background-color: var(--bs-success-border-subtle);
}

/* Red */
.token-summary-deduct .row>.col:not(:first-child)::before {
	background-color: var(--bs-danger-border-subtle);
}

.year-option.active {
	background-color: var(--bs-primary-light);
	color: var(--bs-primary);
	font-weight: 600;
	border-radius: 4px;
}

.token-collapse-icon {
	transition: transform 0.2s ease;
}

.token-collapse-icon.rotate-180 {
	transform: rotate(180deg);
}

.vr.text-ligth-primary {
	height: 17px !important;
	background-color: var(--bs-primary-border-subtle) !important;
	width: 1px !important;
}

.responsive-button {
	padding: 0.775rem 1.5rem !important;
	font-size: 1.1rem !important;
	border-radius: 0.475rem !important;
}

/* Mobile */
@media ( max-width : 767.98px) {
	.token-summary-add .row>.col::before, .token-summary-deduct .row>.col::before
		{
		display: none;
	}
	.token-summary-item {
		justify-content: flex-start !important;
	}
	.token-monthly-separator::before {
		display: none;
	}
	.responsive-button {
		padding: 0.7rem 1rem !important;
		font-size: 0.95rem !important;
		border-radius: 0.425rem !important;
		font-weight: 500 !important;
		line-height: 1.5 !important;
	}
}

/* Laptop */
@media ( min-width : 992px) and (max-width: 1700px) {
	.token-summary-deduct .row, .token-summary-add .row {
		--bs-gutter-x: 0.5rem !important;
	}
	.token-summary-deduct .token-summary-item, .token-summary-add .token-summary-item
		{
		min-width: 0 !important;
		gap: 0.3rem !important;
		white-space: nowrap;
	}
	.token-summary-deduct .token-summary-item i, .token-summary-add .token-summary-item i
		{
		flex-shrink: 0 !important;
	}
	.token-summary-deduct .token-summary-item .fs-6, .token-summary-add .token-summary-item .fs-6
		{
		font-size: 0.7rem !important;
	}
	.token-summary-deduct .token-summary-item .fs-3, .token-summary-add .token-summary-item .fs-3
		{
		font-size: 1rem !important;
	}
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
						Return Cube Token</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/check_in_out"
							class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/cubeTokenManagement"
							class="text-muted text-hover-primary">Cube Token Management</a></li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Return Cube Token</li>
					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid ">
			<div id="kt_app_content_container"
				class="app-container container-fluid">
				<div class="d-flex justify-content-end">
					<div class="dropdown">
						<button
							class="btn btn-light-primary year-select d-flex align-items-center justify-content-center"
							type="button" data-bs-toggle="dropdown" aria-expanded="false">

							<i class="ki-duotone ki-filter fs-1"> <span class="path1"></span>
								<span class="path2"></span>
							</i>
						</button>

						<div class="dropdown-menu dropdown-menu-end p-3 "
							id="token-year-menu"></div>
					</div>
				</div>

				<div class="row g-5 align-items-stretch">

					<!-- ================= EMPLOYEE INFO ================= -->
					<div class="col-12 col-lg-12 col-xl-6 d-flex">

						<div class="card card-flush mt-6 px-9 pb-0 pt-6 w-100 h-100">

							<!-- Employee Personal Info -->
							<div class="employee-personal-info">

								<!-- Name + Employee Type + Status -->
								<div class="d-flex align-items-center gap-3 flex-wrap">

									<div class="fw-bold fs-2 text-gray-900">
										${userInfo.name_en}</div>

									<div>
										<!-- Employee Type -->
										<span
											class="badge
										<c:choose>
											<c:when test="${userInfo.employee_type == '1'}">
												badge-light-primary py-2
											</c:when>
											<c:when test="${userInfo.employee_type == '2'}">
												badge-light-warning py-2
											</c:when>
											<c:when test="${userInfo.employee_type == '3'}">
												badge-light-info py-2
											</c:when>
											<c:otherwise>
												badge-light-secondary
											</c:otherwise>
										</c:choose>">

											<c:choose>
												<c:when test="${userInfo.employee_type == '1'}">
												พนักงานประจำ
											</c:when>
												<c:when test="${userInfo.employee_type == '2'}">
												พนักงานอัตราจ้าง
											</c:when>
												<c:when test="${userInfo.employee_type == '3'}">
												นักศึกษาฝึกงาน
											</c:when>
												<c:otherwise>
												Unknown
											</c:otherwise>
											</c:choose>

										</span>

										<!-- Employee Status -->
										<span
											class="badge
									<c:choose>
										<c:when test="${userInfo.employee_status == '1'}">
											badge-light-success py-2
										</c:when>
										<c:when test="${userInfo.employee_status == '2'}">
											badge-light-warning py-2
										</c:when>
										<c:when test="${userInfo.employee_status == '0'}">
											badge-light-danger py-2
										</c:when>
										<c:when test="${userInfo.employee_status == '3'}">
											badge-light-info py-2
										</c:when>
										<c:otherwise>
											badge-light-secondary
										</c:otherwise>
									</c:choose>">
											<c:choose>
												<c:when test="${userInfo.employee_status == '1'}">
												Active
											</c:when>
												<c:when test="${userInfo.employee_status == '2'}">
												Probation
											</c:when>
												<c:when test="${userInfo.employee_status == '0'}">
												Excluded
											</c:when>
												<c:when test="${userInfo.employee_status == '3'}">
												Intern
											</c:when>
												<c:otherwise>
												Unknown
											</c:otherwise>
											</c:choose>

										</span>
									</div>
								</div>


								<!-- Employee ID + Name -->
								<div
									class="d-flex align-items-center gap-3 fw-normal mt-3 mt-md-1 fs-6 fs-md-4 text-gray-900">

									<div id="employeeId">${userInfo.employee_id}</div>

									<div id="employeeName">
										${userInfo.name_en}-${userInfo.name_th}</div>

								</div>

							</div>

							<!-- Employee Work Info -->
							<div class="employee-work-info mt-4">
								<div class="row g-5">
									<!-- Position -->
									<div class="col-md-4">
										<div
											class="employee-position
													d-flex flex-column
													px-4 py-3
													border border-gray-300 border-dashed
													rounded h-100">

											<span class="fw-bold fs-4 text-gray-900"
												id="employeePosition"> ${userInfo.position} </span> <span
												class="fw-bold fs-6 text-gray-600"> Position </span>

										</div>

									</div>


									<!-- Department -->
									<div class="col-md-4">
										<div
											class="employee-department
													d-flex flex-column
													px-4 py-3
													border border-gray-300 border-dashed
													rounded h-100">

											<span class="fw-bold fs-4 text-gray-900"
												id="employeeDepartment"> ${userInfo.department} </span> <span
												class="fw-bold fs-6 text-gray-600"> Department </span>
										</div>

									</div>

									<!-- Site -->
									<div class="col-md-4">
										<div
											class="employee-site
													d-flex flex-column
													px-4 py-3
													border border-gray-300 border-dashed
													rounded h-100">

											<span class="fw-bold fs-4 text-gray-900"> <c:choose>
													<c:when test="${not empty userInfo.jobsiteList}">
														<c:forEach var="site" items="${userInfo.jobsiteList}"
															varStatus="status">
															${site.name_site}
															<c:if test="${!status.last}">
																,
															</c:if>
														</c:forEach>
													</c:when>

													<c:otherwise>
														-
													</c:otherwise>
												</c:choose>

											</span> <span class="fw-bold fs-6 text-gray-600"> Site </span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>


					<!-- ================= TOTAL / YEARLY TOKEN ================= -->
					<div class="col-12 col-lg-12 col-xl-6 d-flex">

						<div class="row g-5 flex-grow-1">

							<!-- ================= TOTAL TOKEN ================= -->
							<div class="col-6 d-flex">
								<div class="card card-flush mt-6 w-100 h-100">
									<div
										class="d-flex flex-column
												align-items-center
												justify-content-center
												h-100 gap-1">

										<!-- Icon -->
										<div>
											<i class="ki-duotone ki-cube-2 fs-4x text-primary"> <span
												class="path1"></span> <span class="path2"></span> <span
												class="path3"></span>
											</i>
										</div>

										<!-- Token Information -->
										<div
											class="d-flex flex-column
													align-items-center
													justify-content-center">
											<span class="fw-bold fs-2qx text-gray-800 token-value"
												data-field="cubeToken"> - </span> <span
												class="fs-4 fw-bold text-primary"> Cube Token </span> <span
												class="fs-6 text-gray-600"> สะสมทั้งหมด </span>
										</div>

									</div>

								</div>

							</div>


							<!-- ================= YEARLY TOKEN ================= -->
							<div class="col-6 d-flex">

								<div class="card card-flush mt-6 w-100 h-100">

									<div
										class="d-flex flex-column
												align-items-center
												justify-content-center
												h-100 gap-1">
										<!-- Icon -->
										<div>
											<i class="ki-duotone ki-cube-3 fs-4x text-primary"> <span
												class="path1"></span> <span class="path2"></span> <span
												class="path3"></span>
											</i>
										</div>

										<!-- Token Information -->
										<div
											class="d-flex flex-column
													align-items-center
													justify-content-center">

											<span class="fw-bold fs-2qx text-gray-800 token-value"
												data-field="yearlyCubeToken"> - </span> <span
												class="fs-4 fw-bold text-primary"> Cube Token </span> <span
												class="fs-6 fw-semibold text-gray-600"> สะสมรายปี <span
												id="yearlyCubeToken-year">2026</span>
											</span>
										</div>

									</div>

								</div>

							</div>

						</div>

					</div>

				</div>


				<div class="mt-10 mb-4">
					<div class="row g-6">

						<!-- Cube Token -->
						<!-- 						<div class="col-12 col-xxl-2 h-100">
							<div class="text-primary fw-bold fs-4 mb-2">Cube</div>
							<div class="card mt-4">
								<div class="card-body">
									<div
										class="d-flex flex-column align-items-center justify-content-center gap-4">
										<div>
											<i class="ki-duotone ki-cube-2 fs-4x text-primary"> <span
												class="path1"></span> <span class="path2"></span> <span
												class="path3"></span>
											</i>
										</div>
										<div
											class="d-flex flex-column align-items-center justify-content-center gap-3">
											<span class="fw-bold fs-2qx text-gray-800 token-value"
												data-field="cubeToken"> - </span> <span
												class="fs-8 text-gray-600">Cube Token</span>
										</div>
									</div>
								</div>
							</div>
						</div> -->

						<!-- ได้รับ -->
						<div class="col-12 col-xxl-6 h-100">

							<div class="text-success fw-bold fs-4">ได้รับ</div>

							<div class="row row row-cols-2 row-cols-xl-4 g-5">

								<div class="col">
									<div class="card mt-4">
										<div class="card-body">
											<div
												class="d-flex flex-column align-items-center justify-content-center gap-4">
												<div>
													<i class="ki-duotone ki-award fs-4x text-success"> <span
														class="path1"></span> <span class="path2"></span> <span
														class="path3"></span>
													</i>
												</div>
												<div
													class="d-flex flex-column align-items-center justify-content-center gap-3">
													<span class="fw-bold fs-2qx text-gray-800"
														data-field="gift"> - </span> <span
														class="fs-8 text-gray-600">Gift</span>
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="col">
									<div class="card mt-4">
										<div class="card-body">
											<div
												class="d-flex flex-column align-items-center justify-content-center gap-4">
												<div>
													<i class="ki-duotone ki-crown-2 fs-4x text-success"> <span
														class="path1"></span> <span class="path2"></span> <span
														class="path3"></span>
													</i>
												</div>
												<div
													class="d-flex flex-column align-items-center justify-content-center gap-3">
													<span class="fw-bold fs-2qx text-gray-800"
														data-field="reward"> - </span> <span
														class="fs-8 text-gray-600">Reward</span>
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="col">
									<div class="card mt-4">
										<div class="card-body">
											<div
												class="d-flex flex-column align-items-center justify-content-center gap-4">
												<div>
													<i class="ki-duotone ki-arrows-circle fs-4x text-success">
														<span class="path1"></span> <span class="path2"></span>
													</i>
												</div>
												<div
													class="d-flex flex-column align-items-center justify-content-center gap-3">
													<span class="fw-bold fs-2qx text-gray-800"
														data-field="return"> - </span> <span
														class="fs-8 text-gray-600">Return</span>
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="col">
									<div class="card mt-4">
										<div class="card-body">
											<div
												class="d-flex flex-column align-items-center justify-content-center gap-4">
												<div>
													<i
														class="ki-duotone ki-arrow-right-left fs-4x text-success">
														<span class="path1"></span> <span class="path2"></span>
													</i>
												</div>
												<div
													class="d-flex flex-column align-items-center justify-content-center gap-3">
													<span class="fw-bold fs-2qx text-gray-800"
														data-field="exchange"> - </span> <span
														class="fs-8 text-gray-600">Exchange</span>
												</div>
											</div>
										</div>
									</div>
								</div>

							</div>

						</div>

						<!-- หัก -->
						<div class="col-12 col-xxl-6 h-100">

							<div class="text-danger fw-bold fs-4">หัก</div>

							<div class="row row-cols-2 row-cols-xl-5 g-5">

								<div class="col">
									<div class="card mt-4">
										<div class="card-body">
											<div
												class="d-flex flex-column align-items-center justify-content-center gap-4">
												<div>
													<i class="ki-duotone ki-time fs-4x text-danger"> <span
														class="path1"></span> <span class="path2"></span>
													</i>
												</div>
												<div
													class="d-flex flex-column align-items-center justify-content-center gap-3">
													<span class="fw-bold fs-2qx text-gray-800"
														data-field="late"> - </span> <span
														class="fs-8 text-gray-600">Late</span>
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="col">
									<div class="card mt-4">
										<div class="card-body">
											<div
												class="d-flex flex-column align-items-center justify-content-center gap-4">
												<div>
													<i class="ki-duotone ki-brifecase-timer fs-4x text-danger">
														<span class="path1"></span> <span class="path2"></span> <span
														class="path3"></span>
													</i>
												</div>
												<div
													class="d-flex flex-column align-items-center justify-content-center gap-3">
													<span class="fw-bold fs-2qx text-gray-800"
														data-field="earlyOut"> - </span> <span
														class="fs-8 text-gray-600 text-nowrap">Early Out</span>
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="col">
									<div class="card mt-4">
										<div class="card-body">
											<div
												class="d-flex flex-column align-items-center justify-content-center gap-4">
												<div>
													<i class="ki-duotone ki-calendar-8 fs-4x text-danger">
														<span class="path1"></span> <span class="path2"></span> <span
														class="path3"></span> <span class="path4"></span> <span
														class="path5"></span> <span class="path6"></span>
													</i>
												</div>
												<div
													class="d-flex flex-column align-items-center justify-content-center gap-3">
													<span class="fw-bold fs-2qx text-gray-800"
														data-field="leave"> - </span> <span
														class="fs-8 text-gray-600">Leave</span>
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="col">
									<div class="card mt-4">
										<div class="card-body">
											<div
												class="d-flex flex-column align-items-center justify-content-center gap-4">
												<div>
													<i class="ki-duotone ki-calendar-edit fs-4x text-danger">
														<span class="path1"></span> <span class="path2"></span> <span
														class="path3"></span>
													</i>
												</div>
												<div
													class="d-flex flex-column align-items-center justify-content-center gap-3">
													<span class="fw-bold fs-2qx text-gray-800"
														data-field="backDate"> - </span> <span
														class="fs-8 text-gray-600">Backdate</span>
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="col">
									<div class="card mt-4">
										<div class="card-body">
											<div
												class="d-flex flex-column align-items-center justify-content-center gap-4">
												<div>
													<i class="ki-duotone ki-calendar-remove fs-4x text-danger">
														<span class="path1"></span> <span class="path2"></span> <span
														class="path3"></span> <span class="path4"></span> <span
														class="path5"></span> <span class="path6"></span>
													</i>
												</div>
												<div
													class="d-flex flex-column align-items-center justify-content-center gap-3">
													<span class="fw-bold fs-2qx text-gray-800"
														data-field="noRecord"> - </span> <span
														class="fs-8 text-gray-600 text-nowrap">No Record</span>
												</div>
											</div>
										</div>
									</div>
								</div>

							</div>

						</div>

					</div>
				</div>

				<div
					class="d-flex align-items-center justify-content-between mt-6 py-3">
					<h3 class="fw-medium text-gray-900">Transaction History</h3>
					<div>
						<button
							class="d-flex align-items-center justify-content-center gap-3 btn btn-light-success"
							type="button" onClick="openRewardTokenModal()">
							<i class="ki-duotone ki-crown-2 fs-1"> <span class="path1"></span>
								<span class="path2"></span> <span class="path3"></span>
							</i> <span> Reward Token </span>
						</button>
					</div>
				</div>

				<div id="token-transaction-container">
					<!-- Transaction history will be loaded here via AJAX -->
				</div>

				<div class="modal fade" tabindex="-1" id="returnTokenModal"
					aria-hidden="true">
					<input type="hidden" id="returnTokenUserId" value="" /> <input
						type="hidden" id="transactionId" value="" />
					<div class="modal-dialog modal-lg modal-dialog-centered ">
						<div class="modal-content">

							<!--begin::Modal Header-->
							<div class="modal-header border-0 pb-3">
								<h2 class="modal-title fw-bold text-gray-900">Return Cube
									Token</h2>

								<!--begin::Close-->
								<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
									data-bs-dismiss="modal" aria-label="Close">
									<i class="ki-duotone ki-cross fs-1"> <span class="path1"></span>
										<span class="path2"></span>
									</i>
								</div>
								<!--end::Close-->
							</div>
							<!--end::Modal Header-->


							<!--begin::Modal Body-->
							<div class="modal-body pt-10 px-8">

								<!--begin::User-->
								<div class="d-flex align-items-center mb-8">
									<div class="me-4">
										<i class="ki-duotone ki-user-square fs-2"> <span
											class="path1"></span> <span class="path2"></span> <span
											class="path3"></span>
										</i>
									</div>

									<span class="fw-bold text-gray-800 fs-5" id="employeeInfo">
										- </span>
								</div>
								<!--end::User-->

								<!--begin::Activity Type-->
								<div class="d-flex align-items-center mb-8">
									<i id="activityTypeIcon"> <span class="path1"></span> <span
										class="path2"></span> <span class="path3"></span> <span
										class="path4"></span> <span class="path5"></span><span
										class="path6"></span>
									</i>

									<div class="text-gray-800 fs-6" id="returnTokenAction">-
									</div>
								</div>
								<!--end::Activity Type-->


								<!--begin::Information-->
								<div class="row g-8">
									<!--begin::Left Column-->
									<div class="col-md-6">
										<!--begin::Date-->
										<div class="d-flex align-items-center mb-8">
											<i class="ki-duotone ki-calendar fs-3 text-gray-400 me-4">
												<span class="path1"></span> <span class="path2"></span>
											</i>

											<div class="fw-medium text-gray-800 fs-6">
												Date: <span id="returnTokenDate"> - </span>
											</div>
										</div>
										<!--end::Date-->


										<!--begin::Description-->
										<div class="d-flex flex-wrap align-items-center">
											<i class="ki-duotone ki-notepad fs-2 text-gray-400 me-4 mt-1">
												<span class="path1"></span> <span class="path2"></span> <span
												class="path3"></span> <span class="path4"></span>
											</i>

											<div class="fw-medium text-gray-800 fs-6 lh-lg">
												Description: <span id="actionType"></span>
												<span id="returnTokenDescription"></span>
											</div>

											<div class="ms-2">
												<span class="badge p-2 badge-light-primary d-none"
													id="referenceBadge"></span>
											</div>
											
											<div class="d-flex align-items-center ms-2 fs-6 fw-normal text-gray-700" id="eventDate">
												
											</div>

										</div>
										<!--end::Description-->

									</div>
									<!--end::Left Column-->


									<!--begin::Right Column-->
									<div class="col-md-6">

										<!--begin::Return-->
										<div class="d-flex align-items-center mb-8">
											<i class="ki-duotone ki-arrows-circle fs-2 text-success me-4">
												<span class="path1"></span> <span class="path2"></span>
											</i>

											<div class="text-gray-800 fw-medium fs-6">
												Return: <span id="returnTokenValue">0</span> Token
											</div>
										</div>
										<!--end::Return-->


										<!--begin::Balance-->
										<div class="d-flex align-items-center">
											<i class="ki-duotone ki-cube-2 fs-2 text-primary me-4"> <span
												class="path1"></span> <span class="path2"></span> <span
												class="path3"></span>
											</i>

											<div class="text-gray-800 fw-medium fs-6">
												Balance: <span id="returnTokenBalance">0</span> Token
											</div>
										</div>
										<!--end::Balance-->

									</div>
									<!--end::Right Column-->

								</div>
								<!--end::Information-->


								<!--begin::Divider-->
								<div class="separator separator-dashed my-16"></div>
								<!--end::Divider-->


								<!--begin::Reason-->
								<div class="mb-2">
									<label class="form-label fw-semibold text-gray-800">
										Reason <span class="text-danger">*</span>
									</label>

									<textarea id="returnTokenReason" class="form-control" rows="3"
										placeholder="Please provide a reason..."></textarea>
								</div>
								<!--end::Reason-->

							</div>
							<!--end::Modal Body-->


							<!--begin::Modal Footer-->
							<div class="modal-footer border-0 pt-4 px-8 pb-7">

								<button type="button" class="btn btn-light me-3"
									data-bs-dismiss="modal">Cancel</button>

								<button type="button" class="btn btn-success"
									id="btnConfirmReturnToken">Confirm</button>

							</div>
							<!--end::Modal Footer-->

						</div>
					</div>
				</div>

				<!--begin::Reward Cube Token Modal-->
				<div class="modal fade" tabindex="-1" id="rewardTokenModal"
					aria-hidden="true">

					<div class="modal-dialog modal-lg modal-dialog-centered">
						<div class="modal-content">

							<!--begin::Modal Header-->
							<div class="modal-header border-0 pb-3">
								<h2 class="modal-title fw-bold text-gray-900">Reward Cube
									Token</h2>

								<!--begin::Close-->
								<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
									data-bs-dismiss="modal" aria-label="Close">

									<i class="ki-duotone ki-cross fs-1"> <span class="path1"></span>
										<span class="path2"></span>
									</i>

								</div>
								<!--end::Close-->
							</div>
							<!--end::Modal Header-->


							<!--begin::Modal Body-->
							<div class="modal-body pt-7 px-8">

								<!--begin::User-->
								<div
									class="d-flex align-items-center pb-5 border-bottom border-bottom-dashed border-gray-300">

									<div class="me-3">
										<i class="ki-duotone ki-user-square fs-2 text-gray-400"> <span
											class="path1"></span> <span class="path2"></span> <span
											class="path3"></span>
										</i>
									</div>

									<span class="fw-medium text-gray-900 fs-5"
										id="rewardTokenUserName"> - </span>

								</div>
								<!--end::User-->


								<!--begin::Reward Section-->
								<div class="pt-5">

									<!--begin::Label-->
									<div class="d-flex align-items-center mb-2">

										<span class="fw-bold text-gray-800 fs-6"> Reward Cube
											Token </span> <i class="ki-duotone ki-crown-2 fs-3 ms-2"> <span
											class="path1"></span> <span class="path2"></span> <span
											class="path3"></span> <span class="path4"></span> <span
											class="path5"></span> <span class="path6"></span>
										</i>

									</div>
									<!--end::Label-->


									<!--begin::Current Balance-->
									<div class="text-gray-700 fw-normal fs-5 mb-4">

										Current Balance: <span class="fw-normal text-gray-800">
											<span id="rewardCurrentBalance">39</span> Cube Token
										</span>

									</div>
									<!--end::Current Balance-->


									<!--begin::Token Input-->
									<div class="input-group">

										<input type="number" class="form-control form-control-lg"
											id="rewardTokenAmount" min="1" value="1"
											placeholder="Enter token amount" /> <span
											class="input-group-text px-7"> Token </span>

									</div>
									<!--end::Token Input-->

								</div>
								<!--end::Reward Section-->


								<!--begin::Divider-->
								<div class="separator separator-dashed my-6"></div>
								<!--end::Divider-->


								<!--begin::Reason-->
								<div class="mb-5">

									<label class="form-label fw-medium text-gray-800">

										Reason <span class="text-danger">*</span>

									</label>

									<textarea id="rewardTokenReason" class="form-control" rows="3"
										placeholder="Please provide a reason..."></textarea>

								</div>
								<!--end::Reason-->


								<!--begin::Receive Preview-->
								<div
									class="d-inline-flex align-items-center px-3 py-3 border border-dashed border-gray-300 rounded">

									<span class="text-success fw-semibold fs-6"> Receive: </span> <span
										class="fw-normal text-gray-600 fs-7 ms-1"
										id="rewardReceiveAmount"> 2 Cube Token </span>

								</div>
								<!--end::Receive Preview-->

							</div>
							<!--end::Modal Body-->


							<!--begin::Modal Footer-->
							<div class="modal-footer border-0 pt-4 px-8 pb-7">

								<button type="button" class="btn btn-light me-3"
									data-bs-dismiss="modal">Cancel</button>

								<button type="button" class="btn btn-success"
									id="btnConfirmRewardToken">Confirm</button>

							</div>
							<!--end::Modal Footer-->

						</div>
					</div>

				</div>
				<!--end::Reward Cube Token Modal-->



			</div>
		</div>
	</div>
	<script>
	
		const iconMap = {
				'gift': 'ki-award text-success',
				'reward': 'ki-crown-2 text-success',
				'return': 'ki-arrows-circle text-success',
				'exchange': 'ki-arrow-right-left text-success',
				'late': 'ki-time fs-1 text-danger',
				'early out': 'ki-brifecase-timer text-danger',
				'leave': 'ki-calendar-8 text-danger',
				'backdate': 'ki-calendar-edit text-danger',
				'no record': 'ki-calendar-remove fs-1 text-danger', 
				'void': 'ki-file-up fs-1 text-danger'
		}
		
		const transactionRecords = {}
		let userCurrentMonthlyBalance = 0;
	
		function loadTokenSummary(userId, year) {
	
		    $.ajax({
		        url: `tokenSummary?year=\${year}\${userId ? '&userId=' + userId : ''}`,
		        type: "GET",
	
		        beforeSend: function() {
		            $(".token-value").text("-");
		        },
	
		        success: function(res) {
	
		            if (!res.success) {
		                toastr.error(
		                    res.message || "Unable to load token summary."
		                );
		                return;
		            }
		            
		            const data = res.data;
	
		            $("[data-field='cubeToken']").text(
			                formatToken(data.accumulatedToken)
		            );
			            
		            $("[data-field='yearlyCubeToken']").text(
			                formatToken(data.yearlyToken)
			        );
	
		            $("[data-field='gift']").text(
		                formatToken(data.gift)
		            );
	
		            $("[data-field='reward']").text(
		                formatToken(data.reward)
		            );
	
		            $("[data-field='return']").text(
		                formatToken(data.return)
		            );
	
		            $("[data-field='exchange']").text(
		                formatToken(data.exchange)
		            );
	
		            $("[data-field='late']").text(
		                formatToken(data.late)
		            );
	
		            $("[data-field='earlyOut']").text(
		                formatToken(data.earlyOut)
		            );
	
		            $("[data-field='leave']").text(
		                formatToken(data.leave)
		            );
	
		            $("[data-field='backDate']").text(
		                formatToken(data.backDate)
		            );
		            
		            $("[data-field='noRecord']").text(
			                formatToken(data.noRecord)
			        );
		        },
	
		        error: function(xhr) {
	
		            console.error("Get Token Summary error");
	
		            $(".token-value").text("-");
	
		            toastr.error("Unable to load token summary. Please try again.");
		        }
		    });
		}
		
		function validateReason(reasonSelector, buttonSelector) {

		    const reason = $(reasonSelector).val().trim();

		    $(buttonSelector).prop(
		        "disabled",
		        reason.length === 0
		    );
		}
		
		function openReturnTokenModal(transactionId) {

		    const transaction = transactionRecords[String(transactionId)];

		    if (!transaction) {
		        console.error("Transaction not found:", transactionId);
		        toastr.error("Transaction not found.");
		        return;
		    }
		    
		    let description = transaction.description || null;
		    
		    try {
		    	description = JSON.parse(description);
		    } catch (error) {
		    	description = transaction.description;
            }
		    
		    const actionName = transaction.actionName.toLowerCase().replace(/\s+/g, '');
		    
		    if (actionName === "reward") {
		    	$("#actionType").text("ได้รับ").attr("class", "fw-semibold text-success");
		    } else {
		    	$("#actionType").text("หัก").attr("class", "fw-semibold text-danger");
		    }
		    
		    $("#employeeInfo").text("${userInfo.employee_id} - ${userInfo.name_en}");

		    $("#transactionId").val(transaction.id);
		    
		    $("#returnTokenUserId").val(transaction.userId);
		    
		    $("#activityTypeIcon").attr("class", `ki-duotone fs-2 me-4 \${ iconMap[transaction.actionName.toLowerCase()] }`);

		    $("#returnTokenAction").text(transaction.actionName);

		    $("#returnTokenDate").text(transaction.date);

		    $("#returnTokenDescription").text(description?.reason || "-");
		    

		    const referenceBadge = $("#referenceBadge");

		    referenceBadge.addClass("d-none").text("");

		    if (description?.referenceId) {
		        referenceBadge.text(`#\${description.referenceId}`).removeClass("d-none");
		    }
		    
		    const eventDate = $("#eventDate");
		    
		    eventDate.addClass("d-none").text("");

		    if (description?.date) {
		        eventDate
		            .text(`\${description.date}`)
		            .removeClass("d-none");
		    }

		    $("#returnTokenValue").text(`\${transaction.value}`);
		    
		    $("#returnTokenBalance").text(userCurrentMonthlyBalance);

		    $("#returnTokenReason").val("");
		    
		    validateReason("#returnTokenReason", "#btnConfirmReturnToken");

		    const modalElement = document.getElementById("returnTokenModal");
		    const modal = bootstrap.Modal.getOrCreateInstance(modalElement);

		    modal.show();
		}
		
		function openRewardTokenModal() {

		    $("#rewardTokenUserName").text("${userInfo.employee_id} - ${userInfo.name_en}");
		    $("#rewardCurrentBalance").text(userCurrentMonthlyBalance);

		    $("#rewardTokenAmount").val(1);
		    $("#rewardTokenReason").val("");

		    updateRewardReceiveAmount();
		    
		    validateReason("#rewardTokenReason", "#btnConfirmRewardToken");

		    const modalElement = document.getElementById("rewardTokenModal");
		    const modal = bootstrap.Modal.getOrCreateInstance(modalElement);

		    modal.show();
		}
		
		function updateRewardReceiveAmount() {

		    const amount = Number($("#rewardTokenAmount").val()) || 0;

		    $("#rewardReceiveAmount").text(
		        `\${amount} Cube Token`
		    );
		}
		
		function loadAvailableYears(userId) {

		    $.ajax({
		        url: `getTokenAvailableYears\${userId ? '?userId=' + userId : ''}`,
		        type: "GET",
		        dataType: "json",

		        success: function(response) {

		            const menu = $("#token-year-menu");
		            const date = new Date();
		            const currentYear = date.getFullYear();

		            menu.empty();

		            if (!response.success || !response.data?.length) {
						console.warn("No available years found.");
		                menu.append(`
		                    <div class="text-muted px-4 py-2">
		                        No years available
		                    </div>
		                `);
		                return;
		            }

		            response.data.forEach(function(year) {

		                menu.append(`
		                    <button
		                        type="button"
		                        class="dropdown-item year-option \${year === currentYear ? 'active' : ''}"
		                        data-year="\${year}">
		                        \${year}
		                    </button>
		                `);
		            });
		        },
		        error: function(xhr, status, error) {

					console.error("Error loading available years:", error);

					
				}
		    });
		}
		
		function loadTransaction(userId, year) {

			const container = $("#token-transaction-container");

			// Show loading spinner
			container.html(`
				<div class="d-flex flex-column align-items-center justify-content-center py-20 h-300px">
					<div class="spinner-border text-primary" role="status">
						<span class="visually-hidden">Loading...</span>
					</div>
					<span class="text-gray-600 mt-4">
						Loading...
					</span>
				</div>
			`);
			
			$.ajax({
				url: `tokenTransaction?year=\${year}\${userId ? '&userId=' + userId : ''}`,
				type: 'GET',
				dataType: 'json',

				success: function(response) {

					if (!response.success || !response.data || response.data.length === 0) {

						container.empty();

						container.html(`
							<div class="text-center text-muted py-10">
								No transaction found
							</div>
						`);

						return;
					}
					
					container.empty();
					
					const monthNumberMap = {
						    January: 1,
						    February: 2,
						    March: 3,
						    April: 4,
						    May: 5,
						    June: 6,
						    July: 7,
						    August: 8,
						    September: 9,
						    October: 10,
						    November: 11,
						    December: 12
						};
					
					const currentMonth = new Date().getMonth() + 1;
					const data = response.data;
					
					userCurrentMonthlyBalance = Number(response.currentBalance) || 0;
					
					data.forEach(function(month, index) {

						const collapseId = "token_month_" + index;
						const tableId = "token_table_" + index;
						
						const monthNumber = monthNumberMap[month.month];
					    const isCurrentMonth = currentMonth === monthNumber;

						const summary = month.summary || {};
						const transactions = month.transactions || [];
						
						const card = `
							<div class="card card-flush mt-6">

								<!-- ================= HEADER ================= -->
								<div
									class="card-header collapsible cursor-pointer"
									data-bs-toggle="collapse"
									data-bs-target="#\${collapseId}">
									
									<div class="card-title">

										<div class="d-flex align-items-center gap-3">

											<span class="badge badge-circle badge-light-primary">
												\${monthNumber}
											</span>

											<h3 class="fw-semibold text-gray-900 mb-0">
												\${month.month}
											</h3>

										</div>

									</div>
									
									<div class="card-toolbar">
										<div class="d-flex align-items-center gap-2 gap-md-4">
											<div class="d-flex align-items-center justify-content-center gap-2 gap-md-3">
												<!-- Cube Token Icon -->
												<i class="ki-duotone ki-triangle fs-1 text-primary"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span>
												</i>
			
												<!-- Label -->
												<span class="text-gray-800 fs-6"> Cube Token </span>
			
												<!-- Balance -->
												<span class="fw-semibold text-gray-700 fs-3"> \${month.summary.balance} </span>
											</div>
											
											<!-- Metronic Vertical Separator -->
											<div class="d-flex ailgn-items-center justify-content-center">
												<div class="vr mx-2 text-ligth-primary"></div>
											</div>
											
											<div class="d-flex align-items-center justify-content-center gap-2 gap-md-3">
												
												<!-- Label -->
												<span class="text-gray-800 fs-6"> เข้ายอดสะสม </span>
			
												<!-- Balance -->
												<span class="fw-semibold text-gray-700 fs-3"> \${Math.max(month.summary.balance, 0)} </span>
											</div>
											
											<!-- Collapse Button -->
											<div class="bg-light-primary btn btn-sm btn-icon ms-3">
												<i class="ki-duotone ki-down fs-3 text-primary token-collapse-icon \${isCurrentMonth ? 'rotate-180' : ''}">
													<span class="path1"></span> <span class="path2"></span>
												</i>
											</div>
										</div>
									</div>
								</div>


								<!-- ================= BODY ================= -->
								<div id="\${collapseId}" class="collapse token-month-collapse \${isCurrentMonth ? 'show' : ''}">

									<div class="card-body">

										<!-- ================= SUMMARY ================= -->
										\${renderTokenSummary(summary)}


										<!-- ================= TABLE ================= -->
										<div class="table-responsive mt-6">

											<table
												id="\${tableId}"
												class="table table-striped table-row-bordered gy-5">

												<thead>
													<tr class="fw-semibold fs-7 text-gray-500 text-uppercase">

														<th class="ps-4" style="min-width: 150px">Activity</th>
														<th style="min-width: 150px">Date</th>
														<th style="min-width: 170px">Description</th>
														<th class="text-end" style="min-width: 150px">Get Token</th>
														<th class="text-end" style="min-width: 150px">Deduct Token</th>
														<th class="text-end" style="min-width: 120px">Balance</th>
														<th class="text-end pe-4" style="min-width: 120px"></th>

													</tr>
												</thead>

												<tbody>

													\${transactions.map(function(tx) {

														transactionRecords[tx.id] = tx; 
														
														const isAdd =
															tx.transactionType === "ADD";

														const getToken = isAdd
															? formatToken(tx.value)
															: "-";

														const deductToken = !isAdd
															? formatToken(tx.value)
															: "-";
															
														return `
															<tr>
																<td>
																	<div class="d-flex align-items-center gap-3 ps-3">
																		<i class="ki-duotone fs-1 \${iconMap[tx.actionName.toLowerCase()] || 'ki-question-circle fs-3 text-gray-500'}">
																			 <span class="path1"></span>
																			 <span class="path2"></span>
																			 <span class="path3"></span>
																			 <span class="path4"></span>
																			 <span class="path5"></span>
																			 <span class="path6"></span>
																		</i>
																		<span class="fw-semibold fs-6 text-gray-800">
																			\${escapeHtml(tx.actionName || "-")}
																		</span>
																	</div>
																</td>

																<td class="text-gray-800 fs-6">
																	\${escapeHtml(tx.date || "-")}
																</td>

																<td class="text-gray-700 fs-6">
																	\${renderDescription(tx.description || "-")}
																</td>

																<td class="fs-6 \${getToken === '-' ? 'text-muted' : 'text-gray-800'} fw-normal text-end pe-0">
																	\${getToken}
																</td>

																<td class="fs-6 \${deductToken === '-' ? 'text-muted' : 'text-gray-800'} fw-normal text-end pe-0">
																	\${deductToken}
																</td>

																<td class="fs-6 text-gray-800 text-end pe-0">
																	\${formatToken(tx.balance)}
																</td>
																
																<td class="text-end pe-4">
																    \${!tx.returned && (
																    	    !isAdd || tx.actionName.toLowerCase() === 'reward'
																    )
																        ? `
																            <button
																                type="button"
																                class="btn btn-sm btn-icon btn-light-\${tx.actionName.toLowerCase() === 'reward' ? 'danger' : 'primary'}"
																                onClick="openReturnTokenModal('\${escapeHtml(tx.id)}')"
																                data-bs-toggle="modal"
																                data-bs-target="#returnTokenModal"
																            >
																                <i class="ki-duotone \${tx.actionName.toLowerCase() === 'reward' ? 'ki-crown-2' : 'ki-arrows-circle'} fs-1">
																                    <span class="path1"></span>
																                    <span class="path2"></span>
																                    <span class="path3"></span>
																                    <span class="path4"></span>
																                    <span class="path5"></span>
																                    <span class="path6"></span>
																                </i>
																            </button>
																        `
																        : ''
																    }
																</td>

															</tr>
														`;

													}).join("")
													
													}

												</tbody>

											</table>

										</div>

									</div>

								</div>

							</div>
						`;

						container.append(card);
						
						$(`#\${tableId}`).DataTable({
							scrollY: "500px",
							scrollCollapse: true,
							paging: false,
							searching: false,
							info: false,
							ordering: false,
							dom: "<'table-responsive'tr>"
						});
						
					});
					
				},

				error: function(xhr, status, error) {

					console.error("Error loading token transactions:", error);

					container.html(`
						<div class="text-center py-10">
							<i class="ki-duotone ki-information-5 fs-3x text-danger mb-4">
								<span class="path1"></span>
								<span class="path2"></span>
								<span class="path3"></span>
							</i>

							<div class="text-danger fw-semibold">
								Failed to load transactions.
							</div>
						</div>
					`);
				}
			});
		}
		
		function renderDescription(description) {

			if (!description || description.trim() === "") return "-";
			
			let data = description;
			
			try {
                data = JSON.parse(description);
            } catch (e) {
                return escapeHtml(description);
            }
			
            const type = data.type || "";
            const action = data.action || "";
			const reason = data.reason || "-";
			const referenceId = data.referenceId || null;
			const eventDate = data.date || null;
			
			switch (type) {
                case "add":
                    return `<div class="d-flex flex-column gap-2">
                    			<div class="fw-normal text-gray-700 fs-6">
                    				<span class="\${action === 'return' ? 'text-info' : 'text-success'}">\${action === 'return' ? 'คืนแต้ม' : 'ได้รับ'}</span> \${reason}
                    			</div>
                    			\${eventDate ? `<div><span class="fw-normal fs-6 text-gray-700">\${eventDate}</span></div>` : ''}
                    			\${referenceId ? `<div><span class="badge badge-lg badge-light badge-light-primary p-2">#\${referenceId}</span></div>` : ''}
                    		</div>
                    	`;	
                    
                case "deduct":
                    return `<div class="d-flex flex-column gap-2">
			        			<div class="fw-normal text-gray-700 fs-6">
				    				<span class="text-danger">หัก</span> \${reason}
				    			</div>
				    			\${referenceId ? `<div><span class="badge badge-lg badge-light-primary p-2">#\${referenceId}</span></div>` : ''}
				    			\${eventDate ? `<div><span class="fw-normal fs-6 text-gray-700">\${eventDate}</span></div>` : ''}
				    		</div>
				    	`;	
				    	
                case "void":
                    return `<div class="d-flex flex-column gap-2">
			        			<div>
				    				<span class="text-info">ยกเลิก</span> การแจกแต้ม \${reason}
				    			</div>
				    			\${referenceId ? `<div><span class="badge badge-lg badge-light-primary p-2">#\${referenceId}</span></div>` : ''}
				    		</div>
				    	`;
                    
                default:
                    return "-";
            }
		}
		
		function renderTokenSummary(summary) {

			return `
				<div class="token-transaction-container">

					<div class="row g-4">

						<!-- ================= GET TOKEN ================= -->
						<div class="col-12 col-xxl-6">

							<div
								class="token-summary-box token-summary-add
								p-4 p-md-6
								border border-dashed border-success rounded">

								<div class="row row-cols-2 row-cols-md-4 g-2 g-md-3">
									<!-- Gift -->
									<div class="col">
										<div class="token-summary-item
											d-flex align-items-center
											justify-content-center gap-2 ps-4 ps-md-0">

											<i class="ki-duotone ki-award fs-5 fs-md-1 text-success">
												<span class="path1"></span>
												<span class="path2"></span>
												<span class="path3"></span>
											</i>

											<span class="text-gray-800 fs-6 fw-normal">
												Gift
											</span>

											<span class="fw-bold text-gray-700 fs-3">
												\${formatToken(summary.gift)}
											</span>

										</div>
									</div>


									<!-- Reward -->
									<div class="col">

										<div class="token-summary-item
											token-summary-separator-success
											d-flex align-items-center
											justify-content-center gap-2">

											<i class="ki-duotone ki-crown-2 fs-5 fs-md-1 text-success">
												<span class="path1"></span>
												<span class="path2"></span>
											</i>

											<span class="text-gray-800 fs-6 fw-normal">
												Reward
											</span>

											<span class="fw-bold text-gray-700 fs-3">
												\${formatToken(summary.reward)}
											</span>

										</div>

									</div>


									<!-- Return -->
									<div class="col">

										<div class="token-summary-item
											token-summary-separator-success
											d-flex align-items-center
											justify-content-center gap-2 ps-4 ps-md-0">

											<i class="ki-duotone ki-arrows-circle fs-5 fs-md-1 text-success">
												<span class="path1"></span>
												<span class="path2"></span>
											</i>

											<span class="text-gray-800 fs-6 fw-normal">
												Return
											</span>

											<span class="fw-bold text-gray-700 fs-3">
												\${formatToken(summary.return)}
											</span>

										</div>

									</div>


									<!-- Exchange -->
									<div class="col">

										<div class="token-summary-item
											token-summary-separator-success
											d-flex align-items-center
											justify-content-center gap-2">

											<i class="ki-duotone ki-arrow-right-left fs-5 fs-md-1 text-success">
												<span class="path1"></span>
												<span class="path2"></span>
											</i>

											<span class="text-gray-800 fs-6 fw-normal">
												Exchange
											</span>

											<span class="fw-bold text-gray-700 fs-3">
												\${formatToken(summary.exchange)}
											</span>

										</div>

									</div>

								</div>

							</div>

						</div>


						<!-- ================= DEDUCT TOKEN ================= -->
						<div class="col-12 col-xxl-6">

							<div
								class="token-summary-box token-summary-deduct
								p-4 p-md-6
								border border-dashed border-danger rounded">

								<div class="row row-cols-2 row-cols-md-5 g-2 g-md-3">

									<!-- Late -->
									<div class="col">

										<div class="token-summary-item
											d-flex align-items-center
											justify-content-center gap-2 ps-4 ps-md-0">

											<i class="ki-duotone ki-time fs-5 fs-md-1 text-danger">
												<span class="path1"></span>
												<span class="path2"></span>
											</i>

											<span class="text-gray-800 fs-6 fw-normal">
												Late
											</span>

											<span class="fw-bold text-gray-700 fs-3">
												\${formatToken(summary.late)}
											</span>

										</div>

									</div>


									<!-- Early Out -->
									<div class="col">

										<div class="token-summary-item
											token-summary-separator-danger
											d-flex align-items-center
											justify-content-center gap-2">

											<i class="ki-duotone ki-brifecase-timer fs-5 fs-md-1 text-danger">
											 <span class="path1"></span>
											 <span class="path2"></span>
											 <span class="path3"></span>
											</i>

											<span class="text-gray-800 fs-6 fw-normal">
												Early Out
											</span>

											<span class="fw-bold text-gray-700 fs-3">
												\${formatToken(summary.earlyout)}
											</span>

										</div>

									</div>


									<!-- Leave -->
									<div class="col">

										<div class="token-summary-item
											token-summary-separator-danger
											d-flex align-items-center
											justify-content-center gap-2 ps-4 ps-md-0">

											<i class="ki-duotone ki-calendar-8 fs-5 fs-md-1 text-danger">
												<span class="path1"></span>
												<span class="path2"></span>
												<span class="path3"></span>
												<span class="path4"></span>
												<span class="path5"></span>
												<span class="path6"></span>
											</i>

											<span class="text-gray-800 fs-6 fw-normal">
												Leave
											</span>

											<span class="fw-bold text-gray-700 fs-3">
												\${formatToken(summary.leave)}
											</span>

										</div>

									</div>


									<!-- Backdate -->
									<div class="col">

										<div class="token-summary-item
											token-summary-separator-danger
											d-flex align-items-center
											justify-content-center gap-2 ">

											<i class="ki-duotone ki-calendar-edit fs-5 fs-md-1 text-danger">
												<span class="path1"></span>
												<span class="path2"></span>
												<span class="path3"></span>
												<span class="path4"></span>
												<span class="path5"></span>
												<span class="path6"></span>
											</i>

											<span class="text-gray-800 fs-6 fw-normal">
												Backdate
											</span>

											<span class="fw-bold text-gray-700 fs-3">
												\${formatToken(summary.backdate)}
											</span>

										</div>

									</div>
									
									<!-- No Record -->
									<div class="col">

										<div class="token-summary-item
											token-summary-separator-danger
											d-flex align-items-center
											justify-content-center gap-2 ps-4 ps-md-0">

											<i class="ki-duotone ki-calendar-remove fs-5 fs-md-1 text-danger">
												<span class="path1"></span>
												<span class="path2"></span>
												<span class="path3"></span>
												<span class="path4"></span>
												<span class="path5"></span>
												<span class="path6"></span>
											</i>

											<span class="text-gray-800 fs-6 fw-normal">
												No Record
											</span>

											<span class="fw-bold text-gray-700 fs-3">
												\${formatToken(summary.norecord)}
											</span>

										</div>

									</div>

								</div>

							</div>

						</div>

					</div>

				</div>
			`;
		}
		
		function formatToken(value) {

			if (value === null || value === undefined) {
				return "0";
			}

			const number = Number(value);

			if (Number.isNaN(number)) {
				return "0";
			}

			return Number.isInteger(number)
				? number.toString()
				: number.toFixed(2);
		}


		function escapeHtml(value) {

			if (value === null || value === undefined) {
				return "";
			}

			return String(value)
				.replace(/&/g, "&amp;")
				.replace(/</g, "&lt;")
				.replace(/>/g, "&gt;")
				.replace(/"/g, "&quot;")
				.replace(/'/g, "&#039;");
		}

	$(document).ready(function() {

		const queryString = window.location.search;
		const urlParams = new URLSearchParams(queryString);
		
		const userId = urlParams.get("userId");
	  	let year = urlParams.get("year");

	    if (!year || isNaN(year)) {
	        year = new Date().getFullYear();
	    }

	   /*  const currentYear = parseInt(year, 10); */
		
		
		$(".year-select").append(
            `<span class="fw-semibold" id="year-filter">\${year}</span>`
        );
		
		$(document).on("click", ".year-option", function () {

			const selectedYear = $(this).data("year");

		    if (selectedYear === year) {
                return;
            }
		    
		    year = selectedYear;

		    $(".year-option").removeClass("active");

		    $(this).addClass("active");
		    
		    $('#year-filter').text(year);

		    $("#yearlyCubeToken-year").text(year);
		    
		    loadTokenSummary(userId, year);
		    loadTransaction(userId, year);
		});

		loadAvailableYears(userId);
	    loadTokenSummary(userId, year);
	    loadTransaction(userId, year);
	    
	    $(document).on("show.bs.collapse", ".token-month-collapse", function () {
	        const collapseId = this.id;

	        $(`[data-bs-target="#\${collapseId}"]`)
	            .find(".token-collapse-icon")
	            .addClass("rotate-180");
	    });

	    $(document).on("hide.bs.collapse", ".token-month-collapse", function () {
	        const collapseId = this.id;

	        $(`[data-bs-target="#\${collapseId}"]`)
	            .find(".token-collapse-icon")
	            .removeClass("rotate-180");
	    });
	    
	    $(document).on("input", "#rewardTokenAmount", function () {

	/*         let amount = Number($(this).val()) || 0;

	        if (amount < 1) {
	            amount = 1;
	            $(this).val(amount);
	        } */

	        updateRewardReceiveAmount();
	    });
	    
	    $(document).on("input", "#returnTokenReason", function () {
	        validateReason("#returnTokenReason", "#btnConfirmReturnToken");
	    });
	    
	    $(document).on("input", "#rewardTokenReason", function () {
	    	validateReason("#rewardTokenReason", "#btnConfirmRewardToken");
	    });
	    
	    $(document).on("click", "#btnConfirmRewardToken", function () {

	        const value = Number($("#rewardTokenAmount").val());
	        const reason = $("#rewardTokenReason").val().trim();

	        const requestData = {
	            userId: userId || null,
	            value: value,
	            reason: reason
	        };

	        const button = $(this);

	        Swal.fire({
	            title: "Reward Cube Token?",
	            text: `Are you sure you want to reward ${value} Cube Token(s) to this user?`,
	            icon: "question",
	            showCancelButton: true,
	            confirmButtonText: "Confirm",
	            cancelButtonText: "Cancel",
	            reverseButtons: true,
	            customClass: {
	                confirmButton: "btn btn-success",
	                cancelButton: "btn btn-light"
	            },
	            buttonsStyling: false
	        }).then((result) => {

	            if (!result.isConfirmed) {
	                return;
	            }

	            // Disable button ป้องกันกดซ้ำ
	            button.prop("disabled", true);

	            // Loading
	            Swal.fire({
	                title: "Processing...",
	                text: "Please wait while the token is being rewarded.",
	                allowOutsideClick: false,
	                allowEscapeKey: false,
	                showConfirmButton: false,
	                didOpen: () => {
	                    Swal.showLoading();
	                }
	            });

	            $.ajax({
	                url: "rewardCubeToken",
	                type: "POST",
	                dataType: "json",
	                data: requestData,

	                success: function (response) {

	                    if (response.success) {

	                        Swal.fire({
	                            title: "Success!",
	                            text: response.message || "Token rewarded successfully.",
	                            icon: "success",
	                            confirmButtonText: "OK",
	                            customClass: {
	                                confirmButton: "btn btn-success"
	                            },
	                            buttonsStyling: false
	                        }).then(() => {

	                            // ปิด Modal
	                            const modalElement =
	                                document.getElementById("rewardTokenModal");

	                            const modal =
	                                bootstrap.Modal.getOrCreateInstance(modalElement);

	                            modal.hide();

	                            // Reset form
	                            $("#rewardTokenAmount").val(1);
	                            $("#rewardTokenReason").val("");

	                            updateRewardReceiveAmount();

	                            // Reload data
	                            loadTokenSummary(userId, year);
	                            loadTransaction(userId, year);
	                        });

	                    } else {

	                        Swal.fire({
	                            title: "Failed!",
	                            text: response.message || "Failed to reward token.",
	                            icon: "error",
	                            confirmButtonText: "OK",
	                            customClass: {
	                                confirmButton: "btn btn-danger"
	                            },
	                            buttonsStyling: false
	                        });

	                        button.prop("disabled", false);
	                    }
	                },

	                error: function (xhr) {

	                    let message = "Failed to reward token.";

	                    if (xhr.responseJSON && xhr.responseJSON.message) {
	                        message = xhr.responseJSON.message;
	                    }

	                    Swal.fire({
	                        title: "Error!",
	                        text: message,
	                        icon: "error",
	                        confirmButtonText: "OK",
	                        customClass: {
	                            confirmButton: "btn btn-danger"
	                        },
	                        buttonsStyling: false
	                    });

	                    button.prop("disabled", false);
	                }
	            });
	        });
	    });
	    
	    $(document).on("click", "#btnConfirmReturnToken", function () {

	        const button = $(this);
	        const transactionId = $("#transactionId").val();
	        const reason = $("#returnTokenReason").val().trim();

	        // userId stored when opening the modal
	        const userId = $("#returnTokenUserId").val();

	        // ==============================
	        // Validate
	        // ==============================

	        if (!transactionId) {
	            Swal.fire({
	                icon: "warning",
	                title: "Invalid Transaction",
	                text: "Transaction ID is required.",
	                confirmButtonText: "OK",
	                customClass: {
	                    confirmButton: "btn btn-warning"
	                },
	                buttonsStyling: false
	            });
	            return;
	        }

	        if (!userId) {
	            Swal.fire({
	                icon: "warning",
	                title: "Invalid User",
	                text: "User ID is required.",
	                confirmButtonText: "OK",
	                customClass: {
	                    confirmButton: "btn btn-warning"
	                },
	                buttonsStyling: false
	            });
	            return;
	        }

	        if (!reason) {
	            Swal.fire({
	                icon: "warning",
	                title: "Reason Required",
	                text: "Please provide a reason for returning the token.",
	                confirmButtonText: "OK",
	                customClass: {
	                    confirmButton: "btn btn-warning"
	                },
	                buttonsStyling: false
	            });

	            $("#returnTokenReason").focus();
	            return;
	        }

	        // ==============================
	        // Confirm
	        // ==============================

	        Swal.fire({
	            title: "Return Cube Token?",
	            text: "Are you sure you want to return this Cube Token?",
	            icon: "question",
	            showCancelButton: true,
	            confirmButtonText: "Confirm",
	            cancelButtonText: "Cancel",
	            reverseButtons: true,
	            customClass: {
	                confirmButton: "btn btn-success",
	                cancelButton: "btn btn-light"
	            },
	            buttonsStyling: false
	        }).then(function (result) {

	            if (!result.isConfirmed) {
	                return;
	            }

	            // ==============================
	            // Disable button
	            // ==============================

	            button.prop("disabled", true);

	            // ==============================
	            // Loading
	            // ==============================

	            Swal.fire({
	                title: "Processing...",
	                text: "Please wait while the token is being returned.",
	                allowOutsideClick: false,
	                allowEscapeKey: false,
	                showConfirmButton: false,
	                didOpen: function () {
	                    Swal.showLoading();
	                }
	            });

	            // ==============================
	            // AJAX
	            // ==============================

	            $.ajax({
	                url: "returnCubeToken",
	                type: "POST",
	                dataType: "json",
	                data: {
	                    userId: userId,
	                    transactionId: transactionId,
	                    reason: reason
	                },

	                success: function (response) {

	                    if (response.success) {

	                        Swal.fire({
	                            title: "Success!",
	                            text: response.message ||
	                                 "Cube Token returned successfully.",
	                            icon: "success",
	                            confirmButtonText: "OK",
	                            customClass: {
	                                confirmButton: "btn btn-success"
	                            },
	                            buttonsStyling: false
	                        }).then(function () {

	                            // ==============================
	                            // Close Modal
	                            // ==============================

	                            const modalElement =
	                                document.getElementById("returnTokenModal");

	                            const modal =
	                                bootstrap.Modal.getOrCreateInstance(modalElement);

	                            modal.hide();

	                            // ==============================
	                            // Reset Form
	                            // ==============================

	                            $("#returnTokenReason").val("");
	                            $("#transactionId").val("");

	                            // ==============================
	                            // Reload Data
	                            // ==============================

	                            loadTokenSummary(userId, year);
	                            loadTransaction(userId, year);
	                        });

	                    } else {

	                        Swal.fire({
	                            title: "Failed!",
	                            text: response.message ||
	                                 "Failed to return Cube Token.",
	                            icon: "error",
	                            confirmButtonText: "OK",
	                            customClass: {
	                                confirmButton: "btn btn-danger"
	                            },
	                            buttonsStyling: false
	                        });
	                    }
	                },

	                error: function (xhr, status, error) {

	                    console.error("returnCubeToken error:", error);
	                    console.error("Response:", xhr.responseText);

	                    let message = "Failed to return Cube Token.";

	                    if (xhr.responseJSON && xhr.responseJSON.message) {
	                        message = xhr.responseJSON.message;
	                    } else {
	                        try {
	                            const response =
	                                JSON.parse(xhr.responseText);

	                            if (response.message) {
	                                message = response.message;
	                            }

	                        } catch (e) {
	                            console.error(
	                                "Unable to parse error response:",
	                                e
	                            );
	                        }
	                    }

	                    Swal.fire({
	                        title: "Error!",
	                        text: message,
	                        icon: "error",
	                        confirmButtonText: "OK",
	                        customClass: {
	                            confirmButton: "btn btn-danger"
	                        },
	                        buttonsStyling: false
	                    });
	                },

	                complete: function () {
	                    button.prop("disabled", false);
	                }
	            });
	        });
	    });
	    
	});

	</script>
</body>
</html>