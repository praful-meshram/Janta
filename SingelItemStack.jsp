<%@page contentType="text/html"%>
<%@ page import="java.text.*,payment.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<jsp:include page="header.jsp" />
<jsp:include page="leftsidemenu.jsp" />
<script src="js/jquery-1.2.6.min.js" type="text/javascript"></script>
<script src="js/singleItemStock.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/singleItemStock.css" />
 <link href="css/StockMovementReportForm.css" rel="stylesheet" type="text/css"/>

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
<%@ page errorPage="ReportErrorPage.jsp?page=SingleItemStack.jsp" %>

<td width="50%" valign="top" style="font-family: arial;">
	<h2 style="float: left;">Item wise Stock Report</h2>
	<table style="width: 100%;">
	<tr style="display: none;cursor: pointer;" id="excelRow"><td colspan="2"><img alt="Save To Excel" src="images/Background/Excel-icon (2).png"  id="saveToExcel" style="float:right;"/></td></tr>
		<tr>
			<td style="width: 25%; border: 1px solid black;" valign="top" align="center">
				<h4>Search Item</h4>
				<table style="width: 100%;">
					<tr>
						<td align="left" style="width: 37%;">
							Item <font color="blue"><u>N</u></font>ame
						</td>
						<td style="width: 1%;">
							:
						</td>
						<td align="left" style="width: 55%;">
							<input type="text" name="item_name" id="item_name_id" style="width: 95%;" accesskey="n"/>
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
							<input type="text" name="item_code" id="item_code_id" style="width: 95%;" accesskey="c"/>
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
							<SELECT name="item_group" id = "item_group_id" size="6" accesskey="g" style="width: 99%;">
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
								conn.close();
							} catch (Exception e){}
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
							<input type="text" name="item_barcode" id="item_barcode_id" style="width: 98%;" accesskey="b"/>
						</td>
					</tr>
					<tr>
						<td colspan="3" style="padding-top: 10px;">
							<input type="button" accesskey="r" onclick="window.location.reload();" value="Refresh<Alt+r>"/>
							<input type="button" accesskey="s" onclick="getItemList();" value="Search<Alt+s>"/>
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
 	<h3>Current Stock Information</h3> <a id="popupContactClose">x</a>
	<ul style="width: 100%;">
	<li class="list" id='list1'><b>Item Name :&nbsp;</b>null</li>
	<li class="list" id='list2'><b>Item Weight :&nbsp;</b>null</li>
	<li class="list" id='list3'><b>Total Quantity :&nbsp;</b>null</li>
	</ul>
	<div id = "stack_info">
	</div>	
</div>
<div id="backgroundPopup"></div>
</body>
</html>