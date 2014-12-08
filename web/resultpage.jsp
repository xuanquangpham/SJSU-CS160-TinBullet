<%@ include file="header.jsp" %> 

<style type="text/css">
td.poster {
	width: 15%;
}
td.postbody {
	width: 50%;
}
</style>


<%
	int postid = Integer.parseInt(request.getParameter("postid"));
	query = "SELECT p.title, p.content, p.author_id, p.date FROM post p WHERE p.id = "+postid;
	db.queryString(query);
	db.isNext();
	String title = db.getString("title");
	String content = db.getString("content");
	String date = db.getString("date");
	int userid = Integer.parseInt(db.getString("author_id"));
	query = "SELECT u.username FROM users u WHERE u.id = "+userid;
	db.queryString(query);
	db.isNext();
	String author = db.getString("username");
%>

<center><h1><%out.print(title);%></h1></center>
<table style="border-collapse: collapse;" width="100%" border="0">

  <tr>
    <td height="90%" width="6%">&nbsp;</td>

    <td class="poster" style="border:1px solid" height="90%" width="6%" colspan="2" bgcolor="#FFF573"><p><h1>Priority 1</h1></p>
    <p class="text"><%out.print(author);%></p>
	<p class="text"><%out.print(date);%></p>
	<br/>
	
	<td class="postbody" style="border:1px solid" height="70" colspan="2" bgcolor="#FFF573"><br/><p><%out.print(content);%></p>

    <p>&nbsp;</p></td>
    <td><input type="submit" name="post response" id="postresponse" value="Post Response" style="width:200px">
		<br/>
		<input type="submit" name="add new priority" id="addpriority" value="Add New Priority" style="width:200px">
		<br/>
		<input type="submit" name="change priority" id="changepriority" value="Change Priorities" style="width:200px"></td>
  </tr>
  <%
	query = "SELECT u.username, d.content, d.author_id, d.date FROM discussion d INNER JOIN users u ON u.id = d.author_id AND d.post_id = "+postid;
	db.queryString(query);
	int priority = 2;
	while(db.isNext()){
		content = db.getString("content");
		date = db.getString("date");
		author = db.getString("username");
		out.print("<tr><td height='90%' width='6%'>&nbsp;</td><td class='poster' style='border:1px solid' height='90%' width='6%' colspan='2' bgcolor='#FFF573'><p><h1>Priority "
			+ priority +"</h1></p><p class='text'>"+author+"</p><p class='text'>"+date
			+"</p><br/><td class='postbody' style='border:1px solid' height='70' colspan='2' bgcolor='#FFF573'><br/><p>"+content
			+"</p><p>&nbsp;</p></td></tr>");
		priority++;
	}
  %>
</table>
</body>
</html>