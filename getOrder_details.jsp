<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="getOrder_details.jsp" />	
</jsp:include>



<%
		String phone_Number="";
		String order_Number="";
    	String cust_Code="";
    	String customer_Name="";
    	String enteredBy="";
    	String c_date1="";
    	String u_date1="";
    	String c_date2="";
    	String u_date2="";
    	String orderNo="";
    	String orderDate="";
    	String custCode="";
    	String custName="";
    	String entered_By="";
    	String status="";
    	String deliveryPerson="";
    	String deldt="";
    	String sentdt="";

    	int i=2;
    	phone_Number=request.getParameter("phoneNumberStartWith");
		order_Number=request.getParameter("orderNumberStartWith");
		cust_Code=request.getParameter("custCodeStartWith"); 
		customer_Name=request.getParameter("custNameStartWith");		
		enteredBy=request.getParameter("enterByStartWith");
		c_date1=request.getParameter("c_date1StartWith");
		u_date1=request.getParameter("u_date1StartWith");
		c_date2=request.getParameter("c_date2StartWith");
		u_date2=request.getParameter("u_date2StartWith");	    	
    	
    	order.ManageOrder mo;
		mo = new order.ManageOrder("jdbc/js");
		mo.listOrders(phone_Number,customer_Name,order_Number,cust_Code,enteredBy, c_date1, c_date2, u_date1, u_date2);		
%>    	
    	<table border="1" id="id1" class="item3">
    	 	<thead>
				<tr id="id2">
					<td  width="5%"><b>OrderNumber</b></td>
					<td width="15%"><b>Order Date</b></td>
					<td width="10%"><b>Customer Code</b></td>
					<td width="20%"><b>Customer Name</b></td>
					<td width="5%"><b>Entered By</b></td>
					<td width="10%"><b>Status</b></td>
					<td width="10%"><b>Delivery Person</b></td>	
					<td width="10%"><b>Del Date</b></td>	
					<td width="10%"><b>Sent Date</b></td>					
				</tr>
			</thead>
			<tbody>
<%		  	
		Date DELDATE = null;
		Date Snddate = null;

    	while(mo.rs.next()) {
    		orderNo=mo.rs.getString(2);
    		orderDate=mo.rs.getString(4);
        	custCode=mo.rs.getString(3);
        	custName=mo.rs.getString(1);
        	entered_By=mo.rs.getString(6);
        	status=mo.rs.getString(14);
        	deliveryPerson=mo.rs.getString(15);    	
         	if(mo.rs.getString(16)==null)
         	{
         		deldt="     -";
         	}
         	else{ 
         		deldt=mo.rs.getString(16);
         	}
        	if(mo.rs.getString(17)==null){
        		sentdt="     -";  
        	}else{
        		sentdt=mo.rs.getString(17);  
        	}
        
 %>

<tr>
			<td ><a  href="print_order.jsp?orderNo=<%=mo.rs.getString(2)%>&backPage=order_detailsForm.jsp&buttonFlag=Y&statusCode=<%=mo.rs.getString(14)%>">

<%
			out.println(orderNo);
%>
			</a></td><td>
<%			
			out.println(orderDate);
%>       
						
			</td><td>
<%	
           	out.println(custCode);
%>
			</td><td>
<%	
           	out.println(custName);
%>
			</td><td>
<%	
			out.println(entered_By);
%>
			</td>
			<td>
<%	
			out.println(status);
%>
			</td>
<%			if(deliveryPerson!=null){	
%>
				<td><a  href="print_delivered_order.jsp?&orderNo=<%=orderNo%>&backPage=order_detailsForm.jsp&buttonFlag=Y&statusCode=<%=status%>">
<%			
				out.println(deliveryPerson);
			}if(deliveryPerson==null){
	%>
		<td>
<%	
		out.println("Not Delivered Yet");
	}
%>		
		</td><td>
<%	
           	out.println(deldt);
%>
			</td><td>
<%	
           	out.println(sentdt);
%>
			</td>			
</tr>
<%   }
	mo.closeAll();
%>
    <style type="text/css">
		a:link {color: blue}
		a:hover {background: blue;color: white}
		a:active {background: blue;color: white}
		</style>
	</tbody>
	</table>
 
							
	