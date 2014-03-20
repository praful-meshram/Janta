function CancelOrder1(){
	document.myform.action = "OrderCheckedMenuForm.jsp";
	document.myform.submit();
}

function EvalSound(soundobj) {
	var thissound=eval(document.getElementById(soundobj));
	try {
	     thissound.Play();
	 }
	 catch (e) {
	     thissound.DoPlay();
	 }
}

function GetXmlHttpObject(){
	var xmlHttp=null;	
	try{
		  xmlHttp=new XMLHttpRequest();			  // Firefox, Opera 8.0+, Safari
	}catch (e) {
		  try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");			  // Internet Explorer
		  }catch (e){
		    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }	
	}
		return xmlHttp;
}

//---------Page : OrderCheckedMenuForm.jsp..............
function funIsExistOrderNo(){
	
	var orderNo=document.myform.orderNo.value;
	if(orderNo==""){
		alert("Order Number Cannot be Blank ");		
		document.myform.orderNo.focus();
		return false;
	}
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="checkedOrderAjaxResponse.jsp?ajaxCallOption=checkOrderExistance&orderNo="+orderNo;			
	xmlHttp.onreadystatechange=stateIsExistOrderNo;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);	
}

function stateIsExistOrderNo(){	
	if (xmlHttp.readyState==4){ 	
		var result =trim(xmlHttp.responseText)
		if(result=="Exist"){			
			document.myform.action="OrderProcessingCheckedForm.jsp?backPage=OrderCheckedMenuForm.jsp";		
			document.myform.submit();			
		}if(result=="NotExist"){
			alert("Order number does not exist to process.");
			document.myform.orderNo.focus();
			document.myform.orderNo.value="";	
			return;
		}	
	}
}

//---------Page : OrderProcessingCheckedForm.jsp..............

function funShowCustInfo(){
	var orderNo=document.myform.hOrderNo.value;	
	//alert(orderNo);
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="checkedOrderAjaxResponse.jsp?ajaxCallOption=getCustInfo&orderNo="+orderNo;			
	xmlHttp.onreadystatechange=stateShowCustInfo;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);	
}

function stateShowCustInfo(){	
	if (xmlHttp.readyState==4){ 
		//alert("CustInfoDiv "+xmlHttp.responseText);
		document.getElementById("CustInfoDiv").innerHTML=xmlHttp.responseText;	
	    funShowOrderDetails();
	}
}

function funShowOrderDetails(){
	var orderNo=document.myform.hOrderNo.value;	
	//alert(orderNo);
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="checkedOrderAjaxResponse.jsp?ajaxCallOption=getOrderInfo&orderNo="+orderNo;			
	xmlHttp.onreadystatechange=stateShowOrderDetails;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);	
}

function stateShowOrderDetails(){	
	if (xmlHttp.readyState==4){ 
		//alert("OrderInfoDiv "+xmlHttp.responseText);
		document.getElementById("OrderInfoDiv").innerHTML=xmlHttp.responseText;	
		funShowOrderItemDetails();
	}
}

function funShowOrderItemDetails(){
	var orderNo=document.myform.hOrderNo.value;	
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="checkedOrderAjaxResponse.jsp?ajaxCallOption=getOrderItemInfo&orderNo="+orderNo;			
	xmlHttp.onreadystatechange=stateShowOrderItemDetails;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);	
}

function stateShowOrderItemDetails(){	
	if (xmlHttp.readyState==4){ 
		//alert("OrderItemInfoDiv "+xmlHttp.responseText);
		document.getElementById("OrderItemInfoDiv").innerHTML=xmlHttp.responseText;	
		var objTable=eval('document.getElementById("itemTable")');
		var objrows = objTable.getElementsByTagName("TBODY")[0].rows;
		var selObj= document.getElementById("selItemName");
		
		for(var i=0;i<objrows.length;i++){
			//alert(objrows.length+" "+objrows[i].cells[1].getElementsByTagName("INPUT")[0].value)
			var optObj= document.createElement("option");
			optObj.text = trim(objrows[i].cells[1].getElementsByTagName("INPUT")[0].value);
			optObj.value = objrows[i].cells[8].getElementsByTagName("INPUT")[0].value;
			
			//optObj.setAttribute("text",trim(objrows[i].cells[1].getElementsByTagName("INPUT")[0].value));
			//optObj.setAttribute("value",objrows[i].cells[8].getElementsByTagName("INPUT")[0].value);				
			selObj.add(optObj);
			
		}
		
		
	}
}

function funUpdateItemNameSelectBox(){
	var objTable=eval('document.getElementById("itemTable")');
	var objrows = objTable.getElementsByTagName("TBODY")[0].rows;
	var selObj= document.getElementById("selItemName");
	for (i = selObj.length; i>=1; i--) {
		selObj.remove(i);
	}
	for(var i=0;i<objrows.length;i++){
		var optObj= document.createElement("option");
				
		optObj.text = trim(objrows[i].cells[1].getElementsByTagName("INPUT")[0].value);
		optObj.value = trim(objrows[i].cells[8].getElementsByTagName("INPUT")[0].value);	
		//alert(objrows[i].cells[8].getElementsByTagName("INPUT")[0].value);
		selObj.add(optObj);
	}
}
function funCheckItemName(){
	var selValue = document.forms[0].selItemName.value;
	if(selValue == ""){
		alert("Please select item name.")
		return;
	}
	document.myform.itemBarcode.value = selValue ;
	funMatchBarCode();

}
//---------------------------Match Barcode Function-----------

