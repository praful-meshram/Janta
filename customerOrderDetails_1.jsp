<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*,payment.*" %>
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="customerOrderDetails.jsp" />	
</jsp:include>

<%
		String custCode="";
		custCode=request.getParameter("custCodeStartWith");
		ManagePayment manage = new ManagePayment("jdbc/js");
		manage.getOrderInfo(custCode);
		%>
		
		<center><h4>Order Details</h4></center>
		<div style="width: 99%;overflow-y:scroll;">
			<table border="1" style="width: 98%; float: right;background-color: #BEF781;">
				<tr style="width: 100%;">
					<th style="width: 8%;">O.No.</th>
					<th style="width: 9%;">Date</th>
					<th style="width: 9%;">Total</th>
					<th style="width: 9%;">Change</th>
					<th style="width: 9%;">Paid</th>
					<th style="width: 9%;">Advance</th>
					<th style="width: 9%;">Discount</th>
					<th style="width: 9%;">Other</th>
					<th style="width: 9%;">Balance</th>
				</tr>
			</table>
		</div>
		<div style="width: 99%;max-height: 120px;overflow-y:scroll;">
			<table border="1" style="width: 98%;float: right;">
			<%
			int count = 0;
			float total_balance = 0f;
			if(manage.rs.next()){
			do{
				if(count%2==0){
				%>
					<tr style="width: 100%;background-color:#ECFBB9;">
				<%
				}else{
					%>
					<tr style="width: 100%;background-color:#ECFB99;">
					<%
				}
				%>
					<td style="width: 8%; cursor: pointer;" align="left">
					
					<b><u>
					<font color=blue onclick="displayOrderDetail('<%=manage.rs.getString(1)%>','<%= manage.rs.getDate(2) %>')"><%=manage.rs.getString(1)%></font>
					</u></b>
					
					</td>
					<td style="display:none;"><input type="hidden" name="ord_num" size="7" id="order_num_<%=count%>" value = "<%=manage.rs.getString(1)%>"/></td>
					<td style="width: 9%;"><%= manage.rs.getDate(2) %><input type="hidden" name="date" value="<%= manage.rs.getDate(2) %>"/></td>
					<td style="width: 9%;"><%= manage.rs.getFloat(3) %></td>
					<td style="width: 9%;"><%= manage.rs.getFloat(4) %></td>
					<td style="width: 9%;"><%= manage.rs.getFloat(5) %></td>
					<td style="width: 9%;"><%= manage.rs.getFloat(6) %></td>
					<td style="width: 9%;"><%= manage.rs.getFloat(7) %></td>
					<td style="width: 9%;"><%= manage.rs.getFloat(9) %></td>
					<td style="width: 9%;" id="balance_<%=count%>"><%= manage.rs.getFloat(8) %></td>
					<td style="display:none;"><input type="hidden" name="balance" value="<%= manage.rs.getFloat(8) %>"/></td>
				</tr>
			<%
			total_balance = total_balance + manage.rs.getFloat(8);
			count++;
			} while(manage.rs.next());
			}else{
			%>
				<tr style="width: 100%;background-color:#ECFBB9;"><td colspan="12">No Pending</td><tr>
			<%
			}
			manage.closeAll();  
			%>