<%@page contentType="text/html"%>
<%@ page import="java.text.*" %>
<%--  	<jsp:include page="sessionBoth.jsp">	
   		<jsp:param name="formName" value="OrderProcessingSend.jsp" />	
	</jsp:include>
 --%>
 
 <%@ page errorPage="ErrorPage.jsp?page=OrderProcessingSend.jsp" %>
		<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<%
	//DecimalFormat df = new DecimalFormat("###,###.00");
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
	String bagsNo="";
	String discountAmt="";
	String advanceAmt="";
	String balanceAmt="";
	String changeAmt="";
	String paidAmt="";
	String expectedAmt="";
	String deliveryStaffName="";
	String statusCode="";
    String delchgs="";
    String payment="";
    double adamt=0.0f;
    String ord_comm_amt="";
	String submitTypeValue="",startTime="",orderNoArr="",code="",desc="",
		   deliveryPerson="",divCount="";
    String coinArray="" , commArray="";
    boolean subFlag=true;
	int divId=0,count=0;
	submitTypeValue=request.getParameter("subValue");
	String sendValue=request.getParameter("send");
	DecimalFormat df = new DecimalFormat("###,###.00");
	order.ManageOrder mo;
	mo = new order.ManageOrder("jdbc/js");  
	if(submitTypeValue.equals("Submitted3")){
		mo.submittedOrdersList(submitTypeValue);	
	}else if(submitTypeValue.equals("Checked3")){
		mo.checkedOrdersList(submitTypeValue);
	}else if(submitTypeValue.equals("Both")){
		mo.bothOrdersList();
	}
	
	mo.getDeliveryStaffList();
%>
<center><h4>Orders List</h4>

	
      
<table >
	<tr>
	<td>
	<table align="left">
		<tr><td><font size=2 color="red">Total Orders :</td><td><font size=2 color="red"><b><div id="divtonosend"></div></b></td></font></b></tr>
		<tr><td><font size=2 color="red">Total Change :</td><td><font size=2 color="red"><b><div id="divtotchange"></div></td></tr>
		<tr><td><font size=2 color="red">Total Comm.  :</td><td><font size=2 color="red"><b><div id="divtotcomm"></div></td></tr>
		<tr><td><font size=2 color="red">Total  Bags   :</td><td><font size=2 color="red"><b><div id="divtotbags"></div></td></tr>
	</table>
    </td>
    <td>
	<table align="right">
	<tr>
		<td width="25%" ><b><font size=2 color="red">Delivery Person :</b></font></td>
		<td>
			<SELECT name="d_staff" >
				<OPTION VALUE='select' >Select staff
<% 	
	        while (mo.rs1.next()) {
		 		code = mo.rs1.getString(1);
		 		desc = mo.rs1.getString(2);
%>
				<OPTION VALUE="<%=code%>" ><%= desc%>
<% 	
			}		
%>		
		</td>
		<td>
			<INPUT type=BUTTON value='Send <Alt+n>' accesskey='n' onclick='funsend();'>
		</td>			
		<td>		
			<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="cancel();"></center>
		</td>
		<td>		
			<INPUT type=BUTTON value="Denomination <Alt+d>" accesskey="d" onClick="calculate();"></center>
		</td>			
	</tr>
	</table>
	</td>
</tr>
</table><br>

<div>
	<table border="1" id="sendid" style="width=100%;display:none;border-collapse: collapse;" >
	<thead>
		<tr>	
			    <td ><b>Area</b></td>
			    <td ><b>Order</b></td>		
				<td><b>Customer</b></td>					
				<td ><b>Order Date</b></td>			
				<td ><b>Items</b></td>
				<td><b>Payment</b></td>
				
			
				
				<td> <b>Total</b></td>
				<td><b>Advance/Discount</b></td>
				<td><b>Del Chgs</b></td>
				<td><b>Balance</b></td>	
				<td><b>Change</b></td>	
				<td><b>Expected</b></td>
				<td><b>Total Bags</b></td>
				<td colspan="2"><b>Action</b></td>	
				<td colspan="1"><b>Comm Amt</b></td>	
			</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</div>


<br><hr color="red">
<div id="searchTable">        
<table >
	<tr><td width="25%"><font size=2 color="red">Total Orders :  <b><div id="divtono"></div></b></font></b></td>
	
		<td width="25%" ><b><font size=2 color="red">Order Number :</font></b></td>
		<td>
			 <input type="text" name="search" size="7" value=''>
		</td>	

		<td>
			<INPUT type=BUTTON value="Search <Alt+S>" accesskey="s" onClick="searchOno();">
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
<table border="1" name="t" id="id" style="width=100%;" >

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
				<td> <b>Total</b></td>
				<td><b>Advance/Discount</b></td>
				<td><b>Del Chgs</b></td>
				<td><b>Balance</b></td>	
				<td><b>Change</b></td>	
				<td><b>Expected</b></td>
				<td><b>Bags</b></td>
				<td colspan="2"><b>Action</b></td>	
			</tr>
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
      		bagsNo=mo.rs.getString("bags");
      		//System.out.println("bagsNo is:"+bagsNo);
      		discountAmt = mo.rs.getString("discount_amt");
      		advanceAmt = mo.rs.getString("advance_amt");
      		balanceAmt = mo.rs.getString("balance_amt");
      		changeAmt = mo.rs.getString("change_amt");
      		paidAmt = mo.rs.getString("paid_amt");
      		expectedAmt = mo.rs.getString("expected_amt");
      		deliveryStaffName = mo.rs.getString("dstaff_name");
      		statusCode = mo.rs.getString("status_code");
      		
      		delchgs = mo.rs.getString("other_charges");
      		payment = mo.rs.getString("payment_type_desc");
      		ord_comm_amt = df.format(mo.rs.getFloat("ord_comm_amt"));
      		cnt= cnt+1;
      		//System.out.println("value of ord_comm_amt in jsp"+ord_comm_amt);
      		//System.out.println("comm amt "+ord_comm_amt);
