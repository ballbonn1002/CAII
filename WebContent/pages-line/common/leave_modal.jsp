<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- modal รายละเอียดใบลา LIFF ใช้ร่วมกัน (My Leave / Check List) --%>
<!--begin::Modal - Leave Detail-->
<div class="modal fade" id="leaveDetailModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<!--begin::Header-->
			<div class="modal-header">
				<h2 class="modal-title">Leave</h2>
				<div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
					<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
				</div>
			</div>
			<!--end::Header-->

			<!--begin::Body-->
			<div class="modal-body">
				<!-- Leaver Info -->
				<div class="d-flex align-items-center gap-4 mb-4 fs-5">
					<span class="fw-bold text-primary">#<span id="leaveid"></span></span>
					<span class="fw-semibold text-dark" id="leavetype"></span>
					<span class="rounded-circle flex-shrink-0" style="width:8px; height:8px; background-color:var(--bs-text-gray-400);"></span><%-- จุดคั่น --%>
					<span class="badge badge-light-primary fw-semibold" id="noday"></span>
				</div>

				<div class="d-flex align-items-center gap-2 text-gray-800 fw-semibold mb-3 fs-6">
					<i class="ki-duotone ki-user-square fs-4"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
					<span><span id="employeeId"></span><span id="username"></span></span>
				</div>

				<div class="d-flex align-items-center gap-2 text-gray-700 mb-3 fs-6">
					<i class="ki-duotone ki-calendar-2 fs-4"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
					<span><span id="sdate"></span> - <span id="edate"></span></span>
				</div>

				<div class="d-flex align-items-center gap-2 text-gray-700 mb-3 fs-6">
					<i class="ki-duotone ki-time fs-4"><span class="path1"></span><span class="path2"></span></i>
					<span><span id="stime"></span> - <span id="etime"></span></span>
				</div>

				<c:if test="${param.showDescFiles == 'true'}">
				<div class="d-flex align-items-start gap-2 text-gray-700 mb-3 fs-6">
					<i class="ki-duotone ki-message-text fs-4 mt-1"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
					<span id="desc" class="text-break"></span>
				</div>

				<div class="d-flex align-items-start gap-2 text-gray-700 mb-4 fs-6">
					<i class="ki-duotone ki-document fs-4 mt-1"><span class="path1"></span><span class="path2"></span></i>
					<span id="fileList" class="d-flex flex-wrap gap-2 align-items-center" style="min-width:0;"></span>
				</div>
				</c:if>

				<div class="mb-3">
					<span id="leavestatus" class="badge fs-7 fw-semibold"></span>
				</div>

				<div class="fs-7 text-muted">Request Date: <span id="requestdate"></span></div>
				<!-- Leaver Info -->

				<hr id="leaveDetailDivider" style="border-top: 1px dashed #ced4da; opacity: 1;" class="my-5">

				<!-- Approver Info -->
				<div id="status_panel" style="display: none;">
					<h3 class="page-heading fw-bold fs-4 mb-4" id="status_title"></h3>
					<div id="approved_detail">
						<div class="d-flex align-items-center gap-2 text-gray-700 mb-3 fs-6">
							<i class="ki-duotone ki-user-tick fs-4"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
							<span id="aprName"></span>
						</div>
						<div class="d-flex align-items-center gap-2 text-gray-700 mb-3 fs-6">
							<i class="ki-duotone ki-calendar-2 fs-4"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
							<span id="timeupdate"></span>
						</div>
						<div class="d-flex align-items-start gap-2 text-gray-700 fs-6">
							<i class="ki-duotone ki-document fs-4 mt-1"><span class="path1"></span><span class="path2"></span></i>
							<span id="reason_s" class="text-break"></span>
						</div>
					</div>
				</div>
				<!-- Approver Info -->
			</div>
			<!--end::Body-->
		</div>
	</div>
</div>
<!--end::Modal - Leave Detail-->

<script>
/* ---------- modal รายละเอียดใบลา ---------- */
function renderLeaveModalFiles(obj) {
	var $list = $('#fileList').empty();

	var files = (obj && Array.isArray(obj.files)) ? obj.files.slice() : [];

	if (files.length === 0 && obj && obj.leave_file_name && obj.leave_file_name !== 'null' && obj.leave_file_id) {
		files = [{ id: obj.leave_file_id, name: obj.leave_file_name, type: obj.leave_file_type || '' }];
	}

	if (files.length === 0) {
		$list.append($('<span class="text-muted">No file attached</span>'));
		return;
	}

	files.forEach(function (f, i) {
		var full = (f.name || '') + (f.type || '');
		$list.append(
			$('<a target="_blank" class="text-primary text-hover-underline text-truncate d-inline-block align-bottom"></a>')
				.attr('href', 'line_preview_File?id=' + f.id)
				.css('max-width', '220px')
				.attr('title', full)
				.text(full)
		);
		if (i < files.length - 1) $list.append($('<span class="text-muted">,</span>'));
	});
}

