<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
.data-table thead th {
	font-weight: 600 !important;
	text-transform: uppercase;
	white-space: nowrap;
	vertical-align: middle;
}

.data-table thead th .dt-column-header {
	display: inline-flex !important;
	flex-direction: row !important;
	align-items: center !important;
}

.data-table thead th .dt-column-order {
	margin: 0 !important;
}

.filter-card {
	cursor: pointer;
}

.total-log-card.active {
	border: 1.5px solid var(--bs-primary);
	border-radius: 8px;
}

.success-log-card.active {
	border: 1.5px solid var(--bs-success);
	border-radius: 8px;
}

.failed-log-card.active {
	border: 1.5px solid var(--bs-danger);
	border-radius: 8px;
}

.status::first-letter {
	text-transform: uppercase;
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
							href="cubeTokenLogs" class="text-muted text-hover-primary">Cube
								Token Logs</a></li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a href="#"
							class="text-muted text-hover-primary">Log Detail</a></li>

					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid ">
			<div id="kt_app_content_container"
				class="app-container container-fluid">

				<div class="card card-flush mb-8 pb-6 ">

					<!-- Header -->
					<div class="card-header">
						<h3 class="card-title">
							Log - <span class="ms-2" id="logDate"></span>
						</h3>

						<div class="card-toolbar">
							<h1 class="fw-bold text-primary mb-0" id="logId"></h1>
						</div>
					</div>

					<!-- Body -->
					<div class="card-body py-6">

						<div class="d-flex justify-content-center">

							<div
								class="row align-items-center w-100 mw-800px gy-6 gy-md-0 gx-10">

								<!-- All -->
								<div class="col-12 col-md-4">
									<div
										class="d-flex align-items-center justify-content-center gap-3 px-2 py-4 filter-card total-log-card mx-auto"
										data-filter="all" style="max-width: 170px;">
										<div id="totalCount" class="fw-bold fs-2hx text-primary">
											0</div>

										<span class="badge badge-lg badge-primary"> All </span>
									</div>
								</div>

								<!-- Success -->
								<div class="col-12 col-md-4">
									<div
										class="d-flex align-items-center justify-content-center gap-3 px-2 py-4 filter-card success-log-card mx-auto"
										data-filter="success" style="max-width: 170px;">
										<div class="fw-bold fs-2hx text-success success-count">
											0</div>

										<span class="badge badge-lg badge-success"> Success </span>
									</div>
								</div>

								<!-- Failed -->
								<div class="col-12 col-md-4">
									<div
										class="d-flex align-items-center justify-content-center gap-3 px-2 py-4 filter-card failed-log-card mx-auto"
										data-filter="failed" style="max-width: 170px;">
										<div class="fw-bold fs-2hx text-danger failed-count">0</div>

										<span class="badge badge-lg badge-danger"> Failed </span>
									</div>
								</div>

							</div>

						</div>

					</div>

				</div>

				<div class="card mb-8 d-none" id="failedCard">
					<div class="card-header collapsible cursor-pointer rotated"
						data-bs-toggle="collapse" data-bs-target="#failedCardBody">
						<div class="card-title d-flex align-items-center gap-4">
							<span class="badge badge-light-danger fw-bold fs-6 failed-count">3</span>
							<h3 class="fw-semibold text-gray-900">Failed</h3>
						</div>
						<div
							class="d-flex align-items-center justify-content-end ms-auto me-6">
							<button
								class="btn btn-sm btn-light-danger btn-icon-danger btn-text-danger fw-bold fs-6"
								id="retryBtn">
								<i class="ki-duotone ki-arrows-loop fs-2"> <span
									class="path1"></span> <span class="path2"></span>
								</i> Retry
							</button>

						</div>

						<div class="card-toolbar rotate-180">
							<i class="ki-duotone ki-down fs-1"></i>
						</div>
					</div>
					<div id="failedCardBody" class="collapse show">
						<div class="card-body">
							<div class="table-responsive">
								<table
									class="table align-middle table-row-bordered gs-7 gy-5 data-table"
									id="failedTable">
									<thead>
										<tr class="fw-bold text-gray-500 fs-7 text-uppercase">
											<th class="w-75px">#</th>
											<th style="min-width: 110px">date</th>
											<th class="min-w-80px">emp.id</th>
											<th style="min-width: 200px">name</th>
											<th style="min-width: 60px">job site</th>
											<th class="text-end min-w-70px">token</th>
											<th class="text-end min-w-70px">status</th>
										</tr>
									</thead>
									<tbody id="failedTableBody">
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>


				<div class="card d-none" id="successCard">
					<div class="card-header collapsible cursor-pointer rotate"
						data-bs-toggle="collapse" data-bs-target="#successCardBody">
						<div class="card-title d-flex align-items-center gap-4">
							<span
								class="badge badge-light-success fw-bold fs-6 success-count">0</span>
							<h3 class="fw-semibold text-gray-900">Success</h3>
						</div>
						<div class="card-toolbar rotate-180">
							<i class="ki-duotone ki-down fs-1"></i>
						</div>
					</div>
					<div id="successCardBody" class="collapse show">
						<div class="card-body">
							<div class="table-responsive">
								<table
									class="table align-middle table-row-bordered gs-7 gy-5 data-table"
									id="successTable">
									<thead>
										<tr class="fw-bold text-gray-500 fs-7 text-uppercase">
											<th class="w-75px">#</th>
											<th style="min-width: 110px">date</th>
											<th class="min-w-80px">emp.id</th>
											<th style="min-width: 200px">name</th>
											<th style="min-width: 60px">job site</th>
											<th class="text-end min-w-70px">token</th>
											<th class="text-end min-w-70px">status</th>
										</tr>
									</thead>
									<tbody id="successTableBody">
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
	
	    const detailData = [
	    	<c:forEach items="${detail}" var="item" varStatus="status">
	        {
	            tokenLogId: ${item.tokenLogId},
	            userId: "${item.userId}",
	            dateTime: "${item.dateTime}",
	            value: "${item.value}",
	            status: "${item.status}",
	            description: "${item.description}",
	            employeeId: "${item.employeeId}",
	            nameTh: "${item.nameTh}",
	            nameEn: "${item.nameEn}",
	            filePath: "${item.filePath}",
	            jobsiteList: ${item.jobsiteList}
	        }<c:if test="${!status.last}">,</c:if>
	        </c:forEach>
	    ];
	    
	    const failedCase  = detailData.filter(item => item.status === "failed");
	    const successCase = detailData.filter(item => item.status === "success");
	</script>

	<script>

		const $failedCard = $("#failedCard");
		const $successCard = $("#successCard");
		
		$(document).ready(function() {

			const logId = new URLSearchParams(window.location.search).get("logId");

		    if (!logId) {
		        console.error("logId is missing");
		        return;
		    }
		    
		    $("#retryBtn").on("click", retry);
		    
		    $("#logId").text(`#\${logId}`);
		    $("#logDate").text(new Date().toLocaleDateString("en-US"));
		    
		    filter($(".total-log-card"));
		    
		    rednerLogDetails(failedCase, $failedCard, $("#failedTableBody"), $(".failed-count"));
		    rednerLogDetails(successCase, $successCard, $("#successTableBody"), $(".success-count"));
		    
		    const tableOptions = {
		    	    autoWidth: false,
		    	    order: [[0, "asc"]],
		    	    paging: false,
		    	    searching: false,
		    	    info: false,

		    	    columnDefs: [
		    	        { width: "75px", targets: 0 },
		    	        { width: "110px", targets: 1 },
		    	        { width: "80px", targets: 2 },
		    	        { width: "300px", targets: 3 },
		    	        { width: "150px", targets: 4 },
		    	        { width: "100px", targets: 5 },
		    	        { width: "100px", targets: 6 }
		    	    ]
		    	};

		    $("#failedTable").DataTable(tableOptions);
		    $("#successTable").DataTable(tableOptions);
		    
		    $("#totalCount").text(detailData.length);

			$(".filter-card").click(function() {
                filter($(this));
			});

			$("#retryBtn").on("click", function(e) {
				e.stopPropagation();

			});

		});
		
		function formatDate(dateTime) {
		    const date = new Date(dateTime);

		    return date.toLocaleDateString("en-GB", {
		        day: "numeric",
		        month: "short"
		    }) + ", " + date.toLocaleTimeString("en-GB", {
		        hour: "2-digit",
		        minute: "2-digit",
		        hour12: false
		    });
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
		
		function rednerLogDetails(data, $card, $tableBody, $casesCount) {

			if (data.length === 0) {
                $card.hide();
                return;
            }
			
			$casesCount.text(data.length);
			
			data.forEach((item, index) => {

				const nameEn = item.nameEn || "";
				const nameTh = item.nameTh || "";

				const displayName = nameEn || nameTh || item.userId || "-";

				const avatarInitial = displayName.charAt(0).toUpperCase();
				
				let avatarHtml;
				
				if (item.filePath) {

					avatarHtml = `
						<div class="symbol symbol-40px symbol-circle">
							<div class="symbol-label">
								<img src="${pageContext.request.contextPath}\${item.filePath}" class="w-100 h-100 rounded-circle" style="object-fit: cover;">
							</div>
						</div>
					`;

				} else {

					avatarHtml = `
						<div class="symbol symbol-40px symbol-circle">
							<div
								class="symbol-label bg-light-primary text-primary fw-semibold fs-3">
								\${escapeHtml(avatarInitial)}
							</div>
						</div>
					`;
				}
   
				const row = `
							<tr>
								<td class="fw-bold fs-7 text-gray-900">\${index + 1}</td>
                                <td class="fw-normal fs-6 text-gray-900">\${formatDate(item.dateTime)}</td>
                                <td class="fw-normal fs-6 text-gray-900">\${item.employeeId}</td>
                                <td class="fw-normal fs-6 text-gray-900">
                                	<div class="d-flex gap-3 align-items-center">
										\${avatarHtml}
		
										<div class="d-flex flex-column">
		
											<div class="text-gray-900 fw-normal fs-6">
												\${escapeHtml(displayName)}
											</div>
		
											<span class="text-gray-900 fw-normal fs-6">
												\${escapeHtml(nameTh || "-")}
											</span>
		
										</div>
		
									</div>
                                </td>
                                <td>
	                                <div class="d-flex flex-column gap-3">
	                                    \${
	                                        item.jobsiteList && item.jobsiteList.length > 0
	                                            ? item.jobsiteList
	                                                .map(js => `
	                                                	<div>
			                                                <span class="badge badge-lg badge-primary py-2">
		                                                    \${js.name_site || '-'}
		                                                    </span>
	                                                    </div>
	                                                `)
	                                                .join('')
	                                            : '-'
	                                    }
	                                </div>
	                            </td>
                                <td class="text-end fw-normal fs-6 text-gray-900">\${item.value ? parseInt(item.value) : '-'}</td>
                                <td class="text-\${item.status == 'success' ? 'success' : 'danger'} fw-normal fs-6 text-end status">\${item.status}</td>
							</tr>
						`
						
			    $tableBody.append(row);
						
			});
			
		}
		
		function retry() {

		    const logId = new URLSearchParams(window.location.search).get("logId");

		    if (!logId) {
		        console.error("logId is missing");
		        return;
		    }

		    // Confirm ก่อน
		    Swal.fire({
		        title: "Retry distribution?",
		        text: "ระบบจะลองแจก Token ให้กับรายการที่ Failed อีกครั้ง",
		        icon: "warning",
		        showCancelButton: true,
		        confirmButtonText: "Yes, retry",
		        cancelButtonText: "Cancel",
		        reverseButtons: true
		    }).then((result) => {

		        if (!result.isConfirmed) {
		            return;
		        }

		        // Loading ระหว่างรอ AJAX
		        Swal.fire({
		            title: "Retrying...",
		            text: "กำลังแจก Token ให้กับรายการที่ Failed",
		            allowOutsideClick: false,
		            allowEscapeKey: false,
		            didOpen: () => {
		                Swal.showLoading();
		            }
		        });

		        $.ajax({
		            url: `${pageContext.request.contextPath}/retryDistributeMonthlyToken`,
		            method: "POST",
		            data: {
		                logId: logId
		            },

		            success: function(response) {

		                Swal.fire({
		                    title: "Retry completed",
		                    text: "ดำเนินการ Retry เรียบร้อยแล้ว",
		                    icon: "success",
		                    confirmButtonText: "OK"
		                });

		            },

		            error: function(xhr, status, error) {

		                console.error("Retry failed:", error);

		                Swal.fire({
		                    title: "Retry failed",
		                    text: "ไม่สามารถ Retry การแจก Token ได้",
		                    icon: "error",
		                    confirmButtonText: "OK"
		                });

		            }
		        });

		    });
		}
		
		function filter($filterCard) {

		    $(".filter-card").removeClass("active");
		    $filterCard.addClass("active");

		    const filter = $filterCard.data("filter");

		    switch (filter) {

		        case "all":
		            $failedCard.toggleClass("d-none", failedCase.length === 0);
		            $successCard.toggleClass("d-none", successCase.length === 0);
		            break;

		        case "success":
		            $failedCard.addClass("d-none");
		            $successCard.toggleClass("d-none", successCase.length === 0);
		            break;

		        case "failed":
		            $successCard.addClass("d-none");
		            $failedCard.toggleClass("d-none", failedCase.length === 0);
		            break;
		    }
		}
		
	</script>
</body>
</html>