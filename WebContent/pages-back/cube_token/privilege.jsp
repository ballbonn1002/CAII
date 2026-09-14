<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<style>
.responsive-button {
	padding: 0.775rem 1.5rem !important;
	font-size: 1.1rem !important;
	border-radius: 0.475rem !important;
	/* Light theme */
	background-color: var(--bs-white) !important;
	color: var(--bs-primary) !important;
	border: 1px solid var(--bs-primary-border-subtle) !important;
	transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out,
		border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out !important;
}

/* Icon */
.responsive-button i {
	color: var(--bs-primary) !important;
	transition: color 0.2s ease-in-out !important;
}

/* Hover */
.responsive-button:hover {
	background-color: var(--bs-primary) !important;
	color: var(--bs-white) !important;
	border-color: var(--bs-primary) !important;
}

.responsive-button:hover i {
	color: var(--bs-white) !important;
}

[data-bs-theme="dark"] .responsive-button {
	background-color: transparent !important;
	color: var(--bs-primary) !important;
	border-color: var(--bs-primary) !important;
}

[data-bs-theme="dark"] .responsive-button i {
	color: var(--bs-primary) !important;
}

[data-bs-theme="dark"] .responsive-button:hover {
	background-color: var(--bs-primary) !important;
	color: var(--bs-white) !important;
	border-color: var(--bs-primary) !important;
}

[data-bs-theme="dark"] .responsive-button:hover i {
	color: var(--bs-white) !important;
}

.item-card {
	width: 320px;
	height: 545px;
}
</style>
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
						Privilege Management</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/check_in_out"
							class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a href="#"
							class="text-muted text-hover-primary">Cube Token Management</a></li>

						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/privilegePage"
							class="text-muted text-hover-primary">Privilege</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid ">
			<div id="kt_app_content_container"
				class="app-container container-fluid">

				<div class="d-flex align-items-center justify-content-between mt-10">
					<h3 class="fw-semibold text-gray-900">
						Item List (<span id="itemCount">${itemPrivileges.size()}</span>)
					</h3>
					<button
						class="d-flex align-items-center justify-content-start gap-3 btn responsive-button"
						type="button">
						<i class="ki-duotone ki-handcart fs-1"></i> <span class="fs-6">
							Privilege History </span>

					</button>
				</div>

				<div class="row row-cols-2 row-cols-md-3 row-cols-xl-4 g-5">
					<c:forEach var="item" items="${itemPrivileges}">
						<div class="col">
							<div class="card h-100">
								<div
									class="card-body d-flex flex-column justify-content-between">
									<div class="item-image-container border">
										<img src="${item.coverPath}" alt="${item.itemName}"
											class="w-150px h-150px" />
									</div>
								</div>
							</div>
						</div>

						<div class="col">
							<div class="card h-100">
								<div
									class="card-body d-flex flex-column justify-content-between">
									<div class="item-image-container border">
										<img src="${item.coverPath}" alt="${item.itemName}"
											class="w-150px h-150px" />
									</div>
								</div>
							</div>
						</div>

						<div class="col">
							<div class="card h-100">
								<div
									class="card-body d-flex flex-column justify-content-between">
									<div class="item-image-container border">
										<img src="${item.coverPath}" alt="${item.itemName}"
											class="w-150px h-150px" />
									</div>
								</div>
							</div>
						</div>

						<div class="col">
							<div class="item-card h-100">
								<div
									class="card-body d-flex flex-column justify-content-between">
									<div class="item-image-container border">
										<img src="${item.coverPath}" alt="${item.itemName}"
											class="w-150px h-150px" />
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>

				
			</div>
		</div>
	</div>


</body>
</html>