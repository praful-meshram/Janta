<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="NewVendorForm.jsp" />	
</jsp:include>

<%@ page errorPage="ErrorPage.jsp?page=NewVendorForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<script src="js/vendor.js"></script> 
<link rel="stylesheet" type="text/css" href="css/border_radius.css" />
<form name="myform"  method="post">
<fieldset style="width: 40%;">
<legend>
<h3 align="center">Create Vendor</h3>
</legend>
<table align="center">
	<tr>
		<td align="left"><b>Vendor <font color="blue"><u>N</u></font>ame</b></td>
		<td>:</td>
		<td><input type="text" name="vendorName" accesskey="n" size="50"/></td>
	</tr>
	<tr>
		<td align="left"><b><font color="blue"><u>P</u></font>hone Number </b></td>
		<td>:</td>
		<td><input type="text" name="vendorPhone" accesskey="p" size="50"/></td>
	</tr>
	<tr>
		<td align="left"><b><font color="blue"><u>V</u></font>endor Address</b></td>
		<td>:</td>
		<td><input type="text" name="vendorAddress" rows="3" accesskey="v" size="50" accesskey="v" ></td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td colspan="3">
			<input type="button" value="Create Vendor<Alt+s>" onclick="funSubmit();" accesskey="s"/>
			<input type="reset" value="Clear<Alt+c>" accesskey="c"/>
			<input type="button" value="Home<Alt+h>" onclick="funCancel();" accesskey="h"/>			
		</td>
	</tr>
</table>
</fieldset>
</form>
</body>
</html>