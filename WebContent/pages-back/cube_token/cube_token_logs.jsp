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
/* Header */
#itemTable thead th {
	font-weight: 600 !important;
	text-transform: uppercase;
	white-space: nowrap;
	vertical-align: middle;
}

#kt_token_log_table thead th .dt-column-header {
	display: inline-flex !important;
	flex-direction: row !important;
	align-items: center !important;
}

#kt_token_log_table th .dt-column-order {
	margin: 0 !important;
}

.year-option.active {
	background-color: var(--bs-primary-light);
	color: var(--bs-primary);
	font-weight: 600;
	border-radius: 4px;
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
						Privilege Management</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/check_in_out"
							class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a
							href="cubeTokenLogs" class="text-muted text-hover-primary">Token
								Monthly Logs</a></li>

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
								id="year-menu"></div>
						</div>
					</div>
				
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid ">
			<div id="kt_app_content_container"
				class="app-container container-fluid">

				<div class="card card-flush">

					<!-- Header -->
					<div class="card-header align-items-center">
						<h3 class="card-title fw-semibold text-gray-900">Log History</h3>
					</div>

					<!-- Body -->
					<fmt:setLocale value="en" />
					<div class="card-body ">  
						<div class="table-responsive">
							<table id="kt_token_log_table"
								class="table table-hover align-middle table-row-bordered gs-3 gy-4">

								<thead>
									<tr class="text-uppercase fw-bold fs-7 text-gray-500">
										<th class="w-70px">#</th>
										<th class="min-w-60px">ID</th>
										<th class="min-w-150px">Date</th>
										<th class="text-center min-w-80px">All</th>
										<th class="text-end min-w-80px">Success</th>
										<th class="min-w-80px text-end">Fail</th>
										<th class="text-end min-w-70px">Action</th>
									</tr>
								</thead>

								<tbody class="fw-semibold text-gray-700">

									<c:forEach items="${logs}" var="log" varStatus="status">

										<tr>

											<!-- # -->
											<td class="fw-normal fs-7 text-gray-900">${status.index + 1}</td>

											<!-- ID -->
											<td><span class="fw-normal fs-6 text-gray-800">
													${log.monitorLogId} </span></td>

											<!-- Date -->
											<td class="fw-normal fs-6 text-gray-800"><fmt:formatDate
													value="${log.dateTime}" pattern="d MMM yyyy, HH:mm" /></td>

											<!-- All -->
											<td class="text-center"><span
												class="fw-normal fs-6 text-gray-700">
													${log.successCase + log.failCase} </span></td>

											<!-- Success -->
											<td class="text-end"><span
												class="fw-normal fs-6 text-gray-800">
													${log.successCase} </span></td>

											<!-- Fail -->
											<td class="text-end"><span
												class="fw-normal fs-6 text-gray-800"> ${log.failCase}
											</span></td>

											<!-- Action -->
											<td class="text-end"><a
												href="${pageContext.request.contextPath}/cubeTokenLogDetail?logId=${log.monitorLogId}"
												class="btn btn-sm btn-icon btn-light-primary"> <i
													class="ki-duotone ki-pencil fs-2"> <span class="path1"></span>
														<span class="path2"></span>
												</i>

											</a></td>

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

		const currentYear = new Date().getFullYear();
		let selectedYear = currentYear;
	
		let tokenLogTable = null;
	
		$(document).ready(function() {
	
			const $table = $('#kt_token_log_table');
			const $tbody = $table.find('tbody');
			const $menu = $('#year-menu');
	
			// ==========================================================
			// Year filter
			// ==========================================================
	
			$(".year-select").append(
				`<span class="fw-semibold" id="year-filter">\${selectedYear}</span>`
			);
	
			const startYear = 2026;
	
			for (let year = currentYear; year >= startYear; year--) {
	
				$menu.append(`
					<button
						type="button"
						class="dropdown-item year-option \${year === selectedYear ? 'active' : ''}"
						data-year="\${year}">
						\${year}
					</button>
				`);
	
			}
	
	
			// ==========================================================
			// Escape HTML
			// ==========================================================
	
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
	
	
			// ==========================================================
			// Format Date
			// ==========================================================
	
			function formatDate(dateValue) {
	
				if (!dateValue) {
					return "";
				}
	
				const date = new Date(dateValue);
	
				if (isNaN(date.getTime())) {
					return "";
				}
	
				return date.toLocaleDateString("en-GB", {
					day: "numeric",
					month: "short",
					year: "numeric"
				}) + ", " +
				date.toLocaleTimeString("en-GB", {
					hour: "2-digit",
					minute: "2-digit"
				});
			}
	
	
			// ==========================================================
			// Render Table
			// ==========================================================
	
			function renderLogs(logs) {
	
				$tbody.empty();
	
				if (!logs || logs.length === 0) {
					return;
				}
	
				logs.forEach(function(log, index) {
	
					const allCount =
						Number(log.successCase || 0) +
						Number(log.failCase || 0);
	
					const row = `
						<tr>
	
							<!-- # -->
							<td class="fw-normal fs-7 text-gray-900">
								\${index + 1}
							</td>
	
							<!-- ID -->
							<td>
								<span class="fw-normal fs-6 text-gray-800">
									\${escapeHtml(log.monitorLogId)}
								</span>
							</td>
	
							<!-- Date -->
							<td class="fw-normal fs-6 text-gray-800">
								\${formatDate(log.dateTime)}
							</td>
	
							<!-- All -->
							<td class="text-center">
								<span class="fw-normal fs-6 text-gray-700">
									\${allCount}
								</span>
							</td>
	
							<!-- Success -->
							<td class="text-end">
								<span class="fw-normal fs-6 text-gray-800">
									\${Number(log.successCase || 0)}
								</span>
							</td>
	
							<!-- Fail -->
							<td class="text-end">
								<span class="fw-normal fs-6 text-gray-800">
									\${Number(log.failCase || 0)}
								</span>
							</td>
	
							<!-- Action -->
							<td class="text-end">
								<a
									href="${pageContext.request.contextPath}/cubeTokenLogDetail?logId=\${encodeURIComponent(log.monitorLogId)}"
									class="btn btn-sm btn-icon btn-light-primary">
	
									<i class="ki-duotone ki-pencil fs-2">
										<span class="path1"></span>
										<span class="path2"></span>
									</i>
	
								</a>
							</td>
	
						</tr>
					`;
	
					$tbody.append(row);
				});
			}
	
	
			// ==========================================================
			// Load Logs
			// ==========================================================
	
			function loadLogs(year) {
	
				$.ajax({
	
					url: "${pageContext.request.contextPath}/getCubeTokenMonthlyLogs",
	
					type: "GET",
	
					data: {
						year: year
					},
	
					dataType: "json",
	
					beforeSend: function() {
	
						$tbody.html(`
							<tr>
								<td colspan="7" class="text-center py-10">
									<span class="spinner-border text-primary"></span>
								</td>
							</tr>
						`);
						
					},
	
					success: function(response) {
	
						const logs = response.data || [];
	
						renderLogs(logs);
	
						// ==================================================
						// Initialize DataTable ครั้งแรก
						// ==================================================
	
						if (tokenLogTable === null) {
	
							tokenLogTable = $table.DataTable({
	
								pageLength: 25,
	
								columnDefs: [
									{
										targets: -1,
										orderable: false
									}
								]
	
							});
	
						} else {
	
							// ==================================================
							// Refresh DataTable
							// ==================================================
	
							tokenLogTable
								.clear()
								.rows
								.add($tbody.find("tr"))
								.draw();
	
						}
	
					},
	
					error: function(xhr) {
	
						console.error(
							"Failed to load token monthly logs:",
							xhr
						);
	
						$tbody.html(`
							<tr>
								<td
									colspan="7"
									class="text-center text-danger py-10">
	
									Failed to load log history.
	
								</td>
							</tr>
						`);
	
					}
	
				});
	
			}
	
	
			// ==========================================================
			// Year Change
			// ==========================================================
	
			$(document).on("click", ".year-option", function() {
	
				const year = Number($(this).data("year"));
	
				if (year === selectedYear) {
					return;
				}
	
				selectedYear = year;
	
				// Update button
				$("#year-filter").text(selectedYear);
	
				// Update active
				$(".year-option").removeClass("active");
	
				$(this).addClass("active");
	
				// Load new data
				loadLogs(selectedYear);
	
			});
	
	
			// ==========================================================
			// Initial Load
			// ==========================================================
	
			loadLogs(selectedYear);
	
		});
	
	</script>


</body>
</html>