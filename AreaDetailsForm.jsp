<%@page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="AreaDetailsForm.jsp" />	
</jsp:include> --%>
<script src="js/editAreaDetails.js">
 </script>
 <style>
hr {
color: #f00;
background-color: #f00;
height: 3px;
}

</style>

<%@ page errorPage="ErrorPage.jsp?page=AreaDetailsForm.jsp" %>	
	
	<%
	session.getAttribute("UserName").toString();
	System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
		
	%>	

 <center><h3> Area Details </h3></center>
<form name="myform" method="post">

	<center><b><font color="blue">&nbsp;A</font>ll &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="CheckBox" name="chckall" checked onClick="funEnabled();"></center>
	<br><br>
	<div id="div4" style="VISIBILITY:hidden" >	
	<table border="0" align="center">
		<tr>
			<td><b>Area Name</b></td><td><input type="text" name="area"  align="right"></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr></tr>

		<tr>
			<td><b>Description</b></td><td><input type="text" name="desc"  align="right"></td>
		
		</tr>
	</table></div><br><br> 
	<center><input type="submit" name="search"  title="Press <Enter>" value="Search <Enter>" accesskey="s" onclick="showHint();return false;">
	<input type="reset" name="clear" title="Press <Alt+c>" tabindex="1" value="Clear <Alt+c>" accesskey="c" onclick="document.getElementById('txtHint').innerHTML='';">
	<INPUT type=BUTTON value="Cancel <Alt+s>" accesskey="s" onClick="showMsg();">
	<input  type="hidden" name="hchckall" value="1">
	<hr><p>Suggestions: <div id="txtHint" class="ddm1"></div></p>
	<br><br>
	<p><h1><center><div id="waitMessage"  style="cursor: sw-resize"></center></div></h1></p>
</form>
<script type="text/javascript">
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
	