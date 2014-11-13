<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<%@ page import="java.sql.*" %>

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

<jsp:declaration>

Statement stmt;
Connection con;
ResultSet rs; 
String url = "jdbc:mysql://localhost:3306/StickyNotes2";
String query = "select id, username, firstname, lastname, email, password from Users";
</jsp:declaration>

<jsp:scriptlet><![CDATA[

Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection(url, "root", "root"); 
stmt = con.createStatement();
rs = stmt.executeQuery(query); 
out.println("<table border='1'><tr><td>id</td><td>tableusername</td><td>firstname</td><td>lastname</td><td>email</td><td>password</td></tr>");
while(rs.next()){
    int id = rs.getInt("id");
    String username = rs.getString("username");
    String firstname = rs.getString("firstname");
    String lastname = rs.getString("lastname");
    String email = rs.getString("email");
    String password = rs.getString("password");
    out.println("<tr><td>"+id+"</td><td>" + username + "</td><td>" +firstname+ "</td><td>"+lastname+ "</td><td>" +email+ "</td><td>" +password+"</td></tr>");
}
out.println("</tr></table>");
con.close();

]]></jsp:scriptlet>
<h1>Homepage screenshot</h1>
<div><span id="docs-internal-guid-8b667bdf-a6e6-e47a-b693-d22299f6ba3a"><img src="https://lh6.googleusercontent.com/_3tCddFjkPrt3G8Nfb8KcOWxw9nY0mUNN7UxGr59hEfyKQjr5dTpHMmr0zU1WJ2XFb5QxAJLyMPEO8jMTSohBsb-zSZ3N680m2GTpUlhG7tCb20xYwfA5ol3y1nAydlfag" alt="login" width="624px;" height="429px;"/></span></div>
</body>
</html>