/**
 * 
 */
/**
 * 
 */

function auth() {
	let user_email = $('#user_email').val()
	if (user_email == "") {
			alert("이메일을 입력해주세요.")
			return
		}
	const emailregExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i
	
	if (!emailregExp.test(user_email)) {
			alert("올바른 이메일 형식을 입력해주세요.")
			return
		}
		
	$.ajax({
		url: "/email",
		type:"get",
		data:{'user_email' : user_email},
		success : function(data) {
			code = data
			alert("인증번호가 전송 되었습니다.")
		}
	})
	$('#checknum').keyup(function () {
		const inputCode = $(this).val()
		const emailCheckSpan = $('#emailCheckSpan')
		
		if (inputCode == "") {
			emailCheckSpan.text('인증번호를 입력해주세요').css('color', 'black')
		}
		else if (inputCode === code) {
			emailCheckSpan.text('인증번호가 일치합니다.').css('color', 'blue')
			document.getElementById('emailcheck').value = 'Y'
		}
		else {
			emailCheckSpan.text('인증번호가 일치하지 않습니다.').css('color', 'red')
		}
	})
}

function validate() {
	const user_name = $('#user_name').val()
	const user_email = $('#user_email').val()
	const checknum = $('#checknum').val()
	const emailcheck = $('#emailcheck').val()
	
	if (user_name == "" || user_email == "") {
		alert("모든 입력은 필수 사항입니다.")
		return false
	}
	if (checknum == "") {
		alert("인증번호를 입력 해주세요")
		return false
	}
	if (emailcheck == "") {
		alert("이메일 인증을 해주세요")
		return false
	}
	return true
} 

