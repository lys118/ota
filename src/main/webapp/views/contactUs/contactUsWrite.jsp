<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script defer src="/views/common/js/bootstrap.min.js"></script>
<style type="text/css">
#contactUs-section{
	margin: 0 auto;
	width: 60%;
	max-width: 700px;
}
#writeFrom{
	margin: 0 auto;
}
</style>
<title>문의하기</title>
</head>
<body>
	<%@include file="/views/common/header.jsp"%>
	<br/>
	<%
		String result = request.getParameter("result");
	%>
	<main>
		<section id="contactUs-section">
			<form id="writeFrom" action="/contactUs/upload" method="post" enctype="multipart/form-data">
			<%
        		if(loginUserDTO != null){
			%>
				<div class="mb-3">
					<h3 style="text-align: center;"><strong>회원</strong> 입니다</h3>
					<input type="hidden" name="userType" value="회원">
				</div>
				<div class="mb-3">
  					<label for="contactUs-id" class="form-label"><strong>아이디</strong></label>
  					<input type="text" class="form-control" id="contactUs-id" 
						value="<%=loginUserDTO.getUserID()%>" name="userId" readonly>
				</div>
				<div class="mb-3">
  					<label for="contactUs-name" class="form-label"><strong>이름</strong></label>
  					<input type="text" class="form-control" id="contactUs-name" 
						value="<%=loginUserDTO.getUserName()%>" name="userName" readonly>
				</div>
				<div class="mb-3">
  					<label for="contactUs-email" class="form-label"><strong>이메일</strong></label>
  					<input type="email" class="form-control" id="contactUs-email"
  						value="<%=loginUserDTO.getUserEmail()%>" name="userEmail" readonly>
				</div>
			<%
        		}else{
			%>
				<div class="mb-3">
					<h3 style="text-align: center;"><strong>비회원</strong> 입니다</h3>
					<input type="hidden" name="userType" value="비회원">
				</div>
				<div class="mb-3">
  					<label for="contactUs-name" class="form-label"><strong>이름</strong></label>
  					<input type="text" class="form-control" id="contactUs-name"
  					name="userName" maxlength="10" required>
				</div>
				<div class="mb-3">
  					<label for="contactUs-email" class="form-label"><strong>이메일</strong>(작성하신 이메일로 답변해드립니다.)</label>
  					<input type="email" class="form-control" id="contactUs-email" placeholder="name@example.com"
  					name="userEmail" maxlength="40" required>
				</div>
			<%
        		}
			%>
				<div class="mb-3">
 					 <label for="contactUs-type" class="form-label"><strong>문의 유형</strong></label>
 					 <select id="contactUs-type" class="form-select" aria-label="Default select example"
 					 	name="contactUsType">
						<option selected value="회원 정보">회원 정보</option>
						<option value="경매 정보">경매 정보</option>
						<option value="결제 정보">결제 정보</option>
						<option value="기타 정보">기타 정보</option>
					</select>
				</div>
				<div class="mb-3">
  					<label for="contactUs-title" class="form-label"><strong>문의 제목</strong></label>
 					 <input type="text" class="form-control" id="contactUs-title" name="contactUsTitle"
 						 maxlength="40" required>
				</div>
				<div class="mb-3">
					<label for="contactUs-content" class="form-label"><strong>문의 내용</strong>(최대 1000자)</label>
  					<textarea class="form-control" id="contactUs-content" rows="5" name="contactUsContent"
  						maxlength="1000" required></textarea>
				</div>
				<div class="mb-3">
  					<label for="imgUpload" class="form-label"><strong>이미지</strong>(최대 5개)</label>
 					 <input type="file" class="form-control" id="imgUpload" name ="imgs"
 					 multiple accept=".jpg,.jpeg,.png,.gif,.svg">
				</div>
				
				<div style="display: flex; justify-content: space-between;">
					<input type="reset" value="초기화">
					<input type="button" onclick="writeFormCheck()" value="저장">
				</div>	
			</form>
		</section>
	</main>
	<br/>
	<%@include file="/views/common/footer.jsp"%>
</body>
<script type="text/javascript">
	window.onload = function(){
		const result = "<%=result%>";
		if(result =="success")
			alert("저장에 성공하였습니다.");
	}
	const imgInput = document.getElementById("imgUpload");
	
	imgInput.addEventListener('change', function(e){
		const imgList = e.target.files;
		if(imgList.length > 5) {
			alert("이미지는 5개까지만 업로드 가능합니다.");
			imgInput.value="";
			return false;
		}
		for (let i=0; i<imgList.length; i++){
			if(checkExtension(imgList[i])){//확장자체크
				alert("이미지만 업로드 해주세요.");
				imgInput.value="";
				return false;
			}
		}
	});
	
    function checkExtension(file){//확장자 체크
  	  const fileName = file.name;
  	  const fileExtension = fileName.substr(fileName.lastIndexOf('.'));
  	  const accessExtension = ['.jpg','.gif','.png','.jpeg','.svg'];
  	      	  
  	  for(let i=0; i<accessExtension.length; i++){
  		  if(fileExtension == accessExtension[i]){
  			  return false;//이미지 확장자랑 일치함
  		  } 
  	  }
  	  return true;//이미지 확장자가 아님
    }
	
	function writeFormCheck() {
		const writeForm = document.getElementById("writeFrom");
		const name = document.getElementById("contactUs-name");
		const email = document.getElementById("contactUs-email");
		const title = document.getElementById("contactUs-title");
		const content = document.getElementById("contactUs-content");
		
		if(name.value.length==0){
			alert("이름을 작성해 주세요");
			return false;
		}
		
		if(email.value.length==0){
			alert("이메일을 작성해 주세요");
			return false;
		}else{
		  const emailregExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		  if (!emailregExp.test(email.value)) {
			  alert("올바른 이메일 형식을 입력해주세요.");
			  return false;
		  }
		}
		
		if(title.value.length==0){
			alert("제목을 작성해 주세요");
			return false;
		}
		
		if(content.value.length==0){
			alert("내용을 작성해 주세요");
			return false;
		}
		writeForm.submit();
	}
</script>
</html>