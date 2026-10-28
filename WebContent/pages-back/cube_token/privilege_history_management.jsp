<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<fmt:setLocale value="en_US" />
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
/* Header */
#redeemTable thead th {
	text-transform: uppercase;
	white-space: nowrap;
	vertical-align: middle;
}

#redeemTable thead th .dt-column-header {
	display: inline-flex !important;
	flex-direction: row !important;
	align-items: center !important;
}

#redeemTable thead th .dt-column-order {
	margin: 0 !important;
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
						Redeem History Management</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/check_in_out"
							class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a href="#"
							class="text-muted text-hover-primary">Cube Token Privilege</a></li>

						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/privilegeHistory"
							class="text-muted text-hover-primary">Redeem History</a></li>

					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid ">
			<div id="kt_app_content_container"
				class="app-container container-fluid">

				<div class="card card-flush">
					<div class="card-header">
						<h3 class="card-title text-gray-900 fw-semibold">
							All Request (<span id="redeemCount">${redeemList.size()}</span>)
						</h3>
					</div>

					<div class="card-body pt-0">
						<div class="table-responsive">
							<table id="redeemTable"
								class="table table-striped table-row-bordered gy-5 gs-4 align-middle">

								<thead>
									<tr
										class="text-start text-gray-500 fw-bold fs-7 text-uppercase ge-0">

										<th class="min-w-40px">#</th>

										<th style="min-width: 150px; max-width: 150px">Request By</th>

										<th style="min-width: 80px">Date</th>

										<th class="min-w-180px">Item Name</th>

										<th class="min-w-100px text-end">Token</th>

										<th class="text-end" style="min-width: 110px">Cash (THB)</th>

										<th class="min-w-100px text-end">Status</th>

										<th class="min-w-80px text-end">Action</th>

									</tr>
								</thead>

								<tbody>

									<c:forEach items="${redeemList}" var="redeem"
										varStatus="status">

										<tr>

											<!-- ========================= -->
											<!-- # -->
											<!-- ========================= -->
											<td class="fw-normal fs-7 text-gray-900">${status.index + 1}</td>


											<!-- ========================= -->
											<!-- Request By -->
											<!-- ========================= -->
											<td style="min-width: 150px; max-width: 150px">

												<div class="d-flex align-items-center">

													<!-- Avatar -->

													<div class="symbol symbol-40px symbol-circle me-3">

														<c:choose>
															<c:when test="${not empty redeem.filePath}">
																<div class="symbol-label">
																	<img
																		src="${pageContext.request.contextPath}${redeem.filePath}"
																		class="w-100 h-100 rounded-circle"
																		style="object-fit: cover;" alt="${redeem.nameEn}" />
																</div>
															</c:when>

															<c:otherwise>
																<div
																	class="symbol-label bg-light-primary text-primary fw-bold fs-3">
																	<c:choose>

																		<c:when test="${not empty redeem.nameEn}">
				                                                    ${redeem.nameEn.substring(0, 1).toUpperCase()}
				                                                </c:when>

																		<c:when test="${not empty redeem.nameTh}">
				                                                    ${redeem.nameTh.substring(0, 1)}
				                                                </c:when>

																		<c:otherwise>
				                                                    ?
				                                                </c:otherwise>

																	</c:choose>
																</div>
															</c:otherwise>


														</c:choose>
													</div>

													<!-- Name -->
													<div
														class="d-flex flex-column fw-normal fs-6 text-gray-900">

														<span> ${empty redeem.nameEn ? "-" : redeem.nameEn}
														</span> <span> ${empty redeem.nameTh ? "-" : redeem.nameTh}
														</span>

													</div>

												</div>

											</td>


											<!-- ========================= -->
											<!-- Date -->
											<!-- ========================= -->
											<td class="fw-normal fs-6 text-gray-800"><c:choose>

													<c:when test="${not empty redeem.timeCreate}">
														<fmt:formatDate value="${redeem.timeCreate}"
															pattern="d MMM yyyy, HH:mm" />
													</c:when>

													<c:otherwise>
				                                        -
				                                    </c:otherwise>

												</c:choose></td>


											<!-- ========================= -->
											<!-- Item Name -->
											<!-- ========================= -->
											<td><span class="text-gray-700 fs-6 fw-normal">
													${empty redeem.itemName ? "-" : redeem.itemName} </span></td>


											<!-- ========================= -->
											<!-- Token -->
											<!-- ========================= -->
											<td class="text-end"><span
												class="text-gray-700 fs-6 fw-normal"> <fmt:formatNumber
														value="${empty redeem.token ? 0 : redeem.token}"
														pattern="#,##0" />

											</span></td>


											<!-- ========================= -->
											<!-- Cash -->
											<!-- ========================= -->
											<td class="text-end"><span
												class="text-gray-700 fs-6 fw-normal"> <span
													class="me-1"> ฿ </span> <fmt:formatNumber
														value="${empty redeem.cash ? 0 : redeem.cash}"
														pattern="#,##0.##" />

											</span></td>


											<!-- ========================= -->
											<!-- Status -->
											<!-- ========================= -->
											<td class="text-end p-0">
												<span class="badge badge-lg badge-${redeem.statusColor} py-2">
													${redeem.redeemStatus}
												</span>
											</td>


											<!-- ========================= -->
											<!-- Action -->
											<!-- ========================= -->
											<td class="text-end">
											
												<div
													class="d-flex align-items-center justify-content-end gap-2">
													<a
														href="${pageContext.request.contextPath}/editRedeem?redeemId=${redeem.userRedeemId}"
														class="btn btn-sm btn-icon btn-light-info"> <i
														class="ki-duotone ki-document fs-3"> <span
															class="path1"></span> <span class="path2"></span>
													</i>
													</a>
													<c:choose>
														<c:when test="${redeem.redeemStatusCode eq '4'}">
															<a
																href="${pageContext.request.contextPath}/redeemReport?redeemId=${redeem.userRedeemId}"
																class="btn btn-sm btn-icon btn-light-success"> <i
																class="ki-duotone ki-printer fs-3"> <span
																	class="path1"></span> <span class="path2"></span> <span
																	class="path3"></span> <span class="path4"></span> <span
																	class="path5"></span>
															</i>
															</a>
														</c:when>
														<c:otherwise>
															<a href="javascript:void(0)"
																class="btn btn-sm btn-icon btn-light-gray disabled"
																aria-disabled="true"
																title="Available only when status is Completed"> <i
																class="ki-duotone ki-printer fs-3"> <span
																	class="path1"></span> <span class="path2"></span> <span
																	class="path3"></span> <span class="path4"></span> <span
																	class="path5"></span>
															</i>
															</a>
														</c:otherwise>
													</c:choose>
												</div>

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
		$(document).ready(function() {

			$("#redeemTable").DataTable({
				pageLength : 25,
				ordering : true,
				info : true,

				columnDefs : [ {
					targets : [ 6, 7 ],
					orderable : false
				} ],

				language : {
					search : "",
					searchPlaceholder : "Search...",
					emptyTable : "No redeem history found."
				}
			});

		});
	</script>

</body>
</html>