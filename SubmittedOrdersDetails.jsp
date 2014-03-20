<%@page contentType="text/html"%>
<%@ page import="java.text.*" %>
<%@page contentType="text/html"%>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="SubmittedOrdersDetails.jsp" />	
</jsp:include>
 --%>
<%
	String submitTypeValue="",startTime="";
	submitTypeValue=request.getParameter("subValue");
	DecimalFormat df = new DecimalFormat("###,###.00");
	String orderNo="";
		order.ManageOrder mo;
		mo = new order.ManageOrder("jdbc/js");
		if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") 
		   || submitTypeValue.equals("Submitted3"))	{		   
			mo.submittedOrdersList(submitTypeValue);	
		}
		else if(submitTypeValue.equals("Transit1") || submitTypeValue.equals("Transit2")
			    || submitTypeValue.equals("Transit3")){
			    mo.TransitOrdersList(submitTypeValue);
		}	
		else if(submitTypeValue.equals("Delivered1") || submitTypeValue.equals("Delivered2") 
				|| submitTypeValue.equals("Delivered3")){
				mo.DeliveredOrdersList(submitTypeValue);
		}
		else if(submitTypeValue.equals("Hold1") || submitTypeValue.equals("Hold2") 
				|| submitTypeValue.equals("Hold3")){
				mo.HoldOrdersList(submitTypeValue);
		}	
		else if(submitTypeValue.equals("Closed1") || submitTypeValue.equals("Closed2") 
				|| submitTypeValue.equals("Closed3")){
				mo.ClosedOrdersList(submitTypeValue);
		}			
%>
        <center><h4>Orders List</h4><br>

       <table border="1" name="t" id="id" >
       <% if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") 
			 || submitTypeValue.equals("Submitted3") || submitTypeValue.equals("Hold1") || 
			 submitTypeValue.equals("Hold2") || submitTypeValue.equals("Hold3") || 
			 submitTypeValue.equals("Closed1")  || submitTypeValue.equals("Closed2") 
			 || submitTypeValue.equals("Closed3")) { %>
			 <tr>			
				<td><b>Customer Name</b></td>					
				<td ><b>Order Number</b></td>
				<td ><b>Area</b></td>
				<td><b>Status</b></td>
				<td ><b>Order Date</b></td>
				<td ><b>Last Modified</b></td>
				<td ><b>Total Items</b></td>
				<td><b>Total Values</b></td>				
				<td><b>Action</b></td>								
			</tr>
		<%}else if(submitTypeValue.equals("Transit1") || submitTypeValue.equals("Transit2") || submitTypeValue.equals("Transit3")) {	%>
 			<tr>	
				<td><b>Customer Name</b></td> 										
				<td ><b>Order Number</b></td>
				<td ><b>Area</b></td>
				<td><b>Status</b></td>
				<td ><b>Order Date</b></td>			
				<td ><b>Last Modified</b></td>
				<td ><b>Total Items</b></td>
				<td><b>Total Values</b></td>	
				<td><b>Action</b></td>																			
			</tr>
		
		<%}else if(submitTypeValue.equals("Delivered1") || submitTypeValue.equals("Delivered2") || submitTypeValue.equals("Delivered3")) {%>
			 <tr>		
				<td><b>Customer Name</b></td>			 						
				<td ><b>Order Number</b></td>
				<td ><b>Area</b></td>
				<td><b>Status</b></td>
				<td ><b>Order Date</b></td>
				<td ><b>Last Modified</b></td>
				<td ><b>Total Items</b></td>
				<td><b>Total Value</b></td>	
				<td><b>Change</b></td>	
				<td><b>Delivery Person</b></td>	
				<td><b>Paid Amount</b></td>	
				<td><b>Action</b></td>															
			</tr>		
		
		<%}%>		
