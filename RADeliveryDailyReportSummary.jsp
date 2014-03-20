<jsp:include page="header.jsp"></jsp:include>
<%@page import="beans.JasonObject"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.DeliveryReportSummaryOutputBean"%>
<%@page import="beans.DelivaryReportOutputBean"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="report.ManageReports" %>
<html>
<head>



<!-- files for JqxWidget grid  -->
    <link rel="stylesheet" href="js/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="js/jqwidgets/styles/jqx.darkblue.css" type="text/css" />

    

	<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxdata.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxlistbox.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxcalendar.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxdatetimeinput.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.filter.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.selection.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.sort.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.pager.js"></script>
     <script type="text/javascript" src="js/jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxlistbox.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxdropdownlist.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxdata.export.js"></script> 
     <script type="text/javascript" src="js/jqwidgets/jqxgrid.export.js"></script> 
      <script type="text/javascript" src="js/jqwidgets/jqxgrid.columnsresize.js"></script> 
	<script type="text/javascript" src="js/jqwidgets/jqxgrid.grouping.js"></script>
	
	

<title>Report : Daily Analysis</title>

</head>
<body style="font-family: arial;">

<table style="width: 100%;height: auto;border: 10px;cursor: pointer;">
		<tr>
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td ><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>

<center>
<%
			String str1="",pageName="RDelivery",pageType="Summary",closeResult="";
		    str1=request.getParameter("Exp");	    		    
		    closeResult =  request.getParameter("closeresult");  	    
		    if(str1.equals("1")){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");
		    	%>
		    	<style type="text/css">
					#wrapper{
					width: 80%;
					height: 500px;
					overflow-y: scroll;
					overflow-x: hidden;
				}
				#id2{
					background-color: gray;
					color: white;
				}
				#one{
					background-color: #E6E6E6;
					cursor: pointer;
				}
				#two{
					background-color: #FAFAFA ;
					cursor: pointer;
				}
				#one td,#two td,#id2 td{
					padding: 3px 5px 3px 0px;
				}
				</style>
		    	<%
		    }
%>
<form name="myform" method="post">
<%
DecimalFormat df = new DecimalFormat("###,###.00");
		int count=0;
		report.ManageReports c;
		//c = new ManageReports("jdbc/js");
		c = new ManageReports("jdbc/re");
    	String hchckall=""; 	
    	hchckall=request.getParameter("hchckall"); 
    	String criteria="";
    	String order_date="";
    	String close_date="";
    	String close_status="";	
    	String del_datetime="";	
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
            c.VlistDeliveryDailyReportSummary(); 
    		criteria ="All";   		
    	}
    	else{   		    	
	    	String c_date1="";
	    	String c_date2="";	    		
			
			c_date1=request.getParameter("c_date1");
			c_date2=request.getParameter("c_date2");		
			
			criteria = c_date1 + " to "	+ c_date2;		
			c.VlistDeliveryDailyReportsWithDateSummary(c_date1,c_date2); %>
		
			<input type="hidden" name="c_date1" value="<%=c_date1%>">
			<input type="hidden" name="c_date2" value="<%=c_date2%>">		
<%
		}
%>
		<h4> Daily Delivery Report</h4> 
       <br>Type : Summary
       <br>Date Criteria: <%=criteria%>
      
       <div id="wrapper" style="display: none;">
        
