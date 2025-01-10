<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join Result</title>
<link rel="stylesheet" href="/views/login/css/bootstrap.min.css"/>
<link rel="stylesheet" href="/views/login/css/findidresult.css"/>
</head>
<body>
	<%
	boolean result = (boolean)request.getAttribute("result");
	%>
	<div id = result>
	<h2>회원가입 처리 결과</h2>
	<%
	if (result) {
	
	%>
	<h3>회원가입이 정상적으로 처리되었습니다.</h3>
	<div id = "link">
	<a href="/">홈 화면으로</a>
	<a href="/login">로그인 화면으로</a>
	</div>
	
	<%
	} else {
	%>
	<h3>오류가 발생했습니다.</h3>
	<div id = "link">
	<a href="/">홈 화면으로</a>
	<a href="/agreement">회원가입 화면으로</a>
	</div>
	<%
	}
	%>
	</div>
</body>
</html>