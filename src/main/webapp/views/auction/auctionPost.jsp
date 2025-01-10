<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="ota.model.dto.Category_auctionDTO" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script defer src="/views/common/js/bootstrap.min.js"></script>
<style type="text/css">
.post-container{
	margin: 0 auto;
	width: 60%;
	max-width: 700px;
}
.post-wrap{
	margin: 0 auto;
}
</style>
<title>OTA경매 위탁글 작성</title>
</head>
<body>
	<%@include file="/views/common/header.jsp"%>
	<%
		// 로그인 여부 확인
		if(loginUserDTO == null){
			response.sendRedirect("/login");
        	return;
		}
		Map<String, Object> postServiceMap = (Map<String, Object>)request.getAttribute("postServiceMap");
    	List<Category_auctionDTO> categoryDTOList = null;
    	if (postServiceMap != null) {
        	categoryDTOList = (List<Category_auctionDTO>)postServiceMap.get("allCategoryDTOList");
    	}
    	
    	String errorMessage = (String) request.getAttribute("errorMessage");
	%>
	<section class="post-container">
		<div class="post-wrap m-3">
			<% if (errorMessage != null && !errorMessage.isEmpty()) { %>
                <div class="error-message" style="color: red;">
                    <%= errorMessage %>
                </div>
            <% } %>
			<form action="/auction/post/upload" class="post-form" method="post" enctype="multipart/form-data" id="auctionForm">
			<input type="hidden" id="user_user_id" name="user_user_id" 
			 value="<%=loginUserDTO.getUserID()%>">
				<div class="post-form-title mb-3">
					<label for="input-title" class="form-lable"><strong>제목</strong></label>
					<input type="text" class="form-control" id="input-title" name="title" maxlength="20" required>
				</div>
				<div class="post-form-content">
					<label for="input-content" class="form-lable"><strong>본문</strong></label>
					<textarea class="form-control" rows="4" id="input-content" name="content" maxlength="300" required></textarea>
				</div>
				<div class="post-form-startbid mt-3">
                    <label for="input-startingbid" class="form-lable"><strong>시작 입찰가(원)</strong></label>
                    <input type="number" class="form-control" id="input-startingbid" name="startingbid" min="1" required>
                </div>
                
                <div class="post-form-category mt-3">
                    <label><strong>카테고리</strong> (1~3개 선택)</label>
                    <%
                        if (categoryDTOList != null) {
                            for(Category_auctionDTO dto : categoryDTOList){
                    %>
                        <label for="category-<%=dto.getCategory_auction_id()%>">
                            <input type="checkbox" id="category-<%=dto.getCategory_auction_id()%>" name="category" value="<%=dto.getCategory_auction_id()%>">
                            <%=dto.getCategory_auction_name()%>
                        </label>
                    <%
                            }
                        }
                    %>
                </div>
					
				<div class="post-form-image mt-3">
  					<label for="input-img" class="form-label"><strong>이미지</strong>(필수, 1개만 가능)</label>
                    <input type="file" class="form-control" id="input-img" name="img" accept=".jpg,.jpeg,.png,.gif,.svg" required>
				</div>
				<div class="post-form-startdate mt-3">
					<label for="input-startingdate" class="form-lable"><strong>경매 시작</strong></label>
					<input type="datetime-local" class="form-control" id="input-startingdate" name="startdate" onchange="setStartMinValue()" required>
				</div>
				<div class="post-form-enddate mt-3">
					<label for="input-enddate" class="form-lable"><strong>경매 종료</strong></label>
					<input type="datetime-local" class="form-control" id="input-enddate" name="enddate" onchange="setEndMinValue()" required>
				</div>
				<div class="post-form-button mt-3" style="display: flex; justify-content: space-between;">
					<input type="reset" value="초기화">
					<input type="button" onclick="auctionFormCheck()" value="저장">
				</div>
			</form>
			
		</div>
	</section>
	<%@include file="/views/common/footer.jsp"%>
</body>
<script type="text/javascript">
	let isSettedStartDate = false;
	let isOkay = false;
// 	start-max는 now()+3일
<!-- start-min을 정하면, start-max(+3), end-min(+1), end-max(+7)가 정해짐 -->
<!-- startdate를 정하면, end-min(+1)과 end-max(+7)가 정해짐 -->
	const startDateElement = document.getElementById('input-startingdate');
	const endDateElement = document.getElementById("input-enddate");
