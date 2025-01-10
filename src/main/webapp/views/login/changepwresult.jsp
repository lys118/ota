<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password Result</title>
</head>
<link rel="stylesheet" href="/views/login/css/findidresult.css" />
<body>
	<%
	boolean result = (boolean)request.getAttribute("result");
	%>
	<div id = result>
	<h2>비밀번호 변경 결과</h2>
	<%
	if (result) {
	
	%>
	<h3>비밀번호가 성공적으로 변경되었습니다.</h3>
	<div id = "link">
	<a href="/">홈 화면으로</a>
	<a href="/login">로그인 화면으로</a>
	</div>
	
	<%
	} else {
	%>
	<h3>등록된 아이디가 없거나 오류가 발생했습니다.</h3>
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