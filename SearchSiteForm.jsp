<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="SearchSiteForm.jsp" />	
</jsp:include> --%>

<%@ page errorPage="ErrorPage.jsp?page=SearchSiteForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<script src="js/site.js"></script> 
<link rel="stylesheet" type="text/css" href="css/border_radius.css" />
<form name="myform" class="ddm1">
<fieldset style="width: 40%;">
<legend>
<h3 align="center">Search Site</h3>
</legend>
<table align="center">
	<tr>
		<td align="left"><b>Site <font color="blue"><u>N</u></font>ame</b></td>
		<td>:</td>
		<td><input type="text" name="siteName" accesskey="n" style="width: 100%;"/></td>
	</tr>
	<tr align="left">
		<td><b><font color="blue"><u>P</u></font>hone Number </b></td>
		<td>:</td>
		<td><input type="text" name="sitePhone" accesskey="p" style="width: 100%;"/></td>
	</tr>
	<tr><td>&nbsp;</td></tr>
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
<div id="displayDataDiv" style="width: 40%; max-height: 300px; overflow: auto;"></div>
</form>
</body>
</html>