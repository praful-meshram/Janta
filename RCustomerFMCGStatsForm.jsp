
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<jsp:include page="leftsidemenu.jsp" />

<%@ page errorPage="ReportErrorPage.jsp?page=RCustomerFMCGStatsForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<form name="myform" method="post">
<TD  align="center" width="50%">
<center><b>Please Enter Customer Details </b></center><br><br>
	<table>
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
							<tr>
								<td><b><font color="blue">F</font>MCG</b></td><td ><input type="text" name="fmcg"  align="right" accesskey="f" size="5"></td>
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
	window.onload =Clear;
	function funEnabled(){
	    if (document.myform.chckall.checked==true){
			document.getElementById('div4').style.visibility="hidden";
			document.myform.custCode.value="";
			document.myform.area.value="";
			document.myform.custName.value="";
			document.myform.hchckall.value=1;			
			
		}
		else{
			document.getElementById('div4').style.visibility="visible";
			document.myform.hchckall.value=0;			
		}
	}
		function checkField(){
		var custCode=document.myform.custCode.value;
		var custName=document.myform.custName.value;
		var area=document.myform.area.value;
		var fmcg =document.myform.fmcg.value;
		if (document.myform.chckall.checked==false && custName=="" && custCode=="" && area=="" && fmcg=="") {
					alert("fill the information");
					return false;				
		}	
				
 		document.myform.action="RCustomerFMCGStats.jsp?Exp=0";
	    document.myform.submit();	 		
	}
	
	function Clear(){
		
		document.myform.custCode.value="";
		document.myform.area.value="";
		document.myform.custName.value="";
		document.myform.fmcg.value="";
		document.myform.chckall.checked= true;
		return false;
	}
	function showMsg(){
	  	 document.myform.action="HomeForm.jsp";
	   	 document.myform.submit();
	}
	
	
</script>
</body>
</html>
