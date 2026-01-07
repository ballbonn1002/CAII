<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />


<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>

<link
	href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<style>
/* Light Mode */
[data-bs-theme="light"] #kt_table.table.table-striped>tbody>tr:nth-of-type(odd)>*
	{
	background-color: #FBFBFB !important;
	box-shadow: none !important;
}

[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>*, [data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>td,
	[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>th, [data-bs-theme="light"] #kt_table.table.table-hover>tbody>tr:hover>*,
	[data-bs-theme="light"] #kt_table.dataTable>tbody>tr:hover>* {
	background-color: #F9F9F9 !important;
	box-shadow: none !important;
	transition: background-color .15s ease-in-out;
}

/* Dark Mode */
[data-bs-theme="dark"] #kt_table.table.table-striped>tbody>tr:nth-of-type(odd)>*
	{
	background-color: #191B20 !important;
	box-shadow: none !important;
}

[data-bs-theme="dark"] #kt_table.table.table-striped>tbody>tr:nth-of-type(even)>*
	{
	background-color: #15171C !important;
	box-shadow: none !important;
}

[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>*, [data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>td,
	[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>th, [data-bs-theme="dark"] #kt_table.table.table-hover>tbody>tr:hover>*,
	[data-bs-theme="dark"] #kt_table.dataTable>tbody>tr:hover>* {
	background-color: #1B1C22 !important;
	box-shadow: none !important;
	transition: background-color .15s ease-in-out;
}

#kt_table thead th:nth-child(1), #kt_table tbody td:nth-child(1),
	#kt_table tbody td.dt-type-numeric:nth-child(1) {
	width: 75px !important;
	min-width: 75px !important;
	max-width: 75px !important;
}

#kt_table thead th:nth-child(2), #kt_table tbody td:nth-child(2) {
	width: 222px !important;
	min-width: 222px !important;
}

#kt_table thead th:nth-child(3), #kt_table tbody td:nth-child(3),
	#kt_table tbody td.dt-type-numeric:nth-child(3) {
	width: 222px !important;
	min-width: 222px !important;
}

#kt_table thead th:nth-child(4), #kt_table tbody td:nth-child(4) {
	width: 222px !important;
	min-width: 222px !important;
}

#kt_table thead th:nth-child(5), #kt_table tbody td:nth-child(5) {
	width: 150px !important;
	min-width: 150px !important;
}

#kt_table thead th:nth-child(6), #kt_table tbody td:nth-child(6) {
	width: 120px !important;
	min-width: 120px !important;
}

#kt_table {
	width: 100% !important;
}

#kt_table.dataTable {
	width: 100% !important;
}

.dataTables_wrapper {
	width: 100% !important;
}

