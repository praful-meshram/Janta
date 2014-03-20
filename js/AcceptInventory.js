var xmlHttp;
var posx;
var posy;

//lobal arrya for avoid duplication
var globalItemCodeArray = new Array();
var globalTransferIdArray = new Array();
var globalPriceVersionArray = new Array();
 
function capmouse(e){ 
// captures the mouse position 
	posx = 0; posy = 0; 
	if (!e){
		var e = window.event;
	} 
	if (e.pageX || e.pageY){ 
		posx = e.pageX; 
		posy = e.pageY; 
	} 
	else if (e.clientX || e.clientY){ 
		posx = e.clientX; 
		posy = e.clientY; 
	} 
}

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
	document.myform.ajaxCallOption.value=src;
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="AcceptInventoryAjaxResponse.jsp";
  	if(src == "getVendor"){
  		url=url+"?ajaxCallOption=getVendor";
  	}else if(src == "getVendorAddress"){
  		if(document.myform.vendorId.value != ""){
  			url=url+"?ajaxCallOption=getVendorAddress&vendorId="+document.myform.vendorId.value;
  		} else {
  			document.getElementById("vendorAddress").innerHTML = "";
  			return;
  		}
  	}else if(src == "getSite"){
  		url=url+"?ajaxCallOption=getSite";
  	}else if(src == "getSiteAddress"){
  		if(document.myform.siteId.value != ""){
  			url=url+"?ajaxCallOption=getSiteAddress&siteId="+document.myform.siteId.value;
  		} else {
  			document.getElementById("siteAddress").innerHTML = "";
  			return;
  		}
  	}
  	url=url+"&sid="+Math.random();
	xmlHttp.onreadystatechange=stateChangedGetVendor;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function stateChangedGetVendor(){
	if(xmlHttp.readyState==4){
		var src = document.myform.ajaxCallOption.value;
		if(src == "getVendor"){
			document.getElementById("vendorNameDiv").innerHTML = xmlHttp.responseText;
			getData("getSite");
	  	}else if(src == "getVendorAddress"){
	  		document.getElementById("vendorAddress").innerHTML = xmlHttp.responseText;
	  	}else if(src == "getSite"){
			document.getElementById("siteNameDiv").innerHTML = xmlHttp.responseText;
			document.myform.vendorId.focus();
	  	}else if(src == "getSiteAddress"){
	  		document.getElementById("siteAddress").innerHTML = xmlHttp.responseText;
	  	}
	}
}

