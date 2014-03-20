
	<html>
	<head>
	<title>Retail Management-Janta Stores</title>
	<script src="js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="js/BachkaMapping.js"></script>
	
	<script src="js/DataTable/jquery.js" type="text/javascript"></script>
	<script src="js/DataTable/jquery.dataTables.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href=css/BachkaMapping.css />
	
	<!-- JS and css for grid filtering  -->
	<!-- <link rel="stylesheet" href="js/jqwidgets/styles/jqx.base.css" type="text/css" />
    <script type="text/javascript" src="js/jqwidgets/jqxbuttons.js"></script> -->
	
	<script type="text/javascript">
		window.onload = initializeBachkaMapping;
		
	</script>
	</head>
	<%@ page errorPage="ErrorPage.jsp?page=BachkaMappingForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
<body style="background-color: transparent;">
	
	
		<table style="width: 100%;height: 15px;">
			<tr>
			
			<td style="text-align: center;"><h3 align="center">Bachka Mapping</h3></td>
			<td style="text-align: right;"><img alt="home" src="images/Background/House-icon.png" onclick="window.location.assign('HomeForm.jsp');">&nbsp;&nbsp;&nbsp;&nbsp;
			<img alt="reload" src="images/Background/Actions-view-refresh-icon.png" onclick='window.location.reload();'></td>
			</tr>
		</table>
		<center>
		<div id="outer1" style="margin-top:0px;height: 200px; background-color: #BEF781;">
			
				<table  border="0" style="width: 100%;height: 100%;border-collapse: collapse;margin-top: 0px;" >
			
				<tr  style="height: 30%; margin-top: 0px;">
			
					<td style="width: 25%;margin-top: 0px;margin-right: 5px;" >
<!-- 				<div id="searchBachkaId"> -->
					<table id="searchBachkaForm" cellspacing="15" border="0"  style="margin-top: 0px;">
					<form name="bachkaMappingForm" method="post">
					<tr style="margin-top: 0px;">
					<th align="left" style="margin-top: 0px;">Site name&nbsp</th><th style="margin-top: 0px;"><div id="siteNameDiv"></div></th>
					</tr>
					<tr>
					<th align="left">Enter Bar Code</th><th><input type="text" name="bachkaBarcode" tabindex="1" class="textfield"></th>
					</tr>
					<tr>
					<th align="left">Enter Bachka Name</th><th><input type="text" name="bachkaName" tabindex="1" class="textfield"></th>
					</tr>
					<tr>
					  <th><input type="button" style="width: 200px;" id="seachBachka" class="button" onClick="funSearchBachka();" tabindex="1" accesskey="s" value="Search Bachka <Alt+S>"/></th>
					 
					 <th><button class="button" style="width: 200px;" onclick="window.location.reload();" accesskey="r">Refresh &lt;Alt+R&gt;</button></th></tr>
					</form>
					</table>
					</div>
				</td>
				<td style="width: 75%;margin-left:5px;" id ="displayBachkaIdCol">
					<div id="displayBachkaId" style="height: 170px;margin-top: 10px;"></div>
				</td>
				
			</tr></table>
			
		</div>
			<div id="outer2" style=" margin-top:4px; height: 380px;background-color: #BEF781;">
				<table style=" height: 10%;width: 100%;" border="0">
					<tr style="margin-top: 2px;">
						<td style="width: 30%;height: 20px;margin-right: 5px;">
						<p style="font-size: 15px;font-family:'Times New Roman', Times, serif;"><b>Selected Bachka :</b></p>
						<div id="selectedBachkaDIV" style="height:100px; width: 100%;overflow:auto;border:1px solid #98bf21;">
							<table style="height: 100%;width: 100%;border-collapse: collapse;" border="0" id="selectedBachkaTable">
								<thead style="height: 4px;font-family:'imes New Roman',Times,serif;">
									<tr style="text-align: left;">
										<th style="width: 33%;">Item Name</th>
										<th style="width: 12%;">Weight</th>
										<th style="width: 12%;">MRP</th>
										<!-- <th style="width: 15%;">Site Inventory</th> -->
										<th style="width: 15%;">Total Inventory</th>
									</tr>
								</thead>
								<tbody style="height: 7px;">
									<tr>
										<td id="selectedItemName">null</td>
										<td id="selectedItemWeight">null</td>
										<td id="selecteditemMrp">null</td>
									<!-- 	<td id="selectedItemSiteQty">null</td> -->
										<td id="selectedItemTotalQty">null</td>
									
									</tr>
								
								</tbody>
											
							</table>
						
						</div>
					</td>
					<td rowspan="2" style="width: 55%;margin-left: 5px;" id="itemByGroupCodeCol" >
						<!-- <div id="itemByGroupCode" class="itemByGroupCode" style="width: 100%; height:100%;overflow:auto;"></div>
						 --><table border="0" style="height: 100%;width: 100%;">
						<tr>
							<tr>
								<td style="height: 10%;"><div id="searchItemByGroupCode" style="width: 100%;height: 100%;"></div></td>
							</tr>
							<tr><td style="width: 100%;height: 90%;"><div id="itemByGroupCode" class="itemByGroupCode" style="width: 100%; height:100%;"></div></td>
							</tr>
						</table>
					</td>
					</tr>
					<tr>
						<td style="width: 30%;height: 170px;overflow: auto;margin-right: 5px;">
							<table style="height: 100%;width: 100%;">
								<tr><td><p style="font-size: 15px;"><b>Mapped Item :</b></p></td></tr>
								<tr><td><div id="addToBachka" style="height: 170px;border:1px solid #98bf21; overflow: auto;"></td></tr>
							</table>
								
							</div>
					</td>
					</tr>
				</table>
				<div id="button" style="height: 20px;margin-top: 0px;text-align: left;">
				<button class="button" onclick="saveToDB();">Save</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button class="button" onclick="cancelReccord();">Cancel</button>
					</div>
			</div></center>
			
	</body>

</html>