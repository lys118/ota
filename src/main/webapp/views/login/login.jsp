<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
   	<link rel="stylesheet" href="/views/login/css/bootstrap.min.css"/>
   	<link rel="stylesheet" href="/views/login/css/login.css"/>
   	<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
  />	
</head>
<body>
	<%
		String result = (String)request.getAttribute("result");
	%>
    <div class="login-wrapper">
      <h2>Login</h2>
      <form method="post" action="/loginprocess" id="login-form" onsubmit="return loginvalidate()">
        <div class="mb-3">
          <input
            type="text"
            class="form-control"
            id="user_id"
            name="user_id"
            placeholder="아이디"
          />
        </div>

        <br />

        <div class="mb-3" id="input-field">
          <input
            type="password"
            class="form-control"
            id="user_password"
            name="user_password"
            placeholder="비밀번호"
            
          />
          <i class="fas fa-eye icon"></i>
        </div>
        <br />
        <button class="btn btn-primary" type="submit">로그인</button>
      </form>
      <div id="link-wrap">
        <a href="/agreement">회원가입 </a> | <a href="/findid">아이디 찾기 </a> |
        <a href="/findpw">비밀번호 찾기</a>
      </div>
    </div>
<script type="text/javascript">
	const result = "<%=result%>"
	if(result =="실패")
		alert("아이디 또는 비밀번호가 다릅니다.")
</script>    
</body>
<script src="/views/login/js/password_look.js"></script>
<script src="/views/login/js/loginvalidate.js"></script>
</html>
