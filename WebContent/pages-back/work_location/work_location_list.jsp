<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>

<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<style>
    .select2-results__group {
        font-size: 10px !important;
        color: #A1A5B7 !important;
        text-transform: uppercase !important;
        font-weight: 500 !important;
        padding-top: 10px !important;
        padding-bottom: 5px !important;
    }
    .badge-light-info {
    background-color: #E3D7FB !important;
    color: var(--bs-info) !important;
    }
    .badge-light-success {
    background-color: #D1F4DD !important;
    color: var(--bs-success) !important;
    }
    
    .form-check.form-check-info .form-check-input:checked {
    background-color: var(--bs-info);
    }
</style>

<%-- <perm:permission object="report.view">    --%>
    <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
        <div class="d-flex flex-column flex-column-fluid">
         
            <div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
                <div id="kt_app_toolbar_container" class="app-container container-fluid d-flex flex-stack">
                    <div class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
                        <h1 class="page-heading d-flex text-dark fw-bold fs-3 flex-column justify-content-center my-0">Work Location</h1>
                        <ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                            <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
                            <li class="breadcrumb-item"><span class="bullet bg-gray-500 fw-medium fs-7 w-5px h-2px"></span></li>
                            <li class="breadcrumb-item text-muted fw-medium fs-7">Admin Management</li>
                        </ul>
                    </div>
              
                    
                    
                </div>
            </div>
            
            <div id="kt_app_content_container" class="app-container container-fluid">
                
                <form action="work_location.action" method="post" id="filterForm">
                    <div class="card card-flush shadow-sm mb-5">
                        <div class="card-body py-5">
                            <div class="row g-5">
                            
                                <div class="col-md-12">
                                    <div class="input-group flex-nowrap">
                                        <span class="input-group-text bg-transparent border-end-0 h-45px">
                                            <i class="ki-duotone ki-magnifier fs-3"><span class="path1"></span><span class="path2"></span></i>
                                        </span>
                                        <div class="flex-grow-1">
                                            <select name="searchText"
											        id="userSelect"
											        class="form-select rounded-start-0 border-start-0 h-45px"
											        data-control="select2">
											
    										  <option value="">All</option>
											
											    <optgroup label="Enable">
											        <c:forEach var="u" items="${userList}">
											            <c:if test="${u.enable == 1}">
											                <c:set var="displayText" value="" />
											
											                <c:if test="${not empty u.employee_id}">
											                    <c:set var="displayText" value="${u.employee_id}" />
											                </c:if>
											
											                <c:if test="${not empty u.name_en}">
											                    <c:set var="displayText"
											                           value="${displayText}${not empty displayText ? ' - ' : ''}${u.name_en}" />
											                </c:if>
											
											                <c:if test="${not empty u.name}">
											                    <c:set var="displayText"
											                           value="${displayText}${not empty displayText ? ' - ' : ''}${u.name}" />
											                </c:if>
											
											                <c:if test="${not empty u.role_id}">
											                    <c:set var="displayText"
											                           value="${displayText}${not empty displayText ? ' - ' : ''}${u.role_id}" />
											                </c:if>
											
											                <option value="${fn:trim(u.id)}"
											                    ${criteria.searchText eq u.id ? 'selected' : ''}>
											                    ${displayText}
											                </option>
											
											            </c:if>
											        </c:forEach>
											    </optgroup>
											
											    <optgroup label="Disable">
											        <c:forEach var="u" items="${userList}">
											            <c:if test="${u.enable == 0}">
											                <c:set var="displayText" value="" />
											
											                <c:if test="${not empty u.employee_id}">
											                    <c:set var="displayText" value="${u.employee_id}" />
											                </c:if>
											
											                <c:if test="${not empty u.name_en}">
											                    <c:set var="displayText"
											                           value="${displayText}${not empty displayText ? ' - ' : ''}${u.name_en}" />
											                </c:if>
											
											                <c:if test="${not empty u.name}">
											                    <c:set var="displayText"
											                           value="${displayText}${not empty displayText ? ' - ' : ''}${u.name}" />
											                </c:if>
											
											                <c:if test="${not empty u.role_id}">
											                    <c:set var="displayText"
											                           value="${displayText}${not empty displayText ? ' - ' : ''}${u.role_id}" />
											                </c:if>
											
											                <option value="${fn:trim(u.id)}"
											                    ${criteria.searchText eq u.id ? 'selected' : ''}>
											                    ${displayText}
											                </option>
											
											            </c:if>
											        </c:forEach>
											    </optgroup>
											
											</select>
                                        </div>
                                    </div>
                               </div>
                               
                                 <div class="col-md-4">
                                     <label class="form-label fs-7 fw-bold text-gray-700">Site:</label>
                                       
								
								    <div class="position-relative d-flex align-items-center">
                                    	<select name="siteIds" class="form-select" data-control="select2" data-close-on-select="false" data-placeholder="All Site" data-allow-clear="true" multiple="multiple">
		                                     <optgroup label="Site Enable" class="text-muted fs-8 fw-bold text-uppercase">
		                                            <c:forEach var="site" items="${siteList}">
		                                                <option value="${site.id_sitejob}" <c:if test="${criteria.siteId eq site.id_sitejob}">selected</c:if>>${site.name_site}</option>
		                                            </c:forEach>
		                                     </optgroup>
                                        </select>
                                   </div>
                          
                                </div>
                                
                                <div class="col-md-4">
                                     <label class="form-label fs-7 fw-bold text-gray-700">Action:</label>
								    <div class="position-relative d-flex align-items-center">
                                    	<select name="actions" class="form-select" data-control="select2" data-control="select2" data-close-on-select="false" data-placeholder="All Action" data-allow-clear="true" multiple="multiple">
											    <option value="1">In</option>
											    <option value="2">Out</option>
                                        </select>
                                     </div>
                          
                                </div>
                                <div class="col-md-4">
								    <label class="form-label fs-7 fw-bold text-gray-700">
								        Date:
								    </label>
								
								    <div class="position-relative d-flex align-items-center">
								        <i class="ki-duotone ki-calendar-8 position-absolute ms-4 mb-1 text-gray-500 fs-2">
								            <span class="path1"></span>
								            <span class="path2"></span>
								            <span class="path3"></span>
								            <span class="path4"></span>
								            <span class="path5"></span>
								            <span class="path6"></span>
								        </i>
								
								        <input class="form-control ps-12 datepicker"
								               id="workDate"
								               name="workDate"
								               placeholder="Select date"/>
								    </div>
								</div>
                                 
                            </div>
                        </div>
                    </div>
                </form>
                
                <div class="card mb-10 position-relative" >
					    <div id="mapLoading"
						     class="position-absolute top-0 start-0 w-100 h-100 d-flex flex-column align-items-center justify-content-center text-center"
						     style="z-index:1000; background:rgba(245, 245, 245, 0.6);">
						
						    <div id="mapLoadingSpinner"
						         class="spinner-border text-primary mb-3"
						         role="status">
						    </div>
						
						    <div id="mapLoadingText"
						         class="fw-bold text-gray-700">
						        Loading Map...
						    </div>
						
						</div>
					
					    <div id="mapContainer"
					         style="height: calc(100vh - 250px); width:100%;">
					    </div>
				</div>
    
            </div>
        </div>
	</div>
	
