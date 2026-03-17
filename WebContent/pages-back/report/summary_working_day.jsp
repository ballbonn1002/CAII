<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>

<style>
    .pdf-icon {
    	display: inline-block;
    	width: 24px;
    	height: 24px;
    	background-image:url('https://cdn-icons-png.flaticon.com/512/4208/4208479.png');
    	background-size: cover;
    	background-repeat: no-repeat;
    }
    
    .select2-results__group {
    	font-size: 10px !important;
    	color: #A1A5B7 !important;
    	text-transform: uppercase !important;
    	font-weight: 500 !important;
    	padding-top: 10px !important;
    	padding-bottom: 5px !important;
    }
    
    .text-orange {
    	color: #FD7E14 !important;
    }
    
    .position-relative .select2-container .select2-selection--single .select2-selection__rendered {
        padding-left: 10px !important;
    }
    
    #summaryTable th:not(:first-child), 
    #summaryTable td:not(:first-child) {
        min-width: 80px; 
        max-width: 150px;
    }
</style>

<perm:permission object="report.view">
    <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
        <div class="d-flex flex-column flex-column-fluid">

            <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
                <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                    <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                        <h1 class="page-heading d-flex text-gray-700 fw-bold fs-3 flex-column justify-content-center my-0">Summary Working Day</h1>
                        <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                            <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard"
                                class="text-muted text-hover-primary">Home</a></li>
                            <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                            <li class="breadcrumb-item text-muted fw-medium fs-7">Report</li>
                        </ul>
                    </div>

                    <div class="d-flex align-items-center gap-2 gap-lg-3">
                        <a href="#" id="exportPdfBtn" class="btn btn-secondary"> <i class="pdf-icon me-2 fs-6"></i> 
                            <span class="fw-medium fs-6 text-secondary-inverse">Print PDF</span>
                        </a>
                    </div>

                </div>
            </div>

            <div id="kt_app_content_container" class="app-container container-fluid">

                <form action="#" method="post" id="filterForm">
                    <div class="card card-flush shadow-sm mb-5">
                        <div class="card-body py-5">
                            
                            <div class="row mb-5">
                                <div class="col-12">
                                    <div class="input-group flex-nowrap border rounded h-45px overflow-hidden">
                                        <span class="input-group-text bg-transparent border-0 pe-1"> 
                                            <i class="ki-duotone ki-magnifier fs-3"><span class="path1"></span><span class="path2"></span></i>
                                        </span>
                                        <div class="flex-grow-1">
                                            <select name="searchText" id="userSelect" class="form-select border-0 h-45px"  data-control="select2">
                                                <c:forEach var="u" items="${userList}">
                                                    <c:set var="label" value="" />
                                                    <c:if test="${not empty u.employee_id}">
                                                        <c:set var="label" value="${u.employee_id}" />
                                                    </c:if>
                                                    <c:if test="${not empty u.name_en}">
                                                        <c:if test="${not empty label}"><c:set var="label" value="${label} - " /></c:if>
                                                        <c:set var="label" value="${label}${u.name_en}" />
                                                    </c:if>
                                                    <c:if test="${not empty u.name}">
                                                        <c:if test="${not empty label}"><c:set var="label" value="${label} - " /></c:if>
                                                        <c:set var="label" value="${label}${u.name}" />
                                                    </c:if>
                                                    <c:if test="${not empty u.role_id}">
                                                        <c:if test="${not empty label}"><c:set var="label" value="${label} - " /></c:if>
                                                        <c:set var="label" value="${label}${u.role_id}" />
                                                    </c:if>
                                                    <option value="${u.id}" data-name-en="${u.name_en}" data-name-th="${u.name}" ${u.id eq defaultUserId ? 'selected' : ''}>${label}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                
                            <div class="row g-5">
                                <div class="col-md-3">
                                    <label class="form-label fs-7 fw-semibold text-gray-800 mb-1">Year</label>
                                    <div class="w-100 position-relative">
                                        <i class="ki-duotone ki-calendar-8 fs-3 position-absolute top-50 translate-middle-y ms-4" style="z-index: 10; pointer-events: none;">
                                            <span class="path1"></span><span class="path2"></span><span class="path3"></span>
                                            <span class="path4"></span><span class="path5"></span><span class="path6"></span>
                                        </i>
                                        <select id="yearPicker" name="year" class="form-select ps-12 h-45px" data-control="select2" data-hide-search="true"></select>
                                    </div>
                                </div>
                                
                                <div class="col-md-9">
                                    <label class="form-label fs-7 fw-semibold text-gray-800 mb-1">Month</label>
                                    <div class="dropdown w-100">
                                        <button class="form-select text-start h-45px d-flex align-items-center justify-content-between text-gray-700" type="button" id="monthDropdownBtn" data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside">
                                            <span id="monthDropdownBtnText"></span>
                                        </button>
                                        <ul class="dropdown-menu shadow-sm border-gray-200 pt-2 pb-0 px-0" aria-labelledby="monthDropdownBtn" id="monthCheckboxList" style="max-height: 300px; overflow-y: auto; width: 410px;">
                                            </ul>
                                    </div>
                                </div>
                            </div>
                
                        </div>
                    </div>
                </form>

                <%-- Summary Working Day card --%>
                <div class="card card-flush h-auto mb-5">
                    <div class="card-header pt-2 mb-2">
                        <span class="text-gray-800 fw-medium pt-5">Summary Working Day</span>
                    </div>

                    <div class="card-body pt-0">
                        <!-- Summery -->
                        <div class="row align-items-center mt-0 mx-5 fs-6 fw-bold">
                            <div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
                                <span class="fw-bold fs-2 me-5 text-black" id="summaryWorkingDay">${summaryWorkingDay}</span> <span
                                    class="bullet bullet-vertical mx-2 h-15px w-2px me-4" style="background-color: var(--bs-black);"></span> <span
                                    class="text-black fs-6">Working Day</span>
                            </div>
                            <div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
                                <span class="fw-bold fs-2 me-5 text-success" id="summaryOnTime">${summaryOnTime}</span> <span
                                    class="ki-solid ki-check-circle text-success fs-1 me-2"></span> <span class="text-gray-600 fs-6">On Time</span>
                            </div>
                            <div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
                                <span class="fw-bold fs-2 me-5 text-primary" id="summaryLeave">${summaryLeave}</span> <i
                                    class="ki-solid ki-car-2 text-primary fs-1 me-4"></i> <span class="text-gray-600 fs-6">Leave</span>
                            </div>
                            <div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
                                <span class="fw-bold fs-2 me-5 text-info" id="summarySickLeave">${summarySickLeave}</span> <i
                                    class="ki-solid ki-syringe text-info fs-1 me-4"></i> <span class="text-gray-600 fs-6">Sick Leave</span>
                            </div>
                            <div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
                                <span class="fw-bold fs-2 me-5 text-muted" id="summaryHoliday">${summaryHoliday}</span> <i
                                    class="ki-solid ki-calendar-8 text-muted fs-1 me-4"></i> <span class="text-gray-600 fs-6">Holiday</span>
                            </div>
                            <div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
                                <span class="fs-bold fs-2 me-5 text-warning" id="summaryLateEarly">${summaryLateEarly}</span> <i
                                    class="ki-solid ki-information-5 text-warning fs-1 me-4"></i> <span class="text-gray-600 fs-6">Late / Early Out /<br>Unfinished Work
                                </span>
                            </div>
                            <div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
                                <span class="fs-bold fs-2 me-5 text-orange" id="summaryIncomplete">${summaryIncomplete}</span> <i
                                    class="ki-solid ki-abstract-12 text-orange fs-1 me-4"></i> <span class="text-gray-600 fs-6">Incomplete</span>
                            </div>
                            <div class="col-lg-3 col-md-4 mb-10 d-flex align-items-center">
                                <span class="fs-bold fs-2 me-5 text-danger" id="summaryNoRecord">${summaryNoRecord}</span> <i
                                    class="ki-solid ki-abstract-11 text-danger fs-1 me-4"></i> <span class="text-gray-600 fs-6">No Record</span>
                            </div>
                        </div>
                        <!-- Percen Bar -->
                        <div class="progress h-30px rounded-pill w-100">
                            <div id="barOntime" class="progress-bar bg-success" role="progressbar" style="width: ${ontimePercentage}%"></div>
                            <div id="barLeave" class="progress-bar bg-primary" role="progressbar" style="width: ${leavePercentage}%"></div>
                            <div id="barSickLeave" class="progress-bar bg-info" role="progressbar" style="width: ${sickLeavePercentage}%"></div>
                            <div id="barLateEarly" class="progress-bar bg-warning" role="progressbar" style="width: ${lateEarlyOutPercentage}%"></div>
                            <div id="barIncomplete" class="progress-bar bg-orange" role="progressbar" style="width: ${incompletePercentage}%"></div>
                            <div id="barNoRecord" class="progress-bar bg-danger" role="progressbar" style="width: ${noRecordPercentage}%"></div>
                        </div>
                    </div>
                </div>

                <!-- Summary Table -->
                <div class="card card-flush h-auto mb-5 mb-xl-10 shadow-sm">
                    <div class="card-header py-5">
                        <h3 class="card-title align-items-start flex-column">
                            <span class="card-label fw-bold text-gray-900 fs-3">Summary</span>
                        </h3>
                        <div class="d-flex flex-wrap align-items-center gap-2">
                            <span class="badge badge-white text-success border border-gray-200 fs-7 py-4 px-5"><i class="ki-solid ki-check-circle text-success fs-3 me-2"></i> On-Site</span>
                            <span class="badge badge-light-success fs-7 py-4 px-5"><i class="ki-solid ki-check-circle text-success fs-3 me-2"></i> WFH</span>
                        </div>
                        
                    </div>

                    <div class="card-body pt-2">
                        <div class="table-responsive">
                            <table id="summaryTable" class="table table-bordered table-row-dashed align-middle gs-0 gy-3 text-center border-gray-200 w-100">
                                <thead>
                                    <tr class="fw-bold fs-7 text-gray-300">
                                        <th class="min-w-30px text-gray-500" style="width: 6%; white-space: nowrap;">#</th>
                                        <th class="min-w-40px text-gray-500">Jan</th>
                                        <th class="min-w-40px text-gray-500">Feb</th>
                                        <th class="min-w-40px text-gray-500">Mar</th>
                                        <th class="min-w-40px text-gray-500">Apr</th>
                                        <th class="min-w-40px text-gray-500">May</th>
                                        <th class="min-w-40px text-gray-500">Jun</th>
                                        <th class="min-w-40px text-gray-500">Jul</th>
                                        <th class="min-w-40px text-gray-500">Aug</th>
                                        <th class="min-w-40px text-gray-500">Sep</th>
                                        <th class="min-w-40px text-gray-500">Oct</th>
                                        <th class="min-w-40px text-gray-500">Nov</th>
                                        <th class="min-w-40px text-gray-500">Dec</th>
                                    </tr>
                                </thead>

                                <tbody class="fs-6 fw-semibold text-gray-400">
                                    <c:forEach var="day" begin="1" end="31">
                                        <tr>
                                            <td class="fw-bold text-gray-800 border-end">${day}</td>

                                            <c:forEach var="month" begin="1" end="12">
                                                <td class="att-cell" data-month="${month}" data-day="${day}"></td>
                                            </c:forEach>

                                        </tr>
                                    </c:forEach>
                                </tbody>
                                
                                <tfoot>
                                    <tr class="fw-bold fs-7 text-gray-300">
                                        <th class="min-w-30px text-gray-500" style="width: 6%; white-space: nowrap;">#</th>
                                        <th class="min-w-40px text-gray-500">Jan</th>
                                        <th class="min-w-40px text-gray-500">Feb</th>
                                        <th class="min-w-40px text-gray-500">Mar</th>
                                        <th class="min-w-40px text-gray-500">Apr</th>
                                        <th class="min-w-40px text-gray-500">May</th>
                                        <th class="min-w-40px text-gray-500">Jun</th>
                                        <th class="min-w-40px text-gray-500">Jul</th>
                                        <th class="min-w-40px text-gray-500">Aug</th>
                                        <th class="min-w-40px text-gray-500">Sep</th>
                                        <th class="min-w-40px text-gray-500">Oct</th>
                                        <th class="min-w-40px text-gray-500">Nov</th>
                                        <th class="min-w-40px text-gray-500">Dec</th>
                                    </tr>
                                </tfoot>
                                
                            </table>
                        </div>
                        
                        <div id="emptyStateMessage" class="d-none flex-column flex-center text-center py-15">
                            <i class="ki-duotone ki-calendar-remove fs-5x text-gray-400 mb-5">
                                <span class="path1"></span><span class="path2"></span>
                                <span class="path3"></span><span class="path4"></span>
                                <span class="path5"></span><span class="path6"></span>
                            </i>
                            <div class="fs-3 fw-bold text-gray-600 mb-2">Please select a month</div>
                            <div class="fs-6 fw-semibold text-gray-400">Select one or more months from the filter to view the summary.</div>
                        </div>
                        
                    </div>
                </div>

            </div>
        </div>
    </div>
