<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<fmt:setLocale value="en_US" />

<%-- =====================================================================
     NEW: LINE LIFF — รายละเอียดใบรวม (Waiting / Approved / Paid / Cancel / Reject)
     ค่าจาก TravelAction.submitTravelPreview() เหมือนหน้า desktop my_travel_submit.jsp
     ===================================================================== --%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="liff-shell pb-10">

	<div id="liffLoadingOverlay" class="liff-loading-overlay liff-loading-delayed">
		<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>
	</div>

	<div class="d-flex align-items-center gap-3 mb-6 pt-6">
		<a href="javascript:void(0)" class="liff-back-btn" onclick="liffShowLoading(); window.history.go(-1); return false;" aria-label="Back">
			<i class="ki-outline ki-left fs-2 text-gray-700"></i>
		</a>
		<h1 class="liff-page-title text-gray-700 mb-0 flex-grow-1">Travel expense</h1>
	</div>

	<div class="card card-bordered border-0 mb-5">
		<div class="card-body p-5">

			<div class="d-flex align-items-center justify-content-between gap-3 mb-6">
				<span class="fw-bold fs-5 text-primary">#${fn:escapeXml(expense_group_id)}</span>
				<c:choose>
					<c:when test="${statusActiveSafe == 'W'}"><span class="badge badge-warning fs-7 fw-semibold">Waiting</span></c:when>
					<c:when test="${statusActiveSafe == 'A'}"><span class="badge badge-success fs-7 fw-semibold">Approved</span></c:when>
					<c:when test="${statusActiveSafe == 'P'}"><span class="badge badge-info fs-7 fw-semibold">Paid</span></c:when>
					<c:when test="${statusActiveSafe == 'C'}"><span class="badge badge-danger fs-7 fw-semibold">Canceled</span></c:when>
					<c:when test="${statusActiveSafe == 'R'}"><span class="badge badge-danger fs-7 fw-semibold">Rejected</span></c:when>
				</c:choose>
			</div>

			<c:choose>
				<c:when test="${not empty userAppr}">
					<div class="d-flex align-items-center justify-content-between gap-3">
						<span class="text-muted fs-6">Approved Date</span>
						<div class="d-flex align-items-center gap-2">
							<i class="ki-duotone ki-calendar fs-2 text-muted"><span class="path1"></span><span class="path2"></span></i>
							<span class="fw-semibold text-gray-800 fs-6"><c:choose><c:when test="${not empty approved_at}"><fmt:formatDate value="${approved_at}" pattern="d MMM yyyy, H:mm" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
						</div>
					</div>
					<div class="d-flex align-items-center justify-content-between gap-3 mt-4">
						<span class="text-muted fs-6 text-nowrap">Approved By</span>
						<div class="d-flex align-items-center gap-2" style="min-width:0;">
							<i class="ki-duotone ki-user-tick fs-2 text-muted flex-shrink-0"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
							<span class="fw-semibold text-gray-800 fs-6 text-truncate">${fn:escapeXml(empty userAppr.nameEN ? userAppr.name : userAppr.nameEN)}</span>
						</div>
					</div>
					<c:if test="${not empty description_appr}">
						<div class="d-flex align-items-center gap-3 mt-4">
							<i class="ki-duotone ki-notepad fs-2 text-muted"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
							<span class="fw-semibold text-gray-700 fs-6 text-break">${fn:escapeXml(description_appr)}</span>
						</div>
					</c:if>
				</c:when>
				<c:otherwise>
					<div class="d-flex align-items-center justify-content-between gap-3">
						<span class="text-muted fs-6">Request Date</span>
						<div class="d-flex align-items-center gap-2">
							<i class="ki-duotone ki-calendar fs-2 text-muted"><span class="path1"></span><span class="path2"></span></i>
							<span class="fw-semibold text-gray-800 fs-6"><c:choose><c:when test="${not empty expense_group_create_date}"><fmt:formatDate value="${expense_group_create_date}" pattern="d MMM yyyy, H:mm" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
						</div>
					</div>
				</c:otherwise>
			</c:choose>

		</div>
	</div>

	<div class="d-flex align-items-center justify-content-between gap-3 rounded border border-dashed border-primary bg-light-primary py-5 px-6 mb-5">
		<div class="d-flex align-items-center flex-wrap gap-3 text-primary fw-bold fs-3 lh-1" style="min-width:0;">
			<i class="ki-duotone ki-bill fs-5tx text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span></i>
			<span>Total</span>
			<span class="text-nowrap"><fmt:formatNumber value="${grandTotal}" pattern="#,##0.00" /> บาท</span>
		</div>
		<span class="text-primary fw-bold fs-3 lh-1 text-nowrap">${fn:length(expenseListObj)} Items</span>
	</div>

	<c:if test="${not empty expenseListObj}">
	<div class="card card-bordered mb-5">
		<div class="card-body p-5">
	<c:forEach var="exp" items="${expenseListObj}" varStatus="es">
			<c:if test="${not es.first}"><div class="separator separator-dashed my-6"></div></c:if>

			<div class="d-flex align-items-center justify-content-between gap-2 mb-5">
				<div class="d-flex align-items-center gap-3" style="min-width:0;">
					<span class="badge badge-light-primary fs-7 fw-bold">#${exp['expense_id']}</span>
					<span class="fw-semibold text-gray-800 fs-6"><c:choose><c:when test="${not empty exp['dt_start']}"><fmt:formatDate value="${exp['dt_start']}" pattern="d MMM yyyy" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
				</div>
				<span class="badge badge-primary fs-6 fw-bold text-nowrap"><fmt:formatNumber value="${exp['amount']}" pattern="#,##0.00" /> บาท</span>
			</div>

			<div class="d-flex align-items-center justify-content-between gap-3 mb-5">
				<div class="d-flex align-items-center gap-3" style="min-width:0;">
					<i class="ki-duotone ki-geolocation fs-2 text-primary"><span class="path1"></span><span class="path2"></span></i>
					<div class="text-break" style="min-width:0;">
						<span class="text-muted fs-6">Beginning : </span>
						<span class="fw-semibold text-gray-800 fs-6">${not empty exp['from_location'] ? fn:escapeXml(exp['from_location']) : '-'}</span>
					</div>
				</div>
				<div class="d-flex align-items-center gap-2 flex-shrink-0">
					<i class="ki-duotone ki-time fs-2 text-muted"><span class="path1"></span><span class="path2"></span></i>
					<span class="fw-medium text-gray-700 fs-6"><c:choose><c:when test="${not empty exp['dt_start']}"><fmt:formatDate value="${exp['dt_start']}" pattern="H:mm" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
				</div>
			</div>

			<div class="d-flex align-items-center justify-content-between gap-3 mb-5">
				<div class="d-flex align-items-center gap-3" style="min-width:0;">
					<i class="ki-duotone ki-geolocation fs-2 text-success"><span class="path1"></span><span class="path2"></span></i>
					<div class="text-break" style="min-width:0;">
						<span class="text-muted fs-6">Destination : </span>
						<span class="fw-medium text-gray-800 fs-6">${not empty exp['to_location'] ? fn:escapeXml(exp['to_location']) : '-'}</span>
					</div>
				</div>
				<div class="d-flex align-items-center gap-2 flex-shrink-0">
					<i class="ki-duotone ki-time fs-2 text-muted"><span class="path1"></span><span class="path2"></span></i>
					<span class="fw-semibold text-gray-700 fs-6"><c:choose><c:when test="${not empty exp['dt_end']}"><fmt:formatDate value="${exp['dt_end']}" pattern="H:mm" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
				</div>
			</div>

			<c:forEach var="det" items="${exp['details']}">
				<div class="d-flex align-items-start justify-content-between gap-3 py-3">
					<div class="d-flex align-items-start gap-2" style="min-width:0;">
						<div class="d-flex align-items-center gap-2 flex-shrink-0">
							<span class="d-flex justify-content-center flex-shrink-0 w-15px"><span class="rounded-circle flex-shrink-0 w-8px h-8px bg-gray-400" style="transform: translateY(-1px);"></span></span>
							<span class="fw-semibold text-gray-800 fs-7">${fn:escapeXml(det['travel_type_name'])}</span>
						</div>
						<c:if test="${not empty det['description']}">
							<div class="d-flex align-items-start gap-1" style="min-width:0;">
								<i class="ki-duotone ki-document fs-3 flex-shrink-0"><span class="path1"></span><span class="path2"></span></i>
								<span class="text-gray-600 fs-7 text-break">${fn:escapeXml(det['description'])}</span>
							</div>
						</c:if>
					</div>
					<div class="fw-bold text-gray-800 fs-7 text-nowrap"><fmt:formatNumber value="${det['total']}" pattern="#,##0.00" /> บาท</div>
				</div>
			</c:forEach>
			<c:if test="${empty exp['details']}">
				<div class="text-gray-500 fs-7 py-3">-</div>
			</c:if>

			<div class="d-flex align-items-center gap-3 mt-4">
				<i class="ki-duotone ki-notepad fs-2 text-muted"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
				<span class="fw-semibold text-gray-700 fs-6 text-break">${not empty exp['description'] ? fn:escapeXml(exp['description']) : '-'}</span>
			</div>

			<c:if test="${not empty exp['files']}">
				<div class="d-flex flex-column gap-2 mt-4">
					<c:forEach var="file" items="${exp['files']}">
						<a href="${ctx}${fn:escapeXml(file.path)}" class="d-flex align-items-center text-primary fs-7" style="min-width:0;">
							<i class="ki-duotone ki-document fs-3 me-2 flex-shrink-0"><span class="path1"></span><span class="path2"></span></i>
							<span class="text-truncate">${fn:escapeXml(file.name)}</span><span class="flex-shrink-0">${fn:escapeXml(file.type)}</span>
						</a>
					</c:forEach>
				</div>
			</c:if>
	</c:forEach>
		</div>
	</div>
	</c:if>

	<c:if test="${empty expenseListObj}">
		<div class="text-center text-muted fs-7 py-10">No data.</div>
	</c:if>

	<div class="d-flex gap-3 mt-2">
		<a href="${ctx}/travel_report?expense_group_id=${fn:escapeXml(expense_group_id)}"
			target="_blank" rel="noopener noreferrer"
			class="btn btn-light-primary flex-grow-1 d-flex align-items-center justify-content-center gap-2">
			<i class="ki-duotone ki-printer fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
			Print
		</a>
	</div>

</div>
