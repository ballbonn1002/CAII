<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<fmt:setLocale value="en_US" />

<%-- =====================================================================
     NEW: LINE LIFF — รายละเอียด Travel (หน้าเต็มแทน modal ในหน้า list)
     ===================================================================== --%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="exp" value="${expenseObj}" />

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

	<div class="card card-bordered">
		<div class="card-body p-5">

			<div class="d-flex align-items-center gap-3 mb-6">
				<span class="fw-bold fs-5 text-primary">#${exp.expenseId}</span>
				<c:if test="${empty exp.expenseGroupId or exp.expenseGroupId == 0}">
					<span class="badge badge-secondary fs-7 fw-semibold px-3 py-2">Draft</span>
				</c:if>
			</div>
			<c:set var="userText" value="-" />
			<c:forEach var="u" items="${userListObj}">
				<c:if test="${u['id'] == exp.userId}">
					<c:set var="userText">${not empty u['employee_id'] ? fn:escapeXml(u['employee_id']) : ''} - ${not empty u['name_en'] ? fn:escapeXml(u['name_en']) : ''} - ${not empty u['name'] ? fn:escapeXml(u['name']) : ''} - ${not empty u['department'] ? fn:escapeXml(u['department']) : ''}</c:set>
				</c:if>
			</c:forEach>

			<div class="d-flex align-items-center gap-3 mb-5">
				<i class="ki-duotone ki-user-square fs-2 text-muted"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
				<span class="fw-medium text-gray-900 fs-6">${userText}</span>
			</div>

			<div class="d-flex align-items-center gap-3 mb-5">
				<i class="ki-duotone ki-calendar fs-2 text-muted"><span class="path1"></span><span class="path2"></span></i>
				<span class="fw-semibold text-gray-800 fs-6"><c:choose><c:when test="${not empty exp.dtStart}"><fmt:formatDate value="${exp.dtStart}" pattern="d MMM yyyy" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
			</div>

			<div class="d-flex align-items-center gap-3 mb-5">
				<i class="ki-duotone ki-notepad fs-2 text-muted"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
				<span class="fw-semibold text-gray-700 fs-6 text-break">${not empty exp.description ? fn:escapeXml(exp.description) : '-'}</span>
			</div>

			<div class="d-flex align-items-center justify-content-between gap-3 mb-5">
				<div class="d-flex align-items-center gap-3" style="min-width:0;">
					<i class="ki-duotone ki-geolocation fs-2 text-primary"><span class="path1"></span><span class="path2"></span></i>
					<div>
						<span class="text-muted fs-6">Beginning : </span>
						<span class="fw-semibold text-gray-800 fs-6">${not empty exp.fromLocation ? fn:escapeXml(exp.fromLocation) : '-'}</span>
					</div>
				</div>
				<div class="d-flex align-items-center gap-2 flex-shrink-0">
					<i class="ki-duotone ki-time fs-2 text-muted"><span class="path1"></span><span class="path2"></span></i>
					<span class="fw-medium text-gray-700 fs-6"><c:choose><c:when test="${not empty exp.dtStart}"><fmt:formatDate value="${exp.dtStart}" pattern="H:mm" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
				</div>
			</div>

			<div class="d-flex align-items-center justify-content-between gap-3 mb-5">
				<div class="d-flex align-items-center gap-3" style="min-width:0;">
					<i class="ki-duotone ki-geolocation fs-2 text-success"><span class="path1"></span><span class="path2"></span></i>
					<div>
						<span class="text-muted fs-6">Destination : </span>
						<span class="fw-medium text-gray-800 fs-6">${not empty exp.toLocation ? fn:escapeXml(exp.toLocation) : '-'}</span>
					</div>
				</div>
				<div class="d-flex align-items-center gap-2 flex-shrink-0">
					<i class="ki-duotone ki-time fs-2 text-muted"><span class="path1"></span><span class="path2"></span></i>
					<span class="fw-semibold text-gray-700 fs-6"><c:choose><c:when test="${not empty exp.dtEnd}"><fmt:formatDate value="${exp.dtEnd}" pattern="H:mm" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
				</div>
			</div>

			<div class="fs-7 text-muted mb-6">Request Date: <fmt:formatDate value="${exp.timeCreate}" pattern="d MMM yyyy, H:mm" /></div>

			<div class="separator separator-dashed mb-6"></div>

			<div class="d-flex align-items-center justify-content-between mb-3">
				<span class="text-gray-700 fw-medium fs-5">Expense form</span>
				<span class="badge badge-primary fw-bold fs-6"><fmt:formatNumber value="${exp.amount}" pattern="#,##0.00" /> บาท</span>
			</div>

			<div>
				<c:forEach var="det" items="${detailList}">
					<c:set var="typeName" value="-" />
					<c:forEach var="t" items="${expTravelTypeList}">
						<c:if test="${t.expTravelTypeId == det.goBy}"><c:set var="typeName" value="${t.name}" /></c:if>
					</c:forEach>
					<div class="d-flex align-items-start justify-content-between gap-3 py-2">
						<div class="d-flex align-items-start gap-2" style="min-width:0;">
							<div class="d-flex align-items-center gap-2 flex-shrink-0">
								<span class="d-flex justify-content-center flex-shrink-0 w-15px"><span class="rounded-circle flex-shrink-0 w-8px h-8px bg-gray-400" style="transform: translateY(-1px);"></span></span>
								<span class="fw-semibold text-gray-800 fs-7">${fn:escapeXml(typeName)}</span>
							</div>
							<c:if test="${not empty det.description}">
								<div class="d-flex align-items-start gap-1" style="min-width:0;">
									<i class="ki-duotone ki-document fs-3 flex-shrink-0"><span class="path1"></span><span class="path2"></span></i>
									<span class="text-gray-600 fs-7 text-break">${fn:escapeXml(det.description)}</span>
								</div>
							</c:if>
						</div>
						<div class="fw-bold text-primary fs-7 text-nowrap"><fmt:formatNumber value="${det.total}" pattern="#,##0.00" /> บาท</div>
					</div>
				</c:forEach>
				<c:if test="${empty detailList}">
					<div class="text-gray-500 fs-7 py-2">-</div>
				</c:if>
			</div>

			<c:if test="${not empty travelFiles}">
				<div class="d-flex flex-column gap-2 mt-3">
					<c:forEach var="file" items="${travelFiles}">
						<a href="${ctx}${fn:escapeXml(file.path)}" class="d-flex align-items-center text-primary fs-7" style="min-width:0;">
							<i class="ki-duotone ki-document fs-3 me-2 flex-shrink-0"><span class="path1"></span><span class="path2"></span></i>
							<span class="text-truncate">${fn:escapeXml(file.name)}</span><span class="flex-shrink-0">${fn:escapeXml(file.type)}</span>
						</a>
					</c:forEach>
				</div>
			</c:if>

		</div>
	</div>
</div>
