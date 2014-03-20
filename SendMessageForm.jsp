<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<jsp:include page="header.jsp" />

<%@ page errorPage="ErrorPage.jsp?page=SendMessageForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<jsp:include page="sessionBoth.jsp?formName=SendMessageForm.jsp"/> 
<script>
	<%
			String str1="";
		    str1=request.getParameter("Exp");
	%>
	var jExp=<%=str1%>
	if(jExp==1){
		alert("Error !!!");
	}
	function CheckField(){
		var ph_no =document.myform.ph_no.value;
		if(ph_no=="") {
				alert("Please Enter the Phone Number");
				document.myform.ph_no.focus();
				return false;
		}
		var ans=confirm("Do you want to send this sms");
			if (ans==true){			    
				document.myform.action="SendMessage.jsp";
				document.myform.submit();
			}
			else{
			  window.refresh; 
			}	
	}
</script> 
<form method="post" name="myform">
	<h3><center>Send SMS </center></h3>
<table border="0" align="center">
		<tr>
			<td><b>Phone Number&nbsp&nbsp&nbsp</b></td><td><input type="text" name="ph_no"></td>
		</tr>
		<tr>
			<td><b>SMS&nbsp&nbsp&nbsp</b></td><td><input type="text" name="msg" ></td>
		</tr>
</table>

<br>
	

	<center><input type="submit" name="Submit" value="Send<Alt+s>" accesskey="s" onclick="CheckField();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();">
		
</form>
<script>
	function showMsg(){
		 	 document.myform.action="HomeForm.jsp";
			 document.myform.submit();
    }
  	

</script>
</body>
</html>