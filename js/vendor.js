var xmlHttp;

function funCancel(){
	document.myform.action = "HomeForm.jsp";
	document.myform.submit();
}

function funSubmit(){
	var vendorName = document.myform.vendorName.value;
	var vendorAddress = document.myform.vendorAddress.value;
	var vendorPhone = document.myform.vendorPhone.value;
	if (vendorName == "")
  	{ 
  		alert("Please enter vendor name.")
  		return;
  	}
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="NewVendor.jsp";
	url=url+"?vendorName="+vendorName+"&vendorAddress="+vendorAddress+"&vendorPhone="+vendorPhone;
	url=url+"&sid="+Math.random();
	xmlHttp.onreadystatechange=stateChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
} 

function stateChanged() 
{
	if (xmlHttp.readyState==4)
	{ 	
		alert(xmlHttp.responseText);
		//window.location = "HomeForm.jsp";
		window.location.reload();
	}
}

function funSearch(){
	document.getElementById('displayDataDiv').innerHTML  = "<img src=\"images/cir.gif\"/>";
	var vendorName = document.myform.vendorName.value;	
	var vendorPhone = document.myform.vendorPhone.value;
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="SearchVendorList.jsp";
	url=url+"?vendorName="+vendorName+"&vendorPhone="+vendorPhone;
	url=url+"&sid="+Math.random();
	xmlHttp.onreadystatechange=stateSearchChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
} 

function stateSearchChanged() 
{
	if (xmlHttp.readyState==4)
	{ 	
		document.getElementById('displayDataDiv').innerHTML = xmlHttp.responseText;
	}
}

function funSetValues(vendorId,vendorName,address,vendorPhone){
	var actionStr = "EditVendorForm.jsp?" +
			"vendorId="+vendorId+
			"&vendorName="+vendorName+
			"&vendorAddress="+address+
			"&vendorPhone="+vendorPhone;
	document.myform.action = actionStr;
	document.myform.submit();
}
function funUpdate(){
	var vendorId = document.myform.vendorId.value;
	var vendorName = document.myform.vendorName.value;
	var vendorAddress = document.myform.vendorAddress.value;
	var vendorPhone = document.myform.vendorPhone.value;
	if (vendorName == "")
  	{ 
  		alert("Please enter vendor name.")
  		return;
  	}
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="EditVendor.jsp";
	url=url+"?vendorId="+vendorId+"&vendorName="+vendorName+"&vendorAddress="+vendorAddress+"&vendorPhone="+vendorPhone;
	url=url+"&sid="+Math.random();
	xmlHttp.onreadystatechange=stateUpdateChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
} 

function stateUpdateChanged() 
{
	if (xmlHttp.readyState==4)
	{ 	
		alert(xmlHttp.responseText);
		if(xmlHttp.responseText.search("Vendor updated")!=-1)
			window.location.assign("HomeForm.jsp");
		else
			window.location.reload();
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

