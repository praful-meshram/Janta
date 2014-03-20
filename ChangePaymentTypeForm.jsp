<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<jsp:include page="header.jsp" />

<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="ChangePaymentTypeForm.jsp" />	
</jsp:include> --%>

<%@ page errorPage="ErrorPage.jsp?page=ChangePaymentTypeForm.jsp" %>	
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
		
		%>

<%@page contentType="text/html"%>
<script src="js/lastOrderDetails.js"></script>
<%
	String StrWithComma="";
	String[] actionValueArray=null;
	String[] arr=null;
	int count=0;
  	String orderNo=""; 	
  	orderNo=request.getParameter("orderNo");
  	String custCode="";
  	String action1="",action2="",actionValue="";
  	String deliveryBalance="";
  	String subValue="";
  	subValue=request.getParameter("subValue");
  	String name="";
  	String phno="";
  	String area="";
  	String add1="";
  	String add2="";
  	String orderDate="";
  	String status="";
  	String totalItems=""; 
	String payment_type_desc=""; 
  	float totalValue=0.0f;

	order.ManageOrder mo;
	mo = new order.ManageOrder("jdbc/js");
	mo.getOrderDetails(orderNo);
	
	while(mo.rs.next()){		
		custCode = mo.rs.getString("custcode");
	  	name = mo.rs.getString("custname");
	  	phno = mo.rs.getString("phone");
	  	area = mo.rs.getString("area");
	  	add1 = mo.rs.getString("add1");
	  	add2 = mo.rs.getString("add2");	  
		orderDate = mo.rs.getString("order_date");
	  	status=mo.rs.getString("status_code");	  	
	  	totalItems = mo.rs.getString("total_items");
	  	totalValue = mo.rs.getFloat("total_value");	  
	 	payment_type_desc = mo.rs.getString("payment_type_desc");	
	 	actionValue =  mo.rs.getString("action"); 		  	
	}
	mo.closeAll();
		
%>
<form name="myform" method="post" class="ddm1">
	<table align=center>
	<tr>
    	<td><b><font color="blue" size ="1.8">Current Status :</font><b></td>
    	<td><b><label id='status' ></label></label><b></td>
    	<td colspan=4></td>    	
    </tr>
	</table>
	<table width="100%">
	<tr><td colspan=8></td><td>
    <table id="1"  width="100%">
	<tr><th colspan="6"><center><b>Customer Information</b></center> </th></tr>
	<tr></tr><TR></TR>
	<tr></tr><TR></TR>
	<tr>
		
		<td><b>Customer Code</b></td>
		<td>: <%=custCode%></td>
		<td><b>Area</b></td>
		<td>: <%=area%> </td>
		
	</tr>
	<tr>
		
		<td><b>Customer Name</b></td>
		<td>: <%=name%></td>
		<td><b>Address 1</b></td>
		<td>: <%=add1%></td>
	</tr>
	<tr>
		
		<td><b>Phone</b></td>
		<td>: <%=phno%></td>
		<td><b>Address 2</b></td>
		<td>: <%=add2%></td>
	</tr>
	</table><br><br><br>
	<table width="100%">	
		<tr><th colspan="6"><center><b>Order Information</b></center> </th></tr>
		<tr></tr>
		<tr></tr>
		<tr>	
			<td><b>Order Number</b></td>
			<td>: <%=orderNo%></td>
			<td><b>Order Date</b></td>
			<td>: <%=orderDate%></td>
		</tr>
		<tr>	
			<td><b>Total Items</b></td>
			<td>: <%=totalItems%></td>
			<td width="35%"><b>Payment Type</b></td>
			<td>: <%=payment_type_desc%></td>
		</tr>
		<tr>	
			<td><b>Total Value</b></td>
			<td>: <%=totalValue%></td>
			<td width="20%"><b>New Payment Type </b></td>
			<td>		
				<SELECT name="sel_payment" >
					<OPTION VALUE="" >Select Payment
					<OPTION VALUE="CHQ">Cheque
					<OPTION VALUE="H"> Hawala
				</select>
			</td>
		</tr>
		</table>
		</td><br>	
		<td valign=top align=right>			
			<div id="OrderHistory" class="ddm1"> </div> 
		</td>
		</tr>
		</table><br><br>
		<tr><td align="center" colspan=4>		
	<input type="submit" name="Submit"  disabled value="Save <Alt+s>" accesskey="s" onClick="checkField();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
</td></tr><hr>
 	<input type="hidden" name="horderNo" value="<%=orderNo%>">
 	<input type="hidden" name="horderDate" value="<%=orderDate%>"> 	
 	<input type="hidden" name="hstatus" value="<%=status%>">
 	<input type="hidden" name="haction" value="<%=actionValue%>">
	<input type="hidden" name="hpagename" value="DeliveryDetailsForm"> 	 
	<input type="hidden" name="hd_balance_ToPay" value="<%=deliveryBalance%>">		
	<div id="txtHint" class="ddm1">	</div>
	<p><h1><center><div id="waitMessage"  style="cursor: sw-resize"></center></div></h1></p>
	
<script type="text/javascript">		
		document.onkeydown = checkKey;
		document.onclick = checkKey;
		function checkKey() {
			document.myform.Submit.disabled=false;	
					
		}
		
		
		function checkField(){
			var d_paytype = document.myform.sel_payment.value;
			if(d_paytype == ""){
					alert("Please Select Payment Type");
					document.myform.sel_payment.focus();
					return false;
			}	
			else{
					var ans=confirm("Do you want to change the payment type");			
					if (ans==true){	
						document.myform.action="ChangePaymentType.jsp?orderNo=<%=orderNo%>";
						document.myform.submit();
					}
					else{
					  	window.refresh; 			  	
					}
			}
			
		}
		function showMsg(){
		  	 //document.myform.action="SubmittedOrdersDetails.jsp";
			 document.myform.action="TrackingForm.jsp";		  	 
		   	 document.myform.submit();
		}
		//window.onload= showHint; 		
		window.onload= func
		function func(){
			showHistory(); 
			document.getElementById("status").innerHTML="<%=status%>";
			
			
		}
   	</script>