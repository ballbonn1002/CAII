<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">

	<title>Contact</title>

	<!-- Metronic core -->
	<link
		href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
		rel="stylesheet"
		type="text/css" />


	<!-- DataTables -->
	<link
		href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css"
		rel="stylesheet" type="text/css" />

	<script
		src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js">

	</script>

<!-- SweetAlert -->
	<link
		rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js">
	</script>
	
</head>

<style>
#contact_table thead th {
	font-weight: 600 !important;
	white-space: nowrap;
	vertical-align: middle;
}
#contact_table tbody td {
	vertical-align: middle;
	padding-top: 20px;
	padding-bottom: 20px;
}
#contact_table th:nth-child(1),
#contact_table td:nth-child(1) {
	width: 70px;
	padding-left: 16px !important;
}
#contact_table th:nth-child(2) { width: 200px; }
#contact_table th:nth-child(3) { width: 150px; padding-right: 50px !important; }
#contact_table th:nth-child(5) { width: 300px; }
#contact_table th:nth-child(6) { width: 100px; }
#contact_table th:nth-child(7) { width: 120px; }
#contact_table thead th .dt-column-header {
	display: inline-flex !important;
	flex-direction: row !important;
	align-items: center !important;
}
#contact_table thead th .dt-column-order {
	margin: 0 !important;
}

#contact_table th:nth-child(1),
#contact_table td:nth-child(1) {
	text-align: left !important;
}
</style>

