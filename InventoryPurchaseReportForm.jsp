<%@page contentType="text/html"%>
<%@ page import="java.text.*,payment.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
	<jsp:include page="header.jsp" />

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
	<script type="text/javascript" src="js/jqwidgets/jqxgrid.grouping.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.columnsresize.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxdata.export.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.export.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.aggregates.js"></script>	
    <script type="text/javascript" src="js/jqwidgets/jqxinput.js"></script>
    <link rel="stylesheet" href="js/jqwidgets/styles/jqx.darkblue.css" type="text/css" />
    
    <link rel="stylesheet" href="css/themes/base/jquery.ui.all.css">
	<script src="js/ui/jquery.ui.core.js"></script>
	<script src="js/ui/jquery.ui.widget.js"></script>
	<script src="js/ui/jquery.ui.datepicker.js"></script>
	<link rel="stylesheet" href="css/demos.css">
    
    <script language="javascript" src="js/InventoryPurchaseReport.js"></script>
<%@ page errorPage="ReportErrorPage.jsp?page=InventoryPurchaseReportForm.jsp" %>
	

	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<jsp:include page="leftsidemenu.jsp" />
<center>
	<div><fieldset>
<td width="50%" valign="top" style="font-family: arial;">
	
<table style="width: 100%;" align="center">
		<tr>
			<table style="width: 100%;">
		<tr>
			<td style="width: 25%; border: 1px solid black;" valign="top" align="center">
				<!-- <h4>Sell Item</h4> -->
				<center>
				<div style="width: 100%;">
				<h2 style="float: center;">Inventory Purchase Report</h2>
					<table style="" cellpadding=2 align="center">
						
				<!-- 	<tr>
						<td colspan="4" style="text-align: center;"> <b>OR</b> </td>
					</tr> -->
					<tr>
						<td><b>From :</b></td><td><input type="text" class="datepicker" id="range1" name="dateRange1" ></td>
						<td><b>To :</b></td><td><input type="text" class="datepicker" id="range2" name="dateRange2" ></td>
						
					</tr>
					<tr></tr>
					<tr>
						<td><b>Venodor&nbsp;&nbsp;&nbsp;:</b></td>
						<td colspan="1" style="vertical-align: bottom;">
						<div id="venodorList"></div>
						</td>
					</tr>
					<tr><td style="padding-top: 10px;"align="right" colspan="2">
							<input type="button" accesskey="s" onclick="getPurchaseDetails();" value="Search<Alt+s>"/>
						</td>
						<td style="padding-top: 10px;"align="left" colspan="2">
							<input type="button" accesskey="r" onclick="window.location.reload();" value="Refresh<Alt+r>"/>
						</td></tr>
				</table>
				</div>
				</center>
		</tr>
				
</table>	

<div id ="inventoryPurchase" style=""></div>

</body>
</html>




