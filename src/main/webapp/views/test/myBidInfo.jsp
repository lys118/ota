<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="/views/common/header.jsp"%>
<br/>
	<section style="width: 80%; margin: 0 auto;">
		<h2>내 입찰 정보</h2>
		<br/>
		<p style="color: blue;">입찰 중</p>
		<table class="table table-bordered">
			<tr>
				<td style="padding: 0; margin: 0" width="10%" rowspan="2">
					<img alt="썸네일" width="200px" height="150px" style="max-height: 100%; max-width: 100%" 
					src="/views/common/img/hammer-7286346_1920.png">
				</td>
				<th class ="align-middle" width="30%" colspan="2">제목입니다제목입니다제목입니다제목입니다제목입니다제목입니다제목입니다</th>
				<th class ="text-center align-middle" width="15%" >물품명</th>
				<th class ="text-center align-middle table-light" width="10%">내 입찰가</th>
				<td class ="text-center align-middle" width="12%" >30,000</td>
				<th class ="text-center align-middle table-light" width="10%">내입찰 시간</th>
				<td class ="text-center align-middle" width="13%" >16:00</td>
			</tr>
			<tr>
				<td class ="align-middle" colspan="3">설명란입니다</td>
				<th class ="text-center align-middle table-light">현재 입찰가</th>
				<td class ="text-center align-middle">40,000</td>
				<th class ="text-center align-middle table-light">마감 시간</th>
				<td class ="text-center align-middle">13:33</td>
			</tr>
		</table>
	</section>	
<br/>
<%@include file="/views/common/footer.jsp"%>
</body>
</html>