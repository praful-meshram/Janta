<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@page contentType="text/html"%>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="lastOrderDetails.jsp" />	
</jsp:include>
 --%>
 
 
<%@ page errorPage="ErrorPage.jsp?page=lastOrderDetails.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 		

<%
			DecimalFormat df = new DecimalFormat("###,###.00");
			DecimalFormat dfQty = new DecimalFormat("0.000");
			DecimalFormat dfQty1 = new DecimalFormat("0");
				
			int last_order_num=0;		
			last_order_num=Integer.parseInt(request.getParameter("orderNoStartWith"));	
			if(last_order_num!=0){			
				
				String last_order_date="",itemCode="",pageName="";
				last_order_date=request.getParameter("orderDateStartWith");	
				pageName=request.getParameter("pageName");				
				String orderDate="";				
				int totalItems=0,totalItemsTaken=0 , entry_no=0;
				long item_taken=0,itemTaken=0;				
				float totalValue=0.0f;			
				int itemCount=0;
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
				float totMrp=0.0f;
				
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
				  	"d.item_name, d.item_weight, d.comm_amt,b.item_code,a.total_taken,a.total_value_mrp,b.entry_no,b.price_version,a.site_id " +				  	
					"from orders a, order_detail b, item_master d ,payment_type e " +
					"where a.order_num = b.order_num " +					
					"and b.item_code = d.item_code " +
					"and a.payment_type_code = e.payment_type_code "+
					"and a.order_num = '" + last_order_num + "' and b.item_returned=0 "+
					"order by b.entry_no";
					
									
				rs=stat.executeQuery(query);		
				int ctr = 0, j=0, checkIndex=0;
				
			while(rs.next()) {
				
				if(checkIndex==0)
					checkIndex=0;				   
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
				if(item_taken==1)		
					itemTaken++;
				p_type=rs.getString(i++);
				
				itemName=rs.getString(i++);
				itemWeight=rs.getString(i++);
				comm_amt=rs.getFloat(i++);
				itemCode=rs.getString(i++);	
				totalItemsTaken=rs.getInt(i++);
				totalValueMRP=rs.getFloat(i++);	
				entry_no =	 rs.getInt(i++);
				int priceVersion = rs.getInt("price_version");
				int siteId= rs.getInt("site_id");
				tot_comm = tot_comm + (itemQty * comm_amt);	
								
	if (ctr==0) {			
	%>	
	
	<table align=center  border="1" class="item3" style="background-color:#FFE4C4; border-collapse: collapse;width: 90%; border-color: black;" bordercolor=black>	
	<tr>
		<td colspan="10" align=left>
			<b><font color="blue" size ="2">Note * </font>
			<font color=red size ="1.9">Colour in Qty indicates picked item.</font></b>
		</td>
	</tr>
	<tr>
		<th colspan=4>Order Details</th>
		<th colspan=2>Order No. : <%=last_order_num%> </th>
		<th colspan="4">Order Date. : <%=last_order_date%> </th>	
	</tr>	
	<tr>
			<%if(pageName.equals("DeliveryActionForm")){%>
			<td rowspan="2" align="center"><b>Return</b></td>		
			<%}%>	
			<td rowspan="2"><b>Item</b></td>
			<td rowspan="2"><b>Rate</b></td>		
			<td rowspan="2"><b>Weight</b></td>
			<%if(pageName.equals("DeliveryActionForm")){ %>
				<td rowspan="2"><b>Old Qty</b></td>
				<td rowspan="2"><b>New Qty</b></td>
	        <%}else{%>					
			<td rowspan="2"><b>Qty</b></td>
			<%}%>
			<th colspan="2"><b>Price</b></th>
			<th colspan="2"><b>Deals</b></th>			
		</tr>
		
		<tr>	
			<td><b>Janta's Price</b></td>
			<td ><b>MRP</b></td>
			<td><b>Discount</b></td>
			<td><b>Remark</b></td>		
			
		</tr>

<% ctr = ctr + 1; 
	} 
	savings = itemMRP - itemTotPrice;
	if(savings<0)
		savings=0.0f;
	
	%>
	
<tr style="background-color: #FFE4a4;">	
	<%if(pageName.equals("DeliveryActionForm")){ %>
	<td width='8%' align="center">
		<input type="checkbox" name="chck" value="<%=itemCode%>" id="chck_<%=itemCount%>"
		onclick="SelectReturnedItem('<%=itemRate%>','<%=checkIndex%>','<%=itemTotPrice%>','<%=itemQty%>','<%=item_taken%>','<%=itemCode%>','<%=itemMRP%>','<%=pageName%>','<%=itemCount%>','<%=entry_no%>',this);">
	</td>
	<%}%>	
	<td style="display: none;"><input type="text" value="<%=itemCode %>" name="hItemCode"></td>
	<td style="display: none;"><input type="text" value="<%=priceVersion %>" name="hPriceVersion"></td>
	<td style="display: none;"><input type="text" value="<%=siteId %>" name = "hSiteId"></td>
	
	
	<td style="width: 15%; padding: 0px 0px 0px 5px;" align=left><%=itemName%></td>
	<td style="width: 10%; padding: 0px 5px 0px 5px;" align=right><%=itemRate%></td>	
	<td style="width: 10%; padding: 0px 0px 0px 5px;" ><%=itemWeight%></td>	
	<td style="display: none;"><input type="hidden" name="outQty" value="<%=dfQty1.format(itemQty)%>"/></td>
	<%
	System.out.println("itemcode "+itemCode+"\t price vesion "+priceVersion+"\tsiteid "+siteId);
	if(item_taken==1){%>
	<td style="width: 6%; padding: 0px 0px 0px 5px;" valign=top BGCOLOR=#FF99FF  >
	<input type="hidden" value="<%=itemQty%>" id='prevQtyTextField<%=itemCount%>' name="prevQtyTextField">
	<div id="divPrevQty<%=itemCount%>"><%=dfQty1.format(itemQty)%></div></td>
	<%}else if(item_taken==0){%>	
	
	<td style="width: 6%; padding: 0px 0px 0px 5px;">
	<input type="hidden" value="<%=itemQty%>" id='prevQtyTextField<%=itemCount%>' name="prevQtyTextField">
	<div id="divPrevQty<%=itemCount%>"><%=dfQty1.format(itemQty)%></div></td>
	<%} %>
	<%if(pageName.equals("DeliveryActionForm")){ %>
		<td style="width: 6%; padding: 0px 5px 0px 5px;" valign="middle">
			<input type="hidden" value="<%=itemQty%>" id='newQtyTextField<%=itemCount%>' name="newQtyTextField">
			<div id="divNewQty<%=itemCount%>" style="float: left; vertical-align: middle;margin-top: 6px;"><%=dfQty1.format(itemQty)%></div>
			<div id='divInQty<%=itemCount%>' style="VISIBILITY:hidden; float: right;">
				<input type="text" size="2" 
					name="inQty<%=itemCount%>" 
					id="inQty_<%=itemCount%>"
					onblur="funchckempty(this);" 
					onchange="funInQty('<%=itemRate%>','<%=checkIndex%>','<%=itemTotPrice%>','<%=itemQty%>','<%=item_taken%>','<%=itemCode%>','<%=itemMRP%>','<%=pageName%>','<%=itemCount%>','<%=entry_no%>',this);" 
					onkeypress="return isNumberKey(event)"></div>
		</td>
	<%}%>
	<%if(pageName.equals("DeliveryActionForm")){ %>
		<td style="width: 6%; padding: 0px 5px 0px 5px;"><div id="divTotalPrice<%=itemCount%>"><%=itemTotPrice%></div></td>
	<%}else{%>		
		<td style="width: 6%; padding: 0px 5px 0px 5px;" valign=top align=right><%=itemTotPrice%></td>
	<%}%>
	<% if(itemMRP<=0) { %>
	<td style="width: 8%; padding: 0px 5px 0px 5px;" align=right>NA</td>
	<% } else { %>
	<td style="width: 8%; padding: 0px 5px 0px 5px;" align=right id="mrp_td_<%=itemCount%>"><%=df.format(itemMRP)%></td>
	<%}%>
	
	<td align='right' style="width: 6%; padding: 0px 5px 0px 5px;"><%= df.format(savings)%>/-</td>
	<td width='6%'><%=disRemark%>
	<input type="hidden" name="hentry<%=itemCount%>" value="<%=entry_no%>" id="hentry_id_<%=itemCount %>"/></td></tr>
<%	checkIndex++;
	itemCount++;	
	totMrp = totMrp + itemMRP*itemQty;
	}
	//long item_deliver = totalItems-item_taken; previous code(Sanketa)
	long item_deliver = totalItems-totalItemsTaken;
%>

	<tr>
	
			<th>
				<div id='totalSel' align="left">
					<b> Total items:  <label id="totItems"><%=totalItems%></label> <br>
						Pickup: <label id="pickup"> <%=itemTaken%> </label> <br> 
						Deliver:<label id="deliver"> <%=item_deliver%></label> 
						<input type="hidden" name="count" value="<%=itemCount%>" id="row_count"/>
					</b>
				</div>
			</th>
			
<%		if(pageName.equals("DeliveryActionForm")){%>
			<th><b>Payment : <%=p_type%></b></th><th></th><th></th><th></th>
		<%}else if(!pageName.equals("DeliveryActionForm")){%>		
			<th><b>Payment : <%=p_type%></b></th><th></th><th></th>
<%}%>			
		<%if(pageName.equals("DeliveryActionForm")){ %>
			<th align=right></th>
		<%}%>		
			<th align=right><div id='totalValue' align="right"><b>Total: <label id="totVal"><%=totalValue%></label></b></div></th>
			<th align=right><div id='totalValue' align="right"><b>Total MRP: <label id="totMrp"><%=df.format(totMrp)%></label></b></div></th>
			<th align=left colspan=2><div id='totalComm' align="right">Commission: <label id="comm"><%=df.format(tot_comm)%></label></b>
			<input type="hidden" name="comm" value="<%=tot_comm%>"/>
			<input type="hidden" name="hreturnval" value="<%=itemName%>"/>	
			<input type="hidden" name="htotalmrp" value="<%=totalValueMRP%>"/>	</div></th>					
		</tr>
<%
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

%>

</table>







