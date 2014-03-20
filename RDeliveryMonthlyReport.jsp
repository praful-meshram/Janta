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
<%@ page errorPage="ReportErrorPage.jsp?page=RDeliveryMonthlyReport.jsp" %>


<table style="width: 100%;height: auto;border: 10px;">
		<tr style="cursor: pointer;">
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>


<%
			String str1="",check="",pageName="RDelivery";
		    str1=request.getParameter("Exp");		    
		    if(str1.equals("1")){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");		    
		    }
		    check=request.getParameter("hchckall");		    
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
		String year="";
    	String order_date="";		
		int total_orders=0,count=0;		
		int grand_total_orders=0;
		
		//float total_value= 0.0f,expected_value=0.0f;
		//float total_change= 0.0f;
		float total_paid= 0.0f,total_other_amt=0.0f,total_collected=0.0f,total_diff= 0.0f;
		
		float total_expected=0.0f,grand_total_expected=0.0f;
		//float grand_total_change=0.0f;		
		float grand_total_paid=0.0f,grand_total_diff=0.0f,grand_total_other_amt=0.0f,
			  grand_total_total_collected=0.0f;
		
    	if(hchckall.equals("1")){
    		c.listDeliveryMonthlyReports(); 
    		criteria ="All";
    	}
    	else{
    		    	
	    	String selMonth="";			
			selMonth=request.getParameter("selMonth");		
			criteria = 	selMonth;		
			c.listDeliveryMonthlyReportsWithDate(selMonth); %>
		
			<input type="hidden" name="selMonth" value="<%=selMonth%>">
<%
		}
%>

		
       
       	<br><center><b> Monthly Delivery Report</center> 
       <br>	&nbsp	 Type &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp: Detail
       <br>	&nbsp	 Month Criteria&nbsp&nbsp&nbsp:  <%=criteria%>
       
        <div id="delivaryMonth" style="display: none;">
<%		    	
			ArrayList<SalesOutputBean> listOutputBeans = new ArrayList();
	    	while(c.rs.next()) {	
	    		order_date= c.rs.getString(1);		    	
		    	if(order_date!=null){ 
			    	count++; 
			    	//monthName=c.rs.getString(1);
			    	year = c.rs.getString(2);
		    		total_orders= c.rs.getInt(3);
			    	total_paid= c.rs.getFloat(4);
			    	total_other_amt=c.rs.getFloat(5);
			    	total_collected=c.rs.getFloat(7);
			    	total_diff=c.rs.getFloat(5);
		    		total_expected = c.rs.getFloat(8);

	    			grand_total_orders = total_orders + grand_total_orders;
					grand_total_paid = total_paid + grand_total_paid;
					grand_total_other_amt = +grand_total_other_amt;
					grand_total_total_collected = total_collected+grand_total_total_collected;
					grand_total_diff = total_diff+grand_total_diff;
					grand_total_expected = total_expected + grand_total_expected;
					
					SalesOutputBean outputBean = new SalesOutputBean(); 
					outputBean.setOrder_date(order_date); // month
					outputBean.setYear(year);
					/* outputBean.setTotal_orders("<a  href=\"ReportOrderListWithMonth.jsp?selMonth="+c.rs.getString(1)+"&Exp=0&pageName="+
												pageName+"&check='"+document.myform.hchckall.value+"'\">"+(total_orders+"").trim()+"</a>");
				 */
				 	
					outputBean.setTotal_orders("<a  href=\"ReportOrderListWithMonth.jsp?selMonth="+c.rs.getString(1)+"&Exp=0&pageName="+
							pageName+"&check='1' \">"+(total_orders+"").trim()+"</a>");
					outputBean.setTotalOrders1(df.format(total_orders));
					outputBean.setTotal_paid(df.format(total_paid));
					outputBean.setTotal_other_amt(df.format(total_other_amt));
					outputBean.setTotal_collected(df.format(total_collected));
					outputBean.setDiffamt("<a  href=\"ReportDifferenceListWithMonth.jsp?selMonth="+c.rs.getString(1)+"&Exp=0&check="+check+"\" >"+df.format(total_diff)+"</a>");
					outputBean.setDiffamt1(df.format(total_diff));
					outputBean.setExpectedAmount((total_expected+"").trim());
					
					listOutputBeans.add(outputBean);
					
				}
			    
		    	
		}	
	    c.closeAll();	
		JsonOutputBean jsonOutputBean	= new JsonOutputBean();
		jsonOutputBean.setOutputData(listOutputBeans);
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Month","order_date","110px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Year","year","110px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Orders","totalOrders","180px"));
		jqxgridFormat  format = new  jqxgridFormat("Total Orders","totalOrders1","180px"); 
		format.setHidden(true);
		jsonOutputBean.getFormat().add(format); 
		jsonOutputBean.getFormat().add(new jqxgridFormat("Paid Amount","total_paid","180px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Other Amount","total_other_amt","180px"));
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Difference","diffamt","180px"));
		format = new jqxgridFormat("Difference","diffamt1","180px");
		format.setHidden(true);
		jsonOutputBean.getFormat().add(format); 
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Expected","expectedAmount","180px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Collected","total_collected"));
		
		System.out.println(new Gson().toJson(jsonOutputBean));
		out.println(new Gson().toJson(jsonOutputBean));
		
	    
%>	
</div>
<div id="delivaryMonthGrid"></div>
<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>
<br>




<input type="hidden" name="hcount" value="<%=count%>">
<input type="hidden" name="hchckall" value="<%=hchckall%>">

<script>
function Pass(){
	if(document.myform.hcount.value==0)
		alert("No records available to save in excel");
	else if(document.myform.hcount.value>0){
		document.myform.action="RCollectionDailyReport.jsp?Exp=1";
	    document.myform.submit();
	}
}
function check(){	
	var jExp=<%=str1%>			
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}
	
	var gsonObject = jQuery.parseJSON($('#delivaryMonth').html());
		//alert(gsonObject.grandTotalValues);
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
         	$("#delivaryMonthGrid").jqxGrid(
            {	
            	theme:'darkblue',
                height: 340,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                 groupable: true,
                //showaggregates: true,
                //showstatusbar: true,
                //selectionmode: 'singlerow',
                columns:gsonObject.format
                		
                
            });	
            
             $("#saveToExcel").click(function () {
             	
             	$('#delivaryMonthGrid').jqxGrid('hidecolumn', 'totalOrders');
             	$('#delivaryMonthGrid').jqxGrid('showcolumn', 'totalOrders1');
             	
             	$('#delivaryMonthGrid').jqxGrid('hidecolumn', 'diffamt');
             	$('#delivaryMonthGrid').jqxGrid('showcolumn', 'diffamt1');
             	
             	
                $("#delivaryMonthGrid").jqxGrid('exportdata', 'xls', 'Monthly Sales Report');     
                
                	$('#delivaryMonthGrid').jqxGrid('showcolumn', 'totalOrders');
             		$('#delivaryMonthGrid').jqxGrid('hidecolumn', 'totalOrders1');
             		 	
             	$('#delivaryMonthGrid').jqxGrid('showcolumn', 'diffamt');
             	$('#delivaryMonthGrid').jqxGrid('hidecolumn', 'diffamt1');
             		
                
                      
            });	
	
	
	
}
	window.onload = check;

</script>
</form>
</body>
</html>