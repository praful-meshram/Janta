<%@page import="java.sql.ResultSet"%>
<%@page import="bachka.BachkaMapping"%>
<%@page import="inventory.ManageInventory"%>

<%
	String ajaxCallOption = request.getParameter("ajaxCallOption");
	if (ajaxCallOption.equals("getSite")) {
		inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
		objMV.getSite();
		String siteName = "";
		Integer siteId = 0;
%>
<!-- throwing exception of undefied function

<select name="siteId" onchange="getData('getSiteAddress');"
	style="width: 150px;" tabindex="1">
 -->	
<select name="siteId" style="width: 150px;" tabindex="1">	
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
	} else if (ajaxCallOption.equals("searchBachka")) {
		
		ManageInventory objMI = new ManageInventory("jdbc/js");
		String barcode = "", itemName = "";
		barcode = request.getParameter("searchBarCode");
		itemName = request.getParameter("searchItemName");
		int siteId = Integer.parseInt(request.getParameter("siteId"));
		String item_group_code = request.getParameter("item_group_code");
		//objMI.searchBachka(barcode, itemName, ajaxCallOption);
	
		
		String item_code, item_weight, item_name, title;
		int item_qty, price_version, item_pv_qty, site_qty, total_site_qty, item_box_qty;
		double item_mrp, item_rate;
		//
		System.out.println("=======\nPackaging Ajax Response session "+session);
		System.out.println("=======\nPackaging item_group_code "+item_group_code);
		
		
		objMI.searchBachka(barcode, itemName, ajaxCallOption,item_group_code);
%>
	
	<div id="outer" style="position: relative; width: 100%; border: 1px solid black;">
	<div id="inner" style="height: 140px; width: 100%; overflow-y: scroll;">
		<table id="searchItemTable1" class=""
			style="font-size: 170%; width: 100%; margin-right: -17px; border-collapse: collapse;" border="1" cellpadding=0 cellspacing=0>
			<thead>
				<tr style="height: 20px; font-size: 50%;">
					<th>Item Name</th>
					<th>Weight</th>
					<th>MRP</th>
					<th>Site Inventory</th>
					<th>Total Inventory</th>
					<th>Item group Code</th>
					<th style="display: none;"></th>
					<th style="display: none;"></th>
					<th style="display: none;"></th>
					
					
				</tr>
			</thead>
			<tbody>
			<%
				while (objMI.rs.next()) {
						barcode = objMI.rs.getString(1);
						item_code = objMI.rs.getString(2);
						item_weight = objMI.rs.getString(3);
						System.out.println("=======\nitem weight "+item_weight);
						item_name = objMI.rs.getString(4);
					//	System.out.println("=======\nitem name "+item_name);
						price_version = objMI.rs.getInt(6);
						item_mrp = objMI.rs.getDouble(7);
						item_rate = objMI.rs.getDouble(8);
						item_pv_qty = objMI.rs.getInt(9);
						item_box_qty = objMI.rs.getInt(10);
						//item_group_code = objMI.rs.getString("item_group_code");
						item_group_code = objMI.rs.getString(11);
						/* session.removeAttribute("item_group_code");
						if(item_group_code!=null)
						{
							System.out.println("=======\nitem group code "+item_group_code);
							session.setAttribute("item_group_code", item_group_code);
							
						} */
						site_qty = objMI.getSiteQuantity(item_code, siteId,
								price_version);
						item_qty = objMI.getTotalSiteQuantity(item_code,
								price_version);
				%>
				<tr 	
				onclick="Javascript:funSelectBachka('<%=barcode%>','<%=item_code%>','<%=item_weight%>','<%=item_name%>','<%=price_version%>','<%=item_mrp%>','<%=item_rate%>','<%=item_pv_qty%>','<%=site_qty%>','<%=item_qty%>','<%=item_box_qty%>','<%=item_group_code %>');"
				style="cursor: pointer">
			
				<td style="display: none"><input type="text"
					name="searchIBarcode" value="<%=barcode%>" size="7"
					class="hideTextField1" readonly="readonly" /></td>
				<td style="display: none"><input style="cursor: pointer"
					type="text" name="searchICode" value="<%=item_code%>" size="7"
					class="hideTextField1" readonly="readonly" /></td>

				<td bgcolor="#EFFBEF"><input style="cursor: pointer"
					type="text" name="searchICode" value="<%=item_name%>" size="30"
					class="hideTextField1" readonly="readonly" /></td>

				<td bgcolor="#EFFBEF"><input style="cursor: pointer;"
					type="text" name="searchICode" value="<%=item_weight%>" size="7"
					class="hideTextField1" readonly="readonly" /></td>

				<td style="display: none"><input type="text" name="searchICode"
					value="<%=item_rate%>" size="7" class="hideTextField1"
					readonly="readonly" /></td>

				<td bgcolor="#EFFBEF"><input style="cursor: pointer;"
					type="text" name="searchICode" value="<%=item_mrp%>" size="7"
					class="hideTextField1" readonly="readonly" /></td>

				<td bgcolor="#EFFBEF"><input style="cursor: pointer;"
					type="text" name="searchICode" value="<%=site_qty%>" size="2"
					class="hideTextField1" readonly="readonly" /></td>
			
				<td bgcolor="#EFFBEF"><input style="cursor: pointer;"
					type="text" name="searchICode" value="<%=item_qty%>" size="7"
					class="hideTextField1" readonly="readonly"
					onmouseout="closePopup();" /></td>
				<td bgcolor="#EFFBEF"><input style="cursor: pointer;"
					type="text" name="searchICode" value="<%=item_group_code%>" size="2"
					class="hideTextField1" readonly="readonly"/></td>	
				
			</tr>
				
			
			<%
				}
					objMI.closeAll();
			%>
			</tbody>
		</table>
		</div>
<%	//	}
	}else if (ajaxCallOption.equals("searchItem")) {
		System.out.println("search Item .. ");
		
		ManageInventory objMI = new ManageInventory("jdbc/js");
		String barcode = "", itemName = "";
		barcode = request.getParameter("searchBarCode");
		System.out.println(" barcode "+barcode);
		itemName = request.getParameter("searchItemName");
		int siteId = Integer.parseInt(request.getParameter("siteId"));
		String item_group_code = request.getParameter("item_group_code");
		String bachkaCode = request.getParameter("bachkaCode"); 
		//objMI.searchBachka(barcode, itemName, ajaxCallOption);
	
		
		String item_code, item_weight, item_name, title;
		int item_qty, price_version, item_pv_qty, site_qty, total_site_qty, item_box_qty;
		double item_mrp, item_rate;
		//
		System.out.println(bachkaCode + "=======\nPackaging Ajax Response session "+session);
		System.out.println("=======\nPackaging item_group_code "+item_group_code);
		
		
		//objMI.searchBachka(barcode, itemName, ajaxCallOption,item_group_code);
		BachkaMapping bachkaMapping = new BachkaMapping();
		ResultSet resultSet = bachkaMapping.getItemfromBachkaMapping(barcode, itemName, bachkaCode);
		%>
		<table id="searchItemTable2" class=""
			style="font-size: 170%; width: 100%;margin-right: -17px; border-collapse: collapse;" border="1" cellpadding=0 cellspacing=0>
			<thead>
				<tr style="height: 20px; font-size: 50%;">
					<th>Item Name</th>
					<th>Weight</th>
					<th>MRP</th>
					<th>Site Inventory</th>
					<th>Total Inventory</th>
					<th>Item group Code</th>
					<th style="display: none;"></th>
					<th style="display: none;"></th>
					<th style="display: none;"></th>
				</tr>
			</thead>
			<tbody>
		<%
			if(resultSet.next()){
				do{
					barcode = resultSet.getString(1);
					item_code = resultSet.getString(2);
					item_weight = resultSet.getString(3);
					System.out.println("=======\nitem weight "+item_weight);
					item_name = resultSet.getString(4);
				//	System.out.println("=======\nitem name "+item_name);
					price_version = resultSet.getInt(6);
					item_mrp = resultSet.getDouble(7);
					item_rate = resultSet.getDouble(8);
					item_pv_qty = resultSet.getInt(9);
					item_box_qty = resultSet.getInt(10);
					//item_group_code = resultSet.getString("item_group_code");
					item_group_code = resultSet.getString(11);
					site_qty = objMI.getSiteQuantity(item_code, siteId,	price_version);
					item_qty = objMI.getTotalSiteQuantity(item_code,price_version);
				%>
				<tr
				onclick="Javascript:funShowPopup('<%=barcode%>','<%=item_code%>','<%=item_weight%>','<%=item_name%>','<%=price_version%>','<%=item_mrp%>','<%=item_rate%>','<%=item_pv_qty%>','<%=site_qty%>','<%=item_qty%>','<%=item_box_qty%>');"
				style="cursor: pointer">
					<td style="display: none"><input type="text"
					name="searchIBarcode" value="<%=barcode%>" size="7"
					class="hideTextField1" readonly="readonly" /></td>
				<td style="display: none"><input style="cursor: pointer"
					type="text" name="searchICode" value="<%=item_code%>" size="7"
					class="hideTextField1" readonly="readonly" /></td>

				<td bgcolor="#EFFBEF"><input style="cursor: pointer"
					type="text" name="searchICode" value="<%=item_name%>" size="30"
					class="hideTextField1" readonly="readonly" /></td>

				<td bgcolor="#EFFBEF"><input style="cursor: pointer;"
					type="text" name="searchICode" value="<%=item_weight%>" size="7"
					class="hideTextField1" readonly="readonly" /></td>

				<td style="display: none"><input type="text" name="searchICode"
					value="<%=item_rate%>" size="7" class="hideTextField1"
					readonly="readonly" /></td>

				<td bgcolor="#EFFBEF"><input style="cursor: pointer;"
					type="text" name="searchICode" value="<%=item_mrp%>" size="7"
					class="hideTextField1" readonly="readonly" /></td>

				<td bgcolor="#EFFBEF"><input style="cursor: pointer;"
					type="text" name="searchICode" value="<%=site_qty%>" size="2"
					class="hideTextField1" readonly="readonly" /></td>
				
				<td bgcolor="#EFFBEF"><input style="cursor: pointer;"
					type="text" name="searchICode" value="<%=item_qty%>" size="7"
					class="hideTextField1" readonly="readonly"
					onmouseout="closePopup();" /></td>
				<td bgcolor="#EFFBEF"><input style="cursor: pointer;"
					type="text" name="searchICode" value="<%=item_group_code%>" size="2"
					class="hideTextField1" readonly="readonly"/></td>	
				
			</tr>		
						
				<%
					
				}while(resultSet.next());
				
			}
			else{
					System.out.print("else  ");
				
			}
		%>		
				
			</tbody>
			</table>
		<%
		
		resultSet.close();
		objMI.closeAll();
		bachkaMapping.closeAll();
		
	}

	%>