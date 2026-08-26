<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<fmt:setLocale value="en_US" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css"/>
<script src="assets/plugins/global/plugins.bundle.js"></script>

<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>
<link
	href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<style type="text/css">
[data-bs-theme="light"] #purchaseOrderList.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #FBFBFB !important; 
    box-shadow: none !important;
  }
 [data-bs-theme="dark"] #purchaseOrderList.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #191B20 !important; 
    box-shadow: none !important;
  }

#purchaseOrderList thead th.sorting:after, #purchaseOrderList thead th.sorting_asc:after,
#purchaseOrderList thead th.sorting_desc:after, #purchaseOrderList thead th.sorting:before,	
#purchaseOrderList thead th.sorting_asc:before, #purchaseOrderList thead th.sorting_desc:before
	{
	position: absolute !important;
	top: 10px !important;
	right: 10px !important;
	display: block !important;
	opacity: 0.5;
}

#purchaseOrderList thead th.sorting:before {
	margin-top: -6px;
}

#purchaseOrderList thead th.sorting:after {
	margin-top: 4px;
}

/* .border-cyan {
	border-color: #0DCAF0 !important;
}  */
</style>

</head>
<body class="app-default">
	<div class="app-main flex-column flex-row-fluid">
		<div class="d-flex flex-column flex-column-fluid">
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
					<div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<h1 class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
							PO - Purchase Order</h1>
						<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a
								class="text-muted text-hover-primary">Home</a>
							</li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span>
							</li>
							<li class="breadcrumb-item text-muted"><a
								class="text-muted text-hover-primary">Product</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			
			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container" class="app-container container-fluid">
					<form action="" method="post" id="filterForm">
						<div class="card mb-10">
							<div class="card-body filter-card px-10 py-9 rounded-3">
								<div class="row g-5">
									<div class="col-md-9 position-relative">
										<!-- Search -->
										<i class="ki-duotone ki-magnifier fs-3 position-absolute ms-5 top-50 translate-middle-y">
											<span class="path1"></span><span class="path2"></span></i> <input
											type="text" class="form-control form-solid ps-14"
											id="tableSearch" placeholder="All">
					
									</div>
									<div class="col-md-3">
										<div class="position-relative d-flex align-items-center">
									        <i class="ki-duotone ki-calendar-8 position-absolute ms-4 mb-1 text-gray-500 fs-2">
									            <span class="path1"></span>
									            <span class="path2"></span>
									            <span class="path3"></span>
									            <span class="path4"></span>
									            <span class="path5"></span>
									            <span class="path6"></span>
									        </i>
									
									        <input class="form-control ps-12"
									               id="kt_daterangepicker_2" placeholder="Select date"/>
									    </div>
									</div>
								</div>
							</div>
						</div>
					</form>
					<div class="card mb-10">
						<div class="card-header border-0 px-9 pt-7 d-flex align-items-center justify-content-between">
							
							<div class="card-title">
								<h3 class="fw-semibold text-gray-900">PO - Purchase Order List</h3>
							</div>
							
							<a class="btn btn-lg btn-success fw-medium text-white px-6 py-4"
								href="/purchase_order_add"><i class="ki-outline ki-plus fs-3 me-1"></i>Create</a>
							
						</div>
						<div class="card-body filter-card px-10 py-9 rounded-3">
						<!-- Summary PO -->
						<!-- <div class="d-flex flex-row justify-content-center mb-10">					
							<div class="row align-items-center mt-10 mx-5 fs-6 fw-bold">
								
								<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-primary rounded-3 py-3 px-1" data-status="All" data-border-color="border-primary" style="cursor: pointer;">
									<span class="fs-2hx me-2 text-primary" id="summaryPOAll">${poSummaryTotal}</span>
									<span class="badge badge-primary fs-7">All</span>
								</div>
								
								<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3" data-status="${poStatusNames['1']}" data-border-color="border-gray-400" style="cursor: pointer;">
									<span class="fs-2hx me-2 text-gray-600" id="summaryPODraft">${poSummary['1']}</span>
									<span class="badge badge-light fs-7">${poStatusNames['1']}</span>
								</div>
								
								<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3" data-status="${poStatusNames['2']}" data-border-color="border-warning" style="cursor: pointer;">
									<span class="fs-2hx me-2 text-warning" id="summaryPOPending">${poSummary['2']}</span>
									<span class="badge badge-warning fs-7">${poStatusNames['2']}</span>
								</div>
								
								
								<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3" data-status="${poStatusNames['3']}" data-border-color="border-success" style="cursor: pointer;">
									<span class="fs-2hx me-2 text-success" id="summaryPOApproved">${poSummary['3']}</span>
									<span class="badge badge-success fs-7">${poStatusNames['3']}</span>
								</div>
								
								<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3" data-status="${poStatusNames['4']}" data-border-color="border-info" style="cursor: pointer;">
									<span class="fs-2hx me-2 text-info" id="summaryPOReturn">${poSummary['4']}</span>
									<span class="badge badge-info fs-7 lh-base">${poStatusNames['4']}</span>
								</div>
								
								<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3" data-status="${poStatusNames['5']}" data-border-color="border-danger" style="cursor: pointer;">
									<span class="fs-2hx me-2 text-danger" id="summaryPORejected">${poSummary['5']}</span>
									<span class="badge badge-danger fs-7">${poStatusNames['5']}</span>
								</div>
								
								<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3" data-status="${poStatusNames['6']}" data-border-color="border-dark" style="cursor: pointer;">
									<span class="fs-2hx me-2 text-dark" id="summaryPOCancel">${poSummary['6']}</span>
									<span class="badge badge-dark fs-7">${poStatusNames['6']}</span>
								</div>

								<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3" data-status="${poStatusNames['7']}" data-border-color="border-cyan" style="cursor: pointer;">
									<span class="fs-2hx me-2 text-cyan" id="summaryPOInProgress">${poSummary['7']}</span>
									<span class="badge badge-cyan fs-7">${poStatusNames['7']}</span>
								</div>
							</div>
						</div> -->
						<!-- Summary PO -->
							<div class="d-flex flex-row justify-content-center mb-10">
								<div class="row align-items-center mt-10 mx-5 fs-6 fw-bold">

									<!-- All -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-primary rounded-3 py-3 px-1"
										data-status="All"
										data-border-color="border-primary"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 text-primary" id="summaryPOAll">
											${poSummaryTotal}
										</span>

										<span class="badge badge-primary fs-7">All</span>
									</div>

									<!-- Draft -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3"
										data-status="1"
										data-border-color="${poStatusColors['1'] == 'secondary' ? 'border-gray-400' : 'border-'.concat(poStatusColors['1'])}"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 ${poStatusColors['1'] == 'secondary' ? 'text-gray-600' : 'text-'.concat(poStatusColors['1'])}"
											id="summaryPODraft">
											${poSummary['1']}
										</span>

										<span class="badge badge-${poStatusColors['1']} fs-7">
											${poStatusNames['1']}
										</span>
									</div>

									<!-- Pending -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3"
										data-status="2"
										data-border-color="${poStatusColors['2'] == 'secondary' ? 'border-gray-400' : 'border-'.concat(poStatusColors['2'])}"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 ${poStatusColors['2'] == 'secondary' ? 'text-gray-600' : 'text-'.concat(poStatusColors['2'])}"
											id="summaryPOPending">
											${poSummary['2']}
										</span>

										<span class="badge badge-${poStatusColors['2']} fs-7">
											${poStatusNames['2']}
										</span>
									</div>

									<!-- Approved -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3"
										data-status="3"
										data-border-color="${poStatusColors['3'] == 'secondary' ? 'border-gray-400' : 'border-'.concat(poStatusColors['3'])}"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 ${poStatusColors['3'] == 'secondary' ? 'text-gray-600' : 'text-'.concat(poStatusColors['3'])}"
											id="summaryPOApproved">
											${poSummary['3']}
										</span>

										<span class="badge badge-${poStatusColors['3']} fs-7">
											${poStatusNames['3']}
										</span>
									</div>

									<!-- Return -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3"
										data-status="4"
										data-border-color="${poStatusColors['4'] == 'secondary' ? 'border-gray-400' : 'border-'.concat(poStatusColors['4'])}"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 ${poStatusColors['4'] == 'secondary' ? 'text-gray-600' : 'text-'.concat(poStatusColors['4'])}"
											id="summaryPOReturn">
											${poSummary['4']}
										</span>

										<span class="badge badge-${poStatusColors['4']} fs-7 lh-base">
											${poStatusNames['4']}
										</span>
									</div>

									<!-- Rejected -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3"
										data-status="5"
										data-border-color="${poStatusColors['5'] == 'secondary' ? 'border-gray-400' : 'border-'.concat(poStatusColors['5'])}"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 ${poStatusColors['5'] == 'secondary' ? 'text-gray-600' : 'text-'.concat(poStatusColors['5'])}"
											id="summaryPORejected">
											${poSummary['5']}
										</span>

										<span class="badge badge-${poStatusColors['5']} fs-7">
											${poStatusNames['5']}
										</span>
									</div>

									<!-- Cancel -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3"
										data-status="6"
										data-border-color="${poStatusColors['6'] == 'secondary' ? 'border-gray-400' : 'border-'.concat(poStatusColors['6'])}"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 ${poStatusColors['6'] == 'secondary' ? 'text-gray-600' : 'text-'.concat(poStatusColors['6'])}"
											id="summaryPOCancel">
											${poSummary['6']}
										</span>

										<span class="badge badge-${poStatusColors['6']} fs-7">
											${poStatusNames['6']}
										</span>
									</div>

									<!-- In-Progress -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3"
										data-status="7"
										data-border-color="${poStatusColors['7'] == 'secondary' ? 'border-gray-400' : 'border-'.concat(poStatusColors['7'])}"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 ${poStatusColors['7'] == 'secondary' ? 'text-gray-600' : 'text-'.concat(poStatusColors['7'])}"
											id="summaryPOInProgress">
											${poSummary['7']}
										</span>

										<span class="badge badge-${poStatusColors['7']} fs-7">
											${poStatusNames['7']}
										</span>
									</div>

								</div>
							</div>
														
							<div class="table-responsive ">
								<table id="purchaseOrderList"
										class="table table-striped gy-7 gs-7 table-hover border-gray-300 table-row-bordered table-row-gray-200 ">
									<thead class="border-bottom-1 text-uppercase">
										<tr class="fs-7 fw-bold text-gray-500">
											<th class="min-w-50px text-center">#</th>
											<th class="min-w-80px text-start">PO ID</th>
											<th class="min-w-80px text-start">PR Ref</th>
											<th class="min-w-200px text-start">Request Name</th>
											<th class="min-w-150px text-start">Request Date</th>
											<th class="min-w-130px text-end">Product Item</th>
											<th class="min-w-130px text-end">Status</th>
											<th class="min-w-130px text-end px-3">Actions</th>
										</tr>
									</thead>
	
									<tbody>
									<c:forEach var="poItem" items="${poList}">
										<tr class="align-middle">
											<td class="text-gray-900 fs-6 fw-normal text-center row-number"></td>
											<td class="text-gray-900 fs-6 fw-normal text-start">
												${poItem.po_id}
											</td>
											<td class="text-gray-900 fs-6 fw-normal text-start">
												<c:choose>
													<c:when test="${poItem.pr_ref_count > 0}">
														${poItem.pr_ref_count}
													</c:when>
													<c:otherwise>
														-
													</c:otherwise>
												</c:choose>
											</td>
											<td class="text-gray-900 fs-6 fw-normal text-start">
												${poItem.user_create_name}
											</td>
											<td class="text-gray-900 fs-6 fw-normal text-start">
												<fmt:formatDate value="${poItem.time_create}" pattern="dd MMM yyyy, HH:mm" />
											</td>
											<td class="text-gray-900 fs-6 fw-normal text-end">
												${poItem.detail_count}
											</td>
											<!-- <td class="text-gray-900 fs-6 fw-normal text-end">
												<c:choose>
													<c:when test="${poItem.status == '1'}">
														<span class="badge badge-lg bg-secondary fw-semibold fs-7">${poItem.status_name}</span>
													</c:when>

													<c:when test="${poItem.status == '3'}">
														<span class="badge badge-lg bg-success text-white fw-semibold fs-7">${poItem.status_name}</span>
													</c:when>

													<c:when test="${poItem.status == '2'}">
														<span class="badge badge-lg badge-warning text-white fw-semibold fs-7">${poItem.status_name}</span>
													</c:when>

													<c:when test="${poItem.status == '4'}">
														<span class="badge badge-lg badge-info text-white fw-semibold fs-7">${poItem.status_name}</span>
													</c:when>
													
													<c:when test="${poItem.status == '5'}">
														<span class="badge badge-lg bg-danger text-white fw-semibold fs-7">${poItem.status_name}</span>
													</c:when>

													<c:when test="${poItem.status == '6'}">
														<span class="badge badge-lg bg-dark text-white fw-semibold fs-7">${poItem.status_name}</span>
													</c:when>

													<c:when test="${poItem.status == '7'}">
														<span class="badge badge-lg bg-cyan text-white fw-semibold fs-7">${poItem.status_name}</span>
													</c:when>

													<c:otherwise></c:otherwise>
												</c:choose>
											</td> -->
											<td class="text-gray-900 fs-6 fw-normal text-end" data-code="${poItem.status}">
												<span class="badge badge-lg badge-${poItem.status_color} fw-semibold fs-7 ${poItem.status_color == 'secondary' ? 'text-dark' : 'text-white'}">
													${poItem.status_name}
												</span>
											</td>
											<td class="text-end px-3">
												<div class="d-flex justify-content-end align-items-center gap-2">
													<a  href="purchase_order_edit?poId=${poItem.po_id}"
														class="btn btn-icon btn-light-primary btn-sm"
														title="Edit"> <i class="ki-duotone ki-pencil fs-2"><span
														class="path1"></span><span class="path2"></span></i>
													</a> 
													
													<!-- <a href="po_perform_delete?poId=${poItem.po_id}" onclick="return confirmDelete(this.href);"
														class="btn btn-icon btn-light-danger btn-sm" title="Delete">
														<i class="ki-duotone ki-trash fs-2"><span
															class="path1"></span><span class="path2"></span><span
															class="path3"></span><span class="path4"></span><span
															class="path5"></span></i>
													</a> -->
													<c:choose>
														<c:when test="${poItem.status == '1' or poItem.status == '4'}">
															<a href="po_perform_delete?poId=${poItem.po_id}" onclick="return confirmDelete(this.href);"
																class="btn btn-icon btn-light-danger btn-sm" title="Delete">
																<i class="ki-duotone ki-trash fs-2"><span
																	class="path1"></span><span class="path2"></span><span
																	class="path3"></span><span class="path4"></span><span
																	class="path5"></span></i>
															</a>
														</c:when>
														<c:otherwise>
															<a class="btn btn-icon btn-light-danger btn-sm disabled"
																title="Delete" style="pointer-events: none; opacity: 0.5; cursor: not-allowed;"
																aria-disabled="true">
																<i class="ki-duotone ki-trash fs-2"><span
																	class="path1"></span><span class="path2"></span><span
																	class="path3"></span><span class="path4"></span><span
																	class="path5"></span></i>
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
	</div>

