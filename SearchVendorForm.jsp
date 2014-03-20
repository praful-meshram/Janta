<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="SearchVendorForm.jsp" />	
</jsp:include> --%>

<%@ page errorPage="ErrorPage.jsp?page=SearchVendorForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<script src="js/vendor.js"></script> 
<style>
#displayDataDiv{
	width: 40%;
	max-height: 300px;
	overflow: auto;
}
</style>
<link rel="stylesheet" type="text/css" href="css/border_radius.css" />
<form name="myform" class="ddm1">
<fieldset style="width: 40%;">
<legend><h3 align="center">Search Vendor</h3></legend>
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
		<td colspan="3">
			<input type="button" accesskey="s" value="Search<Alt+s>" onclick="funSearch();"/>
			<input type="reset" accesskey="c" value="Clear<Alt+c>"/>
			<input type="button" accesskey="h" value="Home<Alt+h>" onclick="funCancel();"/>
		</td>
	</tr>
</table>
</fieldset>
<br/>
<div id="displayDataDiv"></div>
</form>
</body>
</html>