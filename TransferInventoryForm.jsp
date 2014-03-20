<%@page contentType="text/html"%>
<html>
<head>
<title>Retail Management-Janta Stores</title>
<script src="js/TransferInventory.js"></script>
<script type="text/javascript" src="js/popup.js"></script>
<script src="js/jquery-1.10.2.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/border_radius.css" />
</head>
<%@ page errorPage="ErrorPage.jsp?page=TransferInventoryForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<body class="bodyClass">
<br/>
	<center><h4>Transfer Inventory</h4></center>
	<form name="myform" method="post">
		<input type="hidden" value="" id="sourceSiteName1" name="sourceSiteName">
		<input type="hidden" value="" id="destSiteName1" name="destSiteName">
		
		 
		<table align="center" style="width: 100%">
			<tr>
				<td style="width: 10%">&nbsp;</td>
				<td style="width: 80%">
					<div class="roundedDiv"
						style="background-color: #BEF781; border: 1; width: 100%; height: 120px;">
						<table class="custorderinfo">
							<tr>
								<th>Source Site:</th>
								<td>
									<div id="sourceSiteDiv"></div>
								</td>
								<td>&nbsp;</td>
								<th>Destination Site:</th>
								<td>
									<div id="desSiteDiv"></div>
								</td>
							</tr>
							<tr>
								
								<th>Source Address</th>
								<td>
									<div
										style="height: 50px; vertical-align: middle; padding-top: 15px;"
										id="sourceAddress"></div>
								</td>
								<td>&nbsp;</td>
								<th>Destination Address</th>
								<td>
									<div
										style="height: 50px; vertical-align: middle; padding-top: 15px;"
										id="destinationAddress"></div>
								</td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</div>
				</td>
				<td style="width: 10%">&nbsp;</td>
			</tr>
			<tr>
				<td style="width: 10%">&nbsp;</td>
				<td style="width: 80%">
					<div class="roundedDiv"
						style="background-color: #BEF781; border: 1; width: 100%; height: 200px;">
						<table class="custorderinfo">
							<tr>
								<td style="width: 27%;">
									<table class="custorderinfo">
										<tr>
											<th>Enter Bar Code</th>
											<td colspan="3"><input type="text" name="searchBarCode"
												size="22" onchange="funHandleSearchString('barcode');" /></td>
											<td></td>
										</tr>
										<tr>
											<th>Enter Item Name</th>
											<td colspan="3"><input type="text" name="itemName"
												size="22" onchange="funHandleSearchString('itemName');" tabindex="3"/></td>
										</tr>
										<tr>
											<td align="right"><input type="button" accesskey="s" value="Search<Alt+s>"
												class="menulired" onclick="funSearchItem();" />
											<td><input type="button" accesskey="c" value="Clear<Alt+c>"
												class="menulired" onclick="funClearBarcodeItemName();" /></td>
											
											 </td>
										</tr>
									</table>
								</td>
								<td style="width: 1%;"></td>
								<td style="width: 72%;">
									<div id="searchItemListDiv" style="height: 200px; border: 1">
									</div>
								</td>
							</tr>
						</table>
					</div>
				</td>
				<td style="width: 10%">&nbsp;</td>
			</tr>
			<tr>
				<td style="width: 10%">&nbsp;</td>
				<td style="width: 80%">
					<div class="roundedDiv"
						style="background-color: #BEF781; border: 1; width: 100%; height: 250px;">
						<table class="custorderinfo" style="width: 80%;">
							<tr>
								<td><b>Total Items : </b><input type="text"
									name="grandTotalItems" value="0" class="hideTextFieldGreen"
									readonly="readonly" /></td>
							
								<td><b>Total Transfer Qty. : </b><input type="text"
									name="grandTotalQty" value="0" class="hideTextFieldGreen"
									readonly="readonly" /></td>
							
								<td><input type="button" accesskey="p" value="  Save & Print<Alt+p> "
									class="menulired" onclick="funSaveOrder();" /></td>

								<td><input type="button" accesskey="r" value="Refresh<Alt+r>" class="menulired"
									onclick="window.location.reload()" /></td>
									
								<td><input type="button" accesskey="h" value="Home<Alt+h>" class="menulired"
									onclick="funCancelOrder();"></input></td>
							</tr>
						</table>
						<table class="custorderinfo" style="width:100%;">
							<tr>
								<td style="width: 1%;"></td>
								<td style="width: 72%;">
									<div id="selectedItemsDiv" style="height: 200px; border: 1px solid green; width: 100%;position: relative;">
										<div id="inner1" style="height:198px;width:100%; overflow-y:scroll;">
											<table class="genericTbl1" style="font-size: 15px;width:100%;margin-right: -17px;"
												id="selectedItemsTable" border="1" >
												<thead style="height: 20px;">
													<tr>
														<th rowspan="2">Item Name</th>
														<th rowspan="2">Weight</th>
														<th rowspan="2">MRP</th>
														<th colspan="3">Source Quantity</th>
														<th colspan="3">Transfer Quantity</th>
														<th colspan="3">After transfer destination Qty.</th>
														<th></th>
													</tr>
													<tr>
														<th>Box</th><th>Loose</th><th>Total</th>
														<th>Box</th><th>Loose</th><th>Total</th>
														<th>Box</th><th>Loose</th><th>Total</th>
													</tr>
												
												</thead>
												<tbody>					
												</tbody>
											</table>
										</div>
										<div id="secondWrapper1" style="position:absolute;background-color: #BEF781; left:0; top:0; height:48px; overflow:hidden;"></div>
									</div>
						</table>
					</div>
				</td>
				<td style="width: 10%">&nbsp;</td>
			</tr>
		</table>

		<input type="hidden" name="ajaxCallOption">
		<div id="baseDiv" style="top: 0px;" align="center"></div>
		<div id="popupItemDiv"
			style="border: 2px solid black; background-color: #BEF781; /*padding:25px;*/ display: none; font-size: 100%; text-align: center;">
		</div>
		<script type="text/javascript">
			window.onload = funOnload;
			function funOnload() {
				getData("getSite");
			}
		</script>
	</form>
</body>
</html>

