<%@page import="item.ManageItem"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
     <script type="text/javascript" src="js/jqwidgets/jqxgrid.aggregates.js"></script>  
<%@ page errorPage="ReportErrorPage.jsp?page=StockStatusReportForm.jsp" %>	
	


<jsp:include page="leftsidemenu.jsp" />
<script src="js/StockStatusReport.js"></script>
<td width="50%" valign="top" style="font-family: arial;">
<form name="myform">	
	<!-- <img src="images/save_to excell.jpg"  title="Save to excell" 
	style="height: 40px; width: 35px; float: right; margin-right: 2%; cursor: pointer;"  onclick="saveToExcell();"/> 
	
	<img src="images/Background/Excel-icon (2).png"  title="Save to excell" 
	style="height: 40px; width: 35px; float: right; margin-right: 2%; cursor: pointer;"  id="saveToExcel"/>
	
	<img src="images/Background/printer-icon.png"  title="Print report"
	style="height: 40px; width: 35px; float: right; margin-right: 2%; cursor: pointer;" onclick="printPage();"/>
	
	<img src="images/roload.jpg"  title="Refresh List" 
	style="height: 36px; width: 30px; float: right; margin-right: 2%; cursor: pointer;" onclick="getdata1();"/>-->
	
	<table style="width: 80%;">
		<tr><td style="font-weight: bold;">Search Item Name &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; :&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
		<input type="text" size="50" id="searchItemName" onkeyup="getSuggestedItem();"></td><td><button onclick="getItemDetails();return false;"> Get Stock </button></td></tr>
		
		<tr>
			<td colspan="2" style="height: auto;display: none;" id="suggestedRow">
				<div id="suggesetedGrid" style=""></div>
				<!-- <button onclick="getItemDetails();return false;">Search Item Stock</button> -->
			</td>
		</tr>
		
		<!-- <tr>
			<td style="width: ">
			</td>
			<td align="right" style="width: 10%;">
				<b>Select Item :</b>
			</td>
			<td id="item_list_td" align="left" style="width: 18%;">
			</td>
			<td>
			</td>
		</tr> -->
	</table>
</form>	
<form name="excell" method="post" action="ReorderListToExcell.jsp">
<input type="hidden" name="data"/>
</form>
	
	<table id='imageGrid' style="width: 100%;height: auto;border: 10px;cursor: pointer;display: none;">
		<tr>
			<td style="width: 97%;"></td>
			<td></td>
			<td ><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td>
		</tr>
		<tr></tr>
	</table>
	<div id="item_list_details" style="width: 98%; height: 400px; margin-top: 20px;">
	</div>
</td>
</tr>
<tr><td colspan="2"><div id='popUp'></div></td></tr>
</table>
</body>
</html>
