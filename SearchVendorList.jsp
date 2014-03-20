<script src="js/vendor.js"></script> 
<table border="1"  id="id1" class="item3" style="width: 100%;border-collapse: collapse;" >
	<tr>
		<td><b>Vendor Name</b></td>
		<td><b>Vendor Address</b></td>
		<td><b>Phone Number</b></td>		
	</tr>
<%
	String vendorName = request.getParameter("vendorName");	
	String vendorPhone = request.getParameter("vendorPhone");
	int vendorId;
	String address;
	inventory.ManageVendor objMV = new inventory.ManageVendor("jdbc/js");
	objMV.search(vendorName,vendorPhone);
	if(objMV.rs.next()){
	do{
		vendorId = objMV.rs.getInt(1);
		vendorName = objMV.rs.getString(2);
		address = objMV.rs.getString(3);
		vendorPhone = objMV.rs.getString(4);
		
%>
	<tr>
		<td><a href="EditVendorForm.jsp?vendorId=<%=vendorId%>&vendorName=<%=vendorName%>&vendorAddress=<%=address%>&vendorPhone=<%=vendorPhone%>"><%=vendorName%></a></td>
		<td><%out.println(address);%></td>
		<td><%out.println(vendorPhone);%></td>		
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