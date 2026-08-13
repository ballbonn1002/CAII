<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!--begin::Content-->
<div id="kt_app_content" class="app-content flex-column-fluid">
	<!--begin::Content container-->
	<div id="kt_app_content_container" class="app-container container-fluid">
		<div class="card">
			<!--begin::Header-->
			<div class="card-header d-flex flex-column align-items-start justify-content-center bgi-no-repeat bgi-size-cover rounded-top border-0 min-h-100px"
				style="background-image:url('assets/media/misc/menu-header-bg.jpg')">
				<h3 class="card-title text-white fw-semibold mb-0">${notification.title}</h3>
			</div>
			<!--end::Header-->
			<div class="card-body">
				<div id="kt_notification_detail_row"></div>
			</div>
		</div>
	</div>
	<!--end::Content container-->
</div>
<!--end::Content-->

<div id="kt_notification_data" class="d-none"><c:out value="${notification.message}" /></div>
<div id="kt_notification_time_create" class="d-none"><fmt:formatDate value="${notification.timeCreate}" pattern="yyyy-MM-dd'T'HH:mm:ss" /></div>

<script>
$(document).ready(function () {
	var MONTH_ABBR = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];

	// leave_type_id -> icon/color, mirrors header.jsp notification list rendering
	var LEAVE_TYPE_ICON = {
		"1" : { icon : "ki-airplane", paths : 2, bg : "bg-light-success", color : "text-success" },
		"2" : { icon : "ki-car-2", paths : 6, bg : "bg-light-primary", color : "text-primary" },
		"3" : { icon : "ki-pulse", paths : 2, bg : "bg-light-info", color : "text-info" },
		"4" : { icon : "ki-calendar-remove", paths : 6, bg : "bg-light-danger", color : "text-danger" },
		"5" : { icon : "ki-brifecase-cros", paths : 3, bg : "bg-light-dark", color : "text-dark" },
		"6" : { icon : "ki-timer", paths : 3, bg : "bg-light-warning", color : "text-warning" },
		"7" : { icon : "ki-abstract-12", paths : 2, custom : true },
		"9" : { icon : "ki-abstract-12", paths : 2, custom : true }
	};
	var DEFAULT_ICON = { icon : "ki-notification-status", paths : 4, bg : "bg-light-primary", color : "text-primary" };

	function formatLongDate(dateStr) {
		if (!dateStr) return "";
		var d = new Date(dateStr + "T00:00:00");
		return d.getDate() + " " + MONTH_ABBR[d.getMonth()] + " " + d.getFullYear();
	}

	function notifTimeLabel(timeCreateStr) {
		if (!timeCreateStr) return "";
		var then = new Date(timeCreateStr);
		var now = new Date();
		var diffMin = Math.floor((now - then) / 60000);
		if (diffMin < 60) {
			return diffMin + " minutes";
		}
		var diffHour = Math.floor(diffMin / 60);
		if (diffHour < 24) {
			return diffHour + " hours";
		}
		var diffDay = Math.floor(diffHour / 24);
		if (diffDay < 7) {
			return diffDay + " days";
		}
		return then.getDate() + " " + MONTH_ABBR[then.getMonth()];
	}

	function buildIconHtml(typeInfo) {
		var pathSpans = "";
		for (var i = 1; i <= typeInfo.paths; i++) {
			pathSpans += '<span class="path' + i + '"></span>';
		}
		var wrapStyle = typeInfo.custom ? ' style="background-color:#4B5675;"' : '';
		var iconStyle = typeInfo.custom ? ' style="color:#FFFFFF;"' : '';
		var bgClass = typeInfo.custom ? '' : typeInfo.bg;
		var colorClass = typeInfo.custom ? '' : typeInfo.color;
		return '<div class="symbol symbol-35px mb-1">'
			+ '<span class="symbol-label ' + bgClass + '"' + wrapStyle + '>'
			+ '<i class="ki-duotone ' + typeInfo.icon + ' fs-3 ' + colorClass + '"' + iconStyle + '>' + pathSpans + '</i>'
			+ '</span>'
			+ '</div>';
	}

	var rawMessage = $("#kt_notification_data").text();
	var data = {};
	try {
		data = JSON.parse(rawMessage) || {};
	} catch (e) {
		data = {};
	}

	var typeInfo = LEAVE_TYPE_ICON[String(data.leaveTypeId)] || DEFAULT_ICON;
	var titleText = data.leaveTypeName || "${notification.title}";

	var statusBadge = "";
	if (data.status) {
		var statusClass = data.status === "Approve" ? "badge-light-success" : "badge-light-danger";
		statusBadge = ' <span class="badge ' + statusClass + ' fs-8">' + data.status + '</span>';
	}

	var dateRow = "";
	if (data.startDate && data.endDate) {
		dateRow = '<div class="text-gray-500 fs-7">' + formatLongDate(data.startDate) + ' - ' + formatLongDate(data.endDate) + '</div>';
	}

	var timeCreateStr = $("#kt_notification_time_create").text().trim();

	var $row = $('<div class="d-flex flex-stack py-4"></div>');
	$row.append(
		'<div class="d-flex align-items-center gap-2">'
			+ buildIconHtml(typeInfo)
			+ '<div>'
				+ '<div class="mb-0 me-2">'
				+ '<span class="fs-6 text-gray-800 fw-bold">' + titleText + '</span>' + statusBadge
				+ dateRow
				+ '</div>'
			+ '</div>'
		+ '</div>'
		+ '<div class="d-flex flex-column align-items-center">'
		+ '<span class="badge badge-light fs-8">' + notifTimeLabel(timeCreateStr) + '</span>'
		+ '</div>'
	);
	$("#kt_notification_detail_row").append($row);
});
</script>
