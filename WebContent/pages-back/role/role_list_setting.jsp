<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!--begin::Main-->
<div class="app-main flex-column flex-row-fluid">

	<!--begin::Content wrapper-->
	<div class="d-flex flex-column flex-column-fluid">

		<!--begin::Toolbar-->
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<!--begin::Toolbar container-->
			<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
				<!--begin::Page title-->
				<div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<!--begin::Title-->
					<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">Role Setting</h1>
					<!--end::Title-->
					<!--begin::Breadcrumb-->
					<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a href="demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Authority</li>
						<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Role / Permission</li>
					</ul>
					<!--end::Breadcrumb-->
				</div>
				
				
					<!--begin::Controls-->
					<div class="d-flex flex-wrap my-1">
						<a href="javascript:void(0)" class="btn btn-success btn-lg" data-bs-toggle="modal" data-bs-target="#addGroupAuth">
							<i class="ki-duotone ki-plus"></i>
							Create Group
						</a>
					</div>
					<!--end::Controls-->
				
				
				<!--end::Page title-->
			</div>
			<!--end::Toolbar container-->
		</div>
		<!--end::Toolbar-->

		<!--begin::Content-->
		<div id="kt_app_content" class="app-content flex-column-fluid">

			<!--begin::Content container-->
			<div id="kt_app_content_container" class="app-container container-fluid">

				<form action="role-perform-add" class="form-horizontal" method="post" autocomplete="off">

					<div class="d-flex flex-row">
						<div class="flex-row-fluid mb-5">

							<c:forEach var="group" items="${aoList}">
								<div class="card card-flush mb-5 mb-xl-10 shadow-sm">

									<%-- <div class="card-header fs-4">
										<div class="d-flex align-items-center mb-2 gap-2">
											<h4 class="mb-0 me-3">${group.description}</h4>
										</div>

										<div class="card-toolbar">
											<div class="d-inline-flex align-items-center justify-content-end gap-2">
												<div class="fs-5">id : ${group.authorizedObjectGroupId != null ? group.authorizedObjectGroupId : '-'}</div>
											</div>
										</div>
									</div> --%>
									
									<div class="card-header pt-5">
										<div class="card-title align-items-start">
											<span class="me-3">${group.name}</span><a href="#">#${group.authorizedObjectGroupId != null ? group.authorizedObjectGroupId : '-'}</a>
										</div>
										<div class="card-toolbar">
												<button type="button" class="btn btn-icon btn-sm btn-light-primary me-2 btn-edit-group" data-id="${group.authorizedObjectGroupId}" data-name="${group.name}" data-bs-toggle="modal" 
													data-bs-target="#editGroupAuth">
													<i class="ki-duotone ki-pencil fs-5">
														<span class="path1"></span>
														<span class="path2"></span>
													</i>
												</button>
												<c:choose>
												    <c:when test="${empty group.objects}">
												        <button type="button" class="btn btn-icon btn-sm btn-light-danger btn-delete-group" data-id="${group.authorizedObjectGroupId}" data-bs-toggle="modal"
															data-bs-target="#modal_delete_group" aria-label="Delete">
												            <i class="ki-duotone ki-trash fs-5">
												                <span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>
												            </i>
												        </button>
												    </c:when>
												    <c:otherwise>
												        <button type="button" class="btn btn-icon btn-sm btn-bg-light btn-color-gray-400">
												            <i class="ki-duotone ki-trash fs-5">
												                <span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>
												            </i>
												        </button>
												    </c:otherwise>
												</c:choose>
											</div>
									</div>
									<div class="card-body pt-0">
										<div class="table-responsive">
											<table class="table align-middle table-row-dashed fs-6 gy-5" style="table-layout: fixed; width: 100%;">
											
												<thead>
													<tr>
														<!-- <th>id : ${group.authorizedObjectGroupId != null ? group.authorizedObjectGroupId : '-'}</th> -->
														<th style="width: 10%;" class="text-muted">ACTIVE</th>
														<th style="width: 25%;" class="text-muted">ID</th>
														<th style="width: 25%;" class="text-muted">NAME</th>
														<th style="width: 30%;" class="text-muted">DESCRIPTION</th>
														<th style="width: 10%;"></th>
													</tr>
												</thead>
											
												<tbody>

													<c:forEach var="obj" items="${group.objects}" varStatus="loop">
														<tr class="fs-5">
															<td style="width: 10%;padding:16.25px 9.75px;">
																<div class="form-check form-check-custom form-check-solid">
																	<c:if test="${obj.active eq 1}">
																		<c:set var="isChecked" value="checked" />
																	</c:if>
																	<input class="form-check-input" type="checkbox" name="authId" onclick="performStatus('${obj.authorizedObjectId}','${group.authorizedObjectGroupId}_${loop.count}')"
																	id="checkbox_${group.authorizedObjectGroupId}_${loop.count}" value="${obj.authorizedObjectId}" ${isChecked} />
																</div>
															</td>
															<td style="width: 25%;" class="text-truncate">${obj.authorizedObjectId}</td>

															<td style="width: 25%;" class="text-truncate">
																<label for="checkbox_${group.authorizedObjectGroupId}_${loop.count}">
																	${obj.name}
																</label>
															</td>
															<td style="width: 30%;" class="text-truncate">
																<label for="checkbox_${group.authorizedObjectGroupId}_${loop.count}">
																	${obj.description}
																</label>
															</td>
															<td style="width: 10%;" class="text-end">
															<!-- Edit -->
															<button type="button" class="btn btn-icon btn-sm btn-light-primary btn-edit-auth" data-id="${group.authorizedObjectGroupId}" 
															data-obj="${obj.authorizedObjectId}" data-name="${obj.name}" data-desc="${obj.description}" data-bs-toggle="modal" 
																data-bs-target="#editAuth" aria-label="Edit">
																<i class="ki-duotone ki-pencil fs-5">
																	<span class="path1"></span>
																	<span class="path2"></span>
																</i>
															</button>	
															</td>
														</tr>
													</c:forEach>

													<c:if test="${empty group.objects}">
														<tr>
															<td colspan="3" class="text-center text-muted">
														        <i class="ki-duotone ki-cube-2 fs-2 me-2">
														            <span class="path1"></span>
														            <span class="path2"></span>
														            <span class="path3"></span>
														        </i>
															No Data
															</td>
														</tr>
													</c:if>
												</tbody>
											</table>
										</div>
									</div>

								</div>
							</c:forEach>

						</div>
					</div>

				</form>

			</div>
			<!--end::Content wrapper-->

		</div>
		<!--end::Content-->

	</div>
	<!--begin::Content wrapper-->

