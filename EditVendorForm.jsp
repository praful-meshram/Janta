<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="EditVendorForm.jsp" />	
</jsp:include>  --%>


<%@ page errorPage="ErrorPage.jsp?page=EditVendorForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<script src="js/vendor.js"></script> 
<link rel="stylesheet" type="text/css" href="css/border_radius.css" />
<form name="myform" >

<%
	int vendorId = Integer.parseInt(request.getParameter("vendorId"));
	String vendorName = request.getParameter("vendorName");
	String vendorAddress = request.getParameter("vendorAddress");
	if(vendorAddress == null){
		vendorAddress = "";
	}
	String vendorPhone = request.getParameter("vendorPhone");
	if(vendorPhone == null){
		vendorPhone = "";
	}
%>
<fieldset style="width: 40%;">
<legend><h3 align="center">Edit Vendor</h3></legend>
<table align="center">
	<tr>
		<td align="left" style="width: 30%;"><b>Vendor <font color="blue"><u>N</u></font>ame</b></td>
		<td>:</td>
		<td><input type="text" name="vendorName" accesskey="n" value="<%=vendorName%>" style="width: 100%;"/></td>
	</tr>
	<tr>
		<td align="left"><b><font color="blue"><u>P</u></font>hone Number </b></td>
		<td>:</td>
		<td><input type="text" name="vendorPhone" accesskey="p" value="<%=vendorPhone%>" style="width: 100%;"/></td>
	</tr>
	<tr>
		<td align="left"><b><font color="blue"><u>V</u></font>endor Address</b></td>
		<td>:</td>
		<td><input type="text" name="vendorAddress" rows="3" accesskey="v" size="40" value="<%=vendorAddress%>" style="width: 100%;"/></td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td colspan="3">
		<input type="hidden" name="vendorId" value="<%=vendorId%>" />
			<input type="button" accesskey="s" value="Update Vendor<Alt+s>" onclick="funUpdate();"/>
			<input type="reset" accesskey="c" value="Clear<Alt+c>"/>
			<input type="button" accesskey="h" value="Home<Alt+h>" onclick="funCancel();"/>
		</td>
	</tr>
</table>
</fieldset>
</form>
</body>
</html>