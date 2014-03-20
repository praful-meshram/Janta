<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="RcustListForm.jsp" />	
</jsp:include>

 --%>
 
 
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
 
 
 
<%@ page errorPage="ReportErrorPage.jsp?page=RcustListForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<jsp:include page="leftsidemenu.jsp" />
<script language="javascript" src="js/codethatcalendarstd.js"></script>
<script>
	
	function checkField(){
		//sene date with url
		
		var crateDate1 = $('#crateDate1').jqxDateTimeInput('getText');
		var crateDate2 = $('#crateDate2').jqxDateTimeInput('getText');
		
		var updateDate1 = $('#updateDate1').jqxDateTimeInput('getText');
		var updateDate2 = $('#updateDate2').jqxDateTimeInput('getText');
		
		var url = "";
		if(!($("#crateDate2").jqxDateTimeInput('disabled')))
			url = "&c_date1="+crateDate1+"&c_date2="+crateDate2;
		if(!($("#updateDate2").jqxDateTimeInput('disabled')))
			url += "&u_date1="+updateDate2+"&u_date2="+updateDate2;
			
		document.myform.action="RcustList.jsp?Exp=0"+url;
		
		//alert(document.myform.action);
	   	
	   	document.myform.submit();
	   	
	}
	function showMsg(){
	  	 document.myform.action="HomeForm.jsp";
	   	 document.myform.submit();
	}
	function Clear(){
		document.myform.chckall.checked= true;
		 document.myform.hchckall.vaue="1";
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
		
		
		// create date
		$("#crateDate1").jqxDateTimeInput({theme:'ui-redmond', width: '250px', height: '25px',max:new Date(),formatString: "yyyy-MM-dd"});
		$("#crateDate2").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: "yyyy-MM-dd",value:new Date()});
		
		
		$("#crateDate2").jqxDateTimeInput({disabled: true})
		
		//alert("create datetime  "+ $("#crateDate2").jqxDateTimeInput('disabled'));
		
		$('#crateDate1').on('close', function (event) {
		 // Some code here. 
		 	$("#crateDate2").jqxDateTimeInput({disabled: false});
		 	$("#crateDate2").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});
 		}); 
 		
 		
 		// update date
 		$("#updateDate1").jqxDateTimeInput({theme:'ui-redmond', width: '250px', height: '25px',max:new Date(),formatString: "yyyy-MM-dd"});
		$("#updateDate2").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: "yyyy-MM-dd",value:new Date()});
		
		
		$("#updateDate2").jqxDateTimeInput({disabled: true});
		$('#updateDate1').on('close', function (event) {
		 // Some code here. 
		 	$("#updateDate2").jqxDateTimeInput({disabled: false});
		 	$("#updateDate2").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});
 		}); 
		
		
		
	}
</script>

<form name="myform" method="post">
<td  width="50%">
	<table align="center">
		<tr>
			<td align="center" colspan=3><b><font color="blue">&nbspA</font>ll Customers List &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="CheckBox" name="chckall" checked onClick="funEnabled();"></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr>
			<td colspan=3><fieldset><legend> Selection Criteria</legend>
			<div id="div4" style="VISIBILITY:hidden" >
				<table>	
					<br>			
					<tr><td colSpan="4"><b>Please Enter Customer Details to Search:</b></td></tr>
					<tr></tr>
					<tr></tr>
					<tr></tr>
					<tr></tr>
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
							<td ><b><font color="blue">S</font>tation</b></td><td><input type ="text"  size="22" accesskey="d" name="station"></td>
						</tr>
						<!-- <tr>
							<td><b>Create<font color="blue">D</font>ate</b></td><td><input type ="text" accesskey="d" name="c_date1" size="15"><input type="button" onClick="c1.popup('c_date1');" value="..."/></td><td> <b>And</b></td><td> <input type ="text" name="c_date2"  size="15"><input type="button" onClick="c1.popup('c_date2');" value="..."/></td>
						</tr>
						<tr>
							<td><b><font color="blue">U</font>pdate Date</b></td><td><input type ="text" accesskey="u" name="u_date1" size="15"><input type="button" onClick="c1.popup('u_date1');" value="..."/></td><td><b>And</b></td><td> <input type ="text" name="u_date2" size="15"><input type="button" onClick="c1.popup('u_date2');" value="..."/></td>
						</tr> -->
						<tr>
							<td><b>Create<font color="blue">D</font>ate</b></td><td><div id="crateDate1"></div></td><td> <b>And</b></td><td><div id="crateDate2"></div></td>
						</tr>
						<tr>
							<td><b><font color="blue">U</font>pdate Date</b></td><td><div id="updateDate1"></td><td><b>And</b></td><td> <div id="updateDate2"></td>
						</tr>
						
						<tr></tr>
						<tr></tr>
						<tr></tr>
						<tr></tr>
					</table></div></fieldset>
				</td>
			</tr>
			
			<tr></tr>
			<tr></tr>
			<tr>
				<td align="center" colspan=4>
					<input type="submit" name="search"  title="Press <Enter>" value="Search <Enter>" accesskey="s" onclick="checkField();return false;">
				    <input type="reset" name="clear" title="Press <Alt+c>" tabindex="1" value="Clear <Alt+c>" accesskey="c">
				    <INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
				    
				</td>
				</tr>
		
		  </table>
		  <input  type="hidden" name="hchckall" value="1">
		  <input type="hidden" name="htotalchangeamt" value="">
<input type="hidden" name="htotalordercnt" value="">
<input type="hidden" name="htotalpaidamt" value="">		
 </td>
 </tr>
 
 
 </table>
</form>
<script>
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
</body>


</html>