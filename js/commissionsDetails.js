var xmlHttp;

function showHint() {		
	var str;	
	str=document.myform.d_staff.value;
	var str1;	
	str1=document.myform.c_date1.value;
	
	var str2;	
	str2=document.myform.c_date2.value;
	
	var str3;	
	str3=document.myform.hchckall.value;
	
	
	document.getElementById("waitMessage").innerHTML="Please wait...";
	if (str.length==0 && str1.length==0 && str2.length==0 && str3.length==0)
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
	var url="CommissionsDetails.jsp";
	url=url+"?nameStartWith="+str+"&date1StartWith="+str1+"&date2StartWith="+str2+"&hchckallStartWith="+str3+"";
	url=url+"&sid="+Math.random();
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
		  document.myform.c_date1.value = "";   
	      document.myform.c_date2.value = ""; 
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
