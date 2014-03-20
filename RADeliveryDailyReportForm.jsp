<jsp:include page="header.jsp" />
<%--  	<jsp:include page="sessionBoth.jsp">	
   		<jsp:param name="formName" value="RADeliveryDailyReportForm.jsp" />	
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
	
 
 
 <%@ page errorPage="ReportErrorPage.jsp?page=RADeliveryDailyReportForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<%
String userTypeCode=session.getAttribute("user_type_code").toString();
%>	

<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%	
	if(!userTypeCode.equals("3")){
%>
<jsp:include page="leftsidemenu.jsp" />
<%}%>


<style>
hr {
color: #f00;
background-color: #f00;
height: 3px;
}
</style>

<script language="javascript" src="js/codethatcalendarstd.js"></script>
<script>
var flag=true;
	
	function checkField(){
		var c_date1 = $('#range1').jqxDateTimeInput('getText');
		var c_date2 =  $('#range2').jqxDateTimeInput('getText');		
		
		var url = "&c_date1="+c_date1+"&c_date2="+c_date2;    
	   if (flag==false){
	       //document.myform.action="RCollectionDailyReport.jsp?Exp=0";
	       document.myform.action="RADeliveryDailyReport.jsp?Exp=0";
	       
	       if(document.myform.hchckall.value!=1){
	     		document.myform.action+=url;	
	       	}
	    	
 		}
 		else{
 			document.myform.action="RADeliveryDailyReportSummary.jsp?Exp=0";
 			 if(document.myform.hchckall.value!=1){
	       		document.myform.action+=url;		
	       	}
 			
 		}
 		
 	//	alert(document.myform.action);
 		document.myform.submit();
	}
	
	
</script>
<form method="post" name="myform" >
<td width="50%">
	<h3><center>Daily Reports </center></h3>
	
	<center><b><font color="blue">&nbspA</font>ll &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="CheckBox" name="chckall" checked onClick="funEnabled();"></center>
	<br><br>
	<div id="div4" style="VISIBILITY:hidden" align="center">		
		<table border="0" align="center">		
				<tr></tr>
				<tr></tr>
				<tr>
					<td colspan=4><fieldset><legend>Range</legend><table align="center">					
					<tr></tr>
					<tr></tr>
					<tr></tr>
					<tr></tr>
					<tr>
							<td><b>From<font color="blue">D</font>ate</b></td><td>
							<!-- <input type ="text" accesskey="d" name="c_date1" size="10"><input type="button" onClick="c1.popup('c_date1');" value="..."/> -->
							<div id="range1"></div>
							</td>
							
							<td><font color="blue"> T</font>oDate</td><td> 
							<!-- <input type ="text" name="c_date2"  size="10"><input type="button" onClick="c1.popup('c_date2');" value="..."/> -->
							<div id="range2"></div> </td>
						</tr>
						<tr></tr>
					<tr></tr>
						
					</table></fieldset></td>
				</tr>
		</table></div>

<br>
	<input  type="hidden" name="hchckall" value="1">	
	<center><input type="submit" name="Submit" value="Summary <Alt+s>" accesskey="s" onclick="checkField();return false;">
	
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>" onclick="document.getElementById('txtHint').innerHTML='';">
<!--	<br><br><center><input type="button" name="Details" value="Details <Alt+d>" accesskey="s" onclick="flag=false;checkField();return false;">	-->
	
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
			
			//document.myform.c_date1.value= "";
			//document.myform.c_date2.value="";	
						
		}
		else{
			document.getElementById('div4').style.visibility="visible";
			document.myform.hchckall.value=0;	
			var newdate = new Date();
	
	//	document.myform.c_date1.value= newdate;
	//	document.myform.c_date2.value="";
	//	document.myform.c_date2.value=newdate;		
	
			
			
		}
	}
	
	window.onload=Clear;
		
		function Clear(){	
		document.myform.chckall.checked=true;
		document.myform.hchckall.value=1;
		
		//document.myform.c_date1.value= "";
		//document.myform.c_date2.value="";		
		
		
		$("#range1").jqxDateTimeInput({theme:'ui-redmond', width: '250px', height: '25px',max:new Date(),formatString: "yyyy-MM-dd"});
		$("#range2").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: "yyyy-MM-dd",value:new Date()});
		
		
		//$("#range2").jqxDateTimeInput({disabled: true});
		$('#range1').on('close', function (event) {
		 // Some code here. 
		 	$("#range2").jqxDateTimeInput({disabled: false});
		 	$("#range2").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});
 		}); 
					
						
		}
</script>
</body>
</html>