<%@page import="ota.model.dto.LoginUserDTO"%>
<%@ page contentType="text/html; charset=utf-8"%>
<link rel="stylesheet" href="/views/common/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<%
	LoginUserDTO loginUserDTO = (LoginUserDTO)request.getSession().getAttribute("loginUser");
%>
	<nav class="navbar bg-body-secondary">
      <div class="container-fluid">
        <a class="navbar-brand px-2" href="/welcome"><strong><i>OTA</i></strong></a>
        <a class="nav-link" href="/notice"><strong>공지사항</strong></a>
        <a class="nav-link" href="/auction"><strong>경매</strong></a>
        <a class="nav-link" href="/contactUs/writeForm"><strong>1:1문의하기</strong></a>
        <%
        	if(loginUserDTO != null){
		%>
<%-- 		<a class="nav-link" href="/user/bidInfo?userId=<%=loginUserDTO.getUserID()%>"> --%>
<!--         <strong>내 입찰정보</strong> -->
<!--    		<i id="bidITag" style="color: red; display: none;" class="bi bi-megaphone">입찰실패(1건)</i> -->
<!--         </a> -->
        <%
        	if("admin".equals(loginUserDTO.getUserID())){
        %>
        	<a class="nav-link" href="/admin"><strong>관리자페이지</strong></a>
        <%
        	}
        %>
        <div style="display: flex; padding-right: 10px;">
		<a href="/mypage" class="nav-link active">마이페이지</a>/
		<a href="/logout" class="nav-link active">로그아웃</a>
		<%
        	}else{
		%>
		<div style="display: flex; padding-right: 10px;">
        <a href="/login" class="nav-link active">로그인</a>/
        <a href="/agreement" class="nav-link active">회원가입</a>
        <%
        	}
        %>
        </div>
      </div>
    </nav>
<script type="text/javascript">
</script>