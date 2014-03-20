<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="ReportDifferenceListWithAllDate.jsp" />	
</jsp:include>
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=ReportDifferenceListWithAllDate.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<%
			String str1="";
		    str1=request.getParameter("Exp");		    
		    if(str1.equals("1")){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");		    
		    }
%>

<head>
<title>Sales... </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
.boldtable, .boldtable TD, .boldtable TH
{
font-family:arial;
font-size:10pt;
}
</style>
</head>
<body>
<form name="myform" method="post">

<%	
	report.ManageReports mo;
	mo = new report.ManageReports("jdbc/js");
	
	String order_dt="",del_datetiem="",pageType="",order_type="";
	//order_dt=request.getParameter("order_dt");
	String payment_type="";
	payment_type=request.getParameter("payment_type");	
	pageType=request.getParameter("pageType");
	order_type=request.getParameter("order_type");
	
	mo.VlistDeliveryDailyReportAllDetailsNew(payment_type,order_type);
	
	String criteria="ALL";
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
	float totalValuePrice=0.0f;
	String discountAmt="";
	String advanceAmt="";
	float balanceAmt=0.0f;
	float changeAmt=0.0f;
	float paidAmt=0.0f;
	float expectedAmt=0.0f;
	String deliveryStaffName="";
	String statusCode="";
    float delchgs=0.0f;
    String payment="";
    double adamt=0.0f;  
    float diffamt=0.0f;  
    float grand_total_value=0.0f;
    double grand_total_adamt=0.0f;
    float grand_total_del=0.0f;
    float grand_total_bal=0.0f;
	float grand_total_change=0.0f;	
	float grand_total_exp=0.0f;	
	float grand_total_paid=0.0f;	
	float grand_total_diff=0.0f;
	
	DecimalFormat df = new DecimalFormat("###,###.0");	
%>
<table border="1" name="t" id="id" width="100%" >
<%     
	if(!order_type.equals("ALL")){
%>
		<br><center><b> Difference Report</center> 
<%
	   }else{
%>
		<br><center><b> All Order Details</center> 
<%
		}
%>
		<br>	&nbsp	 Type &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:  <%=pageType%>
		<br>	&nbsp	 Criteria&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:  <%=criteria%>
      
		<input type="hidden" name="order_dt" value="">
		<input type="hidden" name="orderNo" value="">
			 <tr>	
			    <td ><b>Area</b></td>
			    <td ><b>Order</b></td>		
				<td><b>Customer</b></td>					
				<td ><b>Order Date</b></td>			
				<td ><b>Items</b></td>
				<td><b>Payment</b></td>
				<td colspan="8" align="center"><b>Amounts</b></td>											
			</tr>
				<tr>
				<td colspan="6"></td>
				<td> <b>Total</b></td>
				<td><b>Advance/Discount</b></td>
				<td><b>Del Chgs</b></td>
				<td><b>Balance</b></td>	
				<td><b>Change</b></td>	
				<td><b>Expected</b></td>				
				<td><b>Paid</b></td>	
				<td><b>Difference</b></td>	
			</tr>
<%
	int i=0;
      	while(mo.rs.next()) {
	      	i=1;
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
      		totalValuePrice = mo.rs.getFloat("total_value");
      		discountAmt = mo.rs.getString("discount_amt");
      		advanceAmt = mo.rs.getString("advance_amt");
      		balanceAmt = mo.rs.getFloat("balance_amt");
      		changeAmt = mo.rs.getFloat("change_amt");
      		paidAmt = mo.rs.getFloat("paid_amt");
      		expectedAmt = mo.rs.getFloat("expected_amt");
      		deliveryStaffName = mo.rs.getString("dstaff_name");
      		statusCode = mo.rs.getString("status_code");
      		delchgs = mo.rs.getFloat("delv_charges");
      		payment = mo.rs.getString("payment_type_desc");
      		
      			grand_total_value = totalValuePrice + grand_total_value;
      			grand_total_del= delchgs + grand_total_del;
      			grand_total_bal= balanceAmt +grand_total_bal;      			
      			grand_total_change= changeAmt  +grand_total_change;      			
	    		grand_total_paid=paidAmt+grand_total_paid;	    		
	    		grand_total_exp = expectedAmt + grand_total_exp;
      		
%>      	
  		 	<tr>
  		 		<td align="center" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
<%
				out.println(area);
%>    
     			</td>
	      			<td align="center" title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
	      			<a href="Javascript:passVar('<%=orderNo%>');">
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
<%
					out.println(payment);	
				
%>
				</td><td align="center" >
<%
				out.println(totalValuePrice);
%>    					
	      		</td><td align="center" >
<%	
				if(advanceAmt != null && discountAmt != null){
					adamt = Double.parseDouble(advanceAmt) - Double.parseDouble(discountAmt);
					grand_total_adamt= adamt + grand_total_adamt;	
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
	 			</td><td align="center" >
<%						out.println(changeAmt);  
		if(!order_type.equals("ALL")){
%>
	      		</td><td align="center" bgcolor="#ECFB99">
<%	    }else{
%>     	
	 			</td><td align="center">
<%			
		}		out.println(expectedAmt);  
		if(!order_type.equals("ALL")){
%>
	      		</td><td align="center" bgcolor="#ECFB99">
<%	    }else{
%>	 		
				</td><td align="center">
<%			
		}		out.println(paidAmt);  
%>  	 									
 				</td><td align="center">
 				
<% 			
				
					diffamt = expectedAmt - paidAmt;
					grand_total_diff = diffamt + grand_total_diff;
			   
				out.println(diffamt);  		 
 %>				
 				
 				</tD></tr>
<%    }
	mo.closeAll();
%>
<tr ><td align="right" colspan="6"><font color="red"  >Grand Total</td>
				
				<td align="center"><font color="red">
				
<%			    	
				out.println(df.format(grand_total_value));
%>	
				</td><td align="center"><font color="red">
<%        
	    	  
    			out.println(df.format(grand_total_adamt));	
%>
				</td><td align="center"><font color="red">
<%        
	    	  
    			out.println(df.format(grand_total_del));	
%>
    	 		</a></td><td align="center"> <font color="red"> 	
<%				
	    	
				out.println(df.format(grand_total_bal));				
%>
				</td><td align="center"> <font color="red">   			
<%				
	    			
				out.println(df.format(grand_total_change));
		if(!order_type.equals("ALL")){
%>
	      		</td><td align="center" bgcolor="#ECFB99"><font color="red"> 
<%	    }else{
%>
				</td><td align="center"><font color="red"> 		
<%						
	    }	
				out.println(df.format(grand_total_exp));
	if(!order_type.equals("ALL")){
%>
	      		</td><td align="center" bgcolor="#ECFB99"><font color="red"> 
<%	    }else{
%>
				</td><td align="center"><font color="red">   			
<%		}	
	    					
				out.println(df.format(grand_total_paid));			
%>		
				</td></td><td align="center"><font color="red">   			
<%			
	    					
				out.println(df.format(grand_total_diff));			
%>		
			</td></tr>

	
<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>
</table>	  
<div id="div4" style="VISIBILITY:visible"><table><tr><td><a href="Javascript:Pass();">Save to excel</a></td></tr></table></div>
<script>
function passVar(code){
    	document.myform.orderNo.value=code;
		document.myform.action="print_order.jsp?&backPage=Reports.jsp&buttonFlag=Y";
	    document.myform.submit();
}
function Pass(){
		document.myform.action="ReportDifferenceListWithAllDateAnalysis.jsp?Exp=1";
	    document.myform.submit();
}



</script>

</form>
</body>
</html>	