function funDisplayDiv(){
	if(document.myform.chckBillNumber.checked == true){
		document.getElementById("displayBillDiv").style.visibility = "visible";
	}else{
		document.getElementById("displayBillDiv").style.visibility = "hidden";
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
	document.myform.ajaxCallOption.value = "searchString";
	if(searchItemName == "" && searchBarCode == ""){
		alert("Please enter barcode or item name");
		document.myform.itemName.focus();
		return false;
	}
	if(siteId == ""){
		alert("Please select site name");
		document.myform.itemName.focus();
		return false;
	}
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="AcceptInventoryAjaxResponse.jsp"
  			+"?ajaxCallOption=searchString"
  			+"&searchItemName="+searchItemName
  			+"&siteId="+siteId; 		
	url=url+"&sid="+Math.random();
	document.getElementById("searchItemListDiv").innerHTML = "<img src = 'images/Background/ajax-loader (3).gif' alt='loading'/><br/><br/>loading...";
	
	xmlHttp.onreadystatechange=stateChangedSearchString;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function stateChangedSearchString(){
	if(xmlHttp.readyState==4){
		document.getElementById("searchItemListDiv").innerHTML = xmlHttp.responseText;
		var inner = document.getElementById('inner');
		
		// alert("inner "+inner.innerHTML);
		
  		var secondWrapper = document.getElementById('secondWrapper');
  		// alert('secondWrapper '+secondWrapper);
  		secondWrapper.innerHTML = inner.innerHTML;
		xmlHttp = null;
	}
	document.myform.itemName.focus();
}

function funClearBarcodeItemName(){
	document.myform.itemName.value ="";
	document.myform.searchBarCode.value = "";
	document.getElementById("searchItemListDiv").innerHTML="";
	document.myform.itemName.focus();
}

function funShowPopup(barcode,item_code,item_weight,item_name,item_qty,box_qty,price_version){

	for(var i =0; i<globalItemCodeArray.length && i < globalPriceVersionArray .length ; i++){
		if(item_code==globalItemCodeArray[i] && price_version == globalPriceVersionArray[i]){
			alert("item already added ..");
			return;
		}
			
	}

	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var siteId = document.myform.siteId.value;
  	var url="AcceptInventoryAjaxResponse.jsp"
  			+"?ajaxCallOption=popupTable"
  			+"&barcode="+barcode
  			+"&item_code="+item_code
  			+"&item_weight="+item_weight
  			+"&item_name="+item_name
  			+"&item_qty="+item_qty
  			+"&siteId="+siteId
  			+"&box_qty="+box_qty
  			+"&price_version="+price_version;
	url=url+"&sid="+Math.random();
	xmlHttp.onreadystatechange=stateChangedfunShowPopup;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}



 function showMousePopup(item_code,price_version,item_name,item_mrp){
	//alert(item_code+"   "+price_version);
	//$('#showPopUp').
	//alert($('#showPopUpCell'));
	//alert($('#showPopUpCell').offset()+ " "+$('#showPopUpCell').position());
	
	//x=$('#showPopUpCell').position();
//	posx = x.top;
//	posy = x.left; 
	
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	}
  	var siteId = document.myform.siteId.value;
  	var url="AcceptInventoryAjaxResponse.jsp"
  			+"?ajaxCallOption=mouse_over_popup"
  			+"&item_code="+item_code
  			+"&price_version="+price_version
  			+"&item_name="+item_name
  			+"&item_mrp="+item_mrp
	url=url+"&sid="+Math.random();
	xmlHttp.onreadystatechange=stateChangedfunShowMousePopup;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
	
	
} 

function stateChangedfunShowPopup(){
	if(xmlHttp.readyState==4){
		document.getElementById('popupItemDiv').innerHTML = xmlHttp.responseText; 
		displayPopup();
	}
}
function stateChangedfunShowMousePopup(){
	if(xmlHttp.readyState==4){
		showP();
		document.getElementById('inner_div').innerHTML = xmlHttp.responseText;
		document.getElementById('popupMouseOver').style.display='block';
		document.getElementById('popupMouseOver').style.position='absolute';
		document.getElementById('popupMouseOver').style.backgroundColor = "#BEF781";
		document.getElementById('popupMouseOver').style.border="1px solid black";
		
	}
}

function showP(){ 
	document.getElementById('popupMouseOver').style.top=posy-20;
	document.getElementById('popupMouseOver').style.left=posx-190;
	document.getElementById('popupMouseOver').style.width=100;
}
			
function closePopup(){
	document.getElementById('popupMouseOver').style.display='none';
}

function displayPopup(){
	document.getElementById('popupItemDiv').style.display = "block";
	Popup.showModal('popupItemDiv');
	document.myform.popupSelMrp.focus();
}

function funCloseDiv(){
	 Popup.hide('popupItemDiv');
	 document.myform.itemName.focus();
}

function setMrpRateValues(src){
	if(src == "MRP" || src == "RATE"){
		if(src == "MRP"){
			document.myform.popupSelRate.value = document.myform.popupSelMrp.value;	
		}
		else if(src == "RATE"){		
			document.myform.popupSelMrp.value = document.myform.popupSelRate.value;		
		}	
		var item_code = document.myform.popupItemCode.value ;
		var price_version = document.myform.popupSelMrp.value;		
		var siteId = document.myform.siteId.value;	
		var url="AcceptInventoryAjaxResponse.jsp"
  			+"?ajaxCallOption=getValues"  			
  			+"&item_code="+item_code  			
  			+"&price_version="+price_version
  			+"&siteId="+siteId; 		
		url=url+"&sid="+Math.random();
		xmlHttp.onreadystatechange=stateChangedGetValues;
		xmlHttp.open("GET",url,true);
		xmlHttp.send(null);			
	}	
}

function setMrpAndRate(){
	document.myform.popupRate.value =document.myform.popupMrp.value;
}

function stateChangedGetValues(){
	if(xmlHttp.readyState==4){
		var site_qty=parseInt(xmlHttp.responseText.replace(/^\s+|\s+$/g,""));
		var item_box_qty=parseInt(document.myform.popupBoxQty.value);
		if(document.myform.popupSelMrp.options[document.myform.popupSelMrp.selectedIndex].text == "New"){
			document.myform.popupRate.style.display = "block";
			document.myform.popupMrp.style.display = "block";
			var newQty = document.myform.popupNewQty.value;
			document.myform.popupOldQty.value=0;
			document.myform.popupOldQty_box.value=0;
			document.myform.popupTotalQty.value=0;
			document.myform.popupTotalQty_box.value=0;
			if(item_box_qty!=1){
				document.myform.popupTotal_total.value=0;
				document.myform.popupOld_total.value=0;
				document.myform.popupNew_total.value=0;
			}
			document.myform.popupMrp.focus();
		}else{
			document.myform.popupRate.value = "0";
			document.myform.popupMrp.value = "0";
			document.myform.popupRate.style.display = "none";
			document.myform.popupMrp.style.display = "none";			
			var newQty = document.myform.popupNewQty.value;		
			if(newQty != ""){
				setQtyValues();
			}	
			document.myform.popupOldQty.value=site_qty%item_box_qty;
			document.myform.popupOldQty_box.value=(site_qty-(site_qty%item_box_qty))/item_box_qty;
			document.myform.popupTotalQty.value=document.myform.popupOldQty.value;
			document.myform.popupTotalQty_box.value=document.myform.popupOldQty_box.value;
			document.myform.popupNewQty.value="";
			document.myform.popupNewQty_box.value="";
			if(item_box_qty!=1){
				document.myform.popupTotal_total.value=site_qty;
				document.myform.popupOld_total.value=site_qty;
			}	
			document.myform.popupNewQty_box.focus();
		}
	}
}

function setQtyValues(box_qty){
	var item_box_qty = parseInt(box_qty);
	var newQty = document.myform.popupNewQty.value;
	var newQty_box = document.myform.popupNewQty_box.value;
	var oldQty = document.myform.popupOldQty.value;
	var oldQty_box = document.myform.popupOldQty_box.value;
	var totQty = document.myform.popupTotalQty.value;
	var totQty_box = document.myform.popupTotalQty_box.value;
	var box_old_qty=parseInt(oldQty_box);
	var loose_old_qty=parseInt(oldQty);
	var old_Q=(box_old_qty*item_box_qty)+loose_old_qty;
	var box_tot_qty=parseInt(totQty_box);
	var loose_tot_qty=parseInt(totQty);
	var new_Q;
	if(newQty != "" && newQty_box != ""){
		var box_new_qty=parseInt(newQty_box);
		var loose_new_qty=parseInt(newQty);
		if(loose_new_qty >= item_box_qty){
			alert("Loose Quantity can not be greter than or equals to no of items in single box");
			var tot_Q=(box_tot_qty*item_box_qty)+loose_tot_qty;
			var temp=tot_Q-old_Q;
			document.myform.popupNewQty.value=temp%item_box_qty;
		}else{
			document.myform.popupTotalQty.value=oldQty;
			document.myform.popupTotalQty_box.value=oldQty_box;
			new_Q=(box_new_qty*item_box_qty)+loose_new_qty;
			var tot_Q=new_Q+old_Q;
			var temp=tot_Q%item_box_qty;
			document.myform.popupTotalQty.value=temp;
			document.myform.popupTotalQty_box.value=((tot_Q-temp)/item_box_qty);
			document.myform.popupTotal_total.value=tot_Q;
			document.myform.popupNew_total.value=new_Q;
		}	
	}
	if(newQty == "" && newQty_box != ""){
		document.myform.popupTotalQty.value=oldQty;
		document.myform.popupTotalQty_box.value=oldQty_box;
		var box_new_qty=parseInt(newQty_box);
		document.myform.popupTotalQty_box.value=(box_new_qty+box_old_qty);
		document.myform.popupTotal_total.value=(parseInt(document.myform.popupTotalQty_box.value)*item_box_qty)+parseInt(document.myform.popupTotalQty.value);
		new_Q=parseInt(document.myform.popupNewQty_box.value)*item_box_qty;
		document.myform.popupNew_total.value=new_Q;
	}
	if(newQty != "" && newQty_box == ""){
		var box_new_qty=parseInt(newQty_box);
		var box_new_qty=parseInt(newQty_box);
		var loose_new_qty=parseInt(newQty);
		if(loose_new_qty >= item_box_qty){
			alert("Loose Quantity can not be greter than or equals to no of items in single box");
			var tot_Q=(box_tot_qty*item_box_qty)+loose_tot_qty;
			var temp=tot_Q-old_Q;
			document.myform.popupNewQty.value=temp%item_box_qty;
		}else{
			document.myform.popupTotalQty.value=oldQty;
			document.myform.popupTotalQty_box.value=oldQty_box;
			new_Q=loose_new_qty;
			var tot_Q=new_Q+old_Q;
			var temp=tot_Q%item_box_qty;
			document.myform.popupTotalQty.value=temp;
			document.myform.popupTotalQty_box.value=((tot_Q-temp)/item_box_qty);
			document.myform.popupTotal_total.value=tot_Q;
			document.myform.popupNew_total.value=new_Q;
		}	
	}
	if(document.myform.popupSelMrp.options[document.myform.popupSelMrp.selectedIndex].text == "New")
		{
			var txtMrp = document.myform.popupMrp.value;
			totalMrp =  parseFloat(txtMrp) * parseInt(new_Q);
			document.myform.popupTotalMrp.value = totalMrp;
		}
		else
		{
			var selMrp =  document.myform.popupSelMrp.options[document.myform.popupSelMrp.selectedIndex].text;
			totalMrp =  parseFloat(selMrp) * parseInt(new_Q);
			document.myform.popupTotalMrp.value = totalMrp;
		}
}

function funAddRow(item_code1,price_version1){

	//pushing data into array to preven duplication
	globalItemCodeArray.push(item_code1);
	globalPriceVersionArray.push(price_version1);
	

	document.getElementById('secondWrapper1').innerHTML = "";
	var objTable=document.getElementById("selectedItemsTable");
	var rowCount = objTable.rows.length;
	var barcode,itemCode , name, weight, mrp, rate,oldQty,oldQty_box,newQty,newQty_box,totalQty,totalQty_box,totalMrp,priceVersion,newFlag;
	var item_box_qty = parseInt(document.myform.popupBoxQty.value);
	barcode = document.myform.popupBarcode.value;
	itemCode = document.myform.popupItemCode.value;
	name = document.myform.popupItemName.value;
	wieght = document.myform.popupItemWeight.value;	
	oldQty = parseInt(document.myform.popupOldQty.value);
	oldQty_box = parseInt(document.myform.popupOldQty_box.value);
	if(document.myform.popupNewQty.value == "" && document.myform.popupNewQty_box.value == ""){
		alert("Please enter New Quantity!");
		document.myform.popupNewQty_box.focus();
		return false;
	}
	if(document.myform.popupNewQty.value==""){
		document.myform.popupNewQty.value="0";
	}
	if(document.myform.popupNewQty_box.value==""){
		document.myform.popupNewQty_box.value="0";
	}
	newQty = parseInt(document.myform.popupNewQty.value);
	newQty_box = parseInt(document.myform.popupNewQty_box.value);
	totalQty = parseInt(document.myform.popupTotalQty.value);
	totalQty_box = parseInt(document.myform.popupTotalQty_box.value);
	totalMrp = document.myform.popupTotalMrp.value;
	priceVersion = document.myform.popupSelMrp.value;
	if(document.myform.popupSelMrp.options[document.myform.popupSelMrp.selectedIndex].text == "New")
	{
		newFlag="N";
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
		var size=document.myform.popupSelMrp.options.length;
		size=size-1;
		var count=0;
		for(var i=0;i<size;i++){
			if(parseFloat(document.myform.popupSelMrp.options[i].text) == parseFloat(document.myform.popupMrp.value)){
				alert("This MRP already exists");
				document.myform.popupMrp.value="";
				return false;
			}
		}
	}else{
		newFlag="O";
		mrp = document.myform.popupSelMrp.options[document.myform.popupSelMrp.selectedIndex].text;
		
	//	alert(" item  on change "+ document.myform.popupSelRate.options[document.myform.popupSelRate.selectedIndex].text);
		
		rate = document.myform.popupSelRate.options[document.myform.popupSelRate.selectedIndex].text;
	}	
	var lastRow = objTable.rows.length;
	//alert('document.all("selectedItemsTable") '+document.all("selectedItemsTable"));

	var newRow = document.all("selectedItemsTable").insertRow(lastRow);
	//newRow.attachEvent("onclick",al);
	
	// cell function not supported by mozilla
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveBarcode' size='3' class='hideTextField' readonly='readonly' value='"+barcode+"'/>";
	oCell.style.display='none'; 
	
	
	  /* cell = document.createElement("td");
      var cellText = document.createTextNode("<input type='text' name='saveBarcode' size='3' class='hideTextField' readonly='readonly' value='"+barcode+"'/>");
      cell.appendChild(cellText);
      newRow.appendChild(cell);
      cell.style.display='none';  */
	
	//
	
	
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveItemCode' size='10' class='hideTextField' readonly='readonly' value='"+itemCode+"'/>";
	oCell.style.display='none';
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveItemName' size='50' class='hideTextField' readonly='readonly' value='"+name+"'/>";
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveItemWeight' size='10' class='hideTextField' readonly='readonly' value='"+wieght+"'/>";
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveMrp' size='10' class='hideTextField' readonly='readonly' value='"+mrp+"'/>";
	
	//alert(" new item rate "+rate+"\n priceVersion "+priceVersion);
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveRate' size='10' class='hideTextField' readonly='readonly'  value='"+rate+"'/>";
	oCell.style.display='none';
	
	
	if(item_box_qty > 1){
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveOldQty_box' size='10' class='hideTextField' readonly='readonly' value='"+oldQty_box+"'/>("+item_box_qty+")";
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveOldQty' size='10' class='hideTextField' readonly='readonly' value='"+oldQty+"'/>";
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveOldQty-total' size='10' class='hideTextField' readonly='readonly' value='"+(oldQty_box*item_box_qty+oldQty)+"'/>";
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveNewQty_box' size='10' class='hideTextField' readonly='readonly' value='"+newQty_box+"'/>("+item_box_qty+")";
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveNewQty' size='3' class='hideTextField' readonly='readonly' value='"+newQty+"'/>";
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveNewQty_total' size='3' class='hideTextField' readonly='readonly' value='"+(newQty_box*item_box_qty+newQty)+"'/>";
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveTotalQty_box' size='3' class='hideTextField' readonly='readonly' value='"+totalQty_box+"'/>("+item_box_qty+")";
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveTotalQty' size='3' class='hideTextField' readonly='readonly' value='"+totalQty+"'/>";
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='TotalQty-total' size='3' class='hideTextField' readonly='readonly' value='"+(totalQty_box*item_box_qty+totalQty)+"'/>";
		
	}else if(item_box_qty == 1){
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveOldQty_box' size='3' class='hideTextField' readonly='readonly' value='"+oldQty_box+"'/>";
		oCell.colSpan="3";
	
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveOldQty' size='3' class='hideTextField' readonly='readonly' value='"+oldQty+"'/>";
		oCell.style.display='none';
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveOldQty-total' size='3' class='hideTextField' readonly='readonly' value='"+(oldQty_box*item_box_qty+oldQty)+"'/>";
		oCell.style.display='none';
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveNewQty_box' size='3' class='hideTextField' readonly='readonly' value='"+newQty_box+"'/>";
		oCell.colSpan="3";
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveNewQty' size='3' class='hideTextField' readonly='readonly' value='"+newQty+"'/>";
		oCell.style.display='none';
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveNewQty_total' size='3' class='hideTextField' readonly='readonly' value='"+(newQty_box*item_box_qty+newQty)+"'/>";
		oCell.style.display='none';
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveTotalQty_box' size='3' class='hideTextField' readonly='readonly' value='"+totalQty_box+"'/>";
		oCell.colSpan="3";
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='saveTotalQty' size='3' class='hideTextField' readonly='readonly' value='"+totalQty+"'/>";
		oCell.style.display='none';
		
		oCell = newRow.insertCell();
		oCell.innerHTML = "<input type='text' name='TotalQty-total' size='3' class='hideTextField' readonly='readonly' value='"+(totalQty_box*item_box_qty+totalQty)+"'/>";
		oCell.style.display='none';
	}	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveTotalMrp' size='3' class='hideTextField' readonly='readonly' value='"+totalMrp+"'/>";
	oCell.style.display='none';
	oCell = newRow.insertCell();
	//oCell.innerHTML = "<img src='images/icon_trash.gif' onclick='deleteRow(this)' alt='delete row'>";
//	oCell.innerHTML = "<img src='images/icon_trash.gif' onclick=\"deleteRow(this,'itemCode','priceVersion'");\" alt='delete row'>";
	oCell.innerHTML = "<img src='images/icon_trash.gif' onclick=\"deleteRow(this,'"+itemCode+"','"+priceVersion+"')\" alt='delete row'>";
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='hidden' name='savePriceVersion' size='4'  value='"+priceVersion+"'/>";
	oCell.style.display='none';
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='hidden' name='box_qty' size='4'  value='"+item_box_qty+"'/>";
	oCell.style.display='none';
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='hidden' name='new_flag' size='4'  value='"+newFlag+"'/>";
	oCell.style.display='none';
	var grandTotalMrp = document.myform.grandTotalMrp.value;
	grandTotalMrp = parseFloat(grandTotalMrp) + parseFloat(totalMrp);
	document.myform.grandTotalQty.value = --lastRow;
	document.myform.grandTotalMrp.value =grandTotalMrp ;
	var inner = document.getElementById('inner1');
  	var secondWrapper = document.getElementById('secondWrapper1');
  	secondWrapper.innerHTML = inner.innerHTML;
	funCloseDiv();
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
	}
	var barcode,itemCode , name, weight, mrp, rate,oldQty,newQty,totalQty,totalMrp,priceVersion;
	var objTable=document.getElementById("selectedItemsTable");
	var rowCount = objTable.rows.length;
	if(rowCount == 2){	
		barcode = document.myform.saveBarcode.value;
		itemCode = document.myform.saveItemCode.value;
		name = document.myform.saveItemName.value;
		wieght = document.myform.saveItemWeight.value;	
		oldQty = document.myform.saveOldQty.value;
	}else{
		barcode = document.myform.saveBarcode[row].value;
		itemCode = document.myform.saveItemCode[row].value;
		name = document.myform.saveItemName[row].value;
		wieght = document.myform.saveItemWeight[row].value;	
		oldQty = document.myform.saveOldQty[row].value;
	}
	funShowPopup(barcode,itemCode,wieght,name,oldQty)
}

