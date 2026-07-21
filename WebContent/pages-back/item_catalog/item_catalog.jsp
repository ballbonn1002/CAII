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

<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/style.bundle.css"
	rel="stylesheet" />

<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>
<link
	href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<style>
[data-bs-theme="light"] #equipmentList.table.table-striped > tbody > tr:nth-of-type(odd) > *,
[data-bs-theme="light"] #consumablesList.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #FBFBFB !important; 
    box-shadow: none !important;
  }
[data-bs-theme="dark"] #equipmentList.table.table-striped > tbody > tr:nth-of-type(odd) > *,
[data-bs-theme="dark"] #consumablesList.table.table-striped > tbody > tr:nth-of-type(odd) > * {
    background-color: #191B20 !important; 
    box-shadow: none !important;
  }

#equipmentList thead th,
#consumablesList thead th {
	white-space: nowrap !important;
	position: relative !important;
	padding-right: 35px !important;
	cursor: pointer;
}

#equipmentList thead th.no-sort, #consumablesList thead th.no-sort {
    padding-right: 12px !important;
}

#equipmentList thead th.sorting:after, #equipmentList thead th.sorting_asc:after,
#equipmentList thead th.sorting_desc:after, #equipmentList thead th.sorting:before,	
#equipmentList thead th.sorting_asc:before, #equipmentList thead th.sorting_desc:before,
#consumablesList thead th.sorting:after, #consumablesList thead th.sorting_asc:after,
#consumablesList thead th.sorting_desc:after, #consumablesList thead th.sorting:before,	
#consumablesList thead th.sorting_asc:before, #consumablesList thead th.sorting_desc:before
	{
	position: absolute !important;
	top: 10px !important;
	right: 10px !important;
	display: block !important;
	opacity: 0.5;
}

#equipmentList thead th.sorting:before,
#consumablesList thead th.sorting:before {
	margin-top: -6px;
}

#equipmentList thead th.sorting:after,
#consumablesList thead th.sorting:after  {
	margin-top: 4px;
}

.nav-line-tabs .nav-link:not(.active) {
    color: var(--bs-text-muted) !important;
}

.nav-line-tabs .nav-link.active {
    color: var(--bs-text-dark) !important;
}

.nav-line-tabs .nav-link:not(.active) i,
.nav-line-tabs .nav-link:not(.active) i [class^="path"] {
    color: var(--bs-text-muted) !important;
}

.nav-line-tabs .nav-link.active .text-active-primary,
.nav-line-tabs .nav-link.active .text-active-primary [class^="path"] {
    color: var(--bs-primary) !important;
}

.nav-line-tabs .nav-link.active .text-active-orange,
.nav-line-tabs .nav-link.active .text-active-orange [class^="path"] {
    color: var(--bs-orange) !important;
}

#equipmentList .form-check-input:not(:checked),
#consumablesList .form-check-input:not(:checked) {
    border: 1px solid #cccccc !important;
}

#equipmentList .form-check-input:disabled, #consumablesList .form-check-input:disabled {
    border: 1px solid #d8d8d8 !important;
    opacity: 0.8;
}

[data-bs-theme="dark"] #equipmentList .form-check-input:not(:checked),
[data-bs-theme="dark"] #consumablesList .form-check-input:not(:checked) {
    border: 1px solid #4a4b50 !important;
}
[data-bs-theme="dark"] #equipmentList .form-check-input:disabled,
[data-bs-theme="dark"] #consumablesList .form-check-input:disabled  {
    border: 1px solid #323439 !important;
}

</style>

