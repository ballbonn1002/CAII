<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>

<!DOCTYPE html>
<!-- jQuery ต้องโหลดก่อนทุกอย่าง -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>

<!-- Select2 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/select2-bootstrap-theme@0.1.0-beta.10/dist/select2-bootstrap.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

<link href="assets/css/style.bundle.css" rel="stylesheet" type="text/css" />
<script src="assets/js/scripts.bundle.js"></script>

<!-- FullCalendar -->
<link href="assets/plugins/custom/fullcalendar/fullcalendar.bundle.css" rel="stylesheet" type="text/css" />
<script src="assets/plugins/custom/fullcalendar/fullcalendar.bundle.js"></script>


<style>

.fc-header-toolbar {
	padding-bottom: 16px;
}

.fc-col-header-cell {
	height: 61px;
	vertical-align: middle !important;
}

.fc-daygrid-day.fc-day-sun, .fc-daygrid-day.fc-day-sat {
	background-color: #D7D7D74D;
}

.fc-day-header {
	height: 24px;
	align-content: center;
}

.fc-day-grid-event>.fc-content {
	white-space: normal;
}

.fc-day-grid .fc-row {
	max-height: 75px;
	overflow: hidden;
}
</style>

<div class="app-main flex-column flex-row-fluid">
	<div class="d-flex flex-column flex-column-fluid">
		<!-- Header -->
		<div class="app-toolbar py-3 py-lg-6">
			<div class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-900 fw-bold fs-3 flex-column justify-content-center my-0">
						Calendar and Check List</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="demo_dashboard" class="text-muted text-hover-primary">Home</a>
						</li>
					</ul>
				</div>
			</div>
		</div>

		<!-- Content -->
		<div class="app-content flex-column-fluid">
			<div class="app-container container-fluid">
				<!-- Form without submit button -->
				<div class="d-flex flex-row">
					<div class="card flex-row-fluid mb-5">
						<div class="card-header" style="border-bottom: none;">
							<!--begin::Main wrapper-->
							<div id="kt_docs_search_handler_responsive"
								class="d-flex align-items-center w-100"
								data-kt-search-keypress="true" data-kt-search-min-length="1"
								data-kt-search-enter="enter" data-kt-search-layout="menu"
								data-kt-search-responsive="lg" data-kt-menu-trigger="auto"
								data-kt-menu-permanent="true"
								data-kt-menu-placement="bottom-start">

								<!--begin::Form-->
								<form id="userCalendarForm"
									class="d-none d-lg-block w-100 position-relative mb-5 mb-lg-0"
									autocomplete="off" action="TestSearchAllinCalendar" method="post">
									<!--begin::Icon-->
									<i class="ki-duotone ki-magnifier fs-2 fs-lg-1 text-gray-500 position-absolute top-50 translate-middle-y ms-5">
										<span class="path1"></span> <span class="path2"></span>
									</i>
									<!--end::Icon-->
									<!--begin::Input-->
									<input type="text" class="form-control form-solid ps-14"
										name="usercalendar" id="userSearchInput"
										placeholder="${user.employeeId} - ${user.name} - ${user.nameEN}"
										data-kt-search-element="input" />
									<!--end::Input-->
								</form>
								<!--end::Form-->
								<!--begin::Menu-->
								<div data-kt-search-element="content"
									class="menu menu-sub menu-sub-dropdown w-50 py-7 px-7">
									<!--begin::Wrapper-->
									<div data-kt-search-element="wrapper">
										<!--begin::Results-->
										<div data-kt-search-element="results" id="userSearchResults"
											style="max-height: 400px; overflow-y: auto; overflow-x: hidden;">
										</div>
										<!--end::Results-->
										<!--begin::Empty search-->
										<div data-kt-search-element="empty" class="text-center d-none">
											<span class="text-muted">No user found</span>
										</div>
										<!--end::Empty search-->
									</div>
									<!--end::Wrapper-->
								</div>
								<!--end::Menu-->
							</div>
							<!--end::Main wrapper-->

						</div>

						<div class="card-body d-flex flex-row flex-wrap pt-0">
							<div class="d-flex align-items-center me-5">
								<span class="badge badge-primary">${user.workType == 1 ? 'On-site' : 'WFH'}</span>
							</div>
							<div class="d-flex align-items-center me-5">
								Working Time : <span class="ms-2 text-primary">${user.workTimeStart}
									- ${user.workTimeEnd}</span>
							</div>
							<div class="d-flex align-items-center me-5">
								On-site : <span class="ms-2 text-primary">
									${user.onsiteNum == 3 ? '4 – 5 Days (On-site)' :
          							user.onsiteNum == 2 ? '2 – 3 Days (Hybrid)' :
          							user.onsiteNum == 1 ? '0.5 – 1 Day (WFH)' : 'N/A'}
								</span>
							</div>
						</div>
					</div>
				</div>


				<!-- Calendar -->
				<div class="d-flex flex-row">
					<div class="card flex-row-fluid mb-5">
						<div class="card-header pt-10" style="border-bottom: none;">
							<h2 class="card-title">Calendar</h2>
						</div>
						<div class="card-body" id="kt_docs_fullcalendar_populated">
						</div>
						<div class="card-footer d-flex flex-row flex-wrap">
							<div class="badge badge-secondary me-7 fw-semibold">Holiday</div>
							<div class="badge badge-success me-7 fw-semibold">On time</div>
							<div class="badge badge-warning me-7 fw-semibold">Late</div>
							<div class="badge badge-warning me-7 fw-semibold">Early Out</div>
							<div class="badge badge-warning me-7 fw-semibold">Unfinished Work</div>
							<div class="badge badge-dark me-7 fw-semibold">Incomplete</div>
							<div class="badge badge-primary me-7 fw-semibold">Leave</div>
							<div class="badge badge-info me-7 fw-semibold">Sick Leave</div>
						</div>
					</div>
				</div>

				<!-- Summary Working Day -->
				<div class="d-flex flex-row">
					<div class="card flex-row-fluid mb-5">
						<div class="card-header pt-10" style="border-bottom: none;">
							<h2 class="card-title">Summary Working Day</h2>
						</div>
						<div class="card-body">
							<div class="row align-items-center mt-10 mx-5 fs-6 fw-bold">
								<div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
									<span style="color: var(--bs-green);" id="summaryWorkingDay"></span><span
										class="bullet bullet-vertical mx-2 h-15px w-2px"
										style="background-color: var(--bs-green);"></span><span
										style="color: var(--bs-green);">Working Day</span>
								</div>
								<div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
									<span class="text-success" id="summaryOnTime"></span><span
										class="bullet bullet-vertical bg-success mx-2 h-15px w-2px"></span><span
										class="text-gray-600">On Time</span>
								</div>
								<div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
									<span class="text-primary" id="summaryLeave"></span><span
										class="bullet bullet-vertical bg-primary mx-2 h-15px w-2px"></span><span
										class="text-gray-600">Leave</span>
								</div>
								<div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
									<span class="text-info" id="summarySickLeave"></span><span
										class="bullet bullet-vertical bg-info mx-2 h-15px w-2px"></span><span
										class="text-gray-600">Sick Leave</span>
								</div>
								<div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
									<span class="text-danger" id="summaryHoliday"></span><span
										class="bullet bullet-vertical bg-danger mx-2 h-15px w-2px"></span><span
										class="text-gray-600">Holiday</span>
								</div>
								<div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
									<span class="text-warning" id="summaryLateEarly"></span><span
										class="bullet bullet-vertical bg-warning mx-2 h-15px w-2px"></span><span
										class="text-gray-600">Late / Early Out /<br>
										Unfinished Work
									</span>
								</div>
								<div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
									<span class="text-muted" id="summaryIncomplete"></span><span
										class="bullet bullet-vertical bg-muted mx-2 h-15px w-2px"></span><span
										class="text-gray-600">Incomplete</span>
								</div>
								<div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
									<span class="text-dark" id="summaryNoRecord"></span><span
										class="bullet bullet-vertical bg-dark mx-2 h-15px w-2px"></span><span
										class="text-gray-600">No Record</span>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Check List -->
				<div class="d-flex flex-row">
					<div class="card flex-row-fluid mb-5">
						<div class="card-header pt-10" style="border-bottom: none;">
							<div class="row align-items-center w-100">
								<div class="col-lg-6">
									<h2 class="card-title mb-0">Check List</h2>
								</div>
								<div class="col-lg-6 text-end">
									<h3 id="calendarTitle" class="fw-bold text-primary mb-0"></h3>
								</div>
							</div>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table id="calendarTable"
									class="table table-row-bordered table-row-gray-300 gy-7">
									<thead>
										<tr class="fw-bold fs-7 text-gray-500">
											<th class="min-w-120px">DATE</th>
											<th class="min-w-120px">CHECK-IN</th>
											<th class="min-w-120px">CHECK-OUT</th>
											<th class="min-w-100px">WORKING (HRS)</th>
											<th class="min-w-150px">STATUS</th>
										</tr>
									</thead>
									<tbody id="calendarTableBody">
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Leave Modal -->
<%-- <div class="modal fade" id="leavemodal" tabindex="-1">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h2 class="modal-title fw-bold">Leave</h2>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row mb-5 fs-5 fw-semibold">
					<div class="col-md-6">
						<div class="d-flex align-items-center ">
							<span class="text-primary me-4">#<span id="leaveid"></span></span>
							<span id="leavetype" class="fw-medium me-4"></span> <i
								class="fa fa-circle text-gray-400 me-4" style="font-size: 8px;"></i>
							<span id="noday" class="badge badge-light-primary"></span>
						</div>
					</div>
					<div class="col-md-6">
						<span id="userid"></span>
					</div>
				</div>

				<div class="row mb-5 fs-6 fw-medium">
					<div class="col-md-6">
						<div class="d-flex align-items-center mb-2">
							<i class="ki-duotone ki-calendar-2 fs-2 me-2"> <span
								class="path1"></span> <span class="path2"></span>
							</i> <span><span id="sdate"></span> - <span id="edate"></span></span>
						</div>
					</div>
					<div class="col-md-6">
						<div class="d-flex align-items-center mb-2">
							<i class="ki-duotone ki-time fs-2 me-2"> <span class="path1"></span>
								<span class="path2"></span>
							</i> <span><span id="stime"></span> - <span id="etime"></span></span>
						</div>
					</div>
				</div>

				<div class="row mb-5 fs-6 fw-medium">
					<div class="col-md-6">
						<div class="d-flex align-items-center mb-2">
							<i class="ki-duotone ki-message-text fs-2 me-2"> <span
								class="path1"></span> <span class="path2"></span> <span class="path3"></span>
							</i> <span id="desc"></span>
						</div>
					</div>
					<div class="col-md-6">
						<div class="d-flex align-items-center mb-2">
							<i class="ki-duotone ki-document fs-2 me-2"> <span
								class="path1"></span> <span class="path2"></span>
							</i> <a id="file"
								class="text-hover-primary text-truncate flex-grow-1 min-w-0"
								style="max-width: 100%;"></a>
						</div>
					</div>
				</div>

				<div class="row mb-5 fs-6 fw-medium">
					<div class="col-md-6">
						<span id="leavestatus"></span>
					</div>
					<div class="col-md-6 fs-8 text-gray-500">
						<span>Request Date: <span id="timecreate"></span></span>
					</div>
				</div>

				<div id="approveDetail" class="row mb-5 fs-6 fw-medium d-none">
					<hr>
					<div class="row mb-5 fw-semibold">
						<h3 class="text-primary">Approver</h3>
					</div>

					<div class="row mb-5 fs-6 fw-medium">
						<div class="col-md-6">
							<i class="ki-duotone ki-user fs-2 me-2"> <span class="path1"></span>
								<span class="path2"></span>
							</i><span id="approveUser"></span>
						</div>
						<div class="col-md-6">
							<i class="ki-duotone ki-calendar-2 fs-2 me-2"> <span
								class="path1"></span> <span class="path2"></span>
							</i><span id="timeUpdate"></span>
						</div>
					</div>

					<div class="row mb-5 fs-6 fw-medium">
						<div class="col-md-6">
							<i class="ki-duotone ki-document fs-2 me-2"> <span
								class="path1"></span> <span class="path2"></span>
							</i>No description
						</div>
					</div>
				</div>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
				<perm:permission object="leave.approve">
					<a href="#" class="btn btn-primary" id="btn_edit_leave"> <i
						class="fa fa-edit"></i> Edit
					</a>
				</perm:permission>
			</div>
		</div>
	</div>