</div>
<!--begin::Main-->
<!-- modal -->
<!-- modal add -->
<div class="modal fade" tabindex="-1" id="addGroupAuth">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="POST" action="role-perform-add-setting" id="addGroupAuthform">
            <div class="modal-header">
                <h3 class="modal-title">Add Authorized Group</h3>

                <!--begin::Close-->
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
                <!--end::Close-->
            </div>

            <div class="modal-body">
                <div class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
	                <!--begin::Label-->
	                <label class="d-flex align-items-center fs-6 fw-semibold mb-2">
	                	<span class="required">Authorized Group ID</span>
	                </label>
					<!--end::Label-->
	                <input type="text" class="form-control form-control-solid" placeholder="" name="authGroupId" id="authGroupId" onkeyup="myFunction()" required>
	                <small class="text-danger small" style="display: none;" id="error">
						This ID has already been used.
					</small> 
					<small class="text-danger small" style="display: none;" id="pass">
						
					</small>
                </div>
                <div class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
	                <!--begin::Label-->
	                <label class="d-flex align-items-center fs-6 fw-semibold mb-2">
	                	<span class="required">Authorized Group Name</span>
	                </label>
					<!--end::Label-->
	                <input type="text" class="form-control form-control-solid" placeholder="" name="authGroupName" id="authGroupName" onkeyup="myFunction2()" required>
	                <small class="text-danger small" style="display: none;" id="errorName">
						This ID has already been used.
					</small> 
					<small class="text-danger small" style="display: none;" id="passName">
						
					</small>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-success">Save</button>
            </div>
            </form>
        </div>
    </div>
</div>

