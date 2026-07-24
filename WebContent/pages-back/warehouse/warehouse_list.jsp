<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/assets/css/style.bundle.css"
	rel="stylesheet" />
<style>
.toggle-folder i {
    display: inline-block;
    transition: transform .2s ease;
}

.toggle-folder i.expanded {
    transform: rotate(90deg);
}
</style>
</head>
<body>

	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_toolbar" class="app-toolbar py-3 py-lg-6">
			<div id="kt_app_toolbar_container"
				class="app-container container-fluid d-flex flex-stack">
				<div
					class="page-title d-flex flex-column justify-content-center flex-wrap me-3">
					<h1
						class="page-heading d-flex text-gray-700 fw-semibold flex-column justify-content-center my-0">
						Warehouse</h1>
					<ul
						class="breadcrumb breadcrumb-separatorless fw-semibold fs-7 my-0 pt-1">
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/check_in_out"
							class="text-muted text-hover-primary">Home</a></li>
						<li class="breadcrumb-item"><span
							class="bullet bg-gray-500 w-5px h-2px"></span></li>
						<li class="breadcrumb-item text-muted"><a
							href="${pageContext.request.contextPath}/warehouse_list"
							class="text-muted text-hover-primary">Warehouse</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div id="kt_app_content" class="app-content flex-column-fluid">
			<div id="kt_app_content_container"
				class="app-container container-fluid">

				<div class="card card-flush ">

					<div class="card-header">
						<div class="card-title">
							<h3 class="fw-semibold text-gray-900">Cube Center</h3>
						</div>
						<div class="card-toolbar">
							<button
								class="btn btn-success py-3 px-6 d-inline-flex align-items-center gap-1"
								data-bs-toggle="modal" data-bs-target="#createWarehouseModal">
								<i class="ki-duotone ki-plus fs-4"> </i> <span>Create</span>
							</button>
						</div>
					</div>

					<div class="modal fade" tabindex="-1" id="createWarehouseModal">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header border-0">
									<h2 class="modal-title fw-semibold">Warehouse</h2>

									<!--begin::Close-->
									<div class="btn btn-icon btn-sm btn-active-light-primary ms-2"
										data-bs-dismiss="modal" aria-label="Close">
										<i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span
											class="path2"></span></i>
									</div>
									<!--end::Close-->
								</div>

								<div class="modal-body">
									<div class="row g-8 mb-8">
										<div class="col-md-12 create-warehouse-validate-container">
											<label for="Warehouse Name" class="form-label required">Warehouse
												Name</label> <input type="text" class="form-control form-control-lg"
												id="name-create" placeholder="ชั้นที่ 2" required />
										</div>
										<div class="col-md-12 ">
											<label for="Description" class="form-label">
												Description </label>
											<textarea class="form-control" data-kt-autosize="true"
												id="desc-create"></textarea>
										</div>

									</div>
								</div>

								<div class="modal-footer border-0">
									<button type="button" class="btn btn-light"
										data-bs-dismiss="modal">Close</button>
									<button type="button" id="saveIndustryBtn"
										class="btn btn-success">Save</button>
								</div>
							</div>
						</div>
					</div>

					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-striped align-middle table-hover"
								id="kt_datatable_zero_configuration">
								<thead>
									<tr class="text-gray-500 fs-7 fw-semibold text-uppercase">
										<th class="ps-6">Name</th>
										<th>Description</th>
										<th>
											<div
												class="d-flex justify-content-end aling-items-center pe-4">
												Action</div>
										</th>
									</tr>
								</thead>

								<tbody class="ps-3">
                                    <!-- Rows will be dynamically generated here -->
								</tbody>

							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		const warehouseList = [
				<c:forEach items="${warehouseList}" var="wh" varStatus="s">
					{
					    id: ${wh.warehouseId},
					    parentId: ${wh.parent},
					    name: "${fn:escapeXml(wh.warehouseName)}",
					    description: "${fn:escapeXml(wh.description)}"
					}<c:if test="${!s.last}">,</c:if>
				</c:forEach>
			];
		
		const warehouseState = {
			    tree: [],
			    map: {},
			    expanded: new Set()
		};
		
		function initWarehouse(data){

		    warehouseState.tree = buildTree(data);

		    renderWarehouse();

		}
		
		function buildTree(data){

		    const map = {};
		    const roots = [];

		    data.forEach(item => {

		        map[item.id] = {
		            ...item,
		            children:[]
		        };

		    });

		    data.forEach(item=>{

		        if(item.parentId===0){

		            roots.push(map[item.id]);

		        }else{

		            map[item.parentId]?.children.push(map[item.id]);

		        }

		    });

		    warehouseState.map = map;

		    return roots;

		}
		
		function renderWarehouse(){

		    const tbody=$("#kt_datatable_zero_configuration tbody");

		    tbody.html(renderNodes(warehouseState.tree));

		}
		
		function renderNodes(nodes,level=0){

		    let html="";

		    nodes.forEach(node=>{

		        html+=renderRow(node,level);

		        if(node.children.length){

		            html+=renderNodes(node.children,level+1);

		        }

		    });

		    return html;
		}
		
		function isVisible(node) {

		    if (node.parentId === 0) {
		        return true;
		    }

		    let current = node;

		    while (current.parentId !== 0) {

		        if (!warehouseState.expanded.has(current.parentId)) {
		            return false;
		        }

		        current = warehouseState.map[current.parentId];
		    }

		    return true;
		}
		
		function renderRow(node,level){

		    const hasChildren=node.children.length>0;

		    const visible = isVisible(node);

		    const expanded=
		        warehouseState.expanded.has(node.id);

		    return `
					<tr
					    class="\${visible?'':'d-none'}"
					    data-id="\${node.id}"
					    data-parent="\${node.parentId}"
					>
			
						<td>
							<div class="d-flex align-items-center"
							style="padding-left:\${level*40+12}px">
								\${
									hasChildren?
									`
										<span class="toggle-folder me-2 cursor-pointer">
											<i class="ki-duotone ki-right fs-5 \${expanded?'expanded':''}"></i>
										</span>
									`
									:
										
									`<span style="width:22px"></span>`
									}
							
									<i class="ki-duotone ki-folder fs-2x me-5">
										<span class="path1"></span>
										<span class="path2"></span>
									</i>
									\${node.name}
							</div>
						</td>
				
						<td>\${node.description||"-"}</td>
				
						<td>
		                	<div class="d-flex justify-content-end aling-items-center gap-2 pe-3">
			                	<button class="btn btn-icon btn-light-success w-35px h-35px" data-bs-toggle="modal" data-bs-target="#createWarehouseModal">
				                	<i class="ki-duotone ki-plus fs-2">
				                	</i>
			                	</button>
			                    <button class="btn btn-icon btn-light-primary w-35px h-35px" data-bs-toggle="modal" data-bs-target="#createWarehouseModal">
				                    <i class="ki-duotone ki-pencil fs-2">
					                    <span class="path1"></span>
					                    <span class="path2"></span>
				                   	</i>
			                	</button>
			                    <button class="btn btn-icon btn-light-danger w-35px h-35px">
				                    <i class="ki-duotone ki-trash fs-2">
					                    <span class="path1"></span>
					                    <span class="path2"></span>
					                    <span class="path3"></span>
					                    <span class="path4"></span>
					                    <span class="path5"></span>
				                   	</i>
			                	</button>
		                	</div>
		                </td>
					</tr>
				`;
		}
		
		function toggleChildren(parentId, show) {

		    const children = $(`tr[data-parent='\${parentId}']`);
		    console.log(parentId, children.length);

		    children.each(function () {

		        const row = $(this);
		        const childId = row.data("id");

		        if (show) {

		            row
		                .stop(true, true)
		                .removeClass("d-none")
		                .css({
		                    display: "table-row",
		                    opacity: 0
		                })
		                .animate({
		                    opacity: 1
		                }, 180);

		            if (warehouseState.expanded.has(childId)) {
		                toggleChildren(childId, true);
		            }

		        } else {

		            toggleChildren(childId, false);

		            row
		                .stop(true, true)
		                .animate({
		                    opacity: 0
		                }, 180, function () {

		                    row
		                        .addClass("d-none")
		                        .css({
		                            opacity: "",
		                            display: ""
		                        });

		                });
		        }

		    });

		}
		
		
		
		$(document).on("click", ".toggle-folder", function () {

		    const row = $(this).closest("tr");
		    const id = row.data("id");
		    const icon = $(this).find("i");

		    if (warehouseState.expanded.has(id)) {

		        warehouseState.expanded.delete(id);

		        icon.removeClass("expanded");

		        toggleChildren(id, false);

		    } else {

		        warehouseState.expanded.add(id);

		        icon.addClass("expanded");

		        toggleChildren(id, true);

		    }

		});
		
		$(document).ready(function () {
            initWarehouse(warehouseList);
        });
		
		

	</script>
</body>
</html>