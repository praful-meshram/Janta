<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="DeliveryDetailsForm.jsp" />	
</jsp:include>

 --%>

<%@ page errorPage="ErrorPage.jsp?page=DeliveryDetailsForm.jsp" %>
	
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
  	float balance=0.0f;
  	float advance=0.0f;
  	float discount=0.0f;
  	float changeAmt=0.0f;
  	float comm_amt=0.0f;	  	
  	float totalValue=0.0f;
  	float other_charges=0.0f;

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
	  	balance = mo.rs.getFloat("balance_amt");
	  	advance = mo.rs.getFloat("advance_amt");
	  	discount = mo.rs.getFloat("discount_amt");
		orderDate = mo.rs.getString("order_date");
	  	status=mo.rs.getString("status_code");
	  	changeAmt=mo.rs.getFloat("change_amt");
	  	totalItems = mo.rs.getString("total_items");
	  	totalValue = mo.rs.getFloat("total_value");	
	  	comm_amt = mo.rs.getFloat("ord_comm_amt");	
	  	other_charges = mo.rs.getFloat("other_charges");	
	 	payment_type_desc = mo.rs.getString("payment_type_desc");	  		  	
	}
	mo.closeAll();
		
%>
<form name="myform" method="post" class="ddm1">
	<table align=l style="border-collapse: collapse;">
	<tr>
    	<td align="left"><b><font color="blue" size ="1.8">Current Status :</font><b></td>
    	<td align="left"><b><label id='status' ></label></label><b></td>
    	<td colspan=4></td>
    	<td align="left"><b><font color="blue" size ="1.8">Next Action :</font></b></td>
    	<td align="left"><b><label id='action' ></label><b></td>
    </tr>
	</table>
	<table width="100%">
	<tr><td colspan=8></td><td>
    <table id="1"  width="100%">
	<tr><th colspan="6"><center><b>Customer Information</b></center> </th></tr>
	<tr></tr><TR></TR>
	<tr></tr><TR></TR>
	<tr>
		
		<td align="left"><b>Customer Code</b></td>
		<td align="left">: <%=custCode%></td>
		<td align="left"><b>Area</b></td>
		<td align="left">: <%=area%> </td>
		
	</tr>
	<tr>
		
		<td align="left"><b>Customer Name</b></td>
		<td align="left">: <%=name%></td>
		<td align="left"><b>Address 1</b></td>
		<td align="left">: <%=add1%></td>
	</tr>
	<tr>
		
		<td align="left"><b>Phone</b></td>
		<td align="left">: <%=phno%></td>
		<td align="left"><b>Address 2</b></td>
		<td align="left">: <%=add2%></td>
	</tr>
	</table><br>
	<table width="100%">	
		<tr><th colspan="6"><center><b>Order Information</b></center> </th></tr>
		<tr></tr>
		<tr>	
			<td align="left"><b>Order Number</b></td>
			<td align="left">: <%=orderNo%></td>
			<td align="left"><b>Order Date</b></td>
			<td align="left">: <%=orderDate%></td>
		</tr>
		<tr>	
			<td align="left"><b>Total Items</b></td>
			<td align="left">: <%=totalItems%></td>
			<td align="left"><b>Commission</b></td>
			<td align="left">: <%=comm_amt%></td>
		</tr>
		<tr>	
			<td align="left"><b>Total Value</b></td>
			<td align="left">: <%=totalValue%></td>
			<td width="35%" align="left"><b>Payment Type</b></td>
			<td align="left">: <%=payment_type_desc%></td>
		</tr>
		
		<tr>	
			<td align="left"><b>Less Discount</b></td>
			<td align="left">: <%=discount%></td>
		</tr>
		<tr>	
			<td align="left"><b>Less Advance</b></td>
			<td align="left">:<%=advance%></td>
		</tr>
		<tr>	
			<td align="left"><b>Balance</b></td>
