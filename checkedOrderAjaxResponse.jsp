
<%@page import="java.sql.ResultSet"%>
<%@page import="item.ManageItem"%>
<%	
String ajaxCallOption = request.getParameter("ajaxCallOption");


if(ajaxCallOption.equals("checkOrderExistance")){
	String orderNo = request.getParameter("orderNo");
	order.ManageOrder mo = new order.ManageOrder("jdbc/js");
		boolean result = mo.isExistOrderNumber(orderNo,"SUBMITTED");    	
    	if(result){
    		out.println("Exist");
    	}else{
    		out.println("NotExist");
    	}  	
    	mo.closeAll();
}else if(ajaxCallOption.equals("getCustInfo")){	
			
	String cust_code, custname,phone, building, building_no,wing, block,add1, add2, add3; 
	String area, station;	
	String orderNo = request.getParameter("orderNo");
	
	customer.ManageCustomer mc = new customer.ManageCustomer("jdbc/js");
	mc.getCustInfoByOrderNumber(orderNo);
	while(mc.rs.next()){
		cust_code = mc.rs.getString("custcode");
		custname = mc.rs.getString("custname");
		phone = mc.rs.getString("phone");
		building = mc.rs.getString("building");
		building_no = mc.rs.getString("building_no");
		wing = mc.rs.getString("wing");
		block = mc.rs.getString("block");
		add1 = mc.rs.getString("add1");
		add2 = mc.rs.getString("add2");
		area = mc.rs.getString("area");
		station = mc.rs.getString("station");
%>
		<div class="roundedDiv"  style="background-color: #BEF781;border:1px solid black; width: 100%;">
		 <table  class="custorderinfo"  style="width:100%;">
		  <thead>
		   <tr>
	  		 <th width="8%"><b>Customer_Code  </b></th> <td width="8%">: <% out.println(cust_code);%>&nbsp;</td>			  	  	  	
			  <th width="8%"><b>Customer_Name  </b> </th> <td width="16%">: <% out.println(custname);%>&nbsp;</td>			  
			  <th width="8%"><b>Phone_Number  </b> </th> <td width="10%">: <% out.println(phone);%>&nbsp;</td>			  			
			  <th width="3%"><b>Building  </b></th> <td width="12%">: <% out.println(building);%>&nbsp;</td>			  
			  <th width="5%"><b>Building_No.  </b> </th> <td width="9%">: <% out.println(building_no);%>&nbsp;</td>			
			  <th width="2%"><b>Wing  </b></th> <td width="5%">: <% out.println(wing);%></td>		  
		   </tr>
		   <tr><td height="10px;"></td></tr>
		   <tr>
            <th><b>Block   </b> </th> <td>: <% out.println(block);%>&nbsp;</td> 			
			<th><b>Address1 </b></th> <td> : <% out.println(add1);%>&nbsp;</td> 			 
			<th><b>Address2  </b> </th> <td>: <% out.println(add2);%>&nbsp;</td> 			
			<th><b>Area </b></th><td>  : <% out.println(area);%>&nbsp;</td> 			 
			<th><b>Station  </b> </th> <td> : <%out.println(station);%>&nbsp;</td> 
	       </tr>
		  </thead>			
		 </table>
		</div>
<%
	}
	mc.closeAll();
}else if(ajaxCallOption.equals("getOrderInfo")){
	String orderNo = request.getParameter("orderNo");
	order.ManageOrder mo = new order.ManageOrder("jdbc/js");
	mo.getCheckedOrderInfo(orderNo);
	
	String order_num, order_date, total_items, 	payment_type_desc, status_code, remark;
	float total_value, total_value_discount,saving,total_value_mrp;
	while(mo.rs.next()){
		
		order_num = mo.rs.getString("order_num");
		order_date = mo.rs.getString("order_date");
		total_items = mo.rs.getString("total_items");
		total_value = mo.rs.getFloat("total_value");
		total_value_mrp = mo.rs.getFloat("total_value_mrp");
		total_value_discount = mo.rs.getFloat("total_value_discount");
		payment_type_desc = mo.rs.getString("payment_type_desc");
		status_code = mo.rs.getString("status_code");
		remark = mo.rs.getString("remark");
		
		saving = total_value_mrp - total_value + total_value_discount;
%>
		<div class="roundedDiv" style="background-color: #BEF781; border:1px solid black; width: 100%;">
 		  <table class="custorderinfo"  style="width:100%;">
 		  <tr>
			 <th width="8%">Order_Number</th> 
			 <td width="8%">: <% out.println(order_num);%>&nbsp;</td>
			 <th width="8%">Order_Date</th>
			 <td width="16%">:<% out.println(order_date);%>&nbsp;</td>
			 <th width="8%">Total_Items</th> 
			 <td width="10%">: <% out.println(total_items);%>&nbsp;</td>
			 <th width="3%">Total_Price</th> 
			 <td width="12%">: <% out.println(total_value);%>&nbsp;</td>
			  <th width="5%"></th> 
			  <td width="9%">&nbsp;</td>			
			  <th width="2%"></th> 
			  <td width="5%"></td>		  
		</tr>
		<tr><td height="10px;"></td></tr>
				<tr>
					<th >Total_Saving</th> <td >: <% out.println(saving);%>&nbsp;</td>
					<th >Payment_Type</th> <td>: <% out.println(payment_type_desc);%>&nbsp;</td>
					<th >Order_Status </th> <td >:<% out.println(status_code);%>&nbsp;</td>
					<th >Remark</th> <td >: <% out.println(remark);%>&nbsp;</td>
			</tr>
	 	  </table>
		 </div>
<%
	}
	mo.closeAll();
}else if(ajaxCallOption.equals("getOrderItemInfo")){
	String orderNo = request.getParameter("orderNo");
	order.ManageOrder mo = new order.ManageOrder("jdbc/js");
	mo.getOrderItemDetails(orderNo);
	String barcode, item_code, item_name, item_weight, rate, qty, price, remark,itemGroupCode;
%>
	<table id="itemTable" class="genericTbl" style="width:100%;">
	 <thead>	  
	  <tr  style="position:relative;top:expression(document.all['OrderItemInfoDiv'].scrollTop);background-color:#a43333;" >
	  	<th style="background-color:#a43333;color:#FFFFFF;">Item Code</th>
	  	<th style="background-color:#a43333;color:#FFFFFF;">Item Name</th>
	  	<th style="background-color:#a43333;color:#FFFFFF;">Item Weight</th>
	  	<th style="background-color:#a43333;color:#FFFFFF;">Rate</th>
	  	<th style="background-color:#a43333;color:#FFFFFF;">Order Quantity</th>
	  	<th style="background-color:#a43333;color:#FFFFFF;">Accounted Quantity</th>
	  	<th style="background-color:#a43333;color:#FFFFFF;">Total Price</th>
	  	<th style="background-color:#a43333;color:#FFFFFF;">Remark</th>
	  </tr>
	 </thead>
	 <tbody>
<%
	while(mo.rs.next()){
		barcode = mo.rs.getString("barcode");
		item_code = mo.rs.getString("item_code");
		item_name = mo.rs.getString("item_name");
		item_weight = mo.rs.getString("item_weight");
		rate = mo.rs.getString("rate");
		qty = mo.rs.getString("qty");
		price = mo.rs.getString("price");
		remark = mo.rs.getString("remark");
		itemGroupCode = mo.rs.getString("item_group_code");
%>
 
	 <tr>	  
	  <td><input type="text" name="iCode" id="iCode" value="<%=item_code%>" class="hideTextField"  size="7" readonly="readonly" style="font-size: 12;"/></td>
	  <td><input type="text" name="iName" id="iName" value="<%=item_name%>" class="hideTextField"  size="40" readonly="readonly" style="font-size: 12;"/></td>
	  <td><input type="text" name="iWeight" id="iWeight" value="<%=item_weight%>" class="hideTextField"  size="5" readonly="readonly" style="font-size: 12;"/></td>
	  <td><input type="text" name="iRate" id="iRate" value="<%=rate%>" class="hideTextField" size="5"  readonly="readonly" style="font-size: 12;"/></td>
	  <td><input type="text" name="iOrderQty" id="iOrderQty" value="<%=qty%>" class="hideTextField"  size="5" readonly="readonly" style="font-size: 12;"/></td>
	  <td><input type="text" name="iAccountedQty" id="iAccountedQty" value="" class="hideTextField"  size="5" readonly="readonly" style="font-size: 12;"/></td>
	  <td><input type="text" name="iPrice" id="iPrice" value="<%=price%>" class="hideTextField"  size="5" readonly="readonly" style="font-size: 12;"/></td>
	  <td><input type="text" name="iRemark" id="iRemark" value="<%=remark%>" class="hideTextField"  size="20" readonly="readonly" /></td>
	  <td><input type="hidden" name="hBarcode" id="<%=barcode%>" value="<%=barcode%>"  class="hideTextField"/></td>
	  <td style="display: none;"><input type="hidden" name="hItemGroupCode" value="<%=itemGroupCode%>"  class="hideTextField"/></td>
	 </tr>	
<%			
	}
%>
 	 </tbody>
	</table>	
<%
	mo.closeAll();
}	else if(ajaxCallOption.equals("getItemNames")){
	String serachItemName = request.getParameter("serachItemName");
	ManageItem mi = new ManageItem("jdbc/js");
	mi.listItemBarCode("",serachItemName);
	String barcode, item_code, item_name, item_weight, rate, mrp, deal_amt, deal_qty,itemGroupCode;
%>
	<table id="itemTable" class="genericTbl" style="width:100%;">
	 <thead>	  
	  <tr  style="position:relative;top:expression(document.all['ResponseDiv'].scrollTop);">
	  	<th>Item Code</th>
	  	<th>Item Name</th>
	  	<th>Item Weight</th>
	  	<th>Rate</th>
	  	<th>Order Quantity</th>
	  	<th>Accounted Quantity</th>
	  	<th>Total Price</th>
	  	<th>Remark</th>
	  </tr>
	 </thead>
	 <tbody>
<%
	while(mi.rs.next()){
		barcode = mi.rs.getString("barcode");
		item_code = mi.rs.getString("item_code");
		item_name = mi.rs.getString("item_name");
		item_weight = mi.rs.getString("item_weight");
		rate = mi.rs.getString("item_rate");
		mrp = mi.rs.getString("item_mrp");
		deal_amt = mi.rs.getString("deal_amount");
		deal_qty = mi.rs.getString("deal_on_qty");
		itemGroupCode = mi.rs.getString("item_group_code");
%>
 
	 <tr onclick="funSelItem();">	  
	  <td><input type="text" name="siCode" id="iCode" value="<%=item_code%>" class="hideTextField" size="7" readonly="readonly"/></td>
	  <td><a href="funSelItem();"><input type="text" name="siName" id="iName" value="<%=item_name%>" class="hideTextField" size="40" readonly="readonly"/></a></td>
	  <td><input type="text" name="siWeight" id="iWeight" value="<%=item_weight%>" class="hideTextField" size="5" readonly="readonly"/></td>
	  <td><input type="text" name="siRate" id="iRate" value="<%=rate%>" class="hideTextField" size="5" readonly="readonly"/></td>
	  <td><input type="text" name="siOrderQty" id="iOrderQty" value="<%=mrp%>" class="hideTextField" size="5" readonly="readonly"/></td>
	  <td><input type="text" name="siPrice" id="iPrice" value="<%=deal_amt%>" class="hideTextField" size="5" readonly="readonly"/></td>
	  <td><input type="text" name="siRemark" id="iRemark" value="<%=deal_qty%>" class="hideTextField" size="20" readonly="readonly"/></td>
	  <td><input type="hidden" name="hsBarcode" id="<%=barcode%>" value="<%=barcode%>" class="hideTextField"/></td>
	  <td><input type="hidden" name="hsItemGroupCode" value="<%=itemGroupCode%>" class="hideTextField"/></td>
	 </tr>	
<%			
	}
%>
 	 </tbody>
	</table>	
<%
	mi.closeAll();
}else if(ajaxCallOption.equals("showItemNames")){
	ManageItem mi = new ManageItem("jdbc/js");
	ResultSet resultSet = mi.getItemNames();
	%>
	<select>
		<option value="">select</option>
		<%
			while(resultSet.next()){
				%>
				<option value="<%=resultSet.getString(1)%>"><%=resultSet.getString(2) %></option>
				<%
			}
		%>
	</select>
	<%
	mi.closeAll();
	
}	

%>