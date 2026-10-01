<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>

<%-- =====================================================================
     OLD: Calendar and Check List (desktop clone)
     ===================================================================== --%>
<%--
<div class="app-main flex-column flex-row-fluid">
	<div class="d-flex flex-column flex-column-fluid">
		<!-- Header -->
		<div class="app-toolbar py-3 py-lg-6">
			<div class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1 class="page-heading d-flex text-gray-900 fw-bold flex-column justify-content-center my-0">
						Calendar and Check List</h1>
					<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
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
								class="d-flex align-items-center mt-5 w-100"
								data-kt-search-keypress="true" data-kt-search-min-length="1"
								data-kt-search-enter="enter" data-kt-search-layout="menu"
								data-kt-menu-trigger="auto" data-kt-menu-permanent="true"
								data-kt-menu-placement="bottom-start">

								<!--begin::Form-->
								<form id="userCalendarForm"
									class="w-100 position-relative mb-5 mb-lg-0"
									autocomplete="off" action="SearchAllinCalendar"
									method="post" >
									<!--begin::Icon-->
									<i class="ki-duotone ki-magnifier fs-2 fs-lg-1 text-gray-500 position-absolute top-50 translate-middle-y ms-5">
										<span class="path1"></span> <span class="path2"></span>
									</i>
									<!--end::Icon-->
									<!--begin::Input-->
									<input type="text" class="form-control form-solid ps-14"
										name="usercalendar" id="userSearchInput"
										placeholder="${user.employeeId} - ${user.nameEN} - ${user.name} "
										data-kt-search-element="input" disabled="true"/>
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
								<span class="badge badge-primary">${user.workType == 1 ? 'On-site' : (user.workType == 2 ? 'WFH' : 'Head Office')}</span>
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
							<div class="badge badge-secondary fw-semibold me-7 mb-md-0 mb-5">Holiday</div>
							<div class="badge badge-success fw-semibold me-7 mb-md-0 mb-5">On time</div>
							<div class="badge badge-warning fw-semibold me-7 mb-md-0 mb-5">Late</div>
							<div class="badge badge-warning fw-semibold me-7 mb-md-0 mb-5">Early Out</div>
							<div class="badge badge-warning fw-semibold me-7 mb-md-0 mb-5">Unfinished Work</div>
							<div class="badge badge-dark fw-semibold me-7 mb-md-0 mb-5">Incomplete</div>
							<div class="badge badge-primary fw-semibold me-7 mb-md-0 mb-5">Leave</div>
							<div class="badge badge-info fw-semibold me-7 mb-md-0 mb-5">Sick Leave</div>
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
								<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
									<span class="fs-2hx me-2 text-green" id="summaryWorkingDay"></span>
									<span class="badge badge-green fs-7">Working Day</span>
								</div>
								<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
									<span class="fs-2hx me-2 text-success" id="summaryOnTime"></span>
									<span class="badge badge-success fs-7">On Time</span>
								</div>
								<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
									<span class="fs-2hx me-2 text-primary" id="summaryLeave"></span>
									<span class="badge badge-primary fs-7">Leave</span>
								</div>
								<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
									<span class="fs-2hx me-2 text-info" id="summarySickLeave"></span>
									<span class="badge badge-info fs-7">Sick Leave</span>
								</div>
								<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
									<span class="fs-2hx me-2 text-gray-600" id="summaryHoliday"></span>
									<span class="badge badge-light fs-7">Holiday</span>
								</div>
								<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
									<span class="fs-2hx me-2 text-warning" id="summaryLateEarly"></span>
									<span class="badge badge-warning fs-7 lh-base">Late / Early Out /<br>
										Unfinished Work
									</span>
								</div>
								<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
									<span class="fs-2hx me-2 text-dark" id="summaryIncomplete"></span>
									<span class="badge badge-dark fs-7">Incomplete</span>
								</div>
								<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
									<span class="fs-2hx me-2 text-danger" id="summaryNoRecord"></span>
									<span class="badge badge-danger fs-7">No Record</span>
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
								<div class="col-lg-6 col-md-6 col-6">
									<h2 class="card-title mb-0">Check List</h2>
								</div>
								<div class="col-lg-6 col-md-6 col-6 text-end">
									<h3 id="calendarTitle" class="fw-bold text-primary mb-0"></h3>
								</div>
							</div>
							<div class="row align-items-center w-100">
								<div class="col-md-12 col-12 text-end">
									<div class="mt-3">
										<i class="ki-duotone ki-delivery-door text-primary fs-4">
											<span class="path1"></span>
											<span class="path2"></span>
											<span class="path3"></span>
											<span class="path4"></span>
										</i>
										<span class="fs-6 me-5">On Site</span>
										<i class="ki-duotone ki-home text-teal fs-4">
										</i>
										<span class="fs-6 me-5">WFH</span>
										<i class="ki-duotone ki-cube-2 text-danger fs-4">
											<span class="path1"></span>
											<span class="path2"></span>
											<span class="path3"></span>
										</i>
										<span class="fs-6">Head Office</span>
									</div>

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
<div class="modal fade" id="leavemodal" tabindex="-1">
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
						<i class="ki-duotone ki-user-square fs-2">
							<span class="path1"></span>
							<span class="path2"></span>
							<span class="path3"></span>
						</i>
						<span id="employeeId"></span><span id="username"></span>
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
								class="path1"></span> <span class="path2"></span>
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
						<span>Request By : <span id="ucEmpId"></span> - <span id="ucName"></span> , <span id="timecreate"></span></span>
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
							</i>
							<!-- <span id="approveUser"></span> -->
							<span id="aprEmpId"></span> <span id="aprName"></span> - <span id="aprRole"></span>
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
</div>

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

    let enableUsers = [];
    let disableUsers = [];

    userList.forEach(function(user){
        if(user.enable == 1){
            enableUsers.push(user);
        }else{
            disableUsers.push(user);
        }
    });

    function createGroup(title, users){

        if(users.length === 0) return;

        users.sort(function(a,b){
            if(a.id == logonUser) return -1;
            if(b.id == logonUser) return 1;
            return 0;
        });

        var groupTitle = document.createElement("div");
        groupTitle.classList.add("menu-content","pb-2","px-3","fs-5","fw-semibold","text-gray-800");
        if(title === "Disable"){
            groupTitle.classList.add("mt-4");
        }
        groupTitle.textContent = title;

        resultsElement.appendChild(groupTitle);

        users.forEach(function(user){

        	var parts = [];

        	if(user.employee_id) parts.push(user.employee_id);
        	if(user.name_en) parts.push(user.name_en);
        	if(user.name) parts.push(user.name);

        	var displayText = parts.join(" - ");

            var item = document.createElement("div");
            item.classList.add("menu-item","px-3","py-2","cursor-pointer");

            item.textContent = displayText;

            // highlight คนที่เลือก
            if(user.id == logonUser){
                item.style.backgroundColor = "#eef6ff";
               /*  item.style.fontWeight = "bold"; */
            }

            item.addEventListener("click", function(e){
                e.preventDefault();
                document.querySelector("#userSearchInput").value = user.id;
                document.querySelector("#userCalendarForm").submit();
            });

            resultsElement.appendChild(item);

        });
    }

    createGroup("Enable", enableUsers);
    createGroup("Disable", disableUsers);
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

<perm:permission object="checklist.viewall">
	document.getElementById('userSearchInput').disabled = false;
