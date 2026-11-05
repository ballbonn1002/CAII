<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<fmt:setLocale value="en_US" />

<%-- =====================================================================
     NEW: LINE LIFF — Submit Request (statusActiveSafe ว่าง) และรายละเอียดใบรวม (Waiting / Approved / Paid / Cancel / Reject)
     ค่าจาก TravelAction.submitTravelPreview() เหมือนหน้า desktop my_travel_submit.jsp
     ===================================================================== --%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="isSubmitMode" value="${empty statusActiveSafe}" />
<c:set var="userDisplayName" value="${empty userObj.nameEN ? userObj.name : userObj.nameEN}" />

<div class="liff-shell pb-10">

	<style>
	.liff-sig-box { position: relative; width: 100%; height: 180px; border-radius: 10px; border: 2px dashed var(--bs-gray-400); background: var(--bs-card-bg); display: flex; flex-direction: column; align-items: center; justify-content: center; overflow: hidden; }
	.liff-sig-box.is-locked { border-style: solid; border-color: var(--bs-gray-300); }
	.liff-sig-box img { max-width: 100%; max-height: 160px; object-fit: contain; }
	.liff-sig-box canvas { position: absolute; inset: 0; width: 100%; height: 100%; touch-action: none; cursor: crosshair; }
	.liff-sig-box .liff-sig-hint { pointer-events: none; }
	.liff-submit-bar { display: flex; gap: 10px; margin-top: 20px; }
	.liff-submit-bar .btn { flex: 1; }
	.liff-total-icon { font-size: min(calc(1.7rem + 5.4vw), 42px); }
	</style>

	<div id="liffLoadingOverlay" class="liff-loading-overlay liff-loading-delayed">
		<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>
	</div>

	<div class="d-flex align-items-center gap-3 mb-6 pt-6">
		<a href="javascript:void(0)" class="liff-back-btn" onclick="liffShowLoading(); window.history.go(-1); return false;" aria-label="Back">
			<i class="ki-outline ki-left fs-2 text-gray-700"></i>
		</a>
		<h1 class="liff-page-title text-gray-700 mb-0 flex-grow-1">${isSubmitMode ? 'Submit Request' : 'Travel expense'}</h1>
	</div>

	<form id="submitRequestForm" method="post" action="${ctx}/line_travel_submit" enctype="multipart/form-data" data-user-name="${fn:escapeXml(userDisplayName)}">

	<c:if test="${isSubmitMode}">
		<c:forEach var="sid" items="${selectedIds}">
			<input type="hidden" name="ids" value="${fn:escapeXml(sid)}" />
		</c:forEach>
	</c:if>

	<div class="card card-bordered mb-5">
		<div class="card-body p-5">

			<c:if test="${not isSubmitMode}">
			<div class="d-flex align-items-center justify-content-between gap-3 mb-6">
				<span class="fw-bold fs-5 text-primary">#${fn:escapeXml(expense_group_id)}</span>
				<c:choose>
					<c:when test="${statusActiveSafe == 'W'}"><span class="badge badge-warning badge-lg fs-6 fw-semibold py-2">Waiting</span></c:when>
					<c:when test="${statusActiveSafe == 'A'}"><span class="badge badge-success badge-lg fs-6 fw-semibold py-2">Approved</span></c:when>
					<c:when test="${statusActiveSafe == 'P'}"><span class="badge badge-info badge-lg fs-6 fw-semibold py-2">Paid</span></c:when>
					<c:when test="${statusActiveSafe == 'C'}"><span class="badge badge-danger badge-lg fs-6 fw-semibold py-2">Canceled</span></c:when>
					<c:when test="${statusActiveSafe == 'R'}"><span class="badge badge-danger badge-lg fs-6 fw-semibold py-2">Rejected</span></c:when>
				</c:choose>
			</div>
			</c:if>

			<div class="d-flex align-items-center justify-content-between gap-3">
				<span class="text-muted fs-6 text-nowrap">Request By</span>
				<div class="d-flex flex-column align-items-end gap-1 text-end" style="min-width:0;">
					<span class="fw-semibold text-gray-800 fs-6 text-break">${fn:escapeXml(userObj.employeeId)} - ${fn:escapeXml(userDisplayName)}</span>
					<span class="text-muted fs-7"><c:choose><c:when test="${not empty expense_group_create_date}"><fmt:formatDate value="${expense_group_create_date}" pattern="d MMM yyyy, H:mm" /></c:when><c:otherwise><fmt:formatDate value="<%=new java.util.Date()%>" pattern="d MMM yyyy, H:mm" /></c:otherwise></c:choose></span>
				</div>
			</div>

			<div class="d-flex align-items-center justify-content-between gap-3 rounded border border-dashed border-primary bg-light-primary py-5 px-6 my-6">
				<div class="d-flex align-items-center flex-wrap gap-3 text-primary fw-bold fs-3 lh-1" style="min-width:0;">
					<i class="ki-duotone ki-bill liff-total-icon text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span></i>
					<span>Total</span>
					<span class="text-nowrap"><fmt:formatNumber value="${grandTotal}" pattern="#,##0.00" /> บาท</span>
				</div>
				<span class="text-primary fw-bold fs-3 lh-1 text-nowrap">${fn:length(expenseListObj)} Items</span>
			</div>

			<c:forEach var="exp" items="${expenseListObj}" varStatus="es">
				<c:if test="${not es.first}"><div class="separator separator-dashed my-6"></div></c:if>

				<div class="d-flex align-items-center justify-content-between gap-2 mb-5">
					<div class="d-flex align-items-center gap-3" style="min-width:0;">
						<span class="badge badge-light-primary badge-lg fs-6 fw-bold py-2">#${exp['expense_id']}</span>
						<span class="fw-semibold text-gray-800 fs-6"><c:choose><c:when test="${not empty exp['dt_start']}"><fmt:formatDate value="${exp['dt_start']}" pattern="d MMM yyyy" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
					</div>
					<span class="badge badge-primary badge-lg fs-6 fw-bold py-2 text-nowrap"><fmt:formatNumber value="${exp['amount']}" pattern="#,##0.00" /> บาท</span>
				</div>

				<div class="d-flex align-items-center justify-content-between gap-3 mb-5">
					<div class="d-flex align-items-center gap-3" style="min-width:0;">
						<i class="ki-duotone ki-geolocation fs-2 text-primary"><span class="path1"></span><span class="path2"></span></i>
						<div class="text-break lh-lg" style="min-width:0;">
							<span class="text-muted fs-6">Beginning : </span>
							<span class="fw-semibold text-gray-800 fs-6">${not empty exp['from_location'] ? fn:escapeXml(exp['from_location']) : '-'}</span>
						</div>
					</div>
					<div class="d-flex align-items-center gap-2 flex-shrink-0">
						<i class="ki-duotone ki-time fs-2 text-muted"><span class="path1"></span><span class="path2"></span></i>
						<span class="fw-medium text-gray-700 fs-6 min-w-35px text-end"><c:choose><c:when test="${not empty exp['dt_start']}"><fmt:formatDate value="${exp['dt_start']}" pattern="H:mm" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
					</div>
				</div>

				<div class="d-flex align-items-center justify-content-between gap-3 mb-3">
					<div class="d-flex align-items-center gap-3" style="min-width:0;">
						<i class="ki-duotone ki-geolocation fs-2 text-success"><span class="path1"></span><span class="path2"></span></i>
						<div class="text-break lh-lg" style="min-width:0;">
							<span class="text-muted fs-6">Destination : </span>
							<span class="fw-medium text-gray-800 fs-6">${not empty exp['to_location'] ? fn:escapeXml(exp['to_location']) : '-'}</span>
						</div>
					</div>
					<div class="d-flex align-items-center gap-2 flex-shrink-0">
						<i class="ki-duotone ki-time fs-2 text-muted"><span class="path1"></span><span class="path2"></span></i>
						<span class="fw-semibold text-gray-700 fs-6 min-w-35px text-end"><c:choose><c:when test="${not empty exp['dt_end']}"><fmt:formatDate value="${exp['dt_end']}" pattern="H:mm" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
					</div>
				</div>

				<c:forEach var="det" items="${exp['details']}">
					<div class="d-flex align-items-start justify-content-between gap-3 py-2">
						<div class="d-flex align-items-start gap-2" style="min-width:0;">
							<div class="d-flex align-items-center gap-2 flex-shrink-0">
								<span class="d-flex justify-content-center flex-shrink-0 w-15px"><span class="rounded-circle flex-shrink-0 w-8px h-8px bg-gray-400" style="transform: translateY(-1px);"></span></span>
								<span class="fw-semibold text-gray-800 fs-6">${fn:escapeXml(det['travel_type_name'])}</span>
							</div>
							<c:if test="${not empty det['description']}">
								<div class="d-flex align-items-start gap-1" style="min-width:0;">
									<i class="ki-duotone ki-document fs-3 flex-shrink-0"><span class="path1"></span><span class="path2"></span></i>
									<span class="text-gray-600 fs-6 text-break lh-lg">${fn:escapeXml(det['description'])}</span>
								</div>
							</c:if>
						</div>
						<div class="fw-bold text-primary fs-6 text-nowrap"><fmt:formatNumber value="${det['total']}" pattern="#,##0.00" /> บาท</div>
					</div>
				</c:forEach>
				<c:if test="${empty exp['details']}">
					<div class="text-gray-500 fs-6 py-2">-</div>
				</c:if>

				<div class="d-flex align-items-center gap-3 mt-3">
					<i class="ki-duotone ki-notepad fs-2 text-muted"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
					<span class="fw-semibold text-gray-700 fs-6 text-break lh-lg">${not empty exp['description'] ? fn:escapeXml(exp['description']) : '-'}</span>
				</div>

				<c:if test="${not empty exp['files']}">
					<div class="d-flex flex-column gap-2 mt-5">
						<c:forEach var="file" items="${exp['files']}">
							<a href="${ctx}${fn:escapeXml(file.path)}" class="d-flex align-items-center text-primary fs-7" style="min-width:0;">
								<i class="ki-duotone ki-document fs-3 me-2 flex-shrink-0"><span class="path1"></span><span class="path2"></span></i>
								<span class="text-truncate">${fn:escapeXml(file.name)}</span><span class="flex-shrink-0">${fn:escapeXml(file.type)}</span>
							</a>
						</c:forEach>
					</div>
				</c:if>
			</c:forEach>

			<c:if test="${empty expenseListObj}">
				<div class="text-center text-muted fs-7 py-10">No data.</div>
			</c:if>

		</div>
	</div>

	<div class="card card-bordered mb-5">
		<div class="card-body p-5">
			<h3 class="page-heading fw-bold fs-4 text-gray-900 mb-4">Signature</h3>

			<c:choose>
				<c:when test="${not empty signaturePath}">
					<div class="liff-sig-box is-locked">
						<img src="${ctx}${fn:escapeXml(signaturePath)}" alt="Signature" />
						<div class="position-absolute top-0 end-0 mt-2 me-3 d-flex align-items-center gap-1 text-gray-500 fs-8">
							<i class="ki-duotone ki-lock fs-7 text-gray-500"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i> Signature on file
						</div>
					</div>
				</c:when>
				<c:when test="${isSubmitMode}">
					<div class="liff-sig-box" id="sigBox">
						<span class="liff-sig-hint text-muted fs-7" id="sigHint">Sign inside this box</span>
						<canvas id="sigCanvas"></canvas>
					</div>
					<div class="d-flex justify-content-end mt-2">
						<button type="button" class="btn btn-sm btn-light" id="sigClearBtn" disabled>Clear signature</button>
					</div>
				</c:when>
				<c:otherwise>
					<div class="liff-sig-box">
						<span class="text-muted fs-7">The signature has not been uploaded yet</span>
					</div>
				</c:otherwise>
			</c:choose>

			<div class="mt-5">
				<div class="liff-field-row">
					<span class="liff-field-label">ผู้ขอเบิก</span>
					<div class="ms-auto d-flex flex-column align-items-end text-end py-2" id="receiverPreview1" style="min-width:0;">
						<c:choose>
							<c:when test="${isSubmitMode}">
								<div class="d-flex align-items-center gap-3">
									<span class="text-muted fs-7">กดเพื่อยืนยันผู้ขอเบิกเงิน</span>
									<button type="button" class="btn btn-icon btn-sm btn-confirm-receiver bg-info-subtle" data-slot="1" aria-label="ลงชื่อ ผู้ขอเบิก"><i class="ki-duotone ki-notepad-edit fs-2 text-info"><span class="path1"></span><span class="path2"></span></i></button>
								</div>
							</c:when>
							<c:otherwise>
								<span class="fw-semibold text-gray-800 fs-6 text-break">${fn:escapeXml(userDisplayName)}</span>
								<span class="text-muted fs-7"><c:choose><c:when test="${not empty requestAt}"><fmt:formatDate value="${requestAt}" pattern="d MMM yyyy, H:mm" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="liff-field-row">
					<span class="liff-field-label">ผู้รับเงิน</span>
					<div class="ms-auto d-flex flex-column align-items-end text-end py-2" id="receiverPreview2" style="min-width:0;">
						<c:choose>
							<c:when test="${isSubmitMode}">
								<div class="d-flex align-items-center gap-3">
									<span class="text-muted fs-7">กดเพื่อยืนยันผู้รับเงิน</span>
									<button type="button" class="btn btn-icon btn-sm btn-confirm-receiver bg-info-subtle" data-slot="2" aria-label="ลงชื่อ ผู้รับเงิน"><i class="ki-duotone ki-notepad-edit fs-2 text-info"><span class="path1"></span><span class="path2"></span></i></button>
								</div>
							</c:when>
							<c:otherwise>
								<span class="fw-semibold text-gray-800 fs-6 text-break">${fn:escapeXml(userDisplayName)}</span>
								<span class="text-muted fs-7"><c:choose><c:when test="${not empty requestAt}"><fmt:formatDate value="${requestAt}" pattern="d MMM yyyy, H:mm" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>

	<c:if test="${not empty userAppr}">
	<div class="card card-bordered mb-5">
		<div class="card-body p-5">
			<div class="d-flex align-items-center justify-content-between gap-3 mb-4">
				<h3 class="page-heading fw-bold fs-4 text-gray-900 mb-0">Approver</h3>
				<c:choose>
					<c:when test="${statusActiveSafe == 'W'}"><span class="badge badge-warning badge-lg fs-6 fw-semibold py-2">Waiting</span></c:when>
					<c:when test="${statusActiveSafe == 'A'}"><span class="badge badge-success badge-lg fs-6 fw-semibold py-2">Approved</span></c:when>
					<c:when test="${statusActiveSafe == 'P'}"><span class="badge badge-info badge-lg fs-6 fw-semibold py-2">Paid</span></c:when>
					<c:when test="${statusActiveSafe == 'C'}"><span class="badge badge-danger badge-lg fs-6 fw-semibold py-2">Canceled</span></c:when>
					<c:when test="${statusActiveSafe == 'R'}"><span class="badge badge-danger badge-lg fs-6 fw-semibold py-2">Rejected</span></c:when>
				</c:choose>
			</div>
			<div class="d-flex align-items-center gap-2 text-gray-700 mb-3 fs-6">
				<i class="ki-duotone ki-user-square fs-4"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
				<span class="text-break">${fn:escapeXml(userAppr.employeeId)} - ${fn:escapeXml(userAppr.nameEN)} - ${fn:escapeXml(userAppr.name)} - ${fn:escapeXml(userAppr.departmentId)}</span>
			</div>
			<div class="d-flex align-items-center gap-2 text-gray-700 fs-6">
				<i class="ki-solid ki-calendar-tick fs-4"></i>
				<span><c:choose><c:when test="${not empty approved_at}"><fmt:formatDate value="${approved_at}" pattern="d MMM yyyy , H:mm" /></c:when><c:otherwise>-</c:otherwise></c:choose></span>
			</div>
			<c:if test="${not empty description_appr}">
				<div class="d-flex align-items-start gap-2 text-gray-700 fs-6 mt-3">
					<i class="ki-duotone ki-document fs-4 mt-1"><span class="path1"></span><span class="path2"></span></i>
					<span class="text-break lh-lg">${fn:escapeXml(description_appr)}</span>
				</div>
			</c:if>
		</div>
	</div>
	</c:if>

	<c:if test="${isSubmitMode and not empty expenseListObj}">
		<div class="liff-submit-bar mt-0">
			<a href="${ctx}/line_my_travel?status=Draft" class="btn btn-light">Cancel</a>
			<button type="submit" id="btnSubmit" class="btn btn-primary" disabled>Submit Request</button>
		</div>
	</c:if>

	<c:if test="${statusActiveSafe == 'W'}">
		<div class="liff-submit-bar mt-0">
			<button type="button" class="btn btn-light-danger btn-cancel-group" data-id="${fn:escapeXml(expense_group_id)}">Cancel Request</button>
		</div>
	</c:if>

	</form>

