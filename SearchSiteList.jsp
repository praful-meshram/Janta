<script src="js/site.js"></script> 
<table border="1"  id="id1" class="item3" style="width: 100%;">
	<tr>
		<td><b>Site Name</b></td>
		<td><b>Site Address</b></td>
		<td><b>Phone Number</b></td>		
	</tr>
<%
	String siteName = request.getParameter("siteName");	
	String sitePhone = request.getParameter("sitePhone");
	int siteId;
	String address;
	inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
	objMV.search(siteName,sitePhone);
	if(objMV.rs.next()){
	do{
		siteId = objMV.rs.getInt(1);
		siteName = objMV.rs.getString(2);
		address = objMV.rs.getString(3);
		sitePhone = objMV.rs.getString(4);
		
%>
	<tr>
		<td><a href="EditSiteForm.jsp?siteId=<%=siteId%>&siteName=<%=siteName%>&siteAddress=<%=address%>&sitePhone=<%=sitePhone%>"><%out.println(siteName);%></a></td>
		<td><%out.println(address);%></td>
		<td><%out.println(sitePhone);%></td>		
	</tr>
<% 
	}while(objMV.rs.next());
	}else {
		%>
		<tr>
			<td colspan="3">No Matching record found...</td>		
		</tr>
	<%	
	}
	objMV.closeAll();
%>
</table>