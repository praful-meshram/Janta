<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<jsp:include page="sessionBoth.jsp?formName=RDeliveryDailyReportSummary.jsp"/>
<%
			String str1="",pageName="RDelivery",pageType="Summary",closeResult="";
		    str1=request.getParameter("Exp");	    		    
		    closeResult =  request.getParameter("closeresult");  	    
		    if(str1.equals("1")){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");		    
		    }
%>
<form name="myform" method="post">
<%
DecimalFormat df = new DecimalFormat("###,###.00");
		int count=0;
		report.ManageReports c;
		c = new report.ManageReports("jdbc/js");
    	String hchckall=""; 	
    	hchckall=request.getParameter("hchckall"); 
    	String criteria="";
    	String order_date="";		
		int total_orders=0;		
		int grand_total_orders=0;
		
		float total_value= 0.0f,expected_value=0.0f,total_expected=0.0f;
		float total_change= 0.0f,grand_total_expected=0.0f;
		float total_paid= 0.0f,total_other_amt=0.0f,total_collected=0.0f;
		float total_diff= 0.0f;
		
		float grand_total_value=0.0f;
		float grand_total_change=0.0f;		
		float grand_total_paid=0.0f,grand_total_other_amt=0.0f,grand_total_total_collected=0.0f;
		float grand_total_diff=0.0f;
    	
    	if(hchckall.equals("1")){
            c.listDeliveryDailyReportSummary(); 
    		criteria ="All";   		
    	}
    	else{   		    	
	    	String c_date1="";
	    	String c_date2="";	    		
			
			c_date1=request.getParameter("c_date1");
			c_date2=request.getParameter("c_date2");		
			
			criteria = c_date1 + " to "	+ c_date2;		
			c.listDeliveryDailyReportsWithDateSummary(c_date1,c_date2); %>
		
			<input type="hidden" name="c_date1" value="<%=c_date1%>">
			<input type="hidden" name="c_date2" value="<%=c_date2%>">		
			
<%
		}
%>

       <table  id="id1" border="1" class="item3" width="80%" >
       	<br><center><b> Daily Delivery Report</center> 
       <br>	&nbsp	 Type &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp: Summary
       <br>	&nbsp	 Date Criteria&nbsp&nbsp&nbsp: <%=criteria%>
        	<tr>
				<td width="15%"><b>Date</b></td>				
				<td width="10 %"><b>Total Orders</b></td>
				<td width="15%"><b>Paid Amount</b></td>
				<td width="15%"><b>Other Amount</b></td>
				<td width="15%"><b>Difference</b></td>	
				<td width="15%"><b>Total Expected</b></td>	
				<td width="15%"><b>Total Collected</b></td>			
				<td width="15%"><b>Close Order</b></td>	
            </tr>
      
<%		    			
	    	while(c.rs.next()) {   	
	    		order_date= c.rs.getString(1);	    		  		
	    	if(order_date!=null){
				count++;	
	    		total_orders= c.rs.getInt(2);	
	    		total_paid=c.rs.getFloat(3); 
	    		total_diff=c.rs.getFloat(4);	    		
	    		total_other_amt=c.rs.getFloat(5);
	    		total_collected=c.rs.getFloat(6);	 
	    		total_expected = c.rs.getFloat(7);	   		

    			grand_total_orders = total_orders + grand_total_orders;
	    		grand_total_paid=total_paid+grand_total_paid;
	    		grand_total_other_amt=total_other_amt+grand_total_other_amt;
	    		grand_total_total_collected=total_collected+grand_total_total_collected;	    		
	    		grand_total_diff = total_diff + grand_total_diff;
	    		grand_total_expected = total_expected + grand_total_expected;

/*	    		
    			grand_total_orders = total_orders + grand_total_orders;
				grand_total_value = total_value + grand_total_value;
				grand_total_change = total_change + grand_total_change;
				grand_total_paid = total_paid + grand_total_paid;
				grand_total_expected =expected_value+grand_total_expected;
				grand_total_diff = total_diff + grand_total_diff;
*/				
			}	    	
 %>
			<tr ><td align="left"><a href="RDeliveryDailyReportDetails.jsp?order_date=<%=order_date%>" target="_blank">
<%			
	    	if(order_date!=null)
				out.println(order_date);
%>	
				</a></td><td align="right"><a  href="ReportOrderListWithDate.jsp?order_dt=<%=c.rs.getString(1)%>&Exp=0&pageName=<%=pageName%>" >	
			
<%            
	    	if(order_date!=null) 
    			out.println(total_orders);	
%>
				</a></td><td align="right">
<%             
	    	if(order_date!=null)
    			out.println(df.format(total_paid));	
%>
    	 		</a></td><td align="right">  																							
				
<%							
	    	if(order_date!=null)
				out.println(df.format(total_other_amt));				
%>
				</td><td align="right">  
				<a  href="ReportDifferenceListWithDate.jsp?order_dt=<%=c.rs.getString(1)%>&Exp=0,&pageType=<%=pageType%>&order_type=ALLDIFF&payment_type=ALL" >
<%						
	    	if(order_date!=null)
				out.println(df.format(total_diff));
%>
				</td><td align="right">    	
<%						
	    	if(order_date!=null)
				out.println(df.format(total_expected));
%>
				</td><td align="right">  		
<%						
	    	if(order_date!=null)
				out.println(df.format(total_collected));
%>

<!--				</td><td align="right"><a  href="ReportDifferenceListWithDate.jsp?order_dt=<%=c.rs.getString(1)%>&Exp=0,&pageType=<%=pageType%>" >			-->	    			

<%	    	if(order_date!=null){
%>							
			<td width='8%'><input type="CHECKBOX" name="chck" value='<%=order_date%>' ></td>				
<%}%>			
			</tr>			        	  
<%			    
		}	
		c.closeAll();				
