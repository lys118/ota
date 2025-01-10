/**
 * 
 */
function mypagevalidate() {
	const id = document.getElementById("user_id").value;
	const name = document.getElementById("user_name").value;
	const email = document.getElementById("user_email").value;
	const phone = document.getElementById("user_phone").value;
	const postcode = document.getElementById("user_postcode").value;
	const address = document.getElementById("user_address").value;
	const detailaddress = document.getElementById("user_detail_address").value;
	
	if (id == "" || name == "" || email == "" || 
	    phone == "" || postcode == "" || address == "" || detailaddress == "") {
	    alert('모든 입력은 필수 사항입니다.');
	    return false;
	  }
	  
	const emailregExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	if (!emailregExp.test(email)) {
	    alert("올바른 이메일 형식을 입력해주세요.");
	    return false;
	  }
		
	const phoneregExp = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
	if (!phoneregExp.test(phone)) {
		alert("올바른 전화번호 형식을 입력해주세요.");
		return false;
	  }
	  
	  return true;
}