</div>

<c:if test="${isSubmitMode}">
<script>
(function () {
	var form = document.getElementById('submitRequestForm');
	var btnSubmit = document.getElementById('btnSubmit');
	if (!btnSubmit) return;

	var ctx = "${ctx}";
	var currentUserName = form.getAttribute('data-user-name');
	var hasSignature = ${not empty signaturePath ? 'true' : 'false'};
	var canvas = document.getElementById('sigCanvas');
	var signed = false;
	var confirmed = { 1: false, 2: false };
	var MONTH_SHORT = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun",
			"Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];

	function checkSubmitReady() {
		btnSubmit.disabled = !(confirmed[1] && confirmed[2] && (hasSignature || signed));
	}

	if (canvas) {
		var pad = canvas.getContext('2d');
		var drawing = false;
		var hint = document.getElementById('sigHint');
		var clearBtn = document.getElementById('sigClearBtn');

		function setupCanvas() {
			var ratio = window.devicePixelRatio || 1;
			canvas.width = canvas.offsetWidth * ratio;
			canvas.height = canvas.offsetHeight * ratio;
			pad.setTransform(ratio, 0, 0, ratio, 0, 0);
			pad.lineWidth = 2.5;
			pad.lineCap = 'round';
			pad.lineJoin = 'round';
			pad.strokeStyle = getComputedStyle(document.documentElement).getPropertyValue('--bs-primary').trim() || '#1B84FF';
		}

		function pointOf(e) {
			var rect = canvas.getBoundingClientRect();
			return { x: e.clientX - rect.left, y: e.clientY - rect.top };
		}

		canvas.addEventListener('pointerdown', function (e) {
			drawing = true;
			canvas.setPointerCapture(e.pointerId);
			var p = pointOf(e);
			pad.beginPath();
			pad.moveTo(p.x, p.y);
		});

		canvas.addEventListener('pointermove', function (e) {
			if (!drawing) return;
			var p = pointOf(e);
			pad.lineTo(p.x, p.y);
			pad.stroke();
			if (!signed) {
				signed = true;
				hint.classList.add('d-none');
				clearBtn.disabled = false;
				checkSubmitReady();
			}
		});

		canvas.addEventListener('pointerup', function () { drawing = false; });
		canvas.addEventListener('pointercancel', function () { drawing = false; });

		clearBtn.addEventListener('click', function () {
			setupCanvas();
			signed = false;
			hint.classList.remove('d-none');
			clearBtn.disabled = true;
			checkSubmitReady();
		});

		setupCanvas();
	}

	function confirmReceiver(slot) {
		var now = new Date();
		var minutes = now.getMinutes() < 10 ? '0' + now.getMinutes() : now.getMinutes();
		var timestamp = now.getDate() + ' ' + MONTH_SHORT[now.getMonth()] + ' ' + now.getFullYear()
				+ ', ' + now.getHours() + ':' + minutes;

		var preview = document.getElementById('receiverPreview' + slot);
		preview.innerHTML = '';
		$('<span class="fw-semibold text-gray-800 fs-6 text-break"></span>').text(currentUserName).appendTo(preview);
		$('<span class="text-muted fs-7"></span>').text(timestamp).appendTo(preview);
		$('<i class="ki-duotone ki-check-circle fs-2 text-success"><span class="path1"></span><span class="path2"></span></i>').insertAfter(preview);

		confirmed[slot] = true;
		checkSubmitReady();
	}

	$(document).on('click', '.btn-confirm-receiver', function () {
		confirmReceiver(parseInt(this.getAttribute('data-slot'), 10));
	});

	function getSignatureBlob() {
		return new Promise(function (resolve) {
			if (hasSignature || !canvas) { resolve(null); return; }
			canvas.toBlob(resolve, 'image/png');
		});
	}

	// ส่งสำเร็จ BE จะ redirect ไป line_my_travel ถ้า error จะ forward ไม่ redirect
	function isTravelSubmitted(res) {
		return res.ok && res.redirected && res.url.indexOf('line_my_travel') !== -1;
	}

	function isSessionExpired(res) {
		return res.redirected && res.url.indexOf('/pages-line/index.jsp') !== -1;
	}

	var travelSubmitting = false;
	form.addEventListener('submit', function (e) {
		e.preventDefault();
		if (travelSubmitting) { return; }
		travelSubmitting = true;
		btnSubmit.disabled = true;

		var spinner = $('#liffLoadingOverlay');
		spinner.removeClass('liff-loading-delayed').css('display', 'flex');

		var formData = new FormData(form);
		getSignatureBlob()
			.then(function (blob) {
				if (blob) { formData.append('files', blob, 'signature.png'); }
				return fetch(form.action, { method: 'POST', body: formData });
			})
			.then(function (res) {
				if (isSessionExpired(res)) {
					window.location.href = res.url;
					return;
				}
				if (!isTravelSubmitted(res)) { throw new Error('submit failed'); }

				window.location.href = ctx + '/line_my_travel?status=W&saved=submit';
			})
			.catch(function () {
				travelSubmitting = false;
				spinner.css('display', 'none');
				checkSubmitReady();
				liffToastError("Unable to submit your travel request. Please try again.", "Submit failed");
			});
	});

})();
</script>
</c:if>
