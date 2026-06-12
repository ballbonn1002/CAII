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
	<title>Reset Password</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="shortcut icon" href="/assets/media/logos/cube-small-ico.ico" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700" />
	<link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
	<link href="assets/css/style.bundle.css" rel="stylesheet" type="text/css" />
	
	<style>
		body { 
			background-image: url('assets/media/auth/bg6.jpg'); 
			background-attachment: fixed; 
		} 
		[data-bs-theme="dark"] body { 
			background-image: url('assets/media/auth/bg6-dark.jpg'); 
			background-attachment: fixed; 
		}
		
		.form-control.is-invalid {
			background-position: right 3rem center !important; 
			padding-right: 4.5rem !important;
		}
	</style>
</head>
<body id="kt_body" class="app-blank bgi-size-cover bgi-position-center bgi-no-repeat">

	<c:if test="${isSuccess}">
	    <script>
	        window.location.href = '<c:url value="/index.jsp"/>';
	    </script>
	</c:if>

	<div class="d-flex flex-column flex-root" id="kt_app_root">
		<div class="d-flex flex-column flex-center flex-column-fluid">
			<div class="d-flex flex-column flex-center text-center p-10">
				<div class="card card-flush w-lg-650px py-5">
					<div class="card-body py-15 py-lg-20">
						<div class="mb-14 d-flex justify-content-center">
			                <img src="images/logo_cubesofttech.png" alt="Logo"/>
						</div>
						<h1 class="fw-bolder text-gray-900 mb-5">Reset Password ?</h1>
						<div class="fs-6 fw-semibold text-gray-500 mb-10">Check your email for a code verification.</div>
						
						<c:if test="${not empty errorMsg}">
							<div id="errorBlock" class="alert alert-danger d-flex align-items-center p-5 mb-10">
								<span class="svg-icon svg-icon-2hx svg-icon-danger me-4">
									<i class="ki-duotone ki-information-5 fs-2x"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
								</span>
								<div class="d-flex flex-column text-start">
									<h4 class="mb-1 text-danger">Error</h4>
									<span>${errorMsg}</span>
								</div>
							</div>
							<c:remove var="errorMsg" scope="session" /> </c:if>

						<form id="resetPasswordForm" action="<c:url value='/reset_password'/>" method="post">
							
							<input type="hidden" name="userLoginParam" value="${param.userLoginParam != null ? param.userLoginParam : userLoginParam}" />

							<div class="m-7 text-start">
								<label class="form-label text-gray-900">Code <span class="text-danger">*</span></label> 
								<input id="inputCode" name="inputCode" class="form-control form-control-solid" type="text" value="${inputCode}" autocomplete="off" required />
								<c:remove var="inputCode" scope="session" /> </div>

							<div class="m-7 text-start">
								<label class="form-label text-gray-900">Password <span class="text-danger">*</span></label> 
								<div class="position-relative">
									<input id="newPassword" name="newPassword" class="form-control form-control-solid pe-12" type="password" autocomplete="off" required />
									<span class="position-absolute top-50 end-0 translate-middle-y me-3 cursor-pointer" onclick="togglePassword('newPassword', this)" style="z-index: 10;">
										<i class="ki-duotone ki-eye fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
									</span>
								</div>
								
								<div class="m-7 text-start">
									<div class="fs-7 fw-semibold text-muted mb-2">Password must contain:</div>
									<ul class="list-unstyled text-muted fs-7 mb-1">
										<li id="rule-length" class="d-flex align-items-center mb-1 transition-all">
											<span class="indicator w-15px me-1 text-center text-muted">•</span> 8 to 30 characters
										</li>
										<li id="rule-upper" class="d-flex align-items-center mb-1 transition-all">
											<span class="indicator w-15px me-1 text-center text-muted">•</span> At least one uppercase letter
										</li>
										<li id="rule-lower" class="d-flex align-items-center mb-1 transition-all">
											<span class="indicator w-15px me-1 text-center text-muted">•</span> At least one lowercase letter
										</li>
										<li id="rule-number" class="d-flex align-items-center mb-1 transition-all">
											<span class="indicator w-15px me-1 text-center text-muted">•</span> At least one number
										</li>
									</ul>
									<div id="reqErrorMsg" class="text-danger fs-7 d-none mt-2">Please ensure your password meets all requirements.</div>
								</div>
							</div>

							<div class="m-7 text-start">
								<label class="form-label text-gray-900">Confirm Password <span class="text-danger">*</span></label> 
								<div class="position-relative">
									<input id="confirmPassword" name="confirmPassword" class="form-control form-control-solid pe-12" type="password" autocomplete="off" required />
									<span class="position-absolute top-50 end-0 translate-middle-y me-3 cursor-pointer" onclick="togglePassword('confirmPassword', this)" style="z-index: 10;">
										<i class="ki-duotone ki-eye fs-2"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
									</span>
								</div>
								<div id="matchErrorMsg" class="text-danger fs-7 d-none mt-2">Passwords do not match.</div>
							</div>
							
							<div class="mt-5 d-flex justify-content-center gap-3">
								<button type="button" class="btn btn-light" onclick="window.location.href='<c:url value="/index.jsp"/>'">
									Cancel
								</button>
								<button id="submitBtn" type="submit" class="btn btn-primary">
								    Submit
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="assets/plugins/global/plugins.bundle.js"></script>
	<script src="assets/js/scripts.bundle.js"></script>
	
	<script>
		function togglePassword(inputId, iconElement) {
			const input = document.getElementById(inputId);
			const icon = iconElement.querySelector('i');
			if (input.type === "password") {
				input.type = "text";
				icon.classList.remove("ki-eye");
				icon.classList.add("ki-eye-slash");
			} else {
				input.type = "password";
				icon.classList.remove("ki-eye-slash");
				icon.classList.add("ki-eye");
			}
		}

		document.addEventListener('DOMContentLoaded', function () {
		    const codeInput = document.getElementById('inputCode');
		    const pwdInput = document.getElementById('newPassword');
		    const confirmPwdInput = document.getElementById('confirmPassword');
		    const form = document.getElementById('resetPasswordForm');
		    const submitBtn = document.getElementById('submitBtn');
		    
		    const errorBlock = document.getElementById('errorBlock');
		    const matchErrorMsg = document.getElementById('matchErrorMsg');
		    const reqErrorMsg = document.getElementById('reqErrorMsg');

		    let isPasswordValid = false;
	
		    const rules = {
		        length: { 
		            element: document.getElementById('rule-length'), 
		            validate: val => val.length >= 8 && val.length <= 30 
		        },
		        upper: { 
		            element: document.getElementById('rule-upper'), 
		            validate: val => /[A-Z]/.test(val)
		        },
		        lower: { 
		            element: document.getElementById('rule-lower'), 
		            validate: val => /[a-z]/.test(val)
		        },
		        number: { 
		            element: document.getElementById('rule-number'), 
		            validate: val => /[0-9]/.test(val)
		        }
		    };

		    if (errorBlock) {
		    	submitBtn.disabled = true;
		    }

		    codeInput.addEventListener('input', function() {
		        if (errorBlock) {
		        	errorBlock.classList.add('d-none');
		        }
		        submitBtn.disabled = false;
		    });

		    pwdInput.addEventListener('input', function() {
		        const val = pwdInput.value;
		        let allPassed = true;
	
		        for (const key in rules) {
		            const rule = rules[key];
		            const isValid = rule.validate(val);
		            const indicator = rule.element.querySelector('.indicator');
	
		            if (isValid) {
		                indicator.innerHTML = '<span class="text-success fw-bolder fs-6">✓</span>';
		                rule.element.classList.remove('text-muted');
		                rule.element.classList.add('text-gray-900');
		            } else {
		                indicator.innerHTML = '•';
		                rule.element.classList.remove('text-gray-900');
		                rule.element.classList.add('text-muted');
		                allPassed = false;
		            }
		        }
		        
		        isPasswordValid = allPassed;
		        if(isPasswordValid) {
		        	reqErrorMsg.classList.add('d-none');
		        	pwdInput.classList.remove('is-invalid');
		        } else {
		        	pwdInput.classList.add('is-invalid');
		        }
		        checkMatch();
		    });

		    function checkMatch() {
		    	const val1 = pwdInput.value;
		    	const val2 = confirmPwdInput.value;

		    	if(val2.length > 0) {
			    	if (val1 !== val2) {
			    		matchErrorMsg.classList.remove('d-none');
			    		confirmPwdInput.classList.add('is-invalid');
			    	} else {
			    		matchErrorMsg.classList.add('d-none');
			    		confirmPwdInput.classList.remove('is-invalid');
			    	}
		    	} else {
		    		matchErrorMsg.classList.add('d-none');
		    		confirmPwdInput.classList.remove('is-invalid');
		    	}
		    }

		    confirmPwdInput.addEventListener('input', checkMatch);

		    form.addEventListener('submit', function(e) {
		    	let canSubmit = true;

		    	if (!isPasswordValid) {
		    		reqErrorMsg.classList.remove('d-none');
		    		pwdInput.classList.add('is-invalid');
		    		canSubmit = false;
		    	}

		    	if (pwdInput.value !== confirmPwdInput.value) {
		    		matchErrorMsg.classList.remove('d-none');
		    		confirmPwdInput.classList.add('is-invalid');
		    		canSubmit = false;
		    	}

		    	if (!canSubmit) {
		    		e.preventDefault();
		    	}
		    });
		});
	</script>
</body>
</html>