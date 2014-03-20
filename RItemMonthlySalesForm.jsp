<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="RItemMonthlySalesForm.jsp" />	
</jsp:include>
 --%>
 
 <%@ page errorPage="ErrorPage.jsp?page=RItemMonthlySalesForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<jsp:include page="leftsidemenu.jsp" />
<script language="javascript" src="js/codethatcalendarstd.js"></script>
<script src="js/GraphItemMonthlySales.js"></script> 
<script type='text/javascript' src='js/zapatec.js'></script>
	<script type='text/javascript' src='js/dndmodule.js'></script>
	<script type='text/javascript' src='js/list-sorting.js'></script>
	<link href="stylesheet/lists.css" rel="stylesheet" type="text/css">
	

<form name="myform" method="post">
<TD  align="center" width="50%">
<center><b>Please Enter Item Details </b><br><br>
	<table >
		<tr>
					<td><b><font color="blue">&nbspA</font>ll Months &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="CheckBox" name="chckall" checked onClick="funEnabled();"></td>
		</tr>
		<tr>
			<td><div id="div4" style="VISIBILITY:hidden" >
			<table>
			<tr>
			 <td colspan=3><fieldset><legend> Selection Criteria</legend>
				<table align=left>				
				<tr>
					<td align="left"><b>Select Month</b></td>
					<td align="left"><SELECT name="selMonth">
							<OPTION VALUE="select"> ALL
<%					
					String months[] = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
       /*{"Jan", "Feb", "Mar", "Apr", "May", "Jun", 
        "July", "Aug", "Sep", "Oct", "Nov", "Dec"};*/
   		//use the length attribute to get the number of elements in an array
   					for(int i = 0; i < months.length; i++ ) {
%>
					<OPTION VALUE="<%=months[i]%>"> <%=months[i]%>
<%					}
%>
							</td>
						</tr>
						<tr>
							<td align="left"><b>Item Group </b></td>
<%	
	Connection conn=null;
	Statement stmt=null, stat=null;
	ResultSet rs=null, rs2=null;
	try {
		String name,desc;
		int rowcount;
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select item_group_code, item_group_desc from item_group");
%>
			      	<td align="left">
						<SELECT name="iGroupCode">
						<OPTION VALUE="select" >Select Group
<% 
		rowcount = 0;
	 	while (rs.next()) {
	 		name = rs.getString(1);
	 		desc = rs.getString(2);
	 		if (rowcount==0) { 
 %>
							<OPTION VALUE="<%= name%>" ><%= desc%>
<%
  			}
   			else {
%>
								<OPTION VALUE="<%= name%>" ><%= desc%>
<%
			} 
			rowcount++;
		}
		rowcount=0;
	    rs.close();
	    stmt.close();
	    }
	catch (Exception e) {
   		e.getMessage();
    	e.printStackTrace();    	
	}
%>
					</select></td></tr>
	<tr>
				<td align="left"><b>Item Name </b></td>
				<td align="left"><input type="text" name="itemname" onblur="fundispitem(this.value);"></td>
		</tr>
		<tr>
				
				<td colspan="2" align="center"><div id="dispitem" style="visbility:hidden;display:none;overflow:auto;height:100"></div></td>
		</tr>	
		

				</table>				
		 	</fieldset></td></tr></table>
		</div>	
	</table><br>

	
	<center><input type="submit" name="search"  title="Press <Enter>" value="Search <Enter>" accesskey="s" onclick="checkField();return false;">
	<input type="reset" name="clear" title="Press <Alt+r>" tabindex="1" value="Clear  <Alt+r>  " accesskey="r" onClick="window.location.reload(); return false;">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
</TD>
</TR></TABLE>	
	
	<input  type="hidden" name="hchckall" value="1">
	<input  type="hidden" name="hitemname" value="">
	<input  type="hidden" name="hitem" value="">
	
	</form>
<script>
	window.onload =Clear;
</script>
</body>
</html>
