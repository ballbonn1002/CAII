<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<fmt:setLocale value="en_US" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>My Travel | CubeSoftTech</title>

<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/assets/css/style.bundle.css"
	rel="stylesheet" type="text/css" />

<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>

<style>
.btn-purple-light {
	background-color: #E8D9F2 !important;
	color: #7E3391 !important;
	border: none;
}

.btn-purple-light:hover {
	background-color: #7E3391 !important;
	color: white !important;
}

.btn-blue-light {
	background-color: #E1F0FF !important;
	color: #0095E8 !important;
	border: none;
}

.btn-red-light {
	background-color: #FFE2E5 !important;
	color: #F64E60 !important;
	border: none;
}

.table thead th {
	background-color: #F9F9F9;
	text-transform: uppercase;
	font-size: 0.75rem;
	color: #A1A5B7;
}

.breadcrumb-item+.breadcrumb-item::before {
	content: "-" !important;
}

.bg-user-info {
	background-color: #F5F8FA;
	border-radius: 8px;
}

.card.card-flush>.card-header {
	border-bottom: 1px solid #EEF0F3 !important;
}

#kt_travel_table thead th {
	background-color: #fff !important;
}

/* Loading overlay */
.table-loading-overlay {
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(255, 255, 255, 0.85);
	display: none;
	align-items: center;
	justify-content: center;
	z-index: 10;
	border-radius: 8px;
}

.table-loading-overlay.active {
	display: flex;
}

#filterUser+.select2-container .select2-selection__rendered {
	color: #181c32 !important;
	font-weight: 500 !important;
}
</style>
</head>