function funMatchBarCode(){
	var selBarcode = document.myform.itemBarcode.value;
	selBarcode = selBarcode.toUpperCase();
	//alert(selBarcode);
	var barcodeObj = document.getElementById(selBarcode);
	//alert(barcodeObj);
	var orderQty,accountedQty;
	var objTable=eval('document.getElementById("itemTable")'); 
	var objRemoveItemInfoTable=eval('document.getElementById("removeItemInfoTable")');
	var objMatchedItemTable=eval('document.getElementById("matchedItemTable")');
	var objrows = objTable.getElementsByTagName("TBODY")[0].rows;
	var objrowsLength = objTable.getElementsByTagName("TBODY")[0].rows.length;
	var objRemoveItemInfoRows = objRemoveItemInfoTable.getElementsByTagName("TBODY")[0].rows;
	var objMatchedItemRows = objMatchedItemTable.getElementsByTagName("TBODY")[0].rows;
	var removeItemTblColumnCnt = objRemoveItemInfoTable.getElementsByTagName("THEAD")[0].getElementsByTagName("TR")[1].getElementsByTagName("TH").length;
	var flagCheckBarcode=true;
	if(barcodeObj != null){
		var rowObj = barcodeObj.parentNode.parentNode;
		var rowNumber = rowObj.rowIndex-1;
		
		if(document.myform.iOrderQty[rowNumber] !=undefined){
			//alert("1");
			orderQty = document.myform.iOrderQty[rowNumber].value;
			flagCheckBarcode=false;
			if(orderQty == 1){	
				//alert("2");
				document.myform.iAccountedQty[rowNumber].value = 1;			
				
				document.myform.rBarcode.value = selBarcode;				
				document.myform.rItemName.value = document.myform.iName[rowNumber].value;
				document.myform.rWeight.value = document.myform.iWeight[rowNumber].value;
				document.myform.rOrderedQty.value = document.myform.iOrderQty[rowNumber].value;
				document.myform.rAccQty.value = document.myform.iAccountedQty[rowNumber].value;
				
				document.getElementById('matchedItemTableDiv').style.display = "none";	
				document.getElementById('removedItemTableDiv').style.display = "inline";
					
				var objTR= document.createElement("TR");
				for(var j=0;j<removeItemTblColumnCnt-1;j++){
					var objTd = document.createElement("TD");
						objTd.style.background = "#e5d9e5";
						objTd.innerText=trim(objrows[rowNumber].cells[j].getElementsByTagName("INPUT")[0].value);
						objTR.appendChild(objTd);
				}
				objRemoveItemInfoTable.getElementsByTagName("TBODY")[0].appendChild(objTR);
				objrows[rowNumber].parentNode.removeChild(objrows[rowNumber]);
				
				funUpdateItemNameSelectBox();
				document.myform.itemBarcode.value="";
				document.myform.itemBarcode.focus();
				
		    }else{
		    	//alert("3");
				var iaccqty = document.myform.iAccountedQty[rowNumber].value;
				if(iaccqty==""){
					iaccqty=0;
				}
				document.myform.iAccountedQty[rowNumber].value= parseInt(iaccqty)+1;
				if(document.myform.iAccountedQty[rowNumber].value == document.myform.iOrderQty[rowNumber].value){
					document.myform.rBarcode.value = selBarcode;
					document.myform.rItemName.value = document.myform.iName[rowNumber].value;
					document.myform.rWeight.value = document.myform.iWeight[rowNumber].value;
					document.myform.rOrderedQty.value = document.myform.iOrderQty[rowNumber].value;
					document.myform.rAccQty.value = document.myform.iAccountedQty[rowNumber].value;
						
					document.getElementById('matchedItemTableDiv').style.display = "none";	
					document.getElementById('removedItemTableDiv').style.display = "inline";
					//document.getElementById('displayMsgTR').style.display = "inline";
		
					var objTR= document.createElement("TR");
					for(var j=0;j<removeItemTblColumnCnt-1;j++){
						var objTd = document.createElement("TD");
						objTd.style.background = "#e5d9e5";
							objTd.innerText=trim(objrows[rowNumber].cells[j].getElementsByTagName("INPUT")[0].value);
							
							objTR.appendChild(objTd);
					}
					objRemoveItemInfoTable.getElementsByTagName("TBODY")[0].appendChild(objTR);
					objrows[rowNumber].parentNode.removeChild(objrows[rowNumber]);
					funUpdateItemNameSelectBox();
					document.myform.itemBarcode.value="";
					document.myform.itemBarcode.focus();
				}else{
					document.myform.mBarcode.value = selBarcode;
					document.myform.mItemName.value = document.myform.iName[rowNumber].value;
					document.myform.mWeight.value = document.myform.iWeight[rowNumber].value;
					document.myform.mOrderedQty.value = document.myform.iOrderQty[rowNumber].value;
					var newValue = (parseInt(iaccqty)+1);
					document.myform.mAccQty.value = newValue;
					
					document.getElementById('removedItemTableDiv').style.display = "none";
					document.getElementById('matchedItemTableDiv').style.display = "inline";					
					//document.getElementById('displayMsgTR').style.display = "inline";	
					document.myform.itemBarcode.value="";
					document.myform.itemBarcode.focus();
		    	}
				
			}
		}else{
			orderQty = document.myform.iOrderQty.value;
			flagCheckBarcode=false;
			if(orderQty == 1){			
				document.myform.iAccountedQty.value = 1;			
						
				document.myform.rBarcode.value = selBarcode;
				document.myform.rItemName.value = document.myform.iName.value;
				document.myform.rWeight.value = document.myform.iWeight.value;
				document.myform.rOrderedQty.value = document.myform.iOrderQty.value;
				document.myform.rAccQty.value = document.myform.iAccountedQty.value;
							
				document.getElementById('removedItemTableDiv').style.display = "inline";
				document.getElementById('matchedItemTableDiv').style.display = "none";					
				//document.getElementById('displayMsgTR').style.display = "inline";
	
				var objTR= document.createElement("TR");
				for(var j=0;j<removeItemTblColumnCnt-1;j++){
					var objTd = document.createElement("TD");
					objTd.style.background = "#e5d9e5";
						objTd.innerText=trim(objrows[0].cells[j].getElementsByTagName("INPUT")[0].value);
						objTR.appendChild(objTd);
				}
				objRemoveItemInfoTable.getElementsByTagName("TBODY")[0].appendChild(objTR);
				objrows[0].parentNode.removeChild(objrows[0]);
				funUpdateItemNameSelectBox();
				document.myform.itemBarcode.value="";
				document.myform.itemBarcode.focus();
		    }else{
				var iaccqty = document.myform.iAccountedQty.value;
				if(iaccqty==""){
					iaccqty=0;
				}
				document.myform.iAccountedQty.value= parseInt(iaccqty)+1;
				if(document.myform.iAccountedQty.value == document.myform.iOrderQty.value){
					document.myform.rBarcode.value = selBarcode;
					document.myform.rItemName.value = document.myform.iName.value;
					document.myform.rWeight.value = document.myform.iWeight.value;
					document.myform.rOrderedQty.value = document.myform.iOrderQty.value;
					document.myform.rAccQty.value = document.myform.iAccountedQty.value;
					
					document.getElementById('removedItemTableDiv').style.display = "inline";
					document.getElementById('matchedItemTableDiv').style.display = "none";	
					//document.getElementById('displayMsgTR').style.display = "inline";
		
					var objTR= document.createElement("TR");
					for(var j=0;j<removeItemTblColumnCnt-1;j++){
						var objTd = document.createElement("TD");
						objTd.style.background = "#e5d9e5";
							objTd.innerText=trim(objrows[0].cells[j].getElementsByTagName("INPUT")[0].value);
							objTR.appendChild(objTd);
					}
					objRemoveItemInfoTable.getElementsByTagName("TBODY")[0].appendChild(objTR);
					objrows[0].parentNode.removeChild(objrows[0]);
					funUpdateItemNameSelectBox();
					document.myform.itemBarcode.value="";
					document.myform.itemBarcode.focus();
					
				}else{
					
					document.myform.mBarcode.value = selBarcode;
					document.myform.mItemName.value = document.myform.iName.value;
					document.myform.mWeight.value = document.myform.iWeight.value;
					document.myform.mOrderedQty.value = document.myform.iOrderQty.value;
					document.myform.mAccQty.value = parseInt(iaccqty)+1;
					
					document.getElementById('removedItemTableDiv').style.display = "none";
					document.getElementById('matchedItemTableDiv').style.display = "inline";	
					//document.getElementById('displayMsgTR').style.display = "inline";	
					document.myform.itemBarcode.value="";
					document.myform.itemBarcode.focus();
				}
		}
	 }
 }
	var objrows = objTable.getElementsByTagName("TBODY")[0].rows;
	var objrowsLength = objTable.getElementsByTagName("TBODY")[0].rows.length;
	if(objrowsLength ==0){
		SaveOrder();
	}else{
		document.myform.itemBarcode.value="";
		document.myform.itemBarcode.focus();
		
	}
	
	
	
	if(flagCheckBarcode){
		if(selBarcode == ""){
			alert("Please enter item barcode.");
			return false;
		}
		document.myform.notMatchBarcode.value = selBarcode;
		EvalSound("sound1");
		document.getElementById('notMatchedItemTableDiv').style.display = "inline";
		responseDivSetup(document.getElementById('baseDiv'),document.getElementById('notMatchedItemTableDiv'));
		document.myform.notMatchBarcode.focus();
		//Popup.showModal(document.getElementById('notMatchedItemTableDiv'));
		//document.getElementById('displayMessageDiv').innerHTML = document.getElementById('notMatchedItemTableDiv').innerHTML;
		//document.getElementById('displayMessageDiv').style.background = "#BEF781";
		//document.getElementById("displayMsgTR").style.visibility="visible";		
		//document.getElementById('displayMsgTR').style.display = "inline";
	}
	
}

