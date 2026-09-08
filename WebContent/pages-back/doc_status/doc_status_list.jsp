<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!--begin::Main-->
<div class="app-main flex-column flex-row-fluid">

	<div class="d-flex flex-column flex-column-fluid">

		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
				<div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">Doc Status Management</h1>

					<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a href="demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Doc Status</li>
					</ul>
				</div>

			</div>
		</div>
	
		<div id="kt_app_content" class="app-content flex-column-fluid">

			<div id="kt_app_content_container" class="app-container container-fluid">

				<div class="d-flex flex-row">
					<div class="flex-row-fluid mb-5">

						<c:forEach var="entry" items="${statusGroupMap}">
							<div class="card card-flush mb-5 mb-xl-10 shadow-sm">
								<div class="card-header pt-5">
									<div class="card-title align-items-start">
										<span class="me-3">${fn:toUpperCase(entry.key)}</span>
									</div>
								</div>
								<div class="card-body pt-0">
									<div class="table-responsive">
										<table class="table align-middle table-row-dashed fs-6 gy-5" style="table-layout: fixed;">
											<thead>
												<tr class="text-uppercase text-muted">
													<th style="width: 15%;" class="text-center">Status Code</th>
													<th style="width: 35%;" >Name</th>
													<th style="width: 35%;" >Description</th>
													<th style="width: 15%;"></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="status" items="${entry.value}">
													<tr class="fs-5">
														<td class="text-truncate text-center">${status.statusCode}</td>
														<td class="text-truncate">
															<span class="badge badge-lg badge-${status.color} fw-semibold fs-7">${status.statusName}</span>
														</td>
														<td class="text-truncate">${empty status.description ? '-' : status.description}</td>
														<td class="text-end">
															<button type="button" class="btn btn-icon btn-sm btn-light-primary btn-edit-docStatus" data-id="${status.docStatusId}"
																data-code="${status.statusCode}" data-group="${status.page}" data-name="${status.statusName}" data-desc="${status.description}" data-color="${status.color}"
																data-bs-toggle="modal" data-bs-target="#editDocStatus" aria-label="Edit">
																<i class="ki-duotone ki-pencil fs-5">
																	<span class="path1"></span>
																	<span class="path2"></span>
																</i>
															</button>
														</td>
													</tr>
												</c:forEach>

												<c:if test="${empty entry.value}">
													<tr>
														<td colspan="4" class="text-center text-muted">
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

						<c:if test="${empty statusGroupMap}">
							<div class="card card-flush mb-5 mb-xl-10 shadow-sm">
								<div class="card-body text-center text-muted">
									<i class="ki-duotone ki-cube-2 fs-2 me-2">
										<span class="path1"></span>
										<span class="path2"></span>
										<span class="path3"></span>
									</i>
									No Data
								</div>
							</div>
						</c:if>

					</div>
				</div>

			</div>
	
		</div>
	</div>

</div>

<!--begin::Modal - Edit Doc Status-->
<div class="modal fade" id="editDocStatus" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header border-0 px-6 pt-5 pb-0 align-items-center">
				<h2 class="fw-bold m-0 text-gray-800 ps-4 pt-1">Edit Doc Status</h2>
				<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal">
					<i class="ki-duotone ki-cross fs-1">
						<span class="path1"></span>
						<span class="path2"></span>
					</i>
				</div>
			</div>
			<div class="modal-body px-6 py-6">
				<form id="kt_edit_docStatus_form">
					<input type="hidden" id="edit_docStatus_id" name="docStatusId" />

					<div class="mb-8">
						<label class="form-label fw-bold">Group</label>
						<input type="text" class="form-control" id="edit_docStatus_group" readonly disabled />
					</div>

					<div class="mb-8">
						<label class="form-label fw-bold">Status Code</label>
						<input type="text" class="form-control" id="edit_docStatus_code" readonly disabled />
					</div>

					<div class="mb-8">
						<label class="form-label required fw-bold">Status Name</label>
						<input type="text" class="form-control" id="edit_docStatus_name" name="docStatus.statusName" required />
					</div>

					<div class="mb-8">
						<label class="form-label fw-bold">Description</label>
						<input type="text" class="form-control" id="edit_docStatus_desc" name="docStatus.description" />
					</div>

					<div class="mb-8">
						<label class="form-label required fw-bold">Color</label>
						<select class="form-select" name="docStatus.color" id="edit_docStatus_color" data-control="select2" data-placeholder="Select a color" required></select>
					</div>

					<div class="mb-0">
						<span id="edit_docStatus_preview" class="badge badge-lg badge-secondary fs-7 px-4 py-2">Preview</span>
					</div>
				</form>
			</div>
			<div class="modal-footer border-0 d-flex justify-content-end gap-3 py-6 px-6">
				<button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
				<button type="button" class="btn btn-success" id="btn_save_docStatus">Save</button>
			</div>
		</div>
	</div>
