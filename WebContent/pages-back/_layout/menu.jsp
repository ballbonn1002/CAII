<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.cubesofttech.system.Constant"%>

<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>

<%
String token = (String) session.getAttribute("token"); // ดึง token ที่สร้างไว้หลัง login
String targetURL = Constant.getWebContext2() + "/authorization?token=" + token;
%>

<!--begin::Sidebar-->
<div id="kt_app_sidebar" class="app-sidebar flex-column"
	data-kt-drawer="true" data-kt-drawer-name="app-sidebar"
	data-kt-drawer-activate="{default: true, lg: false}"
	data-kt-drawer-overlay="true" data-kt-drawer-width="225px"
	data-kt-drawer-direction="start"
	data-kt-drawer-toggle="#kt_app_sidebar_mobile_toggle">
	<!--begin::Logo-->
	<div class="app-sidebar-logo px-6" id="kt_app_sidebar_logo">
		<!--begin::Logo image-->
		<a href="check_in_out"> <img alt="Logo"
			src="assets/media/logos/Logo2.png"
			class="h-50px app-sidebar-logo-default theme-light-show" /> <img
			alt="Logo" src="assets/media/logos/logo2-w.png"
			class="h-50px app-sidebar-logo-default theme-dark-show" /> <img
			alt="Logo" src="assets/media/logos/cube-small-ico.ico"
			class="h-40px app-sidebar-logo-minimize" />
		</a>
		<!--end::Logo image-->
		<!--begin::Sidebar toggle-->
		<!--begin::Minimized sidebar setup:
            if (isset($_COOKIE["sidebar_minimize_state"]) && $_COOKIE["sidebar_minimize_state"] === "on") { 
                1. "src/js/layout/sidebar.js" adds "sidebar_minimize_state" cookie value to save the sidebar minimize state.
                2. Set data-kt-app-sidebar-minimize="on" attribute for body tag.
                3. Set data-kt-toggle-state="active" attribute to the toggle element with "kt_app_sidebar_toggle" id.
                4. Add "active" class to to sidebar toggle element with "kt_app_sidebar_toggle" id.
            }
        -->
		<div id="kt_app_sidebar_toggle"
			class="app-sidebar-toggle btn btn-icon btn-shadow btn-sm btn-color-muted btn-active-color-primary h-30px w-30px position-absolute top-50 start-100 translate-middle rotate"
			data-kt-toggle="true" data-kt-toggle-state="active"
			data-kt-toggle-target="body"
			data-kt-toggle-name="app-sidebar-minimize">
			<i class="ki-outline ki-black-left-line fs-3 rotate-180"></i>
		</div>
		<!--end::Sidebar toggle-->
	</div>
	<!--end::Logo-->
	<!--begin::sidebar menu-->
	<div class="app-sidebar-menu overflow-hidden flex-column-fluid">
		<!--begin::Menu wrapper-->
		<div id="kt_app_sidebar_menu_wrapper" class="app-sidebar-wrapper">
			<!--begin::Scroll wrapper-->
			<div id="kt_app_sidebar_menu_scroll" class="scroll-y my-5 mx-3"
				data-kt-scroll="true" data-kt-scroll-activate="true"
				data-kt-scroll-height="auto"
				data-kt-scroll-dependencies="#kt_app_sidebar_logo, #kt_app_sidebar_footer"
				data-kt-scroll-wrappers="#kt_app_sidebar_menu"
				data-kt-scroll-offset="5px" data-kt-scroll-save-state="true">
				<!--begin::Menu-->
				<div
					class="menu menu-column menu-rounded menu-sub-indention fw-semibold fs-6"
					id="#kt_app_sidebar_menu" data-kt-menu="true"
					data-kt-menu-expand="false">

					<!--begin:Menu item-->
					<div class="menu-item">
						<a class="menu-link" href="<%=targetURL%>" data-route="#"> <span
							class="menu-icon"> <i class="ki-solid ki-pin fs-1"></i>
						</span> <span class="menu-title">CA Old Version</span>
						</a>
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<!-- 	<div class="menu-item">
						<a class="menu-link" href="#" data-route="#"> <span
							class="menu-icon"> <i
								class="ki-duotone ki-element-11 fs-1"> <span class="path1"></span>
									<span class="path2"></span> <span class="path3"></span> <span
									class="path4"></span></i>
						</span> <span class="menu-title">Dashboards</span>
						</a>
					</div> -->
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<a class="menu-link" href="announcementList"
							data-route="announcementList"> <span class="menu-icon">
								<i class="ki-duotone ki-calendar fs-1"> <span class="path1"></span>
									<span class="path2"></span></i>
						</span> <span class="menu-title">Announcement</span> <i
							class="ki-duotone ki-check-circle fs-3 text-success"> <span
								class="path1"></span><span class="path2"></span>
						</i>
						</a>
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item pt-5">
						<!--begin:Menu content-->
						<div class="menu-content">
							<span class="menu-heading fw-bold text-uppercase fs-7">Cube
								Management</span>
						</div>
						<!--end:Menu content-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<a class="menu-link" href="check_in_out" data-route="check_in_out">
							<span class="menu-icon"> <i
								class="ki-duotone ki-time fs-1"> <span class="path1"></span>
									<span class="path2"></span>
							</i>
						</span> <span class="menu-title">Check In / Check Out</span> <i
							class="ki-duotone ki-check-circle fs-3 text-success"> <span
								class="path1"></span><span class="path2"></span>
						</i>
						</a>
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<a class="menu-link" href="Calendar_Checklist"
							data-route="checkAllCalendar"> <span class="menu-icon">
								<i class="ki-duotone ki-calendar fs-1"> <span class="path1"></span>
									<span class="path2"></span></i>
						</span> <span class="menu-title">Calendar & Check List</span> <i
							class="ki-duotone ki-check-circle fs-3 text-success"> <span
								class="path1"></span><span class="path2"></span>
						</i>
						</a>
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<!-- <div class="menu-item">
						<a class="menu-link" href="#" data-route="#"> <span class="menu-icon">
								<i class="ki-duotone ki-calendar-tick fs-1"> <span
									class="path1"></span> <span class="path2"></span> <span
									class="path3"></span> <span class="path4"></span> <span
									class="path5"></span> <span class="path6"></span>
							</i>
						</span> <span class="menu-title">Check List</span>
						</a>
					</div> -->
					<!--end:Menu item-->

					<!--My Leave-->
					<div class="menu-item">
						<a class="menu-link" href="new_myleave_list?Id=${onlineUser.id}"
							data-route="new_myleave_list"> <span class="menu-icon">
								<i class="ki-duotone ki-pulse fs-1"> <span class="path1"></span>
									<span class="path2"></span>
							</i>
						</span> <span class="menu-title">My Leave</span> <i
							class="ki-duotone ki-check-circle fs-3 text-success"> <span
								class="path1"></span><span class="path2"></span>
						</i>
						</a>
					</div>
					<!--My Leave-->

					<!-- TimeSheet -->

					<div class="menu-item">
						<a class="menu-link" href="timeSheet" data-route="time_sheet"><span
							class="menu-icon "> <i
								class="ki-duotone ki-calendar-8 fs-2"> <span class="path1"></span>
									<span class="path2"></span> <span class="path3"></span> <span
									class="path4"></span> <span class="path5"></span> <span
									class="path6"></span>
							</i>
						</span> <span class="menu-title">TimeSheet</span> <i
							class="ki-duotone ki-check-circle fs-3 text-success"> <span
								class="path1"></span><span class="path2"></span>
						</i> </a>
					</div>
					<!--TimeSheet -->

					<!--begin:Menu item-->
					<div class="menu-item">
						<a class="menu-link" href="my_jobsite?Id=${onlineUser.id}"
							data-route="my_jobsite"> <span class="menu-icon"> <i
								class="ki-duotone ki-map fs-1"> <span class="path1"></span>
									<span class="path2"></span> <span class="path3"></span>
							</i>
						</span> <span class="menu-title">My Job Site</span> <i
							class="ki-duotone ki-check-circle fs-3 text-success"> <span
								class="path1"></span><span class="path2"></span>
						</i>
						</a>
					</div>

					<!-- Overtime Request -->
					<div class="menu-item">
						<a class="menu-link"
							href="overtime_request_list?userId=${onlineUser.id}"
							data-route="overtime_request_list"> <span class="menu-icon">
								<i class="ki-duotone ki-timer fs-1"> <span class="path1"></span>
									<span class="path2"></span> <span class="path3"></span>
							</i>
						</span> <span class="menu-title">Overtime Request</span> <i
							class="ki-duotone ki-check-circle fs-3 text-success"> <span
								class="path1"></span><span class="path2"></span>
						</i>
						</a>
					</div>
					<!-- Overtime Request -->

					<!--end:Menu item-->
					<!--begin:Menu item-->
					<!-- <div class="menu-item">
						<a class="menu-link" href="#" data-route="#">
							<span class="menu-icon"> <i
								class="ki-duotone ki-timer fs-1"> <span class="path1"></span>
									<span class="path2"></span> <span class="path3"></span>
							</i>
						</span> <span class="menu-title">My OT</span>
						</a>
					</div> -->
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<a class="menu-link" href="my_travel" data-route="my_travel">
							<span class="menu-icon"> <i
								class="ki-duotone ki-delivery-time fs-1"> <span
									class="path1"></span> <span class="path2"></span> <span
									class="path3"></span> <span class="path4"></span> <span
									class="path5"></span>
							</i>
						</span> <span class="menu-title">My Travel</span>
						</a>
					</div>
					<!--end:Menu item-->

					<!--begin:Menu item-->
					<div class="menu-item pt-5">
						<!--begin:Menu content-->
						<div class="menu-content">
							<span class="menu-heading fw-bold text-uppercase fs-7">Admin
								Management</span>
						</div>
						<!--end:Menu content-->
					</div>
					<!--end:Menu item-->
					<perm:permission object="user.view">
						<!--begin:Menu item-->
						<div class="menu-item">
							<!--begin:Menu link-->
							<a class="menu-link" href="user-list" data-route="user-list">
								<span class="menu-icon"> <i
									class="ki-duotone ki-user-square fs-1"> <span class="path1"></span>
										<span class="path2"></span> <span class="path3"></span>
								</i>
							</span> <span class="menu-title">Employee Profile</span> <i
								class="ki-duotone ki-check-circle fs-3 text-success"> <span
									class="path1"></span><span class="path2"></span>
							</i>
							</a>
							<!--end:Menu link-->
						</div>
						<!--end:Menu item-->
					</perm:permission>
					<!--begin:Menu item-->
					<!-- <div class="menu-item">
						begin:Menu link
						<a class="menu-link" href="#" data-route="#"> <span class="menu-icon">
								<i class="ki-duotone ki-watch fs-1"> <span class="path1"></span>
									<span class="path2"></span>
							</i>
						</span> <span class="menu-title">Check In - Approve</span>
						</a>
						end:Menu link
					</div> -->
					<!--end:Menu item-->

					<!--Work Log-->
					<perm:permission object="report.view">
						<div class="menu-item">
							<a class="menu-link" href="work_log" data-route="work_log"> <span
								class="menu-icon"> <i class="ki-duotone ki-time fs-1">
										<span class="path1"></span> <span class="path2"></span>
								</i>
							</span> <span class="menu-title"> Work Log </span> <i
								class="ki-duotone ki-check-circle fs-3 text-success"> <span
									class="path1"></span><span class="path2"></span>
							</i>
							</a>
						</div>
					</perm:permission>
					<!--Work Log-->

					<!--Leave Approve-->
					<perm:permission object="leave.approve">
						<div class="menu-item">
							<a class="menu-link" href="new_leave_approved"
								data-route="new_leave_approved"> <span class="menu-icon">
									<i class="ki-duotone ki-pulse fs-1"> <span class="path1"></span>
										<span class="path2"></span>
								</i>
							</span> <span class="menu-title"> Leave Approve </span> <i
								class="ki-duotone ki-check-circle fs-3 text-success"> <span
									class="path1"></span><span class="path2"></span>
							</i>
							</a>
						</div>
					</perm:permission>
					<!--Leave Approve-->

					<!-- Overtime Approve -->
					<perm:permission object="leave.approve">
						<div class="menu-item">
							<a class="menu-link" href="overtime_approve"
								data-route="overtime_approve"> <span class="menu-icon">
									<i class="ki-duotone ki-timer fs-1"> <span class="path1"></span>
										<span class="path2"></span> <span class="path3"></span>
								</i>
							</span> <span class="menu-title">Overtime Approve</span> <i
								class="ki-duotone ki-check-circle fs-3 text-success"> <span
									class="path1"></span><span class="path2"></span>
							</i>
							</a>
						</div>
					</perm:permission>
					<!-- Overtime Approve -->

					<!--begin:Menu item-->
					<perm:permission object="dailymonitor.view">
						<div class="menu-item">
							<a class="menu-link" href="dailyMonitor"
								data-route="dailyMonitor"> <span class="menu-icon"> <i
									class="ki-duotone ki-calendar-tick fs-1"> <span
										class="path1"></span> <span class="path2"></span> <span
										class="path3"></span> <span class="path4"></span> <span
										class="path5"></span> <span class="path6"></span>
								</i>
							</span> <span class="menu-title"> Daily Monitor </span>
							</a>
						</div>
					</perm:permission>
					<!--end:Menu item-->

					<!--begin:Menu item-->
					<div class="menu-item">
						<a class="menu-link" href="travel_approve"
							data-route="travel_approve"> <span class="menu-icon">
								<i class="ki-duotone ki-delivery-time fs-1"> <span
									class="path1"></span> <span class="path2"></span> <span
									class="path3"></span> <span class="path4"></span> <span
									class="path5"></span>
							</i>
						</span> <span class="menu-title">Travel Approve</span>
						</a>
					</div>
					<!--end:Menu item-->

					<!--begin:Menu item-->
					<!-- <div class="menu-item">
						begin:Menu link
						<a class="menu-link" href="#" data-route="#">
							<span class="menu-icon"> <i
								class="ki-duotone ki-timer fs-1"> <span class="path1"></span>
									<span class="path2"></span> <span class="path3"></span>
							</i>
						</span> <span class="menu-title">OT Approve</span>
						</a>
						end:Menu link
					</div> -->
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<!-- <div class="menu-item">
						begin:Menu link
						<a class="menu-link" href="#" data-route="#"> <span class="menu-icon">
								<i class="ki-duotone ki-delivery-time fs-1"> <span
									class="path1"></span> <span class="path2"></span> <span
									class="path3"></span> <span class="path4"></span> <span
									class="path5"></span>
							</i>
						</span> <span class="menu-title">Travel Approve</span>
						</a>
						end:Menu link
					</div> -->
					<!--end:Menu item-->
					<perm:permission object="equipmentlist.view">
						<!--begin:Menu item-->
						<div class="menu-item pt-5">
							<!--begin:Menu content-->
							<div class="menu-content">
								<span class="menu-heading fw-bold text-uppercase fs-7">Borrow</span>
							</div>
							<!--end:Menu content-->
						</div>
						<!--end:Menu item-->
						<!--begin:Menu item-->
						<div class="menu-item">
							<!--begin:Menu link-->
							<a class="menu-link" href="equipment_list"
								data-route="equipment_list"> <span class="menu-icon">
									<i class="ki-duotone ki-monitor-mobile fs-1"> <span
										class="path1"></span> <span class="path2"></span>
								</i>
							</span> <span class="menu-title">Equipment</span> <i
								class="ki-duotone ki-check-circle fs-3 text-success"> <span
									class="path1"></span><span class="path2"></span>
							</i>
							</a>
							<!--end:Menu link-->
						</div>
					</perm:permission>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<perm:permission object="borrow.view">
						<div class="menu-item">
							<!--begin:Menu link-->
							<a class="menu-link" href="borrow_list" data-route="borrow_list">
								<span class="menu-icon"> <i
									class="ki-duotone ki-delivery-3 fs-1"> <span class="path1"></span>
										<span class="path2"></span> <span class="path3"></span>
								</i>
							</span> <span class="menu-title">Borrow</span> <i
								class="ki-duotone ki-check-circle fs-3 text-success"> <span
									class="path1"></span><span class="path2"></span>
							</i>
							</a>
							<!--end:Menu link-->
						</div>
					</perm:permission>
					<!--end:Menu item-->

					<perm:permission object="master.view">
						<!--begin:Menu item-->
						<div class="menu-item pt-5">
							<!--begin:Menu content-->
							<div class="menu-content">
								<span class="menu-heading fw-bold text-uppercase fs-7">Master</span>
							</div>
							<!--end:Menu content-->
						</div>
						<!--end:Menu item-->
						<!--begin:Menu item-->
						<div class="menu-item">
							<!--begin:Menu link-->
							<a class="menu-link" href="position_list"
								data-route="position_list"> <span class="menu-icon">
									<i class="ki-duotone ki-monitor-mobile fs-1"> <span
										class="path1"></span> <span class="path2"></span>
								</i>
							</span> <span class="menu-title">Position</span> <i
								class="ki-duotone ki-check-circle fs-3 text-success"> <span
									class="path1"></span><span class="path2"></span>
							</i>
							</a>
							<!--end:Menu link-->
						</div>
						<!--end:Menu item-->
						<!--begin:Menu item-->
						<div class="menu-item">
							<!--begin:Menu link-->
							<a class="menu-link" href="department_list"
								data-route="department_list"> <span class="menu-icon">
									<i class="ki-duotone ki-monitor-mobile fs-1"> <span
										class="path1"></span> <span class="path2"></span>
								</i>
							</span> <span class="menu-title">Department</span> <i
								class="ki-duotone ki-check-circle fs-3 text-success"> <span
									class="path1"></span><span class="path2"></span>
							</i>
							</a>
							<!--end:Menu link-->
						</div>
						<!--end:Menu item-->
						<!--begin:Menu item-->
						<div class="menu-item">
							<!--begin:Menu link-->
							<a class="menu-link" href="jobsite_list"
								data-route="jobsite_list"> <span class="menu-icon"> <i
									class="ki-duotone ki-monitor-mobile fs-1"> <span
										class="path1"></span> <span class="path2"></span>
								</i>
							</span> <span class="menu-title">Job Site</span> <i
								class="ki-duotone ki-check-circle fs-3 text-success"> <span
									class="path1"></span><span class="path2"></span>
							</i>
							</a>
							<!--end:Menu link-->
						</div>
						<!--end:Menu item-->
						<!--begin:Menu item-->
						<div class="menu-item">
							<!--begin:Menu link-->
							<a class="menu-link" href="leave_type_list"> <span
								class="menu-icon"> <i
									class="ki-duotone ki-monitor-mobile fs-1"> <span
										class="path1"></span> <span class="path2"></span>
								</i>
							</span> <span class="menu-title">Leave Type</span> <i
								class="ki-duotone ki-check-circle fs-3 text-success"> <span
									class="path1"></span><span class="path2"></span>
							</i>
							</a>
							<!--end:Menu link-->
						</div>
						<!--end:Menu item-->


						<!--begin:Menu item-->
						<div class="menu-item">
							<!--begin:Menu link-->
							<a class="menu-link " data-route="holiday_list"
								href="holiday_list"> <span class="menu-icon"> <i
									class="ki-duotone ki-delivery-3 fs-1"> <span class="path1"></span>
										<span class="path2"></span> <span class="path3"></span>
								</i>
							</span> <span class="menu-title">Holiday</span> <i
								class="ki-duotone ki-check-circle fs-3 text-success"> <span
									class="path1"></span><span class="path2"></span>
							</i>
							</a>
							<!--end:Menu link-->
						</div>
						<!--end:Menu item-->
					</perm:permission>

					<!--begin:Menu Authority-->
					<div class="menu-item pt-5">
						<div class="menu-content">
							<span class="menu-heading fw-bold text-uppercase fs-7">Authority</span>
						</div>
					</div>

					<!--Role Management-->
					<perm:permission object="role.view">
						<div class="menu-item">
							<a class="menu-link" href="role-list" data-route="role-list">
								<span class="menu-icon"> <i
									class="ki-duotone ki-security-user fs-1"> <span
										class="path1"></span> <span class="path2"></span>
								</i>
							</span> <span class="menu-title"> Role Management </span> <i
								class="ki-duotone ki-check-circle fs-3 text-success"> <span
									class="path1"></span><span class="path2"></span>
							</i>
							</a>
						</div>
					</perm:permission>
					<!--Role Management-->
					<!--end:Menu Authority-->

					<!--begin:Menu item-->
					<div class="menu-item pt-5">
						<!--begin:Menu content-->
						<div class="menu-content">
							<span class="menu-heading fw-bold text-uppercase fs-7">CMS</span>
						</div>
						<!--end:Menu content-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<a class="menu-link" href="/article_feed" data-route="#"> <span
							class="menu-icon"> <i class="ki-duotone ki-book-open fs-1">
									<span class="path1"></span> <span class="path2"></span> <span
									class="path3"></span> <span class="path4"></span>
							</i>
						</span> <span class="menu-title">Article</span>
						</a>
					</div>

					<!--end:Menu item-->

					<!--begin:Menu item-->
					<div class="menu-item">
						<a class="menu-link" href="/page_uri_list" data-route="#"> <span
							class="menu-icon"> <i class="ki-duotone ki-setting-2 fs-1">
									<span class="path1"></span> <span class="path2"></span>
							</i>
						</span> <span class="menu-title">Page URL</span>
						</a>
					</div>

					<!--end:Menu item-->

					<!--begin:Menu item-->
					<!-- <div class="menu-item">
						begin:Menu link
						<a class="menu-link" href="#" data-route="#">
							<span class="menu-icon"> 
							<i class="ki-duotone ki-user-square fs-1"> 
								<span class="path1"></span><span class="path2"></span> <span class="path3"></span>
							</i>
						</span> <span class="menu-title">Careers</span>
						</a>
						end:Menu link
					</div> -->
					<!--end:Menu item-->

					<!--begin:Menu item-->
					<div class="menu-item pt-5">
						<!--begin:Menu content-->
						<div class="menu-content">
							<span class="menu-heading fw-bold text-uppercase fs-7">Report</span>
						</div>
						<!--end:Menu content-->
					</div>
					<!--Report-->
					<perm:permission object="report.view">
						<div class="menu-item">
							<a class="menu-link" href="report" data-route="report"> <span
								class="menu-icon"> <i
									class="ki-duotone ki-chart-pie-3 fs-1"> <span class="path1"></span><span
										class="path2"></span><span class="path3"></span> <span
										class="path2"></span>
								</i>
							</span> <span class="menu-title">Report</span>
							</a>
						</div>
					</perm:permission>
					<!--Report-->

					<!--begin:Menu item-->
					<div class="menu-item pt-5">
						<!--begin:Menu content-->
						<div class="menu-content">
							<span class="menu-heading fw-bold text-uppercase fs-7">Exit</span>
						</div>
						<!--end:Menu content-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<a class="menu-link" href="signout" data-route="#"> <span
							class="menu-icon"> <i class="ki-duotone ki-exit-left fs-1">
									<span class="path1"></span><span class="path2"></span>
							</i>
						</span> <span class="menu-title">Log Out</span>
						</a>
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item pt-5">
						<!--begin:Menu content-->
						<div class="menu-content">
							<span class="menu-heading fw-bold text-uppercase fs-7">Pages
								(Demo)</span>
						</div>
						<!--end:Menu content-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div data-kt-menu-trigger="click" class="menu-item menu-accordion">
						<!--begin:Menu link-->
						<span class="menu-link"> <span class="menu-icon"> <i
								class="ki-outline ki-address-book fs-2"></i>
						</span> <span class="menu-title">Demo</span> <span class="menu-arrow"></span>
						</span>
						<!--end:Menu link-->
						<!--begin:Menu sub-->
						<div class="menu-sub menu-sub-accordion">

							<!--begin:Menu item-->
							<div class="menu-item">
								<!--begin:Menu link-->
								<a class="menu-link" href="blank_template"
									data-route="blank_template"> <span class="menu-icon">
										<span class="bullet bullet-dot"></span>
								</span> <span class="menu-title">Blank Template</span>
								</a>
								<!--end:Menu link-->
							</div>
							<!--end:Menu item-->
							<!--begin:Menu item-->
							<div class="menu-item">
								<!--begin:Menu link-->
								<a class="menu-link" href="demo_dashboard"
									data-route="demo_dashboard"> <span class="menu-icon">
										<span class="bullet bullet-dot"></span>
								</span> <span class="menu-title">Dashboards</span>
								</a>
								<!--end:Menu link-->
							</div>
							<!--end:Menu item-->
							<!--begin:Menu item-->
							<div class="menu-item">
								<!--begin:Menu link-->
								<a class="menu-link" data-route="demo_table" href="demo_table">
									<span class="menu-icon"> <span class="bullet bullet-dot"></span>
								</span> <span class="menu-title">Table</span>
								</a>
								<!--end:Menu link-->
							</div>
							<!--end:Menu item-->
							<!--begin:Menu item-->
							<div class="menu-item">
								<!--begin:Menu link-->
								<a class="menu-link" href="demo_add_holiday"> <span
									class="menu-icon"> <span class="bullet bullet-dot"></span>
								</span> <span class="menu-title">Holiday Add</span>
								</a>
								<!--end:Menu link-->
							</div>
							<!--end:Menu item-->
						</div>
						<!--end:Menu sub-->
					</div>
					<!--end:Menu item-->
				</div>
				<!--end::Menu-->
			</div>
			<!--end::Scroll wrapper-->
		</div>
		<!--end::Menu wrapper-->
	</div>
	<!--end::sidebar menu-->
</div>
<!--end::Sidebar-->

<script type="text/javascript">
	$(function(){
	  var cur = (location.pathname.split('/').pop() || 'index')
	              .replace(/\.(jsp|action|html|php)$/i,'');
	  
	  $('a.menu-link[data-route]').each(function(){
	    var list = $(this).data('route').toString().split(',');
	    if (list.some(s => new RegExp('^' + s.trim() + '$', 'i').test(cur))) {
	      $(this).addClass('active')
	             .closest('.menu-item, li').addClass('active')
	             .parents('.menu-accordion,.menu-sub').addClass('show here');
	    }
	  });
	});
</script>
