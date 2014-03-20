<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<jsp:include page="sessionBoth.jsp?formName=RDeliveryDailyReport.jsp"/>
<%
			String str1="";
		    str1=request.getParameter("Exp");	    
		    if(str1.equals("1")){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");		    
		    }
%>
<form name="myform" method="post">
<%	
		DecimalFormat df = new DecimalFormat("###,###.00");
		String order_date="",pageName="RDelivery",pageType="Daily";
		String payment_type="";
		String prev_order_date="";	
		String criteria="";
		
		int total_orders=0,count=0;
		int sub_total_orders=0;
		int grand_total_orders=0;
		
		float total_value= 0.0f;
		float total_change= 0.0f;
		float total_paid= 0.0f;
		float total_diff= 0.0f,expected_value=0.0f;
		
		float sub_total_value=0.0f;
		float sub_total_change=0.0f;		
		float sub_total_paid=0.0f,sub_total_expected=0.0f;
		float sub_total_diff=0.0f;
		
		float grand_total_value=0.0f;
		float grand_total_change=0.0f;		
		float grand_total_paid=0.0f,grand_total_expected=0.0f;
		float grand_total_diff=0.0f;
		
		report.ManageReports c;
		//c = new report.ManageReports("jdbc/js");
		c = new report.ManageReports("jdbc/re");
    	String hchckall=""; 	
    	hchckall=request.getParameter("hchckall");   	
    	if(hchckall.equals("1")){
    		//c.listCollectionDailyReports();
    		c.listDeliveryDailyReports();
    		criteria ="All"; 
    	}
    	else{
    		    	
	    	String c_date1="";
	    	String c_date2="";	    		
			
			c_date1=request.getParameter("c_date1");
			c_date2=request.getParameter("c_date2");					
			criteria = c_date1 + " to "	+ c_date2;	
			try{			
				c.listDeliveryDailyReportsWithDate(c_date1,c_date2); 
			}catch(Exception e){
				System.out.println("Error in RdeliveryreporsJSP...");
				e.printStackTrace();
			}
%>
		
			<input type="hidden" name="c_date1" value="<%=c_date1%>">
			<input type="hidden" name="c_date2" value="<%=c_date2%>">
<%
		}
%>	
       <table  id="id1" border="1" class="item3" width="80%" >
       <br><center><b> Daily Delivery Report</center> 
       <br>	&nbsp	 Type &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp: Detail
       <br>	&nbsp	 Date Criteria&nbsp&nbsp&nbsp:  <%=criteria%>
        	<tr>
				<td width="15%"><b>Date</b></td>
				<td width="15%"><b>Payment Type</b></td>
				<td width="10 %"><b>Total Orders</b></td>
				<td width="15%"><b>Order Value</b></td>
				<td width="15%"><b>Change Amount</b></td>
				<td width="15%"><b>Received Amount</b></td>
				<td width="15%"><b>Expected Amount</b></td>
				<td width="15%"><b>Difference</b></td>					
            </tr>
<%		    	
		   	while(c.rs.next()) {
		   		    		
	    		order_date= c.rs.getString(1);	 
			if(order_date!=null){		
				count++;
	    		total_value= c.rs.getFloat(2);
	    		total_change= c.rs.getFloat(3);
	    		total_paid= c.rs.getFloat(4);
	    		total_diff= c.rs.getFloat(5);
	    		total_orders= c.rs.getInt(6);
	    		payment_type= c.rs.getString(7); 
	    		expected_value=total_value+total_change;	
	    	}	
	    		if(!prev_order_date.equals(order_date) && prev_order_date!=""){
					if(order_date!=null)	{
%>
				<tr><td align="right" colspan="2"><font color="blue">Sub Total</font></td>
				
				<td align="right"><a  href="ReportOrderListWithDate.jsp?order_dt=<%=prev_order_date%>&Exp=0&pageName=<%=pageName%>"  >			    			
				
<%			}
			if(order_date!=null)				
				out.println(sub_total_orders);
%>	
				</td><td align="right"><font color="blue">
<%             
    		if(order_date!=null)	
    			out.println(sub_total_value);	
%>
    	 		</a></td><td align="right"> <font color="blue"> 
<%							
			if(order_date!=null)	
				out.println(sub_total_change);				
%>
				</td><td align="right">  <font color="blue">  			
<%						
			if(order_date!=null)	
				out.println(sub_total_paid);
%>

				</td><td align="right"><font color="blue">    			
<%							
			if(order_date!=null)	
				out.println(sub_total_expected);			
%>		
				</td><td align="right"><font color="blue">    			
<%							
			if(order_date!=null)	
				out.println(sub_total_diff);			
%>		
				</td>
			</tr>		

<%				
				if(order_date!=null){
					grand_total_orders = sub_total_orders + grand_total_orders;
					grand_total_value = sub_total_value + grand_total_value;
					grand_total_change = sub_total_change + grand_total_change;
					grand_total_paid = sub_total_paid + grand_total_paid;	
					grand_total_expected = sub_total_expected+grand_total_expected;			
					grand_total_diff = sub_total_diff + grand_total_diff;
				}	
					sub_total_orders = 0;
					sub_total_value = 0.00f;
					sub_total_change = 0.00f;
					sub_total_paid = 0.00f;
					sub_total_diff = 0.00f;
				}	    		
 %>
			<tr ><td align="left">
<%				
		if(order_date!=null)			
				out.println(order_date);				
%>	
				</a></td><td align="left">
<%		
			if(order_date!=null)						
				out.println(payment_type);							
%>	
				</a></td><td align="right"><a  href="ReportOrderListWithDate.jsp?order_dt=<%=c.rs.getString(1)%>&payment_type=<%=payment_type%>&Exp=0&pageName=<%=pageName%>" >			    			
<%             
    		if(order_date!=null)
    			out.println(total_orders);	
%>
				</a></td><td align="right">
<%             
    		if(order_date!=null)	
    			out.println(total_value);	
%>
    	 		</a></td><td align="right">														
<%	
			if(order_date!=null)	
				out.println(total_change);				
%>
				</td><td align="right">    			
<%						
			if(order_date!=null)	
				out.println(total_paid);
%>
				</td><td align="right">   
								
<%							
			if(order_date!=null)
				out.println(expected_value);			
%>		
		<td align="right"><a  href="ReportDifferenceListWithDate.jsp?order_dt=<%=order_date%>&Exp=0&pageType=<%=pageType%>"  >			    			
<%							
			if(order_date!=null)
				out.println(total_diff);			
%>		
				</td>
			</tr>			        	  
<%		
				if(order_date!=null){
					sub_total_orders = sub_total_orders + total_orders;
					sub_total_value = sub_total_value + total_value;
					sub_total_change = sub_total_change + total_change;
					sub_total_paid = sub_total_paid + total_paid;
					sub_total_expected = sub_total_expected+expected_value;
					sub_total_diff = sub_total_diff + total_diff;
					
					prev_order_date = order_date;		 
				}
		}	
		c.closeAll();	
