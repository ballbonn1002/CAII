<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!--begin::Modal - Leave Detail-->
<div class="modal fade" id="leaveDetailModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-lg">
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
				<div class="row gx-5 gy-4">
					<!-- Left -->
					<div class="col-md-6">
						<div class="d-flex align-items-center mb-3 fs-5">
							<a href="#" class="fw-bold text-primary me-5">#<span id="leaveid"></span></a>
							<span class="fw-semibold text-dark me-5" id="leavetype"></span>
							<span class="badge badge-light-primary fw-semibold" id="noday"></span>
						</div>

						<div class="d-flex align-items-center text-gray-700 mb-2 fs-6">
							<i class="ki-duotone ki-calendar-2 me-2">
								 <span class="path1"></span>
								 <span class="path2"></span>
								 <span class="path3"></span>
								 <span class="path4"></span>
								 <span class="path5"></span>
							</i>
							<span id="sdate"></span> - <span id="edate"></span>
						</div>

						<div class="d-flex align-items-center text-gray-700 mb-2 fs-6">
							<i class="ki-duotone ki-message-text me-2">
								 <span class="path1"></span>
								 <span class="path2"></span>
								 <span class="path3"></span>
							</i>
							<span id="desc"></span>
						</div>

						<span id="leavestatus" class="badge badge-lg mt-3 fs-7 fw-semibold"></span>
					</div>

					<!-- Right -->
					<div class="col-md-6">
						
						<div class="fw-semibold text-dark mb-2 fs-5">
							<i class="ki-duotone ki-user-square">
								<span class="path1"></span><span class="path2"></span><span class="path3"></span>
							</i>
							<span class="" id="employeeId"></span><span class="" id="username"></span>
						</div>

						<div class="d-flex align-items-center text-gray-700 mb-2 fs-6">
							<i class="ki-duotone ki-time me-2">
								 <span class="path1"></span><span class="path2"></span>
							</i> 
							<span id="stime"></span> - <span id="etime"></span>
						</div>

						<div class="d-flex align-items-center text-gray-700 mb-2 fs-6">
							<i class="ki-duotone ki-document me-2">
								 <span class="path1"></span>
								 <span class="path2"></span>
							</i>
							<a id="file" href="#" target="_blank" class="text-primary text-hover-underline"></a>
						</div>
						<div>
							Request By: <span id="ucEmpId"></span> <span id="ucName"></span> , <span id="timecreate"></span>
						</div>

					</div>
				</div>
				<!-- Leaver Info -->
				<hr style="border-top: 1px dashed #ced4da; opacity: 1;" class="my-5">
				
				<!-- Approver Info -->
				<c:if test="${param.showApproverInfo == 'true'}">
				<div class="row gx-5 gy-4">
					<div id="status_panel" class="mt-5" style="display: none;">
						<h3 class="text-primary fw-semibold mb-3" id="status_title"></h3>
						<div class="row gx-5 gy-3 fs-6" id="approved_detail">
							<!-- Left -->
							<div class="col-md-6">
								<!-- Approver -->
								<div class="d-flex align-items-center text-gray-700 mb-2 fs-6">
									<i class="ki-duotone ki-user-tick me-2">
										<span class="path1"></span>
										<span class="path2"></span>
										<span class="path3"></span>
									</i>
									<span id="aprEmpId"></span><span id="aprName"></span><span id="aprRole"></span>
								</div>
								<!-- Approver -->

								<!-- Reason Approve -->
								<div class="d-flex align-items-center text-gray-700 mb-2 fs-6">
										<i class="ki-duotone ki-document me-2">
											<span class="path1"></span>
											<span class="path2"></span>
										</i>
										<span id="reason_s"></span>
								</div>
								<!-- Reason Approve -->
							</div>

							<!-- Right -->
							<div class="col-md-6">
								<!-- Date Approve -->
								<div class="d-flex align-items-center text-gray-700 mb-2 fs-6">
										<i class="ki-duotone ki-calendar-2 me-2">
											<span class="path1"></span>
											<span class="path2"></span>
											<span class="path3"></span>
											<span class="path4"></span>
											<span class="path5"></span>
										</i>
										<span id="timeupdate"></span>
								</div>
								<!-- Date Approve -->
							</div>

						</div>

					</div>
				</div>
				</c:if>
				<!-- Approver Info -->
				
				<!-- Approver Info -->
				<c:if test="${param.showApprovePanel == 'true'}">
				<div class="row gx-5 gy-4">
					<div id="approve_action_panel" class="mt-5" style="display: none;">
						<h3 class="text-primary fw-semibold mb-3" id="status_title"></h3>
						<div class="row gx-5 gy-3 fs-6" id="approved_detail">
							<!-- Left -->
							<div class="col-md-6">
								<!-- Approver -->
								<div class="d-flex align-items-center text-gray-700 mb-2 fs-6">
									<i class="ki-duotone ki-user-tick me-2">
										<span class="path1"></span>
										<span class="path2"></span>
										<span class="path3"></span>
									</i>
									<span id="aprEmpId"></span><span id="aprName"></span><span id="aprRole"></span>
								</div>
								<!-- Approver -->

								<!-- Reason Approve -->
								<div class="d-flex align-items-center text-gray-700 mb-2 fs-6">
										<i class="ki-duotone ki-document me-2">
											<span class="path1"></span>
											<span class="path2"></span>
										</i>
										<span id="reason_s"></span>
								</div>
								<!-- Reason Approve -->
							</div>

							<!-- Right -->
							<div class="col-md-6">
								<!-- Date Approve -->
								<div class="d-flex align-items-center text-gray-700 mb-2 fs-6">
										<i class="ki-duotone ki-calendar-2 me-2">
											<span class="path1"></span>
											<span class="path2"></span>
											<span class="path3"></span>
											<span class="path4"></span>
											<span class="path5"></span>
										</i>
										<span id="timeupdate"></span>
								</div>
								<!-- Date Approve -->
							</div>

						</div>

					</div>
					
					<div id="change_panel" >
						<h5 class="text-primary sbold mt-5" id="status_title_action" style="margin-bottom:20px;"></h5>
						<div><span>Reason <span class="text-danger">*</span></span></div>
						<textarea class="form-control" rows="3" id="appr_reason"></textarea>
						<div class="reason invalid-feedback" style="display: none;"></div>
					</div>
					
				</div>
				</c:if>
				<!-- Approver Info -->

			</div>
			<!--end::Body-->

			<!--begin::Footer-->
			<div class="modal-footer">
				<button type="button" class="btn btn-lg btn-light" data-bs-dismiss="modal">Close</button>
				
				<c:if test="${param.showEditButton == 'true'}">
					<perm:permission object="leave.approve">
						<a href="#" class="btn btn-primary" id="btn_edit_leave"> <i
							class="fa fa-edit"></i> Edit
						</a>
					</perm:permission>
				 </c:if>
				
				<c:if test="${param.showApproveButton == 'true'}">
					<button type="button" value="2" class="btn btn-lg btn-danger" id="btn_reject">Reject</button>
					<button type="button" value="1" class="btn btn-lg btn-success" id="btn_approve">Approved</button>
			    </c:if>
			</div>
			<!--end::Footer-->
		</div>
	</div>
