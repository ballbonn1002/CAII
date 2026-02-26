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

<!--Summernote-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>

<style>


#summernote {
	width: 100%;
	margin-left: auto;
	margin-right: auto;
}

#summernote {
	border: 1px solid #d1d5db;
	border-radius: 6px;
	overflow: hidden;
	min-height: 500px;
	padding: 12px;
}

/* UI Summernot */
.note-editor {
  border: 1px solid #d1d5db !important;
  border-radius: 10px !important;
  overflow: hidden;
  transition: all 0.2s ease;
  background: #fff;
}

.note-editor:focus-within {
  border-color: #3b82f6 !important;
  box-shadow: 0 0 0 3px rgba(59,130,246,.15);
}

/*toolbar */
.note-toolbar {
  background: #f9fafb !important;
  border-bottom: 1px solid #e5e7eb !important;
  padding: 8px;
}

/*toolbar buttons */
 .note-btn {
  border-radius: 6px !important;
  transition: all .15s ease;
  margin-right: 8px;
} 

.note-btn:hover {
  background: #e5e7eb !important;
} 

/* Quote */
.note-editable blockquote {
    border-left: 5px solid #f1416c !important; 
    padding: 15px 20px !important;
    margin: 20px 0 !important;
    color: #3f4254 !important;
}

