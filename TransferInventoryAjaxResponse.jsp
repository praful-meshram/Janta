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
		<select name="siteId" id="siteId1" onchange="getData('getSiteAddress');" style="width:150px;" tabindex="1">
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
				<select name="desId" id="desId1" onchange="getData('getDesAddress');" style="width:150px;" tabindex="2">
				<option value="" selected="selected">Select</option>
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
				Integer siteId = Integer.parseInt(request.getParameter("desId"));
				
				objMV.getSiteAddress(siteId);
				String siteAddress = "";
				if(objMV.rs.next()){
					
					siteAddress = objMV.rs.getString(1);				
		%>
					<%=siteAddress%>	
			
		<% 
				}
				objMV.closeAll();
				
	}else if(ajaxCallOption.equals("searchString")){
		ManageInventory  objMI = new ManageInventory("jdbc/js");
		String barcode ="", itemName="";
		barcode = request.getParameter("searchBarCode");
		itemName = request.getParameter("searchItemName");
		int siteId = Integer.parseInt(request.getParameter("siteId"));
		int desId=Integer.parseInt(request.getParameter("desId"));
		objMI.searchItem(barcode,itemName);	
		String item_code, item_weight, item_name,title; 
		int item_qty, price_version, item_pv_qty,site_qty,total_site_qty,box_qty;
		double item_mrp, item_rate ;
%>
	<div id="outer" style="position: relative;width: 99%;border: 1px solid green;" >
		<div id="inner" style="height:200px; overflow-y:scroll;">
		<table  id="searchItemTable1" class="genericTbl1" style="font-size: 17px;width:100%;margin-right: -17px;" border="1">
		<thead>
		<tr style="height: 20px;">
			<th rowspan="2">Item Name</th>
			<th rowspan="2">Weight</th>
			<th rowspan="2">MRP</th>
			<th colspan="3" style="width:210px;">Site Quantity</th>					
		 </tr>	
		 <tr>
		 	<th>Box</th>
		 	<th>Loose</th>
		 	<th>Total</th>
		 </tr>
		</thead>
<%
		while(objMI.rs.next()){
			barcode= objMI.rs.getString(1);
			item_code = objMI.rs.getString(2);
			item_weight = objMI.rs.getString(3); 
			item_name = objMI.rs.getString(4);
			item_qty = objMI.rs.getInt(5);
			price_version= objMI.rs.getInt(6);
			item_mrp= objMI.rs.getDouble(7); 
			item_rate = objMI.rs.getDouble(8);
			item_pv_qty= objMI.rs.getInt(9);
			box_qty=objMI.rs.getInt(10);
			site_qty = objMI.getSiteQuantity(item_code,siteId,price_version);
			total_site_qty = objMI.getTotalSiteQuantity(item_code,siteId);
			int des_qty = objMI.getDesQuantityTrans(item_code,desId,price_version);
			title= "Total Quantity : "+item_qty+"\n"+"Quantity(Price Version) : "+item_pv_qty+"\n"+"Quantity(Site) : "+site_qty;
			//if(site_qty != 0){
%>
		 <tr style="cursor: pointer;" onclick="Javascript:funShowPopup('<%=barcode%>','<%=item_code%>','<%=item_weight%>','<%=item_name%>','<%=item_qty%>','<%=price_version%>','<%=site_qty%>','<%=des_qty%>','<%=box_qty%>');">
		 	<td style="display:none;"><input type="text" name="searchIBarcode" value="<%=barcode%>" size="7" class="hideTextField" readonly="readonly"/></td>
		 	<td style="display:none;"><input type="text" name="searchICode" value="<%=item_code%>" size="7" class="hideTextField" readonly="readonly"/></td>
		 	<td bgcolor="#EFFBEF"><input style="cursor: pointer;" type="text" name="searchICode" value="<%=item_name%>" size="20" class="hideTextField" readonly="readonly" title="<%=item_name%>"/></td>
		 	<td bgcolor="#EFFBEF"><input style="cursor: pointer;" type="text" name="searchICode" value="<%=item_weight%>" size="7" class="hideTextField" readonly="readonly"/></td>
		 	<td bgcolor="#EFFBEF"><input style="cursor: pointer;" type="text" name="searchICode" value="<%=item_mrp%>" size="7" class="hideTextField" readonly="readonly"/></td>
		 	<td style="display:none;"><input type="text" name="searchICode" value="<%=item_rate%>" size="7" class="hideTextField" readonly="readonly"/></td>		 	
		 	<%
		 	if(box_qty!=1){
		 	%>
		 	<td bgcolor="#EFFBEF"><%=(int)site_qty/box_qty%>  (<%=box_qty %>)</td>
		 	<td bgcolor="#EFFBEF"><%=site_qty%box_qty%></td>
		 	<td bgcolor="#EFFBEF"><input style="cursor: pointer;" type="text" name="searchICode" value="<%=site_qty%>" size="7" class="hideTextField" readonly="readonly"/></td>
		 	<%
		 	}else{
		 	%>
		 	<td colspan="3" style="width:230px;" bgcolor="#EFFBEF"><input style="cursor: pointer;" type="text" name="searchICode" value="<%=site_qty%>" size="7" class="hideTextField" readonly="readonly"/></td>
		 	
		 	<%
		 	}
		 	%>
		 	<td style="display:none;"><input type="text" name="searchICode" value="<%=total_site_qty%>" size="7" class="hideTextField" readonly="readonly"/></td>
		 	<td style="display:none;"><input type="text" name="searchICode" value="<%=item_qty%>" size="7" class="hideTextField" readonly="readonly"/></td>	
		 </tr>
<%

			//}
		}
	objMI.closeAll();
%>
</table>
</div>
<div id="secondWrapper" style="position:absolute;background-color: #BEF781; left:0; top:0; height:45px; overflow:hidden;"></div>
</div>
<%
	}else if(ajaxCallOption.equals("popupTable")){
		
		String barcode=request.getParameter("barcode");
		String item_code=request.getParameter("item_code");
		String item_weight=request.getParameter("item_weight");
		String item_name=request.getParameter("item_name");
		String item_qty=request.getParameter("item_qty");
		String source_site_name=request.getParameter("source_site_name");
		String des_site_name=request.getParameter("des_site_name");
		int site_qty=Integer.parseInt(request.getParameter("site_qty"));
		int des_qty=Integer.parseInt(request.getParameter("des_qty"));
		int box_qty=Integer.parseInt(request.getParameter("box_qty"));
		int priceversion=Integer.parseInt(request.getParameter("priceversion"));
		ManageInventory  objMI = new ManageInventory("jdbc/js");
		int siteId=Integer.parseInt(request.getParameter("siteId"));
		objMI.getMrpValuesTrans(item_code,siteId);	
		
%>
			<table border="1" style="padding: 10px;margin: 10px;">
			<tr><th colspan="8" align="center"><%=item_name %>&nbsp;(<%=item_weight %>)</th></tr>
			<tr><td align="center" colspan="8"> MRP : 
				<select name="popupSelMrp" onchange="funValues('<%=item_code%>');" tabindex="4">
				<%
					double itemMrp;
					int priceVersion,cnt=0;
					while(objMI.rs.next()){
						itemMrp = objMI.rs.getDouble(1);
						priceVersion = objMI.rs.getInt(3);
						if(cnt == 0){
							cnt = priceVersion; 		  
							cnt++;
						 }
						if(priceversion==priceVersion){
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
					</select>
					<td style="display:none;"><select name="popupSelRate" onchange="setMrpRateValues('RATE');funValues('<%=item_code%>');">
						<%
						double itemRate;
						int priceVersion1;
						objMI.rs.beforeFirst();
						while(objMI.rs.next()){
						itemRate = objMI.rs.getDouble(2);
						priceVersion1 = objMI.rs.getInt(3);
						%>
							<option value="<%=priceVersion1%>"><%=itemRate%></option>
						<% 
						} 
						%>
						</select>
						</td>
				</tr>
				<tr>
					<td>Transfer from</td>
					<td colspan="3" align="center"><%=source_site_name %></td>
					<td>to</td>
					<td colspan="3" align="center"><%=des_site_name %></td>
				</tr>
				<%
				if(box_qty > 1){
				%>
				<tr>
					<td></td>
					<td>Box</td>
					<td>Loose</td>
					<td>Total</td>
					<td></td>
					<td>Box</td>
					<td>Loose</td>
					<td>Total</td>
				</tr>
				<tr>
					<td>Initial Qty.</td>
					<td>
						<input type="text" name="popupSourceQty_box" value="<%=(int)site_qty/box_qty%>  (<%=box_qty %>)" size="5" 
						class="hideTextField" readonly="readonly"/>
					</td>
					<td>
						<input type="text" name="popupSourceQty_loose" value="<%=site_qty%box_qty%>" size="5" 
						class="hideTextField" readonly="readonly"/>
					</td>
					<td>
						<input type="text" name="popupSourceQty" value="<%=site_qty%>" size="5" 
						class="hideTextField" readonly="readonly"/>
					</td>
					<td></td>
					<td>
						<input type="text" name="popupDesQty_box" value="<%=(int)des_qty/box_qty%>  (<%=box_qty %>)" size="5" 
						class="hideTextField" readonly="readonly" />
					</td>
					<td>
						<input type="text" name="popupDesQty_loose" value="<%=des_qty%box_qty%>" size="5" 
						class="hideTextField" readonly="readonly" />
					</td>
					<td>
						<input type="text" name="popupDesQty" value="<%=des_qty%>" size="5" 
						class="hideTextField" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td>Transfer Qty.</td>
					<td>
						<input type="text" name="popupTransferQty_box" value="" size="2" 
						onkeyup="setQtyValues();" tabindex="5"/>(<%=box_qty %>)
					</td>
					<td>
						<input type="text" name="popupTransferQty_loose" 
						value="" size="6" onkeyup="setQtyValues();" tabindex="6"/>
					</td>
					<td>
						<input type="text" name="popupTransferQty" value="0" 
						size="5" readonly="readonly" class="hideTextField"/>
					</td>
					<td></td>
					<td>
						<input type="text" name="popupTransferQty_box1" value="0  (<%=box_qty %>)" 
						size="5" readonly="readonly" class="hideTextField"/>
					</td>
					<td>
						<input type="text" name="popupTransferQty_loose1" value="0" 
						size="5" readonly="readonly" class="hideTextField"/>
					</td>
					<td>
						<input type="text" name="popupTransferQty1" value="0" 
						size="5" readonly="readonly" class="hideTextField"/>
					</td>
				</tr>
				<tr>
					<td>Remaining Qty.</td>
					<td>
						<input type="text" name="popupRemainingQty_box" value="" size="5" 
						class="hideTextField" readonly="readonly"  />
					</td>
					<td>
						<input type="text" name="popupRemainingQty_loose" value="" size="5" 
						class="hideTextField" readonly="readonly"  />
					</td>
					<td>
						<input type="text" name="popupRemainingQty" value="" size="5" 
						class="hideTextField" readonly="readonly"  />
					</td>
					<td></td>
					<td>
						<input type="text" name="popupAfttrnsQty_box" value="" size="5" 
						class="hideTextField" readonly="readonly"/>
					</td>
					<td>
						<input type="text" name="popupAfttrnsQty_loose" value="" size="5" 
						class="hideTextField" readonly="readonly"/>
					</td>
					<td>
						<input type="text" name="popupAfttrnsQty" value="" size="5" 
						class="hideTextField" readonly="readonly"/>
					</td>
				</tr>
				<%
				} else if(box_qty==1){
				%>
				<tr>
					<td>Initial Qty.</td>
					<td style="display: none;">
						<input type="text" name="popupSourceQty_box" value="<%=(int)site_qty/box_qty%>  (<%=box_qty %>)" size="5" 
						class="hideTextField" readonly="readonly"/>
					</td>
					<td style="display: none;">
						<input type="text" name="popupSourceQty_loose" value="<%=site_qty%box_qty%>" size="5" 
						class="hideTextField" readonly="readonly"/>
					</td>
					<td colspan="3">
						<input type="text" name="popupSourceQty" value="<%=site_qty%>" size="5" 
						class="hideTextField" readonly="readonly"/>
					</td>
					<td></td>
					<td style="display: none;">
						<input type="text" name="popupDesQty_box" value="<%=(int)des_qty/box_qty%>  (<%=box_qty %>)" size="5" 
						class="hideTextField" readonly="readonly" />
					</td>
					<td style="display: none;">
						<input type="text" name="popupDesQty_loose" value="<%=des_qty%box_qty%>" size="5" 
						class="hideTextField" readonly="readonly" />
					</td>
					<td colspan="3">
						<input type="text" name="popupDesQty" value="<%=des_qty%>" size="5" 
						class="hideTextField" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td>Transfer Qty.</td>
					<td colspan="3">
						<input type="text" name="popupTransferQty_box" value="" size="6" 
						onkeyup="setQtyValues();" tabindex="5"/>
					</td>
					<td style="display: none;">
						<input type="text" name="popupTransferQty_loose" 
						value="" size="6" onkeyup="setQtyValues();"/>
					</td>
					<td style="display: none;">
						<input type="text" name="popupTransferQty" value="" 
						size="5" readonly="readonly" class="hideTextField"/>
					</td>
					<td></td>
					<td style="display: none;">
						<input type="text" name="popupTransferQty_box1" value="0  (<%=box_qty %>)" 
						size="5" readonly="readonly" class="hideTextField"/>
					</td>
					<td style="display: none;">
						<input type="text" name="popupTransferQty_loose1" value="0" 
						size="5" readonly="readonly" class="hideTextField"/>
					</td>
					<td colspan="3">
						<input type="text" name="popupTransferQty1" value="0" 
						size="5" readonly="readonly" class="hideTextField"/>
					</td>
				</tr>
				<tr>
					<td>Remaining Qty.</td>
					<td style="display: none;">
						<input type="text" name="popupRemainingQty_box" value="" size="5" 
						class="hideTextField" readonly="readonly"  />
					</td>
					<td style="display: none;">
						<input type="text" name="popupRemainingQty_loose" value="" size="5" 
						class="hideTextField" readonly="readonly"  />
					</td>
					<td colspan="3">
						<input type="text" name="popupRemainingQty" value="" size="5" 
						class="hideTextField" readonly="readonly"  />
					</td>
					<td></td>
					<td style="display: none;">
						<input type="text" name="popupAfttrnsQty_box" value="" size="5" 
						class="hideTextField" readonly="readonly"/>
					</td>
					<td style="display: none;">
						<input type="text" name="popupAfttrnsQty_loose" value="" size="5" 
						class="hideTextField" readonly="readonly"/>
					</td>
					<td colspan="3">
						<input type="text" name="popupAfttrnsQty" value="" size="5" 
						class="hideTextField" readonly="readonly"/>
					</td>
				</tr>
				<%
				}
				%>
				<tr>
					<td align="center" colspan="8" style="display: none;">
						<input type="text" value="<%=box_qty %>" name="box_qty"/>
						<input type="text" value="<%=barcode %>" name="popupBarcode"/>
						<input type="text" value="<%=item_code %>" name="popupItemCode"/>
						<input type="text" value="<%=item_name %>" name="popupItemName"/>
						<input type="text" value="<%=item_weight %>" name="popupItemWeight"/>
					</td>
				</tr>
				<tr>
					<td align="center" colspan="8">
						<br/>
						<%-- <input type="button" accesskey="t" value="Transfer<Alt+t>" onclick="funAddRow('<%=box_qty %>>');" />&nbsp;&nbsp;--%>
						 <input type="button" accesskey="t" value="Transfer<Alt+t>" onclick="funAddRow('<%=box_qty %>>','<%=item_code%>','<%=priceversion%>');" />&nbsp;&nbsp;
						
						<input type="button" accesskey="c" value=" Cancel<Alt+c> " onclick="funCloseDiv();" />
						<br/><br/>
					</td>
				</tr>
			</table>
<%
	objMI.closeAll();
	}

else if(ajaxCallOption.equals("getValues")){
	    ManageInventory  objMI = new ManageInventory("jdbc/js");
	    String item_code=request.getParameter("item_code");
	   	Integer priceversion = Integer.parseInt(request.getParameter("priceversion"));
	   	Integer siteId = Integer.parseInt(request.getParameter("siteId"));
	    Integer desId = Integer.parseInt(request.getParameter("desId"));
		int site_qty = objMI.getSiteQuantity(item_code,siteId,priceversion );
		int des_qty = objMI.getDesQuantityTrans(item_code,desId,priceversion);
		String qtyValue=site_qty + "@@" +des_qty ;
		out.println(qtyValue);
objMI.closeAll();
}
	%>