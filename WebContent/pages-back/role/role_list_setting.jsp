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
					<h1 class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">Role Setting</h1>
					<!--end::Title-->
					<!--begin::Breadcrumb-->
					<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a href="demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Authority</li>
						<li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted">Role / Permission</li>
					</ul>
					<!--end::Breadcrumb-->
				</div>
				
				
					<!--begin::Controls-->
					<div class="d-flex flex-wrap my-1">
						<a href="javascript:void(0)" class="btn btn-success btn-lg" onclick="add()">
							<i class="ki-duotone ki-plus"></i>
							Create Group
						</a>
					</div>
					<!--end::Controls-->
				
				
				<!--end::Page title-->
			</div>
			<!--end::Toolbar container-->
		</div>
		<!--end::Toolbar-->

		<!--begin::Content-->
		<div id="kt_app_content" class="app-content flex-column-fluid">

			<!--begin::Content container-->
			<div id="kt_app_content_container" class="app-container container-fluid">

				<form action="role-perform-add" class="form-horizontal" method="post" autocomplete="off">

					<div class="d-flex flex-row">
						<div class="flex-row-fluid mb-5">

							<c:forEach var="group" items="${aoList}">
								<div class="card card-flush mb-5 mb-xl-10 shadow-sm">

									<%-- <div class="card-header fs-4">
										<div class="d-flex align-items-center mb-2 gap-2">
											<h4 class="mb-0 me-3">${group.description}</h4>
										</div>

										<div class="card-toolbar">
											<div class="d-inline-flex align-items-center justify-content-end gap-2">
												<div class="fs-5">id : ${group.authorizedObjectGroupId != null ? group.authorizedObjectGroupId : '-'}</div>
											</div>
										</div>
									</div> --%>
									
									<div class="card-body pt-0">
										<div class="table-responsive">
											<table class="table align-middle table-row-dashed fs-6 gy-5" style="table-layout: fixed; width: 100%;">
											
												<thead>
													<tr>
														<th>id : ${group.authorizedObjectGroupId != null ? group.authorizedObjectGroupId : '-'}</th>
														<th class="fw-bold fs-3">${group.description}</th>
														<th></th>
														<th class="text-end">
														    <div class="d-flex justify-content-end gap-2">
															<!-- Edit -->
															<button type="button" class="btn btn-icon btn-sm btn-light-primary" aria-label="Edit"
																onclick="window.location.href='role-edit?roleId=${role.id}'">
																<i class="ki-duotone ki-pencil fs-5">
																	<span class="path1"></span>
																	<span class="path2"></span>
																</i>
															</button>
															
															
															
															
<c:choose>
    <c:when test="${empty group.objects}">
        <button type="button" class="btn btn-icon btn-sm btn-light-danger btn-delete-role" 
                data-id="${role.id}" data-bs-toggle="modal" data-bs-target="#modal_delete_role">
            <i class="ki-duotone ki-trash fs-5">
                <span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>
            </i>
        </button>
    </c:when>
    <c:otherwise>
        <button type="button" class="btn btn-icon btn-sm btn-bg-light btn-color-gray-400 btn-delete-role" 
                data-id="${role.id}" data-bs-toggle="modal" data-bs-target="#modal_delete_role">
            <i class="ki-duotone ki-trash fs-5">
                <span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span>
            </i>
        </button>
    </c:otherwise>
</c:choose>															
															
															
															
		
															<!-- Delete -->
															<%-- <button type="button" class="btn btn-icon btn-sm btn-light-danger btn-delete-role" data-id="${role.id}" data-bs-toggle="modal"
																data-bs-target="#modal_delete_role" aria-label="Delete">
																<i class="ki-duotone ki-trash fs-5">
																	<span class="path1"></span>
																	<span class="path2"></span>
																	<span class="path3"></span>
																	<span class="path4"></span>
																	<span class="path5"></span>
																</i>
															</button> --%>
															
															<!-- Delete -->
															<%-- <button type="button" class="btn btn-icon btn-sm btn-bg-light btn-color-gray-400 btn-delete-role" data-id="${role.id}" data-bs-toggle="modal"
																data-bs-target="#modal_delete_role" aria-label="Delete">
																<i class="ki-duotone ki-trash fs-5">
																	<span class="path1"></span>
																	<span class="path2"></span>
																	<span class="path3"></span>
																	<span class="path4"></span>
																	<span class="path5"></span>
																</i>
															</button> --%>
															
														    </div>
														</th>
													</tr>
												</thead>
											
												<tbody>

													<c:forEach var="obj" items="${group.objects}" varStatus="loop">
														<tr class="fs-5">

															<td style="width: 30%;" class="text-truncate">${obj.authorizedObjectId}</td>

															<td style="width: 30%;" class="text-truncate">
																<label for="checkbox_${group.authorizedObjectGroupId}_${loop.count}">
																	${obj.name}
																</label>
															</td>

															<td style="width: 30%;" class="text-truncate">
																<label for="checkbox_${group.authorizedObjectGroupId}_${loop.count}">
																	${obj.description}
																</label>
															</td>

															<td style="width: 10%;" class="text-end">
																<%-- <div class="form-check form-check-custom form-check-solid justify-content-end">


																	<c:set var="isChecked" value="" />
																	<c:forEach var="rao" items="${raoList}">
																		<c:if test="${obj.authorizedObjectId eq rao.authorizedObjectId}">
																			<c:set var="isChecked" value="checked" />
																		</c:if>
																	</c:forEach>

																	<input class="form-check-input" type="checkbox" name="authId" id="checkbox_${group.authorizedObjectGroupId}_${loop.count}" value="${obj.authorizedObjectId}" ${isChecked} />
																</div> --%>
																
																
															<!-- Edit -->
															<button type="button" class="btn btn-icon btn-sm btn-light-primary" aria-label="Edit"
																onclick="window.location.href='role-edit?roleId=${role.id}'">
																<i class="ki-duotone ki-pencil fs-5">
																	<span class="path1"></span>
																	<span class="path2"></span>
																</i>
															</button>
																
																
																
															</td>
														</tr>
													</c:forEach>

													<c:if test="${empty group.objects}">
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
							</c:forEach>

						</div>
					</div>

				</form>

			</div>
			<!--end::Content wrapper-->

		</div>
		<!--end::Content-->

	</div>
	<!--begin::Content wrapper-->

</div>
<!--begin::Main-->
