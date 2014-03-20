<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.io.*"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">
	<jsp:param name="formName" value="DeliveredActionForm.jsp" />
</jsp:include> --%>

<%@page contentType="text/html"%>
<script src="js/lastOrderDetails.js"></script>

 <%@ page errorPage="ErrorPage.jsp?page=DeliveredActionForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	System.out.println("session  : "+session +" \n user "+session.getAttribute("UserName").toString());
		
		
		%>


<%
	String code, desc, status_code_value = "DELIVERED", statusCode = "", actionValue = "";
	String[] actionValueArray = null;
	String custCode = "";
	String name = "";
	String phno = "";
	String area = "";
	String add1 = "";
	String add2 = "";
	String orderNo = "";
	orderNo = request.getParameter("orderNo");
	String orderDate = "";
	String status = "";
	String d_name = "";
	String d_code = "";
	String totalItems = "";
	float totalValue = 0.0f;
	float change = 0.0f;
	float paid_amt = 0.0f;
	float sum = totalValue + change;
	float balance = 0.0f;
	float advance = 0.0f;
	float discount = 0.0f;
	float other_charges = 0.0f;
	order.ManageOrder mo;
	mo = new order.ManageOrder("jdbc/js");
	mo.getOrderDetails(orderNo);
	while (mo.rs.next()) {
		custCode = mo.rs.getString("custcode");
		name = mo.rs.getString("custname");
		phno = mo.rs.getString("phone");
		area = mo.rs.getString("area");
		add1 = mo.rs.getString("add1");
		add2 = mo.rs.getString("add2");
		orderDate = mo.rs.getString("order_date");
		status = mo.rs.getString("status_code");
		d_name = mo.rs.getString("dstaff_name");
		d_code = mo.rs.getString("dstaff_code");
		totalItems = mo.rs.getString("total_items");
		totalValue = mo.rs.getFloat("total_value");
		change = mo.rs.getFloat("change_amt");
		balance = mo.rs.getFloat("balance_amt");
		advance = mo.rs.getFloat("advance_amt");
		discount = mo.rs.getFloat("discount_amt");
		paid_amt = mo.rs.getFloat("paid_amt");
		other_charges = mo.rs.getFloat("other_charges");
		sum = balance + change;
	}
	mo.closeAll();
