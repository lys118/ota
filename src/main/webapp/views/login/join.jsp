<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Join</title>
    <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
  />
    <link rel="stylesheet" href="/views/login/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/views/login/css/join.css" />
</head>
<body>
    <div class="join-wrapper">
      <h2>회원가입</h2>
      <hr />
      <form
        method="post"
        action="/joinprocess"
        id="join-form"
        onsubmit="return joinvalidate()"
      >
        <div id="id">
          <label for="user_id">아이디</label>
          <input
            type="text"
            class="form-control"
            id="user_id"
            name="user_id"
            placeholder="영문자로 시작하는 영문자 또는 숫자 6~20자"
          />
          <input
            type="button"
            class="btn btn-primary"
            id="idCheck-btn"
            value="아이디 중복 체크"
            onclick="checkid()"
          />
          <input type="hidden" id = "idcheck" value=""/>
        </div>
        <hr />
        <br />
        <div id="input-field">
          <label for="userPassword">비밀번호</label>
          <input
            type="password"
            class="form-control"
            id="user_password"
            name="user_password"
            oninput="checkpw()"
            placeholder="8~16자 영문, 숫자 조합"
          />
          <i class="fas fa-eye icon"></i>
        </div>
        <hr />
        <br />
        <div id="input-field-con">
          <label for="userPassword-confirm">비밀번호 확인</label>
          <input
            type="password"
            class="form-control"
            id="user_password_confirm"
            name="user_password_confirm"
            oninput="checkpw()"
            placeholder="8~16자 영문, 숫자 조합"
          />
          <i class="fas fa-eye icon"></i>
        </div>
        <span id = "pwCheckSpan"></span>
        <hr />
        <br />
        <div id="name">
          <label for="user_name">이름</label>
          <input
            type="text"
            class="form-control"
            id="user_name"
            name="user_name"
            placeholder="이름"
          />
        </div>
        <hr />
        <br />
        <div id="email">
          <label for="user_email">이메일</label>
          <input
            type="email"
            class="form-control"
            id="user_email"
            name="user_email"
            placeholder="이메일"
          />
          <input
            type="button"
            class="btn btn-primary"
            id="emailcheck-btn"
            value="인증번호 전송"
            onclick="auth()"
          />
        </div>
        <div id = "auth">
        <input
            type="text"
            class="form-control"
            id="checknum"
            name="checknum"
            placeholder="인증번호"
          />
           <span id="emailCheckSpan"></span>
           <input type="hidden" id = "emailcheck" value=""/>
        </div>
        <hr />
        <br />
        <div id="phone">
          <label for="user_phone">전화번호</label>
          <input
            type="text"
            class="form-control"
            id="user_phone"
            name="user_phone"
            placeholder="전화번호"
          />
        </div>
        <hr />
        <br />
        <div id="postcode">
          <label for="user_postcode">우편번호</label>
          <input
            type="text"
            class="form-control"
            id="user_postcode"
            name="user_postcode"
            placeholder="우편번호"
            readonly
          />
          <input
            type="button"
            class="btn btn-primary"
            id="postcode-btn"
            onclick="execDaumPostcode()"
            value="우편번호 찾기"
          />
        </div>
        <hr />
        <br />
        <div id="address">
          <label for="user_address">주소</label>
          <input
            type="text"
            class="form-control"
            id="user_address"
            name="user_address"
            placeholder="주소"
            readonly
          />
        </div>
        <hr />
        <br />
        <div id="detailaddress">
          <label for="user_detail_address">상세주소</label>
          <input
            type="text"
            class="form-control"
            id="user_detail_address"
            name="user_detail_address"
            placeholder="상세주소"
          />
        </div>
        <hr />
        <br />
        <div id="btn-wrap">
          <input type="submit" value="회원가입" class="btn btn-success" />
          <input
            type="button"
            value="초기화"
            onclick="window.location.reload()"
            class="btn btn-warning"
          />
          <input
            type="button"
            value="취소"
            onclick="location.href='/'"
            class="btn btn-danger"
          />
        </div>
      </form>
    </div>
</body>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="/views/login/js/address.js"></script>
		<script src="/views/login/js/password_look.js"></script>
		<script src="/views/login/js/password_look_ck.js"></script>
		<script src="/views/login/js/joinvalidate.js"></script>
		<script src="/views/login/js/checkid.js"></script>
		<script src="/views/login/js/auth.js"></script>
</html>