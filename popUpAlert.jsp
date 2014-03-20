<%@page contentType="text/html"%>
<%@ page import="java.text.*,payment.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<jsp:include page="header.jsp" />
<jsp:include page="leftsidemenu.jsp" />
<script src="js/jquery-1.2.6.min.js" type="text/javascript"></script>
<script src="js/singleItemStock.js" type="text/javascript"></script>
<script language="javascript" src="js/codethatcalendarstd.js"></script>
<script language="javascript" src="js/popUpAlert.js"></script>

<%-- <jsp:forward page="popUpAlert1.jsp"/> --%>
<link rel="stylesheet" type="text/css" href="css/singleItemStock.css" />

<td width="50%" valign="top" style="font-family: arial;">
	<h2 style="float: left;">Date wise Packaging Report</h2>
	<table style="width: 100%;">
		<tr>
			<td style="width: 25%; border: 1px solid black;" valign="top" align="center">
				<h4>Breakdown Item</h4>
				<table style="width: 100%;">
					<tr>
						<td align=left><b><font color="blue">F</font>rom Date</b></td><td align=left><INPUT name="frDate" size=11 id="frDate" readonly="readonly"> <input type="button" accesskey="f" onClick="c1.popup('frDate');" value="......"/> </TD>
						
					</tr>
					<tr>
						<td align=left><b><font color="blue">T</font>o Date</b></td><td align=left><INPUT name="toDate" size=11 id="toDate" readonly="readonly" >  <input type="button" onClick="c1.popup('toDate');" value="......"/>
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
			<td id = "item_list_td" valign="top" style=" width: 70%;" align="center">
			</td>
		</tr>
	</table>  
</td>
</tr>
</table>		
<div id="popupContact">
	<b>Breakdown Information </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Print" style="width:100" onclick="printPage('content');"/><a id="popupContactClose">x</a>
	<br/><br/>
	<div id = "breakdown_info">
	</div>	
</div>
<div id="backgroundPopup"></div>

<script>
	window.onload =getBreakdownDetails(10);
	
</script>

</body>
</html>




