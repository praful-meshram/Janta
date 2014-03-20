var xmlHttp;

function GetXmlHttpObject() {
	var xmlHttp = null;
	try {
		// Firefox, Opera 8.0+, Safari
		xmlHttp = new XMLHttpRequest();
	} catch (e) {
		// Internet Explorer
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	return xmlHttp;
}

function getData(src) {

	document.myform.ajaxCallOption.value = src;

	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	var url = "ReceiveInventoryAjaxResponse.jsp";
	if (src == "getSite") {
		url = url + "?ajaxCallOption=getSite";
	} else if (src == "getSiteAddress") {
		if(document.myform.siteId.value != ""){
			url = url + "?ajaxCallOption=getSiteAddress&siteId=" + document.myform.siteId.value;
		} else {
			return;
		}
	} else if (src == "getDes") {
		url = url + "?ajaxCallOption=getDes";
	} else if (src == "getDesAddress") {
		if(document.myform.desId.value != ""){
			url = url + "?ajaxCallOption=getDesAddress&siteId=" + document.myform.desId.value;
			
		} else {
			return;
		}
	} else if (src == "getTransferNumber") {
		url = url + "?ajaxCallOption=getTransferNumber&siteId=" + document.myform.siteId.value + "&desId=" + document.myform.desId.value;	
		var fromDate = $('#fromDate').val();
		var toDate = $('#toDate').val();
		if(fromDate!="" && toDate!=""){
			url = url+"&fromDate="+$('#fromDate').val();
			url = url+"&toDate="+$('#toDate').val();
		}else if(fromDate!="" && toDate==""){
			alert("enter to date ");
			return;
			
		}else if(toDate!="" && fromDate==""){
			alert("enter from date ");
			return;
		}
	}

	url = url + "&sid=" + Math.random();
	xmlHttp.onreadystatechange = stateChangedGetSite;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);

}

function stateChangedGetSite() {
	if (xmlHttp.readyState == 4) {
		var src = document.myform.ajaxCallOption.value;
		//alert(src);
		if (src == "getSite") {
			document.getElementById("sourceSiteDiv").innerHTML = xmlHttp.responseText;
			getData("getDes");
		} else if (src == "getSiteAddress") {
			document.getElementById("sourceAddress").innerHTML = xmlHttp.responseText;
			//checkSelectBoxOption();
		} else if (src == "getDes") {
			document.getElementById("desSiteDiv").innerHTML = xmlHttp.responseText;
			document.myform.siteId.focus();
			//checkSelectBoxOption();
		} else if (src == "getDesAddress") {
			document.getElementById("destinationAddress").innerHTML = xmlHttp.responseText;
			$('#search').removeAttr('disabled');
			//checkSelectBoxOption();
		} else if (src == "getTransferNumber") {
			document.getElementById("wait1").style.display = "none";
			document.getElementById("transferNumDiv").innerHTML = xmlHttp.responseText;
		}

	}
}
function checkSelectBoxOption() {

	var siteId = document.myform.siteId.value;
	var desId = document.myform.desId.value;
	if (siteId == "") {
		alert("Please Select site name.");
		return false;
	} else if (desId == "") {
		alert("Please Select destination name.");
		return false;
	} else if (siteId == desId) {
		//document.myform.transId.style.display = "none";
		$('#transId1').css({'display':'none'});
		alert("Please select different destination address");
		return false;
	}
	//document.getElementById("wait1").style.display = "block";
	getData("getTransferNumber");
}

function funSearchTrnsList() {
	document.myform.searchTrnsNumber.value = "";
	var trnsnumbr = document.myform.transId.value;
	var siteId = document.myform.siteId.value;
	var desId = document.myform.desId.value;
	document.myform.ajaxCallOption.value = "popupTable";

	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	var url = "ReceiveInventoryAjaxResponse.jsp" + "?ajaxCallOption=popupTable"
			+ "&searchTrnsNumber=" + trnsnumbr + "&siteId=" + siteId+"&desId="+desId;

	url = url + "&sid=" + Math.random();
	xmlHttp.onreadystatechange = stateChangedSearchStringg;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
}

function stateChangedSearchStringg() {
	if (xmlHttp.readyState == 4) {
		document.getElementById("selectedItemsDiv").innerHTML = xmlHttp.responseText;
		xmlHttp = null;
	}
	document.myform.searchTrnsNumber.focus();
}

