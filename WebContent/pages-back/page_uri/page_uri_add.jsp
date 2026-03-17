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
							class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
							Add Page URL</h1>

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
								href="${pageContext.request.contextPath}/page_uri_list" class="text-muted text-hover-primary">Page URL</a></li>
						</ul>
					</div>
				</div>
			</div>

			<div class="app-content flex-column-fluid">
				<div class="app-container container-fluid">
					<form id="formAddPageUrl" action="page_uri_perform_add"
							method="POST" class="form" autocomplete="off" enctype="multipart/form-data">
							<input type="hidden" name="submitType" id="submitType">
						<div class="card mb-10">
							<div
								class="card-header d-flex align-items-center justify-content-between">
								<h3 class="fw-semibold text-gray-900 mb-0">Add Page URL</h3>
								
							</div>

							<div class="card-body ">
								<div class="col-12">
										<label class="required fw-medium text-gray-800 mb-2">Page URL</label>
										<input type="text"  class="form-control text-gray-700"
												placeholder="Page URL" id="pageUriId" name="pageUriId" />													
								</div>
									
								<div class="col-12 mt-5">
									<label class="required fw-medium text-gray-800 mb-2">Forward to</label>
									<input type="text" class="form-control text-gray-700" placeholder="Forward to" name="forwardTo"
											id="forwardTo" />
														
								</div>
									
								<div class="row col-12 mt-5">
											<%-- <div class="col-12 col-md-4 mt-5 mt-md-0">
												<label class="fw-medium text-gray-800 mb-2">Forward to</label>
												
												<input type="text"
														class="form-control text-gray-700"
														placeholder="Forward to" name="forward_to"
														id="forward_to" value="${pageUri.forwardTo}" />
														
											</div> --%>
											<div class="col-12 col-md-6 mt-5 mt-md-0">
												<label class="fw-medium text-gray-800 mb-2">Model</label>
												<input type="text" class="form-control text-gray-700"
														placeholder="Model" name="model"
														id="model"/>
												
											</div>
											
											<div class="col-12 col-md-6 mt-5 mt-md-0">
												<label class="fw-medium text-gray-800 mb-2">Model ID</label>
												<input type="text" class="form-control text-gray-700"
														placeholder="Model ID" name="modelId"
														id="model_id" />
											</div>
										</div>
									
									<div class="col-12 mt-5">
										<label class="fw-medium text-gray-800 mb-2">Title</label>
										<input type="text" 
												class="form-control text-gray-700" maxlength="100"
												placeholder="Title" id="pageUriTitle" name="pageUriTitle"/>				
									</div>
									<div class="col-12 mt-5">
										<label class="fw-medium text-gray-800 mb-2">Meta</label>
										<textarea class="form-control text-gray-700" id="meta" name="meta"
												placeholder="Meta" rows="3"></textarea>		
									</div>
									<div class="col-12 mt-5">
											<label class="fw-medium text-gray-800 mb-2">Description</label>
											<textarea class="form-control text-gray-700" id="pageUriDescription" name="pageUriDescription"
												placeholder="Description" rows="3"></textarea>
									</div>
								</div>
						</div>


						<div class="d-flex justify-content-end border-0">
							<button type="button" id="cancelFormBtn"
								onclick="confirmLeaveForm('page_uri_list')"
								class="btn btn-lg btn-light fw-medium text-light-inverse px-3 py-4 me-2">Cancel
							</button>
						
							<button type="button" id="saveFormBtn"
								class="btn btn-success text-white fw-medium px-3 py-4"
								onclick="submitForm()">Submit</button>
						</div>
						
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	<script>
	
	function submitForm(){
		var errorFields = [];
		
		const form = document.getElementById("formAddPageUrl");
	    
		  ["pageUriId", "forwardTo"]
		  .forEach(id => {
		      const element = document.getElementById(id);
		      if (element && element.value) {
		          element.value = element.value.trim();
		      }
		  });
		  
		  const pageUriId  = document.getElementById("pageUriId").value
		  const forwardTo = document.getElementById("forwardTo").value
		 
		  
		  if(!pageUriId) errorFields.push("Page URL")
		  if(!forwardTo) errorFields.push("Forward to")
		  
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