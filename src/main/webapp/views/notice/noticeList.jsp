<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter" %>
<%@ page import = "java.util.List" %>  
<%@ page import = "java.util.Map" %>  
<%@ page import = "ota.model.dto.NoticeDto" %>
<%@ page import = "ota.model.dto.PageDto" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="/views/notice/css/noticeList.css" />
</head>
<body>
	<%@include file="../common/header.jsp"%>
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
	<br />
	<section id="notice_table">
		<H1 id='notice_header'>공지 사항</H1>
		<form id='notice_search_form' action="/notice" method="get">
			<select class="form-select" aria-label="Default select example"
			 	 name="searchField">
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="userName">닉네임</option>
			</select> 
			<input type="text" maxlength="10" class="form-control" name="searchWord" value="<%=searchWord%>"/> 
			<button type="submit" class="btn btn-secondary">검색하기</button>
		</form>
		<table class="table table-bordered table-hover">
			<thead class="table-light">
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
					<td colspan="5" align="center">
						등록된 게시물이 없습니다.
					</td>
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
					<td>
						<%= noticeDto.getNoticeId() %>
					</td>
					<td>
						<a class="link-secondary" style="text-decoration: none;"
							href="/notice/view?noticeId=<%=noticeDto.getNoticeId()%>&currentPage=<%=pageDto
									.getCurrentPage()%>&searchField=<%=searchField%>&searchWord=<%=searchWord %>">
							<% 
								if(noticeDto.getNoticeTitle().length() <= 25){
									out.print(noticeDto.getNoticeTitle());
								}else{
									out.print(noticeDto.getNoticeTitle().substring(0,25)+"...");
								}
							%>
						</a>
					</td>
					<td>
						<%= noticeDto.getNoticeUserName() %>
					</td>
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
					<td>
						<%= noticeDto.getNoticeVisitCount() %>
					</td>
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
				<li class="page-item">
					<a class="page-link" 
						href="/notice?currentPage=1">&lt;&lt;</a>
				</li>
				<li class="page-item">
				<% if(pageDto.getBeginPage() > 10) {%>
					<a class="page-link" 
					href="/notice?currentPage=<%=pageDto.getBeginPage()-10 %>">&lt;</a>
				<% }else{ %>
					<a class="page-link" 
					href="/notice?currentPage=1">&lt;</a>
				<% } %>	
				</li>
				<% } %>
				<% if(pageDto.getListCount() != 0) {
					for(int i=pageDto.getBeginPage(); i<=pageDto.getEndPage(); i++){
						if(i == pageDto.getCurrentPage()){
				%>
				<li class="page-item disabled">
					<a class="page-link" 
					href="/notice?currentPage=<%=i%>"><%=i %></a>
				</li>
				<%
						}else{
				%>
				<li class="page-item">
					<a class="page-link" 
					href="/notice?currentPage=<%=i%>"><%=i %></a>
				</li>
				<%
						}
					}
				}
				%>
				<% if(pageDto.getEndPage() < pageDto.getMaxPage()){ %>
				<li class="page-item">
					<a class="page-link" 
					href="/notice?currentPage=<%=pageDto.getEndPage()+1%>">&gt;</a>
				</li>
				<li class="page-item">
					<a class="page-link" 
					href="/notice?currentPage=<%=pageDto.getMaxPage()%>">&gt;&gt;</a>
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
	<%@include file="../common/footer.jsp"%>
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
</script>
</body>
</html>