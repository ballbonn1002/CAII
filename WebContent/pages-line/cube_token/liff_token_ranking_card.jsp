<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
.liff-rank-row { display: flex; align-items: center; gap: 10px; }
.liff-rank-no { min-width: 22px; flex: none; text-align: center; font-size: 2.5rem; }
.liff-rank-avatar { width: 50px; height: 50px; border-radius: 50%; border: 2px solid var(--bs-gray-200); object-fit: cover; flex: none; }
.liff-rank-row.is-me { background: #FFF2F2; border-radius: 8px; margin: -.375rem -.5rem; padding: .375rem .5rem; }
.liff-rank-initial { display: inline-flex; align-items: center; justify-content: center; background: var(--bs-primary-light); color: var(--bs-primary); font-weight: 600; }
@media (max-width: 374.98px) {
	.liff-rank-card { padding: 1.25rem !important; }
	.liff-rank-avatar { width: 40px; height: 40px; }
}
</style>

<div class="liff-rank-card d-flex flex-column gap-4 p-7">
	<span class="fs-1 fw-bold lh-1 text-center" style="color: var(--bs-red);">Cube Token Ranking <span id="rankingCubeToken-year"></span></span>
	<div id="leaderboardTop3" class="d-flex flex-column gap-4" data-user-id="${fn:escapeXml(onlineUser.id)}">
		<div class="liff-rank-row"><span class="liff-skel" style="width:100%; height:50px;"></span></div>
		<div class="liff-rank-row"><span class="liff-skel" style="width:100%; height:50px;"></span></div>
		<div class="liff-rank-row"><span class="liff-skel" style="width:100%; height:50px;"></span></div>
	</div>
</div>

<script>
document.getElementById('rankingCubeToken-year').textContent = new Date().getFullYear();

var LIFF_RANK_COLORS = { 1: '#E3A302', 2: 'var(--bs-gray-500)', 3: '#97766F' };

function liffRankAvatar(user) {
	var ctx = '${pageContext.request.contextPath}';
	var name = user.nameEn || user.nameTh || '-';
	var $initial = $('<span class="liff-rank-avatar liff-rank-initial"></span>').text(name.trim().charAt(0).toUpperCase());
	if (user.filePath) {
		return $('<img class="liff-rank-avatar">').attr('src', ctx + user.filePath).attr('alt', name)
			.on('error', function () { $(this).replaceWith($initial.attr('style', this.getAttribute('style'))); });
	}
	return $initial;
}

function liffTokenTop3(box, users) {
	var $box = $(box).empty();
	var myUserId = $box.attr('data-user-id');
	var top = (users || []).filter(function (u) { return Number(u.rank) <= 3; });
	if (!top.length) {
		$box.append('<div class="text-center text-gray-600 fs-7 py-6">No ranking data available.</div>');
		return;
	}
	top.forEach(function (user) {
		var sites = (user.jobsiteList || []).map(function (s) { return s.name_site; }).filter(Boolean);
		var rankColor = LIFF_RANK_COLORS[Number(user.rank)] || 'var(--bs-gray-900)';
		var isMe = String(user.userId) === myUserId;
		var $name = $('<span class="fs-6 fw-semibold text-dark text-truncate"></span>').text(user.nameEn || user.nameTh || '-');
		var $row = $('<div class="liff-rank-row"></div>').toggleClass('is-me', isMe);
		$row.append($('<span class="liff-rank-no fw-bold lh-1"></span>').css('color', rankColor).text(user.rankDisplay));
		$row.append(liffRankAvatar(user).css('border-color', rankColor));
		$row.append($('<div class="d-flex flex-column flex-grow-1 min-w-0"></div>')
			.append(isMe ? $('<div class="d-flex align-items-center gap-2 min-w-0"></div>').append($name, '<span class="badge flex-shrink-0" style="background: var(--bs-red); color: #FFFFFF;">You</span>') : $name)
			.append($('<span class="fs-7 text-primary text-truncate"></span>').text(sites.length ? sites.join(', ') : '-')));
		$row.append($('<span class="fs-5 fw-semibold text-dark flex-shrink-0"></span>').text(user.token));
		$box.append($row);
	});
}
</script>
