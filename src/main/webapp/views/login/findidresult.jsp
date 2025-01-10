<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find ID Result</title>
</head>
<link rel="stylesheet" href="/views/login/css/findidresult.css" />
<body>
	<%
	String user_id = (String)request.getAttribute("user_id");
	%>
	<div id = "result">
	<h2>아이디 찾기 결과</h2>
	<%
	if (user_id != null) {
	%>
	<h3>회원님의 아이디는 <%=user_id%> 입니다.</h3>
	<div id = "link">
	<a href="/">홈 화면으로</a>
	<a href="/login">로그인 화면으로</a>
	</div>
	<%
	} else {
	%>
	<h3>등록된 아이디가 없습니다.</h3>
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