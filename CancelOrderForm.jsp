<%@ page contentType="text/html"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<jsp:include page="header.jsp" /> 
<%@ page errorPage="ErrorPage.jsp?page=CancelOrderForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<head>
	<script src="js/jquery-1.10.2.min.js"></script>
	<link rel="stylesheet" href="css/themes/base/jquery.ui.all.css">
	<script src="js/ui/jquery.ui.core.js"></script>
	<script src="js/ui/jquery.ui.widget.js"></script>
	<script src="js/ui/jquery.ui.datepicker.js"></script>
	<link rel="stylesheet" href="css/demos.css">
	<script type="text/javascript"  src="js/CancelOrder.js"></script>
	<style>
		hr {
		color: #f00;
		background-color: #f00;
		height: 3px;
		}
	</style>
	
</head> 

<b>Please Enter Order Details to Search  </b>

<form name="myform" method="post" class="ddm1">
<table align="center" width="100%" tabindex="2">
	<tr>
	<td>
	<table border="0" align="left">
	<tr>
	 <td><b><font color="blue">P</font>hone Number</b></td><td><input type="text" name="phonenumber" align="right" colspan="2" accesskey="p"></td>
	</tr>
	<tr>
	 <td><b><font color="blue">O</font>rder Number</b></td><td><input type="text" name="orderNumber" accesskey="o" align="right"></td>
	 <td><b><font color="blue">C</font>ustomer Code</b><td><input type="text" name="customerCode" accesskey="c" align="right" colspan="2"></td>
	</tr>
	<tr>
	 <td ><b>Customer <font color="blue">N</font>ame</b></td>
	 <td><input type="text" name="customerName" accesskey="n" align="right"></b></td>
	 <td><b><font color="blue">E</font>ntered By</b></td><td><input type ="text" name="enteredBy"></td>
	</tr>
	<tr><td colspan=4><fieldset><legend>Date Range</legend><table align="center">		
	<tr>
	 <td><b>Create<font color="blue">D</font>ate</b></td><td><input type="text" id='createFromDate' value="" readonly="readonly"></td>
	 <td> <b>&nbsp;&nbsp;And&nbsp;&nbsp;&nbsp;</b></td><td><input type="text" id='createToDate' readonly="readonly"/></td>
	</tr>
	<tr>
	 <td><b><font color="blue">U</font>pdate Date</b></td><td><input type="text" id='updateFromDate' value="" readonly="readonly"/></td>
	 <td><b>&nbsp;&nbsp;And&nbsp;&nbsp;&nbsp;</b></td><td><input type="text" id='updateToDate' value="" readonly="readonly"></td>
	</tr>
</table></fieldset></td></tr>
  </table>
 </td>
  <td>

</table>  
</table> 
	<br><br>
	<input type="submit" name="search" title="Press <Enter>" value="Search <Enter>" accesskey="s" onclick="checkField();return false;">
	<input type="reset" name="clear" value="Clear <Alt+c>" tabindex="1" title="Press <Alt+c>" accesskey="c" onclick='window.location.reload();'>
	<INPUT type=BUTTON value="Cancel <Alt+s>" accesskey="s" onClick="showMsg();">
	<hr><b>Suggestions: </b><div id="txtHint" style="height: 375px;overflow: auto;"></div>
	<br><br>
	<p><h1><center><div id="waitMessage"></center></div></h1></p>
	<script type="text/javascript">
		  //document.myform.orderNumber.focus();
		  document.myform.phonenumber.focus();
		  var currentFld = 0;
		  function getKey(){
				var key = event.keyCode;
				if (key == 38 || key == 40){
					if (key == 38) currentFld--; //up arrow
					else currentFld++; //down
					if (!document.myform.elements[currentFld]) {
						tref = document.getElementById("id1");
						ahref = tref.getElementsByTagName("A");
						ahref[currentFld-13].focus();
					}
					else
						document.myform.elements[currentFld].focus();
				}
		    }
			document.onkeydown = getKey;      	
   	</script>
	 
</form>
</body>
</html>