function trim(stringToTrim) {
return stringToTrim.replace(/^\s+|\s+$/g,"");
}
function funCancel(){
	//document.getElementById('displayMessageDiv').innerHTML = "";
	//document.getElementById('displayMessageDiv').style.background = "#BEF781";
	//document.getElementById('displayMsgTR').style.visibility = "visible";	
	//document.getElementById('displayMsgTR').style.display = "inline";	
	deletePopUp(document.getElementById('baseDiv'),document.getElementById('notMatchedItemTableDiv'));
	
	
}
function setValue(s){
	var objTable=eval('document.getElementById("itemTable")'); 
	var objRemoveItemInfoTable=eval('document.getElementById("removeItemInfoTable")');
	var objMatchedItemTable=eval('document.getElementById("matchedItemTable")');
	var objrows = objTable.getElementsByTagName("TBODY")[0].rows;
	var objrowsLength = objTable.getElementsByTagName("TBODY")[0].rows.length;
	var objRemoveItemInfoRows = objRemoveItemInfoTable.getElementsByTagName("TBODY")[0].rows;
	var objMatchedItemRows = objMatchedItemTable.getElementsByTagName("TBODY")[0].rows;
	var removeItemTblColumnCnt = objRemoveItemInfoTable.getElementsByTagName("THEAD")[0].getElementsByTagName("TR")[1].getElementsByTagName("TH").length;
	var columnCount = objTable.getElementsByTagName("THEAD")[0].getElementsByTagName("TR")[0].getElementsByTagName("TH").length;
	
	var enteredBarcode = document.myform.mBarcode.value;
	var barcodeObj = document.getElementById(enteredBarcode);
	var rowObj = barcodeObj.parentNode.parentNode;
	var rowNumber = rowObj.rowIndex-1;
	if(document.myform.iOrderQty[rowNumber] !=undefined){
			var orderQty= document.myform.iOrderQty[rowNumber].value;
			document.myform.iAccountedQty[rowNumber].value= s;
			var accountedQty = document.myform.iAccountedQty[rowNumber].value;
			if(orderQty == s){	
				var objTR= document.createElement("TR");
				for(var j=0;j<removeItemTblColumnCnt-1;j++){
					var objTd = document.createElement("TD");
					objTd.style.background = "#e5d9e5";
						objTd.innerText=trim(objrows[rowNumber].cells[j].getElementsByTagName("INPUT")[0].value);
						objTR.appendChild(objTd);
				}
				objRemoveItemInfoTable.getElementsByTagName("TBODY")[0].appendChild(objTR);
				document.myform.rBarcode.value = enteredBarcode;
				document.myform.rItemName.value = document.myform.iName[rowNumber].value;
				document.myform.rWeight.value = document.myform.iWeight[rowNumber].value;
				document.myform.rOrderedQty.value = s;
				document.myform.rAccQty.value = s;
				objrows[rowNumber].parentNode.removeChild(objrows[rowNumber]);
				//document.getElementById('displayMessageDiv').innerHTML = "";
				//document.getElementById('displayMessageDiv').innerHTML = document.getElementById('removedItemTableDiv').innerHTML;
				//document.getElementById('displayMessageDiv').style.background = "#BEF781";
				document.getElementById('removedItemTableDiv').style.display = "inline";
				document.getElementById('matchedItemTableDiv').style.display = "none";	
				funUpdateItemNameSelectBox();
				document.myform.itemBarcode.value="";
				document.myform.itemBarcode.focus();
			}else if (orderQty < s){
				alert("Accounted Quntity Must Be Less Than Order Quantity ");
				document.myform.iAccountedQty[rowNumber].value=1;
				return false;
			}
	}else{
		var orderQty= document.myform.iOrderQty.value;
		document.myform.iAccountedQty.value= s;
		var accountedQty = document.myform.iAccountedQty.value;
		if(orderQty == s){	
			var objTR= document.createElement("TR");
			for(var j=0;j<removeItemTblColumnCnt-1;j++){
				var objTd = document.createElement("TD");
				objTd.style.background = "#e5d9e5";
					objTd.innerText=trim(objrows[0].cells[j].getElementsByTagName("INPUT")[0].value);
					objTR.appendChild(objTd);
			}
			objRemoveItemInfoTable.getElementsByTagName("TBODY")[0].appendChild(objTR);
			document.myform.rBarcode.value = enteredBarcode;
			document.myform.rItemName.value = document.myform.iName.value;
			document.myform.rWeight.value = document.myform.iWeight.value;
			document.myform.rOrderedQty.value = s;
			document.myform.rAccQty.value = s;
			objrows[0].parentNode.removeChild(objrows[0]);
			//document.getElementById('displayMessageDiv').innerHTML = "";
			//document.getElementById('displayMessageDiv').innerHTML = document.getElementById('removedItemTableDiv').innerHTML;
			//document.getElementById('displayMessageDiv').style.background = "#BEF781";
			document.getElementById('removedItemTableDiv').style.display = "inline";
			document.getElementById('matchedItemTableDiv').style.display = "none";	
			funUpdateItemNameSelectBox();
			document.myform.itemBarcode.value="";
			document.myform.itemBarcode.focus();
		}else if (orderQty < s){
			alert("Accounted Quntity Must Be Less Than Order Quantity ");
			document.myform.iAccountedQty.value=1;
			return false;
		}
	}
	var objrows = objTable.getElementsByTagName("TBODY")[0].rows;
	var objrowsLength = objTable.getElementsByTagName("TBODY")[0].rows.length;
	if(objrowsLength ==0){
		SaveOrder();
	}else{
		document.myform.itemBarcode.value="";
		document.myform.itemBarcode.focus();
		
	}
}