<%	
		int i=0;
      	while(mo.rs.next()) {
      	i=1;
 %>
 <%if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") || submitTypeValue.equals("Submitted3")){%>
 <tr><td align="left" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
 <%}if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") || submitTypeValue.equals("Submitted3"))
 	out.println(mo.rs.getString(7));
 %>    
 
 
  <%if(submitTypeValue.equals("Transit1") || submitTypeValue.equals("Transit2") || submitTypeValue.equals("Transit3")){%>
 <tr><td align="left" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
 <%}if(submitTypeValue.equals("Transit1") || submitTypeValue.equals("Transit2") || submitTypeValue.equals("Transit3"))
 	out.println(mo.rs.getString(7));
 %>  
 
 
  <%if(submitTypeValue.equals("Delivered1") || submitTypeValue.equals("Delivered2") || submitTypeValue.equals("Delivered3")){%>
 <tr><td align="left" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
 <%}if(submitTypeValue.equals("Delivered1") || submitTypeValue.equals("Delivered2") || submitTypeValue.equals("Delivered3"))
 	out.println(mo.rs.getString(7));
 %>  
 
 
  <%if(submitTypeValue.equals("Hold1") || submitTypeValue.equals("Hold2") || submitTypeValue.equals("Hold3")){%>
 <tr><td align="left" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
 <%}if(submitTypeValue.equals("Hold1") || submitTypeValue.equals("Hold2") || submitTypeValue.equals("Hold3"))
 	out.println(mo.rs.getString(7));
 %>  
 
   <%if(submitTypeValue.equals("Closed1") || submitTypeValue.equals("Closed2") || submitTypeValue.equals("Closed3")){%>
 <tr><td align="left" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
 <%}if(submitTypeValue.equals("Closed1") || submitTypeValue.equals("Closed2") || submitTypeValue.equals("Closed3"))
 	out.println(mo.rs.getString(7));
 %>
 
<!--  Cust Name 1--> 	 	
     	 	
</td>																		
 <%if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") || submitTypeValue.equals("Submitted3")){%>
			<td align="right">
 <%}else if(submitTypeValue.equals("Transit1") || submitTypeValue.equals("Transit2") || submitTypeValue.equals("Transit3")){%>
			<td align="right">
<%}else if(submitTypeValue.equals("Delivered1") || submitTypeValue.equals("Delivered2") || submitTypeValue.equals("Delivered3")){%>
			<td align="right">
<%}else if(submitTypeValue.equals("Hold1") || submitTypeValue.equals("Hold2") || submitTypeValue.equals("Hold3")){%>
			<td align="right">		
<%}else if(submitTypeValue.equals("Closed1") || submitTypeValue.equals("Closed2") || submitTypeValue.equals("Closed3")){%>
			<td align="right">		
<%}%>	
<% 
//Order Num 2
	orderNo = mo.rs.getString(1);
    		out.println(orderNo);    		    		    		    		
%>
    	 	</a><td align="left">
    			
<%	
//Area 3
		if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") 
			 || submitTypeValue.equals("Submitted3") || submitTypeValue.equals("Hold1") || 
			 submitTypeValue.equals("Hold2") || submitTypeValue.equals("Hold3") || 
			 submitTypeValue.equals("Closed1")  || submitTypeValue.equals("Closed2") 
			 || submitTypeValue.equals("Closed3"))		
             out.println(mo.rs.getString(8));
  		else if(submitTypeValue.equals("Transit1") || submitTypeValue.equals("Transit2")
  			 || submitTypeValue.equals("Transit3")|| submitTypeValue.equals("Delivered1")
  			 || submitTypeValue.equals("Delivered2") || submitTypeValue.equals("Delivered3")){  		
  			 out.println(mo.rs.getString(9));			   			
  		}
%>
			</td><td align="left">
			
<%	
//Status 4	
if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") 
			 || submitTypeValue.equals("Submitted3") || submitTypeValue.equals("Hold1") || 
			 submitTypeValue.equals("Hold2") || submitTypeValue.equals("Hold3") || 
			 submitTypeValue.equals("Closed1")  || submitTypeValue.equals("Closed2") 
			 || submitTypeValue.equals("Closed3"))
             out.println(mo.rs.getString(3));
  		else if(submitTypeValue.equals("Transit1") || submitTypeValue.equals("Transit2")
  			 || submitTypeValue.equals("Transit3")|| submitTypeValue.equals("Delivered1")
  			 || submitTypeValue.equals("Delivered2") || submitTypeValue.equals("Delivered3")){  		
  			 out.println(mo.rs.getString(4)); 			   			
  		}
%>       
					
			</td><td>
<%	
//Order date 5	
           	out.println(mo.rs.getString(2));
           	
/*		if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") || submitTypeValue.equals("Submitted3"))
           	out.println(mo.rs.getString(2));
  		else if(submitTypeValue.equals("Transit1") || submitTypeValue.equals("Transit2")
  			 || submitTypeValue.equals("Transit3")|| submitTypeValue.equals("Delivered1")
  			 || submitTypeValue.equals("Delivered2") || submitTypeValue.equals("Delivered3")){  		
  			 out.println(mo.rs.getString(4));           	
*/  			 
%>
            </td><td align="left">
