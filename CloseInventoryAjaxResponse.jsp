
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
		<select name="siteId" onchange="getData('getSiteAddress')";  style="width:150px;" tabindex="1">
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
	}
	else if(ajaxCallOption.equals("getDes")){
				inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
				objMV.getSite();
				String siteName="";
				Integer siteId=0;
		%>
				<select name="desId" onchange="getData('getDesAddress')";  style="width:150px;" tabindex="2">
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
				inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
				Integer siteId = Integer.parseInt(request.getParameter("siteId"));
				System.out.println(siteId);
				objMV.getSiteAddress(siteId);
				String siteAddress = "";
				if(objMV.rs.next()){
					
					siteAddress = objMV.rs.getString(1);				
		%>
					<%=siteAddress%>	
			
		<% 
				}
				objMV.closeAll();
				
	}else if(ajaxCallOption.equals("getTransferNumber")){
		inventory.ManageSite objMV = new inventory.ManageSite("jdbc/js");
		Integer siteId = Integer.parseInt(request.getParameter("siteId"));
		Integer desId=Integer.parseInt(request.getParameter("desId"));
		objMV.getTransferNumForClose(siteId,desId);
		Integer trnsId=0;
		
%>
		<select name="transId" onchange="funSearchTrnsList();"  style="width:150px;" tabindex="3">
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
	}
	else if(ajaxCallOption.equals("popupTable")){
		
		int siteId = Integer.parseInt(request.getParameter("siteId"));
		int desId=Integer.parseInt(request.getParameter("desId"));
		
		ManageInventory  objMIVB = new ManageInventory("jdbc/js");
		int trnsNumber =Integer.parseInt(request.getParameter("searchTrnsNumber"));
		objMIVB.getTrnsList(trnsNumber,siteId,desId);	
%>
<table  id="displayItemTable" align="center" class="genericTbl" style="font-size:17px;width:100%;">
	<thead>
	<tr >
		<th>Barcode</th>
		<th>Item Code</th>
		<th>Item Name</th>
		<th>Weight</th>
		<th>JS Price</th>
		<th>MRP</th>
		<th>Source Qty</th>
		<th>Destination Qty</th>
		<th>Transfer Qty.</th>
		<th>Accept Qty.</th>
		<th>Status.</th>
		<th>Remark</th>
	</tr>	
	</thead>



<%
while( objMIVB.rs.next()){
	String barcode=objMIVB.rs.getString("barcode");
   	String item_code=objMIVB.rs.getString("item_code");
	String item_name=objMIVB.rs.getString("item_name");
	String item_weight=objMIVB.rs.getString("item_weight");
	
	double item_mrp, item_rate ;
	item_rate =objMIVB.rs.getDouble("item_rate");
	item_mrp=objMIVB.rs.getDouble("item_mrp");
	
	int source_qty=objMIVB.rs.getInt(10);
	int dest_qty=objMIVB.rs.getInt(11);
    int transfer_qty=objMIVB.rs.getInt("transfer_qty");
    String item_trans_status=objMIVB.rs.getString("item_trans_status");
    %>
    <tr>
	<td><input type="text" name="Ibarcode" value="<%=barcode%>" size="7" class="hideTextField" readonly="readonly"/></td>
 	<td><input type="text" name="IitemCode" value="<%=item_code %>" size="7" class="hideTextField" readonly="readonly"/></td>
 	<td><input type="text" name="Iitemname" value="<%=item_name %>" size="7" class="hideTextField" readonly="readonly"/></td>
 	<td><input type="text" name="Iitemweight" value="<%=item_weight %>" size="7" class="hideTextField" readonly="readonly"/></td>
 	<td><input type="text" name="Iitem_rate" value="<%=item_rate %>" size="7" class="hideTextField" readonly="readonly"/></td>
 	<td><input type="text" name="Iitem_mrp" value="<%=item_mrp %>" size="7" class="hideTextField" readonly="readonly"/></td>
 	<td><input type="text" name="Iitem_qty" value="<%=source_qty%>" size="4" class="hideTextField" readonly="readonly"/>
 	<td><input type="text" name="Iitemd_qty" value="<%=dest_qty%>" size="4" class="hideTextField" readonly="readonly"/>
 	
	</td>
 	<td><input type="text"  name="Itransfer_qty" value="<%=transfer_qty%>" size="4" class="hideTextField" readonly="readonly"  /></td>
 	<td><input type="text"  name="Iaccept_qty" value="<%=transfer_qty%>" size="4" class="hideTextField" readonly="readonly"/>
 	<td><input type="text"  name="IStatus" value="<%=item_trans_status%>" size="10" class="hideTextField" onblur="enterremark();" readonly="readonly"/>
   <% if(item_trans_status.equals("TRANSFER")){ %>
    <td><input type="text"  name="IRemark"  size="10" class="hideTextField" readonly="readonly"/>
<%	}else{
%>
 <td><input type="text"  name="IRemark"  size="10"/>
<%	
	}
   }
	objMIVB.closeAll();
 }%>
	 </table>
	