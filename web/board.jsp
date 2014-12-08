<%@ include file="header.jsp" %> 

<table width="100%" border="0" >
  <tr valign="top">
    <td>
    <table width="100%" border="0" ><tr valign="top">
    
    <td width="30%"><table width="100%" border="0" cellpadding="15">
    
    <%
	query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=1";
	db.queryString(query);
	while(db.isNext()) {
		out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='center'><img src='images/pin_red.png' class='pin'></td></tr>");
      	out.print("<tr class='title'><td align='center'><a href='#'>"+db.getString("title")+"</a></td></tr>");
		String content = db.getString("content");
      	if (content.length() < 500)
			out.print("<tr valign='top' class='content'><td height='100'>"+content+"</td></tr>");
		else out.print("<tr valign='top' class='content'><td height='100'>"+content.substring(0,500)+" <i><a href='#'>more</a></i></td></tr>");
      	out.print("<tr class='seen'><td align='right'>Seen by "+db.getString("seen")+"</td></tr>");
      	out.print("<tr class='date'><td align='center'>posted "+db.getDate("date")+"</td></tr></table></td></tr>");
	}
    %>
  
    </table>
    
    <td width="30%"><table width="100%" border="0" cellpadding="15">
    
    <%
	query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=2";
	db.queryString(query);
	while(db.isNext()) {
		out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='center'><img src='images/pin_blue.png' class='pin'></td></tr>");
      	out.print("<tr class='title'><td align='center'><a href='#'>"+db.getString("title")+"</a></td></tr>");
		String content = db.getString("content");
      	if (content.length() < 500)
			out.print("<tr valign='top' class='content'><td height='100'>"+content+"</td></tr>");
		else out.print("<tr valign='top' class='content'><td height='100'>"+content.substring(0,500)+" <i><a href='#'>more</a></i></td></tr>");
      	out.print("<tr class='seen'><td align='right'>Seen by "+db.getString("seen")+"</td></tr>");
      	out.print("<tr class='date'><td align='center'>posted "+db.getDate("date")+"</td></tr></table></td></tr>");
	}
    %>
  
    </table>
    
    
    <td width="30%"><table width="100%" border="0" cellpadding="15">
    
    <%
	query = "SELECT p.id, p.title, p.content, p.date, p.position, p.seen FROM post p, user_board ub WHERE p.board_id=ub.board_id AND p.board_id="+project_id+" AND ub.user_id="+id+" AND type=3";
	db.queryString(query);
	while(db.isNext()) {
		out.print("<tr><td><table class='post' width='100%' cellpadding='5'><tr><td align='center'><img src='images/pin_green.png' class='pin'></td></tr>");
      	out.print("<tr class='title'><td align='center'><a href='#'>"+db.getString("title")+"</a></td></tr>");
		String content = db.getString("content");
      	if (content.length() < 500)
			out.print("<tr valign='top' class='content'><td height='100'>"+content+"</td></tr>");
		else out.print("<tr valign='top' class='content'><td height='100'>"+content.substring(0,500)+" <i><a href='#'>more</a></i></td></tr>");
      	out.print("<tr class='seen'><td align='right'>Seen by "+db.getString("seen")+"</td></tr>");
      	out.print("<tr class='date'><td align='center'>posted "+db.getDate("date")+"</td></tr></table></td></tr>");
	}
    %>
  
    </table>
    
    
    </td>
	<td>&nbsp;</td>
    
    </tr></table>
    </td>
    <td width="150"><a href="">New Note</a>
    <br><a href="">View Archive</a>
    </td>
  </tr>
</table>
</body>
</html>