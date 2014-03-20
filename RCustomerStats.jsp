<jsp:include page="header.jsp"></jsp:include>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.CustomerStatOutputBean"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>




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
    <script type="text/javascript" src="js/jqwidgets/jqxdata.export.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.export.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.aggregates.js"></script>  

 <%@ page errorPage="ReportErrorPage.jsp?page=RCustomerStats.jsp" %>
 
 <table style="width: 100%;height: auto;border: 10px;cursor: pointer;">
		<tr>
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
		
		String frDate="",toDate="";
		String hchckall="", hcondition="";
		String custName="",custCode="",area="";
		String status="";
		String criteria ="";
		String type="";
		
		frDate = request.getParameter("frDate");		
		toDate = request.getParameter("toDate");		
		hchckall = request.getParameter("hchckall"); 		
		 
		System.out.println("===> "+frDate+","+toDate+",");
		
		customer.ManageCustomer c;
		//c = new customer.ManageCustomer("jdbc/js");
		c = new customer.ManageCustomer("jdbc/re");	
%> 
		  			<input type="hidden" name="frDate" value="<%=frDate%>">
		      		<input type="hidden" name="toDate" value="<%=toDate%>">
		      		<input type="hidden" name="orderNo" value="">
		      		<input type="hidden" name="hchckall" value="<%=hchckall%>">
		      		
		      		
		      		
      			
<%
			if(hchckall.equals("1")){		
					c.CustomerStatsDetail("ALL",frDate,toDate,"","",""); 
								criteria = "All";
			}
			else{
			   custCode = request.getParameter("custCode");
			   custName = request.getParameter("custName");
			   area = request.getParameter("area");
			   criteria = custCode+"-"+custName+"-"+area;
			   c.CustomerStatsDetail("NOTALL",frDate,toDate,custCode,custName,area); 
%>
				<input type="hidden" name="custCode" value="<%=custCode%>">
	      		<input type="hidden" name="custName" value="<%=custName%>">
	      		<input type="hidden" name="area" value="<%=area%>">
<%
			}		  
%>			<br><center><b> Customer Statistics Report</center> 
		       <br>	&nbsp	 Type &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp: <%=type%>
		       <br>	&nbsp	 Criteria&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:  <%=criteria%>
		<div id="custStat" style="display: none">	
			
