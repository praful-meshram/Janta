<%@page import="com.google.gson.Gson"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.CustomerPaymentHistoryOutputBean"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 

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
	 <script type="text/javascript" src="js/jqwidgets/jqxgrid.columnsresize.js"></script> 
	 
	 <%@ page errorPage="ReportErrorPage.jsp?page=editCustPaymentHistory.jsp" %>

<style>
hr {
color: #f00;
background-color: #f00;
height: 3px;
}

	/* makes tableContainer Class of DIV */
	DIV.tableContainer   
	{
	   clear: both;
	   overflow: auto;
	   
	   /* Sets the BORDER properties */
	   border: #963 1px solid;
	   
	   /* Sets Width and Height of the container */
	   width: 1000px;
	   height: 240px;
	}  
	DIV.tableContainer TABLE{
	   float: left;
	}	
	/* fixedHeader is the class of THEAD and TR is the property */
	THEAD.fixedHeader TR{
  	 position: relative
	}
	/* Sets the attribute for TH property. Watch out for the TH here. It is used instead of TD. */
	THEAD.fixedHeader TH
	{
	   border-left: #eb8 1px light;
	   border-right: #b74 1px light;
	   border-top: #eb8 1px light;
	   padding-left: 3px;
	   padding-right: 3px;
	   padding-top: 4px;
	   padding-bottom: 4px;*/
	   font-weight: bold;
	   /* Change the color code here to change the fixed header's background color  */
	   background: #c96;
	   /* #fff is the color code for the fixed header's font */
	   color: #fff;
	   /* you can use 'justify', 'left', 'right' or 'center' here */
	   text-align: center
	}
	
	TBODY.scrollContent TD
	{
	   border-left-style: none;
	   border-right: #ccc 1px solid;
	   border-top: #ddd 1px solid;
	   border-bottom: #ddd 1px solid;*/
	   padding-left: 4px;
	   padding-right: 3px;
	   padding-top: 2px;
	   padding-bottom: 3px;
	   background: #fff;
	   text-align: center
	}
	
  </style>

<% 
	String CustCode=request.getParameter("cuscode");
	String CustName=request.getParameter("name");
%>
<script>
function saveToexcel(){
   	//document.myform.target="_blank";
	document.myform.action="editCustPaymentHistoryExcel.jsp";
	document.myform.submit();
}
</script>

<table style="width: 100%;height: auto;border: 10px;cursor: pointer;">
		<tr>
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td ><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>

<form name="myform" method="post">

<br>
<table align="center" border=1 style="border-collapse: collapse;">
 <tr>
  <td><b>Customer Name :</b></td>
  <td><%= CustName %></td>
 </tr>
 <tr>
  <td><b>Customer Code : </b></td>
  <td><%= CustCode %></td>
 </tr>
</table>
<br>
<center>
<div class=tableContainer align="center" style="display: none;">
   
<% 
	
	String order_num="", order_date="", del_datetime="", closed_datetime="";
	String remark="",close_status="";
	Float balance_amt=0.0f, change_amt=0.0f, paid_amt=0.0f,absValue=0.0f;
	
	customer.ManageCustomer c;
	//c = new customer.ManageCustomer("jdbc/js");
	c = new customer.ManageCustomer("jdbc/re");
	ArrayList<CustomerPaymentHistoryOutputBean> listOutputBeans = new ArrayList();
	c.CustPmtHistory(CustCode);
	while(c.rs.next()){
		order_num=c.rs.getString(1);
		order_date=c.rs.getString(2);
		//System.out.println("c.rs.getString(3) "+c.rs.getString(3));
		del_datetime=c.rs.getString(3);
		//System.out.println("c.rs.getString(4) "+c.rs.getString(4));
		closed_datetime=c.rs.getString(4);
		close_status=c.rs.getString(5);
		balance_amt=c.rs.getFloat(6);
		change_amt=c.rs.getFloat(7);
		paid_amt=c.rs.getFloat(8);
		remark=c.rs.getString(9);
		absValue=c.rs.getFloat(10);
		
		CustomerPaymentHistoryOutputBean outputBean = new CustomerPaymentHistoryOutputBean();
		outputBean.setOrderNumber(order_num);
		outputBean.setOrderDate(order_date);
		outputBean.setDelDateTime(del_datetime);
		outputBean.setClosedDateTime(closed_datetime);
		outputBean.setCloseStatus(close_status);
		outputBean.setBalanceAmount((balance_amt+"").trim());
		outputBean.setChangeAmount((change_amt+"").trim());
		outputBean.setPaidAmount((paid_amt+"").trim());
		outputBean.setRemark(remark);
		outputBean.setAbsValue((absValue+"").trim());
		listOutputBeans.add(outputBean);

	}
	JsonOutputBean jsonOutputBean = new JsonOutputBean();
	jsonOutputBean.setOutputData(listOutputBeans);
	jsonOutputBean.getFormat().add(new jqxgridFormat("Order Number ","OrderNumber"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Order Date","OrderDate"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Del Date Time","DelDateTime"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Closed Date Time","ClosedDateTime"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Closed Status","CloseStatus"));
	
	jsonOutputBean.getFormat().add(new jqxgridFormat("Balance Amount","BalanceAmount"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Change Amount","ChangeAmount"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Paid Amount","PaidAmount"));
	jsonOutputBean.getFormat().add(new jqxgridFormat("Remark","Remark"));
	
	System.out.println(new Gson().toJson(jsonOutputBean));
	out.println(new Gson().toJson(jsonOutputBean));
%>
   
  </div>
  <div id ="tableGrid"></div>
  
 <br>
 <table>
  <tr>
<!--    <td><input type="button" name="saveExcel" value=" Save To Excel " onclick="saveToexcel();"></td> -->
  </tr>
 </table>
<input type="hidden" name="cuscode" value="<%= CustCode %>">
<input type="hidden" name="name" value="<%= CustName %>">
 </center>
</form>

<script type="text/javascript">
	$(document).ready(function(){
		
		var gsonObject = jQuery.parseJSON($('.tableContainer').html());
		
		//alert(gsonObject);
		//alert(gsonObject.OutputData);
		//alert(gsonObject.format);
		
		 var source =
            {
                localdata:gsonObject.OutputData,
                datatype: "array"
                
            };
			$("#tableGrid").jqxGrid(
            {	
            	theme:'darkblue',
	            height: 350,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                //showaggregates: true,
                //showstatusbar: true,
                //selectionmode: 'singlecell',
                 groupable: true,
                columns:gsonObject.format 
            });	
	
		$("#saveToExcel").click(function () {
               $("#tableGrid").jqxGrid('exportdata', 'xls', 'Commision Details');     
                
         });		
	
	})
</script>