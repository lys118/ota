/**
 * 
 */

function validate() {
	const user_id = document.getElementById("user_id").value;
	const user_password = document.getElementById("user_password_confirm").value;
	const user_password_confirm = document.getElementById("user_password_confirm").value;
	const idregExp = /^[a-z]+[a-z0-9]{4,19}$/g;
	const psconregExp = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}$/;
	
	if (user_id == "") {
		alert("아이디를 입력 해주세요")
		 return false
	}
	if (!idregExp.test(user_id)) {
		alert("올바른 아이디 형식을 입력해주세요.")
		return false
	}
	if (user_password == "") {
		alert("비밀번호를 입력 해주세요")
		return false
	}
	if (user_password != user_password_confirm) {
	    alert("비밀번호가 일치하지 않습니다.");
	    return false
	}
	if (!psconregExp.test(user_password)) {
		alert("올바른 비밀번호 형식을 입력해주세요.")
		return false
		} 
	return true
}