<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find ID</title>
</head>
<link rel="stylesheet" href="/views/login/css/bootstrap.min.css"/>
<link rel="stylesheet" href="/views/login/css/findid.css"/>
<body>
	 <div class="find-wrapper">
      <h2>아이디 찾기</h2>
      <h3>본인인증 먼저 진행 해주세요</h3>
      <form method="post" action="/findidprocess" id="findid-form" onsubmit="return validate()">
        <div class="mb-3">
          <input
            type="text"
            class="form-control"
            id="user_name"
            name="user_name"
            placeholder="이름"
          />
        </div>

        <br />

        <div class="mb-3" id="email">
          <input
            type="email"
            class="form-control"
            id="user_email"
            name="user_email"
            placeholder="이메일"
          />
          <input
            class="btn btn-primary"
            type="button"
            id="check-btn"
            value="인증번호 전송"
            onclick="auth()"
          />
        </div>

        <br />

        <div class="mb-3">
          <input
            type="text"
            class="form-control"
            id="checknum"
            placeholder="인증번호"
          />
          <span id="emailCheckSpan"></span>
          <input type="hidden" id="emailcheck" value="">
        </div>
        <br />
        <button class="btn btn-success" id="find" type="submit">
          아이디 찾기
        </button>
      </form>
    </div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="/views/login/js/findid.js"></script>
</html>