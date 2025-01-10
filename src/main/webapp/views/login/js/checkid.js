/**
 * 
 */
function checkid() {
	let user_id = $("#user_id").val()
	$('#idCheckSpan').remove()
	
	if (user_id == "") {
		alert("아이디를 입력해주세요.")
		return
	}
	const idregExp = /^[a-z]+[a-z0-9]{4,19}$/g
	if (!idregExp.test(user_id)) {
			alert("올바른 아이디 형식을 입력해주세요.")
			return
	}
	
	$.ajax({
			
		url: "/checkid",
		type:"post",
		
		data:{'user_id' : user_id},
		success : function(res) {
			if (res == "true") {
				$('#id').after("<span id='idCheckSpan' style='color:red'>이미 존재하는 아이디입니다.</span>")
			} else{
				$('#id').after("<span id='idCheckSpan' style='color:blue'>사용가능한 아이디입니다.</span>")
				document.getElementById('idcheck').value = 'Y'
			}
		},
		error : function() {	
			alert("에러")
		}
	})
	
}	

function checkpw() {
	const psconregExp = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}$/;
	let user_password = $('#user_password').val()
	
	if ($('#user_password').val() == "" && $('#user_password_confirm').val() == "") {
		$('#pwCheckSpan').text('비밀번호를 입력하여 주십시오.').css('color', 'black')
	}
	else if ($('#user_password').val() == $('#user_password_confirm').val()) {
		$('#pwCheckSpan').text('비밀번호가 일치합니다.').css('color', 'blue')
	} 
	else if (!psconregExp.test(user_password)) {
		$('#pwCheckSpan').text('올바른 비밀번호 형식을 입력하여 주십시오.').css('color', 'red')
	}
	else  {
		$('#pwCheckSpan').text('비밀번호가 일치하지 않습니다.').css('color', 'red')
	} 
}

