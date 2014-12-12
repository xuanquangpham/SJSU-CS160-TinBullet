<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="error.jsp" %>
<jsp:useBean id="db" scope="session" class="stickynotes.DBBean" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mainboard</title>
<script src="scripts/jquery.js" type="text/javascript"></script>
<script src="scripts/validate.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/board.css">
</head>
<%
String username = (String)session.getAttribute("username");
String query = "";

String id = "";
query = "SELECT id FROM users WHERE username='"+username+"'";
db.queryString(query); db.isNext();
id = db.getInt("id");
session.setAttribute("id",id);

String project_id = (String)session.getAttribute("project_id");
if (project_id == null) project_id = "0";

if (request.getParameter("project") != null) {
	project_id = request.getParameter("project");
	session.setAttribute("project_id",project_id);
}

// ADD NEW PROJECT INTO USER ACCOUNT
if (request.getParameter("add_project") != null) {
	query = "INSERT INTO user_board(user_id,board_id,permission) VALUES("+id+","+request.getParameter("add_project")+",0)";
	db.update(query);
}

// Create new project in boards table and inserts it into user account
if (request.getParameter("add_new_project") != null) {
	String newproj = (String) request.getParameter("add_new_project");
	query = "SELECT name FROM boards WHERE name='"+newproj+"'";
	db.queryString(query); 
	if(db.isNext() == true) {
		out.print("<script>alert('Project already exists');</script>");
	}
	else {
			query = "INSERT INTO boards(name) VALUES('"+newproj+"')";
			db.update(query);
			query = "SELECT id FROM boards WHERE name='"+newproj+"'";
			db.queryString(query); db.isNext();
			String board_id = (String) db.getInt("id");
			query = "INSERT INTO user_board(user_id,board_id,permission) VALUES('"+id+"','"+board_id+"','10')";
			db.update(query);
			session.setAttribute("project_id",board_id);
			response.sendRedirect("board.jsp");
		}
}

// ADD NEW MEMBER INTO PROJECT
if (request.getParameter("add_member") != null) {
	query = "SELECT id FROM users WHERE username='"+request.getParameter("add_member")+"'";
	db.queryString(query); db.isNext();
	String mid = db.getInt("id");
	query = "INSERT INTO user_board(user_id,board_id,permission) VALUES("+mid+","+project_id+",1)";
	db.update(query);
}

// UPDATE USER INFO
if (request.getParameter("firstname") != null) {
	query = "UPDATE users SET firstname='"+request.getParameter("firstname")+"', lastname='"+request.getParameter("lastname")+"', email='"+request.getParameter("email")+"', password='"+request.getParameter("password1")+"' WHERE id ="+id;
	db.update(query);
}
%>
<body>
<script type="text/javascript">
$(document).ready(function(){
    $("#divInfo").hide();
	$("#divProject").hide();
	$("#divMember").hide();
	$("#divNewProject").hide();
 
    $('.info_show_hide').click(function(){
    	$("#divInfo").slideToggle();
    });
	
	$('.project_show_hide').click(function(){
    	$("#divProject").slideToggle();
    });
	
	$('.newproject_show_hide').click(function(){
    	$("#divNewProject").slideToggle();
    });
 
    $('.member_show_hide').click(function(){
    	$("#divMember").slideToggle();
    });
});
</script>
<form action="board.jsp" method="post">
<table class="text" width="100%" border="0"><tr><td  bgcolor="#FFF573">
<table width="100%" border="0">
  <tr>
    <td class = "panel">Projects 
      <select name="project" id="project" class="panel">
        <%
		query = "SELECT b.id, b.name FROM users u, boards b, user_board ub " +
					"WHERE u.id = ub.user_id AND b.id = ub.board_id AND u.username = '" + username + "'";
		db.queryString(query);
		int i = 0;
		while (db.isNext()) {
			String pid = db.getInt("id");
			if (i++ == 0 && project_id.equals("0")) {
				project_id = pid;
				session.setAttribute("project_id", pid);
			}
			if (pid.equals(project_id))
				out.println("<option value='"+ pid +"' selected='selected'>" + db.getString("name") + "</option>");
			else
				out.println("<option value='"+ pid +"'>" + db.getString("name") + "</option>");
			
		}
		%>
        <option value="0" class="project_show_hide">&lt;Add new project&gt;</option>
      </select>&nbsp;<input type="submit" name="btn_project_refresh" id="btn_project_refresh" value="Go" class="panel"> <input type="button" name="btn_create_project" id="btn_create_project" value="Create" onClick="location.href = '#';" class="newproject_show_hide" style="font-family: Arial, Helvetica, sans-serif;
	font-size:15px;"> <form method="post" action="board.jsp">
      <button type="submit" value="Unsubscribe" name="unsub" id="unsub" style="font-family: Arial, Helvetica, sans-serif;
	font-size:15px;">Unsubscribe</button>
      </form>
      &nbsp;&nbsp;&nbsp;&nbsp;Members  
      <label for="member"></label>
    <select name="member" id="member" class="panel">
    	<%
		query = "SELECT u.username, u.firstname, u.lastname FROM users u, boards b, user_board ub " +
					"WHERE u.id = ub.user_id AND b.id = ub.board_id AND u.username <> '" + username + "' AND b.id=" + project_id;
		db.queryString(query);
		while (db.isNext()) {
			out.println("<option value='"+ db.getString("username") +"'>" + db.getString("firstname") + " " + db.getString("lastname") +"</option>");
		}
		%>
      <option value="0" class="member_show_hide">&lt;Add new member&gt;</option>
    </select></td>
    <td width="200" align="right" class="panel"><% out.print("<a href='#' class='info_show_hide'>" + username + "</a> / <a href='index.jsp?logout=1'>logout</a>"); %>&nbsp;</td> 
  </tr>