</div> --%>

<jsp:include page="/pages-back/common/leave_modal.jsp">
	<jsp:param name="showApproverInfo" value="true"/>
	<jsp:param name="showEditButton" value="true"/>
</jsp:include>

<script> // ----------- Search -----------------
// Get JSON data from backend
var cubeUserData = ${cubeUserJson};
var logonUser = '${logonUser}';

// Elements for search
var element = document.querySelector("#kt_docs_search_handler_responsive");
var resultsElement = element.querySelector("#userSearchResults");
var emptyElement = element.querySelector("[data-kt-search-element='empty']");

// Initialize search handler
var searchObject = new KTSearch(element);

// Function to render user list
function renderUsers(userList) {
    resultsElement.innerHTML = "";
    emptyElement.classList.add("d-none");
    resultsElement.classList.remove("d-none");

 	// Separate current user from others
    let currentUser = [];
    let otherUsers = [];

    userList.forEach(function(user){
        if(user.id == logonUser){
            currentUser.push(user);
        } else {
            otherUsers.push(user);
        }
    });

    let finalList = currentUser.concat(otherUsers);

    finalList.forEach(function(user, index){
        var displayText = (user.employee_id ? user.employee_id + " - " : "")
            + (user.name ? user.name : "")
            + (user.name_en ? " - " + user.name_en : "");

        var item = document.createElement("div");
        item.classList.add("menu-item", "px-3", "py-2", "cursor-pointer");
        item.textContent = displayText;

     	// Highlight current user
        if(user.id == logonUser){
            item.style.backgroundColor = "#eef6ff";
        }

     	// Click to fill input and submit form
        item.addEventListener("click", function(e){
            e.preventDefault();
            e.stopPropagation();
            document.querySelector("#userSearchInput").value = user.id;
            document.querySelector("#userCalendarForm").submit();
        });

        resultsElement.appendChild(item);
    });
}

