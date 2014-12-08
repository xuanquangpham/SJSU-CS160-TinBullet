<%@ include file="header.jsp" %> 


<title>Sticky Notes homepage</title>
<style type="text/css">
td.poster {
	width: 15%;
}
td.postbody {
	width: 50%;
}
</style>
<script>

</script>
</script>

<%

%>

<center><h1>POST NAME</h1></center>
<table style="border-collapse: collapse;" width="100%" border="0">

  <tr>
    <td height="90%" width="6%">&nbsp;</td>

    <td class="poster" style="border:1px solid" height="90%" width="6%" colspan="2" bgcolor="#FFF573"><p><h1>Priority 1</h1></p>
    <p class="text">USERNAME</p>
	<p class="text">ROLE</p>
	<br/>
	
	<td class="postbody" style="border:1px solid" height="70" colspan="2" bgcolor="#FFF573"><p>blahblahblah stuff</p>

    <p>&nbsp;</p></td>
    <td><input type="submit" name="post response" id="postresponse" value="Post Response" style="width:200px">
		<br/>
		<input type="submit" name="add new priority" id="addpriority" value="Add New Priority" style="width:200px">
		<br/>
		<input type="submit" name="change priority" id="changepriority" value="Change Priorities" style="width:200px"></td>
  </tr>
</table>
</body>
</html>