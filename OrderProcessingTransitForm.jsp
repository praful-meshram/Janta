<%@page contentType="text/html"%>
<%@ page import="java.text.*" %>
<%--  	<jsp:include page="sessionBoth.jsp">	
   		<jsp:param name="formName" value="OrderProcessingTransitForm.jsp" />	
	</jsp:include>
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=OrderProcessingTransitForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<%
	int cnt=1;
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
	String deliveryStaffName="" ,deliveryStaffcode="";
	String statusCode="";
    String delchgs="";
    String payment="";
    double adamt=0.0f;
    double totalchangeamt=0.0f;
    double totalpaidamt=0.0f;
    double ord_comm_amt=0.0f;
    
	String submitTypeValue="",startTime="",orderNoArr="",code="",desc="",
		   deliveryPerson="",divCount="", commArray="";
    boolean subFlag=true;
	int divId=0,count=0;
	submitTypeValue=request.getParameter("subValue");
	String dp_code=request.getParameter("code");
	String dp_desc=request.getParameter("desc");
	DecimalFormat df = new DecimalFormat("###,###.00");
	order.ManageOrder mo;
	mo = new order.ManageOrder("jdbc/js");  
	mo.getOrderDetailsbyDP(dp_code);	
	mo.getDeliveryStaffList();
%>
<center><h4>Orders List</h4></center>
        
<table border="0" style="border-collapse:collapse;width: 100%;">
	<tr>
		<td ><font size=2 color="red">Total Orders :</td><td><font size=2 color="red"><b><div id="divtonosend"></div></b></td></font></b>
		<td ><font size=2 color="red">&nbsp&nbspDelivery Person :&nbsp;&nbsp;<font size=2 color="red"><b><%=dp_desc%></b></font></td> 
			
		<td>
			<INPUT type=BUTTON value='Delivered <Alt+d>' accesskey='d' onclick='funsendTransit();'>
		</td>			
		<td >		
			<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="cancel();"></center>
		</td>		
	</tr>		
</table><br>

<table border="1" id="sendid" style="border-collapse: collapse;width: 100%;display: none;">
	<thead>
		 <tr>	
			    <td ><b>Area</b></td>
			    <td ><b>Order</b></td>		
				<td><b>Customer</b></td>					
				<td ><b>Order Date</b></td>			
				<td ><b>Items</b></td>
				<td><b>Payment</b></td>
				<td> <b>Paid</b></td>				
				<td><b>Balance</b></td>	
				<td><b>Change</b></td>	
				<td><b>Expected</b></td>				
				<td colspan="2"><b>Action</b>
				<td><b>Comm. Amt</b></td>
				</td>	
			</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<br><hr color="red">
<div id="searchTable">        
<table  width="100%">
	<tr><td>
	<table align="left" >	
		<tr><td><font size=2 color="red">Total Orders : </td><td><font size=2 color="red"><b><div id="divtono"></div></b></font></b></td></tr>
		<tr><td><font size=2 color="red">Total Change :</td><td><font size=2 color="red"><b><div id="divtotchange"></div></td></tr>
		<tr><td align="left"><font size=2 color="red">Total Paid &nbsp&nbsp&nbsp&nbsp&nbsp:</td><td><font size=2 color="red"><b><div id="divtotpaid"></div></td></tr>
	</table>
    </td>
    <td>
	<table align="right" >
		<tr>	
			<td width="25%" ><b><font size=2 color="red">Order Number :</font></b></td>
			<td>
				 <input type="text" name="search" size="7" value=''>
			</td>	
	
			<td>
				<INPUT type=BUTTON value="Search <Alt+S>" accesskey="s" onClick="searchOnoTransit();">
			</td>
			<td>
				<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
			</td>			
			<td>		
				<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="cancel();"></center>
			</td>		
		</tr>
	</table>
	</td>
</tr>
</table><br>
</div>
<table border="1" name="t" id="id" width="100%" style="border-collapse: collapse;">

	<thead>
		 <tr>	
			    <td ><b>Area</b></td>
			    <td ><b>Order</b></td>		
				<td><b>Customer</b></td>					
				<td ><b>Order Date</b></td>			
				<td ><b>Items</b></td>
				<td><b>Payment</b></td>
				<td colspan="6" align="center"><b>Amounts</b></td>											
			</tr>
				<tr>
				<td colspan="6"></td>
				<td> <b>Paid</b></td>				
				<td><b>Balance</b></td>	
				<td><b>Change</b></td>	
				<td><b>Expected</b></td>				
				<td colspan="2"><b>Action</b></td>	
				
			</tr>
	</thead>
	<tbody>
