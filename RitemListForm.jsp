<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="RitemListForm.jsp" />	
</jsp:include>
 --%>
 
<%@ page errorPage="ReportErrorPage.jsp?page=RitemListForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<jsp:include page="leftsidemenu.jsp" />
 <script>	
	function showMsg(){
	  	 document.myform.action="HomeForm.jsp";
	   	 document.myform.submit();
	}
	
	function Clear(){
		document.myform.chckall.checked= true;
		document.myform.i_code.value="";
		document.myform.ig_code.value="";
		document.myform.i_mrp1.value="";
		document.myform.i_mrp2.value="";
		document.myform.i_rate1.value="";
		document.myform.i_rate2.value="";
	}
</script>
<form name="myform" method="post" action="RitemList.jsp?Exp=0">	
 	<td  width="50%">	
	<table align="center">
	<tr></tr>
		<tr></tr>
		<tr></tr>
		<tr>
			<td align="center" colspan=3><b><font color="blue">&nbspA</font>ll Items List &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="CheckBox" name="chckall" checked onClick="funEnabled();"></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr></tr>
		
		<tr>
		<td>				
			<div id="div4" style="VISIBILITY:hidden" >
			<center><h4>Please Enter Item Details to Search</h2></center>
			<table>		
				<tr>
				    <td><b>Item Code&nbsp&nbsp&nbsp</b></td><td><input type="text" name="i_code" >
					<td><b>Item Group&nbsp&nbsp&nbsp</b></td><td><input type="text" name="ig_code"></td>
				</tr>
				<tr></tr>
				<tr >	
					<td><b>Item Name</b></td><td colspan="3"><input type="text" name="i_name" size="65" ></td>
					
				</tr>
				<tr></tr>
		 		<tr>
		 			<td colspan="4">
		 			<fieldset><legend><font color="blue"><b>Prices</b></font></legend>
		  			<table align="center">
				  		<tr>
				  			<td><b>Item MRP [Rs.]</b><input type="text" name="i_mrp1" size="10"></td>				  			
				  			<td><b>And</b></td>				  			
				  			<td><input type="text" name="i_mrp2" size="10"></td>
				  		
				  		</tr>
				  		<tr></tr>
				  		<tr></tr>
				  		<tr>
				  			<td><b>Item Rate [Rs.]</b><input type="text" name="i_rate1" size="10"></td>				  			
				  			<td><b>And</b></td>				  			
				  			<td><input type="text" name="i_rate2" size="10"></td>
				  		</tr>
				  	</table>
				  	</fieldset>
		 	</table></div>
		 </td>
		 </tr>
		 </table>
		  	<br>
			<center><input type="submit" name="Submit" value="Search <Alt+s>" accesskey="s" >
			<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
			 <input  type="hidden" name="hchckall" value="1">
			 <input type="hidden" name="htotalchangeamt" value="">
<input type="hidden" name="htotalordercnt" value="">
<input type="hidden" name="htotalpaidamt" value="">		
</form>
<script>
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
window.onload =Clear;
</script>
</body>
</html>
