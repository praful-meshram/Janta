<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="StaffTotalOrders.jsp" />	
</jsp:include>
 --%>
<%@ page errorPage="ErrorPage.jsp?page=StaffTotalOrders.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>


<form name="myform" method="post" class="dd1">
<%
		String staffCode="";
		staffCode=request.getParameter("d_staffcode");
		String staffName="";
		staffName=request.getParameter("d_staffname");
		
		String query="";
		Connection conn=null;
		Statement stat=null;
		ResultSet rs=null;
		try{	
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stat=conn.createStatement();
			query="select  a.order_num, a.custcode, a.order_date, a.total_items, a.total_value, a.total_value_mrp, a.total_value_discount, b.payment_type_desc, a.lastmodifieddate, a.comm_amt, a.status_code from orders a, payment_type b where a.payment_type_code=b.payment_type_code and a.dstaff_code='"+staffCode+"' ";

			
%> 
		<table  border="1" id="id" class="item3">
		
		<tr><th colspan="10" align="left">Delivery staff name: <%=staffName%> </th></tr>
		
	      <tr>				
				
				<td ><b>Order Number</b></td>
				<td ><b>Customer Code</b></td>
				<td ><b>Order Date</b></td>
				<td><b>Last Modified Date</b></td>
				<td ><b>Total Items</b></td>
				<td><b>Total Values</b></td>
				<td><b>MRP</b></td>
				<td><b>Discount</b></td>
				<td><b>Payment Type</b></td>				
				<td><b>Commission Amount</b></td>
				<td><b>Status</b></td>
				
								
			</tr>
<%
			
		
		rs=stat.executeQuery(query);    
    	while(rs.next()) {
 %>
			<tr id="tr">	
		
				<td align="left">
<%        
    	
			out.println(rs.getString(1));
%>
			</td><td align="left">
<%        
    	
			out.println(rs.getString(2));
%>
			</td><td align="left">
<%        
    	
			out.println(rs.getString(3));
%>
			</td><td align="left">
<%			
			out.println(rs.getString(9));
%>       
			</td><td align="right">
<%        
    	
			out.println(rs.getString(4));
%>
			</td><td align="right">
<%			
			out.println(rs.getString(5));
%>       
			</td><td align="right">
<%			
			out.println(rs.getString(6));
%>       
			</td><td align="right">
<%			
			out.println(rs.getString(7));
%>       
			</td><td align="left">
<%			
			out.println(rs.getString(8));
%>       
			</td><td align="right">
<%			
			String sp = rs.getString(10);
				if (sp == null){
				 out.println("-");
				}
				else{
				out.println(rs.getString(10));
				}
%>       
			</td><td align="left">
<%			
			out.println(rs.getString(11));
%>       
			</td></tr>			        	  
<%		}	    
		rs.close();	
        stat.close();
		conn.close();
	
		
%>

<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>
</table>


<%
	}
	catch (Exception e) {
		e.getMessage();
		e.printStackTrace();
		System.out.println(e);
	}
%>   








</form>
</body>
</html>	

