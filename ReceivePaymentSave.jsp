<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="payment.ManagePayment"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="header.jsp"></jsp:include>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script>
function printRecept(){
   var html="<html>";
   html+= document.getElementById("pay_recept").innerHTML;
   html+="</html>";

   var printWin = window.open('','','left=350,top=100,width=500,height=400,toolbar=0,scrollbars=2,status  =0');
   printWin.document.write(html);
   printWin.document.close();
   printWin.focus();
   printWin.print();
   printWin.close();
   window.location="EditTargetReportForm.jsp?call_type=receive_payment";
}
</script>
<title>Save Receive Payment</title>
</head>
<body>
<br/><br/><br/>
<center>
<%
	String ord_no[] = request.getParameterValues("ord_num");
	String balance[] = request.getParameterValues("balance");
	String dist_amt[] = request.getParameterValues("dist_amt");
	String date[] = request.getParameterValues("date");
	String waived[] = request.getParameterValues("waived");
	String pay_code = request.getParameter("pay_code");
	int row_count = Integer.parseInt(request.getParameter("row_count"));
	String cust_code = request.getParameter("cust_code");
	ManagePayment mp = new ManagePayment("jdbc/js");
	boolean success = false;
	boolean error = true;
	if(mp.isPayCodeExist(pay_code)){
		if(mp.savePayment(pay_code, cust_code, session.getAttribute("UserName").toString(), request.getParameter("total_payment"),request.getParameter("rem_amt_send"))){
			if(mp.saveDistributedPayment(pay_code, ord_no, balance ,dist_amt,waived))
				success = true;	
		} else {
			error = false;
			out.print("<h2>Error In Saving Payment</h2>");
		}
	} else {
		out.print("<h2>Payment Allready Saved</h2>");
	}
	mp.closeAll();
	if(error){
		float waived_amount = 0.0f;
		DateFormat df = new SimpleDateFormat("dd MMM yyyy HH:mm");
	%>
		<div id = "pay_recept" style="border:1px Solid Black; width: 500px;font: serif;" align="center">
			<table style="width: 100%;">
				<tr style="width: 100%;">
					<td style="width: 20%;" align="left"><b>Pay Code : </b></td>
					<td style="width: 30%;" align="left"><%=pay_code%></td>
					<td style="width: 20%;" align="left"><b>Date :</b></td>
					<td style="width: 30%;" align="left"><%= df.format(new Date()) %></td>
				</tr>
				<tr style="width: 100%;">
					<td style="width: 20%;" align="left"><b>Cust. Name : </b></td>
					<td style="width: 30%;" align="left"><%=request.getParameter("cust_name") %></td>
					<td style="width: 20%;" align="left"><b>Phone no :</b></td>
					<td style="width: 30%;" align="left"><%=request.getParameter("phone") %></td>
				</tr>
				<tr style="width: 100%;">
					<td style="width: 25%;" align="left"><b>Address : </b></td>
					<td style="width: 75%;" colspan="3" align="left"><%=request.getParameter("address") %></td>
				</tr>
				<tr><td colspan="4">&nbsp;</td></tr>
				<tr style="width: 100%;">
					<td  colspan="4" style="width: 100%;">
						<table style="width: 100%;" border="1">
							<tr style="width: 100%;">
								<th style="width: 20%;" align="left">Date</th>
								<th style="width: 20%;" align="left">Order no.</th>
								<th style="width: 20%;" align="left">Balance (Rs)</th>
								<th style="width: 20%;" align="left">Pay/order (Rs)</th>
								<th style="width: 20%;" align="left">Rem Bal (Rs)</th>
							</tr>
							<%
							for(int i=0;i<row_count;i++){
								float amt = Float.parseFloat(dist_amt[i]);
								if(amt>0){
									waived_amount = waived_amount + Float.parseFloat(waived[i]);
									float rem = Float.parseFloat(balance[i]) - amt;
									%>
									<tr style="width: 100%;">
										<td style="width: 20%;" align="left"><%=date[i] %></td>
										<td style="width: 20%;" align="left"><%=ord_no[i] %></td>
										<td style="width: 20%;" align="left"><%=balance[i] %></td>
										<td style="width: 20%;" align="left">
											<%
												if(Float.parseFloat(waived[i]) == 0){
													out.print(dist_amt[i]);
												} else {
													out.print(dist_amt[i]+" (W : "+waived[i]+")");
												}
											%>
										</td>
										<td style="width: 20%;" align="left"><%=rem %></td>
									</tr>
									<%
								}
							}
							%>
							
					</table>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<b>Total Payment :  </b>
					</td>
					<td colspan="2">
						Rs : <%= request.getParameter("total_payment") %>/-(<%= waived_amount %>/- Rs Waived)
					</td>
				</tr>
				<tr>
					<td colspan="4" style="height: 100px;" align="left">
						<b>Received By : </b><%= session.getAttribute("UserName").toString() %>
					</td>
				</tr>
			</table>
		</div>
		<br/>
		<div >
			<input type="button" accesskey="p" onclick="printRecept()" value="Print <Alt+p>"/>
		</div>
	<%
	}
	%>	
		
</center>
</body>
</html>