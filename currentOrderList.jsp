<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="currentOrderList.jsp" />	
</jsp:include>


<%
	Connection conn=null;
	Statement stat=null;
	ResultSet rs=null;
	try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
    	stat=conn.createStatement();
    	String query="select a.order_num, a.custcode, a.order_date,a.total_items, "+
    				 "a.total_value, b.custname ,b.phone,a.status_code, a.other_charges, a.advance_amt, a.balance_amt, a.paid_amt,a.enterd_by "+
    				 "from orders a, "+
    				 "customer_master b  where a.custcode = b.custcode "+
    				 "order by a.lastmodifieddate Desc limit 5";
    	rs=stat.executeQuery(query);
%>    	
    	<table   border="1" class="item3"  style="width: 100%;width: 100%; border-collapse: collapse;" cellspacing=0 cellpadding=0 bordercolor=black>
    	<tr><th colspan="8" style="padding: 3px 0px 3px 5px;">Recently updated orders</th></tr>
			<tr align="center"> 
				<td style="padding: 3px 0px 3px 5px;"><b>Order No.</b></td>
				<td><b>Cust Code</b></td>
				<td><b>Order Date</b></td>
				<td><b>Items</b></td>	
				<td><b>Order Value</b></td>		
				<td><b>Enterd By</b></td>	
				<td><b>Status</b></td>
				<td>&nbsp;</td>
		   </tr>
<%		
		while(rs.next()){
%>
          
             <tr align="center"> 
             <td style="padding: 3px 0px 3px 5px;" title="Total value=<%=rs.getString(5)%>,Delv charges=<%=rs.getString(9)%>,Less advance amt=<%=rs.getString(10)%>,Balance amt=<%=rs.getString(11)%>,Paid amt=<%=rs.getString(12)%>">
             <a href="print_order.jsp?orderNo=<%=rs.getString(1)%>&backPage=customer_detailsForm.jsp&buttonFlag=Y&statusCode=<%=rs.getString(8)%>">
<%			
			out.println(rs.getString(1));
%>       
			</a>			
			</td><td title="<%=rs.getString(6)%>,<%=rs.getString(7)%>">
<%	
           	out.println(rs.getString(2));
%>
			</td><td>
<%	
           	out.println(rs.getString(3));
%>	
			</td><td>
<%	
           	out.println(rs.getString(4));
%>	
			</td><td>
<%	
           	out.println(rs.getString(5));
%>	
			</td><td>
<%	
           	out.println(rs.getString(13));
%>
			</td><td>
<%	
           	out.println(rs.getString(8));
%>	
			</td><td><a href="print_order1.jsp?orderNo=<%=rs.getString(1)%>&backPage=customer_detailsForm.jsp">Print</a></td></tr>
<%		
		}	    	  
    	rs.close();
		stat.close();
		conn.close();
%>
	
<%						
	}catch(Exception e){
		rs.close();
		stat.close();
		conn.close();
		System.out.println(e);
	}		
%>
</table>