<!-- modal edit -->
<div class="modal fade" tabindex="-1" id="editGroupAuth">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="POST" action="role-perform-edit-setting" id="editGroupAuthform">
            <div class="modal-header">
                <h3 class="modal-title">Edit Authorized Group</h3>

                <!--begin::Close-->
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
                <!--end::Close-->
            </div>

            <div class="modal-body">
                <div class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
	                <!--begin::Label-->
	                <label class="d-flex align-items-center fs-6 fw-semibold mb-2">
	                	<span class="required">Authorized Group ID</span>
	                </label>
					<!--end::Label-->
	                <input type="text" class="form-control form-control-solid" name="editAuthGroupId" id="editAuthGroupId" disabled>
	                <input type="hidden" name="hiddenEditGroupId" id="hiddenEditGroupId" />
	                <small class="text-danger small" style="display: none;" id="error">
						This ID has already been used.
					</small> 
					<small class="text-danger small" style="display: none;" id="pass">
						
					</small>
                </div>
                <div class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
	                <!--begin::Label-->
	                <label class="d-flex align-items-center fs-6 fw-semibold mb-2">
	                	<span class="required">Authorized Group Name</span>
	                </label>
					<!--end::Label-->
	                <input type="text" class="form-control form-control-solid" name="editAuthGroupName" id="editAuthGroupName" onkeyup="myFunction3()" required>
	                <small class="text-danger small" style="display: none;" id="errorEditName">
						This ID has already been used.
					</small> 
					<small class="text-danger small" style="display: none;" id="passEditName">
						
					</small>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-success">Save</button>
            </div>
            </form>
        </div>
    </div>
</div>

<!-- modal delete -->
<div class="modal fade" tabindex="-1" id="modal_delete_group">
	<div class="modal-dialog">
		<form action="role-delete-setting" method="POST" class="modal-content">
			<div class="modal-body py-15 px-lg-17">
				<div class="mb-10 text-center">
					<i class="ki-duotone ki-information text-danger" style="font-size: 200px">
						<span class="path1"></span>
						<span class="path2"></span>
						<span class="path3"></span>
					</i>        
				</div>

				<div class="text-center mb-13">
					<h2 class="text-dark fw-bold mb-10 fs-1">Confirm Delete ?</h2>
					<div class="fw-semibold fs-5">
						<div>Are you sure you want to delete it?</div>
						<div>Once the data is deleted, it cannot be recovered.</div>
					</div>
					<input type="hidden" name="id" id="hiddenGroupId" />
				</div>

				<div class="d-flex flex-center">
					<button type="button" class="btn btn-light me-3" data-bs-dismiss="modal">Cancel</button>
					<button type="submit" class="btn btn-danger">Delete</button>
				</div>
			</div>
		</form>
	</div>
</div>

<!-- modal edit AO -->
<div class="modal fade" tabindex="-1" id="editAuth">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="POST" action="role-edit-auth" id="editAuthform">
            <div class="modal-header">
                <h3 class="modal-title">Authorized Object</h3>

                <!--begin::Close-->
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
                <!--end::Close-->
            </div>

            <div class="modal-body">
                <div class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
	                <!--begin::Label-->
	                <label class="d-flex align-items-center fs-6 fw-semibold mb-2">
	                	<span class="required">Authorized Group ID</span>
	                </label>
					<!--end::Label-->
	                <select class="form-select form-select-solid" name="editGroupId" id="editGroupId">
	                	<c:forEach var="aog" items="${aogList}">
	                		<option value="${aog.authorizedObjectGroupId}">${aog.name}</option>
	                	</c:forEach>
	                </select>
                </div>
                <div class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
	                <!--begin::Label-->
	                <label class="d-flex align-items-center fs-6 fw-semibold mb-2">
	                	<span class="required">Authorized ID</span>
	                </label>
					<!--end::Label-->
	                <input type="text" class="form-control form-control-solid" name="editAuthId" id="editAuthId" disabled>
	                <input type="hidden" class="form-control form-control-solid" name="hiddenEditAuthId" id="hiddenEditAuthId">
                </div>
                <div class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
	                <!--begin::Label-->
	                <label class="d-flex align-items-center fs-6 fw-semibold mb-2">
	                	<span class="required">Authorized Name</span>
	                </label>
					<!--end::Label-->
	                <input type="text" class="form-control form-control-solid" name="editAuthName" id="editAuthName" required>
                </div>
                <div class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
	                <!--begin::Label-->
	                <label class="d-flex align-items-center fs-6 fw-semibold mb-2">
	                	<span>Description</span>
	                </label>
					<!--end::Label-->
	                <input type="text" class="form-control form-control-solid" name="editAuthDesc" id="editAuthDesc">
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-success">Save</button>
            </div>
            </form>
        </div>
    </div>
