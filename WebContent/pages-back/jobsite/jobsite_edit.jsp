<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/assets/css/style.bundle.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css"
	rel="stylesheet" type="text/css" />

<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>
<script
	src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<style>

/* Light Mode */
#kt_table_team.table.table-striped>tbody>tr:nth-of-type(odd)>* {
    background-color: #FBFBFB !important;
    box-shadow: none !important;
}

#kt_table_team.table-hover tbody tr:hover>*,
#kt_table_team.table-hover tbody tr:hover>td,
#kt_table_team.table-hover tbody tr:hover>th,
#kt_table_team.table.table-hover>tbody>tr:hover>*,
#kt_table_team.dataTable>tbody>tr:hover>* {
    background-color: #F9F9F9 !important;
    box-shadow: none !important;
    transition: background-color .15s ease-in-out;
}

/* Dark Mode */
[data-bs-theme="dark"] #kt_table_team.table.table-striped>tbody>tr:nth-of-type(odd)>* {
    background-color: #191B20 !important;
    box-shadow: none !important;
}

[data-bs-theme="dark"] #kt_table_team.table.table-striped>tbody>tr:nth-of-type(even)>* {
    background-color: #15171C !important;
    box-shadow: none !important;
}

[data-bs-theme="dark"] #kt_table_team.table-hover tbody tr:hover>*,
[data-bs-theme="dark"] #kt_table_team.table-hover tbody tr:hover>td,
[data-bs-theme="dark"] #kt_table_team.table-hover tbody tr:hover>th,
[data-bs-theme="dark"] #kt_table_team.table.table-hover>tbody>tr:hover>*,
[data-bs-theme="dark"] #kt_table_team.dataTable>tbody>tr:hover>* {
    background-color: #1B1C22 !important;
    box-shadow: none !important;
    transition: background-color .15s ease-in-out;
}

/* --- Footer Animation --- */
.footer-hidden {
	display: none !important;
}

.footer-animate {
	animation: footerFadeUp 0.25s ease-out;
}

