<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
						Warehouse</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/check_in_out"
							class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/warehouse_list"
							class="text-muted text-hover-primary">Warehouse</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container"
				class="app-container container-fluid">

				<div class="card card-flush ">

					<div class="card-header">
						<div class="card-title">
							<h3 class="fw-semibold text-gray-900">Cube Center</h3>
						</div>
						<div class="card-toolbar">
							<button
								class="btn btn-success py-3 px-6 d-inline-flex align-items-center gap-1"
								data-bs-toggle="modal" data-bs-target="#createWarehouseModal">
								<i class="ki-duotone ki-plus fs-4"> </i> <span>Create</span>
							</button>
						</div>
					</div>

					<div class="modal fade" tabindex="-1" id="createWarehouseModal">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header border-0">
									<h2 class="modal-title fw-semibold">Warehouse</h2>

									<!--begin::Close-->
									<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
										data-bs-dismiss="modal" aria-label="Close">
										<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span
											class="path2"></span></i>
									</div>
									<!--end::Close-->
								</div>

								<div class="modal-body">
									<div class="row g-8 mb-8">
										<div class="col-md-12 create-warehouse-validate-container">
											<label for="Warehouse Name" class="form-label required">Warehouse
												Name</label> <input type="text" class="form-control form-control-lg"
												id="name-create" placeholder="ชั้นที่ 2" required />
										</div>
										<div class="col-md-12 ">
											<label for="Description" class="form-label">
												Description </label>
											<textarea class="form-control" data-kt-autosize="true"
												id="desc-create"></textarea>
										</div>

									</div>
								</div>

								<div class="modal-footer border-0">
									<button type="button" class="btn btn-light"
										data-bs-dismiss="modal">Close</button>
									<button type="button" id="saveIndustryBtn"
										class="btn btn-success">Save</button>
								</div>
							</div>
						</div>
					</div>

					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-striped align-middle table-row-dashed"
								id="kt_datatable_zero_configuration">
								<thead>
									<tr class="text-muted text-uppercase">
										<th>Name</th>
										<th>Description</th>
										<th class="text-end">Action</th>
									</tr>
								</thead>

								<tbody>

									<!-- ================= ROOT ================= -->

									<tr class="folder-row" data-id="1">
										<td>
											<div class="d-flex align-items-center">
												<span class="toggle-folder me-2 cursor-pointer"> <i
													class="ki-duotone ki-right fs-5"></i>
												</span> <i class="ki-duotone ki-folder fs-3 me-2 text-warning"></i>
												Cube ITF Warehouse
											</div>
										</td>
										<td>Main Warehouse</td>
										<td class="text-end">
											<button class="btn btn-sm btn-light-success">+</button>
											<button class="btn btn-sm btn-light-primary">Edit</button>
											<button class="btn btn-sm btn-light-danger">Delete</button>
										</td>
									</tr>

									<!-- ================= LEVEL 1 ================= -->

									<tr class="folder-child d-none" data-id="2" data-parent="1">
										<td>
											<div class="d-flex align-items-center ps-8">
												<span class="toggle-folder me-2 cursor-pointer"> <i
													class="ki-duotone ki-right fs-5"></i>
												</span> <i class="ki-duotone ki-folder fs-3 me-2 text-warning"></i>
												อาคาร A
											</div>
										</td>
										<td>Building A</td>
										<td class="text-end">
											<button class="btn btn-sm btn-light-success">+</button>
											<button class="btn btn-sm btn-light-primary">Edit</button>
											<button class="btn btn-sm btn-light-danger">Delete</button>
										</td>
									</tr>

									<tr class="folder-child d-none" data-id="3" data-parent="1">
										<td>
											<div class="d-flex align-items-center ps-8">
												<span class="toggle-folder me-2 cursor-pointer"> <i
													class="ki-duotone ki-right fs-5"></i>
												</span> <i class="ki-duotone ki-folder fs-3 me-2 text-warning"></i>
												อาคาร B
											</div>
										</td>
										<td>Building B</td>
										<td class="text-end">
											<button class="btn btn-sm btn-light-success">+</button>
											<button class="btn btn-sm btn-light-primary">Edit</button>
											<button class="btn btn-sm btn-light-danger">Delete</button>
										</td>
									</tr>

									<!-- ================= LEVEL 2 ================= -->

									<tr class="folder-child d-none" data-id="4" data-parent="2">
										<td>
											<div class="d-flex align-items-center ps-15">
												<span class="toggle-folder me-2 cursor-pointer"> <i
													class="ki-duotone ki-right fs-5"></i>
												</span> <i class="ki-duotone ki-folder fs-3 me-2 text-warning"></i>
												ชั้น 1
											</div>
										</td>
										<td>Floor 1</td>
										<td class="text-end">
											<button class="btn btn-sm btn-light-success">+</button>
											<button class="btn btn-sm btn-light-primary">Edit</button>
											<button class="btn btn-sm btn-light-danger">Delete</button>
										</td>
									</tr>

									<tr class="folder-child d-none" data-id="5" data-parent="2">
										<td>
											<div class="d-flex align-items-center ps-15">
												<i class="ki-duotone ki-folder fs-3 me-2 text-warning"></i>
												ชั้น 2
											</div>
										</td>
										<td>Floor 2</td>
										<td class="text-end">
											<button class="btn btn-sm btn-light-success">+</button>
											<button class="btn btn-sm btn-light-primary">Edit</button>
											<button class="btn btn-sm btn-light-danger">Delete</button>
										</td>
									</tr>

									<!-- ================= LEVEL 3 ================= -->

									<tr class="folder-child d-none" data-id="6" data-parent="4">
										<td>
											<div class="d-flex align-items-center ps-20">
												<span class="toggle-folder me-2 cursor-pointer"> <i
													class="ki-duotone ki-right fs-5"></i>
												</span> <i class="ki-duotone ki-folder fs-3 me-2 text-warning"></i>
												ห้อง Server
											</div>
										</td>
										<td>Server Room</td>
										<td class="text-end">
											<button class="btn btn-sm btn-light-success">+</button>
											<button class="btn btn-sm btn-light-primary">Edit</button>
											<button class="btn btn-sm btn-light-danger">Delete</button>
										</td>
									</tr>

									<tr class="folder-child d-none" data-id="7" data-parent="4">
										<td>
											<div class="d-flex align-items-center ps-20">
												<span class="toggle-folder me-2 cursor-pointer"> <i
													class="ki-duotone ki-right fs-5"></i>
												</span> <i class="ki-duotone ki-folder fs-3 me-2 text-warning"></i>
												ห้อง IT
											</div>
										</td>
										<td>IT Room</td>
										<td class="text-end">
											<button class="btn btn-sm btn-light-success">+</button>
											<button class="btn btn-sm btn-light-primary">Edit</button>
											<button class="btn btn-sm btn-light-danger">Delete</button>
										</td>
									</tr>

									<!-- ================= LEVEL 4 ================= -->

									<tr class="folder-child d-none" data-id="8" data-parent="6">
										<td>
											<div class="d-flex align-items-center ps-25">
												<span class="toggle-folder me-2 cursor-pointer"> <i
													class="ki-duotone ki-right fs-5"></i>
												</span> <i class="ki-duotone ki-folder fs-3 me-2 text-warning"></i>
												Rack A
											</div>
										</td>
										<td>Rack A</td>
										<td class="text-end">
											<button class="btn btn-sm btn-light-success">+</button>
											<button class="btn btn-sm btn-light-primary">Edit</button>
											<button class="btn btn-sm btn-light-danger">Delete</button>
										</td>
									</tr>

									<tr class="folder-child d-none" data-id="9" data-parent="6">
										<td>
											<div class="d-flex align-items-center ps-25">
												<i class="ki-duotone ki-folder fs-3 me-2 text-warning"></i>
												Rack B
											</div>
										</td>
										<td>Rack B</td>
										<td class="text-end">
											<button class="btn btn-sm btn-light-success">+</button>
											<button class="btn btn-sm btn-light-primary">Edit</button>
											<button class="btn btn-sm btn-light-danger">Delete</button>
										</td>
									</tr>

									<!-- ================= LEVEL 5 ================= -->

									<tr class="folder-child d-none" data-id="10" data-parent="8">
										<td>
											<div class="d-flex align-items-center ps-30">
												<i class="ki-duotone ki-folder fs-3 me-2 text-info"></i>
												Shelf A-01
											</div>
										</td>
										<td>Dell Servers</td>
										<td class="text-end">
											<button class="btn btn-sm btn-light-success">+</button>
											<button class="btn btn-sm btn-light-primary">Edit</button>
											<button class="btn btn-sm btn-light-danger">Delete</button>
										</td>
									</tr>

									<tr class="folder-child d-none" data-id="11" data-parent="8">
										<td>
											<div class="d-flex align-items-center ps-30">
												<i class="ki-duotone ki-folder fs-3 me-2 text-info"></i>
												Shelf A-02
											</div>
										</td>
										<td>HP Servers</td>
										<td class="text-end">
											<button class="btn btn-sm btn-light-success">+</button>
											<button class="btn btn-sm btn-light-primary">Edit</button>
											<button class="btn btn-sm btn-light-danger">Delete</button>
										</td>
									</tr>

									<!-- ================= Another Branch ================= -->

									<tr class="folder-child d-none" data-id="12" data-parent="3">
										<td>
											<div class="d-flex align-items-center ps-15">
												<span class="toggle-folder me-2 cursor-pointer"> <i
													class="ki-duotone ki-right fs-5"></i>
												</span> <i class="ki-duotone ki-folder fs-3 me-2 text-warning"></i>
												ห้องเอกสาร
											</div>
										</td>
										<td>Document Room</td>
										<td class="text-end">
											<button class="btn btn-sm btn-light-success">+</button>
											<button class="btn btn-sm btn-light-primary">Edit</button>
											<button class="btn btn-sm btn-light-danger">Delete</button>
										</td>
									</tr>

									<tr class="folder-child d-none" data-id="13" data-parent="12">
										<td>
											<div class="d-flex align-items-center ps-20">
												<i class="ki-duotone ki-folder fs-3 me-2 text-info"></i>
												ตู้เอกสาร 2026
											</div>
										</td>
										<td>Archive</td>
										<td class="text-end">
											<button class="btn btn-sm btn-light-success">+</button>
											<button class="btn btn-sm btn-light-primary">Edit</button>
											<button class="btn btn-sm btn-light-danger">Delete</button>
										</td>
									</tr>

								</tbody>
								</tbody>

							</table>
						</div>

					</div>


				</div>



			</div>

		</div>

	</div>

	<script
		src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
	<script
		src="${pageContext.request.contextPath}/assets/js/scripts.bundle.js"></script>
	<script>
		$(document).on("click", ".toggle-folder", function() {

			const row = $(this).closest("tr");
			console.log(row.data("id"));
			const folderId = row.data("id");

			const children = $(`tr[data-parent='\${folderId}']`);

			children.toggleClass("d-none");

			$(this).find("i").toggleClass("ki-right").toggleClass("ki-down");
		});
	</script>
</body>
</html>