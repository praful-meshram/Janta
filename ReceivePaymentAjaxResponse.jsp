<%@page import="java.util.Calendar"%>
<%@ page import="payment.*" %>
<%
String call_option = request.getParameter("call_option");
if(call_option.equals("cust_info")){
	String cust_code = request.getParameter("cust_code");
	ManagePayment manage = new ManagePayment("jdbc/js");
	manage.getCustInfo(cust_code);
	if(manage.rs.next()){
		%>
			<h3>&nbsp;Customer Detail :</h3>
			<b>Name : </b> <%= manage.rs.getString(1) %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Phone : </b> <%= manage.rs.getString(9)+" , "+ manage.rs.getString(10) %><br/>
			<b>Address : </b> <%= manage.rs.getString(2)+" Building, "+manage.rs.getString(3)+" Block, "+manage.rs.getString(4)+" Wing, " %>
			 <%= manage.rs.getString(5)+" , "+manage.rs.getString(6)+" , "+manage.rs.getString(8) %>&nbsp;&nbsp;&nbsp;&nbsp;
			 <b>Station : </b> <%= manage.rs.getString(7) %><br/>
			<input type="button" accesskey="s" value="Search Again<Alt+S>" onclick="goBack()"/>
			<input type="hidden" name="cust_name" value = "<%= manage.rs.getString(1) %>"/>
			<input type="hidden" name="address" value = "<%= manage.rs.getString(2)+" Building, "+manage.rs.getString(3)+" Block, "+manage.rs.getString(4)+" Wing, " %>
			 <%= manage.rs.getString(5)+" , "+manage.rs.getString(6)+" , "+manage.rs.getString(8) %>"/>
			<input type="hidden" name="phone" value = "<%= manage.rs.getString(9)+" , "+ manage.rs.getString(10) %>"/>
		<%
	} else {
		out.print("Error in Fatching data...");
	}
	int last_pay = manage.getLastPayFromTable();
	last_pay++;
	String id = "RP"+last_pay;
	%>
	<input type="hidden" name="pay_code" value = "<%=id%>"/>
	
	<%
	manage.closeAll();
} else if(call_option.equals("order_info")){
	String cust_code = request.getParameter("cust_code");
	ManagePayment manage = new ManagePayment("jdbc/js");
	manage.getOrderInfo(cust_code);
	%>
	<div id = "refresh_button">
		<table>
			<tr>
				<td>
					<input style="float: right;margin-top: 5px;" type="button" onclick="distributePayment()" value="Distribute All<Alt+D>" accesskey="d"/> 
				</td>
				<td>
					<img id = "refresh_button_img" src="images/refresh.png" onclick="loadCustDetails('<%= cust_code%>'),manageAmount()" title="Refresh Order Detail Table"/>
				</td>
			</tr>
		</table>
	</div>
	<center><h4>Order Details</h4></center>
	<div style="width: 99%;overflow-y:scroll;">
		<table border="1" style="width: 98%; float: right;background-color: #BEF781;">
			<tr style="width: 100%;">
				<th style="width: 8%;">O.No.</th>
				<th style="width: 9%;">Date</th>
				<th style="width: 9%;">Total</th>
				<th style="width: 9%;">Change</th>
				<th style="width: 9%;">Paid</th>
				<th style="width: 9%;">Advance</th>
				<th style="width: 9%;">Discount</th>
				<th style="width: 9%;">Other</th>
				<th style="width: 9%;">Balance</th>
				<th style="width: 3%;">&nbsp;</th>
				<th style="width: 9%;">Amount</th>
				<th style="width: 8%;">Waived</th>
			</tr>
		</table>
	</div>
	<div style="width: 99%;max-height: 120px;overflow-y:scroll;">
		<table border="1" style="width: 98%;float: right;">
		<%
		int count = 0;
		float total_balance = 0f;
		if(manage.rs.next()){
		do{
			if(count%2==0){
			%>
				<tr style="width: 100%;background-color:#ECFBB9;">
			<%
			}else{
				%>
				<tr style="width: 100%;background-color:#ECFB99;">
				<%
			}
			%>
				<td style="width: 8%; cursor: pointer;" align="left">
				<table><tr><td>
				<b><u>
				<font color=blue onclick="displayOrderDetail('<%=manage.rs.getString(1)%>','<%= manage.rs.getDate(2) %>')"><%=manage.rs.getString(1)%></font>
				</u></b></td><td>
				<div id="return_arrow" style="width: 18px;height: 18px; float: right;background-image: url(images/return_item.png)" onclick="returnItemPage('<%=manage.rs.getString(1)%>')"></div>
				</td></tr></table>
				</td>
				<td style="display:none;"><input type="hidden" name="ord_num" size="7" id="order_num_<%=count%>" value = "<%=manage.rs.getString(1)%>"/></td>
				<td style="width: 9%;"><%= manage.rs.getDate(2) %><input type="hidden" name="date" value="<%= manage.rs.getDate(2) %>"/></td>
				<td style="width: 9%;"><%= manage.rs.getFloat(3) %></td>
				<td style="width: 9%;"><%= manage.rs.getFloat(4) %></td>
				<td style="width: 9%;"><%= manage.rs.getFloat(5) %></td>
				<td style="width: 9%;"><%= manage.rs.getFloat(6) %></td>
				<td style="width: 9%;"><%= manage.rs.getFloat(7) %></td>
				<td style="width: 9%;"><%= manage.rs.getFloat(9) %></td>
				<td style="width: 9%;" id="balance_<%=count%>"><%= manage.rs.getFloat(8) %></td>
				<td style="display:none;"><input type="hidden" name="balance" value="<%= manage.rs.getFloat(8) %>"/></td>
				<td style="width: 3%;"><img id="arrow_image" src="images/a1.png" onclick="copyAmount('balance_<%=count%>','amount_<%=count%>','<%=count%>')"></td>
				<td style="width: 9%;" align="left">
					<table>
						<tr>
							<td>
								<input type="text" name="dist_amt" size="5" id="amount_<%=count%>" value="0" readonly="readonly"/>
							</td>
							<td>
								<div id="right_<%=count%>" class="right">
									<img src="images/right_icon.png" style="width: 26px; height: 26px;margin-top: -7px;"/>
								</div>
								<div id="wrong_<%=count%>" class="wrong" onclick="confirmDiscount('amount_<%=count%>','balance_<%=count%>','waived_<%=count%>','<%=count%>');">
									<img src="images/wrong_icon.png" style="width: 20px; height: 20px;"/>
								</div>
							</td>
						</tr>
					</table>
				</td>
				<td style="width: 8%;" align="left">
					<table>
						<tr>
							<td>
								<input type="text" size="4" id="waived_<%=count%>" name="waived" value = "0" readonly="readonly"/>
							</td>
							<td>
								<div id="undo_<%=count%>" class="undo" onclick="undoDiscount('amount_<%=count%>','balance_<%=count%>','waived_<%=count%>','<%=count%>')">
									<img src="images/undo.png" style="width: 24px; height: 24px;margin-top: -7px;"/>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		<%
		total_balance = total_balance + manage.rs.getFloat(8);
		count++;
		} while(manage.rs.next());
		}else{
		%>
			<tr style="width: 100%;background-color:#ECFBB9;"><td colspan="12">No Pending</td><tr>
		<%
		}
		manage.closeAll();
		%>
		</table>
	</div>
	<div style="height: 30px;width: 89%;margin-right: 20px;" align="right">
	<b id="grand_total_balance"><%= total_balance %></b><b> /-Rs.</b> Total Balance.</div>
	<input type="hidden" name="row_count" value="<%= count %>" id="row_count"/>
	<%
} else if(call_option.equals("recent_payment")){
	String cust_code = request.getParameter("cust_code");
	ManagePayment manage = new ManagePayment("jdbc/js");
	manage.getRecentPaymentDetail(cust_code);
	%>
	<div style="width: 99%;overflow-y:scroll;">
		<table border="1" style="width: 96%;background-color: #BEF781;float: right;">
			<tr style="width: 100%;">
				<th style="width: 33.33%;">Date</th>
				<th style="width: 33.33%;">Amount</th>
				<th style="width: 33.33%;">Receive By</th>
			</tr>
		</table>
	</div>
	<div style="width: 99%;max-height :85%;overflow-y:scroll">
		<table border="1" style="width: 96%;;background-color: #BEF781;float: right;">
	<%
	int count = 0;
	if(manage.rs.next()){
	do{
		if(count%2==0){
			%>
				<tr style="width: 100%;background-color:#ECFBB9;cursor: pointer;" 
				onclick="loaadDetailSinglePayment('<%=manage.rs.getString(2)%>','<%= manage.rs.getString(4) %>','<%= manage.rs.getString(7) %>','<%= manage.rs.getDate(6) %>')">
			<%
			}else{
			%>
				<tr style="width: 100%;background-color:#ECFB99;cursor: pointer;" 
				onclick="loaadDetailSinglePayment('<%=manage.rs.getString(2)%>','<%= manage.rs.getString(4) %>','<%= manage.rs.getString(7) %>','<%= manage.rs.getDate(6) %>')">
			<%
			}
		%>
				<td style="width: 33.33%;padding-left: 10px;" align="left"><%= manage.rs.getDate(6) %></td>
				<td style="width: 33.33%;padding-left: 10px;" align="left"><%= manage.rs.getString(4) %>&nbsp;Rs.</td>
				<td style="width: 33.33%;padding-left: 10px;" align="left"><%= manage.rs.getString(7) %></td>
			</tr>
		
	<%
	count++;
	}while(manage.rs.next());
	}else{
	%>
	<tr style="width: 100%;background-color:#ECFBB9;"><td colspan="3">No Previous Payment</td></tr>
	<%
	}
	%>
	</table>
	</div>
	<%
	manage.closeAll();
} else if(call_option.equals("detail_payment") || call_option.equals("detail_payment1")){
	String pay_code = request.getParameter("pay_code");
	ManagePayment manage = new ManagePayment("jdbc/js");
	manage.getPaymentDetail(pay_code);
	%>
	<b>Date : </b><%=request.getParameter("date") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Amount : </b><%=request.getParameter("amount") %>
	<br/><br/>
	<div style="width: 99%;overflow-y:scroll;">
		<table border="1" style="width: 97%;float: right;background-color: #BEF781;">
			<tr style="width: 100%;">
				<th style="width: 25%;">Order No</th>
				<th style="width: 25%;">Date</th>
				<th style="width: 25%;">Amount</th>
				<th style="width: 25%;">Receive By</th>
			</tr>
		</table>
	</div>
	<div style="width: 99%;max-height :67%;overflow-y:scroll;max-height: 200px;">
		<table border="1" style="width: 97%;background-color: #BEF781;float: right;">
	<%
	int count = 0;
	while(manage.rs.next()){
		if(count%2==0){
			%>
				<tr style="width: 100%;background-color:#ECFBB9;cursor: pointer;"> 
			<%
			}else{
			%>
				<tr style="width: 100%;background-color:#ECFB99;cursor: pointer;" >
			<%
			}
		if(call_option.equals("detail_payment")){
			%>
				<td style="width: 25%;padding-left: 10px;" align="left"  onclick="displayOrderDetail('<%=manage.rs.getString(2)%>')">
				<b><u><font color=blue><%=manage.rs.getString(2)%></font></u></b></td>
			<%
		}else{
			%>
			<td style="width: 25%;padding-left: 10px;" align="left">
			<%=manage.rs.getString(2)%></td>
			<%
		}
			%>
				
				<td style="width: 25%;padding-left: 10px;" align="left"><%=request.getParameter("date") %></td>
				<td style="width: 25%;padding-left: 10px;" align="left">
				<%
					out.print(manage.rs.getString(3)+" /-Rs.");
					if(Float.parseFloat(manage.rs.getString(5)) > 0){
						out.print("("+manage.rs.getString(5)+" Rs. Waived)");
					}
				%>
				</td>
				<td style="width: 25%;padding-left: 10px;" align="left"><%=request.getParameter("receive_by") %></td>
			</tr>
		
	<%
	count++;
	}
	%>
	</table>
	</div>
	<%
	manage.closeAll();
}
%>