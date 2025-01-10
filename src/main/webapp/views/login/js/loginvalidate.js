/**
 * 
 */
function loginvalidate() {
  const id = document.getElementById("user_id").value;
  const password = document.getElementById("user_password").value;

  if (id == "") {
    alert("아이디를 입력해주세요.");
    return false;
  }
  if (password == "") {
    alert("비밀번호를 입력해주세요.");
    return false;
  }

  return true;
}
