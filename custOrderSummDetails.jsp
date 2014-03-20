	<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>
<%@page contentType="text/html"%>
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="custOrderSummDetails.jsp" />	
</jsp:include>


<%	
  	String custCode="";
  	custCode=request.getParameter("hcuscode");  
  	if(!custCode.equals("CC")){
  		
		  	customer.ManageCustomer c;
			c = new customer.ManageCustomer("jdbc/js");
			c.customerInfo(custCode); 
			String name="",phno="";
			String building="",buildingNo="";
			String block="",wing="",area="";
			String add1="",add2="",station="";		
			String last_order_date="";
			
			int last_order_num=0;
			int tot_orders_3=0;
			int tot_orders_6=0;
			int tot_orders_12=0;
			int avg_items_3=0;
			int avg_items_6=0;
			int avg_items_12=0;
			
			float fmcg_per_3=0.0f;
			float fmcg_per_6=0.0f;
			float fmcg_per_12=0.0f;
			float tot_savings_3=0.0f;
			float tot_savings_6=0.0f;
			float tot_savings_12=0.0f;
			float tot_value_3=0.0f;
			float tot_value_6=0.0f;
			float tot_value_12=0.0f;
		
			while(c.rs.next()){
				int i=1;
				  
				name=c.rs.getString(i++);
				phno=c.rs.getString(i++);
				custCode=c.rs.getString(i++);
				building=c.rs.getString(i++);
				buildingNo=c.rs.getString(i++);
				block=c.rs.getString(i++);
				wing=c.rs.getString(i++);
				area=c.rs.getString(i++);
				add1=c.rs.getString(i++);
				add2=c.rs.getString(i++);
				station=c.rs.getString(i++);
				fmcg_per_3=c.rs.getFloat(i++);
				last_order_date=c.rs.getString(i++);
				last_order_num=c.rs.getInt(i++);
				
				fmcg_per_6=c.rs.getFloat(i++);
				fmcg_per_12=c.rs.getFloat(i++);
				
				tot_orders_3=c.rs.getInt(i++);
				tot_orders_6=c.rs.getInt(i++);
				tot_orders_12=c.rs.getInt(i++);
				
				tot_savings_3=c.rs.getFloat(i++);
				tot_savings_6=c.rs.getFloat(i++);
				tot_savings_12=c.rs.getFloat(i++);
				
				tot_value_3=c.rs.getFloat(i++);
				tot_value_6=c.rs.getFloat(i++);
				tot_value_12=c.rs.getFloat(i++);
				
				avg_items_3=c.rs.getInt(i++);
				avg_items_6=c.rs.getInt(i++);
				avg_items_12=c.rs.getInt(i++);
						
			}
		  	
			c.closeAll();
		%>  
		
			
		
			
			
			
			<table width="40%" class="item3"  border="1" style="background-color:#FFE4C4">
			
			<tr>
				<td>
			<table id="1" border="0" align="left" width="300">
			
			<tr><th colspan="6"><center><b>Customer Information</b></center> </th></tr>
			<tr></tr><TR></TR>
			<tr></tr><TR></TR>
			<tr></tr><TR></TR>
			<tr>		
				<td> <b>Code&nbsp;&nbsp;&nbsp;&nbsp;: </b><%=custCode%></td>	
			</tr>
			<tr>		
				<td> <b>Name &nbsp;&nbsp;&nbsp;: </b> <%=name%> </td>	
			</tr>
			<tr>		
				<td><b>Address&nbsp;: </b><%=buildingNo%>, <%=block%>, <%=wing%>, <%=building%>, <%=area%></td>		
			</tr>
			<tr>		
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=add1%> ,<%=add2%>, <%=station%></td>		
			</tr>
			<tr>		
				<td><b>Phone &nbsp;&nbsp;:</b><%=phno%></td>		
			</tr>
			</table></td>	
			<td>
			<table  border="1" align="left"  width="200">
			<tr><th colspan="4"><center><b>Purchase Pattern</b></center> </th></tr>
				<tr>
					
					<td></td>
					<td><b>3M</b></td>
					<td><b>6M</b></td>
					<td><b>12M</b></td>
				</tr>	
				<tr>
					<td><b>Orders</b></td>
					<td align="right"><%=tot_orders_3%></td>	
					<td align="right"><%=tot_orders_6%></td>	
					<td align="right"><%=tot_orders_12%></td>	
				</tr>
				<tr>
					<td><b>FMCG (%)</b></td>
					<td align="right"><%=fmcg_per_3%></td>
					<td align="right"><%=fmcg_per_6%></td>
					<td align="right"><%=fmcg_per_12%></td>	
				</tr>
				<tr>
					<td><b>Value</b></td>
					<td align="right"><%=tot_value_3%></td>
					<td align="right"><%=tot_value_6%></td>
					<td align="right"><%=tot_value_12%></td>
				</tr>	
				<tr>
					<td><b>Savings</b></td>
					<td align="right"><%=tot_savings_3%></td>
					<td align="right"><%=tot_savings_6%></td>
					<td align="right"><%=tot_savings_12%></td>
				</tr>
				<tr>
					<td><b>AVG Items</b></td>
					<td align="right"><%=avg_items_3%></td>
					<td align="right"><%=avg_items_6%></td>
					<td align="right"><%=avg_items_12%></td>
				</tr>	
		 	</table> 	
		 	</td></tr></table>
		 	
		 	<br><BR><BR>
		 	
		 	<%
					DecimalFormat df = new DecimalFormat("###,###.00");
					DecimalFormat dfQty = new DecimalFormat("0.000");
					DecimalFormat dfQty1 = new DecimalFormat("0");
					//System.out.println("last_order_num: "+last_order_num);	
					if(last_order_num!=0){
						
						String orderDate="";				
						int totalItems=0;
						long item_taken=0;				
						float totalValue=0.0f;			
						
						float itemRate=0.0f;
						float itemQty=0.0f;
						float itemTotPrice=0.0f;
						float itemMRP=0.0f;
						float totalValueMRP=0.0f;
						float savings=0.0f;
						float totalValueDis=0.0f;
						float itemTotDis=0.0f;
						float comm_amt=0.0f;
						float tot_comm=0.0f;
						
						String itemName="";
						String itemWeight="";				
						String p_type="";
						String disRemark="";
		        	    int i=0;
		        	    
		        	    String query="";
					Connection conn=null;
					Statement stat=null;	
					ResultSet rs=null;
				try{	
					Context initContext = new InitialContext();
					Context envContext  = (Context)initContext.lookup("java:/comp/env");
					DataSource ds = (DataSource)envContext.lookup("jdbc/js");
					conn = ds.getConnection();
					stat=conn.createStatement();		
					
		
					query="select a.total_items, a.total_value, " +					
							"b.rate, b.qty, b.price, b.mrp, b.item_discount, b.remark,b.item_taken, e.payment_type_desc, " + 
						  	"d.item_name, d.item_weight, d.comm_amt, a.order_num, a.order_date " +				  	
							"from orders a, order_detail b, item_master d ,payment_type e " +
							"where a.order_num = b.order_num " +					
							"and b.item_code = d.item_code " +
							"and a.payment_type_code = e.payment_type_code "+
							"and a.order_num = (SELECT max(order_num) FROM orders where custcode = '"+custCode+"') "+
							"order by b.entry_no";
							
						System.out.println("order list: "+query);						
						rs=stat.executeQuery(query);		
						int ctr = 0, j=0, itemCount=0;
					while(rs.next()) {
					    
						i=1;				
						totalItems=rs.getInt(i++);
						totalValue=rs.getFloat(i++);
						
						itemRate=rs.getFloat(i++);
						itemQty=rs.getFloat(i++);
							
						itemTotPrice=rs.getFloat(i++);
						itemMRP=rs.getFloat(i++);
						itemTotDis=rs.getFloat(i++);
						disRemark=rs.getString(i++);
						item_taken=rs.getLong(i++);			
						p_type=rs.getString(i++);
						
						itemName=rs.getString(i++);
						itemWeight=rs.getString(i++);
						comm_amt=rs.getFloat(i++);	
						last_order_num = rs.getInt(i++);
						last_order_date = rs.getString(i++);
						tot_comm = tot_comm + (itemQty * comm_amt);				
			if (ctr==0) {			
			%>	
			<table align="left" width="75%" border="1" class="item3" style="background-color:#FFE4C4">	
			
			<th colspan=4><center>Last Order Details</center></th>
			<th>Order No. : <%=last_order_num%> </th>
			<th colspan=3>Order Date. : <%=last_order_date%> </th>		
			<tr>
					<td ><b>Item</b></td>
					<td ><b>Rate</b></td>		
					<td><b>Weight</b></td>			
					<td><b>Qty</b></td>
					<td colspan="2"><b><center>Price</center></b></td>
					<td colspan="2"><b><center>Deals</center></b></td>
					
				</tr>
				
				<tr>
					<td colspan=4>&nbsp;</td>
					<td><b>Janta's Price</b></td>
					<td ><b>MRP</b></td>
					<td><b>Discount</b></td>
					<td><b>Remark</b></td>		
					
				</tr>
				
<% 				ctr = ctr + 1; 
			} 
				savings = itemMRP - itemTotPrice;
				if(savings<0)
					savings=0.0f;			
%>
			
		<tr>
			<td width='15%' align=left><%=itemName%></td>
			<td  width='10%' align=right><%=itemRate%></td>	
			<td width='10%' valign=top><%=itemWeight%></td>	
			<td width='6%' valign=top><%=dfQty1.format(itemQty)%></td>
					
			<td width='8%' valign=top align=right><%=itemTotPrice%></td>
			<% if(itemMRP<=0) { %>
			<td width='8%' valign=top align=right>NA</td>
			<% } else { %>
			<td width='8%' valign=top align=right><%=df.format(itemMRP)%></td>
			<%}%>
			<td align='right' width='6%'><%= df.format(savings)%>/-</td>
			<td width='6%'><%=disRemark%></td></tr>
		
		<%		}
			long item_deliver = totalItems-item_taken;
			if (ctr!=0) {	
		%>
		
			<tr>
			
					<th> <div id='totalSel' align="left"><b>Total items:  <%=totalItems%> <br>
					 Pickup: <%=item_taken%>  <br> Deliver: <%=item_deliver%> </b></div></th>
					<th><b>Payment : <%=p_type%></b></th><th></th><th></th>
					<th align=right><div id='totalValue' align="right"><b>Total: <%=totalValue%></b></th>
					<th align=left colspan=2><div id='totalComm' align="right">Commission: <%=tot_comm%></b></th>
					<input type="hidden" name="comm" value="<%=tot_comm%>">
				</tr>
		<%
			}
				rs.close();
				stat.close();
				conn.close();
			}catch(Exception e)
			{
				System.out.println(e);
				rs.close();
				stat.close();
				conn.close();
			}
		}
}
%>
</table>