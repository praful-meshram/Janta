<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.IOException"%>
<%@page contentType="text/html"%>

<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	 --%>
<%--    <jsp:param name="formName" value="RSalesStaffReportForm.jsp" />	 --%>
<%-- </jsp:include> --%>

<%@ page errorPage="ReportErrorPage.jsp?page=RSalesStaffReportForm.jsp" %>
	
	

<jsp:include page="leftsidemenu.jsp" />

<script type='text/javascript' src='js/zapatec.js'></script>
	<script type='text/javascript' src='js/dndmodule.js'></script>
	<script type='text/javascript' src='js/list-sorting.js'></script>
	<script type='text/javascript' src='js/RItemSalesStaffReport.js'></script>
	<link href="stylesheet/lists.css" rel="stylesheet" type="text/css">
	
	   <script type="text/javascript" src="js/jqwidgets/gettheme.js"></script>
	  <link rel="stylesheet" href="js/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="js/jqwidgets/styles/jqx.darkblue.css" type="text/css" />
    <link rel="stylesheet" href="js/jqwidgets/styles/jqx.ui-redmond.css" type="text/css" />
	   
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
<!--      <script type="text/javascript" src="js/jqwidgets/jqxgrid.aggregates.js"></script>  -->
	
	
	
	
<script language="javascript">
   var flag=true;
	
</script>	

<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<form name="myform" method="post">
<TD  align="center" width="50%">
<b>Please Enter Item Details </b><br><br>
	<table style="width: 100%;">
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>			
			<td align=left><b><font color="blue">F</font>rom Date</b></td><td align=left>
			<!-- <INPUT name="frDate" size=11> <input type="button" accesskey="f" onClick="c1.popup('frDate');" value="..."/> -->
			<div id="range1" style="z-index: -1"></div> </TD>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>			
			<td align=left><b><font color="blue">T</font>o Date</b></td><td align=left>
			<!-- <INPUT name="toDate" size=11>  <input type="button" accesskey="t" onClick="c1.popup('toDate');" value="..."/>  -->
			<div id="range2" style="z-index: -1"></div></TD>
		</tr>
		<tr>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>	
			<td align=left><b><font color="blue">S</font>taff Person</b></td>
<%	
	Connection conn=null;
	Statement stmt=null, stat=null;
	ResultSet rs=null, rs2=null;
	
	try {
		String name,desc;
		int rowcount;
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		//DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		DataSource ds = (DataSource)envContext.lookup("jdbc/re");
		conn = ds.getConnection();
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select username from user");
%>
			      	<td align=left>
						<SELECT name="selUeser" accesskey="s">
						<OPTION VALUE="all" >All</OPTION>
<% 
		rowcount = 0;
	 	while (rs.next()) {
	 		name = rs.getString(1);	 		
%>
				<OPTION VALUE="<%= name%>" ><%= name%></OPTION>
<%
		}		
	    rs.close();
	    stmt.close();
	    conn.close();
	    }
	catch (Exception e) {
   		e.getMessage();
    	e.printStackTrace();    	
	}
%>
					</select></td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>	
		</tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>			
			<td align=left><b><font color="blue">A</font>ll Items</b>
			<td align=left><input type="CheckBox" name="chckall" checked onClick="funEnabled();" accesskey="a"></td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>			
		   <td colspan="2">
		 <div id="hidDiv" style="VISIBILITY:hidden">	
		 	<table><tr>					
			<td align=left><b><font color="blue">I</font>tem Name</b></td>
			<td align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="text" size="40" name="serachItemName" accesskey="i" value="all"/> </TD>
			</tr></table>
		 </div>
		 </td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>	
		</tr>
		<tr>		
			<td colspan="3" style="text-align: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" name="Submit"  title="Press <Enter>" value="Submit <Enter>" accesskey="s" onclick="funGetData();">
			<input type="reset" name="clear" title="Press <Alt+r>" tabindex="1" value="Clear  <Alt+r>  " accesskey="r" onClick="window.location.reload(); return false;">
			<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();">
			</Alt></td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>	
		</tr>			
		<tr style="width: 100%;">		
			<td colspan="3" style="width: 100%;">
				<div id="dataDiv" style="height:200px;width: 100%;"></div>	
			</td>
		</tr>	
				
</table>
</TD>
</tr></table>		

	<input  type="hidden" name="hchckall" value="1">
	<input  type="hidden" name="hitemname" value="">
	<input  type="hidden" name="hitem" value="">

	</form>

<script>
	window.onload =Clear;	
</script>
</body>

</html>