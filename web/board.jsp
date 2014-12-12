<%@ include file="header.jsp" %> 
<script type="text/javascript">
$(document).ready(function(){
    $("#divNewPost").hide();
	
    $('.new_post_show_hide').click(function(){
    	$("#divNewPost").slideToggle();
    });
});
</script>
<div id="divNewPost">
<form name="newPost" method="post" action="board.jsp" onSubmit="return validateNewPostForm()">
<p align="center" class="text"><br>Submit a New Note: (<a href='#' class='new_post_show_hide'>Close</a>)<br><br>
        <input name="noteTitle" type="text" id="noteTitle" size="50" placeholder="Note title"><br><br>
		<textarea name="noteBody" id="noteBody" rows="7" cols="48" placeholder="Enter in your message here." ></textarea><br><br>
        Tags: <input type="radio" name="tag" value="1" checked/>Alert<input type="radio" name="tag" value="2" />Question<input type="radio" name="tag" value="3" />Announcement<br><br>
        <input type="submit" name="btn_new_post" id="btn_new_post" value="Submit">
</p>
</form>
</div>

<%
//Check permissions of board
query = "SELECT id FROM user_board WHERE permission='0' AND board_id='"+(String)session.getAttribute("project_id")+"' AND user_id= '"+(String)session.getAttribute("id")+"'";
db.queryString(query);
if (db.isNext()) {
	out.println("<script>alert('You do not have permission to view this project!'); window.location.href = 'header.jsp';</script>");
}

// SUBMIT A NEW NOTE
if (request.getParameter("noteTitle") != null) {
	String title = db.escapeHTML(request.getParameter("noteTitle")); 
	String body = db.escapeHTML(request.getParameter("noteBody"));
	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	String date = dateFormat.format(new java.util.Date()).toString();
	int position = 1;
	String type = request.getParameter("tag");
	String seen = (String)session.getAttribute("username");
	String author_id = (String)session.getAttribute("id");
	String board_id = (String)session.getAttribute("project_id");

	query = "INSERT INTO post (title, content, date, author_id, board_id, position, type, seen) VALUES('" + title + "', '" + body + "', '" + date + "', " + author_id + ", " + board_id + ", " + position + ", '" + type + "', '" + seen + "')";
	db.update(query); 
}

// MOVE TO ARCHIVE
String post_id = request.getParameter("post");
if (post_id != null) {
	query = "UPDATE post SET position=0 WHERE id="+post_id;
	db.update(query); 
}

//Delete Post From Database
String delete_post = request.getParameter("post_delete");
if (delete_post != null) {
	query = "DELETE FROM post WHERE id="+delete_post;
	db.update(query);
	response.sendRedirect("board.jsp?archive=1");
}

//Reject request to join board
if (request.getParameter("request_reject") != null) {
	query = "SELECT id FROM users WHERE username='"+request.getParameter("member_name")+"'";
	db.queryString(query); db.isNext();
	String mid = db.getInt("id");
	query = "DELETE FROM user_board WHERE user_id='"+mid+"' AND board_id ='"+(String)session.getAttribute("project_id")+"'";
	db.update(query);
	response.sendRedirect("board.jsp");
}
//Accept request to join board
if(request.getParameter("request_accept") != null) {
	query = "SELECT id FROM users WHERE username='"+request.getParameter("member_name")+"'";
	db.queryString(query); db.isNext();
	String mid = db.getInt("id");
	query = "UPDATE user_board SET permission=1 WHERE user_id='"+mid+"' AND board_id ='"+(String)session.getAttribute("project_id")+"'";
	db.update(query);
	response.sendRedirect("board.jsp");
}

//Remove yourself from board
if(request.getParameter("unsub") != null) {
	query = "DELETE FROM user_board WHERE user_id='"+(String)session.getAttribute("id")+"' AND board_id='"+(String)session.getAttribute("project_id")+"'";
	db.update(query);
	query = "Select board_id FROM user_board WHERE user_id = '"+(String)session.getAttribute("id")+"'";
	db.queryString(query); db.isNext();
	String refresh_board_id = db.getInt("id");
	session.setAttribute("project_id", refresh_board_id);
	response.sendRedirect("header.jsp");
}