function funShowPopup(barcode){
	//var barcode = trim(document.myform.itemBarcode.value);
	deletePopUp(document.getElementById('baseDiv'),document.getElementById('notMatchedItemTableDiv'));
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="getItemBarcodeDetails.jsp?ibarcode="+barcode;			
	xmlHttp.onreadystatechange=stateFindData;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);	

}
function stateFindData(){
	if (xmlHttp.readyState==4){ 	
		var arrayList= trim(xmlHttp.responseText);	
		if(arrayList=="Barcode does not exist"){
			EvalSound("sound1");
			alert("Barcode does not exist");
			document.myform.itemBarcode.focus();
		}else{
			funShowSwapDivData(arrayList);
		}
	}
}

function funShowSwapDivData(arrayList){	
	var objArray=new Array();
	objArray = arrayList.split("@@");
	var targetItemCode=objArray[0];
	var targetName=objArray[1];
	var targetWeight=objArray[2];
	var targetRate=objArray[3];
	var targetMrp=objArray[4];
	var targetDealAmount=objArray[5];
	var targetDealQty=objArray[6];
	var targetItemGroupCode=objArray[7];
	var targetBarcode=objArray[8];
	
	document.myform.targetItemCode.value=targetItemCode;
	document.myform.targetName.value=targetName;
	document.myform.targetWeight.value=targetWeight;
	document.myform.targetRate.value=targetRate;
	document.myform.targetMrp.value=targetMrp;
	document.myform.targetQty.value="";
	document.myform.targetPrice.value="";
	if(targetDealQty==null || targetDealQty==""){
		document.myform.targetRemark.value="";
	}else{
		document.myform.targetRemark.value="Rs: "+targetDealQty+"on"+targetDealAmount+" QTYs ";
	}
	document.myform.targetBarcode.value=targetBarcode;
	document.myform.targetItemGroupCode.value=targetItemGroupCode;
	document.myform.targetDealAmount.value=targetDealAmount;
	document.myform.targetDealQty.value=targetDealQty;
	
	var objTable=eval('document.getElementById("itemTable")');
	var objrows = objTable.getElementsByTagName("TBODY")[0].rows;
	
	var selObj= document.getElementById("selSourceItem");
	selObj.length=0;
	var optionObj=document.createElement("option");
	optionObj.setAttribute("text","Select");
	optionObj.setAttribute("value","");				
	selObj.add(optionObj);
	
	for(var i=0;i<objrows.length;i++){		
		if(document.myform.hItemGroupCode[i] != undefined){
			//alert(targetItemGroupCode+"    :   "+trim(document.myform.hItemGroupCode[i].value));
			if (trim(targetItemGroupCode) == (trim(document.myform.hItemGroupCode[i].value))){
				var optObj= document.createElement("option");
				optObj.setAttribute("text",trim(document.myform.iName[i].value));
				optObj.setAttribute("value",trim(document.myform.iCode[i].value));				
				selObj.add(optObj);
			}
		}else{
			//alert(targetItemGroupCode+"    :   "+trim(document.myform.hItemGroupCode.value));
			if (trim(targetItemGroupCode) == (trim(document.myform.hItemGroupCode.value))){
				var optObj= document.createElement("option");
				optObj.setAttribute("text",trim(document.myform.iName.value));
				optObj.setAttribute("value",trim(document.myform.iCode.value));				
				selObj.add(optObj);
			}	
		}
	}
	document.myform.sourceWeight.value="";
	document.myform.sourceRate.value="";	
	document.myform.sourceMrp.value="";
	document.myform.sourceQty.value="";
	document.myform.sourceDiscount.value="";
	document.myform.sourcePrice.value="";
	document.myform.sourceRemark.value="";
	
	document.getElementById('swapItemDiv').style.display = "inline";
	responseDivSetup(document.getElementById('baseDiv'),document.getElementById('swapItemDiv'));
	var sourceItemLength=document.myform.selSourceItem.length;
	if(sourceItemLength == 1){
		alert("Source item group is not matching with target item group");
		return false;
	}

}

function funSetItemValues(){
	var barcode= document.myform.selSourceItem.value;
	//alert(barcode);
	var barcodeObj = document.getElementById(barcode);
	//alert(document.getElementById(barcode));
	//alert(barcodeObj.parentNode.parentNode);
	var rowObj = barcodeObj.parentNode.parentNode;
	var rowNumber = rowObj.rowIndex-1;
	if(document.myform.iWeight[rowNumber] !=undefined){
		document.myform.sourceWeight.value= document.myform.iWeight[rowNumber].value;
		document.myform.sourceRate.value =document.myform.iRate[rowNumber].value;
		document.myform.sourceMrp.value ="";
		document.myform.sourceQty.value =document.myform.iOrderQty[rowNumber].value;
		document.myform.sourceDiscount.value ="";
		document.myform.sourcePrice.value =document.myform.iPrice[rowNumber].value;
		document.myform.sourceRemark.value =document.myform.iRemark[rowNumber].value;
		document.myform.sourceBarcode.value =document.myform.hBarcode[rowNumber].value;
	}else{
		document.myform.sourceWeight.value= document.myform.iWeight.value;
		document.myform.sourceRate.value =document.myform.iRate.value;
		document.myform.sourceMrp.value ="";
		document.myform.sourceQty.value =document.myform.iOrderQty.value;
		document.myform.sourceDiscount.value ="";
		document.myform.sourcePrice.value =document.myform.iPrice.value;
		document.myform.sourceRemark.value =document.myform.iRemark.value;
		document.myform.sourceBarcode.value =document.myform.hBarcode.value;
	}
}