<%
			if(other_charges > 0){
%>			
			<td align="left">: <font color="red"><%=balance%></font><font color="blue">, Other Charges : <%=other_charges%></font></td>
<%}else if(other_charges <=0){ %>
			<td align="left">: <font color="red"><%=balance%></font></td>
<%}%>			
		</tr>
		
		
		<tr>	
			<td align="left"><b>Change</b></td>

<%		if(balance>0){
	 		if(payment_type_desc.equals("Cash") || payment_type_desc.equalsIgnoreCase("Cheque") || payment_type_desc.equals("Credit")){
%>
				<td align="left"> :<input  type="text" readonly value="<%=changeAmt%>" name="change" ></td>
<%			}else{
%>
				<td align="left"> :<input  type="text" value="<%=changeAmt%>" name="change" onkeyup="setExpected();"></td>
<%			}
		}else if(balance<=0){
%>
				<td align="left"> :<input  type="text" readonly value="<%=changeAmt%>" name="change" ></td>
<% 		} 
%>

		</tr>
		<tr>	
			<td align="left"><b>Expected Amount</b></td>
<!-- 			<td>: <%=balance+(50 -(balance % 50))%></td>		
			<td align="left">: <%=balance+changeAmt%></td>		-->		
		
			<td align="left">: <label id='expamtdiv' ></label></td>			
		</tr>		
		
		<tr>	
			<td width="25%" align="left"><b>Delivery  Person </b></td>
			<td align="left" >
<%	
	Connection conn=null;
	Statement stmt=null,stat=null;
	ResultSet rs=null,rs1=null;
	try {
		String code,desc,status_code_value="SUBMITTED",statusCode="",
			  prevStaffCode="",prevStaffName="",staffQuery="";
	    //staffQuery="SELECT o.dstaff_code, d.dstaff_name FROM orders o,delivery_staff d where o.order_num='"+orderNo+"' and o.dstaff_code=d.dstaff_code";
		staffQuery="select a.dstaff_code, a.dstaff_name from delivery_staff a, "+
				   "(select distinct (dstaff_code) from order_history where order_num='"+orderNo+"') b "+				   
				   "where a.dstaff_code=b.dstaff_code";	    
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stmt = conn.createStatement();	
		//stat = conn.createStatement();	
		
		rs =stmt.executeQuery(staffQuery);
		while(rs.next()){
			prevStaffCode=rs.getString(1);
			prevStaffName=rs.getString(2);
			if(count==0)			
				StrWithComma=prevStaffName;
			else
				StrWithComma=StrWithComma+","+prevStaffName;			
			count++;
		}
		rs = stmt.executeQuery("select dstaff_code, dstaff_name from delivery_staff");
%>
			    
						<SELECT name="d_staff" >
						<OPTION VALUE="" >Select staff
<% 
	
	 	while (rs.next()) {
	 		code = rs.getString(1);
	 		desc = rs.getString(2);
%>
			<OPTION VALUE="<%= code%>" ><%= desc%>
<%
		}	
		System.out.println("SELECT status_code, allow_action FROM status where status_code='"+status_code_value+"'");	
		rs1 = stmt.executeQuery("SELECT status_code, allow_action FROM status where status_code='"+status_code_value+"'");		
%>		

			</td>

		<%if(!prevStaffCode.equals("") && !prevStaffName.equals("")){%>
			<tr><td><font color=#FF00CC sixe=2><b>This order was previously assigned to <%=StrWithComma%></b></font></td></tr>
		<%}%>
	
			<td width="20%"><b>Allow Action : </b></td>
			<td align="left">		
						<SELECT name="allow_action" >
						<OPTION VALUE="" >Select action


<%
		while(rs1.next()){
			statusCode=rs1.getString(1);
			actionValue=rs1.getString(2);
		}
		actionValueArray=actionValue.split(",");
		for(int index=0; index<actionValueArray.length; index++){
			System.out.println("index "+index+"\n actionValueArray[index] "+actionValueArray[index]);	
%>
			<OPTION VALUE="<%= index%>" ><%= actionValueArray[index]%>	
<%
	}
	    conn.close();
	    rs.close();
	    rs1.close();
	    stmt.close();	    
	  }
	  catch (Exception e) {
	    rs.close();
	    rs1.close();
	    stmt.close();
	    conn.close();		  
        e.getMessage();
        e.printStackTrace();
      }
	    
