var xmlHttp;
var xmlHttp1;
function showHint() {
	
	var str;	
	str=document.myform.hcustCode.value;

	
	document.getElementById("waitMessage").innerHTML="Please wait...";
	if (str.length==0)
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
  	
  	
	var url="customerOrderDetails.jsp";
	url=url+"?custCodeStartWith="+str+"";
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
	
	}
}
function showCustAtt() {

	if ( eval("document.myform.chckall.checked == false")){		
		document.getElementById("divcustatt").innerHTML="";
	 	document.getElementById("divcustatt").style.visibility="hidden";	
	 		document.myform.hchckall.value=0;	
	 		return false;
	 		
	}else{
		
	var str;	
	str=document.myform.hcustCode.value;
	//alert(str);
	
	xmlHttp1=GetXmlHttpObject()
	if (xmlHttp1==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	
  	
	var url="custAddAttribute.jsp";
	url=url+"?custCodeStartWith="+str+"";
	url=url+"&sid="+Math.random();
	xmlHttp1.onreadystatechange=stateChanged1;
	xmlHttp1.open("GET",url,true);
	xmlHttp1.send(null);
	}
} 

function stateChanged1() 
{
	if (xmlHttp1.readyState==4)
	{ 
	
	document.getElementById("divcustatt").innerHTML=xmlHttp1.responseText;
	 document.getElementById("divcustatt").style.visibility="visible";
	 eval("document.myform.chckall.checked=true");
	 	document.myform.hchckall.value=1;	
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

