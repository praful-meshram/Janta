<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="NewItemGroupForm.jsp" />	
</jsp:include>

 --%>
 <%@ page errorPage="ErrorPage.jsp?page=NewItemGroupForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<script>
	<%
			String str1="";
		    str1=request.getParameter("Exp");
	%>
	var jExp=<%=str1%>
	if(jExp==1){
		alert("Item Group already exists !!!");
	}
	function CheckField(){
		var ig_desc =document.myform.ig_desc.value;
		if(ig_desc=="") {
				alert("Please Enter the Item Group");
				document.myform.ig_desc.focus();
				return false;
		}
		var ig_number =document.myform.ig_number.value;
		if(isNaN(ig_number)) {
				alert("Please Enter a number in  Item Group Number field.");
				document.myform.ig_number.focus();
				return false;
		}
		var ans=confirm("Do you want to create this Item Group?");
			if (ans==true){			    
				document.myform.action="NewItemGroup.jsp";
				document.myform.submit();
			}
			else{
			  window.refresh; 
			}	
	}
</script> 
<form method="post" name="myform">
	<h3><center>Create New Item Group </center></h3>
<table border="0" align="center">
		<tr>
			<td><b>Item Group&nbsp&nbsp&nbsp</b></td><td><input type="text" name="ig_desc"></td>
		</tr>
		<tr>
			<td><b>Item Group Number&nbsp&nbsp&nbsp</b></td><td><input type="text" name="ig_number" value="0"></td>
		</tr>
		<tr>
			<td><b>FMCG&nbsp&nbsp&nbsp</b></td><td><input type="checkbox" name="fmcg_flag" onclick="SetFlag();"></td>
		</tr>
</table>

<br>
	<input type="hidden" name="hfmcg_flag" value="0">
	<center><input type="submit" name="Submit" value="Save<Alt+s>" accesskey="s" onclick="CheckField();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();">
		
</form>
<script>
	function showMsg(){
		 	 document.myform.action="HomeForm.jsp";
			 document.myform.submit();
    }
  	function SetFlag(){
  		if(document.myform.fmcg_flag.checked==true){
  			document.myform.hfmcg_flag.value=1;  		
  		}
  		else{
  			document.myform.hfmcg_flag.value=0;
  			alert(document.myform.hfmcg_flag.value);
  		}
  	}
</script>
</body>
</html>