<%@page contentType="text/html"%>
<%@ page import="java.text.*" %>

<jsp:include page="header.jsp" />
<jsp:include page="leftsidemenu.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="RDeliveryStaffForm.jsp" />	
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
 
 
 
 
<%@ page errorPage="ReportErrorPage.jsp?page=RDeliveryStaffForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<script language="javascript" src="js/codethatcalendarstd.js"></script>
<script>
	
		
	
	function checkField(){
		
		var c_date1 = $('#range1').jqxDateTimeInput('getText');
		var c_date2 = $('#range2').jqxDateTimeInput('getText');
		
		var url = "";
		if(!($("#range2").jqxDateTimeInput('disabled')))
			url = "&c_date1="+c_date1+"&c_date2="+c_date2;
		
	   if(document.myform.chckall.checked)		
	   		document.myform.chckall.value=1;
	  	else
	  		document.myform.chckall.value=0;
	  		document.myform.action="RDeliveryStaff.jsp?Exp=0"+url;
	 //  alert(document.myform.action);
	   document.myform.submit();
	    
	}
</script>
<%

	
	order.ManageOrder mo;
	//mo = new order.ManageOrder("jdbc/js");
	mo = new order.ManageOrder("jdbc/re");
	mo.getDeliveryStaffList();
	String code="",desc="";
%>

<form method="post" name="myform">
<td width="50%">
	<h3><center>Delivery Staff Reports </center></h3>
	
	<center><b><font color="blue">&nbspA</font>ll &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="CheckBox" name="chckall" checked onClick="funEnabled();"></center>
	<br><br>
	<div id="div4" style="VISIBILITY:hidden" >		
		<table border="0" align="center">	
		<tr>	
				<td></td>
				<td align="center"><b><font size=2 color="red">Delivery Person :</b></font></td>
				<td>
			<SELECT name="d_staff" >
				<OPTION VALUE='select' >Select staff
<% 	
	        while (mo.rs1.next()) {
		 		code = mo.rs1.getString(1);
		 		desc = mo.rs1.getString(2);
%>
				<OPTION VALUE="<%= code%>" ><%= desc%>
<% 	
			}		
%>		
		</td></tr>
				<tr></tr>
				<tr></tr>
				<tr>
					<td colspan=4><fieldset><legend>Range</legend><table align="center">					
					<tr></tr>
					<tr></tr>
					<tr>
							<!-- <td><b>From<font color="blue">D</font>ate</b></td><td><input type ="text" accesskey="d" name="c_date1" size="10"><input type="button" onClick="c1.popup('c_date1');" value="..."/></td><td><font color="blue"> T</font>oDate</td><td> <input type ="text" name="c_date2"  size="10"><input type="button" onClick="c1.popup('c_date2');" value="..."/></td> -->
							<td><b>From<font color="blue">D</font>ate</b></td><td><div id=range1></div></td><td><font color="blue"> T</font>oDate</td><td><div id="range2"></div></td><tr>
					<tr></tr>
					<tr></tr>
					</table></fieldset></td>
				</tr>
		</table></div>

<br>
	<input  type="hidden" name="hchckall" value="1">
	<center><input type="submit" name="Summary" value="Summary <Alt+s>" accesskey="s" onclick="checkField();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>" onclick="document.getElementById('txtHint').innerHTML='';">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();">
	
	</td></tr></table>		
</form>
<script>
	function showMsg(){
		 	 document.myform.action="HomeForm.jsp";
			 document.myform.submit();
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
	
	window.onload=Clear;
		
		function Clear(){			
			document.myform.chckall.checked=true;		
			document.myform.hchckall.value="1";
			
				// create date
		$("#range1").jqxDateTimeInput({theme:'ui-redmond', width: '250px', height: '25px',max:new Date(),formatString: "yyyy-MM-dd"});
		$("#range2").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: "yyyy-MM-dd",value:new Date()});
		
		
		$("#range2").jqxDateTimeInput({disabled: true})
		
		$('#range1').on('close', function (event) {
		 // Some code here. 
		 	$("#range2").jqxDateTimeInput({disabled: false});
		 	$("#range2").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});
 		}); 
 				
		}
</script>
</body>
</html>