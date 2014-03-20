<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="RCollectionMonthlyReportForm.jsp" />	
</jsp:include>
 --%>
<%@ page errorPage="ReportErrorPage.jsp?page=RCollectionMonthlyReportForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<jsp:include page="leftsidemenu.jsp" />
  
<style>
hr {
color: #f00;
background-color: #f00;
height: 3px;
}
</style>
<script>
	function checkField(){
		
		var selMonth= document.myform.selMonth.value;
		
		if(document.myform.chckall.checked==false && selMonth == ""){
			alert("Select the month");
			document.myform.selMonth.focus();
			
			return false;
		}
		document.myform.action="RCollectionMonthlyReport.jsp?Exp=0";
	   	document.myform.submit();
	    
	}
</script>
<form method="post" name="myform" action="SaveItemPurchaseDetails.jsp">
<td width="50%">
	<h3><center>Monthly Reports </center></h3>
	
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
							<td><b>Select <font color="blue">M</font>onth</b></td>
							<td> <SELECT name="selMonth">
							<OPTION VALUE=""> Select
<%					
					String months[] = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
       /*{"Jan", "Feb", "Mar", "Apr", "May", "Jun", 
        "July", "Aug", "Sep", "Oct", "Nov", "Dec"};*/
        

   //use the length attribute to get the number
   //of elements in an array
   for(int i = 0; i < months.length; i++ ) {
      
 

%>
					<OPTION VALUE="<%=months[i]%>"> <%=months[i]%>
<%}%>
					</td>
						</tr>
						<tr></tr>
					<tr></tr>
						
					</table></fieldset></td>
				</tr>
		</table></div>

<br>
	<input  type="hidden" name="hchckall" value="1">
	<center><input type="submit" name="Submit" value="Search <Alt+s>" accesskey="s" onclick="checkField();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>" onclick="document.getElementById('txtHint').innerHTML='';">
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
		}
		else{
			document.getElementById('div4').style.visibility="visible";
			document.myform.hchckall.value=0;			
		}
	}
	
	window.onload=Clear;
		
		function Clear(){			
			document.myform.chckall.checked=true;	
			document.myform.hchckall.value="1";				
		}
</script>
</body>
</html>