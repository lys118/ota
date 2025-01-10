/**
 * 
 */
let input_con = document.querySelector("#input-field-con input");
let icon_con = document.querySelector("#input-field-con i");
icon_con.addEventListener("click", function () {
  if (input_con.type == "password") {
    input_con.type = "text";
    icon_con.classList.add("fa-eye-slash");
  } else {
    input_con.type = "password";
    icon_con.classList.remove("fa-eye-slash");
  }
});