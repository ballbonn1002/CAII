<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>

<style>
.report-card-img {
	display: flex;
	align-items: center;
	justify-content: center;
	min-height: 175px;
}

.btn-active-primary, .btn-active-warning, .btn-active-success, .btn-active-danger {
	border: 1px solid rgba(0, 0, 0, 0.1) !important;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
}

[data-bs-theme="dark"] .btn-active-primary, [data-bs-theme="dark"] .btn-active-warning,
	[data-bs-theme="dark"] .btn-active-success, [data-bs-theme="dark"] .btn-active-danger {
	border: 1px solid rgba(255, 255, 255, 0.1) !important;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}
</style>

<perm:permission object="report.view">
<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">

		<%-- Toolbar / Breadcrumb --%>
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h2
						class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
						Report</h2>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted">Home</li>
					</ul>
				</div>
			</div>
		</div>
		<%-- End Toolbar --%>

		<div id="kt_app_content_container"
			class="app-container container-fluid">

			<div class="row g-6 g-xl-9">

				<%-- Card: Work Log --%>
				<div class="col-md-4">
					<a href="${pageContext.request.contextPath}/work_log"
						class="text-decoration-none">
						<div
							class="btn bg-body btn-active-primary w-100 h-100 d-flex flex-column align-items-center justify-content-center py-12 rounded-3">
							<span class="fw-semibold fs-1 mb-3 text-gray-800">Work Log</span>
							<div class="report-card-img">
								<img
									src="${pageContext.request.contextPath}/assets/media/svg/illustrations/easy/workLog.svg"
									onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
									class="mh-175px" alt="Work Log" />
								<div
									style="display: none; align-items: center; justify-content: center; min-height: 175px;">
									<i class="ki-duotone ki-chart-line-up fs-5tx text-primary">
										<span class="path1"></span><span class="path2"></span>
									</i>
								</div>
							</div>
						</div>
					</a>
				</div>
				<%-- End Card: Work Log --%>

				<%-- Card: Daily Monitor --%>
				<div class="col-md-4">
					<a href="${pageContext.request.contextPath}/dailyMonitor"
						class="text-decoration-none">
						<div
							class="btn bg-body btn-active-warning w-100 h-100 d-flex flex-column align-items-center justify-content-center py-12 rounded-3">
							<span class="fw-semibold fs-1 mb-3 text-gray-800">Daily
								Monitor</span>
							<div class="report-card-img">
								<img
									src="${pageContext.request.contextPath}/assets/media/svg/illustrations/easy/dailyMonitor.svg"
									onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
									class="mh-175px" alt="Daily Monitor" />
								<div
									style="display: none; align-items: center; justify-content: center; min-height: 175px;">
									<i class="ki-duotone ki-monitor-mobile fs-5tx text-warning">
										<span class="path1"></span><span class="path2"></span>
									</i>
								</div>
							</div>
						</div>
					</a>
				</div>
				<%-- End Card: Daily Monitor --%>

				<%-- Card: Summary Working Day --%>
				<div class="col-md-4">
					<a href="${pageContext.request.contextPath}/report_listWorking"
						class="text-decoration-none">
						<div
							class="btn bg-body btn-active-success w-100 h-100 d-flex flex-column align-items-center justify-content-center py-12 rounded-3">
							<span class="fw-semibold fs-1 mb-3 text-gray-800">Summary
								Working Day</span>
							<div class="report-card-img">
								<img
									src="${pageContext.request.contextPath}/assets/media/svg/illustrations/easy/summaryWorkDay.svg"
									onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
									class="mh-175px" alt="Summary Working Day" />
								<div
									style="display: none; align-items: center; justify-content: center; min-height: 175px;">
									<i class="ki-duotone ki-calendar-2 fs-5tx text-success"> <span
										class="path1"></span><span class="path2"></span> <span
										class="path3"></span><span class="path4"></span>
									</i>
								</div>
							</div>
						</div>
					</a>
				</div>
				<%-- End Card: Summary Working Day --%>

				<%-- Card: Action Log --%>
				<div class="col-md-4">
					<a href="${pageContext.request.contextPath}/action_log"
						class="text-decoration-none">
						<div
							class="btn bg-body btn-active-danger w-100 h-100 d-flex flex-column align-items-center justify-content-center py-12 rounded-3">
							<span class="fw-semibold fs-1 mb-3 text-gray-800">Action Log</span>
							<div class="report-card-img">
								<img
									src="${pageContext.request.contextPath}/assets/media/svg/illustrations/easy/actionLog.svg"
									onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
									class="mh-175px" alt="Action Log" />
								<div
									style="display: none; align-items: center; justify-content: center; min-height: 175px;">
									<i class="ki-duotone ki-abstract-26 fs-5tx text-danger">
										<span class="path1"></span><span class="path2"></span>
									</i>
								</div>
							</div>
						</div>
					</a>
				</div>
				<%-- End Card: Action Log --%>
				
				<div class="col-md-4">
					<a href="${pageContext.request.contextPath}/work_location"
						class="text-decoration-none">
						<div class="btn bg-body btn-active-info w-100 h-100 d-flex flex-column align-items-center justify-content-center py-12 rounded-3">
							<span class="fw-semibold fs-1 mb-3 text-gray-800">Work Location</span>
							<div class="report-card-img">
								<%-- <img
									src="${pageContext.request.contextPath}/assets/media/svg/illustrations/easy/workLocation.svg"
									onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
									class="mh-175px" alt="Action Log" /> --%>
								<div
									style="display: none; align-items: center; justify-content: center; min-height: 175px;">
									<i class="ki-duotone ki-abstract-26 fs-5tx text-danger">
										<span class="path1"></span><span class="path2"></span>
									</i>
								</div>
							</div>
						</div>
					</a>
				</div>

			</div>
			<%-- End Row --%>

		</div>
		<%-- End Content Container --%>

	</div>
</div>
</perm:permission>