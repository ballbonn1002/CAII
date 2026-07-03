<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet"
	type="text/css" />
<script src="assets/plugins/global/plugins.bundle.js"></script>

<!--CKEditor-->
<script src="assets/plugins/custom/ckeditor/ckeditor-decoupled.bundle.js"></script>
<script src="assets/plugins/custom/ckeditor/ckeditor-document.bundle.js"></script>

<style>
/* Custom Tooltip for Read By */
.read-by-tooltip .tooltip-inner {
    background-color: var(--bs-primary) !important;
    color: #ffffff !important;
    font-weight: 500;
    padding: 8px 12px;
}
.read-by-tooltip.bs-tooltip-auto[data-popper-placement^=top] .tooltip-arrow::before,
.read-by-tooltip.bs-tooltip-top .tooltip-arrow::before {
    border-top-color: var(--bs-primary) !important;
}
.read-by-tooltip.bs-tooltip-auto[data-popper-placement^=bottom] .tooltip-arrow::before,
.read-by-tooltip.bs-tooltip-bottom .tooltip-arrow::before {
    border-bottom-color: var(--bs-primary) !important;
}

.announcement-detail {
    word-break: break-word;
    overflow-wrap: break-word;
}

.announcement-detail img {
    max-width: 100% !important;
    height: auto !important;
}

.announcement-detail table {
    width: 100% !important;
    display: block;
    overflow-x: auto;
}

.announcement-detail iframe {
    max-width: 100% !important;
}

.announcement-detail * {
    max-width: 100%;
}
</style>

</head>
<body>
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
										
										<!-- Detail -->
										<div
											class="ck-content card mb-3 border-0 shadow-none text-gray-700 announcement-detail">
											<c:out value="${ann.detail}" escapeXml="false" />
										</div>
										
									</c:forEach></span>
							</div>
						</div>

						<!-- Read By Section Card -->
						<perm:permission object="announcement.read">
							<div class="card card-flush py-3 mt-5">
								<div class="card-body mx-5 py-5">
									<div class="d-flex align-items-center justify-content-between mb-6">
										<h3 class="fs-4 fw-bold text-gray-800 m-0">Read By</h3>
										<span class="fs-5 fw-bold text-primary" id="readByCount">0</span>
									</div>
									<div class="d-flex flex-wrap gap-3" id="readByContainer">
										<!-- Badges will be generated by JS -->
									</div>
								</div>
							</div>
						</perm:permission>

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
						<c:set var="hasFile" value="false" />

							<c:forEach var="ann" items="${announcement}">
							    <c:forEach var="file" items="${announcementFiles}">
							        <c:if test="${file['pageId'] == ann['announcement_id']}">
							            <c:set var="hasFile" value="true" />
							        </c:if>
							    </c:forEach>
							</c:forEach>
						<c:if test="${hasFile}">
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
						</div></c:if>
					</div>
				</div>
				<div class="text-end">
					<a href="announcementList" class="btn btn-light fw-medium">Close</a>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function() {
    // Mock/Real User Mapping
    var userMap = {
        <c:forEach var="entry" items="${userMap}">
            "${entry.key}": "${entry.value}",
        </c:forEach>
    };

    // Parse JSON
    var readByData = [];
    <c:forEach var="ann" items="${announcement}">
        var jsonStr = '${ann["viewer_logs"]}'; // Backend field that stores the JSON Array
        try {
            if(jsonStr && jsonStr.trim() !== '') {
                var parsedArray = JSON.parse(jsonStr);
                if (Array.isArray(parsedArray)) {
                    parsedArray.forEach(function(item) {
                        readByData.push({
                            "user_id": item.user_id,
                            "time": item.read_time || ""
                        });
                    });
                }
            }
        } catch(e) {
            console.error("Error parsing viewer_logs JSON", e);
        }
    </c:forEach>

    $("#readByCount").text(readByData.length);
    var container = $("#readByContainer");
    
    readByData.forEach(function(item) {
        var nameEn = userMap[item.user_id] || item.user_id;
        var displayTime = item.time;
        if(moment(item.time, moment.ISO_8601, true).isValid()) {
            displayTime = moment(item.time).format('D MMM YYYY, H:mm');
        } else if (item.time && moment(new Date(item.time)).isValid()) {
            displayTime = moment(new Date(item.time)).format('D MMM YYYY, H:mm');
        }

        var badge = $('<div class="badge badge-light text-gray-800 fw-bold fs-6 px-4 py-3 cursor-pointer" ' +
                      'data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-custom-class="read-by-tooltip" title="Read on: ' + displayTime + '">' + 
                      nameEn + '</div>');
        container.append(badge);
    });

    // Initialize tooltips for the new elements
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});
</script>

</body>
</html>