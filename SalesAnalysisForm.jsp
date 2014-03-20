<%@page contentType="text/html"%>
<%@ page import="java.text.*,payment.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
	<jsp:include page="header.jsp" />

<!--  <script src="js/singleItemStock.js" type="text/javascript"></script> -->
<script language="javascript" src="js/SalesAnalysisForm.js"></script>
<link rel="stylesheet" type="text/css" href="css/singleItemStock.css" />

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
<%@ page errorPage="ReportErrorPage.jsp?page=SalesAnalysisForm.jsp" %>
	

	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<jsp:include page="leftsidemenu.jsp" />

<!-- <link rel="stylesheet" type="text/css" href="css/singleItemStock.css" /> -->
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
				<h2 style="float: center;">Sales Analysis Report</h2>
					<table style="" cellpadding=2 align="center">
					<tr><td colspan="4" style="vertical-align: bottom;text-align: center;"><input type="text" id="orderNum" onkeydown="enterNumber(event);"/></td></tr>	
					<tr>
						<td colspan="4" style="text-align: center;"> <b>OR</b> </td>
					</tr>
					<tr>
						<td><b>From :</b></td><td><div id="range1" name="dateRange1"></div></td>
						<td><b>To :</b></td><td><div id="range2" name="dateRange2"></div></td>
						
					</tr>
					<tr><td style="padding-top: 10px;"align="right" colspan="2">
							<input type="button" accesskey="s" onclick="getSalesAnalysis();" value="Search<Alt+s>"/>
						</td>
						<td style="padding-top: 10px;"align="left" colspan="2">
							<input type="button" accesskey="r" onclick="window.location.reload();" value="Refresh<Alt+r>"/>
						</td></tr>
				</table>
				</div>
				</center>
		</tr>
				
</table>	

<table style="width: 100%;height: auto;border: 10px;cursor: pointer;display: none;" id="excell">
		<tr>
			<td style="width: 97%;"></td>
			<td></td>
			<td><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;" /></td>
		</tr>
		<tr></tr>
	</table>

<div id ="sales_info" style="width: 100%;height: 100%;"></div>

<div id="popupContact" style="height: 450px;width: 730px;overflow: auto; " >
	<a id="popupContactClose"><img src="images/Background/Button-Close-icon.png"></a>
	<div id ="stack_info">
	</div>	
</div>
<div id="backgroundPopup" style="background-color: transparent;"></div>	
	
<!-- <div id="salesReport">
	<b>Sales Analysis Report</b>
	<br/><br/>
	<div id = "sales_info">
	</div>	
</div>
<div id="backgroundPopup"></div> -->


</body>
</html>




