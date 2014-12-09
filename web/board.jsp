<%@ include file="header.jsp" %> 
<h2><p align="center">Main Board</p></h2>
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
// SUBMIT A NEW NOTE
if (request.getParameter("noteTitle") != null) {
	String title = request.getParameter("noteTitle");
	String body = request.getParameter("noteBody");
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

// display mode: active note or archive including
boolean all = (request.getParameter("archive") == null? false : true);
%>

<table width="100%" border="0" >
  <tr valign="top">
    <td>
    <table width="100%" border="0" ><tr valign="top">
    
    <td width="30%"><table width="100%" border="0" cellpadding="15">
    
    <%
	if (all)
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=1 ORDER BY p.date DESC";
	else 
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=1 AND position > 0 ORDER BY p.date DESC";
	db.queryString(query);
	while(db.isNext()) {
		if (all && db.getString("position").equals("0"))
			out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='right' width='60%'><img src='images/pin_red.png' class='pin'></td><td align='right' width='40%' style='color:red;'>saved!</td></tr>");
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
    
    <%
	if (all)
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=2 ORDER BY p.date DESC";
	else 
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=2 AND position > 0 ORDER BY p.date DESC";
	db.queryString(query);
	while(db.isNext()) {
		if (all && db.getString("position").equals("0"))
			out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='right' width='60%'><img src='images/pin_blue.png' class='pin'></td><td align='right' width='40%' style='color:red;'>saved!</td></tr>");
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
    
    <%
	if (all)
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=3 ORDER BY p.date DESC";
	else 
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=3 AND position > 0  ORDER BY p.date DESC";
	db.queryString(query);
	while(db.isNext()) {
		if (all && db.getString("position").equals("0"))
			out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='right' width='60%'><img src='images/pin_green.png' class='pin'></td><td align='right' width='40%' style='color:red;'>saved!</td></tr>");
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
	</td>
  </tr>
</table>
</body>
</html>