function funSwapItems(){
	var sourceItem = document.myform.selSourceItem.value;
	if(sourceItem == ""){
		alert("Please select source item name.");
		return false;
	}
	
	var objswapRecordTable=eval('document.getElementById("swapItemTable")');
	var objswapTablerows = objswapRecordTable.getElementsByTagName("TBODY")[0].rows;
	
	var targetQty = document.myform.targetQty.value;
	if(targetQty == "" || targetQty == 0){
		alert("Please enter quantity");
		return false;
	}
	var targetPrice = document.myform.targetPrice.value;
	
	var sourcePrice = document.myform.sourcePrice.value;
	var tallyPrice1 = parseFloat(targetPrice) - parseFloat(sourcePrice);
	var tallyPrice2 = parseFloat(sourcePrice) - parseFloat(targetPrice);
	if(tallyPrice1 > 10 || tallyPrice2 > 10){
		alert("Target price and Source Price difference should not be greater than 10Rs.");
		return false;
	}
	
	var item_code = document.myform.selSourceItem.value;	
	
	var objTable=eval('document.getElementById("itemTable")');
	var objrows = objTable.getElementsByTagName("TBODY")[0].rows;
	objrowsLength =objTable.getElementsByTagName("TBODY")[0].rows.length;
	var columnCount = objTable.getElementsByTagName("THEAD")[0].getElementsByTagName("TR")[0].getElementsByTagName("TH").length;
	
	var objswapNewItemTable=eval('document.getElementById("swapNewItemTable")');
	var objswapNewTablerows = objswapNewItemTable.getElementsByTagName("TBODY")[0].rows;
	
	var rowCount = objswapNewTablerows.length;
	var objNewTR= document.createElement("TR");
	var objNewTd1 = document.createElement("TD");
	var createIcode = document.createElement("INPUT");
	createIcode.setAttribute("id","NewItemCode");
	createIcode.setAttribute("name","NewItemCode");
	createIcode.setAttribute("size","3");
	objNewTd1.appendChild(createIcode);
	objNewTR.appendChild(objNewTd1);
	
	var objNewTd2 = document.createElement("TD");
	var createIname = document.createElement("INPUT");
	createIname.setAttribute("id","NewItemName");
	createIname.setAttribute("name","NewItemName");
	createIname.setAttribute("size","4");
	objNewTd2.appendChild(createIname);
	objNewTR.appendChild(objNewTd2);
	
	var objNewTd3 = document.createElement("TD");
	var createIrate = document.createElement("INPUT");
	createIrate.setAttribute("id","NewItemRate");
	createIrate.setAttribute("name","NewItemRate");
	createIrate.setAttribute("size","3");
	objNewTd3.appendChild(createIrate);
	objNewTR.appendChild(objNewTd3);
	
	var objNewTd4 = document.createElement("TD");
	var createImrp = document.createElement("INPUT");
	createImrp.setAttribute("id","NewItemMrp");
	createImrp.setAttribute("name","NewItemMrp");
	createImrp.setAttribute("size","3");
	objNewTd4.appendChild(createImrp);
	objNewTR.appendChild(objNewTd4);
	
	var objNewTd5 = document.createElement("TD");
	var createIqty = document.createElement("INPUT");
	createIqty.setAttribute("id","NewItemQty");
	createIqty.setAttribute("name","NewItemQty");
	createIqty.setAttribute("size","3");
	objNewTd5.appendChild(createIqty);
	objNewTR.appendChild(objNewTd5);
	
	var objNewTd6 = document.createElement("TD");
	var createIprice = document.createElement("INPUT");
	createIprice.setAttribute("id","NewItemPrice");
	createIprice.setAttribute("name","NewItemPrice");
	createIprice.setAttribute("size","3");
	objNewTd6.appendChild(createIprice);
	objNewTR.appendChild(objNewTd6);
	
	var objNewTd7 = document.createElement("TD");
	var createIremark = document.createElement("INPUT");
	createIremark.setAttribute("id","NewItemRemark");
	createIremark.setAttribute("name","NewItemRemark");
	createIremark.setAttribute("size","5");
	objNewTd7.appendChild(createIremark);
	objNewTR.appendChild(objNewTd7);
	
	objswapNewItemTable.getElementsByTagName("TBODY")[0].appendChild(objNewTR);

	if(rowCount==0){ 
		 document.myform.NewItemCode.value = document.myform.targetItemCode.value;
		 document.myform.NewItemName.value = document.myform.targetName.value;
		 document.myform.NewItemRate.value = document.myform.targetRate.value;
		 document.myform.NewItemMrp.value = document.myform.targetMrp.value;
		 document.myform.NewItemQty.value = document.myform.targetQty.value;
		 document.myform.NewItemPrice.value = document.myform.targetPrice.value;
		 document.myform.NewItemRemark.value = document.myform.targetRemark.value;
		
		 document.myform.NewItemCode.className="hideTextField";
		 document.myform.NewItemName.className="hideTextField";
		 document.myform.NewItemMrp.className="hideTextField";
		 document.myform.NewItemRate.className="hideTextField";
		 document.myform.NewItemQty.className="hideTextField";
		 document.myform.NewItemPrice.className="hideTextField";
		 document.myform.NewItemRemark.className="hideTextField";
				 
	}else{
		 document.myform.NewItemCode[rowCount].value = document.myform.targetItemCode.value;
		 document.myform.NewItemName[rowCount].value = document.myform.targetName.value;
		 document.myform.NewItemRate[rowCount].value = document.myform.targetRate.value;
		 document.myform.NewItemMrp[rowCount].value = document.myform.targetMrp.value;
		 document.myform.NewItemQty[rowCount].value = document.myform.targetQty.value;
		 document.myform.NewItemPrice[rowCount].value = document.myform.targetPrice.value;
		 document.myform.NewItemRemark[rowCount].value = document.myform.targetRemark.value;
		 
		 document.myform.NewItemCode[rowCount].className="hideTextField";
		 document.myform.NewItemName[rowCount].className="hideTextField";
		 document.myform.NewItemMrp[rowCount].className="hideTextField";
		 document.myform.NewItemRate[rowCount].className="hideTextField";
		 document.myform.NewItemQty[rowCount].className="hideTextField";
		 document.myform.NewItemPrice[rowCount].className="hideTextField";
		 document.myform.NewItemRemark[rowCount].className="hideTextField";
		
	}
//--------------------Code For Old Item Teable Swap Element ------------------------------------------------------------------	

	var objswapOldItemTable=eval('document.getElementById("swapOldItemTable")');
	var objswapOldItemRows = objswapOldItemTable.getElementsByTagName("TBODY")[0].rows;
	
	var oldRowCount = objswapOldItemRows.length;
	var objOldTR= document.createElement("TR");
	var objOldTd1 = document.createElement("TD");
	var createOldIcode = document.createElement("INPUT");
	createOldIcode.setAttribute("id","oldItemCode");
	createOldIcode.setAttribute("name","oldItemCode");
	createOldIcode.setAttribute("size","3");
	objOldTd1.appendChild(createOldIcode);
	objOldTR.appendChild(objOldTd1);
	
	var objOldTd2 = document.createElement("TD");
	var createOldIname = document.createElement("INPUT");
	createOldIname.setAttribute("id","oldItemName");
	createOldIname.setAttribute("name","oldItemName");
	createOldIname.setAttribute("size","4");
	objOldTd2.appendChild(createOldIname);
	objOldTR.appendChild(objOldTd2);
	
	
	var objOldTd3 = document.createElement("TD");
	var createOldIrate = document.createElement("INPUT");
	createOldIrate.setAttribute("id","oldItemRate");
	createOldIrate.setAttribute("name","oldItemRate");
	createOldIrate.setAttribute("size","3");
	objOldTd3.appendChild(createOldIrate);
	objOldTR.appendChild(objOldTd3);
	
	
	var objOldTd4 = document.createElement("TD");
	var createOldImrp = document.createElement("INPUT");
	createOldImrp.setAttribute("id","oldItemMrp");
	createOldImrp.setAttribute("name","oldItemMrp");
	createOldImrp.setAttribute("size","3");
	objOldTd4.appendChild(createOldImrp);
	objOldTR.appendChild(objOldTd4);
	
	
	var objOldTd5 = document.createElement("TD");
	var createOldIqty = document.createElement("INPUT");
	createOldIqty.setAttribute("id","oldItemQty");
	createOldIqty.setAttribute("name","oldItemQty");
	createOldIqty.setAttribute("size","3");
	objOldTd5.appendChild(createOldIqty);
	objOldTR.appendChild(objOldTd5);
	
	
	var objOldTd6 = document.createElement("TD");
	var createOldIprice = document.createElement("INPUT");
	createOldIprice.setAttribute("id","oldItemPrice");
	createOldIprice.setAttribute("name","oldItemPrice");
	createOldIprice.setAttribute("size","3");
	objOldTd6.appendChild(createOldIprice);
	objOldTR.appendChild(objOldTd6);
	
	
	var objOldTd7 = document.createElement("TD");
	var createOldIremark = document.createElement("INPUT");
	createOldIremark.setAttribute("id","oldItemRemark");
	createOldIremark.setAttribute("name","oldItemRemark");
	createOldIremark.setAttribute("size","5");
	objOldTd7.appendChild(createOldIremark);
	objOldTR.appendChild(objOldTd7);
	
	objswapOldItemTable.getElementsByTagName("TBODY")[0].appendChild(objOldTR);

	if(oldRowCount==0){         
		 document.myform.oldItemCode.value = document.myform.selSourceItem.value;
		 document.myform.oldItemName.value = document.myform.selSourceItem.options[document.myform.selSourceItem.selectedIndex].text;
		 document.myform.oldItemRate.value = document.myform.sourceRate.value;
		 document.myform.oldItemMrp.value = document.myform.sourceMrp.value;
		 document.myform.oldItemQty.value = document.myform.sourceQty.value;
		 document.myform.oldItemPrice.value = document.myform.sourcePrice.value;
		 document.myform.oldItemRemark.value = document.myform.sourceRemark.value;
		 
		 document.myform.oldItemCode.className="hideTextField";
		 document.myform.oldItemCode.className="hideTextField";
		 document.myform.oldItemName.className="hideTextField";
		 document.myform.oldItemMrp.className="hideTextField";
		 document.myform.oldItemRate.className="hideTextField";
		 document.myform.oldItemQty.className="hideTextField";
		 document.myform.oldItemPrice.className="hideTextField";
		 document.myform.oldItemRemark.className="hideTextField";
 
				 
	}else{
		 document.myform.oldItemCode[oldRowCount].value = document.myform.selSourceItem.value;
		 document.myform.oldItemName[oldRowCount].value = document.myform.selSourceItem.options[document.myform.selSourceItem.selectedIndex].text;
		 document.myform.oldItemRate[oldRowCount].value = document.myform.sourceRate.value;
		 document.myform.oldItemMrp[oldRowCount].value = document.myform.sourceMrp.value;
		 document.myform.oldItemQty[oldRowCount].value = document.myform.sourceQty.value;
		 document.myform.oldItemPrice[oldRowCount].value = document.myform.sourcePrice.value;
		 document.myform.oldItemRemark[oldRowCount].value = document.myform.sourceRemark.value;
		 
		 document.myform.oldItemCode[oldRowCount].className="hideTextField";
		 document.myform.oldItemName[oldRowCount].className="hideTextField";
		 document.myform.oldItemMrp[oldRowCount].className="hideTextField";
		 document.myform.oldItemRate[oldRowCount].className="hideTextField";
		 document.myform.oldItemQty[oldRowCount].className="hideTextField";
		 document.myform.oldItemPrice[oldRowCount].className="hideTextField";
		 document.myform.oldItemRemark[oldRowCount].className="hideTextField";
		
	}
//--------------------------This Code is for delete from itemTable and insert into removedItemTable.
	var barcode = document.myform.sourceBarcode.value;
	var barcodeObj = document.getElementById(barcode);
		
	var objRemoveItemInfoTable=eval('document.getElementById("removeItemInfoTable")');
	var objMatchedItemTable=eval('document.getElementById("matchedItemTable")');
	var objRemoveItemInfoRows = objRemoveItemInfoTable.getElementsByTagName("TBODY")[0].rows;
	var objMatchedItemRows = objMatchedItemTable.getElementsByTagName("TBODY")[0].rows;
	var removeItemTblColumnCnt = objRemoveItemInfoTable.getElementsByTagName("THEAD")[0].getElementsByTagName("TR")[1].getElementsByTagName("TH").length;

		var rowObj = barcodeObj.parentNode.parentNode;
		var rowNumber = rowObj.rowIndex-1;
		if(document.myform.iName[rowNumber]!=undefined){			
			document.myform.rBarcode.value = barcode;
			document.myform.rItemName.value = document.myform.iName[rowNumber].value;
			document.myform.rWeight.value = document.myform.iWeight[rowNumber].value;
			document.myform.rOrderedQty.value = document.myform.iOrderQty[rowNumber].value;
			document.myform.rAccQty.value = document.myform.iAccountedQty[rowNumber].value;
			
			//document.getElementById('displayMsgTR').style.visibility = "visible";	
			document.getElementById('removedItemTableDiv').style.display = "inline";
			document.getElementById('matchedItemTableDiv').style.display = "none";	
			//document.getElementById('displayMsgTR').style.display = "inline";
			//document.getElementById('displayMessageDiv').innerHTML = document.getElementById('removedItemTableDiv').innerHTML;
			//document.getElementById('displayMessageDiv').style.background = "#BEF781";
		
			var objTR= document.createElement("TR");
			for(var j=0;j<removeItemTblColumnCnt-1;j++){
				var objTd = document.createElement("TD");
				objTd.style.background = "#e5d9e5";
					objTd.innerText=trim(objrows[rowNumber].cells[j].getElementsByTagName("INPUT")[0].value);
					objTR.appendChild(objTd);
			}
			objRemoveItemInfoTable.getElementsByTagName("TBODY")[0].appendChild(objTR);
			objrows[rowNumber].parentNode.removeChild(objrows[rowNumber]);
			
		}else{
			document.myform.rBarcode.value = barcode;
			document.myform.rItemName.value = document.myform.iName.value;
			document.myform.rWeight.value = document.myform.iWeight.value;
			document.myform.rOrderedQty.value = document.myform.iOrderQty.value;
			document.myform.rAccQty.value = document.myform.iAccountedQty.value;
			
			//document.getElementById('displayMsgTR').style.visibility = "visible";	
			document.getElementById('removedItemTableDiv').style.display = "inline";
			document.getElementById('matchedItemTableDiv').style.display = "none";	
			//document.getElementById('displayMsgTR').style.display = "inline";
			//document.getElementById('displayMessageDiv').innerHTML = document.getElementById('removedItemTableDiv').innerHTML;
			//document.getElementById('displayMessageDiv').style.background = "#BEF781";
		
			var objTR= document.createElement("TR");
			for(var j=0;j<removeItemTblColumnCnt-1;j++){
				var objTd = document.createElement("TD");
				objTd.style.background = "#e5d9e5";
					objTd.innerText=trim(objrows[0].cells[j].getElementsByTagName("INPUT")[0].value);
					objTd.style.background = "#e5d9e5";
					objTR.appendChild(objTd);
			}
			objRemoveItemInfoTable.getElementsByTagName("TBODY")[0].appendChild(objTR);
			objrows[0].parentNode.removeChild(objrows[0]);
		}
		
		funUpdateItemNameSelectBox();
			
			var objrows = objTable.getElementsByTagName("TBODY")[0].rows;
			var objrowsLength = objTable.getElementsByTagName("TBODY")[0].rows.length;
			if(objrowsLength ==0){
				SaveOrder();
			}else{
				document.myform.itemBarcode.value="";
				document.myform.itemBarcode.focus();
				
			}
			funCloseDiv(objrowsLength);
}
//---------------------------------------------------------------------------------------------
function setTotalPrice(s){
	var rate = document.myform.targetRate.value;
	var qty = document.myform.targetQty.value;
	var total = parseInt(rate)* parseInt(qty);
	document.myform.targetPrice.value=total;
}

