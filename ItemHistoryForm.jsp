<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>

<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">
	<jsp:param name="formName" value="ItemHistoryForm.jsp" />
</jsp:include> --%>


<%@ page errorPage="ErrorPage.jsp?page=ItemHistoryForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<%@page contentType="text/html"%>

<%
	DecimalFormat df = new DecimalFormat("###,###.00");

	String i_code = "";
	i_code = request.getParameter("icode");
	item.ManageItemHistory mih = new item.ManageItemHistory("jdbc/js");
	mih.listItemHistory(i_code);
%>
<center>
	<h3>Item History</h3>
	<br>
	<div class="div_id">
		<table border="1" name="t" id="id" class="item3"
			style="width: 100%; font-family: arial;">

			<tr>
				<td><b>Item Code</b></td>
				<td><b>Item Version No.</b></td>
				<td><b>Item Group</b></td>
				<td><b>Item Name</b></td>
				<td><b>Item weight</b></td>
				<td><b>Item MRP</b></td>
				<td><b>Item Rate</b></td>
				<td><b>Deal type</b></td>
				<td><b>Deal Quantity</b></td>
				<td><b>Deal Amount</b></td>
				<td><b>Update Date/Time</b></td>
				<td><b>Commission Amount</b></td>
			</tr>


			<%
				int i = 0;
				int count = 0;
				while (mih.rs.next()) {
					count++;
					i = 1;
					if (count % 2 == 0) {
					%>
			<tr id="tr" style="background-color: #E3F6CE;">
				<td align="left">
					<%
					} else {
					%> 
			<tr id="tr" style="background-color:#D8F8D7; ">
				<td align="left">
					<%
					}
					out.println(mih.rs.getString(i++));
			%> </a></td>
				<td align="left">
					<%
						out.println(mih.rs.getString(i++));
					%>
				</td>
				<td align="left">
					<%
						out.println(mih.rs.getString(i++));
					%>
				</td>
				<td>
					<%
						out.println(mih.rs.getString(i++));
					%>
				</td>
				<td align="left">
					<%
						out.println(mih.rs.getString(i++));
					%>
				</td>
				<td align="right">
					<%
						out.println(df.format(mih.rs.getFloat(i++)));
					%>
				</td>
				<td align="right">
					<%
						out.println(df.format(mih.rs.getFloat(i++)));
					%>
				</td>
				<td align="left">
					<%
						out.println(mih.rs.getString(i++));
					%>
				</td>
				<td align="right">
					<%
						out.println(df.format(mih.rs.getFloat(i++)));
					%>
				</td>
				<td align="right">
					<%
						out.println(df.format(mih.rs.getFloat(i++)));
					%>
				</td>
				<td align="left">
					<%
						out.println(mih.rs.getString(i++));
					%>
				</td>
				</td>
				<td align="right">
					<%
						out.println(df.format(mih.rs.getFloat(i++)));
					%>
				</td>
			</tr>
			

			
					<%
												}
												mih.closeAll();
											%>
			<style type="text/css">
a:link {
	color: blue
}

a:hover {
	background: blue;
	color: white
}

a:active {
	background: blue;
	color: white
}

.div_id {
	width: 80%;
	background-color:#D8F781;
}
</style>


		
		</table>
	</div>