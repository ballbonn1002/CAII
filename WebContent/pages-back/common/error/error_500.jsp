<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<!--
Author: Keenthemes
Product Name: Metronic
Product Version: 8.3.1
-->
<html lang="en">
<!--begin::Head-->
<head>
<title>System Error</title>
<meta charset="utf-8" />
<meta name="description" content="The most advanced Tailwind CSS & Bootstrap 5 Admin Theme with 40 unique prebuilt layouts." />
<meta name="keywords" content="tailwind, tailwindcss, metronic, bootstrap, bootstrap 5, admin theme" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="Metronic - Error 500" />
<meta property="og:url" content="https://keenthemes.com/metronic" />
<meta property="og:site_name" content="Metronic by Keenthemes" />
<link rel="canonical" href="http://preview.keenthemes.com/authentication/general/error-500.html" />
<link rel="shortcut icon" href="<c:url value='/assets/media/logos/favicon.ico'/>" />
<!--begin::Fonts(mandatory for all pages)-->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700" />
<!--end::Fonts-->
<!--begin::Global Stylesheets Bundle(mandatory for all pages)-->
<link href="<c:url value='/assets/plugins/global/plugins.bundle.css'/>" rel="stylesheet" type="text/css" />
<link href="<c:url value='/assets/css/style.bundle.css'/>" rel="stylesheet" type="text/css" />
<!--end::Global Stylesheets Bundle-->
<script>
	// Frame-busting to prevent click-jacking
	if (window.top !== window.self) {
		window.top.location.replace(window.self.location.href);
	}
</script>
<style>
body {
	background-image: url('<c:url value="/assets/media/auth/bg7.jpg"/>' );
}

[data-bs-theme="dark"] body {
	background-image:
		url('<c:url value="/assets/media/auth/bg7-dark.jpg"/>' );
}
</style>
</head>
<!--end::Head-->

<!--begin::Body-->
<body id="kt_body" class="app-blank bgi-size-cover bgi-position-center bgi-no-repeat">
	<!--begin::Root-->
	<div class="d-flex flex-column flex-root" id="kt_app_root">
		<!--begin::Authentication - Error 500 -->
		<div class="d-flex flex-column flex-center flex-column-fluid">
			<!--begin::Content-->
			<div class="d-flex flex-column flex-center text-center p-10">
				<!--begin::Wrapper-->
				<div class="card card-flush w-lg-650px py-5">
					<div class="card-body py-15 py-lg-20">
						<!--begin::Title-->
						<h1 class="fw-bolder fs-2qx text-gray-900 mb-4">System Error</h1>
						<!--end::Title-->
						<!--begin::Text-->
						<div class="fw-semibold fs-6 text-gray-500 mb-7">Something went wrong! Please try again later.</div>
						<!--end::Text-->
						<!--begin::Illustration-->
						<div class="mb-11">
							<img src="<c:url value='/assets/media/auth/500-error.png'/>" class="mw-100 mh-300px theme-light-show" alt="Error 500" /> <img
								src="<c:url value='/assets/media/auth/500-error-dark.png'/>" class="mw-100 mh-300px theme-dark-show" alt="Error 500" />
						</div>
						<!--end::Illustration-->
						<!--begin::Link-->
						<div class="mb-0">
							<a href="<c:url value='/index.jsp'/>" class="btn btn-sm btn-primary me-3">Return Home</a>
						</div>
						<!--end::Link-->
					</div>
				</div>
				<!--end::Wrapper-->
			</div>
			<!--end::Content-->
		</div>
		<!--end::Authentication - Error 500 -->
	</div>
	<!--end::Root-->

	<!--begin::Javascript-->
	<script>
		var hostUrl = "<c:url value='/assets/'/>";
	</script>
	<!--begin::Global Javascript Bundle(mandatory for all pages)-->
	<script src="<c:url value='/assets/plugins/global/plugins.bundle.js'/>"></script>
	<script src="<c:url value='/assets/js/scripts.bundle.js'/>"></script>
	<!--end::Global Javascript Bundle-->
	<!--end::Javascript-->
</body>
<!--end::Body-->
</html>
