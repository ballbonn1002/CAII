<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
				<div class="card mb-5">
					<div class="card-body">

						<div class="position-relative">
							<i
								class="ki-duotone ki-magnifier fs-3 text-gray-500 position-absolute top-50 translate-middle-y ms-4">
								<span class="path1"></span> <span class="path2"></span>
							</i> <input type="text" id="company-search"
								class="form-control form-control-lg ps-12" placeholder="Search" />
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
							<span id="itemsFound" class="me-2">Compana (${empty companyList ? 0 : fn:length(companyList)})
							</span>
						</h3>
					</div>

					<div class="d-flex align-items-center gap-3">
						<button class="btn btn-icon btn-light" id="toggle-card-view">
							<i class="ki-duotone ki-category fs-2"> <span class="path1"></span>
								<span class="path2"></span> <span class="path3"></span> <span
								class="path4"></span>
							</i>
						</button>

						<button class="btn btn-icon btn-primary me-3"
							id="toggle-table-view">
							<i class="ki-duotone ki-abstract-14 fs-2"> <span
								class="path1"></span> <span class="path2"></span>
							</i>
						</button>

						<div>
							<a href="${pageContext.request.contextPath}/company_add"
								class="btn btn-primary d-inline-flex align-items-center gap-2">
								<i class="ki-duotone ki-plus fs-5"> <span class="path1"></span>
									<span class="path2"></span>
							</i> <span class="fw-bold">Create</span>
							</a>
						</div>

					</div>
				</div>
				<!-- end::headerLine -->


				<!-- begin::companyList -->
				<div id="tableView">
					<div class="card">
						<div class="card-body">
							<div class="table-responsive">
								<table id="kt_datatable_zero_configuration"
									class="table table-row-bordered gy-5 table-striped align-middle">
									<thead>
										<tr class="text-muted text-uppercase text-gray-500">
											<th>#</th>
											<th>company name</th>
											<th>company code</th>
											<th>address location</th>
											<th>contact company</th>
											<th class="text-center">is active</th>
											<th class="text-center">action</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach items="${companyList}" var="company"
											varStatus="status">

											<tr data-company-id="${company.company_id}">

												<td>${company.company_id}</td>

												<td>
													<div class="d-flex align-items-center">

														<div class="symbol symbol-40px symbol-circle me-3">

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
																<div class="d-flex justify-content-start ps-2">
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
																<div class="d-flex justify-content-start ps-2">
																	<span class="text-muted">-</span>
																</div>
															</c:otherwise>

														</c:choose>
													</div>


												</td>

												<td class="text-center">

													<div
														class="form-check form-check-custom form-check-solid justify-content-center">

														<input class="form-check-input js-isactive-input" type="checkbox" data-company-id="${company.company_id}" 
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

														</a>
														<button type="button"
															onclick="confirmDelete('delete_company?companyId=${company.company_id}')"
															class="btn btn-icon btn-sm btn-light-danger mb-1 fs-3 me-1">

															<i class="ki-duotone ki-trash fs-1"> <span
																class="path1"></span> <span class="path2"></span> <span
																class="path3"></span> <span class="path4"></span> <span
																class="path5"></span>
															</i>

														</button>
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

				<div id="cardView" class="d-none">
					<div
						class="d-flex justify-content-center align-items-center <c:if test="${not empty companyList }">d-none</c:if> js-not-found"
						style="height: 200px;">
						<span class="text-muted fs-5">No matching records found</span>
					</div>

					<div class="row g-6">

						<c:forEach items="${companyList}" var="company">
							<div class="col-md-6 col-xl-4 mb-6 company-card"
								data-company-id="${company.company_id}">
								<!-- begin::Card -->
								<div class="card card-px-0 shadow-sm border border-gray-200">

									<!-- begin::Card Header -->
									<div class="card-header px-6 pt-4 pb-4">
										<div
											class="card-title w-100 d-flex justify-content-between align-items-start flex-nowrap">

											<!-- Company Info -->
											<div class="d-flex gap-2 me-3">

												<!-- Symbol/Logo -->
												<div class="symbol symbol-75px me-4">
													<c:choose>
														<c:when test="${not empty company.file_path}">
															<img
																src="${pageContext.request.contextPath}${company.file_path}"
																alt="${company.company_en}" />
														</c:when>
														<c:otherwise>
															<div
																class="symbol-label fs-3 fw-bold bg-light-primary text-primary">
																${fn:toUpperCase(fn:substring(company.company_en, 0, 1))}
															</div>
														</c:otherwise>
													</c:choose>
												</div>

												<!-- Company Name & Code -->
												<div class="d-flex flex-column mt-1">
													<a href="company_edit?companyId=${company.company_id}"
														class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">
														${company.company_en} </a> <span
														class="fs-7 fw-semibold text-muted">${company.company_code}</span>
												</div>

											</div>

										</div>

										<!-- Address Section -->
										<%-- <div class="mt-3 d-flex flex-column gap-5 mb-6">
											<div class="d-flex gap-2">
												<i class="ki-duotone ki-credit-cart fs-2"> <span
													class="path1"></span> <span class="path2"></span>
												</i> <span class="fw-medium text-gray-700">${company.tax_number}</span>
											</div>
											<c:if test="${not empty company.address_location}">
												<div class="d-flex flex-column gap-3">
													<c:forEach items="${company.address_location}"
														var="address">
														<div class="d-flex gap-2 align-items-center">
															<i class="ki-duotone ki-map fs-2"> <span
																class="path1"></span> <span class="path2"></span> <span
																class="path3"></span>
															</i> <span class="fw-medium text-gray-700">${address.address_name}</span>
														</div>

														<div class="ps-8">
															<span class="text-gray-500">${address.address}</span>
														</div>
													</c:forEach>
												</div>
											</c:if>
										</div> --%>

										<div class="mt-3 d-flex flex-column gap-5 mb-6">

											<div class="d-flex gap-2">
												<i class="ki-duotone ki-credit-cart fs-2"> <span
													class="path1"></span> <span class="path2"></span>
												</i> <span class="fw-medium text-gray-700">${company.tax_number}</span>
											</div>

											<c:choose>

												<c:when test="${not empty company.address_location}">
													<div class="d-flex flex-column gap-3">

														<c:forEach items="${company.address_location}"
															var="address">

															<div class="d-flex gap-2 align-items-center">
																<i class="ki-duotone ki-map fs-2"> <span
																	class="path1"></span> <span class="path2"></span> <span
																	class="path3"></span>
																</i> <span class="fw-medium text-gray-700">
																	${address.address_name} </span>
															</div>

															<div class="ps-8">
																<span class="text-gray-500"> ${address.address} </span>
															</div>

														</c:forEach>

													</div>
												</c:when>

												<c:otherwise>

													<div class="d-flex gap-2 align-items-center">
														<i class="ki-duotone ki-map fs-2"> <span
															class="path1"></span> <span class="path2"></span> <span
															class="path3"></span>
														</i> <span class="text-gray-700 fw-medium"> - </span>
													</div>

												</c:otherwise>

											</c:choose>

										</div>
									</div>
									<!-- end::Card Header -->

									<!-- begin::Card Body -->
									<%-- <div class="card-body py-3 px-6">
										<!-- Contacts Section -->
										<div class="mb-4">
											<c:choose>
												<c:when test="${not empty company.company_contact}">
													<div class="fw-medium text-gray-700 mb-2">
														Contact ( ${ fn:length(company.company_contact)} )
													</div>
													<div class="d-flex flex-column gap-2">
														<c:forEach items="${company.company_contact}"
															var="contact">
															<div class="d-flex align-items-center fs-6 text-gray-700">
																<i
																	class="ki-duotone ki-user-square fs-2 me-2 text-gray-500">
																	<span class="path1"></span> <span class="path2"></span>
																	<span class="path3"></span>
																</i> <span class="fw-medium">
																	${contact.title_name_en} ${contact.contact_name} </span>
															</div>
														</c:forEach>
													</div>
												</c:when>
												<c:otherwise>
													<span class="text-gray-400 fs-6 italic">No contacts
														added</span>
												</c:otherwise>
											</c:choose>
										</div>
									</div> --%>

									<div class="card-body py-5 px-6">

										<%-- 	<c:choose>
											<c:when test="${not empty company.company_contact}"> --%>

										<!-- Header -->
										<div
											class="d-flex justify-content-between align-items-center cursor-pointer rotate collapsed collapsible "
											data-bs-toggle="collapse"
											data-bs-target="#contactCollapse${company.company_id}">

											<div class="fw-medium text-gray-700">Contact (
												${fn:length(company.company_contact)} )</div>

											<span class="rotate-n180"> <i
												class="ki-duotone ki-down fs-3"> <span class="path1"></span>
													<span class="path2"></span>
											</i>
											</span>


										</div>

										<!-- Collapse Content -->
										<div class="collapse mt-6 pb-3"
											id="contactCollapse${company.company_id}">

											<div class="d-flex flex-column gap-6">

												<c:forEach items="${company.company_contact}" var="contact"
													varStatus="loop">

													<div class="d-flex align-items-center">
														<!-- Avatar -->
														<div class="symbol symbol-40px symbol-circle me-3">

															<c:choose>
																<c:when test="${not empty contact.file_path}">
																	<img
																		src="${pageContext.request.contextPath}${contact.file_path}">
																</c:when>

																<c:otherwise>
																	<div
																		class="symbol-label bg-light-primary text-primary fw-bold">
																		${fn:substring(contact.contact_name,0,1)}</div>
																</c:otherwise>
															</c:choose>

														</div>

														<!-- Contact Info -->
														<div class="d-flex flex-column">

															<span class="fw-medium text-gray-800 ">
																${contact.title_name_en} ${contact.contact_name} </span> <span
																class="text-muted fs-7"> ${contact.position} </span>

														</div>

													</div>

													<!-- Separator ยกเว้นคนสุดท้าย -->
													<c:if test="${!loop.last}">
														<div class="separator separator-solid border-1"></div>
													</c:if>

												</c:forEach>

											</div>

										</div>

										<%-- </c:when> --%>

										<%-- <c:otherwise>

												<div class="text-muted">Contact (0)</div>

											</c:otherwise> --%>

										<%-- </c:choose> --%>

									</div>
									<!-- end::Card Body -->

									<!-- begin::Card Footer -->
									<div
										class="card-footer px-6 d-flex justify-content-between align-items-center pt-4 pb-6">
										<!-- Status Badge -->
										<%-- 										<span
											class="badge ${company.is_active eq '1' ? 'badge-light-success text-success' : 'badge-light-danger text-danger'} fw-bold px-4 py-2">
											<span
											class="bullet bullet-dot ${company.is_active eq '1' ? 'bg-success' : 'bg-danger'} me-2"></span>
											${company.is_active eq '1' ? 'Active' : 'Inactive'}
										</span> --%>

										<div
											class="form-check form-check-custom form-check-solid form-check-sm">
											<input class="form-check-input js-isactive-input" type="checkbox" data-company-id="${company.company_id}"
												<c:if test="${company.is_active eq '1'}">checked</c:if>>
											<span class="ms-3 text-gray-700 fw-medium">Is Active</span>
										</div>

										<!-- Action Buttons -->
										<div class="d-flex">
											<a href="company_edit?companyId=${company.company_id}"
												class="btn btn-sm btn-light-primary me-2"> <i
												class="ki-duotone ki-pencil fs-4 me-1"> <span
													class="path1"></span><span class="path2"></span>
											</i> Edit
											</a>
											<button type="button"
												class="btn btn-sm btn-light-danger btn-active-danger"
												onclick="confirmDelete('delete_company?companyId=${company.company_id}')">
												<i class="ki-duotone ki-trash fs-4 me-1"> <span
													class="path1"></span><span class="path2"></span><span
													class="path3"></span><span class="path4"></span><span
													class="path5"></span>
												</i> Delete
											</button>
										</div>
									</div>
									<!-- end::Card Footer -->

								</div>
								<!-- end::Card -->
							</div>
						</c:forEach>

					</div>
				</div>

				<!-- end::companyList -->

			</div>
		</div>

	</div>
	<script>

		$(document).ready(function() {

			const table = $("#kt_datatable_zero_configuration").DataTable({
				columnDefs : [ {
					targets : [ 5, 6 ],
					orderable : false
				} ]
			});
			
			const isActiveInputs = $(".js-isactive-input");

			$("#company-search").on("keyup", function() {

				const keyword = $(this).val().toLowerCase();


					table.search(keyword).draw();
					
					const count = table.rows({ filter: 'applied' }).count();
					$("#itemsFound").text(`Company (\${count})`);

					syncCardView(table, count);
			});
			
			$(document).on("change", ".js-isactive-input", function () {
			    const checkbox = $(this);
			    const companyId = checkbox.data("company-id");
			    const prevChecked = !checkbox.is(":checked"); 

			    Swal.fire({
			        title: "Update status?",
			        text: "Do you want to change active status?",
			        icon: "warning",
			        showCancelButton: true,
			        confirmButtonText: "Yes",
			        cancelButtonText: "Cancel",
			        reverseButtons: true,
			        buttonsStyling: false,
			        customClass: {
			            confirmButton: "btn btn-success",
			            cancelButton: "btn btn-light"
			        }
			    }).then((result) => {
			        if (!result.isConfirmed) {
			            checkbox.prop("checked", prevChecked);
			            return;
			        }

			        Swal.fire({
			            title: "Updating...",
			            text: "Please wait",
			            allowOutsideClick: false,
			            allowEscapeKey: false,
			            showConfirmButton: false,
			            didOpen: () => {
			                Swal.showLoading();
			            }
			        });

			        $.ajax({
			            url: "update_company_status",
			            type: "POST",
			            dataType: "json",
			            data: {
			                companyId: companyId
			            },
			            success: function (res) {
			                Swal.close();

			                if (res.success) {
			                    $(`.js-isactive-input[data-company-id='\${companyId}']`).each(function () {
									console.log("test")
			                        $(this).prop("checked", res.isActive === "1" || res.isActive === 1);
			                    });

			                    Swal.fire({
			                        icon: "success",
			                        title: "Updated",
			                        text: "Status updated successfully.",
			                        buttonsStyling: false,
			                        customClass: {
			                            confirmButton: "btn btn-success"
			                        }
			                    });
			                } else {
			                    checkbox.prop("checked", prevChecked);

			                    Swal.fire({
			                        icon: "error",
			                        title: "Error",
			                        text: res.message || "Cannot update status",
			                        buttonsStyling: false,
			                        customClass: {
			                            confirmButton: "btn btn-danger"
			                        }
			                    });
			                }
			            },
			            error: function (xhr) {
			                Swal.close();
			                checkbox.prop("checked", prevChecked);

			                Swal.fire({
			                    icon: "error",
			                    title: "Error",
			                    text: xhr.responseJSON?.message || "Cannot update status",
			                    buttonsStyling: false,
			                    customClass: {
			                        confirmButton: "btn btn-danger"
			                    }
			                });
			            }
			        });
			    });
			});

			$("#toggle-card-view").on("click", function() {

				$("#tableView").addClass("d-none");
				$("#toggle-table-view").removeClass("btn-primary").addClass("btn-light");
				
				$("#cardView").removeClass("d-none");
				$(this).removeClass("btn-light").addClass("btn-primary");
			});
			
			$("#toggle-table-view").on("click", function() {

				$("#cardView").addClass("d-none");
				$("#toggle-card-view").removeClass("btn-primary").addClass("btn-light");
				
				$("#tableView").removeClass("d-none");
				$(this).removeClass("btn-light").addClass("btn-primary");
			});

		});
		
		function syncCardView(table, count) {
		    $(".company-card").hide();
		    console.log("Count: " + count);
		    if (count === 0) {
                $(".js-not-found").removeClass('d-none');
            } else {
                $(".js-not-found").addClass('d-none');
            }
		    table.rows({ search: "applied" }).every(function () {

		        const rowNode = $(this.node());
		        const companyId = rowNode.data("company-id");

		        $('.company-card[data-company-id="' + companyId +'"]').show();
		    });
		}
		
		function confirmDelete(url) {

		    Swal.fire({
		        icon: 'warning',
		        title: 'Delete Company',
		        text: 'Are you sure you want to delete this company?',
		        showCancelButton: true,
/* 		        confirmButtonColor: '#f1416c', */
		        confirmButtonText: 'Yes, Delete',
		        cancelButtonText: 'Cancel',
		        buttonsStyling: false,

		        customClass: {
		            confirmButton: 'btn btn btn-danger px-3',
		            cancelButton: 'btn btn btn-light'
		        },
		        focusConfirm: false,
		        focusCancel: false,
		        reverseButtons: true
		    }).then((result) => {

		    	if (result.isConfirmed) {

		    	    $.ajax({

		    	        url: url,
		    	        type: "POST",

		    	        beforeSend: function () {

		    	            Swal.fire({
		    	                title: 'Deleting...',
		    	                text: 'Please wait',
		    	                allowOutsideClick: false,
		    	                allowEscapeKey: false,
		    	                showConfirmButton: false,
		    	                didOpen: () => {
		    	                    Swal.showLoading();
		    	                }
		    	            });

		    	        },

		    	        success: function () {

		    	            Swal.fire({
		    	                icon: 'success',
		    	                title: 'Deleted',
		    	                text: 'Company deleted successfully'
		    	            }).then(() => {
		    	                location.reload();
		    	            });

		    	        },

		    	        error: function () {

		    	            Swal.fire({
		    	                icon: 'error',
		    	                title: 'Error',
		    	                text: 'Cannot delete company'
		    	            });

		    	        }

		    	    });

		    	}

		    });
		}

	</script>
</body>
</html>