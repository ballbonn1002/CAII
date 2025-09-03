<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>


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
		<a href="index.html"> <img alt="Logo"
			src="assets/media/logos/default.svg"
			class="h-25px app-sidebar-logo-default theme-light-show" /> <img
			alt="Logo" src="assets/media/logos/default-dark.svg"
			class="h-25px app-sidebar-logo-default theme-dark-show" /> <img
			alt="Logo" src="assets/media/logos/default-small.svg"
			class="h-20px app-sidebar-logo-minimize" />
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
					<div class="menu-item menu-accordion">
						<!--begin:Menu link-->
						<span class="menu-link"> <span class="menu-icon"> <i
								class="ki-outline ki-element-11 fs-2"></i>
						</span> <span class="menu-title">Dashboards</span>
						</span>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item menu-accordion">
						<!--begin:Menu link-->
						<span class="menu-link"> 
							<span class="menu-icon"> 
								<i class="ki-duotone ki-calendar fs-2">
									<span class="path1"></span>
 									<span class="path2"></span></i>
							</span> 
							<span class="menu-title">Calendar</span>
						</span>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item menu-accordion">
						<!--begin:Menu link-->
						<span class="menu-link"> 
							<span class="menu-icon"> 
								<i class="ki-outline ki-element-11 fs-2"></i>
							</span> 
							<span class="menu-title">Announcement</span>
						</span>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					
					<!--begin:Menu item-->
					<div class="menu-item pt-5">
						<!--begin:Menu content-->
						<div class="menu-content">
							<span class="menu-heading fw-bold text-uppercase fs-7">Cube Management</span>
						</div>
						<!--end:Menu content-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="#">
							<span class="menu-icon"> 
								<i class="ki-duotone ki-time">
									<span class="path1"></span>
									<span class="path2"></span>
								</i>
							</span> 
							<span class="menu-title">Check In / Check Out</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">Check List</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">My Leave</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">My Job Site</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">My OT</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">My Travel</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					
					<!--begin:Menu item-->
					<div class="menu-item pt-5">
						<!--begin:Menu content-->
						<div class="menu-content">
							<span class="menu-heading fw-bold text-uppercase fs-7">Admin Management</span>
						</div>
						<!--end:Menu content-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">User Profile</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">Check In - Approve</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">Leave Approve</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">OT Approve</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">Travel Approve</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					
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
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">Equipment</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">Borrow</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					
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
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">Position</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">Department</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">Job Site</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">Leave Type</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">Holiday</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					
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
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">Article</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					<!--begin:Menu item-->
					<div class="menu-item">
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">Careers</span>
						</a>
						<!--end:Menu link-->
					</div>
					<!--end:Menu item-->
					
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
						<!--begin:Menu link-->
						<a class="menu-link" href="pages/user-profile/campaigns.html">
							<span class="menu-bullet"> <span
								class="bullet bullet-dot"></span>
							</span> <span class="menu-title">Log Out</span>
						</a>
						<!--end:Menu link-->
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
						</span> <span class="menu-title">Demo</span> <span
							class="menu-arrow"></span>
						</span>
						<!--end:Menu link-->
						<!--begin:Menu sub-->
						<div class="menu-sub menu-sub-accordion">
							
							<!--begin:Menu item-->
							<div class="menu-item">
								<!--begin:Menu link-->
								<a class="menu-link" href="pages/user-profile/campaigns.html">
									<span class="menu-bullet"> <span
										class="bullet bullet-dot"></span>
								</span> <span class="menu-title">Blank Template</span>
								</a>
								<!--end:Menu link-->
							</div>
							<!--end:Menu item-->
							<!--begin:Menu item-->
							<div class="menu-item">
								<!--begin:Menu link-->
								<a class="menu-link" href="pages/user-profile/documents.html">
									<span class="menu-bullet"> <span
										class="bullet bullet-dot"></span>
								</span> <span class="menu-title">Dashboards</span>
								</a>
								<!--end:Menu link-->
							</div>
							<!--end:Menu item-->
							<!--begin:Menu item-->
							<div class="menu-item">
								<!--begin:Menu link-->
								<a class="menu-link" href="pages/user-profile/followers.html">
									<span class="menu-bullet"> <span
										class="bullet bullet-dot"></span>
								</span> <span class="menu-title">Table</span>
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
	<!--begin::Footer-->
	<div class="app-sidebar-footer flex-column-auto pt-2 pb-6 px-6"
		id="kt_app_sidebar_footer">
		<a href="https://preview.keenthemes.com/html/metronic/docs"
			class="btn btn-flex flex-center btn-custom btn-primary overflow-hidden text-nowrap px-0 h-40px w-100"
			data-bs-toggle="tooltip" data-bs-trigger="hover"
			data-bs-dismiss-="click"
			title="200+ in-house components and 3rd-party plugins"> <span
			class="btn-label">Docs & Components</span> <i
			class="ki-outline ki-document btn-icon fs-2 m-0"></i>
		</a>
	</div>
	<!--end::Footer-->
</div>
<!--end::Sidebar-->
