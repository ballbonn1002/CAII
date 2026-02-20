<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value="en_US" />

<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet"
	type="text/css" />
<script src="assets/plugins/global/plugins.bundle.js"></script>

<!--CKEditor-->
<script src="assets/plugins/custom/ckeditor/ckeditor-decoupled.bundle.js"></script>
<script src="assets/plugins/custom/ckeditor/ckeditor-document.bundle.js"></script>

<!--Summernote-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>




<style>
.main-container {
	width: 795px;
	margin-left: auto;
	margin-right: auto;
}

.banner-img {
	width: 100%;
	height: 540px;
	object-fit: cover;
	display: block;
}

/* Quote */
.ck-content blockquote {
    border-left: 5px solid #f1416c !important; 
    padding: 15px 20px !important;
    margin: 20px 0 !important;
    font-style: italic !important;
    color: #3f4254 !important;
}

/*Code */
.ck-content pre {
    background-color: #f1f1f2 !important; 
    border: 1px solid #e1e3ea !important;
    border-radius: 8px !important;
    padding: 15px !important;
    margin: 20px 0 !important;
    font-size: 13px !important;
    color: #181c32 !important;
    line-height: 1.5 !important;
    overflow-x: auto !important;
}

</style>
</head>
<body class="app-default">
	<div class="app-main flex-column flex-row-fluid">
		<div class="d-flex flex-column flex-column-fluid">
			<!-- Header -->
			<div class="app-toolbar py-3 py-lg-6">
				<div class="app-container container-fluid d-flex flex-stack">
					<div
						class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
						<h1
							class="page-heading d-flex text-gray-900 fw-semibold flex-column justify-content-center my-0">
							Preview Article</h1>

						<ul
							class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/article-feed"
								class="text-muted text-hover-primary">CMS</a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted"><a
								href="demo_dashboard" class="text-muted text-hover-primary">Article</a></li>
						</ul>
					</div>
				</div>
			</div>

			<div class="app-content flex-column-fluid">
				<div class="app-container container-fluid">
					<div class="card mb-10">
						<div
							class="card-header d-flex justify-content-between align-items-center border-0 m-0 p-0">
							<img src="${fileImgPath}" class="banner-img" alt="user">

						</div>
						<div class="card-body d-flex flex-column">
							<div class="card p-10">
							<!-- <span class="fs-5 fw-normal text-danger text-uppercase">Artificial Intelligence</span> -->
								<c:if test="${not empty selectedTagName}">
								<div class="d-flex align-items-center gap-4 ">
								 <c:forEach var="tag" items="${selectedTagName}">
									<span
										class="d-flex badge badge-lg badge-light-danger fw-semibold fs-7">
										${tag.tagName} </span>
								</c:forEach> 
								</div>
								</c:if>
								<h1 class="fw-bold text-danger my-6">${empty article.topic ? '' : article.topic}</h1>
								<div class="row align-items-center justify-content-between">

									<div class="col-auto">
										<div class="d-flex align-items-center gap-4 flex-wrap">

											<div class="d-flex align-items-center gap-2">
												<i class="ki-duotone ki-calendar fs-2"> <span
													class="path1"></span><span class="path2"></span>
												</i> <span> <fmt:formatDate value="${publicDate}"
														pattern="dd MMM yyyy" />
												</span>
											</div>

											<div class="d-flex align-items-center gap-2">
												<i class="ki-duotone ki-feather fs-2"> <span
													class="path1"></span><span class="path2"></span>
												</i> <span>By CubeSoftTech</span>
											</div>

											<div class="d-flex align-items-center gap-2">
												<i class="ki-duotone ki-eye fs-2"> <span class="path1"></span><span
													class="path2"></span><span class="path3"></span>
												</i> <span>327 Views</span>
											</div>

										</div>
									</div>

									<div class="col-auto">
										<div class="d-flex align-items-center gap-3">
											<span>Shares : </span> <a href="#" target="_blank"> <img
												alt="logo facebook" class="h-25px"
												src="${pageContext.request.contextPath}/assets/media/svg/social-logos/facebook.svg"></a>

											<a href="#" target="_blank"> <img alt="logo x"
												class="h-25px"
												src="${pageContext.request.contextPath}/assets/media/svg/social-logos/logo_x.png"></a>

											<a href="#" target="_blank"> <img alt="logo gmail"
												class="h-25px"
												src="${pageContext.request.contextPath}/assets/media/svg/social-logos/gmail.png"></a>

											<a href="#" target="_blank"> <img alt="logo linkedin"
												class="h-25px"
												src="${pageContext.request.contextPath}/assets/media/svg/social-logos/linkedin.svg"></a>
										</div>
									</div>

								</div>
							</div>
							<div class="ck-content py-14">${article.detail}</div>
							<div class="my-5">
										<div class="d-flex align-items-center gap-3">
											<span>Shares : </span> <a href="#" target="_blank"> <img
												alt="logo facebook" class="h-25px"
												src="${pageContext.request.contextPath}/assets/media/svg/social-logos/facebook.svg"></a>

											<a href="#" target="_blank"> <img alt="logo x"
												class="h-25px"
												src="${pageContext.request.contextPath}/assets/media/svg/social-logos/logo_x.png"></a>

											<a href="#" target="_blank"> <img alt="logo gmail"
												class="h-25px"
												src="${pageContext.request.contextPath}/assets/media/svg/social-logos/gmail.png"></a>

											<a href="#" target="_blank"> <img alt="logo linkedin"
												class="h-25px"
												src="${pageContext.request.contextPath}/assets/media/svg/social-logos/linkedin.svg"></a>
										</div>
							</div>
						</div>
					</div>

					<div class="d-flex justify-content-end border-0">
						<button type="button" id="cancelFormBtn"
							onclick="confirmLeaveForm('article_feed')"
							class="btn btn-lg btn-light fw-medium text-light-inverse px-3 py-4 me-2">Cancel
						</button>
						<button type="button" id="editButton"
							onclick="window.location.href='article_edit?articleId=${article.articleId}'"
							class="btn btn-lg btn-primary fw-medium text-light-inverse px-4 py-4 me-2">
							Edit</button>

					</div>
				</div>

			</div>
		</div>
	</div>

	<script>
	function renderPreviewContent(html) {
	    if (!html) return '';
	    //หาเนื้อหาใน <style>
	    return html.replace(/<style[^>]*>([\s\S]*?)<\/style>/gi, function(match, cssContent) {
	        //เติม Class .ck-content นำหน้าทุก Selector e.g. h1 {...} จะกลายเป็น .ck-content h1 {...}
	        const scopedCss = cssContent.replace(/(^|[\s,{}])([a-zA-Z0-9\._\-#\*\[\]\:]+)(?=[^{}]*\{)/g, function(selectorMatch, p1, p2) {
	            // ถ้า selector คือ body เปลี่ยนเป็น .ck-content
	            if (p2.trim() === 'body') return p1 + ' .ck-content';
	            return p1 + ' .ck-content ' + p2;
	        });
	        
	        return '<style>' + scopedCss + '</style>';
	    });
	}

	//โหลดหน้า Preview เสร็จ เรียกใช้ renderPreviewContent
	document.addEventListener("DOMContentLoaded", function() {
	    const detailContainer = document.querySelector('.ck-content');
	    const rawContent = detailContainer.innerHTML;
	    detailContainer.innerHTML = renderPreviewContent(rawContent);
	});
	
function confirmLeaveForm(redirectUrl){
	
    Swal.fire({
        title: "Are you sure?!",
        text: "Closing will discard any unsaved data.",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes, discard it",
        cancelButtonText: "Cancel",
        buttonsStyling: false,
        customClass: {
            confirmButton: "btn btn-danger",
            cancelButton: "btn btn-secondary"
        }
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = redirectUrl;
        }
    });
}
</script>

</body>
</html>