</perm:permission>

<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>

<script>
(function () {
	  const $user = $("#userSelect");
	  const $year = $("#yearPicker");
	  const $month = $("#monthSelect");

	  const monthLabels = ["All", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

	  function pad2(n) { return String(n).padStart(2, "0"); }

	  function isLeapYear(y) {
	    y = Number(y);
	    return (y % 4 === 0 && y % 100 !== 0) || (y % 400 === 0);
	  }

	  function daysInMonth(y, m) {
	    if (m === 2) return isLeapYear(y) ? 29 : 28;
	    if ([4, 6, 9, 11].includes(m)) return 30;
	    return 31;
	  }

	  function isWeekend(y, m, d) {
	    const dt = new Date(Number(y), Number(m) - 1, Number(d));
	    const day = dt.getDay(); // 0 Sun, 6 Sat
	    return day === 0 || day === 6;
	  }

	  const monthShortLabels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

	  function initMonthDropdown() {
		    const $dropdownList = $('#monthCheckboxList');
		    $dropdownList.empty();
		    
		    // Checkbox
		    for (let i = 0; i < 12; i++) {
		        const monthValue = i + 1;
		        const html = '<li class="px-4 py-2">' +
		            '<div class="form-check form-check-custom form-check-solid">' +
		            '<input class="form-check-input month-checkbox" type="checkbox" value="' + monthValue + '" id="month_' + monthValue + '" checked>' +
		            '<label class="form-check-label text-gray-800 w-100 cursor-pointer ms-2" for="month_' + monthValue + '">' +
		            monthLabels[i + 1] +
		            '</label>' +
		            '</div>' +
		            '</li>';
		        $dropdownList.append(html);
		    }

		    // btn Select All & Deselect All 
		    const buttonsHtml = '<li class="p-2 border-top text-center bg-white" style="position: sticky; bottom: 0; z-index: 10;">' + 
		        '<button type="button" class="btn btn-sm btn-light fs-6 me-2 deselect-all-btn">Deselect All</button>' +
		        '<button type="button" class="btn btn-sm btn-primary fs-6 select-all-btn">Select All</button>' +
		        '</li>';
		    $dropdownList.append(buttonsHtml);

		    // Event  Select All
		    $('.select-all-btn').on('click', function(e) {
		        e.stopPropagation();
		        $('.month-checkbox').prop('checked', true); 
		        updateMonthButtonText();
		        fetchAndRender();
		    });

		    // Event  Deselect All
		    $('.deselect-all-btn').on('click', function(e) {
		        e.stopPropagation();
		        $('.month-checkbox').prop('checked', false); 
		        updateMonthButtonText();
		        fetchAndRender();
		    });

		    // Event Checkbox
		    $('.month-checkbox').on('change', function() {
		        updateMonthButtonText();
		        fetchAndRender();
		    });

		    updateMonthButtonText();
		}

	  function updateMonthButtonText() {
		    const checkedBoxes = $('.month-checkbox:checked');
		    let text = "Select Month";

		    if (checkedBoxes.length > 0) {
		        const selectedShortNames = [];
		        checkedBoxes.each(function() {
		            const val = parseInt($(this).val());
		            selectedShortNames.push(monthShortLabels[val - 1]);
		        });
		        text = selectedShortNames.join(', '); 
		    }

		    $('#monthDropdownBtnText').text(text);
		}

	  function setSummaryNumbers(s) {
	    $("#summaryWorkingDay").text(s.workingDay ?? 0);
	    $("#summaryOnTime").text(s.ontime ?? 0);
	    $("#summaryLeave").text(s.leave ?? 0);
	    $("#summarySickLeave").text(s.sickLeave ?? 0);
	    $("#summaryHoliday").text(s.holiday ?? 0);
	    $("#summaryLateEarly").text(s.lateEarlyOut ?? 0);
	    $("#summaryIncomplete").text(s.incomplete ?? 0);
	    $("#summaryNoRecord").text(s.noRecord ?? 0);

	    $("#barOntime").css("width", (s.percent?.ontime ?? 0) + "%");
	    $("#barLeave").css("width", (s.percent?.leave ?? 0) + "%");
	    $("#barSickLeave").css("width", (s.percent?.sickLeave ?? 0) + "%");
	    $("#barLateEarly").css("width", (s.percent?.lateEarlyOut ?? 0) + "%");
	    $("#barIncomplete").css("width", (s.percent?.incomplete ?? 0) + "%");
	    $("#barNoRecord").css("width", (s.percent?.noRecord ?? 0) + "%");
	  }

	  // Icon Map
	  function iconHtml(status, detail) {
	      var titleText = "";
	      
	      if (status === "Ontime") titleText = "Ontime";
	      else if (status === "Leave") titleText = "Leave";
	      else if (status === "Sick") titleText = "Sick Leave";
	      else if (status === "Late" || status === "EarlyOut" || status === "Unfinished Work") titleText = "Late/Early/Unfinished";
	      else if (status === "Incomplete") titleText = "Incomplete";
	      else if (status === "NoRecord") titleText = "No Record";
	      else if (status === "Holiday") titleText = "Holiday";

	      var iconClass = "";
	      switch (status) {
	          case "Ontime": iconClass = "ki-solid ki-check-circle text-success fs-2"; break;
	          case "Leave": iconClass = "ki-solid ki-car-2 text-primary fs-2"; break;
	          case "Sick": iconClass = "ki-solid ki-syringe text-info fs-2"; break;
	          case "Late": iconClass = "ki-solid ki-information-5 text-warning fs-2"; break;
	          case "EarlyOut": iconClass = "ki-solid ki-information-5 text-warning fs-2"; break;
	          case "Unfinished Work": iconClass = "ki-solid ki-information-5 text-warning fs-2"; break;
	          case "Incomplete": iconClass = "ki-solid ki-abstract-12 text-orange fs-2"; break;
	          case "NoRecord":  iconClass = "ki-solid ki-abstract-11 text-danger fs-2"; break;
	          case "Holiday": iconClass = "ki-solid ki-calendar-8 text-muted fs-2"; break;
	          default: return "";
	      }
		  // Popover
	      if (detail) {
	          var safeDetail = detail.replace(/"/g, '&quot;'); 
	          var popoverAttrs = 'data-bs-toggle="popover" data-bs-trigger="hover" data-bs-placement="top" ' +
	                             'title="' + titleText + '" data-bs-content="' + safeDetail + '"';
	          
	          return '<span class="d-inline-block" style="cursor: pointer;" ' + popoverAttrs + '><i class="' + iconClass + '"></i></span>';
	      } else {
	          return '<span class="d-inline-block" style="cursor: pointer;" title="' + titleText + '"><i class="' + iconClass + '"></i></span>';
	      }
	  }

	  // PaintCells + Popover
	  function paintCells(year, selectedMonthsArray, attendanceMap, detailsMap, workTypeMap) {
	      var y = Number(year);

	      try {
	          if (typeof $ !== 'undefined' && $.fn.popover) {
	              $('#summaryTable [data-bs-toggle="popover"]').popover('dispose');
	              $('.popover').remove();
	          }
	      } catch(e) {}

	      document.querySelectorAll('#summaryTable td[data-month][data-day]').forEach(function(td) {
	          var m = parseInt(td.getAttribute("data-month"), 10);
	          var d = parseInt(td.getAttribute("data-day"), 10);
	          
	          var valid = d <= daysInMonth(y, m);
	          var weekend = valid && isWeekend(y, m, d);

	          td.className = "att-cell";
	          td.innerHTML = "";
	          td.removeAttribute("style");

	          if (!valid) {
	              td.classList.add("bg-gray-300");
	              return;
	          }
	          if (weekend) {
	              td.classList.add("bg-gray-100");
	          }
	          if (selectedMonthsArray.length > 0 && selectedMonthsArray.length < 12 && !selectedMonthsArray.includes(m)) {
	              return;
	          }
	          
	          var key = m + "_" + d;
	          var statusRaw = attendanceMap[key];
	          var status = String(statusRaw || "").trim();
	          var detail = detailsMap ? detailsMap[key] : "";
	          var workType = workTypeMap ? workTypeMap[key] : "";

	          if (weekend && (status === "NoRecord" || status === "")) {
	              td.innerHTML = "";
	              return;
	          }

	          td.innerHTML = iconHtml(status, detail);
	          
	          if (workType === "2" && status !== "Incomplete") {
	              td.classList.add("bg-light-success"); // WFH
	          } 
  
	      });

	      // Initialize Popover
	      setTimeout(function() {
	          try {
	              if (typeof $ !== 'undefined' && $.fn.popover) {
	                  $('#summaryTable [data-bs-toggle="popover"]').popover({
	                      container: 'body',
	                      html: true,
	                      trigger: 'hover'
	                  });
	              } else if (typeof bootstrap !== 'undefined' && bootstrap.Popover) {
	                  var popoverTriggerList = [].slice.call(document.querySelectorAll('#summaryTable [data-bs-toggle="popover"]'));
	                  popoverTriggerList.map(function (popoverTriggerEl) {
	                      return new bootstrap.Popover(popoverTriggerEl, {
	                          container: 'body',
	                          html: true,
	                          trigger: 'hover'
	                      });
	                  });
	              }
	          } catch (err) {
	              console.error("Popover Init Error: ", err);
	          }
	      }, 250);
	  }

	  function fetchAndRender() {
		    const userId = $user.val()
		    const year = String($year.val()).trim();
		    const selectedMonths = [];
		    $('.month-checkbox:checked').each(function() {
		        selectedMonths.push(parseInt($(this).val()));
		    });

		    const $tableContainer = $('#summaryTable').closest('.table-responsive');
		    const $emptyState = $('#emptyStateMessage');

		    if (selectedMonths.length === 0) {
		        $tableContainer.addClass('d-none');
		        $emptyState.removeClass('d-none').addClass('d-flex');
		        setSummaryNumbers({}); 
		        return; 
		    } else {
		        $tableContainer.removeClass('d-none');
		        $emptyState.addClass('d-none').removeClass('d-flex');
		    }
		    
		    const $table = $('#summaryTable');

		    if (selectedMonths.length > 0 && selectedMonths.length <= 1) {
		        $table.removeClass('w-100').addClass('w-auto');
		    } else {
		        $table.removeClass('w-auto').addClass('w-100');
		    }

		    let monthParam = selectedMonths.join(',');
		    if (selectedMonths.length === 12) {
		        monthParam = "0";
		    }

		    $.ajax({
		        url: "${pageContext.request.contextPath}/summaryWorkingDayData",
		        method: "POST",
		        dataType: "json",
		        data: { userId: userId, year: year, month: monthParam }, 
		        success: function (res) {
		            setSummaryNumbers(res.summary || {});
		            
		            paintCells(Number(year), selectedMonths, res.attendanceMap || {}, res.detailsMap || {}, res.workTypeMap || {});
		            
		            for (let m = 1; m <= 12; m++) {
		                const nth = m + 1;
		                const $col = $('#summaryTable thead th:nth-child(' + nth + '), #summaryTable tbody td:nth-child(' + nth + '), #summaryTable tfoot th:nth-child(' + nth + ')');

		                if (selectedMonths.includes(m)) {
		                    $col.show();
		                } else {
		                    $col.hide();
		                }
		            }
		        },
		        error: function (xhr) {
		            console.error("load error", xhr.status, xhr.responseText);
		        }
		    });
		}

	  function init() {
		  initMonthDropdown();
	    
	    // init select2
	    if ($user.attr("data-control") === "select2") { $user.select2(); }
		if ($month.attr("data-control") === "select2") { $month.select2({ minimumResultsForSearch: Infinity }); }
		
		// Dropdown year
	    const $yearSelect = $("#yearPicker");
        const currentYear = new Date().getFullYear();
        const serverYear = parseInt("${selectedYear}") || currentYear; 
        const startYear = 2010; 
        
        $yearSelect.empty();
        
        for (let i = currentYear; i >= startYear; i--) {
            let selected = (i === serverYear) ? "selected" : "";
            $yearSelect.append('<option value="' + i + '" ' + selected + '>' + i + '</option>');
        }
        
        if ($yearSelect.attr("data-control") === "select2") {
             $yearSelect.select2({ minimumResultsForSearch: Infinity });
        }

	    $user.on("change", fetchAndRender);
	    $yearSelect.on("change", fetchAndRender);
	    
	 // Download PDF
	    $("#exportPdfBtn").on("click", function(e) {
	        e.preventDefault();

            const year = $("#yearPicker").val();
            const yVal = parseInt(year, 10);
            let dateRangeStr = "";

            const selectedMonthsPdf = [];
            $('.month-checkbox:checked').each(function() {
                selectedMonthsPdf.push(parseInt($(this).val()));
            });

            if (selectedMonthsPdf.length === 12) {
                dateRangeStr = "01-Jan-" + yVal + " to 31-Dec-" + yVal;
            } else if (selectedMonthsPdf.length > 0) {
                let segments = [];
                let start = selectedMonthsPdf[0];
                let prev = start;

                for (let i = 1; i < selectedMonthsPdf.length; i++) {
                    if (selectedMonthsPdf[i] === prev + 1) {
                        prev = selectedMonthsPdf[i];
                    } else {
                        segments.push({ start: start, end: prev });
                        start = selectedMonthsPdf[i];
                        prev = start;
                    }
                }
                segments.push({ start: start, end: prev });

                if (segments.length === 1) {
                    const sMonth = segments[0].start;
                    const eMonth = segments[0].end;
                    const lastDay = new Date(yVal, eMonth, 0).getDate(); 
                    dateRangeStr = "01-" + monthShortLabels[sMonth - 1] + "-" + yVal + " to " + lastDay + "-" + monthShortLabels[eMonth - 1] + "-" + yVal;
                } else {
                    const parts = segments.map(seg => {
                        if (seg.start === seg.end) {
                            return monthShortLabels[seg.start - 1]; 
                        } else {
                            return monthShortLabels[seg.start - 1] + "-" + monthShortLabels[seg.end - 1];
                        }
                    });
                    dateRangeStr = parts.join(', ') + " " + yVal;
                }
            }

	        // Data
	        const element = document.getElementById("kt_app_content_container");
	        
	        let nameEn = $("#userSelect option:selected").attr("data-name-en") || "";
	        let nameTh = $("#userSelect option:selected").attr("data-name-th") || "";
	        const userName = nameEn.replace(/_/g, ' ').trim() + "  -  " + nameTh.replace(/_/g, ' ').trim();
	        const fileName = "Summary_Working_Day " + nameTh.replace(/\s+/g, ' ') + "_" + year + ".pdf";

	        const $btn = $(this);
	        const originalHtml = $btn.html();
	        $btn.html('<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span> Downloading...');
	        $btn.prop('disabled', true);

	        const logoImg = new Image();
	        logoImg.src = "${pageContext.request.contextPath}/images/logo_cubesofttech.png"; 

	        const generatePDF = function(loadedLogo) {
	            
	            // Off-Screen Clone
	            const cloneContainer = document.createElement('div');
	            cloneContainer.style.position = 'absolute';
	            cloneContainer.style.top = '0';
	            cloneContainer.style.left = '-9999px';
	            cloneContainer.style.width = '1400px';
	            const clone = element.cloneNode(true);
	            clone.id = "pdf_clone_container";
                
	            // Hide filterForm inside clone
	            const filterForm = clone.querySelector('#filterForm');
	            if (filterForm) filterForm.style.display = 'none';

	            // Overflow unlock
	            const tableResponsive = clone.querySelector('.table-responsive');
	            if (tableResponsive) {
	                tableResponsive.style.overflow = 'visible';
	                tableResponsive.style.height = 'auto';
	            }
				
	            // Formath card Summery working day
	            const cloneStyle = document.createElement('style');
	            cloneStyle.innerHTML = `
	                #pdf_clone_container .card-body > .row.align-items-center {
	                    flex-wrap: wrap !important;
	                    margin: 0 !important;
	                }
	                #pdf_clone_container .card-body > .row.align-items-center > div[class*="col-"] {
	                    flex: 0 0 25% !important;
	                    max-width: 25% !important;
	                    width: 25% !important;
	                    padding: 0 5px !important;
	                    box-sizing: border-box !important;
	                    display: flex !important;
	                    flex-wrap: nowrap !important;
	                    align-items: center !important;
	                }
	                /* number */
	                #pdf_clone_container .card-body > .row.align-items-center > div[class*="col-"] > span:first-child {
	                    white-space: nowrap !important;
	                    flex-shrink: 0 !important;
	                    min-width: 45px !important;
	                    text-align: right !important;
	                    margin-right: 12px !important;
	                }
	                /* icon */
	                #pdf_clone_container .card-body > .row.align-items-center > div[class*="col-"] > i,
	                #pdf_clone_container .card-body > .row.align-items-center > div[class*="col-"] > span.bullet {
	                    flex-shrink: 0 !important;
	                    margin-right: 12px !important;
	                }
	                /* string */
	                #pdf_clone_container .card-body > .row.align-items-center > div[class*="col-"] > span:last-child {
	                    white-space: normal !important;
	                    flex-shrink: 1 !important;
	                    line-height: 1.2 !important;
	                    word-break: keep-all !important;
	                }
	            `;
	            clone.prepend(cloneStyle);
	            cloneContainer.appendChild(clone);
	            element.parentNode.appendChild(cloneContainer);
	            
	         // Snapshot clone screen
	            html2canvas(clone, {
	                scale: 2,
	                useCORS: true,
	                backgroundColor: '#ffffff',
	                width: 1400,
	                windowWidth: 1400,
	                logging: false
	            }).then(function(canvas) {
	                const dataUrl = canvas.toDataURL('image/jpeg', 0.85);
                    
	                const { jsPDF } = window.jspdf;
	                const pdf = new jsPDF({ orientation: 'p', unit: 'mm', format: 'a4', compress: true });
	                
	                const pageWidth = pdf.internal.pageSize.getWidth();
	                const pageHeight = pdf.internal.pageSize.getHeight();
	                const cubeRed = { r: 194, g: 32, b: 38 };

	                // Header
	                if (loadedLogo) {
	                    pdf.addImage(loadedLogo, 'PNG', pageWidth - 59, 6, 50, 12);
	                } else {
	                    pdf.setFontSize(14);
	                    pdf.setTextColor(cubeRed.r, cubeRed.g, cubeRed.b);
	                    pdf.setFont(undefined, 'bold');
	                    pdf.text("CubeSoftTech", pageWidth - 10, 15, { align: 'right' });
	                }

	                pdf.setTextColor(60, 60, 60);
	                pdf.setFontSize(16);
	                pdf.setFont(undefined, 'bold');
	                pdf.text("Report Summary Working Day", 10, 14);
					
	                // set thai name
	                const drawThaiText = (text) => {
	                    const canvas = document.createElement('canvas');
	                    const ctx = canvas.getContext('2d');
	                    ctx.font = "normal 40px 'Sarabun', Tahoma, sans-serif"; 
	                    
	                    const textWidth = ctx.measureText(text).width;
	                    canvas.width = textWidth + 10;
	                    canvas.height = 50; 
	                    
	                    ctx.font = "normal 40px 'Sarabun', Tahoma, sans-serif";
	                    ctx.fillStyle = "#3c3c3c";
	                    ctx.textBaseline = "top";
	                    ctx.fillText(text, 0, 5);
	                    return {
	                        url: canvas.toDataURL('image/png'), 
	                        w: canvas.width * 0.075,            
	                        h: canvas.height * 0.075       
	                    };
	                };

	                // set Name user: [en] - [th]
	                const nameImg = drawThaiText(" User :  " + userName);
	                pdf.addImage(nameImg.url, 'PNG', 9, 21, nameImg.w, nameImg.h);
					// set date
	                pdf.setFontSize(10);
	                pdf.setFont(undefined, 'normal');
	                pdf.text("date :   " + dateRangeStr, pageWidth - 10, 25, { align: 'right' });
					
	                pdf.setFillColor(cubeRed.r, cubeRed.g, cubeRed.b);
	                pdf.rect(0, 30, pageWidth, 4, 'F');

                    pdf.setFontSize(10);
                    pdf.setFont(undefined, 'normal');
                    pdf.text("date :   " + dateRangeStr, pageWidth - 10, 25, { align: 'right' });

	                pdf.setFontSize(10);
	                pdf.setFont(undefined, 'normal');
	                pdf.text("date :   " + dateRangeStr, pageWidth - 10, 25, { align: 'right' });
					
	                pdf.setFillColor(cubeRed.r, cubeRed.g, cubeRed.b);
	                pdf.rect(0, 30, pageWidth, 4, 'F'); 

	                // Footer
	                const footerHeight = 10;
	                const footerY = pageHeight - footerHeight;
	                
	                pdf.setFillColor(cubeRed.r, cubeRed.g, cubeRed.b);
	                pdf.rect(0, footerY, pageWidth, footerHeight, 'F');

	                pdf.setTextColor(255, 255, 255);
	                pdf.setFontSize(9);
	                pdf.setFont(undefined, 'normal');

	                const timeNow = new Date();
	                const dateOptions = { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' };
	                const dateStr = timeNow.toLocaleDateString('en-GB', dateOptions);
	                const timeOptions = { hour: '2-digit', minute: '2-digit', hour12: false };
	                const timeStr = timeNow.toLocaleTimeString('en-GB', timeOptions);
	                const createdTimeStr = "Created : " + dateStr + ", " + timeStr;
	                pdf.text(createdTimeStr, 10, footerY + 6.5, { align: 'left' });

	                pdf.text("Cube SoftTech Co., Ltd.", pageWidth - 10, footerY + 6.5, { align: 'right' });;

	                // Data Content
	                const imgProps = pdf.getImageProperties(dataUrl);
	                const sideMargin = 5; 
	                const topMargin = 38;    
	                const bottomMargin = footerHeight + 5;
	                
	                const maxPdfWidth = pageWidth - (sideMargin * 2);
	                const maxPdfHeight = pageHeight - topMargin - bottomMargin;
	                
	                const ratio = Math.min(maxPdfWidth / imgProps.width, maxPdfHeight / imgProps.height);
	                const finalWidth = imgProps.width * ratio;
	                const finalHeight = imgProps.height * ratio;
	                
	                const xOffset = sideMargin + (maxPdfWidth - finalWidth) / 2;
	                const yOffset = topMargin; 
	                
	                pdf.addImage(dataUrl, 'JPEG', xOffset, yOffset, finalWidth, finalHeight);
	                
	                pdf.save(fileName);
	            })
	            .catch(function (error) {
	                console.error("An error occurred while creating the PDF: ", error);
	            })
	            .finally(function() {
	                if (cloneContainer && cloneContainer.parentNode) {
	                    cloneContainer.parentNode.removeChild(cloneContainer);
	                }
	                $btn.html(originalHtml);
	                $btn.prop('disabled', false);
	            });
	        };

	        logoImg.onload = function() { generatePDF(logoImg); };
	        logoImg.onerror = function() { generatePDF(null); }; 
	    });

	    // initial load
	    fetchAndRender();
	  }

	  $(document).ready(init);
	})();	
</script>