</div>
<!--end::Modal - Leave Detail-->

<script>
function setApproveMode(isWaiting) {

	if (isWaiting) {

		// waiting approve
		$('#status_panel').hide();

		$('#approve_action_panel').show();

		$('#btn_approve').show();
		$('#btn_reject').show();

	} else {

		// approved/reject/cancel
		$('#status_panel').show();

		$('#approve_action_panel').hide();

		$('#btn_approve').hide();
		$('#btn_reject').hide();
	}
}

function leaveStatus(id) {
	const modal = new bootstrap.Modal(document.getElementById('leaveDetailModal'));
	modal.show();

	/* console.log(id); */

	$.ajax({
		url: "new_modalLeaveStatus",
		method: "POST",
		data: { leaveId: id },
		success: function (data) {
			var obj = JSON.parse(data);
			console.log(obj);

			$('#leaveid').html(obj.leave_id);
			$('#employeeId').html(obj.employeeId + " ");
			$('#username').html(obj.name);
			//$('#userid').html(obj.user_id);
			$('#stime').html(obj.start_time);
			$('#etime').html(obj.end_time);
			$('#desc').html(obj.description);
			$('#ucEmpId').html(obj.ucEmpId);
			$('#ucName').html(obj.ucName);
			
			// validate file name is empty
			if (obj.leave_file_name && obj.leave_file_name !== "null") {
			    $('#file')
			        .html(obj.leave_file_name + (obj.leave_file_type || ''))
			        .attr('href', 'preview_File?id=' + obj.leave_file_id)
			        .attr('target', '_blank')
			        .show();
			} else {
			    $('#file')
			        .html('No file attached')
			        .removeAttr('href')
			        .removeAttr('target')
			        .removeClass('text-primary text-hover-underline');
			}

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
			var sdate = moment(startdate[0]).format("D MMM YYYY");
			$('#sdate').html(sdate);

			var enddate = (obj.end_date).split(",");
			var edate = moment(enddate[0]).format("D MMM YYYY");
			$('#edate').html(edate);

			$('#noday').html(obj.no_day + " Day");

			//var timecreate = (obj.time_create).split(",");
			//var tcreate = moment(timecreate[0]).format("D MMM YYYY");
			$('#timecreate').html(obj.time_create.replace(",", " "));

	      // leave status
			if (obj.leave_status_id == '0') {//Wait for Approving
				$('#leavestatus')
					.html("Wait for Approving")
					.removeClass()
					.addClass('badge badge-light-warning');
				$('#status_panel').hide();
				$('#status_title').html("Approver")
					.removeClass('text-danger')
					.addClass('text-primary');
			}
			else if (obj.leave_status_id == '1') {//Approved
				$('#leavestatus')
					.html("Approved")
					.removeClass()
					.addClass('badge badge-light-success');
				$('#status_title')
					.html("Approver")
					.removeClass('text-danger')
					.addClass('text-primary');
				$('#status_panel').show();
				$('#approved_detail').show();
				//$('#approver').html(obj.user_update);
				$('#aprEmpId').html(obj.aprEmpId + " ");
				$('#aprName').html(obj.aprName + " - ");
				$('#aprRole').html(obj.aprRole);
				$('#timeupdate').html(moment(obj.time_update).format("D MMM YYYY, HH:mm"));
				$('#reason_s').html(obj.reason);
			}
			else if (obj.leave_status_id == '2') {//Reject
				$('#leavestatus')
					.html("Reject")
					.removeClass()
					.addClass('badge badge-light-danger');
				$('#status_title')
					.html("Approver")
					.removeClass('text-danger')
					.addClass('text-primary');
				$('#status_panel').show();
				$('#approved_detail').show();
				//$('#approver').html(obj.user_update);
				$('#aprEmpId').html(obj.aprEmpId + " ");
				$('#aprName').html(obj.aprName + " - ");
				$('#aprRole').html(obj.aprRole);
				$('#timeupdate').html(moment(obj.time_update).format("D MMM YYYY, HH:mm"));
				$('#reason_s').html(obj.reason);
			}
			else if (obj.leave_status_id == '3') {//Cancel
				$('#leavestatus')
					.html("Cancel")
					.removeClass()
					.addClass('badge badge-light-dark');
				$('#status_title')
					.html("Cancel")
					.removeClass('text-primary')
					.addClass('text-danger');
				$('#status_panel').show();
				$('#approved_detail').show();
				//$('#approver').html(obj.user_update);
				$('#aprEmpId').html(obj.aprEmpId + " ");
				$('#aprName').html(obj.aprName + " - ");
				$('#aprRole').html(obj.aprRole);
				$('#timeupdate').html(moment(obj.time_update).format("D MMM YYYY, HH:mm"));
				$('#reason_s').html(obj.reason);
			}
		},
		error: function () {
			alert("Error retrieving leave detail.");
		}
	});
}
</script>