<%-- </perm:permission> --%>

<script>
var allWorkLocationsData = [];
var displayWorkLocations = [];
var currentRequest = null;
var map = null;
var markersLayer = null;

$(document).ready(function() {

    var isInit = true;

    $('#userSelect').select2({
    	allowClear: false 
    });

    $('.datepicker').flatpickr({
        dateFormat: "d-m-Y",
        altInput: true,
        altFormat: "j M Y",
        defaultDate: "today",
        onChange: function() {
            loadData();
        }
    });

    $('#userSelect').on('change', function() {
        if (!isInit) {
            loadData();
        }
    });

    $('select[name="siteIds"]').on('change', function() {
        loadData();
    });
    
    $('select[name="actions"]').on('change', function () {
        renderLocalData();
    });

    loadData();

    setTimeout(function() {
        isInit = false;
    }, 500);

});

function renderLocalData() {

    var actionsFilter = $('select[name="actions"]').val() || [];

    displayWorkLocations = allWorkLocationsData.filter(function(item) {

        /* if (actionFilter && String(item.work_hours_type) !== actionFilter) {
            return false;
        }*/
    	if (actionsFilter.length > 0) {
            if (!actionsFilter.includes(String(item.work_hours_type))) {
                return false;
            }
        }

        return true;
    });

    renderAllUserMap();
}

