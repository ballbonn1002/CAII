<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="perm" uri="/WEB-INF/tlds/permission.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Travel Setting</title>

<fmt:setLocale value="en_US" />
<fmt:setTimeZone value="Asia/Bangkok" />

<style>
/*Light Mode*/
[data-bs-theme="light"] #kt_table.table.table-striped>tbody>tr:nth-of-type(odd)>*
	{
	background-color: #FBFBFB !important;
	box-shadow: none !important;
}

[data-bs-theme="light"] #kt_table.table-hover tbody tr:hover>*, [data-bs-theme="light"] #kt_table.table.table-hover>tbody>tr:hover>*,
	[data-bs-theme="light"] #kt_table.dataTable>tbody>tr:hover>* {
	background-color: #F9F9F9 !important; /* hover */
	box-shadow: none !important;
	transition: background-color 0.15s ease-in-out;
}

/*Dark Mode*/
[data-bs-theme="dark"] #kt_table.table.table-striped>tbody>tr:nth-of-type(odd)>*
	{
	background-color: #191B20 !important; /* odd */
	box-shadow: none !important;
}

[data-bs-theme="dark"] #kt_table.table.table-striped>tbody>tr:nth-of-type(even)>*
	{
	background-color: #15171C !important; /* even */
	box-shadow: none !important;
}

