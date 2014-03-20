<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />

	
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

<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="RcustSalesForm.jsp" />	
</jsp:include>
 --%>
 
<%@ page errorPage="ReportErrorPage.jsp?page=RcustSalesForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<jsp:include page="leftsidemenu.jsp" />
<!-- <script language="javascript" src="js/codethatcalendarstd.js"></script> -->
<script type='text/javascript' src='js/report.js'></script>
	<script type='text/javascript' src='js/zapatec.js'></script>
	<script type='text/javascript' src='js/dndmodule.js'></script>
	<script type='text/javascript' src='js/list-sorting.js'></script>
	<script type="text/javascript" src="js/RcustSalesForm.js">
	<link href="stylesheet/lists.css" rel="stylesheet" type="text/css"/>

	
<script language="javascript">

	
</script>	

<form name="myform" method="post">
<TD  align="center" width="50%">
<center><b>Please Enter Customer Details </b></center><br><br>
	<table>
		<tr>
			<td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>			
			<td align=left><b><font color="blue">F</font>rom Date</b></td>
			<td align=left>
				<div id="range1" name="range1"></div> 
			</TD>
		</tr>
		<tr>
			<td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>			
			<td align=left><b><font color="blue">T</font>o Date</b></td>
			<td align=left>
				<div id="range2" name="range2" ></div>
			 </TD>
		</tr>	

		<tr>
			<td colspan=3><fieldset><legend> Selection Criteria</legend>
			<table align=left>
				<tr></tr>
				<tr></tr>
				<tr>
					<td><b><font color="blue">&nbspA</font>ll &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="CheckBox" name="chckall" checked onClick="funEnabled();"></td>
				</tr>
				<tr>
					<td colspan=2>
					<div id="div4" style="VISIBILITY:hidden" >
						<table>
							<tr>
								<td><b><font color="blue">C</font>ode</b></td><td><input type="text" name="custCode" accesskey="c" size="10"></td>
								<td><b><font color="blue">A</font>rea</b></td>
					<td>
<% 

	String name;
	try {
		
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		//DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		DataSource ds = (DataSource)envContext.lookup("jdbc/re");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery("select value from code_table where category='AREA' order by value asc");
					
%>
					<center>
						<SELECT name="area" align="left">
						<OPTION VALUE=""> Select Area 
<%
 		while (rs.next()) {
 			name = rs.getString(1);
 			
%>
								<OPTION VALUE="<%=name%>"> <%= name%> 
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
								<td><b><font color="blue">N</font>ame</b></td><td colspan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<!-- <input type="text" name="custName"  align="right" accesskey="n" size="35" onblur="fundispitem(this.value);"> -->
								<input type="text" name="custName"  align="right" accesskey="n" size="35">
								</td>
							</tr>
							<tr>				
								<td colspan="4" ><div id="dispitem" style="visbility:hidden;display:none;overflow:auto;height:100"></div></td>
							</tr>
						</table>
					</div>
					</td>
				</tr>			
				<tr></tr>
				<tr></tr>	
			</table> 
		 	</fieldset></td></tr>
	</table><br>

	
	<center><input type="submit" name="search"  title="Press <Enter>" value="Summary <Enter>" accesskey="s" onclick="flag=true;checkField();return false;">
	<input type="reset" name="clear" title="Press <Alt+r>" tabindex="1" value="Clear  <Alt+r>  " accesskey="r" onClick="window.location.reload(); return false;">
	<br><br>
	&nbsp&nbsp&nbsp&nbsp<input type="button" name="detail"  title="Press <Alt+d>" value="Details  <Alt+d>   " accesskey="d" onclick="flag=false;checkField();return false;">&nbsp&nbsp
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
</TD>
</TR></TABLE>	
	<input  type="hidden" name="hcondition" value="summary">
	<input  type="hidden" name="hchckall" value="1">
	<input type="hidden" name="htotalchangeamt" value="">
<input type="hidden" name="htotalordercnt" value="">
<input type="hidden" name="htotalpaidamt" value="">	
	<input  type="hidden" name="hitemname" value="">
	<input  type="hidden" name="hitem" value="">	
	</form>
	<div id="salesSummery"></div>

</body>
</html>