<script>
function leaveApproveStatus(id) {
	const modal = new bootstrap.Modal(document.getElementById('leaveDetailModal'));
	modal.show();

	console.log(id);
	$.ajax({
		url: "new_modalLeaveStatus",
		method: "POST",
		data: {
			leaveId: id
		},
		success: function (data) {
			var obj = JSON.parse(data);
			console.log(obj);

			$('#leaveid').html(obj.leave_id);
			$('#employeeId').html(obj.employeeId + " ");
			$('#username').html(obj.name);
			$('#stime').html(obj.start_time);
			$('#etime').html(obj.end_time);
			$('#desc').html(obj.description);
			$('#ucEmpId').html(obj.ucEmpId);
			$('#ucName').html(obj.ucName);
			if(obj.leave_file_name == null){
				$('#file').html("-");
			}else{
				$('#file').html(obj.leave_file_name + obj.leave_file_type).attr('href', 'preview_File?id=' + obj.leave_file_id).attr('target', '_blank');
			}
			// leave type name
			if (obj.leave_type_id == 1) {
				$('#leavetype').html("ลาพักร้อน");
			}
			if (obj.leave_type_id == 2) {
				$('#leavetype').html("ลากิจ");
			}
			if (obj.leave_type_id == 3) {
				$('#leavetype').html("ลาป่วย");
			}
			if (obj.leave_type_id == 4) {
				$('#leavetype').html("ขาดงาน");
			}
			if (obj.leave_type_id == 5) {
				$('#leavetype').html("ลาโดยไม่รับค่าจ้าง");
			}
			if (obj.leave_type_id == 6) {
				$('#leavetype').html("ลาพักร้อนที่เหลือจากปีก่อน");
			}
			if (obj.leave_type_id == 7) {
				$('#leavetype').html("ลาอื่นๆ");
			}
			if (obj.leave_type_id == 9) {
				$('#leavetype').html("อื่นๆ");
			}

			// date formatting
			var startdate = (obj.start_date).split(",");
			var sdate = moment(startdate[0]).format("D MMM YYYY");
			$('#sdate').html(sdate);

			var enddate = (obj.end_date).split(",");
			var edate = moment(enddate[0]).format("D MMM YYYY");
			$('#edate').html(edate);

			$('#noday').html(obj.no_day + " Day");

			//var timecreate = (obj.time_create).split(",");
			//var tcreate = moment(timecreate[0]).format("D MMM YYYY");
			$('#timecreate').html(obj.time_create.replace(",", " "));

			$("#appr_reason").val("");

			// leave status
			if (obj.leave_status_id == '0') {
				//CASE: Wait for Approving
				$('#leavestatus').html("Wait for Approving").removeClass().addClass('badge badge-light-warning');
				$('#status_title_action').html("Approver").removeClass('text-danger').addClass('text-dark');

				setModalViewMode(true);

				$("#btn_reject").attr("onclick", "sentData(" + obj.leave_id + ", 2)");
				$("#btn_approve").attr("onclick", "sentData(" + obj.leave_id + ", 1)");

			} else {
				//CASE: Approved / Reject / Cancel

				setModalViewMode(false);
				//$('#approver').html(obj.user_update);
				$('#aprEmpId').html(obj.aprEmpId + " ");
				$('#aprName').html(obj.aprName + " - ");
				$('#aprRole').html(obj.aprRole);
				$('#timeupdate').html(moment(obj.time_update).format("D MMM YYYY"));
				$('#reason_s').html(obj.reason);

				if (obj.leave_status_id == '1') {
					// Approved
					$('#leavestatus').html("Approved").removeClass().addClass('badge badge-light-success');
					$('#status_title').html("Approver").removeClass('text-danger').addClass('text-primary');

				} else if (obj.leave_status_id == '2') {
					// Reject
					$('#leavestatus').html("Reject").removeClass().addClass('badge badge-light-danger');
					$('#status_title').html("Approver").removeClass('text-danger').addClass('text-primary');

				} else if (obj.leave_status_id == '3') {
					// Cancel
					$('#leavestatus').html("Cancel").removeClass().addClass('badge badge-light-dark');
					$('#status_title').html("Cancel").removeClass('text-primary').addClass('text-danger');
				}
			}
		},
		error: function () {
			alert("Error retrieving leave detail.");
		}
	});
} 
</script>