</div>
<!-- modal -->
<script>
$(document).ready(function() {
	$('.btn-delete-group').on('click', function() {
		// ดึงค่า ID จากปุ่มที่คลิก
		var groupId = $(this).data('id');

		// นำ ID ไปใส่ใน hidden input ของฟอร์มใน Modal
		$('#hiddenGroupId').val(groupId);
	});
	
	$('.btn-edit-group').on('click', function() {
		$('#editAuthGroupId').val("");
		$('#hiddenEditGroupId').val("");
		$('#editAuthGroupName').val("");
		// ดึงค่า ID จากปุ่มที่คลิก
		var groupId = $(this).data('id');
		var groupName = $(this).data('name');

		// นำ ID ไปใส่ใน hidden input ของฟอร์มใน Modal
		$('#editAuthGroupId').val(groupId);
		$('#hiddenEditGroupId').val(groupId);
		$('#editAuthGroupName').val(groupName);
	});
	
	$('.btn-edit-auth').on('click', function() {
		// ดึงค่า ID จากปุ่มที่คลิก
		var groupId = $(this).data('id');
		var objId = $(this).data('obj');
		var name = $(this).data('name');
		var desc = $(this).data('desc');

		// นำ ID ไปใส่ใน hidden input ของฟอร์มใน Modal
		$('#editGroupId').val(groupId);
		$('#editAuthId').val(objId);
		$('#hiddenEditAuthId').val(objId);
		$('#editAuthName').val(name);
		$('#editAuthDesc').val(desc);
	});
});
</script>
<script>
function performStatus(obj_id, id) {
	var status;
	if($('#checkbox_'+id).is(':checked')){
		status = "1";
		
		$.ajax({
    		url : "role-perform-status-update-setting",
    		type : "POST",
    		data : {
    			"obj_id" : obj_id,
    			"status" : status,
    		},
    		success : function(data) {
    			console.log(data);
    			const Toast = Swal.mixin({
    				toast: true,
    				position: 'top-end',
    				showConfirmButton: false,
    				timer: 3000,
    				timerProgressBar: true,
    				didOpen: (toast) => {
    					toast.onmouseenter = Swal.stopTimer;
    					toast.onmouseleave = Swal.resumeTimer;
    				}
    			});
    			Toast.fire({
    				icon: 'success',
    				title: 'Status updated successfully'
    			});
    		},
    		error : function(xhr, status, error) {
    			console.error("Error updating address:", error);
    			const Toast = Swal.mixin({
    				toast: true,
    				position: 'top-end',
    				showConfirmButton: false,
    				timer: 3000,
    				timerProgressBar: true,
    				didOpen: (toast) => {
    					toast.onmouseenter = Swal.stopTimer;
    					toast.onmouseleave = Swal.resumeTimer;
    				}
    			});
    			Toast.fire({
    				icon: 'error',
    				title: 'Update failed'
    			});
    		}
    	});
	} else {
		status = "0";
		
		Swal.fire({
	    	title: 'Confirm Disabled?',
	        text: "You will be disabled this permission from all role!",
	        icon: 'error',
	        showDenyButton: true,
	        denyButtonText: '<span class="text-dark">Cancel</span>',
	        confirmButtonText: 'Disable',
	        confirmButtonColor: "#F8285A",
	        denyButtonColor: "#F9F9F9",
	        reverseButtons: true,
	        allowOutsideClick: false
	    }).then((result) => {
	            if (result.isConfirmed) {
	                $.ajax({
	            		url : "role-perform-status-update-setting",
	            		type : "POST",
	            		data : {
	            			"obj_id" : obj_id,
	            			"status" : status,
	            		},
	            		success : function(data) {
	            			console.log(data);
	            			const Toast = Swal.mixin({
	            				toast: true,
	            				position: 'top-end',
	            				showConfirmButton: false,
	            				timer: 3000,
	            				timerProgressBar: true,
	            				didOpen: (toast) => {
	            					toast.onmouseenter = Swal.stopTimer;
	            					toast.onmouseleave = Swal.resumeTimer;
	            				}
	            			});
	            			Toast.fire({
	            				icon: 'success',
	            				title: 'Status updated successfully'
	            			});
	            		},
	            		error : function(xhr, status, error) {
	            			console.error("Error updating address:", error);
	            			const Toast = Swal.mixin({
	            				toast: true,
	            				position: 'top-end',
	            				showConfirmButton: false,
	            				timer: 3000,
	            				timerProgressBar: true,
	            				didOpen: (toast) => {
	            					toast.onmouseenter = Swal.stopTimer;
	            					toast.onmouseleave = Swal.resumeTimer;
	            				}
	            			});
	            			Toast.fire({
	            				icon: 'error',
	            				title: 'Update failed'
	            			});
	            		}
	            	});
	            }
	            else if (result.isDenied) {
	            	$('#checkbox_'+id).prop("checked", true);
	                return false;
	            }
	  });
	}
}
</script>
<script>
var initialNemValue = $("#authGroupId").val();
function myFunction() {
	var x = $("#authGroupId").val();
	console.log(x);

	// Check if the value of #nem has changed
	if (x == initialNemValue) {
		// Value hasn't changed, enable the submit button
		$(':input[type="submit"]').prop('disabled', false);
	} else if (x != "") {
		$.ajax({
			url : "findAuthGroupId",
			method : "POST",
			type : "JSON",
			data : {
				"value" : x
			},
			success : function(data) {
				//console.log(data);
				if (data == "0") {
					$("#pass").hide();
					$("#error").show();
				} else {
					$("#pass").show();
					$("#error").hide();
				}
				toggleSubmitButton();
			}
		});
	}
}

