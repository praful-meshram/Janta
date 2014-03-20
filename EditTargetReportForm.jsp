<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="EditTargetReportForm.jsp" />	
</jsp:include>  --%>


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
    <script type="text/javascript" src="js/jqwidgets/jqxdata.export.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.export.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.aggregates.js"></script>  
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.grouping.js"></script> 

<%@ page errorPage="ReportErrorPage.jsp?page=EditTargetReportForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>


<script src="js/editCustomer_details.js"> </script> 

<script type="text/javascript" src="js/popup.js"></script>
<style>
hr {
color: #f00;
background-color: #f00;
height: 3px;
}
#selected_order{
width: 40%;
max-height: 300px;
border: 1px solid black; 
background-color: #ECFB99;
float: right;
margin-top: 30px;
overflow: auto;
margin-right: 2%;
padding: 5px;
}
</style>
<script>
	
	function checkField(){
		if(document.myform.chckall.checked==true){
			showHint();
		}
		else{		var c_date1,c_date2,u_date2,u_date1;
				if(!($("#createDate2").jqxDateTimeInput('disabled'))){
				c_date1 = $('#createDate1').jqxDateTimeInput('getText');
				c_date2 = $('#createDate2').jqxDateTimeInput('getText');
			}
			
			if(!($("#updateDate2").jqxDateTimeInput('disabled'))){
				u_date1 = $('#updateDate1').jqxDateTimeInput('getText');
				u_date2 = $('#updateDate2').jqxDateTimeInput('getText');
			}	    
		    showHint();		  
	    }
	}
	function showMsg(){
	  	 document.myform.action="HomeForm.jsp";
	   	 document.myform.submit();
	}
	function Clear(){
		
		try{
			document.getElementById("order_number").focus();
		} catch (exp){}
		
		
		
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
		
		document.myform.selmonth.value="";
		
		$("#createDate1").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',max:new Date(),formatString: "yyyy-MM-dd"});
		$("#createDate2").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: "yyyy-MM-dd",value:new Date()});
		$("#createDate2").jqxDateTimeInput({disabled: true});
		
		
		$("#updateDate1").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',max:new Date(),formatString: "yyyy-MM-dd"});
		$("#updateDate2").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: "yyyy-MM-dd",value:new Date()});
		$("#updateDate2").jqxDateTimeInput({disabled: true});
		
		$('#createDate1').on('close', function (event) {
		 // Some code here. 
		 	$("#createDate2").jqxDateTimeInput({disabled: false});
		 	$("#createDate2").jqxDateTimeInput({min: $('#createDate1').jqxDateTimeInput('getDate')});
 		}); 	
 		
 		$('#updateDate1').on('close', function (event) {
		 // Some code here. 
		 	$("#updateDate2").jqxDateTimeInput({disabled: false});
		 	$("#updateDate2").jqxDateTimeInput({min: $('#updateDate1').jqxDateTimeInput('getDate')});
 		}); 	
		
		funEnabled();
	}
	
function ckeckEmpty(){
	if(document.getElementById("order_number").value == ""){
		alert("Please Enter Order Number");
		document.getElementById("order_number").focus();
		return false;
	} else {
		return true;
	}
}


</script>
<%
	String call_type = request.getParameter("call_type");
	if(call_type == null){
		call_type="";
	}
	if(call_type.equals("search_payment")){
		String m="<< Show List";
		%>
			<div id="selected_order">
				<b>Selected orders</b>
				<form action="PrintSelectedCustPayment.jsp" method="get" id="submit_form">
				<table style="width: 100%;border-collapse: collapse;" border=1 id="selected_order_table">
				<tr>
					<th style="width: 20%;">Order Number</th>
					<th style="width: 35%;">Cust Name</th>
					<th style="width: 20%;">Balance</th>
					<th style="width: 25%;">&nbsp;</th>
				</tr>
				</table>
				<table style="width: 100%;" border=1 id="insert_table">
				</table>
				 <input type="text" readonly="readonly" name="order_count" id="order_count_id" size="3" value="0" style="background-color :#ECFB99 ;"/> orders selected to print.
				<input type="submit" onclick=" return printSelectedInformation()" value="Print" style="float: right;"/>
				</form>
			</div>
		<%
	}