//function deleteRow(t)
function deleteRow(t,itemCode1,priceversion1){
	for(var i = 0; i<globalItemCodeArray.length && i< globalPriceVersionArray.length ; i++){
 		
		if(itemCode1==globalItemCodeArray[i] && priceversion1 == globalPriceVersionArray[i]){
			//alert("if...");
			globalItemCodeArray.splice(i,1);
			globalPriceVersionArray.splice(i,1);
			
		}
	} 
	

	var tr=t.parentNode.parentNode;
	var rowCount = tr.parentNode.rows.length;	
	var objTableId =tr.parentNode.parentNode.getAttribute("id");
	var objTable=document.getElementById(tr.parentNode.parentNode.getAttribute("id"));
	var rowCount = objTable.rows.length;
	var row = tr.rowIndex-1 ;
	var totalQty,totalMrp;
	if(rowCount == 2){
		totalQty = document.myform.saveTotalQty.value;
		totalMrp = document.myform.saveTotalMrp.value;
	}else{
		totalQty = document.myform.saveTotalQty[row].value;
		totalMrp = document.myform.saveTotalMrp[row].value;
	}
	for ( var i = tr.rowIndex; i < rowCount; i++) {		
		if(i== tr.rowIndex){
			tr.parentNode.removeChild(tr);			
		}			
	}		
	var rowCount = objTable.rows.length-2;
	var grandTotalMrp = document.myform.grandTotalMrp.value;	
	grandTotalMrp = parseFloat(grandTotalMrp) - parseFloat(totalMrp);
	document.myform.grandTotalQty.value = rowCount;
	document.myform.grandTotalMrp.value =grandTotalMrp ;
	document.myform.itemName.focus();
}

function funSaveOrder(){
	var vendorId = document.myform.vendorId.value;
	if(vendorId == ""){
		alert("Please select Vendor Name.");
		document.myform.itemName.focus();
		return false;
	}
	var grandTotalQty = document.myform.grandTotalQty.value;
	if(grandTotalQty == 0){
		alert("Please select items.");
		return false;
	}
	document.getElementById("searchItemListDiv").innerHTML ="";
	document.getElementById('secondWrapper1').innerHTML = "";
	document.myform.action = "AcceptInventory.jsp";
	document.myform.submit();
}

function funCancelOrder(){
	document.myform.action = "HomeForm.jsp";
	document.myform.submit();
}