function toggleSubmitButton() {
	var isNameValid = $("#error").is(":hidden")
			&& $("#pass").is(":visible"); // Validates name check

	// Check if both name is valid or #nem value hasn't changed, and price is valid
	if ((isNameValid || $("#authGroupId").val() == initialNemValue)) {
		$(':input[type="submit"]').prop('disabled', false); // Enable submit if both checks pass or #nem hasn't changed
	} else {
		$(':input[type="submit"]').prop('disabled', true); // Disable submit if any check fails
	}
}

function myFunction2() {
	var x = $("#authGroupName").val();
	console.log(x);

	// Check if the value of #nem has changed
	if (x == initialNemValue) {
		// Value hasn't changed, enable the submit button
		$(':input[type="submit"]').prop('disabled', false);
	} else if (x != "") {
		$.ajax({
			url : "findAuthGroupName",
			method : "POST",
			type : "JSON",
			data : {
				"value" : x
			},
			success : function(data) {
				//console.log(data);
				if (data.toString().indexOf("1") != -1) {
					$("#passName").hide();
					$("#errorName").show();
				} else {
					$("#passName").show();
					$("#errorName").hide();
				}
				toggleSubmitButton2();
			}
		});
	}
}

function toggleSubmitButton2() {
	var isNameValid = $("#errorName").is(":hidden")
			&& $("#passName").is(":visible"); // Validates name check

	// Check if both name is valid or #nem value hasn't changed, and price is valid
	if ((isNameValid || $("#authGroupName").val() == initialNemValue)) {
		$(':input[type="submit"]').prop('disabled', false); // Enable submit if both checks pass or #nem hasn't changed
	} else {
		$(':input[type="submit"]').prop('disabled', true); // Disable submit if any check fails
	}
}

function myFunction3() {
	var x = $("#editAuthGroupName").val();
	console.log(x);

	// Check if the value of #nem has changed
	if (x == initialNemValue) {
		// Value hasn't changed, enable the submit button
		$(':input[type="submit"]').prop('disabled', false);
	} else if (x != "") {
		$.ajax({
			url : "findAuthGroupName",
			method : "POST",
			type : "JSON",
			data : {
				"value" : x
			},
			success : function(data) {
				//console.log(data);
				if (data.toString().indexOf("1") != -1) {
					$("#passEditName").hide();
					$("#errorEditName").show();
				} else {
					$("#passEditName").show();
					$("#errorEditName").hide();
				}
				toggleSubmitButton3();
			}
		});
	}
}

function toggleSubmitButton3() {
	var isNameValid = $("#errorEditName").is(":hidden")
			&& $("#passEditName").is(":visible"); // Validates name check

	// Check if both name is valid or #nem value hasn't changed, and price is valid
	if ((isNameValid || $("#editAuthGroupName").val() == initialNemValue)) {
		$(':input[type="submit"]').prop('disabled', false); // Enable submit if both checks pass or #nem hasn't changed
	} else {
		$(':input[type="submit"]').prop('disabled', true); // Disable submit if any check fails
	}
}
</script>