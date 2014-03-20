<%@page contentType="text/html"%>
<html>
<head>
<title>Retail Management-Janta Stores</title>
<script src="js/CloseTransferInventory.js"></script>
<script type="text/javascript" src="js/popup.js"></script>
<link rel="stylesheet" type="text/css" href="css/border_radius.css" />

<%@ page errorPage="ErrorPage.jsp?page=ClosedTransferInventoryForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
		
		%>

</head>
<body class="bodyClass">
	<form name="myform" method="post">
	
	<br/>
	<center><h4>Close Transfer Inventory</h4></center>
		<table align="center" style="width:100%">
			<tr>
				<td style="width:10%">&nbsp;</td>
				<td style="width:80%">
					<div class="roundedDiv" style="background-color: #BEF781; border:1;width:100%;height:120px;">
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
									<div style="height:50px;vertical-align:middle;padding-top:15px" id="sourceAddress"></div>
								</td>
								<td>&nbsp;</td>
								<th>Destination Address</th>
								<td>
									<div style="height:50px;vertical-align:middle;padding-top:16px" id="destinationAddress"></div>
								</td>
								<td><div id='wait1'  class="transparent1"><h3>Please Wait.....</h3></div></td>
								<td>&nbsp;</td>
								</tr>
								
								<tr>
								<th>Select Transfer Number:</th>
								<td>
									<div id="transferNumDiv"></div>
								</td>
						 
									<th>Enter Transfer Number:</th>
									<td><input type="text" name="searchTrnsNumber" 
												size="20" tabindex="4"/></td>
									<td><input  type="button" accesskey="s" value="Search<Alt+s>" class="menulired"
											onclick="funSearchItem();" /></td>
									<td><div id='wait'  class="transparent1"><h3>Please Wait.....</h3></div></td>
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
					<table class="custorderinfo"  >
					<tr>
						<td style="width:1%;"></td>
								<td style="width:72%;">
								<div id="selectedItemsDiv" style="height:180px;overflow:auto;border:1;width:100%;">	
								</div>	
								</td>															
							</tr>							
					</table>
				<table class="custorderinfo" style="width:20%">
				<tr>
				<td><input type="button" accesskey="p" value="Close And Print<Alt+p> " class="menulired"
						onclick="funSaveOrder();" /></td>
				<td><input type="button" accesskey="h" value="Home<Alt+h>" class="menulired" onclick="funCancelOrder();"></input></td>
				</tr>
				</table>
				</div>
				</td>
				<td style="width:10%">&nbsp;</td>
			</tr>
		</table>
		<input type="hidden" name="trnsnumbr">
		<input type="hidden" name="ajaxCallOption">
		
		<script type="text/javascript">
			window.onload = funOnload;

			function funOnload() {
				getData("getSite");
			}
		</script>
	</form>
</body>
</html>
	
