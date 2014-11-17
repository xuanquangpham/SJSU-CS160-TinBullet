<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="error.jsp" %>
<jsp:useBean id="db" scope="session" class="stickynotes.DBBean" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sticky Notes homepage</title>
<style type="text/css">
.text {
	font-family: Arial, Helvetica, sans-serif;
	font-size:12px;
}
</style>
<script>
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
   if (pwd1 != pwd2) {
	   alert("Password must be the same in both fields.");
	   return false;
   }
   return true;
}
</script>
</script>
</head>

<%
if (request.getParameter("username") != null) {
	String user = request.getParameter("username");
	String query = "SELECT username FROM users WHERE username='" + user + "' AND password='" + request.getParameter("password") + "'";
	if (db.isExist(query)) {
		session.setAttribute("username", user);
		response.sendRedirect("board.jsp");
	} else {
		out.println("<script>alert('The username/password you entered is incorrect. Please try again!!');</script>");
	}
}
%>

<body>
<table width="100%" border="0">
  <tr>
    <td height="70" colspan="4" bgcolor="#FFF573"><form action="index.jsp" method="post" name="login" onSubmit="return validateLoginForm()"><table height="70" border="0">
      <tr>
        <td width="50%" rowspan="2" align="center" valign="bottom"><img src="images/stickynotes_logo.png" width="266" alt="stickynotes_logo"></td>
        <td width="50" valign="bottom" class="text">Username</td>
        <td width="350" valign="bottom" class="text">Password</td>
      </tr>
      <tr>
        <td valign="top"><input type="text" name="username" id="username" tabindex="1"></td>
        <td valign="top"><input type="password" name="password" id="password" tabindex="2"><input name="Submit" type="submit" value="Login" tabindex="3"></td>
      </tr>
    </table></form></td>
  </tr>
  <tr>
    <td height="90%" width="6%">&nbsp;</td>
    <td><img src="images/logo.png" width="279" height="252" alt="logo"></td>
    <td><p><h1>Sign Up</h1></p>
    <p class="text">Sign up an account for free</p>
    <form name="signup" method="post" action="signup.jsp" onSubmit="return validateSignupForm()">
      <p class="text">
        <input name="firstname" type="text" id="firstname" size="50" placeholder="First Name" tabindex="4">
        <br>
<input name="lastname" type="text" id="lastname" size="50" placeholder="Last Name" tabindex="5" >
        <br>
		<input name="username" type="text" id="username" size="50" placeholder="User name" tabindex="6">
        <br>        
        <input name="email" type="text" id="email" size="50" placeholder="Email address" tabindex="7">
        <br>
        <input name="password1" type="password" id="password1" size="50" placeholder="Password" tabindex="8">
        <br>
        <input name="password2" type="password" id="password2" size="50" placeholder="Re-enter Password" tabindex="9">
        <br>
        <br><input type="checkbox" name="term" id="term" tabindex="10">
        By checking this box, you agree to the Terms <br>
        and Policy of the site .<br>
        <br>
        <input type="submit" name="signup" id="signup" value="Sign Up" tabindex="11">
      </p>
    </form>
    <p>&nbsp;</p></td>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>