<body id="kt_app_body" class="app-default">

	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<%-- ✅ default = Draft --%>
	<c:set var="statusActiveSafe"
		value="${not empty param.status ? param.status : (empty statusActive ? 'Draft' : statusActive)}" />

	<div class="d-flex flex-column flex-root" id="kt_app_root">
		<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
			<div class="d-flex flex-column flex-column-fluid">

				<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
					<div id="kt_app_toolbar_container"
						class="app-container container-fluid d-flex align-items-center">
						<div
							class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
							<h1
								class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center my-0">
								My Travel</h1>
							<ul
								class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
								<li class="breadcrumb-item text-muted">Home</li>
								<li class="breadcrumb-item"><span
									class="bullet bg-gray-400 w-5px h-2px "></span></li>
								<li class="breadcrumb-item text-muted">Cube Management</li>
							</ul>
						</div>
					</div>
				</div>

				<div id="kt_app_content" class="app-content flex-column-fluid">
					<div id="kt_app_content_container"
						class="app-container container-fluid">

						<!-- Filter Bar -->
						<div class="card mb-5 mb-xl-8">
							<div class="card-body py-3">
								<form id="filterForm" method="get" action="${ctx}/my_travel">
									<input type="hidden" name="status" value="${statusActiveSafe}" />
									<input type="hidden" name="page" value="1" />
									<div class="d-flex flex-stack gap-5">
										<!-- LEFT: User selector -->
										<div
											class="w-100 d-flex align-items-center bg-gray-100 border border-gray-300 rounded px-4 ">
											<i class="ki-duotone ki-magnifier fs-2 me-3 text-muted">
												<span class="path1"></span> <span class="path2"></span>
											</i>
											<div class="d-flex flex-column w-100">
												<select id="filterUser" name="userId"
													class="form-control bg-transparent border-0 shadow-none fw-medium text-gray-900"
													data-control="select2" style="width: 100%;" disabled>
													<c:set var="onlineUser" value="${sessionScope.onlineUser}" />
													<c:forEach var="u" items="${userListObj}">
														<c:if test="${u['id'] == onlineUser.id}">
															<c:set var="emp"
																value="${not empty u['employee_id'] ? u['employee_id'] : ''}" />
															<c:set var="nameEN"
																value="${not empty u['name_en']     ? u['name_en']     : ''}" />
															<c:set var="nameTH"
																value="${not empty u['name']        ? u['name']        : ''}" />
															<c:set var="dept"
																value="${not empty u['department']  ? u['department']  : ''}" />
															<option value="${onlineUser.id}" selected>
																${emp}&nbsp;&nbsp;-&nbsp;&nbsp;${nameEN}&nbsp;&nbsp;-&nbsp;&nbsp;${nameTH}&nbsp;&nbsp;-&nbsp;&nbsp;${dept}
															</option>
														</c:if>
													</c:forEach>
												</select>
											</div>
										</div>
										<!-- RIGHT: Date range -->
										<div class="input-group w-50">
											<span class="input-group-text bg-transparent"><i
												class="ki-duotone ki-calendar-8 fs-3"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span> <span class="path4"></span> <span
													class="path5"></span> <span class="path6"></span>
											</i> </span> <input type="text" id="filterDateRange"
												class="form-control border-start-0" name="dateRange"
												placeholder="YYYY-MM-DD to YYYY-MM-DD" />
										</div>
									</div>
								</form>
							</div>
						</div>

						<div class="card card-flush">

							<div class="card-header pt-6 border-bottom border-gray-200">
								<div class="card-title">
									<h3 class="fw-bold mb-0">Travel expense reimbursement list</h3>
								</div>

								<div class="card-toolbar">
									<%-- ✅ tab Draft ใช้ status=Draft --%>
									<c:url var="tabDraft" value="/my_travel">
										<c:param name="status" value="Draft" />
										<c:param name="page" value="1" />
										<c:if test="${not empty param.dateRange}">
											<c:param name="dateRange" value="${param.dateRange}" />
										</c:if>
									</c:url>

									<c:url var="tabW" value="/my_travel">
										<c:param name="status" value="W" />
										<c:param name="page" value="1" />
										<c:if test="${not empty param.dateRange}">
											<c:param name="dateRange" value="${param.dateRange}" />
										</c:if>
									</c:url>

									<c:url var="tabC" value="/my_travel">
										<c:param name="status" value="C" />
										<c:param name="page" value="1" />
										<c:if test="${not empty param.dateRange}">
											<c:param name="dateRange" value="${param.dateRange}" />
										</c:if>
									</c:url>

									<c:url var="tabA" value="/my_travel">
										<c:param name="status" value="A" />
										<c:param name="page" value="1" />
										<c:if test="${not empty param.dateRange}">
											<c:param name="dateRange" value="${param.dateRange}" />
										</c:if>
									</c:url>

									<c:url var="tabP" value="/my_travel">
										<c:param name="status" value="P" />
										<c:param name="page" value="1" />
										<c:if test="${not empty param.dateRange}">
											<c:param name="dateRange" value="${param.dateRange}" />
										</c:if>
									</c:url>

									<c:url var="tabR" value="/my_travel">
										<c:param name="status" value="R" />
										<c:param name="page" value="1" />
										<c:if test="${not empty param.dateRange}">
											<c:param name="dateRange" value="${param.dateRange}" />
										</c:if>
									</c:url>

									<ul
										class="nav nav-stretch nav-line-tabs nav-line-tabs-2x border-transparent fs-5 fw-bold">
										<%-- ✅ Draft tab — ไม่มีสถานะ ดูจาก expense_group_id = 0 --%>
										<li class="nav-item"><a
											class="nav-link text-active-primary ${statusActiveSafe=='Draft' ? 'active' : ''}"
											href="${tabDraft}" data-status="Draft">Draft</a></li>
										<li class="nav-item"><a
											class="nav-link text-active-primary ${statusActiveSafe=='W' ? 'active' : ''}"
											href="${tabW}" data-status="W">Waiting</a></li>
										<li class="nav-item"><a
											class="nav-link text-active-primary ${statusActiveSafe=='C' ? 'active' : ''}"
											href="${tabC}" data-status="C">Cancel</a></li>
										<li class="nav-item"><a
											class="nav-link text-active-primary ${statusActiveSafe=='A' ? 'active' : ''}"
											href="${tabA}" data-status="A">Approve</a></li>
										<li class="nav-item"><a
											class="nav-link text-active-primary ${statusActiveSafe=='P' ? 'active' : ''}"
											href="${tabP}" data-status="P">Paid</a></li>
										<li class="nav-item"><a
											class="nav-link text-active-primary ${statusActiveSafe=='R' ? 'active' : ''}"
											href="${tabR}" data-status="R">Reject</a></li>
									</ul>
								</div>
							</div>

							<div class="card-body pt-0">
								<form id="submitForm" method="post"
									action="${ctx}/submit_travelR">

									<c:url var="createUrl" value="/my_travelA" />

									<%-- ✅ Submit + Create button แสดงเฉพาะ tab Draft --%>
									<div id="submitButtonContainer"
										class="d-flex align-items-center justify-content-end flex-wrap gap-6 mt-6 mb-6 ${statusActiveSafe != 'Draft' ? 'd-none' : ''}">
										<c:if test="${statusActiveSafe == 'Draft'}">
											<span class="text-gray-400 fw-bold me-6"> <span
												id="selectedCount">0</span> Selected
											</span>

											<div class="d-flex gap-4">
												<button type="submit" class="btn btn-primary btn-sm px-4"
													id="btn-submit-request">
													<i class="ki-duotone ki-send fs-4 me-2"><span
														class="path1"></span> <span class="path2"></span></i>Submit
													Request
												</button>

												<a href="${createUrl}" class="btn btn-success btn-sm px-4"
													data-route="my_travelA"> <i
													class="ki-duotone ki-plus fs-4 me-2"> <span
														class="path1"></span><span class="path2"></span>
												</i> Create
												</a>
											</div>
										</c:if>
									</div>

									<div class="table-responsive" style="position: relative;">
										<div id="tableLoadingOverlay" class="table-loading-overlay">
											<div class="text-center">
												<span class="spinner-border text-primary"></span>
												<div class="mt-3 text-muted fw-semibold">Loading...</div>
											</div>
										</div>

										<c:set var="isGroupView" value="${viewMode == 'group'}" />

										<table class="table align-middle table-row-dashed fs-6 gy-5"
											id="kt_travel_table">
											<thead>
												<tr
													class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">

													<c:if test="${statusActiveSafe == 'Draft'}">
														<th class="w-25px"><input class="form-check-input"
															type="checkbox" id="selectAll" /></th>
													</c:if>

													<c:choose>
														<c:when test="${isGroupView}">
															<th>Group ID</th>
														</c:when>
														<c:otherwise>
															<th>Expense ID</th>
														</c:otherwise>
													</c:choose>

													<th>Date - Time</th>
													<th>User</th>

													<c:if test="${isGroupView}">
														<th class="text-center">Items</th>
													</c:if>

													<th>Amount</th>
													<th class="text-center">Status</th>
													<th class="text-end">Action</th>
												</tr>
											</thead>

											<tbody class="text-gray-600 fw-semibold">
												<c:choose>

													<%-- ===== DRAFT view ===== --%>
													<c:when test="${statusActiveSafe == 'Draft'}">
														<c:forEach var="row" items="${travelListObj}">
															<tr>
																<td><input class="form-check-input row-checkbox"
																	type="checkbox" name="ids" value="${row.expense_id}" />
																</td>
																<td><span class="text-gray-800 fw-bold">${row.expense_id}</span></td>
																<td><c:choose>
																		<c:when test="${not empty row.dt_start}">
																			<fmt:formatDate value="${row.dt_start}"
																				pattern="d MMM yyyy, H:mm" />
																		</c:when>
																		<c:otherwise>-</c:otherwise>
																	</c:choose></td>
																<td>${not empty row.user_name ? row.user_name : '-'}</td>
																<td class="text-gray-800 fw-bold"><fmt:formatNumber
																		value="${row.amount}" pattern="#,##0.00" /></td>
																<td class="text-center"><span
																	class="badge badge-secondary fs-6 px-4 py-2">Draft</span>
																</td>
																<td class="text-end">
																	<div class="d-flex justify-content-end gap-2">
																		<button type="button"
																			class="btn btn-icon btn-light-info btn-open-modal"
																			data-expense-id="${row.expense_id}" title="View">
																			<i class="ki-duotone ki-document fs-1"> <span
																				class="path1"></span><span class="path2"></span>
																			</i>
																		</button>
																		<a href="${ctx}/my_travelE?id=${row.expense_id}"
																			class="btn btn-icon btn-light-primary" title="Edit">
																			<i class="ki-duotone ki-pencil fs-1"> <span
																				class="path1"></span><span class="path2"></span>
																		</i>
																		</a>
																		<button type="button"
																			class="btn btn-icon btn-light-danger btn-delete-expense"
																			data-id="${row.expense_id}" title="Delete">
																			<i class="ki-duotone ki-trash fs-1"> <span
																				class="path1"></span><span class="path2"></span> <span
																				class="path3"></span><span class="path4"></span>
																			</i>
																		</button>
																	</div>
																</td>
															</tr>
														</c:forEach>
														<c:if test="${empty travelListObj}">
															<tr>
																<td colspan="7" class="text-center text-muted py-10">No
																	data.</td>
															</tr>
														</c:if>
													</c:when>

													<c:when test="${statusActiveSafe == 'W'}">
														<c:forEach var="row" items="${travelListObj}">
															<tr>
																<td><span class="text-gray-800 fw-bold">${row.expense_group_id}</span></td>
																<td><c:choose>
																		<c:when test="${not empty row.requested_at}">
																			<fmt:formatDate value="${row.requested_at}"
																				pattern="d MMM yyyy, H:mm" />
																		</c:when>
																		<c:otherwise>
																			<fmt:formatDate value="${row.time_create}"
																				pattern="d MMM yyyy, H:mm" />
																		</c:otherwise>
																	</c:choose></td>
																<td>${not empty row.user_name ? row.user_name : '-'}</td>
																<td class="text-center"><span
																	class="badge badge-light-primary fs-7 px-3 py-2">
																		${row.item_count} </span></td>
																<td class="text-gray-800 fw-bold"><fmt:formatNumber
																		value="${row.total_amount}" pattern="#,##0.00" /></td>
																<td class="text-center"><span
																	class="badge badge-warning fs-6 px-4 py-2">Waiting</span>
																</td>
																<td class="text-end">
																	<div class="d-flex justify-content-end gap-2">
																		<a
																			href="${ctx}/my_travel_group?expense_group_id=${row.expense_group_id}&&status=${statusActiveSafe}"
																			class="btn btn-icon btn-light-info" title="View">
																			<i class="ki-duotone ki-document fs-1"> <span
																				class="path1"></span><span class="path2"></span>
																		</i>
																		</a> <a
																			href="${ctx}/travel_report?expense_group_id=${row.expense_group_id}"
																			class="btn btn-icon btn-light-primary" title="View">
																			<i class="ki-duotone ki-printer fs-1"> <span
																				class="path1"></span> <span class="path2"></span> <span
																				class="path3"></span> <span class="path4"></span> <span
																				class="path5"></span>
																		</i>
																		</a>
																	</div>
																</td>
															</tr>
														</c:forEach>
														<c:if test="${empty travelListObj}">
															<tr>
																<td colspan="7" class="text-center text-muted py-10">No
																	data.</td>
															</tr>
														</c:if>
													</c:when>

													<c:otherwise>
														<c:forEach var="row" items="${travelListObj}">
															<tr>
																<td><span class="text-gray-800 fw-bold">${row.expense_group_id}</span></td>
																<td><c:choose>
																		<c:when test="${not empty row.requested_at}">
																			<fmt:formatDate value="${row.requested_at}"
																				pattern="d MMM yyyy, H:mm" />
																		</c:when>
																		<c:otherwise>-</c:otherwise>
																	</c:choose></td>
																<td>${not empty row.user_name ? row.user_name : '-'}</td>
																<td class="text-center"><span
																	class="badge badge-light-primary fs-7 px-3 py-2">
																		${row.item_count} </span></td>
																<td class="text-gray-800 fw-bold"><fmt:formatNumber
																		value="${row.total_amount}" pattern="#,##0.00" /></td>
																<td class="text-center"><c:choose>
																		<c:when test="${row.status_id == 'A'}">
																			<span class="badge badge-success fs-6 px-4 py-2">Approved</span>
																		</c:when>
																		<c:when test="${row.status_id == 'P'}">
																			<span class="badge badge-info fs-6 px-4 py-2">Paid</span>
																		</c:when>
																		<c:when test="${row.status_id == 'C'}">
																			<span class="badge badge-danger fs-6 px-4 py-2">Canceled</span>
																		</c:when>
																		<c:when test="${row.status_id == 'R'}">
																			<span class="badge badge-danger fs-6 px-4 py-2">Rejected</span>
																		</c:when>
																	</c:choose></td>
																<td class="text-end">
																	<div class="d-flex justify-content-end gap-2">
																		<a
																			href="${ctx}/my_travel_group?expense_group_id=${row.expense_group_id}&&status=${statusActiveSafe}"
																			class="btn btn-icon btn-light-info" title="View">
																			<i class="ki-duotone ki-document fs-1"> <span
																				class="path1"></span><span class="path2"></span>
																		</i>
																		</a> <a
																			href="${ctx}/travel_report?expense_group_id=${row.expense_group_id}"
																			class="btn btn-icon btn-light-primary" title="View">
																			<i class="ki-duotone ki-printer fs-1"> <span
																				class="path1"></span> <span class="path2"></span> <span
																				class="path3"></span> <span class="path4"></span> <span
																				class="path5"></span>
																		</i>
																		</a>
																	</div>
																</td>
															</tr>
														</c:forEach>
														<c:if test="${empty travelListObj}">
															<tr>
																<td colspan="7" class="text-center text-muted py-10">No
																	data.</td>
															</tr>
														</c:if>
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>
									</div>

									<!-- Pagination -->
									<div id="paginationContainer"
										class="d-flex align-items-center justify-content-between flex-wrap mt-6">

										<div class="d-flex align-items-center gap-2">
											<select id="pageSizeSelect"
												class="form-select form-select-sm w-auto">
												<option value="25" ${pageSize == 25 ? 'selected' : ''}>25</option>
												<option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
												<option value="100" ${pageSize == 100 ? 'selected' : ''}>100</option>
											</select>
										</div>

										<div class="d-flex align-items-center gap-1">

											<c:choose>
												<c:when test="${currentPage > 1}">
													<button type="button"
														class="btn btn-icon btn-sm btn-light pagination-link"
														data-page="${currentPage - 1}">
														<i class="ki-duotone ki-left fs-4"></i>
													</button>
												</c:when>
												<c:otherwise>
													<button type="button" class="btn btn-icon btn-sm btn-light"
														disabled>
														<i class="ki-duotone ki-left fs-4"></i>
													</button>
												</c:otherwise>
											</c:choose>

											<c:forEach begin="1" end="${totalPages}" var="i">
												<c:choose>
													<c:when
														test="${totalPages > 7 && i > 3 && i < totalPages - 2 && i != currentPage}">
														<c:if test="${i == 4}">
															<span class="btn btn-icon btn-sm btn-light disabled">...</span>
														</c:if>
													</c:when>
													<c:otherwise>
														<button type="button"
															class="btn btn-icon btn-sm pagination-link ${i == currentPage ? 'btn-primary' : 'btn-light'}"
															data-page="${i}">${i}</button>
													</c:otherwise>
												</c:choose>
											</c:forEach>

											<c:choose>
												<c:when test="${currentPage < totalPages}">
													<button type="button"
														class="btn btn-icon btn-sm btn-light pagination-link"
														data-page="${currentPage + 1}">
														<i class="ki-duotone ki-right fs-4"></i>
													</button>
												</c:when>
												<c:otherwise>
													<button type="button" class="btn btn-icon btn-sm btn-light"
														disabled>
														<i class="ki-duotone ki-right fs-4"></i>
													</button>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="modalDataStore" style="display: none;">
		<c:forEach var="row" items="${travelListObj}">
			<div class="modal-data-item" data-id="${row.expense_id}">
				<span class="md-expense-id">${row.expense_id}</span>
				<%-- ✅ Draft ไม่มี status_id — ปล่อยว่าง --%>
				<span class="md-status-id">${row.status_id}</span> <span
					class="md-request-date"> <c:forEach var="u"
						items="${userListObj}">
						<c:if test="${u['id'] == row.user_id}">
							<span class="md-user"> ${not empty u['employee_id'] ? u['employee_id'] : ''}
								- ${not empty u['name_en'] ? u['name_en'] : ''} - ${not empty u['name'] ? u['name'] : ''}
								- ${not empty u['department'] ? u['department'] : ''}, </span>
						</c:if>
					</c:forEach> <fmt:formatDate value="${row.time_create}"
						pattern="d MMM yyyy H:mm" /></span>
				<c:forEach var="u" items="${userListObj}">
					<c:if test="${u['id'] == row.user_id}">
						<span class="md-user"> ${not empty u['employee_id'] ? u['employee_id'] : ''}
							&nbsp;&nbsp;-&nbsp;&nbsp; ${not empty u['name_en'] ? u['name_en'] : ''}
							&nbsp;&nbsp;-&nbsp;&nbsp; ${not empty u['name'] ? u['name'] : ''}
							&nbsp;&nbsp;-&nbsp;&nbsp; ${not empty u['department'] ? u['department'] : ''}
						</span>
					</c:if>
				</c:forEach>
				<span class="md-date"><fmt:formatDate value="${row.dt_start}"
						pattern="d MMM yyyy" /></span> <span class="md-purpose">${row.description}</span>
				<span class="md-from">${row.from_location}</span> <span
					class="md-to">${row.to_location}</span> <span class="md-time-from"><fmt:formatDate
						value="${row.dt_start}" pattern="H:mm" /></span> <span
					class="md-time-to"><fmt:formatDate value="${row.dt_end}"
						pattern="H:mm" /></span> <span class="md-amount"><fmt:formatNumber
						value="${row.amount}" pattern="#,##0.00" /></span>
				<div class="md-details">
					<c:forEach var="det" items="${row.details}">
						<div class="md-detail-row" data-type="${det.travel_type_name}"
							data-desc="${det.description}" data-total="${det.total}"></div>
					</c:forEach>
					<c:if test="${empty row.details}">
						<div class="md-detail-row" data-type="-" data-desc=""
							data-total="${row.amount}"></div>
					</c:if>
				</div>
			</div>
		</c:forEach>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="travelDetailModal" tabindex="-1"
		aria-hidden="true">
		<div
			class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content"
				style="border-radius: 16px; border: none; box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);">

				<div class="modal-header border-0 pb-0 px-8 pt-7 mb-6">
					<h5 class="modal-title fw-bold fs-4">Travel expense</h5>
					<button type="button"
						class="btn btn-icon btn-sm btn-active-light-primary ms-2"
						data-bs-dismiss="modal">
						<i class="ki-duotone ki-cross fs-2"><span class="path1"></span><span
							class="path2"></span></i>
					</button>
				</div>

				<div class="modal-body px-8 py-6">

					<div class="row mb-10">
						<div class="col-6 d-flex align-items-center gap-5">
							<span id="m_expenseId" class="fw-bold fs-5 text-primary"></span>
							<%-- ✅ Draft ไม่มี status badge — ซ่อนถ้าว่าง --%>
							<span id="m_statusBadge" class="fs-7 fw-semibold px-3 py-2"></span>
						</div>
						<div class="col-6 d-flex align-items-center gap-3">
							<span id="m_requestDate" class="text-gray-700 fw-medium fs-6"></span>
						</div>
					</div>

					<div class="d-flex align-items-center gap-3 mb-8 rounded-2">
						<i class="ki-duotone ki-user-square fs-1"> <span class="path1"></span><span
							class="path2"></span><span class="path3"></span>
						</i> <span id="m_user" class="fw-medium text-gray-900 fs-6"></span>
					</div>

					<div class="row mb-8">
						<div class="col-6 d-flex align-items-center gap-3">
							<i class="ki-duotone ki-calendar fs-2 text-muted"> <span
								class="path1"></span><span class="path2"></span>
							</i> <span id="m_date" class="fw-semibold text-gray-800 fs-6"></span>
						</div>
						<div class="col-6 d-flex align-items-center gap-3">
							<i class="ki-duotone ki-notepad fs-2 text-muted"> <span
								class="path1"></span><span class="path2"></span> <span
								class="path3"></span><span class="path4"></span> <span
								class="path5"></span>
							</i> <span id="m_purpose" class="fw-semibold text-gray-700 fs-6"></span>
						</div>
					</div>

					<div class="row gy-8 mb-12">
						<div class="col-6">
							<div class="d-flex align-items-center gap-3">
								<i class="ki-duotone ki-geolocation fs-2 text-primary"> <span
									class="path1"></span><span class="path2"></span>
								</i>
								<div>
									<span class="text-muted fs-6">Beginning : </span> <span
										id="m_from" class="fw-semibold text-gray-800 fs-6"></span>
								</div>
							</div>
						</div>
						<div class="col-6 d-flex align-items-center gap-3">
							<i class="ki-duotone ki-time fs-2 text-muted"> <span
								class="path1"></span><span class="path2"></span>
							</i> <span id="m_timeFrom" class="fw-medium text-gray-700 fs-6"></span>
						</div>

						<div class="col-6">
							<div class="d-flex align-items-center gap-3">
								<i class="ki-duotone ki-geolocation fs-2 text-success"> <span
									class="path1"></span><span class="path2"></span>
								</i>
								<div>
									<span class="text-muted fs-6">Destination : </span> <span
										id="m_to" class="fw-medium text-gray-800 fs-6"></span>
								</div>
							</div>
						</div>
						<div class="col-6 d-flex align-items-center gap-3">
							<i class="ki-duotone ki-time fs-2 text-muted"> <span
								class="path1"></span><span class="path2"></span>
							</i> <span id="m_timeTo" class="fw-semibold text-gray-700 fs-6"></span>
						</div>
					</div>

					<div class="separator separator-dashed mb-12"></div>

					<div class="d-flex align-items-center justify-content-between mb-4">
						<span class="text-gray-700 fw-medium fs-5">Expense form</span> <span
							id="m_total" class="fw-bold fs-6 px-3 py-1 rounded"
							style="background: #E8F4FF; color: #0095E8;"></span>
					</div>

					<div id="m_expenseRows"></div>

				</div>

				<div
					class="modal-footer border-0 px-8 pb-7 pt-15 justify-content-end">
					<button type="button" class="btn btn-light btn-sm px-6 fw-medium"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<script>
	const ctx = "${pageContext.request.contextPath}";

	const elements = {
	    form: null,
	    dateRangeEl: null,
	    statusInput: null,
	    pageInput: null,
	    tableBody: null,
	    paginationContainer: null,
	    submitButtonContainer: null,
	    selectAll: null,
	    selectedCount: null,
	    loadingOverlay: null
	};

	const state = {
	    isLoading: false,
	    currentFilters: {
	        status: "${statusActiveSafe}",
	        dateRange: "",
	        page: 1,
	        pageSize: 25
	    }
	};

	function debounce(func, wait) {
	    let timeout;
	    return function (...args) {
	        clearTimeout(timeout);
	        timeout = setTimeout(() => func(...args), wait);
	    };
	}

	function cacheElements() {
	    elements.form                  = document.getElementById('filterForm');
	    elements.dateRangeEl           = document.getElementById('filterDateRange');
	    elements.statusInput           = document.querySelector('input[name="status"]');
	    elements.pageInput             = document.querySelector('input[name="page"]');
	    elements.tableBody             = document.querySelector('#kt_travel_table tbody');
	    elements.paginationContainer   = document.getElementById('paginationContainer');
	    elements.submitButtonContainer = document.getElementById('submitButtonContainer');
	    elements.selectAll             = document.getElementById('selectAll');
	    elements.selectedCount         = document.getElementById('selectedCount');
	    elements.loadingOverlay        = document.getElementById('tableLoadingOverlay');
	}

	function buildUrlParams() {
	    const params = new URLSearchParams();

	    const y = new Date().getFullYear();
	    const fallback = y + "-01-01 to " + y + "-12-31";

	    const dateRange =
	        state.currentFilters.dateRange &&
	        state.currentFilters.dateRange.trim() !== ""
	            ? state.currentFilters.dateRange
	            : fallback;

	    params.set('status', state.currentFilters.status);
	    params.set('page', String(state.currentFilters.page));
	    params.set('pageSize', String(state.currentFilters.pageSize));
	    params.set('dateRange', dateRange);

	    return params;
	}

	function showLoading() {
	    if (elements.loadingOverlay) elements.loadingOverlay.classList.add('active');
	    state.isLoading = true;
	}

	function hideLoading() {
	    if (elements.loadingOverlay) elements.loadingOverlay.classList.remove('active');
	    state.isLoading = false;
	}

	function showError(message) {
	    if (!elements.tableBody) return;
	    elements.tableBody.innerHTML =
	        '<tr><td colspan="7" class="text-center text-danger py-10">' +
	        '<div class="fw-bold">Error loading data</div>' +
	        '<div class="text-muted fs-7 mt-2">' + (message || 'An error occurred') + '</div>' +
	        '</td></tr>';
	}

	async function loadTableData() {
	    if (state.isLoading) return;
	    const params = buildUrlParams();
	    showLoading();
	    try {
	        const url = ctx + '/my_travel?' + params.toString();
	        const response = await fetch(url, {
	            headers: { 'X-Requested-With': 'XMLHttpRequest' }
	        });
	        if (!response.ok) throw new Error('HTTP error! status: ' + response.status);
	        const html = await response.text();
	        updateDOM(html);
	        updateURL(params);
	    } catch (error) {
	        console.error('Error:', error);
	        showError(error.message);
	    } finally {
	        hideLoading();
	    }
	}

	function updateDOM(html) {
	    const parser = new DOMParser();
	    const doc = parser.parseFromString(html, 'text/html');
	    updateTable(doc);
	    updatePagination(doc);
	    updateSubmitArea(doc);
	    updateActiveTab();
	    resetCheckboxState();
	}

	function updateTable(doc) {
	    const newTable     = doc.querySelector('#kt_travel_table');
	    const currentTable = document.querySelector('#kt_travel_table');
	    if (!newTable || !currentTable) return;

	    const newHead     = newTable.querySelector('thead');
	    const currentHead = currentTable.querySelector('thead');
	    if (newHead && currentHead) currentHead.innerHTML = newHead.innerHTML;

	    const newBody     = newTable.querySelector('tbody');
	    const currentBody = currentTable.querySelector('tbody');
	    if (newBody && currentBody) {
	        currentBody.innerHTML = newBody.innerHTML;
	        elements.tableBody = currentBody;
	    }
	}

	function updatePagination(doc) {
	    const newPag = doc.getElementById('paginationContainer');
	    const curPag = document.getElementById('paginationContainer');
	    if (!newPag || !curPag) return;
	    curPag.innerHTML = newPag.innerHTML;
	    bindPaginationEvents();
	    const pageSizeEl = document.getElementById('pageSizeSelect');
	    if (pageSizeEl) {
	        pageSizeEl.value = String(state.currentFilters.pageSize);
	        pageSizeEl.addEventListener('change', function () {
	            state.currentFilters.pageSize = parseInt(this.value) || 25;
	            state.currentFilters.page = 1;
	            loadTableData();
	        });
	    }
	}

	function updateSubmitArea(doc) {
	    const newArea = doc.getElementById('submitButtonContainer');
	    const curArea = document.getElementById('submitButtonContainer');
	    if (!newArea || !curArea) return;
	    curArea.className = newArea.className;
	    curArea.innerHTML = newArea.innerHTML;
	    elements.submitButtonContainer = curArea;
	    elements.selectedCount = document.getElementById('selectedCount');
	}

	function updateActiveTab() {
	    document.querySelectorAll('.nav-link[data-status]').forEach(link => {
	        link.classList.toggle('active', link.getAttribute('data-status') === state.currentFilters.status);
	    });
	}

	function updateURL(params) {
	    const newUrl = ctx + '/my_travel?' + params.toString();
	    history.pushState({ path: newUrl }, '', newUrl);
	}

	function bindPaginationEvents() {
	    document.querySelectorAll('.pagination-link').forEach(link => {
	        link.addEventListener('click', function (e) {
	            e.preventDefault();
	            const page = parseInt(this.getAttribute('data-page'), 10);
	            if (!isNaN(page)) {
	                state.currentFilters.page = page;
	                if (elements.pageInput) elements.pageInput.value = page;
	                loadTableData();
	            }
	        });
	    });
	}

	function bindStatusTabs() {
	    document.querySelectorAll('.nav-link[data-status]').forEach(tab => {
	        tab.addEventListener('click', function (e) {
	            e.preventDefault();
	            state.currentFilters.status = this.getAttribute('data-status');
	            state.currentFilters.page = 1;
	            if (elements.statusInput) elements.statusInput.value = state.currentFilters.status;
	            if (elements.pageInput)   elements.pageInput.value   = 1;
	            loadTableData();
	        });
	    });
	}

	function bindDateRangeFilter() {
	    if (!elements.dateRangeEl) return;

	    const now = new Date();
	    const y = now.getFullYear();
	    const defaultStart = new Date(y, 0, 1);
	    const defaultEnd   = new Date(y, 11, 31);

	    const paramDateRange = "${param.dateRange}".trim();

	    flatpickr(elements.dateRangeEl, {
	        mode: "range",
	        dateFormat: "Y-m-d",
	        altInput: true,
	        altFormat: "d M Y",
	        altInputClass: "form-control form-control-sm",
	        allowInput: true,
	        defaultDate: (paramDateRange && paramDateRange.includes(" to "))
	            ? paramDateRange.split(" to ").map(s => s.trim())
	            : [defaultStart, defaultEnd],
	        onClose: function () {
	            state.currentFilters.dateRange = elements.dateRangeEl.value || "";
	            state.currentFilters.page = 1;
	            if (elements.pageInput) elements.pageInput.value = 1;
	            loadTableData();
	        }
	    });

	    state.currentFilters.dateRange = elements.dateRangeEl.value || "";
	}

	function updateSelectedCount() {
	    if (!elements.selectedCount) return;
	    elements.selectedCount.textContent = document.querySelectorAll('.row-checkbox:checked').length;
	}
	
	function updateSubmitButtonState() {
	    const btn = document.getElementById('btn-submit-request');
	    if (!btn) return;

	    const checkedCount = document.querySelectorAll('.row-checkbox:checked').length;

	    btn.disabled = checkedCount === 0;
	}

	function handleSelectAllChange() {
	    const selectAll = document.getElementById('selectAll');
	    if (!selectAll) return;
	    document.querySelectorAll('.row-checkbox').forEach(cb => cb.checked = selectAll.checked);
	    updateSelectedCount();
	    updateSubmitButtonState();
	}

	function handleRowCheckboxChange() {
	    const selectAll = document.getElementById('selectAll');
	    if (!selectAll) return;
	    const all     = document.querySelectorAll('.row-checkbox');
	    const checked = document.querySelectorAll('.row-checkbox:checked');
	    selectAll.checked = (all.length > 0 && checked.length === all.length);
	    updateSelectedCount();
	    updateSubmitButtonState();
	}

	function resetCheckboxState() {
	    const selectedCount = document.getElementById('selectedCount');
	    if (selectedCount) selectedCount.textContent = '0';
	    const selectAll = document.getElementById('selectAll');
	    if (selectAll) {
	        selectAll.checked = false;
	        selectAll.removeEventListener('change', handleSelectAllChange);
	        selectAll.addEventListener('change', handleSelectAllChange);
	    }
	    
	    updateSubmitButtonState();
	}

	function initModal() {
	    const modalEl = document.getElementById('travelDetailModal');
	    if (!modalEl) return;
	    const modal = new bootstrap.Modal(modalEl);

	    document.addEventListener('click', function (e) {
	        const btn = e.target.closest('.btn-open-modal');
	        if (!btn) return;
	        const id = btn.getAttribute('data-expense-id');
	        if (!id) return;
	        const src = document.querySelector('#modalDataStore .modal-data-item[data-id="' + id + '"]');
	        if (!src) return;
	        fillModal(src);
	        modal.show();
	    });
	}

	function fillModal(src) {
	    function txt(cls) {
	        const el = src.querySelector('.' + cls);
	        return el ? el.textContent.trim() : '-';
	    }
	    function set(id, val) {
	        const el = document.getElementById(id);
	        if (el) el.textContent = val || '-';
	    }

	    set('m_expenseId',   '#' + txt('md-expense-id'));
	    set('m_requestDate', 'Request by: ' + txt('md-request-date'));
	    set('m_user',        txt('md-user'));
	    set('m_date',        txt('md-date'));
	    set('m_purpose',     txt('md-purpose'));
	    set('m_from',        txt('md-from'));
	    set('m_to',          txt('md-to'));
	    set('m_timeFrom',    txt('md-time-from'));
	    set('m_timeTo',      txt('md-time-to'));
	    set('m_total',       txt('md-amount') + ' บาท');

	    const statusMap = {
	        'W': { label: 'Waiting',  cls: 'badge-warning text-dark' },
	        'C': { label: 'Cancel', cls: 'badge-danger'            },
	        'A': { label: 'Approve', cls: 'badge-success'           },
	        'P': { label: 'Paid', cls: 'badge-info'           },
	        'R': { label: 'Reject', cls: 'badge-danger'            }
	    };
	    const sid   = txt('md-status-id');
	    const badge = document.getElementById('m_statusBadge');
	    if (badge) {
	        if (sid && statusMap[sid]) {
	            const sm = statusMap[sid];
	            badge.className   = 'badge fs-8 fw-semibold px-3 py-2 ' + sm.cls;
	            badge.textContent = sm.label;
	        } else {
	            badge.className   = '';
	            badge.textContent = '';
	        }
	    }

	    const rowsEl = document.getElementById('m_expenseRows');
	    if (!rowsEl) return;
	    rowsEl.innerHTML = '';

	    src.querySelectorAll('.md-detail-row').forEach(function (det) {
	        const typeName  = det.getAttribute('data-type')  || '-';
	        const desc      = det.getAttribute('data-desc')  || '-';
	        const total     = det.getAttribute('data-total') || '0';
	        const num       = parseFloat(total);
	        const formatted = isNaN(num) ? total
	            : num.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });

	        const row = document.createElement('div');
	        row.className = 'd-flex align-items-center justify-content-between py-3 mb-3';
	        row.innerHTML =
	            '<div class="d-flex align-items-center gap-3" style="flex:1;">' +
	                '<i class="ki-duotone ki-car fs-3"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>' +
	                '<span class="fw-semibold text-gray-800 fs-7">' + typeName + '</span>' +
	            '</div>' +
	            '<div class="d-flex align-items-center gap-3" style="flex:1;">' +
	                '<i class="ki-duotone ki-message-text fs-3 text-muted"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>' +
	                '<span class="text-gray-600 fs-7">' + desc + '</span>' +
	            '</div>' +
	            '<div class="fw-bold text-gray-800 fs-7 text-nowrap">' + formatted + ' บาท</div>';

	        rowsEl.appendChild(row);
	    });
	}

	// ✅ ============ Delete Expense (Draft only) ============
	function initDeleteExpense() {
	    document.addEventListener('click', function (e) {
	        const btn = e.target.closest('.btn-delete-expense');
	        if (!btn) return;

	        const expenseId = btn.getAttribute('data-id');
	        if (!expenseId) return;

	        Swal.fire({
	            title: 'ลบรายการนี้?',
	            html: 'Expense <strong>#' + expenseId + '</strong> จะถูกลบถาวร',
	            icon: 'warning',
	            showCancelButton: true,
	            confirmButtonText: 'ลบ',
	            cancelButtonText: 'ยกเลิก',
	            confirmButtonColor: '#F64E60',
	            reverseButtons: true
	        }).then(function (result) {
	            if (!result.isConfirmed) return;

	            // แสดง loading บน button ระหว่างรอ
	            btn.disabled = true;
	            btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span>';

	            fetch(ctx + '/travel_delete?id=' + expenseId, {
	                method: 'POST',
	                headers: { 'X-Requested-With': 'XMLHttpRequest' }
	            })
	            .then(function (res) { return res.json(); })
	            .then(function (data) {
	                if (data.success) {
	                    Swal.fire({
	                        icon: 'success',
	                        title: 'ลบแล้ว',
	                        text: 'Expense #' + expenseId + ' ถูกลบเรียบร้อย',
	                        timer: 1500,
	                        showConfirmButton: false
	                    }).then(function () {
	                        loadTableData(); // โหลด table ใหม่ ไม่ reload หน้า
	                    });
	                } else {
	                    // คืนค่า icon ให้ button
	                    btn.disabled = false;
	                    btn.innerHTML =
	                        '<i class="ki-duotone ki-trash fs-1">' +
	                        '<span class="path1"></span><span class="path2"></span>' +
	                        '<span class="path3"></span><span class="path4"></span></i>';
	                    Swal.fire({
	                        icon: 'error',
	                        title: 'ไม่สามารถลบได้',
	                        text: data.message || 'เกิดข้อผิดพลาด'
	                    });
	                }
	            })
	            .catch(function (err) {
	                console.error('Delete error:', err);
	                btn.disabled = false;
	                btn.innerHTML =
	                    '<i class="ki-duotone ki-trash fs-1">' +
	                    '<span class="path1"></span><span class="path2"></span>' +
	                    '<span class="path3"></span><span class="path4"></span></i>';
	                Swal.fire({
	                    icon: 'error',
	                    title: 'Network error',
	                    text: 'กรุณาลองใหม่อีกครั้ง'
	                });
	            });
	        });
	    });
	}

	function initBrowserNavigation() {
	    window.addEventListener('popstate', function (e) {
	        if (e.state && e.state.path) location.reload();
	    });
	}

	document.addEventListener('DOMContentLoaded', function () {
	    cacheElements();

	    var currentYear = new Date().getFullYear();
	    var paramDateRange = "${param.dateRange}";
	    if (paramDateRange && paramDateRange.trim() !== '') {
	        state.currentFilters.dateRange = paramDateRange.trim();
	    } else {
	        state.currentFilters.dateRange = currentYear + '-01-01 to ' + currentYear + '-12-31';
	    }

	    const pageSizeEl = document.getElementById('pageSizeSelect');
	    if (pageSizeEl) {
	        state.currentFilters.pageSize = parseInt(pageSizeEl.value) || 25;
	        pageSizeEl.addEventListener('change', function () {
	            state.currentFilters.pageSize = parseInt(this.value) || 25;
	            state.currentFilters.page = 1;
	            if (elements.pageInput) elements.pageInput.value = 1;
	            loadTableData();
	        });
	    }

	    bindStatusTabs();
	    bindDateRangeFilter();
	    bindPaginationEvents();

	    const selectAll = document.getElementById('selectAll');
	    if (selectAll) selectAll.addEventListener('change', handleSelectAllChange);

	    document.addEventListener('change', function (e) {
	        if (e.target && e.target.classList.contains('row-checkbox')) {
	            handleRowCheckboxChange();
	        }
	    });

	    initModal();
	    initDeleteExpense(); // ✅ เพิ่มตรงนี้
	    initBrowserNavigation();
	    updateSelectedCount();

	    loadTableData();
	});
	</script>
</body>
</html>