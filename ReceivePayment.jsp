<%@ page contentType="text/html"%>
<jsp:include page="header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="css/receive_payment.css" />
<script type="text/javascript" src="js/ReceivePayment.js"></script>
<script type="text/javascript" src="js/popup.js"></script>
<center>
<form name="myform" method="post" action="ReceivePaymentSave.jsp">
<input type="hidden" name="cust_code" value="<%= request.getParameter("cust_code")%>"/>
<div id="main_div">
	<table style="width: 100%; height: 100%;">
		<tr style="height: 20%; width: 100%;">
			<td style="height: 100%; width: 30%;">
				<div class="inner_div" style="height: 110px; padding-top : 5px;" id="pay_detail">
					<table>
						<tr>
							<th align="left">
								Enter Amount
							</th>
							<th align="left"> : </th>
							<td>
								<input type="text" name="total_payment" size="15" id="total_amt" 
									onkeypress="return isNumberKey(event)" value="" onkeyup="manageAmount()"/> Rs.
							</td>
						</tr>
						<tr>
							<th align="left">
								Calculated Amount
							</th>
							<th align="left"> : </th>
							<td align="right"  id= "cal_amt">
								0
							</td>
						</tr>
						<tr>	
							<th align="left">
								Remaining Amount
							</th>
							<th align="left"> : +<input type = "hidden" name = "rem_amt_send" value = "0"/></th>
							<td id="rem_amt"  align="right">
								0
							</td>
						</tr>	
						<tr>	
							<th align="left">
								
							</th>
							<th align="left">&nbsp;&nbsp; = </th>
							<td>
								<hr>
							</td>
						</tr>	
						<tr>	
							<th align="left">
								Total Amount
							</th>
							<th align="left"> : </th>
							<td id="tot_amt"  align="right">
								0
							</td>
						</tr>	
					</table>
				</div>
			</td>
			<td style="height: 100%; width: 70%;" align="left">
				<div class="inner_div" style="height: 110px; padding-top : 5px;" id="cust_info"></div>
			</td>
			
		</tr>
		<tr style="height: 80%; width: 100%;">
			<td colspan="2" style="height: 100%; width: 75%;">
			<div class="inner_div" style="max-height: 220px;" id="order_detail"></div><br/>
			<div style="height: 30px;width: 98%;margin-right: 20px;" align="right">
				<input type="submit" value="Save Payment <Enter>" onclick="return confirmAction()"/>
			</div>
			
			</td>
		</tr>
	</table>
</div>

<div id="main_div">
	<table style="width: 100%;max-height: 200px;" border="1">
		<tr style="width: 100%; height: 100%;">
			<td style="width: 35%; height: 100%;">
				<h3>Payment History</h3>
				<div id="recent_payment_detail" style=" width:100%; max-height: 89%;"></div>
			</td>
			<td style="width: 65%; height: 100%;">
				<h3>Single Payment Detail</h3>
				<div id="single_payment_detail" style=" width:100%; max-height: 89%;">
				Click on row to see details about perticular payment
				</div>
			</td>
		</tr>
	</table>
</div>

<div id="baseDiv" style="top: 0px;">
		<div id="popupItemDiv"
			style="height: 400px; width: 60%; border: 2px solid black; background-color: #BEF781; 
			 display: none; font-size: 100%; margin: 150px 0px 0px 250px;">
			 <div style="float: right; width: 20px;height: 20px; overflow: auto; cursor: pointer;" onclick="funCloseDiv()">
			 <img  src="images/close.png"/>
			 </div>
			 <div id="order_detail_popup" style=" width:100%; height: 89%;margin-top: 5%; overflow: auto; font: consolas;"></div>
		</div>
</div>
<br/><br/><br/><br/><br/>
</form>
</center>
</body>
</html>
<script type="text/javascript">
	window.onload = function(){
		loadCustDetails("<%= request.getParameter("cust_code")%>");
	}
</script>