%>      	
			<input type="hidden" name="hcommAmt<%=cnt%>" value="<%=ord_comm_amt%>">
			
  		 	<tr id="row<%=rowID%>" class="<%=orderNo%>">
  		 		<td align="center" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
<%
				
  		 		out.println(area);
%>    
     			</td>
	      			<td id="orderNum<%=rowID%>" align="center" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
	      			<a href="Javascript:AddRow('<%=custName%>','<%=orderNo%>','<%=area%>','<%=orderDate%>',
	      			'<%=totalItems%>','<%=totalValuePrice%>','<%=advanceAmt%>','<%=discountAmt%>',
	      			'<%=balanceAmt%>','<%=delchgs%>','<%=adamt%>','<%=payment%>','<%=changeAmt%>',
	      			'<%=expectedAmt%>','<%=bagsNo%>','<%=cnt%>','<%=statusCode%>','<%=ord_comm_amt%>','<%=rowID%>');">
<%
      		    out.println(orderNo);    		    		    		    		
%>
				</td><td align="center" >	
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
				</a>
<%					
				}else{				
						out.println(payment);			 
				}
%>
	      		</td><td align="center" >
<%	
				out.println(totalValuePrice);
%>    					
	      		</td><td align="center" >
<%	
				if(advanceAmt != null && discountAmt != null){
					adamt = Double.parseDouble(advanceAmt) - Double.parseDouble(discountAmt);
			    }
				out.println(adamt);   
%>
				</td><td align="center" >
<%			
				out.println(delchgs);  
%>      	
	 			</td><td align="center" >
<%			
				out.println(balanceAmt);  
%>      	
	 			</td><td align="center" id="change<%=rowID%>" >
<%			
				out.println(changeAmt);  
%>      	
	 			</td><td align="center" >
<%			
				out.println(expectedAmt);  
%>      	
	 			</td><td align="center" id="bag<%=rowID%>">
<%			
				out.println(bagsNo);  
%>      	
	 			</td>
	 			
	 			<td align="center" id="send<%=rowID%>">
	  				<a href="Javascript:AddRow('<%=custName%>','<%=orderNo%>','<%=area%>','<%=orderDate%>',
	  				'<%=totalItems%>','<%=totalValuePrice%>','<%=advanceAmt%>','<%=discountAmt%>',
	  				'<%=balanceAmt%>','<%=delchgs%>','<%=adamt%>','<%=payment%>','<%=changeAmt%>',
	  				'<%=expectedAmt%>','<%=bagsNo%>','<%=cnt%>',
	  				'<%=statusCode%>','<%=ord_comm_amt%>','<%=rowID%>');">
	  				
<%			

				out.println("Send"); 
%>				
				</td><td align="center" id="TA<%=rowID%>">
				<a href="DeliveryDetailsForm.jsp?orderNo=<%=orderNo%>&subValue=<%=statusCode%>" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>" >
<%			
				out.println("T.A.");
				
					  
		
      	if(divId==0){
      		orderNoArr=orderNo;
      		commArray = orderNo+"|"+ord_comm_amt;
      		
		}else{
		  		orderNoArr=orderNoArr+"|"+orderNo;
		  		commArray = commArray+"|"+orderNo+"|"+ord_comm_amt;
		 } 		
      	divId++;	
      	rowID++;
	 	  %>
	 	  </a></td><td style="display: none;">
	 	  <%=ord_comm_amt %>	
	 	  </td>
	 	  </tr>
	 	  <%   
}  
        mo.getcoininfo();
        	while(mo.rs2.next()) {
        	  coinArray = coinArray + "|" + mo.rs2.getString(1);
        	}
		
        mo.closeAll();
        System.out.println("\n\n row ID "+rowID);
        
        
%>
               
</tbody>

<input type="hidden" name="horderArray">
<input type="hidden" name="hcommArray"  value="<%=commArray%>">
<input type="hidden" name="hcoinArray" value="<%=coinArray%>">
<input type="hidden" name="horderArr" value="<%=orderNoArr%>">	
<input type="hidden" name="hchangeArray" value="">		
<input type="hidden" name="hcountorder" value="<%=count%>">	
	
	
<input type="hidden" name="htotalchangeamt" value="">
<input type="hidden" name="htotalordercnt" value="">
<input type="hidden" name="htotalpaidamt" value="">		
</table>	  


	      	