function responseDivSetup(modal,modal1){
	modal.style.visibility="visible"
	modal.style.position="absolute";
	modal.style.backgroundColor="#c0c0fe";
	modal.style.top="0px"
	modal.style.left="0px"
	modal.style.width=document.body.scrollWidth+"px"
	modal.style.height=Math.max(Math.max(document.body.scrollHeight, document.documentElement.scrollHeight),Math.max(document.body.offsetHeight, document.documentElement.offsetHeight),Math.max(document.body.clientHeight, document.documentElement.clientHeight))+"px"	
	modal.style.zIndex="5"
	if(navigator.appName=="Netscape")
		modal.style.opacity = 40/100;
	else
		modal.style.filter="alpha(opacity=40)";
	modal.style.overflow="auto";
	
	modal1.style.position="absolute";
	modal1.style.zIndex="6"
	modal1.style.overflow="auto";
	var screenWidth=parseInt(modal.style.width.replace("px",""))
	var divWidth=modal1.scrollWidth
	var divLeft;
	if(screenWidth>divWidth)
		divLeft=(screenWidth-divWidth)/2
	else
		divLeft=(divWidth-screenWidth)/2
	modal1.style.left=divLeft+"px";
	
	var screenHeight=parseInt(modal.style.height.replace("px",""))
	var divHeight=modal1.scrollHeight
	var divTop=(screenHeight-divHeight)/2
	modal1.style.top=divTop+"px";	
	modal1.style.border="1px solid black";
	modal1.style.visibility="visible";
	
}
function funCloseDiv(objrowsLength){
	//document.getElementById('displayMessageDiv').innerHTML = "";	
	deletePopUp(document.getElementById('baseDiv'),document.getElementById('swapItemDiv'));
	if(objrowsLength!=0){
	document.myform.itemBarcode.value="";
	document.myform.itemBarcode.focus();
	}
}
function deletePopUp(modal,modal1){
	modal.style.position="absolute";
	modal.style.backgroundColor="#ffffff";
	modal.style.top="0px"
	modal.style.left="0px"
	modal.style.width="0px"
	modal.style.height="0px"
	modal.style.zIndex="0"
	if(navigator.appName=="Netscape")
		modal.style.opacity = 0/100;
	else
		modal.style.filter="alpha(opacity=0)";
	modal.style.overflow="auto";
	modal.innnerHTML="";
	modal.style.visibility="hidden"
	
	modal1.style.border="0px";
	modal1.style.position="absolute";
	modal1.style.overflow="auto";
	modal1.style.visibility="hidden"
	modal1.style.zIndex="0"
}

