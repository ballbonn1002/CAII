<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
.userInfoContainer {
	box-shadow: 0px 3px 4px 0px rgba(0, 0, 0, 0.03);
}

/* Header */
#tokenRankingTable thead th {
	font-weight: 600 !important;
	text-transform: uppercase;
	white-space: nowrap;
	vertical-align: middle;
}

#tokenRankingTable thead th .dt-column-header {
	display: inline-flex !important;
	flex-direction: row !important;
	align-items: center !important;
}

#tokenRankingTable thead th .dt-column-order {
	margin: 0 !important;
}

.responsive-button {
	padding: 0.775rem 1.5rem !important;
	font-size: 1.1rem !important;
	border-radius: 0.475rem !important;
	/* Light theme */
	background-color: var(--bs-white) !important;
	color: var(--bs-primary) !important;
	border: 1px solid var(--bs-primary-border-subtle) !important;
	transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out,
		border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out !important;
}

/* Icon */
.responsive-button i {
	color: var(--bs-primary) !important;
	transition: color 0.2s ease-in-out !important;
}

/* Hover */
.responsive-button:hover {
	background-color: var(--bs-primary) !important;
	color: var(--bs-white) !important;
	border-color: var(--bs-primary) !important;
}

.symbol-group .symbol {
	/* margin-right: -0.5rem !important; */
	
}

.responsive-button:hover i {
	color: var(--bs-white) !important;
}

[data-bs-theme="dark"] .responsive-button {
	background-color: transparent !important;
	color: var(--bs-primary) !important;
	border-color: var(--bs-primary) !important;
}

[data-bs-theme="dark"] .responsive-button i {
	color: var(--bs-primary) !important;
}

[data-bs-theme="dark"] .responsive-button:hover {
	background-color: var(--bs-primary) !important;
	color: var(--bs-white) !important;
	border-color: var(--bs-primary) !important;
}

[data-bs-theme="dark"] .responsive-button:hover i {
	color: var(--bs-white) !important;
}

.year-option.active {
	background-color: var(--bs-primary-light);
	color: var(--bs-primary);
	font-weight: 600;
	border-radius: 4px;
}

.middle {
	color: var(--bs-primary-border-subtle);
}

.border-primary-subtle {
	border-color: var(--bs-primary-border-subtle) !important;
}

.boder-left-primary-subtle {
	border-left: 8px solid var(--bs-primary) !important;
}

/* [data-bs-theme="dark"] .boder-primary-subtle {
	border: 1px solid var(--bs-primary-border-subtle) !important; 
} */
.token-podium-card {
	border-radius: 12px;
	color: #fff;
}

