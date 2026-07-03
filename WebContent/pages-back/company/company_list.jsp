<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* Header */
#kt_datatable_zero_configuration thead th {
	font-weight: 600 !important;
	text-transform: uppercase;
	white-space: nowrap;
	vertical-align: middle;
}

#kt_datatable_zero_configuration thead th .dt-column-header {
	display: inline-flex !important;
	flex-direction: row !important;
	align-items: center !important;
}

#kt_datatable_zero_configuration thead th .dt-column-order {
	margin: 0 !important;
}

/* Cell */
#kt_datatable_zero_configuration tbody td {
	vertical-align: middle;
	padding-top: 20px;
	padding-bottom: 20px;
}

#kt_datatable_zero_configuration th:nth-child(1),
	#kt_datatable_zero_configuration td:nth-child(1) {
	width: 70px;
	padding-left: 16px !important;
}

#kt_datatable_zero_configuration th:nth-child(2) {
	width: 200px;
}

#kt_datatable_zero_configuration th:nth-child(3) {
	width: 150px;
	padding-right: 50px !important;
}

#kt_datatable_zero_configuration th:nth-child(5) {
	width: 300px;
}

#kt_datatable_zero_configuration th:nth-child(6) {
	width: 100px;
}

#kt_datatable_zero_configuration th:nth-child(7) {
	width: 120px;
}

.company-name {
	max-width: 180px;
}

#custom-menu-btn {
	height: 35px !important;
	width: 35px !important;
	background-color: var(--bs-gray-100) !important;
	padding: 20px !important;
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
						<li class="breadcrumb-item text-muted">Company</li>
					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container"
				class="app-container container-fluid">

				<!-- begin::search -->
				<div class="card">
					<div class="card-body">

						<div class="position-relative">
							<i
								class="ki-duotone ki-magnifier fs-3 text-gray-500 position-absolute top-50 translate-middle-y ms-4">
								<span class="path1"></span> <span class="path2"></span>
							</i> <input type="text" class="form-control ps-12"
								placeholder="Search">
						</div>

					</div>

				</div>
				<!-- end::search -->
				<!-- begin::headerLine -->
				<div
					class="d-flex align-items-center justify-content-between mt-8 mb-6">
					<div class="d-flex align-items-baseline gap-1">
						<h3
							class="page-heading text-gray-900 fw-bold mb-0 d-flex align-items-baseline flex-nowrap">
							<span id="itemsFound" class="me-2">Compana (3)</span>
						</h3>
					</div>

					<div class="d-flex align-items-center gap-2 gap-lg-3">
						<button class="btn btn-icon" id="custom-menu-btn">
							<i class="ki-duotone ki-category fs-2"> <span class="path1"></span>
								<span class="path2"></span> <span class="path3"></span> <span
								class="path4"></span>
							</i>
						</button>

						<button class="btn btn-icon btn-primary">
							<i class="ki-duotone ki-abstract-14 fs-2"> <span
								class="path1"></span> <span class="path2"></span>
							</i>
						</button>

						<div>
							<a href="${pageContext.request.contextPath}/company_add"
								class="btn btn-primary d-inline-flex align-items-center py-3 px-6 gap-2">
								<i class="ki-duotone ki-plus fs-5"> <span class="path1"></span>
									<span class="path2"></span>
							</i> <span class="fw-bold">Create</span>
							</a>
						</div>

					</div>
				</div>
				<!-- end::headerLine -->


				<!-- begin::companyList -->
				<div class="card">
					<div class="card-body">
						<div class="table-responsive">
							<table id="kt_datatable_zero_configuration"
								class="table table-row-bordered gy-5 table-striped align-middle">
								<thead >
									<tr class=" text-muted text-uppercase text-gray-500">
										<th>#</th>
										<th>company name</th>
										<th>company code</th>
										<th>address location</th>
										<th>contact company</th>
										<th class="text-center">is active</th>
										<th class="text-end pe-6">action</th>
									</tr>
								</thead>
								<tbody>

									<c:forEach items="${companyList}" var="company"
										varStatus="status">

										<tr>

											<td>${company.company_id}</td>

											<td>
												<div class="d-flex align-items-center">

													<div class="symbol symbol-40px me-4">

														<c:choose>
															<c:when test="${not empty company.file_path}">
																<img
																	src="${pageContext.request.contextPath}${company.file_path}"
																	alt="">
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${not empty company.company_en}">
																		<div class="symbol-label fs-5 fw-bold text-primary">
																			${fn:toUpperCase(fn:substring(company.company_en,0,1))}
																		</div>
																	</c:when>
																	<c:otherwise>
																		<div class="symbol-label fs-5 fw-bold text-primary">
																			?</div>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>

													</div>

													<span class="company-name"> ${company.company_en} </span>

												</div>
											</td>

											<td>${company.company_code}</td>

											<td>
												<div class="d-flex flex-column gap-4 pe-3">
													<c:choose>

														<c:when test="${not empty company.address_location}">

															<c:forEach items="${company.address_location}"
																var="address">
																<div>
																	<div
																		class="fw-semibold mb-1 d-flex align-items-center gap-2">
																		<i class="ki-duotone ki-map me-2 fs-1"> <span
																			class="path1"></span> <span class="path2"></span> <span
																			class="path3"></span>
																		</i> <span>${address.address_name}</span>
																	</div>
																	<div class="text-gray-700 fs-6 lh-lg">${address.address}</div>
																</div>
															</c:forEach>

														</c:when>

														<c:otherwise>
															<div class="d-flex justify-content-center">
																<div class="text-muted">-</div>
															</div>
														</c:otherwise>

													</c:choose>




												</div>
											</td>

											<td>
												<div class="d-flex flex-column gap-6 ">
													<c:choose>
														<c:when test="${not empty company.company_contact}">
															<c:forEach items="${company.company_contact}"
																var="contact">
																<div class="d-flex gap-2">
																	<i class="ki-duotone ki-user-square fs-2"> <span
																		class="path1"></span> <span class="path2"></span> <span
																		class="path3"></span>
																	</i> <span>${contact.title_name_en}
																		${contact.contact_name}</span>
																</div>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<div class="d-flex justify-content-center">
																<span class="text-muted fs-1">-</span>
															</div>
														</c:otherwise>

													</c:choose>
												</div>


											</td>

											<td class="text-center">

												<div
													class="form-check form-check-custom form-check-solid justify-content-center">

													<input class="form-check-input" type="checkbox" disabled
														<c:if test="${company.is_active eq '1'}">checked</c:if>>

												</div>

											</td>

											<td>
												<div class="d-flex justify-content-center gap-3">

													<a href="company_edit?companyId=${company.company_id}"
														class="btn btn-icon btn-sm btn-light-primary mb-1 fs-3">

														<i class="ki-duotone ki-pencil fs-1"> <span
															class="path1"></span> <span class="path2"></span>
													</i>

													</a> <a href="delete_company?companyId=${company.company_id}"
														class="btn btn-icon btn-sm btn-light-danger mb-1 fs-3 me-1">

														<i class="ki-duotone ki-trash fs-1"> <span
															class="path1"></span> <span class="path2"></span> <span
															class="path3"></span> <span class="path4"></span> <span
															class="path5"></span>
													</i>

													</a>

												</div>
											</td>

										</tr>

									</c:forEach>

								</tbody>

							</table>
						</div>
					</div>

				</div>
				<!-- end::companyList -->

			</div>
		</div>

	</div>
	<script>
		$("#kt_datatable_zero_configuration").DataTable();
	</script>
</body>
</html>