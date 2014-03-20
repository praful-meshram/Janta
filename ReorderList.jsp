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
<%@ page errorPage="ReportErrorPage.jsp?page=ReorderList.jsp" %>	
	


<jsp:include page="leftsidemenu.jsp" />
<script src="js/ReorderList.js"></script>
<td width="50%" valign="top" style="font-family: arial;">
<form name="myform">	
	<!-- <img src="images/save_to excell.jpg"  title="Save to excell" 
	style="height: 40px; width: 35px; float: right; margin-right: 2%; cursor: pointer;"  onclick="saveToExcell();"/> -->
	
	<img src="images/Background/Excel-icon (2).png"  title="Save to excell" 
	style="height: 40px; width: 35px; float: right; margin-right: 2%; cursor: pointer;"  id="saveToExcel"/>
	
	<img src="images/Background/printer-icon.png"  title="Print report"
	style="height: 40px; width: 35px; float: right; margin-right: 2%; cursor: pointer;" onclick="printPage();"/>
	
	<img src="images/roload.jpg"  title="Refresh List" 
	style="height: 36px; width: 30px; float: right; margin-right: 2%; cursor: pointer;" onclick="getdata1();"/>
	<table style="width: 80%;">
		<tr>
			<td style="width: 30%;" align="left">
				<font size="4">Reorder Item List</font> 
			</td>
			<td style="width: 15%;">
			</td>
			<td align="right" style="width: 10%;">
				Select Site :
			</td>
			<td id="site_td" align="left" style="width: 18%;">
			</td>
			<td>
			</td>
		</tr>
	</table>
</form>	
<form name="excell" method="post" action="ReorderListToExcell.jsp">
<input type="hidden" name="data"/>
</form>
	<div id="reorder_list" style="width: 98%; height: 400px; margin-top: 20px;">
	</div>
</td>
</tr>
</table>
</body>
</html>