function setLeaveApprover(obj) {
	$('#status_panel').show();
	$('#approved_detail').show();
	$('#aprName').html(obj.aprName);
	// BE ส่งมาเป็น "dd MMM yyyy, HH:mm"
	var updated = moment(obj.time_update, "DD MMM YYYY, HH:mm");
	$('#timeupdate').html(updated.isValid() ? updated.format("D MMM YYYY , H:mm") : (obj.time_update || '-'));
	$('#reason_s').html(obj.reason || '-');
}

function leaveStatus(id) {
	const modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('leaveDetailModal'));
	modal.show();

	$.ajax({
		url: "new_modalLeaveStatus",
		method: "POST",
		data: { leaveId: id },
		success: function (data) {
			var obj = JSON.parse(data);

			$('#leaveid').html(obj.leave_id);
			$('#employeeId').html(obj.employeeId + " ");
			$('#username').html(obj.name);
			$('#stime').html(obj.start_time);
			$('#etime').html(obj.end_time);
			$('#desc').html(obj.description);

			renderLeaveModalFiles(obj);

			// leave type name
			if (obj.leave_type_id == 1) { $('#leavetype').html("ลาพักร้อน"); }
			if (obj.leave_type_id == 2) { $('#leavetype').html("ลากิจ"); }
			if (obj.leave_type_id == 3) { $('#leavetype').html("ลาป่วย"); }
			if (obj.leave_type_id == 4) { $('#leavetype').html("ขาดงาน"); }
			if (obj.leave_type_id == 5) { $('#leavetype').html("ลาโดยไม่รับค่าจ้าง"); }
			if (obj.leave_type_id == 6) { $('#leavetype').html("ลาพักร้อนที่เหลือจากปีก่อน"); }
			if (obj.leave_type_id == 7) { $('#leavetype').html("ลาอื่นๆ"); }
			if (obj.leave_type_id == 9) { $('#leavetype').html("อื่นๆ"); }

			// date formatting
			var startdate = (obj.start_date).split(",");
			$('#sdate').html(moment(startdate[0]).format("D MMM YYYY"));

			var enddate = (obj.end_date).split(",");
			$('#edate').html(moment(enddate[0]).format("D MMM YYYY"));

			$('#noday').html(obj.no_day + " Day");

			// Request Date แสดงแค่วันที่
			var created = moment(String(obj.time_create || '').split(",")[0], "DD MMM YYYY");
			$('#requestdate').html(created.isValid() ? created.format("D MMM YYYY") : (obj.time_create || '-'));

			// leave status
			$('#status_panel').hide();
			$('#leaveDetailDivider').hide();
			if (obj.leave_status_id == '0') {//Wait for Approving
				$('#leavestatus').html("Wait for Approving").removeClass().addClass('badge badge-light-warning fs-7 fw-semibold');
			}
			else if (obj.leave_status_id == '1') {//Approved
				$('#leavestatus').html("Approved").removeClass().addClass('badge badge-light-success fs-7 fw-semibold');
				$('#status_title').html("Approver").removeClass('text-danger').addClass('text-primary');
				$('#leaveDetailDivider').show();
				setLeaveApprover(obj);
			}
			else if (obj.leave_status_id == '2') {//Reject
				$('#leavestatus').html("Reject").removeClass().addClass('badge badge-light-danger fs-7 fw-semibold');
				$('#status_title').html("Reject").removeClass('text-primary').addClass('text-danger');
				$('#leaveDetailDivider').show();
				setLeaveApprover(obj);
			}
			else if (obj.leave_status_id == '3') {//Cancel
				$('#leavestatus').html("Cancel").removeClass().addClass('badge badge-light-dark fs-7 fw-semibold');
				$('#status_title').html("Cancel").removeClass('text-primary').addClass('text-danger');
				$('#leaveDetailDivider').show();
				setLeaveApprover(obj);
			}
		},
		error: function () {
			// modal ยังเปิดไม่เสร็จ รอแสดงก่อนค่อย hide
			var $m = $('#leaveDetailModal');
			$m.one('shown.bs.modal.loadFail', function () { modal.hide(); });
			$m.one('hidden.bs.modal', function () { $m.off('shown.bs.modal.loadFail'); });
			modal.hide();
			liffToastError("Unable to load leave details. Please try again.", "Load failed");
		}
	});
}
</script>