if(!call_type.equals("search_payment") || !call_type.equals("communication")){
%>
<center>
<%} %>
<fieldset style="width: 55%;"><legend>
<%
	
	String msg = request.getParameter("msg"); 
	if(call_type.equals("receive_payment")){
		out.print("<h3>Search Customer To Receive Payment</h3>");
	} else if(call_type.equals("search_payment")){
		out.print("<h3>Search Customer To See Pending</h3>");
	}else if(call_type.equals("communication")){
		out.print("<h3>Search Customer To Communicate</h3>");
	}else{
		out.print("<h3>Search Customer</h3>");
	}
	
%>
</legend>
<%
if(call_type.equals("receive_payment")){
	%>
		<input type = "radio" name = "radio" onclick="ChangeCriteria('order')" checked="checked"/>Search By Order Number
		<input type = "radio" name = "radio" onclick="ChangeCriteria('cust')"/>Search By Customer Detail
	<%
}
if(call_type.equals("receive_payment")){
	%>
	<br/><br/>
<form id="myform1" action="SearchCustUsingOrderNo.jsp" method="get">
	<%
	if(msg!=null){
		out.print("<i><font color=red>No Matching Record Found</font></i><br/><br/>");
	} 
	%>
	Enter Order Number :&nbsp;&nbsp;<input type = "text" name = "order_number" value="" id ="order_number" onkeypress="return isNumberKey(event)"/>
	<input type = "submit" value="Search" onclick="return ckeckEmpty();"/>

<br/>
</form>
<form name="myform" method="post" id="myform" style="display: none">
<%}else{ %>
<form name="myform" method="post" id="myform" >
<%} %>
	<table style="width: 100%;">
		<tr style="width: 100%;">
			<td align="center" colspan=3><b><font color="blue">&nbspA</font>ll Customers List &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
			<input type="CheckBox" name="chckall" accesskey="a" onClick="funEnabled();"></td>
		</tr>		
		<tr style="width: 100%;">
			<td colspan=3>
			<div id="div4" style="width: 100%;" >
				<table>				
					<tr>
						<td style="width: 15%;" align="left">
							<b><font color="blue">C</font>ustomer Code</b>
						</td>
						<td style="width: 1%;" align="left">:</td>
						<td style="width: 29%;"><input style="width: 97%;" type="text" name="custCode" accesskey="c"></td>
						<%if(call_type.equals("search_payment") || call_type.equals("communication")){ %>
						<td style="width: 8%;" align="left"></td>
						
						<td style="width: 15%;" align="left">
							<b>O<font color="blue">r</font>der Number</b>
						</td>
						<td style="width: 1%;" align="left">:</td>
						<td style="width: 29%;"><input style="width: 97%;" type="text" name="ordernumber" accesskey="c"></td>
						<%} %>
					</tr>
					<tr>
						<td style="width: 15%;" align="left"><b>Customer <font color="blue">N</font>ame</b></td>
						<td style="width: 1%;" align="left">:</td>
						<td style="width: 29%;"><input style="width: 97%;" type="text" name="custName"  align="right" accesskey="n"></td>
						
						<td style="width: 8%;" align="left"></td>
						
						<td style="width: 15%;" align="left"><b><font color="blue">P</font>hone Number</b></td>
						<td style="width: 1%;" align="left">:</td>
						<td style="width: 29%;"><input style="width: 97%;" type="text" name="phonenumber" size="22" align="right" colspan="2" accesskey="p"></td>
						
					</tr>
					<tr>
						<td style="width: 15%;" align="left"><b>M<font color="blue">o</font>bile Number</b></td>
						<td style="width: 1%;" align="left">:</td>
						<td><input style="width: 97%;" type="text" name="mobilenumber" size="22" align="right" colspan="2" accesskey="o"></td>
						
						<td style="width: 8%;" align="left"></td>
						
						<td style="width: 15%;" align="left"><b>Na<font color="blue">m</font>e String</b></td>
						<td style="width: 1%;" align="left">:</td>
						<td><input style="width: 97%;" style="width: 100%;" type="text" name="nameString" size="22"  align="right" accesskey="m" colspan="2"></td>
					</tr>
					<tr>
						<td style="width: 15%;" align="left"><b><font color="blue">B</font>uilding</b></td>
						<td style="width: 1%;" align="left">:</td>
						<td><input style="width: 97%;" type="text" name="Building" accesskey="b" align="right"></b></td>
						
						<td style="width: 8%;" align="left"></td>
						
						<td style="width: 15%;" align="left"><b>Building <font color="blue">N</font>o.</b></td>
						<td style="width: 1%;" align="left">:</td>
						<td><input style="width: 97%;" type="text" name="Building_no"  size="22"  accesskey="o"></b></td>
					</tr>
					<tr>
					    <td style="width: 15%;" align="left"><b><font color="blue">W</font>ing</b></td>
					    <td style="width: 1%;" align="left">:</td>
					    <td><input style="width: 97%;" type ="text" name="wing" accesskey="w" ></td>
					    
					    <td style="width: 8%;" align="left"></td>
					    
						<td style="width: 15%;" align="left"><b><font color="blue">F</font>lat No.</b></td>
						<td style="width: 1%;" align="left">:</td>
						<td><input style="width: 97%;" type ="text" name="block"  size="22" accesskey="f" align="right">
						</tr>
					<tr>
						<td style="width: 15%;" align="left"><b>Addr<font color="blue">e</font>ss1</b></td>
						<td style="width: 1%;" align="left">:</td>
						<td><input style="width: 97%;" type ="text" accesskey="e" name="add1"></td>
						
						<td style="width: 8%;" align="left"></td>
						
						<td style="width: 15%;" align="left"><b>A<font color="blue">d</font>dress2</b></td>
						<td style="width: 1%;" align="left">:</td>
						<td><input style="width: 97%;" type ="text" accesskey="d" name="add2" size="22"></td>
					</tr>
					<tr >
						<td style="width: 15%;" align="left"><b>A<font color="blue">r</font>ea</b></td>
						<td style="width: 1%;" align="left">:</td>
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
							<SELECT style="width: 97%;" name="area">
								<OPTION VALUE=""> Select Area </OPTION>
						<%
 								while (rs.next()) {
 								name = rs.getString(1);
 						%>
								<OPTION VALUE="<%=name%>"> <%= name%> </OPTION>
						<%
								}
    					%>
							</SELECT>
						</td>	
						
						<td style="width: 8%;" align="left"></td>
			
						<td style="width: 15%;" align="left"><b>Payment Type</b></td>
						<td style="width: 1%;" align="left">:</td>
						<td>
							<SELECT style="width: 97%;" name="payment" align="left">
								<OPTION selected VALUE=""> Select Type </OPTION>
								<OPTION VALUE="NoType"> No Type </OPTION>
						<%
        						ResultSet rs2 = stmt.executeQuery("SELECT payment_type_code, payment_type_desc FROM payment_type");
    							while (rs2.next()){	
						%>	
								<OPTION VALUE="<%=rs2.getString(1)%>"> <%= rs2.getString(2)%> </OPTION>
						<%	
       							}
        						rs2.close();    	
    							stmt.close();
    							conn.close();
							} catch (Exception e) {
   								e.getMessage();
    							e.printStackTrace();    	
							}
						%>
							</SELECT>
						</td>
					</tr>
					<tr>
						<td style="width: 15%;" align="left"><b>Create<font color="blue">D</font>ate</b></td>
						<td style="width: 1%;" align="left">:</td>
						<td>
							<!-- <input type ="text" accesskey="d" name="c_date1" size="15" style="width: 79%;">
							<input type="button" onClick="c1.popup('c_date1');" value="..." style="width: 15%;"/> -->
							<div id='createDate1'></div>
						</td>
							
						<td style="width: 8%;" align="left"></td>
							
						<td style="width: 15%;" align="left"><b>And</b></td>
						<td style="width: 1%;" align="left">:</td>
						<td> 
							<!-- <input type ="text" name="c_date2" size="15" style="width: 79%;">
							<input type="button" onClick="c1.popup('c_date2');" value="..." style="width: 15%;"/> -->
							<div id='createDate2'></div>
							
						</td>
					</tr>
					<tr>
						<td style="width: 15%;" align="left"><b><font color="blue">U</font>pdate Date</b></td>
						<td style="width: 1%;" align="left">:</td>
						<td>
							<!-- <input type ="text" accesskey="u" name="u_date1" size="15" style="width: 79%;"/>
							<input type="button" onClick="c1.popup('u_date1');" value="..." style="width: 15%;"/> -->
							<div id="updateDate1"></div>
						</td>
							
						<td style="width: 8%;" align="left"></td>
							
						<td style="width: 15%;" align="left"><b>And</b></td>
						<td style="width: 1%;" align="left">:</td>
						<td> 
							<!-- <input type ="text" name="u_date2" size="15" style="width: 79%;"/>
							<input type="button" onClick="c1.popup('u_date2');" value="..." style="width: 15%;"/> -->
							<div id='updateDate2'></div>
						</td>
					</tr>
					<tr>
					<td style="width: 15%;" align="left"><b><font color="blue">S</font>tation</b></td>
					<td style="width: 1%;" align="left">:</td>
					<td><input style="width: 97%;" type ="text"  size="22" accesskey="d" name="station"></td>
						
					<td style="width: 8%;" align="left"></td>
						
					<td style="width: 15%;" align="left"><b>Last Order Days</b></td>
					<td style="width: 1%;" align="left">:</td>
					<td><input style="width: 97%;" type="text" name="selmonth"/></td></tr>
				</table></div>
			</td>
		</tr>
			
		<tr>
			<td align="center" colspan=4>
				<input type="submit" name="search"  title="Press <Enter>" value="Search <Enter>" accesskey="s" onclick="checkField();return false;"/>
				<input type="reset" name="clear" title="Press <Alt+c>" tabindex="1" value="Clear <Alt+c>" accesskey="c" onclick="document.getElementById('txtHint').innerHTML='';"/>
				<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"/></center>
			</td>
		</tr>
	</table>
	</fieldset>
	<input  type="hidden" name="hchckall" value="1">
	<input type="hidden" name="call_type" value="<%= call_type %>"/>
