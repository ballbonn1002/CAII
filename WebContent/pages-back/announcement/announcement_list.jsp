<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>
<!DOCTYPE html>
<style>
.image-box {
	width: 100%;
	height: 250px;
	position: relative;
	border-radius: 10px 10px 0 0;
	overflow: hidden;
}

.image-box img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	object-position: top;
	display: block;
}
</style>
<div class="app-main flex-column flex-row-fluid">
	<fmt:setLocale value="en_US" />
	<div class="d-flex flex-column flex-column-fluid">
		<div class="app-toolbar py-5 py-lg-6">
			<div class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-900 fw-semibold fs-3 flex-column justify-content-center my-0">
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
										autocomplete="off" action="javascript:void(0);"
										onsubmit="return false;">

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
						class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<div class="d-flex align-items-baseline">
							<h1 class="page-heading text-gray-900 fw-bold fs-3 my-0 me-2">
								${announcementList.size()} Items Found</h1>

							<c:set var="currentSort" value="${param.sortOrder}" />
							<c:if test="${empty currentSort}">
								<c:set var="currentSort" value="desc" />
							</c:if>

							<c:choose>
								<c:when test="${currentSort == 'asc'}">
									<c:set var="nextSort" value="desc" />
									<c:set var="label" value="by Oldest" />
									<c:set var="icon" value="ki-arrow-up" />
								</c:when>
								<c:otherwise>
									<c:set var="nextSort" value="asc" />
									<c:set var="label" value="by Recent Updates" />
									<c:set var="icon" value="ki-arrow-down" />
								</c:otherwise>
							</c:choose>

							<a href="javascript:;" onclick="toggleSort('${nextSort}')"
								class="text-gray-500 fs-6 fw-bold d-flex align-items-center">
								${label} <i class="ki-outline ${icon} fs-2 ms-1 text-gray-500">
							</i>
							</a>
						</div>
					</div>
					<!--end::Page title-->
					<!--begin::Actions-->
					<perm:permission object="announcement.edit">
						<div class="d-flex align-items-center gap-2 gap-lg-3">

							<!--begin::Primary button-->
							<a href="announcementAddPage"
								class="btn btn-success btn-flex h-40px border-0 fw-bold px-4 px-lg-6">
								<i class="ki-duotone ki-plus fs-1"> </i>Create
							</a>
							<!--end::Primary button-->
						</div>
					</perm:permission>
					<!--end::Actions-->
				</div>
			</div>
			<!-- Card -->
			<div class="app-container pb-10">
				<div class="row g-5 gx-xl-10" id="announcementListContainer">
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
													style="display: flex; justify-content: flex-end; gap: 6px; position: absolute; top: 20px !important; right: 20px; z-index: 2;">
													<c:if test="${ann.status == '0'}">
														<span class="badge fw-semibold text-dark"
															style="background-color: #FFC107; height: 26px;">Draft</span>
													</c:if>
													<c:if test="${ann.highlight == '1'}">
														<span
															class="badge badge-light-danger d-inline-flex justify-content-center align-items-center"
															style="width: 26px; height: 26px; padding: 0;"> <i
															class="ki-duotone ki-pin text-danger"
															style="font-size: 16px;"> <span class="path1"></span>
																<span class="path2"></span>
														</i>
														</span>
													</c:if>
													<c:if test="${announcementDateStr > todayStr}">
														<span class="badge fw-semibold text-white bg-warning"
															style="height: 26px;">Pending</span>
													</c:if>
													<c:if
														test="${ann.announcementId == islastest or ann.announcementId eq islastest}">
														<span
															class="badge fw-semibold bg-primary text-white bg-primary"
															style="height: 26px;">New</span>
													</c:if>
												</div>

												<!-- รูป -->
												<div class="image-box">
													<img alt="${ann.fileUpload.path}"
														src="${ann.fileUpload.path}" class="w-100 h-100"
														style="object-fit: cover; object-position: center;">
												</div>

												<!-- เนื้อหา -->
												<div class="card-body">
													<span class="fs-6 fw-bold text-gray-800 lh-base">${ann.topic}</span><br>

													<div class="d-flex align-items-center gap-3 mt-4">
														<!-- วันที่ -->
														<span
															class="d-flex align-items-center fs-6 fw-medium text-gray-800">
															<i class="ki-duotone ki-calendar-2 text-muted fs-1 me-2">
																<span class="path1"></span><span class="path2"></span><span
																class="path3"></span> <span class="path4"></span><span
																class="path5"></span>
														</i> <fmt:formatDate value="${ann.announcement_date}"
																pattern="dd MMM yyyy" />
														</span>

														<!-- จำนวนคนอ่าน -->
														<span
															class="d-flex align-items-center fs-6 fw-medium text-gray-800 ms-1">
															<i class="ki-duotone ki-eye fs-1 text-muted me-2"> <span
																class="path1"></span><span class="path2"></span><span
																class="path3"></span>
														</i> ${empty ann.readcount ? 0 : ann.readcount} Views
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
												style="display: flex; justify-content: flex-end; gap: 6px; position: absolute; top: 20px !important; right: 20px; z-index: 2;">
												<c:if
													test="${ann.announcementId == islastest or ann.announcementId eq islastest}">
													<span class="badge fw-semibold text-white bg-primary"
														style="height: 26px;">New</span>
												</c:if>
												<c:if test="${ann.highlight == '1'}">
													<span
														class="badge badge-light-danger d-inline-flex justify-content-center align-items-center"
														style="width: 26px; height: 26px; padding: 0;"> <i
														class="ki-duotone ki-pin text-danger"
														style="font-size: 16px;"> <span class="path1"></span>
															<span class="path2"></span>
													</i>
													</span>
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
												<span class="fs-6 fw-bold text-gray-800 lh-base">${ann.topic}</span><br>

												<div class="d-flex align-items-center gap-3 mt-4">
													<span
														class="d-flex align-items-center fs-6 fw-medium text-gray-800">
														<i class="ki-duotone ki-calendar-2 text-muted fs-1 me-2">
															<span class="path1"></span><span class="path2"></span><span
															class="path3"></span> <span class="path4"></span><span
															class="path5"></span>
													</i> <fmt:formatDate value="${ann.announcement_date}"
															pattern="dd MMM yyyy" />
													</span> <span
														class="d-flex align-items-center fs-6 fw-medium text-gray-800 ms-1">
														<i class="ki-duotone ki-eye fs-1 text-muted me-2"> <span
															class="path1"></span><span class="path2"></span><span
															class="path3"></span>
													</i> ${empty ann.readcount ? 0 : ann.readcount} Views
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
    var isAdmin = false;
    <perm:permission object="announcement.edit">
        isAdmin = true;
    </perm:permission>

    var start = moment().subtract(29, "days");
    var end = moment();
    var searchTimer;

    
    function cb(start, end) {
        $("#kt_daterangepicker_4").html(start.format("DD MMM YYYY") + " - " + end.format("DD MMM YYYY"));
    }

    function getEffectiveEndDate(pickerEndDate) {
        if (isAdmin) {
            return moment().add(30, 'days').format('YYYY-MM-DD');
        }
        return pickerEndDate.format('YYYY-MM-DD');
    }

    function reloadList() {
        var contextPath = "${pageContext.request.contextPath}"; 
        var keyword = $("#xxAnnouncement").val();

        var sortOrder = 'desc';
        var btnSort = $("a[onclick^='toggleSort']");
        if(btnSort.length > 0) {
            var btnOnclick = btnSort.attr("onclick");
            if (btnOnclick && btnOnclick.includes("'desc'")) {
                sortOrder = 'asc';
            }
        }

        var picker = $('#kt_daterangepicker_4').data('daterangepicker');
        if (!picker) return; 

        var startDate = picker.startDate.format('YYYY-MM-DD');
        var endDate = getEffectiveEndDate(picker.endDate);

        var url = contextPath + "/announcementList?mode=ajax"
                + "&xxAnnouncement=" + encodeURIComponent(keyword)
                + "&sortOrder=" + sortOrder 
                + "&startDate=" + startDate
                + "&endDate=" + endDate;

        $("#announcementListContainer").load(url + " #announcementListContainer > *", function() {
        });
    }

    function toggleSort(nextSortOrder) {
        var contextPath = "${pageContext.request.contextPath}";
        var keyword = $("#xxAnnouncement").val();
        var picker = $('#kt_daterangepicker_4').data('daterangepicker');
        var endDate = getEffectiveEndDate(picker.endDate);

        var url = contextPath + "/announcementList?mode=ajax" 
                + "&sortOrder=" + nextSortOrder 
                + "&xxAnnouncement=" + encodeURIComponent(keyword) 
                + "&startDate=" + picker.startDate.format('YYYY-MM-DD') 
                + "&endDate=" + endDate;

        $("#announcementListContainer").load(url + " #announcementListContainer > *", function(response, status, xhr) {
            if (status == "error") {
                console.error("Load Error:", xhr.statusText);
            }

            var nextOrderForBtn = (nextSortOrder === 'asc') ? 'desc' : 'asc';
            var currentLabel = (nextSortOrder === 'asc') ? 'by Oldest' : 'by Recent Updates';
            var currentIcon = (nextSortOrder === 'asc') ? 'ki-arrow-up' : 'ki-arrow-down';

            var btnHtml = currentLabel + ' <i class="ki-outline ' + currentIcon + ' fs-2 ms-1 text-gray-500"></i>';

            $("a[onclick^='toggleSort']")
                .attr("onclick", "toggleSort('" + nextOrderForBtn + "')")
                .html(btnHtml);
        });
    }

    $(document).ready(function() {
        console.log("✅ DOM Ready: เริ่มต้นการทำงานของ Script");

        // 3.1 เริ่มต้น DatePicker
        $("#kt_daterangepicker_4").daterangepicker({
            startDate : start,
            endDate : end,
            locale : { format : 'DD MMM YYYY' },
            ranges : {
                'Today' : [ moment(), moment() ],
                'Yesterday' : [ moment().subtract(1, 'days'), moment().subtract(1, 'days') ],
                'Last 7 Days' : [ moment().subtract(6, 'days'), moment() ],
                'Last 30 Days' : [ moment().subtract(29, 'days'), moment() ],
                'This Month' : [ moment().startOf('month'), moment().endOf('month') ],
                'Last Month' : [ moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month') ]
            }
        }, cb);

        cb(start, end);

        $("#kt_daterangepicker_4").on('apply.daterangepicker', function(ev, picker) {
            reloadList();
        });

        $("#xxAnnouncement").on('keyup', function() {
            clearTimeout(searchTimer);
            searchTimer = setTimeout(function() {
                reloadList();
            }, 500);
        });

        reloadList();
    });
</script>