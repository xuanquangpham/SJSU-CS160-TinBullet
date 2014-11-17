<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<jsp:useBean id="db" scope="session" class="stickynotes.DBBean" />

<html>
<head>
<title>MySQL Database creation</title>
<style>
* { font-size: 12px; font-family: Verdana }
</style>
</head>
<body>

<h1>Welcome to StickyNotes</h1>
<p>The Ant development is set up successfully with Tomcat server and MySQL server</p>
<p>Below are some information retrieve form sample data</p>

<%!
String query = "select id, username, firstname, lastname, email, password from Users";
%>

<%

db.queryString(query);
out.println("<table border='1'><tr><td>id</td><td>tableusername</td><td>firstname</td><td>lastname</td><td>email</td><td>password</td></tr>");
while(db.isNext()){
    String id = db.getInt("id");
    String username = db.getString("username");
    String firstname = db.getString("firstname");
    String lastname = db.getString("lastname");
    String email = db.getString("email");
    String password = db.getString("password");
    out.println("<tr><td>"+id+"</td><td>" + username + "</td><td>" +firstname+ "</td><td>"+lastname+ "</td><td>" +email+ "</td><td>" +password+"</td></tr>");
}
out.println("</tr></table>");
db.close();

%>
<h1>Homepage screenshot</h1>
<div><span id="docs-internal-guid-8b667bdf-a6e6-e47a-b693-d22299f6ba3a"><img src="https://lh6.googleusercontent.com/_3tCddFjkPrt3G8Nfb8KcOWxw9nY0mUNN7UxGr59hEfyKQjr5dTpHMmr0zU1WJ2XFb5QxAJLyMPEO8jMTSohBsb-zSZ3N680m2GTpUlhG7tCb20xYwfA5ol3y1nAydlfag" alt="login" width="624px;" height="429px;"/></span></div>
</body>
</html>