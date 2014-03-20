var xmlHttp;
// global variable for prevent insert exception

var globalItemCodeArray = new Array();
var globalTransferIdArray = new Array();
var globalPriceVersionArray = new Array();

function GetXmlHttpObject()
{
	var xmlHttp=null;
	try
  	{
  		// Firefox, Opera 8.0+, Safari
  		xmlHttp=new XMLHttpRequest();
  	}
	catch (e)
  	{
  	// Internet Explorer
  		try
    	{
    		xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    	}
  		catch (e)
    	{
    	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    	}
  	}
	return xmlHttp;
}


function getData(src){
	//alert($("#desId option:selected").text());

	document.myform.ajaxCallOption.value=src;
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="TransferInventoryAjaxResponse.jsp";
  	if(src == "getSite"){
  		url=url+"?ajaxCallOption=getSite";
  	}else if(src == "getSiteAddress"){
  		if(document.myform.siteId.value !=0){
  			url=url+"?ajaxCallOption=getSiteAddress&siteId="+document.myform.siteId.value;
  		} else {
  			document.getElementById("sourceAddress").innerHTML = "";
  			return;
  		}
  	}if(src == "getDes"){
  		url=url+"?ajaxCallOption=getDes";
  	}else if(src == "getDesAddress"){
  	
  		if(document.myform.desId.value !=0){
  			url=url+"?ajaxCallOption=getDesAddress&desId="+document.myform.desId.value;
  		} else {
  			document.getElementById("destinationAddress").innerHTML = "";
  			return;
  		}
  	}
  	
  	
  	
	url=url+"&sid="+Math.random();
	xmlHttp.onreadystatechange=stateChangedGetSite;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function stateChangedGetSite(){
	if(xmlHttp.readyState==4){
		var src = document.myform.ajaxCallOption.value;
		//alert(src);
		if(src == "getSite"){
			document.getElementById("sourceSiteDiv").innerHTML = xmlHttp.responseText;
			getData("getDes");
	  	}else if(src == "getSiteAddress"){
	  		document.getElementById("sourceAddress").innerHTML = xmlHttp.responseText;
	  		//alert(document.myform.siteId.text)
	  		//alert($("#siteId1 option:selected").text());
	  		$("#sourceSiteName1").attr("value",$("#siteId1 option:selected").text());
	  		
	  	}else if(src == "getDes"){
			document.getElementById("desSiteDiv").innerHTML = xmlHttp.responseText;
			document.myform.siteId.focus();
	  	}else if(src == "getDesAddress"){
	  		document.getElementById("destinationAddress").innerHTML = xmlHttp.responseText;
	  		//alert(document.myform.desId.text)
	  		//alert($("#desId1 option:selected").text());
	  		$("#destSiteName1").attr("value",$("#desId1 option:selected").text());
	  	}
		
	}
}

function funHandleSearchString(source){
	if(source == "barcode"){
		document.myform.itemName.value ="";
	}else if(source == "itemName"){
		document.myform.searchBarCode.value ="";
	}
}


function funSearchItem(){
	var searchItemName = document.myform.itemName.value;
	var searchBarCode = document.myform.searchBarCode.value;	
	var siteId = document.myform.siteId.value;
	var desId=document.myform.desId.value;
	
	if(siteId == desId){
		alert("Please select different destination address");
		document.myform.desId.focus();
		return false;
	}
	document.myform.ajaxCallOption.value = "searchString";
	if(searchItemName == "" && searchBarCode == ""){
		alert("Please enter barcode or item name");
		return false;
	}
	if(siteId == ""){
		alert("Please select site name");
		return false;
	}
	if(desId == ""){
		alert("Please select destination name");
		return false;
	}
	
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="TransferInventoryAjaxResponse.jsp"
  			+"?ajaxCallOption=searchString"
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

function funClearBarcodeItemName(){
	document.myform.itemName.value ="";
	document.myform.searchBarCode.value = "";
	document.getElementById("searchItemListDiv").innerHTML="";
}
function Clear(){
	document.myform.grandTotalItems.value="";
	document.myform.grandTotalQty.value="";
	document.myform.siteId.value="";
	document.myform.desId.value="";
	document.getElementById("selectedItemsDiv").innerHTML="";
	document.getElementById("sourceAddress").innerHTML="";
	document.getElementById("destinationAddress").innerHTML="";
	funClearBarcodeItemName();
}


//var trObj;
function funShowPopup(barcode,item_code,item_weight,item_name,item_qty,price_version,site_qty,des_qty,box_qty){
	//alert(barcode);
	
	// prevent from duplication
	//alert(globalItemCodeArray.length+"  "+globalPriceVersionArray .length+" \n item_code "+item_code +" \n price_version "+price_version)
	
	for(var i =0; i<globalItemCodeArray.length && i < globalPriceVersionArray .length ; i++){
		if(item_code==globalItemCodeArray[i] && price_version == globalPriceVersionArray[i]){
			alert("item already added ..");
			return;
		}
			
	}
	//globalItemCodeArray.push(item_code);
	//globalPriceVersionArray.push(price_version);
	
	
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
  	var url="TransferInventoryAjaxResponse.jsp"
  			+"?ajaxCallOption=popupTable"
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
function funCloseDiv(){
	Popup.hide('popupItemDiv');
}

 function funValues(item_code){
	var priceversion=document.myform.popupSelMrp.value;
	var siteId = document.myform.siteId.value;
	var desId=document.myform.desId.value;
	  xmlHttp=GetXmlHttpObject()
		if (xmlHttp==null)
	  	{
	  		alert ("Your browser does not support AJAX!");
	  		return;
	  	} 
	  	var url="TransferInventoryAjaxResponse.jsp"
	  			+"?ajaxCallOption=getValues"
	  			+"&item_code="+item_code
	  			+"&priceversion="+priceversion
	  			+"&siteId="+siteId
	  			+"&desId="+desId;
	  
	  	url=url+"&sid="+Math.random();
		xmlHttp.open("GET",url,true);
		xmlHttp.onreadystatechange=stateChangedfunPopup;
		xmlHttp.send(null);
	}
 function stateChangedfunPopup(){
	if(xmlHttp.readyState==4){
		var response=xmlHttp.responseText;
		var val=response.split("@@");
		var box_qty=parseInt(document.myform.box_qty.value);
		document.myform.popupSourceQty.value=val[0];
		document.myform.popupDesQty.value=val[1];
		var src_qty=parseInt(document.myform.popupSourceQty.value);
		var des_qty=parseInt(document.myform.popupDesQty.value);
		document.myform.popupDesQty_box.value=((des_qty-(des_qty%box_qty))/box_qty)+"  ("+box_qty+")";
		document.myform.popupDesQty_loose.value=des_qty%box_qty;
		document.myform.popupSourceQty_box.value=((src_qty-(src_qty%box_qty))/box_qty)+"  ("+box_qty+")";
		document.myform.popupSourceQty_loose.value=src_qty%box_qty;
		document.myform.popupTransferQty_box.value="";
		document.myform.popupTransferQty_loose.value="";
		document.myform.popupTransferQty.value="0";
		document.myform.popupTransferQty_box1.value="0  (20)";
		document.myform.popupTransferQty_loose1.value="0";
		document.myform.popupTransferQty1.value="0";
		// popupAfttrnsQty  popupRemainingQty popupTransferQty1 popupTransferQty
		remainingQty();
	}
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

//function funAddRow(temp){
function funAddRow(temp,item_code1,price_version1){
	//pushing data into array to preven duplication
	//alert(item_code1+"  "+price_version1);
	globalItemCodeArray.push(item_code1);
	globalPriceVersionArray.push(price_version1);
	
	document.getElementById('secondWrapper1').innerHTML = "";
	var box_qty = parseInt(temp);
	var objTable=document.getElementById("selectedItemsTable");
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
	//alert("if ..");
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
	
	transferQty= parseInt(document.myform.popupTransferQty_box.value);
	priceVersion = document.myform.popupSelMrp.value;
	if(document.myform.popupSelMrp.options[document.myform.popupSelMrp.selectedIndex].text == "New")
	{
		mrp = document.myform.popupMrp.value;
		rate = document.myform.popupRate.value;
		if(mrp == "0"){
			alert("Please enter mrp value!");
			return false;
		}
		if(mrp == ""){
			alert("Please enter mrp value!");
			return false;
		}
		if(rate == "0"){
			alert("Please enter rate value!");
			return false;
		}if(rate == ""){
			alert("Please enter rate value!");
			return false;
		}
	}else{
		mrp = document.myform.popupSelMrp.options[document.myform.popupSelMrp.selectedIndex].text;
		rate = document.myform.popupSelRate.options[document.myform.popupSelRate.selectedIndex].text;
	}	
	
	var lastRow = objTable.rows.length;
	var newRow = document.getElementById("selectedItemsTable").insertRow(lastRow);
	//newRow.onclick = al();
	newRow.style.backgroundColor= '#EFFBEF';
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveBarcode' size='7' class='hideTextField' readonly='readonly' value='"+barcode+"'/>";
	oCell.style.display='none';
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveItemCode' size='7' class='hideTextField' readonly='readonly' value='"+itemCode+"'/>";
	oCell.style.display='none';
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveItemName' size='15' class='hideTextField' readonly='readonly' value='"+name+"' title='"+name+"' />";
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveItemWeight' size='7' class='hideTextField' readonly='readonly' value='"+wieght+"'/>";
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveMrp' size='7' class='hideTextField' readonly='readonly' value='"+mrp+"'/>";
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveRate' size='7' class='hideTextField' readonly='readonly'  value='"+rate+"'/>";
	oCell.style.display='none';
	if(box_qty > 1){
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='savesourceQty_box' size='2' class='hideTextField' readonly='readonly' value='"+((sourceQty-(sourceQty%box_qty))/box_qty)+"'/>  ("+box_qty+")";
	
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='savesourceQty_loose' size='7' class='hideTextField' readonly='readonly' value='"+(sourceQty%box_qty)+"'/>";
	
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='savesourceQty' size='7' class='hideTextField' readonly='readonly' value='"+sourceQty+"'/>";
	
	 	
	 	oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='savetransferQty_box' size='2' class='hideTextField' readonly='readonly' value='"+parseInt(document.myform.popupTransferQty_box.value)+"'/>  ("+box_qty+")";
	
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='savetransferQty_loose' size='7' class='hideTextField' readonly='readonly' value='"+parseInt(document.myform.popupTransferQty_loose.value)+"'/>";
	
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='savetransferQty' size='7' class='hideTextField' readonly='readonly' value='"+parseInt(document.myform.popupTransferQty.value)+"'/>";
	 	
	}else if(box_qty ==1){
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='savesourceQty_box' size='2' class='hideTextField' readonly='readonly' value='"+((sourceQty-(sourceQty%box_qty))/box_qty)+"'/>";
		oCell.colSpan="3";

		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='savesourceQty_loose' size='7' class='hideTextField' readonly='readonly' value='"+(sourceQty%box_qty)+"'/>";
		oCell.style.display='none';
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='savesourceQty' size='7' class='hideTextField' readonly='readonly' value='"+sourceQty+"'/>";
		oCell.style.display='none';
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='savetransferQty_box' size='2' class='hideTextField' readonly='readonly' value='"+((transferQty-(transferQty%box_qty))/box_qty)+"'/>";
		oCell.colSpan="3";
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='savetransferQty_loose' size='7' class='hideTextField' readonly='readonly' value='"+(transferQty%box_qty)+"'/>";
		oCell.style.display='none';
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='savetransferQty' size='7' class='hideTextField' readonly='readonly' value='"+transferQty+"'/>";
		oCell.style.display='none';
		
	}
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveremainingQty' size='7' class='hideTextField' readonly='readonly' value='"+remainingQty+"'/>";
	oCell.style.display='none';
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='savedestQty' size='7' class='hideTextField' readonly='readonly' value='"+destQty+"'/>";
	oCell.style.display='none';
	if(box_qty > 1){
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveaftrtransQty_box' size='2' class='hideTextField' readonly='readonly' value='"+((aftrtransQty-(aftrtransQty%box_qty))/box_qty)+"'/>  ("+box_qty+")";
	
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveaftrtransQty_loose' size='7' class='hideTextField' readonly='readonly' value='"+parseInt(aftrtransQty%box_qty)+"'/>";
	
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveaftrtransQty' size='7' class='hideTextField' readonly='readonly' value='"+aftrtransQty+"'/>";
	}else if(box_qty ==1){
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveaftrtransQty_box' size='2' class='hideTextField' readonly='readonly' value='"+((aftrtransQty-(aftrtransQty%box_qty))/box_qty)+"'/>";
		oCell.colSpan="3";
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveaftrtransQty_loose' size='7' class='hideTextField' readonly='readonly' value='"+(aftrtransQty%box_qty)+"'/>";
		oCell.style.display='none';
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveaftrtransQty' size='7' class='hideTextField' readonly='readonly' value='"+aftrtransQty+"'/>";
		oCell.style.display='none';
		
		
	}
	oCell = newRow.insertCell();
	oCell.innerHTML = "<img src='images/icon_trash.gif' onclick=\"deleteRow(this,'"+itemCode+"','"+priceVersion+"',"+parseInt(parseInt(document.myform.popupTransferQty.value))+")\" alt='delete row'>";
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='hidden' name='savePriceVersion' size='7'  value='"+priceVersion+"'/>";
	oCell.style.display='none';
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='hidden' name='box_qty_save' size='4'  value='"+box_qty+"'/>";
	oCell.style.display='none';
	
	//source and dest Id for updating site inventory after delivery
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='hidden' name='sourceID' size='7'  value='"+$("#siteId1 option:selected").val()+"'/>";
	oCell.style.display='none';
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='hidden' name='destID' size='4'  value='"+$("#desId1 option:selected").val()+"'/>";
	oCell.style.display='none';
	document.myform.grandTotalQty.value =  parseInt(document.myform.grandTotalQty.value) + parseInt(document.myform.popupTransferQty.value);
	
	document.myform.grandTotalItems.value = lastRow-1;
	var inner = document.getElementById('inner1');
  	var secondWrapper = document.getElementById('secondWrapper1');
  	secondWrapper.innerHTML = inner.innerHTML;
	funCloseDiv();
	document.myform.itemName.value="";
	document.myform.itemName.focus();
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
		alert(row+" aaa  "+rowObj);
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
	//funShowPopup(barcode,itemCode,wieght,name,sourceQty);
}

//function deleteRow(t){
function deleteRow(t,item_code1,price_version1,transferQty1){
	
// 	alert(globalItemCodeArray.length+"  "+globalPriceVersionArray.length);
	//alert("delete row "+transferQty1)
	
	document.myform.grandTotalQty.value = parseInt(document.myform.grandTotalQty.value) - parseInt(transferQty1);
 	for(var i = 0; i<globalItemCodeArray.length && i< globalPriceVersionArray.length ; i++){
 		
		if(item_code1==globalItemCodeArray[i] && price_version1 == globalPriceVersionArray[i]){
			//alert("if...");
			globalItemCodeArray.splice(i,1);
			globalPriceVersionArray.splice(i,1);
			
		}
	} 

	//alert("delete ");
	
	var tr=t.parentNode.parentNode	
	var rowCount = tr.parentNode.rows.length;	
	var objTableId =tr.parentNode.parentNode.getAttribute("id");
	var objTable=document.getElementById(tr.parentNode.parentNode.getAttribute("id"));
	var rowCount = objTable.rows.length;
	var row = tr.rowIndex-2 ;
	var transferQty;
	
	if(rowCount == 3){
		transferQty = document.myform.savetransferQty.value;
		
	}else{
		transferQty = document.myform.savetransferQty[row].value;
	 }
	for ( var i = tr.rowIndex; i <= rowCount; i++) {		
		if(i== tr.rowIndex){
			tr.parentNode.removeChild(tr);			
		}			
	}		
	
	var rowCount = objTable.rows.length-1;
	var grandTotalQty = document.myform.grandTotalQty.value;
	grandTotalQty = parseInt(grandTotalQty) - parseInt(transferQty);
	document.myform.grandTotalItems.value=rowCount;
	//document.myform.grandTotalQty.value = parseInt(grandTotalQty) ;
}
function funSaveOrder(){
	var siteId= document.myform.siteId.value;
	var desId=document.myform.desId.value;
	if(siteId == ""){
		alert("Please select Destination Name.");
		return false;
	}
	var grandTotalItems = document.myform.grandTotalItems.value;
	if(grandTotalItems == 0){
		alert("Please select items.");
		return false;
	}
	document.getElementById("searchItemListDiv").innerHTML ="";
	document.getElementById('secondWrapper1').innerHTML = "";
	document.myform.action = "TransferInventory.jsp";
	//document.myform.action.method='get';
	document.myform.submit();
	
}
function funCancelOrder(){
	document.myform.action = "HomeForm.jsp";
	document.myform.submit();
}

