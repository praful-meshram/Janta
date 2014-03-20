 <%@page import="bachka.MixtureMapping"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Vector"%>
<%@page import="inventory.ManageInventory"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="beans.InputBeanBachkaMapping"%>
<%@page import="beans.JasonObject"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.OutputBeanBachkaMapping"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bachka.BachkaMapping"%>
<%@page import="java.sql.ResultSet"%>
<%-- <%@ page errorPage="ErrorPage.jsp?page=BachkaMappingForm.jsp" %> --%>
<%
	/* session.getAttribute("UserName").toString(); */
	String ajaxCallOption = request.getParameter("ajaxCallOption");
	
	//code to display ste list 
	if (ajaxCallOption.equals("getSite")) {
		BachkaMapping bachkaMapping = new BachkaMapping();
		ResultSet resultSet = bachkaMapping.getSite();
		String siteName = "";
		Integer siteId = 0;
	
		
%>

<select name="siteId" style="width: 150px;" tabindex="1" id="siteId" class="textfield">	
	<option value="">Select</option>
	<%
		while (resultSet.next()) {
				siteId = resultSet.getInt(1);
				siteName = resultSet.getString(2);
				
	%>
	<option value="<%=siteId%>"><%=siteName%></option>

	<%
		}
	resultSet.close();
	bachkaMapping.closeAll();
	
	%>
	
</select>
<%
	}
		
	// display bachka information
	else if (ajaxCallOption.equals("searchBachka")) {
		ManageInventory objMI = new ManageInventory("jdbc/js");
		//MixtureMapping mixtureMapping = new MixtureMapping();
		BachkaMapping bachkaMapping = new BachkaMapping();
		String barcode = "", itemName = "";
		barcode = request.getParameter("searchBarCode");
		itemName = request.getParameter("searchItemName");
		int siteId = Integer.parseInt(request.getParameter("siteId"));
		String item_group_code = request.getParameter("item_group_code");
		//objMI.searchBachka(barcode, itemName, ajaxCallOption);
	
	//	System.out.println("get item by group code " +item_group_code +"\n site Id "+siteId);
		
		String item_code, item_weight, item_name, title;
		int item_qty, price_version, item_pv_qty, site_qty, total_site_qty, item_box_qty;
		double item_mrp, item_rate;
		//
		System.out.println("=======\nPackaging Ajax Response session "+session);
		System.out.println("=======\nPackaging item_group_code "+item_group_code);
		
		%>
			<table style="width: 100%;max-height: 100%;border:1px solid #98bf21;border-collapse: collapse;margin-left: 5px;" id="bachkaTable">
			<thead style="height: 10px;border:1px solid #98bf21;font-size:15px;
				text-align:left;
				padding-top:5px;
				padding-bottom:4px;
				background-color:#A7C942;
				color:#ffffff;">
					<!-- <tr style="text-align: left;">
					<th style="width: 45%;">Item Name</th>
					<th style="width: 13%;">Weight</th>
					<th style="width: 13%;">MRP</th>
					<th style="width: 15%;">Site Inventory</th>
					<th style="width: 15%;">Total Inventory</th>
					<th style="width: 25%;">Item Group Code</th>
					 -->
					 <tr>
					<th style="width: 55%;">Item Name</th>
					<th style="width: 12%;">Weight</th>
					<th style="width: 10%;">MRP</th>
					<!-- <th style="width: 15%;">Site Inventory</th> -->
					<th style="width: 20%;">Total Inventory</th>
					<!-- <th style="width: 30%;">Item Group Code</th> -->
					
					
				</tr>
			</thead>
			<tbody style="cursor: pointer;">
		<%
		
		ResultSet resultSet = bachkaMapping.searchBachka( barcode, itemName, ajaxCallOption,item_group_code);
				
				if(resultSet.next()) {
					int count =0;
					do{
						/*select m.item_code, m.item_weight, m.item_name, m.item_qty , m.item_mrp*/
						
					/* 	barcode = resultSet.getString(1);
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
						item_qty = objMI.getTotalSiteQuantity(item_code,price_version); */
						
						item_code = resultSet.getString(1);
						System.out.println("=======\niitem_code "+item_code);
						item_weight = resultSet.getString(2);
						item_name = resultSet.getString(3);
						item_qty = Integer.parseInt(resultSet.getString(4));
						item_mrp = Double.parseDouble(resultSet.getString(5)); 
						item_group_code = resultSet.getString(6);
						
						
						if(count%2==0){
						%>
						 	<tr onclick="createSelectBachkaTable('<%=item_code%>','<%=item_name%>','<%=item_weight%>','<%=item_mrp%>','<%="aa"%>','<%=item_qty%>','<%=item_group_code%>');" style="height: 7px;">
						
			<%-- 		 	<td style="width: 30%;"><%=item_name %></td>
							<td style="width: 13%;"><%=item_weight %></td>
							<td style="width: 13%;"><%=item_mrp %> </td>
							<td style="width: 15%;"><%=site_qty %></td>
							<td style="width: 15%;"><%=item_qty %></td>
							<td style="width: 28%;"><%=item_group_code %></td>
							 --%>
							 <td style="width: 55%"><%=item_name %></td>
							<td style="width: 12%;"><%=item_weight %></td>
							<td style="width: 10%;"><%=item_mrp %> </td>
							<%-- <td style="width: 15%;"><%=site_qty %></td> --%>
							<td style="width: 20%;"><%=item_qty %></td>
							<%-- <td style="width: 30%;"><%=item_group_code %></td> --%>
							
							
						</tr>
						
						<%
						}
						else{
							
							%>
							<tr onclick="createSelectBachkaTable('<%=item_code%>','<%=item_name%>','<%=item_weight%>','<%=item_mrp%>','<%="aa"%>','<%=item_qty%>','<%=item_group_code%>');" style="height: 7px;">
								 <td style="width: 55%"><%=item_name %></td>
								<td style="width: 12%;"><%=item_weight %></td>
								<td style="width: 10%;"><%=item_mrp %> </td>
								<%-- <td style="width: 15%;"><%=site_qty %></td> --%>
								<td style="width: 20%;"><%=item_qty %></td>
								<%-- <td><%=item_group_code %></td> --%>
							</tr>
							
							<%
						}
				
						 
						count++;
				}while(resultSet.next());
						
			}
				else{
					System.out.println(" no data ");
				}
				
				%></tbody>
				</table>
				<%
				resultSet.close();
				bachkaMapping.closeAll();
				objMI.closeAll();
	}
	
	// code for item group code
		else if(ajaxCallOption.equals("getItemGroupCode"))
		{
			System.out.println("get item group code ");
			//inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
			
			String item_group_code = request.getParameter("item_group_code");
			
			System.out.println("item group code "+item_group_code);
			//ResultSet resultSet = objMV.getItemGroupCode();
			BachkaMapping bachkaMapping = new BachkaMapping();
			String itemGroupCodeDesc = bachkaMapping.getItemGrupCodeDesc(item_group_code);
			ResultSet resultSet= bachkaMapping.getItemGroupCode();
			
			%><table class="bachka"  style="width: 100%;height: 25px;border-width:2px;margin: 1px;"><tr><td>
			
			<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Select Item Group Code</b>&nbsp;&nbsp;&nbsp;:<select name="getItemGroupCode" style="width: 150px;" id="itemGroupCode" onchange="getItemByGroupCode();" class="textfield"> -->	
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Choose Item Group </b>&nbsp;&nbsp;&nbsp;:<select name="getItemGroupCode" style="width: 150px;" id="itemGroupCode" class="textfield">
			
			<% if(item_group_code!=null){
				System.out.println( itemGroupCodeDesc + "item group code "+item_group_code);
				%>
			<%-- <option value="<%=item_group_code%>" selected="selected"><%=itemGroupCodeDesc%></option	 --%>
			<option value="" selected="selected">Select</option>
			
			
			
			<% }
			while(resultSet.next()){
				String itemGroupCodeValue = resultSet.getString(1);
				String itemGroupCodeDescValue = resultSet.getString(2);
				
				%>		
			
		<option value="<%=itemGroupCodeValue%>"><%=itemGroupCodeDescValue%></option>
		
	<% 		System.out.println("itemGroupCode "+itemGroupCodeValue);
			}
			%></select>
			</td>
			<td style="font-weight: bold;">Item Name&nbsp;&nbsp;&nbsp;<input type="text" id="itemName" class="textfield"></td>
			<td s"><input type="button"  style="width: 150px;" accesskey="i" value="Search Item<Alt+i>" class="button" onclick="getItem();"> </td>
			</tr>
			</table>	
			<%
			resultSet.close();
			bachkaMapping.closeAll();
		}
	
	
	//display item by group code
		else if(ajaxCallOption.equals("getItemByGroupCode")){
			System.out.println("get item by group code ");
			String barcode = "", itemName = "";
			String item_code, item_weight, item_name, title;
			int item_qty, price_version, item_pv_qty, site_qty, total_site_qty, item_box_qty;
			double item_mrp, item_rate;
			
			String item_group_code = request.getParameter("item_group_code");
			int siteId = Integer.parseInt(request.getParameter("siteID"));
			String bachkaCode = request.getParameter("mixtureCode");
			String itemNameParameter = request.getParameter("itemName");
			
	//		System.out.println("get item by group code " +item_group_code +"\n site Id "+siteId);
			System.out.println("get item by group code " +item_group_code +"\n siteId  "+request.getParameter("siteID"));
			
			BachkaMapping bachkaMapping = new BachkaMapping();
			ArrayList<String> itemCodeArrayList = bachkaMapping.getItemCode(bachkaCode);
			bachkaMapping.closeAll();
			
			ManageInventory objMI = new ManageInventory("jdbc/js");
			ResultSet resultSet = bachkaMapping.getItemBygroupCode(item_group_code,itemNameParameter);
			
			%>
				<table style="width: 100%;max-height: 100%;border-collapse: collapse;border:1px solid #98bf21;" id="itemByGroupCodeTable">
				<thead style="height: 10px;font-size:15px;
							text-align:left;
							padding-top:5px;
							padding-bottom:4px;
							background-color:#A7C942;
							color:#ffffff;">
					<!-- <th style="width: 27%;text-align: left;">Item Name</th>
					<th style="width: 13%;text-align: left;">Weight</th>
					<th style="width: 13%;text-align: left;">MRP</th>
					<th style="width: 15%;text-align: left;">Site Inventory</th>
					<th style="width: 15%;text-align: left;">Total Inventory</th>
					<th style="width: 28%;text-align: left;">Item Group Code</th>
					<th style="width: 7%;text-align: left;">Add</th>
					 -->
					 
					<th style="width: 55%;">Item Name</th>
					<th style="width: 12%;">Weight</th>
					<th style="width: 10%;">MRP</th>
					<th style="width: 20%;">Total Inventory</th>
					<!-- <th style="width: 30%;">Item Group Code</th> -->
					<th style="width: 7%;text-align: left;">Add</th>
				</tr>
			</thead>
			<tbody style="cursor: pointer;">
			<%
			
			if(resultSet.next()){
				int count=0;
				do{
					/* barcode = resultSet.getString(1);
					item_code = resultSet.getString(2);
					item_weight = resultSet.getString(3);
					//System.out.println("=======\nitem weight "+item_weight);
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
					
					 */
					 
						item_code = resultSet.getString(1);
						item_weight = resultSet.getString(2);
						item_name = resultSet.getString(3);
						item_qty = Integer.parseInt(resultSet.getString(4));
						item_mrp = Double.parseDouble(resultSet.getString(5)); 
						item_group_code = resultSet.getString(6);
					 
					String checkBox = null;
					//System.out.println("itemCodeArrayList "+itemCodeArrayList);
					if(itemCodeArrayList!=null)
					{
						if(itemCodeArrayList.contains(item_code)){
							System.out.println("===== mixture mapping");
							checkBox = "<input type='checkbox' name='addItem' onclick=\"addItemIntoDIV('"+item_name+"','"+item_weight+"','"+item_code+"','checkbox"+count+"','"+bachkaCode+"');\" disabled='disabled' checked='checked' id='checkbox"+count+"'>";
						}else
							checkBox = "<input type='checkbox' name='addItem' onclick=\"addItemIntoDIV('"+item_name+"','"+item_weight+"','"+item_code+"','checkbox"+count+"','"+bachkaCode+"');\" id='checkbox"+count+"'>";
						
					
						
					}
					if(count%2==0){
						%>
							<tr style="height: 7px;">
						<%-- 	<td style="width: 30%;"><%=item_name %></td>
							<td style="width: 13%;"><%=item_weight %></td>
							<td style="width: 13%;"><%=item_mrp %> </td>
							<td style="width: 15%;"><%=site_qty %></td>
							<td style="width: 15%;"><%=item_qty %></td>
							<td style="width: 28%;"><%=item_group_code %></td>
							<td style="width: 7%;"><%=checkBox %></td> --%>
							
							 <td style="width: 55%"><%=item_name %></td>
							<td style="width: 12%;"><%=item_weight %></td>
							<td style="width: 10%;"><%=item_mrp %> </td>
							<%-- <td style="width: 15%;"><%=site_qty %></td> --%>
							<td style="width: 20%;"><%=item_qty %></td>
						<%-- 	<td style="width: 30%;"><%=item_group_code %></td> --%>
							<td style="width: 7%;"><%=checkBox %></td>
							
						</tr>
						
						<%}
						else{
							%>
							
							<tr>
							<%-- <td style="width: 30%;"><%=item_name %></td>
							<td style="width: 13%;"><%=item_weight %></td>
							<td style="width: 13%;"><%=item_mrp %> </td>
							<td style="width: 15%;"><%=site_qty %></td>
							<td style="width: 15%;"><%=item_qty %></td>
							<td style="width: 28%;"><%=item_group_code %></td>
							<td style="width: 7%;"><%=checkBox %></td>
							 --%>
							 
							 <td style="width: 55%"><%=item_name %></td>
							<td style="width: 12%;"><%=item_weight %></td>
							<td style="width: 10%;"><%=item_mrp %> </td>
							<td style="width: 20%;"><%=item_qty %></td>
							<%-- <td style="width: 30%;"><%=item_group_code %></td> --%>
							<td style="width: 7%;"><%=checkBox %></td>
							
							
						</tr>
							
							<%	
							
						}
				
						 
						count++;
					
				}while(resultSet.next());
			}
			else{
				
				System.out.println(" no data   ");
			}
			%>
				</table>
			<%
			
			resultSet.close();
			objMI.closeAll();
			bachkaMapping.closeAll();
			
		}
	else if(ajaxCallOption.equals("saveToDB")){
		
		System.out.println(" save to Db  ");
		//System.out.println(" save to Db  "+ request.getParameter("itemCodeArray"));
		//System.out.println(" save to Db  "+request.getParameter("mixtureCodeArray"));
		
		String [] itemCodeArray = request.getParameter("itemCodeArray").split(",");
		String [] bachkaCodeArray = request.getParameter("mixtureCodeArray").split(",");
		System.out.print("item Code Array  : ");
		for(String s : itemCodeArray){
			System.out.print(s+"\t");
			
		}
		System.out.println();
		System.out.print("Bachka Code Array  : ");
		for(String s : bachkaCodeArray){
			System.out.print(s+"\t");
			
		}
		BachkaMapping bachkaMapping = new BachkaMapping();
		int count = bachkaMapping.insertIntoBachkaMapping(itemCodeArray, bachkaCodeArray);
		out.print(count);		
		bachkaMapping.closeAll();
	}
	else if(ajaxCallOption.equals("mixtureMapping")){
			System.out.println(" ====\n\n mixture mapping   ");
			String bachkaCode  =  request.getParameter("globalMixtureCode");
			System.out.println(bachkaCode);
			BachkaMapping bachkaMapping = new BachkaMapping();
			ResultSet resultSet = bachkaMapping.getBachkaMappingResult(bachkaCode);
			
		%>
			<table style="max-height: 100%;width: 100%;border-collapse: collapse;" id="selectedBachkaTable1">
				<thead style="height: 7px;
							font-family:'Times New Roman',Times,serif;	
							border:1px solid #98bf21;
							font-size:15px;
							text-align:left;
							padding-top:5px;
							padding-bottom:4px;
							background-color:#A7C942;
							color:#ffffff;">
					<tr style="text-align: left;">
						<th style="width: 50%;">Item Name</th>
						<th style="width: 25%;">Item Code</th>
						<th style="width: 15%;">Weight</th>
						<th style="width: 10%;"></th>
					</tr>
				</thead>
				<tbody ID="mixtureMapping" style="border:1px solid #98bf21;height: 5px;">
		<%	if(resultSet.next()){
			int count=0;
			do{
				String item_code = resultSet.getString(1);
				%>
					<tr style="text-align: left;height: 5px; "  id="row<%=count%>"s>
						<td style="width: 50%;"><%=resultSet.getString(2)%></td>
						<td style="width: 25%;"><%=item_code%></td>
						<td style="width: 15%;"><%=resultSet.getString(3)%></td>
						<td style="width: 10%;"><img alt="remove item" src='images/trash-iconBachka.png' onclick="deleteRowFromDatabase('row<%=count%>','<%=bachkaCode%>','<%=item_code%>');"> </td>
					</tr>
								
					
				<%
				
			}while(resultSet.next());
			
		}
		else{
		
		
			
		}
		
		%>
			</tbody>
			</table>
		<%
		resultSet.close();
		bachkaMapping.closeAll(); 
		
	}
	else if(ajaxCallOption.equals("deleteFromDB")){
		System.out.println(" ====\n\n delete mapping. ");
		String bachkaCode = request.getParameter("mixture_code");
		String itemCode = request.getParameter("item_code");
		System.out.println(" \n "+ bachkaCode + " "+itemCode);
		BachkaMapping bachkaMapping = new BachkaMapping();
 		int rowsUpdate = bachkaMapping.deleteRecord(bachkaCode, itemCode);
 		System.out.print(rowsUpdate+" rows deleted");
 		out.print(rowsUpdate);
 		bachkaMapping.closeAll();
		
	}	
	
%>
