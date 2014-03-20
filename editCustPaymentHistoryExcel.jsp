<HTML>
<BODY>
<% 
	response.setHeader("Content-Disposition","attachment;filename=StateSearchReport.xls");
	response.setContentType("application/vnd.ms-excel");
	String CustCode=request.getParameter("cuscode");
	String CustName=request.getParameter("name");
%>
<form name="myform" method="post">
 <table cellSpacing="0" cellPadding="0" border="1" align="center" width="100%">
   <tr>
    <th style="background:#c96;">Order Number</th>
    <th style="background:#c96;">Order Date</th>
    <th style="background:#c96;">Del Date Time</th>
    <th style="background:#c96;">Closed Date Time</th>
    <th style="background:#c96;">Close Status</th>
    <th style="background:#c96;">Balance Amount</th>
    <th style="background:#c96;">Change Amount</th>
    <th style="background:#c96;">Paid Amount</th>
    <th style="background:#c96;">Remark</th>
   </tr>
<% 
	
	
	String order_num="", order_date="", del_datetime="", closed_datetime="";
	String remark="",close_status="";
	Float balance_amt=0.0f, change_amt=0.0f, paid_amt=0.0f,absValue=0.0f;
	
	customer.ManageCustomer c;
	c = new customer.ManageCustomer("jdbc/js");
	c.CustPmtHistory(CustCode);
	while(c.rs.next()){
		order_num=c.rs.getString(1);
		order_date=c.rs.getString(2);
		del_datetime=c.rs.getString(3);
		closed_datetime=c.rs.getString(4);
		close_status=c.rs.getString(5);
		balance_amt=c.rs.getFloat(6);
		change_amt=c.rs.getFloat(7);
		paid_amt=c.rs.getFloat(8);
		remark=c.rs.getString(9);
		absValue=c.rs.getFloat(10);
%>
    <tr>
	 <td><%= order_num %></td>
	 <td><%= order_date %></td>
	 <td><%= del_datetime %></td>
	 <td><%= closed_datetime %></td>
	 <td><%= close_status %></td>
<% 
		if(absValue>1.0){
%>
	 <td style="color:red;"><%= balance_amt %></td>
	 <td style="color:red;"><%= change_amt %></td>
	 <td style="color:red;"><%= paid_amt %></td>
<% 
		}
		else{
%>
	 <td><%= balance_amt %></td>
	 <td><%= change_amt %></td>
	 <td><%= paid_amt %></td>
<% 
		}
%>
	 <td><%= remark %></td>
	</tr>
<%
	}
%>

  </table>
</form>