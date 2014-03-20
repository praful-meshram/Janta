<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%
	response.setContentType("application/vnd.ms-excel");
	String balance[] = request.getParameterValues("balance");
	String Code[] = request.getParameterValues("Code");
	String Name[] = request.getParameterValues("Name");
	String Building[] = request.getParameterValues("Building");
	String Block[] = request.getParameterValues("Block");
	String Wing[] = request.getParameterValues("Wing");
	String Add1[] = request.getParameterValues("Add1");
	String Area[] = request.getParameterValues("Area");
	String Station[] = request.getParameterValues("Station");
	String City[] = request.getParameterValues("City");
	String Phone[] = request.getParameterValues("Phone");
	String Mobile[] = request.getParameterValues("Mobile");
	String Order[] = request.getParameterValues("order");
	String date[] = request.getParameterValues("date");
	out.print("<table border=1><tr><th>Cust Code</th><th>Name</th><th>Balance</th><th>Order no</th><th>Ord date</th><th>Building</th><th>Block</th>");
	out.print("<th>Wing</th><th>Add1</th><th>Area</th><th>Station</th><th>City</th><th>Phone</th><th>Mobile</th></tr>");
	for(int i=0;i<balance.length;i++){
		out.print("<tr>");
		out.print("<td>"+Code[i]+"</td>");
		out.print("<td>"+Name[i]+"</td>");
		out.print("<td>"+balance[i]+"</td>");
		out.print("<td>"+Order[i]+"</td>");
		out.print("<td>"+date[i]+"</td>");
		out.print("<td>"+Building[i]+"</td>");
		out.print("<td>"+Block[i]+"</td>");
		out.print("<td>"+Wing[i]+"</td>");
		out.print("<td>"+Add1[i]+"</td>");
		out.print("<td>"+Area[i]+"</td>");
		out.print("<td>"+Station[i]+"</td>");
		out.print("<td>"+City[i]+"</td>");
		out.print("<td>"+Phone[i]+"</td>");
		out.print("<td>"+Mobile[i]+"</td>");
		out.print("</tr>");
	}
	out.print("</table>");
%>

