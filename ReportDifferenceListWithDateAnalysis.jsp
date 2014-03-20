<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%
	String str1 = "";
	str1 = request.getParameter("Exp");
	if (str1.equals("1")) {
		response.setHeader("Content-Disposition",
				"attachment;filename=ReportDiffreneceListWithDateAnalysis.xls");
		response.setContentType("application/vnd.ms-excel");
	} else {
		response.setContentType("text/html");
	}
%>

<head>
<title>Sales...</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
.boldtable,.boldtable TD,.boldtable TH,h2,body {
	font-family: arial;
	font-size: 10pt;
}
</style>
</head>
<body>
	<form name="myform" method="post">

		<%
			report.ManageReports mo;
			mo = new report.ManageReports("jdbc/js");

			String order_dt = "", del_datetiem = "", pageType = "", order_type = "";
			order_dt = request.getParameter("order_dt");
			String close_status = request.getParameter("close_status");
			String payment_type = "";
			payment_type = request.getParameter("payment_type");
			pageType = request.getParameter("pageType");
			order_type = request.getParameter("order_type");
			mo.VlistDeliveryDailyReportDetailsNew(order_dt, payment_type,
					order_type, close_status);
			String criteria = order_dt;
			String orderNo = "";
			String custCode = "";
			String custName = "";
			String buildingNo = "";
			String block = "";
			String wing = "";
			String building = "";
			String area = "";
			String orderDate = "";
			String lastModifiedDate = "";
			String totalItems = "";
			String totalValueMrp = "";
			float totalValuePrice = 0.0f;
			String discountAmt = "";
			String advanceAmt = "";
			float balanceAmt = 0.0f;
			float changeAmt = 0.0f;
			float paidAmt = 0.0f;
			float expectedAmt = 0.0f;
			//String deliveryStaffName = "";
			String statusCode = "";
			float delchgs = 0.0f;
			String payment = "";
			double adamt = 0.0f;
			float diffamt = 0.0f;
			float grand_total_value = 0.0f;
			double grand_total_adamt = 0.0f;
			float grand_total_del = 0.0f;
			float grand_total_bal = 0.0f;
			float grand_total_change = 0.0f;
			float grand_total_exp = 0.0f;
			float grand_total_paid = 0.0f;
			float grand_total_diff = 0.0f;

			String Phone = "";

			DecimalFormat df = new DecimalFormat("###,###.0");
			if (!order_type.equals("ALL")) {
		%>
		<br><h3> Difference Report</h3>
		<%
			} else {
		%>
		<br><h3> All Order Details</h3>
		<%
			}
		%>
		<br> Type :
		<%=pageType%>
		<br> Criteria:
		<%=criteria%>
		<input type="hidden" name="order_dt" value="<%=order_dt%>"> <input
			type="hidden" name="orderNo" value="">
		<table border="1" name="t" id="id" bordercolor="black"
			style="width: 100%; border-collapse: collapse; font-family: arial; font-size: 13px;">
			<tr valign="top" align="center">
				<td rowspan="2"><b>Area</b></td>
				<td rowspan="2"><b>Order</b></td>
				<td rowspan="2"><b>Customer</b></td>
				<td rowspan="2"><b>Phone</b></td>
				<td rowspan="2"><b>Order Date</b></td>
				<td rowspan="2"><b>Items</b></td>
				<td rowspan="2"><b>Payment</b></td>
				<td colspan="8" align="center"><b>Amounts</b></td>
			</tr>
			<tr>
				<td><b>Total</b></td>
				<td><b>Advance/Discount</b></td>
				<td><b>Del Chgs</b></td>
				<td><b>Change</b></td>
				<td><b>Expected</b></td>
				<td><b>Paid</b></td>
				<td><b>Pending</b></td>
			</tr>
			<%
				int i = 0;
				while (mo.rs.next()) {
					i = 1;
					orderNo = mo.rs.getString("order_num");
					custCode = mo.rs.getString("custcode");
					custName = mo.rs.getString("custname");
					Phone = mo.rs.getString("phone");
					buildingNo = mo.rs.getString("building_no");
					block = mo.rs.getString("block");
					wing = mo.rs.getString("wing");
					building = mo.rs.getString("building");
					area = mo.rs.getString("area");
					orderDate = mo.rs.getString("order_date");
					lastModifiedDate = mo.rs.getString("lastmodifieddate");
					totalItems = mo.rs.getString("total_items");
					totalValueMrp = mo.rs.getString("total_value_mrp");
					totalValuePrice = mo.rs.getFloat("total_value");
					discountAmt = mo.rs.getString("discount_amt");
					advanceAmt = mo.rs.getString("advance_amt");
					balanceAmt = mo.rs.getFloat("balance_amt");
					changeAmt = mo.rs.getFloat("change_amt");
					paidAmt = mo.rs.getFloat("paid_amt");
					expectedAmt = mo.rs.getFloat("expected_amt");
					//deliveryStaffName = mo.rs.getString("dstaff_name");
					statusCode = mo.rs.getString("status_code");
					delchgs = mo.rs.getFloat("delv_charges");
					payment = mo.rs.getString("payment_type_desc");
					grand_total_value = totalValuePrice + grand_total_value;
					grand_total_del = delchgs + grand_total_del;
					grand_total_bal = balanceAmt + grand_total_bal;
					grand_total_change = changeAmt + grand_total_change;
					grand_total_paid = paidAmt + grand_total_paid;
					grand_total_exp = expectedAmt + grand_total_exp;
			%>
			<tr>
				<td align="left"
					title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
					<%=area%>
				</td>
				<td align="center"
					title="<%=mo.rs.getString(12)%>,<%=mo.rs.getString(13)%><%=mo.rs.getString(14)%>,<%=mo.rs.getString(15)%>,<%=mo.rs.getString(8)%>">
					<a href="Javascript:passVar('<%=orderNo%>');"> <%=orderNo%>
				</td>
				<td align="left"><%=custName%></td>
				<td align="left"><%=Phone%></td>
				<td align="left"><%=orderDate%></td>
				<td align="right"><%=totalItems%></td>
				<td align="center"><%=payment%></td>
				<td align="right"><%=totalValuePrice%></td>
				<td align="right">
					<%
						if (advanceAmt != null && discountAmt != null) {
								adamt = Double.parseDouble(advanceAmt)
										- Double.parseDouble(discountAmt);
								grand_total_adamt = adamt + grand_total_adamt;
							}
							out.println(adamt);
					%>
				</td>
				<td align="right"><%=delchgs%></td>
				<td align="right">
					<%
						out.println(changeAmt);
							if (!order_type.equals("ALL")) {
					%>
				</td>
				<td align="right" bgcolor="#ECFB99">
					<%
						} else {
					%>
				</td>
				<td align="right">
					<%
						}
							out.println(expectedAmt);
							if (!order_type.equals("ALL")) {
					%>
				</td>
				<td align="right" bgcolor="#ECFB99">
					<%
						} else {
					%>
				</td>
				<td align="right">
					<%
						}
							out.println(paidAmt);
					%>
				</td>
				<td align="right">
					<%
						diffamt = balanceAmt;
							grand_total_diff = diffamt + grand_total_diff;
							out.println(balanceAmt);
					%>
				</tD>
			</tr>
			<%
				}
				mo.closeAll();
			%>
			<tr align="right" bgcolor="#ECFB99" style="color:red; font-weight: bold;">
				<td colspan="7">Grand Total</td>
				<td><%=df.format(grand_total_value) %></td>
				<td><%=grand_total_adamt%></td>
				<td><%=df.format(grand_total_del)%></td>
				<td><%=grand_total_change%>
				<%
 					if (!order_type.equals("ALL")) {
 				%>
				<td bgcolor="#ECFB99">
				<%
					} else {
				%>
				<td>
				 <%
 				}
				 	out.println(df.format(grand_total_exp)+"</td>");
				 	if (!order_type.equals("ALL")) {
				 %>
				<td bgcolor="#ECFB99">
					<%
					} else {
					%>
				<td> <%
					}
 					out.println(df.format(grand_total_paid));
 					%>
				
				</td>
				<td><%=df.format(grand_total_diff)%></font>
				</td>
			</tr>
			<input type="hidden" name="order_dt" value="<%=order_dt%>">
			<input type="hidden" name="close_status" value="<%=close_status%>">
			<input type="hidden" name="payment_type" value="<%=payment_type%>">
			<input type="hidden" name="pageType" value="<%=pageType%>">
			<input type="hidden" name="order_type" value="<%=order_type%>">

			<style type="text/css">
a:link {
	color: blue
}

a:hover {
	background: blue;
	color: white
}

a:active {
	background: blue;
	color: white
}
</style>
		</table>
		<%
			if (!str1.equals("1")) {
		%>
		<div id="div4" style="VISIBILITY: visible">
			<table>
				<tr>
					<td><a href="Javascript:Pass();">Save to excel</a>
					</td>
				</tr>
			</table>
		</div>
		<%
			}
		%>
		<script>
			function passVar(code) {
				document.myform.orderNo.value = code;
				document.myform.action = "print_order.jsp?&backPage=Reports.jsp&buttonFlag=Y";
				document.myform.submit();
			}
			function Pass() {
				document.myform.action = "ReportDifferenceListWithDateAnalysis.jsp?Exp=1";
				document.myform.submit();
			}
		</script>

	</form>
</body>
</html>

