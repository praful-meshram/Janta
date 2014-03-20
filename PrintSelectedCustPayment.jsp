<%@page import="customer.ManageCustomer"%>
<jsp:include page="header.jsp" /> 
<script type="text/javascript">
function printRecept(){
   var html="<html>";
   html+= document.getElementById("pay_recept").innerHTML;
   html+="</html>";

   var printWin = window.open('','','left=350,top=100,height=400,toolbar=0,scrollbars=2,status=0,font-family=consolas');
   printWin.document.write(html);
   printWin.document.close();
   printWin.focus();
   printWin.print();
   printWin.close();
   window.location="EditTargetReportForm.jsp?call_type=search_payment";
}
</script>
<%
String orders[] = request.getParameterValues("orders");
String orders_count = request.getParameter("order_count");
ManageCustomer manage= new ManageCustomer("jdbc/js");
manage.getPaymentList(orders);
%>
<br/><br/>
<div id = "pay_recept" style="border:1px Solid Black;font-family: consolas;" align="center">
Customer Detail for pending collection(<%=orders_count %> orders)
<table border="1" style="border-collapse: collapse;">
<tr>
	<th style="width: 6%;">Code</th>
	<th style="width: 20%;">Name</th>
	<th style="width: 5%;">Balance</th>
	<th style="width: 5%;">Order</th>
	<th style="width: 10%;"> Ord Date</th>
	<th style="width: 10%;"> Del Date</th>
	<th style="width: 7%;">Phone</th>
	<th style="width: 7%;">Mobile</th>
	<th style="width: 30%;">Address</th>
</tr>
<%
while(manage.rs.next()){
	String addr = manage.rs.getString(8)+", "+manage.rs.getString(9)+", "+manage.rs.getString(10)+", "+manage.rs.getString(11)+", "
			+manage.rs.getString(12)+", "+manage.rs.getString(13)+", "+manage.rs.getString(14)+", "+manage.rs.getString(17);
	%>
	<tr>
		<td valign="top"><%=manage.rs.getString(1) %></td>
		<td valign="top"><%=manage.rs.getString(2) %></td>
		<td valign="top"><%=manage.rs.getString(3) %></td>
		<td valign="top"><%=manage.rs.getString(4) %></td>
		<td valign="top"><%=manage.rs.getString(5) %></td>
		<td valign="top"><%=manage.rs.getString(18) %></td>
		<td valign="top"><%=manage.rs.getString(6) %></td>
		<td valign="top"><%=manage.rs.getString(7) %></td>
		<td valign="top"><%=addr %></td>
	</tr>
	<%
}
%>
</table>
</div>
<div >
	<input type="button" accesskey="p" onclick="printRecept()" value="Print <Alt+p>"/>
</div>
<%
manage.closeAll();
%>
