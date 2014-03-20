<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.SalesOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>



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
    

<%@ page errorPage="ReportErrorPage.jsp?page=ReportOrderListWithMonth.jsp" %>

<table style="width: 100%;height: auto;border: 10px;">
		<tr style="cursor: pointer;">
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>



<%
			String str1="",pageName1="";
		    str1=request.getParameter("Exp");	
	        pageName1=request.getParameter("pageName");	    
		    if(str1.equals("1")){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");		    
		    }
%>


<form name="myform" method="post">
<%
		String selMonth="";
		selMonth=request.getParameter("selMonth");
		//String year = request.getParameter("year");
		String criteria =selMonth;
		String query="";
		Connection conn=null;
		Statement stat=null;
		ResultSet rs=null;
		try{	
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			//DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			DataSource ds = (DataSource)envContext.lookup("jdbc/re");
			conn = ds.getConnection();
			stat=conn.createStatement();
			if(pageName1.equals("Rcollection")){			
				query="select  a.order_num, a.custcode, a.order_date, a.total_items, a.total_value, "+
					  "a.total_value_mrp, a.total_value_discount, b.payment_type_desc, "+
					  "a.lastmodifieddate, a.status_code from orders a, payment_type b "+
					  "where a.payment_type_code=b.payment_type_code and monthname(a.order_date)='"+selMonth+"' order by a.order_num ";
			}
			else if(pageName1.equals("RDelivery")){
				query="select  a.order_num, a.custcode, a.order_date, a.total_items, a.total_value, "+
					  "a.total_value_mrp, a.total_value_discount, b.payment_type_desc, "+
					  "a.lastmodifieddate, a.status_code from orders a, payment_type b "+
					  "where a.payment_type_code=b.payment_type_code and status_code='DELIVERED'"+
					  "and monthname(a.del_datetime)='"+selMonth+"' order by a.order_num ";
			}			
			
%> 
		
		<br><center><b>Orders Report</center> 
		<br>	&nbsp	 Type &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp: Details
		<br>	&nbsp	 Criteria&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:  <%=criteria%>
      
		<input type="hidden" name="selMonth" value="<%=selMonth%>">
		<input type="hidden" name="orderNo" value="">
	 <div id="orderReport" style="display: none;">
<%
		ArrayList<SalesOutputBean> listOutputBeans = new ArrayList();
		JsonOutputBean jsonOutputBean = new JsonOutputBean(); 
		System.out.println("month "+query); 
		rs=stat.executeQuery(query);   
    	while(rs.next()) {
    		
    		//System.out.println("data available in month ");
    		
    		SalesOutputBean outputBean = new SalesOutputBean();
    		outputBean.setOrderNo(rs.getString(1));
    		outputBean.setOrderNo1("<a href=\"Javascript:passVar('"+rs.getString(1)+"');\">"+rs.getString(1)+"</a>");
    		
    		outputBean.setCustomerCode(rs.getString(2));
    		outputBean.setOrder_date(rs.getString(3));
    		outputBean.setTotalItems(rs.getString(4));
    		outputBean.setTotal_value(rs.getString(5));
    		
    		outputBean.setMrp(rs.getString(6));
    		outputBean.setDiscountAmt(rs.getString(7));
    		outputBean.setPaymentType(rs.getString(8));
    		
    		outputBean.setLastModifiedDate(rs.getString(9));
    		outputBean.setStatus(rs.getString(10));
    		listOutputBeans.add(outputBean);
    		
		}	
 
		rs.close();	
        stat.close();
		conn.close();
		
		jsonOutputBean.setOutputData(listOutputBeans);
		jqxgridFormat format = new jqxgridFormat("Order Number","orderNo","120px");
		format.setHidden(true);
		jsonOutputBean.getFormat().add(format);
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Number","orderNo","120px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Code","customerCode","150px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Date","order_date","250px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Items","totalItems","150px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Values","total_value","150px"));
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("MRP","mrp","150px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Discount","discountAmt","200px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Payment Type","paymentType","200px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Last Modified Date ","lastModifiedDate","250px"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Status","status","200px"));
		
		System.out.println(new Gson().toJson(jsonOutputBean));
		out.println(new Gson().toJson(jsonOutputBean));
			
%>
</div>
<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>

<!-- <div id="div4" style="VISIBILITY:visible"><table><tr><td><a href="Javascript:Pass();">Save to excel</a></td></tr></table></div> -->

<%
	}
	catch (Exception e) {
		e.getMessage();
		e.printStackTrace();
		System.out.println(e);
	}
%>   

<div id="orderReportGrid"></div>


<script>
function passVar(code){
    	document.myform.orderNo.value=code;
		document.myform.action="print_order.jsp?&backPage=Reports.jsp&buttonFlag=Y";
	    document.myform.submit();
}
function Pass(){
		document.myform.action="ReportOrderListWithMonth.jsp?Exp=1";
	    document.myform.submit();
}
function check(){	
	
		var jExp=<%=str1%>			
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}
	
	var gsonObject = jQuery.parseJSON($('#orderReport').html());
		//alert(gsonObject.grandTotalValues);
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
         	$("#orderReportGrid").jqxGrid(
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
                //selectionmode: 'singlerow',
                columns:gsonObject.format
                		
                
            });	
            
             $("#saveToExcel").click(function () {
             	
             	$('#orderReportGrid').jqxGrid('hidecolumn', 'orderNo1');
             	$('#orderReportGrid').jqxGrid('showcolumn', 'orderNo');
                $("#orderReportGrid").jqxGrid('exportdata', 'xls', 'Monthly Sales Report');           
            });	
	
	
}
	window.onload = check;


</script>

</form>
</body>
</html>	

