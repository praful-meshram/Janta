var xmlHttp;

function showHint() {
	var str;
	str=document.myform.area.value;
	var str1;
	str1=document.myform.desc.value;
	var str2;
	str2=document.myform.hchckall.value;
	document.getElementById("waitMessage").innerHTML="Please wait for Some Time";	
	if (str.length==0 && str1.length==0 && str2.length==0)
  	{ 
	  	document.getElementById("txtHint").innerHTML="";		
  		return;
  	}
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="editAreaDetails.jsp";
	url=url+"?areaStartWith="+str+"&descStartWith="+str1+"&hchckallStartWith="+str2+"";
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
