var popup_state = 0;
window.onload = dispItemDetail('A','A');
function firstChar(first){
	document.getElementById("item_name_id").value="";
	document.getElementById("first").innerHTML = first;
	dispItemDetail(document.getElementById("first").innerHTML,document.getElementById("second").innerHTML);
}
function secondChar(second){
	document.getElementById("item_name_id").value="";
	document.getElementById("second").innerHTML = second;
	dispItemDetail(document.getElementById("first").innerHTML,document.getElementById("second").innerHTML);
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

function disp(){
	var temp = document.getElementById("item_name_id").value;
	if(temp.length < 2){
		alert("Enter Atleast Tow Charactor to search..")
		document.getElementById("item_name_id").focus();
		return;
	}
	dispItemDetail(temp,'');
	document.getElementById("first").innerHTML = temp;
	document.getElementById("second").innerHTML = '';
}

function dispItemDetail(first,second){
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var url="ItemDetailWithPV.jsp";
  	url = url + "?first="+first;
  	url = url + "&second="+second;
  	xmlHttp.onreadystatechange=dispItems;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function dispItems(){
	if(xmlHttp.readyState==4){
		document.getElementById("item_detail").innerHTML = xmlHttp.responseText;
	}
}

function checkField(current,discard){
	if(document.getElementById(current).checked){
		alert("Can not Discard Current Price Version..");
		document.getElementById(discard).checked=false;
	}	
}
function checkField1(current,discard){
	if(document.getElementById(current).checked){
		document.getElementById(discard).checked=false;
	}	
}
function dispPopup(id){
	document.getElementById(id).style.display='block';
}
function hidePopup(id){
	document.getElementById(id).style.display='none';
}