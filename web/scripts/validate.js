// JavaScript Document
function validateLoginForm() {
   var x = document.forms["login"]["username"].value;
   var y = document.forms["login"]["password"].value;
   if (x == "" || y == "") {
      alert("Username and password must be filled out.");
      return false;
   }
   return true;
}

function validateSignupForm() {
   var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
   var fname = document.forms["signup"]["firstname"].value;
   var lname = document.forms["signup"]["lastname"].value;
   var usr = document.forms["signup"]["username"].value;
   var email = document.forms["signup"]["email"].value;
   var pwd1 = document.forms["signup"]["password1"].value;
   var pwd2 = document.forms["signup"]["password2"].value;
   var term = document.forms["signup"]["term"];
   
   if (fname == "" || lname == "" || usr == "" || email == "" || pwd1 == "" || pwd2 == "" || term.checked == false) {
      alert("All signup fields must be filled out");
      return false;
   }
   if (re.test(email) == false) {
	   alert("Invalid email address.");
	   return false;
   }
   if (pwd1 != pwd2) {
	   alert("Password must be the same in both fields.");
	   return false;
   }
   return true;
}

function validateInfoForm() {
   var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
   var fname = document.forms["infoForm"]["firstname"].value;
   var lname = document.forms["infoForm"]["lastname"].value;
   var email = document.forms["infoForm"]["email"].value;
   var pwd1 = document.forms["infoForm"]["password1"].value;
   var pwd2 = document.forms["infoForm"]["password2"].value;
   
   if (fname == "" || lname == "" || email == "" || pwd1 == "" || pwd2 == "") {
      alert("All signup fields must be filled out");
      return false;
   }
   if (re.test(email) == false) {
	   alert("Invalid email address.");
	   return false;
   }
   if (pwd1 != pwd2) {
	   alert("Password must be the same in both fields.");
	   return false;
   }
   return true;
}

function validateNewPostForm() {
   
   var nTitle = document.forms["newPost"]["noteTitle"].value;
   var nBody = document.forms["newPost"]["noteBody"].value;
   
   if (nTitle == "" || nBody == "") {
      alert("All fields must be filled out");
      return false;
   }
   return true;
}

function validateReply() {
   var text = document.forms["newReply"]["replyBody"].value;
   
   if (text == "") {
      alert("All fields must be filled out");
      return false;
   }
   return true;
}