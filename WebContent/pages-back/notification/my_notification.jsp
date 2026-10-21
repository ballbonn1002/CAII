<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!--begin::Content-->
<div id="kt_app_content" class="app-content flex-column-fluid">
	<!--begin::Content container-->
	<div id="kt_app_content_container" class="app-container container-fluid">
		<div class="card">
			<div class="card-header align-items-center">
				<h3 class="card-title">My Notification</h3>
				<div class="card-toolbar">
					<button type="button" id="kt_notification_read_all" class="btn btn-sm btn-outline btn-outline-primary btn-active-light-primary fw-semibold">
						<i class="ki-solid ki-questionnaire-tablet fs-4"></i>
						Read All
					</button>
				</div>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table id="kt_datatable_notification" class="table table-row-bordered gy-3 align-middle">
						<thead>
							<tr class="fw-bold fs-7 text-gray-500 text-uppercase">
								<th class="w-75px text-center">#</th>
								<th class="min-w-200px">Title</th>
								<th class="min-w-100px">ID</th>
								<th class="min-w-250px">Message</th>
								<th class="min-w-125px">Status</th>
								<th class="min-w-150px text-end">Date</th>
								<th class="w-100px text-center">Read</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${notificationList}" var="n" varStatus="loop">
								<tr class="js-notif-row" data-id="${n.id}" data-title="<c:out value='${n.title}'/>" data-function-id="${n.functionId}" data-user-id="${n.userId}" style="cursor: pointer;">
									<td class="text-center fw-semibold">
										<c:if test="${n.typeSending == 'A'}">
											<i class="ki-duotone ki-verify fs-1 text-success js-notif-icon">
												<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span>
											</i>
										</c:if>
										<c:if test="${n.typeSending == 'U'}">
											<i class="ki-duotone ki-profile-circle fs-1 text-gray-500 js-notif-icon">
												<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span>
											</i>
										</c:if>
									</td>
									<td>
										<div class="d-flex align-items-center js-notif-title">
											<span class="d-none js-notif-raw"><c:out value="${n.message}" /></span>
											<div class="symbol symbol-35px me-3">
												<span class="symbol-label bg-light-primary js-notif-icon-wrap">
													<i class="ki-duotone ki-notification-status fs-3 text-primary js-notif-icon">
														<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span>
													</i>
												</span>
											</div>
											 <div class="d-flex flex-column">
											 		<span class="fw-bold text-gray-800 fs-6 js-notif-typename"></span>
											 		<span class="text-gray-600 fs-7">${n.title}</span>
											 </div>
											 <div class="symbol symbol-35px ms-3">
											 	
											 </div>
										</div>
									</td>
									<td><span class="badge badge-light-primary fs-7 fw-semibold">#${n.functionId}</span></td>
									<td class="text-gray-600 fs-7">
										<span class="d-none js-msg-raw"><c:out value="${n.message}" /></span>
										<div class="js-msg-dates fw-semibold text-gray-800"></div>
										<c:if test="${not empty n.description}">
											<div class="d-flex align-items-center text-gray-600">
												<i class="ki-duotone ki-document fs-6 text-gray-500 me-1">
													<span class="path1"></span><span class="path2"></span>
												</i>
												<span><c:out value="${n.description}" /></span>
											</div>
										</c:if>
										<c:if test="${n.title ne 'My Leave' and n.title ne 'Announcement' and not empty actorMap[n.userId]}">
											<div class="d-flex align-items-center mt-1">
												<i class="ki-duotone ki-user-square fs-6 text-gray-500 me-1">
													<span class="path1"></span><span class="path2"></span><span class="path3"></span>
												</i>
												<span class="text-black"><c:out value="${actorMap[n.userId]}" /></span>
											</div>
										</c:if>
										<c:if test="${n.title eq 'Announcement'}">
											<div class="d-flex align-items-center mt-1">
												<i class="ki-duotone ki-document fs-6 text-gray-500 me-1">
													<span class="path1"></span><span class="path2"></span><span class="path3"></span>
												</i>
												<span class="text-black one-line-text"><c:out value="${n.topic}" /></span>
											</div>
											<div>
												<span class="d-none js-detail-raw"><c:out value="${n.detail}" escapeXml="false" /></span>
												<span class="d-block text-truncate js-detail-text" style="max-width: 200px;"></span>
											</div>
										</c:if>
										<c:if test="${n.title eq 'My Travel' or n.title eq 'Travel Approve'}">
											<div class="d-flex align-items-center mt-1">
												<i class="ki-duotone ki-dollar fs-6 text-gray-500 me-1">
													<span class="path1"></span><span class="path2"></span><span class="path3"></span>
												</i>
												<span class="text-black js-expense-amount" id="expense_amount"></span>
											</div>
										</c:if>
									</td>
									<td>
										<span class="badge badge-light-primary fs-7 js-notif-status"></span>
									</td>
									<td class="text-end fw-semibold text-gray-800 fs-7"><fmt:formatDate value="${n.timeCreate}" pattern="dd MMM yyyy HH:mm" /></td>
									<td class="text-center">
										<c:if test="${not n.isRead}">
											<span class="bullet bullet-dot bg-danger" title="Unread"></span>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!--end::Content container-->
