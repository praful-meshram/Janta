
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<jsp:include page="sessionBoth.jsp?formName=RDeliveryDailyReportDetails.jsp"/>
<form name="myform" method="post" action="RDeliveryDailyReportDetailsPrint.jsp">
<table border="0">
<%
	String order_date=request.getParameter("order_date");
	String pageType="Summary";
	report.ManageReports c;
	//c = new report.ManageReports("jdbc/js");
	c = new report.ManageReports("jdbc/re");
	String payment_type=""; 
	int htotal_orders=0;		
	float hchange_amt= 0.0f;
	float hpaid_amt= 0.0f;
	float hexpected_amt= 0.0f;
	float hrecevied_amt= 0.0f;
	float hdifference_amt= 0.0f;
	int ctotal_orders=0;		
	float cchange_amt= 0.0f;
	float cpaid_amt= 0.0f;
	float cexpected_amt= 0.0f;
	float crecevied_amt= 0.0f;
	float  cdifference_amt= 0.0f;
	int catotal_orders=0;		
	float cachange_amt= 0.0f;
	float capaid_amt= 0.0f;
	float caexpected_amt= 0.0f;
	float carecevied_amt= 0.0f;
	float cadifference_amt= 0.0f;
	c.listDeliveryDailyReportDetails(order_date); 
	while(c.rs.next()) {
		if(c.rs.getString(1).equals("H")){
			htotal_orders=c.rs.getInt(2);
			hpaid_amt=c.rs.getFloat(3);
			hchange_amt=c.rs.getFloat(4);
			hrecevied_amt=c.rs.getFloat(5);
			hexpected_amt=c.rs.getFloat(6);
			hdifference_amt=c.rs.getFloat(7);
		}
		if(c.rs.getString(1).equals("CR")){
			ctotal_orders=c.rs.getInt(2);
			cpaid_amt=c.rs.getFloat(3);
			cchange_amt=c.rs.getFloat(4);
			crecevied_amt=c.rs.getFloat(5);
			cexpected_amt=c.rs.getFloat(6);
			cdifference_amt=c.rs.getFloat(7);
		}
		if(c.rs.getString(1).equals("CASH/CHEQUE")){		
			catotal_orders=c.rs.getInt(2);
			capaid_amt=c.rs.getFloat(3);
			cachange_amt=c.rs.getFloat(4);
			carecevied_amt=c.rs.getFloat(5);
			caexpected_amt=c.rs.getFloat(6);
			cadifference_amt=c.rs.getFloat(7);
		}
	}	
	c.closeAll();
%>			
	<tr>
		<td colspan=4><fieldset><legend>Hawala</legend><table align="left">					
				<tr>
					<td><b><font color="blue">D</font>ate:</b><%=order_date%></td><td></td>
					<td><b>Total <font color="blue">O</font>rders</b></td><td><b>:</b></td><td><a  href="ReportDifferenceListWithDate.jsp?order_dt=<%=order_date%>&Exp=0,&pageType=<%=pageType%>&order_type=ALL&payment_type=H" ><%=htotal_orders%></a></td>
				</tr>
				<tr>
					<td><b>Paid <font color="blue">A</font>mount</b></td><td><b>:</b></td><td><%=hpaid_amt%></td>
				</tr>
				<tr>
					<td><b>Less <font color="blue">C</font>hange</b></td><td><b>:</b></td><td><%=hchange_amt%></td>
				</tr>	
				<tr>
					<td><b><font color="red">Received Amount </font></b></td><td><b>:</b></td><td><%=hrecevied_amt%></td>
				</tr>	
				<tr>
					<td><b>Exp. <font color="blue">A</font>mount</b></td><td><b>:</b></td><td><%=hexpected_amt%></td>
				</tr>
				<tr>
					<td><b>Diff. <font color="blue">A</font>mount</b></td><td><b>:</b></td><td><a  href="ReportDifferenceListWithDate.jsp?order_dt=<%=order_date%>&Exp=0,&pageType=<%=pageType%>&order_type=PMTDIFF&payment_type=H" >
