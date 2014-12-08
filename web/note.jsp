<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="db" scope="session" class="stickynotes.DBBean" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Submitted</title>
</head>

<body>
<%
String title = request.getParameter("title");
String text = request.getParameter("body");
String author = session.getAttribute("username");
int author_id = session.getAttribute("id");
Date dt = new Date();
String date = dt.toString();//NEED TO FIX
int board = session.getAttribute("project_id");
int position = 1;
int type = request.getParameter("Tag");
String seen = "Seen by " + author;

String query = "INSERT INTO post (title, content, date, author_id, board_id, position, type, seen) VALUES('" + title + "', '" + text + "', '" + date + "', '" + author_id + "', '" + board + "', '" + position + "', '" + type + "', '" + seen + "')";
db.update(query); 

out.println("You have posted successfully. <br>The page will redirect in 5 seconds or click <a href='board.jsp'>here</a>");
out.println("<script>setTimeout(function delayer(){ window.location = 'board.jsp'},5000);</script>");
%> 
</body>
</html>