<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <title>Retail Management-Janta Stores</title>
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
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.columnsresize.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.grouping.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxdata.export.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.export.js"></script>
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.aggregates.js"></script>
     
 <script type="text/javascript" src="js/StockMovementReportForm.js"></script>
 <link href="css/StockMovementReportForm.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<table style="width: 100%;height: auto;border: 10px;">
		<tr style="cursor: pointer;">
			<td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign('Reports.jsp');" style="float:right;"></td>
			<td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');" style="float:right;"></td>
			<td></td>
		</tr>
		<tr></tr>
	</table>
<center><h3>Stock Movement Report</h3></center>
<table>
	<tr style="font-weight: bold;">
		<td>Item Name&nbsp;:&nbsp;<input type="text" size="50" id='searchItemName'></td>
		<td><font style="color: blue;">F</font>rom Date</td>
		<td><div id="range1"></div></td>
		<td><font style="color: blue;">T</font>o Date</td>
		<td><div id="range2"></div></td>
		<td><button onclick="getSuggestedItem();" >Search Item</button></td>
		
	</tr>
</table><br/>
<ul style="width: 100%;">
	<li class="list" id='list1'><b>Item Name :&nbsp;</b>null</li>
	<li class="list" id='list2'><b>Item Weight :&nbsp;</b>null</li>
	<li class="list" id='list3'><b>Total Quantity :&nbsp;</b>null</li>
</ul>
<div class="outer"><center><b>Purchase</b><img alt="Save To Excel" class="excel" src="images/Background/Excel-icon (2).png" id="purchaseToExcel"/></center>
<div class="result" id="purchase"></div></div>
<div class="outer"><center><b>Transfer</b><img alt="Save To Excel" class="excel" src="images/Background/Excel-icon (2).png"  id="transferToExcel" /></center>
<div class="result" id='transfer'></div></div>
<div class="outer"><center><b>Sales</b><img alt="Save To Excel" class="excel" src="images/Background/Excel-icon (2).png"  id="salesToExcel" /></center>
<div class="result" id='sales'></div></div>
<div class="outer"><center><b>Current Stock</b><img alt="Save To Excel" class="excel" src="images/Background/Excel-icon (2).png"  id="stockToExcel" /></center><div class="result" id='stock'></div></div>

<div id ="sales_info" style="width: 100%;height: 100%;"></div>

<div id="popupContact" style="height: auto;width: 730px;" >
	<a id="popupContactClose"><img src="images/Background/Button-Close-icon.png"></a>
	<div id = "stack_info">
	</div>	
</div>
<div id="backgroundPopup" style="background-color: transparent;"></div>	
</body>
</html>