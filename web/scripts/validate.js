// JavaScript Document
function replaceChar(myString) {
	return mystring.replace(/&/g, "&amp;").replace(/>/g, "&gt;").replace(/</g, "&lt;").replace(/"/g, "&quot;");
}

function validateLoginForm() {
   var x = replaceChar(document.forms["login"]["username"].value);
   document.forms["login"]["username"].value = x;
   var y = replaceChar(document.forms["login"]["password"].value);
   document.forms["login"]["password"].value = y;
   if (x == "" || y == "") {
      alert("Username and password must be filled out.");
      return false;
   }
   return true;
}

function validateSignupForm() {
   var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
   var fname = replaceChar(document.forms["signup"]["firstname"].value);
   document.forms["signup"]["firstname"].value = fname;
   var lname = replaceChar(document.forms["signup"]["lastname"].value);
   document.forms["signup"]["lastname"].value = lname;
   var usr = replaceChar(document.forms["signup"]["username"].value);
   document.forms["signup"]["username"].value = usr;
   var email = replaceChar(document.forms["signup"]["email"].value);
   document.forms["signup"]["email"].value = email;
   var pwd1 = replaceChar(document.forms["signup"]["password1"].value);
   document.forms["signup"]["password1"].value = pwd1;
   var pwd2 = replaceChar(document.forms["signup"]["password2"].value);
   document.forms["signup"]["password2"].value = pwd2;
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
   var fname = replaceChar(document.forms["signup"]["firstname"].value);
   document.forms["signup"]["firstname"].value = fname;
   var lname = replaceChar(document.forms["signup"]["lastname"].value);
   document.forms["signup"]["lastname"].value = lname;
   var email = replaceChar(document.forms["signup"]["email"].value);
   document.forms["signup"]["email"].value = email;
   var pwd1 = replaceChar(document.forms["signup"]["password1"].value);
   document.forms["signup"]["password1"].value = pwd1;
   var pwd2 = replaceChar(document.forms["signup"]["password2"].value);
   document.forms["signup"]["password2"].value = pwd2;
   
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
   
   var nTitle = replaceChar(document.forms["newPost"]["noteTitle"].value);
   document.forms["newPost"]["noteTitle"].value = nTitle;
   var nBody = replaceChar(document.forms["newPost"]["noteBody"].value);
   document.forms["newPost"]["noteBody"].value = nBody;
   
   if (nTitle == "" || nBody == "") {
      alert("All fields must be filled out");
      return false;
   }
   return true;
}

function validateReply() {
   var text = replaceChar(document.forms["newReply"]["replyBody"].value);
   document.forms["newReply"]["replyBody"].value = text;
   
   if (text == "") {
      alert("All fields must be filled out");
      return false;
   }
   return true;
}