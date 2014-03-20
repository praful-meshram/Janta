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
    <link rel="stylesheet" href="js/jqwidgets/styles/jqx.ui-redmond.css" type="text/css" />
    
    <script type="text/javascript" src="js/jqwidgets/gettheme.js"></script>
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
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.aggregates.js"></script> 
     <script type="text/javascript" src="js/jqwidgets/jqxdata.export.js"></script> 
     <script type="text/javascript" src="js/jqwidgets/jqxgrid.export.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.grouping.js"></script>
<%@ page errorPage="ReportErrorPage.jsp?page=RCollectionMonthlyReport.jsp" %>

	<table style="width: 100%;height: auto;border: 10px;">
		<tr style="cursor: pointer;">
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>

<%
			String str1="",pageName="Rcollection";
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
		report.ManageReports c;
		//c = new report.ManageReports("jdbc/js");
		c = new report.ManageReports("jdbc/re");
    	String hchckall=""; 	
    	hchckall=request.getParameter("hchckall"); 
    	String criteria="";
    	
    	
    	String order_date="";		
		int total_orders=0;		
		int grand_total_orders=0;
		
		float total_value= 0.0f;
		float total_change= 0.0f;
		float total_paid= 0.0f;
		float total_diff= 0.0f;
		
		float grand_total_value=0.0f;
		float grand_total_change=0.0f;		
		float grand_total_paid=0.0f;
		float grand_total_diff=0.0f;
		
    	if(hchckall.equals("1")){
    		c.listCollectionMonthlyReports(); 
    		criteria ="All";
    	}
    	else{
    		    	
	    	String selMonth="";			
			selMonth=request.getParameter("selMonth");		
			criteria = 	selMonth;		
			c.listCollectionMonthlyReportsWithDate(selMonth); %>
		
			<input type="hidden" name="selMonth" value="<%=selMonth%>">
<%
		}
%>

		
      
       <center><b> Monthly Sales Report</center> 
       <br>	&nbsp	 Type &nbsp&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp: Detail
       <br>	&nbsp	 Month Criteria&nbsp&nbsp&nbsp:  <%=criteria%>
       <div id="monthlySalesInfo" style="display:none;">
<%		    	
			ArrayList<SalesOutputBean> listOutputBeans = new ArrayList();
			JsonOutputBean jsonOutputBean = new JsonOutputBean(); 
	    	while(c.rs.next()) {
	    	
	    		order_date= c.rs.getString(1);	    		  		
	    		total_value= c.rs.getFloat(2);
	    		total_change= c.rs.getFloat(3);
	    		total_paid= c.rs.getFloat(4);
	    		total_diff= c.rs.getFloat(5);
	    		total_orders= c.rs.getInt(6);
	    		String year = c.rs.getString(7);
	    		
	    		SalesOutputBean outputBean = new SalesOutputBean();
	    		outputBean.setTotal_value(df.format(total_value));
	    		outputBean.setTotal_chang((total_change+"").trim());
	    		outputBean.setTotal_paid((total_paid+"").trim());
	    		outputBean.setTotal_diff((total_diff+"").trim());
	    		outputBean.setTotal_orders("<a  href=\"ReportOrderListWithMonth.jsp?selMonth="+c.rs.getString(1)+"&Exp=0&pageName="+pageName+"\" >"+(total_orders+"").trim()+"</a>");
	    		outputBean.setYear(year);
	    		outputBean.setOrder_date(order_date);
	    		
	    			grand_total_orders = total_orders + grand_total_orders;
					grand_total_value = total_value + grand_total_value;
					grand_total_change = total_change + grand_total_change;
					grand_total_paid = total_paid + grand_total_paid;
					grand_total_diff = total_diff + grand_total_diff;
			listOutputBeans.add(outputBean);		
		    
		}	
		c.closeAll();	
		jsonOutputBean.setOutputData(listOutputBeans);
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Month","order_date"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Year","year"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Orders","total_orders"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Order Value","total_value"));
		
		jsonOutputBean.setGrandTotalOrders((grand_total_orders+"").trim());
		jsonOutputBean.setGrandTotalValues((grand_total_value+"").trim());
		System.out.println(new Gson().toJson(jsonOutputBean));
		out.println(new Gson().toJson(jsonOutputBean));
		
		
%>
</div>
	
<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>
</table>



<input type="hidden" name="hchckall" value="<%=hchckall%>">
<!-- <div id="divexcel" style="VISIBILITY:visible"><table><tr><td></td><td><a href="Javascript:Pass();">Save to excel</a></td></tr></table></div> -->
<div id="monthlySalesInfoGrid"></div>
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
	
	
	var gsonObject = jQuery.parseJSON($('#monthlySalesInfo').html());
		//alert(gsonObject.grandTotalValues);
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
         	$("#monthlySalesInfoGrid").jqxGrid(
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
                //selectionmode: 'singlerow',
                 groupable: true,
                columns:[
                		{"text":"Order Month","datafield":"order_date"},
                		{"text":"Order Year","datafield":"year"},
                		{"text":"Total Orders","datafield":"total_orders",aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  //return aggregatedValue + currentValue;
																					                                  return gsonObject.grandTotalOrders;
																					                              }
																					                              //return aggregatedValue;
																					                              return gsonObject.grandTotalOrders;
																					                 }//end of aggreagite sum function
																				   }]
                		
                		},
                		{"text":"Total Order Value","datafield":"total_value",aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
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
                $("#monthlySalesInfoGrid").jqxGrid('exportdata', 'xls', 'Monthly Sales Report');           
            });	
	
}
	window.onload = check;

</script>
</form>
</body>
</html>