<body>

	<!-- Main -->
	<div class="app-container container-fluid">

		<!-- Toolbar -->
				<div class="page-title position-relative mb-5" style="z-index: 5;">

			<h1 class="page-heading text-gray-700 fw-semibold">
				Contact
			</h1>

						<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
				<li class="breadcrumb-item text-muted">
					<a href="${pageContext.request.contextPath}/check_in_out"
						class="text-muted text-hover-primary">Home</a>
				</li>
				<li class="breadcrumb-item">
					<span class="bullet bg-gray-500 w-5px h-2px"></span>
				</li>
				  <li class="breadcrumb-item text-muted">
					<a class="text-muted ">Contact</a>
				</li>
			</ul>

		</div>
		

		<!-- Search -->
		<div class="card shadow-sm mb-5">

			<div class="card-body">

				<div class="position-relative">

					<i
						class="ki-duotone ki-magnifier fs-2 position-absolute ms-5 top-50 translate-middle-y text-gray-500">
						<span class="path1"></span>
						<span class="path2"></span>
					</i>

					<input
						type="text"
						id="search_contact"
						class="form-control ps-15 py-4"
						placeholder="Search">

				</div>

			</div>

		</div>

		<!-- Contact title -->
		<div class="d-flex justify-content-between align-items-center mt-8 mb-6">

			<h3 class="fw-semibold text-gray-900 mb-0">
				Contact (<span id="contact_count">0</span>)
			</h3>

			<div class="d-flex align-items-center gap-3">

				<!-- Grid View -->
				<button
					type="button"
					id="btnGridView"
					class="btn btn-icon btn-light-primary view-toggle-button"
					title="Grid View">

					<i class="ki-outline ki-element-plus fs-2"></i>

				</button>

				<!-- Table View -->
				<button
					type="button"
					id="btnTableView"
					class="btn btn-icon btn-primary"
					title="Table View">

					<i class="ki-duotone ki-row-horizontal fs-2">
						<span class="path1"></span>
						<span class="path2"></span>
						<span class="path3"></span>
					</i>

				</button>

				<!-- Create -->
				<button
					type="button"
					class="btn btn-primary"
					id="create_contact">

					<i class="ki-duotone ki-plus fs-2"></i>
					Create

				</button>

			</div>

		</div>

		<!-- Contact content -->
				<div class="card shadow-sm" id="contactContentCard">

			<div class="card-body" id="contactContentBody">
		     <div>

				<!-- Grid View -->
				<div
					id="gridViewContainer"
					class="row g-6 d-none">
				</div>

				<!-- Table View -->
				<div
					id="tableViewContainer"
					class="table-responsive">

					<table
                        id="contact_table"
                        class="table table-striped table-row-bordered table-row-gray-200 gy-5 align-middle table-hover">
						<thead>
										<tr class="text-muted text-uppercase text-gray-500 fw-bold text-nowrap">
											<th>#</th>
											<th>company name</th>
											<th>company </th>
											<th>address location</th>
											<th>contact company</th>
											<th class="text-center">is active</th>
											<th class="text-center">action</th>
										</tr>
									</thead>

						<tbody id="contact_table_body">

							<c:forEach
								var="contact"
								items="${contactList}"
								varStatus="status">

								<tr
									class="contact-row"
									data-id="${contact.company_contact_id}"
									data-company-id="${fn:escapeXml(contact.company_id)}"
									data-company-code="${fn:escapeXml(contact.companyCode)}"
									data-tax="${fn:escapeXml(contact.taxNumber)}"
									data-company-active="${contact.companyActive}"
									data-title="${fn:escapeXml(contact.title_name_en)}">

									<!-- Number -->
									<td class="row-number">
										${status.count}
									</td>

									<!-- Company Name -->
									<td>

										<div class="d-flex align-items-center gap-3">

											<c:choose>
												<c:when test="${not empty contact.file_path}">
													<img src="${pageContext.request.contextPath}${contact.file_path}"
														class="rounded-circle flex-shrink-0" width="42" height="42"
														style="object-fit:cover; object-position: center top;"
														alt="Profile">
												</c:when>
												<c:otherwise>
													<div class="symbol symbol-circle symbol-40px flex-shrink-0">
														<span class="symbol-label bg-light-primary text-primary fw-bold fs-5">
															<c:choose>
																<c:when test="${not empty contact.contact_name}">
																	${fn:toUpperCase(fn:substring(contact.contact_name, 0, 1))}
																</c:when>
																<c:when test="${not empty contact.contact_name_th}">
																	${fn:substring(contact.contact_name_th, 0, 1)}
																</c:when>
																<c:otherwise>?</c:otherwise>
															</c:choose>
														</span>
													</div>
												</c:otherwise>
											</c:choose>

											<div class="min-w-0">

												<div class="fw-medium text-gray-800 contact-name">

													<c:choose>

														<c:when test="${not empty contact.contact_name}">
															<c:out value="${contact.contact_name}" />
														</c:when>

														<c:otherwise>
															<c:out value="${contact.contact_name_th}" />
														</c:otherwise>

													</c:choose>

												</div>

												<div class="text-muted fs-7 contact-position">
													<c:out value="${contact.position}" />
												</div>

											</div>

										</div>

									</td>

									<!-- Company -->
									<td>

										<div class="d-flex align-items-center gap-3">

												<c:choose>
													<c:when test="${not empty contact.company_logo_path}">
														<div class="symbol symbol-35px flex-shrink-0">
	                                                      <img src="${contact.company_logo_path}" alt="Company" style="object-fit: contain;">
                                                        </div>
													</c:when>
													<c:otherwise>
														<div class="symbol symbol-35px flex-shrink-0">
															<span
																class="symbol-label bg-light-primary text-primary fw-bold fs-7">
																<c:choose>
																	<c:when test="${not empty contact.companyEn}">
                                                                       ${fn:toUpperCase(fn:substring(contact.companyEn, 0, 1))}
                                                                    </c:when>
																	<c:when test="${not empty contact.company_id}">
                                                                       ${fn:toUpperCase(fn:substring(contact.company_id, 0, 1))}
                                                                    </c:when>
																	<c:otherwise>?</c:otherwise>
																</c:choose>
															</span>
														</div>
													</c:otherwise>
												</c:choose>

												<span class="text-gray-700 contact-company">

												<c:choose>

													<c:when test="${not empty contact.companyEn}">
														<c:out value="${contact.companyEn}" />
													</c:when>

													<c:otherwise>
														<c:out value="${contact.company_id}" />
													</c:otherwise>

												</c:choose>

											</span>

										</div>

									</td>

									<!-- Address -->
									<td>

										<div class="d-flex align-items-center mb-3 ">

											<i
												class="ki-duotone ki-map fs-2x text-gray-400 me-4 mt-1">

												<span class="path1"></span>
												<span class="path2"></span>

											</i>

											<span class="fw-medium text-gray-700 contact-branch">

												<c:choose>

													<c:when test="${not empty contact.address_name}">
													<c:out value="${contact.address_name}" />
												</c:when>
													
													 

													<c:otherwise>
														-
													</c:otherwise>

												</c:choose>

											</span>

										</div>

										<div class="text-muted fs-7 lh-lg contact-address">

											<c:choose>

												<c:when test="${not empty contact.companyAddress}">
                                                <c:out value="${contact.companyAddress}" />
                                            </c:when>
												
												
												

												<c:otherwise>
											          -
												</c:otherwise>

											</c:choose>

										</div>

									</td>

									<!-- Contact -->
									<td>

										<div class="d-flex align-items-center mb-3">

											<i class="ki-duotone ki-phone fs-3 text-gray-400 me-3">

												<span class="path1"></span>
												<span class="path2"></span>

											</i>

											<span class="text-gray-700 contact-phone">

												<c:choose>

													<c:when test="${not empty contact.phone}">
														<c:out value="${contact.phone}" />
													</c:when>

													<c:otherwise>
														-
													</c:otherwise>

												</c:choose>

											</span>

										</div>

										<div class="d-flex align-items-center mb-3">

											<i class="ki-duotone ki-sms fs-3 text-gray-400 me-3">

												<span class="path1"></span>
												<span class="path2"></span>

											</i>

											<span class="text-gray-700 contact-email">

												<c:choose>

													<c:when test="${not empty contact.email}">
														<c:out value="${contact.email}" />
													</c:when>

													<c:otherwise>
														-
													</c:otherwise>

												</c:choose>
												
												

											</span>

										</div>

									</td>

									<!-- Active -->
									<td class="text-center">
									
									
                                        <div class="form-check form-check-custom form-check-solid justify-content-center">
										<input										
											type="checkbox"
											class="form-check-input js-isactive-input contact-active"
											data-id="${contact.company_contact_id}"
											<c:if test="${contact.is_active eq '1'}">
												checked
											</c:if>>
											
											</div>

									</td>

									<!-- Action -->
									<td>

										<div class="d-flex justify-content-center gap-2 flex-nowrap">

											<button type="button"
												class="btn btn-icon btn-light-primary btn-sm edit-contact"
												data-id="${contact.company_contact_id}">
												

												<i class="ki-duotone ki-pencil fs-3"> <span
													class="path1"></span> <span class="path2"></span>

												</i>

											</button>

											<button
												type="button"
												class="btn btn-icon btn-light-danger btn-sm delete-contact"
												data-id="${contact.company_contact_id}"
												title="Delete">

												<i class="ki-duotone ki-trash fs-3">

													<span class="path1"></span>
													<span class="path2"></span>
													<span class="path3"></span>
													<span class="path4"></span>
													<span class="path5"></span>

												</i>

											</button>

										</div>

									</td>

								</tr>

							</c:forEach>

						</tbody>

					</table>

				</div>

			

				<!-- Footer -->
				<div class="d-flex justify-content-between align-items-center mt-5 w-100">

					<select
						id="page_size"
						class="form-select form-select-sm w-80px">

						<option value="10">
							10
						</option>

						<option value="25" selected>
							25
						</option>

						<option value="50">
							50
						</option>

						<option value="100">
							100
						</option>

					</select>

					<div
						id="tablePagination"
						class="d-flex justify-content-end ms-auto">
					</div>

				</div>

			</div>

		</div>

	</div>

