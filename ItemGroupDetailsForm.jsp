<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="ItemGroupDetailsForm.jsp" />	
</jsp:include>
 --%>
 
 
 
<%@ page errorPage="ErrorPage.jsp?page=ItemGroupDetailsForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/DataTable/jquery.js" type="text/javascript"></script>
<script src="js/DataTable/jquery.dataTables.js" type="text/javascript"></script>

<script src="js/itemGroupDetails.js"> </script>    
<style>
hr {
color: #f00;
background-color: #f00;
height: 3px;
}
#txtHint{
	background-color: transparent;
}
</style>

<form method="post" name="myform" method="post">
	<h3><center>Item Group Details </center></h3>
	
	<center><b><font color="blue">&nbspA</font>ll &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="CheckBox" name="chckall" checked onClick="funEnabled();"></center>
	<br><br>
	<div id="div4" style="VISIBILITY:hidden" >		
		<table border="0" align="center">		
				<tr>
				    <td><b>Item Group Code&nbsp&nbsp&nbsp</b></td><td><input type="text" name="ig_code" >
				</tr>
				<tr>
					<td><b>Item Group&nbsp&nbsp&nbsp</b></td><td><input type="text" name="ig_desc"></td>
				</tr>
				<tr>
					<td><b>Item Group Number&nbsp&nbsp&nbsp</b></td><td><input type="text" name="ig_number" ></td>
				</tr>
		</table></div>

<br>
	<input  type="hidden" name="hchckall" value="1">
	<center><input type="submit" name="Submit" value="Search <Alt+s>" accesskey="s" onclick="showHint();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>" onclick="document.getElementById('txtHint').innerHTML='';">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();">
	
	<br><br><hr>Suggestions: <div id="txtHint" class="ddm1"></div>
	<p><h1><center><div id="waitMessage"  style="cursor: sw-resize"></center></div></h1></p>
	
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
		}
</script>
</body>
</html>