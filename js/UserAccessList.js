var xmlHttp;
var FormArray="";
var ValueArray=new Array();
var tempi=0,k=0, itemcnt, nexttempi;
function showHint() {
	var str;
	str=document.myform.EditUserName.value;
	//alert(str);
	if (str.length==0){
  		document.getElementById("txtHint").innerHTML="";
  		document.getElementById("submit_button").disabled=true;
  		return;
  	}
  	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="UserAccessList.jsp";
	url=url+"?nameStartWith="+str+"";
	url=url+"&sid="+Math.random();
	xmlHttp.onreadystatechange=stateChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
	
} 

function stateChanged() 
{
	if (xmlHttp.readyState==4)
	{
		document.getElementById("txtHint").innerHTML=xmlHttp.responseText;
		document.getElementById("submit_button").disabled=false;
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