<script>
function funEnabled(){
	    if (document.myform.chckall.checked==true){
			document.getElementById('div4').style.visibility="hidden";
			document.myform.hchckall.value=1;		
			$("#createDate2").jqxDateTimeInput({disabled: true});
			$("#updateDate2").jqxDateTimeInput({disabled: true});
			
		}
		else{
			document.getElementById('div4').style.visibility="visible";
			document.myform.hchckall.value=0;			
		}
	}
window.onload =Clear;

function ChangeCriteria(str){
	if(str == "cust"){
		document.getElementById("myform").style.display='block';
		document.getElementById("myform1").style.display='none';
	}else if(str == "order"){
		document.getElementById("myform").style.display='none';
		document.getElementById("myform1").style.display='block';
		document.getElementById("txtHint").innerHTML="";
		document.getElementById("order_number").focus();
		document.getElementById("order_number").value="";
	}
}
function isNumberKey(evt) {
	var charCode = (evt.which) ? evt.which : event.keyCode;
	if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
		return false;
	else
		return true;
}
</script>
	<hr><center><div id="txtHint" class="ddm1" style="background-color: white;width: 100%;max-height: 400px;overflow: auto;"></div></center>
	<br><br>
	<p><h1><center><div id="waitMessage"  style="cursor: sw-resize;"></center></div></h1></p>
<% 
	String fromFromName="";
	if(request.getParameter("fromForm")!=null)
		fromFromName=request.getParameter("fromForm");
	//CustPmtHstry
%>
	<input type="hidden" name="fromForm" value="<%= fromFromName %>">
</form>

<div id="dispdiv" align="center" style="border:1px solid black; padding:25px; text-align:center; display:none; background-color:#FFF; overflow:auto; height:300px; width=200px;"> </div>
</body>
</html>
