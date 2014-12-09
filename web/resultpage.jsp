<%@ include file="header.jsp" %> 

<script type="text/javascript">
$(document).ready(function(){
    $("#divReply").hide();
	
    $('.reply_show_hide').click(function(){
    	$("#divReply").slideToggle();
    });
});
</script>
<div id="divReply">
<form name="newReply" method="post" action="resultpage.jsp" onSubmit="return validateReply()">
<p align="center" class="text"><br>Submit a Reply to the Note: (<a href='#' class='reply_show_hide'>Close</a>)<br><br>
		<textarea name="replyBody" id="replyBody" rows="7" cols="48" placeholder="Enter in your message here." ></textarea><br><br>
        Priorities: <input type="radio" name="tag" value="1" checked/>Red<input type="radio" name="tag" value="2" />Blue<input type="radio" name="tag" value="3" />Green<br><br>
        <input type="submit" name="btn_reply" id="btn_reply" value="Submit">
</p>
</form>
</div>

<%
String postid = request.getParameter("postid");
if (postid == null) postid = (String)session.getAttribute("post_id");
else session.setAttribute("post_id",postid);

// CHANGE PRIORITY
if (request.getParameter("dis") != null) {
	String dis_id = request.getParameter("dis");
	String priority = request.getParameter("priority");
	query = "UPDATE discussion SET priority="+priority+" WHERE id="+dis_id;
	db.update(query);
}

// SUBMIT A REPLY
if (request.getParameter("replyBody") != null) {
	String body = request.getParameter("replyBody");
	String tag = request.getParameter("tag");
	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	String date = dateFormat.format(new java.util.Date()).toString();
	String author_id = (String)session.getAttribute("id");

	query = "INSERT INTO discussion (content, author_id, post_id, date, priority) VALUES('" + body + "', " + author_id + ", " + postid + ", '"+ date +"'," + tag + ")";
	db.update(query); 
}

// GET POST INFO
query = "SELECT p.title, p.content, p.author_id, p.date, p.seen, p.position FROM post p WHERE p.id = "+postid;
db.queryString(query);
db.isNext();
String title = db.getString("title");
String content = db.getString("content");
String date = db.getDate("date");
String time = db.getTime("date");
String seen = db.getString("seen");
int userid = Integer.parseInt(db.getString("author_id"));
query = "SELECT u.firstname, u.lastname FROM users u WHERE u.id = "+userid;
db.queryString(query);
db.isNext();
String author_fn = db.getString("firstname");
String author_ln = db.getString("lastname");
String pos = db.getString("position");

// ADD "SEEN" to the post
if (seen.indexOf(username) == -1) {
	seen = seen + ", " + username;
	query = "UPDATE post SET seen='"+seen+"' WHERE id = "+postid;
	db.update(query); 
}

%>

