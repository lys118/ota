<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="/views/bootstrapTheme/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/views/bootstrapTheme/css/sb-admin-2.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>500</title>
</head>
<body>
	<br />
	<br />
	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- Begin Page Content -->
		<div class="container-fluid">
			<!-- 404 Error Text -->
			<div class="text-center">
				<div class="error mx-auto" data-text="500">500</div>
				<p class="lead text-gray-800 mb-5">Internal Server Error</p>
				<p class="text-gray-700 mb-1">에러 클래스 : <%=exception.getClass() %></p>
				<p class="text-gray-700 mb-1">에러 메세지 : <%=exception.getMessage() %></p>
				<p class="text-gray-700 mb-5">에러 위치 : <%=exception.getStackTrace()[0] %></p>
				<p class="text-gray-600 mb-1">죄송합니다 서버 내 오류입니다...</p>
				<p class="text-gray-600 mb-1">다시 시도해 주세요.</p>
				<p class="text-gray-600 mb-1">오류 반복시 고객센터로 문의해주세요.</p>
				<p class="text-gray-600 mb-1">번호 : 00-000-0000</p>
				<a href="javascript:history.back();">&larr; 이전페이지</a><br />
				<a href="/welcome"><i class="bi bi-house"></i> 홈으로</a>
			</div>
		</div>
		<!-- /.container-fluid -->
	</div>
	<!-- End of Main Content -->

</body>
</html>