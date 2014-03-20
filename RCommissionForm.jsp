<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

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
	

<%@ page errorPage="ReportErrorPage.jsp?page=RCommissionForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<jsp:include page="leftsidemenu.jsp" />
<script src="js/commissionsDetails.js"> </script>    
<style>
hr {
color: #f00;
background-color: #f00;
height: 3px;
}
</style>

<script language="javascript" src="js/codethatcalendarstd.js"></script>
<script>
	
	function checkField(){
		
		var range1 = $('#range1').jqxDateTimeInput('getText');
		var range2 = $('#range2').jqxDateTimeInput('getText');
		
		var url = "";
		if(!($("#range2").jqxDateTimeInput('disabled')))
			url = "&c_date1="+range1+"&c_date2="+range2;
		
		   
	    document.myform.action="RCommissionList.jsp?Exp=0"+url;
	   // alert(document.myform.action);
	   	document.myform.submit();
	    
	}
	
</script>
<form method="post" name="myform" >
<td width="50%">
	<h3><center>Commissions Details </center></h3>
	
	<center><b><font color="blue">&nbspA</font>ll &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="CheckBox" name="chckall" checked onClick="funEnabled();"></center>
	<br><br>
	<div id="div4" style="VISIBILITY:hidden" align="center">		
		<table border="0" align="center">		
				<tr>
				    <td><b><font color="blue">S</font>taff Name&nbsp&nbsp&nbsp</b>
				    <%
	Connection conn,conn1;
	Statement stmt,stmt1;
	ResultSet rs,rs1;	
	try {
		String dname;
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		//DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		DataSource ds = (DataSource)envContext.lookup("jdbc/re");
		conn = ds.getConnection();
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select dstaff_name from delivery_staff order by dstaff_name");%>
		
			<SELECT name="name">
			<OPTION VALUE=""> Select
<%
		 		while (rs.next()) {
		 			dname = rs.getString(1);%>
					<OPTION VALUE="<%=dname%>"> <%=dname%> 
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
				<tr></tr>
				<tr></tr>
				<tr>
					<td colspan=4><fieldset><legend>Range</legend><table align="center">					
					<tr></tr>
					<tr></tr>
					<tr>
						<td><b>A<font color="blue">m</font>ount</b></td><td><input type ="text" accesskey="m" name="amt1" size="6"></td><td><b>to</b></td><td> <input type ="text" name="amt2" size="6"></td>
					</tr>
					<tr></tr>
					<tr></tr>
					<!-- <tr>
							<td><b>From<font color="blue">D</font>ate</b></td><td><input type ="text" accesskey="d" name="c_date1" size="10"><input type="button" onClick="c1.popup('c_date1');" value="..."/></td><td><font color="blue"> T</font>oDate</td><td> <input type ="text" name="c_date2"  size="10"><input type="button" onClick="c1.popup('c_date2');" value="..."/></td>
						</tr>
					 -->
					 
					 <tr>
							<td><b>From<font color="blue">D</font>ate</b></td><td><div id="range1"></div></td><td><font color="blue"> T</font>oDate</td><td><div id="range2"></div></td>
					</tr>
					
					 
					 <tr></tr>
						
						
						
						
					<tr></tr>
						
					</table></fieldset></td>
				</tr>
		</table></div>

<br>
	<input  type="hidden" name="hchckall" value="1">
	<center><input type="submit" name="Submit" value="Search <Alt+s>" accesskey="s" onclick="checkField();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>" onclick="document.getElementById('txtHint').innerHTML='';">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();">
	
	</td></tr></table>	
</form>
</body>

<script>	
	function showMsg(){
		 	 document.myform.action="HomeForm.jsp";
			 document.myform.submit();
    }
	function funEnabled(){
	    if (document.myform.chckall.checked==true){
			document.getElementById('div4').style.visibility="hidden";
			document.myform.hchckall.value=1;	
			$("#range2").jqxDateTimeInput({disabled: true});
							
		}
		else{
			document.getElementById('div4').style.visibility="visible";
			document.myform.hchckall.value=0;	
					
		}
	}
	
	window.onload=Clear;
		
		function Clear(){			
			document.myform.chckall.checked=true;	
			document.myform.hchckall.value="1";
			
		$("#range1").jqxDateTimeInput({theme:'ui-redmond', width: '250px', height: '25px',max:new Date(),formatString: "yyyy-MM-dd"});
		$("#range2").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: "yyyy-MM-dd",value:new Date()});
		
		
		$("#range2").jqxDateTimeInput({disabled: true});
		
		$('#range1').on('close', function (event) {
		 // Some code here. 
		 	$("#range2").jqxDateTimeInput({disabled: false});
		 	$("#range2").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});
 		}); 
			
						
		}
</script>
</html>