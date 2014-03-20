<%@ page contentType="text/html"%>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="editAreaForm.jsp" />	
</jsp:include> --%>
<%@ page errorPage="ErrorPage.jsp?page=editAreaForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<%
		String str="";
	  	str=request.getParameter("code");
		String str1="";
	  	str1=request.getParameter("area");
	  	String str2="";
	  	str2=request.getParameter("desc");
%>
<script type="text/javascript">
<%
		String str3="";
	    str3=request.getParameter("Exp");
%>
	var jExp=<%=str3%>
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
			     alert("before");
				document.myform.action="EditArea.jsp";
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
	
	function Warn(){
		alert("U  Can't Change The Customer Code");
	}
</script>
<center><h3>Edit Area</h3></center>
<form name="myform" method="post">
	<table border="0" align="center">
		<tr>
			
		</tr>
		<tr>
			<td><b>Area Name</b></td><td><input type="text" name="area" value="<%=str1%>" align="right"></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr></tr>

		<tr>
			<td><b>Description</b></td><td><input type="text" name="desc" value="<%=str2%>" align="right"></td>
		
		</tr>
	</table><br><br>
	<center><input type="submit" name="Submit" value="Submit <Alt+s>" accesskey="s" disabled onClick="checkField();return false;">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
	<input type="hidden" name="hcode" value="<%=str%>">
</form>
<script type="text/javascript">
      	document.myform.area.focus();
      	function check(){
    	document.myform.Submit.disabled=false;
	}
	document.onkeyup = check;
</script>
<center>
</body>
</html>