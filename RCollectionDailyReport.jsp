<jsp:include page="header.jsp"></jsp:include>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.SalesOutputBean"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>


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
        <script type="text/javascript" src="js/jqwidgets/jqxgrid.aggregates.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.grouping.js"></script>

<%@ page errorPage="ReportErrorPage.jsp?page=RCollectionDailyReport.jsp" %>

	<table style="width: 100%;height: auto;border: 10px;">
		<tr style="cursor: pointer;">
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>

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
		String order_date="",pageName="RCollection";
		String payment_type="";
		String prev_order_date="";
		String criteria="";
		
		int total_orders=0;
		int sub_total_orders=0;
		int grand_total_orders=0;
		
		float total_value= 0.0f;
		float total_change= 0.0f;
		float total_paid= 0.0f;
		float total_diff= 0.0f;
		
		float sub_total_value=0.0f;
		float sub_total_change=0.0f;		
		float sub_total_paid=0.0f;
		float sub_total_diff=0.0f;
		
		float grand_total_value=0.0f;
		float grand_total_change=0.0f;		
		float grand_total_paid=0.0f;
		float grand_total_diff=0.0f;
		
		report.ManageReports c;
		//c = new report.ManageReports("jdbc/js");
		c = new report.ManageReports("jdbc/re");
    	String hchckall=""; 	
    	hchckall=request.getParameter("hchckall"); 
    	
    	if(hchckall.equals("1")){
    		c.listCollectionDailyReports();
    		criteria ="All"; 
    	}
    	else{
    		    	
	    	String c_date1="";
	    	String c_date2="";	    		
			
			c_date1=request.getParameter("c_date1").replace("/", "-");
			c_date2=request.getParameter("c_date2").replace("/", "-");					
			criteria = c_date1 + " to "	+ c_date2;	
			c.listCollectionDailyReportsWithDate(c_date1,c_date2); 
%>
		
			<input type="hidden" name="c_date1" value="<%=c_date1%>">
			<input type="hidden" name="c_date2" value="<%=c_date2%>">
<%
		}
%>	
       <br><center><b> Daily Sales Report</center> 
       <br>	&nbsp	 Type &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp: Detail
       <br>	&nbsp	 Date Criteria&nbsp&nbsp&nbsp:  <%=criteria%>
        	
       <div id="dailyReport" style="display: none;"> 	
<%		    ArrayList<SalesOutputBean> listOutputBeans = new ArrayList();
			JsonOutputBean jsonOutputBean = new JsonOutputBean();
		   	while(c.rs.next()) {
		   		    		
	    		order_date= c.rs.getString(1);	    		  		
	    		total_value= c.rs.getFloat(2);
	    		total_change= c.rs.getFloat(3);
	    		total_paid= c.rs.getFloat(4);
	    		total_diff= c.rs.getFloat(5);
	    		total_orders= c.rs.getInt(6);
	    		payment_type= c.rs.getString(7); 		
	    		
	    		SalesOutputBean  outputBean = new SalesOutputBean();
	    		SalesOutputBean  outputBeanInnerObject = new SalesOutputBean(); // for sub total
	    		
	    		outputBean.setOrder_date(order_date);
	    		outputBean.setPaymentType(payment_type);
	    		outputBean.setTotal_orders("<a href=\"ReportOrderListWithDate.jsp?order_dt="+c.rs.getString(1)+"&payment_type="+payment_type+"&Exp=0&pageName="+pageName+"\">"+(total_orders+"").trim()+"</a>");
	    		outputBean.setTotalOrders1((sub_total_orders+"").trim());
	    		outputBean.setTotal_value((total_value+"").trim());   // order value  
	    		
	    		outputBean.setTotal_diff((total_diff+"").trim());
	    		outputBean.setTotal_chang((total_change+"").trim());
	    		outputBean.setTotal_paid((total_paid+"").trim());
	    		
	    		
	    		
	    		if(!prev_order_date.equals(order_date) && prev_order_date!=""){
					grand_total_orders = sub_total_orders + grand_total_orders;
					grand_total_value = sub_total_value + grand_total_value;
					grand_total_change = sub_total_change + grand_total_change;
					grand_total_paid = sub_total_paid + grand_total_paid;
					grand_total_diff = sub_total_diff + grand_total_diff;
					
					outputBeanInnerObject.setTotal_orders("<a  href=\"ReportOrderListWithDate.jsp?order_dt="+prev_order_date+"&Exp=0&pageName="+pageName+"\">"+(sub_total_orders+"").trim()+"</a>");
					outputBeanInnerObject.setTotalOrders1((sub_total_orders+"").trim());
					outputBeanInnerObject.setTotal_value((sub_total_value+"").trim());
					outputBeanInnerObject.setTotal_chang((sub_total_change+"").trim());
					outputBeanInnerObject.setTotal_paid((sub_total_paid+"").trim());
					outputBeanInnerObject.setTotal_diff((sub_total_diff+"").trim());
					outputBeanInnerObject.setPaymentType("<a style=\"color:blue;\">Sub Total</span> ");
					outputBeanInnerObject.setPaymentType1("Sub Total");
					outputBeanInnerObject.setOrder_date("");
					
					sub_total_orders = 0;
					sub_total_value = 0.00f;
					sub_total_change = 0.00f;
					sub_total_paid = 0.00f;
					sub_total_diff = 0.00f;
					listOutputBeans.add(outputBeanInnerObject);
				}	    		
	    		
	    		listOutputBeans.add(outputBean);
	    		
	    		sub_total_orders = sub_total_orders + total_orders;
				sub_total_value = sub_total_value + total_value;
				sub_total_change = sub_total_change + total_change;
				sub_total_paid = sub_total_paid + total_paid;
				sub_total_diff = sub_total_diff + total_diff;
				
				
				//setting Grand Total
				grand_total_orders = grand_total_orders + total_orders;
				grand_total_value = grand_total_value + total_value;
				grand_total_change = grand_total_change + total_change;
				grand_total_paid = grand_total_paid + total_paid;
				grand_total_diff = grand_total_diff + total_diff;
				
				
				prev_order_date = order_date;		 
		}	
		   	 
		c.closeAll();	
		/* grand_total_orders = sub_total_orders + grand_total_orders;
		grand_total_value = sub_total_value + grand_total_value;
		grand_total_change = sub_total_change + grand_total_change;
		grand_total_paid = sub_total_paid + grand_total_paid;
		grand_total_diff = sub_total_diff + grand_total_diff; */
		
		
		jsonOutputBean.setOutputData(listOutputBeans);
		jsonOutputBean.setGrandTotalOrders((grand_total_orders+"").trim());
		jsonOutputBean.setGrandTotalValues((grand_total_value+"").trim());
		
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Date","order_date"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Payment Type","paymentType"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Orders","total_orders"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Value","total_value"));
		
	
		System.out.println(new Gson().toJson(jsonOutputBean));
		out.println(new Gson().toJson(jsonOutputBean));
		System.out.println("grand_total_orders "+grand_total_orders);
		System.out.println("grand_total_value "+grand_total_value);
