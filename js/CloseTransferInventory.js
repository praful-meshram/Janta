var xmlHttp;

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
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="CloseInventoryAjaxResponse.jsp";
  	if(src == "getSite"){
  		url=url+"?ajaxCallOption=getSite";
  	}else if(src == "getSiteAddress"){
  		if(document.myform.siteId.value != 0){
  			url=url+"?ajaxCallOption=getSiteAddress&siteId="+document.myform.siteId.value;
  		} else {
  			return;
  		}
  	}else if(src == "getDes"){
  		url=url+"?ajaxCallOption=getDes";
  	}else if(src == "getDesAddress"){
  		if(document.myform.desId.value != 0){
  			url=url+"?ajaxCallOption=getDesAddress&siteId="+document.myform.desId.value;
  		} else {
  			return;
  		}
  	}else if(src=="getTransferNumber"){
  		url=url+"?ajaxCallOption=getTransferNumber&siteId="+document.myform.siteId.value
  		+"&desId="+document.myform.desId.value;
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
	  		checkSelectBoxOption();
	  	}else if(src == "getDes"){
			document.getElementById("desSiteDiv").innerHTML = xmlHttp.responseText;
			document.myform.siteId.focus();
		}else if(src == "getDesAddress"){
	  		document.getElementById("destinationAddress").innerHTML = xmlHttp.responseText;
	  		checkSelectBoxOption();
	  	}else if(src=="getTransferNumber"){
	  		document.getElementById("wait1").style.display="none";
	  		document.getElementById("transferNumDiv").innerHTML = xmlHttp.responseText;
	  	}
	}
}

function checkSelectBoxOption(){
	
	var siteId = document.myform.siteId.value;
	var desId=document.myform.desId.value;
	if(siteId == ""){
		alert("Please Select site name.");
		return false;
	}else if(desId == ""){
		//alert("Please Select destination name.");
		return false;
	}else if(siteId == desId ){
		alert("Please select different destination address");
		document.myform.transId.style.display = "none";
		return false;
	}
	document.getElementById("wait1").style.display="block";
	getData("getTransferNumber");
}

function funSearchTrnsList(){
	document.myform.searchTrnsNumber.value="";
	var trnsnumbr=document.myform.transId.value;
	document.myform.trnsnumbr.value = trnsnumbr;
	var siteId=document.myform.siteId.value;
	var desId=document.myform.desId.value;
	document.myform.ajaxCallOption.value = "popupTable";
	if(trnsnumbr == "" )
	{
		alert("Please enter transfer number.");
		return false;
	}
	
	
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="CloseInventoryAjaxResponse.jsp"
  			+"?ajaxCallOption=popupTable"
  			+"&searchTrnsNumber="+trnsnumbr
  			+"&siteId="+siteId
  			+"&desId="+desId;
  	
	url=url+"&sid="+Math.random();
	xmlHttp.onreadystatechange=stateChangedOptionString;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}


function stateChangedOptionString(){
	if(xmlHttp.readyState==4){
		document.getElementById("selectedItemsDiv").innerHTML = xmlHttp.responseText;
		xmlHttp = null;
	}
}

function funSearchItem(){
	document.myform.transId.value="";
	var trnsnumbr = document.myform.searchTrnsNumber.value;
	document.myform.trnsnumbr.value = trnsnumbr;
	var siteId=document.myform.siteId.value;
	var desId=document.myform.desId.value;
	document.myform.ajaxCallOption.value = "popupTable";
	if(siteId == ""){
		alert("Please Select site name.");
		return false;
	}else if(desId == ""){
		alert("Please select destination name.");
		return false;
	}
	if(trnsnumbr == "" ){
		alert("Please enter transfer number.");
		return false;
	}
	
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	document.getElementById("wait").style.display="block";
  	var url="CloseInventoryAjaxResponse.jsp"
  			+"?ajaxCallOption=popupTable"
  			+"&searchTrnsNumber="+trnsnumbr
  			+"&siteId="+siteId
  			+"&desId="+desId;
  		
	url=url+"&sid="+Math.random();
	xmlHttp.onreadystatechange=stateChangedSearchString;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}


function stateChangedSearchString(){
	if(xmlHttp.readyState==4){
		document.getElementById("wait").style.display="none";
		document.getElementById("selectedItemsDiv").innerHTML = xmlHttp.responseText;
		xmlHttp = null;
		
	}
}
 function enterremark(){
	var objTable=eval('document.getElementById("displayItemTable")'); 
	var objrows = objTable.getElementsByTagName("TBODY")[0].rows;
	var objrowsLength = objTable.getElementsByTagName("TBODY")[0].rows.length;
	var statusvalue = document.myform.IStatus.value;
	if(objrowsLength == 1){
	 	if(statusvalue == "CHNGQTY-RCVD MORE" || statusvalue == "CHNGQTY-RCVD LESS" ){
			document.myform.IRemark.readOnly = false;
			document.myform.IRemark.focus();
			return false;
		}else if(statusvalue == "NOT TRANSFER"){
			document.myform.IRemark.readOnly = false;
			document.myform.IRemark.focus();
			return false;
		}
	}else{
		for(var i=0;i<objrowsLength ;i++){
			var statusvalue=document.myform.IStatus[i].value;
			if(statusvalue == "CHNGQTY-RCVD MORE" || statusvalue == "CHNGQTY-RCVD LESS" ){
				document.myform.IRemark[i].readOnly = false;
				document.myform.IRemark[i].focus();
				return false;
			}else if(statusvalue == "NOT TRANSFER"){
				document.myform.IRemark[i].readOnly = false;
				document.myform.IRemark[i].focus();
				return false;
			}
		}
	}
	 
 }

function funSaveOrder(){
	
	var accept=document.myform.Iaccept_qty.value;
	var objTable=eval('document.getElementById("displayItemTable")'); 
	var objrows = objTable.getElementsByTagName("TBODY")[0].rows;
	var objrowsLength = objTable.getElementsByTagName("TBODY")[0].rows.length;
	
	if(objrowsLength == 1){
		
		var statusvalue = document.myform.IStatus.value;
		if(statusvalue == "CHNGQTY-RCVD MORE" || statusvalue == "CHNGQTY-RCVD LESS"){
			if(document.myform.IRemark.value == ""){
				alert("Please enter remark field cant left it blank");
				return false;
			}
		}else if(statusvalue == "NOT TRANSFER"){
			if(document.myform.IRemark.value == ""){
				alert("Please enter remark field ");
				return false;
			}
		}
		
	}else{
		
			for(var i=0;i<objrowsLength ;i++){
				var statusvalue = document.myform.IStatus[i].value;
					if(statusvalue == "CHNGQTY-RCVD MORE"){
						if(document.myform.IRemark[i].value == ""){
							alert("Please enter remark field cant left it blank");
							return false;
						}
					}else if(statusvalue == "NOT TRANSFER"){
							if(document.myform.IRemark[i].value == ""){
								alert("Please enter remark field ");
								return false;
							}
					}
			}
	}
	document.myform.action = "CloseTransferInventory.jsp";
	document.myform.submit();
}

function funCancelOrder(){
	document.myform.action = "HomeForm.jsp";
	document.myform.submit();
}