</div>

	<script type="text/javascript">

	$(document).ready(function () {
	    const table = $('#contact_table').DataTable({
	        dom: "rt",
	        paging: false,
	        ordering: true,
	        searching: true,
	        autoWidth: true,
	        columnDefs: [
	            { orderable: false, targets: [5,6] },
	            { orderable: true, targets: [0, 1, 2, 3 ,4 ,5] }
	        ],
	        order: [],
	        headerCallback: function (thead) {
	            $(thead).find('.dt-column-header').addClass('d-inline-flex align-items-center');
	            $(thead).find('.dt-column-order').addClass('m-0');
	        }

	    });

	    let currentPage = 1;      
	    let rowsPerPage = Number($("#page_size").val()) || 25;
	    let searchKeyword = "";
	    let isGridView = false;

			/*
			 * ป้องกัน HTML ที่อ่านมาจาก Table
			 * ก่อนนำไปสร้าง Grid Card
			 */
			function escapeHtml(value) {

				return $("<div>")
					.text(value == null ? "" : String(value))
					.html();

			}
			
			
			
			/*
			 * เรียงแถวตาม data-id (companyContactId) จากน้อยไปมาก
			 * แล้วอัปเดตแค่เลขลำดับที่แสดงผล (คอลัมน์ #) ให้ตรงกับ
			 * ลำดับใหม่เท่านั้น

			 */
			function syncRowIds() {

			    const $container = $(".contact-row").parent();

			
			    const rows = $(".contact-row").get().sort(function (a, b) {
			        return Number($(a).attr("data-id")) - Number($(b).attr("data-id"));
			    });

			    
			    $container.append(rows);

			   
			    $(".contact-row").each(function (index) {

			        $(this)
			            .find(".row-number")
			            .text(index + 1);

			    });

			}

			/*
			 * คืนค่าเฉพาะแถวที่ตรงกับคำค้นหา
			 */
			function getFilteredRows() {

				return $(".contact-row").filter(function () {

					const rowText = $(this)
						.text()
						.toLowerCase();

					return rowText.indexOf(searchKeyword) !== -1;

				});

			}
			/*
			 * Grid View: 1 การ์ดต่อ 1 บริษัท (เหมือนการ์ดหน้า Company)
			 */
				function buildGridCards($rows) {

					const $gridContainer = $("#gridViewContainer");
					const ctx = "${pageContext.request.contextPath}";

					$rows = $rows || getFilteredRows();
					$gridContainer.empty();

					// ---------- 1) จัดกลุ่มตามบริษัท ----------
					const groups = [];
					const groupMap = {};

					$rows.each(function () {

						const $row = $(this);
						const $cells = $row.children("td");

						const company   = $row.find(".contact-company").text().trim() || "-";
						const companyId = String($row.attr("data-company-id") || "");
						const key = companyId || company.toLowerCase();
						const $logoImg = $cells.eq(2).find("img").first();

						if (!groupMap[key]) {
							groupMap[key] = {
								companyId:   companyId,
								company:     company,
								companyCode: $row.attr("data-company-code") || "",
								tax:         $row.attr("data-tax") || "",
								active:      $row.attr("data-company-active") === "1",
								logo:        $logoImg.length ? ($logoImg.attr("src") || "") : "",
								addresses: [], addressKeys: {}, contacts: []
							};
							groups.push(groupMap[key]);
						}
						const g = groupMap[key];

						const branch  = $row.find(".contact-branch").text().trim();
						const address = $row.find(".contact-address").text().trim();
						if (branch && branch !== "-" && !g.addressKeys[branch + "|" + address]) {
							g.addressKeys[branch + "|" + address] = true;
							g.addresses.push({ name: branch, address: address });
						}

						const name = $row.find(".contact-name").text().trim();
						const $photo = $cells.eq(1).find("img").first();

						g.contacts.push({
							id:       String($row.attr("data-id") || ""),
							name:     name,
							title:    $row.attr("data-title") || "",
							position: $row.find(".contact-position").text().trim(),
							phone:    $row.find(".contact-phone").text().trim(),
							email:    $row.find(".contact-email").text().trim(),
							branch:   branch,
							address:  address,
							isActive: $row.find(".contact-active").is(":checked"),
							photo:    $photo.length ? ($photo.attr("src") || "") : "",
							initial:  $cells.eq(1).find(".symbol-label").first().text().trim()
							          || (name.charAt(0) || "?").toUpperCase()
						});
					});

					// ---------- 2) สร้างการ์ดบริษัท ----------
					groups.forEach(function (g, gi) {

						const logoHtml = g.logo
							? '<img src="' + escapeHtml(g.logo) + '" style="object-fit: contain;" />'
							: '<div class="symbol-label fs-3 fw-bold bg-light-primary text-primary">' +
							      escapeHtml((g.company.charAt(0) || "?").toUpperCase()) + '</div>';

						// ที่อยู่บริษัท
						let addressHtml = "";
						if (g.addresses.length) {
							g.addresses.forEach(function (a) {
								addressHtml +=
									'<div>' +
										'<div class="d-flex gap-2 align-items-center">' +
											'<i class="ki-duotone ki-map fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>' +
											'<span class="fw-medium text-gray-700">' + escapeHtml(a.name) + '</span>' +
										'</div>' +
										'<div class="ps-8 mt-1"><span class="text-gray-500" style="overflow-wrap:anywhere;">' + escapeHtml(a.address || "-") + '</span></div>' +
									'</div>';
							});
						} else {
							addressHtml =
								'<div class="d-flex gap-2 align-items-center">' +
									'<i class="ki-duotone ki-map fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>' +
									'<span class="text-gray-700 fw-medium">-</span>' +
								'</div>';
						}

						// รายชื่อ contact (ข้อมูลครบแบบการ์ด contact เดิม)
												// รายชื่อ contact (แบบหน้า Company)
						let contactsHtml = "";
						g.contacts.forEach(function (c, i) {

							const avatarHtml = c.photo
								? '<img src="' + escapeHtml(c.photo) + '" style="object-fit: cover; object-position: center top;">'
								: '<div class="symbol-label bg-light-primary text-primary fw-bold">' + escapeHtml(c.initial) + '</div>';

							contactsHtml +=
								'<div class="d-flex align-items-center contact-grid-item" data-id="' + escapeHtml(c.id) + '">' +
									'<div class="symbol symbol-40px symbol-circle me-3">' + avatarHtml + '</div>' +
									'<div class="d-flex flex-column">' +
										'<span class="fw-medium text-gray-800">' + escapeHtml(((c.title ? c.title + " " : "") + (c.name || "-"))) + '</span>' +
										'<span class="text-muted fs-7">' + escapeHtml(c.position || "") + '</span>' +
									'</div>' +
								'</div>' +
								(i < g.contacts.length - 1 ? '<div class="separator separator-solid border-1"></div>' : '');
						});
						

						// ท้ายการ์ด (ของบริษัท)
						const footerHtml = g.companyId
							? '<div class="card-footer px-6 d-flex justify-content-between align-items-center py-4">' +
								'<label class="form-check form-check-custom form-check-solid form-check-sm">' +
									'<input class="form-check-input grid-company-active" type="checkbox" data-company-id="' + escapeHtml(g.companyId) + '"' + (g.active ? ' checked' : '') + '>' +
									'<span class="ms-3 text-gray-700 fw-medium">Is Active</span>' +
								'</label>' +
								'<div class="d-flex">' +
								'<a href="' + ctx + '/contact_add.action?id=' + encodeURIComponent(g.contacts[0].id) + '" class="btn btn-sm btn-light-primary me-2">' +
										'<i class="ki-duotone ki-pencil fs-4 me-1"><span class="path1"></span><span class="path2"></span></i> Edit</a>' +
									'<button type="button" class="btn btn-sm btn-light-danger grid-company-delete" data-company-id="' + escapeHtml(g.companyId) + '">' +
										'<i class="ki-duotone ki-trash fs-4 me-1"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i> Delete</button>' +
								'</div>' +
							  '</div>'
							: '';

						const collapseId = "contactGroupCollapse" + gi;

						const cardHtml =
							'<div class="col-md-6 col-xl-4">' +
							'<div class="card shadow-sm border border-gray-200">' +

								'<div class="card-body px-6 pt-6 pb-0">' +
									'<div class="d-flex align-items-start mb-5">' +
										'<div class="symbol symbol-60px me-4 flex-shrink-0">' + logoHtml + '</div>' +
										'<div class="d-flex flex-column">' +
											(g.companyId
													? '<a href="' + ctx + '/contact_add.action?id=' + encodeURIComponent(g.contacts[0].id) + '" class="fs-5 fw-bold text-gray-900 text-hover-primary mb-1">' + escapeHtml(g.company) + '</a>'
												: '<span class="fs-5 fw-bold text-gray-900 mb-1">' + escapeHtml(g.company) + '</span>') +
											'<span class="fs-7 fw-semibold text-muted">' + escapeHtml(g.companyCode) + '</span>' +
										'</div>' +
									'</div>' +
									'<div class="d-flex flex-column gap-4 pb-6">' +
										'<div class="d-flex gap-2 align-items-center">' +
											'<i class="ki-duotone ki-credit-cart fs-2"><span class="path1"></span><span class="path2"></span></i>' +
											'<span class="fw-medium text-gray-700">' + escapeHtml(g.tax || "-") + '</span>' +
										'</div>' +
										addressHtml +
									'</div>' +
								'</div>' +

								'<div class="border-top border-gray-200 px-6 py-5">' +
									'<div class="d-flex justify-content-between align-items-center cursor-pointer rotate collapsed" data-bs-toggle="collapse" data-bs-target="#' + collapseId + '">' +
										'<div class="fw-medium text-gray-700">Contact ( ' + g.contacts.length + ' )</div>' +
										'<span class="rotate-180"><i class="ki-duotone ki-down fs-3"><span class="path1"></span><span class="path2"></span></i></span>' +
									'</div>' +
									'<div class="collapse" id="' + collapseId + '">' +
									'<div class="d-flex flex-column gap-6 mt-6 pb-3">' + contactsHtml + '</div>' +
									'</div>' +
								'</div>' +

								footerHtml +

							'</div>' +
							'</div>';

						$gridContainer.append(cardHtml);
					});
				}
			/*
			 * แสดงข้อมูลตามหน้าปัจจุบัน
			 */
			function showPage(page) {

				const $allRows = $(".contact-row");
				const $filteredRows = getFilteredRows();

				const totalRows = $filteredRows.length;

				const totalPages = Math.max(
					1,
					Math.ceil(totalRows / rowsPerPage)
				);

				currentPage = Math.min(
					Math.max(Number(page) || 1, 1),
					totalPages
				);

				const startIndex = (currentPage - 1) * rowsPerPage;
				const endIndex = startIndex + rowsPerPage;

				$allRows.hide();
				
				$allRows.removeClass("bg-light bg-white");

				$(".contact-grid-item").addClass("d-none");

				const $rowsOnCurrentPage = $filteredRows.slice(
						startIndex,
						endIndex
					);

					if (!isGridView) {

						$rowsOnCurrentPage.each(function () {
							$(this).show();
						});
						renderPagination(totalPages);

					} else {

						// Grid: 1 การ์ดต่อ 1 บริษัท แสดงทุกคนที่ค้นเจอ
						buildGridCards($filteredRows);
						renderPagination(1);

					}

					updateRowNumber($filteredRows);
					updateContactCount(totalRows);

				updateRowNumber($filteredRows);
				updateContactCount(totalRows);
				renderPagination(totalPages);

			}
			

			/*
			 * สร้าง Pagination
			 */
			function renderPagination(totalPages) {

				let html =
					'<ul class="pagination pagination-sm justify-content-end ' +
					'align-items-center flex-nowrap gap-1 mb-0">';

				html +=
					'<li class="page-item ' +
					(currentPage === 1 ? "disabled" : "") +
					'">' +

						'<button ' +
							'type="button" ' +
							'class="page-link" ' +
							'data-page="' + (currentPage - 1) + '" ' +
							'aria-label="Previous">' +

							'<i class="ki-duotone ki-left fs-3">' +
								'<span class="path1"></span>' +
								'<span class="path2"></span>' +
							'</i>' +

						'</button>' +

					'</li>';

				const windowSize = 5;

				let startPage = Math.max(
					1,
					currentPage - 2
				);

				let endPage = Math.min(
					totalPages,
					startPage + windowSize - 1
				);

				startPage = Math.max(
					1,
					endPage - windowSize + 1
				);

				if (startPage > 1) {

					html += createPageButton(1);

					if (startPage > 2) {

						html +=
							'<li class="page-item disabled">' +
								'<span class="page-link">...</span>' +
							'</li>';

					}

				}

				for (
					let pageNumber = startPage;
					pageNumber <= endPage;
					pageNumber++
				) {

					html += createPageButton(pageNumber);

				}

				if (endPage < totalPages) {

					if (endPage < totalPages - 1) {

						html +=
							'<li class="page-item disabled">' +
								'<span class="page-link">...</span>' +
							'</li>';

					}

					html += createPageButton(totalPages);

				}

				html +=
					'<li class="page-item ' +
					(currentPage === totalPages ? "disabled" : "") +
					'">' +

						'<button ' +
							'type="button" ' +
							'class="page-link" ' +
							'data-page="' + (currentPage + 1) + '" ' +
							'aria-label="Next">' +

							'<i class="ki-duotone ki-right fs-3">' +
								'<span class="path1"></span>' +
								'<span class="path2"></span>' +
							'</i>' +

						'</button>' +

					'</li>';

				html += "</ul>";

				$("#tablePagination").html(html);

			}

			/*
			 * ปุ่มเลขหน้า
			 */
			function createPageButton(pageNumber) {

				return (
					'<li class="page-item ' +
					(pageNumber === currentPage ? "active" : "") +
					'">' +

						'<button ' +
							'type="button" ' +
							'class="page-link" ' +
							'data-page="' + pageNumber + '">' +

							pageNumber +

						'</button>' +

					'</li>'
				);

			}

			/*
			 * จำนวน Contact
			 */
			function updateContactCount(count) {

				$("#contact_count").text(count);

				$("#no_contact").toggleClass(
					"d-none",
					count !== 0
				);

				$("#tablePagination").toggleClass(
					"d-none",
					count === 0
				);

			}

			/*
			 * เลขลำดับแถว
			 */
			function updateRowNumber($filteredRows) {

				$filteredRows.each(function (index) {

					$(this)
						.find(".row-number")
						.text(index + 1);

				});

			}

			/*
			 * Grid View
			 */
			$("#btnGridView").on("click", function () {

				isGridView = true;
				currentPage = 1;

				$("#tableViewContainer").addClass("d-none");
				$("#gridViewContainer").removeClass("d-none");

				// การ์ดลอยบนพื้นหลัง ไม่อยู่ในกล่องขาว
				$("#contactContentCard").addClass("bg-transparent shadow-none border-0");
				$("#contactContentBody").addClass("p-0");

				$("#btnGridView")
					.addClass("active btn-primary")
					.removeClass("btn-light-primary");

				$("#btnTableView")
					.removeClass("active btn-primary")
					.addClass("btn-light-primary");

				showPage(1);

			});

			/*
			 * Table View
			 */
			$("#btnTableView").on("click", function () {

				isGridView = false;
				currentPage = 1;

				$("#gridViewContainer").addClass("d-none");
				$("#tableViewContainer").removeClass("d-none");

				// กลับมาเป็นกล่องขาวครอบตาราง
				$("#contactContentCard").removeClass("bg-transparent shadow-none border-0");
				$("#contactContentBody").removeClass("p-0");

				$("#btnTableView")
					.addClass("active btn-primary")
					.removeClass("btn-light-primary");

				$("#btnGridView")
					.removeClass("active btn-primary")
					.addClass("btn-light-primary");

				showPage(1);

			});
			/*
			 * Pagination
			 */
			$(document).on(
				"click",
				"#tablePagination .page-link",
				function () {

					const $pageItem = $(this).closest(".page-item");

					if ($pageItem.hasClass("disabled")) {
						return;
					}

					const page = Number(
						$(this).attr("data-page")
					);

					if (Number.isInteger(page)) {
						showPage(page);
					}

				}
			);

			/*
			 * จำนวนแถวต่อหน้า
			 */
			$("#page_size").on("change", function () {

				const selectedSize = Number(
					$(this).val()
				);

				if (
					!Number.isInteger(selectedSize) ||
					selectedSize <= 0
				) {
					return;
				}

				rowsPerPage = selectedSize;
				currentPage = 1;

				showPage(1);

			});

			/*
			 * Search
			 */
			$("#search_contact").on("input", function () {

				searchKeyword = $(this)
					.val()
					.trim()
					.toLowerCase();

				currentPage = 1;

				showPage(1);

			});
			
			

			/*
			 * Create
			 */
			$("#create_contact").on("click", function () {

				window.location.href =
					"${pageContext.request.contextPath}/contact_add.action";

			});

			/*
			 * Edit
			 */
			$(document).on(
				"click",
				".edit-contact",
				function () {

					const id = String(
						$(this).attr("data-id") || ""
					);

					if (!id) {
						return;
					}

					window.location.href =
						"${pageContext.request.contextPath}/contact_add.action?id=" +
						encodeURIComponent(id);

				}
			);

			/*
			 * View
			 */
			$(document).on(
				"click",
				".view-contact",
				function () {

					const id = String(
						$(this).attr("data-id") || ""
					);

					if (!id) {
						return;
					}

					window.location.href =
						"${pageContext.request.contextPath}/contact_add.action?id=" +
						encodeURIComponent(id);

				}
			);

			/*
			 * Delete
			 */
			$(document).on(
				"click",
				".delete-contact",
				function () {

					const id = String(
						$(this).attr("data-id") || ""
					);

					if (!id) {
						return;
					}

					swal(
						{
							title: "ยืนยันการลบ",
							text: "คุณต้องการลบ Contact นี้หรือไม่",
							type: "warning",
							showCancelButton: true,
							confirmButtonText: "ใช่",
							cancelButtonText: "ไม่ใช่",
							closeOnConfirm: false
						},
						function (isConfirm) {

							if (!isConfirm) {
								return;
							}

							 $.ajax({
				                    url: "${pageContext.request.contextPath}/contact_delete.action",
				                    type: "POST",
				                    data: { companyContactId: id },
				                    success: function () {
				                        swal(
				                            {
				                                title: "สำเร็จ",
				                                text: "ลบ Contact เรียบร้อยแล้ว",
				                                type: "success"
				                            },
				                            function () {
				                                location.reload();
				                            }
				                        );
				                    },
				                    error: function () {
				                        swal("เกิดข้อผิดพลาด", "ไม่สามารถลบ Contact ได้", "error");
				                    }
				                });

				            }
				        );

				    }
				);

			/*
			 * บันทึกสถานะ Active/Inactive ของ Contact ลง Database
			 * ผ่าน AJAX (ไม่ต้อง Submit ทั้งฟอร์ม) ถ้าบันทึกไม่สำเร็จ
			 * ให้ Revert Checkbox กลับสถานะเดิม
			 */
			 function saveContactActiveStatus($checkbox, id, isActive) {

				    $.ajax({
				        url:
				            "${pageContext.request.contextPath}" +
				            "/contact_toggle_active.action",
				        method: "POST",
				        data: {
				            id: id,
				            activeFlag: isActive ? "1" : "0"
				        },
				        dataType: "json"
				    
				    }).done(function (response) {

				        if (response !== true) {

				            $checkbox.prop("checked", !isActive);

				            swal(
				                "Error",
				                "ไม่สามารถอัปเดตสถานะ Contact ได้",
				                "error"
				            );

				        } else {

				            if (window.toastr) {
				                toastr.success(
				                    isActive
				                        ? "เปิดใช้งาน"
				                        : "ปิดใช้งาน "
				                );
				            }

				        }

				    }).fail(function () {

				        $checkbox.prop("checked", !isActive);

				        swal(
				            "Error",
				            "ไม่สามารถอัปเดตสถานะ Contact ได้",
				            "error"
				        );

				    });

				}
			/*
			 * Active จาก Table ไป Grid
			 */
			$(document).on(
				"change",
				".contact-active",
				function () {

					const id = String(
						$(this).attr("data-id") || ""
					);

					const isActive = $(this).is(":checked");

					$("#gridViewContainer")
						.find(
							'.contact-grid-item[data-id="' + id + '"]'
						)
						.find(".grid-contact-active")
						.prop("checked", isActive);

					saveContactActiveStatus($(this), id, isActive);

				}
			);

			/*
			 * Active จาก Grid ไป Table
			 */
			$(document).on(
				"change",
				".grid-contact-active",
				function () {

					const id = String(
						$(this).attr("data-id") || ""
					);

					const isActive = $(this).is(":checked");

					$("#contact_table_body")
						.find(
							'.contact-row[data-id="' + id + '"]'
						)
						.find(".contact-active")
						.prop("checked", isActive);

					saveContactActiveStatus($(this), id, isActive);

				}
			);
			
			/*
			 * การ์ด: เปิด/ปิด Is Active ของบริษัท (ใช้ action เดียวกับหน้า Company)
			 */
			$(document).on("change", ".grid-company-active", function () {
				const $cb = $(this);
				const companyId = String($cb.attr("data-company-id") || "");
				const prev = !$cb.is(":checked");

				$.ajax({
					url: "${pageContext.request.contextPath}/update_company_status",
					type: "POST",
					dataType: "json",
					data: { companyId: companyId }
				}).done(function (res) {
					if (res && res.success) {
						const on = (res.isActive === "1" || res.isActive === 1);
						$('.contact-row[data-company-id="' + companyId + '"]').attr("data-company-active", on ? "1" : "0");
						$cb.prop("checked", on);
						if (window.toastr) { toastr.success(on ? "เปิดใช้งานบริษัท" : "ปิดใช้งานบริษัท"); }
					} else {
						$cb.prop("checked", prev);
						swal("Error", (res && res.message) || "ไม่สามารถอัปเดตสถานะบริษัทได้", "error");
					}
				}).fail(function () {
					$cb.prop("checked", prev);
					swal("Error", "ไม่สามารถอัปเดตสถานะบริษัทได้", "error");
				});
			});

			/*
			 * การ์ด: ลบบริษัท (ใช้ action เดียวกับหน้า Company)
			 */
			$(document).on("click", ".grid-company-delete", function () {
				const companyId = String($(this).attr("data-company-id") || "");

				swal({
					title: "ยืนยันการลบบริษัท",
					text: "ต้องการลบบริษัทนี้หรือไม่",
					type: "warning",
					showCancelButton: true,
					confirmButtonText: "ใช่",
					cancelButtonText: "ไม่ใช่",
					closeOnConfirm: false
				}, function (isConfirm) {
					if (!isConfirm) { return; }
					$.ajax({
						url: "${pageContext.request.contextPath}/delete_company?companyId=" + encodeURIComponent(companyId),
						type: "POST"
					}).done(function () {
						swal({ title: "สำเร็จ", text: "ลบบริษัทเรียบร้อยแล้ว", type: "success" },
							function () { location.reload(); });
					}).fail(function () {
						swal("เกิดข้อผิดพลาด", "ไม่สามารถลบบริษัทได้", "error");
					});
				});
			});

			/*
			 * Favorite
			 */
			$(document).on(
				"click",
				".favorite-contact",
				function () {

					$(this).toggleClass(
						"btn-light-primary btn-primary"
					);

				}
			);

			/*
			 * เริ่มต้นหน้า
			 */
			syncRowIds();
			buildGridCards();
			showPage(1);

		});

	</script>

</body>

</html>