table.dataTable tbody td {
	box-sizing: border-box !important;
}
</style>
</head>
<body>
	<!--begin::Main-->
	<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
		<div class="d-flex flex-column flex-column-fluid">
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container"
					class="app-container container-xxl d-flex flex-stack">
					<div
						class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<h1
							class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">Jobsite</h1>
						<ul
							class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/demo_dashboard"
								class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted">Master</li>
						</ul>
					</div>
				</div>
			</div>

			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container"
					class="app-container container-xxl">
					<!--begin::Card-->
					<div class="card">
						<div class="card-header border-0 pt-6 align-items-start">
							<div class="card-title pt-3">
								<h3 class="page-heading d-flex text-gray-900 fw-semibold my-0">Job
									Site List</h3>
							</div>

							<div class="card-toolbar d-flex flex-column align-items-end">
								<div class="d-flex mb-3">
									<button type="button" class="btn btn-success btn-lg fw-medium"
										onclick="addJobsite()">
										<i class="ki-duotone ki-plus fs-2"></i> <span
											onclick="addJobsite()">Create</span>
									</button>
								</div>
							</div>
						</div>

						<div class="card-body pt-0">

							<!--begin::Filters (Search + Status)-->
							<div
								class="d-flex flex-column flex-md-row align-items-md-center gap-4 mb-6">

								<!-- Search box -->
								<div class="position-relative flex-grow-1">
									<select id="jobsiteFilter"
										class="form-select form-select-lg h-lg-55px py-3 fw-medium text-muted"
										data-control="select2" data-placeholder="Search">
										<option value="">All</option>
										<c:forEach var="j" items="${jobsiteList}">
											<option value="${j.name_site}">${j.name_site}</option>
										</c:forEach>
									</select>
								</div>

								<!-- Status dropdown -->
								<div class="d-flex align-items-center">
									<select id="statusFilter"
										class="form-select form-select-lg h-lg-55px py-3 fw-medium text-gray-800"
										style="width: 310px;">
										<option value="all" selected>Status: All</option>
										<option value="active">Active</option>
										<option value="inactive">Inactive</option>
									</select>
								</div>

							</div>
							<!--end::Filters-->

							<div class="table-responsive">
								<table
									class="table table-striped table-hover align-middle table-row-bordered"
									id="kt_table">

									<thead>
										<tr
											class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 border-bottom border-gray-200"
											style="height: 39px;">
											<th class="min-w-75px w-75px text-center">#</th>
											<th class="min-w-222px w-222px ">Jobsite Name</th>
											<th class="min-w-222px w-222px ">Team Amount</th>
											<th class="min-w-222px w-222px ">Description</th>
											<th class="min-w-150px w-150px ">STATUS</th>
											<th class="text-end pe-5 min-w-120px w-120px">Actions</th>
										</tr>
									</thead>

									<tbody id="jobsiteTable" class="fw-normal fs-6 text-gray-900"
										style="height: 61px;">
										<c:forEach var="j" items="${jobsiteList}" varStatus="st">
											<tr
												class="jobsite-row align-middle border-bottom border-gray-200">

												<!-- Row Number -->
												<td class="min-w-75px w-75px fw-bold text-center px-0">${st.index + 1}</td>

												<td class="min-w-222px w-222px name-column"
													data-order="${fn:toUpperCase(j.name_site)}"
													data-search="${j.name_site}">${j.name_site}</td>

												<td class="min-w-222px w-222px">${j.team_amount}</td>

												<td class="min-w-150px w-150px">${j.description}</td>

												<!-- STATUS -->
												<td class="status-column" data-status="${j.is_active}">
													<div
														class="form-check form-switch form-switch-sm form-check-success">
														<input class="form-check-input status-toggle"
															type="checkbox" style="width: 33px;"
															data-id="${j.id_sitejob}"
															<c:if test="${j.is_active == '1'}">checked</c:if> />
													</div>
												</td>

												<td class="text-end text-nowrap pe-5">
													<div
														class="d-inline-flex align-items-center justify-content-end gap-2">

														<!-- Edit -->
														<button type="button"
															class="btn btn-icon btn-sm btn-light-primary"
															style="width: 35px; height: 35px; padding: 0;"
															onclick="window.location.href='${pageContext.request.contextPath}/editJobsite?id=${j.id_sitejob}'">
															<i class="ki-duotone ki-pencil fs-1"> <span
																class="path1"></span><span class="path2"></span>
															</i>
														</button>

														<!-- Delete -->
														<button type="button"
															class="btn btn-icon btn-sm btn-light-danger btn-delete-jobsite"
															data-id="${j.id_sitejob}" aria-label="Delete"
															style="width: 35px; height: 35px; padding: 0;">
															<i class="ki-duotone ki-trash fs-1"> <span
																class="path1"></span><span class="path2"></span> <span
																class="path3"></span><span class="path4"></span> <span
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
					<!--end::Card-->
				</div>
			</div>
		</div>
	</div>
	<script>
	function addJobsite() {
	    window.location.href = "${pageContext.request.contextPath}/jobsite_add";
	}
	</script>

	<!-- Delete confirm -->
	<script type="text/javascript">
		document.querySelectorAll('.btn-delete-jobsite').forEach(function(btn){
		    btn.addEventListener('click', function(){
		        var siteId = this.getAttribute('data-id');
		
		        Swal.fire({
		            title: 'Are you sure?',
		            text: "You will be deleting this jobsite!",
		            icon: 'warning',
		            showCancelButton: true,
		            confirmButtonColor: '#3085d6',
		            cancelButtonColor: '#d33',
		            confirmButtonText: 'Yes, delete it!'
		        }).then((result) => {
		            if (result.isConfirmed) {
		                window.location.href =
		                    '${pageContext.request.contextPath}/deleteJobsite?id_sitejob='
		                    + encodeURIComponent(siteId);
		            }
		        });
		    });
		});
		</script>

	<!-- DataTable + Select2 + Filter-->
	<script type="text/javascript">
	$(document).ready(function () {
	
	    // 1. Initialize Select2
	    $('#jobsiteFilter').select2({
	        width: '100%',
	        placeholder: 'Search',
	        allowClear: true,
	        sorter: function (data) {
	            const term = ($('.select2-search__field').val() || '').toLowerCase();
	            return data.sort(function (a, b) {
	                const aText = (a.text || '').toLowerCase();
	                const bText = (b.text || '').toLowerCase();
	                const aStarts = aText.startsWith(term);
	                const bStarts = bText.startsWith(term);
	                if (aStarts && !bStarts) return -1;
	                if (!aStarts && bStarts) return 1;
	                return aText.localeCompare(bText);
	            });
	        }
	    });
	
		// 2. Initialize DataTable
		    var table = $('#kt_table').DataTable({
		        paging: true,
		        lengthChange: true,
		        lengthMenu: [
		        	[10, 25, 50 , -1], 
		        	[10, 25, 50, "All"]
		        ],
		        info: false,
		        searching: true,
		        ordering: true,
		        order: [],
		        autoWidth: false,
		        scrollCollapse: true,
		        
		        columnDefs: [
		            { orderable: false, targets: [0, 2, 3, 4, 5] },
		            { orderable: true, targets: 1 },
		            { className: 'dt-center', targets: 0 },
		            { className: 'dt-left', targets: 2 }
		        ],
		
		        language: {
		            emptyTable: "No data",
		            paginate: {
		                previous: "Previous",
		                next: "Next"
		            }
		        }
		    });
		
		    // 3. Custom Filter Function สำหรับ DataTable
		    $.fn.dataTable.ext.search.push(
		        function(settings, data, dataIndex) {
		            if (settings.nTable.id !== 'kt_table') {
		                return true;
		            }
		
		            const siteVal = $('#jobsiteFilter').val();
		            const statusVal = $('#statusFilter').val();
		            
		            // data[1] = Jobsite Name
		            const name = data[1];
		            
		            // ดึง status จาก DOM
		            const row = table.row(dataIndex).node();
		            const status = $(row).find('.status-column').attr('data-status');
		            
		            // Filter by site
		            let matchSite = true;
		            if (siteVal && siteVal !== '') {
		                matchSite = (name === siteVal);
		            }
		            
		            // Filter by status
		            let matchStatus = true;
		            if (statusVal === 'active') {
		                matchStatus = (status === "1");
		            } else if (statusVal === 'inactive') {
		                matchStatus = (status === "0" || !status || status === "");
		            }
		            
		            return matchSite && matchStatus;
		        }
		    );
		
		    // 4. Event listeners สำหรับ filters
		    $('#jobsiteFilter, #statusFilter').on('change', function() {
		        table.draw();
		    });
		
		    // 5. Initial draw
		    table.draw();
		});
	</script>

	<script>
	$(document).ready(function() {
	    $(document).on('change', '.status-toggle', function() {
	        var $checkbox = $(this);
	        var siteId = $checkbox.data('id');
	        var isActive = $checkbox.is(':checked') ? '1' : '0';

	        $.ajax({
	            url: '${pageContext.request.contextPath}/updateJobsiteStatus', 
	            type: 'POST',
	            data: {
	                id_sitejob: siteId,
	                is_active: isActive
	            },
	            success: function(response) {
	                $checkbox.closest('td').attr('data-status', isActive);
	            },
	            error: function(xhr, status, error) {
	                $checkbox.prop('checked', !$checkbox.is(':checked'));
	            }
	        });
	    });
	});
	</script>

</body>
</html>