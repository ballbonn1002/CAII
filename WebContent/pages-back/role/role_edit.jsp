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
					<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">Create a leave form</h1>
					<!--end::Title-->
					<!--begin::Breadcrumb-->
					<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a href="demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
					</ul>
					<!--end::Breadcrumb-->
				</div>
				<!--end::Page title-->
			</div>
			<!--end::Toolbar container-->
		</div>
		<!--end::Toolbar-->

		<!--begin::Content-->
		<div id="kt_app_content" class="app-content flex-column-fluid">

			<!--begin::Content container-->
			<div id="kt_app_content_container" class="app-container container-fluid">

				<form action="role-perform-edit" class="form-horizontal" method="post" autocomplete="off">

					<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -->
					<div class="d-flex flex-row">
						<div class="flex-row-fluid mb-5">
							<div class="card card-flush h-md-100">
								<!--Header -->
								<div class="card-header pt-7">
									<div class="card-title">
										<h3 class="mb-0">Role</h3>
									</div>
								</div>
								<!--Header -->
								<div class="card-body">
									<div class="row g-5 mb-5">

										<!-- Role ID -->
										<div class="col-md-6">
											<label for="roleId" class="form-label fw-semibold">Role ID <span class="text-danger">*</span>
											</label>
											<div class="form-icon-left">
												<input type="text" class="form-control" placeholder="Role ID" maxlength="32" name="role.id" value="${role.id}" required>
												<input type="hidden" name="roleId" value="${role.id}" required>
											</div>
										</div>
										<!-- Role ID -->

										<!-- Role Name -->
										<div class="col-md-6">
											<label for="roleName" class="form-label fw-semibold">Name <span class="text-danger">*</span>
											</label>
											<div class="form-icon-left">
												<input type="text" class="form-control" placeholder="Role Name" maxlength="64" name="role.name" value="${role.name}" required>
											</div>
										</div>
									</div>
									<!-- Role Name -->

									<!-- Description -->
									<div class="mb-5">
										<label for="description" class="form-label fw-semibold">Description</label> <input type="text" class="form-control"
											placeholder="Description" maxlength="200" name="role.description" value="${role.description}" required>
									</div>
								</div>
								<!-- Description -->

								<!--Buttons -->
								<div class="card-footer pt-0">
									<div class="d-flex justify-content-end gap-3">
										<button type="button" class="btn btn-light d-inline-flex align-items-center justify-content-center"
											onclick="window.location.href='role-list'">Cancel</button>
										<button type="submit" class="btn btn-success" id="btnSave">Save</button>
									</div>
								</div>
								<!--Buttons -->

							</div>
							<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -->
						</div>
						<!--end::Content container-->
					</div>
					<!--end::Content-->
					<!--end::Content wrapper-->

					<!-- Permission Management -->
					<div class="d-flex flex-wrap flex-stack pb-7">
						<!--begin::Title-->
						<div class="d-flex flex-wrap align-items-center my-1">
							<h3 class="fw-bold me-5 my-1">Permission Management</h3>
						</div>
						<!--end::Title-->
					</div>
					<!-- Permission Management -->

					<!--end:::Main-->






					<div class="d-flex flex-row">
						<div class="flex-row-fluid mb-5">

							<c:forEach var="group" items="${aoList}">
								<div class="card card-flush mb-5 mb-xl-10 shadow-sm">

									<div class="card-header fs-4">
										<div class="d-flex align-items-center mb-2 gap-2">
											<h4 class="mb-0 me-3">${group.description}</h4>
										</div>

										<div class="card-toolbar">
											<div class="d-inline-flex align-items-center justify-content-end gap-2">
												<div class="fs-5">id : ${group.authorizedObjectGroupId != null ? group.authorizedObjectGroupId : '-'}</div>
											</div>
										</div>
									</div>
									<div class="card-body pt-0">
										<div class="table-responsive">
											<table class="table align-middle table-row-dashed fs-6 gy-5">
												<tbody>

													<c:forEach var="obj" items="${group.objects}" varStatus="loop">
														<tr class="fs-5">
															<td class="min-w-200px">${obj.authorizedObjectId}</td>

															<td>
																<label class="form-check-label cursor-pointer" for="checkbox_${group.authorizedObjectGroupId}_${loop.count}">
																	${obj.name}
																</label>
															</td>
															<td>
																<label class="form-check-label cursor-pointer" for="checkbox_${group.authorizedObjectGroupId}_${loop.count}">
																	${obj.description}
																</label>
															</td>

															<td class="text-end">
																<div class="form-check form-check-custom form-check-solid justify-content-end">

																	<c:set var="isChecked" value="" />
																	<c:forEach var="rao" items="${raoList}">
																		<c:if test="${obj.authorizedObjectId eq rao.authorizedObjectId}">
																			<c:set var="isChecked" value="checked" />
																		</c:if>
																	</c:forEach>

																	<input class="form-check-input" type="checkbox" name="authId" id="checkbox_${group.authorizedObjectGroupId}_${loop.count}"
																		value="${obj.authorizedObjectId}" ${isChecked} />
																</div>
															</td>
														</tr>
													</c:forEach>

													<c:if test="${empty group.objects}">
														<tr>
															<td colspan="3" class="text-center text-muted">ไม่พบข้อมูลสิทธิ์ในกลุ่มนี้</td>
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
		</div>
	</div>
</div>
