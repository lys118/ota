<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
</head>
<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
  />
<link rel="stylesheet" href="/views/login/css/bootstrap.min.css"/>
<link rel="stylesheet" href="/views/login/css/changepw.css"/>
<body>
	 <div class="change-wrapper">
      <h2>새 비밀번호 설정하기</h2>
      <h3>새로 설정할 비밀번호를 입력 해주세요</h3>
      <form method="post" action="/changepwprocess" id="findid-form">
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

        <div id="input-field">
          <input
            type="password"
            class="form-control"
            id="user_password"
            name="user_password"
            oninput="checkpw()"
            placeholder="새 비밀번호"
          />
          <i class="fas fa-eye icon"></i>
        </div>

        <br />

        <div id="input-field-con">
          <input
            type="password"
            class="form-control"
            id="user_password_confirm"
            name="user_password_confirm"
            oninput="checkpw()"
            placeholder="비밀번호 확인"
          />
          <i class="fas fa-eye icon"></i>
        </div>
        <span id ="pwCheckSpan"></span>
        <br />
        <button class="btn btn-success" id="change" type="submit">
          비밀번호 변경하기
        </button>
      </form>
      <div id = "findid">
      <label>아이디가 기억이 안난다면?</label>
      <a href="/findid">아이디 찾기</a>
      </div>
    </div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="/views/login/js/password_look.js"></script>
<script src="/views/login/js/password_look_ck.js"></script>
<script src="/views/login/js/checkid.js"></script>
<script src="/views/login/js/changepw.js"></script>
</html>