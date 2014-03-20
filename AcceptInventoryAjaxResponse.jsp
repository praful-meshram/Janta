
<%@page import="org.bouncycastle.jce.provider.JDKKeyFactory.RSA"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="inventory.ManageInventory"%>
<%
	String ajaxCallOption = request.getParameter("ajaxCallOption");
	int box_site_qty, loose_site_qty, box_tot_qty, loose_tot_qty, box_item_qty, loose_item_qty;

	//System.out.println("ajaxCallOption value in:"+ajaxCallOption);
	if (ajaxCallOption.equals("getVendor")) {
		inventory.ManageVendor objMV = new inventory.ManageVendor("jdbc/js");
		objMV.getVendor();
		String vendorName = "";
		Integer vendorId = 0;
%>
<select name="vendorId" onchange="getData('getVendorAddress');"
	style="width: 100%;" tabindex="1">
	<option value="">Select</option> 
	<%
		while (objMV.rs.next()) {
				vendorId = objMV.rs.getInt(1);
				vendorName = objMV.rs.getString(2);
	%>
	<option value="<%=vendorId%>"><%=vendorName%></option>

	<%
		}
			objMV.closeAll();
	%>
</select>
<%
	} else if (ajaxCallOption.equals("getVendorAddress")) {
		inventory.ManageVendor objMV = new inventory.ManageVendor("jdbc/js");
		Integer vendorId = Integer.parseInt(request.getParameter("vendorId"));
		objMV.getVendorAddress(vendorId);
		String vendorAddress = "";
		if (objMV.rs.next()) {
			vendorAddress = objMV.rs.getString(1);
%>
<%=vendorAddress%>

<%
	}
		objMV.closeAll();
	} else if (ajaxCallOption.equals("getSite")) {
		//inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
		inventory.ManageSite objMV = new inventory.ManageSite("jdbc/re");
		objMV.getSite();
		String siteName = "";
		Integer siteId = 0;
%>
<select name="siteId" onchange="getData('getSiteAddress');"
	style="width: 100%;px;" tabindex="2">
	<option value="">Select</option>
	<%
		while (objMV.rs.next()) {
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
	} else if (ajaxCallOption.equals("getSiteAddress")) {
		inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
		Integer siteId = Integer.parseInt(request.getParameter("siteId"));
		objMV.getSiteAddress(siteId);
		String siteAddress = "";
		if (objMV.rs.next()) {
			siteAddress = objMV.rs.getString(1);
%>
<%=siteAddress%>

<%
	}
		objMV.closeAll();
	} else if (ajaxCallOption.equals("searchString")) {
		ManageInventory objMI = new ManageInventory("jdbc/js");
		String barcode = "", itemName = "";
		barcode = request.getParameter("searchBarCode");
		itemName = request.getParameter("searchItemName");
		int siteId = Integer.parseInt(request.getParameter("siteId"));
		objMI.searchItem(barcode, itemName);
		String item_code, item_weight, item_name, title,bachka;
		int item_qty, price_version, item_pv_qty, site_qty, total_site_qty, item_box_qty;
		double item_mrp, item_rate;
%>
<div id="outer" style="position: relative;width: 100%;border:1px solid black;" >
	<div id="inner" style="height:150px;width:100%; overflow-y:scroll;">
	<table id="searchItemTable1" class="genericTbl1" style=" font-size: 170%; width: 100%;margin-right: -17px; border-collapse: collapse;" border="1" cellpadding=0 cellspacing=0>
	<thead>
	<tr style="height: 20px;" >
		<th rowspan="2">Item Name</th>
		<th rowspan="2">Weight</th>
		<th rowspan="2">MRP</th>
		<th colspan="3">Site Inventory</th>
		<th colspan="3" style="width: 100px;">Total Inventory</th>
	</tr>
	<tr>
		<th>Box</th>
		<th>Loose</th>
		<th>Total</th>
		<th>Box</th>
		<th>Loose</th>
		<th>Total</th>
	</tr>
</thead>
		<%
			while (objMI.rs.next()) {
					barcode = objMI.rs.getString(1);
					item_code = objMI.rs.getString(2);
					//System.out.println("item_code "+item_code);
					item_weight = objMI.rs.getString(3);
					item_name = objMI.rs.getString(4);
					price_version = objMI.rs.getInt(6);
					item_mrp = objMI.rs.getDouble(7);
					item_rate = objMI.rs.getDouble(8);
					item_pv_qty = objMI.rs.getInt(9);
					item_box_qty = objMI.rs.getInt(10);
					//System.out.println("======\n\n\nitem obx quantity "+item_box_qty+" item code "+item_code+"\n item rate "+ item_rate);
					if(objMI.rs.getString(11).equals("true")){
						bachka="  (Bachka)";
					} else {
						bachka="";
					}
					site_qty = objMI.getSiteQuantity(item_code, siteId,
							price_version);
					item_qty=objMI.getTotalSiteQuantity(item_code,price_version);
					
					// if item_box_qty not 1 then it must give divide by 0 error
					if (item_box_qty != 1) {
						
						System.out.println(item_box_qty+ " if item box quantity "+item_qty);
						box_site_qty = (int) site_qty / item_box_qty;
						loose_site_qty = site_qty % item_box_qty;
						box_item_qty = (int) item_qty / item_box_qty;
						loose_item_qty = item_qty % item_box_qty;
					} else {
						box_site_qty = site_qty;
						loose_site_qty = 0;
						box_item_qty = item_qty;
						loose_item_qty = 0;
					}
		%>
		<tr
			onclick="Javascript:funShowPopup('<%=barcode%>','<%=item_code%>','<%=item_weight%>','<%=item_name%>','<%=site_qty%>','<%=item_box_qty%>','<%=price_version %>');"
			style="cursor: pointer">
			<td style="display: none"><input type="text"
				name="searchIBarcode" value="<%=barcode%>" size="7"
				class="hideTextField" readonly="readonly" /></td>
			<td style="display: none"><input style="cursor: pointer"
				type="text" name="searchICode" value="<%=item_code%>" size="50"
				class="hideTextField" readonly="readonly" /></td>
				 
			<td bgcolor="#EFFBEF"><input style="cursor: pointer" type="text"
				name="searchICode" value="<%=item_name%>" size="90" title="<%=item_name%>"
				class="hideTextField" readonly="readonly" /></td>
			<td bgcolor="#EFFBEF"><input style="cursor: pointer;" type="text"
				name="searchICode" value="<%=item_weight%>" size="7"
				class="hideTextField" readonly="readonly" /></td>
			<td style="display: none"><input type="text" name="searchICode"
				value="<%=item_rate%>" size="7" class="hideTextField"
				readonly="readonly" /></td>
			<td bgcolor="#EFFBEF"><input style="cursor: pointer;" type="text"
				name="searchICode" value="<%=item_mrp%>" size="7"
				class="hideTextField" readonly="readonly" /></td>
			<%
				if (item_box_qty > 1) {
			%>
			<td bgcolor="#EFFBEF"><input style="cursor: pointer;" type="text"
				name="searchICode" value="<%=box_site_qty%>" size="2"
				class="hideTextField" readonly="readonly" />(<%=item_box_qty%>)</td>
			<td bgcolor="#EFFBEF"><input style="cursor: pointer;" type="text"
				name="searchICode" value="<%=loose_site_qty%>" size="7"
				class="hideTextField" readonly="readonly" /></td>
			<td bgcolor="#EFFBEF"><input style="cursor: pointer;" type="text"
				name="searchICode" value="<%=(box_site_qty*item_box_qty+loose_site_qty)%>" size="7"
				class="hideTextField" readonly="readonly" /></td>
			<td bgcolor="#EFFBEF"><input style="cursor: pointer;" type="text"
				name="searchICode" value="<%=box_item_qty%>" size="2"
				class="hideTextField" readonly="readonly" />(<%=item_box_qty%>)</td>
			<td bgcolor="#EFFBEF"><input style="cursor: pointer;" type="text"
				name="searchICode" value="<%=loose_item_qty%>" size="7"
				class="hideTextField" readonly="readonly" /></td>
			<td bgcolor="#EFFBEF"><input id="change" style="cursor: pointer;" type="text"
				name="searchICode" value="<%=(box_item_qty*item_box_qty+loose_item_qty)%>" size="7"
				class="hideTextField" readonly="readonly" id='showPopUpCell'
				onmouseover="Javascript:showMousePopup('<%= item_code%>','<%= price_version%>','<%= item_name %>','<%=item_mrp %>');"
				onmouseout="closePopup();" /></td>
				
			<%
				} else if (item_box_qty == 1) {
			%>
			<td bgcolor="#EFFBEF" colspan="3"><input style="cursor: pointer;"
				type="text" name="searchICode" value="<%=box_site_qty%>" size="2"
				class="hideTextField" readonly="readonly" /><%=bachka %></td>
			<td style="display: none;"><input
				style="cursor: pointer;" type="text" name="searchICode"
				value="<%=loose_site_qty%>" size="7" class="hideTextField"
				readonly="readonly" /></td>
			
			<td bgcolor="#EFFBEF" colspan="3"><input id="change" style="cursor: pointer;"
				type="text" name="searchICode" value="<%=box_item_qty%>" size="2"
				class="hideTextField" readonly="readonly" 
				onmouseover="Javascript:showMousePopup('<%= item_code%>','<%= price_version%>','<%= item_name %>','<%=item_mrp %>');"
				onmouseout="closePopup();"/></td>
			<td style="display: none;"><input
				style="cursor: pointer;" type="text" name="searchICode"
				value="<%=loose_item_qty%>" size="7" class="hideTextField"
				readonly="readonly" /></td>
			<%
				}
			%>
		</tr>
		<%
			}
			objMI.closeAll();
		%>
	</table>
</div>
<div id="secondWrapper" style="position:absolute;background-color: #BEF781; left:0; top:0; height:45px; overflow:hidden;"></div>

</div>

<%
	} else if (ajaxCallOption.equals("popupTable")) {
		String barcode = request.getParameter("barcode");
		String item_code = request.getParameter("item_code");
		String item_weight = request.getParameter("item_weight");
		String item_name = request.getParameter("item_name");
		/* System.out.print("============\n Accept inventory item name "+ item_name+"  \n==========");
		System.out.print("============\n Accept inventory item name "+ barcode+"  \n=========="); */
		
		System.out.print("\nOP : "+request.getParameter("price_version")+"\n");
		int price_version = Integer.parseInt(request
				.getParameter("price_version"));
		int item_box_qty = Integer.parseInt(request
				.getParameter("box_qty"));
		System.out.println("\n" + item_box_qty + "\n");
		int item_qty = Integer.parseInt(request
				.getParameter("item_qty"));
		int popup_box_item_qty = (int) item_qty / item_box_qty;
		int popup_loose_item_qty = item_qty % item_box_qty;
		ManageInventory objMI = new ManageInventory("jdbc/js");
		int siteId = Integer.parseInt(request.getParameter("siteId"));
		objMI.getMrpValues(item_code, siteId);
		
		
%>
<table>
	<tr>
		<td>
			<table id="popupItemTable" class="genericTbl" style="font-size: 70%; border-collapse: collapse;" cellpadding=0 cellspacing=0>
				<%
					if (item_box_qty != 1) {
				%>
				<tr bgcolor="LightBlue">
					<!--<th>Bar code</th>
								<th>Item Code</th>-->
					<th rowspan="2" style="width: 150px;">Item Name</th>
					<th rowspan="2" style="width: 50px;">Weight</th>
					<!--<th>JS Price </th>-->
					<th rowspan="2" style="width: 50px;">MRP</th>
					<th colspan="3" style="width: 100px;">Old Quantity</th>
					<th colspan="3" style="width: 100px;">New Quantity</th>
					<th colspan="3" style="width: 100px;">Total Quantity</th>
					<!-- <th>Total MRP</th>	-->
				</tr>
				<tr>
					<td style="width: 50px; background-color: #BEF781;">Box</td>
					<td style="width: 50px; background-color: #BEF781;">Loose</td>
					<td style="width: 50px; background-color: #BEF781;">Total</td>
					<td style="width: 50px; background-color: #BEF781;">Box</td>
					<td style="width: 50px; background-color: #BEF781;">Loose</td>
					<td style="width: 50px; background-color: #BEF781;">Total</td>
					<td style="width: 50px; background-color: #BEF781;">Box</td>
					<td style="width: 50px; background-color: #BEF781;">Loose</td>
					<td style="width: 50px; background-color: #BEF781;">Total</td>
				</tr>
				<%
					} else {
				%>
				<tr bgcolor="LightBlue">
					<th style="width: 150px;">Item Name</th>
					<th style="width: 50px;">Weight</th>
					<th style="width: 50px;">MRP</th>
					<th style="width: 100px;">Old Quantity</th>
					<th style="width: 100px;">New Quantity</th>
					<th style="width: 100px;">Total Quantity</th>
				</tr>
				<%
					}
				%>
				<tr>
					<td style="display: none"><input type="text"
						name="popupBarcode" value="<%=barcode%>" size="5"
						class="hideTextField" readonly="readonly" /></td>
					<td style="display: none"><input type="text"
						name="popupItemCode" value="<%=item_code%>" size="5"
						class="hideTextField" readonly="readonly" /></td>
					<td><input type="text" name="popupItemName"
						value="<%=item_name%>" size="50" class="hideTextField"
						readonly="readonly" /></td>
						<% System.out.print("============\n Accept inventory item name "+ item_name+"  \n=========="); %>
					<td><input type="text" name="popupItemWeight"
						value="<%=item_weight%>" size="5" class="hideTextField"
						readonly="readonly" /></td>

					<td style="display: none"><select name="popupSelRate"
						onchange="setMrpRateValues('RATE');" >
							<%
								double itemMrp;
									int priceVersion=0, cnt = 0;
									double itemRate;
									int priceVersion1;

									while (objMI.rs.next()) {
										itemRate = objMI.rs.getDouble(2);
										System.out.println(objMI.rs.getString(1)+" accept ajax "+ itemRate);
										priceVersion1 = objMI.rs.getInt(3);
										if (cnt == 0) {
											cnt = priceVersion1;
											cnt++;
										}
										if(priceVersion1==price_version){
											%>
												<option value="<%=priceVersion1%>" selected="selected"><%=itemRate%></option>
											<%
										}
										else{
							%>
												<option value="<%=priceVersion1%>"><%=itemRate%></option>
							<%
										}
								}
									
							%>
							<option value="<%=cnt%>">New</option>
					</select> <input type="text" name="popupRate" value="0" size="5"
						style="display: none;" tabindex="6"
						onkeydown="javascript:this.value=this.value.replace(/[^0-9.]/g, '');"
						onkeyup="javascript:this.value=this.value.replace(/[^0-9.]/g, '');setQtyValues();"
						autocomplete="off" /></td>
					<td><select name="popupSelMrp"
						onchange="setMrpRateValues('MRP');">
							<%
								System.out.print(" result set "+objMI.rs);
								objMI.rs.beforeFirst();
								 	while (objMI.rs.next()) {
											itemMrp = objMI.rs.getDouble(1);
											priceVersion = objMI.rs.getInt(3);
											
										if(price_version==priceVersion){
										%>
											<option value="<%=priceVersion%>" selected="selected"><%=itemMrp%></option>
										<%
										}else{
											%>
											<option value="<%=priceVersion%>"><%=itemMrp%></option>
										<%
										}
									
								 	}
								 	
	
								
							%>
							<option value="<%= priceVersion+1 %>">New</option>
					</select> <input type="text" name="popupMrp" value="0" size="5"
						style="display: none;"
						onkeydown="javascript:this.value=this.value.replace(/[^0-9.]/g, '');"
						onkeyup="javascript:this.value=this.value.replace(/[^0-9.]/g, '');setQtyValues();setMrpAndRate();"
						autocomplete="off" /></td>
					<%
						if (item_box_qty != 1) {
					%>
					<td><input type="text" name="popupOldQty_box"
						value="<%=popup_box_item_qty%>" size="3" class="hideTextField"
						readonly="readonly" /> (<%=item_box_qty%>)</td>
					<td><input type="text" name="popupOldQty"
						value="<%=popup_loose_item_qty%>" size="5" class="hideTextField"
						readonly="readonly" /></td>
					<td><input type="text" name="popupOld_total"
						value="<%=(popup_box_item_qty*item_box_qty+popup_loose_item_qty)%>" size="5" class="hideTextField"
						readonly="readonly" /></td>
					<td><input type="text" name="popupNewQty_box" value=""
						size="3" onkeyup="setQtyValues('<%=item_box_qty%>');" />(<%=item_box_qty%>)</td>
					<td><input type="text" name="popupNewQty" value="" size="5"
						onkeyup="setQtyValues('<%=item_box_qty%>');" /></td>
					<td><input type="text" name="popupNew_total"
						value="0" size="5" class="hideTextField"
						readonly="readonly" /></td>
					<td><input type="text" name="popupTotalQty_box"
						value="<%=popup_box_item_qty%>" size="3" class="hideTextField"
						readonly="readonly" /> (<%=item_box_qty%>)</td>
					<td><input type="text" name="popupTotalQty"
						value="<%=popup_loose_item_qty%>" size="5" class="hideTextField"
						readonly="readonly" /></td>
						<td><input type="text" name="popupTotal_total" style="color:blue;"
						value="<%=(popup_box_item_qty*item_box_qty+popup_loose_item_qty)%>" size="5" class="hideTextField"
						readonly="readonly" /></td>
					<%
						} else if (item_box_qty == 1) {
					%>
					<td><input type="text" name="popupOldQty_box"
						value="<%=popup_box_item_qty%>" size="3" class="hideTextField"
						readonly="readonly" tabindex="7"/></td>
					<td style="display: none;"><input type="text"
						name="popupOldQty" value="<%=popup_loose_item_qty%>" size="5"
						class="hideTextField" readonly="readonly" tabindex="7"/></td>
						
						
				<%-- 	onkeyup event is activated
				
						<td><input type="text" name="popupNewQty_box" value=""
						size="10" onkeyup="setQtyValues('<%=item_box_qty%>');" /></td>
				 --%>
				 
				 	<!-- new quantity onkeyup event deactivated  -->
				 	<td><input type="text" name="popupNewQty_box" value=""
						size="10" /></td>
				
					 <td style="display: none;"><input type="text"
						name="popupNewQty" value="" size="5"
						onkeyup="setQtyValues('<%=item_box_qty%>');" /></td>
													
					<td><input type="text" name="popupTotalQty_box"
						value="<%=popup_box_item_qty%>" size="3" class="hideTextField"
						readonly="readonly" /></td>
					<td style="display: none;"><input type="text"
						name="popupTotalQty" value="<%=popup_loose_item_qty%>" size="5"
						class="hideTextField" readonly="readonly" /></td>
					<%
						}
					%>
					<td style="display: none"><input type="text"
						name="popupTotalMrp" value="" size="5" class="hideTextField"
						readonly="readonly" /></td>
					<td style="display: none"><input type="text"
						name="popupBoxQty" value="<%=item_box_qty%>" size="5"
						class="hideTextField" readonly="readonly" /></td>
				</tr>
				<tr>

				</tr>
			</table>

		</td>
	<tr>
		<td colspan="1" align="right"><input type="button" value="Accept<Alt+a>"
			onclick="funAddRow('<%=item_code%>','<%=price_version%>');" accesskey="a"/> <input type="button" value="Close<Alt+x>"
			onclick="funCloseDiv();" accesskey="x" /></td>
	</tr>
</table>
<%
	objMI.closeAll();
	} else if (ajaxCallOption.equals("getValues")) {
		String item_code = request.getParameter("item_code");
		int price_version = Integer.parseInt(request
				.getParameter("price_version"));
		int siteId = Integer.parseInt(request.getParameter("siteId"));
		ManageInventory objMI = new ManageInventory("jdbc/js");
		int site_qty = objMI.getSiteQuantity(item_code, siteId,
				price_version);
		//objMI.closeAll();
%>
<%=site_qty%>
<%
	objMI.closeAll();
	} else if (ajaxCallOption.equals("mouse_over_popup")) {
		String item_code = request.getParameter("item_code");
		String item_name = request.getParameter("item_name");
		String item_mrp = request.getParameter("item_mrp");
		int price_version=Integer.parseInt(request.getParameter("price_version"));
		ManageInventory objMI = new ManageInventory("jdbc/js");
		objMI.getQtyPerSide(item_code,price_version);
		out.print("<center>"+item_name+"<br>Price : Rs. "+item_mrp+"<br><hr style=\"width:170px\">");
		out.print("<table style='width: 95%; border-collapse: collapse; ' cellpadding=0 cellspacing=0><tr><th>Site</th><th></th><th>Qty</th></tr>");
		while(objMI.rs.next()){
			out.print("<tr><td>"+objMI.rs.getString(1)+"</td><td>:</td><td>"+objMI.rs.getInt(2)+"</td></tr>");
		}
		out.print("</table>");
		objMI.closeAll();
	}
%>