function funSearchItem() {
	document.getElementById("selectedItemsDiv").innerHTML = "";
	var searchTrnsNumber = document.myform.searchTrnsNumber.value;
	var siteId = document.myform.siteId.value;
	var desId = document.myform.desId.value;
	document.myform.ajaxCallOption.value = "searchString";
	if (siteId == "") {
		alert("Please Select site name.");
		document.myform.siteId.focus();
		return false;
	} else if (desId == "") {
		alert("Please select destination name.");
		document.myform.desId.focus();
		return false;
	}
	if (searchTrnsNumber == "") {
		alert("Please enter transfer number.");
		document.myform.searchTrnsNumber.focus;
		return false;
	}
	document.getElementById("wait").style.display = "block";
	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	var url = "ReceiveInventoryAjaxResponse.jsp"
			+ "?ajaxCallOption=searchString" 
			+ "&searchTrnsNumber=" + searchTrnsNumber
			+ "&siteId=" + siteId
			+"&desId="+desId;

	url = url + "&sid=" + Math.random();
	xmlHttp.onreadystatechange = stateChangedSearchString;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
}

function stateChangedSearchString() {
	if (xmlHttp.readyState == 4) {
		document.getElementById("wait").style.display = "none";
		document.getElementById("searchTrnsNumberListDiv").innerHTML = xmlHttp.responseText;
		xmlHttp = null;
	}
	document.myform.searchTrnsNumber.focus();
}

function fundisplayTable(trnsferNumber) {
	var siteId = document.myform.siteId.value;
	var desId = document.myform.desId.value;
	document.myform.ajaxCallOption.value = "popupTable";
	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	var url = "ReceiveInventoryAjaxResponse.jsp" + "?ajaxCallOption=popupTable"
			+ "&searchTrnsNumber=" + trnsferNumber+"&siteId="+siteId+"&desId="+desId;

	url = url + "&sid=" + Math.random();
	xmlHttp.onreadystatechange = stateChangedSearchStr;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);

}

function stateChangedSearchStr() {
	if (xmlHttp.readyState == 4) {
		document.getElementById("selectedItemsDiv").innerHTML = xmlHttp.responseText;
		xmlHttp = null;

	}
}