<%
if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") 
			 || submitTypeValue.equals("Submitted3")|| submitTypeValue.equals("Hold1") || 
			 submitTypeValue.equals("Hold2") || submitTypeValue.equals("Hold3") ||
			 submitTypeValue.equals("Closed1") || submitTypeValue.equals("Closed2") || submitTypeValue.equals("Closed3") )
			 out.println(mo.rs.getString(16));
// Sent time 6             
  		else if(submitTypeValue.equals("Transit1") || submitTypeValue.equals("Transit2")
  			 || submitTypeValue.equals("Transit3")){  		 
		 		java.sql.Timestamp stamp = (java.sql.Timestamp)mo.rs.getObject(21);
				startTime = stamp.toString();
		 		out.println(startTime);  			 
           		out.println(mo.rs.getTime(21));    
           		                    
     }   
     else if( submitTypeValue.equals("Delivered1")|| submitTypeValue.equals("Delivered2") 
     		 || submitTypeValue.equals("Delivered3")){ 
		 		java.sql.Timestamp stamp = (java.sql.Timestamp)mo.rs.getObject(22);
				startTime = stamp.toString();
		 		out.println(startTime);      		  
	}			 
%>
	  </td><td align="left">
			
<%	
// Total Items 6		
if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") 
			 || submitTypeValue.equals("Submitted3") || submitTypeValue.equals("Hold1") || 
			 submitTypeValue.equals("Hold2") || submitTypeValue.equals("Hold3") || 
			 submitTypeValue.equals("Closed1")  || submitTypeValue.equals("Closed2") 
			 || submitTypeValue.equals("Closed3"))
             out.println(mo.rs.getString(4));
// Total Items 7 Transit
  		else if(submitTypeValue.equals("Transit1") || submitTypeValue.equals("Transit2")
  			 || submitTypeValue.equals("Transit3")|| submitTypeValue.equals("Delivered1")
  			 || submitTypeValue.equals("Delivered2") || submitTypeValue.equals("Delivered3")){  		 
                        out.println(mo.rs.getString(5)); 
        }		 		   
		 		   
%>    			
			</td>			
 			
</td><td align="right" >
<%	
// Total Value 7
if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") 
			 || submitTypeValue.equals("Submitted3") || submitTypeValue.equals("Hold1") || 
			 submitTypeValue.equals("Hold2") || submitTypeValue.equals("Hold3") || 
			 submitTypeValue.equals("Closed1")  || submitTypeValue.equals("Closed2") 
			 || submitTypeValue.equals("Closed3"))
           	out.println(df.format(mo.rs.getFloat(5)));   
   
    else if(submitTypeValue.equals("Transit1") || submitTypeValue.equals("Transit2")
  			 || submitTypeValue.equals("Transit3")|| submitTypeValue.equals("Delivered1")
  			 || submitTypeValue.equals("Delivered2") || submitTypeValue.equals("Delivered3"))  		         	
           	out.println(df.format(mo.rs.getFloat(6)));    
           	        	

%>
			</td>
			
<!--  This code is to add Action link  8-->	
<td align="left">		
 <%if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") || submitTypeValue.equals("Submitted3")){%>
			<a href="DeliveryDetailsForm.jsp?orderNo=<%=mo.rs.getString(1)%>&orderDate=<%=mo.rs.getString(2)%>&status=<%=mo.rs.getString(3)%>&totalItems=<%=mo.rs.getString(4)%>&totalValue=<%=mo.rs.getFloat(5)%>&code=<%=mo.rs.getString(6)%>&name=<%=mo.rs.getString(7)%>&area=<%=mo.rs.getString(8)%>&phone=<%=mo.rs.getString(9)%>&add1=<%=mo.rs.getString(10)%>&add2=<%=mo.rs.getString(11)%>&subValue=<%=submitTypeValue%>">	
 <%  //Action for submitted 7
    		//out.println(mo.rs.getString(14)); 
    		out.println("Take Action");
    		 }
else if(submitTypeValue.equals("Hold1") || submitTypeValue.equals("Hold2") 
			 || submitTypeValue.equals("Hold3")) { %>  
			<a href="javascript:checkHoldStatus('<%=orderNo%>','<%=mo.rs.getString(3)%>');">				 	
<%			 	 
    		 out.println("Take Action");
    }	
    
