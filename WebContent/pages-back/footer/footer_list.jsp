<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Footer Menu</title>

<!-- Select2  -->
<link
	href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
	rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<!-- Metronic core -->
<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>

<!-- flatpickr  -->
<script
	src="https://cdn.jsdelivr.net/npm/flatpickr/dist/plugins/monthSelect/index.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/plugins/monthSelect/style.css">

<style type="text/css">
.ps-12 {
	padding-left: 3rem !important;
}

.search-icon {
	position: absolute;
	top: 50%;
	left: 14px;
	transform: translateY(-70%);
	z-index: 10;
	pointer-events: none;
}

.dot {
	display: inline-block;
	width: 10px;
	height: 10px;
	border-radius: 50%;
	margin-right: 8px;
}

.dot-sunday {
	background: #dc3545;
}

.dot-monday {
	background: #ffc107;
}

.dot-tuesday {
	background: #ff6b81;
}

.dot-wednesday {
	background: #28a745;
}

.dot-thursday {
	background: #fd7e14;
}

.dot-friday {
	background: #007bff;
}

.dot-saturday {
	background: #6f42c1;
}

.bg-weekend {
	background: #e1e5ec;
}

.bg-holiday {
	background: #eef4fb;
}
</style>
</head>
<body>
	<div class="app-main flex-column app-container container-xxl">
		<div class="page-title py-3">
			<h1 class="page-heading text-gray-900 fw-bold fs-3">Footer Menu</h1>
			<ul
				class="list-unstyled d-inline-flex gap-2 text-muted fs-7 fw-medium">
				<li class="">Home</li>
				<li class="">-</li>
				<li class="">CMS</li>
			</ul>
		</div>
		<div class="app-content">
			<div class="card">
				<div class="card-header pt-7 border-0">
					<h3 class="fw-bold text-gray-900 fs-3">Footer Menu List</h3>
					<a href="javascript:void(0)" class="btn btn-success btn-lg"
						onclick="document.location = 'footer_add';"> <i
						class="ki-duotone ki-plus"></i> Create
					</a>
				</div>
				<div class="card-body pb-0">
					<div class="table-responsive">
						<c:forEach var="p" items="${parentFooterList}">
							<c:set var="keyId">${p.footer_id}</c:set>
							<c:set var="childList" value="${parentFooterMap[keyId]}" />
							<table class="table table-bordered fs-6 gy-5 mb-10">
								<thead class="text-gray-500 fw-bold fs-7">
									<tr>
										<th>
											<div
												class="d-flex align-items-center justify-content-between px-4">
												<div class="d-flex align-items-center gap-5">

													<h5 class="m-0">${p.footer_name}</h5>
													<c:choose>
														<c:when test="${p.status eq '1'}">
															<span
																class="badge bg-light-success border text-success fs-6 px-4 py-2">Active</span>
														</c:when>
														<c:otherwise>
															<span
																class="badge bg-light-danger text-danger fs-6 px-4 py-2">Inactive</span>
														</c:otherwise>
													</c:choose>
												</div>

												<div class="d-flex gap-2 justify-content-center">
													<a href="footer_edit?parentId=${p.footer_id}"
														class="btn btn-icon  btn-light-primary btn-sm"> <i
														class="ki-duotone ki-pencil fs-5"> <span class="path1"></span>
															<span class="path2"></span>
													</i>
													</a>
													<button class="btn btn-icon btn-light-danger btn-sm"
														onclick="onDelete(${p.footer_id})"
														${not empty childList? 'disabled':'' }>
														<i class="ki-duotone ki-trash fs-5"> <span
															class="path1"></span><span class="path2"></span> <span
															class="path3"></span><span class="path4"></span> <span
															class="path5"></span>
														</i>
													</button>
												</div>
											</div>
										</th>
									</tr>
								</thead>

								<tbody>


									<tr>

										<td class="text-muted">
											<div class="px-4 d-flex flex-wrap align-items-center gap-5">
												<c:forEach var="c" items="${childList}">
													<span>${c.footer_name}</span>
												</c:forEach>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	const onDelete = (id) => {
		 Swal.fire({
	          title: 'Are you sure?',
	          text: "This footer will be deleted.",
	          icon: 'warning',
	          showCancelButton: true,
	          confirmButtonColor: '#3085d6',
	          cancelButtonColor: '#d33',
	          confirmButtonText: 'Yes, delete it!'
		 }).then((result) =>{
			 if(result.isConfirmed){
				 window.location.href = "footer_delete?footerId=" + id;
			 }
		 })
	}	
	
</script>
</body>
</html>