function statusOptions(src) {
	var tr = src.parentNode.parentNode
	var rowCount = tr.parentNode.rows.length;
	var row = tr.rowIndex - 1;
	var accept = document.myform.Iaccept_qty.value;
	
	if (rowCount == 1) {		
		var src = document.myform.Isource_qty.value;
		var statusvalue = document.myform.IStatus.value;
		var source = document.myform.Isource_qty.value;
		var des = document.myform.Ides_qty.value;
		if (statusvalue == "TRANSFER") {
			document.myform.Iaccept_qty.style.backgroundColor = "#EFFBEF";
			document.myform.Iaccept_qty.style.border = "0px";
			document.myform.Iaccept_qty.value = document.myform.Itransfer_qty.value;			
		} else if (statusvalue == "NOT TRANSFER") {
			
			document.myform.Iaccept_qty.style.backgroundColor = "#EFFBEF";
			document.myform.Iaccept_qty.style.border = "0px";
			document.myform.Iaccept_qty.value = '0';			
		} else if (statusvalue == "CHNGQTY-RCVD MORE") {			
			document.myform.Iaccept_qty.value = accept;
			document.myform.Iaccept_qty.style.backgroundColor = "white";
			document.myform.Iaccept_qty.style.border = "1px solid black";
			document.myform.Iaccept_qty.readOnly = false;
			document.myform.Iaccept_qty.focus();
		} else if (statusvalue == "CHNGQTY-RCVD LESS") {
			document.myform.Iaccept_qty.value = accept;
			document.myform.Iaccept_qty.style.backgroundColor = "white";
			document.myform.Iaccept_qty.style.border = "1px  solid black";
			document.myform.Iaccept_qty.readOnly = false;
			document.myform.Iaccept_qty.focus();
		}
		var accept = document.myform.Iaccept_qty.value;
		var remainingqty=parseInt(source) - parseInt(accept);		
		//alert(remainingqty)
		document.myform.IRemainingqty.value=remainingqty;
		var aftrtrnsqty=parseInt(accept) + parseInt(des) ;
		//alert(aftrtrnsqty)
		document.myform.IAftrtransqty.value=aftrtrnsqty;
		
	} else {
		
		var accept = document.myform.Iaccept_qty[row].value;
		var statusvalue = document.myform.IStatus[row].value;
		var source = document.myform.Isource_qty[row].value;
		var des = document.myform.Ides_qty[row].value;
		
		if (statusvalue == "TRANSFER") {
			document.myform.Iaccept_qty[row].style.backgroundColor = "#EFFBEF";
			document.myform.Iaccept_qty[row].style.border = "0px";
			document.myform.Iaccept_qty[row].value = document.myform.Itransfer_qty[row].value;
			
		} else if (statusvalue == "NOT TRANSFER") {
			
			document.myform.Iaccept_qty[row].style.backgroundColor = "#EFFBEF";
			document.myform.Iaccept_qty[row].style.border = "0px";
			document.myform.Iaccept_qty[row].value = '0';
			
		} else if (statusvalue == "CHNGQTY-RCVD MORE") {
			document.myform.Iaccept_qty[row].value = accept;
			document.myform.Iaccept_qty[row].style.backgroundColor = "white";
			document.myform.Iaccept_qty[row].style.border = "1px  solid black";
			document.myform.Iaccept_qty[row].readOnly = false;
			document.myform.Iaccept_qty[row].focus();
			
		} else if (statusvalue == "CHNGQTY-RCVD LESS") {
			document.myform.Iaccept_qty[row].value = accept;
			document.myform.Iaccept_qty[row].style.backgroundColor = "white";
			document.myform.Iaccept_qty[row].style.border = "1px  solid black";
			document.myform.Iaccept_qty[row].readOnly = false;
			document.myform.Iaccept_qty[row].focus();
			
		}
		var accept = document.myform.Iaccept_qty[row].value;
		//var remainingqty=parseInt(source) - parseInt(accept);
		//document.myform.IRemainingqty[row].value=remainingqty;
		//var aftrtrnsqty=parseInt(accept) + parseInt(des) ;
		//document.myform.IAftrtransqty[row].value=aftrtrnsqty;

	}
	

}
function validate(src11,rowID) {
	
	var tr = src11.parentNode.parentNode
	var rowCount = tr.parentNode.rows.length;	
	var a1 = tr.rowIndex;
	//var row = tr.rowIndex - 1;
	var row = parseInt(rowID);
	
	var accept = parseInt(document.myform.Iaccept_qty[row].value);
	var source = parseInt(document.myform.Isource_qty[row].value);
	var des = parseInt(document.myform.Ides_qty[row].value);
	var statusvalue = document.myform.IStatus[row].value;
	var transfer = parseInt(document.myform.Itransfer_qty[row].value);
	
	//alert('accept '+accept+"\n source "+source+"\n transfer "+transfer+"  "+ (accept > source) + " "+( parseInt(accept) > parseInt(source)))
	
	//alert($('#itemStatus'+row+' option:selected').val())
	//var accept = src11.value;
	var statusvalue = $('#itemStatus'+row+' option:selected').val();
	
	if (rowCount == 1) {		
			
		if (accept > source) {
			document.myform.Iaccept_qty[row].focus();
			alert("Please enter value of Accept Quantity less than  or equal to Source Quantity.");
			document.myform.Iaccept_qty[row].value = document.myform.Itransfer_qty[row].value;
			return false;
		} else if (accept == "0") {
			//document.myform.Iaccept_qty.focus();
			alert("Please enter value greater than zero.");
			return false;

		} else if (statusvalue == "CHNGQTY-RCVD LESS") {
			if (accept > transfer) {
				alert("You have received less qty please enter less value of accept qty.");
				document.myform.Iaccept_qty[row].value = document.myform.Itransfer_qty[row].value;
				document.myform.IStatus[row].value = 'TRANSFER';
				return false;
			}
		}else if (statusvalue == "CHNGQTY-RCVD MORE") {
			if (accept < transfer) {
				alert("You have received more qty please enter greater value of accept qty.");
				document.myform.Iaccept_qty[row].value = document.myform.Itransfer_qty[row].value;
				document.myform.IStatus[row].value = 'TRANSFER';
				return false;
			}
		}else{
			var remainingqty=parseInt(source) - parseInt(accept);
			document.myform.IRemainingqty.value=remainingqty;
			var aftrtrnsqty=parseInt(accept) + parseInt(des) ;
			document.myform.IAftrtransqty.value=aftrtrnsqty;
		}
			
	} else {
		
		 if (accept > source) {

			document.myform.Iaccept_qty[row].focus();
			alert("Please enter value of Accept Quantity less than  or equal to Source Quantity.");
			document.myform.Iaccept_qty[row].value = document.myform.Itransfer_qty[row].value;
			return false;
		} else  if (accept == "0") {
			alert("Please enter value greater than zero.");
			return false;

		} else if (statusvalue == "CHNGQTY-RCVD LESS") {
			if (accept > transfer) {
				alert("You have received less qty please enter less value of accept qty.");
				document.myform.Iaccept_qty[row].value = document.myform.Itransfer_qty[row].value;
				document.myform.IStatus[row].value = 'TRANSFER';
				return false;
			}
		}else if (statusvalue == "CHNGQTY-RCVD MORE") {
			if (accept < transfer) {
				alert("You have received more qty please enter greater value of accept qty.");
				document.myform.Iaccept_qty[row].value = document.myform.Itransfer_qty[row].value;
				document.myform.IStatus[row].value = 'TRANSFER';
				return false;
			}
		}else{
			var remainingqty=parseInt(source) - parseInt(accept);
			document.myform.IRemainingqty[row].value=remainingqty;
			var aftrtrnsqty=parseInt(accept) + parseInt(des) ;
			document.myform.IAftrtransqty[row].value=aftrtrnsqty;
		}	
	}
	
	
}

