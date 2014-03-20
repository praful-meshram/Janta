<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="Reports.jsp" />	
</jsp:include>
 --%>
 <%@ page errorPage="ErrorPage.jsp?page=Reports.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<jsp:include page="leftsidemenu.jsp" />

<td width="50%">
<center><br><br><br><br>
<table border="0" class="item3" width="100%" hieght="100%">
</table>
</td>
</tr>
</table>
