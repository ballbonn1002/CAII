<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Demo</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Metronic core -->
<link
	href="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.css"
	rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath}/assets/plugins/global/plugins.bundle.js"></script>

<!-- SweetAlert -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<style type="text/css">
.icon-width {
	width: 40px;
	justify-content: center;
}

.app-main {
	font-family: 'Inter', sans-serif;
}
</style>
</head>

<body>

	<div class="app-main flex-column px-16">
		<!-- Toolbar  -->
		<div class="page-title">
			<h1 class="page-heading text-gray-700 fw-semibold">Add Holiday</h1>
			<ul
				class="list-unstyled d-inline-flex gap-2 text-muted fs-7 fw-medium">
				<li class="">Home</li>
				<li class="">-</li>
				<li class="">Masster</li>
				<li class="">-</li>
				<li class="">Holiday</li>
			</ul>
		</div>

		<!-- Body  -->
		<div class="app-content">
			<div class="card  shadow-sm">
				<div class="card-header pt-7 border-0">
					<h3 class="mb-0 fw-seminbold text-gray-900">Holiday
						Application From</h3>
				</div>
				<form id="holidayForm" action="">
					<div class="card-body">
						<div class="date d-flex flex-row gap-5 mb-3">
							<div id="strat-date" class="date-lg flex-fill">
								<label for="start-date"
									class="required form-label text-gray-800 fw-medium">Start
									Date</label>
								<div class="input-group">
									<span class="input-group-text icon-width"><i
										class="ki-duotone ki-calendar-8 w"> <span class="path1"></span>
											<span class="path2"></span> <span class="path3"></span> <span
											class="path4"></span> <span class="path5"></span> <span
											class="path6"></span>
									</i> </span> <input type="text" class="form-control py-4" placeholder="1 Jan 2025"/>
								</div>

							</div>
							<div id="end-date" class="date-lg flex-fill">
								<label for="end-date"
									class="required form-label text-gray-800 fw-medium">End
									Date</label>
								<div class="input-group">
									<span class="input-group-text icon-width"><i
										class="ki-duotone ki-calendar-8 w"> <span class="path1"></span>
											<span class="path2"></span> <span class="path3"></span> <span
											class="path4"></span> <span class="path5"></span> <span
											class="path6"></span>
									</i> </span> <input type="text" class="form-control py-4" placeholder="1 Jan 2025"/>
								</div>
							</div>
						</div>
						<div id="holiday-name" class="mb-3">
							<label for="holiday-name"
								class="required form-label text-gray-800 fw-medium">Holiday
								Name</label> <input type="text" class="form-control py-4 px-3"
								placeholder="Holiday Name" />
						</div>
						<div id="description">
							<label for="description"
								class="required form-label text-gray-800 fw-medium">Description</label>
							<textarea class="form-control px-3" rows="4"
								placeholder="Optional details"></textarea>
						</div>

					</div>

					<div class="card-footer d-flex justify-content-end  gap-3">
						<button class="btn btn-light btn-bg-secondary fw-medium">Cancel</button>
						<button class="btn  btn-light btn-bg-success fw-medium text-white">Save</button>

					</div>
				</form>

			</div>

		</div>


	</div>




</body>
</html>