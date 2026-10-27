<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%-- modal รายละเอียดเต็มจอ LIFF ใช้ร่วมกันได้ทุกเมนู
     ลิงก์ที่มี class liff-open-detail-modal = โหลดหน้า href แล้วเอาเนื้อหาใน .liff-shell มาแสดง
     (ตัด overlay กับหัวหน้าที่มีปุ่ม back ออก) · param title = หัว modal --%>
<style>
.modal-open .liff-loading-overlay { z-index: 1060; }
</style>

<div class="modal fade" id="liffDetailModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-fullscreen-sm-down modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header py-4" style="padding-left: 22px; padding-right: 22px;">
				<h1 class="liff-page-title text-gray-700 mb-0">${fn:escapeXml(param.title)}</h1>
				<button type="button" class="btn btn-icon btn-light w-45px h-45px flex-shrink-0" data-bs-dismiss="modal" aria-label="Close">
					<i class="ki-duotone ki-cross fs-2x"><span class="path1"></span><span class="path2"></span></i>
				</button>
			</div>
			<div class="modal-body" id="liffDetailBody" style="padding: 22px;"></div>
		</div>
	</div>
</div>

<script>
(function () {
    const modalEl = document.getElementById('liffDetailModal');
    const body = document.getElementById('liffDetailBody');
    const detailModal = new bootstrap.Modal(modalEl);
    let detailModalUrl = null;
    let detailSkeletonTimer = null;
    let skipNextPopstate = false;

    $(document).on('click', '.liff-open-detail-modal', function (e) {
        e.preventDefault();
        openDetailModal(this.href);
    });

    modalEl.addEventListener('hidden.bs.modal', function () {
        detailModalUrl = null;
        clearTimeout(detailSkeletonTimer);
        if (history.state && history.state.detailModal) {
            skipNextPopstate = true;
            history.back();
        }
    });

    window.addEventListener('popstate', function (e) {
        if (skipNextPopstate) {
            skipNextPopstate = false;
            e.stopImmediatePropagation();
        } else if (modalEl.classList.contains('show')) {
            detailModal.hide();
            e.stopImmediatePropagation();
        }
    });

    function openDetailModal(url) {
        detailModalUrl = url;
        body.innerHTML = '';
        clearTimeout(detailSkeletonTimer);
        detailSkeletonTimer = setTimeout(function () {
            body.innerHTML = '<div class="card card-bordered"><div class="card-body p-5 d-flex flex-column gap-5">'
                + '<span class="liff-skel w-100px"></span><span class="liff-skel w-250px"></span>'
                + '<span class="liff-skel w-150px"></span><span class="liff-skel w-200px"></span>'
                + '<span class="liff-skel w-175px"></span></div></div>';
        }, 300);

        history.pushState({ detailModal: true }, '');
        detailModal.show();

        fetch(url, { headers: { 'X-Requested-With': 'XMLHttpRequest' } })
            .then(function (res) {
                if (!res.ok) throw new Error('HTTP ' + res.status);
                return res.text();
            })
            .then(function (html) {
                if (detailModalUrl !== url) return;
                const shell = new DOMParser().parseFromString(html, 'text/html').querySelector('.liff-shell');
                if (!shell) throw new Error('no content');
                const overlay = shell.querySelector('#liffLoadingOverlay');
                if (overlay) overlay.remove();
                const backBtn = shell.querySelector('.liff-back-btn');
                if (backBtn) backBtn.parentElement.remove();
                clearTimeout(detailSkeletonTimer);
                body.innerHTML = '';
                while (shell.firstChild) body.appendChild(shell.firstChild);
            })
            .catch(function () {
                if (detailModalUrl !== url) return;
                detailModal.hide();
                liffToastError('กรุณาลองใหม่อีกครั้ง', 'โหลดรายละเอียดไม่สำเร็จ');
            });
    }
})();
</script>
