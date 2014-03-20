var xmlHttp;

function GetXmlHttpObject()
{
	var xmlHttp1=null;
	try
  	{
  		// Firefox, Opera 8.0+, Safari
  		xmlHttp1=new XMLHttpRequest();
  	}
	catch (e)
  	{
  	// Internet Explorer
  		try
    	{
    		xmlHttp1=new ActiveXObject("Msxml2.XMLHTTP");
    	}
  		catch (e)
    	{
    	xmlHttp1=new ActiveXObject("Microsoft.XMLHTTP");
    	}
  	}
	return xmlHttp1;
}
window.onload=loadAreaList();


function loadAreaList(){
	xmlHttp=GetXmlHttpObject();
	var url="ShowMessageDetails.jsp?callfor=arealist";
	xmlHttp.onreadystatechange=loadArea;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function loadArea(){
	if(xmlHttp.readyState == 4){
	     document.getElementById("selectboxid").innerHTML=xmlHttp.responseText;
	}
}

function showCustDetails(){
xmlHttp=GetXmlHttpObject();
	var url="ShowMessageDetails.jsp?callfor=customerlist";
	xmlHttp.onreadystatechange=loadCust;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}
function loadCust(){
	if(xmlHttp.readyState == 4){
	     document.getElementById("showCustDetails").innerHTML=xmlHttp.responseText;
	}
}


function limitChars(textarea, limit, infodiv)
{
 var text = textarea.value; 
 var textlength = text.length;
 var info = document.getElementById(infodiv);
 //alert(info);
   
 if(textlength > limit)
  {
  info.innerHTML="You cannot write more then \""+limit+"\" characters!";
  textarea.value = text.substring(0,limit);
  return false;
  }
  else
  {
  info.innerHTML = "You have \""+ (limit - textlength) +"\" characters left!";
  return true;
  }
 
 
}

