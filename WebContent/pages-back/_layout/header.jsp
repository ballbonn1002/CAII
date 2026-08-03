<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
#avatarPreview{
    background-color: #f3f6f9;
    color: #0d6efd;
    font-size: 1.9rem;
    font-weight: 500;
    display: flex;
    align-items: center;
    justify-content: center;
    line-height: 1;
}

</style>

<!--begin::Header-->
<div id="kt_app_header" class="app-header" data-kt-sticky="true"
	data-kt-sticky-activate="{default: true, lg: true}"
	data-kt-sticky-name="app-header-minimize"
	data-kt-sticky-offset="{default: '200px', lg: '0'}"
	data-kt-sticky-animation="false">
	<!--begin::Header container-->
	<div
		class="app-container container-fluid d-flex align-items-stretch justify-content-between"
		id="kt_app_header_container">
		<!--begin::Sidebar mobile toggle-->
		<div class="d-flex align-items-center d-lg-none ms-n3 me-1 me-md-2"
			title="Show sidebar menu">
			<div class="btn btn-icon btn-active-color-primary w-35px h-35px"
				id="kt_app_sidebar_mobile_toggle">
				<i class="ki-outline ki-abstract-14 fs-2 fs-md-1"></i>
			</div>
		</div>
		<!--end::Sidebar mobile toggle-->
		<!--begin::Mobile logo-->
		<div class="d-flex align-items-center flex-grow-1 flex-lg-grow-0">
			<a href="check_in_out" class="d-lg-none"> <img alt="Logo"
				src="assets/media/logos/cube-small-ico.ico" class="h-50px" />
			</a>
		</div>
		<!--end::Mobile logo-->
		<!--begin::Header wrapper-->
		<div
			class="d-flex align-items-stretch justify-content-between flex-lg-grow-1"
			id="kt_app_header_wrapper">
			<!--begin::Menu wrapper-->
			<div
				class="app-header-menu app-header-mobile-drawer align-items-stretch"
				data-kt-drawer="true" data-kt-drawer-name="app-header-menu"
				data-kt-drawer-activate="{default: true, lg: false}"
				data-kt-drawer-overlay="true" data-kt-drawer-width="250px"
				data-kt-drawer-direction="end"
				data-kt-drawer-toggle="#kt_app_header_menu_toggle"
				data-kt-swapper="true"
				data-kt-swapper-mode="{default: 'append', lg: 'prepend'}"
				data-kt-swapper-parent="{default: '#kt_app_body', lg: '#kt_app_header_wrapper'}">
				<!--begin::Menu-->
				<div
					class="menu menu-rounded menu-column menu-lg-row my-5 my-lg-0 align-items-stretch fw-semibold px-2 px-lg-0"
					id="kt_app_header_menu" data-kt-menu="true">
				</div>
				<!--end::Menu-->
			</div>
			<!--end::Menu wrapper-->
			<!--begin::Navbar-->
			<div class="app-navbar flex-shrink-0">
				<!--begin::Theme mode-->
				<div class="app-navbar-item ms-1 ms-md-4">
					<!--begin::Menu toggle-->
					<a href="#"
						class="btn btn-icon btn-custom btn-icon-muted btn-active-light btn-active-color-primary w-35px h-35px"
						data-kt-menu-trigger="{default:'click', lg: 'hover'}"
						data-kt-menu-attach="parent" data-kt-menu-placement="bottom-end">
						<i class="ki-outline ki-night-day theme-light-show fs-1"></i> <i
						class="ki-outline ki-moon theme-dark-show fs-1"></i>
					</a>
					<!--begin::Menu toggle-->
					<!--begin::Menu-->
					<div
						class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-title-gray-700 menu-icon-gray-500 menu-active-bg menu-state-color fw-semibold py-4 fs-base w-150px"
						data-kt-menu="true" data-kt-element="theme-mode-menu">
						<!--begin::Menu item-->
						<!-- Light -->
						<div class="menu-item px-3 my-0">
							<a href="#" class="menu-link px-3 py-2" data-kt-element="mode"
								data-kt-value="light"> <span class="menu-icon"
								data-kt-element="icon"> <i
									class="ki-outline ki-night-day fs-2"></i>
							</span> <span class="menu-title">Light</span>
							</a>
						</div>
						<!--end::Menu item-->
						<!--begin::Menu item-->
						<!-- Dark -->
						<div class="menu-item px-3 my-0">
							<a href="#" class="menu-link px-3 py-2" data-kt-element="mode"
								data-kt-value="dark"> <span class="menu-icon"
								data-kt-element="icon"> <i
									class="ki-outline ki-moon fs-2"></i>
							</span> <span class="menu-title">Dark</span>
							</a>
						</div>
						<!--end::Menu item-->
						<!--begin::Menu item-->
						<!-- System -->
						<div class="menu-item px-3 my-0">
							<a href="#" class="menu-link px-3 py-2" data-kt-element="mode"
								data-kt-value="system"> <span class="menu-icon"
								data-kt-element="icon"> <i
									class="ki-outline ki-screen fs-2"></i>
							</span> <span class="menu-title">System</span>
							</a>
						</div>
						<!--end::Menu item-->
					</div>
					<!--end::Menu-->
				</div>
				<!--end::Theme mode-->
				<!--begin::Notifications-->
				<div class="app-navbar-item ms-1 ms-md-4">
					<!--begin::Menu toggle-->
					<div
						class="btn btn-icon btn-custom btn-icon-muted btn-active-light btn-active-color-primary w-35px h-35px position-relative"
						data-kt-menu-trigger="{default: 'click', lg: 'hover'}"
						data-kt-menu-attach="parent" data-kt-menu-placement="bottom-end">
						<i class="ki-duotone ki-notification fs-2">
							<span class="path1"></span>
							<span class="path2"></span>
							<span class="path3"></span>
							<span class="path4"></span>
						</i>
						<span id="kt_notification_unread_dot"
							class="bullet bullet-dot bg-success h-6px w-6px position-absolute translate-middle top-0 start-50 animation-blink d-none"></span>
					</div>
					<!--end::Menu toggle-->
					<!--begin::Menu-->
					<div
						class="menu menu-sub menu-sub-dropdown menu-column w-350px w-lg-375px"
						data-kt-menu="true" id="kt_menu_notifications">
						<!--begin::Heading-->
						<div class="d-flex flex-column bgi-no-repeat rounded-top"
							style="background-image:url('assets/media/misc/menu-header-bg.jpg')">
							<!--begin::Title-->
							<div class="d-flex flex-stack px-9 mt-10 mb-6">
								<h3 class="text-white fw-semibold m-0">Notifications</h3>
								<button type="button" id="kt_notification_mark_all_read"
									class="btn btn-sm btn-color-white btn-active-color-primary">Mark
									all as read</button>
							</div>
							<!--end::Title-->
						</div>
						<!--end::Heading-->
						<!--begin::Items-->
						<style>
							.notif-row {
								display: grid;
								grid-template-columns: 12px 35px 1fr auto;
								align-items: center;
								column-gap: 8px;
							}
						</style>
						<div class="scroll-y mh-325px my-5 px-8" id="kt_notification_list">
							<div class="text-muted text-center py-5">No notifications</div>
						</div>
						<!--end::Items-->
						<!--begin::View more-->
						<div class="py-3 text-center border-top">
							<a href="my_notification"
								class="btn btn-color-gray-600 btn-active-color-primary">View
								All <i class="ki-duotone ki-arrow-right fs-5"><span
									class="path1"></span> <span class="path2"></span>
							</i></a>
						</div>
						<!--end::View more-->
					</div>
					<!--end::Menu-->
				</div>
				<!--end::Notifications-->
				<script>
					$(document).ready(function() {
						var MONTH_ABBR = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];

						// leave_type_id -> icon/color, mirrors leave_type table usage in new_leave_approved.jsp
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

						function formatShortDate(d) {
							return d.getDate() + " " + MONTH_ABBR[d.getMonth()];
						}

						function formatLongDate(dateStr) {
							if (!dateStr) return "";
							var d = new Date(dateStr + "T00:00:00");
							return d.getDate() + " " + MONTH_ABBR[d.getMonth()] + " " + d.getFullYear();
						}

						function notifTimeLabel(timeCreateStr) {
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
							return formatShortDate(then);
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

						function buildNotifRow(n) {
							var data = {};
							try {
								data = JSON.parse(n.message) || {};
							} catch (e) {
								data = {};
							}

							var typeInfo = LEAVE_TYPE_ICON[String(data.leaveTypeId)] || DEFAULT_ICON;
							var titleText = data.leaveTypeName || n.title || "";

							var statusBadge = "";
							if (data.status) {
								var statusClass = data.status === "Approve" ? "badge-light-success" : "badge-light-danger";
								statusBadge = ' <span class="badge ' + statusClass + ' fs-8">' + data.status + '</span>';
							}

							var dateRow = "";
							if (data.startDate && data.endDate) {
								dateRow = '<div class="text-gray-500 fs-7">' + formatLongDate(data.startDate) + ' - ' + formatLongDate(data.endDate) + '</div>';
							}

							var dotHtml = n.isRead ? '' : '<span class="bullet bullet-dot bg-danger"></span>';

							var $row = $('<a href="notification_read?id=' + n.id + '" class="notif-row py-4 text-decoration-none"></a>');
							$row.append(
								'<div class="d-flex justify-content-center">' + dotHtml + '</div>'
								+ buildIconHtml(typeInfo)
								+ '<div>'
									+ '<div class="mb-0 me-2">'
									+ '<span class="fs-6 text-gray-800 text-hover-primary fw-bold">' + titleText + '</span>' + statusBadge
									+ dateRow
									+ '</div>'
								+ '</div>'
								+ '<div class="d-flex flex-column align-items-center">'
								+ '<span class="badge badge-light fs-8">' + notifTimeLabel(n.timeCreate) + '</span>'
								+ '</div>'
							);
							return $row;
						}

						function loadNotifications() {
							$.ajax({
								url : "notification_list_json",
								method : "POST",
								success : function(data) {
									var list = typeof data === "string" ? JSON.parse(data) : data;
									var $container = $("#kt_notification_list");
									$container.empty();

									var hasUnread = list && list.some(function(n) { return !n.isRead; });
									$("#kt_notification_unread_dot").toggleClass("d-none", !hasUnread);

									if (!list || list.length === 0) {
										$container.append('<div class="text-muted text-center py-5">No notifications</div>');
										return;
									}
									list.forEach(function(n) {
										$container.append(buildNotifRow(n));
									});
								},
								error : function() {
									console.log("Unable to load notifications.");
								}
							});
						}

						$("#kt_notification_mark_all_read").on("click", function() {
							$.ajax({
								url : "notification_read_all",
								method : "POST",
								success : function() {
									loadNotifications();
								},
								error : function() {
									console.log("Unable to mark notifications as read.");
								}
							});
						});

						loadNotifications();
					});
				</script>
				<!--  -->
				<!--begin::User menu-->
				<div class="app-navbar-item ms-1 ms-md-4"
					id="kt_header_user_menu_toggle">
					<!--begin::Menu wrapper-->
					<div class="cursor-pointer symbol symbol-35px"
						data-kt-menu-trigger="{default: 'click', lg: 'hover'}"
						data-kt-menu-attach="parent" data-kt-menu-placement="bottom-end">
						<!-- <img src="assets/media/avatars/300-3.jpg" class="rounded-3"
							alt="user" /> -->
							<c:choose>
								<c:when test="${not empty sessionScope.userImgPath}">
										<img id="avatarPreview" src="${sessionScope.userImgPath}" alt="${not empty onlineUser.nameEN ? onlineUser.nameEN : onlineUser.name}"
										class="rounded-3 w-35px h-35px" style="object-fit: cover;"> 
								</c:when>
								<c:otherwise>
										<div id="avatarPreview" class="rounded-3 w-35px h-35px" >
										<c:choose>
											<c:when test="${not empty onlineUser.nameEN and fn:length(onlineUser.nameEN) >= 1}">
                                                    ${fn:toUpperCase(fn:substring(onlineUser.nameEN, 0, 1))}
                                            </c:when>
											<c:when test="${not empty onlineUser.name and fn:length(onlineUser.name) >= 1}">
                                                    ${fn:toUpperCase(fn:substring(onlineUser.name, 0, 1))}
                                            </c:when>
											<c:otherwise>-</c:otherwise>
										</c:choose>
										</div>
								</c:otherwise>
							</c:choose>
					</div>
					<!--begin::User account menu-->
					<div
						class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-800 menu-state-bg menu-state-color fw-semibold py-4 fs-6 w-275px"
						data-kt-menu="true">
						<!--begin::Menu item-->
						<div class="menu-item px-3">
							<div class="menu-content d-flex align-items-center px-3">
								<!--begin::Avatar-->
								<div class="symbol symbol-50px me-5">
									<!-- <img alt="Logo" src="assets/media/avatars/300-3.jpg" /> -->
									<c:choose>
											<c:when test="${not empty sessionScope.userImgPath}">
												<img id="avatarPreview" src="${sessionScope.userImgPath}"
													alt="${not empty onlineUser.nameEN ? onlineUser.nameEN : onlineUser.name}"
													class="rounded-1 w-50px h-50px" style="object-fit: cover;"> 
											</c:when>
											<c:otherwise>
												<div id="avatarPreview"
													class="rounded-1 w-50px h-50px">
													<c:choose>
														<c:when
															test="${not empty onlineUser.nameEN and fn:length(onlineUser.nameEN) >= 1}">
                                                            ${fn:toUpperCase(fn:substring(onlineUser.nameEN, 0, 1))}
                                                        </c:when>
														<c:when
															test="${not empty onlineUser.name and fn:length(onlineUser.name) >= 1}">
                                                            ${fn:toUpperCase(fn:substring(onlineUser.name, 0, 1))}
                                                        </c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose>
												</div>
											</c:otherwise>
										</c:choose>
								</div>
								<!--end::Avatar-->
								<!--begin::Username-->
								<div class="d-flex flex-column">
									<div class="fw-bold d-flex align-items-center fs-5">
										${empty onlineUser.nameEN ? onlineUser.name: onlineUser.nameEN}
									</div>
									<a href="#"
										class="fw-semibold text-muted text-hover-primary fs-7">${onlineUser.id}</a>
								</div>
								<!--end::Username-->
							</div>
						</div>
						<!--end::Menu item-->
						<!--begin::Menu separator-->
						<div class="separator my-2"></div>
						<!--end::Menu separator-->
						<!-- My Profile -->
						<div class="menu-item px-5">
							<a href="my_profile" class="menu-link px-5">My
								Profile</a>
						</div>
						<!-- My Notification -->
						<div class="menu-item px-5">
							<a href="my_notification" class="menu-link px-5">My
								Notification</a>
						</div>
						<!-- My Projects -->
						<!-- <div class="menu-item px-5">
							<a href="#" class="menu-link px-5"> <span
								class="menu-text">My Projects</span> <span class="menu-badge">
									<span
									class="badge badge-light-danger badge-circle fw-bold fs-7">3</span>
							</span>
							</a>
						</div> -->
						<!-- My Subscription -->
						<!-- <div class="menu-item px-5"
							data-kt-menu-trigger="{default: 'click', lg: 'hover'}"
							data-kt-menu-placement="left-start"
							data-kt-menu-offset="-15px, 0">
							<a href="#" class="menu-link px-5"> <span class="menu-title">My
									Subscription</span> <span class="menu-arrow"></span>
							</a>
							begin::Menu sub
							<div class="menu-sub menu-sub-dropdown w-175px py-4">
								begin::Menu item
								<div class="menu-item px-3">
									<a href="account/referrals.html" class="menu-link px-5">Referrals</a>
								</div>
								end::Menu item
								begin::Menu item
								<div class="menu-item px-3">
									<a href="account/billing.html" class="menu-link px-5">Billing</a>
								</div>
								end::Menu item
								begin::Menu item
								<div class="menu-item px-3">
									<a href="account/statements.html" class="menu-link px-5">Payments</a>
								</div>
								end::Menu item
								begin::Menu item
								<div class="menu-item px-3">
									<a href="account/statements.html"
										class="menu-link d-flex flex-stack px-5">Statements <span
										class="ms-2 lh-0" data-bs-toggle="tooltip"
										title="View your statements"> <i
											class="ki-outline ki-information-5 fs-5"></i>
									</span></a>
								</div>
								end::Menu item
								begin::Menu separator
								<div class="separator my-2"></div>
								end::Menu separator
								begin::Menu item
								<div class="menu-item px-3">
									<div class="menu-content px-3">
										<label
											class="form-check form-switch form-check-custom form-check-solid">
											<input class="form-check-input w-30px h-20px" type="checkbox"
											value="1" checked="checked" name="notifications" /> <span
											class="form-check-label text-muted fs-7">Notifications</span>
										</label>
									</div>
								</div>
								end::Menu item
							</div>
							end::Menu sub
						</div> -->
						<!-- My Statements -->
						<!-- <div class="menu-item px-5">
							<a href="account/statements.html" class="menu-link px-5">My
								Statements</a>
						</div> -->
						<!--begin::Menu separator-->
						<div class="separator my-2"></div>
						<!--end::Menu separator-->
						<!-- Mode -->
						<div class="menu-item px-5"
							data-kt-menu-trigger="{default: 'click', lg: 'hover'}"
							data-kt-menu-placement="left-start"
							data-kt-menu-offset="-15px, 0">
							<a href="#" class="menu-link px-5"> <span
								class="menu-title position-relative">Mode <span
									class="ms-5 position-absolute translate-middle-y top-50 end-0">
										<i class="ki-outline ki-night-day theme-light-show fs-2"></i>
										<i class="ki-outline ki-moon theme-dark-show fs-2"></i>
								</span></span>
							</a>
							<!--begin::Menu-->
							<div
								class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-title-gray-700 menu-icon-gray-500 menu-active-bg menu-state-color fw-semibold py-4 fs-base w-150px"
								data-kt-menu="true" data-kt-element="theme-mode-menu">
								<!--begin::Menu item-->
								<div class="menu-item px-3 my-0">
									<a href="#" class="menu-link px-3 py-2" data-kt-element="mode"
										data-kt-value="light"> <span class="menu-icon"
										data-kt-element="icon"> <i
											class="ki-outline ki-night-day fs-2"></i>
									</span> <span class="menu-title">Light</span>
									</a>
								</div>
								<!--end::Menu item-->
								<!--begin::Menu item-->
								<div class="menu-item px-3 my-0">
									<a href="#" class="menu-link px-3 py-2" data-kt-element="mode"
										data-kt-value="dark"> <span class="menu-icon"
										data-kt-element="icon"> <i
											class="ki-outline ki-moon fs-2"></i>
									</span> <span class="menu-title">Dark</span>
									</a>
								</div>
								<!--end::Menu item-->
								<!--begin::Menu item-->
								<div class="menu-item px-3 my-0">
									<a href="#" class="menu-link px-3 py-2" data-kt-element="mode"
										data-kt-value="system"> <span class="menu-icon"
										data-kt-element="icon"> <i
											class="ki-outline ki-screen fs-2"></i>
									</span> <span class="menu-title">System</span>
									</a>
								</div>
								<!--end::Menu item-->
							</div>
							<!--end::Menu-->
						</div>
						<!-- Language -->
						<!-- <div class="menu-item px-5"
							data-kt-menu-trigger="{default: 'click', lg: 'hover'}"
							data-kt-menu-placement="left-start"
							data-kt-menu-offset="-15px, 0">
							<a href="#" class="menu-link px-5"> <span
								class="menu-title position-relative">Language <span
									class="fs-8 rounded bg-light px-3 py-2 position-absolute translate-middle-y top-50 end-0">English
										<img class="w-15px h-15px rounded-1 ms-2"
										src="assets/media/flags/united-states.svg" alt="" />
								</span></span>
							</a>
						</div> -->
						<!-- Account Settings -->
						<!-- <div class="menu-item px-5 my-1">
							<a href="account/settings.html" class="menu-link px-5">Account
								Settings</a>
						</div> -->
						<!-- Sign Out -->
						<div class="menu-item px-5">
							<a href="signout"
								class="menu-link px-5">Sign Out</a>
						</div>
					</div>
					<!--end::User account menu-->
					<!--end::Menu wrapper-->
				</div>
				<!--end::User menu-->
				
				<!--begin::Aside toggle-->
				<!--end::Header menu toggle-->
			</div>
			<!--end::Navbar-->
		</div>
		<!--end::Header wrapper-->
	</div>
	<!--end::Header container-->
</div>
<!--end::Header-->