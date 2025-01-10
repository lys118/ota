<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="ota.model.dto.NoticeDto"%>
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
<style type="text/css">
#notice_View{
	width : 85%;
	margin : 0 auto;
}

#notice_header{
	text-align : center;
}

#notice_table{
	width : 85%;
	margin : 0 auto;
}

#notice_search_form{
	margin-top : 5px;
	margin-bottom : 5px;
	display:flex;
	justify-content: flex-end;
}

#notice_search_form select{
	width:120px;
	margin-right:2px;
}

#notice_search_form input{
	width:170px;
	margin-right:2px;
}

#notice_search_form button{
	width:90px;
}

.otaNoImg2024{
	max-width: 800px;
	max-height: 800px;
}
</style>
</head>

<body id="page-top">
	<%@include file="/views/admin/common/header.jsp" %>
	<%
		NoticeDto noticeDto = (NoticeDto)request.getAttribute("noticeDto");
    		
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
	<br />
	<!-- Page Wrapper -->
	<!-- Main Content -->
	<div id="content">
		<!-- Begin Page Content -->
		<div class="container-fluid">
			<section id="notice_View">
				<h2 style="text-align: center;">공지사항</h2>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th colspan="6">
								<h2><%=noticeDto.getNoticeTitle()%></h2>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr class="text-center table-secondary">
							<th width="10%">no</th>
							<th width="15%">작성자</th>
							<th width="10%">중요도</th>
							<th rowspan="2" width="35%"></th>
							<th width="20%">등록일</th>
							<th width="10%">조회수</th>
						</tr>
						<tr class="text-center table-secondary">
							<td><%=noticeDto.getNoticeId()%></td>
							<td><%=noticeDto.getNoticeUserName()%></td>
							<td><%=noticeDto.getNoticeImportanceType()%></td>
							<td>
								<%
								LocalDateTime noticeLocalDateTime = noticeDto.getNoticePostDate().toLocalDateTime();
								out.print(noticeLocalDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));
								%>
							</td>
							<td><%=noticeDto.getNoticeVisitCount()%></td>
						</tr>
						<tr>
							<td colspan="6">
								<p><%=noticeDto.getNoticeContent()%></p>
							</td>
						</tr>
					</tbody>
				</table>
				<div style="display: flex; justify-content: flex-end; gap: 2px;">
					<button type="button" onclick="delectCheck()" class="btn btn-secondary">삭제하기</button>
					<button type="button" onclick="location.href='/notice/updateForm?noticeId=<%=noticeDto.getNoticeId()%>'"
						 class="btn btn-secondary">수정하기</button>
					<button type="button" onclick="location.href='/notice/writeForm'" class="btn btn-secondary">글쓰기</button>
				</div>
			</section>
			<br />
			<hr />
			<br />
			<section id="notice_table">
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
					<table class="table table-bordered table-hover">
						<thead class="table-secondary">
							<tr class="text-center">
					<th width="10%">no</th>
					<th width="55%">제목</th>
					<th width="13%">작성자</th>
					<th width="12%">등록일(시)</th>
					<th width="10%">조회수</th>
							</tr>
						</thead>
						<tbody>
							<%
					if(noticeList.isEmpty()) {
				%>
							<tr>
								<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
							</tr>
							<%
					}else {	
						for( NoticeDto noticeDto1 : noticeList ){
							if("필독".equals(noticeDto1.getNoticeImportanceType())){
				%>
							<tr class="text-center table-danger aTagcolor">
								<%
							}else if("중요".equals(noticeDto1.getNoticeImportanceType())){
				%>
							
							<tr class="text-center table-warning aTagcolor">
								<%
							}else{					
				%>
							
							<tr class="text-center">
								<%
							}
				%>
								<td><%= noticeDto1.getNoticeId() %></td>
								<td><a class="link-secondary"
									href="/notice/adminView?noticeId=<%=noticeDto1.getNoticeId()%>&currentPage=<%=pageDto.getCurrentPage()%>">
										<% 
								if(noticeDto.getNoticeTitle().length() <= 25){
									out.print(noticeDto1.getNoticeTitle());
								}else{
									out.print(noticeDto1.getNoticeTitle().substring(0,25)+"...");
								}
							%>
								</a></td>
								<td><%= noticeDto1.getNoticeUserName() %></td>
								<td>
									<%
							LocalDate currentLocalDate = LocalDate.now();
							LocalDateTime noticeLocalDateTime1 = noticeDto.getNoticePostDate().toLocalDateTime();
							LocalDate noticePostDate = noticeLocalDateTime1.toLocalDate();
							
							if(currentLocalDate.isEqual(noticePostDate)){//현재날짜면 작성시간만 보여줌
								out.print(noticeLocalDateTime1
										.format(DateTimeFormatter.ofPattern("HH:mm")));
							}else{
								out.print(noticeLocalDateTime1
										.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
							}
						%>
								</td>
								<td><%= noticeDto1.getNoticeVisitCount() %></td>
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
    <%@include file="/views/admin/common/footer.jsp" %>
<script type="text/javascript">
window.onload = function(){
	searchInit();
	pageBarInit();
	titleATagInit();
}

function searchInit() {
	const searchField = "<%= searchField %>";
	const searchSelectBox = document.getElementsByClassName("form-select");
	
	for(let i=0; i<searchSelectBox[0].length; i++){
		if(searchSelectBox[0].options[i].value == searchField){
			searchSelectBox[0].options[i].selected =true;
		}	
	}
}

function pageBarInit() {
	const searchField = "<%=searchField%>";
	const searchWord = "<%=searchWord%>";
	const pageBarAtag = document.getElementsByClassName("page-link");
	
	if(searchWord != ""){
		for(let i=0; i<pageBarAtag.length; i++){
			pageBarAtag[i].href += "&searchField="+searchField+"&searchWord="+searchWord;
		}
	}
}

function titleATagInit(){
	const colortitleTr = document.getElementsByClassName("aTagcolor");
	for(let i=0; i<colortitleTr.length; i++){
		const iTag = document.createElement("i");
		let aTag = colortitleTr[i].children[1].children[0];
		const text = aTag.text.trim();
		aTag.text=""
		aTag.appendChild(iTag);	
		aTag.children[0].innerText=text;
	}
}

function delectCheck(){
	const noticeId = "<%=noticeDto.getNoticeId()%>";
	
	if(confirm("정말 삭제 하시겠습니까?")){
		location.href="/notice/delete?deleteOneCheck="+noticeId;
	}
}
</script>    
</body>

</html>