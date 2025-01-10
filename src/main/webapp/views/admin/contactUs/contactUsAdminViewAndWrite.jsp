<%@page import="java.util.Objects"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="ota.model.dto.ContactUsDto"%>
<%@ page import="ota.model.dto.ContactUsImgDto"%>
<%@ page import="ota.model.dto.PageDto"%>
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
    <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
    <link href="/views/bootstrapTheme/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/views/bootstrapTheme/css/sb-admin-2.min.css" rel="stylesheet">
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
	<%
		ContactUsDto contactUsDto = (ContactUsDto)request.getAttribute("contactUsDto");
    		
    	Map<String,Object> contactUsMap = (Map)request.getAttribute("contactUsMap");
    		
    	PageDto pageDto = (PageDto)contactUsMap.get("pageDto");
    	List<ContactUsDto> contactUsList = (List<ContactUsDto>)contactUsMap.get("contactUsDtoList");
    	String responseStatus = (String)contactUsMap.get("responseStatus");	
	%>
	<br />
	<!-- Page Wrapper -->
	<!-- Main Content -->
	<div id="content">
		<!-- Begin Page Content -->
		<div class="container-fluid">
			<section style="width: 80%; margin: 0 auto;" id="contactUs_View">
				<h2 style="text-align: center;">1:1문의</h2>
				<br/>
				<table class="table table-bordered">
					<tbody>
						<tr class="text-center">
							<th class="table-secondary"width="15%">no</th>
							<td class="table-light"width="35%"><%=contactUsDto.getContactUsId()%></td>
							<th class="table-secondary"width="15%">응답상태</th>
							<td class="table-light"width="35%">
							<%
								if(contactUsDto.isContactUsResponseStatus()){
									out.print("완료");
								}else{
									out.print("미완료");
								}
							 %>
							</td>
						</tr>
						<tr class="text-center">
							<th class="table-secondary"width="15%">회원/비회원</th>
							<td class="table-light"width="35%"><%=contactUsDto.getContactUsUserType() %></td>
							<th class="table-secondary"width="15%">아이디(회원)</th>
							<td class="table-light"width="35%">
							<%
								if(Objects.isNull(contactUsDto.getContactUsUserId())){
									out.print("");
								}else{
									out.print(contactUsDto.getContactUsUserId());
								}
							%>
							</td>
						</tr>
						<tr class="text-center">
							<th class="table-secondary"width="15%">작성자</th>
							<td class="table-light"width="35%"><%=contactUsDto.getContactUsUserName() %></td>
							<th class="table-secondary"width="15%">이메일</th>
							<td class="table-light"width="35%"><%=contactUsDto.getContactUsUserEmail() %></td>
						</tr>
						<tr class="text-center">
							
						</tr>
						<tr class="text-center">
							<th class="table-secondary"width="15%">문의유형</th>
							<td class="table-light"width="35%"><%=contactUsDto.getContactUsType() %></td>
							<th class="table-secondary"width="15%">등록일</th>
							<td class="table-light"width="35%">
						<%
								LocalDateTime contactUsLocalDateTime = contactUsDto.getContactUsPostDate().toLocalDateTime();
								out.print(contactUsLocalDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));
						%>	
							</td>
						</tr>
						<tr class="text-center">
							<th class="table-secondary">제목
							</th>
							<th colspan="3" class="table-light">
								<i><%=contactUsDto.getContactUsTitle()%></i>
							</th>
						</tr>
						<tr>
							<th class="text-center align-middle table-secondary">내용
							</th>
							<td colspan="3" class="table-light">
								<%=contactUsDto.getContactUsTitle()%>
							</td>
						</tr>
						<tr>
							<th class="text-center align-middle table-secondary">이미지
							</th>
							<td colspan="3" class="table-light">
						<%
							for(ContactUsImgDto contactUsImgDto : contactUsDto.getContactUsImgList()){
								String fileDirectory = contactUsImgDto.getWebDirectory();
								String webDirectory = fileDirectory.substring(fileDirectory.lastIndexOf("webapp")+6);
						%>
							<img style="margin:10px; height: 250px; width: 250px;"
							onclick="window.open(this.src)"	alt="첨부사진"
							 src="<%=webDirectory%>/<%=contactUsImgDto.getContactUsImgNewName()%>">
						<%		
							}
						%>
							</td>
						</tr>
						<%
							if(contactUsDto.isContactUsResponseStatus()){
						%>
						<tr>
							<th class="text-center align-middle table-secondary">답변 내용
							</th>
							<td colspan="3" class="table-light">
								<%=contactUsDto.getContactUsAdminResponse() %>
							</td>
						</tr>
					</tbody>
				</table>	
						<%
							}else{
						%>
					</tbody>
				</table>
					<form action="/admin/contactUs/adminResponse" method="post">
						<input type="hidden" name="contactUsId" value ="<%=contactUsDto.getContactUsId()%>">
						<input type="hidden" name="contactUsTitle" value="<%=contactUsDto.getContactUsTitle()%>">
						<input type="hidden" name="contactUsContent" value="<%=contactUsDto.getContactUsContent()%>">
						<input type="hidden" name="contactUsUserEmail" value="<%=contactUsDto.getContactUsUserEmail()%>">
						<div class="mb-3">
						  <label for="responseTextarea" class="form-label"><strong>답변하기</strong></label>
 						  <textarea class="form-control" id="responseTextarea" rows="5"
 						  maxlength="1000" required="required" name="responseText"></textarea>
						</div>
						<div style="display: flex; justify-content: flex-end; gap: 2px;">
							<button type="submit" class="btn btn-secondary">답변보내기</button>
						</div>
					</form>	
					<%
							}
					%>
			</section>
			<br />
			<hr />
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
									for(ContactUsDto contactUsDto1 : contactUsList){
										String rs = "";
										if(contactUsDto1.isContactUsResponseStatus()){
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
									<td><%=contactUsDto1.getContactUsId() %></td>
									<td><%=contactUsDto1.getContactUsUserType() %></td>
									<td><%=contactUsDto1.getContactUsUserName() %></td>
									<td><a class="link-secondary"
										href="/admin/contactUs/adminViewAndWrite?contactUsId=<%=contactUsDto1
										.getContactUsId()%>&currentPage=<%=pageDto
										.getCurrentPage()%>&selectComplete=<%=responseStatus%>">
							<%	
										if(contactUsDto1.getContactUsTitle().length() <=25 ){
											out.print(contactUsDto1.getContactUsTitle());
										}else{
											out.print(contactUsDto1.getContactUsTitle().substring(0,25)+"...");
										}
							%>			
										</a>
									</td>
									<td>
							<%
									LocalDate currentLocalDate1 = LocalDate.now();
									LocalDateTime contactUsLocalDateTime1 = contactUsDto1.getContactUsPostDate().toLocalDateTime();
									LocalDate contatUsPostDate1 = contactUsLocalDateTime1.toLocalDate();
									
									if(currentLocalDate1.isEqual(contatUsPostDate1)){//현재날짜면 작성시간만 보여줌
										out.print(contactUsLocalDateTime1
												.format(DateTimeFormatter.ofPattern("HH:mm")));
									}else{
										out.print(contactUsLocalDateTime1
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
    <%@include file="/views/admin/common/footer.jsp" %>
<script type="text/javascript">
window.onload = function(){
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