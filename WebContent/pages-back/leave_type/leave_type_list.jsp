<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Leave Type</title>

<!-- Metronic core -->
<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>

</head>
<body>
	<div class="app-main flex-column app-container container-xxl">
		<div class="page-title  py-3">
			<h1 class="page-heading text-gray-700 fw-semibold">Leave Type</h1>
			<ul
				class="list-unstyled d-inline-flex gap-2 text-muted fs-7 fw-medium">
				<li class="">Home</li>
				<li class="">-</li>
				<li class="">Master</li>
			</ul>
		</div>
		<div class="app-content">
			<div class="card">
				<div class="card-header pt-7 border-0">
					<h3 class="fw-semibold text-gray-900">Leave Type</h3>
					<a href="leave_type_add" class="btn btn-success btn-lg fw-medium">
						<i class="ki-duotone ki-plus fs-3"></i> Create
					</a>
				</div>
				<div class="card-body pb-0">
					<table class="table table-striped table-hover ">
						<thead class="text-gray-500 fw-bold fs-7">
							<tr>
								<th class="text-center">Leave Type ID</th>
								<th>Name</th>
								<th>Description</th>
								<th class="text-end">Action</th>
							</tr>
						</thead>
						<tbody>
							<s:iterator value="leaveTypeList">
								<tr class="border-bottom">
									<td class="fw-bold text-center align-middle fs-7"><s:property
											value="leaveTypeId" /></td>
									<td class="fs-6 fw-normal align-middle"><s:property
											value="leaveTypeName" /></td>
									<td class="fs-6 fw-normal align-middle"><s:property
											value="description" /></td>
									<td class="fs-6 fw-normal px-3">
										<div
											class="d-flex align-items-center justify-content-end gap-2">
											<a
												href="leave_type_edit?leaveTypeId=<s:property value='leaveTypeId'/>"
												class="btn btn-icon  btn-light-primary btn-sm"> <i
												class="ki-duotone ki-pencil fs-5"> <span class="path1"></span>
													<span class="path2"></span>
											</i>
											</a>
											<button class="btn btn-icon btn-light-danger btn-sm"
												onclick="onDelete('<s:property value="leaveTypeId" />')">
												<i class="ki-duotone ki-trash fs-5"> <span class="path1"></span><span
													class="path2"></span> <span class="path3"></span><span
													class="path4"></span> <span class="path5"></span>
												</i>
											</button>
										</div>
									</td>
								</tr>
							</s:iterator>
						</tbody>
					</table>


				</div>
				<div class="card-footer"></div>
			</div>

		</div>


	</div>
	<script type="text/javascript">
	const onDelete = (id) => {
		 Swal.fire({
	          title: 'Are you sure?',
	          text: "This leave type will be deleted.",
	          icon: 'warning',
	          showCancelButton: true,
	          confirmButtonColor: '#3085d6',
	          cancelButtonColor: '#d33',
	          confirmButtonText: 'Yes, delete it!'
		 }).then((result) =>{
			 if(result.isConfirmed){
				 window.location.href = "leave_type_delete?leaveTypeId=" + id;
			 }
		 })
	}
	
	</script>
</body>
</html>