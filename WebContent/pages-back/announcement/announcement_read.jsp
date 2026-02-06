<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<!DOCTYPE html>
<style>
.announcement-detail img {
	max-width: 100%;
	height: auto;
}
</style>
<div class="app-main flex-column flex-row-fluid">
	<fmt:setLocale value="en_US" />
	<div class="d-flex flex-column flex-column-fluid">
		<div class="app-toolbar align-items-stretch py-5 py-lg-6">
			<div class="app-container container-fluid d-flex flex-stack">
				<div
					class="d-flex align-items-center justify-content-between flex-lg-grow-1">
					<div class="d-flex align-items-center">
						<div
							class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
							<h1
								class="page-heading d-flex text-gray-700 fw-semibold fs-3 flex-column justify-content-center my-0">
								View Announcement</h1>
							<ul
								class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
								<!--begin::Item-->
								<li class="breadcrumb-item text-muted"><a
									href="demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
								<!--end::Item-->
								<!--begin::Item-->
								<li class="breadcrumb-item"><span
									class="bullet bg-gray-500 w-5px h-2px"></span></li>
								<!--end::Item-->
								<!--begin::Item-->
								<li class="breadcrumb-item text-muted">View Announcement</li>
								<!--end::Item-->
							</ul>
						</div>
					</div>
					<c:forEach var="ann" items="${announcement}">
						<perm:permission object="announcement.edit">
							<div class="d-flex align-items-center">
								<a
									class="btn btn-primary btn-flex h-40px border-0 fw-bold px-4 px-lg-6"
									href="announcementEdit?id=${ann.announcement_id}"> <i
									class="ki-duotone ki-pencil fs-2"> <span class="path1"></span>
										<span class="path2"></span>
								</i>&nbsp; Edit
								</a>
							</div>
						</perm:permission>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="app-content flex-column-fluid">
			<div class="app-container container-fluid">
				<div class="row g-5 gx-xl-10">
					<div class="col-md-12 col-lg-7 col-xl-7 col-xxl-8 mb-md-5 mb-xl-10">
						<div class="card card-flush py-3">
							<div class="card-header pt-5">
								<h3 class="card-title align-items-start flex-column">
									<span
										class="card-label fw-semibold text-gray-900 align-items-center"><c:forEach
											var="ann" items="${announcement}">
											<c:if test="${ann['highlight'] == '1'}">
												<span
													class="badge badge-light-danger me-3 justify-content-center align-items-center"
													style="width: 26px; height: 26px; padding: 0;"> <i
													class="ki-duotone ki-pin text-danger"
													style="font-size: 16px;"> <span class="path1"></span> <span
														class="path2"></span>
												</i>
												</span>
											</c:if>
											${ann['topic']}
										</c:forEach></span>
								</h3>
							</div>
							<div class="card-body mx-5 pt-10">
								<span class="card-label fw-medium fs-6 text-gray-800"><c:forEach
										var="ann" items="${announcement}">
										<div class="d-flex align-items-center gap-5 pb-5">
											<span
												class="d-flex align-items-center fw-medium text-gray-900">
												<i class="ki-duotone ki-calendar-2 fs-1 me-2"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span> <span class="path4"></span> <span
													class="path5"></span>
											</i> <fmt:formatDate value="${ann['announcement_date']}"
													pattern="dd MMM yyyy" />
											</span> <span
												class="d-flex align-items-center fw-medium text-gray-800">
												<i class="ki-duotone ki-eye fs-1 me-2"> <span
													class="path1"></span> <span class="path2"></span> <span
													class="path3"></span>
											</i> ${ann['readcount']} Views
											</span>
										</div>
										<%-- <!-- Picture -->
										<div class="d-flex align-items-center pb-5">
											<img src="${ann['path']}" alt="img" class="img-fluid rounded"
												style="max-width: 100%; height: auto;">
										</div> --%>
										<!-- Detail -->
										<div
											class="card mb-3 border-0 shadow-none text-gray-700 announcement-detail">
											<c:out value="${ann['detail']}" escapeXml="false" />
										</div>
									</c:forEach></span>
							</div>
						</div>
					</div>
					<div class="col-md-12 col-lg-5 col-xl-5 col-xxl-4 mb-md-5 mb-xl-10">
						<div class="card card-flush mb-5">
							<div class="card-body p-0">
								<c:forEach var="ann" items="${announcement}">
									<div class="w-100 rounded"
										style="height: 336px; 
            							background-image: url('${pageContext.request.contextPath}${empty ann.path ? '/assets/media/svg/avatars/blank.svg' : ann.path}'); 
            							background-size: cover; 
            							background-position: top;
            							background-repeat: no-repeat;">
									</div>
								</c:forEach>
							</div>
						</div>
						<div class="card card-flush py-3">
							<div class="card-header pt-5">
								<h3 class="card-title align-items-start flex-column">
									<span class="card-label fw-semibold text-gray-900">Attach
										Files</span>
								</h3>
							</div>

							<div class="card-body pt-6">
								<c:forEach var="ann" items="${announcement}">
									<c:forEach var="file" items="${announcementFiles}">
										<c:if test="${file['pageId'] == ann['announcement_id']}">

											<c:set var="rawExt" value="" />
											<c:forTokens items="${file['path']}" delims="." var="token">
												<c:set var="rawExt" value="${token}" />
											</c:forTokens>

											<c:set var="fileExt" value=".${fn:toLowerCase(rawExt)}" />

											<c:set var="fileIcon"
												value="assets/media/svg/files/folder-document.svg" />

											<c:choose>
												<c:when test="${fileExt == '.pdf'}">
													<c:set var="fileIcon"
														value="assets/media/svg/files/pdf.svg" />
												</c:when>
												<c:when test="${fileExt == '.doc' or fileExt == '.docx'}">
													<c:set var="fileIcon"
														value="assets/media/svg/files/doc.svg" />
												</c:when>
												<c:otherwise>
													<c:set var="fileIcon"
														value="assets/media/svg/files/folder-document.svg" />
												</c:otherwise>
											</c:choose>

											<div
												class="d-flex align-items-center justify-content-center mb-2">
												<div
													class="d-flex align-items-center justify-content-between w-100 p-2 rounded bg-hover-light">

													<a href="${file['path']}" target="_blank"
														class="d-flex align-items-center text-decoration-none text-gray-800 hover:text-primary"
														style="flex-grow: 1;"> <img src="${fileIcon}"
														class="w-25px h-25px me-3" alt="icon" /> <span
														class="text-gray-800 fs-6 fw-medium">
															${file['name']} <span class="ms-1">${fileExt}</span>
													</span>
													</a> <a href="${file['path']}" download="${file['name']}"
														class="ms-3" title="Download"> <i
														class="ki-duotone ki-file-down fs-1 text-primary"> <span
															class="path1"></span> <span class="path2"></span>
													</i>
													</a>

												</div>
											</div>

										</c:if>
									</c:forEach>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
				<div class="text-end">
					<a href="announcementList" class="btn btn-light fw-medium">Close</a>
				</div>
			</div>
		</div>
	</div>
</div>