<%    		
			String name1="",area1="";				
			String last_order_date="";
			
			int last_order_num=0;
			int tot_orders_3=0;
			int tot_orders_6=0;
			int tot_orders_12=0;
			int avg_items_3=0;
			int avg_items_6=0;
			int avg_items_12=0;
			
			float fmcg_per_3=0.0f;
			float fmcg_per_6=0.0f;
			float fmcg_per_12=0.0f;
			float tot_savings_3=0.0f;
			float tot_savings_6=0.0f;
			float tot_savings_12=0.0f;
			float tot_value_3=0.0f;
			float tot_value_6=0.0f;
			float tot_value_12=0.0f;
		
			ArrayList<CustomerStatOutputBean> listOutputBeans = new ArrayList();
			while(c.rs.next()){
				int i=1;
				custCode=c.rs.getString(i++);  
				name1	=c.rs.getString(i++);			
				area1	=c.rs.getString(i++);
				last_order_date=c.rs.getString(i++);
				
				fmcg_per_3=c.rs.getFloat(i++);
				fmcg_per_6=c.rs.getFloat(i++);
				fmcg_per_12=c.rs.getFloat(i++);
				
				tot_orders_3=c.rs.getInt(i++);
				tot_orders_6=c.rs.getInt(i++);
				tot_orders_12=c.rs.getInt(i++);
				
				tot_savings_3=c.rs.getFloat(i++);
				tot_savings_6=c.rs.getFloat(i++);
				tot_savings_12=c.rs.getFloat(i++);
				
				tot_value_3=c.rs.getFloat(i++);
				tot_value_6=c.rs.getFloat(i++);
				tot_value_12=c.rs.getFloat(i++);
				
				avg_items_3=c.rs.getInt(i++);
				avg_items_6=c.rs.getInt(i++);
				avg_items_12=c.rs.getInt(i++);
				
				CustomerStatOutputBean outputBean = new CustomerStatOutputBean();
				outputBean.setCustCode(custCode);
				outputBean.setName1(name1);
				outputBean.setArea1(area1);
				outputBean.setLast_order_date(last_order_date);
				
				outputBean.setFmcg_per_3(fmcg_per_3);
				outputBean.setFmcg_per_6(fmcg_per_6);
				outputBean.setFmcg_per_12(fmcg_per_12);
				
				outputBean.setTot_orders_3(tot_orders_3);
				outputBean.setTot_orders_6(tot_orders_6);
				outputBean.setTot_orders_12(tot_orders_12);
				
				outputBean.setTot_savings_3(tot_savings_3);
				outputBean.setTot_savings_6(tot_savings_6);
				outputBean.setTot_savings_12(tot_savings_12);
				
				outputBean.setTot_value_3(tot_value_3);
				outputBean.setTot_value_6(tot_value_6);
				outputBean.setTot_value_12(tot_value_12);
				
				outputBean.setAvg_items_3(avg_items_3);
				outputBean.setAvg_items_6(avg_items_6);
				outputBean.setAvg_items_12(avg_items_12);
		
				listOutputBeans.add(outputBean);

		}
	JsonOutputBean jsonOutputBean = new JsonOutputBean();
	jsonOutputBean.setOutputData(listOutputBeans);
	
	jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Code","custCode","150px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Name","name1","170px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Area","area1","170px"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Last Order Date","last_order_date","170px"));
	
	jqxgridFormat format = new jqxgridFormat("3M","tot_orders_3","80px");
	format.setColumngroup("TotalOrders");
	jsonOutputBean.getFormat().add(format);
	
	format = new jqxgridFormat("6M","tot_orders_6","80px");
	format.setColumngroup("TotalOrders");
	jsonOutputBean.getFormat().add(format);
	
	format = new jqxgridFormat("12M","tot_orders_12","80px");
	format.setColumngroup("TotalOrders");
	jsonOutputBean.getFormat().add(format);
	
	
	format = new jqxgridFormat("3M","fmcg_per_3","80px");
	format.setColumngroup("FmcgItems");
	jsonOutputBean.getFormat().add(format);
	
	format = new jqxgridFormat("6M","fmcg_per_6","80px");
	format.setColumngroup("FmcgItems");
	jsonOutputBean.getFormat().add(format);
	
	format = new jqxgridFormat("12M","fmcg_per_12","80px");
	format.setColumngroup("FmcgItems");
	jsonOutputBean.getFormat().add(format);

	

	format = new jqxgridFormat("3M","tot_savings_3","80px");
	format.setColumngroup("TotalValues");
	jsonOutputBean.getFormat().add(format);
	
	format = new jqxgridFormat("6M","tot_savings_6","80px");
	format.setColumngroup("TotalValues");
	jsonOutputBean.getFormat().add(format);
	
	format = new jqxgridFormat("12M","tot_savings_12","80px");
	format.setColumngroup("TotalValues");
	jsonOutputBean.getFormat().add(format);


	

	format = new jqxgridFormat("3M","avg_items_3","80px");
	format.setColumngroup("AVGItems");
	jsonOutputBean.getFormat().add(format);
	
	format = new jqxgridFormat("6M","avg_items_6","80px");
	format.setColumngroup("AVGItems");
	jsonOutputBean.getFormat().add(format);
	
	format = new jqxgridFormat("12M","avg_items_12","80px");
	format.setColumngroup("AVGItems");
	jsonOutputBean.getFormat().add(format);
	
	System.out.print(new Gson().toJson(jsonOutputBean));
	out.print(new Gson().toJson(jsonOutputBean));
		
%>
</div>
<div id="custStatGrid"></div>

<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>
</table>
<!-- <div id="div4" style="VISIBILITY:visible"><table><tr><td><a href="Javascript:Pass();">Save to excel</a></td></tr></table></div> -->

<script>
function passVar(code){
	
		document.myform.orderNo.value=code;
		document.myform.action="print_order.jsp??&backPage=RcustSalesForm.jsp&buttonFlag=Y";
	    document.myform.submit();
	
}
	function Pass(){
		document.myform.action="RCustomerStats.jsp?Exp=1";
	    document.myform.submit();
	}

function check(){	
	var jExp=<%=str1%>			
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}
	
	
	var gsonObject = jQuery.parseJSON($('#custStat').html());
		
		//alert(gsonObject);
		//alert(gsonObject.OutputData);
		//alert(gsonObject.format);
		
		 var source =
            {
                localdata:gsonObject.OutputData,
                datatype: "array"
                
            };
			$("#custStatGrid").jqxGrid(
            {	
            	theme:'darkblue',
	            height: 340,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                //showaggregates: true,
                //showstatusbar: true,
                //selectionmode: 'singlecell',
                columns: gsonObject.format,
                columngroups: 
                [
                  { text: 'Total Orders', align: 'center', name: 'TotalOrders' },
                  { text: 'Fmcg items(%)', align: 'center', name: 'FmcgItems' },
                  { text: 'Total Values', align: 'center', name: 'TotalValues' },
                  { text: 'AVG Items', align: 'center', name: 'AVGItems' }
                ]
            });	
	
		$("#saveToExcel").click(function () {
         
               $("#custStatGrid").jqxGrid('exportdata', 'xls', 'Commission Order Report');     // not work for huge data
         
         });	
	
	
	
}

	window.onload = check;


</script>

</form></body>
</html>