</body>
<script type="text/javascript">
	
		document.addEventListener("DOMContentLoaded", function () {
			$("#kt_daterangepicker_2").daterangepicker({
			    startDate: moment().startOf("month"),
			    endDate: moment().endOf("month"),
			    locale: {
			        format: "D MMM YYYY"
			    }
			});
			
			var table = $('#purchaseOrderList').DataTable({
				pageLength : 25,
				lengthMenu : [ 25, 50, 100 ],
				ordering : true,
				searching : true,
				autoWidth : false,
				info: false,
				language: {
				    zeroRecords: "No data found",
				    emptyTable: "No data available in table"
				},
				columnDefs : [ {
					orderable : false,
					targets : [ 7 ]
				}, {
					orderable : true,
					targets : [ 0, 1, 2, 3, 4, 5, 6 ]
				}, {
					targets: [ 5 ],
					type: 'string'
				} ],
				order : [],
				headerCallback : function(thead) {
					$(thead).find('th').each(
						function() {
							if ($(this).find('.th-wrapper').length === 0) {
								$(this).wrapInner(
									'<span class="th-wrapper" style="display:inline-flex; align-items:center; white-space:nowrap; pointer-events:none;"></span>');
							}
					});
				}
			});
			
			//search
			$('#tableSearch').on('keyup', function() {
				table.search(this.value).draw();
		    });
			
			/* ---- Summary Card Filter ---- */
			var selectedStatusCode = null; // null = All
			$.fn.dataTable.ext.search.push(function(settings, searchData, dataIndex) {
				if (settings.nTable.id !== 'purchaseOrderList') {
					return true;
				}
				if (selectedStatusCode === null) {
					return true;
				}
				var cellCode = $(settings.aoData[dataIndex].anCells[6]).data('code');
				return String(cellCode) === String(selectedStatusCode);
			});

			$('.summary-card').on('click', function() {
			    $('.summary-card').each(function() {
			        var colorClass = $(this).data('border-color');
			        $(this).removeClass(colorClass).addClass('border-transparent');
			    });

			    var activeColor = $(this).data('border-color');
			    $(this).removeClass('border-transparent').addClass(activeColor);

			    var status = $(this).data('status');
			    selectedStatusCode = (status === "All") ? null : status;
			    table.draw();
			});
			
			
			//running number
			function runNumber() {
				const info = table.page.info();
				table.column(0, {
					page : 'current'
				}).nodes().each(function(cell, i) {
					cell.innerHTML = info.start + i + 1;
				});
			}
			
			table.on('draw.dt order.dt search.dt', runNumber);
			runNumber();
			
			//search
			$('#tableSearch').on('keyup', function() {
				table.search(this.value).draw();
		    });

			$(document).ready(function() {
				$('[data-kt-select2="true"]').select2({
					closeOnSelect : false
				});
			});			
		
	});
		
		
		function confirmDelete(url) {
		    Swal.fire({
		    	title: "Are you sure?!",
		        text: "Are you sure you want to delete this item?",
		        icon: "warning",
		        showCancelButton: true,
		        confirmButtonText: "Yes, delete it",
		        cancelButtonText: "Cancel",
		        buttonsStyling: false,
		        customClass: {
		            confirmButton: "btn btn-danger",
		            cancelButton: "btn btn-secondary"
		        }
		    }).then((result) => {
		        if (result.isConfirmed) {
		            window.location.href = url;
		        }
		    });
		    return false;
		}
	</script>
</html>