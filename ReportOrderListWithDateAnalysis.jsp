<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<jsp:include page="sessionBoth.jsp?formName=ReportOrderListWithDate.jsp"/> 
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
		String order_dt="",pageName="";
		order_dt=request.getParameter("order_dt");	
		String payment_type="";
		payment_type=request.getParameter("payment_type");
		pageName=request.getParameter("pageName");
		String criteria=order_dt;
		String query="";
		Connection conn=null;
		Statement stat=null;
		ResultSet rs=null;
%>
<table  border="1" id="id" class="item3">
		<br><center><b> Sales Report</center> 
		<br>	&nbsp	 Type &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp: Summary
		<br>	&nbsp	 Criteria&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:  <%=criteria%>
      
		<input type="hidden" name="order_dt" value="<%=order_dt%>">
		<input type="hidden" name="orderNo" value="">
<%
		
		try{	
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stat=conn.createStatement();
			if(pageName.equals("RCollection")){
				if(payment_type != null){
					query="select  a.order_num, a.custcode, a.order_date, a.total_items, a.total_value, a.total_value_mrp, a.total_value_discount, b.payment_type_desc, a.lastmodifieddate ,a.status_code from orders a, payment_type b where a.payment_type_code=b.payment_type_code and trim(Date(a.order_date))='"+order_dt+"' and a.payment_type_code ='"+payment_type+"' ";				
				}
				else{
				     query="select  a.order_num, a.custcode, a.order_date, a.total_items, a.total_value, a.total_value_mrp, a.total_value_discount, b.payment_type_desc, a.lastmodifieddate, a.status_code  from orders a, payment_type b where a.payment_type_code=b.payment_type_code and trim(Date(a.order_date))='"+order_dt+"' ";		
				}
%>
	      <tr>				
				
				<td ><b>Order Number</b></td>
				<td ><b>Customer Code</b></td>
				<td ><b>Order Date</b></td>
				<td ><b>Total Items</b></td>
				<td><b>Total Values</b></td>
				<td><b>MRP</b></td>
				<td><b>Discount</b></td>
				<td><b>Payment Type</b></td>
				<td><b>Last Modified Date</b></td>
				<td><b>Status</b></td>
				
								
			</tr>
<%		
		rs=stat.executeQuery(query);    
    	while(rs.next()) {
 %>
			<tr id="tr">	
		
				<td align="left"><a href="Javascript:passVar('<%=rs.getString(1)%>');">
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
    	
			out.println(rs.getString(4));
%>
			</td><td align="left">
<%			
			out.println(rs.getString(5));
%>       
			</td><td align="left">
<%			
			out.println(rs.getString(6));
%>       
			</td><td align="left">
<%			
			out.println(rs.getString(7));
%>       
			</td><td align="left">
<%			
			out.println(rs.getString(8));
%>       
			</td><td align="left">
<%			
			out.println(rs.getString(9));
%>       
			</td><td align="left">
<%			
			out.println(rs.getString(10));
%>       
			</td></tr>			        	  
		    
<%		 }		
		}else if(pageName.equals("RDelivery")){	
				String orderNo="";	
				String custName="";
				String area="";
				String lastModifiedDate="";	
				String totalItems="";
				String totalValue="";
				String discountAmt="";
				String advanceAmt="";
				String balanceAmt="";
				String changeAmt="";
				String paidAmt="";	
				String delchgs="";
			    String payment="";
			    double adamt=0.0f;
			    double expAmt=0.0f;
    
				if(payment_type != null){
					query="select  c.area, a.order_num, c.custname, a.lastmodifieddate, a.total_items, b.payment_type_desc, "+
					"a.total_value, a.advance_amt, a.discount_amt, other_charges, a.balance_amt, a.change_amt, a.paid_amt "+
					"from orders a, payment_type b, customer_master c "+
					"where a.payment_type_code=b.payment_type_code and a.status_code='DELIVERED' and a.custcode=c.custcode "+
					"and trim(Date(a.del_datetime))='"+order_dt+"' and a.payment_type_code ='"+payment_type+"' ";									
				}
				else{
				     query="select  c.area, a.order_num, c.custname, a.lastmodifieddate, a.total_items, b.payment_type_desc, "+
					 "a.total_value, a.advance_amt, a.discount_amt, other_charges, a.balance_amt, a.change_amt, a.paid_amt "+
					 "from orders a, payment_type b, customer_master c "+
				     "where a.payment_type_code=b.payment_type_code and a.status_code='DELIVERED' and a.custcode=c.custcode and "+
				     "trim(Date(a.del_datetime))='"+order_dt+"' ";											     								     
				}
%>
			<tr>	
			    <td ><b>Area</b></td>
			    <td ><b>Order</b></td>		
				<td><b>Customer</b></td>					
				<td ><b>Order Date</b></td>			
				<td ><b>Items</b></td>
				<td><b>Payment</b></td>
				<td colspan="7" align="center"><b>Amounts</b></td>											
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
			</tr>
<%
			
			rs=stat.executeQuery(query);
			  
    		while(rs.next()) {  
    		
    		area = rs.getString(1);
    		orderNo = rs.getString(2);
      		custName = rs.getString(3);     		
      		lastModifiedDate = rs.getString(4);
      		totalItems = rs.getString(5);
      		payment = rs.getString(6);
      		totalValue = rs.getString(7);
      		advanceAmt = rs.getString(8);      	
      		discountAmt = rs.getString(9);      		
      		delchgs = rs.getString(10);
      		balanceAmt  = rs.getString(11);
      		changeAmt = rs.getString(12);
      		paidAmt = rs.getString(13);        				
%>

<tr>
  		 		<td>
<%				
  		 		out.println(area);
%>    
     			</td><td align="center" ><a href="Javascript:passVar('<%=orderNo%>');">
<%
      		    out.println(orderNo);    		    		    		    		
%>
				</td><td align="center" >	
<%	
				out.println(custName);
%>
				</td><td align="center" >	
<%	      
				out.println(lastModifiedDate);
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
				out.println(totalValue);
%>    					
	      		</td><td align="center" >
<%	
				if(advanceAmt != null && discountAmt != null){
					adamt = Double.parseDouble(advanceAmt) + Double.parseDouble(discountAmt);
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
<%			
				out.println(changeAmt);  
%>      	
				</td><td align="center" >
	 			
<%			
				if(balanceAmt != null && changeAmt != null){
					expAmt = Double.parseDouble(balanceAmt) + Double.parseDouble(changeAmt);
			    }
				out.println(expAmt); 				 
%>      	
	 			</td><td align="center" >
	 			
<%			
				out.println(paidAmt);  
%>      	
				</td></tr>

<%
		}
		}
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

<div id="div4" style="VISIBILITY:visible"><table><tr><td><a href="Javascript:Pass();">Save to excel</a></td></tr></table></div>

<%
	}
	catch (Exception e) {
		e.getMessage();
		e.printStackTrace();
		System.out.println(e);
	}
%>   




<script>
function passVar(code){
    	document.myform.orderNo.value=code;
		document.myform.action="print_order.jsp?&backPage=Reports.jsp&buttonFlag=Y";
	    document.myform.submit();
}
function Pass(){
		document.myform.action="ReportOrderListWithDateAnalysis.jsp?Exp=1";
	    document.myform.submit();
}
function check(){	
	var jExp=<%=str1%>			
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}
}
	window.onload = check;


</script>

</form>
</body>
</html>	