function formatDate(dateString) {
    if (!dateString) return '';

    var date = new Date(dateString);

    return date.toLocaleDateString('en-GB', {
        day: 'numeric',
        month: 'short',
        year: 'numeric'
    });
}


function formatTime(dateString) {
    if (!dateString) return '';

    var date = new Date(dateString);

    return date.toLocaleTimeString('en-GB', {
        hour: '2-digit',
        minute: '2-digit'
    });
}


function getWorkTypeIcon(type) {

    type = String(type).trim();

    if (type === '1') {
        return '<div class="d-inline-flex align-items-center badge badge-light-success fw-bold px-4 py-2 fs-7">IN</div>';
    }
    else if (type === '2') {
        return '<div class="d-inline-flex align-items-center badge badge-light-info fw-bold px-4 py-2 fs-7">OUT</div>';
    }

    return '<span class="badge badge-light text-gray-600">' + type + '</span>';
}


window.loadData = function() {

    if (currentRequest) {
        currentRequest.abort();
        currentRequest = null;
    }

    $("#mapLoading").removeClass("d-none").addClass("d-flex");
    $("#mapLoadingSpinner").show();
    $("#mapLoadingText").text("Loading Map...");

    var formData = $('#filterForm').serialize();

    var workDate = $('#workDate').val();

    formData += '&startDate=' + encodeURIComponent(workDate);
    formData += '&endDate=' + encodeURIComponent(workDate);

    currentRequest = $.ajax({

        url: "${pageContext.request.contextPath}/search_work_location",
        type: "POST",
        data: formData,
        dataType: "json",

        success: function(response) {

            currentRequest = null;

            allWorkLocationsData = response.workLogList || [];

            displayWorkLocations = allWorkLocationsData;

            renderAllUserMap();
        },

        error: function(jqXHR, textStatus, errorThrown) {

            if (textStatus === 'abort') {
                return;
            }

            currentRequest = null;

            $("#mapLoadingSpinner").hide();
            $("#mapLoadingText").text("ไม่สามารถโหลดข้อมูลแผนที่ได้");
            $("#mapLoading").removeClass("d-none").addClass("d-flex");

            console.error("Ajax Error:", textStatus, errorThrown);
        }

    });

};

