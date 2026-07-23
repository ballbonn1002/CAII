<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tlds/permission.tld" prefix="perm"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PR - Purchase Requisition</title>

<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<link href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>

<link href="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/assets/plugins/custom/datatables/datatables.bundle.js"></script>

<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
#draft_button { border-color: #e4e6ea; background-color: #e4e6ea; }
</style>

</head>
<body>
	<div class="app-main flex-column app-container container-xxl">
		<div class="page-title d-flex justify-content-between align-items-center py-3">
			<div>
				<h1 class="page-heading text-gray-900 fw-bold fs-3">PR - Purchase Requisition</h1>
				<ul class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
                    <li class="breadcrumb-item text-muted"><a href="${pageContext.request.contextPath}/demo_dashboard" class="text-muted text-hover-primary">Home</a></li>
                    <li class="breadcrumb-item"><span class="bullet bg-gray-500 w-5px h-2px"></span></li>
                    <li class="breadcrumb-item text-muted"><a class="text-muted text-hover-primary">Product</a></li>
                </ul>
			</div>
			<div class="d-flex align-items-center gap-4">
		        <span class="text-primary fs-1 fw-bolder">#PR001</span> 
		        <button class="btn btn-light" id="draft_button">Draft</button>
		    </div>
		</div>
		
		<div class="card mb-6">
		    <div class="card-header border-0 pt-6">
		        <h3 class="card-title fw-bold">PR - Header</h3>
		    </div>
		    <div class="card-body pt-4">
		        <div class="row mb-6">
		            <div class="col-md-6 d-flex align-items-center gap-3">
		                <i class="ki-duotone ki-profile-circle fs-1 text-gray-500"></i>
		                <span class="fw-semibold text-gray-800">A292 - Supaporn Sukthiamsuwan</span>
		            </div>
		            <div class="col-md-6 d-flex align-items-center gap-3">
		                <i class="ki-duotone ki-calendar-8 fs-3"> 
											<span class="path1"></span> <span class="path2"></span> 
											<span class="path3"></span> <span class="path4"></span> 
											<span class="path5"></span> <span class="path6"></span>
										</i> 
		                <span class="fw-semibold text-gray-800">27 May 2026, 10:00</span>
		            </div>
		        </div>
		        <div class="row">
		            <div class="col-12">
		                <label class="form-label fw-semibold">Description <span class="text-danger">*</span></label>
		                <textarea class="form-control form-control-solid" rows="3" placeholder="Enter description..."></textarea>
		            </div>
		        </div>
		    </div>
		</div>
		
		<div class="card mb-6">
		    <div class="card-header border-0 pt-6 d-flex justify-content-between align-items-center">
		        <h3 class="card-title fw-bold">PR - Detail</h3>
		        <div class="card-toolbar gap-3">
		            <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#createPrModal"> 
						<i class="ki-duotone ki-plus fs-2"></i> Create
					</button>
					<!-- PR create popup -->
					<div class="modal fade" id="createPrModal" tabindex="-1" aria-labelledby="createPrModalLabel" aria-hidden="true">
					    <div class="modal-dialog modal-dialog-centered modal-lg"> <div class="modal-content">
					            <div class="modal-header border-0 pb-0 pt-6 px-8">
					                <h3 class="modal-title fw-bold text-gray-900 fs-2" id="createPrModalLabel">Create PR</h3>
					                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					            </div>
					            
					            <div class="modal-body px-8 pt-6 pb-4">
					                <form id="formCreatePr" action="purchase_requisition_detail_savecreate" method="post">
					                    
					                    <div class="row g-6 mb-6">
					                        <div class="col-md-6">
					                            <label class="form-label fw-semibold text-gray-700">Category <span class="text-danger">*</span></label>
					                            <select class="form-select select2-modal" name="category" data-placeholder="Select Category">
					                                <option value=""></option>
					                                <option value="Equipment" selected>Equipment</option>
					                                </select>
					                        </div>
					                        <div class="col-md-6">
					                            <label class="form-label fw-semibold text-gray-700">Product Name <span class="text-danger">*</span></label>
					                            <select class="form-select select2-modal" name="productName" data-placeholder="Select Product">
					                                <option value=""></option>
					                                <option value="Macbook air" selected>Macbook air</option>
					                                </select>
					                        </div>
					                    </div>
					
					                    <div class="row g-6 mb-6">
					                        <div class="col-md-6">
					                            <label class="form-label fw-semibold text-gray-700">จำนวน <span class="text-danger">*</span></label>
					                            <input type="number" class="form-control" name="quantity" value="1" min="1" />
					                        </div>
					                        <div class="col-md-6">
					                            <label class="form-label fw-semibold text-gray-700">Unit <span class="text-danger">*</span></label>
					                            <select class="form-select select2-modal" name="unit" data-placeholder="Select Unit">
					                                <option value=""></option>
					                                <option value="เครื่อง" selected>เครื่อง</option>
					                                </select>
					                        </div>
					                    </div>
					
					                    <div class="row g-6 mb-8">
					                        <div class="col-12">
					                            <label class="form-label fw-semibold text-gray-700">Description / Detail <span class="text-danger">*</span></label>
					                            <textarea class="form-control" name="description" rows="3">Macbook air M5 ,13 นิ้ว , ความจุ 512GB</textarea>
					                        </div>
					                    </div>
					                </form>
					            </div>
					            
					            <div class="modal-footer border-0 px-8 pb-8 pt-0 justify-content-end">
					                <button type="button" class="btn btn-light me-3" data-bs-dismiss="modal">Close</button>
					                <button type="button" class="btn btn-success" onclick="$('#formCreatePr').submit();">Create</button>
					            </div>
					        </div>
					    </div>
					</div>
		            <button class="btn btn-primary btn-sm fw-bold" data-bs-toggle="modal" data-bs-target="#modal_search_mr">
		                <i class="ki-duotone ki-magnifier fs-3">
		                		<span class="path1"></span>
 							<span class="path2"></span>
 						</i>Search MR
		            </button>
		            
		            <!-- =======================================================
					      Modal: Search MR
					======================================================= -->
					<div class="modal fade" id="modal_search_mr" tabindex="-1" aria-hidden="true">
					    <div class="modal-dialog modal-dialog-centered mw-900px">
					        <div class="modal-content">
					            
					            <!-- Modal Header -->
					            <div class="modal-header pb-0 border-0 justify-content-between align-items-center pt-8 px-10">
					                <h2 class="fw-bolder mb-0 fs-2">Search MR</h2>
					                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
					                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
					                </div>
					            </div>
					            
					            <!-- Modal Body -->
					            <div class="modal-body scroll-y pt-8 pb-10 px-10">
					                
					                <!-- Form Filters -->
					                <div class="row g-8 mb-8">
					                    <div class="col-md-6">
					                        <label class="fs-6 fw-semibold mb-2">
					                            Search PR <span class="text-danger">*</span>
					                        </label>
					                        <input type="text" class="form-control" placeholder="" />
					                    </div>
					                    <div class="col-md-6">
					                        <label class="fs-6 fw-semibold mb-2">
					                            Category <span class="text-danger">*</span>
					                        </label>
					                        <select class="form-select" data-control="select2" data-hide-search="true">
					                            <option value="all" selected>All</option>
					                            <option value="equipment">Equipment</option>
					                            <option value="consumables">Consumables</option>
					                            <option value="instrument">Instrument</option>
					                        </select>
					                    </div>
					                </div>
					
					                <!-- Results Header -->
					                <div class="d-flex justify-content-between align-items-center mb-4">
					                    <div class="d-flex align-items-center gap-2">
					                        <h3 class="fw-bold fs-4 mb-0">3 Items Found</h3>
					                        <span class="text-muted fs-7 fw-semibold">by Recent Updates <i class="ki-duotone ki-arrow-down fs-7"></i></span>
					                    </div>
					                    <div class="text-primary fw-bolder fs-5">
					                        1 Selected
					                    </div>
					                </div>
					
					                <!-- Table -->
					                <div class="table-responsive">
					                    <table class="table align-middle table-row-dashed fs-6 gy-4">
					                        <thead>
					                            <tr class="text-start text-muted fw-bold fs-7 text-uppercase gs-0">
					                                <th class="w-10px pe-2">
					                                    <div class="form-check form-check-sm form-check-custom form-check-solid">
					                                        <input class="form-check-input" type="checkbox" value="1" />
					                                    </div>
					                                </th>
					                                <th class="min-w-50px">#</th>
					                                <th class="min-w-100px">MR ID</th>
					                                <th class="min-w-150px">CATEGORY</th>
					                                <th class="min-w-200px">REQUEST NAME</th>
					                                <th class="min-w-150px">PRODUCT</th>
					                                <th class="min-w-100px text-end">STATUS</th>
					                            </tr>
					                        </thead>
					                        <tbody class="text-gray-600 fw-semibold">
					                            <!-- Row 1 Mock Data -->
					                            <tr>
					                                <td>
					                                    <div class="form-check form-check-sm form-check-custom form-check-solid">
					                                        <input class="form-check-input" type="checkbox" value="1" checked="checked" />
					                                    </div>
					                                </td>
					                                <td class="text-gray-800 fw-bold">1</td>
					                                <td>MR001</td>
					                                <td>
					                                    <div class="d-flex align-items-center gap-2">
					                                        <i class="ki-duotone ki-monitor-mobile fs-2 text-primary"><i class="path1"></i><i class="path2"></i></i>
					                                        <span class="text-gray-800">Equipment</span>
					                                    </div>
					                                </td>
					                                <td>
					                                    <div class="d-flex align-items-center">
					                                        <div class="symbol symbol-35px symbol-circle me-3">
					                                            <img src="assets/media/avatars/300-1.jpg" alt="Pic" />
					                                        </div>
					                                        <div class="d-flex flex-column">
					                                            <span class="text-gray-800 mb-1">Kridsada Ninpetch</span>
					                                            <span class="text-muted fs-7">1 Jan 2026, 12:33</span>
					                                        </div>
					                                    </div>
					                                </td>
					                                <td>
					                                    <div class="d-flex flex-column">
					                                        <span class="text-gray-800">Macbook Air</span>
					                                        <span class="text-muted fs-7">1 เครื่อง</span>
					                                    </div>
					                                </td>
					                                <td class="text-end">
					                                    <span class="badge bg-warning text-white px-3 py-2">Pending</span>
					                                </td>
					                            </tr>
					                            <!-- Row 2 -->
					                            <tr>
					                                <td>
					                                    <div class="form-check form-check-sm form-check-custom form-check-solid">
					                                        <input class="form-check-input" type="checkbox" value="2" />
					                                    </div>
					                                </td>
					                                <td class="text-gray-800 fw-bold">2</td>
					                                <td>MR002</td>
					                                <td>
					                                    <div class="d-flex align-items-center gap-2">
					                                        <i class="ki-duotone ki-element-11 fs-2 text-warning"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i>
					                                        <span class="text-gray-800">Consumables</span>
					                                    </div>
					                                </td>
					                                <td>
					                                    <div class="d-flex align-items-center">
					                                        <div class="symbol symbol-35px symbol-circle me-3">
					                                            <img src="assets/media/avatars/300-1.jpg" alt="Pic" />
					                                        </div>
					                                        <div class="d-flex flex-column">
					                                            <span class="text-gray-800 mb-1">Kridsada Ninpetch</span>
					                                            <span class="text-muted fs-7">1 Jan 2026, 12:33</span>
					                                        </div>
					                                    </div>
					                                </td>
					                                <td>
					                                    <div class="d-flex flex-column">
					                                        <span class="text-gray-800">A4</span>
					                                        <span class="text-muted fs-7">1 ริม</span>
					                                    </div>
					                                </td>
					                                <td class="text-end">
					                                    <span class="badge bg-warning text-white px-3 py-2">Pending</span>
					                                </td>
					                            </tr>
					                            <!-- Row 3 -->
					                            <tr class="bg-light rounded">
					                                <td class="ps-3">
					                                    <div class="form-check form-check-sm form-check-custom form-check-solid">
					                                        <input class="form-check-input" type="checkbox" value="3" />
					                                    </div>
					                                </td>
					                                <td class="text-gray-800 fw-bold">3</td>
					                                <td>MR003</td>
					                                <td>
					                                    <div class="d-flex align-items-center gap-2">
					                                        <i class="ki-duotone ki-devices fs-2 text-secondary"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
					                                        <span class="text-gray-800">Instument</span>
					                                    </div>
					                                </td>
					                                <td>
					                                    <div class="d-flex align-items-center">
					                                        <div class="symbol symbol-35px symbol-circle me-3">
					                                            <img src="assets/media/avatars/300-1.jpg" alt="Pic" />
					                                        </div>
					                                        <div class="d-flex flex-column">
					                                            <span class="text-gray-800 mb-1">Kridsada Ninpetch</span>
					                                            <span class="text-muted fs-7">1 Jan 2026, 12:33</span>
					                                        </div>
					                                    </div>
					                                </td>
					                                <td>
					                                    <div class="d-flex flex-column">
					                                        <span class="text-gray-800">ต้นคริสมาส</span>
					                                        <span class="text-muted fs-7">1 ต้น</span>
					                                    </div>
					                                </td>
					                                <td class="text-end pe-3">
					                                    <span class="badge bg-warning text-white px-3 py-2">Pending</span>
					                                </td>
					                            </tr>
					                        </tbody>
					                    </table>
					                </div>
					
					            </div>
					            
					            <!-- Modal Footer -->
					            <div class="modal-footer border-0 justify-content-end pt-0 pb-10 px-10">
					                <button type="button" class="btn btn-light me-3" data-bs-dismiss="modal">Close</button>
					                <button type="button" class="btn btn-success" onclick="$('#formCreatePr').submit();">
					                    Submit
					                </button> 
					            </div>
					
					        </div>
					    </div>
					</div>
		        </div>
		    </div>
		    
		    <div class="card-body pt-0">
		        
				<!-- for use
		        <c:forEach var="item" items="${prItemList}">
		            <div class="pr-item-group border-bottom border-2 py-5" style="border-bottom-color: #C9C9C9 !important;">
		                <div class="d-flex justify-content-between align-items-center pr-main-row">
		                    <div class="d-flex align-items-center gap-4">
		                        <c:choose>
		                            <c:when test="${item.category == 'Equipment'}">\
		                                <i class="ki-duotone ki-monitor-mobile fs-1 text-primary">
											<i class="path1"></i>
											<i class="path2"></i>
										</i>
		                                <span class="badge bg-light-primary text-primary fw-bold px-3 py-2 rounded-pill">${item.category}</span>
		                            </c:when>
		                            <c:when test="${item.category == 'Consumables' || item.category == 'Consumable'}">
										<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
											<path opacity="0.3" d="M6.64 11.4302H1.93C0.86409 11.4302 0 12.2943 0 13.3602V18.0702C0 19.1361 0.86409 20.0002 1.93 20.0002H6.64C7.70591 20.0002 8.57 19.1361 8.57 18.0702V13.3602C8.57 12.2943 7.70591 11.4302 6.64 11.4302Z" fill="#FD7E14"/>
											<path d="M2.86094 11.4302H5.71094V13.3302C5.71094 13.5954 5.60558 13.8497 5.41804 14.0373C5.23051 14.2248 4.97615 14.3302 4.71094 14.3302H3.71094C3.44572 14.3302 3.19137 14.2248 3.00383 14.0373C2.81629 13.8497 2.71094 13.5954 2.71094 13.3302V11.4302H2.86094Z" fill="#FD7E14"/>
											<path opacity="0.3" d="M18.0697 11.4302H13.3597C12.2938 11.4302 11.4297 12.2943 11.4297 13.3602V18.0702C11.4297 19.1361 12.2938 20.0002 13.3597 20.0002H18.0697C19.1356 20.0002 19.9997 19.1361 19.9997 18.0702V13.3602C19.9997 12.2943 19.1356 11.4302 18.0697 11.4302Z" fill="#FD7E14"/>
											<path d="M14.2884 11.4302H17.1484V13.3302C17.1484 13.5954 17.0431 13.8497 16.8555 14.0373C16.668 14.2248 16.4137 14.3302 16.1484 14.3302H15.1484C14.8832 14.3302 14.6289 14.2248 14.4413 14.0373C14.2538 13.8497 14.1484 13.5954 14.1484 13.3302V11.4302H14.2884Z" fill="#FD7E14"/>
											<path opacity="0.3" d="M2 0H6.64C7.15187 0 7.64277 0.203339 8.00472 0.565284C8.36666 0.927229 8.57 1.41813 8.57 1.93V6.64C8.57 7.15187 8.36666 7.64277 8.00472 8.00472C7.64277 8.36666 7.15187 8.57 6.64 8.57H1.93C1.41813 8.57 0.927229 8.36666 0.565284 8.00472C0.203339 7.64277 0 7.15187 0 6.64V2C0 1.46957 0.210714 0.960859 0.585786 0.585786C0.960859 0.210714 1.46957 0 2 0Z" fill="#FD7E14"/>
											<path d="M2.86094 0H5.71094V1.9C5.71094 2.03132 5.68507 2.16136 5.63482 2.28268C5.58456 2.40401 5.5109 2.51425 5.41804 2.60711C5.32519 2.69997 5.21495 2.77362 5.09362 2.82388C4.9723 2.87413 4.84226 2.9 4.71094 2.9H3.71094C3.44572 2.9 3.19137 2.79464 3.00383 2.60711C2.81629 2.41957 2.71094 2.16522 2.71094 1.9V0H2.86094Z" fill="#FD7E14"/>
											<path opacity="0.3" d="M18.0697 0H13.3597C12.2938 0 11.4297 0.86409 11.4297 1.93V6.64C11.4297 7.70591 12.2938 8.57 13.3597 8.57H18.0697C19.1356 8.57 19.9997 7.70591 19.9997 6.64V1.93C19.9997 0.86409 19.1356 0 18.0697 0Z" fill="#FD7E14"/>
											<path d="M14.2884 0H17.1484V1.9C17.1484 2.03132 17.1226 2.16136 17.0723 2.28268C17.0221 2.40401 16.9484 2.51425 16.8555 2.60711C16.7627 2.69997 16.6524 2.77362 16.5311 2.82388C16.4098 2.87413 16.2798 2.9 16.1484 2.9H15.1484C14.8832 2.9 14.6289 2.79464 14.4413 2.60711C14.2538 2.41957 14.1484 2.16522 14.1484 1.9V0H14.2884Z" fill="#FD7E14"/>
										</svg>
		                                <span class="badge bg-light-warning text-warning fw-bold px-3 py-2 rounded-pill">${item.category}</span>
		                            </c:when>
		                            <c:when test="${item.category == 'Office Supplies'}">
		                                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
											<path opacity="0.3" d="M3.09011 7.72172L7.83011 10.4517C8.13946 10.6408 8.39432 10.907 8.56964 11.2244C8.74497 11.5417 8.83473 11.8992 8.83011 12.2617V17.7317C8.82786 18.097 8.72991 18.4553 8.54602 18.771C8.36213 19.0866 8.09873 19.3485 7.78206 19.5306C7.46539 19.7128 7.10652 19.8087 6.74123 19.8089C6.37593 19.8091 6.01696 19.7135 5.70011 19.5317L1.00011 16.8017C0.691428 16.6119 0.43711 16.3455 0.26188 16.0283C0.086649 15.7112 -0.00353161 15.3541 0.000105835 14.9917V9.52172C0.00614049 9.16222 0.104819 8.81035 0.286603 8.50013C0.468387 8.18992 0.727127 7.93185 1.03781 7.75086C1.3485 7.56988 1.70062 7.47211 2.06013 7.46701C2.41965 7.4619 2.77441 7.54963 3.09011 7.72172Z" fill="#20C997"/>
											<path opacity="0.3" d="M19.0186 9.52198V14.992C19.0222 15.3543 18.9321 15.7114 18.7568 16.0286C18.5816 16.3458 18.3273 16.6122 18.0186 16.802L13.2786 19.532C12.9618 19.7138 12.6028 19.8093 12.2375 19.8091C11.8722 19.8089 11.5133 19.713 11.1967 19.5309C10.88 19.3488 10.6166 19.0869 10.4327 18.7712C10.2488 18.4556 10.1509 18.0973 10.1486 17.732V12.262C10.144 11.8995 10.2337 11.542 10.4091 11.2246C10.5844 10.9073 10.8393 10.641 11.1486 10.452L15.8886 7.72198C16.2055 7.54019 16.5644 7.44464 16.9297 7.44482C17.295 7.44501 17.6539 7.54094 17.9706 7.72305C18.2872 7.90516 18.5506 8.16709 18.7345 8.48273C18.9184 8.79836 19.0164 9.15669 19.0186 9.52198Z" fill="#20C997"/>
											<path opacity="0.3" d="M3.71068 6.6418L8.49068 9.3718C8.80721 9.55338 9.16576 9.64893 9.53068 9.64893C9.8956 9.64893 10.2542 9.55338 10.5707 9.3718L15.2807 6.6118C15.5963 6.42906 15.8582 6.16657 16.0404 5.85065C16.2225 5.53472 16.3184 5.17646 16.3184 4.8118C16.3184 4.44713 16.2225 4.08888 16.0404 3.77295C15.8582 3.45703 15.5963 3.19454 15.2807 3.0118L10.4907 0.281799C10.1752 0.09726 9.81621 0 9.45068 0C9.08515 0 8.72621 0.09726 8.41068 0.281799L3.70068 3.0418C3.38561 3.22541 3.12435 3.48863 2.9431 3.80506C2.76184 4.12149 2.66696 4.48001 2.66798 4.84468C2.66899 5.20935 2.76586 5.56734 2.94887 5.88276C3.13188 6.19818 3.39459 6.45994 3.71068 6.6418Z" fill="#20C997"/>
											<path d="M13.3008 11.0118C13.3034 11.209 13.3836 11.3972 13.524 11.5357C13.6643 11.6742 13.8536 11.7518 14.0508 11.7518C14.248 11.7492 14.4362 11.669 14.5747 11.5286C14.7132 11.3883 14.7908 11.199 14.7908 11.0018V8.36182L13.3008 9.22182V11.0118Z" fill="#20C997"/>
											<path d="M14.7714 6.9017L5.94141 1.7417L4.44141 2.6117L13.2814 7.7617V7.7717L14.7714 6.9117V6.9017Z" fill="#20C997"/>
										</svg>
		                                <span class="badge bg-light-success text-success fw-bold px-3 py-2 rounded-pill">${item.category}</span>
		                            </c:when>
		                            <c:otherwise>
		                                <i class="ki-duotone ki-file fs-2x text-gray-500"></i>
		                                <span class="badge bg-light-secondary text-gray-700 fw-bold px-3 py-2 rounded-pill">${item.category}</span>
		                            </c:otherwise>
		                        </c:choose>
		
		                        <span class="fw-semibold text-gray-800">${item.name}</span>
		                        <span class="text-muted"><i class="ki-duotone ki-file fs-4 me-1"></i> ${item.description}</span>
		                    </div>
		                    <div class="d-flex align-items-center gap-8">
		                        <div class="fw-bold text-gray-800 fs-5">${item.quantity} <span class="text-muted fw-normal fs-6 ms-1">${item.unit}</span></div>
		                        <div class="d-flex gap-2">
		                            <a href="${pageContext.request.contextPath}/pr_item_edit?id=${item.itemId}" class="btn btn-icon btn-light-primary btn-sm" title="Edit">
		                                <i class="ki-duotone ki-pencil fs-4"><span class="path1"></span><span class="path2"></span></i>
		                            </a>
		                            <a href="javascript:void(0);" onclick="deletePrItem('${item.itemId}', '${item.name}')" class="btn btn-icon btn-light-danger btn-sm" title="Delete">
		                                <i class="ki-duotone ki-trash fs-4"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i>
		                            </a>
		                            <button class="btn btn-icon btn-light-secondary btn-sm btn-toggle-detail">
		                                <i class="ki-duotone ki-down fs-4"></i>
		                            </button>
		                        </div>
		                    </div>
		                </div>
		
		                <div class="pr-detail-row mt-5 pt-5 border-top border-2 border-secondary ps-12" style="display: none;">
		                    <c:forEach var="subItem" items="${item.subItems}">
		                        <div class="d-flex justify-content-between align-items-center py-4">
		                            <div class="d-flex gap-8 text-gray-600">
		                                <span><i class="ki-duotone ki-user fs-4 me-2"></i> ${subItem.requestedBy}</span>
		                                <span><i class="ki-duotone ki-calendar fs-4 me-2"></i> <fmt:formatDate value="${subItem.requestedDate}" pattern="dd MMM yyyy, HH:mm" /></span>
		                            </div>
		                            <div class="d-flex gap-6 align-items-center" style="min-width: 150px; justify-content: flex-end;">
		                                <c:choose>
		                                    <c:when test="${not empty subItem.mrNo}">
		                                        <span class="text-primary fw-bold badge bg-light-primary"><i class="ki-duotone ki-document fs-4 me-1 text-primary"></i> ${subItem.mrNo}</span>
		                                    </c:when>
		                                    <c:otherwise>
		                                        <span class="text-muted"><i class="ki-duotone ki-document fs-4 me-1"></i> - </span>
		                                    </c:otherwise>
		                                </c:choose>
		                                <span class="fw-semibold text-gray-800" style="min-width: 60px; text-align: right;">${subItem.quantity} <span class="text-muted fw-normal fs-7 ms-1">${item.unit}</span></span>
		                            </div>
		                        </div>
		                    </c:forEach>
		                </div>
		            </div>
		        </c:forEach>
		        -->

				<!-- Mock Data -->
		        <div class="pr-item-group border-bottom border-2 py-5" style="border-bottom-color: #C9C9C9 !important;">
		            <div class="d-flex justify-content-between align-items-center pr-main-row">
		                <div class="d-flex align-items-center gap-4">
		                		<i class="ki-duotone ki-monitor-mobile fs-1 text-primary">
								<i class="path1"></i>
								<i class="path2"></i>
							</i>
		                    <span class="badge bg-light-primary text-primary fw-bold px-3 py-2 rounded-pill">Equipment</span>
		                    <span class="fw-semibold text-gray-800">Notebook Windows</span>
		                    <span class="text-muted"><i class="ki-duotone ki-file fs-4 me-1"></i> Lenovo LOQ 15IAX9</span>
		                </div>
		                <div class="d-flex align-items-center gap-8">
		                    <div class="fw-bold text-gray-800 fs-5">5 <span class="text-muted fw-normal fs-6 ms-1">เครื่อง</span></div>
		                    <div class="d-flex gap-2">
		                        <a href="${pageContext.request.contextPath}/pr_item_edit?id=ITEM001" class="btn btn-icon btn-light-primary btn-sm" title="Edit"><i class="ki-duotone ki-pencil fs-4"><span class="path1"></span><span class="path2"></span></i></a>
		                        <a href="javascript:void(0);" onclick="deletePrItem('ITEM001', 'Notebook Windows')" class="btn btn-icon btn-light-danger btn-sm" title="Delete"><i class="ki-duotone ki-trash fs-4"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i></a>
		                        <button class="btn btn-icon btn-light-secondary btn-sm btn-toggle-detail"><i class="ki-duotone ki-down fs-4"></i></button>
		                    </div>
		                </div>
		            </div>
		            <div class="pr-detail-row mt-5 pt-5 border-top border-2 border-secondary ps-12" style="display: none;">
		                <div class="d-flex justify-content-between align-items-center py-4">
		                    <div class="d-flex gap-8 text-gray-600">
		                        <span><i class="ki-duotone ki-user fs-4 me-2"></i> A314 - Nannapas Inthikay</span>
		                        <span><i class="ki-duotone ki-calendar fs-4 me-2"></i> 25 May 2026, 10:00</span>
		                    </div>
		                    <div class="d-flex gap-6 align-items-center" style="min-width: 150px; justify-content: flex-end;">
		                        <span class="text-primary fw-bold badge bg-light-primary"><i class="ki-duotone ki-document fs-4 me-1 text-primary"></i> MR001</span>
		                        <span class="fw-semibold text-gray-800" style="min-width: 60px; text-align: right;">1 <span class="text-muted fw-normal fs-7 ms-1">เครื่อง</span></span>
		                    </div>
		                </div>
		                <div class="d-flex justify-content-between align-items-center py-4">
		                    <div class="d-flex gap-8 text-gray-600">
		                        <span><i class="ki-duotone ki-user fs-4 me-2"></i> A292 - Supaporn Sukthiamsuwan</span>
		                        <span><i class="ki-duotone ki-calendar fs-4 me-2"></i> 25 May 2026, 10:00</span>
		                    </div>
		                    <div class="d-flex gap-6 align-items-center" style="min-width: 150px; justify-content: flex-end;">
		                        <span class="text-muted"><i class="ki-duotone ki-document fs-4 me-1"></i> - </span>
		                        <span class="fw-semibold text-gray-800" style="min-width: 60px; text-align: right;">4 <span class="text-muted fw-normal fs-7 ms-1">เครื่อง</span></span>
		                    </div>
		                </div>
		            </div>
		        </div>
		        
		        <div class="pr-item-group border-bottom border-2 py-5" style="border-bottom-color: #C9C9C9 !important;">
		            <div class="d-flex justify-content-between align-items-center pr-main-row">
		                <div class="d-flex align-items-center gap-4">
		                		<!-- 
		                		<i class="ki-duotone ki-lots-shopping fs-2x text-warning">
							    <span class="path1"></span>
							    <span class="path2"></span>
							    <span class="path3"></span>
							    <span class="path4"></span>
							    <span class="path5"></span>
							    <span class="path6"></span>
							    <span class="path7"></span>
							    <span class="path8"></span>
							</i>
							-->
							<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path opacity="0.3" d="M6.64 11.4302H1.93C0.86409 11.4302 0 12.2943 0 13.3602V18.0702C0 19.1361 0.86409 20.0002 1.93 20.0002H6.64C7.70591 20.0002 8.57 19.1361 8.57 18.0702V13.3602C8.57 12.2943 7.70591 11.4302 6.64 11.4302Z" fill="#FD7E14"/>
								<path d="M2.86094 11.4302H5.71094V13.3302C5.71094 13.5954 5.60558 13.8497 5.41804 14.0373C5.23051 14.2248 4.97615 14.3302 4.71094 14.3302H3.71094C3.44572 14.3302 3.19137 14.2248 3.00383 14.0373C2.81629 13.8497 2.71094 13.5954 2.71094 13.3302V11.4302H2.86094Z" fill="#FD7E14"/>
								<path opacity="0.3" d="M18.0697 11.4302H13.3597C12.2938 11.4302 11.4297 12.2943 11.4297 13.3602V18.0702C11.4297 19.1361 12.2938 20.0002 13.3597 20.0002H18.0697C19.1356 20.0002 19.9997 19.1361 19.9997 18.0702V13.3602C19.9997 12.2943 19.1356 11.4302 18.0697 11.4302Z" fill="#FD7E14"/>
								<path d="M14.2884 11.4302H17.1484V13.3302C17.1484 13.5954 17.0431 13.8497 16.8555 14.0373C16.668 14.2248 16.4137 14.3302 16.1484 14.3302H15.1484C14.8832 14.3302 14.6289 14.2248 14.4413 14.0373C14.2538 13.8497 14.1484 13.5954 14.1484 13.3302V11.4302H14.2884Z" fill="#FD7E14"/>
								<path opacity="0.3" d="M2 0H6.64C7.15187 0 7.64277 0.203339 8.00472 0.565284C8.36666 0.927229 8.57 1.41813 8.57 1.93V6.64C8.57 7.15187 8.36666 7.64277 8.00472 8.00472C7.64277 8.36666 7.15187 8.57 6.64 8.57H1.93C1.41813 8.57 0.927229 8.36666 0.565284 8.00472C0.203339 7.64277 0 7.15187 0 6.64V2C0 1.46957 0.210714 0.960859 0.585786 0.585786C0.960859 0.210714 1.46957 0 2 0Z" fill="#FD7E14"/>
								<path d="M2.86094 0H5.71094V1.9C5.71094 2.03132 5.68507 2.16136 5.63482 2.28268C5.58456 2.40401 5.5109 2.51425 5.41804 2.60711C5.32519 2.69997 5.21495 2.77362 5.09362 2.82388C4.9723 2.87413 4.84226 2.9 4.71094 2.9H3.71094C3.44572 2.9 3.19137 2.79464 3.00383 2.60711C2.81629 2.41957 2.71094 2.16522 2.71094 1.9V0H2.86094Z" fill="#FD7E14"/>
								<path opacity="0.3" d="M18.0697 0H13.3597C12.2938 0 11.4297 0.86409 11.4297 1.93V6.64C11.4297 7.70591 12.2938 8.57 13.3597 8.57H18.0697C19.1356 8.57 19.9997 7.70591 19.9997 6.64V1.93C19.9997 0.86409 19.1356 0 18.0697 0Z" fill="#FD7E14"/>
								<path d="M14.2884 0H17.1484V1.9C17.1484 2.03132 17.1226 2.16136 17.0723 2.28268C17.0221 2.40401 16.9484 2.51425 16.8555 2.60711C16.7627 2.69997 16.6524 2.77362 16.5311 2.82388C16.4098 2.87413 16.2798 2.9 16.1484 2.9H15.1484C14.8832 2.9 14.6289 2.79464 14.4413 2.60711C14.2538 2.41957 14.1484 2.16522 14.1484 1.9V0H14.2884Z" fill="#FD7E14"/>
							</svg>
		                    <span class="badge bg-light-warning text-warning fw-bold px-3 py-2 rounded-pill">Consumables</span>
		                    <span class="fw-semibold text-gray-800">เมาส์ไร้สาย</span>
		                    <span class="text-muted"><i class="ki-duotone ki-file fs-4 me-1"></i> LOGITECH MOUSE WIRELESS (เมาส์ไร้สาย) M331D</span>
		                </div>
		                <div class="d-flex align-items-center gap-8">
		                    <div class="fw-bold text-gray-800 fs-5">10 <span class="text-muted fw-normal fs-6 ms-1">ตัว</span></div>
		                    <div class="d-flex gap-2">
		                        <a href="${pageContext.request.contextPath}/pr_item_edit?id=ITEM004" class="btn btn-icon btn-light-primary btn-sm" title="Edit"><i class="ki-duotone ki-pencil fs-4"><span class="path1"></span><span class="path2"></span></i></a>
		                        <a href="javascript:void(0);" onclick="deletePrItem('ITEM004', 'เมาส์ไร้สาย')" class="btn btn-icon btn-light-danger btn-sm" title="Delete"><i class="ki-duotone ki-trash fs-4"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i></a>
		                        <button class="btn btn-icon btn-light-secondary btn-sm btn-toggle-detail"><i class="ki-duotone ki-down fs-4"></i></button>
		                    </div>
		                </div>
		            </div>
		            <div class="pr-detail-row mt-5 pt-5 border-top border-2 border-secondary ps-12" style="display: none;">
		                <div class="d-flex justify-content-between align-items-center py-4">
		                    <div class="d-flex gap-8 text-gray-600">
		                        <span><i class="ki-duotone ki-user fs-4 me-2"></i> A292 - Supaporn Sukthiamsuwan</span>
		                        <span><i class="ki-duotone ki-calendar fs-4 me-2"></i> 25 May 2026, 10:00</span>
		                    </div>
		                    <div class="d-flex gap-6 align-items-center" style="min-width: 150px; justify-content: flex-end;">
		                        <span class="text-muted"><i class="ki-duotone ki-document fs-4 me-1"></i> - </span>
		                        <span class="fw-semibold text-gray-800" style="min-width: 60px; text-align: right;">1 <span class="text-muted fw-normal fs-7 ms-1">ตัว</span></span>
		                    </div>
		                </div>
		            </div>
		        </div>
		
		        <div class="pr-item-group border-bottom border-2 py-5" style="border-bottom-color: #C9C9C9 !important;">
		            <div class="d-flex justify-content-between align-items-center pr-main-row">
		                <div class="d-flex align-items-center gap-4">
							<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path opacity="0.3" d="M3.09011 7.72172L7.83011 10.4517C8.13946 10.6408 8.39432 10.907 8.56964 11.2244C8.74497 11.5417 8.83473 11.8992 8.83011 12.2617V17.7317C8.82786 18.097 8.72991 18.4553 8.54602 18.771C8.36213 19.0866 8.09873 19.3485 7.78206 19.5306C7.46539 19.7128 7.10652 19.8087 6.74123 19.8089C6.37593 19.8091 6.01696 19.7135 5.70011 19.5317L1.00011 16.8017C0.691428 16.6119 0.43711 16.3455 0.26188 16.0283C0.086649 15.7112 -0.00353161 15.3541 0.000105835 14.9917V9.52172C0.00614049 9.16222 0.104819 8.81035 0.286603 8.50013C0.468387 8.18992 0.727127 7.93185 1.03781 7.75086C1.3485 7.56988 1.70062 7.47211 2.06013 7.46701C2.41965 7.4619 2.77441 7.54963 3.09011 7.72172Z" fill="#20C997"/>
								<path opacity="0.3" d="M19.0186 9.52198V14.992C19.0222 15.3543 18.9321 15.7114 18.7568 16.0286C18.5816 16.3458 18.3273 16.6122 18.0186 16.802L13.2786 19.532C12.9618 19.7138 12.6028 19.8093 12.2375 19.8091C11.8722 19.8089 11.5133 19.713 11.1967 19.5309C10.88 19.3488 10.6166 19.0869 10.4327 18.7712C10.2488 18.4556 10.1509 18.0973 10.1486 17.732V12.262C10.144 11.8995 10.2337 11.542 10.4091 11.2246C10.5844 10.9073 10.8393 10.641 11.1486 10.452L15.8886 7.72198C16.2055 7.54019 16.5644 7.44464 16.9297 7.44482C17.295 7.44501 17.6539 7.54094 17.9706 7.72305C18.2872 7.90516 18.5506 8.16709 18.7345 8.48273C18.9184 8.79836 19.0164 9.15669 19.0186 9.52198Z" fill="#20C997"/>
								<path opacity="0.3" d="M3.71068 6.6418L8.49068 9.3718C8.80721 9.55338 9.16576 9.64893 9.53068 9.64893C9.8956 9.64893 10.2542 9.55338 10.5707 9.3718L15.2807 6.6118C15.5963 6.42906 15.8582 6.16657 16.0404 5.85065C16.2225 5.53472 16.3184 5.17646 16.3184 4.8118C16.3184 4.44713 16.2225 4.08888 16.0404 3.77295C15.8582 3.45703 15.5963 3.19454 15.2807 3.0118L10.4907 0.281799C10.1752 0.09726 9.81621 0 9.45068 0C9.08515 0 8.72621 0.09726 8.41068 0.281799L3.70068 3.0418C3.38561 3.22541 3.12435 3.48863 2.9431 3.80506C2.76184 4.12149 2.66696 4.48001 2.66798 4.84468C2.66899 5.20935 2.76586 5.56734 2.94887 5.88276C3.13188 6.19818 3.39459 6.45994 3.71068 6.6418Z" fill="#20C997"/>
								<path d="M13.3008 11.0118C13.3034 11.209 13.3836 11.3972 13.524 11.5357C13.6643 11.6742 13.8536 11.7518 14.0508 11.7518C14.248 11.7492 14.4362 11.669 14.5747 11.5286C14.7132 11.3883 14.7908 11.199 14.7908 11.0018V8.36182L13.3008 9.22182V11.0118Z" fill="#20C997"/>
								<path d="M14.7714 6.9017L5.94141 1.7417L4.44141 2.6117L13.2814 7.7617V7.7717L14.7714 6.9117V6.9017Z" fill="#20C997"/>
							</svg>
		                    <span class="badge bg-light-primary text-primary fw-bold px-3 py-2 rounded-pill">Office supplies</span>
		                    <span class="fw-semibold text-gray-800">Macbook Air</span>
		                    <span class="text-muted"><i class="ki-duotone ki-file fs-4 me-1"></i> Macbook Air M5, 13 นิ้ว, ความจุ 512GB</span>
		                </div>
		                <div class="d-flex align-items-center gap-8">
		                    <div class="fw-bold text-gray-800 fs-5">1 <span class="text-muted fw-normal fs-6 ms-1">เครื่อง</span></div>
		                    <div class="d-flex gap-2">
		                        <a href="${pageContext.request.contextPath}/pr_item_edit?id=ITEM002" class="btn btn-icon btn-light-primary btn-sm" title="Edit"><i class="ki-duotone ki-pencil fs-4"><span class="path1"></span><span class="path2"></span></i></a>
		                        <a href="javascript:void(0);" onclick="deletePrItem('ITEM002', 'Macbook Air')" class="btn btn-icon btn-light-danger btn-sm" title="Delete"><i class="ki-duotone ki-trash fs-4"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i></a>
		                        <button class="btn btn-icon btn-light-secondary btn-sm btn-toggle-detail"><i class="ki-duotone ki-down fs-4"></i></button>
		                    </div>
		                </div>
		            </div>
		            <div class="pr-detail-row mt-5 pt-5 border-top border-2 border-secondary ps-12" style="display: none;">
		                <div class="d-flex justify-content-between align-items-center py-4">
		                    <div class="d-flex gap-8 text-gray-600">
		                        <span><i class="ki-duotone ki-user fs-4 me-2"></i> A292 - Supaporn Sukthiamsuwan</span>
		                        <span><i class="ki-duotone ki-calendar fs-4 me-2"></i> 25 May 2026, 10:00</span>
		                    </div>
		                    <div class="d-flex gap-6 align-items-center" style="min-width: 150px; justify-content: flex-end;">
		                        <span class="text-muted"><i class="ki-duotone ki-document fs-4 me-1"></i> - </span>
		                        <span class="fw-semibold text-gray-800" style="min-width: 60px; text-align: right;">1 <span class="text-muted fw-normal fs-7 ms-1">เครื่อง</span></span>
		                    </div>
		                </div>
		            </div>
		        </div>
		
		        <div class="pr-item-group border-bottom border-2 py-5" style="border-bottom-color: #C9C9C9 !important;">
		            <div class="d-flex justify-content-between align-items-center pr-main-row">
		                <div class="d-flex align-items-center gap-4">
		                    <span class="badge bg-light-primary text-primary fw-bold px-3 py-2 rounded-pill">-</span>
		                    <span class="fw-semibold text-gray-800">Macbook Mini</span>
		                    <span class="text-muted"><i class="ki-duotone ki-file fs-4 me-1"></i> Macbook Mini M4, ความจุ 512GB</span>
		                </div>
		                <div class="d-flex align-items-center gap-8">
		                    <div class="fw-bold text-gray-800 fs-5">1 <span class="text-muted fw-normal fs-6 ms-1">เครื่อง</span></div>
		                    <div class="d-flex gap-2">
		                        <a href="${pageContext.request.contextPath}/pr_item_edit?id=ITEM003" class="btn btn-icon btn-light-primary btn-sm" title="Edit"><i class="ki-duotone ki-pencil fs-4"><span class="path1"></span><span class="path2"></span></i></a>
		                        <a href="javascript:void(0);" onclick="deletePrItem('ITEM003', 'Macbook Mini')" class="btn btn-icon btn-light-danger btn-sm" title="Delete"><i class="ki-duotone ki-trash fs-4"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i></a>
		                        <button class="btn btn-icon btn-light-secondary btn-sm btn-toggle-detail"><i class="ki-duotone ki-down fs-4"></i></button>
		                    </div>
		                </div>
		            </div>
		            <div class="pr-detail-row mt-5 pt-5 border-top border-2 border-secondary ps-12" style="display: none;">
		                <div class="d-flex justify-content-between align-items-center py-4">
		                    <div class="d-flex gap-8 text-gray-600">
		                        <span><i class="ki-duotone ki-user fs-4 me-2"></i> A292 - Supaporn Sukthiamsuwan</span>
		                        <span><i class="ki-duotone ki-calendar fs-4 me-2"></i> 25 May 2026, 10:00</span>
		                    </div>
		                    <div class="d-flex gap-6 align-items-center" style="min-width: 150px; justify-content: flex-end;">
		                        <span class="text-muted"><i class="ki-duotone ki-document fs-4 me-1"></i> - </span>
		                        <span class="fw-semibold text-gray-800" style="min-width: 60px; text-align: right;">1 <span class="text-muted fw-normal fs-7 ms-1">เครื่อง</span></span>
		                    </div>
		                </div>
		            </div>
		        </div>
		        --%>
		
		        <div class="d-flex justify-content-end align-items-center mt-6 pt-4">
		            <span class="text-muted fw-semibold me-4 fs-5">Total</span>
		            <span class="text-primary fs-2x fw-bolder">4,700.00</span>
		            <span class="text-muted ms-3 fs-5">บาท</span>
		        </div>
		        
		    </div>
		</div>
		
		<div class="card mb-4">
		    <div class="card-body">     
		        <h3 class="fw-bold mb-4 pb-5">Signature</h3>
		        <div class="row g-6">
		            <div class="col-md-6">
		                <div class="card h-200px border border-gray-300">
		                    <div class="card-body d-flex justify-content-center align-items-center py-10">
		                        <img src="assets/media/signatures/sig-1.png" alt="Signature" class="h-150px" />
		                    </div>
		                </div>
		            </div>
		            <div class="col-md-6">
		                <div class="card h-200px border border-gray-300">
		                    <div class="card-body d-flex flex-column justify-content-center align-items-center text-center py-10">
		                        <span class="text-primary fw-bold mb-2">ชื่อ ผู้ขอเบิก</span>
		                        <span class="text-gray-800 fw-bold">Supaporn Sukthiamsuwan</span>
		                        <span class="text-muted mt-1">27 May 2026, 10:00</span>
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
		
		<div class="d-flex justify-content-between align-items-center mt-5 mb-10">
		    <div class="d-flex gap-3">
		        <button type="button" class="btn btn-light fw-bold px-8">Back</button>
		        <button type="button" class="btn btn-dark fw-bold px-8">Cancel</button>
		    </div>
		    <div class="d-flex gap-3">
		        <button type="button" class="btn btn-info fw-bold px-8">Save Draft</button>
		        <button type="button" class="btn btn-success fw-bold px-8">Submit PR</button>
		    </div>
		</div>
	</div>
		

	<script type="text/javascript">
	    $(document).ready(function() {
	        $(document).on('click', '.btn-toggle-detail', function() {
	            var $btn = $(this);
	            var $detailRow = $btn.closest('.pr-item-group').find('.pr-detail-row');
	            var $icon = $btn.find('i');
	            
	            $detailRow.slideToggle(300, function() {
	                if ($detailRow.is(':visible')) {
	                    $icon.removeClass('ki-down').addClass('ki-up');
	                } else {
	                    $icon.removeClass('ki-up').addClass('ki-down');
	                }
	            });
	        });
	    });
	    
		$('.select2-modal').select2({
		    dropdownParent: $('#createPrModal'),
		    minimumResultsForSearch: Infinity
		});

		$('#createPrModal').on('hidden.bs.modal', function () {
		    $(this).find('form')[0].reset();
		    $('.select2-modal').val(null).trigger('change'); 
		});
	
	    function deletePrItem(itemId, itemName) { 
	        Swal.fire({
	            title: 'Confirm Deletion',
	            text: "Are you sure you want to delete item: " + itemName + "?",
	            icon: 'warning',
	            showCancelButton: true,
	            customClass: { confirmButton: "btn btn-danger", cancelButton: "btn btn-secondary" },
	            reverseButtons: true,
	            confirmButtonText: 'Yes, delete it!',
	            cancelButtonText: 'Cancel'
	        }).then((result) => {
	            if (result.isConfirmed) {
	                window.location.href = "${pageContext.request.contextPath}/purchase_requisition_detail_delete?id=" + itemId; 
	            }
	        });
	    }
	</script>
</body>
</html>