%>	
	</div>
	
	<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>



<input type="hidden" name="hchckall" value="<%=hchckall%>">
<!-- <div id="divexcel" style="VISIBILITY:visible"><table><tr><td></td><td><a href="Javascript:Pass();">Save to excel</a></td></tr></table></div> -->
</form>
<div id="dailyReportGrid"></div>
</body>
<script>
function Pass(){
		
		document.myform.action="RCollectionDailyReport.jsp?Exp=1";		
	    document.myform.submit();
}
function check(){	
	var jExp=<%=str1%>			
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}
	
		var gsonObject = jQuery.parseJSON($('#dailyReport').html());
		//alert(gsonObject.grandTotalValues);
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
         	$("#dailyReportGrid").jqxGrid(
            {	
            	theme:'darkblue',
                height: 340,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                showaggregates: true,
                showstatusbar: true,
                  groupable: true,
                //selectionmode: 'singlerow',
                columns:[
                		{"text":"Date","datafield":"order_date",width:'250px'},
                		{"text":"Payment Type","datafield":"paymentType",width:'250px'},
                		{"text":"Payment Type","datafield":"paymentType1",width:'250px',hidden:true},
                		{"text":"Total Orders","datafield":"total_orders",aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  //return aggregatedValue + currentValue;
																					                                  return gsonObject.grandTotalOrders;
																					                              }
																					                              //return aggregatedValue;
																					                              return gsonObject.grandTotalOrders;
																					                 }//end of aggreagite sum function
																				   }],width:'250px'
                		
                		},
                		{"text":"Total Orders","datafield":"totalOrders1",hidden:true,width:'250px'},
                		
                		{"text":"Order Value","datafield":"total_value",aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  //return aggregatedValue + currentValue;
																					                                  return gsonObject.grandTotalValues;
																					                              }
																					                              //return aggregatedValue;
																					                              return gsonObject.grandTotalValues;
																					                 }//end of aggreagite sum function
																				   }]
                		
                		}
                		]
                
            });	
            
             $("#saveToExcel").click(function () {
             	$('#dailyReportGrid').jqxGrid('hidecolumn', 'total_orders');
                $('#dailyReportGrid').jqxGrid('showcolumn', 'totalOrders1');
             
  		        $('#dailyReportGrid').jqxGrid('hidecolumn', 'paymentType');
                $('#dailyReportGrid').jqxGrid('showcolumn', 'paymentType1');
          
                $("#dailyReportGrid").jqxGrid('exportdata', 'xls', 'Daily Sales Report');  
                
                $('#dailyReportGrid').jqxGrid('hidecolumn', 'totalOrders1');
                $('#dailyReportGrid').jqxGrid('showcolumn', 'total_orders');     
                
                $('#dailyReportGrid').jqxGrid('hidecolumn', 'paymentType1');
                $('#dailyReportGrid').jqxGrid('showcolumn', 'paymentType');     
                    
            });	
}
	window.onload = check;

</script>

</html>