</div>
<!--end::Modal - Edit Doc Status-->

<script>
	document.addEventListener("DOMContentLoaded", function() {
		// รายชื่อสีดึงจาก .badge-xxx ที่มีจริงใน style.bundle.css (เฉพาะสีเข้ม ไม่รวม badge-light-*)
		var COLOR_LIST = [
			{ id: 'secondary', name: 'Secondary' },
			{ id: 'primary',   name: 'Primary' },
			{ id: 'success',   name: 'Success' },
			{ id: 'warning',   name: 'Warning' },
			{ id: 'info',      name: 'Info' },
			{ id: 'danger',    name: 'Danger' },
			{ id: 'dark',      name: 'Dark' },
			{ id: 'cyan',      name: 'Cyan' },
			{ id: 'green',     name: 'Green' }
		];

		var colorSelect = document.getElementById('edit_docStatus_color');
		colorSelect.innerHTML = '';
		COLOR_LIST.forEach(function(color) {
			colorSelect.add(new Option(color.name, color.id));
		});

		$('#edit_docStatus_color').select2({
			dropdownParent: $('#editDocStatus'),
			minimumResultsForSearch: Infinity
		});

		function updateEditPreview(text, color) {
			var badge = document.getElementById('edit_docStatus_preview');
			badge.innerText = text || 'Preview';
			badge.className = 'badge badge-lg fs-7 px-4 py-2';
			badge.classList.add('badge-' + (color || 'secondary'));
		}

		$('#editDocStatus').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget);
			var id = button.data('id');
			var code = button.data('code');
			var group = button.data('group');
			var name = button.data('name');
			var desc = button.data('desc');
			var color = button.data('color') || 'secondary';

			$('#edit_docStatus_id').val(id);
			$('#edit_docStatus_code').val(code);
			$('#edit_docStatus_group').val(group);
			$('#edit_docStatus_name').val(name);
			$('#edit_docStatus_desc').val(desc);

			$('#edit_docStatus_color').val(color).trigger('change');
			updateEditPreview(name, color);
		});

		$('#editDocStatus').on('hide.bs.modal', function() {
			if (document.activeElement) document.activeElement.blur();
		});

		$('#edit_docStatus_color').on('change', function() {
			updateEditPreview($('#edit_docStatus_name').val(), $(this).val());
		});

		$('#edit_docStatus_name').on('input', function() {
			updateEditPreview($(this).val(), $('#edit_docStatus_color').val());
		});

		$('#btn_save_docStatus').on('click', function() {
			document.activeElement.blur();
			var $form = $('#kt_edit_docStatus_form');

			$('#edit_docStatus_name').val($('#edit_docStatus_name').val().trim());
			$('#edit_docStatus_desc').val($('#edit_docStatus_desc').val().trim());

			$.ajax({
				url: 'doc_status_update',
				type: 'POST',
				data: $form.serialize(),
				dataType: 'json',
				success: function(response) {
					if (response.success) {
						toastr.success("Saved Successfully!", "Saved Successfully!");
						setTimeout(function() {
							window.location.reload();
						}, 800);
					} else {
						Swal.fire('Error', response.message || 'Update failed', 'error');
					}
				},
				error: function(err) {
					console.error('Error updating doc status:', err);
					Swal.fire('Error', 'There was an error updating the data.', 'error');
				}
			});
		});
	});
</script>

