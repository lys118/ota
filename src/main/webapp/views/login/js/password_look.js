/**
 * 
 */
let input = document.querySelector("#input-field input");
let icon = document.querySelector("#input-field i");
icon.addEventListener("click", function () {
  if (input.type == "password") {
    input.type = "text";
    icon.classList.add("fa-eye-slash");
  } else {
    input.type = "password";
    icon.classList.remove("fa-eye-slash");
  }
});
