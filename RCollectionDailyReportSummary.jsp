<jsp:include page="header.jsp"></jsp:include>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.SalesOutputBean"%>
<%@page import="beans.SalesReportOutputBean"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>

<%-- <jsp:include page="sessionBoth.jsp?formName=RCollectionDailyReportSummary.jsp"/> --%>


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
   <script type="text/javascript" src="js/jqwidgets/jqxgrid.columnsresize.js"></script>     
<%@ page errorPage="ReportErrorPage.jsp?page=RCollectionDailyReportSummary.jsp" %>

<%
			String str1="",pageName="RCollection";
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
    		c.listCollectionDailyReportSummary(); 
    		criteria ="All";
    	}
    	else{
    		    	
	    	String c_date1="";
	    	String c_date2="";	    		
			
			c_date1=request.getParameter("c_date1").replace("/","-").trim();
			c_date2=request.getParameter("c_date2").replace("/","-").trim();		
			
			System.out.println("c_date1 "+c_date1);
			System.out.println("c_date2 "+c_date2);
			criteria = c_date1 + " to "	+ c_date2;	
			c.listCollectionDailyReportsWithDateSummary(c_date1,c_date2); %>
		
			<input type="hidden" name="c_date1" value="<%=c_date1%>">
			<input type="hidden" name="c_date2" value="<%=c_date2%>">
<%
		}
%>

		<table style="width: 100%;height: auto;border: 10px;">
		<tr style="cursor: pointer;">
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td ><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>
       	<br><center><b> Daily Sales Report</center> 
       <br>	&nbsp	 Type &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp: Summary
       <br>	&nbsp	 Date Criteria&nbsp&nbsp&nbsp: <%=criteria%>
        <div id="dailySalesReport" style="display: none;">	
        
<%		    	
		ArrayList<SalesOutputBean> lisOutputBeans = new ArrayList();
		JsonOutputBean jsonOutputBean = new JsonOutputBean();
		
	    	while(c.rs.next()) {	    	
	    		order_date= c.rs.getString(1);	    		  		
	    		total_value= c.rs.getFloat(2);
	    		total_change= c.rs.getFloat(3);
	    		total_paid= c.rs.getFloat(4);
	    		total_diff= c.rs.getFloat(5);
	    		total_orders= c.rs.getInt(6);
	    		
	    		grand_total_orders = total_orders + grand_total_orders;
				grand_total_value = total_value + grand_total_value;
				grand_total_change = total_change + grand_total_change;
				grand_total_paid = total_paid + grand_total_paid;
				grand_total_diff = total_diff + grand_total_diff;
				
				//creating outbea object
				SalesOutputBean dailySalesOutputBean = new SalesOutputBean();
				dailySalesOutputBean.setOrder_date(order_date);
				dailySalesOutputBean.setTotal_value((total_value+"").trim());
				dailySalesOutputBean.setTotal_chang((total_change+"").trim());
				dailySalesOutputBean.setTotal_paid((total_paid+"").trim());
				dailySalesOutputBean.setTotal_diff((total_diff+"").trim());
				dailySalesOutputBean.setTotal_orders("<a  href=\"ReportOrderListWithDate.jsp?order_dt="+c.rs.getString(1)+"&Exp=0&pageName="+pageName+"\">"+(total_orders+"").trim()+"</a>");
		    	dailySalesOutputBean.setTotalOrders1((total_orders+""));
				
			lisOutputBeans.add(dailySalesOutputBean);
		}	
	    	c.closeAll();
	    	jsonOutputBean.setOutputData(lisOutputBeans);
	    	
	    	/* jsonOutputBean.getFormat().add(new jqxgridFormat("Date11","order_date"));
	    	jsonOutputBean.getFormat().add(new jqxgridFormat("Total Orders","total_orders"));
	    	jqxgridFormat format = new jqxgridFormat("Total Orders","totalOrders1");
	    	//format.setHidden(true);
	    	jsonOutputBean.getFormat().add(new jqxgridFormat("Total Orders","totalOrders1"));
	    	jsonOutputBean.getFormat().add(new jqxgridFormat("Total Value","total_value"));
	    	 */
	    	jsonOutputBean.setGrandTotalOrders((grand_total_orders+"").trim());
	    	jsonOutputBean.setGrandTotalValues((grand_total_value+"").trim());
	    	System.out.println(new Gson().toJson(jsonOutputBean));
	    	out.println(new Gson().toJson(jsonOutputBean));
	    	
	    	System.out.println("grand_total_orders "+grand_total_orders);
	    	System.out.println("grand_total_value "+grand_total_value);
	    	System.out.println("grand_total_value1111111111111 "+grand_total_value);

%>
</div>


<input type="hidden" name="hchckall" value="<%=hchckall%>">
<!-- <div id="divexcel" style="VISIBILITY:visible"><table><tr><td></td><td><a href="Javascript:Pass();">Save to excel</a></td></tr></table></div> -->
<div id="dailySalesReportGrid"></div>

<script>
function Pass(){
		document.myform.action="RCollectionDailyReportSummary.jsp?Exp=1";
	    document.myform.submit();
}
function check(){	
	var jExp=<%=str1%>			
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}
	//alert($('#dailySalesReport').html());
	var gsonObject = jQuery.parseJSON($('#dailySalesReport').html());
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
         	$("#dailySalesReportGrid").jqxGrid(
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
                   //columnsresize: true,
                //selectionmode: 'singlerow',
                columns:
                [
	                {"text":"Date","datafield":"order_date","width":"200px"},
	                {"text":"Total Orders","datafield":"total_orders",aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  return gsonObject.grandTotalOrders;
																					                              }
																					                              
																					                              return gsonObject.grandTotalOrders;
																					                 }//end of aggreagite sum function
																				   }]
	                ,"width":"200px"
	                },
	                {"text":"Total Orders","datafield":"totalOrders1",hidden:true,"width":"200px"},
	                {"text":"Total Value","datafield":"total_value",aggregates: [{'Grand Total': function (aggregatedValue, currentValue) {
																					                              if (currentValue) {
																					                                  return gsonObject.grandTotalValues;
																					                              }
																					                              
																					                              return gsonObject.grandTotalValues;
																					                 }//end of aggreagite sum function
																				   }]
	                
	                }
                ]
                
            });	
            
             $("#saveToExcel").click(function () {
             	$('#dailySalesReportGrid').jqxGrid('hidecolumn', 'total_orders');
                $('#dailySalesReportGrid').jqxGrid('showcolumn', 'totalOrders1');
                
                $("#dailySalesReportGrid").jqxGrid('exportdata', 'xls', 'Daily Sales Report');           
            	
            	$('#dailySalesReportGrid').jqxGrid('hidecolumn', 'totalOrders1');
            	$('#dailySalesReportGrid').jqxGrid('showcolumn', 'total_orders');
				
            });	
	
}
	window.onload = check;

</script>
</form>
</body>
</html>