// 	let enddate;

	let rawDate = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000);
	let date = rawDate.toISOString().slice(0, -5);
	
	// input-startdate를 현재로 설정
	startDateElement.value = date;
	// input-startdate의 최소값을 현재로 설정
	startDateElement.setAttribute("min", date);
	// input-startdate의 최대값을 사흘 뒤로 설정
	rawDate.setDate(rawDate.getDate()+3);
	startDateElement.setAttribute("max", rawDate.toISOString().slice(0, -5));
	
	endDateElement.value = null;
	endDateElement.setAttribute("min", date);
	
	rawDate = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000);
	rawDate.setDate(rawDate.getDate()+7);
	endDateElement.setAttribute("max", rawDate.toISOString().slice(0, -5));
	
	// 1) 현재 시간보다 미래인가? @
	// 2) startmax값보다 작은가? @

	// !) startmin을 현재로 재설정
	// !!) startmax를 startmin+3로 재설정
	// !!!) endmin을 startDateElement.value + 1로 재설정
	// !!!!) endmax를 startDateElement.value+7로 재설정
	function setStartMinValue() {
// 		system.out.println("setStartMinValue");
		console.log("setStartMinValue");

// 		rawDate = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000);
// 		date = rawDate.toISOString().slice(0, -5);
		//	1) 현재 시간보다 미래인가?
		if(startDateElement.value <= date) {
			isSettedStartDate = false;
			alert('현재 시간 이후의 날로 설정하십시오.');
			
			// !) startmin을 현재로 재설정
			rawDate = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000);
			date = rawDate.toISOString().slice(0, -5);
			startDateElement.value = date;
			startDateElement.setAttribute("min", date);
		}
		// 2) startmax값보다 작은가? @
		else if(startDateElement.value >= startDateElement.getAttribute("max")){
			isSettedStartDate = false;
			alert('경매 시작 날은 현재로부터 최대 3일까지 입니다.');
			
			// !) startmin을 현재로 재설정
			rawDate = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000);
			date = rawDate.toISOString().slice(0, -5);
			startDateElement.value = date;
			startDateElement.setAttribute("min", date);
		}
		// 아아~~무런 문제가 없을 때
		else{
			isSettedStartDate = true;
			// !!!) endmin을 startDate + 1 로 설정
			endDateElement.value = startDateElement.value;
			const enddate = new Date(startDateElement.value);
			enddate.setDate(enddate.getDate()+1);
			endDateElement.setAttribute("min", enddate.toISOString().slice(0, -5));
			endDateElement.value = enddate.toISOString().slice(0, -5);
		}
	}

	function setEndMinValue(){
		if(!isSettedStartDate){
			alert("먼저 경매 시작 시간을 설정하십시오.");
			endDateElement.value = null;
			return;
		}
		console.log("setEndMinValue");
		if(endDateElement.value <= startDateElement.value){
			isOkay = false;
			alert("경매 시작 시간 이후의 날로 설정하십시오.");
			endDateElement.value = endDateElement.getAttribute("min");
		}
		// enddate가 enddate+7보다 크다면
		else if(endDateElement.value >= endDateElement.getAttribute("max")){
			isOkay = false;
			alert("경매 시작 시간 이후의 날로 설정하십시오.");
			endDateElement.value = endDateElement.getAttribute("min");
		}
		else{
			isOkay = true;
		}
	}

	function auctionFormCheck(){
		const auctionForm = document.getElementById("auctionForm");
		const title = document.getElementById("input-title");
		const content = document.getElementById("input-content");
		const startingbid = document.getElementById("input-startingbid");
		const categories = document.querySelectorAll('input[name="category"]:checked');
		const img = document.getElementById("input-img");
		const startingdate = document.getElementById("input-startingdate");
		const enddate = document.getElementById("input-enddate");
		
		if(title.value.length == 0){
			alert("제목을 작성하십시오.");
			return;
		}
		if(content.value.length == 0){
			alert("본문을 작성하십시오.");
			return;
		}
		if(startingbid.value <= 0){
			alert("시작 입찰가를 입력하십시오.");
			return;
		}
		if(categories.length < 1 || categories.length > 3){
            alert("카테고리를 1개 이상 3개 이하로 선택하십시오.");
            return;
        }
		if(!isOkay){
			alert("경매 시작/경매 종료 날을 올바르게 지정하십시오");
			return;
		}
		// 이미지 파일 검증
        if(img.files.length === 0){
            alert("이미지 파일을 첨부해주세요.");
            return;
        }
        if(img.files.length > 1){
            alert("이미지 파일은 1개만 첨부 가능합니다.");
            return;
        }
		
		 // 폼 제출 전 user_user_id 값 확인
        const userIdField = document.getElementsByName("user_user_id")[0];
        if (!userIdField.value) {
            alert("사용자 ID가 없습니다. 다시 로그인해주세요.");
            return;
        }
     	// 이미지 파일 선택 시 검증
        document.getElementById('input-img').addEventListener('change', function(e) {
            if(this.files.length > 1) {
                alert('이미지 파일은 1개만 첨부 가능합니다.');
                this.value = ''; // 선택한 파일 초기화
            }
        });
        
		auctionForm.submit();
		
	}
</script>
</html>