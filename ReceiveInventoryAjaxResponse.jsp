
<%@page import="inventory.ManageInventory"%>
<%
	String ajaxCallOption = request.getParameter("ajaxCallOption");	
    //System.out.println("ajaxCallOption value in:"+ajaxCallOption);
	 if(ajaxCallOption.equals("getSite")){
		inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
		objMV.getSite();
		String siteName="";
		Integer siteId=0;
%>
		<select name="siteId" id="siteId1" onchange="getData('getSiteAddress')";  style="width:150px;" tabindex="1">
		<option value="">Select</option>
<%
		while(objMV.rs.next()){
			siteId = objMV.rs.getInt(1);
			siteName = objMV.rs.getString(2);				
%>
			<option value="<%=siteId%>"><%=siteName%></option>	
	
<% 
		}
		objMV.closeAll();
%>
		</select>
<%
	}else if(ajaxCallOption.equals("getSiteAddress")){
		try{
		inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
		Integer siteId = Integer.parseInt(request.getParameter("siteId"));	
		objMV.getSiteAddress(siteId);
		String siteAddress = "";
		if(objMV.rs.next()){
			
			siteAddress = objMV.rs.getString(1);				
%>
			<%=siteAddress%>	
	
<% 
		}
		objMV.closeAll();
		}catch(Exception e){}
	}
	else if(ajaxCallOption.equals("getDes")){
				inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
				objMV.getSite();
				String siteName="";
				Integer siteId=0;
		%>
				<select name="desId" id="desId1" onchange="getData('getDesAddress')";   style="width:150px;" tabindex="2">
				<option value="">Select</option>
		<%
				while(objMV.rs.next()){
					siteId = objMV.rs.getInt(1);
					siteName = objMV.rs.getString(2);				
		%>
					<option value="<%=siteId%>"><%=siteName%></option>	
			
		<% 
				}
				objMV.closeAll();
		%>
				</select>
		<%
			}else if(ajaxCallOption.equals("getDesAddress")){
				try{
				inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
				Integer siteId = Integer.parseInt(request.getParameter("siteId"));
				objMV.getSiteAddress(siteId);
				String siteAddress = "";
				if(objMV.rs.next()){
					
					siteAddress = objMV.rs.getString(1);				
		%>
					<%=siteAddress%>	
			
		<% 
				}
				objMV.closeAll();
			}catch(Exception e){}
	}else if(ajaxCallOption.equals("getTransferNumber")){
		try{
		inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
		String siteId =request.getParameter("siteId");
		String desId=request.getParameter("desId");
		String frDate=request.getParameter("fromDate");
		String toDate=request.getParameter("toDate");
		objMV.getTransferNum(siteId,desId,frDate,toDate);
		Integer trnsId=0;
		
%>
		<select name="transId" id='transId1' onchange="funSearchTrnsList()";  style="width:150px;" tabindex="3">
		<option value="">Select</option>
<%
		while(objMV.rs.next()){
			trnsId = objMV.rs.getInt(1);
%>
			<option value="<%=trnsId%>"><%=trnsId%></option>	
	
<% 
		}
		objMV.closeAll();
%>
		</select>
<%
	
		}catch(Exception e){}
		}else if(ajaxCallOption.equals("searchString")){
		ManageInventory  objMIV = new ManageInventory("jdbc/js");
		String trnsNumber = request.getParameter("searchTrnsNumber");
		String siteId = request.getParameter("siteId");
		String desId=request.getParameter("desId");
		objMIV.searchTrnsNum(trnsNumber,siteId,desId);	
		int total_trans_items, trnsferNumber;
		
	
%>
	<table  id="searchItemTable" class="genericTbl"   style="font-size: 17px;width:80%;">
		<thead>
		<tr style="position:relative;top:expression(document.all['searchTrnsNumberListDiv'].scrollTop);">
			<th>Transfer Number</th>
			<th>No. of Items</th>
		</tr>	
		</thead>
<%
		while(objMIV.rs.next()){
			
			trnsferNumber= objMIV.rs.getInt(1);
			total_trans_items = objMIV.rs.getInt(2);
			
%>			
			<tr onclick="fundisplayTable('<%=trnsferNumber%>')"; style="cursor: pointer;" >
			<td><input type="text" name="searchItrnsnum" value="<%=trnsferNumber%>" size="7" class="hideTextField" readonly="readonly"/></td>
		 	<td><input type="text" name="searchICode" value="<%=total_trans_items %>" size="7" class="hideTextField" readonly="readonly"/></td>
		 	</tr>

<%	}
objMIV.closeAll();
%>
</table>

<%
	}
	else if(ajaxCallOption.equals("popupTable")){
		try{
		int siteId = Integer.parseInt(request.getParameter("siteId"));
		int desId=Integer.parseInt(request.getParameter("desId"));
		
		ManageInventory  objMIVB = new ManageInventory("jdbc/js");
		int trnsNumber =Integer.parseInt(request.getParameter("searchTrnsNumber"));
		objMIVB.getTrnsList(trnsNumber,siteId,desId);	
%>
<table  id="displayItemTable" align="center" class="genericTbl" style="font-size:17px;width:100%;">
	<thead>
	<tr>
		<th>Barcode</th>
		<th>Item Code</th>
		<th>Item Name</th>
		<th>Weight</th>
		<th>JS Price</th>
		<th>MRP</th>
		<th>Source Qty</th>
		<th>Des Qty.</th>
		<th>Transfer Qty.</th>
		<th>Accept Qty.</th>
		<th>Status.</th>
	<!-- 	<th>Remaining Qty.</th>
		<th>Aftr trans. Qty.</th> -->
		<th>Remark</th>
		
	</tr>	
	</thead>

<%int statusID=0;
while( objMIVB.rs.next()){
	String barcode=objMIVB.rs.getString("barcode");
   	String item_code=objMIVB.rs.getString("item_code");
	String item_name=objMIVB.rs.getString("item_name");
	String item_weight=objMIVB.rs.getString("item_weight");
	int priceversion=objMIVB.rs.getInt("price_version");
	System.out.println("priceversion"+priceversion);
	double item_mrp, item_rate ;
	item_rate =objMIVB.rs.getDouble("item_rate");
	item_mrp=objMIVB.rs.getDouble("item_mrp");
	
	int source_qty=objMIVB.rs.getInt(10);
	int des_qty=objMIVB.rs.getInt(11);
	int transfer_qty=objMIVB.rs.getInt("transfer_qty");
	int remainingQty=source_qty - transfer_qty;
	int aftrtransferQty=des_qty + transfer_qty;
	
	objMIVB.getitemstatus();
%>
    <tr>
	<td><input type="text" name="Ibarcode" value="<%=barcode%>" size="7" class="hideTextField" readonly="readonly"/></td>
 	<td><input type="text" name="IitemCode" value="<%=item_code %>" size="7" class="hideTextField" readonly="readonly"/></td>
 	<td><input type="text" name="Iitemname" value="<%=item_name %>" size="7" class="hideTextField" readonly="readonly"/></td>
 	<td><input type="text" name="Iitemweight" value="<%=item_weight %>" size="7" class="hideTextField" readonly="readonly"/></td>
 	
 	<td><input type="text" name="Iitem_rate" value="<%=item_rate %>" size="7" class="hideTextField" readonly="readonly"/></td>
 	<td><input type="text" name="Iitem_mrp" value="<%=item_mrp %>" size="7" class="hideTextField" readonly="readonly"/></td>
 	
 	<td><input type="text" name="Isource_qty" value="<%=source_qty%>" size="4" class="hideTextField" readonly="readonly" onblur="setQtyValues()";/></td>
 	<td><input type="text" name="Ides_qty" value="<%=des_qty%>" size="4" class="hideTextField" readonly="readonly" onblur="setQtyValues()";/></td>
 	
 	<td><input type="text"  name="Itransfer_qty" value="<%=transfer_qty%>" size="4" class="hideTextField" readonly="readonly"  /></td>
 	<td><input type="text"  name="Iaccept_qty" value="<%=transfer_qty%>" size="4" class="hideTextField" onchange="validate(this,'<%=statusID %>');" readonly="readonly"/></td>
 	<td style="display: none"><input type="hidden" name="transfernum" value="<%=trnsNumber%>" class="hideTextField"/></td>
 	<td style="display: none"><input type="hidden" name="priceversion" value="<%=priceversion%>" class="hideTextField"/></td>
 	<td>
 	<select  id="itemStatus<%=statusID%>" name="IStatus"  onchange="statusOptions(this);" >
		
<% 

		while(objMIVB.rs1.next()){
		
			String  itemStatus = objMIVB.rs1.getString(1);
			
			%>
			<option value="<%=itemStatus%>"><%=itemStatus%></option>	
	
<% 
		}
	
	
	%>	</select>
		</td>
	
<%-- 	<td><input type="text" name="IRemainingqty" value="<%=remainingQty %>" size="2" class="hideTextField" readonly="readonly" /></td>
	<td><input type="text" name="IAftrtransqty" value="<%=aftrtransferQty %>" size="2" class="hideTextField" readonly="readonly" /></td> --%>
	<td><input type="text" name="Remark" id="Remark1" size="15"/></td>
	
	</tr>
	<%statusID++; }%>
<%	
objMIVB.closeAll();
		}catch(Exception e){}
		}%>
	 </table>
	