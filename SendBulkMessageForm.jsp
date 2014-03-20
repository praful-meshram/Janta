<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="SendBulkMessageForm.jsp" />	
</jsp:include>
 --%>
<%@ page errorPage="ErrorPage.jsp?page=SendBulkMessageForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<script language="javascript" src="js/codethatcalendarstd.js"></script>
<style>
hr {
color: #f00;
background-color: #f00;
height: 3px;
}
</style>
<script>
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
	
	
	function validateIndiaDate( strValue ) {
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
	
	function checkField(){
		if(document.myform.chckall.checked==true){
			showHint();
		}
		else{
			var c_date1 = document.myform.c_date1.value ;
			var c_date2 = document.myform.c_date2.value ;
			var u_date1 = document.myform.u_date1.value ;
			var u_date2 = document.myform.u_date2.value ;
			if(c_date1!="" && c_date2 !="") {	
					var str = "";
					str = str + document.myform.c_date1.value ;
					//str = str + document.myform.frMonth.value;	
					if (validateIndiaDate(str) == false){
						alert("Please enter a valid Create_date1 Date");
						return false;
					}
					str = "";
					str = str + document.myform.c_date2.value ;
					if (validateIndiaDate(str) == false){
						alert("Please enter a valid Create_date2 Date");
						return false;
					}					
					document.myform.c_date1.value = document.myform.c_date1.value.substring(6,10) + "-" +
				                                document.myform.c_date1.value.substring(3,5) +
				                                "-" + document.myform.c_date1.value.substring(0,2);
				
				 	document.myform.c_date2.value  = document.myform.c_date2.value.substring(6,10) + "-" +
				                                                document.myform.c_date2.value.substring(3,5) +
				                                                "-" + document.myform.c_date2.value.substring(0,2);						
					
		    }
		    else if(c_date1!=""){
		    		var str = "";
					str = str + document.myform.c_date1.value ;
					//str = str + document.myform.frMonth.value;	
					if (validateIndiaDate(str) == false){
						alert("Please enter a valid From Date");
						return false;
					}
					document.myform.c_date1.value = document.myform.c_date1.value.substring(6,10) + "-" +
				                                document.myform.c_date1.value.substring(3,5) +
				                                "-" + document.myform.c_date1.value.substring(0,2);
				
		    }
		    if(u_date1!="" && u_date2 !="") {	
					var str = "";
					str = str + document.myform.u_date1.value ;
					//str = str + document.myform.frMonth.value;	
					if (validateIndiaDate(str) == false){
						alert("Please enter a valid Upadate_date1 Date");
						return false;
					}
					str = "";
					str = str + document.myform.u_date2.value ;
					if (validateIndiaDate(str) == false){
						alert("Please enter a valid Upadate_date2 Date");
						return false;
					}
					
					document.myform.u_date1.value = document.myform.u_date1.value.substring(6,10) + "-" +
				                                document.myform.u_date1.value.substring(3,5) +
				                                "-" + document.myform.u_date1.value.substring(0,2);
				
				 	document.myform.u_date2.value  = document.myform.u_date2.value.substring(6,10) + "-" +
				                                                document.myform.u_date2.value.substring(3,5) +
				                                                "-" + document.myform.u_date2.value.substring(0,2);						
					
		    }
		    else if(u_date1!=""){
		    		var str = "";
					str = str + document.myform.u_date1.value ;
					//str = str + document.myform.frMonth.value;	
					if (validateIndiaDate(str) == false){
						alert("Please enter a valid Upadate_date1 Date");
						return false;
					}
		   			 document.myform.u_date1.value = document.myform.u_date1.value.substring(6,10) + "-" +
				                                document.myform.u_date1.value.substring(3,5) +
				                                "-" + document.myform.u_date1.value.substring(0,2);
			}
		    
		 document.myform.action="SendMsgCustomerDetails.jsp";
		 alert(document.myform.action)
	   	 document.myform.submit();  
	    }
	}
	function showMsg(){
	  	 document.myform.action="HomeForm.jsp";
	   	 document.myform.submit();
	}
	function Clear(){
		document.myform.chckall.checked= true;
		document.myform.custCode.value="";
		document.myform.phonenumber.value="";
		document.myform.custName.value="";
		document.myform.nameString.value="";		
		document.myform.Building.value="";
		document.myform.Building_no.value="";
		document.myform.wing.value="";
		document.myform.block.value="";
		document.myform.add1.value="";
		document.myform.add2.value="";
		document.myform.area.value="";
		document.myform.station.value="";
		document.myform.c_date1.value="";
		document.myform.c_date2.value="";
		document.myform.u_date1.value="";
		document.myform.u_date2.value="";
		
		
	}
</script>




















<form name="myform" method="post">
<td  width="50%">
	<table align="left">
		<tr>
			<td align="center" colspan=3><b><font color="blue">&nbspA</font>ll Customers List &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="CheckBox" name="chckall" checked onClick="funEnabled();"></td>
		</tr>		
		<tr>
			<td colspan=3>
			<div id="div4" style="VISIBILITY:hidden" >
				<table>				
					<tr>
						<td><b><font color="blue">C</font>ustomer Code</b></td><td><input type="text" name="custCode" accesskey="c"></td>
						<td><b><font color="blue">P</font>hone Number</b></td><td><input type="text" name="phonenumber" size="22" align="right" colspan="2" accesskey="p"></td>
					</tr>
					<tr>
						<td><b>Customer <font color="blue">N</font>ame</b></td><td><input type="text" name="custName"  align="right" accesskey="n"></td>
						<td><b>Na<font color="blue">m</font>e String</b></td><td><input type="text" name="nameString" size="22"  align="right" accesskey="m" colspan="2"></td>
					</tr>
					<tr>
						<td ><b><font color="blue">B</font>uilding</b></td><td><input type="text" name="Building" accesskey="b"    align="right"></b></td>
						<td ><b>Building <font color="blue">N</font>o.</b></td><td><input type="text" name="Building_no"  size="22"  accesskey="o"></b></td>
					</tr>
					<tr>
					    <td><b><font color="blue">W</font>ing</b></td><td><input type ="text" name="wing" accesskey="w" ></td>
						<td><b><font color="blue">F</font>lat No.</b></td><td><input type ="text" name="block"  size="22" accesskey="f" align="right">
						</tr>
					<tr>
						<td><b>Addr<font color="blue">e</font>ss1</b></td><td><input type ="text" accesskey="e" name="add1"></td>
						<td ><b>A<font color="blue">d</font>dress2</b></td><td><input type ="text" accesskey="d" name="add2" size="22"></td>
					</tr>
					<tr >
						<td ><b>A<font color="blue">r</font>ea</b></td><td>
<% 

	String name;
	try {
		
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
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
							<td ><b><font color="blue">S</font>tation</b></td><td><input type ="text"  size="22" accesskey="d" name="station"></td>
						</tr>
						<tr>
							<td><b>Create<font color="blue">D</font>ate</b></td><td><input type ="text" accesskey="d" name="c_date1" size="15"><input type="button" onClick="c1.popup('c_date1');" value="..."/></td><td> <b>And</b></td><td> <input type ="text" name="c_date2"  size="15"><input type="button" onClick="c1.popup('c_date2');" value="..."/></td>
						</tr>
						<tr>
							<td><b><font color="blue">U</font>pdate Date</b></td><td><input type ="text" accesskey="u" name="u_date1" size="15"><input type="button" onClick="c1.popup('u_date1');" value="..."/></td><td><b>And</b></td><td> <input type ="text" name="u_date2" size="15"><input type="button" onClick="c1.popup('u_date2');" value="..."/></td>
						</tr>
						
					</table></div>
				</td>
			</tr>
			
			<tr>
				<td align="left" colspan=4>
					<input type="submit" name="search"  title="Press <Enter>" value="Search <Enter>" accesskey="s" onclick="checkField();return false;">
				    <input type="reset" name="clear" title="Press <Alt+c>" tabindex="1" value="Clear <Alt+c>" accesskey="c" onclick="document.getElementById('txtHint').innerHTML='';">
				    <INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
				    
				</td>
				</tr>
		
		  </table>
		  <input  type="hidden" name="hchckall" value="1">
 </td>
 </tr>
 
 
 </table>
 
 <table>
 <tr>
     <td><font color="blue">M</font><b>essage</b></td><td><input type="textarea" name="message"></td>
 </tr>
 <tr>
      <td><input type="button" value="Send" align="center"></td>
 </tr>
  </table>
<script>
<%
			String str1="";
		    str1=request.getParameter("Exp");
	%>
	var jExp=<%=str1%>
	if(jExp==1){
		alert("Error !!!");
	}
function funEnabled(){
	    if (document.myform.chckall.checked==true){
			document.getElementById('div4').style.visibility="hidden";
			document.myform.hchckall.value=1;		
		}
		else{
			document.getElementById('div4').style.visibility="visible";
			document.myform.hchckall.value=0;			
		}
	}
window.onload =Clear;
</script>
	</form>
</body>
</html>
