<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="error.jsp" %>
<jsp:useBean id="db" scope="session" class="stickynotes.DBBean" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sign up</title>
</head>
<%
String user = request.getParameter("username");
String fname = request.getParameter("firstname");
String lname = request.getParameter("lastname");
String email = request.getParameter("email");
String pwd = request.getParameter("password1");

if (db.isExist("users", "username", user)) {
	out.println("The username is already existed. Please choose a diffrent one.<br>The page will redirect in 5 seconds or click <a href='index.jsp'>here</a>");
	out.println("<script>setTimeout(function delayer(){ window.location = 'index.jsp'},5000);</script>");
} else {
	String query = "INSERT INTO users(username, firstname, lastname, email, password) VALUES('"+ user + "','" + fname + "','" + lname +"','" + email + "','" + pwd + "')";
	db.update(query);
	session.setAttribute("username", user);
	
	out.println("Your account added successfully.<br>The page will redirect in 5 seconds or click <a href='board.jsp'>here</a>");
	out.println("<script>setTimeout(function delayer(){ window.location = 'board.jsp'},5000);</script>");
}
%>
<body>
</body>
</html>