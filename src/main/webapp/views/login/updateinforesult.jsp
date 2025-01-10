<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Info Result</title>
</head>
<link rel="stylesheet" href="/views/login/css/updateinforesult.css" />
<body>
	<%
	boolean result = (boolean)request.getAttribute("result");
	%>
	
	<div id = result>
	<h2>회원정보 수정 결과</h2>
	<%
	if (result) {
	
	%>
	<h3>회원정보가 정상적으로 수정되었습니다.</h3>
	<div id = "link">
	<a href="/">홈 화면으로</a>
	</div>
	
	<%
	} else {
	%>
	<h3>오류가 발생했습니다.</h3>
	<div id = "link">
	<a href="/">홈 화면으로</a>
	</div>
	<%
	}
	%>
	</div>
	
</body>
</html>