<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
.liff-sig-box { position: relative; width: 100%; height: 180px; border-radius: 10px; border: 2px dashed var(--bs-gray-400); background: var(--bs-card-bg); display: flex; flex-direction: column; align-items: center; justify-content: center; overflow: hidden; }
.liff-sig-box.is-locked { border-style: solid; border-color: var(--bs-gray-300); }
.liff-sig-box img { max-width: 100%; max-height: 160px; object-fit: contain; }
.liff-sig-box canvas { position: absolute; inset: 0; width: 100%; height: 100%; touch-action: none; cursor: crosshair; }
.liff-sig-box .liff-sig-hint { pointer-events: none; }
</style>

<c:set var="sigId" value="${empty param.idPrefix ? 'sig' : fn:escapeXml(param.idPrefix)}" />
<div class="liff-sig-pad">
	<c:choose>
		<c:when test="${not empty param.signatureUrl}">
			<div class="liff-sig-box is-locked">
				<img src="${fn:escapeXml(param.signatureUrl)}" alt="Signature" />
				<div class="position-absolute top-0 end-0 mt-2 me-3 d-flex align-items-center gap-1 text-gray-500 fs-8">
					<i class="ki-duotone ki-lock fs-7 text-gray-500"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i> Signature on file
				</div>
			</div>
		</c:when>
		<c:when test="${param.editable == 'true'}">
			<div class="liff-sig-box" id="${sigId}Box">
				<span class="liff-sig-hint text-muted fs-7" id="${sigId}Hint">Sign inside this box</span>
				<canvas id="${sigId}Canvas"></canvas>
			</div>
			<div class="d-flex justify-content-end mt-2">
				<button type="button" class="btn btn-sm btn-light liff-sig-clear" id="${sigId}ClearBtn" disabled>Clear signature</button>
			</div>
		</c:when>
		<c:otherwise>
			<div class="liff-sig-box">
				<span class="text-muted fs-7">The signature has not been uploaded yet</span>
			</div>
		</c:otherwise>
	</c:choose>
</div>

<script>
function liffSignaturePad(canvas, onChange) {
	var wrap = canvas.closest('.liff-sig-pad');
	var pad = canvas.getContext('2d');
	var isDrawing = false;
	var hasSigned = false;
	var hint = wrap.querySelector('.liff-sig-hint');
	var clearBtn = wrap.querySelector('.liff-sig-clear');

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

	function clearSignature() {
		setupCanvas();
		hasSigned = false;
		hint.classList.remove('d-none');
		clearBtn.disabled = true;
		onChange();
	}

	function pointOf(e) {
		var rect = canvas.getBoundingClientRect();
		return { x: e.clientX - rect.left, y: e.clientY - rect.top };
	}

	canvas.addEventListener('pointerdown', function (e) {
		isDrawing = true;
		canvas.setPointerCapture(e.pointerId);
		var p = pointOf(e);
		pad.beginPath();
		pad.moveTo(p.x, p.y);
	});

	canvas.addEventListener('pointermove', function (e) {
		if (!isDrawing) return;
		var p = pointOf(e);
		pad.lineTo(p.x, p.y);
		pad.stroke();
		if (!hasSigned) {
			hasSigned = true;
			hint.classList.add('d-none');
			clearBtn.disabled = false;
			onChange();
		}
	});

	canvas.addEventListener('pointerup', function () { isDrawing = false; });
	canvas.addEventListener('pointercancel', function () { isDrawing = false; });
	clearBtn.addEventListener('click', clearSignature);

	setupCanvas();

	return {
		isSigned: function () { return hasSigned; },
		clear: clearSignature,
		resize: setupCanvas,
		toBlob: function () {
			return new Promise(function (resolve) { canvas.toBlob(resolve, 'image/png'); });
		}
	};
}
</script>
