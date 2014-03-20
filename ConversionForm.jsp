<%@page contentType="text/html"%>
<%-- <jsp:include page="sessionBoth.jsp">
	<jsp:param name="formName" value="PakegingForm.jsp" />
</jsp:include> --%>

	<%@ page errorPage="ErrorPage.jsp?page=ConversionForm.jsp" %>
<html>
<head>
<title>Retail Management-Janta Stores</title>
<script type="text/javascript" src="js/popup.js"></script>
<script type="text/javascript" src="js/Conversion.js"></script>
<link rel="stylesheet" type="text/css" href="css/pakeging.css" />
<script src="js/jquery-1.10.2.min.js"></script>

<script src="js/DataTable/jquery.js" type="text/javascript"></script>
<script src="js/DataTable/jquery.dataTables.js" type="text/javascript"></script>

</head>
<body id="pakeging_body" onmousemove="capmouse(event)">
<%
session.getAttribute("UserName").toString();
System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());

%>
	<br/>
	<center><h4>Conversion</h4></center>
	<form name="myform" method="post">
	<center>
		<div id="roundedDiv" >
			<table>
				<tr>
					<td style="35%">
						<table id="search_table">
							<tr>
								<th align="left">
									Site :
								</th>
								<td>
									<div id="siteNameDiv"></div>
								</td>
							</tr>
							<tr>
								<th colspan="2">
									Search Mixture 
								</th>
							</tr>
						
							<tr>
								<th  align="left">Enter Bar Code :
								</th>
								<td colspan="3">
									<input type="text" name="searchBarCode"size="22"/>
								</td>
								<td></td>
							</tr>
							<tr>
								<th  align="left">Enter Mixture Name :</th>
									<td colspan="3"><input type="text" name="searchItemName" size="22" tabindex="2"/>
								</td>
							</tr>
							
							
							<tr>
							
							
								<td></td>
								<td>
									<input type="button" style="width: 100%;" accesskey="s" value="Search<Alt+s>" class="menulired" onclick="funSearchMixture();"  style="width:48%;"/> 
								</td>
							</tr>
    					</table>
    				</td>
    				<td style="width:70%">
    					<div id="searchBachkaListDiv" class="searchItemListDiv"></div>
    				</td>
    			</tr>
    		</table>
		</div>
		
		<!-- Code for generating gain... -->
		<div id="roundedDiv" style="margin-top:5px;height:40px;">
		<table>
			<tr>
				<th>Selected Mixture :</th>
				<td><input style="height:27px;font-size:20px; background-color: #BEF781;"
					type="text" name="selected_bachka_name" value= "" 
					class="hideTextField" readonly="readonly" /></td>
					
				<td style="display: none"><input type="text" name="selected_bachka_barcode"
					value="" size="7" class="hideTextField"
					readonly="readonly" /></td>
					
				<td style="display: none"><input type="text" name="selected_bachka_code"
					value="" size="7" class="hideTextField"
					readonly="readonly" /></td>
					
				<td style="display: none"><input type="text" name="selected_bachka_weight"
					value="" size="7" class="hideTextField"
					readonly="readonly" /></td>
					
				<td style="display: none"><input type="text" name="selected_bachka_pv"
					value="" size="7" class="hideTextField"
					readonly="readonly" /></td>
					
				<td style="display: none"><input type="text" name="selected_bachka_mrp"
					value="" size="7" class="hideTextField"
					readonly="readonly" /></td>
					
				<td style="display: none"><input type="text" name="selected_bachka_rate"
					value="" size="7" class="hideTextField"
					readonly="readonly" /></td>
					
				<td style="display: none"><input type="text" name="selected_bachka_pv_qty"
					value="" size="7" class="hideTextField"
					readonly="readonly" /></td>
					
				<td style="display: none"><input type="text" name="selected_bachka_qty"
					value="" size="7" class="hideTextField"
					readonly="readonly" /></td>
					
				<td style="display: none"><input type="text" name="selected_bachka_totat_qty"
					value="" size="7" class="hideTextField"
					readonly="readonly" /></td>
					
				<td style="display: none"><input type="text" name="selected_bachka_totat_box_qty"
					value="" size="7" class="hideTextField"
					readonly="readonly" /></td>
					
				<th>Mixture :</th>
				<td>
					<select name="break_count" onchange="countTotalBachkaWeight();" disabled="disabled" tabindex="3">
						<option value="0">0</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</td>
				
				<td>&nbsp;&nbsp;&nbsp;</th>
				<th>Total Weight :</td>	
				<td><input type="text" name="weight_to_breakdown"
					value="0" size="5" class="hideTextField"
					readonly="readonly" style="background-color: #BEF781;"/>kg.</td>
					
				<td>&nbsp;&nbsp;&nbsp;</th>
				
				<th>Loss :</td>	
				<td><input type="text" name="loss_in_breakdown"
					value="0" size="3" disabled="disabled"/>kg.</td>
					
					<th>Gain :</td>	
				<td><input type="text" name="gain_in_breakdown"
					value="0" size="3" disabled="disabled"/>kg.</td>
					
				<td>
					<input type="button" accesskey="l" value="Calculate Loss or Gain<Alt+l>"  style="width:100%;" class="menulired" onclick="calculateLoss();" />
				</td>
			</tr>
		</table>
		</div>
		
		
		<div id="roundedDiv" style="margin-top:5px;"  align="left">
			<div id="roundedDiv1">
				<table id="serch_div_table_main">
					<tr style="width: 100%;">
						<td style="width: 100%;">
							<table id="serch_div_table">
								<tr>
									
									<th style="width: 16%;">Bar Code :</th>
									<td style="width: 18%;"><input type="text" name="searchBarCode1"
										size="10" /></td>
											
									<th style="width: 16%;">Item Name :</th>
									<td style="width: 18%;"><input type="text" name="itemName1"
										size="10" tabindex="4"/></td>	
										
									<td style="width: 16%;"><input type="button" value="Search"  style="width:100%;"
										class="menulired" onclick="funSearchItem();" tabindex="5"/></td>
												
									<td style="width: 16%;"> <input type="button" value="Clear" style="width:100%;"
										class="menulired" onclick="funClearBarcodeItemName();" /></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr style="width:100%;height:75%;">
						<td>
							<div id="searchItemListDiv" style="height:100%;overflow: auto;"></div>
						</td>
					</tr>
				</table>
			</div>
			<div id="roundedDiv1" style="margin-top:-200px;margin-left:50%;width : 50%;padding-top:10px;height: 183px;">
				<table id="serch_div_table_main">
					<tr style="width: 100%;height:20%;">
						<td style="width: 100%;">
							<table id="serch_div_table">
								<tr>
									<td>
										<font style="font-size:10px;">Converted weight :</font> 
									</td>
									<td>
										<input type="text" name="breakdown_weight"
											value="0" size="3" class="hideTextField"
											readonly="readonly" style="background-color: #BEF781;"/>kg.
									</td>
									<td>
										<input type="button" accesskey="p" value="Save & Print<Alt+p>"
												class="menulired" onclick="funSaveOrder();" />
									</td>
										
									<td>
										<input type="button" accesskey="r" value="Refresh<Alt+r>" class="menulired"
												onclick="window.location.reload()" />
									</td>
										
									<td>
										<input type="button" accesskey="h" value="Home<Alt+h>"
												class="menulired" onclick="funCancelOrder();" />
									</td>
								</tr>
								
							</table>
						</td>
					</tr>
					<tr style="width:100%;height:75%;">
						<td style="width:100%;height:75%;">
							<div id="selectedItemListDiv" style="height:100%;border:1px solid black;visibility: visible;">
								<div id="inner2" style="height:150px;;width:100%; overflow-y:scroll;visibility: visible;">
									<table class="genericTbl1" style="font-size: 80%;width:100%;margin-right: -17px;height150px;visibility: " id="selectedItemsTable" border="1">
										<thead bgcolor="#BEF781" style="height:20px;">
											<tr>
												<th>Item Name</th>
												<th>Weight</th>
												<th>MRP</th>
												<th>Old Quantity</th>
												<th>New Quantity</th>
												<th>Total Quantity</th>
												<th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
											</tr>
										</thead>
										<tbody  bordercolor="#EFFBEF" id="selectedItemsTable1">
										</tbody>
									</table>
								</div>
								<div id="secondWrapper2" style="background-color: #BEF781; left:0; top:0; height:27px; overflow-y:scroll;margin-top:-150px;"></div>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<br/>
		</center>
		<div id="baseDiv" style="top: 0px;" align="center"></div>
		<div id="popupItemDiv"
			style="x-height: 140px; x-width: 850px; border: 2px solid black; background-color: #BEF781; padding: 27px; display: none; font-size: 100%; text-align: center;">
			
		</div>
		
		
		<script type="text/javascript">
			window.onload = funOnload;
			function funOnload() {
				getSiteList();
			}
		</script>
	</form>
	<div id="popupMouseOver" class="popupMouseOver" style="display:none;">
		<div id="close" onclick="closePopup();"><b>x</b></div>
		<div id="right"></div>
		<div id="inner_div" style="width:150px;padding:2px;"></div>
	</div>
</body>
</html>