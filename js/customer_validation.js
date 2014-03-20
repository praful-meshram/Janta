var xmlHttp
var globType="";

function showHint(type) {
	globType = type;
	var str;
	if(type == "ph")
		str=document.myform.phone.value;
	else if(type == "mo")
		str=document.myform.mobile.value;
	if (str.length==0)
  	{ 
  		return;
  	}
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="customer_validation.jsp";
	url=url+"?phStartWith="+str;
	url=url+"&type="+type;
	//alert(url);
	xmlHttp.onreadystatechange=stateChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
} 

function stateChanged() 
{
	if (xmlHttp.readyState==4)
	{ 
		 var ans = xmlHttp.responseText;
		 ans= ans.replace(/^\s+|\s+$/g,'');
		 if(ans!=""){
	     		if(globType == "mo"){
	     			document.myform.mobile.value="";
	     			document.myform.mobile.focus();
	     		}
	     		if(globType == "ph"){
	     			document.myform.phone.value="";
	     			document.myform.phone.focus();
	     		}
	     		alert(ans);	
	     		
	     }
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
