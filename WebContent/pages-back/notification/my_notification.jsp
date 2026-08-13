<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!--begin::Content-->
<div id="kt_app_content" class="app-content flex-column-fluid">
	<!--begin::Content container-->
	<div id="kt_app_content_container" class="app-container container-fluid">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">My Notification</h3>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table id="kt_datatable_notification" class="table table-row-bordered gy-5 table-striped align-middle">
						<thead>
							<tr class="fw-bold fs-6 text-gray-800">
								<th>ID</th>
								<th>Title</th>
								<th>Message</th>
								<th>Description</th>
								<th>Read</th>
								<th>User</th>
								<th>Created By</th>
								<th>Updated By</th>
								<th>Created At</th>
								<th>Updated At</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${notificationList}" var="n">
								<tr onclick="window.location.href='notification_read?id=${n.id}'" style="cursor: pointer;">
									<td>${n.id}</td>
									<td>${n.title}</td>
									<td>${n.message}</td>
									<td>${n.description}</td>
									<td>${n.isRead ? 'Yes' : 'No'}</td>
									<td>${n.userId}</td>
									<td>${n.userCreate}</td>
									<td>${n.userUpdate}</td>
									<td><fmt:formatDate value="${n.timeCreate}" pattern="dd MMM yyyy HH:mm" /></td>
									<td><fmt:formatDate value="${n.timeUpdate}" pattern="dd MMM yyyy HH:mm" /></td>
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
	$("#kt_datatable_notification").DataTable();
});
</script>