// Handle search process
searchObject.on("kt.search.process", function(search){
    var keyword = search.getQuery().toLowerCase();

    var filtered = cubeUserData.filter(function(user){
        var displayText = (user.employee_id ? user.employee_id + " - " : "")
            + (user.name ? user.name : "")
            + (user.name_en ? " - " + user.name_en : "");
        return displayText.toLowerCase().includes(keyword);
    });

 	// Show all if nothing matches
    if(filtered.length === 0){
        renderUsers(cubeUserData);
    } else {
        renderUsers(filtered);
    }

    search.complete();
});

// Clear handler
searchObject.on("kt.search.clear", function(search){
    renderUsers(cubeUserData);
});

// Prevent scroll from propagating to parent
var menuElement = element.querySelector("[data-kt-search-element='content']");
if(menuElement){
    menuElement.addEventListener('wheel', function(e){
        e.stopPropagation();
    }, {passive:true});
}

// Render all users on page load
document.addEventListener("DOMContentLoaded", function(){
    renderUsers(cubeUserData);
});
// ----------------- End Search -----------------
</script>

<script>
"use strict";
// ----------------- Calendar & Checklist -------------------
// Calendar Application Class
var AppCalendar = function() {
	
	// Holiday Events
	function buildHolidayEvents() {
        var events = [];
        <c:forEach var="holiday" items="${allholiday}">
        <c:set var = "holidayDesc" value = "${holiday.description}"/>
        	<%pageContext.setAttribute("newline", "\r\n");%>
        <c:set var = "holidayDescClean" value = "${fn:replace(holidayDesc,newline,'')}" />
            events.push({
                id: '${holiday.id_date}',
                title: '${holiday.head}',
                start: '${holiday.start_date}',
                end: moment('${holiday.end_date}').add(1, 'days').format("YYYY-MM-DD"),
                description: '${holidayDescClean}',
                backgroundColor: '#F1F1F4',
                borderColor: '#F1F1F4',
                textColor: '#071437',
                allDay: true,
                className: 'fc-event-secondary'
            });
        </c:forEach>
        return events;
    }
	
	// Build Work Check-in/Check-out Events  
    function buildCheckinEvents() {
        var events = [];
        <c:forEach var="work" items="${workList}" varStatus="status">
            <c:if test="${work.mycheckins != null}">
                var status = '${work.status}';
                var title = getEventTitle(status, '${work.mycheckin}', '${work.checkouttime}', '${work.workTypeIn}', '${work.workTypeOut}');
                var description = getEventDescription('${work.mycheckin}', '${work.checkouttime}', status, '${work.workinghours}');
                var statusClass = getStatusClass(status);

                events.push({
                    id: 'work_${status.index}',
                    title: title,
                    start: '${work.mycheckins}'.substring(0, 10),
                    end: moment('${work.mycheckins}'.substring(0, 10)).add(1, 'days').format("YYYY-MM-DD"),
                    description: description,
                    allDay: true,
                    eventType: 'work',
                    status: status,
                    checkin: '${work.mycheckin}',
                    checkout: '${work.checkouttime}',
                    workinghour: '${work.workinghours}',
                    descriptionIn: '${work.descriptionIn}',
                    descriptionOut: '${work.descriptionOut}',
                    workTypeIn: '${work.workTypeIn}',
                    workTypeOut: '${work.workTypeOut}',
                    className: statusClass.className
                });
            </c:if>
        </c:forEach>
        return events;
    }

    // Leave Events
    function buildLeaveEvents() {
        var events = [];
        <c:forEach var="leave" items="${leave}">
        <c:set var = "leaveDesc" value = "${leave.description}"/>
        	<%pageContext.setAttribute("newline", "\r\n");%>
        <c:set var = "leaveDescClean" value = "${fn:replace(leaveDesc,newline,'')}" />
            if (${leave.leave_status_id} != 3 && ${leave.leave_status_id} != 2) {
                var leaveType = '${leave.leave_type_name}';
                var color = leaveType === 'ลาป่วย' ? 
                    {bg: '#7239ea', border: '#7239ea', className: 'fc-event-info'} : 
                    {bg: '#007bff', border: '#007bff', className: 'fc-event-primary'};

                events.push({
                    id: '${leave.leave_id}',
                    title: '${leave.leave_type_name}',
                    start: '${leave.start_date}'.substring(0,10),
                    end: moment('${leave.end_date}'.substring(0,10)).add(1, 'days').format("YYYY-MM-DD"),
                    description: '${leaveDescClean}',
                    backgroundColor: color.bg,
                    borderColor: color.border,
                    allDay: true,
                    status: '${leave.leave_status_id}',
                    leave_type_id: '${leave.leave_type_id}',
                    leave_file: '${leave.file_path}',
                    className: color.className
                });
            }
        </c:forEach>
        return events;
    }
    
    // Helper: get status class
    function getStatusClass(status) {
    	switch(status) {
        case 'On Time': 
            return { className: 'bg-success border-success ' };
        case 'Late':
        case 'Early out':
        case 'Unfinished Work': 
            return { className: 'bg-warning border-warning ' };
        case 'Incomplete': 
            return { className: 'bg-dark border-dark ' };
        default: 
            return { className: 'bg-dark border-dark ' };
    	}
    }
    
 	// Helper: format event title
    function getEventTitle(status, checkin, checkout, typein, typeout) {
        if (status === 'Incomplete') {
            return checkin.substring(11, 16) + "-";
        }
        
        var checkinTime = checkin ? checkin.substring(11, 16) : '--:--';
        var checkoutTime = checkout && checkout !== '' ? checkout.substring(0, 5) : '--:--';
        
        return checkinTime + ' - ' + checkoutTime;
    }
    
 	// Helper: format event description
    function getEventDescription(checkin, checkout, status, workhour) {
        var checkinDateObj = checkin ? new Date(checkin) : null;
        var checkDate = checkinDateObj ? checkinDateObj.toLocaleDateString('en-GB', { day: 'numeric', month: 'long', year: 'numeric' }) : '';
        var checkinTime = checkin ? checkin.substring(11, 16) : '';
        var checkoutTime = checkout && checkout !== '' ? checkout.substring(0, 5) : '';
        var workingHours = workhour ? workhour : '';
        
        var hours = Math.floor(workingHours / 60);
        var minutes = workingHours % 60;

        var formattedWorkingHours = ('0' + hours).slice(-2) + ':' + ('0' + minutes).slice(-2);
        
        return '<b>' + checkDate + '</b><br/>' +
        	   'Check-in: ' + checkinTime + '<br/>' +
               'Check-out: ' + checkoutTime + '<br/>' +
               'Work-time (hrs): ' + formattedWorkingHours + '<br/>' +
               'Status: ' + status;
    }
    
 	// Populate calendar checklist
	function populateCheckList(view) {
    	var events = calendar.getEvents();
    	console.log(events);
    	var $tableBody = $('#calendarTableBody');
    	$tableBody.empty();

    	//var start = moment(view.start);
    	//var end = moment(view.end);
    	var currentDate = calendar.getDate();
    	var start = moment(currentDate).startOf('month');
    	var end = moment(currentDate).endOf('month');
    	var today = moment();
    	console.log(end);


    	for (var day = start.clone(); day.isBefore(end); day.add(1, 'days')) {
    		var dayStr = day.format('dd D MMM');
    		var dayName = day.format('dd');

    		var dayEvents = events.filter(function(ev) {
    			if (ev.extendedProps && ev.extendedProps.leave_type_id) {
                    var evStart = moment(ev.start);
                    var evEnd = ev.end ? moment(ev.end).subtract(1, 'days') : evStart; // ลด end 1 วัน

                    return day.isSameOrAfter(evStart, 'day') && day.isSameOrBefore(evEnd, 'day');
                } else {
                    return moment(ev.start).format('dd D MMM') === dayStr;
                }
    		});

        	var checkin = '';
        	var checkout = '';
        	var workinghour = '';
        	var status = '';
        	var desIn = '';
        	var desOut = '';
        	
        	var dayNum = parseInt(day.format('YYYYMMDD'));
            var todayNum = parseInt(today.format('YYYYMMDD'));
            
            if (dayEvents.length === 0 && dayNum <= todayNum) {
                status = 'No Record';
            } else if (dayEvents.length > 0) {
        	    // Check holiday first
        	    var holidayEvent = dayEvents.find(function(ev) {
        	        return ev.classNames.includes('fc-event-secondary');
        	    });
        	    if (holidayEvent) {
        	        status = getHolidayStatusHTML(holidayEvent);
        	    } else {
        	        // Check Leave Second
        	        var leaveEvent = dayEvents.find(function(ev) {
        	            return ev.extendedProps && ev.extendedProps.leave_type_id;
        	        });
        	        if (leaveEvent) {
        	            var statusLeave = getLeaveStatusHTML(leaveEvent);
        	            status = statusLeave;
        	        } else {
        	            // Then Check work time (Check in - Check out)
        	            var workEvent = dayEvents.find(function(ev) {
        	                return ev.extendedProps && ev.extendedProps.eventType === 'work';
        	            });
        	            if (workEvent) {
        	            	const typeIn = Number(workEvent.extendedProps.workTypeIn);
        	            	checkin = workEvent.extendedProps.checkin 
        	            	    ? (typeIn === 1 
        	            	          ? '<i class="ki-duotone ki-map text-primary fs-2 me-1 align-middle">' +
              	            	            '<span class="path1"></span>' +
            	            	            '<span class="path2"></span>' +
        	            	            	'<span class="path3"></span>' +
            	            	            '</i> '
        	            	          : typeIn === 2 
        	            	            ? '<i class="ki-duotone ki-home-2 fs-2 text-teal me-1 align-middle">' +
                      	            	  	'<span class="path1"></span>' +
                    	            	  	'<span class="path2"></span>' +
                    	            	  	'</i> ' 
        	            	            : ''
        	            	      ) + workEvent.extendedProps.checkin.substring(11,16)
        	            	    : '';
        	            	const typeOut = Number(workEvent.extendedProps.workTypeOut);
        	            	checkout = workEvent.extendedProps.checkout 
        	            	    ? (typeOut === 1 
        	            	          ? '<i class="ki-duotone ki-map fs-2 text-primary me-1 align-middle">' +
        	            	            	'<span class="path1"></span>' +
        	            	            	'<span class="path2"></span>' +
        	            	            	'<span class="path3"></span>' +
        	            	            	'</i>  ' 
        	            	          : typeOut === 2 
        	            	            ? '<i class="ki-duotone ki-home-2 fs-2 text-teal me-1 align-middle">' +
                	            	     	 '<span class="path1"></span>' +
                	            	      	'<span class="path2"></span>' +
                	            	      	
                	            	      	'</i> ' 
        	            	            : ''
        	            	      ) + workEvent.extendedProps.checkout.substring(0,5)
        	            	    : '';
            	            desIn = workEvent.extendedProps.descriptionIn ? '<i class="ki-duotone ki-message-text-2 fs-2 text-gray-500 me-1 align-middle">' +
            	                '<span class="path1"></span>' +
            	                '<span class="path2"></span>' +
            	                '<span class="path3"></span>' +
            	                '</i>' + '<span class="fs-6 fw-400">' + workEvent.extendedProps.descriptionIn + '</span>'
            	                : '';
            	            desOut = workEvent.extendedProps.descriptionOut ? '<i class="ki-duotone ki-message-text-2 fs-2 text-gray-500 me-1 align-middle">' +
            	                '<span class="path1"></span>' +
            	                '<span class="path2"></span>' +
            	            	'<span class="path3"></span>' +
            	                '</i>' + '<span class="fs-6 fw-400">' + workEvent.extendedProps.descriptionOut + '</span>'
            	                : '';
        	                workinghour = workEvent.extendedProps.workinghour || '';
        	                status = workEvent.extendedProps.status;
        	            }
        	        }
        	    }
        	}

        	var rowStyle = "";
            if (dayName === 'Sa' || dayName === 'Su') {
                rowStyle = "bg-light";
                status = "";
            }
            
            var isHoliday = dayEvents.some(function(ev) { 
                return ev.classNames.includes('fc-event-secondary'); 
            });
            if (isHoliday) {
                rowStyle = "bg-light";
            }
            
        	var iconClass = getDayIconClass(dayName);
            var statusClass = getWorkStatusHTML(status);
            
            // get time work by format from minutes to HH:mm
            var formattedWorkingHours = '';
            if (workinghour) {
                var hours = Math.floor(workinghour / 60);
                var minutes = workinghour % 60;
                formattedWorkingHours = ('0' + hours).slice(-2) + ':' + ('0' + minutes).slice(-2);
            }
        
        	var rowHtml = '<tr class="' + rowStyle + '">';
        	rowHtml += '<td><span class="bullet bullet-vertical me-2 h-20px w-3px ' + iconClass + '" style="vertical-align: middle;"></span>' + dayStr + '</td>';
        	rowHtml += '<td>' + checkin + (desIn ? '<br/><small class="text-muted">' + desIn + '</small>' : '') + '</td>';
        	rowHtml += '<td>' + checkout + (desOut ? '<br/><small class="text-muted">' + desOut + '</small>' : '') + '</td>';
        	rowHtml += '<td>' + formattedWorkingHours + '</td>';
       		rowHtml += '<td>' + statusClass + '</td>';
        	rowHtml += '</tr>';

        	$tableBody.append(rowHtml);
    	}
	}
    
	// Calculate working days excluding weekends/holidays
	function calculateWorkingDays(year, month, holidays) {
	    // month = 0 (Jan) → 11 (Dec)
	    var start = moment([year, month]);
	    var end = start.clone().endOf("month");
	    var workingDays = 0;

	    for (var day = start.clone(); day.isSameOrBefore(end); day.add(1, "days")) {
	        var dow = day.day(); // 0=Sunday, 6=Saturday
	        if (dow !== 0 && dow !== 6) { // Not include Sat & Sun
	            // Check holiday ?
	            var isHoliday = holidays.some(function(hd) {
	                return moment(hd.start).isSame(day, "day");
	            });
	            if (!isHoliday) {
	                workingDays++;
	            }
	        }
	    }
	    return workingDays;
	}
    
	// Calculate summary
	function calculateSummary() {
		var events = calendar.getEvents();
	    var view = calendar.view;
	    var year = moment(view.currentStart).year();
	    var month = moment(view.currentStart).month();
	    
	    var holidayEvents = events.filter(ev => ev.classNames.includes("fc-event-secondary"));
	    
	    var summary = {
	        workingDay: calculateWorkingDays(year, month, holidayEvents),
	        onTime: 0,
	        leave: 0,
	        sickLeave: 0,
	        holiday: 0,
	        lateEarlyUnfinished: 0,
	        incomplete: 0,
	        noRecord: 0
	    };

	    var view = calendar.view;
	    var start = moment(view.currentStart);
	    var end = moment(view.currentEnd);
	    var today = moment();

	    for (var day = start.clone(); day.isBefore(end); day.add(1, 'days')) {
	        var dayEvents = events.filter(function(ev) {
	            return moment(ev.start).isSame(day, 'day');
	        });

	        var status = "";
	        if (dayEvents.length === 0 && day.isSameOrBefore(today)) {
	        	var dow = day.day(); // 0=Sunday, 6=Saturday
	            var isHoliday = holidayEvents.some(hd => moment(hd.start).isSame(day, "day"));
	            
	            if (dow !== 0 && dow !== 6 && !isHoliday) {
	                status = "No Record";
	                summary.noRecord++;
	            }
	            
	        } else if (dayEvents.length > 0) {
	            // holiday
	            if (dayEvents.some(ev => ev.classNames.includes("fc-event-secondary"))) {
	                status = "Holiday";
	                summary.holiday++;
	            }
	            // leave
	            else if (dayEvents.some(ev => ev.extendedProps && ev.extendedProps.leave_type_id)) {
	            	dayEvents.forEach(ev => {
	                    if (ev.extendedProps && ev.extendedProps.leave_type_id) {
	                        var evStart = moment(ev.start);
	                        var evEnd = ev.end ? moment(ev.end).subtract(1, 'days') : evStart; // ลด 1 วัน

	                        // คำนวณจำนวนวัน leave
	                        var leaveDays = evEnd.diff(evStart, 'days') + 1; // +1 เพราะ diff คืนค่าเป็นจำนวนวันเต็มระหว่างวันที่
	                        if (ev.title === "ลาป่วย") {
	                            status = "Sick Leave";
	                            summary.sickLeave += leaveDays;
	                        } else {
	                            status = "Leave";
	                            summary.leave += leaveDays;
	                        }
	                    }
	                });
	            }
	            // work
	            else if (dayEvents.some(ev => ev.extendedProps && ev.extendedProps.eventType === "work")) {
	                var workEv = dayEvents.find(ev => ev.extendedProps.eventType === "work");
	                switch (workEv.extendedProps.status) {
	                case "On Time":
	                    summary.onTime++;
	                    break;
	                case "Late":
	                case "Early out":
	                case "Unfinished Work":
	                    summary.lateEarlyUnfinished++;
	                    break;
	                case "Incomplete":
	                    summary.incomplete++;
	                    break;
	            	}
	            }
	        }
	    }

	    // Update value
	    document.querySelector("#summaryWorkingDay").textContent = summary.workingDay;
	    document.querySelector("#summaryOnTime").textContent = summary.onTime;
	    document.querySelector("#summaryLeave").textContent = summary.leave;
	    document.querySelector("#summarySickLeave").textContent = summary.sickLeave;
	    document.querySelector("#summaryHoliday").textContent = summary.holiday;
	    document.querySelector("#summaryLateEarly").textContent = summary.lateEarlyUnfinished;
	    document.querySelector("#summaryIncomplete").textContent = summary.incomplete;
	    document.querySelector("#summaryNoRecord").textContent = summary.noRecord;
	}
    
	function getHolidayStatusHTML(holidayEvent) {
	    var title = holidayEvent.title;
	    return '<span class="badge badge-secondary fs-7 fw-semibold">' + title + '</span>';
	}
	
	function getDayIconClass(dayName) {
        switch(dayName) {
            case 'Mo': return 'bg-warning';
            case 'Tu': return 'bg-pink';
            case 'We': return 'bg-success';
            case 'Th': return 'bg-warning';
            case 'Fr': return 'bg-primary';
            case 'Sa': return 'bg-info';
            case 'Su': return 'bg-danger';
            default: return 'bg-muted';
        }
        return '<span class="bullet bullet-vertical me-2 ' + colorClass + '"></span>';
    }
    
    function getWorkStatusHTML(status) {
        switch(status) {
        	case 'On Time': 
        	    return '<span class="badge badge-success fs-7 fw-semibold">On Time</span>';
        	case 'Incomplete': 
        	    return '<span class="badge badge-dark fs-7 fw-semibold">Incomplete</span>';
        	case 'Unfinished Work': 
        	    return '<span class="badge badge-warning fs-7 fw-semibold">Unfinished Work</span>';
        	case 'Late': 
        	    return '<span class="badge badge-warning fs-7 fw-semibold">Late</span>';
        	case 'Early out': 
        	    return '<span class="badge badge-warning fs-7 fw-semibold">Early out</span>';
        	case 'No Record': 
        	    return '<span class="badge badge-danger fs-7 fw-semibold">No Record</span>';
        	default: 
        	    return status || '';
        }
    }
    
    function getLeaveStatusHTML(leaveEvent) {
        var leaveTitle = leaveEvent.title;
        var statusLeave = '';
        var badgeColor = leaveTitle === 'ลาป่วย' ? 'badge badge-info' : 'badge badge-primary';
        var textColor = leaveTitle === 'ลาป่วย' ? 'text-info' : 'text-primary';
        console.log('leaveEvent:', leaveEvent);
        
        statusLeave = '<span class="' + badgeColor + ' fs-7 fw-bold style="cursor: pointer;" onclick="leaveStatus('+ leaveEvent.id +')">' + leaveTitle ;

		if (leaveEvent.extendedProps && leaveEvent.extendedProps.status === '0') {
        	statusLeave += ' <i class="ki-duotone ki-watch fs-2 text-warning align-middle">' +
            '<i class="path1"></i>' + '<i class="path2"></i>' + '</i>';
        }
        
        statusLeave += '</span>';
        
        // Check File Leave
        console.log(leaveEvent.extendedProps);
        console.log("Path:", "${pageContext.request.contextPath}");
        if (leaveEvent.extendedProps && leaveEvent.extendedProps.leave_file) {
            var fileUrl = "${pageContext.request.contextPath}" + leaveEvent.extendedProps.leave_file;
            statusLeave += "&nbsp;<a href='" + fileUrl + "' target='_blank' class='text-primary'>" +
            			"<i class='ki-duotone ki-document fs-2x text-primary align-middle'>" +
                		"<i class='path1'></i>" +
                		"<i class='path2'></i>" +
            			"</i> " + "</a>";
        }
        
        return statusLeave;
    }
	
	var calendar; // Global calendar variable
	
    return {
        //main function to initiate the module
        init: function() {
            var noTime = '${flag12}' ? moment('${flag12}', "YYYY-MM-DD") : moment();

            var calendarEl = document.getElementById('kt_docs_fullcalendar_populated');
            
            if (calendar) {
                calendar.destroy();
            }
            
            calendar = new FullCalendar.Calendar(calendarEl, {
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: ''
                },
                
                height: 800,
                contentHeight: 780,
                aspectRatio: 3,
                
                initialView: 'dayGridMonth',
                initialDate: noTime.format('YYYY-MM-DD'),
                
                nowIndicator: true,
                editable: true,
                dayMaxEvents: true,
                navLinks: true,
                
                datesSet: function(info) {
                	$('#calendarTitle').text(moment(info.view.currentStart).format('MMMM YYYY'));
                    populateCheckList(info);
                    calculateSummary();
                },

                eventClick: function(info) {
                    var event = info.event;
                    if (event.extendedProps && event.extendedProps.leave_type_id >= 1 && event.extendedProps.leave_type_id <= 9) {
                        <perm:permission object="leave.approve">
                            window.open("NewLeaveEdit?id=" + event.id + "&la=1", "_blank");
                        </perm:permission>
                    }
               	},

                eventDidMount: function(info) {
                    var event = info.event;
                    if (event.extendedProps && event.extendedProps.status === '0') {
                        var titleEl = info.el.querySelector('.fc-event-title');
                        if (titleEl) {
                        	titleEl.innerHTML = '<i class="fa fa-hourglass-end"></i> ' + titleEl.innerHTML;
                        }
                    }
                    
                    // Add Bootstrap tooltip
                    info.el.setAttribute('data-bs-toggle', 'tooltip');
                    info.el.setAttribute('data-bs-placement', 'top');
                    info.el.setAttribute('data-bs-html', 'true');
                    info.el.setAttribute('title', '<strong>' + event.title + '</strong><br/>' + (event.extendedProps.description || ''));
                },

                eventSources: [
                    { 
                        events: buildHolidayEvents(),
                        className: 'holiday-events'
                    },
                    { 
                        events: buildCheckinEvents(),
                        className: 'work-events'
                    },
                    { 
                        events: buildLeaveEvents(),
                        className: 'leave-events'
                    }
                ]
            });
            
            calendar.render();
            
            // Initialize tooltips after calendar renders
            setTimeout(function() {
                var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                tooltipTriggerList.forEach(function (tooltipTriggerEl) {
                    new bootstrap.Tooltip(tooltipTriggerEl);
                });
            }, 500);
        }
    };
}();
// ----------------- End Calendar & Checklist ------------------------

// --------------------- Leave Modal ------------------------
// Leave Status Modal Function

// --------------------- End of Leave Modal -----------------------

// --------------------- Initialize when document is ready ------------------------
jQuery(document).ready(function() {
	AppCalendar.init();
});
</script>