// display mode: active note or archive including
boolean all = (request.getParameter("archive") == null? false : true);
%>

<table width="100%" border="0" >
  <tr valign="top">
    <td>
    <table width="100%" border="0" ><tr valign="top">
    
    <td width="30%"><table width="100%" border="0" cellpadding="15">
    <td><p style="font-size: 24px; text-align:center; font-weight:bold ">Alerts</p></td>
    <%
	if (all)
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=1 ORDER BY p.date DESC";
	else 
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=1 AND position > 0 ORDER BY p.date DESC";
	db.queryString(query);
	while(db.isNext()) {
		if (all && db.getString("position").equals("0"))
			out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='right' width='60%'><img src='images/pin_red.png' class='pin'></td><td align='right' width='40%' style='color:red;'>" + (db.getString("author_id").equals(id)? "<div class='option_delete'><span class='replace'>saved!</span><span class='replaced'><a href='board.jsp?post_delete="+db.getString("id")+"' title='Permenantly Delete This Post' class='delete_post'>DELETE</a></span></div>" : "saved!") +"</td></tr>");
		else 
			out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='right' width='60%'><img src='images/pin_red.png' class='pin'></td><td align='right' width='40%'>" + (db.getString("author_id").equals(id)? "<a class='archive' title='Move to Archive'  href='board.jsp?post="+db.getString("id")+"'>X&nbsp;&nbsp;</a>" : "&nbsp;") + "</td></tr>");
			
      	out.print("<tr><td align='center' colspan='2'  class='title'><a href='resultpage.jsp?postid="+db.getString("id")+"'>"+db.getString("title")+"</a></td></tr>");
		String content = db.getString("content");
      	if (content.length() < 500)
			out.print("<tr valign='top' class='content'><td height='100' colspan='2'>"+content+"</td></tr>");
		else out.print("<tr valign='top' class='content'><td height='100' colspan='2'>"+content.substring(0,500)+"... <a href='resultpage.jsp?postid="+db.getString("id")+"'>more</a></td></tr>");
      	out.print("<tr class='seen'><td align='right' colspan='2'>Seen by "+db.getString("seen")+"</td></tr>");
      	out.print("<tr class='date'><td align='center' colspan='2'>posted "+ db.getTime("date") + " on "+db.getDate("date")+"</td></tr></table></td></tr>");
	}
    %>
  
    </table>
    
    <td width="30%"><table width="100%" border="0" cellpadding="15">
    <td><p style="font-size: 24px; text-align:center; font-weight:bold ">Questions</p></td>
    <%
	if (all)
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=2 ORDER BY p.date DESC";
	else 
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=2 AND position > 0 ORDER BY p.date DESC";
	db.queryString(query);
	while(db.isNext()) {
		if (all && db.getString("position").equals("0"))
			out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='right' width='60%'><img src='images/pin_blue.png' class='pin'></td><td align='right' width='40%' style='color:red;'>" + (db.getString("author_id").equals(id)? "<div class='option_delete'><span class='replace'>saved!</span><span class='replaced'><a href='board.jsp?post_delete="+db.getString("id")+"' title='Permenantly Delete This Post' class='delete_post'>DELETE</a></span></div>" : "saved!") +"</td></tr>");
		else 
			out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='right' width='60%'><img src='images/pin_blue.png' class='pin'></td><td align='right' width='40%'>" + (db.getString("author_id").equals(id)? "<a class='archive' title='Move to Archive' href='board.jsp?post="+db.getString("id")+"'>X&nbsp;&nbsp;</a>" : "&nbsp;") + "</td></tr>");
			
      	out.print("<tr ><td align='center' colspan='2'  class='title'><a href='resultpage.jsp?postid="+db.getString("id")+"'>"+db.getString("title")+"</a></td></tr>");
		String content = db.getString("content");
      	if (content.length() < 500)
			out.print("<tr valign='top' class='content'><td height='100' colspan='2'>"+content+"</td></tr>");
		else out.print("<tr valign='top' class='content'><td height='100' colspan='2'>"+content.substring(0,500)+"... <a href='resultpage.jsp?postid="+db.getString("id")+"'>more</a></td></tr>");
      	out.print("<tr class='seen'><td align='right' colspan='2'>Seen by "+db.getString("seen")+"</td></tr>");
      	out.print("<tr class='date'><td align='center' colspan='2'>posted "+ db.getTime("date") + " on "+db.getDate("date")+"</td></tr></table></td></tr>");
	}
    %>
  
    </table>
    
    
    <td width="30%"><table width="100%" border="0" cellpadding="15">
    <td><p style="font-size: 24px; text-align:center; font-weight:bold ">Announcements</p></td>
    <%
	if (all)
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=3 ORDER BY p.date DESC";
	else 
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=3 AND position > 0  ORDER BY p.date DESC";
	db.queryString(query);
	while(db.isNext()) {
		if (all && db.getString("position").equals("0"))
			out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='right' width='60%'><img src='images/pin_green.png' class='pin'></td><td align='right' width='40%' style='color:red;'>" + (db.getString("author_id").equals(id)? "<div class='option_delete'><span class='replace'>saved!</span><span class='replaced'><a href='board.jsp?post_delete="+db.getString("id")+"' title='Permenantly Delete This Post' class='delete_post'>DELETE</a></span></div>" : "saved!") +"</td></tr>");
		else 
			out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='right' width='60%'><img src='images/pin_green.png' class='pin'></td><td align='right' width='40%'>" + (db.getString("author_id").equals(id)? "<a class='archive'  title='Move to Archive' href='board.jsp?post="+db.getString("id")+"'>X&nbsp;&nbsp;</a>" : "&nbsp;") + "</td></tr>");
			
      	out.print("<tr><td align='center' colspan='2'  class='title'><a href='resultpage.jsp?postid="+db.getString("id")+"'>"+db.getString("title")+"</a></td></tr>");
		String content = db.getString("content");
      	if (content.length() < 500)
			out.print("<tr valign='top' class='content'><td height='100' colspan='2'>"+content+"</td></tr>");
		else out.print("<tr valign='top' class='content'><td height='100' colspan='2'>"+content.substring(0,500)+"... <a href='resultpage.jsp?postid="+db.getString("id")+"'>more</a></td></tr>");
      	out.print("<tr class='seen'><td align='right' colspan='2'>Seen by "+db.getString("seen")+"</td></tr>");
      	out.print("<tr class='date'><td align='center' colspan='2'>posted "+ db.getTime("date") + " on "+db.getDate("date")+"</td></tr></table></td></tr>");
	}
    %>
  
    </table>
    
    
    </td>
	<td>&nbsp;</td>
    
    </tr></table>
    </td>
	<td width="150">
		<input type="button" name="newnote" id="newnote" value="New Note" class="new_post_show_hide"`>
		<br/><br>
		<input type="button" name="showarchive" id="showarchive" value="Show Archive" onClick="location.href = 'board.jsp?archive=1';" class="btnSize">
        <br/><br>
		<input type="button" name="hidearhive" id="hidearchive" value="Hide Archive"  class="btnSize" onClick="location.href = 'board.jsp';">
        <br/><br>
        <form method="post" action="board.jsp"> 
        <select name="member_name" id="membership_requests" class="btnSize">
        <%
		query = "SELECT username, firstname, lastname FROM user_board ub, users u WHERE ub.permission='0' AND ub.board_id='"+(String)session.getAttribute("project_id")+"' AND ub.user_id=u.id";
		db.queryString(query);
		i = 0;
		while (db.isNext()) {
			i++;
			out.println("<option value='"+ db.getString("username") +"'>" + db.getString("firstname") + " " + db.getString("lastname") +"</option>");
		}
		if (i == 0) {
			out.println("<option value='0'>No requests</option>");
		}
		%>
      </select> 
      <button type="submit" value="Accept" name="request_accept" id="request_accept" class="optionBtn" <% if(i==0) out.print("disabled"); %> >Accept</button>
      <button type="submit" value="Reject" name="request_reject" id="request_reject" class="optionBtn" <% if(i==0) out.print("disabled"); %> >Reject</button>
      </form>
      <br/><br>
      <form method="post" action="board.jsp">
      <button type="submit" value="Unsubscribe" name="unsub" id="unsub" class="btnSize">Unsubscribe</button>
      </form>
	</td>
  </tr>
</table>
</body>
</html>