<%@page contentType="text/html"%>
<%@ page import="java.text.*,payment.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<jsp:include page="header.jsp" />
<jsp:include page="leftsidemenu.jsp" />
<link rel="stylesheet" type="text/css" href="css/singleItemStock.css" />
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

<script src="js/singleItemStock.js" type="text/javascript"></script>
<script language="javascript" src="js/NewPackagingReportForm.js"></script>

<%@ page errorPage="ReportErrorPage.jsp?page=NewPackagingReport.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>


<td width="50%" valign="top" style="font-family: arial;">
	<h2 style="float: left;">Date Wise Packaging Report</h2>
	<table style="width: 100%;">
		<tr>
			<td style="width: 25%; border: 1px solid black;" valign="top" align="center">
				<h4>Breakdown Item</h4>
				<table style="width: 100%;">
					<tr>
						<td align=left><b><font color="blue">F</font>rom Date</b></td><td align=left>
						<div id="range1"></div> <INPUT type="hidden" name="frDate" size=11 id="frDate" readonly="readonly"> 
						
						</TD>
						
					</tr>
					<tr>
						<td align=left><b><font color="blue">T</font>o Date</b></td><td align=left>
						<div id="range2"></div>
						<INPUT type="hidden" name="toDate" size=11 id="toDate" readonly="readonly" > 
						<td>
													
					</tr>
					
					<tr>
						<td colspan="3" style="padding-top: 10px;">
							<input type="button" accesskey="r" onclick="window.location.reload();" value="Refresh<Alt+r>"/>
							<input type="button" accesskey="s" onclick="getBreakDownList();" value="Search<Alt+s>"/>
						</td>
					</tr>
				</table>
			</td>
			<td  valign="top" style=" width: 70%;" align="center">
				<div style="width: 100%;height: 10%;" id="firstDIV"></div>
				<div id = "item_list_td" style="width: 100%;height:95%;"></div>
				
			</td>
		</tr>
	</table>  
</td>
</tr>
</table>		
<div id="popupContact">
	<b style="font-size: 16px;">Breakdown Details </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id="popupContactClose">x</a>
	<span id='rowDetails' style="text-align: left;"></span>
	<div id = "breakdown_info">
	</div>	
</div>
<div id="backgroundPopup"></div>

<script>
	window.onload =function Clear(){
	 var flag=true;
	 	
		$("#range1").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',max:new Date(),formatString: "yyyy-MM-dd"});
		$("#range2").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: "yyyy-MM-dd",value:new Date()});
		//$("#range1").jqxDateTimeInput({readonly:true});
		
		$('#range1').on('close', function (event) {
		 // Some code here. 
		 	$("#range2").jqxDateTimeInput({disabled: false});
		 	$("#range2").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});
 		}); 	
		
		document.getElementById("frDate").value =  $('#range1').jqxDateTimeInput('getText');
		document.getElementById("toDate").value = $('#range2').jqxDateTimeInput('getText');
		
		$("#popupContactClose").click(function() {
			disablePopup();
		});
		
		$("#backgroundPopup").click(function() {
			disablePopup();
		});
		
		$(document).keypress(function(e) {
			if (e.keyCode == 27 && popupStatus == 1) {
				disablePopup();
			}
		});
		
		return false;
	    
	  	};
	
</script>

</body>
</html>