/* Code */
.note-editable pre {
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

/* edit area */
.note-editing-area {
  background: #ffffff;
}

.note-editable {
  min-height: 300px;
  padding: 20px;
  font-size: 14px;
  line-height: 1.7;
  color: #111827;
  font-family: system-ui, sans-serif;
}

.note-placeholder {
  color: #9ca3af !important;
}

.note-editable::-webkit-scrollbar {
  width: 8px;
}

.note-editable::-webkit-scrollbar-thumb {
  background: #cbd5f5;
  border-radius: 6px;
}

/* fullscreen mode */
.note-editor.note-frame.fullscreen {
  background: white;
  padding: 15px;
}

.note-editable h1 { font-size: 30px; margin: 16px 0; }
.note-editable h2 { font-size: 24px; margin: 14px 0; }
.note-editable h3 { font-size: 20px; margin: 12px 0; }

.note-btn.dropdown-toggle::after {
  display: none !important;
} 

.note-toolbar .note-btn {
  margin-right: 0 !important;
}

.note-toolbar .note-btn-group {
  margin-right: 10px !important;
}

/* ปุ่มใน group ชิดกัน */
.note-toolbar .note-btn-group .note-btn {
  border-radius: 6px !important;
}

.note-modal .note-modal-footer {
    display: flex !important;
    align-items: center !important;
    justify-content: flex-end !important;
    padding: 1rem !important;
    height: auto !important;
    min-height: 60px !important;
    
}

.note-modal .note-modal-footer .note-btn {
    float: none !important;
    margin: 0 10px !important;
    position: static !important;
   
}

.note-modal-content {
    border: none !important;
    border-radius: 12px !important;
    box-shadow: 0 15px 50px rgba(0,0,0,0.2) !important;
    overflow: hidden !important;
}

.note-modal-header {
    border-bottom: 1px solid #eee !important;
    padding: 15px 20px !important;
}

.note-modal-title {
    font-size: 1.2rem !important;
    font-weight: 600 !important;
    color: #111827 !important;
}

.note-dropdown-menu{
	width: 350px !important;
}
.note-palette{
	margin: 2px 0;
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
							Edit Article</h1>

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
					<form id="formAddArticle" action="article_perform_update"
							method="POST" class="form" autocomplete="off" enctype="multipart/form-data">
							<input type="hidden" name="submitType" id="submitType">
						<div class="card mb-10">
							<div
								class="card-header d-flex align-items-center justify-content-between">
								<h3 class="fw-semibold text-gray-900 mb-0">Edit Article</h3>
								<div
									class="d-flex align-items-center gap-2 fw-semibold text-gray-900">
									<span id="statusText" class="text-gray-700">Active</span> <label
										class="form-check form-switch form-check-success form-check-solid m-0">
										<input id="statusSwitch"
										class="form-check-input h-20px w-35px" type="checkbox"
										 <c:if test="${article.status == 1}">checked</c:if> />
									</label>
									 <input type="hidden" name="article_status" id="article_status" value="1">
								</div>

							</div>

							<div class="card-body ">
								<div class="row ">
									<div class="col-12 col-md-8 mt-0">
										<div class="col-12">
											<label class="required fw-medium text-gray-800 mb-2">Title</label>
											<input type="text" class="form-control text-gray-700"
												placeholder="Title" name="article_title" id="article_title"
												value="${empty article.topic ? '' : article.topic}" />
										</div>
										<div class="col-12 mt-5">
											<label class="required fw-medium text-gray-800 mb-2">Type</label>
											<select name="article_type" id="article_type"
												class="form-select text-gray-700" data-control="select2"
												data-placeholder="Select Type">
												<option></option>

											    <c:forEach var="typeItems" items="${articleTypeList}">
											        <option value="${typeItems.articleTypeId}"
											            <c:if test="${typeItems.articleTypeId == article.articleTypeId}">
											                selected
											            </c:if>>
											            ${typeItems.name}
											            <c:if test="${typeItems.articleTypeId == 1}">(news)</c:if>
														<c:if test="${typeItems.articleTypeId == 2}">(blog)</c:if>
														<c:if test="${typeItems.articleTypeId == 3}">(news)</c:if>
											        </option>
											    </c:forEach>
											</select>
										</div>
										<div class="col-12  mt-5">
											<label class="fw-medium text-gray-800 mb-2">Tag</label>
											<select name="article_tag" id="article_tag"
												class="form-select text-gray-700" data-control="select2"
												data-close-on-select="false" data-placeholder="Select Tag"
												data-allow-clear="true" multiple="multiple">
												<c:if test="${empty tagList}">
												    <option disabled>Select Tag</option>
												</c:if>

												<c:forEach var="tagItems" items="${tagList}">
												    <c:set var="isSelected" value="false" />
												
												    <c:if test="${selectedTagId != null}">
												        <c:forEach var="id" items="${selectedTagId}">
												            <c:if test="${id == tagItems.tagId}">
												                <c:set var="isSelected" value="true" />
												            </c:if>
												        </c:forEach>
												    </c:if>
												
												    <option value="${tagItems.tagId}"
												        <c:if test="${isSelected}">selected</c:if>>
												        ${tagItems.tagName}
												    </option>
												</c:forEach>
											</select>
										</div>
										<div class="col-12 mt-5">
											<label class="fw-medium text-gray-800 mb-2">Related
												Article</label> <select name="article_related"
												class="form-select text-gray-700" id="article_related"
												data-control="select2" data-close-on-select="false"
												data-placeholder="Select Related Article"
												data-allow-clear="true" multiple="multiple">
												<c:if test="${empty articleList}">
												    <option disabled>Select Related Article</option>
												</c:if>
											<c:forEach var="articleItems" items="${articleList}">
											    <c:set var="isSelected" value="false" />
											
											    <c:if test="${selectedRelatedId != null}">
											        <c:forEach var="id" items="${selectedRelatedId}">
											            <c:if test="${id == articleItems.articleId}">
											                <c:set var="isSelected" value="true" />
											            </c:if>
											        </c:forEach>
											    </c:if>
											
											    <option value="${articleItems.articleId}"
											        <c:if test="${isSelected}">selected</c:if>>
											        ${articleItems.topic}
											    </option>
											</c:forEach>
											</select>
										</div>
										<div class="col-12 mt-5">
											<label class="required required fw-medium text-gray-800 mb-2">Author</label>
											<input type="text" class="form-control text-gray-700" disabled
												placeholder="Author" name="user_create"
												id="user_create" value="${userCreate.id} ${not empty userCreate.name ? '- ' : ''}${userCreate.name}" />
										</div>
										<div class="row col-12 ">
											<div class="col-12 col-md-6 mt-5">
												<label class="required fw-medium text-gray-800 mb-2">Publication
													Date</label>
												<div class="position-relative">
													<i
														class="ki-duotone ki-calendar-8 text-gray-500 position-absolute top-50 translate-middle-y ms-4 fs-2">
														<span class="path1"></span><span class="path2"></span> <span
														class="path3"></span><span class="path4"></span> <span
														class="path5"></span><span class="path6"></span>
													</i> <input type="text"
														class="form-control ps-12 text-gray-700"
														placeholder="Publication Date" name="publication_date"
														id="publication_date" value="${publicDate}" />

												</div>
											</div>
											<div class="col-12 col-md-6 mt-5">
												<label class="required fw-medium text-gray-800 mb-2">Publication
													Time</label>
												<div class="position-relative">
													<i
														class="ki-duotone ki-calendar-8 text-gray-500 position-absolute top-50 translate-middle-y ms-4 fs-2">
														<span class="path1"></span><span class="path2"></span> <span
														class="path3"></span><span class="path4"></span> <span
														class="path5"></span><span class="path6"></span>
													</i> <input type="text"
														class="form-control ps-12  text-gray-700"
														placeholder="Publication Time" name="publication_time"
														id="publication_time" value="${publicTime}" />
												</div>
											</div>
										</div>


									</div>

									<div class="col-12 col-md-4 mt-10 mt-md-0">
										<h3 class="fw-semibold text-gray-900 text-start">
											Cover Photo <span class="fs-6 text-primary fw-semibold">Shown
												in Cover</span>
										</h3>
										<div id="errorMsg" class="text-center text-danger"></div>
										<div class="col-12 d-flex justify-content-center mt-6">
										<input type="hidden" id="hasOldImage" value="${not empty fileImgPath}" />
											<div id="ktImageInput"
												class="image-input image-input-outline"
												data-kt-image-input="true"
												style="background-image: url('${pageContext.request.contextPath}/assets/media/svg/avatars/blank.svg');">
 												<div class="image-input-wrapper" id="imageInputWrapper"
											         style="
											            width:300px;
											            height:300px;
											            aspect-ratio: 3 / 2;
											            background-image:url( <c:choose>
												                <c:when test="${not empty fileImgPath}">
												                    ${pageContext.request.contextPath}${fileImgPath}
												                </c:when>
												                <c:otherwise>
												                    ${pageContext.request.contextPath}/assets/media/svg/avatars/blank.svg
												                </c:otherwise>
												            </c:choose>);
											            background-size:contain;
												        background-repeat:no-repeat;
												        background-position:center;
												        background-color:#f5f5f5;
											         ">
											    </div>
												

												<label id="changeBtn"
													class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow"
													data-kt-image-input-action="change"
													data-bs-toggle="tooltip" data-bs-dismiss="click"
													title="Change avatar"> <i
													class="ki-duotone ki-pencil fs-6"> <span class="path1"></span>
														<span class="path2"></span></i>
														 <input id="imageInputFile"
													type="file" name="fileUpload" accept=".png, .jpg, .jpeg" />

													<input id="avatarRemoveHidden" type="hidden"
													name="avatar_remove" value="false" />
												</label> <span id="cancelBtn"
													class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow"
													data-kt-image-input-action="cancel"
													data-bs-toggle="tooltip" data-bs-dismiss="click"
													title="Cancel Image"> <i
													class="ki-outline ki-cross fs-3"></i>
												</span>
												<c:if test="${not empty fileImgPath}">
											    <span id="removeBtn"
											        class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow"
											        data-kt-image-input-action="remove"
											        data-bs-toggle="tooltip"
											        data-bs-dismiss="click"
											        title="Remove Image">
											        <i class="ki-outline ki-cross fs-3"></i>
											    </span>
											</c:if>

											</div>
										</div>
										<div
											class="form-text fs-7 text-muted fw-medium mt-6 mb-0  d-flex justify-content-center">Allowed
											file types: png, jpg, jpeg.</div>


										<div class="col-12  mt-md-4">
											<label class="fw-medium text-gray-800 mb-2">Cover Alt</label>
											<textarea class="form-control text-gray-700" name="cover_alt"
												placeholder="Cover Alt" rows="3">${empty fileImgAlt ? '' : fileImgAlt}</textarea>

										</div>
									</div>
								</div>
							</div>


						</div>

						<div class="card mb-10">
							<div
								class="card-header d-flex align-items-center justify-content-between">
								<h3 class="fw-semibold text-gray-900 mb-0">Content Detail</h3>
							</div>

							<div class="card-body ckeditor-wrapper">
								<div id="summernote"> </div>
								
							</div>
							<input type="hidden" name="detail" id="detailInput" value="${fn:escapeXml(article.detail)}">
						</div>
						
						<div class="card mb-10">
							<div
								class="card-header d-flex align-items-center justify-content-between">
								<h3 class="fw-semibold text-gray-900 mb-0">Page URL Detail</h3>
							</div>

							<div class="card-body page-url">
								
								<div class="row col-12 ">
											<div class="col-12 col-md-4 mt-5 mt-md-0">
												<label class="fw-medium text-gray-800 mb-2">Forward to</label>
												
												<input type="text" disabled
														class="form-control text-gray-700"
														placeholder="Forward to" name="forward_to"
														id="forward_to" value="${pageUri.forwardTo}" />
														
											</div>
											<div class="col-12 col-md-4 mt-5 mt-md-0">
												<label class="fw-medium text-gray-800 mb-2">Model</label>
												<input type="text" disabled
														class="form-control text-gray-700"
														placeholder="Model" name="model"
														id="model" value="${pageUri.model}" />
												
											</div>
											
											<div class="col-12 col-md-4 mt-5 mt-md-0">
												<label class="fw-medium text-gray-800 mb-2">Model ID</label>
												<input type="text" disabled
														class="form-control text-gray-700"
														placeholder="Model ID" name="model_id"
														id="model_id" value="${pageUri.modelId}" />
											</div>
										</div>
									<div class="col-12 mt-5">
										<label class="required fw-medium text-gray-800 mb-2">Page URL</label>
										<input type="text" 
												class="form-control text-gray-700"
												placeholder="Page URL" id="pageUriId" name="pageUriId" value="${empty pageUri.pageUriId ? '' :pageUri.pageUriId}" />
														
									</div>
									<div class="col-12 mt-5">
										<label class="required fw-medium text-gray-800 mb-2">Title</label>
										<input type="text" 
												class="form-control text-gray-700" maxlength="100"
												placeholder="Title" id="pageUriTitle" name="pageUriTitle" value="${empty pageUri.pageUriTitle ? '' :pageUri.pageUriTitle}"/>				
									</div>
									<div class="col-12 mt-5">
										<label class="required fw-medium text-gray-800 mb-2">Meta</label>
										<textarea class="form-control text-gray-700" id="meta" name="meta"
												placeholder="Meta" rows="3">${empty pageUri.meta ? '' : pageUri.meta}</textarea>		
									</div>
									<div class="col-12 mt-5">
											<label class="fw-medium text-gray-800 mb-2">Description</label>
											<textarea class="form-control text-gray-700" id="pageUriDescription" name="pageUriDescription"
												placeholder="Description" rows="3">${empty pageUri.pageUriDescription ? '' : pageUri.pageUriDescription}</textarea>
									</div>
								</div>
							</div>

						<div class="d-flex justify-content-end border-0">
							<button type="button" id="cancelFormBtn"
								onclick="confirmLeaveForm('article_feed')"
								class="btn btn-lg btn-light fw-medium text-light-inverse px-3 py-4 me-2">Cancel
							</button>
							<button type="button" id="preview"  onclick="previewForm()"
								class="btn btn-lg btn-primary fw-medium text-light-inverse px-3 py-4 me-2">Preview
							</button>
							<button type="button" id="saveFormBtn"
								class="btn btn-success text-white fw-medium px-3 py-4"
								onclick="submitForm()">Submit</button>
						</div>
						<input type="hidden" name="articleId" value="${article.articleId}">
					</form>
				</div>
			</div>
		</div>
	</div>
	
<script type="text/javascript">
/* แปลง <style> เป็น <x-style> */
function changeStyles(html){
	if(!html) return '';
	return html.replace(/<style/gi, '<x-style style="display: none;"')
    .replace(/<\/style>/gi, '</x-style>');
}
/* แปลงกลับเป็น <style> */
function unChangeStyles(html) {
    if (!html) return '';
    return html.replace(/<x-style[^>]*>/gi, '<style>')
               .replace(/<\/x-style>/gi, '</style>');
}

function initSummernote(content) {
    $('#summernote').summernote({
        placeholder: '',
        tabsize: 2,
       iframe: true, 
        iframeAttributes: {
            class: 'summernote-iframe'
        }, 
        codeviewFilter: false,
        codeviewIframeFilter: false,
        leTags: [
    	    { title: 'Normal', tag: 'p' },
    	    { title: 'Heading 1', tag: 'h1' },
    	    { title: 'Heading 2', tag: 'h2' },
    	    { title: 'Heading 3', tag: 'h3' },
    	    { title: 'Quote', tag: 'blockquote' },
    	    { title: 'Code', tag: 'pre' }
    	  ],
    	  toolbar: [
    	    // style
    	    ['style', ['style']],

    	    // font
    	    ['font', [
    	      'bold', 'italic',  'underline', 'strikethrough',
    	      'superscript', 'subscript', 'clear'
    	    ]],

    	    // font size/name/color
    	    ['fontname', ['fontname']],
    	    ['fontsize', ['fontsize']],
    	    ['color', ['color']],

    	    // paragraph
    	    ['para', [ 'ul', 'ol', 'paragraph', 'height'  ]],

    	    // insert
    	    ['insert', [ 'link', 'picture', 'video', 'table', 'hr' ]],

    	    // misc/view
    	    ['view', [ 'undo', 'redo', 'fullscreen', 'codeview', 'help' ]]
    	  ],
    	  callbacks: {
    		    onInit: function () {
    		        const $editor = $(this);
    		        // user กดดู HTML code จะเปลี่ยน <x-style> กลับเป็น <style>
    		        $editor.next().on('click', '.btn-codeview', function () {
    		            setTimeout(() => {
    		                const codable = $editor.next().find('.note-codable');

    		                if (codable.length) {
    		                    // user view จะแสดง <style>
    		                    codable.val(
    		                        unChangeStyles(codable.val())
    		                    );
    		                }
    		            }, 0);

    		        });
    		    }, //ออกจาก code view
    		    onBlurCodeview: function () {
    		        const $editor = $(this);
    		        const codable = $editor.next().find('.note-codable');

    		        if (codable.length) {
    		            // แปลง<style> เป็น <x-style> โหลด HTML กลับเข้า editor
    		            const safe = changeStyles(codable.val());
    		            $editor.summernote('code', safe);
    		        }
    		    }
    		}
    });

    /* $('#summernote').summernote('code', content); */
    $('#summernote').summernote('code', changeStyles(content));
}
</script>

	<script>
	var editorInstance;
	
    document.addEventListener("DOMContentLoaded", function () {
    $('#summernote').summernote({
	      placeholder: '',
	      tabsize: 2,
	      iframe: true, 
	        iframeAttributes: {
	            class: 'summernote-iframe'
	        }, 
	      codeviewFilter: false,
	      codeviewIframeFilter: false,
	      leTags: [
	    	    { title: 'Normal', tag: 'p' },
	    	    { title: 'Heading 1', tag: 'h1' },
	    	    { title: 'Heading 2', tag: 'h2' },
	    	    { title: 'Heading 3', tag: 'h3' },
	    	    { title: 'Quote', tag: 'blockquote' },
	    	    { title: 'Code', tag: 'pre' }
	    	    ],
	      	  toolbar: [
	      	    // style
	      	    ['style', ['style']],

	      	    // font
	      	    ['font', [
	      	      'bold', 'italic',  'underline', 'strikethrough',
	      	      'superscript', 'subscript', 'clear'
	      	    ]],

	      	    // font size/name/color
	      	    ['fontname', ['fontname']],
	      	    ['fontsize', ['fontsize']],
	      	    ['color', ['color']],

	      	    // paragraph
	      	    ['para', [ 'ul', 'ol', 'paragraph', 'height'  ]],

	      	    // insert
	      	    ['insert', [ 'link', 'picture', 'video', 'table', 'hr' ]],

	      	    // misc/view
	      	    ['view', [ 'undo', 'redo', 'fullscreen', 'codeview', 'help' ]]
	      	  ],
	      	callbacks: {
    		    onInit: function () {
    		        const $editor = $(this);
    		        // user กดดู HTML code จะเปลี่ยน <x-style> กลับเป็น <style>
    		        $editor.next().on('click', '.btn-codeview', function () {
    		            setTimeout(() => {
    		                const codable = $editor.next().find('.note-codable');

    		                if (codable.length) {
    		                    // user view จะแสดง <style>
    		                    codable.val(
    		                        unChangeStyles(codable.val())
    		                    );
    		                }
    		            }, 0);

    		        });
    		    }, //ออกจาก code view
    		    onBlurCodeview: function () {
    		        const $editor = $(this);
    		        const codable = $editor.next().find('.note-codable');

    		        if (codable.length) {
    		            // แปลง<style> เป็น <x-style> โหลด HTML กลับเข้า editor
    		            const safe = changeStyles(codable.val());
    		            $editor.summernote('code', safe);
    		        }
    		    }
    		}
	    });
    const savedContent = document.getElementById("detailInput").value;

    $('#summernote').summernote('code', changeStyles(savedContent));
	    if(editorInstance) {
	        editorInstance.setData(changeStyles(savedContent));
	    }
    });
		</script>

	<script>
		document.addEventListener("DOMContentLoaded", function () {
			flatpickr("#publication_date", {
		        dateFormat: "Y-m-d",  
		        altInput: true,
		        altFormat: "d M Y",   
		        locale: "en",        
		        allowInput: false,
		       
		    });
			
			$("#publication_time").flatpickr({
			    enableTime: true,
			    noCalendar: true,
			    dateFormat: "H:i",
			    time_24hr: true,
			});
			
			const switchInput = document.getElementById("statusSwitch");
		    const statusText = document.getElementById("statusText");
		    const statusHidden = document.getElementById("article_status");
		    
		    function updateStatus() {
		        if (switchInput.checked) {
		            statusText.textContent = "Active";
		            statusHidden.value = "1";
		        } else {
		            statusText.textContent = "Draft";
		            statusHidden.value = "0";
		        }
		    }
		 	
		    updateStatus();
		    switchInput.addEventListener("change", updateStatus);
		});
	</script>
	
	<script>
			document.addEventListener("DOMContentLoaded", function () {		
			    const imageInput = document.getElementById("imageInputFile");
			
			    imageInput.addEventListener("change", function () {
			
			        const file = this.files[0];
			        const maxSize = 2 * 1024 * 1024;
			        const errorMsg = document.getElementById("errorMsg");
			
			        if (!file) return;
			
			        if (file.size > maxSize) {
			
			            errorMsg.textContent = "Image must be smaller than 2MB.";
			            this.value = "";
			
			
			        } else {
			            errorMsg.textContent = "";
			        }
			
			    });
			    
			    document.getElementById("removeBtn")?.addEventListener("click", () => {

			        const wrapper = document.getElementById("imageInputWrapper");

			        //Reset กลับ default
			        wrapper.style.width = "300px";
			        wrapper.style.height = "300px";
			        
			     //Set default img
			        wrapper.style.backgroundImage = "url('${pageContext.request.contextPath}/assets/media/svg/avatars/blank.svg')";

			        wrapper.style.backgroundSize = "contain";
			        wrapper.style.backgroundRepeat = "no-repeat";
			        wrapper.style.backgroundPosition = "center";

			    });
			    
			    document.getElementById("cancelBtn")?.addEventListener("click", () => {

			        const wrapper = document.getElementById("imageInputWrapper");

			        //Reset กลับ default
			        wrapper.style.width = "300px";
			        wrapper.style.height = "300px";
			        
			      //Set default img
			        wrapper.style.backgroundImage =
			            "url('${pageContext.request.contextPath}/assets/media/svg/avatars/blank.svg')";

			        wrapper.style.backgroundSize = "contain";
			        wrapper.style.backgroundRepeat = "no-repeat";
			        wrapper.style.backgroundPosition = "center";

			    });
			
			});
	</script>
	

	<script>
	document.getElementById("removeBtn")?.addEventListener("click", () => {
	    document.getElementById("avatarRemoveHidden").value = "true";
	    document.getElementById("hasOldImage").value = "false";
	});
	
	var editorInstance;
	
	function previewForm() {
	    document.getElementById("submitType").value = "preview";
	    submitForm();
	}
	function submitReal() {
	    document.getElementById("submitType").value = "save";
	    submitForm();
	}
	
	function submitForm(){
		const content = $('#summernote').summernote('code');
	    /* document.getElementById("detailInput").value = content; */
	    // แปลงกลับเป็นแท็ก style ปกติก่อน Save
	    const finalContent = unChangeStyles(content);
	    document.getElementById("detailInput").value = finalContent;
	    
		var errorFields = [];
		
		const form = document.getElementById("formAddArticle");
	    
		  ["article_title", "publication_date", "publication_time","meta","pageUriDescription","pageUriTitle"]
		  .forEach(id => {
		      const element = document.getElementById(id);
		      if (element && element.value) {
		          element.value = element.value.trim();
		      }
		  });
		  
		  const articleTitle  = document.getElementById("article_title").value
		  const articleType = document.getElementById("article_type").value
		 /*  const articleTag = $("#article_tag").val();
		  const articleRelated = $("#article_related").val(); */
		  const userCreate = document.getElementById("user_create").value
		  const publicDate = document.getElementById("publication_date").value
		  const publicTime  = document.getElementById("publication_time").value
		  const contentText = content.replace(/<[^>]*>/g, "").trim();
		  const imageFile = document.getElementById("imageInputFile");
		  const meta = document.getElementById("meta").value
		  const pageUriTitle  = document.getElementById("pageUriTitle").value
		  
		  if(!articleTitle) errorFields.push("Title")
		  if(!articleType) errorFields.push("Type")
		  /* if (!articleTag || articleTag.length === 0)
		    errorFields.push("Tag");

		  if (!articleRelated || articleRelated.length === 0)
		      errorFields.push("Related"); */
		  
		  if(!userCreate) errorFields.push("Author")
		  if(!publicDate) errorFields.push("Publication Date")
		  if(!meta) errorFields.push("Meta")
		  if(!pageUriTitle) errorFields.push("Title")
		  if(!publicTime) errorFields.push("Publication Time")
		  
		 /*  if (!imageFile.files || imageFile.files.length === 0) {
			    errorFields.push("Cover Photo");
			    imageFile.classList.add("border-danger");
			} else {
				imageFile.classList.remove("border-danger");
			} */
			const removed =
			    document.getElementById("avatarRemoveHidden").value === "true";

			const hasOldImage =
			    document.getElementById("hasOldImage").value === "true";

			if (!removed && !hasOldImage &&
			    (!imageFile.files || imageFile.files.length === 0)) {
			    errorFields.push("Cover Photo");
			}
		  if(!contentText) errorFields.push("Content Detail")
		  
		  if (errorFields.length > 0) {
			  window.scrollTo({
			        top: 0,
			        behavior: "smooth"
			    });
			  document.activeElement.blur();
			  
			  Swal.fire({
		    		title: "Please complete the form!",
		    		html: "Please fill in the following fields:<br><strong>" + errorFields.join(", ") + "</strong>",
			 	    icon: "error",
			 	    confirmButtonText: "OK",
			 	    buttonsStyling: false,
			 	    customClass: {
			 	       confirmButton: "btn btn-danger",
			 	   }
			    })
				return false;
		    } 
		  
		  Swal.fire({
		    	 title: "Are you sure?!",
		 	        text: "Do you want to save the changes?",
		 	        icon: "warning",
		 	        showCancelButton: true,
		 	        confirmButtonText: "Save",
		 	        cancelButtonText: "Close",
		 	        buttonsStyling: false,
		 	        customClass: {
		 	            confirmButton: "btn btn-success",
		 	            cancelButton: "btn btn-secondary"
		 	        }
		    }).then((result) => {
		        if (result.isConfirmed) {      	
		        	form.submit();
		        }
		    });
		  return false;
	}
	
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