%>	
			<tr>
<%if(order_date!=null)	{%>			
			<td align="right" colspan="2"><font color="blue">Sub Total</td>
<%}%>			
			<td align="right"><a  href="ReportOrderListWithDate.jsp?order_dt=<%=order_date%>&Exp=0&pageName=<%=pageName%>&payment_type=<%=payment_type%>"  >			    			
			
<%						
			if(order_date!=null)
				out.println(sub_total_orders);
%>	
				</a></td><td align="right"><font color="blue">
<%             
    		if(order_date!=null)	
    			out.println(sub_total_value);	
%>
    	 		</a></td><td align="right"> <font color="blue">					
<%						
			if(order_date!=null)	
				out.println(sub_total_change);				
%>
				</td><td align="right"> <font color="blue">   			
<%						
			if(order_date!=null)	
				out.println(sub_total_paid);
%>
				</td><td align="right"><font color="blue">   
								 	
<%				
			if(order_date!=null)			
				out.println(sub_total_expected);			
%>					

				</td><td align="right"><font color="blue">   						
<%							
			if(order_date!=null)
				out.println(sub_total_diff);			
%>		
				</td>
			</tr>	
<%
				if(order_date!=null){
					grand_total_orders = sub_total_orders + grand_total_orders;
					grand_total_value = sub_total_value + grand_total_value;
					grand_total_change = sub_total_change + grand_total_change;
					grand_total_paid = sub_total_paid + grand_total_paid;
					grand_total_expected = sub_total_expected+grand_total_expected;
					grand_total_diff = sub_total_diff + grand_total_diff;
				}
%>	
<%if(order_date!=null)	{%>			
			<tr ><td align="right" colspan="2"><font color="red">Grand Total</td>
<%}%>				
				<td align="right"><font color="red">
<%		
			if(order_date!=null)	
				out.println(grand_total_orders);
%>	
				</td><td align="right"><font color="red">
<%             
    		if(order_date!=null)	
    			out.println(grand_total_value);	
%>
    	 		</a></td><td align="right"> <font color="red"> 	
<%				
			if(order_date!=null)	
				out.println(grand_total_change);				
%>
				</td><td align="right"> <font color="red">   			
<%						
			if(order_date!=null)	
				out.println(grand_total_paid);
%>
			</td><td align="right">   <font color="red"> 
<%							
			if(order_date!=null)	
				out.println(grand_total_expected);			
%>		

				</td><td align="right">   <font color="red"> 			
<%							
			if(order_date!=null)	
				out.println(grand_total_diff);			
%>		
				</td>
			</tr>	
<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>
</table><br><br>

<% if(count==0){%>
	<table align="center" bgcolor="#ECFB99" width=40% height=20% >
		<tr>
			<td align="center"><font color="red" size="5">No Records Available</font></td>
	</tr></table>
<%}%>

<input type="hidden" name="hchckall" value="<%=hchckall%>">
<input type="hidden" name="hcount" value="<%=count%>">
<% if(count>0){%>
	<div id="divexcel" style="VISIBILITY:visible"><table><tr><td></td><td><a href="Javascript:Pass();">Save to excel</a></td></tr></table></div>
<%}%>

<script>
function Pass(){
	if(document.myform.hcount.value==0)
		alert("No records available to save in excel");
	else if(document.myform.hcount.value>0){
		document.myform.action="RDeliveryDailyReport.jsp?Exp=1";		
	    document.myform.submit();
    }
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