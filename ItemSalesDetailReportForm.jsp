<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="ItemSalesDetailReportForm.jsp" />	
</jsp:include> --%>

<jsp:include page="leftsidemenu.jsp" />
<script language="javascript" src="js/codethatcalendarstd.js"></script>
<script type='text/javascript' src='js/zapatec.js'></script>
<script type='text/javascript' src='js/dndmodule.js'></script>
<script type='text/javascript' src='js/list-sorting.js'></script>
<script src="js/jquery-1.2.6.min.js" type="text/javascript"></script>
<script type='text/javascript' src='js/itemSalesDetailReport.js'></script>
<script type='text/javascript' src='js/ItemSalesDetailReportForm.js'></script>
<link rel="stylesheet" type="text/css" href="css/ItemSalesDetailReportForm.css" />

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
    <script type="text/javascript" src="js/jqwidgets/jqxdata.export.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.export.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.aggregates.js"></script>  



<%@ page errorPage="ReportErrorPage.jsp?page=ItemSalesDetailReportForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<form name="myform" method="post">
<td  align="left" style="font-family: arial; width: 50%;">
<h3>Single Item Sales Report</h3>
<table style="width: 100%;">
	<tr>
		<td style="width: 25%;height: 10%;border: 1px solid black;" align="center" valign="top">
		<!-- 	<table style="width: 90%;">
				<tr>
					<td align=left style="width: 35%;"><font color="blue"><u>F</u></font>rom Date</td>
					<td align=left  style="width: 65%;"> : 
						<INPUT name="frDate" size=11 style="width: 60%;" id="from_date"> 
						<input type="button" accesskey="f" onClick="c1.popup('frDate');" value="..."/> </TD>
				</tr>
				<tr>
					<td align=left><font color="blue"><u>T</u></font>o Date</td>
					<td align=left> : 
						<INPUT name="toDate" size=11 style="width: 60%;" id="to_date">  
						<input type="button" onClick="c1.popup('toDate');" value="..."/> </TD>
				</tr>
			</table> -->
			<h4>Search Item</h4>
				<table style="width: 90%;">
					<tr>
						<td align="left" style="width: 37%;">
							Item <font color="blue"><u>N</u></font>ame
						</td>
						<td style="width: 1%;">
							:
						</td>
						<td align="left" style="width: 60%;">
							<input type="text" name="item_name" id="item_name_id" style="width: 90%;" accesskey="n"/>
						</td>
					</tr>
					<tr>
						<td align="left">
							Item <font color="blue"><u>C</u></font>ode
						</td>
						<td>
							:
						</td>
						<td align="left">
							<input type="text" name="item_code" id="item_code_id" style="width: 90%;" accesskey="c"/>
						</td>
					</tr>
					<tr>
						<td align="left" valign="top">
							Item <font color="blue"><u>G</u></font>roup
						</td>
						<td valign="top">
							:
						</td>
						<td align="left">
							<%
								Connection conn = null;
								Statement stmt = null, stat = null;
								ResultSet rs = null, rs2 = null;
								try {
									String name, desc;
									int rowcount;
									Context initContext = new InitialContext();
									Context envContext = (Context) initContext.lookup("java:/comp/env");
									//DataSource ds = (DataSource) envContext.lookup("jdbc/js");
									DataSource ds = (DataSource) envContext.lookup("jdbc/re");
									conn = ds.getConnection();
									stmt = conn.createStatement();
									rs = stmt.executeQuery("select item_group_code, item_group_desc from item_group");
							%>
							<SELECT name="item_group" id = "item_group_id" size="6" accesskey="g" style="width: 95%;">
							<OPTION VALUE=""> Select Group</OPTION>
							<%
								rowcount = 0;
								while (rs.next()) {
									name = rs.getString(1);
									desc = rs.getString(2);
									if (rowcount == 0) {
							%>
							<OPTION VALUE="<%=name%>"><%=desc%></OPTION>
							<%
									} else {
							%>
							<OPTION VALUE="<%=name%>"><%=desc%></OPTION>
							<%
									}
								rowcount++;
								}
								rowcount = 0;
								rs.close();
								stmt.close();
							} catch (Exception e){}
								conn.close();
							%>
							</SELECT>
						</td>
					</tr>
					<tr>
						<td align="left">
							Item <font color="blue"><u>B</u></font>arcode
						</td>
						<td>
							:
						</td>
						<td align="left">
							<input type="text" name="item_barcode" id="item_barcode_id" style="width: 90%;" accesskey="b"/>
						</td>
					</tr>
					<tr>
						<td colspan="3" style="padding-top: 10px;">
							<input type="button" accesskey="r" class="button" onclick="clear();" value="Clear<Alt+r>"/>
							<input type="button" accesskey="s" class="button" onclick="getItemList();" value="Search<Alt+s>"/>
						</td>
					</tr>
				</table>
		</td>
		<td><div id="item_list_td"></div>
		</td>
	</tr>
</table>

	
</td>
</tr>
</table>	
<div id="popupContact">
	Item Sales Report <input type="button" value="Print" style="width:100" onclick="printPage('content');"/><a id="popupContactClose">x</a>
	<div id = "stack_info">
	</div>	
</div>
<div id="backgroundPopup"></div>
</body>
</html>