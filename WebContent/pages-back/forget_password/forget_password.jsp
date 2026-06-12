<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<base href="../../" />
		<title>Forget Password</title>
		<meta charset="utf-8" />
		<meta name="description" content="The most advanced Tailwind CSS & Bootstrap 5 Admin Theme with 40 unique prebuilt layouts on Themeforest trusted by 100,000 beginners and professionals. Multi-demo, Dark Mode, RTL support and complete React, Angular, Vue, Asp.Net Core, Rails, Spring, Blazor, Django, Express.js, Node.js, Flask, Symfony & Laravel versions. Grab your copy now and get life-time updates for free." />
		<meta name="keywords" content="tailwind, tailwindcss, metronic, bootstrap, bootstrap 5, angular, VueJs, React, Asp.Net Core, Rails, Spring, Blazor, Django, Express.js, Node.js, Flask, Symfony & Laravel starter kits, admin themes, web design, figma, web development, free templates, free admin themes, bootstrap theme, bootstrap template, bootstrap dashboard, bootstrap dak mode, bootstrap button, bootstrap datepicker, bootstrap timepicker, fullcalendar, datatables, flaticon" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta property="og:locale" content="en_US" />
		<meta property="og:type" content="article" />
		<meta property="og:title" content="Metronic - The World's #1 Selling Tailwind CSS & Bootstrap Admin Template by KeenThemes" />
		<meta property="og:url" content="https://keenthemes.com/metronic" />
		<meta property="og:site_name" content="Metronic by Keenthemes" />
		<link rel="canonical" href="http://preview.keenthemes.comauthentication/general/password-confirmation.html" />
		<link rel="shortcut icon" href="/assets/media/logos/cube-small-ico.ico" />
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700" />
		<link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
		<link href="assets/css/style.bundle.css" rel="stylesheet" type="text/css" />
		<script>// Frame-busting to prevent site from being loaded within a frame without permission (click-jacking) if (window.top != window.self) { window.top.location.replace(window.self.location.href); }</script>
	</head>

	<body id="kt_body" class="app-blank bgi-size-cover bgi-position-center bgi-no-repeat">
		<script>var defaultThemeMode = "light"; var themeMode; if ( document.documentElement ) { if ( document.documentElement.hasAttribute("data-bs-theme-mode")) { themeMode = document.documentElement.getAttribute("data-bs-theme-mode"); } else { if ( localStorage.getItem("data-bs-theme") !== null ) { themeMode = localStorage.getItem("data-bs-theme"); } else { themeMode = defaultThemeMode; } } if (themeMode === "system") { themeMode = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light"; } document.documentElement.setAttribute("data-bs-theme", themeMode); }</script>
		<div class="d-flex flex-column flex-root" id="kt_app_root">
			<style>body { background-image: url('assets/media/auth/bg6.jpg'); } [data-bs-theme="dark"] body { background-image: url('assets/media/auth/bg6-dark.jpg'); }</style>
			<div class="d-flex flex-column flex-center flex-column-fluid">
				<div class="d-flex flex-column flex-center text-center p-10">
					<div class="card card-flush w-lg-650px py-5">
						<div class="card-body py-15 py-lg-20">
							<div class="mb-14 d-flex justify-content-center">
				                <img src="images/logo_cubesofttech.png"/>
							</div>
							<h1 class="fw-bolder text-gray-900 mb-5">Forgot Password ?</h1>
							<div class="fs-6 fw-semibold text-gray-500 mb-15">Enter your user id or email to reset your password.</div>
							<div class="m-10 text-start">
								<label class="form-label">User id or Email</label> <input id="useridOrEmail" name="useridOrEmail" class="form-control form-control-solid" type="text" autocomplete="off" />
								<div id="loginFeedback" class="form-text"></div>
							</div>
							<div class="mb-0 d-flex justify-content-center">
								<button type="button" class="btn btn-light me-3" onclick="window.location.href='<c:url value="/index.jsp"/>'">
									Cancel
								</button>
								<button id="preSubmitBtn" type="button" class="btn btn-primary">
								    Submit
								</button>
							</div>
							</div>
					</div>
					</div>
				</div>
			</div>
		<div class="modal fade" tabindex="-1" id="kt_modal_1">
		    <div class="modal-dialog">
		        <form id="resetForm" action="<c:url value='/send_code'/>" method="post" class="modal-content">
					<div class="modal-header position-relative">
					  <h3 class="modal-title w-100 text-center">Confirm Change Password ?</h3>
		
		                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
		                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
		                </div>
		                </div>
		
		            <div class="modal-body">
		                <p class="d-flex justify-content-center text-gray-500">Upon confirmation, a code will be sent to your email.</p>

			          <p id="userLine" class="d-flex justify-content-center mb-0">
			            <span id="userIdText"></span>
						<span id="emailText" class="ms-2 text-primary"></span>
			          </p>
						<div class="mb-0 text-center">
							<img src="/assets/media/auth/please-verify-your-email.png" class="mw-100 mh-300px theme-light-show" alt="" />
						</div>
						<input type="hidden" name="useridOrEmail" id="hiddenUserIdOrEmail" />
		            </div>
		
		            <div class="modal-footer justify-content-center gap-3">
		                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
		                <button type="submit" class="btn btn-primary">Submit</button>
		            </div>
			      </form>
		    </div>
		</div>
		<script>var hostUrl = "assets/";</script>
		<script src="assets/plugins/global/plugins.bundle.js"></script>
		<script src="assets/js/scripts.bundle.js"></script>
		<script>
			document.addEventListener('DOMContentLoaded', function () {
				const input       = document.getElementById('useridOrEmail');
				const feedback    = document.getElementById('loginFeedback');
				const preBtn      = document.getElementById('preSubmitBtn');

				const modalEl     = document.getElementById('kt_modal_1');
				const modal       = modalEl ? new bootstrap.Modal(modalEl) : null;

				const userIdText  = document.getElementById('userIdText');
				const emailText   = document.getElementById('emailText');
				const spaceSpan   = document.getElementById('spaceBetween');
				const hiddenInput = document.getElementById('hiddenUserIdOrEmail');

				const validateUrl = '<c:url value="/validate_user"/>'; 
					
				if (preBtn) { preBtn.disabled = true; preBtn.setAttribute('disabled', 'disabled'); }

				input.addEventListener('input', function () {
					input.classList.remove('is-valid','is-invalid');
					feedback.textContent = '';
					feedback.style.color = ''; 
					input.dataset.userId = '';
					input.dataset.email  = '';
					if (preBtn) { preBtn.disabled = true; preBtn.setAttribute('disabled', 'disabled'); }
				});

				input.addEventListener('blur', function () {
					const v = (input.value || '').trim();
					
					input.classList.remove('is-valid','is-invalid');
					feedback.textContent = '';
					feedback.style.color = ''; 
					
					input.dataset.userId = '';
					input.dataset.email  = '';
					if (!v) {
						if (preBtn) { preBtn.disabled = true; preBtn.setAttribute('disabled', 'disabled'); }
						return;
					}
					
					feedback.textContent = 'Checking…';
					
					fetch(validateUrl, {
						method: 'POST',
						headers: {
							'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
							'X-Requested-With': 'XMLHttpRequest'
						},
						body: 'useridOrEmail=' + encodeURIComponent(v)
					})
					.then(r => r.ok ? r.json() : Promise.reject(r))
					.then(data => {
						console.log('validate_user response:', data);

						const exists = (data.exists === true || data.exists === 'true' || data.exists === 1 || data.exists === '1');

						if (exists) {
							input.classList.add('is-valid');
							feedback.textContent = data.message || 'Account found.';
							input.dataset.userId = data.userId || '';
							input.dataset.email  = data.email  || '';
							if (preBtn) { preBtn.disabled = false; preBtn.removeAttribute('disabled'); }
						} else {
							input.classList.add('is-invalid');
							feedback.textContent = data.message || 'No account matched.';
							feedback.style.color = 'red'; 
							if (preBtn) { preBtn.disabled = true; preBtn.setAttribute('disabled', 'disabled'); }
						}
					})
					.catch(() => {
						input.classList.add('is-invalid');
						feedback.textContent = 'Error: cannot validate now.';
						feedback.style.color = 'red'; 
						if (preBtn) { preBtn.disabled = true; preBtn.setAttribute('disabled', 'disabled'); }
					});
				});

				preBtn.addEventListener('click', function () {
					if (preBtn.disabled) return;

					const uid  = input.dataset.userId || '';
					const mail = input.dataset.email  || '';

					if (userIdText) userIdText.textContent = uid;
					if (emailText)  emailText.textContent  = mail;
					if (spaceSpan)  spaceSpan.textContent  = (uid && mail) ? ' ' : '';

					if (hiddenInput) hiddenInput.value = (input.value || '').trim();

					if (modal) modal.show();
				});
			});
		</script>
		</body>
	</html>