<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="ItemDetailsForm.jsp" />	
</jsp:include>
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=ItemDetailsForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/DataTable/jquery.js" type="text/javascript"></script>
<script src="js/DataTable/jquery.dataTables.js" type="text/javascript"></script>
 
<script src="js/editItem_details.js">
</script> 

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
<fieldset style="width: 45%;">
<legend><h3>Please Enter Item Details to Search</h3></legend>
<form name="myform"  class="ddm1" method="post">
<%
	String flag=request.getParameter("flag");
%>	
 	<table border="0" align="center">
 		<tr>
		    <td style="width: 28%;" align="left"><b>Item <Font color="blue">B</font>arcode</b></td>
		    <td style="width: 1%;" align="left">:</td>
		    <td style="width: 40%;" align="left"><input type="text" accesskey=b" name="i_barcode" align="left"></td>
		</tr>
		<tr>
		    <td style="width: 28%;" align="left"><b>Item <Font color="blue">C</font>ode</b>
		    <td style="width: 1%;" align="left">:</td>
		    <td style="width: 37%;" align="left"><input type="text" accesskey="c" name="i_code" size="22" align="right" colspan="2" style="width:84%;"></td>
			<td style="width: 28%;" align="left"><b>Item <Font color="blue">G</font>roup</b></td>
			<td style="width: 1%;" align="left">:</td>
		    <td style="width: 35%;" align="left"><input type="text" accesskey="g" name="ig_code" size="22" align="right" colspan="2"></td>
		</tr>
		<tr></tr>
		<tr >	
			<td style="width: 28%;" align="left"><b>Item <Font color="blue">N</font>ame</b></td>
			 <td style="width: 1%;" align="left">:</td>
			<td style="width: 40%;" align="left"><input type="text" accesskey="n" name="i_name"  ></td>
			<td style="width: 28%;" align="left"><b>Ticker Flag </td>
			 <td style="width: 1%;" align="left">:</td>
			<td style="width: 40%;" align="left"><select name="i_tickflg" style="width:100%;">
										<option value="">Select Ticker Flag</option>
										<option value="Y">Yes</option>
										<option value="N">No</option>
										</select></td>
		</tr>
		<tr></tr>
 		<tr>
 			<td colspan="4">
 			<fieldset><legend><font color="blue"><b>Prices</b></font></legend>
  			<table align="center">
		  		<tr>
		  			<td><b>Item MRP [Rs.]</b></td><td><input type="text" name="i_mrp1" size="10"></td>
		  			<td>&nbsp&nbsp</td>
		  			<td><b>And</b></td>
		  			<td>&nbsp&nbsp</td>
		  			<td><input type="text" name="i_mrp2" size="10"></td>
		  		
		  		</tr>
		  		<tr></tr>
		  		<tr></tr>
		  		<tr>
		  			<td><b>Item Rate [Rs.]</b></td><td><input type="text" name="i_rate1" size="10"></td>
		  			<td>&nbsp&nbsp</td>
		  			<td><b>And</b></td>
		  			<td>&nbsp&nbsp</td>
		  			<td><input type="text" name="i_rate2" size="10"></td>
		  		</tr>
		  	</table>
		  	</fieldset>
 	</table>
  	<br>
	<center><input type="button" name="Submit" value="Search <Alt+s>" accesskey="s" onclick="showHint();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>" onclick="document.getElementById('txtHint').innerHTML='';">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();">
	<INPUT type=BUTTON value="New Item <Alt+i>" accesskey="i" onClick="newItem();">
	<INPUT type="hidden" name="flagHidden" value="<%=flag%>">
	</fieldset>
	<hr>Suggestions: <div id="txtHint" class="ddm1" style="height: 325px;overflow: auto;"></div>
	
</form>
<br><br>
<p><h1><center><div id="waitMessage"  style="cursor: sw-resize"></center></div></h1></p>

</body>
</html>
<script type="text/javascript">
	function showMsg(){
		 	 document.myform.action="HomeForm.jsp";
			 document.myform.submit();
    }
    function newItem(){
		 	 document.myform.action="NewItemForm.jsp?backPage=ItemDetailsForm.jsp";
		 	  document.myform.target="_blank";
		 	   window.open(myform.action,myform.target,"fullscreen=yes");
			 //document.myform.submit();
    }
      	document.myform.i_barcode.focus();
    var currentFld = 11;
	  function getKey(){
			var key = event.keyCode;
			if (key == 38 || key == 40){
				if (key == 38) currentFld--; //up arrow
				else currentFld++; //down
				if (currentFld ==0)	{
				   currentFld=10;
				}
				else if (!document.myform.elements[currentFld]) {
				
						tref = document.getElementById("id");
					    ahref = tref.getElementsByTagName("A");
						ahref[currentFld-11].focus();
				}
				else { 
								document.myform.elements[currentFld].focus();
					
				}
			}
	    }
		document.onkeydown = getKey;
</script>
