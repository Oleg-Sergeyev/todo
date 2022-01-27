// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@popperjs/core")

import "bootstrap"

// Import the specific modules you may need (Modal, Alert, etc)
import { Tooltip, Popover } from "bootstrap"

// The stylesheet location we created earlier
require("../stylesheets/application.scss")

// If you're using Turbolinks. Otherwise simply use: jQuery(function () {
document.addEventListener("turbolinks:load", () => {
    // Both of these are from the Bootstrap 5 docs
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new Tooltip(tooltipTriggerEl)
    })

    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    var popoverList = popoverTriggerList.map(function(popoverTriggerEl) {
        return new Popover(popoverTriggerEl)
    })
})

import Rails from "@rails/ujs"
require("jquery")
Rails.start()

window.addEventListener("load", () => {
  const active_links = document.querySelectorAll("tr a.toggle[data-remote]");
  active_links.forEach((element) => {
    element.addEventListener("ajax:success", (event) => {
      element.innerHTML = element.innerHTML == "Active" ? "Disactive" : "Active"
    });
  });
});

window.onload = function() {
  check_email_input()
};

// document.addEventListener('DOMContentLoaded', (event) => {
//   check_email_input();
// });

// Валидация электронной почты
function ValidateEmail(mail) 
{
  var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
  if(mail.match(mailformat)) { return (true) };
  return (false);
}
// Проверка в поле введенного адресса эл.почты 
function check_email_input()
{
  let input = document.getElementById('input_email');
  let warning_label = document.getElementById('label_wrong_email');
  input.addEventListener('input', () => { 
    if (input.value == '') { warning_label.innerHTML = ' '; toggle_submit('off'); return; }
    if (ValidateEmail(input.value) == false) { 
      warning_label.innerHTML = 'Wrong_email!';
      toggle_submit('off'); 
    }
      else{ warning_label.innerHTML = ' '; 
      toggle_submit('on'); 
    }
  });
}
// Включение отключение кнопки подтверждения
function toggle_submit(val){
  let button_submit = document.getElementById("submit_log_in");
  if (val == 'on') {
    button_submit.disabled = false
  } else { button_submit.disabled = true }
}