<%
	int i=0,rowID=0;
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
      		deliveryStaffcode = mo.rs.getString("dstaff_code");
      		deliveryStaffName = mo.rs.getString("dstaff_name");
      		statusCode = mo.rs.getString("status_code");
      		delchgs = mo.rs.getString("other_charges");
      		payment = mo.rs.getString("payment_type_desc");
      		ord_comm_amt = mo.rs.getDouble("ord_comm_amt");
      		
      		totalchangeamt =totalchangeamt + Double.parseDouble(changeAmt); 
      		totalpaidamt = totalpaidamt +  Double.parseDouble(paidAmt);   		
%>      	
  		 	<tr id="row<%=rowID%>">
  		 		<td align="center" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
<%
				cnt= cnt+1;
  		 		out.println(area);
%>    
     			</td>
	      			<td id="orderNum<%=rowID%>" align="center" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>" >
	      			<a href="Javascript:AddRowTransit('<%=custName%>','<%=orderNo%>','<%=area%>',
	      			'<%=orderDate%>','<%=totalItems%>','<%=totalValuePrice%>','<%=advanceAmt%>',
	      			'<%=discountAmt%>','<%=balanceAmt%>','<%=delchgs%>','<%=adamt%>','<%=payment%>',
	      			'<%=changeAmt%>','<%=expectedAmt%>','<%=cnt%>','<%=submitTypeValue%>','<%=paidAmt%>','<%=rowID%>');">
	  				<%
      		    out.println(orderNo);    		    		    		    		
%></td><td align="center" >	
<%	
				out.println(custName);
%>
				</td><td align="center" >	
<%	      
				out.println(orderDate);
%>       	      		      							
	      		</td><td align="center" >
<%	
				out.println(totalItems);    		           	  			 
%>
	      		</td><td align="center">
<%				if(payment.equals("Credit")){
%>	
				<a href="ChangePaymentTypeForm.jsp?orderNo=<%=orderNo%>">
<%
					out.println(payment);	
%>
				
<%					
				}else{				
						out.println(payment);			 
				}
%>
	      		</td><td align="center" id="paid<%=rowID%>"><font color="red">
<%	
				out.println(paidAmt);
%>    			
	 		</font>	</td><td align="center" >
<%			
				out.println(balanceAmt);  
%>      	
	 			</td><td align="center" >
<%			
				out.println(changeAmt);  
%>      	
	 			</td><td align="center" >
<%			
				out.println(expectedAmt);  
%>      	
	 			</td><td align="center" id="select<%=rowID%>" >
	  				<a href="Javascript:AddRowTransit('<%=custName%>','<%=orderNo%>','<%=area%>','<%=orderDate%>','<%=totalItems%>',
	  				'<%=totalValuePrice%>','<%=advanceAmt%>','<%=discountAmt%>','<%=balanceAmt%>','<%=delchgs%>','<%=adamt%>',
	  				'<%=payment%>','<%=changeAmt%>','<%=expectedAmt%>','<%=cnt%>','<%=submitTypeValue%>','<%=paidAmt%>','<%=rowID%>');">
	  				
<%			
				out.println("Select"); 
%>				
				</td><td align="center" id="TA<%=rowID%>"
				title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
				<a href="DeliveryActionForm.jsp?orderNo=<%=orderNo%>&subValue=<%=submitTypeValue%>" >
<%			
				out.println("T.A.");  
		
      	if(divId==0){
      		orderNoArr=orderNo;
      		commArray = orderNo+","+ord_comm_amt;
		}else{
		  	orderNoArr=orderNoArr+"|"+orderNo;
		  	commArray = commArray+","+orderNo+","+ord_comm_amt;
		 } 	
      	divId++;	
		%>
			</a></td>
			</td>
			<td style="display: none;" id="comm<%=rowID%>"> <%=ord_comm_amt %></td>
			<td style="display: none;"> <%=totalValuePrice %></td>
			<td style="display: none;"> <%=delchgs%></td>
			</tr>
		<%
	 	  rowID++;   
}
        mo.closeAll();
%>
     </tbody></table>           
<input type="hidden" name="htotalchangeamt" value="<%=totalchangeamt%>">
<input type="hidden" name="htotalordercnt" value="<%=count%>">
<input type="hidden" name="htotalpaidamt" value="<%=totalpaidamt%>">
<input type="hidden" name="horderArray">	
<input type="hidden" name="horderArr" value="<%=orderNoArr%>">	
<input type="hidden" name="hchangeArray" value="">		
<input type="hidden" name="hcountorder" value="<%=count%>">	

<input type="hidden" name="hd_staff"  value="<%=deliveryStaffcode%>">
<input type="hidden" name="hcommArray"  value="<%=commArray%>">
		
</table>  

	      	