%>
<%	    	if(order_date!=null){
%>
<tr ><td align="right" ><a href="RDeliveryDailyReportAllDetails.jsp" target="_blank"><font color="red">ALL Pending </a></td>
				
				<td align="right"><font color="red">
<%}%>
			<a href="ReportDifferenceListWithAllDate.jsp?Exp=0,&pageType=Summary&order_type=ALL&payment_type=ALL" ><font color="red">			
			<font color="red"> 
<%		
	    	if(order_date!=null)
				out.println(grand_total_orders);
%>	
				</td><td align="right"><font color="red">
<%        
	    	if(order_date!=null)     
    			out.println(grand_total_paid);	
%>
    	 		</a></td><td align="right"> <font color="red"> 	
<%				
	    	if(order_date!=null)
				out.println(grand_total_other_amt);				
%>
				</td><td align="right"> <a href="ReportDifferenceListWithAllDate.jsp?Exp=0,&pageType=Summary&order_type=ALLDIFF&payment_type=ALL" ><font color="red">			
				<font color="red">   			
<%				
	    	if(order_date!=null)		
				out.println(grand_total_diff);
%>
				</td><td align="right"><font color="red"> 		
<%						
	    	if(order_date!=null)
				out.println(df.format(grand_total_expected));
%>
				</td><td align="right">  			
<%			
	    	if(order_date!=null)				
				out.println(grand_total_total_collected);			
%>		
			</td><td align="right"><font color="red"> 	
<!--			
<%				
	    	if(order_date!=null)			
				out.println(grand_total_diff);			
%>	
-->
				</td>
	<td width='8%'> </td>					
			</tr>	
<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>
</table>


<input type="hidden" name="hchckall" value="<%=hchckall%>">
<input type="hidden" name="hiddatearray" value="">
<input type="hidden" name="hcount" value="<%=count%>">	
<!--
<div id="divexcel" style="VISIBILITY:visible"><table><tr><td></td><td><a href="Javascript:Pass();">Save to excel</a></td></tr></table></div>
-->
<center>
<% if(count>0){%>
	<input type="submit" name="Submit"  value="Save to excel <Alt+e>" accesskey="e" onClick="Javascript:Pass();return false;">
<%}%>
	<input type=BUTTON name="Submit"  value="Save <Alt+s>" accesskey="s" onClick="Javascript:save();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
</center><br><br>	

<% if(count==0){%>
	<table align="center" bgcolor="#ECFB99" width=40% height=20% >
		<tr>
			<td align="center"><font color="red" size="5">No Records Available</font></td>
	</tr></table>
<%}%>


<%if(closeResult!=null){
	 if(closeResult.equals("1")){%> 	
		<script>
			alert("Order status set to closed");
		</script>
<%}
}%>



<script>
function Pass(){
	if(document.myform.hcount.value==0)
		alert("No records available to save in excel");
	else if(document.myform.hcount.value>0){
			document.myform.action="RDeliveryDailyReportSummary.jsp?Exp=1";
		    document.myform.submit();
	}
}

function check(){
	var jExp=<%=str1%>			
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}
}
var checkCount=0;
function save(){

	if(document.myform.chck.checked==false){
		alert("No orders selected to close");
		checkCount=0;		
	}
	else if(document.myform.chck.checked==true){
		alert("CHECKED");
		checkCount=1;		
	}
	if(document.myform.chck.value==null){
		for(i=0; i<document.myform.chck.length; i++){
			 if (document.myform.chck[i].checked==true){
			 	checkCount=checkCount+1;		 							 
			 }	 
		}	
		if(checkCount==0)
			alert("No orders selected to close");	
	}	
	if(document.myform.hcount.value==0)
		alert("No records available to save");
	else if(document.myform.hcount.value>0 && checkCount>0){
		checkSelectedDate();	
	
		var ans=confirm("Do you want to change the status to Closed? ");					
		if (ans==true ){
			document.myform.action="RDeliveryCloseOrders.jsp?page=Summary";
	    	document.myform.submit();
		}
		else{
		  	window.refresh; 
		}
	}
}

function checkSelectedDate(){
	var date='$$$$';
	var arr=new Array() ;

if(document.myform.chck.checked==true){			
	 arr=document.myform.chck.value; 
     checkCount=checkCount+1;
}
else if(document.myform.chck.checked==false){				
}

if(document.myform.chck.value==null){
	for(i=0; i<document.myform.chck.length; i++){
		 if (document.myform.chck[i].checked==true){
		 	arr[i]=document.myform.chck[i].value;		 							 
		 }	 
	}		
}	
	document.myform.hiddatearray.value=arr;
}
	window.onload = check;		

</script>
</form>
</body>
</html>