</table></td></tr></table></form>

<div id="divProject">
<form method="post" action="board.jsp">
<p align="center" class="text"><br>Add new project: (<a href='#' class='project_show_hide'>Close</a>)<br><br>
        <select name="add_project" id="add_project">
        <%
		query = "SELECT id, name FROM boards WHERE id NOT IN (SELECT b.id FROM users u, boards b, user_board ub " +
					"WHERE u.id = ub.user_id AND b.id = ub.board_id AND u.username = '" + username + "')";
		db.queryString(query);
		i = 0;
		while (db.isNext()) {
			i++;
			String bid = db.getInt("id");
			out.println("<option value='"+ bid +"'>" + db.getString("name") + "</option>");
		}
		if (i == 0) {
			out.println("<option value='0'>No project's available</option>");
		}
		%>
      </select><br><br>
        <input type="submit" name="btn_project" id="btn_project" value="Add" <% if (i==0) out.print("disabled"); %>>
</p>
</form>
</div>

<div id="divNewProject" style="background-color: #99CCFF;
	margin-left: auto;
    margin-right: auto;
    top:150px;
	width: 400px;
    border-bottom:5px solid #3399FF;">
<form method="post" action="board.jsp">
<p align="center" class="text"><br>Create new project: (<a href='#' class='newproject_show_hide'>Close</a>)<br><br>
      <input type="text" name="add_new_project" id="add_new_project" size="15" maxlength="15" placeholder="New Project Name" /><br><br>
        <input type="submit" name="btn_new_project" id="btn_new_project" value="Create">
</p>
</form>
</div>

<div id="divMember">
<form method="post" action="board.jsp">
<p align="center" class="text"><br>Add new member: (<a href='#' class='member_show_hide'>Close</a>)<br><br>
        <select name="add_member" id="add_member">
        <%
		query = "SELECT id, username, firstname, lastname FROM users WHERE id NOT IN (SELECT u.id FROM users u, boards b, user_board ub WHERE u.id = ub.user_id AND b.id = ub.board_id AND u.username <> '" + username + "' AND b.id=" + project_id + ") AND username <> '"+username+ "'";
		db.queryString(query);
		i = 0;
		while (db.isNext()) {
			i++;
			out.println("<option value='"+ db.getString("username") +"'>" + db.getString("firstname") + " " + db.getString("lastname") +"</option>");
		}
		if (i == 0) {
			out.println("<option value='0'>No member's available</option>");
		}
		%>
      </select><br><br>
        <input type="submit" name="btn_member" id="btn_member" value="Add" <% if (i==0) out.print("disabled");%>>
</p>
</form>
</div>

<div id="divInfo">
<form name="infoForm" method="post" action="board.jsp" onSubmit="return validateInfoForm()">
<p align="center" class="text"><br>Modify account information: (<a href='#' class='info_show_hide'>Close</a>)<br><br>
		<%
		query = "SELECT firstname, lastname, email, password FROM users WHERE username='"+username+"'";
		db.queryString(query);
		db.isNext();
		%>
        <input name="firstname" type="text" id="firstname" size="50" placeholder="First Name" value='<%=db.getString("firstname")%>'><br>
		<input name="lastname" type="text" id="lastname" size="50" placeholder="Last Name" value='<%=db.getString("lastname")%>'><br>     
        <input name="email" type="text" id="email" size="50" placeholder="Email address" value='<%=db.getString("email")%>'><br>
        <input name="password1" type="password" id="password1" size="50" placeholder="Password" value='<%=db.getString("password")%>'><br>
        <input name="password2" type="password" id="password2" size="50" placeholder="Re-enter Password" value='<%=db.getString("password")%>'><br><br>
        <input type="submit" name="btn_info" id="btn_info" value="Update">
</p>
</form>
</div>
<br>