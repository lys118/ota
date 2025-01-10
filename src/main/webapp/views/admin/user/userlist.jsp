<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="ota.model.dto.UserDTO" %>
<%@ page import="ota.model.dao.UserDAO" %>  
<%
ArrayList<UserDTO> list = (ArrayList<UserDTO>) request.getAttribute("list");
int cnt = (int) request.getAttribute("cnt");
int pageSize = (int) request.getAttribute("pageSize");
int currentPage = (int) request.getAttribute("currentPage");
String pageNum = (String) request.getAttribute("pageNum");
%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Dashboard</title>
    
    <!-- Custom fonts for this template-->
    <link href="/views/bootstrapTheme/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/views/bootstrapTheme/css/sb-admin-2.min.css" rel="stylesheet">
    <style type="text/css">
    @charset "UTF-8";

.rwd-table {
  margin: auto;
  width: 95%;
  border-collapse: collapse;
}

.rwd-table tr:first-child {
  background: #5B86EF;
  color: #fff;
}

.rwd-table tr {
  border-top: 1px solid #ddd;
  border-bottom: 1px solid #ddd;
  background-color: white;
}

/*.rwd-table tr:nth-child(odd):not(:first-child) {*/
/*    background-color: #ebf3f9;*/
/*}*/

.rwd-table th {
  display: none;
}

.rwd-table td {
  display: block;
}

.rwd-table td:first-child {
  margin-top: .5em;
}

.rwd-table td:last-child {
  margin-bottom: .5em;
}

.rwd-table td:before {
  /*content: attr(data-th) ": ";*/
  font-weight: bold;
  width: 120px;
  display: inline-block;
  color: #000;
}

.rwd-table th,
.rwd-table td {
  text-align: left;
}

.rwd-table {
  color: #333;
  border-radius: .4em;
  overflow: hidden;
}

.rwd-table tr {
  border-color: #5B86EF;
}

.rwd-table th,
.rwd-table td {
  padding: .5em 1em;
}
@media screen and (max-width: 601px) {
  .rwd-table tr:nth-child(2) {
      border-top: none;
  }
  .rwd-table th:first-child,
  .rwd-table td:first-child {
      font-weight : bold;
      color: black;
  }
  .rwd-table td a {
      text-decoration: none;
      color: black;
  }
}
@media screen and (min-width: 600px) {
  .rwd-table tr:hover:not(:first-child) {
      background-color: rgba(131, 244, 180, 0.3);
      /*background-color: #83F4B4;과 동일 opacity*/
  }
  .rwd-table td:before {
      display: none;
  }
  .rwd-table td a {
      text-decoration: none;
      color: black;
  }
  .rwd-table th,
  .rwd-table td {
      display: table-cell;
      padding: .25em .5em;
  }
  .rwd-table th:first-child,
  .rwd-table td:first-child {
      font-weight : bold;
      padding-left: 0;
  }
  .rwd-table th:last-child,
  .rwd-table td:last-child {
      padding-right: 0;
  }
  .rwd-table th,
  .rwd-table td {
      padding: 1em !important;
  }
}

#page_control {
	margin-top: 50px;
	display: flex;
	justify-content: center;
}

#page_control a {
	font-size: 25px;
	margin-left: 20px;
}

    </style>
	    <!-- Bootstrap core JavaScript-->
    <script defer src="/views/bootstrapTheme/vendor/jquery/jquery.min.js"></script>
    <script defer src="/views/bootstrapTheme/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script defer src="/views/bootstrapTheme/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script defer src="/views/bootstrapTheme/js/sb-admin-2.min.js"></script>
</head>

<body id="page-top">
	<%@include file="/views/admin/common/header.jsp" %>
    <!-- Page Wrapper -->
            <!-- Main Content -->
            <div id="content">
            <br/>
                <!-- Begin Page Content -->
                <div class="container-fluid">
                        <H2 style="text-align: center;" id='contactUs_header'>회원 리스트</H2><br/>
                        <table class="rwd-table">
                        <tbody>
							<tr>
								<th>아이디</th>
								<th>비밀번호</th>
								<th>이름</th>
								<th>이메일</th>
								<th>전화번호</th>
								<th>우편번호</th>
								<th>주소</th>
								<th>상세주소</th>
								<th>가입일</th>
							</tr>
							<%
							for (int i = 0; i < list.size(); i++) {
							%>
							<tr class="KOTRA-fontsize-80">
								<th><%=list.get(i).getUserID() %></th>
								<th><%=list.get(i).getUserPassword() %></th>
								<th><%=list.get(i).getUserName() %></th>
								<th><%=list.get(i).getUserEmail() %></th>
								<th><%=list.get(i).getUserPhone() %></th>
								<th><%=list.get(i).getUserPostcode() %></th>
								<th><%=list.get(i).getUserAddress() %></th>
								<th><%=list.get(i).getUserDetailAddress() %></th>
								<th><%=list.get(i).getUserJoinDate() %></th>
							</tr>
							<%	
							}  
							%>
					</tbody>
				</table>
				<div id = "page_control">
					<% if (cnt != 0) {
						
						int pageCount = cnt / pageSize + (cnt % pageSize == 0 ? 0 : 1);
						
						int pageBlock = 5;
						
						int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
						
						int endPage = startPage + pageBlock - 1;
						
						if (endPage > pageCount) {
							
							endPage = pageCount;
						}
					%>
					
					<% if (startPage > pageBlock) { %>
					<a href = "/userlist?pageNum=<%= startPage - pageBlock%>">Prev</a>
					
					<% } %>
					
					<% for (int  i = startPage; i<=endPage; i++) { %>
					<a href="/userlist?pageNum=<%= i%>"><%=i %></a>
					<% } %>
					
					<% if (endPage < pageCount) { %>
					<a href="/userlist?pageNum=<%=startPage + pageBlock%>">Next</a>
					<% } %>
					<% } %>
				</div>
				</div>
            </div>
            <!-- End of Main Content -->
    <%@include file="/views/admin/common/footer.jsp" %>
</body>

</html>