@
keyframes footerFadeUp {from { opacity:0;
	transform: translateY(10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/* --- Color in select2 --- */
#select2-employeeSelect-container {
    color: var(--bs-gray-900) !important;
    font-weight: 400;
}

</style>

</head>
<body>
	<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
		<div class="d-flex flex-column flex-column-fluid">

			<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
				<div id="kt_app_toolbar_container"
					class="app-container container-xxl d-flex flex-stack">
					<div class="page-title d-flex flex-column justify-content-center">
						<h1 class="page-heading text-gray-700 fw-semibold my-0">
							Jobsite</h1>
						<ul
							class="breadcrumb breadcrumb-separatorless fw-medium fs-7 text-muted pt-1">
							<li class="breadcrumb-item">Home</li>
							<li class="breadcrumb-item"><span class="bullet w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted">Master</li>
							<li class="breadcrumb-item"><span class="bullet w-5px h-2px"></span></li>
							<li class="breadcrumb-item text-muted">Jobsite</li>
						</ul>
					</div>
				</div>
			</div>

			<div id="kt_app_content" class="app-content flex-column-fluid">
				<div id="kt_app_content_container"
					class="app-container container-xxl">
					<div class="card">
						<form
							action="${pageContext.request.contextPath}/updateJobsite.action"
							method="post" class="form" autocomplete="off">

							<input type="hidden" name="jobsite.id_sitejob"
								value="${jobsite.id_sitejob}" />

							<div class="card-header border-0 pt-6 align-items-start">
								<div class="card-title pt-3">
									<h3 class="page-heading d-flex text-gray-900 fw-semibold my-0">Jobsite</h3>
								</div>

								<div
									class="card-toolbar d-flex flex-column align-items-end pt-3 ">
									<div class="d-flex align-items-center mb-3">
										<span class="fw-medium fs-6 text-gray-700 me-3"
											id="statusLabel"> <c:choose>
												<c:when test="${jobsite.is_active eq '1'}">Active</c:when>
												<c:otherwise>Inactive</c:otherwise>
											</c:choose>
										</span> <label class="form-check form-switch form-check-success mb-0">
											<input type="checkbox" class="form-check-input" id="isActive"
											name="is_active" value="1" style="width: 33px;"
											<c:if test="${jobsite.is_active eq '1'}">checked</c:if> />
										</label>
									</div>
								</div>
							</div>

							<div class="card-body p-10 pt-3">
								<div class="row">
									<div class="col-12 col-md-6">
										<label class="form-label fw-medium text-gray-800">Job
											Site Name <span class="required"></span>
										</label> <input type="text" name="jobsite.name_site"
											value="${jobsite.name_site}"
											class="form-control form-control-lg h-55px fw-medium text-gray-700"
											required />
									</div>

									<div class="col-12 col-md-6">
										<label class="form-label fw-medium text-gray-800">Description
											Name</label> <input type="text" name="jobsite.description"
											value="${jobsite.description}"
											class="form-control form-control-lg h-55px fw-medium text-gray-700" />
									</div>
								</div>
							</div>

							<div id="formFooter"
								class="card-footer d-flex justify-content-end gap-3 p-8 footer-hidden">
								<button type="button" onclick="hideFooter()"
									class="btn btn-light px-8 btn-lg">Cancel</button>
								<button type="submit" class="btn btn-success px-8 btn-lg">Save</button>
							</div>
						</form>
					</div>
				</div>
			</div>

			<div id="kt_app_content" class="app-content flex-column-fluid py-10">
				<div id="kt_app_content_container"
					class="app-container container-xxl">

					<div class="card">

						<div class="card-header border-0 pt-6 align-items-start">
							<div class="card-title pt-3">
								<h3 class="page-heading d-flex text-gray-900 fw-semibold my-0">TEAM</h3>
							</div>

							<div class="card-toolbar d-flex flex-column align-items-end">
								<div class="d-flex mb-3">
									<button type="button" class="btn btn-success btn-lg"
										data-bs-toggle="modal" data-bs-target="#employeeModal">
										<i class="ki-duotone ki-plus fs-2"></i> <span
											class="fw-medium">Add Employee</span>
									</button>
								</div>
							</div>
						</div>

						<div class="card-body py-4 px-5">
							<div class="table-responsive">
								<table
									class="table table-striped table-hover align-middle table-row-bordered"
									id="kt_table_team">
									<thead>
										<tr
											class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 border-bottom border-gray-200"
											style="height: 39px;">
											<th class="text-center">#</th>
											<th>Employee Name</th>
											<th class="text-end pe-5">Action</th>
										</tr>
									</thead>

									<tbody class="text-gray-900 fw-normal fs-5">
										<c:forEach var="t" items="${teamList}" varStatus="st">
											<tr style="height: 61px;">
												<td class="fw-bold text-center px-0" style="width: 75px;">${st.index + 1}</td>
												<td><c:set var="displayTeam" value="" /> <c:if
														test="${not empty t.employee_id}">
														<c:set var="displayTeam" value="${t.employee_id}" />
													</c:if> <c:if test="${not empty t.name_en}">
														<c:if test="${not empty displayTeam}">
															<c:set var="displayTeam" value="${displayTeam} - " />
														</c:if>
														<c:set var="displayTeam"
															value="${displayTeam}${t.name_en}" />
													</c:if> <c:if test="${not empty t.name}">
														<c:if test="${not empty displayTeam}">
															<c:set var="displayTeam" value="${displayTeam} - " />
														</c:if>
														<c:set var="displayTeam" value="${displayTeam}${t.name}" />
													</c:if> ${displayTeam}</td>

												<td class="text-end pe-5" style="width: 120px;">
													<button type="button"
														class="btn btn-icon btn-light-danger btn-sm btn-delete-team"
														data-team-id="${t.job_site_team_id}"
														data-site-id="${jobsite.id_sitejob}"
														style="width: 35px; height: 35px; padding: 0;">
														<i class="ki-duotone ki-disconnect fs-2"> <span
															class="path1"></span>
														</i>
													</button>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>


						<form id="employeeForm" action="${ctx}/saveJobSiteTeam.action"
							method="post">
							<input type="hidden" name="id_sitejob"
								value="${jobsite.id_sitejob}" /> <input type="hidden"
								name="user_id" id="userIdInput" />

							<div class="modal fade" id="employeeModal" tabindex="-1"
								aria-hidden="true">
								<div
									class="modal-dialog modal-dialog-centered mw-750px modal-xxl">
									<div class="modal-content p-0">

										<div class="modal-header border-0">
											<h2 class="modal-title fw-medium">Add Employee</h2>
											<div
												class="btn btn-icon btn-sm btn-active-light-primary ms-2"
												data-bs-dismiss="modal" aria-label="Close">
												<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span
													class="path2"></span></i>
											</div>
										</div>

										<div class="modal-body">
											<div class="mb-5">
												<div class="position-relative">
													<i
														class="ki-duotone ki-magnifier fs-4 text-gray-500 position-absolute top-50 start-0 translate-middle-y ms-5"
														style="z-index: 10; pointer-events: none;"> <span
														class="path1"></span><span class="path2"></span>
													</i>

													<c:set var="teamUserIds" value="," />
													<c:forEach var="t" items="${teamList}">
														<c:set var="teamUserIds"
															value="${teamUserIds}${t.user_id}," />
													</c:forEach>

													<select id="employeeSelect"
														class="employee-select2 form-select form-select-lg form-select-solid h-55px ps-13 fw-normal fs-5 text-gray-900"
														data-placeholder="Search employee..."
														data-allow-clear="true">

														<option value=""></option>
													</select>
												</div>
											</div>
										</div>

										<div class="modal-footer justify-content-end">
											<button type="button" class="btn btn-light btn-lg"
												data-bs-dismiss="modal">Cancel</button>
											<button type="button"
												class="btn btn-success fw-medium btn-lg"
												onclick="saveEmployee()">Save Change</button>
										</div>

									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
	    function saveEmployee() {
	        const select = document.getElementById('employeeSelect');
	        const selectedVal = select.value;
	        if (!selectedVal) {
	            alert('กรุณาเลือกพนักงานก่อน');
	            return;
	        }
	        document.getElementById('userIdInput').value = selectedVal;
	        document.getElementById('employeeForm').submit();
	    }
	</script>

	<script>
	    const toggle = document.getElementById("isActive");
	    const label = document.getElementById("statusLabel");
	    function updateStatusLabel() {
	        label.textContent = toggle.checked ? "Active" : "Inactive";
	    }
	    toggle.addEventListener("change", updateStatusLabel);
	    updateStatusLabel();
	</script>

	<script>
	    function hideFooter() {
		    const footer = document.getElementById("formFooter");
		    footer.classList.add("footer-hidden");
		    footer.classList.remove("footer-animate");
		    if (document.activeElement) document.activeElement.blur();
		}
        
        document.addEventListener("DOMContentLoaded", function () {
            const footer = document.getElementById("formFooter");
            const inputs = document.querySelectorAll("input, select, textarea");
            inputs.forEach(el => {
                el.addEventListener("focus", () => {
                    footer.classList.remove("footer-hidden");
                    footer.classList.add("footer-animate");
                });
                el.addEventListener("blur", () => {
                    setTimeout(() => {
                        if (!document.querySelector(":focus")) {
                            footer.classList.add("footer-hidden");
                            footer.classList.remove("footer-animate");
                        }
                    }, 50);
                });
            });
        });
	</script>
	
	<!-- Sort Employee -->
	<script>
	$(document).ready(function () {
	    var userList = [
	        <c:forEach var="u" items="${userList}">
	        {
	            id: "${u.id}",
	            empId: "${u.employeeId}",
	            nameEN: "${u.nameEN}", 
	            nameTH: "${u.name}",
	            inTeam: ${fn:contains(teamUserIds, ',' += u.id += ',')},
	            isLoginUser: "${u.id}" === "${logonUser}"
	        },
	        </c:forEach>
	    ];
	
	    userList.sort(function(a, b) {
	        if (a.isLoginUser && !b.isLoginUser) return -1;
	        if (!a.isLoginUser && b.isLoginUser) return 1;
	        
	        var nameA = (a.nameEN || "").toUpperCase();
	        var nameB = (b.nameEN || "").toUpperCase();
	        
	        if (nameA === "" && nameB !== "") return 1;
	        if (nameA !== "" && nameB === "") return -1;
	        
	        return nameA.localeCompare(nameB);
	    });
	
	    var $select = $('#employeeSelect');
	    $select.empty(); 
	    
	    userList.forEach(function(u) {
	        var displayText = "";
	        
	        if(u.empId) displayText += u.empId;
	        
	        if(u.nameEN) displayText += (displayText ? " - " : "") + u.nameEN;
	        
	        var th = (u.nameTH || "").trim();
	        var en = (u.nameEN || "").trim();
	        if(th && th.toUpperCase() !== en.toUpperCase()) {
	             displayText += (displayText ? " - " : "") + th;
	        } else if (!en && th) {
	             displayText += (displayText ? " - " : "") + th;
	        }
	
	        if(u.isLoginUser) displayText = displayText + " (You)";
	        if(u.inTeam) displayText += " (Already in this site)";
	
	        var newOption = new Option(displayText, u.id, false, false);
	        
	        if(u.inTeam) {
	            $(newOption).attr('disabled', 'disabled');
	        }
	
	        $select.append(newOption);
	    });
	
	    if ($select.hasClass("select2-hidden-accessible")) {
	        $select.select2('destroy');
	    }
	
	    $select.select2({
	        dropdownParent: $('#employeeModal'),
	        placeholder: 'Search employee...',
	        allowClear: true,
	        width: '100%',
	        matcher: function(params, data) {
	            if ($.trim(params.term) === '') return data;
	            if (typeof data.text === 'undefined') return null;
	            
	            var text = data.text.toUpperCase();
	            var term = params.term.toUpperCase();
	            var terms = term.split(' ').filter(function(t) { return t.length > 0; });
	            var match = terms.every(function(t) { return text.indexOf(t) > -1; });
	            return match ? data : null;
	        }
	    });
	
	    $('#employeeModal').on('shown.bs.modal', function () {
	        $select.val(null).trigger('change');
	    });
	});
	</script>

	<!-- Remove Employee -->
	<script>
	  document.querySelectorAll('.btn-delete-team').forEach(function(btn){
	    btn.addEventListener('click', function(){
	      var teamId = this.getAttribute('data-team-id');
	      var siteId = this.getAttribute('data-site-id');
	      Swal.fire({
	        title: 'Remove this member?',
	        text: "This user will be removed from the team.",
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#d33',
	        cancelButtonColor: '#aaa',
	        confirmButtonText: 'Yes, remove'
	      }).then((result) => {
	        if (result.isConfirmed) {
	          const form = document.createElement('form');
	          form.method = 'post';
	          form.action = '${ctx}/deleteJobSiteTeam.action';
	          const i1 = document.createElement('input'); i1.type='hidden'; i1.name='job_site_team_id'; i1.value=teamId; form.appendChild(i1);
	          const i2 = document.createElement('input'); i2.type='hidden'; i2.name='id_sitejob'; i2.value=siteId; form.appendChild(i2);
	          document.body.appendChild(form);
	          form.submit();
	        }
	      });
	    });
	  });
	</script>

	<!-- Data Table -->
	<script>
    $(document).ready(function () {
        $('#kt_table_team').DataTable({
            paging: true,
            lengthChange: true,
	        lengthMenu: [
	        	[10, 25, 50 , -1], 
	        	[10, 25, 50, "All"]
	        ],
            searching: false, 
            info: false,    
            autoWidth: false,
            order: [],       
            
            language: {
                emptyTable: "No data",    
            },

            columnDefs: [
                { targets: 0, orderable: false},
                
                { targets: 1, orderable: true },
                
                { targets: 2, orderable: false}
            ],

        });
    });
    </script>

</body>
</html>