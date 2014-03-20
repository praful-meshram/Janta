<%@page contentType="text/html"%>
<%@ page import="java.text.*" %>
<%@page contentType="text/html"%>
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="DeliveredOrdersDetails.jsp" />	
</jsp:include>

<%
	DecimalFormat df = new DecimalFormat("###,###.00");
		order.ManageOrder mo;
		mo = new order.ManageOrder("jdbc/js");
		String submitTypeValue=request.getParameter("subValue");
		mo.DeliveredOrdersList(submitTypeValue);		
		
%>

        <center><h4>Orders List</h4><br>
       <table border="1" name="t" id="id" >
       
			 <tr>								
				<td ><b>Order Number</b></td>
				<td ><b>Area</b></td>
				<td><b>Status</b></td>
				<td ><b>Order Date</b></td>
				<td ><b>Sent Time</b></td>
				<td ><b>Total Items</b></td>
				<td><b>Total Value</b></td>	
				<td><b>Change</b></td>	
				<td><b>Delivery Person</b></td>	
				<td><b>Paid Amount</b></td>				
			</tr>
		
<%	
		int i=0;
      	while(mo.rs.next()) {
      	i=1;
 %>																			
 
			<tr id="tr"><td align="right"><a href="DeliveredActionForm.jsp?orderNo=<%=mo.rs.getString(1)%>&orderDate=<%=mo.rs.getString(2)%>&status=<%=mo.rs.getString(4)%>&totalItems=<%=mo.rs.getString(5)%>&totalValue=<%=mo.rs.getFloat(6)%>&code=<%=mo.rs.getString(7)%>&name=<%=mo.rs.getString(8)%>&area=<%=mo.rs.getString(9)%>&phone=<%=mo.rs.getString(10)%>&add1=<%=mo.rs.getString(11)%>&add2=<%=mo.rs.getString(12)%>&d_name=<%=mo.rs.getString(14)%>&change=<%=mo.rs.getFloat(15)%>&d_code=<%=mo.rs.getString(16)%>&paid_amt=<%=mo.rs.getFloat(17)%>">	
<% 
            
    		out.println(mo.rs.getString(1));
    		    		    		
%>
    	 	</a></td><td align="left">
    			
<%			 
			out.println(mo.rs.getString(8));  
%>
			</td><td align="left">
			
<%			
             out.println(mo.rs.getString(4));
%>       
						
			</td><td>
<%	
           	out.println(mo.rs.getString(2));
%>
            </td><td>
<%	
           	out.println(mo.rs.getTime(3));
%>
            </td><td align="right">
			
<%			
             out.println(mo.rs.getString(5));
%>    			
			</td><td align="right" >
<%	
           	out.println(df.format(mo.rs.getFloat(6)));
%>
			</td><td align="right" >
<%	
           	out.println(df.format(mo.rs.getFloat(15)));
%>
			</td><td align="right" >
<%	
           	out.println(mo.rs.getString(14));
%>
			</td><td align="right" >
<%	
           	out.println(df.format(mo.rs.getFloat(17)));
%>
			</td></tr>
			
<%			    
		}
		mo.closeAll();
%>
						
	

</table>