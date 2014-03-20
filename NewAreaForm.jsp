<%@ page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="NewAreaForm.jsp" />	
</jsp:include> --%>


<%@ page errorPage="ErrorPage.jsp?page=NewAreaForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>




<script type="text/javascript">
<%
		String str1="";
	    str1=request.getParameter("Exp");
%>
	var jExp=<%=str1%>
	if(jExp==1){
		alert("Area Name already exists !!!");
	}
	
	function checkField(){
		var area1=document.myform.area.value;
		if(area1=="") {
				alert("Please Select Area");
				document.myform.area.focus();
				return false;
		}
		else {		
			var ans=confirm("Do you want to create this Area?");
			if (ans==true){
			    
				document.myform.action="NewArea.jsp";
				document.myform.submit();
			}
			else
			 {
			  window.refresh; 
			 }			
		}	
	}	
	function showMsg(){
	  	 document.myform.action="HomeForm.jsp";
	   	 document.myform.submit();
	}
</script>
<center><h3>Create a New Area</h3></center>
<form name="myform" method="post">
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
	</table><br><br>
	<center><input type="submit" name="Save" value="Save <Alt+s>" accesskey="s" onClick="checkField();return false;">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
</form>
<script type="text/javascript">
      	document.myform.area.focus();
</script>
<center>
</body>
</html>