function displayPopup(){
	document.getElementById('searchItemNameDiv').style.display = "inline";
	responseDivSetup(document.getElementById('baseDiv'),document.getElementById('searchItemNameDiv'));
}

function searchString(){
	//alert("in");
	var serachItemName= document.myform.serachItemName.value;
	if(serachItemName == ""){
		alert("Item Name Cannot be Blank ");		
		document.myform.serachItemName.focus();
		return false;
	}else if(serachItemName.length <3){
		alert("Please enter atleast 3 charachters.");		
		document.myform.serachItemName.focus();
		return false;
	}
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="checkedOrderAjaxResponse.jsp?ajaxCallOption=getItemNames&serachItemName="+serachItemName;			
	xmlHttp.onreadystatechange=stateSearchString;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);	
}

function stateSearchString(){	
	if (xmlHttp.readyState==4){ 	
		document.getElementById("ResponseDiv").innerHTML=xmlHttp.responseText;	
	}

}

function funSelItem(){
	var barcodeValue = document.myform.hsBarcode[0].value;
	deletePopUp(document.getElementById('baseDiv'),document.getElementById('searchItemNameDiv'));
	funShowPopup(barcodeValue);
}

function funCloseSwapDiv(){
	document.getElementById('swapItemDiv').style.display = "none";
	deletePopUp(document.getElementById('baseDiv'),document.getElementById('swapItemDiv'));
	document.myform.itemBarcode.value="";
	document.myform.itemBarcode.focus();
}

function funCloseItemDiv(){
	document.getElementById('searchItemNameDiv').style.display = "none";
	deletePopUp(document.getElementById('baseDiv'),document.getElementById('searchItemNameDiv'));
	document.myform.itemBarcode.value="";
	document.myform.itemBarcode.focus();
}

function searchString(){
	var serachItemName= document.myform.serachItemName.value;
	if(serachItemName == ""){
		alert("Item Name Cannot be Blank ");		
		document.myform.serachItemName.focus();
		return false;
	}else if(serachItemName.length <3){
		alert("Please enter atleast 3 charachters.");		
		document.myform.serachItemName.focus();
		return false;
	}
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="checkedOrderAjaxResponse.jsp?ajaxCallOption=getItemNames&serachItemName="+serachItemName;			
	xmlHttp.onreadystatechange=stateSearchString;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);	
}

function stateSearchString(){	
	if (xmlHttp.readyState==4){ 	
		document.getElementById("ResponseDiv").innerHTML=xmlHttp.responseText;	
	}

}


