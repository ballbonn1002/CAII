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
						Cube Token Management</h1>
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
					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid ">
			<div id="kt_app_content_container"
				class="app-container container-fluid">

				<div class="card mb-5">
					<div class="card-body">
						<div class="position-relative">
							<i
								class="ki-outline ki-magnifier position-absolute top-50 translate-middle-y ms-4 text-gray-500 fs-4 z-index-1"></i>

							<select id="employeeSearch" class="form-select ps-12"
								data-control="select2" data-placeholder="All"
								data-allow-clear="false">
							</select>
						</div>

					</div>
				</div>
				<div class="d-flex align-items-center mt-6 py-3">
					<h3 class="fw-bold text-gray-900">
						Employee (<span class="counter">0</span>)
					</h3>
				</div>

				<div class="card card-flush">
					<div class="card-body py-4">

						<div class="table-responsive">
							<table class="table align-middle table-row-dashed fs-6 gy-5"
								id="kt_datatable_zero_configuration">

								<thead>
									<tr
										class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0">
										<th class="text-center min-w-50px">#</th>
										<th style="min-width: 60px">EMP. ID</th>
										<th class="min-w-100px">NAME</th>
										<th style="min-width: 120px">RECONCILE</th>
										<th style="min-width: 120px">GET TOKEN</th>
										<th style="min-width: 120px">DEDUCT TOKEN</th>
										<th class="text-end min-w-150px pe-3">ACTION</th>
									</tr>
								</thead>

								<tbody class="user-summary-table-body">
									<!-- Data goes here -->
								</tbody>

							</table>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		let table = null;
		let selectedUserId = "All";
		
		$(document).ready(function() {

            const currentYear = new Date().getFullYear();
            
            loadTokenSummary(currentYear);
            
            $("#employeeSearch").on("change", function() {

                selectedUserId = $(this).val() || "All";

                if (table) {
                    table.draw();
                    updateCounter();
                }
            });
            
        });
		
		$.fn.dataTable.ext.search.push(function(settings, data, dataIndex) {

		    // ใช้เฉพาะ table ของเรา
		    if (settings.nTable.id !== "kt_datatable_zero_configuration") {
		        return true;
		    }

		    // All Employee
		    if (selectedUserId === "All") {
		        return true;
		    }

		    // หา row ที่ DataTables กำลังตรวจสอบ
		    const rowNode = table.row(dataIndex).node();

		    if (!rowNode) {
		        return false;
		    }

		    const rowUserId = $(rowNode).attr("data-user-id") || "";
		    
		    return rowUserId === encodeURIComponent(selectedUserId);
		});
		
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
		
		function updateCounter() {
		    if (!table) {
		        return;
		    }

		    const count = table.rows({
		        search: "applied"
		    }).count();

		    $(".counter").text(count);
		}
		
		function populateEmployeeSearch(users) {

		    const select = $("#employeeSearch");

		    // Clear options
		    select.empty();

		    // All
		    select.append(`
		        <option value="All">All</option>
		    `);

		    // ==========================================
		    // Employee ID Pattern
		    // ==========================================
		    const employeeIdPattern = /^[A-Z]\d{3}$/;

		    // ==========================================
		    // Sort function
		    // Valid Employee ID ก่อน
		    // Invalid / ไม่มี ID ไปท้าย
		    // ==========================================
		    function sortUsers(a, b) {

		        const employeeIdA = String(a.employee_id || "")
		            .trim()
		            .toUpperCase();

		        const employeeIdB = String(b.employee_id || "")
		            .trim()
		            .toUpperCase();

		        const isValidA = employeeIdPattern.test(employeeIdA);
		        const isValidB = employeeIdPattern.test(employeeIdB);

		        // Valid ก่อน
		        if (isValidA && !isValidB) {
		            return -1;
		        }

		        if (!isValidA && isValidB) {
		            return 1;
		        }

		        // ถ้าเหมือนกัน ให้เรียงตาม Employee ID
		        return employeeIdA.localeCompare(employeeIdB);
		    }

		    // ==========================================
		    // แบ่ง Enable / Disable
		    // ==========================================
		    const enabledUsers = users
		        .filter(user => String(user.enable) === "1")
		        .sort(sortUsers);

		    const disabledUsers = users
		        .filter(user => String(user.enable) === "0")
		        .sort(sortUsers);

		    // ==========================================
		    // Enable Group
		    // ==========================================
		    const enableGroup = $('<optgroup label="Enable"></optgroup>');

		    enabledUsers.forEach(function(user) {

		        const employeeId = String(user.employee_id || "").trim();

		        const nameEn = ` - \${user.name_en}`|| "";
		        const nameTh = ` - \${user.name_th}` || "";

		        const displayName =
		            nameEn ||
		            nameTh ||
		            user.user_id ||
		            "-";

		        const label = employeeId
		            ? `\${employeeId}\${nameEn}\${nameTh}`
		            : displayName;

		        const option = new Option(
		            label,
		            user.user_id || "",
		            false,
		            false
		        );

		        enableGroup.append(option);
		    });

		    select.append(enableGroup);

		    // ==========================================
		    // Disable Group
		    // ==========================================
		    const disableGroup = $('<optgroup label="Disable"></optgroup>');

		    disabledUsers.forEach(function(user) {

		        const employeeId = String(user.employee_id || "").trim();

		        const nameEn = user.name_en || "";
		        const nameTh = user.name_th || "";

		        const displayName =
		            nameEn ||
		            nameTh ||
		            user.user_id ||
		            "-";

		        const label = employeeId
		            ? `\${employeeId} - \${displayName}`
		            : displayName;

		        const option = new Option(
		            label,
		            user.user_id || "",
		            false,
		            false
		        );

		        disableGroup.append(option);
		    });

		    select.append(disableGroup);

		    // ==========================================
		    // Refresh Select2
		    // ==========================================
		    select.trigger("change");
		}
		
		
		
		function loadTokenSummary(year) {
			const tbody = $(".user-summary-table-body");

			// Loading
			tbody.html(`
				<tr>
					<td colspan="7">
						<div class="d-flex flex-column gap-3 justify-content-center align-items-center py-10">
							<div class="spinner-border text-primary" role="status">
								<span class="visually-hidden">Loading...</span>
							</div>
							<div>
								Loading...
							</div>
						</div>
					</td>
				</tr>
			`);
			
			const context = "${pageContext.request.contextPath}";

			$.ajax({
				url: "getTokenSummaryForAllUsers",
				type: "GET",
				data: {
					year: year
				},
				dataType: "json",

				success: function(response) {

					if (!response.success || !response.data || !response.data.length) {

						tbody.html(`
							<tr>
								<td colspan="7">
									<div class="text-center text-muted py-10">
										No user data found.
									</div>
								</td>
							</tr>
						`);

						return;
					}
					
					populateEmployeeSearch(response.data);
					
		            const employeeIdPattern = /^[A-Z]\d{3}$/;

		            response.data.sort(function(a, b) {

		                const employeeIdA = String(a.employee_id || "").trim().toUpperCase();
		                const employeeIdB = String(b.employee_id || "").trim().toUpperCase();

		                const isValidA = employeeIdPattern.test(employeeIdA);
		                const isValidB = employeeIdPattern.test(employeeIdB);

		                if (isValidA && !isValidB) {
		                    return -1;
		                }

		                if (!isValidA && isValidB) {
		                    return 1;
		                }

		                return employeeIdA.localeCompare(employeeIdB);
		            });

					
					$(".counter").text(response.data.length);

					tbody.empty();

					response.data.forEach(function(user, index) {

						// ==========================================
						// User name
						// ==========================================

						const nameEn = user.name_en || "";
						const nameTh = user.name_th || "";

						// ถ้าไม่มี name_en ให้ใช้ name_th
						const displayName = nameEn || nameTh || user.user_id || "-";

						// ตัวอักษรแรกสำหรับ Avatar
						const avatarInitial = displayName.charAt(0).toUpperCase();


						// ==========================================
						// Employee Type
						// ==========================================

						let employeeType = "-";
						let employeeTypeClass = "badge-light-secondary";

						switch (String(user.employee_type_id)) {

							case "1":
								employeeType = "พนักงานประจำ";
								employeeTypeClass = "badge-light-primary";
								break;

							case "2":
								employeeType = "พนักงานอัตราจ้าง";
								employeeTypeClass = "badge-light-success";
								break;

							case "3":
								employeeType = "นักศึกษาฝึกงาน";
								employeeTypeClass = "badge-light-info";
								break;
						}


						// ==========================================
						// Employee Status
						// ==========================================

						let employeeStatus = "-";
						let employeeStatusClass = "badge-light-secondary";

						switch (String(user.employee_status)) {

							case "1":
								employeeStatus = "Active";
								employeeStatusClass = "badge-light-success";
								break;

							case "2":
								employeeStatus = "Probation";
								employeeStatusClass = "badge-light-warning";
								break;

							case "0":
								employeeStatus = "Excluded";
								employeeStatusClass = "badge-light-danger";
								break;

							case "3":
								employeeStatus = "Intern";
								employeeStatusClass = "badge-light-info";
								break;
						}


						// ==========================================
						// Avatar
						// ==========================================

						let avatarHtml;
						let context = "${pageContext.request.contextPath}";

						if (user.file_path) {

							avatarHtml = `
								<div class="symbol symbol-40px symbol-circle">
									<div class="symbol-label">
										<img src="${pageContext.request.contextPath}\${user.file_path}" class="w-100 h-100 rounded-circle" style="object-fit: cover;">
									</div>
								</div>
							`;

						} else {

							avatarHtml = `
								<div class="symbol symbol-40px symbol-circle">
									<div
										class="symbol-label bg-light-primary text-primary fw-bold fs-5">
										\${escapeHtml(avatarInitial)}
									</div>
								</div>
							`;
						}


						// ==========================================
						// Token values
						// ==========================================

						const reconcile = Number(user.reconcile || 0);
						const getToken = Number(user.get_token || 0);
						const deductToken = Number(user.deduct_token || 0);


						// ==========================================
						// Render Row
						// ==========================================
							
						tbody.append(`
							<tr data-user-id="\${encodeURIComponent(user.user_id || '')}">

								<!-- # -->
								<td class="text-center">
									<span class="fw-bold fs-7 text-gray-900">
										\${index + 1}
									</span>
								</td>


								<!-- EM ID -->
								<td>
									<span class="text-gray-900 fs-6 fw-normal">
										\${escapeHtml(user.employee_id|| "-")}
									</span>
								</td>


								<!-- NAME -->
								<td>

									<div class="d-flex align-items-center gap-3">

										\${avatarHtml}

										<div class="d-flex flex-column">

											<a
												href="returnCubeTokenPage?userId=\${encodeURIComponent(user.user_id || '')}"
												class="text-gray-900 fw-normal fs-6 text-hover-primary">

												\${escapeHtml(displayName)}

											</a>

											<span class="text-gray-600 fs-8">
												\${escapeHtml(nameTh || "-")}
											</span>

											<div class="d-flex gap-3 mt-1">

												<span
													class="badge \${employeeTypeClass} fs-6 fw-medium">

													\${employeeType}

												</span>

												<span
													class="badge \${employeeStatusClass} fs-6 fw-medium">

													\${employeeStatus}

												</span>

											</div>

										</div>

									</div>

								</td>


								<!-- RECONCILE -->
								<td>
									<span class="text-gray-800">
										\${reconcile}
									</span>
								</td>


								<!-- GET TOKEN -->
								<td>
									<span class="text-gray-800">
										\${getToken}
									</span>
								</td>


								<!-- DEDUCT TOKEN -->
								<td>
									<span class="text-gray-800">
										\${deductToken}
									</span>
								</td>


								<!-- ACTION -->
								<td class="text-end pe-3">

									<a
									    href="returnCubeTokenPage?userId=\${encodeURIComponent(user.user_id || '')}"
									    class="btn btn-sm btn-icon btn-light-primary"
									    title="View Token History">
		
									    <i class="ki-duotone ki-pencil fs-4">
									        <span class="path1"></span>
									        <span class="path2"></span>
									    </i>
		
									</a>

								</td>

							</tr>
						`);
						
					
					});
					table = $("#kt_datatable_zero_configuration").DataTable();
				},

				error: function(xhr, status, error) {

					console.error("Error loading token summary:", error);
					console.error("Response:", xhr.responseText);

					tbody.html(`
						<tr>
							<td colspan="7">
								<div class="text-center text-danger py-10">
									Failed to load token summary.
								</div>
							</td>
						</tr>
					`);
				}
			});
		}
	</script>
</body>
</html>