<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.IOException"%>
<%@page contentType="text/html"%>

<jsp:include page="header.jsp" />

<%@ page errorPage="ReportErrorPage.jsp?page=RSalesStaffReportForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<jsp:include page="leftsidemenu.jsp" />

<script type='text/javascript' src='js/zapatec.js'></script>
	<script type='text/javascript' src='js/dndmodule.js'></script>
	<script type='text/javascript' src='js/list-sorting.js'></script>
	<script type='text/javascript' src='js/RSalesStaffReportForm.js'></script>
	<link href="stylesheet/lists.css" rel="stylesheet" type="text/css">

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
<!--      <script type="text/javascript" src="js/jqwidgets/jqxgrid.aggregates.js"></script>  -->
	
	
	
	
<script language="javascript">
   var flag=true;
	

</script>	

<form name="myform" method="post">
<TD  align="center" width="50%">
<b>Please Enter Item Details </b><br><br>
	<table>
		<tr>
			<td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>			
			<td align=left><b><font color="blue">F</font>rom Date</b></td><td align=left><!--<INPUT name="frDate" size=11> 
			 <input type="button" accesskey="f" onClick="c1.popup('frDate');" value="..."/> -->
			<div id="range1"></div>
			 </TD>
		</tr>
		<tr>
			<td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>			
			<td align=left><b><font color="blue">T</font>o Date</b></td><td align=left>
			<!-- <INPUT name="toDate" size=11>  <input type="button" accesskey="t" onClick="c1.popup('toDate');" value="..."/> -->
			<div id="range2"></div> </TD>
		</tr>
		<tr>
		<td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>	
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
	    }
	catch (Exception e) {
   		e.getMessage();
    	e.printStackTrace();    	
	}
%>
					</select></td>
		</tr>
		<tr>
		<td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>	</tr>
		<tr>		
			<td colspan="3">
			<input type="button" name="search"  title="Press <Enter>" value="Search <Enter>" accesskey="s" onclick="checkField();return false;">
			<input type="reset" name="clear" title="Press <Alt+r>" tabindex="1" value="Clear  <Alt+r>  " accesskey="r" onClick="window.location.reload(); return false;">
			<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();">
			</Alt></td>
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