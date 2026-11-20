<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setLocale value="en_US" />

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="displayName" value="${not empty user.nameEN ? user.nameEN : (not empty user.name ? user.name : '-')}" />
<c:set var="workTypeText" value="${user.workType == 1 ? 'On-site' : (user.workType == 2 ? 'WFH' : 'Head Office')}" />

<div class="liff-shell">
<style>
.liff-home { --liff-home-abstract-opacity: .35; margin: calc(-1 * env(safe-area-inset-top, 0px)) calc(50% - min(50vw, 240px)) 0; container-type: inline-size; }
#profileDetail.liff-home { --liff-home-abstract-opacity: .2; }
.liff-home-head { position: relative; isolation: isolate; overflow: hidden; display: flex; justify-content: space-between; align-items: center; gap: 1rem; padding: calc(2rem + max(44px, env(safe-area-inset-top, 0px))) 19.5px calc(1.875rem + 32px); color: #071437; background: linear-gradient(119deg, #FCE8E9 30%, #D9232E 100%); }
.liff-home-head::before { content: ""; position: absolute; top: -227px; top: calc(100cqw * -227 / 393); right: 1px; bottom: 0; left: 0; z-index: -1; pointer-events: none; background: url('${ctx}/assets/media/svg/shapes/abstract-5.svg') center top / 151% auto no-repeat; opacity: var(--liff-home-abstract-opacity); }
.liff-profile-head::before { top: -158px; right: -20px; left: -8px; top: calc(100cqw * -158 / 393); right: calc(100cqw * -20 / 393); left: calc(100cqw * -8 / 393); }
.liff-profile-head { flex-direction: column; align-items: stretch; background: linear-gradient(151deg, #B91F28 20%, #D9232E 40%, #D9232E 65%, #FCE8E9 100%); }
#btnProfileBack.liff-back-btn { background: transparent; border-color: transparent; }
.liff-home-name { font-size: 22.75px; font-weight: 700; line-height: 1.21; overflow-wrap: anywhere; }
.liff-home-body { position: relative; margin-top: -32px; background: var(--bs-body-bg); border-radius: 32px 32px 0 0; padding: 19.5px 19.5px 0; display: flex; flex-direction: column; gap: 19.5px; }
.liff-home-card { border: 1px solid var(--bs-gray-200); border-radius: 16px; box-shadow: var(--bs-root-card-box-shadow); background: var(--bs-body-bg); overflow: hidden; }
.liff-profile-avatar { width: 65px; height: 65px; border-radius: 50%; object-fit: cover; border: 1px solid #FFFFFF; }
.liff-profile-avatar-lg { width: 90px; height: 90px; border: 2px solid var(--bs-gray-300); }
.liff-profile-initial { display: inline-flex; align-items: center; justify-content: center; background: var(--bs-primary-light); color: var(--bs-primary); font-weight: 600; font-size: 1.5rem; }
.liff-borrow-head { background: #FFF2F2; padding: 13px; display: flex; align-items: center; gap: .5rem; color: #071437; font-weight: 600; }
.liff-borrow-icon { width: 38px; height: 38px; border-radius: 7.6px; background: var(--bs-danger-light); display: inline-flex; align-items: center; justify-content: center; flex: none; }
.liff-token-card { background: url('${ctx}/assets/media/svg/shapes/wave-bg-red.svg') right top / cover no-repeat, conic-gradient(from 180deg at 50% 50%, #D9232E 0deg, #F04449 133.27deg, #F04449 221.54deg, #D9232E 360deg); color: #FFFFFF; }
.liff-token-num { font-weight: 600; line-height: 1.21; }
.liff-token-redeem { display: block; background: var(--bs-gray-100); color: var(--bs-red); border-radius: 50px; padding: 13px 26px; text-align: center; font-weight: 600; }
.liff-token-redeem:hover { color: var(--bs-red); }
.liff-info-row { display: flex; justify-content: space-between; align-items: center; gap: 1rem; padding: 1rem 0; border-bottom: 1px solid var(--bs-gray-200); }
.liff-info-row:last-child { border-bottom: 0; }
.liff-info-row .symbol-label .ki-duotone { font-size: 20px; }
.nav-line-tabs.liff-profile-tabs .nav-item .nav-link.active, .nav-line-tabs.liff-profile-tabs .nav-item .nav-link:hover:not(.disabled), .nav-line-tabs.liff-profile-tabs .nav-item.show .nav-link { color: var(--bs-red); border-bottom-color: var(--bs-red); }
.liff-info-row > span:last-child { text-align: right; min-width: 0; overflow-wrap: anywhere; }
.liff-borrow-row { padding-block: 19.5px; }
.liff-borrow-name { cursor: pointer; }
.liff-borrow-name:hover { color: var(--bs-gray-900); }
.liff-news-img { display: block; width: 100%; aspect-ratio: 16 / 9; object-fit: cover; }
.liff-news-img-blank { object-fit: contain; padding: 2rem; background: var(--bs-gray-100); }
.liff-news-carousel .carousel-indicators [data-bs-target] { width: 8px; height: 8px; margin: 0 4px; border: 0; border-radius: 4px; background-color: var(--bs-red); transition: width .3s ease, opacity .3s ease; }
.liff-news-carousel .carousel-indicators .active { width: 24px; }
</style>

	<!-- หน้า Home -->
	<div id="profileMain" class="liff-home">
		<div class="liff-home-head">
			<div class="d-flex flex-column gap-2 min-w-0">
				<span class="fs-6">Hello, Welcome to Cube</span>
				<span class="liff-home-name">${fn:escapeXml(displayName)}</span>
				<div class="d-flex flex-wrap gap-3">
					<c:choose>
						<c:when test="${user.enable eq '1'}"><span class="badge badge-lg badge-light-success fs-6">Active</span></c:when>
						<c:otherwise><span class="badge badge-lg badge-light-danger fs-6">Inactive</span></c:otherwise>
					</c:choose>
					<c:forEach var="site" items="${jobSite}">
						<span class="badge badge-lg badge-primary fs-6">${fn:escapeXml(site.name_site)}</span>
					</c:forEach>
				</div>
			</div>
			<button type="button" id="btnProfileDetail" class="btn p-0 border-0 flex-shrink-0" aria-label="Profile detail">
				<c:choose>
					<c:when test="${not empty userImgPath}">
						<img src="${fn:escapeXml(userImgPath)}" alt="${fn:escapeXml(displayName)}" class="liff-profile-avatar" onerror="this.nextElementSibling.classList.remove('d-none'); this.remove();">
						<span class="liff-profile-avatar liff-profile-initial d-none">${fn:escapeXml(fn:toUpperCase(fn:substring(displayName, 0, 1)))}</span>
					</c:when>
					<c:otherwise>
						<span class="liff-profile-avatar liff-profile-initial">${fn:escapeXml(fn:toUpperCase(fn:substring(displayName, 0, 1)))}</span>
					</c:otherwise>
				</c:choose>
			</button>
		</div>

		<div class="liff-home-body">

			<c:set var="actionCount" value="0" />
			<c:forEach var="item" items="${borrowList}">
				<c:if test="${(item.status == 'B' and not empty item.user_delivery and empty item.user_receive and empty item.user_return and empty item.user_return_receive)
					or (item.status == 'T' and not empty item.user_delivery and not empty item.user_receive and empty item.user_return and empty item.user_return_receive)}">
					<c:set var="actionCount" value="${actionCount + 1}" />
				</c:if>
			</c:forEach>
			<div class="liff-home-card">
				<div class="liff-borrow-head fs-3 justify-content-between">
					<span>Action Required</span>
					<span class="badge badge-danger badge-circle">${actionCount}</span>
				</div>
				<div class="d-flex flex-column gap-4 p-6">
					<c:if test="${actionCount == 0}">
						<div class="text-center text-gray-600 fs-7 py-3">No action required</div>
					</c:if>
					<c:forEach var="item" items="${borrowList}">
						<c:set var="needReceive" value="${item.status == 'B' and not empty item.user_delivery and empty item.user_receive and empty item.user_return and empty item.user_return_receive}" />
						<c:set var="needReturn" value="${item.status == 'T' and not empty item.user_delivery and not empty item.user_receive and empty item.user_return and empty item.user_return_receive}" />
						<c:if test="${needReceive or needReturn}">
							<div class="liff-borrow-action-row d-flex align-items-center gap-3">
								<span class="liff-borrow-icon"><i class="ki-duotone ki-laptop fs-2 text-danger"><span class="path1"></span><span class="path2"></span></i></span>
								<div class="d-flex flex-column flex-grow-1 min-w-0">
									<a href="javascript:void(0)" class="liff-borrow-name d-block fs-6 fw-semibold text-gray-900 text-decoration-none text-truncate">${empty item.name ? '-' : fn:escapeXml(item.name)}</a>
									<span class="d-flex align-items-center gap-1 fs-7 text-gray-800"><i class="ki-duotone ki-calendar-2 fs-6"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i><fmt:formatDate value="${item.time_create}" pattern="d MMM yy, HH:mm" /></span>
								</div>
								<button type="button" class="liff-borrow-action btn btn-sm btn-success flex-shrink-0" data-borrow-id="${item.borrow_id}">${needReceive ? 'Confirm Receive' : 'Return'}</button>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>

			<div class="liff-home-card liff-token-card">
				<div class="d-flex flex-column gap-5 px-4 py-5">
					<div class="d-flex justify-content-between align-items-center gap-3">
						<span class="d-flex align-items-center gap-2 fs-3 fw-semibold"><i class="ki-duotone ki-cube-2 fs-2 text-white"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>My Cube Token</span>
						<span id="tokenRank" class="badge badge-light fs-5 text-gray-800"><span class="liff-skel w-80px"></span></span>
					</div>
					<div class="d-flex">
						<div class="d-flex flex-column flex-grow-1 gap-5">
							<span class="fs-5">This Year (<span id="yearlyCubeToken-year"></span>)</span>
							<span class="liff-token-num fs-1"><span id="tokenYearly">-</span> <span class="fs-7 fw-normal">Token</span></span>
						</div>
						<div class="d-flex flex-column flex-grow-1 gap-5">
							<span class="fs-5">Total</span>
							<span class="liff-token-num fs-1"><span id="tokenTotal">-</span> <span class="fs-7 fw-normal">Token</span></span>
						</div>
					</div>
					<a href="${ctx}/privilegePage" class="liff-token-redeem fs-5">Go to Redeem</a>
				</div>
			</div>

			<a href="${ctx}/line_cubeTokenRankingPage" class="liff-home-card d-block text-reset" onclick="liffShowLoading();">
				<jsp:include page="/pages-line/cube_token/liff_token_ranking_card.jsp" />
			</a>

			<jsp:useBean id="newsNow" class="java.util.Date" />
			<fmt:formatDate var="newsToday" value="${newsNow}" pattern="yyyy-MM-dd" />
			<c:set var="newsCount" value="0" />
			<c:forEach var="ann" items="${announcementList}">
				<fmt:formatDate var="annDateStr" value="${ann.announcement_date}" pattern="yyyy-MM-dd" />
				<c:if test="${newsCount < 3 and ann.status ne '0' and annDateStr <= newsToday}">
					<c:set var="newsCount" value="${newsCount + 1}" />
				</c:if>
			</c:forEach>
			<c:if test="${newsCount > 0}">
					<div class="d-flex justify-content-between align-items-center">
						<span class="d-flex align-items-center gap-2 fs-1 fw-bold lh-1 text-gray-800"><i class="ki-duotone ki-satellite fs-2 text-danger"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span><span class="path6"></span></i>News</span>
					</div>
					<div id="newsCarousel" class="carousel slide liff-news-carousel" data-bs-touch="true" data-bs-interval="false">
						<div class="carousel-inner">
							<c:set var="newsIdx" value="0" />
							<c:forEach var="ann" items="${announcementList}">
								<fmt:formatDate var="annDateStr" value="${ann.announcement_date}" pattern="yyyy-MM-dd" />
								<c:if test="${newsIdx < 3 and ann.status ne '0' and annDateStr <= newsToday}">
									<div class="carousel-item ${newsIdx == 0 ? 'active' : ''}">
										<a href="${ctx}/announcementRead?id=${ann.announcementId}" class="liff-home-card d-block text-reset position-relative">
											<c:if test="${newsIdx == 0}"><span class="badge badge-lg badge-danger position-absolute top-0 end-0 mt-4 me-4">New</span></c:if>
											<c:choose>
												<c:when test="${not empty ann.fileUpload and not empty ann.fileUpload.path}">
													<img src="${fn:escapeXml(ann.fileUpload.path)}" alt="${fn:escapeXml(ann.topic)}" class="liff-news-img" draggable="false" onerror="this.onerror=null; this.src='${ctx}/assets/media/svg/files/blank-image.svg'; this.classList.add('liff-news-img-blank');">
												</c:when>
												<c:otherwise>
													<img src="${ctx}/assets/media/svg/files/blank-image.svg" alt="${fn:escapeXml(ann.topic)}" class="liff-news-img liff-news-img-blank" draggable="false">
												</c:otherwise>
											</c:choose>
											<div class="d-flex flex-column gap-2 p-5">
												<span class="fs-6 fw-bold text-gray-800">${fn:escapeXml(ann.topic)}</span>
												<span class="d-flex align-items-center gap-1 fs-7 text-gray-600"><i class="ki-duotone ki-calendar-2 fs-6"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span><span class="path5"></span></i><fmt:formatDate value="${ann.announcement_date}" pattern="d MMM yyyy" /></span>
											</div>
										</a>
									</div>
									<c:set var="newsIdx" value="${newsIdx + 1}" />
								</c:if>
							</c:forEach>
						</div>
						<c:if test="${newsCount > 1}">
							<div class="carousel-indicators position-relative m-0 mt-3">
								<c:forEach begin="0" end="${newsCount - 1}" var="i">
									<button type="button" data-bs-target="#newsCarousel" data-bs-slide-to="${i}" class="${i == 0 ? 'active' : ''}" aria-label="News ${i + 1}" ${i == 0 ? 'aria-current="true"' : ''}></button>
								</c:forEach>
							</div>
						</c:if>
					</div>
			</c:if>

		</div>
	</div>

	<!-- หน้า My Profile -->
	<div id="profileDetail" class="liff-home d-none">
		<div class="liff-home-head liff-profile-head">
			<div class="d-flex align-items-center gap-3">
				<a href="javascript:void(0)" id="btnProfileBack" class="liff-back-btn" aria-label="Back">
					<i class="ki-duotone ki-arrow-left fs-3 text-white"><span class="path1"></span><span class="path2"></span></i>
				</a>
				<h1 class="liff-page-title text-white mb-0 flex-grow-1">My Profile</h1>
			</div>
		</div>

		<div class="liff-home-body">
			<div class="liff-home-card p-6">
				<div class="d-flex justify-content-between align-items-center gap-3">
					<div class="d-flex flex-column gap-3 min-w-0">
						<span class="fs-2 fw-semibold text-gray-900 text-break">${fn:escapeXml(displayName)}</span>
						<span class="fs-6 text-gray-600">${fn:escapeXml(user.employeeId)}<c:if test="${not empty user.name}"> - ${fn:escapeXml(user.name)}</c:if></span>
						<div class="d-flex flex-wrap gap-3">
							<c:choose>
								<c:when test="${user.enable eq '1'}"><span class="badge badge-lg badge-light-success fs-6">Active</span></c:when>
								<c:otherwise><span class="badge badge-lg badge-light-danger fs-6">Inactive</span></c:otherwise>
							</c:choose>
							<c:forEach var="site" items="${jobSite}">
								<span class="badge badge-lg badge-primary fs-6">${fn:escapeXml(site.name_site)}</span>
							</c:forEach>
						</div>
					</div>
					<c:choose>
						<c:when test="${not empty userImgPath}">
							<img src="${fn:escapeXml(userImgPath)}" alt="${fn:escapeXml(displayName)}" class="liff-profile-avatar liff-profile-avatar-lg flex-shrink-0" onerror="this.nextElementSibling.classList.remove('d-none'); this.remove();">
							<span class="liff-profile-avatar liff-profile-avatar-lg liff-profile-initial flex-shrink-0 d-none">${fn:escapeXml(fn:toUpperCase(fn:substring(displayName, 0, 1)))}</span>
						</c:when>
						<c:otherwise>
							<span class="liff-profile-avatar liff-profile-avatar-lg liff-profile-initial flex-shrink-0">${fn:escapeXml(fn:toUpperCase(fn:substring(displayName, 0, 1)))}</span>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div class="liff-home-card p-6">
				<ul class="nav nav-stretch nav-line-tabs nav-line-tabs-2x liff-profile-tabs mb-5 fs-5 fw-bold">
					<li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#tabOverall">Overall</a></li>
					<li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#tabBorrow">Borrow</a></li>
					<li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#tabSecurity">Security</a></li>
				</ul>

				<div class="tab-content fs-6">
					<div class="tab-pane fade show active" id="tabOverall" role="tabpanel">
						<div class="liff-info-row">
							<span class="d-flex align-items-center gap-3"><span class="symbol symbol-35px symbol-circle"><span class="symbol-label bg-light-primary"><i class="ki-duotone ki-medal-star text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i></span></span><span class="text-gray-600">Department</span></span>
							<span class="fw-semibold text-gray-800">${empty user.departmentId ? 'NONE' : fn:escapeXml(user.departmentId)}</span>
						</div>
						<div class="liff-info-row">
							<span class="d-flex align-items-center gap-3"><span class="symbol symbol-35px symbol-circle"><span class="symbol-label bg-light-primary"><i class="ki-duotone ki-award text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></span></span><span class="text-gray-600">Position</span></span>
							<span class="fw-semibold text-gray-800">${empty user.positionId ? 'NONE' : fn:escapeXml(user.positionId)}</span>
						</div>
						<div class="liff-info-row">
							<span class="d-flex align-items-center gap-3"><span class="symbol symbol-35px symbol-circle"><span class="symbol-label bg-light-primary"><i class="ki-duotone ki-calendar text-primary"><span class="path1"></span><span class="path2"></span></i></span></span><span class="text-gray-600"><c:choose><c:when test="${not empty user.startDate}"><fmt:formatDate value="${user.startDate}" pattern="d MMM yyyy" /></c:when><c:otherwise>-</c:otherwise></c:choose></span></span>
							<span class="fw-semibold text-gray-800">${empty workPeriod ? '-' : fn:escapeXml(workPeriod)}</span>
						</div>
						<div class="liff-info-row">
							<span class="d-flex align-items-center gap-3"><span class="symbol symbol-35px symbol-circle"><span class="symbol-label bg-light-primary"><i class="ki-duotone ki-geolocation text-primary"><span class="path1"></span><span class="path2"></span></i></span></span><span class="text-gray-600">${user.onsiteNum == 3 ? '4–5 Day' : user.onsiteNum == 2 ? '2–3 Day' : user.onsiteNum == 1 ? '0.5–1 Day' : '-'}</span></span>
							<span class="fw-semibold text-gray-800">${workTypeText}</span>
						</div>
						<div class="liff-info-row">
							<span class="d-flex align-items-center gap-3"><span class="symbol symbol-35px symbol-circle"><span class="symbol-label bg-light-primary"><i class="ki-duotone ki-brifecase-timer text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i></span></span><span class="text-gray-600">${fn:escapeXml(user.workTimeStart)} - ${fn:escapeXml(user.workTimeEnd)}</span></span>
							<span class="fw-semibold text-gray-800">${user.workDayStart == 1 ? 'Mon' :
								user.workDayStart == 2 ? 'Tue' :
								user.workDayStart == 3 ? 'Wed' :
								user.workDayStart == 4 ? 'Thu' :
								user.workDayStart == 5 ? 'Fri' :
								user.workDayStart == 6 ? 'Sat' :
								user.workDayStart == 7 ? 'Sun' : ''}
								${user.workDayEnd == 1 ? '- Mon' :
								user.workDayEnd == 2 ? '- Tue' :
								user.workDayEnd == 3 ? '- Wed' :
								user.workDayEnd == 4 ? '- Thu' :
								user.workDayEnd == 5 ? '- Fri' :
								user.workDayEnd == 6 ? '- Sat' :
								user.workDayEnd == 7 ? '- Sun' : ''}</span>
						</div>
						<div class="liff-info-row">
							<span class="d-flex align-items-center gap-3"><span class="symbol symbol-35px symbol-circle"><span class="symbol-label bg-light-primary"><i class="ki-duotone ki-security-user text-primary"><span class="path1"></span><span class="path2"></span></i></span></span><span class="text-gray-600">Manager</span></span>
							<span class="fw-semibold text-gray-800">${empty manager.managerNameEn ? 'NONE' : fn:escapeXml(manager.managerNameEn)}</span>
						</div>
					</div>

					<div class="tab-pane fade" id="tabBorrow" role="tabpanel">
						<c:choose>
							<c:when test="${empty borrowList}">
								<div class="text-center py-10">
									<div class="d-inline-flex align-items-center justify-content-center rounded-circle bg-light-primary mb-4 liff-empty-icon">
										<i class="ki-duotone ki-package text-primary"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
									</div>
									<div class="fs-6 fw-semibold text-gray-800">No borrow records found</div>
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach var="item" items="${borrowList}" varStatus="borrowStatus">
									<c:if test="${not borrowStatus.first}"><div class="separator"></div></c:if>
									<div class="d-flex flex-column gap-2 liff-borrow-row">
										<div class="d-flex justify-content-between align-items-start gap-3">
											<div class="d-flex flex-column flex-grow-1 min-w-0">
												<span class="fs-5 fw-bold text-gray-900 text-truncate">${empty item.name ? '-' : fn:escapeXml(item.name)}</span>
												<span class="fs-7 text-gray-500">${empty item.item_no ? '-' : fn:escapeXml(item.item_no)}</span>
											</div>
											<c:choose>
												<c:when test="${item.status == 'R'}"><span class="badge badge-lg bg-success text-white fs-6 py-2 flex-shrink-0">Returned</span></c:when>
												<c:when test="${item.status == 'B'}"><span class="badge badge-lg bg-warning text-white fs-6 py-2 flex-shrink-0">Borrowing</span></c:when>
												<c:when test="${item.status == 'W'}"><span class="badge badge-lg badge-secondary text-dark fs-6 py-2 flex-shrink-0">Waiting</span></c:when>
												<c:when test="${item.status == 'C'}"><span class="badge badge-lg bg-dark text-white fs-6 py-2 flex-shrink-0">Cancel</span></c:when>
												<c:when test="${item.status == 'T'}"><span class="badge badge-lg bg-warning text-white fs-6 py-2 flex-shrink-0">Waiting for Return</span></c:when>
												<c:otherwise><span class="badge badge-lg bg-light-secondary text-gray-600 fs-6 py-2 flex-shrink-0">-</span></c:otherwise>
											</c:choose>
										</div>
										<div class="d-flex align-items-center justify-content-between flex-wrap column-gap-4 row-gap-1 fs-7 text-gray-600">
											<span class="d-flex align-items-center gap-2"><i class="ki-duotone ki-geolocation fs-5"><span class="path1"></span><span class="path2"></span></i>${empty item.location ? '-' : fn:escapeXml(item.location)}</span>
											<span class="d-flex align-items-center gap-2"><i class="ki-duotone ki-calendar fs-5"><span class="path1"></span><span class="path2"></span></i><c:choose><c:when test="${empty item.time_create}">-</c:when><c:otherwise><fmt:formatDate value="${item.time_create}" pattern="d MMM yy, HH:mm" /></c:otherwise></c:choose></span>
										</div>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>

					<div class="tab-pane fade" id="tabSecurity" role="tabpanel">
						<div class="text-center text-gray-600 fs-7 py-6">-</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Popup Notification (Received / Return) -->
	<c:if test="${actionCount > 0}">
	<div class="modal fade" id="notificationModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header border-0 pb-0">
					<h3 class="modal-title text-gray-900">Notification</h3>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body d-flex flex-column gap-5 p-5">
					<span class="fs-3 fw-bold text-gray-900">ตรวจพบอุปกรณ์รอตอบรับ</span>

					<div class="d-flex flex-column gap-3">
						<span class="fs-4 fw-semibold text-gray-800">Signature</span>
						<jsp:include page="/pages-line/common/liff_signature_pad.jsp">
							<jsp:param name="signatureUrl" value="${imgPathSignature}" />
							<jsp:param name="editable" value="true" />
						</jsp:include>
					</div>

					<c:forEach var="item" items="${borrowList}">
						<c:set var="needReceive" value="${item.status == 'B' and not empty item.user_delivery and empty item.user_receive and empty item.user_return and empty item.user_return_receive}" />
						<c:set var="needReturn" value="${item.status == 'T' and not empty item.user_delivery and not empty item.user_receive and empty item.user_return and empty item.user_return_receive}" />
						<c:if test="${needReceive or needReturn}">
							<div class="liff-borrow-modal-item d-flex flex-column gap-4 border border-warning rounded-2 p-4" data-borrow-id="${item.borrow_id}">
								<div class="d-flex align-items-center gap-3">
									<span class="liff-borrow-icon">
										<c:choose>
											<c:when test="${item.type eq 'c'}"><i class="ki-duotone ki-laptop fs-2 text-danger"><span class="path1"></span><span class="path2"></span></i></c:when>
											<c:when test="${item.type eq 'in'}"><i class="ki-duotone ki-keyboard fs-2 text-danger"><span class="path1"></span><span class="path2"></span></i></c:when>
											<c:when test="${item.type eq 'L' or item.type eq 'sl'}"><i class="ki-duotone ki-verify fs-2 text-danger"><span class="path1"></span><span class="path2"></span></i></c:when>
											<c:when test="${item.type eq 'Mob'}"><i class="ki-duotone ki-phone fs-2 text-danger"><span class="path1"></span><span class="path2"></span></i></c:when>
											<c:when test="${item.type eq 'p'}"><i class="ki-duotone ki-wifi-square fs-2 text-danger"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i></c:when>
											<c:otherwise><i class="ki-duotone ki-dots-square fs-2 text-danger"><span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span></i></c:otherwise>
										</c:choose>
									</span>
									<div class="d-flex flex-column min-w-0">
										<span class="fs-6 fw-semibold text-gray-900 text-break">${fn:escapeXml(item.item_no)} ${fn:escapeXml(item.name)}</span>
										<c:choose>
											<c:when test="${needReceive}"><span class="fs-7 text-gray-700">ส่งมอบ : <fmt:formatDate value="${item.time_delivery}" pattern="dd MMM yyyy" /></span></c:when>
											<c:otherwise><span class="fs-7 text-gray-700">ขอคืน : <fmt:formatDate value="${item.time_update}" pattern="dd MMM yyyy" /></span></c:otherwise>
										</c:choose>
									</div>
								</div>
								<c:choose>
									<c:when test="${needReceive}"><button type="button" class="btn btn-success btnReceived w-100" data-id="${item.borrow_id}" <c:if test="${empty imgPathSignature}">disabled</c:if>>Received</button></c:when>
									<c:otherwise><button type="button" class="btn btn-success btnReturn w-100" data-id="${item.borrow_id}" <c:if test="${empty imgPathSignature}">disabled</c:if>>Return</button></c:otherwise>
								</c:choose>
							</div>
						</c:if>
					</c:forEach>
				</div>
				<div class="modal-footer border-0 pt-0">
					<button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
				</div>
			</div>
		</div>
	</div>
	</c:if>

	<div id="liffLoadingOverlay" class="liff-loading-overlay liff-loading-delayed" style="z-index:1060;">
		<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>
	</div>

</div>

<script type="text/javascript">
(function () {
	var ctx = '${ctx}';
	var year = new Date().getFullYear();
	$('#yearlyCubeToken-year').text(year);

	var newsCarousel = document.getElementById('newsCarousel');
	if (newsCarousel) bootstrap.Carousel.getOrCreateInstance(newsCarousel, { interval: false, touch: true });

	function showMain(show) {
		$('#profileMain').toggleClass('d-none', !show);
		$('#profileDetail').toggleClass('d-none', show);
		window.scrollTo(0, 0);
	}
	$('#btnProfileDetail').on('click', function () {
		showMain(false);
		var tabEl = document.querySelector('#profileDetail a[href="#tabOverall"]');
		if (tabEl) tabEl.click();
	});
	$('#btnProfileBack').on('click', function () { showMain(true); });

	$('#profileMain').on('click', '.liff-borrow-name', function () {
		showMain(false);
		var tabEl = document.querySelector('#profileDetail a[href="#tabBorrow"]');
		if (tabEl) tabEl.click();
	});

	$('#profileMain').on('click', '.liff-borrow-action', function () {
		var modalElement = document.getElementById('notificationModal');
		if (!modalElement) return;
		var borrowId = String($(this).data('borrow-id'));
		$(modalElement).find('.liff-borrow-modal-item').each(function () {
			$(this).toggleClass('d-none', String($(this).data('borrow-id')) !== borrowId);
		});
		bootstrap.Modal.getOrCreateInstance(modalElement).show();
	});

	function hideLoading() {
		$('#liffLoadingOverlay').hide();
	}

	window.addEventListener('pageshow', function (e) {
		if (e.persisted) hideLoading();
	});

	var hasSignature = ${not empty imgPathSignature ? 'true' : 'false'};
	var canvas = document.getElementById('sigCanvas');
	var sigPad = canvas ? liffSignaturePad(canvas, setBorrowButtonsReady) : null;

	function setBorrowButtonsReady() {
		$('.btnReceived, .btnReturn').prop('disabled', !(hasSignature || (sigPad && sigPad.isSigned())));
	}

	if (sigPad) {
		document.getElementById('notificationModal').addEventListener('shown.bs.modal', sigPad.clear);
	}

	function getSignatureBlob() {
		return new Promise(function (resolve) {
			if (hasSignature || !sigPad) { resolve(null); return; }
			sigPad.toBlob().then(resolve);
		});
	}

	function saveSignature() {
		return getSignatureBlob().then(function (blob) {
			if (!blob) return;
			var formData = new FormData();
			formData.append('fileUpload', blob, 'signature.png');
			return fetch(ctx + '/update_signature', { method: 'POST', body: formData })
				.then(function (res) { if (!res.ok) throw new Error(res.status); });
		});
	}

	function postBorrowAction(url, borrowId, errorText) {
		var failText = 'Unable to save your signature. Please try again.';
		var failTitle = 'Save failed';
		liffShowLoading();
		saveSignature()
			.then(function () {
				failText = errorText;
				failTitle = 'Error';
				return fetch(url, {
					method: 'POST',
					headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
					body: 'id=' + encodeURIComponent(borrowId)
				});
			})
			.then(function () { location.reload(); })
			.catch(function () {
				hideLoading();
				liffToastError(failText, failTitle);
			});
	}

	//----- Received -----
	$(document).on('click', '.btnReceived', function (e) {
		e.preventDefault();
		var borrowId = $(this).data('id');
		Swal.fire({
			title: 'Are you sure?!',
			text: 'Have you received this equipment?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonText: 'Yes, received it',
			cancelButtonText: 'Cancel',
			buttonsStyling: false,
			customClass: { confirmButton: 'btn btn-success', cancelButton: 'btn btn-secondary' }
		}).then(function (result) {
			if (result.isConfirmed) postBorrowAction(ctx + '/received_equipment.action', borrowId, 'Failed to received equipment');
		});
	});

	//----- Return -----
	$(document).on('click', '.btnReturn', function (e) {
		e.preventDefault();
		var borrowId = $(this).data('id');
		Swal.fire({
			title: 'Confirm Return?',
			text: 'Confirm that you have returned this equipment.',
			icon: 'question',
			showCancelButton: true,
			confirmButtonText: 'Yes, returned',
			cancelButtonText: 'Cancel',
			buttonsStyling: false,
			customClass: { confirmButton: 'btn btn-success', cancelButton: 'btn btn-secondary' }
		}).then(function (result) {
			if (result.isConfirmed) postBorrowAction(ctx + '/return_equipment.action', borrowId, 'Failed to return equipment');
		});
	});

	function rankText(data) {
		var raw = String(data || '--').replace('#', '');
		if (!/^\d+$/.test(raw)) { return raw; }
		var n = Number(raw), mod100 = n % 100, suffix = 'th';
		if (mod100 < 11 || mod100 > 13) { suffix = ({ 1: 'st', 2: 'nd', 3: 'rd' })[n % 10] || 'th'; }
		return n + suffix;
	}

	function formatToken(value) {
		if (value === null || value === undefined) {
			return "0";
		}
		var number = Number(value);
		if (Number.isNaN(number)) {
			return "0";
		}
		return number.toLocaleString("en-US", {
			minimumFractionDigits: 0,
			maximumFractionDigits: 2
		});
	}

	function loadSummary() {
		$.ajax({ url: ctx + '/tokenSummary', type: 'GET', data: { year: year }, dataType: 'json' })
			.done(function (res) {
				if (!res.success || !res.data) { return failSummary(); }
				$('#tokenYearly').text(formatToken(res.data.yearlyToken));
				$('#tokenTotal').text(formatToken(res.data.accumulatedToken));
			})
			.fail(failSummary);
	}
	function failSummary() {
		$('#tokenYearly, #tokenTotal').text('-');
		liffToastError('Unable to load Cube Token. Please try again.', 'Load failed');
	}

	function loadRank() {
		$.ajax({ url: ctx + '/getUserCurrentRank', type: 'GET', data: { year: year }, dataType: 'json' })
			.done(function (res) { $('#tokenRank').text('My rank is ' + (res.success ? rankText(res.data) : '-')); })
			.fail(function () { $('#tokenRank').text('My rank is -'); });
	}

	function loadTop3() {
		$.ajax({ url: ctx + '/getTokenRanking', type: 'GET', data: { year: year }, dataType: 'json' })
			.done(function (res) {
				liffTokenTop3('#leaderboardTop3', (res.success && res.data) ? res.data : []);
			})
			.fail(function () {
				$('#leaderboardTop3').empty().append('<div class="text-center text-gray-600 fs-7 py-6">-</div>');
				liffToastError('Unable to load the leaderboard. Please try again.', 'Load failed');
			});
	}

	loadSummary();
	loadRank();
	loadTop3();
})();
</script>
