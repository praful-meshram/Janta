<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%
String order_date=request.getParameter("order_date");
String close_status=request.getParameter("close_status");
%>
<jsp:include page="header.jsp"></jsp:include>
<br/>
<div id="print_div" style="border: 1px solid black; width: 600px;">
<table style="font-family: arial;font-size: 14px;">
<%
		//String del_date=request.getParameter("del_date");
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
	c.VlistDeliveryDailyReportDetails(order_date,close_status); 
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
	<tr align="left">
		<td colspan=4>
			<fieldset>
				<legend>Hawala</legend>
					<table align="left">					
						<tr>
							<td><b>Date:</b><%=order_date.substring(0, 10) %></td>
							<td></td>
							<td><b>Total Orders</b></td>
							<td><b>:</b></td>
							<td><a  href="ReportDifferenceListWithDateAnalysis.jsp?order_dt=<%=order_date%>&close_status=<%=close_status%>&Exp=0,&pageType=<%=pageType%>&order_type=ALL&payment_type=H" >
								<%=htotal_orders%></a>
							</td>
						</tr>
						<tr>
							<td><b>Paid Amount</b></td>
							<td><b>:</b></td>
							<td><%=hpaid_amt%></td>
						</tr>
						<tr>
							<td><b>Less Change</b></td>
							<td><b>:</b>
							</td><td><%=hchange_amt%></td>
						</tr>	
						<tr>
							<td><b>Received Amount</b></td>
							<td><b>:</b></td>
							<td><%=hrecevied_amt%></td>
						</tr>	
						<tr>
							<td><b>Pending Amount</b></td>
							<td><b>:</b></td>
							<td><a  href="ReportDifferenceListWithDateAnalysis.jsp?order_dt=<%=order_date%>&close_status=<%=close_status%>&Exp=0,&pageType=<%=pageType%>&order_type=PMTDIFF&payment_type=H" >
								<%=hdifference_amt%>    	 	
		    	 				</a>
		    	 			</td>
		    	 		</tr>				
					</table>
				</fieldset>
			</td><td colspan="10"></td>
			<td colspan=4>
				<fieldset><legend>Cash/Cheque</legend>
					<table align="left">					
						<tr>
							<td><b>Date:</b><%=order_date.substring(0,10)%></td>
							<td></td>
							<td><b>Total Orders:</b><a  href="ReportDifferenceListWithDateAnalysis.jsp?order_dt=<%=order_date%>&close_status=<%=close_status%>&Exp=0,&pageType=<%=pageType%>&order_type=ALL&payment_type=CACHQ" >
								<%=catotal_orders%></a>
							</td>
							</tr>
							<tr>
								<td><b>Paid Amount</b></td>
								<td><b>:</b></td>
								<td><%=capaid_amt%></td>
							</tr>
							<tr>
								<td><b>Less Change</b></td>
								<td><b>:</b></td>
								<td><%=cachange_amt%></td>
							</tr>	
							<tr>
								<td><b>Received  Amount</b></td>
								<td><b>:</b></td>
								<td><%=carecevied_amt%></td>
							</tr>	
							<tr>
							<td><b>Pending Amount</b></td>
							<td><b>:</b></td>
							<td>
								<a  href="ReportDifferenceListWithDateAnalysis.jsp?order_dt=<%=order_date%>&close_status=<%=close_status%>&Exp=0,&pageType=<%=pageType%>&order_type=PMTDIFF&payment_type=CACHQ" >
									<%=cadifference_amt%>    	 	
    	 						</a>
    	 					</td>
    	 				</tr>				
					</table>
				</fieldset>
			</td>
		</tr>
		<tr> 
		</tr>		
		<tr align="left">	
			<td colspan=4>
				<fieldset><legend>Credit</legend>
					<table align="left">					
						<tr>
							<td><b>Date:</b><%=order_date.substring(0,10)%></td>
							<td></td>
							<td><b>Total Orders:</b><a  href="ReportDifferenceListWithDateAnalysis.jsp?order_dt=<%=order_date%>&close_status=<%=close_status%>&Exp=0,&pageType=<%=pageType%>&order_type=ALL&payment_type=CR" >
								<%=ctotal_orders%></a>
							</td>
						</tr>
						<tr>
							<td><b>Paid Amount</b></td>
							<td><b>:</b></td>
							<td><%=cpaid_amt%></td>
						</tr>
						<tr>
							<td><b>Less Change</b></td>
							<td><b>:</b></td>
							<td><%=cchange_amt%></td>
						</tr>	
						<tr>
							<td><b>Received  Amount</b></td>
							<td><b>:</b></td>
							<td><%=crecevied_amt%></td>
						</tr>	
						<tr>
							<td><b>Pending Amount</b></td>
							<td><b>:</b></td>
							<td>
								<a  href="ReportDifferenceListWithDateAnalysis.jsp?order_dt=<%=order_date%>&close_status=<%=close_status%>&Exp=0,&pageType=<%=pageType%>&order_type=PMTDIFF&payment_type=CR" >
									<%=cdifference_amt%>    	 	
			    	 			</a>
			    	 		</td>    
						</tr>				
					</table>
				</fieldset>
			</td>
		</tr>
		<tr></tr>			
		<tr><td colspan="4"></td><td>
	</table>
	</div>
	<input type="submit" name="print" value="Print" onclick="print();">
	<script>
	function print(){
		var html = "<html>";
		html += document.getElementById("print_div").innerHTML;
		html += "</html>";
		var printWin = window.open('', '',
				'left=3,top=4,width=700,height=350,toolbar=0,scrollbars=2,status  =0');
		printWin.document.write(html);
		printWin.document.close();
		printWin.focus();
		printWin.print();
		printWin.close();
	}
	</script>
</body>
</html>			
					