var xmlHttp

function showHint() {
	var str;
	var str1;
	var str2;
	var str3;
	var str4;
	var str5;
	var str6;
	var str7;
	var flag;	
	var strBarcode;
	str=document.myform.i_code.value;
	str1=document.myform.ig_code.value;
	str2=document.myform.i_name.value;
	strBarcode=document.myform.i_barcode.value;
	str3=document.myform.i_mrp1.value;
	str5=document.myform.i_mrp2.value;
	str4=document.myform.i_rate1.value;
	str6=document.myform.i_rate2.value;
	str7=document.myform.i_tickflg.value;
	flag=document.myform.flagHidden.value;
	document.getElementById("waitMessage").innerHTML="Please wait...";
	if (str.length==0 && str1.length==0 && str2.length==0 && str3.length==0 && str4.length==0 && str5.length==0 && str6.length==0 && str7.length==0 && strBarcode.length==0)
  	{ 
  		document.getElementById("txtHint").innerHTML="";
  		return;
  	}
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="editItemDetails.jsp";
	url=url+"?icodeStartWith="+str+"&igcodeStartWith="+str1+"&inameStartWith="+str2+"&imrpStartWith="+str3+"&irateStartWith="+str4+"&imrp2StartWith="+str5+"&irate2StartWith="+str6+"&i_tickflg="+str7
		+"&ibarcode="+strBarcode
		+"&t="+new Date().getTime()+"&flag="+flag;
	url=url+"&sid="+Math.random();
//	url=url+"&is_bachka="
	xmlHttp.onreadystatechange=stateChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
} 

function stateChanged() 
{
	if (xmlHttp.readyState==4)
	{ 
		document.getElementById("waitMessage").innerHTML="";
		document.getElementById("txtHint").innerHTML=xmlHttp.responseText;
	
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


function getList(){
	var itemCode = document.myform.hItemCode.value;
	var siteId = document.myform.siteId.value;
	
	
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	document.getElementById("waitMessage").innerHTML="Please Wait";
	document.getElementById("listDiv").innerHTML = "";
  	var url="ChangeQuantityAjaxResponse.jsp?itemCode="+itemCode+"&siteId="+siteId+"&type=list";
	
	xmlHttp.onreadystatechange=stateChangedGetList;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function stateChangedGetList() 
{
	if (xmlHttp.readyState==4)
	{ 
		document.getElementById("waitMessage").innerHTML="";
		document.getElementById("listDiv").innerHTML=xmlHttp.responseText;
	}
}

function setValues(siteName,priceVersion,qty,newSiteId){
	
	//alert(siteName+" : "+priceVersion+" : "+qty+":"+newSiteId);
	
	document.myform.siteName.value = siteName;
	document.myform.priceVersion.value = priceVersion;
	document.myform.oldQty.value = qty;
	document.myform.newQuantity.value = 0;
	document.myform.newSiteId.value = newSiteId;
}

function funSaveQuantity(){
	var itemCode = document.myform.hItemCode.value;
	var priceVersion = document.myform.priceVersion.value;
	var oldQty = document.myform.oldQty.value;
	var newQuantity = document.myform.newQuantity.value;
	var newSiteId = document.myform.newSiteId.value;
	
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	document.getElementById("waitMessage").innerHTML="Please Wait";
	document.getElementById("listDiv").innerHTML = "";
  	var url="ChangeQuantityAjaxResponse.jsp?" +
  			"itemCode="+itemCode+
  			"&priceVersion="+priceVersion+
  			"&oldQty="+oldQty+
  			"&newQuantity="+newQuantity+
  			"&newSiteId="+newSiteId+  			
  			"&type=save";
	
	xmlHttp.onreadystatechange=stateChangedSave;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
	
}

function stateChangedSave() 
{
	if (xmlHttp.readyState==4)
	{ 
		alert(xmlHttp.responseText.replace(/^\s+|\s+$/g,""));
		getList();
	}
}