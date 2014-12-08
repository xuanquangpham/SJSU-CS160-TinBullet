<%@ include file="header.jsp" %> 
<div id="newPost" style="position: absolute; z-index: 3; top: 100px; left: 100px; visibility: hidden;"> 
<form action="note.jsp" method="post"> 
<table bgcolor="#FFFFCC" border="10px" style="width:100%; height:100%"> 
	<tr>
    	<td colspan="5">Submit New Note</td>
        <td><button id="close" type="button" onClick="closeLayer()">X</button>
    </tr>
    <tr>
    	<td><p>Title<input type="text" name="title" size="35" placeholder="Example Title" /></p> </td>
        <td align="center" valign="bottom">Tags</td>
    </tr>
    <tr>
    	<td valign="top"><textarea name="body" rows="5" cols="50" maxlength="500" placeholder="Enter in your message here." style="height:300px; width:500px"></textarea></td>
        <td align="left" valign="top" ><p><input type="radio" name="Tag" value="1" checked/>Alert</p>
        <p><input type="radio" name="Tag" value="2" />Question</p><p><input type="radio" name="Tag" value="3" />Announcement</p></td>
     </tr>
    <tr>
    	<td><input type="submit" name="submit" value="Submit" />
</table>
</form> </div>
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
	<td width="150">
		<input type="submit" name="new note" id="newnote" value="New Note" onClick="toggleLayer()" style="width:200px">
		<br/>
		<input type="submit" name="view archive" id="viewarchive" value="View Archive" style="width:200px">
	</td>
  </tr>
</table>
<script>
function toggleLayer() {
	document.getElementById("newPost").setAttribute("style", "visibility:visible;");
	//document.getElementById("blur").setAttribute("style", "visibility:visible;");
}
function closeLayer() {
	document.getElementById("newPost").setAttribute("style", "display:none;");
	//document.getElementById("blur").setAttribute("style", "visibility:hidden;");
}
</script>
</body>
</html>