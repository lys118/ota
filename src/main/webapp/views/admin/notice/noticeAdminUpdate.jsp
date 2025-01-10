<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="ota.model.dto.NoticeDto"%>
<%@ page import="ota.model.dto.NoticeImgDto"%>
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
	    <!-- Bootstrap core JavaScript-->
    <script src="/views/bootstrapTheme/vendor/jquery/jquery.min.js"></script>
    <script defer src="/views/bootstrapTheme/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script defer src="/views/bootstrapTheme/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script defer src="/views/bootstrapTheme/js/sb-admin-2.min.js"></script>
    
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link href="/views/common/summernote/summernote-lite.min.css" rel="stylesheet">
    <script src="/views/common/summernote/summernote-lite.min.js"></script>
    <script src="/views/common/summernote/summernote-ko-KR.min.js"></script>
<style type="text/css">
#notice_write{
	width : 80%;
	margin: 0 auto;
}

input[name="noticeTitle"] {
	width :	70%;
	margin-bottom: 2px;
}

select[name="noticeImportType"] {
	width: 8%;
	height: 30px;
}
</style>
</head>
<body id="page-top">
	<%@include file="/views/admin/common/header.jsp" %>
    <!-- Page Wrapper -->
    <%
    	Map<String,Object> noticeMap = (Map)request.getAttribute("noticeMap");
    		
    	NoticeDto noticeDto = (NoticeDto)noticeMap.get("noticeDto");
    	String noticeContent = noticeDto.getNoticeContent().replace('\\', '/');
    	List<NoticeImgDto> noticeImgList = (List<NoticeImgDto>)noticeMap.get("noticeImgList");
	%>
            <!-- Main Content -->
            <br />
            <div id="content">
                <!-- Begin Page Content -->
                <div class="container-fluid">
               	<section id="notice_write">
					<h2 style="text-align: center;">공지사항</h2>
					
					<form id="writeForm" action="/notice/update" method="post">
						<input type="hidden" name="noticeId" value="<%=noticeDto.getNoticeId()%>">
						<%
							if(!noticeImgList.isEmpty()){
								for(NoticeImgDto noticeImgDto : noticeImgList){
						%>
							<input type="hidden" name="webDirectory" 
								value="<%=noticeImgDto.getWebDirectory()%>"
								class="<%=noticeImgDto.getNoticeImgNewName()%>">
							<input type="hidden" name="newFileName" 
								value="<%=noticeImgDto.getNoticeImgNewName()%>"
								class="<%=noticeImgDto.getNoticeImgNewName()%>">
							<input type="hidden" name="fileName" 
								value="<%=noticeImgDto.getNoticeImgOriginName()%>"
								class="<%=noticeImgDto.getNoticeImgNewName()%>">		
						<%
								}
							}
						%>
						<input id="noticeTitle" type="text" placeholder="제목을 작성하세요(최대30자)" maxlength="30" name="noticeTitle"
							value="<%=noticeDto.getNoticeTitle()%>">
						<select name="noticeImportType">
						<%
							if("필독".equals(noticeDto.getNoticeImportanceType())){
						%>
							<option value="필독" selected="selected">필독</option>
							<option value="중요">중요</option>
							<option value="일반">일반</option>	
						<%
							}else if("중요".equals(noticeDto.getNoticeImportanceType())){
						%>
							<option value="필독">필독</option>
							<option value="중요" selected="selected" >중요</option>
							<option value="일반">일반</option>
						<%
							}else {
						%>
							<option value="필독" >필독</option>
							<option value="중요">중요</option>
							<option value="일반" selected="selected">일반</option>
						<%
							}
						%>	
						</select>
						<textarea id="summernote" name="noticeContent" maxlength="5000"></textarea>
						<div style="display: flex; justify-content: space-between; margin-top:5px" >
							<input type="button" onclick="javascript:history.back();" value="이전페이지">
							<input type="button" onclick="writeFormCheck()" value="수정완료">
						</div>
					</form>
				</section>
				</div>
            </div>
            <br />
            <!-- End of Main Content -->
            
    <%@include file="/views/admin/common/footer.jsp" %>
 	<script>
 	window.onload = function(){
 		alert("(주의)이미지 삭제시 서버에 자동반영 됩니다.");
 	}
      $('#summernote').summernote({
        placeholder: '글을 작성해 주세요(최대 5000자)',
        tabsize: 2,
        height: 500,
        lang: "ko-KR",
        toolbar: [
		    ['fontname', ['fontname']],
		    ['fontsize', ['fontsize']],
		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		    ['color', ['forecolor','color']],
		    ['table', ['table']],
		    ['para', ['ul', 'ol', 'paragraph']],
		    ['height', ['height']],
		    ['insert',['picture','link']],
		    ['view', ['help']]
		  ],
		fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
		disableDragAndDrop: true,
		tabDisable: false,
		callbacks : {                                                    
			onImageUpload : function(files, editor, welEditable) {  
                // 이미지 등록시 진행함
                console.log("여기실행");
                // this에는 textarea가 닮긴다.
				for (let i = 0; i < files.length; i++) {
					imageUploader(files[i], this);
				}
			},
      		onMediaDelete : function(imgs, editor, welEditable){
				//이미지 한번에 삭제
				for (let i = 0; i < imgs.length; i++) {
      					imageDelete(imgs[i]);
					}
				}
      		}
  		});
    
      const noticeContent = '<%=noticeContent%>';
	  $("#summernote").summernote('pasteHTML',noticeContent);  //초기화 content등록
      
      function imageUploader(file,textarea){
    	  
    	  if(checkExtension(file)){//확장자체크 true시 불일치 아래실행 
    		  alert("이미지 파일만 업로드 해주세요.(jpg,gif,png,jpeg,svg)");
    		  return false;
    	  }
    	  if(checkSize(file)){//크기체크
    		  alert("이미지가 용랑이 너무큽니다.크기:"+file.size+"(최대:500,000)"); 
    		  return false;
    	  }
    	  
    	  const formData = new FormData(); //전송할 데이터 폼생성
    	  formData.append('file', file); //이미지를 폼에 저장
    	  //ajax로 서버에 저장후 서버에저장한 이미지를 보여줌.
    		$.ajax({                                                              
    			data : formData, //위에 생성한 이미지폼을 전송
    			type : "POST",
    			url : '/notice/imgUpload',  
    			contentType : false, 
    			processData : false, //쿼리스트링으로 전송 막기
    			enctype : 'multipart/form-data',//멀티폼형식으로 전송하고
    			dataType : 'JSON', //JSON형식으로 받겠다
    			success : function(data) {
    				//가져온 데이터를 textarea에 포함시킨다.
 					console.log(textarea);
    				const noImg = "<img class='otaNoImg2024' src='"+data.webDirectory+"/"+data.newFileName+"'alt='사진'>";
    				$(textarea).summernote('pasteHTML',noImg); // textarea에 포함.
    				imgInfoInsertForm(data);// form에 히든타입추가
    				
    			},
    			error : function(request,status,error){
 				   console.log("이미지 등록 실패"); 
    		    }
    		});
      }
      function imgInfoInsertForm(data){//img 정보를 form태그에 추가한다.
    	const writeForm = document.getElementById("writeForm");
    	  
		const inputWD= document.createElement('input');//경로
		inputWD.setAttribute('type','hidden');
		inputWD.setAttribute('name','webDirectory');
		inputWD.setAttribute('value',data.webDirectory);
		inputWD.setAttribute('class',data.newFileName);//삭제를위한 class추가
		
		const inputNF= document.createElement('input');//새로운파일이름
		inputNF.setAttribute('type','hidden');
		inputNF.setAttribute('name','newFileName');
		inputNF.setAttribute('value',data.newFileName);
		inputNF.setAttribute('class',data.newFileName);
		
		const inputOF= document.createElement('input');//원래이름
		inputOF.setAttribute('type','hidden');
		inputOF.setAttribute('name','fileName');
		inputOF.setAttribute('value',data.fileName);
		inputOF.setAttribute('class',data.newFileName);
			
		writeForm.appendChild(inputWD);
		writeForm.appendChild(inputNF);
		writeForm.appendChild(inputOF);
	  }
      
      function imageDelete(img){//이미지 삭제

        const imgName = img.src.substr(img.src.lastIndexOf('/')+1);
    	let	inputHidden = document.getElementsByClassName(imgName);
		
    	const noticeId = "<%=noticeDto.getNoticeId()%>";
    	const webDirectory = inputHidden.webDirectory.value;
     	const newFileName = inputHidden.newFileName.value;
      	const fileName = inputHidden.fileName.value;
    
      	inputHidden.fileName.remove();
      	inputHidden.newFileName.remove();
      	inputHidden.webDirectory.remove();
      	//input 태그내에서 삭제 완료
      	
      	//ajax를 통해 저장된 웹경로+db에서도 삭제.(db에 있을경우만(처음수정시) db에서삭제)
      	const imgInfo = new Object();
      	
      	imgInfo.noticeId = noticeId;
      	imgInfo.webDirectory = webDirectory;
      	imgInfo.newFileName = newFileName;
      	imgInfo.fileName = fileName;
      	
      	let jsonData = JSON.stringify(imgInfo);
      	
      	$.ajax({                                                              
			data : jsonData, //위에 생성한 이미지폼을 전송
			type : "post",
			url : '/notice/imgDelete',  
			contentType : 'application/json; charset=utf-8', //서버전송시
			processData : false, //쿼리스트링으로 전송 막기
			dataType : 'text', //text형식으로 받겠다
			success : function(text) {
			},
			error : function(request,status,error){
				   console.log("이미지 삭제 실패"); 
		    }
		});
      	
      }
      
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
      
      function checkSize(file){//크기 체크
    	  const maxSize = 500000;
    	  const fileSize = file.size;
    	  
    	  if(fileSize <= maxSize){
    		  return false; 
    	  }
    	  return true;
      }
    
      $(".note-group-image-url").remove();//url로 지정하기 삭제
           
      function writeFormCheck(){//서머노트에서 휴지통으로 이미지 제거시 잘사라지지만
    	  //그냥 백스페이스로 지우면 서버,input Hidden이 사라지지 않는다.
    	  //대신 submit할때 체크를하고 서버로 보낸다.
    	  const noticeTitle = document.getElementById("noticeTitle").value;
    	  if(noticeTitle == "" || noticeTitle == null){
    		  alert("제목을 작성해 주세요");
    		  return false;
    	  }
      
          const writeForm = document.getElementById("writeForm");
    	  const imgNames = document.getElementsByName("newFileName");
          let sc = $('#summernote').summernote('code');// 서머노트에 담긴 코드들.
      	  
          if(imgNames.length == 0){//이미지가 없으면 바로전송
        	  writeForm.submit();
       		  return false;
      	  }
          
    	  let arr = []; //hidden에 담긴 이미지이름.
    	  if(imgNames !=0 && imgNames !=null){
    		  for(let i=0; i<imgNames.length; i++){
    			  arr.push(imgNames[i].value);
    		  }
    	  }
    	  for(let i=0; i<arr.length; i++){
    		 if(sc.indexOf(arr[i]) == -1){//서머노트에는 없는데, hidden에는 있을떄
    			 imageDelete(arr[i]);// hidden과 서버에서 지운다.
    		 }
    	  }
    	  writeForm.submit();
    	  return false;
      }
    </script>    
</body>
</html>






