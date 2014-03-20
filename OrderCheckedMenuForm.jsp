
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="OrderCheckedMenuForm.jsp" />	
</jsp:include> --%>

<%@ page errorPage="ErrorPage.jsp?page=OrderCheckedMenuForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<script src="js/OrderCheck.js"></script> 
<link rel="stylesheet" type="text/css" href="css/border_radius.css" />
<form name="myform" onsubmit="" method="post">
<br><br><br>
<table align="center">
	<tr>
		<td><b><font color="blue">O</font>rder Number : </b></td>
		<td><input type="text" name="orderNo"  accesskey="o" class="roundedSearchTextField" onkeydown="javascript:this.value=this.value.replace(/[^0-9]/g, '');" onkeyup="javascript:this.value=this.value.replace(/[^0-9]/g, '');" autocomplete="off"></td>
	</tr>
	<tr>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td></td>
		<td align="center"><input type="submit" value="Submit  <Enter>" Name="Submit"  class="menulired" onclick="funIsExistOrderNo();return false;"/> </td>
	</tr>
</table>

<script  type="text/javascript">
	document.myform.orderNo.focus();
</script>
</form>