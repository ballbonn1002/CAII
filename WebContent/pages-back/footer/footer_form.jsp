<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Footer</title>

<link
	href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
	rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/flatpickr/dist/plugins/monthSelect/index.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/plugins/monthSelect/style.css">

<script
	src="https://cdn.jsdelivr.net/npm/sortablejs@latest/Sortable.min.js"></script>

<style type="text/css">
.ps-12 {
	padding-left: 3rem !important;
}

.search-icon {
	position: absolute;
	top: 50%;
	left: 14px;
	transform: translateY(-60%);
	z-index: 10;
	pointer-events: none;
}
</style>

</head>
<body>
	<div class="app-main flex-column app-container container-xxl">
		<div class="page-title py-3">
			<h1 class="page-heading fw-bold text-gray-900 fs-3">${not empty parentId ?'Menu Edit Form':'Menu Add Form'}</h1>
			<ul
				class="list-unstyled d-inline-flex gap-2 text-muted fs-7 fw-medium">
				<li class="">Home</li>
				<li class="">-</li>
				<li class="">CMS</li>
				<li class="">-</li>
				<li class="">Footer Menu</li>
			</ul>
		</div>

		<div class="app-content">
			<div class="card">
				<div class="card-header pt-7 border-0">
					<h3 class="fw-bold text-gray-900 fs-3">${not empty parentId ?'Menu Edit':'Menu Add'}</h3>
				</div>
				<form id="footerForm" method="post"
					action="${empty parentId ? 'footer_save' : 'footer_update'}">

					<input type="hidden" name="parentId" id="parentId"
						value="${parentId}">

					<div class="card-body pb-0">
						<div class="mb-7">
							<label class="form-label text-gray-800 fw-medium required">Title
								Name EN</label> <input class="form-control" type="text"
								name="titleNameEN" id="footerNameEN" required="required"
								value="${titleNameEN}">
						</div>
						<div class="mb-7">
							<label class="form-label text-gray-800 fw-medium">Title
								Name TH</label> <input class="form-control" type="text"
								name="titleNameTH" id="footerNameTH" value="${titleNameTH}">
						</div>
						<div class="mb-7">
							<label class="form-label text-gray-800 fw-medium required">Link
								Navigation</label> <input class="form-control" type="url" name="url"
								id="url" required="required" value="${url}">
						</div>

						<div class="mb-7">
							<label class="d-flex align-items-center fs-6 fw-semibold mb-2">
								<span>Active</span>
							</label>
							<div class="form-check form-switch">
								<input class="form-check-input" type="checkbox" role="switch"
									value="true" id="status" name="status"
									${status == 'true' || status == true ? 'checked' : ''} />
							</div>
						</div>
					</div>
					<div class="card-footer d-flex justify-content-end gap-3">
						<a href="footer_list" class="btn btn-bg-secondary px-8 fw-medium">Cancel</a>
						<button class="btn btn-bg-success px-8 fw-medium text-white"
							type="submit">Save</button>
					</div>
				</form>
			</div>

			<c:if test="${not empty parentId }">
				<div class="card mt-7">
					<div class="card-header pt-7 border-0 align-items-center">
						<h3 class="fw-bold text-gray-900 fs-3 mb-0">Footer Menu</h3>

						<div class="d-flex gap-5 align-items-center">
							<span id="dragDropHint" class="text-muted fs-6 fw-bold d-none">
								<i class="ki-duotone ki-information fs-5 me-1"></i> Drag & drop
								hierarchical list with mouse.
							</span>

							<button class="btn btn-info" id="btnEditSequence"
								onclick="editSequence()">
								<i class="ki-duotone ki-element-11 fs-2"><span class="path1"></span><span
									class="path2"></span><span class="path3"></span><span
									class="path4"></span></i> Edit Sequence
							</button>

							<button class="btn btn-primary d-none" id="btnSaveSequence"
								onclick="saveSequence()">Complete</button>

							<button class="btn btn-success" id="btnAddFooter"
								onclick="openModalAdd(${parentId})">
								<i class="ki-duotone ki-plus fs-2"></i> Add Footer Menu
							</button>
						</div>
					</div>

					<div class="card-body">
						<table class="table table-bordered fs-6 gy-5 mb-10">
							<thead class="text-gray-500 fw-bold fs-7"
								id="sequence-table-head">
								<tr>
									<th>Sequence</th>
									<th>Menu Name EN</th>
									<th>Menu Name TH</th>
									<th>Link Navigation</th>
									<th class="text-center">Active</th>
									<th class="text-center action-col">Action</th>
								</tr>
							</thead>

							<tbody class="fw-semibold text-gray-600" id="sortable-table-body">
								<c:forEach var="c" items="${childFooterList}" varStatus="status">
									<tr
										class="align-middle border-bottom border-gray-200 sequence-row"
										data-id="${c.footer_id}">
										<td class="text-gray-900 sequence-num">${c.sequence}</td>
										<td class="text-gray-600">${c.footer_name}</td>
										<td class="text-gray-600">${c.footer_name_th}</td>
										<td class="text-gray-600">${c.footer_url}</td>
										<td class="text-center"><c:choose>
												<c:when test="${c.status eq '1'}">
													<span
														class="badge bg-light-success border text-success fs-6 px-4 py-2">Active</span>
												</c:when>
												<c:otherwise>
													<span
														class="badge bg-light-danger text-danger fs-6 px-4 py-2">Inactive</span>
												</c:otherwise>
											</c:choose></td>

										<td class="text-end text-nowrap pe-5 action-col"
											style="width: 120px;">
											<div
												class="d-inline-flex align-items-center justify-content-end gap-2 action-buttons">
												<button type="button"
													class="btn btn-edit-type btn-icon btn-sm btn-light-primary"
													aria-label="Edit" onclick="openModalEdit(this)"
													data-id="${c.footer_id}" data-name-en="${c.footer_name}"
													data-name-th="${c.footer_name_th}"
													data-url="${c.footer_url}" data-status="${c.status}">
													<i class="ki-duotone ki-pencil fs-5"><span
														class="path1"></span><span class="path2"></span></i>
												</button>
												<button class="btn btn-icon btn-light-danger btn-sm"
													onclick="onDelete(${c.footer_id})">
													<i class="ki-duotone ki-trash fs-5"><span class="path1"></span><span
														class="path2"></span><span class="path3"></span><span
														class="path4"></span><span class="path5"></span></i>
												</button>
											</div>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</c:if>
		</div>
	</div>

	<div class="modal fade" tabindex="-1" id="modal_add_footer">
		<div class="modal-dialog">
			<div class="modal-content">
				<form method="POST" action="footer_save" id="addChildFooterForm">
					<input type="hidden" name="parentId" value="${parentId}" /> <input
						type="hidden" name="childId" id="childFooterId" value="" />

					<div class="modal-header">
						<h3 class="modal-title" id="modalTitleText">Add Footer Menu</h3>
						<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
							data-bs-dismiss="modal" aria-label="Close">
							<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span
								class="path2"></span></i>
						</div>
					</div>

					<div class="modal-body">
						<div
							class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
							<label
								class="d-flex align-items-center fs-6 fw-semibold mb-2 required">
								<span>Menu Name EN</span>
							</label> <input type="text" class="form-control form-control-solid"
								name="titleNameEN" id="titleNameEN-child" required />
						</div>
						<div
							class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
							<label class="d-flex align-items-center fs-6 fw-semibold mb-2 ">
								<span>Menu Name TH</span>
							</label> <input type="text" class="form-control form-control-solid"
								name="titleNameTH" id="titleNameTH-child" />
						</div>

						<div
							class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
							<label
								class="d-flex align-items-center fs-6 fw-semibold mb-2 required">
								<span>Link Navigation</span>
							</label> <input type="url" class="form-control form-control-solid"
								name="url" id="url-child" required />
						</div>

						<div
							class="d-flex flex-column mb-8 fv-row fv-plugins-icon-container">
							<label class="d-flex align-items-center fs-6 fw-semibold mb-2">
								<span>Active</span>
							</label>
							<div class="form-check form-switch">
								<input class="form-check-input" type="checkbox" role="switch"
									value="true" id="statusActiveChild" name="status" />
							</div>
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-light"
							data-bs-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-success"
							id="btnSaveAddChildFooter">Save</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	// --- 1. ฟังก์ชันเช็คค่าฟิลด์ ---
	const checkMainForm = () => {
		let isValid = true;
		$('#footerForm input[required]').each(function() {
			if ($.trim($(this).val()) === '') {
				isValid = false;
			}
		});
		$('#footerForm button[type="submit"]').prop('disabled', !isValid);
	};

	const checkChildForm = () => {
		let isValid = true;
		$('#addChildFooterForm input[required]').each(function() {
			if ($.trim($(this).val()) === '') {
				isValid = false;
			}
		});
		$('#btnSaveAddChildFooter').prop('disabled', !isValid);
	};

	// --- 2. Event Listeners ---
	$(document).ready(function() {
		checkMainForm();
		checkChildForm();


		$('#footerForm').on('input', 'input[required]', checkMainForm);
		$('#addChildFooterForm').on('input', 'input[required]', checkChildForm);


		$('#footerForm, #addChildFooterForm').on('submit', function(e) {
			$(this).find('input[type="text"], input[type="url"]').each(function() {
				$(this).val($.trim($(this).val()));
			});
		});
	});


	const onDelete = (id) => {
		Swal.fire({
			title: 'Are you sure?',
			text: "This footer will be deleted.",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: 'Yes, delete it!'
		}).then((result) => {
			if (result.isConfirmed) {
				window.location.href = "footer_delete?footerId=" + id;
			}
		});
	}

	const openModalAdd = (parentId) => {
		$('#addChildFooterForm')[0].reset();
		$('#childFooterId').val('');
		
		$('#addChildFooterForm').attr('action', 'footer_save');
		$('#modalTitleText').text('Add Footer Menu');
		
		$('#btnSaveAddChildFooter').prop('disabled', true);
		$('#modal_add_footer').modal('show');
	}
	
	const openModalEdit = (btn) => {
		const id = $(btn).data('id');
		const nameEn = $(btn).data('name-en');
		const nameTh = $(btn).data('name-th');
		const url = $(btn).data('url');
		const status = $(btn).data('status');

		$('#childFooterId').val(id);
		$('#titleNameEN-child').val(nameEn);
		$('#titleNameTH-child').val(nameTh);
		$('#url-child').val(url);
		
		if(status == '1' || status == true || status == 'true'){
			$('#statusActiveChild').prop('checked', true);
		} else {
			$('#statusActiveChild').prop('checked', false);
		}

		$('#addChildFooterForm').attr('action', 'footer_update');
		$('#modalTitleText').text('Edit Footer Menu');

		checkChildForm();

		$('#modal_add_footer').modal('show');
	}

	// --- 4. ฟังก์ชัน Drag & Drop Sequence ---
	let sortableInstance = null;

	const editSequence = () => {
		$('#btnEditSequence, #btnAddFooter').addClass('d-none');
		$('#btnSaveSequence, #dragDropHint').removeClass('d-none');
		
		$('#sequence-table-head').addClass('bg-dark').find('th').addClass('text-white').removeClass('text-gray-500');
		$('.sequence-row').css('cursor', 'grab');
		$('.action-buttons button').prop('disabled', true);

		const tbody = document.getElementById('sortable-table-body');
		sortableInstance = new Sortable(tbody, {
			animation: 150,
			ghostClass: 'bg-light-primary',
			onEnd: function (evt) {
				// รันเลขอัปเดตที่หน้าจอ
				$('#sortable-table-body tr').each(function(index) {
					$(this).find('.sequence-num').text(index + 1);
				});
			}
		});
	};

	
		const saveSequence = () => {
			let idArray = [];
			

			$('#sortable-table-body tr').each(function() {
				idArray.push($(this).data('id')); 
			});

			// แปลง Array เป็น String เช่น "15,12,18"
			let idsString = idArray.join(','); 

			$.ajax({
				url: 'footer_update_sequence', /
				type: 'POST',
				data: { orderedIds: idsString }, 
				success: function(response) {
					Swal.fire({
						icon: 'success',
						title: 'Sequence Updated!',
						showConfirmButton: false,
						timer: 1500
					}).then(() => {
						window.location.reload();
					});
				},
				error: function(error) {
					Swal.fire('Error', 'Failed to update sequence', 'error');
				}
			});
		};
</script>

</body>
</html>