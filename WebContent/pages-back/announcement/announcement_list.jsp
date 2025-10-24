<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<!DOCTYPE html>
<style>
.image-box {
	width: 100%;
	padding-top: 100%;
	position: relative;
	border-radius: 10px;
	overflow: hidden;
	margin-bottom: 20px;
}

.image-box img {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	object-fit: contain;
	background-color: white;
}
</style>
<div class="app-main flex-column flex-row-fluid">
	<div class="d-flex flex-column flex-column-fluid">
		<div class="app-toolbar py-5 py-lg-6">
			<div class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">
						Announcement</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="demo_dashboard" class="text-muted text-hover-primary">Home</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="app-content flex-column-fluid">
			<div class="app-container container-fluid">
				<!-- Search -->
				<div class="d-flex flex-row pb-10">
					<div class="card flex-row-fluid py-3">
						<div
							class="card-header d-flex align-items-center justify-content-between"
							style="border-bottom: none;">
							<div class="col-md-9">
								<div id="kt_docs_search_handler_responsive"
									class="d-flex align-items-center w-100"
									data-kt-search-keypress="true" data-kt-search-min-length="1"
									data-kt-search-enter="enter" data-kt-search-layout="menu"
									data-kt-search-responsive="lg" data-kt-menu-trigger="auto"
									data-kt-menu-permanent="true"
									data-kt-menu-placement="bottom-start">

									<!--begin::Form-->
									<form id="userCalendarForm"
										class="d-none d-lg-block w-100 position-relative mb-5 mb-lg-0 me-5"
										autocomplete="off" action="testt" method="post">

										<!--begin::Icon-->
										<i
											class="ki-duotone ki-magnifier fs-2 fs-lg-1 text-gray-500 position-absolute top-50 translate-middle-y ms-5">
											<span class="path1"></span> <span class="path2"></span>
										</i>
										<!--end::Icon-->

										<!--begin::Input-->
										<input type="text" class="form-control form-solid ps-14"
											name="xxAnnouncement" id="xxAnnouncement"
											placeholder="search" data-kt-search-element="input" />
										<!--end::Input-->

									</form>
									<!--end::Form-->

									<!--begin::Menu-->
									<div data-kt-search-element="content"
										class="menu menu-sub menu-sub-dropdown w-50 py-7 px-7">

										<!--begin::Wrapper-->
										<div data-kt-search-element="wrapper">
											<!--begin::Results-->
											<div data-kt-search-element="results" id="testt"
												style="max-height: 400px; overflow-y: auto; overflow-x: hidden;">
											</div>
											<!--end::Results-->

											<!--begin::Empty search-->
											<div data-kt-search-element="empty"
												class="text-center d-none">
												<span class="text-muted">testt</span>
											</div>
											<!--end::Empty search-->
										</div>
										<!--end::Wrapper-->
									</div>
									<!--end::Menu-->
								</div>
							</div>
							<div class="col-md-3 position-relative">
								<i
									class="ki-duotone ki-calendar-8 fs-2 text-gray-500 position-absolute top-50 translate-middle-y ms-5">
									<span class="path1"></span> <span class="path2"></span> <span
									class="path3"></span> <span class="path4"></span> <span
									class="path5"></span> <span class="path6"></span>
								</i> <input type="text" class="form-control form-control ps-14"
									placeholder="Pick date range" id="kt_daterangepicker_4" />
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Item Found & Create -->
			<div class="d-flex flex-row pb-10">
				<div id="kt_app_toolbar_container"
					class="app-container container-fluid d-flex flex-stack ">

					<!--begin::Page title-->
					<div
						class="page-title d-flex flex-column justify-content-center flex-wrap me-3 ">
						<!--begin::Title-->
						<h1
							class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">
							${announcementList.size()} Items Found</h1>
						<!--end::Title-->
					</div>
					<!--end::Page title-->
					<!--begin::Actions-->
					<perm:permission object="announcement.edit">
						<div class="d-flex align-items-center gap-2 gap-lg-3">

							<!--begin::Primary button-->
							<a href="announcementAddPage"
								class="btn btn-sm fw-bold btn-success"> <i
								class="ki-duotone ki-plus"> </i>Create
							</a>
							<!--end::Primary button-->
						</div>
					</perm:permission>
					<!--end::Actions-->
				</div>
			</div>
			<!-- Card -->
			<div class="app-container pb-10">
				<div class="row g-5 gx-xl-10">
					<!-- วันที่ปัจจุบัน -->
					<jsp:useBean id="now" class="java.util.Date" />
					<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="todayStr" />

					<!-- ถ้ามีประกาศ -->
					<c:if test="${not empty announcementList}">
						<c:forEach var="ann" items="${announcementList}">
							<!-- แปลงวันประกาศเป็น String -->
							<fmt:formatDate value="${ann.announcement_date}"
								pattern="yyyy-MM-dd" var="announcementDateStr" />

							<c:choose>
								<c:when
									test="${ann.status == '0' or announcementDateStr > todayStr}">
									<perm:permission object="announcement.view">
										<!-- Card แบบไม่มี permission -->
										<div class="col-lg-4 col-md-12 col-12 mb-5 mb-xl-10">
											<div
												class="card hover-elevate-up shadow-sm parent-hover position-relative"
												style="cursor: pointer;"
												onclick="window.location.href='announcementRead?id=${ann.announcementId}'">

												<!-- Badge -->
												<div
													style="display: flex; justify-content: flex-end; gap: 6px; position: absolute; top: 10px; right: 10px; z-index: 2;">
													<c:if test="${ann.status == '0'}">
														<span class="badge fw-semibold text-dark"
															style="background-color: #FFC107;">Draft</span>
													</c:if>
													<c:if test="${announcementDateStr > todayStr}">
														<span class="badge fw-semibold text-white"
															style="background-color: #F1C40F;">Pending</span>
													</c:if>
													<c:if
														test="${ann.announcementId == islastest or ann.announcementId eq islastest}">
														<span class="badge fw-semibold text-white"
															style="background-color: #007BFF;">New</span>
													</c:if>
												</div>

												<!-- รูป -->
												<div class="card-header p-0">
													<div class="image-box">
														<img alt="${ann.fileUpload.path}"
															src="${ann.fileUpload.path}">
													</div>
												</div>

												<!-- เนื้อหา -->
												<div class="card-body">
													<span class="fs-6 fw-bold">${ann.topic}</span><br>

													<div class="d-flex align-items-center gap-3 mt-2">
														<!-- วันที่ -->
														<span class="d-flex align-items-center fs-6 fw-medium">
															<i class="ki-duotone ki-calendar-2 fs-2 me-1"> <span
																class="path1"></span><span class="path2"></span><span
																class="path3"></span> <span class="path4"></span><span
																class="path5"></span>
														</i> <fmt:formatDate value="${ann.announcement_date}"
																pattern="dd MMM yyyy" />
														</span>

														<!-- จำนวนคนอ่าน -->
														<span class="d-flex align-items-center fs-6 fw-medium">
															<i class="ki-duotone ki-eye fs-2 me-1"> <span
																class="path1"></span><span class="path2"></span><span
																class="path3"></span>
														</i> ${empty ann.readcount ? 0 : ann.readcount}
														</span>
													</div>
												</div>
											</div>
										</div>
									</perm:permission>
								</c:when>

								<c:otherwise>
									<div class="col-lg-4 col-md-12 col-12 mb-5 mb-xl-10">
										<div
											class="card hover-elevate-up shadow-sm parent-hover position-relative"
											style="cursor: pointer;"
											onclick="window.location.href='announcementRead?id=${ann.announcementId}'">

											<!-- Badge -->
											<div
												style="display: flex; justify-content: flex-end; gap: 6px; position: absolute; top: 10px; right: 10px; z-index: 2;">
												<c:if
													test="${ann.announcementId == islastest or ann.announcementId eq islastest}">
													<span class="badge fw-semibold text-white"
														style="background-color: #007BFF;">New</span>
												</c:if>
											</div>

											<!-- รูป -->
											<div class="card-header p-0">
												<div class="image-box">
													<img alt="${ann.fileUpload.path}"
														src="${ann.fileUpload.path}">
												</div>
											</div>

											<!-- เนื้อหา -->
											<div class="card-body">
												<span class="fs-6 fw-bold">${ann.topic}</span><br>

												<div class="d-flex align-items-center gap-3 mt-2">
													<span class="d-flex align-items-center fs-6 fw-medium">
														<i class="ki-duotone ki-calendar-2 fs-2 me-1"> <span
															class="path1"></span><span class="path2"></span><span
															class="path3"></span> <span class="path4"></span><span
															class="path5"></span>
													</i> <fmt:formatDate value="${ann.announcement_date}"
															pattern="dd MMM yyyy" />
													</span> <span class="d-flex align-items-center fs-6 fw-medium">
														<i class="ki-duotone ki-eye fs-2 me-1"> <span
															class="path1"></span><span class="path2"></span><span
															class="path3"></span>
													</i> ${empty ann.readcount ? 0 : ann.readcount}
													</span>
												</div>
											</div>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	var start = moment().subtract(29, "days");
	var end = moment();

	function cb(start, end) {
		$("#kt_daterangepicker_4").html(
				start.format("DD MMM YYYY") + " - "
						+ end.format("DD MMM YYYY"));
	}

	$("#kt_daterangepicker_4")
			.daterangepicker(
					{
						startDate : start,
						endDate : end,
						locale: {
				            format: 'DD MMM YYYY'
				        },
						ranges : {
							"Today" : [ moment(), moment() ],
							"Yesterday" : [ moment().subtract(1, "days"),
									moment().subtract(1, "days") ],
							"Last 7 Days" : [ moment().subtract(6, "days"),
									moment() ],
							"Last 30 Days" : [ moment().subtract(29, "days"),
									moment() ],
							"This Month" : [ moment().startOf("month"),
									moment().endOf("month") ],
							"Last Month" : [
									moment().subtract(1, "month").startOf(
											"month"),
									moment().subtract(1, "month")
											.endOf("month") ]
						}
					}, cb);

	cb(start, end);
</script>