<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<div class="liff-shell">
<style>
.liff-home { margin: calc(-1 * env(safe-area-inset-top, 0px)) calc(50% - min(50vw, 240px)) 0; container-type: inline-size; min-height: 100vh; background: linear-gradient(180deg, #D9232E 18.27%, #FFFFFF 42.31%); }
.liff-home-head { position: relative; isolation: isolate; overflow: hidden; display: flex; flex-direction: column; align-items: stretch; gap: 1rem; padding: calc(2rem + max(44px, env(safe-area-inset-top, 0px))) 19.5px 1.5rem; }
.liff-home-head::before { content: ""; position: absolute; top: calc(100cqw * -158 / 393); right: calc(100cqw * -20 / 393); bottom: 0; left: calc(100cqw * -8 / 393); z-index: -1; pointer-events: none; background: url('${ctx}/assets/media/svg/shapes/abstract-5.svg') center top / 151% auto no-repeat; opacity: .2; }
.liff-home-head .liff-back-btn { background: transparent; border-color: transparent; }
.liff-home-body { padding: 0 19.5px; display: flex; flex-direction: column; gap: 19.5px; }
.liff-rank-stat { flex: 1 1 0; min-width: 0; }
.liff-rank-stat-sep { border-right: 0.25px solid rgba(238, 179, 179, 1); }
.liff-rank-list-row { display: flex; align-items: center; gap: .75rem; padding: .625rem 0; border-bottom: 1px solid var(--bs-gray-200); }
.liff-rank-list-row:last-child { border-bottom: 0; }
.liff-rank-list-no { min-width: 48px; flex: none; }
.liff-rank-list-row .liff-rank-avatar { width: 40px; height: 40px; }
.liff-rank-list-row.is-me { background: #FFF2F2; border-radius: 8px; margin-inline: -.5rem; padding-inline: .5rem; }
</style>

<div id="liffLoadingOverlay" class="liff-loading-overlay liff-loading-delayed">
	<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div>
</div>

<div class="liff-home">
	<div class="liff-home-head">
		<div class="d-flex align-items-center gap-3">
			<a href="javascript:void(0)" class="liff-back-btn" onclick="liffShowLoading(); window.history.go(-1); return false;" aria-label="Back">
				<i class="ki-duotone ki-arrow-left fs-3 text-white"><span class="path1"></span><span class="path2"></span></i>
			</a>
			<h1 class="liff-page-title text-white mb-0 flex-grow-1">Leaderboard</h1>
		</div>
	</div>

	<div class="liff-home-body">
		<div class="card card-bordered rounded-4">
			<div class="card-body p-5 d-flex align-items-center gap-4">
				<i class="ki-duotone ki-cube-2 fs-3x flex-shrink-0" style="color: var(--bs-red);"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
				<div class="d-flex flex-column align-items-start gap-2 pe-4 liff-rank-stat liff-rank-stat-sep">
					<span id="myRank" class="fs-2hx fw-bold lh-1" style="color: #B91F28;"><span class="liff-skel" style="width:48px; height:32px;"></span></span>
					<span class="fs-7 text-gray-500">Current Rank</span>
				</div>
				<div class="d-flex flex-column align-items-start gap-2 liff-rank-stat">
					<span class="fs-2hx fw-bold lh-1" style="color: #B91F28;"><c:choose><c:when test="${not empty userInfo.currentBalance}">${userInfo.currentBalance.intValue()}</c:when><c:otherwise>-</c:otherwise></c:choose></span>
					<span class="fs-7 text-gray-500">My Cube Token</span>
				</div>
			</div>
		</div>

		<div class="card card-bordered rounded-4">
			<jsp:include page="/pages-line/cube_token/liff_token_ranking_card.jsp" />
		</div>

		<div class="card card-bordered rounded-4 px-5 py-4">
			<h3 class="fs-3 fw-bold mb-2" style="color: var(--bs-red);">Other Ranking</h3>
			<div id="rankingOthers" data-user-id="${fn:escapeXml(onlineUser.id)}">
				<div class="liff-rank-list-row"><span class="liff-skel" style="width:100%; height:40px;"></span></div>
				<div class="liff-rank-list-row"><span class="liff-skel" style="width:100%; height:40px;"></span></div>
			</div>
		</div>
	</div>
</div>

</div>

<script type="text/javascript">
(function () {
	var ctx = '${ctx}';
	var year = new Date().getFullYear();

	var myUserId = $('#rankingOthers').attr('data-user-id');

	function makeRankRow(user) {
		var isMe = String(user.userId) === myUserId;
		var $name = $('<span class="fs-6 fw-semibold text-gray-900 text-truncate"></span>').text(user.nameEn || user.nameTh || '-');
		var $row = $('<div class="liff-rank-list-row"></div>').toggleClass('is-me', isMe);
		$row.append($('<span class="liff-rank-list-no fs-2x fw-normal lh-base text-center text-gray-600"></span>').text(user.rankDisplay));
		$row.append(liffRankAvatar(user));
		$row.append($('<div class="d-flex flex-column flex-grow-1 min-w-0"></div>')
			.append(isMe ? $('<div class="d-flex align-items-center gap-2 min-w-0"></div>').append($name, '<span class="badge flex-shrink-0" style="background: var(--bs-red); color: #FFFFFF;">You</span>') : $name)
			.append($('<span class="fs-7 text-primary"></span>').text(user.employeeId || '-')));
		$row.append($('<span class="fs-5 fw-bold text-dark flex-shrink-0"></span>').text(Number(user.token).toLocaleString('en-US')));
		return $row;
	}

	window.addEventListener('pageshow', function (e) {
		if (e.persisted) $('#liffLoadingOverlay').hide();
	});

	function emptyText(text) {
		return $('<div class="text-center text-gray-600 fs-7 py-6"></div>').text(text);
	}

	$.ajax({ url: ctx + '/getUserCurrentRank', type: 'GET', data: { year: year }, dataType: 'json' })
		.done(function (res) { $('#myRank').text(res.success ? res.data : '-'); })
		.fail(function () { $('#myRank').text('-'); });

	$.ajax({ url: ctx + '/getTokenRanking', type: 'GET', data: { year: year }, dataType: 'json' })
		.done(function (res) {
			var users = (res.success && res.data) ? res.data : [];
			var others = users.filter(function (u) { return Number(u.rank) > 3; });
			var $others = $('#rankingOthers').empty();
			liffTokenTop3('#leaderboardTop3', users);
			if (others.length) { others.forEach(function (u) { $others.append(makeRankRow(u)); }); }
			else { $others.append(emptyText('-')); }
		})
		.fail(function () {
			$('#leaderboardTop3, #rankingOthers').empty().append(emptyText('-'));
			liffToastError('Unable to load the leaderboard. Please try again.', 'Load failed');
		});
})();
</script>
