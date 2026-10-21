<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="en_US" />
<tbody>

	<c:forEach items="${itemPrivileges}" var="item" varStatus="status">

		<tr>
			<!-- # -->
			<td class="text-center"><span class="fw-bold fs-7 text-gray-900">
					${status.count} </span></td>

			<!-- IMAGE -->
			<td>
				<div style="height: 120px; width: 120px; border-radius: 5px;"
					class="border border-gray-200 d-flex align-items-center justify-content-center overflow-hidden">

					<img src="${pageContext.request.contextPath}${item.coverPath}"
						alt="${item.itemName}"
						class="w-100 h-100 object-fit-cover rounded">

				</div>
			</td>

			<!-- ITEM NAME -->
			<td><span class="fw-normal fs-6 text-gray-900">
					${item.itemName} </span></td>

			<!-- DETAIL -->
			<td><span class="fw-normal fs-6 text-gray-900 details-truncate"
				style="overflow-wrap: anywhere; word-break: break-word; white-space: normal;">
					${item.details} </span></td>

			<!-- TOKEN -->
			<td><span class="fw-normal fs-6 text-gray-900 ps-2"> <fmt:formatNumber
						value="${item.token}" pattern="#,##0" />
			</span></td>

			<td><span class="fw-normal fs-6 text-gray-900 ps-2"> <fmt:formatNumber
						value="${item.addedMoney}" pattern="#,##0" />
			</span></td>

			<!-- QUANTITY -->
			<td><span class="fw-normal fs-6 text-gray-900">
					${item.quantity} </span></td>

			<!-- EFFECTIVE DATE -->
			<td>
				<div>
					<div class="fw-normal fs-6">
						<span class="text-gray-600">Start: </span><span
							class="text-gray-900"><fmt:formatDate
								value="${item.startDate}" pattern="dd MMM yyyy" /></span>
					</div>
					<div class="fw-normal fs-6">
						<span class="text-gray-600">End:</span> <span class="text-gray-900"><fmt:formatDate
								value="${item.endDate}" pattern="dd MMM yyyy" /></span>
					</div>
				</div>
			</td>

			<!-- ACTIVE -->
			<td class="text-center">
				<div
					class="form-check form-switch form-check-custom form-check-solid justify-content-center">

					<input class="form-check-input w-35px h-20px active-input"
						type="checkbox" data-item-id="${item.itemId}"
						${item.activeFlag == 'Y' ? 'checked' : ''} />

				</div>
			</td>

			<!-- ACTION -->
			<td class="text-center">
				<div class="d-flex justify-content-center gap-2">

					<a href="editRewardItem?itemId=${item.itemId}"
						class="btn btn-icon btn-sm btn-light-primary" title="Edit"> <i
						class="ki-duotone ki-pencil fs-4"> <span class="path1"></span>
							<span class="path2"></span>
					</i>

					</a>
					<button class="btn btn-icon btn-sm btn-light-danger deleteItemBtn"
						title="Delete" data-item-id="${item.itemId}">
						<i class="ki-duotone ki-trash fs-4"> <span class="path1"></span>
							<span class="path2"></span> <span class="path3"></span> <span
							class="path4"></span> <span class="path5"></span>
						</i>
					</button>

				</div>
			</td>

		</tr>

	</c:forEach>

</tbody>
