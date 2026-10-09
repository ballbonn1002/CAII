<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<title><tiles:insertAttribute name="title" ignore="true" /></title>
<meta charset="utf-8">
<meta name="description" content="The most advanced Tailwind CSS & Bootstrap 5 Admin Theme with 40 unique prebuilt layouts on Themeforest trusted by 100,000 beginners and professionals. Multi-demo, Dark Mode, RTL support and complete React, Angular, Vue, Asp.Net Core, Rails, Spring, Blazor, Django, Express.js, Node.js, Flask, Symfony & Laravel versions. Grab your copy now and get life-time updates for free." />
<meta name="keywords" content="tailwind, tailwindcss, metronic, bootstrap, bootstrap 5, angular, VueJs, React, Asp.Net Core, Rails, Spring, Blazor, Django, Express.js, Node.js, Flask, Symfony & Laravel starter kits, admin themes, web design, figma, web development, free templates, free admin themes, bootstrap theme, bootstrap template, bootstrap dashboard, bootstrap dak mode, bootstrap button, bootstrap datepicker, bootstrap timepicker, fullcalendar, datatables, flaticon" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, viewport-fit=cover" />
<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="Metronic - The World's #1 Selling Tailwind CSS & Bootstrap Admin Template by KeenThemes" />
<meta property="og:url" content="https://keenthemes.com/metronic" />
<meta property="og:site_name" content="Metronic by Keenthemes" />
<link rel="canonical" href="http://preview.keenthemes.comauthentication/general/error-404.html" />
<link rel="shortcut icon" href="assets/media/logos/cube-small-ico.ico" />

<!--begin::Fonts(mandatory for all pages)-->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+Thai:wght@300;400;500;600;700&display=swap" />
<!--end::Fonts-->
<!--begin::Vendor Stylesheets(used for this page only)-->
<link href="assets/plugins/custom/fullcalendar/fullcalendar.bundle.css" rel="stylesheet" type="text/css" />
<link href="assets/plugins/custom/datatables/datatables.bundle.css" rel="stylesheet" type="text/css" />
<!--end::Vendor Stylesheets-->

<!--begin::Global Stylesheets Bundle(mandatory for all pages)-->
<link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
<link href="assets/css/style.bundle.css" rel="stylesheet" type="text/css" />
<!--end::Global Stylesheets Bundle-->

