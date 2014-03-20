<%@page contentType="text/html"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="order_detailsForm.jsp" />	
</jsp:include>

 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=order_detailsForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
 <link rel="stylesheet" href="css/themes/base/jquery.ui.all.css">
	<script src="js/ui/jquery.ui.core.js"></script>
	<script src="js/ui/jquery.ui.widget.js"></script>
	<script src="js/ui/jquery.ui.datepicker.js"></script>
	<link rel="stylesheet" href="css/demos.css">
 
<script type="text/javascript"  src="js/order_details.js">
</script> 

<style>
hr {
color: #f00;
background-color: #f00;
height: 3px;
}

</style>
<script language="javascript" src="js/codethatcalendarstd.js"></script>
<script>
	
	function checkField(){
			var c_date1 = document.myform.c_date1.value ;
			var c_date2 = document.myform.c_date2.value ;
			var u_date1 = document.myform.u_date1.value ;
			var u_date2 = document.myform.u_date2.value ;
			
			if(c_date1!="" && c_date2==""){
				alert("enter create to_date ");
				return false;
			}
			if(c_date2!="" && c_date1==""){
				alert("enter create from_date ");
				return false;
			}
			if(u_date1!='' && u_date2==''){
				alert("enter update to_date ");
				return false;
			}
			if(u_date2!='' && u_date1==''){
				alert("enter update from_date ");
				return false;
			}
			
		    showHint();		    
	}
	function showMsg(){
		 	 document.myform.action="HomeForm.jsp";
			 document.myform.submit();
    }
</script>
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
	 <td><b>Create<font color="blue">D</font>ate</b></td>
	 <td><input type ="text"  accesskey="d" name="c_date1" id="c_date1" size="15" readonly="readonly"/></td>
	 <td> <b>And</b></td><td> <input type ="text" name="c_date2" id="c_date2"  size="15" readonly="readonly"/></td>
	</tr>
	<tr>
	 <td><b><font color="blue">U</font>pdate Date</b></td>
	 <td><input type ="text" readonly accesskey="u" name="u_date1" id="u_date1" size="15" readonly="readonly"/></td>
	 <td><b>And</b></td><td> <input type ="text" name="u_date2" id ="u_date2" size="15" readonly="readonly"/></td>
	</tr>
</table></fieldset></td></tr>
  </table>
 </td>
  <td>
<%
    Connection conn=null;
	Statement stat=null;
	ResultSet rs=null;
	try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
    	stat=conn.createStatement();
    	String query="select a.order_num, a.custcode, a.order_date,a.total_items,a.total_value, b.custname ,b.phone,a.status_code,a.enterd_by from orders a, customer_master b  where a.custcode = b.custcode order by a.lastmodifieddate Desc limit 5";
    	rs=stat.executeQuery(query);
    	
%>    	
    	<table border="1" id="id1" class="item3" style="border-collapse: collapse;"  >
    	<tr><th colspan="7"><center><b>Recently updated orders</b></center></th></tr>
			<tr> 
				<td><b>Order No.</b></td>
				<td><b>Cust Code</b></td>
				<td><b>Order Date</b></td>
				<td><b>Items</b></td>	
				<td><b>Order Value</b></td>	
				<td><b>Enterd By</b></td>
				<td><b>Status</b></td>		
		   </tr>
<%		
		while(rs.next()) {
%>
          
             <tr> <td><a href="print_order.jsp?orderNo=<%=rs.getString(1)%>&backPage=order_detailsForm.jsp&buttonFlag=Y&statusCode=<%=rs.getString(8)%>">
<%			//System.out.println("\n\n PPPPPPPPPPPP \n\n print_order.jsp?orderNo="+rs.getString(1)+"&backPage=customer_detailsForm.jsp&buttonFlag=Y&statusCode="+rs.getString(8));
			out.println(rs.getString(1));
%>       
						
			</a></td><td title="<%=rs.getString(6)%>,<%=rs.getString(7)%>">
<%	
           	out.println(rs.getString(2));
%>
			</td><td>
<%	
           	out.println(rs.getString(3));
%>	
			</td><td>
<%	
           	out.println(rs.getString(4));
%>	
			</td><td>
<%	
           	out.println(rs.getString(5));
%>	
			</td><td>
<%	
           	out.println(rs.getString(9));
%>	
			</td><td>
<%	
           	out.println(rs.getString(8));
%>	
			</td></tr>
<%		
		}	    	  
    	rs.close();
		stat.close();
		conn.close();
%>
	</table>
</td>
</tr>
<%						
	}catch(Exception e){
		e.getMessage();
		e.printStackTrace();
		rs.close();
		stat.close();
		conn.close();
	}		
%>

</table>  
</table> 
	<br><br>
	<input type="submit" name="search" title="Press <Enter>" value="Search <Enter>" accesskey="s" onclick="checkField();return false;">
	<input type="reset" name="clear" value="Clear <Alt+c>" tabindex="1" title="Press <Alt+c>" accesskey="c" onclick='document.getElementById("txtHint").innerHTML="";'>
	<INPUT type=BUTTON value="Cancel <Alt+s>" accesskey="s" onClick="showMsg();">
	<hr>Suggestions: <div id="txtHint" class="ddm1" style="overflow: auto;max-height: 380px;"></div>
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