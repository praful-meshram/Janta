<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="EditSiteForm.jsp" />	
</jsp:include>  --%>

<%@ page errorPage="ErrorPage.jsp?page=EditSiteForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<script src="js/site.js"></script> 
<link rel="stylesheet" type="text/css" href="css/border_radius.css" />
<form name="myform" >
<fieldset style="width: 40%;">
<legend>
<h3 align="center">Edit Site</h3>
</legend>
<%
	int siteId = Integer.parseInt(request.getParameter("siteId"));
	String siteName = request.getParameter("siteName");
	String siteAddress = request.getParameter("siteAddress");
	if(siteAddress == null){
		siteAddress = "";
	}
	String sitePhone = request.getParameter("sitePhone");
	if(sitePhone == null){
		sitePhone = "";
	}
%>
<table align="center">
	<tr>
		<td align="left"><b>Site <font color="blue"><u>N</u></font>ame</b></td>
		<td>:</td>
		<td><input type="text" name="siteName" accesskey="n" value="<%=siteName%>" style="width: 100%;"/></td>
	</tr>
	<tr>
		<td align="left"><b><font color="blue"><u>P</u></font>hone Number </b></td>
		<td>:</td>
		<td><input type="text" name="sitePhone" accesskey="p" value="<%=sitePhone%>" style="width: 100%;"/></td>
	</tr>
	<tr>
		<td align="left"><b>Site <font color="blue"><u>A</u></font>ddress</b></td>
		<td>:</td>
		<td><input type="text" name="siteAddress" rows="3" accesskey="a" size="40" value="<%=siteAddress%>" style="width: 100%;"/></td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td colspan="3">
		<input type="hidden" name="siteId" value="<%=siteId%>" />
			<input type="button" accesskey="s" value="Update Site<Alt+s>" onclick="funUpdate();"/>
			<input type="reset" accesskey="c" value="Clear<Alt+c>"/>
			<input type="button" accesskey="h" value="Home<Alt+h>" onclick="funCancel();"/>
		</td>
	</tr>
</table>
</fieldset>
</form>
</body>
</html>