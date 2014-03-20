var xmlHttp;

function funCancel(){
	document.myform.action = "HomeForm.jsp";
	document.myform.submit();
}

function funSubmit(){
	var siteName = document.myform.siteName.value;
	var siteAddress = document.myform.siteAddress.value;
	var sitePhone = document.myform.sitePhone.value;
	if (siteName == "")
  	{ 
  		alert("Please enter site name.")
  		return;
  	}
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="NewSite.jsp";
	url=url+"?siteName="+siteName+"&siteAddress="+siteAddress+"&sitePhone="+sitePhone;
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
		window.location = "HomeForm.jsp";
	}
}

function funSearch(){
	
	var siteName = document.myform.siteName.value;	
	var sitePhone = document.myform.sitePhone.value;
	document.getElementById('displayDataDiv').innerHTML = "<img src=\"images/cir.gif\"";
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="SearchSiteList.jsp";
	url=url+"?siteName="+siteName+"&sitePhone="+sitePhone;
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

function funSetValues(siteId,siteName,address,sitePhone){
	var actionStr = "EditSiteForm.jsp?" +
			"siteId="+siteId+
			"&siteName="+siteName+
			"&siteAddress="+address+
			"&sitePhone="+sitePhone;
	document.myform.action = actionStr;
	document.myform.submit();
}
function funUpdate(){
	var siteId = document.myform.siteId.value;
	var siteName = document.myform.siteName.value;
	var siteAddress = document.myform.siteAddress.value;
	var sitePhone = document.myform.sitePhone.value;
	if (siteName == "")
  	{ 
  		alert("Please enter site name.")
  		return;
  	}
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="EditSite.jsp";
	url=url+"?siteId="+siteId+"&siteName="+siteName+"&siteAddress="+siteAddress+"&sitePhone="+sitePhone;
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
		window.location = "HomeForm.jsp";
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

