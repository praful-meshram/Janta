<jsp:include page="header.jsp"></jsp:include>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.JasonObject"%>
<%@page import="beans.SalesReportOutputBean"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>

<head>
<title>Sales... </title>

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
    

<%@ page errorPage="ReportErrorPage.jsp?page=RsalesDetails.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<%
			String str1="";
		    str1=request.getParameter("Exp");		    
		    if(str1.equals("1")){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");		    
		    }
%>


<style>
.boldtable, .boldtable TD, .boldtable TH
{
font-family:arial;
font-size:10pt;
}
</style>
</head>
<body><table style="width: 100%;height: auto;border: 10px;cursor: pointer;">
		<tr>
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td ><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>
	<center><h3>Sales Report</h3></center>
	Type &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp;:&nbsp; Summary<br>	
	Customer Code&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:&nbsp;  <%=request.getParameter("orderNo")%>
	
	<div id="salesReport" style="display: none;">
<%
		System.out.println("rsales details");
		String custCode="";
		custCode=request.getParameter("orderNo");
		String criteria = custCode;
		String frDate="";
		frDate=request.getParameter("frDate").replace("/", "-");
		String toDate="";
		toDate=request.getParameter("toDate").replace("/", "-");	
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
			//query="select  a.order_num, a.custcode, a.order_date, a.total_items, a.total_value, a.total_value_mrp, a.total_value_discount, b.payment_type_desc, a.lastmodifieddate, a.status_code from orders a, payment_type b where a.payment_type_code=b.payment_type_code and a.order_date between '"+frDate+"' and '"+toDate+"' and a.custcode='"+custCode+"'";
			query="select  a.order_num, a.custcode, date(a.order_date), a.total_items, a.total_value, a.total_value_mrp, a.total_value_discount, b.payment_type_desc, date(a.lastmodifieddate), a.status_code from orders a, payment_type b where a.payment_type_code=b.payment_type_code and date_format(a.order_date,'%Y-%m-%d') between ? and ? and a.custcode='"+custCode+"'";
		
		
		//rs=stat.executeQuery(query);  
		System.out.println(query);
		PreparedStatement preparedStatement = conn.prepareStatement(query);
		preparedStatement.setDate(1, Date.valueOf(frDate));
		preparedStatement.setDate(2, Date.valueOf(toDate));
		rs= preparedStatement.executeQuery();
		JsonOutputBean jsonOutputBean = new  JsonOutputBean();
		ArrayList<SalesReportOutputBean> outputBeans = new ArrayList();
    	while(rs.next()) {
    		SalesReportOutputBean outputBean = new SalesReportOutputBean();
    		outputBean.setOrderNumber(rs.getString(1));
    		outputBean.setCustomerCode(rs.getString(2));
    		outputBean.setOrderDate(rs.getString(3));
    		outputBean.setTotalItems(rs.getString(4));
    		outputBean.setTotalValue(rs.getString(5));
    		
    		outputBean.setTotalMrpValue(rs.getString(6));
    		outputBean.setTotalDiscountValue(rs.getString(7));
    		outputBean.setPaymentTypeDesc(rs.getString(8));
    		outputBean.setLastModifiedDate(rs.getString(9));
    		outputBean.setStatusCode(rs.getString(10));
    		
    		outputBeans.add(outputBean); 
	}	    
    	jsonOutputBean.setOutputData(outputBeans);
    	
    	jsonOutputBean.getFormat().add(new jqxgridFormat("Order Number","orderNumber"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Code","customerCode"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Date","orderDate"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Items","totalItems"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Value","totalValue"));
	
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Mrp","totalMrpValue"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Disc","totalDiscountValue"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Payment Type Desc","paymentTypeDesc"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Last Modified Date","lastModifiedDate"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Status Code","statusCode"));
    
		rs.close();	
        stat.close();
		conn.close();
		
		System.out.println(new Gson().toJson(jsonOutputBean));
		out.println(new Gson().toJson(jsonOutputBean));
	}
	catch (Exception e) {
		e.getMessage();
		e.printStackTrace();
		System.out.println(e);
	}
%>   
</div>

<div id="salesReportGrid"></div>
</body>

<script>

	window.onload = function(){
		
			var gsonObject = jQuery.parseJSON($('#salesReport').html());
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
         	$("#salesReportGrid").jqxGrid(
            {	
            	theme:'darkblue',
                height: 350,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                //showaggregates: true,
                selectionmode: 'singlecell',
               columns:gsonObject.format
                
            });	
			
		
		
		
  		        
             $("#saveToExcel").click(function () {
                $("#salesSummery").jqxGrid('exportdata', 'xls', 'Sales Details');           
            });
            
           
	        //UNBINDING DATA
			$("#salesReportGrid").unbind('cellselect');
			$("#salesReportGrid").unbind('rowselect');
		
			$("#salesReportGrid").bind('cellselect', function (event) {
			
			var row = $("#salesReportGrid").jqxGrid('getrowdata', event.args.rowindex);
			var columnheader = $("#salesReportGrid").jqxGrid('getcolumn', event.args.datafield).text;
		
			//alert(event.args.datafield+" "+columnheader +" "+row.customerCode);
				
				if(event.args.datafield=='orderNumber')
				{
					alert(row.orderNumber);
					//passVar(row.orderNumber);
				} 	
				
			}); 
				
			$("#salesReportGrid").jqxGrid('clearselection');
    	
	}

</script>

</html>	

