<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="ota.model.dto.ContactUsDto"%>
<%@ page import="ota.model.dto.PageDto"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - Dashboard</title>
<link rel="stylesheet"
	href="/views/admin/notice/css/noticeAdminList.css" />
<!-- Custom fonts for this template-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link
	href="/views/bootstrapTheme/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/views/bootstrapTheme/css/sb-admin-2.min.css"
	rel="stylesheet">
<!-- Bootstrap core JavaScript-->
<script defer src="/views/bootstrapTheme/vendor/jquery/jquery.min.js"></script>
<script defer
	src="/views/bootstrapTheme/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script defer
	src="/views/bootstrapTheme/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script defer src="/views/bootstrapTheme/js/sb-admin-2.min.js"></script>
</head>

<body id="page-top">
	<%
		String result = (String)request.getAttribute("result");
		Map<String,Object> contactUsMap = (Map)request.getAttribute("contactUsMap");
		
		PageDto pageDto = (PageDto)contactUsMap.get("pageDto");
		List<ContactUsDto> contactUsList = (List<ContactUsDto>)contactUsMap.get("contactUsDtoList");
		String responseStatus = (String)contactUsMap.get("responseStatus");
			
	%>
	<%@include file="/views/admin/common/header.jsp"%>
	<!-- Page Wrapper -->
	<!-- Main Content -->
	<div id="content">
		<!-- Begin Page Content -->
		<div class="container-fluid">
			<br />
			<section style="width: 80%; margin: 0 auto;" id="contactUs_table">
				<H2 style="text-align: center;" id='contactUs_header'>1:1 문의</H2>
				<br/>
					<table class="table table-bordered table-hover">
						<thead class="table-secondary">
							<tr class="text-center">
								<th width="8%">NO</th>
								<th width="11%">회원 유형</th>
								<th width="11%">작성자</th>
								<th width="36%">제목</th>
								<th width="14%">등록일(시)</th>
								<th width="20%">
									<select id="selectRS" style="float: right;" class="form-select form-select-sm w-50" aria-label="Default select example"
									name="selectComplete">
										<option value="allComplete">전체</option>
										<option value="1">완료</option>
										<option value="0">미완료</option>
									</select>
									<p style="margin: 0; padding-top: 6px">답변상태</p>
								</th>
							</tr>
						</thead>
						<tbody>
							<%
								if(contactUsList.isEmpty()){
							%>
							<tr>
								<td colspan="6" align="center">등록된 문의사항이 없습니다.</td>
							</tr>
							<%
								}else {
									for(ContactUsDto contactUsDto : contactUsList){
										String rs = "";
										if(contactUsDto.isContactUsResponseStatus()){
							%>
									<tr class="text-center text-decoration-line-through">
							<%				
											rs = "완료";
										}
										else{
							%>
									<tr class="text-center">
							<%				
											rs = "미완료";
										}
							%>
									<td><%=contactUsDto.getContactUsId() %></td>
									<td><%=contactUsDto.getContactUsUserType() %></td>
									<td><%=contactUsDto.getContactUsUserName() %></td>
									<td><a class="link-secondary"
										href="/admin/contactUs/adminViewAndWrite?contactUsId=<%=contactUsDto
										.getContactUsId()%>&currentPage=<%=pageDto
										.getCurrentPage()%>&selectComplete=<%=responseStatus%>">
							<%	
										if(contactUsDto.getContactUsTitle().length() <=25 ){
											out.print(contactUsDto.getContactUsTitle());
										}else{
											out.print(contactUsDto.getContactUsTitle().substring(0,25)+"...");
										}
							%>			
										</a>
									</td>
									<td>
							<%
									LocalDate currentLocalDate = LocalDate.now();
									LocalDateTime contactUsLocalDateTime = contactUsDto.getContactUsPostDate().toLocalDateTime();
									LocalDate contatUsPostDate = contactUsLocalDateTime.toLocalDate();
									
									if(currentLocalDate.isEqual(contatUsPostDate)){//현재날짜면 작성시간만 보여줌
										out.print(contactUsLocalDateTime
												.format(DateTimeFormatter.ofPattern("HH:mm")));
									}else{
										out.print(contactUsLocalDateTime
												.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
									}
							%>		
										
									</td>
									<td><%=rs %></td>
								</tr>
							<%
									}
								}
							%>
						</tbody>
					</table>
					<%
						if(pageDto.getListCount() != 0) {
					%>
					<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
					<%
						if (pageDto.getBeginPage() != 1) {
					%>
						<li class="page-item"><a class="page-link"
							href="/admin/contactUs/adminList?currentPage=1">&lt;&lt;</a></li>
						<li class="page-item">
					<%
						if (pageDto.getBeginPage() > 10) {
					%>  <a class="page-link"
							href="/admin/contactUs/adminList?currentPage=<%=pageDto.getBeginPage() - 10%>">&lt;</a>
					<%
						} else {
					%>  <a class="page-link"
							href="/admin/contactUs/adminList?currentPage=1">&lt;</a>
					<%
 						}
 					%>
						</li>
					<%
						}
					%>
					<%
						if (pageDto.getListCount() != 0) {
							for (int i = pageDto.getBeginPage(); i <= pageDto.getEndPage(); i++) {
								if (i == pageDto.getCurrentPage()) {
					%>
						<li class="page-item disabled"><a class="page-link"
							href="/admin/contactUs/adminList?currentPage=<%=i%>"><%=i%></a></li>
					<%
						} else {
					%>
						<li class="page-item"><a class="page-link"
							href="/admin/contactUs/adminList?currentPage=<%=i%>"><%=i%></a></li>
					<%
						}
						}
						}
					%>
					<%
						if (pageDto.getEndPage() < pageDto.getMaxPage()) {
					%>
						<li class="page-item"><a class="page-link"
							href="/admin/contactUs/adminList?currentPage=<%=pageDto.getEndPage() + 1%>">&gt;</a>
						</li>
						<li class="page-item"><a class="page-link"
							href="/admin/contactUs/adminList?currentPage=<%=pageDto.getMaxPage()%>">&gt;&gt;</a>
						</li>
					<%
						}
					%>
					</ul>
				</nav>
				<%
				}
				%>	
					
			</section>
			<br />
		</div>
	</div>
	<!-- End of Main Content -->
	<%@include file="/views/admin/common/footer.jsp"%>
<script type="text/javascript">

window.onload = function(){
	const responseResult = "<%=result%>";
	if(responseResult=='success'){
		alert("답변 완료 했습니다.");
	}
	selectInit();
	pageBarInit();
}

function selectInit(){
	const selectValue = "<%= responseStatus %>";
	const selectBox = document.getElementById("selectRS");

	for(let i=0; i<selectBox.length; i++){
		if(selectBox[i].value == selectValue){
			selectBox[i].selected =true;
		}	
	}
}

function pageBarInit(){
	const selectValue = "<%= responseStatus %>";
	const pageBarAtag = document.getElementsByClassName("page-link");
	
	if(selectValue != ""){
		for(let i=0; i<pageBarAtag.length; i++){
			pageBarAtag[i].href += "&selectComplete="+selectValue;
		}
	}
}
	

const currentPage="<%=pageDto.getCurrentPage() %>";

document.getElementById("selectRS").addEventListener('change', function(e){
	const selectRsValue = document.getElementById("selectRS").value;
	location.href="/admin/contactUs/adminList?currentPage=1"
			+"&selectComplete="+selectRsValue;
});
</script>
</body>

</html>