<%@page contentType="text/html"%>
<html>
<head>
<title>Retail Management-Janta Stores</title>
<script src="js/ReceiveInventory.js"></script>
<script type="text/javascript" src="js/popup.js"></script>
<script src="js/jquery-1.10.2.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/border_radius.css" />
	<link rel="stylesheet" href="css/themes/base/jquery.ui.all.css">
	<script src="js/ui/jquery.ui.core.js"></script>
	<script src="js/ui/jquery.ui.widget.js"></script>
	<script src="js/ui/jquery.ui.datepicker.js"></script>
	<link rel="stylesheet" href="css/demos.css">
<%@ page errorPage="ErrorPage.jsp?page=ReceiveInventoryForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
</head>
<body class="bodyClass">
	<form name="myform"method="post">
	<br/>
	<center><h4>Receive Inventory</h4></center>
		<table align="center" style="width:100%">
			<tr >
				<td style="width:10%">&nbsp;</td>
				<td style="width:80%">
					<div class="roundedDiv" style="background-color: #BEF781; border:1;width:100%;height:160px;">
						<table class="custorderinfo"  style="width:80%">
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
									<div style="height:50px;vertical-align:middle;padding-top:15px;" id="sourceAddress"></div>
								</td>
								<td>&nbsp;</td>
								<th>Destination Address</th>
								<td>
									<div style="height:50px;vertical-align:middle;padding-top:15px;" id="destinationAddress"></div>
								</td>
								<td><div id='wait1'  class="transparent1"><h3>Please Wait.....</h3></div></td>
								<td>&nbsp;</td>
								
								</tr>
								<tr><td><b>From Date&nbsp;&nbsp;:</b></td><td><input type="text" id='fromDate' value="" readonly="readonly"></div></td>
								<td><b>To Date&nbsp;&nbsp;:</b></td><td><input type="text" id='toDate' value="" readonly="readonly"></div></td>
								<td style="text-align: right;width:40px;"><input type="button" id='search' onclick="checkSelectBoxOption();return false;"  value="Search Inventory" disabled="disabled"/></td>
								<td><input type="button" onclick="window.location.reload();"  value="Reset" /></td>
								</tr>
								
								<tr>
								<th>Select Transfer Number:</th>
								<td>
									<div id="transferNumDiv"></div>
								</td>
						  </tr>							
						</table>
					</div>
				</td>
				<td style="width:10%">&nbsp;</td>
			</tr>
			<tr>
				<td style="width:10%">&nbsp;</td>
				<td style="width:80%">
					<div class="roundedDiv" style="background-color: #BEF781; border:1;width:100%;height:200px;">
						<table class="custorderinfo"  >
							<tr>
								<td style="width:27%;">						
									<table class="custorderinfo">
										<tr>
											<th>Enter Transfer Number:</th>
											<td colspan="3"><input type="text" name="searchTrnsNumber" 
												size="20" onchange="" tabindex="4"/></td>
											<td><div id='wait'  class="transparent1"><h3>Please Wait.....</h3></div></td>
										</tr>
										<tr>
											<td></td>
											<td><input  type="button" accesskey="s" value="Search<Alt+s>" class="menulired"
												onclick="funSearchItem();" />
											</td>
												
												
										</tr>						
									</table>
								</td>
								<td style="width:1%;"></td>
								<td style="width:72%;">
									<div id="searchTrnsNumberListDiv" style="height:200px;overflow:auto;border:1"> </div>
								</td>
							</tr>
						</table>
					</div>
				</td>
				<td style="width:10%">&nbsp;</td>
			</tr>
			<tr>
				<td style="width:10%">&nbsp;</td>
				<td style="width:80%">
					<div class="roundedDiv"  style="background-color: #BEF781; border:1;width:100%;height:250px;">
						<table class="custorderinfo" style="height: 100%;">
							<tr>
							<td style="width:1%;"></td>
								<td style="width:72%;">
									<div align="center" id="selectedItemsDiv" style="height:100%;text-align:center;border:1;width:100%;overflow: auto;">
									<!-- <div align="center" id="selectedItemsDiv" style="height:180px;text-align:center;border:1;width:100%;"> -->				
									</div>
								</td>
							</tr>
							</table>
							
							<table class="custorderinfo" style="width:20%">
									<tr>											
										<td><input type="button" accesskey="p" value="Save and Print<Alt+p>" class="menulired"
										onclick="funSaveOrder();" /></td>
										<td><input type="button" accesskey="r" value="Refresh<Alt+r>" class="menulired" onclick="Clear();"/></td>
										<td><input type="button" accesskey="h" value="Home<Alt+h>" class="menulired" onclick="funCancelOrder();"></input></td>
									</tr>
								</table>
								</div>
				</td>
				<td style="width:10%">&nbsp;</td>
			</tr>
		</table>
		<input type="hidden" name="hItemStatus"> 
		<input type="hidden" name="ajaxCallOption">
		
		<script type="text/javascript">
			window.onload = funOnload;

			function funOnload() {
				 $( "#fromDate" ).datepicker({
						defaultDate: "+1w",
						changeMonth: true,
						maxDate:new Date(),
						//numberOfMonths: 3,
						onClose: function( selectedDate ) {
							$( "#toDate" ).datepicker( "option", "minDate", selectedDate );
						}
					});
					$( "#toDate" ).datepicker({
						defaultDate: "+1w",
						changeMonth: true,
						//numberOfMonths: 3,
						maxDate:new Date(),
						
						onClose: function( selectedDate ) {
							$( "#fromDate" ).datepicker( "option", "maxDate", selectedDate );
						}
					});
				getData("getSite");
			}
		</script>
	</form>
</body>
</html>
	
