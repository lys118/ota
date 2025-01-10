<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ID = (String)request.getAttribute("ID");
	String Password = (String)request.getAttribute("Password");
	String Name = (String)request.getAttribute("Name");
	String Email = (String)request.getAttribute("Email");
	String Phone = (String)request.getAttribute("Phone");
	String Postcode = (String)request.getAttribute("Postcode");
	String Address = (String)request.getAttribute("Address");
	String DetailAddress = (String)request.getAttribute("DetailAddress");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
</head>
<link rel="stylesheet" href="/views/login/css/bootstrap.min.css"/>
<link rel="stylesheet" href="/views/login/css/mypage.css" />
<body>
	<div class="mypage-wrapper">
      <h2>My Page</h2>
      <hr />
      <form
        method="post"
        action="/updateinfo"
        id="mypage-form"
        onsubmit="return mypagevalidate()"
      >
        <div id="id">
          <label for="user_id">아이디</label>
          <input type="text" class="form-control" id="user_id" name="user_id" value="<%=ID %>" readonly/>
        </div>
        <hr />
        <br />
        <div id="name">
          <label for="user_name">이름</label>
          <input
            type="text"
            class="form-control"
            id="user_name"
            name="user_name"
            value="<%=Name %>"
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
            value="<%=Email %>"
          />
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
            value="<%=Phone %>"
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
            value="<%=Postcode %>"
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
            value="<%=Address %>"
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
            value="<%=DetailAddress %>"
          />
        </div>
        <hr />
        <br />
        <div id="btn-wrap">
          <input type="submit" value="수정하기" class="btn btn-success" />
          <input
            type="button"
            value="취소"
            onclick="location.href='/'"
            class="btn btn-warning"
          />
          <input type="button" value="탈퇴하기" class="btn btn-danger" onclick="deleteConfirm()"/>
        </div>
      </form>
    </div>	
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/views/login/js/address.js"></script>
<script src="/views/login/js/mypagevalidate.js"></script>
<script type="text/javascript">
    	function deleteConfirm() {
			let isDelete = confirm("확인을 누르면 탈퇴가 됩니다. 탈퇴 하시겠습니까?");
			
			if (isDelete) {
				location.href = "/delete"
			}
		}
</script>
</html>