<%			
	  	 	out.println(hdifference_amt);
%>    	 	
    	 	</a></td></tr>				
			</table></fieldset></td><td colspan="10"></td>
			<td colspan=4><fieldset><legend>Cash/Cheque</legend><table align="left">					
				<tr>
					<td><b><font color="blue">D</font>ate:</b><%=order_date%></td><td></td>
					<td><b>Total <font color="blue">O</font>rders:</b><a  href="ReportDifferenceListWithDate.jsp?order_dt=<%=order_date%>&Exp=0,&pageType=<%=pageType%>&order_type=ALL&payment_type=CACHQ" ><%=catotal_orders%></a></td>
			</tr>
			<tr>
				<td><b>Paid <font color="blue">A</font>mount</b></td><td><b>:</b></td><td><%=capaid_amt%></td>
			</tr>
			<tr>
				<td><b>Less <font color="blue">C</font>hange</b></td><td><b>:</b></td><td><%=cachange_amt%></td>
			</tr>	
			<tr>
				<td><b><font color="red">Received  Amount</font></b></td><td><b>:</b></td><td><%=carecevied_amt%></td>
			</tr>	
			<tr>
				<td><b>Exp.<font color="blue">A</font>mount</b></td><td><b>:</b></td><td><%=caexpected_amt%></td>
			</tr>
			<tr>
				<td><b>Diff.<font color="blue">A</font>mount</b></td><td><b>:</b></td><td><a  href="ReportDifferenceListWithDate.jsp?order_dt=<%=order_date%>&Exp=0,&pageType=<%=pageType%>&order_type=PMTDIFF&payment_type=CACHQ" >
<%			
	  	 	out.println(cadifference_amt);
%>    	 	
    	 	</a></td></tr>				
				</table></fieldset></td></tr>
			<tr> </tr>		
			<tr>	
			<td colspan=4><fieldset><legend>Credit</legend><table align="left">					
			<tr>
				<td><b><font color="blue">D</font>ate:</b><%=order_date%></td><td></td>
				<td><b>Total <font color="blue">O</font>rders:</b><a  href="ReportDifferenceListWithDate.jsp?order_dt=<%=order_date%>&Exp=0,&pageType=<%=pageType%>&order_type=ALL&payment_type=CR" ><%=ctotal_orders%></a></td>
			</tr>
			<tr>
				<td><b>Paid <font color="blue">A</font>mount</b></td><td><b>:</b></td><td><%=cpaid_amt%></td>
			</tr>
			<tr>
				<td><b>Less <font color="blue">C</font>hange</b></td><td><b>:</b></td><td><%=cchange_amt%></td>
			</tr>	
			<tr>
				<td><b><font color="red">Received  Amount</font></b></td><td><b>:</b></td><td><%=crecevied_amt%></td>
			</tr>	
			<tr>
				<td><b>Exp.<font color="blue">A</font>mount</b></td><td><b>:</b></td><td><%=cexpected_amt%></td>
			</tr>
			<tr>
				<td><b>Diff.<font color="blue">A</font>mount</b></td><td><b>:</b></td><td><a  href="ReportDifferenceListWithDate.jsp?order_dt=<%=order_date%>&Exp=0,&pageType=<%=pageType%>&order_type=PMTDIFF&payment_type=CR" >
<%			
	  	 	out.println(cdifference_amt);
%>    	 	
    	 	</a></td>    
			</tr>				
				</table></fieldset></td>
			</tr>
<tr></tr>			
<tr><td colspan="4"></td><td>
<input type="button" name="print" accesskey="p" value="Print <Alt+p>" align="right" class="print" onclick="window.print();"></td></tr>
<input type="hidden" name="order_date" value="<%=order_date%>">
</table>
</body>
<style>
@media print{
.print{
	display: none !important;
	}
}
</style>
</html>			
					