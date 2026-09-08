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

#summernote  {
	width: 100%;
	margin-left: auto;
	margin-right: auto;
}

#summernote {
	border: 1px solid #d1d5db;
	border-radius: 6px;
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
/* tagify */
.tags-look .tagify__dropdown__item{
    display: inline-block;
    vertical-align: middle;
    border-radius: 3px;
    padding: .3em .5em;
    border: 1px solid #CCC;
    background: #F3F3F3;
    margin: .2em;
    font-size: .85em;
    color: black;
    transition: 0s;
}

.tags-look .tagify__dropdown__item--active{
    border-color: black;
}

.tags-look .tagify__dropdown__item:hover{
    background: lightyellow;
    border-color: gold;
}

.tags-look .tagify__dropdown__item--hidden {
    max-width: 0;
    max-height: initial;
    padding: .3em 0;
    margin: .2em 0;
    white-space: nowrap;
    text-indent: -20px;
    border: 0;
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
							class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
							New Article</h1>

						<ul
							class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
							<li class="breadcrumb-item text-muted"><a
								href="${pageContext.request.contextPath}/demo_dashboard"
								class="text-muted text-hover-primary">Home</a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted"><a
								class="text-muted text-hover-primary">CMS</a></li>
							<li class="breadcrumb-item"><span
								class="bullet bg-gray-500 w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted"><a
								href="/article_feed" class="text-muted text-hover-primary">Article</a></li>
						</ul>
					</div>
				</div>
			</div>

			<div class="app-content flex-column-fluid">
				<div class="app-container container-fluid">
					<form id="formAddArticle" action="article_perform_add"
						method="POST" class="form" autocomplete="off"
						enctype="multipart/form-data">
						<input type="hidden" name="tempKey" id="tempKey" value="<%= String.valueOf(System.currentTimeMillis()) %>">
						<input type="hidden" name="submitType" id="submitType">
						<div class="card mb-10">
							<div
								class="card-header d-flex align-items-center justify-content-between">
								<h3 class="fw-semibold text-gray-900 mb-0">New Article</h3>
								<div
									class="d-flex align-items-center gap-2 fw-semibold text-gray-900">
									<span id="statusText" class="text-gray-700">Active</span> <label
										class="form-check form-switch form-check-success form-check-solid m-0">
										<input id="statusSwitch"
										class="form-check-input h-20px w-35px" type="checkbox"/>
									</label> <input type="hidden" name="article_status" id="article_status"
										value="0">
								</div>
							</div>

							<div class="card-body ">
								<div class="row ">
									<div class="col-12 col-md-8 mt-0">
										<div class="col-12">
											<label class="required fw-medium text-gray-800 mb-2">Title</label>
											<input type="text" class="form-control text-gray-700"
												placeholder="Title" name="article_title" id="article_title"
												value="" />
										</div>
										<div class="col-12 mt-5">
											<label class="required fw-medium text-gray-800 mb-2">Type</label>
											<select name="article_type" id="article_type"
												class="form-select text-gray-700" data-control="select2"
												data-placeholder="Select Type">
												<option></option>
												<c:forEach var="typeItems" items="${articleTypeList}">
													<option value="${typeItems.articleTypeId}">
														${typeItems.name}
														<c:if test="${typeItems.articleTypeId == 1}">(news)</c:if>
														<c:if test="${typeItems.articleTypeId == 2}">(blog)</c:if>
														<c:if test="${typeItems.articleTypeId == 3}">(news)</c:if>
													</option>
												</c:forEach>
											</select>
										</div>
										<div class="col-12 mt-5">
											<label class="fw-medium text-gray-800 mb-2">Tags</label>
											<input class="form-control tagify--custom-dropdown" name="article_tag" id="article_tag"/>
										</div>
										<div class="col-12 mt-5">
											<label class="fw-medium text-gray-800 mb-2">Related
												Article</label> <select name="article_related"
												class="form-select text-gray-700" id="article_related"
												data-control="select2" data-close-on-select="false"
												data-placeholder="Select Related Article"
												data-allow-clear="true" multiple="multiple">
												<c:forEach var="articleItems" items="${articleList}">
													<option value="${articleItems.articleId }">${articleItems.topic}</option>
												</c:forEach>
											</select>
										</div>
										<div class="col-12 mt-5">
											<label class="required required fw-medium text-gray-800 mb-2">Author</label>
											<input type="text" class="form-control text-gray-700"
												disabled placeholder="Author" name="user_create"
												id="user_create"
												value="${user.id} ${not empty user.name ? '- ' : ''}${user.name}" />
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
														id="publication_date" value="" />

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
														id="publication_time" value="" />
												</div>
											</div>
										</div>


									</div>

									<div class="col-12 col-md-4 mt-10 mt-md-0">
										<h3 class="fw-semibold text-gray-900 text-start">
											Cover Photo <span class="fs-6 text-primary fw-semibold">Shown
												in Cover</span>
										</h3>
										<span class="fs-6 text-center text-danger">กรุณาอัปโหลดไฟล์ที่มีชื่อเป็นภาษาอังกฤษเท่านั้น</span>
										<div id="errorMsg" class="text-center text-danger"></div>
										<div class="col-12 d-flex justify-content-center mt-6">

											<div id="ktImageInput"
												class="image-input image-input-outline"
												data-kt-image-input="true"
												style="background-image: url('${pageContext.request.contextPath}/assets/media/svg/avatars/blank.svg');">
											 <div class="image-input-wrapper" id="imageInputWrapper"
											         style="
											            width:300px;
											            height:300px;
											            aspect-ratio: 3 / 2;
											            background-image:url('${pageContext.request.contextPath}/assets/media/svg/avatars/blank.svg');
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
													title="Change File"> <i
													class="ki-duotone ki-pencil fs-6"> <span class="path1"></span>
														<span class="path2"></span></i> 
														<input id="imageInputFile"
													type="file" name="fileUpload" accept=".png, .jpg, .jpeg" />

													<input id="fileRemoveHidden" type="hidden"
													name="file_remove" value="false" />
												</label> <span id="cancelBtn"
													class="btn btn-icon btn-circle btn-color-muted btn-active-color-primary w-30px h-30px bg-body shadow"
													data-kt-image-input-action="cancel"
													data-bs-toggle="tooltip" data-bs-dismiss="click"
													title="Cancel File"> <i
													class="ki-outline ki-cross fs-3"></i>
												</span>
												

											</div>


										</div>
										<div
											class="form-text fs-7 text-muted fw-medium mt-6 mb-0  d-flex justify-content-center">Allowed
											file types: png, jpg, jpeg.</div>


										<div class="col-12  mt-md-4">
											<label class="fw-medium text-gray-800 mb-2">Cover Alt</label>
											<textarea class="form-control text-gray-700" name="cover_alt"
												placeholder="Cover Alt" rows="3"></textarea>
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
								<div id="editorError" class="text-danger mb-2 text-center"></div>
								<div id="summernote"> </div>
								 
							</div>
							<input type="hidden" name="detail" id="detailInput">
						</div>

						<div class="d-flex justify-content-end border-0">
							<button type="button" id="cancelFormBtn"
								onclick="confirmLeaveForm('article_feed')"
								class="btn btn-lg btn-light fw-medium text-light-inverse px-3 py-4 me-2">Cancel
							</button>
							<button type="button" id="preview" onclick="previewForm()"
								class="btn btn-lg btn-primary fw-medium text-light-inverse px-3 py-4 me-2">Preview
							</button>
							<button type="button" id="saveFormBtn"
								class="btn btn-success text-white fw-medium px-3 py-4"
								onclick="submitReal()">Submit</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	

	<script>
	var editorInstance;

	function initSummernote(content="") {
	    function getEditorHeight() {
			const el = document.getElementById('summernote');
			const topOffset = el.getBoundingClientRect().top + window.scrollY;
			const bottomReserve = 140;
			const height = window.innerHeight - topOffset - bottomReserve;
			return height > 500 ? height : 500; 
		}

		$('#summernote').summernote({
			placeholder: '',
			tabsize: 2,
			height: getEditorHeight(),
			codeviewFilter: false,
			codeviewIframeFilter: false,
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
				callbacks : {
						onImageUpload : function(files) {
							for (var i = files.length - 1; i >= 0; i--) {
								sendFile(files[i], this);
							}
						},
						onMediaDelete : function(target) {
							deleteFile(target[0].src);
						}
					}
			});
			$('#summernote').summernote('code', content);
	}
	
	function sendFile(file, el) {
		const errorBox = document.getElementById("editorError");

	    if(file.size > 2 * 1024 * 1024){
	        errorBox.textContent = "Image must be smaller than 2MB. Please select a new image.";
	        return false;
	    }

	    errorBox.textContent = "";
	    
		var form_data = new FormData();
		const tempKey = document.getElementById("tempKey").value;
		console.log("tempKey before upload =", tempKey);

		
		form_data.append('articleImageFile', file);
		form_data.append('articleImageFileFileName', file.name);
		form_data.append('articleImageFileContentType', file.type);
		form_data.append("tempKey", tempKey); //ส่วรหัสชั่วคราว
		
		$.ajax({
			data : form_data,
			type : "POST",
			url : '${pageContext.request.contextPath}/addImgFormEditor',
			cache : false,
			contentType : false,
			processData : false,
			success : function(url) {
				$('#summernote').summernote('editor.insertImage', url);
				console.log("Succesful uploaded " + url);
				// เคลียร์ input file ของ summernote กันเบราว์เซอร์ส่งไฟล์นี้ซ้ำตอน submit ฟอร์มจริง
				$('.note-image-input').val('');
			},
			error : function(data) {
				console.log("Error upload");
			}
		});
	}

	function deleteFile(src) {
		$.ajax({
			data : "srcDelete=" + src,
			type : "POST",
			url : "${pageContext.request.contextPath}/DeleteImgFormEditor",
			cache : false,
			success : function(response) {
			}
		});
	}
	
		</script>
	

	<script>
		document.addEventListener("DOMContentLoaded", function () {
			flatpickr("#publication_date", {
		        dateFormat: "Y-m-d",  
		        altInput: true,
		        altFormat: "d M Y",   
		        locale: "en",        
		        allowInput: false,
		        defaultDate: new Date()
		    });
			
			$("#publication_time").flatpickr({
			    enableTime: true,
			    noCalendar: true,
			    dateFormat: "H:i",
			    time_24hr: true,
			    defaultDate: new Date()
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
		    
		    if (!$('#summernote').next('.note-editor').length) {
		        initSummernote();
		    }
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
	
		
		const errorBox = document.getElementById("editorError");
	    const editorError = errorBox.textContent.trim();
	    
	    document.getElementById("detailInput").value = content;
		var errorFields = [];
		
		const form = document.getElementById("formAddArticle");
	    
		  ["article_title", "publication_date", "publication_time"]
		  .forEach(id => {
		      const element = document.getElementById(id);
		      if (element && element.value) {
		          element.value = element.value.trim();
		      }
		  });
		  
		  const articleTitle  = document.getElementById("article_title").value
		  const articleType = document.getElementById("article_type").value
		  const userCreate = document.getElementById("user_create").value
		  const publicDate = document.getElementById("publication_date").value
		  const publicTime  = document.getElementById("publication_time").value
		  const contentText = content.replace(/<[^>]*>/g, "").trim();
		  const imageFile = document.getElementById("imageInputFile");
		  
		  if(!articleTitle) errorFields.push("Title")
		  if(!articleType) errorFields.push("Type")		  
		  if(!userCreate) errorFields.push("Author")
		  if(!publicDate) errorFields.push("Publication Date")
		  if(!publicTime) errorFields.push("Publication Time")
		  if (!imageFile.files || imageFile.files.length === 0) {
			    errorFields.push("Cover Photo");
			    imageFile.classList.add("border-danger");
			} else {
				imageFile.classList.remove("border-danger");
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
		  
		  if(editorError){
		    	errorBox.scrollIntoView({
		            behavior: "smooth",
		            block: "center"
		        });
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
					document.getElementById("saveFormBtn").disabled = true;
					document.getElementById("preview").disabled = true;
					document.getElementById("saveFormBtn").textContent = "Saving...";	        	
		        	$(form).find('input[type="file"]').not('#imageInputFile').val('');
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
						document.getElementById("saveFormBtn").disabled = true;
						document.getElementById("preview").disabled = true;
						document.getElementById("saveFormBtn").textContent = "Saving...";
			            window.location.href = redirectUrl;
			        }
			    });
			}
		
		
	</script>

<script>
var input = document.querySelector('input[name="article_tag"]'),
// init Tagify script on the above inputs
tagify = new Tagify(input, {
    whitelist: [<c:forEach items="${tagList}" var="item">'${item.tagName}',</c:forEach>],
    maxTags: 10,
    dropdown: {
        maxItems: 20,           // <- maximum allowed rendered suggestions
        classname: 'tags-look', // <- custom classname for this dropdown, so it could be targeted
        enabled: 0,             // <- show suggestions on focus
        closeOnSelect: false    // <- do not hide the suggestions dropdown once an item has been selected
    }
})
</script>
</body>
</html>