<center><h1>Note Details</h1></center>
<table style="border-collapse: collapse;" width="100%" border="0" cellpadding="10">

  <tr>
    <td height="90%" width="6%">&nbsp;</td>

    <td class="poster" style="border:1px solid" height="90%" width="6%" colspan="2" bgcolor="#FEFCBA" align="center"><p>
    <h3>Author</h3></p>
    <p class="text"><h2><%out.print(author_fn + " " + author_ln);%></h2></p>
	<p class="text"><%out.print("Posted "+ time+ " on " + date);%></p>
	<br/>
	
	<td class="postbody" style="border:1px solid" height="70" colspan="2" bgcolor="#FEFCBA"><h3><p align="center"><%=title%></p></h3><p><%=content%></p>

    <p>&nbsp;</p></td><td witdh="10%">&nbsp;</td>
    <td width='150'><input type='button' name='mainboard' id='mainboard' value='Main Board' class='btnSize' onClick='location.href ="board.jsp";' >
    <%
	if (!pos.equals("0")) {
		out.print("<br><br><input type='button' name='reply' id='reply' value='Reply' class='reply_show_hide'></td>");
	} else out.print("</td>");
	%>
  </tr>
  <%
  	//RED priority
	query = "SELECT u.firstname, u.lastname, d.id, d.content, d.author_id, d.date FROM discussion d INNER JOIN users u ON u.id = d.author_id AND d.post_id = "+postid + " AND d.priority=1 ORDER BY d.date DESC";
	db.queryString(query);
	while(db.isNext()){
		content = db.getString("content");
		date = db.getDate("date");
		time = db.getTime("date");
		author_fn = db.getString("firstname");
		author_ln = db.getString("lastname");
		out.print("<tr><td height='90%' width='6%'>&nbsp;</td><td class='poster' style='border:1px solid' height='90%' width='6%' colspan='2' bgcolor='#F3625E' align='center'><p class='text'><h2>"+author_fn + " " + author_ln+
		"</h2><br>Change priority: <input class='radioBlue' type='button' onClick='location.href = \"resultpage.jsp?dis="+db.getString("id")+"&priority=2\";'/> "+
		"<input class='radioGreen' type='button' onClick='location.href= \"resultpage.jsp?dis="+db.getString("id")+"&priority=3\";'/> "+
		"</p><p class='text'>"+"Posted "+ time+ " on " + date
			+"</p><br/><td class='postbody' style='border:1px solid' height='70' colspan='2' bgcolor='#F3625E'><br/><p>"+content+"</p></td></tr>");
	}
	
	//BLUE prority
	query = "SELECT u.firstname, u.lastname, d.id, d.content, d.author_id, d.date FROM discussion d INNER JOIN users u ON u.id = d.author_id AND d.post_id = "+postid + " AND d.priority=2 ORDER BY d.date DESC";
	db.queryString(query);
	while(db.isNext()){
		content = db.getString("content");
		date = db.getDate("date");
		time = db.getTime("date");
		author_fn = db.getString("firstname");
		author_ln = db.getString("lastname");
		out.print("<tr><td height='90%' width='6%'>&nbsp;</td><td class='poster' style='border:1px solid' height='90%' width='6%' colspan='2' bgcolor='#3399FF' align='center'><p class='text'><h2>"+author_fn + " " + author_ln+
		"</h2><br>Change priority: <input class='radioRed' type='button' onClick='location.href = \"resultpage.jsp?dis="+db.getString("id")+"&priority=1\";'/> "+
		"<input class='radioGreen' type='button' onClick='location.href= \"resultpage.jsp?dis="+db.getString("id")+"&priority=3\";'/> "+
		"</p><p class='text'>"+"Posted "+ time+ " on " + date
			+"</p><br/><td class='postbody' style='border:1px solid' height='70' colspan='2' bgcolor='#3399FF'><br/><p>"+content+"</p></td></tr>");
	}
	
	//GREEN prority
	query = "SELECT u.firstname, u.lastname, d.id, d.content, d.author_id, d.date FROM discussion d INNER JOIN users u ON u.id = d.author_id AND d.post_id = "+postid + " AND d.priority=3 ORDER BY d.date DESC";
	db.queryString(query);
	while(db.isNext()){
		content = db.getString("content");
		date = db.getDate("date");
		time = db.getTime("date");
		author_fn = db.getString("firstname");
		author_ln = db.getString("lastname");
		out.print("<tr><td height='90%' width='6%'>&nbsp;</td><td class='poster' style='border:1px solid' height='90%' width='6%' colspan='2' bgcolor='#AEFF8E' align='center'><p class='text'><h2>"+author_fn + " " + author_ln+
		"</h2><br>Change priority: <input class='radioRed' type='button' onClick='location.href = \"resultpage.jsp?dis="+db.getString("id")+"&priority=1\";'/> "+
		"<input class='radioBlue' type='button' onClick='location.href= \"resultpage.jsp?dis="+db.getString("id")+"&priority=2\";'/> "+
		"</p><p class='text'>"+"Posted "+ time+ " on " + date
			+"</p><br/><td class='postbody' style='border:1px solid' height='70' colspan='2' bgcolor='#AEFF8E'><br/><p>"+content+"</p></td></tr>");
	}
	
  %>
</table>
<p>&nbsp;</p>
</body>
</html>