[data-bs-theme="dark"] #kt_table.table-hover tbody tr:hover>*, [data-bs-theme="dark"] #kt_table.table.table-hover>tbody>tr:hover>*,
	[data-bs-theme="dark"] #kt_table.dataTable>tbody>tr:hover>* {
	background-color: #1B1C22 !important; /* hover */
	box-shadow: none !important;
	transition: background-color 0.15s ease-in-out;
}
</style>
</head>
<body>

	<div class="app-main flex-column flex-row-fluid">
		<div class="d-flex flex-column flex-column-fluid">

			<!--Breadcrumb-->
			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container"
					class="app-container container-fluid d-flex flex-stack">
					<div
						class="page-title d-flex flex-column justify-content-center flex-wrap me-3">

						<!--Title-->
						<h1
							class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">Travel
							Setting</h1>
						<!--Title-->

						<ul
							class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a
								href="demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted">Admin Management</li>
						</ul>
					</div>
				</div>
			</div>
			<!--Breadcrumb-->

			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container"
					class="app-container container-fluid">
					<div class="card">

						<!--Header-->
						<div class="card-header border-0 pt-6 mb-6 align-items-start">

							<div class="card-title">
								<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 my-0">
									Travel Expense Type List</h1>
							</div>

							<!--Btn Create-->
							<div class="d-flex flex-wrap my-1">
								<button class="btn btn-success btn-lg" id="btn-create-type">
									<i class="ki-duotone ki-plus"></i> Create
								</button>
							</div>
							<!--Btn Create-->

						</div>
						<!--Header-->

						<!--Table Listing-->
						<div class="card-body pt-0">
							<div class="table-responsive">
								<table
									class="table table-striped table-hover table-row-bordered fs-6 gy-5"
									id="kt_table">
									<thead>
										<tr
											class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 border-bottom border-gray-200">
											<th style="width: 10%; padding-left: 40px;"
												class="text-start">#</th>
											<th style="width: 10%; text-align: left;">Type ID</th>
											<th style="width: 25%; text-align: left;">Type Name</th>
											<th style="width: 25%; text-align: left;">Description</th>
											<th style="width: 10%; text-align: center;">Active</th>
											<th style="width: 20%;" class="text-end pe-5">Actions</th>
										</tr>
									</thead>
									<tbody class="fw-semibold text-gray-600">
										<c:forEach var="t" items="${travelTypeList}"
											varStatus="status">
											<tr class="align-middle border-bottom border-gray-200">
												<td style="padding-left: 40px;"
													class="fw-bold text-gray-800 text-start text-nowrap">${status.count}</td>
												<td class="text-gray-900">${t.expTravelTypeId}</td>
												<td class="text-gray-600">${t.name}</td>
												<td class="text-gray-600"
													style="white-space: normal; max-width: 360px; word-wrap: break-word;">${t.description}</td>
												<td class="text-center"><c:choose>
														<c:when test="${t.active eq '1'}">
															<span
																class="badge bg-light-success border text-success fs-6 px-4 py-2">Active</span>
														</c:when>
														<c:otherwise>
															<span
																class="badge bg-light-danger text-danger fs-6 px-4 py-2">Inactive</span>
														</c:otherwise>

													</c:choose></td>

												<!-- Actions -->
												<td class="text-end text-nowrap pe-5" style="width: 120px;">
													<div
														class="d-inline-flex align-items-center justify-content-end gap-2">
														<!-- Edit -->
														<button type="button"
															class="btn btn-edit-type btn-icon btn-sm btn-light-primary"
															aria-label="Edit" data-id="${t.expTravelTypeId}">
															<i class="ki-duotone ki-pencil fs-5"> <span
																class="path1"></span> <span class="path2"></span>
															</i>
														</button>
														<!-- Edit -->

														<!-- Delete -->
														<c:set var="useCount"
															value="${expTravelTypeCountMap[t.expTravelTypeId]}" />
														<c:if test="${empty useCount || useCount == 0}">
															<button type="button"
																class="btn btn-icon btn-sm btn-light-danger btn-delete-type"
																data-id="${t.expTravelTypeId}" aria-label="Delete">
																<i class="ki-duotone ki-trash fs-5"> <span
																	class="path1"></span> <span class="path2"></span> <span
																	class="path3"></span> <span class="path4"></span> <span
																	class="path5"></span>
																</i>
															</button>
														</c:if>
														<!-- Delete -->
													</div>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<!--Table Listing-->
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal Add -->
	<div class="modal fade" tabindex="-1" id="modal_add_type">
		<div class="modal-dialog">
			<div class="modal-content">
				<form method="POST" action="travel_setting_add" id="addNewTypeform">
					<div class="modal-header">
						<h3 class="modal-title">Add New Type</h3>
						<!--begin::Close-->
						<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
							data-bs-dismiss="modal" aria-label="Close">
							<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span
								class="path2"></span></i>
						</div>
						<!--end::Close-->
					</div>

					<div class="modal-body">
						<div
							class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
							<label class="d-flex align-items-center fs-6 fw-semibold mb-2">
								<span class="required">Name</span>
							</label> <input type="text" class="form-control form-control-solid"
								name="typeName" id="typeName" required />
						</div>
						<div
							class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
							<label class="d-flex align-items-center fs-6 fw-semibold mb-2">
								<span>Description</span>
							</label>
							<textarea class="form-control form-control-solid"
								name="typeDescription" id="typeDescription"></textarea>
						</div>

						<div
							class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
							<label class="d-flex align-items-center fs-6 fw-semibold mb-2">
								<span>Active</span>
							</label>
							<div class="form-check form-switch">
								<input class="form-check-input" type="checkbox" role="switch"
									id="typeActive" name="typeActive" checked />
							</div>
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-light"
							data-bs-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-success" id="btnSaveAddType"
							disabled>Save</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Modal Add -->

	<!-- Modal Edit -->
	<div class="modal fade" tabindex="-1" id="modal_edit_type">
		<div class="modal-dialog">
			<div class="modal-content">
				<form method="POST" action="travel_setting_update"
					id="updateTypeform">
					<div class="modal-header">
						<h3 class="modal-title">Edit Type</h3>
						<!--begin::Close-->
						<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
							data-bs-dismiss="modal" aria-label="Close">
							<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span
								class="path2"></span></i>
						</div>
						<!--end::Close-->
					</div>

					<div class="modal-body">
						<div
							class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
							<label class="d-flex align-items-center fs-6 fw-semibold mb-2">
								<span class="required">Type ID</span>
							</label> <input type="text" class="form-control form-control-solid"
								name="typeId" id="typeId" readonly />
						</div>
						<div
							class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
							<label class="d-flex align-items-center fs-6 fw-semibold mb-2">
								<span class="required">Name</span>
							</label> <input type="text" class="form-control form-control-solid"
								name="typeName" id="editTypeName" required />
						</div>
						<div
							class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
							<label class="d-flex align-items-center fs-6 fw-semibold mb-2">
								<span>Description</span>
							</label>
							<textarea class="form-control form-control-solid"
								name="typeDescription" id="editTypeDescription"></textarea>
						</div>

						<div
							class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
							<label class="d-flex align-items-center fs-6 fw-semibold mb-2">
								<span>Active</span>
							</label>
							<div class="form-check form-switch">
								<input class="form-check-input" type="checkbox" role="switch"
									id="editTypeActive" name="typeActive"/>
							</div>
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-light"
							data-bs-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-success" id="btnSaveEditType"
							disabled>Save</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Modal  Edit -->


	<!--Modal Delete-->
	<div class="modal fade" tabindex="-1" id="modal_delete_type">
		<div class="modal-dialog">
			<form id="deleteTypeForm" action="travel_setting_delete"
				method="POST" class="modal-content">
				<div class="modal-body py-15 px-lg-17">
					<div class="mb-10 text-center">
						<i class="ki-duotone ki-information text-danger"
							style="font-size: 200px"> <span class="path1"></span> <span
							class="path2"></span> <span class="path3"></span>
						</i>
					</div>

					<div class="text-center mb-13">
						<h2 class="text-dark fw-bold mb-10 fs-1">Confirm Delete ?</h2>
						<div class="fw-semibold fs-5">
							<div>Are you sure you want to delete it?</div>
							<div>Once the data is deleted, it cannot be recovered.</div>
						</div>
						<input type="hidden" name="typeId" id="hiddenTypeId" />
					</div>

					<div class="d-flex flex-center">
						<button type="button" class="btn btn-light me-3"
							data-bs-dismiss="modal">Cancel</button>
						<button type="submit" class="btn btn-danger">Delete</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!--Modal Delete-->
	<script>
		$(document).ready(
				function() {

					/* Modal Delete  */
					$('.btn-delete-type').on('click', function() {
						// ดึงค่า ID จากปุ่มที่คลิก
						var typeId = $(this).data('id');

						// นำ ID ไปใส่ใน hidden input ของฟอร์มใน Modal
						$('#hiddenTypeId').val(typeId);

						$('#modal_delete_type').modal('show');
					});
					/* Modal Delete  */

					/* Modal Add  */
					$('#btn-create-type').on('click', function() {

						$('#modal_add_type').modal('show');
					});
					/* Modal Add */

					/* Modal Edit  */
					$('.btn-edit-type').on(
							'click',
							function() {

								let typeId = $(this).data('id');

								$.ajax({
									url : 'travel_setting_edit',
									type : 'GET',
									data : {
										typeId : typeId
									},
									dataType : 'json',
									success : function(res) {

										// set ค่าเข้า input
										$('#typeId').val(res.expTravelTypeId);
										$('#editTypeName').val(res.name);
										$('#editTypeDescription').val(
												res.description);

										// checkbox active

										$('#editTypeActive').prop('checked',
												res.active == '1');

										// เปิด modal
										$('#modal_edit_type').modal('show');

										validateEditForm();
									},
									error : function(xhr) {
										console.log(xhr);
										alert('Cannot load type data');
									}
								});
							});
					/* Modal Edit */

				});

		// ================= VALIDATE ADD =================
		function validateAddForm() {

			let name = $('#typeName').val().trim();

			if (name !== '') {
				$('#btnSaveAddType').prop('disabled', false);
			} else {
				$('#btnSaveAddType').prop('disabled', true);
			}
		}

		// check ตอนพิมพ์
		$('#typeName').on('keyup change', function() {
			validateAddForm();
		});

		// reset ตอนเปิด modal
		$('#btn-create-type').on('click', function() {

			$('#typeName').val('');
			$('#typeDescription').val('');
			$('#typeActive').prop('checked', true);

			validateAddForm();

			$('#modal_add_type').modal('show');
		});

		// ================= VALIDATE EDIT =================
		function validateEditForm() {

			let name = $('#editTypeName').val().trim();

			if (name !== '') {
				$('#btnSaveEditType').prop('disabled', false);
			} else {
				$('#btnSaveEditType').prop('disabled', true);
			}
		}

		// check ตอนพิมพ์
		$('#editTypeName').on('keyup change', function() {
			validateEditForm();
		});
	</script>
</body>

</html>