<!--begin::LIFF app-shell standards (มาตรฐาน webview ของ LINE LIFF ทุกหน้า)-->
<style>
html, body {
	max-width: 100%;
	overflow-x: hidden;             /* กันเลื่อนลากแกน X โผล่ขอบจอ */
}
body {
	overscroll-behavior-y: contain; /* กัน pull-to-refresh / bounce ของ webview */
	-webkit-tap-highlight-color: transparent; /* กันไฮไลต์ฟ้าตอนแตะปุ่มบน Android */
	padding-top: env(safe-area-inset-top); /* เผื่อ notch/status bar เวลาเปิดแบบ full-screen */
	font-family: 'IBM Plex Sans Thai', Helvetica, Arial, sans-serif;
}
.liff-page-title {
	font-weight: 700;
	font-size: 23.1px;
	line-height: 27.72px;
	letter-spacing: 0px;
}
.liff-shell { --liff-gutter: 1.5rem; width: calc(100% - 32px); max-width: 393px; margin: 0 auto; }
.liff-back-btn { display: inline-flex; align-items: center; justify-content: center; width: 36px; height: 36px; border-radius: 10px; background: #F8F9FB; border: 1px solid #E4E6EF; }
.liff-loading-overlay {
	position: fixed; inset: 0;
	background: rgba(255,255,255,.7);
	display: none;
	align-items: center; justify-content: center;
	z-index: 200;
}
.liff-initializing { visibility: hidden; }
/* overlay โผล่เมื่อรอเกิน 300ms */
.liff-loading-delayed { animation: liffDelayShow 0s .3s both; }
@keyframes liffDelayShow { from { visibility: hidden; } to { visibility: visible; } }
.liff-skel { display: inline-block; height: 12px; border-radius: 6px; flex: none; background: linear-gradient(90deg, var(--bs-gray-200) 25%, var(--bs-gray-300) 37%, var(--bs-gray-200) 63%); background-size: 400% 100%; animation: liffShimmer 1.2s ease-in-out infinite; }
.liff-skel-box { width: 35px; height: 35px; border-radius: .475rem; }
.liff-skel-row { display: flex; align-items: center; gap: .5rem; min-height: 20px; }
.liff-skel-dot { width: 14px; height: 14px; border-radius: 50%; }
@keyframes liffShimmer { 0% { background-position: 100% 50%; } 100% { background-position: 0 50%; } }
@media (prefers-reduced-motion: reduce) { .liff-skel { animation: none; } }
.liff-input-underline { border: none; border-bottom: 1.5px solid #E4E6EF; border-radius: 0; background: transparent; padding: 8px 2px; box-shadow: none !important; }
.liff-input-underline:focus { border-bottom-color: var(--bs-primary); background: transparent; }
.liff-input-underline:disabled, .liff-input-underline[readonly] { background: transparent; border-bottom-style: dashed; color: var(--bs-gray-600); }
textarea.liff-input-underline { padding-left: 2px; padding-right: 2px; }
.liff-field-row { box-sizing: border-box; display: flex; flex-direction: row; align-items: center; padding: 0; gap: 6.5px; width: 100%; min-height: 55.25px; border-bottom: 1px solid #DBDFE9; }
.liff-field-row .liff-field-label { flex: none; font-size: 13.5px; font-weight: 500; color: var(--bs-gray-700); white-space: nowrap; }
.liff-field-row .liff-field-value { flex: 1 1 auto; min-width: 0; border: none !important; background-color: transparent !important; padding: 0 !important; text-align: right; box-shadow: none !important; }
.liff-field-row .liff-field-value:disabled, .liff-field-row .liff-field-value[readonly] { color: var(--bs-gray-600); cursor: default; }
.liff-field-row .liff-field-value::placeholder { color: var(--bs-gray-300); opacity: 1; }
.liff-field-grow { flex: 1 1 auto; min-width: 0; }
.liff-field-row .liff-field-value.liff-field-dropdown {
	appearance: none; -webkit-appearance: none; -moz-appearance: none;
	padding-right: 18px !important;
	background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%2399A1B7' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.6' d='m2 5 6 6 6-6'/%3e%3c/svg%3e") !important;
	background-repeat: no-repeat !important;
	background-position: right center !important;
	background-size: 11px 8px !important;
	cursor: pointer;
}
.liff-field-row .liff-field-value.liff-field-dropdown:disabled { cursor: default; background-image: none !important; padding-right: 0 !important; }
.liff-select-hidden { position: absolute !important; width: 1px !important; height: 1px !important; overflow: hidden !important; clip: rect(0 0 0 0) !important; white-space: nowrap !important; }
.liff-field-row .liff-select-dropdown { position: relative; flex: 1 1 auto; min-width: 0; }
.liff-select-dropdown .liff-dropdown-trigger { width: 100%; border: none !important; background-color: transparent !important; }
.liff-select-dropdown .liff-dropdown-menu {
	display: none;
	position: absolute; top: 100%; right: 0; margin-top: 4px;
	z-index: 300; list-style: none;
	min-width: 140px; max-width: 260px;
	border-radius: 10px; border: 1px solid #E4E6EF; box-shadow: 0 4px 20px rgba(0,0,0,.08);
	padding: 6px; margin-block: 0; margin-inline-start: 0;
	max-height: 260px; overflow-y: auto;
	background: #fff;
}
.liff-select-dropdown.liff-dropdown-open .liff-dropdown-menu { display: block; }
.liff-dropdown-menu .dropdown-item { display: block; width: 100%; text-align: left; font-size: 13px; font-weight: 500; border-radius: 6px; padding: 8px 12px; color: var(--bs-gray-700); white-space: normal; text-decoration: none; background: none; border: none; }
.liff-dropdown-menu .dropdown-item:hover { background-color: var(--bs-gray-100); }
.liff-dropdown-menu .dropdown-item.active { background-color: var(--bs-primary); color: #fff; }
.liff-dropdown-menu .dropdown-item.disabled { color: var(--bs-gray-400); pointer-events: none; }
</style>
<!--end::LIFF app-shell standards-->
<!--begin::Javascript-->
<script>var hostUrl = "assets/";</script>
<!--begin::Global Javascript Bundle(mandatory for all pages)-->
<script src="assets/plugins/global/plugins.bundle.js"></script>
<script src="assets/js/scripts.bundle.js"></script>
<!--end::Global Javascript Bundle-->
<!--begin::Vendors Javascript(used for this page only)-->
<script src="assets/plugins/custom/fullcalendar/fullcalendar.bundle.js"></script>
<script src="https://cdn.amcharts.com/lib/5/index.js"></script>
<script src="https://cdn.amcharts.com/lib/5/xy.js"></script>
<script src="https://cdn.amcharts.com/lib/5/percent.js"></script>
<script src="https://cdn.amcharts.com/lib/5/radar.js"></script>
<script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>
<script src="https://cdn.amcharts.com/lib/5/map.js"></script>
<script src="https://cdn.amcharts.com/lib/5/geodata/worldLow.js"></script>
<script src="https://cdn.amcharts.com/lib/5/geodata/continentsLow.js"></script>
<script src="https://cdn.amcharts.com/lib/5/geodata/usaLow.js"></script>
<script src="https://cdn.amcharts.com/lib/5/geodata/worldTimeZonesLow.js"></script>
<script src="https://cdn.amcharts.com/lib/5/geodata/worldTimeZoneAreasLow.js"></script>
<script src="assets/plugins/custom/datatables/datatables.bundle.js"></script>
<!--end::Vendors Javascript-->
<!--begin::Custom Javascript(used for this page only)-->
<script src="assets/js/widgets.bundle.js"></script>
<script src="assets/js/custom/widgets.js"></script>
<script src="assets/js/custom/apps/chat/chat.js"></script>
<script src="assets/js/custom/utilities/modals/upgrade-plan.js"></script>
<script src="assets/js/custom/utilities/modals/create-app.js"></script>
<script src="assets/js/custom/utilities/modals/new-target.js"></script>
<script src="assets/js/custom/utilities/modals/users-search.js"></script>
<!--end::Custom Javascript-->
<!--begin::LIFF toast (ใช้ร่วมทุกหน้า LIFF)-->
<script>
var liffToastOptions = {
	"closeButton": false,
	"debug": false,
	"newestOnTop": false,
	"progressBar": false,
	"positionClass": "toastr-top-right",
	"preventDuplicates": false,
	"onclick": null,
	"showDuration": "300",
	"hideDuration": "1000",
	"showEasing": "swing",
	"hideEasing": "linear",
	"showMethod": "fadeIn",
	"hideMethod": "fadeOut"
};

function liffToastSuccess(message, title) {
	toastr.options = $.extend({}, liffToastOptions, { "timeOut": "2000", "extendedTimeOut": "1000" });
	toastr.success(message, title);
}

function liffToastError(message, title) {
	toastr.options = $.extend({}, liffToastOptions, { "timeOut": "5000", "extendedTimeOut": "5000" });
	toastr.error(message, title);
}
</script>
<!--end::LIFF toast-->
<!--begin::LIFF form init-->
<script>
function liffInitDone(formSelector) {
	$(formSelector).removeClass('liff-initializing').removeAttr('aria-busy');
	// หลัง init แล้ว spinner ตอน submit ต้องโผล่ทันที
	$('#liffLoadingOverlay').hide().removeClass('liff-loading-delayed');
}

function liffShowLoading() {
	document.getElementById('liffLoadingOverlay').style.display = 'flex';
}
</script>
<!--end::LIFF form init-->
<!--end::Javascript-->
</head>
<!--begin::Body-->
<%-- LIFF ไม่มี sidebar/header attribute = false --%>
<body id="kt_app_body" data-kt-app-layout="light-sidebar" data-kt-app-header-fixed="false" data-kt-app-sidebar-enabled="false" data-kt-app-sidebar-fixed="false" data-kt-app-sidebar-hoverable="false" data-kt-app-sidebar-push-header="false" data-kt-app-sidebar-push-toolbar="false" data-kt-app-sidebar-push-footer="false" data-kt-app-toolbar-enabled="true" class="app-default">
	<!--begin::Theme mode setup on page load-->
	<script>
			var defaultThemeMode = "light"; 
			var themeMode; 
			if ( document.documentElement ) {
				if ( document.documentElement.hasAttribute("data-bs-theme-mode")) { 
					themeMode = document.documentElement.getAttribute("data-bs-theme-mode"); 
				} else { 
					if ( localStorage.getItem("data-bs-theme") !== null ) { 
						themeMode = localStorage.getItem("data-bs-theme"); 
					} else { 
						themeMode = defaultThemeMode; 
					} 
				} 
				if (themeMode === "system") { 
					themeMode = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light"; 
				} 
				document.documentElement.setAttribute("data-bs-theme", themeMode); 
			}
	</script>
	<!--end::Theme mode setup on page load-->
	<!--begin::App-->
	<div class="d-flex flex-column flex-root app-root" id="kt_app_root">
		<!--begin::Page-->
		<div class="app-page flex-column flex-column-fluid" id="kt_app_page">
		<tiles:insertAttribute name="header" />
		<!--begin::Wrapper-->
		<div class="app-wrapper flex-column flex-row-fluid" id="kt_app_wrapper">
			<tiles:insertAttribute name="menu" ignore="true" />
				<tiles:insertAttribute name="body" />
		</div>
		<!--end::Wrapper-->
		</div>
		<!--end::Page-->
	</div>
	<!--end::App-->

		<!--begin::Scrolltop-->
		<div id="kt_scrolltop" class="scrolltop" data-kt-scrolltop="true">
			<i class="ki-outline ki-arrow-up"></i>
		</div>
		<!--end::Scrolltop-->
	<tiles:insertAttribute name="footer" />

</body>
<!--end::Body-->
</html>

<script>
<% int sessionTimeoutSeconds = request.getSession().getMaxInactiveInterval(); %>
const timeoutDuration = (<%= sessionTimeoutSeconds %> * 1000) - 2000;
let sessionTimer;

function showSessionAlert() {
    Swal.fire({
        title: 'Session Timeout',
        html: 'คุณไม่ได้ใช้งานระบบเป็นเวลานาน<br>กรุณาโหลดหน้าเว็บใหม่อีกครั้ง',
        icon: 'warning',
        confirmButtonText: 'OK',
        allowOutsideClick: false,
        allowEscapeKey: false
    }).then((result) => {
        if (result.isConfirmed) {
            //window.location.reload();
        	window.location.href = '<%=request.getContextPath()%>/pages-line/index.jsp';
        }
    });
}

function resetTimer() {
    clearTimeout(sessionTimer);
    sessionTimer = setTimeout(showSessionAlert, timeoutDuration);
}

window.onload = resetTimer;

document.onmousemove = resetTimer;
document.onkeypress = resetTimer;
document.onclick = resetTimer;
document.onscroll = resetTimer;

</script>