</div>
<!--end::Content-->

<script>
$(document).ready(function () {
	// Icon (duotone) mapping keyed by the "typeName" value stored in notification.message JSON
	var TYPE_ICON = {
		"ลากิจ"            : { icon : "ki-car-2",          paths : 6, bg : "bg-light-primary", color : "text-primary" },
		"ลาพักร้อน"        : { icon : "ki-airplane",        paths : 2, bg : "bg-light-warning", color : "text-warning" },
		"ลาป่วย"           : { icon : "ki-pulse",           paths : 2, bg : "bg-light-info",    color : "text-info" },
		"Equipment"        : { icon : "ki-monitor-mobile",  paths : 5, bg : "bg-light-primary", color : "text-primary" },
		"Material Request" : { icon : "ki-delivery-3",      paths : 5, bg : "bg-light-success", color : "text-success" },
		"เบิกค่าเดินทาง"           : { icon : "ki-car-2",           paths : 6, bg : "bg-light-success", color : "text-success" },
		"Announcement"       : { icon : "ki-notification-status", paths : 6, bg : "bg-light-danger", color : "text-danger" },
	};
	var DEFAULT_ICON = { icon : "ki-notification-status", paths : 4, bg : "bg-light-primary", color : "text-primary" };

	$(".js-notif-title").each(function () {
		var $cell = $(this);
		var raw = $cell.find(".js-notif-raw").text().trim();

		var typeName = null;
		try {
			var data = JSON.parse(raw);
			if (data && data.typeName) {
				typeName = data.typeName;
			}
		} catch (e) {
			// message is not JSON, leave empty
		}

		$cell.find(".js-notif-typename").text(typeName == null ? "" : typeName);

		var info = (typeName != null && TYPE_ICON[typeName]) ? TYPE_ICON[typeName] : DEFAULT_ICON;
		var pathSpans = "";
		for (var i = 1; i <= info.paths; i++) {
			pathSpans += '<span class="path' + i + '"></span>';
		}
		$cell.find(".js-notif-icon-wrap")
			.removeClass("bg-light-primary bg-light-warning bg-light-info bg-light-success bg-light-danger")
			.addClass(info.bg);
		$cell.find(".js-notif-icon")
			.attr("class", "ki-duotone " + info.icon + " fs-3 " + info.color + " js-notif-icon")
			.html(pathSpans);
	});

	// Announcement detail ถูกเก็บเป็น HTML, ตัด tag ออกเหลือ plain text แล้วค่อยตัดให้เหลือบรรทัดเดียวด้วย CSS (one-line-text)
	$(".js-detail-text").each(function () {
		var $text = $(this);
		var html = $text.siblings(".js-detail-raw").html();
		var plainText = $("<div>").html(html).text().trim();
		$text.text(plainText);
	});

	// Format a "yyyy-MM-dd" string as "d MMM yyyy" (e.g. 2026-08-01 -> 1 Aug 2026),
	// appending ", HH:mm" when the string carries a time (e.g. "2026-08-01, 14:30" -> 1 Aug 2026, 14:30)
	var MONTH_ABBR = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];
	function fmtDate(str) {
		if (!str) return "";
		var trimmed = String(str).trim();
		var match = trimmed.match(/^(\d{4})-(\d{1,2})-(\d{1,2})(?:[,\sT]+(\d{1,2}):(\d{2}))?/);
		if (!match) return trimmed;
		var y = parseInt(match[1], 10);
		var m = parseInt(match[2], 10);
		var d = parseInt(match[3], 10);
		if (m < 1 || m > 12) return trimmed;
		var result = d + " " + MONTH_ABBR[m - 1] + " " + y;
		if (match[4] !== undefined) {
			var hh = match[4].length === 1 ? "0" + match[4] : match[4];
			result += ", " + hh + ":" + match[5];
		}
		return result;
	}

	// Message column line 1: "startDate - endDate" (or just startDate when endDate is empty), from message JSON
	$(".js-msg-dates").each(function () {
		var $line = $(this);
		var raw = $line.closest("td").find(".js-msg-raw").text().trim();
		var text = "";
		try {
			var data = JSON.parse(raw);
			if (data) {
				var s = data.startDate ? fmtDate(data.startDate) : "";
				var e = data.endDate ? fmtDate(data.endDate) : "";
				if (s && e) {
					text = s + " - " + e;
				} else if (s) {
					text = s;
				}
			}
		} catch (err) {
			// message is not JSON, leave empty
		}
		$line.text(text);
	});

	// Travel amount: "total_amount" from the message JSON, formatted as 1,234.50
	$(".js-expense-amount").each(function () {
		var $amount = $(this);
		var raw = $amount.closest("td").find(".js-msg-raw").text().trim();
		var text = "";
		try {
			var data = JSON.parse(raw);
			if (data && data.total_amount != null && data.total_amount !== "") {
				var num = parseFloat(data.total_amount);
				text = isNaN(num)
					? String(data.total_amount)
					: num.toLocaleString("en-US", { minimumFractionDigits : 2, maximumFractionDigits : 2 });
			}
		} catch (err) {
			// message is not JSON, leave empty
		}
		$amount.text(text);
	});

	// Status column: "status" value from the message JSON (danger for Reject, success for Approve)
	$(".js-notif-status").each(function () {
		var $badge = $(this);
		var raw = $badge.closest("tr").find(".js-msg-raw").text().trim();
		var status = "";
		try {
			var data = JSON.parse(raw);
			if (data && data.status) {
				status = String(data.status).trim();
			}
		} catch (err) {
			// message is not JSON, leave empty
		}

		$badge.removeClass("badge-light-danger badge-light-success badge-light-primary");
		if (!status) {
			$badge.addClass("d-none");
			return;
		}
		$badge.text(status);
		if (status === "Reject" || status === "Cancel") {
			$badge.addClass("badge-light-danger");
		} else if (status === "Approve" || status === "Confirm Received" || status === "Confirm Returned") {
			$badge.addClass("badge-light-success");
		} else if (status === "Wait for approve" || status === "Waiting Approve" || status === "Wait Confirm Received" || status === "Wait Returned") {
			$badge.addClass("badge-light-warning");
		} else if (status === "Paid") {
			$badge.addClass("badge-light-info");
		} else {
			$badge.addClass("badge-light-primary");
		}
	});

	$("#kt_datatable_notification").DataTable({
		pageLength: 25,
		order: [] // ไม่ sort ตอนโหลด ให้คงลำดับตามข้อมูลที่ Action ส่งมา
	});

	// Row click: open the page related to the notification's title in a new tab
	var NOTIF_ROUTES = {
		"My Leave" : function (id, functionId) {
			return "new_myleave_list?Id=" + encodeURIComponent(id)
				+ "&leaveId=" + encodeURIComponent(functionId);
		},
		"Leave Approve" : function (id, functionId) {
			return "new_leave_approved?leaveId=" + encodeURIComponent(functionId);
		},
		"My Travel" : function (id, functionId) {
			return "my_travel_group?expense_group_id=" + encodeURIComponent(functionId);
		},
		"Travel Approve" : function (id, functionId) {
			return "travel_approve_preview?expense_group_id=" + encodeURIComponent(functionId);
		},
		"Announcement" : function (id, functionId) {
			return "announcementRead?id=" + encodeURIComponent(functionId);
		},
		"My Borrow" : function (id, functionId) {
			return "my_profile?tab=borrow&borrowId=" + encodeURIComponent(functionId);
		},
		"Borrow" : function (id, functionId) {
			return "borrow_edit?id=" + encodeURIComponent(functionId);
		}
	};

	$("#kt_datatable_notification").on("click", "tbody tr.js-notif-row", function () {
		var $row = $(this);
		var id = $row.data("id");
		var title = $row.data("title") == null ? "" : String($row.data("title"));
		var functionId = $row.data("functionId");
		var userId = $row.data("userId");

		// mark this notification as read in the background
		$.get("notification_read?id=" + encodeURIComponent(id));

		var builder = NOTIF_ROUTES[title];
		var url = builder ? builder(userId, functionId) : ("notification_read?id=" + encodeURIComponent(id));
		window.open(url, "_blank");
	});

	$("#kt_notification_read_all").on("click", function () {
		$.ajax({
			url : "notification_read_all",
			method : "POST",
			success : function () {
				window.location.reload();
			},
			error : function () {
				console.log("Unable to mark notifications as read.");
			}
		});
	});
});
</script>