</head>
<body class="app-default">
	<div class="app-main flex-column flex-row-fluid">
		<div class="d-flex flex-column flex-column-fluid">
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
					<div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<h1 class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
							Item Catalog</h1>
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
					
					<div class="card mb-10">
						<div class="card-header px-8 py-9 d-flex align-items-center justify-content-between">
							
								<ul class="nav nav-tabs nav-line-tabs nav-line-tabs-2x fs-6 border-0">
								    <li class="nav-item d-flex align-items-center">
								        <a class="nav-link active fs-4 fw-bold " data-bs-toggle="tab" href="#kt_tab_equipment">
								        	<i class="ki-duotone ki-monitor-mobile fs-2 text-muted text-active-primary me-2">
												<span class="path1"></span><span class="path2"></span></i>
												Equipment (<span id="equipmentItemsCount"></span>) </a>
								    </li>
								    <li class="nav-item d-flex align-items-center">
								        <a class="nav-link fs-4 fw-bold " data-bs-toggle="tab" href="#kt_tab_consumables">
									        <i class="ki-duotone ki-lots-shopping fs-2 text-muted text-active-orange me-2">
												<span class="path1"></span><span class="path2"></span>
												<span class="path3"></span><span class="path4"></span>
												<span class="path5"></span><span class="path6"></span>
												<span class="path7"></span><span class="path8"></span>
											</i>Consumables (<span id="consumablesItemsCount"></span>)</a>
								    </li>
								  
								</ul>
							
							<button type="button" class="btn btn-lg btn-success fw-medium text-white px-5 py-3" id="btn_create_equipment" data-bs-toggle="modal" data-bs-target="#modal_equipment">
									<i class="ki-outline ki-plus fs-3 me-1"></i>Create
							</button>
						</div>
						
						<div class="card-body filter-card px-10 py-9 rounded-3">
							<div class="tab-content" id="myTabContent">
								<div class="tab-pane fade show active" id="kt_tab_equipment" role="tabpanel">
							       <!-- Equipment
							        -->
							       <div class="table-responsive ">
										<table id="equipmentList"
												class="table table-striped gy-7 gs-7 table-hover border-gray-300 table-row-bordered table-row-gray-200 ">
											<thead class="border-bottom-1 text-uppercase">
												<tr class="fs-7 fw-bold text-gray-500">
													<th class="px-3 min-w-50px text-center">#</th>
													<th class="px-3 min-w-500px">Items Name</th>
													<th class="px-3 min-w-130px text-center">Active</th>
													<th class="px-3 min-w-130px text-end">Actions</th>
												</tr>
											</thead>
			
											<tbody>
												<c:forEach items="${catalogEqptList}" var="itemEqptList">
													<tr class="align-middle border-bottom-1">
														<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center row-number"></td>
														<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">
															${itemEqptList.catalogEquipmentName}
														</td>
														<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center ">
															<span class="form-check form-switch form-check-custom form-check-success form-check-solid d-flex justify-content-center ">
														        <input class="form-check-input h-20px w-30px" type="checkbox" id="switch_${itemEqptList.catalogEquipmentId}"
       																<c:if test="${itemEqptList.active == '1'}">checked</c:if>/>
														    </span>
														</td>
														
														<td class="text-gray-900 fs-6 fw-normal">
															<div class="d-flex justify-content-end align-items-center gap-2">
																<a  href="" data-bs-toggle="modal" data-bs-target="#modal_equipment"
																	class="btn btn-icon btn-light-primary btn-sm btn-edit-equipment"
																   	data-id="${itemEqptList.catalogEquipmentId}"
																   	data-name="${itemEqptList.catalogEquipmentName}"
																   	data-active="${itemEqptList.active ne '0' ? '1' : '0'}"
																   	title="Edit">
																   	<i class="ki-duotone ki-pencil fs-2"><span class="path1"></span><span class="path2"></span></i>
																</a>
																	
																<a href="catalog_equipment_delete?catalogEquipmentId=${itemEqptList.catalogEquipmentId}" onclick="return confirmDelete(this.href);"
																	class="btn btn-icon btn-light-danger btn-sm" title="Delete">
																	<i class="ki-duotone ki-trash fs-2"><span
																		class="path1"></span><span class="path2"></span><span
																		class="path3"></span><span class="path4"></span><span
																		class="path5"></span></i>
																</a>
															</div>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
							    </div>
							    
							    
							    <div class="tab-pane fade" id="kt_tab_consumables" role="tabpanel">
							        <div class="table-responsive">
										<table id="consumablesList"
												class="table table-striped gy-7 gs-7 table-hover border-gray-300 table-row-bordered table-row-gray-200">
											<thead class="border-bottom-1 text-uppercase">
												<tr class="fs-7 fw-bold text-gray-500">
													<th class="px-3 min-w-50px text-center">#</th>
													<th class="px-3 min-w-200px">Product Name</th>
													<th class="px-3 min-w-200px">Sub Product</th>
													<th class="px-3 min-w-130px text-center">Select SubProduct</th>
													<th class="px-3 min-w-130px text-end">Actions</th>
												</tr>
											</thead>
			
											<tbody>
												<c:forEach items="${catalogConsList}" var="itemConsList">
													<tr class="align-middle border-bottom-1">
														<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center row-number"></td>
														<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">
															${itemConsList.catalogConsumablesName}
														</td>
														<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">
															<span class="badge badge-lg badge-primary fs-7 me-2">Double A</span>
															<span class="badge badge-lg badge-primary fs-7 me-2">Double A</span>
														</td>
														
														<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center">
															<span class="form-check d-flex justify-content-center">
														        <input class="form-check-input" type="checkbox"
														               id="subproduct_${itemConsList.catalogConsumablesId}"
														               <c:if test="${itemConsList.subProductActive == '1'}">checked</c:if> />
														    </span>
														</td>
														
														<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center ">
															<span class="form-check form-switch form-check-custom form-check-success form-check-solid d-flex justify-content-center ">
														        <input class="form-check-input h-20px w-30px" type="checkbox" id="switch_${itemConsList.catalogConsumablesId}"
       																<c:if test="${itemConsList.active == '1'}">checked</c:if>/>
														    </span>
														</td>
													</tr>
												</c:forEach>
												<!-- <tr class="align-middle border-bottom-1">
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center row-number"></td>
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">
														A4
													</td>
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">
														<span class="badge badge-lg badge-primary fs-7 me-2">Double A</span>
													</td>
													
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center">
														<span class="form-check d-flex justify-content-center"><input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" checked /></span>
													</td>
													
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center ">
														<span class="form-check form-switch form-check-custom form-check-success form-check-solid d-flex justify-content-center ">
    														<input class="form-check-input h-20px w-30px" type="checkbox" value="" checked id="kt_flexSwitchCustomDefault_1_1"/>
														</span>
													</td>
												</tr>
												
												<tr class="align-middle border-bottom-1">
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center row-number"></td>
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">
														ถุงขยะ
													</td>
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">
														<span class="badge badge-lg badge-primary fs-7 me-2">18x32</span> 
														<span class="badge badge-lg badge-primary fs-7 me-2">20x40</span>
													</td>
													
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center">
														<span class="form-check d-flex justify-content-center"><input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" checked /></span>
													</td>
													
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center ">
														<span class="form-check form-switch form-check-custom form-check-success form-check-solid d-flex justify-content-center ">
    														<input class="form-check-input h-20px w-30px" type="checkbox" value="" checked id="kt_flexSwitchCustomDefault_1_1"/>
														</span>
													</td>
												</tr>
												
												<tr class="align-middle border-bottom-1">
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center row-number"></td>
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">
														เสื้อบริษัท 2026 (สีดำ)
													</td>
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">
														<span class="badge badge-lg badge-primary fs-7 me-2">S</span> 
														<span class="badge badge-lg badge-primary fs-7 me-2">M</span>
														<span class="badge badge-lg badge-primary fs-7 me-2">L</span> 
														<span class="badge badge-lg badge-primary fs-7 me-2">XL</span>
														<span class="badge badge-lg badge-primary fs-7 me-2">2XL</span> 
														<span class="badge badge-lg badge-primary fs-7 me-2">3XL</span>
													</td>
													
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center">
														<span class="form-check d-flex justify-content-center"><input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" checked /></span>
													</td>
													
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center ">
														<span class="form-check form-switch form-check-custom form-check-success form-check-solid d-flex justify-content-center ">
    														<input class="form-check-input h-20px w-30px" type="checkbox" value="" checked id="kt_flexSwitchCustomDefault_1_1"/>
														</span>
													</td>
												</tr>
												
												<tr class="align-middle border-bottom-1">
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center row-number"></td>
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">
														ริ้บบิ้น
													</td>
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal">
														<span class="badge badge-lg badge-primary fs-7 me-2">สีแดง</span> 
														<span class="badge badge-lg badge-primary fs-7 me-2">สีขาว</span>
														<span class="badge badge-lg badge-primary fs-7 me-2">สีดำ</span> 
													</td>
													
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center">
														<span class="form-check d-flex justify-content-center"><input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" checked /></span>
													</td>
													
													<td class="px-3 py-4 text-gray-900 fs-6 fw-normal text-center ">
														<span class="form-check form-switch form-check-custom form-check-success form-check-solid d-flex justify-content-center ">
    														<input class="form-check-input h-20px w-30px" type="checkbox" value="" checked id="kt_flexSwitchCustomDefault_1_1"/>
														</span>
													</td>
												</tr> -->
												
												
												
											</tbody>
										</table>
									</div>
							    </div>
							    
							</div>
						</div>
					</div>
				</div>
			</div>
			
			
			<div class="modal fade" tabindex="-1" id="modal_equipment">
			  <div class="modal-dialog modal-lg modal-dialog-centered">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h3 class="modal-title" id="modal_equipment_title">Item Catalog - Equipment</h3>
			        <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
			          <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
			        </div>
			      </div>
			      <form id="formItemEquipment" class="form"  autocomplete="off">
				    <div class="modal-body">
				      <input type="hidden" id="catalog_equipment_id" name="catalogEquipmentId" value="" />
				      
				      <div class="row g-5 mb-6">
				        <div class="col-12 d-flex flex-column">
				          <label class="required fw-medium text-gray-800 mb-2">Equipment Name</label>
				          <input type="text" class="form-control text-gray-700 h-45px" name="catalogEquipmentName" id="catalog_equipment_name" maxlength="64" value="" />
				        </div>
				      </div>
				      
				      <div class="row g-5 mb-6">
				        <div class="col-12 px-3 py-4 text-gray-900 fs-6 fw-normal form-check form-switch form-check-custom form-check-success form-check-solid">
				          <input class="form-check-input h-20px w-30px" type="checkbox" name="active" value="1" id="active_switch" />
				          <label class="form-check-label fs-6 text-gray-800" for="active_switch">Active</label>
				        </div>
				      </div>
				    </div>
				    
				    <div class="modal-footer">
				      <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
				      <button type="button" class="btn btn-success" id="btn_submit_equipment" disabled>Save</button>
				    </div>
				</form>
			    </div>
			  </div>
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	const CTX = "${pageContext.request.contextPath}";
	document.addEventListener("DOMContentLoaded", function () {
		$('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
		    var targetTab = $(e.target).attr('href');

		    if (targetTab === '#kt_tab_equipment') {
		        $('#btn_create_equipment').css('visibility', 'visible');
		    } else {
		        $('#btn_create_equipment').css('visibility', 'hidden');
		    }
		});
		
		$("#kt_daterangepicker_2").daterangepicker({
	        startDate: moment().startOf("month"),
	        endDate: moment().endOf("month"),
	        locale: {
	            format: "D MMM YYYY"
	       }
   	 });
		
		
    
    var tableEquipment = $('#equipmentList').DataTable({
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
            targets : [ 2, 3 ]
        }, {
            orderable : true,
            targets : [ 0, 1 ]
        } ],
        order : [],
        headerCallback : function(thead) {
            $(thead).find('th').each(function() {
                if ($(this).find('.th-wrapper').length === 0) {
                    $(this).wrapInner('<span class="th-wrapper" style="display:inline-flex; align-items:center; white-space:nowrap; pointer-events:none;"></span>');
                }
            });
        }
    });
    
    var tableConsumables = $('#consumablesList').DataTable({
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
            targets : [ 2, 3, 4 ]
        }, {
            orderable : true,
            targets : [ 0, 1 ]
        } ],
        order : [],
        headerCallback : function(thead) {
            $(thead).find('th').each(function() {
                if ($(this).find('.th-wrapper').length === 0) {
                    $(this).wrapInner('<span class="th-wrapper" style="display:inline-flex; align-items:center; white-space:nowrap; pointer-events:none;"></span>');
                }
            });
        }
    });
    
  // running number
    function runNumber(targetTable) {
        if (!targetTable) return;
        const info = targetTable.page.info();
        targetTable.column(0, {
            page : 'current'
        }).nodes().each(function(cell, i) {
            cell.innerHTML = info.start + i + 1;
        });
    }
    
    runNumber(tableEquipment);
    if($('#consumablesList').length) { runNumber(tableConsumables); }
    
    tableEquipment.on('draw.dt order.dt search.dt', function() {
        runNumber(tableEquipment);
    });
    
    tableConsumables.on('draw.dt order.dt search.dt', function() {
        runNumber(tableConsumables);
    });
    
    function updateItemsFoundCount() {

        var countEquipment = tableEquipment.rows({ search: 'applied' }).count();
        document.getElementById('equipmentItemsCount').textContent = countEquipment;
        

        var countConsumables = tableConsumables.rows({ search: 'applied' }).count();
        document.getElementById('consumablesItemsCount').textContent = countConsumables;
    }
    

    tableEquipment.on('draw.dt search.dt', updateItemsFoundCount);
    tableConsumables.on('draw.dt search.dt', updateItemsFoundCount);
    

    updateItemsFoundCount();
    
    
    
    function checkEquipmentNameInput() {
        var nameValue = $('#catalog_equipment_name').val().trim();
        if (nameValue === '') {
            $('#btn_submit_equipment').prop('disabled', true);
        } else {
            $('#btn_submit_equipment').prop('disabled', false);
        }
    }
    
    $('#catalog_equipment_name').on('input propertychange paste', function() {
        checkEquipmentNameInput();
    });
    
    $('#btn_create_equipment').on('click', function () {
        $('#modal_equipment_title').text('Item Catalog - Create Equipment');
        $('#catalog_equipment_id').val(''); 
        $('#catalog_equipment_name').val('');
        $('#active_switch').prop('checked', true);
        checkEquipmentNameInput();
    });
    
    $(document).on('click', '.btn-edit-equipment', function (e) {
        e.preventDefault();
        $('#modal_equipment_title').text('Item Catalog - Edit Equipment');
        $('#catalog_equipment_id').val($(this).data('id'));
        $('#catalog_equipment_name').val($(this).data('name')); 
        $('#active_switch').prop('checked', $(this).data('active') == '1');
        checkEquipmentNameInput();
    });
    
 // --- Modal ---
	 var elements = Array.prototype.slice.call(document.querySelectorAll("[data-bs-stacked-modal]"));
	    if (elements && elements.length > 0) {
	        elements.forEach((element) => {
	            if (element.getAttribute("data-kt-initialized") === "1") {
	                return;
	            }

	            element.setAttribute("data-kt-initialized", "1");

	            element.addEventListener("click", function(e) {
	                e.preventDefault();

	                const modalEl = document.querySelector(this.getAttribute("data-bs-stacked-modal"));

	                if (modalEl) {
	                    const modal = new bootstrap.Modal(modalEl);
	                    modal.show();
	                }
	            });
	        });
	    }
	    
	    document.querySelectorAll('a.btn-primary[href="#"]').forEach(function (btn) {
	        if (btn.textContent.trim().includes('Search MR')) {
	            btn.setAttribute('data-bs-toggle', 'modal');
	            btn.setAttribute('data-bs-target', '#modal_equipment');
	        }
	    });
	    
	    $('#btn_submit_equipment').on('click', function () {
	    	
	        var id = $('#catalog_equipment_id').val();
	        var name = $('#catalog_equipment_name').val().trim();

	        var data = {
	        	catalogEquipmentId: id,
	        	catalogEquipmentName: name,
	        	eqptActive: $('#active_switch').is(':checked') ? '1' : '0'
	        };

	        /* var url = CTX + '/' + (id ? 'item_catalog_update' : 'item_catalog_add'); */

	        function submitData() {
	            $.ajax({
	                url: CTX + '/catalog_equipment_save',
	                method: 'POST',
	                data: data,
	                success: function (res) {
	                    $('#modal_equipment').modal('hide');
	                    Swal.fire({
	                        title: 'Success!',
	                        text: 'Item saved successfully!',
	                        icon: 'success',
	                        timer: 1000,
	                        timerProgressBar: true,
	                        showConfirmButton: false
	                    }).then(() => {
	                        window.location.reload();
	                    });
	                },
	                error: function (xhr) {
	                	console.error("HTTP", xhr.status, xhr.responseText);
	                    Swal.fire('Error!', 'Failed to submit return request.', 'error');
	                }
	            });
	        }

	        if (id) {
	            Swal.fire({
	                title: "Are you sure?!",
	                text: "Do you want to save the changes?",
	                icon: "warning",
	                showCancelButton: true,
	                confirmButtonText: "Save",
	                cancelButtonText: "Close",
	                buttonsStyling: false,
	                customClass: {
	                    confirmButton: "btn btn-success",
	                    cancelButton: "btn btn-secondary"
	                }
	            }).then((result) => {
	                if (result.isConfirmed) {
	                    submitData();
	                }
	            });
	        } else {
	            submitData();
	        }
	    });
	    
	    
	    $(document).on('change', '#equipmentList input[type="checkbox"][id^="switch_"]', function () {
	        var $checkbox = $(this);
	        var id = $checkbox.attr('id').replace('switch_', '');
	        var isActive = $checkbox.is(':checked');
	        var name = $checkbox.closest('tr').find('td').eq(1).text().trim();

	        var data = {
	        	catalogEquipmentId: id,
	        	catalogEquipmentName: name,
	        	eqptActive: isActive ? '1' : '0'
	        };

	        $.ajax({
	            url: CTX + '/catalog_equipment_save',
	            method: 'POST',
	            data: data,
	            success: function (res) {
                    Swal.fire({
                        title: 'Success!',
                        text: 'Item saved successfully!',
                        icon: 'success',
                        timer: 1000,
                        timerProgressBar: true,
                        showConfirmButton: false
                    }).then(() => {
                        window.location.reload();
                    });
                },
	            error: function (xhr) {
	                console.error("HTTP", xhr.status, xhr.responseText);
	                $checkbox.prop('checked', !isActive);
	            }
	        });
	    });
	    
	    
	    $(document).on('change', '#consumablesList input[type="checkbox"][id^="switch_"]', function () {
	        var $checkbox = $(this);
	        var id = $checkbox.attr('id').replace('switch_', '');
	        var isActive = $checkbox.is(':checked');

	        $.ajax({
	            url: CTX + '/catalog_consumables_update',
	            method: 'POST',
	            data: {
	                catalogConsumablesId: id,
	                consActive: isActive ? '1' : '0'
	            },
	            success: function (res) {
                    Swal.fire({
                        title: 'Success!',
                        text: 'Item saved successfully!',
                        icon: 'success',
                        timer: 1000,
                        timerProgressBar: true,
                        showConfirmButton: false
                    }).then(() => {
                        window.location.reload();
                    });
                },
	            error: function (xhr) {
	                console.error("HTTP", xhr.status, xhr.responseText);
	                $checkbox.prop('checked', !isActive);
	            }
	        });
	    });

	    $(document).on('change', '#consumablesList input[type="checkbox"][id^="subproduct_"]', function () {
	        var $checkbox = $(this);
	        var id = $checkbox.attr('id').replace('subproduct_', '');
	        var isSubProductActive = $checkbox.is(':checked');

	        $.ajax({
	            url: CTX + '/catalog_consumables_update',
	            method: 'POST',
	            data: {
	                catalogConsumablesId: id,
	                subProductActive: isSubProductActive ? '1' : '0'
	            },
	            success: function (res) {
                    Swal.fire({
                        title: 'Success!',
                        text: 'Item saved successfully!',
                        icon: 'success',
                        timer: 1000,
                        timerProgressBar: true,
                        showConfirmButton: false
                    }).then(() => {
                        window.location.reload();
                    });
                },
	            error: function (xhr) {
	                console.error("HTTP", xhr.status, xhr.responseText);
	                $checkbox.prop('checked', !isSubProductActive);
	            }
	        });
	    });
});	
	
function confirmDelete(url){
		
	    Swal.fire({
	        title: "Are you sure?!",
	        text: "Are you sure you want to delete this item?",
	        icon: "warning",
	        showCancelButton: true,
	        confirmButtonText: "Yes, delete it!",
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