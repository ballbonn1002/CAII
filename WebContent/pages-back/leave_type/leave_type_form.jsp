<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Leave Type Add</title>
<!-- Metronic core -->
<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
</head>
<body>
	<div class="app-main flex-column app-container container-xxl">
		<div class="page-title py-3">
			<h1 class="page-heading fw-bold text-gray-900 fs-3">Leave Type</h1>
			<ul
				class="list-unstyled d-inline-flex gap-2 text-muted fs-7 fw-medium">
				<li class="">Home</li>
				<li class="">-</li>
				<li class="">Master</li>
				<li class="">-</li>
				<li class="">Leave Type</li>
			</ul>
		</div>

		<div class="app-content">
			<div class="card">
				<div class="card-header pt-7 border-0">
					<h3 class="fw-bold text-gray-900 fs-3">
						<s:if test="leaveType.leaveTypeId == null">Add Leave Type</s:if>
						<s:else>Edit Leave Type</s:else>
					</h3>
				</div>
				<form id="leaveTypeForm" method="post" onsubmit="return onSubmit()">

					<input type="hidden" id="tempLeaveTypeId"
						value="<s:property value='leaveType.leaveTypeId'/>" />
					<div class="card-body pb-0">
						<div class="mb-7">
							<label for="leave-type-id"
								class="required form-label text-gray-800 fw-medium">ID</label>
							<s:if test="leaveType.leaveTypeId == null">
								<s:textfield name="leaveType.leaveTypeId" id="leaveTypeId"
									type="text" maxlength="1" cssClass="form-control p-5"
									placeholder="Leave type ID" />
							</s:if>
							<s:else>
								<s:textfield name="leaveType.leaveTypeId"
									cssClass="form-control p-5" disabled="true" />
								<s:hidden id="leaveTypeId" name="leaveType.leaveTypeId" />
							</s:else>

						</div>
						<div class="mb-7">
							<label for="leave-type-name"
								class="required form-label text-gray-800 fw-medium">
								Leave Type Name</label>
							<s:textfield id="leaveTypeName" name="leaveType.leaveTypeName"
								cssClass="form-control p-5" placeholder="Leave type name" maxlength="32" onblur="this.value = this.value.trim()"  />
						</div>
						<div class="mb-7">
							<label for="leave-type-description"
								class="text-gray-800 fw-medium">Description</label>
							<s:textarea id="leaveTypeDescription"
								name="leaveType.description" cssClass="form-control px-4"
								rows="4" placeholder="Optional details..." maxlength="255" onblur="this.value = this.value.trim()" />
						</div>
					</div>
					<div class="card-footer d-flex justify-content-end gap-3">
						<a href="leave_type_list"
							class="btn btn-bg-secondary px-8 fw-medium">Cancel</a>
						<button class="btn btn-bg-success px-8 fw-medium text-white"
							type="submit">Save</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	const inputLeaveTypeId = document.getElementById('leaveTypeId');
	const validPattern = /^[a-zA-Z0-9\s]+$/;
	inputLeaveTypeId.addEventListener('input', function () {
		if(!validPattern.test(this.value))
		  this.value = '';
	});
	
		const onSubmit = ()=> {
			const leaveTypeId = document.getElementById('leaveTypeId').value;
			const tempLeaveTypeId = document.getElementById('tempLeaveTypeId').value;
			const form = document.getElementById('leaveTypeForm');
			const leaveTypeName = document.getElementById('leaveTypeName').value
			const leaveTypeDescription = document.getElementById('leaveTypeDescription').value
	
			
			if(tempLeaveTypeId  === ""){
				const leaveTypeList = [
					<s:iterator value="leaveTypeList" status="st">
						{
							leaveTypeId: "<s:property value='leaveTypeId' />"
						}<s:if test="!#st.last">,</s:if>
					</s:iterator>
				];
				
				for( const leaveType of leaveTypeList){
					if(leaveTypeId === leaveType.leaveTypeId){
						 Swal.fire({
					          title: 'Warning!',
					          text: "This ID have already.",
					          icon: 'warning'
					    });
						return false;
					}
				}
			}
			
			if (leaveTypeId === ""){
				 Swal.fire({
			          title: 'Warning!',
			          text: "ID must not empty.",
			          icon: 'warning'
			    });
				return false;
			}
			
			if (leaveTypeName === "") {
				Swal.fire({
					title: 'Warning!',
					text: 'Leave type name must not empty.',
					icon: 'warning'
				});
				return false;
			}

			if (leaveTypeDescription && !validPattern.test(leaveTypeDescription)) {
				Swal.fire({
					title: 'Warning!',
					text: 'Description must not contain special characters.',
					icon: 'warning'
				});
				return false;
			} 
			
			if(tempLeaveTypeId === ""){
				form.action = "leave_type_save"
			}else {
				form.action = "leave_type_update"
			}
		return true;
	}

	</script>
</body>
</html>