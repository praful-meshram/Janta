<%@ page import="java.io.*" %>
<jsp:include page="header.jsp" /> 
<%@page contentType="text/html"%>
<%@ page import="java.text.*" %>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="SettelCommissionForm.jsp" />	
</jsp:include>
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=SettelCommissionForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
  
<%
DecimalFormat df = new DecimalFormat("###,###.00");
		String d_staffcode="";
	  	d_staffcode=request.getParameter("d_staffcode");
	  	String d_staffname="";
	  	d_staffname=request.getParameter("d_staffname");
	  	String totOrders="";
	  	totOrders=request.getParameter("totOrders");	  	
	  	float totEarned=0.0f;
	  	totEarned=Float.valueOf(request.getParameter("totEarned")).floatValue();	  	
	  	float totPaid=0.0f;
	  	totPaid=Float.valueOf(request.getParameter("totPaid")).floatValue();	  
	  	float balance=0.0f;
	  	balance=Float.valueOf(request.getParameter("balance")).floatValue();
	  
	  	float lastpaid=0.0f;
	  	lastpaid=Float.valueOf(request.getParameter("lastpaid")).floatValue();
%>  
		
<script type="text/javascript">
	
	function checkField(){
	
		
		var payamt=document.myform.payamt.value;
		var balance=document.myform.balance.value;
					
		var name =document.myform.name.value;
		if(isNaN(payamt)) {
				alert("Please Enter a number in Pay Amount field");	
				document.myform.payamt.focus();			
		}
		else if(payamt=="") {
				alert("Please Enter Pay Amount");
				document.myform.payamt.focus();					
		}
		else if(payamt==0) {
				alert("Please Enter Pay Amount Greater than 0");
				document.myform.payamt.focus();					
		}
		else if(parseFloat(payamt) > parseFloat(balance)) {
		
				alert("Please enter Pay Amount less than Balance");
				document.myform.payamt.focus();					
		}
		else {
				
			var ans=confirm("Do you really want to pay ("+ payamt +") to  "+name);
		 	if (ans==true){
		  		document.myform.action="SettelCommissions.jsp";
			    document.myform.submit();
		 	}
		 	else {
		  		document.myform.action="HomeForm.jsp"; 	    
		 	}	
	 	}
	}
	
	function showMsg(){
		document.myform.action="HomeForm.jsp";
	 	document.myform.submit();
	 }
	 
	function Warn(){
		alert("U  Can't Change The Staff Name & Balance");
	}
</script>
<center><h3>Commissions</h3></center>
<form name="myform">
	<table border="0" align="center">
		<tr>
		    <td><b><font size="2">Staff Name </b></td><td> : <font size="2"><%=d_staffname%></td>
		</tr>
		<tr>    
			<td><b><font size="2">Total Orders</b></td><td><font size="2"> : <%=totOrders%></td>
		</tr>
		<tr>    
			<td><b><font size="2">Total Earned</b></td><td><font size="2"> : <%=totEarned%></td>
		</tr>
		<tr>    
			<td><b><font size="2">Total Paid</b></td><td><font size="2"> : <%=totPaid%></td>
		</tr>
		<tr>    
			<td><b><font size="2">Balance</b></td><td><font size="2"> : <%=balance%></td>
		</tr>
		<tr>
			<td ><b><font size="2">Pay Amount</b></td><td> : <input type="number" name="payamt" size="10"  align="right" value=""></b></td>
		</tr>
			
	</table> <br><br><br>
	<center><input type="hidden" name="d_code" value="<%=d_staffcode%>">
	<input type="submit" name="Submit" value="Submit <Alt+s>" accesskey="s"  disabled  onClick="checkField(); return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
	<INPUT type="button" value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
	<input type="hidden" name="balance" value="<%=balance%>">
	<input type="hidden" name="d_code" value="<%=d_staffcode%>">
	<input type="hidden" name="name" value="<%=d_staffname%>">
</form>

<script type="text/javascript">
		document.myform.payamt.focus();		
	function check(){
    	document.myform.Submit.disabled=false;
	}
	document.onkeyup = check;
</script>
</body>
</html>