</perm:permission>
// ----------------- END Search -----------------
</script>
<script> // ----------- Calendar & Checklist -----------------
"use strict";
// ----------- Calendar -----------------
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

	// Check-in/Check-out Events
	function buildCheckinEvents() {
	    var events = [];
	    var dailyData = {};

	    <c:forEach var="work" items="${workList}" varStatus="status">
	        var dateKey = '${work["DATE(work_hours_time_work)"]}';

	        if (dateKey && dateKey !== '') {
	            if (!dailyData[dateKey]) {
	                dailyData[dateKey] = {
	                    checkins: [],
	                    checkouts: [],
	                    allRecords: [],
	                    status: '${work.status}',
	                    workinghours: '${work.workinghours}',
	                    workTypeIn: '${work.workTypeIn}',
	                    workTypeOut: '${work.workTypeOut}'
	                };
	            }

	            var fullCheckin = '${work.mycheckins}';
	            var fullCheckout = '${work.checkouttime}';

	            if (fullCheckin && fullCheckin.trim() !== '' && fullCheckin !== 'null') {
	                dailyData[dateKey].checkins.push(fullCheckin);
	            }
	            if (fullCheckout && fullCheckout.trim() !== '' && fullCheckout !== 'null') {
	                dailyData[dateKey].checkouts.push(fullCheckout);
	            }

	            if ((fullCheckin && fullCheckin !== 'null') || (fullCheckout && fullCheckout !== 'null')) {
	                dailyData[dateKey].allRecords.push({
	                    checkin: fullCheckin !== 'null' ? fullCheckin : '',
	                    checkout: fullCheckout !== 'null' ? fullCheckout : '',
	                    workTypeIn: '${work.workTypeIn}' !== 'null' ? '${work.workTypeIn}' : '',
	                    workTypeOut: '${work.workTypeOut}' !== 'null' ? '${work.workTypeOut}' : '',
	                    descriptionIn: '${work.descriptionIn}' !== 'null' ? '${work.descriptionIn}' : '',
	                    descriptionOut: '${work.descriptionOut}' !== 'null' ? '${work.descriptionOut}' : ''
	                });
	            }
	        }
	    </c:forEach>

	    var dates = Object.keys(dailyData);
	    for (var i = 0; i < dates.length; i++) {
	        var dateStr = dates[i];
	        var dayData = dailyData[dateStr];

	        if (dayData.checkins.length === 0 && dayData.checkouts.length === 0) {
	            continue;
	        }

	        var minCheckin = "";
	        if (dayData.checkins && dayData.checkins.length > 0) {
	            dayData.checkins.sort();
	            minCheckin = dayData.checkins[0];
	        }
	        var maxCheckout = "";
	        if (dayData.checkouts && dayData.checkouts.length > 0) {
	            dayData.checkouts.sort();
	            maxCheckout = dayData.checkouts[dayData.checkouts.length - 1];
	        }

	        var title = getEventTitle(dayData.status, minCheckin, maxCheckout, dayData.workTypeIn, dayData.workTypeOut);
	        var statusClass = getStatusClass(dayData.status);

	        events.push({
	            id: 'work_' + dateStr,
	            title: title,
	            start: dateStr,
	            end: moment(dateStr).add(1, 'days').format("YYYY-MM-DD"),
	            allDay: true,
	            eventType: 'work',
	            checkin: minCheckin,
	            checkout: maxCheckout,
	            status: dayData.status,
	            className: statusClass.className,
	            extendedProps: {
	                checkinList: dayData.allRecords,
	                workinghour: dayData.workinghours,
	                status: dayData.status
	            }
	        });
	    }

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
				var halfDay = '${leave.half_day}';
				switch(halfDay){
					case '0': halfDay = 'เต็มวัน'; break;
					case '1': halfDay = 'ช่วงเช้า'; break;
					case '2': halfDay = 'ช่วงบ่าย'; break;
					case '3': halfDay = 'เลือกช่วงเวลา'; break;
				}
				var title = '${leave.leave_type_name}' + " : " + halfDay;

                events.push({
                    id: '${leave.leave_id}',
                    title: title,
                    start: '${leave.start_date}'.substring(0,10),
                    end: moment('${leave.end_date}'.substring(0,10)).add(1, 'days').format("YYYY-MM-DD"),
                    description: '${leaveDescClean}',
                    backgroundColor: color.bg,
                    borderColor: color.border,
                    allDay: true,
                    no_day : '${leave.no_day}',
                    status: '${leave.leave_status_id}',
                    leave_type_id: '${leave.leave_type_id}',
                    leave_file: '${leave.file_path}',
                    className: color.className
                });
            }
        </c:forEach>
        return events;
    }

	// Helper: (Check-In/Out) get status class
	function getStatusClass(status) {
    	switch(status) {
        case 'ONTIME':
            return { className: 'bg-success border-success ' };
        case 'LATE':
        case 'EARLY_OUT':
        case 'UNFINISHED_WORK':
            return { className: 'bg-warning border-warning ' };
        case 'INCOMPLETE':
            return { className: 'bg-black border-black ' };
        default:
            return { className: 'bg-black border-black ' };
    	}
    }

	// Helper: (Check-In/Out) format event title
	function getEventTitle(status, checkin, checkout, typein, typeout) {
		var workTypeIn = "";
        var workTypeOut = "";

        if(typein == '1'){
			workTypeIn = '<i class="ki-duotone ki-delivery-door fs-2 me-1 text-light align-middle">' +
				'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>';
		}else if(typein == '2'){
			workTypeIn = '<i class="ki-duotone ki-home fs-2 me-1 text-light align-middle">' +
                '</i> '
        }else if(typein == '3'){
			workTypeIn = '<i class="ki-duotone ki-cube-2 fs-2 me-1 text-light align-middle">' +
                '<span class="path1"></span><span class="path2"></span><span class="path3"></span></i> '
		}
		if(typeout == '1'){
			workTypeOut = '<i class="ki-duotone ki-delivery-door fs-2 me-1 text-light align-middle">' +
				'<span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>';
		}else if(typeout == '2'){
			workTypeOut = '<i class="ki-duotone ki-home fs-2 me-1 text-light align-middle">' +
                '</i> '
		}else if(typeout == '3'){
			workTypeOut = '<i class="ki-duotone ki-cube-2 fs-2 me-1 text-light align-middle">' +
            '<span class="path1"></span><span class="path2"></span><span class="path3"></span></i> '
		}

        if (status === 'INCOMPLETE') {
	        var incTime = (checkin && checkin !== '' && checkin !== 'null') ? checkin.substring(11, 16) : '--:--';
	        return incTime + " -";
	    }

        var checkinTime = checkin ? checkin.substring(11, 16) : '--:--';
        var checkoutTime = checkout && checkout !== '' ? checkout.substring(0, 5) : '--:--';
        return workTypeIn + ' ' + checkinTime + ' - ' + workTypeOut + ' ' + checkoutTime;
    }

	// Helper: (Check-In/Out) format event description
	function getEventDescription(checkin, checkout, status, workhour, typeIn, typeOut) {
		var checkinDateObj = checkin ? new Date(checkin) : null;
        var checkDate = checkinDateObj ? checkinDateObj.toLocaleDateString('en-GB', { day: 'numeric', month: 'long', year: 'numeric' }) : '';
        var checkinTime = checkin ? checkin.substring(11, 16) : '';
        var checkoutTime = checkout && checkout !== '' ? checkout.trim() : '';
        var workingHours = workhour ? workhour : '';

		switch(status) {
            case 'ONTIME': status = 'On Time'; break;
            case 'LATE': status = 'Late'; break;
            case 'EARLY_OUT': status = 'Early Out'; break;
            case 'UNFINISHED_WORK': status = 'Unfinished Work'; break;
            case 'INCOMPLETE': status = 'Incomplete'; break;
            case 'NO_RECORD': status = 'No Record'; break;
        }

        return '<b>' + checkDate + '</b><br/>' +
        	   'Check-in: ' + checkinTime + '<br/>' +
               'Check-out: ' + checkoutTime + '<br/>' +
               'Work-time (hrs): ' + workingHours + '<br/>' +
               'Status: ' + status;
    }

	// Populate calendar checklist
	function populateCheckList(view) {
		var events = calendar.getEvents();
		var $tableBody = $('#calendarTableBody');
		$tableBody.empty();

		var currentDate = calendar.getDate();
		var start = moment(currentDate).startOf('month');
		var end = moment(currentDate).endOf('month');
		var today = moment();

		for (var day = start.clone(); day.isBefore(end); day.add(1, 'days')) {
			var dayStr = day.format('dd D MMM');
			var dayName = day.format('dd');

			var dayEvents = events.filter(function(ev) {
                if (ev.extendedProps && ev.extendedProps.leave_type_id) {
                    var evStart = moment(ev.start);
                    var evEnd = ev.end ? moment(ev.end).subtract(1, 'days') : evStart.clone();
                    return day.isSameOrAfter(evStart, 'day') && day.isSameOrBefore(evEnd, 'day');
                }
                else if(ev.classNames && ev.classNames.includes('fc-event-secondary')){
                	var evStart = moment(ev.start);
                	var evEnd = ev.end ? moment(ev.end).subtract(1, 'days') : evStart.clone();
                	return day.isSameOrAfter(evStart, 'day') && day.isSameOrBefore(evEnd, 'day');
                }
                else {
                    return moment(ev.start).format('dd D MMM') === dayStr;
                }
            });

			var dayNum = parseInt(day.format('YYYYMMDD'));
			var todayNum = parseInt(today.format('YYYYMMDD'));
			var iconClass = getDayIconClass(dayName);
			var rowStyle = "";

			if (dayName === 'Sa' || dayName === 'Su') {
				rowStyle = "bg-light";
			}
			var isHolidayEvent = dayEvents.some(function(ev) {
				return ev.classNames.includes('fc-event-secondary');
			});
			if (isHolidayEvent) {
				rowStyle = "bg-light";
			}

			var workList = dayEvents.filter(function(ev) {
				return ev.extendedProps && ev.extendedProps.eventType === 'work';
			});
			var statusHtmlList = [];

			var holidayEvent = dayEvents.find(function(ev) { return ev.classNames.includes('fc-event-secondary'); });
			if (holidayEvent) {
				statusHtmlList.push(getHolidayStatusHTML(holidayEvent));
			}

			var leaveEvents = dayEvents.filter(function(ev) { return ev.extendedProps && ev.extendedProps.leave_type_id; });
			if (leaveEvents.length > 0) {
				leaveEvents.forEach(function(leave) {
					statusHtmlList.push(getLeaveStatusHTML(leave));
				});
			}

			if (workList.length > 0) {
				var combinedCheckinHtml = "";
				var combinedCheckoutHtml = "";

				var mainProps = workList[0].extendedProps;
				var workingHourVal = mainProps.workinghour || '';
				var statusVal = mainProps.status || '';
				if (statusVal && statusVal !== 'NO_RECORD') {
					statusHtmlList.push(getWorkStatusHTML(statusVal));
				}
				workList.forEach(function(workEvent, index) {
					var props = workEvent.extendedProps;
					var dataList = (props.checkinList && props.checkinList.length > 0) ? props.checkinList : [props];

					dataList.forEach(function(item, itemIndex) {
						// --- Logic Check-in ---
						var typeIn = Number(item.workTypeIn);
						var iconIn = "";
						if (typeIn === 1) iconIn = '<i class="ki-duotone ki-delivery-door text-primary fs-2 me-1 align-middle"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i> ';
						else if (typeIn === 2) iconIn = '<i class="ki-duotone ki-home fs-2 text-teal me-1 align-middle"></i> ';
						else if (typeIn === 3) iconIn = '<i class="ki-duotone ki-cube-2 fs-2 text-danger me-1 align-middle"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i> ';
						var rawCheckin = item.checkin || '';
						var timeIn = rawCheckin.length >= 16 ? rawCheckin.substring(11, 16) : '';
						var desIn = item.descriptionIn ? '<i class="ki-duotone ki-message-text-2 fs-2 text-gray-500 me-1 align-middle">'+
							'<span class="path1"></span><span class="path2"></span><span class="path3"></span></i><span class="fs-6 fw-400">' + item.descriptionIn.trim() + '</span>' : '';

						if (timeIn) {
							var spacer = itemIndex > 0 ? '<div class="separator separator-dashed my-1"></div>' : '';
							combinedCheckinHtml += spacer + '<div>' + iconIn + timeIn + '<br/><small class="text-muted">' + desIn + '</small></div>';
						}

						// --- Logic Check-out ---
						var typeOut = Number(item.workTypeOut);
						var iconOut = "";
						if (typeOut === 1) iconOut = '<i class="ki-duotone ki-delivery-door fs-2 text-primary me-1 align-middle"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i> ';
						else if (typeOut === 2) iconOut = '<i class="ki-duotone ki-home fs-2 text-teal me-1 align-middle"></i> ';
						else if (typeOut === 3) iconOut = '<i class="ki-duotone ki-cube-2 fs-2 text-danger me-1 align-middle"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i> ';
						var rawCheckout = item.checkout || '';
						var timeOut = rawCheckout ? rawCheckout.substring(0, 5) : '';
						//var timeOut = props.checkout ? props.checkout.substring(0, 5) : '';
						var desOut = item.descriptionOut ? '<i class="ki-duotone ki-message-text-2 fs-2 text-gray-500 me-1 align-middle">'+
								'<span class="path1"></span><span class="path2"></span><span class="path3"></span></i><span class="fs-6 fw-400">' + item.descriptionOut + '</span>' : '';

						if (timeOut) {
							var spacer = itemIndex > 0 ? '<div class="separator separator-dashed my-1"></div>' : '';
							combinedCheckoutHtml += spacer + '<div>' + iconOut + timeOut + '<br/><small class="text-muted">' + desOut + '</small></div>';
						}
					});
				});

				// Format Working Hours

				var finalStatusHtml = statusHtmlList.join('<div class="separator separator-dashed my-1"></div>');

				var rowHtml = '<tr class="' + rowStyle + '">';
				rowHtml += '<td><span class="bullet bullet-vertical me-2 h-20px w-3px ' + iconClass + '" style="vertical-align: middle;"></span>' + dayStr + '</td>';
				rowHtml += '<td>' + combinedCheckinHtml + '</td>';
				rowHtml += '<td>' + combinedCheckoutHtml + '</td>';
				rowHtml += '<td>' + workingHourVal + '</td>';
				rowHtml += '<td>' + finalStatusHtml + '</td>';
				rowHtml += '</tr>';

				$tableBody.append(rowHtml);

			} else {
				var status = '';
				var holidayEvent = dayEvents.find(function(ev) { return ev.classNames.includes('fc-event-secondary'); });
				var leaveEvent = dayEvents.find(function(ev) { return ev.extendedProps && ev.extendedProps.leave_type_id; });
				if (holidayEvent) {
					status = getHolidayStatusHTML(holidayEvent);
				} else if (leaveEvent) {
					status = getLeaveStatusHTML(leaveEvent);
				} else {
					if (dayNum <= todayNum) {
						if (dayName !== 'Sa' && dayName !== 'Su') {
							status = getWorkStatusHTML('NO_RECORD');
						}
					}
				}

				var rowHtml = '<tr class="' + rowStyle + '">';
				rowHtml += '<td><span class="bullet bullet-vertical me-2 h-20px w-3px ' + iconClass + '" style="vertical-align: middle;"></span>' + dayStr + '</td>';
				rowHtml += '<td></td><td></td><td></td>';
				rowHtml += '<td>' + (status || '') + '</td>';
				rowHtml += '</tr>';

				$tableBody.append(rowHtml);
			}
		}
	}

	// Calculate working days excluding weekends/holidays
	function calculateWorkingDays(year, month, holidays) {
	    var start = moment([year, month]);
	    var end = start.clone().endOf("month");
	    var workingDays = 0;

	    for (var day = start.clone(); day.isSameOrBefore(end); day.add(1, "days")) {
	        var dow = day.day(); // 0=Sunday, 6=Saturday
	        if (dow !== 0 && dow !== 6) { // Not include Sat & Sun
	            // Check holiday ?
	            var isHoliday = holidays.some(function(hd) {
	                var hdStart = moment(hd.start);
	                var hdEnd = hd.end ? moment(hd.end).subtract(1, 'days') : hdStart.clone();
	                return day.isSameOrAfter(hdStart, 'day') && day.isSameOrBefore(hdEnd, 'day');
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

	    var start = moment(view.currentStart);
	    var end = moment(view.currentEnd);
	    var today = moment();
		var processedLeaves = new Set();
	    for (var day = start.clone(); day.isBefore(end); day.add(1, 'days')) {
	        var dayEvents = events.filter(function(ev) {
                if (ev.extendedProps && ev.extendedProps.leave_type_id) {
                    var evStart = moment(ev.start);
                    var evEnd = ev.end ? moment(ev.end).subtract(1, 'days') : evStart.clone();
                    return day.isSameOrAfter(evStart, 'day') && day.isSameOrBefore(evEnd, 'day');
                } else if (ev.classNames && ev.classNames.includes('fc-event-secondary')) {
                    var evStart = moment(ev.start);
                    var evEnd = ev.end ? moment(ev.end).subtract(1, 'days') : evStart.clone();
                    return day.isSameOrAfter(evStart, 'day') && day.isSameOrBefore(evEnd, 'day');
                } else {
                    return moment(ev.start).isSame(day, 'day');
                }
	        });

	        var status = "";
	        if (dayEvents.length === 0 && day.isSameOrBefore(today)) {
	        	var dow = day.day(); // 0=Sunday, 6=Saturday
	            var isHoliday = holidayEvents.some(hd => {
	                var hdStart = moment(hd.start);
	                var hdEnd = hd.end ? moment(hd.end).subtract(1, 'days') : hdStart.clone();
	                return day.isSameOrAfter(hdStart, 'day') && day.isSameOrBefore(hdEnd, 'day');
	            });

	            if (dow !== 0 && dow !== 6 && !isHoliday) {
	                status = "NO_RECORD";
	                summary.noRecord++;
	            }

	        } else if (dayEvents.length > 0) {
	            // holiday
	            if (dayEvents.some(ev => ev.classNames.includes("fc-event-secondary"))) {
	                status = "Holiday";
	                summary.holiday++;
	            }
	            // leave
	            if (dayEvents.some(ev => ev.extendedProps && ev.extendedProps.leave_type_id)) {
                    dayEvents.filter(ev => ev.extendedProps && ev.extendedProps.leave_type_id).forEach(leaveEv => {
                        var noDay = parseFloat(leaveEv.extendedProps.no_day) || 0;
                        if (leaveEv.title.includes("ลาป่วย")) {
                            status = "Sick Leave";
                            if(!processedLeaves.has(leaveEv.id)) {
                                summary.sickLeave += noDay;
                                processedLeaves.add(leaveEv.id);
                            }
                        } else {
                            status = "Leave";
                            if(!processedLeaves.has(leaveEv.id)) {
                                summary.leave += noDay;
                                processedLeaves.add(leaveEv.id);
                            }
                        }
                    });
	            }
	            // work
	            if (dayEvents.some(ev => ev.extendedProps && ev.extendedProps.eventType === "work")) {
	                var workEv = dayEvents.find(ev => ev.extendedProps.eventType === "work");
	                switch (workEv.extendedProps.status) {
	                case "ONTIME":
	                    summary.onTime++;
	                    break;
	                case "LATE":
	                case "EARLY_OUT":
	                case "UNFINISHED_WORK":
	                    summary.lateEarlyUnfinished++;
	                    break;
	                case "INCOMPLETE":
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
        	case 'ONTIME':
        	    return '<span class="badge badge-success fs-7 fw-semibold">On Time</span>';
        	case 'INCOMPLETE':
        	    return '<span class="badge badge-dark fs-7 fw-semibold">Incomplete</span>';
        	case 'UNFINISHED_WORK':
        	    return '<span class="badge badge-warning fs-7 fw-semibold">Unfinished Work</span>';
        	case 'LATE':
        	    return '<span class="badge badge-warning fs-7 fw-semibold">Late</span>';
        	case 'EARLY_OUT':
        	    return '<span class="badge badge-warning fs-7 fw-semibold">Early out</span>';
        	case 'NO_RECORD':
        	    return '<span class="badge badge-danger fs-7 fw-semibold">No Record</span>';
        	default:
        	    return status || '';
        }
    }

	function getLeaveStatusHTML(leaveEvent) {
        var leaveTitle = leaveEvent.title;
        var statusLeave = '';
        var badgeColor = leaveTitle.includes('ลาป่วย') ? 'badge badge-info' : 'badge badge-primary';
        var textColor = leaveTitle.includes('ลาป่วย') ? 'text-info' : 'text-primary';

        statusLeave = '<span class="' + badgeColor + ' fs-7 fw-bold style="cursor: pointer;" onclick="leaveStatus('+ leaveEvent.id +')">' + leaveTitle ;

		if (leaveEvent.extendedProps && leaveEvent.extendedProps.status === '0') {
        	statusLeave += ' <i class="ki-duotone ki-watch fs-2 text-warning align-middle">' +
            '<i class="path1"></i>' + '<i class="path2"></i>' + '</i>';
        }
        statusLeave += '</span>';

        // Check File Leave
        if (leaveEvent.extendedProps && leaveEvent.extendedProps.leave_file) {
            var fileUrl = "${pageContext.request.contextPath}" + leaveEvent.extendedProps.leave_file;
            statusLeave += "&nbsp;<a href='" + fileUrl + "' target='_blank' class='text-primary'>" +
            			"<i class='ki-duotone ki-document fs-2x text-primary align-middle'>" +
                		"<i class='path1'></i><i class='path2'></i>" +
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
                showNonCurrentDates: false,
                fixedWeekCount: false,

				nowIndicator: true,
                editable: false,
                dayMaxEvents: true,
                navLinks: true,

                eventContent: function(arg) {
                    return { html: arg.event.title };
                },

				datesSet: function(info) {
                	$('#calendarTitle').text(moment(info.view.currentStart).format('MMMM YYYY'));
                    populateCheckList(info);
                    calculateSummary();
                },

				eventClick: function(info) {
                    var event = info.event;
                    if (event.extendedProps && event.extendedProps.leave_type_id >= 1 && event.extendedProps.leave_type_id <= 9) {
                        <perm:permission object="leave.approve">
                            window.open("line_NewLeaveEdit?id=" + event.id + "&la=1", "_blank");
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
	}
}();
// ----------- END Calendar -----------------

// ----------------- END Calendar & Checklist ------------------------

// --------------------- Leave Modal ------------------------
function leaveStatus(id) {
	$("#leavemodal").modal("show");

	$.ajax({
		url : "new_modalLeaveStatus",
		method : "POST",
 		data : "leaveId="+ id,
 		success : function(data) {
 			var obj = JSON.parse(data);
			console.log(obj);
			$('#leaveid').html(obj.leave_id);
			$('#employeeId').html(obj.employeeId);
			//$('#userid').html(obj.name);
			$('#username').html(obj.name);
			$('#ucEmpId').html(obj.ucEmpId);
			$('#ucName').html(obj.ucName);
			$('#stime').html(obj.start_time);
			$('#etime').html(obj.end_time);
			$('#desc').html(obj.description);

			if(obj.leave_file_id == null || obj.leave_file_id == ""){
				$('#file').html("No file");
			} else {
				$('#file').html(obj.leave_file_name + obj.leave_file_type);
				$('#file').attr('href', 'line_preview_File?id=' + obj.leave_file_id);
				$('#file').attr('target', '_blank');
			}

			$('#btn_edit_leave').attr({ href: 'line_NewLeaveEdit?id=' + obj.leave_id + '&la=1', target: '_blank' });

			// Set leave type
			var leaveTypeMap = {
				1: "ลาพักร้อน",
				2: "ลากิจ",
				3: "ลาป่วย",
				4: "ขาดงาน",
				5: "ลาโดยไม่รับค่าจ้าง",
				6: "ลาพักร้อนที่เหลือจากปีก่อน",
				7: "ลาอื่นๆ",
				9: "อื่นๆ"
			};
			$('#leavetype').html(leaveTypeMap[obj.leave_type_id] || "");

			var startdate = (obj.start_date).split(",");
			var sdate = moment(startdate[0]).format("D MMM YYYY");
			$('#sdate').html(sdate);

			var enddate = (obj.end_date).split(",");
			var edate = moment(enddate[0]).format("D MMM YYYY");
			$('#edate').html(edate);

			$('#noday').html(obj.no_day + " Day");

			//var timecreate = (obj.time_create).split(",");
			//var tcreate = moment(timecreate[0]).format("D MMM YYYY");
			$('#timecreate').html(obj.time_create.replace(",", " "));

			$('#approveDetail').addClass('d-none');
			$('#approveText').html("");

			// Set status with new theme classes
			switch(obj.leave_status_id) {
				case '0':
					$('#leavestatus').html("Wait for Approving").removeClass().addClass("badge badge-light-warning");
					break;
				case '1':
					$('#leavestatus').html("Approved").removeClass().addClass("badge badge-light-success");
					/* $('#approveUser').html(obj.appr_user_id); */
					$('#aprEmpId').html(obj.aprEmpId + " ");
					$('#aprName').html(obj.aprName + " - ");
					$('#aprRole').html(obj.aprRole);
					$('#timeUpdate').html(obj.time_update);
					//$('#detail').html(obj.dddd);
			        $('#approveDetail').removeClass('d-none');
					break;
				case '2':
					$('#leavestatus').html("Reject").removeClass().addClass("badge badge-light-danger");
					$('#approveUser').html(obj.appr_user_id);
					$('#timeUpdate').html(obj.time_update);
					//$('#detail').html(obj.dddd);
			        $('#approveDetail').removeClass('d-none');
					break;
				case '3':
					$('#leavestatus').html("Cancel").removeClass().addClass("badge badge-light-secondary");
					break;
			}
 		}
	});
}
// --------------------- END of Leave Modal -----------------------

</script>
<script>
// --------------------- Initialize when document is ready ------------------------
jQuery(document).ready(function() {
	AppCalendar.init();
});
</script>
--%>
<!-- ===== END: old desktop-clone content (commented out) ===== -->

<%-- =====================================================================
     NEW: LINE LIFF
     ===================================================================== --%>
<style>
.liff-shell {
	--liff-bullet-w: 3px;    /* แถบสีซ้ายของแถว */
	--liff-col-w: 60px;      /* column เวลา In/Out */
	--liff-inout-gap: 14px;
	--liff-week-gap: 8px;
}
#weekButtonsRow .btn-danger:hover,
#weekButtonsRow .btn-danger:focus,
#weekButtonsRow .btn-danger:active { background-color: var(--bs-danger) !important; border-color: var(--bs-danger) !important; color: #fff !important; }
#weekButtonsRow .week-label { color: #B5B5C3; }
#weekButtonsRow .btn-danger .week-label { color: #fff; }
.calendar-day-card { border: none; box-shadow: none; border-radius: 0; overflow: hidden; }
.calendar-day-card .bullet-vertical { height: auto !important; align-self: stretch; border-radius: 0; }
.calendar-day-card .day-date { font-weight: 600; font-size: 15px; line-height: 22.5px; letter-spacing: 0px; }
#calendarPrevBtn i, #calendarNextBtn i { transition: color .15s; }
#calendarPrevBtn:hover i, #calendarNextBtn:hover i { color: var(--bs-primary) !important; }
.liff-shell .fs-2x { font-size: 28px !important; }
.liff-shell .fs-2  { font-size: 20px !important; }
</style>

<div class="liff-shell">

	<div class="d-flex justify-content-between align-items-center mb-6 pt-6">
		<h1 class="liff-page-title text-gray-700 mb-0">Check List</h1>
		<h3 id="calendarTitle" class="fs-6 fw-bold text-primary mb-0" style="line-height:19.35px; letter-spacing:0px; cursor:pointer;"></h3>
	</div>

	<div class="d-none">
	<!-- Form without submit button -->
	<div class="d-flex flex-row">
		<div class="card flex-row-fluid mb-5">
	<%-- OLD: ช่องค้นหาพนักงาน (LIFF ไม่ใช้ และไม่ต้องฝังรายชื่อพนักงานในหน้า)
			<div class="card-header" style="border-bottom: none;">
				<!--begin::Main wrapper-->
				<div id="kt_docs_search_handler_responsive"
					class="d-flex align-items-center mt-5 w-100"
					data-kt-search-keypress="true" data-kt-search-min-length="1"
					data-kt-search-enter="enter" data-kt-search-layout="menu"
					data-kt-menu-trigger="auto" data-kt-menu-permanent="true"
					data-kt-menu-placement="bottom-start">

					<!--begin::Form-->
					<form id="userCalendarForm"
						class="w-100 position-relative mb-5 mb-lg-0"
						autocomplete="off" action="SearchAllinCalendar"
						method="post" >
						<!--begin::Icon-->
						<i class="ki-duotone ki-magnifier fs-2 fs-lg-1 text-gray-500 position-absolute top-50 translate-middle-y ms-5">
							<span class="path1"></span> <span class="path2"></span>
						</i>
						<!--end::Icon-->
						<!--begin::Input-->
						<input type="text" class="form-control form-solid ps-14"
							name="usercalendar" id="userSearchInput"
							placeholder="${user.employeeId} - ${user.nameEN} - ${user.name} "
							data-kt-search-element="input" disabled="true"/>
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
	--%>
			<div class="card-body d-flex flex-row flex-wrap pt-0">
				<div class="d-flex align-items-center me-5">
					<span class="badge badge-primary">${user.workType == 1 ? 'On-site' : (user.workType == 2 ? 'WFH' : 'Head Office')}</span>
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
			<div class="card-body" id="kt_docs_fullcalendar_populated" style="overflow-x: auto;">
			</div>
			<div class="card-footer d-flex flex-row flex-wrap">
				<div class="badge badge-secondary fw-semibold me-7 mb-md-0 mb-5">Holiday</div>
				<div class="badge badge-success fw-semibold me-7 mb-md-0 mb-5">On time</div>
				<div class="badge badge-warning fw-semibold me-7 mb-md-0 mb-5">Late</div>
				<div class="badge badge-warning fw-semibold me-7 mb-md-0 mb-5">Early Out</div>
				<div class="badge badge-warning fw-semibold me-7 mb-md-0 mb-5">Unfinished Work</div>
				<div class="badge badge-dark fw-semibold me-7 mb-md-0 mb-5">Incomplete</div>
				<div class="badge badge-primary fw-semibold me-7 mb-md-0 mb-5">Leave</div>
				<div class="badge badge-info fw-semibold me-7 mb-md-0 mb-5">Sick Leave</div>
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
					<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
						<span class="fs-2hx me-2 text-green" id="summaryWorkingDay"></span>
						<span class="badge badge-green fs-7">Working Day</span>
					</div>
					<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
						<span class="fs-2hx me-2 text-success" id="summaryOnTime"></span>
						<span class="badge badge-success fs-7">On Time</span>
					</div>
					<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
						<span class="fs-2hx me-2 text-primary" id="summaryLeave"></span>
						<span class="badge badge-primary fs-7">Leave</span>
					</div>
					<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
						<span class="fs-2hx me-2 text-info" id="summarySickLeave"></span>
						<span class="badge badge-info fs-7">Sick Leave</span>
					</div>
					<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
						<span class="fs-2hx me-2 text-gray-600" id="summaryHoliday"></span>
						<span class="badge badge-light fs-7">Holiday</span>
					</div>
					<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
						<span class="fs-2hx me-2 text-warning" id="summaryLateEarly"></span>
						<span class="badge badge-warning fs-7 lh-base">Late / Early Out /<br>
							Unfinished Work
						</span>
					</div>
					<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
						<span class="fs-2hx me-2 text-dark" id="summaryIncomplete"></span>
						<span class="badge badge-dark fs-7">Incomplete</span>
					</div>
					<div class="col-lg-3 col-md-4 col-6 mb-10 d-flex align-items-center">
						<span class="fs-2hx me-2 text-danger" id="summaryNoRecord"></span>
						<span class="badge badge-danger fs-7">No Record</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	<!-- ===== END: Search/User + Calendar + Summary boxes (hidden, kept for script) ===== -->

	<!-- Check List -->
	<div class="d-flex flex-row" style="min-width:0;">
		<div class="card flex-row-fluid mb-5" style="min-width:0;">
			<div class="card-header pt-10" style="border-bottom: none;">
				<div id="calendarMonthYearRow" class="d-flex align-items-center justify-content-between w-100">
					<a href="#" id="calendarPrevBtn" class="d-inline-flex" style="padding:12px; margin:-12px;">
						<i class="ki-duotone ki-left-square fs-2x text-muted"><span class="path1"></span><span class="path2"></span></i>
					</a>
					<h3 id="calendarMonthYear" class="fs-5 fw-bold mb-0"></h3>
					<a href="#" id="calendarNextBtn" class="d-inline-flex" style="padding:12px; margin:-12px;">
						<i class="ki-duotone ki-right-square fs-2x text-muted"><span class="path1"></span><span class="path2"></span></i>
					</a>
				</div>

			</div>
			<div class="card-body">
				<div class="mb-9" style="padding-left:calc(var(--liff-gutter) + var(--liff-bullet-w)); padding-right:var(--liff-gutter);">
					<div id="weekButtonsRow" class="d-flex justify-content-center" style="gap:var(--liff-week-gap);">
					</div>
				</div>

				<div class="d-flex align-items-stretch mb-3">
					<span style="width:var(--liff-bullet-w); visibility:hidden;"></span>
					<div class="d-flex justify-content-between px-4 flex-fill">
						<span class="fs-8 fw-bold text-gray-500 text-uppercase">Date</span>
						<div class="d-flex gap-5">
							<span class="fs-8 fw-bold text-gray-500 text-uppercase" style="min-width:var(--liff-col-w); text-align:center;">In</span>
							<span class="fs-8 fw-bold text-gray-500 text-uppercase" style="min-width:var(--liff-col-w); text-align:center;">Out</span>
						</div>
					</div>
				</div>
				<div id="calendarTableBody">
				</div>
			</div>
		</div>
	</div>

</div>

<%-- ===== OLD: modal ใบลาแบบ desktop (disabled, kept for reference) =====
<!-- Leave Modal -->
<div class="modal fade" id="leavemodal" tabindex="-1">
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
						<i class="ki-duotone ki-user-square fs-2">
							<span class="path1"></span>
							<span class="path2"></span>
							<span class="path3"></span>
						</i>
						<span id="employeeId"></span><span id="username"></span>
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

				<%-- ไม่แสดงคำอธิบาย/ไฟล์แนบใน Check List
				<div class="row mb-5 fs-6 fw-medium">
					<div class="col-md-6">
						<div class="d-flex align-items-center mb-2">
							<i class="ki-duotone ki-message-text fs-2 me-2"> <span
								class="path1"></span> <span class="path2"></span>
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
				--%>
<%-- OLD (ต่อ): modal ใบลาแบบ desktop

				<div class="row mb-5 fs-6 fw-medium">
					<div class="col-md-6">
						<span id="leavestatus"></span>
					</div>
					<div class="col-md-6 fs-8 text-gray-500">
						<span>Request By : <span id="ucEmpId"></span> - <span id="ucName"></span> , <span id="timecreate"></span></span>
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
							</i>
							<!-- <span id="approveUser"></span> -->
							<span id="aprEmpId"></span> <span id="aprName"></span> - <span id="aprRole"></span>
						</div>
						<div class="col-md-6">
							<i class="ki-duotone ki-calendar-2 fs-2 me-2"> <span
								class="path1"></span> <span class="path2"></span>
							</i><span id="timeUpdate"></span>
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
</div>
--%>

<%-- ===== NEW: modal รายละเอียดใบลา LIFF (ตัวกลาง, ไม่แสดงคำอธิบาย/ไฟล์แนบ) ===== --%>
<jsp:include page="/pages-line/common/leave_modal.jsp" />

<%-- OLD: script ค้นหาพนักงาน (ฝัง ${cubeUserJson} ทั้งบริษัท) LIFF ไม่ใช้
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

    let enableUsers = [];
    let disableUsers = [];

    userList.forEach(function(user){
        if(user.enable == 1){
            enableUsers.push(user);
        }else{
            disableUsers.push(user);
        }
    });

    function createGroup(title, users){

        if(users.length === 0) return;

        users.sort(function(a,b){
            if(a.id == logonUser) return -1;
            if(b.id == logonUser) return 1;
            return 0;
        });

        var groupTitle = document.createElement("div");
        groupTitle.classList.add("menu-content","pb-2","px-3","fs-5","fw-semibold","text-gray-800");
        if(title === "Disable"){
            groupTitle.classList.add("mt-4");
        }
        groupTitle.textContent = title;

        resultsElement.appendChild(groupTitle);

        users.forEach(function(user){

        	var parts = [];

        	if(user.employee_id) parts.push(user.employee_id);
        	if(user.name_en) parts.push(user.name_en);
        	if(user.name) parts.push(user.name);

        	var displayText = parts.join(" - ");

            var item = document.createElement("div");
            item.classList.add("menu-item","px-3","py-2","cursor-pointer");

            item.textContent = displayText;

            // highlight คนที่เลือก
            if(user.id == logonUser){
                item.style.backgroundColor = "#eef6ff";
               /*  item.style.fontWeight = "bold"; */
            }

            item.addEventListener("click", function(e){
                e.preventDefault();
                document.querySelector("#userSearchInput").value = user.id;
                document.querySelector("#userCalendarForm").submit();
            });

            resultsElement.appendChild(item);

        });
    }

    createGroup("Enable", enableUsers);
    createGroup("Disable", disableUsers);
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

<perm:permission object="checklist.viewall">
	document.getElementById('userSearchInput').disabled = false;
</perm:permission>
// ----------------- END Search -----------------
</script>
--%>
<%!
// กัน JS string literal และ กัน HTML injection จาก free-text field (description)
private String escFreeText(String s) {
	if (s == null) return "";
	return s.replace("\\", "\\\\")
			.replace("\r\n", " ").replace("\n", " ").replace("\r", " ")
			.replace("'", "\\'")
			.replace("&", "&amp;")
			.replace("<", "&lt;")
			.replace(">", "&gt;")
			.replace("\"", "&quot;");
}
%>
<script> // ----------- Calendar & Checklist -----------------
"use strict";
// ----------- Calendar -----------------
// Calendar Application Class
var AppCalendar = function() {
	// Holiday Events
	function buildHolidayEvents() {
        var events = [];
        <c:forEach var="holiday" items="${allholiday}">
        <c:set var = "rawHolidayDesc" value = "${holiday.description}"/>
        <% pageContext.setAttribute("holidayDescClean", escFreeText((String) pageContext.getAttribute("rawHolidayDesc"))); %>
        <c:set var = "rawHolidayHead" value = "${holiday.head}"/>
        <% pageContext.setAttribute("holidayHeadClean", escFreeText((String) pageContext.getAttribute("rawHolidayHead"))); %>
            events.push({
                id: '${holiday.id_date}',
                title: '${holidayHeadClean}',
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

	// Check-in/Check-out Events
	function buildCheckinEvents() {
	    var events = [];
	    var dailyData = {};

	    <c:forEach var="work" items="${workList}" varStatus="status">
	        var dateKey = '${work["DATE(work_hours_time_work)"]}';
	        <c:set var = "rawDescIn" value = "${work.descriptionIn}" />
	        <% pageContext.setAttribute("descriptionInClean", escFreeText((String) pageContext.getAttribute("rawDescIn"))); %>
	        <c:set var = "rawDescOut" value = "${work.descriptionOut}" />
	        <% pageContext.setAttribute("descriptionOutClean", escFreeText((String) pageContext.getAttribute("rawDescOut"))); %>

	        if (dateKey && dateKey !== '') {
	            if (!dailyData[dateKey]) {
	                dailyData[dateKey] = {
	                    checkins: [],
	                    checkouts: [],
	                    allRecords: [],
	                    status: '${work.status}',
	                    workinghours: '${work.workinghours}',
	                    workTypeIn: '${work.workTypeIn}',
	                    workTypeOut: '${work.workTypeOut}'
	                };
	            }

	            var fullCheckin = '${work.mycheckins}';
	            var fullCheckout = '${work.checkouttime}';

	            if (fullCheckin && fullCheckin.trim() !== '' && fullCheckin !== 'null') {
	                dailyData[dateKey].checkins.push(fullCheckin);
	            }
	            if (fullCheckout && fullCheckout.trim() !== '' && fullCheckout !== 'null') {
	                dailyData[dateKey].checkouts.push(fullCheckout);
	            }

	            if ((fullCheckin && fullCheckin !== 'null') || (fullCheckout && fullCheckout !== 'null')) {
	                dailyData[dateKey].allRecords.push({
	                    checkin: fullCheckin !== 'null' ? fullCheckin : '',
	                    checkout: fullCheckout !== 'null' ? fullCheckout : '',
	                    workTypeIn: '${work.workTypeIn}' !== 'null' ? '${work.workTypeIn}' : '',
	                    workTypeOut: '${work.workTypeOut}' !== 'null' ? '${work.workTypeOut}' : '',
	                    descriptionIn: '${descriptionInClean}' !== 'null' ? '${descriptionInClean}' : '',
	                    descriptionOut: '${descriptionOutClean}' !== 'null' ? '${descriptionOutClean}' : ''
	                });
	            }
	        }
	    </c:forEach>

	    var dates = Object.keys(dailyData);
	    for (var i = 0; i < dates.length; i++) {
	        var dateStr = dates[i];
	        var dayData = dailyData[dateStr];

	        if (dayData.checkins.length === 0 && dayData.checkouts.length === 0) {
	            continue;
	        }

	        var minCheckin = "";
	        if (dayData.checkins && dayData.checkins.length > 0) {
	            dayData.checkins.sort();
	            minCheckin = dayData.checkins[0];
	        }
	        var maxCheckout = "";
	        if (dayData.checkouts && dayData.checkouts.length > 0) {
	            dayData.checkouts.sort();
	            maxCheckout = dayData.checkouts[dayData.checkouts.length - 1];
	        }

	        var title = getEventTitle(dayData.status, minCheckin, maxCheckout, dayData.workTypeIn, dayData.workTypeOut);
	        var statusClass = getStatusClass(dayData.status);

	        events.push({
	            id: 'work_' + dateStr,
	            title: title,
	            start: dateStr,
	            end: moment(dateStr).add(1, 'days').format("YYYY-MM-DD"),
	            allDay: true,
	            eventType: 'work',
	            checkin: minCheckin,
	            checkout: maxCheckout,
	            status: dayData.status,
	            className: statusClass.className,
	            extendedProps: {
	                checkinList: dayData.allRecords,
	                workinghour: dayData.workinghours,
	                status: dayData.status
	            }
	        });
	    }

	    return events;
	}

	// Leave Events
	function buildLeaveEvents() {
        var events = [];
        <c:forEach var="leave" items="${leave}">
        <c:set var = "rawLeaveDesc" value = "${leave.description}"/>
        <% pageContext.setAttribute("leaveDescClean", escFreeText((String) pageContext.getAttribute("rawLeaveDesc"))); %>
            if (${leave.leave_status_id} != 3 && ${leave.leave_status_id} != 2) {
                var color = '${leave.leave_type_id}' === '3' ? // ลาป่วย
                    {bg: '#7239ea', border: '#7239ea', className: 'fc-event-info'} :
                    {bg: '#007bff', border: '#007bff', className: 'fc-event-primary'};
				var halfDay = '${leave.half_day}';
				switch(halfDay){
					case '0': halfDay = 'เต็มวัน'; break;
					case '1': halfDay = 'ช่วงเช้า'; break;
					case '2': halfDay = 'ช่วงบ่าย'; break;
					case '3': halfDay = 'เลือกช่วงเวลา'; break;
				}
				var title = '${leave.leave_type_name}' + " : " + halfDay;

                events.push({
                    id: '${leave.leave_id}',
                    title: title,
                    start: '${leave.start_date}'.substring(0,10),
                    end: moment('${leave.end_date}'.substring(0,10)).add(1, 'days').format("YYYY-MM-DD"),
                    description: '${leaveDescClean}',
                    backgroundColor: color.bg,
                    borderColor: color.border,
                    allDay: true,
                    no_day : '${leave.no_day}',
                    status: '${leave.leave_status_id}',
                    leave_type_id: '${leave.leave_type_id}',
                    leave_file: '${leave.file_path}',
                    className: color.className
                });
            }
        </c:forEach>
        return events;
    }

	// Helper: (Check-In/Out) get status class
	function getStatusClass(status) {
    	switch(status) {
        case 'ONTIME':
            return { className: 'bg-success border-success ' };
        case 'LATE':
        case 'EARLY_OUT':
        case 'UNFINISHED_WORK':
            return { className: 'bg-warning border-warning ' };
        case 'INCOMPLETE':
            return { className: 'bg-black border-black ' };
        default:
            return { className: 'bg-black border-black ' };
    	}
    }

	const WORK_TYPE_ICON_MAP = {
		1: { name: 'ki-map',    paths: 3, color: 'text-primary' },
		2: { name: 'ki-home-2', paths: 2, color: 'text-success' },
		3: { name: 'ki-cube-2', paths: 3, color: 'text-danger' }
	};
	
	function getWorkTypeIconHtml(type, size, colorClass) {
		const icon = WORK_TYPE_ICON_MAP[Number(type)];
		if (!icon) return '';
		let spans = '';
		for (let i = 1; i <= icon.paths; i++) { spans += '<span class="path' + i + '"></span>'; }
		return '<i class="ki-duotone ' + icon.name + ' ' + size + ' ' + (colorClass || icon.color) + ' me-1 align-middle">' + spans + '</i> ';
	}

	// Helper: (Check-In/Out) format event title
	function getEventTitle(status, checkin, checkout, typein, typeout) {
		const workTypeIn = getWorkTypeIconHtml(typein, 'fs-2', 'text-light');
		const workTypeOut = getWorkTypeIconHtml(typeout, 'fs-2', 'text-light');

        if (status === 'INCOMPLETE') {
	        var incTime = (checkin && checkin !== '' && checkin !== 'null') ? checkin.substring(11, 16) : '--:--';
	        return incTime + " -";
	    }

        var checkinTime = checkin ? checkin.substring(11, 16) : '--:--';
        var checkoutTime = checkout && checkout !== '' ? checkout.substring(0, 5) : '--:--';
        return workTypeIn + ' ' + checkinTime + ' - ' + workTypeOut + ' ' + checkoutTime;
    }

	function filterDayEvents(events, day, dayStr) {
		return events.filter(function(ev) {
			if ((ev.extendedProps && ev.extendedProps.leave_type_id) ||
				(ev.classNames && ev.classNames.includes('fc-event-secondary'))) {
				const evStart = moment(ev.start);
				const evEnd = ev.end ? moment(ev.end).subtract(1, 'days') : evStart.clone();
				return day.isSameOrAfter(evStart, 'day') && day.isSameOrBefore(evEnd, 'day');
			}
			return moment(ev.start).format('dd D MMM') === dayStr;
		});
	}

	function pickFirstInLastOut(workEvent) {
		const props = workEvent.extendedProps;
		const items = (props.checkinList && props.checkinList.length > 0) ? props.checkinList : [props];

		let earliestCheckinItem = null;
		let latestCheckoutItem = null;
		items.forEach(function(item) {
			if (item.checkin && (!earliestCheckinItem || item.checkin < earliestCheckinItem.checkin)) {
				earliestCheckinItem = item;
			}
			if (item.checkout && (!latestCheckoutItem || item.checkout > latestCheckoutItem.checkout)) {
				latestCheckoutItem = item;
			}
		});
		return { earliestCheckinItem: earliestCheckinItem, latestCheckoutItem: latestCheckoutItem };
	}

	
	function buildInOutColumnHtml(iconHtml, time) {
		if (!time) return '';
		return '<div style="display:flex;flex-direction:column;align-items:center;gap:var(--liff-inout-gap);">' + iconHtml + '<span class="fw-bold fs-6 text-capitalize lh-1" style="letter-spacing:0;">' + time + '</span></div>';
	}

	function buildDayRowHtml(weekIndex, rowStyle, iconClass, dayStr, statusHtml, checkinHtml, checkoutHtml) {
		let html = '<div class="calendar-day-card card mb-3 ' + rowStyle + '" data-week="' + weekIndex + '">';
		html += '<div class="d-flex align-items-stretch">';
		html += '<span class="bullet bullet-vertical ' + iconClass + '" style="width:var(--liff-bullet-w);"></span>';
		html += '<div class="card-body d-flex align-items-center justify-content-between py-5 px-4 flex-fill">';
		html += '<div><span class="day-date">' + dayStr + '</span>' + (statusHtml ? '<br/><span style="display:inline-block;margin-top:10px;">' + statusHtml + '</span>' : '') + '</div>';
		html += '<div class="d-flex gap-5">';
		html += '<div style="display:flex;flex-direction:column;align-items:center;min-width:var(--liff-col-w);">' + checkinHtml + '</div>';
		html += '<div style="display:flex;flex-direction:column;align-items:center;min-width:var(--liff-col-w);">' + checkoutHtml + '</div>';
		html += '</div></div></div></div>';
		return html;
	}

	// Populate calendar checklist
	function populateCheckList() {
		var events = calendar.getEvents();
		var $tableBody = $('#calendarTableBody');
		$tableBody.empty();

		var currentDate = calendar.getDate();
		var start = moment(currentDate).startOf('month');
		var end = moment(currentDate).endOf('month');
		var today = moment();
		var weekStart = moment(start).startOf('isoWeek');
		var maxWeek = 0;

		for (var day = start.clone(); day.isBefore(end); day.add(1, 'days')) {
			var dayStr = day.format('dd D MMM');
			var dayName = day.format('dd');
			var dayEvents = filterDayEvents(events, day, dayStr);

			var dayNum = parseInt(day.format('YYYYMMDD'));
			var weekIndex = Math.floor(day.diff(weekStart, 'days') / 7);
			if (weekIndex > maxWeek) maxWeek = weekIndex;
			var todayNum = parseInt(today.format('YYYYMMDD'));
			var iconClass = getDayIconClass(dayName);
			var rowStyle = (dayName === 'Sa' || dayName === 'Su') ? "bg-light" : "";

			var holidayEvent = dayEvents.find(function(ev) { return ev.classNames.includes('fc-event-secondary'); });
			if (holidayEvent) {
				rowStyle = "bg-light";
			}

			var workList = dayEvents.filter(function(ev) {
				return ev.extendedProps && ev.extendedProps.eventType === 'work';
			});
			var statusHtmlList = [];
			if (holidayEvent) {
				statusHtmlList.push(getHolidayStatusHTML(holidayEvent));
			}

			var leaveEvents = dayEvents.filter(function(ev) { return ev.extendedProps && ev.extendedProps.leave_type_id; });
			leaveEvents.forEach(function(leave) {
				statusHtmlList.push(getLeaveStatusHTML(leave));
			});

			var rowHtml;
			if (workList.length > 0) {
				const statusVal = workList[0].extendedProps.status || '';
				if (statusVal && statusVal !== 'NO_RECORD') {
					statusHtmlList.push(getWorkStatusHTML(statusVal));
				}

				const { earliestCheckinItem, latestCheckoutItem } = pickFirstInLastOut(workList[0]);

				let combinedCheckinHtml = "";
				if (earliestCheckinItem) {
					const timeIn = earliestCheckinItem.checkin && earliestCheckinItem.checkin.length >= 16 ? earliestCheckinItem.checkin.substring(11, 16) : '';
					combinedCheckinHtml = buildInOutColumnHtml(
						getWorkTypeIconHtml(earliestCheckinItem.workTypeIn, 'fs-2'),
						timeIn
					);
				}

				let combinedCheckoutHtml = "";
				if (latestCheckoutItem) {
					const timeOut = latestCheckoutItem.checkout ? latestCheckoutItem.checkout.substring(0, 5) : '';
					combinedCheckoutHtml = buildInOutColumnHtml(
						getWorkTypeIconHtml(latestCheckoutItem.workTypeOut, 'fs-2'),
						timeOut
					);
				}

				const finalStatusHtml = statusHtmlList.join('<div class="mb-1"></div>');
				rowHtml = buildDayRowHtml(weekIndex, rowStyle, iconClass, dayStr, finalStatusHtml, combinedCheckinHtml, combinedCheckoutHtml);

			} else {
				var leaveEvent = dayEvents.find(function(ev) { return ev.extendedProps && ev.extendedProps.leave_type_id; });
				var status = '';
				if (holidayEvent) {
					status = getHolidayStatusHTML(holidayEvent);
				} else if (leaveEvent) {
					status = getLeaveStatusHTML(leaveEvent);
				} else if (dayNum <= todayNum && dayName !== 'Sa' && dayName !== 'Su') {
					status = getWorkStatusHTML('NO_RECORD');
				}
				rowHtml = buildDayRowHtml(weekIndex, rowStyle, iconClass, dayStr, status, '', '');
			}

			$tableBody.append(rowHtml);
		}
		return maxWeek + 1;
	}

	// Calculate working days excluding weekends/holidays
	function calculateWorkingDays(year, month, holidays) {
	    var start = moment([year, month]);
	    var end = start.clone().endOf("month");
	    var workingDays = 0;

	    for (var day = start.clone(); day.isSameOrBefore(end); day.add(1, "days")) {
	        var dow = day.day(); // 0=Sunday, 6=Saturday
	        if (dow !== 0 && dow !== 6) { // Not include Sat & Sun
	            // Check holiday ?
	            var isHoliday = holidays.some(function(hd) {
	                var hdStart = moment(hd.start);
	                var hdEnd = hd.end ? moment(hd.end).subtract(1, 'days') : hdStart.clone();
	                return day.isSameOrAfter(hdStart, 'day') && day.isSameOrBefore(hdEnd, 'day');
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

	    var start = moment(view.currentStart);
	    var end = moment(view.currentEnd);
	    var today = moment();
		var processedLeaves = new Set();
	    for (var day = start.clone(); day.isBefore(end); day.add(1, 'days')) {
	        var dayEvents = events.filter(function(ev) {
                if (ev.extendedProps && ev.extendedProps.leave_type_id) {
                    var evStart = moment(ev.start);
                    var evEnd = ev.end ? moment(ev.end).subtract(1, 'days') : evStart.clone();
                    return day.isSameOrAfter(evStart, 'day') && day.isSameOrBefore(evEnd, 'day');
                } else if (ev.classNames && ev.classNames.includes('fc-event-secondary')) {
                    var evStart = moment(ev.start);
                    var evEnd = ev.end ? moment(ev.end).subtract(1, 'days') : evStart.clone();
                    return day.isSameOrAfter(evStart, 'day') && day.isSameOrBefore(evEnd, 'day');
                } else {
                    return moment(ev.start).isSame(day, 'day');
                }
	        });

	        var status = "";
	        if (dayEvents.length === 0 && day.isSameOrBefore(today)) {
	        	var dow = day.day(); // 0=Sunday, 6=Saturday
	            var isHoliday = holidayEvents.some(hd => {
	                var hdStart = moment(hd.start);
	                var hdEnd = hd.end ? moment(hd.end).subtract(1, 'days') : hdStart.clone();
	                return day.isSameOrAfter(hdStart, 'day') && day.isSameOrBefore(hdEnd, 'day');
	            });

	            if (dow !== 0 && dow !== 6 && !isHoliday) {
	                status = "NO_RECORD";
	                summary.noRecord++;
	            }

	        } else if (dayEvents.length > 0) {
	            // holiday
	            if (dayEvents.some(ev => ev.classNames.includes("fc-event-secondary"))) {
	                status = "Holiday";
	                summary.holiday++;
	            }
	            // leave
	            if (dayEvents.some(ev => ev.extendedProps && ev.extendedProps.leave_type_id)) {
                    dayEvents.filter(ev => ev.extendedProps && ev.extendedProps.leave_type_id).forEach(leaveEv => {
                        var noDay = parseFloat(leaveEv.extendedProps.no_day) || 0;
                        if (leaveEv.extendedProps.leave_type_id === '3') { // ลาป่วย
                            status = "Sick Leave";
                            if(!processedLeaves.has(leaveEv.id)) {
                                summary.sickLeave += noDay;
                                processedLeaves.add(leaveEv.id);
                            }
                        } else {
                            status = "Leave";
                            if(!processedLeaves.has(leaveEv.id)) {
                                summary.leave += noDay;
                                processedLeaves.add(leaveEv.id);
                            }
                        }
                    });
	            }
	            // work
	            if (dayEvents.some(ev => ev.extendedProps && ev.extendedProps.eventType === "work")) {
	                var workEv = dayEvents.find(ev => ev.extendedProps.eventType === "work");
	                switch (workEv.extendedProps.status) {
	                case "ONTIME":
	                    summary.onTime++;
	                    break;
	                case "LATE":
	                case "EARLY_OUT":
	                case "UNFINISHED_WORK":
	                    summary.lateEarlyUnfinished++;
	                    break;
	                case "INCOMPLETE":
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
            case 'Th': return 'bg-orange';
            case 'Fr': return 'bg-primary';
            case 'Sa': return 'bg-info';
            case 'Su': return 'bg-danger';
            default: return 'bg-muted';
        }
    }

	function getWorkStatusHTML(status) {
        switch(status) {
        	case 'ONTIME':
        	    return '<span class="badge badge-success fs-7 fw-semibold">On Time</span>';
        	case 'INCOMPLETE':
        	    return '<span class="badge badge-dark fs-7 fw-semibold">Incomplete</span>';
        	case 'UNFINISHED_WORK':
        	    return '<span class="badge badge-warning fs-7 fw-semibold">Unfinished Work</span>';
        	case 'LATE':
        	    return '<span class="badge badge-warning fs-7 fw-semibold">Late</span>';
        	case 'EARLY_OUT':
        	    return '<span class="badge badge-warning fs-7 fw-semibold">Early out</span>';
        	case 'NO_RECORD':
        	    return '<span class="badge badge-danger fs-7 fw-semibold">No Record</span>';
        	default:
        	    return status || '';
        }
    }

	function getLeaveStatusHTML(leaveEvent) {
        var leaveTitle = leaveEvent.title;
        var statusLeave = '';
        var isSick = leaveEvent.extendedProps && leaveEvent.extendedProps.leave_type_id === '3';
        var badgeColor = isSick ? 'badge badge-info' : 'badge badge-primary';

        statusLeave = '<span class="' + badgeColor + ' fs-7 fw-bold" style="cursor: pointer;" onclick="leaveStatus('+ leaveEvent.id +')">' + leaveTitle ;

		if (leaveEvent.extendedProps && leaveEvent.extendedProps.status === '0') {
        	statusLeave += ' <i class="ki-duotone ki-watch fs-2 text-warning align-middle">' +
            '<i class="path1"></i>' + '<i class="path2"></i>' + '</i>';
        }
        statusLeave += '</span>';

        // ไม่แสดงไฟล์แนบใน Check List
        // Check File Leave
        // if (leaveEvent.extendedProps && leaveEvent.extendedProps.leave_file) {
        //     var fileUrl = "${pageContext.request.contextPath}" + leaveEvent.extendedProps.leave_file;
        //     statusLeave += "&nbsp;<a href='" + fileUrl + "' target='_blank' class='text-primary'>" +
        //     			"<i class='ki-duotone ki-document fs-2 text-primary align-middle'>" +
        //         		"<i class='path1'></i><i class='path2'></i>" +
        //     			"</i> " + "</a>";
        // }
        return statusLeave;
    }

	function filterWeek(weekIndex) {
		$('#weekButtonsRow button').removeClass('btn-danger').addClass('bg-transparent border-0 text-gray-700');
		$('#weekButtonsRow button[data-week="' + weekIndex + '"]').removeClass('bg-transparent border-0 text-gray-700').addClass('btn-danger');
		$('#calendarTableBody .calendar-day-card').hide();
		$('#calendarTableBody .calendar-day-card[data-week="' + weekIndex + '"]').show();
	}

	function renderWeekButtons(weekCount) {
		var $row = $('#weekButtonsRow');
		$row.empty();

		var currentDate = calendar.getDate();
		var start = moment(currentDate).startOf('month');
		var weekStart = moment(start).startOf('isoWeek');
		var today = moment();
		var defaultWeek = 0;
		if (today.isSame(currentDate, 'month')) {
			defaultWeek = Math.floor(today.diff(weekStart, 'days') / 7);
			if (defaultWeek < 0) defaultWeek = 0;
			if (defaultWeek > weekCount - 1) defaultWeek = weekCount - 1;
		}

		for (var w = 0; w < weekCount; w++) {
			var btnClass = (w === defaultWeek) ? 'btn-danger' : 'bg-transparent border-0 text-gray-700';
			$row.append(
				$('<button type="button" class="btn btn-sm ' + btnClass + ' d-flex flex-column align-items-center lh-1 gap-2" style="border-radius:600px; flex:1 1 0; max-width:45px; min-width:0; height:62px; justify-content:center;" data-week="' + w + '"><span class="fs-9 fw-semibold week-label">Week</span><span class="fs-6 fw-bold">' + (w + 1) + '</span></button>')
			);
		}

		filterWeek(defaultWeek);
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
                showNonCurrentDates: false,
                fixedWeekCount: false,

				nowIndicator: true,
                editable: false,
                dayMaxEvents: true,
                navLinks: true,

                eventContent: function(arg) {
                    return { html: arg.event.title };
                },

				datesSet: function(info) {
                	$('#calendarMonthYear').text(moment(info.view.currentStart).format('MMMM YYYY'));
                	$('#calendarTitle').text('Today ' + moment().format('D MMM YYYY'));
                    renderWeekButtons(populateCheckList());
                    calculateSummary();
                },

				eventClick: function(info) {
                    var event = info.event;
                    if (event.extendedProps && event.extendedProps.leave_type_id >= 1 && event.extendedProps.leave_type_id <= 9) {
                        <perm:permission object="leave.approve">
                            window.open("line_NewLeaveEdit?id=" + event.id + "&la=1", "_blank");
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

			$('#calendarPrevBtn').off('click').on('click', function(e) { e.preventDefault(); calendar.prev(); });
			$('#calendarNextBtn').off('click').on('click', function(e) { e.preventDefault(); calendar.next(); });
			$('#calendarTitle').off('click').on('click', function() {
				calendar.today();
				filterWeek(Math.floor(moment().diff(moment().startOf('month').startOf('isoWeek'), 'days') / 7));
			});
			$('#weekButtonsRow').off('click', 'button').on('click', 'button', function() { filterWeek($(this).data('week')); });

			// Initialize tooltips after calendar renders
            setTimeout(function() {
                var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                tooltipTriggerList.forEach(function (tooltipTriggerEl) {
                    new bootstrap.Tooltip(tooltipTriggerEl);
                });
            }, 500);
		}
	}
}();
// ----------- END Calendar -----------------

// ----------------- END Calendar & Checklist ------------------------

<%-- ===== OLD: leaveStatus() ของ desktop (disabled, kept for reference) =====
// --------------------- Leave Modal ------------------------
function leaveStatus(id) {
	$("#leavemodal").modal("show");

	$.ajax({
		url : "new_modalLeaveStatus",
		method : "POST",
 		data : "leaveId="+ id,
 		success : function(data) {
 			var obj = JSON.parse(data);
			$('#leaveid').html(obj.leave_id);
			$('#employeeId').html(obj.employeeId);
			//$('#userid').html(obj.name);
			$('#username').html(obj.name);
			$('#ucEmpId').html(obj.ucEmpId);
			$('#ucName').html(obj.ucName);
			$('#stime').html(obj.start_time);
			$('#etime').html(obj.end_time);
			$('#desc').text(obj.description);

			if(obj.leave_file_id == null || obj.leave_file_id == ""){
				$('#file').html("No file");
			} else {
				$('#file').html(obj.leave_file_name + obj.leave_file_type);
				$('#file').attr('href', 'line_preview_File?id=' + obj.leave_file_id);
				$('#file').attr('target', '_blank');
			}

			$('#btn_edit_leave').attr({ href: 'line_NewLeaveEdit?id=' + obj.leave_id + '&la=1', target: '_blank' });

			// Set leave type
			var leaveTypeMap = {
				1: "ลาพักร้อน",
				2: "ลากิจ",
				3: "ลาป่วย",
				4: "ขาดงาน",
				5: "ลาโดยไม่รับค่าจ้าง",
				6: "ลาพักร้อนที่เหลือจากปีก่อน",
				7: "ลาอื่นๆ",
				9: "อื่นๆ"
			};
			$('#leavetype').html(leaveTypeMap[obj.leave_type_id] || "");

			var startdate = (obj.start_date).split(",");
			var sdate = moment(startdate[0]).format("D MMM YYYY");
			$('#sdate').html(sdate);

			var enddate = (obj.end_date).split(",");
			var edate = moment(enddate[0]).format("D MMM YYYY");
			$('#edate').html(edate);

			$('#noday').html(obj.no_day + " Day");

			//var timecreate = (obj.time_create).split(",");
			//var tcreate = moment(timecreate[0]).format("D MMM YYYY");
			$('#timecreate').html(obj.time_create.replace(",", " "));

			$('#approveDetail').addClass('d-none');
			$('#approveText').html("");

			// Set status with new theme classes
			switch(obj.leave_status_id) {
				case '0':
					$('#leavestatus').html("Wait for Approving").removeClass().addClass("badge badge-light-warning");
					break;
				case '1':
					$('#leavestatus').html("Approved").removeClass().addClass("badge badge-light-success");
					/* $('#approveUser').html(obj.appr_user_id); */
					$('#aprEmpId').html(obj.aprEmpId + " ");
					$('#aprName').html(obj.aprName + " - ");
					$('#aprRole').html(obj.aprRole);
					$('#timeUpdate').html(obj.time_update);
					//$('#detail').html(obj.dddd);
			        $('#approveDetail').removeClass('d-none');
					break;
				case '2':
					$('#leavestatus').html("Reject").removeClass().addClass("badge badge-light-danger");
					$('#approveUser').html(obj.appr_user_id);
					$('#timeUpdate').html(obj.time_update);
					//$('#detail').html(obj.dddd);
			        $('#approveDetail').removeClass('d-none');
					break;
				case '3':
					$('#leavestatus').html("Cancel").removeClass().addClass("badge badge-light-secondary");
					break;
			}
 		}
	});
}
// --------------------- END of Leave Modal -----------------------
--%>

</script>
<script>
// --------------------- Initialize when document is ready ------------------------
jQuery(document).ready(function() {
	AppCalendar.init();
});
</script>
