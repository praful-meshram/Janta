var xmlHttp;
var posx;
var posy;
// for search item
var item_group_code;
var globalBachkaCode = null;

// to prevent from duplication
var globalItemCode = new Array();
var globalPriceVersion = new Array();

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

function getSiteList(){
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="PakegingAjaxResponse.jsp";
  	url=url+"?ajaxCallOption=getSite";
  	url=url+"&sid="+Math.random();
  	xmlHttp.onreadystatechange=stateChangedGetSite;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function stateChangedGetSite(){
	if(xmlHttp.readyState==4){
		document.getElementById("siteNameDiv").innerHTML = xmlHttp.responseText;
		document.myform.siteId.focus();
	}
}

//code for searching bachka

function funSearchBachka(){
	var searchItemName = document.myform.searchItemName.value;
	var searchBarCode = document.myform.searchBarCode.value;	
	var siteId = document.myform.siteId.value;	
	if(siteId == ""){
		alert("Please select site name");
		document.myform.siteId.focus();
		return false;
	}
	if(searchItemName == "" && searchBarCode == ""){
		alert("Please enter barcode or bachka name");
		document.myform.searchItemName.focus();
		return false;
	}
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="PakegingAjaxResponse.jsp";
  	//url=url+"?ajaxCallOption=searchBachka";
  	url=url+"?ajaxCallOption=searchBachka";
  	
  	url=url+"&searchBarCode="+searchBarCode;
  	url=url+"&searchItemName="+searchItemName;
  	url=url+"&siteId="+siteId;
  	url=url+"&sid="+Math.random();
  	xmlHttp.onreadystatechange=stateChangedSearchString;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function stateChangedSearchString(){
	if(xmlHttp.readyState==4){
		document.getElementById("searchBachkaListDiv").innerHTML = xmlHttp.responseText;
		var inner = document.getElementById('inner');
  		var secondWrapper = document.getElementById('secondWrapper');
  		//secondWrapper.innerHTML = inner.innerHTML;
  		
  		$('#searchItemTable1').dataTable({
	        "sDom": "Rlfrtip",
	     	"bPaginate": false,
	     	"sScrollXInner": "110%"
	     	
		});
  		
		xmlHttp = null;
	}
} 


// code for serching item

function funSearchItem(){
	var searchItemName = document.myform.itemName1.value;
	var searchBarCode = document.myform.searchBarCode1.value;	
	var siteId = document.myform.siteId.value;
	
	if(document.myform.selected_bachka_name.value == ""){
		alert("Please Select Bachka first");
		return false;
	}	
	if(searchItemName == "" && searchBarCode == ""){
		alert("Please enter barcode or item name");
		return false;
	}
	if(siteId == ""){
		alert("Please select site name");
		return false;
	}
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
 // 	alert("search item  item_group_code "+item_group_code);
  	var url="PakegingAjaxResponse.jsp";
  	url=url+"?ajaxCallOption=searchItem";
  	url=url+"&searchBarCode="+searchBarCode;
  	url=url+"&searchItemName="+searchItemName;
  	url=url+"&siteId="+siteId;
  	url=url+"&sid="+Math.random();
  	url=url+"&item_group_code="+item_group_code;
  	url=url+"&bachkaCode="+globalBachkaCode;
  	xmlHttp.onreadystatechange=stateChangedSearchString1;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function stateChangedSearchString1(){
	if(xmlHttp.readyState==4){
		document.getElementById("searchItemListDiv").innerHTML = xmlHttp.responseText;
		var inner = document.getElementById('inner1');
  		var secondWrapper = document.getElementById('secondWrapper1');
  		//secondWrapper.innerHTML = inner.innerHTML;
  		
  		$('#searchItemTable2').dataTable({
	        "sDom": "Rlfrtip",
	     	"bPaginate": false
	     });
		xmlHttp = null;
	}
}


function funClearBarcodeItemName(){
	document.myform.itemName1.value="";
	document.myform.searchBarCode1.value="";
	document.getElementById("searchItemListDiv").innerHTML="";
}

function funClearBarcodeBachkaName(){
	document.myform.searchItemName.value ="";
	document.myform.searchBarCode.value = "";
	document.getElementById("searchBachkaListDiv").innerHTML="";
	clearSelectBachka();
	funClearBarcodeItemName();
}

function funSelectBachka(barcode,item_code,item_weight,item_name,price_version,item_mrp,item_rate,item_pv_qty,site_qty,item_qty,item_box_qty,item_group_code_val){

	// initializing value of array
	globalItemCode = new Array();
	globalPriceVersion = new Array();

	document.myform.selected_bachka_name.value=item_name;
	document.myform.selected_bachka_barcode.value=barcode;
	document.myform.selected_bachka_code.value=item_code;
	document.myform.selected_bachka_weight.value=item_weight;
	document.myform.selected_bachka_pv.value=price_version;
	document.myform.selected_bachka_mrp.value=item_mrp;
	document.myform.selected_bachka_rate.value=item_rate;
	document.myform.selected_bachka_pv_qty.value=item_pv_qty;
	document.myform.selected_bachka_qty.value=site_qty;
	document.myform.selected_bachka_totat_qty.value=item_qty;
	document.myform.selected_bachka_totat_box_qty.value=item_box_qty;
	
	// asssigning value to item group code
	//alert("group code "+item_group_code_val);
	item_group_code=item_group_code_val;
	globalBachkaCode = item_code;	
	
	document.myform.break_count.disabled = false;
	//document.myform.weight_to_breakdown.value=item_weight;
	document.myform.loss_in_breakdown.disabled = false;
	document.myform.gain_in_breakdown.disabled = false;
	document.myform.break_count.focus();
	
	
	//reloading search item and added item  
	document.getElementById("searchItemListDiv").innerHTML=" ";
	$("#selectedItemsTable > tbody").html("");
	document.myform.breakdown_weight.value = 0;
}

function clearSelectBachka(){
	document.myform.selected_bachka_name.value="";
	document.myform.selected_bachka_barcode.value="";
	document.myform.selected_bachka_code.value="";
	document.myform.selected_bachka_weight.value="";
	document.myform.selected_bachka_pv.value="";
	document.myform.selected_bachka_mrp.value="";
	document.myform.selected_bachka_rate.value="";
	document.myform.selected_bachka_pv_qty.value="";
	document.myform.selected_bachka_qty.value="";
	document.myform.selected_bachka_totat_qty.value="";
	document.myform.selected_bachka_totat_box_qty.value="";
	
	document.myform.break_count.disabled = true;
	document.myform.weight_to_breakdown.value = 0;
	document.myform.loss_in_breakdown.disabled = true;
}

function funShowPopup(barcode,item_code,item_weight,item_name,price_version,item_mrp,item_rate,item_pv_qty,site_qty,item_qty,item_box_qty){
	
	//alert(globalItemCode.length+"  "+ globalPriceVersion.length)
	for(var i=0; i<globalItemCode.length && i< globalPriceVersion.length ;  i++){
		if(globalItemCode[i]==item_code && globalPriceVersion[i]==price_version){
			alert(" item already added ");
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
  			+"&box_qty="+item_box_qty
  			+"&price_version="+price_version;
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
		}
	}
}

function closePopup(){
	document.getElementById('popupMouseOver').style.display='none';
}


function funCloseDiv(){
	 Popup.hide('popupItemDiv');
}

function displayPopup(){
	document.getElementById('popupItemDiv').style.display = "block";
	Popup.showModal('popupItemDiv');
	document.myform.popupSelMrp.focus();
}
function funCancelOrder(){
	document.myform.action = "HomeForm.jsp";
	document.myform.submit();
}

function countTotalBachkaWeight(){
	var qty = parseInt(document.myform.break_count.options[document.myform.break_count.selectedIndex].value);
	var weight = parseInt(document.myform.selected_bachka_weight.value);
	if(qty>parseInt(document.myform.selected_bachka_qty.value)){
		alert(qty+" no of quantity is not availabe for break down");
		document.myform.break_count.selectedIndex=0;
		document.myform.weight_to_breakdown.value = 0;
		return;
	}
	document.myform.weight_to_breakdown.value=qty*weight;
}

// calculate total bachka weight for gain
function countTotalBachkaWeight1(){
	var qty = parseInt(document.myform.break_count.options[document.myform.break_count1.selectedIndex].value);
	var weight = parseInt(document.myform.selected_bachka_weight.value);
	if(qty>parseInt(document.myform.selected_bachka_qty.value)){
		alert(qty+" no of quantity is not availabe for break down");
		document.myform.break_count.selectedIndex=0;
		document.myform.weight_to_breakdown.value = 0;
		return;
	}
	document.myform.weight_to_breakdown1.value=qty*weight;
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
			//document.myform.popupTotal_total.value=tot_Q;
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



//function to automatic loss calculation
function calculateLoss(){
	var weight_to_breakdown = parseFloat(document.myform.weight_to_breakdown.value);
  	var breakdown_weight=parseFloat(document.myform.breakdown_weight.value);
  	
  	//alert(weight_to_breakdown+" "+breakdown_weight);
   	
  	if(weight_to_breakdown==0 )
  	{
  		alert("nothing to breakdown...");
  		return;
  	}
  	
  	
  	else if(breakdown_weight == weight_to_breakdown)
  	{ 
  		alert ("no loss no gain ");
  		document.myform.gain_in_breakdown.value=0;	
  		document.myform.loss_in_breakdown.value=0;	
  		return;
  	}
	else if(breakdown_weight < weight_to_breakdown)
  	{
  		alert("loss ....");
  		document.myform.loss_in_breakdown.value=(weight_to_breakdown-breakdown_weight);
  		document.myform.gain_in_breakdown.value=0;	
  		//alert("New quantity weight can nat be grater than Remaining weight. Only "+remaining_weight+" kg is remaining.");
  		
  	}
  	else if(breakdown_weight > weight_to_breakdown)
  	{	
  		alert("gain...");
  		document.myform.gain_in_breakdown.value=(breakdown_weight-weight_to_breakdown);		
  		document.myform.loss_in_breakdown.value=0;	
		// alert("New quantity weight can nat be grater than Remaining weight. Only "+remaining_weight+" kg is remaining.");
		  		
  	}	
  	
}



function funAddRow(){

	// validating for number digit for quantity
	if(isNaN(document.myform.popupNewQty_box.value))
	{
		alert("enter a number");
		document.myform.popupNewQty_box.value="";
		return;
		
	}
	
	document.getElementById('secondWrapper2').innerHTML = "";
	var objTable=document.getElementById("selectedItemsTable1");
	// alert(objTable);
	var rowCount = objTable.rows.length;
	//alert(objTable.rows.length);
	
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
		rate = document.myform.popupSelRate.options[document.myform.popupSelRate.selectedIndex].text;
	}
	
	//code to calculate breakdown weight total
  	var weight_to_breakdown = parseFloat(document.myform.weight_to_breakdown.value);
  	var breakdown_weight=parseFloat(document.myform.breakdown_weight.value);
  	var loss_in_breakdown=parseFloat(document.myform.loss_in_breakdown.value);
  	var item_weight=parseFloat(wieght);
  	var kg_or_gm=wieght.substr(wieght.length - 2);
  	
  	/* 
  		if(kg_or_gm=="gm"){
  		item_weight=item_weight/1000;
  	}else if(kg_or_gm == "kg"){
  		item_weight=item_weight;
  	}
  	 */
  	
  	//alert("char at 0 "+kg_or_gm.charAt(0)); 
  	if(kg_or_gm.charAt(0) == "k" || kg_or_gm.charAt(0) == "K"){
	  		item_weight=item_weight;
  	}else{
  		item_weight=item_weight/1000;
  	}
  	 
  	
  	
  	var quantity=(newQty_box*item_box_qty)+newQty;
  	var new_wight=item_weight*quantity;
  	var remaining_weight=weight_to_breakdown-breakdown_weight-loss_in_breakdown;
  	
  	// checking for total weight not zero
  	if(weight_to_breakdown==0 )
  	{	
  		alert("Nothing to breakdown... "+remaining_weight+" kg is remaining ");
  		return;
  	}
  	 
  	
  		
	// pushing value into array to prevent duplication
	globalItemCode.push(itemCode); 
	globalPriceVersion.push(priceVersion);
	
  	
  	
  	breakdown_weight=breakdown_weight+new_wight;
  	document.myform.breakdown_weight.value=breakdown_weight;
  //	alert(breakdown_weight+" " +breakdown_weight +" "+new_wight);
  		
	//code for adding row in table	
	var lastRow = objTable.rows.length;
	var newRow = document.all("selectedItemsTable").insertRow(-1);
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveBarcode' size='3' class='hideTextField1' readonly='readonly' value='"+barcode+"'/>";
	oCell.style.display='none';
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveItemCode' size='3' class='hideTextField1' readonly='readonly' value='"+itemCode+"'/>";
	oCell.style.display='none';
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveItemName' size='10' class='hideTextField2' readonly='readonly' value='"+name+"'/>";
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveItemWeight' size='3' class='hideTextField2' readonly='readonly' value='"+wieght+"'/>";
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveMrp' size='3' class='hideTextField' readonly='readonly' value='"+mrp+"'/>";
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveRate' size='3' class='hideTextField' readonly='readonly'  value='"+rate+"'/>";
	oCell.style.display='none';
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveOldQty_box' size='2' class='hideTextField' readonly='readonly' value='"+oldQty_box+"'/>";
		
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveOldQty' size='3' class='hideTextField' readonly='readonly' value='"+oldQty+"'/>";
	oCell.style.display='none';
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveOldQty-total' size='3' class='hideTextField' readonly='readonly' value='"+(oldQty_box*item_box_qty+oldQty)+"'/>";
	oCell.style.display='none';
		
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveNewQty_box' size='2' class='hideTextField' readonly='readonly' value='"+newQty_box+"'/>";
		
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveNewQty' size='3' class='hideTextField' readonly='readonly' value='"+newQty+"'/>";
	oCell.style.display='none';
		
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveNewQty_total' size='3' class='hideTextField' readonly='readonly' value='"+(newQty_box*item_box_qty+newQty)+"'/>";
	oCell.style.display='none';
		
	oCell = newRow.insertCell();
	//oCell.innerHTML = "<input type='text' name='saveTotalQty_box' size='2' class='hideTextField' readonly='readonly' value='"+totalQty_box+"'/>";
	oCell.innerHTML = "<input type='text' name='saveTotalQty_box' size='2' class='hideTextField' readonly='readonly' value='"+(oldQty_box+newQty_box)+"'/>";
		
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveTotalQty' size='3' class='hideTextField' readonly='readonly' value='"+totalQty+"'/>";
	oCell.style.display='none';
		
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='TotalQty-total' size='3' class='hideTextField' readonly='readonly' value='"+(totalQty_box*item_box_qty+totalQty)+"'/>";
	oCell.style.display='none';
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='text' name='saveTotalMrp' size='3' class='hideTextField' readonly='readonly' value='"+totalMrp+"'/>";
	oCell.style.display='none';
	oCell = newRow.insertCell();
	//oCell.innerHTML = "<img src='images/icon_trash.gif' onclick='deleteRow(this)' alt='delete row'>";
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
	
	oCell = newRow.insertCell();
	oCell.innerHTML = "<input type='hidden' name='new_weight' size='4'  value='"+new_wight+"'/>";
	oCell.style.display='none';
	
	var inner = document.getElementById('inner2');
	var secondWrapper = document.getElementById('secondWrapper2');
	secondWrapper.innerHTML = inner.innerHTML;
  	funCloseDiv();
  	
  	
  	
   	
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

function deleteRow(t,item_code1,price_version1){
	
		
	//alert("delete "+item_code1+"  "+price_version1);
	
	for(var i=0; i<globalItemCode.length && i< globalPriceVersion.length ;  i++){
		if(globalItemCode[i]==item_code1 && globalPriceVersion[i]==price_version1){
			globalItemCode.splice(i,1);
			globalPriceVersion.splice(i,1);
			
		}
	}


	var breakdown_weight = parseFloat(document.myform.breakdown_weight.value);
	var tr=t.parentNode.parentNode;
	var rowCount = tr.parentNode.rows.length;	
	var objTableId =tr.parentNode.parentNode.getAttribute("id");
	var objTable=document.getElementById(tr.parentNode.parentNode.getAttribute("id"));
	var rowCount = objTable.rows.length;
	var row = tr.rowIndex-1 ;
	var totalQty,totalMrp,weight_to_remove;
	if(rowCount == 1){
		totalQty = document.myform.saveTotalQty.value;
		totalMrp = document.myform.saveTotalMrp.value;
		weight_to_remove = parseFloat(document.myform.new_weight.value);
	}else{
		totalQty = document.myform.saveTotalQty[row].value;
		totalMrp = document.myform.saveTotalMrp[row].value;
		weight_to_remove = parseFloat(document.myform.new_weight[row].value);
	}
	for ( var i = tr.rowIndex; i < rowCount; i++) {		
		if(i== tr.rowIndex){
			tr.parentNode.removeChild(tr);			
		}			
	}		
	breakdown_weight=breakdown_weight-weight_to_remove;
	document.myform.breakdown_weight.value=breakdown_weight;
}


//function to check total_weight value
function calculateLoss1(){
	var weight_to_breakdown = parseFloat(document.myform.weight_to_breakdown.value);
  	var breakdown_weight=parseFloat(document.myform.breakdown_weight.value);
  	
  	//alert(weight_to_breakdown+" "+breakdown_weight);
   	
  	if(weight_to_breakdown==0 )
  	{
  		return;
  	}
  		calculateLoss();		
  }


// function for save & print button 
function funSaveOrder(){
	calculateLoss1();
	
	// checkin is their value availabe for further calculation
	/* 
	if(document.myform.loss_in_breakdown.value==0 && document.myform.gain_in_breakdown.value==0){
		alert("Nothing to breakdown...");
		return;
	}
	
	 */
	
	if(document.myform.loss_in_breakdown.value==""){
		document.myform.loss_in_breakdown.value="0";
	}
	
	if(document.myform.gain_in_breakdown.value==""){
		document.myform.gain_in_breakdown.value="0";
	}
	
	var loss_in_breakdown = parseFloat(document.myform.loss_in_breakdown.value);
	var gain_in_breakdown = parseFloat(document.myform.gain_in_breakdown.value);
	
	var breakdown_weight = parseFloat(document.myform.breakdown_weight.value);
	var weight_to_breakdown = parseFloat(document.myform.weight_to_breakdown.value);
	
	//checkin is their value availabe for further calculation
	if(weight_to_breakdown==0)
	{
		alert("Nothing to breakdown...");
		return;
	}
	
	// validating total value against al, entries 
	if(weight_to_breakdown!=(loss_in_breakdown+breakdown_weight) && weight_to_breakdown != (breakdown_weight - gain_in_breakdown)){
		alert("Total weight to breakdown and actual breakdown weight not matching. Chek out all entries");
		return;
	}
	document.getElementById("searchItemListDiv").innerHTML ="";
	document.getElementById('secondWrapper2').innerHTML = "";
	document.myform.action = "Pakeging.jsp";
	document.myform.submit();
}