<%		    int cnt=0;	
			
			ArrayList<DeliveryReportSummaryOutputBean> listOutputBeans = new ArrayList(); 
	    	while(c.rs.next()) {   	
	    		try{
	    			order_date= c.rs.getString(1);	    		  		
	    		} catch(Exception e){
	    			order_date=null;
	    		}
	    	if(order_date!=null){
				count++;
				close_status = 	c.rs.getString(2);
	    		total_orders= c.rs.getInt(3);	
	    		total_paid=c.rs.getFloat(4); 
	    		total_diff=0;	    		
	    		total_other_amt=0;
	    		
	    		total_collected=c.rs.getFloat(5);	 
	    		total_expected = c.rs.getFloat(6);	   		
				del_datetime = c.rs.getString(7);
				
    			grand_total_orders = total_orders + grand_total_orders;
	    		grand_total_paid=total_paid+grand_total_paid;
	    		grand_total_other_amt=total_other_amt+grand_total_other_amt;
	    		grand_total_total_collected=total_collected+grand_total_total_collected;	    		
	    		grand_total_diff = total_diff + grand_total_diff;
	    		grand_total_expected = total_expected + grand_total_expected;			
	    		
	    		DeliveryReportSummaryOutputBean outputBean = new DeliveryReportSummaryOutputBean();
	    		outputBean.setClosedDate("<a href=\"RADeliveryDailyReportDetails.jsp?order_date="+order_date.substring(0,10)+"&close_status="+close_status+"\" target=\"_blank\">"+order_date.substring(0,10)+"</a>");
	    						//http://localhost:8080/Janta/RADeliveryDailyReportDetails.jsp?order_date=2009-07-01&close_status=BULK_2009-07-01
	    		
	    		outputBean.setClosedDate1(order_date.substring(0,10));
	    		outputBean.setCloseStatus(close_status);
	    		outputBean.setTotalOrders((total_orders+"").trim());
	    		outputBean.setPaidAmount(df.format(total_paid));
	    		outputBean.setTotalExpected(df.format(total_expected));
	    		outputBean.setTotalBalance(df.format(total_collected));
	    		listOutputBeans.add(outputBean);
			}
	    	
	    	
			cnt++;
		}	
		c.closeAll();
		
		DeliveryReportSummaryOutputBean outputBean = new DeliveryReportSummaryOutputBean();
		
		//outputBean.setTotalOrders((grand_total_orders+"").trim());
		//outputBean.setPaidAmount(df.format(grand_total_paid));
		//outputBean.setTotalExpected(df.format(grand_total_expected));
		//outputBean.setTotalBalance(df.format(grand_total_total_collected));
		//listOutputBeans.add(outputBean);
		
		
		JsonOutputBean jsonOutputBean = new JsonOutputBean();
		jsonOutputBean.setOutputData(listOutputBeans);
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Closed Date","closedDate"));
		jqxgridFormat  format = new jqxgridFormat("Closed Date","closedDate1");
		format.setHidden(true);
		jsonOutputBean.getFormat().add(format);
		jsonOutputBean.getFormat().add(new jqxgridFormat("Closed Status","closeStatus"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Orders","totalOrders"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Paid Amount","paidAmount"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Expected","totalExpected"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Balance","totalBalance"));
		
		
		out.println(new Gson().toJson(jsonOutputBean));
		System.out.println(new Gson().toJson(jsonOutputBean));
		%>
 		</div>
      <div id="delivaryGrid"></div>
      
		
<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>
<input type="hidden" name="hchckall" value="<%=hchckall%>">
<input type="hidden" name="hiddatearray" value="">
<input type="hidden" name="hcount" value="<%=count%>">	
<!--
<div id="divexcel" style="VISIBILITY:visible"><table><tr><td></td><td><a href="Javascript:Pass();">Save to excel</a></td></tr></table></div>
-->
<center>
<% if(count>0){%>
	<!-- <input type="submit" name="Submit"  value="Save to excel <Alt+e>" accesskey="e" onClick="Javascript:Pass();return false;"> -->
<%}%>
	<!-- <input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>"> -->
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
			document.myform.action="RADeliveryDailyReportSummary.jsp?Exp=1";
		    document.myform.submit();
	}
}

function check(){
	var jExp='<%=str1%>';			
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}


	var gsonObject = jQuery.parseJSON($('#wrapper').html());
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
         	$("#delivaryGrid").jqxGrid(
            {	
            	theme:'darkblue',
                height: 350,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                //showaggregates: true,
                groupable: true,
               // selectionmode: 'singlecell',
                columns:gsonObject.format
                
            });	
			
			$("#saveToExcel").click(function () {
			
				$('#delivaryGrid').jqxGrid('hidecolumn', 'closedDate');
               	$('#delivaryGrid').jqxGrid('showcolumn', 'closedDate1');
				
                $("#delivaryGrid").jqxGrid('exportdata', 'xls', 'Customer Details');          
                
                 $('#delivaryGrid').jqxGrid('hidecolumn', 'closedDate1');
               	$('#delivaryGrid').jqxGrid('showcolumn', 'closedDate'); 
            });	
	
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