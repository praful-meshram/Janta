<%@page contentType="text/html"%>
<jsp:include page="TrackingForm.jsp?Exp=1" />

<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="ClosedOrderDetails.jsp" />	
</jsp:include> --%>

<%@ page errorPage="ErrorPage.jsp?page=ClosedOrderDetails.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>


<%@ page import="java.text.*" %>

 

<%@page contentType="text/html"%>
<form name="myform" method="post">
<%
	DecimalFormat df = new DecimalFormat("###,###.00");
		order.ManageOrder mo;
		mo = new order.ManageOrder("jdbc/js");
		mo.ClosedOrdersList();		
		
%>
<td width="50%">
        <center><h4>Orders List</h4><br>
        <div class="ddm1">
       <table border="1" name="t" id="id" >
       
			 <tr>								
				<td ><b>Order Number</b></td>
				<td ><b>Area</b></td>
				<td><b>Status</b></td>
				<td ><b>Order Date</b></td>
				<td ><b>Sent Time</b></td>
				<td ><b>Total Items</b></td>
				<td><b>Total Value</b></td>				
			</tr>
		
<%	
		int i=0;
      	while(mo.rs.next()) {
      	i=1;
 %>																			
 
			<tr id="tr"><td align="right"><a href="DeliveryActionForm.jsp?orderNo=<%=mo.rs.getString(1)%>&orderDate=<%=mo.rs.getString(2)%>&status=<%=mo.rs.getString(4)%>&totalItems=<%=mo.rs.getString(5)%>&totalValue=<%=mo.rs.getFloat(6)%>&code=<%=mo.rs.getString(7)%>&name=<%=mo.rs.getString(8)%>&area=<%=mo.rs.getString(9)%>&phone=<%=mo.rs.getString(10)%>&add1=<%=mo.rs.getString(11)%>&add2=<%=mo.rs.getString(12)%>&d_name=<%=mo.rs.getString(14)%>&change=<%=mo.rs.getFloat(15)%>&d_code=<%=mo.rs.getString(16)%>">	
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
			</td></tr>
			
<%			    
		}
		mo.closeAll();
%>
						
	

</table></div>
</td></tr></table>