function Clear() {
	document.myform.siteId.value = "";
	document.myform.desId.value = "";
	document.myform.transId.value = "";
	document.myform.searchTrnsNumber.value = "";
	document.getElementById("selectedItemsDiv").innerHTML = "";
	document.getElementById("searchItemTable").innerHTML = ""
	document.getElementById("searchItemListDiv").innerHTML = "";
	document.getElementById("displayItemTable").innerHTML = "";
	document.getElementById("searchTrnsNumberListDiv").innerHTML = "";
	//document.getElementById("searchTrnsNumberListDiv").innerHTML="";
	//funClearBarcodeItemName();
}
function funSaveOrder() {
//alert(document.getElementById("Remark1").value);	
remark1 = document.getElementById("Remark1").value;

/* if(remark1=="" || remark1==null){
	alert("Please enter Remark ");
	return false;	
} */

	var accept = document.myform.Iaccept_qty.value;
	var objTable = eval('document.getElementById("displayItemTable")');
	var objrows = objTable.getElementsByTagName("TBODY")[0].rows;
	var objrowsLength = objTable.getElementsByTagName("TBODY")[0].rows.length;
	var itemStatus;
	//var statusvalue = document.myform.IStatus[objrowsLength].value;
	if (objrowsLength == 1) {

		var statusvalue = document.myform.IStatus.value;
		if (accept == "") {
			alert("Please enter Accept Quantity");
			return false;
		}
		if (statusvalue == "TRANSFER") {
			itemStatus = "RECEIVE";
		} else if (statusvalue == "NOT TRANSFER") {
			itemStatus = "NOT TRANSFER";
		} else if (statusvalue == "CHNGQTY-RCVD MORE") {
			itemStatus = "Change Qty";
		} else if (statusvalue == "CHNGQTY-RCVD LESS") {
			itemStatus = "Change Qty";
		}
		document.myform.hItemStatus.value = itemStatus;
	} else {
		var tFlag=false, ntFlag=false, chQtyFlag=false; 
		for ( var i = 0; i < objrowsLength; i++) {
			var statusvalue = document.myform.IStatus[i].value;
			//alert("statusvalue "+statusvalue );
			var accept = document.myform.Iaccept_qty[i].value;
			if (accept == "") {
				alert("Please enter Accept Quantity");
				return false;
			}
			if (statusvalue == "TRANSFER") {
				tFlag = true;
			} else if (statusvalue == "NOT TRANSFER") {					
				ntFlag =true;					
			}else if (statusvalue == "CHNGQTY-RCVD MORE") {					
				chQtyFlag =true;					
			}else if (statusvalue == "CHNGQTY-RCVD LESS") {					
				chQtyFlag =true;					
			}
		}
		var itemStatus="";
		if(tFlag == true && ntFlag == true && chQtyFlag == true){
			itemStatus = "ChangeQty";
		}else if(tFlag == true && ntFlag == true && chQtyFlag == false){
			itemStatus = "RECEIVE";
		}else if(tFlag == false && ntFlag == true && chQtyFlag == true){
			itemStatus = "ChangeQty";
		}else if(tFlag == false && ntFlag == false && chQtyFlag == true){
			itemStatus = "ChangeQty";
		}else if(tFlag == true && ntFlag == false && chQtyFlag == false){
			itemStatus = "RECEIVE";
		}else if(tFlag == false && ntFlag == true && chQtyFlag == false){
			itemStatus = "Not Transfer";
		}
		document.myform.hItemStatus.value = itemStatus;
	}
	document.getElementById("searchTrnsNumberListDiv").innerHTML="";
	//document.myform.action = "ReceiveInventory.jsp";
	document.myform.action = "ReceiveInventory.jsp?sourceName="+$("#siteId1 option:selected").text();
	document.myform.action += "&destName="+$("#desId1 option:selected").text();
	document.myform.submit();
}
function funCancelOrder() {
	document.myform.action = "HomeForm.jsp";
	document.myform.submit();
}