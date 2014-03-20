<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="RItemSalesForm.jsp" />	
</jsp:include>
 --%>
<%@ page errorPage="ReportErrorPage.jsp?page=RItemSalesForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<jsp:include page="leftsidemenu.jsp" />
<script language="javascript" src="js/codethatcalendarstd.js"></script>
<script type="text/javascript" src="js/RitemSales.js"></script>
	<script type='text/javascript' src='js/zapatec.js'></script>
	<script type='text/javascript' src='js/dndmodule.js'></script>
	<script type='text/javascript' src='js/list-sorting.js'></script>
	<link href="stylesheet/lists.css" rel="stylesheet" type="text/css">

<script language="javascript">
   var flag=true;
	var caldef1 = {
		firstday:0,
		dtype:'dd/MM/yyyy',
		width:250,
		windoww:300,
		windowh:200,
		border_width:0,
		border_color:'#0000d3',
		dn_css:'clsDayName',                        
		cd_css:'clsCurrentDay',
		wd_css:'clsWorkDay',
		we_css:'clsWeekEnd',
		wdom_css:'clsWorkDayOtherMonth',
		weom_css:'clsWeekEndOtherMonth',
		headerstyle: {
		type:"comboboxes",
		css:'clsWorkDayOtherMonth',
		yearrange:[1987,2050]
		},
		monthnames :["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
		daynames : ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
		};
		var c1 = new CodeThatCalendar(caldef1);
	</script>
	<script language='JavaScript' type='text/javascript'>
	
	
	function validateIndiaDate( strValue ) {
		/************************************************
		DESCRIPTION: Validates that a string contains only
		valid dates with 2 digit month, 2 digit day,
		4 digit year. Date separator can be ., -, or /.
		Uses combination of regular expressions and
		string parsing to validate date.
		Ex. mm/dd/yyyy or mm-dd-yyyy or mm.dd.yyyy
		PARAMETERS:
		strValue - String to be tested for validity
		RETURNS:
		True if valid, otherwise false.
		REMARKS:
		Avoids some of the limitations of the Date.parse()
		method such as the date separator character.
		*************************************************/
		var objRegExp = /^\d{1,2}(\-|\/|\.)\d{1,2}\1\d{4}$/
		//check to see if in correct format
		if(!objRegExp.test(strValue))
		    return false; //doesn't match pattern, bad date
		else{
			var strSeparator = strValue.substring(2,3) //find date separator
		    var arrayDate = strValue.split(strSeparator); //split date into month, day, year
		    //create a lookup for months not equal to Feb.
		    var arrayLookup = { '01' : 31,'03' : 31, '04' : 30,'05' : 31,'06' : 30,'07' : 31,
			'08' : 31,'09' : 30,'10' : 31,'11' : 30,'12' : 31}
		    var intDay = parseInt(arrayDate[0],10);
		    //check if month value and day value agree
			if(arrayLookup[arrayDate[1]] != null) {
		      	if(intDay <= arrayLookup[arrayDate[1]] && intDay != 0)
					return true; //found in lookup table, good date
		    	}
		  //check for February
		  var intYear = parseInt(arrayDate[2],10);
		  var intMonth = parseInt(arrayDate[1],10);
		  if( ((intYear % 4 == 0 && intDay <= 29) || (intYear % 4 != 0 && intDay <=28)) && intDay !=0)
		  	return true; //Feb. had valid number of days
		  }
		  return false; //any other values, bad date
	}	
</script>	

<form name="myform" method="post">
<TD  align="center" width="50%">
<center><b>Please Enter Item Details </b><br><br>
	<table>
		<tr>
			<td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>			
			<td align=left><b><font color="blue">F</font>rom Date</b></td><td align=left><INPUT name="frDate" size=11> <input type="button" accesskey="f" onClick="c1.popup('frDate');" value="..."/> </TD>
		</tr>
		<tr>
			<td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>			
			<td align=left><b><font color="blue">T</font>o Date</b></td><td align=left><INPUT name="toDate" size=11>  <input type="button" onClick="c1.popup('toDate');" value="..."/> </TD>
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
							<td><b>Item Group </b></td>
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
		rs = stmt.executeQuery("select item_group_code, item_group_desc from item_group");
%>
			      	<td>
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
					</select></td>
		</tr>
		<tr>
				<td><b>Item Name </b></td>
				<td><input type="text" name="itemname"  onblur="fundispitem(this.value);"></td>
		</tr>
		<tr>
				
				<td colspan="2" ><div id="dispitem" style="visbility:hidden;display:none;overflow:auto;height:100"></div></td>
		</tr>
		</table>
		</div>
		</td>
	</tr>		
</table></fieldset></td></tr>
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
