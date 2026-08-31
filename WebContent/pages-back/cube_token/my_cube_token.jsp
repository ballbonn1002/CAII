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


/* @media ( max-width : 767.98px) {
	.token-summary-item {
		justify-content: flex-start !important;
	}
	.token-summary-separator-danger, .token-summary-separator-success {
		border: none !important;
		padding-left: 0 !important;
	}
} */

/* @media ( min-width : 768px) and (max-width: 1199.98px) {
	.token-summary-separator-danger {
		border-left: none !important;
		padding-left: 0 !important;
	}
}   */
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
						My Cube Token</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/check_in_out"
							class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/myCubeToken"
							class="text-muted text-hover-primary">My Cube Token</a></li>
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
								<div class="d-flex align-items-center gap-3">

									<div class="fw-bold fs-2 text-gray-900">
										${userInfo.name_en}</div>

									<!-- Employee Type -->
									<span class="badge
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
									<span class="badge
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


								<!-- Employee ID + Name -->
								<div
									class="d-flex align-items-center gap-3 fw-normal mt-1 fs-4 text-gray-900">

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
										<div class="employee-position
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
										<div class="employee-department
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
										<div class="employee-site
													d-flex flex-column
													px-4 py-3
													border border-gray-300 border-dashed
													rounded h-100">

											<span class="fw-bold fs-4 text-gray-900"> 
												<c:choose>
													<c:when test="${not empty userInfo.jobsiteList}">
														<c:forEach var="site" items="${userInfo.jobsiteList}" varStatus="status">
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

											</span> 
											
											<span class="fw-bold fs-6 text-gray-600"> Site </span>
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
											<i class="ki-duotone ki-cube-2 fs-4x text-primary">
												<span class="path1"></span> <span class="path2"></span> <span
												class="path3"></span>
											</i>
										</div>

										<!-- Token Information -->
										<div
											class="d-flex flex-column
													align-items-center
													justify-content-center
													">
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

									<div class="d-flex flex-column
												align-items-center
												justify-content-center
												h-100 gap-1">
										<!-- Icon -->
										<div>
											<i class="ki-duotone ki-cube-3 fs-4x text-primary">
												<span class="path1"></span> <span class="path2"></span> <span
												class="path3"></span>
											</i>
										</div>

										<!-- Token Information -->
										<div
											class="d-flex flex-column
													align-items-center
													justify-content-center
													">

											<span class="fw-bold fs-2qx text-gray-800 token-value"
												data-field="yearlyCubeToken"> - </span> <span
												class="fs-4 fw-bold text-primary"> Cube Token </span> <span
												class="fs-6 fw-semibold text-gray-600"> สะสมรายปี <span id="yearlyCubeToken-year">2026</span> </span>
										</div>

									</div>

								</div>

							</div>

						</div>

					</div>

				</div>



				<div class="mt-10 mb-4">
					<div class="row g-6">

						<!-- 						Cube Token
						<div class="col-12 col-xxl-2 h-100">
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
							class="d-flex align-items-center justify-content-center gap-3 btn btn-light-primary"
							type="button" onClick="openExchangeTokenModal()">
							<i class="ki-duotone ki-arrow-right-left fs-1"> <span
								class="path1"></span> <span class="path2"></span>
							</i> <span class=""> Exchange Cube Token </span>
						</button>
					</div>
				</div>

				<!--begin::Exchange Cube Token Modal-->
				<div class="modal fade" tabindex="-1" id="exchangeTokenModal"
					aria-hidden="true">
					<div class="modal-dialog modal-lg modal-dialog-centered">
						<div class="modal-content">
							<!--begin::Modal Header-->
							<div class="modal-header border-0 pb-4">
								<h2 class="modal-title fw-bold text-gray-900">Exchange Cube
									Token</h2>
								<!--begin::Close-->
								<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
									data-bs-dismiss="modal">
									<i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span
										class="path2"></span></i>
								</div>
								<!--end::Close-->
							</div>
							<!--end::Modal Header-->
							<!--begin::Modal Body-->
							<div class="modal-body mt-4 pt-8 px-10">
								<!--begin::Exchange Rate-->
								<div class="mb-7">
									<div class="d-flex align-items-center mb-6">
										<div class="me-3 d-flex align-items-center">
											<i class="ki-duotone ki-information-5 fs-1 text-primary">
												<span class="path1"></span> <span class="path2"></span> <span
												class="path3"></span>
											</i>
										</div>
										<span class="fw-bold text-gray-800 fs-5"> Exchange Rate
										</span>
									</div>
									<!--begin::Rate Box-->
									<div
										class="bg-light-info border border-info border-opacity-25 rounded px-6 py-5">
										<div
											class="d-flex align-items-center justify-content-center gap-3">
											<span id="exchangeCubeRate" class="fw-bold text-info fs-1">
												1 </span> <span class="text-gray-600 fw-semibold fs-6"> Cube
												Token </span> <span class="text-gray-500 fs-5"> = </span> <span
												id="exchangeMonthlyRate" class="fw-bold text-info fs-1">
												1 </span> <span class="text-gray-600 fw-semibold fs-6">
												Monthly Token </span>
										</div>
									</div>
									<!--end::Rate Box-->
								</div>
								<!--end::Exchange Rate-->
								<!--begin::Divider-->
								<div class="separator separator-dashed mb-5"></div>
								<!--end::Divider-->
								<!--begin::Exchange Amount-->
								<div class="mb-7">
									<!--begin::Label-->
									<div class="d-flex align-items-center mb-2">
										<span class="fw-bold text-gray-800 fs-5"> Exchange
											Amount </span> <i
											class="ki-duotone ki-arrow-right-left fs-2 text-gray-600 ms-3">
											<span class="path1"></span> <span class="path2"></span> <span
											class="path3"></span> <span class="path4"></span> <span
											class="path5"></span> <span class="path6"></span>
										</i>
									</div>
									<!--end::Label-->
									<!--begin::Current Balance-->
									<div class="text-gray-700 fs-5 mb-4">
										Current Balance: <span id="exchangeCurrentBalance"
											class="text-gray-800 fs-5 fw-medium">-</span> <span
											class="text-gray-800 fs-5 fw-medium"> Token </span>
									</div>
									<!--end::Current Balance-->
									<!--begin::Amount Input-->
									<div class="input-group input-group-lg">
										<input type="number" class="form-control form-control-lg"
											id="exchangeTokenAmount" min="1" value="1"
											placeholder="Enter token amount"> <span
											class="input-group-text px-7"> Token </span>
									</div>
									<!--end::Amount Input-->
									<!--begin::Max Redemption-->
									<div class="text-gray-700 fs-5 mt-3">
										Max redemption: <span id="exchangeMaxRedemption"
											class="text-gray-800 fw-medium">-</span> <span
											class="text-gray-800 fw-medium"> Token </span>
									</div>
									<!--end::Max Redemption-->
								</div>
								<!--end::Exchange Amount-->
								<!--begin::Divider-->
								<div class="separator separator-dashed mb-6"></div>
								<!--end::Divider-->
								<!--begin::Receive-->
								<div class="d-flex align-items-center mb-4">
									<div
										class="d-inline-flex align-items-center px-4 py-3 border border-dashed border-gray-300 rounded">
										<span class="text-success fw-bold fs-6"> Receive </span> <span
											class="text-gray-600 fw-bold fs-6 ms-4"><span
											id="exchangeReceiveAmount" class="me-1">-</span> Monthly
											Token </span>
									</div>
								</div>
								<!--end::Receive-->
								<!--begin::Remaining-->
								<div class="text-gray-700 fs-5">
									Remaining: <span id="exchangeRemainingBalance"
										class="text-gray-800 fs-5 fw-normal">38</span> <span
										class="text-gray-800 fs-5 fw-normal"> Token</span>
								</div>
								<!--end::Remaining-->
							</div>
							<!--end::Modal Body-->
							<!--begin::Modal Footer-->
							<div class="modal-footer border-0 pt-4 px-8 pb-8">
								<button type="button" class="btn btn-light me-3"
									data-bs-dismiss="modal">Cancel</button>
								<button type="button" class="btn btn-primary"
									id="btnConfirmExchangeToken">Exchange Token</button>
							</div>
							<!--end::Modal Footer-->
						</div>
					</div>
				</div>
				<!--end::Exchange Cube Token Modal-->

				<div id="token-transaction-container">
					<!-- Transaction history will be loaded here via AJAX -->
				</div>


			</div>
		</div>
	</div>
	<script>
	
		const transactionRecords = {}
		let userCurrentMonthlyBalance = 0;
		let userCurrentCubeBalance = 0;
		
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
			
			const iconMap = {
				'gift': 'ki-award fs-1 text-success',
				'reward': 'ki-crown-2 fs-1 text-success',
				'return': 'ki-arrows-circle fs-1 text-success',
				'exchange': 'ki-arrow-right-left fs-1 text-success',
				'late': 'ki-time fs-1 text-danger',
				'early out': 'ki-brifecase-timer fs-1 text-danger',
				'leave': 'ki-calendar-8 fs-1 text-danger',
				'backdate': 'ki-calendar-edit fs-1 text-danger',
				'no record': 'ki-calendar-remove fs-1 text-danger', 
				'void': 'ki-file-up fs-1 text-danger'
			}

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
						
					    userCurrentMonthlyBalance = Number(response.currentBalance) || 0;
					    userCurrentCubeBalance = Number(response.accumulatedBalance) || 0;

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
					
					userCurrentMonthlyBalance = Number(response.currentBalance) || 0;
					userCurrentCubeBalance = Number(response.accumulatedBalance) || 0;
					
					response.data.forEach(function(month, index) {

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
														<th style="min-width: 150px">Description</th>
														<th class="text-end" style="min-width: 150px">Get Token</th>
														<th class="text-end" style="min-width: 150px">Deduct Token</th>
														<th class="text-end pe-4" style="min-width: 120px">Balance</th>

													</tr>
												</thead>

												<tbody>

													\${transactions.map(function(tx) {

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
																		<i class="ki-duotone \${iconMap[tx.actionName.toLowerCase()] || 'ki-question-circle fs-3 text-gray-500'}">
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
																	\${escapeHtml(tx.description || "-")}
																</td>

																<td class="fs-6 \${getToken === '-' ? 'text-muted' : 'text-gray-800'} fw-normal text-end pe-0">
																	\${getToken}
																</td>

																<td class="fs-6 \${deductToken === '-' ? 'text-muted' : 'text-gray-800'} fw-normal text-end pe-0">
																	\${deductToken}
																</td>

																<td class="fs-6 text-gray-800 text-end pe-4">
																	\${formatToken(tx.balance)}
																</td>

															</tr>
														`;

													}).join("")}

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
		
		function openExchangeTokenModal() {

		    $("#exchangeCurrentBalance").text(userCurrentCubeBalance);
		    $("#exchangeMaxRedemption").text(userCurrentCubeBalance);
		    $("#exchangeTokenAmount").val(1);
		    
		    $("#btnConfirmExchangeToken").prop("disabled", false);

		    updateExchangePreview();

		    const modalElement = document.getElementById("exchangeTokenModal");
		    const modal = bootstrap.Modal.getOrCreateInstance(modalElement);

		    modal.show();
		}
		
		function updateExchangePreview() {

		    const currentBalance = Number($("#exchangeCurrentBalance").text()) || 0;

		    const amount = Number($("#exchangeTokenAmount").val()) || 0;

		    const cubeRate = Number($("#exchangeCubeRate").text()) || 1;

		    const monthlyRate = Number($("#exchangeMonthlyRate").text()) || 1;

		    // Prevent exchange amount from exceeding current balance
		    if (amount > currentBalance) {
		        $("#exchangeTokenAmount").val(currentBalance);
		    }

		    const exchangeAmount =  Number($("#exchangeTokenAmount").val()) || 0;

		    // Cube Token -> Monthly Token
		    const receiveAmount = (exchangeAmount / cubeRate) * monthlyRate;

		    // Remaining Cube Token
		    const remaining = currentBalance - exchangeAmount;

		    $("#exchangeReceiveAmount").text(`\${receiveAmount}`);

		    $("#exchangeRemainingBalance").text(remaining);
		}

	$(document).ready(function() {

		const queryString = window.location.search;
		const urlParams = new URLSearchParams(queryString);
		
		const userId = urlParams.get("userId");
	  	let year = urlParams.get("year");

	    if (!year || isNaN(year)) {
	        year = new Date().getFullYear();
	    }

		
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
	    
	    $(document).on("input", "#exchangeTokenAmount", function () {
	        updateExchangePreview();
	    });
	    
	    $(document).on("click", "#btnConfirmExchangeToken", function () {

	        const tokenAmount = Number($("#exchangeTokenAmount").val()) || 0;

	        // Validate token amount
	        if (tokenAmount <= 0) {

	            Swal.fire({
	                title: "Invalid Amount",
	                text: "Exchange amount must be greater than 0.",
	                icon: "error",
	                confirmButtonText: "OK",
	                customClass: {
	                    confirmButton: "btn btn-danger"
	                },
	                buttonsStyling: false
	            });

	            return;
	        }

	        const requestData = {
	            value: tokenAmount
	        };

	        const button = $(this);

	        Swal.fire({
	            title: "Exchange Cube Token?",
	            html: `
	                <div class="text-gray-700 fs-5">
	                    Are you sure you want to exchange
	                    <strong class="text-primary">
	                        \${tokenAmount} Cube Token
	                    </strong>
	                    ?
	                </div>
	            `,
	            icon: "question",
	            showCancelButton: true,
	            confirmButtonText: "Exchange Token",
	            cancelButtonText: "Cancel",
	            reverseButtons: true,
	            customClass: {
	                confirmButton: "btn btn-primary",
	                cancelButton: "btn btn-light"
	            },
	            buttonsStyling: false
	        }).then((result) => {

	            if (!result.isConfirmed) {
	                return;
	            }

	            // Prevent double click
	            button.prop("disabled", true);

	            // Show loading
	            Swal.fire({
	                title: "Processing...",
	                text: "Please wait while the token is being exchanged.",
	                allowOutsideClick: false,
	                allowEscapeKey: false,
	                showConfirmButton: false,
	                didOpen: () => {
	                    Swal.showLoading();
	                }
	            });

	            $.ajax({
	                url: "exchangeMonthlyToken",
	                type: "POST",
	                dataType: "json",
	                data: requestData,

	                success: function (response) {

	                    if (response.success) {

	                        Swal.fire({
	                            title: "Success!",
	                            text: response.message ||
	                                "Token exchanged successfully.",
	                            icon: "success",
	                            confirmButtonText: "OK",
	                            customClass: {
	                                confirmButton: "btn btn-primary"
	                            },
	                            buttonsStyling: false
	                        }).then(() => {

	                            // Close modal
	                            const modalElement =
	                                document.getElementById("exchangeTokenModal");

	                            const modal =
	                                bootstrap.Modal.getOrCreateInstance(
	                                    modalElement
	                                );

	                            modal.hide();

	                            // Reset amount
	                            $("#exchangeTokenAmount").val(1);

	                            updateExchangePreview();

	                            // Reload data
	                            loadTokenSummary(userId, year);
	                            loadTransaction(userId, year);
	                        });

	                    } else {

	                        Swal.fire({
	                            title: "Failed!",
	                            text: response.message ||
	                                "Failed to exchange token.",
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

	                    console.error(
	                        "exchangeMonthlyToken error:",
	                        xhr
	                    );

	                    let message =
	                        "Failed to exchange token.";

	                    if (
	                        xhr.responseJSON &&
	                        xhr.responseJSON.message
	                    ) {
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
	    
	});

	</script>
</body>
</html>