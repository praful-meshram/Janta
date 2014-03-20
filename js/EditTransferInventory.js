var xmlHttp;
var globalTransferQty=0;

// global variable for prevent insert exception
var globalItemCodeArray = new Array();
var globalTransferIdArray = new Array();
var globalPriceVersionArray = new Array();

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
	var url = "EditTransferInventoryAjaxResponse.jsp";
	
	
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
			//checkSelectBoxOption();
			$('#search').removeAttr('disabled');
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
	var url = "EditTransferInventoryAjaxResponse.jsp" + "?ajaxCallOption=popupTable";
	if(trnsnumbr!='')
		url=url+"&searchTrnsNumber=" + trnsnumbr;
	
	url=url+"&siteId=" + siteId+"&desId="+desId;
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

function funSearchItem() {
	document.getElementById("selectedItemsDiv").innerHTML = "";
	var searchTrnsNumber = document.myform.transId.value;
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
	var url = "EditTransferInventoryAjaxResponse.jsp" + "?ajaxCallOption=popupTable"
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
	//var accept = document.myform.Iaccept_qty.value;
	
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
		var remainingqty=parseInt(source) - parseInt(accept);
		document.myform.IRemainingqty[row].value=remainingqty;
		var aftrtrnsqty=parseInt(accept) + parseInt(des) ;
		document.myform.IAftrtransqty[row].value=aftrtrnsqty;

	}
	

}
function validate(src11) {
	var tr = src11.parentNode.parentNode
	var rowCount = tr.parentNode.rows.length;	
	var a1 = tr.rowIndex;
	var row = tr.rowIndex - 1;
		
	if (rowCount == 1) {		
		var statusvalue = document.myform.IStatus.value;
		var transfer = document.myform.Itransfer_qty.value;
		//var accept = document.myform.Iaccept_qty.value;
		//var accept = document.myform.Itransfer_qty.value;
		var accept =src11.value;
		
		
		var source = document.myform.Isource_qty.value;
		var des = document.myform.Ides_qty.value;
		if (accept > source) {
			document.myform.Iaccept_qty.focus();
			alert("Please enter value of Accept Quantity less than  or equal to Source Quantity.");
			return false;
		} else if (accept == "0") {
			//document.myform.Iaccept_qty.focus();
			alert("Please enter value greater than zero.");
			return false;

		} else if (statusvalue == "CHNGQTY-RCVD LESS") {
			if (accept > transfer) {
				alert("You have received less qty please enter less value of accept qty.");
				return false;
			}
		}else if (statusvalue == "CHNGQTY-RCVD MORE") {
			if (accept < transfer) {
				alert("You have received more qty please enter greater value of accept qty.");
				return false;
			}
		}else{
			var remainingqty=parseInt(source) - parseInt(accept);
			//alert(remainingqty);
			document.myform.IRemainingqty.value=remainingqty;
			var aftrtrnsqty=parseInt(accept) + parseInt(des) ;
			//alert(aftrtrnsqty);
			document.myform.IAftrtransqty.value=aftrtrnsqty;
		}
			
	} else {
		var accept = document.myform.Iaccept_qty[row].value;
		var source = document.myform.Isource_qty[row].value;
		var des = document.myform.Ides_qty[row].value;
		var statusvalue = document.myform.IStatus[row].value;
		
		
		var transfer = document.myform.Itransfer_qty[row].value;
		if (accept > source) {

			document.myform.Iaccept_qty[row].focus();
			alert("Please enter value of Accept Quantity less than  or equal to Source Quantity.");
			return false;
		} else if (accept == "0") {
			alert("Please enter value greater than zero.");
			return false;

		} else if (statusvalue == "CHNGQTY-RCVD LESS") {
			if (accept > transfer) {
				alert("You have received less qty please enter less value of accept qty.");
				return false;
			}
		}else if (statusvalue == "CHNGQTY-RCVD MORE") {
			if (accept < transfer) {
				alert("You have received more qty please enter greater value of accept qty.");
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

	//var accept = document.myform.Iaccept_qty.value;
	var objTable = eval('document.getElementById("displayItemTable")');
	var objrows = objTable.getElementsByTagName("TBODY")[0].rows;
	var objrowsLength = objTable.getElementsByTagName("TBODY")[0].rows.length;
	var itemStatus;
	var siteId= document.myform.siteId.value;
	var desId=document.myform.desId.value;
	
	//document.getElementById("searchTrnsNumberListDiv").innerHTML="";
	//document.myform.action = "ReceiveInventory.jsp";
	document.myform.action = "EditTransferInventory.jsp?sourceName="+$("#siteId1 option:selected").text();
	document.myform.action += "&destName="+$("#desId1 option:selected").text();
	document.myform.action += "&siteId="+siteId;
	document.myform.action += "&desId="+desId;
	
	
	document.myform.submit();
}
function funCancelOrder() {
	//alert('home..')
	document.myform.action = "HomeForm.jsp";
	document.myform.submit();
}

function changeQty(event,obj,rowID,sourecQty){
	// alert(document.getElementById('Isource_qty1')[rowID])
	keyPress = event.keyCode;
	
	//alert(document.getElementById('Itransfer_qty1') +" sourecQty "+sourecQty+" "+obj.value + " "+(obj.value>sourecQty) + " "+(parseInt(obj.value)>parseInt(sourecQty)));
	//alert(document.myform.Itransfer_qty1[rowID].value +" "+obj.value);
	//if(keyPress==37 || keyPress == 38 || keyPress==39 || keyPress==40){
		if(parseInt(obj.value)>parseInt(sourecQty)){
			alert('transefer qty can not be greater than source qty ');
			document.myform.Itransfer_qty1[rowID].value=document.myform.Itransfer_qty2[rowID].value;
			return;
			
		}
		else if(globalTransferQty==null)
			{
			//document.getElementById('Itransfer_qty1')[rowID].value = document.getElementById('Itransfer_qty1')[rowID].value;	
			document.myform.Itransfer_qty1[rowID].value = document.myform.Itransfer_qty2[rowID].value; 
		}else{
			document.myform.Itransfer_qty1[rowID].value.value = globalTransferQty;
			
		}	
		return false;
	//}
	

	calculateGrandTotalQty(obj);
}

function keyDown(obj){
	globalTransferQty =obj.value;

}

function calculateGrandTotalQty(currentObject){
	//alert("changed "+currentObject.value+"\n $('#grandTotalQtyHidden').val() "+$('#grandTotalQtyHidden').val());
	//	alert("abs "+Math.abs(parseInt($('#grandTotalQtyHidden').val())-parseInt(currentObject.value)))
		//	document.myform.grandTotalQty.value=  parseInt($('#grandTotalQtyHidden').val()) + Math.abs(parseInt($('#grandTotalQtyHidden').val())-parseInt(currentObject.value));
			if(+globalTransferQty > +currentObject.value){
				globalTransferQty = globalTransferQty - currentObject.value;
				document.myform.grandTotalQty.value = parseInt($('#grandTotalQtyHidden').val())- globalTransferQty;	
			}
			if(+globalTransferQty < +currentObject.value){
				globalTransferQty = currentObject.value - globalTransferQty;
				document.myform.grandTotalQty.value = parseInt($('#grandTotalQtyHidden').val())+ globalTransferQty;
			}
			globalTransferQty = 0;	
			//document.myform.grandTotalQty.value=  parseInt($('#grandTotalQtyHidden').val()) + globalTransferQty-parseInt(currentObject.value);	
	
	if(isNaN(document.myform.grandTotalQty.value))
		document.myform.grandTotalQty.value= $('#grandTotalQtyHidden').val();
	
}

// code for new item in Edit Transfer Invetntory form

function funHandleSearchString(source){
	if(source == "barcode"){
		document.myform.itemName.value ="";
	}else if(source == "itemName"){
		document.myform.searchBarCode.value ="";
	}
}

function funSearchItemAdd(){
	var searchItemName = document.myform.itemName.value;
	var searchBarCode = document.myform.searchBarCode.value;	
	var siteId = document.myform.siteId.value;
	var desId=document.myform.desId.value;
	
	document.myform.ajaxCallOption.value = "searchString";
	
	if(siteId == ""){
		alert("Please select site name");
		return false;
	}
	if(desId == ""){
		alert("Please select destination name");
		return false;
	}
	var searchTrnsNumber = document.myform.transId.value;
	if (searchTrnsNumber == "") {
		alert("Please enter transfer number.");
		document.myform.transId.focus;
		return false;
	}
	
	if(searchItemName == "" && searchBarCode == ""){
		alert("Please enter barcode or item name");
		return false;
	}
	
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="EditTransferInventoryAjaxResponse.jsp"
  			+"?ajaxCallOption=searchStringEdit"
  			+"&searchItemName="+searchItemName
  			+"&searchBarCode="+searchBarCode
  			+"&siteId="+siteId
  			+"&desId="+desId;
  		
	url=url+"&sid="+Math.random();
	//alert(url);
	xmlHttp.onreadystatechange=stateChangedSearchString;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}


function stateChangedSearchString(){
	if(xmlHttp.readyState==4){
		document.getElementById("searchItemListDiv").innerHTML = xmlHttp.responseText;
		var inner = document.getElementById('inner');
  		var secondWrapper = document.getElementById('secondWrapper');
  		secondWrapper.innerHTML = inner.innerHTML; 
		xmlHttp = null;
	}
}

// prevent from duplication
function funShowPopup(barcode,item_code,item_weight,item_name,item_qty,price_version,site_qty,des_qty,box_qty){
	
	// validating item with local Array
	for(var i =0; i<globalItemCodeArray.length && i < globalPriceVersionArray .length ; i++){
		if(item_code==globalItemCodeArray[i] && price_version == globalPriceVersionArray[i]){
			alert("item already added ..");
			return;
		}
			
	}
		// validating item with DB record
		var data = "ajaxCallOption=preventDuplicate&item_code="+item_code+"&price_version="+price_version+"&transferId="+$('#transId1 option:selected').val();
		$.ajax({
			url:"EditTransferInventoryAjaxResponse.jsp",
			type:'post',
			data:data,
			dataType:'text',
			success:function(result){
				if(result.search('true')!=-1)
					alert('item already added ..');
				else
					funShowPopupAjax(barcode,item_code,item_weight,item_name,item_qty,price_version,site_qty,des_qty,box_qty);
			
			} //end of success
		  	
	  	});//end of ajax
  	
}

// popUp for item Add
function funShowPopupAjax(barcode,item_code,item_weight,item_name,item_qty,price_version,site_qty,des_qty,box_qty){
	var siteId = document.myform.siteId.value;
	var desId=document.myform.desId.value;
	var source_site_name=document.myform.siteId.options[document.myform.siteId.selectedIndex].text;
	var des_site_name=document.myform.desId.options[document.myform.desId.selectedIndex].text;
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="EditTransferInventoryAjaxResponse.jsp"
  			+"?ajaxCallOption=popupTableEdit"
  			+"&barcode="+barcode
  			+"&item_code="+item_code
  			+"&item_weight="+item_weight
  			+"&item_name="+item_name
  			+"&item_qty="+item_qty
  			+"&site_qty="+site_qty
  			+"&des_qty="+des_qty
  			+"&priceversion="+price_version
  			+"&siteId="+siteId
  			+"&desId="+desId
  			+"&source_site_name="+source_site_name
  			+"&des_site_name="+des_site_name
  			+"&box_qty="+box_qty;
  	url=url+"&sid="+Math.random();
	
	xmlHttp.onreadystatechange=stateChangedfunShowPopup;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}


function stateChangedfunShowPopup(){
	if(xmlHttp.readyState==4){
		document.getElementById('popupItemDiv').innerHTML = xmlHttp.responseText;
		displayPopup();
	}
}

function displayPopup(){
	document.getElementById('popupItemDiv').style.display = "block";
	Popup.showModal('popupItemDiv');
	document.myform.popupSelMrp.focus();
}

function setQtyValues(){
	var box_qty = parseInt(document.myform.box_qty.value);
	if(document.myform.popupTransferQty_loose.value == ""){
		var trans_loose = 0;
	}else{
		var trans_loose = parseInt(document.myform.popupTransferQty_loose.value);
		//alert(trans_loose);
	}
	if(document.myform.popupTransferQty_box.value == ""){
		var trans_box = 0;
	}else{
		var trans_box = parseInt(document.myform.popupTransferQty_box.value);
	}
	var trans_qty=trans_box*box_qty+trans_loose;
	var src_qty = parseInt(document.myform.popupSourceQty.value);
	var src_qty_box = parseInt(document.myform.popupSourceQty_box.value);
	if(trans_loose >= box_qty){
		remainingQty();
		alert("Loose Quantity can not be greter than or equals to no of items in single box");
		return false;
	} else if(trans_box > src_qty_box){
		remainingQty();
		if(box_qty > 1)
			alert("Transfer Box Quantity can not be greter than Source Box Quantity");
		else
			alert("Transfer Quantity can not be greter than Source Quantity");
		return false;
	} else if(((trans_box*box_qty)+trans_loose) > src_qty){
		remainingQty();
		alert("Transfer Quantity can not be greter than Source Quantity");
		return false;
	} else{
		document.myform.popupTransferQty.value=trans_qty;
		remainingQty();
	}
}

function remainingQty(){
	var trans_qty = parseInt(document.myform.popupTransferQty.value);
	var des_qty = parseInt(document.myform.popupDesQty.value);
	var src_qty = parseInt(document.myform.popupSourceQty.value);
	var box_qty = parseInt(document.myform.box_qty.value);
	
	var aftr_trans_qty =  des_qty + trans_qty;
	var rem_qty =  src_qty - trans_qty;
	
	document.myform.popupRemainingQty.value=rem_qty;
	document.myform.popupRemainingQty_box.value=((rem_qty-(rem_qty%box_qty))/box_qty)+"  ("+box_qty+")";
	document.myform.popupRemainingQty_loose.value=rem_qty%box_qty;
	
	
	
	document.myform.popupAfttrnsQty.value=aftr_trans_qty;
	document.myform.popupAfttrnsQty_box.value=((aftr_trans_qty-(aftr_trans_qty%box_qty))/box_qty)+"  ("+box_qty+")";
	document.myform.popupAfttrnsQty_loose.value=aftr_trans_qty%box_qty;
	
	//alert(document.myform.popupRemainingQty_box.value +"  loose value "+document.myform.popupRemainingQty_loose.value+"\n  "+document.myform.popupRemainingQty.value)
	
	document.myform.popupTransferQty.value=trans_qty;
	
	var temp = (trans_qty-(trans_qty%box_qty))/box_qty;
	if(temp == 0)
		document.myform.popupTransferQty_box.value="";
	else
		document.myform.popupTransferQty_box.value=temp;
		
	temp = trans_qty%box_qty;
	if(temp == 0)
		document.myform.popupTransferQty_loose.value="";
	else
		document.myform.popupTransferQty_loose.value = temp;
		
	document.myform.popupTransferQty1.value=trans_qty;
	document.myform.popupTransferQty_box1.value=((trans_qty-(trans_qty%box_qty))/box_qty)+"  ("+box_qty+")";
	document.myform.popupTransferQty_loose1.value=trans_qty%box_qty;
}
//temp=box_qty
function funAddRow(temp,item_code1,price_version1){
	//alert('add row'+temp+" "+item_code1+" "+price_version1);
	
	globalItemCodeArray.push(item_code1);
	globalPriceVersionArray.push(price_version1);
	
//	document.getElementById('secondWrapper1').innerHTML = "";
	var box_qty = parseInt(temp);
	var objTable=document.getElementById("displayItemTable");
	var rowCount = objTable.rows.length;
	var barcode,itemCode ,name, weight, mrp, rate,sourceQty,transferQty,remainingQty,destQty,aftrtransQty;
	barcode = document.myform.popupBarcode.value;
	itemCode = document.myform.popupItemCode.value;
	name = document.myform.popupItemName.value;
	wieght = document.myform.popupItemWeight.value;	
	sourceQty = parseInt(document.myform.popupSourceQty.value);
	transferQty=  parseInt(document.myform.popupTransferQty_box.value);
	//transferQty= document.myform.popupTransferQty_box.value);
	
	remainingQty=document.myform.popupRemainingQty.value;
	destQty=document.myform.popupDesQty.value;
	aftrtransQty= parseInt(document.myform.popupAfttrnsQty.value);
	
	popupLooseQuantity = document.myform.popupTransferQty_loose.value;
	if(isNaN(transferQty)){
		document.myform.popupTransferQty_box.value = 0;
	}
	if(isNaN(popupLooseQuantity) || popupLooseQuantity == "" || popupLooseQuantity == null){
		 document.myform.popupTransferQty_loose.value = 0;
	}
	
	if((popupLooseQuantity == "" || popupLooseQuantity == null ) && (transferQty == "" || isNaN(transferQty))){
		alert("Please enter value of Transfer quantity or loose quantity ");
		return false;
	}	  
		  
	if(transferQty > sourceQty){
		alert("Please enter value of Transfer quantity.");
		return false;
	}
 
  addNewRow(item_code1,sourceQty,destQty,transferQty,price_version1);
	
	funCloseDiv();
	document.myform.itemName.value="";
	document.myform.itemName.focus();
}
function funCloseDiv(){
	Popup.hide('popupItemDiv');
}

function al(){
	var row;
	var sendingObj = event.srcElement;
	if(sendingObj.type == undefined){
		var rowObj = sendingObj.parentNode;
		row = rowObj.rowIndex-1;
	}else if(sendingObj.type == "text")
	{
		var rowObj = sendingObj.parentNode.parentNode;
		row = rowObj.rowIndex-1;		
	}
	var barcode,itemCode , name, weight, mrp, rate,sourceQty,newQty,totalQty,totalMrp,priceVersion;
	var objTable=document.getElementById("selectedItemsTable");
	var rowCount = objTable.rows.length;
	if(rowCount == 2){	
		barcode = document.myform.saveBarcode.value;
		itemCode = document.myform.saveItemCode.value;
		name = document.myform.saveItemName.value;
		wieght = document.myform.saveItemWeight.value;	
		sourceQty = document.myform.savesourceQty.value;
	}else{
		barcode = document.myform.saveBarcode[row].value;
		itemCode = document.myform.saveItemCode[row].value;
		name = document.myform.saveItemName[row].value;
		wieght = document.myform.saveItemWeight[row].value;	
		sourceQty = document.myform.savesourceQty[row].value;
	}
	funShowPopup(barcode,itemCode,wieght,name,sourceQty);
}

//ading new row at last   
function addNewRow(item_code,sourceQty,destQty,transferQty,priceVersion){
	//alert('add new row');
	url="ajaxCallOption=addNewRow&item_code="+item_code+"&sourceQty="+sourceQty+"&destQty="+destQty+"&transferQty="+transferQty+"&priceVersion="+priceVersion;
	$.ajax({
		url:"EditTransferInventoryAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'text',
		success:function(result){
		   $('#displayItemTable tr:last').after(result);
		   
	  	} //end of success
  });//end of ajax
}

//clear search Div
function funClearBarcodeItemName(){
	document.myform.itemName.value ="";
	document.myform.searchBarCode.value = "";
	document.getElementById("searchItemListDiv").innerHTML="";
}
