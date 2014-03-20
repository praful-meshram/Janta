<%@page contentType="text/html"%>
<%@ page import="java.text.*" %>
<%@page contentType="text/html"%>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="OrderProcessing.jsp" />	
</jsp:include>
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=OrderProcessing.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<%
	String orderNo="";
	String custCode="";
	String custName="";
	String buildingNo="";
	String block="";
	String wing="";
	String building="";
	String area="";
	String orderDate="";
	String lastModifiedDate="";
	String totalItems="";
	String totalValueMrp="";
	String totalValuePrice="";
	String discountAmt="";
	String advanceAmt="";
	String balanceAmt="";
	String changeAmt="";
	String paidAmt="";
	String expectedAmt="";
	String deliveryStaffName="";
	String statusCode="";

	String submitTypeValue="",startTime="",orderNoArr="",code="",desc="",
		   deliveryPerson="",divCount="";
	boolean subFlag=true;
	int divId=0,count=0;
	submitTypeValue=request.getParameter("subValue");
	if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") 
			|| submitTypeValue.equals("Submitted3"))
		subFlag=false;
	DecimalFormat df = new DecimalFormat("###,###.00");
	order.ManageOrder mo;
	mo = new order.ManageOrder("jdbc/js");
	System.out.println("\nsubmitTypeValue "+submitTypeValue);
	if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") 
	   		|| submitTypeValue.equals("Submitted3"))	{		   
			mo.submittedOrdersList(submitTypeValue);	
	}else if(submitTypeValue.equals("Checked1") || submitTypeValue.equals("Checked2") 
			|| submitTypeValue.equals("Checked3"))	{		   
			mo.checkedOrdersList(submitTypeValue);	
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
	mo.getDeliveryStaffList();		
%>
        <center><h4>Orders List</h4>
<div id="searchTable">        
<table >
	<tr>
<%		
if(subFlag){
%>			 		
		<td width="20%" ><b><font size=2 color="red">Delivery Person :</b></font></td>
		<td>
		
					<SELECT name="d_staff" >
					<OPTION VALUE="" >Select staff
<% 	
	 	while (mo.rs1.next()) {
	 		code = mo.rs1.getString(1);
	 		desc = mo.rs1.getString(2);
%>
			<OPTION VALUE="<%= code%>" ><%= desc%>
		
<% 	
		}		
%>		
		</td>
<% 
	}
%>
		<td width="25%" ><b><font size=2 color="red">Order Number :</font></b></td>
		<td>
			 <input type="text" name="search" size="7" value=''>
		</td>	

		<td>
			<INPUT type=BUTTON value="Search <Alt+S>" accesskey="s" onClick="showMsg(<%=subFlag%>);">
		</td>
		<td>
			<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
		</td>			
		<td>		
			<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="cancel();"></center>
		</td>		
	</tr>
</table><br>
</div>
       <table border="1" name="t" id="id" width="100%" style="border-collapse: collapse;" >
<% 		if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") 
			 || submitTypeValue.equals("Submitted3") || submitTypeValue.equals("Checked1") 
			 || submitTypeValue.equals("Checked2") 
			 || submitTypeValue.equals("Checked3") || submitTypeValue.equals("Hold1") || 
			 submitTypeValue.equals("Hold2") || submitTypeValue.equals("Hold3") || 
			 submitTypeValue.equals("Closed1")  || submitTypeValue.equals("Closed2") 
			 || submitTypeValue.equals("Closed3")) { 
%>
			 <tr>			
				<td><b>Customer Name</b></td>					
				<td ><b>Order No</b></td>
				<td ><b>Area</b></td>
				<td ><b>Order Date</b></td>			
				<td ><b>Total Items</b></td>
				<td><b>Total Values</b></td>
				<td><b>Advance Amount</b></td>
				<td><b>Discount Amount</b></td>
				<td><b>Balance Amount</b></td>
<% 			if(submitTypeValue.equals("Hold1") || 
			 submitTypeValue.equals("Hold2") || submitTypeValue.equals("Hold3") || 
			 submitTypeValue.equals("Closed1")  || submitTypeValue.equals("Closed2") 
			 || submitTypeValue.equals("Closed3")) { 
%>				
				<td><b>Delivery Person</b></td>		
<%
	}if(!submitTypeValue.equals("Closed1")  || !submitTypeValue.equals("Closed2") 
			 || !submitTypeValue.equals("Closed3")){
%>										
				<td><b>Action</b></td>								
			
<%}
%></tr>
<%
	}
			else if(submitTypeValue.equals("Transit1") || submitTypeValue.equals("Transit2") || submitTypeValue.equals("Transit3")) {	%>
 			<tr>	
				<td><b>Customer Name</b></td> 										
				<td ><b>Order No</b></td>
				<td ><b>Area</b></td>
				<td ><b>Order Date</b></td>			
				<td ><b>Total Items</b></td>
				<td><b>Total Values</b></td>	
				<td><b>Advance Amount</b></td>
				<td><b>Discount Amount</b></td>
				<td><b>Balance Amount</b></td>	
				<td><b>Delivery Person</b></td>	
				<td><b>Take Action</b></td>																			
			</tr>
		
<%
	}
		else if(submitTypeValue.equals("Delivered1") || submitTypeValue.equals("Delivered2") || submitTypeValue.equals("Delivered3")) 
			{
%>
			 <tr>		
				<td><b>Customer Name</b></td>			 						
				<td ><b>Order No</b></td>
				<td ><b>Area</b></td>
				<td ><b>Order Date</b></td>
				<td ><b>Total Items</b></td>
				<td><b>Total Value</b></td>	
				<td><b>Advance Amount</b></td>
				<td><b>Discount Amount</b></td>
				<td><b>Balance Amount</b></td>	
				<td><b>Change</b></td>	
				<td><b>Paid Amount</b></td>	
				<td><b>Delivery Person</b></td>	
				<td><b>Action</b></td>															
			</tr>			
<%	
		}
		int i=0;
      	while(mo.rs.next()) {
	      	i=1;
	      	count++;	
	      	divCount=count+"#";   

      		orderNo = mo.rs.getString("order_num");
      		custCode = mo.rs.getString("custcode");
      		custName = mo.rs.getString("custname");
      		buildingNo = mo.rs.getString("building_no");
      		block = mo.rs.getString("block");
      		wing = mo.rs.getString("wing");
      		building = mo.rs.getString("building");
      		area = mo.rs.getString("area");
      		orderDate = mo.rs.getString("order_date");
      		lastModifiedDate = mo.rs.getString("lastmodifieddate");
      		totalItems = mo.rs.getString("total_items");
      		totalValueMrp = mo.rs.getString("total_value_mrp");
      		totalValuePrice = mo.rs.getString("total_value");
      		discountAmt = mo.rs.getString("discount_amt");
      		advanceAmt = mo.rs.getString("advance_amt");
      		balanceAmt = mo.rs.getString("balance_amt");
      		changeAmt = mo.rs.getString("change_amt");
      		paidAmt = mo.rs.getString("paid_amt");
      		expectedAmt = mo.rs.getString("expected_amt");
      		deliveryStaffName = mo.rs.getString("dstaff_name");
      		statusCode = mo.rs.getString("status_code");
	      	
	      	if(submitTypeValue.equals("Submitted1") || submitTypeValue.equals("Submitted2") 
	      			|| submitTypeValue.equals("Submitted3") || submitTypeValue.equals("Checked1") 
	   			 || submitTypeValue.equals("Checked2")  || submitTypeValue.equals("Checked3"))
	      		{
%>      		
  		 		<tr>
	  		 		<td align="left" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
<%
  		 		out.println(custName);
%>    

	      			</td>
	      			<td align="right" >
<%
// Order Num 2
      		    out.println(orderNo);    		    		    		    		
%>
	      		 	</td>
	      		 	<td align="left" >
	      		      		    			
<%	
//	Area 3	
	      		out.println(area);
%>
		      		</td>
		      		<td align="left" >
	      		      					
<%	
//order Date 4	
      		    out.println(orderDate);
%>       	      		      							
	      			</td>
	      			<td align="right" >
<%	
// Total Items 5	
	      		out.println(totalItems);    		           	  			 
%>
	      			</td>
	      			<td align="right">
<%
// Total Values for Sub
	      		 out.println(totalValuePrice);			 
%>
	      		 	</td>
	      		 	<td align="right" >
	      		      					
<%	
//	Advance Amount for Sub		
	      		out.println(advanceAmt);
%>    					
	      		      		 			
		      		</td>
		      		<td align="right" >
<%	
// Discount Amount for Sub	
	      		 out.println(discountAmt);   
%>
	      				
	      		 	</td>
	      		 	<td align="right" >
<%			
//Balance Amt for Sub
	      		out.println(balanceAmt);  
%>      	
	      		      	
  					</td>
  					<td align="left" >
	  				<a href="DeliveryDetailsForm.jsp?orderNo=<%=orderNo%>&subValue=<%=submitTypeValue%>" id=<%=orderNo%> >  
<%			
// Take Action for Sub 
	      		out.println("Take Action");  
	      	} //EOF if Submitted
	      	
/* 				Code for Transit....				*/
	      	else if(submitTypeValue.equals("Transit1") || submitTypeValue.equals("Transit2") || submitTypeValue.equals("Transit3")){
%>    

	      		<tr>
	      			<td align="left" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
<%
	      		out.println(custName);
%>    

	  				</td>
	  				<td align="right" >
<%
//	Order Num 2
	    		out.println(orderNo);    		    		    		    		
%>
  		   			 </td>
  		   			 <td align="left" >	      			       		    			
<%	
// Area 3	
	 			out.println(area);	
%>
  			     	</td>
  			     	<td align="left" >	      			       					
<%	
// order Date 4	
	   		   	out.println(orderDate);
%>       
	      			       							
	   				</td>
	   				<td align="right" >
<%	
//	 Total Items 5	
	      	out.println(totalItems);
	      		       		           	  			 
%>
	      			</td>
	      			<td align="right">
<%
//	Total Values for Sub/Closed/Hlod
			 out.println(totalValuePrice);			 
%>
	   		 		</td>
	   		 		<td align="right" >
	      		       					
<%	
//	Advance Amount fo Sub/Closed/Hlod		
			out.println(advanceAmt);
%>    					
	      		       		 			
	   				</td>
	   				<td align="right" >
<%	
//	Discount Amount fo Sub/Closed/Hlod	

           	out.println(discountAmt);   
%>
	      		 		
	 				</td>
	 				<td align="right" >
<%			
//	Balance Amt 
			out.println(balanceAmt);  
%>      	
	      			</td>
	      			<td align="left" div id=<%=divCount%>>
<%			
//	Delivery Person 
 			out.println(deliveryStaffName);  

%>          		 
			 		</td>
			 		<td align="left" >
			 		<a href="DeliveryActionForm.jsp?orderNo=<%=orderNo%>&subValue=<%=submitTypeValue%>" id=<%=orderNo%> >	 			 			  
<%			
//	Take action for Transit
 			out.println("Take Action");  
	     } //EOF if Transit
	      		      	
 /*				Code for Delivered      				*/      	
	     else if(submitTypeValue.equals("Delivered1") || submitTypeValue.equals("Delivered2") || submitTypeValue.equals("Delivered3")){
%> 


	      	<tr>
	      		<td align="left" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
<%
	      	out.println(custName);
%>    
				</td>
				<td align="right" >
<%
//	Order Num 2
	      	out.println(orderNo);    		    		    		    		
%>
	      		</td>
	      		<td align="left" >	      		    		    			
<%	
//	Area 3	
	      	out.println(area);	
%>
	      		</td>
	      		<td align="left" >
	      		    					
<%	
//	order Date 4	
	      	out.println(orderDate);
%>       
	      		    							
	      		</td>
	      		<td align="left" >
<%	
// Total Items 5	
	      	out.println(totalItems);
%>
	      		</td>
	      		<td align="left">
<%
// Total Values for Delivered
	      	out.println(totalValuePrice);			 
%>
		      	</td>
		      	<td align="left" >	      							
<%	
//Advance Amount for Delivered	
	      	out.println(advanceAmt);
%>    					
	      		</td>
	      		<td align="left" >
<%	
// Discount Amount fo Sub/Closed/Hlod	
			out.println(discountAmt);   
%>
	      		</td>
	      		<td align="left" >
<%			
// Balance Amt 
	      	out.println(balanceAmt);  
%>   
				</td>
				<td align="left" >
<%			
// Change Person 
	      	out.println(changeAmt);  

%>
	      		</td>
	      		<td align="left" >
<%			
//	Paid Person 
	      	out.println(paidAmt);  

%>
				</td>
				<td align="left" div id=<%=divCount%> >
<%			
//	Delivery Person 
	      	out.println(deliveryStaffName);  

%>     

	      		</td>
	      		<td align="left" >
	      		<a href="DeliveredActionForm.jsp?orderNo=<%=orderNo%>&subValue=<%=submitTypeValue%>" id=<%=orderNo%> >	      			 			  
<%			
//	Take action for Delivered
	      	out.println("Take Action");  
	 } //EOF if Delivered
/*  					Code for Hold/Closed				 */      	
	     else if(submitTypeValue.equals("Hold1") || submitTypeValue.equals("Hold2") || submitTypeValue.equals("Hold3") ||
	    		 submitTypeValue.equals("Closed1") || submitTypeValue.equals("Closed2") || submitTypeValue.equals("Closed3")){
%> 
	      	<tr>
	      		<td align="left" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,
	      		<%=mo.rs.getString(8)%>">
<%
	      	out.println(custName);
%>    
				</td>
				<td align="right" >
<%
// Order Num 2
			out.println(orderNo);    		    		    		    		
%>
	      		</td>
	      		<td align="left" >
<%	
//	Area 3	
	      	out.println(area);
%>
	      		</td>
	      		<td align="left" >
<%	
//	 order Date 4	
	      	out.println(orderDate);
%>       
	      		      							
	      		</td>
	      		<td align="left" >
<%	
//	Total Items 5	
	      	out.println(totalItems);
	      		      		           	  			 
%>
	      		</td>
	      		<td align="left">
<%
//	Total Values for Sub
	      	out.println(totalValuePrice);			 
%>
	      		</td>
	      		<td align="left" >
	      		      					
<%	
// Advance Amount for Sub		
	      	out.println(advanceAmt);
%>    					
	      		      		 			
	     		</td>
	     		<td align="right" >
<%	
// Discount Amount for Sub	

	   		out.println(discountAmt);   
%>
	      				
	      		</td>
	      		<td align="left" >
<%			
//	Balance Amt for Sub
	      	out.println(balanceAmt);  
%>
	      		</td>
	      		<td align="left" div id=<%=divCount%> >
<%			
// Delivery staff for Hold/Closed
	      	out.println(deliveryStaffName);  
%>      
	      		</td>
<%
	    if(submitTypeValue.equals("Hold1") || submitTypeValue.equals("Hold2") || submitTypeValue.equals("Hold3")){
%>		
				<td align="left" >
				<a href="javascript:checkHoldStatus('<%=orderNo%>','<%=statusCode%>');" id=<%=orderNo%>>
				<%="Take Action"%></a></td></tr>				 			
<%
	    }
	     else if(submitTypeValue.equals("Closed1") || submitTypeValue.equals("Closed2") || submitTypeValue.equals("Closed3")){
%>	
				<td align="left" ><%="Take Action" %></td></tr>
<%		
	     }
//	Take Action for Hold/CLosed 
	      //	out.println("Take Action");  
		%>
			
		<%
	 } //EOF if Hold/Closed	      	
%> 
	    	 <!-- 							EOF ROW								-->
	  <!--     		</td>
	      	</tr>   -->
		
      		
<%
      	if(divId==0)
      		orderNoArr=orderNo;
		else
		  		orderNoArr=orderNoArr+"|"+orderNo;
      	divId++;	
}//EOF While
		mo.closeAll();	
%>
		<input type="hidden" name="horderArr" value="<%=orderNoArr%>">		
		<input type="hidden" name="hcountorder" value="<%=count%>">	
		<input type="hidden" name="htotalchangeamt" value="">
<input type="hidden" name="htotalordercnt" value="">
<input type="hidden" name="htotalpaidamt" value="">					
</table>