.token-podium-card.rank-1 {
	background: linear-gradient(135deg, #ffd84d, #ffae00);
}

.token-podium-card.rank-2 {
	background: linear-gradient(135deg, #d5dee9, #aebdce);
}

.token-podium-card.rank-3 {
	background: linear-gradient(135deg, #ed9138, #d85d00);
}

.token-podium .podium-avatar-small {
	width: clamp(35px, 6vw, 80px);
	height: clamp(35px, 6vw, 80px);
}

.token-podium .podium-name {
	font-size: clamp(9px, 1.2vw, 16px);
}

.token-podium .podium-id {
	font-size: clamp(8px, 1vw, 14px);
}

.token-podium .podium-card {
	border-radius: clamp(6px, 1vw, 12px);
}

.token-podium .podium-card.rank-1 {
	height: clamp(180px, 25vw, 385px);
}

.token-podium .podium-card.rank-2 {
	height: clamp(150px, 20vw, 295px);
}

.token-podium .podium-card.rank-3 {
	height: clamp(140px, 18vw, 255px);
}

.token-podium .podium-token {
	font-size: clamp(28px, 4vw, 64px);
}

.token-podium .podium-label {
	font-size: clamp(10px, 1.3vw, 18px);
}

.symbol.rank-1 {
	border: 4px solid rgba(255, 217, 75, 1) !important;
}

.symbol.rank-1 .symbol-label {
	background-color: rgba(255, 248, 221, 1) !important;
	color: var(--bs-text-warning) !important;
}

.symbol.rank-2 {
	border: 4px solid var(--bs-text-gray-700) !important;
}

.symbol.rank-2 .symbol-label {
	background-color: var(--bs-border-color) !important;
	color: var(--bs-text-gray-700) !important;
}

[data-bs-theme="dark"] .symbol.rank-2 .symbol-label {
	background-color: #efefef !important;
}

.symbol.rank-3 {
	border: 4px solid var(--bs-orange) !important;
}

.symbol.rank-3 .symbol-label {
	background-color: rgba(255, 239, 223, 1) !important;
	color: rgba(253, 126, 20, 1) !important;
}

.rank-label.rank-3 {
	position: absolute;
	top: 39%;
	left: 51%;
	transform: translate(-50%, -50%);
	color: var(--bs-orange) !important;
}

.rank-label.rank-2 {
	position: absolute;
	top: 39%;
	left: 51%;
	transform: translate(-50%, -50%);
	color: rgba(153, 161, 183, 1) !important;
}

.rank-label.rank-1 {
	position: absolute;
	top: 39%;
	left: 50%;
	transform: translate(-50%, -50%);
	color: rgba(246, 192, 0, 1) !important;
}

[data-bs-theme="dark"] .rank2-label {
	color: var(--bs-text-gray-400) !important;
}

[data-bs-theme="dark"] .symbol.rank-2 {
	border-color: #838385 !important;
}

.remaining-count {
	font-size: clamp(10px, 1.3vw, 20px) !important;
}

.font-responsive {
	font-size: clamp(12px, 1.3vw, 2rem) !important;
}

.gx-custom {
	--bs-gutter-x: 3rem !important;
}

/* Mobile */
@media ( max-width : 767.98px) {
	.symbol.rank-1 {
		border: 2px solid rgba(255, 217, 75, 1) !important;
	}
	.symbol.rank-2 {
		border: 2px solid var(--bs-text-gray-700) !important;
	}
	.symbol.rank-3 {
		border: 2px solid var(--bs-orange) !important;
	}
	.card-toolbar {
		width: 100%;
	}
	.truncatable {
		display: inline-block !important;
		max-width: 110px;
	}
}

/* Tablet */
@media ( min-width : 768px) and (max-width: 991.98px) {
	.symbol.rank-1 {
		border: 2px solid rgba(255, 217, 75, 1) !important;
	}
	.symbol.rank-2 {
		border: 2px solid var(--bs-text-gray-700) !important;
	}
	.symbol.rank-3 {
		border: 2px solid var(--bs-orange) !important;
	}
}

/* ===== Redeem reward card (same as privilege.jsp) ===== */
.image-cover {
	object-fit: cover;
	height: clamp(160px, 20vw, 313px);
}

.bg-dark-light {
	background-color: var(--bs-dark-light) !important;
}

.redeem-btn {
	position: relative;
	overflow: hidden;
	background-color: var(--bs-light) !important;
	border: 1px solid var(--bs-primary-border-subtle) !important;
	color: var(--bs-primary) !important;
	transition: background-color 0.25s ease, color 0.25s ease;
}

.redeem-btn[disabled] {
	background-color: var(--bs-gray-200) !important;
	border: 1px solid var(--bs-gray-200) !important;
	color: var(--bs-text-muted) !important;
}

.redeem-btn .ki-parcel {
	position: absolute;
	top: 50%;
	left: 50%;
	opacity: 0 !important;
	color: var(--bs-white) !important;
	transform: translate(-50%, -50%) translateX(-35px);
	transition: opacity 0.4s ease, transform 0.5s
		cubic-bezier(0.22, 1, 0.36, 1) !important;
}

.redeem-text {
	display: inline-block;
	transform: translateX(0);
	transition: transform 0.5s cubic-bezier(0.22, 1, 0.36, 1);
}

.redeem-btn:hover {
	background-color: var(--bs-primary) !important;
	color: var(--bs-white) !important;
}

.redeem-btn:hover .ki-parcel {
	opacity: 1 !important;
	transform: translate(-50%, -50%) translateX(-50px);
}

.redeem-btn:hover .redeem-text {
	transform: translateX(12px);
}

.details-truncate {
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 2;
	overflow: hidden;
}

.effective-date {
	background: rgba(0, 0, 0, 0.15);
	transition: background 0.4s cubic-bezier(0.22, 1, 0.36, 1);
}

.item-card:hover .effective-date {
	background: rgba(0, 0, 0, 0.5);
}

.badge-gray-500 {
	background-color: rgba(219, 223, 233, 1) !important;
	color: var(--bs-text-muted) !important;
}

@media ( max-width : 767.98px) {
	.redeem-btn:hover .ki-parcel {
		opacity: 1 !important;
		transform: translate(-50%, -50%) translateX(-40px);
	}
}

@media ( min-width : 768px) and (max-width: 991.98px) {
	.redeem-btn:hover .ki-parcel {
		transform: translate(-50%, -50%) translateX(-45px);
	}
}

.reward-carousel .carousel-control-prev,
.reward-carousel .carousel-control-next {
	top: 42%;
	width: 40px;
	height: 40px;
	opacity: 1;
	border-radius: 50%;
	border: 1px solid var(--bs-gray-300);
	background-color: var(--bs-body-bg);
	box-shadow: var(--bs-box-shadow-sm);
	color: var(--bs-primary);
	transition: background-color .2s ease-in-out, color .2s ease-in-out,
		border-color .2s ease-in-out;
}

.reward-carousel .carousel-indicators [data-bs-target].active {
    width: 40px !important;
}

.reward-carousel .carousel-control-prev {
	left: -10px;
}

.reward-carousel .carousel-control-next {
	right: -10px;
}

.reward-carousel .carousel-control-prev:hover,
.reward-carousel .carousel-control-next:hover {
	background-color: var(--bs-primary);
	border-color: var(--bs-primary);
	color: var(--bs-white);
}

.reward-carousel .carousel-indicators {
	position: relative;
	inset: auto;
	display: flex;
	justify-content: center;
	gap: .5rem;
	margin: 1.5rem 0 0;
}

.reward-carousel .carousel-indicators [data-bs-target] {
	width: 10px;
	height: 10px;
	margin: 0;
	border: 0;
	border-radius: 50%;
	background-color: var(--bs-gray-300);
	opacity: 1;
	transition: width .2s ease, background-color .2s ease;
}

.reward-carousel .carousel-indicators [data-bs-target].active {
	width: 24px;
	border-radius: 5px;
	background-color: var(--bs-primary);
}

[data-bs-theme="dark"] .reward-carousel .carousel-control-prev,
[data-bs-theme="dark"] .reward-carousel .carousel-control-next {
	background-color: var(--bs-gray-800);
	border-color: var(--bs-gray-700);
}

@media ( max-width : 1199.98px) {
	.reward-carousel .carousel-control-prev,
	.reward-carousel .carousel-control-next {
		display: none;
	}
}

/* large device */
@media ( min-width : 992) and (max-width: 1200) {
	.symbol.rank-1 {
		border: 3px solid rgba(255, 217, 75, 1) !important;
	}
	.symbol.rank-2 {
		border: 3px solid var(--bs-text-gray-700) !important;
	}
	.symbol.rank-3 {
		border: 3px solid var(--bs-orange) !important;
	}
}
</style>
</head>
<body>
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex align-items-center flex-stack">
				<div class="d-flex justify-content-between align-items-center w-100">

					<div
						class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<h1
							class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
							Privilege Management</h1>
						<ul
							class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/check_in_out"
								class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted"><a href="#"
								class="text-muted text-hover-primary">Dashboards</a></li>

							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/cubeTokenRankingPage"
								class="text-muted text-hover-primary">Cube Token's Rank</a></li>
						</ul>
					</div>


					<div class="d-flex align-items-center justify-content-end">
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
				</div>


			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid ">
			<div id="kt_app_content_container"
				class="app-container container-fluid">

				<div
					class="d-flex justify-content-between flex-wrap boder-left-primary-subtle align-items-center border rounded py-6 px-6 mt-4 gap-6 gap-sm-3 gap-md-0 userInfoContainer">

					<div class="d-flex flex-column gap-2">
						<div class="d-flex gap-4">
							<div class="fw-bold fs-2 text-gray-900">${userInfo.id}</div>
							<c:forEach items="${userInfo.jobsiteList}" var="jobsite">
								<span class="badge badge-lg badge-primary">${jobsite.name_site}</span>
							</c:forEach>
						</div>
						<div class="d-flex gap-4 fw-normal fs-4 text-gray-900">
							<span id="employeeId">${not empty userInfo.employee_id ? userInfo.employee_id : '-'}</span>
							<span id="employeeNameEn" class="truncatable text-truncate">${not empty userInfo.name_en ? userInfo.name_en : '-'}</span>
							<span id="employeeNameTh" class="truncatable text-truncate">${not empty userInfo.name_th ? userInfo.name_th : '-'}</span>
						</div>
					</div>

					<div class="d-flex gap-5 align-items-center">
						<div class="d-flex flex-column align-items-center gap-1">
							<div
								class="d-flex align-items-center justify-content-center gap-2 me-3  lh-1 ">
								<i class="ki-duotone ki-cube-2 fs-2x text-primary"> <span
									class="path1"></span> <span class="path2"></span> <span
									class="path3"></span>
								</i>
								<div class="fw-bold fs-2hx text-primary" id="userToken">
									${userInfo.currentBalance.intValue()}</div>
							</div>
							<div class="fw-medium fs-7 text-gray-500">My Cube Token</div>
						</div>
						<div
							class="d-flex flex-column align-items-center border border-primary-subtle rounded gap-1 p-3">
							<div class="fw-bold fs-2hx text-primary lh-1" id="userRank">
								--</div>
							<div class="fw-medium fs-7 text-gray-500">Current Rank</div>
						</div>
					</div>

				</div>

				<div class="modal fade" tabindex="-1" id="sameRankModal">
					<div class="modal-dialog modal-dialog-centered modal-lg">
						<div class="modal-content">
							<div class="modal-header border-0 pb-0">
								<h3 class="modal-title"></h3>

								<!--begin::Close-->
								<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
									data-bs-dismiss="modal" aria-label="Close">
									<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span
										class="path2"></span></i>
								</div>
								<!--end::Close-->
							</div>

							<div class="modal-body">
								<div
									class="d-flex flex-column gap-4 align-items-center justify-content-center px-md-10">
									<div class="fw-bold text-gray-800 fs-2x">
										อันดับที่ <span id="sameRank"></span>
									</div>
									<div class="fw-medium fs-3">
										<span id="usersWithSameRankAmount" class="text-muted"></span>
										<span id="tokenAmount" class="text-primary"></span>
									</div>

									<!-- Table -->
									<div class="table-responsive w-100 mt-6 px-md-6">
										<table
											class="table align-middle table-row-bordered table-striped fs-7 gy-7 gx-4"
											id="sameRankTable">

											<thead>
												<tr
													class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0">
													<th class="w-50px ps-4">#</th>
													<th class="min-w-80px">EMP.ID</th>
													<th class="min-w-200px">NAME</th>
													<th class="min-w-120px text-end pe-4">JOB SITE</th>
												</tr>
											</thead>

											<tbody id="sameRankTableBody">
												<!-- JS render -->
											</tbody>

										</table>
									</div>
								</div>
							</div>

							<!-- Footer -->
							<div class="modal-footer border-0 pt-0">
								<button type="button" class="btn btn-light"
									data-bs-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>

				<div class="card card-flush mb-7 mt-10 postion-relative">

					<div class="card-header">
						<div class="card-title">
							<h3 class="fw-semibold text-gray-900">Top 10 Ranking</h3>
						</div>
					</div>
					<div class="card-body py-10">

						<div
							class="d-flex flex-column align-items-center justify-content-center py-20 h-300px"
							id="podiumLoading">
							<div class="spinner-border text-primary" role="status">
								<span class="visually-hidden">Loading...</span>
							</div>
							<span class="text-gray-600 mt-4"> Loading... </span>
						</div>

						<div class="token-podium d-none"
							style="max-width: 1500px; margin: 0 auto;">

							<div
								class="row align-items-end justify-content-center gx-2 gx-md-10">

								<!-- Rank 2 -->
								<div class="col-4">
									<div class="d-flex flex-column align-items-center">

										<div
											class="d-flex justify-content-center align-items-center w-100">
											<div id="2ndPlace">
												<div
													class="symbol symbol-circle symbol-40px symbol-lg-70px symbol-xl-90px mb-2 mb-md-4">
													<div class="symbol-label rank2-label fw-bold fs-1">-</div>
												</div>
											</div>
										</div>


										<div class="text-center mb-2 mb-md-3">
											<div class="fw-medium text-gray-900 podium-name text-wrap"
												id="2ndPodiumName"></div>

											<div class="text-gray-600 fw-normal" id="2ndEmployeeId"></div>
										</div>

										<div class="w-100 podium-card rank-2 rounded-4"
											style="background: linear-gradient(180deg, rgba(216, 224, 233, 1), rgba(156, 170, 187, 1));">

											<div
												class="h-100 d-flex flex-column align-items-center gap-md-1 gap-lg-2 mt-4 mt-lg-10">

												<div class="position-relative">

													<i class="ki-duotone ki-medal-star text-white"
														style="font-size: clamp(5.25rem, 10vw, 80px);"> <span
														class="path1"> </span> <span class="path2"></span> <span
														class="path3"></span> <span class="path4"></span>
													</i> <span class="fw-bold fs-8 rank-label rank-2"
														id="2ndRankDisplay"> 2 </span>
												</div>

												<div class="d-flex flex-column align-items-center">
													<span
														class="text-center align-bottom  podium-token fw-bold text-white"
														id="2ndToken">0</span> <span
														class="text-white fw-semibold podium-label">Cube
														Token</span>
													<!-- <div class="d-flex align-items-end text-white fw-bold podium-token">101</div>

													<div class="text-white fw-semibold podium-label">Cube
														Token</div> -->
												</div>

											</div>
										</div>

									</div>
								</div>


								<!-- Rank 1 -->
								<div class="col-4">
									<div class="d-flex flex-column align-items-center">

										<div
											class="d-flex justify-content-center align-items-center w-100"
											id="1stPlace">
											<div
												class="symbol symbol-circle symbol-40px symbol-lg-70px symbol-xl-90px mb-2 mb-md-4 rank-1">
												<div class="symbol-label fw-medium fs-2x"
													style="color: rgba(246, 192, 0, 1);">-</div>
											</div>
										</div>

										<div class="text-center mb-2 mb-md-3">
											<div class="fw-semibold text-gray-900 podium-name text-wrap"
												id="1stPodiumName"></div>

											<div class="text-gray-600 fs-6" id="1stEmployeeId"></div>
										</div>

										<div class="w-100 podium-card rank-1 rounded-4"
											style="background: linear-gradient(180deg, rgba(255, 220, 79, 1), rgba(254, 160, 0, 1));">

											<div
												class="h-100 d-flex flex-column align-items-center gap-3 gap-lg-6 mt-5 mt-md-10">

												<div class="position-relative">

													<i class="ki-duotone ki-medal-star text-white"
														style="font-size: clamp(6rem, 10vw, 120px);"> <span
														class="path1"> </span> <span class="path2"></span> <span
														class="path3"></span> <span class="path4"></span>
													</i> <span class="fw-bold fs-7 rank-label rank-1"
														id="1stRankDisplay"> 1 </span>
												</div>

												<div class="d-flex flex-column align-items-center mt-xl-3">
													<div
														class="d-flex align-items-end text-white fw-bold podium-token"
														id="1stToken">0</div>

													<div class="text-white fw-semibold podium-label">Cube
														Token</div>
												</div>

											</div>
										</div>

									</div>
								</div>


								<!-- Rank 3 -->
								<div class="col-4">
									<div class="d-flex flex-column align-items-center">

										<div
											class="d-flex justify-content-center align-items-center w-100"
											id="3rdPlace">
											<div
												class="symbol symbol-circle symbol-40px symbol-lg-70px symbol-xl-90px mb-2 mb-md-4 rank-3">
												<div class="symbol-label fw-medium fs-2x"
													style="color: rgba(253, 126, 20, 1);">-</div>
											</div>
										</div>

										<div class="text-center mb-2 mb-md-3">
											<div class="fw-semibold text-gray-900 podium-name text-wrap"
												id="3rdPodiumName"></div>

											<div class="text-gray-600 fs-6" id="3rdEmployeeId"></div>
										</div>

										<div class="w-100 podium-card rank-3 rounded-4"
											style="background: linear-gradient(180deg, rgba(235, 149, 64, 1), rgba(204, 84, 0, 1));">

											<div
												class="h-100 d-flex flex-column align-items-center justify-content-center">

												<div class="position-relative">

													<i class="ki-duotone ki-medal-star text-white"
														style="font-size: clamp(5.25rem, 10vw, 80px);"> <span
														class="path1"> </span> <span class="path2"></span> <span
														class="path3"></span> <span class="path4"></span>
													</i> <span class="fw-bold fs-8 rank-label rank-3"
														id="3rdRankDisplay"> 3 </span>
												</div>


												<div class="text-white fw-bold podium-token" id="3rdToken">0</div>

												<div class="text-white fw-semibold podium-label">Cube
													Token</div>

											</div>
										</div>

									</div>
								</div>

							</div>

						</div>

						<div class="table-responsive mt-10"
							id="tokenRankingTableContainer">
							<table
								class="table table-striped table-row-bordered table-row-gray-200 align-middle gy-7 gs-10"
								id="tokenRankingTable">

								<thead>
									<tr class="fw-bold fs-7 text-gray-500 text-uppercase">

										<th style="min-width: 80px;" class="ps-15">#</th>

										<th style="min-width: 80px;">EMP. ID</th>

										<th style="min-width: 250px;">NAME</th>

										<th style="min-width: 180px;">JOB SITE</th>

										<th class="text-end" style="min-width: 100px;">TOKEN</th>

									</tr>
								</thead>
								<tbody>

								</tbody>
							</table>
						</div>

					</div>
				</div>

				<div class="d-flex align-items-center justify-content-between mt-10">
					<h3 class="text-gray-900 fw-bold">Redeem Rewards</h3>
					<a href="${pageContext.request.contextPath}/privilegePage" class="btn btn-secondary text-gray-700">View All</a>
				</div>

				<!--begin::Reward carousel-->
				<div id="rewardItemCarousel" class="carousel slide reward-carousel mt-4">
					<!--begin::Carousel-->
					<div class="carousel-inner pt-4" id="rewardCarouselInner">
						<div class="carousel-item active">
							<div
								class="d-flex flex-column align-items-center justify-content-center py-20">
								<div class="spinner-border text-primary" role="status">
									<span class="visually-hidden">Loading...</span>
								</div>
								<span class="text-gray-600 mt-4">Loading...</span>
							</div>
						</div>
					</div>
					<!--end::Carousel-->

					<!--begin::Controls-->
					<button class="carousel-control-prev d-none" type="button"
						data-bs-target="#rewardItemCarousel" data-bs-slide="prev">
						<i class="ki-duotone ki-left fs-1"> <span class="path1"></span>
							<span class="path2"></span>
						</i> <span class="visually-hidden">Previous</span>
					</button>

					<button class="carousel-control-next d-none" type="button"
						data-bs-target="#rewardItemCarousel" data-bs-slide="next">
						<i class="ki-duotone ki-right fs-1"> <span class="path1"></span>
							<span class="path2"></span>
						</i> <span class="visually-hidden">Next</span>
					</button>
					<!--end::Controls-->

					<!--begin::Indicators-->
					<div class="carousel-indicators" id="rewardCarouselIndicators"></div>
					<!--end::Indicators-->
				</div>
				<!--end::Reward carousel-->
			</div>
		</div>
	</div>

	<script>

    let firstPlaces = [];
    let secondPlaces = [];
    let thirdPlaces = [];

    let userCurrentBalance = 0;
	
	$(document).ready(function() {

        const menu = $("#token-year-menu");
        const date = new Date();
        
        let startYear = 2026;
        let year = date.getFullYear();
        
        $(".year-select").append(
                `<span class="fw-semibold" id="year-filter">\${year}</span>`
        );

        menu.empty();
        
        while (startYear <= year) {
            menu.prepend(`
                <button
                    type="button"
                    class="dropdown-item year-option \${startYear === year ? 'active' : ''}"
                    data-year="\${startYear}">
                    \${startYear}
                </button>
            `);
            startYear++;
        }
        
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

		    loadUserRanking(year);
		    loadUserAccumelatedToken(year)
		    loadTokenRanking(year);
		    renderTop3User();
		});

        loadUserRanking(year);
        loadTokenRanking(year);
        loadUserBalanceAndRewards();

        $(document).on("click", ".favorite-icon", toggleRewardFavorite);

        $(document).on("click", "#rewardCarouselInner .item-card", function() {

            const itemId = $(this).data("item-id");

            window.location = "${pageContext.request.contextPath}/privilegePage?itemId="
                + encodeURIComponent(itemId);
        });
    });
	
	function showSameRankUsers(rank, token, users) {

	    $("#sameRank").text(rank);
	    $("#tokenAmount").text(`\${token} Cube Token`);

	    renderSameRankUsers(users);

	    const modal = new bootstrap.Modal(
	        document.getElementById("sameRankModal")
	    );

	    modal.show();
	}
	
	function renderSameRankUsers(users) {

	    const $tbody = $("#sameRankTableBody");
	    $tbody.empty();

	    users.forEach(function(user, index) {

	        const displayName =
	            user.nameEn ||
	            user.nameTh ||
	            "-";

	        const initial = displayName
	            .charAt(0)
	            .toUpperCase();

	        let avatarHtml;

	        if (user.filePath) {

	            avatarHtml = `
	                <div class="symbol symbol-circle symbol-40px me-4">
	                    <img 
	                        class="symbol-label"
	                        src="${pageContext.request.contextPath}\${user.filePath}"
	                        alt="\${escapeHtml(displayName)}"
	                    />
	                </div>
	            `;

	        } else {

	            avatarHtml = `
	                <div class="symbol symbol-circle symbol-40px me-4">
	                    <div class="symbol-label bg-light-primary text-primary fw-semibold fs-5">
	                        \${escapeHtml(initial)}
	                    </div>
	                </div>
	            `;
	        }

	        const jobSiteHtml = (user.jobsiteList || [])
	            .map(function(site) {
	                return `
	                	<div>
		                    <span class="badge badge-lg badge-primary py-2">
		                        \${escapeHtml(site.name_site)}
		                    </span>
	                    </div>
	                `;
	            })
	            .join("");

	        const html = `
	            <tr>

	                <td class="fs-6 fw-normal text-gray-900 ps-4">
	                    \${index + 1}
	                </td>

	                <td>
	                    <span class="fs-6 fw-normal text-gray-900">
	                        \${escapeHtml(user.employeeId || "-")}
	                    </span>
	                </td>

	                <td>
	                    <div class="d-flex align-items-center">

	                        \${avatarHtml}

	                        <div class="d-flex flex-column">
	                            <span class="fs-6 fw-normal text-gray-900">
	                                \${escapeHtml(user.nameEn || "-")}
	                            </span>

	                            <span class="fs-6 fw-normal text-gray-900">
	                                \${escapeHtml(user.nameTh || "-")}
	                            </span>
	                        </div>

	                    </div>
	                </td>

	                <td class="text-end pe-4">
	                	<div class="d-flex flex-column gap-3">
	                		\${jobSiteHtml || "-"}
	                	</div>
	                </td>

	            </tr>
	        `;

	        $tbody.append(html);
	    });

	    $("#usersWithSameRankAmount").text(
	        `\${users.length} คนร่วมอันดับ`
	    );
	}
	
	
	function renderTop3User() {
	
		renderPodiumPlace($("#1stPlace"), $("#1stPodiumName"), $("#1stRankDisplay"), $("#1stEmployeeId"), $("#1stToken"), firstPlaces, 1); // first place
		renderPodiumPlace($("#2ndPlace"), $("#2ndPodiumName"), $("#2ndRankDisplay"), $("#2ndEmployeeId"), $("#2ndToken"), secondPlaces, 2); // second place
		renderPodiumPlace($("#3rdPlace"), $("#3rdPodiumName"), $("#3rdRankDisplay"), $("#3rdEmployeeId"), $("#3rdToken"), thirdPlaces, 3); // third place
		
	}
	
	function renderPodiumPlace($placeContainer, $name, $rankDisplay, $employeeId, $token, users, rank) {

	    $placeContainer.empty();

	    if (!users || users.length === 0) {

	        $placeContainer.html(`
	            <div
	                class="symbol symbol-circle symbol-35px symbol-lg-70px symbol-xl-90px mb-2 mb-md-4 rank-\${rank} d-none">
	                <div
	                    class="symbol-label fw-medium fs-2x"
	                    style="color: \${getRankColor(rank)}">
	                    -
	                </div>
	            </div>
	        `);

	        $name.text("");
	        $employeeId.text("");
	        $token.text("0");
	        $rankDisplay.text(rank);

	        return;
	    }

	    // ใช้ token จาก user คนแรก
	    const tokenAmount = users[0].token || 0;
	    const rankDisplayText = users[0].rankDisplay || rank;
	    
	    $rankDisplay.text(rankDisplayText);

	    // มีหลายคนร่วมอันดับ
	    if (users.length > 1) {

	        const displayUsers = users.slice(0, 3);
	        const remainingCount = users.length - displayUsers.length;

	        const $group = $(`
	            <div class="symbol-group mb-2 mb-md-4 cursor-pointer">
	            </div>
	        `);

	        displayUsers.forEach(function(user) {

	            const displayName =
	                user.nameEn ||
	                user.nameTh ||
	                "-";

	            const initial = displayName
	                .charAt(0)
	                .toUpperCase();

	            if (user.filePath) {

	                $group.append(`
	                    <div
	                        class="symbol symbol-circle symbol-25px symbol-sm-30px symbol-lg-35px symbol-xl-60px symbol-xxl-70px rank-\${rank}">
	                        <img
	                            src="${pageContext.request.contextPath}\${user.filePath}"
	                            alt="\${escapeHtml(displayName)}" />
	                    </div>
	                `);

	            } else {

	                $group.append(`
	                    <div
	                        class="symbol symbol-circle symbol-25px symbol-sm-30px symbol-lg-35px symbol-xl-60px symbol-xxl-70px rank-\${rank}">
	                        <div
	                            class="symbol-label fw-medium font-responsive text-gray-700">
	                            \${escapeHtml(initial)}
	                        </div>
	                    </div>
	                `);
	            }
	        });

	        // ถ้ามีคนที่เหลือ
	        if (remainingCount > 0) {

	            $group.append(`
	                <div
	                    class="symbol symbol-circle symbol-30px symbol-sm-35px symbol-lg-45px symbol-xl-70px symbol-xxl-75px ">
	                    <div
	                        class="symbol-label bg-secondary text-inverse-secondary fw-medium font-responsive">
	                        +\${remainingCount}
	                    </div>
	                </div>
	            `);
	        }

	        $group.on("click", function() {
	            showSameRankUsers(
	                rank,
	                tokenAmount,
	                users
	            );
	        });

	        $placeContainer.append($group);

	        $name.text(`\${users.length} คนร่วมอันดับ`);
	        $employeeId.text("");
	        $token.text(tokenAmount);

	        return;
	    }

	    // มีคนเดียว
	    const user = users[0];

	    const displayName =
	        user.nameEn ||
	        user.nameTh ||
	        "-";

	    const initial = displayName
	        .charAt(0)
	        .toUpperCase();

	    if (user.filePath) {

	        $placeContainer.html(`
	            <div
	                class="symbol symbol-circle symbol-35px symbol-lg-70px symbol-xl-90px mb-2 mb-md-4 rank-\${rank}">
	                <img
	                    src="${pageContext.request.contextPath}\${user.filePath}"
	                    alt="\${escapeHtml(displayName)}" />
	            </div>
	        `);

	    } else {

	        $placeContainer.html(`
	            <div
	                class="symbol symbol-circle symbol-35px symbol-lg-70px symbol-xl-90px mb-2 mb-md-4 rank-\${rank}">
	                <div
	                    class="symbol-label fw-medium font-responsive">
	                    \${escapeHtml(initial)}
	                </div>
	            </div>
	        `);
	    }

	    $name.text(displayName);
	    $employeeId.text(user.employeeId || "-");
	    $token.text(tokenAmount);
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
	
	function loadUserAccumelatedToken(year) {

	    const $userToken = $("#userToken");

	    // Show spinner while loading
	    $userToken.text('-');
	    
	    $.ajax({
	        url: "${pageContext.request.contextPath}/getUserAccumelatedToken",
	        type: "GET",
	        data: {
	            year: year
	        },
	        dataType: "json",
	        success: function (response) {

	            if (response.success) {
	                $userToken.text(String(Math.trunc(response.data)));
	            } else {
	                $userToken.text("-");
	            }
	        },
	        error: function (xhr, status, error) {

	            console.error("Error loading user accumulated token:", error);

	            $userToken.text("-");
	        }
	    });
	}
	
	function getRankColor(rank) {

	    if (rank === 1) {
	        return "rgba(255, 217, 75, 1)";
	    }

	    if (rank === 3) {
	        return "rgba(253, 126, 20, 1)";
	    }

	    return "rgba(75, 85, 99, 1)";
	}
	
	function loadUserRanking(year) {

	    const $rank = $("#userRank");

	    // Show spinner while loading
	    $rank.html(`
		    <span class="spinner-border text-primary" role="status">
		        <span class="visually-hidden">Loading...</span>
		    </span>
		`);
	    
	    $.ajax({
	        url: "${pageContext.request.contextPath}/getUserCurrentRank",
	        type: "GET",
	        data: {
	            year: year
	        },
	        dataType: "json",
	        success: function (response) {

	            if (response.success) {
	                $rank.text(response.data);
	            } else {
	                $rank.text("-");
	            }
	        },
	        error: function (xhr, status, error) {

	            console.error("Error loading user ranking:", error);

	            $rank.text("N/A");
	        }
	    });
	}
	
	function loadTokenRanking(year) {
	
	    const tbody = $("#tokenRankingTable tbody");
	    const container = $("#tokenRankingTableContainer");
	    
	    firstPlaces.length = 0;
	    secondPlaces.length = 0;
	    thirdPlaces.length = 0;
	
	  /*   // ==========================================
	    // Loading
	    // ==========================================
	    tbody.html(`
	        <tr>
	            <td colspan="5" class="text-center py-10">
	                <div class="d-flex flex-column align-items-center">
	                    <div class="spinner-border text-primary mb-4" role="status">
	                        <span class="visually-hidden">Loading...</span>
	                    </div>
	                    <span class="text-gray-600 fw-semibold">
	                        Loading token ranking...
	                    </span>
	                </div>
	            </td>
	        </tr>
	    `); */
	    
	    $("#podiumLoading").removeClass("d-none");
	    $(".token-podium").addClass("d-none");
	
	    $.ajax({
	        url: "${pageContext.request.contextPath}/getTokenRanking?year=" + year,
	        type: "GET",
	        dataType: "json",
	
	        success: function(response) {
	
	            if (!response.success || !response.data) {
	                showRankingError();
	                return;
	            }
	
	            const users = response.data;
	
	            if (users.length === 0) {
	                tbody.html(`
	                    <tr>
	                        <td colspan="5" class="text-center py-10 text-gray-600">
	                            No ranking data available.
	                        </td>
	                    </tr>
	                `);
	                return;
	            }
	
	            let html = "";
	            /* const rankingGroups = [];
	            
	            users.forEach(function(user) {

	                const rankDisplay = String(user.rankDisplay);

	                let group = rankingGroups.find(function(group) {
	                    return group.rankDisplay === rankDisplay;
	                });

	                if (!group) {
	                    group = {
	                        rankDisplay: rankDisplay,
	                        users: []
	                    };

	                    rankingGroups.push(group);
	                }

	                group.users.push(user);
	            });
	            
	            const top3Groups = rankingGroups.slice(0, 3);
	         
	            firstPlaces = top3Groups[0] ? top3Groups[0].users : [];
	            secondPlaces = top3Groups[1] ? top3Groups[1].users : [];
	            thirdPlaces = top3Groups[2] ? top3Groups[2].users : [];
	            
	            const top3Count = firstPlaces.length + secondPlaces.length + thirdPlaces.length; */
	            
	            users.forEach(function(user) {

	            	const rank = String(user.rankDisplay).replace("T", "");

	            	if (rank === "1") {

		            	firstPlaces.push(user);
	
		            	return;

	            	}

	            	if (rank === "2") {
	
		            	secondPlaces.push(user);
	
		            	return;

	            	}

	            	if (rank === "3") {

		            	thirdPlaces.push(user);
	
		            	return;

	            	}

	                // ==========================================
	                // Avatar
	                // ==========================================
	                let avatarHtml;
	
	                if (user.filePath) {
	
	                    avatarHtml = `
	                        <div class="symbol symbol-40px symbol-circle">
	                            <div class="symbol-label">
	                                <img
	                                    src="${pageContext.request.contextPath}\${escapeHtml(user.filePath)}"
	                                    class="w-100 h-100 rounded-circle"
	                                    style="object-fit: cover;"
	                                    alt="\${user.nameEn || ''}">
	                            </div>
	                        </div>
	                    `;
	
	                } else {
	
	                    const avatarInitial =
	                        (user.nameEn || user.nameTh || "?")
	                            .trim()
	                            .charAt(0)
	                            .toUpperCase();
	
	                    avatarHtml = `
	                        <div class="symbol symbol-40px symbol-circle">
	                            <div class="symbol-label bg-light-primary text-primary fw-semibold fs-5">
	                                \${escapeHtml(avatarInitial)}
	                            </div>
	                        </div>
	                    `;
	                }
	
	                // ==========================================
	                // Row
	                // ==========================================
	                html += ` 
	                    <tr>
		                	<td data-order="\${user.rank}" class="ps-15">
		                		<span class="fw-bold fs-7 text-gray-900">
		                			\${escapeHtml(user.rankDisplay)}
		                		</span>
			                </td>
	
	                        <td><span class="fw-normal fs-6 text-gray-900">\${escapeHtml(user.employeeId ?? "-")}</span></td>
	
	                        <td>
	                            <div class="d-flex align-items-center gap-5">
	
	                                <div class="d-flex flex-shrink-0">
	                                    \${avatarHtml}
	                                </div>
	
	                                <div class="d-flex flex-column justify-content-end" style="height: 48px;">
	                                    <span class="fw-normal fs-6 text-gray-900">
	                                        \${escapeHtml(user.nameEn ?? "-")}
	                                    </span>
	
	                                    <span class="fw-normal fs-6 text-gray-900">
	                                        \${escapeHtml(user.nameTh ?? "-")}
	                                    </span>
	                                </div>
	
	                            </div>
	                        </td>
	
	                        <td>
		                        <div class="d-flex flex-column gap-2">
		                            \${
		                                user.jobsiteList && user.jobsiteList.length > 0
		                                    ? user.jobsiteList.map(site => `
		                                        <div>
		                                            <span class="badge badge-lg badge-primary py-2">
		                                                \${escapeHtml(site.name_site)}
		                                            </span>
		                                        </div>
		                                    `).join("")
		                                    : `<span class="text-gray-900">-</span>`
		                            }
		                        </div>
		                    </td>
	
	                        <td class="text-end fw-normal fs-6 text-gray-900">\${escapeHtml(user.token ?? 0)}</td>
	                    </tr>
	                `;
	            });
	
	            tbody.html(html);
	            renderTop3User();
	            $("#podiumLoading").addClass("d-none");
	            $(".token-podium").removeClass("d-none");
	            $("#tokenRankingTable").DataTable();
	        },
	
	        error: function(xhr, status, error) {
	
	            console.error("Error loading token ranking:", error);
	
	            showRankingError();
	        },

	        complete: function() {
	        	$("#podiumLoading").addClass("d-none");
	            $(".token-podium").removeClass("d-none");
	        }
	    });
	
	
	    // ==========================================
	    // Error
	    // ==========================================
	    function showRankingError() {

	        container.html(`
	            <div class="text-center py-10">
	                <i class="ki-duotone ki-information-5 fs-3x text-danger mb-4">
	                    <span class="path1"></span>
	                    <span class="path2"></span>
	                    <span class="path3"></span>
	                </i>
	                <div class="text-danger fw-semibold">
	                    Failed to load ranking data.
	                </div>
	            </div>
	        `);
	    }
	}

	// ==========================================
	// Redeem reward carousel
	// ==========================================
	const REWARD_CAROUSEL_LIMIT = 12;
	const REWARD_CAROUSEL_ITEMS_PER_SLIDE = 4;
	const REWARD_CAROUSEL_INTERVAL = 8000;

	// Load current user balance first, then render the reward cards
	function loadUserBalanceAndRewards() {

	    $.ajax({
	        url: "${pageContext.request.contextPath}/getUserAccumelatedToken",
	        type: "GET",
	        dataType: "json",

	        success: function(response) {

	            if (response && response.success) {
	                userCurrentBalance = Number(response.data) || 0;
	            } else {
	                userCurrentBalance = 0;
	            }
	        },

	        error: function(xhr, status, error) {

	            console.error("Error loading user balance:", error);
	            userCurrentBalance = 0;
	        },

	        complete: function() {
	            loadRewardCarousel();
	        }
	    });
	}

	function loadRewardCarousel() {

	    $.ajax({
	        url: "${pageContext.request.contextPath}/getRewardItemCarousel",
	        type: "GET",
	        data: {
	            limit: REWARD_CAROUSEL_LIMIT
	        },
	        dataType: "json",

	        success: function(response) {

	            const items = response && Array.isArray(response.data) ? response.data : [];

	            if (!response || !response.success || items.length === 0) {
	                renderRewardCarouselEmpty();
	                return;
	            }

	            renderRewardCarousel(items);
	        },

	        error: function(xhr, status, error) {

	            console.error("Error loading reward carousel:", error);
	            renderRewardCarouselEmpty();
	        }
	    });
	}

	function renderRewardCarousel(items) {

	    const $inner = $("#rewardCarouselInner");
	    const $indicators = $("#rewardCarouselIndicators");

	    $inner.empty();
	    $indicators.empty();

	    const slideCount = Math.ceil(items.length / REWARD_CAROUSEL_ITEMS_PER_SLIDE);

	    for (let i = 0; i < items.length; i += REWARD_CAROUSEL_ITEMS_PER_SLIDE) {

	        const slideItems = items.slice(i, i + REWARD_CAROUSEL_ITEMS_PER_SLIDE);
	        const slideIndex = i / REWARD_CAROUSEL_ITEMS_PER_SLIDE;

	        const $slide = $("<div>").addClass(
	            "carousel-item" + (slideIndex === 0 ? " active" : "")
	        );

	        const $row = $("<div>").addClass("row row-cols-2 row-cols-xl-4 g-3 g-md-6");

	        slideItems.forEach(function(item) {
	            $row.append(buildRewardCard(item));
	        });

	        $slide.append($row);
	        $inner.append($slide);

	        $indicators.append(`
	            <button
	                type="button"
	                data-bs-target="#rewardItemCarousel"
	                data-bs-slide-to="\${slideIndex}"
	                class="\${slideIndex === 0 ? 'active' : ''}"
	                aria-label="Slide \${slideIndex + 1}"
	                aria-current="\${slideIndex === 0 ? 'true' : 'false'}"></button>
	        `);
	    }

	    initRewardCarousel(slideCount > 1);
	    toggleRewardCarouselControls(slideCount > 1);
	}

	function renderRewardCarouselEmpty() {

	    $("#rewardCarouselIndicators").empty();

	    $("#rewardCarouselInner").html(`
	        <div class="carousel-item active">
	            <div class="d-flex flex-column align-items-center justify-content-center text-center py-20">
	                <i class="ki-duotone ki-gift fs-5tx fs-md-3x text-gray-400">
	                    <span class="path1"></span>
	                    <span class="path2"></span>
	                    <span class="path3"></span>
	                    <span class="path4"></span>
	                </i>

	                <div class="fw-bold fs-3 text-gray-700 mt-5">No rewards available</div>
	                <div class="text-gray-500 fs-6 mt-2">There are currently no rewards to redeem.</div>
	            </div>
	        </div>
	    `);

	    initRewardCarousel(false);
	    toggleRewardCarouselControls(false);
	}

	function toggleRewardCarouselControls(show) {

	    const $controls = $(
	        "#rewardCarouselIndicators, " +
	        "#rewardItemCarousel .carousel-control-prev, " +
	        "#rewardItemCarousel .carousel-control-next"
	    );

	    $controls.toggleClass("d-none", !show);
	}

	function initRewardCarousel(autoSlide) {

	    const carouselEl = document.getElementById("rewardItemCarousel");

	    if (!carouselEl || !window.bootstrap) {
	        return;
	    }

	    const existing = bootstrap.Carousel.getInstance(carouselEl);

	    if (existing) {
	        existing.dispose();
	    }

	    new bootstrap.Carousel(carouselEl, {
	        interval: REWARD_CAROUSEL_INTERVAL,
	        ride: autoSlide ? "carousel" : false,
	        pause: "hover",
	        touch: true
	    });
	}

	function buildRewardCard(item) {

	    const itemId = escapeHtml(item.itemId);
	    const itemName = escapeHtml(item.itemName || "-");
	    const details = escapeHtml(item.details || "").replace(/\r\n|\n|\r/g, "<br>");
	    const token = Number(item.token) || 0;
	    const addedMoney = Number(item.addedMoney) || 0;
	    const quantity = Number(item.quantity) || 0;
	    const soldOut = quantity <= 0;
	    const insufficientBalance = userCurrentBalance < token;
	    const isDisabled = soldOut || insufficientBalance;
	    const isFavorite = Number(item.isFavorite) === 1 || item.isFavorite === true;
	    const coverPath = "${pageContext.request.contextPath}" + (item.coverPath || "");
	    const effectiveDate = formatDate(item.startDate) + " - " + formatDate(item.endDate);

	    return `
	        <div class="col">

	            <div class="card card-px-0 h-100 cursor-pointer item-card" data-item-id="\${itemId}">

	                <!--begin::Image-->
	                <div class="position-relative image-container">

	                    <div class="position-relative overflow-hidden bg-dark-light rounded-top">

	                        <img src="\${escapeHtml(coverPath)}"
	                            class="w-100 image-cover lozad"
	                            alt="\${itemName}">

	                        \${soldOut ? `
	                        <div class="position-absolute translate-middle top-50 start-50 w-100">

	                            <div
	                                class="d-flex justify-content-center align-items-center bg-danger text-white text-uppercase fw-bold fs-2 py-2">

	                                sold out

	                            </div>

	                        </div>
	                        ` : ""}

	                    </div>

	                    <!--begin::Stock-->
	                    <div
	                        class="d-flex w-100 justify-content-between position-absolute top-0 start-0 mt-3 ms-3 p-0">

	                        <div>

	                            <span
	                                class="badge badge-lg \${soldOut ? 'badge-gray-500' : 'badge-primary'} fw-normal fs-7 py-2 px-3" style="border: 1px solid rgba(241, 241, 244, 1);">

	                                \${quantity} Remaining

	                            </span>

	                        </div>
	                        <!--end::Stock-->

	                        <!--begin::Favorite-->
	                        <div
	                            class="cursor-pointer ps-6 favorite-icon position-relative"
	                            data-item-id="\${itemId}">

	                            <i class="position-absolute end-25 top-50 mt-4 me-2 me-md-4 translate-middle \${isFavorite ? 'ki-solid' : 'ki-outline' } ki-heart fs-3x fs-md-1 \${isFavorite ? 'text-danger' : ''}">

	                                <span class="path1"></span>
	                                <span class="path2"></span>

	                            </i>

	                        </div>
	                        <!--end::Favorite-->

	                    </div>

	                    <div
	                        class="effective-date position-absolute translate-middle-x bottom-0 start-50 w-100 d-flex align-items-center justify-content-center text-center p-4">

	                        <div class="fs-7 text-white fw-normal">\${effectiveDate}</div>

	                    </div>

	                </div>
	                <!--end::Image-->

	                <!--begin::Card body-->
	                <div class="card-body d-flex flex-column p-6">

	                    <!--begin::Title-->
	                    <div class="mb-2">
	                        <div
	                            class="fw-bold fs-4 text-gray-700 text-truncate item-name">

	                            \${itemName}

	                        </div>

	                        <div
	                            class="fw-bold fs-6 text-gray-600 details-truncate mt-2">

	                            \${details || "-"}

	                        </div>

	                    </div>
	                    <!--end::Title-->

	                    <!--begin::Price-->
	                    <div class="mt-auto pt-10">

	                        <div class="d-flex align-items-center justify-content-between">

	                            <!-- Token -->
	                            <div class="d-flex align-items-center gap-2">

	                                <i class="ki-duotone ki-cube-2 fs-2x text-primary">

	                                    <span class="path1"></span>
	                                    <span class="path2"></span>
	                                    <span class="path3"></span>

	                                </i>

	                                <span class="fw-bold fs-3 text-\${insufficientBalance ? 'warning' : 'gray-800'}">

	                                    \${token.toLocaleString()}

	                                </span>

	                                \${insufficientBalance ? `
	                                <i class="ki-solid ki-information-5 fs-1 text-warning">
	                                    <span class="path1"></span>
	                                    <span class="path2"></span>
	                                    <span class="path3"></span>
	                                </i>
	                                ` : ""}

	                            </div>

	                            <!-- Additional -->
	                            <div class="fw-medium fs-5 text-gray-700">

	                                + &#3647; \${addedMoney.toLocaleString()}

	                            </div>

	                        </div>

	                    </div>
	                    <!--end::Price-->

	                    <!--begin::Button-->
	                    <div class="pt-6">

	                        <button type="button" data-item-id="\${itemId}"
	                            class="btn btn-icon w-100 fw-semibold p-1 redeem-btn">

	                            <i
	                                class="ki-duotone ki-parcel fs-2x text-primary position-absolute">

	                                <span class="path1"></span>
	                                <span class="path2"></span>
	                                <span class="path3"></span>
	                                <span class="path4"></span>
	                                <span class="path5"></span>

	                            </i>

	                            <span class="redeem-text">
	                                \${isDisabled ? "รายละเอียด" : "แลกของรางวัล"}
	                            </span>

	                        </button>

	                    </div>
	                    <!--end::Button-->

	                </div>
	                <!--end::Card body-->

	            </div>

	        </div>
	    `;
	}

	function toggleRewardFavorite(event) {

	    event.preventDefault();
	    event.stopPropagation();

	    const $favorite = $(this);
	    const itemId = $favorite.data("item-id");
	    const $icon = $favorite.find("i");

	    // Update UI first (optimistic)
	    const wasFavorite = $icon.hasClass("ki-solid");

	    setRewardFavoriteIcon($icon, !wasFavorite);

	    $.ajax({
	        url: "${pageContext.request.contextPath}/toggleFavorite",
	        type: "POST",
	        data: {
	            itemId: itemId
	        },
	        dataType: "json",

	        success: function(response) {

	            if (!response.success) {
	                setRewardFavoriteIcon($icon, wasFavorite);
	            }
	        },

	        error: function(xhr, status, error) {

	            console.error("Toggle favorite error:", error);
	            setRewardFavoriteIcon($icon, wasFavorite);
	        }
	    });
	}

	function setRewardFavoriteIcon($icon, isFavorite) {

	    $icon
	        .toggleClass("ki-solid", isFavorite)
	        .toggleClass("ki-outline", !isFavorite)
	        .toggleClass("text-danger", isFavorite)
	        .toggleClass("text-gray-600", !isFavorite);
	}

	function formatDate(value) {

	    if (!value) {
	        return "-";
	    }

	    const date = new Date(value);

	    if (isNaN(date.getTime())) {
	        return "-";
	    }

	    const day = date.getDate();
	    const month = date.toLocaleString("en-US", { month: "short" });
	    const year = String(date.getFullYear()).slice(-2);

	    return day + " " + month + " " + year;
	}

</script>
</body>
</html>