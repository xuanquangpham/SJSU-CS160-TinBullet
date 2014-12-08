<%@ include file="header.jsp" %> 
<%
String post_id = request.getParameter("post");
if (post_id != null) {
	query = "UPDATE post SET position=0 WHERE id="+post_id;
	db.update(query); 
}
boolean all = (request.getParameter("archive") == null? false : true);
%>

<table width="100%" border="0" >
  <tr valign="top">
    <td>
    <table width="100%" border="0" ><tr valign="top">
    
    <td width="30%"><table width="100%" border="0" cellpadding="15">
    
    <%
	if (all)
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=1";
	else 
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=1 AND position > 0";
	db.queryString(query);
	while(db.isNext()) {
		if (all && db.getString("position").equals("0"))
			out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='right' width='60%'><img src='images/pin_red.png' class='pin'></td><td align='right' width='40%' style='color:red;'>saved!</td></tr>");
		else 
			out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='right' width='60%'><img src='images/pin_red.png' class='pin'></td><td align='right' width='40%'>" + (db.getString("author_id").equals(id)? "<a class='archive' href='board.jsp?post="+db.getString("id")+"'>X&nbsp;&nbsp;</a>" : "&nbsp;") + "</td></tr>");
			
      	out.print("<tr class='title'><td align='center' colspan='2'><a href='resultpage.jsp?postid="+db.getString("id")+"'>"+db.getString("title")+"</a></td></tr>");
		String content = db.getString("content");
      	if (content.length() < 500)
			out.print("<tr valign='top' class='content'><td height='100' colspan='2'>"+content+"</td></tr>");
		else out.print("<tr valign='top' class='content'><td height='100' colspan='2'>"+content.substring(0,500)+" <i><a href='resultpage.jsp?postid="+db.getString("id")+"'>more</a></i></td></tr>");
      	out.print("<tr class='seen'><td align='right' colspan='2'>Seen by "+db.getString("seen")+"</td></tr>");
      	out.print("<tr class='date'><td align='center' colspan='2'>posted "+ db.getTime("date") + " on "+db.getDate("date")+"</td></tr></table></td></tr>");
	}
    %>
  
    </table>
    
    <td width="30%"><table width="100%" border="0" cellpadding="15">
    
    <%
	if (all)
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=2";
	else 
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=2 AND position > 0";
	db.queryString(query);
	while(db.isNext()) {
		if (all && db.getString("position").equals("0"))
			out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='right' width='60%'><img src='images/pin_blue.png' class='pin'></td><td align='right' width='40%' style='color:red;'>saved!</td></tr>");
		else 
			out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='right' width='60%'><img src='images/pin_blue.png' class='pin'></td><td align='right' width='40%'>" + (db.getString("author_id").equals(id)? "<a class='archive' href='board.jsp?post="+db.getString("id")+"'>X&nbsp;&nbsp;</a>" : "&nbsp;") + "</td></tr>");
			
      	out.print("<tr class='title'><td align='center' colspan='2'><a href='resultpage.jsp?postid="+db.getString("id")+"'>"+db.getString("title")+"</a></td></tr>");
		String content = db.getString("content");
      	if (content.length() < 500)
			out.print("<tr valign='top' class='content'><td height='100' colspan='2'>"+content+"</td></tr>");
		else out.print("<tr valign='top' class='content'><td height='100' colspan='2'>"+content.substring(0,500)+" <i><a href='resultpage.jsp?postid="+db.getString("id")+"'>more</a></i></td></tr>");
      	out.print("<tr class='seen'><td align='right' colspan='2'>Seen by "+db.getString("seen")+"</td></tr>");
      	out.print("<tr class='date'><td align='center' colspan='2'>posted "+ db.getTime("date") + " on "+db.getDate("date")+"</td></tr></table></td></tr>");
	}
    %>
  
    </table>
    
    
    <td width="30%"><table width="100%" border="0" cellpadding="15">
    
    <%
	if (all)
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=3";
	else 
		query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen, p.author_id FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=3 AND position > 0";
	db.queryString(query);
	while(db.isNext()) {
		if (all && db.getString("position").equals("0"))
			out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='right' width='60%'><img src='images/pin_green.png' class='pin'></td><td align='right' width='40%' style='color:red;'>saved!</td></tr>");
		else 
			out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='right' width='60%'><img src='images/pin_green.png' class='pin'></td><td align='right' width='40%'>" + (db.getString("author_id").equals(id)? "<a class='archive' href='board.jsp?post="+db.getString("id")+"'>X&nbsp;&nbsp;</a>" : "&nbsp;") + "</td></tr>");
			
      	out.print("<tr class='title'><td align='center' colspan='2'><a href='resultpage.jsp?postid="+db.getString("id")+"'>"+db.getString("title")+"</a></td></tr>");
		String content = db.getString("content");
      	if (content.length() < 500)
			out.print("<tr valign='top' class='content'><td height='100' colspan='2'>"+content+"</td></tr>");
		else out.print("<tr valign='top' class='content'><td height='100' colspan='2'>"+content.substring(0,500)+" <i><a href='resultpage.jsp?postid="+db.getString("id")+"'>more</a></i></td></tr>");
      	out.print("<tr class='seen'><td align='right' colspan='2'>Seen by "+db.getString("seen")+"</td></tr>");
      	out.print("<tr class='date'><td align='center' colspan='2'>posted "+ db.getTime("date") + " on "+db.getDate("date")+"</td></tr></table></td></tr>");
	}
    %>
  
    </table>
    
    
    </td>
	<td>&nbsp;</td>
    
    </tr></table>
    </td>
    <td width="150"><a href="">New Note</a>
    <br><a href="board.jsp?archive=1">Show Archive</a>
    <br><a href="board.jsp">Hide Archive</a>
    </td>
  </tr>
</table>
</body>
</html>