function renderAllUserMap() {

    $("#mapLoading").removeClass("d-none").addClass("d-flex");
    $("#mapLoadingSpinner").show();
    $("#mapLoadingText").text("Loading Map...");

    try {
    	var greenIcon = new L.Icon({
    	    iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png',
    	    shadowUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png',
    	    iconSize: [25, 41],
    	    iconAnchor: [12, 41],
    	    popupAnchor: [1, -34],
    	    shadowSize: [41, 41]
    	});

    	var violetIcon = new L.Icon({
    	    iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-violet.png',
    	    shadowUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png',
    	    iconSize: [25, 41],
    	    iconAnchor: [12, 41],
    	    popupAnchor: [1, -34],
    	    shadowSize: [41, 41]
    	});
        if (!map) {

            map = L.map('mapContainer').setView([13.7563, 100.5018], 11);

            L.tileLayer(
                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                {
                    maxZoom: 19,
                    attribution: '&copy; OpenStreetMap'
                }
            ).addTo(map);
        }

        if (markersLayer) {
            markersLayer.clearLayers();
        }
        else {
            markersLayer = L.layerGroup().addTo(map);
        }
        console.log(allWorkLocationsData);
        var bounds = [];

        displayWorkLocations.forEach(function(item) {

            var lat = parseFloat(item.latitude);
            var lng = parseFloat(item.longitude);
            var device = item.user_agent || '-';
            var ip = item.ip_address || '-';

            if (isNaN(lat) || isNaN(lng)) {
                return;
            }
            
            var retroactive =
                item.description &&
                item.time_create &&
                item.work_hours_time_work &&
                item.time_create !== item.work_hours_time_work;

            var retroactiveHtml = '';

            if (retroactive) {
                var retroactiveHtml =
                    '<i class="ki-duotone ki-message-text-2 fs-2 text-gray-500 me-1 align-middle">' +
                            '<span class="path1"></span>' +
                            '<span class="path2"></span>' +
                            '<span class="path3"></span>' +
                        '</i>' +
                        '<span>' + item.description + '</span>';
            }
            

            var userName = item.name_en || item.name || 'Unknown User';

            var popupHtml =
                '<div style="min-width:180px;">'
                + '<strong>' + userName + '</strong><br>'
                + '<div class="my-2">'
                + getWorkTypeIcon(item.work_hours_type)
                + ' '
                + formatDate(item.work_hours_time_work)
                + ', '
                + formatTime(item.work_hours_time_work)+ '<br>'
                + '</div>'
                + '<div class="my-1">'
                + retroactiveHtml
                + '</div>'
                + 'Latitude : ' + lat + '<br>'
                + 'Longitude : ' + lng + '<br>'
                + '<hr>'
                + '<b>IP :</b> ' + ip + '<br>'
                + '<b>Device :</b> <small>' + device + '</small>'
                
                + '</div>';

                var icon;

    			if (item.work_hours_type == '1') {
    			    icon = greenIcon;     // IN
    			} else {
    			    icon = violetIcon;    // OUT
    			}
    			
    			var marker = L.marker([lat, lng], {
    			    icon: icon
    			}).bindPopup(popupHtml);
            /*  var marker = L.marker([lat, lng]).bindPopup(popupHtml); */

           /*  var icon = (item.work_hours_type == '1')
            ? inIcon
            : outIcon;

	        var marker = L.marker([lat, lng], {
	            icon: icon
	        }).bindPopup(popupHtml); */

            markersLayer.addLayer(marker);

            bounds.push([lat, lng]);

        });

        if (bounds.length === 0) {

            map.setView([13.7563, 100.5018], 11);
            map.invalidateSize();

            $("#mapLoadingSpinner").hide();
            $("#mapLoadingText").text("ไม่มีข้อมูลในวันที่เลือก");

            return;
        }

        map.fitBounds(bounds, {
            padding: [40, 40]
        });

        setTimeout(function() {

            map.invalidateSize();

            $("#mapLoadingSpinner").hide();

            $("#mapLoading")
                .addClass("d-none")
                .removeClass("d-flex");

        }, 500);

    }
    catch (e) {

        console.error("Map Render Error:", e);

        $("#mapLoadingSpinner").hide();
        $("#mapLoadingText").text("ไม่สามารถโหลดแผนที่ได้");

    }

}

/* function createMarker(color) {
    return L.divIcon({
        className: '',
        html:
            '<i class="ki-duotone ki-geolocation fs-1" style="color:' + color + ';">' +
                '<span class="path1"></span>' +
                '<span class="path2"></span>' +
            '</i>',
        iconSize: [32, 32],
        iconAnchor: [16, 32],
        popupAnchor: [0, -32]
    });
}

var inIcon = createMarker('#00C853');   // เขียว
var outIcon = createMarker('#9C27B0');  // ม่วง */
</script>
