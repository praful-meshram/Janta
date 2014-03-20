<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<jsp:include page="leftsidemenu.jsp" />

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
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.aggregates.js"></script> 
    
    <%@ page errorPage="ReportErrorPage.jsp?page=RCustStatForm.jsp" %>

<script language="javascript">
   var flag=true;
	
	function checkField(){
		var custCode=document.myform.custCode.value;
		var custName=document.myform.custName.value;
		var area=document.myform.area.value;
	
		//var frDate=document.myform.frDate.value;
		//var toDate=document.myform.toDate.value;
		
		document.myform.frDate.value= $('#range1').jqxDateTimeInput('getText');
		document.myform.toDate.value= $('#range2').jqxDateTimeInput('getText');
				
	    		
 		document.myform.action="RCustomerStats.jsp?Exp=0";
	    document.myform.submit();	 		
	}
	
		window.onload =function Clear(){
		
		document.myform.custCode.value="";
		document.myform.area.value="";
		document.myform.custName.value="";
		document.myform.chckall.checked= true;
		document.myform.hchckall.value=1;
		
		document.myform.frDate.value= $('#range1').jqxDateTimeInput('getText');
		document.myform.frDate.value= $('#range2').jqxDateTimeInput('getText');
		
		
		$("#range1").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',max:new Date(),formatString: "yyyy-MM-dd"});
		$("#range2").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: "yyyy-MM-dd",value:new Date()});
		
		
		//$("#range1").jqxDateTimeInput({readonly:true});
		//$("#range2").jqxDateTimeInput({disabled: true});
		
		$('#range1').on('close', function (event) {
		 // Some code here. 
		 	$("#range2").jqxDateTimeInput({disabled: false});
		 	$("#range2").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});
 		}); 	
 		
 		
		
		return false;
	}
	function showMsg(){
	  	 document.myform.action="HomeForm.jsp";
	   	 document.myform.submit();
	}
</script>	

<form name="myform" method="post">
<TD  align="center" width="50%">
<center><b>Please Enter Customer Details </b></center><br><br>
	<table>
		<tr>
			<td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>			
			<!-- <td align=left><b><font color="blue">F</font>rom Date</b><INPUT type="hidden" name="frDate" size=11></TD> -->
			<td align=left><b><font color="blue">F</font>rom Date</b><div id="range1"></div><input type="hidden" name="frDate">
		</tr>
		<tr>
			<td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>			
			<!-- <td align=left><b><font color="blue">T</font>o Date</b> <INPUT type="hidden"  name="toDate" size=11> </TD> -->
			<td align=left><b><font color="blue">T</font>o Date</b><div id="range2"></div><input type="hidden" name="toDate">
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
	</tr>
							<tr>
								<td><b><font color="blue">N</font>ame</b></td><td colspan="3"><input type="text" name="custName"  align="right" accesskey="n" size="35"></td>
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

	
	<center><input type="submit" name="search"  title="Press <Enter>" value="Search <Enter>" accesskey="s" onclick="checkField();return false;">
	<input type="reset" name="clear" title="Press <Alt+r>" tabindex="1" value="Clear  <Alt+r>  " accesskey="r" onClick="Clear(); return false;">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
</TD>
</TR></TABLE>	
	
	<input  type="hidden" name="hchckall" value="1">
	<input type="hidden" name="htotalchangeamt" value="">
<input type="hidden" name="htotalordercnt" value="">
<input type="hidden" name="htotalpaidamt" value="">		
	</form>
<script>

	function funEnabled(){
	    if (document.myform.chckall.checked==true){
			document.getElementById('div4').style.visibility="hidden";
			document.myform.custCode.value="";
			document.myform.area.value="";
			document.myform.custName.value="";
			
		}
		else{
			document.getElementById('div4').style.visibility="visible";
			document.myform.hchckall.value=0;			
		}
	}
	
	
	
</script>
</body>
</html>
