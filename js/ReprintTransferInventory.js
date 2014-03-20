var xmlHttp;
var globalTransferQty=0;
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
	var url = "ReprintTransferInventoryAjaxResponse.jsp";
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
		//alert("Please Select destination name.");
		return false;
	} else if (siteId == desId) {
		//document.myform.transId.style.display = "none";
		alert("Please select different destination address");
		return false;
	}
	//document.getElementById("wait1").style.display = "block";
	getData("getTransferNumber");
}

function funSearchTrnsList() {
	//document.myform.searchTrnsNumber.value = "";
	var trnsnumbr = document.myform.transId.value;
	var siteId = document.myform.siteId.value;
	var desId = document.myform.desId.value;
	document.myform.ajaxCallOption.value = "popupTable";

	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	var url = "ReprintTransferInventoryAjaxResponse.jsp" + "?ajaxCallOption=popupTable"
			+ "&searchTrnsNumber=" + trnsnumbr + "&siteId=" + siteId+"&desId="+desId;

	url = url + "&sid=" + Math.random();
	xmlHttp.onreadystatechange = stateChangedSearchStringg;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
}

function stateChangedSearchStringg() {
	if (xmlHttp.readyState == 4) {
		document.getElementById("selectedItemsDiv").innerHTML = xmlHttp.responseText;
		document.myform.grandTotalQty.value = document.getElementById('GrandTotalHidden').value;
		document.getElementById('grandTotalQtyHidden').value= document.getElementById('GrandTotalHidden').value; 
		document.myform.grandTotalItems.value = document.getElementById('GrandItemHidden').value;
		xmlHttp = null;
	}
	//document.myform.searchTrnsNumber.focus();
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
	var url = "ReprintTransferInventoryAjaxResponse.jsp" + "?ajaxCallOption=popupTable"
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


function Clear() {//alert('refresh')
	window.location.reload();
	return;
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

	var accept = document.myform.Iaccept_qty.value;
	var objTable = eval('document.getElementById("displayItemTable")');
	var objrows = objTable.getElementsByTagName("TBODY")[0].rows;
	var objrowsLength = objTable.getElementsByTagName("TBODY")[0].rows.length;
	var itemStatus;
	var siteId= document.myform.siteId.value;
	var desId=document.myform.desId.value;
	
	//document.getElementById("searchTrnsNumberListDiv").innerHTML="";
	//document.myform.action = "ReceiveInventory.jsp";
	document.myform.action = "ReprintTransferInventory.jsp?sourceName="+$("#siteId1 option:selected").text();
	document.myform.action += "&destName="+$("#desId1 option:selected").text();
	document.myform.action += "&siteId="+siteId;
	document.myform.action += "&desId="+desId;
	
	
	document.myform.submit();
}
function funCancelOrder() {
	document.myform.action = "HomeForm.jsp";
	document.myform.submit();
}


