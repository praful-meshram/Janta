<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<jsp:include page="leftsidemenu.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="RDailyModificationForm.jsp" />	
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
    <script type="text/javascript" src="js/jqwidgets/jqxdata.export.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.export.js"></script> 
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.aggregates.js"></script>  
    <script type="text/javascript" src="js/jqwidgets/jqxgrid.grouping.js"></script>	
<%@ page errorPage="ErrorPage.jsp?page=RDailyModificationForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 




<form name="myform" method="post">
<TD  align="center" width="50%">
 <table>
  <tr>
	<td align=left><b><font color="blue">D</font>ate</b></td><td align=left>
	<div id='range1'></div> <INPUT type="hidden" name="Date" size=11> </TD>
  </tr>
 
 </table>
 <br><br>
	
	<center><input type="button" name="search"  title="Press <Enter>" value="Search <Enter>" accesskey="s" onclick="checkField();return false;">
	<input type="reset" name="clear" title="Press <Alt+r>" tabindex="1" value="Clear  <Alt+r>  " accesskey="r" >
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
</TD>
</TR>
</TABLE>	
	
</form>
<script>
	window.onload =loadToday;	
	function loadToday(){
		var flag=true;
		$("#range1").jqxDateTimeInput({theme:'ui-redmond', width: '250px', height: '25px',max:new Date(),formatString: "yyyy-MM-dd"});
		document.myform.Date.value= $('#range1').jqxDateTimeInput('getText');	
		$("#range1").jqxDateTimeInput({readonly: true});
	}
	
	function checkField(){
		//alert($('#range1').jqxDateTimeInput('getText'));
		
 		document.myform.Date.value= $('#range1').jqxDateTimeInput('getText');	
 		document.myform.action="RDailyModification.jsp" 						
		document.myform.submit();
 		
	}
	function showMsg(){
	  	 document.myform.action="HomeForm.jsp";
	   	 document.myform.submit();
	}
</script>
</body>
</html>