%>		
			</td>
		</tr>
		
		</table>
		</td><br>	
		<td valign=top align=right>			
			<div id="OrderHistory" class="ddm1"> </div> 
		</td>
		</tr>
		</table>
		<tr><td align="center" colspan=4>		
	<input type="submit" name="Submit"  disabled value="Save and Print<Alt+s>" accesskey="s" onClick="checkField();return false;">
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
</td></tr><hr>
 	<input type="hidden" name="horderNo" value="<%=orderNo%>">
 	<input type="hidden" name="horderDate" value="<%=orderDate%>"> 	
 	<input type="hidden" name="hstatus" value="<%=status%>">
 	<input type="hidden" name="hallowaction" value="">
	<input type="hidden" name="hpagename" value="DeliveryDetailsForm"> 	 
	<input type="hidden" name="hd_balance_ToPay" value="<%=deliveryBalance%>">
	<input type="hidden" name="comm" value="<%=comm_amt%>">		
	<div id="txtHint" class="ddm1">	</div>
	<p><h1><center><div id="waitMessage"  style="cursor: sw-resize"></center></div></h1></p>
	
<script type="text/javascript">		
		document.onkeydown = checkKey;
		document.onclick = checkKey;
		function checkKey() {
			document.myform.Submit.disabled=false;	
					
		}
		
		function setExpected(){
			var balance="<%=balance%>";
			change=document.myform.change.value;
			if(change=='')
				change=0;
			else 	
				document.getElementById("expamtdiv").innerHTML=parseFloat(balance)+parseFloat(change);

		}
		function checkField(){
			var d_staff  = document.myform.d_staff.value;	
			var allow_action = document.myform.allow_action.value;	
			var d_staffnm = document.myform.d_staff[document.myform.d_staff.selectedIndex].text;	
			var allow_actionnm = document.myform.allow_action[document.myform.allow_action.selectedIndex].text;				
			document.myform.hallowaction.value=allow_actionnm;
			var change =document.myform.change.value;	
			if(d_staff == ""){
					alert("Please Select Delivery Staff");
					document.myform.d_staff.focus();
					return false;
			}	
			if(d_staff=="" && allow_actionnm=="Send for delivery") {
					alert("Please Select Delivery Staff");
					document.myform.d_staff.focus();
					return false;
			}
			else if(allow_action=="") {
					alert("Please Select Allow action");
					document.myform.allow_action.focus();
					return false;
			}
			else if(isNaN(change)) {
				alert("Please Enter a number in Change field");
				document.myform.change.value="";
				document.myform.change.focus();
				return false;
			}
			else{	
				if(allow_action==0){
					var ans=confirm("Do you want to send "+ d_staffnm +" to deliver the order: "+ <%=orderNo%>);			
					if (ans==true){	
						document.myform.action = "DeliveryDetails.jsp?subValue=<%=subValue%>";
						//alert()
						document.myform.submit(document.myform.action);
					}
					else{
					  	window.refresh; 			  	
					}
				}
				else if(allow_action==1){
					var ans=confirm("Do you want to hold the order: "+ <%=orderNo%>);			
					if (ans==true){	
						document.myform.action="DeliveryDetails.jsp?subValue=<%=subValue%>";
						document.myform.submit();
					}
					else{
					  	window.refresh; 			  	
					}
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
			document.getElementById("action").innerHTML="<%=actionValue%>";
			document.getElementById("expamtdiv").innerHTML="<%=balance+changeAmt%>";
		}
   	</script>