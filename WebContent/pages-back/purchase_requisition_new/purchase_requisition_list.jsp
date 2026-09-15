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
[data-bs-theme="light"] #purchaseRequisitionList.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #FBFBFB !important; 
    box-shadow: none !important;
  }
 [data-bs-theme="dark"] #purchaseRequisitionList.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #191B20 !important; 
    box-shadow: none !important;
  }

#purchaseRequisitionList thead th.sorting:after, #purchaseRequisitionList thead th.sorting_asc:after,
#purchaseRequisitionList thead th.sorting_desc:after, #purchaseRequisitionList thead th.sorting:before,	
#purchaseRequisitionList thead th.sorting_asc:before, #purchaseRequisitionList thead th.sorting_desc:before
	{
	position: absolute !important;
	top: 10px !important;
	right: 10px !important;
	display: block !important;
	opacity: 0.5;
}

#purchaseRequisitionList thead th.sorting:before {
	margin-top: -6px;
}

#purchaseRequisitionList thead th.sorting:after {
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
							PR - Purchase Requisition</h1>
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
								<h3 class="fw-semibold text-gray-900">PR - Purchase Requisition List</h3>
							</div>
							
							<a class="btn btn-lg btn-success fw-medium text-white px-6 py-4"
								href="/purchase_requisition_add"><i class="ki-outline ki-plus fs-3 me-1"></i>Create</a>
							
						</div>
						<div class="card-body filter-card px-10 py-9 rounded-3">
						<!-- Summary PR -->
							<div class="d-flex flex-row justify-content-center mb-10">
								<div class="row align-items-center mt-10 mx-5 fs-6 fw-bold">

									<!-- All -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-primary rounded-3 py-3 px-1"
										data-status="All"
										data-border-color="border-primary"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 text-primary" id="summaryPRAll">
											${prSummaryTotal}
										</span>

										<span class="badge badge-primary fs-7">All</span>
									</div>

									<!-- Draft -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3"
										data-status="1"
										data-border-color="${prStatusColors['1'] == 'secondary' ? 'border-gray-400' : 'border-'.concat(prStatusColors['1'])}"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 ${prStatusColors['1'] == 'secondary' ? 'text-gray-600' : 'text-'.concat(prStatusColors['1'])}"
											id="summaryPRDraft">
											${prSummary['1']}
										</span>

										<span class="badge badge-${prStatusColors['1']} fs-7">
											${prStatusNames['1']}
										</span>
									</div>

									<!-- Pending -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3"
										data-status="2"
										data-border-color="${prStatusColors['2'] == 'secondary' ? 'border-gray-400' : 'border-'.concat(prStatusColors['2'])}"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 ${prStatusColors['2'] == 'secondary' ? 'text-gray-600' : 'text-'.concat(prStatusColors['2'])}"
											id="summaryPRPending">
											${prSummary['2']}
										</span>

										<span class="badge badge-${prStatusColors['2']} fs-7">
											${prStatusNames['2']}
										</span>
									</div>

									<!-- Approved -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3"
										data-status="3"
										data-border-color="${prStatusColors['3'] == 'secondary' ? 'border-gray-400' : 'border-'.concat(prStatusColors['3'])}"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 ${prStatusColors['3'] == 'secondary' ? 'text-gray-600' : 'text-'.concat(prStatusColors['3'])}"
											id="summaryPRApproved">
											${prSummary['3']}
										</span>

										<span class="badge badge-${prStatusColors['3']} fs-7">
											${prStatusNames['3']}
										</span>
									</div>

									<!-- Return -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3"
										data-status="4"
										data-border-color="${prStatusColors['4'] == 'secondary' ? 'border-gray-400' : 'border-'.concat(prStatusColors['4'])}"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 ${prStatusColors['4'] == 'secondary' ? 'text-gray-600' : 'text-'.concat(prStatusColors['4'])}"
											id="summaryPRReturn">
											${prSummary['4']}
										</span>

										<span class="badge badge-${prStatusColors['4']} fs-7 lh-base">
											${prStatusNames['4']}
										</span>
									</div>

									<!-- Rejected -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3"
										data-status="5"
										data-border-color="${prStatusColors['5'] == 'secondary' ? 'border-gray-400' : 'border-'.concat(prStatusColors['5'])}"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 ${prStatusColors['5'] == 'secondary' ? 'text-gray-600' : 'text-'.concat(prStatusColors['5'])}"
											id="summaryPRRejected">
											${prSummary['5']}
										</span>

										<span class="badge badge-${prStatusColors['5']} fs-7">
											${prStatusNames['5']}
										</span>
									</div>

									<!-- Cancel -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3"
										data-status="6"
										data-border-color="${prStatusColors['6'] == 'secondary' ? 'border-gray-400' : 'border-'.concat(prStatusColors['6'])}"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 ${prStatusColors['6'] == 'secondary' ? 'text-gray-600' : 'text-'.concat(prStatusColors['6'])}"
											id="summaryPRCancel">
											${prSummary['6']}
										</span>

										<span class="badge badge-${prStatusColors['6']} fs-7">
											${prStatusNames['6']}
										</span>
									</div>

									<!-- In-Progress -->
									<div class="col-lg-3 col-md-4 col-6 d-flex align-items-center justify-content-center mb-5 summary-card border border-1 border-transparent rounded-3 p-3"
										data-status="7"
										data-border-color="${prStatusColors['7'] == 'secondary' ? 'border-gray-400' : 'border-'.concat(prStatusColors['7'])}"
										style="cursor: pointer;">

										<span class="fs-2hx me-2 ${prStatusColors['7'] == 'secondary' ? 'text-gray-600' : 'text-'.concat(prStatusColors['7'])}"
											id="summaryPRInProgress">
											${prSummary['7']}
										</span>

										<span class="badge badge-${prStatusColors['7']} fs-7">
											${prStatusNames['7']}
										</span>
									</div>

								</div>
							</div>
														
							<div class="table-responsive ">
								<table id="purchaseRequisitionList"
										class="table table-striped gy-7 gs-7 table-hover border-gray-300 table-row-bordered table-row-gray-200 ">
									<thead class="border-bottom-1 text-uppercase">
										<tr class="fs-7 fw-bold text-gray-500">
											<th class="min-w-50px text-center">#</th>
											<th class="min-w-80px text-start">PR ID</th>
											<th class="min-w-80px text-start">MR Ref</th>
											<th class="min-w-200px text-start">Request Name</th>
											<th class="min-w-150px text-start">Request Date</th>
											<th class="min-w-130px text-end">Product Item</th>
											<th class="min-w-130px text-end">Status</th>
											<th class="min-w-130px text-end px-3">Actions</th>
										</tr>
									</thead>
	
									<tbody>
									<c:forEach var="prItem" items="${prList}">
										<tr class="align-middle">
											<td class="text-gray-900 fs-6 fw-normal text-center row-number"></td>
											<td class="text-gray-900 fs-6 fw-normal text-start">
												${prItem.pr_id}
											</td>
											<td class="text-gray-900 fs-6 fw-normal text-start">
												<c:choose>
													<c:when test="${prItem.mr_ref_count > 0}">
														${prItem.mr_ref_count}
													</c:when>
													<c:otherwise>
														-
													</c:otherwise>
												</c:choose>
											</td>
											<td class="text-gray-900 fs-6 fw-normal text-start">
												${prItem.user_create_name}
											</td>
											<td class="text-gray-900 fs-6 fw-normal text-start">
												<fmt:formatDate value="${prItem.time_create}" pattern="dd MMM yyyy, HH:mm" />
											</td>
											<td class="text-gray-900 fs-6 fw-normal text-end">
												${prItem.detail_count}
											</td>
											
											<!-- <td class="text-gray-900 fs-6 fw-normal text-end" data-code="${prItem.status}">
												<span class="badge badge-lg badge-${prItem.status_color} fw-semibold fs-7 ${prItem.status_color == 'secondary' ? 'text-dark' : 'text-white'}">
													${prItem.status_name}
												</span>
											</td> -->
											<td class="text-gray-900 fs-6 fw-normal text-end" data-code="${prItem.status}">
												<c:if test="${prItem.status == '7'}">
													<c:set var="progress" value="${prDetailProgress[prItem.pr_id]}" />
													<c:set var="doneCount" value="${empty progress ? 0 : progress[0]}" />
													<c:set var="totalCount" value="${empty progress ? 0 : progress[1]}" />

													<c:choose>
														<c:when test="${totalCount > 0 and doneCount >= totalCount}">
															<span class="badge badge-lg bg-success text-white fs-7 fw-semibold text-center d-inline-flex align-items-center justify-content-center">
																${doneCount}
															</span>
														</c:when>
														<c:otherwise>
															<span class="badge badge-lg bg-cyan text-white fs-7 fw-semibold text-center d-inline-flex align-items-center justify-content-center">
																${doneCount}
															</span>
														</c:otherwise>
													</c:choose>
												</c:if>

												<span class="badge badge-lg badge-${prItem.status_color} fw-semibold fs-7 ${prItem.status_color == 'secondary' ? 'text-dark' : 'text-white'}">
													${prItem.status_name}
												</span>
											</td>
											<td class="text-end px-3">
												<div class="d-flex justify-content-end align-items-center gap-2">
													<a  href="purchase_requisition_edit?prId=${prItem.pr_id}"
														class="btn btn-icon btn-light-primary btn-sm"
														title="Edit"> <i class="ki-duotone ki-pencil fs-2"><span
														class="path1"></span><span class="path2"></span></i>
													</a> 
													
													<!-- <a href="pr_perform_delete?prId=${prItem.pr_id}" onclick="return confirmDelete(this.href);"
														class="btn btn-icon btn-light-danger btn-sm" title="Delete">
														<i class="ki-duotone ki-trash fs-2"><span
															class="path1"></span><span class="path2"></span><span
															class="path3"></span><span class="path4"></span><span
															class="path5"></span></i>
													</a> -->
													<c:choose>
														<c:when test="${prItem.status == '1' or prItem.status == '4'}">
															<a href="pr_perform_delete?prId=${prItem.pr_id}" onclick="return confirmDelete(this.href);"
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
			
			var table = $('#purchaseRequisitionList').DataTable({
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
				if (settings.nTable.id !== 'purchaseRequisitionList') {
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