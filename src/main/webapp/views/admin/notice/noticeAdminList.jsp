<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="ota.model.dto.NoticeDto"%>
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
		Map<String,Object> noticeMap = (Map)request.getAttribute("noticeMap");
		
		PageDto pageDto = (PageDto)noticeMap.get("pageDto");
		List<NoticeDto> noticeList = (List<NoticeDto>)noticeMap.get("noticeList");
		Map<String,String> searchMap = (Map<String,String>)noticeMap.get("searchMap");
		
		String searchField = "";
		String searchWord = "";
		if (!searchMap.get("searchWord").equals("")) {
				searchField = searchMap.get("searchField");
				searchWord = searchMap.get("searchWord");
		}
	%>
	<%@include file="/views/admin/common/header.jsp"%>
	<!-- Page Wrapper -->
	<!-- Main Content -->
	<div id="content">
		<!-- Begin Page Content -->
		<div class="container-fluid">
			<br />
			<section id="notice_table">
				<H3 id='notice_header'>공지 사항</H3>
				<div id="buttonAndSearch_Box">
				<div>
				<button type="button" onclick="delectFormCheck()" class="btn btn-secondary">삭제</button>
				<button type="button" onclick="location.href='/notice/writeForm'" class="btn btn-secondary">글쓰기</button>
				</div>
				<form id='notice_search_form' action="/notice/adminList" method="get">
					<select class="form-select" aria-label="Default select example"
						name="searchField">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="userName">닉네임</option>
					</select> <input type="text" maxlength="10" class="form-control"
						name="searchWord" value="<%=searchWord%>" />
					<button type="submit" class="btn btn-secondary">검색하기</button>
				</form>
				</div>
				<form id="delete_check_form" action="/notice/delete" method="get">
					<table class="table table-bordered table-hover">
						<thead class="table-secondary">
							<tr class="text-center">
								<th width="7%">삭제</th>
								<th width="9%">no</th>
								<th width="52%">제목</th>
								<th width="12%">작성자</th>
								<th width="11%">등록일(시)</th>
								<th width="9%">조회수</th>
							</tr>
						</thead>
						<tbody>
							<%
					if(noticeList.isEmpty()) {
				%>
							<tr>
								<td colspan="6" align="center">등록된 게시물이 없습니다.</td>
							</tr>
							<%
					}else {	
						for( NoticeDto noticeDto : noticeList ){
							if("필독".equals(noticeDto.getNoticeImportanceType())){
				%>
							<tr class="text-center table-danger aTagcolor">
								<%
							}else if("중요".equals(noticeDto.getNoticeImportanceType())){
				%>			
							<tr class="text-center table-warning aTagcolor">
								<%
							}else{					
				%>
							<tr class="text-center">
								<%
							}
				%>
								<td><input type="checkbox" name="deleteManyCheck"
									value="<%=noticeDto.getNoticeId()%>"></td>
								<td><%= noticeDto.getNoticeId() %></td>
								<td><a class="link-secondary"
									href="/notice/adminView?noticeId=<%=noticeDto.getNoticeId()%>&currentPage=<%=pageDto
									.getCurrentPage()%>&searchField=<%=searchField%>&searchWord=<%=searchWord %>">
							<% 
								if(noticeDto.getNoticeTitle().length() <= 25){
									out.print(noticeDto.getNoticeTitle());
								}else{
									out.print(noticeDto.getNoticeTitle().substring(0,25)+"...");
								}
							%>
								</a></td>
								<td><%= noticeDto.getNoticeUserName() %></td>
								<td>
									<%
							LocalDate currentLocalDate = LocalDate.now();
							LocalDateTime noticeLocalDateTime = noticeDto.getNoticePostDate().toLocalDateTime();
							LocalDate noticePostDate = noticeLocalDateTime.toLocalDate();
							
							if(currentLocalDate.isEqual(noticePostDate)){//현재날짜면 작성시간만 보여줌
								out.print(noticeLocalDateTime
										.format(DateTimeFormatter.ofPattern("HH:mm")));
							}else{
								out.print(noticeLocalDateTime
										.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
							}
						%>
								</td>
								<td><%= noticeDto.getNoticeVisitCount() %></td>
							</tr>
							<%				
						}
					}	
				%>
						</tbody>
					</table>
				</form>
				<%
			if(pageDto.getListCount() != 0) {
		%>
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<%if(pageDto.getBeginPage() != 1 ){%>
						<li class="page-item"><a class="page-link"
							href="/notice/adminList?currentPage=1">&lt;&lt;</a></li>
						<li class="page-item">
							<% if(pageDto.getBeginPage() > 10) {%> <a class="page-link"
							href="/notice/adminList?currentPage=<%=pageDto.getBeginPage()-10 %>">&lt;</a>
							<% }else{ %> <a class="page-link"
							href="/notice/adminList?currentPage=1">&lt;</a> <% } %>
						</li>
						<% } %>
						<% if(pageDto.getListCount() != 0) {
					for(int i=pageDto.getBeginPage(); i<=pageDto.getEndPage(); i++){
						if(i == pageDto.getCurrentPage()){
				%>
						<li class="page-item disabled"><a class="page-link"
							href="/notice/adminList?currentPage=<%=i%>"><%=i %></a></li>
						<%
						}else{
				%>
						<li class="page-item"><a class="page-link"
							href="/notice/adminList?currentPage=<%=i%>"><%=i %></a></li>
						<%
						}
					}
				}
				%>
						<% if(pageDto.getEndPage() < pageDto.getMaxPage()){ %>
						<li class="page-item"><a class="page-link"
							href="/notice/adminList?currentPage=<%=pageDto.getEndPage()+1%>">&gt;</a>
						</li>
						<li class="page-item"><a class="page-link"
							href="/notice/adminList?currentPage=<%=pageDto.getMaxPage()%>">&gt;&gt;</a>
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
	searchInit();
	pageBarInit();
	titleATagInit();
}

function searchInit() {//검색추가
	const searchField = "<%= searchField %>";
	const searchSelectBox = document.getElementsByClassName("form-select");
	
	for(let i=0; i<searchSelectBox[0].length; i++){
		if(searchSelectBox[0].options[i].value == searchField){
			searchSelectBox[0].options[i].selected =true;
		}	
	}
}

function pageBarInit() {//페이지바에 검색추가
	const searchField = "<%=searchField%>";
	const searchWord = "<%=searchWord%>";
	const pageBarAtag = document.getElementsByClassName("page-link");
	
	if(searchWord != ""){
		for(let i=0; i<pageBarAtag.length; i++){
			pageBarAtag[i].href += "&searchField="+searchField+"&searchWord="+searchWord;
		}
	}
}

function titleATagInit(){//기울기 추가
	const colortitleTr = document.getElementsByClassName("aTagcolor");
	for(let i=0; i<colortitleTr.length; i++){
		const iTag = document.createElement("i");
		let aTag = colortitleTr[i].children[2].children[0];
		const text = aTag.text.trim();
		aTag.text=""
		aTag.appendChild(iTag);	
		aTag.children[0].innerText=text;
	}
}

function delectFormCheck(){
	const deleteCheck = document.getElementsByName("deleteManyCheck");
	let checkCount = 0;
	for(let i =0; i<deleteCheck.length; i++){
		if(deleteCheck[i].checked)
			checkCount++;
	}
	
	if(checkCount==0){
		alert("체크 후 삭제하세요");
		return false;
	}
	
	if(confirm("정말 삭제 하시겠습니까? ("+checkCount+"개)")){
		document.getElementById("delete_check_form").submit();
	}
}
</script>
</body>

</html>