if(submitTypeValue.equals("Closed1") || submitTypeValue.equals("Closed2") || submitTypeValue.equals("Closed3")){%>
			<a href="ClosedDetailsForm.jsp?orderNo=<%=mo.rs.getString(1)%>&orderDate=<%=mo.rs.getString(2)%>&status=<%=mo.rs.getString(3)%>&totalItems=<%=mo.rs.getString(4)%>&totalValue=<%=mo.rs.getFloat(5)%>&code=<%=mo.rs.getString(6)%>&name=<%=mo.rs.getString(7)%>&area=<%=mo.rs.getString(8)%>&phone=<%=mo.rs.getString(9)%>&add1=<%=mo.rs.getString(10)%>&add2=<%=mo.rs.getString(11)%>&subValue=<%=submitTypeValue%>">	
 <%  //Action for submitted 7
    		//out.println(mo.rs.getString(14)); 
    		out.println("Take Action");
    		 }
   // Take Action 9 for transit
	if(submitTypeValue.equals("Transit1") || submitTypeValue.equals("Transit2") || submitTypeValue.equals("Transit3")){%>
			<a href="DeliveryActionForm.jsp?orderNo=<%=mo.rs.getString(1)%>&orderDate=<%=mo.rs.getString(2)%>&status=<%=mo.rs.getString(4)%>&totalItems=<%=mo.rs.getString(5)%>&totalValue=<%=mo.rs.getFloat(6)%>&code=<%=mo.rs.getString(7)%>&name=<%=mo.rs.getString(8)%>&area=<%=mo.rs.getString(9)%>&phone=<%=mo.rs.getString(10)%>&add1=<%=mo.rs.getString(11)%>&add2=<%=mo.rs.getString(12)%>&d_name=<%=mo.rs.getString(14)%>&change=<%=mo.rs.getFloat(15)%>&d_code=<%=mo.rs.getString(16)%>">	
 <%  //Action for Transit 9
    		//out.println(mo.rs.getString(14)); 
    		out.println("Take Action");
     } 


// Change 9 Delivered

if(submitTypeValue.equals("Delivered1") || submitTypeValue.equals("Delivered2") || submitTypeValue.equals("Delivered3"))
           	out.println(df.format(mo.rs.getFloat(15)));
   	 
	//else if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") || submitTypeValue.equals("Submitted3")){
	//    		out.println(mo.rs.getString(14));     
	 %>
<%	    		

%>								

			</td><td align="left" >

<%	
// delivey Person 10
if(submitTypeValue.equals("Delivered1") || submitTypeValue.equals("Delivered2") || submitTypeValue.equals("Delivered3"))
           	out.println(mo.rs.getString(14));
%>
			</td><td align="right" >
<%	
// Paid Amount 11
if(submitTypeValue.equals("Delivered1") || submitTypeValue.equals("Delivered2") || submitTypeValue.equals("Delivered3"))
           	out.println(df.format(mo.rs.getFloat(17)));
%>
	</td>

<td align="left">		
<%
//Action for Delivery 11   		 
 if(submitTypeValue.equals("Delivered1") || submitTypeValue.equals("Delivered2") 
			 || submitTypeValue.equals("Delivered3")) { %>  
			<a href="DeliveredActionForm.jsp?orderNo=<%=mo.rs.getString(1)%>&orderDate=<%=mo.rs.getString(2)%>&status=<%=mo.rs.getString(4)%>&totalItems=<%=mo.rs.getString(5)%>&totalValue=<%=mo.rs.getFloat(6)%>&code=<%=mo.rs.getString(7)%>&name=<%=mo.rs.getString(8)%>&area=<%=mo.rs.getString(9)%>&phone=<%=mo.rs.getString(10)%>&add1=<%=mo.rs.getString(11)%>&add2=<%=mo.rs.getString(12)%>&d_name=<%=mo.rs.getString(14)%>&change=<%=mo.rs.getFloat(15)%>&d_code=<%=mo.rs.getString(16)%>&paid_amt=<%=mo.rs.getFloat(17)%>">	
<%			 	 
    		 out.println("Take Action");
    }	  
	 %>

		</td></tr>			
								
<%			    
		}
		mo.closeAll();
%>
					
</table>


