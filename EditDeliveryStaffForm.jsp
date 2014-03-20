<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<jsp:include page="header.jsp" />
    
<!-- 
	<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="EditDeliveryStaffForm.jsp" />	
</jsp:include> 
 -->


<%@ page errorPage="ErrorPage.jsp?page=EditDeliveryStaffForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<script language="javascript" src="js/codethatcalendarstd.js"></script
<script language="javascript" src="js/date_validation.js"></script>
<script>
<%
		String str1="";
	    str1=request.getParameter("Exp");
	    
	    String dsCode="";
    	String dsName="";
    	String stDate="";
    	String dsBalance="";    	

		dsCode=request.getParameter("dsCode");
		dsName=request.getParameter("dsName"); 
		stDate=request.getParameter("stDate");		
		dsBalance=request.getParameter("dsBalance");
		
%>
	var jExp=<%=str1%>	
		
	function showMsg(){
		 	 document.myform.action="HomeForm.jsp";
			 document.myform.submit();
    }
	
	
	if(jExp==1){
		alert("Member Name already exists !!!");
	}
	function Warn(){
		alert("U  Can't Change The Customer Code");
	}
	function checkField(){
		var dsName= document.myform.dsName.value;
		if(dsName==""){
			alert("Enter Name");
			document.myform.dsName.focus();
			return false;
		}
		document.myform.action="EditDeliveryStaff.jsp";
		document.myform.submit();
	}
</script>
<p>
<form method="post" name="myform" >
	    <br><br>
		<center><h3> New Staff Member Creation</h3></center>
	 	<br>
	 	<table align="center">
		 	<tr>
			    <td><b>Delivery Staff Member Code</b></td><td><input type="text"  name="dsCode"  align="right"  readonly value="<%=dsCode%>"  onClick="Warn();"></td>
			</tr>
	 	    <tr>
			     <td><b><font color="blue">S</font>taff Member Name </td>
			     <td><input name="dsName" id="dsName"  type="text" maxlength="20" value="<%=dsName%>" accesskey="s"><br></td>
			</tr>
			<tr></tr>
			<tr>
			<td ><b><font color="blue">S</font>tart Date</b></td><td align=left><INPUT type="text" readonly name="stDate" size=15 value="<%=stDate%>"> </TD>
			</tr>	
			<tr></tr>
			    <tr>
					<td><b><font color="blue">B</font>alance to Pay</td>
				   	<td><input name="dsBalance" readonly type="text"  value="<%=dsBalance%>" accesskey="b" size="15"></td>
				</tr>
				<tr></tr>
			</table><br><br>			
			<center><input type="submit" name="Submit"  title="Press <Enter>" value="Save <Enter>" accesskey="s" onclick="checkField();return false;">
			<input type="reset" name="clear" title="Press <Alt+r>" tabindex="1" value="Clear  <Alt+r>  " accesskey="r" >
			<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
			
</form>   
<script>
	
	function check(){
    	document.myform.Submit.disabled=false;
	}
	document.onkeyup = check;
</script>
</body>

</html>