var gurl="";
//-------------------------------------------------------------------------------------------------------
//
function SaveOrder(){

//	var orderNo = document.myform.hOrderNo.value;
	var objTable=eval('document.getElementById("itemTable")');
	var objrows = objTable.getElementsByTagName("TBODY")[0].rows;	
	var objrowslength = objTable.getElementsByTagName("TBODY")[0].rows.length;	
	//alert(objrowslength);
	
	if(objrowslength != 0){
		alert("Please Check All Items.");
		return false;
	}
	var orderNo= document.myform.hOrderNo.value;

	var ans = confirm("Order No. "+orderNo+" has been checked do you want to change the status to CHECKED?");
	if(ans){
		var objswapItemTable=eval('document.getElementById("swapOldItemTable")');
		var objswapTablerows = objswapItemTable.getElementsByTagName("TBODY")[0].rows;
		var columnOldCount = objTable.getElementsByTagName("THEAD")[0].getElementsByTagName("TR")[0].getElementsByTagName("TH").length;
		var oldItemValues="";
		//alert("Table :"+objswapTablerows.length);
		//alert(columnOldCount);
		var c=0;
		for(var i=0;i<objswapTablerows.length;i++){
			if(document.myform.oldItemCode[i]==undefined){
				if(c == 0){
					oldItemValues= document.myform.oldItemCode.value;
					c++;
				}else{
					oldItemValues=oldItemValues+document.myform.oldItemCode.value;
				}			 
				 oldItemValues=oldItemValues+"@@"+document.myform.oldItemName.value;
				 oldItemValues=oldItemValues+"@@"+document.myform.oldItemRate.value;
				 oldItemValues=oldItemValues+"@@"+document.myform.oldItemMrp.value;
				 oldItemValues=oldItemValues+"@@"+document.myform.oldItemQty.value; 
				 oldItemValues=oldItemValues+"@@"+document.myform.oldItemPrice.value; 
				 oldItemValues=oldItemValues+"@@"+document.myform.oldItemRemark.value; 
			}else{
				if(c == 0){
					oldItemValues= document.myform.oldItemCode[i].value;
					c++;
				}else{
					oldItemValues=oldItemValues+document.myform.oldItemCode[i].value;
				}
				 oldItemValues=oldItemValues+"@@"+document.myform.oldItemCode[i].value;
				 oldItemValues=oldItemValues+"@@"+document.myform.oldItemName[i].value;
				 oldItemValues=oldItemValues+"@@"+document.myform.oldItemRate[i].value;
				 oldItemValues=oldItemValues+"@@"+document.myform.oldItemMrp[i].value;
				 oldItemValues=oldItemValues+"@@"+document.myform.oldItemQty[i].value; 
				 oldItemValues=oldItemValues+"@@"+document.myform.oldItemPrice[i].value; 
				 oldItemValues=oldItemValues+"@@"+document.myform.oldItemRemark[i].value; 
			}
			oldItemValues = oldItemValues + "##";
					
		}
		
		var objswapNewItemTable=eval('document.getElementById("swapNewItemTable")');
		var objswapNewTablerows = objswapNewItemTable.getElementsByTagName("TBODY")[0].rows;
		var columnNewCount = objTable.getElementsByTagName("THEAD")[0].getElementsByTagName("TR")[0].getElementsByTagName("TH").length;
		var newItemValues="";
		var c=0;
		for(var i=0;i<objswapNewTablerows.length;i++){
			
			if(document.myform.oldItemCode[i]==undefined){
				if(c == 0){
					 newItemValues=document.myform.NewItemCode.value;
					c++;
				}else{
					 newItemValues=newItemValues+document.myform.NewItemCode.value;
				}			 
				 newItemValues=newItemValues+"@@"+document.myform.NewItemName.value;
				 newItemValues=newItemValues+"@@"+document.myform.NewItemRate.value;
				 newItemValues=newItemValues+"@@"+document.myform.NewItemMrp.value;
				 newItemValues=newItemValues+"@@"+document.myform.NewItemQty.value; 
				 newItemValues=newItemValues+"@@"+document.myform.NewItemPrice.value; 
				 newItemValues=newItemValues+"@@"+document.myform.NewItemRemark.value; 
			}else{
				if(c == 0){
					 newItemValues=document.myform.NewItemCode[i].value;
					c++;
				}else{
					 newItemValues=newItemValues+document.myform.NewItemCode[i].value;
				}			 
				 newItemValues=newItemValues+"@@"+document.myform.NewItemName[i].value;
				 newItemValues=newItemValues+"@@"+document.myform.NewItemRate[i].value;
				 newItemValues=newItemValues+"@@"+document.myform.NewItemMrp[i].value;
				 newItemValues=newItemValues+"@@"+document.myform.NewItemQty[i].value; 
				 newItemValues=newItemValues+"@@"+document.myform.NewItemPrice[i].value; 
				 newItemValues=newItemValues+"@@"+document.myform.NewItemRemark[i].value; 
			}
			newItemValues= newItemValues+"##";
		}
		
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null)
			{
				alert ("Your browser does not support AJAX!");
				return;
			} 
		gurl="saveCheckedOrderData.jsp?orderNo="+orderNo+"&oldItems="+oldItemValues+"&newItems="+newItemValues;	
		funshow();
	}
	
}
function funshow(){
	
	document.getElementById('bagDisplayDiv').style.display="inline";
	document.myform.bagname.value="";
	document.myform.bagname.focus();
	responseDivSetup(document.getElementById('baseDiv'),document.getElementById('bagDisplayDiv'));
	
	
}
function funsave(){
	
	var bagNo=document.myform.bagname.value;
	document.myform.bagname.focus();
	if(bagNo==""){
		alert("Bag number should not be blank");
		document.myform.bagname.focus();
		return false;
	}else if(bagNo<=0){
		alert("please enter bag number greater than 0");
		document.myform.bagname.focus();
		return false;
	 }
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null)
		{
			alert ("Your browser does not support AJAX!");
			return;
		} 
	
	var url=gurl+"&bagNo="+bagNo;
	xmlHttp.onreadystatechange=stateSaveData;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);	
}

function stateSaveData(){
	if (xmlHttp.readyState==4){ 
		gurl=null;
		
		var ans = trim(xmlHttp.responseText);
		//alert(ans);
		if(ans == "Success"){
			alert("Information has been saved successfuly");
			document.myform.action = "OrderCheckedMenuForm.jsp";
			document.myform.submit();
		}else if(ans == "Swap"){	
			alert("Item swaped Successfuly."+"\n"+"Information has been saved successfuly");
			document.myform.action="print_order1.jsp?backPage=OrderCheckedMenuForm.jsp&orderNo="+document.myform.hOrderNo.value;
			document.myform.submit();
		}else{
			alert("Error");
			document.myform.action = "OrderCheckedMenuForm.jsp";
			document.myform.submit();
		}
		
	}
}


function cancelOrder(){
	
	document.myform.action = "OrderProcessingCheckedForm.jsp";
	document.myform.submit();
	
}
function ShowOrder(){
	document.getElementById("removeItemInfoTableDiv").style.display="inline";
	document.getElementById("SwapItemDetailsDiv").style.display="inline";
	document.myform.ShowOrderDetails.style.display = "none";
	document.myform.HideOrderDetails.style.display="inline";
	
}
function HideOrder(){
	document.getElementById("removeItemInfoTableDiv").style.display = "none";
	document.getElementById("SwapItemDetailsDiv").style.display = "none";
	document.myform.ShowOrderDetails.style.display = "inline";
	document.myform.HideOrderDetails.style.display = "none";	
	
}

// show item names
function showItemNames(){
	
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null)
		{
			alert ("Your browser does not support AJAX!");
			return;
		} 
	var url="checkedOrderAjaxResponse.jsp?ajaxCallOption=showItemNames";	
	xmlHttp.onreadystatechange=showItems;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);	
}
function showItems(){
	if (xmlHttp.readyState==4){ 
		document.getElementById("selItemComboDiv").innerHTML = xmlHttp.responseText;
	}
}	


