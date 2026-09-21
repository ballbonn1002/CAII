<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

	<script
		src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js">
	</script>

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

<body>

	<!-- Main -->
	<div class="app-main flex-column px-16">

		<!-- Toolbar -->
		<div class="page-title">

			<h1 class="page-heading text-gray-700 fw-semibold">
				Contact
			</h1>

			<ul class="list-unstyled d-inline-flex gap-2 text-muted fs-7 fw-medium">

				<li>Dashboard</li>
				<li>-</li>
				<li>Contact</li>

			</ul>

		</div>
		

		<!-- Search -->
		<div class="card shadow-sm mb-8">

			<div class="card-body py-5">

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
		<div class="d-flex justify-content-between align-items-center mb-5">

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
		<div class="card shadow-sm">

			<div class="card-body">
		     <div class="table-responsive">

				<!-- Grid View -->
				<div
					id="gridViewContainer"
					class="row g-5 d-none">
				</div>

				<!-- Table View -->
				<div
					id="tableViewContainer"
					class="table-responsive">

					<table
                        id="contact_table"
                        class="table table-striped table-row-bordered table-row-gray-200 align-middle table-hover">
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
									data-id="${contact.company_contact_id}">

									<!-- Number -->
									<td class="text-center row-number">
										${status.count}
									</td>

									<!-- Company Name -->
									<td>

										<div class="d-flex align-items-center gap-3">

											<img
											src="<c:choose>
											<c:when test="${not empty contact.file_path}">${pageContext.request.contextPath}${contact.file_path}</c:when>
											<c:otherwise>${pageContext.request.contextPath}/assets/media/avatars/blank.png</c:otherwise>
                                            </c:choose>"
											class="rounded-circle" width="42" height="42"
											style="object-fit:cover; object-position: center top;"
											alt="Profile">

											<div class="min-w-0">

												<div class="fw-medium text-gray-800 contact-name">

													<c:choose>

														<c:when test="${not empty contact.contact_name}">
															<c:out value="${contact.contact_name}" />
														</c:when>

														<c:otherwise>
															<c:out value="${contact.contactNameTh}" />
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
														<div class="symbol symbol-35px symbol-circle">
															<img src="${contact.company_logo_path}" alt="Company">
														</div>
													</c:when>
													<c:otherwise>
														<div class="symbol symbol-35px symbol-circle">
															<span
																class="symbol-label bg-light-primary text-primary fw-bold fs-7">
																<c:choose>
																	<c:when test="${not empty contact.companyEn}">
                                                                       ${fn:toUpperCase(fn:substring(contact.companyEn, 0, 1))}
                                                                    </c:when>
																	<c:when test="${not empty contact.companyId}">
                                                                       ${fn:toUpperCase(fn:substring(contact.companyId, 0, 1))}
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
														<c:out value="${contact.company_Id}" />
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

												<c:when test="${not empty contact.company_address}">
													<c:out value="${contact.company_address}" />
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
												data-id="${contact.company_contact_id}"
												<c:if test="${contact.is_active eq 'Y'}">   
                                                     checked
                                                </c:if>>

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
	        autoWidth: false,
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
			 * สร้าง Grid Card จากข้อมูลใน Table
			 */
			function buildGridCards() {

				const $gridContainer = $("#gridViewContainer");

				$gridContainer.empty();

				$(".contact-row").each(function () {

					const $row = $(this);

					const id = String(
						$row.attr("data-id") || ""
					);

					const contactName = $row
						.find(".contact-name")
						.text()
						.trim();

					const position = $row
						.find(".contact-position")
						.text()
						.trim();

					const company = $row
						.find(".contact-company")
						.text()
						.trim();

					const branch = $row
						.find(".contact-branch")
						.text()
						.trim();

					const address = $row
						.find(".contact-address")
						.text()
						.trim();

					const phone = $row
						.find(".contact-phone")
						.text()
						.trim();

					const email = $row
						.find(".contact-email")
						.text()
						.trim();

					const $companyLogoImg = $row
				    .children("td")
				    .eq(2)
				    .find("img");

				const companyLogo = $companyLogoImg.length
				    ? ($companyLogoImg.attr("src") || "")
				    : "";

				const companyInitial = (
				    (company || "?").trim().charAt(0) || "?"
				).toUpperCase();

				const companyLogoHtml = companyLogo
				    ? (
				        '<img ' +
				            'src="' + escapeHtml(companyLogo) + '" ' +
				            'class="rounded border border-gray-300 p-1" ' +
				            'alt="' + escapeHtml(company) + '">'
				    )
				    : (
				        '<span class="symbol-label bg-light-primary text-primary fw-bold fs-3">' +
				            escapeHtml(companyInitial) +
				        '</span>'
				    );

				const isActive = $row
				    .find(".contact-active")
				    .is(":checked");

					const cardHtml =
						'<div class="col-12 col-md-6 col-xl-4 contact-grid-item d-none" ' +
						'data-id="' + escapeHtml(id) + '">' +

							'<div class="card h-100 shadow-sm overflow-hidden">' +

								'<div class="card-body p-7">' +

									'<div class="d-flex align-items-start gap-4 mb-7">' +

									'<div class="symbol symbol-50px flex-shrink-0">' +

								    companyLogoHtml +

								'</div>' +

										'<div class="flex-grow-1 min-w-0 pt-1">' +

											'<div class="fw-semibold text-gray-900 fs-4 text-truncate">' +
												escapeHtml(company || contactName || "-") +
											'</div>' +

											'<div class="text-muted fs-7 mt-2 text-truncate">' +
												escapeHtml(position || "-") +
											'</div>' +

										'</div>' +

									'</div>' +

									'<div class="d-flex align-items-center mb-5">' +

										'<i class="ki-outline ki-credit-cart fs-3 text-gray-500 me-4"></i>' +

										'<span class="text-gray-800 fs-6">' +
											escapeHtml(phone || "-") +
										'</span>' +

									'</div>' +

									'<div class="d-flex align-items-start">' +

										'<i class="ki-outline ki-geolocation fs-3 text-gray-500 me-4 mt-1"></i>' +

										'<div class="min-w-0 flex-grow-1">' +

											'<div class="text-gray-800 fs-6 mb-4">' +
												escapeHtml(branch || "-") +
											'</div>' +

											'<div class="text-gray-700 fs-7 lh-lg text-wrap">' +
												escapeHtml(address || "-") +
											'</div>' +

										'</div>' +

									'</div>' +

								'</div>' +

								'<div class="separator"></div>' +

								'<div class="card-footer px-7 py-5">' +

									'<div class="d-flex justify-content-between align-items-center">' +

										'<div class="form-check form-check-custom form-check-solid">' +

											'<input ' +
												'type="checkbox" ' +
												'class="form-check-input grid-contact-active" ' +
												'data-id="' + escapeHtml(id) + '" ' +
												(isActive ? "checked" : "") +
											'>' +

											'<label class="form-check-label text-gray-800 fs-6">' +
												'Is Active' +
											'</label>' +

										'</div>' +

										'<div class="d-flex align-items-center gap-2">' +

											'<button ' +
												'type="button" ' +
												'class="btn btn-icon btn-sm btn-light-primary favorite-contact" ' +
												'data-id="' + escapeHtml(id) + '" ' +
												'title="Favorite">' +

												'<i class="ki-outline ki-star fs-5"></i>' +

											'</button>' +

											'<button ' +
												'type="button" ' +
												'class="btn btn-icon btn-sm btn-light-primary view-contact" ' +
												'data-id="' + escapeHtml(id) + '" ' +
												'title="View">' +

												'<i class="ki-outline ki-message-text-2 fs-5"></i>' +

											'</button>' +

											'<button ' +
												'type="button" ' +
												'class="btn btn-icon btn-sm btn-light-primary edit-contact" ' +
												'data-id="' + escapeHtml(id) + '" ' +
												'title="Edit">' +

												'<i class="ki-outline ki-notepad-edit fs-5"></i>' +

											'</button>' +

											'<button ' +
												'type="button" ' +
												'class="btn btn-icon btn-sm btn-light-danger delete-contact" ' +
												'data-id="' + escapeHtml(id) + '" ' +
												'title="Delete">' +

												'<i class="ki-outline ki-trash fs-5"></i>' +

											'</button>' +

										'</div>' +

									'</div>' +

								'</div>' +

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

				} else {

				    $rowsOnCurrentPage.each(function () {

				        const id = String(
				            $(this).attr("data-id") || ""
				        );

				        $("#gridViewContainer")
				            .find(
				                '.contact-grid-item[data-id="' + id + '"]'
				            )
				            .removeClass("d-none");

				    });

				}

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

				buildGridCards();

				$("#tableViewContainer").addClass("d-none");

				$("#gridViewContainer").removeClass("d-none");

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
				                        location.reload();
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