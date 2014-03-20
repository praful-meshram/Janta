<%@page import="payment.ManagePayment"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 
	ManagePayment mp = new ManagePayment("jdbc/js");
	String from_date = "";//request.getParameter("from_date");
	String to_date = "";//request.getParameter("to_date");
	mp.getDateRangePendingBalance(from_date, to_date);
	%>

	<table border=1>
		<tr>
			<th>Balance</th>
			<th>Cust Code</th>
			<th>Name</th>
			<th>Building</th>
			<th>Block</th>
			<th>Wing</th>
			<th>Add1</th>
			<th>Area</th>
			<th>Station</th>
			<th>City</th>
			<th>Phone</th>
			<th>Mobile</th>
		</tr>
		<%
		int counter=0;
		while(mp.rs.next()){
			%>
			<tr>
				<td><%= mp.rs.getFloat(1) %><input type="hidden" name="balance" value="<%= mp.rs.getFloat(1) %>"/></td>
				<td><%= mp.rs.getString(2) %><input type="hidden" name="Code" value="<%= mp.rs.getString(2) %>"/></td>
				<td><%= mp.rs.getString(3) %><input type="hidden" name="Name" value="<%= mp.rs.getString(3) %>"/></td>
				<td><%= mp.rs.getString(4)+", "+ mp.rs.getString(5) %>
					<input type="hidden" name="Building" value="<%= mp.rs.getString(4)+", "+ mp.rs.getString(5) %>"/></td>
				<td><%= mp.rs.getString(6) %><input type="hidden" name="Block" value="<%= mp.rs.getString(6) %>"/></td>
				<td><%= mp.rs.getString(7) %><input type="hidden" name="Wing" value="<%= mp.rs.getString(7) %>"/></td>
				<td><%= mp.rs.getString(8) %><input type="hidden" name="Add1" value="<%= mp.rs.getString(8) %>"/></td>
				<td><%= mp.rs.getString(9) %><input type="hidden" name="Area" value="<%= mp.rs.getString(9) %>"/></td>
				<td><%= mp.rs.getString(10) %><input type="hidden" name="Station" value="<%= mp.rs.getString(10) %>"/></td>
				<td><%= mp.rs.getString(11) %><input type="hidden" name="City" value="<%= mp.rs.getString(11) %>"/></td>
				<td><%= mp.rs.getString(12) %><input type="hidden" name="Phone" value="<%= mp.rs.getString(12) %>"/></td>
				<td><%= mp.rs.getString(13) %><input type="hidden" name="Mobile" value="<%= mp.rs.getString(13) %>"/></td>
			</tr>
			<%
			counter++;
		}
		%>
	</table>
	<%
	mp.closeAll();
%>