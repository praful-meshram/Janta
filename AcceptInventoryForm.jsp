<%@page contentType="text/html"%>
<jsp:include page="sessionBoth.jsp">
	<jsp:param name="formName" value="AcceptInventoryForm.jsp" />
</jsp:include>

<%@ page errorPage="ErrorPage.jsp?page=AcceptInventoryForm.jsp" %>	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%> 

<html>
<head>
<title>Retail Management-Janta Stores</title>
<script type="text/javascript" src="js/AcceptInventory.js"></script>
<script type="text/javascript" src="js/popup.js"></script>
<link rel="stylesheet" type="text/css" href="css/border_radius.css" />
</head>
<body class="bodyClass" onmousemove="capmouse();">
	<br/>
	<br/>
	
	<center><h4>Accept Inventory</h4></center>
	<form name="myform" method="post">
		<table align="center" style="width: 100%">
			<tr>
				<td style="width: 5%">&nbsp;</td>
				<td style="width: 90%">
					<div class="roundedDiv"
						style="background-color: #BEF781; border: 1; width: 100%;">
						<table class="custorderinfo" style="width: 80%">
							<tr>
								<th style="width:10%;">Vendor Name</th>
								<td align="left" style="width:20%;">
									<div id="vendorNameDiv" style="width: 100%;"></div>
								</td>
								<td>&nbsp;</td>
								<th style="width:10%;">Site Name</th>
								<td align="left" style="width:20%;">
									<div id="siteNameDiv" style="width: 100%;"></div>
								</td>
								<td>&nbsp;</td>
								<td><b>with Bill Number?</b> &nbsp;<input type="checkbox"
									name="chckBillNumber" onclick="funDisplayDiv()" /></td>
							</tr>
							<tr>
								<th>Vendor Address</th>
								<td>
									<div id="vendorAddress"></div>
								</td>
								<td>&nbsp;</td>
								<th>Site Address</th>
								<td>
									<div id="siteAddress"></div>
								</td>
								<td>&nbsp;</td>
								<td colspan="2"><div id="displayBillDiv"
										style="visibility: hidden;">
										<b>Bill Number :</b> <input type="text" name="billNumber" />
									</div></td>
							</tr>
						</table>
					</div>
				</td>
				<td style="width: 10%">&nbsp;</td>
			</tr>
			<tr>
				<td style="width: 5%">&nbsp;</td>
				<td style="width: 80%">
					<div class="roundedDiv"
						style="background-color: #BEF781; border: 1; width: 100%;">
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
											<td colspan="2" align="right"><input accesskey="s" type="button" value="Search<Alt+s>"
												class="menulired" onclick="funSearchItem();"/>&nbsp;
												<input accesskey="c" type="button" value="Clear<Alt+c>"
												class="menulired" onclick="funClearBarcodeItemName();" /></td>
										</tr>
									</table>
								</td>
								<td style="width: 1%;"></td>
								<td style="width: 72%;">
									<div id="searchItemListDiv" style="height: 150px; border: 1"></div>
								</td>
							</tr>
						</table>
					</div>
				</td>
				<td style="width: 10%">&nbsp;</td>
			</tr>
			<tr>
				<td style="width: 5%">&nbsp;</td>
				<td style="width: 80%">
					<div class="roundedDiv"
						style="background-color: #BEF781; border: 1; width: 100%;">
						<table class="custorderinfo">
							<tr>
								<td style="width: 17%;">
									<table class="custorderinfo">
										<tr>
											<td>Total Items : <input type="text"
												name="grandTotalQty" value="0" class="hideTextFieldGreen"
												readonly="readonly" />
											</td>
										</tr>
										<tr>
											<td>Total MRP : <input type="text" name="grandTotalMrp"
												value="0" class="hideTextFieldGreen" readonly="readonly" /></td>
										</tr>
										<tr>
											<td><input type="button" accesskey="p" value="Save & Print<Alt+p>"
												class="menulired" onclick="funSaveOrder();" /></td>
										</tr>
											<td><input type="button" accesskey="r" value="     Refresh<Alt+r>   " class="menulired"
												onclick="window.location.reload()" />
											</td>
										<tr>
											<td><input type="button" accesskey="h" value="      Home<Alt+h>     "
												class="menulired" onclick="funCancelOrder();" /></td>
										</tr>
										<tr>
											<td></td>
										</tr>
									</table>
								</td>
								<td style="width: 1%;"></td>
								<td style="width: 82%;">
									<div id="selectedItemsDiv" style="position:relative;height: 200px; border: 1px solid green;">		
										<div id="inner1" style="height:198px;width:100%; overflow-y:scroll;">
											<table class="genericTbl" style="font-size: 150%;width:100%;margin-right: -17px;" id="selectedItemsTable" border="1">
												<thead bgcolor="#BEF781" style="height:20px;">
													<tr>
														<th rowspan="2">Item Name</th>
														<th rowspan="2">Weight</th>
														<th rowspan="2">MRP</th>
														<th colspan="3">Old Quantity</th>
														<th colspan="3">New Quantity</th>
														<th colspan="3">Total Quantity</th>
														<th rowspan="2">Delete</th>
													</tr>
													<tr>
														<td>Box</td>
														<td>Loose</td>
														<td>Total</td>
														<td>Box</td>
														<td>Loose</td>
														<td>Total</td>
														<td>Box</td>
														<td>Loose</td>
														<td>Total</td>
													</tr>
												</thead>
												<tbody>
												</tbody>
											</table>
										</div>
										<div id="secondWrapper1" style="position:absolute;background-color: #BEF781; left:0; top:0; height:48px; overflow:hidden;"></div>
										</div>
								</td>
							</tr>
						</table>
					</div>
				</td>
				<td style="width: 10%">&nbsp;</td>
			</tr>
		</table>
		<input type="hidden" name="ajaxCallOption">
		<div id="baseDiv" style="top: 0px;" align="center"></div>
		<div id="popupItemDiv"
			style="x-height: 140px; x-width: 850px; border: 2px solid black; background-color: #BEF781; padding: 25px; display: none; font-size: 100%; text-align: center;">
		</div>
		
		
		<script type="text/javascript">
			window.onload = funOnload;
			function funOnload() {
			 //alert('load');
				getData("getVendor");
			}
		</script>
	</form>
	<div id="popupMouseOver" class="popupMouseOver">
			<div id="close" onclick="closePopup();"><b>x</b></div>
			<div id="right">
			</div>
			<div id="inner_div" style="width:150px;padding:2px;"></div>
		</div>
</body>
</html>