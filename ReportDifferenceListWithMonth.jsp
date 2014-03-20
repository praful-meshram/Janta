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
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="ReportDifferenceListWithMonth.jsp" />	
</jsp:include>
 --%>
 
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
 
<%@ page errorPage="ReportErrorPage.jsp?page=ReportDifferenceListWithMonth.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 <table style="width: 100%;height: auto;border: 10px;cursor: pointer;">
		<tr>
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td ><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>
 
<%
			String str1="",checkVal="";
		    str1=request.getParameter("Exp");		    
		    if(str1.equals("1")){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");		    
		    }
		    checkVal=request.getParameter("check");		    
%>

<head>
<title>Sales... </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
.boldtable, .boldtable TD, .boldtable TH
{
font-family:arial;
font-size:10pt;
}
</style>
</head>
<body>
<form name="myform" method="post">
<%
		String order_dt="",del_datetiem="";
		order_dt=request.getParameter("order_dt");
		String payment_type="";
		payment_type=request.getParameter("payment_type");
		String selMonth="",criteria="";
		selMonth=request.getParameter("selMonth");
		if(checkVal.equals("0"))	
			criteria=selMonth;
		else if(checkVal.equals("1"))
			criteria="ALL";						
		float recievedAmt=0.0f,expectedAmt=0.0f,paidAmt=0.0f,differenceAmt=0.0f;
		String query="";
		Connection conn=null;
		Statement stat=null;
		ResultSet rs=null;
		try{	
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stat=conn.createStatement();
								   
				query="select  a.order_num, a.custcode, a.order_date, a.total_items, a.total_value, "+
					"a.change_amt, a.total_value_discount, b.payment_type_desc, a.lastmodifieddate, "+
					"a.status_code,a.paid_amt,a.del_datetime from orders a, payment_type b " +
					"where a.payment_type_code=b.payment_type_code and "+
					"monthname(a.del_datetime)='"+selMonth+"' order by a.order_num ";							   
			
%> 
		
		<br><center><b>Monthly Difference Report</center> 
		<br>	&nbsp	 Type &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp: Monthly
		<br>	&nbsp	 Criteria&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:  <%=criteria%>
      
		<input type="hidden" name="order_dt" value="<%=order_dt%>">
		<input type="hidden" name="orderNo" value="">
		
	  <div id="info" style="display: none;">
<%		
		ArrayList<SalesOutputBean> listOutputBeans = new ArrayList();
		rs=stat.executeQuery(query);    
    	while(rs.next()) {
	    	recievedAmt=rs.getFloat(11);
	    	differenceAmt=(rs.getFloat(5)+rs.getFloat(6))-rs.getFloat(11);
	    	expectedAmt=rs.getFloat(5)+rs.getFloat(6);
	    	del_datetiem=rs.getString(12);	
	    	if(differenceAmt>0 || differenceAmt<0){
	    		
	    		SalesOutputBean outputBean = new SalesOutputBean();
	    		outputBean.setOrderNo("<a href=\"Javascript:passVar('"+rs.getString(1)+"');\">"+rs.getString(1)+"</a>");
	    		outputBean.setOrderNo1(rs.getString(1));
	    		outputBean.setCustomerCode(rs.getString(2));
	    		outputBean.setOrder_date(rs.getString(3));
	    		
	    		outputBean.setDeliveryDate(rs.getString(12));
	    		outputBean.setTotalItems(rs.getString(4));
	    		outputBean.setTotal_value(rs.getString(5));
	    		outputBean.setTotal_chang(rs.getString(6));
	    		
	    		outputBean.setRecievedAmount((recievedAmt+"").trim());
	    		outputBean.setExpectedAmount((expectedAmt+"").trim());
	    		outputBean.setDiscountAmt(rs.getString(7));
	    		outputBean.setPaymentType(rs.getString(8));
	    		outputBean.setStatus(rs.getString(10));
	    		outputBean.setDiffamt((differenceAmt+"").trim());
	    		listOutputBeans.add(outputBean);
	    		
			}
	    }	    
		rs.close();	
        stat.close();
		conn.close();
		
		
		JsonOutputBean jsonOutputBean = new JsonOutputBean();
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Number","orderNo"));
		
		jqxgridFormat format = new jqxgridFormat("Order Number","orderNo1");
		format.setHidden(true);
		jsonOutputBean.getFormat().add(format);
	
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Customer Code","customerCode"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Order Date","order_date"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Delivary Date","deliveryDate"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Items","totalItems"));
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Total Value","total_value"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Change","total_chang"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Receive Amount","recievedAmount"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Expected Amount","expectedAmount"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Discount Amount","discountAmt"));
		
		jsonOutputBean.getFormat().add(new jqxgridFormat("Paymnt Type","paymentType"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Status","status"));
		jsonOutputBean.getFormat().add(new jqxgridFormat("Difference","diffamt"));
		
		System.out.println(new Gson().toJson(jsonOutputBean));
		out.println(new Gson().toJson(jsonOutputBean));
		
		
		
%>
</div>
<div id="infoGrid"></div>

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




<script>
function passVar(code){
    	document.myform.orderNo.value=code;
		document.myform.action="print_order.jsp?&backPage=Reports.jsp&buttonFlag=Y";
	    document.myform.submit();
}
function Pass(){
		document.myform.action="ReportOrderListWithDate.jsp?Exp=1";
	    document.myform.submit();
}
function check(){	
	var jExp=<%=str1%>			
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}
	//alert($('#info').html())
	var gsonObject = jQuery.parseJSON($('#info').html());
		//alert(gsonObject.grandTotalValues);
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
         	$("#infoGrid").jqxGrid(
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
             	
             	$('#infoGrid').jqxGrid('hidecolumn', 'orderNo');
             	$('#infoGrid').jqxGrid('showcolumn', 'orderNo1');
                
                $("#infoGrid").jqxGrid('exportdata', 'xls', 'Monthly Sales Report');     
                
                $('#infoGrid').jqxGrid('showcolumn', 'orderNo');
             	$('#infoGrid').jqxGrid('hidecolumn', 'orderNo1');
                
                      
            });	
}
	window.onload = check;


</script>

</form>
</body>
</html>	

