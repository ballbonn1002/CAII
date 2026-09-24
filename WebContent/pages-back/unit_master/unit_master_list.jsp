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
					<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">Unit Master</h1>

					<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a href="demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Unit Master</li>
					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid">

			<div id="kt_app_content_container" class="app-container container-fluid">

				<%-- ชื่อหน่วยกลาง (unit_master) - ที่มาของ dropdown "Unit Name" ในหน้า Product Edit
				     แก้ชื่อที่นี่จะ sync ไปยัง unit_of_measure.unit_name ของทุก product ที่ใช้หน่วยนี้อยู่ด้วย
				     (ดู UnitMasterDAOImpl.update()) --%>
				<div class="card card-flush mb-5 mb-xl-10 shadow-sm">
					<div class="card-header pt-5">
						<div class="card-title align-items-start">
							<span class="me-3">Unit Name</span>
						</div>
					</div>
					<div class="card-body pt-0">
						<div class="table-responsive">
							<table class="table align-middle table-row-dashed fs-6 gy-5" style="table-layout: fixed;">
								<thead>
									<tr class="text-uppercase text-muted">
										<th style="width: 50%;">Unit Name</th>
										<th style="width: 30%;" class="text-center">Used By</th>
										<th style="width: 20%;"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="um" items="${unitMasters}">
										<tr class="fs-5">
											<td class="text-truncate">${fn:escapeXml(um.unitName)}</td>
											<td class="text-center">
												<c:choose>
													<c:when test="${um.usageCount > 0}">
														<span class="badge badge-light-primary fs-7 fw-semibold py-2 px-3">${um.usageCount} unit(s)</span>
													</c:when>
													<c:otherwise>
														<span class="text-muted">-</span>
													</c:otherwise>
												</c:choose>
											</td>
											<td class="text-end">
												<button type="button" class="btn btn-icon btn-sm btn-light-primary btn-edit-unitMaster"
													data-id="${um.unitMasterId}" data-name="${fn:escapeXml(um.unitName)}"
													data-bs-toggle="modal" data-bs-target="#editUnitMaster" aria-label="Edit">
													<i class="ki-duotone ki-pencil fs-5">
														<span class="path1"></span>
														<span class="path2"></span>
													</i>
												</button>
											</td>
										</tr>
									</c:forEach>

									<c:if test="${empty unitMasters}">
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

			</div>

		</div>
	</div>

</div>

<!--begin::Modal - Edit Unit Master-->
<div class="modal fade" id="editUnitMaster" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header border-0 px-6 pt-5 pb-0 align-items-center">
				<h2 class="fw-bold m-0 text-gray-800 ps-4 pt-1">Edit Unit Name</h2>
				<div class="btn btn-sm btn-icon btn-active-color-primary" data-bs-dismiss="modal">
					<i class="ki-duotone ki-cross fs-1">
						<span class="path1"></span>
						<span class="path2"></span>
					</i>
				</div>
			</div>
			<div class="modal-body px-6 py-6">
				<form id="kt_edit_unitMaster_form">
					<input type="hidden" id="edit_unitMaster_id" name="unitMasterId" />

					<div class="mb-2">
						<label class="form-label required fw-bold">Unit Name</label>
						<input type="text" class="form-control" id="edit_unitMaster_name" name="unitName" maxlength="32" required />
						<div id="edit_unitMaster_error" class="text-danger fs-7 mt-2"></div>
					</div>
					<div class="text-muted fs-7">
						แก้ชื่อนี้จะมีผลกับทุก product ที่ใช้หน่วยนี้อยู่ทันที
					</div>
				</form>
			</div>
			<div class="modal-footer border-0 d-flex justify-content-end gap-3 py-6 px-6">
				<button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
				<button type="button" class="btn btn-success" id="btn_save_unitMaster">Save</button>
			</div>
		</div>
	</div>
</div>
<!--end::Modal - Edit Unit Master-->

<script>
	document.addEventListener("DOMContentLoaded", function() {
		var CONTEXT = '${pageContext.request.contextPath}';

		$('#editUnitMaster').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget);
			$('#edit_unitMaster_id').val(button.data('id'));
			$('#edit_unitMaster_name').val(button.data('name'));
			$('#edit_unitMaster_error').text('');
		});

		$('#editUnitMaster').on('hide.bs.modal', function() {
			if (document.activeElement) document.activeElement.blur();
		});

		$('#btn_save_unitMaster').on('click', function() {
			document.activeElement.blur();
			var $btn = $(this);
			var $form = $('#kt_edit_unitMaster_form');
			var name = $('#edit_unitMaster_name').val().trim();
			$('#edit_unitMaster_name').val(name);
			$('#edit_unitMaster_error').text('');

			if (!name) {
				$('#edit_unitMaster_error').text('กรุณากรอกชื่อหน่วย');
				return;
			}

			$btn.prop('disabled', true);

			$.ajax({
				url: CONTEXT + '/unit_master_update',
				type: 'POST',
				data: $form.serialize(),
				dataType: 'json',
				success: function(response) {
					if (response && response.success) {
						if (window.toastr) { toastr.success("Saved Successfully!", "Saved Successfully!"); }
						setTimeout(function() {
							window.location.reload();
						}, 800);
					} else {
						var msg = (response && response.message) ? response.message : 'Update failed';
						$('#edit_unitMaster_error').text(msg);
						$btn.prop('disabled', false);
					}
				},
				error: function() {
					$('#edit_unitMaster_error').text('เกิดข้อผิดพลาด กรุณาลองใหม่');
					$btn.prop('disabled', false);
				}
			});
		});
	});
</script>