%>
<form name="myform" method="post" class="ddm1">

	<table align=center>
		<tr align="left">
			<td><b><font color="blue" size="1.8">Current Status :</font><b>
			</td>
			<td><b><label id='status'></label></label><b>
			</td>
			<td colspan=4></td>
			<td><b><font color="blue" size="1.8">Next Action :</font>
			</b>
			</td>
			<td><b><label id='action'></label><b>
			</td>
		</tr>
	</table>

	<center>
		<h5>
			<b> Order Details</b>
		</h5>
	</center>

	<table aligh=left style="width:100%">
		<tr align="left">
			<td>
				<table style="width:100%">
					<tr>
						<td>

							<table id="1" border="0" align="left" width="100%">
								<tr>
									<th colspan="6"><center>
											<b>Customer Information</b>
										</center></th>
								</tr>
								<tr></tr>
								<TR></TR>
								<tr></tr>
								<TR></TR>
								<tr></tr>
								<TR></TR>
								<tr>
									<td><b>Customer Code</b>
									</td>
									<td>: <%=custCode%></td>
									<td>&nbsp&nbsp&nbsp&nbsp</td>
									<td><b>Area</b>
									</td>
									<td>: <%=area%></td>
								</tr>
								<tr>

									<td><b>Customer Name</b>
									</td>
									<td>: <%=name%></td>
									<td></td>
									<td><b>Address 1</b>
									</td>
									<td>: <%=add1%></td>
								</tr>
								<tr>

									<td><b>Phone</b>
									</td>
									<td>: <%=phno%></td>
									<td></td>
									<td><b>Address 2</b>
									</td>
									<td>: <%=add2%></td>
								</tr>
								<tr></tr>
								<TR></TR>
							</table></td>
					</tr>

					<tr>
						<td>
							<table align=left width=100%>
								<tr>
									<th colspan="6"><center>
											<b>Order Information</b>
										</center></th>
								</tr>
								<tr></tr>
								<TR></TR>
								<tr></tr>
								<TR></TR>
								<tr></tr>
								<TR></TR>
								<tr>
									<td><b>Order Number</b>
									</td>
									<td>: <%=orderNo%></td>

									<td><b>Order Date</b>
									</td>
									<td>: <%=orderDate%></td>
								</tr>
								<tr>
									<td><b>Total Items</b>
									</td>
									<td>: <%=totalItems%></td>

								</tr>
								<tr>
									<td><b>Total Value</b>
									</td>
									<td>: <%=totalValue%></td>
								</tr>
								<tr>
									<td><b>Less Discount</b>
									</td>
									<td>: <%=discount%></td>
								</tr>
								<tr>
									<td><b>Less Advance</b>
									</td>
									<td>:<%=advance%></td>
								</tr>
								<tr>
									<td><b>Balance</b>
									</td>
									<%
										if (other_charges > 0) {
									%>
									<td width="50%">: <font color="red"><%=balance%></font><font
										color="blue">, Other Charges : <%=other_charges%></font>
									</td>
									<%
										} else if (other_charges <= 0) {
									%>
									<td>: <font color="red"><%=balance%></font>
									</td>
									<%
										}
									%>
								</tr>


								<tr>
									<td><b>Change</b>
									</td>
									<td>: <%=change%></td>

									<td><b>Paid Amount </b>
									</td>
									<td>: <%=paid_amt%></td>

								</tr>
								<tr></tr>
								<TR></TR>

								<%
									Connection conn = null;
									Statement stmt = null, stat = null;
									ResultSet rs = null, rs1 = null;
									try {
										Context initContext = new InitialContext();
										Context envContext = (Context) initContext
												.lookup("java:/comp/env");
										DataSource ds = (DataSource) envContext.lookup("jdbc/js");
										conn = ds.getConnection();
										stmt = conn.createStatement();
										//stat = conn.createStatement();	
										System.out.println("SELECT status_code, allow_action FROM status where status_code='"
												+ status_code_value + "'");
										rs = stmt.executeQuery("SELECT status_code, allow_action FROM status where status_code='"
														+ status_code_value + "'");
								%>

								<tr>

									<td><b>Delivery Person </b>
									</td>
									<td>: <%=d_name%></td>
									<td><b>Allow Action </b>
									</td>
									<td>: <SELECT name="allow_action">
											<OPTION VALUE="">
												Select action


												<%
												while (rs.next()) {
														statusCode = rs.getString(1);
														actionValue = rs.getString(2);
													}
													actionValueArray = actionValue.split(",");
													for (int index = 0; index < actionValueArray.length; index++) {
														
														System.out.println(" index "+index+"\n actionValueArray "+actionValueArray[index]);
											%>
											
											<OPTION VALUE="<%=index%>"><%=actionValueArray[index]%>
												<%
													}
														rs.close();
														stmt.close();
														conn.close();
													} catch (Exception e) {
														e.getMessage();
														e.printStackTrace();
													}
												%>
											
							</table></td>
					</tr>
				</table></td>
			<td align=left valign=top>
				<div id="OrderHistory" class="ddm1"></div></td>





			</td>
		</tr>
	</table>
	<center>
		<input type="submit" name="Submit" disabled value="Save <Alt+ s>"
		accesskey="s" onClick="checkField();return false;"> <INPUT type=BUTTON
			value="Cancel <Alt+ c>" accesskey="c" onClick="showMsg();">
	</center>

	<center>
		<hr>
		<br> <input type="hidden" name="horderNo" value="<%=orderNo%>">
		<input type="hidden" name="horderDate" value="<%=orderDate%>">
		<input type="hidden" name="hstatus" value="<%=status%>"> 
		<input type="hidden" name="d_staff" value="<%=d_code%>"> 
		<input type="hidden" name="hpagename" value="DeliveredActionForm"> 
		<input type="hidden" name="hallowaction" value=""> 
		<input type="hidden" name="htotalValue" value="<%=totalValue%>"> 
		<input type="hidden" name="hpaidamt" value="<%=paid_amt%>"> 
		<input type="hidden" name="hchange" value="<%=change%>"> 
		<input type="hidden" name="hcomm" value="0">
		<div id="txtHint" class="ddm1"></div>
		<center>
			<div id="waitMessage" style="cursor: sw-resize">
		</center>
		</div>

		<script type="text/javascript">	
		
		document.onkeydown = checkKey;
		document.onclick = checkKey;
		function checkKey() {
			document.myform.Submit.disabled=false;			
		}

		function checkField(){
			
			
			var allow_action = document.myform.allow_action.value;	
			var allow_actionnm = document.myform.allow_action[document.myform.allow_action.selectedIndex].text;				
			document.myform.hallowaction.value=allow_actionnm;	
			var totalVal=document.myform.htotalValue.value;
			var changeVal=document.myform.hchange.value;
			var paidAmt=parseInt(document.myform.hpaidamt.value);
			totalVal=parseInt(totalVal)+parseInt(changeVal);
			document.myform.hcomm.value=document.getElementById("comm").innerHTML;
			
			
			
			if(allow_action=="") {
				alert("Please Select Allow action");
				document.myform.allow_action.focus();
				return false;
			}	
			else if(totalVal!=paidAmt && allow_actionnm=="Close")
				alert("Total value not equal to paid amount");
			else if(allow_actionnm=="Close"){ 
				var ans=confirm("Do you want to change the status to Close? ");
				if (ans==true){
					document.myform.action="DeliveredAction.jsp";
					document.myform.submit();
				}
				else{
				  	window.refresh; 
				}				
			}	
			else if(allow_actionnm=="Hold"){ 
				var ans=confirm("Do you want to change the status to Hold? ");
				if (ans==true){
					document.myform.action="DeliveredAction.jsp";
					document.myform.submit();
				}
				else{
				  	window.refresh; 
				}				
			}					
		
		}// EOF Function
			
		
		
		function showMsg(){			
			 document.myform.action="TrackingForm.jsp";		 
		   	 document.myform.submit();
		}
		function func(){
			document.getElementById("status").innerHTML="<%=status%>";
			document.getElementById("action").innerHTML="<%=actionValue%>";
				showHistory();
				//showHint(document.myform.hpagename.value);
			}
			window.onload = func;
		</script>