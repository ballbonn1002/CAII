<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
</head>
<body>
	<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
		<div class="d-flex flex-column flex-column-fluid">

			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container"
					class="app-container container-xxl d-flex flex-stack">
					<div class="page-title d-flex flex-column justify-content-center">
						<h1 class="page-heading text-gray-700 fw-semibold my-0">Create
							Jobsite</h1>
						<ul
							class="breadcrumb breadcrumb-separatorless fw-medium fs-7 text-muted pt-1">
							<li class="breadcrumb-item">Home</li>
							<li class="breadcrumb-item"><span
								class="bullet w-5px h-2px"></span></li>
							<li class="breadcrumb-item">Master</li>
							<li class="breadcrumb-item"><span
								class="bullet w-5px h-2px"></span></li>
							<li class="breadcrumb-item ">Jobsite</li>
						</ul>
					</div>
				</div>
			</div>

			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container"
					class="app-container container-xxl">
					<!--begin::Card-->
					<div class="card">
						<form action="saveJobsite.action" method="post" class="form"
							autocomplete="off">

							<div class="card-header border-0 pt-6 align-items-start">
								<div class="card-title pt-3">
									<h3 class="page-heading d-flex text-gray-900 fw-semibold my-0">Jobsite</h3>
								</div>

								<div class="card-toolbar d-flex flex-column align-items-end pt-3">
									<div class="d-flex align-items-center mb-3">
										<!-- Status Toggle -->
										<span class="fw-medium fs-6 text-gray-700 me-3"
											id="statusLabel">Active</span> <label
											class="form-check form-switch form-check-success mb-0">
											<input type="checkbox" class="form-check-input" id="isActive"
											name="is_active" value="1" checked
											style="width:33px;">
										</label>
									</div>
								</div>
							</div>

							<div class="card-body p-10 pt-3">

								<div class="row">

									<!-- Job Site Name -->
									<div class="col-12 col-md-6 ">
										<label class="form-label fw-medium text-gray-800"> Job Site Name <span
											class="required"></span>
										</label> <input type="text" name="jobsite.name_site"
											class="form-control form-select-lg h-55px fw-medium text-gray-700" />
									</div>

									<!-- Description -->
									<div class="col-12 col-md-6">
										<label class="form-label fw-medium text-gray-800"> Description
											Name</label> <input type="text" name="jobsite.description"
											"
											class="form-control form-select-lg h-55px fw-medium text-gray-700" />
									</div>
								</div>
							</div>

							<div class="card-footer d-flex justify-content-end gap-3 p-8">
								<a href="${pageContext.request.contextPath}/jobsite_list.action"
									class="btn btn-light px-8 btn-lg">Cancel</a>
								<button type="submit" class="btn btn-success px-8 fw-medium btn-lg">Save</button>
							</div>
						</form>

					</div>
				</div>
			</div>

		</div>
	</div>


	<script>
		const toggle = document.getElementById("isActive");
		const label = document.getElementById("statusLabel");

		function updateStatusLabel() {
			label.textContent = toggle.checked ? "Active" : "Inactive";
		}

		toggle.addEventListener("change", updateStatusLabel);
		updateStatusLabel();
	</script>

</body>
</html>